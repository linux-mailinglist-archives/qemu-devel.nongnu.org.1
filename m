Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDF374364C
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:00:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF92I-00087R-MU; Fri, 30 Jun 2023 03:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qF92H-00086V-2m
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:21 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qF92B-0007vF-Of
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:20 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxqMVPi55kYTQEAA--.6847S3;
 Fri, 30 Jun 2023 15:59:11 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxjiNIi55kExQTAA--.24469S6; 
 Fri, 30 Jun 2023 15:59:10 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 04/46] target/loongarch: Implement xvadd/xvsub
Date: Fri, 30 Jun 2023 15:58:22 +0800
Message-Id: <20230630075904.45940-5-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230630075904.45940-1-gaosong@loongson.cn>
References: <20230630075904.45940-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjiNIi55kExQTAA--.24469S6
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
- XVADD.{B/H/W/D/Q};
- XVSUB.{B/H/W/D/Q}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  23 +
 target/loongarch/insn_trans/trans_lasx.c.inc |  52 +-
 target/loongarch/insn_trans/trans_lsx.c.inc  | 511 +++++++++----------
 target/loongarch/insns.decode                |  14 +
 target/loongarch/translate.c                 |   5 +
 target/loongarch/vec.h                       |  17 +
 6 files changed, 351 insertions(+), 271 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 5c402d944d..d8b62ba532 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1695,3 +1695,26 @@ INSN_LSX(vstelm_d,         vr_ii)
 INSN_LSX(vstelm_w,         vr_ii)
 INSN_LSX(vstelm_h,         vr_ii)
 INSN_LSX(vstelm_b,         vr_ii)
+
+#define INSN_LASX(insn, type)                               \
+static bool trans_##insn(DisasContext *ctx, arg_##type * a) \
+{                                                           \
+    output_##type ## _x(ctx, a, #insn);                     \
+    return true;                                            \
+}
+
+static void output_vvv_x(DisasContext *ctx, arg_vvv * a, const char *mnemonic)
+{
+    output(ctx, mnemonic, "x%d, x%d, x%d", a->vd, a->vj, a->vk);
+}
+
+INSN_LASX(xvadd_b,           vvv)
+INSN_LASX(xvadd_h,           vvv)
+INSN_LASX(xvadd_w,           vvv)
+INSN_LASX(xvadd_d,           vvv)
+INSN_LASX(xvadd_q,           vvv)
+INSN_LASX(xvsub_b,           vvv)
+INSN_LASX(xvsub_h,           vvv)
+INSN_LASX(xvsub_w,           vvv)
+INSN_LASX(xvsub_d,           vvv)
+INSN_LASX(xvsub_q,           vvv)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 75a77f5dce..86ba296a73 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -4,13 +4,45 @@
  * Copyright (c) 2023 Loongson Technology Corporation Limited
  */
 
-#ifndef CONFIG_USER_ONLY
-#define CHECK_ASXE do { \
-    if ((ctx->base.tb->flags & HW_FLAGS_EUEN_ASXE) == 0) { \
-        generate_exception(ctx, EXCCODE_ASXD); \
-        return true; \
-    } \
-} while (0)
-#else
-#define CHECK_ASXE
-#endif
+TRANS(xvadd_b, gvec_vvv, 32, MO_8, tcg_gen_gvec_add)
+TRANS(xvadd_h, gvec_vvv, 32, MO_16, tcg_gen_gvec_add)
+TRANS(xvadd_w, gvec_vvv, 32, MO_32, tcg_gen_gvec_add)
+TRANS(xvadd_d, gvec_vvv, 32, MO_64, tcg_gen_gvec_add)
+
+#define XVADDSUB_Q(NAME)                                         \
+static bool trans_xv## NAME ##_q(DisasContext *ctx, arg_vvv * a) \
+{                                                                \
+    TCGv_i64 rh, rl, ah, al, bh, bl;                             \
+    int i;                                                       \
+                                                                 \
+    CHECK_VEC;                                                   \
+                                                                 \
+    rh = tcg_temp_new_i64();                                     \
+    rl = tcg_temp_new_i64();                                     \
+    ah = tcg_temp_new_i64();                                     \
+    al = tcg_temp_new_i64();                                     \
+    bh = tcg_temp_new_i64();                                     \
+    bl = tcg_temp_new_i64();                                     \
+                                                                 \
+    for (i = 0; i < 2; i++) {                                    \
+        get_vreg64(ah, a->vj, 1 + i * 2);                        \
+        get_vreg64(al, a->vj, 0 + i * 2);                        \
+        get_vreg64(bh, a->vk, 1 + i * 2);                        \
+        get_vreg64(bl, a->vk, 0 + i * 2);                        \
+                                                                 \
+        tcg_gen_## NAME ##2_i64(rl, rh, al, ah, bl, bh);         \
+                                                                 \
+        set_vreg64(rh, a->vd, 1 + i * 2);                        \
+        set_vreg64(rl, a->vd, 0 + i * 2);                        \
+   }                                                             \
+                                                                 \
+    return true;                                                 \
+}
+
+XVADDSUB_Q(add)
+XVADDSUB_Q(sub)
+
+TRANS(xvsub_b, gvec_vvv, 32, MO_8, tcg_gen_gvec_sub)
+TRANS(xvsub_h, gvec_vvv, 32, MO_16, tcg_gen_gvec_sub)
+TRANS(xvsub_w, gvec_vvv, 32, MO_32, tcg_gen_gvec_sub)
+TRANS(xvsub_d, gvec_vvv, 32, MO_64, tcg_gen_gvec_sub)
diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index 68779daff6..63061bd4a1 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_lsx.c.inc
@@ -4,17 +4,6 @@
  * Copyright (c) 2022-2023 Loongson Technology Corporation Limited
  */
 
-#ifndef CONFIG_USER_ONLY
-#define CHECK_SXE do { \
-    if ((ctx->base.tb->flags & HW_FLAGS_EUEN_SXE) == 0) { \
-        generate_exception(ctx, EXCCODE_SXD); \
-        return true; \
-    } \
-} while (0)
-#else
-#define CHECK_SXE
-#endif
-
 static bool gen_vvvv(DisasContext *ctx, arg_vvvv *a,
                      void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32,
                                   TCGv_i32, TCGv_i32))
@@ -24,7 +13,7 @@ static bool gen_vvvv(DisasContext *ctx, arg_vvvv *a,
     TCGv_i32 vk = tcg_constant_i32(a->vk);
     TCGv_i32 va = tcg_constant_i32(a->va);
 
-    CHECK_SXE;
+    CHECK_VEC;
     func(cpu_env, vd, vj, vk, va);
     return true;
 }
