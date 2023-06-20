Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCB9736831
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:45:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXot-000761-BQ; Tue, 20 Jun 2023 05:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXor-00075g-9b
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:37 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXoo-0006K8-GR
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:37 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxRumOc5FkoSUHAA--.12862S3;
 Tue, 20 Jun 2023 17:38:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S14; 
 Tue, 20 Jun 2023 17:38:21 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 12/46] target/loongarch: Implement xvabsd
Date: Tue, 20 Jun 2023 17:37:40 +0800
Message-Id: <20230620093814.123650-13-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S14
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
- XVABSD.{B/H/W/D}[U].

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  9 +++
 target/loongarch/helper.h                    |  9 +++
 target/loongarch/insn_trans/trans_lasx.c.inc | 81 ++++++++++++++++++++
 target/loongarch/insns.decode                |  9 +++
 target/loongarch/lasx_helper.c               |  9 +++
 target/loongarch/lsx_helper.c                |  2 -
 target/loongarch/vec.h                       |  2 +
 7 files changed, 119 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index d804caaee0..d6b6b8ddd6 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1842,6 +1842,15 @@ INSN_LASX(xvavgr_hu,         xxx)
 INSN_LASX(xvavgr_wu,         xxx)
 INSN_LASX(xvavgr_du,         xxx)
 
