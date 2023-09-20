Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B160C7A7335
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 08:53:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qir4Q-0007oU-ER; Wed, 20 Sep 2023 02:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qir4H-0007nt-Pf
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 02:52:13 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qir4D-00042Y-QL
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 02:52:12 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Dxl+iMlgplpC8qAA--.45085S3;
 Wed, 20 Sep 2023 14:51:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dxzdx7lgplhVYMAA--.24315S22; 
 Wed, 20 Sep 2023 14:51:55 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 20/57] target/loongarch: Implement xvaddw/xvsubw
Date: Wed, 20 Sep 2023 14:51:02 +0800
Message-Id: <20230920065139.1403868-21-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230920065139.1403868-1-gaosong@loongson.cn>
References: <20230920065139.1403868-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxzdx7lgplhVYMAA--.24315S22
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
- XVADDW{EV/OD}.{H.B/W.H/D.W/Q.D}[U];
- XVSUBW{EV/OD}.{H.B/W.H/D.W/Q.D}[U];
- XVADDW{EV/OD}.{H.BU.B/W.HU.H/D.WU.W/Q.DU.D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230914022645.1151356-21-gaosong@loongson.cn>
---
 target/loongarch/insns.decode               |  45 ++++++++
 target/loongarch/disas.c                    |  43 +++++++
 target/loongarch/vec_helper.c               | 120 ++++++++++++++------
 target/loongarch/insn_trans/trans_vec.c.inc |  41 +++++++
 4 files changed, 215 insertions(+), 34 deletions(-)

diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index ba0b36f4a7..e1d8b30179 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1361,6 +1361,51 @@ xvhsubw_wu_hu    0111 01000101 10101 ..... ..... .....    @vvv
 xvhsubw_du_wu    0111 01000101 10110 ..... ..... .....    @vvv
 xvhsubw_qu_du    0111 01000101 10111 ..... ..... .....    @vvv
 
+xvaddwev_h_b     0111 01000001 11100 ..... ..... .....    @vvv
+xvaddwev_w_h     0111 01000001 11101 ..... ..... .....    @vvv
+xvaddwev_d_w     0111 01000001 11110 ..... ..... .....    @vvv
+xvaddwev_q_d     0111 01000001 11111 ..... ..... .....    @vvv
+xvaddwod_h_b     0111 01000010 00100 ..... ..... .....    @vvv
+xvaddwod_w_h     0111 01000010 00101 ..... ..... .....    @vvv
+xvaddwod_d_w     0111 01000010 00110 ..... ..... .....    @vvv
+xvaddwod_q_d     0111 01000010 00111 ..... ..... .....    @vvv
+
+xvsubwev_h_b     0111 01000010 00000 ..... ..... .....    @vvv
+xvsubwev_w_h     0111 01000010 00001 ..... ..... .....    @vvv
+xvsubwev_d_w     0111 01000010 00010 ..... ..... .....    @vvv
+xvsubwev_q_d     0111 01000010 00011 ..... ..... .....    @vvv
+xvsubwod_h_b     0111 01000010 01000 ..... ..... .....    @vvv
+xvsubwod_w_h     0111 01000010 01001 ..... ..... .....    @vvv
+xvsubwod_d_w     0111 01000010 01010 ..... ..... .....    @vvv
+xvsubwod_q_d     0111 01000010 01011 ..... ..... .....    @vvv
+
+xvaddwev_h_bu    0111 01000010 11100 ..... ..... .....    @vvv
+xvaddwev_w_hu    0111 01000010 11101 ..... ..... .....    @vvv
+xvaddwev_d_wu    0111 01000010 11110 ..... ..... .....    @vvv
+xvaddwev_q_du    0111 01000010 11111 ..... ..... .....    @vvv
+xvaddwod_h_bu    0111 01000011 00100 ..... ..... .....    @vvv
+xvaddwod_w_hu    0111 01000011 00101 ..... ..... .....    @vvv
+xvaddwod_d_wu    0111 01000011 00110 ..... ..... .....    @vvv
+xvaddwod_q_du    0111 01000011 00111 ..... ..... .....    @vvv
+
+xvsubwev_h_bu    0111 01000011 00000 ..... ..... .....    @vvv
+xvsubwev_w_hu    0111 01000011 00001 ..... ..... .....    @vvv
+xvsubwev_d_wu    0111 01000011 00010 ..... ..... .....    @vvv
+xvsubwev_q_du    0111 01000011 00011 ..... ..... .....    @vvv
+xvsubwod_h_bu    0111 01000011 01000 ..... ..... .....    @vvv
+xvsubwod_w_hu    0111 01000011 01001 ..... ..... .....    @vvv
+xvsubwod_d_wu    0111 01000011 01010 ..... ..... .....    @vvv
+xvsubwod_q_du    0111 01000011 01011 ..... ..... .....    @vvv
+
+xvaddwev_h_bu_b  0111 01000011 11100 ..... ..... .....    @vvv
+xvaddwev_w_hu_h  0111 01000011 11101 ..... ..... .....    @vvv
+xvaddwev_d_wu_w  0111 01000011 11110 ..... ..... .....    @vvv
+xvaddwev_q_du_d  0111 01000011 11111 ..... ..... .....    @vvv
+xvaddwod_h_bu_b  0111 01000100 00000 ..... ..... .....    @vvv
+xvaddwod_w_hu_h  0111 01000100 00001 ..... ..... .....    @vvv
+xvaddwod_d_wu_w  0111 01000100 00010 ..... ..... .....    @vvv
+xvaddwod_q_du_d  0111 01000100 00011 ..... ..... .....    @vvv
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index c810a52f0d..e3e57e1d05 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1782,6 +1782,49 @@ INSN_LASX(xvhsubw_wu_hu,     vvv)
 INSN_LASX(xvhsubw_du_wu,     vvv)
 INSN_LASX(xvhsubw_qu_du,     vvv)
 
+INSN_LASX(xvaddwev_h_b,      vvv)
+INSN_LASX(xvaddwev_w_h,      vvv)
+INSN_LASX(xvaddwev_d_w,      vvv)
+INSN_LASX(xvaddwev_q_d,      vvv)
+INSN_LASX(xvaddwod_h_b,      vvv)
+INSN_LASX(xvaddwod_w_h,      vvv)
+INSN_LASX(xvaddwod_d_w,      vvv)
+INSN_LASX(xvaddwod_q_d,      vvv)
+INSN_LASX(xvsubwev_h_b,      vvv)
+INSN_LASX(xvsubwev_w_h,      vvv)
+INSN_LASX(xvsubwev_d_w,      vvv)
+INSN_LASX(xvsubwev_q_d,      vvv)
+INSN_LASX(xvsubwod_h_b,      vvv)
+INSN_LASX(xvsubwod_w_h,      vvv)
+INSN_LASX(xvsubwod_d_w,      vvv)
+INSN_LASX(xvsubwod_q_d,      vvv)
+
+INSN_LASX(xvaddwev_h_bu,     vvv)
+INSN_LASX(xvaddwev_w_hu,     vvv)
+INSN_LASX(xvaddwev_d_wu,     vvv)
+INSN_LASX(xvaddwev_q_du,     vvv)
+INSN_LASX(xvaddwod_h_bu,     vvv)
+INSN_LASX(xvaddwod_w_hu,     vvv)
+INSN_LASX(xvaddwod_d_wu,     vvv)
+INSN_LASX(xvaddwod_q_du,     vvv)
+INSN_LASX(xvsubwev_h_bu,     vvv)
+INSN_LASX(xvsubwev_w_hu,     vvv)
+INSN_LASX(xvsubwev_d_wu,     vvv)
+INSN_LASX(xvsubwev_q_du,     vvv)
+INSN_LASX(xvsubwod_h_bu,     vvv)
+INSN_LASX(xvsubwod_w_hu,     vvv)
+INSN_LASX(xvsubwod_d_wu,     vvv)
+INSN_LASX(xvsubwod_q_du,     vvv)
+
+INSN_LASX(xvaddwev_h_bu_b,   vvv)
+INSN_LASX(xvaddwev_w_hu_h,   vvv)
+INSN_LASX(xvaddwev_d_wu_w,   vvv)
+INSN_LASX(xvaddwev_q_du_d,   vvv)
+INSN_LASX(xvaddwod_h_bu_b,   vvv)
+INSN_LASX(xvaddwod_w_hu_h,   vvv)
+INSN_LASX(xvaddwod_d_wu_w,   vvv)
+INSN_LASX(xvaddwod_q_du_d,   vvv)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 2ce0ca41a7..fc3b07e8d2 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -106,133 +106,173 @@ void HELPER(vhsubw_qu_du)(void *vd, void *vj, void *vk, uint32_t desc)
 }
 
 #define DO_EVEN(NAME, BIT, E1, E2, DO_OP)                        \
