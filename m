Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 944187A7359
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 08:56:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qir56-0008OD-Os; Wed, 20 Sep 2023 02:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qir4r-00081i-QW
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 02:52:52 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qir4c-00048s-H4
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 02:52:49 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx2eqllgpl4C8qAA--.10469S3;
 Wed, 20 Sep 2023 14:52:21 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dxzdx7lgplhVYMAA--.24315S50; 
 Wed, 20 Sep 2023 14:52:20 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 48/57] target/loongarch: Implement xvseq xvsle xvslt
Date: Wed, 20 Sep 2023 14:51:30 +0800
Message-Id: <20230920065139.1403868-49-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230920065139.1403868-1-gaosong@loongson.cn>
References: <20230920065139.1403868-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxzdx7lgplhVYMAA--.24315S50
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230914022645.1151356-49-gaosong@loongson.cn>
---
 target/loongarch/insns.decode               |  43 ++++
 target/loongarch/disas.c                    |  43 ++++
 target/loongarch/vec_helper.c               |  23 +-
 target/loongarch/insn_trans/trans_vec.c.inc | 257 ++++++++------------
 4 files changed, 201 insertions(+), 165 deletions(-)

diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index ed4f82e7fe..82c26a318b 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1915,6 +1915,49 @@ xvffintl_d_w     0111 01101001 11100 00100 ..... .....    @vv
 xvffinth_d_w     0111 01101001 11100 00101 ..... .....    @vv
 xvffint_s_l      0111 01010100 10000 ..... ..... .....    @vvv
 
+xvseq_b          0111 01000000 00000 ..... ..... .....    @vvv
+xvseq_h          0111 01000000 00001 ..... ..... .....    @vvv
+xvseq_w          0111 01000000 00010 ..... ..... .....    @vvv
+xvseq_d          0111 01000000 00011 ..... ..... .....    @vvv
+xvseqi_b         0111 01101000 00000 ..... ..... .....    @vv_i5
+xvseqi_h         0111 01101000 00001 ..... ..... .....    @vv_i5
+xvseqi_w         0111 01101000 00010 ..... ..... .....    @vv_i5
+xvseqi_d         0111 01101000 00011 ..... ..... .....    @vv_i5
+
+xvsle_b          0111 01000000 00100 ..... ..... .....    @vvv
+xvsle_h          0111 01000000 00101 ..... ..... .....    @vvv
+xvsle_w          0111 01000000 00110 ..... ..... .....    @vvv
+xvsle_d          0111 01000000 00111 ..... ..... .....    @vvv
+xvslei_b         0111 01101000 00100 ..... ..... .....    @vv_i5
+xvslei_h         0111 01101000 00101 ..... ..... .....    @vv_i5
+xvslei_w         0111 01101000 00110 ..... ..... .....    @vv_i5
+xvslei_d         0111 01101000 00111 ..... ..... .....    @vv_i5
+xvsle_bu         0111 01000000 01000 ..... ..... .....    @vvv
+xvsle_hu         0111 01000000 01001 ..... ..... .....    @vvv
+xvsle_wu         0111 01000000 01010 ..... ..... .....    @vvv
+xvsle_du         0111 01000000 01011 ..... ..... .....    @vvv
+xvslei_bu        0111 01101000 01000 ..... ..... .....    @vv_ui5
+xvslei_hu        0111 01101000 01001 ..... ..... .....    @vv_ui5
+xvslei_wu        0111 01101000 01010 ..... ..... .....    @vv_ui5
+xvslei_du        0111 01101000 01011 ..... ..... .....    @vv_ui5
+
+xvslt_b          0111 01000000 01100 ..... ..... .....    @vvv
+xvslt_h          0111 01000000 01101 ..... ..... .....    @vvv
+xvslt_w          0111 01000000 01110 ..... ..... .....    @vvv
+xvslt_d          0111 01000000 01111 ..... ..... .....    @vvv
+xvslti_b         0111 01101000 01100 ..... ..... .....    @vv_i5
+xvslti_h         0111 01101000 01101 ..... ..... .....    @vv_i5
+xvslti_w         0111 01101000 01110 ..... ..... .....    @vv_i5
+xvslti_d         0111 01101000 01111 ..... ..... .....    @vv_i5
+xvslt_bu         0111 01000000 10000 ..... ..... .....    @vvv
+xvslt_hu         0111 01000000 10001 ..... ..... .....    @vvv
+xvslt_wu         0111 01000000 10010 ..... ..... .....    @vvv
+xvslt_du         0111 01000000 10011 ..... ..... .....    @vvv
+xvslti_bu        0111 01101000 10000 ..... ..... .....    @vv_ui5
+xvslti_hu        0111 01101000 10001 ..... ..... .....    @vv_ui5
+xvslti_wu        0111 01101000 10010 ..... ..... .....    @vv_ui5
+xvslti_du        0111 01101000 10011 ..... ..... .....    @vv_ui5
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index f1a1321d0d..48e0b559f2 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2342,6 +2342,49 @@ INSN_LASX(xvffintl_d_w,      vv)
 INSN_LASX(xvffinth_d_w,      vv)
 INSN_LASX(xvffint_s_l,       vvv)
 
