Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D64BC773616
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 03:57:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTBxC-0002fW-IH; Mon, 07 Aug 2023 21:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTBx3-0002dn-HD
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 21:56:02 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTBx1-0003lI-Ii
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 21:56:01 -0400
Received: from cslab-raptor.. (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id A42BC43F4C;
 Tue,  8 Aug 2023 01:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691459758; bh=c30M3wy1xpV66XCkG+/dWdDlHZQJzXc9XQq4BvOu5L4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ir4TDh8vpBr9mkDMHHQij2ffAgqknnJ4Pv3NRV75vTJLTkaKYJsS4XmU9IFIpC+4w
 NMjKhDL/Duq3w1bQy1XfPbiW2Yu2UB3SuDWZLjLydwviGwhs3Lxz7QzvJn7qvPVC7l
 CdfMcjInVVlx2IS2UUx++OiM6U84/uypcoPGp6rA=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, yijun@loongson.cn, shenjinyang@loongson.cn,
 gaosong@loongson.cn, i.qemu@xen0n.name, Jiajie Chen <c@jia.je>
Subject: [PATCH v4 09/11] target/loongarch: Truncate high 32 bits of address
 in VA32 mode
Date: Tue,  8 Aug 2023 09:54:35 +0800
Message-ID: <20230808015506.1705140-10-c@jia.je>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808015506.1705140-1-c@jia.je>
References: <20230808015506.1705140-1-c@jia.je>
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

When running in VA32 mode(LA32 or VA32L[1-3] matching PLV), virtual
address is truncated to 32 bits before address mapping.

Signed-off-by: Jiajie Chen <c@jia.je>
---
 target/loongarch/cpu.h                          |  6 +++++-
 target/loongarch/insn_trans/trans_atomic.c.inc  |  1 +
 target/loongarch/insn_trans/trans_fmemory.c.inc |  8 ++++++++
 target/loongarch/insn_trans/trans_lsx.c.inc     |  6 ++++++
 target/loongarch/insn_trans/trans_memory.c.inc  | 10 ++++++++++
 target/loongarch/translate.c                    | 10 ++++++++++
 6 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 69589f0aef..9ad5fcc494 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -457,7 +457,11 @@ static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
         va32 = 1;
     }
 
-    *pc = env->pc;
+    if (va32) {
+        *pc = (uint32_t)env->pc;
+    } else {
+        *pc = env->pc;
+    }
     *cs_base = 0;
     *flags = env->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
     *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
diff --git a/target/loongarch/insn_trans/trans_atomic.c.inc b/target/loongarch/insn_trans/trans_atomic.c.inc
index c69f31bc78..d9d950d642 100644
--- a/target/loongarch/insn_trans/trans_atomic.c.inc
+++ b/target/loongarch/insn_trans/trans_atomic.c.inc
@@ -10,6 +10,7 @@ static bool gen_ll(DisasContext *ctx, arg_rr_i *a, MemOp mop)
     TCGv t0 = tcg_temp_new();
 
     tcg_gen_addi_tl(t0, src1, a->imm);
+    t0 = va32_address(ctx, t0);
     tcg_gen_qemu_ld_i64(dest, t0, ctx->mem_idx, mop);
     tcg_gen_st_tl(t0, cpu_env, offsetof(CPULoongArchState, lladdr));
     tcg_gen_st_tl(dest, cpu_env, offsetof(CPULoongArchState, llval));
diff --git a/target/loongarch/insn_trans/trans_fmemory.c.inc b/target/loongarch/insn_trans/trans_fmemory.c.inc
index 91c09fb6d9..391af356d0 100644
--- a/target/loongarch/insn_trans/trans_fmemory.c.inc
+++ b/target/loongarch/insn_trans/trans_fmemory.c.inc
@@ -22,6 +22,7 @@ static bool gen_fload_i(DisasContext *ctx, arg_fr_i *a, MemOp mop)
         tcg_gen_addi_tl(temp, addr, a->imm);
         addr = temp;
     }
+    addr = va32_address(ctx, addr);
 
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
@@ -42,6 +43,7 @@ static bool gen_fstore_i(DisasContext *ctx, arg_fr_i *a, MemOp mop)
         tcg_gen_addi_tl(temp, addr, a->imm);
         addr = temp;
     }
+    addr = va32_address(ctx, addr);
 
     tcg_gen_qemu_st_tl(src, addr, ctx->mem_idx, mop);
 
@@ -59,6 +61,7 @@ static bool gen_floadx(DisasContext *ctx, arg_frr *a, MemOp mop)
 
     addr = tcg_temp_new();
     tcg_gen_add_tl(addr, src1, src2);
