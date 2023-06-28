Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A493741386
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 16:17:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEVyC-0000Ic-LS; Wed, 28 Jun 2023 10:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEVy6-00006E-0R
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:16:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEVy3-0005Op-To
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687961783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iBhtcKHm0pGYgiaWtNkYrHZAZjYE7RlKLlvq9d5ieqU=;
 b=YoYX+ghjv1EDkErq5RISiKya+oNWIW89LoOxXS/FtWP/yzFhHq5XR8HEKS9KStBn/dCue8
 2DZ7/uMrdwdiSJBN2jiySMKLkXBrXdxHEQwc55H3jZsDvQgIBd9PFLwQ96B4S2bav0tf7h
 5cDC6Us1WGXMY2cjcgdJO7izG99ozjE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-YeN7pYJBPqmtLoNAMnVXzw-1; Wed, 28 Jun 2023 10:16:19 -0400
X-MC-Unique: YeN7pYJBPqmtLoNAMnVXzw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EB5D84B168;
 Wed, 28 Jun 2023 14:16:00 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.195.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 161AF40C2063;
 Wed, 28 Jun 2023 14:15:58 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 20/23] vhdx: mark more functions as coroutine_fns and
 GRAPH_RDLOCK
Date: Wed, 28 Jun 2023 16:15:23 +0200
Message-ID: <20230628141526.293104-21-kwolf@redhat.com>
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

Mark functions as coroutine_fn when they are only called by other coroutine_fns
and they can suspend.  Change calls to co_wrappers to use the non-wrapped
functions, which in turn requires adding GRAPH_RDLOCK annotations.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20230601115145.196465-10-pbonzini@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vhdx.h     |  5 ++--
 block/vhdx-log.c | 36 +++++++++++++-----------
 block/vhdx.c     | 73 +++++++++++++++++++++++-------------------------
 3 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/block/vhdx.h b/block/vhdx.h
index 0b74924cee..7db746cd18 100644
--- a/block/vhdx.h
+++ b/block/vhdx.h
@@ -413,8 +413,9 @@ bool vhdx_checksum_is_valid(uint8_t *buf, size_t size, int crc_offset);
 int vhdx_parse_log(BlockDriverState *bs, BDRVVHDXState *s, bool *flushed,
                    Error **errp);
 
-int vhdx_log_write_and_flush(BlockDriverState *bs, BDRVVHDXState *s,
-                             void *data, uint32_t length, uint64_t offset);
+int coroutine_fn GRAPH_RDLOCK
+vhdx_log_write_and_flush(BlockDriverState *bs, BDRVVHDXState *s,
+                         void *data, uint32_t length, uint64_t offset);
 
 static inline void leguid_to_cpus(MSGUID *guid)
 {
diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index 38148f107a..d8ed651b70 100644
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
+int coroutine_fn
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
index 89913cba87..f2c3a80190 100644
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
-- 
2.41.0


