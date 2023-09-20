Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8687A7378
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 08:58:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qir4H-0007nb-V4; Wed, 20 Sep 2023 02:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qir4F-0007mv-4c
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 02:52:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qir4C-000426-R6
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 02:52:10 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxNvGLlgploy8qAA--.15179S3;
 Wed, 20 Sep 2023 14:51:55 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dxzdx7lgplhVYMAA--.24315S21; 
 Wed, 20 Sep 2023 14:51:54 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 19/57] target/loongarch: Implement xvhaddw/xvhsubw
Date: Wed, 20 Sep 2023 14:51:01 +0800
Message-Id: <20230920065139.1403868-20-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230920065139.1403868-1-gaosong@loongson.cn>
References: <20230920065139.1403868-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxzdx7lgplhVYMAA--.24315S21
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
- XVHADDW.{H.B/W.H/D.W/Q.D/HU.BU/WU.HU/DU.WU/QU.DU};
- XVHSUBW.{H.B/W.H/D.W/Q.D/HU.BU/WU.HU/DU.WU/QU.DU}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230914022645.1151356-20-gaosong@loongson.cn>
---
 target/loongarch/insns.decode               | 18 +++++++++++
 target/loongarch/disas.c                    | 17 +++++++++++
 target/loongarch/vec_helper.c               | 34 ++++++++++++++++-----
 target/loongarch/insn_trans/trans_vec.c.inc | 30 +++++++++++++++---
 4 files changed, 88 insertions(+), 11 deletions(-)

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
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 4ba4fbfc64..c810a52f0d 100644
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
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index c784f98ab2..2ce0ca41a7 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -13,6 +13,7 @@
 #include "internals.h"
 #include "tcg/tcg.h"
 #include "vec.h"
+#include "tcg/tcg-gvec-desc.h"
 
 #define DO_ADD(a, b)  (a + b)
 #define DO_SUB(a, b)  (a - b)
@@ -25,8 +26,9 @@ void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)       \
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
@@ -37,11 +39,16 @@ DO_ODD_EVEN(vhaddw_d_w, 64, D, W, DO_ADD)
 
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
@@ -50,11 +57,16 @@ DO_ODD_EVEN(vhsubw_d_w, 64, D, W, DO_SUB)
 
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
@@ -63,12 +75,16 @@ DO_ODD_EVEN(vhaddw_du_wu, 64, UD, UW, DO_ADD)
 
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
@@ -77,12 +93,16 @@ DO_ODD_EVEN(vhsubw_du_wu, 64, UD, UW, DO_SUB)
 
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
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 0f9a85bbb2..7786f21022 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -97,6 +97,10 @@ static bool gen_vvv_ptr(DisasContext *ctx, arg_vvv *a,
 static bool gen_vvv_vl(DisasContext *ctx, arg_vvv *a, uint32_t oprsz,
                        gen_helper_gvec_3 *fn)
 {
+    if (!check_vec(ctx, oprsz)) {
+        return true;
+    }
+
     tcg_gen_gvec_3_ool(vec_full_offset(a->vd),
                        vec_full_offset(a->vj),
                        vec_full_offset(a->vk),
@@ -106,13 +110,14 @@ static bool gen_vvv_vl(DisasContext *ctx, arg_vvv *a, uint32_t oprsz,
 
 static bool gen_vvv(DisasContext *ctx, arg_vvv *a, gen_helper_gvec_3 *fn)
 {
-    if (!check_vec(ctx, 16)) {
-        return true;
-    }
-
     return gen_vvv_vl(ctx, a, 16, fn);
 }
 
+static bool gen_xxx(DisasContext *ctx, arg_vvv *a, gen_helper_gvec_3 *fn)
+{
+    return gen_vvv_vl(ctx, a, 32, fn);
+}
+
 static bool gen_vv_ptr_vl(DisasContext *ctx, arg_vv *a, uint32_t oprsz,
                           gen_helper_gvec_2_ptr *fn)
 {
@@ -446,6 +451,23 @@ TRANS(vhsubw_wu_hu, LSX, gen_vvv, gen_helper_vhsubw_wu_hu)
 TRANS(vhsubw_du_wu, LSX, gen_vvv, gen_helper_vhsubw_du_wu)
 TRANS(vhsubw_qu_du, LSX, gen_vvv, gen_helper_vhsubw_qu_du)
 
+TRANS(xvhaddw_h_b, LASX, gen_xxx, gen_helper_vhaddw_h_b)
+TRANS(xvhaddw_w_h, LASX, gen_xxx, gen_helper_vhaddw_w_h)
+TRANS(xvhaddw_d_w, LASX, gen_xxx, gen_helper_vhaddw_d_w)
+TRANS(xvhaddw_q_d, LASX, gen_xxx, gen_helper_vhaddw_q_d)
+TRANS(xvhaddw_hu_bu, LASX, gen_xxx, gen_helper_vhaddw_hu_bu)
+TRANS(xvhaddw_wu_hu, LASX, gen_xxx, gen_helper_vhaddw_wu_hu)
+TRANS(xvhaddw_du_wu, LASX, gen_xxx, gen_helper_vhaddw_du_wu)
+TRANS(xvhaddw_qu_du, LASX, gen_xxx, gen_helper_vhaddw_qu_du)
+TRANS(xvhsubw_h_b, LASX, gen_xxx, gen_helper_vhsubw_h_b)
+TRANS(xvhsubw_w_h, LASX, gen_xxx, gen_helper_vhsubw_w_h)
+TRANS(xvhsubw_d_w, LASX, gen_xxx, gen_helper_vhsubw_d_w)
+TRANS(xvhsubw_q_d, LASX, gen_xxx, gen_helper_vhsubw_q_d)
+TRANS(xvhsubw_hu_bu, LASX, gen_xxx, gen_helper_vhsubw_hu_bu)
+TRANS(xvhsubw_wu_hu, LASX, gen_xxx, gen_helper_vhsubw_wu_hu)
+TRANS(xvhsubw_du_wu, LASX, gen_xxx, gen_helper_vhsubw_du_wu)
+TRANS(xvhsubw_qu_du, LASX, gen_xxx, gen_helper_vhsubw_qu_du)
+
 static void gen_vaddwev_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
     TCGv_vec t1, t2;
-- 
2.39.1


