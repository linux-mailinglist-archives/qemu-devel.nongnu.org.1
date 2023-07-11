Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E6074F739
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 19:27:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJH7n-0005yS-Qz; Tue, 11 Jul 2023 13:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qJH7k-0005va-PA; Tue, 11 Jul 2023 13:26:04 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qJH7h-0006yS-Lg; Tue, 11 Jul 2023 13:26:04 -0400
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1qJH6C-008F35-00;
 Tue, 11 Jul 2023 19:25:44 +0200
To: qemu-block@nongnu.org,
	qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 vsementsov@yandex-team.ru, eblake@redhat.com,
 andrey.drobyshev@virtuozzo.com, den@openvz.org
Subject: [PATCH v2 2/3] block/io: align requests to subcluster_size
Date: Tue, 11 Jul 2023 20:25:52 +0300
Message-Id: <20230711172553.234055-3-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230711172553.234055-1-andrey.drobyshev@virtuozzo.com>
References: <20230711172553.234055-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
From:  Andrey Drobyshev via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

When target image is using subclusters, and we align the request during
copy-on-read, it makes sense to align to subcluster_size rather than
cluster_size.  Otherwise we end up with unnecessary allocations.

This commit renames bdrv_round_to_clusters() to bdrv_round_to_subclusters()
and utilizes subcluster_size field of BlockDriverInfo to make necessary
alignments.  It affects copy-on-read as well as mirror job (which is
using bdrv_round_to_clusters()).

This change also fixes the following bug with failing assert (covered by
the test in the subsequent commit):

qemu-img create -f qcow2 base.qcow2 64K
qemu-img create -f qcow2 -o extended_l2=on,backing_file=base.qcow2,backing_fmt=qcow2 img.qcow2 64K
qemu-io -c "write -P 0xaa 0 2K" img.qcow2
qemu-io -C -c "read -P 0x00 2K 62K" img.qcow2

