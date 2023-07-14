Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDBE753595
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 10:50:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKETD-00083X-2J; Fri, 14 Jul 2023 04:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qKESx-0007Q1-CB
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:47:55 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qKESq-00057O-Gl
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:47:54 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxlPBgC7FkV84EAA--.13324S3;
 Fri, 14 Jul 2023 16:46:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxzyNYC7FkFOotAA--.22026S12; 
 Fri, 14 Jul 2023 16:46:22 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 10/47] target/loongarch: Implement xvhaddw/xvhsubw
Date: Fri, 14 Jul 2023 16:45:38 +0800
Message-Id: <20230714084615.2448038-11-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230714084615.2448038-1-gaosong@loongson.cn>
References: <20230714084615.2448038-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzyNYC7FkFOotAA--.22026S12
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
- XVHADDW.{H.B/W.H/D.W/Q.D/HU.BU/WU.HU/DU.WU/QU.DU};
- XVHSUBW.{H.B/W.H/D.W/Q.D/HU.BU/WU.HU/DU.WU/QU.DU}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     | 17 +++++++++
 target/loongarch/insn_trans/trans_lasx.c.inc | 17 +++++++++
 target/loongarch/insns.decode                | 18 ++++++++++
 target/loongarch/meson.build                 |  2 +-
 target/loongarch/vec.h                       |  3 ++
 target/loongarch/vec_helper.c                | 36 ++++++++++++++------
 6 files changed, 82 insertions(+), 11 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 0fd88a56c1..e188220519 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1765,6 +1765,23 @@ INSN_LASX(xvssub_hu,         vvv)
 INSN_LASX(xvssub_wu,         vvv)
 INSN_LASX(xvssub_du,         vvv)
 
+INSN_LASX(xvhaddw_h_b,       vvv)
+INSN_LASX(xvhaddw_w_h,       vvv)
+INSN_LASX(xvhaddw_d_w,       vvv)
+INSN_LASX(xvhaddw_q_d,       vvv)
+INSN_LASX(xvhaddw_hu_bu,     vvv)
+INSN_LASX(xvhaddw_wu_hu,     vvv)
+INSN_LASX(xvhaddw_du_wu,     vvv)
+INSN_LASX(xvhaddw_qu_du,     vvv)
+INSN_LASX(xvhsubw_h_b,       vvv)
+INSN_LASX(xvhsubw_w_h,       vvv)
+INSN_LASX(xvhsubw_d_w,       vvv)
+INSN_LASX(xvhsubw_q_d,       vvv)
+INSN_LASX(xvhsubw_hu_bu,     vvv)
+INSN_LASX(xvhsubw_wu_hu,     vvv)
+INSN_LASX(xvhsubw_du_wu,     vvv)
+INSN_LASX(xvhsubw_qu_du,     vvv)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 275c6172b4..4272bafda2 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -78,6 +78,23 @@ TRANS(xvssub_hu, gvec_vvv, 32, MO_16, tcg_gen_gvec_ussub)
 TRANS(xvssub_wu, gvec_vvv, 32, MO_32, tcg_gen_gvec_ussub)
 TRANS(xvssub_du, gvec_vvv, 32, MO_64, tcg_gen_gvec_ussub)
 
