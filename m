Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E0D743680
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:07:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF92o-0008LY-3E; Fri, 30 Jun 2023 03:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qF92k-0008J9-6l
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:50 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qF92h-00084y-KO
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:49 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxxvBmi55ktjQEAA--.6758S3;
 Fri, 30 Jun 2023 15:59:34 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxjiNIi55kExQTAA--.24469S47; 
 Fri, 30 Jun 2023 15:59:34 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 45/46] target/loongarch: Implement xvld xvst
Date: Fri, 30 Jun 2023 15:59:03 +0800
Message-Id: <20230630075904.45940-46-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230630075904.45940-1-gaosong@loongson.cn>
References: <20230630075904.45940-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjiNIi55kExQTAA--.24469S47
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
- XVLD[X], XVST[X];
- XVLDREPL.{B/H/W/D};
- XVSTELM.{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     | 24 ++++++++
 target/loongarch/helper.h                    |  3 +
 target/loongarch/insn_trans/trans_lasx.c.inc | 49 ++++++++++++++++
 target/loongarch/insn_trans/trans_lsx.c.inc  | 54 +++++++++---------
 target/loongarch/insns.decode                | 18 ++++++
 target/loongarch/vec_helper.c                | 59 ++++++++++++++++++++
 6 files changed, 180 insertions(+), 27 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index a518c59772..e5fb362d7f 100644
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
@@ -2596,3 +2606,17 @@ INSN_LASX(xvextrins_d,       vv_i)
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
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 3c969c9c9b..d4b96d4db3 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -717,3 +717,6 @@ DEF_HELPER_5(vextrins_b, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vextrins_h, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vextrins_w, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vextrins_d, void, env, i32, i32, i32, i32)
+
+DEF_HELPER_3(xvld_b, void, env, i32, tl)
+DEF_HELPER_3(xvst_b, void, env, i32, tl)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index b8d9b42070..c305c0feac 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -983,3 +983,52 @@ TRANS(xvextrins_b, gen_vv_i, 32, gen_helper_vextrins_b)
 TRANS(xvextrins_h, gen_vv_i, 32, gen_helper_vextrins_h)
 TRANS(xvextrins_w, gen_vv_i, 32, gen_helper_vextrins_w)
 TRANS(xvextrins_d, gen_vv_i, 32, gen_helper_vextrins_d)
+
+static bool gen_lasx_memory(DisasContext *ctx, arg_vr_i * a,
+                            void (*func)(TCGv_ptr, TCGv_i32, TCGv))
+{
+    TCGv_i32 vd = tcg_constant_i32(a->vd);
+    TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
+    TCGv temp = NULL;
+
+    CHECK_VEC;
+
+    if (a->imm) {
+        temp = tcg_temp_new();
+        tcg_gen_addi_tl(temp, addr, a->imm);
+        addr = temp;
+    }
+
+    func(cpu_env, vd, addr);
+    return true;
+}
+
+TRANS(xvld, gen_lasx_memory, gen_helper_xvld_b)
+TRANS(xvst, gen_lasx_memory, gen_helper_xvst_b)
+
+static bool gen_lasx_memoryx(DisasContext *ctx, arg_vrr *a,
+                             void (*func)(TCGv_ptr, TCGv_i32, TCGv))
+{
+    TCGv_i32 vd = tcg_constant_i32(a->vd);
+    TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
+    TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
+    TCGv addr = tcg_temp_new();
+
+    CHECK_VEC;
+
+    tcg_gen_add_tl(addr, src1, src2);
+    func(cpu_env, vd, addr);
+    return true;
+}
+
+TRANS(xvldx, gen_lasx_memoryx, gen_helper_xvld_b)
+TRANS(xvstx, gen_lasx_memoryx, gen_helper_xvst_b)
+
+TRANS(xvldrepl_b, do_vldrepl, 32, MO_8)
+TRANS(xvldrepl_h, do_vldrepl, 32, MO_16)
+TRANS(xvldrepl_w, do_vldrepl, 32, MO_32)
+TRANS(xvldrepl_d, do_vldrepl, 32, MO_64)
+VSTELM(xvstelm_b, MO_8, B)
+VSTELM(xvstelm_h, MO_16, H)
+VSTELM(xvstelm_w, MO_32, W)
+VSTELM(xvstelm_d, MO_64, D)
diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index 9ae6ca60bf..e965147859 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_lsx.c.inc
@@ -4396,33 +4396,33 @@ static bool trans_vstx(DisasContext *ctx, arg_vrr *a)
     return true;
 }
 
