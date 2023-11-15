Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 102167DD686
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 20:05:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtyR-0004Jc-7C; Tue, 31 Oct 2023 15:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxty8-0004C5-27
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxl-00068q-WE
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698778781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vYhvADMLU/Y/UBF/Lr1Z8Sj0udiiZxhJ5mUvN9t2Kf0=;
 b=Ks2UXLE7PErYQyi7FjoOv78HuxY9+io9M0CXc3q2+Sa66/nCtlq1eo+q281a71DjCvx9yg
 BJExbFapVD6y/56EyK0DVcWX/ALwhZ6KSW2mOuDEcRnW4vFCM7tgkgtap1Bw3mcvrKPR48
 CGIPWdXHP44REJWWVnn331dmifqZmDU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-froO-M2ZMT6SoI8EvKUMjw-1; Tue, 31 Oct 2023 14:59:38 -0400
X-MC-Unique: froO-M2ZMT6SoI8EvKUMjw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B92608678D2;
 Tue, 31 Oct 2023 18:59:37 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2952125C2;
 Tue, 31 Oct 2023 18:59:37 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 21/27] block/mirror: determine copy_to_target only once
Date: Tue, 31 Oct 2023 19:59:12 +0100
Message-ID: <20231031185918.346940-22-kwolf@redhat.com>
In-Reply-To: <20231031185918.346940-1-kwolf@redhat.com>
References: <20231031185918.346940-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Fiona Ebner <f.ebner@proxmox.com>

In preparation to allow changing the copy_mode via QMP. When running
in an iothread, it could be that copy_mode is changed from the main
thread in between reading copy_mode in bdrv_mirror_top_pwritev() and
reading copy_mode in bdrv_mirror_top_do_write(), so they might end up
disagreeing about whether copy_to_target is true or false. Avoid that
scenario by determining copy_to_target only once and passing it to
bdrv_mirror_top_do_write() as an argument.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20231031135431.393137-5-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/mirror.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 914d723446..31da1526eb 100644
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
@@ -1524,17 +1524,10 @@ static int coroutine_fn GRAPH_RDLOCK
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
@@ -1551,8 +1544,8 @@ bdrv_mirror_top_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
         flags &= ~BDRV_REQ_REGISTERED_BUF;
     }
 
-    ret = bdrv_mirror_top_do_write(bs, MIRROR_METHOD_COPY, offset, bytes, qiov,
-                                   flags);
+    ret = bdrv_mirror_top_do_write(bs, MIRROR_METHOD_COPY, copy_to_target,
+                                   offset, bytes, qiov, flags);
 
     if (copy_to_target) {
         qemu_iovec_destroy(&bounce_qiov);
@@ -1575,15 +1568,17 @@ static int coroutine_fn GRAPH_RDLOCK
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
2.41.0


