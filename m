Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EE878D45B
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 10:53:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbGvE-0000xz-L7; Wed, 30 Aug 2023 04:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qbGvB-0000Md-8w
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:51:29 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qbGv6-00087C-1I
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:51:29 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Dx_+uYAu9ksAgdAA--.58278S3;
 Wed, 30 Aug 2023 16:49:28 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxF81+Au9kHhxnAA--.49766S34; 
 Wed, 30 Aug 2023 16:49:28 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v4 32/48] target/loongarch: Implement xvssrln xvssran
Date: Wed, 30 Aug 2023 16:48:46 +0800
Message-Id: <20230830084902.2113960-33-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230830084902.2113960-1-gaosong@loongson.cn>
References: <20230830084902.2113960-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxF81+Au9kHhxnAA--.49766S34
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
 target/loongarch/insns.decode                |  30 ++
 target/loongarch/disas.c                     |  30 ++
 target/loongarch/vec_helper.c                | 451 ++++++++++---------
 target/loongarch/insn_trans/trans_lasx.c.inc |  30 ++
 4 files changed, 337 insertions(+), 204 deletions(-)

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
index 04b6ea713d..04e8d42044 100644
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
index d4f2091656..738bb452f6 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -1371,23 +1371,29 @@ SSRLNS(B, uint16_t, int16_t, uint8_t)
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
@@ -1399,10 +1405,10 @@ static T1 do_ssrans_ ## E(T1 e2, int sa, int sh) \
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
@@ -1413,23 +1419,29 @@ SSRANS(B, int16_t, int8_t)
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
@@ -1441,7 +1453,7 @@ static T1 do_ssrlnu_ ## E(T3 e2, int sa, int sh) \
             shft_res = (((T1)e2) >> sa);         \
         }                                        \
         T2 mask;                                 \
-        mask = (1ull << sh) -1;                  \
+        mask = (1ull << sh) - 1;                 \
         if (shft_res > mask) {                   \
             return mask;                         \
         } else {                                 \
@@ -1453,23 +1465,29 @@ SSRLNU(B, uint16_t, uint8_t,  int16_t)
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
@@ -1484,7 +1502,7 @@ static T1 do_ssranu_ ## E(T3 e2, int sa, int sh) \
             shft_res = 0;                        \
         }                                        \
         T2 mask;                                 \
-        mask = (1ull << sh) -1;                  \
+        mask = (1ull << sh) - 1;                 \
         if (shft_res > mask) {                   \
             return mask;                         \
         } else {                                 \
@@ -1496,64 +1514,76 @@ SSRANU(B, uint16_t, uint8_t,  int16_t)
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
 }
 
 void HELPER(vssrlni_d_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
 {
-    Int128 shft_res1, shft_res2, mask;
+    int i, j;
+    Int128 shft_res[4], mask;
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
     mask = int128_sub(int128_lshift(int128_one(), 63), int128_one());
 
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
+        if (imm == 0) {
+            shft_res[2 * i] = Vj->Q(i);
+            shft_res[2 * i + 1] = Vd->Q(i);
+        } else {
+            shft_res[2 * i] = int128_urshift(Vj->Q(i), imm);
+            shft_res[2 * i + 1] = int128_urshift(Vd->Q(i), imm);
+        }
+        for (j = 2 * i; j <= 2 * i + 1; j++) {
+            if (int128_ult(mask, shft_res[j])) {
+                Vd->D(j) = int128_getlo(mask);
+            }else {
+                Vd->D(j) = int128_getlo(shft_res[j]);
+            }
+        }
     }
 }
 