-#define VLDREPL(NAME, MO)                                                 \
-static bool trans_## NAME (DisasContext *ctx, arg_vr_i *a)                \
-{                                                                         \
-    TCGv addr, temp;                                                      \
-    TCGv_i64 val;                                                         \
-                                                                          \
-    CHECK_VEC;                                                            \
-                                                                          \
-    addr = gpr_src(ctx, a->rj, EXT_NONE);                                 \
-    val = tcg_temp_new_i64();                                             \
-                                                                          \
-    if (a->imm) {                                                         \
-        temp = tcg_temp_new();                                            \
-        tcg_gen_addi_tl(temp, addr, a->imm);                              \
-        addr = temp;                                                      \
-    }                                                                     \
-                                                                          \
-    tcg_gen_qemu_ld_i64(val, addr, ctx->mem_idx, MO);                     \
-    tcg_gen_gvec_dup_i64(MO, vec_full_offset(a->vd), 16, ctx->vl/8, val); \
-                                                                          \
-    return true;                                                          \
-}
-
-VLDREPL(vldrepl_b, MO_8)
-VLDREPL(vldrepl_h, MO_16)
-VLDREPL(vldrepl_w, MO_32)
-VLDREPL(vldrepl_d, MO_64)
+static bool do_vldrepl(DisasContext *ctx, arg_vr_i * a,
+                       uint32_t oprsz, MemOp mop)
+{
+    TCGv addr, temp;
+    TCGv_i64 val;
+
+    CHECK_VEC;
+
+    addr = gpr_src(ctx, a->rj, EXT_NONE);
+    val = tcg_temp_new_i64();
+
+    if (a->imm) {
+        temp = tcg_temp_new();
+        tcg_gen_addi_tl(temp, addr, a->imm);
+        addr = temp;
+    }
+
+    tcg_gen_qemu_ld_i64(val, addr, ctx->mem_idx, mop);
+    tcg_gen_gvec_dup_i64(mop, vec_full_offset(a->vd), oprsz, ctx->vl / 8, val);
+
+    return true;
+}
+
+TRANS(vldrepl_b, do_vldrepl, 16, MO_8)
+TRANS(vldrepl_h, do_vldrepl, 16, MO_16)
+TRANS(vldrepl_w, do_vldrepl, 16, MO_32)
+TRANS(vldrepl_d, do_vldrepl, 16, MO_64)
 
 #define VSTELM(NAME, MO, E)                                                  \
 static bool trans_## NAME (DisasContext *ctx, arg_vr_ii *a)                  \
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
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 65e83062c1..6138860288 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -3604,3 +3604,62 @@ VEXTRINS(vextrins_b, 8, B, 0xf)
 VEXTRINS(vextrins_h, 16, H, 0x7)
 VEXTRINS(vextrins_w, 32, W, 0x3)
 VEXTRINS(vextrins_d, 64, D, 0x1)
+
+#include "exec/cpu_ldst.h"
+#include "tcg/tcg-ldst.h"
+
+void helper_xvld_b(CPULoongArchState *env, uint32_t vd, target_ulong addr)
+{
+    int i;
+    VReg *Vd = &(env->fpr[vd].vreg);
+#if !defined(CONFIG_USER_ONLY)
+    MemOpIdx oi = make_memop_idx(MO_TE | MO_UNALN, cpu_mmu_index(env, false));
+
+    for (i = 0; i < LASX_LEN / 8; i++) {
+        Vd->B(i)  = helper_ldub_mmu(env, addr + i, oi, GETPC());
+    }
+#else
+    for (i = 0; i < LASX_LEN / 8; i++) {
+        Vd->B(i)  = cpu_ldub_data(env, addr + i);
+    }
+#endif
+}
+
+#define LASX_PAGESPAN(x) \
+        ((((x) & ~TARGET_PAGE_MASK) + (LASX_LEN / 8) - 1) >= TARGET_PAGE_SIZE)
+
+static inline void ensure_lasx_writable_pages(CPULoongArchState *env,
+                                             target_ulong addr,
+                                             int mmu_idx,
+                                             uintptr_t retaddr)
+{
+#ifndef CONFIG_USER_ONLY
+    /* FIXME: Probe the actual accesses (pass and use a size) */
+    if (unlikely(LASX_PAGESPAN(addr))) {
+        /* first page */
+        probe_write(env, addr, 0, mmu_idx, retaddr);
+        /* second page */
+        addr = (addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+        probe_write(env, addr, 0, mmu_idx, retaddr);
+    }
+#endif
+}
+
+void helper_xvst_b(CPULoongArchState *env, uint32_t vd, target_ulong addr)
+{
+    int i;
+    VReg *Vd = &(env->fpr[vd].vreg);
+    int mmu_idx = cpu_mmu_index(env, false);
+
+    ensure_lasx_writable_pages(env, addr, mmu_idx, GETPC());
+#if !defined(CONFIG_USER_ONLY)
+    MemOpIdx oi = make_memop_idx(MO_TE | MO_UNALN, mmu_idx);
+    for (i = 0; i < LASX_LEN / 8; i++) {
+        helper_stb_mmu(env, addr + i, Vd->B(i),  oi, GETPC());
+    }
+#else
+    for (i = 0; i < LASX_LEN / 8; i++) {
+        cpu_stb_data(env, addr + i, Vd->B(i));
+    }
+#endif
+}
-- 
2.39.1


