Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B2F7778BD
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 14:43:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU4yo-0001CW-Eo; Thu, 10 Aug 2023 08:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qU4yj-0001BF-GP
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 08:41:26 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qU4yg-00045j-FA
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 08:41:25 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxDOvr2tRkdqsUAA--.39076S3;
 Thu, 10 Aug 2023 20:41:15 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Ax3c7o2tRkoiNTAA--.11480S7; 
 Thu, 10 Aug 2023 20:41:15 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn
Subject: [PATCH v1 5/6] target/loongarch: Add REQUIRE_LSX macro to check LSX
 instructions
Date: Thu, 10 Aug 2023 20:41:11 +0800
Message-Id: <20230810124112.236640-6-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230810124112.236640-1-gaosong@loongson.cn>
References: <20230810124112.236640-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Ax3c7o2tRkoiNTAA--.11480S7
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

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.h                      |  2 +
 target/loongarch/insn_trans/trans_lsx.c.inc | 71 ++++++++++++++++++++-
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 0166ec3d7b..19d2a28a47 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -464,6 +464,7 @@ static inline void set_pc(CPULoongArchState *env, uint64_t value)
 #define HW_FLAGS_FP_DP      0x100
 #define HW_FLAGS_LSPW       0x200
 #define HW_FLAGS_LAM        0x400
+#define HW_FLAGS_LSX        0x800
 
 static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
@@ -479,6 +480,7 @@ static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
     *flags |= FIELD_EX32(env->cpucfg[2], CPUCFG2, FP_DP) * HW_FLAGS_FP_DP;
     *flags |= FIELD_EX32(env->cpucfg[2], CPUCFG2, LSPW) * HW_FLAGS_LSPW;
     *flags |= FIELD_EX32(env->cpucfg[2], CPUCFG2, LAM) * HW_FLAGS_LAM;
+    *flags |= FIELD_EX32(env->cpucfg[2], CPUCFG2, LSX) * HW_FLAGS_LSX;
 }
 
 void loongarch_cpu_list(void);
diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index 50153d6d0b..293f8c8c2a 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_lsx.c.inc
@@ -15,6 +15,13 @@
 #define CHECK_SXE
 #endif
 
+#define REQUIRE_LSX do { \
+    if ((ctx->base.tb->flags & HW_FLAGS_LSX) == 0) { \
+        return false; \
+    } \
+} while (0)
+
+
 static bool gen_vvvv(DisasContext *ctx, arg_vvvv *a,
                      void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32,
                                   TCGv_i32, TCGv_i32))
