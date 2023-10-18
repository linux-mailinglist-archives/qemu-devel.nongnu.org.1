Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 135557CEADE
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:01:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEVi-0002Dt-JK; Wed, 18 Oct 2023 17:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVf-0002Cr-KV
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:23 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVc-00052h-Qb
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:23 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-57babef76deso4061422eaf.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697666119; x=1698270919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zD/OD2M8jB+vs5HcR8Jr1nPSGY+rtPwbTcZp5cLt+Kg=;
 b=nEWebg0VEq5GjJgWJqCD5ez1q/xIy6Aajjmfgac2ueLPgThjfWGNInF0Lm9uczo473
 zs3VlmxQFnj3/WsAtyzpR8gKE0bhuPAMs/iE8VJwSLrrZ5B/aoWDmesh/7RGakQrElOg
 pTihqIL8wR7nj8aOOiDD5oWtbcdNoDHCjs4HAlZdu42aPoNJVZuBiONP19JfAQHKN2QX
 TJuLeqGv0zKeujhgG14rE6IpZG+DDWMlOSYPyiX6hf2E0z7ecGYBqF7iWJRHUJFS4mHD
 eeCsOFAMBI2xOjoVeKUoSRumg+wJqYhxiXkt3lb2FBMIY6Eo0CfzY5zI9MJ8zp/NIjvT
 Oe5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697666119; x=1698270919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zD/OD2M8jB+vs5HcR8Jr1nPSGY+rtPwbTcZp5cLt+Kg=;
 b=hvFVw3YOZa+VPDtGeGDvLWPmHa1lbHAgc3jS6gcV0TnRyW0A0ZCY1gB4JG9fYAC9Vn
 rZdzvOnQs0ch/oXyqlbYb1f6luBYwPCxY/exu609DZHfKLHlecQCUpckkV7iWZPA70tK
 JiWLFRi+LwxnpRgT6dCIJ2A2UJMtOe8ojPRhCFhqMKiJ2FMTSaocRkOXl43XoC3xXyfJ
 sP8BN7vIMftIfOQfcfEjI/NJ5O24e1eIXM8PNqRNfHxjPJMk3Y/dcCoac5CX3qma1/PK
 BwyZqnCIRatVogp1alJCaQUZi0UDospzFRQoN3Yt3O3W9t3KdWPX77DsooY9/TZCTm7i
 94hg==
X-Gm-Message-State: AOJu0YzylQ0wFkSGuZYZ1qkQMNXltI8g20eR1/wyDvAwDKipxufCu6/0
 qiuTbvQe10l/pBEsqC7mKhUsaiWxhggE+VjaWvc=
X-Google-Smtp-Source: AGHT+IEc0S6ZSL7D2WW6WfHDefvT2YTY16XPAgYjRMpMk1oRhO6tlq2EhwcLNpelj1qughjVWGKEfQ==
X-Received: by 2002:a05:6358:c62a:b0:166:a6e3:cb9c with SMTP id
 fd42-20020a056358c62a00b00166a6e3cb9cmr301586rwb.5.1697666119546; 
 Wed, 18 Oct 2023 14:55:19 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r15-20020aa7962f000000b006889348ba6esm3796263pfg.127.2023.10.18.14.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:55:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 49/61] target/hppa: Use tcg_temp_new_i64 not tcg_temp_new
Date: Wed, 18 Oct 2023 14:51:23 -0700
Message-Id: <20231018215135.1561375-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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
 target/hppa/translate.c | 158 ++++++++++++++++++++--------------------
 1 file changed, 80 insertions(+), 78 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index c782c57149..4a2bfb7757 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -32,6 +32,8 @@
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
 
