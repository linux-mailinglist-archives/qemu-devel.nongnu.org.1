Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6882D7367FE
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:40:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXp4-0007AB-8h; Tue, 20 Jun 2023 05:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXp1-00079C-Gm
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:47 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXow-0006NB-En
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:44 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxSuqWc5FkwCUHAA--.14508S3;
 Tue, 20 Jun 2023 17:38:30 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S28; 
 Tue, 20 Jun 2023 17:38:29 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 26/46] target/loongarch: Implement xvsllwil xvextl
Date: Tue, 20 Jun 2023 17:37:54 +0800
Message-Id: <20230620093814.123650-27-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S28
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
- XVSLLWIL.{H.B/W.H/D.W};
- XVSLLWIL.{HU.BU/WU.HU/DU.WU};
- XVEXTL.Q.D, VEXTL.QU.DU.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  9 ++++
 target/loongarch/helper.h                    |  9 ++++
 target/loongarch/insn_trans/trans_lasx.c.inc | 21 +++++++++
 target/loongarch/insns.decode                |  9 ++++
 target/loongarch/lasx_helper.c               | 45 ++++++++++++++++++++
 5 files changed, 93 insertions(+)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 0c1c7a7e6e..b6940e6389 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2076,6 +2076,15 @@ INSN_LASX(xvrotri_h,         xx_i)
 INSN_LASX(xvrotri_w,         xx_i)
 INSN_LASX(xvrotri_d,         xx_i)
 
+INSN_LASX(xvsllwil_h_b,      xx_i)
+INSN_LASX(xvsllwil_w_h,      xx_i)
+INSN_LASX(xvsllwil_d_w,      xx_i)
+INSN_LASX(xvextl_q_d,        xx)
+INSN_LASX(xvsllwil_hu_bu,    xx_i)
+INSN_LASX(xvsllwil_wu_hu,    xx_i)
+INSN_LASX(xvsllwil_du_wu,    xx_i)
+INSN_LASX(xvextl_qu_du,      xx)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 4e0a900318..672a5f8988 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -931,3 +931,12 @@ DEF_HELPER_3(xvmskgez_b, void, env, i32, i32)
 DEF_HELPER_3(xvmsknz_b, void, env, i32, i32)
 
 DEF_HELPER_FLAGS_4(xvnori_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_4(xvsllwil_h_b, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsllwil_w_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsllwil_d_w, void, env, i32, i32, i32)
+DEF_HELPER_3(xvextl_q_d, void, env, i32, i32)
+DEF_HELPER_4(xvsllwil_hu_bu, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsllwil_wu_hu, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsllwil_du_wu, void, env, i32, i32, i32)
+DEF_HELPER_3(xvextl_qu_du, void, env, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 5d7deb312e..53631cea63 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -39,6 +39,18 @@ static bool gen_xx(DisasContext *ctx, arg_xx *a,
     return true;
 }
 
+static bool gen_xx_i(DisasContext *ctx, arg_xx_i *a,
+                     void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32))
+{
+    TCGv_i32 xd = tcg_constant_i32(a->xd);
+    TCGv_i32 xj = tcg_constant_i32(a->xj);
+    TCGv_i32 imm = tcg_constant_i32(a->imm);
+
+    CHECK_SXE;
+    func(cpu_env, xd, xj, imm);
+    return true;
+}
+
 static bool gvec_xxx(DisasContext *ctx, arg_xxx *a, MemOp mop,
                      void (*func)(unsigned, uint32_t, uint32_t,
                                   uint32_t, uint32_t, uint32_t))
@@ -2013,6 +2025,15 @@ TRANS(xvrotri_h, gvec_xx_i, MO_16, tcg_gen_gvec_rotri)
 TRANS(xvrotri_w, gvec_xx_i, MO_32, tcg_gen_gvec_rotri)
 TRANS(xvrotri_d, gvec_xx_i, MO_64, tcg_gen_gvec_rotri)
 
+TRANS(xvsllwil_h_b, gen_xx_i, gen_helper_xvsllwil_h_b)
+TRANS(xvsllwil_w_h, gen_xx_i, gen_helper_xvsllwil_w_h)
+TRANS(xvsllwil_d_w, gen_xx_i, gen_helper_xvsllwil_d_w)
+TRANS(xvextl_q_d, gen_xx, gen_helper_xvextl_q_d)
+TRANS(xvsllwil_hu_bu, gen_xx_i, gen_helper_xvsllwil_hu_bu)
+TRANS(xvsllwil_wu_hu, gen_xx_i, gen_helper_xvsllwil_wu_hu)
+TRANS(xvsllwil_du_wu, gen_xx_i, gen_helper_xvsllwil_du_wu)
+TRANS(xvextl_qu_du, gen_xx, gen_helper_xvextl_qu_du)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 03c3aa0019..ebaddb94ea 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1674,6 +1674,15 @@ xvrotri_h        0111 01101010 00000 1 .... ..... .....   @xx_ui4
 xvrotri_w        0111 01101010 00001 ..... ..... .....    @xx_ui5
 xvrotri_d        0111 01101010 0001 ...... ..... .....    @xx_ui6
 
+xvsllwil_h_b     0111 01110000 10000 01 ... ..... .....   @xx_ui3
+xvsllwil_w_h     0111 01110000 10000 1 .... ..... .....   @xx_ui4
+xvsllwil_d_w     0111 01110000 10001 ..... ..... .....    @xx_ui5
+xvextl_q_d       0111 01110000 10010 00000 ..... .....    @xx
+xvsllwil_hu_bu   0111 01110000 11000 01 ... ..... .....   @xx_ui3
+xvsllwil_wu_hu   0111 01110000 11000 1 .... ..... .....   @xx_ui4
+xvsllwil_du_wu   0111 01110000 11001 ..... ..... .....    @xx_ui5
+xvextl_qu_du     0111 01110000 11010 00000 ..... .....    @xx
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index 8e8860c1bb..cd0e18ac3c 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -815,3 +815,48 @@ void HELPER(xvnori_b)(void *xd, void *xj, uint64_t imm, uint32_t v)
         Xd->XB(i) = ~(Xj->XB(i) | (uint8_t)imm);
     }
 }
