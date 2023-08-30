Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4980778D451
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 10:52:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbGtC-0000D6-7D; Wed, 30 Aug 2023 04:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qbGt9-00008A-OF
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:49:23 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qbGt2-0007TE-Jb
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:49:23 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxV_GFAu9kZwgdAA--.59814S3;
 Wed, 30 Aug 2023 16:49:09 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxF81+Au9kHhxnAA--.49766S7; 
 Wed, 30 Aug 2023 16:49:09 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v4 05/48] target/loongarch: Implement xvadd/xvsub
Date: Wed, 30 Aug 2023 16:48:19 +0800
Message-Id: <20230830084902.2113960-6-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230830084902.2113960-1-gaosong@loongson.cn>
References: <20230830084902.2113960-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxF81+Au9kHhxnAA--.49766S7
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
- XVADD.{B/H/W/D/Q};
- XVSUB.{B/H/W/D/Q}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/vec.h                       |  17 +
 target/loongarch/insns.decode                |  14 +
 target/loongarch/disas.c                     |  23 +
 target/loongarch/translate.c                 |   4 +
 target/loongarch/insn_trans/trans_lasx.c.inc |  56 +-
 target/loongarch/insn_trans/trans_lsx.c.inc  | 513 +++++++++----------
 6 files changed, 355 insertions(+), 272 deletions(-)

diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index 2f23cae7d7..512f2fd83f 100644
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
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index 1f91afee81..36039dfeef 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -18,6 +18,7 @@
 #include "fpu/softfloat.h"
 #include "translate.h"
 #include "internals.h"
+#include "vec.h"
 
 /* Global register indices */
 TCGv cpu_gpr[32], cpu_pc;
@@ -122,6 +123,9 @@ static void loongarch_tr_init_disas_context(DisasContextBase *dcbase,
     if (FIELD_EX64(env->cpucfg[2], CPUCFG2, LSX)) {
         ctx->vl = LSX_LEN;
     }
+    if (FIELD_EX64(env->cpucfg[2], CPUCFG2, LASX)) {
+        ctx->vl = LASX_LEN;
+    }
 
     ctx->la64 = is_la64(env);
     ctx->va32 = (ctx->base.tb->flags & HW_FLAGS_VA32) != 0;
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 75a77f5dce..218b8dc648 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -4,13 +4,49 @@
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
+TRANS(xvadd_b, LASX, gvec_vvv, 32, MO_8, tcg_gen_gvec_add)
+TRANS(xvadd_h, LASX, gvec_vvv, 32, MO_16, tcg_gen_gvec_add)
+TRANS(xvadd_w, LASX, gvec_vvv, 32, MO_32, tcg_gen_gvec_add)
+TRANS(xvadd_d, LASX, gvec_vvv, 32, MO_64, tcg_gen_gvec_add)
+
+#define XVADDSUB_Q(NAME)                                         \
+static bool trans_xv## NAME ##_q(DisasContext *ctx, arg_vvv * a) \
+{                                                                \
+    TCGv_i64 rh, rl, ah, al, bh, bl;                             \
+    int i;                                                       \
+                                                                 \
+    if (!avail_LASX(ctx)) {                                      \
+        return false;                                            \
+    }                                                            \
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
+TRANS(xvsub_b, LASX, gvec_vvv, 32, MO_8, tcg_gen_gvec_sub)
+TRANS(xvsub_h, LASX, gvec_vvv, 32, MO_16, tcg_gen_gvec_sub)
+TRANS(xvsub_w, LASX, gvec_vvv, 32, MO_32, tcg_gen_gvec_sub)
+TRANS(xvsub_d, LASX, gvec_vvv, 32, MO_64, tcg_gen_gvec_sub)
diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index 5fbf2718f7..0e12213e8b 100644
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
@@ -135,10 +124,10 @@ static bool gvec_subi(DisasContext *ctx, arg_vv_i *a, MemOp mop)
     return true;
 }
 
-TRANS(vadd_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_add)
-TRANS(vadd_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_add)
-TRANS(vadd_w, LSX, gvec_vvv, MO_32, tcg_gen_gvec_add)
-TRANS(vadd_d, LSX, gvec_vvv, MO_64, tcg_gen_gvec_add)
+TRANS(vadd_b, LSX, gvec_vvv, 16, MO_8, tcg_gen_gvec_add)
+TRANS(vadd_h, LSX, gvec_vvv, 16, MO_16, tcg_gen_gvec_add)
+TRANS(vadd_w, LSX, gvec_vvv, 16, MO_32, tcg_gen_gvec_add)
+TRANS(vadd_d, LSX, gvec_vvv, 16, MO_64, tcg_gen_gvec_add)
 
 #define VADDSUB_Q(NAME)                                        \
 static bool trans_v## NAME ##_q(DisasContext *ctx, arg_vvv *a) \
@@ -149,7 +138,7 @@ static bool trans_v## NAME ##_q(DisasContext *ctx, arg_vvv *a) \
         return false;                                          \
     }                                                          \
                                                                \
-    CHECK_SXE;                                                 \
+    CHECK_VEC;                                                 \
                                                                \
     rh = tcg_temp_new_i64();                                   \
     rl = tcg_temp_new_i64();                                   \
@@ -174,10 +163,10 @@ static bool trans_v## NAME ##_q(DisasContext *ctx, arg_vvv *a) \
 VADDSUB_Q(add)
 VADDSUB_Q(sub)
 
-TRANS(vsub_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_sub)
-TRANS(vsub_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_sub)
-TRANS(vsub_w, LSX, gvec_vvv, MO_32, tcg_gen_gvec_sub)
-TRANS(vsub_d, LSX, gvec_vvv, MO_64, tcg_gen_gvec_sub)
+TRANS(vsub_b, LSX, gvec_vvv, 16, MO_8, tcg_gen_gvec_sub)
+TRANS(vsub_h, LSX, gvec_vvv, 16, MO_16, tcg_gen_gvec_sub)
+TRANS(vsub_w, LSX, gvec_vvv, 16, MO_32, tcg_gen_gvec_sub)
+TRANS(vsub_d, LSX, gvec_vvv, 16, MO_64, tcg_gen_gvec_sub)
 
 TRANS(vaddi_bu, LSX, gvec_vv_i, MO_8, tcg_gen_gvec_addi)
 TRANS(vaddi_hu, LSX, gvec_vv_i, MO_16, tcg_gen_gvec_addi)
@@ -193,22 +182,22 @@ TRANS(vneg_h, LSX, gvec_vv, MO_16, tcg_gen_gvec_neg)
 TRANS(vneg_w, LSX, gvec_vv, MO_32, tcg_gen_gvec_neg)
 TRANS(vneg_d, LSX, gvec_vv, MO_64, tcg_gen_gvec_neg)
 
