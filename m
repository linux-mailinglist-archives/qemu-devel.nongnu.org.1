Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C258779F809
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:30:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgc5K-0003Ok-8o; Wed, 13 Sep 2023 22:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qgc4l-0003F7-Aq
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:27:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qgc4h-0004vL-Nq
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:27:27 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bxyep8bwJli_gmAA--.451S3;
 Thu, 14 Sep 2023 10:27:08 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxvdxmbwJlJ+UDAA--.7298S28; 
 Thu, 14 Sep 2023 10:27:08 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH v6 26/57] target/loongarch: Implement
 xvmadd/xvmsub/xvmaddw{ev/od}
Date: Thu, 14 Sep 2023 10:26:14 +0800
Message-Id: <20230914022645.1151356-27-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230914022645.1151356-1-gaosong@loongson.cn>
References: <20230914022645.1151356-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxvdxmbwJlJ+UDAA--.7298S28
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
- XVMADD.{B/H/W/D};
- XVMSUB.{B/H/W/D};
- XVMADDW{EV/OD}.{H.B/W.H/D.W/Q.D}[U];
- XVMADDW{EV/OD}.{H.BU.B/W.HU.H/D.WU.W/Q.DU.D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/insns.decode               |  34 ++++++
 target/loongarch/disas.c                    |  34 ++++++
 target/loongarch/vec_helper.c               | 112 +++++++++---------
 target/loongarch/insn_trans/trans_vec.c.inc | 121 ++++++++++++++------
 4 files changed, 212 insertions(+), 89 deletions(-)

diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 0f9ebe641f..d6fb51ae64 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1511,6 +1511,40 @@ xvmulwod_w_hu_h  0111 01001010 00101 ..... ..... .....    @vvv
 xvmulwod_d_wu_w  0111 01001010 00110 ..... ..... .....    @vvv
 xvmulwod_q_du_d  0111 01001010 00111 ..... ..... .....    @vvv
 
+xvmadd_b         0111 01001010 10000 ..... ..... .....    @vvv
+xvmadd_h         0111 01001010 10001 ..... ..... .....    @vvv
+xvmadd_w         0111 01001010 10010 ..... ..... .....    @vvv
+xvmadd_d         0111 01001010 10011 ..... ..... .....    @vvv
+xvmsub_b         0111 01001010 10100 ..... ..... .....    @vvv
+xvmsub_h         0111 01001010 10101 ..... ..... .....    @vvv
+xvmsub_w         0111 01001010 10110 ..... ..... .....    @vvv
+xvmsub_d         0111 01001010 10111 ..... ..... .....    @vvv
+
+xvmaddwev_h_b    0111 01001010 11000 ..... ..... .....    @vvv
+xvmaddwev_w_h    0111 01001010 11001 ..... ..... .....    @vvv
+xvmaddwev_d_w    0111 01001010 11010 ..... ..... .....    @vvv
+xvmaddwev_q_d    0111 01001010 11011 ..... ..... .....    @vvv
+xvmaddwod_h_b    0111 01001010 11100 ..... ..... .....    @vvv
+xvmaddwod_w_h    0111 01001010 11101 ..... ..... .....    @vvv
+xvmaddwod_d_w    0111 01001010 11110 ..... ..... .....    @vvv
+xvmaddwod_q_d    0111 01001010 11111 ..... ..... .....    @vvv
+xvmaddwev_h_bu   0111 01001011 01000 ..... ..... .....    @vvv
+xvmaddwev_w_hu   0111 01001011 01001 ..... ..... .....    @vvv
+xvmaddwev_d_wu   0111 01001011 01010 ..... ..... .....    @vvv
+xvmaddwev_q_du   0111 01001011 01011 ..... ..... .....    @vvv
+xvmaddwod_h_bu   0111 01001011 01100 ..... ..... .....    @vvv
+xvmaddwod_w_hu   0111 01001011 01101 ..... ..... .....    @vvv
+xvmaddwod_d_wu   0111 01001011 01110 ..... ..... .....    @vvv
+xvmaddwod_q_du   0111 01001011 01111 ..... ..... .....    @vvv
+xvmaddwev_h_bu_b 0111 01001011 11000 ..... ..... .....    @vvv
+xvmaddwev_w_hu_h 0111 01001011 11001 ..... ..... .....    @vvv
+xvmaddwev_d_wu_w 0111 01001011 11010 ..... ..... .....    @vvv
+xvmaddwev_q_du_d 0111 01001011 11011 ..... ..... .....    @vvv
+xvmaddwod_h_bu_b 0111 01001011 11100 ..... ..... .....    @vvv
+xvmaddwod_w_hu_h 0111 01001011 11101 ..... ..... .....    @vvv
+xvmaddwod_d_wu_w 0111 01001011 11110 ..... ..... .....    @vvv
+xvmaddwod_q_du_d 0111 01001011 11111 ..... ..... .....    @vvv
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index f839373a7a..e4369fd08b 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1928,6 +1928,40 @@ INSN_LASX(xvmulwod_w_hu_h,   vvv)
 INSN_LASX(xvmulwod_d_wu_w,   vvv)
 INSN_LASX(xvmulwod_q_du_d,   vvv)
 
+INSN_LASX(xvmadd_b,          vvv)
+INSN_LASX(xvmadd_h,          vvv)
+INSN_LASX(xvmadd_w,          vvv)
+INSN_LASX(xvmadd_d,          vvv)
+INSN_LASX(xvmsub_b,          vvv)
+INSN_LASX(xvmsub_h,          vvv)
+INSN_LASX(xvmsub_w,          vvv)
+INSN_LASX(xvmsub_d,          vvv)
+
+INSN_LASX(xvmaddwev_h_b,     vvv)
+INSN_LASX(xvmaddwev_w_h,     vvv)
+INSN_LASX(xvmaddwev_d_w,     vvv)
+INSN_LASX(xvmaddwev_q_d,     vvv)
+INSN_LASX(xvmaddwod_h_b,     vvv)
+INSN_LASX(xvmaddwod_w_h,     vvv)
+INSN_LASX(xvmaddwod_d_w,     vvv)
+INSN_LASX(xvmaddwod_q_d,     vvv)
+INSN_LASX(xvmaddwev_h_bu,    vvv)
+INSN_LASX(xvmaddwev_w_hu,    vvv)
+INSN_LASX(xvmaddwev_d_wu,    vvv)
+INSN_LASX(xvmaddwev_q_du,    vvv)
+INSN_LASX(xvmaddwod_h_bu,    vvv)
+INSN_LASX(xvmaddwod_w_hu,    vvv)
+INSN_LASX(xvmaddwod_d_wu,    vvv)
+INSN_LASX(xvmaddwod_q_du,    vvv)
+INSN_LASX(xvmaddwev_h_bu_b,  vvv)
+INSN_LASX(xvmaddwev_w_hu_h,  vvv)
+INSN_LASX(xvmaddwev_d_wu_w,  vvv)
+INSN_LASX(xvmaddwev_q_du_d,  vvv)
+INSN_LASX(xvmaddwod_h_bu_b,  vvv)
+INSN_LASX(xvmaddwod_w_hu_h,  vvv)
+INSN_LASX(xvmaddwod_d_wu_w,  vvv)
+INSN_LASX(xvmaddwod_q_du_d,  vvv)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index e152998094..a800554159 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -529,16 +529,18 @@ DO_ODD_U_S(vmulwod_d_wu_w, 64, D, UD, W, UW, DO_MUL)
 #define DO_MADD(a, b, c)  (a + b * c)
 #define DO_MSUB(a, b, c)  (a - b * c)
 
-#define VMADDSUB(NAME, BIT, E, DO_OP)                       \
-void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t v) \
-{                                                           \
-    int i;                                                  \
-    VReg *Vd = (VReg *)vd;                                  \
-    VReg *Vj = (VReg *)vj;                                  \
-    VReg *Vk = (VReg *)vk;                                  \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                     \
-        Vd->E(i) = DO_OP(Vd->E(i), Vj->E(i) ,Vk->E(i));     \
-    }                                                       \
+#define VMADDSUB(NAME, BIT, E, DO_OP)                          \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
+{                                                              \
+    int i;                                                     \
+    VReg *Vd = (VReg *)vd;                                     \
+    VReg *Vj = (VReg *)vj;                                     \
+    VReg *Vk = (VReg *)vk;                                     \
+    int oprsz = simd_oprsz(desc);                              \
+                                                               \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                  \
+        Vd->E(i) = DO_OP(Vd->E(i), Vj->E(i) ,Vk->E(i));        \
+    }                                                          \
 }
 
 VMADDSUB(vmadd_b, 8, B, DO_MADD)
