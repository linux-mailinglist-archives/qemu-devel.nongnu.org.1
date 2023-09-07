Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EFB7970C3
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 10:33:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeARf-0004ew-VU; Thu, 07 Sep 2023 04:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qeARX-0004Oi-QO
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:32:51 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qeARU-0002Mr-3V
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:32:51 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxlPChivlkOjkhAA--.786S3;
 Thu, 07 Sep 2023 16:32:33 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bxxsx+ivlk8FVwAA--.49124S40; 
 Thu, 07 Sep 2023 16:32:33 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH RESEND v5 38/57] target/loongarch: Implement xvsrln xvsran
Date: Thu,  7 Sep 2023 16:31:39 +0800
Message-Id: <20230907083158.3975132-39-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230907083158.3975132-1-gaosong@loongson.cn>
References: <20230907083158.3975132-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxxsx+ivlk8FVwAA--.49124S40
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
- XVSRLN.{B.H/H.W/W.D};
- XVSRAN.{B.H/H.W/W.D};
- XVSRLNI.{B.H/H.W/W.D/D.Q};
- XVSRANI.{B.H/H.W/W.D/D.Q}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/insns.decode               |  16 ++
 target/loongarch/disas.c                    |  16 ++
 target/loongarch/vec_helper.c               | 166 +++++++++++---------
 target/loongarch/insn_trans/trans_vec.c.inc |  14 ++
 4 files changed, 137 insertions(+), 75 deletions(-)

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
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index bc5eb82b49..28e5e16eb2 100644
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
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index bb30d24b89..8c405ce32b 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -1109,105 +1109,121 @@ VSRARI(vsrari_d, 64, D)
 
 #define R_SHIFT(a, b) (a >> b)
 
-#define VSRLN(NAME, BIT, T, E1, E2)                             \
-void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)  \
-{                                                               \
-    int i;                                                      \
-    VReg *Vd = (VReg *)vd;                                      \
-    VReg *Vj = (VReg *)vj;                                      \
-    VReg *Vk = (VReg *)vk;                                      \
-                                                                \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                         \
-        Vd->E1(i) = R_SHIFT((T)Vj->E2(i),((T)Vk->E2(i)) % BIT); \
-    }                                                           \
-    Vd->D(1) = 0;                                               \
+#define VSRLN(NAME, BIT, E1, E2)                                          \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)            \
+{                                                                         \
+    int i, j, ofs;                                                        \
+    VReg *Vd = (VReg *)vd;                                                \
+    VReg *Vj = (VReg *)vj;                                                \
+    VReg *Vk = (VReg *)vk;                                                \
+    int oprsz = simd_oprsz(desc);                                         \
+                                                                          \
+    ofs = LSX_LEN / BIT;                                                  \
+    for (i = 0; i < oprsz / 16; i++) {                                    \
+        for (j = 0; j < ofs; j++) {                                       \
+            Vd->E1(j + ofs * 2 * i) = R_SHIFT(Vj->E2(j + ofs * i),        \
+                                              Vk->E2(j + ofs * i) % BIT); \
+        }                                                                 \
+        Vd->D(2 * i + 1) = 0;                                             \
+    }                                                                     \
 }
 
-VSRLN(vsrln_b_h, 16, uint16_t, B, H)
-VSRLN(vsrln_h_w, 32, uint32_t, H, W)
-VSRLN(vsrln_w_d, 64, uint64_t, W, D)
+VSRLN(vsrln_b_h, 16, B, UH)
+VSRLN(vsrln_h_w, 32, H, UW)
+VSRLN(vsrln_w_d, 64, W, UD)
 
-#define VSRAN(NAME, BIT, T, E1, E2)                            \
-void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
-{                                                              \
-    int i;                                                     \
-    VReg *Vd = (VReg *)vd;                                     \
-    VReg *Vj = (VReg *)vj;                                     \
-    VReg *Vk = (VReg *)vk;                                     \
-                                                               \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                        \
-        Vd->E1(i) = R_SHIFT(Vj->E2(i), ((T)Vk->E2(i)) % BIT);  \
-    }                                                          \
-    Vd->D(1) = 0;                                              \
+#define VSRAN(NAME, BIT, E1, E2, E3)                                      \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)            \
+{                                                                         \
+    int i, j, ofs;                                                        \
+    VReg *Vd = (VReg *)vd;                                                \
+    VReg *Vj = (VReg *)vj;                                                \
+    VReg *Vk = (VReg *)vk;                                                \
+    int oprsz = simd_oprsz(desc);                                         \
+                                                                          \
+    ofs = LSX_LEN / BIT;                                                  \
+    for (i = 0; i < oprsz / 16; i++) {                                    \
+        for (j = 0; j < ofs; j++) {                                       \
+            Vd->E1(j + ofs * 2 * i) = R_SHIFT(Vj->E2(j + ofs * i),        \
+                                              Vk->E3(j + ofs * i) % BIT); \
+        }                                                                 \
+        Vd->D(2 * i + 1) = 0;                                             \
+    }                                                                     \
 }
 
