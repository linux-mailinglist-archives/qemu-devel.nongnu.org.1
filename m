Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DAD73681E
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:43:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXqX-00031f-FE; Tue, 20 Jun 2023 05:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXqQ-0002hO-5A
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:40:14 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXqM-0006aQ-DP
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:40:12 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bxb+uMc5FkkiUHAA--.14737S3;
 Tue, 20 Jun 2023 17:38:20 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S11; 
 Tue, 20 Jun 2023 17:38:18 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 09/46] target/loongarch: Implement xvhaddw/xvhsubw
Date: Tue, 20 Jun 2023 17:37:37 +0800
Message-Id: <20230620093814.123650-10-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S11
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
- XVHADDW.{H.B/W.H/D.W/Q.D/HU.BU/WU.HU/DU.WU/QU.DU};
- XVHSUBW.{H.B/W.H/D.W/Q.D/HU.BU/WU.HU/DU.WU/QU.DU}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     | 17 ++++
 target/loongarch/helper.h                    | 18 ++++
 target/loongarch/insn_trans/trans_lasx.c.inc | 30 +++++++
 target/loongarch/insns.decode                | 18 ++++
 target/loongarch/lasx_helper.c               | 90 ++++++++++++++++++++
 target/loongarch/lsx_helper.c                |  3 -
 target/loongarch/vec.h                       |  3 +
 7 files changed, 176 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 2a2993cb95..770359524e 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1765,6 +1765,23 @@ INSN_LASX(xvssub_hu,         xxx)
 INSN_LASX(xvssub_wu,         xxx)
 INSN_LASX(xvssub_du,         xxx)
 
+INSN_LASX(xvhaddw_h_b,       xxx)
+INSN_LASX(xvhaddw_w_h,       xxx)
+INSN_LASX(xvhaddw_d_w,       xxx)
+INSN_LASX(xvhaddw_q_d,       xxx)
+INSN_LASX(xvhaddw_hu_bu,     xxx)
+INSN_LASX(xvhaddw_wu_hu,     xxx)
+INSN_LASX(xvhaddw_du_wu,     xxx)
+INSN_LASX(xvhaddw_qu_du,     xxx)
+INSN_LASX(xvhsubw_h_b,       xxx)
+INSN_LASX(xvhsubw_w_h,       xxx)
+INSN_LASX(xvhsubw_d_w,       xxx)
+INSN_LASX(xvhsubw_q_d,       xxx)
+INSN_LASX(xvhsubw_hu_bu,     xxx)
+INSN_LASX(xvhsubw_wu_hu,     xxx)
+INSN_LASX(xvhsubw_du_wu,     xxx)
+INSN_LASX(xvhsubw_qu_du,     xxx)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index b9de77d926..db2deaff79 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -696,3 +696,21 @@ DEF_HELPER_4(vextrins_b, void, env, i32, i32, i32)
 DEF_HELPER_4(vextrins_h, void, env, i32, i32, i32)
 DEF_HELPER_4(vextrins_w, void, env, i32, i32, i32)
 DEF_HELPER_4(vextrins_d, void, env, i32, i32, i32)
+
+/* LoongArch LASX */
+DEF_HELPER_4(xvhaddw_h_b, void, env, i32, i32, i32)
+DEF_HELPER_4(xvhaddw_w_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvhaddw_d_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvhaddw_q_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvhaddw_hu_bu, void, env, i32, i32, i32)
+DEF_HELPER_4(xvhaddw_wu_hu, void, env, i32, i32, i32)
+DEF_HELPER_4(xvhaddw_du_wu, void, env, i32, i32, i32)
+DEF_HELPER_4(xvhaddw_qu_du, void, env, i32, i32, i32)
+DEF_HELPER_4(xvhsubw_h_b, void, env, i32, i32, i32)
+DEF_HELPER_4(xvhsubw_w_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvhsubw_d_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvhsubw_q_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvhsubw_hu_bu, void, env, i32, i32, i32)
+DEF_HELPER_4(xvhsubw_wu_hu, void, env, i32, i32, i32)
+DEF_HELPER_4(xvhsubw_du_wu, void, env, i32, i32, i32)
+DEF_HELPER_4(xvhsubw_qu_du, void, env, i32, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index ec68193686..aa0e35b228 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -15,6 +15,19 @@
 #define CHECK_ASXE
 #endif
 
+static bool gen_xxx(DisasContext *ctx, arg_xxx *a,
+                    void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32))
+{
+    TCGv_i32 xd = tcg_constant_i32(a->xd);
+    TCGv_i32 xj = tcg_constant_i32(a->xj);
+    TCGv_i32 xk = tcg_constant_i32(a->xk);
+
+    CHECK_ASXE;
+
+    func(cpu_env, xd, xj, xk);
+    return true;
+}
+
 static bool gvec_xxx(DisasContext *ctx, arg_xxx *a, MemOp mop,
                      void (*func)(unsigned, uint32_t, uint32_t,
                                   uint32_t, uint32_t, uint32_t))
