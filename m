Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 942FC706EB7
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:52:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzKNB-0003vp-Eh; Wed, 17 May 2023 12:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzKN9-0003uV-LE
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:51:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzKN6-0001O7-UH
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684342288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pgtNqd1DPjR5WMspqcarUQwt0vxcrVbWV0LqFSCnTb4=;
 b=EjXDz417toJRqANL6LP3pEsvYc7tT4F0RMo+AVRmDcxqvmgsYCOxcNBd4DFCSgysOdCiCH
 K1bI5oUOLXHc7xTR1wjqGfomY7Rlyg6volAJKWmREw4IfCCz2/fqT/KlDdu+s/4phzv2yh
 jQ1SsMBYvz/uMmVvoBEKEh9uvbgYLYU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-stwK-pfJOEKLJadNFw6wmA-1; Wed, 17 May 2023 12:51:25 -0400
X-MC-Unique: stwK-pfJOEKLJadNFw6wmA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F047185A79C;
 Wed, 17 May 2023 16:51:24 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1641440C6EC4;
 Wed, 17 May 2023 16:51:22 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 01/18] blockdev: refactor transaction to use Transaction API
Date: Wed, 17 May 2023 18:50:59 +0200
Message-Id: <20230517165116.475123-2-kwolf@redhat.com>
In-Reply-To: <20230517165116.475123-1-kwolf@redhat.com>
References: <20230517165116.475123-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

We are going to add more block-graph modifying transaction actions,
and block-graph modifying functions are already based on Transaction
API.

Next, we'll need to separately update permissions after several
graph-modifying actions, and this would be simple with help of
Transaction API.

So, now let's just transform what we have into new-style transaction
actions.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-Id: <20230510150624.310640-2-vsementsov@yandex-team.ru>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c | 309 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 178 insertions(+), 131 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index d141ca7a2d..3c72d40f51 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1210,10 +1210,7 @@ typedef struct BlkActionState BlkActionState;
  */
 typedef struct BlkActionOps {
     size_t instance_size;
-    void (*prepare)(BlkActionState *common, Error **errp);
-    void (*commit)(BlkActionState *common);
-    void (*abort)(BlkActionState *common);
-    void (*clean)(BlkActionState *common);
+    void (*action)(BlkActionState *common, Transaction *tran, Error **errp);
 } BlkActionOps;
 
 /**
@@ -1245,6 +1242,12 @@ typedef struct InternalSnapshotState {
     bool created;
 } InternalSnapshotState;
 
+static void internal_snapshot_abort(void *opaque);
+static void internal_snapshot_clean(void *opaque);
+TransactionActionDrv internal_snapshot_drv = {
+    .abort = internal_snapshot_abort,
+    .clean = internal_snapshot_clean,
+};
 
 static int action_check_completion_mode(BlkActionState *s, Error **errp)
 {
@@ -1259,8 +1262,8 @@ static int action_check_completion_mode(BlkActionState *s, Error **errp)
     return 0;
 }
 
-static void internal_snapshot_prepare(BlkActionState *common,
-                                      Error **errp)
+static void internal_snapshot_action(BlkActionState *common,
+                                     Transaction *tran, Error **errp)
 {
     Error *local_err = NULL;
     const char *device;
@@ -1279,6 +1282,8 @@ static void internal_snapshot_prepare(BlkActionState *common,
     internal = common->action->u.blockdev_snapshot_internal_sync.data;
     state = DO_UPCAST(InternalSnapshotState, common, common);
 
+    tran_add(tran, &internal_snapshot_drv, state);
+
     /* 1. parse input */
     device = internal->device;
     name = internal->name;
@@ -1363,10 +1368,9 @@ out:
     aio_context_release(aio_context);
 }
 
