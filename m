Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC7C73680C
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:42:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXqc-0003oO-HE; Tue, 20 Jun 2023 05:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXqV-0002sK-7F
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:40:19 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXqM-0006aS-PK
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:40:17 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Ax0OiOc5FkpiUHAA--.12766S3;
 Tue, 20 Jun 2023 17:38:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S16; 
 Tue, 20 Jun 2023 17:38:22 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 14/46] target/loongarch: Implement xvmax/xvmin
Date: Tue, 20 Jun 2023 17:37:42 +0800
Message-Id: <20230620093814.123650-15-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S16
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
- XVMAX[I].{B/H/W/D}[U];
- XVMIN[I].{B/H/W/D}[U].

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  33 ++++
 target/loongarch/helper.h                    |  18 ++
 target/loongarch/insn_trans/trans_lasx.c.inc | 180 +++++++++++++++++++
 target/loongarch/insns.decode                |  37 ++++
 target/loongarch/lasx_helper.c               |  30 ++++
 target/loongarch/lsx_helper.c                |   3 -
 target/loongarch/vec.h                       |   3 +
 7 files changed, 301 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index cc92f0e763..ff22fcb90e 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1856,6 +1856,39 @@ INSN_LASX(xvadda_h,          xxx)
 INSN_LASX(xvadda_w,          xxx)
 INSN_LASX(xvadda_d,          xxx)
 
