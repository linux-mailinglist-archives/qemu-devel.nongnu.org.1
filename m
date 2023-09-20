Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE597A7380
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 08:58:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qir57-0008TT-D3; Wed, 20 Sep 2023 02:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qir4R-0007rO-L1
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 02:52:26 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qir4E-00042R-GD
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 02:52:16 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxFeiNlgplpy8qAA--.22185S3;
 Wed, 20 Sep 2023 14:51:57 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dxzdx7lgplhVYMAA--.24315S23; 
 Wed, 20 Sep 2023 14:51:56 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 21/57] target/loongarch: Implement xavg/xvagr
Date: Wed, 20 Sep 2023 14:51:03 +0800
Message-Id: <20230920065139.1403868-22-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230920065139.1403868-1-gaosong@loongson.cn>
References: <20230920065139.1403868-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxzdx7lgplhVYMAA--.24315S23
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
- XVAVG.{B/H/W/D/}[U];
- XVAVGR.{B/H/W/D}[U].

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230914022645.1151356-22-gaosong@loongson.cn>
---
 target/loongarch/insns.decode               | 17 ++++++++++++++++
 target/loongarch/disas.c                    | 17 ++++++++++++++++
 target/loongarch/vec_helper.c               | 22 +++++++++++----------
 target/loongarch/insn_trans/trans_vec.c.inc | 16 +++++++++++++++
 4 files changed, 62 insertions(+), 10 deletions(-)

diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index e1d8b30179..a2cb39750d 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1406,6 +1406,23 @@ xvaddwod_w_hu_h  0111 01000100 00001 ..... ..... .....    @vvv
 xvaddwod_d_wu_w  0111 01000100 00010 ..... ..... .....    @vvv
 xvaddwod_q_du_d  0111 01000100 00011 ..... ..... .....    @vvv
 
+xvavg_b          0111 01000110 01000 ..... ..... .....    @vvv
+xvavg_h          0111 01000110 01001 ..... ..... .....    @vvv
+xvavg_w          0111 01000110 01010 ..... ..... .....    @vvv
+xvavg_d          0111 01000110 01011 ..... ..... .....    @vvv
+xvavg_bu         0111 01000110 01100 ..... ..... .....    @vvv
+xvavg_hu         0111 01000110 01101 ..... ..... .....    @vvv
+xvavg_wu         0111 01000110 01110 ..... ..... .....    @vvv
+xvavg_du         0111 01000110 01111 ..... ..... .....    @vvv
+xvavgr_b         0111 01000110 10000 ..... ..... .....    @vvv
+xvavgr_h         0111 01000110 10001 ..... ..... .....    @vvv
+xvavgr_w         0111 01000110 10010 ..... ..... .....    @vvv
+xvavgr_d         0111 01000110 10011 ..... ..... .....    @vvv
+xvavgr_bu        0111 01000110 10100 ..... ..... .....    @vvv
+xvavgr_hu        0111 01000110 10101 ..... ..... .....    @vvv
+xvavgr_wu        0111 01000110 10110 ..... ..... .....    @vvv
+xvavgr_du        0111 01000110 10111 ..... ..... .....    @vvv
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index e3e57e1d05..f9d9583fcc 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1825,6 +1825,23 @@ INSN_LASX(xvaddwod_w_hu_h,   vvv)
 INSN_LASX(xvaddwod_d_wu_w,   vvv)
 INSN_LASX(xvaddwod_q_du_d,   vvv)
 
+INSN_LASX(xvavg_b,           vvv)
+INSN_LASX(xvavg_h,           vvv)
+INSN_LASX(xvavg_w,           vvv)
+INSN_LASX(xvavg_d,           vvv)
+INSN_LASX(xvavg_bu,          vvv)
+INSN_LASX(xvavg_hu,          vvv)
+INSN_LASX(xvavg_wu,          vvv)
+INSN_LASX(xvavg_du,          vvv)
+INSN_LASX(xvavgr_b,          vvv)
+INSN_LASX(xvavgr_h,          vvv)
+INSN_LASX(xvavgr_w,          vvv)
+INSN_LASX(xvavgr_d,          vvv)
+INSN_LASX(xvavgr_bu,         vvv)
+INSN_LASX(xvavgr_hu,         vvv)
+INSN_LASX(xvavgr_wu,         vvv)
+INSN_LASX(xvavgr_du,         vvv)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index fc3b07e8d2..35b207aae1 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -350,16 +350,18 @@ DO_ODD_U_S(vaddwod_d_wu_w, 64, D, UD, W, UW, DO_ADD)
 #define DO_VAVG(a, b)  ((a >> 1) + (b >> 1) + (a & b & 1))
 #define DO_VAVGR(a, b) ((a >> 1) + (b >> 1) + ((a | b) & 1))
 
