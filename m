Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2A1832B78
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:43:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQq3A-0005y7-L7; Fri, 19 Jan 2024 09:40:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2q-0005pt-7R
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:34 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2k-0003sh-1t
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8VbSSJ+elwAUh/3IBh5c6unmBtljyQ3plo6LsH7WdK4=; b=FITrlALjFaKVMHTJ9yP75JbGb1
 do4NHneJlsothXci4kF3y4HhYLcb8lgMYQMCEqerOYJsvFmFSCdWSgYVQf8MPho6y8fvfoaSL8oPg
 xAUm+1FrABt1w0SDwHw6NzO4UKUxrJpzZ0Ex2EX3yNHmlUnPwuOiHNTDLxxECrUxleYA=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [RFC PATCH 13/34] target: Uninline cpu_get_tb_cpu_state()
Date: Fri, 19 Jan 2024 15:40:03 +0100
Message-ID: <20240119144024.14289-14-anjo@rev.ng>
In-Reply-To: <20240119144024.14289-1-anjo@rev.ng>
References: <20240119144024.14289-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Required to compile accel/tcg/translate-all.c once for softmmu targets.
The function gets quite big for some targets so uninlining makes sense.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/exec/cpu-common.h |  4 +++
 target/alpha/cpu.h        | 11 -------
 target/arm/cpu.h          |  3 --
 target/avr/cpu.h          | 18 -----------
 target/cris/cpu.h         | 10 ------
 target/hexagon/cpu.h      | 12 -------
 target/hppa/cpu.h         | 43 -------------------------
 target/i386/cpu.h         |  9 ------
 target/loongarch/cpu.h    | 11 -------
 target/m68k/cpu.h         | 16 ---------
 target/microblaze/cpu.h   |  8 -----
 target/mips/cpu.h         |  9 ------
 target/nios2/cpu.h        | 12 -------
 target/openrisc/cpu.h     | 10 ------
 target/ppc/cpu.h          | 13 --------
 target/riscv/cpu.h        |  3 --
 target/rx/cpu.h           |  9 ------
 target/s390x/cpu.h        | 22 -------------
 target/sh4/cpu.h          | 15 ---------
 target/sparc/cpu.h        | 35 --------------------
 target/tricore/cpu.h      | 12 -------
 target/xtensa/cpu.h       | 68 ---------------------------------------
 target/alpha/cpu.c        | 11 +++++++
 target/avr/cpu.c          | 18 +++++++++++
 target/cris/cpu.c         | 10 ++++++
 target/hexagon/cpu.c      | 12 +++++++
 target/hppa/cpu.c         | 47 +++++++++++++++++++++++++++
 target/i386/cpu.c         |  9 ++++++
 target/loongarch/cpu.c    | 11 +++++++
 target/m68k/cpu.c         | 16 +++++++++
 target/microblaze/cpu.c   |  7 ++++
 target/mips/cpu.c         |  9 ++++++
 target/nios2/cpu.c        | 12 +++++++
 target/openrisc/cpu.c     | 10 ++++++
 target/ppc/cpu.c          | 11 +++++++
 target/rx/cpu.c           |  9 ++++++
 target/s390x/cpu.c        | 24 ++++++++++++++
 target/sh4/cpu.c          | 15 +++++++++
 target/sparc/cpu.c        | 35 ++++++++++++++++++++
 target/tricore/cpu.c      | 12 +++++++
 target/xtensa/cpu.c       | 68 +++++++++++++++++++++++++++++++++++++++
 41 files changed, 350 insertions(+), 349 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 12952c481c..b5dae4a9d6 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -70,6 +70,10 @@ unsigned int cpu_list_generation_id_get(void);
  */
 int cpu_mmu_index(CPUArchState *env, bool ifetch);
 
+void cpu_get_tb_cpu_state(CPUArchState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *pflags);
+
+
 void tcg_flush_softmmu_tlb(CPUState *cs);
 void tcg_flush_jmp_cache(CPUState *cs);
 
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index e93186d50e..09937b32a2 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -452,17 +452,6 @@ void alpha_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                      MemTxResult response, uintptr_t retaddr);
 #endif
 
-static inline void cpu_get_tb_cpu_state(CPUAlphaState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *pflags)
-{
-    *pc = env->pc;
-    *cs_base = 0;
-    *pflags = env->flags & ENV_FLAG_TB_MASK;
-#ifdef CONFIG_USER_ONLY
-    *pflags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
-#endif
-}
-
 #ifdef CONFIG_USER_ONLY
 /* Copied from linux ieee_swcr_to_fpcr.  */
 static inline uint64_t alpha_ieee_swcr_to_fpcr(uint64_t swcr)
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 3dfca8f3ae..9732c836b2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3212,9 +3212,6 @@ static inline bool arm_cpu_bswap_data(CPUARMState *env)
 }
 #endif
 