+INSN_LASX(xvseq_b,           vvv)
+INSN_LASX(xvseq_h,           vvv)
+INSN_LASX(xvseq_w,           vvv)
+INSN_LASX(xvseq_d,           vvv)
+INSN_LASX(xvseqi_b,          vv_i)
+INSN_LASX(xvseqi_h,          vv_i)
+INSN_LASX(xvseqi_w,          vv_i)
+INSN_LASX(xvseqi_d,          vv_i)
+
+INSN_LASX(xvsle_b,           vvv)
+INSN_LASX(xvsle_h,           vvv)
+INSN_LASX(xvsle_w,           vvv)
+INSN_LASX(xvsle_d,           vvv)
+INSN_LASX(xvslei_b,          vv_i)
+INSN_LASX(xvslei_h,          vv_i)
+INSN_LASX(xvslei_w,          vv_i)
+INSN_LASX(xvslei_d,          vv_i)
+INSN_LASX(xvsle_bu,          vvv)
+INSN_LASX(xvsle_hu,          vvv)
+INSN_LASX(xvsle_wu,          vvv)
+INSN_LASX(xvsle_du,          vvv)
+INSN_LASX(xvslei_bu,         vv_i)
+INSN_LASX(xvslei_hu,         vv_i)
+INSN_LASX(xvslei_wu,         vv_i)
+INSN_LASX(xvslei_du,         vv_i)
+
+INSN_LASX(xvslt_b,           vvv)
+INSN_LASX(xvslt_h,           vvv)
+INSN_LASX(xvslt_w,           vvv)
+INSN_LASX(xvslt_d,           vvv)
+INSN_LASX(xvslti_b,          vv_i)
+INSN_LASX(xvslti_h,          vv_i)
+INSN_LASX(xvslti_w,          vv_i)
+INSN_LASX(xvslti_d,          vv_i)
+INSN_LASX(xvslt_bu,          vvv)
+INSN_LASX(xvslt_hu,          vvv)
+INSN_LASX(xvslt_wu,          vvv)
+INSN_LASX(xvslt_du,          vvv)
+INSN_LASX(xvslti_bu,         vv_i)
+INSN_LASX(xvslti_hu,         vv_i)
+INSN_LASX(xvslti_wu,         vv_i)
+INSN_LASX(xvslti_du,         vv_i)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 20d7675256..960b3d19ec 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -3057,17 +3057,18 @@ void HELPER(vffint_s_l)(void *vd, void *vj, void *vk,
 #define VSLE(a, b) (a <= b ? -1 : 0)
 #define VSLT(a, b) (a < b ? -1 : 0)
 
-#define VCMPI(NAME, BIT, E, DO_OP)                              \
-void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t v) \
-{                                                               \
-    int i;                                                      \
-    VReg *Vd = (VReg *)vd;                                      \
-    VReg *Vj = (VReg *)vj;                                      \
-    typedef __typeof(Vd->E(0)) TD;                              \
-                                                                \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                         \
-        Vd->E(i) = DO_OP(Vj->E(i), (TD)imm);                    \
-    }                                                           \
+#define VCMPI(NAME, BIT, E, DO_OP)                                 \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc) \
+{                                                                  \
+    int i;                                                         \
+    VReg *Vd = (VReg *)vd;                                         \
+    VReg *Vj = (VReg *)vj;                                         \
+    typedef __typeof(Vd->E(0)) TD;                                 \
+    int oprsz = simd_oprsz(desc);                                  \
+                                                                   \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                      \
+        Vd->E(i) = DO_OP(Vj->E(i), (TD)imm);                       \
+    }                                                              \
 }
 
 VCMPI(vseqi_b, 8, B, VSEQ)
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 9ee3e613fc..63d71e2332 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -4505,11 +4505,12 @@ TRANS(xvffintl_d_w, LASX, gen_xx_ptr, gen_helper_vffintl_d_w)
 TRANS(xvffinth_d_w, LASX, gen_xx_ptr, gen_helper_vffinth_d_w)
 TRANS(xvffint_s_l, LASX, gen_xxx_ptr, gen_helper_vffint_s_l)
 
