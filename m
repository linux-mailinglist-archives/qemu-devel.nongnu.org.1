Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC58743659
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:02:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF92l-0008K7-Oq; Fri, 30 Jun 2023 03:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qF92b-0008Cu-ML
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:42 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qF92Y-00081e-Sl
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:41 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxZ8Vei55klDQEAA--.6890S3;
 Fri, 30 Jun 2023 15:59:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxjiNIi55kExQTAA--.24469S30; 
 Fri, 30 Jun 2023 15:59:24 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 28/46] target/loongarch: Implement xvsrln xvsran
Date: Fri, 30 Jun 2023 15:58:46 +0800
Message-Id: <20230630075904.45940-29-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230630075904.45940-1-gaosong@loongson.cn>
References: <20230630075904.45940-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjiNIi55kExQTAA--.24469S30
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
- XVSRLN.{B.H/H.W/W.D};
- XVSRAN.{B.H/H.W/W.D};
- XVSRLNI.{B.H/H.W/W.D/D.Q};
- XVSRANI.{B.H/H.W/W.D/D.Q}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  16 ++
 target/loongarch/helper.h                    |  48 ++---
 target/loongarch/insn_trans/trans_lasx.c.inc |  16 ++
 target/loongarch/insns.decode                |  16 ++
 target/loongarch/vec.h                       |   2 +
 target/loongarch/vec_helper.c                | 206 +++++++++++--------
 6 files changed, 196 insertions(+), 108 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 9109203a05..14b526abd6 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2104,6 +2104,22 @@ INSN_LASX(xvsrari_h,         vv_i)
 INSN_LASX(xvsrari_w,         vv_i)
 INSN_LASX(xvsrari_d,         vv_i)
 
+INSN_LASX(xvsrln_b_h,        vvv)
+INSN_LASX(xvsrln_h_w,        vvv)
+INSN_LASX(xvsrln_w_d,        vvv)
+INSN_LASX(xvsran_b_h,        vvv)
+INSN_LASX(xvsran_h_w,        vvv)
+INSN_LASX(xvsran_w_d,        vvv)
+
+INSN_LASX(xvsrlni_b_h,       vv_i)
+INSN_LASX(xvsrlni_h_w,       vv_i)
+INSN_LASX(xvsrlni_w_d,       vv_i)
+INSN_LASX(xvsrlni_d_q,       vv_i)
+INSN_LASX(xvsrani_b_h,       vv_i)
+INSN_LASX(xvsrani_h_w,       vv_i)
+INSN_LASX(xvsrani_w_d,       vv_i)
+INSN_LASX(xvsrani_d_q,       vv_i)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index b4828b1829..edef8c2135 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -384,30 +384,30 @@ DEF_HELPER_5(vsrlri_h, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vsrlri_w, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vsrlri_d, void, env, i32, i32, i32, i32)
 
