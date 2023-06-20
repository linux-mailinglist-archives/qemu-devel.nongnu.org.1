Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 277F5736832
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:45:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXqZ-0003Iz-B7; Tue, 20 Jun 2023 05:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXqR-0002j5-EN
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:40:16 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXqM-0006aM-Gc
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:40:15 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxIuibc5FkzyUHAA--.621S3;
 Tue, 20 Jun 2023 17:38:35 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S35; 
 Tue, 20 Jun 2023 17:38:34 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 33/46] target/loongarch: Implement xvpcnt
Date: Tue, 20 Jun 2023 17:38:01 +0800
Message-Id: <20230620093814.123650-34-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S35
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
- VPCNT.{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  5 +++++
 target/loongarch/helper.h                    |  5 +++++
 target/loongarch/insn_trans/trans_lasx.c.inc |  5 +++++
 target/loongarch/insns.decode                |  5 +++++
 target/loongarch/lasx_helper.c               | 17 +++++++++++++++++
 5 files changed, 37 insertions(+)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 99636ca56c..b7a322651f 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2204,6 +2204,11 @@ INSN_LASX(xvclz_h,           xx)
 INSN_LASX(xvclz_w,           xx)
 INSN_LASX(xvclz_d,           xx)
 
+INSN_LASX(xvpcnt_b,          xx)
+INSN_LASX(xvpcnt_h,          xx)
+INSN_LASX(xvpcnt_w,          xx)
+INSN_LASX(xvpcnt_d,          xx)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 950a73ec6f..a434443819 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -1059,3 +1059,8 @@ DEF_HELPER_3(xvclz_b, void, env, i32, i32)
 DEF_HELPER_3(xvclz_h, void, env, i32, i32)
 DEF_HELPER_3(xvclz_w, void, env, i32, i32)
 DEF_HELPER_3(xvclz_d, void, env, i32, i32)
+
+DEF_HELPER_3(xvpcnt_b, void, env, i32, i32)
+DEF_HELPER_3(xvpcnt_h, void, env, i32, i32)
+DEF_HELPER_3(xvpcnt_w, void, env, i32, i32)
+DEF_HELPER_3(xvpcnt_d, void, env, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index fa7dafa7f9..616d296432 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -2153,6 +2153,11 @@ TRANS(xvclz_h, gen_xx, gen_helper_xvclz_h)
 TRANS(xvclz_w, gen_xx, gen_helper_xvclz_w)
 TRANS(xvclz_d, gen_xx, gen_helper_xvclz_d)
 
+TRANS(xvpcnt_b, gen_xx, gen_helper_xvpcnt_b)
+TRANS(xvpcnt_h, gen_xx, gen_helper_xvpcnt_h)
+TRANS(xvpcnt_w, gen_xx, gen_helper_xvpcnt_w)
+TRANS(xvpcnt_d, gen_xx, gen_helper_xvpcnt_d)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 91de5a3815..7d49ddb0ea 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1802,6 +1802,11 @@ xvclz_h          0111 01101001 11000 00101 ..... .....    @xx
 xvclz_w          0111 01101001 11000 00110 ..... .....    @xx
 xvclz_d          0111 01101001 11000 00111 ..... .....    @xx
 
+xvpcnt_b         0111 01101001 11000 01000 ..... .....    @xx
+xvpcnt_h         0111 01101001 11000 01001 ..... .....    @xx
+xvpcnt_w         0111 01101001 11000 01010 ..... .....    @xx
+xvpcnt_d         0111 01101001 11000 01011 ..... .....    @xx
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index 122c460fb5..f04817984b 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -2102,3 +2102,20 @@ XDO_2OP(xvclz_b, 8, UXB, DO_CLZ_B)
 XDO_2OP(xvclz_h, 16, UXH, DO_CLZ_H)
 XDO_2OP(xvclz_w, 32, UXW, DO_CLZ_W)
 XDO_2OP(xvclz_d, 64, UXD, DO_CLZ_D)
+
+#define XVPCNT(NAME, BIT, E, FN)                                    \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t xd, uint32_t xj) \
+{                                                                   \
+    int i;                                                          \
+    XReg *Xd = &(env->fpr[xd].xreg);                                \
+    XReg *Xj = &(env->fpr[xj].xreg);                                \
+                                                                    \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                          \
+        Xd->E(i) = FN(Xj->E(i));                                    \
+    }                                                               \
+}
+
+XVPCNT(xvpcnt_b, 8, UXB, ctpop8)
+XVPCNT(xvpcnt_h, 16, UXH, ctpop16)
+XVPCNT(xvpcnt_w, 32, UXW, ctpop32)
+XVPCNT(xvpcnt_d, 64, UXD, ctpop64)
-- 
2.39.1


