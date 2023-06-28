Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD6B741387
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 16:17:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEVyP-0000iG-Mp; Wed, 28 Jun 2023 10:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEVyK-0000d2-L2
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:16:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEVyH-0005TV-SA
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687961797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NIZI3JvAcxQVgE2LyTl4FbXMiUqQfDCBx2FGz0msD30=;
 b=VYIwQvj5PcaRiZth4uIomtNZKHHzHPsqhL/CFgmTSZYd4R0drr9irurJ4RxE/pLv29pl0u
 llrng+YsvlIUJUlH8OzjGMWLHDI0F9SuKt4AGkwEDdd6dNDQmtE7Q6zijupY7eMjXOEuUL
 mKLwt8lK9NePy15USMlNUaLLlWJkSYs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-32-4V9FPai2NqWRAg8Rhqafvg-1; Wed, 28 Jun 2023 10:16:32 -0400
X-MC-Unique: 4V9FPai2NqWRAg8Rhqafvg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 769D4858F1E;
 Wed, 28 Jun 2023 14:16:03 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.195.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6B3140C2070;
 Wed, 28 Jun 2023 14:16:02 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 23/23] block: use bdrv_co_debug_event in coroutine context
Date: Wed, 28 Jun 2023 16:15:26 +0200
Message-ID: <20230628141526.293104-24-kwolf@redhat.com>
In-Reply-To: <20230628141526.293104-1-kwolf@redhat.com>
References: <20230628141526.293104-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

bdrv_co_debug_event was recently introduced, with bdrv_debug_event
becoming a wrapper for use in unknown context.  Because most of the
time bdrv_debug_event is used on a BdrvChild via the wrapper macro
BLKDBG_EVENT, introduce a similar macro BLKDBG_CO_EVENT that calls
bdrv_co_debug_event, and switch whenever possible.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20230601115145.196465-13-pbonzini@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-io.h |  7 +++++++
 block/io.c               |  4 ++--
 block/qcow.c             | 24 ++++++++++++------------
 block/qcow2-cluster.c    | 12 ++++++------
 block/qcow2-refcount.c   |  4 ++--
 block/qcow2.c            | 18 +++++++++---------
 block/qed-table.c        |  6 +++---
 block/qed.c              |  8 ++++----
 block/raw-format.c       |  4 ++--
 block/vmdk.c             | 24 ++++++++++++------------
 10 files changed, 59 insertions(+), 52 deletions(-)

diff --git a/include/block/block-io.h b/include/block/block-io.h
index 43af816d75..4415506e40 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -224,6 +224,13 @@ bdrv_co_debug_event(BlockDriverState *bs, BlkdebugEvent event);
 void co_wrapper_mixed_bdrv_rdlock
 bdrv_debug_event(BlockDriverState *bs, BlkdebugEvent event);
 