-TRANS(vsadd_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_ssadd)
-TRANS(vsadd_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_ssadd)
-TRANS(vsadd_w, LSX, gvec_vvv, MO_32, tcg_gen_gvec_ssadd)
-TRANS(vsadd_d, LSX, gvec_vvv, MO_64, tcg_gen_gvec_ssadd)
-TRANS(vsadd_bu, LSX, gvec_vvv, MO_8, tcg_gen_gvec_usadd)
-TRANS(vsadd_hu, LSX, gvec_vvv, MO_16, tcg_gen_gvec_usadd)
-TRANS(vsadd_wu, LSX, gvec_vvv, MO_32, tcg_gen_gvec_usadd)
-TRANS(vsadd_du, LSX, gvec_vvv, MO_64, tcg_gen_gvec_usadd)
-TRANS(vssub_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_sssub)
-TRANS(vssub_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_sssub)
-TRANS(vssub_w, LSX, gvec_vvv, MO_32, tcg_gen_gvec_sssub)
-TRANS(vssub_d, LSX, gvec_vvv, MO_64, tcg_gen_gvec_sssub)
-TRANS(vssub_bu, LSX, gvec_vvv, MO_8, tcg_gen_gvec_ussub)
-TRANS(vssub_hu, LSX, gvec_vvv, MO_16, tcg_gen_gvec_ussub)
-TRANS(vssub_wu, LSX, gvec_vvv, MO_32, tcg_gen_gvec_ussub)
-TRANS(vssub_du, LSX, gvec_vvv, MO_64, tcg_gen_gvec_ussub)
+TRANS(vsadd_b, LSX, gvec_vvv, 16, MO_8, tcg_gen_gvec_ssadd)
+TRANS(vsadd_h, LSX, gvec_vvv, 16, MO_16, tcg_gen_gvec_ssadd)
+TRANS(vsadd_w, LSX, gvec_vvv, 16, MO_32, tcg_gen_gvec_ssadd)
+TRANS(vsadd_d, LSX, gvec_vvv, 16, MO_64, tcg_gen_gvec_ssadd)
+TRANS(vsadd_bu, LSX, gvec_vvv, 16, MO_8, tcg_gen_gvec_usadd)
+TRANS(vsadd_hu, LSX, gvec_vvv, 16, MO_16, tcg_gen_gvec_usadd)
+TRANS(vsadd_wu, LSX, gvec_vvv, 16, MO_32, tcg_gen_gvec_usadd)
+TRANS(vsadd_du, LSX, gvec_vvv, 16, MO_64, tcg_gen_gvec_usadd)
+TRANS(vssub_b, LSX, gvec_vvv, 16, MO_8, tcg_gen_gvec_sssub)
+TRANS(vssub_h, LSX, gvec_vvv, 16, MO_16, tcg_gen_gvec_sssub)
+TRANS(vssub_w, LSX, gvec_vvv, 16, MO_32, tcg_gen_gvec_sssub)
+TRANS(vssub_d, LSX, gvec_vvv, 16, MO_64, tcg_gen_gvec_sssub)
+TRANS(vssub_bu, LSX, gvec_vvv, 16, MO_8, tcg_gen_gvec_ussub)
+TRANS(vssub_hu, LSX, gvec_vvv, 16, MO_16, tcg_gen_gvec_ussub)
+TRANS(vssub_wu, LSX, gvec_vvv, 16, MO_32, tcg_gen_gvec_ussub)
+TRANS(vssub_du, LSX, gvec_vvv, 16, MO_64, tcg_gen_gvec_ussub)
 
 TRANS(vhaddw_h_b, LSX, gen_vvv, gen_helper_vhaddw_h_b)
 TRANS(vhaddw_w_h, LSX, gen_vvv, gen_helper_vhaddw_w_h)
@@ -305,10 +294,10 @@ static void do_vaddwev_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vaddwev_h_b, LSX, gvec_vvv, MO_8, do_vaddwev_s)
-TRANS(vaddwev_w_h, LSX, gvec_vvv, MO_16, do_vaddwev_s)
-TRANS(vaddwev_d_w, LSX, gvec_vvv, MO_32, do_vaddwev_s)
-TRANS(vaddwev_q_d, LSX, gvec_vvv, MO_64, do_vaddwev_s)
+TRANS(vaddwev_h_b, LSX, gvec_vvv, 16, MO_8, do_vaddwev_s)
+TRANS(vaddwev_w_h, LSX, gvec_vvv, 16, MO_16, do_vaddwev_s)
+TRANS(vaddwev_d_w, LSX, gvec_vvv, 16, MO_32, do_vaddwev_s)
+TRANS(vaddwev_q_d, LSX, gvec_vvv, 16, MO_64, do_vaddwev_s)
 
 static void gen_vaddwod_w_h(TCGv_i32 t, TCGv_i32 a, TCGv_i32 b)
 {
@@ -384,10 +373,10 @@ static void do_vaddwod_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vaddwod_h_b, LSX, gvec_vvv, MO_8, do_vaddwod_s)
-TRANS(vaddwod_w_h, LSX, gvec_vvv, MO_16, do_vaddwod_s)
-TRANS(vaddwod_d_w, LSX, gvec_vvv, MO_32, do_vaddwod_s)
-TRANS(vaddwod_q_d, LSX, gvec_vvv, MO_64, do_vaddwod_s)
+TRANS(vaddwod_h_b, LSX, gvec_vvv, 16, MO_8, do_vaddwod_s)
+TRANS(vaddwod_w_h, LSX, gvec_vvv, 16, MO_16, do_vaddwod_s)
+TRANS(vaddwod_d_w, LSX, gvec_vvv, 16, MO_32, do_vaddwod_s)
+TRANS(vaddwod_q_d, LSX, gvec_vvv, 16, MO_64, do_vaddwod_s)
 
 static void gen_vsubwev_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -467,10 +456,10 @@ static void do_vsubwev_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vsubwev_h_b, LSX, gvec_vvv, MO_8, do_vsubwev_s)
-TRANS(vsubwev_w_h, LSX, gvec_vvv, MO_16, do_vsubwev_s)
-TRANS(vsubwev_d_w, LSX, gvec_vvv, MO_32, do_vsubwev_s)
-TRANS(vsubwev_q_d, LSX, gvec_vvv, MO_64, do_vsubwev_s)
+TRANS(vsubwev_h_b, LSX, gvec_vvv, 16, MO_8, do_vsubwev_s)
+TRANS(vsubwev_w_h, LSX, gvec_vvv, 16, MO_16, do_vsubwev_s)
+TRANS(vsubwev_d_w, LSX, gvec_vvv, 16, MO_32, do_vsubwev_s)
+TRANS(vsubwev_q_d, LSX, gvec_vvv, 16, MO_64, do_vsubwev_s)
 
 static void gen_vsubwod_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -546,10 +535,10 @@ static void do_vsubwod_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vsubwod_h_b, LSX, gvec_vvv, MO_8, do_vsubwod_s)
-TRANS(vsubwod_w_h, LSX, gvec_vvv, MO_16, do_vsubwod_s)
-TRANS(vsubwod_d_w, LSX, gvec_vvv, MO_32, do_vsubwod_s)
-TRANS(vsubwod_q_d, LSX, gvec_vvv, MO_64, do_vsubwod_s)
+TRANS(vsubwod_h_b, LSX, gvec_vvv, 16, MO_8, do_vsubwod_s)
+TRANS(vsubwod_w_h, LSX, gvec_vvv, 16, MO_16, do_vsubwod_s)
+TRANS(vsubwod_d_w, LSX, gvec_vvv, 16, MO_32, do_vsubwod_s)
+TRANS(vsubwod_q_d, LSX, gvec_vvv, 16, MO_64, do_vsubwod_s)
 
 static void gen_vaddwev_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -621,10 +610,10 @@ static void do_vaddwev_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vaddwev_h_bu, LSX, gvec_vvv, MO_8, do_vaddwev_u)
-TRANS(vaddwev_w_hu, LSX, gvec_vvv, MO_16, do_vaddwev_u)
-TRANS(vaddwev_d_wu, LSX, gvec_vvv, MO_32, do_vaddwev_u)
-TRANS(vaddwev_q_du, LSX, gvec_vvv, MO_64, do_vaddwev_u)
+TRANS(vaddwev_h_bu, LSX, gvec_vvv, 16, MO_8, do_vaddwev_u)
+TRANS(vaddwev_w_hu, LSX, gvec_vvv, 16, MO_16, do_vaddwev_u)
+TRANS(vaddwev_d_wu, LSX, gvec_vvv, 16, MO_32, do_vaddwev_u)
+TRANS(vaddwev_q_du, LSX, gvec_vvv, 16, MO_64, do_vaddwev_u)
 
 static void gen_vaddwod_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -700,10 +689,10 @@ static void do_vaddwod_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vaddwod_h_bu, LSX, gvec_vvv, MO_8, do_vaddwod_u)
-TRANS(vaddwod_w_hu, LSX, gvec_vvv, MO_16, do_vaddwod_u)
-TRANS(vaddwod_d_wu, LSX, gvec_vvv, MO_32, do_vaddwod_u)
-TRANS(vaddwod_q_du, LSX, gvec_vvv, MO_64, do_vaddwod_u)
+TRANS(vaddwod_h_bu, LSX, gvec_vvv, 16, MO_8, do_vaddwod_u)
+TRANS(vaddwod_w_hu, LSX, gvec_vvv, 16, MO_16, do_vaddwod_u)
+TRANS(vaddwod_d_wu, LSX, gvec_vvv, 16, MO_32, do_vaddwod_u)
+TRANS(vaddwod_q_du, LSX, gvec_vvv, 16, MO_64, do_vaddwod_u)
 
 static void gen_vsubwev_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -775,10 +764,10 @@ static void do_vsubwev_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vsubwev_h_bu, LSX, gvec_vvv, MO_8, do_vsubwev_u)
