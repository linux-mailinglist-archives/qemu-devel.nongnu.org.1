Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF5E7E33FB
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:14:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CPL-0000FP-RJ; Mon, 06 Nov 2023 22:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COZ-0007B5-Gc
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:52 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COL-0000h5-6S
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:51 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6b497c8575aso5525280b3a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326271; x=1699931071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GfDw/bslcTiKaSPMMxqGxyDHw7Pd9QUFMroBjWabI5A=;
 b=sGm2/B0lv/rgfXXw7ok1eYRy7c1/1QNeWbKRTe5xRaqVzUaMqnL1bHB5vwvomz3Rqq
 KhVl2YicLWYBy+vEvA7EsaogexjFYNJslMuhQXupNr9DwaxWKvggeOXo2CjwBcl4SVYF
 XBqaECrlHeQTzoNd495MXWndlWh0COlczonTH/0z/kZzVnj3bNOLJM5G2VAF8uv0tZfe
 RSu8Pfv9W5v9glHgXciomA4HHH0DfdPPa/H9I2bopPEu2LrhuPqwtNGGiDN5VWDXy5Q7
 H13iFY4sTB9isJq0spwTUFfBx/YZjTSIzcTTSWZEZb2boOUC++z8sK+aAAfWNiyTxwj8
 UElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326271; x=1699931071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GfDw/bslcTiKaSPMMxqGxyDHw7Pd9QUFMroBjWabI5A=;
 b=uQmpziT7DpZnnjKPIYU7yjusipVNCCLaeom8OJU6owT95sa3Qwos7EqRQeR9ZZHG3/
 5fpOLPMztUWnrLEPWejRlhfY5526wU1F7BsBDjYTW03JyG1ZBioJKLOTQgxlUweiS0XK
 DTvc8Ed2lAIK8thgnPNPp28+k0cPyGLkyenbbDchXb2ceLvhr0bcTBPkzZnVH0Zp/O0o
 w3fnnFDCobhFhoNaC0E5KkA+jEyszOmPauUkZs6e8TlcK0aqPpwA1dwQqhk10em1uGCZ
 1ZkvgmyD9k/ublRQPDgJDmMYvAcJhgA/z2KfCOuNHx/m2t1x0GnGatJwNZieaSdvWFAD
 J3og==
X-Gm-Message-State: AOJu0YxUxEColXkQGvoo1O8wW3wesXxcSg7g9P1BQu/e9vVd2Bc6CEp6
 82VnDKnc0nufTSDhGdbdO5gy+ncylOh+TE0967U=
X-Google-Smtp-Source: AGHT+IHuGWU5GJT3J9pG0bxxasbM/3+UX03ozIeoItE28nLm0Rdvot+mb87ZFP/bRIYwejr/sBobJg==
X-Received: by 2002:a05:6a21:a597:b0:161:76a4:4f74 with SMTP id
 gd23-20020a056a21a59700b0016176a44f74mr43068656pzc.1.1699326271189; 
 Mon, 06 Nov 2023 19:04:31 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/85] target/hppa: Pass d to do_cond
Date: Mon,  6 Nov 2023 19:03:12 -0800
Message-Id: <20231107030407.8979-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Hoist the resolution of d up one level above do_cond.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 82 +++++++++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 28 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 1694b988ae..7b0e48c42b 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -827,7 +827,7 @@ static bool cond_need_cb(int c)
 /* Need extensions from TCGv_i32 to TCGv_reg. */
 static bool cond_need_ext(DisasContext *ctx, bool d)
 {
-    return TARGET_REGISTER_BITS == 64 && !d;
+    return TARGET_REGISTER_BITS == 64 && !(ctx->is_pa20 && d);
 }
 
 /*
@@ -835,8 +835,8 @@ static bool cond_need_ext(DisasContext *ctx, bool d)
  * the Parisc 1.1 Architecture Reference Manual for details.
  */
 
