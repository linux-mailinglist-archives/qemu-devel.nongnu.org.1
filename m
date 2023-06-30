Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DC6743651
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:00:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF92X-0008AS-Bg; Fri, 30 Jun 2023 03:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qF92Q-00089f-P3
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:31 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qF92O-0007vt-2B
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:30 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxV8VSi55kbjQEAA--.6968S3;
 Fri, 30 Jun 2023 15:59:14 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxjiNIi55kExQTAA--.24469S12; 
 Fri, 30 Jun 2023 15:59:13 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 10/46] target/loongarch: Implement xvaddw/xvsubw
Date: Fri, 30 Jun 2023 15:58:28 +0800
Message-Id: <20230630075904.45940-11-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230630075904.45940-1-gaosong@loongson.cn>
References: <20230630075904.45940-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjiNIi55kExQTAA--.24469S12
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
- XVADDW{EV/OD}.{H.B/W.H/D.W/Q.D}[U];
- XVSUBW{EV/OD}.{H.B/W.H/D.W/Q.D}[U];
- XVADDW{EV/OD}.{H.BU.B/W.HU.H/D.WU.W/Q.DU.D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     | 43 ++++++++++
 target/loongarch/insn_trans/trans_lasx.c.inc | 45 +++++++++++
 target/loongarch/insns.decode                | 45 +++++++++++
 target/loongarch/vec_helper.c                | 85 +++++++++++++++-----
 4 files changed, 200 insertions(+), 18 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index e188220519..6972e33833 100644
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
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 4272bafda2..d8230cba9f 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -95,6 +95,51 @@ TRANS(xvhsubw_wu_hu, gen_vvv, 32, gen_helper_vhsubw_wu_hu)
 TRANS(xvhsubw_du_wu, gen_vvv, 32, gen_helper_vhsubw_du_wu)
 TRANS(xvhsubw_qu_du, gen_vvv, 32, gen_helper_vhsubw_qu_du)
 
+TRANS(xvaddwev_h_b, gvec_vvv, 32, MO_8, do_vaddwev_s)
+TRANS(xvaddwev_w_h, gvec_vvv, 32, MO_16, do_vaddwev_s)
+TRANS(xvaddwev_d_w, gvec_vvv, 32, MO_32, do_vaddwev_s)
+TRANS(xvaddwev_q_d, gvec_vvv, 32, MO_64, do_vaddwev_s)
+TRANS(xvaddwod_h_b, gvec_vvv, 32, MO_8, do_vaddwod_s)
+TRANS(xvaddwod_w_h, gvec_vvv, 32, MO_16, do_vaddwod_s)
+TRANS(xvaddwod_d_w, gvec_vvv, 32, MO_32, do_vaddwod_s)
+TRANS(xvaddwod_q_d, gvec_vvv, 32, MO_64, do_vaddwod_s)
+
+TRANS(xvsubwev_h_b, gvec_vvv, 32, MO_8, do_vsubwev_s)
+TRANS(xvsubwev_w_h, gvec_vvv, 32, MO_16, do_vsubwev_s)
+TRANS(xvsubwev_d_w, gvec_vvv, 32, MO_32, do_vsubwev_s)
+TRANS(xvsubwev_q_d, gvec_vvv, 32, MO_64, do_vsubwev_s)
+TRANS(xvsubwod_h_b, gvec_vvv, 32, MO_8, do_vsubwod_s)
+TRANS(xvsubwod_w_h, gvec_vvv, 32, MO_16, do_vsubwod_s)
+TRANS(xvsubwod_d_w, gvec_vvv, 32, MO_32, do_vsubwod_s)
+TRANS(xvsubwod_q_d, gvec_vvv, 32, MO_64, do_vsubwod_s)
+
+TRANS(xvaddwev_h_bu, gvec_vvv, 32, MO_8, do_vaddwev_u)
+TRANS(xvaddwev_w_hu, gvec_vvv, 32, MO_16, do_vaddwev_u)
+TRANS(xvaddwev_d_wu, gvec_vvv, 32, MO_32, do_vaddwev_u)
+TRANS(xvaddwev_q_du, gvec_vvv, 32, MO_64, do_vaddwev_u)
+TRANS(xvaddwod_h_bu, gvec_vvv, 32, MO_8, do_vaddwod_u)
+TRANS(xvaddwod_w_hu, gvec_vvv, 32, MO_16, do_vaddwod_u)
+TRANS(xvaddwod_d_wu, gvec_vvv, 32, MO_32, do_vaddwod_u)
+TRANS(xvaddwod_q_du, gvec_vvv, 32, MO_64, do_vaddwod_u)
+
+TRANS(xvsubwev_h_bu, gvec_vvv, 32, MO_8, do_vsubwev_u)
+TRANS(xvsubwev_w_hu, gvec_vvv, 32, MO_16, do_vsubwev_u)
+TRANS(xvsubwev_d_wu, gvec_vvv, 32, MO_32, do_vsubwev_u)
+TRANS(xvsubwev_q_du, gvec_vvv, 32, MO_64, do_vsubwev_u)
+TRANS(xvsubwod_h_bu, gvec_vvv, 32, MO_8, do_vsubwod_u)
+TRANS(xvsubwod_w_hu, gvec_vvv, 32, MO_16, do_vsubwod_u)
+TRANS(xvsubwod_d_wu, gvec_vvv, 32, MO_32, do_vsubwod_u)
+TRANS(xvsubwod_q_du, gvec_vvv, 32, MO_64, do_vsubwod_u)
+
+TRANS(xvaddwev_h_bu_b, gvec_vvv, 32, MO_8, do_vaddwev_u_s)
+TRANS(xvaddwev_w_hu_h, gvec_vvv, 32, MO_16, do_vaddwev_u_s)
+TRANS(xvaddwev_d_wu_w, gvec_vvv, 32, MO_32, do_vaddwev_u_s)
+TRANS(xvaddwev_q_du_d, gvec_vvv, 32, MO_64, do_vaddwev_u_s)
+TRANS(xvaddwod_h_bu_b, gvec_vvv, 32, MO_8, do_vaddwod_u_s)
+TRANS(xvaddwod_w_hu_h, gvec_vvv, 32, MO_16, do_vaddwod_u_s)
+TRANS(xvaddwod_d_wu_w, gvec_vvv, 32, MO_32, do_vaddwod_u_s)
+TRANS(xvaddwod_q_du_d, gvec_vvv, 32, MO_64, do_vaddwod_u_s)
+
 TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
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
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index bd7389407b..411d94780d 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -13,6 +13,7 @@
 #include "internals.h"
 #include "tcg/tcg.h"
 #include "vec.h"
+#include "tcg/tcg-gvec-desc.h"
 
 #define DO_ODD_EVEN(NAME, BIT, E1, E2, DO_OP)                        \
 void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz,            \
@@ -105,12 +106,14 @@ void HELPER(vhsubw_qu_du)(CPULoongArchState *env, uint32_t oprsz,
 #define DO_EVEN(NAME, BIT, E1, E2, DO_OP)                        \
 void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t v)      \
 {                                                                \
-    int i;                                                       \
+    int i, len;                                                  \
     VReg *Vd = (VReg *)vd;                                       \
     VReg *Vj = (VReg *)vj;                                       \
     VReg *Vk = (VReg *)vk;                                       \
     typedef __typeof(Vd->E1(0)) TD;                              \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                          \
+                                                                 \
+    len = (simd_oprsz(v) == 16) ? LSX_LEN : LASX_LEN;            \
+    for (i = 0; i < len / BIT; i++) {                            \
         Vd->E1(i) = DO_OP((TD)Vj->E2(2 * i) ,(TD)Vk->E2(2 * i)); \
     }                                                            \
 }
@@ -118,12 +121,14 @@ void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t v)      \
 #define DO_ODD(NAME, BIT, E1, E2, DO_OP)                                 \
 void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t v)              \
 {                                                                        \
-    int i;                                                               \
+    int i, len;                                                          \
     VReg *Vd = (VReg *)vd;                                               \
     VReg *Vj = (VReg *)vj;                                               \
     VReg *Vk = (VReg *)vk;                                               \
     typedef __typeof(Vd->E1(0)) TD;                                      \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                                  \
+                                                                         \
+    len = (simd_oprsz(v) == 16) ? LSX_LEN : LASX_LEN;                    \
+    for (i = 0; i < len / BIT; i++) {                                    \
         Vd->E1(i) = DO_OP((TD)Vj->E2(2 * i + 1), (TD)Vk->E2(2 * i + 1)); \
     }                                                                    \
 }