-void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t v)      \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)   \
 {                                                                \
     int i;                                                       \
     VReg *Vd = (VReg *)vd;                                       \
     VReg *Vj = (VReg *)vj;                                       \
     VReg *Vk = (VReg *)vk;                                       \
     typedef __typeof(Vd->E1(0)) TD;                              \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                          \
+    int oprsz = simd_oprsz(desc);                                \
+                                                                 \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                    \
         Vd->E1(i) = DO_OP((TD)Vj->E2(2 * i) ,(TD)Vk->E2(2 * i)); \
     }                                                            \
 }
 
 #define DO_ODD(NAME, BIT, E1, E2, DO_OP)                                 \
-void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t v)              \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)           \
 {                                                                        \
     int i;                                                               \
     VReg *Vd = (VReg *)vd;                                               \
     VReg *Vj = (VReg *)vj;                                               \
     VReg *Vk = (VReg *)vk;                                               \
     typedef __typeof(Vd->E1(0)) TD;                                      \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                                  \
+    int oprsz = simd_oprsz(desc);                                        \
+                                                                         \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                            \
         Vd->E1(i) = DO_OP((TD)Vj->E2(2 * i + 1), (TD)Vk->E2(2 * i + 1)); \
     }                                                                    \
 }
 
-void HELPER(vaddwev_q_d)(void *vd, void *vj, void *vk, uint32_t v)
+void HELPER(vaddwev_q_d)(void *vd, void *vj, void *vk, uint32_t desc)
 {
+    int i;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
     VReg *Vk = (VReg *)vk;
+    int oprsz = simd_oprsz(desc);
 
-    Vd->Q(0) = int128_add(int128_makes64(Vj->D(0)), int128_makes64(Vk->D(0)));
+    for (i = 0; i < oprsz / 16; i++) {
+        Vd->Q(i) = int128_add(int128_makes64(Vj->D(2 * i)),
+                              int128_makes64(Vk->D(2 * i)));
+    }
 }
 
 DO_EVEN(vaddwev_h_b, 16, H, B, DO_ADD)
 DO_EVEN(vaddwev_w_h, 32, W, H, DO_ADD)
 DO_EVEN(vaddwev_d_w, 64, D, W, DO_ADD)
 
