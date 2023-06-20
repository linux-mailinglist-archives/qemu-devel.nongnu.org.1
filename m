Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0EC736838
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:46:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXpW-0007YB-5z; Tue, 20 Jun 2023 05:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXpF-0007Dv-Kd
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:39:03 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXpB-0006QC-KG
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:39:01 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxGuqjc5Fk6CUHAA--.14776S3;
 Tue, 20 Jun 2023 17:38:43 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S47; 
 Tue, 20 Jun 2023 17:38:43 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 45/46] target/loongarch: Implement xvld xvst
Date: Tue, 20 Jun 2023 17:38:13 +0800
Message-Id: <20230620093814.123650-46-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S47
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
 target/loongarch/disas.c                     | 24 +++++
 target/loongarch/helper.h                    |  3 +
 target/loongarch/insn_trans/trans_lasx.c.inc | 97 ++++++++++++++++++++
 target/loongarch/insns.decode                | 25 +++++
 target/loongarch/lasx_helper.c               | 59 ++++++++++++
 5 files changed, 208 insertions(+)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 9af1c95641..4403669047 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1753,6 +1753,16 @@ static void output_xxr(DisasContext *ctx, arg_xxr *a, const char *mnemonic)
     output(ctx, mnemonic, "x%d, x%d, r%d", a->xd, a->xj, a->rk);
 }
 
+static void output_xrr(DisasContext *ctx, arg_xrr *a, const char *mnemonic)
+{
+    output(ctx, mnemonic, "x%d, r%d, r%d", a->xd, a->rj, a->rk);
+}
+
+static void output_xr_ii(DisasContext *ctx, arg_xr_ii *a, const char *mnemonic)
+{
+    output(ctx, mnemonic, "x%d, r%d, 0x%x, 0x%x", a->xd, a->rj, a->imm, a->imm2);
+}
+
 INSN_LASX(xvadd_b,           xxx)
 INSN_LASX(xvadd_h,           xxx)
 INSN_LASX(xvadd_w,           xxx)
@@ -2595,3 +2605,17 @@ INSN_LASX(xvextrins_d,       xx_i)
 INSN_LASX(xvextrins_w,       xx_i)
 INSN_LASX(xvextrins_h,       xx_i)
 INSN_LASX(xvextrins_b,       xx_i)
+
+INSN_LASX(xvld,              xr_i)
+INSN_LASX(xvst,              xr_i)
+INSN_LASX(xvldx,             xrr)
+INSN_LASX(xvstx,             xrr)
+
+INSN_LASX(xvldrepl_d,        xr_i)
+INSN_LASX(xvldrepl_w,        xr_i)
+INSN_LASX(xvldrepl_h,        xr_i)
+INSN_LASX(xvldrepl_b,        xr_i)
+INSN_LASX(xvstelm_d,         xr_ii)
+INSN_LASX(xvstelm_w,         xr_ii)
+INSN_LASX(xvstelm_h,         xr_ii)
+INSN_LASX(xvstelm_b,         xr_ii)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 1058a7de75..adeb181407 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -1285,3 +1285,6 @@ DEF_HELPER_4(xvextrins_d, void, env, i32, i32, i32)
 DEF_HELPER_4(xvextrins_w, void, env, i32, i32, i32)
 DEF_HELPER_4(xvextrins_h, void, env, i32, i32, i32)
 DEF_HELPER_4(xvextrins_b, void, env, i32, i32, i32)
+
+DEF_HELPER_3(xvld_b, void, env, i32, tl)
+DEF_HELPER_3(xvst_b, void, env, i32, tl)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 1344f75113..761f227c76 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -3104,3 +3104,100 @@ TRANS(xvextrins_b, gen_xx_i, gen_helper_xvextrins_b)
 TRANS(xvextrins_h, gen_xx_i, gen_helper_xvextrins_h)
 TRANS(xvextrins_w, gen_xx_i, gen_helper_xvextrins_w)
 TRANS(xvextrins_d, gen_xx_i, gen_helper_xvextrins_d)
