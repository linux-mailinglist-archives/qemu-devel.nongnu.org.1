Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1457367F3
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:39:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXpS-0007LC-TS; Tue, 20 Jun 2023 05:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXp8-0007Cq-3D
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:39:01 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXp5-0006Oy-2j
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:53 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bx4Oiec5Fk2yUHAA--.12806S3;
 Tue, 20 Jun 2023 17:38:38 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S41; 
 Tue, 20 Jun 2023 17:38:37 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 39/46] target/loongarch: Implement xvfcmp
Date: Tue, 20 Jun 2023 17:38:07 +0800
Message-Id: <20230620093814.123650-40-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S41
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
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
- XVFCMP.cond.{S/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     | 94 ++++++++++++++++++++
 target/loongarch/helper.h                    |  5 ++
 target/loongarch/insn_trans/trans_lasx.c.inc | 32 +++++++
 target/loongarch/insns.decode                |  5 ++
 target/loongarch/lasx_helper.c               | 25 ++++++
 target/loongarch/lsx_helper.c                |  4 +-
 target/loongarch/vec.h                       |  5 ++
 7 files changed, 168 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 5d3904402d..c3bcb9d84a 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2384,6 +2384,100 @@ INSN_LASX(xvslti_hu,         xx_i)
 INSN_LASX(xvslti_wu,         xx_i)
 INSN_LASX(xvslti_du,         xx_i)
 
+#define output_xvfcmp(C, PREFIX, SUFFIX)                                    \
+{                                                                           \
+    (C)->info->fprintf_func((C)->info->stream, "%08x  %s%s\tx%d, x%d, x%d", \
+                            (C)->insn, PREFIX, SUFFIX, a->xd,               \
+                            a->xj, a->xk);                                  \
+}
+
+static bool output_xxx_fcond(DisasContext *ctx, arg_xxx_fcond * a,
+                             const char *suffix)
+{
+    bool ret = true;
+    switch (a->fcond) {
+    case 0x0:
+        output_xvfcmp(ctx, "xvfcmp_caf_", suffix);
+        break;
+    case 0x1:
+        output_xvfcmp(ctx, "xvfcmp_saf_", suffix);
+        break;
+    case 0x2:
+        output_xvfcmp(ctx, "xvfcmp_clt_", suffix);
+        break;
+    case 0x3:
+        output_xvfcmp(ctx, "xvfcmp_slt_", suffix);
+        break;
+    case 0x4:
+        output_xvfcmp(ctx, "xvfcmp_ceq_", suffix);
+        break;
+    case 0x5:
+        output_xvfcmp(ctx, "xvfcmp_seq_", suffix);
+        break;
+    case 0x6:
+        output_xvfcmp(ctx, "xvfcmp_cle_", suffix);
+        break;
+    case 0x7:
+        output_xvfcmp(ctx, "xvfcmp_sle_", suffix);
+        break;
+    case 0x8:
+        output_xvfcmp(ctx, "xvfcmp_cun_", suffix);
+        break;
+    case 0x9:
+        output_xvfcmp(ctx, "xvfcmp_sun_", suffix);
+        break;
+    case 0xA:
+        output_xvfcmp(ctx, "xvfcmp_cult_", suffix);
+        break;
+    case 0xB:
+        output_xvfcmp(ctx, "xvfcmp_sult_", suffix);
+        break;
+    case 0xC:
+        output_xvfcmp(ctx, "xvfcmp_cueq_", suffix);
+        break;
+    case 0xD:
+        output_xvfcmp(ctx, "xvfcmp_sueq_", suffix);
+        break;
+    case 0xE:
+        output_xvfcmp(ctx, "xvfcmp_cule_", suffix);
+        break;
+    case 0xF:
+        output_xvfcmp(ctx, "xvfcmp_sule_", suffix);
+        break;
+    case 0x10:
+        output_xvfcmp(ctx, "xvfcmp_cne_", suffix);
+        break;
+    case 0x11:
+        output_xvfcmp(ctx, "xvfcmp_sne_", suffix);
+        break;
+    case 0x14:
+        output_xvfcmp(ctx, "xvfcmp_cor_", suffix);
+        break;
+    case 0x15:
+        output_xvfcmp(ctx, "xvfcmp_sor_", suffix);
+        break;
+    case 0x18:
+        output_xvfcmp(ctx, "xvfcmp_cune_", suffix);
+        break;
+    case 0x19:
+        output_xvfcmp(ctx, "xvfcmp_sune_", suffix);
+        break;
+    default:
+        ret = false;
+    }
+    return ret;
+}
+
+#define LASX_FCMP_INSN(suffix)                            \
+static bool trans_xvfcmp_cond_##suffix(DisasContext *ctx, \
+                                       arg_xxx_fcond * a) \
+{                                                         \
+    return output_xxx_fcond(ctx, a, #suffix);             \
+}
+
+LASX_FCMP_INSN(s)
+LASX_FCMP_INSN(d)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index fbfd15d711..665bcb812a 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -1216,3 +1216,8 @@ DEF_HELPER_FLAGS_4(xvslti_bu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(xvslti_hu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(xvslti_wu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(xvslti_du, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_5(xvfcmp_c_s, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(xvfcmp_s_s, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(xvfcmp_c_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(xvfcmp_s_d, void, env, i32, i32, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index cc1b4fd42a..cdcd4a279a 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -2674,6 +2674,38 @@ TRANS(xvslti_hu, do_xvslti_u, MO_16)
 TRANS(xvslti_wu, do_xvslti_u, MO_32)
 TRANS(xvslti_du, do_xvslti_u, MO_64)
 
+static bool trans_xvfcmp_cond_s(DisasContext *ctx, arg_xxx_fcond * a)
+{
+    uint32_t flags;
+    void (*fn)(TCGv_env, TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32);
+    TCGv_i32 xd = tcg_constant_i32(a->xd);
+    TCGv_i32 xj = tcg_constant_i32(a->xj);
+    TCGv_i32 xk = tcg_constant_i32(a->xk);
+
+    CHECK_SXE;
+
+    fn = (a->fcond & 1 ? gen_helper_xvfcmp_s_s : gen_helper_xvfcmp_c_s);
+    flags = get_fcmp_flags(a->fcond >> 1);
+    fn(cpu_env, xd, xj, xk, tcg_constant_i32(flags));
+
+    return true;
+}
+
+static bool trans_xvfcmp_cond_d(DisasContext *ctx, arg_xxx_fcond *a)
+{
+    uint32_t flags;
+    void (*fn)(TCGv_env, TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32);
+    TCGv_i32 xd = tcg_constant_i32(a->xd);
+    TCGv_i32 xj = tcg_constant_i32(a->xj);
+    TCGv_i32 xk = tcg_constant_i32(a->xk);
+
+    fn = (a->fcond & 1 ? gen_helper_xvfcmp_s_d : gen_helper_xvfcmp_c_d);
+    flags = get_fcmp_flags(a->fcond >> 1);
+    fn(cpu_env, xd, xj, xk, tcg_constant_i32(flags));
+
+    return true;
+}
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 4e1f0b30a0..df45dc3d76 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1307,6 +1307,7 @@ vstelm_b         0011 000110 .... ........ ..... .....    @vr_i8i4
 &xx_i         xd xj imm
 &x_i          xd imm
 &xxxx         xd xj xk xa
+&xxx_fcond    xd xj xk fcond
 
 #
 # LASX Formats
@@ -1324,6 +1325,7 @@ vstelm_b         0011 000110 .... ........ ..... .....    @vr_i8i4
 @xx_ui7              .... ........ ... imm:7 xj:5 xd:5    &xx_i
 @xx_ui8               .... ........ .. imm:8 xj:5 xd:5    &xx_i
 @xxxx                .... ........ xa:5 xk:5 xj:5 xd:5    &xxxx
+@xxx_fcond        .... ........ fcond:5 xk:5 xj:5 xd:5    &xxx_fcond
 
 xvadd_b          0111 01000000 10100 ..... ..... .....    @xxx
 xvadd_h          0111 01000000 10101 ..... ..... .....    @xxx
@@ -1983,6 +1985,9 @@ xvslti_hu        0111 01101000 10001 ..... ..... .....    @xx_ui5
 xvslti_wu        0111 01101000 10010 ..... ..... .....    @xx_ui5
 xvslti_du        0111 01101000 10011 ..... ..... .....    @xx_ui5
 
+xvfcmp_cond_s    0000 11001001 ..... ..... ..... .....    @xxx_fcond
+xvfcmp_cond_d    0000 11001010 ..... ..... ..... .....    @xxx_fcond
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index d0bc02de72..1d56fe7b22 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -2757,3 +2757,28 @@ XVCMPI(xvslti_bu, 8, UXB, VSLT)
 XVCMPI(xvslti_hu, 16, UXH, VSLT)
 XVCMPI(xvslti_wu, 32, UXW, VSLT)
 XVCMPI(xvslti_du, 64, UXD, VSLT)
+
+#define XVFCMP(NAME, BIT, E, FN)                                         \
+void HELPER(NAME)(CPULoongArchState *env,                                \
+                  uint32_t xd, uint32_t xj, uint32_t xk, uint32_t flags) \
+{                                                                        \
+    int i;                                                               \
+    XReg t;                                                              \
+    XReg *Xd = &(env->fpr[xd].xreg);                                     \
+    XReg *Xj = &(env->fpr[xj].xreg);                                     \
+    XReg *Xk = &(env->fpr[xk].xreg);                                     \
+                                                                         \
+    vec_clear_cause(env);                                                \
+    for (i = 0; i < LASX_LEN / BIT ; i++) {                              \
+        FloatRelation cmp;                                               \
+        cmp = FN(Xj->E(i), Xk->E(i), &env->fp_status);                   \
+        t.E(i) = vfcmp_common(env, cmp, flags);                          \
+        vec_update_fcsr0(env, GETPC());                                  \
+    }                                                                    \
+    *Xd = t;                                                             \
+}
+
+XVFCMP(xvfcmp_c_s, 32, UXW, float32_compare_quiet)
+XVFCMP(xvfcmp_s_s, 32, UXW, float32_compare)
+XVFCMP(xvfcmp_c_d, 64, UXD, float64_compare_quiet)
+XVFCMP(xvfcmp_s_d, 64, UXD, float64_compare)
diff --git a/target/loongarch/lsx_helper.c b/target/loongarch/lsx_helper.c
index 22d71cb39e..4a5c1a47a1 100644
--- a/target/loongarch/lsx_helper.c
+++ b/target/loongarch/lsx_helper.c
@@ -2622,8 +2622,8 @@ VCMPI(vslti_hu, 16, UH, VSLT)
 VCMPI(vslti_wu, 32, UW, VSLT)
 VCMPI(vslti_du, 64, UD, VSLT)
 
-static uint64_t vfcmp_common(CPULoongArchState *env,
-                             FloatRelation cmp, uint32_t flags)
+uint64_t vfcmp_common(CPULoongArchState *env,
+                      FloatRelation cmp, uint32_t flags)
 {
     uint64_t ret = 0;
 
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index 54fd2689f3..134dd265bf 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -8,6 +8,8 @@
 #ifndef LOONGARCH_VEC_H
 #define LOONGARCH_VEC_H
 
+#include "fpu/softfloat.h"
+
 #if HOST_BIG_ENDIAN
 #define B(x)  B[15 - (x)]
 #define H(x)  H[7 - (x)]
@@ -113,4 +115,7 @@ uint64_t do_frecip_64(CPULoongArchState *env, uint64_t fj);
 uint32_t do_frsqrt_32(CPULoongArchState *env, uint32_t fj);
 uint64_t do_frsqrt_64(CPULoongArchState *env, uint64_t fj);
 
+uint64_t vfcmp_common(CPULoongArchState *env,
+                      FloatRelation cmp, uint32_t flags);
+
 #endif /* LOONGARCH_VEC_H */
-- 
2.39.1