-void HELPER(vaddwod_q_d)(void *vd, void *vj, void *vk, uint32_t v)
+void HELPER(vaddwod_q_d)(void *vd, void *vj, void *vk, uint32_t desc)
 {
+    int i;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
     VReg *Vk = (VReg *)vk;
+    int oprsz = simd_oprsz(desc);
 
-    Vd->Q(0) = int128_add(int128_makes64(Vj->D(1)), int128_makes64(Vk->D(1)));
+    for (i = 0; i < oprsz / 16; i++) {
+        Vd->Q(i) = int128_add(int128_makes64(Vj->D(2 * i +1)),
+                              int128_makes64(Vk->D(2 * i +1)));
+    }
 }
 
 DO_ODD(vaddwod_h_b, 16, H, B, DO_ADD)
 DO_ODD(vaddwod_w_h, 32, W, H, DO_ADD)
 DO_ODD(vaddwod_d_w, 64, D, W, DO_ADD)
 
-void HELPER(vsubwev_q_d)(void *vd, void *vj, void *vk, uint32_t v)
+void HELPER(vsubwev_q_d)(void *vd, void *vj, void *vk, uint32_t desc)
 {
+    int i;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
     VReg *Vk = (VReg *)vk;
+    int oprsz = simd_oprsz(desc);
 
-    Vd->Q(0) = int128_sub(int128_makes64(Vj->D(0)), int128_makes64(Vk->D(0)));
+    for (i = 0; i < oprsz / 16; i++) {
+        Vd->Q(i) = int128_sub(int128_makes64(Vj->D(2 * i)),
+                              int128_makes64(Vk->D(2 * i)));
+    }
 }
 
 DO_EVEN(vsubwev_h_b, 16, H, B, DO_SUB)
 DO_EVEN(vsubwev_w_h, 32, W, H, DO_SUB)
 DO_EVEN(vsubwev_d_w, 64, D, W, DO_SUB)
 
