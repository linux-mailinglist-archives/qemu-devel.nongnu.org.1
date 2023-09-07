Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A057970D6
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 10:38:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeARi-0004lz-3A; Thu, 07 Sep 2023 04:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qeARZ-0004SM-6n
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:32:53 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qeARU-0002NS-Ld
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:32:52 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxNvGkivlkPzkhAA--.438S3;
 Thu, 07 Sep 2023 16:32:36 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bxxsx+ivlk8FVwAA--.49124S43; 
 Thu, 07 Sep 2023 16:32:35 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH RESEND v5 41/57] target/loongarch: Implement xvssrlrn xvssrarn
Date: Thu,  7 Sep 2023 16:31:42 +0800
Message-Id: <20230907083158.3975132-42-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230907083158.3975132-1-gaosong@loongson.cn>
References: <20230907083158.3975132-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxxsx+ivlk8FVwAA--.49124S43
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
- XVSSRLRN.{B.H/H.W/W.D};
- XVSSRARN.{B.H/H.W/W.D};
- XVSSRLRN.{BU.H/HU.W/WU.D};
- XVSSRARN.{BU.H/HU.W/WU.D};
- XVSSRLRNI.{B.H/H.W/W.D/D.Q};
- XVSSRARNI.{B.H/H.W/W.D/D.Q};
- XVSSRLRNI.{BU.H/HU.W/WU.D/DU.Q};
- XVSSRARNI.{BU.H/HU.W/WU.D/DU.Q}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/insns.decode               |  30 ++
 target/loongarch/disas.c                    |  30 ++
 target/loongarch/vec_helper.c               | 489 ++++++++++++--------
 target/loongarch/insn_trans/trans_vec.c.inc |  28 ++
 4 files changed, 378 insertions(+), 199 deletions(-)

diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 022dd9bfd1..dc74bae7a5 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1740,6 +1740,36 @@ xvssrani_hu_w    0111 01110110 01001 ..... ..... .....    @vv_ui5
 xvssrani_wu_d    0111 01110110 0101 ...... ..... .....    @vv_ui6
 xvssrani_du_q    0111 01110110 011 ....... ..... .....    @vv_ui7
 
+xvssrlrn_b_h     0111 01010000 00001 ..... ..... .....    @vvv
+xvssrlrn_h_w     0111 01010000 00010 ..... ..... .....    @vvv
+xvssrlrn_w_d     0111 01010000 00011 ..... ..... .....    @vvv
+xvssrarn_b_h     0111 01010000 00101 ..... ..... .....    @vvv
+xvssrarn_h_w     0111 01010000 00110 ..... ..... .....    @vvv
+xvssrarn_w_d     0111 01010000 00111 ..... ..... .....    @vvv
+xvssrlrn_bu_h    0111 01010000 10001 ..... ..... .....    @vvv
+xvssrlrn_hu_w    0111 01010000 10010 ..... ..... .....    @vvv
+xvssrlrn_wu_d    0111 01010000 10011 ..... ..... .....    @vvv
+xvssrarn_bu_h    0111 01010000 10101 ..... ..... .....    @vvv
+xvssrarn_hu_w    0111 01010000 10110 ..... ..... .....    @vvv
+xvssrarn_wu_d    0111 01010000 10111 ..... ..... .....    @vvv
+
+xvssrlrni_b_h    0111 01110101 00000 1 .... ..... .....   @vv_ui4
+xvssrlrni_h_w    0111 01110101 00001 ..... ..... .....    @vv_ui5
+xvssrlrni_w_d    0111 01110101 0001 ...... ..... .....    @vv_ui6
+xvssrlrni_d_q    0111 01110101 001 ....... ..... .....    @vv_ui7
+xvssrarni_b_h    0111 01110110 10000 1 .... ..... .....   @vv_ui4
+xvssrarni_h_w    0111 01110110 10001 ..... ..... .....    @vv_ui5
+xvssrarni_w_d    0111 01110110 1001 ...... ..... .....    @vv_ui6
+xvssrarni_d_q    0111 01110110 101 ....... ..... .....    @vv_ui7
+xvssrlrni_bu_h   0111 01110101 01000 1 .... ..... .....   @vv_ui4
+xvssrlrni_hu_w   0111 01110101 01001 ..... ..... .....    @vv_ui5
+xvssrlrni_wu_d   0111 01110101 0101 ...... ..... .....    @vv_ui6
+xvssrlrni_du_q   0111 01110101 011 ....... ..... .....    @vv_ui7
+xvssrarni_bu_h   0111 01110110 11000 1 .... ..... .....   @vv_ui4
+xvssrarni_hu_w   0111 01110110 11001 ..... ..... .....    @vv_ui5
+xvssrarni_wu_d   0111 01110110 1101 ...... ..... .....    @vv_ui6
+xvssrarni_du_q   0111 01110110 111 ....... ..... .....    @vv_ui7
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index c02f31019f..421eecbb71 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2166,6 +2166,36 @@ INSN_LASX(xvssrani_hu_w,     vv_i)
 INSN_LASX(xvssrani_wu_d,     vv_i)
 INSN_LASX(xvssrani_du_q,     vv_i)
 