+#define BLKDBG_CO_EVENT(child, evt) \
+    do { \
+        if (child) { \
+            bdrv_co_debug_event(child->bs, evt); \
+        } \
+    } while (0)
+
 #define BLKDBG_EVENT(child, evt) \
     do { \
         if (child) { \
diff --git a/block/io.c b/block/io.c
index b53253c7a7..e8293d6b26 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3011,7 +3011,7 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
     }
 
     /* Write back cached data to the OS even with cache=unsafe */
-    BLKDBG_EVENT(primary_child, BLKDBG_FLUSH_TO_OS);
+    BLKDBG_CO_EVENT(primary_child, BLKDBG_FLUSH_TO_OS);
     if (bs->drv->bdrv_co_flush_to_os) {
         ret = bs->drv->bdrv_co_flush_to_os(bs);
         if (ret < 0) {
@@ -3029,7 +3029,7 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
         goto flush_children;
     }
 
-    BLKDBG_EVENT(primary_child, BLKDBG_FLUSH_TO_DISK);
+    BLKDBG_CO_EVENT(primary_child, BLKDBG_FLUSH_TO_DISK);
     if (!bs->drv) {
         /* bs->drv->bdrv_co_flush() might have ejected the BDS
          * (even in case of apparent success) */
diff --git a/block/qcow.c b/block/qcow.c
index cb240a5369..577bd70324 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -379,7 +379,7 @@ get_cluster_offset(BlockDriverState *bs, uint64_t offset, int allocate,
         /* update the L1 entry */
         s->l1_table[l1_index] = l2_offset;
         tmp = cpu_to_be64(l2_offset);
-        BLKDBG_EVENT(bs->file, BLKDBG_L1_UPDATE);
+        BLKDBG_CO_EVENT(bs->file, BLKDBG_L1_UPDATE);
         ret = bdrv_co_pwrite_sync(bs->file,
                                   s->l1_table_offset + l1_index * sizeof(tmp),
                                   sizeof(tmp), &tmp, 0);
@@ -410,7 +410,7 @@ get_cluster_offset(BlockDriverState *bs, uint64_t offset, int allocate,
         }
     }
     l2_table = s->l2_cache + (min_index << s->l2_bits);
-    BLKDBG_EVENT(bs->file, BLKDBG_L2_LOAD);
+    BLKDBG_CO_EVENT(bs->file, BLKDBG_L2_LOAD);
     if (new_l2_table) {
         memset(l2_table, 0, s->l2_size * sizeof(uint64_t));
         ret = bdrv_co_pwrite_sync(bs->file, l2_offset,
@@ -434,7 +434,7 @@ get_cluster_offset(BlockDriverState *bs, uint64_t offset, int allocate,
         ((cluster_offset & QCOW_OFLAG_COMPRESSED) && allocate == 1)) {
         if (!allocate)
             return 0;
-        BLKDBG_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC);
+        BLKDBG_CO_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC);
         assert(QEMU_IS_ALIGNED(n_start | n_end, BDRV_SECTOR_SIZE));
         /* allocate a new cluster */
         if ((cluster_offset & QCOW_OFLAG_COMPRESSED) &&
@@ -451,7 +451,7 @@ get_cluster_offset(BlockDriverState *bs, uint64_t offset, int allocate,
             }
             cluster_offset = QEMU_ALIGN_UP(cluster_offset, s->cluster_size);
             /* write the cluster content */
-            BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
+            BLKDBG_CO_EVENT(bs->file, BLKDBG_WRITE_AIO);
             ret = bdrv_co_pwrite(bs->file, cluster_offset, s->cluster_size,
                                  s->cluster_cache, 0);
             if (ret < 0) {
@@ -491,7 +491,7 @@ get_cluster_offset(BlockDriverState *bs, uint64_t offset, int allocate,
                                                       NULL) < 0) {
                                 return -EIO;
                             }
-                            BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
+                            BLKDBG_CO_EVENT(bs->file, BLKDBG_WRITE_AIO);
                             ret = bdrv_co_pwrite(bs->file, cluster_offset + i,
                                                  BDRV_SECTOR_SIZE,
                                                  s->cluster_data, 0);
@@ -510,9 +510,9 @@ get_cluster_offset(BlockDriverState *bs, uint64_t offset, int allocate,
         tmp = cpu_to_be64(cluster_offset);
         l2_table[l2_index] = tmp;
         if (allocate == 2) {
-            BLKDBG_EVENT(bs->file, BLKDBG_L2_UPDATE_COMPRESSED);
+            BLKDBG_CO_EVENT(bs->file, BLKDBG_L2_UPDATE_COMPRESSED);
         } else {
-            BLKDBG_EVENT(bs->file, BLKDBG_L2_UPDATE);
+            BLKDBG_CO_EVENT(bs->file, BLKDBG_L2_UPDATE);
         }
         ret = bdrv_co_pwrite_sync(bs->file, l2_offset + l2_index * sizeof(tmp),
                                   sizeof(tmp), &tmp, 0);
@@ -595,7 +595,7 @@ decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
     if (s->cluster_cache_offset != coffset) {
         csize = cluster_offset >> (63 - s->cluster_bits);
         csize &= (s->cluster_size - 1);
-        BLKDBG_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
+        BLKDBG_CO_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
         ret = bdrv_co_pread(bs->file, coffset, csize, s->cluster_data, 0);
         if (ret < 0)
             return -1;
@@ -657,7 +657,7 @@ qcow_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
                 /* read from the base image */
                 qemu_co_mutex_unlock(&s->lock);
                 /* qcow2 emits this on bs->file instead of bs->backing */
-                BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
+                BLKDBG_CO_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
                 ret = bdrv_co_pread(bs->backing, offset, n, buf, 0);
                 qemu_co_mutex_lock(&s->lock);
                 if (ret < 0) {
@@ -680,7 +680,7 @@ qcow_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
                 break;
             }
             qemu_co_mutex_unlock(&s->lock);
-            BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
+            BLKDBG_CO_EVENT(bs->file, BLKDBG_READ_AIO);
             ret = bdrv_co_pread(bs->file, cluster_offset + offset_in_cluster,
                                 n, buf, 0);
             qemu_co_mutex_lock(&s->lock);
@@ -765,7 +765,7 @@ qcow_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
         }
 
         qemu_co_mutex_unlock(&s->lock);
-        BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
+        BLKDBG_CO_EVENT(bs->file, BLKDBG_WRITE_AIO);
         ret = bdrv_co_pwrite(bs->file, cluster_offset + offset_in_cluster,
                              n, buf, 0);
         qemu_co_mutex_lock(&s->lock);
@@ -1114,7 +1114,7 @@ qcow_co_pwritev_compressed(BlockDriverState *bs, int64_t offset, int64_t bytes,
     }
     cluster_offset &= s->cluster_offset_mask;
 
-    BLKDBG_EVENT(bs->file, BLKDBG_WRITE_COMPRESSED);
+    BLKDBG_CO_EVENT(bs->file, BLKDBG_WRITE_COMPRESSED);
     ret = bdrv_co_pwrite(bs->file, cluster_offset, out_len, out_buf, 0);
     if (ret < 0) {
         goto fail;
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 6172b2df40..f4f6cd6ad0 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -48,7 +48,7 @@ int coroutine_fn qcow2_shrink_l1_table(BlockDriverState *bs,
     fprintf(stderr, "shrink l1_table from %d to %d\n", s->l1_size, new_l1_size);
 #endif
 
-    BLKDBG_EVENT(bs->file, BLKDBG_L1_SHRINK_WRITE_TABLE);
+    BLKDBG_CO_EVENT(bs->file, BLKDBG_L1_SHRINK_WRITE_TABLE);
     ret = bdrv_co_pwrite_zeroes(bs->file,
                                 s->l1_table_offset + new_l1_size * L1E_SIZE,
                                 (s->l1_size - new_l1_size) * L1E_SIZE, 0);
@@ -61,7 +61,7 @@ int coroutine_fn qcow2_shrink_l1_table(BlockDriverState *bs,
         goto fail;
     }
 
-    BLKDBG_EVENT(bs->file, BLKDBG_L1_SHRINK_FREE_L2_CLUSTERS);
+    BLKDBG_CO_EVENT(bs->file, BLKDBG_L1_SHRINK_FREE_L2_CLUSTERS);
     for (i = s->l1_size - 1; i > new_l1_size - 1; i--) {
         if ((s->l1_table[i] & L1E_OFFSET_MASK) == 0) {
             continue;
@@ -501,7 +501,7 @@ do_perform_cow_read(BlockDriverState *bs, uint64_t src_cluster_offset,
         return 0;
     }
 
-    BLKDBG_EVENT(bs->file, BLKDBG_COW_READ);
+    BLKDBG_CO_EVENT(bs->file, BLKDBG_COW_READ);
 
     if (!bs->drv) {
         return -ENOMEDIUM;
@@ -551,7 +551,7 @@ do_perform_cow_write(BlockDriverState *bs, uint64_t cluster_offset,
         return ret;
     }
 
-    BLKDBG_EVENT(bs->file, BLKDBG_COW_WRITE);
+    BLKDBG_CO_EVENT(bs->file, BLKDBG_COW_WRITE);
     ret = bdrv_co_pwritev(s->data_file, cluster_offset + offset_in_cluster,
                           qiov->size, qiov, 0);
     if (ret < 0) {
@@ -871,7 +871,7 @@ qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs, uint64_t offset,
 
     /* compressed clusters never have the copied flag */
 
-    BLKDBG_EVENT(bs->file, BLKDBG_L2_UPDATE_COMPRESSED);
+    BLKDBG_CO_EVENT(bs->file, BLKDBG_L2_UPDATE_COMPRESSED);
     qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
     set_l2_entry(s, l2_slice, l2_index, cluster_offset);
     if (has_subclusters(s)) {
@@ -991,7 +991,7 @@ perform_cow(BlockDriverState *bs, QCowL2Meta *m)
         /* NOTE: we have a write_aio blkdebug event here followed by
          * a cow_write one in do_perform_cow_write(), but there's only
          * one single I/O operation */
-        BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
+        BLKDBG_CO_EVENT(bs->file, BLKDBG_WRITE_AIO);
         ret = do_perform_cow_write(bs, m->alloc_offset, start->offset, &qiov);
     } else {
         /* If there's no guest data then write both COW regions separately */
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index de527c3ee4..5095e99a37 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -118,7 +118,7 @@ int coroutine_fn qcow2_refcount_init(BlockDriverState *bs)
             ret = -ENOMEM;
             goto fail;
         }
-        BLKDBG_EVENT(bs->file, BLKDBG_REFTABLE_LOAD);
+        BLKDBG_CO_EVENT(bs->file, BLKDBG_REFTABLE_LOAD);
         ret = bdrv_co_pread(bs->file, s->refcount_table_offset,
                             refcount_table_size2, s->refcount_table, 0);
         if (ret < 0) {
@@ -1076,7 +1076,7 @@ int64_t coroutine_fn GRAPH_RDLOCK qcow2_alloc_bytes(BlockDriverState *bs, int si
     size_t free_in_cluster;
     int ret;
 
-    BLKDBG_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC_BYTES);
+    BLKDBG_CO_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC_BYTES);
     assert(size > 0 && size <= s->cluster_size);
     assert(!s->free_byte_offset || offset_into_cluster(s, s->free_byte_offset));
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 267a644aad..c51388e99d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2225,7 +2225,7 @@ qcow2_co_preadv_encrypted(BlockDriverState *bs,
         return -ENOMEM;
     }
 
-    BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
+    BLKDBG_CO_EVENT(bs->file, BLKDBG_READ_AIO);
     ret = bdrv_co_pread(s->data_file, host_offset, bytes, buf, 0);
     if (ret < 0) {
         goto fail;
@@ -2315,7 +2315,7 @@ qcow2_co_preadv_task(BlockDriverState *bs, QCow2SubclusterType subc_type,
     case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC:
         assert(bs->backing); /* otherwise handled in qcow2_co_preadv_part */
 
-        BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
+        BLKDBG_CO_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
         return bdrv_co_preadv_part(bs->backing, offset, bytes,
                                    qiov, qiov_offset, 0);
 
@@ -2329,7 +2329,7 @@ qcow2_co_preadv_task(BlockDriverState *bs, QCow2SubclusterType subc_type,
                                              offset, bytes, qiov, qiov_offset);
         }
 
-        BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
+        BLKDBG_CO_EVENT(bs->file, BLKDBG_READ_AIO);
         return bdrv_co_preadv_part(s->data_file, host_offset,
                                    bytes, qiov, qiov_offset, 0);
 
@@ -2539,7 +2539,7 @@ handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
             return ret;
         }
 
-        BLKDBG_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC_SPACE);
+        BLKDBG_CO_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC_SPACE);
         ret = bdrv_co_pwrite_zeroes(s->data_file, start_offset, nb_bytes,
                                     BDRV_REQ_NO_FALLBACK);
         if (ret < 0) {
@@ -2604,7 +2604,7 @@ int qcow2_co_pwritev_task(BlockDriverState *bs, uint64_t host_offset,
      * guest data now.
      */
     if (!merge_cow(offset, bytes, qiov, qiov_offset, l2meta)) {
-        BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
+        BLKDBG_CO_EVENT(bs->file, BLKDBG_WRITE_AIO);
         trace_qcow2_writev_data(qemu_coroutine_self(), host_offset);
         ret = bdrv_co_pwritev_part(s->data_file, host_offset,
                                    bytes, qiov, qiov_offset, 0);
@@ -4678,7 +4678,7 @@ qcow2_co_pwritev_compressed_task(BlockDriverState *bs,
         goto fail;
     }
 
-    BLKDBG_EVENT(s->data_file, BLKDBG_WRITE_COMPRESSED);
+    BLKDBG_CO_EVENT(s->data_file, BLKDBG_WRITE_COMPRESSED);
     ret = bdrv_co_pwrite(s->data_file, cluster_offset, out_len, out_buf, 0);
     if (ret < 0) {
         goto fail;
@@ -4797,7 +4797,7 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
 
     out_buf = qemu_blockalign(bs, s->cluster_size);
 
-    BLKDBG_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
+    BLKDBG_CO_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
     ret = bdrv_co_pread(bs->file, coffset, csize, buf, 0);
     if (ret < 0) {
         goto fail;
@@ -5344,7 +5344,7 @@ qcow2_co_save_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
         return offset;
     }
 
-    BLKDBG_EVENT(bs->file, BLKDBG_VMSTATE_SAVE);
+    BLKDBG_CO_EVENT(bs->file, BLKDBG_VMSTATE_SAVE);
     return bs->drv->bdrv_co_pwritev_part(bs, offset, qiov->size, qiov, 0, 0);
 }
 
@@ -5356,7 +5356,7 @@ qcow2_co_load_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
         return offset;
     }
 
-    BLKDBG_EVENT(bs->file, BLKDBG_VMSTATE_LOAD);
+    BLKDBG_CO_EVENT(bs->file, BLKDBG_VMSTATE_LOAD);
     return bs->drv->bdrv_co_preadv_part(bs, offset, qiov->size, qiov, 0, 0);
 }
 
diff --git a/block/qed-table.c b/block/qed-table.c
index 3b331ce709..f04520d4c8 100644
--- a/block/qed-table.c
+++ b/block/qed-table.c
@@ -122,7 +122,7 @@ int coroutine_fn qed_read_l1_table_sync(BDRVQEDState *s)
 int coroutine_fn qed_write_l1_table(BDRVQEDState *s, unsigned int index,
                                     unsigned int n)
 {
-    BLKDBG_EVENT(s->bs->file, BLKDBG_L1_UPDATE);
+    BLKDBG_CO_EVENT(s->bs->file, BLKDBG_L1_UPDATE);
     return qed_write_table(s, s->header.l1_table_offset,
                            s->l1_table, index, n, false);
 }
@@ -150,7 +150,7 @@ int coroutine_fn qed_read_l2_table(BDRVQEDState *s, QEDRequest *request,
     request->l2_table = qed_alloc_l2_cache_entry(&s->l2_cache);
     request->l2_table->table = qed_alloc_table(s);
 
-    BLKDBG_EVENT(s->bs->file, BLKDBG_L2_LOAD);
+    BLKDBG_CO_EVENT(s->bs->file, BLKDBG_L2_LOAD);
     ret = qed_read_table(s, offset, request->l2_table->table);
 
     if (ret) {
@@ -183,7 +183,7 @@ int coroutine_fn qed_write_l2_table(BDRVQEDState *s, QEDRequest *request,
                                     unsigned int index, unsigned int n,
                                     bool flush)
 {
-    BLKDBG_EVENT(s->bs->file, BLKDBG_L2_UPDATE);
+    BLKDBG_CO_EVENT(s->bs->file, BLKDBG_L2_UPDATE);
     return qed_write_table(s, request->l2_table->offset,
                            request->l2_table->table, index, n, flush);
 }
diff --git a/block/qed.c b/block/qed.c
index 2cab3540a9..b2604d9dad 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -883,7 +883,7 @@ static int coroutine_fn GRAPH_RDLOCK
 qed_read_backing_file(BDRVQEDState *s, uint64_t pos, QEMUIOVector *qiov)
 {
     if (s->bs->backing) {
-        BLKDBG_EVENT(s->bs->file, BLKDBG_READ_BACKING_AIO);
+        BLKDBG_CO_EVENT(s->bs->file, BLKDBG_READ_BACKING_AIO);
         return bdrv_co_preadv(s->bs->backing, pos, qiov->size, qiov, 0);
     }
     qemu_iovec_memset(qiov, 0, 0, qiov->size);
@@ -918,7 +918,7 @@ qed_copy_from_backing_file(BDRVQEDState *s, uint64_t pos, uint64_t len,
         goto out;
     }
 
-    BLKDBG_EVENT(s->bs->file, BLKDBG_COW_WRITE);
+    BLKDBG_CO_EVENT(s->bs->file, BLKDBG_COW_WRITE);
     ret = bdrv_co_pwritev(s->bs->file, offset, qiov.size, &qiov, 0);
     if (ret < 0) {
         goto out;
@@ -1070,7 +1070,7 @@ static int coroutine_fn GRAPH_RDLOCK qed_aio_write_main(QEDAIOCB *acb)
 
     trace_qed_aio_write_main(s, acb, 0, offset, acb->cur_qiov.size);
 
-    BLKDBG_EVENT(s->bs->file, BLKDBG_WRITE_AIO);
+    BLKDBG_CO_EVENT(s->bs->file, BLKDBG_WRITE_AIO);
     return bdrv_co_pwritev(s->bs->file, offset, acb->cur_qiov.size,
                            &acb->cur_qiov, 0);
 }
@@ -1324,7 +1324,7 @@ qed_aio_read_data(void *opaque, int ret, uint64_t offset, size_t len)
     } else if (ret != QED_CLUSTER_FOUND) {
         r = qed_read_backing_file(s, acb->cur_pos, &acb->cur_qiov);
     } else {
-        BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
+        BLKDBG_CO_EVENT(bs->file, BLKDBG_READ_AIO);
         r = bdrv_co_preadv(bs->file, offset, acb->cur_qiov.size,
                            &acb->cur_qiov, 0);
     }
diff --git a/block/raw-format.c b/block/raw-format.c
index e4f35268e6..a8bdee5279 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -214,7 +214,7 @@ raw_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
         return ret;
     }
 
-    BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
+    BLKDBG_CO_EVENT(bs->file, BLKDBG_READ_AIO);
     return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
 }
 
@@ -268,7 +268,7 @@ raw_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
         goto fail;
     }
 
-    BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
+    BLKDBG_CO_EVENT(bs->file, BLKDBG_WRITE_AIO);
     ret = bdrv_co_pwritev(bs->file, offset, bytes, qiov, flags);
 
 fail:
diff --git a/block/vmdk.c b/block/vmdk.c
index 234e671786..70066c2b01 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1438,7 +1438,7 @@ get_whole_cluster(BlockDriverState *bs, VmdkExtent *extent,
     if (skip_start_bytes > 0) {
         if (copy_from_backing) {
             /* qcow2 emits this on bs->file instead of bs->backing */
-            BLKDBG_EVENT(extent->file, BLKDBG_COW_READ);
+            BLKDBG_CO_EVENT(extent->file, BLKDBG_COW_READ);
             ret = bdrv_co_pread(bs->backing, offset, skip_start_bytes,
                                 whole_grain, 0);
             if (ret < 0) {
@@ -1446,7 +1446,7 @@ get_whole_cluster(BlockDriverState *bs, VmdkExtent *extent,
                 goto exit;
             }
         }
-        BLKDBG_EVENT(extent->file, BLKDBG_COW_WRITE);
+        BLKDBG_CO_EVENT(extent->file, BLKDBG_COW_WRITE);
         ret = bdrv_co_pwrite(extent->file, cluster_offset, skip_start_bytes,
                              whole_grain, 0);
         if (ret < 0) {
@@ -1458,7 +1458,7 @@ get_whole_cluster(BlockDriverState *bs, VmdkExtent *extent,
     if (skip_end_bytes < cluster_bytes) {
         if (copy_from_backing) {
             /* qcow2 emits this on bs->file instead of bs->backing */
-            BLKDBG_EVENT(extent->file, BLKDBG_COW_READ);
+            BLKDBG_CO_EVENT(extent->file, BLKDBG_COW_READ);
             ret = bdrv_co_pread(bs->backing, offset + skip_end_bytes,
                                 cluster_bytes - skip_end_bytes,
                                 whole_grain + skip_end_bytes, 0);
@@ -1467,7 +1467,7 @@ get_whole_cluster(BlockDriverState *bs, VmdkExtent *extent,
                 goto exit;
             }
         }
-        BLKDBG_EVENT(extent->file, BLKDBG_COW_WRITE);
+        BLKDBG_CO_EVENT(extent->file, BLKDBG_COW_WRITE);
         ret = bdrv_co_pwrite(extent->file, cluster_offset + skip_end_bytes,
                              cluster_bytes - skip_end_bytes,
                              whole_grain + skip_end_bytes, 0);
@@ -1488,7 +1488,7 @@ vmdk_L2update(VmdkExtent *extent, VmdkMetaData *m_data, uint32_t offset)
 {
     offset = cpu_to_le32(offset);
     /* update L2 table */
-    BLKDBG_EVENT(extent->file, BLKDBG_L2_UPDATE);
+    BLKDBG_CO_EVENT(extent->file, BLKDBG_L2_UPDATE);
     if (bdrv_co_pwrite(extent->file,
                        ((int64_t)m_data->l2_offset * 512)
                            + (m_data->l2_index * sizeof(offset)),
@@ -1618,7 +1618,7 @@ get_cluster_offset(BlockDriverState *bs, VmdkExtent *extent,
         }
     }
     l2_table = (char *)extent->l2_cache + (min_index * l2_size_bytes);
-    BLKDBG_EVENT(extent->file, BLKDBG_L2_LOAD);
+    BLKDBG_CO_EVENT(extent->file, BLKDBG_L2_LOAD);
     if (bdrv_co_pread(extent->file,
                 (int64_t)l2_offset * 512,
                 l2_size_bytes,
@@ -1829,12 +1829,12 @@ vmdk_write_extent(VmdkExtent *extent, int64_t cluster_offset,
         n_bytes = buf_len + sizeof(VmdkGrainMarker);
         qemu_iovec_init_buf(&local_qiov, data, n_bytes);
 
-        BLKDBG_EVENT(extent->file, BLKDBG_WRITE_COMPRESSED);
+        BLKDBG_CO_EVENT(extent->file, BLKDBG_WRITE_COMPRESSED);
     } else {
         qemu_iovec_init(&local_qiov, qiov->niov);
         qemu_iovec_concat(&local_qiov, qiov, qiov_offset, n_bytes);
 
-        BLKDBG_EVENT(extent->file, BLKDBG_WRITE_AIO);
+        BLKDBG_CO_EVENT(extent->file, BLKDBG_WRITE_AIO);
     }
 
     write_offset = cluster_offset + offset_in_cluster;
@@ -1876,7 +1876,7 @@ vmdk_read_extent(VmdkExtent *extent, int64_t cluster_offset,
 
 
     if (!extent->compressed) {
-        BLKDBG_EVENT(extent->file, BLKDBG_READ_AIO);
+        BLKDBG_CO_EVENT(extent->file, BLKDBG_READ_AIO);
         ret = bdrv_co_preadv(extent->file,
                              cluster_offset + offset_in_cluster, bytes,
                              qiov, 0);
@@ -1890,7 +1890,7 @@ vmdk_read_extent(VmdkExtent *extent, int64_t cluster_offset,
     buf_bytes = cluster_bytes * 2;
     cluster_buf = g_malloc(buf_bytes);
     uncomp_buf = g_malloc(cluster_bytes);
-    BLKDBG_EVENT(extent->file, BLKDBG_READ_COMPRESSED);
+    BLKDBG_CO_EVENT(extent->file, BLKDBG_READ_COMPRESSED);
     ret = bdrv_co_pread(extent->file, cluster_offset, buf_bytes, cluster_buf,
                         0);
     if (ret < 0) {
@@ -1968,7 +1968,7 @@ vmdk_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
                 qemu_iovec_concat(&local_qiov, qiov, bytes_done, n_bytes);
 
                 /* qcow2 emits this on bs->file instead of bs->backing */
-                BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
+                BLKDBG_CO_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
                 ret = bdrv_co_preadv(bs->backing, offset, n_bytes,
                                      &local_qiov, 0);
                 if (ret < 0) {
@@ -2909,7 +2909,7 @@ vmdk_co_check(BlockDriverState *bs, BdrvCheckResult *result, BdrvCheckMode fix)
     BDRVVmdkState *s = bs->opaque;
     VmdkExtent *extent = NULL;
     int64_t sector_num = 0;
-    int64_t total_sectors = bdrv_nb_sectors(bs);
+    int64_t total_sectors = bdrv_co_nb_sectors(bs);
     int ret;
     uint64_t cluster_offset;
 
-- 
2.41.0


