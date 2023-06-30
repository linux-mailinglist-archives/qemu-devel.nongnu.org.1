Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1051374369C
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:11:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF94C-0003oz-HB; Fri, 30 Jun 2023 04:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qF948-0003hg-CV
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:01:16 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qF945-00006f-4R
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:01:15 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxU8Rki55krzQEAA--.6880S3;
 Fri, 30 Jun 2023 15:59:32 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxjiNIi55kExQTAA--.24469S44; 
 Fri, 30 Jun 2023 15:59:32 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 42/46] target/loongarch: Implement xvreplve xvinsve0
 xvpickve xvb{sll/srl}v
Date: Fri, 30 Jun 2023 15:59:00 +0800
Message-Id: <20230630075904.45940-43-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230630075904.45940-1-gaosong@loongson.cn>
References: <20230630075904.45940-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjiNIi55kExQTAA--.24469S44
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
- XVREPLVE.{B/H/W/D};
- XVREPL128VEI.{B/H/W/D};
- XVREPLVE0.{B/H/W/D/Q};
- XVINSVE0.{W/D};
- XVPICKVE.{W/D};
- XVBSLL.V, XVBSRL.V.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  28 +++++
 target/loongarch/helper.h                    |   5 +
 target/loongarch/insn_trans/trans_lasx.c.inc |  98 ++++++++++++++++
 target/loongarch/insn_trans/trans_lsx.c.inc  | 111 +++++++++++--------
 target/loongarch/insns.decode                |  25 +++++
 target/loongarch/vec_helper.c                |  29 +++++
 6 files changed, 250 insertions(+), 46 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 0995d9b794..ac7dd3021d 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1748,6 +1748,10 @@ static void output_rv_i_x(DisasContext *ctx, arg_rv_i *a, const char *mnemonic)
     output(ctx, mnemonic, "r%d, x%d, 0x%x", a->rd, a->vj, a->imm);
 }
 
+static void output_vvr_x(DisasContext *ctx, arg_vvr *a, const char *mnemonic)
+{
+    output(ctx, mnemonic, "x%d, x%d, r%d", a->vd, a->vj, a->rk);
+}
 
 INSN_LASX(xvadd_b,           vvv)
 INSN_LASX(xvadd_h,           vvv)
@@ -2520,3 +2524,27 @@ INSN_LASX(xvreplgr2vr_b,     vr)
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
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index b248dcc055..ca7296e652 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -667,6 +667,11 @@ DEF_HELPER_4(vsetallnez_h, void, env, i32, i32, i32)
 DEF_HELPER_4(vsetallnez_w, void, env, i32, i32, i32)
 DEF_HELPER_4(vsetallnez_d, void, env, i32, i32, i32)
 
