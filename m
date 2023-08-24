Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2818B786BB4
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:27:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6bV-0003HO-9r; Thu, 24 Aug 2023 05:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qZ6bR-0002wH-On
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:26:09 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qZ6bO-0004D7-2u
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:26:09 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxyerCIedkYXkbAA--.46669S3;
 Thu, 24 Aug 2023 17:24:18 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxJ826IedkJjhiAA--.40637S16; 
 Thu, 24 Aug 2023 17:24:18 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, richard.henderson@linaro.org, Jiajie Chen <c@jia.je>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/31] target/loongarch: Extract make_address_i() helper
Date: Thu, 24 Aug 2023 17:23:52 +0800
Message-Id: <20230824092409.1492470-15-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230824092409.1492470-1-gaosong@loongson.cn>
References: <20230824092409.1492470-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxJ826IedkJjhiAA--.40637S16
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

From: Jiajie Chen <c@jia.je>

Signed-off-by: Jiajie Chen <c@jia.je>
Co-authored-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230822032724.1353391-6-gaosong@loongson.cn>
[PMD: Extract helper from bigger patch]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230822071405.35386-7-philmd@linaro.org>
---
 .../loongarch/insn_trans/trans_atomic.c.inc   |  5 +--
 .../loongarch/insn_trans/trans_branch.c.inc   |  3 +-
 .../loongarch/insn_trans/trans_fmemory.c.inc  | 12 ++-----
 target/loongarch/insn_trans/trans_lsx.c.inc   | 32 +++++--------------
 .../loongarch/insn_trans/trans_memory.c.inc   | 28 +++++-----------
 target/loongarch/translate.c                  |  6 ++++
 6 files changed, 29 insertions(+), 57 deletions(-)

