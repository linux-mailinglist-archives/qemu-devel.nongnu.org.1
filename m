Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D9C736839
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:46:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXqa-0003QF-B1; Tue, 20 Jun 2023 05:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXqS-0002n5-VS
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:40:18 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXqM-0006aP-QV
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:40:15 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx_eqZc5FkyCUHAA--.14883S3;
 Tue, 20 Jun 2023 17:38:33 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S32; 
 Tue, 20 Jun 2023 17:38:32 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 30/46] target/loongarch: Implement xvssrln xvssran
Date: Tue, 20 Jun 2023 17:37:58 +0800
Message-Id: <20230620093814.123650-31-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S32
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
- XVSSRLN.{B.H/H.W/W.D};
- XVSSRAN.{B.H/H.W/W.D};
- XVSSRLN.{BU.H/HU.W/WU.D};
- XVSSRAN.{BU.H/HU.W/WU.D};
- XVSSRLNI.{B.H/H.W/W.D/D.Q};
- XVSSRANI.{B.H/H.W/W.D/D.Q};
- XVSSRLNI.{BU.H/HU.W/WU.D/DU.Q};
- XVSSRANI.{BU.H/HU.W/WU.D/DU.Q}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  30 ++
 target/loongarch/helper.h                    |  30 ++
 target/loongarch/insn_trans/trans_lasx.c.inc |  30 ++
 target/loongarch/insns.decode                |  30 ++
 target/loongarch/lasx_helper.c               | 428 +++++++++++++++++++
 5 files changed, 548 insertions(+)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 515d99aa1f..1f40f3aaca 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2135,6 +2135,36 @@ INSN_LASX(xvsrarni_h_w,      xx_i)
 INSN_LASX(xvsrarni_w_d,      xx_i)
 INSN_LASX(xvsrarni_d_q,      xx_i)
 
+INSN_LASX(xvssrln_b_h,       xxx)
+INSN_LASX(xvssrln_h_w,       xxx)
+INSN_LASX(xvssrln_w_d,       xxx)
+INSN_LASX(xvssran_b_h,       xxx)
+INSN_LASX(xvssran_h_w,       xxx)
+INSN_LASX(xvssran_w_d,       xxx)
+INSN_LASX(xvssrln_bu_h,      xxx)
+INSN_LASX(xvssrln_hu_w,      xxx)
+INSN_LASX(xvssrln_wu_d,      xxx)
+INSN_LASX(xvssran_bu_h,      xxx)
+INSN_LASX(xvssran_hu_w,      xxx)
+INSN_LASX(xvssran_wu_d,      xxx)
+
+INSN_LASX(xvssrlni_b_h,      xx_i)
+INSN_LASX(xvssrlni_h_w,      xx_i)
+INSN_LASX(xvssrlni_w_d,      xx_i)
+INSN_LASX(xvssrlni_d_q,      xx_i)
+INSN_LASX(xvssrani_b_h,      xx_i)
+INSN_LASX(xvssrani_h_w,      xx_i)
+INSN_LASX(xvssrani_w_d,      xx_i)
+INSN_LASX(xvssrani_d_q,      xx_i)
+INSN_LASX(xvssrlni_bu_h,     xx_i)
+INSN_LASX(xvssrlni_hu_w,     xx_i)
+INSN_LASX(xvssrlni_wu_d,     xx_i)
+INSN_LASX(xvssrlni_du_q,     xx_i)
+INSN_LASX(xvssrani_bu_h,     xx_i)
+INSN_LASX(xvssrani_hu_w,     xx_i)
+INSN_LASX(xvssrani_wu_d,     xx_i)
+INSN_LASX(xvssrani_du_q,     xx_i)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 09ae21edd6..2d76916049 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -990,3 +990,33 @@ DEF_HELPER_4(xvsrarni_b_h, void, env, i32, i32, i32)
 DEF_HELPER_4(xvsrarni_h_w, void, env, i32, i32, i32)
 DEF_HELPER_4(xvsrarni_w_d, void, env, i32, i32, i32)
 DEF_HELPER_4(xvsrarni_d_q, void, env, i32, i32, i32)
