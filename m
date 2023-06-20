Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 773677367FA
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:40:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXoy-00077s-30; Tue, 20 Jun 2023 05:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXou-00076r-RE
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:40 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXos-0006MA-NI
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:40 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bxb+uSc5FksSUHAA--.14740S3;
 Tue, 20 Jun 2023 17:38:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S21; 
 Tue, 20 Jun 2023 17:38:25 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 19/46] target/loongarch: Implement xvexth
Date: Tue, 20 Jun 2023 17:37:47 +0800
Message-Id: <20230620093814.123650-20-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S21
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
- XVEXTH.{H.B/W.H/D.W/Q.D};
- XVEXTH.{HU.BU/WU.HU/DU.WU/QU.DU}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  9 +++++
 target/loongarch/helper.h                    |  9 +++++
 target/loongarch/insn_trans/trans_lasx.c.inc | 20 ++++++++++
 target/loongarch/insns.decode                |  9 +++++
 target/loongarch/lasx_helper.c               | 39 ++++++++++++++++++++
 5 files changed, 86 insertions(+)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 18fa454be8..5ac374bc63 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1987,6 +1987,15 @@ INSN_LASX(xvsat_hu,          xx_i)
 INSN_LASX(xvsat_wu,          xx_i)
 INSN_LASX(xvsat_du,          xx_i)
 
+INSN_LASX(xvexth_h_b,        xx)
+INSN_LASX(xvexth_w_h,        xx)
+INSN_LASX(xvexth_d_w,        xx)
+INSN_LASX(xvexth_q_d,        xx)
+INSN_LASX(xvexth_hu_bu,      xx)
+INSN_LASX(xvexth_wu_hu,      xx)
+INSN_LASX(xvexth_du_wu,      xx)
+INSN_LASX(xvexth_qu_du,      xx)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 741872a24d..17e54eb29a 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -895,3 +895,12 @@ DEF_HELPER_FLAGS_4(xvsat_bu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(xvsat_hu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(xvsat_wu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(xvsat_du, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_3(xvexth_h_b, void, env, i32, i32)
+DEF_HELPER_3(xvexth_w_h, void, env, i32, i32)
+DEF_HELPER_3(xvexth_d_w, void, env, i32, i32)
+DEF_HELPER_3(xvexth_q_d, void, env, i32, i32)
+DEF_HELPER_3(xvexth_hu_bu, void, env, i32, i32)
+DEF_HELPER_3(xvexth_wu_hu, void, env, i32, i32)
+DEF_HELPER_3(xvexth_du_wu, void, env, i32, i32)
+DEF_HELPER_3(xvexth_qu_du, void, env, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 350d575a6a..5110cf9a33 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -28,6 +28,17 @@ static bool gen_xxx(DisasContext *ctx, arg_xxx *a,
     return true;
 }
 
+static bool gen_xx(DisasContext *ctx, arg_xx *a,
+                   void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32))
+{
+    TCGv_i32 xd = tcg_constant_i32(a->xd);
+    TCGv_i32 xj = tcg_constant_i32(a->xj);
+
+    CHECK_SXE;
+    func(cpu_env, xd, xj);
+    return true;
+}
+
 static bool gvec_xxx(DisasContext *ctx, arg_xxx *a, MemOp mop,
                      void (*func)(unsigned, uint32_t, uint32_t,
                                   uint32_t, uint32_t, uint32_t))
@@ -1833,6 +1844,15 @@ TRANS(xvsat_hu, gvec_xx_i, MO_16, do_xvsat_u)
 TRANS(xvsat_wu, gvec_xx_i, MO_32, do_xvsat_u)
 TRANS(xvsat_du, gvec_xx_i, MO_64, do_xvsat_u)
 
+TRANS(xvexth_h_b, gen_xx, gen_helper_xvexth_h_b)
+TRANS(xvexth_w_h, gen_xx, gen_helper_xvexth_w_h)
+TRANS(xvexth_d_w, gen_xx, gen_helper_xvexth_d_w)
+TRANS(xvexth_q_d, gen_xx, gen_helper_xvexth_q_d)
+TRANS(xvexth_hu_bu, gen_xx, gen_helper_xvexth_hu_bu)
+TRANS(xvexth_wu_hu, gen_xx, gen_helper_xvexth_wu_hu)
+TRANS(xvexth_du_wu, gen_xx, gen_helper_xvexth_du_wu)
+TRANS(xvexth_qu_du, gen_xx, gen_helper_xvexth_qu_du)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 9efb5f2032..98de616846 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1591,6 +1591,15 @@ xvsat_hu         0111 01110010 10000 1 .... ..... .....   @xx_ui4
 xvsat_wu         0111 01110010 10001 ..... ..... .....    @xx_ui5
 xvsat_du         0111 01110010 1001 ...... ..... .....    @xx_ui6
 
+xvexth_h_b       0111 01101001 11101 11000 ..... .....    @xx
+xvexth_w_h       0111 01101001 11101 11001 ..... .....    @xx
+xvexth_d_w       0111 01101001 11101 11010 ..... .....    @xx
+xvexth_q_d       0111 01101001 11101 11011 ..... .....    @xx
+xvexth_hu_bu     0111 01101001 11101 11100 ..... .....    @xx
+xvexth_wu_hu     0111 01101001 11101 11101 ..... .....    @xx
+xvexth_du_wu     0111 01101001 11101 11110 ..... .....    @xx
+xvexth_qu_du     0111 01101001 11101 11111 ..... .....    @xx
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index 33da60f2d8..ca74263c6e 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -638,3 +638,42 @@ XVSAT_U(xvsat_bu, 8, UXB)
 XVSAT_U(xvsat_hu, 16, UXH)
 XVSAT_U(xvsat_wu, 32, UXW)
 XVSAT_U(xvsat_du, 64, UXD)
+
+#define XVEXTH(NAME, BIT, E1, E2)                                   \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t xd, uint32_t xj) \
+{                                                                   \
+    int i, max;                                                     \
+    XReg *Xd = &(env->fpr[xd].xreg);                                \
+    XReg *Xj = &(env->fpr[xj].xreg);                                \
+                                                                    \
+    max = LASX_LEN / (BIT * 2);                                     \
+    for (i = 0; i < max; i++) {                                     \
+        Xd->E1(i) = Xj->E2(i + max);                                \
+        Xd->E1(i + max) = Xj->E2(i + max * 3);                      \
+    }                                                               \
+}
+
+void HELPER(xvexth_q_d)(CPULoongArchState *env, uint32_t xd, uint32_t xj)
+{
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    Xd->XQ(0) = int128_makes64(Xj->XD(1));
+    Xd->XQ(1) = int128_makes64(Xj->XD(3));
+}
+
+void HELPER(xvexth_qu_du)(CPULoongArchState *env, uint32_t xd, uint32_t xj)
+{
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    Xd->XQ(0) = int128_make64(Xj->UXD(1));
+    Xd->XQ(1) = int128_make64(Xj->UXD(3));
+}
+
+XVEXTH(xvexth_h_b, 16, XH, XB)
+XVEXTH(xvexth_w_h, 32, XW, XH)
+XVEXTH(xvexth_d_w, 64, XD, XW)
+XVEXTH(xvexth_hu_bu, 16, UXH, UXB)
+XVEXTH(xvexth_wu_hu, 32, UXW, UXH)
+XVEXTH(xvexth_du_wu, 64, UXD, UXW)
-- 
2.39.1


