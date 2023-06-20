Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C6073681A
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:43:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXqf-000465-3X; Tue, 20 Jun 2023 05:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXqT-0002nO-1t
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:40:18 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXqM-0006aV-Op
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:40:16 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxDeuac5FkzCUHAA--.14735S3;
 Tue, 20 Jun 2023 17:38:34 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S34; 
 Tue, 20 Jun 2023 17:38:33 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 32/46] target/loongarch: Implement xvclo xvclz
Date: Tue, 20 Jun 2023 17:38:00 +0800
Message-Id: <20230620093814.123650-33-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S34
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
- XVCLO.{B/H/W/D};
- XVCLZ.{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  9 +++++++++
 target/loongarch/helper.h                    |  9 +++++++++
 target/loongarch/insn_trans/trans_lasx.c.inc |  9 +++++++++
 target/loongarch/insns.decode                |  9 +++++++++
 target/loongarch/lasx_helper.c               | 21 ++++++++++++++++++++
 target/loongarch/lsx_helper.c                |  9 ---------
 target/loongarch/vec.h                       |  9 +++++++++
 7 files changed, 66 insertions(+), 9 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index da07b56dee..99636ca56c 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2195,6 +2195,15 @@ INSN_LASX(xvssrarni_hu_w,    xx_i)
 INSN_LASX(xvssrarni_wu_d,    xx_i)
 INSN_LASX(xvssrarni_du_q,    xx_i)
 
+INSN_LASX(xvclo_b,           xx)
+INSN_LASX(xvclo_h,           xx)
+INSN_LASX(xvclo_w,           xx)
+INSN_LASX(xvclo_d,           xx)
+INSN_LASX(xvclz_b,           xx)
+INSN_LASX(xvclz_h,           xx)
+INSN_LASX(xvclz_w,           xx)
+INSN_LASX(xvclz_d,           xx)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index b5d1cff1f0..950a73ec6f 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -1050,3 +1050,12 @@ DEF_HELPER_4(xvssrarni_bu_h, void, env, i32, i32, i32)
 DEF_HELPER_4(xvssrarni_hu_w, void, env, i32, i32, i32)
 DEF_HELPER_4(xvssrarni_wu_d, void, env, i32, i32, i32)
 DEF_HELPER_4(xvssrarni_du_q, void, env, i32, i32, i32)
+
+DEF_HELPER_3(xvclo_b, void, env, i32, i32)
+DEF_HELPER_3(xvclo_h, void, env, i32, i32)
+DEF_HELPER_3(xvclo_w, void, env, i32, i32)
+DEF_HELPER_3(xvclo_d, void, env, i32, i32)
+DEF_HELPER_3(xvclz_b, void, env, i32, i32)
+DEF_HELPER_3(xvclz_h, void, env, i32, i32)
+DEF_HELPER_3(xvclz_w, void, env, i32, i32)
+DEF_HELPER_3(xvclz_d, void, env, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index aa145c850b..fa7dafa7f9 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -2144,6 +2144,15 @@ TRANS(xvssrarni_hu_w, gen_xx_i, gen_helper_xvssrarni_hu_w)
 TRANS(xvssrarni_wu_d, gen_xx_i, gen_helper_xvssrarni_wu_d)
 TRANS(xvssrarni_du_q, gen_xx_i, gen_helper_xvssrarni_du_q)
 
+TRANS(xvclo_b, gen_xx, gen_helper_xvclo_b)
+TRANS(xvclo_h, gen_xx, gen_helper_xvclo_h)
+TRANS(xvclo_w, gen_xx, gen_helper_xvclo_w)
+TRANS(xvclo_d, gen_xx, gen_helper_xvclo_d)
+TRANS(xvclz_b, gen_xx, gen_helper_xvclz_b)
+TRANS(xvclz_h, gen_xx, gen_helper_xvclz_h)
+TRANS(xvclz_w, gen_xx, gen_helper_xvclz_w)
+TRANS(xvclz_d, gen_xx, gen_helper_xvclz_d)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 3aed69b766..91de5a3815 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1793,6 +1793,15 @@ xvssrarni_hu_w   0111 01110110 11001 ..... ..... .....    @xx_ui5
 xvssrarni_wu_d   0111 01110110 1101 ...... ..... .....    @xx_ui6
 xvssrarni_du_q   0111 01110110 111 ....... ..... .....    @xx_ui7
 
+xvclo_b          0111 01101001 11000 00000 ..... .....    @xx
+xvclo_h          0111 01101001 11000 00001 ..... .....    @xx
+xvclo_w          0111 01101001 11000 00010 ..... .....    @xx
+xvclo_d          0111 01101001 11000 00011 ..... .....    @xx
+xvclz_b          0111 01101001 11000 00100 ..... .....    @xx
+xvclz_h          0111 01101001 11000 00101 ..... .....    @xx
+xvclz_w          0111 01101001 11000 00110 ..... .....    @xx
+xvclz_d          0111 01101001 11000 00111 ..... .....    @xx
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index 0e223601de..122c460fb5 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -2081,3 +2081,24 @@ void HELPER(xvssrarni_du_q)(CPULoongArchState *env,
 XVSSRARNUI(xvssrarni_bu_h, 16, XB, XH)
 XVSSRARNUI(xvssrarni_hu_w, 32, XH, XW)
 XVSSRARNUI(xvssrarni_wu_d, 64, XW, XD)
+
+#define XDO_2OP(NAME, BIT, E, DO_OP)                                \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t xd, uint32_t xj) \
+{                                                                   \
+    int i;                                                          \
+    XReg *Xd = &(env->fpr[xd].xreg);                                \
+    XReg *Xj = &(env->fpr[xj].xreg);                                \
+                                                                    \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                          \
+        Xd->E(i) = DO_OP(Xj->E(i));                                 \
+    }                                                               \
+}
+
+XDO_2OP(xvclo_b, 8, UXB, DO_CLO_B)
+XDO_2OP(xvclo_h, 16, UXH, DO_CLO_H)
+XDO_2OP(xvclo_w, 32, UXW, DO_CLO_W)
+XDO_2OP(xvclo_d, 64, UXD, DO_CLO_D)
+XDO_2OP(xvclz_b, 8, UXB, DO_CLZ_B)
+XDO_2OP(xvclz_h, 16, UXH, DO_CLZ_H)
+XDO_2OP(xvclz_w, 32, UXW, DO_CLZ_W)
+XDO_2OP(xvclz_d, 64, UXD, DO_CLZ_D)
diff --git a/target/loongarch/lsx_helper.c b/target/loongarch/lsx_helper.c
index d21e4006f2..e1b448a2e6 100644
--- a/target/loongarch/lsx_helper.c
+++ b/target/loongarch/lsx_helper.c
@@ -1910,15 +1910,6 @@ void HELPER(NAME)(CPULoongArchState *env, uint32_t vd, uint32_t vj) \
     }                                                               \
 }
 
