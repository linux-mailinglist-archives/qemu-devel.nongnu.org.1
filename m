Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8551E74139A
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 16:18:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEVy7-00007S-Jd; Wed, 28 Jun 2023 10:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEVxs-0008J7-Kg
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEVxk-0005GZ-6D
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687961759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FWCFMBkRtd5ptxeRyAFmwpVYLusK7s5Y4fIKICblOqs=;
 b=XBNHgU46gqS9JabS5h/VOmtOW87puZ/HLZpAjlnaiKKoDZScp24nDDk3DBRPjpzWYxZQ7p
 aG9Uua+8gUMKXz7f9Dch7Vo9yJoM226DVIcZ83+9OwFxUYLIbPkFSYcSdpGeqAHqfTh8pN
 Nh7K0V0yrI3NEO4uqu+Ac0c5yZzDv4Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-138-YG_4EicKNJe1uyj2XoEgjg-1; Wed, 28 Jun 2023 10:15:56 -0400
X-MC-Unique: YG_4EicKNJe1uyj2XoEgjg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C82828237F4;
 Wed, 28 Jun 2023 14:15:54 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.195.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79BF640C206F;
 Wed, 28 Jun 2023 14:15:53 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 14/23] vpc: mark more functions as coroutine_fns and
 GRAPH_RDLOCK
Date: Wed, 28 Jun 2023 16:15:17 +0200
Message-ID: <20230628141526.293104-15-kwolf@redhat.com>
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