+INSN_LASX(xvssrlrn_b_h,      vvv)
+INSN_LASX(xvssrlrn_h_w,      vvv)
+INSN_LASX(xvssrlrn_w_d,      vvv)
+INSN_LASX(xvssrarn_b_h,      vvv)
+INSN_LASX(xvssrarn_h_w,      vvv)
+INSN_LASX(xvssrarn_w_d,      vvv)
+INSN_LASX(xvssrlrn_bu_h,     vvv)
+INSN_LASX(xvssrlrn_hu_w,     vvv)
+INSN_LASX(xvssrlrn_wu_d,     vvv)
+INSN_LASX(xvssrarn_bu_h,     vvv)
+INSN_LASX(xvssrarn_hu_w,     vvv)
+INSN_LASX(xvssrarn_wu_d,     vvv)
+
+INSN_LASX(xvssrlrni_b_h,     vv_i)
+INSN_LASX(xvssrlrni_h_w,     vv_i)
+INSN_LASX(xvssrlrni_w_d,     vv_i)
+INSN_LASX(xvssrlrni_d_q,     vv_i)
+INSN_LASX(xvssrlrni_bu_h,    vv_i)
+INSN_LASX(xvssrlrni_hu_w,    vv_i)
+INSN_LASX(xvssrlrni_wu_d,    vv_i)
+INSN_LASX(xvssrlrni_du_q,    vv_i)
+INSN_LASX(xvssrarni_b_h,     vv_i)
+INSN_LASX(xvssrarni_h_w,     vv_i)
+INSN_LASX(xvssrarni_w_d,     vv_i)
+INSN_LASX(xvssrarni_d_q,     vv_i)
+INSN_LASX(xvssrarni_bu_h,    vv_i)
+INSN_LASX(xvssrarni_hu_w,    vv_i)
+INSN_LASX(xvssrarni_wu_d,    vv_i)
+INSN_LASX(xvssrarni_du_q,    vv_i)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index e8dd95eaed..53dc53cb09 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -1827,7 +1827,7 @@ static T1 do_ssrlrns_ ## E1(T2 e2, int sa, int sh) \
                                                    \
     shft_res = do_vsrlr_ ## E2(e2, sa);            \
     T1 mask;                                       \
-    mask = (1ull << sh) -1;                        \
+    mask = (1ull << sh) - 1;                       \
     if (shft_res > mask) {                         \
         return mask;                               \
     } else {                                       \
@@ -1839,23 +1839,29 @@ SSRLRNS(B, H, uint16_t, int16_t, uint8_t)
 SSRLRNS(H, W, uint32_t, int32_t, uint16_t)
 SSRLRNS(W, D, uint64_t, int64_t, uint32_t)
 
-#define VSSRLRN(NAME, BIT, T, E1, E2)                                         \
-void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)                \
-{                                                                             \
-    int i;                                                                    \
-    VReg *Vd = (VReg *)vd;                                                    \
-    VReg *Vj = (VReg *)vj;                                                    \
-    VReg *Vk = (VReg *)vk;                                                    \
-                                                                              \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                                       \
-        Vd->E1(i) = do_ssrlrns_ ## E1(Vj->E2(i), (T)Vk->E2(i)%BIT, BIT/2 -1); \
-    }                                                                         \
-    Vd->D(1) = 0;                                                             \
+#define VSSRLRN(NAME, BIT, E1, E2, E3)                                         \
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
+            Vd->E1(j + ofs * 2 * i) = do_ssrlrns_ ## E1(Vj->E2(j + ofs * i),   \
+                                                    Vk->E3(j + ofs * i) % BIT, \
+                                                    BIT / 2 - 1);              \
+        }                                                                      \
+        Vd->D(2 * i + 1) = 0;                                                  \
+    }                                                                          \
 }
 
-VSSRLRN(vssrlrn_b_h, 16, uint16_t, B, H)
-VSSRLRN(vssrlrn_h_w, 32, uint32_t, H, W)
-VSSRLRN(vssrlrn_w_d, 64, uint64_t, W, D)
+VSSRLRN(vssrlrn_b_h, 16, B, H, UH)
+VSSRLRN(vssrlrn_h_w, 32, H, W, UW)
+VSSRLRN(vssrlrn_w_d, 64, W, D, UD)
 
 #define SSRARNS(E1, E2, T1, T2)                    \
 static T1 do_ssrarns_ ## E1(T1 e2, int sa, int sh) \
@@ -1864,7 +1870,7 @@ static T1 do_ssrarns_ ## E1(T1 e2, int sa, int sh) \
                                                    \
     shft_res = do_vsrar_ ## E2(e2, sa);            \
     T2 mask;                                       \
