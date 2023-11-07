Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AE27E489D
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:48:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0R6I-0004a2-Tc; Tue, 07 Nov 2023 13:46:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0R5p-00041Y-8y
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:46:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0R5m-0001Wl-96
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699382785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EFmRSZZ1tGJRCUwb25czO0aO3P+HawN92fGv1bSfreg=;
 b=CIs5fLN8Fxsr6iauZLLPr0DFiFcTFo1GzqYRWmDWMPh81iUhFMNZ4SUHGB0g08Ez0v53Lm
 1+Fy5suvyEIYiO4NY1z93gyfQc6YhJyl4Qx9YZSd16kHceuZtAb6AC2HOmu/rh7QWkEvbu
 BjGAPlyD8DscBJ6SrFXx8wg3vorbOZg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-Vld49_u-PNS-ojBmldC1QQ-1; Tue,
 07 Nov 2023 13:46:23 -0500
X-MC-Unique: Vld49_u-PNS-ojBmldC1QQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87153280302A
 for <qemu-devel@nongnu.org>; Tue,  7 Nov 2023 18:46:23 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12CCCC1596F;
 Tue,  7 Nov 2023 18:46:22 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com
Subject: [PULL 21/25] qcow2: Take locks for accessing bs->file
Date: Tue,  7 Nov 2023 19:46:01 +0100
Message-ID: <20231107184605.236540-22-kwolf@redhat.com>
In-Reply-To: <20231107184605.236540-1-kwolf@redhat.com>
References: <20231107184605.236540-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This updates the qcow2 code to add GRAPH_RDLOCK annotations for all
places that read bs->file.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20231027155333.420094-22-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.h         | 48 ++++++++++++++++++++++++++-----------------
 block/qcow2-bitmap.c  | 14 +++++++------
 block/qcow2-cluster.c | 25 +++++++++++-----------
 block/qcow2.c         | 13 ++++++++----
 4 files changed, 59 insertions(+), 41 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 948335979f..a9e3481c6e 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -641,7 +641,7 @@ static inline void set_l2_bitmap(BDRVQcow2State *s, uint64_t *l2_slice,
     l2_slice[idx + 1] = cpu_to_be64(bitmap);
 }
 
-static inline bool has_data_file(BlockDriverState *bs)
+static inline bool GRAPH_RDLOCK has_data_file(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
     return (s->data_file != bs->file);
@@ -709,8 +709,8 @@ static inline int64_t qcow2_vm_state_offset(BDRVQcow2State *s)
     return (int64_t)s->l1_vm_state_index << (s->cluster_bits + s->l2_bits);
 }
 
-static inline QCow2ClusterType qcow2_get_cluster_type(BlockDriverState *bs,
-                                                      uint64_t l2_entry)
+static inline QCow2ClusterType GRAPH_RDLOCK
+qcow2_get_cluster_type(BlockDriverState *bs, uint64_t l2_entry)
 {
     BDRVQcow2State *s = bs->opaque;
 
@@ -743,7 +743,7 @@ static inline QCow2ClusterType qcow2_get_cluster_type(BlockDriverState *bs,
  * (this checks the whole entry and bitmap, not only the bits related
  * to subcluster @sc_index).
  */
-static inline
+static inline GRAPH_RDLOCK
 QCow2SubclusterType qcow2_get_subcluster_type(BlockDriverState *bs,
                                               uint64_t l2_entry,
                                               uint64_t l2_bitmap,
@@ -834,9 +834,9 @@ int64_t qcow2_refcount_metadata_size(int64_t clusters, size_t cluster_size,
                                      int refcount_order, bool generous_increase,
                                      uint64_t *refblock_count);
 
-int qcow2_mark_dirty(BlockDriverState *bs);
-int qcow2_mark_corrupt(BlockDriverState *bs);
-int qcow2_update_header(BlockDriverState *bs);
+int GRAPH_RDLOCK qcow2_mark_dirty(BlockDriverState *bs);
+int GRAPH_RDLOCK qcow2_mark_corrupt(BlockDriverState *bs);
+int GRAPH_RDLOCK qcow2_update_header(BlockDriverState *bs);
 
 void GRAPH_RDLOCK
 qcow2_signal_corruption(BlockDriverState *bs, bool fatal, int64_t offset,
@@ -890,10 +890,11 @@ int GRAPH_RDLOCK qcow2_write_caches(BlockDriverState *bs);
 int coroutine_fn qcow2_check_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                                        BdrvCheckMode fix);
 
-void qcow2_process_discards(BlockDriverState *bs, int ret);
+void GRAPH_RDLOCK qcow2_process_discards(BlockDriverState *bs, int ret);
 
-int qcow2_check_metadata_overlap(BlockDriverState *bs, int ign, int64_t offset,
-                                 int64_t size);
+int GRAPH_RDLOCK
+qcow2_check_metadata_overlap(BlockDriverState *bs, int ign, int64_t offset,
+                             int64_t size);
 int GRAPH_RDLOCK
 qcow2_pre_write_overlap_check(BlockDriverState *bs, int ign, int64_t offset,
                               int64_t size, bool data_file);
@@ -939,8 +940,9 @@ qcow2_alloc_host_offset(BlockDriverState *bs, uint64_t offset,
 int coroutine_fn GRAPH_RDLOCK
 qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs, uint64_t offset,
                                       int compressed_size, uint64_t *host_offset);
-void qcow2_parse_compressed_l2_entry(BlockDriverState *bs, uint64_t l2_entry,
-                                     uint64_t *coffset, int *csize);
+void GRAPH_RDLOCK
+qcow2_parse_compressed_l2_entry(BlockDriverState *bs, uint64_t l2_entry,
+                                uint64_t *coffset, int *csize);
 
 int coroutine_fn GRAPH_RDLOCK
 qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m);
@@ -993,8 +995,9 @@ qcow2_check_fix_snapshot_table(BlockDriverState *bs, BdrvCheckResult *result,
                                BdrvCheckMode fix);
 
 /* qcow2-cache.c functions */
-Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables,
-                               unsigned table_size);
+Qcow2Cache * GRAPH_RDLOCK
+qcow2_cache_create(BlockDriverState *bs, int num_tables, unsigned table_size);
+
 int qcow2_cache_destroy(Qcow2Cache *c);
 
 void qcow2_cache_entry_mark_dirty(Qcow2Cache *c, void *table);
@@ -1020,17 +1023,24 @@ void *qcow2_cache_is_table_offset(Qcow2Cache *c, uint64_t offset);
 void qcow2_cache_discard(Qcow2Cache *c, void *table);
 
 /* qcow2-bitmap.c functions */
-int coroutine_fn
+int coroutine_fn GRAPH_RDLOCK
 qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                               void **refcount_table,
                               int64_t *refcount_table_size);
