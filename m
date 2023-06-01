Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA34719B31
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:53:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4gqc-0001Ag-Gd; Thu, 01 Jun 2023 07:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqV-0000mS-Gq
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:51:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqT-0000Kg-0I
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685620314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1+15Ues+9N1LiEnG5bYhMWTuA1nqCGUfqQ757hiAsyk=;
 b=ORRImjy5hKGPE7OmPZGOLuXEKvGFqtxI7qcouX+nscu5ADhEmanLu27+DkRYJjOZRiv78p
 fEcGOr0Fjhspbk0JtoSmB3GFpb56XX+LRRFQY+dstMgqXY2Ud+umq4+eds3RtIxnN7ICuS
 1z2xUBrUIayKmi9mRSfKxSK1WpwgDZk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-G3eVb2g_Pdms89E9akWYcA-1; Thu, 01 Jun 2023 07:51:53 -0400
X-MC-Unique: G3eVb2g_Pdms89E9akWYcA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-96fd3757c1dso47784466b.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685620312; x=1688212312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1+15Ues+9N1LiEnG5bYhMWTuA1nqCGUfqQ757hiAsyk=;
 b=KldHUl2Rxrl1zQqTN6jMDotSYYUxmVqOGYtDIqFpvZE38exhzckO0q66KrdTB9nPgi
 VMbubYeXr37/YzgZNi/7WJdYk0dEZknujQEGmBjMpdkwRgAA4wG6Rs2VsnTvFNbleWKH
 U6LEvf9N1f2hO03M+1cbW5Nek0zfeLjC7oKIeb3GarcnwSv0dkBvcPnsedTPK6BjRaIN
 wYCa8NUtx9TComv6kDTmCIGmur5l8YoM0Pct2Af7B/Ccf4kBQAdv52lUAdjgycUtn8UN
 8riG4GyO/x9qlmTYY9kZskZ9HlO5mngu3zwW/FLLqrDPcyV0/xuI1ANrjCcuc1ZDly+c
 qTTQ==
X-Gm-Message-State: AC+VfDzow5sWB5xR96cXvHwViKHb+rH3nODinfPFvEdviUcxYo6sgrkW
 N60zYY6TbrjmQQejQvg2uR+PY0dBPh+6J+engasPsbj1/FQ4fot7Yv+WpL2DJDw9CsHrPs8i3OK
 2Jx2tT/cfUqm8JN9xvSN5/Bc8P+6423DUgRC75tpdwAwiSjQVoPQB8fcCaBMhj1X59NQl3VSgBS
 o=
X-Received: by 2002:a17:907:6da4:b0:96f:1f79:c0a6 with SMTP id
 sb36-20020a1709076da400b0096f1f79c0a6mr6940155ejc.70.1685620311826; 
 Thu, 01 Jun 2023 04:51:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5zAeb97uIiH4KXthuk9X/zImYSrTNf1zf+jeqtPQNmBmuT506LpUvxienze2zDbh0E09SBSw==
X-Received: by 2002:a17:907:6da4:b0:96f:1f79:c0a6 with SMTP id
 sb36-20020a1709076da400b0096f1f79c0a6mr6940138ejc.70.1685620311554; 
 Thu, 01 Jun 2023 04:51:51 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 j6-20020aa7c0c6000000b00514b2a9ce60sm3227553edp.81.2023.06.01.04.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 04:51:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH 03/12] vpc: mark more functions as coroutine_fns and
 GRAPH_RDLOCK
Date: Thu,  1 Jun 2023 13:51:36 +0200
Message-Id: <20230601115145.196465-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601115145.196465-1-pbonzini@redhat.com>
References: <20230601115145.196465-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Mark functions as coroutine_fn when they are only called by other coroutine_fns
and they can suspend.  Change calls to co_wrappers to use the non-wrapped
functions, which in turn requires adding GRAPH_RDLOCK annotations.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/vpc.c | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/block/vpc.c b/block/vpc.c
index 5af8e2807112..22a160267131 100644
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
2.40.1


