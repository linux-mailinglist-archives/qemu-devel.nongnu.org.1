Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3F87A732B
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 08:53:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qir46-0007jf-Gz; Wed, 20 Sep 2023 02:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qir43-0007iB-TA
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 02:51:59 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qir3y-0003zq-NE
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 02:51:59 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxbOqClgpley8qAA--.53624S3;
 Wed, 20 Sep 2023 14:51:46 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dxzdx7lgplhVYMAA--.24315S7; 
 Wed, 20 Sep 2023 14:51:46 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/57] target/loongarch: Use gen_helper_gvec_3_ptr for 3OP +
 env vector instructions
Date: Wed, 20 Sep 2023 14:50:47 +0800
Message-Id: <20230920065139.1403868-6-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230920065139.1403868-1-gaosong@loongson.cn>
References: <20230920065139.1403868-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxzdx7lgplhVYMAA--.24315S7
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230914022645.1151356-6-gaosong@loongson.cn>
---
 target/loongarch/helper.h                   | 48 +++++++--------
 target/loongarch/vec_helper.c               | 50 ++++++++--------
 target/loongarch/insn_trans/trans_vec.c.inc | 66 +++++++++++++--------
 3 files changed, 91 insertions(+), 73 deletions(-)

diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 727ccfb32c..bcf82597aa 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -519,14 +519,14 @@ DEF_HELPER_4(vfrstp_h, void, env, i32, i32, i32)
 DEF_HELPER_4(vfrstpi_b, void, env, i32, i32, i32)
 DEF_HELPER_4(vfrstpi_h, void, env, i32, i32, i32)
 