-TRANS(vsubwev_w_hu, LSX, gvec_vvv, MO_16, do_vsubwev_u)
-TRANS(vsubwev_d_wu, LSX, gvec_vvv, MO_32, do_vsubwev_u)
-TRANS(vsubwev_q_du, LSX, gvec_vvv, MO_64, do_vsubwev_u)
+TRANS(vsubwev_h_bu, LSX, gvec_vvv, 16, MO_8, do_vsubwev_u)
+TRANS(vsubwev_w_hu, LSX, gvec_vvv, 16, MO_16, do_vsubwev_u)
+TRANS(vsubwev_d_wu, LSX, gvec_vvv, 16, MO_32, do_vsubwev_u)
+TRANS(vsubwev_q_du, LSX, gvec_vvv, 16, MO_64, do_vsubwev_u)
 
 static void gen_vsubwod_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -854,10 +843,10 @@ static void do_vsubwod_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vsubwod_h_bu, LSX, gvec_vvv, MO_8, do_vsubwod_u)
-TRANS(vsubwod_w_hu, LSX, gvec_vvv, MO_16, do_vsubwod_u)
-TRANS(vsubwod_d_wu, LSX, gvec_vvv, MO_32, do_vsubwod_u)
-TRANS(vsubwod_q_du, LSX, gvec_vvv, MO_64, do_vsubwod_u)
+TRANS(vsubwod_h_bu, LSX, gvec_vvv, 16, MO_8, do_vsubwod_u)
+TRANS(vsubwod_w_hu, LSX, gvec_vvv, 16, MO_16, do_vsubwod_u)
+TRANS(vsubwod_d_wu, LSX, gvec_vvv, 16, MO_32, do_vsubwod_u)
+TRANS(vsubwod_q_du, LSX, gvec_vvv, 16, MO_64, do_vsubwod_u)
 
 static void gen_vaddwev_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -937,10 +926,10 @@ static void do_vaddwev_u_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vaddwev_h_bu_b, LSX, gvec_vvv, MO_8, do_vaddwev_u_s)
-TRANS(vaddwev_w_hu_h, LSX, gvec_vvv, MO_16, do_vaddwev_u_s)
-TRANS(vaddwev_d_wu_w, LSX, gvec_vvv, MO_32, do_vaddwev_u_s)
-TRANS(vaddwev_q_du_d, LSX, gvec_vvv, MO_64, do_vaddwev_u_s)
+TRANS(vaddwev_h_bu_b, LSX, gvec_vvv, 16, MO_8, do_vaddwev_u_s)
+TRANS(vaddwev_w_hu_h, LSX, gvec_vvv, 16, MO_16, do_vaddwev_u_s)
+TRANS(vaddwev_d_wu_w, LSX, gvec_vvv, 16, MO_32, do_vaddwev_u_s)
+TRANS(vaddwev_q_du_d, LSX, gvec_vvv, 16, MO_64, do_vaddwev_u_s)
 
 static void gen_vaddwod_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -1017,10 +1006,10 @@ static void do_vaddwod_u_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vaddwod_h_bu_b, LSX, gvec_vvv, MO_8, do_vaddwod_u_s)
-TRANS(vaddwod_w_hu_h, LSX, gvec_vvv, MO_16, do_vaddwod_u_s)
-TRANS(vaddwod_d_wu_w, LSX, gvec_vvv, MO_32, do_vaddwod_u_s)
-TRANS(vaddwod_q_du_d, LSX, gvec_vvv, MO_64, do_vaddwod_u_s)
+TRANS(vaddwod_h_bu_b, LSX, gvec_vvv, 16, MO_8, do_vaddwod_u_s)
+TRANS(vaddwod_w_hu_h, LSX, gvec_vvv, 16, MO_16, do_vaddwod_u_s)
+TRANS(vaddwod_d_wu_w, LSX, gvec_vvv, 16, MO_32, do_vaddwod_u_s)
+TRANS(vaddwod_q_du_d, LSX, gvec_vvv, 16, MO_64, do_vaddwod_u_s)
 
 static void do_vavg(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b,
                     void (*gen_shr_vec)(unsigned, TCGv_vec,
@@ -1129,14 +1118,14 @@ static void do_vavg_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vavg_b, LSX, gvec_vvv, MO_8, do_vavg_s)
-TRANS(vavg_h, LSX, gvec_vvv, MO_16, do_vavg_s)
-TRANS(vavg_w, LSX, gvec_vvv, MO_32, do_vavg_s)
-TRANS(vavg_d, LSX, gvec_vvv, MO_64, do_vavg_s)
-TRANS(vavg_bu, LSX, gvec_vvv, MO_8, do_vavg_u)
-TRANS(vavg_hu, LSX, gvec_vvv, MO_16, do_vavg_u)
-TRANS(vavg_wu, LSX, gvec_vvv, MO_32, do_vavg_u)
-TRANS(vavg_du, LSX, gvec_vvv, MO_64, do_vavg_u)
+TRANS(vavg_b, LSX, gvec_vvv, 16, MO_8, do_vavg_s)
+TRANS(vavg_h, LSX, gvec_vvv, 16, MO_16, do_vavg_s)
+TRANS(vavg_w, LSX, gvec_vvv, 16, MO_32, do_vavg_s)
+TRANS(vavg_d, LSX, gvec_vvv, 16, MO_64, do_vavg_s)
+TRANS(vavg_bu, LSX, gvec_vvv, 16, MO_8, do_vavg_u)
+TRANS(vavg_hu, LSX, gvec_vvv, 16, MO_16, do_vavg_u)
+TRANS(vavg_wu, LSX, gvec_vvv, 16, MO_32, do_vavg_u)
+TRANS(vavg_du, LSX, gvec_vvv, 16, MO_64, do_vavg_u)
 
 static void do_vavgr_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
                        uint32_t vk_ofs, uint32_t oprsz, uint32_t maxsz)
@@ -1210,14 +1199,14 @@ static void do_vavgr_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vavgr_b, LSX, gvec_vvv, MO_8, do_vavgr_s)
-TRANS(vavgr_h, LSX, gvec_vvv, MO_16, do_vavgr_s)
-TRANS(vavgr_w, LSX, gvec_vvv, MO_32, do_vavgr_s)
-TRANS(vavgr_d, LSX, gvec_vvv, MO_64, do_vavgr_s)
-TRANS(vavgr_bu, LSX, gvec_vvv, MO_8, do_vavgr_u)
-TRANS(vavgr_hu, LSX, gvec_vvv, MO_16, do_vavgr_u)
-TRANS(vavgr_wu, LSX, gvec_vvv, MO_32, do_vavgr_u)
-TRANS(vavgr_du, LSX, gvec_vvv, MO_64, do_vavgr_u)
+TRANS(vavgr_b, LSX, gvec_vvv, 16, MO_8, do_vavgr_s)
+TRANS(vavgr_h, LSX, gvec_vvv, 16, MO_16, do_vavgr_s)
+TRANS(vavgr_w, LSX, gvec_vvv, 16, MO_32, do_vavgr_s)
+TRANS(vavgr_d, LSX, gvec_vvv, 16, MO_64, do_vavgr_s)
+TRANS(vavgr_bu, LSX, gvec_vvv, 16, MO_8, do_vavgr_u)
+TRANS(vavgr_hu, LSX, gvec_vvv, 16, MO_16, do_vavgr_u)
+TRANS(vavgr_wu, LSX, gvec_vvv, 16, MO_32, do_vavgr_u)
+TRANS(vavgr_du, LSX, gvec_vvv, 16, MO_64, do_vavgr_u)
 
 static void gen_vabsd_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -1305,14 +1294,14 @@ static void do_vabsd_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vabsd_b, LSX, gvec_vvv, MO_8, do_vabsd_s)