-static void internal_snapshot_abort(BlkActionState *common)
+static void internal_snapshot_abort(void *opaque)
 {
-    InternalSnapshotState *state =
-                             DO_UPCAST(InternalSnapshotState, common, common);
+    InternalSnapshotState *state = opaque;
     BlockDriverState *bs = state->bs;
     QEMUSnapshotInfo *sn = &state->sn;
     AioContext *aio_context;
@@ -1390,10 +1394,9 @@ static void internal_snapshot_abort(BlkActionState *common)
     aio_context_release(aio_context);
 }
 
-static void internal_snapshot_clean(BlkActionState *common)
+static void internal_snapshot_clean(void *opaque)
 {
-    InternalSnapshotState *state = DO_UPCAST(InternalSnapshotState,
-                                             common, common);
+    g_autofree InternalSnapshotState *state = opaque;
     AioContext *aio_context;
 
     if (!state->bs) {
@@ -1416,8 +1419,17 @@ typedef struct ExternalSnapshotState {
     bool overlay_appended;
 } ExternalSnapshotState;
 
-static void external_snapshot_prepare(BlkActionState *common,
-                                      Error **errp)
+static void external_snapshot_commit(void *opaque);
+static void external_snapshot_abort(void *opaque);
+static void external_snapshot_clean(void *opaque);
+TransactionActionDrv external_snapshot_drv = {
+    .commit = external_snapshot_commit,
+    .abort = external_snapshot_abort,
+    .clean = external_snapshot_clean,
+};
+
+static void external_snapshot_action(BlkActionState *common, Transaction *tran,
+                                     Error **errp)
 {
     int ret;
     int flags = 0;
@@ -1436,6 +1448,8 @@ static void external_snapshot_prepare(BlkActionState *common,
     AioContext *aio_context;
     uint64_t perm, shared;
 
+    tran_add(tran, &external_snapshot_drv, state);
+
     /* 'blockdev-snapshot' and 'blockdev-snapshot-sync' have similar
      * purpose but a different set of parameters */
     switch (action->type) {
@@ -1588,10 +1602,9 @@ out:
     aio_context_release(aio_context);
 }
 
-static void external_snapshot_commit(BlkActionState *common)
+static void external_snapshot_commit(void *opaque)
 {
-    ExternalSnapshotState *state =
-                             DO_UPCAST(ExternalSnapshotState, common, common);
+    ExternalSnapshotState *state = opaque;
     AioContext *aio_context;
 
     aio_context = bdrv_get_aio_context(state->old_bs);
@@ -1607,10 +1620,9 @@ static void external_snapshot_commit(BlkActionState *common)
     aio_context_release(aio_context);
 }
 
-static void external_snapshot_abort(BlkActionState *common)
+static void external_snapshot_abort(void *opaque)
 {
-    ExternalSnapshotState *state =
-                             DO_UPCAST(ExternalSnapshotState, common, common);
+    ExternalSnapshotState *state = opaque;
     if (state->new_bs) {
         if (state->overlay_appended) {
             AioContext *aio_context;
@@ -1650,10 +1662,9 @@ static void external_snapshot_abort(BlkActionState *common)
     }
 }
 
-static void external_snapshot_clean(BlkActionState *common)
+static void external_snapshot_clean(void *opaque)
 {
-    ExternalSnapshotState *state =
-                             DO_UPCAST(ExternalSnapshotState, common, common);
+    g_autofree ExternalSnapshotState *state = opaque;
     AioContext *aio_context;
 
     if (!state->old_bs) {
@@ -1681,7 +1692,17 @@ static BlockJob *do_backup_common(BackupCommon *backup,
                                   AioContext *aio_context,
                                   JobTxn *txn, Error **errp);
 
-static void drive_backup_prepare(BlkActionState *common, Error **errp)
+static void drive_backup_commit(void *opaque);
+static void drive_backup_abort(void *opaque);
+static void drive_backup_clean(void *opaque);
+TransactionActionDrv drive_backup_drv = {
+    .commit = drive_backup_commit,
+    .abort = drive_backup_abort,
+    .clean = drive_backup_clean,
+};
+
+static void drive_backup_action(BlkActionState *common, Transaction *tran,
+                                Error **errp)
 {
     DriveBackupState *state = DO_UPCAST(DriveBackupState, common, common);
     DriveBackup *backup;
@@ -1698,6 +1719,8 @@ static void drive_backup_prepare(BlkActionState *common, Error **errp)
     bool set_backing_hd = false;
     int ret;
 
+    tran_add(tran, &drive_backup_drv, state);
+
     assert(common->action->type == TRANSACTION_ACTION_KIND_DRIVE_BACKUP);
     backup = common->action->u.drive_backup.data;
 
@@ -1828,9 +1851,9 @@ out:
     aio_context_release(aio_context);
 }
 
-static void drive_backup_commit(BlkActionState *common)
+static void drive_backup_commit(void *opaque)
 {
-    DriveBackupState *state = DO_UPCAST(DriveBackupState, common, common);
+    DriveBackupState *state = opaque;
     AioContext *aio_context;
 
     aio_context = bdrv_get_aio_context(state->bs);
@@ -1842,18 +1865,18 @@ static void drive_backup_commit(BlkActionState *common)
     aio_context_release(aio_context);
 }
 
-static void drive_backup_abort(BlkActionState *common)
+static void drive_backup_abort(void *opaque)
 {
-    DriveBackupState *state = DO_UPCAST(DriveBackupState, common, common);
+    DriveBackupState *state = opaque;
 
     if (state->job) {
         job_cancel_sync(&state->job->job, true);
     }
 }
 
-static void drive_backup_clean(BlkActionState *common)
+static void drive_backup_clean(void *opaque)
 {
-    DriveBackupState *state = DO_UPCAST(DriveBackupState, common, common);
+    g_autofree DriveBackupState *state = opaque;
     AioContext *aio_context;
 
     if (!state->bs) {
@@ -1874,7 +1897,17 @@ typedef struct BlockdevBackupState {
     BlockJob *job;
 } BlockdevBackupState;
 
-static void blockdev_backup_prepare(BlkActionState *common, Error **errp)
+static void blockdev_backup_commit(void *opaque);
+static void blockdev_backup_abort(void *opaque);
+static void blockdev_backup_clean(void *opaque);
+TransactionActionDrv blockdev_backup_drv = {
+    .commit = blockdev_backup_commit,
+    .abort = blockdev_backup_abort,
+    .clean = blockdev_backup_clean,
+};
+
+static void blockdev_backup_action(BlkActionState *common, Transaction *tran,
+                                   Error **errp)
 {
     BlockdevBackupState *state = DO_UPCAST(BlockdevBackupState, common, common);
     BlockdevBackup *backup;
@@ -1884,6 +1917,8 @@ static void blockdev_backup_prepare(BlkActionState *common, Error **errp)
     AioContext *old_context;
     int ret;
 
+    tran_add(tran, &blockdev_backup_drv, state);
+
     assert(common->action->type == TRANSACTION_ACTION_KIND_BLOCKDEV_BACKUP);
     backup = common->action->u.blockdev_backup.data;
 
@@ -1922,9 +1957,9 @@ static void blockdev_backup_prepare(BlkActionState *common, Error **errp)
     aio_context_release(aio_context);
 }
 
-static void blockdev_backup_commit(BlkActionState *common)
+static void blockdev_backup_commit(void *opaque)
 {
-    BlockdevBackupState *state = DO_UPCAST(BlockdevBackupState, common, common);
+    BlockdevBackupState *state = opaque;
     AioContext *aio_context;
 
     aio_context = bdrv_get_aio_context(state->bs);
@@ -1936,18 +1971,18 @@ static void blockdev_backup_commit(BlkActionState *common)
     aio_context_release(aio_context);
 }
 
-static void blockdev_backup_abort(BlkActionState *common)
+static void blockdev_backup_abort(void *opaque)
 {
-    BlockdevBackupState *state = DO_UPCAST(BlockdevBackupState, common, common);
+    BlockdevBackupState *state = opaque;
 
     if (state->job) {
         job_cancel_sync(&state->job->job, true);
     }
 }
 
-static void blockdev_backup_clean(BlkActionState *common)
+static void blockdev_backup_clean(void *opaque)
 {
-    BlockdevBackupState *state = DO_UPCAST(BlockdevBackupState, common, common);
+    g_autofree BlockdevBackupState *state = opaque;
     AioContext *aio_context;
 
     if (!state->bs) {
@@ -1971,14 +2006,22 @@ typedef struct BlockDirtyBitmapState {
     bool was_enabled;
 } BlockDirtyBitmapState;
 
-static void block_dirty_bitmap_add_prepare(BlkActionState *common,
-                                           Error **errp)
+static void block_dirty_bitmap_add_abort(void *opaque);
+TransactionActionDrv block_dirty_bitmap_add_drv = {
+    .abort = block_dirty_bitmap_add_abort,
+    .clean = g_free,
+};
+
+static void block_dirty_bitmap_add_action(BlkActionState *common,
+                                          Transaction *tran, Error **errp)
 {
     Error *local_err = NULL;
     BlockDirtyBitmapAdd *action;
     BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
                                              common, common);
 
+    tran_add(tran, &block_dirty_bitmap_add_drv, state);
+
     if (action_check_completion_mode(common, errp) < 0) {
         return;
     }
@@ -1998,13 +2041,12 @@ static void block_dirty_bitmap_add_prepare(BlkActionState *common,
     }
 }
 
-static void block_dirty_bitmap_add_abort(BlkActionState *common)
+static void block_dirty_bitmap_add_abort(void *opaque)
 {
     BlockDirtyBitmapAdd *action;
-    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
-                                             common, common);
+    BlockDirtyBitmapState *state = opaque;
 
-    action = common->action->u.block_dirty_bitmap_add.data;
+    action = state->common.action->u.block_dirty_bitmap_add.data;
     /* Should not be able to fail: IF the bitmap was added via .prepare(),
      * then the node reference and bitmap name must have been valid.
      */
@@ -2013,13 +2055,23 @@ static void block_dirty_bitmap_add_abort(BlkActionState *common)
     }
 }
 
-static void block_dirty_bitmap_clear_prepare(BlkActionState *common,
-                                             Error **errp)
+static void block_dirty_bitmap_restore(void *opaque);
+static void block_dirty_bitmap_free_backup(void *opaque);
+TransactionActionDrv block_dirty_bitmap_clear_drv = {
+    .abort = block_dirty_bitmap_restore,
+    .commit = block_dirty_bitmap_free_backup,
+    .clean = g_free,
+};
+
+static void block_dirty_bitmap_clear_action(BlkActionState *common,
+                                            Transaction *tran, Error **errp)
 {
     BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
                                              common, common);
     BlockDirtyBitmap *action;
 
+    tran_add(tran, &block_dirty_bitmap_clear_drv, state);
+
     if (action_check_completion_mode(common, errp) < 0) {
         return;
     }
@@ -2040,31 +2092,37 @@ static void block_dirty_bitmap_clear_prepare(BlkActionState *common,
     bdrv_clear_dirty_bitmap(state->bitmap, &state->backup);
 }
 
-static void block_dirty_bitmap_restore(BlkActionState *common)
+static void block_dirty_bitmap_restore(void *opaque)
 {
-    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
-                                             common, common);
+    BlockDirtyBitmapState *state = opaque;
 
     if (state->backup) {
         bdrv_restore_dirty_bitmap(state->bitmap, state->backup);
     }
 }
 
-static void block_dirty_bitmap_free_backup(BlkActionState *common)
+static void block_dirty_bitmap_free_backup(void *opaque)
 {
-    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
-                                             common, common);
+    BlockDirtyBitmapState *state = opaque;
 
     hbitmap_free(state->backup);
 }
 
-static void block_dirty_bitmap_enable_prepare(BlkActionState *common,
-                                              Error **errp)
+static void block_dirty_bitmap_enable_abort(void *opaque);
+TransactionActionDrv block_dirty_bitmap_enable_drv = {
+    .abort = block_dirty_bitmap_enable_abort,
+    .clean = g_free,
+};
+
+static void block_dirty_bitmap_enable_action(BlkActionState *common,
+                                             Transaction *tran, Error **errp)
 {
     BlockDirtyBitmap *action;
     BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
                                              common, common);
 
+    tran_add(tran, &block_dirty_bitmap_enable_drv, state);
+
     if (action_check_completion_mode(common, errp) < 0) {
         return;
     }
@@ -2086,23 +2144,30 @@ static void block_dirty_bitmap_enable_prepare(BlkActionState *common,
     bdrv_enable_dirty_bitmap(state->bitmap);
 }
 
-static void block_dirty_bitmap_enable_abort(BlkActionState *common)
+static void block_dirty_bitmap_enable_abort(void *opaque)
 {
-    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
-                                             common, common);
+    BlockDirtyBitmapState *state = opaque;
 
     if (!state->was_enabled) {
         bdrv_disable_dirty_bitmap(state->bitmap);
     }
 }
 
-static void block_dirty_bitmap_disable_prepare(BlkActionState *common,
-                                               Error **errp)
+static void block_dirty_bitmap_disable_abort(void *opaque);
+TransactionActionDrv block_dirty_bitmap_disable_drv = {
+    .abort = block_dirty_bitmap_disable_abort,
+    .clean = g_free,
+};
+
+static void block_dirty_bitmap_disable_action(BlkActionState *common,
+                                              Transaction *tran, Error **errp)
 {
     BlockDirtyBitmap *action;
     BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
                                              common, common);
 
+    tran_add(tran, &block_dirty_bitmap_disable_drv, state);
+
     if (action_check_completion_mode(common, errp) < 0) {
         return;
     }
@@ -2124,23 +2189,30 @@ static void block_dirty_bitmap_disable_prepare(BlkActionState *common,
     bdrv_disable_dirty_bitmap(state->bitmap);
 }
 
-static void block_dirty_bitmap_disable_abort(BlkActionState *common)
+static void block_dirty_bitmap_disable_abort(void *opaque)
 {
-    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
-                                             common, common);
+    BlockDirtyBitmapState *state = opaque;
 
     if (state->was_enabled) {
         bdrv_enable_dirty_bitmap(state->bitmap);
     }
 }
 
-static void block_dirty_bitmap_merge_prepare(BlkActionState *common,
-                                             Error **errp)
+TransactionActionDrv block_dirty_bitmap_merge_drv = {
+    .commit = block_dirty_bitmap_free_backup,
+    .abort = block_dirty_bitmap_restore,
+    .clean = g_free,
+};
+
+static void block_dirty_bitmap_merge_action(BlkActionState *common,
+                                            Transaction *tran, Error **errp)
 {
     BlockDirtyBitmapMerge *action;
     BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
                                              common, common);
 
+    tran_add(tran, &block_dirty_bitmap_merge_drv, state);
+
     if (action_check_completion_mode(common, errp) < 0) {
         return;
     }
@@ -2152,13 +2224,23 @@ static void block_dirty_bitmap_merge_prepare(BlkActionState *common,
                                              errp);
 }
 
-static void block_dirty_bitmap_remove_prepare(BlkActionState *common,
-                                              Error **errp)
+static void block_dirty_bitmap_remove_commit(void *opaque);
+static void block_dirty_bitmap_remove_abort(void *opaque);
+TransactionActionDrv block_dirty_bitmap_remove_drv = {
+    .commit = block_dirty_bitmap_remove_commit,
+    .abort = block_dirty_bitmap_remove_abort,
+    .clean = g_free,
+};
+
+static void block_dirty_bitmap_remove_action(BlkActionState *common,
+                                             Transaction *tran, Error **errp)
 {
     BlockDirtyBitmap *action;
     BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
                                              common, common);
 
+    tran_add(tran, &block_dirty_bitmap_remove_drv, state);
+
     if (action_check_completion_mode(common, errp) < 0) {
         return;
     }
@@ -2173,10 +2255,9 @@ static void block_dirty_bitmap_remove_prepare(BlkActionState *common,
     }
 }
 
-static void block_dirty_bitmap_remove_abort(BlkActionState *common)
+static void block_dirty_bitmap_remove_abort(void *opaque)
 {
-    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
-                                             common, common);
+    BlockDirtyBitmapState *state = opaque;
 
     if (state->bitmap) {
         bdrv_dirty_bitmap_skip_store(state->bitmap, false);
@@ -2184,21 +2265,28 @@ static void block_dirty_bitmap_remove_abort(BlkActionState *common)
     }
 }
 
-static void block_dirty_bitmap_remove_commit(BlkActionState *common)
+static void block_dirty_bitmap_remove_commit(void *opaque)
 {
-    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
-                                             common, common);
+    BlockDirtyBitmapState *state = opaque;
 
     bdrv_dirty_bitmap_set_busy(state->bitmap, false);
     bdrv_release_dirty_bitmap(state->bitmap);
 }
 
