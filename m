Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B03074139D
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 16:19:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEVyE-0000KV-Tn; Wed, 28 Jun 2023 10:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEVy2-0008Ky-AD
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:16:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEVxz-0005MG-Jp
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687961778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JQGG284cMlSAZ8E2XQat7in4lVDsCAG/JK6ZUF+bVg0=;
 b=cgAUznjVhWF9nghyRsgZ6C2YtIOIJOzYMc14BLXdmOXV6SWeKkE5ZTa29yGpuxD/fHwghA
 xiHNnKrkFlhbcYOhrBSXjqIsMkqqdmHi7zlKSwCvgtl9D+apvehVF9lgYGGu7r6Mom0liX
 nuAIphfcptFIZwHUOe/V/bcOM3Y8TbI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-gTiYzynLN6CKKBlJyXeEkw-1; Wed, 28 Jun 2023 10:16:15 -0400
X-MC-Unique: gTiYzynLN6CKKBlJyXeEkw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83D051C4FD9C;
 Wed, 28 Jun 2023 14:16:01 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.195.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B5EDA40C2063;
 Wed, 28 Jun 2023 14:16:00 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 21/23] qcow2: mark more functions as coroutine_fns and
 GRAPH_RDLOCK
Date: Wed, 28 Jun 2023 16:15:24 +0200
Message-ID: <20230628141526.293104-22-kwolf@redhat.com>
In-Reply-To: <20230628141526.293104-1-kwolf@redhat.com>
References: <20230628141526.293104-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

Mark functions as coroutine_fn when they are only called by other coroutine_fns
and they can suspend.  Change calls to co_wrappers to use the non-wrapped
functions, which in turn requires adding GRAPH_RDLOCK annotations.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20230601115145.196465-11-pbonzini@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.h          |  33 +++++------
 block/qcow2-bitmap.c   |  26 +++++----
 block/qcow2-cluster.c  |  12 ++--
 block/qcow2-refcount.c | 130 +++++++++++++++++++++--------------------
 block/qcow2.c          |   2 +-
 5 files changed, 105 insertions(+), 98 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index ea9adb5706..f789ce3ae0 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -836,7 +836,6 @@ int64_t qcow2_refcount_metadata_size(int64_t clusters, size_t cluster_size,
 
 int qcow2_mark_dirty(BlockDriverState *bs);
 int qcow2_mark_corrupt(BlockDriverState *bs);
-int qcow2_mark_consistent(BlockDriverState *bs);
 int qcow2_update_header(BlockDriverState *bs);
 
 void qcow2_signal_corruption(BlockDriverState *bs, bool fatal, int64_t offset,
@@ -867,7 +866,7 @@ int64_t qcow2_refcount_area(BlockDriverState *bs, uint64_t offset,
 int64_t qcow2_alloc_clusters(BlockDriverState *bs, uint64_t size);
 int64_t coroutine_fn qcow2_alloc_clusters_at(BlockDriverState *bs, uint64_t offset,
                                              int64_t nb_clusters);
-int64_t coroutine_fn qcow2_alloc_bytes(BlockDriverState *bs, int size);
+int64_t coroutine_fn GRAPH_RDLOCK qcow2_alloc_bytes(BlockDriverState *bs, int size);
 void qcow2_free_clusters(BlockDriverState *bs,
                           int64_t offset, int64_t size,
                           enum qcow2_discard_type type);
@@ -879,8 +878,8 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
 
 int qcow2_flush_caches(BlockDriverState *bs);
 int qcow2_write_caches(BlockDriverState *bs);
-int qcow2_check_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
-                          BdrvCheckMode fix);
+int coroutine_fn qcow2_check_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
+                                       BdrvCheckMode fix);
 
 void qcow2_process_discards(BlockDriverState *bs, int ret);
 
@@ -888,10 +887,10 @@ int qcow2_check_metadata_overlap(BlockDriverState *bs, int ign, int64_t offset,
                                  int64_t size);
 int qcow2_pre_write_overlap_check(BlockDriverState *bs, int ign, int64_t offset,
                                   int64_t size, bool data_file);
-int qcow2_inc_refcounts_imrt(BlockDriverState *bs, BdrvCheckResult *res,
-                             void **refcount_table,
-                             int64_t *refcount_table_size,
-                             int64_t offset, int64_t size);
+int coroutine_fn qcow2_inc_refcounts_imrt(BlockDriverState *bs, BdrvCheckResult *res,
+                                          void **refcount_table,
+                                          int64_t *refcount_table_size,
+                                          int64_t offset, int64_t size);
 
 int qcow2_change_refcount_order(BlockDriverState *bs, int refcount_order,
                                 BlockDriverAmendStatusCB *status_cb,
@@ -919,10 +918,9 @@ int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
 int coroutine_fn qcow2_alloc_host_offset(BlockDriverState *bs, uint64_t offset,
                                          unsigned int *bytes,
                                          uint64_t *host_offset, QCowL2Meta **m);
-int coroutine_fn qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
-                                                       uint64_t offset,
-                                                       int compressed_size,
-                                                       uint64_t *host_offset);
+int coroutine_fn GRAPH_RDLOCK
+qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs, uint64_t offset,
+                                      int compressed_size, uint64_t *host_offset);
 void qcow2_parse_compressed_l2_entry(BlockDriverState *bs, uint64_t l2_entry,
                                      uint64_t *coffset, int *csize);
 
