Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 034F67778BB
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 14:43:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU4ym-0001BG-MF; Thu, 10 Aug 2023 08:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qU4yi-00019I-Aj
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 08:41:24 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qU4ye-00044K-3H
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 08:41:24 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Dxfevq2tRkbqsUAA--.42245S3;
 Thu, 10 Aug 2023 20:41:14 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Ax3c7o2tRkoiNTAA--.11480S4; 
 Thu, 10 Aug 2023 20:41:13 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn
Subject: [PATCH v1 2/6] target/loongarch: Add some checks before translating
 fpu instructions
Date: Thu, 10 Aug 2023 20:41:08 +0800
Message-Id: <20230810124112.236640-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230810124112.236640-1-gaosong@loongson.cn>
References: <20230810124112.236640-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Ax3c7o2tRkoiNTAA--.11480S4
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

This patch adds REQUIRE_FP/FP_SP/FP_DP to check CPUCFG2.FP/FP_SP/FP_DP.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.h                        |   6 +
 .../loongarch/insn_trans/trans_farith.c.inc   | 132 ++++++++++++------
 target/loongarch/insn_trans/trans_fcmp.c.inc  |   4 +
 target/loongarch/insn_trans/trans_fcnv.c.inc  |  56 ++++----
 .../loongarch/insn_trans/trans_fmemory.c.inc  | 104 ++++++++++----
 target/loongarch/insn_trans/trans_fmov.c.inc  |  47 +++++--
 6 files changed, 247 insertions(+), 102 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 9f550793ca..5594d83011 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -459,6 +459,9 @@ static inline void set_pc(CPULoongArchState *env, uint64_t value)
 #define HW_FLAGS_EUEN_FPE   0x04
 #define HW_FLAGS_EUEN_SXE   0x08
 #define HW_FLAGS_VA32       0x20
+#define HW_FLAGS_FP         0x40
+#define HW_FLAGS_FP_SP      0x80
+#define HW_FLAGS_FP_DP      0x100
 
 static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
@@ -469,6 +472,9 @@ static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
     *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
     *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
     *flags |= is_va32(env) * HW_FLAGS_VA32;
+    *flags |= FIELD_EX32(env->cpucfg[2], CPUCFG2, FP) * HW_FLAGS_FP;
+    *flags |= FIELD_EX32(env->cpucfg[2], CPUCFG2, FP_SP) * HW_FLAGS_FP_SP;
+    *flags |= FIELD_EX32(env->cpucfg[2], CPUCFG2, FP_DP) * HW_FLAGS_FP_DP;
 }
 
 void loongarch_cpu_list(void);
diff --git a/target/loongarch/insn_trans/trans_farith.c.inc b/target/loongarch/insn_trans/trans_farith.c.inc
index 21ea47308b..f8ff5b7bb6 100644
--- a/target/loongarch/insn_trans/trans_farith.c.inc
+++ b/target/loongarch/insn_trans/trans_farith.c.inc
@@ -10,17 +10,45 @@
         return true; \
     } \
 } while (0)
+
+#define REQUIRE_FP do { \
+    if ((ctx->base.tb->flags & HW_FLAGS_FP) == 0) { \
+        return false; \
+    } \
+} while (0)
+
+#define REQUIRE_FP_SP do { \
+    if ((ctx->base.tb->flags & HW_FLAGS_FP_SP) == 0) { \
+        return false; \
+    } \
+} while (0)
+
+#define REQUIRE_FP_DP do { \
+    if ((ctx->base.tb->flags & HW_FLAGS_FP_DP) == 0) { \
+        return false; \
+    } \
+} while (0)
 #else
 #define CHECK_FPE
+#define REQUIRE_FP
+#define REQUIRE_FP_SP
+#define REQUIRE_FP_DP
 #endif
 