+
 bool coroutine_fn GRAPH_RDLOCK
-qcow2_load_dirty_bitmaps(BlockDriverState *bs, bool *header_updated, Error **errp);
-bool qcow2_get_bitmap_info_list(BlockDriverState *bs,
-                                Qcow2BitmapInfoList **info_list, Error **errp);
+qcow2_load_dirty_bitmaps(BlockDriverState *bs, bool *header_updated,
+                         Error **errp);
+
+bool GRAPH_RDLOCK
+qcow2_get_bitmap_info_list(BlockDriverState *bs,
+                           Qcow2BitmapInfoList **info_list, Error **errp);
+
 int GRAPH_RDLOCK qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
 int GRAPH_RDLOCK qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
-int coroutine_fn qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp);
+
+int coroutine_fn GRAPH_RDLOCK
+qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp);
 
 bool GRAPH_RDLOCK
 qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, bool release_stored,
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 3058309c47..0e567ed588 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -105,7 +105,7 @@ static inline bool can_write(BlockDriverState *bs)
     return !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTIVE);
 }
 
-static int update_header_sync(BlockDriverState *bs)
+static int GRAPH_RDLOCK update_header_sync(BlockDriverState *bs)
 {
     int ret;
 
@@ -221,8 +221,9 @@ clear_bitmap_table(BlockDriverState *bs, uint64_t *bitmap_table,
     }
 }
 