+INSN_LASX(xvmax_b,           xxx)
+INSN_LASX(xvmax_h,           xxx)
+INSN_LASX(xvmax_w,           xxx)
+INSN_LASX(xvmax_d,           xxx)
+INSN_LASX(xvmin_b,           xxx)
+INSN_LASX(xvmin_h,           xxx)
+INSN_LASX(xvmin_w,           xxx)
+INSN_LASX(xvmin_d,           xxx)
+INSN_LASX(xvmax_bu,          xxx)
+INSN_LASX(xvmax_hu,          xxx)
+INSN_LASX(xvmax_wu,          xxx)
+INSN_LASX(xvmax_du,          xxx)
+INSN_LASX(xvmin_bu,          xxx)
+INSN_LASX(xvmin_hu,          xxx)
+INSN_LASX(xvmin_wu,          xxx)
+INSN_LASX(xvmin_du,          xxx)
+INSN_LASX(xvmaxi_b,          xx_i)
+INSN_LASX(xvmaxi_h,          xx_i)
+INSN_LASX(xvmaxi_w,          xx_i)
+INSN_LASX(xvmaxi_d,          xx_i)
+INSN_LASX(xvmini_b,          xx_i)
+INSN_LASX(xvmini_h,          xx_i)
+INSN_LASX(xvmini_w,          xx_i)
+INSN_LASX(xvmini_d,          xx_i)
+INSN_LASX(xvmaxi_bu,         xx_i)
+INSN_LASX(xvmaxi_hu,         xx_i)
+INSN_LASX(xvmaxi_wu,         xx_i)
+INSN_LASX(xvmaxi_du,         xx_i)
+INSN_LASX(xvmini_bu,         xx_i)
+INSN_LASX(xvmini_hu,         xx_i)
+INSN_LASX(xvmini_wu,         xx_i)
+INSN_LASX(xvmini_du,         xx_i)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 67ef7491c4..d5ebc0b963 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -791,3 +791,21 @@ DEF_HELPER_FLAGS_4(xvadda_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(xvadda_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(xvadda_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(xvadda_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(xvmini_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvmini_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvmini_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvmini_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvmini_bu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvmini_hu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvmini_wu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvmini_du, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_FLAGS_4(xvmaxi_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvmaxi_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvmaxi_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvmaxi_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvmaxi_bu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvmaxi_hu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvmaxi_wu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvmaxi_du, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 4b2e50de68..cdf3dcc161 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -872,6 +872,186 @@ TRANS(xvadda_h, gvec_xxx, MO_16, do_xvadda)
 TRANS(xvadda_w, gvec_xxx, MO_32, do_xvadda)
 TRANS(xvadda_d, gvec_xxx, MO_64, do_xvadda)
 
+TRANS(xvmax_b, gvec_xxx, MO_8, tcg_gen_gvec_smax)
+TRANS(xvmax_h, gvec_xxx, MO_16, tcg_gen_gvec_smax)
+TRANS(xvmax_w, gvec_xxx, MO_32, tcg_gen_gvec_smax)
+TRANS(xvmax_d, gvec_xxx, MO_64, tcg_gen_gvec_smax)
+TRANS(xvmax_bu, gvec_xxx, MO_8, tcg_gen_gvec_umax)
+TRANS(xvmax_hu, gvec_xxx, MO_16, tcg_gen_gvec_umax)
+TRANS(xvmax_wu, gvec_xxx, MO_32, tcg_gen_gvec_umax)
+TRANS(xvmax_du, gvec_xxx, MO_64, tcg_gen_gvec_umax)
+
+TRANS(xvmin_b, gvec_xxx, MO_8, tcg_gen_gvec_smin)
+TRANS(xvmin_h, gvec_xxx, MO_16, tcg_gen_gvec_smin)
+TRANS(xvmin_w, gvec_xxx, MO_32, tcg_gen_gvec_smin)
+TRANS(xvmin_d, gvec_xxx, MO_64, tcg_gen_gvec_smin)
+TRANS(xvmin_bu, gvec_xxx, MO_8, tcg_gen_gvec_umin)
+TRANS(xvmin_hu, gvec_xxx, MO_16, tcg_gen_gvec_umin)
+TRANS(xvmin_wu, gvec_xxx, MO_32, tcg_gen_gvec_umin)
+TRANS(xvmin_du, gvec_xxx, MO_64, tcg_gen_gvec_umin)
+
+static void do_xvmini_s(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                        int64_t imm, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_smin_vec, 0
+        };
+    static const GVecGen2i op[4] = {
+        {
+            .fniv = gen_vmini_s,
+            .fnoi = gen_helper_xvmini_b,
+            .opt_opc = vecop_list,
+            .vece = MO_8
+        },
+        {
+            .fniv = gen_vmini_s,
+            .fnoi = gen_helper_xvmini_h,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fniv = gen_vmini_s,
+            .fnoi = gen_helper_xvmini_w,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fniv = gen_vmini_s,
+            .fnoi = gen_helper_xvmini_d,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_2i(xd_ofs, xj_ofs, oprsz, maxsz, imm, &op[vece]);
+}
+
+static void do_xvmini_u(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                        int64_t imm, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_umin_vec, 0
+        };
+    static const GVecGen2i op[4] = {
+        {
+            .fniv = gen_vmini_u,
+            .fnoi = gen_helper_xvmini_bu,
+            .opt_opc = vecop_list,
+            .vece = MO_8
+        },
+        {
+            .fniv = gen_vmini_u,
+            .fnoi = gen_helper_xvmini_hu,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fniv = gen_vmini_u,
+            .fnoi = gen_helper_xvmini_wu,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fniv = gen_vmini_u,
+            .fnoi = gen_helper_xvmini_du,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_2i(xd_ofs, xj_ofs, oprsz, maxsz, imm, &op[vece]);
+}
+
+TRANS(xvmini_b, gvec_xx_i, MO_8, do_xvmini_s)
+TRANS(xvmini_h, gvec_xx_i, MO_16, do_xvmini_s)
+TRANS(xvmini_w, gvec_xx_i, MO_32, do_xvmini_s)
+TRANS(xvmini_d, gvec_xx_i, MO_64, do_xvmini_s)
+TRANS(xvmini_bu, gvec_xx_i, MO_8, do_xvmini_u)
+TRANS(xvmini_hu, gvec_xx_i, MO_16, do_xvmini_u)
+TRANS(xvmini_wu, gvec_xx_i, MO_32, do_xvmini_u)
+TRANS(xvmini_du, gvec_xx_i, MO_64, do_xvmini_u)
+
+static void do_xvmaxi_s(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                        int64_t imm, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_smax_vec, 0
+        };
+    static const GVecGen2i op[4] = {
+        {
+            .fniv = gen_vmaxi_s,
+            .fnoi = gen_helper_xvmaxi_b,
+            .opt_opc = vecop_list,
+            .vece = MO_8
+        },
+        {
+            .fniv = gen_vmaxi_s,
+            .fnoi = gen_helper_xvmaxi_h,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fniv = gen_vmaxi_s,
+            .fnoi = gen_helper_xvmaxi_w,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fniv = gen_vmaxi_s,
+            .fnoi = gen_helper_xvmaxi_d,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_2i(xd_ofs, xj_ofs, oprsz, maxsz, imm, &op[vece]);
+}
+
+static void do_xvmaxi_u(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                        int64_t imm, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_umax_vec, 0
+        };
+    static const GVecGen2i op[4] = {
+        {
+            .fniv = gen_vmaxi_u,
+            .fnoi = gen_helper_xvmaxi_bu,
+            .opt_opc = vecop_list,
+            .vece = MO_8
+        },
+        {
+            .fniv = gen_vmaxi_u,
+            .fnoi = gen_helper_xvmaxi_hu,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fniv = gen_vmaxi_u,
+            .fnoi = gen_helper_xvmaxi_wu,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fniv = gen_vmaxi_u,
+            .fnoi = gen_helper_xvmaxi_du,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_2i(xd_ofs, xj_ofs, oprsz, maxsz, imm, &op[vece]);
+}
+
+TRANS(xvmaxi_b, gvec_xx_i, MO_8, do_xvmaxi_s)
+TRANS(xvmaxi_h, gvec_xx_i, MO_16, do_xvmaxi_s)
+TRANS(xvmaxi_w, gvec_xx_i, MO_32, do_xvmaxi_s)
+TRANS(xvmaxi_d, gvec_xx_i, MO_64, do_xvmaxi_s)
+TRANS(xvmaxi_bu, gvec_xx_i, MO_8, do_xvmaxi_u)
+TRANS(xvmaxi_hu, gvec_xx_i, MO_16, do_xvmaxi_u)
+TRANS(xvmaxi_wu, gvec_xx_i, MO_32, do_xvmaxi_u)
+TRANS(xvmaxi_du, gvec_xx_i, MO_64, do_xvmaxi_u)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index f8a17f262a..29666f7925 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1313,6 +1313,7 @@ vstelm_b         0011 000110 .... ........ ..... .....    @vr_i8i4
 @xx                .... ........ ..... ..... xj:5 xd:5    &xx
 @xxx                .... ........ ..... xk:5 xj:5 xd:5    &xxx
 @xr                .... ........ ..... ..... rj:5 xd:5    &xr
+@xx_i5            .... ........ ..... imm:s5 xj:5 xd:5    &xx_i
 @xx_ui5            .... ........ ..... imm:5 xj:5 xd:5    &xx_i
 
 xvadd_b          0111 01000000 10100 ..... ..... .....    @xxx
@@ -1452,6 +1453,42 @@ xvadda_h         0111 01000101 11001 ..... ..... .....    @xxx
 xvadda_w         0111 01000101 11010 ..... ..... .....    @xxx
 xvadda_d         0111 01000101 11011 ..... ..... .....    @xxx
 
+xvmax_b          0111 01000111 00000 ..... ..... .....    @xxx
+xvmax_h          0111 01000111 00001 ..... ..... .....    @xxx
+xvmax_w          0111 01000111 00010 ..... ..... .....    @xxx
+xvmax_d          0111 01000111 00011 ..... ..... .....    @xxx
+xvmax_bu         0111 01000111 01000 ..... ..... .....    @xxx
+xvmax_hu         0111 01000111 01001 ..... ..... .....    @xxx
+xvmax_wu         0111 01000111 01010 ..... ..... .....    @xxx
+xvmax_du         0111 01000111 01011 ..... ..... .....    @xxx
+
+xvmaxi_b         0111 01101001 00000 ..... ..... .....    @xx_i5
+xvmaxi_h         0111 01101001 00001 ..... ..... .....    @xx_i5
+xvmaxi_w         0111 01101001 00010 ..... ..... .....    @xx_i5
+xvmaxi_d         0111 01101001 00011 ..... ..... .....    @xx_i5
+xvmaxi_bu        0111 01101001 01000 ..... ..... .....    @xx_ui5
+xvmaxi_hu        0111 01101001 01001 ..... ..... .....    @xx_ui5
+xvmaxi_wu        0111 01101001 01010 ..... ..... .....    @xx_ui5
+xvmaxi_du        0111 01101001 01011 ..... ..... .....    @xx_ui5
+
+xvmin_b          0111 01000111 00100 ..... ..... .....    @xxx
+xvmin_h          0111 01000111 00101 ..... ..... .....    @xxx
+xvmin_w          0111 01000111 00110 ..... ..... .....    @xxx
+xvmin_d          0111 01000111 00111 ..... ..... .....    @xxx
+xvmin_bu         0111 01000111 01100 ..... ..... .....    @xxx
+xvmin_hu         0111 01000111 01101 ..... ..... .....    @xxx
+xvmin_wu         0111 01000111 01110 ..... ..... .....    @xxx
+xvmin_du         0111 01000111 01111 ..... ..... .....    @xxx
+
+xvmini_b         0111 01101001 00100 ..... ..... .....    @xx_i5
+xvmini_h         0111 01101001 00101 ..... ..... .....    @xx_i5
+xvmini_w         0111 01101001 00110 ..... ..... .....    @xx_i5
+xvmini_d         0111 01101001 00111 ..... ..... .....    @xx_i5
+xvmini_bu        0111 01101001 01100 ..... ..... .....    @xx_ui5
+xvmini_hu        0111 01101001 01101 ..... ..... .....    @xx_ui5
+xvmini_wu        0111 01101001 01110 ..... ..... .....    @xx_ui5
+xvmini_du        0111 01101001 01111 ..... ..... .....    @xx_ui5
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index 52c230a681..486cf9f7f1 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -363,3 +363,33 @@ XDO_VADDA(xvadda_b, 8, XB, DO_VABS)
 XDO_VADDA(xvadda_h, 16, XH, DO_VABS)
 XDO_VADDA(xvadda_w, 32, XW, DO_VABS)
 XDO_VADDA(xvadda_d, 64, XD, DO_VABS)
+
+#define XVMINMAXI(NAME, BIT, E, DO_OP)                          \
+void HELPER(NAME)(void *xd, void *xj, uint64_t imm, uint32_t v) \
+{                                                               \
+    int i;                                                      \
+    XReg *Xd = (XReg *)xd;                                      \
+    XReg *Xj = (XReg *)xj;                                      \
+    typedef __typeof(Xd->E(0)) TD;                              \
+                                                                \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                      \
+        Xd->E(i) = DO_OP(Xj->E(i), (TD)imm);                    \
+    }                                                           \
+}
+
+XVMINMAXI(xvmini_b, 8, XB, DO_MIN)
+XVMINMAXI(xvmini_h, 16, XH, DO_MIN)
+XVMINMAXI(xvmini_w, 32, XW, DO_MIN)
+XVMINMAXI(xvmini_d, 64, XD, DO_MIN)
+XVMINMAXI(xvmaxi_b, 8, XB, DO_MAX)
+XVMINMAXI(xvmaxi_h, 16, XH, DO_MAX)
+XVMINMAXI(xvmaxi_w, 32, XW, DO_MAX)
+XVMINMAXI(xvmaxi_d, 64, XD, DO_MAX)
+XVMINMAXI(xvmini_bu, 8, UXB, DO_MIN)
+XVMINMAXI(xvmini_hu, 16, UXH, DO_MIN)
+XVMINMAXI(xvmini_wu, 32, UXW, DO_MIN)
+XVMINMAXI(xvmini_du, 64, UXD, DO_MIN)
+XVMINMAXI(xvmaxi_bu, 8, UXB, DO_MAX)
+XVMINMAXI(xvmaxi_hu, 16, UXH, DO_MAX)
+XVMINMAXI(xvmaxi_wu, 32, UXW, DO_MAX)
+XVMINMAXI(xvmaxi_du, 64, UXD, DO_MAX)
diff --git a/target/loongarch/lsx_helper.c b/target/loongarch/lsx_helper.c
index 72120c04a4..192cdb164c 100644
--- a/target/loongarch/lsx_helper.c
+++ b/target/loongarch/lsx_helper.c
@@ -335,9 +335,6 @@ DO_VADDA(vadda_h, 16, H, DO_VABS)
 DO_VADDA(vadda_w, 32, W, DO_VABS)
 DO_VADDA(vadda_d, 64, D, DO_VABS)
 
-#define DO_MIN(a, b) (a < b ? a : b)
-#define DO_MAX(a, b) (a > b ? a : b)
-
 #define VMINMAXI(NAME, BIT, E, DO_OP)                           \
 void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t v) \
 {                                                               \
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index 20b86c3119..96f216d569 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -58,4 +58,7 @@
 
 #define DO_VABS(a)      ((a < 0) ? (-a) : (a))
 
+#define DO_MIN(a, b)    (a < b ? a : b)
+#define DO_MAX(a, b)    (a > b ? a : b)
+
 #endif /* LOONGARCH_VEC_H */
-- 
2.39.1