@@ -551,15 +553,16 @@ VMADDSUB(vmsub_w, 32, W, DO_MSUB)
 VMADDSUB(vmsub_d, 64, D, DO_MSUB)
 
 #define VMADDWEV(NAME, BIT, E1, E2, DO_OP)                        \
-void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t v)       \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)    \
 {                                                                 \
     int i;                                                        \
     VReg *Vd = (VReg *)vd;                                        \
     VReg *Vj = (VReg *)vj;                                        \
     VReg *Vk = (VReg *)vk;                                        \
     typedef __typeof(Vd->E1(0)) TD;                               \
+    int oprsz = simd_oprsz(desc);                                 \
                                                                   \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                           \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                     \
         Vd->E1(i) += DO_OP((TD)Vj->E2(2 * i), (TD)Vk->E2(2 * i)); \
     }                                                             \
 }
@@ -571,19 +574,20 @@ VMADDWEV(vmaddwev_h_bu, 16, UH, UB, DO_MUL)
 VMADDWEV(vmaddwev_w_hu, 32, UW, UH, DO_MUL)
 VMADDWEV(vmaddwev_d_wu, 64, UD, UW, DO_MUL)
 
-#define VMADDWOD(NAME, BIT, E1, E2, DO_OP)                  \
-void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t v) \
-{                                                           \
-    int i;                                                  \
-    VReg *Vd = (VReg *)vd;                                  \
-    VReg *Vj = (VReg *)vj;                                  \
-    VReg *Vk = (VReg *)vk;                                  \
-    typedef __typeof(Vd->E1(0)) TD;                         \
-                                                            \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                     \
-        Vd->E1(i) += DO_OP((TD)Vj->E2(2 * i + 1),           \
-                           (TD)Vk->E2(2 * i + 1));          \
-    }                                                       \
+#define VMADDWOD(NAME, BIT, E1, E2, DO_OP)                     \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
+{                                                              \
+    int i;                                                     \
+    VReg *Vd = (VReg *)vd;                                     \
+    VReg *Vj = (VReg *)vj;                                     \
+    VReg *Vk = (VReg *)vk;                                     \
+    typedef __typeof(Vd->E1(0)) TD;                            \
+    int oprsz = simd_oprsz(desc);                              \
+                                                               \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                  \
+        Vd->E1(i) += DO_OP((TD)Vj->E2(2 * i + 1),              \
+                           (TD)Vk->E2(2 * i + 1));             \
+    }                                                          \
 }
 
 VMADDWOD(vmaddwod_h_b, 16, H, B, DO_MUL)