-void cpu_get_tb_cpu_state(CPUARMState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *flags);
-
 enum {
     QEMU_PSCI_CONDUIT_DISABLED = 0,
     QEMU_PSCI_CONDUIT_SMC = 1,
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 581ba54aae..e454f3ac3c 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -183,24 +183,6 @@ enum {
     TB_FLAGS_SKIP = 2,
 };
 
-static inline void cpu_get_tb_cpu_state(CPUAVRState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *pflags)
-{
-    uint32_t flags = 0;
-
-    *pc = env->pc_w * 2;
-    *cs_base = 0;
-
-    if (env->fullacc) {
-        flags |= TB_FLAGS_FULL_ACCESS;
-    }
-    if (env->skip) {
-        flags |= TB_FLAGS_SKIP;
-    }
-
-    *pflags = flags;
-}
-
 static inline int cpu_interrupts_enabled(CPUAVRState *env)
 {
     return env->sregI != 0;
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 9587a2a229..1312a719b7 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -261,16 +261,6 @@ enum {
 
 #include "exec/cpu-all.h"
 
-static inline void cpu_get_tb_cpu_state(CPUCRISState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *pc = env->pc;
-    *cs_base = 0;
-    *flags = env->dslot |
-            (env->pregs[PR_CCS] & (S_FLAG | P_FLAG | U_FLAG
-				     | X_FLAG | PFIX_FLAG));
-}
-
 #define cpu_list cris_cpu_list
 void cris_cpu_list(void);
 
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 562b5c7095..8e0b7704ef 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -153,18 +153,6 @@ struct ArchCPU {
 
 FIELD(TB_FLAGS, IS_TIGHT_LOOP, 0, 1)
 
-static inline void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    uint32_t hex_flags = 0;
-    *pc = env->gpr[HEX_REG_PC];
-    *cs_base = 0;
-    if (*pc == env->gpr[HEX_REG_SA0]) {
-        hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP, 1);
-    }
-    *flags = hex_flags;
-}
-
 typedef HexagonCPU ArchCPU;
 
 void hexagon_translate_init(void);
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 3da91d41d4..088692db90 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -267,49 +267,6 @@ static inline target_ulong hppa_form_gva(CPUHPPAState *env, uint64_t spc,
 #define TB_FLAG_PRIV_SHIFT  8
 #define TB_FLAG_UNALIGN     0x400
 
-static inline void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *pflags)
-{
-    uint32_t flags = env->psw_n * PSW_N;
-
-    /* TB lookup assumes that PC contains the complete virtual address.
-       If we leave space+offset separate, we'll get ITLB misses to an
-       incomplete virtual address.  This also means that we must separate
-       out current cpu privilege from the low bits of IAOQ_F.  */
-#ifdef CONFIG_USER_ONLY
-    *pc = env->iaoq_f & -4;
-    *cs_base = env->iaoq_b & -4;
-    flags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
-#else
-    /* ??? E, T, H, L, B, P bits need to be here, when implemented.  */
-    flags |= env->psw & (PSW_W | PSW_C | PSW_D);
-    flags |= (env->iaoq_f & 3) << TB_FLAG_PRIV_SHIFT;
-
-    *pc = (env->psw & PSW_C
-           ? hppa_form_gva_psw(env->psw, env->iasq_f, env->iaoq_f & -4)
-           : env->iaoq_f & -4);
-    *cs_base = env->iasq_f;
-
-    /* Insert a difference between IAOQ_B and IAOQ_F within the otherwise zero
-       low 32-bits of CS_BASE.  This will succeed for all direct branches,
-       which is the primary case we care about -- using goto_tb within a page.
-       Failure is indicated by a zero difference.  */
-    if (env->iasq_f == env->iasq_b) {
-        target_sreg diff = env->iaoq_b - env->iaoq_f;
-        if (TARGET_REGISTER_BITS == 32 || diff == (int32_t)diff) {
-            *cs_base |= (uint32_t)diff;
-        }
-    }
-    if ((env->sr[4] == env->sr[5])
-        & (env->sr[4] == env->sr[6])
-        & (env->sr[4] == env->sr[7])) {
-        flags |= TB_FLAG_SR_SAME;
-    }
-#endif
-
-    *pflags = flags;
-}
-
 target_ureg cpu_hppa_get_psw(CPUHPPAState *env);
 void cpu_hppa_put_psw(CPUHPPAState *env, target_ureg);
 void cpu_hppa_loaded_fr0(CPUHPPAState *env);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7de2bad701..5e938fdac3 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2278,15 +2278,6 @@ static inline int cpu_mmu_index_kernel(CPUX86State *env)
 #include "hw/i386/apic.h"
 #endif
 
-static inline void cpu_get_tb_cpu_state(CPUX86State *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *cs_base = env->segs[R_CS].base;
-    *pc = *cs_base + env->eip;
-    *flags = env->hflags |
-        (env->eflags & (IOPL_MASK | TF_MASK | RF_MASK | VM_MASK | AC_MASK));
-}
-
 void do_cpu_init(X86CPU *cpu);
 
 #define MCE_INJECT_BROADCAST    1
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index d85103c28d..ce9bdedbf0 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -449,17 +449,6 @@ static inline void set_pc(CPULoongArchState *env, uint64_t value)
 #define HW_FLAGS_EUEN_SXE   0x08
 #define HW_FLAGS_VA32       0x20
 
-static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *pc = env->pc;
-    *cs_base = 0;
-    *flags = env->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
-    *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
-    *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
-    *flags |= is_va32(env) * HW_FLAGS_VA32;
-}
-
 void loongarch_cpu_list(void);
 
 #define cpu_list loongarch_cpu_list
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index da13111fd8..21c37e2267 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -596,22 +596,6 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
 #define TB_FLAGS_TRACE          16
 #define TB_FLAGS_TRACE_BIT      (1 << TB_FLAGS_TRACE)
 
-static inline void cpu_get_tb_cpu_state(CPUM68KState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *pc = env->pc;
-    *cs_base = 0;
-    *flags = (env->macsr >> 4) & TB_FLAGS_MACSR;
-    if (env->sr & SR_S) {
-        *flags |= TB_FLAGS_MSR_S;
-        *flags |= (env->sfc << (TB_FLAGS_SFC_S_BIT - 2)) & TB_FLAGS_SFC_S;
-        *flags |= (env->dfc << (TB_FLAGS_DFC_S_BIT - 2)) & TB_FLAGS_DFC_S;
-    }
-    if (M68K_SR_TRACE(env->sr) == M68K_SR_TRACE_ANY_INS) {
-        *flags |= TB_FLAGS_TRACE;
-    }
-}
-
 void dump_mmu(CPUM68KState *env);
 
 #endif
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 8f8b4f55d4..bdbbf2751b 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -404,14 +404,6 @@ void mb_tcg_init(void);
 /* Ensure there is no overlap between the two masks. */
 QEMU_BUILD_BUG_ON(MSR_TB_MASK & IFLAGS_TB_MASK);
 
-static inline void cpu_get_tb_cpu_state(CPUMBState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *pc = env->pc;
-    *flags = (env->iflags & IFLAGS_TB_MASK) | (env->msr & MSR_TB_MASK);
-    *cs_base = (*flags & IMM_FLAG ? env->imm : 0);
-}
-
 #if !defined(CONFIG_USER_ONLY)
 bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                      MMUAccessType access_type, int mmu_idx,
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 49915af09d..6d9f95be18 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1344,15 +1344,6 @@ void itc_reconfigure(struct MIPSITUState *tag);
 /* helper.c */
 target_ulong exception_resume_pc(CPUMIPSState *env);
 
-static inline void cpu_get_tb_cpu_state(CPUMIPSState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *pc = env->active_tc.PC;
-    *cs_base = 0;
-    *flags = env->hflags & (MIPS_HFLAG_TMASK | MIPS_HFLAG_BMASK |
-                            MIPS_HFLAG_HWRENA_ULR);
-}
-
 /**
  * mips_cpu_create_with_clock:
  * @typename: a MIPS CPU type.
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index c1d4fc6542..890d91d901 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -295,16 +295,4 @@ FIELD(TBFLAGS, CRS0, 0, 1)  /* Set if CRS == 0. */
 FIELD(TBFLAGS, U, 1, 1)     /* Overlaps CR_STATUS_U */
 FIELD(TBFLAGS, R0_0, 2, 1)  /* Set if R0 == 0. */
 
-static inline void cpu_get_tb_cpu_state(CPUNios2State *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    unsigned crs = FIELD_EX32(env->ctrl[CR_STATUS], CR_STATUS, CRS);
-
-    *pc = env->pc;
-    *cs_base = 0;
-    *flags = (env->ctrl[CR_STATUS] & CR_STATUS_U)
-           | (crs ? 0 : R_TBFLAGS_CRS0_MASK)
-           | (env->regs[0] ? 0 : R_TBFLAGS_R0_0_MASK);
-}
-
 #endif /* NIOS2_CPU_H */
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index d57f820743..bfa3d6fba6 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -366,16 +366,6 @@ static inline void cpu_set_gpr(CPUOpenRISCState *env, int i, uint32_t val)
     env->shadow_gpr[0][i] = val;
 }
 
