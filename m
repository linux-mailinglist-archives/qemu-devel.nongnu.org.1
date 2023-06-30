Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E32A07436A2
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:11:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF92p-0008Mx-Ca; Fri, 30 Jun 2023 03:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qF92e-0008Dw-3G
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:44 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qF92b-00081g-B2
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:43 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxCsZei55kljQEAA--.6905S3;
 Fri, 30 Jun 2023 15:59:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxjiNIi55kExQTAA--.24469S31; 
 Fri, 30 Jun 2023 15:59:25 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 29/46] target/loongarch: Implement xvsrlrn xvsrarn
Date: Fri, 30 Jun 2023 15:58:47 +0800
Message-Id: <20230630075904.45940-30-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230630075904.45940-1-gaosong@loongson.cn>
References: <20230630075904.45940-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjiNIi55kExQTAA--.24469S31
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
- XVSRLRN.{B.H/H.W/W.D};
- XVSRARN.{B.H/H.W/W.D};
- XVSRLRNI.{B.H/H.W/W.D/D.Q};
- XVSRARNI.{B.H/H.W/W.D/D.Q}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  16 ++
 target/loongarch/helper.h                    |  30 +--
 target/loongarch/insn_trans/trans_lasx.c.inc |  16 ++
 target/loongarch/insns.decode                |  16 ++
 target/loongarch/vec_helper.c                | 206 ++++++++++++-------
 5 files changed, 189 insertions(+), 95 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 14b526abd6..04b6ea713d 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2120,6 +2120,22 @@ INSN_LASX(xvsrani_h_w,       vv_i)
 INSN_LASX(xvsrani_w_d,       vv_i)
 INSN_LASX(xvsrani_d_q,       vv_i)
 
+INSN_LASX(xvsrlrn_b_h,       vvv)
+INSN_LASX(xvsrlrn_h_w,       vvv)
+INSN_LASX(xvsrlrn_w_d,       vvv)
+INSN_LASX(xvsrarn_b_h,       vvv)
+INSN_LASX(xvsrarn_h_w,       vvv)
+INSN_LASX(xvsrarn_w_d,       vvv)
+
+INSN_LASX(xvsrlrni_b_h,      vv_i)
+INSN_LASX(xvsrlrni_h_w,      vv_i)
+INSN_LASX(xvsrlrni_w_d,      vv_i)
+INSN_LASX(xvsrlrni_d_q,      vv_i)
+INSN_LASX(xvsrarni_b_h,      vv_i)
+INSN_LASX(xvsrarni_h_w,      vv_i)
+INSN_LASX(xvsrarni_w_d,      vv_i)
+INSN_LASX(xvsrarni_d_q,      vv_i)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index edef8c2135..a708b4321f 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -409,21 +409,21 @@ DEF_HELPER_5(vsrani_h_w, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vsrani_w_d, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vsrani_d_q, void, env, i32, i32, i32, i32)
 
