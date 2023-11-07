Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE817E3414
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:16:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRs-0005el-Ox; Mon, 06 Nov 2023 22:08:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRc-0004nt-Rx
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:01 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRW-0001PD-Fq
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:00 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6b89ab5ddb7so5544226b3a.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326473; x=1699931273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SoAzoqPgJWu65ZedEAkYdYolZU34/SD/kPLT/+E1D0c=;
 b=ADJ7KmG2z7Qu/4W/SC9270AX9kzbr0omXTGMiDScPDBYwj2ZwEKeoP/9Ca47Hr+rIY
 BY8JQU94jUVtakFoyTZwQadY+LZrdDoIjLVhs3TaWlLu8iImwHfHKZBr1jq7XScrm0y4
 6lUuiIHROtecPa0Yi6zvqkRayV5+QJWE2j9UN3SM90WDYhjpzXF/vNF9qUCOcW2e3GVd
 AiKoEWZMU9p74trP/tX5aVPVwS55H/ya54QbT8x7Miu4z7srddjIpI3M218xAbkygnuu
 ljp0dSZrDI8shDg1w7+3xRAvAcr1pbDGWLFK8klWGtHotlawbK8uV7Mw1X8/DnSRJLAj
 JlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326473; x=1699931273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SoAzoqPgJWu65ZedEAkYdYolZU34/SD/kPLT/+E1D0c=;
 b=QjkgwN3FOYnU2yVDVElZRyBk3o9YsB/nk04x+1HUyb04fNTgVMuFDA9T9opNHLQzfv
 T1NoChty+fTOJyB9f2YHvApY9r3OUlNzrr7NhoXyC1DyYpJT2Tt1OrOq3mGnxNaMbga5
 cT3vbBGX5YTtukggnnL6E/qPlcRNKNqKzQ/l6xDqZYUv6DiRwG1dWC6NnM4wVTGZ0wjr
 A2dhRegM8jzZIHIazaWn4w2N3CahEP14eB8YcNvFm3+I3ZDyzOIAM5Y2+a3Jhu9Hr/OM
 Ottwo44U/fA+h3X/JfIaB+xpAR5HqgunOuhwh4tY0sSB/p4vcZ9EiF/lO1vXA3CGduDQ
 g73A==
X-Gm-Message-State: AOJu0YxxVBZRYgwj8adFD9i02jR8pg0ME4+4lxFoT3ul2aVnltc939PF
 pzKqwmxhQChE7sIIWOXtrPEbBfd8YVXEryXuDC8=
X-Google-Smtp-Source: AGHT+IHztllZcAWJfvRfclKGVXQFvv1arkvE+aW1dUcolSy6+JZCiI+CMgm2GB2f9xgv7q2GDSP3WA==
X-Received: by 2002:a05:6a20:12c4:b0:181:275f:3b4f with SMTP id
 v4-20020a056a2012c400b00181275f3b4fmr18536398pzg.11.1699326473045; 
 Mon, 06 Nov 2023 19:07:53 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.07.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:07:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 59/85] target/hppa: Use tcg_temp_new_i64 not tcg_temp_new
Date: Mon,  6 Nov 2023 19:03:41 -0800
Message-Id: <20231107030407.8979-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
 target/hppa/translate.c | 162 ++++++++++++++++++++--------------------
 1 file changed, 82 insertions(+), 80 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 0024c38c84..c8c702ac03 100644
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
@@ -657,14 +659,14 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
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
@@ -681,7 +683,7 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
          *   !(~(res ^ sv) >> 31) | !res
          *   !(~(res ^ sv) >> 31 & res)
          */
