Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB57736830
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:44:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXqX-0002uC-Cp; Tue, 20 Jun 2023 05:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXqQ-0002hK-3t
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:40:14 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXqM-0006aH-I9
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:40:13 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxKuqXc5FkxCUHAA--.14734S3;
 Tue, 20 Jun 2023 17:38:31 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S30; 
 Tue, 20 Jun 2023 17:38:30 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 28/46] target/loongarch: Implement xvsrln xvsran
Date: Tue, 20 Jun 2023 17:37:56 +0800
Message-Id: <20230620093814.123650-29-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S30
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
- XVSRLN.{B.H/H.W/W.D};
- XVSRAN.{B.H/H.W/W.D};
- XVSRLNI.{B.H/H.W/W.D/D.Q};
- XVSRANI.{B.H/H.W/W.D/D.Q}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  16 +++
 target/loongarch/helper.h                    |  16 +++
 target/loongarch/insn_trans/trans_lasx.c.inc |  16 +++
 target/loongarch/insns.decode                |  17 +++
 target/loongarch/lasx_helper.c               | 128 +++++++++++++++++++
 target/loongarch/lsx_helper.c                |   2 -
 target/loongarch/vec.h                       |   2 +
 7 files changed, 195 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index a63ba6d6ee..5ea713075f 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2103,6 +2103,22 @@ INSN_LASX(xvsrari_h,         xx_i)
 INSN_LASX(xvsrari_w,         xx_i)
 INSN_LASX(xvsrari_d,         xx_i)
 
+INSN_LASX(xvsrln_b_h,        xxx)
+INSN_LASX(xvsrln_h_w,        xxx)
+INSN_LASX(xvsrln_w_d,        xxx)
+INSN_LASX(xvsran_b_h,        xxx)
+INSN_LASX(xvsran_h_w,        xxx)
+INSN_LASX(xvsran_w_d,        xxx)
+
+INSN_LASX(xvsrlni_b_h,       xx_i)
+INSN_LASX(xvsrlni_h_w,       xx_i)
+INSN_LASX(xvsrlni_w_d,       xx_i)
+INSN_LASX(xvsrlni_d_q,       xx_i)
+INSN_LASX(xvsrani_b_h,       xx_i)
+INSN_LASX(xvsrani_h_w,       xx_i)
+INSN_LASX(xvsrani_w_d,       xx_i)
+INSN_LASX(xvsrani_d_q,       xx_i)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 6bb30ddd31..c41f8e2bc9 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -958,3 +958,19 @@ DEF_HELPER_4(xvsrari_b, void, env, i32, i32, i32)
 DEF_HELPER_4(xvsrari_h, void, env, i32, i32, i32)
 DEF_HELPER_4(xvsrari_w, void, env, i32, i32, i32)
 DEF_HELPER_4(xvsrari_d, void, env, i32, i32, i32)