+
+DEF_HELPER_4(xvssrln_b_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrln_h_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrln_w_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssran_b_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssran_h_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssran_w_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrln_bu_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrln_hu_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrln_wu_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssran_bu_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssran_hu_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssran_wu_d, void, env, i32, i32, i32)
+
+DEF_HELPER_4(xvssrlni_b_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrlni_h_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrlni_w_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrlni_d_q, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrani_b_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrani_h_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrani_w_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrani_d_q, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrlni_bu_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrlni_hu_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrlni_wu_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrlni_du_q, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrani_bu_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrani_hu_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrani_wu_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvssrani_du_q, void, env, i32, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 5cd241bafa..b6c2ced30c 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -2084,6 +2084,36 @@ TRANS(xvsrarni_h_w, gen_xx_i, gen_helper_xvsrarni_h_w)
 TRANS(xvsrarni_w_d, gen_xx_i, gen_helper_xvsrarni_w_d)
 TRANS(xvsrarni_d_q, gen_xx_i, gen_helper_xvsrarni_d_q)
 
+TRANS(xvssrln_b_h, gen_xxx, gen_helper_xvssrln_b_h)
+TRANS(xvssrln_h_w, gen_xxx, gen_helper_xvssrln_h_w)
+TRANS(xvssrln_w_d, gen_xxx, gen_helper_xvssrln_w_d)
+TRANS(xvssran_b_h, gen_xxx, gen_helper_xvssran_b_h)
+TRANS(xvssran_h_w, gen_xxx, gen_helper_xvssran_h_w)
+TRANS(xvssran_w_d, gen_xxx, gen_helper_xvssran_w_d)
+TRANS(xvssrln_bu_h, gen_xxx, gen_helper_xvssrln_bu_h)
+TRANS(xvssrln_hu_w, gen_xxx, gen_helper_xvssrln_hu_w)
+TRANS(xvssrln_wu_d, gen_xxx, gen_helper_xvssrln_wu_d)
+TRANS(xvssran_bu_h, gen_xxx, gen_helper_xvssran_bu_h)
+TRANS(xvssran_hu_w, gen_xxx, gen_helper_xvssran_hu_w)
+TRANS(xvssran_wu_d, gen_xxx, gen_helper_xvssran_wu_d)
+
+TRANS(xvssrlni_b_h, gen_xx_i, gen_helper_xvssrlni_b_h)
+TRANS(xvssrlni_h_w, gen_xx_i, gen_helper_xvssrlni_h_w)
+TRANS(xvssrlni_w_d, gen_xx_i, gen_helper_xvssrlni_w_d)
+TRANS(xvssrlni_d_q, gen_xx_i, gen_helper_xvssrlni_d_q)
+TRANS(xvssrani_b_h, gen_xx_i, gen_helper_xvssrani_b_h)
+TRANS(xvssrani_h_w, gen_xx_i, gen_helper_xvssrani_h_w)
+TRANS(xvssrani_w_d, gen_xx_i, gen_helper_xvssrani_w_d)
+TRANS(xvssrani_d_q, gen_xx_i, gen_helper_xvssrani_d_q)
+TRANS(xvssrlni_bu_h, gen_xx_i, gen_helper_xvssrlni_bu_h)
+TRANS(xvssrlni_hu_w, gen_xx_i, gen_helper_xvssrlni_hu_w)
+TRANS(xvssrlni_wu_d, gen_xx_i, gen_helper_xvssrlni_wu_d)
+TRANS(xvssrlni_du_q, gen_xx_i, gen_helper_xvssrlni_du_q)
+TRANS(xvssrani_bu_h, gen_xx_i, gen_helper_xvssrani_bu_h)
+TRANS(xvssrani_hu_w, gen_xx_i, gen_helper_xvssrani_hu_w)
+TRANS(xvssrani_wu_d, gen_xx_i, gen_helper_xvssrani_wu_d)
+TRANS(xvssrani_du_q, gen_xx_i, gen_helper_xvssrani_du_q)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 0273576ada..cf3803c230 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1733,6 +1733,36 @@ xvsrarni_h_w     0111 01110101 11001 ..... ..... .....    @xx_ui5
 xvsrarni_w_d     0111 01110101 1101 ...... ..... .....    @xx_ui6
 xvsrarni_d_q     0111 01110101 111 ....... ..... .....    @xx_ui7
 
+xvssrln_b_h      0111 01001111 11001 ..... ..... .....    @xxx
+xvssrln_h_w      0111 01001111 11010 ..... ..... .....    @xxx
+xvssrln_w_d      0111 01001111 11011 ..... ..... .....    @xxx
+xvssran_b_h      0111 01001111 11101 ..... ..... .....    @xxx
+xvssran_h_w      0111 01001111 11110 ..... ..... .....    @xxx
+xvssran_w_d      0111 01001111 11111 ..... ..... .....    @xxx
+xvssrln_bu_h     0111 01010000 01001 ..... ..... .....    @xxx
+xvssrln_hu_w     0111 01010000 01010 ..... ..... .....    @xxx
+xvssrln_wu_d     0111 01010000 01011 ..... ..... .....    @xxx
+xvssran_bu_h     0111 01010000 01101 ..... ..... .....    @xxx
+xvssran_hu_w     0111 01010000 01110 ..... ..... .....    @xxx
+xvssran_wu_d     0111 01010000 01111 ..... ..... .....    @xxx
+
+xvssrlni_b_h     0111 01110100 10000 1 .... ..... .....   @xx_ui4
+xvssrlni_h_w     0111 01110100 10001 ..... ..... .....    @xx_ui5
+xvssrlni_w_d     0111 01110100 1001 ...... ..... .....    @xx_ui6
+xvssrlni_d_q     0111 01110100 101 ....... ..... .....    @xx_ui7
+xvssrani_b_h     0111 01110110 00000 1 .... ..... .....   @xx_ui4
+xvssrani_h_w     0111 01110110 00001 ..... ..... .....    @xx_ui5
+xvssrani_w_d     0111 01110110 0001 ...... ..... .....    @xx_ui6
+xvssrani_d_q     0111 01110110 001 ....... ..... .....    @xx_ui7
+xvssrlni_bu_h    0111 01110100 11000 1 .... ..... .....   @xx_ui4
+xvssrlni_hu_w    0111 01110100 11001 ..... ..... .....    @xx_ui5
+xvssrlni_wu_d    0111 01110100 1101 ...... ..... .....    @xx_ui6
+xvssrlni_du_q    0111 01110100 111 ....... ..... .....    @xx_ui7
+xvssrani_bu_h    0111 01110110 01000 1 .... ..... .....   @xx_ui4
+xvssrani_hu_w    0111 01110110 01001 ..... ..... .....    @xx_ui5
+xvssrani_wu_d    0111 01110110 0101 ...... ..... .....    @xx_ui6
+xvssrani_du_q    0111 01110110 011 ....... ..... .....    @xx_ui7
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index b0d5f93a97..b42f412c02 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -1242,3 +1242,431 @@ void HELPER(xvsrarni_d_q)(CPULoongArchState *env,
 XVSRARNI(xvsrarni_b_h, 16, XB, XH)
 XVSRARNI(xvsrarni_h_w, 32, XH, XW)
 XVSRARNI(xvsrarni_w_d, 64, XW, XD)
+
+#define XSSRLNS(NAME, T1, T2, T3)                    \
+static T1 do_xssrlns_ ## NAME(T2 e2, int sa, int sh) \
+{                                                    \
+        T1 shft_res;                                 \
+        if (sa == 0) {                               \
+            shft_res = e2;                           \
+        } else {                                     \
+            shft_res = (((T1)e2) >> sa);             \
+        }                                            \
+        T3 mask;                                     \
+        mask = (1ull << sh) - 1;                     \
+        if (shft_res > mask) {                       \
+            return mask;                             \
+        } else {                                     \
+            return  shft_res;                        \
+        }                                            \
+}
+
+XSSRLNS(XB, uint16_t, int16_t, uint8_t)
+XSSRLNS(XH, uint32_t, int32_t, uint16_t)
+XSSRLNS(XW, uint64_t, int64_t, uint32_t)
+
+#define XVSSRLN(NAME, BIT, E1, E2, E3)                                 \
+void HELPER(NAME)(CPULoongArchState *env,                              \
+                  uint32_t xd, uint32_t xj, uint32_t xk)               \
+{                                                                      \
+    int i, max;                                                        \
+    XReg *Xd = &(env->fpr[xd].xreg);                                   \
+    XReg *Xj = &(env->fpr[xj].xreg);                                   \
+    XReg *Xk = &(env->fpr[xk].xreg);                                   \
+                                                                       \
+    max = LASX_LEN / (BIT * 2);                                        \
+    for (i = 0; i < max; i++) {                                        \
+        Xd->E1(i) = do_xssrlns_ ## E1(Xj->E2(i),                       \
+                                      Xk->E3(i) % BIT, (BIT / 2) - 1); \
+        Xd->E1(i + max * 2) = do_xssrlns_## E1(Xj->E2(i + max),        \
+                                               Xk->E3(i + max) % BIT,  \
+                                               (BIT / 2) - 1);         \
+    }                                                                  \
+    Xd->XD(1) = 0;                                                     \
+    Xd->XD(3) = 0;                                                     \
+}
+
+XVSSRLN(xvssrln_b_h, 16, XB, XH, UXH)
+XVSSRLN(xvssrln_h_w, 32, XH, XW, UXW)
+XVSSRLN(xvssrln_w_d, 64, XW, XD, UXD)
+
+#define XSSRANS(E, T1, T2)                        \
+static T1 do_xssrans_ ## E(T1 e2, int sa, int sh) \
+{                                                 \
+        T1 shft_res;                              \
+        if (sa == 0) {                            \
+            shft_res = e2;                        \
+        } else {                                  \
+            shft_res = e2 >> sa;                  \
+        }                                         \
+        T2 mask;                                  \
+        mask = (1ll << sh) - 1;                   \
+        if (shft_res > mask) {                    \
+            return  mask;                         \
+        } else if (shft_res < -(mask + 1)) {      \
+            return  ~mask;                        \
+        } else {                                  \
+            return shft_res;                      \
+        }                                         \
+}
+
+XSSRANS(XB, int16_t, int8_t)
+XSSRANS(XH, int32_t, int16_t)
+XSSRANS(XW, int64_t, int32_t)
+
+#define XVSSRAN(NAME, BIT, E1, E2, E3)                                 \
+void HELPER(NAME)(CPULoongArchState *env,                              \
+                  uint32_t xd, uint32_t xj, uint32_t xk)               \
+{                                                                      \
+    int i, max;                                                        \
+    XReg *Xd = &(env->fpr[xd].xreg);                                   \
+    XReg *Xj = &(env->fpr[xj].xreg);                                   \
+    XReg *Xk = &(env->fpr[xk].xreg);                                   \
+                                                                       \
+    max = LASX_LEN / (BIT * 2);                                        \
+    for (i = 0; i < max; i++) {                                        \
+        Xd->E1(i) = do_xssrans_ ## E1(Xj->E2(i),                       \
+                                      Xk->E3(i) % BIT, (BIT / 2) - 1); \
+        Xd->E1(i + max * 2) = do_xssrans_## E1(Xj->E2(i + max),        \
+                                               Xk->E3(i + max) % BIT,  \
+                                               (BIT / 2) - 1);         \
+    }                                                                  \
+    Xd->XD(1) = 0;                                                     \
+    Xd->XD(3) = 0;                                                     \
+}
+
+XVSSRAN(xvssran_b_h, 16, XB, XH, UXH)
+XVSSRAN(xvssran_h_w, 32, XH, XW, UXW)
+XVSSRAN(xvssran_w_d, 64, XW, XD, UXD)
+
+#define XSSRLNU(E, T1, T2, T3)                    \
+static T1 do_xssrlnu_ ## E(T3 e2, int sa, int sh) \
+{                                                 \
+        T1 shft_res;                              \
+        if (sa == 0) {                            \
+            shft_res = e2;                        \
+        } else {                                  \
+            shft_res = (((T1)e2) >> sa);          \
+        }                                         \
+        T2 mask;                                  \
+        mask = (1ull << sh) - 1;                  \
+        if (shft_res > mask) {                    \
+            return mask;                          \
+        } else {                                  \
+            return shft_res;                      \
+        }                                         \
+}
+
+XSSRLNU(XB, uint16_t, uint8_t,  int16_t)
+XSSRLNU(XH, uint32_t, uint16_t, int32_t)
+XSSRLNU(XW, uint64_t, uint32_t, int64_t)
+
+#define XVSSRLNU(NAME, BIT, E1, E2, E3)                                     \
+void HELPER(NAME)(CPULoongArchState *env,                                   \
+                  uint32_t xd, uint32_t xj, uint32_t xk)                    \
+{                                                                           \
+    int i, max;                                                             \
+    XReg *Xd = &(env->fpr[xd].xreg);                                        \
+    XReg *Xj = &(env->fpr[xj].xreg);                                        \
+    XReg *Xk = &(env->fpr[xk].xreg);                                        \
+                                                                            \
+    max = LASX_LEN / (BIT * 2);                                             \
+    for (i = 0; i < max; i++) {                                             \
+        Xd->E1(i) = do_xssrlnu_ ## E1(Xj->E2(i), Xk->E3(i) % BIT, BIT / 2); \
+        Xd->E1(i + max * 2) = do_xssrlnu_## E1(Xj->E2(i + max),             \
+                                               Xk->E3(i + max) % BIT,       \
+                                               BIT / 2);                    \
+    }                                                                       \
+    Xd->XD(1) = 0;                                                          \
+    Xd->XD(3) = 0;                                                          \
+}
+
+XVSSRLNU(xvssrln_bu_h, 16, XB, XH, UXH)
+XVSSRLNU(xvssrln_hu_w, 32, XH, XW, UXW)
+XVSSRLNU(xvssrln_wu_d, 64, XW, XD, UXD)
+
+#define XSSRANU(E, T1, T2, T3)                    \
+static T1 do_xssranu_ ## E(T3 e2, int sa, int sh) \
+{                                                 \
+        T1 shft_res;                              \
+        if (sa == 0) {                            \
+            shft_res = e2;                        \
+        } else {                                  \
+            shft_res = e2 >> sa;                  \
+        }                                         \
+        if (e2 < 0) {                             \
+            shft_res = 0;                         \
+        }                                         \
+        T2 mask;                                  \
+        mask = (1ull << sh) - 1;                  \
+        if (shft_res > mask) {                    \
+            return mask;                          \
+        } else {                                  \
+            return shft_res;                      \
+        }                                         \
+}
+
+XSSRANU(XB, uint16_t, uint8_t,  int16_t)
+XSSRANU(XH, uint32_t, uint16_t, int32_t)
+XSSRANU(XW, uint64_t, uint32_t, int64_t)
+
+#define XVSSRANU(NAME, BIT, E1, E2, E3)                                     \
+void HELPER(NAME)(CPULoongArchState *env,                                   \
+                  uint32_t xd, uint32_t xj, uint32_t xk)                    \
+{                                                                           \
+    int i, max;                                                             \
+    XReg *Xd = &(env->fpr[xd].xreg);                                        \
+    XReg *Xj = &(env->fpr[xj].xreg);                                        \
+    XReg *Xk = &(env->fpr[xk].xreg);                                        \
+                                                                            \
+    max = LASX_LEN / (BIT * 2);                                             \
+    for (i = 0; i < max; i++) {                                             \
+        Xd->E1(i) = do_xssranu_ ## E1(Xj->E2(i), Xk->E3(i) % BIT, BIT / 2); \
+        Xd->E1(i + max * 2) = do_xssranu_## E1(Xj->E2(i + max),             \
+                                               Xk->E3(i + max) % BIT,       \
+                                               BIT / 2);                    \
+    }                                                                       \
+    Xd->XD(1) = 0;                                                          \
+    Xd->XD(3) = 0;                                                          \
+}
+
+XVSSRANU(xvssran_bu_h, 16, XB, XH, UXH)
+XVSSRANU(xvssran_hu_w, 32, XH, XW, UXW)
+XVSSRANU(xvssran_wu_d, 64, XW, XD, UXD)
+
+#define XVSSRLNI(NAME, BIT, E1, E2)                                          \
+void HELPER(NAME)(CPULoongArchState *env,                                    \
+                  uint32_t xd, uint32_t xj, uint32_t imm)                    \
+{                                                                            \
+    int i, max;                                                              \
+    XReg temp;                                                               \
+    XReg *Xd = &(env->fpr[xd].xreg);                                         \
+    XReg *Xj = &(env->fpr[xj].xreg);                                         \
+                                                                             \
+    max = LASX_LEN / (BIT * 2);                                              \
+    for (i = 0; i < max; i++) {                                              \
+        temp.E1(i) = do_xssrlns_ ## E1(Xj->E2(i), imm, (BIT / 2) - 1);       \
+        temp.E1(i + max) = do_xssrlns_ ## E1(Xd->E2(i), imm, (BIT / 2) - 1); \
+        temp.E1(i + max * 2) = do_xssrlns_## E1(Xj->E2(i + max),             \
+                                                imm, (BIT / 2) - 1);         \
+        temp.E1(i + max * 3) = do_xssrlns_## E1(Xd->E2(i + max),             \
+                                                imm, (BIT / 2) - 1);         \
+    }                                                                        \
+    *Xd = temp;                                                              \
+}
+
+void HELPER(xvssrlni_d_q)(CPULoongArchState *env,
+                          uint32_t xd, uint32_t xj, uint32_t imm)
+{
+    int i;
+    Int128 shft_res[4], mask;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    if (imm == 0) {
+        shft_res[0] = Xj->XQ(0);
+        shft_res[1] = Xd->XQ(0);
+        shft_res[2] = Xj->XQ(1);
+        shft_res[3] = Xd->XQ(1);
+    } else {
+        shft_res[0] = int128_urshift(Xj->XQ(0), imm);
+        shft_res[1] = int128_urshift(Xd->XQ(0), imm);
+        shft_res[2] = int128_urshift(Xj->XQ(1), imm);
+        shft_res[3] = int128_urshift(Xd->XQ(1), imm);
+    }
+    mask = int128_sub(int128_lshift(int128_one(), 63), int128_one());
+
+    for (i = 0; i < 4; i++) {
+        if (int128_ult(mask, shft_res[i])) {
+            Xd->XD(i) = int128_getlo(mask);
+        } else {
+            Xd->XD(i) = int128_getlo(shft_res[i]);
+        }
+    }
+}
+
+XVSSRLNI(xvssrlni_b_h, 16, XB, XH)
+XVSSRLNI(xvssrlni_h_w, 32, XH, XW)
+XVSSRLNI(xvssrlni_w_d, 64, XW, XD)
+
+#define XVSSRANI(NAME, BIT, E1, E2)                                          \
+void HELPER(NAME)(CPULoongArchState *env,                                    \
+                  uint32_t xd, uint32_t xj, uint32_t imm)                    \
+{                                                                            \
+    int i, max;                                                              \
+    XReg temp;                                                               \
+    XReg *Xd = &(env->fpr[xd].xreg);                                         \
+    XReg *Xj = &(env->fpr[xj].xreg);                                         \
+                                                                             \
+    max = LASX_LEN / (BIT * 2);                                              \
+    for (i = 0; i < max; i++) {                                              \
+        temp.E1(i) = do_xssrans_ ## E1(Xj->E2(i), imm, (BIT / 2) - 1);       \
+        temp.E1(i + max) = do_xssrans_ ## E1(Xd->E2(i), imm, (BIT / 2) - 1); \
+        temp.E1(i + max * 2) = do_xssrans_## E1(Xj->E2(i + max),             \
+                                                imm, (BIT / 2) - 1);         \
+        temp.E1(i + max * 3) = do_xssrans_## E1(Xd->E2(i + max),             \
+                                                imm, (BIT / 2) - 1);         \
+    }                                                                        \
+    *Xd = temp;                                                              \
+}
+
+void HELPER(xvssrani_d_q)(CPULoongArchState *env,
+                          uint32_t xd, uint32_t xj, uint32_t imm)
+{
+    int i;
+    Int128 shft_res[4], mask, min;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    if (imm == 0) {
+        shft_res[0] = Xj->XQ(0);
+        shft_res[1] = Xd->XQ(0);
+        shft_res[2] = Xj->XQ(1);
+        shft_res[3] = Xd->XQ(1);
+    } else {
+        shft_res[0] = int128_rshift(Xj->XQ(0), imm);
+        shft_res[1] = int128_rshift(Xd->XQ(0), imm);
+        shft_res[2] = int128_rshift(Xj->XQ(1), imm);
+        shft_res[3] = int128_rshift(Xd->XQ(1), imm);
+    }
+    mask = int128_sub(int128_lshift(int128_one(), 63), int128_one());
+    min  = int128_lshift(int128_one(), 63);
+
+    for (i = 0; i < 4; i++) {
+        if (int128_gt(shft_res[i],  mask)) {
+            Xd->XD(i) = int128_getlo(mask);
+        } else if (int128_lt(shft_res[i], int128_neg(min))) {
+            Xd->XD(i) = int128_getlo(min);
+        } else {
+            Xd->XD(i) = int128_getlo(shft_res[i]);
+        }
+    }
+}
+
+XVSSRANI(xvssrani_b_h, 16, XB, XH)
+XVSSRANI(xvssrani_h_w, 32, XH, XW)
+XVSSRANI(xvssrani_w_d, 64, XW, XD)
+
+#define XVSSRLNUI(NAME, BIT, E1, E2)                                   \
+void HELPER(NAME)(CPULoongArchState *env,                              \
+                  uint32_t xd, uint32_t xj, uint32_t imm)              \
+{                                                                      \
+    int i, max;                                                        \
+    XReg temp;                                                         \
+    XReg *Xd = &(env->fpr[xd].xreg);                                   \
+    XReg *Xj = &(env->fpr[xj].xreg);                                   \
+                                                                       \
+    max = LASX_LEN / (BIT * 2);                                        \
+    for (i = 0; i < max; i++) {                                        \
+        temp.E1(i) = do_xssrlnu_ ## E1(Xj->E2(i), imm, BIT / 2);       \
+        temp.E1(i + max) = do_xssrlnu_ ## E1(Xd->E2(i), imm, BIT / 2); \
+        temp.E1(i + max * 2) = do_xssrlnu_## E1(Xj->E2(i + max),       \
+                                                imm, BIT / 2);         \
+        temp.E1(i + max * 3) = do_xssrlnu_## E1(Xd->E2(i + max),       \
+                                                       imm, BIT / 2);  \
+    }                                                                  \
+    *Xd = temp;                                                        \
+}
+
+void HELPER(xvssrlni_du_q)(CPULoongArchState *env,
+                           uint32_t xd, uint32_t xj, uint32_t imm)
+{
+    int i;
+    Int128 shft_res[4], mask;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    if (imm == 0) {
+        shft_res[0] = Xj->XQ(0);
+        shft_res[1] = Xd->XQ(0);
+        shft_res[2] = Xj->XQ(1);
+        shft_res[3] = Xd->XQ(1);
+    } else {
+        shft_res[0] = int128_urshift(Xj->XQ(0), imm);
+        shft_res[1] = int128_urshift(Xd->XQ(0), imm);
+        shft_res[2] = int128_urshift(Xj->XQ(1), imm);
+        shft_res[3] = int128_urshift(Xd->XQ(1), imm);
+    }
+    mask = int128_sub(int128_lshift(int128_one(), 64), int128_one());
+
+    for (i = 0; i < 4; i++) {
+        if (int128_ult(mask, shft_res[i])) {
+            Xd->XD(i) = int128_getlo(mask);
+        } else {
+            Xd->XD(i) = int128_getlo(shft_res[i]);
+        }
+    }
+}
+
+XVSSRLNUI(xvssrlni_bu_h, 16, XB, XH)
+XVSSRLNUI(xvssrlni_hu_w, 32, XH, XW)
+XVSSRLNUI(xvssrlni_wu_d, 64, XW, XD)
+
+#define XVSSRANUI(NAME, BIT, E1, E2)                                   \
+void HELPER(NAME)(CPULoongArchState *env,                              \
+                  uint32_t xd, uint32_t xj, uint32_t imm)              \
+{                                                                      \
+    int i, max;                                                        \
+    XReg temp;                                                         \
+    XReg *Xd = &(env->fpr[xd].xreg);                                   \
+    XReg *Xj = &(env->fpr[xj].xreg);                                   \
+                                                                       \
+    max = LASX_LEN / (BIT * 2);                                        \
+    for (i = 0; i < max; i++) {                                        \
+        temp.E1(i) = do_xssranu_ ## E1(Xj->E2(i), imm, BIT / 2);       \
+        temp.E1(i + max) = do_xssranu_ ## E1(Xd->E2(i), imm, BIT / 2); \
+        temp.E1(i + max * 2) = do_xssranu_## E1(Xj->E2(i + max),       \
+                                                imm, BIT / 2);         \
+        temp.E1(i + max * 3) = do_xssranu_## E1(Xd->E2(i + max),       \
+                                                imm, BIT / 2);         \
+    }                                                                  \
+    *Xd = temp;                                                        \
+}
+
+void HELPER(xvssrani_du_q)(CPULoongArchState *env,
+                           uint32_t xd, uint32_t xj, uint32_t imm)
+{
+    int i;
+    Int128 shft_res[4], mask;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    if (imm == 0) {
+        shft_res[0] = Xj->XQ(0);
+        shft_res[1] = Xd->XQ(0);
+        shft_res[2] = Xj->XQ(1);
+        shft_res[3] = Xd->XQ(1);
+    } else {
+        shft_res[0] = int128_rshift(Xj->XQ(0), imm);
+        shft_res[1] = int128_rshift(Xd->XQ(0), imm);
+        shft_res[2] = int128_rshift(Xj->XQ(1), imm);
+        shft_res[3] = int128_rshift(Xd->XQ(1), imm);
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
+    mask = int128_sub(int128_lshift(int128_one(), 64), int128_one());
+
+    for (i = 0; i < 4; i++) {
+        if (int128_ult(mask, shft_res[i])) {
+            Xd->XD(i) = int128_getlo(mask);
+        } else {
+            Xd->XD(i) = int128_getlo(shft_res[i]);
+        }
+    }
+}
+
+XVSSRANUI(xvssrani_bu_h, 16, XB, XH)
+XVSSRANUI(xvssrani_hu_w, 32, XH, XW)
+XVSSRANUI(xvssrani_wu_d, 64, XW, XD)
-- 
2.39.1