+TRANS(xvhaddw_h_b, gen_vvv, 32, gen_helper_vhaddw_h_b)
+TRANS(xvhaddw_w_h, gen_vvv, 32, gen_helper_vhaddw_w_h)
+TRANS(xvhaddw_d_w, gen_vvv, 32, gen_helper_vhaddw_d_w)
+TRANS(xvhaddw_q_d, gen_vvv, 32, gen_helper_vhaddw_q_d)
+TRANS(xvhaddw_hu_bu, gen_vvv, 32, gen_helper_vhaddw_hu_bu)
+TRANS(xvhaddw_wu_hu, gen_vvv, 32, gen_helper_vhaddw_wu_hu)
+TRANS(xvhaddw_du_wu, gen_vvv, 32, gen_helper_vhaddw_du_wu)
+TRANS(xvhaddw_qu_du, gen_vvv, 32, gen_helper_vhaddw_qu_du)
+TRANS(xvhsubw_h_b, gen_vvv, 32, gen_helper_vhsubw_h_b)
+TRANS(xvhsubw_w_h, gen_vvv, 32, gen_helper_vhsubw_w_h)
+TRANS(xvhsubw_d_w, gen_vvv, 32, gen_helper_vhsubw_d_w)
+TRANS(xvhsubw_q_d, gen_vvv, 32, gen_helper_vhsubw_q_d)
+TRANS(xvhsubw_hu_bu, gen_vvv, 32, gen_helper_vhsubw_hu_bu)
+TRANS(xvhsubw_wu_hu, gen_vvv, 32, gen_helper_vhsubw_wu_hu)
+TRANS(xvhsubw_du_wu, gen_vvv, 32, gen_helper_vhsubw_du_wu)
+TRANS(xvhsubw_qu_du, gen_vvv, 32, gen_helper_vhsubw_qu_du)
+
 TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 32f857ff7c..ba0b36f4a7 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1343,6 +1343,24 @@ xvssub_hu        0111 01000100 11001 ..... ..... .....    @vvv
 xvssub_wu        0111 01000100 11010 ..... ..... .....    @vvv
 xvssub_du        0111 01000100 11011 ..... ..... .....    @vvv
 
+xvhaddw_h_b      0111 01000101 01000 ..... ..... .....    @vvv
+xvhaddw_w_h      0111 01000101 01001 ..... ..... .....    @vvv
+xvhaddw_d_w      0111 01000101 01010 ..... ..... .....    @vvv
+xvhaddw_q_d      0111 01000101 01011 ..... ..... .....    @vvv
+xvhaddw_hu_bu    0111 01000101 10000 ..... ..... .....    @vvv
+xvhaddw_wu_hu    0111 01000101 10001 ..... ..... .....    @vvv
+xvhaddw_du_wu    0111 01000101 10010 ..... ..... .....    @vvv
+xvhaddw_qu_du    0111 01000101 10011 ..... ..... .....    @vvv
+
+xvhsubw_h_b      0111 01000101 01100 ..... ..... .....    @vvv
+xvhsubw_w_h      0111 01000101 01101 ..... ..... .....    @vvv
+xvhsubw_d_w      0111 01000101 01110 ..... ..... .....    @vvv
+xvhsubw_q_d      0111 01000101 01111 ..... ..... .....    @vvv
+xvhsubw_hu_bu    0111 01000101 10100 ..... ..... .....    @vvv
+xvhsubw_wu_hu    0111 01000101 10101 ..... ..... .....    @vvv
+xvhsubw_du_wu    0111 01000101 10110 ..... ..... .....    @vvv
+xvhsubw_qu_du    0111 01000101 10111 ..... ..... .....    @vvv
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/meson.build b/target/loongarch/meson.build
index b7a27df5a9..7fbf045a5d 100644
--- a/target/loongarch/meson.build
+++ b/target/loongarch/meson.build
@@ -11,7 +11,7 @@ loongarch_tcg_ss.add(files(
   'op_helper.c',
   'translate.c',
   'gdbstub.c',
-  'lsx_helper.c',
+  'vec_helper.c',
 ))
 loongarch_tcg_ss.add(zlib)
 
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index 512f2fd83f..5332dff83c 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -47,4 +47,7 @@
 #define Q(x)  Q[x]
 #endif /* HOST_BIG_ENDIAN */
 
+#define DO_ADD(a, b)  (a + b)
+#define DO_SUB(a, b)  (a - b)
+
 #endif /* LOONGARCH_VEC_H */
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 7c6efe77eb..cfb0b7afbb 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -14,9 +14,6 @@
 #include "tcg/tcg.h"
 #include "vec.h"
 
