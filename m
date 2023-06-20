Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 805787367FD
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:40:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXou-00076i-Ig; Tue, 20 Jun 2023 05:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXot-00076J-9B
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:39 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXoq-0006La-Vm
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:39 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxzOqQc5FkrSUHAA--.14640S3;
 Tue, 20 Jun 2023 17:38:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S19; 
 Tue, 20 Jun 2023 17:38:23 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 17/46] target/loongarch; Implement xvdiv/xvmod
Date: Tue, 20 Jun 2023 17:37:45 +0800
Message-Id: <20230620093814.123650-18-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S19
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
- XVDIV.{B/H/W/D}[U];
- XVMOD.{B/H/W/D}[U].

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     | 17 +++++++++++
 target/loongarch/helper.h                    | 17 +++++++++++
 target/loongarch/insn_trans/trans_lasx.c.inc | 17 +++++++++++
 target/loongarch/insns.decode                | 17 +++++++++++
 target/loongarch/lasx_helper.c               | 30 ++++++++++++++++++++
 target/loongarch/lsx_helper.c                |  7 -----
 target/loongarch/vec.h                       |  7 +++++
 7 files changed, 105 insertions(+), 7 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index ddfc4921b9..83efde440f 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1961,6 +1961,23 @@ INSN_LASX(xvmaddwod_w_hu_h,  xxx)
 INSN_LASX(xvmaddwod_d_wu_w,  xxx)
 INSN_LASX(xvmaddwod_q_du_d,  xxx)
 