-DEF_HELPER_4(vsrlrn_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlrn_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlrn_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrarn_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrarn_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrarn_w_d, void, env, i32, i32, i32)
-
-DEF_HELPER_4(vsrlrni_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlrni_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlrni_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlrni_d_q, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrarni_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrarni_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrarni_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrarni_d_q, void, env, i32, i32, i32)
+DEF_HELPER_5(vsrlrn_b_h, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrlrn_h_w, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrlrn_w_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrarn_b_h, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrarn_h_w, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrarn_w_d, void, env, i32, i32, i32, i32)
+
+DEF_HELPER_5(vsrlrni_b_h, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrlrni_h_w, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrlrni_w_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrlrni_d_q, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrarni_b_h, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrarni_h_w, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrarni_w_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrarni_d_q, void, env, i32, i32, i32, i32)
 
 DEF_HELPER_4(vssrln_b_h, void, env, i32, i32, i32)
 DEF_HELPER_4(vssrln_h_w, void, env, i32, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index a1c3432eec..58f7c3bbc0 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -496,6 +496,22 @@ TRANS(xvsrani_h_w, gen_vv_i, 32, gen_helper_vsrani_h_w)
 TRANS(xvsrani_w_d, gen_vv_i, 32, gen_helper_vsrani_w_d)
 TRANS(xvsrani_d_q, gen_vv_i, 32, gen_helper_vsrani_d_q)
 
+TRANS(xvsrlrn_b_h, gen_vvv, 32, gen_helper_vsrlrn_b_h)
+TRANS(xvsrlrn_h_w, gen_vvv, 32, gen_helper_vsrlrn_h_w)
+TRANS(xvsrlrn_w_d, gen_vvv, 32, gen_helper_vsrlrn_w_d)
+TRANS(xvsrarn_b_h, gen_vvv, 32, gen_helper_vsrarn_b_h)
+TRANS(xvsrarn_h_w, gen_vvv, 32, gen_helper_vsrarn_h_w)
+TRANS(xvsrarn_w_d, gen_vvv, 32, gen_helper_vsrarn_w_d)
+
+TRANS(xvsrlrni_b_h, gen_vv_i, 32, gen_helper_vsrlrni_b_h)
+TRANS(xvsrlrni_h_w, gen_vv_i, 32, gen_helper_vsrlrni_h_w)
+TRANS(xvsrlrni_w_d, gen_vv_i, 32, gen_helper_vsrlrni_w_d)
+TRANS(xvsrlrni_d_q, gen_vv_i, 32, gen_helper_vsrlrni_d_q)
+TRANS(xvsrarni_b_h, gen_vv_i, 32, gen_helper_vsrarni_b_h)
+TRANS(xvsrarni_h_w, gen_vv_i, 32, gen_helper_vsrarni_h_w)
+TRANS(xvsrarni_w_d, gen_vv_i, 32, gen_helper_vsrarni_w_d)
+TRANS(xvsrarni_d_q, gen_vv_i, 32, gen_helper_vsrarni_d_q)
+
 TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 204dcfa075..d7c50b14ca 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1694,6 +1694,22 @@ xvsrani_h_w      0111 01110101 10001 ..... ..... .....    @vv_ui5
 xvsrani_w_d      0111 01110101 1001 ...... ..... .....    @vv_ui6
 xvsrani_d_q      0111 01110101 101 ....... ..... .....    @vv_ui7
 
+xvsrlrn_b_h      0111 01001111 10001 ..... ..... .....    @vvv
+xvsrlrn_h_w      0111 01001111 10010 ..... ..... .....    @vvv
+xvsrlrn_w_d      0111 01001111 10011 ..... ..... .....    @vvv
+xvsrarn_b_h      0111 01001111 10101 ..... ..... .....    @vvv
+xvsrarn_h_w      0111 01001111 10110 ..... ..... .....    @vvv
+xvsrarn_w_d      0111 01001111 10111 ..... ..... .....    @vvv
+
+xvsrlrni_b_h     0111 01110100 01000 1 .... ..... .....   @vv_ui4
+xvsrlrni_h_w     0111 01110100 01001 ..... ..... .....    @vv_ui5
+xvsrlrni_w_d     0111 01110100 0101 ...... ..... .....    @vv_ui6
+xvsrlrni_d_q     0111 01110100 011 ....... ..... .....    @vv_ui7
+xvsrarni_b_h     0111 01110101 11000 1 .... ..... .....   @vv_ui4
+xvsrarni_h_w     0111 01110101 11001 ..... ..... .....    @vv_ui5
+xvsrarni_w_d     0111 01110101 1101 ...... ..... .....    @vv_ui6
+xvsrarni_d_q     0111 01110101 111 ....... ..... .....    @vv_ui7
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 8083c24ea7..bad3fe2952 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -1256,80 +1256,111 @@ VSRANI(vsrani_b_h, 16, B, H)
 VSRANI(vsrani_h_w, 32, H, W)
 VSRANI(vsrani_w_d, 64, W, D)
 
-#define VSRLRN(NAME, BIT, T, E1, E2)                                \
-void HELPER(NAME)(CPULoongArchState *env,                           \
-                  uint32_t vd, uint32_t vj, uint32_t vk)            \
-{                                                                   \
-    int i;                                                          \
-    VReg *Vd = &(env->fpr[vd].vreg);                                \
-    VReg *Vj = &(env->fpr[vj].vreg);                                \
-    VReg *Vk = &(env->fpr[vk].vreg);                                \
-                                                                    \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                             \
-        Vd->E1(i) = do_vsrlr_ ## E2(Vj->E2(i), ((T)Vk->E2(i))%BIT); \
-    }                                                               \
-    Vd->D(1) = 0;                                                   \
+#define VSRLRN(NAME, BIT, E1, E2, E3)                                     \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz,                 \
+                  uint32_t vd, uint32_t vj, uint32_t vk)                  \
+{                                                                         \
+    int i, max;                                                           \
+    VReg *Vd = &(env->fpr[vd].vreg);                                      \
+    VReg *Vj = &(env->fpr[vj].vreg);                                      \
+    VReg *Vk = &(env->fpr[vk].vreg);                                      \
+                                                                          \
+    max = LSX_LEN / BIT;                                                  \
+    for (i = 0; i < max; i++) {                                           \
+        Vd->E1(i) = do_vsrlr_ ## E2(Vj->E2(i), Vk->E3(i) % BIT);          \
+        if (oprsz == 32) {                                                \
+            Vd->E1(i + max * 2 ) = do_vsrlr_ ##E2(Vj->E2(i + max),        \
+                                                  Vk->E3(i + max) % BIT); \
+        }                                                                 \
+    }                                                                     \
+    Vd->D(1) = 0;                                                         \
+    if (oprsz == 32) {                                                    \
+        Vd->D(3) = 0;                                                     \
+    }                                                                     \
 }
 
