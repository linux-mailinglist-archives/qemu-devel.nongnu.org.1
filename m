Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BAC74369B
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:11:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF92n-0008LB-KC; Fri, 30 Jun 2023 03:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qF92k-0008JA-7l
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:50 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qF92h-00084n-IM
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:49 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bx38dmi55kszQEAA--.6754S3;
 Fri, 30 Jun 2023 15:59:34 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxjiNIi55kExQTAA--.24469S46; 
 Fri, 30 Jun 2023 15:59:33 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 44/46] target/loongarch: Implement xvshuf xvperm{i}
 xvshuf4i xvextrins
Date: Fri, 30 Jun 2023 15:59:02 +0800
Message-Id: <20230630075904.45940-45-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230630075904.45940-1-gaosong@loongson.cn>
References: <20230630075904.45940-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjiNIi55kExQTAA--.24469S46
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
- XVSHUF.{B/H/W/D};
- XVPERM.W;
- XVSHUF4i.{B/H/W/D};
- XVPERMI.{W/D/Q};
- XVEXTRINS.{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  21 +++
 target/loongarch/helper.h                    |  33 ++--
 target/loongarch/insn_trans/trans_lasx.c.inc |  21 +++
 target/loongarch/insns.decode                |  21 +++
 target/loongarch/vec.h                       |   2 +
 target/loongarch/vec_helper.c                | 159 ++++++++++++++-----
 6 files changed, 200 insertions(+), 57 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 9b6a07bbb0..a518c59772 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2575,3 +2575,24 @@ INSN_LASX(xvilvh_b,          vvv)
 INSN_LASX(xvilvh_h,          vvv)
 INSN_LASX(xvilvh_w,          vvv)
 INSN_LASX(xvilvh_d,          vvv)
+
+INSN_LASX(xvshuf_b,          vvvv)
+INSN_LASX(xvshuf_h,          vvv)
+INSN_LASX(xvshuf_w,          vvv)
+INSN_LASX(xvshuf_d,          vvv)
+
+INSN_LASX(xvperm_w,          vvv)
+
+INSN_LASX(xvshuf4i_b,        vv_i)
+INSN_LASX(xvshuf4i_h,        vv_i)
+INSN_LASX(xvshuf4i_w,        vv_i)
+INSN_LASX(xvshuf4i_d,        vv_i)
+
+INSN_LASX(xvpermi_w,         vv_i)
+INSN_LASX(xvpermi_d,         vv_i)
+INSN_LASX(xvpermi_q,         vv_i)
+
+INSN_LASX(xvextrins_d,       vv_i)
+INSN_LASX(xvextrins_w,       vv_i)
+INSN_LASX(xvextrins_h,       vv_i)
+INSN_LASX(xvextrins_b,       vv_i)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index ce6dc97500..3c969c9c9b 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -699,18 +699,21 @@ DEF_HELPER_5(vilvh_h, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vilvh_w, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vilvh_d, void, env, i32, i32, i32, i32)
 
-DEF_HELPER_5(vshuf_b, void, env, i32, i32, i32, i32)
-DEF_HELPER_4(vshuf_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vshuf_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vshuf_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vshuf4i_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vshuf4i_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vshuf4i_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vshuf4i_d, void, env, i32, i32, i32)
-
-DEF_HELPER_4(vpermi_w, void, env, i32, i32, i32)
-
-DEF_HELPER_4(vextrins_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vextrins_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vextrins_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vextrins_d, void, env, i32, i32, i32)
+DEF_HELPER_6(vshuf_b, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_5(vshuf_h, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vshuf_w, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vshuf_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vshuf4i_b, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vshuf4i_h, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vshuf4i_w, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vshuf4i_d, void, env, i32, i32, i32, i32)
+
+DEF_HELPER_5(vperm_w, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vpermi_w, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vpermi_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vpermi_q, void, env, i32, i32, i32, i32)
+
+DEF_HELPER_5(vextrins_b, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vextrins_h, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vextrins_w, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vextrins_d, void, env, i32, i32, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index c059e2fdcc..b8d9b42070 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -962,3 +962,24 @@ TRANS(xvilvh_b, gen_vvv, 32, gen_helper_vilvh_b)
 TRANS(xvilvh_h, gen_vvv, 32, gen_helper_vilvh_h)
 TRANS(xvilvh_w, gen_vvv, 32, gen_helper_vilvh_w)
 TRANS(xvilvh_d, gen_vvv, 32, gen_helper_vilvh_d)
+
+TRANS(xvshuf_b, gen_vvvv, 32, gen_helper_vshuf_b)
+TRANS(xvshuf_h, gen_vvv, 32, gen_helper_vshuf_h)
+TRANS(xvshuf_w, gen_vvv, 32, gen_helper_vshuf_w)
+TRANS(xvshuf_d, gen_vvv, 32, gen_helper_vshuf_d)
+
+TRANS(xvperm_w, gen_vvv, 32,  gen_helper_vperm_w)
+
+TRANS(xvshuf4i_b, gen_vv_i, 32, gen_helper_vshuf4i_b)
+TRANS(xvshuf4i_h, gen_vv_i, 32, gen_helper_vshuf4i_h)
+TRANS(xvshuf4i_w, gen_vv_i, 32, gen_helper_vshuf4i_w)
+TRANS(xvshuf4i_d, gen_vv_i, 32, gen_helper_vshuf4i_d)
+
+TRANS(xvpermi_w, gen_vv_i, 32, gen_helper_vpermi_w)
+TRANS(xvpermi_d, gen_vv_i, 32, gen_helper_vpermi_d)
+TRANS(xvpermi_q, gen_vv_i, 32, gen_helper_vpermi_q)
+
+TRANS(xvextrins_b, gen_vv_i, 32, gen_helper_vextrins_b)
+TRANS(xvextrins_h, gen_vv_i, 32, gen_helper_vextrins_h)
+TRANS(xvextrins_w, gen_vv_i, 32, gen_helper_vextrins_w)
+TRANS(xvextrins_d, gen_vv_i, 32, gen_helper_vextrins_d)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index a325b861c1..64b67ee9ac 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -2039,3 +2039,24 @@ xvilvh_b         0111 01010001 11000 ..... ..... .....    @vvv
 xvilvh_h         0111 01010001 11001 ..... ..... .....    @vvv
 xvilvh_w         0111 01010001 11010 ..... ..... .....    @vvv
 xvilvh_d         0111 01010001 11011 ..... ..... .....    @vvv
+
+xvshuf_b         0000 11010110 ..... ..... ..... .....    @vvvv
+xvshuf_h         0111 01010111 10101 ..... ..... .....    @vvv
+xvshuf_w         0111 01010111 10110 ..... ..... .....    @vvv
+xvshuf_d         0111 01010111 10111 ..... ..... .....    @vvv
+
+xvperm_w         0111 01010111 11010 ..... ..... .....    @vvv
+
+xvshuf4i_b       0111 01111001 00 ........ ..... .....    @vv_ui8
+xvshuf4i_h       0111 01111001 01 ........ ..... .....    @vv_ui8
+xvshuf4i_w       0111 01111001 10 ........ ..... .....    @vv_ui8
+xvshuf4i_d       0111 01111001 11 ........ ..... .....    @vv_ui8
+
+xvpermi_w        0111 01111110 01 ........ ..... .....    @vv_ui8
+xvpermi_d        0111 01111110 10 ........ ..... .....    @vv_ui8
+xvpermi_q        0111 01111110 11 ........ ..... .....    @vv_ui8
+
+xvextrins_d      0111 01111000 00 ........ ..... .....    @vv_ui8
+xvextrins_w      0111 01111000 01 ........ ..... .....    @vv_ui8
+xvextrins_h      0111 01111000 10 ........ ..... .....    @vv_ui8
+xvextrins_b      0111 01111000 11 ........ ..... .....    @vv_ui8
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index 06cc5331a3..c41bdd42fa 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -93,4 +93,6 @@
 #define VSLE(a, b) (a <= b ? -1 : 0)
 #define VSLT(a, b) (a < b ? -1 : 0)
 
+#define SHF_POS(i, imm) (((i) & 0xfc) + (((imm) >> (2 * ((i) & 0x03))) & 0x03))
+
 #endif /* LOONGARCH_VEC_H */
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index d641c718f6..65e83062c1 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -3426,7 +3426,7 @@ VILVH(vilvh_h, 32, H)
 VILVH(vilvh_w, 64, W)
 VILVH(vilvh_d, 128, D)
 
-void HELPER(vshuf_b)(CPULoongArchState *env,
+void HELPER(vshuf_b)(CPULoongArchState *env, uint32_t oprsz,
                      uint32_t vd, uint32_t vj, uint32_t vk, uint32_t va)
 {
     int i, m;
@@ -3436,93 +3436,168 @@ void HELPER(vshuf_b)(CPULoongArchState *env,
     VReg *Vk = &(env->fpr[vk].vreg);
     VReg *Va = &(env->fpr[va].vreg);
 
-    m = LSX_LEN/8;
-    for (i = 0; i < m ; i++) {
+    m = LSX_LEN / 8;
+    for (i = 0; i < m; i++) {
         uint64_t k = (uint8_t)Va->B(i) % (2 * m);
         temp.B(i) = k < m ? Vk->B(k) : Vj->B(k - m);
     }
-    *Vd = temp;
-}
+    if (oprsz == 32) {
+        for(i = m; i < 2 * m; i++) {
+            uint64_t j = (uint8_t)Va->B(i) % (2 * m);
+            temp.B(i) = j < m ? Vk->B(j + m) : Vj->B(j);
+        }
+    }
 
-#define VSHUF(NAME, BIT, E)                              \
-void HELPER(NAME)(CPULoongArchState *env,                \
-                  uint32_t vd, uint32_t vj, uint32_t vk) \
-{                                                        \
-    int i, m;                                            \
-    VReg temp;                                           \
-    VReg *Vd = &(env->fpr[vd].vreg);                     \
-    VReg *Vj = &(env->fpr[vj].vreg);                     \
-    VReg *Vk = &(env->fpr[vk].vreg);                     \
-                                                         \
-    m = LSX_LEN/BIT;                                     \
-    for (i = 0; i < m; i++) {                            \
-        uint64_t k  = ((uint8_t) Vd->E(i)) % (2 * m);    \
-        temp.E(i) = k < m ? Vk->E(k) : Vj->E(k - m);     \
-    }                                                    \
-    *Vd = temp;                                          \
+    *Vd = temp;
 }
 
-VSHUF(vshuf_h, 16, H)
-VSHUF(vshuf_w, 32, W)
-VSHUF(vshuf_d, 64, D)
-
-#define VSHUF4I(NAME, BIT, E)                             \
-void HELPER(NAME)(CPULoongArchState *env,                 \
-                  uint32_t vd, uint32_t vj, uint32_t imm) \
+#define VSHUF(NAME, BIT, E)                               \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz, \
+                  uint32_t vd, uint32_t vj, uint32_t vk)  \
 {                                                         \
-    int i;                                                \
+    int i, m;                                             \
     VReg temp;                                            \
     VReg *Vd = &(env->fpr[vd].vreg);                      \
     VReg *Vj = &(env->fpr[vj].vreg);                      \
+    VReg *Vk = &(env->fpr[vk].vreg);                      \
                                                           \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                   \
-         temp.E(i) = Vj->E(((i) & 0xfc) + (((imm) >>      \
-                           (2 * ((i) & 0x03))) & 0x03));  \
+    m = LSX_LEN / BIT;                                    \
+    for (i = 0; i < m; i++) {                             \
+        uint64_t k  = (uint8_t)Vd->E(i) % (2 * m);        \
+        temp.E(i) = k < m ? Vk->E(k) : Vj->E(k - m);      \
+    }                                                     \
+    if (oprsz == 32) {                                    \
+        for (i = m; i < 2 * m; i++) {                     \
+            uint64_t j = (uint8_t)Vd->E(i) % (2 * m);     \
+            temp.E(i) = j < m ? Vk->E(j + m): Vj->E(j);   \
+        }                                                 \
     }                                                     \
     *Vd = temp;                                           \
 }
 
+VSHUF(vshuf_h, 16, H)
+VSHUF(vshuf_w, 32, W)
+VSHUF(vshuf_d, 64, D)
+
+#define VSHUF4I(NAME, BIT, E)                               \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz,   \
+                  uint32_t vd, uint32_t vj, uint32_t imm)   \
+{                                                           \
+    int i, max;                                             \
+    VReg temp;                                              \
+    VReg *Vd = &(env->fpr[vd].vreg);                        \
+    VReg *Vj = &(env->fpr[vj].vreg);                        \
+                                                            \
+    max = LSX_LEN / BIT;                                    \
+    for (i = 0; i < max; i++) {                             \
+        temp.E(i) = Vj->E(SHF_POS(i, imm));                 \
+    }                                                       \
+    if (oprsz == 32) {                                      \
+        for (i = max; i < 2 * max; i++) {                   \
+            temp.E(i) = Vj->E(SHF_POS(i - max, imm) + max); \
+        }                                                   \
+    }                                                       \
+    *Vd = temp;                                             \
+}
+
 VSHUF4I(vshuf4i_b, 8, B)
 VSHUF4I(vshuf4i_h, 16, H)
 VSHUF4I(vshuf4i_w, 32, W)
 
-void HELPER(vshuf4i_d)(CPULoongArchState *env,
+void HELPER(vshuf4i_d)(CPULoongArchState *env, uint32_t oprsz,
                        uint32_t vd, uint32_t vj, uint32_t imm)
 {
+    int i, max;
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
 
     VReg temp;
-    temp.D(0) = (imm & 2 ? Vj : Vd)->D(imm & 1);
-    temp.D(1) = (imm & 8 ? Vj : Vd)->D((imm >> 2) & 1);
+    max = (oprsz == 16) ? 1 : 2;
+    for (i = 0; i < max; i++) {
+        temp.D(2 * i) = (imm & 2 ? Vj : Vd)->D((imm & 1) + 2 * i);
+        temp.D(2 * i + 1) = (imm & 8 ? Vj : Vd)->D(((imm >> 2) & 1) + 2 * i);
+    }
+    *Vd = temp;
+}
+
+void HELPER(vperm_w)(CPULoongArchState *env, uint32_t oprsz,
+                     uint32_t vd, uint32_t vj, uint32_t vk)
+{
+    int i, m;
+    VReg temp;
+    VReg *Vd = &(env->fpr[vd].vreg);
+    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vk = &(env->fpr[vk].vreg);
+
+    m = LASX_LEN / 32;
+    for (i = 0; i < m ; i++) {
+        uint64_t k = (uint8_t)Vk->W(i) % 8;
+        temp.W(i) = Vj->W(k);
+    }
+    *Vd = temp;
+}
+
+void HELPER(vpermi_w)(CPULoongArchState *env, uint32_t oprsz,
+                      uint32_t vd, uint32_t vj, uint32_t imm)
+{
+    int i, max;
+    VReg temp;
+    VReg *Vd = &(env->fpr[vd].vreg);
+    VReg *Vj = &(env->fpr[vj].vreg);
+
+    max = (oprsz == 16) ? 1 : 2;
+
+    for (i = 0; i < max; i++) {
+        temp.W(4 * i) = Vj->W((imm & 0x3) + 4 * i);
+        temp.W(4 * i + 1) = Vj->W(((imm >> 2) & 0x3) + 4 * i);
+        temp.W(4 * i + 2) = Vd->W(((imm >> 4) & 0x3) + 4 * i);
+        temp.W(4 * i + 3) = Vd->W(((imm >> 6) & 0x3) + 4 * i);
+    }
+    *Vd = temp;
+}
+
+void HELPER(vpermi_d)(CPULoongArchState *env, uint32_t oprsz,
+                      uint32_t vd, uint32_t vj, uint32_t imm)
+{
+    VReg temp;
+    VReg *Vd = &(env->fpr[vd].vreg);
+    VReg *Vj = &(env->fpr[vj].vreg);
+
+    temp.D(0) = Vj->D(imm & 0x3);
+    temp.D(1) = Vj->D((imm >> 2) & 0x3);
+    temp.D(2) = Vj->D((imm >> 4) & 0x3);
+    temp.D(3) = Vj->D((imm >> 6) & 0x3);
     *Vd = temp;
 }
 
-void HELPER(vpermi_w)(CPULoongArchState *env,
+void HELPER(vpermi_q)(CPULoongArchState *env, uint32_t oprsz,
                       uint32_t vd, uint32_t vj, uint32_t imm)
 {
     VReg temp;
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
 
-    temp.W(0) = Vj->W(imm & 0x3);
-    temp.W(1) = Vj->W((imm >> 2) & 0x3);
-    temp.W(2) = Vd->W((imm >> 4) & 0x3);
-    temp.W(3) = Vd->W((imm >> 6) & 0x3);
+    temp.Q(0) = (imm & 0x3) > 1 ? Vd->Q((imm & 0x3) - 2) : Vj->Q(imm & 0x3);
+    temp.Q(1) = ((imm >> 4) & 0x3) > 1 ? Vd->Q(((imm >> 4) & 0x3) - 2) :
+                                         Vj->Q((imm >> 4) & 0x3);
     *Vd = temp;
 }
 
 #define VEXTRINS(NAME, BIT, E, MASK)                      \
-void HELPER(NAME)(CPULoongArchState *env,                 \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz, \
                   uint32_t vd, uint32_t vj, uint32_t imm) \
 {                                                         \
-    int ins, extr;                                        \
+    int ins, extr, max;                                   \
     VReg *Vd = &(env->fpr[vd].vreg);                      \
     VReg *Vj = &(env->fpr[vj].vreg);                      \
                                                           \
+    max = LSX_LEN / BIT;                                  \
     ins = (imm >> 4) & MASK;                              \
     extr = imm & MASK;                                    \
     Vd->E(ins) = Vj->E(extr);                             \
+    if (oprsz == 32) {                                    \
+        Vd->E(ins + max) = Vj->E(extr + max);             \
+    }                                                     \
 }
 
 VEXTRINS(vextrins_b, 8, B, 0xf)
-- 
2.39.1