-static void abort_prepare(BlkActionState *common, Error **errp)
+static void abort_commit(void *opaque);
+TransactionActionDrv abort_drv = {
+    .commit = abort_commit,
+    .clean = g_free,
+};
+
+static void abort_action(BlkActionState *common, Transaction *tran,
+                         Error **errp)
 {
+    tran_add(tran, &abort_drv, common);
     error_setg(errp, "Transaction aborted using Abort action");
 }
 
-static void abort_commit(BlkActionState *common)
+static void abort_commit(void *opaque)
 {
     g_assert_not_reached(); /* this action never succeeds */
 }
@@ -2206,75 +2294,51 @@ static void abort_commit(BlkActionState *common)
 static const BlkActionOps actions[] = {
     [TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT] = {
         .instance_size = sizeof(ExternalSnapshotState),
-        .prepare  = external_snapshot_prepare,
-        .commit   = external_snapshot_commit,
-        .abort = external_snapshot_abort,
-        .clean = external_snapshot_clean,
+        .action  = external_snapshot_action,
     },
     [TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT_SYNC] = {
         .instance_size = sizeof(ExternalSnapshotState),
-        .prepare  = external_snapshot_prepare,
-        .commit   = external_snapshot_commit,
-        .abort = external_snapshot_abort,
-        .clean = external_snapshot_clean,
+        .action  = external_snapshot_action,
     },
     [TRANSACTION_ACTION_KIND_DRIVE_BACKUP] = {
         .instance_size = sizeof(DriveBackupState),
-        .prepare = drive_backup_prepare,
-        .commit = drive_backup_commit,
-        .abort = drive_backup_abort,
-        .clean = drive_backup_clean,
+        .action = drive_backup_action,
     },
     [TRANSACTION_ACTION_KIND_BLOCKDEV_BACKUP] = {
         .instance_size = sizeof(BlockdevBackupState),
-        .prepare = blockdev_backup_prepare,
-        .commit = blockdev_backup_commit,
-        .abort = blockdev_backup_abort,
-        .clean = blockdev_backup_clean,
+        .action = blockdev_backup_action,
     },
     [TRANSACTION_ACTION_KIND_ABORT] = {
         .instance_size = sizeof(BlkActionState),
-        .prepare = abort_prepare,
-        .commit = abort_commit,
+        .action = abort_action,
     },
     [TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT_INTERNAL_SYNC] = {
         .instance_size = sizeof(InternalSnapshotState),
-        .prepare  = internal_snapshot_prepare,
-        .abort = internal_snapshot_abort,
-        .clean = internal_snapshot_clean,
+        .action  = internal_snapshot_action,
     },
     [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_ADD] = {
         .instance_size = sizeof(BlockDirtyBitmapState),
-        .prepare = block_dirty_bitmap_add_prepare,
-        .abort = block_dirty_bitmap_add_abort,
+        .action = block_dirty_bitmap_add_action,
     },
     [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_CLEAR] = {
         .instance_size = sizeof(BlockDirtyBitmapState),
-        .prepare = block_dirty_bitmap_clear_prepare,
-        .commit = block_dirty_bitmap_free_backup,
-        .abort = block_dirty_bitmap_restore,
+        .action = block_dirty_bitmap_clear_action,
     },
     [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_ENABLE] = {
         .instance_size = sizeof(BlockDirtyBitmapState),
-        .prepare = block_dirty_bitmap_enable_prepare,
-        .abort = block_dirty_bitmap_enable_abort,
+        .action = block_dirty_bitmap_enable_action,
     },
     [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_DISABLE] = {
         .instance_size = sizeof(BlockDirtyBitmapState),
-        .prepare = block_dirty_bitmap_disable_prepare,
-        .abort = block_dirty_bitmap_disable_abort,
+        .action = block_dirty_bitmap_disable_action,
     },
     [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_MERGE] = {
         .instance_size = sizeof(BlockDirtyBitmapState),
-        .prepare = block_dirty_bitmap_merge_prepare,
-        .commit = block_dirty_bitmap_free_backup,
-        .abort = block_dirty_bitmap_restore,
+        .action = block_dirty_bitmap_merge_action,
     },
     [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_REMOVE] = {
         .instance_size = sizeof(BlockDirtyBitmapState),
-        .prepare = block_dirty_bitmap_remove_prepare,
-        .commit = block_dirty_bitmap_remove_commit,
-        .abort = block_dirty_bitmap_remove_abort,
+        .action = block_dirty_bitmap_remove_action,
     },
     /* Where are transactions for MIRROR, COMMIT and STREAM?
      * Although these blockjobs use transaction callbacks like the backup job,
@@ -2316,14 +2380,11 @@ void qmp_transaction(TransactionActionList *dev_list,
     TransactionActionList *dev_entry = dev_list;
     bool has_props = !!props;
     JobTxn *block_job_txn = NULL;
-    BlkActionState *state, *next;
     Error *local_err = NULL;
+    Transaction *tran = tran_new();
 
     GLOBAL_STATE_CODE();
 
-    QTAILQ_HEAD(, BlkActionState) snap_bdrv_states;
-    QTAILQ_INIT(&snap_bdrv_states);
-
     /* Does this transaction get canceled as a group on failure?
      * If not, we don't really need to make a JobTxn.
      */
@@ -2339,6 +2400,7 @@ void qmp_transaction(TransactionActionList *dev_list,
     while (NULL != dev_entry) {
         TransactionAction *dev_info = NULL;
         const BlkActionOps *ops;
+        BlkActionState *state;
 
         dev_info = dev_entry->value;
         dev_entry = dev_entry->next;
@@ -2353,38 +2415,23 @@ void qmp_transaction(TransactionActionList *dev_list,
         state->action = dev_info;
         state->block_job_txn = block_job_txn;
         state->txn_props = props;
-        QTAILQ_INSERT_TAIL(&snap_bdrv_states, state, entry);
 
-        state->ops->prepare(state, &local_err);
+        state->ops->action(state, tran, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             goto delete_and_fail;
         }
     }
 
-    QTAILQ_FOREACH(state, &snap_bdrv_states, entry) {
-        if (state->ops->commit) {
-            state->ops->commit(state);
-        }
-    }
+    tran_commit(tran);
 
     /* success */
     goto exit;
 
 delete_and_fail:
     /* failure, and it is all-or-none; roll back all operations */
-    QTAILQ_FOREACH_REVERSE(state, &snap_bdrv_states, entry) {
-        if (state->ops->abort) {
-            state->ops->abort(state);
-        }
-    }
+    tran_abort(tran);
 exit:
-    QTAILQ_FOREACH_SAFE(state, &snap_bdrv_states, entry, next) {
-        if (state->ops->clean) {
-            state->ops->clean(state);
-        }
-        g_free(state);
-    }
     if (!has_props) {
         qapi_free_TransactionProperties(props);
     }
-- 
2.40.1


