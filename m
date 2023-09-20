Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A21587A733D
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 08:54:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qir47-0007ji-C3; Wed, 20 Sep 2023 02:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qir42-0007hf-NQ
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 02:51:58 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qir3y-00040Z-LY
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 02:51:58 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxruuFlgplgi8qAA--.12832S3;
 Wed, 20 Sep 2023 14:51:49 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dxzdx7lgplhVYMAA--.24315S10; 
 Wed, 20 Sep 2023 14:51:48 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/57] target/loongarch: Use gen_helper_gvec_2 for 2OP vector
 instructions
Date: Wed, 20 Sep 2023 14:50:50 +0800
Message-Id: <20230920065139.1403868-9-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230920065139.1403868-1-gaosong@loongson.cn>
References: <20230920065139.1403868-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxzdx7lgplhVYMAA--.24315S10
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
Message-Id: <20230914022645.1151356-9-gaosong@loongson.cn>
---
 target/loongarch/helper.h                   |  58 ++++-----
 target/loongarch/vec_helper.c               | 124 ++++++++++----------
 target/loongarch/insn_trans/trans_vec.c.inc |  16 ++-
 3 files changed, 101 insertions(+), 97 deletions(-)

diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 0752cc7212..523591035d 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -331,37 +331,37 @@ DEF_HELPER_FLAGS_4(vsat_hu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(vsat_wu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(vsat_du, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 
-DEF_HELPER_3(vexth_h_b, void, env, i32, i32)
-DEF_HELPER_3(vexth_w_h, void, env, i32, i32)
-DEF_HELPER_3(vexth_d_w, void, env, i32, i32)
-DEF_HELPER_3(vexth_q_d, void, env, i32, i32)
-DEF_HELPER_3(vexth_hu_bu, void, env, i32, i32)
-DEF_HELPER_3(vexth_wu_hu, void, env, i32, i32)
-DEF_HELPER_3(vexth_du_wu, void, env, i32, i32)
-DEF_HELPER_3(vexth_qu_du, void, env, i32, i32)
+DEF_HELPER_FLAGS_3(vexth_h_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vexth_w_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vexth_d_w, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vexth_q_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vexth_hu_bu, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vexth_wu_hu, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vexth_du_wu, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vexth_qu_du, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(vsigncov_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vsigncov_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vsigncov_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vsigncov_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
-DEF_HELPER_3(vmskltz_b, void, env, i32, i32)
-DEF_HELPER_3(vmskltz_h, void, env, i32, i32)
-DEF_HELPER_3(vmskltz_w, void, env, i32, i32)
-DEF_HELPER_3(vmskltz_d, void, env, i32, i32)
-DEF_HELPER_3(vmskgez_b, void, env, i32, i32)
-DEF_HELPER_3(vmsknz_b, void, env, i32,i32)
+DEF_HELPER_FLAGS_3(vmskltz_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vmskltz_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vmskltz_w, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vmskltz_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vmskgez_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vmsknz_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(vnori_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 
 DEF_HELPER_4(vsllwil_h_b, void, env, i32, i32, i32)
 DEF_HELPER_4(vsllwil_w_h, void, env, i32, i32, i32)
 DEF_HELPER_4(vsllwil_d_w, void, env, i32, i32, i32)
-DEF_HELPER_3(vextl_q_d, void, env, i32, i32)
+DEF_HELPER_FLAGS_3(vextl_q_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_4(vsllwil_hu_bu, void, env, i32, i32, i32)
 DEF_HELPER_4(vsllwil_wu_hu, void, env, i32, i32, i32)
 DEF_HELPER_4(vsllwil_du_wu, void, env, i32, i32, i32)
-DEF_HELPER_3(vextl_qu_du, void, env, i32, i32)
+DEF_HELPER_FLAGS_3(vextl_qu_du, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(vsrlr_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vsrlr_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
@@ -473,19 +473,19 @@ DEF_HELPER_4(vssrarni_hu_w, void, env, i32, i32, i32)
 DEF_HELPER_4(vssrarni_wu_d, void, env, i32, i32, i32)
 DEF_HELPER_4(vssrarni_du_q, void, env, i32, i32, i32)
 
-DEF_HELPER_3(vclo_b, void, env, i32, i32)
-DEF_HELPER_3(vclo_h, void, env, i32, i32)
-DEF_HELPER_3(vclo_w, void, env, i32, i32)
-DEF_HELPER_3(vclo_d, void, env, i32, i32)
-DEF_HELPER_3(vclz_b, void, env, i32, i32)
-DEF_HELPER_3(vclz_h, void, env, i32, i32)
-DEF_HELPER_3(vclz_w, void, env, i32, i32)
-DEF_HELPER_3(vclz_d, void, env, i32, i32)
-
-DEF_HELPER_3(vpcnt_b, void, env, i32, i32)
-DEF_HELPER_3(vpcnt_h, void, env, i32, i32)
-DEF_HELPER_3(vpcnt_w, void, env, i32, i32)
-DEF_HELPER_3(vpcnt_d, void, env, i32, i32)
+DEF_HELPER_FLAGS_3(vclo_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vclo_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vclo_w, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vclo_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vclz_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vclz_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vclz_w, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vclz_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(vpcnt_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vpcnt_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vpcnt_w, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vpcnt_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(vbitclr_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vbitclr_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 2898ae06ce..fd38b47c28 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -625,30 +625,30 @@ VSAT_U(vsat_hu, 16, UH)
 VSAT_U(vsat_wu, 32, UW)
 VSAT_U(vsat_du, 64, UD)
 
-#define VEXTH(NAME, BIT, E1, E2)                                    \
-void HELPER(NAME)(CPULoongArchState *env, uint32_t vd, uint32_t vj) \
-{                                                                   \
-    int i;                                                          \
-    VReg *Vd = &(env->fpr[vd].vreg);                                \
-    VReg *Vj = &(env->fpr[vj].vreg);                                \
-                                                                    \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                             \
-        Vd->E1(i) = Vj->E2(i + LSX_LEN/BIT);                        \
-    }                                                               \
+#define VEXTH(NAME, BIT, E1, E2)                     \
+void HELPER(NAME)(void *vd, void *vj, uint32_t desc) \
+{                                                    \
+    int i;                                           \
+    VReg *Vd = (VReg *)vd;                           \
+    VReg *Vj = (VReg *)vj;                           \
+                                                     \
+    for (i = 0; i < LSX_LEN/BIT; i++) {              \
+        Vd->E1(i) = Vj->E2(i + LSX_LEN/BIT);         \
+    }                                                \
 }
 
-void HELPER(vexth_q_d)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vexth_q_d)(void *vd, void *vj, uint32_t desc)
 {
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     Vd->Q(0) = int128_makes64(Vj->D(1));
 }
 
-void HELPER(vexth_qu_du)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vexth_qu_du)(void *vd, void *vj, uint32_t desc)
 {
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     Vd->Q(0) = int128_make64((uint64_t)Vj->D(1));
 }
@@ -677,11 +677,11 @@ static uint64_t do_vmskltz_b(int64_t val)
     return c >> 56;
 }
 
-void HELPER(vmskltz_b)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vmskltz_b)(void *vd, void *vj, uint32_t desc)
 {
     uint16_t temp = 0;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     temp = do_vmskltz_b(Vj->D(0));
     temp |= (do_vmskltz_b(Vj->D(1)) << 8);
@@ -698,11 +698,11 @@ static uint64_t do_vmskltz_h(int64_t val)
     return c >> 60;
 }
 
-void HELPER(vmskltz_h)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vmskltz_h)(void *vd, void *vj, uint32_t desc)
 {
     uint16_t temp = 0;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     temp = do_vmskltz_h(Vj->D(0));
     temp |= (do_vmskltz_h(Vj->D(1)) << 4);
@@ -718,11 +718,11 @@ static uint64_t do_vmskltz_w(int64_t val)
     return c >> 62;
 }
 
-void HELPER(vmskltz_w)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vmskltz_w)(void *vd, void *vj, uint32_t desc)
 {
     uint16_t temp = 0;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     temp = do_vmskltz_w(Vj->D(0));
     temp |= (do_vmskltz_w(Vj->D(1)) << 2);
@@ -734,11 +734,11 @@ static uint64_t do_vmskltz_d(int64_t val)
 {
     return (uint64_t)val >> 63;
 }
-void HELPER(vmskltz_d)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vmskltz_d)(void *vd, void *vj, uint32_t desc)
 {
     uint16_t temp = 0;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     temp = do_vmskltz_d(Vj->D(0));
     temp |= (do_vmskltz_d(Vj->D(1)) << 1);
@@ -746,11 +746,11 @@ void HELPER(vmskltz_d)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
     Vd->D(1) = 0;
 }
 
-void HELPER(vmskgez_b)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vmskgez_b)(void *vd, void *vj, uint32_t desc)
 {
     uint16_t temp = 0;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     temp =  do_vmskltz_b(Vj->D(0));
     temp |= (do_vmskltz_b(Vj->D(1)) << 8);
@@ -768,11 +768,11 @@ static uint64_t do_vmskez_b(uint64_t a)
     return c >> 56;
 }
 
-void HELPER(vmsknz_b)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vmsknz_b)(void *vd, void *vj, uint32_t desc)
 {
     uint16_t temp = 0;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     temp = do_vmskez_b(Vj->D(0));
     temp |= (do_vmskez_b(Vj->D(1)) << 8);
@@ -809,18 +809,18 @@ void HELPER(NAME)(CPULoongArchState *env,                 \
     *Vd = temp;                                           \
 }
 
-void HELPER(vextl_q_d)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vextl_q_d)(void *vd, void *vj, uint32_t desc)
 {
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     Vd->Q(0) = int128_makes64(Vj->D(0));
 }
 
-void HELPER(vextl_qu_du)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vextl_qu_du)(void *vd, void *vj, uint32_t desc)
 {
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     Vd->Q(0) = int128_make64(Vj->D(0));
 }
@@ -1899,17 +1899,17 @@ VSSRARNUI(vssrarni_bu_h, 16, B, H)
 VSSRARNUI(vssrarni_hu_w, 32, H, W)
 VSSRARNUI(vssrarni_wu_d, 64, W, D)
 
-#define DO_2OP(NAME, BIT, E, DO_OP)                                 \
-void HELPER(NAME)(CPULoongArchState *env, uint32_t vd, uint32_t vj) \
-{                                                                   \
-    int i;                                                          \
-    VReg *Vd = &(env->fpr[vd].vreg);                                \
-    VReg *Vj = &(env->fpr[vj].vreg);                                \
-                                                                    \
-    for (i = 0; i < LSX_LEN/BIT; i++)                               \
-    {                                                               \
-        Vd->E(i) = DO_OP(Vj->E(i));                                 \
-    }                                                               \
+#define DO_2OP(NAME, BIT, E, DO_OP)                  \
+void HELPER(NAME)(void *vd, void *vj, uint32_t desc) \
+{                                                    \
+    int i;                                           \
+    VReg *Vd = (VReg *)vd;                           \
+    VReg *Vj = (VReg *)vj;                           \
+                                                     \
+    for (i = 0; i < LSX_LEN/BIT; i++)                \
+    {                                                \
+        Vd->E(i) = DO_OP(Vj->E(i));                  \
+    }                                                \
 }
 
 #define DO_CLO_B(N)  (clz32(~N & 0xff) - 24)
@@ -1930,17 +1930,17 @@ DO_2OP(vclz_h, 16, UH, DO_CLZ_H)
 DO_2OP(vclz_w, 32, UW, DO_CLZ_W)
 DO_2OP(vclz_d, 64, UD, DO_CLZ_D)
 
-#define VPCNT(NAME, BIT, E, FN)                                     \
-void HELPER(NAME)(CPULoongArchState *env, uint32_t vd, uint32_t vj) \
-{                                                                   \
-    int i;                                                          \
-    VReg *Vd = &(env->fpr[vd].vreg);                                \
-    VReg *Vj = &(env->fpr[vj].vreg);                                \
-                                                                    \
-    for (i = 0; i < LSX_LEN/BIT; i++)                               \
-    {                                                               \
-        Vd->E(i) = FN(Vj->E(i));                                    \
-    }                                                               \
+#define VPCNT(NAME, BIT, E, FN)                      \
+void HELPER(NAME)(void *vd, void *vj, uint32_t desc) \
+{                                                    \
+    int i;                                           \
+    VReg *Vd = (VReg *)vd;                           \
+    VReg *Vj = (VReg *)vj;                           \
+                                                     \
+    for (i = 0; i < LSX_LEN/BIT; i++)                \
+    {                                                \
+        Vd->E(i) = FN(Vj->E(i));                     \
+    }                                                \
 }
 
 VPCNT(vpcnt_b, 8, UB, ctpop8)
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 06aa037e3b..e78c6bba0a 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -103,15 +103,19 @@ static bool gen_vv_ptr(DisasContext *ctx, arg_vv *a,
     return gen_vv_ptr_vl(ctx, a, 16, fn);
 }
 
-static bool gen_vv(DisasContext *ctx, arg_vv *a,
-                   void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32))
+static bool gen_vv_vl(DisasContext *ctx, arg_vv *a, uint32_t oprsz,
+                      gen_helper_gvec_2 *fn)
 {
-    TCGv_i32 vd = tcg_constant_i32(a->vd);
-    TCGv_i32 vj = tcg_constant_i32(a->vj);
+    tcg_gen_gvec_2_ool(vec_full_offset(a->vd),
+                       vec_full_offset(a->vj),
+                       oprsz, ctx->vl / 8, 0, fn);
+    return true;
+}
 
+static bool gen_vv(DisasContext *ctx, arg_vv *a, gen_helper_gvec_2 *fn)
+{
     CHECK_SXE;
-    func(cpu_env, vd, vj);
-    return true;
+    return gen_vv_vl(ctx, a, 16, fn);
 }
 
 static bool gen_vv_i(DisasContext *ctx, arg_vv_i *a,
-- 
2.39.1