@@ -593,40 +597,42 @@ VMADDWOD(vmaddwod_h_bu, 16,  UH, UB, DO_MUL)
 VMADDWOD(vmaddwod_w_hu, 32,  UW, UH, DO_MUL)
 VMADDWOD(vmaddwod_d_wu, 64,  UD, UW, DO_MUL)
 
-#define VMADDWEV_U_S(NAME, BIT, ES1, EU1, ES2, EU2, DO_OP)  \
-void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t v) \
-{                                                           \
-    int i;                                                  \
-    VReg *Vd = (VReg *)vd;                                  \
-    VReg *Vj = (VReg *)vj;                                  \
-    VReg *Vk = (VReg *)vk;                                  \
-    typedef __typeof(Vd->ES1(0)) TS1;                       \
-    typedef __typeof(Vd->EU1(0)) TU1;                       \
-                                                            \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                     \
-        Vd->ES1(i) += DO_OP((TU1)Vj->EU2(2 * i),            \
-                            (TS1)Vk->ES2(2 * i));           \
-    }                                                       \
+#define VMADDWEV_U_S(NAME, BIT, ES1, EU1, ES2, EU2, DO_OP)     \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
+{                                                              \
+    int i;                                                     \
+    VReg *Vd = (VReg *)vd;                                     \
+    VReg *Vj = (VReg *)vj;                                     \
+    VReg *Vk = (VReg *)vk;                                     \
+    typedef __typeof(Vd->ES1(0)) TS1;                          \
+    typedef __typeof(Vd->EU1(0)) TU1;                          \
+    int oprsz = simd_oprsz(desc);                              \
+                                                               \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                  \
+        Vd->ES1(i) += DO_OP((TU1)Vj->EU2(2 * i),               \
+                            (TS1)Vk->ES2(2 * i));              \
+    }                                                          \
 }
 
 VMADDWEV_U_S(vmaddwev_h_bu_b, 16, H, UH, B, UB, DO_MUL)
 VMADDWEV_U_S(vmaddwev_w_hu_h, 32, W, UW, H, UH, DO_MUL)
 VMADDWEV_U_S(vmaddwev_d_wu_w, 64, D, UD, W, UW, DO_MUL)
 