@@ -148,6 +161,23 @@ TRANS(xvssub_hu, gvec_xxx, MO_16, tcg_gen_gvec_ussub)
 TRANS(xvssub_wu, gvec_xxx, MO_32, tcg_gen_gvec_ussub)
 TRANS(xvssub_du, gvec_xxx, MO_64, tcg_gen_gvec_ussub)
 
+TRANS(xvhaddw_h_b, gen_xxx, gen_helper_xvhaddw_h_b)
+TRANS(xvhaddw_w_h, gen_xxx, gen_helper_xvhaddw_w_h)
+TRANS(xvhaddw_d_w, gen_xxx, gen_helper_xvhaddw_d_w)
+TRANS(xvhaddw_q_d, gen_xxx, gen_helper_xvhaddw_q_d)
+TRANS(xvhaddw_hu_bu, gen_xxx, gen_helper_xvhaddw_hu_bu)
+TRANS(xvhaddw_wu_hu, gen_xxx, gen_helper_xvhaddw_wu_hu)
+TRANS(xvhaddw_du_wu, gen_xxx, gen_helper_xvhaddw_du_wu)
+TRANS(xvhaddw_qu_du, gen_xxx, gen_helper_xvhaddw_qu_du)
+TRANS(xvhsubw_h_b, gen_xxx, gen_helper_xvhsubw_h_b)
+TRANS(xvhsubw_w_h, gen_xxx, gen_helper_xvhsubw_w_h)
+TRANS(xvhsubw_d_w, gen_xxx, gen_helper_xvhsubw_d_w)
+TRANS(xvhsubw_q_d, gen_xxx, gen_helper_xvhsubw_q_d)
+TRANS(xvhsubw_hu_bu, gen_xxx, gen_helper_xvhsubw_hu_bu)
+TRANS(xvhsubw_wu_hu, gen_xxx, gen_helper_xvhsubw_wu_hu)
+TRANS(xvhsubw_du_wu, gen_xxx, gen_helper_xvhsubw_du_wu)
+TRANS(xvhsubw_qu_du, gen_xxx, gen_helper_xvhsubw_qu_du)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index be706fe0f7..48556b2267 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1358,6 +1358,24 @@ xvssub_hu        0111 01000100 11001 ..... ..... .....    @xxx
 xvssub_wu        0111 01000100 11010 ..... ..... .....    @xxx
 xvssub_du        0111 01000100 11011 ..... ..... .....    @xxx
 
+xvhaddw_h_b      0111 01000101 01000 ..... ..... .....    @xxx
+xvhaddw_w_h      0111 01000101 01001 ..... ..... .....    @xxx
+xvhaddw_d_w      0111 01000101 01010 ..... ..... .....    @xxx
+xvhaddw_q_d      0111 01000101 01011 ..... ..... .....    @xxx
+xvhaddw_hu_bu    0111 01000101 10000 ..... ..... .....    @xxx
+xvhaddw_wu_hu    0111 01000101 10001 ..... ..... .....    @xxx
+xvhaddw_du_wu    0111 01000101 10010 ..... ..... .....    @xxx
+xvhaddw_qu_du    0111 01000101 10011 ..... ..... .....    @xxx
+
+xvhsubw_h_b      0111 01000101 01100 ..... ..... .....    @xxx
+xvhsubw_w_h      0111 01000101 01101 ..... ..... .....    @xxx
+xvhsubw_d_w      0111 01000101 01110 ..... ..... .....    @xxx
+xvhsubw_q_d      0111 01000101 01111 ..... ..... .....    @xxx
+xvhsubw_hu_bu    0111 01000101 10100 ..... ..... .....    @xxx
+xvhsubw_wu_hu    0111 01000101 10101 ..... ..... .....    @xxx
+xvhsubw_du_wu    0111 01000101 10110 ..... ..... .....    @xxx
+xvhsubw_qu_du    0111 01000101 10111 ..... ..... .....    @xxx
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index 1754790a3a..d86381ff8a 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -4,3 +4,93 @@
  *
  * Copyright (c) 2023 Loongson Technology Corporation Limited
  */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/exec-all.h"
