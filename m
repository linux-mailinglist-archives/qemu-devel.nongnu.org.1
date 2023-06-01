Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F41719B43
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:54:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4gqr-0001U6-QZ; Thu, 01 Jun 2023 07:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqk-0001Qy-Su
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:52:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqh-0000Oh-0l
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685620330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NJZxX/GSw0FE7vhnB8bRKXEkHq0sonSPw98sySoYJqU=;
 b=A/7ZOn3JoDu1hL3AD9AbgB9g6ovFAFt+RBhmtzqxMxwqWCAZgYZWomO2/er2j1dRWVFufo
 pBalpVPXymnJPHJhwl/J5a7llRavxQBuT7TjK3Oc4bRXQ+zlg3PspU6Ht4cXLYOyLWincX
 MpqyMcWavfR4GhLu8sgmeOGcxcSOxLA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-oExuQOm2NTevHOs-OeKvnQ-1; Thu, 01 Jun 2023 07:52:09 -0400
X-MC-Unique: oExuQOm2NTevHOs-OeKvnQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-96f9996fb3dso48739366b.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685620327; x=1688212327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NJZxX/GSw0FE7vhnB8bRKXEkHq0sonSPw98sySoYJqU=;
 b=Wfvcr1K1lPu0VmZ7GSmp6sCllbR3t/aN+ty5q7gbVi9NzCLCPz86JZHtNyYvwER24K
 IQLvM3l8Q6Jxw8/qaRI4BgSajqQ4CYPoMvqAhscBLjE8ha0vypEX1KOrC+dw3ACzoxWJ
 7y/IVIW3qI4xYz2+zXTE8chQg4PSRmOuFMx43Y2Kj1qNToReWW0i3yPW4HhRTny6+rmJ
 Jz1Fn5U1EqfIE/2l/w6f0m815FrMXXPPtSLKSN43pZyKi6IUdofndDJNqRQ2bd53nW84
 xg8nTTO7ZJmlTtFni2p91Zo7PL5Aqyicm0ZKaG5iKrI/5UP4yEcOehzLj65ks3eqDq+s
 MuVQ==
X-Gm-Message-State: AC+VfDzVSzOG71TDCsK5+C/jKCixGC9iLE1gCUKE2kVG37Br6KRKUNt6
 2ox5CeGloJO5hQdi/SrlJaph/2iuGeTZ+QDPCLFqIHPuA6zgLaldVW14AtNg0RhoOBr6S3p3ssu
 6/oJSCsJxzu5ys+sxCCy/7a5kDZ/mIDap7XbpPR5nBiXd9zyMdLJf0TU6QSNJDPORxag7IdGxfw
 g=
X-Received: by 2002:a17:907:7da6:b0:96a:1cbf:3dcc with SMTP id
 oz38-20020a1709077da600b0096a1cbf3dccmr9131817ejc.54.1685620327313; 
 Thu, 01 Jun 2023 04:52:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5JYaz68Hu5D+3nKov5IaVYyLCToRLKSJEn/tUqpy09IiPqv+XNnJuarVlBkuFXf7G3W7Fpng==
X-Received: by 2002:a17:907:7da6:b0:96a:1cbf:3dcc with SMTP id
 oz38-20020a1709077da600b0096a1cbf3dccmr9131796ejc.54.1685620326890; 
 Thu, 01 Jun 2023 04:52:06 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 dv22-20020a170906b81600b0096f78953b77sm10516410ejb.147.2023.06.01.04.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 04:52:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH 12/12] block: use bdrv_co_debug_event in coroutine context
Date: Thu,  1 Jun 2023 13:51:45 +0200
Message-Id: <20230601115145.196465-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601115145.196465-1-pbonzini@redhat.com>
References: <20230601115145.196465-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

bdrv_co_debug_event was recently introduced, with bdrv_debug_event
becoming a wrapper for use in unknown context.  Because most of the
time bdrv_debug_event is used on a BdrvChild via the wrapper macro
BLKDBG_EVENT, introduce a similar macro BLKDBG_CO_EVENT that calls
bdrv_co_debug_event, and switch whenever possible.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/io.c               |  4 ++--
 block/qcow.c             | 24 ++++++++++++------------
 block/qcow2-cluster.c    | 12 ++++++------
 block/qcow2-refcount.c   |  4 ++--
 block/qcow2.c            | 18 +++++++++---------
 block/qed-table.c        |  6 +++---
 block/qed.c              |  8 ++++----
 block/raw-format.c       |  4 ++--
 block/vmdk.c             | 24 ++++++++++++------------
 include/block/block-io.h |  7 +++++++
 10 files changed, 59 insertions(+), 52 deletions(-)

diff --git a/block/io.c b/block/io.c
index f537421ef523..e48b7454cfd8 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2827,7 +2827,7 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
     }
 
     /* Write back cached data to the OS even with cache=unsafe */