-    mask = (1ll << sh) -1;                         \
+    mask = (1ll << sh) - 1;                        \
     if (shft_res > mask) {                         \
         return  mask;                              \
     } else if (shft_res < -(mask +1)) {            \
@@ -1878,23 +1884,29 @@ SSRARNS(B, H, int16_t, int8_t)
 SSRARNS(H, W, int32_t, int16_t)
 SSRARNS(W, D, int64_t, int32_t)
 
-#define VSSRARN(NAME, BIT, T, E1, E2)                                         \
-void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)                \
-{                                                                             \
-    int i;                                                                    \
-    VReg *Vd = (VReg *)vd;                                                    \
-    VReg *Vj = (VReg *)vj;                                                    \
-    VReg *Vk = (VReg *)vk;                                                    \
-                                                                              \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                                       \
-        Vd->E1(i) = do_ssrarns_ ## E1(Vj->E2(i), (T)Vk->E2(i)%BIT, BIT/2 -1); \
-    }                                                                         \
-    Vd->D(1) = 0;                                                             \
+#define VSSRARN(NAME, BIT, E1, E2, E3)                                         \
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
+            Vd->E1(j + ofs * 2 * i) = do_ssrarns_ ## E1(Vj->E2(j + ofs * i),   \
+                                                    Vk->E3(j + ofs * i) % BIT, \
+                                                    BIT/ 2 - 1);               \
+        }                                                                      \
+        Vd->D(2 * i + 1) = 0;                                                  \
+    }                                                                          \
 }
 
-VSSRARN(vssrarn_b_h, 16, uint16_t, B, H)
-VSSRARN(vssrarn_h_w, 32, uint32_t, H, W)
-VSSRARN(vssrarn_w_d, 64, uint64_t, W, D)
+VSSRARN(vssrarn_b_h, 16, B, H, UH)
+VSSRARN(vssrarn_h_w, 32, H, W, UW)
+VSSRARN(vssrarn_w_d, 64, W, D, UD)
 
 #define SSRLRNU(E1, E2, T1, T2, T3)                \
 static T1 do_ssrlrnu_ ## E1(T3 e2, int sa, int sh) \
@@ -1904,7 +1916,7 @@ static T1 do_ssrlrnu_ ## E1(T3 e2, int sa, int sh) \
     shft_res = do_vsrlr_ ## E2(e2, sa);            \
                                                    \
     T2 mask;                                       \
-    mask = (1ull << sh) -1;                        \
+    mask = (1ull << sh) - 1;                       \
     if (shft_res > mask) {                         \
         return mask;                               \
     } else {                                       \
@@ -1916,23 +1928,29 @@ SSRLRNU(B, H, uint16_t, uint8_t, int16_t)
 SSRLRNU(H, W, uint32_t, uint16_t, int32_t)
 SSRLRNU(W, D, uint64_t, uint32_t, int64_t)
 
-#define VSSRLRNU(NAME, BIT, T, E1, E2)                                     \
-void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)             \
-{                                                                          \
-    int i;                                                                 \
-    VReg *Vd = (VReg *)vd;                                                 \
-    VReg *Vj = (VReg *)vj;                                                 \
-    VReg *Vk = (VReg *)vk;                                                 \
-                                                                           \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                                    \
-        Vd->E1(i) = do_ssrlrnu_ ## E1(Vj->E2(i), (T)Vk->E2(i)%BIT, BIT/2); \
-    }                                                                      \
-    Vd->D(1) = 0;                                                          \
+#define VSSRLRNU(NAME, BIT, E1, E2, E3)                                        \
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
+            Vd->E1(j + ofs * 2 * i) = do_ssrlrnu_ ## E1(Vj->E2(j + ofs * i),   \
+                                                    Vk->E3(j + ofs * i) % BIT, \
+                                                    BIT / 2);                  \
+        }                                                                      \
+        Vd->D(2 * i + 1) = 0;                                                  \
+    }                                                                          \
 }
 
-VSSRLRNU(vssrlrn_bu_h, 16, uint16_t, B, H)
-VSSRLRNU(vssrlrn_hu_w, 32, uint32_t, H, W)
-VSSRLRNU(vssrlrn_wu_d, 64, uint64_t, W, D)
+VSSRLRNU(vssrlrn_bu_h, 16, B, H, UH)
+VSSRLRNU(vssrlrn_hu_w, 32, H, W, UW)
+VSSRLRNU(vssrlrn_wu_d, 64, W, D, UD)
 
 #define SSRARNU(E1, E2, T1, T2, T3)                \
 static T1 do_ssrarnu_ ## E1(T3 e2, int sa, int sh) \
@@ -1945,7 +1963,7 @@ static T1 do_ssrarnu_ ## E1(T3 e2, int sa, int sh) \
         shft_res = do_vsrar_ ## E2(e2, sa);        \
     }                                              \
     T2 mask;                                       \