-static inline void cpu_get_tb_cpu_state(CPUOpenRISCState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *pc = env->pc;
-    *cs_base = 0;
-    *flags = (env->dflag ? TB_FLAGS_DFLAG : 0)
-           | (cpu_get_gpr(env, 0) ? 0 : TB_FLAGS_R0_0)
-           | (env->sr & (SR_SM | SR_DME | SR_IME | SR_OVE));
-}
-
 static inline uint32_t cpu_get_sr(const CPUOpenRISCState *env)
 {
     return (env->sr
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index faba987dc0..46eeb78c33 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2511,19 +2511,6 @@ void cpu_write_xer(CPUPPCState *env, target_ulong xer);
  */
 #define is_book3s_arch2x(ctx) (!!((ctx)->insns_flags & PPC_SEGMENT_64B))
 
-#ifdef CONFIG_DEBUG_TCG
-void cpu_get_tb_cpu_state(CPUPPCState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *flags);
-#else
-static inline void cpu_get_tb_cpu_state(CPUPPCState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *pc = env->nip;
-    *cs_base = 0;
-    *flags = env->hflags;
-}
-#endif
-
 G_NORETURN void raise_exception(CPUPPCState *env, uint32_t exception);
 G_NORETURN void raise_exception_ra(CPUPPCState *env, uint32_t exception,
                                    uintptr_t raddr);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 9b0590c7d9..58ed6700de 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -627,9 +627,6 @@ static inline uint32_t vext_get_vlmax(RISCVCPU *cpu, target_ulong vtype)
     return cpu->cfg.vlen >> (sew + 3 - lmul);
 }
 
-void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *pflags);
-
 void riscv_cpu_update_mask(CPURISCVState *env);
 
 RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 3f5b501acf..33290e2c47 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -142,15 +142,6 @@ void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte);
 #define RX_CPU_IRQ 0
 #define RX_CPU_FIR 1
 