+/* Choose to use explicit sizes within this file. */
+#undef tcg_temp_new
 
 typedef struct DisasCond {
     TCGCond c;
@@ -269,15 +271,15 @@ static DisasCond cond_make_0_tmp(TCGCond c, TCGv_i64 a0)
 
 static DisasCond cond_make_0(TCGCond c, TCGv_i64 a0)
 {
-    TCGv_i64 tmp = tcg_temp_new();
+    TCGv_i64 tmp = tcg_temp_new_i64();
     tcg_gen_mov_i64(tmp, a0);
     return cond_make_0_tmp(c, tmp);
 }
 
 static DisasCond cond_make(TCGCond c, TCGv_i64 a0, TCGv_i64 a1)
 {
-    TCGv_i64 t0 = tcg_temp_new();
-    TCGv_i64 t1 = tcg_temp_new();
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
 
     tcg_gen_mov_i64(t0, a0);
     tcg_gen_mov_i64(t1, a1);
@@ -302,7 +304,7 @@ static void cond_free(DisasCond *cond)
 static TCGv_i64 load_gpr(DisasContext *ctx, unsigned reg)
 {
     if (reg == 0) {
-        TCGv_i64 t = tcg_temp_new();
+        TCGv_i64 t = tcg_temp_new_i64();
         tcg_gen_movi_i64(t, 0);
         return t;
     } else {
@@ -313,7 +315,7 @@ static TCGv_i64 load_gpr(DisasContext *ctx, unsigned reg)
 static TCGv_i64 dest_gpr(DisasContext *ctx, unsigned reg)
 {
     if (reg == 0 || ctx->null_cond.c != TCG_COND_NEVER) {
-        return tcg_temp_new();
+        return tcg_temp_new_i64();
     } else {
         return cpu_gr[reg];
     }
@@ -437,7 +439,7 @@ static void nullify_over(DisasContext *ctx)
 
         /* If we're using PSW[N], copy it to a temp because... */
         if (ctx->null_cond.a0 == cpu_psw_n) {
-            ctx->null_cond.a0 = tcg_temp_new();
+            ctx->null_cond.a0 = tcg_temp_new_i64();
             tcg_gen_mov_i64(ctx->null_cond.a0, cpu_psw_n);
         }
         /* ... we clear it before branching over the implementation,
@@ -644,14 +646,14 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
         break;
     case 1: /* = / <>        (Z / !Z) */
         if (cond_need_ext(ctx, d)) {
-            tmp = tcg_temp_new();
+            tmp = tcg_temp_new_i64();
             tcg_gen_ext32u_i64(tmp, res);
             res = tmp;
         }
         cond = cond_make_0(TCG_COND_EQ, res);
         break;
     case 2: /* < / >=        (N ^ V / !(N ^ V) */
-        tmp = tcg_temp_new();
+        tmp = tcg_temp_new_i64();
         tcg_gen_xor_i64(tmp, res, sv);
         if (cond_need_ext(ctx, d)) {
             tcg_gen_ext32s_i64(tmp, tmp);
@@ -668,7 +670,7 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
          *   !(~(res ^ sv) >> 31) | !res
          *   !(~(res ^ sv) >> 31 & res)
          */
-        tmp = tcg_temp_new();
+        tmp = tcg_temp_new_i64();
         tcg_gen_eqv_i64(tmp, res, sv);
         if (cond_need_ext(ctx, d)) {
             tcg_gen_sextract_i64(tmp, tmp, 31, 1);
@@ -685,7 +687,7 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
         cond = cond_make_0(TCG_COND_EQ, cb_msb);
         break;
     case 5: /* ZNV / VNZ     (!C | Z / C & !Z) */
-        tmp = tcg_temp_new();
+        tmp = tcg_temp_new_i64();
         tcg_gen_neg_i64(tmp, cb_msb);
         tcg_gen_and_i64(tmp, tmp, res);
         if (cond_need_ext(ctx, d)) {
@@ -695,14 +697,14 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
         break;
     case 6: /* SV / NSV      (V / !V) */
         if (cond_need_ext(ctx, d)) {
-            tmp = tcg_temp_new();
+            tmp = tcg_temp_new_i64();
             tcg_gen_ext32s_i64(tmp, sv);
             sv = tmp;
         }
         cond = cond_make_0(TCG_COND_LT, sv);
         break;
     case 7: /* OD / EV */
-        tmp = tcg_temp_new();
+        tmp = tcg_temp_new_i64();
         tcg_gen_andi_i64(tmp, res, 1);
         cond = cond_make_0_tmp(TCG_COND_NE, tmp);
         break;
@@ -756,8 +758,8 @@ static DisasCond do_sub_cond(DisasContext *ctx, unsigned cf, bool d,
         tc = tcg_invert_cond(tc);
     }
     if (cond_need_ext(ctx, d)) {
-        TCGv_i64 t1 = tcg_temp_new();
-        TCGv_i64 t2 = tcg_temp_new();
+        TCGv_i64 t1 = tcg_temp_new_i64();
+        TCGv_i64 t2 = tcg_temp_new_i64();
 
         if (ext_uns) {
             tcg_gen_ext32u_i64(t1, in1);
@@ -833,7 +835,7 @@ static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, bool d,
     }
 
     if (cond_need_ext(ctx, d)) {
-        TCGv_i64 tmp = tcg_temp_new();
+        TCGv_i64 tmp = tcg_temp_new_i64();
 
         if (ext_uns) {
             tcg_gen_ext32u_i64(tmp, res);
@@ -878,8 +880,8 @@ static DisasCond do_unit_cond(unsigned cf, bool d, TCGv_i64 res,
          * do our normal thing and compute carry-in of bit B+1 since that
          * leaves us with carry bits spread across two words.
          */
-        cb = tcg_temp_new();
-        tmp = tcg_temp_new();
+        cb = tcg_temp_new_i64();
+        tmp = tcg_temp_new_i64();
         tcg_gen_or_i64(cb, in1, in2);
         tcg_gen_and_i64(tmp, in1, in2);
         tcg_gen_andc_i64(cb, cb, res);
@@ -897,7 +899,7 @@ static DisasCond do_unit_cond(unsigned cf, bool d, TCGv_i64 res,
         /* See hasless(v,1) from
          * https://graphics.stanford.edu/~seander/bithacks.html#ZeroInWord
          */
-        tmp = tcg_temp_new();
+        tmp = tcg_temp_new_i64();
         tcg_gen_subi_i64(tmp, res, d_repl * 0x01010101u);
         tcg_gen_andc_i64(tmp, tmp, res);
         tcg_gen_andi_i64(tmp, tmp, d_repl * 0x80808080u);
@@ -905,7 +907,7 @@ static DisasCond do_unit_cond(unsigned cf, bool d, TCGv_i64 res,
         break;
 
     case 3: /* SHZ / NHZ */
-        tmp = tcg_temp_new();
+        tmp = tcg_temp_new_i64();
         tcg_gen_subi_i64(tmp, res, d_repl * 0x00010001u);
         tcg_gen_andc_i64(tmp, tmp, res);
         tcg_gen_andi_i64(tmp, tmp, d_repl * 0x80008000u);
@@ -941,7 +943,7 @@ static TCGv_i64 get_carry(DisasContext *ctx, bool d,
                           TCGv_i64 cb, TCGv_i64 cb_msb)
 {
     if (cond_need_ext(ctx, d)) {
-        TCGv_i64 t = tcg_temp_new();
+        TCGv_i64 t = tcg_temp_new_i64();
         tcg_gen_extract_i64(t, cb, 32, 1);
         return t;
     }
@@ -957,8 +959,8 @@ static TCGv_i64 get_psw_carry(DisasContext *ctx, bool d)
 static TCGv_i64 do_add_sv(DisasContext *ctx, TCGv_i64 res,
                           TCGv_i64 in1, TCGv_i64 in2)
 {
-    TCGv_i64 sv = tcg_temp_new();
-    TCGv_i64 tmp = tcg_temp_new();
+    TCGv_i64 sv = tcg_temp_new_i64();
+    TCGv_i64 tmp = tcg_temp_new_i64();
 
     tcg_gen_xor_i64(sv, res, in1);
     tcg_gen_xor_i64(tmp, in1, in2);
@@ -971,8 +973,8 @@ static TCGv_i64 do_add_sv(DisasContext *ctx, TCGv_i64 res,
 static TCGv_i64 do_sub_sv(DisasContext *ctx, TCGv_i64 res,
                           TCGv_i64 in1, TCGv_i64 in2)
 {
-    TCGv_i64 sv = tcg_temp_new();
-    TCGv_i64 tmp = tcg_temp_new();
+    TCGv_i64 sv = tcg_temp_new_i64();
+    TCGv_i64 tmp = tcg_temp_new_i64();
 
     tcg_gen_xor_i64(sv, res, in1);
     tcg_gen_xor_i64(tmp, in1, in2);
@@ -989,21 +991,21 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     unsigned c = cf >> 1;
     DisasCond cond;
 
-    dest = tcg_temp_new();
+    dest = tcg_temp_new_i64();
     cb = NULL;
     cb_msb = NULL;
     cb_cond = NULL;
 
     if (shift) {
-        tmp = tcg_temp_new();
+        tmp = tcg_temp_new_i64();
         tcg_gen_shli_i64(tmp, in1, shift);
         in1 = tmp;
     }
 
     if (!is_l || cond_need_cb(c)) {
         TCGv_i64 zero = tcg_constant_i64(0);
-        cb_msb = tcg_temp_new();
-        cb = tcg_temp_new();
+        cb_msb = tcg_temp_new_i64();
+        cb = tcg_temp_new_i64();
 
         tcg_gen_add2_i64(dest, cb_msb, in1, zero, in2, zero);
         if (is_c) {
@@ -1035,7 +1037,7 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     /* Emit any conditional trap before any writeback.  */
     cond = do_cond(ctx, cf, d, dest, cb_cond, sv);
     if (is_tc) {
-        tmp = tcg_temp_new();
+        tmp = tcg_temp_new_i64();
         tcg_gen_setcond_i64(cond.c, tmp, cond.a0, cond.a1);
         gen_helper_tcond(tcg_env, tmp);
     }
@@ -1090,9 +1092,9 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     unsigned c = cf >> 1;
     DisasCond cond;
 
-    dest = tcg_temp_new();
-    cb = tcg_temp_new();
-    cb_msb = tcg_temp_new();
+    dest = tcg_temp_new_i64();
+    cb = tcg_temp_new_i64();
+    cb_msb = tcg_temp_new_i64();
 
     zero = tcg_constant_i64(0);
     if (is_b) {
@@ -1131,7 +1133,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
 
     /* Emit any conditional trap before any writeback.  */
     if (is_tc) {
-        tmp = tcg_temp_new();
+        tmp = tcg_temp_new_i64();
         tcg_gen_setcond_i64(cond.c, tmp, cond.a0, cond.a1);
         gen_helper_tcond(tcg_env, tmp);
     }
@@ -1180,7 +1182,7 @@ static void do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     TCGv_i64 dest, sv;
     DisasCond cond;
 
-    dest = tcg_temp_new();
+    dest = tcg_temp_new_i64();
     tcg_gen_sub_i64(dest, in1, in2);
 
     /* Compute signed overflow if required.  */
@@ -1245,13 +1247,13 @@ static void do_unit(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
         save_gpr(ctx, rt, dest);
         cond_free(&ctx->null_cond);
     } else {
-        dest = tcg_temp_new();
+        dest = tcg_temp_new_i64();
         fn(dest, in1, in2);
 
         cond = do_unit_cond(cf, d, dest, in1, in2);
 
         if (is_tc) {
-            TCGv_i64 tmp = tcg_temp_new();
+            TCGv_i64 tmp = tcg_temp_new_i64();
             tcg_gen_setcond_i64(cond.c, tmp, cond.a0, cond.a1);
             gen_helper_tcond(tcg_env, tmp);
         }
@@ -1286,7 +1288,7 @@ static TCGv_i64 space_select(DisasContext *ctx, int sp, TCGv_i64 base)
     }
 
     ptr = tcg_temp_new_ptr();
-    tmp = tcg_temp_new();
+    tmp = tcg_temp_new_i64();
     spc = tcg_temp_new_i64();
 
     /* Extract top 2 bits of the address, shift left 3 for uint64_t index. */
@@ -1311,11 +1313,11 @@ static void form_gva(DisasContext *ctx, TCGv_i64 *pgva, TCGv_i64 *pofs,
 
     /* Note that RX is mutually exclusive with DISP.  */
     if (rx) {
-        ofs = tcg_temp_new();
+        ofs = tcg_temp_new_i64();
         tcg_gen_shli_i64(ofs, cpu_gr[rx], scale);
         tcg_gen_add_i64(ofs, ofs, base);
     } else if (disp || modify) {
-        ofs = tcg_temp_new();
+        ofs = tcg_temp_new_i64();
         tcg_gen_addi_i64(ofs, base, disp);
     } else {
         ofs = base;
@@ -1421,7 +1423,7 @@ static bool do_load(DisasContext *ctx, unsigned rt, unsigned rb,
         dest = dest_gpr(ctx, rt);
     } else {
         /* Make sure if RT == RB, we see the result of the load.  */
-        dest = tcg_temp_new();
+        dest = tcg_temp_new_i64();
     }
     do_load_64(ctx, dest, rb, rx, scale, disp, sp, modify, mop);
     save_gpr(ctx, rt, dest);
@@ -1737,7 +1739,7 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
         if (link != 0) {
             copy_iaoq_entry(cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
         }
-        next = tcg_temp_new();
+        next = tcg_temp_new_i64();
         tcg_gen_mov_i64(next, dest);
         if (is_n) {
             if (use_nullify_skip(ctx)) {
@@ -1778,8 +1780,8 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
         a0 = ctx->null_cond.a0;
         a1 = ctx->null_cond.a1;
 
-        tmp = tcg_temp_new();
-        next = tcg_temp_new();
+        tmp = tcg_temp_new_i64();
+        next = tcg_temp_new_i64();
 
         copy_iaoq_entry(tmp, ctx->iaoq_n, ctx->iaoq_n_var);
         tcg_gen_movcond_i64(c, next, a0, a1, tmp, dest);
@@ -1821,11 +1823,11 @@ static TCGv_i64 do_ibranch_priv(DisasContext *ctx, TCGv_i64 offset)
         return offset;
     case 3:
         /* Privilege 3 is minimum and is never allowed to increase.  */
-        dest = tcg_temp_new();
+        dest = tcg_temp_new_i64();
         tcg_gen_ori_i64(dest, offset, 3);
         break;
     default:
-        dest = tcg_temp_new();
+        dest = tcg_temp_new_i64();
         tcg_gen_andi_i64(dest, offset, -4);
         tcg_gen_ori_i64(dest, dest, ctx->privilege);
         tcg_gen_movcond_i64(TCG_COND_GTU, dest, dest, offset, dest, offset);
@@ -1983,7 +1985,7 @@ static bool trans_mfctl(DisasContext *ctx, arg_mfctl *a)
         break;
     }
 
-    tmp = tcg_temp_new();
+    tmp = tcg_temp_new_i64();
     tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUHPPAState, cr[ctl]));
     save_gpr(ctx, rt, tmp);
 
@@ -2024,7 +2026,7 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
 
     if (ctl == CR_SAR) {
         reg = load_gpr(ctx, a->r);
-        tmp = tcg_temp_new();
+        tmp = tcg_temp_new_i64();
         tcg_gen_andi_i64(tmp, reg, ctx->is_pa20 ? 63 : 31);
         save_or_nullify(ctx, cpu_sar, tmp);
 
@@ -2055,7 +2057,7 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
     case CR_IIAOQ:
         /* FIXME: Respect PSW_Q bit */
         /* The write advances the queue and stores to the back element.  */
-        tmp = tcg_temp_new();
+        tmp = tcg_temp_new_i64();
         tcg_gen_ld_i64(tmp, tcg_env,
                        offsetof(CPUHPPAState, cr_back[ctl - CR_IIASQ]));
         tcg_gen_st_i64(tmp, tcg_env, offsetof(CPUHPPAState, cr[ctl]));
@@ -2083,7 +2085,7 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
 
 static bool trans_mtsarcm(DisasContext *ctx, arg_mtsarcm *a)
 {
-    TCGv_i64 tmp = tcg_temp_new();
+    TCGv_i64 tmp = tcg_temp_new_i64();
 
     tcg_gen_not_i64(tmp, load_gpr(ctx, a->r));
     tcg_gen_andi_i64(tmp, tmp, ctx->is_pa20 ? 63 : 31);
@@ -2118,7 +2120,7 @@ static bool trans_rsm(DisasContext *ctx, arg_rsm *a)
 
     nullify_over(ctx);
 
-    tmp = tcg_temp_new();
+    tmp = tcg_temp_new_i64();
     tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
     tcg_gen_andi_i64(tmp, tmp, ~a->i);
     gen_helper_swap_system_mask(tmp, tcg_env, tmp);
@@ -2138,7 +2140,7 @@ static bool trans_ssm(DisasContext *ctx, arg_ssm *a)
 
     nullify_over(ctx);
 
-    tmp = tcg_temp_new();
+    tmp = tcg_temp_new_i64();
     tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
     tcg_gen_ori_i64(tmp, tmp, a->i);
     gen_helper_swap_system_mask(tmp, tcg_env, tmp);
@@ -2158,7 +2160,7 @@ static bool trans_mtsm(DisasContext *ctx, arg_mtsm *a)
     nullify_over(ctx);
 
     reg = load_gpr(ctx, a->r);
-    tmp = tcg_temp_new();
+    tmp = tcg_temp_new_i64();
     gen_helper_swap_system_mask(tmp, tcg_env, reg);
 
     /* Exit the TB to recognize new interrupts.  */
@@ -2406,7 +2408,7 @@ static bool trans_lpa(DisasContext *ctx, arg_ldst *a)
 
     form_gva(ctx, &vaddr, &ofs, a->b, a->x, 0, 0, a->sp, a->m, false);
 
-    paddr = tcg_temp_new();
+    paddr = tcg_temp_new_i64();
     gen_helper_lpa(paddr, tcg_env, vaddr);
 
     /* Note that physical address result overrides base modification.  */
@@ -2590,7 +2592,7 @@ static bool do_uaddcm(DisasContext *ctx, arg_rrr_cf_d *a, bool is_tc)
     }
     tcg_r1 = load_gpr(ctx, a->r1);
     tcg_r2 = load_gpr(ctx, a->r2);
-    tmp = tcg_temp_new();
+    tmp = tcg_temp_new_i64();
     tcg_gen_not_i64(tmp, tcg_r2);
     do_unit(ctx, a->t, tcg_r1, tmp, a->cf, a->d, is_tc, tcg_gen_add_i64);
     return nullify_end(ctx);
@@ -2612,7 +2614,7 @@ static bool do_dcor(DisasContext *ctx, arg_rr_cf_d *a, bool is_i)
 
     nullify_over(ctx);
 
-    tmp = tcg_temp_new();
+    tmp = tcg_temp_new_i64();
     tcg_gen_shri_i64(tmp, cpu_psw_cb, 3);
     if (!is_i) {
         tcg_gen_not_i64(tmp, tmp);
@@ -2644,10 +2646,10 @@ static bool trans_ds(DisasContext *ctx, arg_rrr_cf *a)
     in1 = load_gpr(ctx, a->r1);
     in2 = load_gpr(ctx, a->r2);
 
-    add1 = tcg_temp_new();
-    add2 = tcg_temp_new();
-    addc = tcg_temp_new();
-    dest = tcg_temp_new();
+    add1 = tcg_temp_new_i64();
+    add2 = tcg_temp_new_i64();
+    addc = tcg_temp_new_i64();
+    dest = tcg_temp_new_i64();
     zero = tcg_constant_i64(0);
 
     /* Form R1 << 1 | PSW[CB]{8}.  */
@@ -2770,7 +2772,7 @@ static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
     if (a->m) {
         /* Base register modification.  Make sure if RT == RB,
            we see the result of the load.  */
-        dest = tcg_temp_new();
+        dest = tcg_temp_new_i64();
     } else {
         dest = dest_gpr(ctx, a->t);
     }
@@ -2927,7 +2929,7 @@ static bool do_cmpb(DisasContext *ctx, unsigned r, TCGv_i64 in1,
     DisasCond cond;
 
     in2 = load_gpr(ctx, r);
-    dest = tcg_temp_new();
+    dest = tcg_temp_new_i64();
 
     tcg_gen_sub_i64(dest, in1, in2);
 
@@ -2979,13 +2981,13 @@ static bool do_addb(DisasContext *ctx, unsigned r, TCGv_i64 in1,
     }
 
     in2 = load_gpr(ctx, r);
-    dest = tcg_temp_new();
+    dest = tcg_temp_new_i64();
     sv = NULL;
     cb_cond = NULL;
 
     if (cond_need_cb(c)) {
-        TCGv_i64 cb = tcg_temp_new();
-        TCGv_i64 cb_msb = tcg_temp_new();
+        TCGv_i64 cb = tcg_temp_new_i64();
+        TCGv_i64 cb_msb = tcg_temp_new_i64();
 
         tcg_gen_movi_i64(cb_msb, 0);
         tcg_gen_add2_i64(dest, cb_msb, in1, cb_msb, in2, cb_msb);
@@ -3023,7 +3025,7 @@ static bool trans_bb_sar(DisasContext *ctx, arg_bb_sar *a)
 
     nullify_over(ctx);
 
-    tmp = tcg_temp_new();
+    tmp = tcg_temp_new_i64();
     tcg_r = load_gpr(ctx, a->r);
     if (cond_need_ext(ctx, a->d)) {
         /* Force shift into [32,63] */
@@ -3045,7 +3047,7 @@ static bool trans_bb_imm(DisasContext *ctx, arg_bb_imm *a)
 
     nullify_over(ctx);
 
-    tmp = tcg_temp_new();
+    tmp = tcg_temp_new_i64();
     tcg_r = load_gpr(ctx, a->r);
     p = a->p | (cond_need_ext(ctx, a->d) ? 32 : 0);
     tcg_gen_shli_i64(tmp, tcg_r, p);
@@ -3105,7 +3107,7 @@ static bool trans_shrp_sar(DisasContext *ctx, arg_shrp_sar *a)
             tcg_gen_shr_i64(dest, dest, cpu_sar);
         } else {
             tcg_gen_ext32u_i64(dest, load_gpr(ctx, a->r2));
-            tmp = tcg_temp_new();
+            tmp = tcg_temp_new_i64();
             tcg_gen_andi_i64(tmp, cpu_sar, 31);
             tcg_gen_shr_i64(dest, dest, tmp);
         }
@@ -3123,8 +3125,8 @@ static bool trans_shrp_sar(DisasContext *ctx, arg_shrp_sar *a)
             tcg_gen_extu_i32_i64(dest, t32);
         }
     } else if (a->d) {
-        TCGv_i64 t = tcg_temp_new();
-        TCGv_i64 n = tcg_temp_new();
+        TCGv_i64 t = tcg_temp_new_i64();
+        TCGv_i64 n = tcg_temp_new_i64();
 
         tcg_gen_xori_i64(n, cpu_sar, 63);
         tcg_gen_shl_i64(t, load_gpr(ctx, a->r2), n);
@@ -3206,7 +3208,7 @@ static bool trans_extr_sar(DisasContext *ctx, arg_extr_sar *a)
 
     dest = dest_gpr(ctx, a->t);
     src = load_gpr(ctx, a->r);
-    tmp = tcg_temp_new();
+    tmp = tcg_temp_new_i64();
 
     /* Recall that SAR is using big-endian bit numbering.  */
     tcg_gen_andi_i64(tmp, cpu_sar, widthm1);
@@ -3350,14 +3352,14 @@ static bool do_dep_sar(DisasContext *ctx, unsigned rt, unsigned c,
     uint64_t msb = 1ULL << (len - 1);
 
     dest = dest_gpr(ctx, rt);
-    shift = tcg_temp_new();
-    tmp = tcg_temp_new();
+    shift = tcg_temp_new_i64();
+    tmp = tcg_temp_new_i64();
 
     /* Convert big-endian bit numbering in SAR to left-shift.  */
     tcg_gen_andi_i64(shift, cpu_sar, widthm1);
     tcg_gen_xori_i64(shift, shift, widthm1);
 
-    mask = tcg_temp_new();
+    mask = tcg_temp_new_i64();
     tcg_gen_movi_i64(mask, msb + (msb - 1));
     tcg_gen_and_i64(tmp, val, mask);
     if (rs) {
@@ -3422,7 +3424,7 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
     nullify_over(ctx);
 #endif
 
-    tmp = tcg_temp_new();
+    tmp = tcg_temp_new_i64();
     tcg_gen_addi_i64(tmp, load_gpr(ctx, a->b), a->disp);
     tmp = do_ibranch_priv(ctx, tmp);
 
@@ -3519,7 +3521,7 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
 static bool trans_blr(DisasContext *ctx, arg_blr *a)
 {
     if (a->x) {
-        TCGv_i64 tmp = tcg_temp_new();
+        TCGv_i64 tmp = tcg_temp_new_i64();
         tcg_gen_shli_i64(tmp, load_gpr(ctx, a->x), 3);
         tcg_gen_addi_i64(tmp, tmp, ctx->iaoq_f + 8);
         /* The computation here never changes privilege level.  */
@@ -3537,7 +3539,7 @@ static bool trans_bv(DisasContext *ctx, arg_bv *a)
     if (a->x == 0) {
         dest = load_gpr(ctx, a->b);
     } else {
-        dest = tcg_temp_new();
+        dest = tcg_temp_new_i64();
         tcg_gen_shli_i64(dest, load_gpr(ctx, a->x), 3);
         tcg_gen_add_i64(dest, dest, load_gpr(ctx, a->b));
     }
@@ -3874,7 +3876,7 @@ static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
 
     nullify_over(ctx);
 
-    t = tcg_temp_new();
+    t = tcg_temp_new_i64();
     tcg_gen_ld32u_i64(t, tcg_env, offsetof(CPUHPPAState, fr0_shadow));
 
     if (a->y == 1) {
@@ -4176,7 +4178,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
            This will be overwritten by a branch.  */
         if (ctx->iaoq_b == -1) {
             ctx->iaoq_n = -1;
-            ctx->iaoq_n_var = tcg_temp_new();
+            ctx->iaoq_n_var = tcg_temp_new_i64();
             tcg_gen_addi_i64(ctx->iaoq_n_var, cpu_iaoq_b, 4);
         } else {
             ctx->iaoq_n = ctx->iaoq_b + 4;
-- 
2.34.1