-static bool gen_fff(DisasContext *ctx, arg_fff *a,
+static bool gen_fff(DisasContext *ctx, arg_fff *a, int mode,
                     void (*func)(TCGv, TCGv_env, TCGv, TCGv))
 {
     TCGv dest = get_fpr(ctx, a->fd);
     TCGv src1 = get_fpr(ctx, a->fj);
     TCGv src2 = get_fpr(ctx, a->fk);
 
+    REQUIRE_FP;
+    if (mode == 0) {
+        REQUIRE_FP_SP;
+    } else {
+        REQUIRE_FP_DP;
+    }
+
     CHECK_FPE;
 
     func(dest, cpu_env, src1, src2);
@@ -29,12 +57,19 @@ static bool gen_fff(DisasContext *ctx, arg_fff *a,
     return true;
 }
 
-static bool gen_ff(DisasContext *ctx, arg_ff *a,
+static bool gen_ff(DisasContext *ctx, arg_ff *a, int mode,
                    void (*func)(TCGv, TCGv_env, TCGv))
 {
     TCGv dest = get_fpr(ctx, a->fd);
     TCGv src = get_fpr(ctx, a->fj);
 
+    REQUIRE_FP;
+    if (mode == 0) {
+        REQUIRE_FP_SP;
+    } else {
+        REQUIRE_FP_DP;
+    }
+
     CHECK_FPE;
 
     func(dest, cpu_env, src);
@@ -43,7 +78,7 @@ static bool gen_ff(DisasContext *ctx, arg_ff *a,
     return true;
 }
 
-static bool gen_muladd(DisasContext *ctx, arg_ffff *a,
+static bool gen_muladd(DisasContext *ctx, arg_ffff *a, int mode,
                        void (*func)(TCGv, TCGv_env, TCGv, TCGv, TCGv, TCGv_i32),
                        int flag)
 {
@@ -53,6 +88,13 @@ static bool gen_muladd(DisasContext *ctx, arg_ffff *a,
     TCGv src2 = get_fpr(ctx, a->fk);
     TCGv src3 = get_fpr(ctx, a->fa);
 
+    REQUIRE_FP;
+    if (mode == 0) {
+        REQUIRE_FP_SP;
+    } else {
+        REQUIRE_FP_DP;
+    }
+
     CHECK_FPE;
 
     func(dest, cpu_env, src1, src2, src3, tflag);
@@ -67,6 +109,8 @@ static bool trans_fcopysign_s(DisasContext *ctx, arg_fcopysign_s *a)
     TCGv src1 = get_fpr(ctx, a->fk);
     TCGv src2 = get_fpr(ctx, a->fj);
 
+    REQUIRE_FP;
+    REQUIRE_FP_SP;
     CHECK_FPE;
 
     tcg_gen_deposit_i64(dest, src1, src2, 0, 31);
@@ -81,6 +125,8 @@ static bool trans_fcopysign_d(DisasContext *ctx, arg_fcopysign_d *a)
     TCGv src1 = get_fpr(ctx, a->fk);
     TCGv src2 = get_fpr(ctx, a->fj);
 
+    REQUIRE_FP;
+    REQUIRE_FP_DP;
     CHECK_FPE;
 
     tcg_gen_deposit_i64(dest, src1, src2, 0, 63);
@@ -94,6 +140,8 @@ static bool trans_fabs_s(DisasContext *ctx, arg_fabs_s *a)
     TCGv dest = get_fpr(ctx, a->fd);
     TCGv src = get_fpr(ctx, a->fj);
 
+    REQUIRE_FP;
+    REQUIRE_FP_SP;
     CHECK_FPE;
 
     tcg_gen_andi_i64(dest, src, MAKE_64BIT_MASK(0, 31));
@@ -108,6 +156,8 @@ static bool trans_fabs_d(DisasContext *ctx, arg_fabs_d *a)
     TCGv dest = get_fpr(ctx, a->fd);
     TCGv src = get_fpr(ctx, a->fj);
 
+    REQUIRE_FP;
+    REQUIRE_FP_DP;
     CHECK_FPE;
 
     tcg_gen_andi_i64(dest, src, MAKE_64BIT_MASK(0, 63));
@@ -121,6 +171,8 @@ static bool trans_fneg_s(DisasContext *ctx, arg_fneg_s *a)
     TCGv dest = get_fpr(ctx, a->fd);
     TCGv src = get_fpr(ctx, a->fj);
 
+    REQUIRE_FP;
+    REQUIRE_FP_SP;
     CHECK_FPE;
 
     tcg_gen_xori_i64(dest, src, 0x80000000);
@@ -135,6 +187,8 @@ static bool trans_fneg_d(DisasContext *ctx, arg_fneg_d *a)
     TCGv dest = get_fpr(ctx, a->fd);
     TCGv src = get_fpr(ctx, a->fj);
 
+    REQUIRE_FP;
+    REQUIRE_FP_DP;
     CHECK_FPE;
 
     tcg_gen_xori_i64(dest, src, 0x8000000000000000LL);
@@ -143,41 +197,41 @@ static bool trans_fneg_d(DisasContext *ctx, arg_fneg_d *a)
     return true;
 }
 
-TRANS(fadd_s, gen_fff, gen_helper_fadd_s)
-TRANS(fadd_d, gen_fff, gen_helper_fadd_d)
-TRANS(fsub_s, gen_fff, gen_helper_fsub_s)
-TRANS(fsub_d, gen_fff, gen_helper_fsub_d)
-TRANS(fmul_s, gen_fff, gen_helper_fmul_s)
-TRANS(fmul_d, gen_fff, gen_helper_fmul_d)
-TRANS(fdiv_s, gen_fff, gen_helper_fdiv_s)
-TRANS(fdiv_d, gen_fff, gen_helper_fdiv_d)
-TRANS(fmax_s, gen_fff, gen_helper_fmax_s)
-TRANS(fmax_d, gen_fff, gen_helper_fmax_d)
-TRANS(fmin_s, gen_fff, gen_helper_fmin_s)
-TRANS(fmin_d, gen_fff, gen_helper_fmin_d)
-TRANS(fmaxa_s, gen_fff, gen_helper_fmaxa_s)
-TRANS(fmaxa_d, gen_fff, gen_helper_fmaxa_d)
-TRANS(fmina_s, gen_fff, gen_helper_fmina_s)
-TRANS(fmina_d, gen_fff, gen_helper_fmina_d)
-TRANS(fscaleb_s, gen_fff, gen_helper_fscaleb_s)
-TRANS(fscaleb_d, gen_fff, gen_helper_fscaleb_d)
-TRANS(fsqrt_s, gen_ff, gen_helper_fsqrt_s)
-TRANS(fsqrt_d, gen_ff, gen_helper_fsqrt_d)
-TRANS(frecip_s, gen_ff, gen_helper_frecip_s)
-TRANS(frecip_d, gen_ff, gen_helper_frecip_d)
-TRANS(frsqrt_s, gen_ff, gen_helper_frsqrt_s)
-TRANS(frsqrt_d, gen_ff, gen_helper_frsqrt_d)
-TRANS(flogb_s, gen_ff, gen_helper_flogb_s)
-TRANS(flogb_d, gen_ff, gen_helper_flogb_d)
-TRANS(fclass_s, gen_ff, gen_helper_fclass_s)
-TRANS(fclass_d, gen_ff, gen_helper_fclass_d)
-TRANS(fmadd_s, gen_muladd, gen_helper_fmuladd_s, 0)
-TRANS(fmadd_d, gen_muladd, gen_helper_fmuladd_d, 0)
-TRANS(fmsub_s, gen_muladd, gen_helper_fmuladd_s, float_muladd_negate_c)
-TRANS(fmsub_d, gen_muladd, gen_helper_fmuladd_d, float_muladd_negate_c)
-TRANS(fnmadd_s, gen_muladd, gen_helper_fmuladd_s, float_muladd_negate_result)
-TRANS(fnmadd_d, gen_muladd, gen_helper_fmuladd_d, float_muladd_negate_result)
-TRANS(fnmsub_s, gen_muladd, gen_helper_fmuladd_s,
+TRANS(fadd_s, gen_fff, 0, gen_helper_fadd_s)
+TRANS(fadd_d, gen_fff, 1, gen_helper_fadd_d)
+TRANS(fsub_s, gen_fff, 0, gen_helper_fsub_s)
+TRANS(fsub_d, gen_fff, 1, gen_helper_fsub_d)
+TRANS(fmul_s, gen_fff, 0, gen_helper_fmul_s)
+TRANS(fmul_d, gen_fff, 1, gen_helper_fmul_d)
+TRANS(fdiv_s, gen_fff, 0, gen_helper_fdiv_s)
+TRANS(fdiv_d, gen_fff, 1, gen_helper_fdiv_d)
+TRANS(fmax_s, gen_fff, 0, gen_helper_fmax_s)
+TRANS(fmax_d, gen_fff, 1, gen_helper_fmax_d)
+TRANS(fmin_s, gen_fff, 0, gen_helper_fmin_s)
+TRANS(fmin_d, gen_fff, 1, gen_helper_fmin_d)
+TRANS(fmaxa_s, gen_fff, 0, gen_helper_fmaxa_s)
+TRANS(fmaxa_d, gen_fff, 1, gen_helper_fmaxa_d)
+TRANS(fmina_s, gen_fff, 0, gen_helper_fmina_s)
+TRANS(fmina_d, gen_fff, 1, gen_helper_fmina_d)
+TRANS(fscaleb_s, gen_fff, 0, gen_helper_fscaleb_s)
+TRANS(fscaleb_d, gen_fff, 1, gen_helper_fscaleb_d)
+TRANS(fsqrt_s, gen_ff, 0, gen_helper_fsqrt_s)
+TRANS(fsqrt_d, gen_ff, 1, gen_helper_fsqrt_d)
+TRANS(frecip_s, gen_ff, 0, gen_helper_frecip_s)
+TRANS(frecip_d, gen_ff, 1, gen_helper_frecip_d)
+TRANS(frsqrt_s, gen_ff, 0, gen_helper_frsqrt_s)
+TRANS(frsqrt_d, gen_ff, 1, gen_helper_frsqrt_d)
+TRANS(flogb_s, gen_ff, 0, gen_helper_flogb_s)
+TRANS(flogb_d, gen_ff, 1, gen_helper_flogb_d)
+TRANS(fclass_s, gen_ff, 0, gen_helper_fclass_s)
+TRANS(fclass_d, gen_ff, 1, gen_helper_fclass_d)
+TRANS(fmadd_s, gen_muladd, 0, gen_helper_fmuladd_s, 0)
+TRANS(fmadd_d, gen_muladd, 1, gen_helper_fmuladd_d, 0)
+TRANS(fmsub_s, gen_muladd, 0, gen_helper_fmuladd_s, float_muladd_negate_c)
+TRANS(fmsub_d, gen_muladd, 1, gen_helper_fmuladd_d, float_muladd_negate_c)
+TRANS(fnmadd_s, gen_muladd, 0, gen_helper_fmuladd_s, float_muladd_negate_result)
+TRANS(fnmadd_d, gen_muladd, 1, gen_helper_fmuladd_d, float_muladd_negate_result)
+TRANS(fnmsub_s, gen_muladd, 0, gen_helper_fmuladd_s,
       float_muladd_negate_c | float_muladd_negate_result)
-TRANS(fnmsub_d, gen_muladd, gen_helper_fmuladd_d,
+TRANS(fnmsub_d, gen_muladd, 1, gen_helper_fmuladd_d,
       float_muladd_negate_c | float_muladd_negate_result)
diff --git a/target/loongarch/insn_trans/trans_fcmp.c.inc b/target/loongarch/insn_trans/trans_fcmp.c.inc
index a78868dbc4..17ee28a1a2 100644
--- a/target/loongarch/insn_trans/trans_fcmp.c.inc
+++ b/target/loongarch/insn_trans/trans_fcmp.c.inc
@@ -29,6 +29,8 @@ static bool trans_fcmp_cond_s(DisasContext *ctx, arg_fcmp_cond_s *a)
     uint32_t flags;
     void (*fn)(TCGv, TCGv_env, TCGv, TCGv, TCGv_i32);
 
+    REQUIRE_FP;
+    REQUIRE_FP_SP;
     CHECK_FPE;
 
     var = tcg_temp_new();
@@ -49,6 +51,8 @@ static bool trans_fcmp_cond_d(DisasContext *ctx, arg_fcmp_cond_d *a)
     uint32_t flags;
     void (*fn)(TCGv, TCGv_env, TCGv, TCGv, TCGv_i32);
 
+    REQUIRE_FP;
+    REQUIRE_FP_DP;
     CHECK_FPE;
 
     var = tcg_temp_new();
diff --git a/target/loongarch/insn_trans/trans_fcnv.c.inc b/target/loongarch/insn_trans/trans_fcnv.c.inc
index c1c6918ad1..db33abcc32 100644
--- a/target/loongarch/insn_trans/trans_fcnv.c.inc
+++ b/target/loongarch/insn_trans/trans_fcnv.c.inc
@@ -3,31 +3,31 @@
  * Copyright (c) 2021 Loongson Technology Corporation Limited
  */
 
-TRANS(fcvt_s_d, gen_ff, gen_helper_fcvt_s_d)
-TRANS(fcvt_d_s, gen_ff, gen_helper_fcvt_d_s)
-TRANS(ftintrm_w_s, gen_ff, gen_helper_ftintrm_w_s)
-TRANS(ftintrm_w_d, gen_ff, gen_helper_ftintrm_w_d)
-TRANS(ftintrm_l_s, gen_ff, gen_helper_ftintrm_l_s)
-TRANS(ftintrm_l_d, gen_ff, gen_helper_ftintrm_l_d)
-TRANS(ftintrp_w_s, gen_ff, gen_helper_ftintrp_w_s)
-TRANS(ftintrp_w_d, gen_ff, gen_helper_ftintrp_w_d)
-TRANS(ftintrp_l_s, gen_ff, gen_helper_ftintrp_l_s)
-TRANS(ftintrp_l_d, gen_ff, gen_helper_ftintrp_l_d)
-TRANS(ftintrz_w_s, gen_ff, gen_helper_ftintrz_w_s)
-TRANS(ftintrz_w_d, gen_ff, gen_helper_ftintrz_w_d)
-TRANS(ftintrz_l_s, gen_ff, gen_helper_ftintrz_l_s)
-TRANS(ftintrz_l_d, gen_ff, gen_helper_ftintrz_l_d)
-TRANS(ftintrne_w_s, gen_ff, gen_helper_ftintrne_w_s)
-TRANS(ftintrne_w_d, gen_ff, gen_helper_ftintrne_w_d)
-TRANS(ftintrne_l_s, gen_ff, gen_helper_ftintrne_l_s)
-TRANS(ftintrne_l_d, gen_ff, gen_helper_ftintrne_l_d)
-TRANS(ftint_w_s, gen_ff, gen_helper_ftint_w_s)
-TRANS(ftint_w_d, gen_ff, gen_helper_ftint_w_d)
-TRANS(ftint_l_s, gen_ff, gen_helper_ftint_l_s)
-TRANS(ftint_l_d, gen_ff, gen_helper_ftint_l_d)
-TRANS(ffint_s_w, gen_ff, gen_helper_ffint_s_w)
-TRANS(ffint_s_l, gen_ff, gen_helper_ffint_s_l)
-TRANS(ffint_d_w, gen_ff, gen_helper_ffint_d_w)
-TRANS(ffint_d_l, gen_ff, gen_helper_ffint_d_l)
-TRANS(frint_s, gen_ff, gen_helper_frint_s)
-TRANS(frint_d, gen_ff, gen_helper_frint_d)
+TRANS(fcvt_s_d, gen_ff, 0, gen_helper_fcvt_s_d)
+TRANS(fcvt_d_s, gen_ff, 1, gen_helper_fcvt_d_s)
+TRANS(ftintrm_w_s, gen_ff, 0, gen_helper_ftintrm_w_s)
+TRANS(ftintrm_w_d, gen_ff, 1, gen_helper_ftintrm_w_d)
+TRANS(ftintrm_l_s, gen_ff, 0, gen_helper_ftintrm_l_s)
+TRANS(ftintrm_l_d, gen_ff, 1, gen_helper_ftintrm_l_d)
+TRANS(ftintrp_w_s, gen_ff, 0, gen_helper_ftintrp_w_s)
+TRANS(ftintrp_w_d, gen_ff, 1, gen_helper_ftintrp_w_d)
+TRANS(ftintrp_l_s, gen_ff, 0, gen_helper_ftintrp_l_s)
+TRANS(ftintrp_l_d, gen_ff, 1, gen_helper_ftintrp_l_d)
+TRANS(ftintrz_w_s, gen_ff, 0, gen_helper_ftintrz_w_s)
+TRANS(ftintrz_w_d, gen_ff, 1, gen_helper_ftintrz_w_d)
+TRANS(ftintrz_l_s, gen_ff, 0, gen_helper_ftintrz_l_s)
+TRANS(ftintrz_l_d, gen_ff, 1, gen_helper_ftintrz_l_d)
+TRANS(ftintrne_w_s, gen_ff, 0, gen_helper_ftintrne_w_s)
+TRANS(ftintrne_w_d, gen_ff, 1, gen_helper_ftintrne_w_d)
+TRANS(ftintrne_l_s, gen_ff, 0, gen_helper_ftintrne_l_s)
+TRANS(ftintrne_l_d, gen_ff, 1, gen_helper_ftintrne_l_d)
+TRANS(ftint_w_s, gen_ff, 0, gen_helper_ftint_w_s)
+TRANS(ftint_w_d, gen_ff, 1, gen_helper_ftint_w_d)
+TRANS(ftint_l_s, gen_ff, 0, gen_helper_ftint_l_s)
+TRANS(ftint_l_d, gen_ff, 1, gen_helper_ftint_l_d)
+TRANS(ffint_s_w, gen_ff, 0, gen_helper_ffint_s_w)
+TRANS(ffint_s_l, gen_ff, 1, gen_helper_ffint_s_l)
+TRANS(ffint_d_w, gen_ff, 0, gen_helper_ffint_d_w)
+TRANS(ffint_d_l, gen_ff, 1, gen_helper_ffint_d_l)
+TRANS(frint_s, gen_ff, 0, gen_helper_frint_s)
+TRANS(frint_d, gen_ff, 1, gen_helper_frint_d)
diff --git a/target/loongarch/insn_trans/trans_fmemory.c.inc b/target/loongarch/insn_trans/trans_fmemory.c.inc
index bd3aba2c49..b8cf3f63b2 100644
--- a/target/loongarch/insn_trans/trans_fmemory.c.inc
+++ b/target/loongarch/insn_trans/trans_fmemory.c.inc
@@ -10,11 +10,18 @@ static void maybe_nanbox_load(TCGv freg, MemOp mop)
     }
 }
 
-static bool gen_fload_i(DisasContext *ctx, arg_fr_i *a, MemOp mop)
+static bool gen_fload_i(DisasContext *ctx, arg_fr_i *a, int mode, MemOp mop)
 {
     TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv dest = get_fpr(ctx, a->fd);
 
+    REQUIRE_FP;
+    if (mode == 0) {
+        REQUIRE_FP_SP;
+    } else {
+        REQUIRE_FP_DP;
+    }
+
     CHECK_FPE;
 
     addr = make_address_i(ctx, addr, a->imm);
@@ -26,11 +33,18 @@ static bool gen_fload_i(DisasContext *ctx, arg_fr_i *a, MemOp mop)
     return true;
 }
 
-static bool gen_fstore_i(DisasContext *ctx, arg_fr_i *a, MemOp mop)
+static bool gen_fstore_i(DisasContext *ctx, arg_fr_i *a, int mode,  MemOp mop)
 {
     TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src = get_fpr(ctx, a->fd);
 
+    REQUIRE_FP;
+    if (mode == 0) {
+        REQUIRE_FP_SP;
+    } else {
+        REQUIRE_FP_DP;
+    }
+
     CHECK_FPE;
 
     addr = make_address_i(ctx, addr, a->imm);
@@ -40,13 +54,20 @@ static bool gen_fstore_i(DisasContext *ctx, arg_fr_i *a, MemOp mop)
     return true;
 }
 
-static bool gen_floadx(DisasContext *ctx, arg_frr *a, MemOp mop)
+static bool gen_floadx(DisasContext *ctx, arg_frr *a, int mode, MemOp mop)
 {
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
     TCGv dest = get_fpr(ctx, a->fd);
     TCGv addr;
 
+    REQUIRE_FP;
+    if (mode == 0) {
+        REQUIRE_FP_SP;
+    } else {
+        REQUIRE_FP_DP;
+    }
+
     CHECK_FPE;
 
     addr = make_address_x(ctx, src1, src2);
@@ -57,13 +78,20 @@ static bool gen_floadx(DisasContext *ctx, arg_frr *a, MemOp mop)
     return true;
 }
 
-static bool gen_fstorex(DisasContext *ctx, arg_frr *a, MemOp mop)
+static bool gen_fstorex(DisasContext *ctx, arg_frr *a, int mode, MemOp mop)
 {
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
     TCGv src3 = get_fpr(ctx, a->fd);
     TCGv addr;
 
+    REQUIRE_FP;
+    if (mode == 0) {
+        REQUIRE_FP_SP;
+    } else {
+        REQUIRE_FP_DP;
+    }
+
     CHECK_FPE;
 
     addr = make_address_x(ctx, src1, src2);
@@ -72,13 +100,20 @@ static bool gen_fstorex(DisasContext *ctx, arg_frr *a, MemOp mop)
     return true;
 }
 
-static bool gen_fload_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
+static bool gen_fload_gt(DisasContext *ctx, arg_frr *a, int mode, MemOp mop)
 {
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
     TCGv dest = get_fpr(ctx, a->fd);
     TCGv addr;
 
+    REQUIRE_FP;
+    if (mode == 0) {
+        REQUIRE_FP_SP;
+    } else {
+        REQUIRE_FP_DP;
+    }
+
     CHECK_FPE;
 
     gen_helper_asrtgt_d(cpu_env, src1, src2);
@@ -90,13 +125,20 @@ static bool gen_fload_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
     return true;
 }
 
-static bool gen_fstore_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
+static bool gen_fstore_gt(DisasContext *ctx, arg_frr *a, int mode, MemOp mop)
 {
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
     TCGv src3 = get_fpr(ctx, a->fd);
     TCGv addr;
 
+    REQUIRE_FP;
+    if (mode == 0) {
+        REQUIRE_FP_SP;
+    } else {
+        REQUIRE_FP_DP;
+    }
+
     CHECK_FPE;
 
     gen_helper_asrtgt_d(cpu_env, src1, src2);
@@ -106,13 +148,20 @@ static bool gen_fstore_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
     return true;
 }
 
-static bool gen_fload_le(DisasContext *ctx, arg_frr *a, MemOp mop)
+static bool gen_fload_le(DisasContext *ctx, arg_frr *a, int mode, MemOp mop)
 {
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
     TCGv dest = get_fpr(ctx, a->fd);
     TCGv addr;
 
+    REQUIRE_FP;
+    if (mode == 0) {
+        REQUIRE_FP_SP;
+    } else {
+        REQUIRE_FP_DP;
+    }
+
     CHECK_FPE;
 
     gen_helper_asrtle_d(cpu_env, src1, src2);
@@ -124,13 +173,20 @@ static bool gen_fload_le(DisasContext *ctx, arg_frr *a, MemOp mop)
     return true;
 }
 
-static bool gen_fstore_le(DisasContext *ctx, arg_frr *a, MemOp mop)
+static bool gen_fstore_le(DisasContext *ctx, arg_frr *a, int mode, MemOp mop)
 {
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
     TCGv src3 = get_fpr(ctx, a->fd);
     TCGv addr;
 
+    REQUIRE_FP;
+    if (mode == 0) {
+        REQUIRE_FP_SP;
+    } else {
+        REQUIRE_FP_DP;
+    }
+
     CHECK_FPE;
 
     gen_helper_asrtle_d(cpu_env, src1, src2);
@@ -140,19 +196,19 @@ static bool gen_fstore_le(DisasContext *ctx, arg_frr *a, MemOp mop)
     return true;
 }
 
-TRANS(fld_s, gen_fload_i, MO_TEUL)
-TRANS(fst_s, gen_fstore_i, MO_TEUL)
-TRANS(fld_d, gen_fload_i, MO_TEUQ)
-TRANS(fst_d, gen_fstore_i, MO_TEUQ)
-TRANS(fldx_s, gen_floadx, MO_TEUL)
-TRANS(fldx_d, gen_floadx, MO_TEUQ)
-TRANS(fstx_s, gen_fstorex, MO_TEUL)
-TRANS(fstx_d, gen_fstorex, MO_TEUQ)
-TRANS(fldgt_s, gen_fload_gt, MO_TEUL)
-TRANS(fldgt_d, gen_fload_gt, MO_TEUQ)
-TRANS(fldle_s, gen_fload_le, MO_TEUL)
-TRANS(fldle_d, gen_fload_le, MO_TEUQ)
-TRANS(fstgt_s, gen_fstore_gt, MO_TEUL)
-TRANS(fstgt_d, gen_fstore_gt, MO_TEUQ)
-TRANS(fstle_s, gen_fstore_le, MO_TEUL)
-TRANS(fstle_d, gen_fstore_le, MO_TEUQ)
+TRANS(fld_s, gen_fload_i, 0, MO_TEUL)
+TRANS(fst_s, gen_fstore_i, 0, MO_TEUL)
+TRANS(fld_d, gen_fload_i, 1, MO_TEUQ)
+TRANS(fst_d, gen_fstore_i, 1, MO_TEUQ)
+TRANS(fldx_s, gen_floadx, 0, MO_TEUL)
+TRANS(fldx_d, gen_floadx, 1, MO_TEUQ)
+TRANS(fstx_s, gen_fstorex, 0, MO_TEUL)
+TRANS(fstx_d, gen_fstorex, 1, MO_TEUQ)
+TRANS(fldgt_s, gen_fload_gt, 0, MO_TEUL)
+TRANS(fldgt_d, gen_fload_gt, 1, MO_TEUQ)
+TRANS(fldle_s, gen_fload_le, 0, MO_TEUL)
+TRANS(fldle_d, gen_fload_le, 1, MO_TEUQ)
+TRANS(fstgt_s, gen_fstore_gt, 0, MO_TEUL)
+TRANS(fstgt_d, gen_fstore_gt, 1, MO_TEUQ)
+TRANS(fstle_s, gen_fstore_le, 0, MO_TEUL)
+TRANS(fstle_d, gen_fstore_le, 1, MO_TEUQ)
diff --git a/target/loongarch/insn_trans/trans_fmov.c.inc b/target/loongarch/insn_trans/trans_fmov.c.inc
index c58c5c6534..09a7b5bc60 100644
--- a/target/loongarch/insn_trans/trans_fmov.c.inc
+++ b/target/loongarch/insn_trans/trans_fmov.c.inc
@@ -15,6 +15,7 @@ static bool trans_fsel(DisasContext *ctx, arg_fsel *a)
     TCGv src2 = get_fpr(ctx, a->fk);
     TCGv cond;
 
+    REQUIRE_FP;
     CHECK_FPE;
 
     cond = tcg_temp_new();
@@ -25,12 +26,20 @@ static bool trans_fsel(DisasContext *ctx, arg_fsel *a)
     return true;
 }
 
-static bool gen_f2f(DisasContext *ctx, arg_ff *a,
+static bool gen_f2f(DisasContext *ctx, arg_ff *a, int mode,
                     void (*func)(TCGv, TCGv), bool nanbox)
 {
     TCGv dest = get_fpr(ctx, a->fd);
     TCGv src = get_fpr(ctx, a->fj);
 
+
+    REQUIRE_FP;
+    if (mode == 0) {
+        REQUIRE_FP_SP;
+    } else {
+        REQUIRE_FP_DP;
+    }
+
     CHECK_FPE;
 
     func(dest, src);
@@ -42,12 +51,17 @@ static bool gen_f2f(DisasContext *ctx, arg_ff *a,
     return true;
 }
 
-static bool gen_r2f(DisasContext *ctx, arg_fr *a,
+static bool gen_r2f(DisasContext *ctx, arg_fr *a, int mode,
                     void (*func)(TCGv, TCGv))
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv dest = get_fpr(ctx, a->fd);
 
+    REQUIRE_FP;
+    if (mode == 1) {
+        REQUIRE_FP_DP;
+    }
+
     CHECK_FPE;
 
     func(dest, src);
@@ -56,12 +70,17 @@ static bool gen_r2f(DisasContext *ctx, arg_fr *a,
     return true;
 }
 
-static bool gen_f2r(DisasContext *ctx, arg_rf *a,
+static bool gen_f2r(DisasContext *ctx, arg_rf *a, int mode,
                     void (*func)(TCGv, TCGv))
 {
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv src = get_fpr(ctx, a->fj);
 
+    REQUIRE_FP;
+    if (mode == 1) {
+        REQUIRE_FP_DP;
+    }
+
     CHECK_FPE;
 
     func(dest, src);
@@ -75,6 +94,7 @@ static bool trans_movgr2fcsr(DisasContext *ctx, arg_movgr2fcsr *a)
     uint32_t mask = fcsr_mask[a->fcsrd];
     TCGv Rj = gpr_src(ctx, a->rj, EXT_NONE);
 
+    REQUIRE_FP;
     CHECK_FPE;
 
     if (mask == UINT32_MAX) {
@@ -105,6 +125,7 @@ static bool trans_movfcsr2gr(DisasContext *ctx, arg_movfcsr2gr *a)
 {
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
 
+    REQUIRE_FP;
     CHECK_FPE;
 
     tcg_gen_ld32u_i64(dest, cpu_env, offsetof(CPULoongArchState, fcsr0));
@@ -134,6 +155,7 @@ static bool trans_movfr2cf(DisasContext *ctx, arg_movfr2cf *a)
     TCGv t0;
     TCGv src = get_fpr(ctx, a->fj);
 
+    REQUIRE_FP;
     CHECK_FPE;
 
     t0 = tcg_temp_new();
@@ -147,6 +169,7 @@ static bool trans_movcf2fr(DisasContext *ctx, arg_movcf2fr *a)
 {
     TCGv dest = get_fpr(ctx, a->fd);
 
+    REQUIRE_FP;
     CHECK_FPE;
 
     tcg_gen_ld8u_tl(dest, cpu_env,
@@ -160,6 +183,7 @@ static bool trans_movgr2cf(DisasContext *ctx, arg_movgr2cf *a)
 {
     TCGv t0;
 
+    REQUIRE_FP;
     CHECK_FPE;
 
     t0 = tcg_temp_new();
@@ -171,6 +195,7 @@ static bool trans_movgr2cf(DisasContext *ctx, arg_movgr2cf *a)
 
 static bool trans_movcf2gr(DisasContext *ctx, arg_movcf2gr *a)
 {
+    REQUIRE_FP;
     CHECK_FPE;
 
     tcg_gen_ld8u_tl(gpr_dst(ctx, a->rd, EXT_NONE), cpu_env,
@@ -178,11 +203,11 @@ static bool trans_movcf2gr(DisasContext *ctx, arg_movcf2gr *a)
     return true;
 }
 
-TRANS(fmov_s, gen_f2f, tcg_gen_mov_tl, true)
-TRANS(fmov_d, gen_f2f, tcg_gen_mov_tl, false)
-TRANS(movgr2fr_w, gen_r2f, gen_movgr2fr_w)
-TRANS_64(movgr2fr_d, gen_r2f, tcg_gen_mov_tl)
-TRANS(movgr2frh_w, gen_r2f, gen_movgr2frh_w)
-TRANS(movfr2gr_s, gen_f2r, tcg_gen_ext32s_tl)
-TRANS_64(movfr2gr_d, gen_f2r, tcg_gen_mov_tl)
-TRANS(movfrh2gr_s, gen_f2r, gen_movfrh2gr_s)
+TRANS(fmov_s, gen_f2f, 0, tcg_gen_mov_tl, true)
+TRANS(fmov_d, gen_f2f, 1, tcg_gen_mov_tl, false)
+TRANS(movgr2fr_w, gen_r2f, 0, gen_movgr2fr_w)
+TRANS_64(movgr2fr_d, gen_r2f, 1, tcg_gen_mov_tl)
+TRANS(movgr2frh_w, gen_r2f, 0, gen_movgr2frh_w)
+TRANS(movfr2gr_s, gen_f2r, 0, tcg_gen_ext32s_tl)
+TRANS_64(movfr2gr_d, gen_f2r, 1, tcg_gen_mov_tl)
+TRANS(movfrh2gr_s, gen_f2r, 0, gen_movfrh2gr_s)
-- 
2.39.1