-TRANS(vabsd_h, LSX, gvec_vvv, MO_16, do_vabsd_s)
-TRANS(vabsd_w, LSX, gvec_vvv, MO_32, do_vabsd_s)
-TRANS(vabsd_d, LSX, gvec_vvv, MO_64, do_vabsd_s)
-TRANS(vabsd_bu, LSX, gvec_vvv, MO_8, do_vabsd_u)
-TRANS(vabsd_hu, LSX, gvec_vvv, MO_16, do_vabsd_u)
-TRANS(vabsd_wu, LSX, gvec_vvv, MO_32, do_vabsd_u)
-TRANS(vabsd_du, LSX, gvec_vvv, MO_64, do_vabsd_u)
+TRANS(vabsd_b, LSX, gvec_vvv, 16, MO_8, do_vabsd_s)
+TRANS(vabsd_h, LSX, gvec_vvv, 16, MO_16, do_vabsd_s)
+TRANS(vabsd_w, LSX, gvec_vvv, 16, MO_32, do_vabsd_s)
+TRANS(vabsd_d, LSX, gvec_vvv, 16, MO_64, do_vabsd_s)
+TRANS(vabsd_bu, LSX, gvec_vvv, 16, MO_8, do_vabsd_u)
+TRANS(vabsd_hu, LSX, gvec_vvv, 16, MO_16, do_vabsd_u)
+TRANS(vabsd_wu, LSX, gvec_vvv, 16, MO_32, do_vabsd_u)
+TRANS(vabsd_du, LSX, gvec_vvv, 16, MO_64, do_vabsd_u)
 
 static void gen_vadda(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -1362,28 +1351,28 @@ static void do_vadda(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vadda_b, LSX, gvec_vvv, MO_8, do_vadda)
-TRANS(vadda_h, LSX, gvec_vvv, MO_16, do_vadda)
-TRANS(vadda_w, LSX, gvec_vvv, MO_32, do_vadda)
-TRANS(vadda_d, LSX, gvec_vvv, MO_64, do_vadda)
-
-TRANS(vmax_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_smax)
-TRANS(vmax_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_smax)
-TRANS(vmax_w, LSX, gvec_vvv, MO_32, tcg_gen_gvec_smax)
-TRANS(vmax_d, LSX, gvec_vvv, MO_64, tcg_gen_gvec_smax)
-TRANS(vmax_bu, LSX, gvec_vvv, MO_8, tcg_gen_gvec_umax)
-TRANS(vmax_hu, LSX, gvec_vvv, MO_16, tcg_gen_gvec_umax)
-TRANS(vmax_wu, LSX, gvec_vvv, MO_32, tcg_gen_gvec_umax)
-TRANS(vmax_du, LSX, gvec_vvv, MO_64, tcg_gen_gvec_umax)
-
-TRANS(vmin_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_smin)
-TRANS(vmin_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_smin)
-TRANS(vmin_w, LSX, gvec_vvv, MO_32, tcg_gen_gvec_smin)
-TRANS(vmin_d, LSX, gvec_vvv, MO_64, tcg_gen_gvec_smin)
-TRANS(vmin_bu, LSX, gvec_vvv, MO_8, tcg_gen_gvec_umin)
-TRANS(vmin_hu, LSX, gvec_vvv, MO_16, tcg_gen_gvec_umin)
-TRANS(vmin_wu, LSX, gvec_vvv, MO_32, tcg_gen_gvec_umin)
-TRANS(vmin_du, LSX, gvec_vvv, MO_64, tcg_gen_gvec_umin)
+TRANS(vadda_b, LSX, gvec_vvv, 16, MO_8, do_vadda)
+TRANS(vadda_h, LSX, gvec_vvv, 16, MO_16, do_vadda)
+TRANS(vadda_w, LSX, gvec_vvv, 16, MO_32, do_vadda)
+TRANS(vadda_d, LSX, gvec_vvv, 16, MO_64, do_vadda)
+
+TRANS(vmax_b, LSX, gvec_vvv, 16, MO_8, tcg_gen_gvec_smax)
+TRANS(vmax_h, LSX, gvec_vvv, 16, MO_16, tcg_gen_gvec_smax)
+TRANS(vmax_w, LSX, gvec_vvv, 16, MO_32, tcg_gen_gvec_smax)
+TRANS(vmax_d, LSX, gvec_vvv, 16, MO_64, tcg_gen_gvec_smax)
+TRANS(vmax_bu, LSX, gvec_vvv, 16, MO_8, tcg_gen_gvec_umax)
+TRANS(vmax_hu, LSX, gvec_vvv, 16, MO_16, tcg_gen_gvec_umax)
+TRANS(vmax_wu, LSX, gvec_vvv, 16, MO_32, tcg_gen_gvec_umax)
+TRANS(vmax_du, LSX, gvec_vvv, 16, MO_64, tcg_gen_gvec_umax)
+
+TRANS(vmin_b, LSX, gvec_vvv, 16, MO_8, tcg_gen_gvec_smin)
+TRANS(vmin_h, LSX, gvec_vvv, 16, MO_16, tcg_gen_gvec_smin)
+TRANS(vmin_w, LSX, gvec_vvv, 16, MO_32, tcg_gen_gvec_smin)
+TRANS(vmin_d, LSX, gvec_vvv, 16, MO_64, tcg_gen_gvec_smin)
+TRANS(vmin_bu, LSX, gvec_vvv, 16, MO_8, tcg_gen_gvec_umin)
+TRANS(vmin_hu, LSX, gvec_vvv, 16, MO_16, tcg_gen_gvec_umin)
+TRANS(vmin_wu, LSX, gvec_vvv, 16, MO_32, tcg_gen_gvec_umin)
+TRANS(vmin_du, LSX, gvec_vvv, 16, MO_64, tcg_gen_gvec_umin)
 
 static void gen_vmini_s(unsigned vece, TCGv_vec t, TCGv_vec a, int64_t imm)
 {
@@ -1567,10 +1556,10 @@ TRANS(vmaxi_hu, LSX, gvec_vv_i, MO_16, do_vmaxi_u)
 TRANS(vmaxi_wu, LSX, gvec_vv_i, MO_32, do_vmaxi_u)
 TRANS(vmaxi_du, LSX, gvec_vv_i, MO_64, do_vmaxi_u)
 
-TRANS(vmul_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_mul)
-TRANS(vmul_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_mul)
-TRANS(vmul_w, LSX, gvec_vvv, MO_32, tcg_gen_gvec_mul)
-TRANS(vmul_d, LSX, gvec_vvv, MO_64, tcg_gen_gvec_mul)
+TRANS(vmul_b, LSX, gvec_vvv, 16, MO_8, tcg_gen_gvec_mul)
+TRANS(vmul_h, LSX, gvec_vvv, 16, MO_16, tcg_gen_gvec_mul)
+TRANS(vmul_w, LSX, gvec_vvv, 16, MO_32, tcg_gen_gvec_mul)
+TRANS(vmul_d, LSX, gvec_vvv, 16, MO_64, tcg_gen_gvec_mul)
 
 static void gen_vmuh_w(TCGv_i32 t, TCGv_i32 a, TCGv_i32 b)
 {
@@ -1611,10 +1600,10 @@ static void do_vmuh_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmuh_b, LSX, gvec_vvv, MO_8, do_vmuh_s)
-TRANS(vmuh_h, LSX, gvec_vvv, MO_16, do_vmuh_s)
-TRANS(vmuh_w, LSX, gvec_vvv, MO_32, do_vmuh_s)
-TRANS(vmuh_d, LSX, gvec_vvv, MO_64, do_vmuh_s)
+TRANS(vmuh_b, LSX, gvec_vvv, 16, MO_8, do_vmuh_s)
+TRANS(vmuh_h, LSX, gvec_vvv, 16, MO_16, do_vmuh_s)
+TRANS(vmuh_w, LSX, gvec_vvv, 16, MO_32, do_vmuh_s)
+TRANS(vmuh_d, LSX, gvec_vvv, 16, MO_64, do_vmuh_s)
 
 static void gen_vmuh_wu(TCGv_i32 t, TCGv_i32 a, TCGv_i32 b)
 {
@@ -1655,10 +1644,10 @@ static void do_vmuh_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmuh_bu, LSX, gvec_vvv, MO_8,  do_vmuh_u)
-TRANS(vmuh_hu, LSX, gvec_vvv, MO_16, do_vmuh_u)
-TRANS(vmuh_wu, LSX, gvec_vvv, MO_32, do_vmuh_u)
-TRANS(vmuh_du, LSX, gvec_vvv, MO_64, do_vmuh_u)
+TRANS(vmuh_bu, LSX, gvec_vvv, 16, MO_8,  do_vmuh_u)
+TRANS(vmuh_hu, LSX, gvec_vvv, 16, MO_16, do_vmuh_u)
+TRANS(vmuh_wu, LSX, gvec_vvv, 16, MO_32, do_vmuh_u)
+TRANS(vmuh_du, LSX, gvec_vvv, 16, MO_64, do_vmuh_u)
 
 static void gen_vmulwev_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -1728,9 +1717,9 @@ static void do_vmulwev_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmulwev_h_b, LSX, gvec_vvv, MO_8, do_vmulwev_s)
-TRANS(vmulwev_w_h, LSX, gvec_vvv, MO_16, do_vmulwev_s)
-TRANS(vmulwev_d_w, LSX, gvec_vvv, MO_32, do_vmulwev_s)
+TRANS(vmulwev_h_b, LSX, gvec_vvv, 16, MO_8, do_vmulwev_s)
+TRANS(vmulwev_w_h, LSX, gvec_vvv, 16, MO_16, do_vmulwev_s)
+TRANS(vmulwev_d_w, LSX, gvec_vvv, 16, MO_32, do_vmulwev_s)
 
 static void tcg_gen_mulus2_i64(TCGv_i64 rl, TCGv_i64 rh,
                                TCGv_i64 arg1, TCGv_i64 arg2)
@@ -1836,9 +1825,9 @@ static void do_vmulwod_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmulwod_h_b, LSX, gvec_vvv, MO_8, do_vmulwod_s)
-TRANS(vmulwod_w_h, LSX, gvec_vvv, MO_16, do_vmulwod_s)
-TRANS(vmulwod_d_w, LSX, gvec_vvv, MO_32, do_vmulwod_s)
+TRANS(vmulwod_h_b, LSX, gvec_vvv, 16, MO_8, do_vmulwod_s)
+TRANS(vmulwod_w_h, LSX, gvec_vvv, 16, MO_16, do_vmulwod_s)
+TRANS(vmulwod_d_w, LSX, gvec_vvv, 16, MO_32, do_vmulwod_s)
 
 static void gen_vmulwev_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -1906,9 +1895,9 @@ static void do_vmulwev_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmulwev_h_bu, LSX, gvec_vvv, MO_8, do_vmulwev_u)