@@ -992,11 +990,12 @@ void *qcow2_cache_is_table_offset(Qcow2Cache *c, uint64_t offset);
 void qcow2_cache_discard(Qcow2Cache *c, void *table);
 
 /* qcow2-bitmap.c functions */
-int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
-                                  void **refcount_table,
-                                  int64_t *refcount_table_size);
-bool coroutine_fn qcow2_load_dirty_bitmaps(BlockDriverState *bs,
-                                           bool *header_updated, Error **errp);
+int coroutine_fn
+qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
+                              void **refcount_table,
+                              int64_t *refcount_table_size);
+bool coroutine_fn GRAPH_RDLOCK
+qcow2_load_dirty_bitmaps(BlockDriverState *bs, bool *header_updated, Error **errp);
 bool qcow2_get_bitmap_info_list(BlockDriverState *bs,
                                 Qcow2BitmapInfoList **info_list, Error **errp);
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index a952fd58d8..037fa2d435 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -283,10 +283,9 @@ static int free_bitmap_clusters(BlockDriverState *bs, Qcow2BitmapTable *tb)
 /* load_bitmap_data
  * @bitmap_table entries must satisfy specification constraints.
  * @bitmap must be cleared */
-static int load_bitmap_data(BlockDriverState *bs,
-                            const uint64_t *bitmap_table,
-                            uint32_t bitmap_table_size,
-                            BdrvDirtyBitmap *bitmap)
+static int coroutine_fn GRAPH_RDLOCK
+load_bitmap_data(BlockDriverState *bs, const uint64_t *bitmap_table,
+                 uint32_t bitmap_table_size, BdrvDirtyBitmap *bitmap)
 {
     int ret = 0;
     BDRVQcow2State *s = bs->opaque;
@@ -319,7 +318,7 @@ static int load_bitmap_data(BlockDriverState *bs,
                  * already cleared */
             }
         } else {
-            ret = bdrv_pread(bs->file, data_offset, s->cluster_size, buf, 0);
+            ret = bdrv_co_pread(bs->file, data_offset, s->cluster_size, buf, 0);
             if (ret < 0) {
                 goto finish;
             }
@@ -337,8 +336,9 @@ finish:
     return ret;
 }
 
-static BdrvDirtyBitmap *load_bitmap(BlockDriverState *bs,
-                                    Qcow2Bitmap *bm, Error **errp)
+static coroutine_fn GRAPH_RDLOCK
+BdrvDirtyBitmap *load_bitmap(BlockDriverState *bs,
+                             Qcow2Bitmap *bm, Error **errp)
 {
     int ret;
     uint64_t *bitmap_table = NULL;
@@ -649,9 +649,10 @@ fail:
     return NULL;
 }
 
