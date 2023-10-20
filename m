Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE117D1760
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:48:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwLq-0007oL-TV; Fri, 20 Oct 2023 16:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLL-0007ft-St
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:39 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLJ-00088H-Mz
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:39 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6bd0e1b1890so1095352b3a.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834616; x=1698439416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EEVa0UToFhXataikrG28OSq2vCy6h8vLUqtzrSHrlk8=;
 b=FiHA/uDIV9XFAaj/zdJdSGoX9N3o6t0QR/JKVxJ7t5lYAvXGCpHAlAi7keRiYBCuS3
 P0baMmmC3SBR1lSn3MSrDCDQrqizc8GOt1ftrQAb0vcWtVEpeJ+nTSVHylyVvXtJgnP2
 FtUbPMGgoQTFd5r6c4HsJaRuuCD9kyYZkKay8kdPej5hbd5XfNxIg7CeD8wlanNVvaQZ
 7xQYK2rUEv3tgA219/BRt1yuT80ryOLcSq+7vTyR5wxEwy1psDv1ZofZtGt/Z4UiODPE
 FD5zF+QhxxEOSWaArdwg9MEZE0hvwZUSQUSzjtp9nT+fPrciM6alcZCwmjs3Mio+a5nw
 Er1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834616; x=1698439416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EEVa0UToFhXataikrG28OSq2vCy6h8vLUqtzrSHrlk8=;
 b=gNaRuw+SUG8oYRmzip9UQh4InYorUHVdW51ALXFyEC6NW59O+ZE7pmMCeMCr4B7vJh
 ABeg6QaSky0rXp0zz7MQt+oqO48/+HNzcwUdPIFyaMhIZ9U1pQnlkOc6MvwumeiYV3nm
 BrK3UQ1nFWgR9j3NX1t/0jIyCdhCr5IWvgyb9aTu5TtOjFCJZ26nrZt6PQlTa49mzae2
 9dupmWU1oWrU3SAwGka6mu6gEg6zsMTeewLReLX6BgjNFx0rY+9GtsoRwwTQeId0Inax
 RQ/LPi3sNR1bU9Ja+d/VDjGVR5AWJh3u8gwQlCuu5XqemFN8k4TJT7zPAeCwyMy4IXWy
 BjVA==
X-Gm-Message-State: AOJu0YwBOunYQ5ZRnbTB7/egF1s8SZiK5bd2D10NhZoOjprEo9uKCt94
 w9M38NQgnY6DUSeZ/km6SyqUzejXQ5yizFVver4=
X-Google-Smtp-Source: AGHT+IHBySjp39F5QRjMzZcRNV5AnkAKKw5Fjd+Cf5YPZ9KqiQ11w6o2tT+71q7/IPvcbvM1u1t97w==
X-Received: by 2002:a05:6a00:194c:b0:6b7:18c1:c09a with SMTP id
 s12-20020a056a00194c00b006b718c1c09amr2737723pfk.5.1697834616278; 
 Fri, 20 Oct 2023 13:43:36 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 03/65] target/hppa: Remove get_temp
Date: Fri, 20 Oct 2023 13:42:29 -0700
Message-Id: <20231020204331.139847-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Replace with tcg_temp_new without recording into ctx.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 76 +++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 45 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 9f3ba9f42f..3065fbf625 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -254,8 +254,7 @@ typedef struct DisasContext {
     target_ureg iaoq_n;
     TCGv_reg iaoq_n_var;
 
-    int ntempr, ntempl;
-    TCGv_reg tempr[8];
+    int ntempl;
     TCGv_tl  templ[4];
 
     DisasCond null_cond;
@@ -492,13 +491,6 @@ static void cond_free(DisasCond *cond)
     }
 }
 
