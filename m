Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B6D74139B
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 16:18:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEVyi-0001fT-AU; Wed, 28 Jun 2023 10:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEVyg-0001Y3-5v
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:17:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEVye-0005Wz-Ak
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687961819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oo+cUqmb0AL9IoU32J7leeMXK4Px5r2O7Pk3x1KmaIk=;
 b=giTKjv/gCgqoZ6V91sEAGhmF15Hm+idLz0xBzG0kvMhA593bOJBO+Sopvw+UG+L4krXyzS
 Vx2RMDYJMwHLryZiGZs8+P6gUfRmwuP3iUJJbkvgOn7UOGK818i/2uDCtGztUMjUbl9qzo
 ezAg6O3V6LwJ/1PJS/beDQ1HJa5gGG0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-7AYjH2QKMuCX_2WlvPj9WQ-1; Wed, 28 Jun 2023 10:16:51 -0400
X-MC-Unique: 7AYjH2QKMuCX_2WlvPj9WQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CC6D1C04B79;
 Wed, 28 Jun 2023 14:16:02 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.195.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA2CD40C2063;
 Wed, 28 Jun 2023 14:16:01 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 22/23] block: use bdrv_co_getlength in coroutine context
Date: Wed, 28 Jun 2023 16:15:25 +0200
Message-ID: <20230628141526.293104-23-kwolf@redhat.com>
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

From: Paolo Bonzini <pbonzini@redhat.com>

bdrv_co_getlength was recently introduced, with bdrv_getlength becoming
a wrapper for use in unknown context.  Switch to bdrv_co_getlength when
possible.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20230601115145.196465-12-pbonzini@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c        | 10 +++++-----
 block/parallels.c |  4 ++--
 block/qcow.c      |  6 +++---
 block/vmdk.c      |  4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/io.c b/block/io.c
index 30748f0b59..b53253c7a7 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1379,7 +1379,7 @@ bdrv_aligned_preadv(BdrvChild *child, BdrvTrackedRequest *req,
     }
 
     /* Forward the request to the BlockDriver, possibly fragmenting it */
-    total_bytes = bdrv_getlength(bs);
+    total_bytes = bdrv_co_getlength(bs);
     if (total_bytes < 0) {
         ret = total_bytes;
         goto out;
@@ -2388,7 +2388,7 @@ bdrv_co_block_status(BlockDriverState *bs, bool want_zero,
     assert(pnum);
     assert_bdrv_graph_readable();
     *pnum = 0;
-    total_size = bdrv_getlength(bs);
+    total_size = bdrv_co_getlength(bs);
     if (total_size < 0) {
         ret = total_size;
         goto early_out;
@@ -2408,7 +2408,7 @@ bdrv_co_block_status(BlockDriverState *bs, bool want_zero,
         bytes = n;
     }
 
-    /* Must be non-NULL or bdrv_getlength() would have failed */
+    /* Must be non-NULL or bdrv_co_getlength() would have failed */
     assert(bs->drv);
     has_filtered_child = bdrv_filter_child(bs);
     if (!bs->drv->bdrv_co_block_status && !has_filtered_child) {
@@ -2546,7 +2546,7 @@ bdrv_co_block_status(BlockDriverState *bs, bool want_zero,
         if (!cow_bs) {
             ret |= BDRV_BLOCK_ZERO;
         } else if (want_zero) {
-            int64_t size2 = bdrv_getlength(cow_bs);
+            int64_t size2 = bdrv_co_getlength(cow_bs);
 
             if (size2 >= 0 && offset >= size2) {
                 ret |= BDRV_BLOCK_ZERO;
@@ -3592,7 +3592,7 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
         return ret;
     }
 
-    old_size = bdrv_getlength(bs);
+    old_size = bdrv_co_getlength(bs);
     if (old_size < 0) {
         error_setg_errno(errp, -old_size, "Failed to get old image size");
         return old_size;
diff --git a/block/parallels.c b/block/parallels.c
index 7c263d5085..18e34aef28 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -200,7 +200,7 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
     assert(idx < s->bat_size && idx + to_allocate <= s->bat_size);
 
     space = to_allocate * s->tracks;
-    len = bdrv_getlength(bs->file->bs);
+    len = bdrv_co_getlength(bs->file->bs);
     if (len < 0) {
         return len;
     }
@@ -448,7 +448,7 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
     uint32_t i;
     int64_t off, high_off, size;
 
-    size = bdrv_getlength(bs->file->bs);
+    size = bdrv_co_getlength(bs->file->bs);
     if (size < 0) {
         res->check_errors++;
         return size;
diff --git a/block/qcow.c b/block/qcow.c
index 3644bbf5cb..cb240a5369 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -370,7 +370,7 @@ get_cluster_offset(BlockDriverState *bs, uint64_t offset, int allocate,
         if (!allocate)
             return 0;
         /* allocate a new l2 entry */
-        l2_offset = bdrv_getlength(bs->file->bs);
+        l2_offset = bdrv_co_getlength(bs->file->bs);
         if (l2_offset < 0) {
             return l2_offset;
         }
@@ -445,7 +445,7 @@ get_cluster_offset(BlockDriverState *bs, uint64_t offset, int allocate,
             if (decompress_cluster(bs, cluster_offset) < 0) {
                 return -EIO;
             }
-            cluster_offset = bdrv_getlength(bs->file->bs);
+            cluster_offset = bdrv_co_getlength(bs->file->bs);
             if ((int64_t) cluster_offset < 0) {
                 return cluster_offset;
             }
@@ -458,7 +458,7 @@ get_cluster_offset(BlockDriverState *bs, uint64_t offset, int allocate,
                 return ret;
             }
         } else {
-            cluster_offset = bdrv_getlength(bs->file->bs);
+            cluster_offset = bdrv_co_getlength(bs->file->bs);
             if ((int64_t) cluster_offset < 0) {
                 return cluster_offset;
             }
diff --git a/block/vmdk.c b/block/vmdk.c
index 0410b895dc..234e671786 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2132,7 +2132,7 @@ vmdk_co_pwritev_compressed(BlockDriverState *bs, int64_t offset, int64_t bytes,
         int64_t length;
 
         for (i = 0; i < s->num_extents; i++) {
-            length = bdrv_getlength(s->extents[i].file->bs);
+            length = bdrv_co_getlength(s->extents[i].file->bs);
             if (length < 0) {
                 return length;
             }
@@ -2939,7 +2939,7 @@ vmdk_co_check(BlockDriverState *bs, BdrvCheckResult *result, BdrvCheckMode fix)
             break;
         }
         if (ret == VMDK_OK) {
-            int64_t extent_len = bdrv_getlength(extent->file->bs);
+            int64_t extent_len = bdrv_co_getlength(extent->file->bs);
             if (extent_len < 0) {
                 fprintf(stderr,
                         "ERROR: could not get extent file length for sector %"
-- 
2.41.0


