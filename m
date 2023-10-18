Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D1F7CEADC
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:00:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEVb-0001rW-Ck; Wed, 18 Oct 2023 17:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVX-0001em-83
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:15 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVU-0004zV-F7
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:14 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-581ed744114so871278eaf.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697666110; x=1698270910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJFEdGs915wcYeWHi0GO48pw7TVo3wCe1dYizr8poqU=;
 b=bQtp6aaW2pSIEXt6w4aLFoe1VHxmFnG/ntKNtKpL+z3cTn2bP/R/YdSb/xLqldXFMy
 zbjSH0lsk79vWEpc7NMOC/wnnRVgFpciwE/YYM41V0tNm8PHASkW4cdHaxFfMlVtADRm
 e2nAj9CDfIKvI8FFGUkqlrKPJkDb4GE3VNRabd4AUewJ25P0OqItF0BlV1Dkrkt9Iisg
 v11CSPj0UJ/lLLs1BRp/j5+SXxdVhU9g2Xu0vUPhwRRzMGOF2u7OGjlztJchCTWMi8RN
 82q+QwOzTfAUANdu6IALnPbwCC80II8bA4h3fdnCW8/XY/P7lVa+CwTqy/Rn201gvrR0
 8uNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697666110; x=1698270910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJFEdGs915wcYeWHi0GO48pw7TVo3wCe1dYizr8poqU=;
 b=sC1uZNX6uJ9043bryJylw6TURkR4+Fu/fvjtnfhM6xCGgcdTdEfWs+2EYPVab7NOF4
 qA1pGpe8DcomgLDdDSKceJ2eZd9ib/KoYsZRTuJ47M8Z5sfK0ygkZOh5/+/IiN1sYONC
 Pjh09mn3I9urJO1H0M6H2nmNgvKlV9g+GXFOE5/rVl0B+63/eqq/Aa4FLxXReon/XlBM
 a7prcmucepkqcyuxieMdYkYxE64YSLUpPxGdHbGDmFcd5Q2q0/GDawZbZD/X2aSucmEN
 ld3gmzTkiD5vt5p0pscvHjDIXzEZ2LmRNkLnEwWiK46ZzvkkfRLJMmTzau+hRtmeZWc4
 qwDA==
X-Gm-Message-State: AOJu0YzxFuhK1+TNcswpjwxFkmtPHO4+t8VHZHDCE8CU4BhLCqBoFibU
 tJsuxBTCZzICtAc5m4VScYcnBRpvw8oCCBQffgE=
X-Google-Smtp-Source: AGHT+IEgol9VhJo1UD/fmcW523Ie9KEZIGylPbGniYxORCqP5K91Cx2rnpFRb4I+XpUBZ334eN0vOA==
X-Received: by 2002:a05:6358:78d:b0:14b:7ee9:fece with SMTP id
 n13-20020a056358078d00b0014b7ee9fecemr327171rwj.7.1697666109977; 
 Wed, 18 Oct 2023 14:55:09 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r15-20020aa7962f000000b006889348ba6esm3796263pfg.127.2023.10.18.14.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:55:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 40/61] target/hppa: Implement DEPD, DEPDI
Date: Wed, 18 Oct 2023 14:51:14 -0700
Message-Id: <20231018215135.1561375-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/insns.decode | 19 ++++++++--
 target/hppa/translate.c  | 80 +++++++++++++++++++++++++++-------------
 2 files changed, 69 insertions(+), 30 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 33eec3f4c3..12684b590e 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -46,6 +46,10 @@
 
 %im5_0          0:s1 1:4
 %im5_16         16:s1 17:4
+%len5           0:5      !function=assemble_6
+%len6_8         8:1 0:5  !function=assemble_6
+%len6_12        12:1 0:5 !function=assemble_6
+%cpos6_11       11:1 5:5
 %ma_to_m        5:1 13:1 !function=ma_to_m
 %ma2_to_m       2:2      !function=ma_to_m
 %pos_to_m       0:1      !function=pos_to_m
