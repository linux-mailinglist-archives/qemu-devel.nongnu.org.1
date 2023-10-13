Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A787C81E5
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 11:23:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrEMq-0005r5-GD; Fri, 13 Oct 2023 05:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qrEMn-0005kR-7U; Fri, 13 Oct 2023 05:21:57 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qrEMl-00072m-HX; Fri, 13 Oct 2023 05:21:56 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 64D3748F3D;
 Fri, 13 Oct 2023 11:21:51 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
Subject: [PATCH v3 4/9] block/mirror: determine copy_to_target only once
Date: Fri, 13 Oct 2023 11:21:38 +0200
Message-Id: <20231013092143.365296-5-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013092143.365296-1-f.ebner@proxmox.com>
References: <20231013092143.365296-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

In preparation to allow changing the copy_mode via QMP. When running
in an iothread, it could be that copy_mode is changed from the main
thread in between reading copy_mode in bdrv_mirror_top_pwritev() and
reading copy_mode in bdrv_mirror_top_do_write(), so they might end up
disagreeing about whether copy_to_target is true or false. Avoid that
scenario by determining copy_to_target only once and passing it to
bdrv_mirror_top_do_write() as an argument.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

No changes in v3.

 block/mirror.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 0ed54754e2..8992c09172 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1463,21 +1463,21 @@ bdrv_mirror_top_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
     return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
 }
 
+static bool should_copy_to_target(MirrorBDSOpaque *s)
+{
+    return s->job && s->job->ret >= 0 &&
+        !job_is_cancelled(&s->job->common.job) &&
+        s->job->copy_mode == MIRROR_COPY_MODE_WRITE_BLOCKING;
+}
+
 static int coroutine_fn GRAPH_RDLOCK
 bdrv_mirror_top_do_write(BlockDriverState *bs, MirrorMethod method,
-                         uint64_t offset, uint64_t bytes, QEMUIOVector *qiov,
-                         int flags)
+                         bool copy_to_target, uint64_t offset, uint64_t bytes,
+                         QEMUIOVector *qiov, int flags)
 {
     MirrorOp *op = NULL;
     MirrorBDSOpaque *s = bs->opaque;
     int ret = 0;
-    bool copy_to_target = false;
-
-    if (s->job) {
-        copy_to_target = s->job->ret >= 0 &&
-                         !job_is_cancelled(&s->job->common.job) &&
-                         s->job->copy_mode == MIRROR_COPY_MODE_WRITE_BLOCKING;
-    }
 
     if (copy_to_target) {
         op = active_write_prepare(s->job, offset, bytes);
@@ -1523,17 +1523,10 @@ static int coroutine_fn GRAPH_RDLOCK
 bdrv_mirror_top_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
                         QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
-    MirrorBDSOpaque *s = bs->opaque;
     QEMUIOVector bounce_qiov;
     void *bounce_buf;
     int ret = 0;
-    bool copy_to_target = false;
-
-    if (s->job) {
-        copy_to_target = s->job->ret >= 0 &&
-                         !job_is_cancelled(&s->job->common.job) &&
-                         s->job->copy_mode == MIRROR_COPY_MODE_WRITE_BLOCKING;
-    }
+    bool copy_to_target = should_copy_to_target(bs->opaque);
 
     if (copy_to_target) {
         /* The guest might concurrently modify the data to write; but
@@ -1550,8 +1543,8 @@ bdrv_mirror_top_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
         flags &= ~BDRV_REQ_REGISTERED_BUF;
     }
 
-    ret = bdrv_mirror_top_do_write(bs, MIRROR_METHOD_COPY, offset, bytes, qiov,
-                                   flags);
+    ret = bdrv_mirror_top_do_write(bs, MIRROR_METHOD_COPY, copy_to_target,
+                                   offset, bytes, qiov, flags);
 
     if (copy_to_target) {
         qemu_iovec_destroy(&bounce_qiov);
@@ -1574,15 +1567,17 @@ static int coroutine_fn GRAPH_RDLOCK
 bdrv_mirror_top_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
                               int64_t bytes, BdrvRequestFlags flags)
 {
-    return bdrv_mirror_top_do_write(bs, MIRROR_METHOD_ZERO, offset, bytes, NULL,
-                                    flags);
+    bool copy_to_target = should_copy_to_target(bs->opaque);
+    return bdrv_mirror_top_do_write(bs, MIRROR_METHOD_ZERO, copy_to_target,
+                                    offset, bytes, NULL, flags);
 }
 
 static int coroutine_fn GRAPH_RDLOCK
 bdrv_mirror_top_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
 {
-    return bdrv_mirror_top_do_write(bs, MIRROR_METHOD_DISCARD, offset, bytes,
-                                    NULL, 0);
+    bool copy_to_target = should_copy_to_target(bs->opaque);
+    return bdrv_mirror_top_do_write(bs, MIRROR_METHOD_DISCARD, copy_to_target,
+                                    offset, bytes, NULL, 0);
 }
 
 static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs)
-- 
2.39.2