@@ -135,6 +140,10 @@ void HELPER(vaddwev_q_d)(void *vd, void *vj, void *vk, uint32_t v)
     VReg *Vk = (VReg *)vk;
 
     Vd->Q(0) = int128_add(int128_makes64(Vj->D(0)), int128_makes64(Vk->D(0)));
+    if (simd_oprsz(v) == 32) {
+        Vd->Q(1) = int128_add(int128_makes64(Vj->D(2)),
+                              int128_makes64(Vk->D(2)));
+    }
 }
 
 DO_EVEN(vaddwev_h_b, 16, H, B, DO_ADD)
@@ -148,6 +157,10 @@ void HELPER(vaddwod_q_d)(void *vd, void *vj, void *vk, uint32_t v)
     VReg *Vk = (VReg *)vk;
 
     Vd->Q(0) = int128_add(int128_makes64(Vj->D(1)), int128_makes64(Vk->D(1)));
+    if (simd_oprsz(v) == 32) {
+        Vd->Q(1) = int128_add(int128_makes64(Vj->D(3)),
+                              int128_makes64(Vk->D(3)));
+    }
 }
 
 DO_ODD(vaddwod_h_b, 16, H, B, DO_ADD)
@@ -161,6 +174,10 @@ void HELPER(vsubwev_q_d)(void *vd, void *vj, void *vk, uint32_t v)
     VReg *Vk = (VReg *)vk;
 
     Vd->Q(0) = int128_sub(int128_makes64(Vj->D(0)), int128_makes64(Vk->D(0)));