-VSRLRN(vsrlrn_b_h, 16, uint16_t, B, H)
-VSRLRN(vsrlrn_h_w, 32, uint32_t, H, W)
-VSRLRN(vsrlrn_w_d, 64, uint64_t, W, D)
+VSRLRN(vsrlrn_b_h, 16, B, H, UH)
+VSRLRN(vsrlrn_h_w, 32, H, W, UW)
+VSRLRN(vsrlrn_w_d, 64, W, D, UD)
 
-#define VSRARN(NAME, BIT, T, E1, E2)                                \
-void HELPER(NAME)(CPULoongArchState *env,                           \
-                  uint32_t vd, uint32_t vj, uint32_t vk)            \
-{                                                                   \
-    int i;                                                          \
-    VReg *Vd = &(env->fpr[vd].vreg);                                \
-    VReg *Vj = &(env->fpr[vj].vreg);                                \
-    VReg *Vk = &(env->fpr[vk].vreg);                                \
-                                                                    \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                             \
-        Vd->E1(i) = do_vsrar_ ## E2(Vj->E2(i), ((T)Vk->E2(i))%BIT); \
-    }                                                               \
-    Vd->D(1) = 0;                                                   \
+#define VSRARN(NAME, BIT, E1, E2, E3)                                     \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz,                 \
+                  uint32_t vd, uint32_t vj, uint32_t vk)                  \
+{                                                                         \
+    int i, max;                                                           \
+    VReg *Vd = &(env->fpr[vd].vreg);                                      \
+    VReg *Vj = &(env->fpr[vj].vreg);                                      \
+    VReg *Vk = &(env->fpr[vk].vreg);                                      \
+                                                                          \
+    max = LSX_LEN / BIT;                                                  \
+    for (i = 0; i < max; i++) {                                           \
+        Vd->E1(i) = do_vsrar_ ## E2(Vj->E2(i), Vk->E3(i) % BIT);          \
+        if (oprsz == 32) {                                                \
+            Vd->E1(i + max * 2) = do_vsrar_ ## E2(Vj->E2(i + max),        \
+                                                  Vk->E3(i + max) % BIT); \
+        }                                                                 \
+    }                                                                     \
+    Vd->D(1) = 0;                                                         \
+    if (oprsz == 32) {                                                    \
+        Vd->D(3) = 0;                                                     \
+    }                                                                     \
 }
 
-VSRARN(vsrarn_b_h, 16, uint8_t,  B, H)
-VSRARN(vsrarn_h_w, 32, uint16_t, H, W)
-VSRARN(vsrarn_w_d, 64, uint32_t, W, D)
+VSRARN(vsrarn_b_h, 16, B, H, UH)
+VSRARN(vsrarn_h_w, 32, H, W, UW)
+VSRARN(vsrarn_w_d, 64, W, D, UD)
 