-#define DO_ADD(a, b)  (a + b)
-#define DO_SUB(a, b)  (a - b)
-
 #define DO_ODD_EVEN(NAME, BIT, E1, E2, DO_OP)                        \
 void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)       \
 {                                                                    \
@@ -25,8 +22,9 @@ void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)       \
     VReg *Vj = (VReg *)vj;                                           \
     VReg *Vk = (VReg *)vk;                                           \
     typedef __typeof(Vd->E1(0)) TD;                                  \
+    int oprsz = simd_oprsz(desc);                                    \
                                                                      \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                              \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                        \
         Vd->E1(i) = DO_OP((TD)Vj->E2(2 * i + 1), (TD)Vk->E2(2 * i)); \
     }                                                                \
 }
@@ -37,11 +35,16 @@ DO_ODD_EVEN(vhaddw_d_w, 64, D, W, DO_ADD)
 
 void HELPER(vhaddw_q_d)(void *vd, void *vj, void *vk, uint32_t desc)
 {
+    int i;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
     VReg *Vk = (VReg *)vk;
+    int oprsz = simd_oprsz(desc);
 
-    Vd->Q(0) = int128_add(int128_makes64(Vj->D(1)), int128_makes64(Vk->D(0)));
+    for (i = 0; i < oprsz / 16 ; i++) {
+        Vd->Q(i) = int128_add(int128_makes64(Vj->D(2 * i + 1)),
+                              int128_makes64(Vk->D(2 * i)));
+    }
 }
 
 DO_ODD_EVEN(vhsubw_h_b, 16, H, B, DO_SUB)
@@ -50,11 +53,16 @@ DO_ODD_EVEN(vhsubw_d_w, 64, D, W, DO_SUB)
 
 void HELPER(vhsubw_q_d)(void *vd, void *vj, void *vk, uint32_t desc)
 {
+    int i;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
     VReg *Vk = (VReg *)vk;
+    int oprsz = simd_oprsz(desc);
 
-    Vd->Q(0) = int128_sub(int128_makes64(Vj->D(1)), int128_makes64(Vk->D(0)));
+    for (i = 0; i < oprsz / 16; i++) {
+        Vd->Q(i) = int128_sub(int128_makes64(Vj->D(2 * i + 1)),
+                              int128_makes64(Vk->D(2 * i)));
+    }
 }
 
 DO_ODD_EVEN(vhaddw_hu_bu, 16, UH, UB, DO_ADD)
@@ -63,12 +71,16 @@ DO_ODD_EVEN(vhaddw_du_wu, 64, UD, UW, DO_ADD)
 
 void HELPER(vhaddw_qu_du)(void *vd, void *vj, void *vk, uint32_t desc)
 {
+    int i;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
     VReg *Vk = (VReg *)vk;
+    int oprsz = simd_oprsz(desc);
 
-    Vd->Q(0) = int128_add(int128_make64((uint64_t)Vj->D(1)),
-                          int128_make64((uint64_t)Vk->D(0)));
+    for (i = 0; i < oprsz / 16; i ++) {
+        Vd->Q(i) = int128_add(int128_make64(Vj->UD(2 * i + 1)),
+                              int128_make64(Vk->UD(2 * i)));
+    }
 }
 
 DO_ODD_EVEN(vhsubw_hu_bu, 16, UH, UB, DO_SUB)
@@ -77,12 +89,16 @@ DO_ODD_EVEN(vhsubw_du_wu, 64, UD, UW, DO_SUB)
 
 void HELPER(vhsubw_qu_du)(void *vd, void *vj, void *vk, uint32_t desc)
 {
+    int i;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
     VReg *Vk = (VReg *)vk;
+    int oprsz = simd_oprsz(desc);
 
-    Vd->Q(0) = int128_sub(int128_make64((uint64_t)Vj->D(1)),
-                          int128_make64((uint64_t)Vk->D(0)));
+    for (i = 0; i < oprsz / 16; i++) {
+        Vd->Q(i) = int128_sub(int128_make64(Vj->UD(2 * i + 1)),
+                              int128_make64(Vk->UD(2 * i)));
+    }
 }
 
 #define DO_EVEN(NAME, BIT, E1, E2, DO_OP)                        \
-- 
2.39.1


