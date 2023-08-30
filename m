Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0909278D468
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 10:54:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbGuQ-0002j2-Uw; Wed, 30 Aug 2023 04:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qbGtf-0001cU-Cu
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:49:55 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qbGtZ-0007ZL-6l
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:49:55 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxHOugAu9kyQgdAA--.54598S3;
 Wed, 30 Aug 2023 16:49:36 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxF81+Au9kHhxnAA--.49766S44; 
 Wed, 30 Aug 2023 16:49:35 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v4 42/48] target/loongarch: Implement xvbitsel xvset
Date: Wed, 30 Aug 2023 16:48:56 +0800
Message-Id: <20230830084902.2113960-43-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230830084902.2113960-1-gaosong@loongson.cn>
References: <20230830084902.2113960-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxF81+Au9kHhxnAA--.49766S44
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

This patch includes:
- XVBITSEL.V;
- XVBITSELI.B;
- XVSET{EQZ/NEZ}.V;
- XVSETANYEQZ.{B/H/W/D};
- XVSETALLNEZ.{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/helper.h                    | 16 +++----
 target/loongarch/insns.decode                | 15 +++++++
 target/loongarch/disas.c                     | 19 ++++++++
 target/loongarch/vec_helper.c                | 40 ++++++++++-------
 target/loongarch/insn_trans/trans_lasx.c.inc | 46 ++++++++++++++++++++
 target/loongarch/insn_trans/trans_lsx.c.inc  | 44 +++++++++----------
 6 files changed, 134 insertions(+), 46 deletions(-)

diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index b54ce68077..85233586e3 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -659,14 +659,14 @@ DEF_HELPER_6(vfcmp_s_d, void, env, i32, i32, i32, i32, i32)
 
 DEF_HELPER_FLAGS_4(vbitseli_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 
-DEF_HELPER_3(vsetanyeqz_b, void, env, i32, i32)
-DEF_HELPER_3(vsetanyeqz_h, void, env, i32, i32)
-DEF_HELPER_3(vsetanyeqz_w, void, env, i32, i32)
-DEF_HELPER_3(vsetanyeqz_d, void, env, i32, i32)
-DEF_HELPER_3(vsetallnez_b, void, env, i32, i32)
-DEF_HELPER_3(vsetallnez_h, void, env, i32, i32)
-DEF_HELPER_3(vsetallnez_w, void, env, i32, i32)
-DEF_HELPER_3(vsetallnez_d, void, env, i32, i32)
+DEF_HELPER_4(vsetanyeqz_b, void, env, i32, i32, i32)
+DEF_HELPER_4(vsetanyeqz_h, void, env, i32, i32, i32)
+DEF_HELPER_4(vsetanyeqz_w, void, env, i32, i32, i32)
+DEF_HELPER_4(vsetanyeqz_d, void, env, i32, i32, i32)
+DEF_HELPER_4(vsetallnez_b, void, env, i32, i32, i32)
+DEF_HELPER_4(vsetallnez_h, void, env, i32, i32, i32)
+DEF_HELPER_4(vsetallnez_w, void, env, i32, i32, i32)
+DEF_HELPER_4(vsetallnez_d, void, env, i32, i32, i32)
 
 DEF_HELPER_FLAGS_4(vpackev_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vpackev_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 0d46bd5e5e..ad6751fdfb 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1961,6 +1961,21 @@ xvslti_du        0111 01101000 10011 ..... ..... .....    @vv_ui5
 xvfcmp_cond_s    0000 11001001 ..... ..... ..... .....    @vvv_fcond
 xvfcmp_cond_d    0000 11001010 ..... ..... ..... .....    @vvv_fcond
 
+xvbitsel_v       0000 11010010 ..... ..... ..... .....    @vvvv
+
+xvbitseli_b      0111 01111100 01 ........ ..... .....    @vv_ui8
+
+xvseteqz_v       0111 01101001 11001 00110 ..... 00 ...   @cv
+xvsetnez_v       0111 01101001 11001 00111 ..... 00 ...   @cv
+xvsetanyeqz_b    0111 01101001 11001 01000 ..... 00 ...   @cv
+xvsetanyeqz_h    0111 01101001 11001 01001 ..... 00 ...   @cv
+xvsetanyeqz_w    0111 01101001 11001 01010 ..... 00 ...   @cv
+xvsetanyeqz_d    0111 01101001 11001 01011 ..... 00 ...   @cv
+xvsetallnez_b    0111 01101001 11001 01100 ..... 00 ...   @cv
+xvsetallnez_h    0111 01101001 11001 01101 ..... 00 ...   @cv
+xvsetallnez_w    0111 01101001 11001 01110 ..... 00 ...   @cv
+xvsetallnez_d    0111 01101001 11001 01111 ..... 00 ...   @cv
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 607774375c..3a06b5cb80 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1703,6 +1703,11 @@ static bool trans_##insn(DisasContext *ctx, arg_##type * a) \
     return true;                                            \
 }
 
+static void output_cv_x(DisasContext *ctx, arg_cv *a, const char *mnemonic)
+{
+    output(ctx, mnemonic, "fcc%d, x%d", a->cd, a->vj);
+}
+
 static void output_v_i_x(DisasContext *ctx, arg_v_i *a, const char *mnemonic)
 {
     output(ctx, mnemonic, "x%d, 0x%x", a->vd, a->imm);
@@ -2479,6 +2484,20 @@ static bool trans_xvfcmp_cond_##suffix(DisasContext *ctx, \
 LASX_FCMP_INSN(s)
 LASX_FCMP_INSN(d)
 
+INSN_LASX(xvbitsel_v,        vvvv)
+INSN_LASX(xvbitseli_b,       vv_i)
+
+INSN_LASX(xvseteqz_v,        cv)
+INSN_LASX(xvsetnez_v,        cv)
+INSN_LASX(xvsetanyeqz_b,     cv)
+INSN_LASX(xvsetanyeqz_h,     cv)
+INSN_LASX(xvsetanyeqz_w,     cv)
+INSN_LASX(xvsetanyeqz_d,     cv)
+INSN_LASX(xvsetallnez_b,     cv)
+INSN_LASX(xvsetallnez_h,     cv)
+INSN_LASX(xvsetallnez_w,     cv)
+INSN_LASX(xvsetallnez_d,     cv)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 4970a4b39a..1a13342c86 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -3025,13 +3025,13 @@ VFCMP(vfcmp_s_s, 32, UW, float32_compare)
 VFCMP(vfcmp_c_d, 64, UD, float64_compare_quiet)
 VFCMP(vfcmp_s_d, 64, UD, float64_compare)
 
-void HELPER(vbitseli_b)(void *vd, void *vj,  uint64_t imm, uint32_t v)
+void HELPER(vbitseli_b)(void *vd, void *vj,  uint64_t imm, uint32_t desc)
 {
     int i;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
 
-    for (i = 0; i < 16; i++) {
+    for (i = 0; i < simd_oprsz(desc); i++) {
         Vd->B(i) = (~Vd->B(i) & Vj->B(i)) | (Vd->B(i) & imm);
     }
 }
@@ -3039,7 +3039,7 @@ void HELPER(vbitseli_b)(void *vd, void *vj,  uint64_t imm, uint32_t v)
 /* Copy from target/arm/tcg/sve_helper.c */
 static inline bool do_match2(uint64_t n, uint64_t m0, uint64_t m1, int esz)
 {
-    uint64_t bits = 8 << esz;
+    int bits = 8 << esz;
     uint64_t ones = dup_const(esz, 1);
     uint64_t signs = ones << (bits - 1);
     uint64_t cmp0, cmp1;
@@ -3052,24 +3052,34 @@ static inline bool do_match2(uint64_t n, uint64_t m0, uint64_t m1, int esz)
     return (cmp0 | cmp1) & signs;
 }
 
-#define SETANYEQZ(NAME, MO)                                         \
-void HELPER(NAME)(CPULoongArchState *env, uint32_t cd, uint32_t vj) \
-{                                                                   \
-    VReg *Vj = &(env->fpr[vj].vreg);                                \
-                                                                    \
-    env->cf[cd & 0x7] = do_match2(0, Vj->D(0), Vj->D(1), MO);       \
+#define SETANYEQZ(NAME, MO)                                        \
+void HELPER(NAME)(CPULoongArchState *env,                          \
+                  uint32_t oprsz, uint32_t cd, uint32_t vj)        \
+{                                                                  \
+    VReg *Vj = &(env->fpr[vj].vreg);                               \
+                                                                   \
+    env->cf[cd & 0x7] = do_match2(0, Vj->D(0), Vj->D(1), MO);      \
+    if (oprsz == 32) {                                             \
+        env->cf[cd & 0x7] =  env->cf[cd & 0x7] ||                  \
+                             do_match2(0, Vj->D(2), Vj->D(3), MO); \
+    }                                                              \
 }
 SETANYEQZ(vsetanyeqz_b, MO_8)
 SETANYEQZ(vsetanyeqz_h, MO_16)
 SETANYEQZ(vsetanyeqz_w, MO_32)
 SETANYEQZ(vsetanyeqz_d, MO_64)
 
-#define SETALLNEZ(NAME, MO)                                         \
-void HELPER(NAME)(CPULoongArchState *env, uint32_t cd, uint32_t vj) \
-{                                                                   \
-    VReg *Vj = &(env->fpr[vj].vreg);                                \
-                                                                    \
-    env->cf[cd & 0x7]= !do_match2(0, Vj->D(0), Vj->D(1), MO);       \
+#define SETALLNEZ(NAME, MO)                                        \
+void HELPER(NAME)(CPULoongArchState *env,                          \
+                  uint32_t oprsz, uint32_t cd, uint32_t vj)        \
+{                                                                  \
+    VReg *Vj = &(env->fpr[vj].vreg);                               \
+                                                                   \
+    env->cf[cd & 0x7]= !do_match2(0, Vj->D(0), Vj->D(1), MO);      \
+    if (oprsz == 32) {                                             \
+        env->cf[cd & 0x7] = env->cf[cd & 0x7] &&                   \
+                            !do_match2(0, Vj->D(2), Vj->D(3), MO); \
+    }                                                              \
 }
 SETALLNEZ(vsetallnez_b, MO_8)
 SETALLNEZ(vsetallnez_h, MO_16)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 6efb9733a3..190fe3eecb 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -708,6 +708,52 @@ TRANS(xvslti_du, LASX, do_vslti_u, 32, MO_64)
 TRANS(xvfcmp_cond_s, LASX, do_vfcmp_cond_s, 32)
 TRANS(xvfcmp_cond_d, LASX, do_vfcmp_cond_d, 32)
 
+TRANS(xvbitsel_v, LASX, do_vbitsel_v, 32)
+TRANS(xvbitseli_b, LASX, do_vbitseli_b, 32)
+
+#define XVSET(NAME, COND)                                                      \
+static bool trans_## NAME(DisasContext *ctx, arg_cv * a)                       \
+{                                                                              \
+    TCGv_i64 t1, t2, d[4];                                                     \
+                                                                               \
+    d[0] = tcg_temp_new_i64();                                                 \
+    d[1] = tcg_temp_new_i64();                                                 \
+    d[2] = tcg_temp_new_i64();                                                 \
+    d[3] = tcg_temp_new_i64();                                                 \
+    t1 = tcg_temp_new_i64();                                                   \
+    t2 = tcg_temp_new_i64();                                                   \
+                                                                               \
+    get_vreg64(d[0], a->vj, 0);                                                \
+    get_vreg64(d[1], a->vj, 1);                                                \
+    get_vreg64(d[2], a->vj, 2);                                                \
+    get_vreg64(d[3], a->vj, 3);                                                \
+                                                                               \
+    if (!avail_LASX(ctx)) {                                                    \
+        return false;                                                          \
+    }                                                                          \
+                                                                               \
+    CHECK_VEC;                                                                 \
+    tcg_gen_or_i64(t1, d[0], d[1]);                                            \
+    tcg_gen_or_i64(t2, d[2], d[3]);                                            \
+    tcg_gen_or_i64(t1, t2, t1);                                                \
+    tcg_gen_setcondi_i64(COND, t1, t1, 0);                                     \
+    tcg_gen_st8_tl(t1, cpu_env, offsetof(CPULoongArchState, cf[a->cd & 0x7])); \
+                                                                               \
+    return true;                                                               \
+}
+
+XVSET(xvseteqz_v, TCG_COND_EQ)
+XVSET(xvsetnez_v, TCG_COND_NE)
+
+TRANS(xvsetanyeqz_b, LASX, gen_cv, 32, gen_helper_vsetanyeqz_b)
+TRANS(xvsetanyeqz_h, LASX, gen_cv, 32, gen_helper_vsetanyeqz_h)
+TRANS(xvsetanyeqz_w, LASX, gen_cv, 32, gen_helper_vsetanyeqz_w)
+TRANS(xvsetanyeqz_d, LASX, gen_cv, 32, gen_helper_vsetanyeqz_d)
+TRANS(xvsetallnez_b, LASX, gen_cv, 32, gen_helper_vsetallnez_b)
+TRANS(xvsetallnez_h, LASX, gen_cv, 32, gen_helper_vsetallnez_h)
+TRANS(xvsetallnez_w, LASX, gen_cv, 32, gen_helper_vsetallnez_w)
+TRANS(xvsetallnez_d, LASX, gen_cv, 32, gen_helper_vsetallnez_d)
+
 TRANS(xvreplgr2vr_b, LASX, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, LASX, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, LASX, gvec_dup, 32, MO_32)
diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index a5d6cc834d..2928e878cf 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_lsx.c.inc
@@ -91,14 +91,16 @@ static bool gen_vv_i(DisasContext *ctx, arg_vv_i *a, int oprsz,
     return true;
 }
 
-static bool gen_cv(DisasContext *ctx, arg_cv *a,
-                    void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32))
+static bool gen_cv(DisasContext *ctx, arg_cv *a, uint32_t sz,
+                    void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32))
 {
     TCGv_i32 vj = tcg_constant_i32(a->vj);
     TCGv_i32 cd = tcg_constant_i32(a->cd);
+    TCGv_i32 oprsz = tcg_constant_i32(sz);
 
     CHECK_VEC;
-    func(cpu_env, cd, vj);
+
+    func(cpu_env, oprsz, cd, vj);
     return true;
 }
 
@@ -3968,26 +3970,24 @@ static bool do_vfcmp_cond_d(DisasContext *ctx, arg_vvv_fcond *a, uint32_t sz)
 TRANS(vfcmp_cond_s, LSX, do_vfcmp_cond_s, 16)
 TRANS(vfcmp_cond_d, LSX, do_vfcmp_cond_d, 16)
 
-static bool trans_vbitsel_v(DisasContext *ctx, arg_vvvv *a)
+static bool do_vbitsel_v(DisasContext *ctx, arg_vvvv *a, uint32_t oprsz)
 {
-    if (!avail_LSX(ctx)) {
-        return false;
-    }
-
     CHECK_VEC;
 
     tcg_gen_gvec_bitsel(MO_64, vec_full_offset(a->vd), vec_full_offset(a->va),
                         vec_full_offset(a->vk), vec_full_offset(a->vj),
-                        16, ctx->vl/8);
+                        oprsz, ctx->vl / 8);
     return true;
 }
 
+TRANS(vbitsel_v, LASX, do_vbitsel_v, 16)
+
 static void gen_vbitseli(unsigned vece, TCGv_vec a, TCGv_vec b, int64_t imm)
 {
     tcg_gen_bitsel_vec(vece, a, a, tcg_constant_vec_matching(a, vece, imm), b);
 }
 
-static bool trans_vbitseli_b(DisasContext *ctx, arg_vv_i *a)
+static bool do_vbitseli_b(DisasContext *ctx, arg_vv_i *a, uint32_t oprsz)
 {
     static const GVecGen2i op = {
        .fniv = gen_vbitseli,
@@ -3996,17 +3996,15 @@ static bool trans_vbitseli_b(DisasContext *ctx, arg_vv_i *a)
        .load_dest = true
     };
 
-    if (!avail_LSX(ctx)) {
-        return false;
-    }
-
     CHECK_VEC;
 
     tcg_gen_gvec_2i(vec_full_offset(a->vd), vec_full_offset(a->vj),
-                    16, ctx->vl/8, a->imm, &op);
+                    oprsz, ctx->vl / 8, a->imm, &op);
     return true;
 }
 
+TRANS(vbitseli_b, LASX, do_vbitseli_b, 16)
+
 #define VSET(NAME, COND)                                                       \
 static bool trans_## NAME (DisasContext *ctx, arg_cv *a)                       \
 {                                                                              \
@@ -4034,14 +4032,14 @@ static bool trans_## NAME (DisasContext *ctx, arg_cv *a)                       \
 VSET(vseteqz_v, TCG_COND_EQ)
 VSET(vsetnez_v, TCG_COND_NE)
 
-TRANS(vsetanyeqz_b, LSX, gen_cv, gen_helper_vsetanyeqz_b)
-TRANS(vsetanyeqz_h, LSX, gen_cv, gen_helper_vsetanyeqz_h)
-TRANS(vsetanyeqz_w, LSX, gen_cv, gen_helper_vsetanyeqz_w)
-TRANS(vsetanyeqz_d, LSX, gen_cv, gen_helper_vsetanyeqz_d)
-TRANS(vsetallnez_b, LSX, gen_cv, gen_helper_vsetallnez_b)
-TRANS(vsetallnez_h, LSX, gen_cv, gen_helper_vsetallnez_h)
-TRANS(vsetallnez_w, LSX, gen_cv, gen_helper_vsetallnez_w)
-TRANS(vsetallnez_d, LSX, gen_cv, gen_helper_vsetallnez_d)
+TRANS(vsetanyeqz_b, LSX, gen_cv, 16, gen_helper_vsetanyeqz_b)
+TRANS(vsetanyeqz_h, LSX, gen_cv, 16, gen_helper_vsetanyeqz_h)
+TRANS(vsetanyeqz_w, LSX, gen_cv, 16, gen_helper_vsetanyeqz_w)
+TRANS(vsetanyeqz_d, LSX, gen_cv, 16, gen_helper_vsetanyeqz_d)
+TRANS(vsetallnez_b, LSX, gen_cv, 16, gen_helper_vsetallnez_b)
+TRANS(vsetallnez_h, LSX, gen_cv, 16, gen_helper_vsetallnez_h)
+TRANS(vsetallnez_w, LSX, gen_cv, 16, gen_helper_vsetallnez_w)
+TRANS(vsetallnez_d, LSX, gen_cv, 16, gen_helper_vsetallnez_d)
 
 static bool trans_vinsgr2vr_b(DisasContext *ctx, arg_vr_i *a)
 {
-- 
2.39.1