-#define VSRLRNI(NAME, BIT, E1, E2)                          \
-void HELPER(NAME)(CPULoongArchState *env,                   \
-                  uint32_t vd, uint32_t vj, uint32_t imm)   \
-{                                                           \
-    int i, max;                                             \
-    VReg temp;                                              \
-    VReg *Vd = &(env->fpr[vd].vreg);                        \
-    VReg *Vj = &(env->fpr[vj].vreg);                        \
-                                                            \
-    temp.D(0) = 0;                                          \
-    temp.D(1) = 0;                                          \
-    max = LSX_LEN/BIT;                                      \
-    for (i = 0; i < max; i++) {                             \
-        temp.E1(i) = do_vsrlr_ ## E2(Vj->E2(i), imm);       \
-        temp.E1(i + max) = do_vsrlr_ ## E2(Vd->E2(i), imm); \
-    }                                                       \
-    *Vd = temp;                                             \
+#define VSRLRNI(NAME, BIT, E1, E2)                                        \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz,                 \
+                  uint32_t vd, uint32_t vj, uint32_t imm)                 \
+{                                                                         \
+    int i, max;                                                           \
+    VReg temp;                                                            \
+    VReg *Vd = &(env->fpr[vd].vreg);                                      \
+    VReg *Vj = &(env->fpr[vj].vreg);                                      \
+                                                                          \
+    temp.Q(0) = int128_zero();                                            \
+    if (oprsz == 32) {                                                    \
+        temp.Q(1) = int128_zero();                                        \
+    }                                                                     \
+    max = LSX_LEN / BIT;                                                  \
+    for (i = 0; i < max; i++) {                                           \
+        temp.E1(i) = do_vsrlr_ ## E2(Vj->E2(i), imm);                     \
+        temp.E1(i + max) = do_vsrlr_ ## E2(Vd->E2(i), imm);               \
+        if (oprsz == 32) {                                                \
+            temp.E1(i + max * 2) = do_vsrlr_ ## E2(Vj->E2(i + max), imm); \
+            temp.E1(i + max * 3) = do_vsrlr_ ## E2(Vd->E2(i + max), imm); \
+        }                                                                 \
+    }                                                                     \
+    *Vd = temp;                                                           \
 }
 
