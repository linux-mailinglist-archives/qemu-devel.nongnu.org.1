Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A09B7CEAF5
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:06:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESj-0001n2-Fr; Wed, 18 Oct 2023 17:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESM-00018y-4E
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:59 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESK-0004R2-4M
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:57 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1e9c9d181d6so3933298fac.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665915; x=1698270715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=io7/0k/pOO+TKp7Ec9Fj4OHEiClXaVK9yG3Lda49zh8=;
 b=Zr2PzKBNK44CINttQlE5jN5RD74XF9JTJpe55i1/Af8yuM90jY570FLWFN2VOiH/wi
 CR/L0LyGcB7vposOfVTWh+c9lC3CIEha8ggO0t0ED20kBznrbk6RER4bWH4YqT73x4zS
 JAtoEu9zUGDZStxUDuaLi4MQA4bXrjLi6rSf38/XJ/Sfuo1MnK2w5PsbQeXbfk95MErR
 K+TfKnTqEVTjKd6cpGjHaA7xrgiKvfofoGZ3kIzFcafu0AD6srknCu5zjiYcPkkmsjNe
 e5lS1Jdl1/+vgppJSy4y9dj06JjUlV7ATONOjnCcdewHbLZaCqRU4n8BbrfwWvCnh2u5
 2YTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665915; x=1698270715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=io7/0k/pOO+TKp7Ec9Fj4OHEiClXaVK9yG3Lda49zh8=;
 b=uYo4up3ApLrtJwE6u9WqHqEp/XCGnUjPBdtmZWtCUIR8n3/oj1YISpMw/IO+HbHr6d
 7lsTHJTYZig+m/gRzRC8oPNJJx/W7oGrzP74CeFzWcgBpUVJrODHAA2OtVh8Gk6pt16D
 jl2ombI3uDi5wa1wnuUyLJI1zhMBZc7ouCBSkX7/JDdMSu/6S3y0T+HhltAWLK6qFFDg
 xFygFuVtzdK6TMl+HXBvGX1XW6JV20gLFAMcDgOKF599D7ZLsnBXRPc+/r5KlYgukoo2
 MI75AMn6A6NSzNbS2kZIl3CGKjn4bDTdcSwTXIPxUvBa7IBhws5rs3iiAdoXYeZZIAGA
 LogA==
X-Gm-Message-State: AOJu0YwnCYhDX+F/2oN2HoY2PHmtgZWhVDxMaWljmITy1lye1CUz5hlz
 05bK/5DNA17KXO3AM7jy8X6LBgrZvKmone+bbQM=
X-Google-Smtp-Source: AGHT+IEZ41v1fhC8JMM4JZ7zHR4YWf/tJNwSFXgmFDf+PNEJYCUcuwEG8VotdyY5VKvzP4xwyYe1iA==
X-Received: by 2002:a05:6871:6183:b0:1e9:a8ff:67e8 with SMTP id
 rb3-20020a056871618300b001e9a8ff67e8mr608688oab.50.1697665914999; 
 Wed, 18 Oct 2023 14:51:54 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:51:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 22/61] target/hppa: Pass d to do_cond
Date: Wed, 18 Oct 2023 14:50:56 -0700
Message-Id: <20231018215135.1561375-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

Hoist the resolution of d up one level above do_cond.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 82 +++++++++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 28 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index e2b692a6c5..d6edad9adb 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -814,7 +814,7 @@ static bool cond_need_cb(int c)
 /* Need extensions from TCGv_i32 to TCGv_reg. */
 static bool cond_need_ext(DisasContext *ctx, bool d)
 {
-    return TARGET_REGISTER_BITS == 64 && !d;
+    return TARGET_REGISTER_BITS == 64 && !(ctx->is_pa20 && d);
 }
 
 /*
@@ -822,8 +822,8 @@ static bool cond_need_ext(DisasContext *ctx, bool d)
  * the Parisc 1.1 Architecture Reference Manual for details.
  */
 
