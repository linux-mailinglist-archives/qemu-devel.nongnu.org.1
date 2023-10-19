Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D23427CFAE2
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:23:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSyW-0005rM-3a; Thu, 19 Oct 2023 09:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qtSwR-0004VY-BJ; Thu, 19 Oct 2023 09:20:05 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qtSwO-0004Gg-OL; Thu, 19 Oct 2023 09:19:59 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 6CAA3430DF;
 Thu, 19 Oct 2023 15:19:41 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru, jsnow@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com,
 t.lamprecht@proxmox.com
Subject: [PATCH 3/3] blockdev: mirror: avoid potential deadlock when using
 iothread
Date: Thu, 19 Oct 2023 15:19:36 +0200
Message-Id: <20231019131936.414246-4-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231019131936.414246-1-f.ebner@proxmox.com>
References: <20231019131936.414246-1-f.ebner@proxmox.com>
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

The bdrv_getlength() function is a generated co-wrapper and uses
AIO_WAIT_WHILE() to wait for the spawned coroutine. AIO_WAIT_WHILE()
expects the lock to be acquired exactly once.

This can happen when the source node is explicitly specified as the
@replaces parameter or if there is a filter on top of the source node.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 blockdev.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index a01c62596b..877e3a26d4 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2968,6 +2968,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
 
     if (replaces) {
         BlockDriverState *to_replace_bs;
+        AioContext *aio_context;
         AioContext *replace_aio_context;
         int64_t bs_size, replace_size;
 
@@ -2982,10 +2983,19 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
             return;
         }
 
+        aio_context = bdrv_get_aio_context(bs);
         replace_aio_context = bdrv_get_aio_context(to_replace_bs);
-        aio_context_acquire(replace_aio_context);
+        /*
+         * bdrv_getlength() is a co-wrapper and uses AIO_WAIT_WHILE. Be sure not
+         * to acquire the same AioContext twice.
+         */
+        if (replace_aio_context != aio_context) {
+            aio_context_acquire(replace_aio_context);
+        }
         replace_size = bdrv_getlength(to_replace_bs);
-        aio_context_release(replace_aio_context);
+        if (replace_aio_context != aio_context) {
+            aio_context_release(replace_aio_context);
+        }
 
         if (replace_size < 0) {
             error_setg_errno(errp, -replace_size,
-- 
2.39.2



