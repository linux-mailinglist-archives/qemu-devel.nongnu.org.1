Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E36417970EC
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 10:40:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeARo-0004od-Kd; Thu, 07 Sep 2023 04:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qeARc-0004cY-J3
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:32:56 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qeARX-0002OQ-5e
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:32:56 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxXeukivlkRDkhAA--.61083S3;
 Thu, 07 Sep 2023 16:32:36 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bxxsx+ivlk8FVwAA--.49124S42; 
 Thu, 07 Sep 2023 16:32:34 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH RESEND v5 40/57] target/loongarch: Implement xvssrln xvssran
Date: Thu,  7 Sep 2023 16:31:41 +0800
Message-Id: <20230907083158.3975132-41-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230907083158.3975132-1-gaosong@loongson.cn>
References: <20230907083158.3975132-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxxsx+ivlk8FVwAA--.49124S42
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
- XVSSRLN.{B.H/H.W/W.D};
- XVSSRAN.{B.H/H.W/W.D};
- XVSSRLN.{BU.H/HU.W/WU.D};
- XVSSRAN.{BU.H/HU.W/WU.D};
- XVSSRLNI.{B.H/H.W/W.D/D.Q};
- XVSSRANI.{B.H/H.W/W.D/D.Q};
- XVSSRLNI.{BU.H/HU.W/WU.D/DU.Q};
- XVSSRANI.{BU.H/HU.W/WU.D/DU.Q}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/insns.decode               |  30 ++
 target/loongarch/disas.c                    |  30 ++
 target/loongarch/vec_helper.c               | 456 ++++++++++++--------
 target/loongarch/insn_trans/trans_vec.c.inc |  28 ++
 4 files changed, 353 insertions(+), 191 deletions(-)

diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index d7c50b14ca..022dd9bfd1 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1710,6 +1710,36 @@ xvsrarni_h_w     0111 01110101 11001 ..... ..... .....    @vv_ui5
 xvsrarni_w_d     0111 01110101 1101 ...... ..... .....    @vv_ui6
 xvsrarni_d_q     0111 01110101 111 ....... ..... .....    @vv_ui7
 
+xvssrln_b_h      0111 01001111 11001 ..... ..... .....    @vvv
+xvssrln_h_w      0111 01001111 11010 ..... ..... .....    @vvv
+xvssrln_w_d      0111 01001111 11011 ..... ..... .....    @vvv
+xvssran_b_h      0111 01001111 11101 ..... ..... .....    @vvv
+xvssran_h_w      0111 01001111 11110 ..... ..... .....    @vvv
+xvssran_w_d      0111 01001111 11111 ..... ..... .....    @vvv
+xvssrln_bu_h     0111 01010000 01001 ..... ..... .....    @vvv
+xvssrln_hu_w     0111 01010000 01010 ..... ..... .....    @vvv
+xvssrln_wu_d     0111 01010000 01011 ..... ..... .....    @vvv
+xvssran_bu_h     0111 01010000 01101 ..... ..... .....    @vvv
+xvssran_hu_w     0111 01010000 01110 ..... ..... .....    @vvv
+xvssran_wu_d     0111 01010000 01111 ..... ..... .....    @vvv
+
+xvssrlni_b_h     0111 01110100 10000 1 .... ..... .....   @vv_ui4
+xvssrlni_h_w     0111 01110100 10001 ..... ..... .....    @vv_ui5
+xvssrlni_w_d     0111 01110100 1001 ...... ..... .....    @vv_ui6
+xvssrlni_d_q     0111 01110100 101 ....... ..... .....    @vv_ui7
+xvssrani_b_h     0111 01110110 00000 1 .... ..... .....   @vv_ui4
+xvssrani_h_w     0111 01110110 00001 ..... ..... .....    @vv_ui5
+xvssrani_w_d     0111 01110110 0001 ...... ..... .....    @vv_ui6
+xvssrani_d_q     0111 01110110 001 ....... ..... .....    @vv_ui7
+xvssrlni_bu_h    0111 01110100 11000 1 .... ..... .....   @vv_ui4
+xvssrlni_hu_w    0111 01110100 11001 ..... ..... .....    @vv_ui5
+xvssrlni_wu_d    0111 01110100 1101 ...... ..... .....    @vv_ui6
+xvssrlni_du_q    0111 01110100 111 ....... ..... .....    @vv_ui7
+xvssrani_bu_h    0111 01110110 01000 1 .... ..... .....   @vv_ui4
+xvssrani_hu_w    0111 01110110 01001 ..... ..... .....    @vv_ui5
+xvssrani_wu_d    0111 01110110 0101 ...... ..... .....    @vv_ui6
+xvssrani_du_q    0111 01110110 011 ....... ..... .....    @vv_ui7
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index e7b5974eaa..c02f31019f 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2136,6 +2136,36 @@ INSN_LASX(xvsrarni_h_w,      vv_i)
 INSN_LASX(xvsrarni_w_d,      vv_i)
 INSN_LASX(xvsrarni_d_q,      vv_i)
 