-static DisasCond do_cond(unsigned cf, TCGv_reg res,
-                         TCGv_reg cb_msb, TCGv_reg sv)
+static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
+                         TCGv_reg res, TCGv_reg cb_msb, TCGv_reg sv)
 {
     DisasCond cond;
     TCGv_reg tmp;
@@ -833,11 +833,19 @@ static DisasCond do_cond(unsigned cf, TCGv_reg res,
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
@@ -852,20 +860,35 @@ static DisasCond do_cond(unsigned cf, TCGv_reg res,
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
@@ -887,10 +910,11 @@ static DisasCond do_cond(unsigned cf, TCGv_reg res,
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
@@ -909,7 +933,7 @@ static DisasCond do_sub_cond(unsigned cf, TCGv_reg res,
         cond = cond_make(TCG_COND_LEU, in1, in2);
         break;
     default:
-        return do_cond(cf, res, NULL, sv);
+        return do_cond(ctx, cf, d, res, NULL, sv);
     }
     if (cf & 1) {
         cond.c = tcg_invert_cond(cond.c);
@@ -927,8 +951,10 @@ static DisasCond do_sub_cond(unsigned cf, TCGv_reg res,
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
@@ -957,7 +983,7 @@ static DisasCond do_log_cond(unsigned cf, TCGv_reg res)
 
     case 14: /* OD */
     case 15: /* EV */
-        return do_cond(cf, res, NULL, NULL);
+        return do_cond(ctx, cf, d, res, NULL, NULL);
 
     default:
         g_assert_not_reached();
@@ -966,7 +992,7 @@ static DisasCond do_log_cond(unsigned cf, TCGv_reg res)
 
 /* Similar, but for shift/extract/deposit conditions.  */
 
-static DisasCond do_sed_cond(unsigned orig, TCGv_reg res)
+static DisasCond do_sed_cond(DisasContext *ctx, unsigned orig, TCGv_reg res)
 {
     unsigned c, f;
 
@@ -979,7 +1005,7 @@ static DisasCond do_sed_cond(unsigned orig, TCGv_reg res)
     }
     f = (orig & 4) / 4;
 
-    return do_log_cond(c * 2 + f, res);
+    return do_log_cond(ctx, c * 2 + f, res);
 }
 
 /* Similar, but for unit conditions.  */
@@ -1151,7 +1177,7 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     }
 
     /* Emit any conditional trap before any writeback.  */
-    cond = do_cond(cf, dest, cb_cond, sv);
+    cond = do_cond(ctx, cf, d, dest, cb_cond, sv);
     if (is_tc) {
         tmp = tcg_temp_new();
         tcg_gen_setcond_reg(cond.c, tmp, cond.a0, cond.a1);
@@ -1241,9 +1267,9 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
 
     /* Compute the condition.  We cannot use the special case for borrow.  */
     if (!is_b) {
-        cond = do_sub_cond(cf, dest, in1, in2, sv);
+        cond = do_sub_cond(ctx, cf, dest, in1, in2, sv);
     } else {
-        cond = do_cond(cf, dest, get_carry(ctx, d, cb, cb_msb), sv);
+        cond = do_cond(ctx, cf, d, dest, get_carry(ctx, d, cb, cb_msb), sv);
     }
 
     /* Emit any conditional trap before any writeback.  */
@@ -1306,7 +1332,7 @@ static void do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     }
 
     /* Form the condition for the compare.  */
-    cond = do_sub_cond(cf, dest, in1, in2, sv);
+    cond = do_sub_cond(ctx, cf, dest, in1, in2, sv);
 
     /* Clear.  */
     tcg_gen_movi_reg(dest, 0);
@@ -1330,7 +1356,7 @@ static void do_log(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (cf) {
-        ctx->null_cond = do_log_cond(cf, dest);
+        ctx->null_cond = do_log_cond(ctx, cf, dest);
     }
 }
 
@@ -2796,7 +2822,7 @@ static bool trans_ds(DisasContext *ctx, arg_rrr_cf *a)
             /* ??? The lshift is supposed to contribute to overflow.  */
             sv = do_add_sv(ctx, dest, add1, add2);
         }
-        ctx->null_cond = do_cond(a->cf, dest, cout, sv);
+        ctx->null_cond = do_cond(ctx, a->cf, false, dest, cout, sv);
     }
 
     return nullify_end(ctx);
@@ -3013,7 +3039,7 @@ static bool do_cmpb(DisasContext *ctx, unsigned r, TCGv_reg in1,
         sv = do_sub_sv(ctx, dest, in1, in2);
     }
 
-    cond = do_sub_cond(c * 2 + f, dest, in1, in2, sv);
+    cond = do_sub_cond(ctx, c * 2 + f, dest, in1, in2, sv);
     return do_cbranch(ctx, disp, n, &cond);
 }
 
@@ -3057,7 +3083,7 @@ static bool do_addb(DisasContext *ctx, unsigned r, TCGv_reg in1,
         sv = do_add_sv(ctx, dest, in1, in2);
     }
 
-    cond = do_cond(c * 2 + f, dest, cb_cond, sv);
+    cond = do_cond(ctx, c * 2 + f, d, dest, cb_cond, sv);
     save_gpr(ctx, r, dest);
     return do_cbranch(ctx, disp, n, &cond);
 }
@@ -3128,7 +3154,7 @@ static bool trans_movb(DisasContext *ctx, arg_movb *a)
         tcg_gen_mov_reg(dest, cpu_gr[a->r1]);
     }
 
-    cond = do_sed_cond(a->c, dest);
+    cond = do_sed_cond(ctx, a->c, dest);
     return do_cbranch(ctx, a->disp, a->n, &cond);
 }
 
@@ -3142,7 +3168,7 @@ static bool trans_movbi(DisasContext *ctx, arg_movbi *a)
     dest = dest_gpr(ctx, a->r);
     tcg_gen_movi_reg(dest, a->i);
 
-    cond = do_sed_cond(a->c, dest);
+    cond = do_sed_cond(ctx, a->c, dest);
     return do_cbranch(ctx, a->disp, a->n, &cond);
 }
 
@@ -3180,7 +3206,7 @@ static bool trans_shrpw_sar(DisasContext *ctx, arg_shrpw_sar *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(a->c, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, dest);
     }
     return nullify_end(ctx);
 }
@@ -3216,7 +3242,7 @@ static bool trans_shrpw_imm(DisasContext *ctx, arg_shrpw_imm *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(a->c, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, dest);
     }
     return nullify_end(ctx);
 }
@@ -3250,7 +3276,7 @@ static bool trans_extrw_sar(DisasContext *ctx, arg_extrw_sar *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(a->c, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, dest);
     }
     return nullify_end(ctx);
 }
@@ -3277,7 +3303,7 @@ static bool trans_extrw_imm(DisasContext *ctx, arg_extrw_imm *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(a->c, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, dest);
     }
     return nullify_end(ctx);
 }
@@ -3314,7 +3340,7 @@ static bool trans_depwi_imm(DisasContext *ctx, arg_depwi_imm *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(a->c, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, dest);
     }
     return nullify_end(ctx);
 }
@@ -3344,7 +3370,7 @@ static bool trans_depw_imm(DisasContext *ctx, arg_depw_imm *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(a->c, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, dest);
     }
     return nullify_end(ctx);
 }
@@ -3381,7 +3407,7 @@ static bool do_depw_sar(DisasContext *ctx, unsigned rt, unsigned c,
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