-    mask = (1ull << sh) -1;                        \
+    mask = (1ull << sh) - 1;                       \
     if (shft_res > mask) {                         \
         return mask;                               \
     } else {                                       \
@@ -1957,126 +1975,162 @@ SSRARNU(B, H, uint16_t, uint8_t, int16_t)
 SSRARNU(H, W, uint32_t, uint16_t, int32_t)
 SSRARNU(W, D, uint64_t, uint32_t, int64_t)
 
-#define VSSRARNU(NAME, BIT, T, E1, E2)                                     \
-void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)             \
-{                                                                          \
-    int i;                                                                 \
-    VReg *Vd = (VReg *)vd;                                                 \
-    VReg *Vj = (VReg *)vj;                                                 \
-    VReg *Vk = (VReg *)vk;                                                 \
-                                                                           \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                                    \
-        Vd->E1(i) = do_ssrarnu_ ## E1(Vj->E2(i), (T)Vk->E2(i)%BIT, BIT/2); \
-    }                                                                      \
-    Vd->D(1) = 0;                                                          \
+#define VSSRARNU(NAME, BIT, E1, E2, E3)                                      \
+void HELPER(NAME)(void *vd, void *vj, void  *vk, uint32_t desc)              \
+{                                                                            \
+    int i, j, ofs;                                                           \
+    VReg *Vd = (VReg *)vd;                                                   \
+    VReg *Vj = (VReg *)vj;                                                   \
+    VReg *Vk = (VReg *)vk;                                                   \
+    int oprsz = simd_oprsz(desc);                                            \
+                                                                             \
+    ofs = LSX_LEN / BIT;                                                     \
+    for (i = 0; i < oprsz / 16; i++) {                                       \
+        for (j = 0; j < ofs; j++) {                                          \
+            Vd->E1(j + ofs * 2 * i) = do_ssrarnu_ ## E1(Vj->E2(j + ofs * i), \
+                                                Vk->E3(j + ofs * i) % BIT,   \
+                                                BIT / 2);                    \
+        }                                                                    \
+        Vd->D(2 * i + 1) = 0;                                                \
+    }                                                                        \
 }
 
-VSSRARNU(vssrarn_bu_h, 16, uint16_t, B, H)
-VSSRARNU(vssrarn_hu_w, 32, uint32_t, H, W)
-VSSRARNU(vssrarn_wu_d, 64, uint64_t, W, D)
+VSSRARNU(vssrarn_bu_h, 16, B, H, UH)
+VSSRARNU(vssrarn_hu_w, 32, H, W, UW)
+VSSRARNU(vssrarn_wu_d, 64, W, D, UD)
+
+#define VSSRLRNI(NAME, BIT, E1, E2)                                                 \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)                  \
+{                                                                                   \
+    int i, j, ofs;                                                                  \
+    VReg temp = {};                                                                 \
+    VReg *Vd = (VReg *)vd;                                                          \
+    VReg *Vj = (VReg *)vj;                                                          \
+    int oprsz = simd_oprsz(desc);                                                   \
+                                                                                    \
+    ofs = LSX_LEN / BIT;                                                            \
+    for (i = 0; i < oprsz / 16; i++) {                                              \
+        for (j = 0; j < ofs; j++) {                                                 \
+            temp.E1(j + ofs * 2 * i) = do_ssrlrns_ ## E1(Vj->E2(j + ofs * i),       \
+                                                         imm, BIT / 2 - 1);         \
+            temp.E1(j + ofs * (2 * i + 1)) = do_ssrlrns_ ## E1(Vd->E2(j + ofs * i), \
+                                                               imm, BIT / 2 - 1);   \
+        }                                                                           \
+    }                                                                               \
+    *Vd = temp;                                                                     \
+}
+
+static void do_vssrlrni_q(VReg *Vd, VReg * Vj,
+                          uint64_t imm, int idx, Int128 mask)
+{
+    Int128 shft_res1, shft_res2, r1, r2;
+    if (imm == 0) {
+        shft_res1 = Vj->Q(idx);
+        shft_res2 = Vd->Q(idx);
+    } else {
+        r1 = int128_and(int128_urshift(Vj->Q(idx), (imm - 1)), int128_one());
+        r2 = int128_and(int128_urshift(Vd->Q(idx), (imm - 1)), int128_one());
+        shft_res1 = (int128_add(int128_urshift(Vj->Q(idx), imm), r1));
+        shft_res2 = (int128_add(int128_urshift(Vd->Q(idx), imm), r2));
+    }
 
-#define VSSRLRNI(NAME, BIT, E1, E2)                                            \
-void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)             \
-{                                                                              \
-    int i;                                                                     \
-    VReg temp;                                                                 \
-    VReg *Vd = (VReg *)vd;                                                     \
-    VReg *Vj = (VReg *)vj;                                                     \
-                                                                               \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                                        \
-        temp.E1(i) = do_ssrlrns_ ## E1(Vj->E2(i), imm, BIT/2 -1);              \
-        temp.E1(i + LSX_LEN/BIT) = do_ssrlrns_ ## E1(Vd->E2(i), imm, BIT/2 -1);\
-    }                                                                          \
-    *Vd = temp;                                                                \
+    if (int128_ult(mask, shft_res1)) {
+        Vd->D(idx * 2) = int128_getlo(mask);
+    }else {
+        Vd->D(idx * 2) = int128_getlo(shft_res1);
+    }
+
+    if (int128_ult(mask, shft_res2)) {
+        Vd->D(idx * 2 + 1) = int128_getlo(mask);
+    }else {
+        Vd->D(idx * 2 + 1) = int128_getlo(shft_res2);
+    }
 }
 