-static inline void cpu_get_tb_cpu_state(CPURXState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *pc = env->pc;
-    *cs_base = 0;
-    *flags = FIELD_DP32(0, PSW, PM, env->psw_pm);
-    *flags = FIELD_DP32(*flags, PSW, U, env->psw_u);
-}
-
 static inline uint32_t rx_cpu_pack_psw(CPURXState *env)
 {
     uint32_t psw = 0;
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 5c646cafaa..eeb10d10bd 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -348,28 +348,6 @@ extern const VMStateDescription vmstate_s390_cpu;
 #define MMU_HOME_IDX            2
 #define MMU_REAL_IDX            3
 
-static inline void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    if (env->psw.addr & 1) {
-        /*
-         * Instructions must be at even addresses.
-         * This needs to be checked before address translation.
-         */
-        env->int_pgm_ilen = 2; /* see s390_cpu_tlb_fill() */
-        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, 0);
-    }
-    *pc = env->psw.addr;
-    *cs_base = env->ex_value;
-    *flags = (env->psw.mask >> FLAG_MASK_PSW_SHIFT) & FLAG_MASK_PSW;
-    if (env->cregs[0] & CR0_AFP) {
-        *flags |= FLAG_MASK_AFP;
-    }
-    if (env->cregs[0] & CR0_VECTOR) {
-        *flags |= FLAG_MASK_VECTOR;
-    }
-}
-
 /* PER bits from control register 9 */
 #define PER_CR9_EVENT_BRANCH           0x80000000
 #define PER_CR9_EVENT_IFETCH           0x40000000
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 218ba24333..818810769f 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -357,19 +357,4 @@ static inline void cpu_write_sr(CPUSH4State *env, target_ulong sr)
     env->sr = sr & ~((1u << SR_M) | (1u << SR_Q) | (1u << SR_T));
 }
 
-static inline void cpu_get_tb_cpu_state(CPUSH4State *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *pc = env->pc;
-    /* For a gUSA region, notice the end of the region.  */
-    *cs_base = env->flags & TB_FLAG_GUSA_MASK ? env->gregs[0] : 0;
-    *flags = env->flags
-            | (env->fpscr & TB_FLAG_FPSCR_MASK)
-            | (env->sr & TB_FLAG_SR_MASK)
-            | (env->movcal_backup ? TB_FLAG_PENDING_MOVCA : 0); /* Bit 3 */
-#ifdef CONFIG_USER_ONLY
-    *flags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
-#endif
-}
-
 #endif /* SH4_CPU_H */
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index bd24cd578c..33338f8846 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -733,41 +733,6 @@ trap_state* cpu_tsptr(CPUSPARCState* env);
 #define TB_FLAG_HYPER        (1 << 7)
 #define TB_FLAG_ASI_SHIFT    24
 
-static inline void cpu_get_tb_cpu_state(CPUSPARCState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *pflags)
-{
-    uint32_t flags;
-    *pc = env->pc;
-    *cs_base = env->npc;
-    flags = cpu_mmu_index(env, false);
-#ifndef CONFIG_USER_ONLY
-    if (cpu_supervisor_mode(env)) {
-        flags |= TB_FLAG_SUPER;
-    }
-#endif
-#ifdef TARGET_SPARC64
-#ifndef CONFIG_USER_ONLY
-    if (cpu_hypervisor_mode(env)) {
-        flags |= TB_FLAG_HYPER;
-    }
-#endif
-    if (env->pstate & PS_AM) {
-        flags |= TB_FLAG_AM_ENABLED;
-    }
-    if ((env->def.features & CPU_FEATURE_FLOAT)
-        && (env->pstate & PS_PEF)
-        && (env->fprs & FPRS_FEF)) {
-        flags |= TB_FLAG_FPU_ENABLED;
-    }
-    flags |= env->asi << TB_FLAG_ASI_SHIFT;
-#else
-    if ((env->def.features & CPU_FEATURE_FLOAT) && env->psref) {
-        flags |= TB_FLAG_FPU_ENABLED;
-    }
-#endif
-    *pflags = flags;
-}
-
 static inline bool tb_fpu_enabled(int tb_flags)
 {
 #if defined(CONFIG_USER_ONLY)
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 9454b0adcd..43604f00ca 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -378,18 +378,6 @@ FIELD(TB_FLAGS, PRIV, 0, 2)
 void cpu_state_reset(CPUTriCoreState *s);
 void tricore_tcg_init(void);
 
-static inline void cpu_get_tb_cpu_state(CPUTriCoreState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    uint32_t new_flags = 0;
-    *pc = env->PC;
-    *cs_base = 0;
-
-    new_flags |= FIELD_DP32(new_flags, TB_FLAGS, PRIV,
-            extract32(env->PSW, 10, 2));
-    *flags = new_flags;
-}
-
 #define TRICORE_CPU_TYPE_SUFFIX "-" TYPE_TRICORE_CPU
 #define TRICORE_CPU_TYPE_NAME(model) model TRICORE_CPU_TYPE_SUFFIX
 #define CPU_RESOLVING_TYPE TYPE_TRICORE_CPU
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 89d6b690af..0c51d2b0ec 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -721,74 +721,6 @@ static inline uint32_t xtensa_replicate_windowstart(CPUXtensaState *env)
 
 #include "exec/cpu-all.h"
 
-static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *pc = env->pc;
-    *cs_base = 0;
-    *flags = 0;
-    *flags |= xtensa_get_ring(env);
-    if (env->sregs[PS] & PS_EXCM) {
-        *flags |= XTENSA_TBFLAG_EXCM;
-    } else if (xtensa_option_enabled(env->config, XTENSA_OPTION_LOOP)) {
-        target_ulong lend_dist =
-            env->sregs[LEND] - (env->pc & -(1u << TARGET_PAGE_BITS));
-
-        /*
-         * 0 in the csbase_lend field means that there may not be a loopback
-         * for any instruction that starts inside this page. Any other value
-         * means that an instruction that ends at this offset from the page
-         * start may loop back and will need loopback code to be generated.
-         *
-         * lend_dist is 0 when LEND points to the start of the page, but
-         * no instruction that starts inside this page may end at offset 0,
-         * so it's still correct.
-         *
-         * When an instruction ends at a page boundary it may only start in
-         * the previous page. lend_dist will be encoded as TARGET_PAGE_SIZE
-         * for the TB that contains this instruction.
-         */
-        if (lend_dist < (1u << TARGET_PAGE_BITS) + env->config->max_insn_size) {
-            target_ulong lbeg_off = env->sregs[LEND] - env->sregs[LBEG];
-
-            *cs_base = lend_dist;
-            if (lbeg_off < 256) {
-                *cs_base |= lbeg_off << XTENSA_CSBASE_LBEG_OFF_SHIFT;
-            }
-        }
-    }
-    if (xtensa_option_enabled(env->config, XTENSA_OPTION_EXTENDED_L32R) &&
-            (env->sregs[LITBASE] & 1)) {
-        *flags |= XTENSA_TBFLAG_LITBASE;
-    }
-    if (xtensa_option_enabled(env->config, XTENSA_OPTION_DEBUG)) {
-        if (xtensa_get_cintlevel(env) < env->config->debug_level) {
-            *flags |= XTENSA_TBFLAG_DEBUG;
-        }
-        if (xtensa_get_cintlevel(env) < env->sregs[ICOUNTLEVEL]) {
-            *flags |= XTENSA_TBFLAG_ICOUNT;
-        }
-    }
-    if (xtensa_option_enabled(env->config, XTENSA_OPTION_COPROCESSOR)) {
-        *flags |= env->sregs[CPENABLE] << XTENSA_TBFLAG_CPENABLE_SHIFT;
-    }
-    if (xtensa_option_enabled(env->config, XTENSA_OPTION_WINDOWED_REGISTER) &&
-        (env->sregs[PS] & (PS_WOE | PS_EXCM)) == PS_WOE) {
-        uint32_t windowstart = xtensa_replicate_windowstart(env) >>
-            (env->sregs[WINDOW_BASE] + 1);
-        uint32_t w = ctz32(windowstart | 0x8);
-
-        *flags |= (w << XTENSA_TBFLAG_WINDOW_SHIFT) | XTENSA_TBFLAG_CWOE;
-        *flags |= extract32(env->sregs[PS], PS_CALLINC_SHIFT,
-                            PS_CALLINC_LEN) << XTENSA_TBFLAG_CALLINC_SHIFT;
-    } else {
-        *flags |= 3 << XTENSA_TBFLAG_WINDOW_SHIFT;
-    }
-    if (env->yield_needed) {
-        *flags |= XTENSA_TBFLAG_YIELD;
-    }
-}
-
 XtensaCPU *xtensa_cpu_create_with_clock(const char *cpu_type,
                                         Clock *cpu_refclk);
 
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 2559ce38ee..5e468d4605 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -34,6 +34,17 @@ int cpu_mmu_index(CPUAlphaState *env, bool ifetch)
     return ret;
 }
 