-    BLKDBG_EVENT(primary_child, BLKDBG_FLUSH_TO_OS);
+    BLKDBG_CO_EVENT(primary_child, BLKDBG_FLUSH_TO_OS);
     if (bs->drv->bdrv_co_flush_to_os) {
         ret = bs->drv->bdrv_co_flush_to_os(bs);
         if (ret < 0) {
@@ -2845,7 +2845,7 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
         goto flush_children;
     }
 
-    BLKDBG_EVENT(primary_child, BLKDBG_FLUSH_TO_DISK);
+    BLKDBG_CO_EVENT(primary_child, BLKDBG_FLUSH_TO_DISK);
     if (!bs->drv) {
         /* bs->drv->bdrv_co_flush() might have ejected the BDS
          * (even in case of apparent success) */
diff --git a/block/qcow.c b/block/qcow.c
index 4aee835e8c36..94aba110fd32 100644
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
index 427c96c1d039..8ba8722a19cf 100644
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
index de527c3ee496..5095e99a378e 100644
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
index 98dcbe472b77..fe8ed866cdbc 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2207,7 +2207,7 @@ qcow2_co_preadv_encrypted(BlockDriverState *bs,
         return -ENOMEM;
     }
 
-    BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
+    BLKDBG_CO_EVENT(bs->file, BLKDBG_READ_AIO);
     ret = bdrv_co_pread(s->data_file, host_offset, bytes, buf, 0);
     if (ret < 0) {
         goto fail;
@@ -2297,7 +2297,7 @@ qcow2_co_preadv_task(BlockDriverState *bs, QCow2SubclusterType subc_type,
     case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC:
         assert(bs->backing); /* otherwise handled in qcow2_co_preadv_part */
 
-        BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
+        BLKDBG_CO_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
         return bdrv_co_preadv_part(bs->backing, offset, bytes,
                                    qiov, qiov_offset, 0);
 
@@ -2311,7 +2311,7 @@ qcow2_co_preadv_task(BlockDriverState *bs, QCow2SubclusterType subc_type,
                                              offset, bytes, qiov, qiov_offset);
         }
 
-        BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
+        BLKDBG_CO_EVENT(bs->file, BLKDBG_READ_AIO);
         return bdrv_co_preadv_part(s->data_file, host_offset,
                                    bytes, qiov, qiov_offset, 0);
 
@@ -2521,7 +2521,7 @@ handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
             return ret;
         }
 
-        BLKDBG_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC_SPACE);
+        BLKDBG_CO_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC_SPACE);
         ret = bdrv_co_pwrite_zeroes(s->data_file, start_offset, nb_bytes,
                                     BDRV_REQ_NO_FALLBACK);
         if (ret < 0) {
@@ -2586,7 +2586,7 @@ int qcow2_co_pwritev_task(BlockDriverState *bs, uint64_t host_offset,
      * guest data now.
      */
     if (!merge_cow(offset, bytes, qiov, qiov_offset, l2meta)) {
-        BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
+        BLKDBG_CO_EVENT(bs->file, BLKDBG_WRITE_AIO);
         trace_qcow2_writev_data(qemu_coroutine_self(), host_offset);
         ret = bdrv_co_pwritev_part(s->data_file, host_offset,
                                    bytes, qiov, qiov_offset, 0);
@@ -4661,7 +4661,7 @@ qcow2_co_pwritev_compressed_task(BlockDriverState *bs,
         goto fail;
     }
 
-    BLKDBG_EVENT(s->data_file, BLKDBG_WRITE_COMPRESSED);
+    BLKDBG_CO_EVENT(s->data_file, BLKDBG_WRITE_COMPRESSED);
     ret = bdrv_co_pwrite(s->data_file, cluster_offset, out_len, out_buf, 0);
     if (ret < 0) {
         goto fail;
@@ -4780,7 +4780,7 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
 
     out_buf = qemu_blockalign(bs, s->cluster_size);
 
-    BLKDBG_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
+    BLKDBG_CO_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
     ret = bdrv_co_pread(bs->file, coffset, csize, buf, 0);
     if (ret < 0) {
         goto fail;
@@ -5327,7 +5327,7 @@ qcow2_co_save_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
         return offset;
     }
 
-    BLKDBG_EVENT(bs->file, BLKDBG_VMSTATE_SAVE);
+    BLKDBG_CO_EVENT(bs->file, BLKDBG_VMSTATE_SAVE);
     return bs->drv->bdrv_co_pwritev_part(bs, offset, qiov->size, qiov, 0, 0);
 }
 
@@ -5339,7 +5339,7 @@ qcow2_co_load_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
         return offset;
     }
 
-    BLKDBG_EVENT(bs->file, BLKDBG_VMSTATE_LOAD);
+    BLKDBG_CO_EVENT(bs->file, BLKDBG_VMSTATE_LOAD);
     return bs->drv->bdrv_co_preadv_part(bs, offset, qiov->size, qiov, 0, 0);
 }
 
diff --git a/block/qed-table.c b/block/qed-table.c
index 3b331ce70986..f04520d4c834 100644
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
index 382c05c83fef..5fdbcb0de7b0 100644
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
index e4f35268e6f3..a8bdee5279ad 100644
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
index c64f2eacc03f..82d8f5efe961 100644
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
 
diff --git a/include/block/block-io.h b/include/block/block-io.h
index 3946bbefc5c2..331a549b79b5 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -232,6 +232,13 @@ bdrv_co_debug_event(BlockDriverState *bs, BlkdebugEvent event);
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
-- 
2.40.1