-DEF_HELPER_5(vsrar_b, void, env, int, i32, i32, i32)
-DEF_HELPER_5(vsrar_h, void, env, int, i32, i32, i32)
-DEF_HELPER_5(vsrar_w, void, env, int, i32, i32, i32)
-DEF_HELPER_5(vsrar_d, void, env, int, i32, i32, i32)
-DEF_HELPER_5(vsrari_b, void, env, int, i32, i32, i32)
-DEF_HELPER_5(vsrari_h, void, env, int, i32, i32, i32)
-DEF_HELPER_5(vsrari_w, void, env, int, i32, i32, i32)
-DEF_HELPER_5(vsrari_d, void, env, int, i32, i32, i32)
-
-DEF_HELPER_4(vsrln_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrln_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrln_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vsran_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsran_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsran_w_d, void, env, i32, i32, i32)
-
-DEF_HELPER_4(vsrlni_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlni_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlni_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlni_d_q, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrani_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrani_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrani_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrani_d_q, void, env, i32, i32, i32)
+DEF_HELPER_5(vsrar_b, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrar_h, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrar_w, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrar_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrari_b, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrari_h, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrari_w, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrari_d, void, env, i32, i32, i32, i32)
+
+DEF_HELPER_5(vsrln_b_h, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrln_h_w, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrln_w_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsran_b_h, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsran_h_w, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsran_w_d, void, env, i32, i32, i32, i32)
+
+DEF_HELPER_5(vsrlni_b_h, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrlni_h_w, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrlni_w_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrlni_d_q, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrani_b_h, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrani_h_w, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrani_w_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrani_d_q, void, env, i32, i32, i32, i32)
 
 DEF_HELPER_4(vsrlrn_b_h, void, env, i32, i32, i32)
 DEF_HELPER_4(vsrlrn_h_w, void, env, i32, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 2f654ef401..a1c3432eec 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -480,6 +480,22 @@ TRANS(xvsrari_h, gen_vv_i, 32, gen_helper_vsrari_h)
 TRANS(xvsrari_w, gen_vv_i, 32, gen_helper_vsrari_w)
 TRANS(xvsrari_d, gen_vv_i, 32, gen_helper_vsrari_d)
 
+TRANS(xvsrln_b_h, gen_vvv, 32, gen_helper_vsrln_b_h)
+TRANS(xvsrln_h_w, gen_vvv, 32, gen_helper_vsrln_h_w)
+TRANS(xvsrln_w_d, gen_vvv, 32, gen_helper_vsrln_w_d)
+TRANS(xvsran_b_h, gen_vvv, 32, gen_helper_vsran_b_h)
+TRANS(xvsran_h_w, gen_vvv, 32, gen_helper_vsran_h_w)
+TRANS(xvsran_w_d, gen_vvv, 32, gen_helper_vsran_w_d)
+
+TRANS(xvsrlni_b_h, gen_vv_i, 32, gen_helper_vsrlni_b_h)
+TRANS(xvsrlni_h_w, gen_vv_i, 32, gen_helper_vsrlni_h_w)
+TRANS(xvsrlni_w_d, gen_vv_i, 32, gen_helper_vsrlni_w_d)
+TRANS(xvsrlni_d_q, gen_vv_i, 32, gen_helper_vsrlni_d_q)
+TRANS(xvsrani_b_h, gen_vv_i, 32, gen_helper_vsrani_b_h)
+TRANS(xvsrani_h_w, gen_vv_i, 32, gen_helper_vsrani_h_w)
+TRANS(xvsrani_w_d, gen_vv_i, 32, gen_helper_vsrani_w_d)
+TRANS(xvsrani_d_q, gen_vv_i, 32, gen_helper_vsrani_d_q)
+
 TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index ca0951e1cc..204dcfa075 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1678,6 +1678,22 @@ xvsrari_h        0111 01101010 10000 1 .... ..... .....   @vv_ui4
 xvsrari_w        0111 01101010 10001 ..... ..... .....    @vv_ui5
 xvsrari_d        0111 01101010 1001 ...... ..... .....    @vv_ui6
 
+xvsrln_b_h       0111 01001111 01001 ..... ..... .....    @vvv
+xvsrln_h_w       0111 01001111 01010 ..... ..... .....    @vvv
+xvsrln_w_d       0111 01001111 01011 ..... ..... .....    @vvv
+xvsran_b_h       0111 01001111 01101 ..... ..... .....    @vvv
+xvsran_h_w       0111 01001111 01110 ..... ..... .....    @vvv
+xvsran_w_d       0111 01001111 01111 ..... ..... .....    @vvv
+
+xvsrlni_b_h      0111 01110100 00000 1 .... ..... .....   @vv_ui4
+xvsrlni_h_w      0111 01110100 00001 ..... ..... .....    @vv_ui5
+xvsrlni_w_d      0111 01110100 0001 ...... ..... .....    @vv_ui6
+xvsrlni_d_q      0111 01110100 001 ....... ..... .....    @vv_ui7
+xvsrani_b_h      0111 01110101 10000 1 .... ..... .....   @vv_ui4
+xvsrani_h_w      0111 01110101 10001 ..... ..... .....    @vv_ui5
+xvsrani_w_d      0111 01110101 1001 ...... ..... .....    @vv_ui6
+xvsrani_d_q      0111 01110101 101 ....... ..... .....    @vv_ui7
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index a0a664cde5..bc3d6b967b 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -74,4 +74,6 @@
 
 #define DO_SIGNCOV(a, b)  (a == 0 ? 0 : a < 0 ? -b : b)
 
+#define R_SHIFT(a, b) (a >> b)
+
 #endif /* LOONGARCH_VEC_H */
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index b745240f8c..8083c24ea7 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -1104,113 +1104,151 @@ VSRARI(vsrari_h, 16, H)
 VSRARI(vsrari_w, 32, W)
 VSRARI(vsrari_d, 64, D)
 
-#define R_SHIFT(a, b) (a >> b)
+#define VSRLN(NAME, BIT, E1, E2)                                  \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz,         \
+                  uint32_t vd, uint32_t vj, uint32_t vk)          \
+{                                                                 \
+    int i, max;                                                   \
+    VReg *Vd = &(env->fpr[vd].vreg);                              \
+    VReg *Vj = &(env->fpr[vj].vreg);                              \
+    VReg *Vk = &(env->fpr[vk].vreg);                              \
+                                                                  \
+    max = LSX_LEN / BIT;                                          \
+    for (i = 0; i < max; i++) {                                   \
+        Vd->E1(i) = R_SHIFT(Vj->E2(i),Vk->E2(i) % BIT);           \
+        if (oprsz == 32) {                                        \
+            Vd->E1(i + max * 2) = R_SHIFT(Vj->E2(i + max),        \
+                                          Vk->E2(i + max) % BIT); \
+        }                                                         \
+    }                                                             \
+    Vd->D(1) = 0;                                                 \
+    if (oprsz == 32) {                                            \
+        Vd->D(3) = 0;                                             \
+    }                                                             \
+}
 