-void HELPER(vsrlrni_d_q)(CPULoongArchState *env,
+void HELPER(vsrlrni_d_q)(CPULoongArchState *env, uint32_t oprsz,
                          uint32_t vd, uint32_t vj, uint32_t imm)
 {
     VReg temp;
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
-    Int128 r1, r2;
+    Int128 r1, r2, r3, r4;
 
     if (imm == 0) {
         temp.D(0) = int128_getlo(Vj->Q(0));
         temp.D(1) = int128_getlo(Vd->Q(0));
+        if (oprsz == 32) {
+            temp.D(2) = int128_getlo(Vj->Q(1));
+            temp.D(3) = int128_getlo(Vd->Q(1));
+        }
     } else {
-        r1 = int128_and(int128_urshift(Vj->Q(0), (imm -1)), int128_one());
-        r2 = int128_and(int128_urshift(Vd->Q(0), (imm -1)), int128_one());
-
-       temp.D(0) = int128_getlo(int128_add(int128_urshift(Vj->Q(0), imm), r1));
-       temp.D(1) = int128_getlo(int128_add(int128_urshift(Vd->Q(0), imm), r2));
+        r1 = int128_and(int128_urshift(Vj->Q(0), (imm - 1)), int128_one());
+        r2 = int128_and(int128_urshift(Vd->Q(0), (imm - 1)), int128_one());
+        temp.D(0) = int128_getlo(int128_add(int128_urshift(Vj->Q(0), imm), r1));
+        temp.D(1) = int128_getlo(int128_add(int128_urshift(Vd->Q(0), imm), r2));
+        if (oprsz == 32) {
+            r3 = int128_and(int128_urshift(Vj->Q(1), (imm - 1)), int128_one());
+            r4 = int128_and(int128_urshift(Vd->Q(1), (imm - 1)), int128_one());
+            temp.D(2) = int128_getlo(int128_add(int128_urshift(Vj->Q(1), imm), r3));
+            temp.D(3) = int128_getlo(int128_add(int128_urshift(Vd->Q(1), imm), r4));
+        }
     }
     *Vd = temp;
 }
@@ -1338,42 +1369,57 @@ VSRLRNI(vsrlrni_b_h, 16, B, H)
 VSRLRNI(vsrlrni_h_w, 32, H, W)
 VSRLRNI(vsrlrni_w_d, 64, W, D)
 
-#define VSRARNI(NAME, BIT, E1, E2)                          \
-void HELPER(NAME)(CPULoongArchState *env,                   \
-                  uint32_t vd, uint32_t vj, uint32_t imm)   \
-{                                                           \
-    int i, max;                                             \
-    VReg temp;                                              \
-    VReg *Vd = &(env->fpr[vd].vreg);                        \
-    VReg *Vj = &(env->fpr[vj].vreg);                        \
-                                                            \
-    temp.D(0) = 0;                                          \
-    temp.D(1) = 0;                                          \
-    max = LSX_LEN/BIT;                                      \
-    for (i = 0; i < max; i++) {                             \
-        temp.E1(i) = do_vsrar_ ## E2(Vj->E2(i), imm);       \
-        temp.E1(i + max) = do_vsrar_ ## E2(Vd->E2(i), imm); \
-    }                                                       \
-    *Vd = temp;                                             \
+#define VSRARNI(NAME, BIT, E1, E2)                                        \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz,                 \
+                  uint32_t vd, uint32_t vj, uint32_t imm)                 \
+{                                                                         \
+    int i, max;                                                           \
+    VReg temp;                                                            \
+    VReg *Vd = &(env->fpr[vd].vreg);                                      \
+    VReg *Vj = &(env->fpr[vj].vreg);                                      \
+                                                                          \
+    temp.Q(0) = int128_zero();                                            \
+    if (oprsz == 32) {                                                    \
+        temp.Q(1) = int128_zero();                                        \
+    }                                                                     \
+    max = LSX_LEN / BIT;                                                  \
+    for (i = 0; i < max; i++) {                                           \
+        temp.E1(i) = do_vsrar_ ## E2(Vj->E2(i), imm);                     \
+        temp.E1(i + max) = do_vsrar_ ## E2(Vd->E2(i), imm);               \
+        if (oprsz == 32) {                                                \
+            temp.E1(i + max * 2) = do_vsrar_ ## E2(Vj->E2(i + max), imm); \
+            temp.E1(i + max * 3) = do_vsrar_ ## E2(Vd->E2(i + max), imm); \
+        }                                                                 \
+    }                                                                     \
+    *Vd = temp;                                                           \
 }
 
-void HELPER(vsrarni_d_q)(CPULoongArchState *env,
+void HELPER(vsrarni_d_q)(CPULoongArchState *env, uint32_t oprsz,
                          uint32_t vd, uint32_t vj, uint32_t imm)
 {
     VReg temp;
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
-    Int128 r1, r2;
+    Int128 r1, r2, r3, r4;
 
     if (imm == 0) {
         temp.D(0) = int128_getlo(Vj->Q(0));
         temp.D(1) = int128_getlo(Vd->Q(0));
+        if (oprsz == 32) {
+            temp.D(2) = int128_getlo(Vj->Q(1));
+            temp.D(3) = int128_getlo(Vd->Q(1));
+        }
     } else {
-        r1 = int128_and(int128_rshift(Vj->Q(0), (imm -1)), int128_one());
-        r2 = int128_and(int128_rshift(Vd->Q(0), (imm -1)), int128_one());
-
-       temp.D(0) = int128_getlo(int128_add(int128_rshift(Vj->Q(0), imm), r1));
-       temp.D(1) = int128_getlo(int128_add(int128_rshift(Vd->Q(0), imm), r2));
+        r1 = int128_and(int128_rshift(Vj->Q(0), (imm - 1)), int128_one());
+        r2 = int128_and(int128_rshift(Vd->Q(0), (imm - 1)), int128_one());
+        temp.D(0) = int128_getlo(int128_add(int128_rshift(Vj->Q(0), imm), r1));
+        temp.D(1) = int128_getlo(int128_add(int128_rshift(Vd->Q(0), imm), r2));
+        if (oprsz == 32) {
+            r3 = int128_and(int128_rshift(Vj->Q(1), (imm - 1)), int128_one());
+            r4 = int128_and(int128_rshift(Vd->Q(1), (imm - 1)), int128_one());
+            temp.D(2) = int128_getlo(int128_add(int128_rshift(Vj->Q(1), imm), r3));
+            temp.D(3) = int128_getlo(int128_add(int128_rshift(Vd->Q(1), imm), r4));
+        }
     }
     *Vd = temp;
 }
-- 
2.39.1


