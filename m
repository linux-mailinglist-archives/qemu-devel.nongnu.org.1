Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F31EF7A7331
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 08:53:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qir4G-0007nD-9v; Wed, 20 Sep 2023 02:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qir4D-0007mS-Ng
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 02:52:09 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qir49-000416-VW
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 02:52:09 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxLOuIlgplmC8qAA--.10101S3;
 Wed, 20 Sep 2023 14:51:52 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dxzdx7lgplhVYMAA--.24315S16; 
 Wed, 20 Sep 2023 14:51:52 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/57] target/loongarch: Implement xvadd/xvsub
Date: Wed, 20 Sep 2023 14:50:56 +0800
Message-Id: <20230920065139.1403868-15-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230920065139.1403868-1-gaosong@loongson.cn>
References: <20230920065139.1403868-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxzdx7lgplhVYMAA--.24315S16
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
Message-Id: <20230914022645.1151356-15-gaosong@loongson.cn>
---
 target/loongarch/insns.decode               |  14 +++
 target/loongarch/disas.c                    |  23 +++++
 target/loongarch/translate.c                |   4 +
 target/loongarch/insn_trans/trans_vec.c.inc | 107 +++++++++++++-------
 4 files changed, 109 insertions(+), 39 deletions(-)

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
index 7f3958a1f4..10e2fe8ff6 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -124,6 +124,10 @@ static void loongarch_tr_init_disas_context(DisasContextBase *dcbase,
         ctx->vl = LSX_LEN;
     }
 
+    if (FIELD_EX64(env->cpucfg[2], CPUCFG2, LASX)) {
+        ctx->vl = LASX_LEN;
+    }
+
     ctx->la64 = is_la64(env);
     ctx->va32 = (ctx->base.tb->flags & HW_FLAGS_VA32) != 0;
 
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index b5ca65c250..3252e1d809 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -193,6 +193,10 @@ static bool gvec_vvv_vl(DisasContext *ctx, arg_vvv *a,
     uint32_t vj_ofs = vec_full_offset(a->vj);
     uint32_t vk_ofs = vec_full_offset(a->vk);
 
+    if (!check_vec(ctx, oprsz)) {
+        return true;
+    }
+
     func(mop, vd_ofs, vj_ofs, vk_ofs, oprsz, ctx->vl / 8);
     return true;
 }
@@ -201,13 +205,15 @@ static bool gvec_vvv(DisasContext *ctx, arg_vvv *a, MemOp mop,
                      void (*func)(unsigned, uint32_t, uint32_t,
                                   uint32_t, uint32_t, uint32_t))
 {
-    if (!check_vec(ctx, 16)) {
-        return true;
-    }
-
     return gvec_vvv_vl(ctx, a, 16, mop, func);
 }
 