+INSN_LASX(xvssrln_b_h,       vvv)
+INSN_LASX(xvssrln_h_w,       vvv)
+INSN_LASX(xvssrln_w_d,       vvv)
+INSN_LASX(xvssran_b_h,       vvv)
+INSN_LASX(xvssran_h_w,       vvv)
+INSN_LASX(xvssran_w_d,       vvv)
+INSN_LASX(xvssrln_bu_h,      vvv)
+INSN_LASX(xvssrln_hu_w,      vvv)
+INSN_LASX(xvssrln_wu_d,      vvv)
+INSN_LASX(xvssran_bu_h,      vvv)
+INSN_LASX(xvssran_hu_w,      vvv)
+INSN_LASX(xvssran_wu_d,      vvv)
+
+INSN_LASX(xvssrlni_b_h,      vv_i)
+INSN_LASX(xvssrlni_h_w,      vv_i)
+INSN_LASX(xvssrlni_w_d,      vv_i)
+INSN_LASX(xvssrlni_d_q,      vv_i)
+INSN_LASX(xvssrani_b_h,      vv_i)
+INSN_LASX(xvssrani_h_w,      vv_i)
+INSN_LASX(xvssrani_w_d,      vv_i)
+INSN_LASX(xvssrani_d_q,      vv_i)
+INSN_LASX(xvssrlni_bu_h,     vv_i)
+INSN_LASX(xvssrlni_hu_w,     vv_i)
+INSN_LASX(xvssrlni_wu_d,     vv_i)
+INSN_LASX(xvssrlni_du_q,     vv_i)
+INSN_LASX(xvssrani_bu_h,     vv_i)
+INSN_LASX(xvssrani_hu_w,     vv_i)
+INSN_LASX(xvssrani_wu_d,     vv_i)
+INSN_LASX(xvssrani_du_q,     vv_i)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index a3f9b396fa..e8dd95eaed 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -1401,23 +1401,29 @@ SSRLNS(B, uint16_t, int16_t, uint8_t)
 SSRLNS(H, uint32_t, int32_t, uint16_t)
 SSRLNS(W, uint64_t, int64_t, uint32_t)
 
-#define VSSRLN(NAME, BIT, T, E1, E2)                                          \
-void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)                \
-{                                                                             \
-    int i;                                                                    \
-    VReg *Vd = (VReg *)vd;                                                    \
-    VReg *Vj = (VReg *)vj;                                                    \
-    VReg *Vk = (VReg *)vk;                                                    \
-                                                                              \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                                       \
-        Vd->E1(i) = do_ssrlns_ ## E1(Vj->E2(i), (T)Vk->E2(i)% BIT, BIT/2 -1); \
-    }                                                                         \
-    Vd->D(1) = 0;                                                             \
+#define VSSRLN(NAME, BIT, E1, E2, E3)                                       \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)              \
+{                                                                           \
+    int i, j, ofs;                                                          \
+    VReg *Vd = (VReg *)vd;                                                  \
+    VReg *Vj = (VReg *)vj;                                                  \
+    VReg *Vk = (VReg *)vk;                                                  \
+    int oprsz = simd_oprsz(desc);                                           \
+                                                                            \
+    ofs = LSX_LEN / BIT;                                                    \
+    for (i = 0; i < oprsz / 16; i++) {                                      \
+        for (j = 0; j < ofs; j++) {                                         \
+            Vd->E1(j + ofs * 2 * i) = do_ssrlns_ ## E1(Vj->E2(j + ofs * i), \
+                                                Vk->E3(j + ofs * i) % BIT,  \
+                                                BIT / 2 - 1);               \
+        }                                                                   \
+        Vd->D(2 * i + 1) = 0;                                               \
+    }                                                                       \
 }
 
-VSSRLN(vssrln_b_h, 16, uint16_t, B, H)
-VSSRLN(vssrln_h_w, 32, uint32_t, H, W)
-VSSRLN(vssrln_w_d, 64, uint64_t, W, D)
+VSSRLN(vssrln_b_h, 16, B, H, UH)
+VSSRLN(vssrln_h_w, 32, H, W, UW)
+VSSRLN(vssrln_w_d, 64, W, D, UD)
 
 #define SSRANS(E, T1, T2)                        \
 static T1 do_ssrans_ ## E(T1 e2, int sa, int sh) \
@@ -1429,10 +1435,10 @@ static T1 do_ssrans_ ## E(T1 e2, int sa, int sh) \
             shft_res = e2 >> sa;                 \
         }                                        \
         T2 mask;                                 \
