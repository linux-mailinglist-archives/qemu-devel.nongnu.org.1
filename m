Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2234D7B362E
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:57:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmErX-00060l-Jf; Fri, 29 Sep 2023 10:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qmErV-0005zp-Rx
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:53:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qmEr0-0004lz-NU
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695999150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WaaE9tA6jzihAWyc1aNvWCfpzJmYl2QXxGBCSSIlfyU=;
 b=AdQ2dag88EqXxhRxIBUUA1rywVRJ6nlYGprHDjjgY4xwNGgMSKODPInBBC0egV9CkXAB6S
 36v1B8k65uHkxWD+z7+aVsbstCSoJRn2e++r5XrlTS+DMne1oHeTybbg7F/1L35DviGbLw
 1UTeZtsU3RHZyPgxM7FibA2w1g0hTvs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-0_Re9RQCOQ6rFkCgR2Wrig-1; Fri, 29 Sep 2023 10:52:28 -0400
X-MC-Unique: 0_Re9RQCOQ6rFkCgR2Wrig-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 082A6811E7D;
 Fri, 29 Sep 2023 14:52:28 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CEA112026D4B;
 Fri, 29 Sep 2023 14:52:26 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eesposit@redhat.com,
 eblake@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 17/22] block: Mark bdrv_op_is_blocked() and callers
 GRAPH_RDLOCK
Date: Fri, 29 Sep 2023 16:51:52 +0200
Message-ID: <20230929145157.45443-18-kwolf@redhat.com>
In-Reply-To: <20230929145157.45443-1-kwolf@redhat.com>
References: <20230929145157.45443-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

This adds GRAPH_RDLOCK annotations to declare that callers of
bdrv_op_is_blocked() need to hold a reader lock for the graph
because it calls bdrv_get_device_or_node_name(), which accesses the
parents list of a node.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-global-state.h |  4 +++-
 block.c                            |  2 --
 block/block-backend.c              |  1 +
 block/commit.c                     |  1 +
 block/monitor/block-hmp-cmds.c     |  3 +++
 block/qapi-sysemu.c                |  9 +++++++--
 blockdev.c                         | 15 +++++++++++++++
 7 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index 794ef34ded..6bfafe781d 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -246,7 +246,9 @@ bdrv_attach_child(BlockDriverState *parent_bs,
                   BdrvChildRole child_role,
                   Error **errp);
 
-bool bdrv_op_is_blocked(BlockDriverState *bs, BlockOpType op, Error **errp);
+bool GRAPH_RDLOCK
+bdrv_op_is_blocked(BlockDriverState *bs, BlockOpType op, Error **errp);
+
 void bdrv_op_block(BlockDriverState *bs, BlockOpType op, Error *reason);
 void bdrv_op_unblock(BlockDriverState *bs, BlockOpType op, Error *reason);
 void bdrv_op_block_all(BlockDriverState *bs, Error *reason);
diff --git a/block.c b/block.c
index 39c28a8dde..0814b0704e 100644
--- a/block.c
+++ b/block.c
@@ -7250,8 +7250,6 @@ bool bdrv_op_is_blocked(BlockDriverState *bs, BlockOpType op, Error **errp)
     BdrvOpBlocker *blocker;
     GLOBAL_STATE_CODE();
 
