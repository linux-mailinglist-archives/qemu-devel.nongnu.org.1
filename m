Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5197970F8
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 10:42:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeARR-00045Q-OF; Thu, 07 Sep 2023 04:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qeARN-00042m-4o
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:32:41 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qeARI-0002KH-3Q
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:32:40 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxfOqXivlkEzkhAA--.39250S3;
 Thu, 07 Sep 2023 16:32:23 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bxxsx+ivlk8FVwAA--.49124S27; 
 Thu, 07 Sep 2023 16:32:22 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH RESEND v5 25/57] target/loongarch: Implement
 xvmul/xvmuh/xvmulw{ev/od}
Date: Thu,  7 Sep 2023 16:31:26 +0800
Message-Id: <20230907083158.3975132-26-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230907083158.3975132-1-gaosong@loongson.cn>
References: <20230907083158.3975132-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxxsx+ivlk8FVwAA--.49124S27
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
- XVMUL.{B/H/W/D};
- XVMUH.{B/H/W/D}[U];
- XVMULW{EV/OD}.{H.B/W.H/D.W/Q.D}[U];
- XVMULW{EV/OD}.{H.BU.B/W.HU.H/D.WU.W/Q.DU.D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/insns.decode               | 38 ++++++++
 target/loongarch/disas.c                    | 38 ++++++++
 target/loongarch/vec_helper.c               | 55 ++++++------
 target/loongarch/insn_trans/trans_vec.c.inc | 96 +++++++++++++++++++--
 4 files changed, 195 insertions(+), 32 deletions(-)

diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 99aefcb651..0f9ebe641f 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1473,6 +1473,44 @@ xvmini_hu        0111 01101001 01101 ..... ..... .....    @vv_ui5
 xvmini_wu        0111 01101001 01110 ..... ..... .....    @vv_ui5
 xvmini_du        0111 01101001 01111 ..... ..... .....    @vv_ui5
 
+xvmul_b          0111 01001000 01000 ..... ..... .....    @vvv
+xvmul_h          0111 01001000 01001 ..... ..... .....    @vvv
+xvmul_w          0111 01001000 01010 ..... ..... .....    @vvv
+xvmul_d          0111 01001000 01011 ..... ..... .....    @vvv
+xvmuh_b          0111 01001000 01100 ..... ..... .....    @vvv
+xvmuh_h          0111 01001000 01101 ..... ..... .....    @vvv
+xvmuh_w          0111 01001000 01110 ..... ..... .....    @vvv
+xvmuh_d          0111 01001000 01111 ..... ..... .....    @vvv
+xvmuh_bu         0111 01001000 10000 ..... ..... .....    @vvv
+xvmuh_hu         0111 01001000 10001 ..... ..... .....    @vvv
+xvmuh_wu         0111 01001000 10010 ..... ..... .....    @vvv
+xvmuh_du         0111 01001000 10011 ..... ..... .....    @vvv
+
+xvmulwev_h_b     0111 01001001 00000 ..... ..... .....    @vvv
+xvmulwev_w_h     0111 01001001 00001 ..... ..... .....    @vvv
+xvmulwev_d_w     0111 01001001 00010 ..... ..... .....    @vvv
+xvmulwev_q_d     0111 01001001 00011 ..... ..... .....    @vvv
+xvmulwod_h_b     0111 01001001 00100 ..... ..... .....    @vvv
+xvmulwod_w_h     0111 01001001 00101 ..... ..... .....    @vvv
+xvmulwod_d_w     0111 01001001 00110 ..... ..... .....    @vvv
+xvmulwod_q_d     0111 01001001 00111 ..... ..... .....    @vvv
+xvmulwev_h_bu    0111 01001001 10000 ..... ..... .....    @vvv
+xvmulwev_w_hu    0111 01001001 10001 ..... ..... .....    @vvv
+xvmulwev_d_wu    0111 01001001 10010 ..... ..... .....    @vvv
+xvmulwev_q_du    0111 01001001 10011 ..... ..... .....    @vvv
+xvmulwod_h_bu    0111 01001001 10100 ..... ..... .....    @vvv
+xvmulwod_w_hu    0111 01001001 10101 ..... ..... .....    @vvv
+xvmulwod_d_wu    0111 01001001 10110 ..... ..... .....    @vvv
+xvmulwod_q_du    0111 01001001 10111 ..... ..... .....    @vvv
+xvmulwev_h_bu_b  0111 01001010 00000 ..... ..... .....    @vvv
+xvmulwev_w_hu_h  0111 01001010 00001 ..... ..... .....    @vvv
+xvmulwev_d_wu_w  0111 01001010 00010 ..... ..... .....    @vvv
+xvmulwev_q_du_d  0111 01001010 00011 ..... ..... .....    @vvv
+xvmulwod_h_bu_b  0111 01001010 00100 ..... ..... .....    @vvv
+xvmulwod_w_hu_h  0111 01001010 00101 ..... ..... .....    @vvv
+xvmulwod_d_wu_w  0111 01001010 00110 ..... ..... .....    @vvv
+xvmulwod_q_du_d  0111 01001010 00111 ..... ..... .....    @vvv
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index ef2c78147e..f839373a7a 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1890,6 +1890,44 @@ INSN_LASX(xvmini_hu,         vv_i)
 INSN_LASX(xvmini_wu,         vv_i)
 INSN_LASX(xvmini_du,         vv_i)
 
+INSN_LASX(xvmul_b,           vvv)
+INSN_LASX(xvmul_h,           vvv)
+INSN_LASX(xvmul_w,           vvv)
+INSN_LASX(xvmul_d,           vvv)
+INSN_LASX(xvmuh_b,           vvv)
+INSN_LASX(xvmuh_h,           vvv)
+INSN_LASX(xvmuh_w,           vvv)
+INSN_LASX(xvmuh_d,           vvv)
+INSN_LASX(xvmuh_bu,          vvv)
+INSN_LASX(xvmuh_hu,          vvv)
+INSN_LASX(xvmuh_wu,          vvv)
+INSN_LASX(xvmuh_du,          vvv)
+
+INSN_LASX(xvmulwev_h_b,      vvv)
+INSN_LASX(xvmulwev_w_h,      vvv)
+INSN_LASX(xvmulwev_d_w,      vvv)
+INSN_LASX(xvmulwev_q_d,      vvv)
+INSN_LASX(xvmulwod_h_b,      vvv)
+INSN_LASX(xvmulwod_w_h,      vvv)
+INSN_LASX(xvmulwod_d_w,      vvv)
+INSN_LASX(xvmulwod_q_d,      vvv)
+INSN_LASX(xvmulwev_h_bu,     vvv)
+INSN_LASX(xvmulwev_w_hu,     vvv)
+INSN_LASX(xvmulwev_d_wu,     vvv)
+INSN_LASX(xvmulwev_q_du,     vvv)
+INSN_LASX(xvmulwod_h_bu,     vvv)
+INSN_LASX(xvmulwod_w_hu,     vvv)
+INSN_LASX(xvmulwod_d_wu,     vvv)
+INSN_LASX(xvmulwod_q_du,     vvv)
+INSN_LASX(xvmulwev_h_bu_b,   vvv)
+INSN_LASX(xvmulwev_w_hu_h,   vvv)
+INSN_LASX(xvmulwev_d_wu_w,   vvv)
+INSN_LASX(xvmulwev_q_du_d,   vvv)
+INSN_LASX(xvmulwod_h_bu_b,   vvv)
+INSN_LASX(xvmulwod_w_hu_h,   vvv)
+INSN_LASX(xvmulwod_d_wu_w,   vvv)
+INSN_LASX(xvmulwod_q_du_d,   vvv)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index fdf8b3dd64..e152998094 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -447,50 +447,53 @@ VMINMAXI(vmaxi_hu, 16, UH, DO_MAX)
 VMINMAXI(vmaxi_wu, 32, UW, DO_MAX)
 VMINMAXI(vmaxi_du, 64, UD, DO_MAX)
 
-#define DO_VMUH(NAME, BIT, E1, E2, DO_OP)                   \
-void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t v) \
-{                                                           \
-    int i;                                                  \
-    VReg *Vd = (VReg *)vd;                                  \
-    VReg *Vj = (VReg *)vj;                                  \
-    VReg *Vk = (VReg *)vk;                                  \
-    typedef __typeof(Vd->E1(0)) T;                          \
-                                                            \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                     \
-        Vd->E2(i) = ((T)Vj->E2(i)) * ((T)Vk->E2(i)) >> BIT; \
-    }                                                       \
+#define DO_VMUH(NAME, BIT, E1, E2, DO_OP)                      \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
+{                                                              \
+    int i;                                                     \
+    VReg *Vd = (VReg *)vd;                                     \
+    VReg *Vj = (VReg *)vj;                                     \
+    VReg *Vk = (VReg *)vk;                                     \
+    typedef __typeof(Vd->E1(0)) T;                             \
+    int oprsz = simd_oprsz(desc);                              \
+                                                               \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                  \
+        Vd->E2(i) = ((T)Vj->E2(i)) * ((T)Vk->E2(i)) >> BIT;    \
+    }                                                          \
 }
 