-#define VMADDWOD_U_S(NAME, BIT, ES1, EU1, ES2, EU2, DO_OP)  \
-void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t v) \
-{                                                           \
-    int i;                                                  \
-    VReg *Vd = (VReg *)vd;                                  \
-    VReg *Vj = (VReg *)vj;                                  \
-    VReg *Vk = (VReg *)vk;                                  \
-    typedef __typeof(Vd->ES1(0)) TS1;                       \
-    typedef __typeof(Vd->EU1(0)) TU1;                       \
-                                                            \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                     \
-        Vd->ES1(i) += DO_OP((TU1)Vj->EU2(2 * i + 1),         \
-                            (TS1)Vk->ES2(2 * i + 1));        \
-    }                                                       \
+#define VMADDWOD_U_S(NAME, BIT, ES1, EU1, ES2, EU2, DO_OP)     \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
+{                                                              \
+    int i;                                                     \
+    VReg *Vd = (VReg *)vd;                                     \
+    VReg *Vj = (VReg *)vj;                                     \
+    VReg *Vk = (VReg *)vk;                                     \
+    typedef __typeof(Vd->ES1(0)) TS1;                          \
+    typedef __typeof(Vd->EU1(0)) TU1;                          \
+    int oprsz = simd_oprsz(desc);                              \
+                                                               \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                  \
+        Vd->ES1(i) += DO_OP((TU1)Vj->EU2(2 * i + 1),           \
+                            (TS1)Vk->ES2(2 * i + 1));          \
+    }                                                          \
 }
 
 VMADDWOD_U_S(vmaddwod_h_bu_b, 16, H, UH, B, UB, DO_MUL)
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 714cea848f..370e29ad99 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -2591,6 +2591,10 @@ TRANS(vmadd_b, LSX, gvec_vvv, MO_8, do_vmadd)
 TRANS(vmadd_h, LSX, gvec_vvv, MO_16, do_vmadd)
 TRANS(vmadd_w, LSX, gvec_vvv, MO_32, do_vmadd)
 TRANS(vmadd_d, LSX, gvec_vvv, MO_64, do_vmadd)
