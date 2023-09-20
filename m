Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF597A7344
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 08:54:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qir4z-00087w-Jc; Wed, 20 Sep 2023 02:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qir4T-0007rT-10
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 02:52:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qir4J-00043o-Uy
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 02:52:24 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bxd+iSlgpltC8qAA--.44966S3;
 Wed, 20 Sep 2023 14:52:02 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dxzdx7lgplhVYMAA--.24315S30; 
 Wed, 20 Sep 2023 14:52:02 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 28/57] target/loongarch: Implement xvsat
Date: Wed, 20 Sep 2023 14:51:10 +0800
Message-Id: <20230920065139.1403868-29-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230920065139.1403868-1-gaosong@loongson.cn>
References: <20230920065139.1403868-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxzdx7lgplhVYMAA--.24315S30
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
- XVSAT.{B/H/W/D}[U].

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230914022645.1151356-29-gaosong@loongson.cn>
---
 target/loongarch/insns.decode               |  9 ++++
 target/loongarch/disas.c                    |  9 ++++
 target/loongarch/vec_helper.c               | 48 +++++++++++----------
 target/loongarch/insn_trans/trans_vec.c.inc |  8 ++++
 4 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index fa25c876b4..e366cf7615 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1562,6 +1562,15 @@ xvmod_hu         0111 01001110 01101 ..... ..... .....    @vvv
 xvmod_wu         0111 01001110 01110 ..... ..... .....    @vvv
 xvmod_du         0111 01001110 01111 ..... ..... .....    @vvv
 
+xvsat_b          0111 01110010 01000 01 ... ..... .....   @vv_ui3
+xvsat_h          0111 01110010 01000 1 .... ..... .....   @vv_ui4
+xvsat_w          0111 01110010 01001 ..... ..... .....    @vv_ui5
+xvsat_d          0111 01110010 0101 ...... ..... .....    @vv_ui6
+xvsat_bu         0111 01110010 10000 01 ... ..... .....   @vv_ui3
+xvsat_hu         0111 01110010 10000 1 .... ..... .....   @vv_ui4
+xvsat_wu         0111 01110010 10001 ..... ..... .....    @vv_ui5
+xvsat_du         0111 01110010 1001 ...... ..... .....    @vv_ui6
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index d932318b27..4e54dcd08a 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1979,6 +1979,15 @@ INSN_LASX(xvmod_hu,          vvv)
 INSN_LASX(xvmod_wu,          vvv)
 INSN_LASX(xvmod_du,          vvv)
 
+INSN_LASX(xvsat_b,           vv_i)
+INSN_LASX(xvsat_h,           vv_i)
+INSN_LASX(xvsat_w,           vv_i)
+INSN_LASX(xvsat_d,           vv_i)
+INSN_LASX(xvsat_bu,          vv_i)
+INSN_LASX(xvsat_hu,          vv_i)
+INSN_LASX(xvsat_wu,          vv_i)
+INSN_LASX(xvsat_du,          vv_i)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 9cf979a4bb..f2e19343bf 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -677,18 +677,19 @@ VDIV(vmod_hu, 16, UH, DO_REMU)
 VDIV(vmod_wu, 32, UW, DO_REMU)
 VDIV(vmod_du, 64, UD, DO_REMU)
 
-#define VSAT_S(NAME, BIT, E)                                    \
-void HELPER(NAME)(void *vd, void *vj, uint64_t max, uint32_t v) \
-{                                                               \
-    int i;                                                      \
-    VReg *Vd = (VReg *)vd;                                      \
-    VReg *Vj = (VReg *)vj;                                      \
-    typedef __typeof(Vd->E(0)) TD;                              \
-                                                                \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                         \
-        Vd->E(i) = Vj->E(i) > (TD)max ? (TD)max :               \
-                   Vj->E(i) < (TD)~max ? (TD)~max: Vj->E(i);    \
-    }                                                           \
+#define VSAT_S(NAME, BIT, E)                                       \
+void HELPER(NAME)(void *vd, void *vj, uint64_t max, uint32_t desc) \
+{                                                                  \
+    int i;                                                         \
+    VReg *Vd = (VReg *)vd;                                         \
+    VReg *Vj = (VReg *)vj;                                         \
+    typedef __typeof(Vd->E(0)) TD;                                 \
+    int oprsz = simd_oprsz(desc);                                  \
+                                                                   \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                      \
+        Vd->E(i) = Vj->E(i) > (TD)max ? (TD)max :                  \
+                   Vj->E(i) < (TD)~max ? (TD)~max: Vj->E(i);       \
+    }                                                              \
 }
 
 VSAT_S(vsat_b, 8, B)
