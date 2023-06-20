Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 708FC736813
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:43:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXpQ-0007Cu-8y; Tue, 20 Jun 2023 05:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXp5-0007BF-Gf
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:51 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXp1-0006Nu-7g
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:51 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx+emZc5FkyiUHAA--.14781S3;
 Tue, 20 Jun 2023 17:38:33 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S33; 
 Tue, 20 Jun 2023 17:38:33 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 31/46] target/loongarch: Implement xvssrlrn xvssrarn
Date: Tue, 20 Jun 2023 17:37:59 +0800
Message-Id: <20230620093814.123650-32-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S33
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
- XVSSRLRN.{B.H/H.W/W.D};
- XVSSRARN.{B.H/H.W/W.D};
- XVSSRLRN.{BU.H/HU.W/WU.D};
- XVSSRARN.{BU.H/HU.W/WU.D};
- XVSSRLRNI.{B.H/H.W/W.D/D.Q};
- XVSSRARNI.{B.H/H.W/W.D/D.Q};
- XVSSRLRNI.{BU.H/HU.W/WU.D/DU.Q};
- XVSSRARNI.{BU.H/HU.W/WU.D/DU.Q}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  30 ++
 target/loongarch/helper.h                    |  30 ++
 target/loongarch/insn_trans/trans_lasx.c.inc |  30 ++
 target/loongarch/insns.decode                |  30 ++
 target/loongarch/lasx_helper.c               | 411 +++++++++++++++++++
 5 files changed, 531 insertions(+)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 1f40f3aaca..da07b56dee 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2165,6 +2165,36 @@ INSN_LASX(xvssrani_hu_w,     xx_i)
 INSN_LASX(xvssrani_wu_d,     xx_i)
 INSN_LASX(xvssrani_du_q,     xx_i)
 
+INSN_LASX(xvssrlrn_b_h,      xxx)
+INSN_LASX(xvssrlrn_h_w,      xxx)
+INSN_LASX(xvssrlrn_w_d,      xxx)
+INSN_LASX(xvssrarn_b_h,      xxx)
+INSN_LASX(xvssrarn_h_w,      xxx)
+INSN_LASX(xvssrarn_w_d,      xxx)
+INSN_LASX(xvssrlrn_bu_h,     xxx)
+INSN_LASX(xvssrlrn_hu_w,     xxx)
+INSN_LASX(xvssrlrn_wu_d,     xxx)
+INSN_LASX(xvssrarn_bu_h,     xxx)
+INSN_LASX(xvssrarn_hu_w,     xxx)
+INSN_LASX(xvssrarn_wu_d,     xxx)
+
+INSN_LASX(xvssrlrni_b_h,     xx_i)
+INSN_LASX(xvssrlrni_h_w,     xx_i)
+INSN_LASX(xvssrlrni_w_d,     xx_i)
+INSN_LASX(xvssrlrni_d_q,     xx_i)
+INSN_LASX(xvssrlrni_bu_h,    xx_i)
+INSN_LASX(xvssrlrni_hu_w,    xx_i)
+INSN_LASX(xvssrlrni_wu_d,    xx_i)
+INSN_LASX(xvssrlrni_du_q,    xx_i)
+INSN_LASX(xvssrarni_b_h,     xx_i)
+INSN_LASX(xvssrarni_h_w,     xx_i)
+INSN_LASX(xvssrarni_w_d,     xx_i)
+INSN_LASX(xvssrarni_d_q,     xx_i)
+INSN_LASX(xvssrarni_bu_h,    xx_i)
+INSN_LASX(xvssrarni_hu_w,    xx_i)
+INSN_LASX(xvssrarni_wu_d,    xx_i)
+INSN_LASX(xvssrarni_du_q,    xx_i)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 2d76916049..b5d1cff1f0 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -1020,3 +1020,33 @@ DEF_HELPER_4(xvssrani_bu_h, void, env, i32, i32, i32)
 DEF_HELPER_4(xvssrani_hu_w, void, env, i32, i32, i32)
 DEF_HELPER_4(xvssrani_wu_d, void, env, i32, i32, i32)
 DEF_HELPER_4(xvssrani_du_q, void, env, i32, i32, i32)