-static TCGv_reg get_temp(DisasContext *ctx)
-{
-    unsigned i = ctx->ntempr++;
-    g_assert(i < ARRAY_SIZE(ctx->tempr));
-    return ctx->tempr[i] = tcg_temp_new();
-}
-
 #ifndef CONFIG_USER_ONLY
 static TCGv_tl get_temp_tl(DisasContext *ctx)
 {
@@ -510,7 +502,7 @@ static TCGv_tl get_temp_tl(DisasContext *ctx)
 
 static TCGv_reg load_const(DisasContext *ctx, target_sreg v)
 {
-    TCGv_reg t = get_temp(ctx);
+    TCGv_reg t = tcg_temp_new();
     tcg_gen_movi_reg(t, v);
     return t;
 }
@@ -518,7 +510,7 @@ static TCGv_reg load_const(DisasContext *ctx, target_sreg v)
 static TCGv_reg load_gpr(DisasContext *ctx, unsigned reg)
 {
     if (reg == 0) {
-        TCGv_reg t = get_temp(ctx);
+        TCGv_reg t = tcg_temp_new();
         tcg_gen_movi_reg(t, 0);
         return t;
     } else {
@@ -529,7 +521,7 @@ static TCGv_reg load_gpr(DisasContext *ctx, unsigned reg)
 static TCGv_reg dest_gpr(DisasContext *ctx, unsigned reg)
 {
     if (reg == 0 || ctx->null_cond.c != TCG_COND_NEVER) {
-        return get_temp(ctx);
+        return tcg_temp_new();
     } else {
         return cpu_gr[reg];
     }
@@ -1071,7 +1063,7 @@ static DisasCond do_unit_cond(unsigned cf, TCGv_reg res,
 static TCGv_reg do_add_sv(DisasContext *ctx, TCGv_reg res,
                           TCGv_reg in1, TCGv_reg in2)
 {
-    TCGv_reg sv = get_temp(ctx);
+    TCGv_reg sv = tcg_temp_new();
     TCGv_reg tmp = tcg_temp_new();
 
     tcg_gen_xor_reg(sv, res, in1);
@@ -1085,7 +1077,7 @@ static TCGv_reg do_add_sv(DisasContext *ctx, TCGv_reg res,
 static TCGv_reg do_sub_sv(DisasContext *ctx, TCGv_reg res,
                           TCGv_reg in1, TCGv_reg in2)
 {
-    TCGv_reg sv = get_temp(ctx);
+    TCGv_reg sv = tcg_temp_new();
     TCGv_reg tmp = tcg_temp_new();
 
     tcg_gen_xor_reg(sv, res, in1);
@@ -1108,20 +1100,20 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     cb_msb = NULL;
 
     if (shift) {
-        tmp = get_temp(ctx);
+        tmp = tcg_temp_new();
         tcg_gen_shli_reg(tmp, in1, shift);
         in1 = tmp;
     }
 
     if (!is_l || cond_need_cb(c)) {
         TCGv_reg zero = tcg_constant_reg(0);
-        cb_msb = get_temp(ctx);
+        cb_msb = tcg_temp_new();
         tcg_gen_add2_reg(dest, cb_msb, in1, zero, in2, zero);
         if (is_c) {
             tcg_gen_add2_reg(dest, cb_msb, dest, cb_msb, cpu_psw_cb_msb, zero);
         }
         if (!is_l) {
-            cb = get_temp(ctx);
+            cb = tcg_temp_new();
             tcg_gen_xor_reg(cb, in1, in2);
             tcg_gen_xor_reg(cb, cb, dest);
         }
@@ -1414,11 +1406,11 @@ static void form_gva(DisasContext *ctx, TCGv_tl *pgva, TCGv_reg *pofs,
 
     /* Note that RX is mutually exclusive with DISP.  */
     if (rx) {
-        ofs = get_temp(ctx);
+        ofs = tcg_temp_new();
         tcg_gen_shli_reg(ofs, cpu_gr[rx], scale);
         tcg_gen_add_reg(ofs, ofs, base);
     } else if (disp || modify) {
-        ofs = get_temp(ctx);
+        ofs = tcg_temp_new();
         tcg_gen_addi_reg(ofs, base, disp);
     } else {
         ofs = base;
@@ -1538,7 +1530,7 @@ static bool do_load(DisasContext *ctx, unsigned rt, unsigned rb,
         dest = dest_gpr(ctx, rt);
     } else {
         /* Make sure if RT == RB, we see the result of the load.  */
-        dest = get_temp(ctx);
+        dest = tcg_temp_new();
     }
     do_load_reg(ctx, dest, rb, rx, scale, disp, sp, modify, mop);
     save_gpr(ctx, rt, dest);
@@ -1854,7 +1846,7 @@ static bool do_ibranch(DisasContext *ctx, TCGv_reg dest,
         if (link != 0) {
             copy_iaoq_entry(cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
         }
-        next = get_temp(ctx);
+        next = tcg_temp_new();
         tcg_gen_mov_reg(next, dest);
         if (is_n) {
             if (use_nullify_skip(ctx)) {
@@ -1896,7 +1888,7 @@ static bool do_ibranch(DisasContext *ctx, TCGv_reg dest,
         a1 = ctx->null_cond.a1;
 
         tmp = tcg_temp_new();
-        next = get_temp(ctx);
+        next = tcg_temp_new();
 
         copy_iaoq_entry(tmp, ctx->iaoq_n, ctx->iaoq_n_var);
         tcg_gen_movcond_reg(c, next, a0, a1, tmp, dest);
@@ -1938,11 +1930,11 @@ static TCGv_reg do_ibranch_priv(DisasContext *ctx, TCGv_reg offset)
         return offset;
     case 3:
         /* Privilege 3 is minimum and is never allowed to increase.  */
-        dest = get_temp(ctx);
+        dest = tcg_temp_new();
         tcg_gen_ori_reg(dest, offset, 3);
         break;
     default:
-        dest = get_temp(ctx);
+        dest = tcg_temp_new();
         tcg_gen_andi_reg(dest, offset, -4);
         tcg_gen_ori_reg(dest, dest, ctx->privilege);
         tcg_gen_movcond_reg(TCG_COND_GTU, dest, dest, offset, dest, offset);
@@ -2104,7 +2096,7 @@ static bool trans_mfctl(DisasContext *ctx, arg_mfctl *a)
         break;
     }
 
-    tmp = get_temp(ctx);
+    tmp = tcg_temp_new();
     tcg_gen_ld_reg(tmp, tcg_env, offsetof(CPUHPPAState, cr[ctl]));
     save_gpr(ctx, rt, tmp);
 
@@ -2177,7 +2169,7 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
     case CR_IIAOQ:
         /* FIXME: Respect PSW_Q bit */
         /* The write advances the queue and stores to the back element.  */
-        tmp = get_temp(ctx);
+        tmp = tcg_temp_new();
         tcg_gen_ld_reg(tmp, tcg_env,
                        offsetof(CPUHPPAState, cr_back[ctl - CR_IIASQ]));
         tcg_gen_st_reg(tmp, tcg_env, offsetof(CPUHPPAState, cr[ctl]));
@@ -2243,7 +2235,7 @@ static bool trans_rsm(DisasContext *ctx, arg_rsm *a)
 
     nullify_over(ctx);
 
-    tmp = get_temp(ctx);
+    tmp = tcg_temp_new();
     tcg_gen_ld_reg(tmp, tcg_env, offsetof(CPUHPPAState, psw));
     tcg_gen_andi_reg(tmp, tmp, ~a->i);
     gen_helper_swap_system_mask(tmp, tcg_env, tmp);
@@ -2263,7 +2255,7 @@ static bool trans_ssm(DisasContext *ctx, arg_ssm *a)
 
     nullify_over(ctx);
 
-    tmp = get_temp(ctx);
+    tmp = tcg_temp_new();
     tcg_gen_ld_reg(tmp, tcg_env, offsetof(CPUHPPAState, psw));
     tcg_gen_ori_reg(tmp, tmp, a->i);
     gen_helper_swap_system_mask(tmp, tcg_env, tmp);
@@ -2283,7 +2275,7 @@ static bool trans_mtsm(DisasContext *ctx, arg_mtsm *a)
     nullify_over(ctx);
 
     reg = load_gpr(ctx, a->r);
-    tmp = get_temp(ctx);
+    tmp = tcg_temp_new();
     gen_helper_swap_system_mask(tmp, tcg_env, reg);
 
     /* Exit the TB to recognize new interrupts.  */
@@ -2692,7 +2684,7 @@ static bool do_uaddcm(DisasContext *ctx, arg_rrr_cf *a, bool is_tc)
     }
     tcg_r1 = load_gpr(ctx, a->r1);
     tcg_r2 = load_gpr(ctx, a->r2);
-    tmp = get_temp(ctx);
+    tmp = tcg_temp_new();
     tcg_gen_not_reg(tmp, tcg_r2);
     do_unit(ctx, a->t, tcg_r1, tmp, a->cf, is_tc, tcg_gen_add_reg);
     return nullify_end(ctx);
@@ -2714,7 +2706,7 @@ static bool do_dcor(DisasContext *ctx, arg_rr_cf *a, bool is_i)
 
     nullify_over(ctx);
 
-    tmp = get_temp(ctx);
+    tmp = tcg_temp_new();
     tcg_gen_shri_reg(tmp, cpu_psw_cb, 3);
     if (!is_i) {
         tcg_gen_not_reg(tmp, tmp);
@@ -2866,7 +2858,7 @@ static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
     if (a->m) {
         /* Base register modification.  Make sure if RT == RB,
            we see the result of the load.  */
-        dest = get_temp(ctx);
+        dest = tcg_temp_new();
     } else {
         dest = dest_gpr(ctx, a->t);
     }
@@ -2992,7 +2984,7 @@ static bool do_cmpb(DisasContext *ctx, unsigned r, TCGv_reg in1,
     DisasCond cond;
 
     in2 = load_gpr(ctx, r);
-    dest = get_temp(ctx);
+    dest = tcg_temp_new();
 
     tcg_gen_sub_reg(dest, in1, in2);
 
@@ -3029,7 +3021,7 @@ static bool do_addb(DisasContext *ctx, unsigned r, TCGv_reg in1,
     cb_msb = NULL;
 
     if (cond_need_cb(c)) {
-        cb_msb = get_temp(ctx);
+        cb_msb = tcg_temp_new();
         tcg_gen_movi_reg(cb_msb, 0);
         tcg_gen_add2_reg(dest, cb_msb, in1, cb_msb, in2, cb_msb);
     } else {
@@ -3388,7 +3380,7 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
     nullify_over(ctx);
 #endif
 
-    tmp = get_temp(ctx);
+    tmp = tcg_temp_new();
     tcg_gen_addi_reg(tmp, load_gpr(ctx, a->b), a->disp);
     tmp = do_ibranch_priv(ctx, tmp);
 
@@ -3485,7 +3477,7 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
 static bool trans_blr(DisasContext *ctx, arg_blr *a)
 {
     if (a->x) {
-        TCGv_reg tmp = get_temp(ctx);
+        TCGv_reg tmp = tcg_temp_new();
         tcg_gen_shli_reg(tmp, load_gpr(ctx, a->x), 3);
         tcg_gen_addi_reg(tmp, tmp, ctx->iaoq_f + 8);
         /* The computation here never changes privilege level.  */
@@ -3503,7 +3495,7 @@ static bool trans_bv(DisasContext *ctx, arg_bv *a)
     if (a->x == 0) {
         dest = load_gpr(ctx, a->b);
     } else {
-        dest = get_temp(ctx);
+        dest = tcg_temp_new();
         tcg_gen_shli_reg(dest, load_gpr(ctx, a->x), 3);
         tcg_gen_add_reg(dest, dest, load_gpr(ctx, a->b));
     }
@@ -3834,7 +3826,7 @@ static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
 
     nullify_over(ctx);
 
-    t = get_temp(ctx);
+    t = tcg_temp_new();
     tcg_gen_ld32u_reg(t, tcg_env, offsetof(CPUHPPAState, fr0_shadow));
 
     if (a->y == 1) {
@@ -4089,9 +4081,7 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     bound = -(ctx->base.pc_first | TARGET_PAGE_MASK) / 4;
     ctx->base.max_insns = MIN(ctx->base.max_insns, bound);
 
-    ctx->ntempr = 0;
     ctx->ntempl = 0;
-    memset(ctx->tempr, 0, sizeof(ctx->tempr));
     memset(ctx->templ, 0, sizeof(ctx->templ));
 }
 
@@ -4140,7 +4130,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
            This will be overwritten by a branch.  */
         if (ctx->iaoq_b == -1) {
             ctx->iaoq_n = -1;
-            ctx->iaoq_n_var = get_temp(ctx);
+            ctx->iaoq_n_var = tcg_temp_new();
             tcg_gen_addi_reg(ctx->iaoq_n_var, cpu_iaoq_b, 4);
         } else {
             ctx->iaoq_n = ctx->iaoq_b + 4;
@@ -4161,13 +4151,9 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     }
 
     /* Forget any temporaries allocated.  */
-    for (i = 0, n = ctx->ntempr; i < n; ++i) {
-        ctx->tempr[i] = NULL;
-    }
     for (i = 0, n = ctx->ntempl; i < n; ++i) {
         ctx->templ[i] = NULL;
     }
-    ctx->ntempr = 0;
     ctx->ntempl = 0;
 
     /* Advance the insn queue.  Note that this check also detects
-- 
2.34.1


