Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D40A879F81A
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:31:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgc6M-0006pV-QO; Wed, 13 Sep 2023 22:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qgc51-0003KY-Hi
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:27:46 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qgc4x-00054p-3u
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:27:42 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxbeuObwJlvfgmAA--.7592S3;
 Thu, 14 Sep 2023 10:27:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxvdxmbwJlJ+UDAA--.7298S51; 
 Thu, 14 Sep 2023 10:27:25 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH v6 49/57] target/loongarch: Implement xvfcmp
Date: Thu, 14 Sep 2023 10:26:37 +0800
Message-Id: <20230914022645.1151356-50-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230914022645.1151356-1-gaosong@loongson.cn>
References: <20230914022645.1151356-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxvdxmbwJlJ+UDAA--.7298S51
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
- XVFCMP.cond.{S/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/helper.h                   |  8 +-
 target/loongarch/insns.decode               |  3 +
 target/loongarch/disas.c                    | 93 +++++++++++++++++++++
 target/loongarch/vec_helper.c               |  4 +-
 target/loongarch/insn_trans/trans_vec.c.inc | 31 ++++---
 5 files changed, 117 insertions(+), 22 deletions(-)

diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index e9c5412267..b54ce68077 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -652,10 +652,10 @@ DEF_HELPER_FLAGS_4(vslti_hu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(vslti_wu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(vslti_du, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 
-DEF_HELPER_5(vfcmp_c_s, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(vfcmp_s_s, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(vfcmp_c_d, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(vfcmp_s_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_6(vfcmp_c_s, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vfcmp_s_s, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vfcmp_c_d, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vfcmp_s_d, void, env, i32, i32, i32, i32, i32)
 
 DEF_HELPER_FLAGS_4(vbitseli_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 82c26a318b..0d46bd5e5e 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1958,6 +1958,9 @@ xvslti_hu        0111 01101000 10001 ..... ..... .....    @vv_ui5
 xvslti_wu        0111 01101000 10010 ..... ..... .....    @vv_ui5
 xvslti_du        0111 01101000 10011 ..... ..... .....    @vv_ui5
 
+xvfcmp_cond_s    0000 11001001 ..... ..... ..... .....    @vvv_fcond
+xvfcmp_cond_d    0000 11001010 ..... ..... ..... .....    @vvv_fcond
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 48e0b559f2..4ab51b712e 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2385,6 +2385,99 @@ INSN_LASX(xvslti_hu,         vv_i)
 INSN_LASX(xvslti_wu,         vv_i)
 INSN_LASX(xvslti_du,         vv_i)
 
+#define output_xvfcmp(C, PREFIX, SUFFIX)                                    \
+{                                                                           \
+    (C)->info->fprintf_func((C)->info->stream, "%08x  %s%s\tx%d, x%d, x%d", \
+                            (C)->insn, PREFIX, SUFFIX, a->vd,               \
+                            a->vj, a->vk);                                  \
+}
+static bool output_xxx_fcond(DisasContext *ctx, arg_vvv_fcond * a,
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
+                                       arg_vvv_fcond * a) \
+{                                                         \
+    return output_xxx_fcond(ctx, a, #suffix);             \
+}
+
+LASX_FCMP_INSN(s)
+LASX_FCMP_INSN(d)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 960b3d19ec..5188b7f72d 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -3122,7 +3122,7 @@ static uint64_t vfcmp_common(CPULoongArchState *env,
 }
 
 #define VFCMP(NAME, BIT, E, FN)                                          \
-void HELPER(NAME)(CPULoongArchState *env,                                \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz,                \
                   uint32_t vd, uint32_t vj, uint32_t vk, uint32_t flags) \
 {                                                                        \
     int i;                                                               \
@@ -3132,7 +3132,7 @@ void HELPER(NAME)(CPULoongArchState *env,                                \
     VReg *Vk = &(env->fpr[vk].vreg);                                     \
                                                                          \
     vec_clear_cause(env);                                                \
-    for (i = 0; i < LSX_LEN/BIT ; i++) {                                 \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                            \
         FloatRelation cmp;                                               \
         cmp = FN(Vj->E(i), Vk->E(i), &env->fp_status);                   \
         t.E(i) = vfcmp_common(env, cmp, flags);                          \
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 63d71e2332..9b89b81cfb 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -4645,52 +4645,51 @@ TRANS(xvslti_hu, LASX, do_xcmpi, MO_16, TCG_COND_LTU)
 TRANS(xvslti_wu, LASX, do_xcmpi, MO_32, TCG_COND_LTU)
 TRANS(xvslti_du, LASX, do_xcmpi, MO_64, TCG_COND_LTU)
 
-static bool trans_vfcmp_cond_s(DisasContext *ctx, arg_vvv_fcond *a)
+static bool do_vfcmp_cond_s(DisasContext *ctx, arg_vvv_fcond *a, uint32_t sz)
 {
     uint32_t flags;
-    void (*fn)(TCGv_env, TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32);
+    void (*fn)(TCGv_env, TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32);
     TCGv_i32 vd = tcg_constant_i32(a->vd);
     TCGv_i32 vj = tcg_constant_i32(a->vj);
     TCGv_i32 vk = tcg_constant_i32(a->vk);
+    TCGv_i32 oprsz = tcg_constant_i32(sz);
 
-    if (!avail_LSX(ctx)) {
-        return false;
-    }
-
-    if (!check_vec(ctx, 16)) {
+    if (!check_vec(ctx, sz)) {
         return true;
     }
 
     fn = (a->fcond & 1 ? gen_helper_vfcmp_s_s : gen_helper_vfcmp_c_s);
     flags = get_fcmp_flags(a->fcond >> 1);
-    fn(cpu_env, vd, vj, vk,  tcg_constant_i32(flags));
+    fn(cpu_env, oprsz, vd, vj, vk, tcg_constant_i32(flags));
 
     return true;
 }
 
-static bool trans_vfcmp_cond_d(DisasContext *ctx, arg_vvv_fcond *a)
+static bool do_vfcmp_cond_d(DisasContext *ctx, arg_vvv_fcond *a, uint32_t sz)
 {
     uint32_t flags;
-    void (*fn)(TCGv_env, TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32);
+    void (*fn)(TCGv_env, TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32);
     TCGv_i32 vd = tcg_constant_i32(a->vd);
     TCGv_i32 vj = tcg_constant_i32(a->vj);
     TCGv_i32 vk = tcg_constant_i32(a->vk);
+    TCGv_i32 oprsz = tcg_constant_i32(sz);
 
-    if (!avail_LSX(ctx)) {
-        return false;
-    }
-
-    if (!check_vec(ctx, 16)) {
+    if (!check_vec(ctx, sz)) {
         return true;
     }
 
     fn = (a->fcond & 1 ? gen_helper_vfcmp_s_d : gen_helper_vfcmp_c_d);
     flags = get_fcmp_flags(a->fcond >> 1);
-    fn(cpu_env, vd, vj, vk, tcg_constant_i32(flags));
+    fn(cpu_env, oprsz, vd, vj, vk, tcg_constant_i32(flags));
 
     return true;
 }
 
+TRANS(vfcmp_cond_s, LSX, do_vfcmp_cond_s, 16)
+TRANS(vfcmp_cond_d, LSX, do_vfcmp_cond_d, 16)
+TRANS(xvfcmp_cond_s, LASX, do_vfcmp_cond_s, 32)
+TRANS(xvfcmp_cond_d, LASX, do_vfcmp_cond_d, 32)
+
 static bool trans_vbitsel_v(DisasContext *ctx, arg_vvvv *a)
 {
     if (!avail_LSX(ctx)) {
-- 
2.39.1