@@ -334,10 +338,17 @@ shrpw_imm       110100 r2:5 r1:5 c:3 01 0    cpos:5 t:5
 extrw_sar       110100 r:5  t:5  c:3 10 se:1 00000  clen:5
 extrw_imm       110100 r:5  t:5  c:3 11 se:1 pos:5  clen:5
 
-depw_sar        110101 t:5 r:5   c:3 00 nz:1 00000  clen:5
-depw_imm        110101 t:5 r:5   c:3 01 nz:1 cpos:5 clen:5
-depwi_sar       110101 t:5 ..... c:3 10 nz:1 00000  clen:5      i=%im5_16
-depwi_imm       110101 t:5 ..... c:3 11 nz:1 cpos:5 clen:5      i=%im5_16
+dep_sar         110101 t:5 r:5   c:3 00 nz:1 00 000 .....     d=0 len=%len5
+dep_sar         110101 t:5 r:5   c:3 00 nz:1 1. 000 .....     d=1 len=%len6_8
+dep_imm         110101 t:5 r:5   c:3 01 nz:1 cpos:5 .....     d=0 len=%len5
+dep_imm         111100 t:5 r:5   c:3 .. nz:1 ..... .....      \
+                d=1 len=%len6_12 cpos=%cpos6_11
+depi_sar        110101 t:5 ..... c:3 10 nz:1 d:1 . 000 .....  \
+                i=%im5_16 len=%len6_8
+depi_imm        110101 t:5 ..... c:3 11 nz:1 cpos:5 .....     \
+                d=0 i=%im5_16 len=%len5
+depi_imm        111101 t:5 ..... c:3 .. nz:1 ..... .....      \
+                d=1 i=%im5_16 len=%len6_12 cpos=%cpos6_11
 
 ####
 # Branch External
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 308b8dd263..b3d3506f94 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -329,6 +329,17 @@ static int expand_shl11(DisasContext *ctx, int val)
     return val << 11;
 }
 
+static int assemble_6(DisasContext *ctx, int val)
+{
+    /*
+     * Officially, 32 * x + 32 - y.
+     * Here, x is already in bit 5, and y is [4:0].
+     * Since -y = ~y + 1, in 5 bits 32 - y => y ^ 31 + 1,
+     * with the overflow from bit 4 summing with x.
+     */
+    return (val ^ 31) + 1;
+}
+
 /* Translate CMPI doubleword conditions to standard. */
 static int cmpbid_c(DisasContext *ctx, int val)
 {
@@ -3383,17 +3394,23 @@ static bool trans_extrw_imm(DisasContext *ctx, arg_extrw_imm *a)
     return nullify_end(ctx);
 }
 