-static bool do_cmp(DisasContext *ctx, arg_vvv *a, MemOp mop, TCGCond cond)
+static bool do_cmp_vl(DisasContext *ctx, arg_vvv *a,
+                      uint32_t oprsz, MemOp mop, TCGCond cond)
 {
     uint32_t vd_ofs, vj_ofs, vk_ofs;
 
-    if (!check_vec(ctx, 16)) {
+    if (!check_vec(ctx, oprsz)) {
         return true;
     }
 
@@ -4517,184 +4518,132 @@ static bool do_cmp(DisasContext *ctx, arg_vvv *a, MemOp mop, TCGCond cond)
     vj_ofs = vec_full_offset(a->vj);
     vk_ofs = vec_full_offset(a->vk);
 
-    tcg_gen_gvec_cmp(cond, mop, vd_ofs, vj_ofs, vk_ofs, 16, ctx->vl/8);
+    tcg_gen_gvec_cmp(cond, mop, vd_ofs, vj_ofs, vk_ofs, oprsz, ctx->vl / 8);
     return true;
 }
 
-static void do_cmpi_vec(TCGCond cond,
-                        unsigned vece, TCGv_vec t, TCGv_vec a, int64_t imm)
-{
-    tcg_gen_cmp_vec(cond, vece, t, a, tcg_constant_vec_matching(t, vece, imm));
-}
-
-static void gen_vseqi_s_vec(unsigned vece, TCGv_vec t, TCGv_vec a, int64_t imm)
-{
-    do_cmpi_vec(TCG_COND_EQ, vece, t, a, imm);
-}
-
-static void gen_vslei_s_vec(unsigned vece, TCGv_vec t, TCGv_vec a, int64_t imm)
-{
-    do_cmpi_vec(TCG_COND_LE, vece, t, a, imm);
-}
-
-static void gen_vslti_s_vec(unsigned vece, TCGv_vec t, TCGv_vec a, int64_t imm)
-{
-    do_cmpi_vec(TCG_COND_LT, vece, t, a, imm);
-}
-
-static void gen_vslei_u_vec(unsigned vece, TCGv_vec t, TCGv_vec a, int64_t imm)
-{
-    do_cmpi_vec(TCG_COND_LEU, vece, t, a, imm);
-}
-
-static void gen_vslti_u_vec(unsigned vece, TCGv_vec t, TCGv_vec a, int64_t imm)
-{
-    do_cmpi_vec(TCG_COND_LTU, vece, t, a, imm);
-}
-
-#define DO_CMPI_S(NAME)                                                \
-static bool do_## NAME ##_s(DisasContext *ctx, arg_vv_i *a, MemOp mop) \
-{                                                                      \
-    uint32_t vd_ofs, vj_ofs;                                           \
-                                                                       \
-    if (!check_vec(ctx, 16)) {                                         \
-        return true;                                                   \
-    }                                                                  \
-                                                                       \
-    static const TCGOpcode vecop_list[] = {                            \
-        INDEX_op_cmp_vec, 0                                            \
-    };                                                                 \
-    static const GVecGen2i op[4] = {                                   \
-        {                                                              \
-            .fniv = gen_## NAME ##_s_vec,                              \
-            .fnoi = gen_helper_## NAME ##_b,                           \
-            .opt_opc = vecop_list,                                     \
-            .vece = MO_8                                               \
-        },                                                             \
-        {                                                              \
-            .fniv = gen_## NAME ##_s_vec,                              \
-            .fnoi = gen_helper_## NAME ##_h,                           \
-            .opt_opc = vecop_list,                                     \
-            .vece = MO_16                                              \
-        },                                                             \
-        {                                                              \
-            .fniv = gen_## NAME ##_s_vec,                              \
-            .fnoi = gen_helper_## NAME ##_w,                           \
-            .opt_opc = vecop_list,                                     \
-            .vece = MO_32                                              \
-        },                                                             \
-        {                                                              \
-            .fniv = gen_## NAME ##_s_vec,                              \
-            .fnoi = gen_helper_## NAME ##_d,                           \
-            .opt_opc = vecop_list,                                     \
-            .vece = MO_64                                              \
-        }                                                              \
-    };                                                                 \
-                                                                       \
-    vd_ofs = vec_full_offset(a->vd);                                   \
-    vj_ofs = vec_full_offset(a->vj);                                   \
-                                                                       \
-    tcg_gen_gvec_2i(vd_ofs, vj_ofs, 16, ctx->vl/8, a->imm, &op[mop]);  \
-                                                                       \
-    return true;                                                       \
-}
-
-DO_CMPI_S(vseqi)
-DO_CMPI_S(vslei)
-DO_CMPI_S(vslti)
-
-#define DO_CMPI_U(NAME)                                                \
-static bool do_## NAME ##_u(DisasContext *ctx, arg_vv_i *a, MemOp mop) \
-{                                                                      \
-    uint32_t vd_ofs, vj_ofs;                                           \
-                                                                       \
-    if (!check_vec(ctx, 16)) {                                         \
-        return true;                                                   \
-    }                                                                  \
-                                                                       \
-    static const TCGOpcode vecop_list[] = {                            \
-        INDEX_op_cmp_vec, 0                                            \
-    };                                                                 \
-    static const GVecGen2i op[4] = {                                   \
-        {                                                              \
-            .fniv = gen_## NAME ##_u_vec,                              \
-            .fnoi = gen_helper_## NAME ##_bu,                          \
-            .opt_opc = vecop_list,                                     \
-            .vece = MO_8                                               \
-        },                                                             \
-        {                                                              \
-            .fniv = gen_## NAME ##_u_vec,                              \
-            .fnoi = gen_helper_## NAME ##_hu,                          \
-            .opt_opc = vecop_list,                                     \
-            .vece = MO_16                                              \
-        },                                                             \
-        {                                                              \
-            .fniv = gen_## NAME ##_u_vec,                              \
-            .fnoi = gen_helper_## NAME ##_wu,                          \
-            .opt_opc = vecop_list,                                     \
-            .vece = MO_32                                              \
-        },                                                             \
-        {                                                              \
-            .fniv = gen_## NAME ##_u_vec,                              \
-            .fnoi = gen_helper_## NAME ##_du,                          \
-            .opt_opc = vecop_list,                                     \
-            .vece = MO_64                                              \
-        }                                                              \
-    };                                                                 \
-                                                                       \
-    vd_ofs = vec_full_offset(a->vd);                                   \
-    vj_ofs = vec_full_offset(a->vj);                                   \
-                                                                       \
-    tcg_gen_gvec_2i(vd_ofs, vj_ofs, 16, ctx->vl/8, a->imm, &op[mop]);  \
-                                                                       \
-    return true;                                                       \
-}
-
-DO_CMPI_U(vslei)
-DO_CMPI_U(vslti)
+static bool do_cmp(DisasContext *ctx, arg_vvv *a,
+                   MemOp mop, TCGCond cond)
+{
+    return do_cmp_vl(ctx, a, 16, mop, cond);
+}
+
+static bool do_xcmp(DisasContext *ctx, arg_vvv *a,
+                    MemOp mop, TCGCond cond)
+{
+    return do_cmp_vl(ctx, a, 32, mop, cond);
+}
+
+static bool do_cmpi_vl(DisasContext *ctx, arg_vv_i *a,
+                       uint32_t oprsz, MemOp mop, TCGCond cond)
+{
+    uint32_t vd_ofs, vj_ofs;
+
+    if (!check_vec(ctx, oprsz)) {
+        return true;
+    }
+
+    vd_ofs = vec_full_offset(a->vd);
+    vj_ofs = vec_full_offset(a->vj);
+
+    tcg_gen_gvec_cmpi(cond, mop, vd_ofs, vj_ofs, a->imm, oprsz, ctx->vl / 8);
+    return true;
+}
+
+static bool do_cmpi(DisasContext *ctx, arg_vv_i *a,
+                    MemOp mop, TCGCond cond)
+{
+    return do_cmpi_vl(ctx, a, 16, mop, cond);
+}
+
+static bool do_xcmpi(DisasContext *ctx, arg_vv_i *a,
+                     MemOp mop, TCGCond cond)
+{
+    return do_cmpi_vl(ctx, a, 32, mop, cond);
+}
 
 TRANS(vseq_b, LSX, do_cmp, MO_8, TCG_COND_EQ)
 TRANS(vseq_h, LSX, do_cmp, MO_16, TCG_COND_EQ)
 TRANS(vseq_w, LSX, do_cmp, MO_32, TCG_COND_EQ)
 TRANS(vseq_d, LSX, do_cmp, MO_64, TCG_COND_EQ)
-TRANS(vseqi_b, LSX, do_vseqi_s, MO_8)
-TRANS(vseqi_h, LSX, do_vseqi_s, MO_16)
-TRANS(vseqi_w, LSX, do_vseqi_s, MO_32)
-TRANS(vseqi_d, LSX, do_vseqi_s, MO_64)
+TRANS(vseqi_b, LSX, do_cmpi, MO_8, TCG_COND_EQ)
+TRANS(vseqi_h, LSX, do_cmpi, MO_16, TCG_COND_EQ)
+TRANS(vseqi_w, LSX, do_cmpi, MO_32, TCG_COND_EQ)
+TRANS(vseqi_d, LSX, do_cmpi, MO_64, TCG_COND_EQ)
+TRANS(xvseq_b, LASX, do_xcmp, MO_8, TCG_COND_EQ)
+TRANS(xvseq_h, LASX, do_xcmp, MO_16, TCG_COND_EQ)
+TRANS(xvseq_w, LASX, do_xcmp, MO_32, TCG_COND_EQ)
+TRANS(xvseq_d, LASX, do_xcmp, MO_64, TCG_COND_EQ)
+TRANS(xvseqi_b, LASX, do_xcmpi, MO_8, TCG_COND_EQ)
+TRANS(xvseqi_h, LASX, do_xcmpi, MO_16, TCG_COND_EQ)
+TRANS(xvseqi_w, LASX, do_xcmpi, MO_32, TCG_COND_EQ)
+TRANS(xvseqi_d, LASX, do_xcmpi, MO_64, TCG_COND_EQ)
 
 TRANS(vsle_b, LSX, do_cmp, MO_8, TCG_COND_LE)
 TRANS(vsle_h, LSX, do_cmp, MO_16, TCG_COND_LE)
 TRANS(vsle_w, LSX, do_cmp, MO_32, TCG_COND_LE)
 TRANS(vsle_d, LSX, do_cmp, MO_64, TCG_COND_LE)
-TRANS(vslei_b, LSX, do_vslei_s, MO_8)
-TRANS(vslei_h, LSX, do_vslei_s, MO_16)
-TRANS(vslei_w, LSX, do_vslei_s, MO_32)
-TRANS(vslei_d, LSX, do_vslei_s, MO_64)
+TRANS(vslei_b, LSX, do_cmpi, MO_8, TCG_COND_LE)
+TRANS(vslei_h, LSX, do_cmpi, MO_16, TCG_COND_LE)
+TRANS(vslei_w, LSX, do_cmpi, MO_32, TCG_COND_LE)
+TRANS(vslei_d, LSX, do_cmpi, MO_64, TCG_COND_LE)
 TRANS(vsle_bu, LSX, do_cmp, MO_8, TCG_COND_LEU)
 TRANS(vsle_hu, LSX, do_cmp, MO_16, TCG_COND_LEU)
 TRANS(vsle_wu, LSX, do_cmp, MO_32, TCG_COND_LEU)
 TRANS(vsle_du, LSX, do_cmp, MO_64, TCG_COND_LEU)
-TRANS(vslei_bu, LSX, do_vslei_u, MO_8)
-TRANS(vslei_hu, LSX, do_vslei_u, MO_16)
-TRANS(vslei_wu, LSX, do_vslei_u, MO_32)
-TRANS(vslei_du, LSX, do_vslei_u, MO_64)
+TRANS(vslei_bu, LSX, do_cmpi, MO_8, TCG_COND_LEU)
+TRANS(vslei_hu, LSX, do_cmpi, MO_16, TCG_COND_LEU)
+TRANS(vslei_wu, LSX, do_cmpi, MO_32, TCG_COND_LEU)
+TRANS(vslei_du, LSX, do_cmpi, MO_64, TCG_COND_LEU)
+TRANS(xvsle_b, LASX, do_xcmp, MO_8, TCG_COND_LE)
+TRANS(xvsle_h, LASX, do_xcmp, MO_16, TCG_COND_LE)
+TRANS(xvsle_w, LASX, do_xcmp, MO_32, TCG_COND_LE)
+TRANS(xvsle_d, LASX, do_xcmp, MO_64, TCG_COND_LE)
+TRANS(xvslei_b, LASX, do_xcmpi, MO_8, TCG_COND_LE)
+TRANS(xvslei_h, LASX, do_xcmpi, MO_16, TCG_COND_LE)
+TRANS(xvslei_w, LASX, do_xcmpi, MO_32, TCG_COND_LE)
+TRANS(xvslei_d, LASX, do_xcmpi, MO_64, TCG_COND_LE)
+TRANS(xvsle_bu, LASX, do_xcmp, MO_8, TCG_COND_LEU)
+TRANS(xvsle_hu, LASX, do_xcmp, MO_16, TCG_COND_LEU)
+TRANS(xvsle_wu, LASX, do_xcmp, MO_32, TCG_COND_LEU)
+TRANS(xvsle_du, LASX, do_xcmp, MO_64, TCG_COND_LEU)
+TRANS(xvslei_bu, LASX, do_xcmpi, MO_8, TCG_COND_LEU)
+TRANS(xvslei_hu, LASX, do_xcmpi, MO_16, TCG_COND_LEU)
+TRANS(xvslei_wu, LASX, do_xcmpi, MO_32, TCG_COND_LEU)
+TRANS(xvslei_du, LASX, do_xcmpi, MO_64, TCG_COND_LEU)
 
 TRANS(vslt_b, LSX, do_cmp, MO_8, TCG_COND_LT)
 TRANS(vslt_h, LSX, do_cmp, MO_16, TCG_COND_LT)
 TRANS(vslt_w, LSX, do_cmp, MO_32, TCG_COND_LT)
 TRANS(vslt_d, LSX, do_cmp, MO_64, TCG_COND_LT)
-TRANS(vslti_b, LSX, do_vslti_s, MO_8)
-TRANS(vslti_h, LSX, do_vslti_s, MO_16)
-TRANS(vslti_w, LSX, do_vslti_s, MO_32)
-TRANS(vslti_d, LSX, do_vslti_s, MO_64)
+TRANS(vslti_b, LSX, do_cmpi, MO_8, TCG_COND_LT)
+TRANS(vslti_h, LSX, do_cmpi, MO_16, TCG_COND_LT)
+TRANS(vslti_w, LSX, do_cmpi, MO_32, TCG_COND_LT)
+TRANS(vslti_d, LSX, do_cmpi, MO_64, TCG_COND_LT)
 TRANS(vslt_bu, LSX, do_cmp, MO_8, TCG_COND_LTU)
 TRANS(vslt_hu, LSX, do_cmp, MO_16, TCG_COND_LTU)
 TRANS(vslt_wu, LSX, do_cmp, MO_32, TCG_COND_LTU)
 TRANS(vslt_du, LSX, do_cmp, MO_64, TCG_COND_LTU)
-TRANS(vslti_bu, LSX, do_vslti_u, MO_8)
-TRANS(vslti_hu, LSX, do_vslti_u, MO_16)
-TRANS(vslti_wu, LSX, do_vslti_u, MO_32)
-TRANS(vslti_du, LSX, do_vslti_u, MO_64)
+TRANS(vslti_bu, LSX, do_cmpi, MO_8, TCG_COND_LTU)
+TRANS(vslti_hu, LSX, do_cmpi, MO_16, TCG_COND_LTU)
+TRANS(vslti_wu, LSX, do_cmpi, MO_32, TCG_COND_LTU)
+TRANS(vslti_du, LSX, do_cmpi, MO_64, TCG_COND_LTU)
+TRANS(xvslt_b, LASX, do_xcmp, MO_8, TCG_COND_LT)
+TRANS(xvslt_h, LASX, do_xcmp, MO_16, TCG_COND_LT)
+TRANS(xvslt_w, LASX, do_xcmp, MO_32, TCG_COND_LT)
+TRANS(xvslt_d, LASX, do_xcmp, MO_64, TCG_COND_LT)
+TRANS(xvslti_b, LASX, do_xcmpi, MO_8, TCG_COND_LT)
+TRANS(xvslti_h, LASX, do_xcmpi, MO_16, TCG_COND_LT)
+TRANS(xvslti_w, LASX, do_xcmpi, MO_32, TCG_COND_LT)
+TRANS(xvslti_d, LASX, do_xcmpi, MO_64, TCG_COND_LT)
+TRANS(xvslt_bu, LASX, do_xcmp, MO_8, TCG_COND_LTU)
+TRANS(xvslt_hu, LASX, do_xcmp, MO_16, TCG_COND_LTU)
+TRANS(xvslt_wu, LASX, do_xcmp, MO_32, TCG_COND_LTU)
+TRANS(xvslt_du, LASX, do_xcmp, MO_64, TCG_COND_LTU)
+TRANS(xvslti_bu, LASX, do_xcmpi, MO_8, TCG_COND_LTU)
+TRANS(xvslti_hu, LASX, do_xcmpi, MO_16, TCG_COND_LTU)
+TRANS(xvslti_wu, LASX, do_xcmpi, MO_32, TCG_COND_LTU)
+TRANS(xvslti_du, LASX, do_xcmpi, MO_64, TCG_COND_LTU)
 
 static bool trans_vfcmp_cond_s(DisasContext *ctx, arg_vvv_fcond *a)
 {
-- 
2.39.1