-void HELPER(vsubwod_q_d)(void *vd, void *vj, void *vk, uint32_t v)
+void HELPER(vsubwod_q_d)(void *vd, void *vj, void *vk, uint32_t desc)
 {
+    int i;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
     VReg *Vk = (VReg *)vk;
+    int oprsz = simd_oprsz(desc);
 
-    Vd->Q(0) = int128_sub(int128_makes64(Vj->D(1)), int128_makes64(Vk->D(1)));
+    for (i = 0; i < oprsz / 16; i++) {
+        Vd->Q(i) = int128_sub(int128_makes64(Vj->D(2 * i + 1)),
+                              int128_makes64(Vk->D(2 * i + 1)));
+    }
 }
 
 DO_ODD(vsubwod_h_b, 16, H, B, DO_SUB)
 DO_ODD(vsubwod_w_h, 32, W, H, DO_SUB)
 DO_ODD(vsubwod_d_w, 64, D, W, DO_SUB)
 
-void HELPER(vaddwev_q_du)(void *vd, void *vj, void *vk, uint32_t v)
+void HELPER(vaddwev_q_du)(void *vd, void *vj, void *vk, uint32_t desc)
 {
+    int i;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
     VReg *Vk = (VReg *)vk;
+    int oprsz = simd_oprsz(desc);
 
-    Vd->Q(0) = int128_add(int128_make64((uint64_t)Vj->D(0)),
-                          int128_make64((uint64_t)Vk->D(0)));
+    for (i = 0; i < oprsz / 16; i++) {
+        Vd->Q(i) = int128_add(int128_make64(Vj->UD(2 * i)),
+                              int128_make64(Vk->UD(2 * i)));
+    }
 }
 
 DO_EVEN(vaddwev_h_bu, 16, UH, UB, DO_ADD)
 DO_EVEN(vaddwev_w_hu, 32, UW, UH, DO_ADD)
 DO_EVEN(vaddwev_d_wu, 64, UD, UW, DO_ADD)
 
-void HELPER(vaddwod_q_du)(void *vd, void *vj, void *vk, uint32_t v)
+void HELPER(vaddwod_q_du)(void *vd, void *vj, void *vk, uint32_t desc)
 {
+    int i;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
     VReg *Vk = (VReg *)vk;
+    int oprsz = simd_oprsz(desc);
 
-    Vd->Q(0) = int128_add(int128_make64((uint64_t)Vj->D(1)),
-                          int128_make64((uint64_t)Vk->D(1)));
+    for (i = 0; i < oprsz / 16; i++) {
+        Vd->Q(i) = int128_add(int128_make64(Vj->UD(2 * i + 1)),
+                              int128_make64(Vk->UD(2 * i + 1)));
+    }
 }
 
 DO_ODD(vaddwod_h_bu, 16, UH, UB, DO_ADD)
 DO_ODD(vaddwod_w_hu, 32, UW, UH, DO_ADD)
 DO_ODD(vaddwod_d_wu, 64, UD, UW, DO_ADD)
 