+INSN_LASX(xvdiv_b,           xxx)
+INSN_LASX(xvdiv_h,           xxx)
+INSN_LASX(xvdiv_w,           xxx)
+INSN_LASX(xvdiv_d,           xxx)
+INSN_LASX(xvdiv_bu,          xxx)
+INSN_LASX(xvdiv_hu,          xxx)
+INSN_LASX(xvdiv_wu,          xxx)
+INSN_LASX(xvdiv_du,          xxx)
+INSN_LASX(xvmod_b,           xxx)
+INSN_LASX(xvmod_h,           xxx)
+INSN_LASX(xvmod_w,           xxx)
+INSN_LASX(xvmod_d,           xxx)
+INSN_LASX(xvmod_bu,          xxx)
+INSN_LASX(xvmod_hu,          xxx)
+INSN_LASX(xvmod_wu,          xxx)
+INSN_LASX(xvmod_du,          xxx)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 0dc4cc18da..95c7ecba3b 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -869,3 +869,20 @@ DEF_HELPER_FLAGS_4(xvmaddwev_d_wu_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(xvmaddwod_h_bu_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(xvmaddwod_w_hu_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(xvmaddwod_d_wu_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_4(xvdiv_b, void, env, i32, i32, i32)
+DEF_HELPER_4(xvdiv_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvdiv_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvdiv_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvdiv_bu, void, env, i32, i32, i32)
+DEF_HELPER_4(xvdiv_hu, void, env, i32, i32, i32)
+DEF_HELPER_4(xvdiv_wu, void, env, i32, i32, i32)
+DEF_HELPER_4(xvdiv_du, void, env, i32, i32, i32)
+DEF_HELPER_4(xvmod_b, void, env, i32, i32, i32)
+DEF_HELPER_4(xvmod_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvmod_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvmod_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvmod_bu, void, env, i32, i32, i32)
+DEF_HELPER_4(xvmod_hu, void, env, i32, i32, i32)
+DEF_HELPER_4(xvmod_wu, void, env, i32, i32, i32)
+DEF_HELPER_4(xvmod_du, void, env, i32, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 78ba31b8c2..930872c939 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -1730,6 +1730,23 @@ TRANS(xvmaddwod_h_bu_b, gvec_xxx, MO_8, do_xvmaddwod_u_s)
 TRANS(xvmaddwod_w_hu_h, gvec_xxx, MO_16, do_xvmaddwod_u_s)
 TRANS(xvmaddwod_d_wu_w, gvec_xxx, MO_32, do_xvmaddwod_u_s)
 
+TRANS(xvdiv_b, gen_xxx, gen_helper_xvdiv_b)
+TRANS(xvdiv_h, gen_xxx, gen_helper_xvdiv_h)
+TRANS(xvdiv_w, gen_xxx, gen_helper_xvdiv_w)
+TRANS(xvdiv_d, gen_xxx, gen_helper_xvdiv_d)
+TRANS(xvdiv_bu, gen_xxx, gen_helper_xvdiv_bu)
+TRANS(xvdiv_hu, gen_xxx, gen_helper_xvdiv_hu)
+TRANS(xvdiv_wu, gen_xxx, gen_helper_xvdiv_wu)
+TRANS(xvdiv_du, gen_xxx, gen_helper_xvdiv_du)
+TRANS(xvmod_b, gen_xxx, gen_helper_xvmod_b)
+TRANS(xvmod_h, gen_xxx, gen_helper_xvmod_h)
+TRANS(xvmod_w, gen_xxx, gen_helper_xvmod_w)
+TRANS(xvmod_d, gen_xxx, gen_helper_xvmod_d)
+TRANS(xvmod_bu, gen_xxx, gen_helper_xvmod_bu)
+TRANS(xvmod_hu, gen_xxx, gen_helper_xvmod_hu)
+TRANS(xvmod_wu, gen_xxx, gen_helper_xvmod_wu)
+TRANS(xvmod_du, gen_xxx, gen_helper_xvmod_du)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index cc210314ff..0bd4e7709a 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1561,6 +1561,23 @@ xvmaddwod_w_hu_h 0111 01001011 11101 ..... ..... .....    @xxx
 xvmaddwod_d_wu_w 0111 01001011 11110 ..... ..... .....    @xxx
 xvmaddwod_q_du_d 0111 01001011 11111 ..... ..... .....    @xxx
 
+xvdiv_b          0111 01001110 00000 ..... ..... .....    @xxx
+xvdiv_h          0111 01001110 00001 ..... ..... .....    @xxx
+xvdiv_w          0111 01001110 00010 ..... ..... .....    @xxx
+xvdiv_d          0111 01001110 00011 ..... ..... .....    @xxx
+xvmod_b          0111 01001110 00100 ..... ..... .....    @xxx
+xvmod_h          0111 01001110 00101 ..... ..... .....    @xxx
+xvmod_w          0111 01001110 00110 ..... ..... .....    @xxx
+xvmod_d          0111 01001110 00111 ..... ..... .....    @xxx
+xvdiv_bu         0111 01001110 01000 ..... ..... .....    @xxx
+xvdiv_hu         0111 01001110 01001 ..... ..... .....    @xxx
+xvdiv_wu         0111 01001110 01010 ..... ..... .....    @xxx
+xvdiv_du         0111 01001110 01011 ..... ..... .....    @xxx
+xvmod_bu         0111 01001110 01100 ..... ..... .....    @xxx
+xvmod_hu         0111 01001110 01101 ..... ..... .....    @xxx
+xvmod_wu         0111 01001110 01110 ..... ..... .....    @xxx
+xvmod_du         0111 01001110 01111 ..... ..... .....    @xxx
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index df85fa04f0..d4a4a7659a 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -571,3 +571,33 @@ void HELPER(NAME)(void *xd, void *xj, void *xk, uint32_t v) \
 XVMADDWOD_U_S(xvmaddwod_h_bu_b, 16, XH, UXH, XB, UXB, DO_MUL)
 XVMADDWOD_U_S(xvmaddwod_w_hu_h, 32, XW, UXW, XH, UXH, DO_MUL)
 XVMADDWOD_U_S(xvmaddwod_d_wu_w, 64, XD, UXD, XW, UXW, DO_MUL)
+
+#define XVDIV(NAME, BIT, E, DO_OP)                          \
+void HELPER(NAME)(CPULoongArchState *env,                   \
+                  uint32_t xd, uint32_t xj, uint32_t xk)    \
+{                                                           \
+    int i;                                                  \
+    XReg *Xd = &(env->fpr[xd].xreg);                        \
+    XReg *Xj = &(env->fpr[xj].xreg);                        \
+    XReg *Xk = &(env->fpr[xk].xreg);                        \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                  \
+        Xd->E(i) = DO_OP(Xj->E(i), Xk->E(i));               \
+    }                                                       \
+}
+
+XVDIV(xvdiv_b, 8, XB, DO_DIV)
+XVDIV(xvdiv_h, 16, XH, DO_DIV)
+XVDIV(xvdiv_w, 32, XW, DO_DIV)
+XVDIV(xvdiv_d, 64, XD, DO_DIV)
+XVDIV(xvdiv_bu, 8, UXB, DO_DIVU)
+XVDIV(xvdiv_hu, 16, UXH, DO_DIVU)
+XVDIV(xvdiv_wu, 32, UXW, DO_DIVU)
+XVDIV(xvdiv_du, 64, UXD, DO_DIVU)
+XVDIV(xvmod_b, 8, XB, DO_REM)
+XVDIV(xvmod_h, 16, XH, DO_REM)
+XVDIV(xvmod_w, 32, XW, DO_REM)
+XVDIV(xvmod_d, 64, XD, DO_REM)
+XVDIV(xvmod_bu, 8, UXB, DO_REMU)
+XVDIV(xvmod_hu, 16, UXH, DO_REMU)
+XVDIV(xvmod_wu, 32, UXW, DO_REMU)
+XVDIV(xvmod_du, 64, UXD, DO_REMU)
diff --git a/target/loongarch/lsx_helper.c b/target/loongarch/lsx_helper.c
index d384fbef3a..5aac0c9ef5 100644
--- a/target/loongarch/lsx_helper.c
+++ b/target/loongarch/lsx_helper.c
@@ -546,13 +546,6 @@ VMADDWOD_U_S(vmaddwod_h_bu_b, 16, H, UH, B, UB, DO_MUL)
 VMADDWOD_U_S(vmaddwod_w_hu_h, 32, W, UW, H, UH, DO_MUL)
 VMADDWOD_U_S(vmaddwod_d_wu_w, 64, D, UD, W, UW, DO_MUL)
 
-#define DO_DIVU(N, M) (unlikely(M == 0) ? 0 : N / M)
-#define DO_REMU(N, M) (unlikely(M == 0) ? 0 : N % M)
-#define DO_DIV(N, M)  (unlikely(M == 0) ? 0 :\
-        unlikely((N == -N) && (M == (__typeof(N))(-1))) ? N : N / M)
-#define DO_REM(N, M)  (unlikely(M == 0) ? 0 :\
-        unlikely((N == -N) && (M == (__typeof(N))(-1))) ? 0 : N % M)
-
 #define VDIV(NAME, BIT, E, DO_OP)                           \
 void HELPER(NAME)(CPULoongArchState *env,                   \
                   uint32_t vd, uint32_t vj, uint32_t vk)    \
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index 06992410ad..c748957158 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -66,4 +66,11 @@
 #define DO_MADD(a, b, c)  (a + b * c)
 #define DO_MSUB(a, b, c)  (a - b * c)
 
+#define DO_DIVU(N, M) (unlikely(M == 0) ? 0 : N / M)
+#define DO_REMU(N, M) (unlikely(M == 0) ? 0 : N % M)
+#define DO_DIV(N, M)  (unlikely(M == 0) ? 0 :\
+        unlikely((N == -N) && (M == (__typeof(N))(-1))) ? N : N / M)
+#define DO_REM(N, M)  (unlikely(M == 0) ? 0 :\
+        unlikely((N == -N) && (M == (__typeof(N))(-1))) ? 0 : N % M)
+
 #endif /* LOONGARCH_VEC_H */
-- 
2.39.1