@@ -36,7 +25,7 @@ static bool gen_vvv(DisasContext *ctx, arg_vvv *a,
     TCGv_i32 vj = tcg_constant_i32(a->vj);
     TCGv_i32 vk = tcg_constant_i32(a->vk);
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     func(cpu_env, vd, vj, vk);
     return true;
@@ -48,7 +37,7 @@ static bool gen_vv(DisasContext *ctx, arg_vv *a,
     TCGv_i32 vd = tcg_constant_i32(a->vd);
     TCGv_i32 vj = tcg_constant_i32(a->vj);
 
-    CHECK_SXE;
+    CHECK_VEC;
     func(cpu_env, vd, vj);
     return true;
 }
@@ -60,7 +49,7 @@ static bool gen_vv_i(DisasContext *ctx, arg_vv_i *a,
     TCGv_i32 vj = tcg_constant_i32(a->vj);
     TCGv_i32 imm = tcg_constant_i32(a->imm);
 
-    CHECK_SXE;
+    CHECK_VEC;
     func(cpu_env, vd, vj, imm);
     return true;
 }
@@ -71,24 +60,24 @@ static bool gen_cv(DisasContext *ctx, arg_cv *a,
     TCGv_i32 vj = tcg_constant_i32(a->vj);
     TCGv_i32 cd = tcg_constant_i32(a->cd);
 
-    CHECK_SXE;
+    CHECK_VEC;
     func(cpu_env, cd, vj);
     return true;
 }
 
-static bool gvec_vvv(DisasContext *ctx, arg_vvv *a, MemOp mop,
+static bool gvec_vvv(DisasContext *ctx, arg_vvv *a, uint32_t oprsz, MemOp mop,
                      void (*func)(unsigned, uint32_t, uint32_t,
                                   uint32_t, uint32_t, uint32_t))
 {
     uint32_t vd_ofs, vj_ofs, vk_ofs;
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     vd_ofs = vec_full_offset(a->vd);
     vj_ofs = vec_full_offset(a->vj);
     vk_ofs = vec_full_offset(a->vk);
 
-    func(mop, vd_ofs, vj_ofs, vk_ofs, 16, ctx->vl/8);
+    func(mop, vd_ofs, vj_ofs, vk_ofs, oprsz, ctx->vl / 8);
     return true;
 }
 
@@ -98,7 +87,7 @@ static bool gvec_vv(DisasContext *ctx, arg_vv *a, MemOp mop,
 {
     uint32_t vd_ofs, vj_ofs;
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     vd_ofs = vec_full_offset(a->vd);
     vj_ofs = vec_full_offset(a->vj);
@@ -113,7 +102,7 @@ static bool gvec_vv_i(DisasContext *ctx, arg_vv_i *a, MemOp mop,
 {
     uint32_t vd_ofs, vj_ofs;
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     vd_ofs = vec_full_offset(a->vd);
     vj_ofs = vec_full_offset(a->vj);
@@ -126,7 +115,7 @@ static bool gvec_subi(DisasContext *ctx, arg_vv_i *a, MemOp mop)
 {
     uint32_t vd_ofs, vj_ofs;
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     vd_ofs = vec_full_offset(a->vd);
     vj_ofs = vec_full_offset(a->vj);
@@ -135,17 +124,17 @@ static bool gvec_subi(DisasContext *ctx, arg_vv_i *a, MemOp mop)
     return true;
 }
 
-TRANS(vadd_b, gvec_vvv, MO_8, tcg_gen_gvec_add)
-TRANS(vadd_h, gvec_vvv, MO_16, tcg_gen_gvec_add)
-TRANS(vadd_w, gvec_vvv, MO_32, tcg_gen_gvec_add)
-TRANS(vadd_d, gvec_vvv, MO_64, tcg_gen_gvec_add)
+TRANS(vadd_b, gvec_vvv, 16, MO_8, tcg_gen_gvec_add)
+TRANS(vadd_h, gvec_vvv, 16, MO_16, tcg_gen_gvec_add)
+TRANS(vadd_w, gvec_vvv, 16, MO_32, tcg_gen_gvec_add)
+TRANS(vadd_d, gvec_vvv, 16, MO_64, tcg_gen_gvec_add)
 
 #define VADDSUB_Q(NAME)                                        \
 static bool trans_v## NAME ##_q(DisasContext *ctx, arg_vvv *a) \
 {                                                              \
     TCGv_i64 rh, rl, ah, al, bh, bl;                           \
                                                                \
-    CHECK_SXE;                                                 \
+    CHECK_VEC;                                                 \
                                                                \
     rh = tcg_temp_new_i64();                                   \
     rl = tcg_temp_new_i64();                                   \
@@ -170,10 +159,10 @@ static bool trans_v## NAME ##_q(DisasContext *ctx, arg_vvv *a) \
 VADDSUB_Q(add)
 VADDSUB_Q(sub)
 
-TRANS(vsub_b, gvec_vvv, MO_8, tcg_gen_gvec_sub)
-TRANS(vsub_h, gvec_vvv, MO_16, tcg_gen_gvec_sub)
-TRANS(vsub_w, gvec_vvv, MO_32, tcg_gen_gvec_sub)
-TRANS(vsub_d, gvec_vvv, MO_64, tcg_gen_gvec_sub)
+TRANS(vsub_b, gvec_vvv, 16, MO_8, tcg_gen_gvec_sub)
+TRANS(vsub_h, gvec_vvv, 16, MO_16, tcg_gen_gvec_sub)
+TRANS(vsub_w, gvec_vvv, 16, MO_32, tcg_gen_gvec_sub)
+TRANS(vsub_d, gvec_vvv, 16, MO_64, tcg_gen_gvec_sub)
 
 TRANS(vaddi_bu, gvec_vv_i, MO_8, tcg_gen_gvec_addi)
 TRANS(vaddi_hu, gvec_vv_i, MO_16, tcg_gen_gvec_addi)
@@ -189,22 +178,22 @@ TRANS(vneg_h, gvec_vv, MO_16, tcg_gen_gvec_neg)
 TRANS(vneg_w, gvec_vv, MO_32, tcg_gen_gvec_neg)
 TRANS(vneg_d, gvec_vv, MO_64, tcg_gen_gvec_neg)
 
-TRANS(vsadd_b, gvec_vvv, MO_8, tcg_gen_gvec_ssadd)
-TRANS(vsadd_h, gvec_vvv, MO_16, tcg_gen_gvec_ssadd)
-TRANS(vsadd_w, gvec_vvv, MO_32, tcg_gen_gvec_ssadd)
-TRANS(vsadd_d, gvec_vvv, MO_64, tcg_gen_gvec_ssadd)
-TRANS(vsadd_bu, gvec_vvv, MO_8, tcg_gen_gvec_usadd)
-TRANS(vsadd_hu, gvec_vvv, MO_16, tcg_gen_gvec_usadd)
-TRANS(vsadd_wu, gvec_vvv, MO_32, tcg_gen_gvec_usadd)
-TRANS(vsadd_du, gvec_vvv, MO_64, tcg_gen_gvec_usadd)
-TRANS(vssub_b, gvec_vvv, MO_8, tcg_gen_gvec_sssub)
-TRANS(vssub_h, gvec_vvv, MO_16, tcg_gen_gvec_sssub)
-TRANS(vssub_w, gvec_vvv, MO_32, tcg_gen_gvec_sssub)
-TRANS(vssub_d, gvec_vvv, MO_64, tcg_gen_gvec_sssub)
-TRANS(vssub_bu, gvec_vvv, MO_8, tcg_gen_gvec_ussub)
-TRANS(vssub_hu, gvec_vvv, MO_16, tcg_gen_gvec_ussub)
-TRANS(vssub_wu, gvec_vvv, MO_32, tcg_gen_gvec_ussub)
-TRANS(vssub_du, gvec_vvv, MO_64, tcg_gen_gvec_ussub)
+TRANS(vsadd_b, gvec_vvv, 16, MO_8, tcg_gen_gvec_ssadd)
+TRANS(vsadd_h, gvec_vvv, 16, MO_16, tcg_gen_gvec_ssadd)
+TRANS(vsadd_w, gvec_vvv, 16, MO_32, tcg_gen_gvec_ssadd)
+TRANS(vsadd_d, gvec_vvv, 16, MO_64, tcg_gen_gvec_ssadd)
+TRANS(vsadd_bu, gvec_vvv, 16, MO_8, tcg_gen_gvec_usadd)
+TRANS(vsadd_hu, gvec_vvv, 16, MO_16, tcg_gen_gvec_usadd)
+TRANS(vsadd_wu, gvec_vvv, 16, MO_32, tcg_gen_gvec_usadd)
+TRANS(vsadd_du, gvec_vvv, 16, MO_64, tcg_gen_gvec_usadd)
+TRANS(vssub_b, gvec_vvv, 16, MO_8, tcg_gen_gvec_sssub)
+TRANS(vssub_h, gvec_vvv, 16, MO_16, tcg_gen_gvec_sssub)
+TRANS(vssub_w, gvec_vvv, 16, MO_32, tcg_gen_gvec_sssub)
+TRANS(vssub_d, gvec_vvv, 16, MO_64, tcg_gen_gvec_sssub)
+TRANS(vssub_bu, gvec_vvv, 16, MO_8, tcg_gen_gvec_ussub)
+TRANS(vssub_hu, gvec_vvv, 16, MO_16, tcg_gen_gvec_ussub)
+TRANS(vssub_wu, gvec_vvv, 16, MO_32, tcg_gen_gvec_ussub)
+TRANS(vssub_du, gvec_vvv, 16, MO_64, tcg_gen_gvec_ussub)
 
 TRANS(vhaddw_h_b, gen_vvv, gen_helper_vhaddw_h_b)
 TRANS(vhaddw_w_h, gen_vvv, gen_helper_vhaddw_w_h)
@@ -301,10 +290,10 @@ static void do_vaddwev_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vaddwev_h_b, gvec_vvv, MO_8, do_vaddwev_s)
-TRANS(vaddwev_w_h, gvec_vvv, MO_16, do_vaddwev_s)
-TRANS(vaddwev_d_w, gvec_vvv, MO_32, do_vaddwev_s)
-TRANS(vaddwev_q_d, gvec_vvv, MO_64, do_vaddwev_s)
+TRANS(vaddwev_h_b, gvec_vvv, 16, MO_8, do_vaddwev_s)
+TRANS(vaddwev_w_h, gvec_vvv, 16, MO_16, do_vaddwev_s)
+TRANS(vaddwev_d_w, gvec_vvv, 16, MO_32, do_vaddwev_s)
+TRANS(vaddwev_q_d, gvec_vvv, 16, MO_64, do_vaddwev_s)
 
 static void gen_vaddwod_w_h(TCGv_i32 t, TCGv_i32 a, TCGv_i32 b)
 {
@@ -380,10 +369,10 @@ static void do_vaddwod_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vaddwod_h_b, gvec_vvv, MO_8, do_vaddwod_s)
-TRANS(vaddwod_w_h, gvec_vvv, MO_16, do_vaddwod_s)
-TRANS(vaddwod_d_w, gvec_vvv, MO_32, do_vaddwod_s)
-TRANS(vaddwod_q_d, gvec_vvv, MO_64, do_vaddwod_s)
+TRANS(vaddwod_h_b, gvec_vvv, 16, MO_8, do_vaddwod_s)
+TRANS(vaddwod_w_h, gvec_vvv, 16, MO_16, do_vaddwod_s)
+TRANS(vaddwod_d_w, gvec_vvv, 16, MO_32, do_vaddwod_s)
+TRANS(vaddwod_q_d, gvec_vvv, 16, MO_64, do_vaddwod_s)
 
 static void gen_vsubwev_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -463,10 +452,10 @@ static void do_vsubwev_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vsubwev_h_b, gvec_vvv, MO_8, do_vsubwev_s)
-TRANS(vsubwev_w_h, gvec_vvv, MO_16, do_vsubwev_s)
-TRANS(vsubwev_d_w, gvec_vvv, MO_32, do_vsubwev_s)
-TRANS(vsubwev_q_d, gvec_vvv, MO_64, do_vsubwev_s)
+TRANS(vsubwev_h_b, gvec_vvv, 16, MO_8, do_vsubwev_s)
+TRANS(vsubwev_w_h, gvec_vvv, 16, MO_16, do_vsubwev_s)
+TRANS(vsubwev_d_w, gvec_vvv, 16, MO_32, do_vsubwev_s)
+TRANS(vsubwev_q_d, gvec_vvv, 16, MO_64, do_vsubwev_s)
 
 static void gen_vsubwod_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -542,10 +531,10 @@ static void do_vsubwod_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vsubwod_h_b, gvec_vvv, MO_8, do_vsubwod_s)
-TRANS(vsubwod_w_h, gvec_vvv, MO_16, do_vsubwod_s)
-TRANS(vsubwod_d_w, gvec_vvv, MO_32, do_vsubwod_s)
-TRANS(vsubwod_q_d, gvec_vvv, MO_64, do_vsubwod_s)
+TRANS(vsubwod_h_b, gvec_vvv, 16, MO_8, do_vsubwod_s)
+TRANS(vsubwod_w_h, gvec_vvv, 16, MO_16, do_vsubwod_s)
+TRANS(vsubwod_d_w, gvec_vvv, 16, MO_32, do_vsubwod_s)
+TRANS(vsubwod_q_d, gvec_vvv, 16, MO_64, do_vsubwod_s)
 
 static void gen_vaddwev_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -617,10 +606,10 @@ static void do_vaddwev_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vaddwev_h_bu, gvec_vvv, MO_8, do_vaddwev_u)
-TRANS(vaddwev_w_hu, gvec_vvv, MO_16, do_vaddwev_u)
-TRANS(vaddwev_d_wu, gvec_vvv, MO_32, do_vaddwev_u)
-TRANS(vaddwev_q_du, gvec_vvv, MO_64, do_vaddwev_u)
+TRANS(vaddwev_h_bu, gvec_vvv, 16, MO_8, do_vaddwev_u)
+TRANS(vaddwev_w_hu, gvec_vvv, 16, MO_16, do_vaddwev_u)
+TRANS(vaddwev_d_wu, gvec_vvv, 16, MO_32, do_vaddwev_u)
+TRANS(vaddwev_q_du, gvec_vvv, 16, MO_64, do_vaddwev_u)
 
 static void gen_vaddwod_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -696,10 +685,10 @@ static void do_vaddwod_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vaddwod_h_bu, gvec_vvv, MO_8, do_vaddwod_u)
-TRANS(vaddwod_w_hu, gvec_vvv, MO_16, do_vaddwod_u)
-TRANS(vaddwod_d_wu, gvec_vvv, MO_32, do_vaddwod_u)
-TRANS(vaddwod_q_du, gvec_vvv, MO_64, do_vaddwod_u)
+TRANS(vaddwod_h_bu, gvec_vvv, 16, MO_8, do_vaddwod_u)
+TRANS(vaddwod_w_hu, gvec_vvv, 16, MO_16, do_vaddwod_u)
+TRANS(vaddwod_d_wu, gvec_vvv, 16, MO_32, do_vaddwod_u)
+TRANS(vaddwod_q_du, gvec_vvv, 16, MO_64, do_vaddwod_u)
 
 static void gen_vsubwev_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -771,10 +760,10 @@ static void do_vsubwev_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vsubwev_h_bu, gvec_vvv, MO_8, do_vsubwev_u)
-TRANS(vsubwev_w_hu, gvec_vvv, MO_16, do_vsubwev_u)
-TRANS(vsubwev_d_wu, gvec_vvv, MO_32, do_vsubwev_u)
-TRANS(vsubwev_q_du, gvec_vvv, MO_64, do_vsubwev_u)
+TRANS(vsubwev_h_bu, gvec_vvv, 16, MO_8, do_vsubwev_u)
+TRANS(vsubwev_w_hu, gvec_vvv, 16, MO_16, do_vsubwev_u)
+TRANS(vsubwev_d_wu, gvec_vvv, 16, MO_32, do_vsubwev_u)
+TRANS(vsubwev_q_du, gvec_vvv, 16, MO_64, do_vsubwev_u)
 
 static void gen_vsubwod_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -850,10 +839,10 @@ static void do_vsubwod_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vsubwod_h_bu, gvec_vvv, MO_8, do_vsubwod_u)
