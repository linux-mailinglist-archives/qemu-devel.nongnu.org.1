Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 333E2743688
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:08:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF92p-0008N2-CS; Fri, 30 Jun 2023 03:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qF92h-0008Ge-3s
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:48 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qF92d-00083H-JS
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:46 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxiMVji55kqDQEAA--.6790S3;
 Fri, 30 Jun 2023 15:59:31 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxjiNIi55kExQTAA--.24469S40; 
 Fri, 30 Jun 2023 15:59:30 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 38/46] target/loongarch: Implement xvseq xvsle xvslt
Date: Fri, 30 Jun 2023 15:58:56 +0800
Message-Id: <20230630075904.45940-39-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230630075904.45940-1-gaosong@loongson.cn>
References: <20230630075904.45940-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjiNIi55kExQTAA--.24469S40
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
 target/loongarch/disas.c                     |  43 +++
 target/loongarch/insn_trans/trans_lasx.c.inc |  43 +++
 target/loongarch/insn_trans/trans_lsx.c.inc  | 263 ++++++++++---------
 target/loongarch/insns.decode                |  43 +++
 target/loongarch/vec.h                       |   4 +
 target/loongarch/vec_helper.c                |   9 +-
 6 files changed, 269 insertions(+), 136 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 3fd3dc3591..295ba74f2b 100644
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
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 9fe530eaf8..dceff8d112 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -715,6 +715,49 @@ TRANS(xvffintl_d_w, gen_vv, 32, gen_helper_vffintl_d_w)
 TRANS(xvffinth_d_w, gen_vv, 32, gen_helper_vffinth_d_w)
 TRANS(xvffint_s_l, gen_vvv, 32, gen_helper_vffint_s_l)
 
+TRANS(xvseq_b, do_cmp, 32, MO_8, TCG_COND_EQ)
+TRANS(xvseq_h, do_cmp, 32, MO_16, TCG_COND_EQ)
+TRANS(xvseq_w, do_cmp, 32, MO_32, TCG_COND_EQ)
+TRANS(xvseq_d, do_cmp, 32, MO_64, TCG_COND_EQ)
+TRANS(xvseqi_b, do_vseqi_s, 32, MO_8)
+TRANS(xvseqi_h, do_vseqi_s, 32, MO_16)
+TRANS(xvseqi_w, do_vseqi_s, 32, MO_32)
+TRANS(xvseqi_d, do_vseqi_s, 32, MO_64)
+
+TRANS(xvsle_b, do_cmp, 32, MO_8, TCG_COND_LE)
+TRANS(xvsle_h, do_cmp, 32, MO_16, TCG_COND_LE)
+TRANS(xvsle_w, do_cmp, 32, MO_32, TCG_COND_LE)
+TRANS(xvsle_d, do_cmp, 32, MO_64, TCG_COND_LE)
+TRANS(xvslei_b, do_vslei_s, 32, MO_8)
+TRANS(xvslei_h, do_vslei_s, 32, MO_16)
+TRANS(xvslei_w, do_vslei_s, 32, MO_32)
+TRANS(xvslei_d, do_vslei_s, 32, MO_64)
+TRANS(xvsle_bu, do_cmp, 32, MO_8, TCG_COND_LEU)
+TRANS(xvsle_hu, do_cmp, 32, MO_16, TCG_COND_LEU)
+TRANS(xvsle_wu, do_cmp, 32, MO_32, TCG_COND_LEU)
+TRANS(xvsle_du, do_cmp, 32, MO_64, TCG_COND_LEU)
+TRANS(xvslei_bu, do_vslei_u, 32, MO_8)
+TRANS(xvslei_hu, do_vslei_u, 32, MO_16)
+TRANS(xvslei_wu, do_vslei_u, 32, MO_32)
+TRANS(xvslei_du, do_vslei_u, 32, MO_64)
+
+TRANS(xvslt_b, do_cmp, 32, MO_8, TCG_COND_LT)
+TRANS(xvslt_h, do_cmp, 32, MO_16, TCG_COND_LT)
+TRANS(xvslt_w, do_cmp, 32, MO_32, TCG_COND_LT)
+TRANS(xvslt_d, do_cmp, 32, MO_64, TCG_COND_LT)
+TRANS(xvslti_b, do_vslti_s, 32, MO_8)
+TRANS(xvslti_h, do_vslti_s, 32, MO_16)
+TRANS(xvslti_w, do_vslti_s, 32, MO_32)
+TRANS(xvslti_d, do_vslti_s, 32, MO_64)
+TRANS(xvslt_bu, do_cmp, 32, MO_8, TCG_COND_LTU)
+TRANS(xvslt_hu, do_cmp, 32, MO_16, TCG_COND_LTU)
+TRANS(xvslt_wu, do_cmp, 32, MO_32, TCG_COND_LTU)
+TRANS(xvslt_du, do_cmp, 32, MO_64, TCG_COND_LTU)
+TRANS(xvslti_bu, do_vslti_u, 32, MO_8)
+TRANS(xvslti_hu, do_vslti_u, 32, MO_16)
+TRANS(xvslti_wu, do_vslti_u, 32, MO_32)
+TRANS(xvslti_du, do_vslti_u, 32, MO_64)
+
 TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index 98a50f2839..077101a86d 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_lsx.c.inc