-void HELPER(vmuh_d)(void *vd, void *vj, void *vk, uint32_t v)
+void HELPER(vmuh_d)(void *vd, void *vj, void *vk, uint32_t desc)
 {
-    uint64_t l, h1, h2;
+    int i;
+    uint64_t l, h;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
     VReg *Vk = (VReg *)vk;
+    int oprsz = simd_oprsz(desc);
 
-    muls64(&l, &h1, Vj->D(0), Vk->D(0));
-    muls64(&l, &h2, Vj->D(1), Vk->D(1));
-
-    Vd->D(0) = h1;
-    Vd->D(1) = h2;
+    for (i = 0; i < oprsz / 8; i++) {
+        muls64(&l, &h, Vj->D(i), Vk->D(i));
+        Vd->D(i) = h;
+    }
 }
 
 DO_VMUH(vmuh_b, 8, H, B, DO_MUH)
 DO_VMUH(vmuh_h, 16, W, H, DO_MUH)
 DO_VMUH(vmuh_w, 32, D, W, DO_MUH)
 
-void HELPER(vmuh_du)(void *vd, void *vj, void *vk, uint32_t v)
+void HELPER(vmuh_du)(void *vd, void *vj, void *vk, uint32_t desc)
 {
-    uint64_t l, h1, h2;
+    int i;
+    uint64_t l, h;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
     VReg *Vk = (VReg *)vk;
+    int oprsz = simd_oprsz(desc);
 
-    mulu64(&l, &h1, Vj->D(0), Vk->D(0));
-    mulu64(&l, &h2, Vj->D(1), Vk->D(1));
-
-    Vd->D(0) = h1;
-    Vd->D(1) = h2;
+    for (i = 0; i < oprsz / 8; i++) {
+        mulu64(&l, &h, Vj->D(i), Vk->D(i));
+        Vd->D(i) = h;
+    }
 }
 
 DO_VMUH(vmuh_bu, 8, UH, UB, DO_MUH)
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index bf93d0750b..d5b2a73ca8 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -1936,6 +1936,10 @@ TRANS(vmul_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_mul)
 TRANS(vmul_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_mul)
 TRANS(vmul_w, LSX, gvec_vvv, MO_32, tcg_gen_gvec_mul)
 TRANS(vmul_d, LSX, gvec_vvv, MO_64, tcg_gen_gvec_mul)
