Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3FC7DEA36
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:38:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMbs-00075c-Ew; Wed, 01 Nov 2023 21:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbA-0006YS-3J
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:17 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMb5-0001yA-Mk
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:15 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5b7f3f470a9so330195a12.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888850; x=1699493650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Aq/Lxt9rxYKknv7LZ2TP65EWgsQ32uEGBivTsfXbT4=;
 b=IEockq/u86SxQTdTi+/sB0FP2NNeuSjfzuj7zGb+Hx/7Jdxsi6V6ixpzkaY6hcrrd8
 2seHWDFvg050pSVLx2cMXcGFIGbgdrlcBMe1KhhzVgmXFYKAgBjOyzax8NTxirGZtB8U
 +fF4OB33Y/Y357o0PBJV0qOaPiBdV9EHulapB0yKk/0nWHLRxvl9TMhjf/AI/ucevfLU
 Nk12A+PkpHfW3LjMDRU95msOo4KaFljvRFiq0HdFdyWq1fUeycVgjKUB43Rwp2fkGWBV
 iaVdbgcLuVXu652/gv5Ec5hXTf6+Hqb8YWPCXGATqcBifvhh+N14dgwlmtfrPekRh0HO
 sKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888850; x=1699493650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Aq/Lxt9rxYKknv7LZ2TP65EWgsQ32uEGBivTsfXbT4=;
 b=LZXtA/mPiuHvXnFHeR1Zl2Wye58aG/7hKcdIq+tg6s2DwRFoVOFNiqfB3vx61qonoH
 Hrm5/VrM9VcCe5Fe9DAuXozmjpIgIrmfj2x32/vsukcTXqPKhHUkDgfblS4vq+AT+fEe
 bL1lYRe+BJccgwFN2VVamcD2XxdU3HlATlE0XfcODWKV5hu7pcTFUSAXs2F6tltSQBxD
 MB+YkgcDN7Fm0cEnamOdwJwWmp196cBkgo5iAFP8VW5uBPnfs87tk1gRScptFAouRzNE
 ypqhTG0aWYgsPiuR9qO91k7liJSfNCJkouAmLPdJnxNNv/p/MzFb1t1JRDeTFfl8JiKE
 8iLg==
X-Gm-Message-State: AOJu0Ywmw6SMhIMI7tVkRBi8fa6hDJPVo3CIxzw/yBFQAc+n/2bQOwtF
 XUcnAeqr69E8By3e2pLUbW0pR7kM1NDnee5aaUE=
X-Google-Smtp-Source: AGHT+IF0tLiam8v0NrNqV32H9eqUQwf7z0uxeVdzwXDrEK/JpmgwDM/veAGv8gyUzqJa0gKbJujwnw==
X-Received: by 2002:a05:6a20:4414:b0:181:9518:5aae with SMTP id
 ce20-20020a056a20441400b0018195185aaemr866607pzb.10.1698888850149; 
 Wed, 01 Nov 2023 18:34:10 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:34:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 61/88] target/hppa: Use tcg_temp_new_i64 not tcg_temp_new