Mark functions as coroutine_fn when they are only called by other coroutine_fns
and they can suspend.  Change calls to co_wrappers to use the non-wrapped
functions, which in turn requires adding GRAPH_RDLOCK annotations.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20230601115145.196465-4-pbonzini@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vpc.c | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/block/vpc.c b/block/vpc.c
index 7ee7c7b4e0..3810a601a3 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -486,8 +486,8 @@ static int vpc_reopen_prepare(BDRVReopenState *state,
  * operation (the block bitmaps is updated then), 0 otherwise.
  * If write is true then err must not be NULL.
  */
-static inline int64_t get_image_offset(BlockDriverState *bs, uint64_t offset,
-                                       bool write, int *err)
+static int64_t coroutine_fn GRAPH_RDLOCK
+get_image_offset(BlockDriverState *bs, uint64_t offset, bool write, int *err)
 {
     BDRVVPCState *s = bs->opaque;
     uint64_t bitmap_offset, block_offset;
@@ -515,8 +515,7 @@ static inline int64_t get_image_offset(BlockDriverState *bs, uint64_t offset,
 
         s->last_bitmap_offset = bitmap_offset;
         memset(bitmap, 0xff, s->bitmap_size);
-        r = bdrv_pwrite_sync(bs->file, bitmap_offset, s->bitmap_size, bitmap,
-                             0);
+        r = bdrv_co_pwrite_sync(bs->file, bitmap_offset, s->bitmap_size, bitmap, 0);
         if (r < 0) {
             *err = r;
             return -2;
@@ -532,13 +531,13 @@ static inline int64_t get_image_offset(BlockDriverState *bs, uint64_t offset,
  *
  * Returns 0 on success and < 0 on error
  */
-static int rewrite_footer(BlockDriverState *bs)
+static int coroutine_fn GRAPH_RDLOCK rewrite_footer(BlockDriverState *bs)
 {
     int ret;
     BDRVVPCState *s = bs->opaque;
     int64_t offset = s->free_data_block_offset;
 
-    ret = bdrv_pwrite_sync(bs->file, offset, sizeof(s->footer), &s->footer, 0);
+    ret = bdrv_co_pwrite_sync(bs->file, offset, sizeof(s->footer), &s->footer, 0);
     if (ret < 0)
         return ret;
 
@@ -552,7 +551,8 @@ static int rewrite_footer(BlockDriverState *bs)
  *
  * Returns the sectors' offset in the image file on success and < 0 on error
  */
-static int64_t alloc_block(BlockDriverState *bs, int64_t offset)
+static int64_t coroutine_fn GRAPH_RDLOCK
+alloc_block(BlockDriverState *bs, int64_t offset)
 {
     BDRVVPCState *s = bs->opaque;
     int64_t bat_offset;
@@ -572,8 +572,8 @@ static int64_t alloc_block(BlockDriverState *bs, int64_t offset)
 
     /* Initialize the block's bitmap */
     memset(bitmap, 0xff, s->bitmap_size);
-    ret = bdrv_pwrite_sync(bs->file, s->free_data_block_offset,
-                           s->bitmap_size, bitmap, 0);
+    ret = bdrv_co_pwrite_sync(bs->file, s->free_data_block_offset,
+                              s->bitmap_size, bitmap, 0);
     if (ret < 0) {
         return ret;
     }
@@ -587,7 +587,7 @@ static int64_t alloc_block(BlockDriverState *bs, int64_t offset)
     /* Write BAT entry to disk */
     bat_offset = s->bat_offset + (4 * index);
     bat_value = cpu_to_be32(s->pagetable[index]);
-    ret = bdrv_pwrite_sync(bs->file, bat_offset, 4, &bat_value, 0);
+    ret = bdrv_co_pwrite_sync(bs->file, bat_offset, 4, &bat_value, 0);
     if (ret < 0)
         goto fail;
 
@@ -718,11 +718,11 @@ fail:
     return ret;
 }
 
-static int coroutine_fn vpc_co_block_status(BlockDriverState *bs,
-                                            bool want_zero,
-                                            int64_t offset, int64_t bytes,
-                                            int64_t *pnum, int64_t *map,
-                                            BlockDriverState **file)
+static int coroutine_fn GRAPH_RDLOCK
+vpc_co_block_status(BlockDriverState *bs, bool want_zero,
+                    int64_t offset, int64_t bytes,
+                    int64_t *pnum, int64_t *map,
+                    BlockDriverState **file)
 {
     BDRVVPCState *s = bs->opaque;
     int64_t image_offset;
@@ -820,8 +820,8 @@ static int calculate_geometry(int64_t total_sectors, uint16_t *cyls,
     return 0;
 }
 
-static int create_dynamic_disk(BlockBackend *blk, VHDFooter *footer,
-                               int64_t total_sectors)
+static int coroutine_fn create_dynamic_disk(BlockBackend *blk, VHDFooter *footer,
+                                            int64_t total_sectors)
 {
     VHDDynDiskHeader dyndisk_header;
     uint8_t bat_sector[512];
@@ -834,13 +834,13 @@ static int create_dynamic_disk(BlockBackend *blk, VHDFooter *footer,
     block_size = 0x200000;
     num_bat_entries = DIV_ROUND_UP(total_sectors, block_size / 512);
 
-    ret = blk_pwrite(blk, offset, sizeof(*footer), footer, 0);
+    ret = blk_co_pwrite(blk, offset, sizeof(*footer), footer, 0);
     if (ret < 0) {
         goto fail;
     }
 
     offset = 1536 + ((num_bat_entries * 4 + 511) & ~511);
-    ret = blk_pwrite(blk, offset, sizeof(*footer), footer, 0);
+    ret = blk_co_pwrite(blk, offset, sizeof(*footer), footer, 0);
     if (ret < 0) {
         goto fail;
     }
@@ -850,7 +850,7 @@ static int create_dynamic_disk(BlockBackend *blk, VHDFooter *footer,
 
     memset(bat_sector, 0xFF, 512);
     for (i = 0; i < DIV_ROUND_UP(num_bat_entries * 4, 512); i++) {
-        ret = blk_pwrite(blk, offset, 512, bat_sector, 0);
+        ret = blk_co_pwrite(blk, offset, 512, bat_sector, 0);
         if (ret < 0) {
             goto fail;
         }
@@ -878,7 +878,7 @@ static int create_dynamic_disk(BlockBackend *blk, VHDFooter *footer,
     /* Write the header */
     offset = 512;
 
-    ret = blk_pwrite(blk, offset, sizeof(dyndisk_header), &dyndisk_header, 0);
+    ret = blk_co_pwrite(blk, offset, sizeof(dyndisk_header), &dyndisk_header, 0);
     if (ret < 0) {
         goto fail;
     }
@@ -888,21 +888,21 @@ static int create_dynamic_disk(BlockBackend *blk, VHDFooter *footer,
     return ret;
 }
 
-static int create_fixed_disk(BlockBackend *blk, VHDFooter *footer,
-                             int64_t total_size, Error **errp)
+static int coroutine_fn create_fixed_disk(BlockBackend *blk, VHDFooter *footer,
+                                          int64_t total_size, Error **errp)
 {
     int ret;
 
     /* Add footer to total size */
     total_size += sizeof(*footer);
 
-    ret = blk_truncate(blk, total_size, false, PREALLOC_MODE_OFF, 0, errp);
+    ret = blk_co_truncate(blk, total_size, false, PREALLOC_MODE_OFF, 0, errp);
     if (ret < 0) {
         return ret;
     }
 
-    ret = blk_pwrite(blk, total_size - sizeof(*footer), sizeof(*footer),
-                     footer, 0);
+    ret = blk_co_pwrite(blk, total_size - sizeof(*footer), sizeof(*footer),
+                        footer, 0);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Unable to write VHD header");
         return ret;
-- 
2.41.0