diff --git a/target/loongarch/insn_trans/trans_atomic.c.inc b/target/loongarch/insn_trans/trans_atomic.c.inc
index 612709f2a7..fbc081448d 100644
--- a/target/loongarch/insn_trans/trans_atomic.c.inc
+++ b/target/loongarch/insn_trans/trans_atomic.c.inc
@@ -7,9 +7,8 @@ static bool gen_ll(DisasContext *ctx, arg_rr_i *a, MemOp mop)
 {
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
-    TCGv t0 = tcg_temp_new();
+    TCGv t0 = make_address_i(ctx, src1, a->imm);
 
-    tcg_gen_addi_tl(t0, src1, a->imm);
     tcg_gen_qemu_ld_i64(dest, t0, ctx->mem_idx, mop);
     tcg_gen_st_tl(t0, cpu_env, offsetof(CPULoongArchState, lladdr));
     tcg_gen_st_tl(dest, cpu_env, offsetof(CPULoongArchState, llval));
@@ -62,6 +61,8 @@ static bool gen_am(DisasContext *ctx, arg_rrr *a,
         return false;
     }
 
+    addr = make_address_i(ctx, addr, 0);
+
     func(dest, addr, val, ctx->mem_idx, mop);
     gen_set_gpr(a->rd, dest, EXT_NONE);
 
diff --git a/target/loongarch/insn_trans/trans_branch.c.inc b/target/loongarch/insn_trans/trans_branch.c.inc
index a860f7e733..3ad34bcc05 100644
--- a/target/loongarch/insn_trans/trans_branch.c.inc
+++ b/target/loongarch/insn_trans/trans_branch.c.inc
@@ -23,7 +23,8 @@ static bool trans_jirl(DisasContext *ctx, arg_jirl *a)
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
 
-    tcg_gen_addi_tl(cpu_pc, src1, a->imm);
+    TCGv addr = make_address_i(ctx, src1, a->imm);
+    tcg_gen_mov_tl(cpu_pc, addr);
     tcg_gen_movi_tl(dest, ctx->base.pc_next + 4);
     gen_set_gpr(a->rd, dest, EXT_NONE);
     tcg_gen_lookup_and_goto_ptr();
diff --git a/target/loongarch/insn_trans/trans_fmemory.c.inc b/target/loongarch/insn_trans/trans_fmemory.c.inc
index 88ad209338..bd3aba2c49 100644
--- a/target/loongarch/insn_trans/trans_fmemory.c.inc
+++ b/target/loongarch/insn_trans/trans_fmemory.c.inc
@@ -17,11 +17,7 @@ static bool gen_fload_i(DisasContext *ctx, arg_fr_i *a, MemOp mop)
 
     CHECK_FPE;
 
-    if (a->imm) {
-        TCGv temp = tcg_temp_new();
-        tcg_gen_addi_tl(temp, addr, a->imm);
-        addr = temp;
-    }
+    addr = make_address_i(ctx, addr, a->imm);
 
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
@@ -37,11 +33,7 @@ static bool gen_fstore_i(DisasContext *ctx, arg_fr_i *a, MemOp mop)
 
     CHECK_FPE;
 
-    if (a->imm) {
-        TCGv temp = tcg_temp_new();
-        tcg_gen_addi_tl(temp, addr, a->imm);
-        addr = temp;
-    }
+    addr = make_address_i(ctx, addr, a->imm);
 
     tcg_gen_qemu_st_tl(src, addr, ctx->mem_idx, mop);
 
diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index 875cb7d51d..50153d6d0b 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_lsx.c.inc
@@ -4255,7 +4255,7 @@ TRANS(vextrins_d, gen_vv_i, gen_helper_vextrins_d)
 
 static bool trans_vld(DisasContext *ctx, arg_vr_i *a)
 {
-    TCGv addr, temp;
+    TCGv addr;
     TCGv_i64 rl, rh;
     TCGv_i128 val;
 
@@ -4266,11 +4266,7 @@ static bool trans_vld(DisasContext *ctx, arg_vr_i *a)
     rl = tcg_temp_new_i64();
     rh = tcg_temp_new_i64();
 
-    if (a->imm) {
-        temp = tcg_temp_new();
-        tcg_gen_addi_tl(temp, addr, a->imm);
-        addr = temp;
-    }
+    addr = make_address_i(ctx, addr, a->imm);
 
     tcg_gen_qemu_ld_i128(val, addr, ctx->mem_idx, MO_128 | MO_TE);
     tcg_gen_extr_i128_i64(rl, rh, val);
@@ -4282,7 +4278,7 @@ static bool trans_vld(DisasContext *ctx, arg_vr_i *a)
 
 static bool trans_vst(DisasContext *ctx, arg_vr_i *a)
 {
-    TCGv addr, temp;
+    TCGv addr;
     TCGv_i128 val;
     TCGv_i64 ah, al;
 
@@ -4293,11 +4289,7 @@ static bool trans_vst(DisasContext *ctx, arg_vr_i *a)
     ah = tcg_temp_new_i64();
     al = tcg_temp_new_i64();
 
-    if (a->imm) {
-        temp = tcg_temp_new();
-        tcg_gen_addi_tl(temp, addr, a->imm);
-        addr = temp;
-    }
+    addr = make_address_i(ctx, addr, a->imm);
 
     get_vreg64(ah, a->vd, 1);
     get_vreg64(al, a->vd, 0);
@@ -4356,7 +4348,7 @@ static bool trans_vstx(DisasContext *ctx, arg_vrr *a)
 #define VLDREPL(NAME, MO)                                                 \
 static bool trans_## NAME (DisasContext *ctx, arg_vr_i *a)                \
 {                                                                         \
-    TCGv addr, temp;                                                      \
+    TCGv addr;                                                            \
     TCGv_i64 val;                                                         \
                                                                           \
     CHECK_SXE;                                                            \
@@ -4364,11 +4356,7 @@ static bool trans_## NAME (DisasContext *ctx, arg_vr_i *a)                \
     addr = gpr_src(ctx, a->rj, EXT_NONE);                                 \
     val = tcg_temp_new_i64();                                             \
                                                                           \
-    if (a->imm) {                                                         \
-        temp = tcg_temp_new();                                            \
-        tcg_gen_addi_tl(temp, addr, a->imm);                              \
-        addr = temp;                                                      \
-    }                                                                     \
+    addr = make_address_i(ctx, addr, a->imm);                             \
                                                                           \
     tcg_gen_qemu_ld_i64(val, addr, ctx->mem_idx, MO);                     \
     tcg_gen_gvec_dup_i64(MO, vec_full_offset(a->vd), 16, ctx->vl/8, val); \
@@ -4384,7 +4372,7 @@ VLDREPL(vldrepl_d, MO_64)
 #define VSTELM(NAME, MO, E)                                                  \
 static bool trans_## NAME (DisasContext *ctx, arg_vr_ii *a)                  \
 {                                                                            \
-    TCGv addr, temp;                                                         \
+    TCGv addr;                                                               \
     TCGv_i64 val;                                                            \
                                                                              \
     CHECK_SXE;                                                               \
@@ -4392,11 +4380,7 @@ static bool trans_## NAME (DisasContext *ctx, arg_vr_ii *a)                  \
     addr = gpr_src(ctx, a->rj, EXT_NONE);                                    \
     val = tcg_temp_new_i64();                                                \
                                                                              \
-    if (a->imm) {                                                            \
-        temp = tcg_temp_new();                                               \
-        tcg_gen_addi_tl(temp, addr, a->imm);                                 \
-        addr = temp;                                                         \
-    }                                                                        \
+    addr = make_address_i(ctx, addr, a->imm);                                \
                                                                              \
     tcg_gen_ld_i64(val, cpu_env,                                             \
                    offsetof(CPULoongArchState, fpr[a->vd].vreg.E(a->imm2))); \
diff --git a/target/loongarch/insn_trans/trans_memory.c.inc b/target/loongarch/insn_trans/trans_memory.c.inc
index ccebd0a4e0..88953f0ab0 100644
--- a/target/loongarch/insn_trans/trans_memory.c.inc
+++ b/target/loongarch/insn_trans/trans_memory.c.inc
@@ -8,11 +8,7 @@ static bool gen_load(DisasContext *ctx, arg_rr_i *a, MemOp mop)
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
 
-    if (a->imm) {
-        TCGv temp = tcg_temp_new();
-        tcg_gen_addi_tl(temp, addr, a->imm);
-        addr = temp;
-    }
+    addr = make_address_i(ctx, addr, a->imm);
 
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     gen_set_gpr(a->rd, dest, EXT_NONE);
@@ -24,11 +20,7 @@ static bool gen_store(DisasContext *ctx, arg_rr_i *a, MemOp mop)
     TCGv data = gpr_src(ctx, a->rd, EXT_NONE);
     TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
 
-    if (a->imm) {
-        TCGv temp = tcg_temp_new();
-        tcg_gen_addi_tl(temp, addr, a->imm);
-        addr = temp;
-    }
+    addr = make_address_i(ctx, addr, a->imm);
 
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, mop);
     return true;
@@ -66,6 +58,7 @@ static bool gen_load_gt(DisasContext *ctx, arg_rrr *a, MemOp mop)
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
 
     gen_helper_asrtgt_d(cpu_env, src1, src2);
+    src1 = make_address_i(ctx, src1, 0);
     tcg_gen_qemu_ld_tl(dest, src1, ctx->mem_idx, mop);
     gen_set_gpr(a->rd, dest, EXT_NONE);
 
@@ -79,6 +72,7 @@ static bool gen_load_le(DisasContext *ctx, arg_rrr *a, MemOp mop)
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
 
     gen_helper_asrtle_d(cpu_env, src1, src2);
+    src1 = make_address_i(ctx, src1, 0);
     tcg_gen_qemu_ld_tl(dest, src1, ctx->mem_idx, mop);
     gen_set_gpr(a->rd, dest, EXT_NONE);
 
@@ -92,6 +86,7 @@ static bool gen_store_gt(DisasContext *ctx, arg_rrr *a, MemOp mop)
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
 
     gen_helper_asrtgt_d(cpu_env, src1, src2);
+    src1 = make_address_i(ctx, src1, 0);
     tcg_gen_qemu_st_tl(data, src1, ctx->mem_idx, mop);
 
     return true;
@@ -104,6 +99,7 @@ static bool gen_store_le(DisasContext *ctx, arg_rrr *a, MemOp mop)
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
 
     gen_helper_asrtle_d(cpu_env, src1, src2);
+    src1 = make_address_i(ctx, src1, 0);
     tcg_gen_qemu_st_tl(data, src1, ctx->mem_idx, mop);
 
     return true;
@@ -131,11 +127,7 @@ static bool gen_ldptr(DisasContext *ctx, arg_rr_i *a, MemOp mop)
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
 
-    if (a->imm) {
-        TCGv temp = tcg_temp_new();
-        tcg_gen_addi_tl(temp, addr, a->imm);
-        addr = temp;
-    }
+    addr = make_address_i(ctx, addr, a->imm);
 
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     gen_set_gpr(a->rd, dest, EXT_NONE);
@@ -147,11 +139,7 @@ static bool gen_stptr(DisasContext *ctx, arg_rr_i *a, MemOp mop)
     TCGv data = gpr_src(ctx, a->rd, EXT_NONE);
     TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
 
-    if (a->imm) {
-        TCGv temp = tcg_temp_new();
-        tcg_gen_addi_tl(temp, addr, a->imm);
-        addr = temp;
-    }
+    addr = make_address_i(ctx, addr, a->imm);
 
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, mop);
     return true;
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index a68a979a55..acc54d7587 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -220,6 +220,12 @@ static TCGv make_address_x(DisasContext *ctx, TCGv base, TCGv addend)
     return base;
 }
 
+static TCGv make_address_i(DisasContext *ctx, TCGv base, target_long ofs)
+{
+    TCGv addend = ofs ? tcg_constant_tl(ofs) : NULL;
+    return make_address_x(ctx, base, addend);
+}
+
 #include "decode-insns.c.inc"
 #include "insn_trans/trans_arith.c.inc"
 #include "insn_trans/trans_shift.c.inc"
-- 
2.39.1