-#define DO_CLO_B(N)  (clz32(~N & 0xff) - 24)
-#define DO_CLO_H(N)  (clz32(~N & 0xffff) - 16)
-#define DO_CLO_W(N)  (clz32(~N))
-#define DO_CLO_D(N)  (clz64(~N))
-#define DO_CLZ_B(N)  (clz32(N) - 24)
-#define DO_CLZ_H(N)  (clz32(N) - 16)
-#define DO_CLZ_W(N)  (clz32(N))
-#define DO_CLZ_D(N)  (clz64(N))
-
 DO_2OP(vclo_b, 8, UB, DO_CLO_B)
 DO_2OP(vclo_h, 16, UH, DO_CLO_H)
 DO_2OP(vclo_w, 32, UW, DO_CLO_W)
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index b5cdb4b470..db5704dd05 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -77,6 +77,15 @@
 
 #define R_SHIFT(a, b) (a >> b)
 
+#define DO_CLO_B(N)  (clz32(~N & 0xff) - 24)
+#define DO_CLO_H(N)  (clz32(~N & 0xffff) - 16)
+#define DO_CLO_W(N)  (clz32(~N))
+#define DO_CLO_D(N)  (clz64(~N))
+#define DO_CLZ_B(N)  (clz32(N) - 24)
+#define DO_CLZ_H(N)  (clz32(N) - 16)
+#define DO_CLZ_W(N)  (clz32(N))
+#define DO_CLZ_D(N)  (clz64(N))
+
 uint64_t do_vmskltz_b(int64_t val);
 uint64_t do_vmskltz_h(int64_t val);
 uint64_t do_vmskltz_w(int64_t val);
-- 
2.39.1


