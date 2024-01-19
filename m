Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5449B832B84
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:44:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQq32-0005uY-1t; Fri, 19 Jan 2024 09:40:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2q-0005q4-SZ
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:35 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2i-0003sd-T4
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RJp3FDw6CrSCzKk75aUjlDvdhLiCJ8PHaUBmcDm9HLw=; b=WLkoLfZAgtmqctR5iZtWLTMUde
 jbOOfVaqcf0VJgQgbUCqMGWoHiL8e7bqwUyzpuEgPMXqAiPePT03Hq3pekaenn9Epunp/1bCQekoQ
 M7vuBp2mFEOY5lNULsOBWwPwt90QOzbOGFo41mNkCbCtVVD86bme9xEhPVxGyFmw+ikQ=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [RFC PATCH 12/34] target: Uninline cpu_mmu_index()
Date: Fri, 19 Jan 2024 15:40:02 +0100
Message-ID: <20240119144024.14289-13-anjo@rev.ng>
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

Uninlines the target-defined cpu_mmu_index() function by moving its
definition to target/*/cpu.c.  This allows for compiling memory access
functions in accel/tcg/cputlb.c without having to know target specifics.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/exec/cpu-common.h | 10 ++++++++++
 target/alpha/cpu.h        |  9 ---------
 target/arm/cpu.h          | 13 -------------
 target/avr/cpu.h          |  6 ------
 target/cris/cpu.h         |  4 ----
 target/hexagon/cpu.h      |  9 ---------
 target/hppa/cpu.h         | 12 ------------
 target/i386/cpu.h         |  7 -------
 target/loongarch/cpu.h    | 12 ------------
 target/m68k/cpu.h         |  4 ----
 target/microblaze/cpu.h   | 15 ---------------
 target/mips/cpu.h         | 14 +-------------
 target/nios2/cpu.h        |  6 ------
 target/openrisc/cpu.h     | 12 ------------
 target/ppc/cpu.h          |  8 --------
 target/riscv/cpu.h        |  2 --
 target/rx/cpu.h           |  5 -----
 target/s390x/cpu.h        | 31 -------------------------------
 target/sh4/cpu.h          | 10 ----------
 target/sparc/cpu.h        | 28 ----------------------------
 target/tricore/cpu.h      |  5 -----
 target/xtensa/cpu.h       |  5 -----
 target/alpha/cpu.c        |  8 ++++++++
 target/arm/cpu.c          |  5 +++++
 target/avr/cpu.c          |  5 +++++
 target/cris/cpu.c         |  4 ++++
 target/hexagon/cpu.c      |  9 +++++++++
 target/hppa/cpu.c         | 12 ++++++++++++
 target/i386/cpu.c         |  7 +++++++
 target/loongarch/cpu.c    | 12 ++++++++++++
 target/m68k/cpu.c         |  5 +++++
 target/microblaze/cpu.c   | 16 ++++++++++++++++
 target/mips/cpu.c         | 14 ++++++++++++++
 target/nios2/cpu.c        |  6 ++++++
 target/openrisc/cpu.c     | 12 ++++++++++++
 target/ppc/cpu.c          |  9 +++++++++
 target/riscv/cpu_helper.c |  2 +-
 target/rx/cpu.c           |  5 +++++
 target/s390x/cpu.c        | 31 +++++++++++++++++++++++++++++++
 target/sh4/cpu.c          | 13 +++++++++++++
 target/sparc/cpu.c        | 28 ++++++++++++++++++++++++++++
 target/tricore/cpu.c      |  5 +++++
 target/xtensa/cpu.c       |  4 ++++
 43 files changed, 222 insertions(+), 217 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 2eb6589764..12952c481c 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -60,6 +60,16 @@ void cpu_list_lock(void);
 void cpu_list_unlock(void);
 unsigned int cpu_list_generation_id_get(void);
 
+/**
+ * cpu_mmu_index:
+ * @env: The cpu environment
+ * @ifetch: True for code access, false for data access.
+ *
+ * Return the core mmu index for the current translation regime.
+ * This function is used by generic TCG code paths.
+ */
+int cpu_mmu_index(CPUArchState *env, bool ifetch);
+
 void tcg_flush_softmmu_tlb(CPUState *cs);
 void tcg_flush_jmp_cache(CPUState *cs);
 
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index e2a467ec17..e93186d50e 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -380,15 +380,6 @@ enum {
 
 #define TB_FLAG_UNALIGN       (1u << 1)
 
-static inline int cpu_mmu_index(CPUAlphaState *env, bool ifetch)
-{
-    int ret = env->flags & ENV_FLAG_PS_USER ? MMU_USER_IDX : MMU_KERNEL_IDX;
-    if (env->flags & ENV_FLAG_PAL_MODE) {
-        ret = MMU_KERNEL_IDX;
-    }
-    return ret;
-}
-
 enum {
     IR_V0   = 0,
     IR_T0   = 1,
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 51963b6545..3dfca8f3ae 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3167,19 +3167,6 @@ FIELD(TBFLAG_A64, NAA, 30, 1)
 #define EX_TBFLAG_M32(IN, WHICH)   FIELD_EX32(IN.flags2, TBFLAG_M32, WHICH)
 #define EX_TBFLAG_AM32(IN, WHICH)  FIELD_EX32(IN.flags2, TBFLAG_AM32, WHICH)
 
-/**
- * cpu_mmu_index:
- * @env: The cpu environment
- * @ifetch: True for code access, false for data access.
- *
- * Return the core mmu index for the current translation regime.
- * This function is used by generic TCG code paths.
- */
-static inline int cpu_mmu_index(CPUARMState *env, bool ifetch)
-{
-    return EX_TBFLAG_ANY(env->hflags, MMUIDX);
-}
-
 /**
  * sve_vq
  * @env: the cpu context
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 4ce22d8e4f..581ba54aae 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -172,12 +172,6 @@ static inline void set_avr_feature(CPUAVRState *env, int feature)
 }
 
 #define cpu_list avr_cpu_list
-#define cpu_mmu_index avr_cpu_mmu_index
-
-static inline int avr_cpu_mmu_index(CPUAVRState *env, bool ifetch)
-{
-    return ifetch ? MMU_CODE_IDX : MMU_DATA_IDX;
-}
 
 void avr_cpu_tcg_init(void);
 
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 676b8e93ca..9587a2a229 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -248,10 +248,6 @@ enum {
 
 /* MMU modes definitions */
 #define MMU_USER_IDX 1
-static inline int cpu_mmu_index (CPUCRISState *env, bool ifetch)
-{
-	return !!(env->pregs[PR_CCS] & U_FLAG);
-}
 
 /* Support function regs.  */
 #define SFR_RW_GC_CFG      0][0
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 10cd1efd57..562b5c7095 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -165,15 +165,6 @@ static inline void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
     *flags = hex_flags;
 }
 
-static inline int cpu_mmu_index(CPUHexagonState *env, bool ifetch)
-{
-#ifdef CONFIG_USER_ONLY
-    return MMU_USER_IDX;
-#else
-#error System mode not supported on Hexagon yet
-#endif
-}
-
 typedef HexagonCPU ArchCPU;
 
 void hexagon_translate_init(void);
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 7557f884b5..3da91d41d4 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -237,18 +237,6 @@ struct ArchCPU {
 
 #include "exec/cpu-all.h"
 
-static inline int cpu_mmu_index(CPUHPPAState *env, bool ifetch)
-{
-#ifdef CONFIG_USER_ONLY
-    return MMU_USER_IDX;
-#else
-    if (env->psw & (ifetch ? PSW_C : PSW_D)) {
-        return PRIV_TO_MMU_IDX(env->iaoq_f & 3);
-    }
-    return MMU_PHYS_IDX;  /* mmu disabled */
-#endif
-}
-
 void hppa_translate_init(void);
 
 #define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e1b41c29f0..7de2bad701 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2259,13 +2259,6 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 #define MMU_NESTED_IDX  3
 #define MMU_PHYS_IDX    4
 
-static inline int cpu_mmu_index(CPUX86State *env, bool ifetch)
-{
-    return (env->hflags & HF_CPL_MASK) == 3 ? MMU_USER_IDX :
-        (!(env->hflags & HF_SMAP_MASK) || (env->eflags & AC_MASK))
-        ? MMU_KNOSMAP_IDX : MMU_KSMAP_IDX;
-}
-
 static inline int cpu_mmu_index_kernel(CPUX86State *env)
 {
     return !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP_IDX :
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 3b5ec51928..d85103c28d 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -415,18 +415,6 @@ struct LoongArchCPUClass {
 #define MMU_IDX_USER     MMU_PLV_USER
 #define MMU_IDX_DA       4
 
-static inline int cpu_mmu_index(CPULoongArchState *env, bool ifetch)
-{
-#ifdef CONFIG_USER_ONLY
-    return MMU_IDX_USER;
-#else
-    if (FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG)) {
-        return FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV);
-    }
-    return MMU_IDX_DA;
-#endif
-}
-
 static inline bool is_la64(CPULoongArchState *env)
 {
     return FIELD_EX32(env->cpucfg[1], CPUCFG1, ARCH) == CPUCFG1_ARCH_LA64;
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 20afb0c94d..da13111fd8 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -572,10 +572,6 @@ enum {
 /* MMU modes definitions */
 #define MMU_KERNEL_IDX 0
 #define MMU_USER_IDX 1
-static inline int cpu_mmu_index (CPUM68KState *env, bool ifetch)
-{
-    return (env->sr & SR_S) == 0 ? 1 : 0;
-}
 
 bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                        MMUAccessType access_type, int mmu_idx,
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index e43c49d4af..8f8b4f55d4 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -423,21 +423,6 @@ void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                MemTxResult response, uintptr_t retaddr);
 #endif
 
-static inline int cpu_mmu_index(CPUMBState *env, bool ifetch)
-{
-    MicroBlazeCPU *cpu = env_archcpu(env);
-
-    /* Are we in nommu mode?.  */
-    if (!(env->msr & MSR_VM) || !cpu->cfg.use_mmu) {
-        return MMU_NOMMU_IDX;
-    }
-
-    if (env->msr & MSR_UM) {
-        return MMU_USER_IDX;
-    }
-    return MMU_KERNEL_IDX;
-}
-
 #ifndef CONFIG_USER_ONLY
 extern const VMStateDescription vmstate_mb_cpu;
 #endif
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 67f8e8b988..49915af09d 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1233,19 +1233,7 @@ uint32_t cpu_rddsp(uint32_t mask_num, CPUMIPSState *env);
  */
 #define MMU_USER_IDX 2
 
-static inline int hflags_mmu_index(uint32_t hflags)
-{
-    if (hflags & MIPS_HFLAG_ERL) {
-        return 3; /* ERL */
-    } else {
-        return hflags & MIPS_HFLAG_KSU;
-    }
-}
-
-static inline int cpu_mmu_index(CPUMIPSState *env, bool ifetch)
-{
-    return hflags_mmu_index(env->hflags);
-}
+int hflags_mmu_index(uint32_t hflags);
 
 #include "exec/cpu-all.h"
 
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 70b6377a4f..c1d4fc6542 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -279,12 +279,6 @@ void do_nios2_semihosting(CPUNios2State *env);
 #define MMU_SUPERVISOR_IDX  0
 #define MMU_USER_IDX        1
 
-static inline int cpu_mmu_index(CPUNios2State *env, bool ifetch)
-{
-    return (env->ctrl[CR_STATUS] & CR_STATUS_U) ? MMU_USER_IDX :
-                                                  MMU_SUPERVISOR_IDX;
-}
-
 #ifndef CONFIG_USER_ONLY
 hwaddr nios2_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 bool nios2_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 334997e9a1..d57f820743 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -376,18 +376,6 @@ static inline void cpu_get_tb_cpu_state(CPUOpenRISCState *env, vaddr *pc,
            | (env->sr & (SR_SM | SR_DME | SR_IME | SR_OVE));
 }
 
-static inline int cpu_mmu_index(CPUOpenRISCState *env, bool ifetch)
-{
-    int ret = MMU_NOMMU_IDX;  /* mmu is disabled */
-
-    if (env->sr & (ifetch ? SR_IME : SR_DME)) {
-        /* The mmu is enabled; test supervisor state.  */
-        ret = env->sr & SR_SM ? MMU_SUPERVISOR_IDX : MMU_USER_IDX;
-    }
-
-    return ret;
-}
-
 static inline uint32_t cpu_get_sr(const CPUOpenRISCState *env)
 {
     return (env->sr
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index f5027616fa..faba987dc0 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1483,14 +1483,6 @@ int ppc_dcr_write(ppc_dcr_t *dcr_env, int dcrn, uint32_t val);
 
 /* MMU modes definitions */
 #define MMU_USER_IDX 0
-static inline int cpu_mmu_index(CPUPPCState *env, bool ifetch)
-{
-#ifdef CONFIG_USER_ONLY
-    return MMU_USER_IDX;
-#else
-    return (env->hflags >> (ifetch ? HFLAGS_IMMU_IDX : HFLAGS_DMMU_IDX)) & 7;
-#endif
-}
 
 /* Compatibility modes */
 #if defined(TARGET_PPC64)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index ef9cf21c0c..9b0590c7d9 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -434,7 +434,6 @@ target_ulong riscv_cpu_get_geilen(CPURISCVState *env);
 void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen);
 bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
-int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
 G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                                MMUAccessType access_type,
                                                int mmu_idx, uintptr_t retaddr);
@@ -446,7 +445,6 @@ void riscv_cpu_list(void);
 void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp);
 
 #define cpu_list riscv_cpu_list
-#define cpu_mmu_index riscv_cpu_mmu_index
 
 #ifndef CONFIG_USER_ONLY
 void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index f66754eb8a..3f5b501acf 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -151,11 +151,6 @@ static inline void cpu_get_tb_cpu_state(CPURXState *env, vaddr *pc,
     *flags = FIELD_DP32(*flags, PSW, U, env->psw_u);
 }
 
-static inline int cpu_mmu_index(CPURXState *env, bool ifetch)
-{
-    return 0;
-}
-
 static inline uint32_t rx_cpu_pack_psw(CPURXState *env)
 {
     uint32_t psw = 0;
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 7bea7075e1..5c646cafaa 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -348,37 +348,6 @@ extern const VMStateDescription vmstate_s390_cpu;
 #define MMU_HOME_IDX            2
 #define MMU_REAL_IDX            3
 
-static inline int cpu_mmu_index(CPUS390XState *env, bool ifetch)
-{
-#ifdef CONFIG_USER_ONLY
-    return MMU_USER_IDX;
-#else
-    if (!(env->psw.mask & PSW_MASK_DAT)) {
-        return MMU_REAL_IDX;
-    }
-
-    if (ifetch) {
-        if ((env->psw.mask & PSW_MASK_ASC) == PSW_ASC_HOME) {
-            return MMU_HOME_IDX;
-        }
-        return MMU_PRIMARY_IDX;
-    }
-
-    switch (env->psw.mask & PSW_MASK_ASC) {
-    case PSW_ASC_PRIMARY:
-        return MMU_PRIMARY_IDX;
-    case PSW_ASC_SECONDARY:
-        return MMU_SECONDARY_IDX;
-    case PSW_ASC_HOME:
-        return MMU_HOME_IDX;
-    case PSW_ASC_ACCREG:
-        /* Fallthrough: access register mode is not yet supported */
-    default:
-        abort();
-    }
-#endif
-}
-
 static inline void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index f75a235973..218ba24333 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -260,16 +260,6 @@ void cpu_load_tlb(CPUSH4State * env);
 
 /* MMU modes definitions */
 #define MMU_USER_IDX 1
-static inline int cpu_mmu_index (CPUSH4State *env, bool ifetch)
-{
-    /* The instruction in a RTE delay slot is fetched in privileged
-       mode, but executed in user mode.  */
-    if (ifetch && (env->flags & TB_FLAG_DELAY_SLOT_RTE)) {
-        return 0;
-    } else {
-        return (env->sr & (1u << SR_MD)) == 0 ? 1 : 0;
-    }
-}
 
 #include "exec/cpu-all.h"
 
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index b3a98f1d74..bd24cd578c 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -692,34 +692,6 @@ static inline int cpu_supervisor_mode(CPUSPARCState *env1)
 }
 #endif
 
-static inline int cpu_mmu_index(CPUSPARCState *env, bool ifetch)
-{
-#if defined(CONFIG_USER_ONLY)
-    return MMU_USER_IDX;
-#elif !defined(TARGET_SPARC64)
-    if ((env->mmuregs[0] & MMU_E) == 0) { /* MMU disabled */
-        return MMU_PHYS_IDX;
-    } else {
-        return env->psrs;
-    }
-#else
-    /* IMMU or DMMU disabled.  */
-    if (ifetch
-        ? (env->lsu & IMMU_E) == 0 || (env->pstate & PS_RED) != 0
-        : (env->lsu & DMMU_E) == 0) {
-        return MMU_PHYS_IDX;
-    } else if (cpu_hypervisor_mode(env)) {
-        return MMU_PHYS_IDX;
-    } else if (env->tl > 0) {
-        return MMU_NUCLEUS_IDX;
-    } else if (cpu_supervisor_mode(env)) {
-        return MMU_KERNEL_IDX;
-    } else {
-        return MMU_USER_IDX;
-    }
-#endif
-}
-
 static inline int cpu_interrupts_enabled(CPUSPARCState *env1)
 {
 #if !defined (TARGET_SPARC64)
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 217937bbf6..9454b0adcd 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -371,11 +371,6 @@ void tricore_cpu_list(void);
 
 #define cpu_list tricore_cpu_list
 
-static inline int cpu_mmu_index(CPUTriCoreState *env, bool ifetch)
-{
-    return 0;
-}
-
 #include "exec/cpu-all.h"
 
 FIELD(TB_FLAGS, PRIV, 0, 2)
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index c6bbef1e5d..89d6b690af 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -700,11 +700,6 @@ static inline uint32_t xtensa_replicate_windowstart(CPUXtensaState *env)
 /* MMU modes definitions */
 #define MMU_USER_IDX 3
 
-static inline int cpu_mmu_index(CPUXtensaState *env, bool ifetch)
-{
-    return xtensa_get_cring(env);
-}
-
 #define XTENSA_TBFLAG_RING_MASK 0x3
 #define XTENSA_TBFLAG_EXCM 0x4
 #define XTENSA_TBFLAG_LITBASE 0x8
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 51b7d8d1bf..2559ce38ee 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -25,6 +25,14 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 
+int cpu_mmu_index(CPUAlphaState *env, bool ifetch)
+{
+    int ret = env->flags & ENV_FLAG_PS_USER ? MMU_USER_IDX : MMU_KERNEL_IDX;
+    if (env->flags & ENV_FLAG_PAL_MODE) {
+        ret = MMU_KERNEL_IDX;
+    }
+    return ret;
+}
 
 static void alpha_cpu_set_pc(CPUState *cs, vaddr value)
 {
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 374ef523da..6f640b0e78 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -49,6 +49,11 @@
 #include "fpu/softfloat.h"
 #include "cpregs.h"
 
+int cpu_mmu_index(CPUARMState *env, bool ifetch)
+{
+    return EX_TBFLAG_ANY(env->hflags, MMUIDX);
+}
+
 static void arm_cpu_set_pc(CPUState *cs, vaddr value)
 {
     ARMCPU *cpu = ARM_CPU(cs);
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 14d8b9d1f0..38263d07dd 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -26,6 +26,11 @@
 #include "disas/dis-asm.h"
 #include "tcg/debug-assert.h"
 
+int cpu_mmu_index(CPUAVRState *env, bool ifetch)
+{
+    return ifetch ? MMU_CODE_IDX : MMU_DATA_IDX;
+}
+
 static void avr_cpu_set_pc(CPUState *cs, vaddr value)
 {
     AVRCPU *cpu = AVR_CPU(cs);
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index be4a44c218..553742a068 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -27,6 +27,10 @@
 #include "cpu.h"
 #include "mmu.h"
 
+int cpu_mmu_index(CPUCRISState *env, bool ifetch)
+{
+    return !!(env->pregs[PR_CCS] & U_FLAG);
+}
 
 static void cris_cpu_set_pc(CPUState *cs, vaddr value)
 {
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 1adc11b713..bf7c901705 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -26,6 +26,15 @@
 #include "tcg/tcg.h"
 #include "exec/gdbstub.h"
 
+int cpu_mmu_index(CPUHexagonState *env, bool ifetch)
+{
+#ifdef CONFIG_USER_ONLY
+    return MMU_USER_IDX;
+#else
+#error System mode not supported on Hexagon yet
+#endif
+}
+
 static void hexagon_v67_cpu_init(Object *obj) { }
 static void hexagon_v68_cpu_init(Object *obj) { }
 static void hexagon_v69_cpu_init(Object *obj) { }
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 1644297bf8..22f031758e 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -28,6 +28,18 @@
 #include "fpu/softfloat.h"
 #include "tcg/tcg.h"
 
+int cpu_mmu_index(CPUHPPAState *env, bool ifetch)
+{
+#ifdef CONFIG_USER_ONLY
+    return MMU_USER_IDX;
+#else
+    if (env->psw & (ifetch ? PSW_C : PSW_D)) {
+        return PRIV_TO_MMU_IDX(env->iaoq_f & 3);
+    }
+    return MMU_PHYS_IDX;  /* mmu disabled */
+#endif
+}
+
 static void hppa_cpu_set_pc(CPUState *cs, vaddr value)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 66ab092628..3327ecf6db 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -45,6 +45,13 @@
 #include "disas/capstone.h"
 #include "cpu-internal.h"
 
+int cpu_mmu_index(CPUX86State *env, bool ifetch)
+{
+    return (env->hflags & HF_CPL_MASK) == 3 ? MMU_USER_IDX :
+        (!(env->hflags & HF_SMAP_MASK) || (env->eflags & AC_MASK))
+        ? MMU_KNOSMAP_IDX : MMU_KSMAP_IDX;
+}
+
 static void x86_cpu_realizefn(DeviceState *dev, Error **errp);
 
 /* Helpers for building CPUID[2] descriptors: */
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index e70773c22e..c6c2760e46 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -20,6 +20,18 @@
 #include "sysemu/reset.h"
 #include "tcg/tcg.h"
 
+int cpu_mmu_index(CPULoongArchState *env, bool ifetch)
+{
+#ifdef CONFIG_USER_ONLY
+    return MMU_IDX_USER;
+#else
+    if (FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG)) {
+        return FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV);
+    }
+    return MMU_IDX_DA;
+#endif
+}
+
 const char * const regnames[32] = {
     "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
     "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15",
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 538d9473c2..74da87f07e 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -24,6 +24,11 @@
 #include "migration/vmstate.h"
 #include "fpu/softfloat.h"
 
+int cpu_mmu_index(CPUM68KState *env, bool ifetch)
+{
+    return (env->sr & SR_S) == 0 ? 1 : 0;
+}
+
 static void m68k_cpu_set_pc(CPUState *cs, vaddr value)
 {
     M68kCPU *cpu = M68K_CPU(cs);
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index bbb3335cad..f8891de41e 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -32,6 +32,22 @@
 #include "fpu/softfloat-helpers.h"
 #include "tcg/tcg.h"
 
+int cpu_mmu_index(CPUMBState *env, bool ifetch)
+{
+    MicroBlazeCPU *cpu = env_archcpu(env);
+
+    /* Are we in nommu mode?.  */
+    if (!(env->msr & MSR_VM) || !cpu->cfg.use_mmu) {
+        return MMU_NOMMU_IDX;
+    }
+
+    if (env->msr & MSR_UM) {
+        return MMU_USER_IDX;
+    }
+    return MMU_KERNEL_IDX;
+}
+
+
 static const struct {
     const char *name;
     uint8_t version_id;
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index a0023edd43..1b5994e9a7 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -35,6 +35,20 @@
 #include "semihosting/semihost.h"
 #include "fpu_helper.h"
 
+int hflags_mmu_index(uint32_t hflags)
+{
+    if (hflags & MIPS_HFLAG_ERL) {
+        return 3; /* ERL */
+    } else {
+        return hflags & MIPS_HFLAG_KSU;
+    }
+}
+
+int cpu_mmu_index(CPUMIPSState *env, bool ifetch)
+{
+    return hflags_mmu_index(env->hflags);
+}
+
 const char regnames[32][3] = {
     "r0", "at", "v0", "v1", "a0", "a1", "a2", "a3",
     "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7",
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index 15e499f828..887a9bf786 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -26,6 +26,12 @@
 #include "gdbstub/helpers.h"
 #include "hw/qdev-properties.h"
 
+int cpu_mmu_index(CPUNios2State *env, bool ifetch)
+{
+    return (env->ctrl[CR_STATUS] & CR_STATUS_U) ? MMU_USER_IDX :
+                                                  MMU_SUPERVISOR_IDX;
+}
+
 static void nios2_cpu_set_pc(CPUState *cs, vaddr value)
 {
     Nios2CPU *cpu = NIOS2_CPU(cs);
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index f5a3d5273b..5938d66da3 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -25,6 +25,18 @@
 #include "fpu/softfloat-helpers.h"
 #include "tcg/tcg.h"
 
+int cpu_mmu_index(CPUOpenRISCState *env, bool ifetch)
+{
+    int ret = MMU_NOMMU_IDX;  /* mmu is disabled */
+
+    if (env->sr & (ifetch ? SR_IME : SR_DME)) {
+        /* The mmu is enabled; test supervisor state.  */
+        ret = env->sr & SR_SM ? MMU_SUPERVISOR_IDX : MMU_USER_IDX;
+    }
+
+    return ret;
+}
+
 static void openrisc_cpu_set_pc(CPUState *cs, vaddr value)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index e3ad8e0c27..53f1d5c370 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -27,6 +27,15 @@
 #include "helper_regs.h"
 #include "sysemu/tcg.h"
 
+int cpu_mmu_index(CPUPPCState *env, bool ifetch)
+{
+#ifdef CONFIG_USER_ONLY
+    return MMU_USER_IDX;
+#else
+    return (env->hflags >> (ifetch ? HFLAGS_IMMU_IDX : HFLAGS_DMMU_IDX)) & 7;
+#endif
+}
+
 target_ulong cpu_read_xer(const CPUPPCState *env)
 {
     if (is_isa300(env)) {
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 3a02079290..537a56ed27 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -33,7 +33,7 @@
 #include "debug.h"
 #include "tcg/oversized-guest.h"
 
-int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
+int cpu_mmu_index(CPURISCVState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
     return 0;
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 4d0d3a0c8c..1ce1da0a6b 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -26,6 +26,11 @@
 #include "fpu/softfloat.h"
 #include "tcg/debug-assert.h"
 
+int cpu_mmu_index(CPURXState *env, bool ifetch)
+{
+    return 0;
+}
+
 static void rx_cpu_set_pc(CPUState *cs, vaddr value)
 {
     RXCPU *cpu = RX_CPU(cs);
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 4f7599d72c..aa574807f1 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -41,6 +41,37 @@
 #define CR0_RESET       0xE0UL
 #define CR14_RESET      0xC2000000UL;
 
+int cpu_mmu_index(CPUS390XState *env, bool ifetch)
+{
+#ifdef CONFIG_USER_ONLY
+    return MMU_USER_IDX;
+#else
+    if (!(env->psw.mask & PSW_MASK_DAT)) {
+        return MMU_REAL_IDX;
+    }
+
+    if (ifetch) {
+        if ((env->psw.mask & PSW_MASK_ASC) == PSW_ASC_HOME) {
+            return MMU_HOME_IDX;
+        }
+        return MMU_PRIMARY_IDX;
+    }
+
+    switch (env->psw.mask & PSW_MASK_ASC) {
+    case PSW_ASC_PRIMARY:
+        return MMU_PRIMARY_IDX;
+    case PSW_ASC_SECONDARY:
+        return MMU_SECONDARY_IDX;
+    case PSW_ASC_HOME:
+        return MMU_HOME_IDX;
+    case PSW_ASC_ACCREG:
+        /* Fallthrough: access register mode is not yet supported */
+    default:
+        abort();
+    }
+#endif
+}
+
 #ifndef CONFIG_USER_ONLY
 static bool is_early_exception_psw(uint64_t mask, uint64_t addr)
 {
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 788e41fea6..6bffe52c04 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -28,6 +28,19 @@
 #include "fpu/softfloat-helpers.h"
 #include "tcg/tcg.h"
 
+int cpu_mmu_index(CPUSH4State *env, bool ifetch)
+{
+    /*
+     * The instruction in a RTE delay slot is fetched in privileged
+     * mode, but executed in user mode.
+     */
+    if (ifetch && (env->flags & TB_FLAG_DELAY_SLOT_RTE)) {
+        return 0;
+    } else {
+        return (env->sr & (1u << SR_MD)) == 0 ? 1 : 0;
+    }
+}
+
 static void superh_cpu_set_pc(CPUState *cs, vaddr value)
 {
     SuperHCPU *cpu = SUPERH_CPU(cs);
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 8ba96ae225..256ba2be88 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -29,6 +29,34 @@
 
 //#define DEBUG_FEATURES
 
+int cpu_mmu_index(CPUSPARCState *env, bool ifetch)
+{
+#if defined(CONFIG_USER_ONLY)
+    return MMU_USER_IDX;
+#elif !defined(TARGET_SPARC64)
+    if ((env->mmuregs[0] & MMU_E) == 0) { /* MMU disabled */
+        return MMU_PHYS_IDX;
+    } else {
+        return env->psrs;
+    }
+#else
+    /* IMMU or DMMU disabled.  */
+    if (ifetch
+        ? (env->lsu & IMMU_E) == 0 || (env->pstate & PS_RED) != 0
+        : (env->lsu & DMMU_E) == 0) {
+        return MMU_PHYS_IDX;
+    } else if (cpu_hypervisor_mode(env)) {
+        return MMU_PHYS_IDX;
+    } else if (env->tl > 0) {
+        return MMU_NUCLEUS_IDX;
+    } else if (cpu_supervisor_mode(env)) {
+        return MMU_KERNEL_IDX;
+    } else {
+        return MMU_USER_IDX;
+    }
+#endif
+}
+
 static void sparc_cpu_reset_hold(Object *obj)
 {
     CPUState *s = CPU(obj);
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index d1477622e6..a81f37e3e4 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -24,6 +24,11 @@
 #include "qemu/error-report.h"
 #include "tcg/debug-assert.h"
 
+int cpu_mmu_index(CPUTriCoreState *env, bool ifetch)
+{
+    return 0;
+}
+
 static inline void set_feature(CPUTriCoreState *env, int feature)
 {
     env->features |= 1ULL << feature;
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index ea1dae7390..769b3c9305 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -39,6 +39,10 @@
 #include "exec/memory.h"
 #endif
 
+int cpu_mmu_index(CPUXtensaState *env, bool ifetch)
+{
+    return xtensa_get_cring(env);
+}
 
 static void xtensa_cpu_set_pc(CPUState *cs, vaddr value)
 {
-- 
2.43.0