-VSRAN(vsran_b_h, 16, uint16_t, B, H)
-VSRAN(vsran_h_w, 32, uint32_t, H, W)
-VSRAN(vsran_w_d, 64, uint64_t, W, D)
+VSRAN(vsran_b_h, 16, B, H, UH)
+VSRAN(vsran_h_w, 32, H, W, UW)
+VSRAN(vsran_w_d, 64, W, D, UD)
 
-#define VSRLNI(NAME, BIT, T, E1, E2)                               \
-void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc) \
-{                                                                  \
-    int i, max;                                                    \
-    VReg temp;                                                     \
-    VReg *Vd = (VReg *)vd;                                         \
-    VReg *Vj = (VReg *)vj;                                         \
-                                                                   \
-    temp.D(0) = 0;                                                 \
-    temp.D(1) = 0;                                                 \
-    max = LSX_LEN/BIT;                                             \
-    for (i = 0; i < max; i++) {                                    \
-        temp.E1(i) = R_SHIFT((T)Vj->E2(i), imm);                   \
-        temp.E1(i + max) = R_SHIFT((T)Vd->E2(i), imm);             \
-    }                                                              \
-    *Vd = temp;                                                    \
+#define VSRLNI(NAME, BIT, E1, E2)                                         \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)        \
+{                                                                         \
+    int i, j, ofs;                                                        \
+    VReg temp = {};                                                       \
+    VReg *Vd = (VReg *)vd;                                                \
+    VReg *Vj = (VReg *)vj;                                                \
+    int oprsz = simd_oprsz(desc);                                         \
+                                                                          \
+    ofs = LSX_LEN / BIT;                                                  \
+    for (i = 0; i < oprsz / 16; i++) {                                    \
+        for (j = 0; j < ofs; j++) {                                       \
+            temp.E1(j + ofs * 2 * i) = R_SHIFT(Vj->E2(j + ofs * i), imm); \
+            temp.E1(j + ofs * (2 * i + 1)) = R_SHIFT(Vd->E2(j + ofs * i), \
+                                                     imm);                \
+        }                                                                 \
+    }                                                                     \
+    *Vd = temp;                                                           \
 }
 
 void HELPER(vsrlni_d_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
 {
-    VReg temp;
+    int i;
+    VReg temp = {};
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
 
-    temp.D(0) = 0;
-    temp.D(1) = 0;
-    temp.D(0) = int128_getlo(int128_urshift(Vj->Q(0), imm % 128));
-    temp.D(1) = int128_getlo(int128_urshift(Vd->Q(0), imm % 128));
+    for (i = 0; i < 2; i++) {
+        temp.D(2 * i) = int128_getlo(int128_urshift(Vj->Q(i), imm % 128));
+        temp.D(2 * i +1) = int128_getlo(int128_urshift(Vd->Q(i), imm % 128));
+    }
     *Vd = temp;
 }
 
-VSRLNI(vsrlni_b_h, 16, uint16_t, B, H)
-VSRLNI(vsrlni_h_w, 32, uint32_t, H, W)
-VSRLNI(vsrlni_w_d, 64, uint64_t, W, D)
+VSRLNI(vsrlni_b_h, 16, B, UH)
+VSRLNI(vsrlni_h_w, 32, H, UW)
+VSRLNI(vsrlni_w_d, 64, W, UD)
 
-#define VSRANI(NAME, BIT, E1, E2)                                  \
-void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc) \
-{                                                                  \
-    int i, max;                                                    \
-    VReg temp;                                                     \
-    VReg *Vd = (VReg *)vd;                                         \
-    VReg *Vj = (VReg *)vj;                                         \
-                                                                   \
-    temp.D(0) = 0;                                                 \
-    temp.D(1) = 0;                                                 \
-    max = LSX_LEN/BIT;                                             \
-    for (i = 0; i < max; i++) {                                    \
-        temp.E1(i) = R_SHIFT(Vj->E2(i), imm);                      \
-        temp.E1(i + max) = R_SHIFT(Vd->E2(i), imm);                \
-    }                                                              \
-    *Vd = temp;                                                    \
+#define VSRANI(NAME, BIT, E1, E2)                                         \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)        \
+{                                                                         \
+    int i, j, ofs;                                                        \
+    VReg temp = {};                                                       \
+    VReg *Vd = (VReg *)vd;                                                \
+    VReg *Vj = (VReg *)vj;                                                \
+    int oprsz = simd_oprsz(desc);                                         \
+                                                                          \
+    ofs = LSX_LEN / BIT;                                                  \
+    for (i = 0; i < oprsz / 16; i++) {                                    \
+        for (j = 0; j < ofs; j++) {                                       \
+            temp.E1(j + ofs * 2 * i) = R_SHIFT(Vj->E2(j + ofs * i), imm); \
+            temp.E1(j + ofs * (2 * i + 1)) = R_SHIFT(Vd->E2(j + ofs * i), \
+                                                     imm);                \
+        }                                                                 \
+    }                                                                     \
+    *Vd = temp;                                                           \
 }
 
 void HELPER(vsrani_d_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
 {
-    VReg temp;
+    int i;
+    VReg temp = {};
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
 
-    temp.D(0) = 0;
-    temp.D(1) = 0;
-    temp.D(0) = int128_getlo(int128_rshift(Vj->Q(0), imm % 128));
-    temp.D(1) = int128_getlo(int128_rshift(Vd->Q(0), imm % 128));
+    for (i = 0; i < 2; i++) {
+        temp.D(2 * i) = int128_getlo(int128_rshift(Vj->Q(i), imm % 128));
+        temp.D(2 * i + 1) = int128_getlo(int128_rshift(Vd->Q(i), imm % 128));
+    }
     *Vd = temp;
 }
 
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 9d95c42708..01934e5f97 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -3835,6 +3835,12 @@ TRANS(vsrln_w_d, LSX, gen_vvv, gen_helper_vsrln_w_d)
 TRANS(vsran_b_h, LSX, gen_vvv, gen_helper_vsran_b_h)
 TRANS(vsran_h_w, LSX, gen_vvv, gen_helper_vsran_h_w)
 TRANS(vsran_w_d, LSX, gen_vvv, gen_helper_vsran_w_d)
+TRANS(xvsrln_b_h, LASX, gen_xxx, gen_helper_vsrln_b_h)
+TRANS(xvsrln_h_w, LASX, gen_xxx, gen_helper_vsrln_h_w)
+TRANS(xvsrln_w_d, LASX, gen_xxx, gen_helper_vsrln_w_d)
+TRANS(xvsran_b_h, LASX, gen_xxx, gen_helper_vsran_b_h)
+TRANS(xvsran_h_w, LASX, gen_xxx, gen_helper_vsran_h_w)
+TRANS(xvsran_w_d, LASX, gen_xxx, gen_helper_vsran_w_d)
 
 TRANS(vsrlni_b_h, LSX, gen_vv_i, gen_helper_vsrlni_b_h)
 TRANS(vsrlni_h_w, LSX, gen_vv_i, gen_helper_vsrlni_h_w)
@@ -3844,6 +3850,14 @@ TRANS(vsrani_b_h, LSX, gen_vv_i, gen_helper_vsrani_b_h)
 TRANS(vsrani_h_w, LSX, gen_vv_i, gen_helper_vsrani_h_w)
 TRANS(vsrani_w_d, LSX, gen_vv_i, gen_helper_vsrani_w_d)
 TRANS(vsrani_d_q, LSX, gen_vv_i, gen_helper_vsrani_d_q)
+TRANS(xvsrlni_b_h, LASX, gen_xx_i, gen_helper_vsrlni_b_h)
+TRANS(xvsrlni_h_w, LASX, gen_xx_i, gen_helper_vsrlni_h_w)
+TRANS(xvsrlni_w_d, LASX, gen_xx_i, gen_helper_vsrlni_w_d)
+TRANS(xvsrlni_d_q, LASX, gen_xx_i, gen_helper_vsrlni_d_q)
+TRANS(xvsrani_b_h, LASX, gen_xx_i, gen_helper_vsrani_b_h)
+TRANS(xvsrani_h_w, LASX, gen_xx_i, gen_helper_vsrani_h_w)
+TRANS(xvsrani_w_d, LASX, gen_xx_i, gen_helper_vsrani_w_d)
+TRANS(xvsrani_d_q, LASX, gen_xx_i, gen_helper_vsrani_d_q)
 
 TRANS(vsrlrn_b_h, LSX, gen_vvv, gen_helper_vsrlrn_b_h)
 TRANS(vsrlrn_h_w, LSX, gen_vvv, gen_helper_vsrlrn_h_w)
-- 
2.39.1


