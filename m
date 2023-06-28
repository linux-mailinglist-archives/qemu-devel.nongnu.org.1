Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 363A274139C
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 16:19:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEVyB-0000IG-Sq; Wed, 28 Jun 2023 10:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEVy4-0008V7-Tq
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:16:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEVy3-0005OE-4Q
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687961782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B2OIJbsBRHq3dAFB1PjrNM7Ngyqas2Lg9ragXt9nc3c=;
 b=K1e96nr4tzoBQj3PCntKwu+URIXSbeyIRosOimM7/1ck6N/H/eL876ATuXaqH7LtpjBbyC
 Md43T3jrGnJSNKeuUmHdZ7AD9nZcF00Y9qpNUxF220/RPZiv3ML2uKnZkAVkVG8rXCR7l6
 bn0ycr3rJR5hpGgGbGUrVKfHKOrYNNA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-uZk6sP0IPVeIQBbAsP9tWg-1; Wed, 28 Jun 2023 10:16:11 -0400
X-MC-Unique: uZk6sP0IPVeIQBbAsP9tWg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D34AD8002BF;
 Wed, 28 Jun 2023 14:15:58 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.195.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D64E40C2063;
 Wed, 28 Jun 2023 14:15:58 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 19/23] vmdk: mark more functions as coroutine_fns and
 GRAPH_RDLOCK
Date: Wed, 28 Jun 2023 16:15:22 +0200
Message-ID: <20230628141526.293104-20-kwolf@redhat.com>
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

Mark functions as coroutine_fn when they are only called by other coroutine_fns
and they can suspend.  Change calls to co_wrappers to use the non-wrapped
functions, which in turn requires adding GRAPH_RDLOCK annotations.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20230601115145.196465-9-pbonzini@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vmdk.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index e3e86608ec..0410b895dc 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -339,7 +339,8 @@ out:
     return ret;
 }
 
-static int vmdk_write_cid(BlockDriverState *bs, uint32_t cid)
+static int coroutine_fn GRAPH_RDLOCK
+vmdk_write_cid(BlockDriverState *bs, uint32_t cid)
 {
     char *desc, *tmp_desc;
     char *p_name, *tmp_str;
@@ -348,7 +349,7 @@ static int vmdk_write_cid(BlockDriverState *bs, uint32_t cid)
 
     desc = g_malloc0(DESC_SIZE);
     tmp_desc = g_malloc0(DESC_SIZE);
-    ret = bdrv_pread(bs->file, s->desc_offset, DESC_SIZE, desc, 0);
+    ret = bdrv_co_pread(bs->file, s->desc_offset, DESC_SIZE, desc, 0);
     if (ret < 0) {
         goto out;
     }
@@ -368,7 +369,7 @@ static int vmdk_write_cid(BlockDriverState *bs, uint32_t cid)
         pstrcat(desc, DESC_SIZE, tmp_desc);
     }
 
-    ret = bdrv_pwrite_sync(bs->file, s->desc_offset, DESC_SIZE, desc, 0);
+    ret = bdrv_co_pwrite_sync(bs->file, s->desc_offset, DESC_SIZE, desc, 0);
 
 out:
     g_free(desc);
@@ -2165,7 +2166,7 @@ vmdk_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
     return ret;
 }
 
-static int GRAPH_UNLOCKED
+static int coroutine_fn GRAPH_UNLOCKED
 vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
                  bool zeroed_grain, Error **errp)
 {
@@ -2176,7 +2177,7 @@ vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
     int gd_buf_size;
 
     if (flat) {
-        ret = blk_truncate(blk, filesize, false, PREALLOC_MODE_OFF, 0, errp);
+        ret = blk_co_truncate(blk, filesize, false, PREALLOC_MODE_OFF, 0, errp);
         goto exit;
     }
     magic = cpu_to_be32(VMDK4_MAGIC);
@@ -2228,19 +2229,19 @@ vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
     header.check_bytes[3] = 0xa;
 
     /* write all the data */
-    ret = blk_pwrite(blk, 0, sizeof(magic), &magic, 0);
+    ret = blk_co_pwrite(blk, 0, sizeof(magic), &magic, 0);
     if (ret < 0) {
         error_setg(errp, QERR_IO_ERROR);
         goto exit;
     }
-    ret = blk_pwrite(blk, sizeof(magic), sizeof(header), &header, 0);
+    ret = blk_co_pwrite(blk, sizeof(magic), sizeof(header), &header, 0);
     if (ret < 0) {
         error_setg(errp, QERR_IO_ERROR);
         goto exit;
     }
 
-    ret = blk_truncate(blk, le64_to_cpu(header.grain_offset) << 9, false,
-                       PREALLOC_MODE_OFF, 0, errp);
+    ret = blk_co_truncate(blk, le64_to_cpu(header.grain_offset) << 9, false,
+                          PREALLOC_MODE_OFF, 0, errp);
     if (ret < 0) {
         goto exit;
     }
@@ -2252,8 +2253,8 @@ vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
          i < gt_count; i++, tmp += gt_size) {
         gd_buf[i] = cpu_to_le32(tmp);
     }
-    ret = blk_pwrite(blk, le64_to_cpu(header.rgd_offset) * BDRV_SECTOR_SIZE,
-                     gd_buf_size, gd_buf, 0);
+    ret = blk_co_pwrite(blk, le64_to_cpu(header.rgd_offset) * BDRV_SECTOR_SIZE,
+                        gd_buf_size, gd_buf, 0);
     if (ret < 0) {
         error_setg(errp, QERR_IO_ERROR);
         goto exit;
@@ -2264,8 +2265,8 @@ vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
          i < gt_count; i++, tmp += gt_size) {
         gd_buf[i] = cpu_to_le32(tmp);
     }
-    ret = blk_pwrite(blk, le64_to_cpu(header.gd_offset) * BDRV_SECTOR_SIZE,
-                     gd_buf_size, gd_buf, 0);
+    ret = blk_co_pwrite(blk, le64_to_cpu(header.gd_offset) * BDRV_SECTOR_SIZE,
+                        gd_buf_size, gd_buf, 0);
     if (ret < 0) {
         error_setg(errp, QERR_IO_ERROR);
     }
-- 
2.41.0


