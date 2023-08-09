Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE4B775580
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 10:35:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTeda-00048x-HF; Wed, 09 Aug 2023 04:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTedY-00047t-7h
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 04:33:48 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTedV-0001oI-JL
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 04:33:47 -0400
Received: from cslab-raptor.. (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 455894404B;
 Wed,  9 Aug 2023 08:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691570024; bh=PeDSdLd80k1ckMiwyU0utgXgopEtrOXlO4lDLTn2q1Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MF8SIoQMiFTqfjsEx9BYz/1tMHIczk5yAN0DsFCycxJ/uUIEH+LQkv29Whw8b5rAH
 YoR8O2QG9cr35szqno9pFqD9hsKW/uB76Q+5Zj8YL7hpji8/tvkkLb6wZnWwO0KJL8
 LVjogxnqRfepOJeGSIfceTp8IarI7J875MTCKPT4=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, yijun@loongson.cn, shenjinyang@loongson.cn,
 gaosong@loongson.cn, i.qemu@xen0n.name, Jiajie Chen <c@jia.je>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
Subject: [PATCH v5 09/11] target/loongarch: Truncate high 32 bits of address
 in VA32 mode
Date: Wed,  9 Aug 2023 16:26:37 +0800
Message-ID: <20230809083258.1787464-10-c@jia.je>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809083258.1787464-1-c@jia.je>
References: <20230809083258.1787464-1-c@jia.je>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

When running in VA32 mode(!LA64 or VA32L[1-3] matching PLV), virtual
address is truncated to 32 bits before address mapping.

Signed-off-by: Jiajie Chen <c@jia.je>
Co-authored-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/cpu.c                        | 16 ++++----
 target/loongarch/cpu.h                        |  9 +++++
 target/loongarch/gdbstub.c                    |  2 +-
 .../loongarch/insn_trans/trans_atomic.c.inc   |  5 ++-
 .../loongarch/insn_trans/trans_branch.c.inc   |  3 +-
 .../loongarch/insn_trans/trans_fmemory.c.inc  | 30 ++++-----------
 target/loongarch/insn_trans/trans_lsx.c.inc   | 38 +++++--------------
 .../loongarch/insn_trans/trans_memory.c.inc   | 34 +++++------------
 target/loongarch/op_helper.c                  |  4 +-
 target/loongarch/translate.c                  | 32 ++++++++++++++++
 10 files changed, 85 insertions(+), 88 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 30dd70571a..bd980790f2 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -81,7 +81,7 @@ static void loongarch_cpu_set_pc(CPUState *cs, vaddr value)
     LoongArchCPU *cpu = LOONGARCH_CPU(cs);
     CPULoongArchState *env = &cpu->env;
 
-    env->pc = value;
+    set_pc(env, value);
 }
 
 static vaddr loongarch_cpu_get_pc(CPUState *cs)
@@ -168,7 +168,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     set_DERA:
         env->CSR_DERA = env->pc;
         env->CSR_DBG = FIELD_DP64(env->CSR_DBG, CSR_DBG, DST, 1);