@@ -1561,51 +1591,55 @@ VSSRLNI(vssrlni_b_h, 16, B, H)
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
 }
 
 void HELPER(vssrani_d_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
 {
-    Int128 shft_res1, shft_res2, mask, min;
-    VReg *Vd = (VReg *)vd; 
-    VReg *Vj = (VReg *)vj; 
+    int i, j;
+    Int128 shft_res[4], mask, min;
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
+    int oprsz = simd_oprsz(desc);
 
-    if (imm == 0) {
-        shft_res1 = Vj->Q(0);
-        shft_res2 = Vd->Q(0);
-    } else {
-        shft_res1 = int128_rshift(Vj->Q(0), imm);
-        shft_res2 = int128_rshift(Vd->Q(0), imm);
-    }
     mask = int128_sub(int128_lshift(int128_one(), 63), int128_one());
     min  = int128_lshift(int128_one(), 63);
 
-    if (int128_gt(shft_res1,  mask)) {
-        Vd->D(0) = int128_getlo(mask);
-    } else if (int128_lt(shft_res1, int128_neg(min))) {
-        Vd->D(0) = int128_getlo(min);
-    } else {
-        Vd->D(0) = int128_getlo(shft_res1);
-    }
-
-    if (int128_gt(shft_res2, mask)) {
-        Vd->D(1) = int128_getlo(mask);
-    } else if (int128_lt(shft_res2, int128_neg(min))) {
-        Vd->D(1) = int128_getlo(min);
-    } else {
-        Vd->D(1) = int128_getlo(shft_res2);
+    for (i = 0; i < oprsz / 16; i++) {
+        if (imm == 0) {
+            shft_res[2 * i] = Vj->Q(i);
+            shft_res[2 * i + 1] = Vd->Q(i);
+        } else {
+            shft_res[2 * i] = int128_rshift(Vj->Q(i), imm);
+            shft_res[2 * i + 1] = int128_rshift(Vd->Q(i), imm);
+        }
+        for (j = 2 * i; j <= 2 * i + 1; j++) {
+            if (int128_gt(shft_res[j],  mask)) {
+                Vd->D(j) = int128_getlo(mask);
+            } else if (int128_lt(shft_res[j], int128_neg(min))) {
+                Vd->D(j) = int128_getlo(min);
+            } else {
+                Vd->D(j) = int128_getlo(shft_res[j]);
+            }
+        }
     }
 }
 
@@ -1613,46 +1647,52 @@ VSSRANI(vssrani_b_h, 16, B, H)
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
+    int i, j;
+    Int128 shft_res[4], mask;
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
+        if (imm == 0) {
+            shft_res[2 * i] = Vj->Q(i);
+            shft_res[2 * i + 1] = Vd->Q(i);
+        } else {
+            shft_res[2 * i] = int128_urshift(Vj->Q(i), imm);
+            shft_res[2 * i + 1] = int128_urshift(Vd->Q(i), imm);
+        }
+        for (j = 2 * i; j <= 2 * i + 1; j++) {
+            if (int128_ult(mask, shft_res[j])) {
+                Vd->D(j) = int128_getlo(mask);
+            }else {
+                Vd->D(j) = int128_getlo(shft_res[j]);
+            }
+        }
     }
 }
 
@@ -1660,55 +1700,58 @@ VSSRLNUI(vssrlni_bu_h, 16, B, H)
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
 }
 
 void HELPER(vssrani_du_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
 {
-    Int128 shft_res1, shft_res2, mask;
+    int i, j;
+    Int128 shft_res[4], mask;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
-
-    if (imm == 0) {
-        shft_res1 = Vj->Q(0);
-        shft_res2 = Vd->Q(0);
-    } else {
-        shft_res1 = int128_rshift(Vj->Q(0), imm);
-        shft_res2 = int128_rshift(Vd->Q(0), imm);
-    }
-
-    if (int128_lt(Vj->Q(0), int128_zero())) {
-        shft_res1 = int128_zero();
-    }
-
-    if (int128_lt(Vd->Q(0), int128_zero())) {
-        shft_res2 = int128_zero();
-    }
+    int oprsz = simd_oprsz(desc);
 
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
+        if (imm == 0) {
+            shft_res[2 * i] = Vj->Q(i);
+            shft_res[2 * i + 1] = Vd->Q(i);
+        } else {
+            shft_res[2 * i] = int128_rshift(Vj->Q(i), imm);
+            shft_res[2 * i + 1] = int128_rshift(Vd->Q(i), imm);
+        }
+        if (int128_lt(Vj->Q(i), int128_zero())) {
+            shft_res[2 * i] = int128_zero();
+        }
+        if (int128_lt(Vd->Q(i), int128_zero())) {
+            shft_res[2 * i + 1] = int128_zero();
+        }
+        for (j = 2 * i; j <= 2 * i + 1; j++) {
+            if (int128_ult(mask, shft_res[j])) {
+                Vd->D(j) = int128_getlo(mask);
+            }else {
+                Vd->D(j) = int128_getlo(shft_res[j]);
+            }
+        }
     }
 }
 
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 702a2f770d..9c218abb6f 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -459,6 +459,36 @@ TRANS(xvsrarni_h_w, LASX, gen_vv_i, 32, gen_helper_vsrarni_h_w)
 TRANS(xvsrarni_w_d, LASX, gen_vv_i, 32, gen_helper_vsrarni_w_d)
 TRANS(xvsrarni_d_q, LASX, gen_vv_i, 32, gen_helper_vsrarni_d_q)
 