-void HELPER(vsubwev_q_du)(void *vd, void *vj, void *vk, uint32_t v)
+void HELPER(vsubwev_q_du)(void *vd, void *vj, void *vk, uint32_t desc)
 {
+    int i;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
     VReg *Vk = (VReg *)vk;
+    int oprsz = simd_oprsz(desc);
 
-    Vd->Q(0) = int128_sub(int128_make64((uint64_t)Vj->D(0)),
-                          int128_make64((uint64_t)Vk->D(0)));
+    for (i = 0; i < oprsz / 16; i++) {
+        Vd->Q(i) = int128_sub(int128_make64(Vj->UD(2 * i)),
+                              int128_make64(Vk->UD(2 * i)));
+    }
 }
 
 DO_EVEN(vsubwev_h_bu, 16, UH, UB, DO_SUB)
 DO_EVEN(vsubwev_w_hu, 32, UW, UH, DO_SUB)
 DO_EVEN(vsubwev_d_wu, 64, UD, UW, DO_SUB)
 
-void HELPER(vsubwod_q_du)(void *vd, void *vj, void *vk, uint32_t v)
+void HELPER(vsubwod_q_du)(void *vd, void *vj, void *vk, uint32_t desc)
 {
+    int i;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
     VReg *Vk = (VReg *)vk;
+    int oprsz = simd_oprsz(desc);
 
-    Vd->Q(0) = int128_sub(int128_make64((uint64_t)Vj->D(1)),
-                          int128_make64((uint64_t)Vk->D(1)));
+    for (i = 0; i < oprsz / 16; i++) {
+        Vd->Q(i) = int128_sub(int128_make64(Vj->UD(2 * i + 1)),
+                              int128_make64(Vk->UD(2 * i + 1)));
+    }
 }
 
 DO_ODD(vsubwod_h_bu, 16, UH, UB, DO_SUB)
@@ -240,7 +280,7 @@ DO_ODD(vsubwod_w_hu, 32, UW, UH, DO_SUB)
 DO_ODD(vsubwod_d_wu, 64, UD, UW, DO_SUB)
 
 #define DO_EVEN_U_S(NAME, BIT, ES1, EU1, ES2, EU2, DO_OP)             \
-void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t v)           \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)        \
 {                                                                     \
     int i;                                                            \
     VReg *Vd = (VReg *)vd;                                            \
@@ -248,13 +288,15 @@ void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t v)           \
     VReg *Vk = (VReg *)vk;                                            \
     typedef __typeof(Vd->ES1(0)) TDS;                                 \
     typedef __typeof(Vd->EU1(0)) TDU;                                 \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                               \
+    int oprsz = simd_oprsz(desc);                                     \
+                                                                      \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                         \
         Vd->ES1(i) = DO_OP((TDU)Vj->EU2(2 * i) ,(TDS)Vk->ES2(2 * i)); \
     }                                                                 \
 }
 
 #define DO_ODD_U_S(NAME, BIT, ES1, EU1, ES2, EU2, DO_OP)                      \
-void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t v)                   \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)                \
 {                                                                             \
     int i;                                                                    \
     VReg *Vd = (VReg *)vd;                                                    \
@@ -262,33 +304,43 @@ void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t v)                   \
     VReg *Vk = (VReg *)vk;                                                    \
     typedef __typeof(Vd->ES1(0)) TDS;                                         \
     typedef __typeof(Vd->EU1(0)) TDU;                                         \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                                       \
+    int oprsz = simd_oprsz(desc);                                             \
+                                                                              \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                                 \
         Vd->ES1(i) = DO_OP((TDU)Vj->EU2(2 * i + 1), (TDS)Vk->ES2(2 * i + 1)); \
     }                                                                         \
 }
 
