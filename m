Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC065AA6574
	for <lists+qemu-devel@lfdr.de>; Thu,  1 May 2025 23:28:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLr-00012I-1Z; Thu, 01 May 2025 17:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLk-0000yt-NZ
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:45 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLf-0001Y5-U7
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:44 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so1691123b3a.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134498; x=1746739298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eqgq53P8go7GbjpbQfo5/cBeTkOCPr27bFA5RO1C29o=;
 b=UMaatoarcWOQx0MO7zbrI6nJbtLMtPA0HicRpQEQPwPebJqRHoUTfUN81BnTox72Gr
 TxE3APHZJLUkWkN1OApU77JMHAtMiMI9uVKJ+hkf0L6zKj6/snOHMFFVnKqkp79aLYkj
 rLtTS5WMODdUpVm8+4Zve/BdJC+2r3MjMCgNChAr40pRKmyVTH368HxBRmaBw8dqb+yM
 LV5S5DUC1mJmdt4fd8cSgruhDHhK8jHR7ZJnAMmQskPd94OuwqrKPB2J+ZM4tR0SmzdX
 THOGkaGFzb4ofkn340Z8K7KRP/p7HIaoB1QA4M+Fr+6ebS/02DzVWWdUOPJA5YAxYwb2
 vU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134498; x=1746739298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eqgq53P8go7GbjpbQfo5/cBeTkOCPr27bFA5RO1C29o=;
 b=ZFP/SZ/3qmNH4TT+uTE0tV2fBIx48IdmK6jz7bpOmPGgYf1cbjxGwFOoT4m8r+Q7WU
 9rGjKnnCgexKBtza3SrzMFL8FRFf+ulZGu5d3hi6ry28QKOhOcrUu3G+LfAl5JOcpzg/
 KdidgpqEcRNkKvPZv2b4ZxlMvGWEuecH+rCUBxhp8i1YWv7EDkNMJzslC4RDzmBZ75sF
 hsKk7QbkBZaMdw8hBYuzyuTOevZZo6tA5H+6EP8vIlSzfkuAPXj35Qps6Lec0AuAOQDI
 PAK5vRH5QS17uh9oFcHfEpALc/tb46+Oz6tN+ui+8n3hpnQJk4k48E7XJlbbiqFKyrWj
 407A==
X-Gm-Message-State: AOJu0YynPameSJbn1pVAKHOsd5IKxakMQQHZ3PT9HciTgle2JT+msMFr
 vf9XzXvTOnb/3kBNs4WEVJTYnrzEQgfcPCT68pZ0ctQbu6MTPO2RBcTxxvIEaVeKupyQ+F9VZI1
 m
X-Gm-Gg: ASbGncsVCqSBSYgTHkzbu694RZYah2lTe+mcesZkGdLVPqPpzTAFribV+RT7KTR6W5Z
 PQ52sTVPjIOTl+EpXi+u0C+93WVcuPLRj5wIn8ulqXBViyFFtx7KYx4skf1O7mparEIqGdH18kv
 pIHKISmch49xWxy5y2II3qgMQj0J9mmb6jdDIpw9RrmCyGPgRP1tNAa2UBr/U+Fgf/HRtQ4tZu8
 wHXDxpDEYWn3M4PSk9jmvKldXCIvC4OAAqXPrDc3HxT6piM4AuMK+vCN2cG5bYs+adDfnuiL8Zp
 mEHIC553etHFtTs4cSNBCeVPpXVpEV53j5EEUFaGbIoNjOMZb9EPOehOok/AyVzK8g/hL1m2zFQ
 T6xVnMC9NzQ==
X-Google-Smtp-Source: AGHT+IGn5wdNiMrBRpxcSWSwwViu1xhhO8kcOwuEMceWCvNX6DjaKuGxwhMDPfKptCegv9T/K5yimQ==
X-Received: by 2002:a17:90a:c88b:b0:308:5273:4dee with SMTP id
 98e67ed59e1d1-30a4e5b9967mr984843a91.15.1746134498235; 
 Thu, 01 May 2025 14:21:38 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 28/59] accel/tcg: Hoist cpu_get_tb_cpu_state decl to
 accl/tcg/cpu-ops.h