-#define VSSRLRNI_Q(NAME, sh)                                               \
-void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)         \
-{                                                                          \
-    Int128 shft_res1, shft_res2, mask, r1, r2;                             \
-    VReg *Vd = (VReg *)vd;                                                 \
-    VReg *Vj = (VReg *)vj;                                                 \
-                                                                           \
-    if (imm == 0) {                                                        \
-        shft_res1 = Vj->Q(0);                                              \
-        shft_res2 = Vd->Q(0);                                              \
-    } else {                                                               \
-        r1 = int128_and(int128_urshift(Vj->Q(0), (imm -1)), int128_one()); \
-        r2 = int128_and(int128_urshift(Vd->Q(0), (imm -1)), int128_one()); \
-                                                                           \
-        shft_res1 = (int128_add(int128_urshift(Vj->Q(0), imm), r1));       \
-        shft_res2 = (int128_add(int128_urshift(Vd->Q(0), imm), r2));       \
-    }                                                                      \
-                                                                           \
-    mask = int128_sub(int128_lshift(int128_one(), sh), int128_one());      \
-                                                                           \
-    if (int128_ult(mask, shft_res1)) {                                     \
-        Vd->D(0) = int128_getlo(mask);                                     \
-    }else {                                                                \
-        Vd->D(0) = int128_getlo(shft_res1);                                \
-    }                                                                      \
-                                                                           \
-    if (int128_ult(mask, shft_res2)) {                                     \
-        Vd->D(1) = int128_getlo(mask);                                     \
-    }else {                                                                \
-        Vd->D(1) = int128_getlo(shft_res2);                                \
-    }                                                                      \
+void HELPER(vssrlrni_d_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
+{
+    int i;
+    Int128 mask;
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
+    int oprsz = simd_oprsz(desc);
+
+    mask = int128_sub(int128_lshift(int128_one(), 63), int128_one());
+
+    for (i = 0; i < oprsz / 16; i ++) {
+        do_vssrlrni_q(Vd, Vj, imm, i, mask);
+    }
 }
 
 VSSRLRNI(vssrlrni_b_h, 16, B, H)
 VSSRLRNI(vssrlrni_h_w, 32, H, W)
 VSSRLRNI(vssrlrni_w_d, 64, W, D)
-VSSRLRNI_Q(vssrlrni_d_q, 63)
-
-#define VSSRARNI(NAME, BIT, E1, E2)                                             \
-void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)              \
-{                                                                               \
-    int i;                                                                      \
-    VReg temp;                                                                  \
-    VReg *Vd = (VReg *)vd;                                                      \
-    VReg *Vj = (VReg *)vj;                                                      \
-                                                                                \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                                         \
-        temp.E1(i) = do_ssrarns_ ## E1(Vj->E2(i), imm, BIT/2 -1);               \
-        temp.E1(i + LSX_LEN/BIT) = do_ssrarns_ ## E1(Vd->E2(i), imm, BIT/2 -1); \
-    }                                                                           \
-    *Vd = temp;                                                                 \
-}
 