+#include "exec/helper-proto.h"
+#include "internals.h"
+#include "vec.h"
+
+#define XDO_ODD_EVEN(NAME, BIT, E1, E2, DO_OP)                       \
+void HELPER(NAME)(CPULoongArchState *env,                            \
+                  uint32_t xd, uint32_t xj, uint32_t xk)             \
+{                                                                    \
+    int i;                                                           \
+    XReg *Xd = &(env->fpr[xd].xreg);                                 \
+    XReg *Xj = &(env->fpr[xj].xreg);                                 \
+    XReg *Xk = &(env->fpr[xk].xreg);                                 \
+    typedef __typeof(Xd->E1(0)) TD;                                  \
+                                                                     \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                           \
+        Xd->E1(i) = DO_OP((TD)Xj->E2(2 * i + 1), (TD)Xk->E2(2 * i)); \
+    }                                                                \
+}
+
+XDO_ODD_EVEN(xvhaddw_h_b, 16, XH, XB, DO_ADD)
+XDO_ODD_EVEN(xvhaddw_w_h, 32, XW, XH, DO_ADD)
+XDO_ODD_EVEN(xvhaddw_d_w, 64, XD, XW, DO_ADD)
+
+void HELPER(xvhaddw_q_d)(CPULoongArchState *env,
+                         uint32_t xd, uint32_t xj, uint32_t xk)
+{
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+    XReg *Xk = &(env->fpr[xk].xreg);
+
+    Xd->XQ(0) = int128_add(int128_makes64(Xj->XD(1)),
+                           int128_makes64(Xk->XD(0)));
+    Xd->XQ(1) = int128_add(int128_makes64(Xj->XD(3)),
+                           int128_makes64(Xk->XD(2)));
+}
+
+XDO_ODD_EVEN(xvhsubw_h_b, 16, XH, XB, DO_SUB)
+XDO_ODD_EVEN(xvhsubw_w_h, 32, XW, XH, DO_SUB)
+XDO_ODD_EVEN(xvhsubw_d_w, 64, XD, XW, DO_SUB)
+
+void HELPER(xvhsubw_q_d)(CPULoongArchState *env,
+                         uint32_t xd, uint32_t xj, uint32_t xk)
+{
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+    XReg *Xk = &(env->fpr[xk].xreg);
+
+    Xd->XQ(0) = int128_sub(int128_makes64(Xj->XD(1)),
+                           int128_makes64(Xk->XD(0)));
+    Xd->XQ(1) = int128_sub(int128_makes64(Xj->XD(3)),
+                           int128_makes64(Xk->XD(2)));
+}
+
+XDO_ODD_EVEN(xvhaddw_hu_bu, 16, UXH, UXB, DO_ADD)
+XDO_ODD_EVEN(xvhaddw_wu_hu, 32, UXW, UXH, DO_ADD)
+XDO_ODD_EVEN(xvhaddw_du_wu, 64, UXD, UXW, DO_ADD)
+
+void HELPER(xvhaddw_qu_du)(CPULoongArchState *env,
+                           uint32_t xd, uint32_t xj, uint32_t xk)
+{
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+    XReg *Xk = &(env->fpr[xk].xreg);
+
+    Xd->XQ(0) = int128_add(int128_make64(Xj->UXD(1)),
+                           int128_make64(Xk->UXD(0)));
+    Xd->XQ(1) = int128_add(int128_make64(Xj->UXD(3)),
+                           int128_make64(Xk->UXD(2)));
+}
+
+XDO_ODD_EVEN(xvhsubw_hu_bu, 16, UXH, UXB, DO_SUB)
+XDO_ODD_EVEN(xvhsubw_wu_hu, 32, UXW, UXH, DO_SUB)
+XDO_ODD_EVEN(xvhsubw_du_wu, 64, UXD, UXW, DO_SUB)
+
+void HELPER(xvhsubw_qu_du)(CPULoongArchState *env,
+                           uint32_t xd, uint32_t xj, uint32_t xk)
+{
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+    XReg *Xk = &(env->fpr[xk].xreg);
+
+    Xd->XQ(0) = int128_sub(int128_make64(Xj->UXD(1)),
+                           int128_make64(Xk->UXD(0)));
+    Xd->XQ(1) = int128_sub(int128_make64(Xj->UXD(3)),
+                           int128_make64(Xk->UXD(2)));
+}
diff --git a/target/loongarch/lsx_helper.c b/target/loongarch/lsx_helper.c
index b231a2798b..d79a65dfe2 100644
--- a/target/loongarch/lsx_helper.c
+++ b/target/loongarch/lsx_helper.c
@@ -14,9 +14,6 @@
 #include "tcg/tcg.h"
 #include "vec.h"
 
-#define DO_ADD(a, b)  (a + b)
-#define DO_SUB(a, b)  (a - b)
-
 #define DO_ODD_EVEN(NAME, BIT, E1, E2, DO_OP)                        \
 void HELPER(NAME)(CPULoongArchState *env,                            \
                   uint32_t vd, uint32_t vj, uint32_t vk)             \
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index a89cdb8d45..7e71035e50 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -48,4 +48,7 @@
 #define XQ(x)  XQ[x]
 #endif /* HOST_BIG_ENDIAN */
 
+#define DO_ADD(a, b)  (a + b)
+#define DO_SUB(a, b)  (a - b)
+
 #endif /* LOONGARCH_VEC_H */
-- 
2.39.1


