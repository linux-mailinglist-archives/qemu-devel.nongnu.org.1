Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 046697367F9
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:40:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXpR-0007H0-7S; Tue, 20 Jun 2023 05:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXp5-0007B2-6e
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:51 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXp1-0006O8-Lu
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:50 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxHuubc5Fk0SUHAA--.14789S3;
 Tue, 20 Jun 2023 17:38:35 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S36; 
 Tue, 20 Jun 2023 17:38:35 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 34/46] target/loongarch: Implement xvbitclr xvbitset
 xvbitrev
Date: Tue, 20 Jun 2023 17:38:02 +0800
Message-Id: <20230620093814.123650-35-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S36
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
- XVBITCLR[I].{B/H/W/D};
- XVBITSET[I].{B/H/W/D};
- XVBITREV[I].{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  25 ++
 target/loongarch/helper.h                    |  27 ++
 target/loongarch/insn_trans/trans_lasx.c.inc | 246 +++++++++++++++++++
 target/loongarch/insns.decode                |  27 ++
 target/loongarch/lasx_helper.c               |  51 ++++
 target/loongarch/lsx_helper.c                |   4 -
 target/loongarch/vec.h                       |   4 +
 7 files changed, 380 insertions(+), 4 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index b7a322651f..60d265a9f2 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2209,6 +2209,31 @@ INSN_LASX(xvpcnt_h,          xx)
 INSN_LASX(xvpcnt_w,          xx)
 INSN_LASX(xvpcnt_d,          xx)
 
+INSN_LASX(xvbitclr_b,        xxx)
+INSN_LASX(xvbitclr_h,        xxx)
+INSN_LASX(xvbitclr_w,        xxx)
+INSN_LASX(xvbitclr_d,        xxx)
+INSN_LASX(xvbitclri_b,       xx_i)
+INSN_LASX(xvbitclri_h,       xx_i)
+INSN_LASX(xvbitclri_w,       xx_i)
+INSN_LASX(xvbitclri_d,       xx_i)
+INSN_LASX(xvbitset_b,        xxx)
+INSN_LASX(xvbitset_h,        xxx)
+INSN_LASX(xvbitset_w,        xxx)
+INSN_LASX(xvbitset_d,        xxx)
+INSN_LASX(xvbitseti_b,       xx_i)
+INSN_LASX(xvbitseti_h,       xx_i)
+INSN_LASX(xvbitseti_w,       xx_i)
+INSN_LASX(xvbitseti_d,       xx_i)
+INSN_LASX(xvbitrev_b,        xxx)
+INSN_LASX(xvbitrev_h,        xxx)
+INSN_LASX(xvbitrev_w,        xxx)
+INSN_LASX(xvbitrev_d,        xxx)
+INSN_LASX(xvbitrevi_b,       xx_i)
+INSN_LASX(xvbitrevi_h,       xx_i)
+INSN_LASX(xvbitrevi_w,       xx_i)
+INSN_LASX(xvbitrevi_d,       xx_i)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index a434443819..294ac477fc 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -1064,3 +1064,30 @@ DEF_HELPER_3(xvpcnt_b, void, env, i32, i32)
 DEF_HELPER_3(xvpcnt_h, void, env, i32, i32)
 DEF_HELPER_3(xvpcnt_w, void, env, i32, i32)
 DEF_HELPER_3(xvpcnt_d, void, env, i32, i32)
+
+DEF_HELPER_FLAGS_4(xvbitclr_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvbitclr_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvbitclr_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvbitclr_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvbitclri_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvbitclri_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvbitclri_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvbitclri_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_FLAGS_4(xvbitset_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvbitset_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvbitset_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvbitset_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvbitseti_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvbitseti_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvbitseti_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvbitseti_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_FLAGS_4(xvbitrev_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvbitrev_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvbitrev_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvbitrev_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(xvbitrevi_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvbitrevi_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvbitrevi_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvbitrevi_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 616d296432..e87e000478 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -2158,6 +2158,252 @@ TRANS(xvpcnt_h, gen_xx, gen_helper_xvpcnt_h)
 TRANS(xvpcnt_w, gen_xx, gen_helper_xvpcnt_w)
 TRANS(xvpcnt_d, gen_xx, gen_helper_xvpcnt_d)
 
+static void do_xvbitclr(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                        uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shlv_vec, INDEX_op_andc_vec, 0
+        };
+    static const GVecGen3 op[4] = {
+        {
+            .fniv = gen_vbitclr,
+            .fno = gen_helper_xvbitclr_b,
+            .opt_opc = vecop_list,
+            .vece = MO_8
+        },
+        {
+            .fniv = gen_vbitclr,
+            .fno = gen_helper_xvbitclr_h,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fniv = gen_vbitclr,
+            .fno = gen_helper_xvbitclr_w,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fniv = gen_vbitclr,
+            .fno = gen_helper_xvbitclr_d,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvbitclr_b, gvec_xxx, MO_8, do_xvbitclr)
+TRANS(xvbitclr_h, gvec_xxx, MO_16, do_xvbitclr)
+TRANS(xvbitclr_w, gvec_xxx, MO_32, do_xvbitclr)
+TRANS(xvbitclr_d, gvec_xxx, MO_64, do_xvbitclr)
+
+static void do_xvbitclri(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                         int64_t imm, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shli_vec, INDEX_op_andc_vec, 0
+        };
+    static const GVecGen2i op[4] = {
+        {
+            .fniv = gen_vbitclri,
+            .fnoi = gen_helper_xvbitclri_b,
+            .opt_opc = vecop_list,
+            .vece = MO_8
+        },
+        {
+            .fniv = gen_vbitclri,
+            .fnoi = gen_helper_xvbitclri_h,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fniv = gen_vbitclri,
+            .fnoi = gen_helper_xvbitclri_w,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fniv = gen_vbitclri,
+            .fnoi = gen_helper_xvbitclri_d,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_2i(xd_ofs, xj_ofs, oprsz, maxsz, imm, &op[vece]);
+}
+
+TRANS(xvbitclri_b, gvec_xx_i, MO_8, do_xvbitclri)
+TRANS(xvbitclri_h, gvec_xx_i, MO_16, do_xvbitclri)
+TRANS(xvbitclri_w, gvec_xx_i, MO_32, do_xvbitclri)
+TRANS(xvbitclri_d, gvec_xx_i, MO_64, do_xvbitclri)
+
+static void do_xvbitset(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                        uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shlv_vec, 0
+        };
+    static const GVecGen3 op[4] = {
+        {
+            .fniv = gen_vbitset,
+            .fno = gen_helper_xvbitset_b,
+            .opt_opc = vecop_list,
+            .vece = MO_8
+        },
+        {
+            .fniv = gen_vbitset,
+            .fno = gen_helper_xvbitset_h,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fniv = gen_vbitset,
+            .fno = gen_helper_xvbitset_w,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fniv = gen_vbitset,
+            .fno = gen_helper_xvbitset_d,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvbitset_b, gvec_xxx, MO_8, do_xvbitset)
+TRANS(xvbitset_h, gvec_xxx, MO_16, do_xvbitset)
+TRANS(xvbitset_w, gvec_xxx, MO_32, do_xvbitset)
+TRANS(xvbitset_d, gvec_xxx, MO_64, do_xvbitset)
+
+static void do_xvbitseti(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                         int64_t imm, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shli_vec, 0
+        };
+    static const GVecGen2i op[4] = {
+        {
+            .fniv = gen_vbitseti,
+            .fnoi = gen_helper_xvbitseti_b,
+            .opt_opc = vecop_list,
+            .vece = MO_8
+        },
+        {
+            .fniv = gen_vbitseti,
+            .fnoi = gen_helper_xvbitseti_h,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fniv = gen_vbitseti,
+            .fnoi = gen_helper_xvbitseti_w,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fniv = gen_vbitseti,
+            .fnoi = gen_helper_xvbitseti_d,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_2i(xd_ofs, xj_ofs, oprsz, maxsz, imm, &op[vece]);
+}
+
+TRANS(xvbitseti_b, gvec_xx_i, MO_8, do_xvbitseti)
+TRANS(xvbitseti_h, gvec_xx_i, MO_16, do_xvbitseti)
+TRANS(xvbitseti_w, gvec_xx_i, MO_32, do_xvbitseti)
+TRANS(xvbitseti_d, gvec_xx_i, MO_64, do_xvbitseti)
+
+static void do_xvbitrev(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                        uint32_t xk_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shlv_vec, 0
+        };
+    static const GVecGen3 op[4] = {
+        {
+            .fniv = gen_vbitrev,
+            .fno = gen_helper_xvbitrev_b,
+            .opt_opc = vecop_list,
+            .vece = MO_8
+        },
+        {
+            .fniv = gen_vbitrev,
+            .fno = gen_helper_xvbitrev_h,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fniv = gen_vbitrev,
+            .fno = gen_helper_xvbitrev_w,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fniv = gen_vbitrev,
+            .fno = gen_helper_xvbitrev_d,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_3(xd_ofs, xj_ofs, xk_ofs, oprsz, maxsz, &op[vece]);
+}
+
+TRANS(xvbitrev_b, gvec_xxx, MO_8, do_xvbitrev)
+TRANS(xvbitrev_h, gvec_xxx, MO_16, do_xvbitrev)
+TRANS(xvbitrev_w, gvec_xxx, MO_32, do_xvbitrev)
+TRANS(xvbitrev_d, gvec_xxx, MO_64, do_xvbitrev)
+
+static void do_xvbitrevi(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                         int64_t imm, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shli_vec, 0
+        };
+    static const GVecGen2i op[4] = {
+        {
+            .fniv = gen_vbitrevi,
+            .fnoi = gen_helper_xvbitrevi_b,
+            .opt_opc = vecop_list,
+            .vece = MO_8
+        },
+        {
+            .fniv = gen_vbitrevi,
+            .fnoi = gen_helper_xvbitrevi_h,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fniv = gen_vbitrevi,
+            .fnoi = gen_helper_xvbitrevi_w,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fniv = gen_vbitrevi,
+            .fnoi = gen_helper_xvbitrevi_d,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_2i(xd_ofs, xj_ofs, oprsz, maxsz, imm, &op[vece]);
+}
+
+TRANS(xvbitrevi_b, gvec_xx_i, MO_8, do_xvbitrevi)
+TRANS(xvbitrevi_h, gvec_xx_i, MO_16, do_xvbitrevi)
+TRANS(xvbitrevi_w, gvec_xx_i, MO_32, do_xvbitrevi)
+TRANS(xvbitrevi_d, gvec_xx_i, MO_64, do_xvbitrevi)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 7d49ddb0ea..47374054c6 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1807,6 +1807,33 @@ xvpcnt_h         0111 01101001 11000 01001 ..... .....    @xx
 xvpcnt_w         0111 01101001 11000 01010 ..... .....    @xx
 xvpcnt_d         0111 01101001 11000 01011 ..... .....    @xx
 
+xvbitclr_b       0111 01010000 11000 ..... ..... .....    @xxx
+xvbitclr_h       0111 01010000 11001 ..... ..... .....    @xxx
+xvbitclr_w       0111 01010000 11010 ..... ..... .....    @xxx
+xvbitclr_d       0111 01010000 11011 ..... ..... .....    @xxx
+xvbitclri_b      0111 01110001 00000 01 ... ..... .....   @xx_ui3
+xvbitclri_h      0111 01110001 00000 1 .... ..... .....   @xx_ui4
+xvbitclri_w      0111 01110001 00001 ..... ..... .....    @xx_ui5
+xvbitclri_d      0111 01110001 0001 ...... ..... .....    @xx_ui6
+
+xvbitset_b       0111 01010000 11100 ..... ..... .....    @xxx
+xvbitset_h       0111 01010000 11101 ..... ..... .....    @xxx
+xvbitset_w       0111 01010000 11110 ..... ..... .....    @xxx
+xvbitset_d       0111 01010000 11111 ..... ..... .....    @xxx
+xvbitseti_b      0111 01110001 01000 01 ... ..... .....   @xx_ui3
+xvbitseti_h      0111 01110001 01000 1 .... ..... .....   @xx_ui4
+xvbitseti_w      0111 01110001 01001 ..... ..... .....    @xx_ui5
+xvbitseti_d      0111 01110001 0101 ...... ..... .....    @xx_ui6
+
+xvbitrev_b       0111 01010001 00000 ..... ..... .....    @xxx
+xvbitrev_h       0111 01010001 00001 ..... ..... .....    @xxx
+xvbitrev_w       0111 01010001 00010 ..... ..... .....    @xxx
+xvbitrev_d       0111 01010001 00011 ..... ..... .....    @xxx
+xvbitrevi_b      0111 01110001 10000 01 ... ..... .....   @xx_ui3
+xvbitrevi_h      0111 01110001 10000 1 .... ..... .....   @xx_ui4
+xvbitrevi_w      0111 01110001 10001 ..... ..... .....    @xx_ui5
+xvbitrevi_d      0111 01110001 1001 ...... ..... .....    @xx_ui6
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index f04817984b..7092835d30 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -2119,3 +2119,54 @@ XVPCNT(xvpcnt_b, 8, UXB, ctpop8)
 XVPCNT(xvpcnt_h, 16, UXH, ctpop16)
 XVPCNT(xvpcnt_w, 32, UXW, ctpop32)
 XVPCNT(xvpcnt_d, 64, UXD, ctpop64)
+
+#define XDO_BIT(NAME, BIT, E, DO_OP)                        \
+void HELPER(NAME)(void *xd, void *xj, void *xk, uint32_t v) \
+{                                                           \
+    int i;                                                  \
+    XReg *Xd = (XReg *)xd;                                  \
+    XReg *Xj = (XReg *)xj;                                  \
+    XReg *Xk = (XReg *)xk;                                  \
+                                                            \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                  \
+        Xd->E(i) = DO_OP(Xj->E(i), Xk->E(i) % BIT);         \
+    }                                                       \
+}
+
+XDO_BIT(xvbitclr_b, 8, UXB, DO_BITCLR)
+XDO_BIT(xvbitclr_h, 16, UXH, DO_BITCLR)
+XDO_BIT(xvbitclr_w, 32, UXW, DO_BITCLR)
+XDO_BIT(xvbitclr_d, 64, UXD, DO_BITCLR)
+XDO_BIT(xvbitset_b, 8, UXB, DO_BITSET)
+XDO_BIT(xvbitset_h, 16, UXH, DO_BITSET)
+XDO_BIT(xvbitset_w, 32, UXW, DO_BITSET)
+XDO_BIT(xvbitset_d, 64, UXD, DO_BITSET)
+XDO_BIT(xvbitrev_b, 8, UXB, DO_BITREV)
+XDO_BIT(xvbitrev_h, 16, UXH, DO_BITREV)
+XDO_BIT(xvbitrev_w, 32, UXW, DO_BITREV)
+XDO_BIT(xvbitrev_d, 64, UXD, DO_BITREV)
+
+#define XDO_BITI(NAME, BIT, E, DO_OP)                           \
+void HELPER(NAME)(void *xd, void *xj, uint64_t imm, uint32_t v) \
+{                                                               \
+    int i;                                                      \
+    XReg *Xd = (XReg *)xd;                                      \
+    XReg *Xj = (XReg *)xj;                                      \
+                                                                \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                      \
+        Xd->E(i) = DO_OP(Xj->E(i), imm);                        \
+    }                                                           \
+}
+
+XDO_BITI(xvbitclri_b, 8, UXB, DO_BITCLR)
+XDO_BITI(xvbitclri_h, 16, UXH, DO_BITCLR)
+XDO_BITI(xvbitclri_w, 32, UXW, DO_BITCLR)
+XDO_BITI(xvbitclri_d, 64, UXD, DO_BITCLR)
+XDO_BITI(xvbitseti_b, 8, UXB, DO_BITSET)
+XDO_BITI(xvbitseti_h, 16, UXH, DO_BITSET)
+XDO_BITI(xvbitseti_w, 32, UXW, DO_BITSET)
+XDO_BITI(xvbitseti_d, 64, UXD, DO_BITSET)
+XDO_BITI(xvbitrevi_b, 8, UXB, DO_BITREV)
+XDO_BITI(xvbitrevi_h, 16, UXH, DO_BITREV)
+XDO_BITI(xvbitrevi_w, 32, UXW, DO_BITREV)
+XDO_BITI(xvbitrevi_d, 64, UXD, DO_BITREV)
diff --git a/target/loongarch/lsx_helper.c b/target/loongarch/lsx_helper.c
index e1b448a2e6..b9fdcd3ed7 100644
--- a/target/loongarch/lsx_helper.c
+++ b/target/loongarch/lsx_helper.c
@@ -1937,10 +1937,6 @@ VPCNT(vpcnt_h, 16, UH, ctpop16)
 VPCNT(vpcnt_w, 32, UW, ctpop32)
 VPCNT(vpcnt_d, 64, UD, ctpop64)
 
-#define DO_BITCLR(a, bit) (a & ~(1ull << bit))
-#define DO_BITSET(a, bit) (a | 1ull << bit)
-#define DO_BITREV(a, bit) (a ^ (1ull << bit))
-
 #define DO_BIT(NAME, BIT, E, DO_OP)                         \
 void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t v) \
 {                                                           \
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index db5704dd05..4d9c4eb85f 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -86,6 +86,10 @@
 #define DO_CLZ_W(N)  (clz32(N))
 #define DO_CLZ_D(N)  (clz64(N))
 
+#define DO_BITCLR(a, bit) (a & ~(1ull << bit))
+#define DO_BITSET(a, bit) (a | 1ull << bit)
+#define DO_BITREV(a, bit) (a ^ (1ull << bit))
+
 uint64_t do_vmskltz_b(int64_t val);
 uint64_t do_vmskltz_h(int64_t val);
 uint64_t do_vmskltz_w(int64_t val);
-- 
2.39.1