-TRANS(vmulwev_w_hu, LSX, gvec_vvv, MO_16, do_vmulwev_u)
-TRANS(vmulwev_d_wu, LSX, gvec_vvv, MO_32, do_vmulwev_u)
+TRANS(vmulwev_h_bu, LSX, gvec_vvv, 16, MO_8, do_vmulwev_u)
+TRANS(vmulwev_w_hu, LSX, gvec_vvv, 16, MO_16, do_vmulwev_u)
+TRANS(vmulwev_d_wu, LSX, gvec_vvv, 16, MO_32, do_vmulwev_u)
 
 static void gen_vmulwod_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -1976,9 +1965,9 @@ static void do_vmulwod_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmulwod_h_bu, LSX, gvec_vvv, MO_8, do_vmulwod_u)
-TRANS(vmulwod_w_hu, LSX, gvec_vvv, MO_16, do_vmulwod_u)
-TRANS(vmulwod_d_wu, LSX, gvec_vvv, MO_32, do_vmulwod_u)
+TRANS(vmulwod_h_bu, LSX, gvec_vvv, 16, MO_8, do_vmulwod_u)
+TRANS(vmulwod_w_hu, LSX, gvec_vvv, 16, MO_16, do_vmulwod_u)
+TRANS(vmulwod_d_wu, LSX, gvec_vvv, 16, MO_32, do_vmulwod_u)
 
 static void gen_vmulwev_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2048,9 +2037,9 @@ static void do_vmulwev_u_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmulwev_h_bu_b, LSX, gvec_vvv, MO_8, do_vmulwev_u_s)
-TRANS(vmulwev_w_hu_h, LSX, gvec_vvv, MO_16, do_vmulwev_u_s)
-TRANS(vmulwev_d_wu_w, LSX, gvec_vvv, MO_32, do_vmulwev_u_s)
+TRANS(vmulwev_h_bu_b, LSX, gvec_vvv, 16, MO_8, do_vmulwev_u_s)
+TRANS(vmulwev_w_hu_h, LSX, gvec_vvv, 16, MO_16, do_vmulwev_u_s)
+TRANS(vmulwev_d_wu_w, LSX, gvec_vvv, 16, MO_32, do_vmulwev_u_s)
 
 static void gen_vmulwod_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2117,9 +2106,9 @@ static void do_vmulwod_u_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmulwod_h_bu_b, LSX, gvec_vvv, MO_8, do_vmulwod_u_s)
-TRANS(vmulwod_w_hu_h, LSX, gvec_vvv, MO_16, do_vmulwod_u_s)
-TRANS(vmulwod_d_wu_w, LSX, gvec_vvv, MO_32, do_vmulwod_u_s)
+TRANS(vmulwod_h_bu_b, LSX, gvec_vvv, 16, MO_8, do_vmulwod_u_s)
+TRANS(vmulwod_w_hu_h, LSX, gvec_vvv, 16, MO_16, do_vmulwod_u_s)
+TRANS(vmulwod_d_wu_w, LSX, gvec_vvv, 16, MO_32, do_vmulwod_u_s)
 
 static void gen_vmadd(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2190,10 +2179,10 @@ static void do_vmadd(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmadd_b, LSX, gvec_vvv, MO_8, do_vmadd)
-TRANS(vmadd_h, LSX, gvec_vvv, MO_16, do_vmadd)
-TRANS(vmadd_w, LSX, gvec_vvv, MO_32, do_vmadd)
-TRANS(vmadd_d, LSX, gvec_vvv, MO_64, do_vmadd)
+TRANS(vmadd_b, LSX, gvec_vvv, 16, MO_8, do_vmadd)
+TRANS(vmadd_h, LSX, gvec_vvv, 16, MO_16, do_vmadd)
+TRANS(vmadd_w, LSX, gvec_vvv, 16, MO_32, do_vmadd)
+TRANS(vmadd_d, LSX, gvec_vvv, 16, MO_64, do_vmadd)
 
 static void gen_vmsub(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2264,10 +2253,10 @@ static void do_vmsub(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmsub_b, LSX, gvec_vvv, MO_8, do_vmsub)
-TRANS(vmsub_h, LSX, gvec_vvv, MO_16, do_vmsub)
-TRANS(vmsub_w, LSX, gvec_vvv, MO_32, do_vmsub)
-TRANS(vmsub_d, LSX, gvec_vvv, MO_64, do_vmsub)
+TRANS(vmsub_b, LSX, gvec_vvv, 16, MO_8, do_vmsub)
+TRANS(vmsub_h, LSX, gvec_vvv, 16, MO_16, do_vmsub)
+TRANS(vmsub_w, LSX, gvec_vvv, 16, MO_32, do_vmsub)
+TRANS(vmsub_d, LSX, gvec_vvv, 16, MO_64, do_vmsub)
 
 static void gen_vmaddwev_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2339,9 +2328,9 @@ static void do_vmaddwev_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmaddwev_h_b, LSX, gvec_vvv, MO_8, do_vmaddwev_s)
-TRANS(vmaddwev_w_h, LSX, gvec_vvv, MO_16, do_vmaddwev_s)
-TRANS(vmaddwev_d_w, LSX, gvec_vvv, MO_32, do_vmaddwev_s)
+TRANS(vmaddwev_h_b, LSX, gvec_vvv, 16, MO_8, do_vmaddwev_s)
+TRANS(vmaddwev_w_h, LSX, gvec_vvv, 16, MO_16, do_vmaddwev_s)
+TRANS(vmaddwev_d_w, LSX, gvec_vvv, 16, MO_32, do_vmaddwev_s)
 
 #define VMADD_Q(NAME, FN, idx1, idx2)                     \
 static bool trans_## NAME (DisasContext *ctx, arg_vvv *a) \
@@ -2447,9 +2436,9 @@ static void do_vmaddwod_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmaddwod_h_b, LSX, gvec_vvv, MO_8, do_vmaddwod_s)
-TRANS(vmaddwod_w_h, LSX, gvec_vvv, MO_16, do_vmaddwod_s)
-TRANS(vmaddwod_d_w, LSX, gvec_vvv, MO_32, do_vmaddwod_s)
+TRANS(vmaddwod_h_b, LSX, gvec_vvv, 16, MO_8, do_vmaddwod_s)
+TRANS(vmaddwod_w_h, LSX, gvec_vvv, 16, MO_16, do_vmaddwod_s)
+TRANS(vmaddwod_d_w, LSX, gvec_vvv, 16, MO_32, do_vmaddwod_s)
 
 static void gen_vmaddwev_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2517,9 +2506,9 @@ static void do_vmaddwev_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmaddwev_h_bu, LSX, gvec_vvv, MO_8, do_vmaddwev_u)