-static DisasCond do_cond(unsigned cf, TCGv_reg res,
-                         TCGv_reg cb_msb, TCGv_reg sv)
+static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
+                         TCGv_reg res, TCGv_reg cb_msb, TCGv_reg sv)
 {
     DisasCond cond;
     TCGv_reg tmp;
@@ -846,11 +846,19 @@ static DisasCond do_cond(unsigned cf, TCGv_reg res,
         cond = cond_make_f();
         break;
     case 1: /* = / <>        (Z / !Z) */
+        if (cond_need_ext(ctx, d)) {
+            tmp = tcg_temp_new();
+            tcg_gen_ext32u_reg(tmp, res);
+            res = tmp;
+        }
         cond = cond_make_0(TCG_COND_EQ, res);
         break;
     case 2: /* < / >=        (N ^ V / !(N ^ V) */
         tmp = tcg_temp_new();
         tcg_gen_xor_reg(tmp, res, sv);
+        if (cond_need_ext(ctx, d)) {
+            tcg_gen_ext32s_reg(tmp, tmp);
+        }
         cond = cond_make_0_tmp(TCG_COND_LT, tmp);
         break;
     case 3: /* <= / >        (N ^ V) | Z / !((N ^ V) | Z) */
@@ -865,20 +873,35 @@ static DisasCond do_cond(unsigned cf, TCGv_reg res,
          */
         tmp = tcg_temp_new();
         tcg_gen_eqv_reg(tmp, res, sv);
-        tcg_gen_sari_reg(tmp, tmp, TARGET_REGISTER_BITS - 1);
-        tcg_gen_and_reg(tmp, tmp, res);
+        if (cond_need_ext(ctx, d)) {
+            tcg_gen_sextract_reg(tmp, tmp, 31, 1);
+            tcg_gen_and_reg(tmp, tmp, res);
+            tcg_gen_ext32u_reg(tmp, tmp);
+        } else {
+            tcg_gen_sari_reg(tmp, tmp, TARGET_REGISTER_BITS - 1);
+            tcg_gen_and_reg(tmp, tmp, res);
+        }
         cond = cond_make_0_tmp(TCG_COND_EQ, tmp);
         break;
     case 4: /* NUV / UV      (!C / C) */
+        /* Only bit 0 of cb_msb is ever set. */
         cond = cond_make_0(TCG_COND_EQ, cb_msb);
         break;
     case 5: /* ZNV / VNZ     (!C | Z / C & !Z) */
         tmp = tcg_temp_new();
         tcg_gen_neg_reg(tmp, cb_msb);
         tcg_gen_and_reg(tmp, tmp, res);
+        if (cond_need_ext(ctx, d)) {
+            tcg_gen_ext32u_reg(tmp, tmp);
+        }
         cond = cond_make_0_tmp(TCG_COND_EQ, tmp);
         break;
     case 6: /* SV / NSV      (V / !V) */
+        if (cond_need_ext(ctx, d)) {
+            tmp = tcg_temp_new();
+            tcg_gen_ext32s_reg(tmp, sv);
+            sv = tmp;
+        }
         cond = cond_make_0(TCG_COND_LT, sv);
         break;
     case 7: /* OD / EV */
@@ -900,10 +923,11 @@ static DisasCond do_cond(unsigned cf, TCGv_reg res,
    can use the inputs directly.  This can allow other computation to be
    deleted as unused.  */
 
-static DisasCond do_sub_cond(unsigned cf, TCGv_reg res,
+static DisasCond do_sub_cond(DisasContext *ctx, unsigned cf, TCGv_reg res,
                              TCGv_reg in1, TCGv_reg in2, TCGv_reg sv)
 {
     DisasCond cond;
+    bool d = false;
 
     switch (cf >> 1) {
     case 1: /* = / <> */
@@ -922,7 +946,7 @@ static DisasCond do_sub_cond(unsigned cf, TCGv_reg res,
         cond = cond_make(TCG_COND_LEU, in1, in2);
         break;
     default:
-        return do_cond(cf, res, NULL, sv);
+        return do_cond(ctx, cf, d, res, NULL, sv);
     }
     if (cf & 1) {
         cond.c = tcg_invert_cond(cond.c);
@@ -940,8 +964,10 @@ static DisasCond do_sub_cond(unsigned cf, TCGv_reg res,
  * how cases c={2,3} are treated.
  */
 
-static DisasCond do_log_cond(unsigned cf, TCGv_reg res)
+static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, TCGv_reg res)
 {
+    bool d = false;
+
     switch (cf) {
     case 0:  /* never */
     case 9:  /* undef, C */
@@ -970,7 +996,7 @@ static DisasCond do_log_cond(unsigned cf, TCGv_reg res)
 
     case 14: /* OD */
     case 15: /* EV */
-        return do_cond(cf, res, NULL, NULL);
+        return do_cond(ctx, cf, d, res, NULL, NULL);
 
     default:
         g_assert_not_reached();
@@ -979,7 +1005,7 @@ static DisasCond do_log_cond(unsigned cf, TCGv_reg res)
 
 /* Similar, but for shift/extract/deposit conditions.  */
 
-static DisasCond do_sed_cond(unsigned orig, TCGv_reg res)
+static DisasCond do_sed_cond(DisasContext *ctx, unsigned orig, TCGv_reg res)
 {
     unsigned c, f;
 
@@ -992,7 +1018,7 @@ static DisasCond do_sed_cond(unsigned orig, TCGv_reg res)
     }
     f = (orig & 4) / 4;
 
-    return do_log_cond(c * 2 + f, res);
+    return do_log_cond(ctx, c * 2 + f, res);
 }
 
 /* Similar, but for unit conditions.  */
@@ -1164,7 +1190,7 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     }
 
     /* Emit any conditional trap before any writeback.  */
-    cond = do_cond(cf, dest, cb_cond, sv);
+    cond = do_cond(ctx, cf, d, dest, cb_cond, sv);
     if (is_tc) {
         tmp = tcg_temp_new();
         tcg_gen_setcond_reg(cond.c, tmp, cond.a0, cond.a1);
@@ -1254,9 +1280,9 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
 
     /* Compute the condition.  We cannot use the special case for borrow.  */
     if (!is_b) {
-        cond = do_sub_cond(cf, dest, in1, in2, sv);
+        cond = do_sub_cond(ctx, cf, dest, in1, in2, sv);
     } else {
-        cond = do_cond(cf, dest, get_carry(ctx, d, cb, cb_msb), sv);
+        cond = do_cond(ctx, cf, d, dest, get_carry(ctx, d, cb, cb_msb), sv);
     }
 
     /* Emit any conditional trap before any writeback.  */
@@ -1319,7 +1345,7 @@ static void do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     }
 
     /* Form the condition for the compare.  */
-    cond = do_sub_cond(cf, dest, in1, in2, sv);
+    cond = do_sub_cond(ctx, cf, dest, in1, in2, sv);
 
     /* Clear.  */
     tcg_gen_movi_reg(dest, 0);
@@ -1343,7 +1369,7 @@ static void do_log(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (cf) {
-        ctx->null_cond = do_log_cond(cf, dest);
+        ctx->null_cond = do_log_cond(ctx, cf, dest);
     }
 }
 
@@ -2817,7 +2843,7 @@ static bool trans_ds(DisasContext *ctx, arg_rrr_cf *a)
             /* ??? The lshift is supposed to contribute to overflow.  */
             sv = do_add_sv(ctx, dest, add1, add2);
         }
-        ctx->null_cond = do_cond(a->cf, dest, cout, sv);
+        ctx->null_cond = do_cond(ctx, a->cf, false, dest, cout, sv);
     }
 
     return nullify_end(ctx);
@@ -3034,7 +3060,7 @@ static bool do_cmpb(DisasContext *ctx, unsigned r, TCGv_reg in1,
         sv = do_sub_sv(ctx, dest, in1, in2);
     }
 
-    cond = do_sub_cond(c * 2 + f, dest, in1, in2, sv);
+    cond = do_sub_cond(ctx, c * 2 + f, dest, in1, in2, sv);
     return do_cbranch(ctx, disp, n, &cond);
 }
 
@@ -3078,7 +3104,7 @@ static bool do_addb(DisasContext *ctx, unsigned r, TCGv_reg in1,
         sv = do_add_sv(ctx, dest, in1, in2);
     }
 
-    cond = do_cond(c * 2 + f, dest, cb_cond, sv);
+    cond = do_cond(ctx, c * 2 + f, d, dest, cb_cond, sv);
     save_gpr(ctx, r, dest);
     return do_cbranch(ctx, disp, n, &cond);
 }
@@ -3149,7 +3175,7 @@ static bool trans_movb(DisasContext *ctx, arg_movb *a)
         tcg_gen_mov_reg(dest, cpu_gr[a->r1]);
     }
 
-    cond = do_sed_cond(a->c, dest);
+    cond = do_sed_cond(ctx, a->c, dest);
     return do_cbranch(ctx, a->disp, a->n, &cond);
 }
 
@@ -3163,7 +3189,7 @@ static bool trans_movbi(DisasContext *ctx, arg_movbi *a)
     dest = dest_gpr(ctx, a->r);
     tcg_gen_movi_reg(dest, a->i);
 
-    cond = do_sed_cond(a->c, dest);
+    cond = do_sed_cond(ctx, a->c, dest);
     return do_cbranch(ctx, a->disp, a->n, &cond);
 }
 
@@ -3201,7 +3227,7 @@ static bool trans_shrpw_sar(DisasContext *ctx, arg_shrpw_sar *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(a->c, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, dest);
     }
     return nullify_end(ctx);
 }
