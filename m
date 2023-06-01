Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C26C7719B4E
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:55:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4gqo-0001RM-Rb; Thu, 01 Jun 2023 07:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqb-0001C8-2Y
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:52:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqZ-0000Mu-Cr
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685620322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p505Phhkx6YtNgSh3YBugYQztGZodw4U0C8ss9gsYXA=;
 b=BWc578JzRKl363Zj8FIOFIwFAVkQzoAGA6E7qayHHVF1ySS8xUmIEaCJact0JQ012rJnKT
 Rg0oqZWy4TGrPT9JSZ1ttWM9HQ4q5D1Gya71+oBxpY6fm3GaJNF7hRbf3NuZVMI2mqwFXQ
 TrCX1QZBsAysiryJnP1AGgkPUmInCd8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-T-PfM9dwP0Si8680Lbkiyw-1; Thu, 01 Jun 2023 07:52:01 -0400
X-MC-Unique: T-PfM9dwP0Si8680Lbkiyw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9737cde2ce8so103222966b.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685620320; x=1688212320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p505Phhkx6YtNgSh3YBugYQztGZodw4U0C8ss9gsYXA=;
 b=bm8ww0erom2xx4z7kk+rbInmWJfgDN0G7CPQmQ5Fcp7AGkl5i4OxX91F0RaLOMuJhx
 n+e5Jo+qvQNieZrqOp4K5UsBDErvATg+QvewuPS83nBsVunocTpxchwgUIYhrLipcUhY
 ri2LB/uUujIAw4JNp7ypHoj7l8Ol1olyAO4Nx66fX8Xhpvb3eABMdTz/jnkuF9LjnnAK
 yx0cRsoZUpXNas6RrKq1X5vwtc+j5TdxlaQPRvO7EoOi7dafC0cnjkesLoKn1CFLMREp
 pYPfa7l+e53rUEiC4inHrlOf75E/uv8VERC+pnel6b4M0SAJYXDR23bBTNSqRPE+K+8E
 om3g==
X-Gm-Message-State: AC+VfDwG11TS9wV2OLzzT54QR/pEAc1suiss4SEmvxTf3HbsTlstkJbT
 U3fxk2UQI9zvuNXqy2wk9pTGH9Q+NJ8I/9a/yy0aoXzChSisqCTn41a9l79WRsJrEF6wgp3Q6x+
 j+UrQMV6XbJ0gDMhqr02Q+ZkXRjMzJ0ZAqORAdlj1q0xz7gVEmDax5fpqrLOXZGhxJodIvY0NUr
 M=
X-Received: by 2002:a17:907:3f2a:b0:96f:7d0a:5981 with SMTP id
 hq42-20020a1709073f2a00b0096f7d0a5981mr1361261ejc.36.1685620319901; 
 Thu, 01 Jun 2023 04:51:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7/ys4qwIWzcNy2ek7sGMt6Y0WclhJcpIReni+mGiHV5jLBQtFIQohf4eWU9220LuOepZA8uw==
X-Received: by 2002:a17:907:3f2a:b0:96f:7d0a:5981 with SMTP id
 hq42-20020a1709073f2a00b0096f7d0a5981mr1361250ejc.36.1685620319633; 
 Thu, 01 Jun 2023 04:51:59 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 lk15-20020a170906cb0f00b0096f5781205fsm10444397ejb.165.2023.06.01.04.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 04:51:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH 08/12] vmdk: mark more functions as coroutine_fns and
 GRAPH_RDLOCK
Date: Thu,  1 Jun 2023 13:51:41 +0200
Message-Id: <20230601115145.196465-9-pbonzini@redhat.com>
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
 block/vmdk.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index a864069a5a1f..419868a42ae2 100644
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
2.40.1


