Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CD279F831
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:35:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgc6I-0005xl-5Z; Wed, 13 Sep 2023 22:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qgc55-0003ON-4K
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:27:50 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qgc50-00056G-7K
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:27:46 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxJuiQbwJlwPgmAA--.16425S3;
 Thu, 14 Sep 2023 10:27:28 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxvdxmbwJlJ+UDAA--.7298S53; 
 Thu, 14 Sep 2023 10:27:27 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH v6 51/57] target/loongarch: Implement xvinsgr2vr xvpickve2gr
Date: Thu, 14 Sep 2023 10:26:39 +0800
Message-Id: <20230914022645.1151356-52-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230914022645.1151356-1-gaosong@loongson.cn>
References: <20230914022645.1151356-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxvdxmbwJlJ+UDAA--.7298S53
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
- XVINSGR2VR.{W/D};
- XVPICKVE2GR.{W/D}[U].

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/insns.decode               |   7 +
 target/loongarch/disas.c                    |  17 ++
 target/loongarch/translate.c                |  13 ++
 target/loongarch/insn_trans/trans_vec.c.inc | 208 ++++----------------
 4 files changed, 75 insertions(+), 170 deletions(-)

diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index ad6751fdfb..bb3bb447ae 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1976,6 +1976,13 @@ xvsetallnez_h    0111 01101001 11001 01101 ..... 00 ...   @cv
 xvsetallnez_w    0111 01101001 11001 01110 ..... 00 ...   @cv
 xvsetallnez_d    0111 01101001 11001 01111 ..... 00 ...   @cv
 
+xvinsgr2vr_w     0111 01101110 10111 10 ... ..... .....   @vr_ui3
+xvinsgr2vr_d     0111 01101110 10111 110 .. ..... .....   @vr_ui2
+xvpickve2gr_w    0111 01101110 11111 10 ... ..... .....   @rv_ui3
+xvpickve2gr_d    0111 01101110 11111 110 .. ..... .....   @rv_ui2
+xvpickve2gr_wu   0111 01101111 00111 10 ... ..... .....   @rv_ui3
+xvpickve2gr_du   0111 01101111 00111 110 .. ..... .....   @rv_ui2
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index abe113b150..04f9f9fa4b 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1738,6 +1738,16 @@ static void output_vv_x(DisasContext *ctx, arg_vv *a, const char *mnemonic)
     output(ctx, mnemonic, "x%d, x%d", a->vd, a->vj);
 }
 
+static void output_vr_i_x(DisasContext *ctx, arg_vr_i *a, const char *mnemonic)
+{
+    output(ctx, mnemonic, "x%d, r%d, 0x%x", a->vd, a->rj, a->imm);
+}
+
+static void output_rv_i_x(DisasContext *ctx, arg_rv_i *a, const char *mnemonic)
+{
+    output(ctx, mnemonic, "r%d, x%d, 0x%x", a->rd, a->vj, a->imm);
+}
+
 INSN_LASX(xvadd_b,           vvv)
 INSN_LASX(xvadd_h,           vvv)
 INSN_LASX(xvadd_w,           vvv)
@@ -2497,6 +2507,13 @@ INSN_LASX(xvsetallnez_h,     cv)
 INSN_LASX(xvsetallnez_w,     cv)
 INSN_LASX(xvsetallnez_d,     cv)
 
+INSN_LASX(xvinsgr2vr_w,      vr_i)
+INSN_LASX(xvinsgr2vr_d,      vr_i)
+INSN_LASX(xvpickve2gr_w,     rv_i)
+INSN_LASX(xvpickve2gr_d,     rv_i)
+INSN_LASX(xvpickve2gr_wu,    rv_i)
+INSN_LASX(xvpickve2gr_du,    rv_i)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index 10e2fe8ff6..4892834d0c 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -37,6 +37,19 @@ static inline int vec_full_offset(int regno)
     return  offsetof(CPULoongArchState, fpr[regno]);
 }
 
