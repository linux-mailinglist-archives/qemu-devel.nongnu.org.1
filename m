Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 832A99B34A4
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Oct 2024 16:20:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5RX2-0000FX-Cv; Mon, 28 Oct 2024 11:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5RWq-0008Bm-J5
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:19:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5RWo-0000ps-J6
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730128772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JiVqWkstUV/F0IFzwEgI64OSPFJg4cv0MklXzVnGPTs=;
 b=KoFqhsLnFD+yGpuCOLdYgtz3AAIWzq/mveCV7fUJqi4lm8PgBK29mlRqzuvi1JB6cnyO2i
 py5dY4l3rBxHt0T6H6Y2P/2pJWNvZQsvx/253Xy56VQpQGHPevFn3JuwYWdfYKSLGpKCvf
 bRO+fiGodNbNr3+O/RgZH25dE00KfJk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-RXuGY9RZOoy40Fftb_uPAg-1; Mon, 28 Oct 2024 11:19:30 -0400
X-MC-Unique: RXuGY9RZOoy40Fftb_uPAg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315b7b0c16so34417695e9.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 08:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730128769; x=1730733569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JiVqWkstUV/F0IFzwEgI64OSPFJg4cv0MklXzVnGPTs=;
 b=drRvmaR/bM/gzw6m+VN27WBkxaBz62LWYIGb5G1j6lLJUfo235PLdCwJf12VCyCTtd
 EHQXAmNPQMXwv5pjx2SbeprGRdu0YcBkHAftnfbR+VxLVLAL1/SkCb99tdBhkKBNG5ym
 FqXzsUui2ABVQ3qiyBsSZ7Vxqz3jj0q8440H7Q3lQr8Qss31G1s7l2tBwoXjShxu4p2H
 8DNoZI+ANo1R/OdIBpcaRFtUT6UuJx3n+kTCF6bA5PQvhYoxHG/5cxn5rOGpXbV09CGb
 036pT/69AkoW6ZnxT+bJfmYk/IaBGnvvBmjCxVA34DKsc+/yMWnR07eXuEeJPg1b4Wkh
 Bjug==
X-Gm-Message-State: AOJu0YyVHF4DywyU6InL/QyL+3tYPxuHj8QD9GivkCsTXNUo3bpvhzH0
 1M2GuVk4dcibwfpPbIJ3hgMFCL57LhVWk9y1EBK79kXOSjkhETtv1ROgQnCXgfZKfHyjcHcIR9Z
 3YwYqlUtHWLcHmTvs1iZBMmZQY2zq5TVqlk2gl3gPy3QuCRNPCb77FfyXw6J25ABRB02sakTL3Z
 NNKTKJgX36NVMrblHKJmIStwGAxUaaqIvq5Hbl0u0=
X-Received: by 2002:a05:600c:4e8b:b0:431:40ca:ce44 with SMTP id
 5b1f17b1804b1-4319ad34a44mr66617535e9.30.1730128769113; 
 Mon, 28 Oct 2024 08:19:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpJjcDf1KXunpZ3F2x4M5OBAq2xIA+tSvyToXLYr4qveja7+ljn9fhKXDTufyIPoT/snkVOg==
X-Received: by 2002:a05:600c:4e8b:b0:431:40ca:ce44 with SMTP id
 5b1f17b1804b1-4319ad34a44mr66617245e9.30.1730128768522; 
 Mon, 28 Oct 2024 08:19:28 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43193595c6asm111686435e9.18.2024.10.28.08.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 08:19:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 11/14] target/i386: make flag variables unsigned
Date: Mon, 28 Oct 2024 16:18:48 +0100
Message-ID: <20241028151851.376355-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028151851.376355-1-pbonzini@redhat.com>
References: <20241028151851.376355-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This makes it easier for the compiler to understand which bits are set,
and it also removes "cltq" instructions to canonicalize the output value
as 32-bit signed.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/cc_helper_template.h.inc | 46 ++++++++++++------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/target/i386/tcg/cc_helper_template.h.inc b/target/i386/tcg/cc_helper_template.h.inc
index c5425e57cfb..4cbbc73c3cd 100644
--- a/target/i386/tcg/cc_helper_template.h.inc
+++ b/target/i386/tcg/cc_helper_template.h.inc
@@ -39,9 +39,9 @@
 
 /* dynamic flags computation */
 