-void HELPER(vaddwev_q_du_d)(void *vd, void *vj, void *vk, uint32_t v)
+void HELPER(vaddwev_q_du_d)(void *vd, void *vj, void *vk, uint32_t desc)
 {
+    int i;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
     VReg *Vk = (VReg *)vk;
+    int oprsz = simd_oprsz(desc);
 
-    Vd->Q(0) = int128_add(int128_make64((uint64_t)Vj->D(0)),
-                          int128_makes64(Vk->D(0)));
+    for (i = 0; i < oprsz / 16; i++) {
+        Vd->Q(i) = int128_add(int128_make64(Vj->UD(2 * i)),
+                              int128_makes64(Vk->D(2 * i)));
+    }
 }
 
 DO_EVEN_U_S(vaddwev_h_bu_b, 16, H, UH, B, UB, DO_ADD)
 DO_EVEN_U_S(vaddwev_w_hu_h, 32, W, UW, H, UH, DO_ADD)
 DO_EVEN_U_S(vaddwev_d_wu_w, 64, D, UD, W, UW, DO_ADD)
 
-void HELPER(vaddwod_q_du_d)(void *vd, void *vj, void *vk, uint32_t v)
+void HELPER(vaddwod_q_du_d)(void *vd, void *vj, void *vk, uint32_t desc)
 {
+    int i;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
     VReg *Vk = (VReg *)vk;
+    int oprsz = simd_oprsz(desc);
 
-    Vd->Q(0) = int128_add(int128_make64((uint64_t)Vj->D(1)),
-                          int128_makes64(Vk->D(1)));
+    for (i = 0; i < oprsz / 16; i++) {
+        Vd->Q(i) = int128_add(int128_make64(Vj->UD(2 * i + 1)),
+                              int128_makes64(Vk->D(2 * i + 1)));
+    }
 }
 
 DO_ODD_U_S(vaddwod_h_bu_b, 16, H, UH, B, UB, DO_ADD)
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 7786f21022..322d43d50c 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -550,6 +550,10 @@ TRANS(vaddwev_h_b, LSX, gvec_vvv, MO_8, do_vaddwev_s)
 TRANS(vaddwev_w_h, LSX, gvec_vvv, MO_16, do_vaddwev_s)
 TRANS(vaddwev_d_w, LSX, gvec_vvv, MO_32, do_vaddwev_s)
 TRANS(vaddwev_q_d, LSX, gvec_vvv, MO_64, do_vaddwev_s)