-DEF_HELPER_4(vfadd_s, void, env, i32, i32, i32)
-DEF_HELPER_4(vfadd_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vfsub_s, void, env, i32, i32, i32)
-DEF_HELPER_4(vfsub_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vfmul_s, void, env, i32, i32, i32)
-DEF_HELPER_4(vfmul_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vfdiv_s, void, env, i32, i32, i32)
-DEF_HELPER_4(vfdiv_d, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_5(vfadd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfadd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfsub_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfsub_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfmul_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfmul_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfdiv_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfdiv_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_6(vfmadd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_6(vfmadd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
@@ -537,15 +537,15 @@ DEF_HELPER_FLAGS_6(vfnmadd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i3
 DEF_HELPER_FLAGS_6(vfnmsub_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_6(vfnmsub_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
 
-DEF_HELPER_4(vfmax_s, void, env, i32, i32, i32)
-DEF_HELPER_4(vfmax_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vfmin_s, void, env, i32, i32, i32)
-DEF_HELPER_4(vfmin_d, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_5(vfmax_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfmax_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfmin_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfmin_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 
-DEF_HELPER_4(vfmaxa_s, void, env, i32, i32, i32)
-DEF_HELPER_4(vfmaxa_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vfmina_s, void, env, i32, i32, i32)
-DEF_HELPER_4(vfmina_d, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_5(vfmaxa_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfmaxa_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfmina_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfmina_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_3(vflogb_s, void, env, i32, i32)
 DEF_HELPER_3(vflogb_d, void, env, i32, i32)
@@ -564,8 +564,8 @@ DEF_HELPER_3(vfcvtl_s_h, void, env, i32, i32)
 DEF_HELPER_3(vfcvth_s_h, void, env, i32, i32)
 DEF_HELPER_3(vfcvtl_d_s, void, env, i32, i32)
 DEF_HELPER_3(vfcvth_d_s, void, env, i32, i32)
-DEF_HELPER_4(vfcvt_h_s, void, env, i32, i32, i32)
-DEF_HELPER_4(vfcvt_s_d, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_5(vfcvt_h_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfcvt_s_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_3(vfrintrne_s, void, env, i32, i32)
 DEF_HELPER_3(vfrintrne_d, void, env, i32, i32)
@@ -592,11 +592,11 @@ DEF_HELPER_3(vftintrz_wu_s, void, env, i32, i32)
 DEF_HELPER_3(vftintrz_lu_d, void, env, i32, i32)
 DEF_HELPER_3(vftint_wu_s, void, env, i32, i32)
 DEF_HELPER_3(vftint_lu_d, void, env, i32, i32)
-DEF_HELPER_4(vftintrne_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vftintrz_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vftintrp_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vftintrm_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vftint_w_d, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_5(vftintrne_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vftintrz_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vftintrp_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vftintrm_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vftint_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_3(vftintrnel_l_s, void, env, i32, i32)
 DEF_HELPER_3(vftintrneh_l_s, void, env, i32, i32)
 DEF_HELPER_3(vftintrzl_l_s, void, env, i32, i32)
@@ -614,7 +614,7 @@ DEF_HELPER_3(vffint_s_wu, void, env, i32, i32)
 DEF_HELPER_3(vffint_d_lu, void, env, i32, i32)
 DEF_HELPER_3(vffintl_d_w, void, env, i32, i32)
 DEF_HELPER_3(vffinth_d_w, void, env, i32, i32)
-DEF_HELPER_4(vffint_s_l, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_5(vffint_s_l, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_4(vseqi_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(vseqi_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 7078c4c845..eab94a8b76 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -2096,13 +2096,13 @@ static inline void vec_clear_cause(CPULoongArchState *env)
 }
 
 #define DO_3OP_F(NAME, BIT, E, FN)                          \
-void HELPER(NAME)(CPULoongArchState *env,                   \
-                  uint32_t vd, uint32_t vj, uint32_t vk)    \
+void HELPER(NAME)(void *vd, void *vj, void *vk,             \
+                  CPULoongArchState *env, uint32_t desc)    \
 {                                                           \
     int i;                                                  \
-    VReg *Vd = &(env->fpr[vd].vreg);                        \
-    VReg *Vj = &(env->fpr[vj].vreg);                        \
-    VReg *Vk = &(env->fpr[vk].vreg);                        \
+    VReg *Vd = (VReg *)vd;                                  \
+    VReg *Vj = (VReg *)vj;                                  \
+    VReg *Vk = (VReg *)vk;                                  \
                                                             \
     vec_clear_cause(env);                                   \
     for (i = 0; i < LSX_LEN/BIT; i++) {                     \
@@ -2326,14 +2326,14 @@ void HELPER(vfcvth_d_s)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
     *Vd = temp;
 }
 
-void HELPER(vfcvt_h_s)(CPULoongArchState *env,
-                       uint32_t vd, uint32_t vj, uint32_t vk)
+void HELPER(vfcvt_h_s)(void *vd, void *vj, void *vk,
+                       CPULoongArchState *env, uint32_t desc)
 {
     int i;
     VReg temp;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
-    VReg *Vk = &(env->fpr[vk].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
+    VReg *Vk = (VReg *)vk;
 
     vec_clear_cause(env);
     for(i = 0; i < LSX_LEN/32; i++) {
@@ -2344,14 +2344,14 @@ void HELPER(vfcvt_h_s)(CPULoongArchState *env,
     *Vd = temp;
 }
 
-void HELPER(vfcvt_s_d)(CPULoongArchState *env,
-                       uint32_t vd, uint32_t vj, uint32_t vk)
+void HELPER(vfcvt_s_d)(void *vd, void *vj, void *vk,
+                       CPULoongArchState *env, uint32_t desc)
 {
     int i;
     VReg temp;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
-    VReg *Vk = &(env->fpr[vk].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
+    VReg *Vk = (VReg *)vk;
 
     vec_clear_cause(env);
     for(i = 0; i < LSX_LEN/64; i++) {
@@ -2482,14 +2482,14 @@ FTINT(rz_w_d, float64, int32, uint64_t, uint32_t, float_round_to_zero)
 FTINT(rne_w_d, float64, int32, uint64_t, uint32_t, float_round_nearest_even)
 
 #define FTINT_W_D(NAME, FN)                              \
-void HELPER(NAME)(CPULoongArchState *env,                \
-                  uint32_t vd, uint32_t vj, uint32_t vk) \
+void HELPER(NAME)(void *vd, void *vj, void *vk,          \
+                  CPULoongArchState *env, uint32_t desc) \
 {                                                        \
     int i;                                               \
     VReg temp;                                           \
-    VReg *Vd = &(env->fpr[vd].vreg);                     \
-    VReg *Vj = &(env->fpr[vj].vreg);                     \
-    VReg *Vk = &(env->fpr[vk].vreg);                     \
+    VReg *Vd = (VReg *)vd;                               \
+    VReg *Vj = (VReg *)vj;                               \
+    VReg *Vk = (VReg *)vk;                               \
                                                          \
     vec_clear_cause(env);                                \
     for (i = 0; i < 2; i++) {                            \
@@ -2606,14 +2606,14 @@ void HELPER(vffinth_d_w)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
     *Vd = temp;
 }
 
-void HELPER(vffint_s_l)(CPULoongArchState *env,
-                        uint32_t vd, uint32_t vj, uint32_t vk)
+void HELPER(vffint_s_l)(void *vd, void *vj, void *vk,
+                        CPULoongArchState *env, uint32_t desc)
 {
     int i;
     VReg temp;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
-    VReg *Vk = &(env->fpr[vk].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
+    VReg *Vk = (VReg *)vk;
 
     vec_clear_cause(env);
     for (i = 0; i < 2; i++) {
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 71b1b5ef58..4547ba304d 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -52,6 +52,24 @@ static bool gen_vvvv(DisasContext *ctx, arg_vvvv *a,
     return gen_vvvv_vl(ctx, a, 16, fn);
 }
 
+static bool gen_vvv_ptr_vl(DisasContext *ctx, arg_vvv *a, uint32_t oprsz,
+                           gen_helper_gvec_3_ptr *fn)
+{
+    tcg_gen_gvec_3_ptr(vec_full_offset(a->vd),
+                       vec_full_offset(a->vj),
+                       vec_full_offset(a->vk),
+                       cpu_env,
+                       oprsz, ctx->vl / 8, 0, fn);
+    return true;
+}
+
+static bool gen_vvv_ptr(DisasContext *ctx, arg_vvv *a,
+                        gen_helper_gvec_3_ptr *fn)
+{
+    CHECK_SXE;
+    return gen_vvv_ptr_vl(ctx, a, 16, fn);
+}
+
 static bool gen_vvv(DisasContext *ctx, arg_vvv *a,
                     void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32))
 {
@@ -3648,14 +3666,14 @@ TRANS(vfrstp_h, LSX, gen_vvv, gen_helper_vfrstp_h)
 TRANS(vfrstpi_b, LSX, gen_vv_i, gen_helper_vfrstpi_b)
 TRANS(vfrstpi_h, LSX, gen_vv_i, gen_helper_vfrstpi_h)
 
-TRANS(vfadd_s, LSX, gen_vvv, gen_helper_vfadd_s)
-TRANS(vfadd_d, LSX, gen_vvv, gen_helper_vfadd_d)
-TRANS(vfsub_s, LSX, gen_vvv, gen_helper_vfsub_s)
-TRANS(vfsub_d, LSX, gen_vvv, gen_helper_vfsub_d)
-TRANS(vfmul_s, LSX, gen_vvv, gen_helper_vfmul_s)
-TRANS(vfmul_d, LSX, gen_vvv, gen_helper_vfmul_d)
-TRANS(vfdiv_s, LSX, gen_vvv, gen_helper_vfdiv_s)
-TRANS(vfdiv_d, LSX, gen_vvv, gen_helper_vfdiv_d)
+TRANS(vfadd_s, LSX, gen_vvv_ptr, gen_helper_vfadd_s)
+TRANS(vfadd_d, LSX, gen_vvv_ptr, gen_helper_vfadd_d)
+TRANS(vfsub_s, LSX, gen_vvv_ptr, gen_helper_vfsub_s)
+TRANS(vfsub_d, LSX, gen_vvv_ptr, gen_helper_vfsub_d)
+TRANS(vfmul_s, LSX, gen_vvv_ptr, gen_helper_vfmul_s)
+TRANS(vfmul_d, LSX, gen_vvv_ptr, gen_helper_vfmul_d)
+TRANS(vfdiv_s, LSX, gen_vvv_ptr, gen_helper_vfdiv_s)
+TRANS(vfdiv_d, LSX, gen_vvv_ptr, gen_helper_vfdiv_d)
 
 TRANS(vfmadd_s, LSX, gen_vvvv_ptr, gen_helper_vfmadd_s)
 TRANS(vfmadd_d, LSX, gen_vvvv_ptr, gen_helper_vfmadd_d)
@@ -3666,15 +3684,15 @@ TRANS(vfnmadd_d, LSX, gen_vvvv_ptr, gen_helper_vfnmadd_d)
 TRANS(vfnmsub_s, LSX, gen_vvvv_ptr, gen_helper_vfnmsub_s)
 TRANS(vfnmsub_d, LSX, gen_vvvv_ptr, gen_helper_vfnmsub_d)
 
-TRANS(vfmax_s, LSX, gen_vvv, gen_helper_vfmax_s)
-TRANS(vfmax_d, LSX, gen_vvv, gen_helper_vfmax_d)
-TRANS(vfmin_s, LSX, gen_vvv, gen_helper_vfmin_s)
-TRANS(vfmin_d, LSX, gen_vvv, gen_helper_vfmin_d)
+TRANS(vfmax_s, LSX, gen_vvv_ptr, gen_helper_vfmax_s)
+TRANS(vfmax_d, LSX, gen_vvv_ptr, gen_helper_vfmax_d)
+TRANS(vfmin_s, LSX, gen_vvv_ptr, gen_helper_vfmin_s)
+TRANS(vfmin_d, LSX, gen_vvv_ptr, gen_helper_vfmin_d)
 
-TRANS(vfmaxa_s, LSX, gen_vvv, gen_helper_vfmaxa_s)
-TRANS(vfmaxa_d, LSX, gen_vvv, gen_helper_vfmaxa_d)
-TRANS(vfmina_s, LSX, gen_vvv, gen_helper_vfmina_s)
-TRANS(vfmina_d, LSX, gen_vvv, gen_helper_vfmina_d)
+TRANS(vfmaxa_s, LSX, gen_vvv_ptr, gen_helper_vfmaxa_s)
+TRANS(vfmaxa_d, LSX, gen_vvv_ptr, gen_helper_vfmaxa_d)
+TRANS(vfmina_s, LSX, gen_vvv_ptr, gen_helper_vfmina_s)
+TRANS(vfmina_d, LSX, gen_vvv_ptr, gen_helper_vfmina_d)
 
 TRANS(vflogb_s, LSX, gen_vv, gen_helper_vflogb_s)
 TRANS(vflogb_d, LSX, gen_vv, gen_helper_vflogb_d)
@@ -3693,8 +3711,8 @@ TRANS(vfcvtl_s_h, LSX, gen_vv, gen_helper_vfcvtl_s_h)
 TRANS(vfcvth_s_h, LSX, gen_vv, gen_helper_vfcvth_s_h)
 TRANS(vfcvtl_d_s, LSX, gen_vv, gen_helper_vfcvtl_d_s)
 TRANS(vfcvth_d_s, LSX, gen_vv, gen_helper_vfcvth_d_s)
-TRANS(vfcvt_h_s, LSX, gen_vvv, gen_helper_vfcvt_h_s)
-TRANS(vfcvt_s_d, LSX, gen_vvv, gen_helper_vfcvt_s_d)
+TRANS(vfcvt_h_s, LSX, gen_vvv_ptr, gen_helper_vfcvt_h_s)
+TRANS(vfcvt_s_d, LSX, gen_vvv_ptr, gen_helper_vfcvt_s_d)
 
 TRANS(vfrintrne_s, LSX, gen_vv, gen_helper_vfrintrne_s)
 TRANS(vfrintrne_d, LSX, gen_vv, gen_helper_vfrintrne_d)
@@ -3721,11 +3739,11 @@ TRANS(vftintrz_wu_s, LSX, gen_vv, gen_helper_vftintrz_wu_s)
 TRANS(vftintrz_lu_d, LSX, gen_vv, gen_helper_vftintrz_lu_d)
 TRANS(vftint_wu_s, LSX, gen_vv, gen_helper_vftint_wu_s)
 TRANS(vftint_lu_d, LSX, gen_vv, gen_helper_vftint_lu_d)
-TRANS(vftintrne_w_d, LSX, gen_vvv, gen_helper_vftintrne_w_d)
-TRANS(vftintrz_w_d, LSX, gen_vvv, gen_helper_vftintrz_w_d)
-TRANS(vftintrp_w_d, LSX, gen_vvv, gen_helper_vftintrp_w_d)
-TRANS(vftintrm_w_d, LSX, gen_vvv, gen_helper_vftintrm_w_d)
-TRANS(vftint_w_d, LSX, gen_vvv, gen_helper_vftint_w_d)
+TRANS(vftintrne_w_d, LSX, gen_vvv_ptr, gen_helper_vftintrne_w_d)
+TRANS(vftintrz_w_d, LSX, gen_vvv_ptr, gen_helper_vftintrz_w_d)
+TRANS(vftintrp_w_d, LSX, gen_vvv_ptr, gen_helper_vftintrp_w_d)
+TRANS(vftintrm_w_d, LSX, gen_vvv_ptr, gen_helper_vftintrm_w_d)
+TRANS(vftint_w_d, LSX, gen_vvv_ptr, gen_helper_vftint_w_d)
 TRANS(vftintrnel_l_s, LSX, gen_vv, gen_helper_vftintrnel_l_s)
 TRANS(vftintrneh_l_s, LSX, gen_vv, gen_helper_vftintrneh_l_s)
 TRANS(vftintrzl_l_s, LSX, gen_vv, gen_helper_vftintrzl_l_s)
@@ -3743,7 +3761,7 @@ TRANS(vffint_s_wu, LSX, gen_vv, gen_helper_vffint_s_wu)
 TRANS(vffint_d_lu, LSX, gen_vv, gen_helper_vffint_d_lu)
 TRANS(vffintl_d_w, LSX, gen_vv, gen_helper_vffintl_d_w)
 TRANS(vffinth_d_w, LSX, gen_vv, gen_helper_vffinth_d_w)
-TRANS(vffint_s_l, LSX, gen_vvv, gen_helper_vffint_s_l)
+TRANS(vffint_s_l, LSX, gen_vvv_ptr, gen_helper_vffint_s_l)
 
 static bool do_cmp(DisasContext *ctx, arg_vvv *a, MemOp mop, TCGCond cond)
 {
-- 
2.39.1


