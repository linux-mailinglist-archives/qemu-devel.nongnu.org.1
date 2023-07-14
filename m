Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F171E753580
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 10:49:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKET0-0007if-9B; Fri, 14 Jul 2023 04:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qKESx-0007Q4-C0
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:47:55 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qKESp-00057M-SL
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:47:54 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxBfFjC7Fkb84EAA--.13137S3;
 Fri, 14 Jul 2023 16:46:27 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxzyNYC7FkFOotAA--.22026S17; 
 Fri, 14 Jul 2023 16:46:26 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 15/47] target/loongarch: Implement xvmax/xvmin
Date: Fri, 14 Jul 2023 16:45:43 +0800
Message-Id: <20230714084615.2448038-16-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230714084615.2448038-1-gaosong@loongson.cn>
References: <20230714084615.2448038-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzyNYC7FkFOotAA--.22026S17
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
- XVMAX[I].{B/H/W/D}[U];
- XVMIN[I].{B/H/W/D}[U].

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     | 34 ++++++++++++++++++
 target/loongarch/insn_trans/trans_lasx.c.inc | 36 ++++++++++++++++++++
 target/loongarch/insns.decode                | 36 ++++++++++++++++++++
 target/loongarch/vec.h                       |  3 ++
 target/loongarch/vec_helper.c                | 26 +++++++-------
 5 files changed, 121 insertions(+), 14 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index b48822e431..63c1dc757f 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1856,6 +1856,40 @@ INSN_LASX(xvadda_h,          vvv)
 INSN_LASX(xvadda_w,          vvv)
 INSN_LASX(xvadda_d,          vvv)
 
+INSN_LASX(xvmax_b,           vvv)
+INSN_LASX(xvmax_h,           vvv)
+INSN_LASX(xvmax_w,           vvv)
+INSN_LASX(xvmax_d,           vvv)
+INSN_LASX(xvmin_b,           vvv)
+INSN_LASX(xvmin_h,           vvv)
+INSN_LASX(xvmin_w,           vvv)
+INSN_LASX(xvmin_d,           vvv)
+INSN_LASX(xvmax_bu,          vvv)
+INSN_LASX(xvmax_hu,          vvv)
+INSN_LASX(xvmax_wu,          vvv)
+INSN_LASX(xvmax_du,          vvv)
+INSN_LASX(xvmin_bu,          vvv)
+INSN_LASX(xvmin_hu,          vvv)
+INSN_LASX(xvmin_wu,          vvv)
+INSN_LASX(xvmin_du,          vvv)
+
+INSN_LASX(xvmaxi_b,          vv_i)
+INSN_LASX(xvmaxi_h,          vv_i)
+INSN_LASX(xvmaxi_w,          vv_i)
+INSN_LASX(xvmaxi_d,          vv_i)
+INSN_LASX(xvmini_b,          vv_i)
+INSN_LASX(xvmini_h,          vv_i)
+INSN_LASX(xvmini_w,          vv_i)
+INSN_LASX(xvmini_d,          vv_i)
+INSN_LASX(xvmaxi_bu,         vv_i)
+INSN_LASX(xvmaxi_hu,         vv_i)
+INSN_LASX(xvmaxi_wu,         vv_i)
+INSN_LASX(xvmaxi_du,         vv_i)
+INSN_LASX(xvmini_bu,         vv_i)
+INSN_LASX(xvmini_hu,         vv_i)
+INSN_LASX(xvmini_wu,         vv_i)
+INSN_LASX(xvmini_du,         vv_i)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 30cb286cb9..107c75f1b6 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -171,6 +171,42 @@ TRANS(xvadda_h, gvec_vvv, 32, MO_16, do_vadda)
 TRANS(xvadda_w, gvec_vvv, 32, MO_32, do_vadda)
 TRANS(xvadda_d, gvec_vvv, 32, MO_64, do_vadda)
 