@@ -3686,7 +3686,8 @@ TRANS(vffintl_d_w, gen_vv, 16, gen_helper_vffintl_d_w)
 TRANS(vffinth_d_w, gen_vv, 16, gen_helper_vffinth_d_w)
 TRANS(vffint_s_l, gen_vvv, 16, gen_helper_vffint_s_l)
 
-static bool do_cmp(DisasContext *ctx, arg_vvv *a, MemOp mop, TCGCond cond)
+static bool do_cmp(DisasContext *ctx, arg_vvv *a,
+                   uint32_t oprsz, MemOp mop, TCGCond cond)
 {
     uint32_t vd_ofs, vj_ofs, vk_ofs;
 
@@ -3696,7 +3697,7 @@ static bool do_cmp(DisasContext *ctx, arg_vvv *a, MemOp mop, TCGCond cond)
     vj_ofs = vec_full_offset(a->vj);
     vk_ofs = vec_full_offset(a->vk);
 
-    tcg_gen_gvec_cmp(cond, mop, vd_ofs, vj_ofs, vk_ofs, 16, ctx->vl/8);
+    tcg_gen_gvec_cmp(cond, mop, vd_ofs, vj_ofs, vk_ofs, oprsz, ctx->vl / 8);
     return true;
 }
 
@@ -3731,145 +3732,147 @@ static void gen_vslti_u_vec(unsigned vece, TCGv_vec t, TCGv_vec a, int64_t imm)
     do_cmpi_vec(TCG_COND_LTU, vece, t, a, imm);
 }
 