+static inline int vec_reg_offset(int regno, int index, MemOp mop)
+{
+    const uint8_t size = 1 << mop;
+    int offs = index * size;
+
+#if HOST_BIG_ENDIAN
+    if (size < 8 ) {
+        offs ^ = (8 - size);
+    }
+#endif
+    return offs + vec_full_offset(regno);
+}
+
 static inline void get_vreg64(TCGv_i64 dest, int regno, int index)
 {
     tcg_gen_ld_i64(dest, cpu_env,
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 0dec3dfffe..e1ba54075e 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -4829,209 +4829,77 @@ TRANS(xvsetallnez_h, LASX, gen_cx, gen_helper_vsetallnez_h)
 TRANS(xvsetallnez_w, LASX, gen_cx, gen_helper_vsetallnez_w)
 TRANS(xvsetallnez_d, LASX, gen_cx, gen_helper_vsetallnez_d)
 
-static bool trans_vinsgr2vr_b(DisasContext *ctx, arg_vr_i *a)
+static bool gen_g2v_vl(DisasContext *ctx, arg_vr_i *a, uint32_t oprsz, MemOp mop,
+                       void (*func)(TCGv, TCGv_ptr, tcg_target_long))
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
 
-    if (!avail_LSX(ctx)) {
-        return false;
-    }
-
-    if (!check_vec(ctx, 16)) {
-        return true;
-    }
-
-    tcg_gen_st8_i64(src, cpu_env,
-                    offsetof(CPULoongArchState, fpr[a->vd].vreg.B(a->imm)));
-    return true;
-}
-
-static bool trans_vinsgr2vr_h(DisasContext *ctx, arg_vr_i *a)
-{
-    TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
-
-    if (!avail_LSX(ctx)) {
-        return false;
-    }
-
-    if (!check_vec(ctx, 16)) {
-        return true;
-    }
-
-    tcg_gen_st16_i64(src, cpu_env,
-                    offsetof(CPULoongArchState, fpr[a->vd].vreg.H(a->imm)));
-    return true;
-}
-
-static bool trans_vinsgr2vr_w(DisasContext *ctx, arg_vr_i *a)
-{
-    TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
-
-    if (!avail_LSX(ctx)) {
-        return false;
-    }
-
-    if (!check_vec(ctx, 16)) {
+    if (!check_vec(ctx, oprsz)) {
         return true;
     }
 
-    tcg_gen_st32_i64(src, cpu_env,
-                     offsetof(CPULoongArchState, fpr[a->vd].vreg.W(a->imm)));
-    return true;
-}
-
-static bool trans_vinsgr2vr_d(DisasContext *ctx, arg_vr_i *a)
-{
-    TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
-
-    if (!avail_LSX(ctx)) {
-        return false;
-    }
+    func(src, cpu_env, vec_reg_offset(a->vd, a->imm, mop));
 
-    if (!check_vec(ctx, 16)) {
-        return true;
-    }
-
-    tcg_gen_st_i64(src, cpu_env,
-                   offsetof(CPULoongArchState, fpr[a->vd].vreg.D(a->imm)));
     return true;
 }
 
-static bool trans_vpickve2gr_b(DisasContext *ctx, arg_rv_i *a)
+static bool gen_g2v(DisasContext *ctx, arg_vr_i *a, MemOp mop,
+                    void (*func)(TCGv, TCGv_ptr, tcg_target_long))
 {
-    TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
-
-    if (!avail_LSX(ctx)) {
-        return false;
-    }
-
-    if (!check_vec(ctx, 16)) {
-        return true;
-    }
-
-    tcg_gen_ld8s_i64(dst, cpu_env,
-                     offsetof(CPULoongArchState, fpr[a->vj].vreg.B(a->imm)));
-    return true;
+    return gen_g2v_vl(ctx, a, 16, mop, func);
 }
 
-static bool trans_vpickve2gr_h(DisasContext *ctx, arg_rv_i *a)
+static bool gen_g2x(DisasContext *ctx, arg_vr_i *a, MemOp mop,
+                    void (*func)(TCGv, TCGv_ptr, tcg_target_long))
 {
-    TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
-
-    if (!avail_LSX(ctx)) {
-        return false;
-    }
-
-    if (!check_vec(ctx, 16)) {
-        return true;
-    }
-
-    tcg_gen_ld16s_i64(dst, cpu_env,
-                      offsetof(CPULoongArchState, fpr[a->vj].vreg.H(a->imm)));
-    return true;
+    return gen_g2v_vl(ctx, a, 32, mop, func);
 }
 
-static bool trans_vpickve2gr_w(DisasContext *ctx, arg_rv_i *a)
-{
-    TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
+TRANS(vinsgr2vr_b, LSX, gen_g2v, MO_8, tcg_gen_st8_i64)
+TRANS(vinsgr2vr_h, LSX, gen_g2v, MO_16, tcg_gen_st16_i64)
+TRANS(vinsgr2vr_w, LSX, gen_g2v, MO_32, tcg_gen_st32_i64)
+TRANS(vinsgr2vr_d, LSX, gen_g2v, MO_64, tcg_gen_st_i64)
+TRANS(xvinsgr2vr_w, LASX, gen_g2x, MO_32, tcg_gen_st32_i64)
+TRANS(xvinsgr2vr_d, LASX, gen_g2x, MO_64, tcg_gen_st_i64)
 
-    if (!avail_LSX(ctx)) {
-        return false;
-    }
-
-    if (!check_vec(ctx, 16)) {
-        return true;
-    }
-
-    tcg_gen_ld32s_i64(dst, cpu_env,
-                      offsetof(CPULoongArchState, fpr[a->vj].vreg.W(a->imm)));
-    return true;
-}
-
-static bool trans_vpickve2gr_d(DisasContext *ctx, arg_rv_i *a)
+static bool gen_v2g_vl(DisasContext *ctx, arg_rv_i *a, uint32_t oprsz, MemOp mop,
+                       void (*func)(TCGv, TCGv_ptr, tcg_target_long))
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
 
-    if (!avail_LSX(ctx)) {
-        return false;
-    }
-
-    if (!check_vec(ctx, 16)) {
+    if (!check_vec(ctx, oprsz)) {
         return true;
     }
 
-    tcg_gen_ld_i64(dst, cpu_env,
-                   offsetof(CPULoongArchState, fpr[a->vj].vreg.D(a->imm)));
-    return true;
-}
+    func(dst, cpu_env, vec_reg_offset(a->vj, a->imm, mop));
 
-static bool trans_vpickve2gr_bu(DisasContext *ctx, arg_rv_i *a)
-{
-    TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
-
-    if (!avail_LSX(ctx)) {
-        return false;
-    }
-
-    if (!check_vec(ctx, 16)) {
-        return true;
-    }
-
-    tcg_gen_ld8u_i64(dst, cpu_env,
-                     offsetof(CPULoongArchState, fpr[a->vj].vreg.B(a->imm)));
     return true;
 }
 
-static bool trans_vpickve2gr_hu(DisasContext *ctx, arg_rv_i *a)
+static bool gen_v2g(DisasContext *ctx, arg_rv_i *a, MemOp mop,
+                    void (*func)(TCGv, TCGv_ptr, tcg_target_long))
 {
-    TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
-
-    if (!avail_LSX(ctx)) {
-        return false;
-    }
-
-    if (!check_vec(ctx, 16)) {
-        return true;
-    }
-
-    tcg_gen_ld16u_i64(dst, cpu_env,
-                      offsetof(CPULoongArchState, fpr[a->vj].vreg.H(a->imm)));
-    return true;
+    return gen_v2g_vl(ctx, a, 16, mop, func);
 }
 
-static bool trans_vpickve2gr_wu(DisasContext *ctx, arg_rv_i *a)
+static bool gen_x2g(DisasContext *ctx, arg_rv_i *a, MemOp mop,
+                    void (*func)(TCGv, TCGv_ptr, tcg_target_long))
 {
-    TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
-
-    if (!avail_LSX(ctx)) {
-        return false;
-    }
-
-    if (!check_vec(ctx, 16)) {
-        return true;
-    }
-
-    tcg_gen_ld32u_i64(dst, cpu_env,
-                      offsetof(CPULoongArchState, fpr[a->vj].vreg.W(a->imm)));
-    return true;
+    return gen_v2g_vl(ctx, a, 32, mop, func);
 }
 
-static bool trans_vpickve2gr_du(DisasContext *ctx, arg_rv_i *a)
-{
-    TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
-
-    if (!avail_LSX(ctx)) {
-        return false;
-    }
-
-    if (!check_vec(ctx, 16)) {
-        return true;
-    }
-
-    tcg_gen_ld_i64(dst, cpu_env,
-                   offsetof(CPULoongArchState, fpr[a->vj].vreg.D(a->imm)));
-    return true;
-}
+TRANS(vpickve2gr_b, LSX, gen_v2g, MO_8, tcg_gen_ld8s_i64)
+TRANS(vpickve2gr_h, LSX, gen_v2g, MO_16, tcg_gen_ld16s_i64)
+TRANS(vpickve2gr_w, LSX, gen_v2g, MO_32, tcg_gen_ld32s_i64)
+TRANS(vpickve2gr_d, LSX, gen_v2g, MO_64, tcg_gen_ld_i64)
+TRANS(vpickve2gr_bu, LSX, gen_v2g, MO_8, tcg_gen_ld8u_i64)
+TRANS(vpickve2gr_hu, LSX, gen_v2g, MO_16, tcg_gen_ld16u_i64)
+TRANS(vpickve2gr_wu, LSX, gen_v2g, MO_32, tcg_gen_ld32u_i64)
+TRANS(vpickve2gr_du, LSX, gen_v2g, MO_64, tcg_gen_ld_i64)
+TRANS(xvpickve2gr_w, LASX, gen_x2g, MO_32, tcg_gen_ld32s_i64)
+TRANS(xvpickve2gr_d, LASX, gen_x2g, MO_64, tcg_gen_ld_i64)
+TRANS(xvpickve2gr_wu, LASX, gen_x2g, MO_32, tcg_gen_ld32u_i64)
+TRANS(xvpickve2gr_du, LASX, gen_x2g, MO_64, tcg_gen_ld_i64)
 
 static bool gvec_dup_vl(DisasContext *ctx, arg_vr *a,
                         uint32_t oprsz, MemOp mop)
-- 
2.39.1


