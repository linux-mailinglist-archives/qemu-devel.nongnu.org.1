Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F79A7C7269
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:24:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqySu-0003e3-He; Thu, 12 Oct 2023 12:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySs-0003cN-Br
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySb-0000cc-5V
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697127772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bGuEPBSbkrZ/s8B4Iu/msTYXt+Rc7GOMpJpdhUt65EI=;
 b=XZZeGpWfm8DdZ+5H+9+4XFk4nWi2e5MqqmHmZfms2e4HCGQ1GTPpptuFMJ4nAEyITRWECt
 go/+x9127KPXits7txRFo7KeqJHKP9p6AnEsHdaBg+Wl5RDRdDHQ3xl02dPtVKqiUtqKd0
 vvOfUbKb5DzEXw3OWMMrvqiLAZmvHEQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-LeC-tgL6PmGWT7etCeBs0g-1; Thu, 12 Oct 2023 12:22:50 -0400
X-MC-Unique: LeC-tgL6PmGWT7etCeBs0g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C20885A5BF;
 Thu, 12 Oct 2023 16:22:50 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6F32202701E;
 Thu, 12 Oct 2023 16:22:49 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 18/26] qcow2: Mark qcow2_signal_corruption() and callers
 GRAPH_RDLOCK
Date: Thu, 12 Oct 2023 18:22:16 +0200
Message-ID: <20231012162224.240535-19-kwolf@redhat.com>
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
qcow2_signal_corruption() need to hold a reader lock for the graph
because it calls bdrv_get_node_name(), which accesses the parents list
of a node.

For some places, we know that they will hold the lock, but we don't have
the GRAPH_RDLOCK annotations yet. In this case, add assume_graph_lock()
with a FIXME comment. These places will be removed once everything is
properly annotated.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20230929145157.45443-15-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.h                      | 180 +++++++++++++++++------------
 include/block/block-global-state.h |   2 +-
 include/block/block_int-common.h   |   2 +-
 block.c                            |   3 +-
 block/block-backend.c              |   2 +
 block/qcow2-bitmap.c               |  31 ++---
 block/qcow2-cache.c                |  11 +-
 block/qcow2-cluster.c              |  62 +++++-----
 block/qcow2-refcount.c             |  80 ++++++-------
 block/qcow2.c                      |  61 +++++-----
 block/replication.c                |   8 +-
 11 files changed, 250 insertions(+), 192 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 359bfca4aa..29958c512b 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -838,9 +838,10 @@ int qcow2_mark_dirty(BlockDriverState *bs);
 int qcow2_mark_corrupt(BlockDriverState *bs);
 int qcow2_update_header(BlockDriverState *bs);
 