-#define DO_CMPI_S(NAME)                                                \
-static bool do_## NAME ##_s(DisasContext *ctx, arg_vv_i *a, MemOp mop) \
-{                                                                      \
-    uint32_t vd_ofs, vj_ofs;                                           \
-                                                                       \
-    CHECK_VEC;                                                         \
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
+#define DO_CMPI_S(NAME)                                                    \
+static bool do_## NAME ##_s(DisasContext *ctx,                             \
+                            arg_vv_i *a, uint32_t oprsz, MemOp mop)        \
+{                                                                          \
+    uint32_t vd_ofs, vj_ofs;                                               \
+                                                                           \
+    CHECK_VEC;                                                             \
+                                                                           \
+    static const TCGOpcode vecop_list[] = {                                \
+        INDEX_op_cmp_vec, 0                                                \
+    };                                                                     \
+    static const GVecGen2i op[4] = {                                       \
+        {                                                                  \
+            .fniv = gen_## NAME ##_s_vec,                                  \
+            .fnoi = gen_helper_## NAME ##_b,                               \
+            .opt_opc = vecop_list,                                         \
+            .vece = MO_8                                                   \
+        },                                                                 \
+        {                                                                  \
+            .fniv = gen_## NAME ##_s_vec,                                  \
+            .fnoi = gen_helper_## NAME ##_h,                               \
+            .opt_opc = vecop_list,                                         \
+            .vece = MO_16                                                  \
+        },                                                                 \
+        {                                                                  \
+            .fniv = gen_## NAME ##_s_vec,                                  \
+            .fnoi = gen_helper_## NAME ##_w,                               \
+            .opt_opc = vecop_list,                                         \
+            .vece = MO_32                                                  \
+        },                                                                 \
+        {                                                                  \
+            .fniv = gen_## NAME ##_s_vec,                                  \
+            .fnoi = gen_helper_## NAME ##_d,                               \
+            .opt_opc = vecop_list,                                         \
+            .vece = MO_64                                                  \
+        }                                                                  \
+    };                                                                     \
+                                                                           \
+    vd_ofs = vec_full_offset(a->vd);                                       \
+    vj_ofs = vec_full_offset(a->vj);                                       \
+                                                                           \
+    tcg_gen_gvec_2i(vd_ofs, vj_ofs, oprsz, ctx->vl / 8, a->imm, &op[mop]); \
+                                                                           \
+    return true;                                                           \
 }
 
 DO_CMPI_S(vseqi)
 DO_CMPI_S(vslei)
 DO_CMPI_S(vslti)
 
-#define DO_CMPI_U(NAME)                                                \
-static bool do_## NAME ##_u(DisasContext *ctx, arg_vv_i *a, MemOp mop) \
-{                                                                      \
-    uint32_t vd_ofs, vj_ofs;                                           \
-                                                                       \
-    CHECK_VEC;                                                         \
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
+#define DO_CMPI_U(NAME)                                                    \
+static bool do_## NAME ##_u(DisasContext *ctx,                             \
+                            arg_vv_i *a, uint32_t oprsz, MemOp mop)        \
+{                                                                          \
+    uint32_t vd_ofs, vj_ofs;                                               \
+                                                                           \
+    CHECK_VEC;                                                             \
+                                                                           \
+    static const TCGOpcode vecop_list[] = {                                \
+        INDEX_op_cmp_vec, 0                                                \
+    };                                                                     \
+    static const GVecGen2i op[4] = {                                       \
+        {                                                                  \
+            .fniv = gen_## NAME ##_u_vec,                                  \
+            .fnoi = gen_helper_## NAME ##_bu,                              \
+            .opt_opc = vecop_list,                                         \
+            .vece = MO_8                                                   \
+        },                                                                 \
+        {                                                                  \
+            .fniv = gen_## NAME ##_u_vec,                                  \
+            .fnoi = gen_helper_## NAME ##_hu,                              \
+            .opt_opc = vecop_list,                                         \
+            .vece = MO_16                                                  \
+        },                                                                 \
+        {                                                                  \
+            .fniv = gen_## NAME ##_u_vec,                                  \
+            .fnoi = gen_helper_## NAME ##_wu,                              \
+            .opt_opc = vecop_list,                                         \
+            .vece = MO_32                                                  \
+        },                                                                 \
+        {                                                                  \
+            .fniv = gen_## NAME ##_u_vec,                                  \
+            .fnoi = gen_helper_## NAME ##_du,                              \
+            .opt_opc = vecop_list,                                         \
+            .vece = MO_64                                                  \
+        }                                                                  \
+    };                                                                     \
+                                                                           \
+    vd_ofs = vec_full_offset(a->vd);                                       \
+    vj_ofs = vec_full_offset(a->vj);                                       \
+                                                                           \
+    tcg_gen_gvec_2i(vd_ofs, vj_ofs, oprsz, ctx->vl / 8, a->imm, &op[mop]); \
+                                                                           \
+    return true;                                                           \
 }
 
 DO_CMPI_U(vslei)
 DO_CMPI_U(vslti)
 