-#define VSRLN(NAME, BIT, T, E1, E2)                             \
-void HELPER(NAME)(CPULoongArchState *env,                       \
-                  uint32_t vd, uint32_t vj, uint32_t vk)        \
-{                                                               \
-    int i;                                                      \
-    VReg *Vd = &(env->fpr[vd].vreg);                            \
-    VReg *Vj = &(env->fpr[vj].vreg);                            \
-    VReg *Vk = &(env->fpr[vk].vreg);                            \
-                                                                \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                         \
-        Vd->E1(i) = R_SHIFT((T)Vj->E2(i),((T)Vk->E2(i)) % BIT); \
-    }                                                           \
-    Vd->D(1) = 0;                                               \
-}
-
-VSRLN(vsrln_b_h, 16, uint16_t, B, H)
-VSRLN(vsrln_h_w, 32, uint32_t, H, W)
-VSRLN(vsrln_w_d, 64, uint64_t, W, D)
-
-#define VSRAN(NAME, BIT, T, E1, E2)                           \
-void HELPER(NAME)(CPULoongArchState *env,                     \
-                  uint32_t vd, uint32_t vj, uint32_t vk)      \
-{                                                             \
-    int i;                                                    \
-    VReg *Vd = &(env->fpr[vd].vreg);                          \
-    VReg *Vj = &(env->fpr[vj].vreg);                          \
-    VReg *Vk = &(env->fpr[vk].vreg);                          \
-                                                              \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                       \
-        Vd->E1(i) = R_SHIFT(Vj->E2(i), ((T)Vk->E2(i)) % BIT); \
-    }                                                         \
-    Vd->D(1) = 0;                                             \
-}
-
-VSRAN(vsran_b_h, 16, uint16_t, B, H)
-VSRAN(vsran_h_w, 32, uint32_t, H, W)
-VSRAN(vsran_w_d, 64, uint64_t, W, D)
-
-#define VSRLNI(NAME, BIT, T, E1, E2)                         \
-void HELPER(NAME)(CPULoongArchState *env,                    \
-                  uint32_t vd, uint32_t vj, uint32_t imm)    \
-{                                                            \
-    int i, max;                                              \
-    VReg temp;                                               \
-    VReg *Vd = &(env->fpr[vd].vreg);                         \
-    VReg *Vj = &(env->fpr[vj].vreg);                         \
-                                                             \
-    temp.D(0) = 0;                                           \
-    temp.D(1) = 0;                                           \
-    max = LSX_LEN/BIT;                                       \
-    for (i = 0; i < max; i++) {                              \
-        temp.E1(i) = R_SHIFT((T)Vj->E2(i), imm);             \
-        temp.E1(i + max) = R_SHIFT((T)Vd->E2(i), imm);       \
-    }                                                        \
-    *Vd = temp;                                              \
-}
-
-void HELPER(vsrlni_d_q)(CPULoongArchState *env,
+VSRLN(vsrln_b_h, 16, B, UH)
+VSRLN(vsrln_h_w, 32, H, UW)
+VSRLN(vsrln_w_d, 64, W, UD)
+
+#define VSRAN(NAME, BIT, E1, E2, E3)                              \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz,         \
+                  uint32_t vd, uint32_t vj, uint32_t vk)          \
+{                                                                 \
+    int i, max;                                                   \
+    VReg *Vd = &(env->fpr[vd].vreg);                              \
+    VReg *Vj = &(env->fpr[vj].vreg);                              \
+    VReg *Vk = &(env->fpr[vk].vreg);                              \
+                                                                  \
+    max = LSX_LEN / BIT;                                          \
+    for (i = 0; i < max; i++) {                                   \
+        Vd->E1(i) = R_SHIFT(Vj->E2(i), Vk->E3(i) % BIT);          \
+        if (oprsz == 32) {                                        \
+            Vd->E1(i + max * 2) = R_SHIFT(Vj->E2(i + max),        \
+                                          Vk->E3(i + max) % BIT); \
+        }                                                         \
+    }                                                             \
+    Vd->D(1) = 0;                                                 \
+    if (oprsz == 32) {                                            \
+        Vd->D(3) = 0;                                             \
+    }                                                             \
+}
+
+VSRAN(vsran_b_h, 16, B, H, UH)
+VSRAN(vsran_h_w, 32, H, W, UW)
+VSRAN(vsran_w_d, 64, W, D, UD)
+
+#define VSRLNI(NAME, BIT, E1, E2)                                 \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz,         \
+                  uint32_t vd, uint32_t vj, uint32_t imm)         \
+{                                                                 \
+    int i, max;                                                   \
+    VReg temp;                                                    \
+    VReg *Vd = &(env->fpr[vd].vreg);                              \
+    VReg *Vj = &(env->fpr[vj].vreg);                              \
+                                                                  \
+    temp.Q(0) = int128_zero();                                    \
+    if (oprsz == 32) {                                            \
+        temp.Q(1) = int128_zero();                                \
+    }                                                             \
+    max = LSX_LEN / BIT;                                          \
+    for (i = 0; i < max; i++) {                                   \
+        temp.E1(i) = R_SHIFT(Vj->E2(i), imm);                     \
+        temp.E1(i + max) = R_SHIFT(Vd->E2(i), imm);               \
+        if (oprsz == 32) {                                        \
+            temp.E1(i + max * 2) = R_SHIFT(Vj->E2(i + max), imm); \
+            temp.E1(i + max * 3) = R_SHIFT(Vd->E2(i + max), imm); \
+        }                                                         \
+    }                                                             \
+    *Vd = temp;                                                   \
+}
+
+void HELPER(vsrlni_d_q)(CPULoongArchState *env, uint32_t oprsz,
                         uint32_t vd, uint32_t vj, uint32_t imm)
 {
     VReg temp;
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
 
-    temp.D(0) = 0;
-    temp.D(1) = 0;
+    temp.Q(0) = int128_zero();
+    if (oprsz == 32) {
+        temp.Q(1) = int128_zero();
+    }
     temp.D(0) = int128_getlo(int128_urshift(Vj->Q(0), imm % 128));
     temp.D(1) = int128_getlo(int128_urshift(Vd->Q(0), imm % 128));
+    if (oprsz == 32) {
+        temp.D(2) = int128_getlo(int128_urshift(Vj->Q(1), imm % 128));
+        temp.D(3) = int128_getlo(int128_urshift(Vd->Q(1), imm % 128));
+    }
     *Vd = temp;
 }
 