Date: Thu,  1 May 2025 14:20:42 -0700
Message-ID: <20250501212113.2961531-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

For some targets, simply remove the local definition.
For other targets, move the inline definition out of line.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ops.h |  3 ++
 target/alpha/cpu.h          | 11 ------
 target/arm/cpu.h            |  3 --
 target/avr/cpu.h            | 18 ----------
 target/hexagon/cpu.h        | 15 --------
 target/hppa/cpu.h           |  3 --
 target/i386/cpu.h           | 14 --------
 target/loongarch/cpu.h      | 12 -------
 target/m68k/cpu.h           | 16 ---------
 target/microblaze/cpu.h     |  8 -----
 target/mips/cpu.h           |  9 -----
 target/openrisc/cpu.h       | 10 ------
 target/ppc/cpu.h            | 13 -------
 target/riscv/cpu.h          |  3 --
 target/rx/cpu.h             |  9 -----
 target/s390x/cpu.h          |  9 -----
 target/sh4/cpu.h            | 15 --------
 target/sparc/cpu.h          |  3 --
 target/tricore/cpu.h        | 12 -------
 target/xtensa/cpu.h         | 68 -----------------------------------
 target/alpha/cpu.c          | 14 ++++++--
 target/arm/helper.c         |  1 +
 target/avr/cpu.c            | 21 +++++++++--
 target/hexagon/cpu.c        | 18 ++++++++--
 target/hppa/cpu.c           |  3 +-
 target/i386/tcg/tcg-cpu.c   | 17 +++++++--
 target/loongarch/cpu.c      | 15 ++++++--
 target/m68k/cpu.c           | 19 ++++++++--
 target/microblaze/cpu.c     | 11 ++++--
 target/mips/cpu.c           |  9 +++++
 target/openrisc/cpu.c       | 13 +++++--
 target/ppc/helper_regs.c    | 16 ++++-----
 target/rx/cpu.c             | 12 +++++--
 target/s390x/cpu.c          |  1 +
 target/sh4/cpu.c            | 18 ++++++++--
 target/tricore/cpu.c        | 15 ++++++--
 target/xtensa/cpu.c         | 71 +++++++++++++++++++++++++++++++++++--
 37 files changed, 243 insertions(+), 285 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 3ff72b8d9d..f5e5746976 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -18,6 +18,9 @@
 #include "exec/vaddr.h"
 #include "tcg/tcg-mo.h"
 