+void cpu_get_tb_cpu_state(CPUAlphaState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *pflags)
+{
+    *pc = env->pc;
+    *cs_base = 0;
+    *pflags = env->flags & ENV_FLAG_TB_MASK;
+#ifdef CONFIG_USER_ONLY
+    *pflags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
+#endif
+}
+
 static void alpha_cpu_set_pc(CPUState *cs, vaddr value)
 {
     AlphaCPU *cpu = ALPHA_CPU(cs);
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 38263d07dd..351e127fea 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -31,6 +31,24 @@ int cpu_mmu_index(CPUAVRState *env, bool ifetch)
     return ifetch ? MMU_CODE_IDX : MMU_DATA_IDX;
 }
 
+void cpu_get_tb_cpu_state(CPUAVRState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *pflags)
+{
+    uint32_t flags = 0;
+
+    *pc = env->pc_w * 2;
+    *cs_base = 0;
+
+    if (env->fullacc) {
+        flags |= TB_FLAGS_FULL_ACCESS;
+    }
+    if (env->skip) {
+        flags |= TB_FLAGS_SKIP;
+    }
+
+    *pflags = flags;
+}
+
 static void avr_cpu_set_pc(CPUState *cs, vaddr value)
 {
     AVRCPU *cpu = AVR_CPU(cs);
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 553742a068..8880e94a8e 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -32,6 +32,16 @@ int cpu_mmu_index(CPUCRISState *env, bool ifetch)
     return !!(env->pregs[PR_CCS] & U_FLAG);
 }
 
+void cpu_get_tb_cpu_state(CPUCRISState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    *pc = env->pc;
+    *cs_base = 0;
+    *flags = env->dslot |
+            (env->pregs[PR_CCS] & (S_FLAG | P_FLAG | U_FLAG
+                                   | X_FLAG | PFIX_FLAG));
+}
+
 static void cris_cpu_set_pc(CPUState *cs, vaddr value)
 {
     CRISCPU *cpu = CRIS_CPU(cs);
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index bf7c901705..68b6e1a31f 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -35,6 +35,18 @@ int cpu_mmu_index(CPUHexagonState *env, bool ifetch)
 #endif
 }
 
+void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    uint32_t hex_flags = 0;
+    *pc = env->gpr[HEX_REG_PC];
+    *cs_base = 0;
+    if (*pc == env->gpr[HEX_REG_SA0]) {
+        hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP, 1);
+    }
+    *flags = hex_flags;
+}
+
 static void hexagon_v67_cpu_init(Object *obj) { }
 static void hexagon_v68_cpu_init(Object *obj) { }
 static void hexagon_v69_cpu_init(Object *obj) { }
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 22f031758e..0103e0429b 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -40,6 +40,53 @@ int cpu_mmu_index(CPUHPPAState *env, bool ifetch)
 #endif
 }
 