-VSRLNI(vsrlni_b_h, 16, uint16_t, B, H)
-VSRLNI(vsrlni_h_w, 32, uint32_t, H, W)
-VSRLNI(vsrlni_w_d, 64, uint64_t, W, D)
+VSRLNI(vsrlni_b_h, 16, B, UH)
+VSRLNI(vsrlni_h_w, 32, H, UW)
+VSRLNI(vsrlni_w_d, 64, W, UD)
 
-#define VSRANI(NAME, BIT, E1, E2)                         \
-void HELPER(NAME)(CPULoongArchState *env,                 \
-                  uint32_t vd, uint32_t vj, uint32_t imm) \
-{                                                         \
-    int i, max;                                           \
-    VReg temp;                                            \
-    VReg *Vd = &(env->fpr[vd].vreg);                      \
-    VReg *Vj = &(env->fpr[vj].vreg);                      \
-                                                          \
-    temp.D(0) = 0;                                        \
-    temp.D(1) = 0;                                        \
-    max = LSX_LEN/BIT;                                    \
-    for (i = 0; i < max; i++) {                           \
-        temp.E1(i) = R_SHIFT(Vj->E2(i), imm);             \
-        temp.E1(i + max) = R_SHIFT(Vd->E2(i), imm);       \
-    }                                                     \
-    *Vd = temp;                                           \
+#define VSRANI(NAME, BIT, E1, E2)                                 \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz,         \
+                  uint32_t vd, uint32_t vj, uint32_t imm)         \
+{                                                                 \
+    int i, max;                                                   \
+    VReg temp;                                                    \
+    VReg *Vd = &(env->fpr[vd].vreg);                              \
+    VReg *Vj = &(env->fpr[vj].vreg);                              \
+                                                                  \
+    temp.Q(0) = int128_zero();                                    \
+    if (oprsz == 32) {                                            \
+        temp.Q(1) = int128_zero();                                \
+    }                                                             \
+    max = LSX_LEN / BIT;                                          \
+    for (i = 0; i < max; i++) {                                   \
+        temp.E1(i) = R_SHIFT(Vj->E2(i), imm);                     \
+        temp.E1(i + max) = R_SHIFT(Vd->E2(i), imm);               \
+        if (oprsz == 32) {                                        \
+            temp.E1(i + max * 2) = R_SHIFT(Vj->E2(i + max), imm); \
+            temp.E1(i + max * 3) = R_SHIFT(Vd->E2(i + max), imm); \
+        }                                                         \
+    }                                                             \
+    *Vd = temp;                                                   \
 }
 
-void HELPER(vsrani_d_q)(CPULoongArchState *env,
+void HELPER(vsrani_d_q)(CPULoongArchState *env, uint32_t oprsz,
                         uint32_t vd, uint32_t vj, uint32_t imm)
 {
     VReg temp;
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
 
-    temp.D(0) = 0;
-    temp.D(1) = 0;
+    temp.Q(0) = int128_zero();
+    if (oprsz == 32) {
+        temp.Q(1) = int128_zero();
+    }
     temp.D(0) = int128_getlo(int128_rshift(Vj->Q(0), imm % 128));
     temp.D(1) = int128_getlo(int128_rshift(Vd->Q(0), imm % 128));
+    if (oprsz == 32) {
+        temp.D(2) = int128_getlo(int128_rshift(Vj->Q(1), imm % 128));
+        temp.D(3) = int128_getlo(int128_rshift(Vd->Q(1), imm % 128));
+    }
     *Vd = temp;
 }
 
-- 
2.39.1