-        mask = (1ll << sh) -1;                   \
+        mask = (1ll << sh) - 1;                  \
         if (shft_res > mask) {                   \
             return  mask;                        \
-        } else if (shft_res < -(mask +1)) {      \
+        } else if (shft_res < -(mask + 1)) {     \
             return  ~mask;                       \
         } else {                                 \
             return shft_res;                     \
@@ -1443,23 +1449,29 @@ SSRANS(B, int16_t, int8_t)
 SSRANS(H, int32_t, int16_t)
 SSRANS(W, int64_t, int32_t)
 
-#define VSSRAN(NAME, BIT, T, E1, E2)                                         \
-void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)               \
-{                                                                            \
-    int i;                                                                   \
-    VReg *Vd = (VReg *)vd;                                                   \
-    VReg *Vj = (VReg *)vj;                                                   \
-    VReg *Vk = (VReg *)vk;                                                   \
-                                                                             \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                                      \
-        Vd->E1(i) = do_ssrans_ ## E1(Vj->E2(i), (T)Vk->E2(i)%BIT, BIT/2 -1); \
-    }                                                                        \
-    Vd->D(1) = 0;                                                            \
+#define VSSRAN(NAME, BIT, E1, E2, E3)                                       \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)              \
+{                                                                           \
+    int i, j, ofs;                                                          \
+    VReg *Vd = (VReg *)vd;                                                  \
+    VReg *Vj = (VReg *)vj;                                                  \
+    VReg *Vk = (VReg *)vk;                                                  \
+    int oprsz = simd_oprsz(desc);                                           \
+                                                                            \
+    ofs = LSX_LEN / BIT;                                                    \
+    for (i = 0; i < oprsz / 16; i++) {                                      \
+        for (j = 0; j < ofs; j++) {                                         \
+            Vd->E1(j + ofs * 2 * i) = do_ssrans_ ## E1(Vj->E2(j + ofs * i), \
+                                                Vk->E3(j + ofs * i) % BIT,  \
+                                                BIT / 2 - 1);               \
+        }                                                                   \
+        Vd->D(2 * i + 1) = 0;                                               \
+    }                                                                       \
 }
 
-VSSRAN(vssran_b_h, 16, uint16_t, B, H)
-VSSRAN(vssran_h_w, 32, uint32_t, H, W)
-VSSRAN(vssran_w_d, 64, uint64_t, W, D)
+VSSRAN(vssran_b_h, 16, B, H, UH)
+VSSRAN(vssran_h_w, 32, H, W, UW)
+VSSRAN(vssran_w_d, 64, W, D, UD)
 
 #define SSRLNU(E, T1, T2, T3)                    \
 static T1 do_ssrlnu_ ## E(T3 e2, int sa, int sh) \
@@ -1471,7 +1483,7 @@ static T1 do_ssrlnu_ ## E(T3 e2, int sa, int sh) \
             shft_res = (((T1)e2) >> sa);         \
         }                                        \
         T2 mask;                                 \
-        mask = (1ull << sh) -1;                  \
+        mask = (1ull << sh) - 1;                 \
         if (shft_res > mask) {                   \
             return mask;                         \
         } else {                                 \
@@ -1483,23 +1495,29 @@ SSRLNU(B, uint16_t, uint8_t,  int16_t)
 SSRLNU(H, uint32_t, uint16_t, int32_t)
 SSRLNU(W, uint64_t, uint32_t, int64_t)
 
-#define VSSRLNU(NAME, BIT, T, E1, E2)                                     \
-void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)            \
-{                                                                         \
-    int i;                                                                \
-    VReg *Vd = (VReg *)vd;                                                \
-    VReg *Vj = (VReg *)vj;                                                \
-    VReg *Vk = (VReg *)vk;                                                \
-                                                                          \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                                   \
-        Vd->E1(i) = do_ssrlnu_ ## E1(Vj->E2(i), (T)Vk->E2(i)%BIT, BIT/2); \
-    }                                                                     \
-    Vd->D(1) = 0;                                                         \
+#define VSSRLNU(NAME, BIT, E1, E2, E3)                                      \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)              \
+{                                                                           \
+    int i, j, ofs;                                                          \
+    VReg *Vd = (VReg *)vd;                                                  \
+    VReg *Vj = (VReg *)vj;                                                  \
+    VReg *Vk = (VReg *)vk;                                                  \
+    int oprsz = simd_oprsz(desc);                                           \
+                                                                            \
+    ofs = LSX_LEN / BIT;                                                    \
+    for (i = 0; i < oprsz / 16; i++) {                                      \
+        for (j = 0; j < ofs; j++) {                                         \
+            Vd->E1(j + ofs * 2 * i) = do_ssrlnu_ ## E1(Vj->E2(j + ofs * i), \
+                                                Vk->E3(j + ofs * i) % BIT,  \
+                                                BIT / 2);                   \
+        }                                                                   \
+        Vd->D(2 * i + 1) = 0;                                               \
+    }                                                                       \
 }
 
