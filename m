Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4347E3427
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:18:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRV-0004IO-2F; Mon, 06 Nov 2023 22:07:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRQ-000498-4U
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:07:48 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRO-0001NM-1z
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:07:47 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cc7077d34aso39025425ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326465; x=1699931265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wtKfWdXFSNlzbjUD16+VR+PXfcJkhL8owsB0fGI5Ev0=;
 b=wRsEaBU68jSQxnEQGodoVNK/FPcv8tBzl+L3GPq9hmi62BC5aOI7TlLm+843XQhGs8
 CFG1/OEw3oodElxsaiF/0KZP380r3DH8rqhcGeU7zIENXS2Q+/Nh0a+GsW/Vdgk44YBQ
 +QU+VXUQEF9UlW3Qc7vi3JKpuUhLHGNIgl3TiEVrfR/LaTRFsqrjIwhEEHDU7oySiuYN
 UD9lKUVBQmVrdyq5XlysEqzK/6PvKVqhOU170JhU/qYNhj6p41BCkhVBpSq4VzQAjU7E
 B/ydg7pcq0RAkA9t9IRbRvR2kN5itv9Lr+P49kCNp2tyV7ggbuXAYx4SXR9lprib6EMe
 dDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326465; x=1699931265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wtKfWdXFSNlzbjUD16+VR+PXfcJkhL8owsB0fGI5Ev0=;
 b=UokDG24x79rzAqRg82EBKRzb9qC1+iRQ5OXUXQx5/WA285jkUmunuaiFLQxrJ6+Yl7
 b6ijUjmVX17yjdfdEZeFPqfUc6oW7XXR36ixwhXO/Q/hp6uU0t13bAVoRuLupcQR8POt
 7akMrA6ptvHVWl90efwtw8wHPNagmP5t5BFBhht2sulDfPKXBmRePR7A2C889V5y3Ix3
 Tsi1tLENuciuxd5DETABCK598p+/KKFLPhlY6/0iyaJJMjVHfqgxIl9A01cstYpKOIw3
 QoNsglsShijYnCiFJQtUrgKzrypr4nMadK0ZCr5DHCIK6xJ4kvWaNxKEG0aiaN2bqvic
 lH5w==
X-Gm-Message-State: AOJu0Ywzqfy+km0nfWL3w1EaQregB99ajCjJBFMJvTFcH0Va579Nsnl5
 gvmCXIjHboGRveA08DeQtLjgp2ytkxUS7tmMMqc=
X-Google-Smtp-Source: AGHT+IHRprWOuccsiYQJdULbH8kBZZltUVofr3SNl1ZCJZurU4LqRNpP9yLWjs2p3p4WyzasRsxGRg==
X-Received: by 2002:a17:90a:1d5:b0:280:53b2:4b9b with SMTP id
 21-20020a17090a01d500b0028053b24b9bmr19348458pjd.15.1699326464611; 
 Mon, 06 Nov 2023 19:07:44 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.07.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:07:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/85] target/hppa: Implement DEPD, DEPDI
Date: Mon,  6 Nov 2023 19:03:30 -0800
Message-Id: <20231107030407.8979-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
index 4562f865f4..ea2150cc55 100644
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
@@ -3404,17 +3415,23 @@ static bool trans_extrw_imm(DisasContext *ctx, arg_extrw_imm *a)
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
@@ -3423,11 +3440,8 @@ static bool trans_depwi_imm(DisasContext *ctx, arg_depwi_imm *a)
 
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
@@ -3436,22 +3450,28 @@ static bool trans_depwi_imm(DisasContext *ctx, arg_depwi_imm *a)
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
@@ -3466,26 +3486,26 @@ static bool trans_depw_imm(DisasContext *ctx, arg_depw_imm *a)
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
@@ -3503,25 +3523,33 @@ static bool do_depw_sar(DisasContext *ctx, unsigned rt, unsigned c,
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


