Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D88C67DEA32
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:38:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMcc-0000I2-Jt; Wed, 01 Nov 2023 21:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMb8-0006Xr-BE
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:14 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMb3-0001xq-MU
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:14 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cc58219376so3532455ad.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888848; x=1699493648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VuQ71Pxz42WxQSpC4yJP9ZvlGKvcjABn91g+jcEZ5UI=;
 b=CNrSdF5ue5Fw57Wbk1cq5zUHhJzyXVahhZDoYoza8OFe2FotPsyB0wqZiJbHKY04wa
 D0G381o95PZ3CSSwM8M182aYFa4lXgE1LtiMlc8fo/Jbxhq1v6BaK527Dn2y1Lo+nnFq
 kITVzWmXX6DIkuRSnHALXjKvBgbPXuCj/oopRGkcfziuUckl5Q1QqwgBnkILmy8WAwAH
 gK7r/ad0qbFRbkZjGvco+ND9bSS57Y7JWLDVbrG0tYx2c4NNgMd+hVFNDIavLVcznUys
 Q25KHhcYL5syby8ubr/0C80OISWT2oIcN3Sru23Cg1vHFK+/DrfxZcf1clCfB/peoLo9
 XnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888848; x=1699493648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VuQ71Pxz42WxQSpC4yJP9ZvlGKvcjABn91g+jcEZ5UI=;
 b=GlwCfw3f2hONopfGtMKiLK6BVVZwQd7cDBtrUVEA5/IDNchcXwEKfQ3DMljQuC5m3C
 TNpCETscIUQaK1EC8sUSaNGQdFm9yjeJXjeSzK8nIsa+u3dGFyi1cNHkGV6v3ntz3nkM
 xoKEyEJ/WQHf7U7DSoQVjCv+4ik221ugWwmDyUmelE8vuOrajcl9GoP8atMshUzymfrM
 ZRH+UhcNTSRlFqDN95jHBDuDEEHL7GijiJmGWC0i/Py/XgjKOIYMVCqlSwtT56G41Mod
 +wa8/HJUL8v7QKF4YEkKTELSHFmNZ4rRI57isMu1d+nmIkiEPzeaek/oC0Je58XJbUQl
 jK0g==
X-Gm-Message-State: AOJu0Yw2yOsqovydOUJll6atSbqm4BVFzeTVYvcs/19jOdp67m+ozBwA
 V1ncU3BBrU1mLmVgDgCRin7+5OllYfD0VGIKMNM=
X-Google-Smtp-Source: AGHT+IFsR8bwZDlmIiK96YCrKDIbyoO+68EKMQgjFvNPNwoE34N89N9KKx0WQK4eGqBiHDLb19tXOQ==
X-Received: by 2002:a17:903:48f:b0:1cc:3544:ea41 with SMTP id
 jj15-20020a170903048f00b001cc3544ea41mr13121840plb.46.1698888848090; 
 Wed, 01 Nov 2023 18:34:08 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:34:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 58/88] target/hppa: Remove most of the TARGET_REGISTER_BITS
 redirections
Date: Wed,  1 Nov 2023 18:29:46 -0700
Message-Id: <20231102013016.369010-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Remove all but those intended to change type to or from i64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 910 ++++++++++++++++++----------------------
 1 file changed, 406 insertions(+), 504 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 2c3e114b86..520a375e3a 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -36,110 +36,15 @@
 /* Since we have a distinction between register size and address size,
    we need to redefine all of these.  */
 
-#undef TCGv
-#undef tcg_temp_new
-#undef tcg_global_mem_new
-
-#define TCGv_tl              TCGv_i64
-#define tcg_temp_new_tl      tcg_temp_new_i64
 #define tcg_gen_extu_reg_tl  tcg_gen_mov_i64
-
-#define TCGv_reg             TCGv_i64
-
-#define tcg_temp_new         tcg_temp_new_i64
-#define tcg_global_mem_new   tcg_global_mem_new_i64
-
-#define tcg_gen_movi_reg     tcg_gen_movi_i64
-#define tcg_gen_mov_reg      tcg_gen_mov_i64
-#define tcg_gen_ld8u_reg     tcg_gen_ld8u_i64
-#define tcg_gen_ld8s_reg     tcg_gen_ld8s_i64
-#define tcg_gen_ld16u_reg    tcg_gen_ld16u_i64
-#define tcg_gen_ld16s_reg    tcg_gen_ld16s_i64
-#define tcg_gen_ld32u_reg    tcg_gen_ld32u_i64
-#define tcg_gen_ld32s_reg    tcg_gen_ld32s_i64
-#define tcg_gen_ld_reg       tcg_gen_ld_i64
-#define tcg_gen_st8_reg      tcg_gen_st8_i64
-#define tcg_gen_st16_reg     tcg_gen_st16_i64
-#define tcg_gen_st32_reg     tcg_gen_st32_i64
-#define tcg_gen_st_reg       tcg_gen_st_i64
-#define tcg_gen_add_reg      tcg_gen_add_i64
-#define tcg_gen_addi_reg     tcg_gen_addi_i64
-#define tcg_gen_sub_reg      tcg_gen_sub_i64
-#define tcg_gen_neg_reg      tcg_gen_neg_i64
-#define tcg_gen_subfi_reg    tcg_gen_subfi_i64
-#define tcg_gen_subi_reg     tcg_gen_subi_i64
-#define tcg_gen_and_reg      tcg_gen_and_i64
-#define tcg_gen_andi_reg     tcg_gen_andi_i64
-#define tcg_gen_or_reg       tcg_gen_or_i64
-#define tcg_gen_ori_reg      tcg_gen_ori_i64
-#define tcg_gen_xor_reg      tcg_gen_xor_i64
-#define tcg_gen_xori_reg     tcg_gen_xori_i64
-#define tcg_gen_not_reg      tcg_gen_not_i64
-#define tcg_gen_shl_reg      tcg_gen_shl_i64
-#define tcg_gen_shli_reg     tcg_gen_shli_i64
-#define tcg_gen_shr_reg      tcg_gen_shr_i64
-#define tcg_gen_shri_reg     tcg_gen_shri_i64
-#define tcg_gen_sar_reg      tcg_gen_sar_i64
-#define tcg_gen_sari_reg     tcg_gen_sari_i64
-#define tcg_gen_brcond_reg   tcg_gen_brcond_i64
-#define tcg_gen_brcondi_reg  tcg_gen_brcondi_i64
-#define tcg_gen_setcond_reg  tcg_gen_setcond_i64
-#define tcg_gen_setcondi_reg tcg_gen_setcondi_i64
-#define tcg_gen_mul_reg      tcg_gen_mul_i64
-#define tcg_gen_muli_reg     tcg_gen_muli_i64
-#define tcg_gen_div_reg      tcg_gen_div_i64
-#define tcg_gen_rem_reg      tcg_gen_rem_i64
-#define tcg_gen_divu_reg     tcg_gen_divu_i64
-#define tcg_gen_remu_reg     tcg_gen_remu_i64
-#define tcg_gen_discard_reg  tcg_gen_discard_i64
-#define tcg_gen_trunc_reg_i32 tcg_gen_extrl_i64_i32
 #define tcg_gen_trunc_i64_reg tcg_gen_mov_i64
-#define tcg_gen_extu_i32_reg tcg_gen_extu_i32_i64
-#define tcg_gen_ext_i32_reg  tcg_gen_ext_i32_i64
 #define tcg_gen_extu_reg_i64 tcg_gen_mov_i64
 #define tcg_gen_ext_reg_i64  tcg_gen_mov_i64