+DEF_HELPER_5(xvinsve0_w, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(xvinsve0_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(xvpickve_w, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(xvpickve_d, void, env, i32, i32, i32, i32)
+
 DEF_HELPER_4(vpackev_b, void, env, i32, i32, i32)
 DEF_HELPER_4(vpackev_h, void, env, i32, i32, i32)
 DEF_HELPER_4(vpackev_w, void, env, i32, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 4f58ff1f12..c411762756 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -837,3 +837,101 @@ TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
 TRANS(xvreplgr2vr_d, gvec_dup, 32, MO_64)
+
+TRANS(xvreplve_b, gen_vreplve, 32, MO_8, 8, tcg_gen_ld8u_i64)
+TRANS(xvreplve_h, gen_vreplve, 32, MO_16, 16, tcg_gen_ld16u_i64)
+TRANS(xvreplve_w, gen_vreplve, 32, MO_32, 32, tcg_gen_ld32u_i64)
+TRANS(xvreplve_d, gen_vreplve, 32, MO_64, 64, tcg_gen_ld_i64)
+
+static bool trans_xvrepl128vei_b(DisasContext *ctx, arg_vv_i * a)
+{
+    CHECK_VEC;
+
+    tcg_gen_gvec_dup_mem(MO_8,
+                         offsetof(CPULoongArchState, fpr[a->vd].vreg.B(0)),
+                         offsetof(CPULoongArchState,
+                                  fpr[a->vj].vreg.B((a->imm))),
+                         16, 16);
+    tcg_gen_gvec_dup_mem(MO_8,
+                         offsetof(CPULoongArchState, fpr[a->vd].vreg.B(16)),
+                         offsetof(CPULoongArchState,
+                                  fpr[a->vj].vreg.B((a->imm + 16))),
+                         16, 16);
+    return true;
+}
+
+static bool trans_xvrepl128vei_h(DisasContext *ctx, arg_vv_i *a)
+{
+    CHECK_VEC;
+
+    tcg_gen_gvec_dup_mem(MO_16,
+                         offsetof(CPULoongArchState, fpr[a->vd].vreg.H(0)),
+                         offsetof(CPULoongArchState,
+                                  fpr[a->vj].vreg.H((a->imm))),
+                         16, 16);
+    tcg_gen_gvec_dup_mem(MO_16,
+                         offsetof(CPULoongArchState, fpr[a->vd].vreg.H(8)),
+                         offsetof(CPULoongArchState,
+                                  fpr[a->vj].vreg.H((a->imm + 8))),
+                         16, 16);
+    return true;
+}
+
+static bool trans_xvrepl128vei_w(DisasContext *ctx, arg_vv_i *a)
+{
+    CHECK_VEC;
+
+    tcg_gen_gvec_dup_mem(MO_32,
+                         offsetof(CPULoongArchState, fpr[a->vd].vreg.W(0)),
+                         offsetof(CPULoongArchState,
+                                  fpr[a->vj].vreg.W((a->imm))),
+                         16, 16);
+    tcg_gen_gvec_dup_mem(MO_32,
+                         offsetof(CPULoongArchState, fpr[a->vd].vreg.W(4)),
+                         offsetof(CPULoongArchState,
+                                  fpr[a->vj].vreg.W((a->imm + 4))),
+                         16, 16);
+    return true;
+}
+
+static bool trans_xvrepl128vei_d(DisasContext *ctx, arg_vv_i *a)
+{
+    CHECK_VEC;
+
+    tcg_gen_gvec_dup_mem(MO_64,
+                         offsetof(CPULoongArchState, fpr[a->vd].vreg.D(0)),
+                         offsetof(CPULoongArchState,
+                                  fpr[a->vj].vreg.D((a->imm))),
+                         16, 16);
+    tcg_gen_gvec_dup_mem(MO_64,
+                         offsetof(CPULoongArchState, fpr[a->vd].vreg.D(2)),
+                         offsetof(CPULoongArchState,
+                                  fpr[a->vj].vreg.D((a->imm + 2))),
+                         16, 16);
+    return true;
+}
+
+#define XVREPLVE0(NAME, MOP)                                                  \
+static bool trans_## NAME(DisasContext *ctx, arg_vv * a)                      \
+{                                                                             \
+    CHECK_VEC;                                                               \
+                                                                              \
+    tcg_gen_gvec_dup_mem(MOP, vec_full_offset(a->vd), vec_full_offset(a->vj), \
+                         32, 32);                                             \
+    return true;                                                              \
+}
+
+XVREPLVE0(xvreplve0_b, MO_8)
+XVREPLVE0(xvreplve0_h, MO_16)
+XVREPLVE0(xvreplve0_w, MO_32)
+XVREPLVE0(xvreplve0_d, MO_64)
+XVREPLVE0(xvreplve0_q, MO_128)
+
+TRANS(xvinsve0_w, gen_vv_i, 32, gen_helper_xvinsve0_w)
+TRANS(xvinsve0_d, gen_vv_i, 32, gen_helper_xvinsve0_d)
+
+TRANS(xvpickve_w, gen_vv_i, 32, gen_helper_xvpickve_w)
+TRANS(xvpickve_d, gen_vv_i, 32, gen_helper_xvpickve_d)
+
+TRANS(xvbsll_v, do_vbsll_v, 32)
+TRANS(xvbsrl_v, do_vbsrl_v, 32)
diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index 8e1ef4544e..9ae6ca60bf 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_lsx.c.inc
@@ -4144,7 +4144,8 @@ static bool trans_vreplvei_d(DisasContext *ctx, arg_vv_i *a)
     return true;
 }
 
-static bool gen_vreplve(DisasContext *ctx, arg_vvr *a, int vece, int bit,
+static bool gen_vreplve(DisasContext *ctx, arg_vvr *a,
+                        uint32_t  oprsz, int vece, int bit,
                         void (*func)(TCGv_i64, TCGv_ptr, tcg_target_long))
 {
     TCGv_i64 t0 = tcg_temp_new_i64();
@@ -4153,85 +4154,103 @@ static bool gen_vreplve(DisasContext *ctx, arg_vvr *a, int vece, int bit,
 
     CHECK_VEC;
 
-    tcg_gen_andi_i64(t0, gpr_src(ctx, a->rk, EXT_NONE), (LSX_LEN/bit) -1);
+    tcg_gen_andi_i64(t0, gpr_src(ctx, a->rk, EXT_NONE), (LSX_LEN / bit) - 1);
     tcg_gen_shli_i64(t0, t0, vece);
     if (HOST_BIG_ENDIAN) {
-        tcg_gen_xori_i64(t0, t0, vece << ((LSX_LEN/bit) -1));
+        tcg_gen_xori_i64(t0, t0, vece << ((LSX_LEN / bit) - 1));
     }
 
     tcg_gen_trunc_i64_ptr(t1, t0);
     tcg_gen_add_ptr(t1, t1, cpu_env);
     func(t2, t1, vec_full_offset(a->vj));
-    tcg_gen_gvec_dup_i64(vece, vec_full_offset(a->vd), 16, ctx->vl/8, t2);
+    tcg_gen_gvec_dup_i64(vece, vec_full_offset(a->vd), 16, 16, t2);
+    if (oprsz == 32) {
+        func(t2, t1,  offsetof(CPULoongArchState, fpr[a->vj].vreg.Q(1)));
+        tcg_gen_gvec_dup_i64(vece,
+                             offsetof(CPULoongArchState, fpr[a->vd].vreg.Q(1)),
+                             16, 16, t2);
+    }
 
     return true;
 }
 
-TRANS(vreplve_b, gen_vreplve, MO_8,  8, tcg_gen_ld8u_i64)
-TRANS(vreplve_h, gen_vreplve, MO_16, 16, tcg_gen_ld16u_i64)
-TRANS(vreplve_w, gen_vreplve, MO_32, 32, tcg_gen_ld32u_i64)
-TRANS(vreplve_d, gen_vreplve, MO_64, 64, tcg_gen_ld_i64)
+TRANS(vreplve_b, gen_vreplve, 16, MO_8, 8, tcg_gen_ld8u_i64)
+TRANS(vreplve_h, gen_vreplve, 16, MO_16, 16, tcg_gen_ld16u_i64)
+TRANS(vreplve_w, gen_vreplve, 16, MO_32, 32, tcg_gen_ld32u_i64)
+TRANS(vreplve_d, gen_vreplve, 16, MO_64, 64, tcg_gen_ld_i64)
 
-static bool trans_vbsll_v(DisasContext *ctx, arg_vv_i *a)
+static bool do_vbsll_v(DisasContext *ctx, arg_vv_i *a, uint32_t oprsz)
 {
+    int i, max;
     int ofs;
-    TCGv_i64 desthigh, destlow, high, low;
+    TCGv_i64 desthigh[2], destlow[2], high[2], low[2];
 
     CHECK_VEC;
+    max = (oprsz == 16) ? 1 : 2;
+
+    for (i = 0; i < max; i++) {
+        desthigh[i] = tcg_temp_new_i64();
+        destlow[i] = tcg_temp_new_i64();
+        high[i] = tcg_temp_new_i64();
+        low[i] = tcg_temp_new_i64();
+
+        get_vreg64(low[i], a->vj, 2 * i);
+
+        ofs = ((a->imm) & 0xf) * 8;
+        if (ofs < 64) {
+            get_vreg64(high[i], a->vj, 2 * i + 1);
+            tcg_gen_extract2_i64(desthigh[i], low[i], high[i], 64 - ofs);
+            tcg_gen_shli_i64(destlow[i], low[i], ofs);
+        } else {
+            tcg_gen_shli_i64(desthigh[i], low[i], ofs - 64);
+            destlow[i] = tcg_constant_i64(0);
+        }
 
-    desthigh = tcg_temp_new_i64();
-    destlow = tcg_temp_new_i64();
-    high = tcg_temp_new_i64();
-    low = tcg_temp_new_i64();
-
-    get_vreg64(low, a->vj, 0);
-
-    ofs = ((a->imm) & 0xf) * 8;
-    if (ofs < 64) {
-        get_vreg64(high, a->vj, 1);
-        tcg_gen_extract2_i64(desthigh, low, high, 64 - ofs);
-        tcg_gen_shli_i64(destlow, low, ofs);
-    } else {
-        tcg_gen_shli_i64(desthigh, low, ofs - 64);
-        destlow = tcg_constant_i64(0);
+        set_vreg64(desthigh[i], a->vd, 2 * i + 1);
+        set_vreg64(destlow[i], a->vd, 2 * i);
     }
 
-    set_vreg64(desthigh, a->vd, 1);
-    set_vreg64(destlow, a->vd, 0);
-
     return true;
 }
 
-static bool trans_vbsrl_v(DisasContext *ctx, arg_vv_i *a)
+static bool do_vbsrl_v(DisasContext *ctx, arg_vv_i *a, uint32_t oprsz)
 {
-    TCGv_i64 desthigh, destlow, high, low;
+    int i, max;
+    TCGv_i64 desthigh[2], destlow[2], high[2], low[2];
     int ofs;
 
     CHECK_VEC;
 
-    desthigh = tcg_temp_new_i64();
-    destlow = tcg_temp_new_i64();
-    high = tcg_temp_new_i64();
-    low = tcg_temp_new_i64();
+    max = (oprsz == 16) ? 1 : 2;
 
-    get_vreg64(high, a->vj, 1);
+    for (i = 0; i < max; i++) {
+        desthigh[i] = tcg_temp_new_i64();
+        destlow[i] = tcg_temp_new_i64();
+        high[i] = tcg_temp_new_i64();
+        low[i] = tcg_temp_new_i64();
 
-    ofs = ((a->imm) & 0xf) * 8;
-    if (ofs < 64) {
-        get_vreg64(low, a->vj, 0);
-        tcg_gen_extract2_i64(destlow, low, high, ofs);
-        tcg_gen_shri_i64(desthigh, high, ofs);
-    } else {
-        tcg_gen_shri_i64(destlow, high, ofs - 64);
-        desthigh = tcg_constant_i64(0);
-    }
+        get_vreg64(high[i], a->vj, 2 * i + 1);
+
+        ofs = ((a->imm) & 0xf) * 8;
+        if (ofs < 64) {
+            get_vreg64(low[i], a->vj, 2 * i);
+            tcg_gen_extract2_i64(destlow[i], low[i], high[i], ofs);
+            tcg_gen_shri_i64(desthigh[i], high[i], ofs);
+        } else {
+            tcg_gen_shri_i64(destlow[i], high[i], ofs - 64);
+            desthigh[i] = tcg_constant_i64(0);
+        }
 
-    set_vreg64(desthigh, a->vd, 1);
-    set_vreg64(destlow, a->vd, 0);
+        set_vreg64(desthigh[i], a->vd, 2 * i + 1);
+        set_vreg64(destlow[i], a->vd, 2 * i);
+    }
 
     return true;
 }
 
+TRANS(vbsll_v, do_vbsll_v, 16)
+TRANS(vbsrl_v, do_vbsrl_v, 16)
+
 TRANS(vpackev_b, gen_vvv, 16, gen_helper_vpackev_b)
 TRANS(vpackev_h, gen_vvv, 16, gen_helper_vpackev_h)
 TRANS(vpackev_w, gen_vvv, 16, gen_helper_vpackev_w)
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
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index c457f9f66a..65faf9f7a7 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -3243,6 +3243,35 @@ SETALLNEZ(vsetallnez_h, MO_16)
 SETALLNEZ(vsetallnez_w, MO_32)
 SETALLNEZ(vsetallnez_d, MO_64)
 
+#define XVINSVE0(NAME, E, MASK)                           \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz, \
+                  uint32_t vd, uint32_t vj, uint32_t imm) \
+{                                                         \
+    VReg *Vd = &(env->fpr[vd].vreg);                      \
+    VReg *Vj = &(env->fpr[vj].vreg);                      \
+    Vd->E(imm & MASK) = Vj->E(0);                         \
+}
+
+XVINSVE0(xvinsve0_w, W, 0x7)
+XVINSVE0(xvinsve0_d, D, 0x3)
+
+#define XVPICKVE(NAME, E, BIT, MASK)                      \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz, \
+                  uint32_t vd, uint32_t vj, uint32_t imm) \
+{                                                         \
+    int i;                                                \
+    VReg *Vd = &(env->fpr[vd].vreg);                      \
+    VReg *Vj = &(env->fpr[vj].vreg);                      \
+                                                          \
+    Vd->E(0) = Vj->E(imm & MASK);                         \
+    for (i = 1; i < LASX_LEN / BIT; i++) {                \
+        Vd->E(i) = 0;                                     \
+    }                                                     \
+}
+
+XVPICKVE(xvpickve_w, W, 32, 0x7)
+XVPICKVE(xvpickve_d, D, 64, 0x3)
+
 #define VPACKEV(NAME, BIT, E)                            \
 void HELPER(NAME)(CPULoongArchState *env,                \
                   uint32_t vd, uint32_t vj, uint32_t vk) \
-- 
2.39.1