+TRANS(xvmax_b, gvec_vvv, 32, MO_8, tcg_gen_gvec_smax)
+TRANS(xvmax_h, gvec_vvv, 32, MO_16, tcg_gen_gvec_smax)
+TRANS(xvmax_w, gvec_vvv, 32, MO_32, tcg_gen_gvec_smax)
+TRANS(xvmax_d, gvec_vvv, 32, MO_64, tcg_gen_gvec_smax)
+TRANS(xvmax_bu, gvec_vvv, 32, MO_8, tcg_gen_gvec_umax)
+TRANS(xvmax_hu, gvec_vvv, 32, MO_16, tcg_gen_gvec_umax)
+TRANS(xvmax_wu, gvec_vvv, 32, MO_32, tcg_gen_gvec_umax)
+TRANS(xvmax_du, gvec_vvv, 32, MO_64, tcg_gen_gvec_umax)
+
+TRANS(xvmin_b, gvec_vvv, 32, MO_8, tcg_gen_gvec_smin)
+TRANS(xvmin_h, gvec_vvv, 32, MO_16, tcg_gen_gvec_smin)
+TRANS(xvmin_w, gvec_vvv, 32, MO_32, tcg_gen_gvec_smin)
+TRANS(xvmin_d, gvec_vvv, 32, MO_64, tcg_gen_gvec_smin)
+TRANS(xvmin_bu, gvec_vvv, 32, MO_8, tcg_gen_gvec_umin)
+TRANS(xvmin_hu, gvec_vvv, 32, MO_16, tcg_gen_gvec_umin)
+TRANS(xvmin_wu, gvec_vvv, 32, MO_32, tcg_gen_gvec_umin)
+TRANS(xvmin_du, gvec_vvv, 32, MO_64, tcg_gen_gvec_umin)
+
+TRANS(xvmini_b, gvec_vv_i, 32, MO_8, do_vmini_s)
+TRANS(xvmini_h, gvec_vv_i, 32, MO_16, do_vmini_s)
+TRANS(xvmini_w, gvec_vv_i, 32, MO_32, do_vmini_s)
+TRANS(xvmini_d, gvec_vv_i, 32, MO_64, do_vmini_s)
+TRANS(xvmini_bu, gvec_vv_i, 32, MO_8, do_vmini_u)
+TRANS(xvmini_hu, gvec_vv_i, 32, MO_16, do_vmini_u)
+TRANS(xvmini_wu, gvec_vv_i, 32, MO_32, do_vmini_u)
+TRANS(xvmini_du, gvec_vv_i, 32, MO_64, do_vmini_u)
+
+TRANS(xvmaxi_b, gvec_vv_i, 32, MO_8, do_vmaxi_s)
+TRANS(xvmaxi_h, gvec_vv_i, 32, MO_16, do_vmaxi_s)
+TRANS(xvmaxi_w, gvec_vv_i, 32, MO_32, do_vmaxi_s)
+TRANS(xvmaxi_d, gvec_vv_i, 32, MO_64, do_vmaxi_s)
+TRANS(xvmaxi_bu, gvec_vv_i, 32, MO_8, do_vmaxi_u)
+TRANS(xvmaxi_hu, gvec_vv_i, 32, MO_16, do_vmaxi_u)
+TRANS(xvmaxi_wu, gvec_vv_i, 32, MO_32, do_vmaxi_u)
+TRANS(xvmaxi_du, gvec_vv_i, 32, MO_64, do_vmaxi_u)
+
 TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index f3722e3aa7..99aefcb651 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1437,6 +1437,42 @@ xvadda_h         0111 01000101 11001 ..... ..... .....    @vvv
 xvadda_w         0111 01000101 11010 ..... ..... .....    @vvv
 xvadda_d         0111 01000101 11011 ..... ..... .....    @vvv
 