@@ -696,17 +697,18 @@ VSAT_S(vsat_h, 16, H)
 VSAT_S(vsat_w, 32, W)
 VSAT_S(vsat_d, 64, D)
 
-#define VSAT_U(NAME, BIT, E)                                    \
-void HELPER(NAME)(void *vd, void *vj, uint64_t max, uint32_t v) \
-{                                                               \
-    int i;                                                      \
-    VReg *Vd = (VReg *)vd;                                      \
-    VReg *Vj = (VReg *)vj;                                      \
-    typedef __typeof(Vd->E(0)) TD;                              \
-                                                                \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                         \
-        Vd->E(i) = Vj->E(i) > (TD)max ? (TD)max : Vj->E(i);     \
-    }                                                           \
+#define VSAT_U(NAME, BIT, E)                                       \
+void HELPER(NAME)(void *vd, void *vj, uint64_t max, uint32_t desc) \
+{                                                                  \
+    int i;                                                         \
+    VReg *Vd = (VReg *)vd;                                         \
+    VReg *Vj = (VReg *)vj;                                         \
+    typedef __typeof(Vd->E(0)) TD;                                 \
+    int oprsz = simd_oprsz(desc);                                  \
+                                                                   \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                      \
+        Vd->E(i) = Vj->E(i) > (TD)max ? (TD)max : Vj->E(i);        \
+    }                                                              \
 }
 
 VSAT_U(vsat_bu, 8, UB)
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index a22ced99f5..a6c6675a94 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -3267,6 +3267,10 @@ TRANS(vsat_b, LSX, gvec_vv_i, MO_8, do_vsat_s)
 TRANS(vsat_h, LSX, gvec_vv_i, MO_16, do_vsat_s)
 TRANS(vsat_w, LSX, gvec_vv_i, MO_32, do_vsat_s)
 TRANS(vsat_d, LSX, gvec_vv_i, MO_64, do_vsat_s)
+TRANS(xvsat_b, LASX, gvec_xx_i, MO_8, do_vsat_s)
+TRANS(xvsat_h, LASX, gvec_xx_i, MO_16, do_vsat_s)
+TRANS(xvsat_w, LASX, gvec_xx_i, MO_32, do_vsat_s)
+TRANS(xvsat_d, LASX, gvec_xx_i, MO_64, do_vsat_s)
 
 static void gen_vsat_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec max)
 {
@@ -3316,6 +3320,10 @@ TRANS(vsat_bu, LSX, gvec_vv_i, MO_8, do_vsat_u)
 TRANS(vsat_hu, LSX, gvec_vv_i, MO_16, do_vsat_u)
 TRANS(vsat_wu, LSX, gvec_vv_i, MO_32, do_vsat_u)
 TRANS(vsat_du, LSX, gvec_vv_i, MO_64, do_vsat_u)
+TRANS(xvsat_bu, LASX, gvec_xx_i, MO_8, do_vsat_u)
+TRANS(xvsat_hu, LASX, gvec_xx_i, MO_16, do_vsat_u)
+TRANS(xvsat_wu, LASX, gvec_xx_i, MO_32, do_vsat_u)
+TRANS(xvsat_du, LASX, gvec_xx_i, MO_64, do_vsat_u)
 
 TRANS(vexth_h_b, LSX, gen_vv, gen_helper_vexth_h_b)
 TRANS(vexth_w_h, LSX, gen_vv, gen_helper_vexth_w_h)
-- 
2.39.1


