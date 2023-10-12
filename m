Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 968737C726C
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:24:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqyT2-0003kk-MV; Thu, 12 Oct 2023 12:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySz-0003jg-QC
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySg-0000dz-GQ
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697127776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B4J4aZoJ1boonYFeBWY+ige7+vNUsnok3K/n42FY/qE=;
 b=B0FUCOXxX5WYHVpcSnzQby+prOYdSprC8vdP4SnKR+sIpQXzsRBat3kMhCQrAr5NyUoc5h
 CR60h+4uxq6WAJJ5F3cOBls2Op116CA27aEL5pZ5ok7JJvK9w6A08sj5vSDhyP1Kencm/i
 xlwVt/4I9LXyizfUv6W9EBnelKoSgxo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-CveZD598N3CvjsIGR7m1sA-1; Thu, 12 Oct 2023 12:22:49 -0400
X-MC-Unique: CveZD598N3CvjsIGR7m1sA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DC5E3810791;
 Thu, 12 Oct 2023 16:22:48 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0DC1320296DB;
 Thu, 12 Oct 2023 16:22:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 16/26] block: Mark bdrv_get_parent_name() and callers
 GRAPH_RDLOCK
Date: Thu, 12 Oct 2023 18:22:14 +0200
Message-ID: <20231012162224.240535-17-kwolf@redhat.com>
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
bdrv_get_parent_name() need to hold a reader lock for the graph
because it accesses the parents list of a node.

For some places, we know that they will hold the lock, but we don't have
the GRAPH_RDLOCK annotations yet. In this case, add assume_graph_lock()
with a FIXME comment. These places will be removed once everything is
properly annotated.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20230929145157.45443-13-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.h                |  7 +++----
 include/block/block-io.h     |  8 ++++++--
 include/block/block_int-io.h |  2 +-
 include/block/qapi.h         |  7 ++++---
 block.c                      | 14 ++++++++++++--
 block/backup.c               |  1 +
 block/parallels.c            |  3 +++
 block/qcow.c                 |  3 +++
 block/qcow2-bitmap.c         |  2 ++
 block/qcow2.c                |  4 ++++
 block/quorum.c               |  4 ++--
 block/rbd.c                  |  2 ++
 block/snapshot.c             |  3 +++
 block/vdi.c                  |  3 +++
 block/vpc.c                  |  3 +++
 block/vvfat.c                |  2 ++
 blockjob.c                   |  1 +
 17 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index f789ce3ae0..359bfca4aa 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -1003,10 +1003,9 @@ int coroutine_fn qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp
 bool qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
                                           bool release_stored, Error **errp);
 int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
-bool coroutine_fn qcow2_co_can_store_new_dirty_bitmap(BlockDriverState *bs,
-                                                      const char *name,
-                                                      uint32_t granularity,
-                                                      Error **errp);
+bool coroutine_fn GRAPH_RDLOCK
+qcow2_co_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
+                                    uint32_t granularity, Error **errp);
 int coroutine_fn qcow2_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
                                                          const char *name,
                                                          Error **errp);
diff --git a/include/block/block-io.h b/include/block/block-io.h
index 9707eb3eff..2c0c7b1906 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -183,8 +183,12 @@ const char *bdrv_get_format_name(BlockDriverState *bs);
 
 bool bdrv_supports_compressed_writes(BlockDriverState *bs);
 const char *bdrv_get_node_name(const BlockDriverState *bs);
-const char *bdrv_get_device_name(const BlockDriverState *bs);
-const char *bdrv_get_device_or_node_name(const BlockDriverState *bs);
+
+const char * GRAPH_RDLOCK
+bdrv_get_device_name(const BlockDriverState *bs);
+
+const char * GRAPH_RDLOCK
+bdrv_get_device_or_node_name(const BlockDriverState *bs);
 
 int coroutine_fn GRAPH_RDLOCK
 bdrv_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi);
diff --git a/include/block/block_int-io.h b/include/block/block_int-io.h
index 2b6004ab93..34eac72d7a 100644
--- a/include/block/block_int-io.h
+++ b/include/block/block_int-io.h
@@ -99,7 +99,7 @@ BlockDriver *bdrv_probe_all(const uint8_t *buf, int buf_size,
  */
 void bdrv_wakeup(BlockDriverState *bs);
 
-const char *bdrv_get_parent_name(const BlockDriverState *bs);
+const char * GRAPH_RDLOCK bdrv_get_parent_name(const BlockDriverState *bs);
 bool blk_dev_has_tray(BlockBackend *blk);
 bool blk_dev_is_tray_open(BlockBackend *blk);
 
diff --git a/include/block/qapi.h b/include/block/qapi.h
index 887235653a..54c48de26a 100644
--- a/include/block/qapi.h
+++ b/include/block/qapi.h
@@ -33,9 +33,10 @@ BlockDeviceInfo * GRAPH_RDLOCK
 bdrv_block_device_info(BlockBackend *blk, BlockDriverState *bs,
                        bool flat, Error **errp);
 
-int bdrv_query_snapshot_info_list(BlockDriverState *bs,
-                                  SnapshotInfoList **p_list,
-                                  Error **errp);
+int GRAPH_RDLOCK
+bdrv_query_snapshot_info_list(BlockDriverState *bs,
+                              SnapshotInfoList **p_list,
+                              Error **errp);
 void GRAPH_RDLOCK
 bdrv_query_image_info(BlockDriverState *bs, ImageInfo **p_info, bool flat,
                       bool skip_implicit_filters, Error **errp);
diff --git a/block.c b/block.c
index 6ce3e2ad7a..c932dc0a51 100644
--- a/block.c
+++ b/block.c
@@ -279,8 +279,9 @@ bool bdrv_is_read_only(BlockDriverState *bs)
     return !(bs->open_flags & BDRV_O_RDWR);
 }
 
