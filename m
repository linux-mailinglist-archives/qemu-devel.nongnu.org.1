Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9661C7CBB8F
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:46:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdmV-0008S7-3q; Tue, 17 Oct 2023 02:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdld-0007tQ-9u
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:28 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlY-0001rg-8X
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:25 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c77449a6daso42939625ad.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697524879; x=1698129679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yad38dQouP6DqHdsCPOXEG2JDxb1v+Imde3CiLnCBP4=;
 b=CGGQu8YYpnpzkY4xJO9hMLm+ZVbXFlsQtBEDSxtR38KXHg27CQQlK0StXSCOXxffqG
 Hbt+NB4ca6e8lqk74VDGcrPNUBm2gQjcCUd20JbAupYtXzy44FQZpPV549Y+B1fYH5Yn
 +iyzyzVssavMcIh6lkBTBCoYzLGmp/WO5flpWmirbQG6imcnpl+WAERBvWoDiTvMIsFK
 KcLemP3RjXsRPOUVxkzmV77j6tmRj4jGaa5egdQxldRsct5N3McB8vc6qqTGsQ2IpXqt
 ebqGxE64Tf+EC8/rbLZijUv+XExF2h1doR0Y1qNmazPn/9YI4eyuR9jbWLR4HiX++4yr
 1w8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697524879; x=1698129679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yad38dQouP6DqHdsCPOXEG2JDxb1v+Imde3CiLnCBP4=;
 b=vxYWtuvnkvg7l+hHcoECApTzPyqJIQ0R7PDLzjfIHJMV8fSH8jj6KB/1g8VRQePPdr
 GkS3fef6pCNKdSb2ekU7ehMvs07/jgSdViW9uGwmMtGDDLOT+cYDBM7nr1zon0mlDC0z
 JOOsZTZviHvaZaAC25Hq6jaLSEKVb2DyQjXnJhEN7MeyiSnV8gN61X2RHFGh/nFM41oY
 ZAhegvk5i44Xh6QGLxnuDRKXkvUq1CvyXjLmDjtdLMIQSiAICuysiW+NUxnIj0bFLFk1
 JnglCbZHNk/0YtiNdiu/EuM++44hhZaDk29bHY9AkUIzPOYKWgSPLNG1XCYIkgF+DL+/
 8B6Q==
X-Gm-Message-State: AOJu0YzKJ9wdjX9p5wDmww1XEHg283SPMtZxE3MngqevKad/uN+GH4mi
 Ma4RUsnPU/l6kQIf8FKDHIM7I9hM7QocRjMl8pE=
X-Google-Smtp-Source: AGHT+IHBc7gZUZRT3vGiaIFf8gNaY9N2PkyxsKfVVVRhSC+RczhSin5X4ZLp+1+HlJv4pEthrZbN7g==
X-Received: by 2002:a17:902:d38d:b0:1c5:f0fd:51be with SMTP id
 e13-20020a170902d38d00b001c5f0fd51bemr1526928pld.69.1697524878790; 
 Mon, 16 Oct 2023 23:41:18 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 x18-20020a17090300d200b001b891259eddsm685682plc.197.2023.10.16.23.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:41:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 11/20] target/sparc: Always copy conditions into a new
 temporary
Date: Mon, 16 Oct 2023 23:41:00 -0700
Message-Id: <20231017064109.681935-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017064109.681935-1-richard.henderson@linaro.org>
References: <20231017064109.681935-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This will allow the condition to live across changes to
the global cc variables.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 32d29f16b5..a75f75dfb9 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -977,7 +977,7 @@ static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
 {
     TCGv t1, t2, zero;
 
-    cmp->c1 = NULL;
+    cmp->c1 = t1 = tcg_temp_new();
     cmp->c2 = 0;
 
     switch (cond & 7) {
@@ -989,16 +989,14 @@ static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
     case 0x1: /* eq */
         cmp->cond = TCG_COND_EQ;
         if (TARGET_LONG_BITS == 32 || xcc) {
-            cmp->c1 = cpu_cc_Z;
+            tcg_gen_mov_tl(t1, cpu_cc_Z);
         } else {
-            cmp->c1 = t1 = tcg_temp_new();
             tcg_gen_ext32u_tl(t1, cpu_icc_Z);
         }
         break;
 
     case 0x2: /* le: Z | (N ^ V) */
         cmp->cond = TCG_COND_LT;
-        cmp->c1 = t1 = tcg_temp_new();
         zero = tcg_constant_tl(0);
         if (TARGET_LONG_BITS == 32 || xcc) {
             tcg_gen_negsetcond_tl(TCG_COND_EQ, t1, cpu_cc_Z, zero);
@@ -1016,7 +1014,6 @@ static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
 
     case 0x3: /* lt: N ^ V */
         cmp->cond = TCG_COND_LT;
-        cmp->c1 = t1 = tcg_temp_new();
         tcg_gen_xor_tl(t1, cpu_cc_N, cpu_cc_V);
         if (TARGET_LONG_BITS == 64 && !xcc) {
             tcg_gen_ext32s_tl(t1, t1);
@@ -1025,7 +1022,6 @@ static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
 
     case 0x4: /* leu: C | Z -> !(!C & !Z) */
         cmp->cond = TCG_COND_EQ;
-        cmp->c1 = t1 = tcg_temp_new();
         if (TARGET_LONG_BITS == 32 || xcc) {
             tcg_gen_subi_tl(t1, cpu_cc_C, 1);
             tcg_gen_and_tl(t1, t1, cpu_cc_Z);
@@ -1041,9 +1037,8 @@ static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
     case 0x5: /* ltu: C */
         cmp->cond = TCG_COND_NE;
         if (TARGET_LONG_BITS == 32 || xcc) {
-            cmp->c1 = cpu_cc_C;
+            tcg_gen_mov_tl(t1, cpu_cc_C);
         } else {
-            cmp->c1 = t1 = tcg_temp_new();
             tcg_gen_extract_tl(t1, cpu_icc_C, 32, 1);
         }
         break;
@@ -1051,9 +1046,8 @@ static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
     case 0x6: /* neg: N */
         cmp->cond = TCG_COND_LT;
         if (TARGET_LONG_BITS == 32 || xcc) {
-            cmp->c1 = cpu_cc_N;
+            tcg_gen_mov_tl(t1, cpu_cc_N);
         } else {
-            cmp->c1 = t1 = tcg_temp_new();
             tcg_gen_ext32s_tl(t1, cpu_cc_N);
         }
         break;
@@ -1061,9 +1055,8 @@ static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
     case 0x7: /* vs: V */
         cmp->cond = TCG_COND_LT;
         if (TARGET_LONG_BITS == 32 || xcc) {
-            cmp->c1 = cpu_cc_V;
+            tcg_gen_mov_tl(t1, cpu_cc_V);
         } else {
-            cmp->c1 = t1 = tcg_temp_new();
             tcg_gen_ext32s_tl(t1, cpu_cc_V);
         }
         break;
@@ -1166,8 +1159,9 @@ static const TCGCond gen_tcg_cond_reg[8] = {
 static void gen_compare_reg(DisasCompare *cmp, int cond, TCGv r_src)
 {
     cmp->cond = tcg_invert_cond(gen_tcg_cond_reg[cond]);
-    cmp->c1 = r_src;
+    cmp->c1 = tcg_temp_new();
     cmp->c2 = 0;
+    tcg_gen_mov_tl(cmp->c1, r_src);
 }
 
 static void gen_op_clear_ieee_excp_and_FTT(void)
-- 
2.34.1