-TRANS(vsubwod_w_hu, gvec_vvv, MO_16, do_vsubwod_u)
-TRANS(vsubwod_d_wu, gvec_vvv, MO_32, do_vsubwod_u)
-TRANS(vsubwod_q_du, gvec_vvv, MO_64, do_vsubwod_u)
+TRANS(vsubwod_h_bu, gvec_vvv, 16, MO_8, do_vsubwod_u)
+TRANS(vsubwod_w_hu, gvec_vvv, 16, MO_16, do_vsubwod_u)
+TRANS(vsubwod_d_wu, gvec_vvv, 16, MO_32, do_vsubwod_u)
+TRANS(vsubwod_q_du, gvec_vvv, 16, MO_64, do_vsubwod_u)
 
 static void gen_vaddwev_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -933,10 +922,10 @@ static void do_vaddwev_u_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vaddwev_h_bu_b, gvec_vvv, MO_8, do_vaddwev_u_s)
-TRANS(vaddwev_w_hu_h, gvec_vvv, MO_16, do_vaddwev_u_s)
-TRANS(vaddwev_d_wu_w, gvec_vvv, MO_32, do_vaddwev_u_s)
-TRANS(vaddwev_q_du_d, gvec_vvv, MO_64, do_vaddwev_u_s)
+TRANS(vaddwev_h_bu_b, gvec_vvv, 16, MO_8, do_vaddwev_u_s)
+TRANS(vaddwev_w_hu_h, gvec_vvv, 16, MO_16, do_vaddwev_u_s)
+TRANS(vaddwev_d_wu_w, gvec_vvv, 16, MO_32, do_vaddwev_u_s)
+TRANS(vaddwev_q_du_d, gvec_vvv, 16, MO_64, do_vaddwev_u_s)
 
 static void gen_vaddwod_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -1013,10 +1002,10 @@ static void do_vaddwod_u_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vaddwod_h_bu_b, gvec_vvv, MO_8, do_vaddwod_u_s)
-TRANS(vaddwod_w_hu_h, gvec_vvv, MO_16, do_vaddwod_u_s)
-TRANS(vaddwod_d_wu_w, gvec_vvv, MO_32, do_vaddwod_u_s)
-TRANS(vaddwod_q_du_d, gvec_vvv, MO_64, do_vaddwod_u_s)
+TRANS(vaddwod_h_bu_b, gvec_vvv, 16, MO_8, do_vaddwod_u_s)
+TRANS(vaddwod_w_hu_h, gvec_vvv, 16, MO_16, do_vaddwod_u_s)
+TRANS(vaddwod_d_wu_w, gvec_vvv, 16, MO_32, do_vaddwod_u_s)
+TRANS(vaddwod_q_du_d, gvec_vvv, 16, MO_64, do_vaddwod_u_s)
 
 static void do_vavg(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b,
                     void (*gen_shr_vec)(unsigned, TCGv_vec,
@@ -1125,14 +1114,14 @@ static void do_vavg_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vavg_b, gvec_vvv, MO_8, do_vavg_s)
-TRANS(vavg_h, gvec_vvv, MO_16, do_vavg_s)
-TRANS(vavg_w, gvec_vvv, MO_32, do_vavg_s)
-TRANS(vavg_d, gvec_vvv, MO_64, do_vavg_s)
-TRANS(vavg_bu, gvec_vvv, MO_8, do_vavg_u)
-TRANS(vavg_hu, gvec_vvv, MO_16, do_vavg_u)
-TRANS(vavg_wu, gvec_vvv, MO_32, do_vavg_u)
-TRANS(vavg_du, gvec_vvv, MO_64, do_vavg_u)
+TRANS(vavg_b, gvec_vvv, 16, MO_8, do_vavg_s)
+TRANS(vavg_h, gvec_vvv, 16, MO_16, do_vavg_s)
+TRANS(vavg_w, gvec_vvv, 16, MO_32, do_vavg_s)
+TRANS(vavg_d, gvec_vvv, 16, MO_64, do_vavg_s)
+TRANS(vavg_bu, gvec_vvv, 16, MO_8, do_vavg_u)
+TRANS(vavg_hu, gvec_vvv, 16, MO_16, do_vavg_u)
+TRANS(vavg_wu, gvec_vvv, 16, MO_32, do_vavg_u)
+TRANS(vavg_du, gvec_vvv, 16, MO_64, do_vavg_u)
 
 static void do_vavgr_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
                        uint32_t vk_ofs, uint32_t oprsz, uint32_t maxsz)
