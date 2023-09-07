Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E75E27970DB
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 10:39:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeARy-0005f5-Pl; Thu, 07 Sep 2023 04:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qeARi-0004p8-LJ
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:33:04 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qeARf-0002Sc-LF
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:33:02 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxBfGvivlkczkhAA--.910S3;
 Thu, 07 Sep 2023 16:32:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bxxsx+ivlk8FVwAA--.49124S57; 
 Thu, 07 Sep 2023 16:32:46 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH RESEND v5 55/57] target/loongarch: Implement xvld xvst
Date: Thu,  7 Sep 2023 16:31:56 +0800
Message-Id: <20230907083158.3975132-56-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230907083158.3975132-1-gaosong@loongson.cn>
References: <20230907083158.3975132-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxxsx+ivlk8FVwAA--.49124S57
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
- XVLD[X], XVST[X];
- XVLDREPL.{B/H/W/D};
- XVSTELM.{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/insns.decode               |  18 +++
 target/loongarch/disas.c                    |  24 ++++
 target/loongarch/insn_trans/trans_vec.c.inc | 143 ++++++++++++++++++--
 3 files changed, 175 insertions(+), 10 deletions(-)

diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 64b67ee9ac..64b308f9fb 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -550,6 +550,10 @@ dbcl             0000 00000010 10101 ...............      @i15
 @vr_i8i2      .... ........ imm2:2 ........ rj:5 vd:5    &vr_ii imm=%i8s2
 @vr_i8i3       .... ....... imm2:3 ........ rj:5 vd:5    &vr_ii imm=%i8s1
 @vr_i8i4          .... ...... imm2:4 imm:s8 rj:5 vd:5    &vr_ii
+@vr_i8i2x     .... ........ imm2:2 ........ rj:5 vd:5    &vr_ii imm=%i8s3
+@vr_i8i3x      .... ....... imm2:3 ........ rj:5 vd:5    &vr_ii imm=%i8s2
+@vr_i8i4x       .... ...... imm2:4 ........ rj:5 vd:5    &vr_ii imm=%i8s1
+@vr_i8i5x          .... ..... imm2:5 imm:s8 rj:5 vd:5    &vr_ii
 @vrr               .... ........ ..... rk:5 rj:5 vd:5    &vrr
 @v_i13                   .... ........ .. imm:13 vd:5    &v_i
 
@@ -2060,3 +2064,17 @@ xvextrins_d      0111 01111000 00 ........ ..... .....    @vv_ui8
 xvextrins_w      0111 01111000 01 ........ ..... .....    @vv_ui8
 xvextrins_h      0111 01111000 10 ........ ..... .....    @vv_ui8
 xvextrins_b      0111 01111000 11 ........ ..... .....    @vv_ui8
+
+xvld             0010 110010 ............ ..... .....     @vr_i12
+xvst             0010 110011 ............ ..... .....     @vr_i12
+xvldx            0011 10000100 10000 ..... ..... .....    @vrr
+xvstx            0011 10000100 11000 ..... ..... .....    @vrr
+
+xvldrepl_d       0011 00100001 0 ......... ..... .....    @vr_i9
+xvldrepl_w       0011 00100010 .......... ..... .....     @vr_i10
+xvldrepl_h       0011 0010010 ........... ..... .....     @vr_i11
+xvldrepl_b       0011 001010 ............ ..... .....     @vr_i12
+xvstelm_d        0011 00110001 .. ........ ..... .....    @vr_i8i2x
+xvstelm_w        0011 0011001 ... ........ ..... .....    @vr_i8i3x
+xvstelm_h        0011 001101 .... ........ ..... .....    @vr_i8i4x
+xvstelm_b        0011 00111 ..... ........ ..... .....    @vr_i8i5x
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 1ec8e21e01..c8a29eac2b 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1753,6 +1753,16 @@ static void output_vvr_x(DisasContext *ctx, arg_vvr *a, const char *mnemonic)
     output(ctx, mnemonic, "x%d, x%d, r%d", a->vd, a->vj, a->rk);
 }
 
