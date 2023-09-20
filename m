Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6C57A737E
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 08:58:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qir5A-0000NM-Ka; Wed, 20 Sep 2023 02:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qir4p-0007zu-TS
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 02:52:49 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qir4f-00049h-6s
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 02:52:46 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cxruuolgpl5y8qAA--.12837S3;
 Wed, 20 Sep 2023 14:52:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dxzdx7lgplhVYMAA--.24315S54; 
 Wed, 20 Sep 2023 14:52:24 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 52/57] target/loongarch: Implement xvreplve xvinsve0 xvpickve
Date: Wed, 20 Sep 2023 14:51:34 +0800
Message-Id: <20230920065139.1403868-53-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230920065139.1403868-1-gaosong@loongson.cn>
References: <20230920065139.1403868-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxzdx7lgplhVYMAA--.24315S54
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
- XVREPLVE.{B/H/W/D};
- XVREPL128VEI.{B/H/W/D};
- XVREPLVE0.{B/H/W/D/Q};
- XVINSVE0.{W/D};
- XVPICKVE.{W/D};
- XVBSLL.V, XVBSRL.V.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230914022645.1151356-53-gaosong@loongson.cn>
---
 target/loongarch/helper.h                   |   5 +
 target/loongarch/insns.decode               |  25 +++
 target/loongarch/disas.c                    |  29 ++++
 target/loongarch/vec_helper.c               |  28 ++++
 target/loongarch/insn_trans/trans_vec.c.inc | 171 +++++++++++++-------
 5 files changed, 201 insertions(+), 57 deletions(-)

diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 85233586e3..fb489dda2d 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -668,6 +668,11 @@ DEF_HELPER_4(vsetallnez_h, void, env, i32, i32, i32)
 DEF_HELPER_4(vsetallnez_w, void, env, i32, i32, i32)
 DEF_HELPER_4(vsetallnez_d, void, env, i32, i32, i32)
 