@@ -3237,7 +3263,7 @@ static bool trans_shrpw_imm(DisasContext *ctx, arg_shrpw_imm *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(a->c, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, dest);
     }
     return nullify_end(ctx);
 }
@@ -3271,7 +3297,7 @@ static bool trans_extrw_sar(DisasContext *ctx, arg_extrw_sar *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(a->c, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, dest);
     }
     return nullify_end(ctx);
 }
@@ -3298,7 +3324,7 @@ static bool trans_extrw_imm(DisasContext *ctx, arg_extrw_imm *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(a->c, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, dest);
     }
     return nullify_end(ctx);
 }
@@ -3335,7 +3361,7 @@ static bool trans_depwi_imm(DisasContext *ctx, arg_depwi_imm *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(a->c, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, dest);
     }
     return nullify_end(ctx);
 }
@@ -3365,7 +3391,7 @@ static bool trans_depw_imm(DisasContext *ctx, arg_depw_imm *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(a->c, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, dest);
     }
     return nullify_end(ctx);
 }
@@ -3402,7 +3428,7 @@ static bool do_depw_sar(DisasContext *ctx, unsigned rt, unsigned c,
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (c) {
-        ctx->null_cond = do_sed_cond(c, dest);
+        ctx->null_cond = do_sed_cond(ctx, c, dest);
     }
     return nullify_end(ctx);
 }
-- 
2.34.1


