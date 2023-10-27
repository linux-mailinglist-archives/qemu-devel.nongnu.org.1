Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F107D9DAC
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 17:58:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwPAM-0004qX-6u; Fri, 27 Oct 2023 11:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwPAE-00047R-DV
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:54:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwPA9-0002zJ-UP
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698422056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SwBYclsnFH5vWLO1S0RZoTomczByXS9X23T1mrJweng=;
 b=FW3KK0vwtlDmv14PH7Hy1e8JtV9vSGkUud4uLfdjzRdgSNUOEw8vK1LjWFhnf/KSc0gHt7
 40oCyaiBw0laey/vkdlu711nWIN2V8zr2AG1/Sy0oFIeRSQMHQ03NpzRdvJ01awv1YluvC
 c2nE5j/kiJm5xfIyzdTzWqM4aGABigo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-7vqIT3D8O1C9tNADsJmiYg-1; Fri, 27 Oct 2023 11:54:13 -0400
X-MC-Unique: 7vqIT3D8O1C9tNADsJmiYg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C79DC185A780;
 Fri, 27 Oct 2023 15:54:12 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95E225027;
 Fri, 27 Oct 2023 15:54:11 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eesposit@redhat.com,
 eblake@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 22/24] vhdx: Take locks for accessing bs->file
Date: Fri, 27 Oct 2023 17:53:31 +0200
Message-ID: <20231027155333.420094-23-kwolf@redhat.com>
In-Reply-To: <20231027155333.420094-1-kwolf@redhat.com>
References: <20231027155333.420094-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This updates the vhdx code to add GRAPH_RDLOCK annotations for all
places that read bs->file.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vhdx.h     |  9 ++++++---
 block/vhdx-log.c | 40 ++++++++++++++++++++++------------------
 block/vhdx.c     | 18 +++++++++++-------
 3 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/block/vhdx.h b/block/vhdx.h