+TRANS(xvssrln_b_h, LASX, gen_vvv, 32, gen_helper_vssrln_b_h)
+TRANS(xvssrln_h_w, LASX, gen_vvv, 32, gen_helper_vssrln_h_w)
+TRANS(xvssrln_w_d, LASX, gen_vvv, 32, gen_helper_vssrln_w_d)
+TRANS(xvssran_b_h, LASX, gen_vvv, 32, gen_helper_vssran_b_h)
+TRANS(xvssran_h_w, LASX, gen_vvv, 32, gen_helper_vssran_h_w)
+TRANS(xvssran_w_d, LASX, gen_vvv, 32, gen_helper_vssran_w_d)
+TRANS(xvssrln_bu_h, LASX, gen_vvv, 32, gen_helper_vssrln_bu_h)
+TRANS(xvssrln_hu_w, LASX, gen_vvv, 32, gen_helper_vssrln_hu_w)
+TRANS(xvssrln_wu_d, LASX, gen_vvv, 32, gen_helper_vssrln_wu_d)
+TRANS(xvssran_bu_h, LASX, gen_vvv, 32, gen_helper_vssran_bu_h)
+TRANS(xvssran_hu_w, LASX, gen_vvv, 32, gen_helper_vssran_hu_w)
+TRANS(xvssran_wu_d, LASX, gen_vvv, 32, gen_helper_vssran_wu_d)
+
+TRANS(xvssrlni_b_h, LASX, gen_vv_i, 32, gen_helper_vssrlni_b_h)
+TRANS(xvssrlni_h_w, LASX, gen_vv_i, 32, gen_helper_vssrlni_h_w)
+TRANS(xvssrlni_w_d, LASX, gen_vv_i, 32, gen_helper_vssrlni_w_d)
+TRANS(xvssrlni_d_q, LASX, gen_vv_i, 32, gen_helper_vssrlni_d_q)
+TRANS(xvssrani_b_h, LASX, gen_vv_i, 32, gen_helper_vssrani_b_h)
+TRANS(xvssrani_h_w, LASX, gen_vv_i, 32, gen_helper_vssrani_h_w)
+TRANS(xvssrani_w_d, LASX, gen_vv_i, 32, gen_helper_vssrani_w_d)
+TRANS(xvssrani_d_q, LASX, gen_vv_i, 32, gen_helper_vssrani_d_q)
+TRANS(xvssrlni_bu_h, LASX, gen_vv_i, 32, gen_helper_vssrlni_bu_h)
+TRANS(xvssrlni_hu_w, LASX, gen_vv_i, 32, gen_helper_vssrlni_hu_w)
+TRANS(xvssrlni_wu_d, LASX, gen_vv_i, 32, gen_helper_vssrlni_wu_d)
+TRANS(xvssrlni_du_q, LASX, gen_vv_i, 32, gen_helper_vssrlni_du_q)
+TRANS(xvssrani_bu_h, LASX, gen_vv_i, 32, gen_helper_vssrani_bu_h)
+TRANS(xvssrani_hu_w, LASX, gen_vv_i, 32, gen_helper_vssrani_hu_w)
+TRANS(xvssrani_wu_d, LASX, gen_vv_i, 32, gen_helper_vssrani_wu_d)
+TRANS(xvssrani_du_q, LASX, gen_vv_i, 32, gen_helper_vssrani_du_q)
+
 TRANS(xvreplgr2vr_b, LASX, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, LASX, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, LASX, gvec_dup, 32, MO_32)
-- 
2.39.1