-void qcow2_signal_corruption(BlockDriverState *bs, bool fatal, int64_t offset,
-                             int64_t size, const char *message_format, ...)
-                             G_GNUC_PRINTF(5, 6);
+void GRAPH_RDLOCK
+qcow2_signal_corruption(BlockDriverState *bs, bool fatal, int64_t offset,
+                        int64_t size, const char *message_format, ...)
+                        G_GNUC_PRINTF(5, 6);
 
 int qcow2_validate_table(BlockDriverState *bs, uint64_t offset,
                          uint64_t entries, size_t entry_len,
@@ -851,33 +852,41 @@ int qcow2_validate_table(BlockDriverState *bs, uint64_t offset,
 int coroutine_fn GRAPH_RDLOCK qcow2_refcount_init(BlockDriverState *bs);
 void qcow2_refcount_close(BlockDriverState *bs);
 
-int qcow2_get_refcount(BlockDriverState *bs, int64_t cluster_index,
-                       uint64_t *refcount);
+int GRAPH_RDLOCK qcow2_get_refcount(BlockDriverState *bs, int64_t cluster_index,
+                                    uint64_t *refcount);
 
-int qcow2_update_cluster_refcount(BlockDriverState *bs, int64_t cluster_index,
-                                  uint64_t addend, bool decrease,
-                                  enum qcow2_discard_type type);
+int GRAPH_RDLOCK
+qcow2_update_cluster_refcount(BlockDriverState *bs, int64_t cluster_index,
+                              uint64_t addend, bool decrease,
+                              enum qcow2_discard_type type);
 
-int64_t qcow2_refcount_area(BlockDriverState *bs, uint64_t offset,
-                            uint64_t additional_clusters, bool exact_size,
-                            int new_refblock_index,
-                            uint64_t new_refblock_offset);
+int64_t GRAPH_RDLOCK
+qcow2_refcount_area(BlockDriverState *bs, uint64_t offset,
+                    uint64_t additional_clusters, bool exact_size,
+                    int new_refblock_index,
+                    uint64_t new_refblock_offset);
 
-int64_t qcow2_alloc_clusters(BlockDriverState *bs, uint64_t size);
-int64_t coroutine_fn qcow2_alloc_clusters_at(BlockDriverState *bs, uint64_t offset,
-                                             int64_t nb_clusters);
-int64_t coroutine_fn GRAPH_RDLOCK qcow2_alloc_bytes(BlockDriverState *bs, int size);
-void qcow2_free_clusters(BlockDriverState *bs,
-                          int64_t offset, int64_t size,
-                          enum qcow2_discard_type type);
-void qcow2_free_any_cluster(BlockDriverState *bs, uint64_t l2_entry,
-                            enum qcow2_discard_type type);
+int64_t GRAPH_RDLOCK
+qcow2_alloc_clusters(BlockDriverState *bs, uint64_t size);
 
-int qcow2_update_snapshot_refcount(BlockDriverState *bs,
-    int64_t l1_table_offset, int l1_size, int addend);
+int64_t GRAPH_RDLOCK coroutine_fn
+qcow2_alloc_clusters_at(BlockDriverState *bs, uint64_t offset,
+                        int64_t nb_clusters);
 
-int qcow2_flush_caches(BlockDriverState *bs);
-int qcow2_write_caches(BlockDriverState *bs);
+int64_t coroutine_fn GRAPH_RDLOCK qcow2_alloc_bytes(BlockDriverState *bs, int size);
+void GRAPH_RDLOCK qcow2_free_clusters(BlockDriverState *bs,
+                                      int64_t offset, int64_t size,
+                                      enum qcow2_discard_type type);
+void GRAPH_RDLOCK
+qcow2_free_any_cluster(BlockDriverState *bs, uint64_t l2_entry,
+                       enum qcow2_discard_type type);
+
+int GRAPH_RDLOCK
+qcow2_update_snapshot_refcount(BlockDriverState *bs, int64_t l1_table_offset,
+                               int l1_size, int addend);
+
+int GRAPH_RDLOCK qcow2_flush_caches(BlockDriverState *bs);
+int GRAPH_RDLOCK qcow2_write_caches(BlockDriverState *bs);
 int coroutine_fn qcow2_check_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                                        BdrvCheckMode fix);
 
@@ -885,39 +894,48 @@ void qcow2_process_discards(BlockDriverState *bs, int ret);
 
 int qcow2_check_metadata_overlap(BlockDriverState *bs, int ign, int64_t offset,
                                  int64_t size);
-int qcow2_pre_write_overlap_check(BlockDriverState *bs, int ign, int64_t offset,
-                                  int64_t size, bool data_file);
+int GRAPH_RDLOCK
+qcow2_pre_write_overlap_check(BlockDriverState *bs, int ign, int64_t offset,
+                              int64_t size, bool data_file);
+
 int coroutine_fn qcow2_inc_refcounts_imrt(BlockDriverState *bs, BdrvCheckResult *res,
                                           void **refcount_table,
                                           int64_t *refcount_table_size,
                                           int64_t offset, int64_t size);
 
-int qcow2_change_refcount_order(BlockDriverState *bs, int refcount_order,
-                                BlockDriverAmendStatusCB *status_cb,
-                                void *cb_opaque, Error **errp);
+int GRAPH_RDLOCK
+qcow2_change_refcount_order(BlockDriverState *bs, int refcount_order,
+                            BlockDriverAmendStatusCB *status_cb,
+                            void *cb_opaque, Error **errp);
 int coroutine_fn GRAPH_RDLOCK qcow2_shrink_reftable(BlockDriverState *bs);
-int64_t coroutine_fn qcow2_get_last_cluster(BlockDriverState *bs, int64_t size);
+
+int64_t coroutine_fn GRAPH_RDLOCK
+qcow2_get_last_cluster(BlockDriverState *bs, int64_t size);
 
 int coroutine_fn GRAPH_RDLOCK
 qcow2_detect_metadata_preallocation(BlockDriverState *bs);
 
 /* qcow2-cluster.c functions */
-int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
-                        bool exact_size);
+int GRAPH_RDLOCK
+qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size, bool exact_size);
 
 int coroutine_fn GRAPH_RDLOCK
 qcow2_shrink_l1_table(BlockDriverState *bs, uint64_t max_size);
 
-int qcow2_write_l1_entry(BlockDriverState *bs, int l1_index);
+int GRAPH_RDLOCK qcow2_write_l1_entry(BlockDriverState *bs, int l1_index);
 int qcow2_encrypt_sectors(BDRVQcow2State *s, int64_t sector_num,
                           uint8_t *buf, int nb_sectors, bool enc, Error **errp);
 
-int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
-                          unsigned int *bytes, uint64_t *host_offset,
-                          QCow2SubclusterType *subcluster_type);
-int coroutine_fn qcow2_alloc_host_offset(BlockDriverState *bs, uint64_t offset,
-                                         unsigned int *bytes,
-                                         uint64_t *host_offset, QCowL2Meta **m);
+int GRAPH_RDLOCK
+qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
+                      unsigned int *bytes, uint64_t *host_offset,
+                      QCow2SubclusterType *subcluster_type);
+
+int coroutine_fn GRAPH_RDLOCK
+qcow2_alloc_host_offset(BlockDriverState *bs, uint64_t offset,
+                        unsigned int *bytes, uint64_t *host_offset,
+                        QCowL2Meta **m);
+
 int coroutine_fn GRAPH_RDLOCK
 qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs, uint64_t offset,
                                       int compressed_size, uint64_t *host_offset);
@@ -927,26 +945,33 @@ void qcow2_parse_compressed_l2_entry(BlockDriverState *bs, uint64_t l2_entry,
 int coroutine_fn GRAPH_RDLOCK
 qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m);
 
-void coroutine_fn qcow2_alloc_cluster_abort(BlockDriverState *bs, QCowL2Meta *m);
-int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
-                          uint64_t bytes, enum qcow2_discard_type type,
-                          bool full_discard);
+void coroutine_fn GRAPH_RDLOCK
+qcow2_alloc_cluster_abort(BlockDriverState *bs, QCowL2Meta *m);
+
+int GRAPH_RDLOCK
+qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+                      enum qcow2_discard_type type, bool full_discard);
 
 int coroutine_fn GRAPH_RDLOCK
 qcow2_subcluster_zeroize(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
                          int flags);
 
