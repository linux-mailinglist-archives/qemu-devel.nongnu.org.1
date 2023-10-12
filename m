Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0F57C726D
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:24:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqyTK-0003tf-7E; Thu, 12 Oct 2023 12:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqyTA-0003pO-AV
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySl-0000gP-En
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697127782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HNwosY+GbpV2B2QbA/CnOm/xc+b/NkSMjvFgxn3SKl4=;
 b=UpjjA2maAQJ1IBuFD3TH5uoW4rwSuTsv1eP0o1QnWRhymphgmDPAvtG/GHczBTlN/Xowce
 Zy0uMzPM3QkVFNYcHECYb9r8nnv/fODCV4v4D3itluuQCzOH4pUotq34wuTc60i1ExyTaU
 MfykPCH+wyE9xwwYxcXKdUVlWWYne/o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-YDeuZMzxPimY_NGU3cadYw-1; Thu, 12 Oct 2023 12:22:42 -0400
X-MC-Unique: YDeuZMzxPimY_NGU3cadYw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 268F23810791;
 Thu, 12 Oct 2023 16:22:42 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8945F20296DB;
 Thu, 12 Oct 2023 16:22:41 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 08/26] block: Mark bdrv_first_blk() and bdrv_is_root_node()
 GRAPH_RDLOCK
Date: Thu, 12 Oct 2023 18:22:06 +0200
Message-ID: <20231012162224.240535-9-kwolf@redhat.com>
In-Reply-To: <20231012162224.240535-1-kwolf@redhat.com>
References: <20231012162224.240535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
bdrv_first_blk() and bdrv_is_root_node() need to hold a reader lock
for the graph. These functions are the only functions in block-backend.c
that access the parent list of a node.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20230929145157.45443-5-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-global-state.h          |  9 +++++----
 include/sysemu/block-backend-global-state.h |  4 ++--
 block.c                                     |  1 +
 block/block-backend.c                       |  6 +++++-
 block/export/export.c                       |  4 ++++
 block/io.c                                  |  1 +
 block/monitor/block-hmp-cmds.c              |  2 ++
 block/qapi-sysemu.c                         |  2 ++
 block/replication.c                         | 10 ++++++++--
 block/snapshot.c                            | 15 +++++++++++----
 blockdev.c                                  |  5 +++++
 migration/block.c                           |  2 ++
 migration/migration-hmp-cmds.c              |  2 ++
 tests/unit/test-block-iothread.c            |  3 +++
 14 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index 6061220a6c..505a0d0c11 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -170,9 +170,10 @@ BlockDriverState * GRAPH_RDLOCK
 check_to_replace_node(BlockDriverState *parent_bs, const char *node_name,
                       Error **errp);
 
-int no_coroutine_fn bdrv_activate(BlockDriverState *bs, Error **errp);
+int no_coroutine_fn GRAPH_RDLOCK
+bdrv_activate(BlockDriverState *bs, Error **errp);
 
-int coroutine_fn no_co_wrapper
+int coroutine_fn no_co_wrapper_bdrv_rdlock
 bdrv_co_activate(BlockDriverState *bs, Error **errp);
 
 void bdrv_activate_all(Error **errp);
@@ -208,8 +209,8 @@ typedef struct BdrvNextIterator {
     BlockDriverState *bs;
 } BdrvNextIterator;
 
-BlockDriverState *bdrv_first(BdrvNextIterator *it);
-BlockDriverState *bdrv_next(BdrvNextIterator *it);
+BlockDriverState * GRAPH_RDLOCK bdrv_first(BdrvNextIterator *it);
+BlockDriverState * GRAPH_RDLOCK bdrv_next(BdrvNextIterator *it);
 void bdrv_next_cleanup(BdrvNextIterator *it);
 
 BlockDriverState *bdrv_next_monitor_owned(BlockDriverState *bs);
diff --git a/include/sysemu/block-backend-global-state.h b/include/sysemu/block-backend-global-state.h
index d5f675493a..49c12b0fa9 100644
--- a/include/sysemu/block-backend-global-state.h
+++ b/include/sysemu/block-backend-global-state.h
@@ -59,8 +59,8 @@ BlockBackend *blk_by_public(BlockBackendPublic *public);
 void blk_remove_bs(BlockBackend *blk);
 int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp);
 int blk_replace_bs(BlockBackend *blk, BlockDriverState *new_bs, Error **errp);
-bool bdrv_has_blk(BlockDriverState *bs);
-bool bdrv_is_root_node(BlockDriverState *bs);
+bool GRAPH_RDLOCK bdrv_has_blk(BlockDriverState *bs);
+bool GRAPH_RDLOCK bdrv_is_root_node(BlockDriverState *bs);
 int GRAPH_UNLOCKED blk_set_perm(BlockBackend *blk, uint64_t perm,
                                 uint64_t shared_perm, Error **errp);
 void blk_get_perm(BlockBackend *blk, uint64_t *perm, uint64_t *shared_perm);