@@ -1206,14 +1195,14 @@ static void do_vavgr_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vavgr_b, gvec_vvv, MO_8, do_vavgr_s)
-TRANS(vavgr_h, gvec_vvv, MO_16, do_vavgr_s)
-TRANS(vavgr_w, gvec_vvv, MO_32, do_vavgr_s)
-TRANS(vavgr_d, gvec_vvv, MO_64, do_vavgr_s)
-TRANS(vavgr_bu, gvec_vvv, MO_8, do_vavgr_u)
-TRANS(vavgr_hu, gvec_vvv, MO_16, do_vavgr_u)
-TRANS(vavgr_wu, gvec_vvv, MO_32, do_vavgr_u)
-TRANS(vavgr_du, gvec_vvv, MO_64, do_vavgr_u)
+TRANS(vavgr_b, gvec_vvv, 16, MO_8, do_vavgr_s)
+TRANS(vavgr_h, gvec_vvv, 16, MO_16, do_vavgr_s)
+TRANS(vavgr_w, gvec_vvv, 16, MO_32, do_vavgr_s)
+TRANS(vavgr_d, gvec_vvv, 16, MO_64, do_vavgr_s)
+TRANS(vavgr_bu, gvec_vvv, 16, MO_8, do_vavgr_u)
+TRANS(vavgr_hu, gvec_vvv, 16, MO_16, do_vavgr_u)
+TRANS(vavgr_wu, gvec_vvv, 16, MO_32, do_vavgr_u)
+TRANS(vavgr_du, gvec_vvv, 16, MO_64, do_vavgr_u)
 
 static void gen_vabsd_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -1301,14 +1290,14 @@ static void do_vabsd_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vabsd_b, gvec_vvv, MO_8, do_vabsd_s)
-TRANS(vabsd_h, gvec_vvv, MO_16, do_vabsd_s)
-TRANS(vabsd_w, gvec_vvv, MO_32, do_vabsd_s)
-TRANS(vabsd_d, gvec_vvv, MO_64, do_vabsd_s)
-TRANS(vabsd_bu, gvec_vvv, MO_8, do_vabsd_u)
-TRANS(vabsd_hu, gvec_vvv, MO_16, do_vabsd_u)
-TRANS(vabsd_wu, gvec_vvv, MO_32, do_vabsd_u)
-TRANS(vabsd_du, gvec_vvv, MO_64, do_vabsd_u)
+TRANS(vabsd_b, gvec_vvv, 16, MO_8, do_vabsd_s)
+TRANS(vabsd_h, gvec_vvv, 16, MO_16, do_vabsd_s)
+TRANS(vabsd_w, gvec_vvv, 16, MO_32, do_vabsd_s)
+TRANS(vabsd_d, gvec_vvv, 16, MO_64, do_vabsd_s)
+TRANS(vabsd_bu, gvec_vvv, 16, MO_8, do_vabsd_u)
+TRANS(vabsd_hu, gvec_vvv, 16, MO_16, do_vabsd_u)
+TRANS(vabsd_wu, gvec_vvv, 16, MO_32, do_vabsd_u)
+TRANS(vabsd_du, gvec_vvv, 16, MO_64, do_vabsd_u)
 
 static void gen_vadda(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -1358,28 +1347,28 @@ static void do_vadda(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vadda_b, gvec_vvv, MO_8, do_vadda)
-TRANS(vadda_h, gvec_vvv, MO_16, do_vadda)
-TRANS(vadda_w, gvec_vvv, MO_32, do_vadda)
-TRANS(vadda_d, gvec_vvv, MO_64, do_vadda)
-
-TRANS(vmax_b, gvec_vvv, MO_8, tcg_gen_gvec_smax)
-TRANS(vmax_h, gvec_vvv, MO_16, tcg_gen_gvec_smax)
-TRANS(vmax_w, gvec_vvv, MO_32, tcg_gen_gvec_smax)
-TRANS(vmax_d, gvec_vvv, MO_64, tcg_gen_gvec_smax)
-TRANS(vmax_bu, gvec_vvv, MO_8, tcg_gen_gvec_umax)
-TRANS(vmax_hu, gvec_vvv, MO_16, tcg_gen_gvec_umax)
-TRANS(vmax_wu, gvec_vvv, MO_32, tcg_gen_gvec_umax)
-TRANS(vmax_du, gvec_vvv, MO_64, tcg_gen_gvec_umax)
-
-TRANS(vmin_b, gvec_vvv, MO_8, tcg_gen_gvec_smin)
-TRANS(vmin_h, gvec_vvv, MO_16, tcg_gen_gvec_smin)
-TRANS(vmin_w, gvec_vvv, MO_32, tcg_gen_gvec_smin)
-TRANS(vmin_d, gvec_vvv, MO_64, tcg_gen_gvec_smin)
-TRANS(vmin_bu, gvec_vvv, MO_8, tcg_gen_gvec_umin)
-TRANS(vmin_hu, gvec_vvv, MO_16, tcg_gen_gvec_umin)
-TRANS(vmin_wu, gvec_vvv, MO_32, tcg_gen_gvec_umin)
-TRANS(vmin_du, gvec_vvv, MO_64, tcg_gen_gvec_umin)
+TRANS(vadda_b, gvec_vvv, 16, MO_8, do_vadda)
+TRANS(vadda_h, gvec_vvv, 16, MO_16, do_vadda)
+TRANS(vadda_w, gvec_vvv, 16, MO_32, do_vadda)
+TRANS(vadda_d, gvec_vvv, 16, MO_64, do_vadda)
+
+TRANS(vmax_b, gvec_vvv, 16, MO_8, tcg_gen_gvec_smax)
+TRANS(vmax_h, gvec_vvv, 16, MO_16, tcg_gen_gvec_smax)
+TRANS(vmax_w, gvec_vvv, 16, MO_32, tcg_gen_gvec_smax)
+TRANS(vmax_d, gvec_vvv, 16, MO_64, tcg_gen_gvec_smax)
+TRANS(vmax_bu, gvec_vvv, 16, MO_8, tcg_gen_gvec_umax)
+TRANS(vmax_hu, gvec_vvv, 16, MO_16, tcg_gen_gvec_umax)
+TRANS(vmax_wu, gvec_vvv, 16, MO_32, tcg_gen_gvec_umax)
+TRANS(vmax_du, gvec_vvv, 16, MO_64, tcg_gen_gvec_umax)
+
+TRANS(vmin_b, gvec_vvv, 16, MO_8, tcg_gen_gvec_smin)
+TRANS(vmin_h, gvec_vvv, 16, MO_16, tcg_gen_gvec_smin)
+TRANS(vmin_w, gvec_vvv, 16, MO_32, tcg_gen_gvec_smin)
+TRANS(vmin_d, gvec_vvv, 16, MO_64, tcg_gen_gvec_smin)
+TRANS(vmin_bu, gvec_vvv, 16, MO_8, tcg_gen_gvec_umin)
+TRANS(vmin_hu, gvec_vvv, 16, MO_16, tcg_gen_gvec_umin)
+TRANS(vmin_wu, gvec_vvv, 16, MO_32, tcg_gen_gvec_umin)
+TRANS(vmin_du, gvec_vvv, 16, MO_64, tcg_gen_gvec_umin)
 
 static void gen_vmini_s(unsigned vece, TCGv_vec t, TCGv_vec a, int64_t imm)
 {
@@ -1563,10 +1552,10 @@ TRANS(vmaxi_hu, gvec_vv_i, MO_16, do_vmaxi_u)
 TRANS(vmaxi_wu, gvec_vv_i, MO_32, do_vmaxi_u)
 TRANS(vmaxi_du, gvec_vv_i, MO_64, do_vmaxi_u)
 
-TRANS(vmul_b, gvec_vvv, MO_8, tcg_gen_gvec_mul)
-TRANS(vmul_h, gvec_vvv, MO_16, tcg_gen_gvec_mul)
-TRANS(vmul_w, gvec_vvv, MO_32, tcg_gen_gvec_mul)
-TRANS(vmul_d, gvec_vvv, MO_64, tcg_gen_gvec_mul)
+TRANS(vmul_b, gvec_vvv, 16, MO_8, tcg_gen_gvec_mul)
+TRANS(vmul_h, gvec_vvv, 16, MO_16, tcg_gen_gvec_mul)
+TRANS(vmul_w, gvec_vvv, 16, MO_32, tcg_gen_gvec_mul)
+TRANS(vmul_d, gvec_vvv, 16, MO_64, tcg_gen_gvec_mul)
 
 static void gen_vmuh_w(TCGv_i32 t, TCGv_i32 a, TCGv_i32 b)
 {
@@ -1607,10 +1596,10 @@ static void do_vmuh_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmuh_b, gvec_vvv, MO_8, do_vmuh_s)
-TRANS(vmuh_h, gvec_vvv, MO_16, do_vmuh_s)
-TRANS(vmuh_w, gvec_vvv, MO_32, do_vmuh_s)
-TRANS(vmuh_d, gvec_vvv, MO_64, do_vmuh_s)
+TRANS(vmuh_b, gvec_vvv, 16, MO_8, do_vmuh_s)
+TRANS(vmuh_h, gvec_vvv, 16, MO_16, do_vmuh_s)
+TRANS(vmuh_w, gvec_vvv, 16, MO_32, do_vmuh_s)
+TRANS(vmuh_d, gvec_vvv, 16, MO_64, do_vmuh_s)
 
 static void gen_vmuh_wu(TCGv_i32 t, TCGv_i32 a, TCGv_i32 b)
 {
@@ -1651,10 +1640,10 @@ static void do_vmuh_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmuh_bu, gvec_vvv, MO_8,  do_vmuh_u)
-TRANS(vmuh_hu, gvec_vvv, MO_16, do_vmuh_u)
-TRANS(vmuh_wu, gvec_vvv, MO_32, do_vmuh_u)
-TRANS(vmuh_du, gvec_vvv, MO_64, do_vmuh_u)
+TRANS(vmuh_bu, gvec_vvv, 16, MO_8,  do_vmuh_u)
+TRANS(vmuh_hu, gvec_vvv, 16, MO_16, do_vmuh_u)
+TRANS(vmuh_wu, gvec_vvv, 16, MO_32, do_vmuh_u)
+TRANS(vmuh_du, gvec_vvv, 16, MO_64, do_vmuh_u)
 
 static void gen_vmulwev_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -1724,9 +1713,9 @@ static void do_vmulwev_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmulwev_h_b, gvec_vvv, MO_8, do_vmulwev_s)
-TRANS(vmulwev_w_h, gvec_vvv, MO_16, do_vmulwev_s)
-TRANS(vmulwev_d_w, gvec_vvv, MO_32, do_vmulwev_s)
+TRANS(vmulwev_h_b, gvec_vvv, 16, MO_8, do_vmulwev_s)
+TRANS(vmulwev_w_h, gvec_vvv, 16, MO_16, do_vmulwev_s)
+TRANS(vmulwev_d_w, gvec_vvv, 16, MO_32, do_vmulwev_s)
 
 static void tcg_gen_mulus2_i64(TCGv_i64 rl, TCGv_i64 rh,
                                TCGv_i64 arg1, TCGv_i64 arg2)
@@ -1828,9 +1817,9 @@ static void do_vmulwod_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmulwod_h_b, gvec_vvv, MO_8, do_vmulwod_s)
-TRANS(vmulwod_w_h, gvec_vvv, MO_16, do_vmulwod_s)
-TRANS(vmulwod_d_w, gvec_vvv, MO_32, do_vmulwod_s)
+TRANS(vmulwod_h_b, gvec_vvv, 16, MO_8, do_vmulwod_s)
+TRANS(vmulwod_w_h, gvec_vvv, 16, MO_16, do_vmulwod_s)
+TRANS(vmulwod_d_w, gvec_vvv, 16, MO_32, do_vmulwod_s)
 
 static void gen_vmulwev_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -1898,9 +1887,9 @@ static void do_vmulwev_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmulwev_h_bu, gvec_vvv, MO_8, do_vmulwev_u)