@@ -24,6 +31,7 @@ static bool gen_vvvv(DisasContext *ctx, arg_vvvv *a,
     TCGv_i32 vk = tcg_constant_i32(a->vk);
     TCGv_i32 va = tcg_constant_i32(a->va);
 
+    REQUIRE_LSX;
     CHECK_SXE;
     func(cpu_env, vd, vj, vk, va);
     return true;
@@ -36,6 +44,7 @@ static bool gen_vvv(DisasContext *ctx, arg_vvv *a,
     TCGv_i32 vj = tcg_constant_i32(a->vj);
     TCGv_i32 vk = tcg_constant_i32(a->vk);
 
+    REQUIRE_LSX;
     CHECK_SXE;
 
     func(cpu_env, vd, vj, vk);
@@ -48,6 +57,7 @@ static bool gen_vv(DisasContext *ctx, arg_vv *a,
     TCGv_i32 vd = tcg_constant_i32(a->vd);
     TCGv_i32 vj = tcg_constant_i32(a->vj);
 
+    REQUIRE_LSX;
     CHECK_SXE;
     func(cpu_env, vd, vj);
     return true;
@@ -60,6 +70,7 @@ static bool gen_vv_i(DisasContext *ctx, arg_vv_i *a,
     TCGv_i32 vj = tcg_constant_i32(a->vj);
     TCGv_i32 imm = tcg_constant_i32(a->imm);
 
+    REQUIRE_LSX;
     CHECK_SXE;
     func(cpu_env, vd, vj, imm);
     return true;
@@ -71,6 +82,7 @@ static bool gen_cv(DisasContext *ctx, arg_cv *a,
     TCGv_i32 vj = tcg_constant_i32(a->vj);
     TCGv_i32 cd = tcg_constant_i32(a->cd);
 
+    REQUIRE_LSX;
     CHECK_SXE;
     func(cpu_env, cd, vj);
     return true;
@@ -82,6 +94,7 @@ static bool gvec_vvv(DisasContext *ctx, arg_vvv *a, MemOp mop,
 {
     uint32_t vd_ofs, vj_ofs, vk_ofs;
 
+    REQUIRE_LSX;
     CHECK_SXE;
 
     vd_ofs = vec_full_offset(a->vd);
@@ -98,6 +111,7 @@ static bool gvec_vv(DisasContext *ctx, arg_vv *a, MemOp mop,
 {
     uint32_t vd_ofs, vj_ofs;
 
+    REQUIRE_LSX;
     CHECK_SXE;
 
     vd_ofs = vec_full_offset(a->vd);
@@ -113,6 +127,7 @@ static bool gvec_vv_i(DisasContext *ctx, arg_vv_i *a, MemOp mop,
 {
     uint32_t vd_ofs, vj_ofs;
 
+    REQUIRE_LSX;
     CHECK_SXE;
 
     vd_ofs = vec_full_offset(a->vd);
@@ -126,6 +141,7 @@ static bool gvec_subi(DisasContext *ctx, arg_vv_i *a, MemOp mop)
 {
     uint32_t vd_ofs, vj_ofs;
 
+    REQUIRE_LSX;
     CHECK_SXE;
 
     vd_ofs = vec_full_offset(a->vd);
@@ -145,6 +161,7 @@ static bool trans_v## NAME ##_q(DisasContext *ctx, arg_vvv *a) \
 {                                                              \
     TCGv_i64 rh, rl, ah, al, bh, bl;                           \
                                                                \
+    REQUIRE_LSX;                                               \
     CHECK_SXE;                                                 \
                                                                \
     rh = tcg_temp_new_i64();                                   \
@@ -3032,6 +3049,8 @@ static bool trans_vldi(DisasContext *ctx, arg_vldi *a)
 {
     int sel, vece;
     uint64_t value;
+
+    REQUIRE_LSX;
     CHECK_SXE;
 
     sel = (a->imm >> 12) & 0x1;
@@ -3058,6 +3077,7 @@ static bool trans_vandn_v(DisasContext *ctx, arg_vvv *a)
 {
     uint32_t vd_ofs, vj_ofs, vk_ofs;
 
+    REQUIRE_LSX;
     CHECK_SXE;
 
     vd_ofs = vec_full_offset(a->vd);
@@ -3685,6 +3705,7 @@ static bool do_cmp(DisasContext *ctx, arg_vvv *a, MemOp mop, TCGCond cond)
 {
     uint32_t vd_ofs, vj_ofs, vk_ofs;
 
+    REQUIRE_LSX;
     CHECK_SXE;
 
     vd_ofs = vec_full_offset(a->vd);
@@ -3731,6 +3752,7 @@ static bool do_## NAME ##_s(DisasContext *ctx, arg_vv_i *a, MemOp mop) \
 {                                                                      \
     uint32_t vd_ofs, vj_ofs;                                           \
                                                                        \
+    REQUIRE_LSX;                                                       \
     CHECK_SXE;                                                         \
                                                                        \
     static const TCGOpcode vecop_list[] = {                            \
@@ -3780,6 +3802,7 @@ static bool do_## NAME ##_u(DisasContext *ctx, arg_vv_i *a, MemOp mop) \
 {                                                                      \
     uint32_t vd_ofs, vj_ofs;                                           \
                                                                        \
+    REQUIRE_LSX;                                                       \
     CHECK_SXE;                                                         \
                                                                        \
     static const TCGOpcode vecop_list[] = {                            \
@@ -3874,6 +3897,7 @@ static bool trans_vfcmp_cond_s(DisasContext *ctx, arg_vvv_fcond *a)
     TCGv_i32 vj = tcg_constant_i32(a->vj);
     TCGv_i32 vk = tcg_constant_i32(a->vk);
 
+    REQUIRE_LSX;
     CHECK_SXE;
 
     fn = (a->fcond & 1 ? gen_helper_vfcmp_s_s : gen_helper_vfcmp_c_s);
@@ -3900,6 +3924,7 @@ static bool trans_vfcmp_cond_d(DisasContext *ctx, arg_vvv_fcond *a)
 
 static bool trans_vbitsel_v(DisasContext *ctx, arg_vvvv *a)
 {
+    REQUIRE_LSX;
     CHECK_SXE;
 
     tcg_gen_gvec_bitsel(MO_64, vec_full_offset(a->vd), vec_full_offset(a->va),
@@ -3922,6 +3947,7 @@ static bool trans_vbitseli_b(DisasContext *ctx, arg_vv_i *a)
        .load_dest = true
     };
 
+    REQUIRE_LSX;
     CHECK_SXE;
 
     tcg_gen_gvec_2i(vec_full_offset(a->vd), vec_full_offset(a->vj),
@@ -3941,6 +3967,7 @@ static bool trans_## NAME (DisasContext *ctx, arg_cv *a)                       \
     get_vreg64(ah, a->vj, 1);                                                  \
     get_vreg64(al, a->vj, 0);                                                  \
                                                                                \
+    REQUIRE_LSX;                                                               \
     CHECK_SXE;                                                                 \
     tcg_gen_or_i64(t1, al, ah);                                                \
     tcg_gen_setcondi_i64(COND, t1, t1, 0);                                     \
@@ -3964,6 +3991,8 @@ TRANS(vsetallnez_d, gen_cv, gen_helper_vsetallnez_d)
 static bool trans_vinsgr2vr_b(DisasContext *ctx, arg_vr_i *a)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
+
+    REQUIRE_LSX;
     CHECK_SXE;
     tcg_gen_st8_i64(src, cpu_env,
                     offsetof(CPULoongArchState, fpr[a->vd].vreg.B(a->imm)));
@@ -3973,6 +4002,8 @@ static bool trans_vinsgr2vr_b(DisasContext *ctx, arg_vr_i *a)
 static bool trans_vinsgr2vr_h(DisasContext *ctx, arg_vr_i *a)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
+
+    REQUIRE_LSX;
     CHECK_SXE;
     tcg_gen_st16_i64(src, cpu_env,
                     offsetof(CPULoongArchState, fpr[a->vd].vreg.H(a->imm)));
@@ -3982,6 +4013,8 @@ static bool trans_vinsgr2vr_h(DisasContext *ctx, arg_vr_i *a)
 static bool trans_vinsgr2vr_w(DisasContext *ctx, arg_vr_i *a)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
+
+    REQUIRE_LSX;
     CHECK_SXE;
     tcg_gen_st32_i64(src, cpu_env,
                      offsetof(CPULoongArchState, fpr[a->vd].vreg.W(a->imm)));
@@ -3991,6 +4024,8 @@ static bool trans_vinsgr2vr_w(DisasContext *ctx, arg_vr_i *a)
 static bool trans_vinsgr2vr_d(DisasContext *ctx, arg_vr_i *a)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
+
+    REQUIRE_LSX;
     CHECK_SXE;
     tcg_gen_st_i64(src, cpu_env,
                    offsetof(CPULoongArchState, fpr[a->vd].vreg.D(a->imm)));
@@ -4000,6 +4035,8 @@ static bool trans_vinsgr2vr_d(DisasContext *ctx, arg_vr_i *a)
 static bool trans_vpickve2gr_b(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
+
+    REQUIRE_LSX;
     CHECK_SXE;
     tcg_gen_ld8s_i64(dst, cpu_env,
                      offsetof(CPULoongArchState, fpr[a->vj].vreg.B(a->imm)));
@@ -4009,6 +4046,8 @@ static bool trans_vpickve2gr_b(DisasContext *ctx, arg_rv_i *a)
 static bool trans_vpickve2gr_h(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
+
+    REQUIRE_LSX;
     CHECK_SXE;
     tcg_gen_ld16s_i64(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.H(a->imm)));
@@ -4018,6 +4057,8 @@ static bool trans_vpickve2gr_h(DisasContext *ctx, arg_rv_i *a)
 static bool trans_vpickve2gr_w(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
+
+    REQUIRE_LSX;
     CHECK_SXE;
     tcg_gen_ld32s_i64(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.W(a->imm)));
@@ -4027,6 +4068,8 @@ static bool trans_vpickve2gr_w(DisasContext *ctx, arg_rv_i *a)
 static bool trans_vpickve2gr_d(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
+
+    REQUIRE_LSX;
     CHECK_SXE;
     tcg_gen_ld_i64(dst, cpu_env,
                    offsetof(CPULoongArchState, fpr[a->vj].vreg.D(a->imm)));
@@ -4036,6 +4079,8 @@ static bool trans_vpickve2gr_d(DisasContext *ctx, arg_rv_i *a)
 static bool trans_vpickve2gr_bu(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
+
+    REQUIRE_LSX;
     CHECK_SXE;
     tcg_gen_ld8u_i64(dst, cpu_env,
                      offsetof(CPULoongArchState, fpr[a->vj].vreg.B(a->imm)));
@@ -4045,6 +4090,8 @@ static bool trans_vpickve2gr_bu(DisasContext *ctx, arg_rv_i *a)
 static bool trans_vpickve2gr_hu(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
+
+    REQUIRE_LSX;
     CHECK_SXE;
     tcg_gen_ld16u_i64(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.H(a->imm)));
@@ -4054,6 +4101,8 @@ static bool trans_vpickve2gr_hu(DisasContext *ctx, arg_rv_i *a)
 static bool trans_vpickve2gr_wu(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
+
+    REQUIRE_LSX;
     CHECK_SXE;
     tcg_gen_ld32u_i64(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.W(a->imm)));
@@ -4063,6 +4112,8 @@ static bool trans_vpickve2gr_wu(DisasContext *ctx, arg_rv_i *a)
 static bool trans_vpickve2gr_du(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
+
+    REQUIRE_LSX;
     CHECK_SXE;
     tcg_gen_ld_i64(dst, cpu_env,
                    offsetof(CPULoongArchState, fpr[a->vj].vreg.D(a->imm)));
@@ -4072,8 +4123,9 @@ static bool trans_vpickve2gr_du(DisasContext *ctx, arg_rv_i *a)
 static bool gvec_dup(DisasContext *ctx, arg_vr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
-    CHECK_SXE;
 
+    REQUIRE_LSX;
+    CHECK_SXE;
     tcg_gen_gvec_dup_i64(mop, vec_full_offset(a->vd),
                          16, ctx->vl/8, src);
     return true;
@@ -4086,7 +4138,9 @@ TRANS(vreplgr2vr_d, gvec_dup, MO_64)
 
 static bool trans_vreplvei_b(DisasContext *ctx, arg_vv_i *a)
 {
+    REQUIRE_LSX;
     CHECK_SXE;
+
     tcg_gen_gvec_dup_mem(MO_8,vec_full_offset(a->vd),
                          offsetof(CPULoongArchState,
                                   fpr[a->vj].vreg.B((a->imm))),
@@ -4096,7 +4150,9 @@ static bool trans_vreplvei_b(DisasContext *ctx, arg_vv_i *a)
 
 static bool trans_vreplvei_h(DisasContext *ctx, arg_vv_i *a)
 {
+    REQUIRE_LSX;
     CHECK_SXE;
+
     tcg_gen_gvec_dup_mem(MO_16, vec_full_offset(a->vd),
                          offsetof(CPULoongArchState,
                                   fpr[a->vj].vreg.H((a->imm))),
@@ -4105,7 +4161,9 @@ static bool trans_vreplvei_h(DisasContext *ctx, arg_vv_i *a)
 }
 static bool trans_vreplvei_w(DisasContext *ctx, arg_vv_i *a)
 {
+    REQUIRE_LSX;
     CHECK_SXE;
+
     tcg_gen_gvec_dup_mem(MO_32, vec_full_offset(a->vd),
                          offsetof(CPULoongArchState,
                                   fpr[a->vj].vreg.W((a->imm))),
@@ -4114,7 +4172,9 @@ static bool trans_vreplvei_w(DisasContext *ctx, arg_vv_i *a)
 }
 static bool trans_vreplvei_d(DisasContext *ctx, arg_vv_i *a)
 {
+    REQUIRE_LSX;
     CHECK_SXE;
+
     tcg_gen_gvec_dup_mem(MO_64, vec_full_offset(a->vd),
                          offsetof(CPULoongArchState,
                                   fpr[a->vj].vreg.D((a->imm))),
@@ -4129,6 +4189,7 @@ static bool gen_vreplve(DisasContext *ctx, arg_vvr *a, int vece, int bit,
     TCGv_ptr t1 = tcg_temp_new_ptr();
     TCGv_i64 t2 = tcg_temp_new_i64();
 
+    REQUIRE_LSX;
     CHECK_SXE;
 
     tcg_gen_andi_i64(t0, gpr_src(ctx, a->rk, EXT_NONE), (LSX_LEN/bit) -1);
@@ -4155,6 +4216,7 @@ static bool trans_vbsll_v(DisasContext *ctx, arg_vv_i *a)
     int ofs;
     TCGv_i64 desthigh, destlow, high, low;
 
+    REQUIRE_LSX;
     CHECK_SXE;
 
     desthigh = tcg_temp_new_i64();
@@ -4185,6 +4247,7 @@ static bool trans_vbsrl_v(DisasContext *ctx, arg_vv_i *a)
     TCGv_i64 desthigh, destlow, high, low;
     int ofs;
 
+    REQUIRE_LSX;
     CHECK_SXE;
 
     desthigh = tcg_temp_new_i64();
@@ -4259,6 +4322,7 @@ static bool trans_vld(DisasContext *ctx, arg_vr_i *a)
     TCGv_i64 rl, rh;
     TCGv_i128 val;
 
+    REQUIRE_LSX;
     CHECK_SXE;
 
     addr = gpr_src(ctx, a->rj, EXT_NONE);
@@ -4282,6 +4346,7 @@ static bool trans_vst(DisasContext *ctx, arg_vr_i *a)
     TCGv_i128 val;
     TCGv_i64 ah, al;
 
+    REQUIRE_LSX;
     CHECK_SXE;
 
     addr = gpr_src(ctx, a->rj, EXT_NONE);
@@ -4305,6 +4370,7 @@ static bool trans_vldx(DisasContext *ctx, arg_vrr *a)
     TCGv_i64 rl, rh;
     TCGv_i128 val;
 
+    REQUIRE_LSX;
     CHECK_SXE;
 
     src1 = gpr_src(ctx, a->rj, EXT_NONE);
@@ -4328,6 +4394,7 @@ static bool trans_vstx(DisasContext *ctx, arg_vrr *a)
     TCGv_i64 ah, al;
     TCGv_i128 val;
 
+    REQUIRE_LSX;
     CHECK_SXE;
 
     src1 = gpr_src(ctx, a->rj, EXT_NONE);
@@ -4351,6 +4418,7 @@ static bool trans_## NAME (DisasContext *ctx, arg_vr_i *a)                \
     TCGv addr;                                                            \
     TCGv_i64 val;                                                         \
                                                                           \
+    REQUIRE_LSX;                                                          \
     CHECK_SXE;                                                            \
                                                                           \
     addr = gpr_src(ctx, a->rj, EXT_NONE);                                 \
@@ -4375,6 +4443,7 @@ static bool trans_## NAME (DisasContext *ctx, arg_vr_ii *a)                  \
     TCGv addr;                                                               \
     TCGv_i64 val;                                                            \
                                                                              \
+    REQUIRE_LSX;                                                             \
     CHECK_SXE;                                                               \
                                                                              \
     addr = gpr_src(ctx, a->rj, EXT_NONE);                                    \
-- 
2.39.1