+
+static bool gen_lasx_memory(DisasContext *ctx, arg_xr_i * a,
+                            void (*func)(TCGv_ptr, TCGv_i32, TCGv))
+{
+    TCGv_i32 xd = tcg_constant_i32(a->xd);
+    TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
+    TCGv temp = NULL;
+
+    CHECK_ASXE;
+
+    if (a->imm) {
+        temp = tcg_temp_new();
+        tcg_gen_addi_tl(temp, addr, a->imm);
+        addr = temp;
+    }
+
+    func(cpu_env, xd, addr);
+    return true;
+}
+
+TRANS(xvld, gen_lasx_memory, gen_helper_xvld_b)
+TRANS(xvst, gen_lasx_memory, gen_helper_xvst_b)
+
+static bool gen_lasx_memoryx(DisasContext *ctx, arg_xrr *a,
+                             void (*func)(TCGv_ptr, TCGv_i32, TCGv))
+{
+    TCGv_i32 xd = tcg_constant_i32(a->xd);
+    TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
+    TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
+    TCGv addr = tcg_temp_new();
+
+    CHECK_ASXE;
+
+    tcg_gen_add_tl(addr, src1, src2);
+    func(cpu_env, xd, addr);
+    return true;
+}
+
+TRANS(xvldx, gen_lasx_memoryx, gen_helper_xvld_b)
+TRANS(xvstx, gen_lasx_memoryx, gen_helper_xvst_b)
+
+#define XVLDREPL(NAME, MO)                                                  \
+static bool trans_## NAME(DisasContext *ctx, arg_xr_i * a)                  \
+{                                                                           \
+    TCGv addr, temp;                                                        \
+    TCGv_i64 val;                                                           \
+                                                                            \
+    CHECK_ASXE;                                                             \
+                                                                            \
+    addr = gpr_src(ctx, a->rj, EXT_NONE);                                   \
+    val = tcg_temp_new_i64();                                               \
+                                                                            \
+    if (a->imm) {                                                           \
+        temp = tcg_temp_new();                                              \
+        tcg_gen_addi_tl(temp, addr, a->imm);                                \
+        addr = temp;                                                        \
+    }                                                                       \
+                                                                            \
+    tcg_gen_qemu_ld_i64(val, addr, ctx->mem_idx, MO);                       \
+    tcg_gen_gvec_dup_i64(MO, vec_full_offset(a->xd), 32, ctx->vl / 8, val); \
+                                                                            \
+    return true;                                                            \
+}
+
+XVLDREPL(xvldrepl_b, MO_8)
+XVLDREPL(xvldrepl_h, MO_16)
+XVLDREPL(xvldrepl_w, MO_32)
+XVLDREPL(xvldrepl_d, MO_64)
+
+#define XVSTELM(NAME, MO, E)                                                 \
+static bool trans_## NAME(DisasContext *ctx, arg_xr_ii * a)                  \
+{                                                                            \
+    TCGv addr, temp;                                                         \
+    TCGv_i64 val;                                                            \
+                                                                             \
+    CHECK_ASXE;                                                              \
+                                                                             \
+    addr = gpr_src(ctx, a->rj, EXT_NONE);                                    \
+    val = tcg_temp_new_i64();                                                \
+                                                                             \
+    if (a->imm) {                                                            \
+        temp = tcg_temp_new();                                               \
+        tcg_gen_addi_tl(temp, addr, a->imm);                                 \
+        addr = temp;                                                         \
+    }                                                                        \
+                                                                             \
+    tcg_gen_ld_i64(val, cpu_env,                                             \
+                   offsetof(CPULoongArchState, fpr[a->xd].xreg.E(a->imm2))); \
+    tcg_gen_qemu_st_i64(val, addr, ctx->mem_idx, MO);                        \
+                                                                             \
+    return true;                                                             \
+}
+
+XVSTELM(xvstelm_b, MO_8, XB)
+XVSTELM(xvstelm_h, MO_16, XH)
+XVSTELM(xvstelm_w, MO_32, XW)
+XVSTELM(xvstelm_d, MO_64, XD)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 9c6a6037e9..b7940e4c23 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1312,6 +1312,8 @@ vstelm_b         0011 000110 .... ........ ..... .....    @vr_i8i4
 &xr_i         xd rj imm
 &rx_i         rd xj imm
 &xxr          xd xj rk
+&xrr          xd rj rk
+&xr_ii        xd rj imm imm2
 
 #
 # LASX Formats
@@ -1338,6 +1340,15 @@ vstelm_b         0011 000110 .... ........ ..... .....    @vr_i8i4
 @rx_ui3         .... ........ ..... .. imm:3 xj:5 rd:5    &rx_i
 @rx_ui2        .... ........ ..... ... imm:2 xj:5 rd:5    &rx_i
 @xxr                .... ........ ..... rk:5 xj:5 xd:5    &xxr
