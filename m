Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0257673680E
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:42:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXqU-0002XU-Ui; Tue, 20 Jun 2023 05:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXqF-0001sh-Da
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:40:03 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXqC-0006aJ-4P
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:40:02 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bxb+udc5Fk2SUHAA--.14743S3;
 Tue, 20 Jun 2023 17:38:37 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S40; 
 Tue, 20 Jun 2023 17:38:36 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 38/46] target/loongarch: Implement xvseq xvsle xvslt
Date: Tue, 20 Jun 2023 17:38:06 +0800
Message-Id: <20230620093814.123650-39-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S40
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
- XVSEQ[I].{B/H/W/D};
- XVSLE[I].{B/H/W/D}[U];
- XVSLT[I].{B/H/W/D/}[U].

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  43 ++++++
 target/loongarch/helper.h                    |  23 +++
 target/loongarch/insn_trans/trans_lasx.c.inc | 154 +++++++++++++++++++
 target/loongarch/insns.decode                |  43 ++++++
 target/loongarch/lasx_helper.c               |  34 ++++
 target/loongarch/lsx_helper.c                |   4 -
 target/loongarch/vec.h                       |   4 +
 7 files changed, 301 insertions(+), 4 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 65eccc8598..5d3904402d 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2341,6 +2341,49 @@ INSN_LASX(xvffintl_d_w,      xx)
 INSN_LASX(xvffinth_d_w,      xx)
 INSN_LASX(xvffint_s_l,       xxx)
 
+INSN_LASX(xvseq_b,           xxx)
+INSN_LASX(xvseq_h,           xxx)
+INSN_LASX(xvseq_w,           xxx)
+INSN_LASX(xvseq_d,           xxx)
+INSN_LASX(xvseqi_b,          xx_i)
+INSN_LASX(xvseqi_h,          xx_i)
+INSN_LASX(xvseqi_w,          xx_i)
+INSN_LASX(xvseqi_d,          xx_i)
+
+INSN_LASX(xvsle_b,           xxx)
+INSN_LASX(xvsle_h,           xxx)
+INSN_LASX(xvsle_w,           xxx)
+INSN_LASX(xvsle_d,           xxx)
+INSN_LASX(xvslei_b,          xx_i)
+INSN_LASX(xvslei_h,          xx_i)
+INSN_LASX(xvslei_w,          xx_i)
+INSN_LASX(xvslei_d,          xx_i)
+INSN_LASX(xvsle_bu,          xxx)
+INSN_LASX(xvsle_hu,          xxx)
+INSN_LASX(xvsle_wu,          xxx)
+INSN_LASX(xvsle_du,          xxx)
+INSN_LASX(xvslei_bu,         xx_i)
+INSN_LASX(xvslei_hu,         xx_i)
+INSN_LASX(xvslei_wu,         xx_i)
+INSN_LASX(xvslei_du,         xx_i)
+
+INSN_LASX(xvslt_b,           xxx)
+INSN_LASX(xvslt_h,           xxx)
+INSN_LASX(xvslt_w,           xxx)
+INSN_LASX(xvslt_d,           xxx)
+INSN_LASX(xvslti_b,          xx_i)
+INSN_LASX(xvslti_h,          xx_i)
+INSN_LASX(xvslti_w,          xx_i)
+INSN_LASX(xvslti_d,          xx_i)
+INSN_LASX(xvslt_bu,          xxx)
+INSN_LASX(xvslt_hu,          xxx)
+INSN_LASX(xvslt_wu,          xxx)
+INSN_LASX(xvslt_du,          xxx)
+INSN_LASX(xvslti_bu,         xx_i)
+INSN_LASX(xvslti_hu,         xx_i)
+INSN_LASX(xvslti_wu,         xx_i)
+INSN_LASX(xvslti_du,         xx_i)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index d30ea7f6a4..fbfd15d711 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -1193,3 +1193,26 @@ DEF_HELPER_3(xvffint_d_lu, void, env, i32, i32)
 DEF_HELPER_3(xvffintl_d_w, void, env, i32, i32)
 DEF_HELPER_3(xvffinth_d_w, void, env, i32, i32)
 DEF_HELPER_4(xvffint_s_l, void, env, i32, i32, i32)
