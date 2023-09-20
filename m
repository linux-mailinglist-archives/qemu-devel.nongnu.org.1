Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C3A7A7386
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 08:59:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qir47-0007jj-Iz; Wed, 20 Sep 2023 02:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qir43-0007hs-7R
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 02:51:59 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qir3y-0003zi-S1
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 02:51:58 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bx5fCBlgpleC8qAA--.15910S3;
 Wed, 20 Sep 2023 14:51:45 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dxzdx7lgplhVYMAA--.24315S5; 
 Wed, 20 Sep 2023 14:51:44 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/57] target/loongarch: Use gen_helper_gvec_4_ptr for 4OP +
 env vector instructions
Date: Wed, 20 Sep 2023 14:50:45 +0800
Message-Id: <20230920065139.1403868-4-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230920065139.1403868-1-gaosong@loongson.cn>
References: <20230920065139.1403868-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxzdx7lgplhVYMAA--.24315S5
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
Message-Id: <20230914022645.1151356-4-gaosong@loongson.cn>
---
 target/loongarch/helper.h                   | 16 +++++-----
 target/loongarch/vec_helper.c               | 12 +++----
 target/loongarch/insn_trans/trans_vec.c.inc | 35 ++++++++++++++++-----
 3 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index ffb1e0b0bf..ead16567c2 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -528,14 +528,14 @@ DEF_HELPER_4(vfmul_d, void, env, i32, i32, i32)
 DEF_HELPER_4(vfdiv_s, void, env, i32, i32, i32)
 DEF_HELPER_4(vfdiv_d, void, env, i32, i32, i32)
 
-DEF_HELPER_5(vfmadd_s, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(vfmadd_d, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(vfmsub_s, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(vfmsub_d, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(vfnmadd_s, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(vfnmadd_d, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(vfnmsub_s, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(vfnmsub_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_FLAGS_6(vfmadd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_6(vfmadd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_6(vfmsub_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_6(vfmsub_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_6(vfnmadd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_6(vfnmadd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_6(vfnmsub_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_6(vfnmsub_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_4(vfmax_s, void, env, i32, i32, i32)
 DEF_HELPER_4(vfmax_d, void, env, i32, i32, i32)
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 73f0974744..3a7a620227 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -2129,14 +2129,14 @@ DO_3OP_F(vfmina_s, 32, UW, float32_minnummag)
 DO_3OP_F(vfmina_d, 64, UD, float64_minnummag)
 
 #define DO_4OP_F(NAME, BIT, E, FN, flags)                                    \
-void HELPER(NAME)(CPULoongArchState *env,                                    \
-                  uint32_t vd, uint32_t vj, uint32_t vk, uint32_t va)        \
+void HELPER(NAME)(void *vd, void *vj, void *vk, void *va,                    \
+                  CPULoongArchState *env, uint32_t desc)                     \
 {                                                                            \
     int i;                                                                   \
-    VReg *Vd = &(env->fpr[vd].vreg);                                         \
-    VReg *Vj = &(env->fpr[vj].vreg);                                         \
-    VReg *Vk = &(env->fpr[vk].vreg);                                         \
-    VReg *Va = &(env->fpr[va].vreg);                                         \
+    VReg *Vd = (VReg *)vd;                                                   \
+    VReg *Vj = (VReg *)vj;                                                   \
+    VReg *Vk = (VReg *)vk;                                                   \
+    VReg *Va = (VReg *)va;                                                   \
                                                                              \
     vec_clear_cause(env);                                                    \
     for (i = 0; i < LSX_LEN/BIT; i++) {                                      \
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index aeeb2df41c..6a518523f0 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -15,6 +15,25 @@
 #define CHECK_SXE
 #endif
 
+static bool gen_vvvv_ptr_vl(DisasContext *ctx, arg_vvvv *a, uint32_t oprsz,
+                            gen_helper_gvec_4_ptr *fn)
+{
+    tcg_gen_gvec_4_ptr(vec_full_offset(a->vd),
+                       vec_full_offset(a->vj),
+                       vec_full_offset(a->vk),
+                       vec_full_offset(a->va),
+                       cpu_env,
+                       oprsz, ctx->vl / 8, 0, fn);
+    return true;
+}
+
+static bool gen_vvvv_ptr(DisasContext *ctx, arg_vvvv *a,
+                         gen_helper_gvec_4_ptr *fn)
+{
+    CHECK_SXE;
+    return gen_vvvv_ptr_vl(ctx, a, 16, fn);
+}
+
 static bool gen_vvvv(DisasContext *ctx, arg_vvvv *a,
                      void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32,
                                   TCGv_i32, TCGv_i32))
@@ -3634,14 +3653,14 @@ TRANS(vfmul_d, LSX, gen_vvv, gen_helper_vfmul_d)
 TRANS(vfdiv_s, LSX, gen_vvv, gen_helper_vfdiv_s)
 TRANS(vfdiv_d, LSX, gen_vvv, gen_helper_vfdiv_d)
 
-TRANS(vfmadd_s, LSX, gen_vvvv, gen_helper_vfmadd_s)
-TRANS(vfmadd_d, LSX, gen_vvvv, gen_helper_vfmadd_d)
-TRANS(vfmsub_s, LSX, gen_vvvv, gen_helper_vfmsub_s)
-TRANS(vfmsub_d, LSX, gen_vvvv, gen_helper_vfmsub_d)
-TRANS(vfnmadd_s, LSX, gen_vvvv, gen_helper_vfnmadd_s)
-TRANS(vfnmadd_d, LSX, gen_vvvv, gen_helper_vfnmadd_d)
-TRANS(vfnmsub_s, LSX, gen_vvvv, gen_helper_vfnmsub_s)
-TRANS(vfnmsub_d, LSX, gen_vvvv, gen_helper_vfnmsub_d)
+TRANS(vfmadd_s, LSX, gen_vvvv_ptr, gen_helper_vfmadd_s)
+TRANS(vfmadd_d, LSX, gen_vvvv_ptr, gen_helper_vfmadd_d)
+TRANS(vfmsub_s, LSX, gen_vvvv_ptr, gen_helper_vfmsub_s)
+TRANS(vfmsub_d, LSX, gen_vvvv_ptr, gen_helper_vfmsub_d)
+TRANS(vfnmadd_s, LSX, gen_vvvv_ptr, gen_helper_vfnmadd_s)
+TRANS(vfnmadd_d, LSX, gen_vvvv_ptr, gen_helper_vfnmadd_d)
+TRANS(vfnmsub_s, LSX, gen_vvvv_ptr, gen_helper_vfnmsub_s)
+TRANS(vfnmsub_d, LSX, gen_vvvv_ptr, gen_helper_vfnmsub_d)
 
 TRANS(vfmax_s, LSX, gen_vvv, gen_helper_vfmax_s)
 TRANS(vfmax_d, LSX, gen_vvv, gen_helper_vfmax_d)
-- 
2.39.1