-TRANS(vmaddwev_w_hu, LSX, gvec_vvv, MO_16, do_vmaddwev_u)
-TRANS(vmaddwev_d_wu, LSX, gvec_vvv, MO_32, do_vmaddwev_u)
+TRANS(vmaddwev_h_bu, LSX, gvec_vvv, 16, MO_8, do_vmaddwev_u)
+TRANS(vmaddwev_w_hu, LSX, gvec_vvv, 16, MO_16, do_vmaddwev_u)
+TRANS(vmaddwev_d_wu, LSX, gvec_vvv, 16, MO_32, do_vmaddwev_u)
 
 static void gen_vmaddwod_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2588,9 +2577,9 @@ static void do_vmaddwod_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmaddwod_h_bu, LSX, gvec_vvv, MO_8, do_vmaddwod_u)
-TRANS(vmaddwod_w_hu, LSX, gvec_vvv, MO_16, do_vmaddwod_u)
-TRANS(vmaddwod_d_wu, LSX, gvec_vvv, MO_32, do_vmaddwod_u)
+TRANS(vmaddwod_h_bu, LSX, gvec_vvv, 16, MO_8, do_vmaddwod_u)
+TRANS(vmaddwod_w_hu, LSX, gvec_vvv, 16, MO_16, do_vmaddwod_u)
+TRANS(vmaddwod_d_wu, LSX, gvec_vvv, 16, MO_32, do_vmaddwod_u)
 
 static void gen_vmaddwev_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2661,9 +2650,9 @@ static void do_vmaddwev_u_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmaddwev_h_bu_b, LSX, gvec_vvv, MO_8, do_vmaddwev_u_s)
-TRANS(vmaddwev_w_hu_h, LSX, gvec_vvv, MO_16, do_vmaddwev_u_s)
-TRANS(vmaddwev_d_wu_w, LSX, gvec_vvv, MO_32, do_vmaddwev_u_s)
+TRANS(vmaddwev_h_bu_b, LSX, gvec_vvv, 16, MO_8, do_vmaddwev_u_s)
+TRANS(vmaddwev_w_hu_h, LSX, gvec_vvv, 16, MO_16, do_vmaddwev_u_s)
+TRANS(vmaddwev_d_wu_w, LSX, gvec_vvv, 16, MO_32, do_vmaddwev_u_s)
 
 static void gen_vmaddwod_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2733,9 +2722,9 @@ static void do_vmaddwod_u_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmaddwod_h_bu_b, LSX, gvec_vvv, MO_8, do_vmaddwod_u_s)
-TRANS(vmaddwod_w_hu_h, LSX, gvec_vvv, MO_16, do_vmaddwod_u_s)
-TRANS(vmaddwod_d_wu_w, LSX, gvec_vvv, MO_32, do_vmaddwod_u_s)
+TRANS(vmaddwod_h_bu_b, LSX, gvec_vvv, 16, MO_8, do_vmaddwod_u_s)
+TRANS(vmaddwod_w_hu_h, LSX, gvec_vvv, 16, MO_16, do_vmaddwod_u_s)
+TRANS(vmaddwod_d_wu_w, LSX, gvec_vvv, 16, MO_32, do_vmaddwod_u_s)
 
 TRANS(vdiv_b, LSX, gen_vvv, gen_helper_vdiv_b)
 TRANS(vdiv_h, LSX, gen_vvv, gen_helper_vdiv_h)
@@ -2912,10 +2901,10 @@ static void do_vsigncov(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vsigncov_b, LSX, gvec_vvv, MO_8, do_vsigncov)
-TRANS(vsigncov_h, LSX, gvec_vvv, MO_16, do_vsigncov)
-TRANS(vsigncov_w, LSX, gvec_vvv, MO_32, do_vsigncov)
-TRANS(vsigncov_d, LSX, gvec_vvv, MO_64, do_vsigncov)
+TRANS(vsigncov_b, LSX, gvec_vvv, 16, MO_8, do_vsigncov)
+TRANS(vsigncov_h, LSX, gvec_vvv, 16, MO_16, do_vsigncov)
+TRANS(vsigncov_w, LSX, gvec_vvv, 16, MO_32, do_vsigncov)
+TRANS(vsigncov_d, LSX, gvec_vvv, 16, MO_64, do_vsigncov)
 
 TRANS(vmskltz_b, LSX, gen_vv, gen_helper_vmskltz_b)
 TRANS(vmskltz_h, LSX, gen_vv, gen_helper_vmskltz_h)
@@ -3049,7 +3038,7 @@ static bool trans_vldi(DisasContext *ctx, arg_vldi *a)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     sel = (a->imm >> 12) & 0x1;
 
@@ -3066,10 +3055,10 @@ static bool trans_vldi(DisasContext *ctx, arg_vldi *a)
     return true;
 }
 
-TRANS(vand_v, LSX, gvec_vvv, MO_64, tcg_gen_gvec_and)
-TRANS(vor_v, LSX, gvec_vvv, MO_64, tcg_gen_gvec_or)
-TRANS(vxor_v, LSX, gvec_vvv, MO_64, tcg_gen_gvec_xor)
-TRANS(vnor_v, LSX, gvec_vvv, MO_64, tcg_gen_gvec_nor)
+TRANS(vand_v, LSX, gvec_vvv, 16, MO_64, tcg_gen_gvec_and)
+TRANS(vor_v, LSX, gvec_vvv, 16, MO_64, tcg_gen_gvec_or)
+TRANS(vxor_v, LSX, gvec_vvv, 16, MO_64, tcg_gen_gvec_xor)
+TRANS(vnor_v, LSX, gvec_vvv, 16, MO_64, tcg_gen_gvec_nor)
 
 static bool trans_vandn_v(DisasContext *ctx, arg_vvv *a)
 {
@@ -3079,7 +3068,7 @@ static bool trans_vandn_v(DisasContext *ctx, arg_vvv *a)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     vd_ofs = vec_full_offset(a->vd);
     vj_ofs = vec_full_offset(a->vj);
@@ -3088,7 +3077,7 @@ static bool trans_vandn_v(DisasContext *ctx, arg_vvv *a)
     tcg_gen_gvec_andc(MO_64, vd_ofs, vk_ofs, vj_ofs, 16, ctx->vl/8);
     return true;
 }
-TRANS(vorn_v, LSX, gvec_vvv, MO_64, tcg_gen_gvec_orc)
+TRANS(vorn_v, LSX, gvec_vvv, 16, MO_64, tcg_gen_gvec_orc)
 TRANS(vandi_b, LSX, gvec_vv_i, MO_8, tcg_gen_gvec_andi)
 TRANS(vori_b, LSX, gvec_vv_i, MO_8, tcg_gen_gvec_ori)
 TRANS(vxori_b, LSX, gvec_vv_i, MO_8, tcg_gen_gvec_xori)