index 85594a5380..c6dd4d6040 100644
--- a/block/vhdx.h
+++ b/block/vhdx.h
@@ -401,8 +401,9 @@ typedef struct BDRVVHDXState {
 
 void vhdx_guid_generate(MSGUID *guid);
 
-int vhdx_update_headers(BlockDriverState *bs, BDRVVHDXState *s, bool rw,
-                        MSGUID *log_guid);
+int GRAPH_RDLOCK
+vhdx_update_headers(BlockDriverState *bs, BDRVVHDXState *s, bool rw,
+                    MSGUID *log_guid);
 
 uint32_t vhdx_update_checksum(uint8_t *buf, size_t size, int crc_offset);
 uint32_t vhdx_checksum_calc(uint32_t crc, uint8_t *buf, size_t size,
@@ -448,6 +449,8 @@ void vhdx_metadata_header_le_import(VHDXMetadataTableHeader *hdr);
 void vhdx_metadata_header_le_export(VHDXMetadataTableHeader *hdr);
 void vhdx_metadata_entry_le_import(VHDXMetadataTableEntry *e);
 void vhdx_metadata_entry_le_export(VHDXMetadataTableEntry *e);
-int vhdx_user_visible_write(BlockDriverState *bs, BDRVVHDXState *s);
+
+int GRAPH_RDLOCK
+vhdx_user_visible_write(BlockDriverState *bs, BDRVVHDXState *s);
 
 #endif
diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index d8ed651b70..4385a2d4f6 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -55,8 +55,9 @@ static const MSGUID zero_guid = { 0 };
 
 /* Allow peeking at the hdr entry at the beginning of the current
  * read index, without advancing the read index */
-static int vhdx_log_peek_hdr(BlockDriverState *bs, VHDXLogEntries *log,
-                             VHDXLogEntryHeader *hdr)
+static int GRAPH_RDLOCK
+vhdx_log_peek_hdr(BlockDriverState *bs, VHDXLogEntries *log,
+                  VHDXLogEntryHeader *hdr)
 {
     int ret = 0;
     uint64_t offset;
@@ -107,7 +108,7 @@ static int vhdx_log_inc_idx(uint32_t idx, uint64_t length)
 
 
 /* Reset the log to empty */
-static void vhdx_log_reset(BlockDriverState *bs, BDRVVHDXState *s)
+static void GRAPH_RDLOCK vhdx_log_reset(BlockDriverState *bs, BDRVVHDXState *s)
 {
     MSGUID guid = { 0 };
     s->log.read = s->log.write = 0;
@@ -127,9 +128,10 @@ static void vhdx_log_reset(BlockDriverState *bs, BDRVVHDXState *s)
  * not modified.
  *
  * 0 is returned on success, -errno otherwise.  */
-static int vhdx_log_read_sectors(BlockDriverState *bs, VHDXLogEntries *log,
-                                 uint32_t *sectors_read, void *buffer,
-                                 uint32_t num_sectors, bool peek)
+static int GRAPH_RDLOCK
+vhdx_log_read_sectors(BlockDriverState *bs, VHDXLogEntries *log,
+                      uint32_t *sectors_read, void *buffer,
+                      uint32_t num_sectors, bool peek)
 {
     int ret = 0;
     uint64_t offset;
@@ -333,9 +335,9 @@ static int vhdx_compute_desc_sectors(uint32_t desc_cnt)
  * will allocate all the space for buffer, which must be NULL when
  * passed into this function. Each descriptor will also be validated,
  * and error returned if any are invalid. */
-static int vhdx_log_read_desc(BlockDriverState *bs, BDRVVHDXState *s,
-                              VHDXLogEntries *log, VHDXLogDescEntries **buffer,
-                              bool convert_endian)
+static int GRAPH_RDLOCK
+vhdx_log_read_desc(BlockDriverState *bs, BDRVVHDXState *s, VHDXLogEntries *log,
+                   VHDXLogDescEntries **buffer, bool convert_endian)
 {
     int ret = 0;
     uint32_t desc_sectors;
@@ -412,8 +414,9 @@ exit:
  * For a zero descriptor, it may describe multiple sectors to fill with zeroes.
  * In this case, it should be noted that zeroes are written to disk, and the
  * image file is not extended as a sparse file.  */
-static int vhdx_log_flush_desc(BlockDriverState *bs, VHDXLogDescriptor *desc,
-                               VHDXLogDataSector *data)
+static int GRAPH_RDLOCK
+vhdx_log_flush_desc(BlockDriverState *bs, VHDXLogDescriptor *desc,
+                    VHDXLogDataSector *data)
 {
     int ret = 0;
     uint64_t seq, file_offset;
@@ -484,8 +487,8 @@ exit:
  * file, and then set the log to 'empty' status once complete.
  *
  * The log entries should be validate prior to flushing */
-static int vhdx_log_flush(BlockDriverState *bs, BDRVVHDXState *s,
-                          VHDXLogSequence *logs)
+static int GRAPH_RDLOCK
+vhdx_log_flush(BlockDriverState *bs, BDRVVHDXState *s, VHDXLogSequence *logs)
 {
     int ret = 0;
     int i;
@@ -584,9 +587,10 @@ exit:
     return ret;
 }
 
-static int vhdx_validate_log_entry(BlockDriverState *bs, BDRVVHDXState *s,
-                                   VHDXLogEntries *log, uint64_t seq,
-                                   bool *valid, VHDXLogEntryHeader *entry)
+static int GRAPH_RDLOCK
+vhdx_validate_log_entry(BlockDriverState *bs, BDRVVHDXState *s,
+                        VHDXLogEntries *log, uint64_t seq,
+                        bool *valid, VHDXLogEntryHeader *entry)
 {
     int ret = 0;
     VHDXLogEntryHeader hdr;
@@ -663,8 +667,8 @@ free_and_exit:
 /* Search through the log circular buffer, and find the valid, active
  * log sequence, if any exists
  * */
-static int vhdx_log_search(BlockDriverState *bs, BDRVVHDXState *s,
-                           VHDXLogSequence *logs)
+static int GRAPH_RDLOCK
+vhdx_log_search(BlockDriverState *bs, BDRVVHDXState *s, VHDXLogSequence *logs)
 {
     int ret = 0;
     uint32_t tail;
diff --git a/block/vhdx.c b/block/vhdx.c
index 50aefa5fb5..fa3875fa63 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -353,8 +353,9 @@ exit:
  *
  *  - non-current header is updated with largest sequence number
  */
-static int vhdx_update_header(BlockDriverState *bs, BDRVVHDXState *s,
-                              bool generate_data_write_guid, MSGUID *log_guid)
+static int GRAPH_RDLOCK
+vhdx_update_header(BlockDriverState *bs, BDRVVHDXState *s,
+                   bool generate_data_write_guid, MSGUID *log_guid)
 {
     int ret = 0;
     int hdr_idx = 0;
@@ -416,8 +417,8 @@ int vhdx_update_headers(BlockDriverState *bs, BDRVVHDXState *s,
 }
 
 /* opens the specified header block from the VHDX file header section */
-static void vhdx_parse_header(BlockDriverState *bs, BDRVVHDXState *s,
-                              Error **errp)
+static void GRAPH_RDLOCK
+vhdx_parse_header(BlockDriverState *bs, BDRVVHDXState *s, Error **errp)
 {
     int ret;
     VHDXHeader *header1;
@@ -517,7 +518,8 @@ exit:
 }
 
 
-static int vhdx_open_region_tables(BlockDriverState *bs, BDRVVHDXState *s)
+static int GRAPH_RDLOCK
+vhdx_open_region_tables(BlockDriverState *bs, BDRVVHDXState *s)
 {
     int ret = 0;
     uint8_t *buffer;
@@ -634,7 +636,8 @@ fail:
  * Also, if the File Parameters indicate this is a differencing file,
  * we must also look for the Parent Locator metadata item.
  */
-static int vhdx_parse_metadata(BlockDriverState *bs, BDRVVHDXState *s)
+static int GRAPH_RDLOCK
+vhdx_parse_metadata(BlockDriverState *bs, BDRVVHDXState *s)
 {
     int ret = 0;
     uint8_t *buffer;
@@ -885,7 +888,8 @@ static void vhdx_calc_bat_entries(BDRVVHDXState *s)
 
 }
 
-static int vhdx_check_bat_entries(BlockDriverState *bs, int *errcnt)
+static int coroutine_mixed_fn GRAPH_RDLOCK
+vhdx_check_bat_entries(BlockDriverState *bs, int *errcnt)
 {
     BDRVVHDXState *s = bs->opaque;
     int64_t image_file_size = bdrv_getlength(bs->file->bs);
-- 
2.41.0