+void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *pflags)
+{
+    uint32_t flags = env->psw_n * PSW_N;
+
+    /*
+     * TB lookup assumes that PC contains the complete virtual address.
+     * If we leave space+offset separate, we'll get ITLB misses to an
+     * incomplete virtual address.  This also means that we must separate
+     * out current cpu privilege from the low bits of IAOQ_F.
+     */
+#ifdef CONFIG_USER_ONLY
+    *pc = env->iaoq_f & -4;
+    *cs_base = env->iaoq_b & -4;
+    flags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
+#else
+    /* ??? E, T, H, L, B, P bits need to be here, when implemented.  */
+    flags |= env->psw & (PSW_W | PSW_C | PSW_D);
+    flags |= (env->iaoq_f & 3) << TB_FLAG_PRIV_SHIFT;
+
+    *pc = (env->psw & PSW_C
+           ? hppa_form_gva_psw(env->psw, env->iasq_f, env->iaoq_f & -4)
+           : env->iaoq_f & -4);
+    *cs_base = env->iasq_f;
+
+    /*
+     * Insert a difference between IAOQ_B and IAOQ_F within the otherwise zero
+     * low 32-bits of CS_BASE.  This will succeed for all direct branches,
+     * which is the primary case we care about -- using goto_tb within a page.
+     * Failure is indicated by a zero difference.
+     */
+    if (env->iasq_f == env->iasq_b) {
+        target_sreg diff = env->iaoq_b - env->iaoq_f;
+        if (TARGET_REGISTER_BITS == 32 || diff == (int32_t)diff) {
+            *cs_base |= (uint32_t)diff;
+        }
+    }
+    if ((env->sr[4] == env->sr[5])
+        & (env->sr[4] == env->sr[6])
+        & (env->sr[4] == env->sr[7])) {
+        flags |= TB_FLAG_SR_SAME;
+    }
+#endif
+
+    *pflags = flags;
+}
+
 static void hppa_cpu_set_pc(CPUState *cs, vaddr value)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3327ecf6db..7baf74fb9a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -52,6 +52,15 @@ int cpu_mmu_index(CPUX86State *env, bool ifetch)
         ? MMU_KNOSMAP_IDX : MMU_KSMAP_IDX;
 }
 
+void cpu_get_tb_cpu_state(CPUX86State *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    *cs_base = env->segs[R_CS].base;
+    *pc = *cs_base + env->eip;
+    *flags = env->hflags |
+        (env->eflags & (IOPL_MASK | TF_MASK | RF_MASK | VM_MASK | AC_MASK));
+}
+
 static void x86_cpu_realizefn(DeviceState *dev, Error **errp);
 
 /* Helpers for building CPUID[2] descriptors: */
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index c6c2760e46..cc53a7e51a 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -32,6 +32,17 @@ int cpu_mmu_index(CPULoongArchState *env, bool ifetch)
 #endif
 }
 
+void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    *pc = env->pc;
+    *cs_base = 0;
+    *flags = env->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
+    *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
+    *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
+    *flags |= is_va32(env) * HW_FLAGS_VA32;
+}
+
 const char * const regnames[32] = {
     "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
     "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15",
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 74da87f07e..9c664cb9a8 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -29,6 +29,22 @@ int cpu_mmu_index(CPUM68KState *env, bool ifetch)
     return (env->sr & SR_S) == 0 ? 1 : 0;
 }
 
+void cpu_get_tb_cpu_state(CPUM68KState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    *pc = env->pc;
+    *cs_base = 0;
+    *flags = (env->macsr >> 4) & TB_FLAGS_MACSR;
+    if (env->sr & SR_S) {
+        *flags |= TB_FLAGS_MSR_S;
+        *flags |= (env->sfc << (TB_FLAGS_SFC_S_BIT - 2)) & TB_FLAGS_SFC_S;
+        *flags |= (env->dfc << (TB_FLAGS_DFC_S_BIT - 2)) & TB_FLAGS_DFC_S;
+    }
+    if (M68K_SR_TRACE(env->sr) == M68K_SR_TRACE_ANY_INS) {
+        *flags |= TB_FLAGS_TRACE;
+    }
+}
+
 static void m68k_cpu_set_pc(CPUState *cs, vaddr value)
 {
     M68kCPU *cpu = M68K_CPU(cs);
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index f8891de41e..4c270e941f 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -47,6 +47,13 @@ int cpu_mmu_index(CPUMBState *env, bool ifetch)
     return MMU_KERNEL_IDX;
 }
 
+void cpu_get_tb_cpu_state(CPUMBState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    *pc = env->pc;
+    *flags = (env->iflags & IFLAGS_TB_MASK) | (env->msr & MSR_TB_MASK);
+    *cs_base = (*flags & IMM_FLAG ? env->imm : 0);
+}
 
 static const struct {
     const char *name;
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 1b5994e9a7..fe93acf28f 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -49,6 +49,15 @@ int cpu_mmu_index(CPUMIPSState *env, bool ifetch)
     return hflags_mmu_index(env->hflags);
 }
 