+static bool gvec_xxx(DisasContext *ctx, arg_vvv *a, MemOp mop,
+                     void (*func)(unsigned, uint32_t, uint32_t,
+                                  uint32_t, uint32_t, uint32_t))
+{
+    return gvec_vvv_vl(ctx, a, 32, mop, func);
+}
 
 static bool gvec_vv_vl(DisasContext *ctx, arg_vv *a,
                        uint32_t oprsz, MemOp mop,
@@ -279,47 +285,70 @@ TRANS(vadd_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_add)
 TRANS(vadd_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_add)
 TRANS(vadd_w, LSX, gvec_vvv, MO_32, tcg_gen_gvec_add)
 TRANS(vadd_d, LSX, gvec_vvv, MO_64, tcg_gen_gvec_add)
+TRANS(xvadd_b, LASX, gvec_xxx, MO_8, tcg_gen_gvec_add)
+TRANS(xvadd_h, LASX, gvec_xxx, MO_16, tcg_gen_gvec_add)
+TRANS(xvadd_w, LASX, gvec_xxx, MO_32, tcg_gen_gvec_add)
+TRANS(xvadd_d, LASX, gvec_xxx, MO_64, tcg_gen_gvec_add)
+
+static bool gen_vaddsub_q_vl(DisasContext *ctx, arg_vvv *a, uint32_t oprsz,
+                             void (*func)(TCGv_i64, TCGv_i64, TCGv_i64,
+                                          TCGv_i64, TCGv_i64, TCGv_i64))
+{
+    int i;
+    TCGv_i64 rh, rl, ah, al, bh, bl;
+
+    if (!check_vec(ctx, oprsz)) {
+        return true;
+    }
 
-#define VADDSUB_Q(NAME)                                        \
-static bool trans_v## NAME ##_q(DisasContext *ctx, arg_vvv *a) \
-{                                                              \
-    TCGv_i64 rh, rl, ah, al, bh, bl;                           \
-                                                               \
-    if (!avail_LSX(ctx)) {                                     \
-        return false;                                          \
-    }                                                          \
-                                                               \
-    if (!check_vec(ctx, 16)) {                                 \
-        return true;                                           \
-    }                                                          \
-                                                               \
-    rh = tcg_temp_new_i64();                                   \
-    rl = tcg_temp_new_i64();                                   \
-    ah = tcg_temp_new_i64();                                   \
-    al = tcg_temp_new_i64();                                   \
-    bh = tcg_temp_new_i64();                                   \
-    bl = tcg_temp_new_i64();                                   \
-                                                               \
-    get_vreg64(ah, a->vj, 1);                                  \
-    get_vreg64(al, a->vj, 0);                                  \
-    get_vreg64(bh, a->vk, 1);                                  \
-    get_vreg64(bl, a->vk, 0);                                  \
-                                                               \
-    tcg_gen_## NAME ##2_i64(rl, rh, al, ah, bl, bh);           \
-                                                               \
-    set_vreg64(rh, a->vd, 1);                                  \
-    set_vreg64(rl, a->vd, 0);                                  \
-                                                               \
-    return true;                                               \
-}
-
-VADDSUB_Q(add)
-VADDSUB_Q(sub)
+    rh = tcg_temp_new_i64();
+    rl = tcg_temp_new_i64();
+    ah = tcg_temp_new_i64();
+    al = tcg_temp_new_i64();
+    bh = tcg_temp_new_i64();
+    bl = tcg_temp_new_i64();
+
+    for (i = 0; i < oprsz / 16; i++) {
+        get_vreg64(ah, a->vj, 1 + i * 2);
+        get_vreg64(al, a->vj, i * 2);
+        get_vreg64(bh, a->vk, 1 + i * 2);
+        get_vreg64(bl, a->vk, i * 2);
+
+        func(rl, rh, al, ah, bl, bh);
+
+        set_vreg64(rh, a->vd, 1 + i * 2);
+        set_vreg64(rl, a->vd, i * 2);
+    }
+    return true;
+}
+
+static bool gen_vaddsub_q(DisasContext *ctx, arg_vvv *a,
+                          void (*func)(TCGv_i64, TCGv_i64, TCGv_i64,
+                                       TCGv_i64, TCGv_i64, TCGv_i64))
+{
+    return gen_vaddsub_q_vl(ctx, a, 16, func);
+}
+
+static bool gen_xvaddsub_q(DisasContext *ctx, arg_vvv *a,
+                           void (*func)(TCGv_i64, TCGv_i64, TCGv_i64,
+                                        TCGv_i64, TCGv_i64, TCGv_i64))
+{
+    return gen_vaddsub_q_vl(ctx, a, 32, func);
+}
 
 TRANS(vsub_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_sub)
 TRANS(vsub_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_sub)
 TRANS(vsub_w, LSX, gvec_vvv, MO_32, tcg_gen_gvec_sub)
 TRANS(vsub_d, LSX, gvec_vvv, MO_64, tcg_gen_gvec_sub)
+TRANS(xvsub_b, LASX, gvec_xxx, MO_8, tcg_gen_gvec_sub)
+TRANS(xvsub_h, LASX, gvec_xxx, MO_16, tcg_gen_gvec_sub)
+TRANS(xvsub_w, LASX, gvec_xxx, MO_32, tcg_gen_gvec_sub)
+TRANS(xvsub_d, LASX, gvec_xxx, MO_64, tcg_gen_gvec_sub)
+
+TRANS(vadd_q, LSX, gen_vaddsub_q, tcg_gen_add2_i64)
+TRANS(vsub_q, LSX, gen_vaddsub_q, tcg_gen_sub2_i64)
+TRANS(xvadd_q, LASX, gen_xvaddsub_q, tcg_gen_add2_i64)
+TRANS(xvsub_q, LASX, gen_xvaddsub_q, tcg_gen_sub2_i64)
 
 TRANS(vaddi_bu, LSX, gvec_vv_i, MO_8, tcg_gen_gvec_addi)
 TRANS(vaddi_hu, LSX, gvec_vv_i, MO_16, tcg_gen_gvec_addi)
-- 
2.39.1