+    addr = va32_address(ctx, addr);
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
     set_fpr(a->fd, dest);
@@ -77,6 +80,7 @@ static bool gen_fstorex(DisasContext *ctx, arg_frr *a, MemOp mop)
 
     addr = tcg_temp_new();
     tcg_gen_add_tl(addr, src1, src2);
+    addr = va32_address(ctx, addr);
     tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
 
     return true;
@@ -94,6 +98,7 @@ static bool gen_fload_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
     addr = tcg_temp_new();
     gen_helper_asrtgt_d(cpu_env, src1, src2);
     tcg_gen_add_tl(addr, src1, src2);
+    addr = va32_address(ctx, addr);
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
     set_fpr(a->fd, dest);
@@ -113,6 +118,7 @@ static bool gen_fstore_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
     addr = tcg_temp_new();
     gen_helper_asrtgt_d(cpu_env, src1, src2);
     tcg_gen_add_tl(addr, src1, src2);
+    addr = va32_address(ctx, addr);
     tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
 
     return true;
@@ -130,6 +136,7 @@ static bool gen_fload_le(DisasContext *ctx, arg_frr *a, MemOp mop)
     addr = tcg_temp_new();
     gen_helper_asrtle_d(cpu_env, src1, src2);
     tcg_gen_add_tl(addr, src1, src2);
+    addr = va32_address(ctx, addr);
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
     set_fpr(a->fd, dest);
@@ -149,6 +156,7 @@ static bool gen_fstore_le(DisasContext *ctx, arg_frr *a, MemOp mop)
     addr = tcg_temp_new();
     gen_helper_asrtle_d(cpu_env, src1, src2);
     tcg_gen_add_tl(addr, src1, src2);
+    addr = va32_address(ctx, addr);
     tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
 
     return true;
diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index 68779daff6..b7325cfd8a 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_lsx.c.inc
@@ -4271,6 +4271,7 @@ static bool trans_vld(DisasContext *ctx, arg_vr_i *a)
         tcg_gen_addi_tl(temp, addr, a->imm);
         addr = temp;
     }
+    addr = va32_address(ctx, addr);
 
     tcg_gen_qemu_ld_i128(val, addr, ctx->mem_idx, MO_128 | MO_TE);
     tcg_gen_extr_i128_i64(rl, rh, val);
@@ -4298,6 +4299,7 @@ static bool trans_vst(DisasContext *ctx, arg_vr_i *a)
         tcg_gen_addi_tl(temp, addr, a->imm);
         addr = temp;
     }
+    addr = va32_address(ctx, addr);
 
     get_vreg64(ah, a->vd, 1);
     get_vreg64(al, a->vd, 0);
@@ -4323,6 +4325,7 @@ static bool trans_vldx(DisasContext *ctx, arg_vrr *a)
     rh = tcg_temp_new_i64();
 
     tcg_gen_add_tl(addr, src1, src2);
+    addr = va32_address(ctx, addr);
     tcg_gen_qemu_ld_i128(val, addr, ctx->mem_idx, MO_128 | MO_TE);
     tcg_gen_extr_i128_i64(rl, rh, val);
     set_vreg64(rh, a->vd, 1);
@@ -4347,6 +4350,7 @@ static bool trans_vstx(DisasContext *ctx, arg_vrr *a)
     al = tcg_temp_new_i64();
 
     tcg_gen_add_tl(addr, src1, src2);
+    addr = va32_address(ctx, addr);
     get_vreg64(ah, a->vd, 1);
     get_vreg64(al, a->vd, 0);
     tcg_gen_concat_i64_i128(val, al, ah);
@@ -4371,6 +4375,7 @@ static bool trans_## NAME (DisasContext *ctx, arg_vr_i *a)                \
         tcg_gen_addi_tl(temp, addr, a->imm);                              \
         addr = temp;                                                      \
     }                                                                     \
+    addr = va32_address(ctx, addr);                                        \
                                                                           \
     tcg_gen_qemu_ld_i64(val, addr, ctx->mem_idx, MO);                     \
     tcg_gen_gvec_dup_i64(MO, vec_full_offset(a->vd), 16, ctx->vl/8, val); \
@@ -4399,6 +4404,7 @@ static bool trans_## NAME (DisasContext *ctx, arg_vr_ii *a)                  \
         tcg_gen_addi_tl(temp, addr, a->imm);                                 \
         addr = temp;                                                         \
     }                                                                        \
+    addr = va32_address(ctx, addr);                                           \
                                                                              \
     tcg_gen_ld_i64(val, cpu_env,                                             \
                    offsetof(CPULoongArchState, fpr[a->vd].vreg.E(a->imm2))); \