-    assume_graph_lock(); /* FIXME */
-
     assert((int) op >= 0 && op < BLOCK_OP_TYPE_MAX);
     if (!QLIST_EMPTY(&bs->op_blockers[op])) {
         blocker = QLIST_FIRST(&bs->op_blockers[op]);
diff --git a/block/block-backend.c b/block/block-backend.c
index 0fd1b4a437..a7057400d7 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2388,6 +2388,7 @@ bool blk_op_is_blocked(BlockBackend *blk, BlockOpType op, Error **errp)
 {
     BlockDriverState *bs = blk_bs(blk);
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     if (!bs) {
         return false;
diff --git a/block/commit.c b/block/commit.c
index aa45beb0f0..43d1de7577 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -434,6 +434,7 @@ int bdrv_commit(BlockDriverState *bs)
     Error *local_err = NULL;
 
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     if (!drv)
         return -ENOMEDIUM;
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 6b7d7dd072..7645c7e5fb 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -144,6 +144,9 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict)
     AioContext *aio_context;
     Error *local_err = NULL;
 
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     bs = bdrv_find_node(id);
     if (bs) {
         qmp_blockdev_del(id, &local_err);
diff --git a/block/qapi-sysemu.c b/block/qapi-sysemu.c
index e885a64c32..3f614cbc04 100644
--- a/block/qapi-sysemu.c
+++ b/block/qapi-sysemu.c
@@ -169,14 +169,16 @@ void qmp_blockdev_close_tray(const char *device,
     }
 }
 
-static void blockdev_remove_medium(const char *device, const char *id,
-                                   Error **errp)
+static void GRAPH_UNLOCKED
+blockdev_remove_medium(const char *device, const char *id, Error **errp)
 {
     BlockBackend *blk;
     BlockDriverState *bs;
     AioContext *aio_context;
     bool has_attached_device;
 
+    GLOBAL_STATE_CODE();
+
     blk = qmp_get_blk(device, id, errp);
     if (!blk) {
         return;
@@ -205,9 +207,12 @@ static void blockdev_remove_medium(const char *device, const char *id,
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
+    bdrv_graph_rdlock_main_loop();
     if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_EJECT, errp)) {
+        bdrv_graph_rdunlock_main_loop();
         goto out;
     }
+    bdrv_graph_rdunlock_main_loop();
 
     blk_remove_bs(blk);
 
diff --git a/blockdev.c b/blockdev.c
index 51c58dd432..a01c62596b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1696,9 +1696,12 @@ static void drive_backup_action(DriveBackup *backup,
     }
 
     /* Early check to avoid creating target */
+    bdrv_graph_rdlock_main_loop();
     if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_BACKUP_SOURCE, errp)) {
+        bdrv_graph_rdunlock_main_loop();
         goto out;
     }
+    bdrv_graph_rdunlock_main_loop();
 
     flags = bs->open_flags | BDRV_O_RDWR;
 
@@ -2360,10 +2363,13 @@ void coroutine_fn qmp_block_resize(const char *device, const char *node_name,
         return;
     }
 
+    bdrv_graph_co_rdlock();
     if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_RESIZE, NULL)) {
         error_setg(errp, QERR_DEVICE_IN_USE, device);
+        bdrv_graph_co_rdunlock();
         return;
     }
+    bdrv_graph_co_rdunlock();
 
     blk = blk_co_new_with_bs(bs, BLK_PERM_RESIZE, BLK_PERM_ALL, errp);
     if (!blk) {
@@ -2487,13 +2493,16 @@ void qmp_block_stream(const char *job_id, const char *device,
      * Check for op blockers in the whole chain between bs and base (or bottom)
      */
     iter_end = bottom ? bdrv_filter_or_cow_bs(bottom_bs) : base_bs;
+    bdrv_graph_rdlock_main_loop();
     for (iter = bs; iter && iter != iter_end;
          iter = bdrv_filter_or_cow_bs(iter))
     {
         if (bdrv_op_is_blocked(iter, BLOCK_OP_TYPE_STREAM, errp)) {
+            bdrv_graph_rdunlock_main_loop();
             goto out;
         }
     }
+    bdrv_graph_rdunlock_main_loop();
 
     /* if we are streaming the entire chain, the result will have no backing
      * file, and specifying one is therefore an error */
@@ -3021,9 +3030,12 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
     }
 
     /* Early check to avoid creating target */
+    bdrv_graph_rdlock_main_loop();
     if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_MIRROR_SOURCE, errp)) {
+        bdrv_graph_rdunlock_main_loop();
         return;
     }
+    bdrv_graph_rdunlock_main_loop();
 
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
@@ -3409,9 +3421,12 @@ void qmp_change_backing_file(const char *device,
 
     /* even though we are not necessarily operating on bs, we need it to
      * determine if block ops are currently prohibited on the chain */
+    bdrv_graph_rdlock_main_loop();
     if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_CHANGE, errp)) {
+        bdrv_graph_rdunlock_main_loop();
         goto out;
     }
+    bdrv_graph_rdunlock_main_loop();
 
     /* final sanity check */
     if (!bdrv_chain_contains(bs, image_bs)) {
-- 
2.41.0