+DEF_HELPER_FLAGS_4(xvinsve0_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvinsve0_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvpickve_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvpickve_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
 DEF_HELPER_FLAGS_4(vpackev_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vpackev_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vpackev_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index bb3bb447ae..74383ba3bc 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1987,3 +1987,28 @@ xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
 xvreplgr2vr_d    0111 01101001 11110 00011 ..... .....    @vr
+
+xvreplve_b       0111 01010010 00100 ..... ..... .....    @vvr
+xvreplve_h       0111 01010010 00101 ..... ..... .....    @vvr
+xvreplve_w       0111 01010010 00110 ..... ..... .....    @vvr
+xvreplve_d       0111 01010010 00111 ..... ..... .....    @vvr
+
+xvrepl128vei_b   0111 01101111 01111 0 .... ..... .....   @vv_ui4
+xvrepl128vei_h   0111 01101111 01111 10 ... ..... .....   @vv_ui3
+xvrepl128vei_w   0111 01101111 01111 110 .. ..... .....   @vv_ui2
+xvrepl128vei_d   0111 01101111 01111 1110 . ..... .....   @vv_ui1
+
+xvreplve0_b      0111 01110000 01110 00000 ..... .....    @vv
+xvreplve0_h      0111 01110000 01111 00000 ..... .....    @vv
+xvreplve0_w      0111 01110000 01111 10000 ..... .....    @vv
+xvreplve0_d      0111 01110000 01111 11000 ..... .....    @vv
+xvreplve0_q      0111 01110000 01111 11100 ..... .....    @vv
+
+xvinsve0_w       0111 01101111 11111 10 ... ..... .....   @vv_ui3
+xvinsve0_d       0111 01101111 11111 110 .. ..... .....   @vv_ui2
+
+xvpickve_w       0111 01110000 00111 10 ... ..... .....   @vv_ui3
+xvpickve_d       0111 01110000 00111 110 .. ..... .....   @vv_ui2
+
+xvbsll_v         0111 01101000 11100 ..... ..... .....    @vv_ui5
+xvbsrl_v         0111 01101000 11101 ..... ..... .....    @vv_ui5
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 04f9f9fa4b..d091402db6 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1748,6 +1748,11 @@ static void output_rv_i_x(DisasContext *ctx, arg_rv_i *a, const char *mnemonic)
     output(ctx, mnemonic, "r%d, x%d, 0x%x", a->rd, a->vj, a->imm);
 }
 
+static void output_vvr_x(DisasContext *ctx, arg_vvr *a, const char *mnemonic)
+{
+    output(ctx, mnemonic, "x%d, x%d, r%d", a->vd, a->vj, a->rk);
+}
+
 INSN_LASX(xvadd_b,           vvv)
 INSN_LASX(xvadd_h,           vvv)
 INSN_LASX(xvadd_w,           vvv)
@@ -2518,3 +2523,27 @@ INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
 INSN_LASX(xvreplgr2vr_d,     vr)
+
+INSN_LASX(xvreplve_b,        vvr)
+INSN_LASX(xvreplve_h,        vvr)
+INSN_LASX(xvreplve_w,        vvr)
+INSN_LASX(xvreplve_d,        vvr)
+INSN_LASX(xvrepl128vei_b,    vv_i)
+INSN_LASX(xvrepl128vei_h,    vv_i)
+INSN_LASX(xvrepl128vei_w,    vv_i)
+INSN_LASX(xvrepl128vei_d,    vv_i)
+
+INSN_LASX(xvreplve0_b,       vv)
+INSN_LASX(xvreplve0_h,       vv)
+INSN_LASX(xvreplve0_w,       vv)
+INSN_LASX(xvreplve0_d,       vv)
+INSN_LASX(xvreplve0_q,       vv)
+
+INSN_LASX(xvinsve0_w,        vv_i)
+INSN_LASX(xvinsve0_d,        vv_i)
+
+INSN_LASX(xvpickve_w,        vv_i)
+INSN_LASX(xvpickve_d,        vv_i)
+
+INSN_LASX(xvbsll_v,          vv_i)
+INSN_LASX(xvbsrl_v,          vv_i)
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 11793972f5..26d48ed921 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -3209,6 +3209,34 @@ SETALLNEZ(vsetallnez_h, MO_16)
 SETALLNEZ(vsetallnez_w, MO_32)
 SETALLNEZ(vsetallnez_d, MO_64)
 
+#define XVINSVE0(NAME, E, MASK)                                    \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc) \
+{                                                                  \
+    VReg *Vd = (VReg *)vd;                                         \
+    VReg *Vj = (VReg *)vj;                                         \
+    Vd->E(imm & MASK) = Vj->E(0);                                  \
+}
+
+XVINSVE0(xvinsve0_w, W, 0x7)
+XVINSVE0(xvinsve0_d, D, 0x3)
+
+#define XVPICKVE(NAME, E, BIT, MASK)                               \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc) \
+{                                                                  \
+    int i;                                                         \
+    VReg *Vd = (VReg *)vd;                                         \
+    VReg *Vj = (VReg *)vj;                                         \
+    int oprsz = simd_oprsz(desc);                                  \
+                                                                   \
+    Vd->E(0) = Vj->E(imm & MASK);                                  \
+    for (i = 1; i < oprsz / (BIT / 8); i++) {                      \
+        Vd->E(i) = 0;                                              \
+    }                                                              \
+}
+
+XVPICKVE(xvpickve_w, W, 32, 0x7)
+XVPICKVE(xvpickve_d, D, 64, 0x3)
+
 #define VPACKEV(NAME, BIT, E)                                  \
 void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
 {                                                              \
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index e1ba54075e..ab3d92da30 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -5000,112 +5000,169 @@ static bool trans_vreplvei_d(DisasContext *ctx, arg_vv_i *a)
     return true;
 }
 
-static bool gen_vreplve(DisasContext *ctx, arg_vvr *a, int vece, int bit,
-                        void (*func)(TCGv_i64, TCGv_ptr, tcg_target_long))
+static bool gen_vreplve_vl(DisasContext *ctx, arg_vvr *a,
+                           uint32_t oprsz, int vece, int bit,
+                           void (*func)(TCGv_i64, TCGv_ptr, tcg_target_long))
 {
+    int i;
     TCGv_i64 t0 = tcg_temp_new_i64();
     TCGv_ptr t1 = tcg_temp_new_ptr();
     TCGv_i64 t2 = tcg_temp_new_i64();
 
-    if (!avail_LSX(ctx)) {
-        return false;
-    }
-
-    if (!check_vec(ctx, 16)) {
+    if (!check_vec(ctx, oprsz)) {
         return true;
     }
 
-    tcg_gen_andi_i64(t0, gpr_src(ctx, a->rk, EXT_NONE), (LSX_LEN/bit) -1);
+    tcg_gen_andi_i64(t0, gpr_src(ctx, a->rk, EXT_NONE), (LSX_LEN / bit) - 1);
     tcg_gen_shli_i64(t0, t0, vece);
     if (HOST_BIG_ENDIAN) {
-        tcg_gen_xori_i64(t0, t0, vece << ((LSX_LEN/bit) -1));
+        tcg_gen_xori_i64(t0, t0, vece << ((LSX_LEN / bit) - 1));
     }
 
     tcg_gen_trunc_i64_ptr(t1, t0);
     tcg_gen_add_ptr(t1, t1, cpu_env);
-    func(t2, t1, vec_full_offset(a->vj));
-    tcg_gen_gvec_dup_i64(vece, vec_full_offset(a->vd), 16, ctx->vl/8, t2);
+
+    for (i = 0; i < oprsz; i += 16) {
+        func(t2, t1, vec_full_offset(a->vj) + i);
+        tcg_gen_gvec_dup_i64(vece, vec_full_offset(a->vd) + i, 16, 16, t2);
+    }
 
     return true;
 }
 
+static bool gen_vreplve(DisasContext *ctx, arg_vvr *a, int vece, int bit,
+                        void (*func)(TCGv_i64, TCGv_ptr, tcg_target_long))
+{
+    return gen_vreplve_vl(ctx, a, 16, vece, bit, func);
+}
+
+static bool gen_xvreplve(DisasContext *ctx, arg_vvr *a, int vece, int bit,
+                         void (*func)(TCGv_i64, TCGv_ptr, tcg_target_long))
+{
+    return gen_vreplve_vl(ctx, a, 32, vece, bit, func);
+}
+
 TRANS(vreplve_b, LSX, gen_vreplve, MO_8,  8, tcg_gen_ld8u_i64)
 TRANS(vreplve_h, LSX, gen_vreplve, MO_16, 16, tcg_gen_ld16u_i64)
 TRANS(vreplve_w, LSX, gen_vreplve, MO_32, 32, tcg_gen_ld32u_i64)
 TRANS(vreplve_d, LSX, gen_vreplve, MO_64, 64, tcg_gen_ld_i64)
+TRANS(xvreplve_b, LASX, gen_xvreplve, MO_8,  8, tcg_gen_ld8u_i64)
+TRANS(xvreplve_h, LASX, gen_xvreplve, MO_16, 16, tcg_gen_ld16u_i64)
+TRANS(xvreplve_w, LASX, gen_xvreplve, MO_32, 32, tcg_gen_ld32u_i64)
+TRANS(xvreplve_d, LASX, gen_xvreplve, MO_64, 64, tcg_gen_ld_i64)
 
-static bool trans_vbsll_v(DisasContext *ctx, arg_vv_i *a)
+static bool gen_xvrepl128(DisasContext *ctx, arg_vv_i *a, MemOp mop)
 {
-    int ofs;
-    TCGv_i64 desthigh, destlow, high, low;
-
-    if (!avail_LSX(ctx)) {
-        return false;
-    }
+    int i;
 
-    if (!check_vec(ctx, 16)) {
+    if (!check_vec(ctx, 32)) {
         return true;
     }
 
-    desthigh = tcg_temp_new_i64();
-    destlow = tcg_temp_new_i64();
-    high = tcg_temp_new_i64();
-    low = tcg_temp_new_i64();
-
-    get_vreg64(low, a->vj, 0);
+    for (i = 0; i < 32; i += 16) {
+        tcg_gen_gvec_dup_mem(mop, vec_full_offset(a->vd) + i,
+                             vec_reg_offset(a->vj, a->imm, mop) + i, 16, 16);
 
-    ofs = ((a->imm) & 0xf) * 8;
-    if (ofs < 64) {
-        get_vreg64(high, a->vj, 1);
-        tcg_gen_extract2_i64(desthigh, low, high, 64 - ofs);
-        tcg_gen_shli_i64(destlow, low, ofs);
-    } else {
-        tcg_gen_shli_i64(desthigh, low, ofs - 64);
-        destlow = tcg_constant_i64(0);
     }
+    return true;
+}
 
-    set_vreg64(desthigh, a->vd, 1);
-    set_vreg64(destlow, a->vd, 0);
+TRANS(xvrepl128vei_b, LASX, gen_xvrepl128, MO_8)
+TRANS(xvrepl128vei_h, LASX, gen_xvrepl128, MO_16)
+TRANS(xvrepl128vei_w, LASX, gen_xvrepl128, MO_32)
+TRANS(xvrepl128vei_d, LASX, gen_xvrepl128, MO_64)
 
+static bool gen_xvreplve0(DisasContext *ctx, arg_vv *a, MemOp mop)
+{
+    if (!check_vec(ctx, 32)) {
+        return true;
+    }
+
+    tcg_gen_gvec_dup_mem(mop, vec_full_offset(a->vd),
+                         vec_full_offset(a->vj), 32, 32);
     return true;
 }
 
-static bool trans_vbsrl_v(DisasContext *ctx, arg_vv_i *a)
+TRANS(xvreplve0_b, LASX, gen_xvreplve0, MO_8)
+TRANS(xvreplve0_h, LASX, gen_xvreplve0, MO_16)
+TRANS(xvreplve0_w, LASX, gen_xvreplve0, MO_32)
+TRANS(xvreplve0_d, LASX, gen_xvreplve0, MO_64)
+TRANS(xvreplve0_q, LASX, gen_xvreplve0, MO_128)
+
+TRANS(xvinsve0_w, LASX, gen_xx_i, gen_helper_xvinsve0_w)
+TRANS(xvinsve0_d, LASX, gen_xx_i, gen_helper_xvinsve0_d)
+
+TRANS(xvpickve_w, LASX, gen_xx_i, gen_helper_xvpickve_w)
+TRANS(xvpickve_d, LASX, gen_xx_i, gen_helper_xvpickve_d)
+
+static bool do_vbsll_v(DisasContext *ctx, arg_vv_i *a, uint32_t oprsz)
 {
-    TCGv_i64 desthigh, destlow, high, low;
-    int ofs;
+    int i, ofs;
 
-    if (!avail_LSX(ctx)) {
-        return false;
+    if (!check_vec(ctx, oprsz)) {
+        return true;
     }
 
-    if (!check_vec(ctx, 16)) {
-        return true;
+    for (i = 0; i < oprsz / 16; i++) {
+        TCGv desthigh = tcg_temp_new_i64();
+        TCGv destlow = tcg_temp_new_i64();
+        TCGv high = tcg_temp_new_i64();
+        TCGv low = tcg_temp_new_i64();
+
+        get_vreg64(low, a->vj, 2 * i);
+
+        ofs = ((a->imm) & 0xf) * 8;
+        if (ofs < 64) {
+            get_vreg64(high, a->vj, 2 * i + 1);
+            tcg_gen_extract2_i64(desthigh, low, high, 64 - ofs);
+            tcg_gen_shli_i64(destlow, low, ofs);
+        } else {
+            tcg_gen_shli_i64(desthigh, low, ofs - 64);
+            destlow = tcg_constant_i64(0);
+        }
+        set_vreg64(desthigh, a->vd, 2 * i + 1);
+        set_vreg64(destlow, a->vd, 2 * i);
     }
 
-    desthigh = tcg_temp_new_i64();
-    destlow = tcg_temp_new_i64();
-    high = tcg_temp_new_i64();
-    low = tcg_temp_new_i64();
+    return true;
+}
 
-    get_vreg64(high, a->vj, 1);
+static bool do_vbsrl_v(DisasContext *ctx, arg_vv_i *a, uint32_t oprsz)
+{
+    int i, ofs;
 
-    ofs = ((a->imm) & 0xf) * 8;
-    if (ofs < 64) {
-        get_vreg64(low, a->vj, 0);
-        tcg_gen_extract2_i64(destlow, low, high, ofs);
-        tcg_gen_shri_i64(desthigh, high, ofs);
-    } else {
-        tcg_gen_shri_i64(destlow, high, ofs - 64);
-        desthigh = tcg_constant_i64(0);
+    if (!check_vec(ctx, 32)) {
+        return true;
     }
 
-    set_vreg64(desthigh, a->vd, 1);
-    set_vreg64(destlow, a->vd, 0);
+    for (i = 0; i < oprsz / 16; i++) {
+        TCGv desthigh = tcg_temp_new_i64();
+        TCGv destlow = tcg_temp_new_i64();
+        TCGv high = tcg_temp_new_i64();
+        TCGv low = tcg_temp_new_i64();
+        get_vreg64(high, a->vj, 2 * i + 1);
+
+        ofs = ((a->imm) & 0xf) * 8;
+        if (ofs < 64) {
+            get_vreg64(low, a->vj, 2 * i);
+            tcg_gen_extract2_i64(destlow, low, high, ofs);
+            tcg_gen_shri_i64(desthigh, high, ofs);
+        } else {
+            tcg_gen_shri_i64(destlow, high, ofs - 64);
+            desthigh = tcg_constant_i64(0);
+        }
+        set_vreg64(desthigh, a->vd, 2 * i + 1);
+        set_vreg64(destlow, a->vd, 2 * i);
+    }
 
     return true;
 }
 
+TRANS(vbsll_v, LSX, do_vbsll_v, 16)
+TRANS(vbsrl_v, LSX, do_vbsrl_v, 16)
+TRANS(xvbsll_v, LASX, do_vbsll_v, 32)
+TRANS(xvbsrl_v, LASX, do_vbsrl_v, 32)
+
 TRANS(vpackev_b, LSX, gen_vvv, gen_helper_vpackev_b)
 TRANS(vpackev_h, LSX, gen_vvv, gen_helper_vpackev_h)
 TRANS(vpackev_w, LSX, gen_vvv, gen_helper_vpackev_w)
-- 
2.39.1