@@ -3126,37 +3115,37 @@ static void do_vnori_b(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
 
 TRANS(vnori_b, LSX, gvec_vv_i, MO_8, do_vnori_b)
 
-TRANS(vsll_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_shlv)
-TRANS(vsll_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_shlv)
-TRANS(vsll_w, LSX, gvec_vvv, MO_32, tcg_gen_gvec_shlv)
-TRANS(vsll_d, LSX, gvec_vvv, MO_64, tcg_gen_gvec_shlv)
+TRANS(vsll_b, LSX, gvec_vvv, 16, MO_8, tcg_gen_gvec_shlv)
+TRANS(vsll_h, LSX, gvec_vvv, 16, MO_16, tcg_gen_gvec_shlv)
+TRANS(vsll_w, LSX, gvec_vvv, 16, MO_32, tcg_gen_gvec_shlv)
+TRANS(vsll_d, LSX, gvec_vvv, 16, MO_64, tcg_gen_gvec_shlv)
 TRANS(vslli_b, LSX, gvec_vv_i, MO_8, tcg_gen_gvec_shli)
 TRANS(vslli_h, LSX, gvec_vv_i, MO_16, tcg_gen_gvec_shli)
 TRANS(vslli_w, LSX, gvec_vv_i, MO_32, tcg_gen_gvec_shli)
 TRANS(vslli_d, LSX, gvec_vv_i, MO_64, tcg_gen_gvec_shli)
 
-TRANS(vsrl_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_shrv)
-TRANS(vsrl_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_shrv)
-TRANS(vsrl_w, LSX, gvec_vvv, MO_32, tcg_gen_gvec_shrv)
-TRANS(vsrl_d, LSX, gvec_vvv, MO_64, tcg_gen_gvec_shrv)
+TRANS(vsrl_b, LSX, gvec_vvv, 16, MO_8, tcg_gen_gvec_shrv)
+TRANS(vsrl_h, LSX, gvec_vvv, 16, MO_16, tcg_gen_gvec_shrv)
+TRANS(vsrl_w, LSX, gvec_vvv, 16, MO_32, tcg_gen_gvec_shrv)
+TRANS(vsrl_d, LSX, gvec_vvv, 16, MO_64, tcg_gen_gvec_shrv)
 TRANS(vsrli_b, LSX, gvec_vv_i, MO_8, tcg_gen_gvec_shri)
 TRANS(vsrli_h, LSX, gvec_vv_i, MO_16, tcg_gen_gvec_shri)
 TRANS(vsrli_w, LSX, gvec_vv_i, MO_32, tcg_gen_gvec_shri)
 TRANS(vsrli_d, LSX, gvec_vv_i, MO_64, tcg_gen_gvec_shri)
 
-TRANS(vsra_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_sarv)
-TRANS(vsra_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_sarv)
-TRANS(vsra_w, LSX, gvec_vvv, MO_32, tcg_gen_gvec_sarv)
-TRANS(vsra_d, LSX, gvec_vvv, MO_64, tcg_gen_gvec_sarv)
+TRANS(vsra_b, LSX, gvec_vvv, 16, MO_8, tcg_gen_gvec_sarv)
+TRANS(vsra_h, LSX, gvec_vvv, 16, MO_16, tcg_gen_gvec_sarv)
+TRANS(vsra_w, LSX, gvec_vvv, 16, MO_32, tcg_gen_gvec_sarv)
+TRANS(vsra_d, LSX, gvec_vvv, 16, MO_64, tcg_gen_gvec_sarv)
 TRANS(vsrai_b, LSX, gvec_vv_i, MO_8, tcg_gen_gvec_sari)
 TRANS(vsrai_h, LSX, gvec_vv_i, MO_16, tcg_gen_gvec_sari)
 TRANS(vsrai_w, LSX, gvec_vv_i, MO_32, tcg_gen_gvec_sari)
 TRANS(vsrai_d, LSX, gvec_vv_i, MO_64, tcg_gen_gvec_sari)
 
-TRANS(vrotr_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_rotrv)
-TRANS(vrotr_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_rotrv)
-TRANS(vrotr_w, LSX, gvec_vvv, MO_32, tcg_gen_gvec_rotrv)
-TRANS(vrotr_d, LSX, gvec_vvv, MO_64, tcg_gen_gvec_rotrv)
+TRANS(vrotr_b, LSX, gvec_vvv, 16, MO_8, tcg_gen_gvec_rotrv)
+TRANS(vrotr_h, LSX, gvec_vvv, 16, MO_16, tcg_gen_gvec_rotrv)
+TRANS(vrotr_w, LSX, gvec_vvv, 16, MO_32, tcg_gen_gvec_rotrv)
+TRANS(vrotr_d, LSX, gvec_vvv, 16, MO_64, tcg_gen_gvec_rotrv)
 TRANS(vrotri_b, LSX, gvec_vv_i, MO_8, tcg_gen_gvec_rotri)
 TRANS(vrotri_h, LSX, gvec_vv_i, MO_16, tcg_gen_gvec_rotri)
 TRANS(vrotri_w, LSX, gvec_vv_i, MO_32, tcg_gen_gvec_rotri)
@@ -3361,10 +3350,10 @@ static void do_vbitclr(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vbitclr_b, LSX, gvec_vvv, MO_8, do_vbitclr)
-TRANS(vbitclr_h, LSX, gvec_vvv, MO_16, do_vbitclr)
-TRANS(vbitclr_w, LSX, gvec_vvv, MO_32, do_vbitclr)
-TRANS(vbitclr_d, LSX, gvec_vvv, MO_64, do_vbitclr)
+TRANS(vbitclr_b, LSX, gvec_vvv, 16, MO_8, do_vbitclr)
+TRANS(vbitclr_h, LSX, gvec_vvv, 16, MO_16, do_vbitclr)
+TRANS(vbitclr_w, LSX, gvec_vvv, 16, MO_32, do_vbitclr)
+TRANS(vbitclr_d, LSX, gvec_vvv, 16, MO_64, do_vbitclr)
 
 static void do_vbiti(unsigned vece, TCGv_vec t, TCGv_vec a, int64_t imm,
                      void (*func)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec))
@@ -3472,10 +3461,10 @@ static void do_vbitset(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vbitset_b, LSX, gvec_vvv, MO_8, do_vbitset)
-TRANS(vbitset_h, LSX, gvec_vvv, MO_16, do_vbitset)
-TRANS(vbitset_w, LSX, gvec_vvv, MO_32, do_vbitset)
-TRANS(vbitset_d, LSX, gvec_vvv, MO_64, do_vbitset)
+TRANS(vbitset_b, LSX, gvec_vvv, 16, MO_8, do_vbitset)
+TRANS(vbitset_h, LSX, gvec_vvv, 16, MO_16, do_vbitset)
+TRANS(vbitset_w, LSX, gvec_vvv, 16, MO_32, do_vbitset)
+TRANS(vbitset_d, LSX, gvec_vvv, 16, MO_64, do_vbitset)
 
 static void do_vbitseti(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
                         int64_t imm, uint32_t oprsz, uint32_t maxsz)
@@ -3554,10 +3543,10 @@ static void do_vbitrev(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vbitrev_b, LSX, gvec_vvv, MO_8, do_vbitrev)
-TRANS(vbitrev_h, LSX, gvec_vvv, MO_16, do_vbitrev)
-TRANS(vbitrev_w, LSX, gvec_vvv, MO_32, do_vbitrev)
-TRANS(vbitrev_d, LSX, gvec_vvv, MO_64, do_vbitrev)
+TRANS(vbitrev_b, LSX, gvec_vvv, 16, MO_8, do_vbitrev)
+TRANS(vbitrev_h, LSX, gvec_vvv, 16, MO_16, do_vbitrev)
+TRANS(vbitrev_w, LSX, gvec_vvv, 16, MO_32, do_vbitrev)
+TRANS(vbitrev_d, LSX, gvec_vvv, 16, MO_64, do_vbitrev)
 
 static void do_vbitrevi(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
                         int64_t imm, uint32_t oprsz, uint32_t maxsz)