+
+DEF_HELPER_FLAGS_4(xvseqi_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvseqi_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvseqi_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvseqi_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_FLAGS_4(xvslei_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvslei_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvslei_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvslei_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvslei_bu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvslei_hu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvslei_wu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvslei_du, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_FLAGS_4(xvslti_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvslti_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvslti_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvslti_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvslti_bu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvslti_hu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvslti_wu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvslti_du, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 998c07b358..cc1b4fd42a 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -2520,6 +2520,160 @@ TRANS(xvffintl_d_w, gen_xx, gen_helper_xvffintl_d_w)
 TRANS(xvffinth_d_w, gen_xx, gen_helper_xvffinth_d_w)
 TRANS(xvffint_s_l, gen_xxx, gen_helper_xvffint_s_l)
 
+static bool do_xcmp(DisasContext *ctx, arg_xxx * a, MemOp mop, TCGCond cond)
+{
+    uint32_t xd_ofs, xj_ofs, xk_ofs;
+
+    CHECK_ASXE;
+
+    xd_ofs = vec_full_offset(a->xd);
+    xj_ofs = vec_full_offset(a->xj);
+    xk_ofs = vec_full_offset(a->xk);
+
+    tcg_gen_gvec_cmp(cond, mop, xd_ofs, xj_ofs, xk_ofs, 32, ctx->vl / 8);
+    return true;
+}
+
+#define DO_XCMPI_S(NAME)                                                 \
+static bool do_x## NAME ##_s(DisasContext *ctx, arg_xx_i * a, MemOp mop) \
+{                                                                        \
+    uint32_t xd_ofs, xj_ofs;                                             \
+                                                                         \
+    CHECK_ASXE;                                                          \
+                                                                         \
+    static const TCGOpcode vecop_list[] = {                              \
+        INDEX_op_cmp_vec, 0                                              \
+    };                                                                   \
+    static const GVecGen2i op[4] = {                                     \
+        {                                                                \
+            .fniv = gen_## NAME ##_s_vec,                                \
+            .fnoi = gen_helper_x## NAME ##_b,                            \
+            .opt_opc = vecop_list,                                       \
+            .vece = MO_8                                                 \
+        },                                                               \
+        {                                                                \
+            .fniv = gen_## NAME ##_s_vec,                                \
+            .fnoi = gen_helper_x## NAME ##_h,                            \
+            .opt_opc = vecop_list,                                       \
+            .vece = MO_16                                                \
+        },                                                               \
+        {                                                                \
+            .fniv = gen_## NAME ##_s_vec,                                \
+            .fnoi = gen_helper_x## NAME ##_w,                            \
+            .opt_opc = vecop_list,                                       \
+            .vece = MO_32                                                \
+        },                                                               \
+        {                                                                \
+            .fniv = gen_## NAME ##_s_vec,                                \
+            .fnoi = gen_helper_x## NAME ##_d,                            \
+            .opt_opc = vecop_list,                                       \
+            .vece = MO_64                                                \
+        }                                                                \
+    };                                                                   \
+                                                                         \
+    xd_ofs = vec_full_offset(a->xd);                                     \
+    xj_ofs = vec_full_offset(a->xj);                                     \
+                                                                         \
+    tcg_gen_gvec_2i(xd_ofs, xj_ofs, 32, ctx->vl / 8, a->imm, &op[mop]);  \
+                                                                         \
+    return true;                                                         \
+}
+
+DO_XCMPI_S(vseqi)
+DO_XCMPI_S(vslei)
+DO_XCMPI_S(vslti)
+
+#define DO_XCMPI_U(NAME)                                                 \
+static bool do_x## NAME ##_u(DisasContext *ctx, arg_xx_i * a, MemOp mop) \
+{                                                                        \
+    uint32_t xd_ofs, xj_ofs;                                             \
+                                                                         \
+    CHECK_ASXE;                                                          \
+                                                                         \
+    static const TCGOpcode vecop_list[] = {                              \
+        INDEX_op_cmp_vec, 0                                              \
+    };                                                                   \
+    static const GVecGen2i op[4] = {                                     \
+        {                                                                \
+            .fniv = gen_## NAME ##_u_vec,                                \
+            .fnoi = gen_helper_x## NAME ##_bu,                           \
+            .opt_opc = vecop_list,                                       \
+            .vece = MO_8                                                 \
+        },                                                               \
+        {                                                                \
+            .fniv = gen_## NAME ##_u_vec,                                \
+            .fnoi = gen_helper_x## NAME ##_hu,                           \
+            .opt_opc = vecop_list,                                       \
+            .vece = MO_16                                                \
+        },                                                               \
+        {                                                                \
+            .fniv = gen_## NAME ##_u_vec,                                \
+            .fnoi = gen_helper_x## NAME ##_wu,                           \
+            .opt_opc = vecop_list,                                       \
+            .vece = MO_32                                                \
+        },                                                               \
+        {                                                                \
+            .fniv = gen_## NAME ##_u_vec,                                \
+            .fnoi = gen_helper_x## NAME ##_du,                           \
+            .opt_opc = vecop_list,                                       \
+            .vece = MO_64                                                \
+        }                                                                \
+    };                                                                   \
+                                                                         \
+    xd_ofs = vec_full_offset(a->xd);                                     \
+    xj_ofs = vec_full_offset(a->xj);                                     \
+                                                                         \
+    tcg_gen_gvec_2i(xd_ofs, xj_ofs, 32, ctx->vl / 8, a->imm, &op[mop]);  \
+                                                                         \
+    return true;                                                         \
+}
+
+DO_XCMPI_U(vslei)
+DO_XCMPI_U(vslti)
+
+TRANS(xvseq_b, do_xcmp, MO_8, TCG_COND_EQ)
+TRANS(xvseq_h, do_xcmp, MO_16, TCG_COND_EQ)
+TRANS(xvseq_w, do_xcmp, MO_32, TCG_COND_EQ)
+TRANS(xvseq_d, do_xcmp, MO_64, TCG_COND_EQ)
+TRANS(xvseqi_b, do_xvseqi_s, MO_8)
+TRANS(xvseqi_h, do_xvseqi_s, MO_16)
+TRANS(xvseqi_w, do_xvseqi_s, MO_32)
+TRANS(xvseqi_d, do_xvseqi_s, MO_64)
+
+TRANS(xvsle_b, do_xcmp, MO_8, TCG_COND_LE)
+TRANS(xvsle_h, do_xcmp, MO_16, TCG_COND_LE)
+TRANS(xvsle_w, do_xcmp, MO_32, TCG_COND_LE)
+TRANS(xvsle_d, do_xcmp, MO_64, TCG_COND_LE)
+TRANS(xvslei_b, do_xvslei_s, MO_8)
+TRANS(xvslei_h, do_xvslei_s, MO_16)
+TRANS(xvslei_w, do_xvslei_s, MO_32)
+TRANS(xvslei_d, do_xvslei_s, MO_64)
+TRANS(xvsle_bu, do_xcmp, MO_8, TCG_COND_LEU)
+TRANS(xvsle_hu, do_xcmp, MO_16, TCG_COND_LEU)
+TRANS(xvsle_wu, do_xcmp, MO_32, TCG_COND_LEU)
+TRANS(xvsle_du, do_xcmp, MO_64, TCG_COND_LEU)
+TRANS(xvslei_bu, do_xvslei_u, MO_8)
+TRANS(xvslei_hu, do_xvslei_u, MO_16)
+TRANS(xvslei_wu, do_xvslei_u, MO_32)
+TRANS(xvslei_du, do_xvslei_u, MO_64)
+
+TRANS(xvslt_b, do_xcmp, MO_8, TCG_COND_LT)
+TRANS(xvslt_h, do_xcmp, MO_16, TCG_COND_LT)
+TRANS(xvslt_w, do_xcmp, MO_32, TCG_COND_LT)
+TRANS(xvslt_d, do_xcmp, MO_64, TCG_COND_LT)
+TRANS(xvslti_b, do_xvslti_s, MO_8)
+TRANS(xvslti_h, do_xvslti_s, MO_16)
+TRANS(xvslti_w, do_xvslti_s, MO_32)
+TRANS(xvslti_d, do_xvslti_s, MO_64)
+TRANS(xvslt_bu, do_xcmp, MO_8, TCG_COND_LTU)
+TRANS(xvslt_hu, do_xcmp, MO_16, TCG_COND_LTU)
+TRANS(xvslt_wu, do_xcmp, MO_32, TCG_COND_LTU)
+TRANS(xvslt_du, do_xcmp, MO_64, TCG_COND_LTU)
+TRANS(xvslti_bu, do_xvslti_u, MO_8)
+TRANS(xvslti_hu, do_xvslti_u, MO_16)
+TRANS(xvslti_wu, do_xvslti_u, MO_32)
+TRANS(xvslti_du, do_xvslti_u, MO_64)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 59b79573e5..4e1f0b30a0 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1940,6 +1940,49 @@ xvffintl_d_w     0111 01101001 11100 00100 ..... .....    @xx
 xvffinth_d_w     0111 01101001 11100 00101 ..... .....    @xx
 xvffint_s_l      0111 01010100 10000 ..... ..... .....    @xxx
 
+xvseq_b          0111 01000000 00000 ..... ..... .....    @xxx
+xvseq_h          0111 01000000 00001 ..... ..... .....    @xxx
+xvseq_w          0111 01000000 00010 ..... ..... .....    @xxx
+xvseq_d          0111 01000000 00011 ..... ..... .....    @xxx
+xvseqi_b         0111 01101000 00000 ..... ..... .....    @xx_i5
+xvseqi_h         0111 01101000 00001 ..... ..... .....    @xx_i5
+xvseqi_w         0111 01101000 00010 ..... ..... .....    @xx_i5
+xvseqi_d         0111 01101000 00011 ..... ..... .....    @xx_i5
+
+xvsle_b          0111 01000000 00100 ..... ..... .....    @xxx
+xvsle_h          0111 01000000 00101 ..... ..... .....    @xxx
+xvsle_w          0111 01000000 00110 ..... ..... .....    @xxx
+xvsle_d          0111 01000000 00111 ..... ..... .....    @xxx
+xvslei_b         0111 01101000 00100 ..... ..... .....    @xx_i5
+xvslei_h         0111 01101000 00101 ..... ..... .....    @xx_i5
+xvslei_w         0111 01101000 00110 ..... ..... .....    @xx_i5
+xvslei_d         0111 01101000 00111 ..... ..... .....    @xx_i5
+xvsle_bu         0111 01000000 01000 ..... ..... .....    @xxx
+xvsle_hu         0111 01000000 01001 ..... ..... .....    @xxx
+xvsle_wu         0111 01000000 01010 ..... ..... .....    @xxx
+xvsle_du         0111 01000000 01011 ..... ..... .....    @xxx
+xvslei_bu        0111 01101000 01000 ..... ..... .....    @xx_ui5
+xvslei_hu        0111 01101000 01001 ..... ..... .....    @xx_ui5
+xvslei_wu        0111 01101000 01010 ..... ..... .....    @xx_ui5
+xvslei_du        0111 01101000 01011 ..... ..... .....    @xx_ui5
+
+xvslt_b          0111 01000000 01100 ..... ..... .....    @xxx
+xvslt_h          0111 01000000 01101 ..... ..... .....    @xxx
+xvslt_w          0111 01000000 01110 ..... ..... .....    @xxx
+xvslt_d          0111 01000000 01111 ..... ..... .....    @xxx
+xvslti_b         0111 01101000 01100 ..... ..... .....    @xx_i5
+xvslti_h         0111 01101000 01101 ..... ..... .....    @xx_i5
+xvslti_w         0111 01101000 01110 ..... ..... .....    @xx_i5
+xvslti_d         0111 01101000 01111 ..... ..... .....    @xx_i5
+xvslt_bu         0111 01000000 10000 ..... ..... .....    @xxx
+xvslt_hu         0111 01000000 10001 ..... ..... .....    @xxx
+xvslt_wu         0111 01000000 10010 ..... ..... .....    @xxx
+xvslt_du         0111 01000000 10011 ..... ..... .....    @xxx
+xvslti_bu        0111 01101000 10000 ..... ..... .....    @xx_ui5
+xvslti_hu        0111 01101000 10001 ..... ..... .....    @xx_ui5
+xvslti_wu        0111 01101000 10010 ..... ..... .....    @xx_ui5
+xvslti_du        0111 01101000 10011 ..... ..... .....    @xx_ui5
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index 5cc917fdc3..d0bc02de72 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -2723,3 +2723,37 @@ void HELPER(xvffint_s_l)(CPULoongArchState *env,
     }
     *Xd = temp;
 }
+
+#define XVCMPI(NAME, BIT, E, DO_OP)                             \
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
+XVCMPI(xvseqi_b, 8, XB, VSEQ)
+XVCMPI(xvseqi_h, 16, XH, VSEQ)
+XVCMPI(xvseqi_w, 32, XW, VSEQ)
+XVCMPI(xvseqi_d, 64, XD, VSEQ)
+XVCMPI(xvslei_b, 8, XB, VSLE)
+XVCMPI(xvslei_h, 16, XH, VSLE)
+XVCMPI(xvslei_w, 32, XW, VSLE)
+XVCMPI(xvslei_d, 64, XD, VSLE)
+XVCMPI(xvslei_bu, 8, UXB, VSLE)
+XVCMPI(xvslei_hu, 16, UXH, VSLE)
+XVCMPI(xvslei_wu, 32, UXW, VSLE)
+XVCMPI(xvslei_du, 64, UXD, VSLE)
+XVCMPI(xvslti_b, 8, XB, VSLT)
+XVCMPI(xvslti_h, 16, XH, VSLT)
+XVCMPI(xvslti_w, 32, XW, VSLT)
+XVCMPI(xvslti_d, 64, XD, VSLT)
+XVCMPI(xvslti_bu, 8, UXB, VSLT)
+XVCMPI(xvslti_hu, 16, UXH, VSLT)
+XVCMPI(xvslti_wu, 32, UXW, VSLT)
+XVCMPI(xvslti_du, 64, UXD, VSLT)
diff --git a/target/loongarch/lsx_helper.c b/target/loongarch/lsx_helper.c
index 446a1bdfe3..22d71cb39e 100644
--- a/target/loongarch/lsx_helper.c
+++ b/target/loongarch/lsx_helper.c
@@ -2588,10 +2588,6 @@ void HELPER(vffint_s_l)(CPULoongArchState *env,
     *Vd = temp;
 }
 
-#define VSEQ(a, b) (a == b ? -1 : 0)
-#define VSLE(a, b) (a <= b ? -1 : 0)
-#define VSLT(a, b) (a < b ? -1 : 0)
-
 #define VCMPI(NAME, BIT, E, DO_OP)                              \
 void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t v) \
 {                                                               \
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index 583997d576..54fd2689f3 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -90,6 +90,10 @@
 #define DO_BITSET(a, bit) (a | 1ull << bit)
 #define DO_BITREV(a, bit) (a ^ (1ull << bit))
 
+#define VSEQ(a, b) (a == b ? -1 : 0)
+#define VSLE(a, b) (a <= b ? -1 : 0)
+#define VSLT(a, b) (a < b ? -1 : 0)
+
 uint64_t do_vmskltz_b(int64_t val);
 uint64_t do_vmskltz_h(int64_t val);
 uint64_t do_vmskltz_w(int64_t val);
-- 
2.39.1


