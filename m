Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D23D273683D
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:46:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXqZ-0003Dx-3B; Tue, 20 Jun 2023 05:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXqR-0002jL-NO
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:40:16 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXqM-0006aO-Jk
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:40:15 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxW+qNc5FknyUHAA--.14683S3;
 Tue, 20 Jun 2023 17:38:21 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S13; 
 Tue, 20 Jun 2023 17:38:21 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 11/46] target/loongarch: Implement xavg/xvagr
Date: Tue, 20 Jun 2023 17:37:39 +0800
Message-Id: <20230620093814.123650-12-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S13
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
- XVAVG.{B/H/W/D/}[U];
- XVAVGR.{B/H/W/D}[U].

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  17 ++
 target/loongarch/helper.h                    |  18 +++
 target/loongarch/insn_trans/trans_lasx.c.inc | 162 +++++++++++++++++++
 target/loongarch/insns.decode                |  17 ++
 target/loongarch/lasx_helper.c               |  29 ++++
 target/loongarch/vec.h                       |   3 +
 6 files changed, 246 insertions(+)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 6e790f0959..d804caaee0 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1825,6 +1825,23 @@ INSN_LASX(xvaddwod_w_hu_h,   xxx)
 INSN_LASX(xvaddwod_d_wu_w,   xxx)
 INSN_LASX(xvaddwod_q_du_d,   xxx)
 