-int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
-                                  void **refcount_table,
-                                  int64_t *refcount_table_size)
+int coroutine_fn
+qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
+                              void **refcount_table,
+                              int64_t *refcount_table_size)
 {
     int ret;
     BDRVQcow2State *s = bs->opaque;
@@ -957,8 +958,9 @@ static void set_readonly_helper(gpointer bitmap, gpointer value)
  * If header_updated is not NULL then it is set appropriately regardless of
  * the return value.
  */
-bool coroutine_fn qcow2_load_dirty_bitmaps(BlockDriverState *bs,
-                                           bool *header_updated, Error **errp)
+bool coroutine_fn GRAPH_RDLOCK
+qcow2_load_dirty_bitmaps(BlockDriverState *bs,
+                         bool *header_updated, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     Qcow2BitmapList *bm_list;
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 2e76de027c..6172b2df40 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -823,10 +823,9 @@ static int get_cluster_table(BlockDriverState *bs, uint64_t offset,
  *
  * Return 0 on success and -errno in error cases
  */
-int coroutine_fn qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
-                                                       uint64_t offset,
-                                                       int compressed_size,
-                                                       uint64_t *host_offset)
+int coroutine_fn GRAPH_RDLOCK
+qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs, uint64_t offset,
+                                      int compressed_size, uint64_t *host_offset)
 {
     BDRVQcow2State *s = bs->opaque;
     int l2_index, ret;
@@ -2038,8 +2037,9 @@ fail:
  * all clusters in the same L2 slice) and returns the number of zeroed
  * clusters.
  */
-static int zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
-                            uint64_t nb_clusters, int flags)
+static int coroutine_fn
+zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
+                 uint64_t nb_clusters, int flags)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t *l2_slice;
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 4cf91bd955..de527c3ee4 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1069,7 +1069,7 @@ int64_t coroutine_fn qcow2_alloc_clusters_at(BlockDriverState *bs, uint64_t offs
 
 /* only used to allocate compressed sectors. We try to allocate
    contiguous sectors. size must be <= cluster_size */
-int64_t coroutine_fn qcow2_alloc_bytes(BlockDriverState *bs, int size)
+int64_t coroutine_fn GRAPH_RDLOCK qcow2_alloc_bytes(BlockDriverState *bs, int size)
 {
     BDRVQcow2State *s = bs->opaque;
     int64_t offset;
@@ -1524,10 +1524,11 @@ static int realloc_refcount_array(BDRVQcow2State *s, void **array,
  *
  * Modifies the number of errors in res.
  */
-int qcow2_inc_refcounts_imrt(BlockDriverState *bs, BdrvCheckResult *res,
-                             void **refcount_table,
-                             int64_t *refcount_table_size,
-                             int64_t offset, int64_t size)
+int coroutine_fn GRAPH_RDLOCK
+qcow2_inc_refcounts_imrt(BlockDriverState *bs, BdrvCheckResult *res,
+                         void **refcount_table,
+                         int64_t *refcount_table_size,
+                         int64_t offset, int64_t size)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t start, last, cluster_offset, k, refcount;
@@ -1538,7 +1539,7 @@ int qcow2_inc_refcounts_imrt(BlockDriverState *bs, BdrvCheckResult *res,
         return 0;
     }
 
-    file_len = bdrv_getlength(bs->file->bs);
+    file_len = bdrv_co_getlength(bs->file->bs);
     if (file_len < 0) {
         return file_len;
     }
@@ -1600,10 +1601,11 @@ enum {
  *
  * On failure in-memory @l2_table may be modified.
  */
-static int fix_l2_entry_by_zero(BlockDriverState *bs, BdrvCheckResult *res,
-                                uint64_t l2_offset,
-                                uint64_t *l2_table, int l2_index, bool active,
-                                bool *metadata_overlap)
+static int coroutine_fn GRAPH_RDLOCK
+fix_l2_entry_by_zero(BlockDriverState *bs, BdrvCheckResult *res,
+                     uint64_t l2_offset, uint64_t *l2_table,
+                     int l2_index, bool active,
+                     bool *metadata_overlap)
 {
     BDRVQcow2State *s = bs->opaque;
     int ret;
@@ -1634,8 +1636,8 @@ static int fix_l2_entry_by_zero(BlockDriverState *bs, BdrvCheckResult *res,
         goto fail;
     }
 
-    ret = bdrv_pwrite_sync(bs->file, l2e_offset, l2_entry_size(s),
-                           &l2_table[idx], 0);
+    ret = bdrv_co_pwrite_sync(bs->file, l2e_offset, l2_entry_size(s),
+                              &l2_table[idx], 0);
     if (ret < 0) {
         fprintf(stderr, "ERROR: Failed to overwrite L2 "
                 "table entry: %s\n", strerror(-ret));
@@ -1659,10 +1661,11 @@ fail:
  * Returns the number of errors found by the checks or -errno if an internal
  * error occurred.
  */
-static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
-                              void **refcount_table,
-                              int64_t *refcount_table_size, int64_t l2_offset,
-                              int flags, BdrvCheckMode fix, bool active)
+static int coroutine_fn GRAPH_RDLOCK
+check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
+                   void **refcount_table,
+                   int64_t *refcount_table_size, int64_t l2_offset,
+                   int flags, BdrvCheckMode fix, bool active)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t l2_entry, l2_bitmap;
@@ -1673,7 +1676,7 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
     bool metadata_overlap;
 
     /* Read L2 table from disk */
-    ret = bdrv_pread(bs->file, l2_offset, l2_size_bytes, l2_table, 0);
+    ret = bdrv_co_pread(bs->file, l2_offset, l2_size_bytes, l2_table, 0);
     if (ret < 0) {
         fprintf(stderr, "ERROR: I/O error in check_refcounts_l2\n");
         res->check_errors++;
@@ -1858,12 +1861,11 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
  * Returns the number of errors found by the checks or -errno if an internal
  * error occurred.
  */
-static int check_refcounts_l1(BlockDriverState *bs,
-                              BdrvCheckResult *res,
-                              void **refcount_table,
-                              int64_t *refcount_table_size,
-                              int64_t l1_table_offset, int l1_size,
-                              int flags, BdrvCheckMode fix, bool active)
+static int coroutine_fn GRAPH_RDLOCK
+check_refcounts_l1(BlockDriverState *bs, BdrvCheckResult *res,
+                   void **refcount_table, int64_t *refcount_table_size,
+                   int64_t l1_table_offset, int l1_size,
+                   int flags, BdrvCheckMode fix, bool active)
 {
     BDRVQcow2State *s = bs->opaque;
     size_t l1_size_bytes = l1_size * L1E_SIZE;
@@ -1889,7 +1891,7 @@ static int check_refcounts_l1(BlockDriverState *bs,
     }
 
     /* Read L1 table entries from disk */
-    ret = bdrv_pread(bs->file, l1_table_offset, l1_size_bytes, l1_table, 0);
+    ret = bdrv_co_pread(bs->file, l1_table_offset, l1_size_bytes, l1_table, 0);
     if (ret < 0) {
         fprintf(stderr, "ERROR: I/O error in check_refcounts_l1\n");
         res->check_errors++;
@@ -1949,8 +1951,8 @@ static int check_refcounts_l1(BlockDriverState *bs,
  * have been already detected and sufficiently signaled by the calling function
  * (qcow2_check_refcounts) by the time this function is called).
  */
-static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
-                              BdrvCheckMode fix)
+static int coroutine_fn GRAPH_RDLOCK
+check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res, BdrvCheckMode fix)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t *l2_table = qemu_blockalign(bs, s->cluster_size);
@@ -2005,8 +2007,8 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
             }
         }
 
-        ret = bdrv_pread(bs->file, l2_offset, s->l2_size * l2_entry_size(s),
-                         l2_table, 0);
+        ret = bdrv_co_pread(bs->file, l2_offset, s->l2_size * l2_entry_size(s),
+                            l2_table, 0);
         if (ret < 0) {
             fprintf(stderr, "ERROR: Could not read L2 table: %s\n",
                     strerror(-ret));
@@ -2059,8 +2061,7 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
                 goto fail;
             }
 
-            ret = bdrv_pwrite(bs->file, l2_offset, s->cluster_size, l2_table,
-                              0);
+            ret = bdrv_co_pwrite(bs->file, l2_offset, s->cluster_size, l2_table, 0);
             if (ret < 0) {
                 fprintf(stderr, "ERROR: Could not write L2 table: %s\n",
                         strerror(-ret));
@@ -2083,9 +2084,10 @@ fail:
  * Checks consistency of refblocks and accounts for each refblock in
  * *refcount_table.
  */
-static int check_refblocks(BlockDriverState *bs, BdrvCheckResult *res,
-                           BdrvCheckMode fix, bool *rebuild,
-                           void **refcount_table, int64_t *nb_clusters)
+static int coroutine_fn GRAPH_RDLOCK
+check_refblocks(BlockDriverState *bs, BdrvCheckResult *res,
+                BdrvCheckMode fix, bool *rebuild,
+                void **refcount_table, int64_t *nb_clusters)
 {
     BDRVQcow2State *s = bs->opaque;
     int64_t i, size;
@@ -2127,13 +2129,13 @@ static int check_refblocks(BlockDriverState *bs, BdrvCheckResult *res,
                     goto resize_fail;
                 }
 
-                ret = bdrv_truncate(bs->file, offset + s->cluster_size, false,
-                                    PREALLOC_MODE_OFF, 0, &local_err);
+                ret = bdrv_co_truncate(bs->file, offset + s->cluster_size, false,
+                                       PREALLOC_MODE_OFF, 0, &local_err);
                 if (ret < 0) {
                     error_report_err(local_err);
                     goto resize_fail;
                 }
-                size = bdrv_getlength(bs->file->bs);
+                size = bdrv_co_getlength(bs->file->bs);
                 if (size < 0) {
                     ret = size;
                     goto resize_fail;
@@ -2197,9 +2199,10 @@ resize_fail:
 /*
  * Calculates an in-memory refcount table.
  */
-static int calculate_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
-                               BdrvCheckMode fix, bool *rebuild,
-                               void **refcount_table, int64_t *nb_clusters)
+static int coroutine_fn GRAPH_RDLOCK
+calculate_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
+                    BdrvCheckMode fix, bool *rebuild,
+                    void **refcount_table, int64_t *nb_clusters)
 {
     BDRVQcow2State *s = bs->opaque;
     int64_t i;
@@ -2299,10 +2302,11 @@ static int calculate_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
  * Compares the actual reference count for each cluster in the image against the
  * refcount as reported by the refcount structures on-disk.
  */
-static void compare_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
-                              BdrvCheckMode fix, bool *rebuild,
-                              int64_t *highest_cluster,
-                              void *refcount_table, int64_t nb_clusters)
+static void coroutine_fn
+compare_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
+                  BdrvCheckMode fix, bool *rebuild,
+                  int64_t *highest_cluster,
+                  void *refcount_table, int64_t nb_clusters)
 {
     BDRVQcow2State *s = bs->opaque;
     int64_t i;
@@ -2463,7 +2467,8 @@ static int64_t alloc_clusters_imrt(BlockDriverState *bs,
  * Return whether the on-disk reftable array was resized (true/false),
  * or -errno on error.
  */
-static int rebuild_refcounts_write_refblocks(
+static int coroutine_fn GRAPH_RDLOCK
+rebuild_refcounts_write_refblocks(
         BlockDriverState *bs, void **refcount_table, int64_t *nb_clusters,
         int64_t first_cluster, int64_t end_cluster,
         uint64_t **on_disk_reftable_ptr, uint32_t *on_disk_reftable_entries_ptr,
@@ -2578,8 +2583,8 @@ static int rebuild_refcounts_write_refblocks(
         on_disk_refblock = (void *)((char *) *refcount_table +
                                     refblock_index * s->cluster_size);
 
-        ret = bdrv_pwrite(bs->file, refblock_offset, s->cluster_size,
-                          on_disk_refblock, 0);
+        ret = bdrv_co_pwrite(bs->file, refblock_offset, s->cluster_size,
+                             on_disk_refblock, 0);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "ERROR writing refblock");
             return ret;
@@ -2601,11 +2606,10 @@ static int rebuild_refcounts_write_refblocks(
  * On success, the old refcount structure is leaked (it will be covered by the
  * new refcount structure).
  */
-static int rebuild_refcount_structure(BlockDriverState *bs,
-                                      BdrvCheckResult *res,
-                                      void **refcount_table,
-                                      int64_t *nb_clusters,
-                                      Error **errp)
+static int coroutine_fn GRAPH_RDLOCK
+rebuild_refcount_structure(BlockDriverState *bs, BdrvCheckResult *res,
+                           void **refcount_table, int64_t *nb_clusters,
+                           Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     int64_t reftable_offset = -1;
@@ -2734,8 +2738,8 @@ static int rebuild_refcount_structure(BlockDriverState *bs,
     }
 
     assert(reftable_length < INT_MAX);
-    ret = bdrv_pwrite(bs->file, reftable_offset, reftable_length,
-                      on_disk_reftable, 0);
+    ret = bdrv_co_pwrite(bs->file, reftable_offset, reftable_length,
+                         on_disk_reftable, 0);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "ERROR writing reftable");
         goto fail;
@@ -2745,10 +2749,10 @@ static int rebuild_refcount_structure(BlockDriverState *bs,
     reftable_offset_and_clusters.reftable_offset = cpu_to_be64(reftable_offset);
     reftable_offset_and_clusters.reftable_clusters =
         cpu_to_be32(reftable_clusters);
-    ret = bdrv_pwrite_sync(bs->file,
-                           offsetof(QCowHeader, refcount_table_offset),
-                           sizeof(reftable_offset_and_clusters),
-                           &reftable_offset_and_clusters, 0);
+    ret = bdrv_co_pwrite_sync(bs->file,
+                              offsetof(QCowHeader, refcount_table_offset),
+                              sizeof(reftable_offset_and_clusters),
+                              &reftable_offset_and_clusters, 0);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "ERROR setting reftable");
         goto fail;
@@ -2777,8 +2781,8 @@ fail:
  * Returns 0 if no errors are found, the number of errors in case the image is
  * detected as corrupted, and -errno when an internal error occurred.
  */
-int qcow2_check_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
-                          BdrvCheckMode fix)
+int coroutine_fn GRAPH_RDLOCK
+qcow2_check_refcounts(BlockDriverState *bs, BdrvCheckResult *res, BdrvCheckMode fix)
 {
     BDRVQcow2State *s = bs->opaque;
     BdrvCheckResult pre_compare_res;
@@ -2787,7 +2791,7 @@ int qcow2_check_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
     bool rebuild = false;
     int ret;
 
-    size = bdrv_getlength(bs->file->bs);
+    size = bdrv_co_getlength(bs->file->bs);
     if (size < 0) {
         res->check_errors++;
         return size;
@@ -3541,7 +3545,8 @@ done:
     return ret;
 }
 
-static int64_t get_refblock_offset(BlockDriverState *bs, uint64_t offset)
+static int64_t coroutine_fn get_refblock_offset(BlockDriverState *bs,
+                                                uint64_t offset)
 {
     BDRVQcow2State *s = bs->opaque;
     uint32_t index = offset_to_reftable_index(s, offset);
@@ -3707,7 +3712,8 @@ int64_t coroutine_fn qcow2_get_last_cluster(BlockDriverState *bs, int64_t size)
     return -EIO;
 }
 
-int coroutine_fn qcow2_detect_metadata_preallocation(BlockDriverState *bs)
+int coroutine_fn GRAPH_RDLOCK
+qcow2_detect_metadata_preallocation(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
     int64_t i, end_cluster, cluster_count = 0, threshold;
diff --git a/block/qcow2.c b/block/qcow2.c
index e23edd48c2..267a644aad 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -570,7 +570,7 @@ int qcow2_mark_corrupt(BlockDriverState *bs)
  * Marks the image as consistent, i.e., unsets the corrupt bit, and flushes
  * before if necessary.
  */
-int qcow2_mark_consistent(BlockDriverState *bs)
+static int coroutine_fn qcow2_mark_consistent(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
 
-- 
2.41.0


