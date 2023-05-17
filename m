Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5718A706EBD
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:53:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzKNJ-00041a-Kq; Wed, 17 May 2023 12:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzKNH-0003zT-8F
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:51:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzKNC-0001Q5-JC
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684342294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qhMv5NzwHttqaQUeeSf8xX8q9cynsPcI2TdbA7/N4p8=;
 b=M6TzDdebhGdF1CR4LZ2VIBHP7euLUaKuWk+KNbNJtUEggXme+yebXnoXrGEStRDrVcXspu
 6rFm32R38mJd8P/WmYKPV59zWqFs++EjDg8F186gzED3VL31ET2blJc5jvcQqH+ARQ0pbI
 wx350cGzii0ed/9scUEkitpJDeLs6wg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-68-Lccu88P6OdKH-FeQHdvKeA-1; Wed, 17 May 2023 12:51:29 -0400
X-MC-Unique: Lccu88P6OdKH-FeQHdvKeA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 694F2185A790;
 Wed, 17 May 2023 16:51:29 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95EC740C6EC4;
 Wed, 17 May 2023 16:51:28 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 06/18] blockdev: qmp_transaction: drop extra generic layer
Date: Wed, 17 May 2023 18:51:04 +0200
Message-Id: <20230517165116.475123-7-kwolf@redhat.com>
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

Let's simplify things:

First, actions generally don't need access to common BlkActionState
structure. The only exclusion are backup actions that need
block_job_txn.

Next, for transaction actions of Transaction API is more native to
allocated state structure in the action itself.

So, do the following transformation:

1. Let all actions be represented by a function with corresponding
   structure as arguments.

2. Instead of array-map marshaller, let's make a function, that calls
   corresponding action directly.

3. BlkActionOps and BlkActionState structures become unused

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-Id: <20230510150624.310640-7-vsementsov@yandex-team.ru>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c | 265 +++++++++++++++++------------------------------------
 1 file changed, 85 insertions(+), 180 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 4bf15566b2..5d56b79df4 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1188,54 +1188,8 @@ out_aio_context:
     return NULL;
 }
 
