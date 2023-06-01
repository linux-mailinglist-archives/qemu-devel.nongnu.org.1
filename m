Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DADA9719B33
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:53:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4gqH-00088q-FN; Thu, 01 Jun 2023 07:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqF-0007z6-1x
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:51:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqD-0000FD-G9
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685620301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FRC33n8j//iR7nSBERN/NX8JHJFnLAbHE6VHVE/3Ilo=;
 b=I18jcmUNSm3lMY3WBiCtenEJAtltOdKXNHiHtLuGRye6n/onb0XxqYvbpj0G1xS9cexSno
 P2I/TkuqOJvGxmoeBj+XuKYOCXs6swj3zts+juWEzxVLe4BC43ly6fRW6qw75n1EbRtFpu
 jQ+6SSFaTGw/P59lWwVht1kmGkaUrKc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-xquwKWE0OtmJoy76TX3rxg-1; Thu, 01 Jun 2023 07:51:39 -0400
X-MC-Unique: xquwKWE0OtmJoy76TX3rxg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94a34a0b75eso49154466b.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685620298; x=1688212298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FRC33n8j//iR7nSBERN/NX8JHJFnLAbHE6VHVE/3Ilo=;
 b=GedxkOz0KLAUBBVm0o9DBPzq1xGEN4vKSXIwCUIjrI6MteR0AxvsNxgbZyIEkBus96
 b4Mqoc+PyGkss3beJgID0LuWvJvzrTCUPNr9bqbMPiWN3LhrRRt2CjOLnj+0c5z0M2vP
 U97gHTT/uWWM4yoFzsOy7BiCYOdK9ugTgHYhfXqmrh5adxbSatK23c+TAsTrm5e3E2RN
 fhsN07eVHFIGlbpyzZLAmQsjuB2Hg3myj+pvAJQwelmIyakTcL8xbK1wshn0FFq701Jz
 mgl0D43Gs4K3r3zTZRxqG06jNZvJhmvQEsRvIfameZbe3ZXXb7gFt674I8JHL0ANbrJ0
 BbPw==
X-Gm-Message-State: AC+VfDzwcMkE3oeWOX6DzJIT14geKrq5Uoa7D6KIPf3dXqamvd8ClEB/
 nHJSh6vMvlozjPbde+8CzUmkASrsbB5DpjwqMgZOKQJ20qN45wh57vj3/q4k2pu3Zm7tv1hMR7F
 S9QblKbjiHvMyLKtBLp83shzDx2m3DtgiaZoTwaPU1NzlYXiYCuhVrHT20k46W9f7fCy8LSXnOc
 Q=
X-Received: by 2002:a17:907:724b:b0:96a:316f:8abf with SMTP id
 ds11-20020a170907724b00b0096a316f8abfmr8015501ejc.20.1685620297806; 
 Thu, 01 Jun 2023 04:51:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7/CNmYMR9Ra2287B91nXdfGHzvB6wj3r+dQlZkr8oS8IS+UESm9G11E78q140PngdSVjHsAQ==
X-Received: by 2002:a17:907:724b:b0:96a:316f:8abf with SMTP id
 ds11-20020a170907724b00b0096a316f8abfmr8015481ejc.20.1685620297455; 
 Thu, 01 Jun 2023 04:51:37 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170906244600b00965b416585bsm10411489ejb.118.2023.06.01.04.51.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 04:51:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com,
	qemu-block@nongnu.org,
	Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 3/4] block: switch to co_wrapper for bdrv_is_allocated_*
Date: Thu,  1 Jun 2023 13:51:30 +0200
Message-Id: <20230601115131.196234-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601115131.196234-1-pbonzini@redhat.com>
References: <20230601115131.196234-1-pbonzini@redhat.com>
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

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/io.c               | 53 ++++++----------------------------------
 include/block/block-io.h | 12 +++++----
 2 files changed, 14 insertions(+), 51 deletions(-)