-static int bitmap_table_load(BlockDriverState *bs, Qcow2BitmapTable *tb,
-                             uint64_t **bitmap_table)
+static int GRAPH_RDLOCK
+bitmap_table_load(BlockDriverState *bs, Qcow2BitmapTable *tb,
+                  uint64_t **bitmap_table)
 {
     int ret;
     BDRVQcow2State *s = bs->opaque;
@@ -551,8 +552,9 @@ static uint32_t bitmap_list_count(Qcow2BitmapList *bm_list)
  * Get bitmap list from qcow2 image. Actually reads bitmap directory,
  * checks it and convert to bitmap list.
  */
-static Qcow2BitmapList *bitmap_list_load(BlockDriverState *bs, uint64_t offset,
-                                         uint64_t size, Error **errp)
+static Qcow2BitmapList * GRAPH_RDLOCK
+bitmap_list_load(BlockDriverState *bs, uint64_t offset, uint64_t size,
+                 Error **errp)
 {
     int ret;
     BDRVQcow2State *s = bs->opaque;
@@ -961,7 +963,7 @@ static void set_readonly_helper(gpointer bitmap, gpointer value)
  * If header_updated is not NULL then it is set appropriately regardless of
  * the return value.
  */
-bool coroutine_fn GRAPH_RDLOCK
+bool coroutine_fn
 qcow2_load_dirty_bitmaps(BlockDriverState *bs,
                          bool *header_updated, Error **errp)
 {
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 5af439bd11..ce8c0076b3 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -391,11 +391,10 @@ fail:
  * If the L2 entry is invalid return -errno and set @type to
  * QCOW2_SUBCLUSTER_INVALID.
  */
-static int qcow2_get_subcluster_range_type(BlockDriverState *bs,
-                                           uint64_t l2_entry,
-                                           uint64_t l2_bitmap,
-                                           unsigned sc_from,
-                                           QCow2SubclusterType *type)
+static int GRAPH_RDLOCK
+qcow2_get_subcluster_range_type(BlockDriverState *bs, uint64_t l2_entry,
+                                uint64_t l2_bitmap, unsigned sc_from,
+                                QCow2SubclusterType *type)
 {
     BDRVQcow2State *s = bs->opaque;
     uint32_t val;
@@ -442,9 +441,10 @@ static int qcow2_get_subcluster_range_type(BlockDriverState *bs,
  * On failure return -errno and update @l2_index to point to the
  * invalid entry.
  */
-static int count_contiguous_subclusters(BlockDriverState *bs, int nb_clusters,
-                                        unsigned sc_index, uint64_t *l2_slice,
-                                        unsigned *l2_index)
+static int GRAPH_RDLOCK
+count_contiguous_subclusters(BlockDriverState *bs, int nb_clusters,
+                             unsigned sc_index, uint64_t *l2_slice,
+                             unsigned *l2_index)
 {
     BDRVQcow2State *s = bs->opaque;
     int i, count = 0;
@@ -1329,7 +1329,8 @@ calculate_l2_meta(BlockDriverState *bs, uint64_t host_cluster_offset,
  * requires a new allocation (that is, if the cluster is unallocated
  * or has refcount > 1 and therefore cannot be written in-place).
  */
-static bool cluster_needs_new_alloc(BlockDriverState *bs, uint64_t l2_entry)
+static bool GRAPH_RDLOCK
+cluster_needs_new_alloc(BlockDriverState *bs, uint64_t l2_entry)
 {
     switch (qcow2_get_cluster_type(bs, l2_entry)) {
     case QCOW2_CLUSTER_NORMAL:
@@ -1360,9 +1361,9 @@ static bool cluster_needs_new_alloc(BlockDriverState *bs, uint64_t l2_entry)
  * allocated and can be overwritten in-place (this includes clusters
  * of type QCOW2_CLUSTER_ZERO_ALLOC).
  */
-static int count_single_write_clusters(BlockDriverState *bs, int nb_clusters,
-                                       uint64_t *l2_slice, int l2_index,
-                                       bool new_alloc)
+static int GRAPH_RDLOCK
+count_single_write_clusters(BlockDriverState *bs, int nb_clusters,
+                            uint64_t *l2_slice, int l2_index, bool new_alloc)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t l2_entry = get_l2_entry(s, l2_slice, l2_index);
diff --git a/block/qcow2.c b/block/qcow2.c
index 7ab399ffc5..cf2468858f 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -95,9 +95,10 @@ static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
 }
 
 
-static int qcow2_crypto_hdr_read_func(QCryptoBlock *block, size_t offset,
-                                      uint8_t *buf, size_t buflen,
-                                      void *opaque, Error **errp)
+static int GRAPH_RDLOCK
+qcow2_crypto_hdr_read_func(QCryptoBlock *block, size_t offset,
+                           uint8_t *buf, size_t buflen,
+                           void *opaque, Error **errp)
 {
     BlockDriverState *bs = opaque;
     BDRVQcow2State *s = bs->opaque;
@@ -156,7 +157,7 @@ qcow2_crypto_hdr_init_func(QCryptoBlock *block, size_t headerlen, void *opaque,
 
 
 /* The graph lock must be held when called in coroutine context */
-static int coroutine_mixed_fn
+static int coroutine_mixed_fn GRAPH_RDLOCK
 qcow2_crypto_hdr_write_func(QCryptoBlock *block, size_t offset,
                             const uint8_t *buf, size_t buflen,
                             void *opaque, Error **errp)
@@ -2029,6 +2030,8 @@ static void qcow2_reopen_commit(BDRVReopenState *state)
 {
     BDRVQcow2State *s = state->bs->opaque;
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     qcow2_update_options_commit(state->bs, state->opaque);
     if (!s->data_file) {
         /*
@@ -2064,6 +2067,8 @@ static void qcow2_reopen_abort(BDRVReopenState *state)
 {
     BDRVQcow2State *s = state->bs->opaque;
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     if (!s->data_file) {
         /*
          * If we don't have an external data file, s->data_file was cleared by
-- 
2.41.0