-        env->pc = env->CSR_EENTRY + 0x480;
+        set_pc(env, env->CSR_EENTRY + 0x480);
         break;
     case EXCCODE_INT:
         if (FIELD_EX64(env->CSR_DBG, CSR_DBG, DST)) {
@@ -249,7 +249,8 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
 
         /* Find the highest-priority interrupt. */
         vector = 31 - clz32(pending);
-        env->pc = env->CSR_EENTRY + (EXCCODE_EXTERNAL_INT + vector) * vec_size;
+        set_pc(env, env->CSR_EENTRY + \
+               (EXCCODE_EXTERNAL_INT + vector) * vec_size);
         qemu_log_mask(CPU_LOG_INT,
                       "%s: PC " TARGET_FMT_lx " ERA " TARGET_FMT_lx
                       " cause %d\n" "    A " TARGET_FMT_lx " D "
@@ -260,10 +261,9 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
                       env->CSR_ECFG, env->CSR_ESTAT);
     } else {
         if (tlbfill) {
-            env->pc = env->CSR_TLBRENTRY;
+            set_pc(env, env->CSR_TLBRENTRY);
         } else {
-            env->pc = env->CSR_EENTRY;
-            env->pc += EXCODE_MCODE(cause) * vec_size;
+            set_pc(env, env->CSR_EENTRY + EXCODE_MCODE(cause) * vec_size);
         }
         qemu_log_mask(CPU_LOG_INT,
                       "%s: PC " TARGET_FMT_lx " ERA " TARGET_FMT_lx
@@ -324,7 +324,7 @@ static void loongarch_cpu_synchronize_from_tb(CPUState *cs,
     CPULoongArchState *env = &cpu->env;
 
     tcg_debug_assert(!(cs->tcg_cflags & CF_PCREL));
-    env->pc = tb->pc;
+    set_pc(env, tb->pc);
 }
 
 static void loongarch_restore_state_to_opc(CPUState *cs,
@@ -334,7 +334,7 @@ static void loongarch_restore_state_to_opc(CPUState *cs,
     LoongArchCPU *cpu = LOONGARCH_CPU(cs);
     CPULoongArchState *env = &cpu->env;
 
-    env->pc = data[0];
+    set_pc(env, data[0]);
 }
 #endif /* CONFIG_TCG */
 
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 0e02257f91..9f550793ca 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -442,6 +442,15 @@ static inline bool is_va32(CPULoongArchState *env)
     return va32;
 }
 
+static inline void set_pc(CPULoongArchState *env, uint64_t value)
+{
+    if (is_va32(env)) {
+        env->pc = (uint32_t)value;
+    } else {
+        env->pc = value;
+    }
+}
+
 /*
  * LoongArch CPUs hardware flags.
  */
diff --git a/target/loongarch/gdbstub.c b/target/loongarch/gdbstub.c
index a462e25737..e20b20f99b 100644
--- a/target/loongarch/gdbstub.c
+++ b/target/loongarch/gdbstub.c
@@ -77,7 +77,7 @@ int loongarch_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         env->gpr[n] = tmp;
         length = read_length;
     } else if (n == 33) {
-        env->pc = tmp;
+        set_pc(env, tmp);
         length = read_length;
     }
     return length;
diff --git a/target/loongarch/insn_trans/trans_atomic.c.inc b/target/loongarch/insn_trans/trans_atomic.c.inc
index c69f31bc78..d90312729b 100644
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
index 29b81a9843..b63058235d 100644
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
index 91c09fb6d9..bd3aba2c49 100644
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
 
@@ -57,8 +49,7 @@ static bool gen_floadx(DisasContext *ctx, arg_frr *a, MemOp mop)
 
     CHECK_FPE;
 
-    addr = tcg_temp_new();
-    tcg_gen_add_tl(addr, src1, src2);
+    addr = make_address_x(ctx, src1, src2);
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
     set_fpr(a->fd, dest);
@@ -75,8 +66,7 @@ static bool gen_fstorex(DisasContext *ctx, arg_frr *a, MemOp mop)
 
     CHECK_FPE;
 
-    addr = tcg_temp_new();
-    tcg_gen_add_tl(addr, src1, src2);
+    addr = make_address_x(ctx, src1, src2);
     tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
 
     return true;
@@ -91,9 +81,8 @@ static bool gen_fload_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
 
     CHECK_FPE;
 
-    addr = tcg_temp_new();
     gen_helper_asrtgt_d(cpu_env, src1, src2);
-    tcg_gen_add_tl(addr, src1, src2);
+    addr = make_address_x(ctx, src1, src2);
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
     set_fpr(a->fd, dest);
@@ -110,9 +99,8 @@ static bool gen_fstore_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
 
     CHECK_FPE;
 
-    addr = tcg_temp_new();
     gen_helper_asrtgt_d(cpu_env, src1, src2);
-    tcg_gen_add_tl(addr, src1, src2);
+    addr = make_address_x(ctx, src1, src2);
     tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
 
     return true;
@@ -127,9 +115,8 @@ static bool gen_fload_le(DisasContext *ctx, arg_frr *a, MemOp mop)
 
     CHECK_FPE;
 
-    addr = tcg_temp_new();
     gen_helper_asrtle_d(cpu_env, src1, src2);
-    tcg_gen_add_tl(addr, src1, src2);
+    addr = make_address_x(ctx, src1, src2);
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
     set_fpr(a->fd, dest);
@@ -146,9 +133,8 @@ static bool gen_fstore_le(DisasContext *ctx, arg_frr *a, MemOp mop)
 
     CHECK_FPE;
 
-    addr = tcg_temp_new();
     gen_helper_asrtle_d(cpu_env, src1, src2);
-    tcg_gen_add_tl(addr, src1, src2);
+    addr = make_address_x(ctx, src1, src2);
     tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
 
     return true;
diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index 68779daff6..50153d6d0b 100644
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
@@ -4315,14 +4307,13 @@ static bool trans_vldx(DisasContext *ctx, arg_vrr *a)
 
     CHECK_SXE;
 
-    addr = tcg_temp_new();
     src1 = gpr_src(ctx, a->rj, EXT_NONE);
     src2 = gpr_src(ctx, a->rk, EXT_NONE);
     val = tcg_temp_new_i128();
     rl = tcg_temp_new_i64();
     rh = tcg_temp_new_i64();
 
-    tcg_gen_add_tl(addr, src1, src2);
+    addr = make_address_x(ctx, src1, src2);
     tcg_gen_qemu_ld_i128(val, addr, ctx->mem_idx, MO_128 | MO_TE);
     tcg_gen_extr_i128_i64(rl, rh, val);
     set_vreg64(rh, a->vd, 1);
@@ -4339,14 +4330,13 @@ static bool trans_vstx(DisasContext *ctx, arg_vrr *a)
 
     CHECK_SXE;
 
-    addr = tcg_temp_new();
     src1 = gpr_src(ctx, a->rj, EXT_NONE);
     src2 = gpr_src(ctx, a->rk, EXT_NONE);
     val = tcg_temp_new_i128();
     ah = tcg_temp_new_i64();
     al = tcg_temp_new_i64();
 
-    tcg_gen_add_tl(addr, src1, src2);
+    addr = make_address_x(ctx, src1, src2);
     get_vreg64(ah, a->vd, 1);
     get_vreg64(al, a->vd, 0);
     tcg_gen_concat_i64_i128(val, al, ah);
@@ -4358,7 +4348,7 @@ static bool trans_vstx(DisasContext *ctx, arg_vrr *a)
 #define VLDREPL(NAME, MO)                                                 \
 static bool trans_## NAME (DisasContext *ctx, arg_vr_i *a)                \
 {                                                                         \
-    TCGv addr, temp;                                                      \
+    TCGv addr;                                                            \
     TCGv_i64 val;                                                         \
                                                                           \
     CHECK_SXE;                                                            \
@@ -4366,11 +4356,7 @@ static bool trans_## NAME (DisasContext *ctx, arg_vr_i *a)                \
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
@@ -4386,7 +4372,7 @@ VLDREPL(vldrepl_d, MO_64)
 #define VSTELM(NAME, MO, E)                                                  \
 static bool trans_## NAME (DisasContext *ctx, arg_vr_ii *a)                  \
 {                                                                            \
-    TCGv addr, temp;                                                         \
+    TCGv addr;                                                               \
     TCGv_i64 val;                                                            \
                                                                              \
     CHECK_SXE;                                                               \
@@ -4394,11 +4380,7 @@ static bool trans_## NAME (DisasContext *ctx, arg_vr_ii *a)                  \
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
index 858c97951b..63269e52c9 100644
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
@@ -39,9 +31,8 @@ static bool gen_loadx(DisasContext *ctx, arg_rrr *a, MemOp mop)
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
-    TCGv addr = tcg_temp_new();
+    TCGv addr = make_address_x(ctx, src1, src2);
 
-    tcg_gen_add_tl(addr, src1, src2);
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     gen_set_gpr(a->rd, dest, EXT_NONE);
 
@@ -53,9 +44,8 @@ static bool gen_storex(DisasContext *ctx, arg_rrr *a, MemOp mop)
     TCGv data = gpr_src(ctx, a->rd, EXT_NONE);
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
-    TCGv addr = tcg_temp_new();
+    TCGv addr = make_address_x(ctx, src1, src2);
 
-    tcg_gen_add_tl(addr, src1, src2);
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, mop);
 
     return true;
@@ -68,6 +58,7 @@ static bool gen_load_gt(DisasContext *ctx, arg_rrr *a, MemOp mop)
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
 
     gen_helper_asrtgt_d(cpu_env, src1, src2);
+    src1 = make_address_i(ctx, src1, 0);
     tcg_gen_qemu_ld_tl(dest, src1, ctx->mem_idx, mop);
     gen_set_gpr(a->rd, dest, EXT_NONE);
 
@@ -81,6 +72,7 @@ static bool gen_load_le(DisasContext *ctx, arg_rrr *a, MemOp mop)
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
 
     gen_helper_asrtle_d(cpu_env, src1, src2);
+    src1 = make_address_i(ctx, src1, 0);
     tcg_gen_qemu_ld_tl(dest, src1, ctx->mem_idx, mop);
     gen_set_gpr(a->rd, dest, EXT_NONE);
 
@@ -94,6 +86,7 @@ static bool gen_store_gt(DisasContext *ctx, arg_rrr *a, MemOp mop)
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
 
     gen_helper_asrtgt_d(cpu_env, src1, src2);
+    src1 = make_address_i(ctx, src1, 0);
     tcg_gen_qemu_st_tl(data, src1, ctx->mem_idx, mop);
 
     return true;
@@ -106,6 +99,7 @@ static bool gen_store_le(DisasContext *ctx, arg_rrr *a, MemOp mop)
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
 
     gen_helper_asrtle_d(cpu_env, src1, src2);
+    src1 = make_address_i(ctx, src1, 0);
     tcg_gen_qemu_st_tl(data, src1, ctx->mem_idx, mop);
 
     return true;
@@ -133,11 +127,7 @@ static bool gen_ldptr(DisasContext *ctx, arg_rr_i *a, MemOp mop)
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
@@ -149,11 +139,7 @@ static bool gen_stptr(DisasContext *ctx, arg_rr_i *a, MemOp mop)
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
diff --git a/target/loongarch/op_helper.c b/target/loongarch/op_helper.c
index 60335a05e2..cf84f20aba 100644
--- a/target/loongarch/op_helper.c
+++ b/target/loongarch/op_helper.c
@@ -114,14 +114,14 @@ void helper_ertn(CPULoongArchState *env)
         env->CSR_TLBRERA = FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 0);
         env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, DA, 0);
         env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PG, 1);