qemu-io: ../block/io.c:1236: bdrv_co_do_copy_on_readv: Assertion `skip_bytes < pnum' failed.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/io.c               | 50 ++++++++++++++++++++--------------------
 block/mirror.c           |  8 +++----
 include/block/block-io.h |  8 +++----
 3 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/block/io.c b/block/io.c
index e8293d6b26..4a2fef6a77 100644
--- a/block/io.c
+++ b/block/io.c
@@ -728,21 +728,21 @@ BdrvTrackedRequest *coroutine_fn bdrv_co_get_self_request(BlockDriverState *bs)
 }
 
 /**
- * Round a region to cluster boundaries
+ * Round a region to subcluster (if supported) or cluster boundaries
  */
 void coroutine_fn GRAPH_RDLOCK
-bdrv_round_to_clusters(BlockDriverState *bs, int64_t offset, int64_t bytes,
-                       int64_t *cluster_offset, int64_t *cluster_bytes)
+bdrv_round_to_subclusters(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                          int64_t *align_offset, int64_t *align_bytes)
 {
     BlockDriverInfo bdi;
     IO_CODE();
-    if (bdrv_co_get_info(bs, &bdi) < 0 || bdi.cluster_size == 0) {
-        *cluster_offset = offset;
-        *cluster_bytes = bytes;
+    if (bdrv_co_get_info(bs, &bdi) < 0 || bdi.subcluster_size == 0) {
+        *align_offset = offset;
+        *align_bytes = bytes;
     } else {
-        int64_t c = bdi.cluster_size;
-        *cluster_offset = QEMU_ALIGN_DOWN(offset, c);
-        *cluster_bytes = QEMU_ALIGN_UP(offset - *cluster_offset + bytes, c);
+        int64_t c = bdi.subcluster_size;
+        *align_offset = QEMU_ALIGN_DOWN(offset, c);
+        *align_bytes = QEMU_ALIGN_UP(offset - *align_offset + bytes, c);
     }
 }
 
@@ -1168,8 +1168,8 @@ bdrv_co_do_copy_on_readv(BdrvChild *child, int64_t offset, int64_t bytes,
     void *bounce_buffer = NULL;
 
     BlockDriver *drv = bs->drv;
-    int64_t cluster_offset;
-    int64_t cluster_bytes;
+    int64_t align_offset;
+    int64_t align_bytes;
     int64_t skip_bytes;
     int ret;
     int max_transfer = MIN_NON_ZERO(bs->bl.max_transfer,
@@ -1203,28 +1203,28 @@ bdrv_co_do_copy_on_readv(BdrvChild *child, int64_t offset, int64_t bytes,
      * BDRV_REQUEST_MAX_BYTES (even when the original read did not), which
      * is one reason we loop rather than doing it all at once.
      */
-    bdrv_round_to_clusters(bs, offset, bytes, &cluster_offset, &cluster_bytes);
-    skip_bytes = offset - cluster_offset;
+    bdrv_round_to_subclusters(bs, offset, bytes, &align_offset, &align_bytes);
+    skip_bytes = offset - align_offset;
 
     trace_bdrv_co_do_copy_on_readv(bs, offset, bytes,
-                                   cluster_offset, cluster_bytes);
+                                   align_offset, align_bytes);
 
-    while (cluster_bytes) {
+    while (align_bytes) {
         int64_t pnum;
 
         if (skip_write) {
             ret = 1; /* "already allocated", so nothing will be copied */
-            pnum = MIN(cluster_bytes, max_transfer);
+            pnum = MIN(align_bytes, max_transfer);
         } else {
-            ret = bdrv_is_allocated(bs, cluster_offset,
-                                    MIN(cluster_bytes, max_transfer), &pnum);
+            ret = bdrv_is_allocated(bs, align_offset,
+                                    MIN(align_bytes, max_transfer), &pnum);
             if (ret < 0) {
                 /*
                  * Safe to treat errors in querying allocation as if
                  * unallocated; we'll probably fail again soon on the
                  * read, but at least that will set a decent errno.
                  */
-                pnum = MIN(cluster_bytes, max_transfer);
+                pnum = MIN(align_bytes, max_transfer);
             }
 
             /* Stop at EOF if the image ends in the middle of the cluster */
@@ -1242,7 +1242,7 @@ bdrv_co_do_copy_on_readv(BdrvChild *child, int64_t offset, int64_t bytes,
             /* Must copy-on-read; use the bounce buffer */
             pnum = MIN(pnum, MAX_BOUNCE_BUFFER);
             if (!bounce_buffer) {
-                int64_t max_we_need = MAX(pnum, cluster_bytes - pnum);
+                int64_t max_we_need = MAX(pnum, align_bytes - pnum);
                 int64_t max_allowed = MIN(max_transfer, MAX_BOUNCE_BUFFER);
                 int64_t bounce_buffer_len = MIN(max_we_need, max_allowed);
 
@@ -1254,7 +1254,7 @@ bdrv_co_do_copy_on_readv(BdrvChild *child, int64_t offset, int64_t bytes,
             }
             qemu_iovec_init_buf(&local_qiov, bounce_buffer, pnum);
 
-            ret = bdrv_driver_preadv(bs, cluster_offset, pnum,
+            ret = bdrv_driver_preadv(bs, align_offset, pnum,
                                      &local_qiov, 0, 0);
             if (ret < 0) {
                 goto err;
@@ -1266,13 +1266,13 @@ bdrv_co_do_copy_on_readv(BdrvChild *child, int64_t offset, int64_t bytes,
                 /* FIXME: Should we (perhaps conditionally) be setting
                  * BDRV_REQ_MAY_UNMAP, if it will allow for a sparser copy
                  * that still correctly reads as zero? */
-                ret = bdrv_co_do_pwrite_zeroes(bs, cluster_offset, pnum,
+                ret = bdrv_co_do_pwrite_zeroes(bs, align_offset, pnum,
                                                BDRV_REQ_WRITE_UNCHANGED);
             } else {
                 /* This does not change the data on the disk, it is not
                  * necessary to flush even in cache=writethrough mode.
                  */
-                ret = bdrv_driver_pwritev(bs, cluster_offset, pnum,
+                ret = bdrv_driver_pwritev(bs, align_offset, pnum,
                                           &local_qiov, 0,
                                           BDRV_REQ_WRITE_UNCHANGED);
             }
@@ -1301,8 +1301,8 @@ bdrv_co_do_copy_on_readv(BdrvChild *child, int64_t offset, int64_t bytes,
             }
         }
 
-        cluster_offset += pnum;
-        cluster_bytes -= pnum;
+        align_offset += pnum;
+        align_bytes -= pnum;
         progress += pnum - skip_bytes;
         skip_bytes = 0;
     }
diff --git a/block/mirror.c b/block/mirror.c
index d3cacd1708..e213a892db 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -283,8 +283,8 @@ static int coroutine_fn mirror_cow_align(MirrorBlockJob *s, int64_t *offset,
     need_cow |= !test_bit((*offset + *bytes - 1) / s->granularity,
                           s->cow_bitmap);
     if (need_cow) {
-        bdrv_round_to_clusters(blk_bs(s->target), *offset, *bytes,
-                               &align_offset, &align_bytes);
+        bdrv_round_to_subclusters(blk_bs(s->target), *offset, *bytes,
+                                  &align_offset, &align_bytes);
     }
 
     if (align_bytes > max_bytes) {
@@ -576,8 +576,8 @@ static void coroutine_fn mirror_iteration(MirrorBlockJob *s)
             int64_t target_offset;
             int64_t target_bytes;
             WITH_GRAPH_RDLOCK_GUARD() {
-                bdrv_round_to_clusters(blk_bs(s->target), offset, io_bytes,
-                                       &target_offset, &target_bytes);
+                bdrv_round_to_subclusters(blk_bs(s->target), offset, io_bytes,
+                                          &target_offset, &target_bytes);
             }
             if (target_offset == offset &&
                 target_bytes == io_bytes) {
diff --git a/include/block/block-io.h b/include/block/block-io.h
index 4415506e40..6db48f2d35 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -189,10 +189,10 @@ bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi);
 ImageInfoSpecific *bdrv_get_specific_info(BlockDriverState *bs,
                                           Error **errp);
 BlockStatsSpecific *bdrv_get_specific_stats(BlockDriverState *bs);
-void bdrv_round_to_clusters(BlockDriverState *bs,
-                            int64_t offset, int64_t bytes,
-                            int64_t *cluster_offset,
-                            int64_t *cluster_bytes);
+void bdrv_round_to_subclusters(BlockDriverState *bs,
+                               int64_t offset, int64_t bytes,
+                               int64_t *cluster_offset,
+                               int64_t *cluster_bytes);
 
 void bdrv_get_backing_filename(BlockDriverState *bs,
                                char *filename, int filename_size);
-- 
2.39.3