diff --git a/block.c b/block.c
index b62f6f3841..701f77fe2f 100644
--- a/block.c
+++ b/block.c
@@ -6961,6 +6961,7 @@ void bdrv_activate_all(Error **errp)
     BdrvNextIterator it;
 
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         AioContext *aio_context = bdrv_get_aio_context(bs);
diff --git a/block/block-backend.c b/block/block-backend.c
index efe2e7cbf8..39b5f90a11 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -780,11 +780,12 @@ BlockDriverState *blk_bs(BlockBackend *blk)
     return blk->root ? blk->root->bs : NULL;
 }
 
-static BlockBackend *bdrv_first_blk(BlockDriverState *bs)
+static BlockBackend * GRAPH_RDLOCK bdrv_first_blk(BlockDriverState *bs)
 {
     BdrvChild *child;
 
     GLOBAL_STATE_CODE();
+    assert_bdrv_graph_readable();
 
     QLIST_FOREACH(child, &bs->parents, next_parent) {
         if (child->klass == &child_root) {
@@ -812,6 +813,8 @@ bool bdrv_is_root_node(BlockDriverState *bs)
     BdrvChild *c;
 
     GLOBAL_STATE_CODE();
+    assert_bdrv_graph_readable();
+
     QLIST_FOREACH(c, &bs->parents, next_parent) {
         if (c->klass != &child_root) {
             return false;
@@ -2259,6 +2262,7 @@ void blk_activate(BlockBackend *blk, Error **errp)
     if (qemu_in_coroutine()) {
         bdrv_co_activate(bs, errp);
     } else {
+        GRAPH_RDLOCK_GUARD_MAINLOOP();
         bdrv_activate(bs, errp);
     }
 }
diff --git a/block/export/export.c b/block/export/export.c
index 10316b43c5..a8f274e526 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -83,6 +83,8 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
     uint64_t perm;
     int ret;
 
+    GLOBAL_STATE_CODE();
+
     if (!id_wellformed(export->id)) {
         error_setg(errp, "Invalid block export id");
         return NULL;
@@ -145,7 +147,9 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
      * access since the export could be available before migration handover.
      * ctx was acquired in the caller.
      */
+    bdrv_graph_rdlock_main_loop();
     bdrv_activate(bs, NULL);
+    bdrv_graph_rdunlock_main_loop();
 
     perm = BLK_PERM_CONSISTENT_READ;
     if (export->writable) {
diff --git a/block/io.c b/block/io.c
index 9e170929a7..5821a4d1f5 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2330,6 +2330,7 @@ int bdrv_flush_all(void)
     int result = 0;
 
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     /*
      * bdrv queue is managed by record/replay,
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index ca2599de44..6b7d7dd072 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -896,6 +896,8 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
     SnapshotEntry *snapshot_entry;
     Error *err = NULL;
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     bs = bdrv_all_find_vmstate_bs(NULL, false, NULL, &err);
     if (!bs) {
         error_report_err(err);
diff --git a/block/qapi-sysemu.c b/block/qapi-sysemu.c
index ef07151892..e885a64c32 100644
--- a/block/qapi-sysemu.c
+++ b/block/qapi-sysemu.c
@@ -279,6 +279,8 @@ static void blockdev_insert_medium(const char *device, const char *id,
     BlockBackend *blk;
     BlockDriverState *bs;
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     blk = qmp_get_blk(device, id, errp);
     if (!blk) {
         return;
diff --git a/block/replication.c b/block/replication.c
index 4ad3dd5115..107445d0ce 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -458,6 +458,8 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
     Error *local_err = NULL;
     BackupPerf perf = { .use_copy_range = true, .max_workers = 1 };
 
+    GLOBAL_STATE_CODE();
+
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
     s = bs->opaque;
@@ -504,12 +506,15 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
             return;
         }
 
+        bdrv_graph_rdlock_main_loop();
         secondary_disk = hidden_disk->bs->backing;
         if (!secondary_disk->bs || !bdrv_has_blk(secondary_disk->bs)) {
             error_setg(errp, "The secondary disk doesn't have block backend");
+            bdrv_graph_rdunlock_main_loop();
             aio_context_release(aio_context);
             return;
         }
+        bdrv_graph_rdunlock_main_loop();
 
         /* verify the length */
         active_length = bdrv_getlength(active_disk->bs);
@@ -566,8 +571,6 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
             return;
         }
 
-        bdrv_graph_wrunlock();
-
         /* start backup job now */
         error_setg(&s->blocker,
                    "Block device is in use by internal backup job");
@@ -576,6 +579,7 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
         if (!top_bs || !bdrv_is_root_node(top_bs) ||
             !check_top_bs(top_bs, bs)) {
             error_setg(errp, "No top_bs or it is invalid");
+            bdrv_graph_wrunlock();
             reopen_backing_file(bs, false, NULL);
             aio_context_release(aio_context);
             return;
@@ -583,6 +587,8 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
         bdrv_op_block_all(top_bs, s->blocker);
         bdrv_op_unblock(top_bs, BLOCK_OP_TYPE_DATAPLANE, s->blocker);
 
+        bdrv_graph_wrunlock();
+
         s->backup_job = backup_job_create(
                                 NULL, s->secondary_disk->bs, s->hidden_disk->bs,
                                 0, MIRROR_SYNC_MODE_NONE, NULL, 0, false, NULL,
diff --git a/block/snapshot.c b/block/snapshot.c
index b86b5b24ad..633391e8a9 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -462,9 +462,9 @@ int bdrv_snapshot_load_tmp_by_id_or_name(BlockDriverState *bs,
 }
 
 
-static int bdrv_all_get_snapshot_devices(bool has_devices, strList *devices,
-                                         GList **all_bdrvs,
-                                         Error **errp)
+static int GRAPH_RDLOCK
+bdrv_all_get_snapshot_devices(bool has_devices, strList *devices,
+                              GList **all_bdrvs, Error **errp)
 {
     g_autoptr(GList) bdrvs = NULL;
 
@@ -496,7 +496,7 @@ static int bdrv_all_get_snapshot_devices(bool has_devices, strList *devices,
 }
 
 
-static bool bdrv_all_snapshots_includes_bs(BlockDriverState *bs)
+static bool GRAPH_RDLOCK bdrv_all_snapshots_includes_bs(BlockDriverState *bs)
 {
     if (!bdrv_is_inserted(bs) || bdrv_is_read_only(bs)) {
         return false;
@@ -518,6 +518,7 @@ bool bdrv_all_can_snapshot(bool has_devices, strList *devices,
     GList *iterbdrvs;
 
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     if (bdrv_all_get_snapshot_devices(has_devices, devices, &bdrvs, errp) < 0) {
         return false;
@@ -554,6 +555,7 @@ int bdrv_all_delete_snapshot(const char *name,
     GList *iterbdrvs;
 
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     if (bdrv_all_get_snapshot_devices(has_devices, devices, &bdrvs, errp) < 0) {
         return -1;
@@ -595,6 +597,7 @@ int bdrv_all_goto_snapshot(const char *name,
     GList *iterbdrvs;
 
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     if (bdrv_all_get_snapshot_devices(has_devices, devices, &bdrvs, errp) < 0) {
         return -1;
@@ -631,6 +634,7 @@ int bdrv_all_has_snapshot(const char *name,
     GList *iterbdrvs;
 
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     if (bdrv_all_get_snapshot_devices(has_devices, devices, &bdrvs, errp) < 0) {
         return -1;
@@ -673,7 +677,9 @@ int bdrv_all_create_snapshot(QEMUSnapshotInfo *sn,
 {
     g_autoptr(GList) bdrvs = NULL;
     GList *iterbdrvs;
+
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     if (bdrv_all_get_snapshot_devices(has_devices, devices, &bdrvs, errp) < 0) {
         return -1;
@@ -715,6 +721,7 @@ BlockDriverState *bdrv_all_find_vmstate_bs(const char *vmstate_bs,
     GList *iterbdrvs;
 
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     if (bdrv_all_get_snapshot_devices(has_devices, devices, &bdrvs, errp) < 0) {
         return NULL;
diff --git a/blockdev.c b/blockdev.c
index 325b7a3bef..b6b7c44288 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1041,6 +1041,8 @@ static BlockDriverState *qmp_get_root_bs(const char *name, Error **errp)
     BlockDriverState *bs;
     AioContext *aio_context;
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     bs = bdrv_lookup_bs(name, name, errp);
     if (bs == NULL) {
         return NULL;
@@ -3509,6 +3511,7 @@ void qmp_blockdev_del(const char *node_name, Error **errp)
     BlockDriverState *bs;
 
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     bs = bdrv_find_node(node_name);
     if (!bs) {
@@ -3636,6 +3639,8 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
     AioContext *new_context;
     BlockDriverState *bs;
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     bs = bdrv_find_node(node_name);
     if (!bs) {
         error_setg(errp, "Failed to find node with node-name='%s'", node_name);
diff --git a/migration/block.c b/migration/block.c
index 5f930870a5..d115e1cfa5 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -388,6 +388,8 @@ static int init_blk_migration(QEMUFile *f)
     Error *local_err = NULL;
     int ret;
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     block_mig_state.submitted = 0;
     block_mig_state.read_done = 0;
     block_mig_state.transferred = 0;
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index c115ef2d23..5b25ba24f7 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -794,6 +794,8 @@ static void vm_completion(ReadLineState *rs, const char *str)
     BlockDriverState *bs;
     BdrvNextIterator it;
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     len = strlen(str);
     readline_set_completion_index(rs, len);
 
diff --git a/tests/unit/test-block-iothread.c b/tests/unit/test-block-iothread.c
index 9155547313..151049bda5 100644
--- a/tests/unit/test-block-iothread.c
+++ b/tests/unit/test-block-iothread.c
@@ -383,6 +383,9 @@ static void test_sync_op_check(BdrvChild *c)
 
 static void test_sync_op_activate(BdrvChild *c)
 {
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     /* Early success: Image is not inactive */
     bdrv_activate(c->bs, NULL);
 }
-- 
2.41.0