-TRANS(vmulwev_w_hu, gvec_vvv, MO_16, do_vmulwev_u)
-TRANS(vmulwev_d_wu, gvec_vvv, MO_32, do_vmulwev_u)
+TRANS(vmulwev_h_bu, gvec_vvv, 16, MO_8, do_vmulwev_u)
+TRANS(vmulwev_w_hu, gvec_vvv, 16, MO_16, do_vmulwev_u)
+TRANS(vmulwev_d_wu, gvec_vvv, 16, MO_32, do_vmulwev_u)
 
 static void gen_vmulwod_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -1968,9 +1957,9 @@ static void do_vmulwod_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmulwod_h_bu, gvec_vvv, MO_8, do_vmulwod_u)
-TRANS(vmulwod_w_hu, gvec_vvv, MO_16, do_vmulwod_u)
-TRANS(vmulwod_d_wu, gvec_vvv, MO_32, do_vmulwod_u)
+TRANS(vmulwod_h_bu, gvec_vvv, 16, MO_8, do_vmulwod_u)
+TRANS(vmulwod_w_hu, gvec_vvv, 16, MO_16, do_vmulwod_u)
+TRANS(vmulwod_d_wu, gvec_vvv, 16, MO_32, do_vmulwod_u)
 
 static void gen_vmulwev_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2040,9 +2029,9 @@ static void do_vmulwev_u_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmulwev_h_bu_b, gvec_vvv, MO_8, do_vmulwev_u_s)
-TRANS(vmulwev_w_hu_h, gvec_vvv, MO_16, do_vmulwev_u_s)
-TRANS(vmulwev_d_wu_w, gvec_vvv, MO_32, do_vmulwev_u_s)
+TRANS(vmulwev_h_bu_b, gvec_vvv, 16, MO_8, do_vmulwev_u_s)
+TRANS(vmulwev_w_hu_h, gvec_vvv, 16, MO_16, do_vmulwev_u_s)
+TRANS(vmulwev_d_wu_w, gvec_vvv, 16, MO_32, do_vmulwev_u_s)
 
 static void gen_vmulwod_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2109,9 +2098,9 @@ static void do_vmulwod_u_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmulwod_h_bu_b, gvec_vvv, MO_8, do_vmulwod_u_s)
-TRANS(vmulwod_w_hu_h, gvec_vvv, MO_16, do_vmulwod_u_s)
-TRANS(vmulwod_d_wu_w, gvec_vvv, MO_32, do_vmulwod_u_s)
+TRANS(vmulwod_h_bu_b, gvec_vvv, 16, MO_8, do_vmulwod_u_s)
+TRANS(vmulwod_w_hu_h, gvec_vvv, 16, MO_16, do_vmulwod_u_s)
+TRANS(vmulwod_d_wu_w, gvec_vvv, 16, MO_32, do_vmulwod_u_s)
 
 static void gen_vmadd(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2182,10 +2171,10 @@ static void do_vmadd(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmadd_b, gvec_vvv, MO_8, do_vmadd)
-TRANS(vmadd_h, gvec_vvv, MO_16, do_vmadd)
-TRANS(vmadd_w, gvec_vvv, MO_32, do_vmadd)
-TRANS(vmadd_d, gvec_vvv, MO_64, do_vmadd)
+TRANS(vmadd_b, gvec_vvv, 16, MO_8, do_vmadd)
+TRANS(vmadd_h, gvec_vvv, 16, MO_16, do_vmadd)
+TRANS(vmadd_w, gvec_vvv, 16, MO_32, do_vmadd)
+TRANS(vmadd_d, gvec_vvv, 16, MO_64, do_vmadd)
 
 static void gen_vmsub(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2256,10 +2245,10 @@ static void do_vmsub(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmsub_b, gvec_vvv, MO_8, do_vmsub)
-TRANS(vmsub_h, gvec_vvv, MO_16, do_vmsub)
-TRANS(vmsub_w, gvec_vvv, MO_32, do_vmsub)
-TRANS(vmsub_d, gvec_vvv, MO_64, do_vmsub)
+TRANS(vmsub_b, gvec_vvv, 16, MO_8, do_vmsub)
+TRANS(vmsub_h, gvec_vvv, 16, MO_16, do_vmsub)
+TRANS(vmsub_w, gvec_vvv, 16, MO_32, do_vmsub)
+TRANS(vmsub_d, gvec_vvv, 16, MO_64, do_vmsub)
 
 static void gen_vmaddwev_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2331,9 +2320,9 @@ static void do_vmaddwev_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmaddwev_h_b, gvec_vvv, MO_8, do_vmaddwev_s)
-TRANS(vmaddwev_w_h, gvec_vvv, MO_16, do_vmaddwev_s)
-TRANS(vmaddwev_d_w, gvec_vvv, MO_32, do_vmaddwev_s)
+TRANS(vmaddwev_h_b, gvec_vvv, 16, MO_8, do_vmaddwev_s)
+TRANS(vmaddwev_w_h, gvec_vvv, 16, MO_16, do_vmaddwev_s)
+TRANS(vmaddwev_d_w, gvec_vvv, 16, MO_32, do_vmaddwev_s)
 
 #define VMADD_Q(NAME, FN, idx1, idx2)                     \
 static bool trans_## NAME (DisasContext *ctx, arg_vvv *a) \
@@ -2435,9 +2424,9 @@ static void do_vmaddwod_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmaddwod_h_b, gvec_vvv, MO_8, do_vmaddwod_s)
-TRANS(vmaddwod_w_h, gvec_vvv, MO_16, do_vmaddwod_s)
-TRANS(vmaddwod_d_w, gvec_vvv, MO_32, do_vmaddwod_s)
+TRANS(vmaddwod_h_b, gvec_vvv, 16, MO_8, do_vmaddwod_s)
+TRANS(vmaddwod_w_h, gvec_vvv, 16, MO_16, do_vmaddwod_s)
+TRANS(vmaddwod_d_w, gvec_vvv, 16, MO_32, do_vmaddwod_s)
 
 static void gen_vmaddwev_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2505,9 +2494,9 @@ static void do_vmaddwev_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmaddwev_h_bu, gvec_vvv, MO_8, do_vmaddwev_u)
-TRANS(vmaddwev_w_hu, gvec_vvv, MO_16, do_vmaddwev_u)
-TRANS(vmaddwev_d_wu, gvec_vvv, MO_32, do_vmaddwev_u)
+TRANS(vmaddwev_h_bu, gvec_vvv, 16, MO_8, do_vmaddwev_u)
+TRANS(vmaddwev_w_hu, gvec_vvv, 16, MO_16, do_vmaddwev_u)
+TRANS(vmaddwev_d_wu, gvec_vvv, 16, MO_32, do_vmaddwev_u)
 
 static void gen_vmaddwod_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2576,9 +2565,9 @@ static void do_vmaddwod_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmaddwod_h_bu, gvec_vvv, MO_8, do_vmaddwod_u)
-TRANS(vmaddwod_w_hu, gvec_vvv, MO_16, do_vmaddwod_u)
-TRANS(vmaddwod_d_wu, gvec_vvv, MO_32, do_vmaddwod_u)
+TRANS(vmaddwod_h_bu, gvec_vvv, 16, MO_8, do_vmaddwod_u)
+TRANS(vmaddwod_w_hu, gvec_vvv, 16, MO_16, do_vmaddwod_u)
+TRANS(vmaddwod_d_wu, gvec_vvv, 16, MO_32, do_vmaddwod_u)
 
 static void gen_vmaddwev_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2649,9 +2638,9 @@ static void do_vmaddwev_u_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmaddwev_h_bu_b, gvec_vvv, MO_8, do_vmaddwev_u_s)