diff --git a/target/loongarch/insn_trans/trans_memory.c.inc b/target/loongarch/insn_trans/trans_memory.c.inc
index 858c97951b..5b45444be4 100644
--- a/target/loongarch/insn_trans/trans_memory.c.inc
+++ b/target/loongarch/insn_trans/trans_memory.c.inc
@@ -13,6 +13,7 @@ static bool gen_load(DisasContext *ctx, arg_rr_i *a, MemOp mop)
         tcg_gen_addi_tl(temp, addr, a->imm);
         addr = temp;
     }
+    addr = va32_address(ctx, addr);
 
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     gen_set_gpr(a->rd, dest, EXT_NONE);
@@ -29,6 +30,7 @@ static bool gen_store(DisasContext *ctx, arg_rr_i *a, MemOp mop)
         tcg_gen_addi_tl(temp, addr, a->imm);
         addr = temp;
     }
+    addr = va32_address(ctx, addr);
 
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, mop);
     return true;
@@ -42,6 +44,7 @@ static bool gen_loadx(DisasContext *ctx, arg_rrr *a, MemOp mop)
     TCGv addr = tcg_temp_new();
 
     tcg_gen_add_tl(addr, src1, src2);
+    addr = va32_address(ctx, addr);
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     gen_set_gpr(a->rd, dest, EXT_NONE);
 
@@ -56,6 +59,7 @@ static bool gen_storex(DisasContext *ctx, arg_rrr *a, MemOp mop)
     TCGv addr = tcg_temp_new();
 
     tcg_gen_add_tl(addr, src1, src2);
+    addr = va32_address(ctx, addr);
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, mop);
 
     return true;
@@ -68,6 +72,7 @@ static bool gen_load_gt(DisasContext *ctx, arg_rrr *a, MemOp mop)
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
 
     gen_helper_asrtgt_d(cpu_env, src1, src2);
+    src1 = va32_address(ctx, src1);
     tcg_gen_qemu_ld_tl(dest, src1, ctx->mem_idx, mop);
     gen_set_gpr(a->rd, dest, EXT_NONE);
 
@@ -81,6 +86,7 @@ static bool gen_load_le(DisasContext *ctx, arg_rrr *a, MemOp mop)
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
 
     gen_helper_asrtle_d(cpu_env, src1, src2);
+    src1 = va32_address(ctx, src1);
     tcg_gen_qemu_ld_tl(dest, src1, ctx->mem_idx, mop);
     gen_set_gpr(a->rd, dest, EXT_NONE);
 
@@ -94,6 +100,7 @@ static bool gen_store_gt(DisasContext *ctx, arg_rrr *a, MemOp mop)
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
 
     gen_helper_asrtgt_d(cpu_env, src1, src2);
+    src1 = va32_address(ctx, src1);
     tcg_gen_qemu_st_tl(data, src1, ctx->mem_idx, mop);
 
     return true;
@@ -106,6 +113,7 @@ static bool gen_store_le(DisasContext *ctx, arg_rrr *a, MemOp mop)
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
 
     gen_helper_asrtle_d(cpu_env, src1, src2);
+    src1 = va32_address(ctx, src1);
     tcg_gen_qemu_st_tl(data, src1, ctx->mem_idx, mop);
 
     return true;
@@ -138,6 +146,7 @@ static bool gen_ldptr(DisasContext *ctx, arg_rr_i *a, MemOp mop)
         tcg_gen_addi_tl(temp, addr, a->imm);
         addr = temp;
     }
+    addr = va32_address(ctx, addr);
 
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     gen_set_gpr(a->rd, dest, EXT_NONE);
@@ -154,6 +163,7 @@ static bool gen_stptr(DisasContext *ctx, arg_rr_i *a, MemOp mop)
         tcg_gen_addi_tl(temp, addr, a->imm);
         addr = temp;
     }
+    addr = va32_address(ctx, addr);
 
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, mop);
     return true;
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index f1e5fe4cf8..9cd2f13778 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -208,6 +208,16 @@ static void set_fpr(int reg_num, TCGv val)
                    offsetof(CPULoongArchState, fpr[reg_num].vreg.D(0)));
 }
 
+static TCGv va32_address(DisasContext *ctx, TCGv addr)
+{
+    if (ctx->va32) {
+        TCGv temp = tcg_temp_new();
+        tcg_gen_ext32u_tl(temp, addr);
+        addr = temp;
+    }
+    return addr;
+}
+
 #include "decode-insns.c.inc"
 #include "insn_trans/trans_arith.c.inc"
 #include "insn_trans/trans_shift.c.inc"
-- 
2.41.0