+void cpu_get_tb_cpu_state(CPUArchState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags);
+
 struct TCGCPUOps {
     /**
      * mttcg_supported: multi-threaded TCG is supported
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 849f673489..45944e46b5 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -464,17 +464,6 @@ void alpha_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
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
index fdcf8cd1ae..be4449ca06 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3119,9 +3119,6 @@ static inline bool bswap_code(bool sctlr_b)
 #endif
 }
 
-void cpu_get_tb_cpu_state(CPUARMState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *flags);
-
 enum {
     QEMU_PSCI_CONDUIT_DISABLED = 0,
     QEMU_PSCI_CONDUIT_SMC = 1,
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index d6666175a9..518e243d81 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -205,24 +205,6 @@ enum {
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
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index c065fa8ddc..43a854f517 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -137,21 +137,6 @@ G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
                                             uint32_t exception,
                                             uintptr_t pc);
 
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
-    if (*pc & PCALIGN_MASK) {
-        hexagon_raise_exception_err(env, HEX_CAUSE_PC_NOT_ALIGNED, 0);
-    }
-}
-
 typedef HexagonCPU ArchCPU;
 
 void hexagon_translate_init(void);
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index acc9937240..11d59d11ca 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -351,9 +351,6 @@ hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr);
 #define CS_BASE_DIFFPAGE    (1 << 12)
 #define CS_BASE_DIFFSPACE   (1 << 13)
 
-void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *pflags);
-
 target_ulong cpu_hppa_get_psw(CPUHPPAState *env);
 void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong);
 void update_gva_offset_mask(CPUHPPAState *env);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 3182ba413b..4f8ed8868e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2599,20 +2599,6 @@ static inline bool is_mmu_index_32(int mmu_index)
 #include "hw/i386/apic.h"
 #endif
 
-static inline void cpu_get_tb_cpu_state(CPUX86State *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *flags = env->hflags |
-        (env->eflags & (IOPL_MASK | TF_MASK | RF_MASK | VM_MASK | AC_MASK));
-    if (env->hflags & HF_CS64_MASK) {
-        *cs_base = 0;
-        *pc = env->eip;
-    } else {
-        *cs_base = env->segs[R_CS].base;
-        *pc = (uint32_t)(*cs_base + env->eip);
-    }
-}
-
 void do_cpu_init(X86CPU *cpu);
 
 #define MCE_INJECT_BROADCAST    1
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 70ff56e60c..262bf87f7b 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -492,18 +492,6 @@ static inline void set_pc(CPULoongArchState *env, uint64_t value)
 #define HW_FLAGS_VA32       0x20
 #define HW_FLAGS_EUEN_ASXE  0x40
 
-static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *pc = env->pc;
-    *cs_base = 0;
-    *flags = env->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
-    *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
-    *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
-    *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, ASXE) * HW_FLAGS_EUEN_ASXE;
-    *flags |= is_va32(env) * HW_FLAGS_VA32;
-}
-
 #define CPU_RESOLVING_TYPE TYPE_LOONGARCH_CPU
 
 void loongarch_cpu_post_init(Object *obj);
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 39d0b9d6d7..d9db6a486a 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -605,22 +605,6 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
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
index d511f22a55..6ad8643f2e 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -419,14 +419,6 @@ static inline bool mb_cpu_is_big_endian(CPUState *cs)
     return !cpu->cfg.endi;
 }
 
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
index d16f9a7220..5cd4c6c818 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1366,15 +1366,6 @@ void cpu_mips_clock_init(MIPSCPU *cpu);
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
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 569819bfb0..f4bcf00b07 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -349,16 +349,6 @@ static inline void cpu_set_gpr(CPUOpenRISCState *env, int i, uint32_t val)
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
index 13115a89ff..6b90543811 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2751,19 +2751,6 @@ void cpu_write_xer(CPUPPCState *env, target_ulong xer);
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
 G_NORETURN void raise_exception_err_ra(CPUPPCState *env, uint32_t exception,
                                        uint32_t error_code, uintptr_t raddr);
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 167909c89b..c66ac3bc27 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -802,9 +802,6 @@ static inline uint32_t vext_get_vlmax(uint32_t vlenb, uint32_t vsew,
     return vlen >> (vsew + 3 - lmul);
 }
 
-void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *pflags);
-
 bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
 bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 5c19c83219..ba5761b647 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -153,15 +153,6 @@ void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte);
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
index 530d97ccf1..aa931cb674 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -411,15 +411,6 @@ static inline int s390x_env_mmu_index(CPUS390XState *env, bool ifetch)
 #endif
 }
 
-#ifdef CONFIG_TCG
-
-#include "tcg/tcg_s390x.h"
-
-void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *flags);
-
-#endif /* CONFIG_TCG */
-
 /* PER bits from control register 9 */
 #define PER_CR9_EVENT_BRANCH                    0x80000000
 #define PER_CR9_EVENT_IFETCH                    0x40000000
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 906f99ddf0..c41ab70dd7 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -380,19 +380,4 @@ static inline void cpu_write_sr(CPUSH4State *env, target_ulong sr)
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
index 37fd1e066e..31cb3d97eb 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -741,9 +741,6 @@ trap_state* cpu_tsptr(CPUSPARCState* env);
 #define TB_FLAG_FSR_QNE      (1 << 8)
 #define TB_FLAG_ASI_SHIFT    24
 
-void cpu_get_tb_cpu_state(CPUSPARCState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *pflags);
-
 static inline bool tb_fpu_enabled(int tb_flags)
 {
 #if defined(CONFIG_USER_ONLY)
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index c76e65f818..82085fbc32 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -258,18 +258,6 @@ void tricore_tcg_init(void);
 void tricore_translate_code(CPUState *cs, TranslationBlock *tb,
                             int *max_insns, vaddr pc, void *host_pc);
 
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
 #define CPU_RESOLVING_TYPE TYPE_TRICORE_CPU
 
 /* helpers.c */
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index c03ed71c94..74122ebe15 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -733,74 +733,6 @@ static inline uint32_t xtensa_replicate_windowstart(CPUXtensaState *env)
 #define XTENSA_CSBASE_LBEG_OFF_MASK 0x00ff0000
 #define XTENSA_CSBASE_LBEG_OFF_SHIFT 16
 
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
index d4e66aa432..134806e755 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -25,6 +25,7 @@
 #include "cpu.h"
 #include "exec/translation-block.h"
 #include "exec/target_page.h"
+#include "accel/tcg/cpu-ops.h"
 #include "fpu/softfloat.h"
 
 
@@ -40,6 +41,17 @@ static vaddr alpha_cpu_get_pc(CPUState *cs)
     return env->pc;
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
 static void alpha_cpu_synchronize_from_tb(CPUState *cs,
                                           const TranslationBlock *tb)
 {
@@ -231,8 +243,6 @@ static const struct SysemuCPUOps alpha_sysemu_ops = {
 };
 #endif
 
-#include "accel/tcg/cpu-ops.h"
-
 static const TCGCPUOps alpha_tcg_ops = {
     /* Alpha processors have a weak memory model */
     .guest_default_memory_order = 0,
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8de4eb2c1f..98adeb7086 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -30,6 +30,7 @@
 #include "qemu/guest-random.h"
 #ifdef CONFIG_TCG
 #include "accel/tcg/probe.h"
+#include "accel/tcg/cpu-ops.h"
 #include "semihosting/common-semi.h"
 #endif
 #include "cpregs.h"
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 50b835e1ae..d9fecb272e 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -27,6 +27,7 @@
 #include "disas/dis-asm.h"
 #include "tcg/debug-assert.h"
 #include "hw/qdev-properties.h"
+#include "accel/tcg/cpu-ops.h"
 
 static void avr_cpu_set_pc(CPUState *cs, vaddr value)
 {
@@ -53,6 +54,24 @@ static int avr_cpu_mmu_index(CPUState *cs, bool ifetch)
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
 static void avr_cpu_synchronize_from_tb(CPUState *cs,
                                         const TranslationBlock *tb)
 {
@@ -220,8 +239,6 @@ static const struct SysemuCPUOps avr_sysemu_ops = {
     .get_phys_page_debug = avr_cpu_get_phys_page_debug,
 };
 
-#include "accel/tcg/cpu-ops.h"
-
 static const TCGCPUOps avr_tcg_ops = {
     .guest_default_memory_order = 0,
     .mttcg_supported = false,
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index c1bfa80252..2272f1222b 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -25,6 +25,7 @@
 #include "fpu/softfloat-helpers.h"
 #include "tcg/tcg.h"
 #include "exec/gdbstub.h"
+#include "accel/tcg/cpu-ops.h"
 
 static void hexagon_v66_cpu_init(Object *obj) { }
 static void hexagon_v67_cpu_init(Object *obj) { }
@@ -254,6 +255,21 @@ static vaddr hexagon_cpu_get_pc(CPUState *cs)
     return cpu_env(cs)->gpr[HEX_REG_PC];
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
+    if (*pc & PCALIGN_MASK) {
+        hexagon_raise_exception_err(env, HEX_CAUSE_PC_NOT_ALIGNED, 0);
+    }
+}
+
 static void hexagon_cpu_synchronize_from_tb(CPUState *cs,
                                             const TranslationBlock *tb)
 {
@@ -321,8 +337,6 @@ static void hexagon_cpu_init(Object *obj)
 {
 }
 
-#include "accel/tcg/cpu-ops.h"
-
 static const TCGCPUOps hexagon_tcg_ops = {
     /* MTTCG not yet supported: require strict ordering */
     .guest_default_memory_order = TCG_MO_ALL,
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 60b618a22b..4cdaf98ab1 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -29,6 +29,7 @@
 #include "fpu/softfloat.h"
 #include "tcg/tcg.h"
 #include "hw/hppa/hppa_hardware.h"
+#include "accel/tcg/cpu-ops.h"
 
 static void hppa_cpu_set_pc(CPUState *cs, vaddr value)
 {
@@ -249,8 +250,6 @@ static const struct SysemuCPUOps hppa_sysemu_ops = {
 };
 #endif
 
-#include "accel/tcg/cpu-ops.h"
-
 static const TCGCPUOps hppa_tcg_ops = {
     /* PA-RISC 1.x processors have a strong memory model.  */
     /*
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index f3f0380e70..bb6f82befb 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -24,6 +24,7 @@
 #include "accel/accel-cpu-target.h"
 #include "exec/translation-block.h"
 #include "exec/target_page.h"
+#include "accel/tcg/cpu-ops.h"
 #include "tcg-cpu.h"
 
 /* Frob eflags into and out of the CPU temporary format.  */
@@ -47,6 +48,20 @@ static void x86_cpu_exec_exit(CPUState *cs)
     env->eflags = cpu_compute_eflags(env);
 }
 
+void cpu_get_tb_cpu_state(CPUX86State *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    *flags = env->hflags |
+        (env->eflags & (IOPL_MASK | TF_MASK | RF_MASK | VM_MASK | AC_MASK));
+    if (env->hflags & HF_CS64_MASK) {
+        *cs_base = 0;
+        *pc = env->eip;
+    } else {
+        *cs_base = env->segs[R_CS].base;
+        *pc = (uint32_t)(*cs_base + env->eip);
+    }
+}
+
 static void x86_cpu_synchronize_from_tb(CPUState *cs,
                                         const TranslationBlock *tb)
 {
@@ -131,8 +146,6 @@ static void x86_cpu_exec_reset(CPUState *cs)
 }
 #endif
 
-#include "accel/tcg/cpu-ops.h"
-
 const TCGCPUOps x86_tcg_ops = {
     .mttcg_supported = true,
     .precise_smc = true,
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index c64cba72dd..be770b7e19 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -29,6 +29,7 @@
 #endif
 #ifdef CONFIG_TCG
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-ops.h"
 #include "tcg/tcg.h"
 #endif
 #include "tcg/tcg_loongarch.h"
@@ -335,6 +336,18 @@ static bool loongarch_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 }
 #endif
 
+void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    *pc = env->pc;
+    *cs_base = 0;
+    *flags = env->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
+    *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
+    *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
+    *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, ASXE) * HW_FLAGS_EUEN_ASXE;
+    *flags |= is_va32(env) * HW_FLAGS_VA32;
+}
+
 static void loongarch_cpu_synchronize_from_tb(CPUState *cs,
                                               const TranslationBlock *tb)
 {
@@ -861,8 +874,6 @@ static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 }
 
 #ifdef CONFIG_TCG
-#include "accel/tcg/cpu-ops.h"
-
 static const TCGCPUOps loongarch_tcg_ops = {
     .guest_default_memory_order = 0,
     .mttcg_supported = true,
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index f446c6c8f7..2b4ec40509 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -23,6 +23,7 @@
 #include "cpu.h"
 #include "migration/vmstate.h"
 #include "fpu/softfloat.h"
+#include "accel/tcg/cpu-ops.h"
 
 static void m68k_cpu_set_pc(CPUState *cs, vaddr value)
 {
@@ -38,6 +39,22 @@ static vaddr m68k_cpu_get_pc(CPUState *cs)
     return cpu->env.pc;
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
 static void m68k_restore_state_to_opc(CPUState *cs,
                                       const TranslationBlock *tb,
                                       const uint64_t *data)
@@ -586,8 +603,6 @@ static const struct SysemuCPUOps m68k_sysemu_ops = {
 };
 #endif /* !CONFIG_USER_ONLY */
 
-#include "accel/tcg/cpu-ops.h"
-
 static const TCGCPUOps m68k_tcg_ops = {
     /* MTTCG not yet supported: require strict ordering */
     .guest_default_memory_order = TCG_MO_ALL,
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index f305ed04f6..105ede0b1e 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -31,6 +31,7 @@
 #include "exec/gdbstub.h"
 #include "exec/translation-block.h"
 #include "fpu/softfloat-helpers.h"
+#include "accel/tcg/cpu-ops.h"
 #include "tcg/tcg.h"
 
 static const struct {
@@ -94,6 +95,14 @@ static vaddr mb_cpu_get_pc(CPUState *cs)
     return cpu->env.pc;
 }
 
+void cpu_get_tb_cpu_state(CPUMBState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    *pc = env->pc;
+    *flags = (env->iflags & IFLAGS_TB_MASK) | (env->msr & MSR_TB_MASK);
+    *cs_base = (*flags & IMM_FLAG ? env->imm : 0);
+}
+
 static void mb_cpu_synchronize_from_tb(CPUState *cs,
                                        const TranslationBlock *tb)
 {
@@ -423,8 +432,6 @@ static const struct SysemuCPUOps mb_sysemu_ops = {
 };
 #endif
 
-#include "accel/tcg/cpu-ops.h"
-
 static const TCGCPUOps mb_tcg_ops = {
     /* MicroBlaze is always in-order. */
     .guest_default_memory_order = TCG_MO_ALL,
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 09ed330027..ab00adf86b 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -549,6 +549,15 @@ static int mips_cpu_mmu_index(CPUState *cs, bool ifunc)
     return mips_env_mmu_index(cpu_env(cs));
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
 static const TCGCPUOps mips_tcg_ops = {
     .mttcg_supported = TARGET_LONG_BITS == 32,
     .guest_default_memory_order = 0,
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 94776e0ad8..d798127d67 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -23,6 +23,7 @@
 #include "cpu.h"
 #include "exec/translation-block.h"
 #include "fpu/softfloat-helpers.h"
+#include "accel/tcg/cpu-ops.h"
 #include "tcg/tcg.h"
 
 static void openrisc_cpu_set_pc(CPUState *cs, vaddr value)
@@ -40,6 +41,16 @@ static vaddr openrisc_cpu_get_pc(CPUState *cs)
     return cpu->env.pc;
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
 static void openrisc_cpu_synchronize_from_tb(CPUState *cs,
                                              const TranslationBlock *tb)
 {
@@ -239,8 +250,6 @@ static const struct SysemuCPUOps openrisc_sysemu_ops = {
 };
 #endif
 
-#include "accel/tcg/cpu-ops.h"
-
 static const TCGCPUOps openrisc_tcg_ops = {
     .guest_default_memory_order = 0,
     .mttcg_supported = true,
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index f211bc9830..8d248bcbb9 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -27,6 +27,7 @@
 #include "power8-pmu.h"
 #include "cpu-models.h"
 #include "spr_common.h"
+#include "accel/tcg/cpu-ops.h"
 
 /* Swap temporary saved registers with GPRs */
 void hreg_swap_gpr_tgpr(CPUPPCState *env)
@@ -255,26 +256,25 @@ void hreg_update_pmu_hflags(CPUPPCState *env)
     env->hflags |= hreg_compute_pmu_hflags_value(env);
 }
 
-#ifdef CONFIG_DEBUG_TCG
 void cpu_get_tb_cpu_state(CPUPPCState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *flags)
 {
     uint32_t hflags_current = env->hflags;
-    uint32_t hflags_rebuilt;
 
-    *pc = env->nip;
-    *cs_base = 0;
-    *flags = hflags_current;
-
-    hflags_rebuilt = hreg_compute_hflags_value(env);
+#ifdef CONFIG_DEBUG_TCG
+    uint32_t hflags_rebuilt = hreg_compute_hflags_value(env);
     if (unlikely(hflags_current != hflags_rebuilt)) {
         cpu_abort(env_cpu(env),
                   "TCG hflags mismatch (current:0x%08x rebuilt:0x%08x)\n",
                   hflags_current, hflags_rebuilt);
     }
-}
 #endif
 
+    *pc = env->nip;
+    *cs_base = 0;
+    *flags = hflags_current;
+}
+
 void cpu_interrupt_exittb(CPUState *cs)
 {
     /*
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index de2e6a22ff..e8b47be675 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -28,6 +28,7 @@
 #include "hw/loader.h"
 #include "fpu/softfloat.h"
 #include "tcg/debug-assert.h"
+#include "accel/tcg/cpu-ops.h"
 
 static void rx_cpu_set_pc(CPUState *cs, vaddr value)
 {
@@ -43,6 +44,15 @@ static vaddr rx_cpu_get_pc(CPUState *cs)
     return cpu->env.pc;
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
 static void rx_cpu_synchronize_from_tb(CPUState *cs,
                                        const TranslationBlock *tb)
 {
@@ -201,8 +211,6 @@ static const struct SysemuCPUOps rx_sysemu_ops = {
     .get_phys_page_debug = rx_cpu_get_phys_page_debug,
 };
 
-#include "accel/tcg/cpu-ops.h"
-
 static const TCGCPUOps rx_tcg_ops = {
     /* MTTCG not yet supported: require strict ordering */
     .guest_default_memory_order = TCG_MO_ALL,
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 71338aae77..435b2034ff 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -302,6 +302,7 @@ static const Property s390x_cpu_properties[] = {
 
 #ifdef CONFIG_TCG
 #include "accel/tcg/cpu-ops.h"
+#include "tcg/tcg_s390x.h"
 
 static int s390x_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 681237c511..5fb18bf55e 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -26,6 +26,7 @@
 #include "migration/vmstate.h"
 #include "exec/translation-block.h"
 #include "fpu/softfloat-helpers.h"
+#include "accel/tcg/cpu-ops.h"
 #include "tcg/tcg.h"
 
 static void superh_cpu_set_pc(CPUState *cs, vaddr value)
@@ -42,6 +43,21 @@ static vaddr superh_cpu_get_pc(CPUState *cs)
     return cpu->env.pc;
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
 static void superh_cpu_synchronize_from_tb(CPUState *cs,
                                            const TranslationBlock *tb)
 {
@@ -258,8 +274,6 @@ static const struct SysemuCPUOps sh4_sysemu_ops = {
 };
 #endif
 
-#include "accel/tcg/cpu-ops.h"
-
 static const TCGCPUOps superh_tcg_ops = {
     /* MTTCG not yet supported: require strict ordering */
     .guest_default_memory_order = TCG_MO_ALL,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 0fcac697f6..81b3bb6362 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -23,6 +23,7 @@
 #include "exec/translation-block.h"
 #include "qemu/error-report.h"
 #include "tcg/debug-assert.h"
+#include "accel/tcg/cpu-ops.h"
 
 static inline void set_feature(CPUTriCoreState *env, int feature)
 {
@@ -44,6 +45,18 @@ static vaddr tricore_cpu_get_pc(CPUState *cs)
     return cpu_env(cs)->PC;
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
 static void tricore_cpu_synchronize_from_tb(CPUState *cs,
                                             const TranslationBlock *tb)
 {
@@ -168,8 +181,6 @@ static const struct SysemuCPUOps tricore_sysemu_ops = {
     .get_phys_page_debug = tricore_cpu_get_phys_page_debug,
 };
 
-#include "accel/tcg/cpu-ops.h"
-
 static const TCGCPUOps tricore_tcg_ops = {
     /* MTTCG not yet supported: require strict ordering */
     .guest_default_memory_order = TCG_MO_ALL,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 9dcb883208..c78ef9421c 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -35,6 +35,7 @@
 #include "qemu/module.h"
 #include "migration/vmstate.h"
 #include "hw/qdev-clock.h"
+#include "accel/tcg/cpu-ops.h"
 #ifndef CONFIG_USER_ONLY
 #include "system/memory.h"
 #endif
@@ -54,6 +55,74 @@ static vaddr xtensa_cpu_get_pc(CPUState *cs)
     return cpu->env.pc;
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
 static void xtensa_restore_state_to_opc(CPUState *cs,
                                         const TranslationBlock *tb,
                                         const uint64_t *data)
@@ -229,8 +298,6 @@ static const struct SysemuCPUOps xtensa_sysemu_ops = {
 };
 #endif
 
-#include "accel/tcg/cpu-ops.h"
-
 static const TCGCPUOps xtensa_tcg_ops = {
     /* Xtensa processors have a weak memory model */
     .guest_default_memory_order = 0,
-- 
2.43.0