-TRANS(vmaddwev_w_hu_h, gvec_vvv, MO_16, do_vmaddwev_u_s)
-TRANS(vmaddwev_d_wu_w, gvec_vvv, MO_32, do_vmaddwev_u_s)
+TRANS(vmaddwev_h_bu_b, gvec_vvv, 16, MO_8, do_vmaddwev_u_s)
+TRANS(vmaddwev_w_hu_h, gvec_vvv, 16, MO_16, do_vmaddwev_u_s)
+TRANS(vmaddwev_d_wu_w, gvec_vvv, 16, MO_32, do_vmaddwev_u_s)
 
 static void gen_vmaddwod_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2721,9 +2710,9 @@ static void do_vmaddwod_u_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmaddwod_h_bu_b, gvec_vvv, MO_8, do_vmaddwod_u_s)
-TRANS(vmaddwod_w_hu_h, gvec_vvv, MO_16, do_vmaddwod_u_s)
-TRANS(vmaddwod_d_wu_w, gvec_vvv, MO_32, do_vmaddwod_u_s)
+TRANS(vmaddwod_h_bu_b, gvec_vvv, 16, MO_8, do_vmaddwod_u_s)
+TRANS(vmaddwod_w_hu_h, gvec_vvv, 16, MO_16, do_vmaddwod_u_s)
+TRANS(vmaddwod_d_wu_w, gvec_vvv, 16, MO_32, do_vmaddwod_u_s)
 
 TRANS(vdiv_b, gen_vvv, gen_helper_vdiv_b)
 TRANS(vdiv_h, gen_vvv, gen_helper_vdiv_h)
@@ -2900,10 +2889,10 @@ static void do_vsigncov(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vsigncov_b, gvec_vvv, MO_8, do_vsigncov)
-TRANS(vsigncov_h, gvec_vvv, MO_16, do_vsigncov)
-TRANS(vsigncov_w, gvec_vvv, MO_32, do_vsigncov)
-TRANS(vsigncov_d, gvec_vvv, MO_64, do_vsigncov)
+TRANS(vsigncov_b, gvec_vvv, 16, MO_8, do_vsigncov)
+TRANS(vsigncov_h, gvec_vvv, 16, MO_16, do_vsigncov)
+TRANS(vsigncov_w, gvec_vvv, 16, MO_32, do_vsigncov)
+TRANS(vsigncov_d, gvec_vvv, 16, MO_64, do_vsigncov)
 
 TRANS(vmskltz_b, gen_vv, gen_helper_vmskltz_b)
 TRANS(vmskltz_h, gen_vv, gen_helper_vmskltz_h)
@@ -3032,7 +3021,7 @@ static bool trans_vldi(DisasContext *ctx, arg_vldi *a)
 {
     int sel, vece;
     uint64_t value;
-    CHECK_SXE;
+    CHECK_VEC;
 
     sel = (a->imm >> 12) & 0x1;
 
@@ -3049,16 +3038,16 @@ static bool trans_vldi(DisasContext *ctx, arg_vldi *a)
     return true;
 }
 
-TRANS(vand_v, gvec_vvv, MO_64, tcg_gen_gvec_and)
-TRANS(vor_v, gvec_vvv, MO_64, tcg_gen_gvec_or)
-TRANS(vxor_v, gvec_vvv, MO_64, tcg_gen_gvec_xor)
-TRANS(vnor_v, gvec_vvv, MO_64, tcg_gen_gvec_nor)
+TRANS(vand_v, gvec_vvv, 16, MO_64, tcg_gen_gvec_and)
+TRANS(vor_v, gvec_vvv, 16, MO_64, tcg_gen_gvec_or)
+TRANS(vxor_v, gvec_vvv, 16, MO_64, tcg_gen_gvec_xor)
+TRANS(vnor_v, gvec_vvv, 16, MO_64, tcg_gen_gvec_nor)
 
 static bool trans_vandn_v(DisasContext *ctx, arg_vvv *a)
 {
     uint32_t vd_ofs, vj_ofs, vk_ofs;
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     vd_ofs = vec_full_offset(a->vd);
     vj_ofs = vec_full_offset(a->vj);
@@ -3067,7 +3056,7 @@ static bool trans_vandn_v(DisasContext *ctx, arg_vvv *a)
     tcg_gen_gvec_andc(MO_64, vd_ofs, vk_ofs, vj_ofs, 16, ctx->vl/8);
     return true;
 }
-TRANS(vorn_v, gvec_vvv, MO_64, tcg_gen_gvec_orc)
+TRANS(vorn_v, gvec_vvv, 16, MO_64, tcg_gen_gvec_orc)
 TRANS(vandi_b, gvec_vv_i, MO_8, tcg_gen_gvec_andi)
 TRANS(vori_b, gvec_vv_i, MO_8, tcg_gen_gvec_ori)
 TRANS(vxori_b, gvec_vv_i, MO_8, tcg_gen_gvec_xori)
@@ -3105,37 +3094,37 @@ static void do_vnori_b(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
 
 TRANS(vnori_b, gvec_vv_i, MO_8, do_vnori_b)
 
-TRANS(vsll_b, gvec_vvv, MO_8, tcg_gen_gvec_shlv)
-TRANS(vsll_h, gvec_vvv, MO_16, tcg_gen_gvec_shlv)
-TRANS(vsll_w, gvec_vvv, MO_32, tcg_gen_gvec_shlv)
-TRANS(vsll_d, gvec_vvv, MO_64, tcg_gen_gvec_shlv)
+TRANS(vsll_b, gvec_vvv, 16, MO_8, tcg_gen_gvec_shlv)
+TRANS(vsll_h, gvec_vvv, 16, MO_16, tcg_gen_gvec_shlv)
+TRANS(vsll_w, gvec_vvv, 16, MO_32, tcg_gen_gvec_shlv)
+TRANS(vsll_d, gvec_vvv, 16, MO_64, tcg_gen_gvec_shlv)
 TRANS(vslli_b, gvec_vv_i, MO_8, tcg_gen_gvec_shli)
 TRANS(vslli_h, gvec_vv_i, MO_16, tcg_gen_gvec_shli)
 TRANS(vslli_w, gvec_vv_i, MO_32, tcg_gen_gvec_shli)
 TRANS(vslli_d, gvec_vv_i, MO_64, tcg_gen_gvec_shli)
 
-TRANS(vsrl_b, gvec_vvv, MO_8, tcg_gen_gvec_shrv)
-TRANS(vsrl_h, gvec_vvv, MO_16, tcg_gen_gvec_shrv)
-TRANS(vsrl_w, gvec_vvv, MO_32, tcg_gen_gvec_shrv)
-TRANS(vsrl_d, gvec_vvv, MO_64, tcg_gen_gvec_shrv)
+TRANS(vsrl_b, gvec_vvv, 16, MO_8, tcg_gen_gvec_shrv)
+TRANS(vsrl_h, gvec_vvv, 16, MO_16, tcg_gen_gvec_shrv)
+TRANS(vsrl_w, gvec_vvv, 16, MO_32, tcg_gen_gvec_shrv)
+TRANS(vsrl_d, gvec_vvv, 16, MO_64, tcg_gen_gvec_shrv)
 TRANS(vsrli_b, gvec_vv_i, MO_8, tcg_gen_gvec_shri)
 TRANS(vsrli_h, gvec_vv_i, MO_16, tcg_gen_gvec_shri)
 TRANS(vsrli_w, gvec_vv_i, MO_32, tcg_gen_gvec_shri)
 TRANS(vsrli_d, gvec_vv_i, MO_64, tcg_gen_gvec_shri)
 
-TRANS(vsra_b, gvec_vvv, MO_8, tcg_gen_gvec_sarv)
-TRANS(vsra_h, gvec_vvv, MO_16, tcg_gen_gvec_sarv)
-TRANS(vsra_w, gvec_vvv, MO_32, tcg_gen_gvec_sarv)
-TRANS(vsra_d, gvec_vvv, MO_64, tcg_gen_gvec_sarv)
+TRANS(vsra_b, gvec_vvv, 16, MO_8, tcg_gen_gvec_sarv)
+TRANS(vsra_h, gvec_vvv, 16, MO_16, tcg_gen_gvec_sarv)
+TRANS(vsra_w, gvec_vvv, 16, MO_32, tcg_gen_gvec_sarv)
+TRANS(vsra_d, gvec_vvv, 16, MO_64, tcg_gen_gvec_sarv)
 TRANS(vsrai_b, gvec_vv_i, MO_8, tcg_gen_gvec_sari)
 TRANS(vsrai_h, gvec_vv_i, MO_16, tcg_gen_gvec_sari)
 TRANS(vsrai_w, gvec_vv_i, MO_32, tcg_gen_gvec_sari)
 TRANS(vsrai_d, gvec_vv_i, MO_64, tcg_gen_gvec_sari)
 
-TRANS(vrotr_b, gvec_vvv, MO_8, tcg_gen_gvec_rotrv)
-TRANS(vrotr_h, gvec_vvv, MO_16, tcg_gen_gvec_rotrv)
-TRANS(vrotr_w, gvec_vvv, MO_32, tcg_gen_gvec_rotrv)
-TRANS(vrotr_d, gvec_vvv, MO_64, tcg_gen_gvec_rotrv)
+TRANS(vrotr_b, gvec_vvv, 16, MO_8, tcg_gen_gvec_rotrv)
+TRANS(vrotr_h, gvec_vvv, 16, MO_16, tcg_gen_gvec_rotrv)
+TRANS(vrotr_w, gvec_vvv, 16, MO_32, tcg_gen_gvec_rotrv)
+TRANS(vrotr_d, gvec_vvv, 16, MO_64, tcg_gen_gvec_rotrv)
 TRANS(vrotri_b, gvec_vv_i, MO_8, tcg_gen_gvec_rotri)
 TRANS(vrotri_h, gvec_vv_i, MO_16, tcg_gen_gvec_rotri)
 TRANS(vrotri_w, gvec_vv_i, MO_32, tcg_gen_gvec_rotri)
@@ -3340,10 +3329,10 @@ static void do_vbitclr(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vbitclr_b, gvec_vvv, MO_8, do_vbitclr)
-TRANS(vbitclr_h, gvec_vvv, MO_16, do_vbitclr)
-TRANS(vbitclr_w, gvec_vvv, MO_32, do_vbitclr)
-TRANS(vbitclr_d, gvec_vvv, MO_64, do_vbitclr)
+TRANS(vbitclr_b, gvec_vvv, 16, MO_8, do_vbitclr)
+TRANS(vbitclr_h, gvec_vvv, 16, MO_16, do_vbitclr)
+TRANS(vbitclr_w, gvec_vvv, 16, MO_32, do_vbitclr)
+TRANS(vbitclr_d, gvec_vvv, 16, MO_64, do_vbitclr)
 
 static void do_vbiti(unsigned vece, TCGv_vec t, TCGv_vec a, int64_t imm,
                      void (*func)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec))