-int qcow2_expand_zero_clusters(BlockDriverState *bs,
-                               BlockDriverAmendStatusCB *status_cb,
-                               void *cb_opaque);
+int GRAPH_RDLOCK
+qcow2_expand_zero_clusters(BlockDriverState *bs,
+                           BlockDriverAmendStatusCB *status_cb,
+                           void *cb_opaque);
 
 /* qcow2-snapshot.c functions */
-int qcow2_snapshot_create(BlockDriverState *bs, QEMUSnapshotInfo *sn_info);
-int qcow2_snapshot_goto(BlockDriverState *bs, const char *snapshot_id);
-int qcow2_snapshot_delete(BlockDriverState *bs,
-                          const char *snapshot_id,
-                          const char *name,
-                          Error **errp);
+int GRAPH_RDLOCK
+qcow2_snapshot_create(BlockDriverState *bs, QEMUSnapshotInfo *sn_info);
+
+int GRAPH_RDLOCK
+qcow2_snapshot_goto(BlockDriverState *bs, const char *snapshot_id);
+
+int GRAPH_RDLOCK
+qcow2_snapshot_delete(BlockDriverState *bs, const char *snapshot_id,
+                          const char *name, Error **errp);
+
 int qcow2_snapshot_list(BlockDriverState *bs, QEMUSnapshotInfo **psn_tab);
 int qcow2_snapshot_load_tmp(BlockDriverState *bs,
                             const char *snapshot_id,
@@ -956,15 +981,15 @@ int qcow2_snapshot_load_tmp(BlockDriverState *bs,
 void qcow2_free_snapshots(BlockDriverState *bs);
 int coroutine_fn GRAPH_RDLOCK
 qcow2_read_snapshots(BlockDriverState *bs, Error **errp);
-int qcow2_write_snapshots(BlockDriverState *bs);
+int GRAPH_RDLOCK qcow2_write_snapshots(BlockDriverState *bs);
 
 int coroutine_fn GRAPH_RDLOCK
 qcow2_check_read_snapshot_table(BlockDriverState *bs, BdrvCheckResult *result,
                                 BdrvCheckMode fix);
 
-int coroutine_fn qcow2_check_fix_snapshot_table(BlockDriverState *bs,
-                                                BdrvCheckResult *result,
-                                                BdrvCheckMode fix);
+int coroutine_fn GRAPH_RDLOCK
+qcow2_check_fix_snapshot_table(BlockDriverState *bs, BdrvCheckResult *result,
+                               BdrvCheckMode fix);
 
 /* qcow2-cache.c functions */
 Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables,
@@ -972,19 +997,23 @@ Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables,
 int qcow2_cache_destroy(Qcow2Cache *c);
 
 void qcow2_cache_entry_mark_dirty(Qcow2Cache *c, void *table);
-int qcow2_cache_flush(BlockDriverState *bs, Qcow2Cache *c);
-int qcow2_cache_write(BlockDriverState *bs, Qcow2Cache *c);
-int qcow2_cache_set_dependency(BlockDriverState *bs, Qcow2Cache *c,
-    Qcow2Cache *dependency);
+int GRAPH_RDLOCK qcow2_cache_flush(BlockDriverState *bs, Qcow2Cache *c);
+int GRAPH_RDLOCK qcow2_cache_write(BlockDriverState *bs, Qcow2Cache *c);
+int GRAPH_RDLOCK qcow2_cache_set_dependency(BlockDriverState *bs, Qcow2Cache *c,
+                                            Qcow2Cache *dependency);
 void qcow2_cache_depends_on_flush(Qcow2Cache *c);
 
 void qcow2_cache_clean_unused(Qcow2Cache *c);
-int qcow2_cache_empty(BlockDriverState *bs, Qcow2Cache *c);
+int GRAPH_RDLOCK qcow2_cache_empty(BlockDriverState *bs, Qcow2Cache *c);
+
+int GRAPH_RDLOCK
+qcow2_cache_get(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
+                void **table);
+
+int GRAPH_RDLOCK
+qcow2_cache_get_empty(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
+                      void **table);
 
-int qcow2_cache_get(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
-    void **table);
-int qcow2_cache_get_empty(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
-    void **table);
 void qcow2_cache_put(Qcow2Cache *c, void **table);
 void *qcow2_cache_is_table_offset(Qcow2Cache *c, uint64_t offset);
 void qcow2_cache_discard(Qcow2Cache *c, void *table);
@@ -998,17 +1027,22 @@ bool coroutine_fn GRAPH_RDLOCK
 qcow2_load_dirty_bitmaps(BlockDriverState *bs, bool *header_updated, Error **errp);
 bool qcow2_get_bitmap_info_list(BlockDriverState *bs,
                                 Qcow2BitmapInfoList **info_list, Error **errp);
-int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
+int GRAPH_RDLOCK qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
+int GRAPH_RDLOCK qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
 int coroutine_fn qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp);
-bool qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
-                                          bool release_stored, Error **errp);
-int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
+
+bool GRAPH_RDLOCK
+qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, bool release_stored,
+                                     Error **errp);
+
 bool coroutine_fn GRAPH_RDLOCK
 qcow2_co_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
                                     uint32_t granularity, Error **errp);
-int coroutine_fn qcow2_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
-                                                         const char *name,
-                                                         Error **errp);
+
+int coroutine_fn GRAPH_RDLOCK
+qcow2_co_remove_persistent_dirty_bitmap(BlockDriverState *bs, const char *name,
+                                        Error **errp);
+
 bool qcow2_supports_persistent_dirty_bitmap(BlockDriverState *bs);
 uint64_t qcow2_get_persistent_dirty_bitmap_size(BlockDriverState *bs,
                                                 uint32_t cluster_size);
diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index 9dc35133a8..794ef34ded 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -138,7 +138,7 @@ void GRAPH_RDLOCK
 bdrv_refresh_limits(BlockDriverState *bs, Transaction *tran, Error **errp);
 
 int bdrv_commit(BlockDriverState *bs);
-int bdrv_make_empty(BdrvChild *c, Error **errp);
+int GRAPH_RDLOCK bdrv_make_empty(BdrvChild *c, Error **errp);
 int bdrv_change_backing_file(BlockDriverState *bs, const char *backing_file,
                              const char *backing_fmt, bool warn);
 void bdrv_register(BlockDriver *bdrv);
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index c8661775f4..d971d73f8f 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -264,7 +264,7 @@ struct BlockDriver {
         BlockDriverAmendStatusCB *status_cb, void *cb_opaque,
         bool force, Error **errp);
 
-    int (*bdrv_make_empty)(BlockDriverState *bs);
+    int GRAPH_RDLOCK_PTR (*bdrv_make_empty)(BlockDriverState *bs);
 
     /*
      * Refreshes the bs->exact_filename field. If that is impossible,
diff --git a/block.c b/block.c
index c932dc0a51..d1a3466069 100644
--- a/block.c
+++ b/block.c
@@ -7250,7 +7250,8 @@ bool bdrv_op_is_blocked(BlockDriverState *bs, BlockOpType op, Error **errp)
 {
     BdrvOpBlocker *blocker;
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+    assume_graph_lock(); /* FIXME */
 
     assert((int) op >= 0 && op < BLOCK_OP_TYPE_MAX);
     if (!QLIST_EMPTY(&bs->op_blockers[op])) {
diff --git a/block/block-backend.c b/block/block-backend.c
index 39b5f90a11..fd10fcc2d0 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2905,6 +2905,8 @@ const BdrvChild *blk_root(BlockBackend *blk)
 int blk_make_empty(BlockBackend *blk, Error **errp)
 {
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     if (!blk_is_available(blk)) {
         error_setg(errp, "No medium inserted");
         return -ENOMEDIUM;
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 03dd91dfac..6996eab9e1 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -206,8 +206,9 @@ static int check_constraints_on_bitmap(BlockDriverState *bs,
     return 0;
 }
 
-static void clear_bitmap_table(BlockDriverState *bs, uint64_t *bitmap_table,
-                               uint32_t bitmap_table_size)
+static void GRAPH_RDLOCK
+clear_bitmap_table(BlockDriverState *bs, uint64_t *bitmap_table,
+                   uint32_t bitmap_table_size)
 {
     BDRVQcow2State *s = bs->opaque;
     int i;
@@ -261,7 +262,8 @@ fail:
     return ret;
 }
 
-static int free_bitmap_clusters(BlockDriverState *bs, Qcow2BitmapTable *tb)
+static int GRAPH_RDLOCK
+free_bitmap_clusters(BlockDriverState *bs, Qcow2BitmapTable *tb)
 {
     int ret;
     uint64_t *bitmap_table;
@@ -732,8 +734,9 @@ out:
  * Store bitmap list to qcow2 image as a bitmap directory.
  * Everything is checked.
  */
-static int bitmap_list_store(BlockDriverState *bs, Qcow2BitmapList *bm_list,
-                             uint64_t *offset, uint64_t *size, bool in_place)
+static int GRAPH_RDLOCK
+bitmap_list_store(BlockDriverState *bs, Qcow2BitmapList *bm_list,
+                  uint64_t *offset, uint64_t *size, bool in_place)
 {
     int ret;
     uint8_t *dir;
@@ -831,8 +834,9 @@ fail:
  * Bitmap List end
  */
 
-static int update_ext_header_and_dir_in_place(BlockDriverState *bs,
-                                              Qcow2BitmapList *bm_list)
+static int GRAPH_RDLOCK
+update_ext_header_and_dir_in_place(BlockDriverState *bs,
+                                   Qcow2BitmapList *bm_list)
 {
     BDRVQcow2State *s = bs->opaque;
     int ret;
@@ -879,8 +883,8 @@ static int update_ext_header_and_dir_in_place(BlockDriverState *bs,
      */
 }
 
-static int update_ext_header_and_dir(BlockDriverState *bs,
-                                     Qcow2BitmapList *bm_list)
+static int GRAPH_RDLOCK
+update_ext_header_and_dir(BlockDriverState *bs, Qcow2BitmapList *bm_list)
 {
     BDRVQcow2State *s = bs->opaque;
     int ret;
@@ -1273,9 +1277,9 @@ out:
 /* store_bitmap_data()
  * Store bitmap to image, filling bitmap table accordingly.
  */
-static uint64_t *store_bitmap_data(BlockDriverState *bs,
-                                   BdrvDirtyBitmap *bitmap,
-                                   uint32_t *bitmap_table_size, Error **errp)
+static uint64_t * GRAPH_RDLOCK
+store_bitmap_data(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
+                  uint32_t *bitmap_table_size, Error **errp)
 {
     int ret;
     BDRVQcow2State *s = bs->opaque;
@@ -1372,7 +1376,8 @@ fail:
  * Store bm->dirty_bitmap to qcow2.
  * Set bm->table_offset and bm->table_size accordingly.
  */
-static int store_bitmap(BlockDriverState *bs, Qcow2Bitmap *bm, Error **errp)
+static int GRAPH_RDLOCK
+store_bitmap(BlockDriverState *bs, Qcow2Bitmap *bm, Error **errp)
 {
     int ret;
     uint64_t *tb;
diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index 01c67bdddc..23d9588b08 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -163,7 +163,8 @@ int qcow2_cache_destroy(Qcow2Cache *c)
     return 0;
 }
 
-static int qcow2_cache_flush_dependency(BlockDriverState *bs, Qcow2Cache *c)
+static int GRAPH_RDLOCK
+qcow2_cache_flush_dependency(BlockDriverState *bs, Qcow2Cache *c)
 {
     int ret;
 
@@ -178,7 +179,8 @@ static int qcow2_cache_flush_dependency(BlockDriverState *bs, Qcow2Cache *c)
     return 0;
 }
 
-static int qcow2_cache_entry_flush(BlockDriverState *bs, Qcow2Cache *c, int i)
+static int GRAPH_RDLOCK
+qcow2_cache_entry_flush(BlockDriverState *bs, Qcow2Cache *c, int i)
 {
     BDRVQcow2State *s = bs->opaque;
     int ret = 0;
@@ -318,8 +320,9 @@ int qcow2_cache_empty(BlockDriverState *bs, Qcow2Cache *c)
     return 0;
 }
 
-static int qcow2_cache_do_get(BlockDriverState *bs, Qcow2Cache *c,
-    uint64_t offset, void **table, bool read_from_disk)
+static int GRAPH_RDLOCK
+qcow2_cache_do_get(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
+                   void **table, bool read_from_disk)
 {
     BDRVQcow2State *s = bs->opaque;
     int i;
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index f4f6cd6ad0..904f00d1b3 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -207,8 +207,9 @@ int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
  * the cache is used; otherwise the L2 slice is loaded from the image
  * file.
  */
-static int l2_load(BlockDriverState *bs, uint64_t offset,
-                   uint64_t l2_offset, uint64_t **l2_slice)
+static int GRAPH_RDLOCK
+l2_load(BlockDriverState *bs, uint64_t offset,
+        uint64_t l2_offset, uint64_t **l2_slice)
 {
     BDRVQcow2State *s = bs->opaque;
     int start_of_slice = l2_entry_size(s) *
@@ -269,7 +270,7 @@ int qcow2_write_l1_entry(BlockDriverState *bs, int l1_index)
  *
  */
 
-static int l2_allocate(BlockDriverState *bs, int l1_index)
+static int GRAPH_RDLOCK l2_allocate(BlockDriverState *bs, int l1_index)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t old_l2_offset;
@@ -751,9 +752,9 @@ fail:
  *
  * Returns 0 on success, -errno in failure case
  */
-static int get_cluster_table(BlockDriverState *bs, uint64_t offset,
-                             uint64_t **new_l2_slice,
-                             int *new_l2_index)
+static int GRAPH_RDLOCK
+get_cluster_table(BlockDriverState *bs, uint64_t offset,
+                  uint64_t **new_l2_slice, int *new_l2_index)
 {
     BDRVQcow2State *s = bs->opaque;
     unsigned int l2_index;
@@ -1155,11 +1156,10 @@ void coroutine_fn qcow2_alloc_cluster_abort(BlockDriverState *bs, QCowL2Meta *m)
  *
  * Returns 0 on success, -errno on failure.
  */
-static int coroutine_fn calculate_l2_meta(BlockDriverState *bs,
-                                          uint64_t host_cluster_offset,
-                                          uint64_t guest_offset, unsigned bytes,
-                                          uint64_t *l2_slice, QCowL2Meta **m,
-                                          bool keep_old)
+static int coroutine_fn GRAPH_RDLOCK
+calculate_l2_meta(BlockDriverState *bs, uint64_t host_cluster_offset,
+                  uint64_t guest_offset, unsigned bytes, uint64_t *l2_slice,
+                  QCowL2Meta **m, bool keep_old)
 {
     BDRVQcow2State *s = bs->opaque;
     int sc_index, l2_index = offset_to_l2_slice_index(s, guest_offset);
@@ -1490,9 +1490,9 @@ static int coroutine_fn handle_dependencies(BlockDriverState *bs,
  *
  *  -errno: in error cases
  */
-static int coroutine_fn handle_copied(BlockDriverState *bs,
-    uint64_t guest_offset, uint64_t *host_offset, uint64_t *bytes,
-    QCowL2Meta **m)
+static int coroutine_fn GRAPH_RDLOCK
+handle_copied(BlockDriverState *bs, uint64_t guest_offset,
+              uint64_t *host_offset, uint64_t *bytes, QCowL2Meta **m)
 {
     BDRVQcow2State *s = bs->opaque;
     int l2_index;
@@ -1600,10 +1600,9 @@ out:
  * function has been waiting for another request and the allocation must be
  * restarted, but the whole request should not be failed.
  */
-static int coroutine_fn do_alloc_cluster_offset(BlockDriverState *bs,
-                                                uint64_t guest_offset,
-                                                uint64_t *host_offset,
-                                                uint64_t *nb_clusters)
+static int coroutine_fn GRAPH_RDLOCK
+do_alloc_cluster_offset(BlockDriverState *bs, uint64_t guest_offset,
+                        uint64_t *host_offset, uint64_t *nb_clusters)
 {
     BDRVQcow2State *s = bs->opaque;
 
@@ -1658,9 +1657,9 @@ static int coroutine_fn do_alloc_cluster_offset(BlockDriverState *bs,
  *
  *  -errno: in error cases
  */
-static int coroutine_fn handle_alloc(BlockDriverState *bs,
-    uint64_t guest_offset, uint64_t *host_offset, uint64_t *bytes,
-    QCowL2Meta **m)
+static int coroutine_fn GRAPH_RDLOCK
+handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
+             uint64_t *host_offset, uint64_t *bytes, QCowL2Meta **m)
 {
     BDRVQcow2State *s = bs->opaque;
     int l2_index;
@@ -1898,9 +1897,9 @@ again:
  * all clusters in the same L2 slice) and returns the number of discarded
  * clusters.
  */
-static int discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
-                               uint64_t nb_clusters,
-                               enum qcow2_discard_type type, bool full_discard)
+static int GRAPH_RDLOCK
+discard_in_l2_slice(BlockDriverState *bs, uint64_t offset, uint64_t nb_clusters,
+                    enum qcow2_discard_type type, bool full_discard)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t *l2_slice;
@@ -2037,7 +2036,7 @@ fail:
  * all clusters in the same L2 slice) and returns the number of zeroed
  * clusters.
  */
-static int coroutine_fn
+static int coroutine_fn GRAPH_RDLOCK
 zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
                  uint64_t nb_clusters, int flags)
 {
@@ -2093,7 +2092,7 @@ zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
     return nb_clusters;
 }
 
-static int coroutine_fn
+static int coroutine_fn GRAPH_RDLOCK
 zero_l2_subclusters(BlockDriverState *bs, uint64_t offset,
                     unsigned nb_subclusters)
 {
@@ -2231,11 +2230,12 @@ fail:
  * status_cb(). l1_entries contains the total number of L1 entries and
  * *visited_l1_entries counts all visited L1 entries.
  */
-static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
-                                      int l1_size, int64_t *visited_l1_entries,
-                                      int64_t l1_entries,
-                                      BlockDriverAmendStatusCB *status_cb,
-                                      void *cb_opaque)
+static int GRAPH_RDLOCK
+expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
+                           int l1_size, int64_t *visited_l1_entries,
+                           int64_t l1_entries,
+                           BlockDriverAmendStatusCB *status_cb,
+                           void *cb_opaque)
 {
     BDRVQcow2State *s = bs->opaque;
     bool is_active_l1 = (l1_table == s->l1_table);
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 996d1217d0..0266542cee 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -229,9 +229,9 @@ static void set_refcount_ro6(void *refcount_array, uint64_t index,
 }
 
 
-static int load_refcount_block(BlockDriverState *bs,
-                               int64_t refcount_block_offset,
-                               void **refcount_block)
+static int GRAPH_RDLOCK
+load_refcount_block(BlockDriverState *bs, int64_t refcount_block_offset,
+                    void **refcount_block)
 {
     BDRVQcow2State *s = bs->opaque;
 
@@ -302,8 +302,9 @@ static int in_same_refcount_block(BDRVQcow2State *s, uint64_t offset_a,
  *
  * Returns 0 on success or -errno in error case
  */
-static int alloc_refcount_block(BlockDriverState *bs,
-                                int64_t cluster_index, void **refcount_block)
+static int GRAPH_RDLOCK
+alloc_refcount_block(BlockDriverState *bs, int64_t cluster_index,
+                     void **refcount_block)
 {
     BDRVQcow2State *s = bs->opaque;
     unsigned int refcount_table_index;
@@ -806,12 +807,9 @@ found:
 /* XXX: cache several refcount block clusters ? */
 /* @addend is the absolute value of the addend; if @decrease is set, @addend
  * will be subtracted from the current refcount, otherwise it will be added */
-static int update_refcount(BlockDriverState *bs,
-                           int64_t offset,
-                           int64_t length,
-                           uint64_t addend,
-                           bool decrease,
-                           enum qcow2_discard_type type)
+static int GRAPH_RDLOCK
+update_refcount(BlockDriverState *bs, int64_t offset, int64_t length,
+                uint64_t addend, bool decrease, enum qcow2_discard_type type)
 {
     BDRVQcow2State *s = bs->opaque;
     int64_t start, last, cluster_offset;
@@ -967,8 +965,8 @@ int qcow2_update_cluster_refcount(BlockDriverState *bs,
 
 
 /* return < 0 if error */
-static int64_t alloc_clusters_noref(BlockDriverState *bs, uint64_t size,
-                                    uint64_t max)
+static int64_t GRAPH_RDLOCK
+alloc_clusters_noref(BlockDriverState *bs, uint64_t size, uint64_t max)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t i, nb_clusters, refcount;
@@ -2302,7 +2300,7 @@ calculate_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
  * Compares the actual reference count for each cluster in the image against the
  * refcount as reported by the refcount structures on-disk.
  */
-static void coroutine_fn
+static void coroutine_fn GRAPH_RDLOCK
 compare_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                   BdrvCheckMode fix, bool *rebuild,
                   int64_t *highest_cluster,
@@ -3103,20 +3101,22 @@ int qcow2_pre_write_overlap_check(BlockDriverState *bs, int ign, int64_t offset,
  *
  * @allocated should be set to true if a new cluster has been allocated.
  */
-typedef int (RefblockFinishOp)(BlockDriverState *bs, uint64_t **reftable,
-                               uint64_t reftable_index, uint64_t *reftable_size,
-                               void *refblock, bool refblock_empty,
-                               bool *allocated, Error **errp);
+typedef int /* GRAPH_RDLOCK_PTR */
+    (RefblockFinishOp)(BlockDriverState *bs, uint64_t **reftable,
+                       uint64_t reftable_index, uint64_t *reftable_size,
+                       void *refblock, bool refblock_empty,
+                       bool *allocated, Error **errp);
 
 /**
  * This "operation" for walk_over_reftable() allocates the refblock on disk (if
  * it is not empty) and inserts its offset into the new reftable. The size of
  * this new reftable is increased as required.
  */
-static int alloc_refblock(BlockDriverState *bs, uint64_t **reftable,
-                          uint64_t reftable_index, uint64_t *reftable_size,
-                          void *refblock, bool refblock_empty, bool *allocated,
-                          Error **errp)
+static int GRAPH_RDLOCK
+alloc_refblock(BlockDriverState *bs, uint64_t **reftable,
+               uint64_t reftable_index, uint64_t *reftable_size,
+               void *refblock, bool refblock_empty, bool *allocated,
+               Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     int64_t offset;
@@ -3166,10 +3166,11 @@ static int alloc_refblock(BlockDriverState *bs, uint64_t **reftable,
  * offset specified by the new reftable's entry. It does not modify the new
  * reftable or change any refcounts.
  */
-static int flush_refblock(BlockDriverState *bs, uint64_t **reftable,
-                          uint64_t reftable_index, uint64_t *reftable_size,
-                          void *refblock, bool refblock_empty, bool *allocated,
-                          Error **errp)
+static int GRAPH_RDLOCK
+flush_refblock(BlockDriverState *bs, uint64_t **reftable,
+               uint64_t reftable_index, uint64_t *reftable_size,
+               void *refblock, bool refblock_empty, bool *allocated,
+               Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     int64_t offset;
@@ -3210,16 +3211,17 @@ static int flush_refblock(BlockDriverState *bs, uint64_t **reftable,
  *
  * @allocated is set to true if a new cluster has been allocated.
  */
-static int walk_over_reftable(BlockDriverState *bs, uint64_t **new_reftable,
-                              uint64_t *new_reftable_index,
-                              uint64_t *new_reftable_size,
-                              void *new_refblock, int new_refblock_size,
-                              int new_refcount_bits,
-                              RefblockFinishOp *operation, bool *allocated,
-                              Qcow2SetRefcountFunc *new_set_refcount,
-                              BlockDriverAmendStatusCB *status_cb,
-                              void *cb_opaque, int index, int total,
-                              Error **errp)
+static int GRAPH_RDLOCK
+walk_over_reftable(BlockDriverState *bs, uint64_t **new_reftable,
+                   uint64_t *new_reftable_index,
+                   uint64_t *new_reftable_size,
+                   void *new_refblock, int new_refblock_size,
+                   int new_refcount_bits,
+                   RefblockFinishOp *operation, bool *allocated,
+                   Qcow2SetRefcountFunc *new_set_refcount,
+                   BlockDriverAmendStatusCB *status_cb,
+                   void *cb_opaque, int index, int total,
+                   Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t reftable_index;
@@ -3545,8 +3547,8 @@ done:
     return ret;
 }
 
-static int64_t coroutine_fn get_refblock_offset(BlockDriverState *bs,
-                                                uint64_t offset)
+static int64_t coroutine_fn GRAPH_RDLOCK
+get_refblock_offset(BlockDriverState *bs, uint64_t offset)
 {
     BDRVQcow2State *s = bs->opaque;
     uint32_t index = offset_to_reftable_index(s, offset);
@@ -3565,7 +3567,7 @@ static int64_t coroutine_fn get_refblock_offset(BlockDriverState *bs,
     return covering_refblock_offset;
 }
 
-static int coroutine_fn
+static int coroutine_fn GRAPH_RDLOCK
 qcow2_discard_refcount_block(BlockDriverState *bs, uint64_t discard_block_offs)
 {
     BDRVQcow2State *s = bs->opaque;
diff --git a/block/qcow2.c b/block/qcow2.c
index 4780cb9148..137c036ea4 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -536,7 +536,7 @@ int qcow2_mark_dirty(BlockDriverState *bs)
  * function when there are no pending requests, it does not guard against
  * concurrent requests dirtying the image.
  */
-static int qcow2_mark_clean(BlockDriverState *bs)
+static int GRAPH_RDLOCK qcow2_mark_clean(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
 
@@ -570,7 +570,8 @@ int qcow2_mark_corrupt(BlockDriverState *bs)
  * Marks the image as consistent, i.e., unsets the corrupt bit, and flushes
  * before if necessary.
  */
-static int coroutine_fn qcow2_mark_consistent(BlockDriverState *bs)
+static int coroutine_fn GRAPH_RDLOCK
+qcow2_mark_consistent(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
 
@@ -980,10 +981,9 @@ typedef struct Qcow2ReopenState {
     QCryptoBlockOpenOptions *crypto_opts; /* Disk encryption runtime options */
 } Qcow2ReopenState;
 
-static int qcow2_update_options_prepare(BlockDriverState *bs,
-                                        Qcow2ReopenState *r,
-                                        QDict *options, int flags,
-                                        Error **errp)
+static int GRAPH_RDLOCK
+qcow2_update_options_prepare(BlockDriverState *bs, Qcow2ReopenState *r,
+                             QDict *options, int flags, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     QemuOpts *opts = NULL;
@@ -1260,7 +1260,7 @@ static void qcow2_update_options_abort(BlockDriverState *bs,
     qapi_free_QCryptoBlockOpenOptions(r->crypto_opts);
 }
 
-static int coroutine_fn
+static int coroutine_fn GRAPH_RDLOCK
 qcow2_update_options(BlockDriverState *bs, QDict *options, int flags,
                      Error **errp)
 {
@@ -1969,13 +1969,17 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
     bs->bl.pdiscard_alignment = s->cluster_size;
 }
 
-static int qcow2_reopen_prepare(BDRVReopenState *state,
-                                BlockReopenQueue *queue, Error **errp)
+static int GRAPH_UNLOCKED
+qcow2_reopen_prepare(BDRVReopenState *state,BlockReopenQueue *queue,
+                     Error **errp)
 {
     BDRVQcow2State *s = state->bs->opaque;
     Qcow2ReopenState *r;
     int ret;
 
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     r = g_new0(Qcow2ReopenState, 1);
     state->opaque = r;
 
@@ -2038,6 +2042,8 @@ static void qcow2_reopen_commit(BDRVReopenState *state)
 
 static void qcow2_reopen_commit_post(BDRVReopenState *state)
 {
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     if (state->flags & BDRV_O_RDWR) {
         Error *local_err = NULL;
 
@@ -4079,8 +4085,8 @@ qcow2_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
     return ret;
 }
 
-static coroutine_fn int qcow2_co_pdiscard(BlockDriverState *bs,
-                                          int64_t offset, int64_t bytes)
+static int coroutine_fn GRAPH_RDLOCK
+qcow2_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
 {
     int ret;
     BDRVQcow2State *s = bs->opaque;
@@ -4825,7 +4831,7 @@ fail:
     return ret;
 }
 
-static int make_completely_empty(BlockDriverState *bs)
+static int GRAPH_RDLOCK make_completely_empty(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
     Error *local_err = NULL;
@@ -4976,7 +4982,7 @@ fail:
     return ret;
 }
 
-static int qcow2_make_empty(BlockDriverState *bs)
+static int GRAPH_RDLOCK qcow2_make_empty(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t offset, end_offset;
@@ -5020,7 +5026,7 @@ static int qcow2_make_empty(BlockDriverState *bs)
     return ret;
 }
 
-static coroutine_fn int qcow2_co_flush_to_os(BlockDriverState *bs)
+static coroutine_fn GRAPH_RDLOCK int qcow2_co_flush_to_os(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
     int ret;
@@ -5369,7 +5375,7 @@ qcow2_co_load_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
     return bs->drv->bdrv_co_preadv_part(bs, offset, qiov->size, qiov, 0, 0);
 }
 
-static int qcow2_has_compressed_clusters(BlockDriverState *bs)
+static int GRAPH_RDLOCK qcow2_has_compressed_clusters(BlockDriverState *bs)
 {
     int64_t offset = 0;
     int64_t bytes = bdrv_getlength(bs);
@@ -5405,9 +5411,10 @@ static int qcow2_has_compressed_clusters(BlockDriverState *bs)
  * Downgrades an image's version. To achieve this, any incompatible features
  * have to be removed.
  */
-static int qcow2_downgrade(BlockDriverState *bs, int target_version,
-                           BlockDriverAmendStatusCB *status_cb, void *cb_opaque,
-                           Error **errp)
+static int GRAPH_RDLOCK
+qcow2_downgrade(BlockDriverState *bs, int target_version,
+                BlockDriverAmendStatusCB *status_cb, void *cb_opaque,
+                Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     int current_version = s->qcow_version;
@@ -5515,9 +5522,10 @@ static int qcow2_downgrade(BlockDriverState *bs, int target_version,
  * features of older versions, some things may have to be presented
  * differently.
  */
-static int qcow2_upgrade(BlockDriverState *bs, int target_version,
-                         BlockDriverAmendStatusCB *status_cb, void *cb_opaque,
-                         Error **errp)
+static int GRAPH_RDLOCK
+qcow2_upgrade(BlockDriverState *bs, int target_version,
+              BlockDriverAmendStatusCB *status_cb, void *cb_opaque,
+              Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     bool need_snapshot_update;
@@ -5643,11 +5651,10 @@ static void qcow2_amend_helper_cb(BlockDriverState *bs,
                              info->original_cb_opaque);
 }
 
-static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
-                               BlockDriverAmendStatusCB *status_cb,
-                               void *cb_opaque,
-                               bool force,
-                               Error **errp)
+static int GRAPH_RDLOCK
+qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
+                    BlockDriverAmendStatusCB *status_cb, void *cb_opaque,
+                    bool force, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     int old_version = s->qcow_version, new_version = old_version;
@@ -5947,8 +5954,6 @@ void qcow2_signal_corruption(BlockDriverState *bs, bool fatal, int64_t offset,
     char *message;
     va_list ap;
 
-    assume_graph_lock(); /* FIXME */
-
     fatal = fatal && bdrv_is_writable(bs);
 
     if (s->signaled_corruption &&
diff --git a/block/replication.c b/block/replication.c
index 107445d0ce..3459f50669 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -307,13 +307,16 @@ out:
     return ret;
 }
 
-static void secondary_do_checkpoint(BlockDriverState *bs, Error **errp)
+static void GRAPH_UNLOCKED
+secondary_do_checkpoint(BlockDriverState *bs, Error **errp)
 {
     BDRVReplicationState *s = bs->opaque;
     BdrvChild *active_disk = bs->file;
     Error *local_err = NULL;
     int ret;
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     if (!s->backup_job) {
         error_setg(errp, "Backup job was cancelled unexpectedly");
         return;
@@ -531,13 +534,16 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
         /* Must be true, or the bdrv_getlength() calls would have failed */
         assert(active_disk->bs->drv && hidden_disk->bs->drv);
 
+        bdrv_graph_rdlock_main_loop();
         if (!active_disk->bs->drv->bdrv_make_empty ||
             !hidden_disk->bs->drv->bdrv_make_empty) {
             error_setg(errp,
                        "Active disk or hidden disk doesn't support make_empty");
             aio_context_release(aio_context);
+            bdrv_graph_rdunlock_main_loop();
             return;
         }
+        bdrv_graph_rdunlock_main_loop();
 
         /* reopen the backing file in r/w mode */
         reopen_backing_file(bs, true, &local_err);
-- 
2.41.0