+INSN_LASX(xvavg_b,           xxx)
+INSN_LASX(xvavg_h,           xxx)
+INSN_LASX(xvavg_w,           xxx)
+INSN_LASX(xvavg_d,           xxx)
+INSN_LASX(xvavg_bu,          xxx)
+INSN_LASX(xvavg_hu,          xxx)
+INSN_LASX(xvavg_wu,          xxx)
+INSN_LASX(xvavg_du,          xxx)
+INSN_LASX(xvavgr_b,          xxx)
+INSN_LASX(xvavgr_h,          xxx)
+INSN_LASX(xvavgr_w,          xxx)
+INSN_LASX(xvavgr_d,          xxx)
+INSN_LASX(xvavgr_bu,         xxx)
+INSN_LASX(xvavgr_hu,         xxx)
+INSN_LASX(xvavgr_wu,         xxx)
+INSN_LASX(xvavgr_du,         xxx)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 2034576d87..feeaa92447 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -759,3 +759,21 @@ DEF_HELPER_FLAGS_4(xvaddwod_h_bu_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(xvaddwod_w_hu_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(xvaddwod_d_wu_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(xvaddwod_q_du_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(xvavg_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvavg_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvavg_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvavg_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvavg_bu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvavg_hu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvavg_wu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvavg_du, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(xvavgr_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvavgr_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvavgr_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvavgr_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvavgr_bu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvavgr_hu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvavgr_wu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvavgr_du, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 0a574182db..4a8bcf618f 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -588,6 +588,168 @@ TRANS(xvaddwod_w_hu_h, gvec_xxx, MO_16, do_xvaddwod_u_s)
 TRANS(xvaddwod_d_wu_w, gvec_xxx, MO_32, do_xvaddwod_u_s)
 TRANS(xvaddwod_q_du_d, gvec_xxx, MO_64, do_xvaddwod_u_s)
 
+static void do_xvavg_s(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                       uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sari_vec, INDEX_op_add_vec, 0
+        };
+    static const GVecGen3 op[4] = {
+        {
+            .fniv = gen_vavg_s,
+            .fno = gen_helper_xvavg_b,
+            .opt_opc = vecop_list,
+            .vece = MO_8
+        },
+        {
+            .fniv = gen_vavg_s,
+            .fno = gen_helper_xvavg_h,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fniv = gen_vavg_s,
+            .fno = gen_helper_xvavg_w,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fniv = gen_vavg_s,
+            .fno = gen_helper_xvavg_d,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+static void do_xvavg_u(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                       uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shri_vec, INDEX_op_add_vec, 0
+        };
+    static const GVecGen3 op[4] = {
+        {
+            .fniv = gen_vavg_u,
+            .fno = gen_helper_xvavg_bu,
+            .opt_opc = vecop_list,
+            .vece = MO_8
+        },
+        {
+            .fniv = gen_vavg_u,
+            .fno = gen_helper_xvavg_hu,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fniv = gen_vavg_u,
+            .fno = gen_helper_xvavg_wu,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fniv = gen_vavg_u,
+            .fno = gen_helper_xvavg_du,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvavg_b, gvec_xxx, MO_8, do_xvavg_s)
+TRANS(xvavg_h, gvec_xxx, MO_16, do_xvavg_s)
+TRANS(xvavg_w, gvec_xxx, MO_32, do_xvavg_s)
+TRANS(xvavg_d, gvec_xxx, MO_64, do_xvavg_s)
+TRANS(xvavg_bu, gvec_xxx, MO_8, do_xvavg_u)
+TRANS(xvavg_hu, gvec_xxx, MO_16, do_xvavg_u)
+TRANS(xvavg_wu, gvec_xxx, MO_32, do_xvavg_u)
+TRANS(xvavg_du, gvec_xxx, MO_64, do_xvavg_u)
+
+static void do_xvavgr_s(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                        uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sari_vec, INDEX_op_add_vec, 0
+        };
+    static const GVecGen3 op[4] = {
+        {
+            .fniv = gen_vavgr_s,
+            .fno = gen_helper_xvavgr_b,
+            .opt_opc = vecop_list,
+            .vece = MO_8
+        },
+        {
+            .fniv = gen_vavgr_s,
+            .fno = gen_helper_xvavgr_h,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fniv = gen_vavgr_s,
+            .fno = gen_helper_xvavgr_w,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fniv = gen_vavgr_s,
+            .fno = gen_helper_xvavgr_d,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+static void do_xvavgr_u(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                        uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shri_vec, INDEX_op_add_vec, 0
+        };
+    static const GVecGen3 op[4] = {
+        {
+            .fniv = gen_vavgr_u,
+            .fno = gen_helper_xvavgr_bu,
+            .opt_opc = vecop_list,
+            .vece = MO_8
+        },
+        {
+            .fniv = gen_vavgr_u,
+            .fno = gen_helper_xvavgr_hu,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fniv = gen_vavgr_u,
+            .fno = gen_helper_xvavgr_wu,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fniv = gen_vavgr_u,
+            .fno = gen_helper_xvavgr_du,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvavgr_b, gvec_xxx, MO_8, do_xvavgr_s)
+TRANS(xvavgr_h, gvec_xxx, MO_16, do_xvavgr_s)
+TRANS(xvavgr_w, gvec_xxx, MO_32, do_xvavgr_s)
+TRANS(xvavgr_d, gvec_xxx, MO_64, do_xvavgr_s)
+TRANS(xvavgr_bu, gvec_xxx, MO_8, do_xvavgr_u)
+TRANS(xvavgr_hu, gvec_xxx, MO_16, do_xvavgr_u)
+TRANS(xvavgr_wu, gvec_xxx, MO_32, do_xvavgr_u)
+TRANS(xvavgr_du, gvec_xxx, MO_64, do_xvavgr_u)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 1d177f9676..0057aaf1d4 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1421,6 +1421,23 @@ xvaddwod_w_hu_h  0111 01000100 00001 ..... ..... .....    @xxx
 xvaddwod_d_wu_w  0111 01000100 00010 ..... ..... .....    @xxx
 xvaddwod_q_du_d  0111 01000100 00011 ..... ..... .....    @xxx
 
+xvavg_b          0111 01000110 01000 ..... ..... .....    @xxx
+xvavg_h          0111 01000110 01001 ..... ..... .....    @xxx
+xvavg_w          0111 01000110 01010 ..... ..... .....    @xxx
+xvavg_d          0111 01000110 01011 ..... ..... .....    @xxx
+xvavg_bu         0111 01000110 01100 ..... ..... .....    @xxx
+xvavg_hu         0111 01000110 01101 ..... ..... .....    @xxx
+xvavg_wu         0111 01000110 01110 ..... ..... .....    @xxx
+xvavg_du         0111 01000110 01111 ..... ..... .....    @xxx
+xvavgr_b         0111 01000110 10000 ..... ..... .....    @xxx
+xvavgr_h         0111 01000110 10001 ..... ..... .....    @xxx
+xvavgr_w         0111 01000110 10010 ..... ..... .....    @xxx
+xvavgr_d         0111 01000110 10011 ..... ..... .....    @xxx
+xvavgr_bu        0111 01000110 10100 ..... ..... .....    @xxx
+xvavgr_hu        0111 01000110 10101 ..... ..... .....    @xxx
+xvavgr_wu        0111 01000110 10110 ..... ..... .....    @xxx
+xvavgr_du        0111 01000110 10111 ..... ..... .....    @xxx
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index 8e830e1f3c..8e1bcdb764 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -308,3 +308,32 @@ void HELPER(xvaddwod_q_du_d)(void *xd, void *xj, void *xk, uint32_t v)
 XDO_ODD_U_S(xvaddwod_h_bu_b, 16, XH, UXH, XB, UXB, DO_ADD)
 XDO_ODD_U_S(xvaddwod_w_hu_h, 32, XW, UXW, XH, UXH, DO_ADD)
 XDO_ODD_U_S(xvaddwod_d_wu_w, 64, XD, UXD, XW, UXW, DO_ADD)
+
+#define XDO_3OP(NAME, BIT, E, DO_OP)                        \
+void HELPER(NAME)(void *xd, void *xj, void *xk, uint32_t v) \
+{                                                           \
+    int i;                                                  \
+    XReg *Xd = (XReg *)xd;                                  \
+    XReg *Xj = (XReg *)xj;                                  \
+    XReg *Xk = (XReg *)xk;                                  \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                  \
+        Xd->E(i) = DO_OP(Xj->E(i), Xk->E(i));               \
+    }                                                       \
+}
+
+XDO_3OP(xvavg_b, 8, XB, DO_VAVG)
+XDO_3OP(xvavg_h, 16, XH, DO_VAVG)
+XDO_3OP(xvavg_w, 32, XW, DO_VAVG)
+XDO_3OP(xvavg_d, 64, XD, DO_VAVG)
+XDO_3OP(xvavgr_b, 8, XB, DO_VAVGR)
+XDO_3OP(xvavgr_h, 16, XH, DO_VAVGR)
+XDO_3OP(xvavgr_w, 32, XW, DO_VAVGR)
+XDO_3OP(xvavgr_d, 64, XD, DO_VAVGR)
+XDO_3OP(xvavg_bu, 8, UXB, DO_VAVG)
+XDO_3OP(xvavg_hu, 16, UXH, DO_VAVG)
+XDO_3OP(xvavg_wu, 32, UXW, DO_VAVG)
+XDO_3OP(xvavg_du, 64, UXD, DO_VAVG)
+XDO_3OP(xvavgr_bu, 8, UXB, DO_VAVGR)
+XDO_3OP(xvavgr_hu, 16, UXH, DO_VAVGR)
+XDO_3OP(xvavgr_wu, 32, UXW, DO_VAVGR)
+XDO_3OP(xvavgr_du, 64, UXD, DO_VAVGR)
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index 7e71035e50..2a9c312e3d 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -51,4 +51,7 @@
 #define DO_ADD(a, b)  (a + b)
 #define DO_SUB(a, b)  (a - b)
 
+#define DO_VAVG(a, b)  ((a >> 1) + (b >> 1) + (a & b & 1))
+#define DO_VAVGR(a, b) ((a >> 1) + (b >> 1) + ((a | b) & 1))
+
 #endif /* LOONGARCH_VEC_H */
-- 
2.39.1


