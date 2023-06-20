Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4B673680D
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:42:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXoz-00078O-5p; Tue, 20 Jun 2023 05:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXox-00077f-Ba
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:43 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXov-0006MM-Ay
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:43 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxPuuTc5FktSUHAA--.14626S3;
 Tue, 20 Jun 2023 17:38:27 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S23; 
 Tue, 20 Jun 2023 17:38:26 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 21/46] target/loongarch: Implement xvsigncov
Date: Tue, 20 Jun 2023 17:37:49 +0800
Message-Id: <20230620093814.123650-22-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S23
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
- XVSIGNCOV.{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  5 +++
 target/loongarch/helper.h                    |  5 +++
 target/loongarch/insn_trans/trans_lasx.c.inc | 41 ++++++++++++++++++++
 target/loongarch/insns.decode                |  5 +++
 target/loongarch/lasx_helper.c               |  5 +++
 target/loongarch/lsx_helper.c                |  2 -
 target/loongarch/vec.h                       |  2 +
 7 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 1897aa7ba1..d0ccf3e86c 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2009,6 +2009,11 @@ INSN_LASX(vext2xv_wu_hu,     xx)
 INSN_LASX(vext2xv_du_hu,     xx)
 INSN_LASX(vext2xv_du_wu,     xx)
 
+INSN_LASX(xvsigncov_b,       xxx)
+INSN_LASX(xvsigncov_h,       xxx)
+INSN_LASX(xvsigncov_w,       xxx)
+INSN_LASX(xvsigncov_d,       xxx)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 7a303ee3f1..53a33703b3 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -917,3 +917,8 @@ DEF_HELPER_3(vext2xv_du_bu, void, env, i32, i32)
 DEF_HELPER_3(vext2xv_wu_hu, void, env, i32, i32)
 DEF_HELPER_3(vext2xv_du_hu, void, env, i32, i32)
 DEF_HELPER_3(vext2xv_du_wu, void, env, i32, i32)
+
+DEF_HELPER_FLAGS_4(xvsigncov_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvsigncov_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvsigncov_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvsigncov_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index c04469af75..9c24e82ac0 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -1866,6 +1866,47 @@ TRANS(vext2xv_wu_hu, gen_xx, gen_helper_vext2xv_wu_hu)
 TRANS(vext2xv_du_hu, gen_xx, gen_helper_vext2xv_du_hu)
 TRANS(vext2xv_du_wu, gen_xx, gen_helper_vext2xv_du_wu)
 
+static void do_xvsigncov(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                         uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_neg_vec, INDEX_op_cmpsel_vec, 0
+        };
+    static const GVecGen3 op[4] = {
+        {
+            .fniv = gen_vsigncov,
+            .fno = gen_helper_xvsigncov_b,
+            .opt_opc = vecop_list,
+            .vece = MO_8
+        },
+        {
+            .fniv = gen_vsigncov,
+            .fno = gen_helper_xvsigncov_h,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fniv = gen_vsigncov,
+            .fno = gen_helper_xvsigncov_w,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fniv = gen_vsigncov,
+            .fno = gen_helper_xvsigncov_d,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvsigncov_b, gvec_xxx, MO_8, do_xvsigncov)
+TRANS(xvsigncov_h, gvec_xxx, MO_16, do_xvsigncov)
+TRANS(xvsigncov_w, gvec_xxx, MO_32, do_xvsigncov)
+TRANS(xvsigncov_d, gvec_xxx, MO_64, do_xvsigncov)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 9f1cb04368..887d7f5a90 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1613,6 +1613,11 @@ vext2xv_wu_hu    0111 01101001 11110 01101 ..... .....    @xx
 vext2xv_du_hu    0111 01101001 11110 01110 ..... .....    @xx
 vext2xv_du_wu    0111 01101001 11110 01111 ..... .....    @xx
 
+xvsigncov_b      0111 01010010 11100 ..... ..... .....    @xxx
+xvsigncov_h      0111 01010010 11101 ..... ..... .....    @xxx
+xvsigncov_w      0111 01010010 11110 ..... ..... .....    @xxx
+xvsigncov_d      0111 01010010 11111 ..... ..... .....    @xxx
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index ca82d03ff4..db7905fa4d 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -704,3 +704,8 @@ VEXT2XV(vext2xv_du_bu, 64, UXD, UXB)
 VEXT2XV(vext2xv_wu_hu, 32, UXW, UXH)
 VEXT2XV(vext2xv_du_hu, 64, UXD, UXH)
 VEXT2XV(vext2xv_du_wu, 64, UXD, UXW)
+
+XDO_3OP(xvsigncov_b, 8, XB, DO_SIGNCOV)
+XDO_3OP(xvsigncov_h, 16, XH, DO_SIGNCOV)
+XDO_3OP(xvsigncov_w, 32, XW, DO_SIGNCOV)
+XDO_3OP(xvsigncov_d, 64, XD, DO_SIGNCOV)
diff --git a/target/loongarch/lsx_helper.c b/target/loongarch/lsx_helper.c
index 5aac0c9ef5..dadba47513 100644
--- a/target/loongarch/lsx_helper.c
+++ b/target/loongarch/lsx_helper.c
@@ -648,8 +648,6 @@ VEXTH(vexth_hu_bu, 16, UH, UB)
 VEXTH(vexth_wu_hu, 32, UW, UH)
 VEXTH(vexth_du_wu, 64, UD, UW)
 
-#define DO_SIGNCOV(a, b)  (a == 0 ? 0 : a < 0 ? -b : b)
-
 DO_3OP(vsigncov_b, 8, B, DO_SIGNCOV)
 DO_3OP(vsigncov_h, 16, H, DO_SIGNCOV)
 DO_3OP(vsigncov_w, 32, W, DO_SIGNCOV)
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index c748957158..f6ad3f78dd 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -73,4 +73,6 @@
 #define DO_REM(N, M)  (unlikely(M == 0) ? 0 :\
         unlikely((N == -N) && (M == (__typeof(N))(-1))) ? 0 : N % M)
 
+#define DO_SIGNCOV(a, b)  (a == 0 ? 0 : a < 0 ? -b : b)
+
 #endif /* LOONGARCH_VEC_H */
-- 
2.39.1


