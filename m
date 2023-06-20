Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B03F7367F7
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:40:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXpQ-0007FK-HM; Tue, 20 Jun 2023 05:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXp4-0007Ar-SP
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:50 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXoy-0006Nc-O4
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:50 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxTuuYc5FkxiUHAA--.14551S3;
 Tue, 20 Jun 2023 17:38:32 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S31; 
 Tue, 20 Jun 2023 17:38:31 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 29/46] target/loongarch: Implement xvsrlrn xvsrarn
Date: Tue, 20 Jun 2023 17:37:57 +0800
Message-Id: <20230620093814.123650-30-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S31
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
- XVSRLRN.{B.H/H.W/W.D};
- XVSRARN.{B.H/H.W/W.D};
- XVSRLRNI.{B.H/H.W/W.D/D.Q};
- XVSRARNI.{B.H/H.W/W.D/D.Q}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  16 ++
 target/loongarch/helper.h                    |  16 ++
 target/loongarch/insn_trans/trans_lasx.c.inc |  16 ++
 target/loongarch/insns.decode                |  16 ++
 target/loongarch/lasx_helper.c               | 150 +++++++++++++++++++
 5 files changed, 214 insertions(+)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 5ea713075f..515d99aa1f 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2119,6 +2119,22 @@ INSN_LASX(xvsrani_h_w,       xx_i)
 INSN_LASX(xvsrani_w_d,       xx_i)
 INSN_LASX(xvsrani_d_q,       xx_i)
 
+INSN_LASX(xvsrlrn_b_h,       xxx)
+INSN_LASX(xvsrlrn_h_w,       xxx)
+INSN_LASX(xvsrlrn_w_d,       xxx)
+INSN_LASX(xvsrarn_b_h,       xxx)
+INSN_LASX(xvsrarn_h_w,       xxx)
+INSN_LASX(xvsrarn_w_d,       xxx)
+
+INSN_LASX(xvsrlrni_b_h,      xx_i)
+INSN_LASX(xvsrlrni_h_w,      xx_i)
+INSN_LASX(xvsrlrni_w_d,      xx_i)
+INSN_LASX(xvsrlrni_d_q,      xx_i)
+INSN_LASX(xvsrarni_b_h,      xx_i)
+INSN_LASX(xvsrarni_h_w,      xx_i)
+INSN_LASX(xvsrarni_w_d,      xx_i)
+INSN_LASX(xvsrarni_d_q,      xx_i)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index c41f8e2bc9..09ae21edd6 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -974,3 +974,19 @@ DEF_HELPER_4(xvsrani_b_h, void, env, i32, i32, i32)
 DEF_HELPER_4(xvsrani_h_w, void, env, i32, i32, i32)
 DEF_HELPER_4(xvsrani_w_d, void, env, i32, i32, i32)
 DEF_HELPER_4(xvsrani_d_q, void, env, i32, i32, i32)