-/* New and old BlockDriverState structs for atomic group operations */
-
-typedef struct BlkActionState BlkActionState;
-
-/**
- * BlkActionOps:
- * Table of operations that define an Action.
- *
- * @instance_size: Size of state struct, in bytes.
- * @prepare: Prepare the work, must NOT be NULL.
- * @commit: Commit the changes, can be NULL.
- * @abort: Abort the changes on fail, can be NULL.
- * @clean: Clean up resources after all transaction actions have called
- *         commit() or abort(). Can be NULL.
- *
- * Only prepare() may fail. In a single transaction, only one of commit() or
- * abort() will be called. clean() will always be called if it is present.
- *
- * Always run under BQL.
- */
-typedef struct BlkActionOps {
-    size_t instance_size;
-    void (*action)(BlkActionState *common, Transaction *tran, Error **errp);
-} BlkActionOps;
-
-/**
- * BlkActionState:
- * Describes one Action's state within a Transaction.
- *
- * @action: QAPI-defined enum identifying which Action to perform.
- * @ops: Table of ActionOps this Action can perform.
- * @block_job_txn: Transaction which this action belongs to.
- * @entry: List membership for all Actions in this Transaction.
- *
- * This structure must be arranged as first member in a subclassed type,
- * assuming that the compiler will also arrange it to the same offsets as the
- * base class.
- */
-struct BlkActionState {
-    TransactionAction *action;
-    const BlkActionOps *ops;
-    JobTxn *block_job_txn;
-    QTAILQ_ENTRY(BlkActionState) entry;
-};
-
 /* internal snapshot private data */
 typedef struct InternalSnapshotState {
-    BlkActionState common;
     BlockDriverState *bs;
     QEMUSnapshotInfo sn;
     bool created;
@@ -1248,7 +1202,7 @@ TransactionActionDrv internal_snapshot_drv = {
     .clean = internal_snapshot_clean,
 };
 
-static void internal_snapshot_action(BlkActionState *common,
+static void internal_snapshot_action(BlockdevSnapshotInternal *internal,
                                      Transaction *tran, Error **errp)
 {
     Error *local_err = NULL;
@@ -1258,16 +1212,10 @@ static void internal_snapshot_action(BlkActionState *common,
     QEMUSnapshotInfo old_sn, *sn;
     bool ret;
     int64_t rt;
-    BlockdevSnapshotInternal *internal;
-    InternalSnapshotState *state;
+    InternalSnapshotState *state = g_new0(InternalSnapshotState, 1);
     AioContext *aio_context;
     int ret1;
 
-    g_assert(common->action->type ==
-             TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT_INTERNAL_SYNC);
-    internal = common->action->u.blockdev_snapshot_internal_sync.data;
-    state = DO_UPCAST(InternalSnapshotState, common, common);
-
     tran_add(tran, &internal_snapshot_drv, state);
 
     device = internal->device;
@@ -1393,7 +1341,6 @@ static void internal_snapshot_clean(void *opaque)
 
 /* external snapshot private data */
 typedef struct ExternalSnapshotState {
-    BlkActionState common;
     BlockDriverState *old_bs;
     BlockDriverState *new_bs;
     bool overlay_appended;
@@ -1408,8 +1355,8 @@ TransactionActionDrv external_snapshot_drv = {
     .clean = external_snapshot_clean,
 };
 
-static void external_snapshot_action(BlkActionState *common, Transaction *tran,
-                                     Error **errp)
+static void external_snapshot_action(TransactionAction *action,
+                                     Transaction *tran, Error **errp)
 {
     int ret;
     int flags = 0;
@@ -1422,9 +1369,7 @@ static void external_snapshot_action(BlkActionState *common, Transaction *tran,
     const char *snapshot_ref;
     /* File name of the new image (for 'blockdev-snapshot-sync') */
     const char *new_image_file;
-    ExternalSnapshotState *state =
-                             DO_UPCAST(ExternalSnapshotState, common, common);
-    TransactionAction *action = common->action;
+    ExternalSnapshotState *state = g_new0(ExternalSnapshotState, 1);
     AioContext *aio_context;
     uint64_t perm, shared;
 
@@ -1658,7 +1603,6 @@ static void external_snapshot_clean(void *opaque)
 }
 
 typedef struct DriveBackupState {
-    BlkActionState common;
     BlockDriverState *bs;
     BlockJob *job;
 } DriveBackupState;
@@ -1678,11 +1622,11 @@ TransactionActionDrv drive_backup_drv = {
     .clean = drive_backup_clean,
 };
 
-static void drive_backup_action(BlkActionState *common, Transaction *tran,
-                                Error **errp)
+static void drive_backup_action(DriveBackup *backup,
+                                JobTxn *block_job_txn,
+                                Transaction *tran, Error **errp)
 {
-    DriveBackupState *state = DO_UPCAST(DriveBackupState, common, common);
-    DriveBackup *backup;
+    DriveBackupState *state = g_new0(DriveBackupState, 1);
     BlockDriverState *bs;
     BlockDriverState *target_bs;
     BlockDriverState *source = NULL;
@@ -1698,9 +1642,6 @@ static void drive_backup_action(BlkActionState *common, Transaction *tran,
 
     tran_add(tran, &drive_backup_drv, state);
 
-    assert(common->action->type == TRANSACTION_ACTION_KIND_DRIVE_BACKUP);
-    backup = common->action->u.drive_backup.data;
-
     if (!backup->has_mode) {
         backup->mode = NEW_IMAGE_MODE_ABSOLUTE_PATHS;
     }
@@ -1820,7 +1761,7 @@ static void drive_backup_action(BlkActionState *common, Transaction *tran,
 
     state->job = do_backup_common(qapi_DriveBackup_base(backup),
                                   bs, target_bs, aio_context,
-                                  common->block_job_txn, errp);
+                                  block_job_txn, errp);
 
 unref:
     bdrv_unref(target_bs);
@@ -1869,7 +1810,6 @@ static void drive_backup_clean(void *opaque)
 }
 
 typedef struct BlockdevBackupState {
-    BlkActionState common;
     BlockDriverState *bs;
     BlockJob *job;
 } BlockdevBackupState;
@@ -1883,11 +1823,11 @@ TransactionActionDrv blockdev_backup_drv = {
     .clean = blockdev_backup_clean,
 };
 
-static void blockdev_backup_action(BlkActionState *common, Transaction *tran,
-                                   Error **errp)
+static void blockdev_backup_action(BlockdevBackup *backup,
+                                   JobTxn *block_job_txn,
+                                   Transaction *tran, Error **errp)
 {
-    BlockdevBackupState *state = DO_UPCAST(BlockdevBackupState, common, common);
-    BlockdevBackup *backup;
+    BlockdevBackupState *state = g_new0(BlockdevBackupState, 1);
     BlockDriverState *bs;
     BlockDriverState *target_bs;
     AioContext *aio_context;
@@ -1896,9 +1836,6 @@ static void blockdev_backup_action(BlkActionState *common, Transaction *tran,
 
     tran_add(tran, &blockdev_backup_drv, state);
 
-    assert(common->action->type == TRANSACTION_ACTION_KIND_BLOCKDEV_BACKUP);
-    backup = common->action->u.blockdev_backup.data;
-
     bs = bdrv_lookup_bs(backup->device, backup->device, errp);
     if (!bs) {
         return;
@@ -1929,7 +1866,7 @@ static void blockdev_backup_action(BlkActionState *common, Transaction *tran,
 
     state->job = do_backup_common(qapi_BlockdevBackup_base(backup),
                                   bs, target_bs, aio_context,
-                                  common->block_job_txn, errp);
+                                  block_job_txn, errp);
 
     aio_context_release(aio_context);
 }
@@ -1975,7 +1912,6 @@ static void blockdev_backup_clean(void *opaque)
 }
 
 typedef struct BlockDirtyBitmapState {
-    BlkActionState common;
     BdrvDirtyBitmap *bitmap;
     BlockDriverState *bs;
     HBitmap *backup;
@@ -1988,17 +1924,14 @@ TransactionActionDrv block_dirty_bitmap_add_drv = {
     .clean = g_free,
 };
 
-static void block_dirty_bitmap_add_action(BlkActionState *common,
+static void block_dirty_bitmap_add_action(BlockDirtyBitmapAdd *action,
                                           Transaction *tran, Error **errp)
 {
     Error *local_err = NULL;
-    BlockDirtyBitmapAdd *action;
-    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
-                                             common, common);
+    BlockDirtyBitmapState *state = g_new0(BlockDirtyBitmapState, 1);
 
     tran_add(tran, &block_dirty_bitmap_add_drv, state);
 
-    action = common->action->u.block_dirty_bitmap_add.data;
     /* AIO context taken and released within qmp_block_dirty_bitmap_add */
     qmp_block_dirty_bitmap_add(action->node, action->name,
                                action->has_granularity, action->granularity,
@@ -2031,16 +1964,13 @@ TransactionActionDrv block_dirty_bitmap_clear_drv = {
     .clean = g_free,
 };
 
-static void block_dirty_bitmap_clear_action(BlkActionState *common,
+static void block_dirty_bitmap_clear_action(BlockDirtyBitmap *action,
                                             Transaction *tran, Error **errp)
 {
-    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
-                                             common, common);
-    BlockDirtyBitmap *action;
+    BlockDirtyBitmapState *state = g_new0(BlockDirtyBitmapState, 1);
 
     tran_add(tran, &block_dirty_bitmap_clear_drv, state);
 
-    action = common->action->u.block_dirty_bitmap_clear.data;
     state->bitmap = block_dirty_bitmap_lookup(action->node,
                                               action->name,
                                               &state->bs,
@@ -2078,16 +2008,13 @@ TransactionActionDrv block_dirty_bitmap_enable_drv = {
     .clean = g_free,
 };
 
-static void block_dirty_bitmap_enable_action(BlkActionState *common,
+static void block_dirty_bitmap_enable_action(BlockDirtyBitmap *action,
                                              Transaction *tran, Error **errp)
 {
-    BlockDirtyBitmap *action;
-    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
-                                             common, common);
+    BlockDirtyBitmapState *state = g_new0(BlockDirtyBitmapState, 1);
 
     tran_add(tran, &block_dirty_bitmap_enable_drv, state);
 
-    action = common->action->u.block_dirty_bitmap_enable.data;
     state->bitmap = block_dirty_bitmap_lookup(action->node,
                                               action->name,
                                               NULL,
@@ -2119,16 +2046,13 @@ TransactionActionDrv block_dirty_bitmap_disable_drv = {
     .clean = g_free,
 };
 
-static void block_dirty_bitmap_disable_action(BlkActionState *common,
+static void block_dirty_bitmap_disable_action(BlockDirtyBitmap *action,
                                               Transaction *tran, Error **errp)
 {
-    BlockDirtyBitmap *action;
-    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
-                                             common, common);
+    BlockDirtyBitmapState *state = g_new0(BlockDirtyBitmapState, 1);
 
     tran_add(tran, &block_dirty_bitmap_disable_drv, state);
 
-    action = common->action->u.block_dirty_bitmap_disable.data;
     state->bitmap = block_dirty_bitmap_lookup(action->node,
                                               action->name,
                                               NULL,
@@ -2160,17 +2084,13 @@ TransactionActionDrv block_dirty_bitmap_merge_drv = {
     .clean = g_free,
 };
 
-static void block_dirty_bitmap_merge_action(BlkActionState *common,
+static void block_dirty_bitmap_merge_action(BlockDirtyBitmapMerge *action,
                                             Transaction *tran, Error **errp)
 {
-    BlockDirtyBitmapMerge *action;
-    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
-                                             common, common);
+    BlockDirtyBitmapState *state = g_new0(BlockDirtyBitmapState, 1);
 
     tran_add(tran, &block_dirty_bitmap_merge_drv, state);
 
-    action = common->action->u.block_dirty_bitmap_merge.data;
-
     state->bitmap = block_dirty_bitmap_merge(action->node, action->target,
                                              action->bitmaps, &state->backup,
                                              errp);
@@ -2184,16 +2104,13 @@ TransactionActionDrv block_dirty_bitmap_remove_drv = {
     .clean = g_free,
 };
 
-static void block_dirty_bitmap_remove_action(BlkActionState *common,
+static void block_dirty_bitmap_remove_action(BlockDirtyBitmap *action,
                                              Transaction *tran, Error **errp)
 {
-    BlockDirtyBitmap *action;
-    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
-                                             common, common);
+    BlockDirtyBitmapState *state = g_new0(BlockDirtyBitmapState, 1);
 
     tran_add(tran, &block_dirty_bitmap_remove_drv, state);
 
-    action = common->action->u.block_dirty_bitmap_remove.data;
 
     state->bitmap = block_dirty_bitmap_remove(action->node, action->name,
                                               false, &state->bs, errp);
@@ -2224,13 +2141,11 @@ static void block_dirty_bitmap_remove_commit(void *opaque)
 static void abort_commit(void *opaque);
 TransactionActionDrv abort_drv = {
     .commit = abort_commit,
-    .clean = g_free,
 };
 
-static void abort_action(BlkActionState *common, Transaction *tran,
-                         Error **errp)
+static void abort_action(Transaction *tran, Error **errp)
 {
-    tran_add(tran, &abort_drv, common);
+    tran_add(tran, &abort_drv, NULL);
     error_setg(errp, "Transaction aborted using Abort action");
 }
 
@@ -2239,62 +2154,66 @@ static void abort_commit(void *opaque)
     g_assert_not_reached(); /* this action never succeeds */
 }
 
-static const BlkActionOps actions_map[] = {
-    [TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT] = {
-        .instance_size = sizeof(ExternalSnapshotState),
-        .action  = external_snapshot_action,
-    },
-    [TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT_SYNC] = {
-        .instance_size = sizeof(ExternalSnapshotState),
-        .action  = external_snapshot_action,
-    },
-    [TRANSACTION_ACTION_KIND_DRIVE_BACKUP] = {
-        .instance_size = sizeof(DriveBackupState),
-        .action = drive_backup_action,
-    },
-    [TRANSACTION_ACTION_KIND_BLOCKDEV_BACKUP] = {
-        .instance_size = sizeof(BlockdevBackupState),
-        .action = blockdev_backup_action,
-    },
-    [TRANSACTION_ACTION_KIND_ABORT] = {
-        .instance_size = sizeof(BlkActionState),
-        .action = abort_action,
-    },
-    [TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT_INTERNAL_SYNC] = {
-        .instance_size = sizeof(InternalSnapshotState),
-        .action  = internal_snapshot_action,
-    },
-    [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_ADD] = {
-        .instance_size = sizeof(BlockDirtyBitmapState),
-        .action = block_dirty_bitmap_add_action,
-    },
-    [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_CLEAR] = {
-        .instance_size = sizeof(BlockDirtyBitmapState),
-        .action = block_dirty_bitmap_clear_action,
-    },
-    [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_ENABLE] = {
-        .instance_size = sizeof(BlockDirtyBitmapState),
-        .action = block_dirty_bitmap_enable_action,
-    },
-    [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_DISABLE] = {
-        .instance_size = sizeof(BlockDirtyBitmapState),
-        .action = block_dirty_bitmap_disable_action,
-    },
-    [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_MERGE] = {
-        .instance_size = sizeof(BlockDirtyBitmapState),
-        .action = block_dirty_bitmap_merge_action,
-    },
-    [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_REMOVE] = {
-        .instance_size = sizeof(BlockDirtyBitmapState),
-        .action = block_dirty_bitmap_remove_action,
-    },
-    /* Where are transactions for MIRROR, COMMIT and STREAM?
+static void transaction_action(TransactionAction *act, JobTxn *block_job_txn,
+                               Transaction *tran, Error **errp)
+{
+    switch (act->type) {
+    case TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT:
+    case TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT_SYNC:
+        external_snapshot_action(act, tran, errp);
+        return;
+    case TRANSACTION_ACTION_KIND_DRIVE_BACKUP:
+        drive_backup_action(act->u.drive_backup.data,
+                            block_job_txn, tran, errp);
+        return;
+    case TRANSACTION_ACTION_KIND_BLOCKDEV_BACKUP:
+        blockdev_backup_action(act->u.blockdev_backup.data,
+                               block_job_txn, tran, errp);
+        return;
+    case TRANSACTION_ACTION_KIND_ABORT:
+        abort_action(tran, errp);
+        return;
+    case TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT_INTERNAL_SYNC:
+        internal_snapshot_action(act->u.blockdev_snapshot_internal_sync.data,
+                                 tran, errp);
+        return;
+    case TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_ADD:
+        block_dirty_bitmap_add_action(act->u.block_dirty_bitmap_add.data,
+                                      tran, errp);
+        return;
+    case TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_CLEAR:
+        block_dirty_bitmap_clear_action(act->u.block_dirty_bitmap_clear.data,
+                                        tran, errp);
+        return;
+    case TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_ENABLE:
+        block_dirty_bitmap_enable_action(act->u.block_dirty_bitmap_enable.data,
+                                         tran, errp);
+        return;
+    case TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_DISABLE:
+        block_dirty_bitmap_disable_action(
+                act->u.block_dirty_bitmap_disable.data, tran, errp);
+        return;
+    case TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_MERGE:
+        block_dirty_bitmap_merge_action(act->u.block_dirty_bitmap_merge.data,
+                                        tran, errp);
+        return;
+    case TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_REMOVE:
+        block_dirty_bitmap_remove_action(act->u.block_dirty_bitmap_remove.data,
+                                         tran, errp);
+        return;
+    /*
+     * Where are transactions for MIRROR, COMMIT and STREAM?
      * Although these blockjobs use transaction callbacks like the backup job,
      * these jobs do not necessarily adhere to transaction semantics.
      * These jobs may not fully undo all of their actions on abort, nor do they
      * necessarily work in transactions with more than one job in them.
      */
-};
+    case TRANSACTION_ACTION_KIND__MAX:
+    default:
+        g_assert_not_reached();
+    };
+}
+
 
 /*
  * 'Atomic' group operations.  The operations are performed as a set, and if
@@ -2345,21 +2264,7 @@ void qmp_transaction(TransactionActionList *actions,
 
     /* We don't do anything in this loop that commits us to the operations */
     for (act = actions; act; act = act->next) {
-        TransactionAction *dev_info = act->value;
-        const BlkActionOps *ops;
-        BlkActionState *state;
-
-        assert(dev_info->type < ARRAY_SIZE(actions_map));
-
-        ops = &actions_map[dev_info->type];
-        assert(ops->instance_size > 0);
-
-        state = g_malloc0(ops->instance_size);
-        state->ops = ops;
-        state->action = dev_info;
-        state->block_job_txn = block_job_txn;
-
-        state->ops->action(state, tran, &local_err);
+        transaction_action(act->value, block_job_txn, tran, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             goto delete_and_fail;
-- 
2.40.1


