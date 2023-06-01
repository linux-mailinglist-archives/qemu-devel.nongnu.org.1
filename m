Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9067719B49
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:55:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4gqv-0001X6-0s; Thu, 01 Jun 2023 07:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqs-0001WH-QC
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:52:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqd-0000Nx-2J
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685620325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Exraz4pe9MsBvAgBn7XjlVETcy1FbQxMyAH+SRVNttc=;
 b=Ipnajd8fqkvtc9ijws8GPIMipCrWMu4s4jyYNFim5SM2EsZAFL7Eos3RgEHpcm7fPjue2m
 0zjhwGe+1lJL4eK7+wT4ui8SBbZjJveaCwcoHw8h+Pl53tcMxbn/+AnffAdKiVLA8ki5KR
 jSm446mAIV0dWWpHwB1b2rklJjSvTBw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-JF-Ezf6oPJeoj9wyhJj6VQ-1; Thu, 01 Jun 2023 07:52:03 -0400
X-MC-Unique: JF-Ezf6oPJeoj9wyhJj6VQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94a355c9028so47175566b.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685620321; x=1688212321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Exraz4pe9MsBvAgBn7XjlVETcy1FbQxMyAH+SRVNttc=;
 b=BfdsguZoRvvzMVskFqcuRebbrFkm9rhWzxiRt/tO2RiKxH/rqYfEBSm/ppYGyaPQnK
 tb98coA1E5In4NZlAtVQUhjG2Du+MVwbsIyCjmG5s10adef1tK0CAoY5IOBdkxcvx/vn
 dk6msmFYfjrIYh93f//cuVtTeJxekSfTJNDfGaRCcJ/3EcHi7W2hREaDeY+ZqauraCKe
 OLs5K2QTFnLIUcls1cKm5lL7MfYoOevUo7Q320+qVJgdxwTeT6TAx1cWhCIdnn4yNd61
 6jycrqcNviFVCK+vxpt/IRlQY9lTo2TPV1jUriKTSkeBbzryqevHK3+X/l+TSCeaIO/m
 nVUA==
X-Gm-Message-State: AC+VfDzLR5fD8wWv+SeAphEAL0eboz/rdadRFMdOoAznQmRnV1Prhux4
 MO3HRfY3qibk6G9pc2/UJuARMsi2WUV8NP7Pm3Bmp7nHN5auvN/jefcEEh8QFWQDpEOjMMp1+4C
 a+QLIUfWZF8RV5zyBEU/sueYcETnSj5OpQzymOi86PSFlEQ9DTbbjIm9qUOxKg/Sp6LbqdMNacY
 0=
X-Received: by 2002:a17:906:fe08:b0:973:d8c4:a4df with SMTP id
 wy8-20020a170906fe0800b00973d8c4a4dfmr7955669ejb.52.1685620321576; 
 Thu, 01 Jun 2023 04:52:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ZMs+1fqnlcNRjTlsbm/McpIyQgX6p3s1Z1+NeTKwDkFWfMO6xra5zUuwcc0TmW/vHVcy2TA==
X-Received: by 2002:a17:906:fe08:b0:973:d8c4:a4df with SMTP id
 wy8-20020a170906fe0800b00973d8c4a4dfmr7955646ejb.52.1685620321301; 
 Thu, 01 Jun 2023 04:52:01 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a1709064d4800b00965f31ff894sm10371684ejv.137.2023.06.01.04.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 04:52:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH 09/12] vhdx: mark more functions as coroutine_fns and
 GRAPH_RDLOCK
Date: Thu,  1 Jun 2023 13:51:42 +0200
Message-Id: <20230601115145.196465-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601115145.196465-1-pbonzini@redhat.com>
References: <20230601115145.196465-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
 block/vhdx-log.c | 36 +++++++++++++-----------
 block/vhdx.c     | 73 +++++++++++++++++++++++-------------------------
 block/vhdx.h     |  5 ++--
 3 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index 38148f107a97..cf36d2b3a346 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -169,9 +169,10 @@ exit:
  * It is assumed that 'buffer' is at least 4096*num_sectors large.
  *
  * 0 is returned on success, -errno otherwise */