+    if (simd_oprsz(v) == 32) {
+        Vd->Q(1) = int128_sub(int128_makes64(Vj->D(2)),
+                              int128_makes64(Vk->D(2)));
+    }
 }
 
 DO_EVEN(vsubwev_h_b, 16, H, B, DO_SUB)
@@ -174,6 +191,10 @@ void HELPER(vsubwod_q_d)(void *vd, void *vj, void *vk, uint32_t v)
     VReg *Vk = (VReg *)vk;
 
     Vd->Q(0) = int128_sub(int128_makes64(Vj->D(1)), int128_makes64(Vk->D(1)));
+    if (simd_oprsz(v) == 32) {
+        Vd->Q(1) = int128_sub(int128_makes64(Vj->D(3)),
+                              int128_makes64(Vk->D(3)));
+    }
 }
 
 DO_ODD(vsubwod_h_b, 16, H, B, DO_SUB)
@@ -186,8 +207,12 @@ void HELPER(vaddwev_q_du)(void *vd, void *vj, void *vk, uint32_t v)
     VReg *Vj = (VReg *)vj;
     VReg *Vk = (VReg *)vk;
 
-    Vd->Q(0) = int128_add(int128_make64((uint64_t)Vj->D(0)),
-                          int128_make64((uint64_t)Vk->D(0)));
+    Vd->Q(0) = int128_add(int128_make64(Vj->UD(0)),
+                          int128_make64(Vk->UD(0)));
+    if (simd_oprsz(v) == 32) {
+        Vd->Q(1) = int128_add(int128_make64(Vj->UD(2)),
+                              int128_make64(Vk->UD(2)));
+    }
 }
 
 DO_EVEN(vaddwev_h_bu, 16, UH, UB, DO_ADD)
@@ -200,8 +225,12 @@ void HELPER(vaddwod_q_du)(void *vd, void *vj, void *vk, uint32_t v)
     VReg *Vj = (VReg *)vj;
     VReg *Vk = (VReg *)vk;
 
-    Vd->Q(0) = int128_add(int128_make64((uint64_t)Vj->D(1)),
-                          int128_make64((uint64_t)Vk->D(1)));
+    Vd->Q(0) = int128_add(int128_make64(Vj->UD(1)),
+                          int128_make64(Vk->UD(1)));
+    if (simd_oprsz(v) == 32) {
+        Vd->Q(1) = int128_add(int128_make64(Vj->UD(3)),
+                              int128_make64(Vk->UD(3)));
+    }
 }
 
 DO_ODD(vaddwod_h_bu, 16, UH, UB, DO_ADD)
@@ -214,8 +243,12 @@ void HELPER(vsubwev_q_du)(void *vd, void *vj, void *vk, uint32_t v)
     VReg *Vj = (VReg *)vj;
     VReg *Vk = (VReg *)vk;
 
-    Vd->Q(0) = int128_sub(int128_make64((uint64_t)Vj->D(0)),
-                          int128_make64((uint64_t)Vk->D(0)));
+    Vd->Q(0) = int128_sub(int128_make64(Vj->UD(0)),
+                          int128_make64(Vk->UD(0)));
+    if (simd_oprsz(v) == 32) {
+        Vd->Q(1) = int128_sub(int128_make64(Vj->UD(2)),
+                              int128_make64(Vk->UD(2)));
+    }
 }
 
 DO_EVEN(vsubwev_h_bu, 16, UH, UB, DO_SUB)