-#define tcg_gen_ext8u_reg    tcg_gen_ext8u_i64
-#define tcg_gen_ext8s_reg    tcg_gen_ext8s_i64
-#define tcg_gen_ext16u_reg   tcg_gen_ext16u_i64
-#define tcg_gen_ext16s_reg   tcg_gen_ext16s_i64
-#define tcg_gen_ext32u_reg   tcg_gen_ext32u_i64
-#define tcg_gen_ext32s_reg   tcg_gen_ext32s_i64
-#define tcg_gen_bswap16_reg  tcg_gen_bswap16_i64
-#define tcg_gen_bswap32_reg  tcg_gen_bswap32_i64
-#define tcg_gen_bswap64_reg  tcg_gen_bswap64_i64
-#define tcg_gen_concat_reg_i64 tcg_gen_concat32_i64
-#define tcg_gen_andc_reg     tcg_gen_andc_i64
-#define tcg_gen_eqv_reg      tcg_gen_eqv_i64
-#define tcg_gen_nand_reg     tcg_gen_nand_i64
-#define tcg_gen_nor_reg      tcg_gen_nor_i64
-#define tcg_gen_orc_reg      tcg_gen_orc_i64
-#define tcg_gen_clz_reg      tcg_gen_clz_i64
-#define tcg_gen_ctz_reg      tcg_gen_ctz_i64
-#define tcg_gen_clzi_reg     tcg_gen_clzi_i64
-#define tcg_gen_ctzi_reg     tcg_gen_ctzi_i64
-#define tcg_gen_clrsb_reg    tcg_gen_clrsb_i64
-#define tcg_gen_ctpop_reg    tcg_gen_ctpop_i64
-#define tcg_gen_rotl_reg     tcg_gen_rotl_i64
-#define tcg_gen_rotli_reg    tcg_gen_rotli_i64
-#define tcg_gen_rotr_reg     tcg_gen_rotr_i64
-#define tcg_gen_rotri_reg    tcg_gen_rotri_i64
-#define tcg_gen_deposit_reg  tcg_gen_deposit_i64
-#define tcg_gen_deposit_z_reg tcg_gen_deposit_z_i64
-#define tcg_gen_extract_reg  tcg_gen_extract_i64
-#define tcg_gen_sextract_reg tcg_gen_sextract_i64
-#define tcg_gen_extract2_reg tcg_gen_extract2_i64
-#define tcg_constant_reg     tcg_constant_i64
-#define tcg_gen_movcond_reg  tcg_gen_movcond_i64
-#define tcg_gen_add2_reg     tcg_gen_add2_i64
-#define tcg_gen_sub2_reg     tcg_gen_sub2_i64
-#define tcg_gen_qemu_ld_reg  tcg_gen_qemu_ld_i64
-#define tcg_gen_qemu_st_reg  tcg_gen_qemu_st_i64
-#define tcg_gen_atomic_xchg_reg tcg_gen_atomic_xchg_i64
-#define tcg_gen_trunc_reg_ptr   tcg_gen_trunc_i64_ptr
+
 
 typedef struct DisasCond {
     TCGCond c;
-    TCGv_reg a0, a1;
+    TCGv_i64 a0, a1;
 } DisasCond;
 
 typedef struct DisasContext {
@@ -149,7 +54,7 @@ typedef struct DisasContext {
     uint64_t iaoq_f;
     uint64_t iaoq_b;
     uint64_t iaoq_n;
-    TCGv_reg iaoq_n_var;
+    TCGv_i64 iaoq_n_var;
 
     DisasCond null_cond;
     TCGLabel *null_lab;
@@ -261,24 +166,24 @@ static int cmpbid_c(DisasContext *ctx, int val)
 #define DISAS_EXIT                  DISAS_TARGET_3
 
 /* global register indexes */
-static TCGv_reg cpu_gr[32];
+static TCGv_i64 cpu_gr[32];
 static TCGv_i64 cpu_sr[4];
 static TCGv_i64 cpu_srH;
-static TCGv_reg cpu_iaoq_f;
-static TCGv_reg cpu_iaoq_b;
+static TCGv_i64 cpu_iaoq_f;
+static TCGv_i64 cpu_iaoq_b;
 static TCGv_i64 cpu_iasq_f;
 static TCGv_i64 cpu_iasq_b;
-static TCGv_reg cpu_sar;
-static TCGv_reg cpu_psw_n;
-static TCGv_reg cpu_psw_v;
-static TCGv_reg cpu_psw_cb;
-static TCGv_reg cpu_psw_cb_msb;
+static TCGv_i64 cpu_sar;
+static TCGv_i64 cpu_psw_n;
+static TCGv_i64 cpu_psw_v;
+static TCGv_i64 cpu_psw_cb;
+static TCGv_i64 cpu_psw_cb_msb;
 
 void hppa_translate_init(void)
 {
 #define DEF_VAR(V)  { &cpu_##V, #V, offsetof(CPUHPPAState, V) }
 
-    typedef struct { TCGv_reg *var; const char *name; int ofs; } GlobalVar;
+    typedef struct { TCGv_i64 *var; const char *name; int ofs; } GlobalVar;
     static const GlobalVar vars[] = {
         { &cpu_sar, "sar", offsetof(CPUHPPAState, cr[CR_SAR]) },
         DEF_VAR(psw_n),
@@ -356,35 +261,35 @@ static DisasCond cond_make_n(void)
     return (DisasCond){
         .c = TCG_COND_NE,
         .a0 = cpu_psw_n,
-        .a1 = tcg_constant_reg(0)
+        .a1 = tcg_constant_i64(0)
     };
 }
 
-static DisasCond cond_make_tmp(TCGCond c, TCGv_reg a0, TCGv_reg a1)
+static DisasCond cond_make_tmp(TCGCond c, TCGv_i64 a0, TCGv_i64 a1)
 {
     assert (c != TCG_COND_NEVER && c != TCG_COND_ALWAYS);
     return (DisasCond){ .c = c, .a0 = a0, .a1 = a1 };
 }
 
-static DisasCond cond_make_0_tmp(TCGCond c, TCGv_reg a0)
+static DisasCond cond_make_0_tmp(TCGCond c, TCGv_i64 a0)
 {
-    return cond_make_tmp(c, a0, tcg_constant_reg(0));
+    return cond_make_tmp(c, a0, tcg_constant_i64(0));
 }
 
-static DisasCond cond_make_0(TCGCond c, TCGv_reg a0)
+static DisasCond cond_make_0(TCGCond c, TCGv_i64 a0)
 {
-    TCGv_reg tmp = tcg_temp_new();
-    tcg_gen_mov_reg(tmp, a0);
+    TCGv_i64 tmp = tcg_temp_new();
+    tcg_gen_mov_i64(tmp, a0);
     return cond_make_0_tmp(c, tmp);
 }
 
-static DisasCond cond_make(TCGCond c, TCGv_reg a0, TCGv_reg a1)
+static DisasCond cond_make(TCGCond c, TCGv_i64 a0, TCGv_i64 a1)
 {
-    TCGv_reg t0 = tcg_temp_new();
-    TCGv_reg t1 = tcg_temp_new();
+    TCGv_i64 t0 = tcg_temp_new();
+    TCGv_i64 t1 = tcg_temp_new();
 
-    tcg_gen_mov_reg(t0, a0);
-    tcg_gen_mov_reg(t1, a1);
+    tcg_gen_mov_i64(t0, a0);
+    tcg_gen_mov_i64(t1, a1);
     return cond_make_tmp(c, t0, t1);
 }
 
@@ -403,18 +308,18 @@ static void cond_free(DisasCond *cond)
     }
 }
 
-static TCGv_reg load_gpr(DisasContext *ctx, unsigned reg)
+static TCGv_i64 load_gpr(DisasContext *ctx, unsigned reg)
 {
     if (reg == 0) {
-        TCGv_reg t = tcg_temp_new();
-        tcg_gen_movi_reg(t, 0);
+        TCGv_i64 t = tcg_temp_new();
+        tcg_gen_movi_i64(t, 0);
         return t;
     } else {
         return cpu_gr[reg];
     }
 }
 
-static TCGv_reg dest_gpr(DisasContext *ctx, unsigned reg)
+static TCGv_i64 dest_gpr(DisasContext *ctx, unsigned reg)
 {
     if (reg == 0 || ctx->null_cond.c != TCG_COND_NEVER) {
         return tcg_temp_new();
@@ -423,17 +328,17 @@ static TCGv_reg dest_gpr(DisasContext *ctx, unsigned reg)
     }
 }
 
-static void save_or_nullify(DisasContext *ctx, TCGv_reg dest, TCGv_reg t)
+static void save_or_nullify(DisasContext *ctx, TCGv_i64 dest, TCGv_i64 t)
 {
     if (ctx->null_cond.c != TCG_COND_NEVER) {
-        tcg_gen_movcond_reg(ctx->null_cond.c, dest, ctx->null_cond.a0,
+        tcg_gen_movcond_i64(ctx->null_cond.c, dest, ctx->null_cond.a0,
                             ctx->null_cond.a1, dest, t);
     } else {
-        tcg_gen_mov_reg(dest, t);
+        tcg_gen_mov_i64(dest, t);
     }
 }
 
-static void save_gpr(DisasContext *ctx, unsigned reg, TCGv_reg t)
+static void save_gpr(DisasContext *ctx, unsigned reg, TCGv_i64 t)
 {
     if (reg != 0) {
         save_or_nullify(ctx, cpu_gr[reg], t);
@@ -542,17 +447,17 @@ static void nullify_over(DisasContext *ctx)
         /* If we're using PSW[N], copy it to a temp because... */
         if (ctx->null_cond.a0 == cpu_psw_n) {
             ctx->null_cond.a0 = tcg_temp_new();
-            tcg_gen_mov_reg(ctx->null_cond.a0, cpu_psw_n);
+            tcg_gen_mov_i64(ctx->null_cond.a0, cpu_psw_n);
         }
         /* ... we clear it before branching over the implementation,
            so that (1) it's clear after nullifying this insn and
            (2) if this insn nullifies the next, PSW[N] is valid.  */
         if (ctx->psw_n_nonzero) {
             ctx->psw_n_nonzero = false;
-            tcg_gen_movi_reg(cpu_psw_n, 0);
+            tcg_gen_movi_i64(cpu_psw_n, 0);
         }
 
-        tcg_gen_brcond_reg(ctx->null_cond.c, ctx->null_cond.a0,
+        tcg_gen_brcond_i64(ctx->null_cond.c, ctx->null_cond.a0,
                            ctx->null_cond.a1, ctx->null_lab);
         cond_free(&ctx->null_cond);
     }
@@ -563,12 +468,12 @@ static void nullify_save(DisasContext *ctx)
 {
     if (ctx->null_cond.c == TCG_COND_NEVER) {
         if (ctx->psw_n_nonzero) {
-            tcg_gen_movi_reg(cpu_psw_n, 0);
+            tcg_gen_movi_i64(cpu_psw_n, 0);
         }
         return;
     }
     if (ctx->null_cond.a0 != cpu_psw_n) {
-        tcg_gen_setcond_reg(ctx->null_cond.c, cpu_psw_n,
+        tcg_gen_setcond_i64(ctx->null_cond.c, cpu_psw_n,
                             ctx->null_cond.a0, ctx->null_cond.a1);
         ctx->psw_n_nonzero = true;
     }
@@ -581,7 +486,7 @@ static void nullify_save(DisasContext *ctx)
 static void nullify_set(DisasContext *ctx, bool x)
 {
     if (ctx->psw_n_nonzero || x) {
-        tcg_gen_movi_reg(cpu_psw_n, x);
+        tcg_gen_movi_i64(cpu_psw_n, x);
     }
 }
 
@@ -631,13 +536,13 @@ static uint64_t gva_offset_mask(DisasContext *ctx)
             : MAKE_64BIT_MASK(0, 32));
 }
 
-static void copy_iaoq_entry(DisasContext *ctx, TCGv_reg dest,
-                            uint64_t ival, TCGv_reg vval)
+static void copy_iaoq_entry(DisasContext *ctx, TCGv_i64 dest,
+                            uint64_t ival, TCGv_i64 vval)
 {
     uint64_t mask = gva_offset_mask(ctx);
 
     if (ival != -1) {
-        tcg_gen_movi_reg(dest, ival & mask);
+        tcg_gen_movi_i64(dest, ival & mask);
         return;
     }
     tcg_debug_assert(vval != NULL);
@@ -647,9 +552,9 @@ static void copy_iaoq_entry(DisasContext *ctx, TCGv_reg dest,
      * This optimization is primarily for "iaoq_f = iaoq_b".
      */
     if (vval == cpu_iaoq_f || vval == cpu_iaoq_b) {
-        tcg_gen_mov_reg(dest, vval);
+        tcg_gen_mov_i64(dest, vval);
     } else {
-        tcg_gen_andi_reg(dest, vval, mask);
+        tcg_gen_andi_i64(dest, vval, mask);
     }
 }
 
@@ -675,7 +580,7 @@ static void gen_excp(DisasContext *ctx, int exception)
 static bool gen_excp_iir(DisasContext *ctx, int exc)
 {
     nullify_over(ctx);
-    tcg_gen_st_reg(tcg_constant_reg(ctx->insn),
+    tcg_gen_st_i64(tcg_constant_i64(ctx->insn),
                    tcg_env, offsetof(CPUHPPAState, cr[CR_IIR]));
     gen_excp(ctx, exc);
     return nullify_end(ctx);
@@ -738,7 +643,7 @@ static bool cond_need_cb(int c)
     return c == 4 || c == 5;
 }
 
-/* Need extensions from TCGv_i32 to TCGv_reg. */
+/* Need extensions from TCGv_i32 to TCGv_i64. */
 static bool cond_need_ext(DisasContext *ctx, bool d)
 {
     return !(ctx->is_pa20 && d);
@@ -750,10 +655,10 @@ static bool cond_need_ext(DisasContext *ctx, bool d)
  */
 
 static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
-                         TCGv_reg res, TCGv_reg cb_msb, TCGv_reg sv)
+                         TCGv_i64 res, TCGv_i64 cb_msb, TCGv_i64 sv)
 {
     DisasCond cond;
-    TCGv_reg tmp;
+    TCGv_i64 tmp;
 
     switch (cf >> 1) {
     case 0: /* Never / TR    (0 / 1) */
@@ -762,16 +667,16 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
     case 1: /* = / <>        (Z / !Z) */
         if (cond_need_ext(ctx, d)) {
             tmp = tcg_temp_new();
-            tcg_gen_ext32u_reg(tmp, res);
+            tcg_gen_ext32u_i64(tmp, res);
             res = tmp;
         }
         cond = cond_make_0(TCG_COND_EQ, res);
         break;
     case 2: /* < / >=        (N ^ V / !(N ^ V) */
         tmp = tcg_temp_new();
-        tcg_gen_xor_reg(tmp, res, sv);
+        tcg_gen_xor_i64(tmp, res, sv);
         if (cond_need_ext(ctx, d)) {
-            tcg_gen_ext32s_reg(tmp, tmp);
+            tcg_gen_ext32s_i64(tmp, tmp);
         }
         cond = cond_make_0_tmp(TCG_COND_LT, tmp);
         break;
@@ -786,14 +691,14 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
          *   !(~(res ^ sv) >> 31 & res)
          */
         tmp = tcg_temp_new();
-        tcg_gen_eqv_reg(tmp, res, sv);
+        tcg_gen_eqv_i64(tmp, res, sv);
         if (cond_need_ext(ctx, d)) {
-            tcg_gen_sextract_reg(tmp, tmp, 31, 1);
-            tcg_gen_and_reg(tmp, tmp, res);
-            tcg_gen_ext32u_reg(tmp, tmp);
+            tcg_gen_sextract_i64(tmp, tmp, 31, 1);
+            tcg_gen_and_i64(tmp, tmp, res);
+            tcg_gen_ext32u_i64(tmp, tmp);
         } else {
-            tcg_gen_sari_reg(tmp, tmp, 63);
-            tcg_gen_and_reg(tmp, tmp, res);
+            tcg_gen_sari_i64(tmp, tmp, 63);
+            tcg_gen_and_i64(tmp, tmp, res);
         }
         cond = cond_make_0_tmp(TCG_COND_EQ, tmp);
         break;
@@ -803,24 +708,24 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
         break;
     case 5: /* ZNV / VNZ     (!C | Z / C & !Z) */
         tmp = tcg_temp_new();
-        tcg_gen_neg_reg(tmp, cb_msb);
-        tcg_gen_and_reg(tmp, tmp, res);
+        tcg_gen_neg_i64(tmp, cb_msb);
+        tcg_gen_and_i64(tmp, tmp, res);
         if (cond_need_ext(ctx, d)) {
-            tcg_gen_ext32u_reg(tmp, tmp);
+            tcg_gen_ext32u_i64(tmp, tmp);
         }
         cond = cond_make_0_tmp(TCG_COND_EQ, tmp);
         break;
     case 6: /* SV / NSV      (V / !V) */
         if (cond_need_ext(ctx, d)) {
             tmp = tcg_temp_new();
-            tcg_gen_ext32s_reg(tmp, sv);
+            tcg_gen_ext32s_i64(tmp, sv);
             sv = tmp;
         }
         cond = cond_make_0(TCG_COND_LT, sv);
         break;
     case 7: /* OD / EV */
         tmp = tcg_temp_new();
-        tcg_gen_andi_reg(tmp, res, 1);
+        tcg_gen_andi_i64(tmp, res, 1);
         cond = cond_make_0_tmp(TCG_COND_NE, tmp);
         break;
     default:
@@ -838,8 +743,8 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
    deleted as unused.  */
 
 static DisasCond do_sub_cond(DisasContext *ctx, unsigned cf, bool d,
-                             TCGv_reg res, TCGv_reg in1,
-                             TCGv_reg in2, TCGv_reg sv)
+                             TCGv_i64 res, TCGv_i64 in1,
+                             TCGv_i64 in2, TCGv_i64 sv)
 {
     TCGCond tc;
     bool ext_uns;
@@ -873,15 +778,15 @@ static DisasCond do_sub_cond(DisasContext *ctx, unsigned cf, bool d,
         tc = tcg_invert_cond(tc);
     }
     if (cond_need_ext(ctx, d)) {
-        TCGv_reg t1 = tcg_temp_new();
-        TCGv_reg t2 = tcg_temp_new();
+        TCGv_i64 t1 = tcg_temp_new();
+        TCGv_i64 t2 = tcg_temp_new();
 
         if (ext_uns) {
-            tcg_gen_ext32u_reg(t1, in1);
-            tcg_gen_ext32u_reg(t2, in2);
+            tcg_gen_ext32u_i64(t1, in1);
+            tcg_gen_ext32u_i64(t2, in2);
         } else {
-            tcg_gen_ext32s_reg(t1, in1);
-            tcg_gen_ext32s_reg(t2, in2);
+            tcg_gen_ext32s_i64(t1, in1);
+            tcg_gen_ext32s_i64(t2, in2);
         }
         return cond_make_tmp(tc, t1, t2);
     }
@@ -898,7 +803,7 @@ static DisasCond do_sub_cond(DisasContext *ctx, unsigned cf, bool d,
  */
 
 static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, bool d,
-                             TCGv_reg res)
+                             TCGv_i64 res)
 {
     TCGCond tc;
     bool ext_uns;
@@ -950,12 +855,12 @@ static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, bool d,
     }
 
     if (cond_need_ext(ctx, d)) {
-        TCGv_reg tmp = tcg_temp_new();
+        TCGv_i64 tmp = tcg_temp_new();
 
         if (ext_uns) {
-            tcg_gen_ext32u_reg(tmp, res);
+            tcg_gen_ext32u_i64(tmp, res);
         } else {
-            tcg_gen_ext32s_reg(tmp, res);
+            tcg_gen_ext32s_i64(tmp, res);
         }
         return cond_make_0_tmp(tc, tmp);
     }
@@ -965,7 +870,7 @@ static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, bool d,
 /* Similar, but for shift/extract/deposit conditions.  */
 
 static DisasCond do_sed_cond(DisasContext *ctx, unsigned orig, bool d,
-                             TCGv_reg res)
+                             TCGv_i64 res)
 {
     unsigned c, f;
 
@@ -983,11 +888,11 @@ static DisasCond do_sed_cond(DisasContext *ctx, unsigned orig, bool d,
 
 /* Similar, but for unit conditions.  */
 
-static DisasCond do_unit_cond(unsigned cf, bool d, TCGv_reg res,
-                              TCGv_reg in1, TCGv_reg in2)
+static DisasCond do_unit_cond(unsigned cf, bool d, TCGv_i64 res,
+                              TCGv_i64 in1, TCGv_i64 in2)
 {
     DisasCond cond;
-    TCGv_reg tmp, cb = NULL;
+    TCGv_i64 tmp, cb = NULL;
     uint64_t d_repl = d ? 0x0000000100000001ull : 1;
 
     if (cf & 8) {
@@ -997,10 +902,10 @@ static DisasCond do_unit_cond(unsigned cf, bool d, TCGv_reg res,
          */
         cb = tcg_temp_new();
         tmp = tcg_temp_new();
-        tcg_gen_or_reg(cb, in1, in2);
-        tcg_gen_and_reg(tmp, in1, in2);
-        tcg_gen_andc_reg(cb, cb, res);
-        tcg_gen_or_reg(cb, cb, tmp);
+        tcg_gen_or_i64(cb, in1, in2);
+        tcg_gen_and_i64(tmp, in1, in2);
+        tcg_gen_andc_i64(cb, cb, res);
+        tcg_gen_or_i64(cb, cb, tmp);
     }
 
     switch (cf >> 1) {
@@ -1015,32 +920,32 @@ static DisasCond do_unit_cond(unsigned cf, bool d, TCGv_reg res,
          * https://graphics.stanford.edu/~seander/bithacks.html#ZeroInWord
          */
         tmp = tcg_temp_new();
-        tcg_gen_subi_reg(tmp, res, d_repl * 0x01010101u);
-        tcg_gen_andc_reg(tmp, tmp, res);
-        tcg_gen_andi_reg(tmp, tmp, d_repl * 0x80808080u);
+        tcg_gen_subi_i64(tmp, res, d_repl * 0x01010101u);
+        tcg_gen_andc_i64(tmp, tmp, res);
+        tcg_gen_andi_i64(tmp, tmp, d_repl * 0x80808080u);
         cond = cond_make_0(TCG_COND_NE, tmp);
         break;
 
     case 3: /* SHZ / NHZ */
         tmp = tcg_temp_new();
-        tcg_gen_subi_reg(tmp, res, d_repl * 0x00010001u);
-        tcg_gen_andc_reg(tmp, tmp, res);
-        tcg_gen_andi_reg(tmp, tmp, d_repl * 0x80008000u);
+        tcg_gen_subi_i64(tmp, res, d_repl * 0x00010001u);
+        tcg_gen_andc_i64(tmp, tmp, res);
+        tcg_gen_andi_i64(tmp, tmp, d_repl * 0x80008000u);
         cond = cond_make_0(TCG_COND_NE, tmp);
         break;
 
     case 4: /* SDC / NDC */
-        tcg_gen_andi_reg(cb, cb, d_repl * 0x88888888u);
+        tcg_gen_andi_i64(cb, cb, d_repl * 0x88888888u);
         cond = cond_make_0(TCG_COND_NE, cb);
         break;
 
     case 6: /* SBC / NBC */
-        tcg_gen_andi_reg(cb, cb, d_repl * 0x80808080u);
+        tcg_gen_andi_i64(cb, cb, d_repl * 0x80808080u);
         cond = cond_make_0(TCG_COND_NE, cb);
         break;
 
     case 7: /* SHC / NHC */
-        tcg_gen_andi_reg(cb, cb, d_repl * 0x80008000u);
+        tcg_gen_andi_i64(cb, cb, d_repl * 0x80008000u);
         cond = cond_make_0(TCG_COND_NE, cb);
         break;
 
@@ -1054,55 +959,55 @@ static DisasCond do_unit_cond(unsigned cf, bool d, TCGv_reg res,
     return cond;
 }
 
-static TCGv_reg get_carry(DisasContext *ctx, bool d,
-                          TCGv_reg cb, TCGv_reg cb_msb)
+static TCGv_i64 get_carry(DisasContext *ctx, bool d,
+                          TCGv_i64 cb, TCGv_i64 cb_msb)
 {
     if (cond_need_ext(ctx, d)) {
-        TCGv_reg t = tcg_temp_new();
-        tcg_gen_extract_reg(t, cb, 32, 1);
+        TCGv_i64 t = tcg_temp_new();
+        tcg_gen_extract_i64(t, cb, 32, 1);
         return t;
     }
     return cb_msb;
 }
 
-static TCGv_reg get_psw_carry(DisasContext *ctx, bool d)
+static TCGv_i64 get_psw_carry(DisasContext *ctx, bool d)
 {
     return get_carry(ctx, d, cpu_psw_cb, cpu_psw_cb_msb);
 }
 
 /* Compute signed overflow for addition.  */
-static TCGv_reg do_add_sv(DisasContext *ctx, TCGv_reg res,
-                          TCGv_reg in1, TCGv_reg in2)
+static TCGv_i64 do_add_sv(DisasContext *ctx, TCGv_i64 res,
+                          TCGv_i64 in1, TCGv_i64 in2)
 {
-    TCGv_reg sv = tcg_temp_new();
-    TCGv_reg tmp = tcg_temp_new();
+    TCGv_i64 sv = tcg_temp_new();
+    TCGv_i64 tmp = tcg_temp_new();
 
-    tcg_gen_xor_reg(sv, res, in1);
-    tcg_gen_xor_reg(tmp, in1, in2);
-    tcg_gen_andc_reg(sv, sv, tmp);
+    tcg_gen_xor_i64(sv, res, in1);
+    tcg_gen_xor_i64(tmp, in1, in2);
+    tcg_gen_andc_i64(sv, sv, tmp);
 
     return sv;
 }
 
 /* Compute signed overflow for subtraction.  */
-static TCGv_reg do_sub_sv(DisasContext *ctx, TCGv_reg res,
-                          TCGv_reg in1, TCGv_reg in2)
+static TCGv_i64 do_sub_sv(DisasContext *ctx, TCGv_i64 res,
+                          TCGv_i64 in1, TCGv_i64 in2)
 {
-    TCGv_reg sv = tcg_temp_new();
-    TCGv_reg tmp = tcg_temp_new();
+    TCGv_i64 sv = tcg_temp_new();
+    TCGv_i64 tmp = tcg_temp_new();
 
-    tcg_gen_xor_reg(sv, res, in1);
-    tcg_gen_xor_reg(tmp, in1, in2);
-    tcg_gen_and_reg(sv, sv, tmp);
+    tcg_gen_xor_i64(sv, res, in1);
+    tcg_gen_xor_i64(tmp, in1, in2);
+    tcg_gen_and_i64(sv, sv, tmp);
 
     return sv;
 }
 
-static void do_add(DisasContext *ctx, unsigned rt, TCGv_reg in1,
-                   TCGv_reg in2, unsigned shift, bool is_l,
+static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
+                   TCGv_i64 in2, unsigned shift, bool is_l,
                    bool is_tsv, bool is_tc, bool is_c, unsigned cf, bool d)
 {
-    TCGv_reg dest, cb, cb_msb, cb_cond, sv, tmp;
+    TCGv_i64 dest, cb, cb_msb, cb_cond, sv, tmp;
     unsigned c = cf >> 1;
     DisasCond cond;
 
@@ -1113,29 +1018,29 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_reg in1,
 
     if (shift) {
         tmp = tcg_temp_new();
-        tcg_gen_shli_reg(tmp, in1, shift);
+        tcg_gen_shli_i64(tmp, in1, shift);
         in1 = tmp;
     }
 
     if (!is_l || cond_need_cb(c)) {
-        TCGv_reg zero = tcg_constant_reg(0);
+        TCGv_i64 zero = tcg_constant_i64(0);
         cb_msb = tcg_temp_new();
         cb = tcg_temp_new();
 
-        tcg_gen_add2_reg(dest, cb_msb, in1, zero, in2, zero);
+        tcg_gen_add2_i64(dest, cb_msb, in1, zero, in2, zero);
         if (is_c) {
-            tcg_gen_add2_reg(dest, cb_msb, dest, cb_msb,
+            tcg_gen_add2_i64(dest, cb_msb, dest, cb_msb,
                              get_psw_carry(ctx, d), zero);
         }
-        tcg_gen_xor_reg(cb, in1, in2);
-        tcg_gen_xor_reg(cb, cb, dest);
+        tcg_gen_xor_i64(cb, in1, in2);
+        tcg_gen_xor_i64(cb, cb, dest);
         if (cond_need_cb(c)) {
             cb_cond = get_carry(ctx, d, cb, cb_msb);
         }
     } else {
-        tcg_gen_add_reg(dest, in1, in2);
+        tcg_gen_add_i64(dest, in1, in2);
         if (is_c) {
-            tcg_gen_add_reg(dest, dest, get_psw_carry(ctx, d));
+            tcg_gen_add_i64(dest, dest, get_psw_carry(ctx, d));
         }
     }
 
@@ -1153,7 +1058,7 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     cond = do_cond(ctx, cf, d, dest, cb_cond, sv);
     if (is_tc) {
         tmp = tcg_temp_new();
-        tcg_gen_setcond_reg(cond.c, tmp, cond.a0, cond.a1);
+        tcg_gen_setcond_i64(cond.c, tmp, cond.a0, cond.a1);
         gen_helper_tcond(tcg_env, tmp);
     }
 
@@ -1172,7 +1077,7 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_reg in1,
 static bool do_add_reg(DisasContext *ctx, arg_rrr_cf_d_sh *a,
                        bool is_l, bool is_tsv, bool is_tc, bool is_c)
 {
-    TCGv_reg tcg_r1, tcg_r2;
+    TCGv_i64 tcg_r1, tcg_r2;
 
     if (a->cf) {
         nullify_over(ctx);
@@ -1187,23 +1092,23 @@ static bool do_add_reg(DisasContext *ctx, arg_rrr_cf_d_sh *a,
 static bool do_add_imm(DisasContext *ctx, arg_rri_cf *a,
                        bool is_tsv, bool is_tc)
 {
-    TCGv_reg tcg_im, tcg_r2;
+    TCGv_i64 tcg_im, tcg_r2;
 
     if (a->cf) {
         nullify_over(ctx);
     }
-    tcg_im = tcg_constant_reg(a->i);
+    tcg_im = tcg_constant_i64(a->i);
     tcg_r2 = load_gpr(ctx, a->r);
     /* All ADDI conditions are 32-bit. */
     do_add(ctx, a->t, tcg_im, tcg_r2, 0, 0, is_tsv, is_tc, 0, a->cf, false);
     return nullify_end(ctx);
 }
 
-static void do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
-                   TCGv_reg in2, bool is_tsv, bool is_b,
+static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
+                   TCGv_i64 in2, bool is_tsv, bool is_b,
                    bool is_tc, unsigned cf, bool d)
 {
-    TCGv_reg dest, sv, cb, cb_msb, zero, tmp;
+    TCGv_i64 dest, sv, cb, cb_msb, zero, tmp;
     unsigned c = cf >> 1;
     DisasCond cond;
 
@@ -1211,23 +1116,23 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     cb = tcg_temp_new();
     cb_msb = tcg_temp_new();
 
-    zero = tcg_constant_reg(0);
+    zero = tcg_constant_i64(0);
     if (is_b) {
         /* DEST,C = IN1 + ~IN2 + C.  */
-        tcg_gen_not_reg(cb, in2);
-        tcg_gen_add2_reg(dest, cb_msb, in1, zero, get_psw_carry(ctx, d), zero);
-        tcg_gen_add2_reg(dest, cb_msb, dest, cb_msb, cb, zero);
-        tcg_gen_xor_reg(cb, cb, in1);
-        tcg_gen_xor_reg(cb, cb, dest);
+        tcg_gen_not_i64(cb, in2);
+        tcg_gen_add2_i64(dest, cb_msb, in1, zero, get_psw_carry(ctx, d), zero);
+        tcg_gen_add2_i64(dest, cb_msb, dest, cb_msb, cb, zero);
+        tcg_gen_xor_i64(cb, cb, in1);
+        tcg_gen_xor_i64(cb, cb, dest);
     } else {
         /*
          * DEST,C = IN1 + ~IN2 + 1.  We can produce the same result in fewer
          * operations by seeding the high word with 1 and subtracting.
          */
-        TCGv_reg one = tcg_constant_reg(1);
-        tcg_gen_sub2_reg(dest, cb_msb, in1, one, in2, zero);
-        tcg_gen_eqv_reg(cb, in1, in2);
-        tcg_gen_xor_reg(cb, cb, dest);
+        TCGv_i64 one = tcg_constant_i64(1);
+        tcg_gen_sub2_i64(dest, cb_msb, in1, one, in2, zero);
+        tcg_gen_eqv_i64(cb, in1, in2);
+        tcg_gen_xor_i64(cb, cb, dest);
     }
 
     /* Compute signed overflow if required.  */
@@ -1249,7 +1154,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     /* Emit any conditional trap before any writeback.  */
     if (is_tc) {
         tmp = tcg_temp_new();
-        tcg_gen_setcond_reg(cond.c, tmp, cond.a0, cond.a1);
+        tcg_gen_setcond_i64(cond.c, tmp, cond.a0, cond.a1);
         gen_helper_tcond(tcg_env, tmp);
     }
 
@@ -1266,7 +1171,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
 static bool do_sub_reg(DisasContext *ctx, arg_rrr_cf_d *a,
                        bool is_tsv, bool is_b, bool is_tc)
 {
-    TCGv_reg tcg_r1, tcg_r2;
+    TCGv_i64 tcg_r1, tcg_r2;
 
     if (a->cf) {
         nullify_over(ctx);
@@ -1279,26 +1184,26 @@ static bool do_sub_reg(DisasContext *ctx, arg_rrr_cf_d *a,
 
 static bool do_sub_imm(DisasContext *ctx, arg_rri_cf *a, bool is_tsv)
 {
-    TCGv_reg tcg_im, tcg_r2;
+    TCGv_i64 tcg_im, tcg_r2;
 
     if (a->cf) {
         nullify_over(ctx);
     }
-    tcg_im = tcg_constant_reg(a->i);
+    tcg_im = tcg_constant_i64(a->i);
     tcg_r2 = load_gpr(ctx, a->r);
     /* All SUBI conditions are 32-bit. */
     do_sub(ctx, a->t, tcg_im, tcg_r2, is_tsv, 0, 0, a->cf, false);
     return nullify_end(ctx);
 }
 
-static void do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_reg in1,
-                      TCGv_reg in2, unsigned cf, bool d)
+static void do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
+                      TCGv_i64 in2, unsigned cf, bool d)
 {
-    TCGv_reg dest, sv;
+    TCGv_i64 dest, sv;
     DisasCond cond;
 
     dest = tcg_temp_new();
-    tcg_gen_sub_reg(dest, in1, in2);
+    tcg_gen_sub_i64(dest, in1, in2);
 
     /* Compute signed overflow if required.  */
     sv = NULL;
@@ -1310,7 +1215,7 @@ static void do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     cond = do_sub_cond(ctx, cf, d, dest, in1, in2, sv);
 
     /* Clear.  */
-    tcg_gen_movi_reg(dest, 0);
+    tcg_gen_movi_i64(dest, 0);
     save_gpr(ctx, rt, dest);
 
     /* Install the new nullification.  */
@@ -1318,11 +1223,11 @@ static void do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     ctx->null_cond = cond;
 }
 
-static void do_log(DisasContext *ctx, unsigned rt, TCGv_reg in1,
-                   TCGv_reg in2, unsigned cf, bool d,
-                   void (*fn)(TCGv_reg, TCGv_reg, TCGv_reg))
+static void do_log(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
+                   TCGv_i64 in2, unsigned cf, bool d,
+                   void (*fn)(TCGv_i64, TCGv_i64, TCGv_i64))
 {
-    TCGv_reg dest = dest_gpr(ctx, rt);
+    TCGv_i64 dest = dest_gpr(ctx, rt);
 
     /* Perform the operation, and writeback.  */
     fn(dest, in1, in2);
@@ -1336,9 +1241,9 @@ static void do_log(DisasContext *ctx, unsigned rt, TCGv_reg in1,
 }
 
 static bool do_log_reg(DisasContext *ctx, arg_rrr_cf_d *a,
-                       void (*fn)(TCGv_reg, TCGv_reg, TCGv_reg))
+                       void (*fn)(TCGv_i64, TCGv_i64, TCGv_i64))
 {
-    TCGv_reg tcg_r1, tcg_r2;
+    TCGv_i64 tcg_r1, tcg_r2;
 
     if (a->cf) {
         nullify_over(ctx);
@@ -1349,11 +1254,11 @@ static bool do_log_reg(DisasContext *ctx, arg_rrr_cf_d *a,
     return nullify_end(ctx);
 }
 
-static void do_unit(DisasContext *ctx, unsigned rt, TCGv_reg in1,
-                    TCGv_reg in2, unsigned cf, bool d, bool is_tc,
-                    void (*fn)(TCGv_reg, TCGv_reg, TCGv_reg))
+static void do_unit(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
+                    TCGv_i64 in2, unsigned cf, bool d, bool is_tc,
+                    void (*fn)(TCGv_i64, TCGv_i64, TCGv_i64))
 {
-    TCGv_reg dest;
+    TCGv_i64 dest;
     DisasCond cond;
 
     if (cf == 0) {
@@ -1368,8 +1273,8 @@ static void do_unit(DisasContext *ctx, unsigned rt, TCGv_reg in1,
         cond = do_unit_cond(cf, d, dest, in1, in2);
 
         if (is_tc) {
-            TCGv_reg tmp = tcg_temp_new();
-            tcg_gen_setcond_reg(cond.c, tmp, cond.a0, cond.a1);
+            TCGv_i64 tmp = tcg_temp_new();
+            tcg_gen_setcond_i64(cond.c, tmp, cond.a0, cond.a1);
             gen_helper_tcond(tcg_env, tmp);
         }
         save_gpr(ctx, rt, dest);
@@ -1384,17 +1289,17 @@ static void do_unit(DisasContext *ctx, unsigned rt, TCGv_reg in1,
    from the top 2 bits of the base register.  There are a few system
    instructions that have a 3-bit space specifier, for which SR0 is
    not special.  To handle this, pass ~SP.  */
-static TCGv_i64 space_select(DisasContext *ctx, int sp, TCGv_reg base)
+static TCGv_i64 space_select(DisasContext *ctx, int sp, TCGv_i64 base)
 {
     TCGv_ptr ptr;
-    TCGv_reg tmp;
+    TCGv_i64 tmp;
     TCGv_i64 spc;
 
     if (sp != 0) {
         if (sp < 0) {
             sp = ~sp;
         }
-        spc = tcg_temp_new_tl();
+        spc = tcg_temp_new_i64();
         load_spr(ctx, spc, sp);
         return spc;
     }
@@ -1404,12 +1309,12 @@ static TCGv_i64 space_select(DisasContext *ctx, int sp, TCGv_reg base)
 
     ptr = tcg_temp_new_ptr();
     tmp = tcg_temp_new();
-    spc = tcg_temp_new_tl();
+    spc = tcg_temp_new_i64();
 
     /* Extract top 2 bits of the address, shift left 3 for uint64_t index. */
-    tcg_gen_shri_reg(tmp, base, (ctx->tb_flags & PSW_W ? 64 : 32) - 5);
-    tcg_gen_andi_reg(tmp, tmp, 030);
-    tcg_gen_trunc_reg_ptr(ptr, tmp);
+    tcg_gen_shri_i64(tmp, base, (ctx->tb_flags & PSW_W ? 64 : 32) - 5);
+    tcg_gen_andi_i64(tmp, tmp, 030);
+    tcg_gen_trunc_i64_ptr(ptr, tmp);
 
     tcg_gen_add_ptr(ptr, ptr, tcg_env);
     tcg_gen_ld_i64(spc, ptr, offsetof(CPUHPPAState, sr[4]));
@@ -1418,28 +1323,28 @@ static TCGv_i64 space_select(DisasContext *ctx, int sp, TCGv_reg base)
 }
 #endif
 
-static void form_gva(DisasContext *ctx, TCGv_tl *pgva, TCGv_reg *pofs,
+static void form_gva(DisasContext *ctx, TCGv_i64 *pgva, TCGv_i64 *pofs,
                      unsigned rb, unsigned rx, int scale, int64_t disp,
                      unsigned sp, int modify, bool is_phys)
 {
-    TCGv_reg base = load_gpr(ctx, rb);
-    TCGv_reg ofs;
-    TCGv_tl addr;
+    TCGv_i64 base = load_gpr(ctx, rb);
+    TCGv_i64 ofs;
+    TCGv_i64 addr;
 
     /* Note that RX is mutually exclusive with DISP.  */
     if (rx) {
         ofs = tcg_temp_new();
-        tcg_gen_shli_reg(ofs, cpu_gr[rx], scale);
-        tcg_gen_add_reg(ofs, ofs, base);
+        tcg_gen_shli_i64(ofs, cpu_gr[rx], scale);
+        tcg_gen_add_i64(ofs, ofs, base);
     } else if (disp || modify) {
         ofs = tcg_temp_new();
-        tcg_gen_addi_reg(ofs, base, disp);
+        tcg_gen_addi_i64(ofs, base, disp);
     } else {
         ofs = base;
     }
 
     *pofs = ofs;
-    *pgva = addr = tcg_temp_new_tl();
+    *pgva = addr = tcg_temp_new_i64();
     tcg_gen_extu_reg_tl(addr, modify <= 0 ? ofs : base);
     tcg_gen_andi_tl(addr, addr, gva_offset_mask(ctx));
 #ifndef CONFIG_USER_ONLY
@@ -1458,8 +1363,8 @@ static void do_load_32(DisasContext *ctx, TCGv_i32 dest, unsigned rb,
                        unsigned rx, int scale, int64_t disp,
                        unsigned sp, int modify, MemOp mop)
 {
-    TCGv_reg ofs;
-    TCGv_tl addr;
+    TCGv_i64 ofs;
+    TCGv_i64 addr;
 
     /* Caller uses nullify_over/nullify_end.  */
     assert(ctx->null_cond.c == TCG_COND_NEVER);
@@ -1476,8 +1381,8 @@ static void do_load_64(DisasContext *ctx, TCGv_i64 dest, unsigned rb,
                        unsigned rx, int scale, int64_t disp,
                        unsigned sp, int modify, MemOp mop)
 {
-    TCGv_reg ofs;
-    TCGv_tl addr;
+    TCGv_i64 ofs;
+    TCGv_i64 addr;
 
     /* Caller uses nullify_over/nullify_end.  */
     assert(ctx->null_cond.c == TCG_COND_NEVER);
@@ -1494,8 +1399,8 @@ static void do_store_32(DisasContext *ctx, TCGv_i32 src, unsigned rb,
                         unsigned rx, int scale, int64_t disp,
                         unsigned sp, int modify, MemOp mop)
 {
-    TCGv_reg ofs;
-    TCGv_tl addr;
+    TCGv_i64 ofs;
+    TCGv_i64 addr;
 
     /* Caller uses nullify_over/nullify_end.  */
     assert(ctx->null_cond.c == TCG_COND_NEVER);
@@ -1512,8 +1417,8 @@ static void do_store_64(DisasContext *ctx, TCGv_i64 src, unsigned rb,
                         unsigned rx, int scale, int64_t disp,
                         unsigned sp, int modify, MemOp mop)
 {
-    TCGv_reg ofs;
-    TCGv_tl addr;
+    TCGv_i64 ofs;
+    TCGv_i64 addr;
 
     /* Caller uses nullify_over/nullify_end.  */
     assert(ctx->null_cond.c == TCG_COND_NEVER);
@@ -1526,14 +1431,11 @@ static void do_store_64(DisasContext *ctx, TCGv_i64 src, unsigned rb,
     }
 }
 
-#define do_load_reg   do_load_64
-#define do_store_reg  do_store_64
-
 static bool do_load(DisasContext *ctx, unsigned rt, unsigned rb,
                     unsigned rx, int scale, int64_t disp,
                     unsigned sp, int modify, MemOp mop)
 {
-    TCGv_reg dest;
+    TCGv_i64 dest;
 
     nullify_over(ctx);
 
@@ -1544,7 +1446,7 @@ static bool do_load(DisasContext *ctx, unsigned rt, unsigned rb,
         /* Make sure if RT == RB, we see the result of the load.  */
         dest = tcg_temp_new();
     }
-    do_load_reg(ctx, dest, rb, rx, scale, disp, sp, modify, mop);
+    do_load_64(ctx, dest, rb, rx, scale, disp, sp, modify, mop);
     save_gpr(ctx, rt, dest);
 
     return nullify_end(ctx);
@@ -1605,7 +1507,7 @@ static bool do_store(DisasContext *ctx, unsigned rt, unsigned rb,
                      int modify, MemOp mop)
 {
     nullify_over(ctx);
-    do_store_reg(ctx, load_gpr(ctx, rt), rb, 0, 0, disp, sp, modify, mop);
+    do_store_64(ctx, load_gpr(ctx, rt), rb, 0, 0, disp, sp, modify, mop);
     return nullify_end(ctx);
 }
 
@@ -1799,7 +1701,7 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
     }
 
     taken = gen_new_label();
-    tcg_gen_brcond_reg(c, cond->a0, cond->a1, taken);
+    tcg_gen_brcond_i64(c, cond->a0, cond->a1, taken);
     cond_free(cond);
 
     /* Not taken: Condition not satisfied; nullify on backward branches. */
@@ -1816,7 +1718,7 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
         if (ctx->iaoq_n == -1) {
             /* The temporary iaoq_n_var died at the branch above.
                Regenerate it here instead of saving it.  */
-            tcg_gen_addi_reg(ctx->iaoq_n_var, cpu_iaoq_b, 4);
+            tcg_gen_addi_i64(ctx->iaoq_n_var, cpu_iaoq_b, 4);
         }
         gen_goto_tb(ctx, 0, ctx->iaoq_b, ctx->iaoq_n);
     }
@@ -1846,10 +1748,10 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
 
 /* Emit an unconditional branch to an indirect target.  This handles
    nullification of the branch itself.  */
-static bool do_ibranch(DisasContext *ctx, TCGv_reg dest,
+static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
                        unsigned link, bool is_n)
 {
-    TCGv_reg a0, a1, next, tmp;
+    TCGv_i64 a0, a1, next, tmp;
     TCGCond c;
 
     assert(ctx->null_lab == NULL);
@@ -1859,11 +1761,11 @@ static bool do_ibranch(DisasContext *ctx, TCGv_reg dest,
             copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
         }
         next = tcg_temp_new();
-        tcg_gen_mov_reg(next, dest);
+        tcg_gen_mov_i64(next, dest);
         if (is_n) {
             if (use_nullify_skip(ctx)) {
                 copy_iaoq_entry(ctx, cpu_iaoq_f, -1, next);
-                tcg_gen_addi_reg(next, next, 4);
+                tcg_gen_addi_i64(next, next, 4);
                 copy_iaoq_entry(ctx, cpu_iaoq_b, -1, next);
                 nullify_set(ctx, 0);
                 ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
@@ -1888,7 +1790,7 @@ static bool do_ibranch(DisasContext *ctx, TCGv_reg dest,
            can simply store DEST optimistically.  Similarly with IAOQ_B.  */
         copy_iaoq_entry(ctx, cpu_iaoq_f, -1, dest);
         next = tcg_temp_new();
-        tcg_gen_addi_reg(next, dest, 4);
+        tcg_gen_addi_i64(next, dest, 4);
         copy_iaoq_entry(ctx, cpu_iaoq_b, -1, next);
 
         nullify_over(ctx);
@@ -1906,19 +1808,19 @@ static bool do_ibranch(DisasContext *ctx, TCGv_reg dest,
         next = tcg_temp_new();
 
         copy_iaoq_entry(ctx, tmp, ctx->iaoq_n, ctx->iaoq_n_var);
-        tcg_gen_movcond_reg(c, next, a0, a1, tmp, dest);
+        tcg_gen_movcond_i64(c, next, a0, a1, tmp, dest);
         ctx->iaoq_n = -1;
         ctx->iaoq_n_var = next;
 
         if (link != 0) {
-            tcg_gen_movcond_reg(c, cpu_gr[link], a0, a1, cpu_gr[link], tmp);
+            tcg_gen_movcond_i64(c, cpu_gr[link], a0, a1, cpu_gr[link], tmp);
         }
 
         if (is_n) {
             /* The branch nullifies the next insn, which means the state of N
                after the branch is the inverse of the state of N that applied
                to the branch.  */
-            tcg_gen_setcond_reg(tcg_invert_cond(c), cpu_psw_n, a0, a1);
+            tcg_gen_setcond_i64(tcg_invert_cond(c), cpu_psw_n, a0, a1);
             cond_free(&ctx->null_cond);
             ctx->null_cond = cond_make_n();
             ctx->psw_n_nonzero = true;
@@ -1936,9 +1838,9 @@ static bool do_ibranch(DisasContext *ctx, TCGv_reg dest,
  *      IAOQ_Next{30..31} ← IAOQ_Front{30..31};
  * which keeps the privilege level from being increased.
  */
-static TCGv_reg do_ibranch_priv(DisasContext *ctx, TCGv_reg offset)
+static TCGv_i64 do_ibranch_priv(DisasContext *ctx, TCGv_i64 offset)
 {
-    TCGv_reg dest;
+    TCGv_i64 dest;
     switch (ctx->privilege) {
     case 0:
         /* Privilege 0 is maximum and is allowed to decrease.  */
@@ -1946,13 +1848,13 @@ static TCGv_reg do_ibranch_priv(DisasContext *ctx, TCGv_reg offset)
     case 3:
         /* Privilege 3 is minimum and is never allowed to increase.  */
         dest = tcg_temp_new();
-        tcg_gen_ori_reg(dest, offset, 3);
+        tcg_gen_ori_i64(dest, offset, 3);
         break;
     default:
         dest = tcg_temp_new();
-        tcg_gen_andi_reg(dest, offset, -4);
-        tcg_gen_ori_reg(dest, dest, ctx->privilege);
-        tcg_gen_movcond_reg(TCG_COND_GTU, dest, dest, offset, dest, offset);
+        tcg_gen_andi_i64(dest, offset, -4);
+        tcg_gen_ori_i64(dest, dest, ctx->privilege);
+        tcg_gen_movcond_i64(TCG_COND_GTU, dest, dest, offset, dest, offset);
         break;
     }
     return dest;
@@ -1968,7 +1870,7 @@ static TCGv_reg do_ibranch_priv(DisasContext *ctx, TCGv_reg offset)
    aforementioned BE.  */
 static void do_page_zero(DisasContext *ctx)
 {
-    TCGv_reg tmp;
+    TCGv_i64 tmp;
 
     /* If by some means we get here with PSW[N]=1, that implies that
        the B,GATE instruction would be skipped, and we'd fault on the
@@ -1977,7 +1879,7 @@ static void do_page_zero(DisasContext *ctx)
     case TCG_COND_NEVER:
         break;
     case TCG_COND_ALWAYS:
-        tcg_gen_movi_reg(cpu_psw_n, 0);
+        tcg_gen_movi_i64(cpu_psw_n, 0);
         goto do_sigill;
     default:
         /* Since this is always the first (and only) insn within the
@@ -2005,11 +1907,11 @@ static void do_page_zero(DisasContext *ctx)
         break;
 
     case 0xe0: /* SET_THREAD_POINTER */
-        tcg_gen_st_reg(cpu_gr[26], tcg_env, offsetof(CPUHPPAState, cr[27]));
+        tcg_gen_st_i64(cpu_gr[26], tcg_env, offsetof(CPUHPPAState, cr[27]));
         tmp = tcg_temp_new();
-        tcg_gen_ori_reg(tmp, cpu_gr[31], 3);
+        tcg_gen_ori_i64(tmp, cpu_gr[31], 3);
         copy_iaoq_entry(ctx, cpu_iaoq_f, -1, tmp);
-        tcg_gen_addi_reg(tmp, tmp, 4);
+        tcg_gen_addi_i64(tmp, tmp, 4);
         copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);
         ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
         break;
@@ -2051,8 +1953,8 @@ static bool trans_sync(DisasContext *ctx, arg_sync *a)
 static bool trans_mfia(DisasContext *ctx, arg_mfia *a)
 {
     unsigned rt = a->t;
-    TCGv_reg tmp = dest_gpr(ctx, rt);
-    tcg_gen_movi_reg(tmp, ctx->iaoq_f);
+    TCGv_i64 tmp = dest_gpr(ctx, rt);
+    tcg_gen_movi_i64(tmp, ctx->iaoq_f);
     save_gpr(ctx, rt, tmp);
 
     cond_free(&ctx->null_cond);
@@ -2064,7 +1966,7 @@ static bool trans_mfsp(DisasContext *ctx, arg_mfsp *a)
     unsigned rt = a->t;
     unsigned rs = a->sp;
     TCGv_i64 t0 = tcg_temp_new_i64();
-    TCGv_reg t1 = tcg_temp_new();
+    TCGv_i64 t1 = tcg_temp_new();
 
     load_spr(ctx, t0, rs);
     tcg_gen_shri_i64(t0, t0, 32);
@@ -2080,14 +1982,14 @@ static bool trans_mfctl(DisasContext *ctx, arg_mfctl *a)
 {
     unsigned rt = a->t;
     unsigned ctl = a->r;
-    TCGv_reg tmp;
+    TCGv_i64 tmp;
 
     switch (ctl) {
     case CR_SAR:
         if (a->e == 0) {
             /* MFSAR without ,W masks low 5 bits.  */
             tmp = dest_gpr(ctx, rt);
-            tcg_gen_andi_reg(tmp, cpu_sar, 31);
+            tcg_gen_andi_i64(tmp, cpu_sar, 31);
             save_gpr(ctx, rt, tmp);
             goto done;
         }
@@ -2115,7 +2017,7 @@ static bool trans_mfctl(DisasContext *ctx, arg_mfctl *a)
     }
 
     tmp = tcg_temp_new();
-    tcg_gen_ld_reg(tmp, tcg_env, offsetof(CPUHPPAState, cr[ctl]));
+    tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUHPPAState, cr[ctl]));
     save_gpr(ctx, rt, tmp);
 
  done:
@@ -2151,13 +2053,13 @@ static bool trans_mtsp(DisasContext *ctx, arg_mtsp *a)
 static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
 {
     unsigned ctl = a->t;
-    TCGv_reg reg;
-    TCGv_reg tmp;
+    TCGv_i64 reg;
+    TCGv_i64 tmp;
 
     if (ctl == CR_SAR) {
         reg = load_gpr(ctx, a->r);
         tmp = tcg_temp_new();
-        tcg_gen_andi_reg(tmp, reg, ctx->is_pa20 ? 63 : 31);
+        tcg_gen_andi_i64(tmp, reg, ctx->is_pa20 ? 63 : 31);
         save_or_nullify(ctx, cpu_sar, tmp);
 
         cond_free(&ctx->null_cond);
@@ -2188,10 +2090,10 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
         /* FIXME: Respect PSW_Q bit */
         /* The write advances the queue and stores to the back element.  */
         tmp = tcg_temp_new();
-        tcg_gen_ld_reg(tmp, tcg_env,
+        tcg_gen_ld_i64(tmp, tcg_env,
                        offsetof(CPUHPPAState, cr_back[ctl - CR_IIASQ]));
-        tcg_gen_st_reg(tmp, tcg_env, offsetof(CPUHPPAState, cr[ctl]));
-        tcg_gen_st_reg(reg, tcg_env,
+        tcg_gen_st_i64(tmp, tcg_env, offsetof(CPUHPPAState, cr[ctl]));
+        tcg_gen_st_i64(reg, tcg_env,
                        offsetof(CPUHPPAState, cr_back[ctl - CR_IIASQ]));
         break;
 
@@ -2199,14 +2101,14 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
     case CR_PID2:
     case CR_PID3:
     case CR_PID4:
-        tcg_gen_st_reg(reg, tcg_env, offsetof(CPUHPPAState, cr[ctl]));
+        tcg_gen_st_i64(reg, tcg_env, offsetof(CPUHPPAState, cr[ctl]));
 #ifndef CONFIG_USER_ONLY
         gen_helper_change_prot_id(tcg_env);
 #endif
         break;
 
     default:
-        tcg_gen_st_reg(reg, tcg_env, offsetof(CPUHPPAState, cr[ctl]));
+        tcg_gen_st_i64(reg, tcg_env, offsetof(CPUHPPAState, cr[ctl]));
         break;
     }
     return nullify_end(ctx);
@@ -2215,10 +2117,10 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
 
 static bool trans_mtsarcm(DisasContext *ctx, arg_mtsarcm *a)
 {
-    TCGv_reg tmp = tcg_temp_new();
+    TCGv_i64 tmp = tcg_temp_new();
 
-    tcg_gen_not_reg(tmp, load_gpr(ctx, a->r));
-    tcg_gen_andi_reg(tmp, tmp, ctx->is_pa20 ? 63 : 31);
+    tcg_gen_not_i64(tmp, load_gpr(ctx, a->r));
+    tcg_gen_andi_i64(tmp, tmp, ctx->is_pa20 ? 63 : 31);
     save_or_nullify(ctx, cpu_sar, tmp);
 
     cond_free(&ctx->null_cond);
@@ -2227,11 +2129,11 @@ static bool trans_mtsarcm(DisasContext *ctx, arg_mtsarcm *a)
 
 static bool trans_ldsid(DisasContext *ctx, arg_ldsid *a)
 {
-    TCGv_reg dest = dest_gpr(ctx, a->t);
+    TCGv_i64 dest = dest_gpr(ctx, a->t);
 
 #ifdef CONFIG_USER_ONLY
     /* We don't implement space registers in user mode. */
-    tcg_gen_movi_reg(dest, 0);
+    tcg_gen_movi_i64(dest, 0);
 #else
     TCGv_i64 t0 = tcg_temp_new_i64();
 
@@ -2249,13 +2151,13 @@ static bool trans_rsm(DisasContext *ctx, arg_rsm *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
 #ifndef CONFIG_USER_ONLY
-    TCGv_reg tmp;
+    TCGv_i64 tmp;
 
     nullify_over(ctx);
 
     tmp = tcg_temp_new();
-    tcg_gen_ld_reg(tmp, tcg_env, offsetof(CPUHPPAState, psw));
-    tcg_gen_andi_reg(tmp, tmp, ~a->i);
+    tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
+    tcg_gen_andi_i64(tmp, tmp, ~a->i);
     gen_helper_swap_system_mask(tmp, tcg_env, tmp);
     save_gpr(ctx, a->t, tmp);
 
@@ -2269,13 +2171,13 @@ static bool trans_ssm(DisasContext *ctx, arg_ssm *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
 #ifndef CONFIG_USER_ONLY
-    TCGv_reg tmp;
+    TCGv_i64 tmp;
 
     nullify_over(ctx);
 
     tmp = tcg_temp_new();
-    tcg_gen_ld_reg(tmp, tcg_env, offsetof(CPUHPPAState, psw));
-    tcg_gen_ori_reg(tmp, tmp, a->i);
+    tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
+    tcg_gen_ori_i64(tmp, tmp, a->i);
     gen_helper_swap_system_mask(tmp, tcg_env, tmp);
     save_gpr(ctx, a->t, tmp);
 
@@ -2289,7 +2191,7 @@ static bool trans_mtsm(DisasContext *ctx, arg_mtsm *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
 #ifndef CONFIG_USER_ONLY
-    TCGv_reg tmp, reg;
+    TCGv_i64 tmp, reg;
     nullify_over(ctx);
 
     reg = load_gpr(ctx, a->r);
@@ -2366,12 +2268,12 @@ static bool trans_getshadowregs(DisasContext *ctx, arg_getshadowregs *a)
 static bool trans_nop_addrx(DisasContext *ctx, arg_ldst *a)
 {
     if (a->m) {
-        TCGv_reg dest = dest_gpr(ctx, a->b);
-        TCGv_reg src1 = load_gpr(ctx, a->b);
-        TCGv_reg src2 = load_gpr(ctx, a->x);
+        TCGv_i64 dest = dest_gpr(ctx, a->b);
+        TCGv_i64 src1 = load_gpr(ctx, a->b);
+        TCGv_i64 src2 = load_gpr(ctx, a->x);
 
         /* The only thing we need to do is the base register modification.  */
-        tcg_gen_add_reg(dest, src1, src2);
+        tcg_gen_add_i64(dest, src1, src2);
         save_gpr(ctx, a->b, dest);
     }
     cond_free(&ctx->null_cond);
@@ -2380,9 +2282,9 @@ static bool trans_nop_addrx(DisasContext *ctx, arg_ldst *a)
 
 static bool trans_probe(DisasContext *ctx, arg_probe *a)
 {
-    TCGv_reg dest, ofs;
+    TCGv_i64 dest, ofs;
     TCGv_i32 level, want;
-    TCGv_tl addr;
+    TCGv_i64 addr;
 
     nullify_over(ctx);
 
@@ -2393,7 +2295,7 @@ static bool trans_probe(DisasContext *ctx, arg_probe *a)
         level = tcg_constant_i32(a->ri);
     } else {
         level = tcg_temp_new_i32();
-        tcg_gen_trunc_reg_i32(level, load_gpr(ctx, a->ri));
+        tcg_gen_extrl_i64_i32(level, load_gpr(ctx, a->ri));
         tcg_gen_andi_i32(level, level, 3);
     }
     want = tcg_constant_i32(a->write ? PAGE_WRITE : PAGE_READ);
@@ -2411,8 +2313,8 @@ static bool trans_ixtlbx(DisasContext *ctx, arg_ixtlbx *a)
     }
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
 #ifndef CONFIG_USER_ONLY
-    TCGv_tl addr;
-    TCGv_reg ofs, reg;
+    TCGv_i64 addr;
+    TCGv_i64 ofs, reg;
 
     nullify_over(ctx);
 
@@ -2436,8 +2338,8 @@ static bool trans_pxtlbx(DisasContext *ctx, arg_pxtlbx *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
 #ifndef CONFIG_USER_ONLY
-    TCGv_tl addr;
-    TCGv_reg ofs;
+    TCGv_i64 addr;
+    TCGv_i64 ofs;
 
     nullify_over(ctx);
 
@@ -2472,8 +2374,8 @@ static bool trans_ixtlbxf(DisasContext *ctx, arg_ixtlbxf *a)
     }
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
 #ifndef CONFIG_USER_ONLY
-    TCGv_tl addr, atl, stl;
-    TCGv_reg reg;
+    TCGv_i64 addr, atl, stl;
+    TCGv_i64 reg;
 
     nullify_over(ctx);
 
@@ -2483,9 +2385,9 @@ static bool trans_ixtlbxf(DisasContext *ctx, arg_ixtlbxf *a)
      *    return gen_illegal(ctx);
      */
 
-    atl = tcg_temp_new_tl();
-    stl = tcg_temp_new_tl();
-    addr = tcg_temp_new_tl();
+    atl = tcg_temp_new_i64();
+    stl = tcg_temp_new_i64();
+    addr = tcg_temp_new_i64();
 
     tcg_gen_ld32u_i64(stl, tcg_env,
                       a->data ? offsetof(CPUHPPAState, cr[CR_ISR])
@@ -2541,8 +2443,8 @@ static bool trans_lpa(DisasContext *ctx, arg_ldst *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
 #ifndef CONFIG_USER_ONLY
-    TCGv_tl vaddr;
-    TCGv_reg ofs, paddr;
+    TCGv_i64 vaddr;
+    TCGv_i64 ofs, paddr;
 
     nullify_over(ctx);
 
@@ -2569,7 +2471,7 @@ static bool trans_lci(DisasContext *ctx, arg_lci *a)
        physical address.  Two addresses with the same CI have a coherent
        view of the cache.  Our implementation is to return 0 for all,
        since the entire address space is coherent.  */
-    save_gpr(ctx, a->t, tcg_constant_reg(0));
+    save_gpr(ctx, a->t, tcg_constant_i64(0));
 
     cond_free(&ctx->null_cond);
     return true;
@@ -2632,12 +2534,12 @@ static bool trans_sub_b_tsv(DisasContext *ctx, arg_rrr_cf_d *a)
 
 static bool trans_andcm(DisasContext *ctx, arg_rrr_cf_d *a)
 {
-    return do_log_reg(ctx, a, tcg_gen_andc_reg);
+    return do_log_reg(ctx, a, tcg_gen_andc_i64);
 }
 
 static bool trans_and(DisasContext *ctx, arg_rrr_cf_d *a)
 {
-    return do_log_reg(ctx, a, tcg_gen_and_reg);
+    return do_log_reg(ctx, a, tcg_gen_and_i64);
 }
 
 static bool trans_or(DisasContext *ctx, arg_rrr_cf_d *a)
@@ -2653,8 +2555,8 @@ static bool trans_or(DisasContext *ctx, arg_rrr_cf_d *a)
         }
         if (r2 == 0) { /* COPY */
             if (r1 == 0) {
-                TCGv_reg dest = dest_gpr(ctx, rt);
-                tcg_gen_movi_reg(dest, 0);
+                TCGv_i64 dest = dest_gpr(ctx, rt);
+                tcg_gen_movi_i64(dest, 0);
                 save_gpr(ctx, rt, dest);
             } else {
                 save_gpr(ctx, rt, cpu_gr[r1]);
@@ -2689,17 +2591,17 @@ static bool trans_or(DisasContext *ctx, arg_rrr_cf_d *a)
         }
 #endif
     }
-    return do_log_reg(ctx, a, tcg_gen_or_reg);
+    return do_log_reg(ctx, a, tcg_gen_or_i64);
 }
 
 static bool trans_xor(DisasContext *ctx, arg_rrr_cf_d *a)
 {
-    return do_log_reg(ctx, a, tcg_gen_xor_reg);
+    return do_log_reg(ctx, a, tcg_gen_xor_i64);
 }
 
 static bool trans_cmpclr(DisasContext *ctx, arg_rrr_cf_d *a)
 {
-    TCGv_reg tcg_r1, tcg_r2;
+    TCGv_i64 tcg_r1, tcg_r2;
 
     if (a->cf) {
         nullify_over(ctx);
@@ -2712,20 +2614,20 @@ static bool trans_cmpclr(DisasContext *ctx, arg_rrr_cf_d *a)
 
 static bool trans_uxor(DisasContext *ctx, arg_rrr_cf_d *a)
 {
-    TCGv_reg tcg_r1, tcg_r2;
+    TCGv_i64 tcg_r1, tcg_r2;
 
     if (a->cf) {
         nullify_over(ctx);
     }
     tcg_r1 = load_gpr(ctx, a->r1);
     tcg_r2 = load_gpr(ctx, a->r2);
-    do_unit(ctx, a->t, tcg_r1, tcg_r2, a->cf, a->d, false, tcg_gen_xor_reg);
+    do_unit(ctx, a->t, tcg_r1, tcg_r2, a->cf, a->d, false, tcg_gen_xor_i64);
     return nullify_end(ctx);
 }
 
 static bool do_uaddcm(DisasContext *ctx, arg_rrr_cf_d *a, bool is_tc)
 {
-    TCGv_reg tcg_r1, tcg_r2, tmp;
+    TCGv_i64 tcg_r1, tcg_r2, tmp;
 
     if (a->cf) {
         nullify_over(ctx);
@@ -2733,8 +2635,8 @@ static bool do_uaddcm(DisasContext *ctx, arg_rrr_cf_d *a, bool is_tc)
     tcg_r1 = load_gpr(ctx, a->r1);
     tcg_r2 = load_gpr(ctx, a->r2);
     tmp = tcg_temp_new();
-    tcg_gen_not_reg(tmp, tcg_r2);
-    do_unit(ctx, a->t, tcg_r1, tmp, a->cf, a->d, is_tc, tcg_gen_add_reg);
+    tcg_gen_not_i64(tmp, tcg_r2);
+    do_unit(ctx, a->t, tcg_r1, tmp, a->cf, a->d, is_tc, tcg_gen_add_i64);
     return nullify_end(ctx);
 }
 
@@ -2750,19 +2652,19 @@ static bool trans_uaddcm_tc(DisasContext *ctx, arg_rrr_cf_d *a)
 
 static bool do_dcor(DisasContext *ctx, arg_rr_cf_d *a, bool is_i)
 {
-    TCGv_reg tmp;
+    TCGv_i64 tmp;
 
     nullify_over(ctx);
 
     tmp = tcg_temp_new();
-    tcg_gen_shri_reg(tmp, cpu_psw_cb, 3);
+    tcg_gen_shri_i64(tmp, cpu_psw_cb, 3);
     if (!is_i) {
-        tcg_gen_not_reg(tmp, tmp);
+        tcg_gen_not_i64(tmp, tmp);
     }
-    tcg_gen_andi_reg(tmp, tmp, (uint64_t)0x1111111111111111ull);
-    tcg_gen_muli_reg(tmp, tmp, 6);
+    tcg_gen_andi_i64(tmp, tmp, (uint64_t)0x1111111111111111ull);
+    tcg_gen_muli_i64(tmp, tmp, 6);
     do_unit(ctx, a->t, load_gpr(ctx, a->r), tmp, a->cf, a->d, false,
-            is_i ? tcg_gen_add_reg : tcg_gen_sub_reg);
+            is_i ? tcg_gen_add_i64 : tcg_gen_sub_i64);
     return nullify_end(ctx);
 }
 
@@ -2778,8 +2680,8 @@ static bool trans_dcor_i(DisasContext *ctx, arg_rr_cf_d *a)
 
 static bool trans_ds(DisasContext *ctx, arg_rrr_cf *a)
 {
-    TCGv_reg dest, add1, add2, addc, zero, in1, in2;
-    TCGv_reg cout;
+    TCGv_i64 dest, add1, add2, addc, zero, in1, in2;
+    TCGv_i64 cout;
 
     nullify_over(ctx);
 
@@ -2790,11 +2692,11 @@ static bool trans_ds(DisasContext *ctx, arg_rrr_cf *a)
     add2 = tcg_temp_new();
     addc = tcg_temp_new();
     dest = tcg_temp_new();
-    zero = tcg_constant_reg(0);
+    zero = tcg_constant_i64(0);
 
     /* Form R1 << 1 | PSW[CB]{8}.  */
-    tcg_gen_add_reg(add1, in1, in1);
-    tcg_gen_add_reg(add1, add1, get_psw_carry(ctx, false));
+    tcg_gen_add_i64(add1, in1, in1);
+    tcg_gen_add_i64(add1, add1, get_psw_carry(ctx, false));
 
     /*
      * Add or subtract R2, depending on PSW[V].  Proper computation of
@@ -2802,28 +2704,28 @@ static bool trans_ds(DisasContext *ctx, arg_rrr_cf *a)
      * the manual.  By extracting and masking V, we can produce the
      * proper inputs to the addition without movcond.
      */
-    tcg_gen_sextract_reg(addc, cpu_psw_v, 31, 1);
-    tcg_gen_xor_reg(add2, in2, addc);
-    tcg_gen_andi_reg(addc, addc, 1);
+    tcg_gen_sextract_i64(addc, cpu_psw_v, 31, 1);
+    tcg_gen_xor_i64(add2, in2, addc);
+    tcg_gen_andi_i64(addc, addc, 1);
 
-    tcg_gen_add2_reg(dest, cpu_psw_cb_msb, add1, zero, add2, zero);
-    tcg_gen_add2_reg(dest, cpu_psw_cb_msb, dest, cpu_psw_cb_msb, addc, zero);
+    tcg_gen_add2_i64(dest, cpu_psw_cb_msb, add1, zero, add2, zero);
+    tcg_gen_add2_i64(dest, cpu_psw_cb_msb, dest, cpu_psw_cb_msb, addc, zero);
 
     /* Write back the result register.  */
     save_gpr(ctx, a->t, dest);
 
     /* Write back PSW[CB].  */
-    tcg_gen_xor_reg(cpu_psw_cb, add1, add2);
-    tcg_gen_xor_reg(cpu_psw_cb, cpu_psw_cb, dest);
+    tcg_gen_xor_i64(cpu_psw_cb, add1, add2);
+    tcg_gen_xor_i64(cpu_psw_cb, cpu_psw_cb, dest);
 
     /* Write back PSW[V] for the division step.  */
     cout = get_psw_carry(ctx, false);
-    tcg_gen_neg_reg(cpu_psw_v, cout);
-    tcg_gen_xor_reg(cpu_psw_v, cpu_psw_v, in2);
+    tcg_gen_neg_i64(cpu_psw_v, cout);
+    tcg_gen_xor_i64(cpu_psw_v, cpu_psw_v, in2);
 
     /* Install the new nullification.  */
     if (a->cf) {
-        TCGv_reg sv = NULL;
+        TCGv_i64 sv = NULL;
         if (cond_need_sv(a->cf >> 1)) {
             /* ??? The lshift is supposed to contribute to overflow.  */
             sv = do_add_sv(ctx, dest, add1, add2);
@@ -2866,13 +2768,13 @@ static bool trans_subi_tsv(DisasContext *ctx, arg_rri_cf *a)
 
 static bool trans_cmpiclr(DisasContext *ctx, arg_rri_cf_d *a)
 {
-    TCGv_reg tcg_im, tcg_r2;
+    TCGv_i64 tcg_im, tcg_r2;
 
     if (a->cf) {
         nullify_over(ctx);
     }
 
-    tcg_im = tcg_constant_reg(a->i);
+    tcg_im = tcg_constant_i64(a->i);
     tcg_r2 = load_gpr(ctx, a->r);
     do_cmpclr(ctx, a->t, tcg_im, tcg_r2, a->cf, a->d);
 
@@ -2900,8 +2802,8 @@ static bool trans_st(DisasContext *ctx, arg_ldst *a)
 static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
 {
     MemOp mop = MO_TE | MO_ALIGN | a->size;
-    TCGv_reg zero, dest, ofs;
-    TCGv_tl addr;
+    TCGv_i64 zero, dest, ofs;
+    TCGv_i64 addr;
 
     if (!ctx->is_pa20 && a->size > MO_32) {
         return gen_illegal(ctx);
@@ -2930,8 +2832,8 @@ static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
      */
     gen_helper_ldc_check(addr);
 
-    zero = tcg_constant_reg(0);
-    tcg_gen_atomic_xchg_reg(dest, addr, zero, ctx->mmu_idx, mop);
+    zero = tcg_constant_i64(0);
+    tcg_gen_atomic_xchg_i64(dest, addr, zero, ctx->mmu_idx, mop);
 
     if (a->m) {
         save_gpr(ctx, a->b, ofs);
@@ -2943,8 +2845,8 @@ static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
 
 static bool trans_stby(DisasContext *ctx, arg_stby *a)
 {
-    TCGv_reg ofs, val;
-    TCGv_tl addr;
+    TCGv_i64 ofs, val;
+    TCGv_i64 addr;
 
     nullify_over(ctx);
 
@@ -2965,7 +2867,7 @@ static bool trans_stby(DisasContext *ctx, arg_stby *a)
         }
     }
     if (a->m) {
-        tcg_gen_andi_reg(ofs, ofs, ~3);
+        tcg_gen_andi_i64(ofs, ofs, ~3);
         save_gpr(ctx, a->b, ofs);
     }
 
@@ -2974,8 +2876,8 @@ static bool trans_stby(DisasContext *ctx, arg_stby *a)
 
 static bool trans_stdby(DisasContext *ctx, arg_stby *a)
 {
-    TCGv_reg ofs, val;
-    TCGv_tl addr;
+    TCGv_i64 ofs, val;
+    TCGv_i64 addr;
 
     nullify_over(ctx);
 
@@ -2996,7 +2898,7 @@ static bool trans_stdby(DisasContext *ctx, arg_stby *a)
         }
     }
     if (a->m) {
-        tcg_gen_andi_reg(ofs, ofs, ~7);
+        tcg_gen_andi_i64(ofs, ofs, ~7);
         save_gpr(ctx, a->b, ofs);
     }
 
@@ -3027,9 +2929,9 @@ static bool trans_sta(DisasContext *ctx, arg_ldst *a)
 
 static bool trans_ldil(DisasContext *ctx, arg_ldil *a)
 {
-    TCGv_reg tcg_rt = dest_gpr(ctx, a->t);
+    TCGv_i64 tcg_rt = dest_gpr(ctx, a->t);
 
-    tcg_gen_movi_reg(tcg_rt, a->i);
+    tcg_gen_movi_i64(tcg_rt, a->i);
     save_gpr(ctx, a->t, tcg_rt);
     cond_free(&ctx->null_cond);
     return true;
@@ -3037,10 +2939,10 @@ static bool trans_ldil(DisasContext *ctx, arg_ldil *a)
 
 static bool trans_addil(DisasContext *ctx, arg_addil *a)
 {
-    TCGv_reg tcg_rt = load_gpr(ctx, a->r);
-    TCGv_reg tcg_r1 = dest_gpr(ctx, 1);
+    TCGv_i64 tcg_rt = load_gpr(ctx, a->r);
+    TCGv_i64 tcg_r1 = dest_gpr(ctx, 1);
 
-    tcg_gen_addi_reg(tcg_r1, tcg_rt, a->i);
+    tcg_gen_addi_i64(tcg_r1, tcg_rt, a->i);
     save_gpr(ctx, 1, tcg_r1);
     cond_free(&ctx->null_cond);
     return true;
@@ -3048,30 +2950,30 @@ static bool trans_addil(DisasContext *ctx, arg_addil *a)
 
 static bool trans_ldo(DisasContext *ctx, arg_ldo *a)
 {
-    TCGv_reg tcg_rt = dest_gpr(ctx, a->t);
+    TCGv_i64 tcg_rt = dest_gpr(ctx, a->t);
 
     /* Special case rb == 0, for the LDI pseudo-op.
        The COPY pseudo-op is handled for free within tcg_gen_addi_tl.  */
     if (a->b == 0) {
-        tcg_gen_movi_reg(tcg_rt, a->i);
+        tcg_gen_movi_i64(tcg_rt, a->i);
     } else {
-        tcg_gen_addi_reg(tcg_rt, cpu_gr[a->b], a->i);
+        tcg_gen_addi_i64(tcg_rt, cpu_gr[a->b], a->i);
     }
     save_gpr(ctx, a->t, tcg_rt);
     cond_free(&ctx->null_cond);
     return true;
 }
 
-static bool do_cmpb(DisasContext *ctx, unsigned r, TCGv_reg in1,
+static bool do_cmpb(DisasContext *ctx, unsigned r, TCGv_i64 in1,
                     unsigned c, unsigned f, bool d, unsigned n, int disp)
 {
-    TCGv_reg dest, in2, sv;
+    TCGv_i64 dest, in2, sv;
     DisasCond cond;
 
     in2 = load_gpr(ctx, r);
     dest = tcg_temp_new();
 
-    tcg_gen_sub_reg(dest, in1, in2);
+    tcg_gen_sub_i64(dest, in1, in2);
 
     sv = NULL;
     if (cond_need_sv(c)) {
@@ -3098,14 +3000,14 @@ static bool trans_cmpbi(DisasContext *ctx, arg_cmpbi *a)
         return false;
     }
     nullify_over(ctx);
-    return do_cmpb(ctx, a->r, tcg_constant_reg(a->i),
+    return do_cmpb(ctx, a->r, tcg_constant_i64(a->i),
                    a->c, a->f, a->d, a->n, a->disp);
 }
 
-static bool do_addb(DisasContext *ctx, unsigned r, TCGv_reg in1,
+static bool do_addb(DisasContext *ctx, unsigned r, TCGv_i64 in1,
                     unsigned c, unsigned f, unsigned n, int disp)
 {
-    TCGv_reg dest, in2, sv, cb_cond;
+    TCGv_i64 dest, in2, sv, cb_cond;
     DisasCond cond;
     bool d = false;
 
@@ -3126,16 +3028,16 @@ static bool do_addb(DisasContext *ctx, unsigned r, TCGv_reg in1,
     cb_cond = NULL;
 
     if (cond_need_cb(c)) {
-        TCGv_reg cb = tcg_temp_new();
-        TCGv_reg cb_msb = tcg_temp_new();
+        TCGv_i64 cb = tcg_temp_new();
+        TCGv_i64 cb_msb = tcg_temp_new();
 
-        tcg_gen_movi_reg(cb_msb, 0);
-        tcg_gen_add2_reg(dest, cb_msb, in1, cb_msb, in2, cb_msb);
-        tcg_gen_xor_reg(cb, in1, in2);
-        tcg_gen_xor_reg(cb, cb, dest);
+        tcg_gen_movi_i64(cb_msb, 0);
+        tcg_gen_add2_i64(dest, cb_msb, in1, cb_msb, in2, cb_msb);
+        tcg_gen_xor_i64(cb, in1, in2);
+        tcg_gen_xor_i64(cb, cb, dest);
         cb_cond = get_carry(ctx, d, cb, cb_msb);
     } else {
-        tcg_gen_add_reg(dest, in1, in2);
+        tcg_gen_add_i64(dest, in1, in2);
     }
     if (cond_need_sv(c)) {
         sv = do_add_sv(ctx, dest, in1, in2);
@@ -3155,12 +3057,12 @@ static bool trans_addb(DisasContext *ctx, arg_addb *a)
 static bool trans_addbi(DisasContext *ctx, arg_addbi *a)
 {
     nullify_over(ctx);
-    return do_addb(ctx, a->r, tcg_constant_reg(a->i), a->c, a->f, a->n, a->disp);
+    return do_addb(ctx, a->r, tcg_constant_i64(a->i), a->c, a->f, a->n, a->disp);
 }
 
 static bool trans_bb_sar(DisasContext *ctx, arg_bb_sar *a)
 {
-    TCGv_reg tmp, tcg_r;
+    TCGv_i64 tmp, tcg_r;
     DisasCond cond;
 
     nullify_over(ctx);
@@ -3169,10 +3071,10 @@ static bool trans_bb_sar(DisasContext *ctx, arg_bb_sar *a)
     tcg_r = load_gpr(ctx, a->r);
     if (cond_need_ext(ctx, a->d)) {
         /* Force shift into [32,63] */
-        tcg_gen_ori_reg(tmp, cpu_sar, 32);
-        tcg_gen_shl_reg(tmp, tcg_r, tmp);
+        tcg_gen_ori_i64(tmp, cpu_sar, 32);
+        tcg_gen_shl_i64(tmp, tcg_r, tmp);
     } else {
-        tcg_gen_shl_reg(tmp, tcg_r, cpu_sar);
+        tcg_gen_shl_i64(tmp, tcg_r, cpu_sar);
     }
 
     cond = cond_make_0_tmp(a->c ? TCG_COND_GE : TCG_COND_LT, tmp);
@@ -3181,7 +3083,7 @@ static bool trans_bb_sar(DisasContext *ctx, arg_bb_sar *a)
 
 static bool trans_bb_imm(DisasContext *ctx, arg_bb_imm *a)
 {
-    TCGv_reg tmp, tcg_r;
+    TCGv_i64 tmp, tcg_r;
     DisasCond cond;
     int p;
 
@@ -3190,7 +3092,7 @@ static bool trans_bb_imm(DisasContext *ctx, arg_bb_imm *a)
     tmp = tcg_temp_new();
     tcg_r = load_gpr(ctx, a->r);
     p = a->p | (cond_need_ext(ctx, a->d) ? 32 : 0);
-    tcg_gen_shli_reg(tmp, tcg_r, p);
+    tcg_gen_shli_i64(tmp, tcg_r, p);
 
     cond = cond_make_0(a->c ? TCG_COND_GE : TCG_COND_LT, tmp);
     return do_cbranch(ctx, a->disp, a->n, &cond);
@@ -3198,16 +3100,16 @@ static bool trans_bb_imm(DisasContext *ctx, arg_bb_imm *a)
 
 static bool trans_movb(DisasContext *ctx, arg_movb *a)
 {
-    TCGv_reg dest;
+    TCGv_i64 dest;
     DisasCond cond;
 
     nullify_over(ctx);
 
     dest = dest_gpr(ctx, a->r2);
     if (a->r1 == 0) {
-        tcg_gen_movi_reg(dest, 0);
+        tcg_gen_movi_i64(dest, 0);
     } else {
-        tcg_gen_mov_reg(dest, cpu_gr[a->r1]);
+        tcg_gen_mov_i64(dest, cpu_gr[a->r1]);
     }
 
     /* All MOVB conditions are 32-bit. */
@@ -3217,13 +3119,13 @@ static bool trans_movb(DisasContext *ctx, arg_movb *a)
 
 static bool trans_movbi(DisasContext *ctx, arg_movbi *a)
 {
-    TCGv_reg dest;
+    TCGv_i64 dest;
     DisasCond cond;
 
     nullify_over(ctx);
 
     dest = dest_gpr(ctx, a->r);
-    tcg_gen_movi_reg(dest, a->i);
+    tcg_gen_movi_i64(dest, a->i);
 
     /* All MOVBI conditions are 32-bit. */
     cond = do_sed_cond(ctx, a->c, false, dest);
@@ -3232,7 +3134,7 @@ static bool trans_movbi(DisasContext *ctx, arg_movbi *a)
 
 static bool trans_shrp_sar(DisasContext *ctx, arg_shrp_sar *a)
 {
-    TCGv_reg dest, src2;
+    TCGv_i64 dest, src2;
 
     if (!ctx->is_pa20 && a->d) {
         return false;
@@ -3245,44 +3147,44 @@ static bool trans_shrp_sar(DisasContext *ctx, arg_shrp_sar *a)
     src2 = load_gpr(ctx, a->r2);
     if (a->r1 == 0) {
         if (a->d) {
-            tcg_gen_shr_reg(dest, src2, cpu_sar);
+            tcg_gen_shr_i64(dest, src2, cpu_sar);
         } else {
-            TCGv_reg tmp = tcg_temp_new();
+            TCGv_i64 tmp = tcg_temp_new();
 
-            tcg_gen_ext32u_reg(dest, src2);
-            tcg_gen_andi_reg(tmp, cpu_sar, 31);
-            tcg_gen_shr_reg(dest, dest, tmp);
+            tcg_gen_ext32u_i64(dest, src2);
+            tcg_gen_andi_i64(tmp, cpu_sar, 31);
+            tcg_gen_shr_i64(dest, dest, tmp);
         }
     } else if (a->r1 == a->r2) {
         if (a->d) {
-            tcg_gen_rotr_reg(dest, src2, cpu_sar);
+            tcg_gen_rotr_i64(dest, src2, cpu_sar);
         } else {
             TCGv_i32 t32 = tcg_temp_new_i32();
             TCGv_i32 s32 = tcg_temp_new_i32();
 
-            tcg_gen_trunc_reg_i32(t32, src2);
-            tcg_gen_trunc_reg_i32(s32, cpu_sar);
+            tcg_gen_extrl_i64_i32(t32, src2);
+            tcg_gen_extrl_i64_i32(s32, cpu_sar);
             tcg_gen_andi_i32(s32, s32, 31);
             tcg_gen_rotr_i32(t32, t32, s32);
-            tcg_gen_extu_i32_reg(dest, t32);
+            tcg_gen_extu_i32_i64(dest, t32);
         }
     } else {
-        TCGv_reg src1 = load_gpr(ctx, a->r1);
+        TCGv_i64 src1 = load_gpr(ctx, a->r1);
 
         if (a->d) {
-            TCGv_reg t = tcg_temp_new();
-            TCGv_reg n = tcg_temp_new();
+            TCGv_i64 t = tcg_temp_new();
+            TCGv_i64 n = tcg_temp_new();
 
-            tcg_gen_xori_reg(n, cpu_sar, 63);
-            tcg_gen_shl_reg(t, src2, n);
-            tcg_gen_shli_reg(t, t, 1);
-            tcg_gen_shr_reg(dest, src1, cpu_sar);
-            tcg_gen_or_reg(dest, dest, t);
+            tcg_gen_xori_i64(n, cpu_sar, 63);
+            tcg_gen_shl_i64(t, src2, n);
+            tcg_gen_shli_i64(t, t, 1);
+            tcg_gen_shr_i64(dest, src1, cpu_sar);
+            tcg_gen_or_i64(dest, dest, t);
         } else {
             TCGv_i64 t = tcg_temp_new_i64();
             TCGv_i64 s = tcg_temp_new_i64();
 
-            tcg_gen_concat_reg_i64(t, src2, src1);
+            tcg_gen_concat32_i64(t, src2, src1);
             tcg_gen_extu_reg_i64(s, cpu_sar);
             tcg_gen_andi_i64(s, s, 31);
             tcg_gen_shr_i64(t, t, s);
@@ -3302,7 +3204,7 @@ static bool trans_shrp_sar(DisasContext *ctx, arg_shrp_sar *a)
 static bool trans_shrp_imm(DisasContext *ctx, arg_shrp_imm *a)
 {
     unsigned width, sa;
-    TCGv_reg dest, t2;
+    TCGv_i64 dest, t2;
 
     if (!ctx->is_pa20 && a->d) {
         return false;
@@ -3317,19 +3219,19 @@ static bool trans_shrp_imm(DisasContext *ctx, arg_shrp_imm *a)
     dest = dest_gpr(ctx, a->t);
     t2 = load_gpr(ctx, a->r2);
     if (a->r1 == 0) {
-        tcg_gen_extract_reg(dest, t2, sa, width - sa);
+        tcg_gen_extract_i64(dest, t2, sa, width - sa);
     } else if (width == TARGET_LONG_BITS) {
-        tcg_gen_extract2_reg(dest, t2, cpu_gr[a->r1], sa);
+        tcg_gen_extract2_i64(dest, t2, cpu_gr[a->r1], sa);
     } else {
         assert(!a->d);
         if (a->r1 == a->r2) {
             TCGv_i32 t32 = tcg_temp_new_i32();
-            tcg_gen_trunc_reg_i32(t32, t2);
+            tcg_gen_extrl_i64_i32(t32, t2);
             tcg_gen_rotri_i32(t32, t32, sa);
-            tcg_gen_extu_i32_reg(dest, t32);
+            tcg_gen_extu_i32_i64(dest, t32);
         } else {
             TCGv_i64 t64 = tcg_temp_new_i64();
-            tcg_gen_concat_reg_i64(t64, t2, cpu_gr[a->r1]);
+            tcg_gen_concat32_i64(t64, t2, cpu_gr[a->r1]);
             tcg_gen_shri_i64(t64, t64, sa);
             tcg_gen_trunc_i64_reg(dest, t64);
         }
@@ -3347,7 +3249,7 @@ static bool trans_shrp_imm(DisasContext *ctx, arg_shrp_imm *a)
 static bool trans_extr_sar(DisasContext *ctx, arg_extr_sar *a)
 {
     unsigned widthm1 = a->d ? 63 : 31;
-    TCGv_reg dest, src, tmp;
+    TCGv_i64 dest, src, tmp;
 
     if (!ctx->is_pa20 && a->d) {
         return false;
@@ -3361,23 +3263,23 @@ static bool trans_extr_sar(DisasContext *ctx, arg_extr_sar *a)
     tmp = tcg_temp_new();
 
     /* Recall that SAR is using big-endian bit numbering.  */
-    tcg_gen_andi_reg(tmp, cpu_sar, widthm1);
-    tcg_gen_xori_reg(tmp, tmp, widthm1);
+    tcg_gen_andi_i64(tmp, cpu_sar, widthm1);
+    tcg_gen_xori_i64(tmp, tmp, widthm1);
 
     if (a->se) {
         if (!a->d) {
-            tcg_gen_ext32s_reg(dest, src);
+            tcg_gen_ext32s_i64(dest, src);
             src = dest;
         }
-        tcg_gen_sar_reg(dest, src, tmp);
-        tcg_gen_sextract_reg(dest, dest, 0, a->len);
+        tcg_gen_sar_i64(dest, src, tmp);
+        tcg_gen_sextract_i64(dest, dest, 0, a->len);
     } else {
         if (!a->d) {
-            tcg_gen_ext32u_reg(dest, src);
+            tcg_gen_ext32u_i64(dest, src);
             src = dest;
         }
-        tcg_gen_shr_reg(dest, src, tmp);
-        tcg_gen_extract_reg(dest, dest, 0, a->len);
+        tcg_gen_shr_i64(dest, src, tmp);
+        tcg_gen_extract_i64(dest, dest, 0, a->len);
     }
     save_gpr(ctx, a->t, dest);
 
@@ -3392,7 +3294,7 @@ static bool trans_extr_sar(DisasContext *ctx, arg_extr_sar *a)
 static bool trans_extr_imm(DisasContext *ctx, arg_extr_imm *a)
 {
     unsigned len, cpos, width;
-    TCGv_reg dest, src;
+    TCGv_i64 dest, src;
 
     if (!ctx->is_pa20 && a->d) {
         return false;
@@ -3411,9 +3313,9 @@ static bool trans_extr_imm(DisasContext *ctx, arg_extr_imm *a)
     dest = dest_gpr(ctx, a->t);
     src = load_gpr(ctx, a->r);
     if (a->se) {
-        tcg_gen_sextract_reg(dest, src, cpos, len);
+        tcg_gen_sextract_i64(dest, src, cpos, len);
     } else {
-        tcg_gen_extract_reg(dest, src, cpos, len);
+        tcg_gen_extract_i64(dest, src, cpos, len);
     }
     save_gpr(ctx, a->t, dest);
 
@@ -3429,7 +3331,7 @@ static bool trans_depi_imm(DisasContext *ctx, arg_depi_imm *a)
 {
     unsigned len, width;
     uint64_t mask0, mask1;
-    TCGv_reg dest;
+    TCGv_i64 dest;
 
     if (!ctx->is_pa20 && a->d) {
         return false;
@@ -3449,11 +3351,11 @@ static bool trans_depi_imm(DisasContext *ctx, arg_depi_imm *a)
     mask1 = deposit64(-1, a->cpos, len, a->i);
 
     if (a->nz) {
-        TCGv_reg src = load_gpr(ctx, a->t);
-        tcg_gen_andi_reg(dest, src, mask1);
-        tcg_gen_ori_reg(dest, dest, mask0);
+        TCGv_i64 src = load_gpr(ctx, a->t);
+        tcg_gen_andi_i64(dest, src, mask1);
+        tcg_gen_ori_i64(dest, dest, mask0);
     } else {
-        tcg_gen_movi_reg(dest, mask0);
+        tcg_gen_movi_i64(dest, mask0);
     }
     save_gpr(ctx, a->t, dest);
 
@@ -3469,7 +3371,7 @@ static bool trans_dep_imm(DisasContext *ctx, arg_dep_imm *a)
 {
     unsigned rs = a->nz ? a->t : 0;
     unsigned len, width;
-    TCGv_reg dest, val;
+    TCGv_i64 dest, val;
 
     if (!ctx->is_pa20 && a->d) {
         return false;
@@ -3487,9 +3389,9 @@ static bool trans_dep_imm(DisasContext *ctx, arg_dep_imm *a)
     dest = dest_gpr(ctx, a->t);
     val = load_gpr(ctx, a->r);
     if (rs == 0) {
-        tcg_gen_deposit_z_reg(dest, val, a->cpos, len);
+        tcg_gen_deposit_z_i64(dest, val, a->cpos, len);
     } else {
-        tcg_gen_deposit_reg(dest, cpu_gr[rs], val, a->cpos, len);
+        tcg_gen_deposit_i64(dest, cpu_gr[rs], val, a->cpos, len);
     }
     save_gpr(ctx, a->t, dest);
 
@@ -3502,11 +3404,11 @@ static bool trans_dep_imm(DisasContext *ctx, arg_dep_imm *a)
 }
 
 static bool do_dep_sar(DisasContext *ctx, unsigned rt, unsigned c,
-                       bool d, bool nz, unsigned len, TCGv_reg val)
+                       bool d, bool nz, unsigned len, TCGv_i64 val)
 {
     unsigned rs = nz ? rt : 0;
     unsigned widthm1 = d ? 63 : 31;
-    TCGv_reg mask, tmp, shift, dest;
+    TCGv_i64 mask, tmp, shift, dest;
     uint64_t msb = 1ULL << (len - 1);
 
     dest = dest_gpr(ctx, rt);
@@ -3514,19 +3416,19 @@ static bool do_dep_sar(DisasContext *ctx, unsigned rt, unsigned c,
     tmp = tcg_temp_new();
 
     /* Convert big-endian bit numbering in SAR to left-shift.  */
-    tcg_gen_andi_reg(shift, cpu_sar, widthm1);
-    tcg_gen_xori_reg(shift, shift, widthm1);
+    tcg_gen_andi_i64(shift, cpu_sar, widthm1);
+    tcg_gen_xori_i64(shift, shift, widthm1);
 
     mask = tcg_temp_new();
-    tcg_gen_movi_reg(mask, msb + (msb - 1));
-    tcg_gen_and_reg(tmp, val, mask);
+    tcg_gen_movi_i64(mask, msb + (msb - 1));
+    tcg_gen_and_i64(tmp, val, mask);
     if (rs) {
-        tcg_gen_shl_reg(mask, mask, shift);
-        tcg_gen_shl_reg(tmp, tmp, shift);
-        tcg_gen_andc_reg(dest, cpu_gr[rs], mask);
-        tcg_gen_or_reg(dest, dest, tmp);
+        tcg_gen_shl_i64(mask, mask, shift);
+        tcg_gen_shl_i64(tmp, tmp, shift);
+        tcg_gen_andc_i64(dest, cpu_gr[rs], mask);
+        tcg_gen_or_i64(dest, dest, tmp);
     } else {
-        tcg_gen_shl_reg(dest, tmp, shift);
+        tcg_gen_shl_i64(dest, tmp, shift);
     }
     save_gpr(ctx, rt, dest);
 
@@ -3559,12 +3461,12 @@ static bool trans_depi_sar(DisasContext *ctx, arg_depi_sar *a)
         nullify_over(ctx);
     }
     return do_dep_sar(ctx, a->t, a->c, a->d, a->nz, a->len,
-                      tcg_constant_reg(a->i));
+                      tcg_constant_i64(a->i));
 }
 
 static bool trans_be(DisasContext *ctx, arg_be *a)
 {
-    TCGv_reg tmp;
+    TCGv_i64 tmp;
 
 #ifdef CONFIG_USER_ONLY
     /* ??? It seems like there should be a good way of using
@@ -3583,7 +3485,7 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
 #endif
 
     tmp = tcg_temp_new();
-    tcg_gen_addi_reg(tmp, load_gpr(ctx, a->b), a->disp);
+    tcg_gen_addi_i64(tmp, load_gpr(ctx, a->b), a->disp);
     tmp = do_ibranch_priv(ctx, tmp);
 
 #ifdef CONFIG_USER_ONLY
@@ -3598,7 +3500,7 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
     }
     if (a->n && use_nullify_skip(ctx)) {
         copy_iaoq_entry(ctx, cpu_iaoq_f, -1, tmp);
-        tcg_gen_addi_reg(tmp, tmp, 4);
+        tcg_gen_addi_i64(tmp, tmp, 4);
         copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);
         tcg_gen_mov_i64(cpu_iasq_f, new_spc);
         tcg_gen_mov_i64(cpu_iasq_b, cpu_iasq_f);
@@ -3666,11 +3568,11 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
 #endif
 
     if (a->l) {
-        TCGv_reg tmp = dest_gpr(ctx, a->l);
+        TCGv_i64 tmp = dest_gpr(ctx, a->l);
         if (ctx->privilege < 3) {
-            tcg_gen_andi_reg(tmp, tmp, -4);
+            tcg_gen_andi_i64(tmp, tmp, -4);
         }
-        tcg_gen_ori_reg(tmp, tmp, ctx->privilege);
+        tcg_gen_ori_i64(tmp, tmp, ctx->privilege);
         save_gpr(ctx, a->l, tmp);
     }
 
@@ -3680,9 +3582,9 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
 static bool trans_blr(DisasContext *ctx, arg_blr *a)
 {
     if (a->x) {
-        TCGv_reg tmp = tcg_temp_new();
-        tcg_gen_shli_reg(tmp, load_gpr(ctx, a->x), 3);
-        tcg_gen_addi_reg(tmp, tmp, ctx->iaoq_f + 8);
+        TCGv_i64 tmp = tcg_temp_new();
+        tcg_gen_shli_i64(tmp, load_gpr(ctx, a->x), 3);
+        tcg_gen_addi_i64(tmp, tmp, ctx->iaoq_f + 8);
         /* The computation here never changes privilege level.  */
         return do_ibranch(ctx, tmp, a->l, a->n);
     } else {
@@ -3693,14 +3595,14 @@ static bool trans_blr(DisasContext *ctx, arg_blr *a)
 
 static bool trans_bv(DisasContext *ctx, arg_bv *a)
 {
-    TCGv_reg dest;
+    TCGv_i64 dest;
 
     if (a->x == 0) {
         dest = load_gpr(ctx, a->b);
     } else {
         dest = tcg_temp_new();
-        tcg_gen_shli_reg(dest, load_gpr(ctx, a->x), 3);
-        tcg_gen_add_reg(dest, dest, load_gpr(ctx, a->b));
+        tcg_gen_shli_i64(dest, load_gpr(ctx, a->x), 3);
+        tcg_gen_add_i64(dest, dest, load_gpr(ctx, a->b));
     }
     dest = do_ibranch_priv(ctx, dest);
     return do_ibranch(ctx, dest, 0, a->n);
@@ -3708,7 +3610,7 @@ static bool trans_bv(DisasContext *ctx, arg_bv *a)
 
 static bool trans_bve(DisasContext *ctx, arg_bve *a)
 {
-    TCGv_reg dest;
+    TCGv_i64 dest;
 
 #ifdef CONFIG_USER_ONLY
     dest = do_ibranch_priv(ctx, load_gpr(ctx, a->b));
@@ -4031,12 +3933,12 @@ static bool trans_fcmp_d(DisasContext *ctx, arg_fclass2 *a)
 
 static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
 {
-    TCGv_reg t;
+    TCGv_i64 t;
 
     nullify_over(ctx);
 
     t = tcg_temp_new();
-    tcg_gen_ld32u_reg(t, tcg_env, offsetof(CPUHPPAState, fr0_shadow));
+    tcg_gen_ld32u_i64(t, tcg_env, offsetof(CPUHPPAState, fr0_shadow));
 
     if (a->y == 1) {
         int mask;
@@ -4044,7 +3946,7 @@ static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
 
         switch (a->c) {
         case 0: /* simple */
-            tcg_gen_andi_reg(t, t, 0x4000000);
+            tcg_gen_andi_i64(t, t, 0x4000000);
             ctx->null_cond = cond_make_0(TCG_COND_NE, t);
             goto done;
         case 2: /* rej */
@@ -4073,17 +3975,17 @@ static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
             return true;
         }
         if (inv) {
-            TCGv_reg c = tcg_constant_reg(mask);
-            tcg_gen_or_reg(t, t, c);
+            TCGv_i64 c = tcg_constant_i64(mask);
+            tcg_gen_or_i64(t, t, c);
             ctx->null_cond = cond_make(TCG_COND_EQ, t, c);
         } else {
-            tcg_gen_andi_reg(t, t, mask);
+            tcg_gen_andi_i64(t, t, mask);
             ctx->null_cond = cond_make_0(TCG_COND_EQ, t);
         }
     } else {
         unsigned cbit = (a->y ^ 1) - 1;
 
-        tcg_gen_extract_reg(t, t, 21 - cbit, 1);
+        tcg_gen_extract_i64(t, t, 21 - cbit, 1);
         ctx->null_cond = cond_make_0(TCG_COND_NE, t);
     }
 
@@ -4338,7 +4240,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
         if (ctx->iaoq_b == -1) {
             ctx->iaoq_n = -1;
             ctx->iaoq_n_var = tcg_temp_new();
-            tcg_gen_addi_reg(ctx->iaoq_n_var, cpu_iaoq_b, 4);
+            tcg_gen_addi_i64(ctx->iaoq_n_var, cpu_iaoq_b, 4);
         } else {
             ctx->iaoq_n = ctx->iaoq_b + 4;
             ctx->iaoq_n_var = NULL;
-- 
2.34.1


