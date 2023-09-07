Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BBA7970BF
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 10:32:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeAQv-0003IT-43; Thu, 07 Sep 2023 04:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qeAQs-0003GH-6v
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:32:10 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qeAQn-00026e-RV
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:32:09 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxZ+iDivlk3zghAA--.30321S3;
 Thu, 07 Sep 2023 16:32:03 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bxxsx+ivlk8FVwAA--.49124S6; 
 Thu, 07 Sep 2023 16:32:02 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH RESEND v5 04/57] target/loongarch: Use gen_helper_gvec_4 for
 4OP vector instructions
Date: Thu,  7 Sep 2023 16:31:05 +0800
Message-Id: <20230907083158.3975132-5-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230907083158.3975132-1-gaosong@loongson.cn>
References: <20230907083158.3975132-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxxsx+ivlk8FVwAA--.49124S6
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
 target/loongarch/helper.h                   |  2 +-
 target/loongarch/vec_helper.c               | 11 +++++------
 target/loongarch/insn_trans/trans_vec.c.inc | 22 ++++++++++++---------
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index ead16567c2..727ccfb32c 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -682,7 +682,7 @@ DEF_HELPER_4(vilvh_h, void, env, i32, i32, i32)
 DEF_HELPER_4(vilvh_w, void, env, i32, i32, i32)
 DEF_HELPER_4(vilvh_d, void, env, i32, i32, i32)
 
-DEF_HELPER_5(vshuf_b, void, env, i32, i32, i32, i32)
+DEF_HELPER_FLAGS_5(vshuf_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_4(vshuf_h, void, env, i32, i32, i32)
 DEF_HELPER_4(vshuf_w, void, env, i32, i32, i32)
 DEF_HELPER_4(vshuf_d, void, env, i32, i32, i32)
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 3a7a620227..7078c4c845 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -2899,15 +2899,14 @@ VILVH(vilvh_h, 32, H)
 VILVH(vilvh_w, 64, W)
 VILVH(vilvh_d, 128, D)
 
-void HELPER(vshuf_b)(CPULoongArchState *env,
-                     uint32_t vd, uint32_t vj, uint32_t vk, uint32_t va)
+void HELPER(vshuf_b)(void *vd, void *vj, void *vk, void *va, uint32_t desc)
 {
     int i, m;
     VReg temp;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
-    VReg *Vk = &(env->fpr[vk].vreg);
-    VReg *Va = &(env->fpr[va].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
+    VReg *Vk = (VReg *)vk;
+    VReg *Va = (VReg *)va;
 
     m = LSX_LEN/8;
     for (i = 0; i < m ; i++) {
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 85bc8670a7..6f45296987 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -34,18 +34,22 @@ static bool gen_vvvv_ptr(DisasContext *ctx, arg_vvvv *a,
     return gen_vvvv_ptr_vl(ctx, a, 16, fn);
 }
 
-static bool gen_vvvv(DisasContext *ctx, arg_vvvv *a,
-                     void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32,
-                                  TCGv_i32, TCGv_i32))
+static bool gen_vvvv_vl(DisasContext *ctx, arg_vvvv *a, uint32_t oprsz,
+                        gen_helper_gvec_4 *fn)
 {
-    TCGv_i32 vd = tcg_constant_i32(a->vd);
-    TCGv_i32 vj = tcg_constant_i32(a->vj);
-    TCGv_i32 vk = tcg_constant_i32(a->vk);
-    TCGv_i32 va = tcg_constant_i32(a->va);
+    tcg_gen_gvec_4_ool(vec_full_offset(a->vd),
+                       vec_full_offset(a->vj),
+                       vec_full_offset(a->vk),
+                       vec_full_offset(a->va),
+                       oprsz, ctx->vl / 8, oprsz, fn);
+    return true;
+}
 
+static bool gen_vvvv(DisasContext *ctx, arg_vvvv *a,
+                     gen_helper_gvec_4 *fn)
+{
     CHECK_SXE;
-    func(cpu_env, vd, vj, vk, va);
-    return true;
+    return gen_vvvv_vl(ctx, a, 16, fn);
 }
 
 static bool gen_vvv(DisasContext *ctx, arg_vvv *a,
-- 
2.39.1


