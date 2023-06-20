Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA5A736809
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:42:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXoq-00075M-Tg; Tue, 20 Jun 2023 05:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXoi-00072B-Bd
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:31 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXod-0006JK-A9
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:28 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx8OiNc5FkliUHAA--.12756S3;
 Tue, 20 Jun 2023 17:38:21 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S12; 
 Tue, 20 Jun 2023 17:38:20 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 10/46] target/loongarch: Implement xvaddw/xvsubw
Date: Tue, 20 Jun 2023 17:37:38 +0800
Message-Id: <20230620093814.123650-11-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S12
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
- XVADDW{EV/OD}.{H.B/W.H/D.W/Q.D}[U];
- XVSUBW{EV/OD}.{H.B/W.H/D.W/Q.D}[U];
- XVADDW{EV/OD}.{H.BU.B/W.HU.H/D.WU.W/Q.DU.D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  43 ++
 target/loongarch/helper.h                    |  45 ++
 target/loongarch/insn_trans/trans_lasx.c.inc | 410 +++++++++++++++++++
 target/loongarch/insns.decode                |  45 ++
 target/loongarch/lasx_helper.c               | 214 ++++++++++
 5 files changed, 757 insertions(+)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 770359524e..6e790f0959 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1782,6 +1782,49 @@ INSN_LASX(xvhsubw_wu_hu,     xxx)
 INSN_LASX(xvhsubw_du_wu,     xxx)
 INSN_LASX(xvhsubw_qu_du,     xxx)
 
+INSN_LASX(xvaddwev_h_b,      xxx)
+INSN_LASX(xvaddwev_w_h,      xxx)
+INSN_LASX(xvaddwev_d_w,      xxx)
+INSN_LASX(xvaddwev_q_d,      xxx)
+INSN_LASX(xvaddwod_h_b,      xxx)
+INSN_LASX(xvaddwod_w_h,      xxx)
+INSN_LASX(xvaddwod_d_w,      xxx)
+INSN_LASX(xvaddwod_q_d,      xxx)
+INSN_LASX(xvsubwev_h_b,      xxx)
+INSN_LASX(xvsubwev_w_h,      xxx)
+INSN_LASX(xvsubwev_d_w,      xxx)
+INSN_LASX(xvsubwev_q_d,      xxx)
+INSN_LASX(xvsubwod_h_b,      xxx)
+INSN_LASX(xvsubwod_w_h,      xxx)
+INSN_LASX(xvsubwod_d_w,      xxx)
+INSN_LASX(xvsubwod_q_d,      xxx)
+
+INSN_LASX(xvaddwev_h_bu,     xxx)
+INSN_LASX(xvaddwev_w_hu,     xxx)
+INSN_LASX(xvaddwev_d_wu,     xxx)
+INSN_LASX(xvaddwev_q_du,     xxx)
+INSN_LASX(xvaddwod_h_bu,     xxx)
+INSN_LASX(xvaddwod_w_hu,     xxx)
+INSN_LASX(xvaddwod_d_wu,     xxx)
+INSN_LASX(xvaddwod_q_du,     xxx)
+INSN_LASX(xvsubwev_h_bu,     xxx)
+INSN_LASX(xvsubwev_w_hu,     xxx)
+INSN_LASX(xvsubwev_d_wu,     xxx)
+INSN_LASX(xvsubwev_q_du,     xxx)
+INSN_LASX(xvsubwod_h_bu,     xxx)
+INSN_LASX(xvsubwod_w_hu,     xxx)
+INSN_LASX(xvsubwod_d_wu,     xxx)
+INSN_LASX(xvsubwod_q_du,     xxx)
+
+INSN_LASX(xvaddwev_h_bu_b,   xxx)
+INSN_LASX(xvaddwev_w_hu_h,   xxx)
+INSN_LASX(xvaddwev_d_wu_w,   xxx)
+INSN_LASX(xvaddwev_q_du_d,   xxx)
+INSN_LASX(xvaddwod_h_bu_b,   xxx)
+INSN_LASX(xvaddwod_w_hu_h,   xxx)
+INSN_LASX(xvaddwod_d_wu_w,   xxx)
+INSN_LASX(xvaddwod_q_du_d,   xxx)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index db2deaff79..2034576d87 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -714,3 +714,48 @@ DEF_HELPER_4(xvhsubw_hu_bu, void, env, i32, i32, i32)
 DEF_HELPER_4(xvhsubw_wu_hu, void, env, i32, i32, i32)
 DEF_HELPER_4(xvhsubw_du_wu, void, env, i32, i32, i32)
 DEF_HELPER_4(xvhsubw_qu_du, void, env, i32, i32, i32)
+
+DEF_HELPER_FLAGS_4(xvaddwev_h_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvaddwev_w_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvaddwev_d_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvaddwev_q_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvaddwod_h_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvaddwod_w_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvaddwod_d_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvaddwod_q_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(xvsubwev_h_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvsubwev_w_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvsubwev_d_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvsubwev_q_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvsubwod_h_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvsubwod_w_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvsubwod_d_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvsubwod_q_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(xvaddwev_h_bu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvaddwev_w_hu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvaddwev_d_wu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvaddwev_q_du, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvaddwod_h_bu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvaddwod_w_hu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvaddwod_d_wu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvaddwod_q_du, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(xvsubwev_h_bu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvsubwev_w_hu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvsubwev_d_wu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvsubwev_q_du, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvsubwod_h_bu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvsubwod_w_hu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvsubwod_d_wu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvsubwod_q_du, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(xvaddwev_h_bu_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvaddwev_w_hu_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvaddwev_d_wu_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvaddwev_q_du_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvaddwod_h_bu_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvaddwod_w_hu_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvaddwod_d_wu_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvaddwod_q_du_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index aa0e35b228..0a574182db 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -178,6 +178,416 @@ TRANS(xvhsubw_wu_hu, gen_xxx, gen_helper_xvhsubw_wu_hu)
 TRANS(xvhsubw_du_wu, gen_xxx, gen_helper_xvhsubw_du_wu)
 TRANS(xvhsubw_qu_du, gen_xxx, gen_helper_xvhsubw_qu_du)
 
+static void do_xvaddwev_s(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                          uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shli_vec, INDEX_op_sari_vec, INDEX_op_add_vec, 0
+        };
+    static const GVecGen3 op[4] = {
+        {
+            .fniv = gen_vaddwev_s,
+            .fno = gen_helper_xvaddwev_h_b,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fni4 = gen_vaddwev_w_h,
+            .fniv = gen_vaddwev_s,
+            .fno = gen_helper_xvaddwev_w_h,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fni8 = gen_vaddwev_d_w,
+            .fniv = gen_vaddwev_s,
+            .fno = gen_helper_xvaddwev_d_w,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+        {
+            .fno = gen_helper_xvaddwev_q_d,
+            .vece = MO_128
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvaddwev_h_b, gvec_xxx, MO_8, do_xvaddwev_s)
+TRANS(xvaddwev_w_h, gvec_xxx, MO_16, do_xvaddwev_s)
+TRANS(xvaddwev_d_w, gvec_xxx, MO_32, do_xvaddwev_s)
+TRANS(xvaddwev_q_d, gvec_xxx, MO_64, do_xvaddwev_s)
+
+static void do_xvaddwod_s(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                          uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sari_vec, INDEX_op_add_vec, 0
+        };
+    static const GVecGen3 op[4] = {
+        {
+            .fniv = gen_vaddwod_s,
+            .fno = gen_helper_xvaddwod_h_b,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fni4 = gen_vaddwod_w_h,
+            .fniv = gen_vaddwod_s,
+            .fno = gen_helper_xvaddwod_w_h,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fni8 = gen_vaddwod_d_w,
+            .fniv = gen_vaddwod_s,
+            .fno = gen_helper_xvaddwod_d_w,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+        {
+            .fno = gen_helper_xvaddwod_q_d,
+            .vece = MO_128
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvaddwod_h_b, gvec_xxx, MO_8, do_xvaddwod_s)
+TRANS(xvaddwod_w_h, gvec_xxx, MO_16, do_xvaddwod_s)
+TRANS(xvaddwod_d_w, gvec_xxx, MO_32, do_xvaddwod_s)
+TRANS(xvaddwod_q_d, gvec_xxx, MO_64, do_xvaddwod_s)
+
+static void do_xvsubwev_s(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                          uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shli_vec, INDEX_op_sari_vec, INDEX_op_sub_vec, 0
+        };
+    static const GVecGen3 op[4] = {
+        {
+            .fniv = gen_vsubwev_s,
+            .fno = gen_helper_xvsubwev_h_b,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fni4 = gen_vsubwev_w_h,
+            .fniv = gen_vsubwev_s,
+            .fno = gen_helper_xvsubwev_w_h,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fni8 = gen_vsubwev_d_w,
+            .fniv = gen_vsubwev_s,
+            .fno = gen_helper_xvsubwev_d_w,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+        {
+            .fno = gen_helper_xvsubwev_q_d,
+            .vece = MO_128
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvsubwev_h_b, gvec_xxx, MO_8, do_xvsubwev_s)
+TRANS(xvsubwev_w_h, gvec_xxx, MO_16, do_xvsubwev_s)
+TRANS(xvsubwev_d_w, gvec_xxx, MO_32, do_xvsubwev_s)
+TRANS(xvsubwev_q_d, gvec_xxx, MO_64, do_xvsubwev_s)
+
+static void do_xvsubwod_s(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                          uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sari_vec, INDEX_op_sub_vec, 0
+        };
+    static const GVecGen3 op[4] = {
+        {
+            .fniv = gen_vsubwod_s,
+            .fno = gen_helper_xvsubwod_h_b,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fni4 = gen_vsubwod_w_h,
+            .fniv = gen_vsubwod_s,
+            .fno = gen_helper_xvsubwod_w_h,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fni8 = gen_vsubwod_d_w,
+            .fniv = gen_vsubwod_s,
+            .fno = gen_helper_xvsubwod_d_w,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+        {
+            .fno = gen_helper_xvsubwod_q_d,
+            .vece = MO_128
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvsubwod_h_b, gvec_xxx, MO_8, do_xvsubwod_s)
+TRANS(xvsubwod_w_h, gvec_xxx, MO_16, do_xvsubwod_s)
+TRANS(xvsubwod_d_w, gvec_xxx, MO_32, do_xvsubwod_s)
+TRANS(xvsubwod_q_d, gvec_xxx, MO_64, do_xvsubwod_s)
+
+static void do_xvaddwev_u(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                          uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_add_vec, 0
+        };
+    static const GVecGen3 op[4] = {
+        {
+            .fniv = gen_vaddwev_u,
+            .fno = gen_helper_xvaddwev_h_bu,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fni4 = gen_vaddwev_w_hu,
+            .fniv = gen_vaddwev_u,
+            .fno = gen_helper_xvaddwev_w_hu,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fni8 = gen_vaddwev_d_wu,
+            .fniv = gen_vaddwev_u,
+            .fno = gen_helper_xvaddwev_d_wu,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+        {
+            .fno = gen_helper_xvaddwev_q_du,
+            .vece = MO_128
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvaddwev_h_bu, gvec_xxx, MO_8, do_xvaddwev_u)
+TRANS(xvaddwev_w_hu, gvec_xxx, MO_16, do_xvaddwev_u)
+TRANS(xvaddwev_d_wu, gvec_xxx, MO_32, do_xvaddwev_u)
+TRANS(xvaddwev_q_du, gvec_xxx, MO_64, do_xvaddwev_u)
+
+static void do_xvaddwod_u(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                          uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shri_vec, INDEX_op_add_vec, 0
+        };
+    static const GVecGen3 op[4] = {
+        {
+            .fniv = gen_vaddwod_u,
+            .fno = gen_helper_xvaddwod_h_bu,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fni4 = gen_vaddwod_w_hu,
+            .fniv = gen_vaddwod_u,
+            .fno = gen_helper_xvaddwod_w_hu,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fni8 = gen_vaddwod_d_wu,
+            .fniv = gen_vaddwod_u,
+            .fno = gen_helper_xvaddwod_d_wu,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+        {
+            .fno = gen_helper_xvaddwod_q_du,
+            .vece = MO_128
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvaddwod_h_bu, gvec_xxx, MO_8, do_xvaddwod_u)
+TRANS(xvaddwod_w_hu, gvec_xxx, MO_16, do_xvaddwod_u)
+TRANS(xvaddwod_d_wu, gvec_xxx, MO_32, do_xvaddwod_u)
+TRANS(xvaddwod_q_du, gvec_xxx, MO_64, do_xvaddwod_u)
+
+static void do_xvsubwev_u(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                          uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sub_vec, 0
+        };
+    static const GVecGen3 op[4] = {
+        {
+            .fniv = gen_vsubwev_u,
+            .fno = gen_helper_xvsubwev_h_bu,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fni4 = gen_vsubwev_w_hu,
+            .fniv = gen_vsubwev_u,
+            .fno = gen_helper_xvsubwev_w_hu,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fni8 = gen_vsubwev_d_wu,
+            .fniv = gen_vsubwev_u,
+            .fno = gen_helper_xvsubwev_d_wu,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+        {
+            .fno = gen_helper_xvsubwev_q_du,
+            .vece = MO_128
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvsubwev_h_bu, gvec_xxx, MO_8, do_xvsubwev_u)
+TRANS(xvsubwev_w_hu, gvec_xxx, MO_16, do_xvsubwev_u)
+TRANS(xvsubwev_d_wu, gvec_xxx, MO_32, do_xvsubwev_u)
+TRANS(xvsubwev_q_du, gvec_xxx, MO_64, do_xvsubwev_u)
+
+static void do_xvsubwod_u(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                          uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shri_vec, INDEX_op_sub_vec, 0
+        };
+    static const GVecGen3 op[4] = {
+        {
+            .fniv = gen_vsubwod_u,
+            .fno = gen_helper_xvsubwod_h_bu,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fni4 = gen_vsubwod_w_hu,
+            .fniv = gen_vsubwod_u,
+            .fno = gen_helper_xvsubwod_w_hu,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fni8 = gen_vsubwod_d_wu,
+            .fniv = gen_vsubwod_u,
+            .fno = gen_helper_xvsubwod_d_wu,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+        {
+            .fno = gen_helper_xvsubwod_q_du,
+            .vece = MO_128
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvsubwod_h_bu, gvec_xxx, MO_8, do_xvsubwod_u)
+TRANS(xvsubwod_w_hu, gvec_xxx, MO_16, do_xvsubwod_u)
+TRANS(xvsubwod_d_wu, gvec_xxx, MO_32, do_xvsubwod_u)
+TRANS(xvsubwod_q_du, gvec_xxx, MO_64, do_xvsubwod_u)
+
+static void do_xvaddwev_u_s(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                            uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shli_vec, INDEX_op_sari_vec, INDEX_op_add_vec, 0
+        };
+    static const GVecGen3 op[4] = {
+        {
+            .fniv = gen_vaddwev_u_s,
+            .fno = gen_helper_xvaddwev_h_bu_b,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fni4 = gen_vaddwev_w_hu_h,
+            .fniv = gen_vaddwev_u_s,
+            .fno = gen_helper_xvaddwev_w_hu_h,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fni8 = gen_vaddwev_d_wu_w,
+            .fniv = gen_vaddwev_u_s,
+            .fno = gen_helper_xvaddwev_d_wu_w,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+        {
+            .fno = gen_helper_xvaddwev_q_du_d,
+            .vece = MO_128
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvaddwev_h_bu_b, gvec_xxx, MO_8, do_xvaddwev_u_s)
+TRANS(xvaddwev_w_hu_h, gvec_xxx, MO_16, do_xvaddwev_u_s)
+TRANS(xvaddwev_d_wu_w, gvec_xxx, MO_32, do_xvaddwev_u_s)
+TRANS(xvaddwev_q_du_d, gvec_xxx, MO_64, do_xvaddwev_u_s)
+
+static void do_xvaddwod_u_s(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                            uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shri_vec, INDEX_op_sari_vec,  INDEX_op_add_vec, 0
+        };
+    static const GVecGen3 op[4] = {
+        {
+            .fniv = gen_vaddwod_u_s,
+            .fno = gen_helper_xvaddwod_h_bu_b,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fni4 = gen_vaddwod_w_hu_h,
+            .fniv = gen_vaddwod_u_s,
+            .fno = gen_helper_xvaddwod_w_hu_h,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fni8 = gen_vaddwod_d_wu_w,
+            .fniv = gen_vaddwod_u_s,
+            .fno = gen_helper_xvaddwod_d_wu_w,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+        {
+            .fno = gen_helper_xvaddwod_q_du_d,
+            .vece = MO_128
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvaddwod_h_bu_b, gvec_xxx, MO_8, do_xvaddwod_u_s)
+TRANS(xvaddwod_w_hu_h, gvec_xxx, MO_16, do_xvaddwod_u_s)
+TRANS(xvaddwod_d_wu_w, gvec_xxx, MO_32, do_xvaddwod_u_s)
+TRANS(xvaddwod_q_du_d, gvec_xxx, MO_64, do_xvaddwod_u_s)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 48556b2267..1d177f9676 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1376,6 +1376,51 @@ xvhsubw_wu_hu    0111 01000101 10101 ..... ..... .....    @xxx
 xvhsubw_du_wu    0111 01000101 10110 ..... ..... .....    @xxx
 xvhsubw_qu_du    0111 01000101 10111 ..... ..... .....    @xxx
 
+xvaddwev_h_b     0111 01000001 11100 ..... ..... .....    @xxx
+xvaddwev_w_h     0111 01000001 11101 ..... ..... .....    @xxx
+xvaddwev_d_w     0111 01000001 11110 ..... ..... .....    @xxx
+xvaddwev_q_d     0111 01000001 11111 ..... ..... .....    @xxx
+xvaddwod_h_b     0111 01000010 00100 ..... ..... .....    @xxx
+xvaddwod_w_h     0111 01000010 00101 ..... ..... .....    @xxx
+xvaddwod_d_w     0111 01000010 00110 ..... ..... .....    @xxx
+xvaddwod_q_d     0111 01000010 00111 ..... ..... .....    @xxx
+
+xvsubwev_h_b     0111 01000010 00000 ..... ..... .....    @xxx
+xvsubwev_w_h     0111 01000010 00001 ..... ..... .....    @xxx
+xvsubwev_d_w     0111 01000010 00010 ..... ..... .....    @xxx
+xvsubwev_q_d     0111 01000010 00011 ..... ..... .....    @xxx
+xvsubwod_h_b     0111 01000010 01000 ..... ..... .....    @xxx
+xvsubwod_w_h     0111 01000010 01001 ..... ..... .....    @xxx
+xvsubwod_d_w     0111 01000010 01010 ..... ..... .....    @xxx
+xvsubwod_q_d     0111 01000010 01011 ..... ..... .....    @xxx
+
+xvaddwev_h_bu    0111 01000010 11100 ..... ..... .....    @xxx
+xvaddwev_w_hu    0111 01000010 11101 ..... ..... .....    @xxx
+xvaddwev_d_wu    0111 01000010 11110 ..... ..... .....    @xxx
+xvaddwev_q_du    0111 01000010 11111 ..... ..... .....    @xxx
+xvaddwod_h_bu    0111 01000011 00100 ..... ..... .....    @xxx
+xvaddwod_w_hu    0111 01000011 00101 ..... ..... .....    @xxx
+xvaddwod_d_wu    0111 01000011 00110 ..... ..... .....    @xxx
+xvaddwod_q_du    0111 01000011 00111 ..... ..... .....    @xxx
+
+xvsubwev_h_bu    0111 01000011 00000 ..... ..... .....    @xxx
+xvsubwev_w_hu    0111 01000011 00001 ..... ..... .....    @xxx
+xvsubwev_d_wu    0111 01000011 00010 ..... ..... .....    @xxx
+xvsubwev_q_du    0111 01000011 00011 ..... ..... .....    @xxx
+xvsubwod_h_bu    0111 01000011 01000 ..... ..... .....    @xxx
+xvsubwod_w_hu    0111 01000011 01001 ..... ..... .....    @xxx
+xvsubwod_d_wu    0111 01000011 01010 ..... ..... .....    @xxx
+xvsubwod_q_du    0111 01000011 01011 ..... ..... .....    @xxx
+
+xvaddwev_h_bu_b  0111 01000011 11100 ..... ..... .....    @xxx
+xvaddwev_w_hu_h  0111 01000011 11101 ..... ..... .....    @xxx
+xvaddwev_d_wu_w  0111 01000011 11110 ..... ..... .....    @xxx
+xvaddwev_q_du_d  0111 01000011 11111 ..... ..... .....    @xxx
+xvaddwod_h_bu_b  0111 01000100 00000 ..... ..... .....    @xxx
+xvaddwod_w_hu_h  0111 01000100 00001 ..... ..... .....    @xxx
+xvaddwod_d_wu_w  0111 01000100 00010 ..... ..... .....    @xxx
+xvaddwod_q_du_d  0111 01000100 00011 ..... ..... .....    @xxx
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index d86381ff8a..8e830e1f3c 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -94,3 +94,217 @@ void HELPER(xvhsubw_qu_du)(CPULoongArchState *env,
     Xd->XQ(1) = int128_sub(int128_make64(Xj->UXD(3)),
                            int128_make64(Xk->UXD(2)));
 }
+
+#define XDO_EVEN(NAME, BIT, E1, E2, DO_OP)                       \
+void HELPER(NAME)(void *xd, void *xj, void *xk, uint32_t v)      \
+{                                                                \
+    int i;                                                       \
+    XReg *Xd = (XReg *)xd;                                       \
+    XReg *Xj = (XReg *)xj;                                       \
+    XReg *Xk = (XReg *)xk;                                       \
+    typedef __typeof(Xd->E1(0)) TD;                              \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                       \
+        Xd->E1(i) = DO_OP((TD)Xj->E2(2 * i), (TD)Xk->E2(2 * i)); \
+    }                                                            \
+}
+
+#define XDO_ODD(NAME, BIT, E1, E2, DO_OP)                                \
+void HELPER(NAME)(void *xd, void *xj, void *xk, uint32_t v)              \
+{                                                                        \
+    int i;                                                               \
+    XReg *Xd = (XReg *)xd;                                               \
+    XReg *Xj = (XReg *)xj;                                               \
+    XReg *Xk = (XReg *)xk;                                               \
+    typedef __typeof(Xd->E1(0)) TD;                                      \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                               \
+        Xd->E1(i) = DO_OP((TD)Xj->E2(2 * i + 1), (TD)Xk->E2(2 * i + 1)); \
+    }                                                                    \
+}
+
+void HELPER(xvaddwev_q_d)(void *xd, void *xj, void *xk, uint32_t v)
+{
+    XReg *Xd = (XReg *)xd;
+    XReg *Xj = (XReg *)xj;
+    XReg *Xk = (XReg *)xk;
+
+    Xd->XQ(0) = int128_add(int128_makes64(Xj->XD(0)),
+                           int128_makes64(Xk->XD(0)));
+    Xd->XQ(1) = int128_add(int128_makes64(Xj->XD(2)),
+                           int128_makes64(Xk->XD(2)));
+}
+
+XDO_EVEN(xvaddwev_h_b, 16, XH, XB, DO_ADD)
+XDO_EVEN(xvaddwev_w_h, 32, XW, XH, DO_ADD)
+XDO_EVEN(xvaddwev_d_w, 64, XD, XW, DO_ADD)
+
+void HELPER(xvaddwod_q_d)(void *xd, void *xj, void *xk, uint32_t v)
+{
+    XReg *Xd = (XReg *)xd;
+    XReg *Xj = (XReg *)xj;
+    XReg *Xk = (XReg *)xk;
+
+    Xd->XQ(0) = int128_add(int128_makes64(Xj->XD(1)),
+                           int128_makes64(Xk->XD(1)));
+    Xd->XQ(1) = int128_add(int128_makes64(Xj->XD(3)),
+                           int128_makes64(Xk->XD(3)));
+}
+
+XDO_ODD(xvaddwod_h_b, 16, XH, XB, DO_ADD)
+XDO_ODD(xvaddwod_w_h, 32, XW, XH, DO_ADD)
+XDO_ODD(xvaddwod_d_w, 64, XD, XW, DO_ADD)
+
+void HELPER(xvsubwev_q_d)(void *xd, void *xj, void *xk, uint32_t v)
+{
+    XReg *Xd = (XReg *)xd;
+    XReg *Xj = (XReg *)xj;
+    XReg *Xk = (XReg *)xk;
+
+    Xd->XQ(0) = int128_sub(int128_makes64(Xj->XD(0)),
+                           int128_makes64(Xk->XD(0)));
+    Xd->XQ(1) = int128_sub(int128_makes64(Xj->XD(2)),
+                           int128_makes64(Xk->XD(2)));
+}
+
+XDO_EVEN(xvsubwev_h_b, 16, XH, XB, DO_SUB)
+XDO_EVEN(xvsubwev_w_h, 32, XW, XH, DO_SUB)
+XDO_EVEN(xvsubwev_d_w, 64, XD, XW, DO_SUB)
+
+void HELPER(xvsubwod_q_d)(void *xd, void *xj, void *xk, uint32_t v)
+{
+    XReg *Xd = (XReg *)xd;
+    XReg *Xj = (XReg *)xj;
+    XReg *Xk = (XReg *)xk;
+
+    Xd->XQ(0) = int128_sub(int128_makes64(Xj->XD(1)),
+                           int128_makes64(Xk->XD(1)));
+    Xd->XQ(1) = int128_sub(int128_makes64(Xj->XD(3)),
+                           int128_makes64(Xk->XD(3)));
+}
+
+XDO_ODD(xvsubwod_h_b, 16, XH, XB, DO_SUB)
+XDO_ODD(xvsubwod_w_h, 32, XW, XH, DO_SUB)
+XDO_ODD(xvsubwod_d_w, 64, XD, XW, DO_SUB)
+
+void HELPER(xvaddwev_q_du)(void *xd, void *xj, void *xk, uint32_t v)
+{
+    XReg *Xd = (XReg *)xd;
+    XReg *Xj = (XReg *)xj;
+    XReg *Xk = (XReg *)xk;
+
+    Xd->XQ(0) = int128_add(int128_make64(Xj->UXD(0)),
+                           int128_make64(Xk->UXD(0)));
+    Xd->XQ(1) = int128_add(int128_make64(Xj->UXD(2)),
+                           int128_make64(Xk->UXD(2)));
+}
+
+XDO_EVEN(xvaddwev_h_bu, 16, UXH, UXB, DO_ADD)
+XDO_EVEN(xvaddwev_w_hu, 32, UXW, UXH, DO_ADD)
+XDO_EVEN(xvaddwev_d_wu, 64, UXD, UXW, DO_ADD)
+
+void HELPER(xvaddwod_q_du)(void *xd, void *xj, void *xk, uint32_t v)
+{
+    XReg *Xd = (XReg *)xd;
+    XReg *Xj = (XReg *)xj;
+    XReg *Xk = (XReg *)xk;
+
+    Xd->XQ(0) = int128_add(int128_make64(Xj->UXD(1)),
+                           int128_make64(Xk->UXD(1)));
+    Xd->XQ(1) = int128_add(int128_make64(Xj->UXD(3)),
+                           int128_make64(Xk->UXD(3)));
+}
+
+XDO_ODD(xvaddwod_h_bu, 16, UXH, UXB, DO_ADD)
+XDO_ODD(xvaddwod_w_hu, 32, UXW, UXH, DO_ADD)
+XDO_ODD(xvaddwod_d_wu, 64, UXD, UXW, DO_ADD)
+
+void HELPER(xvsubwev_q_du)(void *xd, void *xj, void *xk, uint32_t v)
+{
+    XReg *Xd = (XReg *)xd;
+    XReg *Xj = (XReg *)xj;
+    XReg *Xk = (XReg *)xk;
+
+    Xd->XQ(0) = int128_sub(int128_make64(Xj->UXD(0)),
+                           int128_make64(Xk->UXD(0)));
+    Xd->XQ(1) = int128_sub(int128_make64(Xj->UXD(2)),
+                           int128_make64(Xk->UXD(2)));
+}
+
+XDO_EVEN(xvsubwev_h_bu, 16, UXH, UXB, DO_SUB)
+XDO_EVEN(xvsubwev_w_hu, 32, UXW, UXH, DO_SUB)
+XDO_EVEN(xvsubwev_d_wu, 64, UXD, UXW, DO_SUB)
+
+void HELPER(xvsubwod_q_du)(void *xd, void *xj, void *xk, uint32_t v)
+{
+    XReg *Xd = (XReg *)xd;
+    XReg *Xj = (XReg *)xj;
+    XReg *Xk = (XReg *)xk;
+
+    Xd->XQ(0) = int128_sub(int128_make64(Xj->UXD(1)),
+                           int128_make64(Xk->UXD(1)));
+    Xd->XQ(1) = int128_sub(int128_make64(Xj->UXD(3)),
+                           int128_make64(Xk->UXD(3)));
+}
+
+XDO_ODD(xvsubwod_h_bu, 16, UXH, UXB, DO_SUB)
+XDO_ODD(xvsubwod_w_hu, 32, UXW, UXH, DO_SUB)
+XDO_ODD(xvsubwod_d_wu, 64, UXD, UXW, DO_SUB)
+
+#define XDO_EVEN_U_S(NAME, BIT, ES1, EU1, ES2, EU2, DO_OP)            \
+void HELPER(NAME)(void *xd, void *xj, void *xk, uint32_t v)           \
+{                                                                     \
+    int i;                                                            \
+    XReg *Xd = (XReg *)xd;                                            \
+    XReg *Xj = (XReg *)xj;                                            \
+    XReg *Xk = (XReg *)xk;                                            \
+    typedef __typeof(Xd->ES1(0)) TDS;                                 \
+    typedef __typeof(Xd->EU1(0)) TDU;                                 \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                            \
+        Xd->ES1(i) = DO_OP((TDU)Xj->EU2(2 * i), (TDS)Xk->ES2(2 * i)); \
+    }                                                                 \
+}
+
+#define XDO_ODD_U_S(NAME, BIT, ES1, EU1, ES2, EU2, DO_OP)                     \
+void HELPER(NAME)(void *xd, void *xj, void *xk, uint32_t v)                   \
+{                                                                             \
+    int i;                                                                    \
+    XReg *Xd = (XReg *)xd;                                                    \
+    XReg *Xj = (XReg *)xj;                                                    \
+    XReg *Xk = (XReg *)xk;                                                    \
+    typedef __typeof(Xd->ES1(0)) TDS;                                         \
+    typedef __typeof(Xd->EU1(0)) TDU;                                         \
+    for (i = 0; i < LSX_LEN / BIT; i++) {                                     \
+        Xd->ES1(i) = DO_OP((TDU)Xj->EU2(2 * i + 1), (TDS)Xk->ES2(2 * i + 1)); \
+    }                                                                         \
+}
+
+void HELPER(xvaddwev_q_du_d)(void *xd, void *xj, void *xk, uint32_t v)
+{
+    XReg *Xd = (XReg *)xd;
+    XReg *Xj = (XReg *)xj;
+    XReg *Xk = (XReg *)xk;
+
+    Xd->XQ(0) = int128_add(int128_make64(Xj->UXD(0)),
+                           int128_makes64(Xk->XD(0)));
+    Xd->XQ(1) = int128_add(int128_make64(Xj->UXD(2)),
+                           int128_makes64(Xk->XD(2)));
+}
+
+XDO_EVEN_U_S(xvaddwev_h_bu_b, 16, XH, UXH, XB, UXB, DO_ADD)
+XDO_EVEN_U_S(xvaddwev_w_hu_h, 32, XW, UXW, XH, UXH, DO_ADD)
+XDO_EVEN_U_S(xvaddwev_d_wu_w, 64, XD, UXD, XW, UXW, DO_ADD)
+
+void HELPER(xvaddwod_q_du_d)(void *xd, void *xj, void *xk, uint32_t v)
+{
+    XReg *Xd = (XReg *)xd;
+    XReg *Xj = (XReg *)xj;
+    XReg *Xk = (XReg *)xk;
+
+    Xd->XQ(0) = int128_add(int128_make64(Xj->UXD(1)),
+                           int128_makes64(Xk->XD(1)));
+    Xd->XQ(1) = int128_add(int128_make64(Xj->UXD(3)),
+                           int128_makes64(Xk->XD(3)));
+}
+
+XDO_ODD_U_S(xvaddwod_h_bu_b, 16, XH, UXH, XB, UXB, DO_ADD)
+XDO_ODD_U_S(xvaddwod_w_hu_h, 32, XW, UXW, XH, UXH, DO_ADD)
+XDO_ODD_U_S(xvaddwod_d_wu_w, 64, XD, UXD, XW, UXW, DO_ADD)
-- 
2.39.1


