Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B7D736808
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:42:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXp1-00078q-H9; Tue, 20 Jun 2023 05:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXox-00077i-Fv
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:43 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXov-0006MJ-Ah
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:43 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx+emSc5FksyUHAA--.14779S3;
 Tue, 20 Jun 2023 17:38:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S22; 
 Tue, 20 Jun 2023 17:38:26 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 20/46] target/loongarch: Implement vext2xv
Date: Tue, 20 Jun 2023 17:37:48 +0800
Message-Id: <20230620093814.123650-21-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S22
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
- VEXT2XV.{H/W/D}.B, VEXT2XV.{HU/WU/DU}.BU;
- VEXT2XV.{W/D}.B, VEXT2XV.{WU/DU}.HU;
- VEXT2XV.D.W, VEXT2XV.DU.WU.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     | 13 ++++++++++
 target/loongarch/helper.h                    | 13 ++++++++++
 target/loongarch/insn_trans/trans_lasx.c.inc | 13 ++++++++++
 target/loongarch/insns.decode                | 13 ++++++++++
 target/loongarch/lasx_helper.c               | 27 ++++++++++++++++++++
 5 files changed, 79 insertions(+)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 5ac374bc63..1897aa7ba1 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1996,6 +1996,19 @@ INSN_LASX(xvexth_wu_hu,      xx)
 INSN_LASX(xvexth_du_wu,      xx)
 INSN_LASX(xvexth_qu_du,      xx)
 
+INSN_LASX(vext2xv_h_b,       xx)
+INSN_LASX(vext2xv_w_b,       xx)
+INSN_LASX(vext2xv_d_b,       xx)
+INSN_LASX(vext2xv_w_h,       xx)
+INSN_LASX(vext2xv_d_h,       xx)
+INSN_LASX(vext2xv_d_w,       xx)
+INSN_LASX(vext2xv_hu_bu,     xx)
+INSN_LASX(vext2xv_wu_bu,     xx)
+INSN_LASX(vext2xv_du_bu,     xx)
+INSN_LASX(vext2xv_wu_hu,     xx)
+INSN_LASX(vext2xv_du_hu,     xx)
+INSN_LASX(vext2xv_du_wu,     xx)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 17e54eb29a..7a303ee3f1 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -904,3 +904,16 @@ DEF_HELPER_3(xvexth_hu_bu, void, env, i32, i32)
 DEF_HELPER_3(xvexth_wu_hu, void, env, i32, i32)
 DEF_HELPER_3(xvexth_du_wu, void, env, i32, i32)
 DEF_HELPER_3(xvexth_qu_du, void, env, i32, i32)
