Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 767C7AB7BA3
	for <lists+qemu-devel@lfdr.de>; Thu, 15 May 2025 04:32:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFOLr-0007F8-JC; Wed, 14 May 2025 22:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uFOLh-0007D5-Ro
 for qemu-devel@nongnu.org; Wed, 14 May 2025 22:29:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uFOLc-00044T-IL
 for qemu-devel@nongnu.org; Wed, 14 May 2025 22:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747276163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MeXQE2FRJZtia6HCeAw2QEBuNFkAtvieRC3rANMWfL8=;
 b=PolcgO3UzDT0x5DAzu9Qx/NPI7gol/UU8+Nk32jg7ayPQ7Vztb4nWs3LbjTqaKDS92b12I
 V3hsVMavyPO8CKvZDN5Oog8v8oBXQo7BeBqwiqiJ050ebHDtvzlgeaG5fHFksru5MmxQdV
 ffHJd3weD/XIYPhBDn6YQNKrXZc+1jo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-lTM5U7pLOp-4iFBhL0EyOQ-1; Wed,
 14 May 2025 22:29:19 -0400
X-MC-Unique: lTM5U7pLOp-4iFBhL0EyOQ-1
X-Mimecast-MFC-AGG-ID: lTM5U7pLOp-4iFBhL0EyOQ_1747276157
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60C71180035E; Thu, 15 May 2025 02:29:16 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.66])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BEA321955F24; Thu, 15 May 2025 02:29:10 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@dlhnet.de>,
 "Denis V. Lunev" <den@openvz.org>, Alberto Garcia <berto@igalia.com>,
 Ilya Dryomov <idryomov@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-block@nongnu.org (open list:blkdebug),
 integration@gluster.org (open list:GLUSTER)
Subject: [PULL 01/14] block: Expand block status mode from bool to flags
Date: Wed, 14 May 2025 21:28:44 -0500
Message-ID: <20250515022904.575509-17-eblake@redhat.com>
In-Reply-To: <20250515022904.575509-16-eblake@redhat.com>
References: <20250515022904.575509-16-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patch is purely mechanical, changing bool want_zero into an
unsigned int for bitwise-or of flags.  As of this patch, all
implementations are unchanged (the old want_zero==true is now
mode==BDRV_WANT_PRECISE which is a superset of BDRV_WANT_ZERO); but
the callers in io.c that used to pass want_zero==false are now
prepared for future driver changes that can now distinguish bewteen
BDRV_WANT_ZERO vs. BDRV_WANT_ALLOCATED.  The next patch will actually
change the file-posix driver along those lines, now that we have
more-specific hints.

As for the background why this patch is useful: right now, the
file-posix driver recognizes that if allocation is being queried, the
entire image can be reported as allocated (there is no backing file to
refer to) - but this throws away information on whether the entire
image reads as zero (trivially true if lseek(SEEK_HOLE) at offset 0
returns -ENXIO, a bit more complicated to prove if the raw file was
created with 'qemu-img create' since we intentionally allocate a small
chunk of all-zero data to help with alignment probing).  Later patches
will add a generic algorithm for seeing if an entire file reads as
zeroes.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20250509204341.3553601-16-eblake@redhat.com>
---
 block/coroutines.h               |  4 +--
 include/block/block-common.h     | 11 +++++++
 include/block/block_int-common.h | 27 +++++++++--------
 include/block/block_int-io.h     |  4 +--
 block/io.c                       | 51 ++++++++++++++++----------------
 block/blkdebug.c                 |  6 ++--
 block/copy-before-write.c        |  4 +--
 block/file-posix.c               |  4 +--
 block/gluster.c                  |  4 +--
 block/iscsi.c                    |  6 ++--
 block/nbd.c                      |  4 +--
 block/null.c                     |  6 ++--
 block/parallels.c                |  6 ++--
 block/qcow.c                     |  2 +-
 block/qcow2.c                    |  6 ++--
 block/qed.c                      |  6 ++--
 block/quorum.c                   |  4 +--
 block/raw-format.c               |  4 +--
 block/rbd.c                      |  6 ++--
 block/snapshot-access.c          |  4 +--
 block/vdi.c                      |  4 +--
 block/vmdk.c                     |  2 +-
 block/vpc.c                      |  2 +-
 block/vvfat.c                    |  6 ++--
 tests/unit/test-block-iothread.c |  2 +-
 25 files changed, 99 insertions(+), 86 deletions(-)

