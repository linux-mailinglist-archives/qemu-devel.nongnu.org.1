Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BE2736823
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:44:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXp6-0007B8-3M; Tue, 20 Jun 2023 05:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXp3-00079w-4J
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:49 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXoy-0006NV-8N
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:48 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxtOiWc5FkwiUHAA--.4340S3;
 Tue, 20 Jun 2023 17:38:30 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S29; 
 Tue, 20 Jun 2023 17:38:30 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 27/46] target/loongarch: Implement xvsrlr xvsrar
Date: Tue, 20 Jun 2023 17:37:55 +0800
Message-Id: <20230620093814.123650-28-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S29
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
- XVSRLR[I].{B/H/W/D};
- XVSRAR[I].{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  18 ++++
 target/loongarch/helper.h                    |  18 ++++
 target/loongarch/insn_trans/trans_lasx.c.inc |  18 ++++
 target/loongarch/insns.decode                |  17 +++
 target/loongarch/lasx_helper.c               | 104 +++++++++++++++++++
 5 files changed, 175 insertions(+)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index b6940e6389..a63ba6d6ee 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2085,6 +2085,24 @@ INSN_LASX(xvsllwil_wu_hu,    xx_i)
 INSN_LASX(xvsllwil_du_wu,    xx_i)
 INSN_LASX(xvextl_qu_du,      xx)
 
+INSN_LASX(xvsrlr_b,          xxx)
+INSN_LASX(xvsrlr_h,          xxx)
+INSN_LASX(xvsrlr_w,          xxx)
+INSN_LASX(xvsrlr_d,          xxx)
+INSN_LASX(xvsrlri_b,         xx_i)
+INSN_LASX(xvsrlri_h,         xx_i)
+INSN_LASX(xvsrlri_w,         xx_i)
+INSN_LASX(xvsrlri_d,         xx_i)
+
+INSN_LASX(xvsrar_b,          xxx)
+INSN_LASX(xvsrar_h,          xxx)
+INSN_LASX(xvsrar_w,          xxx)
+INSN_LASX(xvsrar_d,          xxx)
+INSN_LASX(xvsrari_b,         xx_i)
+INSN_LASX(xvsrari_h,         xx_i)
+INSN_LASX(xvsrari_w,         xx_i)
+INSN_LASX(xvsrari_d,         xx_i)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 672a5f8988..6bb30ddd31 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -940,3 +940,21 @@ DEF_HELPER_4(xvsllwil_hu_bu, void, env, i32, i32, i32)
 DEF_HELPER_4(xvsllwil_wu_hu, void, env, i32, i32, i32)
 DEF_HELPER_4(xvsllwil_du_wu, void, env, i32, i32, i32)
 DEF_HELPER_3(xvextl_qu_du, void, env, i32, i32)
+
+DEF_HELPER_4(xvsrlr_b, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrlr_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrlr_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrlr_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrlri_b, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrlri_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrlri_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrlri_d, void, env, i32, i32, i32)
+
+DEF_HELPER_4(xvsrar_b, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrar_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrar_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrar_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrari_b, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrari_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrari_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrari_d, void, env, i32, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 53631cea63..602ba0c800 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -2034,6 +2034,24 @@ TRANS(xvsllwil_wu_hu, gen_xx_i, gen_helper_xvsllwil_wu_hu)
 TRANS(xvsllwil_du_wu, gen_xx_i, gen_helper_xvsllwil_du_wu)
 TRANS(xvextl_qu_du, gen_xx, gen_helper_xvextl_qu_du)
 
+TRANS(xvsrlr_b, gen_xxx, gen_helper_xvsrlr_b)
+TRANS(xvsrlr_h, gen_xxx, gen_helper_xvsrlr_h)
+TRANS(xvsrlr_w, gen_xxx, gen_helper_xvsrlr_w)
+TRANS(xvsrlr_d, gen_xxx, gen_helper_xvsrlr_d)
+TRANS(xvsrlri_b, gen_xx_i, gen_helper_xvsrlri_b)
+TRANS(xvsrlri_h, gen_xx_i, gen_helper_xvsrlri_h)
+TRANS(xvsrlri_w, gen_xx_i, gen_helper_xvsrlri_w)
+TRANS(xvsrlri_d, gen_xx_i, gen_helper_xvsrlri_d)
+
+TRANS(xvsrar_b, gen_xxx, gen_helper_xvsrar_b)
+TRANS(xvsrar_h, gen_xxx, gen_helper_xvsrar_h)
+TRANS(xvsrar_w, gen_xxx, gen_helper_xvsrar_w)
+TRANS(xvsrar_d, gen_xxx, gen_helper_xvsrar_d)
+TRANS(xvsrari_b, gen_xx_i, gen_helper_xvsrari_b)
+TRANS(xvsrari_h, gen_xx_i, gen_helper_xvsrari_h)
+TRANS(xvsrari_w, gen_xx_i, gen_helper_xvsrari_w)
+TRANS(xvsrari_d, gen_xx_i, gen_helper_xvsrari_d)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index ebaddb94ea..d901ddf063 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1683,6 +1683,23 @@ xvsllwil_wu_hu   0111 01110000 11000 1 .... ..... .....   @xx_ui4
 xvsllwil_du_wu   0111 01110000 11001 ..... ..... .....    @xx_ui5
 xvextl_qu_du     0111 01110000 11010 00000 ..... .....    @xx
 
+xvsrlr_b         0111 01001111 00000 ..... ..... .....    @xxx
+xvsrlr_h         0111 01001111 00001 ..... ..... .....    @xxx
+xvsrlr_w         0111 01001111 00010 ..... ..... .....    @xxx
+xvsrlr_d         0111 01001111 00011 ..... ..... .....    @xxx
+xvsrlri_b        0111 01101010 01000 01 ... ..... .....   @xx_ui3
+xvsrlri_h        0111 01101010 01000 1 .... ..... .....   @xx_ui4
+xvsrlri_w        0111 01101010 01001 ..... ..... .....    @xx_ui5
+xvsrlri_d        0111 01101010 0101 ...... ..... .....    @xx_ui6
+xvsrar_b         0111 01001111 00100 ..... ..... .....    @xxx
+xvsrar_h         0111 01001111 00101 ..... ..... .....    @xxx
+xvsrar_w         0111 01001111 00110 ..... ..... .....    @xxx
+xvsrar_d         0111 01001111 00111 ..... ..... .....    @xxx
+xvsrari_b        0111 01101010 10000 01 ... ..... .....   @xx_ui3
+xvsrari_h        0111 01101010 10000 1 .... ..... .....   @xx_ui4
+xvsrari_w        0111 01101010 10001 ..... ..... .....    @xx_ui5
+xvsrari_d        0111 01101010 1001 ...... ..... .....    @xx_ui6
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index cd0e18ac3c..ebbbf014f7 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -860,3 +860,107 @@ XVSLLWIL(xvsllwil_d_w, 64, XD, XW)
 XVSLLWIL(xvsllwil_hu_bu, 16, UXH, UXB)
 XVSLLWIL(xvsllwil_wu_hu, 32, UXW, UXH)
 XVSLLWIL(xvsllwil_du_wu, 64, UXD, UXW)
+
+#define do_xvsrlr(E, T)                                 \
+static T do_xvsrlr_ ##E(T s1, int sh)                   \
+{                                                       \
+    if (sh == 0) {                                      \
+        return s1;                                      \
+    } else {                                            \
+        return  (s1 >> sh)  + ((s1 >> (sh - 1)) & 0x1); \
+    }                                                   \
+}
+
+do_xvsrlr(XB, uint8_t)
+do_xvsrlr(XH, uint16_t)
+do_xvsrlr(XW, uint32_t)
+do_xvsrlr(XD, uint64_t)
+
+#define XVSRLR(NAME, BIT, E1, E2)                                   \
+void HELPER(NAME)(CPULoongArchState *env,                           \
+                  uint32_t xd, uint32_t xj, uint32_t xk)            \
+{                                                                   \
+    int i;                                                          \
+    XReg *Xd = &(env->fpr[xd].xreg);                                \
+    XReg *Xj = &(env->fpr[xj].xreg);                                \
+    XReg *Xk = &(env->fpr[xk].xreg);                                \
+                                                                    \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                          \
+        Xd->E1(i) = do_xvsrlr_ ## E1(Xj->E1(i), (Xk->E2(i)) % BIT); \
+    }                                                               \
+}
+
+XVSRLR(xvsrlr_b, 8, XB, UXB)
+XVSRLR(xvsrlr_h, 16, XH, UXH)
+XVSRLR(xvsrlr_w, 32, XW, UXW)
+XVSRLR(xvsrlr_d, 64, XD, UXD)
+
+#define XVSRLRI(NAME, BIT, E)                             \
+void HELPER(NAME)(CPULoongArchState *env,                 \
+                  uint32_t xd, uint32_t xj, uint32_t imm) \
+{                                                         \
+    int i;                                                \
+    XReg *Xd = &(env->fpr[xd].xreg);                      \
+    XReg *Xj = &(env->fpr[xj].xreg);                      \
+                                                          \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                \
+        Xd->E(i) = do_xvsrlr_ ## E(Xj->E(i), imm);        \
+    }                                                     \
+}
+
+XVSRLRI(xvsrlri_b, 8, XB)
+XVSRLRI(xvsrlri_h, 16, XH)
+XVSRLRI(xvsrlri_w, 32, XW)
+XVSRLRI(xvsrlri_d, 64, XD)
+
+#define do_xvsrar(E, T)                                 \
+static T do_xvsrar_ ##E(T s1, int sh)                   \
+{                                                       \
+    if (sh == 0) {                                      \
+        return s1;                                      \
+    } else {                                            \
+        return  (s1 >> sh)  + ((s1 >> (sh - 1)) & 0x1); \
+    }                                                   \
+}
+
+do_xvsrar(XB, int8_t)
+do_xvsrar(XH, int16_t)
+do_xvsrar(XW, int32_t)
+do_xvsrar(XD, int64_t)
+
+#define XVSRAR(NAME, BIT, E1, E2)                                   \
+void HELPER(NAME)(CPULoongArchState *env,                           \
+                  uint32_t xd, uint32_t xj, uint32_t xk)            \
+{                                                                   \
+    int i;                                                          \
+    XReg *Xd = &(env->fpr[xd].xreg);                                \
+    XReg *Xj = &(env->fpr[xj].xreg);                                \
+    XReg *Xk = &(env->fpr[xk].xreg);                                \
+                                                                    \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                          \
+        Xd->E1(i) = do_xvsrar_ ## E1(Xj->E1(i), (Xk->E2(i)) % BIT); \
+    }                                                               \
+}
+
+XVSRAR(xvsrar_b, 8, XB, UXB)
+XVSRAR(xvsrar_h, 16, XH, UXH)
+XVSRAR(xvsrar_w, 32, XW, UXW)
+XVSRAR(xvsrar_d, 64, XD, UXD)
+
+#define XVSRARI(NAME, BIT, E)                             \
+void HELPER(NAME)(CPULoongArchState *env,                 \
+                  uint32_t xd, uint32_t xj, uint32_t imm) \
+{                                                         \
+    int i;                                                \
+    XReg *Xd = &(env->fpr[xd].xreg);                      \
+    XReg *Xj = &(env->fpr[xj].xreg);                      \
+                                                          \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                \
+        Xd->E(i) = do_xvsrar_ ## E(Xj->E(i), imm);        \
+    }                                                     \
+}
+
+XVSRARI(xvsrari_b, 8, XB)
+XVSRARI(xvsrari_h, 16, XH)
+XVSRARI(xvsrari_w, 32, XW)
+XVSRARI(xvsrari_d, 64, XD)
-- 
2.39.1