-#define DO_3OP(NAME, BIT, E, DO_OP)                         \
-void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t v) \
-{                                                           \
-    int i;                                                  \
-    VReg *Vd = (VReg *)vd;                                  \
-    VReg *Vj = (VReg *)vj;                                  \
-    VReg *Vk = (VReg *)vk;                                  \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                     \
-        Vd->E(i) = DO_OP(Vj->E(i), Vk->E(i));               \
-    }                                                       \
+#define DO_3OP(NAME, BIT, E, DO_OP)                            \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
+{                                                              \
+    int i;                                                     \
+    VReg *Vd = (VReg *)vd;                                     \
+    VReg *Vj = (VReg *)vj;                                     \
+    VReg *Vk = (VReg *)vk;                                     \
+    int oprsz = simd_oprsz(desc);                              \
+                                                               \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                  \
+        Vd->E(i) = DO_OP(Vj->E(i), Vk->E(i));                  \
+    }                                                          \
 }
 
 DO_3OP(vavg_b, 8, B, DO_VAVG)
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 322d43d50c..050a96088d 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -1419,6 +1419,14 @@ TRANS(vavg_bu, LSX, gvec_vvv, MO_8, do_vavg_u)
 TRANS(vavg_hu, LSX, gvec_vvv, MO_16, do_vavg_u)
 TRANS(vavg_wu, LSX, gvec_vvv, MO_32, do_vavg_u)
 TRANS(vavg_du, LSX, gvec_vvv, MO_64, do_vavg_u)
+TRANS(xvavg_b, LASX, gvec_xxx, MO_8, do_vavg_s)
+TRANS(xvavg_h, LASX, gvec_xxx, MO_16, do_vavg_s)
+TRANS(xvavg_w, LASX, gvec_xxx, MO_32, do_vavg_s)
+TRANS(xvavg_d, LASX, gvec_xxx, MO_64, do_vavg_s)
+TRANS(xvavg_bu, LASX, gvec_xxx, MO_8, do_vavg_u)
+TRANS(xvavg_hu, LASX, gvec_xxx, MO_16, do_vavg_u)
+TRANS(xvavg_wu, LASX, gvec_xxx, MO_32, do_vavg_u)
+TRANS(xvavg_du, LASX, gvec_xxx, MO_64, do_vavg_u)
 
 static void do_vavgr_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
                        uint32_t vk_ofs, uint32_t oprsz, uint32_t maxsz)
@@ -1500,6 +1508,14 @@ TRANS(vavgr_bu, LSX, gvec_vvv, MO_8, do_vavgr_u)
 TRANS(vavgr_hu, LSX, gvec_vvv, MO_16, do_vavgr_u)
 TRANS(vavgr_wu, LSX, gvec_vvv, MO_32, do_vavgr_u)
 TRANS(vavgr_du, LSX, gvec_vvv, MO_64, do_vavgr_u)
+TRANS(xvavgr_b, LASX, gvec_xxx, MO_8, do_vavgr_s)
+TRANS(xvavgr_h, LASX, gvec_xxx, MO_16, do_vavgr_s)
+TRANS(xvavgr_w, LASX, gvec_xxx, MO_32, do_vavgr_s)
+TRANS(xvavgr_d, LASX, gvec_xxx, MO_64, do_vavgr_s)
+TRANS(xvavgr_bu, LASX, gvec_xxx, MO_8, do_vavgr_u)
+TRANS(xvavgr_hu, LASX, gvec_xxx, MO_16, do_vavgr_u)
+TRANS(xvavgr_wu, LASX, gvec_xxx, MO_32, do_vavgr_u)
+TRANS(xvavgr_du, LASX, gvec_xxx, MO_64, do_vavgr_u)
 
 static void gen_vabsd_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
-- 
2.39.1