-TRANS(vseq_b, do_cmp, MO_8, TCG_COND_EQ)
-TRANS(vseq_h, do_cmp, MO_16, TCG_COND_EQ)
-TRANS(vseq_w, do_cmp, MO_32, TCG_COND_EQ)
-TRANS(vseq_d, do_cmp, MO_64, TCG_COND_EQ)
-TRANS(vseqi_b, do_vseqi_s, MO_8)
-TRANS(vseqi_h, do_vseqi_s, MO_16)
-TRANS(vseqi_w, do_vseqi_s, MO_32)
-TRANS(vseqi_d, do_vseqi_s, MO_64)
-
-TRANS(vsle_b, do_cmp, MO_8, TCG_COND_LE)
-TRANS(vsle_h, do_cmp, MO_16, TCG_COND_LE)
-TRANS(vsle_w, do_cmp, MO_32, TCG_COND_LE)
-TRANS(vsle_d, do_cmp, MO_64, TCG_COND_LE)
-TRANS(vslei_b, do_vslei_s, MO_8)
-TRANS(vslei_h, do_vslei_s, MO_16)
-TRANS(vslei_w, do_vslei_s, MO_32)
-TRANS(vslei_d, do_vslei_s, MO_64)
-TRANS(vsle_bu, do_cmp, MO_8, TCG_COND_LEU)
-TRANS(vsle_hu, do_cmp, MO_16, TCG_COND_LEU)
-TRANS(vsle_wu, do_cmp, MO_32, TCG_COND_LEU)
-TRANS(vsle_du, do_cmp, MO_64, TCG_COND_LEU)
-TRANS(vslei_bu, do_vslei_u, MO_8)
-TRANS(vslei_hu, do_vslei_u, MO_16)
-TRANS(vslei_wu, do_vslei_u, MO_32)
-TRANS(vslei_du, do_vslei_u, MO_64)
-
-TRANS(vslt_b, do_cmp, MO_8, TCG_COND_LT)
-TRANS(vslt_h, do_cmp, MO_16, TCG_COND_LT)
-TRANS(vslt_w, do_cmp, MO_32, TCG_COND_LT)
-TRANS(vslt_d, do_cmp, MO_64, TCG_COND_LT)
-TRANS(vslti_b, do_vslti_s, MO_8)
-TRANS(vslti_h, do_vslti_s, MO_16)
-TRANS(vslti_w, do_vslti_s, MO_32)
-TRANS(vslti_d, do_vslti_s, MO_64)
-TRANS(vslt_bu, do_cmp, MO_8, TCG_COND_LTU)
-TRANS(vslt_hu, do_cmp, MO_16, TCG_COND_LTU)
-TRANS(vslt_wu, do_cmp, MO_32, TCG_COND_LTU)
-TRANS(vslt_du, do_cmp, MO_64, TCG_COND_LTU)
-TRANS(vslti_bu, do_vslti_u, MO_8)
-TRANS(vslti_hu, do_vslti_u, MO_16)
-TRANS(vslti_wu, do_vslti_u, MO_32)
-TRANS(vslti_du, do_vslti_u, MO_64)
+TRANS(vseq_b, do_cmp, 16, MO_8, TCG_COND_EQ)
+TRANS(vseq_h, do_cmp, 16, MO_16, TCG_COND_EQ)
+TRANS(vseq_w, do_cmp, 16, MO_32, TCG_COND_EQ)
+TRANS(vseq_d, do_cmp, 16, MO_64, TCG_COND_EQ)
+TRANS(vseqi_b, do_vseqi_s, 16, MO_8)
+TRANS(vseqi_h, do_vseqi_s, 16, MO_16)
+TRANS(vseqi_w, do_vseqi_s, 16, MO_32)
+TRANS(vseqi_d, do_vseqi_s, 16, MO_64)
+
+TRANS(vsle_b, do_cmp, 16, MO_8, TCG_COND_LE)
+TRANS(vsle_h, do_cmp, 16, MO_16, TCG_COND_LE)
+TRANS(vsle_w, do_cmp, 16, MO_32, TCG_COND_LE)
+TRANS(vsle_d, do_cmp, 16, MO_64, TCG_COND_LE)
+TRANS(vslei_b, do_vslei_s, 16, MO_8)
+TRANS(vslei_h, do_vslei_s, 16, MO_16)
+TRANS(vslei_w, do_vslei_s, 16, MO_32)
+TRANS(vslei_d, do_vslei_s, 16, MO_64)
+TRANS(vsle_bu, do_cmp, 16, MO_8, TCG_COND_LEU)
+TRANS(vsle_hu, do_cmp, 16, MO_16, TCG_COND_LEU)
+TRANS(vsle_wu, do_cmp, 16, MO_32, TCG_COND_LEU)
+TRANS(vsle_du, do_cmp, 16, MO_64, TCG_COND_LEU)
+TRANS(vslei_bu, do_vslei_u, 16, MO_8)
+TRANS(vslei_hu, do_vslei_u, 16, MO_16)
+TRANS(vslei_wu, do_vslei_u, 16, MO_32)
+TRANS(vslei_du, do_vslei_u, 16, MO_64)
+
+TRANS(vslt_b, do_cmp, 16, MO_8, TCG_COND_LT)
+TRANS(vslt_h, do_cmp, 16, MO_16, TCG_COND_LT)
+TRANS(vslt_w, do_cmp, 16, MO_32, TCG_COND_LT)
+TRANS(vslt_d, do_cmp, 16, MO_64, TCG_COND_LT)
+TRANS(vslti_b, do_vslti_s, 16, MO_8)
+TRANS(vslti_h, do_vslti_s, 16, MO_16)
+TRANS(vslti_w, do_vslti_s, 16, MO_32)
+TRANS(vslti_d, do_vslti_s, 16, MO_64)
+TRANS(vslt_bu, do_cmp, 16, MO_8, TCG_COND_LTU)
+TRANS(vslt_hu, do_cmp, 16, MO_16, TCG_COND_LTU)
+TRANS(vslt_wu, do_cmp, 16, MO_32, TCG_COND_LTU)
+TRANS(vslt_du, do_cmp, 16, MO_64, TCG_COND_LTU)
+TRANS(vslti_bu, do_vslti_u, 16, MO_8)
+TRANS(vslti_hu, do_vslti_u, 16, MO_16)
+TRANS(vslti_wu, do_vslti_u, 16, MO_32)
+TRANS(vslti_du, do_vslti_u, 16, MO_64)
 
 static bool trans_vfcmp_cond_s(DisasContext *ctx, arg_vvv_fcond *a)
 {
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
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index 62c50e74aa..06cc5331a3 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -89,4 +89,8 @@
 #define DO_BITSET(a, bit) (a | 1ull << bit)
 #define DO_BITREV(a, bit) (a ^ (1ull << bit))
 
+#define VSEQ(a, b) (a == b ? -1 : 0)
+#define VSLE(a, b) (a <= b ? -1 : 0)
+#define VSLT(a, b) (a < b ? -1 : 0)
+
 #endif /* LOONGARCH_VEC_H */
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index f07ef30b51..169397160d 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -3091,19 +3091,16 @@ void HELPER(vffint_s_l)(CPULoongArchState *env,
     *Vd = temp;
 }
 
-#define VSEQ(a, b) (a == b ? -1 : 0)
-#define VSLE(a, b) (a <= b ? -1 : 0)
-#define VSLT(a, b) (a < b ? -1 : 0)
-
 #define VCMPI(NAME, BIT, E, DO_OP)                              \
 void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t v) \
 {                                                               \
-    int i;                                                      \
+    int i, len;                                                 \
     VReg *Vd = (VReg *)vd;                                      \
     VReg *Vj = (VReg *)vj;                                      \
     typedef __typeof(Vd->E(0)) TD;                              \
                                                                 \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                         \
+    len = (simd_oprsz(v) == 16) ? LSX_LEN : LASX_LEN;           \
+    for (i = 0; i < len / BIT; i++) {                           \
         Vd->E(i) = DO_OP(Vj->E(i), (TD)imm);                    \
     }                                                           \
 }
-- 
2.39.1


