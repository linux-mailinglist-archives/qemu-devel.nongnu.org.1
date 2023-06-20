Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CA5736819
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:43:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXqb-0003cP-D7; Tue, 20 Jun 2023 05:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXqS-0002mv-Uo
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:40:18 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXqM-0006aL-Gc
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:40:15 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxGuqPc5FkqiUHAA--.14772S3;
 Tue, 20 Jun 2023 17:38:23 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S18; 
 Tue, 20 Jun 2023 17:38:23 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 16/46] target/loongarch: Implement
 xvmadd/xvmsub/xvmaddw{ev/od}
Date: Tue, 20 Jun 2023 17:37:44 +0800
Message-Id: <20230620093814.123650-17-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S18
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
- XVMADD.{B/H/W/D};
- XVMSUB.{B/H/W/D};
- XVMADDW{EV/OD}.{H.B/W.H/D.W/Q.D}[U];
- XVMADDW{EV/OD}.{H.BU.B/W.HU.H/D.WU.W/Q.DU.D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  34 ++
 target/loongarch/helper.h                    |  30 ++
 target/loongarch/insn_trans/trans_lasx.c.inc | 367 +++++++++++++++++++
 target/loongarch/insns.decode                |  34 ++
 target/loongarch/lasx_helper.c               | 104 ++++++
 target/loongarch/vec.h                       |   3 +
 6 files changed, 572 insertions(+)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index e7c46bc3a2..ddfc4921b9 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1927,6 +1927,40 @@ INSN_LASX(xvmulwod_w_hu_h,   xxx)
 INSN_LASX(xvmulwod_d_wu_w,   xxx)
 INSN_LASX(xvmulwod_q_du_d,   xxx)
 
+INSN_LASX(xvmadd_b,          xxx)
+INSN_LASX(xvmadd_h,          xxx)
+INSN_LASX(xvmadd_w,          xxx)
+INSN_LASX(xvmadd_d,          xxx)
+INSN_LASX(xvmsub_b,          xxx)
+INSN_LASX(xvmsub_h,          xxx)
+INSN_LASX(xvmsub_w,          xxx)
+INSN_LASX(xvmsub_d,          xxx)
+
+INSN_LASX(xvmaddwev_h_b,     xxx)
+INSN_LASX(xvmaddwev_w_h,     xxx)
+INSN_LASX(xvmaddwev_d_w,     xxx)
+INSN_LASX(xvmaddwev_q_d,     xxx)
+INSN_LASX(xvmaddwod_h_b,     xxx)
+INSN_LASX(xvmaddwod_w_h,     xxx)
+INSN_LASX(xvmaddwod_d_w,     xxx)
+INSN_LASX(xvmaddwod_q_d,     xxx)
+INSN_LASX(xvmaddwev_h_bu,    xxx)
+INSN_LASX(xvmaddwev_w_hu,    xxx)
+INSN_LASX(xvmaddwev_d_wu,    xxx)
+INSN_LASX(xvmaddwev_q_du,    xxx)
+INSN_LASX(xvmaddwod_h_bu,    xxx)
+INSN_LASX(xvmaddwod_w_hu,    xxx)
+INSN_LASX(xvmaddwod_d_wu,    xxx)
+INSN_LASX(xvmaddwod_q_du,    xxx)
+INSN_LASX(xvmaddwev_h_bu_b,  xxx)
+INSN_LASX(xvmaddwev_w_hu_h,  xxx)
+INSN_LASX(xvmaddwev_d_wu_w,  xxx)
+INSN_LASX(xvmaddwev_q_du_d,  xxx)
+INSN_LASX(xvmaddwod_h_bu_b,  xxx)
+INSN_LASX(xvmaddwod_w_hu_h,  xxx)
+INSN_LASX(xvmaddwod_d_wu_w,  xxx)
+INSN_LASX(xvmaddwod_q_du_d,  xxx)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 88ae707027..0dc4cc18da 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -839,3 +839,33 @@ DEF_HELPER_FLAGS_4(xvmulwev_d_wu_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(xvmulwod_h_bu_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(xvmulwod_w_hu_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(xvmulwod_d_wu_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(xvmadd_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmadd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmadd_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmadd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmsub_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmsub_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmsub_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmsub_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(xvmaddwev_h_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmaddwev_w_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmaddwev_d_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmaddwod_h_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmaddwod_w_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmaddwod_d_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(xvmaddwev_h_bu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmaddwev_w_hu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmaddwev_d_wu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmaddwod_h_bu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmaddwod_w_hu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmaddwod_d_wu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(xvmaddwev_h_bu_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmaddwev_w_hu_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmaddwev_d_wu_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmaddwod_h_bu_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmaddwod_w_hu_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvmaddwod_d_wu_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index d57d867f17..78ba31b8c2 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -1363,6 +1363,373 @@ TRANS(xvmulwod_h_bu_b, gvec_xxx, MO_8, do_xvmulwod_u_s)
 TRANS(xvmulwod_w_hu_h, gvec_xxx, MO_16, do_xvmulwod_u_s)
 TRANS(xvmulwod_d_wu_w, gvec_xxx, MO_32, do_xvmulwod_u_s)
 
+static void do_xvmadd(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                      uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_mul_vec, INDEX_op_add_vec, 0
+        };
+    static const GVecGen3 op[4] = {
+        {
+            .fniv = gen_vmadd,
+            .fno = gen_helper_xvmadd_b,
+            .load_dest = true,
+            .opt_opc = vecop_list,
+            .vece = MO_8
+        },
+        {
+            .fniv = gen_vmadd,
+            .fno = gen_helper_xvmadd_h,
+            .load_dest = true,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fni4 = gen_vmadd_w,
+            .fniv = gen_vmadd,
+            .fno = gen_helper_xvmadd_w,
+            .load_dest = true,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fni8 = gen_vmadd_d,
+            .fniv = gen_vmadd,
+            .fno = gen_helper_xvmadd_d,
+            .load_dest = true,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvmadd_b, gvec_xxx, MO_8, do_xvmadd)
+TRANS(xvmadd_h, gvec_xxx, MO_16, do_xvmadd)
+TRANS(xvmadd_w, gvec_xxx, MO_32, do_xvmadd)
+TRANS(xvmadd_d, gvec_xxx, MO_64, do_xvmadd)
+
+static void do_xvmsub(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                      uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_mul_vec, INDEX_op_sub_vec, 0
+        };
+    static const GVecGen3 op[4] = {
+        {
+            .fniv = gen_vmsub,
+            .fno = gen_helper_xvmsub_b,
+            .load_dest = true,
+            .opt_opc = vecop_list,
+            .vece = MO_8
+        },
+        {
+            .fniv = gen_vmsub,
+            .fno = gen_helper_xvmsub_h,
+            .load_dest = true,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fni4 = gen_vmsub_w,
+            .fniv = gen_vmsub,
+            .fno = gen_helper_xvmsub_w,
+            .load_dest = true,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fni8 = gen_vmsub_d,
+            .fniv = gen_vmsub,
+            .fno = gen_helper_xvmsub_d,
+            .load_dest = true,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvmsub_b, gvec_xxx, MO_8, do_xvmsub)
+TRANS(xvmsub_h, gvec_xxx, MO_16, do_xvmsub)
+TRANS(xvmsub_w, gvec_xxx, MO_32, do_xvmsub)
+TRANS(xvmsub_d, gvec_xxx, MO_64, do_xvmsub)
+
+static void do_xvmaddwev_s(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                           uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shli_vec, INDEX_op_sari_vec,
+        INDEX_op_mul_vec, INDEX_op_add_vec, 0
+        };
+    static const GVecGen3 op[3] = {
+        {
+            .fniv = gen_vmaddwev_s,
+            .fno = gen_helper_xvmaddwev_h_b,
+            .load_dest = true,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fni4 = gen_vmaddwev_w_h,
+            .fniv = gen_vmaddwev_s,
+            .fno = gen_helper_xvmaddwev_w_h,
+            .load_dest = true,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fni8 = gen_vmaddwev_d_w,
+            .fniv = gen_vmaddwev_s,
+            .fno = gen_helper_xvmaddwev_d_w,
+            .load_dest = true,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvmaddwev_h_b, gvec_xxx, MO_8, do_xvmaddwev_s)
+TRANS(xvmaddwev_w_h, gvec_xxx, MO_16, do_xvmaddwev_s)
+TRANS(xvmaddwev_d_w, gvec_xxx, MO_32, do_xvmaddwev_s)
+
+#define XVMADD_Q(NAME, FN, idx1, idx2)                    \
+static bool trans_## NAME(DisasContext *ctx, arg_xxx * a) \
+{                                                         \
+    TCGv_i64 rh, rl, arg1, arg2, th, tl;                  \
+    int i;                                                \
+                                                          \
+    rh = tcg_temp_new_i64();                              \
+    rl = tcg_temp_new_i64();                              \
+    arg1 = tcg_temp_new_i64();                            \
+    arg2 = tcg_temp_new_i64();                            \
+    th = tcg_temp_new_i64();                              \
+    tl = tcg_temp_new_i64();                              \
+                                                          \
+    for (i = 0; i < 2; i++) {                             \
+        get_xreg64(arg1, a->xj, idx1 + i * 2);            \
+        get_xreg64(arg2, a->xk, idx2 + i * 2);            \
+        get_xreg64(rh, a->xd, 1 + i * 2);                 \
+        get_xreg64(rl, a->xd, 0 + i * 2);                 \
+                                                          \
+        tcg_gen_## FN ##_i64(tl, th, arg1, arg2);         \
+        tcg_gen_add2_i64(rl, rh, rl, rh, tl, th);         \
+                                                          \
+        set_xreg64(rh, a->xd, 1 + i * 2);                 \
+        set_xreg64(rl, a->xd, 0 + i * 2);                 \
+    }                                                     \
+                                                          \
+    return true;                                          \
+}
+
+XVMADD_Q(xvmaddwev_q_d, muls2, 0, 0)
+XVMADD_Q(xvmaddwod_q_d, muls2, 1, 1)
+XVMADD_Q(xvmaddwev_q_du, mulu2, 0, 0)
+XVMADD_Q(xvmaddwod_q_du, mulu2, 1, 1)
+XVMADD_Q(xvmaddwev_q_du_d, mulus2, 0, 0)
+XVMADD_Q(xvmaddwod_q_du_d, mulus2, 1, 1)
+
+static void do_xvmaddwod_s(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                           uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sari_vec, INDEX_op_mul_vec, INDEX_op_add_vec, 0
+        };
+    static const GVecGen3 op[3] = {
+        {
+            .fniv = gen_vmaddwod_s,
+            .fno = gen_helper_xvmaddwod_h_b,
+            .load_dest = true,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fni4 = gen_vmaddwod_w_h,
+            .fniv = gen_vmaddwod_s,
+            .fno = gen_helper_xvmaddwod_w_h,
+            .load_dest = true,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fni8 = gen_vmaddwod_d_w,
+            .fniv = gen_vmaddwod_s,
+            .fno = gen_helper_xvmaddwod_d_w,
+            .load_dest = true,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvmaddwod_h_b, gvec_xxx, MO_8, do_xvmaddwod_s)
+TRANS(xvmaddwod_w_h, gvec_xxx, MO_16, do_xvmaddwod_s)
+TRANS(xvmaddwod_d_w, gvec_xxx, MO_32, do_xvmaddwod_s)
+
+static void do_xvmaddwev_u(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                           uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_mul_vec, INDEX_op_add_vec, 0
+        };
+    static const GVecGen3 op[3] = {
+        {
+            .fniv = gen_vmaddwev_u,
+            .fno = gen_helper_xvmaddwev_h_bu,
+            .load_dest = true,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fni4 = gen_vmaddwev_w_hu,
+            .fniv = gen_vmaddwev_u,
+            .fno = gen_helper_xvmaddwev_w_hu,
+            .load_dest = true,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fni8 = gen_vmaddwev_d_wu,
+            .fniv = gen_vmaddwev_u,
+            .fno = gen_helper_xvmaddwev_d_wu,
+            .load_dest = true,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvmaddwev_h_bu, gvec_xxx, MO_8, do_xvmaddwev_u)
+TRANS(xvmaddwev_w_hu, gvec_xxx, MO_16, do_xvmaddwev_u)
+TRANS(xvmaddwev_d_wu, gvec_xxx, MO_32, do_xvmaddwev_u)
+
+static void do_xvmaddwod_u(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                           uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shri_vec, INDEX_op_mul_vec, INDEX_op_add_vec, 0
+        };
+    static const GVecGen3 op[3] = {
+        {
+            .fniv = gen_vmaddwod_u,
+            .fno = gen_helper_xvmaddwod_h_bu,
+            .load_dest = true,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fni4 = gen_vmaddwod_w_hu,
+            .fniv = gen_vmaddwod_u,
+            .fno = gen_helper_xvmaddwod_w_hu,
+            .load_dest = true,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fni8 = gen_vmaddwod_d_wu,
+            .fniv = gen_vmaddwod_u,
+            .fno = gen_helper_xvmaddwod_d_wu,
+            .load_dest = true,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvmaddwod_h_bu, gvec_xxx, MO_8, do_xvmaddwod_u)
+TRANS(xvmaddwod_w_hu, gvec_xxx, MO_16, do_xvmaddwod_u)
+TRANS(xvmaddwod_d_wu, gvec_xxx, MO_32, do_xvmaddwod_u)
+
+static void do_xvmaddwev_u_s(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                             uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shli_vec, INDEX_op_sari_vec,
+        INDEX_op_mul_vec, INDEX_op_add_vec, 0
+        };
+    static const GVecGen3 op[3] = {
+        {
+            .fniv = gen_vmaddwev_u_s,
+            .fno = gen_helper_xvmaddwev_h_bu_b,
+            .load_dest = true,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fni4 = gen_vmaddwev_w_hu_h,
+            .fniv = gen_vmaddwev_u_s,
+            .fno = gen_helper_xvmaddwev_w_hu_h,
+            .load_dest = true,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fni8 = gen_vmaddwev_d_wu_w,
+            .fniv = gen_vmaddwev_u_s,
+            .fno = gen_helper_xvmaddwev_d_wu_w,
+            .load_dest = true,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvmaddwev_h_bu_b, gvec_xxx, MO_8, do_xvmaddwev_u_s)
+TRANS(xvmaddwev_w_hu_h, gvec_xxx, MO_16, do_xvmaddwev_u_s)
+TRANS(xvmaddwev_d_wu_w, gvec_xxx, MO_32, do_xvmaddwev_u_s)
+
+static void do_xvmaddwod_u_s(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                             uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shri_vec, INDEX_op_sari_vec,
+        INDEX_op_mul_vec, INDEX_op_add_vec, 0
+        };
+    static const GVecGen3 op[3] = {
+        {
+            .fniv = gen_vmaddwod_u_s,
+            .fno = gen_helper_xvmaddwod_h_bu_b,
+            .load_dest = true,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fni4 = gen_vmaddwod_w_hu_h,
+            .fniv = gen_vmaddwod_u_s,
+            .fno = gen_helper_xvmaddwod_w_hu_h,
+            .load_dest = true,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fni8 = gen_vmaddwod_d_wu_w,
+            .fniv = gen_vmaddwod_u_s,
+            .fno = gen_helper_xvmaddwod_d_wu_w,
+            .load_dest = true,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvmaddwod_h_bu_b, gvec_xxx, MO_8, do_xvmaddwod_u_s)
+TRANS(xvmaddwod_w_hu_h, gvec_xxx, MO_16, do_xvmaddwod_u_s)
+TRANS(xvmaddwod_d_wu_w, gvec_xxx, MO_32, do_xvmaddwod_u_s)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 872eeed7a8..cc210314ff 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1527,6 +1527,40 @@ xvmulwod_w_hu_h  0111 01001010 00101 ..... ..... .....    @xxx
 xvmulwod_d_wu_w  0111 01001010 00110 ..... ..... .....    @xxx
 xvmulwod_q_du_d  0111 01001010 00111 ..... ..... .....    @xxx
 
+xvmadd_b         0111 01001010 10000 ..... ..... .....    @xxx
+xvmadd_h         0111 01001010 10001 ..... ..... .....    @xxx
+xvmadd_w         0111 01001010 10010 ..... ..... .....    @xxx
+xvmadd_d         0111 01001010 10011 ..... ..... .....    @xxx
+xvmsub_b         0111 01001010 10100 ..... ..... .....    @xxx
+xvmsub_h         0111 01001010 10101 ..... ..... .....    @xxx
+xvmsub_w         0111 01001010 10110 ..... ..... .....    @xxx
+xvmsub_d         0111 01001010 10111 ..... ..... .....    @xxx
+
+xvmaddwev_h_b    0111 01001010 11000 ..... ..... .....    @xxx
+xvmaddwev_w_h    0111 01001010 11001 ..... ..... .....    @xxx
+xvmaddwev_d_w    0111 01001010 11010 ..... ..... .....    @xxx
+xvmaddwev_q_d    0111 01001010 11011 ..... ..... .....    @xxx
+xvmaddwod_h_b    0111 01001010 11100 ..... ..... .....    @xxx
+xvmaddwod_w_h    0111 01001010 11101 ..... ..... .....    @xxx
+xvmaddwod_d_w    0111 01001010 11110 ..... ..... .....    @xxx
+xvmaddwod_q_d    0111 01001010 11111 ..... ..... .....    @xxx
+xvmaddwev_h_bu   0111 01001011 01000 ..... ..... .....    @xxx
+xvmaddwev_w_hu   0111 01001011 01001 ..... ..... .....    @xxx
+xvmaddwev_d_wu   0111 01001011 01010 ..... ..... .....    @xxx
+xvmaddwev_q_du   0111 01001011 01011 ..... ..... .....    @xxx
+xvmaddwod_h_bu   0111 01001011 01100 ..... ..... .....    @xxx
+xvmaddwod_w_hu   0111 01001011 01101 ..... ..... .....    @xxx
+xvmaddwod_d_wu   0111 01001011 01110 ..... ..... .....    @xxx
+xvmaddwod_q_du   0111 01001011 01111 ..... ..... .....    @xxx
+xvmaddwev_h_bu_b 0111 01001011 11000 ..... ..... .....    @xxx
+xvmaddwev_w_hu_h 0111 01001011 11001 ..... ..... .....    @xxx
+xvmaddwev_d_wu_w 0111 01001011 11010 ..... ..... .....    @xxx
+xvmaddwev_q_du_d 0111 01001011 11011 ..... ..... .....    @xxx
+xvmaddwod_h_bu_b 0111 01001011 11100 ..... ..... .....    @xxx
+xvmaddwod_w_hu_h 0111 01001011 11101 ..... ..... .....    @xxx
+xvmaddwod_d_wu_w 0111 01001011 11110 ..... ..... .....    @xxx
+xvmaddwod_q_du_d 0111 01001011 11111 ..... ..... .....    @xxx
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index 4c342b06e5..df85fa04f0 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -467,3 +467,107 @@ XDO_EVEN_U_S(xvmulwev_d_wu_w, 64, XD, UXD, XW, UXW, DO_MUL)
 XDO_ODD_U_S(xvmulwod_h_bu_b, 16, XH, UXH, XB, UXB, DO_MUL)
 XDO_ODD_U_S(xvmulwod_w_hu_h, 32, XW, UXW, XH, UXH, DO_MUL)
 XDO_ODD_U_S(xvmulwod_d_wu_w, 64, XD, UXD, XW, UXW, DO_MUL)
+
+#define XVMADDSUB(NAME, BIT, E, DO_OP)                      \
+void HELPER(NAME)(void *xd, void *xj, void *xk, uint32_t v) \
+{                                                           \
+    int i;                                                  \
+    XReg *Xd = (XReg *)xd;                                  \
+    XReg *Xj = (XReg *)xj;                                  \
+    XReg *Xk = (XReg *)xk;                                  \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                  \
+        Xd->E(i) = DO_OP(Xd->E(i), Xj->E(i), Xk->E(i));     \
+    }                                                       \
+}
+
+XVMADDSUB(xvmadd_b, 8, XB, DO_MADD)
+XVMADDSUB(xvmadd_h, 16, XH, DO_MADD)
+XVMADDSUB(xvmadd_w, 32, XW, DO_MADD)
+XVMADDSUB(xvmadd_d, 64, XD, DO_MADD)
+XVMADDSUB(xvmsub_b, 8, XB, DO_MSUB)
+XVMADDSUB(xvmsub_h, 16, XH, DO_MSUB)
+XVMADDSUB(xvmsub_w, 32, XW, DO_MSUB)
+XVMADDSUB(xvmsub_d, 64, XD, DO_MSUB)
+
+#define XVMADDWEV(NAME, BIT, E1, E2, DO_OP)                       \
+void HELPER(NAME)(void *xd, void *xj, void *xk, uint32_t v)       \
+{                                                                 \
+    int i;                                                        \
+    XReg *Xd = (XReg *)xd;                                        \
+    XReg *Xj = (XReg *)xj;                                        \
+    XReg *Xk = (XReg *)xk;                                        \
+    typedef __typeof(Xd->E1(0)) TD;                               \
+                                                                  \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                        \
+        Xd->E1(i) += DO_OP((TD)Xj->E2(2 * i), (TD)Xk->E2(2 * i)); \
+    }                                                             \
+}
+
+XVMADDWEV(xvmaddwev_h_b, 16, XH, XB, DO_MUL)
+XVMADDWEV(xvmaddwev_w_h, 32, XW, XH, DO_MUL)
+XVMADDWEV(xvmaddwev_d_w, 64, XD, XW, DO_MUL)
+XVMADDWEV(xvmaddwev_h_bu, 16, UXH, UXB, DO_MUL)
+XVMADDWEV(xvmaddwev_w_hu, 32, UXW, UXH, DO_MUL)
+XVMADDWEV(xvmaddwev_d_wu, 64, UXD, UXW, DO_MUL)
+
+#define XVMADDWOD(NAME, BIT, E1, E2, DO_OP)                 \
+void HELPER(NAME)(void *xd, void *xj, void *xk, uint32_t v) \
+{                                                           \
+    int i;                                                  \
+    XReg *Xd = (XReg *)xd;                                  \
+    XReg *Xj = (XReg *)xj;                                  \
+    XReg *Xk = (XReg *)xk;                                  \
+    typedef __typeof(Xd->E1(0)) TD;                         \
+                                                            \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                  \
+        Xd->E1(i) += DO_OP((TD)Xj->E2(2 * i + 1),           \
+                           (TD)Xk->E2(2 * i + 1));          \
+    }                                                       \
+}
+
+XVMADDWOD(xvmaddwod_h_b, 16, XH, XB, DO_MUL)
+XVMADDWOD(xvmaddwod_w_h, 32, XW, XH, DO_MUL)
+XVMADDWOD(xvmaddwod_d_w, 64, XD, XW, DO_MUL)
+XVMADDWOD(xvmaddwod_h_bu, 16,  UXH, UXB, DO_MUL)
+XVMADDWOD(xvmaddwod_w_hu, 32,  UXW, UXH, DO_MUL)
+XVMADDWOD(xvmaddwod_d_wu, 64,  UXD, UXW, DO_MUL)
+
+#define XVMADDWEV_U_S(NAME, BIT, ES1, EU1, ES2, EU2, DO_OP) \
+void HELPER(NAME)(void *xd, void *xj, void *xk, uint32_t v) \
+{                                                           \
+    int i;                                                  \
+    XReg *Xd = (XReg *)xd;                                  \
+    XReg *Xj = (XReg *)xj;                                  \
+    XReg *Xk = (XReg *)xk;                                  \
+    typedef __typeof(Xd->ES1(0)) TS1;                       \
+    typedef __typeof(Xd->EU1(0)) TU1;                       \
+                                                            \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                  \
+        Xd->ES1(i) += DO_OP((TU1)Xj->EU2(2 * i),            \
+                            (TS1)Xk->ES2(2 * i));           \
+    }                                                       \
+}
+
+XVMADDWEV_U_S(xvmaddwev_h_bu_b, 16, XH, UXH, XB, UXB, DO_MUL)
+XVMADDWEV_U_S(xvmaddwev_w_hu_h, 32, XW, UXW, XH, UXH, DO_MUL)
+XVMADDWEV_U_S(xvmaddwev_d_wu_w, 64, XD, UXD, XW, UXW, DO_MUL)
+
+#define XVMADDWOD_U_S(NAME, BIT, ES1, EU1, ES2, EU2, DO_OP) \
+void HELPER(NAME)(void *xd, void *xj, void *xk, uint32_t v) \
+{                                                           \
+    int i;                                                  \
+    XReg *Xd = (XReg *)xd;                                  \
+    XReg *Xj = (XReg *)xj;                                  \
+    XReg *Xk = (XReg *)xk;                                  \
+    typedef __typeof(Xd->ES1(0)) TS1;                       \
+    typedef __typeof(Xd->EU1(0)) TU1;                       \
+                                                            \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                  \
+        Xd->ES1(i) += DO_OP((TU1)Xj->EU2(2 * i + 1),        \
+                            (TS1)Xk->ES2(2 * i + 1));       \
+    }                                                       \
+}
+
+XVMADDWOD_U_S(xvmaddwod_h_bu_b, 16, XH, UXH, XB, UXB, DO_MUL)
+XVMADDWOD_U_S(xvmaddwod_w_hu_h, 32, XW, UXW, XH, UXH, DO_MUL)
+XVMADDWOD_U_S(xvmaddwod_d_wu_w, 64, XD, UXD, XW, UXW, DO_MUL)
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index e3dbf0f893..06992410ad 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -63,4 +63,7 @@
 
 #define DO_MUL(a, b)    (a * b)
 
+#define DO_MADD(a, b, c)  (a + b * c)
+#define DO_MSUB(a, b, c)  (a - b * c)
+
 #endif /* LOONGARCH_VEC_H */
-- 
2.39.1