-        tmp = tcg_temp_new();
+        tmp = tcg_temp_new_i64();
         tcg_gen_eqv_i64(tmp, res, sv);
         if (cond_need_ext(ctx, d)) {
             tcg_gen_sextract_i64(tmp, tmp, 31, 1);
@@ -698,7 +700,7 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
         cond = cond_make_0(TCG_COND_EQ, cb_msb);
         break;
     case 5: /* ZNV / VNZ     (!C | Z / C & !Z) */
-        tmp = tcg_temp_new();
+        tmp = tcg_temp_new_i64();
         tcg_gen_neg_i64(tmp, cb_msb);
         tcg_gen_and_i64(tmp, tmp, res);
         if (cond_need_ext(ctx, d)) {
@@ -708,14 +710,14 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
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
@@ -769,8 +771,8 @@ static DisasCond do_sub_cond(DisasContext *ctx, unsigned cf, bool d,
         tc = tcg_invert_cond(tc);
     }
     if (cond_need_ext(ctx, d)) {
-        TCGv_i64 t1 = tcg_temp_new();
-        TCGv_i64 t2 = tcg_temp_new();
+        TCGv_i64 t1 = tcg_temp_new_i64();
+        TCGv_i64 t2 = tcg_temp_new_i64();
 
         if (ext_uns) {
             tcg_gen_ext32u_i64(t1, in1);
@@ -846,7 +848,7 @@ static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, bool d,
     }
 
     if (cond_need_ext(ctx, d)) {
-        TCGv_i64 tmp = tcg_temp_new();
+        TCGv_i64 tmp = tcg_temp_new_i64();
 
         if (ext_uns) {
             tcg_gen_ext32u_i64(tmp, res);
@@ -891,8 +893,8 @@ static DisasCond do_unit_cond(unsigned cf, bool d, TCGv_i64 res,
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
@@ -910,7 +912,7 @@ static DisasCond do_unit_cond(unsigned cf, bool d, TCGv_i64 res,
         /* See hasless(v,1) from
          * https://graphics.stanford.edu/~seander/bithacks.html#ZeroInWord
          */
-        tmp = tcg_temp_new();
+        tmp = tcg_temp_new_i64();
         tcg_gen_subi_i64(tmp, res, d_repl * 0x01010101u);
         tcg_gen_andc_i64(tmp, tmp, res);
         tcg_gen_andi_i64(tmp, tmp, d_repl * 0x80808080u);
@@ -918,7 +920,7 @@ static DisasCond do_unit_cond(unsigned cf, bool d, TCGv_i64 res,
         break;
 
     case 3: /* SHZ / NHZ */
-        tmp = tcg_temp_new();
+        tmp = tcg_temp_new_i64();
         tcg_gen_subi_i64(tmp, res, d_repl * 0x00010001u);
         tcg_gen_andc_i64(tmp, tmp, res);
         tcg_gen_andi_i64(tmp, tmp, d_repl * 0x80008000u);
@@ -954,7 +956,7 @@ static TCGv_i64 get_carry(DisasContext *ctx, bool d,
                           TCGv_i64 cb, TCGv_i64 cb_msb)
 {
     if (cond_need_ext(ctx, d)) {
-        TCGv_i64 t = tcg_temp_new();
+        TCGv_i64 t = tcg_temp_new_i64();
         tcg_gen_extract_i64(t, cb, 32, 1);
         return t;
     }
@@ -970,8 +972,8 @@ static TCGv_i64 get_psw_carry(DisasContext *ctx, bool d)
 static TCGv_i64 do_add_sv(DisasContext *ctx, TCGv_i64 res,
                           TCGv_i64 in1, TCGv_i64 in2)
 {
-    TCGv_i64 sv = tcg_temp_new();
-    TCGv_i64 tmp = tcg_temp_new();
+    TCGv_i64 sv = tcg_temp_new_i64();
+    TCGv_i64 tmp = tcg_temp_new_i64();
 
     tcg_gen_xor_i64(sv, res, in1);
     tcg_gen_xor_i64(tmp, in1, in2);
@@ -984,8 +986,8 @@ static TCGv_i64 do_add_sv(DisasContext *ctx, TCGv_i64 res,
 static TCGv_i64 do_sub_sv(DisasContext *ctx, TCGv_i64 res,
                           TCGv_i64 in1, TCGv_i64 in2)
 {
-    TCGv_i64 sv = tcg_temp_new();
-    TCGv_i64 tmp = tcg_temp_new();
+    TCGv_i64 sv = tcg_temp_new_i64();
+    TCGv_i64 tmp = tcg_temp_new_i64();
 
     tcg_gen_xor_i64(sv, res, in1);
     tcg_gen_xor_i64(tmp, in1, in2);
@@ -1002,21 +1004,21 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
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
@@ -1048,7 +1050,7 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     /* Emit any conditional trap before any writeback.  */
     cond = do_cond(ctx, cf, d, dest, cb_cond, sv);
     if (is_tc) {
-        tmp = tcg_temp_new();
+        tmp = tcg_temp_new_i64();
         tcg_gen_setcond_i64(cond.c, tmp, cond.a0, cond.a1);
         gen_helper_tcond(tcg_env, tmp);
     }
@@ -1103,9 +1105,9 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
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
@@ -1144,7 +1146,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
 
     /* Emit any conditional trap before any writeback.  */
     if (is_tc) {
-        tmp = tcg_temp_new();
+        tmp = tcg_temp_new_i64();
         tcg_gen_setcond_i64(cond.c, tmp, cond.a0, cond.a1);
         gen_helper_tcond(tcg_env, tmp);
     }
@@ -1193,7 +1195,7 @@ static void do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     TCGv_i64 dest, sv;
     DisasCond cond;
 
-    dest = tcg_temp_new();
+    dest = tcg_temp_new_i64();
     tcg_gen_sub_i64(dest, in1, in2);
 
     /* Compute signed overflow if required.  */
@@ -1258,13 +1260,13 @@ static void do_unit(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
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
@@ -1299,7 +1301,7 @@ static TCGv_i64 space_select(DisasContext *ctx, int sp, TCGv_i64 base)
     }
 
     ptr = tcg_temp_new_ptr();
-    tmp = tcg_temp_new();
+    tmp = tcg_temp_new_i64();
     spc = tcg_temp_new_i64();
 
     /* Extract top 2 bits of the address, shift left 3 for uint64_t index. */
@@ -1324,11 +1326,11 @@ static void form_gva(DisasContext *ctx, TCGv_i64 *pgva, TCGv_i64 *pofs,
 
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
@@ -1434,7 +1436,7 @@ static bool do_load(DisasContext *ctx, unsigned rt, unsigned rb,
         dest = dest_gpr(ctx, rt);
     } else {
         /* Make sure if RT == RB, we see the result of the load.  */
-        dest = tcg_temp_new();
+        dest = tcg_temp_new_i64();
     }
     do_load_64(ctx, dest, rb, rx, scale, disp, sp, modify, mop);
     save_gpr(ctx, rt, dest);
@@ -1750,7 +1752,7 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
         if (link != 0) {
             copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
         }
-        next = tcg_temp_new();
+        next = tcg_temp_new_i64();
         tcg_gen_mov_i64(next, dest);
         if (is_n) {
             if (use_nullify_skip(ctx)) {
@@ -1779,7 +1781,7 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
            branching.  Since IOAQ_F is not really live at this point, we
            can simply store DEST optimistically.  Similarly with IAOQ_B.  */
         copy_iaoq_entry(ctx, cpu_iaoq_f, -1, dest);
-        next = tcg_temp_new();
+        next = tcg_temp_new_i64();
         tcg_gen_addi_i64(next, dest, 4);
         copy_iaoq_entry(ctx, cpu_iaoq_b, -1, next);
 
@@ -1794,8 +1796,8 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
         a0 = ctx->null_cond.a0;
         a1 = ctx->null_cond.a1;
 
-        tmp = tcg_temp_new();
-        next = tcg_temp_new();
+        tmp = tcg_temp_new_i64();
+        next = tcg_temp_new_i64();
 
         copy_iaoq_entry(ctx, tmp, ctx->iaoq_n, ctx->iaoq_n_var);
         tcg_gen_movcond_i64(c, next, a0, a1, tmp, dest);
@@ -1837,11 +1839,11 @@ static TCGv_i64 do_ibranch_priv(DisasContext *ctx, TCGv_i64 offset)
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
@@ -1898,7 +1900,7 @@ static void do_page_zero(DisasContext *ctx)
 
     case 0xe0: /* SET_THREAD_POINTER */
         tcg_gen_st_i64(cpu_gr[26], tcg_env, offsetof(CPUHPPAState, cr[27]));
-        tmp = tcg_temp_new();
+        tmp = tcg_temp_new_i64();
         tcg_gen_ori_i64(tmp, cpu_gr[31], 3);
         copy_iaoq_entry(ctx, cpu_iaoq_f, -1, tmp);
         tcg_gen_addi_i64(tmp, tmp, 4);
@@ -2004,7 +2006,7 @@ static bool trans_mfctl(DisasContext *ctx, arg_mfctl *a)
         break;
     }
 
-    tmp = tcg_temp_new();
+    tmp = tcg_temp_new_i64();
     tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUHPPAState, cr[ctl]));
     save_gpr(ctx, rt, tmp);
 
@@ -2045,7 +2047,7 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
 
     if (ctl == CR_SAR) {
         reg = load_gpr(ctx, a->r);
-        tmp = tcg_temp_new();
+        tmp = tcg_temp_new_i64();
         tcg_gen_andi_i64(tmp, reg, ctx->is_pa20 ? 63 : 31);
         save_or_nullify(ctx, cpu_sar, tmp);
 
@@ -2076,7 +2078,7 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
     case CR_IIAOQ:
         /* FIXME: Respect PSW_Q bit */
         /* The write advances the queue and stores to the back element.  */
-        tmp = tcg_temp_new();
+        tmp = tcg_temp_new_i64();
         tcg_gen_ld_i64(tmp, tcg_env,
                        offsetof(CPUHPPAState, cr_back[ctl - CR_IIASQ]));
         tcg_gen_st_i64(tmp, tcg_env, offsetof(CPUHPPAState, cr[ctl]));
@@ -2104,7 +2106,7 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
 
 static bool trans_mtsarcm(DisasContext *ctx, arg_mtsarcm *a)
 {
-    TCGv_i64 tmp = tcg_temp_new();
+    TCGv_i64 tmp = tcg_temp_new_i64();
 
     tcg_gen_not_i64(tmp, load_gpr(ctx, a->r));
     tcg_gen_andi_i64(tmp, tmp, ctx->is_pa20 ? 63 : 31);
@@ -2139,7 +2141,7 @@ static bool trans_rsm(DisasContext *ctx, arg_rsm *a)
 
     nullify_over(ctx);
 
-    tmp = tcg_temp_new();
+    tmp = tcg_temp_new_i64();
     tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
     tcg_gen_andi_i64(tmp, tmp, ~a->i);
     gen_helper_swap_system_mask(tmp, tcg_env, tmp);
@@ -2159,7 +2161,7 @@ static bool trans_ssm(DisasContext *ctx, arg_ssm *a)
 
     nullify_over(ctx);
 
-    tmp = tcg_temp_new();
+    tmp = tcg_temp_new_i64();
     tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
     tcg_gen_ori_i64(tmp, tmp, a->i);
     gen_helper_swap_system_mask(tmp, tcg_env, tmp);
@@ -2179,7 +2181,7 @@ static bool trans_mtsm(DisasContext *ctx, arg_mtsm *a)
     nullify_over(ctx);
 
     reg = load_gpr(ctx, a->r);
-    tmp = tcg_temp_new();
+    tmp = tcg_temp_new_i64();
     gen_helper_swap_system_mask(tmp, tcg_env, reg);
 
     /* Exit the TB to recognize new interrupts.  */
@@ -2434,7 +2436,7 @@ static bool trans_lpa(DisasContext *ctx, arg_ldst *a)
 
     form_gva(ctx, &vaddr, &ofs, a->b, a->x, 0, 0, a->sp, a->m, false);
 
-    paddr = tcg_temp_new();
+    paddr = tcg_temp_new_i64();
     gen_helper_lpa(paddr, tcg_env, vaddr);
 
     /* Note that physical address result overrides base modification.  */
@@ -2618,7 +2620,7 @@ static bool do_uaddcm(DisasContext *ctx, arg_rrr_cf_d *a, bool is_tc)
     }
     tcg_r1 = load_gpr(ctx, a->r1);
     tcg_r2 = load_gpr(ctx, a->r2);
-    tmp = tcg_temp_new();
+    tmp = tcg_temp_new_i64();
     tcg_gen_not_i64(tmp, tcg_r2);
     do_unit(ctx, a->t, tcg_r1, tmp, a->cf, a->d, is_tc, tcg_gen_add_i64);
     return nullify_end(ctx);
@@ -2640,7 +2642,7 @@ static bool do_dcor(DisasContext *ctx, arg_rr_cf_d *a, bool is_i)
 
     nullify_over(ctx);
 
-    tmp = tcg_temp_new();
+    tmp = tcg_temp_new_i64();
     tcg_gen_shri_i64(tmp, cpu_psw_cb, 3);
     if (!is_i) {
         tcg_gen_not_i64(tmp, tmp);
@@ -2672,10 +2674,10 @@ static bool trans_ds(DisasContext *ctx, arg_rrr_cf *a)
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
@@ -2798,7 +2800,7 @@ static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
     if (a->m) {
         /* Base register modification.  Make sure if RT == RB,
            we see the result of the load.  */
-        dest = tcg_temp_new();
+        dest = tcg_temp_new_i64();
     } else {
         dest = dest_gpr(ctx, a->t);
     }
@@ -2958,7 +2960,7 @@ static bool do_cmpb(DisasContext *ctx, unsigned r, TCGv_i64 in1,
     DisasCond cond;
 
     in2 = load_gpr(ctx, r);
-    dest = tcg_temp_new();
+    dest = tcg_temp_new_i64();
 
     tcg_gen_sub_i64(dest, in1, in2);
 
@@ -3010,13 +3012,13 @@ static bool do_addb(DisasContext *ctx, unsigned r, TCGv_i64 in1,
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
@@ -3054,7 +3056,7 @@ static bool trans_bb_sar(DisasContext *ctx, arg_bb_sar *a)
 
     nullify_over(ctx);
 
-    tmp = tcg_temp_new();
+    tmp = tcg_temp_new_i64();
     tcg_r = load_gpr(ctx, a->r);
     if (cond_need_ext(ctx, a->d)) {
         /* Force shift into [32,63] */
@@ -3076,7 +3078,7 @@ static bool trans_bb_imm(DisasContext *ctx, arg_bb_imm *a)
 
     nullify_over(ctx);
 
-    tmp = tcg_temp_new();
+    tmp = tcg_temp_new_i64();
     tcg_r = load_gpr(ctx, a->r);
     p = a->p | (cond_need_ext(ctx, a->d) ? 32 : 0);
     tcg_gen_shli_i64(tmp, tcg_r, p);
@@ -3136,7 +3138,7 @@ static bool trans_shrp_sar(DisasContext *ctx, arg_shrp_sar *a)
         if (a->d) {
             tcg_gen_shr_i64(dest, src2, cpu_sar);
         } else {
-            TCGv_i64 tmp = tcg_temp_new();
+            TCGv_i64 tmp = tcg_temp_new_i64();
 
             tcg_gen_ext32u_i64(dest, src2);
             tcg_gen_andi_i64(tmp, cpu_sar, 31);
@@ -3159,8 +3161,8 @@ static bool trans_shrp_sar(DisasContext *ctx, arg_shrp_sar *a)
         TCGv_i64 src1 = load_gpr(ctx, a->r1);
 
         if (a->d) {
-            TCGv_i64 t = tcg_temp_new();
-            TCGv_i64 n = tcg_temp_new();
+            TCGv_i64 t = tcg_temp_new_i64();
+            TCGv_i64 n = tcg_temp_new_i64();
 
             tcg_gen_xori_i64(n, cpu_sar, 63);
             tcg_gen_shl_i64(t, src2, n);
@@ -3243,7 +3245,7 @@ static bool trans_extr_sar(DisasContext *ctx, arg_extr_sar *a)
 
     dest = dest_gpr(ctx, a->t);
     src = load_gpr(ctx, a->r);
-    tmp = tcg_temp_new();
+    tmp = tcg_temp_new_i64();
 
     /* Recall that SAR is using big-endian bit numbering.  */
     tcg_gen_andi_i64(tmp, cpu_sar, widthm1);
@@ -3395,14 +3397,14 @@ static bool do_dep_sar(DisasContext *ctx, unsigned rt, unsigned c,
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
@@ -3467,7 +3469,7 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
     nullify_over(ctx);
 #endif
 
-    tmp = tcg_temp_new();
+    tmp = tcg_temp_new_i64();
     tcg_gen_addi_i64(tmp, load_gpr(ctx, a->b), a->disp);
     tmp = do_ibranch_priv(ctx, tmp);
 
@@ -3565,7 +3567,7 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
 static bool trans_blr(DisasContext *ctx, arg_blr *a)
 {
     if (a->x) {
-        TCGv_i64 tmp = tcg_temp_new();
+        TCGv_i64 tmp = tcg_temp_new_i64();
         tcg_gen_shli_i64(tmp, load_gpr(ctx, a->x), 3);
         tcg_gen_addi_i64(tmp, tmp, ctx->iaoq_f + 8);
         /* The computation here never changes privilege level.  */
@@ -3583,7 +3585,7 @@ static bool trans_bv(DisasContext *ctx, arg_bv *a)
     if (a->x == 0) {
         dest = load_gpr(ctx, a->b);
     } else {
-        dest = tcg_temp_new();
+        dest = tcg_temp_new_i64();
         tcg_gen_shli_i64(dest, load_gpr(ctx, a->x), 3);
         tcg_gen_add_i64(dest, dest, load_gpr(ctx, a->b));
     }
@@ -3920,7 +3922,7 @@ static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
 
     nullify_over(ctx);
 
-    t = tcg_temp_new();
+    t = tcg_temp_new_i64();
     tcg_gen_ld32u_i64(t, tcg_env, offsetof(CPUHPPAState, fr0_shadow));
 
     if (a->y == 1) {
@@ -4222,7 +4224,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
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