+xvmax_b          0111 01000111 00000 ..... ..... .....    @vvv
+xvmax_h          0111 01000111 00001 ..... ..... .....    @vvv
+xvmax_w          0111 01000111 00010 ..... ..... .....    @vvv
+xvmax_d          0111 01000111 00011 ..... ..... .....    @vvv
+xvmax_bu         0111 01000111 01000 ..... ..... .....    @vvv
+xvmax_hu         0111 01000111 01001 ..... ..... .....    @vvv
+xvmax_wu         0111 01000111 01010 ..... ..... .....    @vvv
+xvmax_du         0111 01000111 01011 ..... ..... .....    @vvv
+
+xvmaxi_b         0111 01101001 00000 ..... ..... .....    @vv_i5
+xvmaxi_h         0111 01101001 00001 ..... ..... .....    @vv_i5
+xvmaxi_w         0111 01101001 00010 ..... ..... .....    @vv_i5
+xvmaxi_d         0111 01101001 00011 ..... ..... .....    @vv_i5
+xvmaxi_bu        0111 01101001 01000 ..... ..... .....    @vv_ui5
+xvmaxi_hu        0111 01101001 01001 ..... ..... .....    @vv_ui5
+xvmaxi_wu        0111 01101001 01010 ..... ..... .....    @vv_ui5
+xvmaxi_du        0111 01101001 01011 ..... ..... .....    @vv_ui5
+
+xvmin_b          0111 01000111 00100 ..... ..... .....    @vvv
+xvmin_h          0111 01000111 00101 ..... ..... .....    @vvv
+xvmin_w          0111 01000111 00110 ..... ..... .....    @vvv
+xvmin_d          0111 01000111 00111 ..... ..... .....    @vvv
+xvmin_bu         0111 01000111 01100 ..... ..... .....    @vvv
+xvmin_hu         0111 01000111 01101 ..... ..... .....    @vvv
+xvmin_wu         0111 01000111 01110 ..... ..... .....    @vvv
+xvmin_du         0111 01000111 01111 ..... ..... .....    @vvv
+
+xvmini_b         0111 01101001 00100 ..... ..... .....    @vv_i5
+xvmini_h         0111 01101001 00101 ..... ..... .....    @vv_i5
+xvmini_w         0111 01101001 00110 ..... ..... .....    @vv_i5
+xvmini_d         0111 01101001 00111 ..... ..... .....    @vv_i5
+xvmini_bu        0111 01101001 01100 ..... ..... .....    @vv_ui5
+xvmini_hu        0111 01101001 01101 ..... ..... .....    @vv_ui5
+xvmini_wu        0111 01101001 01110 ..... ..... .....    @vv_ui5
+xvmini_du        0111 01101001 01111 ..... ..... .....    @vv_ui5
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index 7ccc89c10f..cd6f6a72fd 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -57,4 +57,7 @@
 
 #define DO_VABS(a)      ((a < 0) ? (-a) : (a))
 
+#define DO_MIN(a, b)    (a < b ? a : b)
+#define DO_MAX(a, b)    (a > b ? a : b)
+
 #endif /* LOONGARCH_VEC_H */
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index ff77f714e8..396319518f 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -403,20 +403,18 @@ DO_VADDA(vadda_h, 16, H, DO_VABS)
 DO_VADDA(vadda_w, 32, W, DO_VABS)
 DO_VADDA(vadda_d, 64, D, DO_VABS)
 
-#define DO_MIN(a, b) (a < b ? a : b)
-#define DO_MAX(a, b) (a > b ? a : b)
-
-#define VMINMAXI(NAME, BIT, E, DO_OP)                           \
-void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t v) \
-{                                                               \
-    int i;                                                      \
-    VReg *Vd = (VReg *)vd;                                      \
-    VReg *Vj = (VReg *)vj;                                      \
-    typedef __typeof(Vd->E(0)) TD;                              \
-                                                                \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                         \
-        Vd->E(i) = DO_OP(Vj->E(i), (TD)imm);                    \
-    }                                                           \
+#define VMINMAXI(NAME, BIT, E, DO_OP)                              \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc) \
+{                                                                  \
+    int i;                                                         \
+    VReg *Vd = (VReg *)vd;                                         \
+    VReg *Vj = (VReg *)vj;                                         \
+    typedef __typeof(Vd->E(0)) TD;                                 \
+    int oprsz = simd_oprsz(desc);                                  \
+                                                                   \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                      \
+        Vd->E(i) = DO_OP(Vj->E(i), (TD)imm);                       \
+    }                                                              \
 }
 
 VMINMAXI(vmini_b, 8, B, DO_MIN)
-- 
2.39.1