+INSN_LASX(xvabsd_b,          xxx)
+INSN_LASX(xvabsd_h,          xxx)
+INSN_LASX(xvabsd_w,          xxx)
+INSN_LASX(xvabsd_d,          xxx)
+INSN_LASX(xvabsd_bu,         xxx)
+INSN_LASX(xvabsd_hu,         xxx)
+INSN_LASX(xvabsd_wu,         xxx)
+INSN_LASX(xvabsd_du,         xxx)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index feeaa92447..3ec7717c88 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -777,3 +777,12 @@ DEF_HELPER_FLAGS_4(xvavgr_bu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(xvavgr_hu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(xvavgr_wu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(xvavgr_du, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(xvabsd_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvabsd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvabsd_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvabsd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvabsd_bu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvabsd_hu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvabsd_wu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvabsd_du, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 4a8bcf618f..8f7ff2cba6 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -750,6 +750,87 @@ TRANS(xvavgr_hu, gvec_xxx, MO_16, do_xvavgr_u)
 TRANS(xvavgr_wu, gvec_xxx, MO_32, do_xvavgr_u)
 TRANS(xvavgr_du, gvec_xxx, MO_64, do_xvavgr_u)
 
+static void do_xvabsd_s(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                        uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_smax_vec, INDEX_op_smin_vec, INDEX_op_sub_vec, 0
+        };
+    static const GVecGen3 op[4] = {
+        {
+            .fniv = gen_vabsd_s,
+            .fno = gen_helper_xvabsd_b,
+            .opt_opc = vecop_list,
+            .vece = MO_8
+        },
+        {
+            .fniv = gen_vabsd_s,
+            .fno = gen_helper_xvabsd_h,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fniv = gen_vabsd_s,
+            .fno = gen_helper_xvabsd_w,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fniv = gen_vabsd_s,
+            .fno = gen_helper_xvabsd_d,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+static void do_xvabsd_u(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                        uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_umax_vec, INDEX_op_umin_vec, INDEX_op_sub_vec, 0
+        };
+    static const GVecGen3 op[4] = {
+        {
+            .fniv = gen_vabsd_u,
+            .fno = gen_helper_xvabsd_bu,
+            .opt_opc = vecop_list,
+            .vece = MO_8
+        },
+        {
+            .fniv = gen_vabsd_u,
+            .fno = gen_helper_xvabsd_hu,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fniv = gen_vabsd_u,
+            .fno = gen_helper_xvabsd_wu,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fniv = gen_vabsd_u,
+            .fno = gen_helper_xvabsd_du,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvabsd_b, gvec_xxx, MO_8, do_xvabsd_s)
+TRANS(xvabsd_h, gvec_xxx, MO_16, do_xvabsd_s)
+TRANS(xvabsd_w, gvec_xxx, MO_32, do_xvabsd_s)
+TRANS(xvabsd_d, gvec_xxx, MO_64, do_xvabsd_s)
+TRANS(xvabsd_bu, gvec_xxx, MO_8, do_xvabsd_u)
+TRANS(xvabsd_hu, gvec_xxx, MO_16, do_xvabsd_u)
+TRANS(xvabsd_wu, gvec_xxx, MO_32, do_xvabsd_u)
+TRANS(xvabsd_du, gvec_xxx, MO_64, do_xvabsd_u)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 0057aaf1d4..8bd029a6e8 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1438,6 +1438,15 @@ xvavgr_hu        0111 01000110 10101 ..... ..... .....    @xxx
 xvavgr_wu        0111 01000110 10110 ..... ..... .....    @xxx
 xvavgr_du        0111 01000110 10111 ..... ..... .....    @xxx
 
+xvabsd_b         0111 01000110 00000 ..... ..... .....    @xxx
+xvabsd_h         0111 01000110 00001 ..... ..... .....    @xxx
+xvabsd_w         0111 01000110 00010 ..... ..... .....    @xxx
+xvabsd_d         0111 01000110 00011 ..... ..... .....    @xxx
+xvabsd_bu        0111 01000110 00100 ..... ..... .....    @xxx
+xvabsd_hu        0111 01000110 00101 ..... ..... .....    @xxx
+xvabsd_wu        0111 01000110 00110 ..... ..... .....    @xxx
+xvabsd_du        0111 01000110 00111 ..... ..... .....    @xxx
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index 8e1bcdb764..e9d38d83bc 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -337,3 +337,12 @@ XDO_3OP(xvavgr_bu, 8, UXB, DO_VAVGR)
 XDO_3OP(xvavgr_hu, 16, UXH, DO_VAVGR)
 XDO_3OP(xvavgr_wu, 32, UXW, DO_VAVGR)
 XDO_3OP(xvavgr_du, 64, UXD, DO_VAVGR)
+
+XDO_3OP(xvabsd_b, 8, XB, DO_VABSD)
+XDO_3OP(xvabsd_h, 16, XH, DO_VABSD)
+XDO_3OP(xvabsd_w, 32, XW, DO_VABSD)
+XDO_3OP(xvabsd_d, 64, XD, DO_VABSD)
+XDO_3OP(xvabsd_bu, 8, UXB, DO_VABSD)
+XDO_3OP(xvabsd_hu, 16, UXH, DO_VABSD)
+XDO_3OP(xvabsd_wu, 32, UXW, DO_VABSD)
+XDO_3OP(xvabsd_du, 64, UXD, DO_VABSD)
diff --git a/target/loongarch/lsx_helper.c b/target/loongarch/lsx_helper.c
index d79a65dfe2..72e2306f0c 100644
--- a/target/loongarch/lsx_helper.c
+++ b/target/loongarch/lsx_helper.c
@@ -309,8 +309,6 @@ DO_3OP(vavgr_hu, 16, UH, DO_VAVGR)
 DO_3OP(vavgr_wu, 32, UW, DO_VAVGR)
 DO_3OP(vavgr_du, 64, UD, DO_VAVGR)
 
-#define DO_VABSD(a, b)  ((a > b) ? (a -b) : (b-a))
-
 DO_3OP(vabsd_b, 8, B, DO_VABSD)
 DO_3OP(vabsd_h, 16, H, DO_VABSD)
 DO_3OP(vabsd_w, 32, W, DO_VABSD)
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index 2a9c312e3d..652d46c157 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -54,4 +54,6 @@
 #define DO_VAVG(a, b)  ((a >> 1) + (b >> 1) + (a & b & 1))
 #define DO_VAVGR(a, b) ((a >> 1) + (b >> 1) + ((a | b) & 1))
 
+#define DO_VABSD(a, b)  ((a > b) ? (a - b) : (b - a))
+
 #endif /* LOONGARCH_VEC_H */
-- 
2.39.1