@@ -3451,10 +3440,10 @@ static void do_vbitset(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vbitset_b, gvec_vvv, MO_8, do_vbitset)
-TRANS(vbitset_h, gvec_vvv, MO_16, do_vbitset)
-TRANS(vbitset_w, gvec_vvv, MO_32, do_vbitset)
-TRANS(vbitset_d, gvec_vvv, MO_64, do_vbitset)
+TRANS(vbitset_b, gvec_vvv, 16, MO_8, do_vbitset)
+TRANS(vbitset_h, gvec_vvv, 16, MO_16, do_vbitset)
+TRANS(vbitset_w, gvec_vvv, 16, MO_32, do_vbitset)
+TRANS(vbitset_d, gvec_vvv, 16, MO_64, do_vbitset)
 
 static void do_vbitseti(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
                         int64_t imm, uint32_t oprsz, uint32_t maxsz)
@@ -3533,10 +3522,10 @@ static void do_vbitrev(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vbitrev_b, gvec_vvv, MO_8, do_vbitrev)
-TRANS(vbitrev_h, gvec_vvv, MO_16, do_vbitrev)
-TRANS(vbitrev_w, gvec_vvv, MO_32, do_vbitrev)
-TRANS(vbitrev_d, gvec_vvv, MO_64, do_vbitrev)
+TRANS(vbitrev_b, gvec_vvv, 16, MO_8, do_vbitrev)
+TRANS(vbitrev_h, gvec_vvv, 16, MO_16, do_vbitrev)
+TRANS(vbitrev_w, gvec_vvv, 16, MO_32, do_vbitrev)
+TRANS(vbitrev_d, gvec_vvv, 16, MO_64, do_vbitrev)
 
 static void do_vbitrevi(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
                         int64_t imm, uint32_t oprsz, uint32_t maxsz)