+
+DEF_HELPER_4(xvsrlrn_b_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrlrn_h_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrlrn_w_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrarn_b_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrarn_h_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrarn_w_d, void, env, i32, i32, i32)
+
+DEF_HELPER_4(xvsrlrni_b_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrlrni_h_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrlrni_w_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrlrni_d_q, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrarni_b_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrarni_h_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrarni_w_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrarni_d_q, void, env, i32, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 9a3c2114eb..5cd241bafa 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -2068,6 +2068,22 @@ TRANS(xvsrani_h_w, gen_xx_i, gen_helper_xvsrani_h_w)
 TRANS(xvsrani_w_d, gen_xx_i, gen_helper_xvsrani_w_d)
 TRANS(xvsrani_d_q, gen_xx_i, gen_helper_xvsrani_d_q)
 
+TRANS(xvsrlrn_b_h, gen_xxx, gen_helper_xvsrlrn_b_h)
+TRANS(xvsrlrn_h_w, gen_xxx, gen_helper_xvsrlrn_h_w)
+TRANS(xvsrlrn_w_d, gen_xxx, gen_helper_xvsrlrn_w_d)
+TRANS(xvsrarn_b_h, gen_xxx, gen_helper_xvsrarn_b_h)
+TRANS(xvsrarn_h_w, gen_xxx, gen_helper_xvsrarn_h_w)
+TRANS(xvsrarn_w_d, gen_xxx, gen_helper_xvsrarn_w_d)
+
+TRANS(xvsrlrni_b_h, gen_xx_i, gen_helper_xvsrlrni_b_h)
+TRANS(xvsrlrni_h_w, gen_xx_i, gen_helper_xvsrlrni_h_w)
+TRANS(xvsrlrni_w_d, gen_xx_i, gen_helper_xvsrlrni_w_d)
+TRANS(xvsrlrni_d_q, gen_xx_i, gen_helper_xvsrlrni_d_q)
+TRANS(xvsrarni_b_h, gen_xx_i, gen_helper_xvsrarni_b_h)
+TRANS(xvsrarni_h_w, gen_xx_i, gen_helper_xvsrarni_h_w)
+TRANS(xvsrarni_w_d, gen_xx_i, gen_helper_xvsrarni_w_d)
+TRANS(xvsrarni_d_q, gen_xx_i, gen_helper_xvsrarni_d_q)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 45f15e3be2..0273576ada 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1717,6 +1717,22 @@ xvsrani_h_w      0111 01110101 10001 ..... ..... .....    @xx_ui5
 xvsrani_w_d      0111 01110101 1001 ...... ..... .....    @xx_ui6
 xvsrani_d_q      0111 01110101 101 ....... ..... .....    @xx_ui7
 
+xvsrlrn_b_h      0111 01001111 10001 ..... ..... .....    @xxx
+xvsrlrn_h_w      0111 01001111 10010 ..... ..... .....    @xxx
+xvsrlrn_w_d      0111 01001111 10011 ..... ..... .....    @xxx
+xvsrarn_b_h      0111 01001111 10101 ..... ..... .....    @xxx
+xvsrarn_h_w      0111 01001111 10110 ..... ..... .....    @xxx
+xvsrarn_w_d      0111 01001111 10111 ..... ..... .....    @xxx
+
+xvsrlrni_b_h     0111 01110100 01000 1 .... ..... .....   @xx_ui4
+xvsrlrni_h_w     0111 01110100 01001 ..... ..... .....    @xx_ui5
+xvsrlrni_w_d     0111 01110100 0101 ...... ..... .....    @xx_ui6
+xvsrlrni_d_q     0111 01110100 011 ....... ..... .....    @xx_ui7
+xvsrarni_b_h     0111 01110101 11000 1 .... ..... .....   @xx_ui4
+xvsrarni_h_w     0111 01110101 11001 ..... ..... .....    @xx_ui5
+xvsrarni_w_d     0111 01110101 1101 ...... ..... .....    @xx_ui6
+xvsrarni_d_q     0111 01110101 111 ....... ..... .....    @xx_ui7
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index 02550646d7..b0d5f93a97 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -1092,3 +1092,153 @@ void HELPER(xvsrani_d_q)(CPULoongArchState *env,
 XVSRANI(xvsrani_b_h, 16, XB, XH)
 XVSRANI(xvsrani_h_w, 32, XH, XW)
 XVSRANI(xvsrani_w_d, 64, XW, XD)
+
+#define XVSRLRN(NAME, BIT, E1, E2, E3)                                \
+void HELPER(NAME)(CPULoongArchState *env,                             \
+                  uint32_t xd, uint32_t xj, uint32_t xk)              \
+{                                                                     \
+    int i, max;                                                       \
+    XReg *Xd = &(env->fpr[xd].xreg);                                  \
+    XReg *Xj = &(env->fpr[xj].xreg);                                  \
+    XReg *Xk = &(env->fpr[xk].xreg);                                  \
+                                                                      \
+    max = LASX_LEN / (BIT * 2);                                       \
+    for (i = 0; i < max; i++) {                                       \
+        Xd->E1(i) = do_xvsrlr_ ## E2(Xj->E2(i), (Xk->E3(i)) % BIT);   \
+        Xd->E1(i + max * 2) = do_xvsrlr_## E2(Xj->E2(i + max),        \
+                                              Xk->E3(i + max) % BIT); \
+    }                                                                 \
+    Xd->XD(1) = 0;                                                    \
+    Xd->XD(3) = 0;                                                    \
+}
+
+XVSRLRN(xvsrlrn_b_h, 16, XB, XH, UXH)
+XVSRLRN(xvsrlrn_h_w, 32, XH, XW, UXW)
+XVSRLRN(xvsrlrn_w_d, 64, XW, XD, UXD)
+
+#define XVSRARN(NAME, BIT, E1, E2, E3)                                \
+void HELPER(NAME)(CPULoongArchState *env,                             \
+                  uint32_t xd, uint32_t xj, uint32_t xk)              \
+{                                                                     \
+    int i, max;                                                       \
+    XReg *Xd = &(env->fpr[xd].xreg);                                  \
+    XReg *Xj = &(env->fpr[xj].xreg);                                  \
+    XReg *Xk = &(env->fpr[xk].xreg);                                  \
+                                                                      \
+    max = LASX_LEN / (BIT * 2);                                       \
+    for (i = 0; i < max; i++) {                                       \
+        Xd->E1(i) = do_xvsrar_ ## E2(Xj->E2(i), (Xk->E3(i)) % BIT);   \
+        Xd->E1(i + max * 2) = do_xvsrar_## E2(Xj->E2(i + max),        \
+                                              Xk->E3(i + max) % BIT); \
+    }                                                                 \
+    Xd->XD(1) = 0;                                                    \
+    Xd->XD(3) = 0;                                                    \
+}
+
+XVSRARN(xvsrarn_b_h, 16, XB, XH, UXH)
+XVSRARN(xvsrarn_h_w, 32, XH, XW, UXW)
+XVSRARN(xvsrarn_w_d, 64, XW, XD, UXD)
+
+#define XVSRLRNI(NAME, BIT, E1, E2)                                   \
+void HELPER(NAME)(CPULoongArchState *env,                             \
+                  uint32_t xd, uint32_t xj, uint32_t imm)             \
+{                                                                     \
+    int i, max;                                                       \
+    XReg temp;                                                        \
+    XReg *Xd = &(env->fpr[xd].xreg);                                  \
+    XReg *Xj = &(env->fpr[xj].xreg);                                  \
+                                                                      \
+    temp.XQ(0) = int128_zero();                                       \
+    temp.XQ(1) = int128_zero();                                       \
+    max = LASX_LEN / (BIT * 2);                                       \
+    for (i = 0; i < max; i++) {                                       \
+        temp.E1(i) = do_xvsrlr_ ## E2(Xj->E2(i), imm);                \
+        temp.E1(i + max) = do_xvsrlr_ ## E2(Xd->E2(i), imm);          \
+        temp.E1(i + max * 2) = do_xvsrlr_## E2(Xj->E2(i + max), imm); \
+        temp.E1(i + max * 3) = do_xvsrlr_## E2(Xd->E2(i + max), imm); \
+    }                                                                 \
+    *Xd = temp;                                                       \
+}
+
+void HELPER(xvsrlrni_d_q)(CPULoongArchState *env,
+                          uint32_t xd, uint32_t xj, uint32_t imm)
+{
+    XReg temp;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+    Int128 r1, r2, r3, r4;
+
+    if (imm == 0) {
+        temp.XD(0) = int128_getlo(Xj->XQ(0));
+        temp.XD(1) = int128_getlo(Xd->XQ(0));
+        temp.XD(2) = int128_getlo(Xj->XQ(1));
+        temp.XD(3) = int128_getlo(Xd->XQ(1));
+    } else {
+        r1 = int128_and(int128_urshift(Xj->XQ(0), (imm - 1)), int128_one());
+        r2 = int128_and(int128_urshift(Xd->XQ(0), (imm - 1)), int128_one());
+        r3 = int128_and(int128_urshift(Xj->XQ(1), (imm - 1)), int128_one());
+        r4 = int128_and(int128_urshift(Xd->XQ(1), (imm - 1)), int128_one());
+
+       temp.XD(0) = int128_getlo(int128_add(int128_urshift(Xj->XQ(0), imm), r1));
+       temp.XD(1) = int128_getlo(int128_add(int128_urshift(Xd->XQ(0), imm), r2));
+       temp.XD(2) = int128_getlo(int128_add(int128_urshift(Xj->XQ(1), imm), r3));
+       temp.XD(3) = int128_getlo(int128_add(int128_urshift(Xd->XQ(1), imm), r4));
+    }
+    *Xd = temp;
+}
+
+XVSRLRNI(xvsrlrni_b_h, 16, XB, XH)
+XVSRLRNI(xvsrlrni_h_w, 32, XH, XW)
+XVSRLRNI(xvsrlrni_w_d, 64, XW, XD)
+
+#define XVSRARNI(NAME, BIT, E1, E2)                                   \
+void HELPER(NAME)(CPULoongArchState *env,                             \
+                  uint32_t xd, uint32_t xj, uint32_t imm)             \
+{                                                                     \
+    int i, max;                                                       \
+    XReg temp;                                                        \
+    XReg *Xd = &(env->fpr[xd].xreg);                                  \
+    XReg *Xj = &(env->fpr[xj].xreg);                                  \
+                                                                      \
+    temp.XQ(0) = int128_zero();                                       \
+    temp.XQ(1) = int128_zero();                                       \
+    max = LASX_LEN / (BIT * 2);                                       \
+    for (i = 0; i < max; i++) {                                       \
+        temp.E1(i) = do_xvsrar_ ## E2(Xj->E2(i), imm);                \
+        temp.E1(i + max) = do_xvsrar_ ## E2(Xd->E2(i), imm);          \
+        temp.E1(i + max * 2) = do_xvsrar_## E2(Xj->E2(i + max), imm); \
+        temp.E1(i + max * 3) = do_xvsrar_## E2(Xd->E2(i + max), imm); \
+    }                                                                 \
+    *Xd = temp;                                                       \
+}
+
+void HELPER(xvsrarni_d_q)(CPULoongArchState *env,
+                          uint32_t xd, uint32_t xj, uint32_t imm)
+{
+    XReg temp;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+    Int128 r1, r2, r3, r4;
+
+    if (imm == 0) {
+        temp.XD(0) = int128_getlo(Xj->XQ(0));
+        temp.XD(1) = int128_getlo(Xd->XQ(0));
+        temp.XD(2) = int128_getlo(Xj->XQ(1));
+        temp.XD(3) = int128_getlo(Xd->XQ(1));
+    } else {
+        r1 = int128_and(int128_rshift(Xj->XQ(0), (imm - 1)), int128_one());
+        r2 = int128_and(int128_rshift(Xd->XQ(0), (imm - 1)), int128_one());
+        r3 = int128_and(int128_rshift(Xj->XQ(1), (imm - 1)), int128_one());
+        r4 = int128_and(int128_rshift(Xd->XQ(1), (imm - 1)), int128_one());
+
+       temp.XD(0) = int128_getlo(int128_add(int128_rshift(Xj->XQ(0), imm), r1));
+       temp.XD(1) = int128_getlo(int128_add(int128_rshift(Xd->XQ(0), imm), r2));
+       temp.XD(2) = int128_getlo(int128_add(int128_rshift(Xj->XQ(1), imm), r3));
+       temp.XD(3) = int128_getlo(int128_add(int128_rshift(Xd->XQ(1), imm), r4));
+    }
+    *Xd = temp;
+}
+
+XVSRARNI(xvsrarni_b_h, 16, XB, XH)
+XVSRARNI(xvsrarni_h_w, 32, XH, XW)
+XVSRARNI(xvsrarni_w_d, 64, XW, XD)
-- 
2.39.1


