Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74385736837
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:46:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXox-00077U-HO; Tue, 20 Jun 2023 05:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXou-00076g-0X
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:40 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXoq-0006KR-3u
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:39 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Ax3eqPc5FkqSUHAA--.14571S3;
 Tue, 20 Jun 2023 17:38:23 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S17; 
 Tue, 20 Jun 2023 17:38:22 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 15/46] target/loongarch: Implement xvmul/xvmuh/xvmulw{ev/od}
Date: Tue, 20 Jun 2023 17:37:43 +0800
Message-Id: <20230620093814.123650-16-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S17
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
- XVMUL.{B/H/W/D};
- XVMUH.{B/H/W/D}[U];
- XVMULW{EV/OD}.{H.B/W.H/D.W/Q.D}[U];
- XVMULW{EV/OD}.{H.BU.B/W.HU.H/D.WU.W/Q.DU.D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  38 +++
 target/loongarch/helper.h                    |  30 ++
 target/loongarch/insn_trans/trans_lasx.c.inc | 311 +++++++++++++++++++
 target/loongarch/insns.decode                |  38 +++
 target/loongarch/lasx_helper.c               |  74 +++++
 target/loongarch/lsx_helper.c                |   2 -
 target/loongarch/vec.h                       |   2 +
 7 files changed, 493 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index ff22fcb90e..e7c46bc3a2 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1889,6 +1889,44 @@ INSN_LASX(xvmini_hu,         xx_i)
 INSN_LASX(xvmini_wu,         xx_i)
 INSN_LASX(xvmini_du,         xx_i)
 
+INSN_LASX(xvmul_b,           xxx)
+INSN_LASX(xvmul_h,           xxx)
+INSN_LASX(xvmul_w,           xxx)
+INSN_LASX(xvmul_d,           xxx)
+INSN_LASX(xvmuh_b,           xxx)
+INSN_LASX(xvmuh_h,           xxx)
+INSN_LASX(xvmuh_w,           xxx)
+INSN_LASX(xvmuh_d,           xxx)
+INSN_LASX(xvmuh_bu,          xxx)
+INSN_LASX(xvmuh_hu,          xxx)
+INSN_LASX(xvmuh_wu,          xxx)
+INSN_LASX(xvmuh_du,          xxx)
+
+INSN_LASX(xvmulwev_h_b,      xxx)
+INSN_LASX(xvmulwev_w_h,      xxx)
+INSN_LASX(xvmulwev_d_w,      xxx)
+INSN_LASX(xvmulwev_q_d,      xxx)
+INSN_LASX(xvmulwod_h_b,      xxx)
+INSN_LASX(xvmulwod_w_h,      xxx)
+INSN_LASX(xvmulwod_d_w,      xxx)
+INSN_LASX(xvmulwod_q_d,      xxx)
+INSN_LASX(xvmulwev_h_bu,     xxx)
+INSN_LASX(xvmulwev_w_hu,     xxx)
+INSN_LASX(xvmulwev_d_wu,     xxx)
+INSN_LASX(xvmulwev_q_du,     xxx)
+INSN_LASX(xvmulwod_h_bu,     xxx)
+INSN_LASX(xvmulwod_w_hu,     xxx)
+INSN_LASX(xvmulwod_d_wu,     xxx)
+INSN_LASX(xvmulwod_q_du,     xxx)
+INSN_LASX(xvmulwev_h_bu_b,   xxx)
+INSN_LASX(xvmulwev_w_hu_h,   xxx)
+INSN_LASX(xvmulwev_d_wu_w,   xxx)
+INSN_LASX(xvmulwev_q_du_d,   xxx)
+INSN_LASX(xvmulwod_h_bu_b,   xxx)
+INSN_LASX(xvmulwod_w_hu_h,   xxx)
+INSN_LASX(xvmulwod_d_wu_w,   xxx)
+INSN_LASX(xvmulwod_q_du_d,   xxx)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index d5ebc0b963..88ae707027 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -809,3 +809,33 @@ DEF_HELPER_FLAGS_4(xvmaxi_bu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(xvmaxi_hu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(xvmaxi_wu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(xvmaxi_du, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_FLAGS_4(xvmuh_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmuh_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmuh_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmuh_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmuh_bu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmuh_hu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmuh_wu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmuh_du, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(xvmulwev_h_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmulwev_w_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmulwev_d_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmulwod_h_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmulwod_w_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmulwod_d_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(xvmulwev_h_bu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmulwev_w_hu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmulwev_d_wu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmulwod_h_bu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmulwod_w_hu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmulwod_d_wu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(xvmulwev_h_bu_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmulwev_w_hu_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmulwev_d_wu_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmulwod_h_bu_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmulwod_w_hu_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmulwod_d_wu_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index cdf3dcc161..d57d867f17 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -1052,6 +1052,317 @@ TRANS(xvmaxi_hu, gvec_xx_i, MO_16, do_xvmaxi_u)
 TRANS(xvmaxi_wu, gvec_xx_i, MO_32, do_xvmaxi_u)
 TRANS(xvmaxi_du, gvec_xx_i, MO_64, do_xvmaxi_u)
 
+TRANS(xvmul_b, gvec_xxx, MO_8, tcg_gen_gvec_mul)
+TRANS(xvmul_h, gvec_xxx, MO_16, tcg_gen_gvec_mul)
+TRANS(xvmul_w, gvec_xxx, MO_32, tcg_gen_gvec_mul)
+TRANS(xvmul_d, gvec_xxx, MO_64, tcg_gen_gvec_mul)
+
+static void do_xvmuh_s(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                       uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen3 op[4] = {
+        {
+            .fno = gen_helper_xvmuh_b,
+            .vece = MO_8
+        },
+        {
+            .fno = gen_helper_xvmuh_h,
+            .vece = MO_16
+        },
+        {
+            .fni4 = gen_vmuh_w,
+            .fno = gen_helper_xvmuh_w,
+            .vece = MO_32
+        },
+        {
+            .fni8 = gen_vmuh_d,
+            .fno = gen_helper_xvmuh_d,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvmuh_b, gvec_xxx, MO_8, do_xvmuh_s)
+TRANS(xvmuh_h, gvec_xxx, MO_16, do_xvmuh_s)
+TRANS(xvmuh_w, gvec_xxx, MO_32, do_xvmuh_s)
+TRANS(xvmuh_d, gvec_xxx, MO_64, do_xvmuh_s)
+
+static void do_xvmuh_u(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                       uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen3 op[4] = {
+        {
+            .fno = gen_helper_xvmuh_bu,
+            .vece = MO_8
+        },
+        {
+            .fno = gen_helper_xvmuh_hu,
+            .vece = MO_16
+        },
+        {
+            .fni4 = gen_vmuh_wu,
+            .fno = gen_helper_xvmuh_wu,
+            .vece = MO_32
+        },
+        {
+            .fni8 = gen_vmuh_du,
+            .fno = gen_helper_xvmuh_du,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvmuh_bu, gvec_xxx, MO_8, do_xvmuh_u)
+TRANS(xvmuh_hu, gvec_xxx, MO_16, do_xvmuh_u)
+TRANS(xvmuh_wu, gvec_xxx, MO_32, do_xvmuh_u)
+TRANS(xvmuh_du, gvec_xxx, MO_64, do_xvmuh_u)
+
+static void do_xvmulwev_s(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                          uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shli_vec, INDEX_op_sari_vec, INDEX_op_mul_vec, 0
+        };
+    static const GVecGen3 op[3] = {
+        {
+            .fniv = gen_vmulwev_s,
+            .fno = gen_helper_xvmulwev_h_b,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fni4 = gen_vmulwev_w_h,
+            .fniv = gen_vmulwev_s,
+            .fno = gen_helper_xvmulwev_w_h,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fni8 = gen_vmulwev_d_w,
+            .fniv = gen_vmulwev_s,
+            .fno = gen_helper_xvmulwev_d_w,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvmulwev_h_b, gvec_xxx, MO_8, do_xvmulwev_s)
+TRANS(xvmulwev_w_h, gvec_xxx, MO_16, do_xvmulwev_s)
+TRANS(xvmulwev_d_w, gvec_xxx, MO_32, do_xvmulwev_s)
+
+#define XVMUL_Q(NAME, FN, idx1, idx2)                     \
+static bool trans_## NAME(DisasContext *ctx, arg_xxx * a) \
+{                                                         \
+    TCGv_i64 rh, rl, arg1, arg2;                          \
+    int i;                                                \
+                                                          \
+    rh = tcg_temp_new_i64();                              \
+    rl = tcg_temp_new_i64();                              \
+    arg1 = tcg_temp_new_i64();                            \
+    arg2 = tcg_temp_new_i64();                            \
+                                                          \
+    for (i = 0; i < 2; i++) {                             \
+        get_xreg64(arg1, a->xj, idx1 + i * 2);            \
+        get_xreg64(arg2, a->xk, idx2 + i * 2);            \
+                                                          \
+        tcg_gen_## FN ##_i64(rl, rh, arg1, arg2);         \
+                                                          \
+        set_xreg64(rh, a->xd, 1 + i * 2);                 \
+        set_xreg64(rl, a->xd, 0 + i * 2);                 \
+    }                                                     \
+                                                          \
+    return true;                                          \
+}
+
+XVMUL_Q(xvmulwev_q_d, muls2, 0, 0)
+XVMUL_Q(xvmulwod_q_d, muls2, 1, 1)
+XVMUL_Q(xvmulwev_q_du, mulu2, 0, 0)
+XVMUL_Q(xvmulwod_q_du, mulu2, 1, 1)
+XVMUL_Q(xvmulwev_q_du_d, mulus2, 0, 0)
+XVMUL_Q(xvmulwod_q_du_d, mulus2, 1, 1)
+
+static void do_xvmulwod_s(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                          uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sari_vec, INDEX_op_mul_vec, 0
+        };
+    static const GVecGen3 op[3] = {
+        {
+            .fniv = gen_vmulwod_s,
+            .fno = gen_helper_xvmulwod_h_b,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fni4 = gen_vmulwod_w_h,
+            .fniv = gen_vmulwod_s,
+            .fno = gen_helper_xvmulwod_w_h,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fni8 = gen_vmulwod_d_w,
+            .fniv = gen_vmulwod_s,
+            .fno = gen_helper_xvmulwod_d_w,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+TRANS(xvmulwod_h_b, gvec_xxx, MO_8, do_xvmulwod_s)
+TRANS(xvmulwod_w_h, gvec_xxx, MO_16, do_xvmulwod_s)
+TRANS(xvmulwod_d_w, gvec_xxx, MO_32, do_xvmulwod_s)
+
+static void do_xvmulwev_u(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                          uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_mul_vec, 0
+        };
+    static const GVecGen3 op[3] = {
+        {
+            .fniv = gen_vmulwev_u,
+            .fno = gen_helper_xvmulwev_h_bu,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fni4 = gen_vmulwev_w_hu,
+            .fniv = gen_vmulwev_u,
+            .fno = gen_helper_xvmulwev_w_hu,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fni8 = gen_vmulwev_d_wu,
+            .fniv = gen_vmulwev_u,
+            .fno = gen_helper_xvmulwev_d_wu,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+TRANS(xvmulwev_h_bu, gvec_xxx, MO_8, do_xvmulwev_u)
+TRANS(xvmulwev_w_hu, gvec_xxx, MO_16, do_xvmulwev_u)
+TRANS(xvmulwev_d_wu, gvec_xxx, MO_32, do_xvmulwev_u)
+
+static void do_xvmulwod_u(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                          uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shri_vec, INDEX_op_mul_vec, 0
+        };
+    static const GVecGen3 op[3] = {
+        {
+            .fniv = gen_vmulwod_u,
+            .fno = gen_helper_xvmulwod_h_bu,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fni4 = gen_vmulwod_w_hu,
+            .fniv = gen_vmulwod_u,
+            .fno = gen_helper_xvmulwod_w_hu,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fni8 = gen_vmulwod_d_wu,
+            .fniv = gen_vmulwod_u,
+            .fno = gen_helper_xvmulwod_d_wu,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+TRANS(xvmulwod_h_bu, gvec_xxx, MO_8, do_xvmulwod_u)
+TRANS(xvmulwod_w_hu, gvec_xxx, MO_16, do_xvmulwod_u)
+TRANS(xvmulwod_d_wu, gvec_xxx, MO_32, do_xvmulwod_u)
+
+static void do_xvmulwev_u_s(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                            uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shli_vec, INDEX_op_sari_vec, INDEX_op_mul_vec, 0
+        };
+    static const GVecGen3 op[3] = {
+        {
+            .fniv = gen_vmulwev_u_s,
+            .fno = gen_helper_xvmulwev_h_bu_b,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fni4 = gen_vmulwev_w_hu_h,
+            .fniv = gen_vmulwev_u_s,
+            .fno = gen_helper_xvmulwev_w_hu_h,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fni8 = gen_vmulwev_d_wu_w,
+            .fniv = gen_vmulwev_u_s,
+            .fno = gen_helper_xvmulwev_d_wu_w,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+TRANS(xvmulwev_h_bu_b, gvec_xxx, MO_8, do_xvmulwev_u_s)
+TRANS(xvmulwev_w_hu_h, gvec_xxx, MO_16, do_xvmulwev_u_s)
+TRANS(xvmulwev_d_wu_w, gvec_xxx, MO_32, do_xvmulwev_u_s)
+
+static void do_xvmulwod_u_s(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                            uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shri_vec, INDEX_op_sari_vec, INDEX_op_mul_vec, 0
+        };
+    static const GVecGen3 op[3] = {
+        {
+            .fniv = gen_vmulwod_u_s,
+            .fno = gen_helper_xvmulwod_h_bu_b,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fni4 = gen_vmulwod_w_hu_h,
+            .fniv = gen_vmulwod_u_s,
+            .fno = gen_helper_xvmulwod_w_hu_h,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fni8 = gen_vmulwod_d_wu_w,
+            .fniv = gen_vmulwod_u_s,
+            .fno = gen_helper_xvmulwod_d_wu_w,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+TRANS(xvmulwod_h_bu_b, gvec_xxx, MO_8, do_xvmulwod_u_s)
+TRANS(xvmulwod_w_hu_h, gvec_xxx, MO_16, do_xvmulwod_u_s)
+TRANS(xvmulwod_d_wu_w, gvec_xxx, MO_32, do_xvmulwod_u_s)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 29666f7925..872eeed7a8 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1489,6 +1489,44 @@ xvmini_hu        0111 01101001 01101 ..... ..... .....    @xx_ui5
 xvmini_wu        0111 01101001 01110 ..... ..... .....    @xx_ui5
 xvmini_du        0111 01101001 01111 ..... ..... .....    @xx_ui5
 
+xvmul_b          0111 01001000 01000 ..... ..... .....    @xxx
+xvmul_h          0111 01001000 01001 ..... ..... .....    @xxx
+xvmul_w          0111 01001000 01010 ..... ..... .....    @xxx
+xvmul_d          0111 01001000 01011 ..... ..... .....    @xxx
+xvmuh_b          0111 01001000 01100 ..... ..... .....    @xxx
+xvmuh_h          0111 01001000 01101 ..... ..... .....    @xxx
+xvmuh_w          0111 01001000 01110 ..... ..... .....    @xxx
+xvmuh_d          0111 01001000 01111 ..... ..... .....    @xxx
+xvmuh_bu         0111 01001000 10000 ..... ..... .....    @xxx
+xvmuh_hu         0111 01001000 10001 ..... ..... .....    @xxx
+xvmuh_wu         0111 01001000 10010 ..... ..... .....    @xxx
+xvmuh_du         0111 01001000 10011 ..... ..... .....    @xxx
+
+xvmulwev_h_b     0111 01001001 00000 ..... ..... .....    @xxx
+xvmulwev_w_h     0111 01001001 00001 ..... ..... .....    @xxx
+xvmulwev_d_w     0111 01001001 00010 ..... ..... .....    @xxx
+xvmulwev_q_d     0111 01001001 00011 ..... ..... .....    @xxx
+xvmulwod_h_b     0111 01001001 00100 ..... ..... .....    @xxx
+xvmulwod_w_h     0111 01001001 00101 ..... ..... .....    @xxx
+xvmulwod_d_w     0111 01001001 00110 ..... ..... .....    @xxx
+xvmulwod_q_d     0111 01001001 00111 ..... ..... .....    @xxx
+xvmulwev_h_bu    0111 01001001 10000 ..... ..... .....    @xxx
+xvmulwev_w_hu    0111 01001001 10001 ..... ..... .....    @xxx
+xvmulwev_d_wu    0111 01001001 10010 ..... ..... .....    @xxx
+xvmulwev_q_du    0111 01001001 10011 ..... ..... .....    @xxx
+xvmulwod_h_bu    0111 01001001 10100 ..... ..... .....    @xxx
+xvmulwod_w_hu    0111 01001001 10101 ..... ..... .....    @xxx
+xvmulwod_d_wu    0111 01001001 10110 ..... ..... .....    @xxx
+xvmulwod_q_du    0111 01001001 10111 ..... ..... .....    @xxx
+xvmulwev_h_bu_b  0111 01001010 00000 ..... ..... .....    @xxx
+xvmulwev_w_hu_h  0111 01001010 00001 ..... ..... .....    @xxx
+xvmulwev_d_wu_w  0111 01001010 00010 ..... ..... .....    @xxx
+xvmulwev_q_du_d  0111 01001010 00011 ..... ..... .....    @xxx
+xvmulwod_h_bu_b  0111 01001010 00100 ..... ..... .....    @xxx
+xvmulwod_w_hu_h  0111 01001010 00101 ..... ..... .....    @xxx
+xvmulwod_d_wu_w  0111 01001010 00110 ..... ..... .....    @xxx
+xvmulwod_q_du_d  0111 01001010 00111 ..... ..... .....    @xxx
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index 486cf9f7f1..4c342b06e5 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -393,3 +393,77 @@ XVMINMAXI(xvmaxi_bu, 8, UXB, DO_MAX)
 XVMINMAXI(xvmaxi_hu, 16, UXH, DO_MAX)
 XVMINMAXI(xvmaxi_wu, 32, UXW, DO_MAX)
 XVMINMAXI(xvmaxi_du, 64, UXD, DO_MAX)
+
+#define DO_XVMUH(NAME, BIT, E1, E2)                         \
+void HELPER(NAME)(void *xd, void *xj, void *xk, uint32_t v) \
+{                                                           \
+    int i;                                                  \
+    XReg *Xd = (XReg *)xd;                                  \
+    XReg *Xj = (XReg *)xj;                                  \
+    XReg *Xk = (XReg *)xk;                                  \
+    typedef __typeof(Xd->E1(0)) T;                          \
+                                                            \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                  \
+        Xd->E2(i) = ((T)Xj->E2(i)) * ((T)Xk->E2(i)) >> BIT; \
+    }                                                       \
+}
+
+void HELPER(xvmuh_d)(void *xd, void *xj, void *xk, uint32_t v)
+{
+    uint64_t l, h;
+    XReg *Xd = (XReg *)xd;
+    XReg *Xj = (XReg *)xj;
+    XReg *Xk = (XReg *)xk;
+    int i;
+
+    for (i = 0; i < 4; i++) {
+        muls64(&l, &h, Xj->XD(i), Xk->XD(i));
+        Xd->XD(i) = h;
+    }
+}
+
+DO_XVMUH(xvmuh_b, 8, XH, XB)
+DO_XVMUH(xvmuh_h, 16, XW, XH)
+DO_XVMUH(xvmuh_w, 32, XD, XW)
+
+void HELPER(xvmuh_du)(void *xd, void *xj, void *xk, uint32_t v)
+{
+    uint64_t l, h;
+    XReg *Xd = (XReg *)xd;
+    XReg *Xj = (XReg *)xj;
+    XReg *Xk = (XReg *)xk;
+    int i;
+
+    for (i = 0; i < 4; i++) {
+        mulu64(&l, &h, Xj->XD(i), Xk->XD(i));
+        Xd->XD(i) = h;
+    }
+}
+
+DO_XVMUH(xvmuh_bu, 8, UXH, UXB)
+DO_XVMUH(xvmuh_hu, 16, UXW, UXH)
+DO_XVMUH(xvmuh_wu, 32, UXD, UXW)
+
+XDO_EVEN(xvmulwev_h_b, 16, XH, XB, DO_MUL)
+XDO_EVEN(xvmulwev_w_h, 32, XW, XH, DO_MUL)
+XDO_EVEN(xvmulwev_d_w, 64, XD, XW, DO_MUL)
+
+XDO_ODD(xvmulwod_h_b, 16, XH, XB, DO_MUL)
+XDO_ODD(xvmulwod_w_h, 32, XW, XH, DO_MUL)
+XDO_ODD(xvmulwod_d_w, 64, XD, XW, DO_MUL)
+
+XDO_EVEN(xvmulwev_h_bu, 16, UXH, UXB, DO_MUL)
+XDO_EVEN(xvmulwev_w_hu, 32, UXW, UXH, DO_MUL)
+XDO_EVEN(xvmulwev_d_wu, 64, UXD, UXW, DO_MUL)
+
+XDO_ODD(xvmulwod_h_bu, 16, UXH, UXB, DO_MUL)
+XDO_ODD(xvmulwod_w_hu, 32, UXW, UXH, DO_MUL)
+XDO_ODD(xvmulwod_d_wu, 64, UXD, UXW, DO_MUL)
+
+XDO_EVEN_U_S(xvmulwev_h_bu_b, 16, XH, UXH, XB, UXB, DO_MUL)
+XDO_EVEN_U_S(xvmulwev_w_hu_h, 32, XW, UXW, XH, UXH, DO_MUL)
+XDO_EVEN_U_S(xvmulwev_d_wu_w, 64, XD, UXD, XW, UXW, DO_MUL)
+
+XDO_ODD_U_S(xvmulwod_h_bu_b, 16, XH, UXH, XB, UXB, DO_MUL)
+XDO_ODD_U_S(xvmulwod_w_hu_h, 32, XW, UXW, XH, UXH, DO_MUL)
+XDO_ODD_U_S(xvmulwod_d_wu_w, 64, XD, UXD, XW, UXW, DO_MUL)
diff --git a/target/loongarch/lsx_helper.c b/target/loongarch/lsx_helper.c
index 192cdb164c..d384fbef3a 100644
--- a/target/loongarch/lsx_helper.c
+++ b/target/loongarch/lsx_helper.c
@@ -415,8 +415,6 @@ DO_VMUH(vmuh_bu, 8, UH, UB, DO_MUH)
 DO_VMUH(vmuh_hu, 16, UW, UH, DO_MUH)
 DO_VMUH(vmuh_wu, 32, UD, UW, DO_MUH)
 
-#define DO_MUL(a, b) (a * b)
-
 DO_EVEN(vmulwev_h_b, 16, H, B, DO_MUL)
 DO_EVEN(vmulwev_w_h, 32, W, H, DO_MUL)
 DO_EVEN(vmulwev_d_w, 64, D, W, DO_MUL)
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index 96f216d569..e3dbf0f893 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -61,4 +61,6 @@
 #define DO_MIN(a, b)    (a < b ? a : b)
 #define DO_MAX(a, b)    (a > b ? a : b)
 
+#define DO_MUL(a, b)    (a * b)
+
 #endif /* LOONGARCH_VEC_H */
-- 
2.39.1


