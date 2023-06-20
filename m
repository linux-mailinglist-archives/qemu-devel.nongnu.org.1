Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29005736811
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:43:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXpH-0007CS-3X; Tue, 20 Jun 2023 05:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXp4-0007Aj-H5
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:50 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXp2-0006OK-9l
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:50 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxNumbc5Fk0iUHAA--.12679S3;
 Tue, 20 Jun 2023 17:38:35 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S37; 
 Tue, 20 Jun 2023 17:38:35 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 35/46] target/loongarch: Implement xvfrstp
Date: Tue, 20 Jun 2023 17:38:03 +0800
Message-Id: <20230620093814.123650-36-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S37
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
- XVFRSTP[I].{B/H}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  5 ++
 target/loongarch/helper.h                    |  5 ++
 target/loongarch/insn_trans/trans_lasx.c.inc |  5 ++
 target/loongarch/insns.decode                |  5 ++
 target/loongarch/lasx_helper.c               | 56 ++++++++++++++++++++
 5 files changed, 76 insertions(+)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 60d265a9f2..5340609e6f 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2234,6 +2234,11 @@ INSN_LASX(xvbitrevi_h,       xx_i)
 INSN_LASX(xvbitrevi_w,       xx_i)
 INSN_LASX(xvbitrevi_d,       xx_i)
 
+INSN_LASX(xvfrstp_b,         xxx)
+INSN_LASX(xvfrstp_h,         xxx)
+INSN_LASX(xvfrstpi_b,        xx_i)
+INSN_LASX(xvfrstpi_h,        xx_i)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 294ac477fc..4db0cd25d3 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -1091,3 +1091,8 @@ DEF_HELPER_FLAGS_4(xvbitrevi_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(xvbitrevi_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(xvbitrevi_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(xvbitrevi_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_4(xvfrstp_b, void, env, i32, i32, i32)
+DEF_HELPER_4(xvfrstp_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvfrstpi_b, void, env, i32, i32, i32)
+DEF_HELPER_4(xvfrstpi_h, void, env, i32, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index e87e000478..beeb9b3ff8 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -2404,6 +2404,11 @@ TRANS(xvbitrevi_h, gvec_xx_i, MO_16, do_xvbitrevi)
 TRANS(xvbitrevi_w, gvec_xx_i, MO_32, do_xvbitrevi)
 TRANS(xvbitrevi_d, gvec_xx_i, MO_64, do_xvbitrevi)
 
+TRANS(xvfrstp_b, gen_xxx, gen_helper_xvfrstp_b)
+TRANS(xvfrstp_h, gen_xxx, gen_helper_xvfrstp_h)
+TRANS(xvfrstpi_b, gen_xx_i, gen_helper_xvfrstpi_b)
+TRANS(xvfrstpi_h, gen_xx_i, gen_helper_xvfrstpi_h)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 47374054c6..387c1e5776 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1834,6 +1834,11 @@ xvbitrevi_h      0111 01110001 10000 1 .... ..... .....   @xx_ui4
 xvbitrevi_w      0111 01110001 10001 ..... ..... .....    @xx_ui5
 xvbitrevi_d      0111 01110001 1001 ...... ..... .....    @xx_ui6
 
+xvfrstp_b        0111 01010010 10110 ..... ..... .....    @xxx
+xvfrstp_h        0111 01010010 10111 ..... ..... .....    @xxx
+xvfrstpi_b       0111 01101001 10100 ..... ..... .....    @xx_ui5
+xvfrstpi_h       0111 01101001 10101 ..... ..... .....    @xx_ui5
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index 7092835d30..011eab46fb 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -2170,3 +2170,59 @@ XDO_BITI(xvbitrevi_b, 8, UXB, DO_BITREV)
 XDO_BITI(xvbitrevi_h, 16, UXH, DO_BITREV)
 XDO_BITI(xvbitrevi_w, 32, UXW, DO_BITREV)
 XDO_BITI(xvbitrevi_d, 64, UXD, DO_BITREV)
+
+#define XVFRSTP(NAME, BIT, MASK, E)                      \
+void HELPER(NAME)(CPULoongArchState *env,                \
+                  uint32_t xd, uint32_t xj, uint32_t xk) \
+{                                                        \
+    int i, j, m1, m2, max;                               \
+    XReg *Xd = &(env->fpr[xd].xreg);                     \
+    XReg *Xj = &(env->fpr[xj].xreg);                     \
+    XReg *Xk = &(env->fpr[xk].xreg);                     \
+                                                         \
+    max = LASX_LEN / (BIT * 2);                          \
+    m1 = Xk->E(0) & MASK;                                \
+    for (i = 0; i < max; i++) {                          \
+        if (Xj->E(i) < 0) {                              \
+            break;                                       \
+        }                                                \
+    }                                                    \
+    Xd->E(m1) = i;                                       \
+    for (j = 0; j < max; j++) {                          \
+        if (Xj->E(j + max) < 0) {                        \
+            break;                                       \
+        }                                                \
+    }                                                    \
+    m2 = Xk->E(max) & MASK;                              \
+    Xd->E(m2 + max) = j;                                 \
+}
+
+XVFRSTP(xvfrstp_b, 8, 0xf, XB)
+XVFRSTP(xvfrstp_h, 16, 0x7, XH)
+
+#define XVFRSTPI(NAME, BIT, E)                            \
+void HELPER(NAME)(CPULoongArchState *env,                 \
+                  uint32_t xd, uint32_t xj, uint32_t imm) \
+{                                                         \
+    int i, j, m, max;                                     \
+    XReg *Xd = &(env->fpr[xd].xreg);                      \
+    XReg *Xj = &(env->fpr[xj].xreg);                      \
+                                                          \
+    max = LASX_LEN / (BIT * 2);                           \
+    m = imm % (max);                                      \
+    for (i = 0; i < max; i++) {                           \
+        if (Xj->E(i) < 0) {                               \
+            break;                                        \
+        }                                                 \
+    }                                                     \
+    Xd->E(m) = i;                                         \
+    for (j = 0; j < max; j++) {                           \
+        if (Xj->E(j + max) < 0) {                         \
+            break;                                        \
+        }                                                 \
+    }                                                     \
+    Xd->E(m + max) = j;                                   \
+}
+
+XVFRSTPI(xvfrstpi_b, 8, XB)
+XVFRSTPI(xvfrstpi_h, 16, XH)
-- 
2.39.1