-void HELPER(vssrarni_d_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
-{
-    Int128 shft_res1, shft_res2, mask1, mask2, r1, r2;
-    VReg *Vd = (VReg *)vd;
-    VReg *Vj = (VReg *)vj;
+#define VSSRARNI(NAME, BIT, E1, E2)                                                 \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)                  \
+{                                                                                   \
+    int i, j, ofs;                                                                  \
+    VReg temp = {};                                                                 \
+    VReg *Vd = (VReg *)vd;                                                          \
+    VReg *Vj = (VReg *)vj;                                                          \
+    int oprsz = simd_oprsz(desc);                                                   \
+                                                                                    \
+    ofs = LSX_LEN / BIT;                                                            \
+    for (i = 0; i < oprsz / 16; i++) {                                              \
+        for (j = 0; j < ofs; j++) {                                                 \
+            temp.E1(j + ofs * 2 * i) = do_ssrarns_ ## E1(Vj->E2(j + ofs * i),       \
+                                                         imm, BIT / 2 - 1);         \
+            temp.E1(j + ofs * (2 * i + 1)) = do_ssrarns_ ## E1(Vd->E2(j + ofs * i), \
+                                                               imm, BIT / 2 - 1);   \
+        }                                                                           \
+    }                                                                               \
+    *Vd = temp;                                                                     \
+}
+
+static void do_vssrarni_d_q(VReg *Vd, VReg *Vj,
+                           uint64_t imm, int idx, Int128 mask1, Int128 mask2)
+{
+    Int128 shft_res1, shft_res2, r1, r2;
 
     if (imm == 0) {
-        shft_res1 = Vj->Q(0);
-        shft_res2 = Vd->Q(0);
+        shft_res1 = Vj->Q(idx);
+        shft_res2 = Vd->Q(idx);
     } else {
-        r1 = int128_and(int128_rshift(Vj->Q(0), (imm -1)), int128_one());
-        r2 = int128_and(int128_rshift(Vd->Q(0), (imm -1)), int128_one());
-
-        shft_res1 = int128_add(int128_rshift(Vj->Q(0), imm), r1);
-        shft_res2 = int128_add(int128_rshift(Vd->Q(0), imm), r2);
+        r1 = int128_and(int128_rshift(Vj->Q(idx), (imm - 1)), int128_one());
+        r2 = int128_and(int128_rshift(Vd->Q(idx), (imm - 1)), int128_one());
+        shft_res1 = int128_add(int128_rshift(Vj->Q(idx), imm), r1);
+        shft_res2 = int128_add(int128_rshift(Vd->Q(idx), imm), r2);
     }
-
-    mask1 = int128_sub(int128_lshift(int128_one(), 63), int128_one());
-    mask2  = int128_lshift(int128_one(), 63);
-
-    if (int128_gt(shft_res1,  mask1)) {
-        Vd->D(0) = int128_getlo(mask1);
+    if (int128_gt(shft_res1, mask1)) {
+        Vd->D(idx * 2) = int128_getlo(mask1);
     } else if (int128_lt(shft_res1, int128_neg(mask2))) {
-        Vd->D(0) = int128_getlo(mask2);
+        Vd->D(idx * 2) = int128_getlo(mask2);
     } else {
-        Vd->D(0) = int128_getlo(shft_res1);
+        Vd->D(idx * 2) = int128_getlo(shft_res1);
     }
 
     if (int128_gt(shft_res2, mask1)) {
-        Vd->D(1) = int128_getlo(mask1);
+        Vd->D(idx * 2 + 1) = int128_getlo(mask1);
     } else if (int128_lt(shft_res2, int128_neg(mask2))) {
-        Vd->D(1) = int128_getlo(mask2);
+        Vd->D(idx * 2 + 1) = int128_getlo(mask2);
     } else {
-        Vd->D(1) = int128_getlo(shft_res2);
+        Vd->D(idx * 2 + 1) = int128_getlo(shft_res2);
+    }
+}
+
+void HELPER(vssrarni_d_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
+{
+    int i;
+    Int128 mask1, mask2;
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
+    int oprsz = simd_oprsz(desc);
+
+    mask1 = int128_sub(int128_lshift(int128_one(), 63), int128_one());
+    mask2  = int128_lshift(int128_one(), 63);
+
+    for (i = 0; i < oprsz / 16; i++) {
+        do_vssrarni_d_q(Vd, Vj, imm, i, mask1, mask2);
     }
 }
 
@@ -2084,82 +2138,119 @@ VSSRARNI(vssrarni_b_h, 16, B, H)
 VSSRARNI(vssrarni_h_w, 32, H, W)
 VSSRARNI(vssrarni_w_d, 64, W, D)
 
-#define VSSRLRNUI(NAME, BIT, E1, E2)                                         \
-void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)           \
-{                                                                            \
-    int i;                                                                   \
-    VReg temp;                                                               \
-    VReg *Vd = (VReg *)vd;                                                   \
-    VReg *Vj = (VReg *)vj;                                                   \
-                                                                             \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                                      \
-        temp.E1(i) = do_ssrlrnu_ ## E1(Vj->E2(i), imm, BIT/2);               \
-        temp.E1(i + LSX_LEN/BIT) = do_ssrlrnu_ ## E1(Vd->E2(i), imm, BIT/2); \
-    }                                                                        \
-    *Vd = temp;                                                              \
+#define VSSRLRNUI(NAME, BIT, E1, E2)                                                \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)                  \
+{                                                                                   \
+    int i, j, ofs;                                                                  \
+    VReg temp = {};                                                                 \
+    VReg *Vd = (VReg *)vd;                                                          \
+    VReg *Vj = (VReg *)vj;                                                          \
+    int oprsz = simd_oprsz(desc);                                                   \
+                                                                                    \
+    ofs = LSX_LEN / BIT;                                                            \
+    for (i = 0; i < oprsz / 16; i++) {                                              \
+        for (j = 0; j < ofs; j++) {                                                 \
+            temp.E1(j + ofs * 2 * i) = do_ssrlrnu_ ## E1(Vj->E2(j + ofs * i),       \
+                                                         imm, BIT / 2);             \
+            temp.E1(j + ofs * (2 * i + 1)) = do_ssrlrnu_ ## E1(Vd->E2(j + ofs * i), \
+                                                               imm, BIT / 2);       \
+        }                                                                           \
+    }                                                                               \
+    *Vd = temp;                                                                     \
+}
+
+void HELPER(vssrlrni_du_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
+{
+    int i;
+    Int128 mask;
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
+    int oprsz = simd_oprsz(desc);
+
+    mask = int128_sub(int128_lshift(int128_one(), 64), int128_one());
+
+    for (i = 0; i < oprsz / 16; i ++) {
+        do_vssrlrni_q(Vd, Vj, imm, i, mask);
+    }
 }
 
 VSSRLRNUI(vssrlrni_bu_h, 16, B, H)
 VSSRLRNUI(vssrlrni_hu_w, 32, H, W)
 VSSRLRNUI(vssrlrni_wu_d, 64, W, D)
-VSSRLRNI_Q(vssrlrni_du_q, 64)
 
-#define VSSRARNUI(NAME, BIT, E1, E2)                                         \
-void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)           \
-{                                                                            \
-    int i;                                                                   \
-    VReg temp;                                                               \
-    VReg *Vd = (VReg *)vd;                                                   \
-    VReg *Vj = (VReg *)vj;                                                   \
-                                                                             \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                                      \
-        temp.E1(i) = do_ssrarnu_ ## E1(Vj->E2(i), imm, BIT/2);               \
-        temp.E1(i + LSX_LEN/BIT) = do_ssrarnu_ ## E1(Vd->E2(i), imm, BIT/2); \
-    }                                                                        \
-    *Vd = temp;                                                              \
-}
-
-void HELPER(vssrarni_du_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
-{
-    Int128 shft_res1, shft_res2, mask1, mask2, r1, r2;
-    VReg *Vd = (VReg *)vd;
-    VReg *Vj = (VReg *)vj;
+#define VSSRARNUI(NAME, BIT, E1, E2)                                                \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)                  \
+{                                                                                   \
+    int i, j, ofs;                                                                  \
+    VReg temp = {};                                                                 \
+    VReg *Vd = (VReg *)vd;                                                          \
+    VReg *Vj = (VReg *)vj;                                                          \
+    int oprsz = simd_oprsz(desc);                                                   \
+                                                                                    \
+    ofs = LSX_LEN / BIT;                                                            \
+    for (i = 0; i < oprsz / 16; i++) {                                              \
+        for (j = 0; j < ofs; j++) {                                                 \
+            temp.E1(j + ofs * 2 * i) = do_ssrarnu_ ## E1(Vj->E2(j + ofs * i),       \
+                                                         imm, BIT / 2);             \
+            temp.E1(j + ofs * (2 * i + 1)) = do_ssrarnu_ ## E1(Vd->E2(j + ofs * i), \
+                                                               imm, BIT / 2);       \
+        }                                                                           \
+    }                                                                               \
+    *Vd = temp;                                                                     \
+}
+
+static void do_vssrarni_du_q(VReg *Vd, VReg *Vj,
+                             uint64_t imm, int idx, Int128 mask1, Int128 mask2)
+{
+    Int128 shft_res1, shft_res2, r1, r2;
 
     if (imm == 0) {
-        shft_res1 = Vj->Q(0);
-        shft_res2 = Vd->Q(0);
+        shft_res1 = Vj->Q(idx);
+        shft_res2 = Vd->Q(idx);
     } else {
-        r1 = int128_and(int128_rshift(Vj->Q(0), (imm -1)), int128_one());
-        r2 = int128_and(int128_rshift(Vd->Q(0), (imm -1)), int128_one());
-
-        shft_res1 = int128_add(int128_rshift(Vj->Q(0), imm), r1);
-        shft_res2 = int128_add(int128_rshift(Vd->Q(0), imm), r2);
+        r1 = int128_and(int128_rshift(Vj->Q(idx), (imm - 1)), int128_one());
+        r2 = int128_and(int128_rshift(Vd->Q(idx), (imm - 1)), int128_one());
+        shft_res1 = int128_add(int128_rshift(Vj->Q(idx), imm), r1);
+        shft_res2 = int128_add(int128_rshift(Vd->Q(idx), imm), r2);
     }
 
-    if (int128_lt(Vj->Q(0), int128_zero())) {
+    if (int128_lt(Vj->Q(idx), int128_zero())) {
         shft_res1 = int128_zero();
     }
-    if (int128_lt(Vd->Q(0), int128_zero())) {
+    if (int128_lt(Vd->Q(idx), int128_zero())) {
         shft_res2 = int128_zero();
     }
 
-    mask1 = int128_sub(int128_lshift(int128_one(), 64), int128_one());
-    mask2  = int128_lshift(int128_one(), 64);
-
     if (int128_gt(shft_res1,  mask1)) {
-        Vd->D(0) = int128_getlo(mask1);
+        Vd->D(idx * 2) = int128_getlo(mask1);
     } else if (int128_lt(shft_res1, int128_neg(mask2))) {
-        Vd->D(0) = int128_getlo(mask2);
+        Vd->D(idx * 2) = int128_getlo(mask2);
     } else {
-        Vd->D(0) = int128_getlo(shft_res1);
+        Vd->D(idx * 2) = int128_getlo(shft_res1);
     }
 
     if (int128_gt(shft_res2, mask1)) {
-        Vd->D(1) = int128_getlo(mask1);
+        Vd->D(idx * 2 + 1) = int128_getlo(mask1);
     } else if (int128_lt(shft_res2, int128_neg(mask2))) {
-        Vd->D(1) = int128_getlo(mask2);
+        Vd->D(idx * 2 + 1) = int128_getlo(mask2);
     } else {
-        Vd->D(1) = int128_getlo(shft_res2);
+        Vd->D(idx * 1 + 1) = int128_getlo(shft_res2);
+    }
+}
+
+void HELPER(vssrarni_du_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
+{
+    int i;
+    Int128 mask1, mask2;
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
+    int oprsz = simd_oprsz(desc);
+
+    mask1 = int128_sub(int128_lshift(int128_one(), 64), int128_one());
+    mask2  = int128_lshift(int128_one(), 64);
+
+    for (i = 0; i < oprsz / 16; i++) {
+        do_vssrarni_du_q(Vd, Vj, imm, i, mask1, mask2);
     }
 }
 
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 952f7fdc46..c9d0897acf 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -3959,6 +3959,18 @@ TRANS(vssrlrn_wu_d, LSX, gen_vvv, gen_helper_vssrlrn_wu_d)
 TRANS(vssrarn_bu_h, LSX, gen_vvv, gen_helper_vssrarn_bu_h)
 TRANS(vssrarn_hu_w, LSX, gen_vvv, gen_helper_vssrarn_hu_w)
 TRANS(vssrarn_wu_d, LSX, gen_vvv, gen_helper_vssrarn_wu_d)
+TRANS(xvssrlrn_b_h, LASX, gen_xxx, gen_helper_vssrlrn_b_h)
+TRANS(xvssrlrn_h_w, LASX, gen_xxx, gen_helper_vssrlrn_h_w)
+TRANS(xvssrlrn_w_d, LASX, gen_xxx, gen_helper_vssrlrn_w_d)
+TRANS(xvssrarn_b_h, LASX, gen_xxx, gen_helper_vssrarn_b_h)
+TRANS(xvssrarn_h_w, LASX, gen_xxx, gen_helper_vssrarn_h_w)
+TRANS(xvssrarn_w_d, LASX, gen_xxx, gen_helper_vssrarn_w_d)
+TRANS(xvssrlrn_bu_h, LASX, gen_xxx, gen_helper_vssrlrn_bu_h)
+TRANS(xvssrlrn_hu_w, LASX, gen_xxx, gen_helper_vssrlrn_hu_w)
+TRANS(xvssrlrn_wu_d, LASX, gen_xxx, gen_helper_vssrlrn_wu_d)
+TRANS(xvssrarn_bu_h, LASX, gen_xxx, gen_helper_vssrarn_bu_h)
+TRANS(xvssrarn_hu_w, LASX, gen_xxx, gen_helper_vssrarn_hu_w)
+TRANS(xvssrarn_wu_d, LASX, gen_xxx, gen_helper_vssrarn_wu_d)
 
 TRANS(vssrlrni_b_h, LSX, gen_vv_i, gen_helper_vssrlrni_b_h)
 TRANS(vssrlrni_h_w, LSX, gen_vv_i, gen_helper_vssrlrni_h_w)
@@ -3976,6 +3988,22 @@ TRANS(vssrarni_bu_h, LSX, gen_vv_i, gen_helper_vssrarni_bu_h)
 TRANS(vssrarni_hu_w, LSX, gen_vv_i, gen_helper_vssrarni_hu_w)
 TRANS(vssrarni_wu_d, LSX, gen_vv_i, gen_helper_vssrarni_wu_d)
 TRANS(vssrarni_du_q, LSX, gen_vv_i, gen_helper_vssrarni_du_q)
+TRANS(xvssrlrni_b_h, LASX, gen_xx_i, gen_helper_vssrlrni_b_h)
+TRANS(xvssrlrni_h_w, LASX, gen_xx_i, gen_helper_vssrlrni_h_w)
+TRANS(xvssrlrni_w_d, LASX, gen_xx_i, gen_helper_vssrlrni_w_d)
+TRANS(xvssrlrni_d_q, LASX, gen_xx_i, gen_helper_vssrlrni_d_q)
+TRANS(xvssrarni_b_h, LASX, gen_xx_i, gen_helper_vssrarni_b_h)
+TRANS(xvssrarni_h_w, LASX, gen_xx_i, gen_helper_vssrarni_h_w)
+TRANS(xvssrarni_w_d, LASX, gen_xx_i, gen_helper_vssrarni_w_d)
+TRANS(xvssrarni_d_q, LASX, gen_xx_i, gen_helper_vssrarni_d_q)
+TRANS(xvssrlrni_bu_h, LASX, gen_xx_i, gen_helper_vssrlrni_bu_h)
+TRANS(xvssrlrni_hu_w, LASX, gen_xx_i, gen_helper_vssrlrni_hu_w)
+TRANS(xvssrlrni_wu_d, LASX, gen_xx_i, gen_helper_vssrlrni_wu_d)
+TRANS(xvssrlrni_du_q, LASX, gen_xx_i, gen_helper_vssrlrni_du_q)
+TRANS(xvssrarni_bu_h, LASX, gen_xx_i, gen_helper_vssrarni_bu_h)
+TRANS(xvssrarni_hu_w, LASX, gen_xx_i, gen_helper_vssrarni_hu_w)
+TRANS(xvssrarni_wu_d, LASX, gen_xx_i, gen_helper_vssrarni_wu_d)
+TRANS(xvssrarni_du_q, LASX, gen_xx_i, gen_helper_vssrarni_du_q)
 
 TRANS(vclo_b, LSX, gen_vv, gen_helper_vclo_b)
 TRANS(vclo_h, LSX, gen_vv, gen_helper_vclo_h)
-- 
2.39.1