+
+DEF_HELPER_3(vext2xv_h_b, void, env, i32, i32)
+DEF_HELPER_3(vext2xv_w_b, void, env, i32, i32)
+DEF_HELPER_3(vext2xv_d_b, void, env, i32, i32)
+DEF_HELPER_3(vext2xv_w_h, void, env, i32, i32)
+DEF_HELPER_3(vext2xv_d_h, void, env, i32, i32)
+DEF_HELPER_3(vext2xv_d_w, void, env, i32, i32)
+DEF_HELPER_3(vext2xv_hu_bu, void, env, i32, i32)
+DEF_HELPER_3(vext2xv_wu_bu, void, env, i32, i32)
+DEF_HELPER_3(vext2xv_du_bu, void, env, i32, i32)
+DEF_HELPER_3(vext2xv_wu_hu, void, env, i32, i32)
+DEF_HELPER_3(vext2xv_du_hu, void, env, i32, i32)
+DEF_HELPER_3(vext2xv_du_wu, void, env, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 5110cf9a33..c04469af75 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -1853,6 +1853,19 @@ TRANS(xvexth_wu_hu, gen_xx, gen_helper_xvexth_wu_hu)
 TRANS(xvexth_du_wu, gen_xx, gen_helper_xvexth_du_wu)
 TRANS(xvexth_qu_du, gen_xx, gen_helper_xvexth_qu_du)
 
+TRANS(vext2xv_h_b, gen_xx, gen_helper_vext2xv_h_b)
+TRANS(vext2xv_w_b, gen_xx, gen_helper_vext2xv_w_b)
+TRANS(vext2xv_d_b, gen_xx, gen_helper_vext2xv_d_b)
+TRANS(vext2xv_w_h, gen_xx, gen_helper_vext2xv_w_h)
+TRANS(vext2xv_d_h, gen_xx, gen_helper_vext2xv_d_h)
+TRANS(vext2xv_d_w, gen_xx, gen_helper_vext2xv_d_w)
+TRANS(vext2xv_hu_bu, gen_xx, gen_helper_vext2xv_hu_bu)
+TRANS(vext2xv_wu_bu, gen_xx, gen_helper_vext2xv_wu_bu)
+TRANS(vext2xv_du_bu, gen_xx, gen_helper_vext2xv_du_bu)
+TRANS(vext2xv_wu_hu, gen_xx, gen_helper_vext2xv_wu_hu)
+TRANS(vext2xv_du_hu, gen_xx, gen_helper_vext2xv_du_hu)
+TRANS(vext2xv_du_wu, gen_xx, gen_helper_vext2xv_du_wu)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 98de616846..9f1cb04368 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1600,6 +1600,19 @@ xvexth_wu_hu     0111 01101001 11101 11101 ..... .....    @xx
 xvexth_du_wu     0111 01101001 11101 11110 ..... .....    @xx
 xvexth_qu_du     0111 01101001 11101 11111 ..... .....    @xx
 
+vext2xv_h_b      0111 01101001 11110 00100 ..... .....    @xx
+vext2xv_w_b      0111 01101001 11110 00101 ..... .....    @xx
+vext2xv_d_b      0111 01101001 11110 00110 ..... .....    @xx
+vext2xv_w_h      0111 01101001 11110 00111 ..... .....    @xx
+vext2xv_d_h      0111 01101001 11110 01000 ..... .....    @xx
+vext2xv_d_w      0111 01101001 11110 01001 ..... .....    @xx
+vext2xv_hu_bu    0111 01101001 11110 01010 ..... .....    @xx
+vext2xv_wu_bu    0111 01101001 11110 01011 ..... .....    @xx
+vext2xv_du_bu    0111 01101001 11110 01100 ..... .....    @xx
+vext2xv_wu_hu    0111 01101001 11110 01101 ..... .....    @xx
+vext2xv_du_hu    0111 01101001 11110 01110 ..... .....    @xx
+vext2xv_du_wu    0111 01101001 11110 01111 ..... .....    @xx
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index ca74263c6e..ca82d03ff4 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -677,3 +677,30 @@ XVEXTH(xvexth_d_w, 64, XD, XW)
 XVEXTH(xvexth_hu_bu, 16, UXH, UXB)
 XVEXTH(xvexth_wu_hu, 32, UXW, UXH)
 XVEXTH(xvexth_du_wu, 64, UXD, UXW)
+
+#define VEXT2XV(NAME, BIT, E1, E2)                                  \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t xd, uint32_t xj) \
+{                                                                   \
+    int i;                                                          \
+    XReg *Xd = &(env->fpr[xd].xreg);                                \
+    XReg *Xj = &(env->fpr[xj].xreg);                                \
+    XReg temp;                                                      \
+                                                                    \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                          \
+        temp.E1(i) = Xj->E2(i);                                     \
+    }                                                               \
+    *Xd = temp;                                                     \
+}
+
+VEXT2XV(vext2xv_h_b, 16, XH, XB)
+VEXT2XV(vext2xv_w_b, 32, XW, XB)
+VEXT2XV(vext2xv_d_b, 64, XD, XB)
+VEXT2XV(vext2xv_w_h, 32, XW, XH)
+VEXT2XV(vext2xv_d_h, 64, XD, XH)
+VEXT2XV(vext2xv_d_w, 64, XD, XW)
+VEXT2XV(vext2xv_hu_bu, 16, UXH, UXB)
+VEXT2XV(vext2xv_wu_bu, 32, UXW, UXB)
+VEXT2XV(vext2xv_du_bu, 64, UXD, UXB)
+VEXT2XV(vext2xv_wu_hu, 32, UXW, UXH)
+VEXT2XV(vext2xv_du_hu, 64, UXD, UXH)
+VEXT2XV(vext2xv_du_wu, 64, UXD, UXW)
-- 
2.39.1