+TRANS(xvmadd_b, LASX, gvec_xxx, MO_8, do_vmadd)
+TRANS(xvmadd_h, LASX, gvec_xxx, MO_16, do_vmadd)
+TRANS(xvmadd_w, LASX, gvec_xxx, MO_32, do_vmadd)
+TRANS(xvmadd_d, LASX, gvec_xxx, MO_64, do_vmadd)
 
 static void gen_vmsub(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2665,6 +2669,10 @@ TRANS(vmsub_b, LSX, gvec_vvv, MO_8, do_vmsub)
 TRANS(vmsub_h, LSX, gvec_vvv, MO_16, do_vmsub)
 TRANS(vmsub_w, LSX, gvec_vvv, MO_32, do_vmsub)
 TRANS(vmsub_d, LSX, gvec_vvv, MO_64, do_vmsub)
+TRANS(xvmsub_b, LASX, gvec_xxx, MO_8, do_vmsub)
+TRANS(xvmsub_h, LASX, gvec_xxx, MO_16, do_vmsub)
+TRANS(xvmsub_w, LASX, gvec_xxx, MO_32, do_vmsub)
+TRANS(xvmsub_d, LASX, gvec_xxx, MO_64, do_vmsub)
 
 static void gen_vmaddwev_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2739,43 +2747,69 @@ static void do_vmaddwev_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
 TRANS(vmaddwev_h_b, LSX, gvec_vvv, MO_8, do_vmaddwev_s)
 TRANS(vmaddwev_w_h, LSX, gvec_vvv, MO_16, do_vmaddwev_s)
 TRANS(vmaddwev_d_w, LSX, gvec_vvv, MO_32, do_vmaddwev_s)
+TRANS(xvmaddwev_h_b, LASX, gvec_xxx, MO_8, do_vmaddwev_s)
+TRANS(xvmaddwev_w_h, LASX, gvec_xxx, MO_16, do_vmaddwev_s)
+TRANS(xvmaddwev_d_w, LASX, gvec_xxx, MO_32, do_vmaddwev_s)
 
-#define VMADD_Q(NAME, FN, idx1, idx2)                     \
-static bool trans_## NAME (DisasContext *ctx, arg_vvv *a) \
-{                                                         \
-    TCGv_i64 rh, rl, arg1, arg2, th, tl;                  \
-                                                          \
-    if (!avail_LSX(ctx)) {                                \
-        return false;                                     \
-    }                                                     \
-                                                          \
-    rh = tcg_temp_new_i64();                              \
-    rl = tcg_temp_new_i64();                              \
-    arg1 = tcg_temp_new_i64();                            \
-    arg2 = tcg_temp_new_i64();                            \
-    th = tcg_temp_new_i64();                              \
-    tl = tcg_temp_new_i64();                              \
-                                                          \
-    get_vreg64(arg1, a->vj, idx1);                        \
-    get_vreg64(arg2, a->vk, idx2);                        \
-    get_vreg64(rh, a->vd, 1);                             \
-    get_vreg64(rl, a->vd, 0);                             \
-                                                          \
-    tcg_gen_## FN ##_i64(tl, th, arg1, arg2);             \
-    tcg_gen_add2_i64(rl, rh, rl, rh, tl, th);             \
-                                                          \
-    set_vreg64(rh, a->vd, 1);                             \
-    set_vreg64(rl, a->vd, 0);                             \
-                                                          \
-    return true;                                          \
-}
-
-VMADD_Q(vmaddwev_q_d, muls2, 0, 0)
-VMADD_Q(vmaddwod_q_d, muls2, 1, 1)
-VMADD_Q(vmaddwev_q_du, mulu2, 0, 0)
-VMADD_Q(vmaddwod_q_du, mulu2, 1, 1)
-VMADD_Q(vmaddwev_q_du_d, mulus2, 0, 0)
-VMADD_Q(vmaddwod_q_du_d, mulus2, 1, 1)
+static bool gen_vmadd_q_vl(DisasContext * ctx,
+                           arg_vvv *a, uint32_t oprsz, int idx1, int idx2,
+                           void (*func)(TCGv_i64, TCGv_i64,
+                                        TCGv_i64, TCGv_i64))
+{
+    TCGv_i64 rh, rl, arg1, arg2, th, tl;
+    int i;
+
+    if (!check_vec(ctx, oprsz)) {
+        return true;
+    }
+
+    rh = tcg_temp_new_i64();
+    rl = tcg_temp_new_i64();
+    arg1 = tcg_temp_new_i64();
+    arg2 = tcg_temp_new_i64();
+    th = tcg_temp_new_i64();
+    tl = tcg_temp_new_i64();
+
+    for (i = 0; i < oprsz / 16; i++) {
+        get_vreg64(arg1, a->vj, 2 * i + idx1);
+        get_vreg64(arg2, a->vk, 2 * i + idx2);
+        get_vreg64(rh, a->vd, 2 * i + 1);
+        get_vreg64(rl, a->vd, 2 * i);
+
+        func(tl, th, arg1, arg2);
+        tcg_gen_add2_i64(rl, rh, rl, rh, tl, th);
+
+        set_vreg64(rh, a->vd, 2 * i + 1);
+        set_vreg64(rl, a->vd, 2 * i);
+    }
+
+    return true;
+}
+
+static bool gen_vmadd_q(DisasContext *ctx, arg_vvv *a, int idx1, int idx2,
+                        void (*func)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
+{
+    return gen_vmadd_q_vl(ctx, a, 16, idx1, idx2, func);
+}
+
+static bool gen_xvmadd_q(DisasContext *ctx, arg_vvv *a, int idx1, int idx2,
+                         void (*func)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
+{
+    return gen_vmadd_q_vl(ctx, a, 32, idx1, idx2, func);
+}
+
+TRANS(vmaddwev_q_d, LSX, gen_vmadd_q, 0, 0, tcg_gen_muls2_i64)
+TRANS(vmaddwod_q_d, LSX, gen_vmadd_q, 1, 1, tcg_gen_muls2_i64)
+TRANS(vmaddwev_q_du, LSX, gen_vmadd_q, 0, 0, tcg_gen_mulu2_i64)
+TRANS(vmaddwod_q_du, LSX, gen_vmadd_q, 1, 1, tcg_gen_mulu2_i64)
+TRANS(vmaddwev_q_du_d, LSX, gen_vmadd_q, 0, 0, tcg_gen_mulus2_i64)
+TRANS(vmaddwod_q_du_d, LSX, gen_vmadd_q, 1, 1, tcg_gen_mulus2_i64)
+TRANS(xvmaddwev_q_d, LASX, gen_xvmadd_q, 0, 0, tcg_gen_muls2_i64)
+TRANS(xvmaddwod_q_d, LASX, gen_xvmadd_q, 1, 1, tcg_gen_muls2_i64)
+TRANS(xvmaddwev_q_du, LASX, gen_xvmadd_q, 0, 0, tcg_gen_mulu2_i64)
+TRANS(xvmaddwod_q_du, LASX, gen_xvmadd_q, 1, 1, tcg_gen_mulu2_i64)
+TRANS(xvmaddwev_q_du_d, LASX, gen_xvmadd_q, 0, 0, tcg_gen_mulus2_i64)
+TRANS(xvmaddwod_q_du_d, LASX, gen_xvmadd_q, 1, 1, tcg_gen_mulus2_i64)
 
 static void gen_vmaddwod_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2847,6 +2881,9 @@ static void do_vmaddwod_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
 TRANS(vmaddwod_h_b, LSX, gvec_vvv, MO_8, do_vmaddwod_s)
 TRANS(vmaddwod_w_h, LSX, gvec_vvv, MO_16, do_vmaddwod_s)
 TRANS(vmaddwod_d_w, LSX, gvec_vvv, MO_32, do_vmaddwod_s)
+TRANS(xvmaddwod_h_b, LASX, gvec_xxx, MO_8, do_vmaddwod_s)
+TRANS(xvmaddwod_w_h, LASX, gvec_xxx, MO_16, do_vmaddwod_s)
+TRANS(xvmaddwod_d_w, LASX, gvec_xxx, MO_32, do_vmaddwod_s)
 
 static void gen_vmaddwev_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2917,6 +2954,9 @@ static void do_vmaddwev_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
 TRANS(vmaddwev_h_bu, LSX, gvec_vvv, MO_8, do_vmaddwev_u)
 TRANS(vmaddwev_w_hu, LSX, gvec_vvv, MO_16, do_vmaddwev_u)
 TRANS(vmaddwev_d_wu, LSX, gvec_vvv, MO_32, do_vmaddwev_u)
+TRANS(xvmaddwev_h_bu, LASX, gvec_xxx, MO_8, do_vmaddwev_u)
+TRANS(xvmaddwev_w_hu, LASX, gvec_xxx, MO_16, do_vmaddwev_u)
+TRANS(xvmaddwev_d_wu, LASX, gvec_xxx, MO_32, do_vmaddwev_u)
 
 static void gen_vmaddwod_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2988,6 +3028,9 @@ static void do_vmaddwod_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
 TRANS(vmaddwod_h_bu, LSX, gvec_vvv, MO_8, do_vmaddwod_u)
 TRANS(vmaddwod_w_hu, LSX, gvec_vvv, MO_16, do_vmaddwod_u)
 TRANS(vmaddwod_d_wu, LSX, gvec_vvv, MO_32, do_vmaddwod_u)
+TRANS(xvmaddwod_h_bu, LASX, gvec_xxx, MO_8, do_vmaddwod_u)
+TRANS(xvmaddwod_w_hu, LASX, gvec_xxx, MO_16, do_vmaddwod_u)
+TRANS(xvmaddwod_d_wu, LASX, gvec_xxx, MO_32, do_vmaddwod_u)
 
 static void gen_vmaddwev_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -3061,6 +3104,9 @@ static void do_vmaddwev_u_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
 TRANS(vmaddwev_h_bu_b, LSX, gvec_vvv, MO_8, do_vmaddwev_u_s)
 TRANS(vmaddwev_w_hu_h, LSX, gvec_vvv, MO_16, do_vmaddwev_u_s)
 TRANS(vmaddwev_d_wu_w, LSX, gvec_vvv, MO_32, do_vmaddwev_u_s)
+TRANS(xvmaddwev_h_bu_b, LASX, gvec_xxx, MO_8, do_vmaddwev_u_s)
+TRANS(xvmaddwev_w_hu_h, LASX, gvec_xxx, MO_16, do_vmaddwev_u_s)
+TRANS(xvmaddwev_d_wu_w, LASX, gvec_xxx, MO_32, do_vmaddwev_u_s)
 
 static void gen_vmaddwod_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -3133,6 +3179,9 @@ static void do_vmaddwod_u_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
 TRANS(vmaddwod_h_bu_b, LSX, gvec_vvv, MO_8, do_vmaddwod_u_s)
 TRANS(vmaddwod_w_hu_h, LSX, gvec_vvv, MO_16, do_vmaddwod_u_s)
 TRANS(vmaddwod_d_wu_w, LSX, gvec_vvv, MO_32, do_vmaddwod_u_s)
+TRANS(xvmaddwod_h_bu_b, LASX, gvec_xxx, MO_8, do_vmaddwod_u_s)
+TRANS(xvmaddwod_w_hu_h, LASX, gvec_xxx, MO_16, do_vmaddwod_u_s)
+TRANS(xvmaddwod_d_wu_w, LASX, gvec_xxx, MO_32, do_vmaddwod_u_s)
 
 TRANS(vdiv_b, LSX, gen_vvv, gen_helper_vdiv_b)
 TRANS(vdiv_h, LSX, gen_vvv, gen_helper_vdiv_h)
-- 
2.39.1


