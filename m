Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 520817A732F
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 08:53:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qir45-0007iz-VA; Wed, 20 Sep 2023 02:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qir43-0007hq-5I
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 02:51:59 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qir3x-00040J-M0
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 02:51:58 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxyOiElgplgC8qAA--.45366S3;
 Wed, 20 Sep 2023 14:51:48 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dxzdx7lgplhVYMAA--.24315S9; 
 Wed, 20 Sep 2023 14:51:47 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/57] target/loongarch: Use gen_helper_gvec_2_ptr for 2OP +
 env vector instructions
Date: Wed, 20 Sep 2023 14:50:49 +0800
Message-Id: <20230920065139.1403868-8-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230920065139.1403868-1-gaosong@loongson.cn>
References: <20230920065139.1403868-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxzdx7lgplhVYMAA--.24315S9
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
Message-Id: <20230914022645.1151356-8-gaosong@loongson.cn>
---
 target/loongarch/helper.h                   | 118 +++++++-------
 target/loongarch/vec_helper.c               | 161 +++++++++++---------
 target/loongarch/insn_trans/trans_vec.c.inc | 129 +++++++++-------
 3 files changed, 219 insertions(+), 189 deletions(-)

diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 4b681e948f..0752cc7212 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -547,73 +547,73 @@ DEF_HELPER_FLAGS_5(vfmaxa_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(vfmina_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(vfmina_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 
-DEF_HELPER_3(vflogb_s, void, env, i32, i32)
-DEF_HELPER_3(vflogb_d, void, env, i32, i32)
-
-DEF_HELPER_3(vfclass_s, void, env, i32, i32)
-DEF_HELPER_3(vfclass_d, void, env, i32, i32)
-
-DEF_HELPER_3(vfsqrt_s, void, env, i32, i32)
-DEF_HELPER_3(vfsqrt_d, void, env, i32, i32)
-DEF_HELPER_3(vfrecip_s, void, env, i32, i32)
-DEF_HELPER_3(vfrecip_d, void, env, i32, i32)
-DEF_HELPER_3(vfrsqrt_s, void, env, i32, i32)
-DEF_HELPER_3(vfrsqrt_d, void, env, i32, i32)
-
-DEF_HELPER_3(vfcvtl_s_h, void, env, i32, i32)
-DEF_HELPER_3(vfcvth_s_h, void, env, i32, i32)
-DEF_HELPER_3(vfcvtl_d_s, void, env, i32, i32)
-DEF_HELPER_3(vfcvth_d_s, void, env, i32, i32)
+DEF_HELPER_FLAGS_4(vflogb_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vflogb_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(vfclass_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfclass_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(vfsqrt_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfsqrt_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfrecip_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfrecip_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfrsqrt_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfrsqrt_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(vfcvtl_s_h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfcvth_s_h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfcvtl_d_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfcvth_d_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(vfcvt_h_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(vfcvt_s_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 
-DEF_HELPER_3(vfrintrne_s, void, env, i32, i32)
-DEF_HELPER_3(vfrintrne_d, void, env, i32, i32)
-DEF_HELPER_3(vfrintrz_s, void, env, i32, i32)
-DEF_HELPER_3(vfrintrz_d, void, env, i32, i32)
-DEF_HELPER_3(vfrintrp_s, void, env, i32, i32)
-DEF_HELPER_3(vfrintrp_d, void, env, i32, i32)
-DEF_HELPER_3(vfrintrm_s, void, env, i32, i32)
-DEF_HELPER_3(vfrintrm_d, void, env, i32, i32)
-DEF_HELPER_3(vfrint_s, void, env, i32, i32)
-DEF_HELPER_3(vfrint_d, void, env, i32, i32)
-
-DEF_HELPER_3(vftintrne_w_s, void, env, i32, i32)
-DEF_HELPER_3(vftintrne_l_d, void, env, i32, i32)
-DEF_HELPER_3(vftintrz_w_s, void, env, i32, i32)
-DEF_HELPER_3(vftintrz_l_d, void, env, i32, i32)
-DEF_HELPER_3(vftintrp_w_s, void, env, i32, i32)
-DEF_HELPER_3(vftintrp_l_d, void, env, i32, i32)
-DEF_HELPER_3(vftintrm_w_s, void, env, i32, i32)
-DEF_HELPER_3(vftintrm_l_d, void, env, i32, i32)
-DEF_HELPER_3(vftint_w_s, void, env, i32, i32)
-DEF_HELPER_3(vftint_l_d, void, env, i32, i32)
-DEF_HELPER_3(vftintrz_wu_s, void, env, i32, i32)
-DEF_HELPER_3(vftintrz_lu_d, void, env, i32, i32)
-DEF_HELPER_3(vftint_wu_s, void, env, i32, i32)
-DEF_HELPER_3(vftint_lu_d, void, env, i32, i32)
+DEF_HELPER_FLAGS_4(vfrintrne_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfrintrne_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfrintrz_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfrintrz_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfrintrp_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfrintrp_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfrintrm_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfrintrm_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfrint_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfrint_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(vftintrne_w_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrne_l_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrz_w_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrz_l_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrp_w_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrp_l_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrm_w_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrm_l_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftint_w_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftint_l_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrz_wu_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrz_lu_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftint_wu_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftint_lu_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(vftintrne_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(vftintrz_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(vftintrp_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(vftintrm_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(vftint_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_3(vftintrnel_l_s, void, env, i32, i32)
-DEF_HELPER_3(vftintrneh_l_s, void, env, i32, i32)
-DEF_HELPER_3(vftintrzl_l_s, void, env, i32, i32)
-DEF_HELPER_3(vftintrzh_l_s, void, env, i32, i32)
-DEF_HELPER_3(vftintrpl_l_s, void, env, i32, i32)
-DEF_HELPER_3(vftintrph_l_s, void, env, i32, i32)
-DEF_HELPER_3(vftintrml_l_s, void, env, i32, i32)
-DEF_HELPER_3(vftintrmh_l_s, void, env, i32, i32)
-DEF_HELPER_3(vftintl_l_s, void, env, i32, i32)
-DEF_HELPER_3(vftinth_l_s, void, env, i32, i32)
-
-DEF_HELPER_3(vffint_s_w, void, env, i32, i32)
-DEF_HELPER_3(vffint_d_l, void, env, i32, i32)
-DEF_HELPER_3(vffint_s_wu, void, env, i32, i32)
-DEF_HELPER_3(vffint_d_lu, void, env, i32, i32)
-DEF_HELPER_3(vffintl_d_w, void, env, i32, i32)
-DEF_HELPER_3(vffinth_d_w, void, env, i32, i32)
+DEF_HELPER_FLAGS_4(vftintrnel_l_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrneh_l_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrzl_l_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrzh_l_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrpl_l_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrph_l_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrml_l_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrmh_l_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintl_l_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftinth_l_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(vffint_s_w, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vffint_d_l, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vffint_s_wu, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vffint_d_lu, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vffintl_d_w, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vffinth_d_w, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(vffint_s_l, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_4(vseqi_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 15b361c6b3..2898ae06ce 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -2135,17 +2135,18 @@ DO_4OP_F(vfnmsub_s, 32, UW, float32_muladd,
 DO_4OP_F(vfnmsub_d, 64, UD, float64_muladd,
          float_muladd_negate_c | float_muladd_negate_result)
 
-#define DO_2OP_F(NAME, BIT, E, FN)                                  \
-void HELPER(NAME)(CPULoongArchState *env, uint32_t vd, uint32_t vj) \
-{                                                                   \
-    int i;                                                          \
-    VReg *Vd = &(env->fpr[vd].vreg);                                \
-    VReg *Vj = &(env->fpr[vj].vreg);                                \
-                                                                    \
-    vec_clear_cause(env);                                           \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                             \
-        Vd->E(i) = FN(env, Vj->E(i));                               \
-    }                                                               \
+#define DO_2OP_F(NAME, BIT, E, FN)                       \
+void HELPER(NAME)(void *vd, void *vj,                    \
+                  CPULoongArchState *env, uint32_t desc) \
+{                                                        \
+    int i;                                               \
+    VReg *Vd = (VReg *)vd;                               \
+    VReg *Vj = (VReg *)vj;                               \
+                                                         \
+    vec_clear_cause(env);                                \
+    for (i = 0; i < LSX_LEN/BIT; i++) {                  \
+        Vd->E(i) = FN(env, Vj->E(i));                    \
+    }                                                    \
 }
 
 #define FLOGB(BIT, T)                                            \
@@ -2166,16 +2167,17 @@ static T do_flogb_## BIT(CPULoongArchState *env, T fj)           \
 FLOGB(32, uint32_t)
 FLOGB(64, uint64_t)
 
-#define FCLASS(NAME, BIT, E, FN)                                    \
-void HELPER(NAME)(CPULoongArchState *env, uint32_t vd, uint32_t vj) \
-{                                                                   \
-    int i;                                                          \
-    VReg *Vd = &(env->fpr[vd].vreg);                                \
-    VReg *Vj = &(env->fpr[vj].vreg);                                \
-                                                                    \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                             \
-        Vd->E(i) = FN(env, Vj->E(i));                               \
-    }                                                               \
+#define FCLASS(NAME, BIT, E, FN)                         \
+void HELPER(NAME)(void *vd, void *vj,                    \
+                  CPULoongArchState *env, uint32_t desc) \
+{                                                        \
+    int i;                                               \
+    VReg *Vd = (VReg *)vd;                               \
+    VReg *Vj = (VReg *)vj;                               \
+                                                         \
+    for (i = 0; i < LSX_LEN/BIT; i++) {                  \
+        Vd->E(i) = FN(env, Vj->E(i));                    \
+    }                                                    \
 }
 
 FCLASS(vfclass_s, 32, UW, helper_fclass_s)
@@ -2245,12 +2247,13 @@ static uint32_t float64_cvt_float32(uint64_t d, float_status *status)
     return float64_to_float32(d, status);
 }
 
-void HELPER(vfcvtl_s_h)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vfcvtl_s_h)(void *vd, void *vj,
+                        CPULoongArchState *env, uint32_t desc)
 {
     int i;
     VReg temp;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     vec_clear_cause(env);
     for (i = 0; i < LSX_LEN/32; i++) {
@@ -2260,12 +2263,13 @@ void HELPER(vfcvtl_s_h)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
     *Vd = temp;
 }
 
-void HELPER(vfcvtl_d_s)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vfcvtl_d_s)(void *vd, void *vj,
+                        CPULoongArchState *env, uint32_t desc)
 {
     int i;
     VReg temp;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     vec_clear_cause(env);
     for (i = 0; i < LSX_LEN/64; i++) {
@@ -2275,12 +2279,13 @@ void HELPER(vfcvtl_d_s)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
     *Vd = temp;
 }
 
-void HELPER(vfcvth_s_h)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vfcvth_s_h)(void *vd, void *vj,
+                        CPULoongArchState *env, uint32_t desc)
 {
     int i;
     VReg temp;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     vec_clear_cause(env);
     for (i = 0; i < LSX_LEN/32; i++) {
@@ -2290,12 +2295,13 @@ void HELPER(vfcvth_s_h)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
     *Vd = temp;
 }
 
-void HELPER(vfcvth_d_s)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vfcvth_d_s)(void *vd, void *vj,
+                        CPULoongArchState *env, uint32_t desc)
 {
     int i;
     VReg temp;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     vec_clear_cause(env);
     for (i = 0; i < LSX_LEN/64; i++) {
@@ -2341,11 +2347,12 @@ void HELPER(vfcvt_s_d)(void *vd, void *vj, void *vk,
     *Vd = temp;
 }
 
-void HELPER(vfrint_s)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vfrint_s)(void *vd, void *vj,
+                      CPULoongArchState *env, uint32_t desc)
 {
     int i;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     vec_clear_cause(env);
     for (i = 0; i < 4; i++) {
@@ -2354,11 +2361,12 @@ void HELPER(vfrint_s)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
     }
 }
 
-void HELPER(vfrint_d)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vfrint_d)(void *vd, void *vj,
+                      CPULoongArchState *env, uint32_t desc)
 {
     int i;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     vec_clear_cause(env);
     for (i = 0; i < 2; i++) {
@@ -2368,11 +2376,12 @@ void HELPER(vfrint_d)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
 }
 
 #define FCVT_2OP(NAME, BIT, E, MODE)                                        \
-void HELPER(NAME)(CPULoongArchState *env, uint32_t vd, uint32_t vj)         \
+void HELPER(NAME)(void *vd, void *vj,                                       \
+                  CPULoongArchState *env, uint32_t desc)                    \
 {                                                                           \
     int i;                                                                  \
-    VReg *Vd = &(env->fpr[vd].vreg);                                        \
-    VReg *Vj = &(env->fpr[vj].vreg);                                        \
+    VReg *Vd = (VReg *)vd;                                                  \
+    VReg *Vj = (VReg *)vj;                                                  \
                                                                             \
     vec_clear_cause(env);                                                   \
     for (i = 0; i < LSX_LEN/BIT; i++) {                                     \
@@ -2493,19 +2502,20 @@ FTINT(rph_l_s, float32, int64, uint32_t, uint64_t, float_round_up)
 FTINT(rzh_l_s, float32, int64, uint32_t, uint64_t, float_round_to_zero)
 FTINT(rneh_l_s, float32, int64, uint32_t, uint64_t, float_round_nearest_even)
 
-#define FTINTL_L_S(NAME, FN)                                        \
-void HELPER(NAME)(CPULoongArchState *env, uint32_t vd, uint32_t vj) \
-{                                                                   \
-    int i;                                                          \
-    VReg temp;                                                      \
-    VReg *Vd = &(env->fpr[vd].vreg);                                \
-    VReg *Vj = &(env->fpr[vj].vreg);                                \
-                                                                    \
-    vec_clear_cause(env);                                           \
-    for (i = 0; i < 2; i++) {                                       \
-        temp.D(i) = FN(env, Vj->UW(i));                             \
-    }                                                               \
-    *Vd = temp;                                                     \
+#define FTINTL_L_S(NAME, FN)                             \
+void HELPER(NAME)(void *vd, void *vj,                    \
+                  CPULoongArchState *env, uint32_t desc) \
+{                                                        \
+    int i;                                               \
+    VReg temp;                                           \
+    VReg *Vd = (VReg *)vd;                               \
+    VReg *Vj = (VReg *)vj;                               \
+                                                         \
+    vec_clear_cause(env);                                \
+    for (i = 0; i < 2; i++) {                            \
+        temp.D(i) = FN(env, Vj->UW(i));                  \
+    }                                                    \
+    *Vd = temp;                                          \
 }
 
 FTINTL_L_S(vftintl_l_s, do_float32_to_int64)
@@ -2514,19 +2524,20 @@ FTINTL_L_S(vftintrpl_l_s, do_ftintrpl_l_s)
 FTINTL_L_S(vftintrzl_l_s, do_ftintrzl_l_s)
 FTINTL_L_S(vftintrnel_l_s, do_ftintrnel_l_s)
 
-#define FTINTH_L_S(NAME, FN)                                        \
-void HELPER(NAME)(CPULoongArchState *env, uint32_t vd, uint32_t vj) \
-{                                                                   \
-    int i;                                                          \
-    VReg temp;                                                      \
-    VReg *Vd = &(env->fpr[vd].vreg);                                \
-    VReg *Vj = &(env->fpr[vj].vreg);                                \
-                                                                    \
-    vec_clear_cause(env);                                           \
-    for (i = 0; i < 2; i++) {                                       \
-        temp.D(i) = FN(env, Vj->UW(i + 2));                         \
-    }                                                               \
-    *Vd = temp;                                                     \
+#define FTINTH_L_S(NAME, FN)                             \
+void HELPER(NAME)(void *vd, void *vj,                    \
+                  CPULoongArchState *env, uint32_t desc) \
+{                                                        \
+    int i;                                               \
+    VReg temp;                                           \
+    VReg *Vd = (VReg *)vd;                               \
+    VReg *Vj = (VReg *)vj;                               \
+                                                         \
+    vec_clear_cause(env);                                \
+    for (i = 0; i < 2; i++) {                            \
+        temp.D(i) = FN(env, Vj->UW(i + 2));              \
+    }                                                    \
+    *Vd = temp;                                          \
 }
 
 FTINTH_L_S(vftinth_l_s, do_float32_to_int64)
@@ -2555,12 +2566,13 @@ DO_2OP_F(vffint_d_l, 64, D, do_ffint_d_l)
 DO_2OP_F(vffint_s_wu, 32, UW, do_ffint_s_wu)
 DO_2OP_F(vffint_d_lu, 64, UD, do_ffint_d_lu)
 
-void HELPER(vffintl_d_w)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vffintl_d_w)(void *vd, void *vj,
+                         CPULoongArchState *env, uint32_t desc)
 {
     int i;
     VReg temp;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     vec_clear_cause(env);
     for (i = 0; i < 2; i++) {
@@ -2570,12 +2582,13 @@ void HELPER(vffintl_d_w)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
     *Vd = temp;
 }
 
-void HELPER(vffinth_d_w)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vffinth_d_w)(void *vd, void *vj,
+                         CPULoongArchState *env, uint32_t desc)
 {
     int i;
     VReg temp;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     vec_clear_cause(env);
     for (i = 0; i < 2; i++) {
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 9f67774fc9..06aa037e3b 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -86,6 +86,23 @@ static bool gen_vvv(DisasContext *ctx, arg_vvv *a, gen_helper_gvec_3 *fn)
     return gen_vvv_vl(ctx, a, 16, fn);
 }
 
+static bool gen_vv_ptr_vl(DisasContext *ctx, arg_vv *a, uint32_t oprsz,
+                          gen_helper_gvec_2_ptr *fn)
+{
+    tcg_gen_gvec_2_ptr(vec_full_offset(a->vd),
+                       vec_full_offset(a->vj),
+                       cpu_env,
+                       oprsz, ctx->vl / 8, 0, fn);
+    return true;
+}
+
+static bool gen_vv_ptr(DisasContext *ctx, arg_vv *a,
+                       gen_helper_gvec_2_ptr *fn)
+{
+    CHECK_SXE;
+    return gen_vv_ptr_vl(ctx, a, 16, fn);
+}
+
 static bool gen_vv(DisasContext *ctx, arg_vv *a,
                    void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32))
 {
@@ -3697,73 +3714,73 @@ TRANS(vfmaxa_d, LSX, gen_vvv_ptr, gen_helper_vfmaxa_d)
 TRANS(vfmina_s, LSX, gen_vvv_ptr, gen_helper_vfmina_s)
 TRANS(vfmina_d, LSX, gen_vvv_ptr, gen_helper_vfmina_d)
 
-TRANS(vflogb_s, LSX, gen_vv, gen_helper_vflogb_s)
-TRANS(vflogb_d, LSX, gen_vv, gen_helper_vflogb_d)
+TRANS(vflogb_s, LSX, gen_vv_ptr, gen_helper_vflogb_s)
+TRANS(vflogb_d, LSX, gen_vv_ptr, gen_helper_vflogb_d)
 
-TRANS(vfclass_s, LSX, gen_vv, gen_helper_vfclass_s)
-TRANS(vfclass_d, LSX, gen_vv, gen_helper_vfclass_d)
+TRANS(vfclass_s, LSX, gen_vv_ptr, gen_helper_vfclass_s)
+TRANS(vfclass_d, LSX, gen_vv_ptr, gen_helper_vfclass_d)
 
-TRANS(vfsqrt_s, LSX, gen_vv, gen_helper_vfsqrt_s)
-TRANS(vfsqrt_d, LSX, gen_vv, gen_helper_vfsqrt_d)
-TRANS(vfrecip_s, LSX, gen_vv, gen_helper_vfrecip_s)
-TRANS(vfrecip_d, LSX, gen_vv, gen_helper_vfrecip_d)
-TRANS(vfrsqrt_s, LSX, gen_vv, gen_helper_vfrsqrt_s)
-TRANS(vfrsqrt_d, LSX, gen_vv, gen_helper_vfrsqrt_d)
+TRANS(vfsqrt_s, LSX, gen_vv_ptr, gen_helper_vfsqrt_s)
+TRANS(vfsqrt_d, LSX, gen_vv_ptr, gen_helper_vfsqrt_d)
+TRANS(vfrecip_s, LSX, gen_vv_ptr, gen_helper_vfrecip_s)
+TRANS(vfrecip_d, LSX, gen_vv_ptr, gen_helper_vfrecip_d)
+TRANS(vfrsqrt_s, LSX, gen_vv_ptr, gen_helper_vfrsqrt_s)
+TRANS(vfrsqrt_d, LSX, gen_vv_ptr, gen_helper_vfrsqrt_d)
 
-TRANS(vfcvtl_s_h, LSX, gen_vv, gen_helper_vfcvtl_s_h)
-TRANS(vfcvth_s_h, LSX, gen_vv, gen_helper_vfcvth_s_h)
-TRANS(vfcvtl_d_s, LSX, gen_vv, gen_helper_vfcvtl_d_s)
-TRANS(vfcvth_d_s, LSX, gen_vv, gen_helper_vfcvth_d_s)
+TRANS(vfcvtl_s_h, LSX, gen_vv_ptr, gen_helper_vfcvtl_s_h)
+TRANS(vfcvth_s_h, LSX, gen_vv_ptr, gen_helper_vfcvth_s_h)
+TRANS(vfcvtl_d_s, LSX, gen_vv_ptr, gen_helper_vfcvtl_d_s)
+TRANS(vfcvth_d_s, LSX, gen_vv_ptr, gen_helper_vfcvth_d_s)
 TRANS(vfcvt_h_s, LSX, gen_vvv_ptr, gen_helper_vfcvt_h_s)
 TRANS(vfcvt_s_d, LSX, gen_vvv_ptr, gen_helper_vfcvt_s_d)
 
-TRANS(vfrintrne_s, LSX, gen_vv, gen_helper_vfrintrne_s)
-TRANS(vfrintrne_d, LSX, gen_vv, gen_helper_vfrintrne_d)
-TRANS(vfrintrz_s, LSX, gen_vv, gen_helper_vfrintrz_s)
-TRANS(vfrintrz_d, LSX, gen_vv, gen_helper_vfrintrz_d)
-TRANS(vfrintrp_s, LSX, gen_vv, gen_helper_vfrintrp_s)
-TRANS(vfrintrp_d, LSX, gen_vv, gen_helper_vfrintrp_d)
-TRANS(vfrintrm_s, LSX, gen_vv, gen_helper_vfrintrm_s)
-TRANS(vfrintrm_d, LSX, gen_vv, gen_helper_vfrintrm_d)
-TRANS(vfrint_s, LSX, gen_vv, gen_helper_vfrint_s)
-TRANS(vfrint_d, LSX, gen_vv, gen_helper_vfrint_d)
-
-TRANS(vftintrne_w_s, LSX, gen_vv, gen_helper_vftintrne_w_s)
-TRANS(vftintrne_l_d, LSX, gen_vv, gen_helper_vftintrne_l_d)
-TRANS(vftintrz_w_s, LSX, gen_vv, gen_helper_vftintrz_w_s)
-TRANS(vftintrz_l_d, LSX, gen_vv, gen_helper_vftintrz_l_d)
-TRANS(vftintrp_w_s, LSX, gen_vv, gen_helper_vftintrp_w_s)
-TRANS(vftintrp_l_d, LSX, gen_vv, gen_helper_vftintrp_l_d)
-TRANS(vftintrm_w_s, LSX, gen_vv, gen_helper_vftintrm_w_s)
-TRANS(vftintrm_l_d, LSX, gen_vv, gen_helper_vftintrm_l_d)
-TRANS(vftint_w_s, LSX, gen_vv, gen_helper_vftint_w_s)
-TRANS(vftint_l_d, LSX, gen_vv, gen_helper_vftint_l_d)
-TRANS(vftintrz_wu_s, LSX, gen_vv, gen_helper_vftintrz_wu_s)
-TRANS(vftintrz_lu_d, LSX, gen_vv, gen_helper_vftintrz_lu_d)
-TRANS(vftint_wu_s, LSX, gen_vv, gen_helper_vftint_wu_s)
-TRANS(vftint_lu_d, LSX, gen_vv, gen_helper_vftint_lu_d)
+TRANS(vfrintrne_s, LSX, gen_vv_ptr, gen_helper_vfrintrne_s)
+TRANS(vfrintrne_d, LSX, gen_vv_ptr, gen_helper_vfrintrne_d)
+TRANS(vfrintrz_s, LSX, gen_vv_ptr, gen_helper_vfrintrz_s)
+TRANS(vfrintrz_d, LSX, gen_vv_ptr, gen_helper_vfrintrz_d)
+TRANS(vfrintrp_s, LSX, gen_vv_ptr, gen_helper_vfrintrp_s)
+TRANS(vfrintrp_d, LSX, gen_vv_ptr, gen_helper_vfrintrp_d)
+TRANS(vfrintrm_s, LSX, gen_vv_ptr, gen_helper_vfrintrm_s)
+TRANS(vfrintrm_d, LSX, gen_vv_ptr, gen_helper_vfrintrm_d)
+TRANS(vfrint_s, LSX, gen_vv_ptr, gen_helper_vfrint_s)
+TRANS(vfrint_d, LSX, gen_vv_ptr, gen_helper_vfrint_d)
+
+TRANS(vftintrne_w_s, LSX, gen_vv_ptr, gen_helper_vftintrne_w_s)
+TRANS(vftintrne_l_d, LSX, gen_vv_ptr, gen_helper_vftintrne_l_d)
+TRANS(vftintrz_w_s, LSX, gen_vv_ptr, gen_helper_vftintrz_w_s)
+TRANS(vftintrz_l_d, LSX, gen_vv_ptr, gen_helper_vftintrz_l_d)
+TRANS(vftintrp_w_s, LSX, gen_vv_ptr, gen_helper_vftintrp_w_s)
+TRANS(vftintrp_l_d, LSX, gen_vv_ptr, gen_helper_vftintrp_l_d)
+TRANS(vftintrm_w_s, LSX, gen_vv_ptr, gen_helper_vftintrm_w_s)
+TRANS(vftintrm_l_d, LSX, gen_vv_ptr, gen_helper_vftintrm_l_d)
+TRANS(vftint_w_s, LSX, gen_vv_ptr, gen_helper_vftint_w_s)
+TRANS(vftint_l_d, LSX, gen_vv_ptr, gen_helper_vftint_l_d)
+TRANS(vftintrz_wu_s, LSX, gen_vv_ptr, gen_helper_vftintrz_wu_s)
+TRANS(vftintrz_lu_d, LSX, gen_vv_ptr, gen_helper_vftintrz_lu_d)
+TRANS(vftint_wu_s, LSX, gen_vv_ptr, gen_helper_vftint_wu_s)
+TRANS(vftint_lu_d, LSX, gen_vv_ptr, gen_helper_vftint_lu_d)
 TRANS(vftintrne_w_d, LSX, gen_vvv_ptr, gen_helper_vftintrne_w_d)
 TRANS(vftintrz_w_d, LSX, gen_vvv_ptr, gen_helper_vftintrz_w_d)
 TRANS(vftintrp_w_d, LSX, gen_vvv_ptr, gen_helper_vftintrp_w_d)
 TRANS(vftintrm_w_d, LSX, gen_vvv_ptr, gen_helper_vftintrm_w_d)
 TRANS(vftint_w_d, LSX, gen_vvv_ptr, gen_helper_vftint_w_d)
-TRANS(vftintrnel_l_s, LSX, gen_vv, gen_helper_vftintrnel_l_s)
-TRANS(vftintrneh_l_s, LSX, gen_vv, gen_helper_vftintrneh_l_s)
-TRANS(vftintrzl_l_s, LSX, gen_vv, gen_helper_vftintrzl_l_s)
-TRANS(vftintrzh_l_s, LSX, gen_vv, gen_helper_vftintrzh_l_s)
-TRANS(vftintrpl_l_s, LSX, gen_vv, gen_helper_vftintrpl_l_s)
-TRANS(vftintrph_l_s, LSX, gen_vv, gen_helper_vftintrph_l_s)
-TRANS(vftintrml_l_s, LSX, gen_vv, gen_helper_vftintrml_l_s)
-TRANS(vftintrmh_l_s, LSX, gen_vv, gen_helper_vftintrmh_l_s)
-TRANS(vftintl_l_s, LSX, gen_vv, gen_helper_vftintl_l_s)
-TRANS(vftinth_l_s, LSX, gen_vv, gen_helper_vftinth_l_s)
-
-TRANS(vffint_s_w, LSX, gen_vv, gen_helper_vffint_s_w)
-TRANS(vffint_d_l, LSX, gen_vv, gen_helper_vffint_d_l)
-TRANS(vffint_s_wu, LSX, gen_vv, gen_helper_vffint_s_wu)
-TRANS(vffint_d_lu, LSX, gen_vv, gen_helper_vffint_d_lu)
-TRANS(vffintl_d_w, LSX, gen_vv, gen_helper_vffintl_d_w)
-TRANS(vffinth_d_w, LSX, gen_vv, gen_helper_vffinth_d_w)
+TRANS(vftintrnel_l_s, LSX, gen_vv_ptr, gen_helper_vftintrnel_l_s)
+TRANS(vftintrneh_l_s, LSX, gen_vv_ptr, gen_helper_vftintrneh_l_s)
+TRANS(vftintrzl_l_s, LSX, gen_vv_ptr, gen_helper_vftintrzl_l_s)
+TRANS(vftintrzh_l_s, LSX, gen_vv_ptr, gen_helper_vftintrzh_l_s)
+TRANS(vftintrpl_l_s, LSX, gen_vv_ptr, gen_helper_vftintrpl_l_s)
+TRANS(vftintrph_l_s, LSX, gen_vv_ptr, gen_helper_vftintrph_l_s)
+TRANS(vftintrml_l_s, LSX, gen_vv_ptr, gen_helper_vftintrml_l_s)
+TRANS(vftintrmh_l_s, LSX, gen_vv_ptr, gen_helper_vftintrmh_l_s)
+TRANS(vftintl_l_s, LSX, gen_vv_ptr, gen_helper_vftintl_l_s)
+TRANS(vftinth_l_s, LSX, gen_vv_ptr, gen_helper_vftinth_l_s)
+
+TRANS(vffint_s_w, LSX, gen_vv_ptr, gen_helper_vffint_s_w)
+TRANS(vffint_d_l, LSX, gen_vv_ptr, gen_helper_vffint_d_l)
+TRANS(vffint_s_wu, LSX, gen_vv_ptr, gen_helper_vffint_s_wu)
+TRANS(vffint_d_lu, LSX, gen_vv_ptr, gen_helper_vffint_d_lu)
+TRANS(vffintl_d_w, LSX, gen_vv_ptr, gen_helper_vffintl_d_w)
+TRANS(vffinth_d_w, LSX, gen_vv_ptr, gen_helper_vffinth_d_w)
 TRANS(vffint_s_l, LSX, gen_vvv_ptr, gen_helper_vffint_s_l)
 
 static bool do_cmp(DisasContext *ctx, arg_vvv *a, MemOp mop, TCGCond cond)
-- 
2.39.1