@@ -3706,7 +3695,7 @@ static bool do_cmp(DisasContext *ctx, arg_vvv *a, MemOp mop, TCGCond cond)
 {
     uint32_t vd_ofs, vj_ofs, vk_ofs;
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     vd_ofs = vec_full_offset(a->vd);
     vj_ofs = vec_full_offset(a->vj);
@@ -3752,7 +3741,7 @@ static bool do_## NAME ##_s(DisasContext *ctx, arg_vv_i *a, MemOp mop) \
 {                                                                      \
     uint32_t vd_ofs, vj_ofs;                                           \
                                                                        \
-    CHECK_SXE;                                                         \
+    CHECK_VEC;                                                         \
                                                                        \
     static const TCGOpcode vecop_list[] = {                            \
         INDEX_op_cmp_vec, 0                                            \
@@ -3801,7 +3790,7 @@ static bool do_## NAME ##_u(DisasContext *ctx, arg_vv_i *a, MemOp mop) \
 {                                                                      \
     uint32_t vd_ofs, vj_ofs;                                           \
                                                                        \
-    CHECK_SXE;                                                         \
+    CHECK_VEC;                                                         \
                                                                        \
     static const TCGOpcode vecop_list[] = {                            \
         INDEX_op_cmp_vec, 0                                            \
@@ -3899,7 +3888,7 @@ static bool trans_vfcmp_cond_s(DisasContext *ctx, arg_vvv_fcond *a)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     fn = (a->fcond & 1 ? gen_helper_vfcmp_s_s : gen_helper_vfcmp_c_s);
     flags = get_fcmp_flags(a->fcond >> 1);
@@ -3920,7 +3909,7 @@ static bool trans_vfcmp_cond_d(DisasContext *ctx, arg_vvv_fcond *a)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     fn = (a->fcond & 1 ? gen_helper_vfcmp_s_d : gen_helper_vfcmp_c_d);
     flags = get_fcmp_flags(a->fcond >> 1);
@@ -3935,7 +3924,7 @@ static bool trans_vbitsel_v(DisasContext *ctx, arg_vvvv *a)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     tcg_gen_gvec_bitsel(MO_64, vec_full_offset(a->vd), vec_full_offset(a->va),
                         vec_full_offset(a->vk), vec_full_offset(a->vj),
@@ -3961,7 +3950,7 @@ static bool trans_vbitseli_b(DisasContext *ctx, arg_vv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     tcg_gen_gvec_2i(vec_full_offset(a->vd), vec_full_offset(a->vj),
                     16, ctx->vl/8, a->imm, &op);
@@ -3984,7 +3973,7 @@ static bool trans_## NAME (DisasContext *ctx, arg_cv *a)                       \
         return false;                                                          \
     }                                                                          \
                                                                                \
-    CHECK_SXE;                                                                 \
+    CHECK_VEC;                                                                 \
     tcg_gen_or_i64(t1, al, ah);                                                \
     tcg_gen_setcondi_i64(COND, t1, t1, 0);                                     \
     tcg_gen_st8_tl(t1, cpu_env, offsetof(CPULoongArchState, cf[a->cd & 0x7])); \
@@ -4012,7 +4001,7 @@ static bool trans_vinsgr2vr_b(DisasContext *ctx, arg_vr_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_st8_i64(src, cpu_env,
                     offsetof(CPULoongArchState, fpr[a->vd].vreg.B(a->imm)));
     return true;
@@ -4026,7 +4015,7 @@ static bool trans_vinsgr2vr_h(DisasContext *ctx, arg_vr_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_st16_i64(src, cpu_env,
                     offsetof(CPULoongArchState, fpr[a->vd].vreg.H(a->imm)));
     return true;
@@ -4040,7 +4029,7 @@ static bool trans_vinsgr2vr_w(DisasContext *ctx, arg_vr_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_st32_i64(src, cpu_env,
                      offsetof(CPULoongArchState, fpr[a->vd].vreg.W(a->imm)));
     return true;
@@ -4054,7 +4043,7 @@ static bool trans_vinsgr2vr_d(DisasContext *ctx, arg_vr_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_st_i64(src, cpu_env,
                    offsetof(CPULoongArchState, fpr[a->vd].vreg.D(a->imm)));
     return true;
@@ -4068,7 +4057,7 @@ static bool trans_vpickve2gr_b(DisasContext *ctx, arg_rv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_ld8s_i64(dst, cpu_env,
                      offsetof(CPULoongArchState, fpr[a->vj].vreg.B(a->imm)));
     return true;
@@ -4082,7 +4071,7 @@ static bool trans_vpickve2gr_h(DisasContext *ctx, arg_rv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_ld16s_i64(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.H(a->imm)));
     return true;
@@ -4096,7 +4085,7 @@ static bool trans_vpickve2gr_w(DisasContext *ctx, arg_rv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_ld32s_i64(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.W(a->imm)));
     return true;
@@ -4110,7 +4099,7 @@ static bool trans_vpickve2gr_d(DisasContext *ctx, arg_rv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_ld_i64(dst, cpu_env,
                    offsetof(CPULoongArchState, fpr[a->vj].vreg.D(a->imm)));
     return true;
@@ -4124,7 +4113,7 @@ static bool trans_vpickve2gr_bu(DisasContext *ctx, arg_rv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_ld8u_i64(dst, cpu_env,
                      offsetof(CPULoongArchState, fpr[a->vj].vreg.B(a->imm)));
     return true;
@@ -4138,7 +4127,7 @@ static bool trans_vpickve2gr_hu(DisasContext *ctx, arg_rv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_ld16u_i64(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.H(a->imm)));
     return true;
@@ -4152,7 +4141,7 @@ static bool trans_vpickve2gr_wu(DisasContext *ctx, arg_rv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_ld32u_i64(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.W(a->imm)));
     return true;
@@ -4166,7 +4155,7 @@ static bool trans_vpickve2gr_du(DisasContext *ctx, arg_rv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_ld_i64(dst, cpu_env,
                    offsetof(CPULoongArchState, fpr[a->vj].vreg.D(a->imm)));
     return true;
@@ -4180,7 +4169,7 @@ static bool gvec_dup(DisasContext *ctx, arg_vr *a, MemOp mop)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     tcg_gen_gvec_dup_i64(mop, vec_full_offset(a->vd),
                          16, ctx->vl/8, src);
@@ -4198,7 +4187,7 @@ static bool trans_vreplvei_b(DisasContext *ctx, arg_vv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_gvec_dup_mem(MO_8,vec_full_offset(a->vd),
                          offsetof(CPULoongArchState,
                                   fpr[a->vj].vreg.B((a->imm))),
@@ -4212,7 +4201,7 @@ static bool trans_vreplvei_h(DisasContext *ctx, arg_vv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_gvec_dup_mem(MO_16, vec_full_offset(a->vd),
                          offsetof(CPULoongArchState,
                                   fpr[a->vj].vreg.H((a->imm))),
@@ -4225,7 +4214,7 @@ static bool trans_vreplvei_w(DisasContext *ctx, arg_vv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_gvec_dup_mem(MO_32, vec_full_offset(a->vd),
                          offsetof(CPULoongArchState,
                                   fpr[a->vj].vreg.W((a->imm))),
@@ -4238,7 +4227,7 @@ static bool trans_vreplvei_d(DisasContext *ctx, arg_vv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
     tcg_gen_gvec_dup_mem(MO_64, vec_full_offset(a->vd),
                          offsetof(CPULoongArchState,
                                   fpr[a->vj].vreg.D((a->imm))),
@@ -4257,7 +4246,7 @@ static bool gen_vreplve(DisasContext *ctx, arg_vvr *a, int vece, int bit,
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     tcg_gen_andi_i64(t0, gpr_src(ctx, a->rk, EXT_NONE), (LSX_LEN/bit) -1);
     tcg_gen_shli_i64(t0, t0, vece);
@@ -4287,7 +4276,7 @@ static bool trans_vbsll_v(DisasContext *ctx, arg_vv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     desthigh = tcg_temp_new_i64();
     destlow = tcg_temp_new_i64();
@@ -4321,7 +4310,7 @@ static bool trans_vbsrl_v(DisasContext *ctx, arg_vv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     desthigh = tcg_temp_new_i64();
     destlow = tcg_temp_new_i64();
@@ -4399,7 +4388,7 @@ static bool trans_vld(DisasContext *ctx, arg_vr_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     addr = gpr_src(ctx, a->rj, EXT_NONE);
     val = tcg_temp_new_i128();
@@ -4426,7 +4415,7 @@ static bool trans_vst(DisasContext *ctx, arg_vr_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     addr = gpr_src(ctx, a->rj, EXT_NONE);
     val = tcg_temp_new_i128();
@@ -4453,7 +4442,7 @@ static bool trans_vldx(DisasContext *ctx, arg_vrr *a)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     src1 = gpr_src(ctx, a->rj, EXT_NONE);
     src2 = gpr_src(ctx, a->rk, EXT_NONE);
@@ -4480,7 +4469,7 @@ static bool trans_vstx(DisasContext *ctx, arg_vrr *a)
         return false;
     }
 
-    CHECK_SXE;
+    CHECK_VEC;
 
     src1 = gpr_src(ctx, a->rj, EXT_NONE);
     src2 = gpr_src(ctx, a->rk, EXT_NONE);
@@ -4507,7 +4496,7 @@ static bool trans_## NAME (DisasContext *ctx, arg_vr_i *a)                \
         return false;                                                     \
     }                                                                     \
                                                                           \
-    CHECK_SXE;                                                            \
+    CHECK_VEC;                                                            \
                                                                           \
     addr = gpr_src(ctx, a->rj, EXT_NONE);                                 \
     val = tcg_temp_new_i64();                                             \
@@ -4535,7 +4524,7 @@ static bool trans_## NAME (DisasContext *ctx, arg_vr_ii *a)                  \
         return false;                                                        \
     }                                                                        \
                                                                              \
-    CHECK_SXE;                                                               \
+    CHECK_VEC;                                                               \
                                                                              \
     addr = gpr_src(ctx, a->rj, EXT_NONE);                                    \
     val = tcg_temp_new_i64();                                                \
-- 
2.39.1