-VSSRLNU(vssrln_bu_h, 16, uint16_t, B, H)
-VSSRLNU(vssrln_hu_w, 32, uint32_t, H, W)
-VSSRLNU(vssrln_wu_d, 64, uint64_t, W, D)
+VSSRLNU(vssrln_bu_h, 16, B, H, UH)
+VSSRLNU(vssrln_hu_w, 32, H, W, UW)
+VSSRLNU(vssrln_wu_d, 64, W, D, UD)
 
 #define SSRANU(E, T1, T2, T3)                    \
 static T1 do_ssranu_ ## E(T3 e2, int sa, int sh) \
@@ -1514,7 +1532,7 @@ static T1 do_ssranu_ ## E(T3 e2, int sa, int sh) \
             shft_res = 0;                        \
         }                                        \
         T2 mask;                                 \
-        mask = (1ull << sh) -1;                  \
+        mask = (1ull << sh) - 1;                 \
         if (shft_res > mask) {                   \
             return mask;                         \
         } else {                                 \
@@ -1526,64 +1544,89 @@ SSRANU(B, uint16_t, uint8_t,  int16_t)
 SSRANU(H, uint32_t, uint16_t, int32_t)
 SSRANU(W, uint64_t, uint32_t, int64_t)
 
-#define VSSRANU(NAME, BIT, T, E1, E2)                                     \
-void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)            \
-{                                                                         \
-    int i;                                                                \
-    VReg *Vd = (VReg *)vd;                                                \
-    VReg *Vj = (VReg *)vj;                                                \
-    VReg *Vk = (VReg *)vk;                                                \
-                                                                          \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                                   \
-        Vd->E1(i) = do_ssranu_ ## E1(Vj->E2(i), (T)Vk->E2(i)%BIT, BIT/2); \
-    }                                                                     \
-    Vd->D(1) = 0;                                                         \
-}
-
-VSSRANU(vssran_bu_h, 16, uint16_t, B, H)
-VSSRANU(vssran_hu_w, 32, uint32_t, H, W)
-VSSRANU(vssran_wu_d, 64, uint64_t, W, D)
-
-#define VSSRLNI(NAME, BIT, E1, E2)                                            \
-void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)            \
-{                                                                             \
-    int i;                                                                    \
-    VReg temp;                                                                \
-    VReg *Vd = (VReg *)vd;                                                    \
-    VReg *Vj = (VReg *)vj;                                                    \
-                                                                              \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                                       \
-        temp.E1(i) = do_ssrlns_ ## E1(Vj->E2(i), imm, BIT/2 -1);              \
-        temp.E1(i + LSX_LEN/BIT) = do_ssrlns_ ## E1(Vd->E2(i), imm, BIT/2 -1);\
-    }                                                                         \
-    *Vd = temp;                                                               \
+#define VSSRANU(NAME, BIT, E1, E2, E3)                                         \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)                 \
+{                                                                              \
+    int i, j, ofs;                                                             \
+    VReg *Vd = (VReg *)vd;                                                     \
+    VReg *Vj = (VReg *)vj;                                                     \
+    VReg *Vk = (VReg *)vk;                                                     \
+    int oprsz = simd_oprsz(desc);                                              \
+                                                                               \
+    ofs = LSX_LEN / BIT;                                                       \
+    for (i = 0; i < oprsz / 16; i++) {                                         \
+        for (j = 0; j < ofs; j++) {                                            \
+            Vd->E1(j + ofs * 2 * i) = do_ssranu_ ## E1(Vj->E2(j + ofs * i),    \
+                                                    Vk->E3(j + ofs * i) % BIT, \
+                                                    BIT / 2);                  \
+        }                                                                      \
+        Vd->D(2 * i + 1) = 0;                                                  \
+    }                                                                          \
 }
 