+static void output_vrr_x(DisasContext *ctx, arg_vrr *a, const char *mnemonic)
+{
+    output(ctx, mnemonic, "x%d, r%d, r%d", a->vd, a->rj, a->rk);
+}
+
+static void output_vr_ii_x(DisasContext *ctx, arg_vr_ii *a, const char *mnemonic)
+{
+    output(ctx, mnemonic, "x%d, r%d, 0x%x, 0x%x", a->vd, a->rj, a->imm, a->imm2);
+}
+
 INSN_LASX(xvadd_b,           vvv)
 INSN_LASX(xvadd_h,           vvv)
 INSN_LASX(xvadd_w,           vvv)
@@ -2595,3 +2605,17 @@ INSN_LASX(xvextrins_d,       vv_i)
 INSN_LASX(xvextrins_w,       vv_i)
 INSN_LASX(xvextrins_h,       vv_i)
 INSN_LASX(xvextrins_b,       vv_i)
+
+INSN_LASX(xvld,              vr_i)
+INSN_LASX(xvst,              vr_i)
+INSN_LASX(xvldx,             vrr)
+INSN_LASX(xvstx,             vrr)
+
+INSN_LASX(xvldrepl_d,        vr_i)
+INSN_LASX(xvldrepl_w,        vr_i)
+INSN_LASX(xvldrepl_h,        vr_i)
+INSN_LASX(xvldrepl_b,        vr_i)
+INSN_LASX(xvstelm_d,         vr_ii)
+INSN_LASX(xvstelm_w,         vr_ii)
+INSN_LASX(xvstelm_h,         vr_ii)
+INSN_LASX(xvstelm_b,         vr_ii)
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 767fc06f47..f27c8b3508 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -5904,22 +5904,57 @@ static bool trans_## NAME (DisasContext *ctx, arg_vr_i *a)                \
     return true;                                                          \
 }
 
-VLDREPL(vldrepl_b, MO_8)
-VLDREPL(vldrepl_h, MO_16)
-VLDREPL(vldrepl_w, MO_32)
-VLDREPL(vldrepl_d, MO_64)
+static bool do_vldrepl_vl(DisasContext *ctx, arg_vr_i *a,
+                          uint32_t oprsz, MemOp mop)
+{
+    TCGv addr;
+    TCGv_i64 val;
+
+    addr = gpr_src(ctx, a->rj, EXT_NONE);
+    val = tcg_temp_new_i64();
+
+    addr = make_address_i(ctx, addr, a->imm);
+
+    tcg_gen_qemu_ld_i64(val, addr, ctx->mem_idx, mop);
+    tcg_gen_gvec_dup_i64(mop, vec_full_offset(a->vd), oprsz, ctx->vl / 8, val);
+
+    return true;
+}
+
+static bool do_vldrepl(DisasContext *ctx, arg_vr_i *a, MemOp mop)
+{
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
+    return do_vldrepl_vl(ctx, a, 16, mop);
+}
+
+static bool do_xvldrepl(DisasContext *ctx, arg_vr_i *a, MemOp mop)
+{
+    if (!check_vec(ctx, 32)) {
+        return true;
+    }
+
+    return do_vldrepl_vl(ctx, a, 32, mop);
+}
+
+TRANS(vldrepl_b, LSX, do_vldrepl, MO_8)
+TRANS(vldrepl_h, LSX, do_vldrepl, MO_16)
+TRANS(vldrepl_w, LSX, do_vldrepl, MO_32)
+TRANS(vldrepl_d, LSX, do_vldrepl, MO_64)
+TRANS(xvldrepl_b, LASX, do_xvldrepl, MO_8)
+TRANS(xvldrepl_h, LASX, do_xvldrepl, MO_16)
+TRANS(xvldrepl_w, LASX, do_xvldrepl, MO_32)
+TRANS(xvldrepl_d, LASX, do_xvldrepl, MO_64)
 
 #define VSTELM(NAME, MO, E)                                                  \