+@xr_i9             .... ........ . ......... rj:5 xd:5    &xr_i  imm=%i9s3
+@xr_i10             .... ........ .......... rj:5 xd:5    &xr_i  imm=%i10s2
+@xr_i11             .... ....... ........... rj:5 xd:5    &xr_i  imm=%i11s1
+@xr_i12                  .... ...... imm:s12 rj:5 xd:5    &xr_i
+@xr_i8i2       .... ........ imm2:2 ........ rj:5 xd:5    &xr_ii imm=%i8s3
+@xr_i8i3        .... ....... imm2:3 ........ rj:5 xd:5    &xr_ii imm=%i8s2
+@xr_i8i4         .... ...... imm2:4 ........ rj:5 xd:5    &xr_ii imm=%i8s1
+@xr_i8i5            .... ..... imm2:5 imm:s8 rj:5 xd:5    &xr_ii
+@xrr                .... ........ ..... rk:5 rj:5 xd:5    &xrr
 
 xvadd_b          0111 01000000 10100 ..... ..... .....    @xxx
 xvadd_h          0111 01000000 10101 ..... ..... .....    @xxx
@@ -2099,3 +2110,17 @@ xvextrins_d      0111 01111000 00 ........ ..... .....    @xx_ui8
 xvextrins_w      0111 01111000 01 ........ ..... .....    @xx_ui8
 xvextrins_h      0111 01111000 10 ........ ..... .....    @xx_ui8
 xvextrins_b      0111 01111000 11 ........ ..... .....    @xx_ui8
+
+xvld             0010 110010 ............ ..... .....     @xr_i12
+xvst             0010 110011 ............ ..... .....     @xr_i12
+xvldx            0011 10000100 10000 ..... ..... .....    @xrr
+xvstx            0011 10000100 11000 ..... ..... .....    @xrr
+
+xvldrepl_d       0011 00100001 0 ......... ..... .....    @xr_i9
+xvldrepl_w       0011 00100010 .......... ..... .....     @xr_i10
+xvldrepl_h       0011 0010010 ........... ..... .....     @xr_i11
+xvldrepl_b       0011 001010 ............ ..... .....     @xr_i12
+xvstelm_d        0011 00110001 .. ........ ..... .....    @xr_i8i2
+xvstelm_w        0011 0011001 ... ........ ..... .....    @xr_i8i3
+xvstelm_h        0011 001101 .... ........ ..... .....    @xr_i8i4
+xvstelm_b        0011 00111 ..... ........ ..... .....    @xr_i8i5
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index a0338dfa6d..16346f218c 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -12,6 +12,9 @@
 #include "fpu/softfloat.h"
 #include "internals.h"
 #include "vec.h"
+#include "tcg/tcg.h"
+#include "exec/cpu_ldst.h"
+#include "tcg/tcg-ldst.h"
 
 #define XDO_ODD_EVEN(NAME, BIT, E1, E2, DO_OP)                       \
 void HELPER(NAME)(CPULoongArchState *env,                            \
@@ -3160,3 +3163,59 @@ XVEXTRINS(xvextrins_b, 8, XB, 0xf)
 XVEXTRINS(xvextrins_h, 16, XH, 0x7)
 XVEXTRINS(xvextrins_w, 32, XW, 0x3)
 XVEXTRINS(xvextrins_d, 64, XD, 0x1)
+
+void helper_xvld_b(CPULoongArchState *env, uint32_t xd, target_ulong addr)
+{
+    int i;
+    XReg *Xd = &(env->fpr[xd].xreg);
+#if !defined(CONFIG_USER_ONLY)
+    MemOpIdx oi = make_memop_idx(MO_TE | MO_UNALN, cpu_mmu_index(env, false));
+
+    for (i = 0; i < LASX_LEN / 8; i++) {
+        Xd->XB(i)  = helper_ldub_mmu(env, addr + i, oi, GETPC());
+    }
+#else
+    for (i = 0; i < LASX_LEN / 8; i++) {
+        Xd->XB(i)  = cpu_ldub_data(env, addr + i);
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
+void helper_xvst_b(CPULoongArchState *env, uint32_t xd, target_ulong addr)
+{
+    int i;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    int mmu_idx = cpu_mmu_index(env, false);
+
+    ensure_lasx_writable_pages(env, addr, mmu_idx, GETPC());
+#if !defined(CONFIG_USER_ONLY)
+    MemOpIdx oi = make_memop_idx(MO_TE | MO_UNALN, mmu_idx);
+    for (i = 0; i < LASX_LEN / 8; i++) {
+        helper_stb_mmu(env, addr + i, Xd->XB(i),  oi, GETPC());
+    }
+#else
+    for (i = 0; i < LASX_LEN / 8; i++) {
+        cpu_stb_data(env, addr + i, Xd->XB(i));
+    }
+#endif
+}
-- 
2.39.1