@@ -228,8 +261,12 @@ void HELPER(vsubwod_q_du)(void *vd, void *vj, void *vk, uint32_t v)
     VReg *Vj = (VReg *)vj;
     VReg *Vk = (VReg *)vk;
 
-    Vd->Q(0) = int128_sub(int128_make64((uint64_t)Vj->D(1)),
-                          int128_make64((uint64_t)Vk->D(1)));
+    Vd->Q(0) = int128_sub(int128_make64(Vj->UD(1)),
+                          int128_make64(Vk->UD(1)));
+    if (simd_oprsz(v) == 32) {
+        Vd->Q(1) = int128_sub(int128_make64(Vj->UD(3)),
+                              int128_make64(Vk->UD(3)));
+    }
 }
 
 DO_ODD(vsubwod_h_bu, 16, UH, UB, DO_SUB)
@@ -239,13 +276,15 @@ DO_ODD(vsubwod_d_wu, 64, UD, UW, DO_SUB)
 #define DO_EVEN_U_S(NAME, BIT, ES1, EU1, ES2, EU2, DO_OP)             \
 void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t v)           \
 {                                                                     \
-    int i;                                                            \
+    int i, len;                                                       \
     VReg *Vd = (VReg *)vd;                                            \
     VReg *Vj = (VReg *)vj;                                            \
     VReg *Vk = (VReg *)vk;                                            \
     typedef __typeof(Vd->ES1(0)) TDS;                                 \
     typedef __typeof(Vd->EU1(0)) TDU;                                 \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                               \
+                                                                      \
+    len = (simd_oprsz(v) == 16) ? LSX_LEN : LASX_LEN;                 \
+    for (i = 0; i < len / BIT; i++) {                                 \
         Vd->ES1(i) = DO_OP((TDU)Vj->EU2(2 * i) ,(TDS)Vk->ES2(2 * i)); \
     }                                                                 \
 }
@@ -253,13 +292,15 @@ void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t v)           \
 #define DO_ODD_U_S(NAME, BIT, ES1, EU1, ES2, EU2, DO_OP)                      \
 void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t v)                   \
 {                                                                             \
-    int i;                                                                    \
+    int i, len;                                                               \
     VReg *Vd = (VReg *)vd;                                                    \
     VReg *Vj = (VReg *)vj;                                                    \
     VReg *Vk = (VReg *)vk;                                                    \
     typedef __typeof(Vd->ES1(0)) TDS;                                         \
     typedef __typeof(Vd->EU1(0)) TDU;                                         \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                                       \
+                                                                              \
+    len = (simd_oprsz(v) == 16) ? LSX_LEN : LASX_LEN;                         \
+    for (i = 0; i < len / BIT; i++) {                                         \
         Vd->ES1(i) = DO_OP((TDU)Vj->EU2(2 * i + 1), (TDS)Vk->ES2(2 * i + 1)); \
     }                                                                         \
 }
@@ -270,8 +311,12 @@ void HELPER(vaddwev_q_du_d)(void *vd, void *vj, void *vk, uint32_t v)
     VReg *Vj = (VReg *)vj;
     VReg *Vk = (VReg *)vk;
 
-    Vd->Q(0) = int128_add(int128_make64((uint64_t)Vj->D(0)),
+    Vd->Q(0) = int128_add(int128_make64(Vj->UD(0)),
                           int128_makes64(Vk->D(0)));
+    if (simd_oprsz(v) == 32) {
+        Vd->Q(1) = int128_add(int128_make64(Vj->UD(2)),
+                              int128_makes64(Vk->D(2)));
+    }
 }
 
 DO_EVEN_U_S(vaddwev_h_bu_b, 16, H, UH, B, UB, DO_ADD)
@@ -284,8 +329,12 @@ void HELPER(vaddwod_q_du_d)(void *vd, void *vj, void *vk, uint32_t v)
     VReg *Vj = (VReg *)vj;
     VReg *Vk = (VReg *)vk;
 
-    Vd->Q(0) = int128_add(int128_make64((uint64_t)Vj->D(1)),
+    Vd->Q(0) = int128_add(int128_make64(Vj->UD(1)),
                           int128_makes64(Vk->D(1)));
+    if (simd_oprsz(v) == 32) {
+        Vd->Q(1) = int128_add(int128_make64(Vj->UD(3)),
+                              int128_makes64(Vk->D(3)));
+    }
 }
 
 DO_ODD_U_S(vaddwod_h_bu_b, 16, H, UH, B, UB, DO_ADD)
-- 
2.39.1