@@ -3685,7 +3674,7 @@ static bool do_cmp(DisasContext *ctx, arg_vvv *a, MemOp mop, TCGCond cond)
 {
     uint32_t vd_ofs, vj_ofs, vk_ofs;
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     vd_ofs = vec_full_offset(a->vd);
     vj_ofs = vec_full_offset(a->vj);
@@ -3731,7 +3720,7 @@ static bool do_## NAME ##_s(DisasContext *ctx, arg_vv_i *a, MemOp mop) \
 {                                                                      \
     uint32_t vd_ofs, vj_ofs;                                           \
                                                                        \
-    CHECK_SXE;                                                         \
+    CHECK_VEC;                                                         \
                                                                        \
     static const TCGOpcode vecop_list[] = {                            \
         INDEX_op_cmp_vec, 0                                            \
@@ -3780,7 +3769,7 @@ static bool do_## NAME ##_u(DisasContext *ctx, arg_vv_i *a, MemOp mop) \
 {                                                                      \
     uint32_t vd_ofs, vj_ofs;                                           \
                                                                        \
-    CHECK_SXE;                                                         \
+    CHECK_VEC;                                                         \
                                                                        \
     static const TCGOpcode vecop_list[] = {                            \
         INDEX_op_cmp_vec, 0                                            \
@@ -3874,7 +3863,7 @@ static bool trans_vfcmp_cond_s(DisasContext *ctx, arg_vvv_fcond *a)
     TCGv_i32 vj = tcg_constant_i32(a->vj);
     TCGv_i32 vk = tcg_constant_i32(a->vk);
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     fn = (a->fcond & 1 ? gen_helper_vfcmp_s_s : gen_helper_vfcmp_c_s);
     flags = get_fcmp_flags(a->fcond >> 1);
@@ -3900,7 +3889,7 @@ static bool trans_vfcmp_cond_d(DisasContext *ctx, arg_vvv_fcond *a)
 
 static bool trans_vbitsel_v(DisasContext *ctx, arg_vvvv *a)
 {
-    CHECK_SXE;
+    CHECK_VEC;
 
     tcg_gen_gvec_bitsel(MO_64, vec_full_offset(a->vd), vec_full_offset(a->va),
                         vec_full_offset(a->vk), vec_full_offset(a->vj),
@@ -3922,7 +3911,7 @@ static bool trans_vbitseli_b(DisasContext *ctx, arg_vv_i *a)
        .load_dest = true
     };
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     tcg_gen_gvec_2i(vec_full_offset(a->vd), vec_full_offset(a->vj),
                     16, ctx->vl/8, a->imm, &op);
@@ -3941,7 +3930,7 @@ static bool trans_## NAME (DisasContext *ctx, arg_cv *a)                       \
     get_vreg64(ah, a->vj, 1);                                                  \
     get_vreg64(al, a->vj, 0);                                                  \
                                                                                \
-    CHECK_SXE;                                                                 \
+    CHECK_VEC;                                                                 \
     tcg_gen_or_i64(t1, al, ah);                                                \
     tcg_gen_setcondi_i64(COND, t1, t1, 0);                                     \
     tcg_gen_st8_tl(t1, cpu_env, offsetof(CPULoongArchState, cf[a->cd & 0x7])); \
@@ -3964,7 +3953,7 @@ TRANS(vsetallnez_d, gen_cv, gen_helper_vsetallnez_d)
 static bool trans_vinsgr2vr_b(DisasContext *ctx, arg_vr_i *a)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_st8_i64(src, cpu_env,
                     offsetof(CPULoongArchState, fpr[a->vd].vreg.B(a->imm)));
     return true;
@@ -3973,7 +3962,7 @@ static bool trans_vinsgr2vr_b(DisasContext *ctx, arg_vr_i *a)
 static bool trans_vinsgr2vr_h(DisasContext *ctx, arg_vr_i *a)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_st16_i64(src, cpu_env,
                     offsetof(CPULoongArchState, fpr[a->vd].vreg.H(a->imm)));
     return true;
@@ -3982,7 +3971,7 @@ static bool trans_vinsgr2vr_h(DisasContext *ctx, arg_vr_i *a)
 static bool trans_vinsgr2vr_w(DisasContext *ctx, arg_vr_i *a)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_st32_i64(src, cpu_env,
                      offsetof(CPULoongArchState, fpr[a->vd].vreg.W(a->imm)));
     return true;
@@ -3991,7 +3980,7 @@ static bool trans_vinsgr2vr_w(DisasContext *ctx, arg_vr_i *a)
 static bool trans_vinsgr2vr_d(DisasContext *ctx, arg_vr_i *a)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_st_i64(src, cpu_env,
                    offsetof(CPULoongArchState, fpr[a->vd].vreg.D(a->imm)));
     return true;
@@ -4000,7 +3989,7 @@ static bool trans_vinsgr2vr_d(DisasContext *ctx, arg_vr_i *a)
 static bool trans_vpickve2gr_b(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_ld8s_i64(dst, cpu_env,
                      offsetof(CPULoongArchState, fpr[a->vj].vreg.B(a->imm)));
     return true;
@@ -4009,7 +3998,7 @@ static bool trans_vpickve2gr_b(DisasContext *ctx, arg_rv_i *a)
 static bool trans_vpickve2gr_h(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_ld16s_i64(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.H(a->imm)));
     return true;
@@ -4018,7 +4007,7 @@ static bool trans_vpickve2gr_h(DisasContext *ctx, arg_rv_i *a)
 static bool trans_vpickve2gr_w(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_ld32s_i64(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.W(a->imm)));
     return true;
@@ -4027,7 +4016,7 @@ static bool trans_vpickve2gr_w(DisasContext *ctx, arg_rv_i *a)
 static bool trans_vpickve2gr_d(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_ld_i64(dst, cpu_env,
                    offsetof(CPULoongArchState, fpr[a->vj].vreg.D(a->imm)));
     return true;
@@ -4036,7 +4025,7 @@ static bool trans_vpickve2gr_d(DisasContext *ctx, arg_rv_i *a)
 static bool trans_vpickve2gr_bu(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_ld8u_i64(dst, cpu_env,
                      offsetof(CPULoongArchState, fpr[a->vj].vreg.B(a->imm)));
     return true;
@@ -4045,7 +4034,7 @@ static bool trans_vpickve2gr_bu(DisasContext *ctx, arg_rv_i *a)
 static bool trans_vpickve2gr_hu(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_ld16u_i64(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.H(a->imm)));
     return true;
@@ -4054,7 +4043,7 @@ static bool trans_vpickve2gr_hu(DisasContext *ctx, arg_rv_i *a)
 static bool trans_vpickve2gr_wu(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_ld32u_i64(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.W(a->imm)));
     return true;
@@ -4063,7 +4052,7 @@ static bool trans_vpickve2gr_wu(DisasContext *ctx, arg_rv_i *a)
 static bool trans_vpickve2gr_du(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_ld_i64(dst, cpu_env,
                    offsetof(CPULoongArchState, fpr[a->vj].vreg.D(a->imm)));
     return true;
@@ -4072,7 +4061,7 @@ static bool trans_vpickve2gr_du(DisasContext *ctx, arg_rv_i *a)
 static bool gvec_dup(DisasContext *ctx, arg_vr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
-    CHECK_SXE;
+    CHECK_VEC;
 
     tcg_gen_gvec_dup_i64(mop, vec_full_offset(a->vd),
                          16, ctx->vl/8, src);
@@ -4086,7 +4075,7 @@ TRANS(vreplgr2vr_d, gvec_dup, MO_64)
 
 static bool trans_vreplvei_b(DisasContext *ctx, arg_vv_i *a)
 {
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_gvec_dup_mem(MO_8,vec_full_offset(a->vd),
                          offsetof(CPULoongArchState,
                                   fpr[a->vj].vreg.B((a->imm))),
@@ -4096,7 +4085,7 @@ static bool trans_vreplvei_b(DisasContext *ctx, arg_vv_i *a)
 
 static bool trans_vreplvei_h(DisasContext *ctx, arg_vv_i *a)
 {
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_gvec_dup_mem(MO_16, vec_full_offset(a->vd),
                          offsetof(CPULoongArchState,
                                   fpr[a->vj].vreg.H((a->imm))),
@@ -4105,7 +4094,7 @@ static bool trans_vreplvei_h(DisasContext *ctx, arg_vv_i *a)
 }
 static bool trans_vreplvei_w(DisasContext *ctx, arg_vv_i *a)
 {
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_gvec_dup_mem(MO_32, vec_full_offset(a->vd),
                          offsetof(CPULoongArchState,
                                   fpr[a->vj].vreg.W((a->imm))),
@@ -4114,7 +4103,7 @@ static bool trans_vreplvei_w(DisasContext *ctx, arg_vv_i *a)
 }
 static bool trans_vreplvei_d(DisasContext *ctx, arg_vv_i *a)
 {
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_gvec_dup_mem(MO_64, vec_full_offset(a->vd),
                          offsetof(CPULoongArchState,
                                   fpr[a->vj].vreg.D((a->imm))),
@@ -4129,7 +4118,7 @@ static bool gen_vreplve(DisasContext *ctx, arg_vvr *a, int vece, int bit,
     TCGv_ptr t1 = tcg_temp_new_ptr();
     TCGv_i64 t2 = tcg_temp_new_i64();
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     tcg_gen_andi_i64(t0, gpr_src(ctx, a->rk, EXT_NONE), (LSX_LEN/bit) -1);
     tcg_gen_shli_i64(t0, t0, vece);
@@ -4155,7 +4144,7 @@ static bool trans_vbsll_v(DisasContext *ctx, arg_vv_i *a)
     int ofs;
     TCGv_i64 desthigh, destlow, high, low;
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     desthigh = tcg_temp_new_i64();
     destlow = tcg_temp_new_i64();
@@ -4185,7 +4174,7 @@ static bool trans_vbsrl_v(DisasContext *ctx, arg_vv_i *a)
     TCGv_i64 desthigh, destlow, high, low;
     int ofs;
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     desthigh = tcg_temp_new_i64();
     destlow = tcg_temp_new_i64();
@@ -4259,7 +4248,7 @@ static bool trans_vld(DisasContext *ctx, arg_vr_i *a)
     TCGv_i64 rl, rh;
     TCGv_i128 val;
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     addr = gpr_src(ctx, a->rj, EXT_NONE);
     val = tcg_temp_new_i128();
@@ -4286,7 +4275,7 @@ static bool trans_vst(DisasContext *ctx, arg_vr_i *a)
     TCGv_i128 val;
     TCGv_i64 ah, al;
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     addr = gpr_src(ctx, a->rj, EXT_NONE);
     val = tcg_temp_new_i128();
@@ -4313,7 +4302,7 @@ static bool trans_vldx(DisasContext *ctx, arg_vrr *a)
     TCGv_i64 rl, rh;
     TCGv_i128 val;
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     addr = tcg_temp_new();
     src1 = gpr_src(ctx, a->rj, EXT_NONE);
@@ -4337,7 +4326,7 @@ static bool trans_vstx(DisasContext *ctx, arg_vrr *a)
     TCGv_i64 ah, al;
     TCGv_i128 val;
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     addr = tcg_temp_new();
     src1 = gpr_src(ctx, a->rj, EXT_NONE);
@@ -4361,7 +4350,7 @@ static bool trans_## NAME (DisasContext *ctx, arg_vr_i *a)                \
     TCGv addr, temp;                                                      \
     TCGv_i64 val;                                                         \
                                                                           \
-    CHECK_SXE;                                                            \
+    CHECK_VEC;                                                            \
                                                                           \
     addr = gpr_src(ctx, a->rj, EXT_NONE);                                 \
     val = tcg_temp_new_i64();                                             \
@@ -4389,7 +4378,7 @@ static bool trans_## NAME (DisasContext *ctx, arg_vr_ii *a)                  \
     TCGv addr, temp;                                                         \
     TCGv_i64 val;                                                            \
                                                                              \
-    CHECK_SXE;                                                               \
+    CHECK_VEC;                                                               \
                                                                              \
     addr = gpr_src(ctx, a->rj, EXT_NONE);                                    \
     val = tcg_temp_new_i64();                                                \
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index c9c3bc2c73..bcc18fb6c5 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1296,3 +1296,17 @@ vstelm_d         0011 00010001 0 . ........ ..... .....   @vr_i8i1
 vstelm_w         0011 00010010 .. ........ ..... .....    @vr_i8i2
 vstelm_h         0011 0001010 ... ........ ..... .....    @vr_i8i3
 vstelm_b         0011 000110 .... ........ ..... .....    @vr_i8i4
+
+#
+# LoongArch LASX instructions
+#
+xvadd_b          0111 01000000 10100 ..... ..... .....    @vvv
+xvadd_h          0111 01000000 10101 ..... ..... .....    @vvv
+xvadd_w          0111 01000000 10110 ..... ..... .....    @vvv
+xvadd_d          0111 01000000 10111 ..... ..... .....    @vvv
+xvadd_q          0111 01010010 11010 ..... ..... .....    @vvv
+xvsub_b          0111 01000000 11000 ..... ..... .....    @vvv
+xvsub_h          0111 01000000 11001 ..... ..... .....    @vvv
+xvsub_w          0111 01000000 11010 ..... ..... .....    @vvv
+xvsub_d          0111 01000000 11011 ..... ..... .....    @vvv
+xvsub_q          0111 01010010 11011 ..... ..... .....    @vvv
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index 6bf2d726d6..c46222c9e9 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -18,6 +18,7 @@
 #include "fpu/softfloat.h"
 #include "translate.h"
 #include "internals.h"
+#include "vec.h"
 
 /* Global register indices */
 TCGv cpu_gpr[32], cpu_pc;
@@ -119,6 +120,10 @@ static void loongarch_tr_init_disas_context(DisasContextBase *dcbase,
         ctx->vl = LSX_LEN;
     }
 
+    if (FIELD_EX64(env->cpucfg[2], CPUCFG2, LASX)) {
+        ctx->vl = LASX_LEN;
+    }
+
     ctx->zero = tcg_constant_tl(0);
 }
 
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index 655192a6ac..f032aee327 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -8,6 +8,23 @@
 #ifndef LOONGARCH_VEC_H
 #define LOONGARCH_VEC_H
 
+#ifndef CONFIG_USER_ONLY
+ #define CHECK_VEC do { \
+     if ((ctx->vl == LSX_LEN) && \
+         (ctx->base.tb->flags & HW_FLAGS_EUEN_SXE) == 0) { \
+         generate_exception(ctx, EXCCODE_SXD); \
+         return true; \
+     } \
+     if ((ctx->vl == LASX_LEN) && \
+         (ctx->base.tb->flags & HW_FLAGS_EUEN_ASXE) == 0) { \
+         generate_exception(ctx, EXCCODE_ASXD); \
+         return true; \
+     } \
+ } while (0)
+#else
+ #define CHECK_VEC
+#endif /*!CONFIG_USER_ONLY */
+
 #if HOST_BIG_ENDIAN
 #define B(x)  B[(x) ^ 15]
 #define H(x)  H[(x) ^ 7]
-- 
2.39.1