+TRANS(xvaddwev_h_b, LASX, gvec_xxx, MO_8, do_vaddwev_s)
+TRANS(xvaddwev_w_h, LASX, gvec_xxx, MO_16, do_vaddwev_s)
+TRANS(xvaddwev_d_w, LASX, gvec_xxx, MO_32, do_vaddwev_s)
+TRANS(xvaddwev_q_d, LASX, gvec_xxx, MO_64, do_vaddwev_s)
 
 static void gen_vaddwod_w_h(TCGv_i32 t, TCGv_i32 a, TCGv_i32 b)
 {
@@ -629,6 +633,11 @@ TRANS(vaddwod_h_b, LSX, gvec_vvv, MO_8, do_vaddwod_s)
 TRANS(vaddwod_w_h, LSX, gvec_vvv, MO_16, do_vaddwod_s)
 TRANS(vaddwod_d_w, LSX, gvec_vvv, MO_32, do_vaddwod_s)
 TRANS(vaddwod_q_d, LSX, gvec_vvv, MO_64, do_vaddwod_s)
+TRANS(xvaddwod_h_b, LASX, gvec_xxx, MO_8, do_vaddwod_s)
+TRANS(xvaddwod_w_h, LASX, gvec_xxx, MO_16, do_vaddwod_s)
+TRANS(xvaddwod_d_w, LASX, gvec_xxx, MO_32, do_vaddwod_s)
+TRANS(xvaddwod_q_d, LASX, gvec_xxx, MO_64, do_vaddwod_s)
+
 
 static void gen_vsubwev_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -712,6 +721,10 @@ TRANS(vsubwev_h_b, LSX, gvec_vvv, MO_8, do_vsubwev_s)
 TRANS(vsubwev_w_h, LSX, gvec_vvv, MO_16, do_vsubwev_s)
 TRANS(vsubwev_d_w, LSX, gvec_vvv, MO_32, do_vsubwev_s)
 TRANS(vsubwev_q_d, LSX, gvec_vvv, MO_64, do_vsubwev_s)
+TRANS(xvsubwev_h_b, LASX, gvec_xxx, MO_8, do_vsubwev_s)
+TRANS(xvsubwev_w_h, LASX, gvec_xxx, MO_16, do_vsubwev_s)
+TRANS(xvsubwev_d_w, LASX, gvec_xxx, MO_32, do_vsubwev_s)
+TRANS(xvsubwev_q_d, LASX, gvec_xxx, MO_64, do_vsubwev_s)
 
 static void gen_vsubwod_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -791,6 +804,10 @@ TRANS(vsubwod_h_b, LSX, gvec_vvv, MO_8, do_vsubwod_s)
 TRANS(vsubwod_w_h, LSX, gvec_vvv, MO_16, do_vsubwod_s)
 TRANS(vsubwod_d_w, LSX, gvec_vvv, MO_32, do_vsubwod_s)
 TRANS(vsubwod_q_d, LSX, gvec_vvv, MO_64, do_vsubwod_s)
+TRANS(xvsubwod_h_b, LASX, gvec_xxx, MO_8, do_vsubwod_s)
+TRANS(xvsubwod_w_h, LASX, gvec_xxx, MO_16, do_vsubwod_s)
+TRANS(xvsubwod_d_w, LASX, gvec_xxx, MO_32, do_vsubwod_s)
+TRANS(xvsubwod_q_d, LASX, gvec_xxx, MO_64, do_vsubwod_s)
 
 static void gen_vaddwev_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -866,6 +883,10 @@ TRANS(vaddwev_h_bu, LSX, gvec_vvv, MO_8, do_vaddwev_u)
 TRANS(vaddwev_w_hu, LSX, gvec_vvv, MO_16, do_vaddwev_u)
 TRANS(vaddwev_d_wu, LSX, gvec_vvv, MO_32, do_vaddwev_u)
 TRANS(vaddwev_q_du, LSX, gvec_vvv, MO_64, do_vaddwev_u)
+TRANS(xvaddwev_h_bu, LASX, gvec_xxx, MO_8, do_vaddwev_u)
+TRANS(xvaddwev_w_hu, LASX, gvec_xxx, MO_16, do_vaddwev_u)
+TRANS(xvaddwev_d_wu, LASX, gvec_xxx, MO_32, do_vaddwev_u)
+TRANS(xvaddwev_q_du, LASX, gvec_xxx, MO_64, do_vaddwev_u)
 
 static void gen_vaddwod_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -945,6 +966,10 @@ TRANS(vaddwod_h_bu, LSX, gvec_vvv, MO_8, do_vaddwod_u)
 TRANS(vaddwod_w_hu, LSX, gvec_vvv, MO_16, do_vaddwod_u)
 TRANS(vaddwod_d_wu, LSX, gvec_vvv, MO_32, do_vaddwod_u)
 TRANS(vaddwod_q_du, LSX, gvec_vvv, MO_64, do_vaddwod_u)
+TRANS(xvaddwod_h_bu, LASX, gvec_xxx, MO_8, do_vaddwod_u)
+TRANS(xvaddwod_w_hu, LASX, gvec_xxx, MO_16, do_vaddwod_u)
+TRANS(xvaddwod_d_wu, LASX, gvec_xxx, MO_32, do_vaddwod_u)
+TRANS(xvaddwod_q_du, LASX, gvec_xxx, MO_64, do_vaddwod_u)
 
 static void gen_vsubwev_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -1020,6 +1045,10 @@ TRANS(vsubwev_h_bu, LSX, gvec_vvv, MO_8, do_vsubwev_u)
 TRANS(vsubwev_w_hu, LSX, gvec_vvv, MO_16, do_vsubwev_u)
 TRANS(vsubwev_d_wu, LSX, gvec_vvv, MO_32, do_vsubwev_u)
 TRANS(vsubwev_q_du, LSX, gvec_vvv, MO_64, do_vsubwev_u)
+TRANS(xvsubwev_h_bu, LASX, gvec_xxx, MO_8, do_vsubwev_u)
+TRANS(xvsubwev_w_hu, LASX, gvec_xxx, MO_16, do_vsubwev_u)
+TRANS(xvsubwev_d_wu, LASX, gvec_xxx, MO_32, do_vsubwev_u)
+TRANS(xvsubwev_q_du, LASX, gvec_xxx, MO_64, do_vsubwev_u)
 
 static void gen_vsubwod_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -1099,6 +1128,10 @@ TRANS(vsubwod_h_bu, LSX, gvec_vvv, MO_8, do_vsubwod_u)
 TRANS(vsubwod_w_hu, LSX, gvec_vvv, MO_16, do_vsubwod_u)
 TRANS(vsubwod_d_wu, LSX, gvec_vvv, MO_32, do_vsubwod_u)
 TRANS(vsubwod_q_du, LSX, gvec_vvv, MO_64, do_vsubwod_u)
+TRANS(xvsubwod_h_bu, LASX, gvec_xxx, MO_8, do_vsubwod_u)
+TRANS(xvsubwod_w_hu, LASX, gvec_xxx, MO_16, do_vsubwod_u)
+TRANS(xvsubwod_d_wu, LASX, gvec_xxx, MO_32, do_vsubwod_u)
+TRANS(xvsubwod_q_du, LASX, gvec_xxx, MO_64, do_vsubwod_u)
 
 static void gen_vaddwev_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -1182,6 +1215,10 @@ TRANS(vaddwev_h_bu_b, LSX, gvec_vvv, MO_8, do_vaddwev_u_s)
 TRANS(vaddwev_w_hu_h, LSX, gvec_vvv, MO_16, do_vaddwev_u_s)
 TRANS(vaddwev_d_wu_w, LSX, gvec_vvv, MO_32, do_vaddwev_u_s)
 TRANS(vaddwev_q_du_d, LSX, gvec_vvv, MO_64, do_vaddwev_u_s)
+TRANS(xvaddwev_h_bu_b, LASX, gvec_xxx, MO_8, do_vaddwev_u_s)
+TRANS(xvaddwev_w_hu_h, LASX, gvec_xxx, MO_16, do_vaddwev_u_s)
+TRANS(xvaddwev_d_wu_w, LASX, gvec_xxx, MO_32, do_vaddwev_u_s)
+TRANS(xvaddwev_q_du_d, LASX, gvec_xxx, MO_64, do_vaddwev_u_s)
 
 static void gen_vaddwod_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -1262,6 +1299,10 @@ TRANS(vaddwod_h_bu_b, LSX, gvec_vvv, MO_8, do_vaddwod_u_s)
 TRANS(vaddwod_w_hu_h, LSX, gvec_vvv, MO_16, do_vaddwod_u_s)
 TRANS(vaddwod_d_wu_w, LSX, gvec_vvv, MO_32, do_vaddwod_u_s)
 TRANS(vaddwod_q_du_d, LSX, gvec_vvv, MO_64, do_vaddwod_u_s)
+TRANS(xvaddwod_h_bu_b, LSX, gvec_xxx, MO_8, do_vaddwod_u_s)
+TRANS(xvaddwod_w_hu_h, LSX, gvec_xxx, MO_16, do_vaddwod_u_s)
+TRANS(xvaddwod_d_wu_w, LSX, gvec_xxx, MO_32, do_vaddwod_u_s)
+TRANS(xvaddwod_q_du_d, LSX, gvec_xxx, MO_64, do_vaddwod_u_s)
 
 static void do_vavg(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b,
                     void (*gen_shr_vec)(unsigned, TCGv_vec,
-- 
2.39.1