-static int glue(compute_all_add, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static uint32_t glue(compute_all_add, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
     DATA_TYPE src2 = dst - src1;
 
     cf = dst < src1;
@@ -58,10 +58,10 @@ static int glue(compute_c_add, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     return dst < src1;
 }
 
-static int glue(compute_all_adc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1,
+static uint32_t glue(compute_all_adc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1,
                                          DATA_TYPE src3)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
     DATA_TYPE src2 = dst - src1 - src3;
 
     cf = (src3 ? dst <= src1 : dst < src1);
@@ -79,9 +79,9 @@ static int glue(compute_c_adc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1,
     return src3 ? dst <= src1 : dst < src1;
 }
 
-static int glue(compute_all_sub, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2)
+static uint32_t glue(compute_all_sub, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
     DATA_TYPE src1 = dst + src2;
 
     cf = src1 < src2;
@@ -100,10 +100,10 @@ static int glue(compute_c_sub, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2)
     return src1 < src2;
 }
 
-static int glue(compute_all_sbb, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2,
+static uint32_t glue(compute_all_sbb, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2,
                                          DATA_TYPE src3)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
     DATA_TYPE src1 = dst + src2 + src3;
 
     cf = (src3 ? src1 <= src2 : src1 < src2);
@@ -123,9 +123,9 @@ static int glue(compute_c_sbb, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2,
     return (src3 ? src1 <= src2 : src1 < src2);
 }
 
-static int glue(compute_all_logic, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static uint32_t glue(compute_all_logic, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
 
     cf = 0;
     pf = parity_table[(uint8_t)dst];
@@ -136,9 +136,9 @@ static int glue(compute_all_logic, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     return cf | pf | af | zf | sf | of;
 }
 
-static int glue(compute_all_inc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static uint32_t glue(compute_all_inc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
     DATA_TYPE src2;
 
     cf = src1;
@@ -152,9 +152,9 @@ static int glue(compute_all_inc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     return cf | pf | af | zf | sf | of;
 }
 
-static int glue(compute_all_dec, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static uint32_t glue(compute_all_dec, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
     DATA_TYPE src2;
 
     cf = src1;
@@ -168,9 +168,9 @@ static int glue(compute_all_dec, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     return cf | pf | af | zf | sf | of;
 }
 
-static int glue(compute_all_shl, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static uint32_t glue(compute_all_shl, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
 
     cf = (src1 >> (DATA_BITS - 1)) & CC_C;
     pf = parity_table[(uint8_t)dst];
@@ -187,9 +187,9 @@ static int glue(compute_c_shl, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     return (src1 >> (DATA_BITS - 1)) & CC_C;
 }
 
-static int glue(compute_all_sar, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static uint32_t glue(compute_all_sar, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
 
     cf = src1 & 1;
     pf = parity_table[(uint8_t)dst];
@@ -204,9 +204,9 @@ static int glue(compute_all_sar, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 /* NOTE: we compute the flags like the P4. On olders CPUs, only OF and
    CF are modified and it is slower to do that.  Note as well that we
    don't truncate SRC1 for computing carry to DATA_TYPE.  */
-static int glue(compute_all_mul, SUFFIX)(DATA_TYPE dst, target_long src1)
+static uint32_t glue(compute_all_mul, SUFFIX)(DATA_TYPE dst, target_long src1)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
 
     cf = (src1 != 0);
     pf = parity_table[(uint8_t)dst];
@@ -217,9 +217,9 @@ static int glue(compute_all_mul, SUFFIX)(DATA_TYPE dst, target_long src1)
     return cf | pf | af | zf | sf | of;
 }
 
-static int glue(compute_all_bmilg, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static uint32_t glue(compute_all_bmilg, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
 
     cf = (src1 == 0);
     pf = 0; /* undefined */
@@ -237,7 +237,7 @@ static int glue(compute_c_bmilg, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 
 static int glue(compute_all_blsi, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
 
     cf = (src1 != 0);
     pf = 0; /* undefined */
-- 
2.47.0