+void cpu_get_tb_cpu_state(CPUMIPSState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    *pc = env->active_tc.PC;
+    *cs_base = 0;
+    *flags = env->hflags & (MIPS_HFLAG_TMASK | MIPS_HFLAG_BMASK |
+                            MIPS_HFLAG_HWRENA_ULR);
+}
+
 const char regnames[32][3] = {
     "r0", "at", "v0", "v1", "a0", "a1", "a2", "a3",
     "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7",
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index 887a9bf786..868d75b165 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -32,6 +32,18 @@ int cpu_mmu_index(CPUNios2State *env, bool ifetch)
                                                   MMU_SUPERVISOR_IDX;
 }
 
+void cpu_get_tb_cpu_state(CPUNios2State *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    unsigned crs = FIELD_EX32(env->ctrl[CR_STATUS], CR_STATUS, CRS);
+
+    *pc = env->pc;
+    *cs_base = 0;
+    *flags = (env->ctrl[CR_STATUS] & CR_STATUS_U)
+           | (crs ? 0 : R_TBFLAGS_CRS0_MASK)
+           | (env->regs[0] ? 0 : R_TBFLAGS_R0_0_MASK);
+}
+
 static void nios2_cpu_set_pc(CPUState *cs, vaddr value)
 {
     Nios2CPU *cpu = NIOS2_CPU(cs);
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 5938d66da3..36d97d249d 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -37,6 +37,16 @@ int cpu_mmu_index(CPUOpenRISCState *env, bool ifetch)
     return ret;
 }
 
+void cpu_get_tb_cpu_state(CPUOpenRISCState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    *pc = env->pc;
+    *cs_base = 0;
+    *flags = (env->dflag ? TB_FLAGS_DFLAG : 0)
+           | (cpu_get_gpr(env, 0) ? 0 : TB_FLAGS_R0_0)
+           | (env->sr & (SR_SM | SR_DME | SR_IME | SR_OVE));
+}
+
 static void openrisc_cpu_set_pc(CPUState *cs, vaddr value)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index 53f1d5c370..046732857b 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -36,6 +36,17 @@ int cpu_mmu_index(CPUPPCState *env, bool ifetch)
 #endif
 }
 
+/* debug version defined in helper_hregs */
+#ifndef CONFIG_DEBUG_TCG
+void cpu_get_tb_cpu_state(CPUPPCState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    *pc = env->nip;
+    *cs_base = 0;
+    *flags = env->hflags;
+}
+#endif
+
 target_ulong cpu_read_xer(const CPUPPCState *env)
 {
     if (is_isa300(env)) {
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 1ce1da0a6b..688a70b707 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -31,6 +31,15 @@ int cpu_mmu_index(CPURXState *env, bool ifetch)
     return 0;
 }
 
+void cpu_get_tb_cpu_state(CPURXState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    *pc = env->pc;
+    *cs_base = 0;
+    *flags = FIELD_DP32(0, PSW, PM, env->psw_pm);
+    *flags = FIELD_DP32(*flags, PSW, U, env->psw_u);
+}
+
 static void rx_cpu_set_pc(CPUState *cs, vaddr value)
 {
     RXCPU *cpu = RX_CPU(cs);
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index aa574807f1..51c707ea12 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -72,6 +72,30 @@ int cpu_mmu_index(CPUS390XState *env, bool ifetch)
 #endif
 }
 
+void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    if (env->psw.addr & 1) {
+        /*
+         * Instructions must be at even addresses.
+         * This needs to be checked before address translation.
+         */
+        env->int_pgm_ilen = 2; /* see s390_cpu_tlb_fill() */
+#ifdef CONFIG_TCG
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, 0);
+#endif
+    }
+    *pc = env->psw.addr;
+    *cs_base = env->ex_value;
+    *flags = (env->psw.mask >> FLAG_MASK_PSW_SHIFT) & FLAG_MASK_PSW;
+    if (env->cregs[0] & CR0_AFP) {
+        *flags |= FLAG_MASK_AFP;
+    }
+    if (env->cregs[0] & CR0_VECTOR) {
+        *flags |= FLAG_MASK_VECTOR;
+    }
+}
+
 #ifndef CONFIG_USER_ONLY
 static bool is_early_exception_psw(uint64_t mask, uint64_t addr)
 {
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 6bffe52c04..ea7f13612e 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -41,6 +41,21 @@ int cpu_mmu_index(CPUSH4State *env, bool ifetch)
     }
 }
 
+void cpu_get_tb_cpu_state(CPUSH4State *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    *pc = env->pc;
+    /* For a gUSA region, notice the end of the region.  */
+    *cs_base = env->flags & TB_FLAG_GUSA_MASK ? env->gregs[0] : 0;
+    *flags = env->flags
+            | (env->fpscr & TB_FLAG_FPSCR_MASK)
+            | (env->sr & TB_FLAG_SR_MASK)
+            | (env->movcal_backup ? TB_FLAG_PENDING_MOVCA : 0); /* Bit 3 */
+#ifdef CONFIG_USER_ONLY
+    *flags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
+#endif
+}
+
 static void superh_cpu_set_pc(CPUState *cs, vaddr value)
 {
     SuperHCPU *cpu = SUPERH_CPU(cs);
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 256ba2be88..a6af3fd9ee 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -57,6 +57,41 @@ int cpu_mmu_index(CPUSPARCState *env, bool ifetch)
 #endif
 }
 