+
+DEF_HELPER_4(xvssrlrn_b_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrlrn_h_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrlrn_w_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrarn_b_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrarn_h_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrarn_w_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrlrn_bu_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrlrn_hu_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrlrn_wu_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrarn_bu_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrarn_hu_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrarn_wu_d, void, env, i32, i32, i32)
+
+DEF_HELPER_4(xvssrlrni_b_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrlrni_h_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrlrni_w_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrlrni_d_q, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrarni_b_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrarni_h_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrarni_w_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrarni_d_q, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrlrni_bu_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrlrni_hu_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrlrni_wu_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrlrni_du_q, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrarni_bu_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrarni_hu_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrarni_wu_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrarni_du_q, void, env, i32, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index b6c2ced30c..aa145c850b 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -2114,6 +2114,36 @@ TRANS(xvssrani_hu_w, gen_xx_i, gen_helper_xvssrani_hu_w)
 TRANS(xvssrani_wu_d, gen_xx_i, gen_helper_xvssrani_wu_d)
 TRANS(xvssrani_du_q, gen_xx_i, gen_helper_xvssrani_du_q)
 
+TRANS(xvssrlrn_b_h, gen_xxx, gen_helper_xvssrlrn_b_h)
+TRANS(xvssrlrn_h_w, gen_xxx, gen_helper_xvssrlrn_h_w)
+TRANS(xvssrlrn_w_d, gen_xxx, gen_helper_xvssrlrn_w_d)
+TRANS(xvssrarn_b_h, gen_xxx, gen_helper_xvssrarn_b_h)
+TRANS(xvssrarn_h_w, gen_xxx, gen_helper_xvssrarn_h_w)
+TRANS(xvssrarn_w_d, gen_xxx, gen_helper_xvssrarn_w_d)
+TRANS(xvssrlrn_bu_h, gen_xxx, gen_helper_xvssrlrn_bu_h)
+TRANS(xvssrlrn_hu_w, gen_xxx, gen_helper_xvssrlrn_hu_w)
+TRANS(xvssrlrn_wu_d, gen_xxx, gen_helper_xvssrlrn_wu_d)
+TRANS(xvssrarn_bu_h, gen_xxx, gen_helper_xvssrarn_bu_h)
+TRANS(xvssrarn_hu_w, gen_xxx, gen_helper_xvssrarn_hu_w)
+TRANS(xvssrarn_wu_d, gen_xxx, gen_helper_xvssrarn_wu_d)
+
+TRANS(xvssrlrni_b_h, gen_xx_i, gen_helper_xvssrlrni_b_h)
+TRANS(xvssrlrni_h_w, gen_xx_i, gen_helper_xvssrlrni_h_w)
+TRANS(xvssrlrni_w_d, gen_xx_i, gen_helper_xvssrlrni_w_d)
+TRANS(xvssrlrni_d_q, gen_xx_i, gen_helper_xvssrlrni_d_q)
+TRANS(xvssrarni_b_h, gen_xx_i, gen_helper_xvssrarni_b_h)
+TRANS(xvssrarni_h_w, gen_xx_i, gen_helper_xvssrarni_h_w)
+TRANS(xvssrarni_w_d, gen_xx_i, gen_helper_xvssrarni_w_d)
+TRANS(xvssrarni_d_q, gen_xx_i, gen_helper_xvssrarni_d_q)
+TRANS(xvssrlrni_bu_h, gen_xx_i, gen_helper_xvssrlrni_bu_h)
+TRANS(xvssrlrni_hu_w, gen_xx_i, gen_helper_xvssrlrni_hu_w)
+TRANS(xvssrlrni_wu_d, gen_xx_i, gen_helper_xvssrlrni_wu_d)
+TRANS(xvssrlrni_du_q, gen_xx_i, gen_helper_xvssrlrni_du_q)
+TRANS(xvssrarni_bu_h, gen_xx_i, gen_helper_xvssrarni_bu_h)
+TRANS(xvssrarni_hu_w, gen_xx_i, gen_helper_xvssrarni_hu_w)
+TRANS(xvssrarni_wu_d, gen_xx_i, gen_helper_xvssrarni_wu_d)
+TRANS(xvssrarni_du_q, gen_xx_i, gen_helper_xvssrarni_du_q)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index cf3803c230..3aed69b766 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1763,6 +1763,36 @@ xvssrani_hu_w    0111 01110110 01001 ..... ..... .....    @xx_ui5
 xvssrani_wu_d    0111 01110110 0101 ...... ..... .....    @xx_ui6
 xvssrani_du_q    0111 01110110 011 ....... ..... .....    @xx_ui7
 
+xvssrlrn_b_h     0111 01010000 00001 ..... ..... .....    @xxx
+xvssrlrn_h_w     0111 01010000 00010 ..... ..... .....    @xxx
+xvssrlrn_w_d     0111 01010000 00011 ..... ..... .....    @xxx
+xvssrarn_b_h     0111 01010000 00101 ..... ..... .....    @xxx
+xvssrarn_h_w     0111 01010000 00110 ..... ..... .....    @xxx
+xvssrarn_w_d     0111 01010000 00111 ..... ..... .....    @xxx
+xvssrlrn_bu_h    0111 01010000 10001 ..... ..... .....    @xxx
+xvssrlrn_hu_w    0111 01010000 10010 ..... ..... .....    @xxx
+xvssrlrn_wu_d    0111 01010000 10011 ..... ..... .....    @xxx
+xvssrarn_bu_h    0111 01010000 10101 ..... ..... .....    @xxx
+xvssrarn_hu_w    0111 01010000 10110 ..... ..... .....    @xxx
+xvssrarn_wu_d    0111 01010000 10111 ..... ..... .....    @xxx
+
+xvssrlrni_b_h    0111 01110101 00000 1 .... ..... .....   @xx_ui4
+xvssrlrni_h_w    0111 01110101 00001 ..... ..... .....    @xx_ui5
+xvssrlrni_w_d    0111 01110101 0001 ...... ..... .....    @xx_ui6
+xvssrlrni_d_q    0111 01110101 001 ....... ..... .....    @xx_ui7
+xvssrarni_b_h    0111 01110110 10000 1 .... ..... .....   @xx_ui4
+xvssrarni_h_w    0111 01110110 10001 ..... ..... .....    @xx_ui5
+xvssrarni_w_d    0111 01110110 1001 ...... ..... .....    @xx_ui6
+xvssrarni_d_q    0111 01110110 101 ....... ..... .....    @xx_ui7
+xvssrlrni_bu_h   0111 01110101 01000 1 .... ..... .....   @xx_ui4
+xvssrlrni_hu_w   0111 01110101 01001 ..... ..... .....    @xx_ui5
+xvssrlrni_wu_d   0111 01110101 0101 ...... ..... .....    @xx_ui6
+xvssrlrni_du_q   0111 01110101 011 ....... ..... .....    @xx_ui7
+xvssrarni_bu_h   0111 01110110 11000 1 .... ..... .....   @xx_ui4
+xvssrarni_hu_w   0111 01110110 11001 ..... ..... .....    @xx_ui5
+xvssrarni_wu_d   0111 01110110 1101 ...... ..... .....    @xx_ui6
+xvssrarni_du_q   0111 01110110 111 ....... ..... .....    @xx_ui7
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index b42f412c02..0e223601de 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -1670,3 +1670,414 @@ void HELPER(xvssrani_du_q)(CPULoongArchState *env,
 XVSSRANUI(xvssrani_bu_h, 16, XB, XH)
 XVSSRANUI(xvssrani_hu_w, 32, XH, XW)
 XVSSRANUI(xvssrani_wu_d, 64, XW, XD)
+
+#define XSSRLRNS(E1, E2, T1, T2, T3)                \
+static T1 do_xssrlrns_ ## E1(T2 e2, int sa, int sh) \
+{                                                   \
+    T1 shft_res;                                    \
+                                                    \
+    shft_res = do_xvsrlr_ ## E2(e2, sa);            \
+    T1 mask;                                        \
+    mask = (1ull << sh) - 1;                        \
+    if (shft_res > mask) {                          \
+        return mask;                                \
+    } else {                                        \
+        return  shft_res;                           \
+    }                                               \
+}
+
+XSSRLRNS(XB, XH, uint16_t, int16_t, uint8_t)
+XSSRLRNS(XH, XW, uint32_t, int32_t, uint16_t)
+XSSRLRNS(XW, XD, uint64_t, int64_t, uint32_t)
+
+#define XVSSRLRN(NAME, BIT, E1, E2, E3)                                 \
+void HELPER(NAME)(CPULoongArchState *env,                               \
+                  uint32_t xd, uint32_t xj, uint32_t xk)                \
+{                                                                       \
+    int i, max;                                                         \
+    XReg *Xd = &(env->fpr[xd].xreg);                                    \
+    XReg *Xj = &(env->fpr[xj].xreg);                                    \
+    XReg *Xk = &(env->fpr[xk].xreg);                                    \
+                                                                        \
+    max = LASX_LEN / (BIT * 2);                                         \
+    for (i = 0; i < max; i++) {                                         \
+        Xd->E1(i) = do_xssrlrns_ ## E1(Xj->E2(i),                       \
+                                       Xk->E3(i) % BIT, (BIT / 2) - 1); \
+        Xd->E1(i + max * 2) = do_xssrlrns_## E1(Xj->E2(i + max),        \
+                                                Xk->E3(i + max) % BIT,  \
+                                                (BIT / 2) - 1);         \
+    }                                                                   \
+    Xd->XD(1) = 0;                                                      \
+    Xd->XD(3) = 0;                                                      \
+}
+
+XVSSRLRN(xvssrlrn_b_h, 16, XB, XH, UXH)
+XVSSRLRN(xvssrlrn_h_w, 32, XH, XW, UXW)
+XVSSRLRN(xvssrlrn_w_d, 64, XW, XD, UXD)
+
+#define XSSRARNS(E1, E2, T1, T2)                    \
+static T1 do_xssrarns_ ## E1(T1 e2, int sa, int sh) \
+{                                                   \
+    T1 shft_res;                                    \
+                                                    \
+    shft_res = do_xvsrar_ ## E2(e2, sa);            \
+    T2 mask;                                        \
+    mask = (1ll << sh) - 1;                         \
+    if (shft_res > mask) {                          \
+        return  mask;                               \
+    } else if (shft_res < -(mask + 1)) {            \
+        return  ~mask;                              \
+    } else {                                        \
+        return shft_res;                            \
+    }                                               \
+}
+
+XSSRARNS(XB, XH, int16_t, int8_t)
+XSSRARNS(XH, XW, int32_t, int16_t)
+XSSRARNS(XW, XD, int64_t, int32_t)
+
+#define XVSSRARN(NAME, BIT, E1, E2, E3)                                 \
+void HELPER(NAME)(CPULoongArchState *env,                               \
+                  uint32_t xd, uint32_t xj, uint32_t xk)                \
+{                                                                       \
+    int i, max;                                                         \
+    XReg *Xd = &(env->fpr[xd].xreg);                                    \
+    XReg *Xj = &(env->fpr[xj].xreg);                                    \
+    XReg *Xk = &(env->fpr[xk].xreg);                                    \
+                                                                        \
+    max = LASX_LEN / (BIT * 2);                                         \
+    for (i = 0; i < max; i++) {                                         \
+        Xd->E1(i) = do_xssrarns_ ## E1(Xj->E2(i),                       \
+                                       Xk->E3(i) % BIT, (BIT / 2) - 1); \
+        Xd->E1(i + max * 2) = do_xssrarns_## E1(Xj->E2(i + max),        \
+                                                Xk->E3(i + max) % BIT,  \
+                                                (BIT / 2) - 1);         \
+    }                                                                   \
+    Xd->XD(1) = 0;                                                      \
+    Xd->XD(3) = 0;                                                      \
+}
+
+XVSSRARN(xvssrarn_b_h, 16, XB, XH, UXH)
+XVSSRARN(xvssrarn_h_w, 32, XH, XW, UXW)
+XVSSRARN(xvssrarn_w_d, 64, XW, XD, UXD)
+
+#define XSSRLRNU(E1, E2, T1, T2, T3)                \
+static T1 do_xssrlrnu_ ## E1(T3 e2, int sa, int sh) \
+{                                                   \
+    T1 shft_res;                                    \
+                                                    \
+    shft_res = do_xvsrlr_ ## E2(e2, sa);            \
+                                                    \
+    T2 mask;                                        \
+    mask = (1ull << sh) - 1;                        \
+    if (shft_res > mask) {                          \
+        return mask;                                \
+    } else {                                        \
+        return shft_res;                            \
+    }                                               \
+}
+
+XSSRLRNU(XB, XH, uint16_t, uint8_t, int16_t)
+XSSRLRNU(XH, XW, uint32_t, uint16_t, int32_t)
+XSSRLRNU(XW, XD, uint64_t, uint32_t, int64_t)
+
+#define XVSSRLRNU(NAME, BIT, E1, E2, E3)                                     \
+void HELPER(NAME)(CPULoongArchState *env,                                    \
+                  uint32_t xd, uint32_t xj, uint32_t xk)                     \
+{                                                                            \
+    int i, max;                                                              \
+    XReg *Xd = &(env->fpr[xd].xreg);                                         \
+    XReg *Xj = &(env->fpr[xj].xreg);                                         \
+    XReg *Xk = &(env->fpr[xk].xreg);                                         \
+                                                                             \
+    max = LASX_LEN / (BIT * 2);                                              \
+    for (i = 0; i < max; i++) {                                              \
+        Xd->E1(i) = do_xssrlrnu_ ## E1(Xj->E2(i), Xk->E3(i) % BIT, BIT / 2); \
+        Xd->E1(i + max * 2) = do_xssrlrnu_## E1(Xj->E2(i + max),             \
+                                                Xk->E3(i + max) % BIT,       \
+                                                BIT / 2);                    \
+    }                                                                        \
+    Xd->XD(1) = 0;                                                           \
+    Xd->XD(3) = 0;                                                           \
+}
+
+XVSSRLRNU(xvssrlrn_bu_h, 16, XB, XH, UXH)
+XVSSRLRNU(xvssrlrn_hu_w, 32, XH, XW, UXW)
+XVSSRLRNU(xvssrlrn_wu_d, 64, XW, XD, UXD)
+
+#define XSSRARNU(E1, E2, T1, T2, T3)                \
+static T1 do_xssrarnu_ ## E1(T3 e2, int sa, int sh) \
+{                                                   \
+    T1 shft_res;                                    \
+                                                    \
+    if (e2 < 0) {                                   \
+        shft_res = 0;                               \
+    } else {                                        \
+        shft_res = do_xvsrar_ ## E2(e2, sa);        \
+    }                                               \
+    T2 mask;                                        \
+    mask = (1ull << sh) - 1;                        \
+    if (shft_res > mask) {                          \
+        return mask;                                \
+    } else {                                        \
+        return shft_res;                            \
+    }                                               \
+}
+
+XSSRARNU(XB, XH, uint16_t, uint8_t, int16_t)
+XSSRARNU(XH, XW, uint32_t, uint16_t, int32_t)
+XSSRARNU(XW, XD, uint64_t, uint32_t, int64_t)
+
+#define XVSSRARNU(NAME, BIT, E1, E2, E3)                                     \
+void HELPER(NAME)(CPULoongArchState *env,                                    \
+                  uint32_t xd, uint32_t xj, uint32_t xk)                     \
+{                                                                            \
+    int i, max;                                                              \
+    XReg *Xd = &(env->fpr[xd].xreg);                                         \
+    XReg *Xj = &(env->fpr[xj].xreg);                                         \
+    XReg *Xk = &(env->fpr[xk].xreg);                                         \
+                                                                             \
+    max = LASX_LEN / (BIT * 2);                                              \
+    for (i = 0; i < max; i++) {                                              \
+        Xd->E1(i) = do_xssrarnu_ ## E1(Xj->E2(i), Xk->E3(i) % BIT, BIT / 2); \
+        Xd->E1(i + max * 2) = do_xssrarnu_## E1(Xj->E2(i + max),             \
+                                                Xk->E3(i + max) % BIT,       \
+                                                BIT / 2);                    \
+    }                                                                        \
+    Xd->XD(1) = 0;                                                           \
+    Xd->XD(3) = 0;                                                           \
+}
+
+XVSSRARNU(xvssrarn_bu_h, 16, XB, XH, UXH)
+XVSSRARNU(xvssrarn_hu_w, 32, XH, XW, UXW)
+XVSSRARNU(xvssrarn_wu_d, 64, XW, XD, UXD)
+
+#define XVSSRLRNI(NAME, BIT, E1, E2)                                          \
+void HELPER(NAME)(CPULoongArchState *env,                                     \
+                  uint32_t xd, uint32_t xj, uint32_t imm)                     \
+{                                                                             \
+    int i, max;                                                               \
+    XReg temp;                                                                \
+    XReg *Xd = &(env->fpr[xd].xreg);                                          \
+    XReg *Xj = &(env->fpr[xj].xreg);                                          \
+                                                                              \
+    max = LASX_LEN / (BIT * 2);                                               \
+    for (i = 0; i < max; i++) {                                               \
+        temp.E1(i) = do_xssrlrns_ ## E1(Xj->E2(i), imm, (BIT / 2) - 1);       \
+        temp.E1(i + max) = do_xssrlrns_ ## E1(Xd->E2(i), imm, (BIT / 2) - 1); \
+        temp.E1(i + max * 2) = do_xssrlrns_## E1(Xj->E2(i + max),             \
+                                                 imm, (BIT / 2) - 1);         \
+        temp.E1(i + max * 3) = do_xssrlrns_## E1(Xd->E2(i + max),             \
+                                                 imm, (BIT / 2) - 1);         \
+    }                                                                         \
+    *Xd = temp;                                                               \
+}
+
+#define XVSSRLRNI_Q(NAME, sh)                                                  \
+void HELPER(NAME)(CPULoongArchState *env,                                      \
+                          uint32_t xd, uint32_t xj, uint32_t imm)              \
+{                                                                              \
+    int i;                                                                     \
+    Int128 shft_res[4], r[4], mask;                                            \
+    XReg *Xd = &(env->fpr[xd].xreg);                                           \
+    XReg *Xj = &(env->fpr[xj].xreg);                                           \
+                                                                               \
+    if (imm == 0) {                                                            \
+        shft_res[0] = Xj->XQ(0);                                               \
+        shft_res[1] = Xd->XQ(0);                                               \
+        shft_res[2] = Xj->XQ(1);                                               \
+        shft_res[3] = Xd->XQ(1);                                               \
+    } else {                                                                   \
+        r[0] = int128_and(int128_urshift(Xj->XQ(0), (imm - 1)), int128_one()); \
+        r[1] = int128_and(int128_urshift(Xd->XQ(0), (imm - 1)), int128_one()); \
+        r[2] = int128_and(int128_urshift(Xj->XQ(1), (imm - 1)), int128_one()); \
+        r[3] = int128_and(int128_urshift(Xd->XQ(1), (imm - 1)), int128_one()); \
+                                                                               \
+        shft_res[0] = (int128_add(int128_urshift(Xj->XQ(0), imm), r[0]));      \
+        shft_res[1] = (int128_add(int128_urshift(Xd->XQ(0), imm), r[1]));      \
+        shft_res[2] = (int128_add(int128_urshift(Xj->XQ(1), imm), r[2]));      \
+        shft_res[3] = (int128_add(int128_urshift(Xd->XQ(1), imm), r[3]));      \
+    }                                                                          \
+                                                                               \
+    mask = int128_sub(int128_lshift(int128_one(), sh), int128_one());          \
+                                                                               \
+    for (i = 0; i < 4; i++) {                                                  \
+        if (int128_ult(mask, shft_res[i])) {                                   \
+            Xd->XD(i) = int128_getlo(mask);                                    \
+        } else {                                                               \
+            Xd->XD(i) = int128_getlo(shft_res[i]);                             \
+        }                                                                      \
+    }                                                                          \
+}
+
+XVSSRLRNI(xvssrlrni_b_h, 16, XB, XH)
+XVSSRLRNI(xvssrlrni_h_w, 32, XH, XW)
+XVSSRLRNI(xvssrlrni_w_d, 64, XW, XD)
+XVSSRLRNI_Q(xvssrlrni_d_q, 63)
+
+#define XVSSRARNI(NAME, BIT, E1, E2)                                          \
+void HELPER(NAME)(CPULoongArchState *env,                                     \
+                  uint32_t xd, uint32_t xj, uint32_t imm)                     \
+{                                                                             \
+    int i, max;                                                               \
+    XReg temp;                                                                \
+    XReg *Xd = &(env->fpr[xd].xreg);                                          \
+    XReg *Xj = &(env->fpr[xj].xreg);                                          \
+                                                                              \
+    max = LASX_LEN / (BIT * 2);                                               \
+    for (i = 0; i < max; i++) {                                               \
+        temp.E1(i) = do_xssrarns_ ## E1(Xj->E2(i), imm, (BIT / 2) -  1);      \
+        temp.E1(i + max) = do_xssrarns_ ## E1(Xd->E2(i), imm, (BIT / 2) - 1); \
+        temp.E1(i + max * 2) = do_xssrarns_## E1(Xj->E2(i + max),             \
+                                                 imm, (BIT / 2) - 1);         \
+        temp.E1(i + max * 3) = do_xssrarns_## E1(Xd->E2(i + max),             \
+                                                 imm, (BIT / 2) - 1);         \
+    }                                                                         \
+    *Xd = temp;                                                               \
+}
+
+void HELPER(xvssrarni_d_q)(CPULoongArchState *env,
+                           uint32_t xd, uint32_t xj, uint32_t imm)
+{
+    int i;
+    Int128 shft_res[4], r[4], mask1, mask2;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    if (imm == 0) {
+        shft_res[0] = Xj->XQ(0);
+        shft_res[1] = Xd->XQ(0);
+        shft_res[2] = Xj->XQ(1);
+        shft_res[3] = Xd->XQ(1);
+    } else {
+        r[0] = int128_and(int128_rshift(Xj->XQ(0), (imm - 1)), int128_one());
+        r[1] = int128_and(int128_rshift(Xd->XQ(0), (imm - 1)), int128_one());
+        r[2] = int128_and(int128_rshift(Xj->XQ(1), (imm - 1)), int128_one());
+        r[3] = int128_and(int128_rshift(Xd->XQ(1), (imm - 1)), int128_one());
+
+        shft_res[0] = int128_add(int128_rshift(Xj->XQ(0), imm), r[0]);
+        shft_res[1] = int128_add(int128_rshift(Xd->XQ(0), imm), r[1]);
+        shft_res[2] = int128_add(int128_rshift(Xj->XQ(1), imm), r[2]);
+        shft_res[3] = int128_add(int128_rshift(Xd->XQ(1), imm), r[3]);
+    }
+
+    mask1 = int128_sub(int128_lshift(int128_one(), 63), int128_one());
+    mask2  = int128_lshift(int128_one(), 63);
+
+    for (i = 0; i < 4; i++) {
+        if (int128_gt(shft_res[i],  mask1)) {
+            Xd->XD(i) = int128_getlo(mask1);
+        } else if (int128_lt(shft_res[i], int128_neg(mask2))) {
+            Xd->XD(i) = int128_getlo(mask2);
+        } else {
+            Xd->XD(i) = int128_getlo(shft_res[i]);
+        }
+    }
+}
+
+XVSSRARNI(xvssrarni_b_h, 16, XB, XH)
+XVSSRARNI(xvssrarni_h_w, 32, XH, XW)
+XVSSRARNI(xvssrarni_w_d, 64, XW, XD)
+
+#define XVSSRLRNUI(NAME, BIT, E1, E2)                                   \
+void HELPER(NAME)(CPULoongArchState *env,                               \
+                  uint32_t xd, uint32_t xj, uint32_t imm)               \
+{                                                                       \
+    int i, max;                                                         \
+    XReg temp;                                                          \
+    XReg *Xd = &(env->fpr[xd].xreg);                                    \
+    XReg *Xj = &(env->fpr[xj].xreg);                                    \
+                                                                        \
+    max = LASX_LEN / (BIT * 2);                                         \
+    for (i = 0; i < max; i++) {                                         \
+        temp.E1(i) = do_xssrlrnu_ ## E1(Xj->E2(i), imm, BIT / 2);       \
+        temp.E1(i + max) = do_xssrlrnu_ ## E1(Xd->E2(i), imm, BIT / 2); \
+        temp.E1(i + max * 2) = do_xssrlrnu_## E1(Xj->E2(i + max),       \
+                                                 imm, BIT / 2);         \
+        temp.E1(i + max * 3) = do_xssrlrnu_## E1(Xd->E2(i + max),       \
+                                                 imm, BIT / 2);         \
+    }                                                                   \
+    *Xd = temp;                                                         \
+}
+
+XVSSRLRNUI(xvssrlrni_bu_h, 16, XB, XH)
+XVSSRLRNUI(xvssrlrni_hu_w, 32, XH, XW)
+XVSSRLRNUI(xvssrlrni_wu_d, 64, XW, XD)
+XVSSRLRNI_Q(xvssrlrni_du_q, 64)
+
+#define XVSSRARNUI(NAME, BIT, E1, E2)                                   \
+void HELPER(NAME)(CPULoongArchState *env,                               \
+                  uint32_t xd, uint32_t xj, uint32_t imm)               \
+{                                                                       \
+    int i, max;                                                         \
+    XReg temp;                                                          \
+    XReg *Xd = &(env->fpr[xd].xreg);                                    \
+    XReg *Xj = &(env->fpr[xj].xreg);                                    \
+                                                                        \
+    max = LASX_LEN / (BIT * 2);                                         \
+    for (i = 0; i < max; i++) {                                         \
+        temp.E1(i) = do_xssrarnu_ ## E1(Xj->E2(i), imm, BIT / 2);       \
+        temp.E1(i + max) = do_xssrarnu_ ## E1(Xd->E2(i), imm, BIT / 2); \
+        temp.E1(i + max * 2) = do_xssrarnu_## E1(Xj->E2(i + max),       \
+                                                 imm, BIT / 2);         \
+        temp.E1(i + max * 3) = do_xssrarnu_## E1(Xd->E2(i + max),       \
+                                                 imm, BIT / 2);         \
+    }                                                                   \
+    *Xd = temp;                                                         \
+}
+
+void HELPER(xvssrarni_du_q)(CPULoongArchState *env,
+                            uint32_t xd, uint32_t xj, uint32_t imm)
+{
+    int i;
+    Int128 shft_res[4], r[4], mask1, mask2;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    if (imm == 0) {
+        shft_res[0] = Xj->XQ(0);
+        shft_res[1] = Xd->XQ(0);
+        shft_res[2] = Xj->XQ(1);
+        shft_res[3] = Xd->XQ(1);
+    } else {
+        r[0] = int128_and(int128_rshift(Xj->XQ(0), (imm - 1)), int128_one());
+        r[1] = int128_and(int128_rshift(Xd->XQ(0), (imm - 1)), int128_one());
+        r[2] = int128_and(int128_rshift(Xj->XQ(1), (imm - 1)), int128_one());
+        r[3] = int128_and(int128_rshift(Xd->XQ(1), (imm - 1)), int128_one());
+
+        shft_res[0] = int128_add(int128_rshift(Xj->XQ(0), imm), r[0]);
+        shft_res[1] = int128_add(int128_rshift(Xd->XQ(0), imm), r[1]);
+        shft_res[2] = int128_add(int128_rshift(Xj->XQ(1), imm), r[2]);
+        shft_res[3] = int128_add(int128_rshift(Xd->XQ(1), imm), r[3]);
+    }
+
+    if (int128_lt(Xj->XQ(0), int128_zero())) {
+        shft_res[0] = int128_zero();
+    }
+    if (int128_lt(Xd->XQ(0), int128_zero())) {
+        shft_res[1] = int128_zero();
+    }
+    if (int128_lt(Xj->XQ(1), int128_zero())) {
+        shft_res[2] = int128_zero();
+    }
+    if (int128_lt(Xd->XQ(1), int128_zero())) {
+        shft_res[3] = int128_zero();
+    }
+
+    mask1 = int128_sub(int128_lshift(int128_one(), 64), int128_one());
+    mask2  = int128_lshift(int128_one(), 64);
+
+    for (i = 0; i < 4; i++) {
+        if (int128_gt(shft_res[i],  mask1)) {
+            Xd->XD(i) = int128_getlo(mask1);
+        } else if (int128_lt(shft_res[i], int128_neg(mask2))) {
+            Xd->XD(i) = int128_getlo(mask2);
+        } else {
+            Xd->XD(i) = int128_getlo(shft_res[i]);
+        }
+    }
+}
+
+XVSSRARNUI(xvssrarni_bu_h, 16, XB, XH)
+XVSSRARNUI(xvssrarni_hu_w, 32, XH, XW)
+XVSSRARNUI(xvssrarni_wu_d, 64, XW, XD)
-- 
2.39.1