-static bool trans_depwi_imm(DisasContext *ctx, arg_depwi_imm *a)
+static bool trans_depi_imm(DisasContext *ctx, arg_depi_imm *a)
 {
-    unsigned len = 32 - a->clen;
+    unsigned len, width;
     target_sreg mask0, mask1;
     TCGv_reg dest;
 
+    if (!ctx->is_pa20 && a->d) {
+        return false;
+    }
     if (a->c) {
         nullify_over(ctx);
     }
-    if (a->cpos + len > 32) {
-        len = 32 - a->cpos;
+
+    len = a->len;
+    width = a->d ? 64 : 32;
+    if (a->cpos + len > width) {
+        len = width - a->cpos;
     }
 
     dest = dest_gpr(ctx, a->t);
@@ -3402,11 +3419,8 @@ static bool trans_depwi_imm(DisasContext *ctx, arg_depwi_imm *a)
 
     if (a->nz) {
         TCGv_reg src = load_gpr(ctx, a->t);
-        if (mask1 != -1) {
-            tcg_gen_andi_reg(dest, src, mask1);
-            src = dest;
-        }
-        tcg_gen_ori_reg(dest, src, mask0);
+        tcg_gen_andi_reg(dest, src, mask1);
+        tcg_gen_ori_reg(dest, dest, mask0);
     } else {
         tcg_gen_movi_reg(dest, mask0);
     }
@@ -3415,22 +3429,28 @@ static bool trans_depwi_imm(DisasContext *ctx, arg_depwi_imm *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, false, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
     }
     return nullify_end(ctx);
 }
 
-static bool trans_depw_imm(DisasContext *ctx, arg_depw_imm *a)
+static bool trans_dep_imm(DisasContext *ctx, arg_dep_imm *a)
 {
     unsigned rs = a->nz ? a->t : 0;
-    unsigned len = 32 - a->clen;
+    unsigned len, width;
     TCGv_reg dest, val;
 
+    if (!ctx->is_pa20 && a->d) {
+        return false;
+    }
     if (a->c) {
         nullify_over(ctx);
     }
-    if (a->cpos + len > 32) {
-        len = 32 - a->cpos;
+
+    len = a->len;
+    width = a->d ? 64 : 32;
+    if (a->cpos + len > width) {
+        len = width - a->cpos;
     }
 
     dest = dest_gpr(ctx, a->t);
@@ -3445,26 +3465,26 @@ static bool trans_depw_imm(DisasContext *ctx, arg_depw_imm *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, false, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
     }
     return nullify_end(ctx);
 }
 
-static bool do_depw_sar(DisasContext *ctx, unsigned rt, unsigned c,
-                        unsigned nz, unsigned clen, TCGv_reg val)
+static bool do_dep_sar(DisasContext *ctx, unsigned rt, unsigned c,
+                       bool d, bool nz, unsigned len, TCGv_reg val)
 {
     unsigned rs = nz ? rt : 0;
-    unsigned len = 32 - clen;
+    unsigned widthm1 = d ? 63 : 31;
     TCGv_reg mask, tmp, shift, dest;
-    unsigned msb = 1U << (len - 1);
+    target_ureg msb = 1ULL << (len - 1);
 
     dest = dest_gpr(ctx, rt);
     shift = tcg_temp_new();
     tmp = tcg_temp_new();
 
     /* Convert big-endian bit numbering in SAR to left-shift.  */
-    tcg_gen_andi_reg(shift, cpu_sar, 31);
-    tcg_gen_xori_reg(shift, shift, 31);
+    tcg_gen_andi_reg(shift, cpu_sar, widthm1);
+    tcg_gen_xori_reg(shift, shift, widthm1);
 
     mask = tcg_temp_new();
     tcg_gen_movi_reg(mask, msb + (msb - 1));
@@ -3482,25 +3502,33 @@ static bool do_depw_sar(DisasContext *ctx, unsigned rt, unsigned c,
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (c) {
-        ctx->null_cond = do_sed_cond(ctx, c, false, dest);
+        ctx->null_cond = do_sed_cond(ctx, c, d, dest);
     }
     return nullify_end(ctx);
 }
 
-static bool trans_depw_sar(DisasContext *ctx, arg_depw_sar *a)
+static bool trans_dep_sar(DisasContext *ctx, arg_dep_sar *a)
 {
+    if (!ctx->is_pa20 && a->d) {
+        return false;
+    }
     if (a->c) {
         nullify_over(ctx);
     }
-    return do_depw_sar(ctx, a->t, a->c, a->nz, a->clen, load_gpr(ctx, a->r));
+    return do_dep_sar(ctx, a->t, a->c, a->d, a->nz, a->len,
+                      load_gpr(ctx, a->r));
 }
 
-static bool trans_depwi_sar(DisasContext *ctx, arg_depwi_sar *a)
+static bool trans_depi_sar(DisasContext *ctx, arg_depi_sar *a)
 {
+    if (!ctx->is_pa20 && a->d) {
+        return false;
+    }
     if (a->c) {
         nullify_over(ctx);
     }
-    return do_depw_sar(ctx, a->t, a->c, a->nz, a->clen, tcg_constant_reg(a->i));
+    return do_dep_sar(ctx, a->t, a->c, a->d, a->nz, a->len,
+                      tcg_constant_reg(a->i));
 }
 
 static bool trans_be(DisasContext *ctx, arg_be *a)
-- 
2.34.1