+void cpu_get_tb_cpu_state(CPUSPARCState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *pflags)
+{
+    uint32_t flags;
+    *pc = env->pc;
+    *cs_base = env->npc;
+    flags = cpu_mmu_index(env, false);
+#ifndef CONFIG_USER_ONLY
+    if (cpu_supervisor_mode(env)) {
+        flags |= TB_FLAG_SUPER;
+    }
+#endif
+#ifdef TARGET_SPARC64
+#ifndef CONFIG_USER_ONLY
+    if (cpu_hypervisor_mode(env)) {
+        flags |= TB_FLAG_HYPER;
+    }
+#endif
+    if (env->pstate & PS_AM) {
+        flags |= TB_FLAG_AM_ENABLED;
+    }
+    if ((env->def.features & CPU_FEATURE_FLOAT)
+        && (env->pstate & PS_PEF)
+        && (env->fprs & FPRS_FEF)) {
+        flags |= TB_FLAG_FPU_ENABLED;
+    }
+    flags |= env->asi << TB_FLAG_ASI_SHIFT;
+#else
+    if ((env->def.features & CPU_FEATURE_FLOAT) && env->psref) {
+        flags |= TB_FLAG_FPU_ENABLED;
+    }
+#endif
+    *pflags = flags;
+}
+
 static void sparc_cpu_reset_hold(Object *obj)
 {
     CPUState *s = CPU(obj);
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index a81f37e3e4..f8bf10569a 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -29,6 +29,18 @@ int cpu_mmu_index(CPUTriCoreState *env, bool ifetch)
     return 0;
 }
 
+void cpu_get_tb_cpu_state(CPUTriCoreState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    uint32_t new_flags = 0;
+    *pc = env->PC;
+    *cs_base = 0;
+
+    new_flags |= FIELD_DP32(new_flags, TB_FLAGS, PRIV,
+            extract32(env->PSW, 10, 2));
+    *flags = new_flags;
+}
+
 static inline void set_feature(CPUTriCoreState *env, int feature)
 {
     env->features |= 1ULL << feature;
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 769b3c9305..2c76ba86cd 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -44,6 +44,74 @@ int cpu_mmu_index(CPUXtensaState *env, bool ifetch)
     return xtensa_get_cring(env);
 }
 
+void cpu_get_tb_cpu_state(CPUXtensaState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    *pc = env->pc;
+    *cs_base = 0;
+    *flags = 0;
+    *flags |= xtensa_get_ring(env);
+    if (env->sregs[PS] & PS_EXCM) {
+        *flags |= XTENSA_TBFLAG_EXCM;
+    } else if (xtensa_option_enabled(env->config, XTENSA_OPTION_LOOP)) {
+        target_ulong lend_dist =
+            env->sregs[LEND] - (env->pc & -(1u << TARGET_PAGE_BITS));
+
+        /*
+         * 0 in the csbase_lend field means that there may not be a loopback
+         * for any instruction that starts inside this page. Any other value
+         * means that an instruction that ends at this offset from the page
+         * start may loop back and will need loopback code to be generated.
+         *
+         * lend_dist is 0 when LEND points to the start of the page, but
+         * no instruction that starts inside this page may end at offset 0,
+         * so it's still correct.
+         *
+         * When an instruction ends at a page boundary it may only start in
+         * the previous page. lend_dist will be encoded as TARGET_PAGE_SIZE
+         * for the TB that contains this instruction.
+         */
+        if (lend_dist < (1u << TARGET_PAGE_BITS) + env->config->max_insn_size) {
+            target_ulong lbeg_off = env->sregs[LEND] - env->sregs[LBEG];
+
+            *cs_base = lend_dist;
+            if (lbeg_off < 256) {
+                *cs_base |= lbeg_off << XTENSA_CSBASE_LBEG_OFF_SHIFT;
+            }
+        }
+    }
+    if (xtensa_option_enabled(env->config, XTENSA_OPTION_EXTENDED_L32R) &&
+            (env->sregs[LITBASE] & 1)) {
+        *flags |= XTENSA_TBFLAG_LITBASE;
+    }
+    if (xtensa_option_enabled(env->config, XTENSA_OPTION_DEBUG)) {
+        if (xtensa_get_cintlevel(env) < env->config->debug_level) {
+            *flags |= XTENSA_TBFLAG_DEBUG;
+        }
+        if (xtensa_get_cintlevel(env) < env->sregs[ICOUNTLEVEL]) {
+            *flags |= XTENSA_TBFLAG_ICOUNT;
+        }
+    }
+    if (xtensa_option_enabled(env->config, XTENSA_OPTION_COPROCESSOR)) {
+        *flags |= env->sregs[CPENABLE] << XTENSA_TBFLAG_CPENABLE_SHIFT;
+    }
+    if (xtensa_option_enabled(env->config, XTENSA_OPTION_WINDOWED_REGISTER) &&
+        (env->sregs[PS] & (PS_WOE | PS_EXCM)) == PS_WOE) {
+        uint32_t windowstart = xtensa_replicate_windowstart(env) >>
+            (env->sregs[WINDOW_BASE] + 1);
+        uint32_t w = ctz32(windowstart | 0x8);
+
+        *flags |= (w << XTENSA_TBFLAG_WINDOW_SHIFT) | XTENSA_TBFLAG_CWOE;
+        *flags |= extract32(env->sregs[PS], PS_CALLINC_SHIFT,
+                            PS_CALLINC_LEN) << XTENSA_TBFLAG_CALLINC_SHIFT;
+    } else {
+        *flags |= 3 << XTENSA_TBFLAG_WINDOW_SHIFT;
+    }
+    if (env->yield_needed) {
+        *flags |= XTENSA_TBFLAG_YIELD;
+    }
+}
+
 static void xtensa_cpu_set_pc(CPUState *cs, vaddr value)
 {
     XtensaCPU *cpu = XTENSA_CPU(cs);
-- 
2.43.0


