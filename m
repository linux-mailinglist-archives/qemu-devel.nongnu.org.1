Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C267D1785
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:51:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwM5-0007yz-Ud; Fri, 20 Oct 2023 16:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLk-0007lp-Vi
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:08 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLd-0008C0-IH
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:03 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6bd73395bceso1020900b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834632; x=1698439432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zge3ex/yn6oStv5+4EsP6t9DbvB5wzQOrcigC9xjD9g=;
 b=bFe1R92j1iz1zLM9bnysicrjk0VttdwlJrKhDBGb8eAUaqbYw3T8YWYBQvMkYZ2xjU
 fDmNPxTQ7h3wYItN3H5oMiwZhM82uo7SiszoQWotWF0fHX21EO4PwagLasyy/hZu+sI9
 6dnOxdEm2GFlnTt1iK8vI4y9oLH0GwmnfkDla7pbNzWvy3wepJHvY0cFtlVF5jSgqghL
 6DeEPJM0Ue46F4BECGpK4xeOKCqx75m2o/SV1J0hLJpCYee0z0zluoghdT8m7kbTu63B
 z8w8/HWs3tmsksKd7KZi0En5hgGmpbbPrtLwaNgKGZp58b3cNLqL3Zz9J0EtKVoNc9B/
 Ki2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834632; x=1698439432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zge3ex/yn6oStv5+4EsP6t9DbvB5wzQOrcigC9xjD9g=;
 b=wVd+eK92N6YkvZL5Ul/EzxKtCdIZ1Q+YFSiOPZJba/VcRvaJGVMlMyi6dKkM/6hpQ5
 xlGeewXPcLD9z6sg6aFurRWVTAq+sIts0VwGlr8I3tThidzeceyzTKbPMHq3HndsuTPO
 2kT70O1fAcxFl8hADBhlezlJc9fF+F/Xcs4VtVaYa5sojqJB8i2zQZaSFWPQrBkrwgES
 KQgmaAxAsgSTaEXEvJ75D5n9hjE9qJedTJ8fgYPPWi1fLvcsxGseovAMhqsJ37Lg9Pnj
 CIQtVaYfi+j4R2zqMeavvUGf7MR2jkJnO8NsrcUTkkFQfjiqGTmhJsXw/002onxeia8k
 E2wA==
X-Gm-Message-State: AOJu0YyTyBXHy3pZ4m3AQGU8jlKKxq27GxxwKoIjkhADjdsPIG0PU7LU
 oKSRKHI3zDNMq4CWxFeayg/e/YJWpw1T9VmMHzE=
X-Google-Smtp-Source: AGHT+IH2D211wsmqXhSSrl8qs171g37dZk6xITI3smIGKU5Dsnc9jgOvIVBvYbWMzdVkF9QNBcuE/Q==
X-Received: by 2002:a05:6a20:2593:b0:15d:8366:65be with SMTP id
 k19-20020a056a20259300b0015d836665bemr3794091pzd.9.1697834632468; 
 Fri, 20 Oct 2023 13:43:52 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 22/65] target/hppa: Pass d to do_cond
Date: Fri, 20 Oct 2023 13:42:48 -0700
Message-Id: <20231020204331.139847-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
index cb60485cbb..e84311d886 100644
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