+
+#define XVSLLWIL(NAME, BIT, E1, E2)                                \
+void HELPER(NAME)(CPULoongArchState *env,                          \
+                  uint32_t xd, uint32_t xj, uint32_t imm)          \
+{                                                                  \
+    int i, max;                                                    \
+    XReg temp;                                                     \
+    XReg *Xd = &(env->fpr[xd].xreg);                               \
+    XReg *Xj = &(env->fpr[xj].xreg);                               \
+    typedef __typeof(temp.E1(0)) TD;                               \
+                                                                   \
+    temp.XQ(0) = int128_zero();                                    \
+    temp.XQ(1) = int128_zero();                                    \
+    max = LASX_LEN / (BIT * 2);                                    \
+    for (i = 0; i < max; i++) {                                    \
+        temp.E1(i) = (TD)Xj->E2(i) << (imm % BIT);                 \
+        temp.E1(i + max) = (TD)Xj->E2(i + max * 2) << (imm % BIT); \
+    }                                                              \
+    *Xd = temp;                                                    \
+}
+
+void HELPER(xvextl_q_d)(CPULoongArchState *env, uint32_t xd, uint32_t xj)
+{
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    Xd->XQ(0) = int128_makes64(Xj->XD(0));
+    Xd->XQ(1) = int128_makes64(Xj->XD(2));
+}
+
+void HELPER(xvextl_qu_du)(CPULoongArchState *env, uint32_t xd, uint32_t xj)
+{
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    Xd->XQ(0) = int128_make64(Xj->UXD(0));
+    Xd->XQ(1) = int128_make64(Xj->UXD(2));
+}
+
+XVSLLWIL(xvsllwil_h_b, 16, XH, XB)
+XVSLLWIL(xvsllwil_w_h, 32, XW, XH)
+XVSLLWIL(xvsllwil_d_w, 64, XD, XW)
+XVSLLWIL(xvsllwil_hu_bu, 16, UXH, UXB)
+XVSLLWIL(xvsllwil_wu_hu, 32, UXW, UXH)
+XVSLLWIL(xvsllwil_du_wu, 64, UXD, UXW)
-- 
2.39.1