diff --git a/block/coroutines.h b/block/coroutines.h
index 79e5efbf752..892646bb7aa 100644
--- a/block/coroutines.h
+++ b/block/coroutines.h
@@ -47,7 +47,7 @@ int coroutine_fn GRAPH_RDLOCK
 bdrv_co_common_block_status_above(BlockDriverState *bs,
                                   BlockDriverState *base,
                                   bool include_base,
-                                  bool want_zero,
+                                  unsigned int mode,
                                   int64_t offset,
                                   int64_t bytes,
                                   int64_t *pnum,
@@ -78,7 +78,7 @@ int co_wrapper_mixed_bdrv_rdlock
 bdrv_common_block_status_above(BlockDriverState *bs,
                                BlockDriverState *base,
                                bool include_base,
-                               bool want_zero,
+                               unsigned int mode,
                                int64_t offset,
                                int64_t bytes,
                                int64_t *pnum,
diff --git a/include/block/block-common.h b/include/block/block-common.h
index 0b831ef87b1..c8c626daeaa 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -333,6 +333,17 @@ typedef enum {
 #define BDRV_BLOCK_RECURSE      0x40
 #define BDRV_BLOCK_COMPRESSED   0x80

+/*
+ * Block status hints: the bitwise-or of these flags emphasize what
+ * the caller hopes to learn, and some drivers may be able to give
+ * faster answers by doing less work when the hint permits.
+ */
+#define BDRV_WANT_ZERO          BDRV_BLOCK_ZERO
+#define BDRV_WANT_OFFSET_VALID  BDRV_BLOCK_OFFSET_VALID
+#define BDRV_WANT_ALLOCATED     BDRV_BLOCK_ALLOCATED
+#define BDRV_WANT_PRECISE       (BDRV_WANT_ZERO | BDRV_WANT_OFFSET_VALID | \
+                                 BDRV_WANT_OFFSET_VALID)
+
 typedef QTAILQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry) BlockReopenQueue;

 typedef struct BDRVReopenState {
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 0d8187f6567..2982dd31180 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -604,15 +604,16 @@ struct BlockDriver {
      * according to the current layer, and should only need to set
      * BDRV_BLOCK_DATA, BDRV_BLOCK_ZERO, BDRV_BLOCK_OFFSET_VALID,
      * and/or BDRV_BLOCK_RAW; if the current layer defers to a backing
-     * layer, the result should be 0 (and not BDRV_BLOCK_ZERO).  See
-     * block.h for the overall meaning of the bits.  As a hint, the
-     * flag want_zero is true if the caller cares more about precise
-     * mappings (favor accurate _OFFSET_VALID/_ZERO) or false for
-     * overall allocation (favor larger *pnum, perhaps by reporting
-     * _DATA instead of _ZERO).  The block layer guarantees input
-     * clamped to bdrv_getlength() and aligned to request_alignment,
-     * as well as non-NULL pnum, map, and file; in turn, the driver
-     * must return an error or set pnum to an aligned non-zero value.
+     * layer, the result should be 0 (and not BDRV_BLOCK_ZERO).  The
+     * caller will synthesize BDRV_BLOCK_ALLOCATED based on the
+     * non-zero results.  See block.h for the overall meaning of the
+     * bits.  As a hint, the flags in @mode may include a bitwise-or
+     * of BDRV_WANT_ALLOCATED, BDRV_WANT_OFFSET_VALID, or
+     * BDRV_WANT_ZERO based on what the caller is looking for in the
+     * results.  The block layer guarantees input clamped to
+     * bdrv_getlength() and aligned to request_alignment, as well as
+     * non-NULL pnum, map, and file; in turn, the driver must return
+     * an error or set pnum to an aligned non-zero value.
      *
      * Note that @bytes is just a hint on how big of a region the
      * caller wants to inspect.  It is not a limit on *pnum.
@@ -624,8 +625,8 @@ struct BlockDriver {
      * to clamping *pnum for return to its caller.
      */
     int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_block_status)(
-        BlockDriverState *bs,
-        bool want_zero, int64_t offset, int64_t bytes, int64_t *pnum,
+        BlockDriverState *bs, unsigned int mode,
+        int64_t offset, int64_t bytes, int64_t *pnum,
         int64_t *map, BlockDriverState **file);

     /*
@@ -649,8 +650,8 @@ struct BlockDriver {
         QEMUIOVector *qiov, size_t qiov_offset);

     int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_snapshot_block_status)(
-        BlockDriverState *bs, bool want_zero, int64_t offset, int64_t bytes,
-        int64_t *pnum, int64_t *map, BlockDriverState **file);
+        BlockDriverState *bs, unsigned int mode, int64_t offset,
+        int64_t bytes, int64_t *pnum, int64_t *map, BlockDriverState **file);

     int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_pdiscard_snapshot)(
         BlockDriverState *bs, int64_t offset, int64_t bytes);
diff --git a/include/block/block_int-io.h b/include/block/block_int-io.h
index 4a7cf2b4fdc..4f94eb3c5a2 100644
--- a/include/block/block_int-io.h
+++ b/include/block/block_int-io.h
@@ -38,8 +38,8 @@
 int coroutine_fn GRAPH_RDLOCK bdrv_co_preadv_snapshot(BdrvChild *child,
     int64_t offset, int64_t bytes, QEMUIOVector *qiov, size_t qiov_offset);
 int coroutine_fn GRAPH_RDLOCK bdrv_co_snapshot_block_status(
-    BlockDriverState *bs, bool want_zero, int64_t offset, int64_t bytes,
-    int64_t *pnum, int64_t *map, BlockDriverState **file);
+    BlockDriverState *bs, unsigned int mode, int64_t offset,
+    int64_t bytes, int64_t *pnum, int64_t *map, BlockDriverState **file);
 int coroutine_fn GRAPH_RDLOCK bdrv_co_pdiscard_snapshot(BlockDriverState *bs,
     int64_t offset, int64_t bytes);

diff --git a/block/io.c b/block/io.c
index 6d98b0abb98..b5b143cd1b0 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2364,10 +2364,8 @@ int bdrv_flush_all(void)
  * Drivers not implementing the functionality are assumed to not support
  * backing files, hence all their sectors are reported as allocated.
  *
- * If 'want_zero' is true, the caller is querying for mapping
- * purposes, with a focus on valid BDRV_BLOCK_OFFSET_VALID, _DATA, and
- * _ZERO where possible; otherwise, the result favors larger 'pnum',
- * with a focus on accurate BDRV_BLOCK_ALLOCATED.
+ * 'mode' serves as a hint as to which results are favored; see the
+ * BDRV_WANT_* macros for details.
  *
  * If 'offset' is beyond the end of the disk image the return value is
  * BDRV_BLOCK_EOF and 'pnum' is set to 0.
@@ -2387,7 +2385,7 @@ int bdrv_flush_all(void)
  * set to the host mapping and BDS corresponding to the guest offset.
  */
 static int coroutine_fn GRAPH_RDLOCK
-bdrv_co_do_block_status(BlockDriverState *bs, bool want_zero,
+bdrv_co_do_block_status(BlockDriverState *bs, unsigned int mode,
                         int64_t offset, int64_t bytes,
                         int64_t *pnum, int64_t *map, BlockDriverState **file)
 {
@@ -2476,7 +2474,7 @@ bdrv_co_do_block_status(BlockDriverState *bs, bool want_zero,
             local_file = bs;
             local_map = aligned_offset;
         } else {
-            ret = bs->drv->bdrv_co_block_status(bs, want_zero, aligned_offset,
+            ret = bs->drv->bdrv_co_block_status(bs, mode, aligned_offset,
                                                 aligned_bytes, pnum, &local_map,
                                                 &local_file);

@@ -2488,10 +2486,10 @@ bdrv_co_do_block_status(BlockDriverState *bs, bool want_zero,
              * the cache requires an RCU update, so double check here to avoid
              * such an update if possible.
              *
-             * Check want_zero, because we only want to update the cache when we
+             * Check mode, because we only want to update the cache when we
              * have accurate information about what is zero and what is data.
              */
-            if (want_zero &&
+            if (mode == BDRV_WANT_PRECISE &&
                 ret == (BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID) &&
                 QLIST_EMPTY(&bs->children))
             {
@@ -2548,7 +2546,7 @@ bdrv_co_do_block_status(BlockDriverState *bs, bool want_zero,

     if (ret & BDRV_BLOCK_RAW) {
         assert(ret & BDRV_BLOCK_OFFSET_VALID && local_file);
-        ret = bdrv_co_do_block_status(local_file, want_zero, local_map,
+        ret = bdrv_co_do_block_status(local_file, mode, local_map,
                                       *pnum, pnum, &local_map, &local_file);
         goto out;
     }
@@ -2560,7 +2558,7 @@ bdrv_co_do_block_status(BlockDriverState *bs, bool want_zero,

         if (!cow_bs) {
             ret |= BDRV_BLOCK_ZERO;
-        } else if (want_zero) {
+        } else if (mode == BDRV_WANT_PRECISE) {
             int64_t size2 = bdrv_co_getlength(cow_bs);

             if (size2 >= 0 && offset >= size2) {
@@ -2569,14 +2567,14 @@ bdrv_co_do_block_status(BlockDriverState *bs, bool want_zero,
         }
     }

-    if (want_zero && ret & BDRV_BLOCK_RECURSE &&
+    if (mode == BDRV_WANT_PRECISE && ret & BDRV_BLOCK_RECURSE &&
         local_file && local_file != bs &&
         (ret & BDRV_BLOCK_DATA) && !(ret & BDRV_BLOCK_ZERO) &&
         (ret & BDRV_BLOCK_OFFSET_VALID)) {
         int64_t file_pnum;
         int ret2;

-        ret2 = bdrv_co_do_block_status(local_file, want_zero, local_map,
+        ret2 = bdrv_co_do_block_status(local_file, mode, local_map,
                                        *pnum, &file_pnum, NULL, NULL);
         if (ret2 >= 0) {
             /* Ignore errors.  This is just providing extra information, it
@@ -2627,7 +2625,7 @@ int coroutine_fn
 bdrv_co_common_block_status_above(BlockDriverState *bs,
                                   BlockDriverState *base,
                                   bool include_base,
-                                  bool want_zero,
+                                  unsigned int mode,
                                   int64_t offset,
                                   int64_t bytes,
                                   int64_t *pnum,
@@ -2654,7 +2652,7 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
         return 0;
     }

-    ret = bdrv_co_do_block_status(bs, want_zero, offset, bytes, pnum,
+    ret = bdrv_co_do_block_status(bs, mode, offset, bytes, pnum,
                                   map, file);
     ++*depth;
     if (ret < 0 || *pnum == 0 || ret & BDRV_BLOCK_ALLOCATED || bs == base) {
@@ -2671,7 +2669,7 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
     for (p = bdrv_filter_or_cow_bs(bs); include_base || p != base;
          p = bdrv_filter_or_cow_bs(p))
     {
-        ret = bdrv_co_do_block_status(p, want_zero, offset, bytes, pnum,
+        ret = bdrv_co_do_block_status(p, mode, offset, bytes, pnum,
                                       map, file);
         ++*depth;
         if (ret < 0) {
@@ -2734,7 +2732,8 @@ int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
                                             BlockDriverState **file)
 {
     IO_CODE();
-    return bdrv_co_common_block_status_above(bs, base, false, true, offset,
+    return bdrv_co_common_block_status_above(bs, base, false,
+                                             BDRV_WANT_PRECISE, offset,
                                              bytes, pnum, map, file, NULL);
 }

@@ -2765,8 +2764,9 @@ int coroutine_fn bdrv_co_is_zero_fast(BlockDriverState *bs, int64_t offset,
         return 1;
     }

-    ret = bdrv_co_common_block_status_above(bs, NULL, false, false, offset,
-                                            bytes, &pnum, NULL, NULL, NULL);
+    ret = bdrv_co_common_block_status_above(bs, NULL, false, BDRV_WANT_ZERO,
+                                            offset, bytes, &pnum, NULL, NULL,
+                                            NULL);

     if (ret < 0) {
         return ret;
@@ -2782,9 +2782,9 @@ int coroutine_fn bdrv_co_is_allocated(BlockDriverState *bs, int64_t offset,
     int64_t dummy;
     IO_CODE();

-    ret = bdrv_co_common_block_status_above(bs, bs, true, false, offset,
-                                            bytes, pnum ? pnum : &dummy, NULL,
-                                            NULL, NULL);
+    ret = bdrv_co_common_block_status_above(bs, bs, true, BDRV_WANT_ALLOCATED,
+                                            offset, bytes, pnum ? pnum : &dummy,
+                                            NULL, NULL, NULL);
     if (ret < 0) {
         return ret;
     }
@@ -2817,7 +2817,8 @@ int coroutine_fn bdrv_co_is_allocated_above(BlockDriverState *bs,
     int ret;
     IO_CODE();

-    ret = bdrv_co_common_block_status_above(bs, base, include_base, false,
+    ret = bdrv_co_common_block_status_above(bs, base, include_base,
+                                            BDRV_WANT_ALLOCATED,
                                             offset, bytes, pnum, NULL, NULL,
                                             &depth);
     if (ret < 0) {
@@ -3698,8 +3699,8 @@ bdrv_co_preadv_snapshot(BdrvChild *child, int64_t offset, int64_t bytes,
 }

 int coroutine_fn
-bdrv_co_snapshot_block_status(BlockDriverState *bs,
-                              bool want_zero, int64_t offset, int64_t bytes,
+bdrv_co_snapshot_block_status(BlockDriverState *bs, unsigned int mode,
+                              int64_t offset, int64_t bytes,
                               int64_t *pnum, int64_t *map,
                               BlockDriverState **file)
 {
@@ -3717,7 +3718,7 @@ bdrv_co_snapshot_block_status(BlockDriverState *bs,
     }

     bdrv_inc_in_flight(bs);
-    ret = drv->bdrv_co_snapshot_block_status(bs, want_zero, offset, bytes,
+    ret = drv->bdrv_co_snapshot_block_status(bs, mode, offset, bytes,
                                              pnum, map, file);
     bdrv_dec_in_flight(bs);

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 1c1967f8e0a..c54aee0c84b 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -751,9 +751,9 @@ blkdebug_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
 }

 static int coroutine_fn GRAPH_RDLOCK
-blkdebug_co_block_status(BlockDriverState *bs, bool want_zero, int64_t offset,
-                         int64_t bytes, int64_t *pnum, int64_t *map,
-                         BlockDriverState **file)
+blkdebug_co_block_status(BlockDriverState *bs, unsigned int mode,
+                         int64_t offset, int64_t bytes, int64_t *pnum,
+                         int64_t *map, BlockDriverState **file)
 {
     int err;

diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index 00af0b18ac4..36d5d3ed9b0 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -291,8 +291,8 @@ cbw_co_preadv_snapshot(BlockDriverState *bs, int64_t offset, int64_t bytes,
 }

 static int coroutine_fn GRAPH_RDLOCK
-cbw_co_snapshot_block_status(BlockDriverState *bs,
-                             bool want_zero, int64_t offset, int64_t bytes,
+cbw_co_snapshot_block_status(BlockDriverState *bs, unsigned int mode,
+                             int64_t offset, int64_t bytes,
                              int64_t *pnum, int64_t *map,
                              BlockDriverState **file)
 {
diff --git a/block/file-posix.c b/block/file-posix.c
index ef52ed9169e..805a1a2949b 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3273,7 +3273,7 @@ static int find_allocation(BlockDriverState *bs, off_t start,
  * well exceed it.
  */
 static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
-                                            bool want_zero,
+                                            unsigned int mode,
                                             int64_t offset,
                                             int64_t bytes, int64_t *pnum,
                                             int64_t *map,
@@ -3289,7 +3289,7 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
         return ret;
     }

-    if (!want_zero) {
+    if (mode != BDRV_WANT_PRECISE) {
         *pnum = bytes;
         *map = offset;
         *file = bs;
diff --git a/block/gluster.c b/block/gluster.c
index 8712aa606a4..1a2ef53e9b0 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1461,7 +1461,7 @@ exit:
  * (Based on raw_co_block_status() from file-posix.c.)
  */
 static int coroutine_fn qemu_gluster_co_block_status(BlockDriverState *bs,
-                                                     bool want_zero,
+                                                     unsigned int mode,
                                                      int64_t offset,
                                                      int64_t bytes,
                                                      int64_t *pnum,
@@ -1478,7 +1478,7 @@ static int coroutine_fn qemu_gluster_co_block_status(BlockDriverState *bs,
         return ret;
     }

-    if (!want_zero) {
+    if (mode != BDRV_WANT_PRECISE) {
         *pnum = bytes;
         *map = offset;
         *file = bs;
diff --git a/block/iscsi.c b/block/iscsi.c
index 2f0f4dac097..15b96ee8800 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -694,9 +694,9 @@ out_unlock:


 static int coroutine_fn iscsi_co_block_status(BlockDriverState *bs,
-                                              bool want_zero, int64_t offset,
-                                              int64_t bytes, int64_t *pnum,
-                                              int64_t *map,
+                                              unsigned int mode,
+                                              int64_t offset, int64_t bytes,
+                                              int64_t *pnum, int64_t *map,
                                               BlockDriverState **file)
 {
     IscsiLun *iscsilun = bs->opaque;
diff --git a/block/nbd.c b/block/nbd.c
index 887841bc813..d5a2b21c6d1 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1397,8 +1397,8 @@ nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
 }

 static int coroutine_fn GRAPH_RDLOCK nbd_client_co_block_status(
-        BlockDriverState *bs, bool want_zero, int64_t offset, int64_t bytes,
-        int64_t *pnum, int64_t *map, BlockDriverState **file)
+        BlockDriverState *bs, unsigned int mode, int64_t offset,
+        int64_t bytes, int64_t *pnum, int64_t *map, BlockDriverState **file)
 {
     int ret, request_ret;
     NBDExtent64 extent = { 0 };
diff --git a/block/null.c b/block/null.c
index dc0b1fdbd9b..4e448d593d7 100644
--- a/block/null.c
+++ b/block/null.c
@@ -227,9 +227,9 @@ static int null_reopen_prepare(BDRVReopenState *reopen_state,
 }

 static int coroutine_fn null_co_block_status(BlockDriverState *bs,
-                                             bool want_zero, int64_t offset,
-                                             int64_t bytes, int64_t *pnum,
-                                             int64_t *map,
+                                             unsigned int mode,
+                                             int64_t offset, int64_t bytes,
+                                             int64_t *pnum, int64_t *map,
                                              BlockDriverState **file)
 {
     BDRVNullState *s = bs->opaque;
diff --git a/block/parallels.c b/block/parallels.c
index 347ca127f34..3a375e2a8ab 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -416,9 +416,9 @@ parallels_co_flush_to_os(BlockDriverState *bs)
 }

 static int coroutine_fn GRAPH_RDLOCK
-parallels_co_block_status(BlockDriverState *bs, bool want_zero, int64_t offset,
-                          int64_t bytes, int64_t *pnum, int64_t *map,
-                          BlockDriverState **file)
+parallels_co_block_status(BlockDriverState *bs, unsigned int mode,
+                          int64_t offset, int64_t bytes, int64_t *pnum,
+                          int64_t *map, BlockDriverState **file)
 {
     BDRVParallelsState *s = bs->opaque;
     int count;
diff --git a/block/qcow.c b/block/qcow.c
index da8ad4d2430..8a3e7591a92 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -530,7 +530,7 @@ get_cluster_offset(BlockDriverState *bs, uint64_t offset, int allocate,
 }

 static int coroutine_fn GRAPH_RDLOCK
-qcow_co_block_status(BlockDriverState *bs, bool want_zero,
+qcow_co_block_status(BlockDriverState *bs, unsigned int mode,
                      int64_t offset, int64_t bytes, int64_t *pnum,
                      int64_t *map, BlockDriverState **file)
 {
diff --git a/block/qcow2.c b/block/qcow2.c
index 7774e7f0909..66fba89b414 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2141,9 +2141,9 @@ static void qcow2_join_options(QDict *options, QDict *old_options)
 }

 static int coroutine_fn GRAPH_RDLOCK
-qcow2_co_block_status(BlockDriverState *bs, bool want_zero, int64_t offset,
-                      int64_t count, int64_t *pnum, int64_t *map,
-                      BlockDriverState **file)
+qcow2_co_block_status(BlockDriverState *bs, unsigned int mode,
+                      int64_t offset, int64_t count, int64_t *pnum,
+                      int64_t *map, BlockDriverState **file)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t host_offset;
diff --git a/block/qed.c b/block/qed.c
index ac24449ffb3..4a36fb39294 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -833,9 +833,9 @@ fail:
 }

 static int coroutine_fn GRAPH_RDLOCK
-bdrv_qed_co_block_status(BlockDriverState *bs, bool want_zero, int64_t pos,
-                         int64_t bytes, int64_t *pnum, int64_t *map,
-                         BlockDriverState **file)
+bdrv_qed_co_block_status(BlockDriverState *bs, unsigned int mode,
+                         int64_t pos, int64_t bytes, int64_t *pnum,
+                         int64_t *map, BlockDriverState **file)
 {
     BDRVQEDState *s = bs->opaque;
     size_t len = MIN(bytes, SIZE_MAX);
diff --git a/block/quorum.c b/block/quorum.c
index 30747a6df93..ed8ce801ee3 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1226,7 +1226,7 @@ static void quorum_child_perm(BlockDriverState *bs, BdrvChild *c,
  * region contains zeroes, and BDRV_BLOCK_DATA otherwise.
  */
 static int coroutine_fn GRAPH_RDLOCK
-quorum_co_block_status(BlockDriverState *bs, bool want_zero,
+quorum_co_block_status(BlockDriverState *bs, unsigned int mode,
                        int64_t offset, int64_t count,
                        int64_t *pnum, int64_t *map, BlockDriverState **file)
 {
@@ -1238,7 +1238,7 @@ quorum_co_block_status(BlockDriverState *bs, bool want_zero,
     for (i = 0; i < s->num_children; i++) {
         int64_t bytes;
         ret = bdrv_co_common_block_status_above(s->children[i]->bs, NULL, false,
-                                                want_zero, offset, count,
+                                                mode, offset, count,
                                                 &bytes, NULL, NULL, NULL);
         if (ret < 0) {
             quorum_report_bad(QUORUM_OP_TYPE_READ, offset, count,
diff --git a/block/raw-format.c b/block/raw-format.c
index e08526e2eca..df16ac1ea25 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -283,8 +283,8 @@ fail:
 }

 static int coroutine_fn GRAPH_RDLOCK
-raw_co_block_status(BlockDriverState *bs, bool want_zero, int64_t offset,
-                    int64_t bytes, int64_t *pnum, int64_t *map,
+raw_co_block_status(BlockDriverState *bs, unsigned int mode,
+                    int64_t offset, int64_t bytes, int64_t *pnum, int64_t *map,
                     BlockDriverState **file)
 {
     BDRVRawState *s = bs->opaque;
diff --git a/block/rbd.c b/block/rbd.c
index 7446e66659e..951cd63f9ae 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1503,9 +1503,9 @@ static int qemu_rbd_diff_iterate_cb(uint64_t offs, size_t len,
 }

 static int coroutine_fn qemu_rbd_co_block_status(BlockDriverState *bs,
-                                                 bool want_zero, int64_t offset,
-                                                 int64_t bytes, int64_t *pnum,
-                                                 int64_t *map,
+                                                 unsigned int mode,
+                                                 int64_t offset, int64_t bytes,
+                                                 int64_t *pnum, int64_t *map,
                                                  BlockDriverState **file)
 {
     BDRVRBDState *s = bs->opaque;
diff --git a/block/snapshot-access.c b/block/snapshot-access.c
index 71ac83c01f0..17ed2402db8 100644
--- a/block/snapshot-access.c
+++ b/block/snapshot-access.c
@@ -41,11 +41,11 @@ snapshot_access_co_preadv_part(BlockDriverState *bs,

 static int coroutine_fn GRAPH_RDLOCK
 snapshot_access_co_block_status(BlockDriverState *bs,
-                                bool want_zero, int64_t offset,
+                                unsigned int mode, int64_t offset,
                                 int64_t bytes, int64_t *pnum,
                                 int64_t *map, BlockDriverState **file)
 {
-    return bdrv_co_snapshot_block_status(bs->file->bs, want_zero, offset,
+    return bdrv_co_snapshot_block_status(bs->file->bs, mode, offset,
                                          bytes, pnum, map, file);
 }

diff --git a/block/vdi.c b/block/vdi.c
index a2da6ecab01..3ddc62a5690 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -523,8 +523,8 @@ static int vdi_reopen_prepare(BDRVReopenState *state,
 }

 static int coroutine_fn GRAPH_RDLOCK
-vdi_co_block_status(BlockDriverState *bs, bool want_zero, int64_t offset,
-                    int64_t bytes, int64_t *pnum, int64_t *map,
+vdi_co_block_status(BlockDriverState *bs, unsigned int mode,
+                    int64_t offset, int64_t bytes, int64_t *pnum, int64_t *map,
                     BlockDriverState **file)
 {
     BDRVVdiState *s = (BDRVVdiState *)bs->opaque;
diff --git a/block/vmdk.c b/block/vmdk.c
index 2adec499122..9c7ab037e14 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1777,7 +1777,7 @@ static inline uint64_t vmdk_find_offset_in_cluster(VmdkExtent *extent,
 }

 static int coroutine_fn GRAPH_RDLOCK
-vmdk_co_block_status(BlockDriverState *bs, bool want_zero,
+vmdk_co_block_status(BlockDriverState *bs, unsigned int mode,
                      int64_t offset, int64_t bytes, int64_t *pnum,
                      int64_t *map, BlockDriverState **file)
 {
diff --git a/block/vpc.c b/block/vpc.c
index 0309e319f60..801ff5793f8 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -726,7 +726,7 @@ fail:
 }

 static int coroutine_fn GRAPH_RDLOCK
-vpc_co_block_status(BlockDriverState *bs, bool want_zero,
+vpc_co_block_status(BlockDriverState *bs, unsigned int mode,
                     int64_t offset, int64_t bytes,
                     int64_t *pnum, int64_t *map,
                     BlockDriverState **file)
diff --git a/block/vvfat.c b/block/vvfat.c
index 91d69b3cc83..814796d9185 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3134,9 +3134,9 @@ vvfat_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
 }

 static int coroutine_fn vvfat_co_block_status(BlockDriverState *bs,
-                                              bool want_zero, int64_t offset,
-                                              int64_t bytes, int64_t *n,
-                                              int64_t *map,
+                                              unsigned int mode,
+                                              int64_t offset, int64_t bytes,
+                                              int64_t *n, int64_t *map,
                                               BlockDriverState **file)
 {
     *n = bytes;
diff --git a/tests/unit/test-block-iothread.c b/tests/unit/test-block-iothread.c
index 2b358eaaa82..e26b3be5939 100644
--- a/tests/unit/test-block-iothread.c
+++ b/tests/unit/test-block-iothread.c
@@ -63,7 +63,7 @@ bdrv_test_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
 }

 static int coroutine_fn bdrv_test_co_block_status(BlockDriverState *bs,
-                                                  bool want_zero,
+                                                  unsigned int mode,
                                                   int64_t offset, int64_t count,
                                                   int64_t *pnum, int64_t *map,
                                                   BlockDriverState **file)
-- 
2.49.0