-void HELPER(vssrlni_d_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
-{
-    Int128 shft_res1, shft_res2, mask;
-    VReg *Vd = (VReg *)vd;
-    VReg *Vj = (VReg *)vj;
+VSSRANU(vssran_bu_h, 16, B, H, UH)
+VSSRANU(vssran_hu_w, 32, H, W, UW)
+VSSRANU(vssran_wu_d, 64, W, D, UD)
+
+#define VSSRLNI(NAME, BIT, E1, E2)                                                 \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)                 \
+{                                                                                  \
+    int i, j, ofs;                                                                 \
+    VReg temp = {};                                                                \
+    VReg *Vd = (VReg *)vd;                                                         \
+    VReg *Vj = (VReg *)vj;                                                         \
+    int oprsz = simd_oprsz(desc);                                                  \
+                                                                                   \
+    ofs = LSX_LEN / BIT;                                                           \
+    for (i = 0; i < oprsz / 16; i++) {                                             \
+        for (j = 0; j < ofs; j++) {                                                \
+            temp.E1(j + ofs * 2 * i) = do_ssrlns_ ## E1(Vj->E2(j + ofs * i),       \
+                                                     imm, BIT / 2 - 1);            \
+            temp.E1(j + ofs * (2 * i + 1)) = do_ssrlns_ ## E1(Vd->E2(j + ofs * i), \
+                                                           imm, BIT / 2 - 1);      \
+        }                                                                          \
+    }                                                                              \
+    *Vd = temp;                                                                    \
+}
+
+static void do_vssrlni_q(VReg *Vd, VReg *Vj,
+                         uint64_t imm, int idx, Int128 mask)
+{
+    Int128 shft_res1, shft_res2;
 
     if (imm == 0) {
-        shft_res1 = Vj->Q(0);
-        shft_res2 = Vd->Q(0);
+        shft_res1 = Vj->Q(idx);
+        shft_res2 = Vd->Q(idx);
     } else {
-        shft_res1 = int128_urshift(Vj->Q(0), imm);
-        shft_res2 = int128_urshift(Vd->Q(0), imm);
+        shft_res1 = int128_urshift(Vj->Q(idx), imm);
+        shft_res2 = int128_urshift(Vd->Q(idx), imm);
     }
-    mask = int128_sub(int128_lshift(int128_one(), 63), int128_one());
 
     if (int128_ult(mask, shft_res1)) {
-        Vd->D(0) = int128_getlo(mask);
+        Vd->D(idx * 2) = int128_getlo(mask);
     }else {
-        Vd->D(0) = int128_getlo(shft_res1);
+        Vd->D(idx * 2) = int128_getlo(shft_res1);
     }
 
     if (int128_ult(mask, shft_res2)) {
-        Vd->D(1) = int128_getlo(mask);
+        Vd->D(idx * 2 + 1) = int128_getlo(mask);
     }else {
-        Vd->D(1) = int128_getlo(shft_res2);
+        Vd->D(idx * 2 + 1) = int128_getlo(shft_res2);
+    }
+}
+
+void HELPER(vssrlni_d_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
+{
+    int i;
+    Int128 mask;
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
+    int oprsz = simd_oprsz(desc);
+
+    mask = int128_sub(int128_lshift(int128_one(), 63), int128_one());
+
+    for (i = 0; i < oprsz / 16; i++) {
+        do_vssrlni_q(Vd, Vj, imm, i, mask);
     }
 }
 
@@ -1591,98 +1634,111 @@ VSSRLNI(vssrlni_b_h, 16, B, H)
 VSSRLNI(vssrlni_h_w, 32, H, W)
 VSSRLNI(vssrlni_w_d, 64, W, D)
 
-#define VSSRANI(NAME, BIT, E1, E2)                                             \
-void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)             \
-{                                                                              \
-    int i;                                                                     \
-    VReg temp;                                                                 \
-    VReg *Vd = (VReg *)vd;                                                     \
-    VReg *Vj = (VReg *)vj;                                                     \
-                                                                               \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                                        \
-        temp.E1(i) = do_ssrans_ ## E1(Vj->E2(i), imm, BIT/2 -1);               \
-        temp.E1(i + LSX_LEN/BIT) = do_ssrans_ ## E1(Vd->E2(i), imm, BIT/2 -1); \
-    }                                                                          \
-    *Vd = temp;                                                                \
-}
-
-void HELPER(vssrani_d_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
-{
-    Int128 shft_res1, shft_res2, mask, min;
-    VReg *Vd = (VReg *)vd;
-    VReg *Vj = (VReg *)vj;
+#define VSSRANI(NAME, BIT, E1, E2)                                                 \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)                 \
+{                                                                                  \
+    int i, j, ofs;                                                                 \
+    VReg temp = {};                                                                \
+    VReg *Vd = (VReg *)vd;                                                         \
+    VReg *Vj = (VReg *)vj;                                                         \
+    int oprsz = simd_oprsz(desc);                                                  \
+                                                                                   \
+    ofs = LSX_LEN / BIT;                                                           \
+    for (i = 0; i < oprsz / 16; i++) {                                             \
+        for (j = 0; j < ofs; j++) {                                                \
+            temp.E1(j + ofs * 2 * i) = do_ssrans_ ## E1(Vj->E2(j + ofs * i),       \
+                                                        imm, BIT / 2 - 1);         \
+            temp.E1(j + ofs * (2 * i + 1)) = do_ssrans_ ## E1(Vd->E2(j + ofs * i), \
+                                                              imm, BIT / 2 - 1);   \
+        }                                                                          \
+    }                                                                              \
+    *Vd = temp;                                                                    \
+}
+
+static void do_vssrani_d_q(VReg *Vd, VReg *Vj,
+                           uint64_t imm, int idx, Int128 mask, Int128 min)
+{
+    Int128 shft_res1, shft_res2;
 
     if (imm == 0) {
-        shft_res1 = Vj->Q(0);
-        shft_res2 = Vd->Q(0);
+        shft_res1 = Vj->Q(idx);
+        shft_res2 = Vd->Q(idx);
     } else {
-        shft_res1 = int128_rshift(Vj->Q(0), imm);
-        shft_res2 = int128_rshift(Vd->Q(0), imm);
+        shft_res1 = int128_rshift(Vj->Q(idx), imm);
+        shft_res2 = int128_rshift(Vd->Q(idx), imm);
     }
-    mask = int128_sub(int128_lshift(int128_one(), 63), int128_one());
-    min  = int128_lshift(int128_one(), 63);
 
-    if (int128_gt(shft_res1,  mask)) {
-        Vd->D(0) = int128_getlo(mask);
+    if (int128_gt(shft_res1, mask)) {
+        Vd->D(idx * 2) = int128_getlo(mask);
     } else if (int128_lt(shft_res1, int128_neg(min))) {
-        Vd->D(0) = int128_getlo(min);
+        Vd->D(idx * 2) = int128_getlo(min);
     } else {
-        Vd->D(0) = int128_getlo(shft_res1);
+        Vd->D(idx * 2) = int128_getlo(shft_res1);
     }
 
     if (int128_gt(shft_res2, mask)) {
-        Vd->D(1) = int128_getlo(mask);
+        Vd->D(idx * 2 + 1) = int128_getlo(mask);
     } else if (int128_lt(shft_res2, int128_neg(min))) {
-        Vd->D(1) = int128_getlo(min);
+        Vd->D(idx * 2 + 1) = int128_getlo(min);
     } else {
-        Vd->D(1) = int128_getlo(shft_res2);
+        Vd->D(idx * 2 + 1) = int128_getlo(shft_res2);
+    }
+}
+
+void HELPER(vssrani_d_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
+{
+    int i;
+    Int128 mask, min;
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
+    int oprsz = simd_oprsz(desc);
+
+    mask = int128_sub(int128_lshift(int128_one(), 63), int128_one());
+    min  = int128_lshift(int128_one(), 63);
+
+    for (i = 0; i < oprsz / 16; i++) {
+        do_vssrani_d_q(Vd, Vj, imm, i, mask, min);
     }
 }
 
+
 VSSRANI(vssrani_b_h, 16, B, H)
 VSSRANI(vssrani_h_w, 32, H, W)
 VSSRANI(vssrani_w_d, 64, W, D)
 
-#define VSSRLNUI(NAME, BIT, E1, E2)                                         \
-void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)          \
-{                                                                           \
-    int i;                                                                  \
-    VReg temp;                                                              \
-    VReg *Vd = (VReg *)vd;                                                  \
-    VReg *Vj = (VReg *)vj;                                                  \
-                                                                            \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                                     \
-        temp.E1(i) = do_ssrlnu_ ## E1(Vj->E2(i), imm, BIT/2);               \
-        temp.E1(i + LSX_LEN/BIT) = do_ssrlnu_ ## E1(Vd->E2(i), imm, BIT/2); \
-    }                                                                       \
-    *Vd = temp;                                                             \
+#define VSSRLNUI(NAME, BIT, E1, E2)                                                \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)                 \
+{                                                                                  \
+    int i, j, ofs;                                                                 \
+    VReg temp = {};                                                                \
+    VReg *Vd = (VReg *)vd;                                                         \
+    VReg *Vj = (VReg *)vj;                                                         \
+    int oprsz = simd_oprsz(desc);                                                  \
+                                                                                   \
+    ofs = LSX_LEN / BIT;                                                           \
+    for (i = 0; i < oprsz / 16; i++) {                                             \
+        for (j = 0; j < ofs; j++) {                                                \
+            temp.E1(j + ofs * 2 * i) = do_ssrlnu_ ## E1(Vj->E2(j + ofs * i),       \
+                                                        imm, BIT / 2);             \
+            temp.E1(j + ofs * (2 * i + 1)) = do_ssrlnu_ ## E1(Vd->E2(j + ofs * i), \
+                                                              imm, BIT / 2);       \
+        }                                                                          \
+    }                                                                              \
+    *Vd = temp;                                                                    \
 }
 
 void HELPER(vssrlni_du_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
 {
-    Int128 shft_res1, shft_res2, mask;
+    int i;
+    Int128 mask;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
+    int oprsz = simd_oprsz(desc);
 
-    if (imm == 0) {
-        shft_res1 = Vj->Q(0);
-        shft_res2 = Vd->Q(0);
-    } else {
-        shft_res1 = int128_urshift(Vj->Q(0), imm);
-        shft_res2 = int128_urshift(Vd->Q(0), imm);
-    }
     mask = int128_sub(int128_lshift(int128_one(), 64), int128_one());
 
-    if (int128_ult(mask, shft_res1)) {
-        Vd->D(0) = int128_getlo(mask);
-    }else {
-        Vd->D(0) = int128_getlo(shft_res1);
-    }
-
-    if (int128_ult(mask, shft_res2)) {
-        Vd->D(1) = int128_getlo(mask);
-    }else {
-        Vd->D(1) = int128_getlo(shft_res2);
+    for (i = 0; i < oprsz / 16; i++) {
+        do_vssrlni_q(Vd, Vj, imm, i, mask);
     }
 }
 
@@ -1690,55 +1746,73 @@ VSSRLNUI(vssrlni_bu_h, 16, B, H)
 VSSRLNUI(vssrlni_hu_w, 32, H, W)
 VSSRLNUI(vssrlni_wu_d, 64, W, D)
 
-#define VSSRANUI(NAME, BIT, E1, E2)                                         \
-void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)          \
-{                                                                           \
-    int i;                                                                  \
-    VReg temp;                                                              \
-    VReg *Vd = (VReg *)vd;                                                  \
-    VReg *Vj = (VReg *)vj;                                                  \
-                                                                            \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                                     \
-        temp.E1(i) = do_ssranu_ ## E1(Vj->E2(i), imm, BIT/2);               \
-        temp.E1(i + LSX_LEN/BIT) = do_ssranu_ ## E1(Vd->E2(i), imm, BIT/2); \
-    }                                                                       \
-    *Vd = temp;                                                             \
-}
-
-void HELPER(vssrani_du_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
-{
-    Int128 shft_res1, shft_res2, mask;
-    VReg *Vd = (VReg *)vd;
-    VReg *Vj = (VReg *)vj;
+#define VSSRANUI(NAME, BIT, E1, E2)                                                \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)                 \
+{                                                                                  \
+    int i, j, ofs;                                                                 \
+    VReg temp = {};                                                                \
+    VReg *Vd = (VReg *)vd;                                                         \
+    VReg *Vj = (VReg *)vj;                                                         \
+    int oprsz = simd_oprsz(desc);                                                  \
+                                                                                   \
+    ofs = LSX_LEN / BIT;                                                           \
+    for (i = 0; i < oprsz / 16; i++) {                                             \
+        for (j = 0; j < ofs; j++) {                                                \
+            temp.E1(j + ofs * 2 * i) = do_ssranu_ ## E1(Vj->E2(j + ofs * i),       \
+                                                        imm, BIT / 2);             \
+            temp.E1(j + ofs * (2 * i + 1)) = do_ssranu_ ## E1(Vd->E2(j + ofs * i), \
+                                                              imm, BIT / 2);       \
+        }                                                                          \
+    }                                                                              \
+    *Vd = temp;                                                                    \
+}
+
+static void do_vssrani_du_q(VReg *Vd, VReg *Vj,
+                            uint64_t imm, int idx, Int128 mask)
+{
+    Int128 shft_res1, shft_res2;
 
     if (imm == 0) {
-        shft_res1 = Vj->Q(0);
-        shft_res2 = Vd->Q(0);
+        shft_res1 = Vj->Q(idx);
+        shft_res2 = Vd->Q(idx);
     } else {
-        shft_res1 = int128_rshift(Vj->Q(0), imm);
-        shft_res2 = int128_rshift(Vd->Q(0), imm);
+        shft_res1 = int128_rshift(Vj->Q(idx), imm);
+        shft_res2 = int128_rshift(Vd->Q(idx), imm);
     }
 
-    if (int128_lt(Vj->Q(0), int128_zero())) {
+    if (int128_lt(Vj->Q(idx), int128_zero())) {
         shft_res1 = int128_zero();
     }
 
-    if (int128_lt(Vd->Q(0), int128_zero())) {
+    if (int128_lt(Vd->Q(idx), int128_zero())) {
         shft_res2 = int128_zero();
     }
-
-    mask = int128_sub(int128_lshift(int128_one(), 64), int128_one());
-
     if (int128_ult(mask, shft_res1)) {
-        Vd->D(0) = int128_getlo(mask);
+        Vd->D(idx * 2) = int128_getlo(mask);
     }else {
-        Vd->D(0) = int128_getlo(shft_res1);
+        Vd->D(idx * 2) = int128_getlo(shft_res1);
     }
 
     if (int128_ult(mask, shft_res2)) {
-        Vd->D(1) = int128_getlo(mask);
+        Vd->D(idx * 2 + 1) = int128_getlo(mask);
     }else {
-        Vd->D(1) = int128_getlo(shft_res2);
+        Vd->D(idx * 2 + 1) = int128_getlo(shft_res2);
+    }
+
+}
+
+void HELPER(vssrani_du_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
+{
+    int i;
+    Int128 mask;
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
+    int oprsz = simd_oprsz(desc);
+
+    mask = int128_sub(int128_lshift(int128_one(), 64), int128_one());
+
+    for (i = 0; i < oprsz / 16; i++) {
+        do_vssrani_du_q(Vd, Vj, imm, i, mask);
     }
 }
 
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index c60a48a16a..952f7fdc46 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -3901,6 +3901,18 @@ TRANS(vssrln_wu_d, LSX, gen_vvv, gen_helper_vssrln_wu_d)
 TRANS(vssran_bu_h, LSX, gen_vvv, gen_helper_vssran_bu_h)
 TRANS(vssran_hu_w, LSX, gen_vvv, gen_helper_vssran_hu_w)
 TRANS(vssran_wu_d, LSX, gen_vvv, gen_helper_vssran_wu_d)
+TRANS(xvssrln_b_h, LASX, gen_xxx, gen_helper_vssrln_b_h)
+TRANS(xvssrln_h_w, LASX, gen_xxx, gen_helper_vssrln_h_w)
+TRANS(xvssrln_w_d, LASX, gen_xxx, gen_helper_vssrln_w_d)
+TRANS(xvssran_b_h, LASX, gen_xxx, gen_helper_vssran_b_h)
+TRANS(xvssran_h_w, LASX, gen_xxx, gen_helper_vssran_h_w)
+TRANS(xvssran_w_d, LASX, gen_xxx, gen_helper_vssran_w_d)
+TRANS(xvssrln_bu_h, LASX, gen_xxx, gen_helper_vssrln_bu_h)
+TRANS(xvssrln_hu_w, LASX, gen_xxx, gen_helper_vssrln_hu_w)
+TRANS(xvssrln_wu_d, LASX, gen_xxx, gen_helper_vssrln_wu_d)
+TRANS(xvssran_bu_h, LASX, gen_xxx, gen_helper_vssran_bu_h)
+TRANS(xvssran_hu_w, LASX, gen_xxx, gen_helper_vssran_hu_w)
+TRANS(xvssran_wu_d, LASX, gen_xxx, gen_helper_vssran_wu_d)
 
 TRANS(vssrlni_b_h, LSX, gen_vv_i, gen_helper_vssrlni_b_h)
 TRANS(vssrlni_h_w, LSX, gen_vv_i, gen_helper_vssrlni_h_w)
@@ -3918,6 +3930,22 @@ TRANS(vssrani_bu_h, LSX, gen_vv_i, gen_helper_vssrani_bu_h)
 TRANS(vssrani_hu_w, LSX, gen_vv_i, gen_helper_vssrani_hu_w)
 TRANS(vssrani_wu_d, LSX, gen_vv_i, gen_helper_vssrani_wu_d)
 TRANS(vssrani_du_q, LSX, gen_vv_i, gen_helper_vssrani_du_q)
+TRANS(xvssrlni_b_h, LASX, gen_xx_i, gen_helper_vssrlni_b_h)
+TRANS(xvssrlni_h_w, LASX, gen_xx_i, gen_helper_vssrlni_h_w)
+TRANS(xvssrlni_w_d, LASX, gen_xx_i, gen_helper_vssrlni_w_d)
+TRANS(xvssrlni_d_q, LASX, gen_xx_i, gen_helper_vssrlni_d_q)
+TRANS(xvssrani_b_h, LASX, gen_xx_i, gen_helper_vssrani_b_h)
+TRANS(xvssrani_h_w, LASX, gen_xx_i, gen_helper_vssrani_h_w)
+TRANS(xvssrani_w_d, LASX, gen_xx_i, gen_helper_vssrani_w_d)
+TRANS(xvssrani_d_q, LASX, gen_xx_i, gen_helper_vssrani_d_q)
+TRANS(xvssrlni_bu_h, LASX, gen_xx_i, gen_helper_vssrlni_bu_h)
+TRANS(xvssrlni_hu_w, LASX, gen_xx_i, gen_helper_vssrlni_hu_w)
+TRANS(xvssrlni_wu_d, LASX, gen_xx_i, gen_helper_vssrlni_wu_d)
+TRANS(xvssrlni_du_q, LASX, gen_xx_i, gen_helper_vssrlni_du_q)
+TRANS(xvssrani_bu_h, LASX, gen_xx_i, gen_helper_vssrani_bu_h)
+TRANS(xvssrani_hu_w, LASX, gen_xx_i, gen_helper_vssrani_hu_w)
+TRANS(xvssrani_wu_d, LASX, gen_xx_i, gen_helper_vssrani_wu_d)
+TRANS(xvssrani_du_q, LASX, gen_xx_i, gen_helper_vssrani_du_q)
 
 TRANS(vssrlrn_b_h, LSX, gen_vvv, gen_helper_vssrlrn_b_h)
 TRANS(vssrlrn_h_w, LSX, gen_vvv, gen_helper_vssrlrn_h_w)
-- 
2.39.1