-        env->pc = env->CSR_TLBRERA;
+        set_pc(env, env->CSR_TLBRERA);
         qemu_log_mask(CPU_LOG_INT, "%s: TLBRERA " TARGET_FMT_lx "\n",
                       __func__, env->CSR_TLBRERA);
     } else {
         csr_pplv = FIELD_EX64(env->CSR_PRMD, CSR_PRMD, PPLV);
         csr_pie = FIELD_EX64(env->CSR_PRMD, CSR_PRMD, PIE);
 
-        env->pc = env->CSR_ERA;
+        set_pc(env, env->CSR_ERA);
         qemu_log_mask(CPU_LOG_INT, "%s: ERA " TARGET_FMT_lx "\n",
                       __func__, env->CSR_ERA);
     }
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index ac847745df..689da19ed0 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -86,6 +86,10 @@ void generate_exception(DisasContext *ctx, int excp)
 
 static inline void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
 {
+    if (ctx->va32) {
+        dest = (uint32_t) dest;
+    }
+
     if (translator_use_goto_tb(&ctx->base, dest)) {
         tcg_gen_goto_tb(n);
         tcg_gen_movi_tl(cpu_pc, dest);
@@ -208,6 +212,30 @@ static void set_fpr(int reg_num, TCGv val)
                    offsetof(CPULoongArchState, fpr[reg_num].vreg.D(0)));
 }
 
+static TCGv make_address_x(DisasContext *ctx, TCGv base, TCGv addend)
+{
+    TCGv temp = NULL;
+
+    if (addend || ctx->va32) {
+        temp = tcg_temp_new();
+    }
+    if (addend) {
+        tcg_gen_add_tl(temp, base, addend);
+        base = temp;
+    }
+    if (ctx->va32) {
+        tcg_gen_ext32u_tl(temp, base);
+        base = temp;
+    }
+    return base;
+}
+
+static TCGv make_address_i(DisasContext *ctx, TCGv base, target_long ofs)
+{
+    TCGv addend = ofs ? tcg_constant_tl(ofs) : NULL;
+    return make_address_x(ctx, base, addend);
+}
+
 #include "decode-insns.c.inc"
 #include "insn_trans/trans_arith.c.inc"
 #include "insn_trans/trans_shift.c.inc"
@@ -239,6 +267,10 @@ static void loongarch_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     }
 
     ctx->base.pc_next += 4;
+
+    if (ctx->va32) {
+        ctx->base.pc_next = (uint32_t)ctx->base.pc_next;
+    }
 }
 
 static void loongarch_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
-- 
2.41.0