diff --git a/block/io.c b/block/io.c
index 806715a5bbe3..2fae64ad1eb6 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2628,45 +2628,6 @@ int coroutine_fn bdrv_co_is_allocated(BlockDriverState *bs, int64_t offset,
     return !!(ret & BDRV_BLOCK_ALLOCATED);
 }
 
-int bdrv_is_allocated(BlockDriverState *bs, int64_t offset, int64_t bytes,
-                      int64_t *pnum)
-{
-    int ret;
-    int64_t dummy;
-    IO_CODE();
-
-    ret = bdrv_common_block_status_above(bs, bs, true, false, offset,
-                                         bytes, pnum ? pnum : &dummy, NULL,
-                                         NULL, NULL);
-    if (ret < 0) {
-        return ret;
-    }
-    return !!(ret & BDRV_BLOCK_ALLOCATED);
-}
-
-/* See bdrv_is_allocated_above for documentation */
-int coroutine_fn bdrv_co_is_allocated_above(BlockDriverState *top,
-                                            BlockDriverState *base,
-                                            bool include_base, int64_t offset,
-                                            int64_t bytes, int64_t *pnum)
-{
-    int depth;
-    int ret;
-    IO_CODE();
-
-    ret = bdrv_co_common_block_status_above(top, base, include_base, false,
-                                            offset, bytes, pnum, NULL, NULL,
-                                            &depth);
-    if (ret < 0) {
-        return ret;
-    }
-
-    if (ret & BDRV_BLOCK_ALLOCATED) {
-        return depth;
-    }
-    return 0;
-}
-
 /*
  * Given an image chain: ... -> [BASE] -> [INTER1] -> [INTER2] -> [TOP]
  *
@@ -2684,18 +2645,18 @@ int coroutine_fn bdrv_co_is_allocated_above(BlockDriverState *top,
  * words, the result is not necessarily the maximum possible range);
  * but 'pnum' will only be 0 when end of file is reached.
  */
-int bdrv_is_allocated_above(BlockDriverState *top,
-                            BlockDriverState *base,
-                            bool include_base, int64_t offset,
-                            int64_t bytes, int64_t *pnum)
+int coroutine_fn bdrv_co_is_allocated_above(BlockDriverState *bs,
+                                            BlockDriverState *base,
+                                            bool include_base, int64_t offset,
+                                            int64_t bytes, int64_t *pnum)
 {
     int depth;
     int ret;
     IO_CODE();
 
-    ret = bdrv_common_block_status_above(top, base, include_base, false,
-                                         offset, bytes, pnum, NULL, NULL,
-                                         &depth);
+    ret = bdrv_co_common_block_status_above(bs, base, include_base, false,
+                                            offset, bytes, pnum, NULL, NULL,
+                                            &depth);
     if (ret < 0) {
         return ret;
     }
diff --git a/include/block/block-io.h b/include/block/block-io.h
index ce75ff5ddde8..3946bbefc5c2 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -149,16 +149,18 @@ bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
 int coroutine_fn GRAPH_RDLOCK
 bdrv_co_is_allocated(BlockDriverState *bs, int64_t offset, int64_t bytes,
                      int64_t *pnum);
-int bdrv_is_allocated(BlockDriverState *bs, int64_t offset, int64_t bytes,
-                      int64_t *pnum);
+int co_wrapper_mixed_bdrv_rdlock
+bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
+                  int64_t bytes, int64_t *pnum);
 
 int coroutine_fn GRAPH_RDLOCK
 bdrv_co_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
                            bool include_base, int64_t offset, int64_t bytes,
                            int64_t *pnum);
-int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
-                            bool include_base, int64_t offset, int64_t bytes,
-                            int64_t *pnum);
+int co_wrapper_mixed_bdrv_rdlock
+bdrv_is_allocated_above(BlockDriverState *bs, BlockDriverState *base,
+                        bool include_base, int64_t offset,
+                        int64_t bytes, int64_t *pnum);
 
 int coroutine_fn GRAPH_RDLOCK
 bdrv_co_is_zero_fast(BlockDriverState *bs, int64_t offset, int64_t bytes);
-- 
2.40.1