-static int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only,
-                                  bool ignore_allow_rdw, Error **errp)
+static int GRAPH_RDLOCK
+bdrv_can_set_read_only(BlockDriverState *bs, bool read_only,
+                       bool ignore_allow_rdw, Error **errp)
 {
     IO_CODE();
 
@@ -319,6 +320,8 @@ int bdrv_apply_auto_read_only(BlockDriverState *bs, const char *errmsg,
     int ret = 0;
     IO_CODE();
 
+    assume_graph_lock(); /* FIXME */
+
     if (!(bs->open_flags & BDRV_O_RDWR)) {
         return 0;
     }
@@ -4950,7 +4953,10 @@ bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
      * to r/w. Attempting to set to r/w may fail if either BDRV_O_ALLOW_RDWR is
      * not set, or if the BDS still has copy_on_read enabled */
     read_only = !(reopen_state->flags & BDRV_O_RDWR);
+
+    bdrv_graph_rdlock_main_loop();
     ret = bdrv_can_set_read_only(reopen_state->bs, read_only, true, &local_err);
+    bdrv_graph_rdunlock_main_loop();
     if (local_err) {
         error_propagate(errp, local_err);
         goto error;
@@ -4984,9 +4990,11 @@ bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
     } else {
         /* It is currently mandatory to have a bdrv_reopen_prepare()
          * handler for each supported drv. */
+        bdrv_graph_rdlock_main_loop();
         error_setg(errp, "Block format '%s' used by node '%s' "
                    "does not support reopening files", drv->format_name,
                    bdrv_get_device_or_node_name(reopen_state->bs));
+        bdrv_graph_rdunlock_main_loop();
         ret = -1;
         goto error;
     }
@@ -7242,6 +7250,8 @@ bool bdrv_op_is_blocked(BlockDriverState *bs, BlockOpType op, Error **errp)
 {
     BdrvOpBlocker *blocker;
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     assert((int) op >= 0 && op < BLOCK_OP_TYPE_MAX);
     if (!QLIST_EMPTY(&bs->op_blockers[op])) {
         blocker = QLIST_FIRST(&bs->op_blockers[op]);
diff --git a/block/backup.c b/block/backup.c
index db3791f4d1..9a3c4bdc82 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -374,6 +374,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     assert(bs);
     assert(target);
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     /* QMP interface protects us from these cases */
     assert(sync_mode != MIRROR_SYNC_MODE_INCREMENTAL);
diff --git a/block/parallels.c b/block/parallels.c
index d026ce9e2f..6b46623241 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1363,9 +1363,12 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         bitmap_new(DIV_ROUND_UP(s->header_size, s->bat_dirty_block));
 
     /* Disable migration until bdrv_activate method is added */
+    bdrv_graph_rdlock_main_loop();
     error_setg(&s->migration_blocker, "The Parallels format used by node '%s' "
                "does not support live migration",
                bdrv_get_device_or_node_name(bs));
+    bdrv_graph_rdunlock_main_loop();
+
     ret = migrate_add_blocker(s->migration_blocker, errp);
     if (ret < 0) {
         error_setg(errp, "Migration blocker error");
diff --git a/block/qcow.c b/block/qcow.c
index d56d24ab6d..38a16253b8 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -301,9 +301,12 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     /* Disable migration when qcow images are used */
+    bdrv_graph_rdlock_main_loop();
     error_setg(&s->migration_blocker, "The qcow format used by node '%s' "
                "does not support live migration",
                bdrv_get_device_or_node_name(bs));
+    bdrv_graph_rdunlock_main_loop();
+
     ret = migrate_add_blocker(s->migration_blocker, errp);
     if (ret < 0) {
         error_free(s->migration_blocker);
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index ffd5cd3b23..03dd91dfac 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -166,6 +166,8 @@ static int check_constraints_on_bitmap(BlockDriverState *bs,
     int64_t len = bdrv_getlength(bs);
     int64_t bitmap_bytes;
 
+    assume_graph_lock(); /* FIXME */
+
     assert(granularity > 0);
     assert((granularity & (granularity - 1)) == 0);
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 6e9c731bac..4780cb9148 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2737,6 +2737,8 @@ static int qcow2_inactivate(BlockDriverState *bs)
     int ret, result = 0;
     Error *local_err = NULL;
 
+    assume_graph_lock(); /* FIXME */
+
     qcow2_store_persistent_dirty_bitmaps(bs, true, &local_err);
     if (local_err != NULL) {
         result = -EINVAL;
@@ -5945,6 +5947,8 @@ void qcow2_signal_corruption(BlockDriverState *bs, bool fatal, int64_t offset,
     char *message;
     va_list ap;
 
+    assume_graph_lock(); /* FIXME */
+
     fatal = fatal && bdrv_is_writable(bs);
 
     if (s->signaled_corruption &&
diff --git a/block/quorum.c b/block/quorum.c
index 05220cab7f..d3ffc2ee33 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -206,7 +206,7 @@ static void quorum_report_bad(QuorumOpType type, uint64_t offset,
                                       end_sector - start_sector);
 }
 
-static void quorum_report_failure(QuorumAIOCB *acb)
+static void GRAPH_RDLOCK quorum_report_failure(QuorumAIOCB *acb)
 {
     const char *reference = bdrv_get_device_or_node_name(acb->bs);
     int64_t start_sector = acb->offset / BDRV_SECTOR_SIZE;
@@ -219,7 +219,7 @@ static void quorum_report_failure(QuorumAIOCB *acb)
 
 static int quorum_vote_error(QuorumAIOCB *acb);
 
-static bool quorum_has_too_much_io_failed(QuorumAIOCB *acb)
+static bool GRAPH_RDLOCK quorum_has_too_much_io_failed(QuorumAIOCB *acb)
 {
     BDRVQuorumState *s = acb->bs->opaque;
 
diff --git a/block/rbd.c b/block/rbd.c
index 472ca05cba..073bc92e39 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1208,6 +1208,8 @@ static int qemu_rbd_reopen_prepare(BDRVReopenState *state,
     BDRVRBDState *s = state->bs->opaque;
     int ret = 0;
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     if (s->snap && state->flags & BDRV_O_RDWR) {
         error_setg(errp,
                    "Cannot change node '%s' to r/w when using RBD snapshot",
diff --git a/block/snapshot.c b/block/snapshot.c
index ad2bf6e068..6e16eb803a 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -432,6 +432,7 @@ int bdrv_snapshot_load_tmp(BlockDriverState *bs,
     BlockDriver *drv = bs->drv;
 
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     if (!drv) {
         error_setg(errp, QERR_DEVICE_HAS_NO_MEDIUM, bdrv_get_device_name(bs));
@@ -641,8 +642,10 @@ int bdrv_all_goto_snapshot(const char *name,
         }
         aio_context_release(ctx);
         if (ret < 0) {
+            bdrv_graph_rdlock_main_loop();
             error_prepend(errp, "Could not load snapshot '%s' on '%s': ",
                           name, bdrv_get_device_or_node_name(bs));
+            bdrv_graph_rdunlock_main_loop();
             return -1;
         }
 
diff --git a/block/vdi.c b/block/vdi.c
index 934e1b849b..3ed43b6f35 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -492,9 +492,12 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     /* Disable migration when vdi images are used */
+    bdrv_graph_rdlock_main_loop();
     error_setg(&s->migration_blocker, "The vdi format used by node '%s' "
                "does not support live migration",
                bdrv_get_device_or_node_name(bs));
+    bdrv_graph_rdunlock_main_loop();
+
     ret = migrate_add_blocker(s->migration_blocker, errp);
     if (ret < 0) {
         error_free(s->migration_blocker);
diff --git a/block/vpc.c b/block/vpc.c
index ceb87dd3d8..945847fe4a 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -446,9 +446,12 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     /* Disable migration when VHD images are used */
+    bdrv_graph_rdlock_main_loop();
     error_setg(&s->migration_blocker, "The vpc format used by node '%s' "
                "does not support live migration",
                bdrv_get_device_or_node_name(bs));
+    bdrv_graph_rdunlock_main_loop();
+
     ret = migrate_add_blocker(s->migration_blocker, errp);
     if (ret < 0) {
         error_free(s->migration_blocker);
diff --git a/block/vvfat.c b/block/vvfat.c
index 1a3a64c713..b0415798c0 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1144,6 +1144,8 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
     QemuOpts *opts;
     int ret;
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
 #ifdef DEBUG
     vvv = s;
 #endif
diff --git a/blockjob.c b/blockjob.c
index 58c5d64539..807f992b59 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -485,6 +485,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     BlockJob *job;
     int ret;
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     if (job_id == NULL && !(flags & JOB_INTERNAL)) {
         job_id = bdrv_get_device_name(bs);
-- 
2.41.0


