Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B017753578
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 10:49:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKERy-0002cX-2U; Fri, 14 Jul 2023 04:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qKERu-0002PW-V1
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:50 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qKERi-0004nw-PO
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:50 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxHOthC7FkXs4EAA--.8190S3;
 Fri, 14 Jul 2023 16:46:25 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxzyNYC7FkFOotAA--.22026S14; 
 Fri, 14 Jul 2023 16:46:24 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 12/47] target/loongarch: Implement xavg/xvagr
Date: Fri, 14 Jul 2023 16:45:40 +0800
Message-Id: <20230714084615.2448038-13-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230714084615.2448038-1-gaosong@loongson.cn>
References: <20230714084615.2448038-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzyNYC7FkFOotAA--.22026S14
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
- XVAVG.{B/H/W/D/}[U];
- XVAVGR.{B/H/W/D}[U].

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     | 17 +++++++++++++
 target/loongarch/insn_trans/trans_lasx.c.inc | 17 +++++++++++++
 target/loongarch/insns.decode                | 17 +++++++++++++
 target/loongarch/vec.h                       |  3 +++
 target/loongarch/vec_helper.c                | 25 ++++++++++----------
 5 files changed, 66 insertions(+), 13 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 6972e33833..8296aafa98 100644
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
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index d8230cba9f..ac4cade845 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -140,6 +140,23 @@ TRANS(xvaddwod_w_hu_h, gvec_vvv, 32, MO_16, do_vaddwod_u_s)
 TRANS(xvaddwod_d_wu_w, gvec_vvv, 32, MO_32, do_vaddwod_u_s)
 TRANS(xvaddwod_q_du_d, gvec_vvv, 32, MO_64, do_vaddwod_u_s)
 
+TRANS(xvavg_b, gvec_vvv, 32, MO_8, do_vavg_s)
+TRANS(xvavg_h, gvec_vvv, 32, MO_16, do_vavg_s)
+TRANS(xvavg_w, gvec_vvv, 32, MO_32, do_vavg_s)
+TRANS(xvavg_d, gvec_vvv, 32, MO_64, do_vavg_s)
+TRANS(xvavg_bu, gvec_vvv, 32, MO_8, do_vavg_u)
+TRANS(xvavg_hu, gvec_vvv, 32, MO_16, do_vavg_u)
+TRANS(xvavg_wu, gvec_vvv, 32, MO_32, do_vavg_u)
+TRANS(xvavg_du, gvec_vvv, 32, MO_64, do_vavg_u)
+TRANS(xvavgr_b, gvec_vvv, 32, MO_8, do_vavgr_s)
+TRANS(xvavgr_h, gvec_vvv, 32, MO_16, do_vavgr_s)
+TRANS(xvavgr_w, gvec_vvv, 32, MO_32, do_vavgr_s)
+TRANS(xvavgr_d, gvec_vvv, 32, MO_64, do_vavgr_s)
+TRANS(xvavgr_bu, gvec_vvv, 32, MO_8, do_vavgr_u)
+TRANS(xvavgr_hu, gvec_vvv, 32, MO_16, do_vavgr_u)
+TRANS(xvavgr_wu, gvec_vvv, 32, MO_32, do_vavgr_u)
+TRANS(xvavgr_du, gvec_vvv, 32, MO_64, do_vavgr_u)
+
 TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
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
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index 5332dff83c..6ac6b22f20 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -50,4 +50,7 @@
 #define DO_ADD(a, b)  (a + b)
 #define DO_SUB(a, b)  (a - b)
 
+#define DO_VAVG(a, b)  ((a >> 1) + (b >> 1) + (a & b & 1))
+#define DO_VAVGR(a, b) ((a >> 1) + (b >> 1) + ((a | b) & 1))
+
 #endif /* LOONGARCH_VEC_H */
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 0127f8ba0b..2fa8b68e72 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -344,19 +344,18 @@ DO_ODD_U_S(vaddwod_h_bu_b, 16, H, UH, B, UB, DO_ADD)
 DO_ODD_U_S(vaddwod_w_hu_h, 32, W, UW, H, UH, DO_ADD)
 DO_ODD_U_S(vaddwod_d_wu_w, 64, D, UD, W, UW, DO_ADD)
 
-#define DO_VAVG(a, b)  ((a >> 1) + (b >> 1) + (a & b & 1))
-#define DO_VAVGR(a, b) ((a >> 1) + (b >> 1) + ((a | b) & 1))
-
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
-- 
2.39.1