+TRANS(xvmul_b, LASX, gvec_xxx, MO_8, tcg_gen_gvec_mul)
+TRANS(xvmul_h, LASX, gvec_xxx, MO_16, tcg_gen_gvec_mul)
+TRANS(xvmul_w, LASX, gvec_xxx, MO_32, tcg_gen_gvec_mul)
+TRANS(xvmul_d, LASX, gvec_xxx, MO_64, tcg_gen_gvec_mul)
 
 static void gen_vmuh_w(TCGv_i32 t, TCGv_i32 a, TCGv_i32 b)
 {
@@ -1980,6 +1984,10 @@ TRANS(vmuh_b, LSX, gvec_vvv, MO_8, do_vmuh_s)
 TRANS(vmuh_h, LSX, gvec_vvv, MO_16, do_vmuh_s)
 TRANS(vmuh_w, LSX, gvec_vvv, MO_32, do_vmuh_s)
 TRANS(vmuh_d, LSX, gvec_vvv, MO_64, do_vmuh_s)
+TRANS(xvmuh_b, LASX, gvec_xxx, MO_8, do_vmuh_s)
+TRANS(xvmuh_h, LASX, gvec_xxx, MO_16, do_vmuh_s)
+TRANS(xvmuh_w, LASX, gvec_xxx, MO_32, do_vmuh_s)
+TRANS(xvmuh_d, LASX, gvec_xxx, MO_64, do_vmuh_s)
 
 static void gen_vmuh_wu(TCGv_i32 t, TCGv_i32 a, TCGv_i32 b)
 {
@@ -2024,6 +2032,10 @@ TRANS(vmuh_bu, LSX, gvec_vvv, MO_8,  do_vmuh_u)
 TRANS(vmuh_hu, LSX, gvec_vvv, MO_16, do_vmuh_u)
 TRANS(vmuh_wu, LSX, gvec_vvv, MO_32, do_vmuh_u)
 TRANS(vmuh_du, LSX, gvec_vvv, MO_64, do_vmuh_u)
+TRANS(xvmuh_bu, LASX, gvec_xxx, MO_8,  do_vmuh_u)
+TRANS(xvmuh_hu, LASX, gvec_xxx, MO_16, do_vmuh_u)
+TRANS(xvmuh_wu, LASX, gvec_xxx, MO_32, do_vmuh_u)
+TRANS(xvmuh_du, LASX, gvec_xxx, MO_64, do_vmuh_u)
 
 static void gen_vmulwev_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2096,6 +2108,9 @@ static void do_vmulwev_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
 TRANS(vmulwev_h_b, LSX, gvec_vvv, MO_8, do_vmulwev_s)
 TRANS(vmulwev_w_h, LSX, gvec_vvv, MO_16, do_vmulwev_s)
 TRANS(vmulwev_d_w, LSX, gvec_vvv, MO_32, do_vmulwev_s)
+TRANS(xvmulwev_h_b, LASX, gvec_xxx, MO_8, do_vmulwev_s)
+TRANS(xvmulwev_w_h, LASX, gvec_xxx, MO_16, do_vmulwev_s)
+TRANS(xvmulwev_d_w, LASX, gvec_xxx, MO_32, do_vmulwev_s)
 
 static void tcg_gen_mulus2_i64(TCGv_i64 rl, TCGv_i64 rh,
                                TCGv_i64 arg1, TCGv_i64 arg2)
@@ -2128,12 +2143,66 @@ static bool trans_## NAME (DisasContext *ctx, arg_vvv *a) \
     return true;                                          \
 }
 
-VMUL_Q(vmulwev_q_d, muls2, 0, 0)
-VMUL_Q(vmulwod_q_d, muls2, 1, 1)
-VMUL_Q(vmulwev_q_du, mulu2, 0, 0)
-VMUL_Q(vmulwod_q_du, mulu2, 1, 1)
-VMUL_Q(vmulwev_q_du_d, mulus2, 0, 0)
-VMUL_Q(vmulwod_q_du_d, mulus2, 1, 1)
+static bool gen_vmul_q_vl(DisasContext *ctx,
+                          arg_vvv *a, uint32_t oprsz, int idx1, int idx2,
+                          void (*func)(TCGv_i64, TCGv_i64,
+                                       TCGv_i64, TCGv_i64))
+{
+    TCGv_i64 rh, rl, arg1, arg2;
+    int i;
+
+    rh = tcg_temp_new_i64();
+    rl = tcg_temp_new_i64();
+    arg1 = tcg_temp_new_i64();
+    arg2 = tcg_temp_new_i64();
+
+    for (i = 0; i < oprsz / 16; i++) {
+        get_vreg64(arg1, a->vj, 2 * i + idx1);
+        get_vreg64(arg2, a->vk, 2 * i + idx2);
+
+        func(rl, rh, arg1, arg2);
+
+        set_vreg64(rh, a->vd, 2 * i + 1);
+        set_vreg64(rl, a->vd, 2 * i);
+    }
+
+    return true;
+}
+
+static bool gen_vmul_q(DisasContext *ctx, arg_vvv *a, int idx1, int idx2,
+                       void (*func)(TCGv_i64, TCGv_i64,
+                                    TCGv_i64, TCGv_i64))
+{
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
+    return gen_vmul_q_vl(ctx, a, 16, idx1, idx2, func);
+}
+
+static bool gen_xvmul_q(DisasContext *ctx, arg_vvv *a, int idx1, int idx2,
+                        void (*func)(TCGv_i64, TCGv_i64,
+                                     TCGv_i64, TCGv_i64))
+{
+    if (!check_vec(ctx, 32)) {
+        return true;
+    }
+
+    return gen_vmul_q_vl(ctx, a, 32, idx1, idx2, func);
+}
+
+TRANS(vmulwev_q_d, LSX, gen_vmul_q, 0, 0, tcg_gen_muls2_i64)
+TRANS(vmulwod_q_d, LSX, gen_vmul_q, 1, 1, tcg_gen_muls2_i64)
+TRANS(vmulwev_q_du, LSX, gen_vmul_q, 0, 0, tcg_gen_mulu2_i64)
+TRANS(vmulwod_q_du, LSX, gen_vmul_q, 1, 1, tcg_gen_mulu2_i64)
+TRANS(vmulwev_q_du_d, LSX, gen_vmul_q, 0, 0, tcg_gen_mulus2_i64)
+TRANS(vmulwod_q_du_d, LSX, gen_vmul_q, 1, 1, tcg_gen_mulus2_i64)
+TRANS(xvmulwev_q_d, LASX, gen_xvmul_q, 0, 0, tcg_gen_muls2_i64)
+TRANS(xvmulwod_q_d, LASX, gen_xvmul_q, 1, 1, tcg_gen_muls2_i64)
+TRANS(xvmulwev_q_du, LASX, gen_xvmul_q, 0, 0, tcg_gen_mulu2_i64)
+TRANS(xvmulwod_q_du, LASX, gen_xvmul_q, 1, 1, tcg_gen_mulu2_i64)
+TRANS(xvmulwev_q_du_d, LASX, gen_xvmul_q, 0, 0, tcg_gen_mulus2_i64)
+TRANS(xvmulwod_q_du_d, LASX, gen_xvmul_q, 1, 1, tcg_gen_mulus2_i64)
 
 static void gen_vmulwod_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2204,6 +2273,9 @@ static void do_vmulwod_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
 TRANS(vmulwod_h_b, LSX, gvec_vvv, MO_8, do_vmulwod_s)
 TRANS(vmulwod_w_h, LSX, gvec_vvv, MO_16, do_vmulwod_s)
 TRANS(vmulwod_d_w, LSX, gvec_vvv, MO_32, do_vmulwod_s)
+TRANS(xvmulwod_h_b, LASX, gvec_xxx, MO_8, do_vmulwod_s)
+TRANS(xvmulwod_w_h, LASX, gvec_xxx, MO_16, do_vmulwod_s)
+TRANS(xvmulwod_d_w, LASX, gvec_xxx, MO_32, do_vmulwod_s)
 
 static void gen_vmulwev_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2274,6 +2346,9 @@ static void do_vmulwev_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
 TRANS(vmulwev_h_bu, LSX, gvec_vvv, MO_8, do_vmulwev_u)
 TRANS(vmulwev_w_hu, LSX, gvec_vvv, MO_16, do_vmulwev_u)
 TRANS(vmulwev_d_wu, LSX, gvec_vvv, MO_32, do_vmulwev_u)
+TRANS(xvmulwev_h_bu, LASX, gvec_xxx, MO_8, do_vmulwev_u)
+TRANS(xvmulwev_w_hu, LASX, gvec_xxx, MO_16, do_vmulwev_u)
+TRANS(xvmulwev_d_wu, LASX, gvec_xxx, MO_32, do_vmulwev_u)
 
 static void gen_vmulwod_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2344,6 +2419,9 @@ static void do_vmulwod_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
 TRANS(vmulwod_h_bu, LSX, gvec_vvv, MO_8, do_vmulwod_u)
 TRANS(vmulwod_w_hu, LSX, gvec_vvv, MO_16, do_vmulwod_u)
 TRANS(vmulwod_d_wu, LSX, gvec_vvv, MO_32, do_vmulwod_u)
+TRANS(xvmulwod_h_bu, LASX, gvec_xxx, MO_8, do_vmulwod_u)
+TRANS(xvmulwod_w_hu, LASX, gvec_xxx, MO_16, do_vmulwod_u)
+TRANS(xvmulwod_d_wu, LASX, gvec_xxx, MO_32, do_vmulwod_u)
 
 static void gen_vmulwev_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2416,6 +2494,9 @@ static void do_vmulwev_u_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
 TRANS(vmulwev_h_bu_b, LSX, gvec_vvv, MO_8, do_vmulwev_u_s)
 TRANS(vmulwev_w_hu_h, LSX, gvec_vvv, MO_16, do_vmulwev_u_s)
 TRANS(vmulwev_d_wu_w, LSX, gvec_vvv, MO_32, do_vmulwev_u_s)
+TRANS(xvmulwev_h_bu_b, LASX, gvec_xxx, MO_8, do_vmulwev_u_s)
+TRANS(xvmulwev_w_hu_h, LASX, gvec_xxx, MO_16, do_vmulwev_u_s)
+TRANS(xvmulwev_d_wu_w, LASX, gvec_xxx, MO_32, do_vmulwev_u_s)
 
 static void gen_vmulwod_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2485,6 +2566,9 @@ static void do_vmulwod_u_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
 TRANS(vmulwod_h_bu_b, LSX, gvec_vvv, MO_8, do_vmulwod_u_s)
 TRANS(vmulwod_w_hu_h, LSX, gvec_vvv, MO_16, do_vmulwod_u_s)
 TRANS(vmulwod_d_wu_w, LSX, gvec_vvv, MO_32, do_vmulwod_u_s)
+TRANS(xvmulwod_h_bu_b, LASX, gvec_xxx, MO_8, do_vmulwod_u_s)
+TRANS(xvmulwod_w_hu_h, LASX, gvec_xxx, MO_16, do_vmulwod_u_s)
+TRANS(xvmulwod_d_wu_w, LASX, gvec_xxx, MO_32, do_vmulwod_u_s)
 
 static void gen_vmadd(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
-- 
2.39.1