-static bool trans_## NAME (DisasContext *ctx, arg_vr_ii *a)                  \
+static bool do_## NAME (DisasContext *ctx, arg_vr_ii *a, uint32_t oprsz)     \
 {                                                                            \
     TCGv addr;                                                               \
     TCGv_i64 val;                                                            \
                                                                              \
-    if (!avail_LSX(ctx)) {                                                   \
-        return false;                                                        \
-    }                                                                        \
-                                                                             \
-    if (!check_vec(ctx, 16)) {                                               \
+    if (!check_vec(ctx, oprsz)) {                                            \
         return true;                                                         \
     }                                                                        \
                                                                              \
@@ -5939,3 +5974,91 @@ VSTELM(vstelm_b, MO_8, B)
 VSTELM(vstelm_h, MO_16, H)
 VSTELM(vstelm_w, MO_32, W)
 VSTELM(vstelm_d, MO_64, D)
+VSTELM(xvstelm_b, MO_8, B)
+VSTELM(xvstelm_h, MO_16, H)
+VSTELM(xvstelm_w, MO_32, W)
+VSTELM(xvstelm_d, MO_64, D)
+
+TRANS(vstelm_b, LSX, do_vstelm_b, 16)
+TRANS(vstelm_h, LSX, do_vstelm_h, 16)
+TRANS(vstelm_w, LSX, do_vstelm_w, 16)
+TRANS(vstelm_d, LSX, do_vstelm_d, 16)
+TRANS(xvstelm_b, LASX, do_xvstelm_b, 32)
+TRANS(xvstelm_h, LASX, do_xvstelm_h, 32)
+TRANS(xvstelm_w, LASX, do_xvstelm_w, 32)
+TRANS(xvstelm_d, LASX, do_xvstelm_d, 32)
+
+static bool gen_lasx_memory(DisasContext *ctx, arg_vr_i *a,
+                            void (*func)(DisasContext *, int, TCGv))
+{
+    TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
+    TCGv temp = NULL;
+
+    if (!check_vec(ctx, 32)) {
+        return true;
+    }
+
+    if (a->imm) {
+        temp = tcg_temp_new();
+        tcg_gen_addi_tl(temp, addr, a->imm);
+        addr = temp;
+    }
+
+    func(ctx, a->vd, addr);
+    return true;
+}
+
+static void gen_xvld(DisasContext *ctx, int vreg, TCGv addr)
+{
+    int i;
+    TCGv temp = tcg_temp_new();
+    TCGv dest = tcg_temp_new();
+
+    tcg_gen_qemu_ld_i64(dest, addr, ctx->mem_idx, MO_TEUQ);
+    set_vreg64(dest, vreg, 0);
+
+    for (i = 1; i < 4; i++) {
+        tcg_gen_addi_tl(temp, addr, 8 * i);
+        tcg_gen_qemu_ld_i64(dest, temp, ctx->mem_idx, MO_TEUQ);
+        set_vreg64(dest, vreg, i);
+    }
+}
+
+static void gen_xvst(DisasContext * ctx, int vreg, TCGv addr)
+{
+    int i;
+    TCGv temp = tcg_temp_new();
+    TCGv dest = tcg_temp_new();
+
+    get_vreg64(dest, vreg, 0);
+    tcg_gen_qemu_st_i64(dest, addr, ctx->mem_idx, MO_TEUQ);
+
+    for (i = 1; i < 4; i++) {
+        tcg_gen_addi_tl(temp, addr, 8 * i);
+        get_vreg64(dest, vreg, i);
+        tcg_gen_qemu_st_i64(dest, temp, ctx->mem_idx, MO_TEUQ);
+    }
+}
+
+TRANS(xvld, LASX, gen_lasx_memory, gen_xvld)
+TRANS(xvst, LASX, gen_lasx_memory, gen_xvst)
+
+static bool gen_lasx_memoryx(DisasContext *ctx, arg_vrr *a,
+                             void (*func)(DisasContext*, int, TCGv))
+{
+    TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
+    TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
+    TCGv addr = tcg_temp_new();
+
+    if (!check_vec(ctx, 32)) {
+        return true;
+    }
+
+    tcg_gen_add_tl(addr, src1, src2);
+    func(ctx, a->vd, addr);
+
+    return true;
+}
+
+TRANS(xvldx, LASX, gen_lasx_memoryx, gen_xvld)
+TRANS(xvstx, LASX, gen_lasx_memoryx, gen_xvst)
-- 
2.39.1