-static int vhdx_log_write_sectors(BlockDriverState *bs, VHDXLogEntries *log,
-                                  uint32_t *sectors_written, void *buffer,
-                                  uint32_t num_sectors)
+static int coroutine_fn GRAPH_RDLOCK
+vhdx_log_write_sectors(BlockDriverState *bs, VHDXLogEntries *log,
+                       uint32_t *sectors_written, void *buffer,
+                       uint32_t num_sectors)
 {
     int ret = 0;
     uint64_t offset;
@@ -195,8 +196,7 @@ static int vhdx_log_write_sectors(BlockDriverState *bs, VHDXLogEntries *log,
             /* full */
             break;
         }
-        ret = bdrv_pwrite(bs->file, offset, VHDX_LOG_SECTOR_SIZE, buffer_tmp,
-                          0);
+        ret = bdrv_co_pwrite(bs->file, offset, VHDX_LOG_SECTOR_SIZE, buffer_tmp, 0);
         if (ret < 0) {
             goto exit;
         }
@@ -853,8 +853,9 @@ static void vhdx_log_raw_to_le_sector(VHDXLogDescriptor *desc,
 }
 
 
-static int vhdx_log_write(BlockDriverState *bs, BDRVVHDXState *s,
-                          void *data, uint32_t length, uint64_t offset)
+static int coroutine_fn GRAPH_RDLOCK
+vhdx_log_write(BlockDriverState *bs, BDRVVHDXState *s,
+               void *data, uint32_t length, uint64_t offset)
 {
     int ret = 0;
     void *buffer = NULL;
@@ -924,7 +925,7 @@ static int vhdx_log_write(BlockDriverState *bs, BDRVVHDXState *s,
 
     sectors += partial_sectors;
 
-    file_length = bdrv_getlength(bs->file->bs);
+    file_length = bdrv_co_getlength(bs->file->bs);
     if (file_length < 0) {
         ret = file_length;
         goto exit;
@@ -971,8 +972,8 @@ static int vhdx_log_write(BlockDriverState *bs, BDRVVHDXState *s,
 
         if (i == 0 && leading_length) {
             /* partial sector at the front of the buffer */
-            ret = bdrv_pread(bs->file, file_offset, VHDX_LOG_SECTOR_SIZE,
-                             merged_sector, 0);
+            ret = bdrv_co_pread(bs->file, file_offset, VHDX_LOG_SECTOR_SIZE,
+                                merged_sector, 0);
             if (ret < 0) {
                 goto exit;
             }
@@ -981,9 +982,9 @@ static int vhdx_log_write(BlockDriverState *bs, BDRVVHDXState *s,
             sector_write = merged_sector;
         } else if (i == sectors - 1 && trailing_length) {
             /* partial sector at the end of the buffer */
-            ret = bdrv_pread(bs->file, file_offset + trailing_length,
-                             VHDX_LOG_SECTOR_SIZE - trailing_length,
-                             merged_sector + trailing_length, 0);
+            ret = bdrv_co_pread(bs->file, file_offset + trailing_length,
+                                VHDX_LOG_SECTOR_SIZE - trailing_length,
+                                merged_sector + trailing_length, 0);
             if (ret < 0) {
                 goto exit;
             }
@@ -1036,8 +1037,9 @@ exit:
 }
 
 /* Perform a log write, and then immediately flush the entire log */
-int vhdx_log_write_and_flush(BlockDriverState *bs, BDRVVHDXState *s,
-                             void *data, uint32_t length, uint64_t offset)
+int coroutine_fn GRAPH_RDLOCK
+vhdx_log_write_and_flush(BlockDriverState *bs, BDRVVHDXState *s,
+                         void *data, uint32_t length, uint64_t offset)
 {
     int ret = 0;
     VHDXLogSequence logs = { .valid = true,
@@ -1047,7 +1049,7 @@ int vhdx_log_write_and_flush(BlockDriverState *bs, BDRVVHDXState *s,
 
     /* Make sure data written (new and/or changed blocks) is stable
      * on disk, before creating log entry */
-    ret = bdrv_flush(bs);
+    ret = bdrv_co_flush(bs);
     if (ret < 0) {
         goto exit;
     }
@@ -1059,7 +1061,7 @@ int vhdx_log_write_and_flush(BlockDriverState *bs, BDRVVHDXState *s,
     logs.log = s->log;
 
     /* Make sure log is stable on disk */
-    ret = bdrv_flush(bs);
+    ret = bdrv_co_flush(bs);
     if (ret < 0) {
         goto exit;
     }
diff --git a/block/vhdx.c b/block/vhdx.c
index 798b6aacf419..45a11255b306 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1250,12 +1250,13 @@ exit:
  *
  * Returns the file offset start of the new payload block
  */
-static int vhdx_allocate_block(BlockDriverState *bs, BDRVVHDXState *s,
-                               uint64_t *new_offset, bool *need_zero)
+static int coroutine_fn GRAPH_RDLOCK
+vhdx_allocate_block(BlockDriverState *bs, BDRVVHDXState *s,
+                    uint64_t *new_offset, bool *need_zero)
 {
     int64_t current_len;
 
-    current_len = bdrv_getlength(bs->file->bs);
+    current_len = bdrv_co_getlength(bs->file->bs);
     if (current_len < 0) {
         return current_len;
     }
@@ -1271,16 +1272,16 @@ static int vhdx_allocate_block(BlockDriverState *bs, BDRVVHDXState *s,
     if (*need_zero) {
         int ret;
 
-        ret = bdrv_truncate(bs->file, *new_offset + s->block_size, false,
-                            PREALLOC_MODE_OFF, BDRV_REQ_ZERO_WRITE, NULL);
+        ret = bdrv_co_truncate(bs->file, *new_offset + s->block_size, false,
+                               PREALLOC_MODE_OFF, BDRV_REQ_ZERO_WRITE, NULL);
         if (ret != -ENOTSUP) {
             *need_zero = false;
             return ret;
         }
     }
 
-    return bdrv_truncate(bs->file, *new_offset + s->block_size, false,
-                         PREALLOC_MODE_OFF, 0, NULL);
+    return bdrv_co_truncate(bs->file, *new_offset + s->block_size, false,
+                            PREALLOC_MODE_OFF, 0, NULL);
 }
 
 /*
@@ -1572,12 +1573,10 @@ exit:
  * The first 64KB of the Metadata section is reserved for the metadata
  * header and entries; beyond that, the metadata items themselves reside.
  */
-static int vhdx_create_new_metadata(BlockBackend *blk,
-                                    uint64_t image_size,
-                                    uint32_t block_size,
-                                    uint32_t sector_size,
-                                    uint64_t metadata_offset,
-                                    VHDXImageType type)
+static int coroutine_fn
+vhdx_create_new_metadata(BlockBackend *blk, uint64_t image_size,
+                         uint32_t block_size, uint32_t sector_size,
+                         uint64_t metadata_offset, VHDXImageType type)
 {
     int ret = 0;
     uint32_t offset = 0;
@@ -1668,13 +1667,13 @@ static int vhdx_create_new_metadata(BlockBackend *blk,
                                    VHDX_META_FLAGS_IS_VIRTUAL_DISK;
     vhdx_metadata_entry_le_export(&md_table_entry[4]);
 
-    ret = blk_pwrite(blk, metadata_offset, VHDX_HEADER_BLOCK_SIZE, buffer, 0);
+    ret = blk_co_pwrite(blk, metadata_offset, VHDX_HEADER_BLOCK_SIZE, buffer, 0);
     if (ret < 0) {
         goto exit;
     }
 
-    ret = blk_pwrite(blk, metadata_offset + (64 * KiB),
-                     VHDX_METADATA_ENTRY_BUFFER_SIZE, entry_buffer, 0);
+    ret = blk_co_pwrite(blk, metadata_offset + (64 * KiB),
+                        VHDX_METADATA_ENTRY_BUFFER_SIZE, entry_buffer, 0);
     if (ret < 0) {
         goto exit;
     }
@@ -1694,10 +1693,11 @@ exit:
  *  Fixed images: default state of the BAT is fully populated, with
  *                file offsets and state PAYLOAD_BLOCK_FULLY_PRESENT.
  */
-static int vhdx_create_bat(BlockBackend *blk, BDRVVHDXState *s,
-                           uint64_t image_size, VHDXImageType type,
-                           bool use_zero_blocks, uint64_t file_offset,
-                           uint32_t length, Error **errp)
+static int coroutine_fn
+vhdx_create_bat(BlockBackend *blk, BDRVVHDXState *s,
+                uint64_t image_size, VHDXImageType type,
+                bool use_zero_blocks, uint64_t file_offset,
+                uint32_t length, Error **errp)
 {
     int ret = 0;
     uint64_t data_file_offset;
@@ -1718,14 +1718,14 @@ static int vhdx_create_bat(BlockBackend *blk, BDRVVHDXState *s,
     if (type == VHDX_TYPE_DYNAMIC) {
         /* All zeroes, so we can just extend the file - the end of the BAT
          * is the furthest thing we have written yet */
-        ret = blk_truncate(blk, data_file_offset, false, PREALLOC_MODE_OFF,
-                           0, errp);
+        ret = blk_co_truncate(blk, data_file_offset, false, PREALLOC_MODE_OFF,
+                              0, errp);
         if (ret < 0) {
             goto exit;
         }
     } else if (type == VHDX_TYPE_FIXED) {
-        ret = blk_truncate(blk, data_file_offset + image_size, false,
-                           PREALLOC_MODE_OFF, 0, errp);
+        ret = blk_co_truncate(blk, data_file_offset + image_size, false,
+                              PREALLOC_MODE_OFF, 0, errp);
         if (ret < 0) {
             goto exit;
         }
@@ -1759,7 +1759,7 @@ static int vhdx_create_bat(BlockBackend *blk, BDRVVHDXState *s,
             s->bat[sinfo.bat_idx] = cpu_to_le64(s->bat[sinfo.bat_idx]);
             sector_num += s->sectors_per_block;
         }
-        ret = blk_pwrite(blk, file_offset, length, s->bat, 0);
+        ret = blk_co_pwrite(blk, file_offset, length, s->bat, 0);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Failed to write the BAT");
             goto exit;
@@ -1780,15 +1780,12 @@ exit:
  * to create the BAT itself, we will also cause the BAT to be
  * created.
  */
-static int vhdx_create_new_region_table(BlockBackend *blk,
-                                        uint64_t image_size,
-                                        uint32_t block_size,
-                                        uint32_t sector_size,
-                                        uint32_t log_size,
-                                        bool use_zero_blocks,
-                                        VHDXImageType type,
-                                        uint64_t *metadata_offset,
-                                        Error **errp)
+static int coroutine_fn
+vhdx_create_new_region_table(BlockBackend *blk, uint64_t image_size,
+                             uint32_t block_size, uint32_t sector_size,
+                             uint32_t log_size, bool use_zero_blocks,
+                             VHDXImageType type, uint64_t *metadata_offset,
+                             Error **errp)
 {
     int ret = 0;
     uint32_t offset = 0;
@@ -1863,15 +1860,15 @@ static int vhdx_create_new_region_table(BlockBackend *blk,
     }
 
     /* Now write out the region headers to disk */
-    ret = blk_pwrite(blk, VHDX_REGION_TABLE_OFFSET, VHDX_HEADER_BLOCK_SIZE,
-                     buffer, 0);
+    ret = blk_co_pwrite(blk, VHDX_REGION_TABLE_OFFSET, VHDX_HEADER_BLOCK_SIZE,
+                        buffer, 0);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to write first region table");
         goto exit;
     }
 
-    ret = blk_pwrite(blk, VHDX_REGION_TABLE2_OFFSET, VHDX_HEADER_BLOCK_SIZE,
-                     buffer, 0);
+    ret = blk_co_pwrite(blk, VHDX_REGION_TABLE2_OFFSET, VHDX_HEADER_BLOCK_SIZE,
+                        buffer, 0);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to write second region table");
         goto exit;
diff --git a/block/vhdx.h b/block/vhdx.h
index 0b74924cee98..637516b8f307 100644
--- a/block/vhdx.h
+++ b/block/vhdx.h
@@ -413,8 +413,9 @@ bool vhdx_checksum_is_valid(uint8_t *buf, size_t size, int crc_offset);
 int vhdx_parse_log(BlockDriverState *bs, BDRVVHDXState *s, bool *flushed,
                    Error **errp);
 
-int vhdx_log_write_and_flush(BlockDriverState *bs, BDRVVHDXState *s,
-                             void *data, uint32_t length, uint64_t offset);
+int coroutine_fn vhdx_log_write_and_flush(BlockDriverState *bs, BDRVVHDXState *s,
+                                          void *data, uint32_t length,
+                                          uint64_t offset);
 
 static inline void leguid_to_cpus(MSGUID *guid)
 {
-- 
2.40.1


