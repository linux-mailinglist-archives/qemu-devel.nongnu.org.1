Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 882F37367F2
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:39:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXpR-0007IX-SZ; Tue, 20 Jun 2023 05:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXpD-0007DW-V0
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:39:03 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXpB-0006Px-HN
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:59 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Ax0Oiic5Fk4iUHAA--.12773S3;
 Tue, 20 Jun 2023 17:38:42 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S45; 
 Tue, 20 Jun 2023 17:38:41 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 43/46] target/loongarch: Implement xvpack xvpick xvilv{l/h}
Date: Tue, 20 Jun 2023 17:38:11 +0800
Message-Id: <20230620093814.123650-44-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S45
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
- XVPACK{EV/OD}.{B/H/W/D};
- XVPICK{EV/OD}.{B/H/W/D};
- XVILV{L/H}.{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  27 ++++
 target/loongarch/helper.h                    |  27 ++++
 target/loongarch/insn_trans/trans_lasx.c.inc |  27 ++++
 target/loongarch/insns.decode                |  27 ++++
 target/loongarch/lasx_helper.c               | 144 +++++++++++++++++++
 5 files changed, 252 insertions(+)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 3b89a5df87..4b815c86b8 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2547,3 +2547,30 @@ INSN_LASX(xvpickve_d,        xx_i)
 
 INSN_LASX(xvbsll_v,          xx_i)
 INSN_LASX(xvbsrl_v,          xx_i)
+
+INSN_LASX(xvpackev_b,        xxx)
+INSN_LASX(xvpackev_h,        xxx)
+INSN_LASX(xvpackev_w,        xxx)
+INSN_LASX(xvpackev_d,        xxx)
+INSN_LASX(xvpackod_b,        xxx)
+INSN_LASX(xvpackod_h,        xxx)
+INSN_LASX(xvpackod_w,        xxx)
+INSN_LASX(xvpackod_d,        xxx)
+
+INSN_LASX(xvpickev_b,        xxx)
+INSN_LASX(xvpickev_h,        xxx)
+INSN_LASX(xvpickev_w,        xxx)
+INSN_LASX(xvpickev_d,        xxx)
+INSN_LASX(xvpickod_b,        xxx)
+INSN_LASX(xvpickod_h,        xxx)
+INSN_LASX(xvpickod_w,        xxx)
+INSN_LASX(xvpickod_d,        xxx)
+
+INSN_LASX(xvilvl_b,          xxx)
+INSN_LASX(xvilvl_h,          xxx)
+INSN_LASX(xvilvl_w,          xxx)
+INSN_LASX(xvilvl_d,          xxx)
+INSN_LASX(xvilvh_b,          xxx)
+INSN_LASX(xvilvh_h,          xxx)
+INSN_LASX(xvilvh_w,          xxx)
+INSN_LASX(xvilvh_d,          xxx)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 6c4525a413..dc5ab59f8e 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -1237,3 +1237,30 @@ DEF_HELPER_4(xvinsve0_w, void, env, i32, i32, i32)
 DEF_HELPER_4(xvinsve0_d, void, env, i32, i32, i32)
 DEF_HELPER_4(xvpickve_w, void, env, i32, i32, i32)
 DEF_HELPER_4(xvpickve_d, void, env, i32, i32, i32)
+
+DEF_HELPER_4(xvpackev_b, void, env, i32, i32, i32)
+DEF_HELPER_4(xvpackev_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvpackev_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvpackev_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvpackod_b, void, env, i32, i32, i32)
+DEF_HELPER_4(xvpackod_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvpackod_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvpackod_d, void, env, i32, i32, i32)
+
+DEF_HELPER_4(xvpickev_b, void, env, i32, i32, i32)
+DEF_HELPER_4(xvpickev_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvpickev_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvpickev_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvpickod_b, void, env, i32, i32, i32)
+DEF_HELPER_4(xvpickod_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvpickod_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvpickod_d, void, env, i32, i32, i32)
+
+DEF_HELPER_4(xvilvl_b, void, env, i32, i32, i32)
+DEF_HELPER_4(xvilvl_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvilvl_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvilvl_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvilvh_b, void, env, i32, i32, i32)
+DEF_HELPER_4(xvilvh_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvilvh_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvilvh_d, void, env, i32, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index e63b1c67c9..75ac0ae1f1 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -3056,3 +3056,30 @@ static bool trans_xvbsrl_v(DisasContext *ctx, arg_xx_i *a)
 
     return true;
 }
+
+TRANS(xvpackev_b, gen_xxx, gen_helper_xvpackev_b)
+TRANS(xvpackev_h, gen_xxx, gen_helper_xvpackev_h)
+TRANS(xvpackev_w, gen_xxx, gen_helper_xvpackev_w)
+TRANS(xvpackev_d, gen_xxx, gen_helper_xvpackev_d)
+TRANS(xvpackod_b, gen_xxx, gen_helper_xvpackod_b)
+TRANS(xvpackod_h, gen_xxx, gen_helper_xvpackod_h)
+TRANS(xvpackod_w, gen_xxx, gen_helper_xvpackod_w)
+TRANS(xvpackod_d, gen_xxx, gen_helper_xvpackod_d)
+
+TRANS(xvpickev_b, gen_xxx, gen_helper_xvpickev_b)
+TRANS(xvpickev_h, gen_xxx, gen_helper_xvpickev_h)
+TRANS(xvpickev_w, gen_xxx, gen_helper_xvpickev_w)
+TRANS(xvpickev_d, gen_xxx, gen_helper_xvpickev_d)
+TRANS(xvpickod_b, gen_xxx, gen_helper_xvpickod_b)
+TRANS(xvpickod_h, gen_xxx, gen_helper_xvpickod_h)
+TRANS(xvpickod_w, gen_xxx, gen_helper_xvpickod_w)
+TRANS(xvpickod_d, gen_xxx, gen_helper_xvpickod_d)
+
+TRANS(xvilvl_b, gen_xxx, gen_helper_xvilvl_b)
+TRANS(xvilvl_h, gen_xxx, gen_helper_xvilvl_h)
+TRANS(xvilvl_w, gen_xxx, gen_helper_xvilvl_w)
+TRANS(xvilvl_d, gen_xxx, gen_helper_xvilvl_d)
+TRANS(xvilvh_b, gen_xxx, gen_helper_xvilvh_b)
+TRANS(xvilvh_h, gen_xxx, gen_helper_xvilvh_h)
+TRANS(xvilvh_w, gen_xxx, gen_helper_xvilvh_w)
+TRANS(xvilvh_d, gen_xxx, gen_helper_xvilvh_d)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 697087e6ef..5c3a18fbe2 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -2051,3 +2051,30 @@ xvpickve_d       0111 01110000 00111 110 .. ..... .....   @xx_ui2
 
 xvbsll_v         0111 01101000 11100 ..... ..... .....    @xx_ui5
 xvbsrl_v         0111 01101000 11101 ..... ..... .....    @xx_ui5
+
+xvpackev_b       0111 01010001 01100 ..... ..... .....    @xxx
+xvpackev_h       0111 01010001 01101 ..... ..... .....    @xxx
+xvpackev_w       0111 01010001 01110 ..... ..... .....    @xxx
+xvpackev_d       0111 01010001 01111 ..... ..... .....    @xxx
+xvpackod_b       0111 01010001 10000 ..... ..... .....    @xxx
+xvpackod_h       0111 01010001 10001 ..... ..... .....    @xxx
+xvpackod_w       0111 01010001 10010 ..... ..... .....    @xxx
+xvpackod_d       0111 01010001 10011 ..... ..... .....    @xxx
+
+xvpickev_b       0111 01010001 11100 ..... ..... .....    @xxx
+xvpickev_h       0111 01010001 11101 ..... ..... .....    @xxx
+xvpickev_w       0111 01010001 11110 ..... ..... .....    @xxx
+xvpickev_d       0111 01010001 11111 ..... ..... .....    @xxx
+xvpickod_b       0111 01010010 00000 ..... ..... .....    @xxx
+xvpickod_h       0111 01010010 00001 ..... ..... .....    @xxx
+xvpickod_w       0111 01010010 00010 ..... ..... .....    @xxx
+xvpickod_d       0111 01010010 00011 ..... ..... .....    @xxx
+
+xvilvl_b         0111 01010001 10100 ..... ..... .....    @xxx
+xvilvl_h         0111 01010001 10101 ..... ..... .....    @xxx
+xvilvl_w         0111 01010001 10110 ..... ..... .....    @xxx
+xvilvl_d         0111 01010001 10111 ..... ..... .....    @xxx
+xvilvh_b         0111 01010001 11000 ..... ..... .....    @xxx
+xvilvh_h         0111 01010001 11001 ..... ..... .....    @xxx
+xvilvh_w         0111 01010001 11010 ..... ..... .....    @xxx
+xvilvh_d         0111 01010001 11011 ..... ..... .....    @xxx
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index 4422c1292e..50991998bf 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -2848,3 +2848,147 @@ void HELPER(NAME)(CPULoongArchState *env,                 \
 
 XVPICKVE(xvpickve_w, XW, 32, 0x7)
 XVPICKVE(xvpickve_d, XD, 64, 0x3)
+
+#define XVPACKEV(NAME, BIT, E)                           \
+void HELPER(NAME)(CPULoongArchState *env,                \
+                  uint32_t xd, uint32_t xj, uint32_t xk) \
+{                                                        \
+    int i;                                               \
+    XReg temp;                                           \
+    XReg *Xd = &(env->fpr[xd].xreg);                     \
+    XReg *Xj = &(env->fpr[xj].xreg);                     \
+    XReg *Xk = &(env->fpr[xk].xreg);                     \
+                                                         \
+    for (i = 0; i < LASX_LEN / (BIT * 2); i++) {         \
+        temp.E(2 * i + 1) = Xj->E(2 * i);                \
+        temp.E(2 * i) = Xk->E(2 * i);                    \
+    }                                                    \
+    *Xd = temp;                                          \
+}
+
+XVPACKEV(xvpackev_b, 8, XB)
+XVPACKEV(xvpackev_h, 16, XH)
+XVPACKEV(xvpackev_w, 32, XW)
+XVPACKEV(xvpackev_d, 64, XD)
+
+#define XVPACKOD(NAME, BIT, E)                           \
+void HELPER(NAME)(CPULoongArchState *env,                \
+                  uint32_t xd, uint32_t xj, uint32_t xk) \
+{                                                        \
+    int i;                                               \
+    XReg temp;                                           \
+    XReg *Xd = &(env->fpr[xd].xreg);                     \
+    XReg *Xj = &(env->fpr[xj].xreg);                     \
+    XReg *Xk = &(env->fpr[xk].xreg);                     \
+                                                         \
+    for (i = 0; i < LASX_LEN / (BIT * 2); i++) {         \
+        temp.E(2 * i + 1) = Xj->E(2 * i + 1);            \
+        temp.E(2 * i) = Xk->E(2 * i + 1);                \
+    }                                                    \
+    *Xd = temp;                                          \
+}
+
+XVPACKOD(xvpackod_b, 8, XB)
+XVPACKOD(xvpackod_h, 16, XH)
+XVPACKOD(xvpackod_w, 32, XW)
+XVPACKOD(xvpackod_d, 64, XD)
+
+#define XVPICKEV(NAME, BIT, E)                           \
+void HELPER(NAME)(CPULoongArchState *env,                \
+                  uint32_t xd, uint32_t xj, uint32_t xk) \
+{                                                        \
+    int i, max;                                          \
+    XReg temp;                                           \
+    XReg *Xd = &(env->fpr[xd].xreg);                     \
+    XReg *Xj = &(env->fpr[xj].xreg);                     \
+    XReg *Xk = &(env->fpr[xk].xreg);                     \
+                                                         \
+    max = LASX_LEN / (BIT * 4);                          \
+    for (i = 0; i < max; i++) {                          \
+        temp.E(i + max) = Xj->E(2 * i);                  \
+        temp.E(i) = Xk->E(2 * i);                        \
+        temp.E(i + max * 3) = Xj->E(2 * i + max * 2);    \
+        temp.E(i + max * 2) = Xk->E(2 * i + max * 2);    \
+    }                                                    \
+    *Xd = temp;                                          \
+}
+
+XVPICKEV(xvpickev_b, 8, XB)
+XVPICKEV(xvpickev_h, 16, XH)
+XVPICKEV(xvpickev_w, 32, XW)
+XVPICKEV(xvpickev_d, 64, XD)
+
+#define XVPICKOD(NAME, BIT, E)                            \
+void HELPER(NAME)(CPULoongArchState *env,                 \
+                  uint32_t xd, uint32_t xj, uint32_t xk)  \
+{                                                         \
+    int i, max;                                           \
+    XReg temp;                                            \
+    XReg *Xd = &(env->fpr[xd].xreg);                      \
+    XReg *Xj = &(env->fpr[xj].xreg);                      \
+    XReg *Xk = &(env->fpr[xk].xreg);                      \
+                                                          \
+    max = LASX_LEN / (BIT * 4);                           \
+    for (i = 0; i < max; i++) {                           \
+        temp.E(i + max) = Xj->E(2 * i + 1);               \
+        temp.E(i) = Xk->E(2 * i + 1);                     \
+        temp.E(i + max * 3) = Xj->E(2 * i + 1 + max * 2); \
+        temp.E(i + max * 2) = Xk->E(2 * i + 1 + max * 2); \
+    }                                                     \
+    *Xd = temp;                                           \
+}
+
+XVPICKOD(xvpickod_b, 8, XB)
+XVPICKOD(xvpickod_h, 16, XH)
+XVPICKOD(xvpickod_w, 32, XW)
+XVPICKOD(xvpickod_d, 64, XD)
+
+#define XVILVL(NAME, BIT, E)                              \
+void HELPER(NAME)(CPULoongArchState *env,                 \
+                  uint32_t xd, uint32_t xj, uint32_t xk)  \
+{                                                         \
+    int i, max;                                           \
+    XReg temp;                                            \
+    XReg *Xd = &(env->fpr[xd].xreg);                      \
+    XReg *Xj = &(env->fpr[xj].xreg);                      \
+    XReg *Xk = &(env->fpr[xk].xreg);                      \
+                                                          \
+    max = LASX_LEN / (BIT * 4);                           \
+    for (i = 0; i < max; i++) {                           \
+        temp.E(2 * i + 1) = Xj->E(i);                     \
+        temp.E(2 * i) = Xk->E(i);                         \
+        temp.E(2 * i + 1 + max * 2) = Xj->E(i + max * 2); \
+        temp.E(2 * i + max * 2) = Xk->E(i + max * 2);     \
+    }                                                     \
+    *Xd = temp;                                           \
+}
+
+XVILVL(xvilvl_b, 8, XB)
+XVILVL(xvilvl_h, 16, XH)
+XVILVL(xvilvl_w, 32, XW)
+XVILVL(xvilvl_d, 64, XD)
+
+#define XVILVH(NAME, BIT, E)                               \
+void HELPER(NAME)(CPULoongArchState *env,                  \
+                  uint32_t xd, uint32_t xj, uint32_t xk)   \
+{                                                          \
+    int i, max;                                            \
+    XReg temp;                                             \
+    XReg *Xd = &(env->fpr[xd].xreg);                       \
+    XReg *Xj = &(env->fpr[xj].xreg);                       \
+    XReg *Xk = &(env->fpr[xk].xreg);                       \
+                                                           \
+    max = LASX_LEN / (BIT * 4);                            \
+    for (i = 0; i < max; i++) {                            \
+        temp.E(2 * i + 1) = Xj->E(i + max);                \
+        temp.E(2 * i) = Xk->E(i + max);                    \
+        temp.E(2 * i +  1 + max * 2) = Xj->E(i + max * 3); \
+        temp.E(2 * i + max * 2) = Xk->E(i + max * 3);      \
+    }                                                      \
+    *Xd = temp;                                            \
+}
+
+XVILVH(xvilvh_b, 8, XB)
+XVILVH(xvilvh_h, 16, XH)
+XVILVH(xvilvh_w, 32, XW)
+XVILVH(xvilvh_d, 64, XD)
-- 
2.39.1