+
+DEF_HELPER_4(xvsrln_b_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrln_h_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrln_w_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsran_b_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsran_h_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsran_w_d, void, env, i32, i32, i32)
+
+DEF_HELPER_4(xvsrlni_b_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrlni_h_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrlni_w_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrlni_d_q, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrani_b_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrani_h_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrani_w_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvsrani_d_q, void, env, i32, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 602ba0c800..9a3c2114eb 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -2052,6 +2052,22 @@ TRANS(xvsrari_h, gen_xx_i, gen_helper_xvsrari_h)
 TRANS(xvsrari_w, gen_xx_i, gen_helper_xvsrari_w)
 TRANS(xvsrari_d, gen_xx_i, gen_helper_xvsrari_d)
 
+TRANS(xvsrln_b_h, gen_xxx, gen_helper_xvsrln_b_h)
+TRANS(xvsrln_h_w, gen_xxx, gen_helper_xvsrln_h_w)
+TRANS(xvsrln_w_d, gen_xxx, gen_helper_xvsrln_w_d)
+TRANS(xvsran_b_h, gen_xxx, gen_helper_xvsran_b_h)
+TRANS(xvsran_h_w, gen_xxx, gen_helper_xvsran_h_w)
+TRANS(xvsran_w_d, gen_xxx, gen_helper_xvsran_w_d)
+
+TRANS(xvsrlni_b_h, gen_xx_i, gen_helper_xvsrlni_b_h)
+TRANS(xvsrlni_h_w, gen_xx_i, gen_helper_xvsrlni_h_w)
+TRANS(xvsrlni_w_d, gen_xx_i, gen_helper_xvsrlni_w_d)
+TRANS(xvsrlni_d_q, gen_xx_i, gen_helper_xvsrlni_d_q)
+TRANS(xvsrani_b_h, gen_xx_i, gen_helper_xvsrani_b_h)
+TRANS(xvsrani_h_w, gen_xx_i, gen_helper_xvsrani_h_w)
+TRANS(xvsrani_w_d, gen_xx_i, gen_helper_xvsrani_w_d)
+TRANS(xvsrani_d_q, gen_xx_i, gen_helper_xvsrani_d_q)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index d901ddf063..45f15e3be2 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1320,6 +1320,7 @@ vstelm_b         0011 000110 .... ........ ..... .....    @vr_i8i4
 @xx_ui4          .... ........ ..... . imm:4 xj:5 xd:5    &xx_i
 @xx_ui5            .... ........ ..... imm:5 xj:5 xd:5    &xx_i
 @xx_ui6             .... ........ .... imm:6 xj:5 xd:5    &xx_i
+@xx_ui7              .... ........ ... imm:7 xj:5 xd:5    &xx_i
 @xx_ui8               .... ........ .. imm:8 xj:5 xd:5    &xx_i
 
 xvadd_b          0111 01000000 10100 ..... ..... .....    @xxx
@@ -1700,6 +1701,22 @@ xvsrari_h        0111 01101010 10000 1 .... ..... .....   @xx_ui4
 xvsrari_w        0111 01101010 10001 ..... ..... .....    @xx_ui5
 xvsrari_d        0111 01101010 1001 ...... ..... .....    @xx_ui6
 
+xvsrln_b_h       0111 01001111 01001 ..... ..... .....    @xxx
+xvsrln_h_w       0111 01001111 01010 ..... ..... .....    @xxx
+xvsrln_w_d       0111 01001111 01011 ..... ..... .....    @xxx
+xvsran_b_h       0111 01001111 01101 ..... ..... .....    @xxx
+xvsran_h_w       0111 01001111 01110 ..... ..... .....    @xxx
+xvsran_w_d       0111 01001111 01111 ..... ..... .....    @xxx
+
+xvsrlni_b_h      0111 01110100 00000 1 .... ..... .....   @xx_ui4
+xvsrlni_h_w      0111 01110100 00001 ..... ..... .....    @xx_ui5
+xvsrlni_w_d      0111 01110100 0001 ...... ..... .....    @xx_ui6
+xvsrlni_d_q      0111 01110100 001 ....... ..... .....    @xx_ui7
+xvsrani_b_h      0111 01110101 10000 1 .... ..... .....   @xx_ui4
+xvsrani_h_w      0111 01110101 10001 ..... ..... .....    @xx_ui5
+xvsrani_w_d      0111 01110101 1001 ...... ..... .....    @xx_ui6
+xvsrani_d_q      0111 01110101 101 ....... ..... .....    @xx_ui7
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index ebbbf014f7..02550646d7 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -964,3 +964,131 @@ XVSRARI(xvsrari_b, 8, XB)
 XVSRARI(xvsrari_h, 16, XH)
 XVSRARI(xvsrari_w, 32, XW)
 XVSRARI(xvsrari_d, 64, XD)
+
+#define XVSRLN(NAME, BIT, E1, E2)                             \
+void HELPER(NAME)(CPULoongArchState *env,                     \
+                  uint32_t xd, uint32_t xj, uint32_t xk)      \
+{                                                             \
+    int i, max;                                               \
+    XReg *Xd = &(env->fpr[xd].xreg);                          \
+    XReg *Xj = &(env->fpr[xj].xreg);                          \
+    XReg *Xk = &(env->fpr[xk].xreg);                          \
+                                                              \
+    max = LASX_LEN / (BIT * 2);                               \
+    for (i = 0; i < max; i++) {                               \
+        Xd->E1(i) = R_SHIFT(Xj->E2(i), (Xk->E2(i)) % BIT);    \
+        Xd->E1(i + max * 2) = R_SHIFT(Xj->E2(i + max),        \
+                                      Xk->E2(i + max) % BIT); \
+    }                                                         \
+    Xd->XD(1) = 0;                                            \
+    Xd->XD(3) = 0;                                            \
+}
+
+XVSRLN(xvsrln_b_h, 16, XB, UXH)
+XVSRLN(xvsrln_h_w, 32, XH, UXW)
+XVSRLN(xvsrln_w_d, 64, XW, UXD)
+
+#define XVSRAN(NAME, BIT, E1, E2, E3)                         \
+void HELPER(NAME)(CPULoongArchState *env,                     \
+                  uint32_t xd, uint32_t xj, uint32_t xk)      \
+{                                                             \
+    int i, max;                                               \
+    XReg *Xd = &(env->fpr[xd].xreg);                          \
+    XReg *Xj = &(env->fpr[xj].xreg);                          \
+    XReg *Xk = &(env->fpr[xk].xreg);                          \
+                                                              \
+    max = LASX_LEN / (BIT * 2);                               \
+    for (i = 0; i < max; i++) {                               \
+        Xd->E1(i) = R_SHIFT(Xj->E2(i), (Xk->E3(i)) % BIT);    \
+        Xd->E1(i + max * 2) = R_SHIFT(Xj->E2(i + max),        \
+                                      Xk->E3(i + max) % BIT); \
+    }                                                         \
+    Xd->XD(1) = 0;                                            \
+    Xd->XD(3) = 0;                                            \
+}
+
+XVSRAN(xvsran_b_h, 16, XB, XH, UXH)
+XVSRAN(xvsran_h_w, 32, XH, XW, UXW)
+XVSRAN(xvsran_w_d, 64, XW, XD, UXD)
+
+#define XVSRLNI(NAME, BIT, E1, E2)                            \
+void HELPER(NAME)(CPULoongArchState *env,                     \
+                  uint32_t xd, uint32_t xj, uint32_t imm)     \
+{                                                             \
+    int i, max;                                               \
+    XReg temp;                                                \
+    XReg *Xd = &(env->fpr[xd].xreg);                          \
+    XReg *Xj = &(env->fpr[xj].xreg);                          \
+                                                              \
+    temp.XQ(0) = int128_zero();                               \
+    temp.XQ(1) = int128_zero();                               \
+    max = LASX_LEN / (BIT * 2);                               \
+    for (i = 0; i < max; i++) {                               \
+        temp.E1(i) = R_SHIFT(Xj->E2(i), imm);                 \
+        temp.E1(i + max) = R_SHIFT(Xd->E2(i), imm);           \
+        temp.E1(i + max * 2) = R_SHIFT(Xj->E2(i + max), imm); \
+        temp.E1(i + max * 3) = R_SHIFT(Xd->E2(i + max), imm); \
+    }                                                         \
+    *Xd = temp;                                               \
+}
+
+void HELPER(xvsrlni_d_q)(CPULoongArchState *env,
+                         uint32_t xd, uint32_t xj, uint32_t imm)
+{
+    XReg temp;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    temp.XQ(0) = int128_zero();
+    temp.XQ(1) = int128_zero();
+    temp.XD(0) = int128_getlo(int128_urshift(Xj->XQ(0), imm % 128));
+    temp.XD(1) = int128_getlo(int128_urshift(Xd->XQ(0), imm % 128));
+    temp.XD(2) = int128_getlo(int128_urshift(Xj->XQ(1), imm % 128));
+    temp.XD(3) = int128_getlo(int128_urshift(Xd->XQ(1), imm % 128));
+    *Xd = temp;
+}
+
+XVSRLNI(xvsrlni_b_h, 16, XB, UXH)
+XVSRLNI(xvsrlni_h_w, 32, XH, UXW)
+XVSRLNI(xvsrlni_w_d, 64, XW, UXD)
+
+#define XVSRANI(NAME, BIT, E1, E2)                            \
+void HELPER(NAME)(CPULoongArchState *env,                     \
+                  uint32_t xd, uint32_t xj, uint32_t imm)     \
+{                                                             \
+    int i, max;                                               \
+    XReg temp;                                                \
+    XReg *Xd = &(env->fpr[xd].xreg);                          \
+    XReg *Xj = &(env->fpr[xj].xreg);                          \
+                                                              \
+    temp.XQ(0) = int128_zero();                               \
+    temp.XQ(1) = int128_zero();                               \
+    max = LASX_LEN / (BIT * 2);                               \
+    for (i = 0; i < max; i++) {                               \
+        temp.E1(i) = R_SHIFT(Xj->E2(i), imm);                 \
+        temp.E1(i + max) = R_SHIFT(Xd->E2(i), imm);           \
+        temp.E1(i + max * 2) = R_SHIFT(Xj->E2(i + max), imm); \
+        temp.E1(i + max * 3) = R_SHIFT(Xd->E2(i + max), imm); \
+    }                                                         \
+    *Xd = temp;                                               \
+}
+
+void HELPER(xvsrani_d_q)(CPULoongArchState *env,
+                         uint32_t xd, uint32_t xj, uint32_t imm)
+{
+    XReg temp;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    temp.XQ(0) = int128_zero();
+    temp.XQ(1) = int128_zero();
+    temp.XD(0) = int128_getlo(int128_rshift(Xj->XQ(0), imm % 128));
+    temp.XD(1) = int128_getlo(int128_rshift(Xd->XQ(0), imm % 128));
+    temp.XD(2) = int128_getlo(int128_rshift(Xj->XQ(1), imm % 128));
+    temp.XD(3) = int128_getlo(int128_rshift(Xd->XQ(1), imm % 128));
+    *Xd = temp;
+}
+
+XVSRANI(xvsrani_b_h, 16, XB, XH)
+XVSRANI(xvsrani_h_w, 32, XH, XW)
+XVSRANI(xvsrani_w_d, 64, XW, XD)
diff --git a/target/loongarch/lsx_helper.c b/target/loongarch/lsx_helper.c
index e64155f38c..d21e4006f2 100644
--- a/target/loongarch/lsx_helper.c
+++ b/target/loongarch/lsx_helper.c
@@ -922,8 +922,6 @@ VSRARI(vsrari_h, 16, H)
 VSRARI(vsrari_w, 32, W)
 VSRARI(vsrari_d, 64, D)
 
-#define R_SHIFT(a, b) (a >> b)
-
 #define VSRLN(NAME, BIT, T, E1, E2)                             \
 void HELPER(NAME)(CPULoongArchState *env,                       \
                   uint32_t vd, uint32_t vj, uint32_t vk)        \
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index d5a880b3fd..b5cdb4b470 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -75,6 +75,8 @@
 
 #define DO_SIGNCOV(a, b)  (a == 0 ? 0 : a < 0 ? -b : b)
 
+#define R_SHIFT(a, b) (a >> b)
+
 uint64_t do_vmskltz_b(int64_t val);
 uint64_t do_vmskltz_h(int64_t val);
 uint64_t do_vmskltz_w(int64_t val);
-- 
2.39.1


