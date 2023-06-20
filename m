Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F88273682E
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:44:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXot-00076N-Ta; Tue, 20 Jun 2023 05:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXor-00075f-8Y
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:37 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXop-0006KH-2s
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:37 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxMuiOc5FkoyUHAA--.655S3;
 Tue, 20 Jun 2023 17:38:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S15; 
 Tue, 20 Jun 2023 17:38:22 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 13/46] target/loongarch: Implement xvadda
Date: Tue, 20 Jun 2023 17:37:41 +0800
Message-Id: <20230620093814.123650-14-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S15
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
- XVADDA.{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  5 +++
 target/loongarch/helper.h                    |  5 +++
 target/loongarch/insn_trans/trans_lasx.c.inc | 41 ++++++++++++++++++++
 target/loongarch/insns.decode                |  5 +++
 target/loongarch/lasx_helper.c               | 17 ++++++++
 target/loongarch/lsx_helper.c                |  2 -
 target/loongarch/vec.h                       |  2 +
 7 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index d6b6b8ddd6..cc92f0e763 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1851,6 +1851,11 @@ INSN_LASX(xvabsd_hu,         xxx)
 INSN_LASX(xvabsd_wu,         xxx)
 INSN_LASX(xvabsd_du,         xxx)
 
+INSN_LASX(xvadda_b,          xxx)
+INSN_LASX(xvadda_h,          xxx)
+INSN_LASX(xvadda_w,          xxx)
+INSN_LASX(xvadda_d,          xxx)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 3ec7717c88..67ef7491c4 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -786,3 +786,8 @@ DEF_HELPER_FLAGS_4(xvabsd_bu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(xvabsd_hu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(xvabsd_wu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(xvabsd_du, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(xvadda_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvadda_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvadda_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvadda_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 8f7ff2cba6..4b2e50de68 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -831,6 +831,47 @@ TRANS(xvabsd_hu, gvec_xxx, MO_16, do_xvabsd_u)
 TRANS(xvabsd_wu, gvec_xxx, MO_32, do_xvabsd_u)
 TRANS(xvabsd_du, gvec_xxx, MO_64, do_xvabsd_u)
 
+static void do_xvadda(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                      uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_abs_vec, INDEX_op_add_vec, 0
+        };
+    static const GVecGen3 op[4] = {
+        {
+            .fniv = gen_vadda,
+            .fno = gen_helper_xvadda_b,
+            .opt_opc = vecop_list,
+            .vece = MO_8
+        },
+        {
+            .fniv = gen_vadda,
+            .fno = gen_helper_xvadda_h,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fniv = gen_vadda,
+            .fno = gen_helper_xvadda_w,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fniv = gen_vadda,
+            .fno = gen_helper_xvadda_d,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvadda_b, gvec_xxx, MO_8, do_xvadda)
+TRANS(xvadda_h, gvec_xxx, MO_16, do_xvadda)
+TRANS(xvadda_w, gvec_xxx, MO_32, do_xvadda)
+TRANS(xvadda_d, gvec_xxx, MO_64, do_xvadda)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 8bd029a6e8..f8a17f262a 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1447,6 +1447,11 @@ xvabsd_hu        0111 01000110 00101 ..... ..... .....    @xxx
 xvabsd_wu        0111 01000110 00110 ..... ..... .....    @xxx
 xvabsd_du        0111 01000110 00111 ..... ..... .....    @xxx
 
+xvadda_b         0111 01000101 11000 ..... ..... .....    @xxx
+xvadda_h         0111 01000101 11001 ..... ..... .....    @xxx
+xvadda_w         0111 01000101 11010 ..... ..... .....    @xxx
+xvadda_d         0111 01000101 11011 ..... ..... .....    @xxx
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index e9d38d83bc..52c230a681 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -346,3 +346,20 @@ XDO_3OP(xvabsd_bu, 8, UXB, DO_VABSD)
 XDO_3OP(xvabsd_hu, 16, UXH, DO_VABSD)
 XDO_3OP(xvabsd_wu, 32, UXW, DO_VABSD)
 XDO_3OP(xvabsd_du, 64, UXD, DO_VABSD)
+
+#define XDO_VADDA(NAME, BIT, E, DO_OP)                      \
+void HELPER(NAME)(void *xd, void *xj, void *xk, uint32_t v) \
+{                                                           \
+    int i;                                                  \
+    XReg *Xd = (XReg *)xd;                                  \
+    XReg *Xj = (XReg *)xj;                                  \
+    XReg *Xk = (XReg *)xk;                                  \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                  \
+        Xd->E(i) = DO_OP(Xj->E(i)) + DO_OP(Xk->E(i));       \
+    }                                                       \
+}
+
+XDO_VADDA(xvadda_b, 8, XB, DO_VABS)
+XDO_VADDA(xvadda_h, 16, XH, DO_VABS)
+XDO_VADDA(xvadda_w, 32, XW, DO_VABS)
+XDO_VADDA(xvadda_d, 64, XD, DO_VABS)
diff --git a/target/loongarch/lsx_helper.c b/target/loongarch/lsx_helper.c
index 72e2306f0c..72120c04a4 100644
--- a/target/loongarch/lsx_helper.c
+++ b/target/loongarch/lsx_helper.c
@@ -318,8 +318,6 @@ DO_3OP(vabsd_hu, 16, UH, DO_VABSD)
 DO_3OP(vabsd_wu, 32, UW, DO_VABSD)
 DO_3OP(vabsd_du, 64, UD, DO_VABSD)
 
-#define DO_VABS(a)  ((a < 0) ? (-a) : (a))
-
 #define DO_VADDA(NAME, BIT, E, DO_OP)                       \
 void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t v) \
 {                                                           \
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index 652d46c157..20b86c3119 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -56,4 +56,6 @@
 
 #define DO_VABSD(a, b)  ((a > b) ? (a - b) : (b - a))
 
+#define DO_VABS(a)      ((a < 0) ? (-a) : (a))
+
 #endif /* LOONGARCH_VEC_H */
-- 
2.39.1