Date: Wed,  1 Nov 2023 18:29:49 -0700
Message-Id: <20231102013016.369010-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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
index ce8d812e04..59d172f355 100644
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
@@ -2955,7 +2957,7 @@ static bool do_cmpb(DisasContext *ctx, unsigned r, TCGv_i64 in1,
     DisasCond cond;
 
     in2 = load_gpr(ctx, r);
-    dest = tcg_temp_new();
+    dest = tcg_temp_new_i64();
 
     tcg_gen_sub_i64(dest, in1, in2);
 
@@ -3007,13 +3009,13 @@ static bool do_addb(DisasContext *ctx, unsigned r, TCGv_i64 in1,
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
@@ -3051,7 +3053,7 @@ static bool trans_bb_sar(DisasContext *ctx, arg_bb_sar *a)
 
     nullify_over(ctx);
 
-    tmp = tcg_temp_new();
+    tmp = tcg_temp_new_i64();
     tcg_r = load_gpr(ctx, a->r);
     if (cond_need_ext(ctx, a->d)) {
         /* Force shift into [32,63] */
@@ -3073,7 +3075,7 @@ static bool trans_bb_imm(DisasContext *ctx, arg_bb_imm *a)
 
     nullify_over(ctx);
 
-    tmp = tcg_temp_new();
+    tmp = tcg_temp_new_i64();
     tcg_r = load_gpr(ctx, a->r);
     p = a->p | (cond_need_ext(ctx, a->d) ? 32 : 0);
     tcg_gen_shli_i64(tmp, tcg_r, p);
@@ -3133,7 +3135,7 @@ static bool trans_shrp_sar(DisasContext *ctx, arg_shrp_sar *a)
         if (a->d) {
             tcg_gen_shr_i64(dest, src2, cpu_sar);
         } else {
-            TCGv_i64 tmp = tcg_temp_new();
+            TCGv_i64 tmp = tcg_temp_new_i64();
 
             tcg_gen_ext32u_i64(dest, src2);
             tcg_gen_andi_i64(tmp, cpu_sar, 31);
@@ -3156,8 +3158,8 @@ static bool trans_shrp_sar(DisasContext *ctx, arg_shrp_sar *a)
         TCGv_i64 src1 = load_gpr(ctx, a->r1);
 
         if (a->d) {
-            TCGv_i64 t = tcg_temp_new();
-            TCGv_i64 n = tcg_temp_new();
+            TCGv_i64 t = tcg_temp_new_i64();
+            TCGv_i64 n = tcg_temp_new_i64();
 
             tcg_gen_xori_i64(n, cpu_sar, 63);
             tcg_gen_shl_i64(t, src2, n);
@@ -3240,7 +3242,7 @@ static bool trans_extr_sar(DisasContext *ctx, arg_extr_sar *a)
 
     dest = dest_gpr(ctx, a->t);
     src = load_gpr(ctx, a->r);
-    tmp = tcg_temp_new();
+    tmp = tcg_temp_new_i64();
 
     /* Recall that SAR is using big-endian bit numbering.  */
     tcg_gen_andi_i64(tmp, cpu_sar, widthm1);
@@ -3392,14 +3394,14 @@ static bool do_dep_sar(DisasContext *ctx, unsigned rt, unsigned c,
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
@@ -3464,7 +3466,7 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
     nullify_over(ctx);
 #endif
 
-    tmp = tcg_temp_new();
+    tmp = tcg_temp_new_i64();
     tcg_gen_addi_i64(tmp, load_gpr(ctx, a->b), a->disp);
     tmp = do_ibranch_priv(ctx, tmp);
 
@@ -3562,7 +3564,7 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
 static bool trans_blr(DisasContext *ctx, arg_blr *a)
 {
     if (a->x) {
-        TCGv_i64 tmp = tcg_temp_new();
+        TCGv_i64 tmp = tcg_temp_new_i64();
         tcg_gen_shli_i64(tmp, load_gpr(ctx, a->x), 3);
         tcg_gen_addi_i64(tmp, tmp, ctx->iaoq_f + 8);
         /* The computation here never changes privilege level.  */
@@ -3580,7 +3582,7 @@ static bool trans_bv(DisasContext *ctx, arg_bv *a)
     if (a->x == 0) {
         dest = load_gpr(ctx, a->b);
     } else {
-        dest = tcg_temp_new();
+        dest = tcg_temp_new_i64();
         tcg_gen_shli_i64(dest, load_gpr(ctx, a->x), 3);
         tcg_gen_add_i64(dest, dest, load_gpr(ctx, a->b));
     }
@@ -3917,7 +3919,7 @@ static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
 
     nullify_over(ctx);
 
-    t = tcg_temp_new();
+    t = tcg_temp_new_i64();
     tcg_gen_ld32u_i64(t, tcg_env, offsetof(CPUHPPAState, fr0_shadow));
 
     if (a->y == 1) {
@@ -4219,7 +4221,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
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


