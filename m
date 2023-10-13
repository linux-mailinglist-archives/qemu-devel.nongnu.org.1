Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 238DE7C7F7B
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:07:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD4f-0001eO-Bj; Fri, 13 Oct 2023 03:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4R-0000x5-V4
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:59 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4D-0006tp-Gk
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:47 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-406609df1a6so19255955e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183920; x=1697788720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kcog8S1phTlO4n8UZKQfZPL+oXYpmBCSiSUPN6vTFxA=;
 b=K4FvB3zpsL9mOysPZgKCM4halcBPDaOL2gcE70pMrjbyTCo+qOTOdU1nJZDE1G9vsk
 O0rYkn4tgltKXs/zJqfTzZlLPxCB1lxWLpkcW2qBahEeSpcfVfkb6aiHhTqy5TFIS2M7
 Z1HqYEYlBNISQHu/RIvT6MujaYnZ28bUXYMsVmfyCkfSEIbg0wjfHCB+j7CBsjcxhfvz
 sU2leRdcMLVYfOxoEGZ07D5BqOz+j65Z1eUngwldnvsPQLfdX+E5HLbn8RevREZzgVsZ
 UUyfKLNR7ylloqDyD5iXyNRlJ2dzaCqiIk8vXSHAjvCJv++vRfT7oasT8ZZnn0g0L38L
 EfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183920; x=1697788720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kcog8S1phTlO4n8UZKQfZPL+oXYpmBCSiSUPN6vTFxA=;
 b=nEo2UnXXqFTRO2oEO0S3pvKXZQU51qPHJT1E3FzjlKMEsTokMkbTJNNc0s0XA3g4jR
 Ydr1yJgZGrChLvPRgItA1X9siBH46X5T/KvoQBJetQJIWN8UbORVLOx7UrVaZ2pZ2P43
 DRCl5YkZnq2TtNtfIvtJMHkzj8lVqHffEWr+AxcJQnVAqVbPeSldiZQCfX9E2cL0qZk4
 yu+xit01kacg8HilgjhiSsan03rY7E88Ph4iVmiQsI7CUVT5kzHPH0cLbylryk26oEe6
 D9j7JSxWF8tcEcI0MlJ3VyG3sfOiO0Daq+Uw7ilA58aMwuWQetLQ3Ik7Zmo/bXyJ/NtK
 60rw==
X-Gm-Message-State: AOJu0YwLNC0VDgcxWEc2nSJzltKrX1mzAWyGT9ymflE5Qcqx8RAkALd+
 q7HzYodp4k+kxskqCkmgRIQRXgrYjQSGGahge30=
X-Google-Smtp-Source: AGHT+IEkCSRD21TaFmbc+LMFjfjFcbOuie5UHywEufiWyL1eewLdSVQVIanHVOW08UoCWtFnE2zI8A==
X-Received: by 2002:a1c:721a:0:b0:405:1baf:cedf with SMTP id
 n26-20020a1c721a000000b004051bafcedfmr23271922wmc.24.1697183918463; 
 Fri, 13 Oct 2023 00:58:38 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:58:37 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [RFC PATCH v2 23/78] target/arm: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:56:50 +0300
Message-Id: <f1a134edc1de7e1122c42c68cdc8e8f96ce1e35a.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URI_NOVOWEL=0.5 autolearn=ham autolearn_force=no
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/arm/helper.c               | 34 +++++++-------
 target/arm/ptw.c                  | 10 ++--
 target/arm/tcg/psci.c             |  2 +-
 target/arm/tcg/translate-a64.c    | 76 +++++++++++++++----------------
 target/arm/tcg/translate-m-nocp.c |  2 +-
 target/arm/tcg/translate-vfp.c    |  2 +-
 target/arm/tcg/translate.c        |  8 ++--
 7 files changed, 68 insertions(+), 66 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 74fbb6e1d7..e2d1426cf4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2507,42 +2507,42 @@ static CPAccessResult gt_counter_access(CPUARMState *env, int timeridx,
 static CPAccessResult gt_timer_access(CPUARMState *env, int timeridx,
                                       bool isread)
 {
     unsigned int cur_el = arm_current_el(env);
     bool has_el2 = arm_is_el2_enabled(env);
     uint64_t hcr = arm_hcr_el2_eff(env);
 
     switch (cur_el) {
     case 0:
         if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
             /* If HCR_EL2.<E2H,TGE> == '11': check CNTHCTL_EL2.EL0[PV]TEN. */
             return (extract32(env->cp15.cnthctl_el2, 9 - timeridx, 1)
                     ? CP_ACCESS_OK : CP_ACCESS_TRAP_EL2);
         }
 
         /*
          * CNT[PV]_CVAL, CNT[PV]_CTL, CNT[PV]_TVAL: not visible from
          * EL0 if EL0[PV]TEN is zero.
          */
         if (!extract32(env->cp15.c14_cntkctl, 9 - timeridx, 1)) {
             return CP_ACCESS_TRAP;
         }
-        /* fall through */
+        fallthrough;
 
     case 1:
         if (has_el2 && timeridx == GTIMER_PHYS) {
             if (hcr & HCR_E2H) {
                 /* If HCR_EL2.<E2H,TGE> == '10': check CNTHCTL_EL2.EL1PTEN. */
                 if (!extract32(env->cp15.cnthctl_el2, 11, 1)) {
                     return CP_ACCESS_TRAP_EL2;
                 }
             } else {
                 /* If HCR_EL2.<E2H> == 0: check CNTHCTL_EL2.EL1PCEN. */
                 if (!extract32(env->cp15.cnthctl_el2, 1, 1)) {
                     return CP_ACCESS_TRAP_EL2;
                 }
             }
         }
         break;
     }
     return CP_ACCESS_OK;
 }
@@ -3573,69 +3573,69 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
 static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
 #ifdef CONFIG_TCG
     MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
     uint64_t par64;
     ARMMMUIdx mmu_idx;
     int el = arm_current_el(env);
     ARMSecuritySpace ss = arm_security_space(env);
 
     switch (ri->opc2 & 6) {
     case 0:
         /* stage 1 current state PL1: ATS1CPR, ATS1CPW, ATS1CPRP, ATS1CPWP */
         switch (el) {
         case 3:
             mmu_idx = ARMMMUIdx_E3;
             break;
         case 2:
             g_assert(ss != ARMSS_Secure);  /* ARMv8.4-SecEL2 is 64-bit only */
-            /* fall through */
+            fallthrough;
         case 1:
             if (ri->crm == 9 && (env->uncached_cpsr & CPSR_PAN)) {
                 mmu_idx = ARMMMUIdx_Stage1_E1_PAN;
             } else {
                 mmu_idx = ARMMMUIdx_Stage1_E1;
             }
             break;
         default:
             g_assert_not_reached();
         }
         break;
     case 2:
         /* stage 1 current state PL0: ATS1CUR, ATS1CUW */
         switch (el) {
         case 3:
             mmu_idx = ARMMMUIdx_E10_0;
             break;
         case 2:
             g_assert(ss != ARMSS_Secure);  /* ARMv8.4-SecEL2 is 64-bit only */
             mmu_idx = ARMMMUIdx_Stage1_E0;
             break;
         case 1:
             mmu_idx = ARMMMUIdx_Stage1_E0;
             break;
         default:
             g_assert_not_reached();
         }
         break;
     case 4:
         /* stage 1+2 NonSecure PL1: ATS12NSOPR, ATS12NSOPW */
         mmu_idx = ARMMMUIdx_E10_1;
         ss = ARMSS_NonSecure;
         break;
     case 6:
         /* stage 1+2 NonSecure PL0: ATS12NSOUR, ATS12NSOUW */
         mmu_idx = ARMMMUIdx_E10_0;
         ss = ARMSS_NonSecure;
         break;
     default:
         g_assert_not_reached();
     }
 
     par64 = do_ats_write(env, value, access_type, mmu_idx, ss);
 
     A32_BANKED_CURRENT_REG_SET(env, par, par64);
 #else
     /* Handled by hardware accelerator. */
     g_assert_not_reached();
 #endif /* CONFIG_TCG */
 }
@@ -4649,21 +4649,21 @@ static const ARMCPRegInfo ssbs_reginfo = {
 static CPAccessResult aa64_cacheop_poc_access(CPUARMState *env,
                                               const ARMCPRegInfo *ri,
                                               bool isread)
 {
     /* Cache invalidate/clean to Point of Coherency or Persistence...  */
     switch (arm_current_el(env)) {
     case 0:
         /* ... EL0 must UNDEF unless SCTLR_EL1.UCI is set.  */
         if (!(arm_sctlr(env, 0) & SCTLR_UCI)) {
             return CP_ACCESS_TRAP;
         }
-        /* fall through */
+        fallthrough;
     case 1:
         /* ... EL1 must trap to EL2 if HCR_EL2.TPCP is set.  */
         if (arm_hcr_el2_eff(env) & HCR_TPCP) {
             return CP_ACCESS_TRAP_EL2;
         }
         break;
     }
     return CP_ACCESS_OK;
 }
@@ -4671,19 +4671,19 @@ static CPAccessResult aa64_cacheop_poc_access(CPUARMState *env,
 static CPAccessResult do_cacheop_pou_access(CPUARMState *env, uint64_t hcrflags)
 {
     /* Cache invalidate/clean to Point of Unification... */
     switch (arm_current_el(env)) {
     case 0:
         /* ... EL0 must UNDEF unless SCTLR_EL1.UCI is set.  */
         if (!(arm_sctlr(env, 0) & SCTLR_UCI)) {
             return CP_ACCESS_TRAP;
         }
-        /* fall through */
+        fallthrough;
     case 1:
         /* ... EL1 must trap to EL2 if relevant HCR_EL2 flags are set.  */
         if (arm_hcr_el2_eff(env) & hcrflags) {
             return CP_ACCESS_TRAP_EL2;
         }
         break;
     }
     return CP_ACCESS_OK;
 }
@@ -6741,107 +6741,107 @@ static const ARMCPRegInfo minimal_ras_reginfo[] = {
 /*
  * Return the exception level to which exceptions should be taken
  * via SVEAccessTrap.  This excludes the check for whether the exception
  * should be routed through AArch64.AdvSIMDFPAccessTrap.  That can easily
  * be found by testing 0 < fp_exception_el < sve_exception_el.
  *
  * C.f. the ARM pseudocode function CheckSVEEnabled.  Note that the
  * pseudocode does *not* separate out the FP trap checks, but has them
  * all in one function.
  */
 int sve_exception_el(CPUARMState *env, int el)
 {
 #ifndef CONFIG_USER_ONLY
     if (el <= 1 && !el_is_in_host(env, el)) {
         switch (FIELD_EX64(env->cp15.cpacr_el1, CPACR_EL1, ZEN)) {
         case 1:
             if (el != 0) {
                 break;
             }
-            /* fall through */
+            fallthrough;
         case 0:
         case 2:
             return 1;
         }
     }
 
     if (el <= 2 && arm_is_el2_enabled(env)) {
         /* CPTR_EL2 changes format with HCR_EL2.E2H (regardless of TGE). */
         if (env->cp15.hcr_el2 & HCR_E2H) {
             switch (FIELD_EX64(env->cp15.cptr_el[2], CPTR_EL2, ZEN)) {
             case 1:
                 if (el != 0 || !(env->cp15.hcr_el2 & HCR_TGE)) {
                     break;
                 }
-                /* fall through */
+                fallthrough;
             case 0:
             case 2:
                 return 2;
             }
         } else {
             if (FIELD_EX64(env->cp15.cptr_el[2], CPTR_EL2, TZ)) {
                 return 2;
             }
         }
     }
 
     /* CPTR_EL3.  Since EZ is negative we must check for EL3.  */
     if (arm_feature(env, ARM_FEATURE_EL3)
         && !FIELD_EX64(env->cp15.cptr_el[3], CPTR_EL3, EZ)) {
         return 3;
     }
 #endif
     return 0;
 }
 
 /*
  * Return the exception level to which exceptions should be taken for SME.
  * C.f. the ARM pseudocode function CheckSMEAccess.
  */
 int sme_exception_el(CPUARMState *env, int el)
 {
 #ifndef CONFIG_USER_ONLY
     if (el <= 1 && !el_is_in_host(env, el)) {
         switch (FIELD_EX64(env->cp15.cpacr_el1, CPACR_EL1, SMEN)) {
         case 1:
             if (el != 0) {
                 break;
             }
-            /* fall through */
+            fallthrough;
         case 0:
         case 2:
             return 1;
         }
     }
 
     if (el <= 2 && arm_is_el2_enabled(env)) {
         /* CPTR_EL2 changes format with HCR_EL2.E2H (regardless of TGE). */
         if (env->cp15.hcr_el2 & HCR_E2H) {
             switch (FIELD_EX64(env->cp15.cptr_el[2], CPTR_EL2, SMEN)) {
             case 1:
                 if (el != 0 || !(env->cp15.hcr_el2 & HCR_TGE)) {
                     break;
                 }
-                /* fall through */
+                fallthrough;
             case 0:
             case 2:
                 return 2;
             }
         } else {
             if (FIELD_EX64(env->cp15.cptr_el[2], CPTR_EL2, TSM)) {
                 return 2;
             }
         }
     }
 
     /* CPTR_EL3.  Since ESM is negative we must check for EL3.  */
     if (arm_feature(env, ARM_FEATURE_EL3)
         && !FIELD_EX64(env->cp15.cptr_el[3], CPTR_EL3, ESM)) {
         return 3;
     }
 #endif
     return 0;
 }
 
 /*
  * Given that SVE is enabled, return the vector length for EL.
  */
@@ -9678,182 +9678,182 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
 void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
                                        const ARMCPRegInfo *r, void *opaque)
 {
     /*
      * Define implementations of coprocessor registers.
      * We store these in a hashtable because typically
      * there are less than 150 registers in a space which
      * is 16*16*16*8*8 = 262144 in size.
      * Wildcarding is supported for the crm, opc1 and opc2 fields.
      * If a register is defined twice then the second definition is
      * used, so this can be used to define some generic registers and
      * then override them with implementation specific variations.
      * At least one of the original and the second definition should
      * include ARM_CP_OVERRIDE in its type bits -- this is just a guard
      * against accidental use.
      *
      * The state field defines whether the register is to be
      * visible in the AArch32 or AArch64 execution state. If the
      * state is set to ARM_CP_STATE_BOTH then we synthesise a
      * reginfo structure for the AArch32 view, which sees the lower
      * 32 bits of the 64 bit register.
      *
      * Only registers visible in AArch64 may set r->opc0; opc0 cannot
      * be wildcarded. AArch64 registers are always considered to be 64
      * bits; the ARM_CP_64BIT* flag applies only to the AArch32 view of
      * the register, if any.
      */
     int crm, opc1, opc2;
     int crmmin = (r->crm == CP_ANY) ? 0 : r->crm;
     int crmmax = (r->crm == CP_ANY) ? 15 : r->crm;
     int opc1min = (r->opc1 == CP_ANY) ? 0 : r->opc1;
     int opc1max = (r->opc1 == CP_ANY) ? 7 : r->opc1;
     int opc2min = (r->opc2 == CP_ANY) ? 0 : r->opc2;
     int opc2max = (r->opc2 == CP_ANY) ? 7 : r->opc2;
     CPState state;
 
     /* 64 bit registers have only CRm and Opc1 fields */
     assert(!((r->type & ARM_CP_64BIT) && (r->opc2 || r->crn)));
     /* op0 only exists in the AArch64 encodings */
     assert((r->state != ARM_CP_STATE_AA32) || (r->opc0 == 0));
     /* AArch64 regs are all 64 bit so ARM_CP_64BIT is meaningless */
     assert((r->state != ARM_CP_STATE_AA64) || !(r->type & ARM_CP_64BIT));
     /*
      * This API is only for Arm's system coprocessors (14 and 15) or
      * (M-profile or v7A-and-earlier only) for implementation defined
      * coprocessors in the range 0..7.  Our decode assumes this, since
      * 8..13 can be used for other insns including VFP and Neon. See
      * valid_cp() in translate.c.  Assert here that we haven't tried
      * to use an invalid coprocessor number.
      */
     switch (r->state) {
     case ARM_CP_STATE_BOTH:
         /* 0 has a special meaning, but otherwise the same rules as AA32. */
         if (r->cp == 0) {
             break;
         }
-        /* fall through */
+        fallthrough;
     case ARM_CP_STATE_AA32:
         if (arm_feature(&cpu->env, ARM_FEATURE_V8) &&
             !arm_feature(&cpu->env, ARM_FEATURE_M)) {
             assert(r->cp >= 14 && r->cp <= 15);
         } else {
             assert(r->cp < 8 || (r->cp >= 14 && r->cp <= 15));
         }
         break;
     case ARM_CP_STATE_AA64:
         assert(r->cp == 0 || r->cp == CP_REG_ARM64_SYSREG_CP);
         break;
     default:
         g_assert_not_reached();
     }
     /*
      * The AArch64 pseudocode CheckSystemAccess() specifies that op1
      * encodes a minimum access level for the register. We roll this
      * runtime check into our general permission check code, so check
      * here that the reginfo's specified permissions are strict enough
      * to encompass the generic architectural permission check.
      */
     if (r->state != ARM_CP_STATE_AA32) {
         CPAccessRights mask;
         switch (r->opc1) {
         case 0:
             /* min_EL EL1, but some accessible to EL0 via kernel ABI */
             mask = PL0U_R | PL1_RW;
             break;
         case 1: case 2:
             /* min_EL EL1 */
             mask = PL1_RW;
             break;
         case 3:
             /* min_EL EL0 */
             mask = PL0_RW;
             break;
         case 4:
         case 5:
             /* min_EL EL2 */
             mask = PL2_RW;
             break;
         case 6:
             /* min_EL EL3 */
             mask = PL3_RW;
             break;
         case 7:
             /* min_EL EL1, secure mode only (we don't check the latter) */
             mask = PL1_RW;
             break;
         default:
             /* broken reginfo with out-of-range opc1 */
             g_assert_not_reached();
         }
         /* assert our permissions are not too lax (stricter is fine) */
         assert((r->access & ~mask) == 0);
     }
 
     /*
      * Check that the register definition has enough info to handle
      * reads and writes if they are permitted.
      */
     if (!(r->type & (ARM_CP_SPECIAL_MASK | ARM_CP_CONST))) {
         if (r->access & PL3_R) {
             assert((r->fieldoffset ||
                    (r->bank_fieldoffsets[0] && r->bank_fieldoffsets[1])) ||
                    r->readfn);
         }
         if (r->access & PL3_W) {
             assert((r->fieldoffset ||
                    (r->bank_fieldoffsets[0] && r->bank_fieldoffsets[1])) ||
                    r->writefn);
         }
     }
 
     for (crm = crmmin; crm <= crmmax; crm++) {
         for (opc1 = opc1min; opc1 <= opc1max; opc1++) {
             for (opc2 = opc2min; opc2 <= opc2max; opc2++) {
                 for (state = ARM_CP_STATE_AA32;
                      state <= ARM_CP_STATE_AA64; state++) {
                     if (r->state != state && r->state != ARM_CP_STATE_BOTH) {
                         continue;
                     }
                     if (state == ARM_CP_STATE_AA32) {
                         /*
                          * Under AArch32 CP registers can be common
                          * (same for secure and non-secure world) or banked.
                          */
                         char *name;
 
                         switch (r->secure) {
                         case ARM_CP_SECSTATE_S:
                         case ARM_CP_SECSTATE_NS:
                             add_cpreg_to_hashtable(cpu, r, opaque, state,
                                                    r->secure, crm, opc1, opc2,
                                                    r->name);
                             break;
                         case ARM_CP_SECSTATE_BOTH:
                             name = g_strdup_printf("%s_S", r->name);
                             add_cpreg_to_hashtable(cpu, r, opaque, state,
                                                    ARM_CP_SECSTATE_S,
                                                    crm, opc1, opc2, name);
                             g_free(name);
                             add_cpreg_to_hashtable(cpu, r, opaque, state,
                                                    ARM_CP_SECSTATE_NS,
                                                    crm, opc1, opc2, r->name);
                             break;
                         default:
                             g_assert_not_reached();
                         }
                     } else {
                         /*
                          * AArch64 registers get mapped to non-secure instance
                          * of AArch32
                          */
                         add_cpreg_to_hashtable(cpu, r, opaque, state,
                                                ARM_CP_SECSTATE_NS,
                                                crm, opc1, opc2, r->name);
                     }
                 }
             }
         }
     }
 }
 
 /* Define a whole list of registers */
@@ -10609,79 +10609,79 @@ void aarch64_sync_64_to_32(CPUARMState *env)
 static void take_aarch32_exception(CPUARMState *env, int new_mode,
                                    uint32_t mask, uint32_t offset,
                                    uint32_t newpc)
 {
     int new_el;
 
     /* Change the CPU state so as to actually take the exception. */
     switch_mode(env, new_mode);
 
     /*
      * For exceptions taken to AArch32 we must clear the SS bit in both
      * PSTATE and in the old-state value we save to SPSR_<mode>, so zero it now.
      */
     env->pstate &= ~PSTATE_SS;
     env->spsr = cpsr_read(env);
     /* Clear IT bits.  */
     env->condexec_bits = 0;
     /* Switch to the new mode, and to the correct instruction set.  */
     env->uncached_cpsr = (env->uncached_cpsr & ~CPSR_M) | new_mode;
 
     /* This must be after mode switching. */
     new_el = arm_current_el(env);
 
     /* Set new mode endianness */
     env->uncached_cpsr &= ~CPSR_E;
     if (env->cp15.sctlr_el[new_el] & SCTLR_EE) {
         env->uncached_cpsr |= CPSR_E;
     }
     /* J and IL must always be cleared for exception entry */
     env->uncached_cpsr &= ~(CPSR_IL | CPSR_J);
     env->daif |= mask;
 
     if (cpu_isar_feature(aa32_ssbs, env_archcpu(env))) {
         if (env->cp15.sctlr_el[new_el] & SCTLR_DSSBS_32) {
             env->uncached_cpsr |= CPSR_SSBS;
         } else {
             env->uncached_cpsr &= ~CPSR_SSBS;
         }
     }
 
     if (new_mode == ARM_CPU_MODE_HYP) {
         env->thumb = (env->cp15.sctlr_el[2] & SCTLR_TE) != 0;
         env->elr_el[2] = env->regs[15];
     } else {
         /* CPSR.PAN is normally preserved preserved unless...  */
         if (cpu_isar_feature(aa32_pan, env_archcpu(env))) {
             switch (new_el) {
             case 3:
                 if (!arm_is_secure_below_el3(env)) {
                     /* ... the target is EL3, from non-secure state.  */
                     env->uncached_cpsr &= ~CPSR_PAN;
                     break;
                 }
                 /* ... the target is EL3, from secure state ... */
-                /* fall through */
+                fallthrough;
             case 1:
                 /* ... the target is EL1 and SCTLR.SPAN is 0.  */
                 if (!(env->cp15.sctlr_el[new_el] & SCTLR_SPAN)) {
                     env->uncached_cpsr |= CPSR_PAN;
                 }
                 break;
             }
         }
         /*
          * this is a lie, as there was no c1_sys on V4T/V5, but who cares
          * and we should just guard the thumb mode on V4
          */
         if (arm_feature(env, ARM_FEATURE_V4T)) {
             env->thumb =
                 (A32_BANKED_CURRENT_REG_GET(env, sctlr) & SCTLR_TE) != 0;
         }
         env->regs[14] = env->regs[15] + offset;
     }
     env->regs[15] = newpc;
 
     if (tcg_enabled()) {
         arm_rebuild_hflags(env);
     }
 }
@@ -10689,90 +10689,91 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
 static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
 {
     /*
      * Handle exception entry to Hyp mode; this is sufficiently
      * different to entry to other AArch32 modes that we handle it
      * separately here.
      *
      * The vector table entry used is always the 0x14 Hyp mode entry point,
      * unless this is an UNDEF/SVC/HVC/abort taken from Hyp to Hyp.
      * The offset applied to the preferred return address is always zero
      * (see DDI0487C.a section G1.12.3).
      * PSTATE A/I/F masks are set based only on the SCR.EA/IRQ/FIQ values.
      */
     uint32_t addr, mask;
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
 
     switch (cs->exception_index) {
     case EXCP_UDEF:
         addr = 0x04;
         break;
     case EXCP_SWI:
         addr = 0x08;
         break;
     case EXCP_BKPT:
         /* Fall through to prefetch abort.  */
+        fallthrough;
     case EXCP_PREFETCH_ABORT:
         env->cp15.ifar_s = env->exception.vaddress;
         qemu_log_mask(CPU_LOG_INT, "...with HIFAR 0x%x\n",
                       (uint32_t)env->exception.vaddress);
         addr = 0x0c;
         break;
     case EXCP_DATA_ABORT:
         env->cp15.dfar_s = env->exception.vaddress;
         qemu_log_mask(CPU_LOG_INT, "...with HDFAR 0x%x\n",
                       (uint32_t)env->exception.vaddress);
         addr = 0x10;
         break;
     case EXCP_IRQ:
         addr = 0x18;
         break;
     case EXCP_FIQ:
         addr = 0x1c;
         break;
     case EXCP_HVC:
         addr = 0x08;
         break;
     case EXCP_HYP_TRAP:
         addr = 0x14;
         break;
     default:
         cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
     }
 
     if (cs->exception_index != EXCP_IRQ && cs->exception_index != EXCP_FIQ) {
         if (!arm_feature(env, ARM_FEATURE_V8)) {
             /*
              * QEMU syndrome values are v8-style. v7 has the IL bit
              * UNK/SBZP for "field not valid" cases, where v8 uses RES1.
              * If this is a v7 CPU, squash the IL bit in those cases.
              */
             if (cs->exception_index == EXCP_PREFETCH_ABORT ||
                 (cs->exception_index == EXCP_DATA_ABORT &&
                  !(env->exception.syndrome & ARM_EL_ISV)) ||
                 syn_get_ec(env->exception.syndrome) == EC_UNCATEGORIZED) {
                 env->exception.syndrome &= ~ARM_EL_IL;
             }
         }
         env->cp15.esr_el[2] = env->exception.syndrome;
     }
 
     if (arm_current_el(env) != 2 && addr < 0x14) {
         addr = 0x14;
     }
 
     mask = 0;
     if (!(env->cp15.scr_el3 & SCR_EA)) {
         mask |= CPSR_A;
     }
     if (!(env->cp15.scr_el3 & SCR_IRQ)) {
         mask |= CPSR_I;
     }
     if (!(env->cp15.scr_el3 & SCR_FIQ)) {
         mask |= CPSR_F;
     }
 
     addr += env->cp15.hvbar;
 
     take_aarch32_exception(env, ARM_CPU_MODE_HYP, mask, 0, addr);
 }
@@ -10780,175 +10781,176 @@ static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
 static void arm_cpu_do_interrupt_aarch32(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     uint32_t addr;
     uint32_t mask;
     int new_mode;
     uint32_t offset;
     uint32_t moe;
 
     /* If this is a debug exception we must update the DBGDSCR.MOE bits */
     switch (syn_get_ec(env->exception.syndrome)) {
     case EC_BREAKPOINT:
     case EC_BREAKPOINT_SAME_EL:
         moe = 1;
         break;
     case EC_WATCHPOINT:
     case EC_WATCHPOINT_SAME_EL:
         moe = 10;
         break;
     case EC_AA32_BKPT:
         moe = 3;
         break;
     case EC_VECTORCATCH:
         moe = 5;
         break;
     default:
         moe = 0;
         break;
     }
 
     if (moe) {
         env->cp15.mdscr_el1 = deposit64(env->cp15.mdscr_el1, 2, 4, moe);
     }
 
     if (env->exception.target_el == 2) {
         arm_cpu_do_interrupt_aarch32_hyp(cs);
         return;
     }
 
     switch (cs->exception_index) {
     case EXCP_UDEF:
         new_mode = ARM_CPU_MODE_UND;
         addr = 0x04;
         mask = CPSR_I;
         if (env->thumb) {
             offset = 2;
         } else {
             offset = 4;
         }
         break;
     case EXCP_SWI:
         new_mode = ARM_CPU_MODE_SVC;
         addr = 0x08;
         mask = CPSR_I;
         /* The PC already points to the next instruction.  */
         offset = 0;
         break;
     case EXCP_BKPT:
         /* Fall through to prefetch abort.  */
+        fallthrough;
     case EXCP_PREFETCH_ABORT:
         A32_BANKED_CURRENT_REG_SET(env, ifsr, env->exception.fsr);
         A32_BANKED_CURRENT_REG_SET(env, ifar, env->exception.vaddress);
         qemu_log_mask(CPU_LOG_INT, "...with IFSR 0x%x IFAR 0x%x\n",
                       env->exception.fsr, (uint32_t)env->exception.vaddress);
         new_mode = ARM_CPU_MODE_ABT;
         addr = 0x0c;
         mask = CPSR_A | CPSR_I;
         offset = 4;
         break;
     case EXCP_DATA_ABORT:
         A32_BANKED_CURRENT_REG_SET(env, dfsr, env->exception.fsr);
         A32_BANKED_CURRENT_REG_SET(env, dfar, env->exception.vaddress);
         qemu_log_mask(CPU_LOG_INT, "...with DFSR 0x%x DFAR 0x%x\n",
                       env->exception.fsr,
                       (uint32_t)env->exception.vaddress);
         new_mode = ARM_CPU_MODE_ABT;
         addr = 0x10;
         mask = CPSR_A | CPSR_I;
         offset = 8;
         break;
     case EXCP_IRQ:
         new_mode = ARM_CPU_MODE_IRQ;
         addr = 0x18;
         /* Disable IRQ and imprecise data aborts.  */
         mask = CPSR_A | CPSR_I;
         offset = 4;
         if (env->cp15.scr_el3 & SCR_IRQ) {
             /* IRQ routed to monitor mode */
             new_mode = ARM_CPU_MODE_MON;
             mask |= CPSR_F;
         }
         break;
     case EXCP_FIQ:
         new_mode = ARM_CPU_MODE_FIQ;
         addr = 0x1c;
         /* Disable FIQ, IRQ and imprecise data aborts.  */
         mask = CPSR_A | CPSR_I | CPSR_F;
         if (env->cp15.scr_el3 & SCR_FIQ) {
             /* FIQ routed to monitor mode */
             new_mode = ARM_CPU_MODE_MON;
         }
         offset = 4;
         break;
     case EXCP_VIRQ:
         new_mode = ARM_CPU_MODE_IRQ;
         addr = 0x18;
         /* Disable IRQ and imprecise data aborts.  */
         mask = CPSR_A | CPSR_I;
         offset = 4;
         break;
     case EXCP_VFIQ:
         new_mode = ARM_CPU_MODE_FIQ;
         addr = 0x1c;
         /* Disable FIQ, IRQ and imprecise data aborts.  */
         mask = CPSR_A | CPSR_I | CPSR_F;
         offset = 4;
         break;
     case EXCP_VSERR:
         {
             /*
              * Note that this is reported as a data abort, but the DFAR
              * has an UNKNOWN value.  Construct the SError syndrome from
              * AET and ExT fields.
              */
             ARMMMUFaultInfo fi = { .type = ARMFault_AsyncExternal, };
 
             if (extended_addresses_enabled(env)) {
                 env->exception.fsr = arm_fi_to_lfsc(&fi);
             } else {
                 env->exception.fsr = arm_fi_to_sfsc(&fi);
             }
             env->exception.fsr |= env->cp15.vsesr_el2 & 0xd000;
             A32_BANKED_CURRENT_REG_SET(env, dfsr, env->exception.fsr);
             qemu_log_mask(CPU_LOG_INT, "...with IFSR 0x%x\n",
                           env->exception.fsr);
 
             new_mode = ARM_CPU_MODE_ABT;
             addr = 0x10;
             mask = CPSR_A | CPSR_I;
             offset = 8;
         }
         break;
     case EXCP_SMC:
         new_mode = ARM_CPU_MODE_MON;
         addr = 0x08;
         mask = CPSR_A | CPSR_I | CPSR_F;
         offset = 0;
         break;
     default:
         cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
         return; /* Never happens.  Keep compiler happy.  */
     }
 
     if (new_mode == ARM_CPU_MODE_MON) {
         addr += env->cp15.mvbar;
     } else if (A32_BANKED_CURRENT_REG_GET(env, sctlr) & SCTLR_V) {
         /* High vectors. When enabled, base address cannot be remapped. */
         addr += 0xffff0000;
     } else {
         /*
          * ARM v7 architectures provide a vector base address register to remap
          * the interrupt vector table.
          * This register is only followed in non-monitor mode, and is banked.
          * Note: only bits 31:5 are valid.
          */
         addr += A32_BANKED_CURRENT_REG_GET(env, vbar);
     }
 
     if ((env->uncached_cpsr & CPSR_M) == ARM_CPU_MODE_MON) {
         env->cp15.scr_el3 &= ~SCR_NS;
     }
 
     take_aarch32_exception(env, new_mode, mask, offset, addr);
 }
@@ -11056,209 +11058,209 @@ static bool syndrome_is_sync_extabt(uint32_t syndrome)
 /* Handle exception entry to a target EL which is using AArch64 */
 static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     unsigned int new_el = env->exception.target_el;
     target_ulong addr = env->cp15.vbar_el[new_el];
     unsigned int new_mode = aarch64_pstate_mode(new_el, true);
     unsigned int old_mode;
     unsigned int cur_el = arm_current_el(env);
     int rt;
 
     if (tcg_enabled()) {
         /*
          * Note that new_el can never be 0.  If cur_el is 0, then
          * el0_a64 is is_a64(), else el0_a64 is ignored.
          */
         aarch64_sve_change_el(env, cur_el, new_el, is_a64(env));
     }
 
     if (cur_el < new_el) {
         /*
          * Entry vector offset depends on whether the implemented EL
          * immediately lower than the target level is using AArch32 or AArch64
          */
         bool is_aa64;
         uint64_t hcr;
 
         switch (new_el) {
         case 3:
             is_aa64 = (env->cp15.scr_el3 & SCR_RW) != 0;
             break;
         case 2:
             hcr = arm_hcr_el2_eff(env);
             if ((hcr & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
                 is_aa64 = (hcr & HCR_RW) != 0;
                 break;
             }
-            /* fall through */
+            fallthrough;
         case 1:
             is_aa64 = is_a64(env);
             break;
         default:
             g_assert_not_reached();
         }
 
         if (is_aa64) {
             addr += 0x400;
         } else {
             addr += 0x600;
         }
     } else if (pstate_read(env) & PSTATE_SP) {
         addr += 0x200;
     }
 
     switch (cs->exception_index) {
     case EXCP_GPC:
         qemu_log_mask(CPU_LOG_INT, "...with MFAR 0x%" PRIx64 "\n",
                       env->cp15.mfar_el3);
-        /* fall through */
+        fallthrough;
     case EXCP_PREFETCH_ABORT:
     case EXCP_DATA_ABORT:
         /*
          * FEAT_DoubleFault allows synchronous external aborts taken to EL3
          * to be taken to the SError vector entrypoint.
          */
         if (new_el == 3 && (env->cp15.scr_el3 & SCR_EASE) &&
             syndrome_is_sync_extabt(env->exception.syndrome)) {
             addr += 0x180;
         }
         env->cp15.far_el[new_el] = env->exception.vaddress;
         qemu_log_mask(CPU_LOG_INT, "...with FAR 0x%" PRIx64 "\n",
                       env->cp15.far_el[new_el]);
-        /* fall through */
+        fallthrough;
     case EXCP_BKPT:
     case EXCP_UDEF:
     case EXCP_SWI:
     case EXCP_HVC:
     case EXCP_HYP_TRAP:
     case EXCP_SMC:
         switch (syn_get_ec(env->exception.syndrome)) {
         case EC_ADVSIMDFPACCESSTRAP:
             /*
              * QEMU internal FP/SIMD syndromes from AArch32 include the
              * TA and coproc fields which are only exposed if the exception
              * is taken to AArch32 Hyp mode. Mask them out to get a valid
              * AArch64 format syndrome.
              */
             env->exception.syndrome &= ~MAKE_64BIT_MASK(0, 20);
             break;
         case EC_CP14RTTRAP:
         case EC_CP15RTTRAP:
         case EC_CP14DTTRAP:
             /*
              * For a trap on AArch32 MRC/MCR/LDC/STC the Rt field is currently
              * the raw register field from the insn; when taking this to
              * AArch64 we must convert it to the AArch64 view of the register
              * number. Notice that we read a 4-bit AArch32 register number and
              * write back a 5-bit AArch64 one.
              */
             rt = extract32(env->exception.syndrome, 5, 4);
             rt = aarch64_regnum(env, rt);
             env->exception.syndrome = deposit32(env->exception.syndrome,
                                                 5, 5, rt);
             break;
         case EC_CP15RRTTRAP:
         case EC_CP14RRTTRAP:
             /* Similarly for MRRC/MCRR traps for Rt and Rt2 fields */
             rt = extract32(env->exception.syndrome, 5, 4);
             rt = aarch64_regnum(env, rt);
             env->exception.syndrome = deposit32(env->exception.syndrome,
                                                 5, 5, rt);
             rt = extract32(env->exception.syndrome, 10, 4);
             rt = aarch64_regnum(env, rt);
             env->exception.syndrome = deposit32(env->exception.syndrome,
                                                 10, 5, rt);
             break;
         }
         env->cp15.esr_el[new_el] = env->exception.syndrome;
         break;
     case EXCP_IRQ:
     case EXCP_VIRQ:
         addr += 0x80;
         break;
     case EXCP_FIQ:
     case EXCP_VFIQ:
         addr += 0x100;
         break;
     case EXCP_VSERR:
         addr += 0x180;
         /* Construct the SError syndrome from IDS and ISS fields. */
         env->exception.syndrome = syn_serror(env->cp15.vsesr_el2 & 0x1ffffff);
         env->cp15.esr_el[new_el] = env->exception.syndrome;
         break;
     default:
         cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
     }
 
     if (is_a64(env)) {
         old_mode = pstate_read(env);
         aarch64_save_sp(env, arm_current_el(env));
         env->elr_el[new_el] = env->pc;
     } else {
         old_mode = cpsr_read_for_spsr_elx(env);
         env->elr_el[new_el] = env->regs[15];
 
         aarch64_sync_32_to_64(env);
 
         env->condexec_bits = 0;
     }
     env->banked_spsr[aarch64_banked_spsr_index(new_el)] = old_mode;
 
     qemu_log_mask(CPU_LOG_INT, "...with ELR 0x%" PRIx64 "\n",
                   env->elr_el[new_el]);
 
     if (cpu_isar_feature(aa64_pan, cpu)) {
         /* The value of PSTATE.PAN is normally preserved, except when ... */
         new_mode |= old_mode & PSTATE_PAN;
         switch (new_el) {
         case 2:
             /* ... the target is EL2 with HCR_EL2.{E2H,TGE} == '11' ...  */
             if ((arm_hcr_el2_eff(env) & (HCR_E2H | HCR_TGE))
                 != (HCR_E2H | HCR_TGE)) {
                 break;
             }
-            /* fall through */
+            fallthrough;
         case 1:
             /* ... the target is EL1 ... */
             /* ... and SCTLR_ELx.SPAN == 0, then set to 1.  */
             if ((env->cp15.sctlr_el[new_el] & SCTLR_SPAN) == 0) {
                 new_mode |= PSTATE_PAN;
             }
             break;
         }
     }
     if (cpu_isar_feature(aa64_mte, cpu)) {
         new_mode |= PSTATE_TCO;
     }
 
     if (cpu_isar_feature(aa64_ssbs, cpu)) {
         if (env->cp15.sctlr_el[new_el] & SCTLR_DSSBS_64) {
             new_mode |= PSTATE_SSBS;
         } else {
             new_mode &= ~PSTATE_SSBS;
         }
     }
 
     pstate_write(env, PSTATE_DAIF | new_mode);
     env->aarch64 = true;
     aarch64_restore_sp(env, new_el);
 
     if (tcg_enabled()) {
         helper_rebuild_hflags_a64(env, new_el);
     }
 
     env->pc = addr;
 
     qemu_log_mask(CPU_LOG_INT, "...to EL%d PC 0x%" PRIx64 " PSTATE 0x%x\n",
                   new_el, env->pc, pstate_read(env));
 }
 
 /*
  * Do semihosting call and set the appropriate return value. All the
  * permission and validity checks have been done at translate time.
  *
  * We only see semihosting exceptions in TCG only as they are not
  * trapped to the hypervisor in KVM.
  */
 #ifdef CONFIG_TCG
@@ -11909,111 +11911,111 @@ uint32_t HELPER(crc32c)(uint32_t acc, uint32_t val, uint32_t bytes)
 /*
  * Return the exception level to which FP-disabled exceptions should
  * be taken, or 0 if FP is enabled.
  */
 int fp_exception_el(CPUARMState *env, int cur_el)
 {
 #ifndef CONFIG_USER_ONLY
     uint64_t hcr_el2;
 
     /*
      * CPACR and the CPTR registers don't exist before v6, so FP is
      * always accessible
      */
     if (!arm_feature(env, ARM_FEATURE_V6)) {
         return 0;
     }
 
     if (arm_feature(env, ARM_FEATURE_M)) {
         /* CPACR can cause a NOCP UsageFault taken to current security state */
         if (!v7m_cpacr_pass(env, env->v7m.secure, cur_el != 0)) {
             return 1;
         }
 
         if (arm_feature(env, ARM_FEATURE_M_SECURITY) && !env->v7m.secure) {
             if (!extract32(env->v7m.nsacr, 10, 1)) {
                 /* FP insns cause a NOCP UsageFault taken to Secure */
                 return 3;
             }
         }
 
         return 0;
     }
 
     hcr_el2 = arm_hcr_el2_eff(env);
 
     /*
      * The CPACR controls traps to EL1, or PL1 if we're 32 bit:
      * 0, 2 : trap EL0 and EL1/PL1 accesses
      * 1    : trap only EL0 accesses
      * 3    : trap no accesses
      * This register is ignored if E2H+TGE are both set.
      */
     if ((hcr_el2 & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
         int fpen = FIELD_EX64(env->cp15.cpacr_el1, CPACR_EL1, FPEN);
 
         switch (fpen) {
         case 1:
             if (cur_el != 0) {
                 break;
             }
-            /* fall through */
+            fallthrough;
         case 0:
         case 2:
             /* Trap from Secure PL0 or PL1 to Secure PL1. */
             if (!arm_el_is_aa64(env, 3)
                 && (cur_el == 3 || arm_is_secure_below_el3(env))) {
                 return 3;
             }
             if (cur_el <= 1) {
                 return 1;
             }
             break;
         }
     }
 
     /*
      * The NSACR allows A-profile AArch32 EL3 and M-profile secure mode
      * to control non-secure access to the FPU. It doesn't have any
      * effect if EL3 is AArch64 or if EL3 doesn't exist at all.
      */
     if ((arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
          cur_el <= 2 && !arm_is_secure_below_el3(env))) {
         if (!extract32(env->cp15.nsacr, 10, 1)) {
             /* FP insns act as UNDEF */
             return cur_el == 2 ? 2 : 1;
         }
     }
 
     /*
      * CPTR_EL2 is present in v7VE or v8, and changes format
      * with HCR_EL2.E2H (regardless of TGE).
      */
     if (cur_el <= 2) {
         if (hcr_el2 & HCR_E2H) {
             switch (FIELD_EX64(env->cp15.cptr_el[2], CPTR_EL2, FPEN)) {
             case 1:
                 if (cur_el != 0 || !(hcr_el2 & HCR_TGE)) {
                     break;
                 }
-                /* fall through */
+                fallthrough;
             case 0:
             case 2:
                 return 2;
             }
         } else if (arm_is_el2_enabled(env)) {
             if (FIELD_EX64(env->cp15.cptr_el[2], CPTR_EL2, TFP)) {
                 return 2;
             }
         }
     }
 
     /* CPTR_EL3 : present in v8 */
     if (FIELD_EX64(env->cp15.cptr_el[3], CPTR_EL3, TFP)) {
         /* Trap all FP ops to EL3 */
         return 3;
     }
 #endif
     return 0;
 }
 
 /* Return the exception level we're running at if this is our mmu_idx */
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 95db9ec4c3..3f6783c100 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2240,192 +2240,192 @@ static bool pmsav7_use_background_region(ARMCPU *cpu, ARMMMUIdx mmu_idx,
 static bool get_phys_addr_pmsav7(CPUARMState *env,
                                  S1Translate *ptw,
                                  uint32_t address,
                                  MMUAccessType access_type,
                                  GetPhysAddrResult *result,
                                  ARMMMUFaultInfo *fi)
 {
     ARMCPU *cpu = env_archcpu(env);
     int n;
     ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
     bool is_user = regime_is_user(env, mmu_idx);
     bool secure = arm_space_is_secure(ptw->in_space);
 
     result->f.phys_addr = address;
     result->f.lg_page_size = TARGET_PAGE_BITS;
     result->f.prot = 0;
 
     if (regime_translation_disabled(env, mmu_idx, ptw->in_space) ||
         m_is_ppb_region(env, address)) {
         /*
          * MPU disabled or M profile PPB access: use default memory map.
          * The other case which uses the default memory map in the
          * v7M ARM ARM pseudocode is exception vector reads from the vector
          * table. In QEMU those accesses are done in arm_v7m_load_vector(),
          * which always does a direct read using address_space_ldl(), rather
          * than going via this function, so we don't need to check that here.
          */
         get_phys_addr_pmsav7_default(env, mmu_idx, address, &result->f.prot);
     } else { /* MPU enabled */
         for (n = (int)cpu->pmsav7_dregion - 1; n >= 0; n--) {
             /* region search */
             uint32_t base = env->pmsav7.drbar[n];
             uint32_t rsize = extract32(env->pmsav7.drsr[n], 1, 5);
             uint32_t rmask;
             bool srdis = false;
 
             if (!(env->pmsav7.drsr[n] & 0x1)) {
                 continue;
             }
 
             if (!rsize) {
                 qemu_log_mask(LOG_GUEST_ERROR,
                               "DRSR[%d]: Rsize field cannot be 0\n", n);
                 continue;
             }
             rsize++;
             rmask = (1ull << rsize) - 1;
 
             if (base & rmask) {
                 qemu_log_mask(LOG_GUEST_ERROR,
                               "DRBAR[%d]: 0x%" PRIx32 " misaligned "
                               "to DRSR region size, mask = 0x%" PRIx32 "\n",
                               n, base, rmask);
                 continue;
             }
 
             if (address < base || address > base + rmask) {
                 /*
                  * Address not in this region. We must check whether the
                  * region covers addresses in the same page as our address.
                  * In that case we must not report a size that covers the
                  * whole page for a subsequent hit against a different MPU
                  * region or the background region, because it would result in
                  * incorrect TLB hits for subsequent accesses to addresses that
                  * are in this MPU region.
                  */
                 if (ranges_overlap(base, rmask,
                                    address & TARGET_PAGE_MASK,
                                    TARGET_PAGE_SIZE)) {
                     result->f.lg_page_size = 0;
                 }
                 continue;
             }
 
             /* Region matched */
 
             if (rsize >= 8) { /* no subregions for regions < 256 bytes */
                 int i, snd;
                 uint32_t srdis_mask;
 
                 rsize -= 3; /* sub region size (power of 2) */
                 snd = ((address - base) >> rsize) & 0x7;
                 srdis = extract32(env->pmsav7.drsr[n], snd + 8, 1);
 
                 srdis_mask = srdis ? 0x3 : 0x0;
                 for (i = 2; i <= 8 && rsize < TARGET_PAGE_BITS; i *= 2) {
                     /*
                      * This will check in groups of 2, 4 and then 8, whether
                      * the subregion bits are consistent. rsize is incremented
                      * back up to give the region size, considering consistent
                      * adjacent subregions as one region. Stop testing if rsize
                      * is already big enough for an entire QEMU page.
                      */
                     int snd_rounded = snd & ~(i - 1);
                     uint32_t srdis_multi = extract32(env->pmsav7.drsr[n],
                                                      snd_rounded + 8, i);
                     if (srdis_mask ^ srdis_multi) {
                         break;
                     }
                     srdis_mask = (srdis_mask << i) | srdis_mask;
                     rsize++;
                 }
             }
             if (srdis) {
                 continue;
             }
             if (rsize < TARGET_PAGE_BITS) {
                 result->f.lg_page_size = rsize;
             }
             break;
         }
 
         if (n == -1) { /* no hits */
             if (!pmsav7_use_background_region(cpu, mmu_idx, secure, is_user)) {
                 /* background fault */
                 fi->type = ARMFault_Background;
                 return true;
             }
             get_phys_addr_pmsav7_default(env, mmu_idx, address,
                                          &result->f.prot);
         } else { /* a MPU hit! */
             uint32_t ap = extract32(env->pmsav7.dracr[n], 8, 3);
             uint32_t xn = extract32(env->pmsav7.dracr[n], 12, 1);
 
             if (m_is_system_region(env, address)) {
                 /* System space is always execute never */
                 xn = 1;
             }
 
             if (is_user) { /* User mode AP bit decoding */
                 switch (ap) {
                 case 0:
                 case 1:
                 case 5:
                     break; /* no access */
                 case 3:
                     result->f.prot |= PAGE_WRITE;
-                    /* fall through */
+                    fallthrough;
                 case 2:
                 case 6:
                     result->f.prot |= PAGE_READ | PAGE_EXEC;
                     break;
                 case 7:
                     /* for v7M, same as 6; for R profile a reserved value */
                     if (arm_feature(env, ARM_FEATURE_M)) {
                         result->f.prot |= PAGE_READ | PAGE_EXEC;
                         break;
                     }
-                    /* fall through */
+                    fallthrough;
                 default:
                     qemu_log_mask(LOG_GUEST_ERROR,
                                   "DRACR[%d]: Bad value for AP bits: 0x%"
                                   PRIx32 "\n", n, ap);
                 }
             } else { /* Priv. mode AP bits decoding */
                 switch (ap) {
                 case 0:
                     break; /* no access */
                 case 1:
                 case 2:
                 case 3:
                     result->f.prot |= PAGE_WRITE;
-                    /* fall through */
+                    fallthrough;
                 case 5:
                 case 6:
                     result->f.prot |= PAGE_READ | PAGE_EXEC;
                     break;
                 case 7:
                     /* for v7M, same as 6; for R profile a reserved value */
                     if (arm_feature(env, ARM_FEATURE_M)) {
                         result->f.prot |= PAGE_READ | PAGE_EXEC;
                         break;
                     }
-                    /* fall through */
+                    fallthrough;
                 default:
                     qemu_log_mask(LOG_GUEST_ERROR,
                                   "DRACR[%d]: Bad value for AP bits: 0x%"
                                   PRIx32 "\n", n, ap);
                 }
             }
 
             /* execute never */
             if (xn) {
                 result->f.prot &= ~PAGE_EXEC;
             }
         }
     }
 
     fi->type = ARMFault_Permission;
     fi->level = 1;
     return !(result->f.prot & (1 << access_type));
 }
@@ -3269,136 +3269,136 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
 static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
                                       target_ulong address,
                                       MMUAccessType access_type,
                                       GetPhysAddrResult *result,
                                       ARMMMUFaultInfo *fi)
 {
     ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
     ARMMMUIdx s1_mmu_idx;
 
     /*
      * The page table entries may downgrade Secure to NonSecure, but
      * cannot upgrade a NonSecure translation regime's attributes
      * to Secure or Realm.
      */
     result->f.attrs.space = ptw->in_space;
     result->f.attrs.secure = arm_space_is_secure(ptw->in_space);
 
     switch (mmu_idx) {
     case ARMMMUIdx_Phys_S:
     case ARMMMUIdx_Phys_NS:
     case ARMMMUIdx_Phys_Root:
     case ARMMMUIdx_Phys_Realm:
         /* Checking Phys early avoids special casing later vs regime_el. */
         return get_phys_addr_disabled(env, ptw, address, access_type,
                                       result, fi);
 
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_Stage1_E1:
     case ARMMMUIdx_Stage1_E1_PAN:
         /*
          * First stage lookup uses second stage for ptw; only
          * Secure has both S and NS IPA and starts with Stage2_S.
          */
         ptw->in_ptw_idx = (ptw->in_space == ARMSS_Secure) ?
             ARMMMUIdx_Stage2_S : ARMMMUIdx_Stage2;
         break;
 
     case ARMMMUIdx_Stage2:
     case ARMMMUIdx_Stage2_S:
         /*
          * Second stage lookup uses physical for ptw; whether this is S or
          * NS may depend on the SW/NSW bits if this is a stage 2 lookup for
          * the Secure EL2&0 regime.
          */
         ptw->in_ptw_idx = ptw_idx_for_stage_2(env, mmu_idx);
         break;
 
     case ARMMMUIdx_E10_0:
         s1_mmu_idx = ARMMMUIdx_Stage1_E0;
         goto do_twostage;
     case ARMMMUIdx_E10_1:
         s1_mmu_idx = ARMMMUIdx_Stage1_E1;
         goto do_twostage;
     case ARMMMUIdx_E10_1_PAN:
         s1_mmu_idx = ARMMMUIdx_Stage1_E1_PAN;
     do_twostage:
         /*
          * Call ourselves recursively to do the stage 1 and then stage 2
          * translations if mmu_idx is a two-stage regime, and EL2 present.
          * Otherwise, a stage1+stage2 translation is just stage 1.
          */
         ptw->in_mmu_idx = mmu_idx = s1_mmu_idx;
         if (arm_feature(env, ARM_FEATURE_EL2) &&
             !regime_translation_disabled(env, ARMMMUIdx_Stage2, ptw->in_space)) {
             return get_phys_addr_twostage(env, ptw, address, access_type,
                                           result, fi);
         }
-        /* fall through */
+        fallthrough;
 
     default:
         /* Single stage uses physical for ptw. */
         ptw->in_ptw_idx = arm_space_to_phys(ptw->in_space);
         break;
     }
 
     result->f.attrs.user = regime_is_user(env, mmu_idx);
 
     /*
      * Fast Context Switch Extension. This doesn't exist at all in v8.
      * In v7 and earlier it affects all stage 1 translations.
      */
     if (address < 0x02000000 && mmu_idx != ARMMMUIdx_Stage2
         && !arm_feature(env, ARM_FEATURE_V8)) {
         if (regime_el(env, mmu_idx) == 3) {
             address += env->cp15.fcseidr_s;
         } else {
             address += env->cp15.fcseidr_ns;
         }
     }
 
     if (arm_feature(env, ARM_FEATURE_PMSA)) {
         bool ret;
         result->f.lg_page_size = TARGET_PAGE_BITS;
 
         if (arm_feature(env, ARM_FEATURE_V8)) {
             /* PMSAv8 */
             ret = get_phys_addr_pmsav8(env, ptw, address, access_type,
                                        result, fi);
         } else if (arm_feature(env, ARM_FEATURE_V7)) {
             /* PMSAv7 */
             ret = get_phys_addr_pmsav7(env, ptw, address, access_type,
                                        result, fi);
         } else {
             /* Pre-v7 MPU */
             ret = get_phys_addr_pmsav5(env, ptw, address, access_type,
                                        result, fi);
         }
         qemu_log_mask(CPU_LOG_MMU, "PMSA MPU lookup for %s at 0x%08" PRIx32
                       " mmu_idx %u -> %s (prot %c%c%c)\n",
                       access_type == MMU_DATA_LOAD ? "reading" :
                       (access_type == MMU_DATA_STORE ? "writing" : "execute"),
                       (uint32_t)address, mmu_idx,
                       ret ? "Miss" : "Hit",
                       result->f.prot & PAGE_READ ? 'r' : '-',
                       result->f.prot & PAGE_WRITE ? 'w' : '-',
                       result->f.prot & PAGE_EXEC ? 'x' : '-');
 
         return ret;
     }
 
     /* Definitely a real MMU, not an MPU */
 
     if (regime_translation_disabled(env, mmu_idx, ptw->in_space)) {
         return get_phys_addr_disabled(env, ptw, address, access_type,
                                       result, fi);
     }
 
     if (regime_using_lpae_format(env, mmu_idx)) {
         return get_phys_addr_lpae(env, ptw, address, access_type, result, fi);
     } else if (arm_feature(env, ARM_FEATURE_V7) ||
                regime_sctlr(env, mmu_idx) & SCTLR_XP) {
         return get_phys_addr_v6(env, ptw, address, access_type, result, fi);
     } else {
         return get_phys_addr_v5(env, ptw, address, access_type, result, fi);
     }
 }
diff --git a/target/arm/tcg/psci.c b/target/arm/tcg/psci.c
index 6c1239bb96..dafc39c3d7 100644
--- a/target/arm/tcg/psci.c
+++ b/target/arm/tcg/psci.c
@@ -56,152 +56,152 @@ bool arm_is_psci_call(ARMCPU *cpu, int excp_type)
 void arm_handle_psci_call(ARMCPU *cpu)
 {
     /*
      * This function partially implements the logic for dispatching Power State
      * Coordination Interface (PSCI) calls (as described in ARM DEN 0022D.b),
      * to the extent required for bringing up and taking down secondary cores,
      * and for handling reset and poweroff requests.
      * Additional information about the calling convention used is available in
      * the document 'SMC Calling Convention' (ARM DEN 0028)
      */
     CPUARMState *env = &cpu->env;
     uint64_t param[4];
     uint64_t context_id, mpidr;
     target_ulong entry;
     int32_t ret = 0;
     int i;
 
     for (i = 0; i < 4; i++) {
         /*
          * All PSCI functions take explicit 32-bit or native int sized
          * arguments so we can simply zero-extend all arguments regardless
          * of which exact function we are about to call.
          */
         param[i] = is_a64(env) ? env->xregs[i] : env->regs[i];
     }
 
     if ((param[0] & QEMU_PSCI_0_2_64BIT) && !is_a64(env)) {
         ret = QEMU_PSCI_RET_NOT_SUPPORTED;
         goto err;
     }
 
     switch (param[0]) {
         CPUState *target_cpu_state;
         ARMCPU *target_cpu;
 
     case QEMU_PSCI_0_2_FN_PSCI_VERSION:
         ret = QEMU_PSCI_VERSION_1_1;
         break;
     case QEMU_PSCI_0_2_FN_MIGRATE_INFO_TYPE:
         ret = QEMU_PSCI_0_2_RET_TOS_MIGRATION_NOT_REQUIRED; /* No trusted OS */
         break;
     case QEMU_PSCI_0_2_FN_AFFINITY_INFO:
     case QEMU_PSCI_0_2_FN64_AFFINITY_INFO:
         mpidr = param[1];
 
         switch (param[2]) {
         case 0:
             target_cpu_state = arm_get_cpu_by_id(mpidr);
             if (!target_cpu_state) {
                 ret = QEMU_PSCI_RET_INVALID_PARAMS;
                 break;
             }
             target_cpu = ARM_CPU(target_cpu_state);
 
             g_assert(qemu_mutex_iothread_locked());
             ret = target_cpu->power_state;
             break;
         default:
             /* Everything above affinity level 0 is always on. */
             ret = 0;
         }
         break;
     case QEMU_PSCI_0_2_FN_SYSTEM_RESET:
         qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         /* QEMU reset and shutdown are async requests, but PSCI
          * mandates that we never return from the reset/shutdown
          * call, so power the CPU off now so it doesn't execute
          * anything further.
          */
         goto cpu_off;
     case QEMU_PSCI_0_2_FN_SYSTEM_OFF:
         qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
         goto cpu_off;
     case QEMU_PSCI_0_1_FN_CPU_ON:
     case QEMU_PSCI_0_2_FN_CPU_ON:
     case QEMU_PSCI_0_2_FN64_CPU_ON:
     {
         /* The PSCI spec mandates that newly brought up CPUs start
          * in the highest exception level which exists and is enabled
          * on the calling CPU. Since the QEMU PSCI implementation is
          * acting as a "fake EL3" or "fake EL2" firmware, this for us
          * means that we want to start at the highest NS exception level
          * that we are providing to the guest.
          * The execution mode should be that which is currently in use
          * by the same exception level on the calling CPU.
          * The CPU should be started with the context_id value
          * in x0 (if AArch64) or r0 (if AArch32).
          */
         int target_el = arm_feature(env, ARM_FEATURE_EL2) ? 2 : 1;
         bool target_aarch64 = arm_el_is_aa64(env, target_el);
 
         mpidr = param[1];
         entry = param[2];
         context_id = param[3];
         ret = arm_set_cpu_on(mpidr, entry, context_id,
                              target_el, target_aarch64);
         break;
     }
     case QEMU_PSCI_0_1_FN_CPU_OFF:
     case QEMU_PSCI_0_2_FN_CPU_OFF:
         goto cpu_off;
     case QEMU_PSCI_0_1_FN_CPU_SUSPEND:
     case QEMU_PSCI_0_2_FN_CPU_SUSPEND:
     case QEMU_PSCI_0_2_FN64_CPU_SUSPEND:
         /* Affinity levels are not supported in QEMU */
         if (param[1] & 0xfffe0000) {
             ret = QEMU_PSCI_RET_INVALID_PARAMS;
             break;
         }
         /* Powerdown is not supported, we always go into WFI */
         if (is_a64(env)) {
             env->xregs[0] = 0;
         } else {
             env->regs[0] = 0;
         }
         helper_wfi(env, 4);
         break;
     case QEMU_PSCI_1_0_FN_PSCI_FEATURES:
         switch (param[1]) {
         case QEMU_PSCI_0_2_FN_PSCI_VERSION:
         case QEMU_PSCI_0_2_FN_MIGRATE_INFO_TYPE:
         case QEMU_PSCI_0_2_FN_AFFINITY_INFO:
         case QEMU_PSCI_0_2_FN64_AFFINITY_INFO:
         case QEMU_PSCI_0_2_FN_SYSTEM_RESET:
         case QEMU_PSCI_0_2_FN_SYSTEM_OFF:
         case QEMU_PSCI_0_1_FN_CPU_ON:
         case QEMU_PSCI_0_2_FN_CPU_ON:
         case QEMU_PSCI_0_2_FN64_CPU_ON:
         case QEMU_PSCI_0_1_FN_CPU_OFF:
         case QEMU_PSCI_0_2_FN_CPU_OFF:
         case QEMU_PSCI_0_1_FN_CPU_SUSPEND:
         case QEMU_PSCI_0_2_FN_CPU_SUSPEND:
         case QEMU_PSCI_0_2_FN64_CPU_SUSPEND:
         case QEMU_PSCI_1_0_FN_PSCI_FEATURES:
             if (!(param[1] & QEMU_PSCI_0_2_64BIT) || is_a64(env)) {
                 ret = 0;
                 break;
             }
-            /* fallthrough */
+            fallthrough;
         case QEMU_PSCI_0_1_FN_MIGRATE:
         case QEMU_PSCI_0_2_FN_MIGRATE:
         default:
             ret = QEMU_PSCI_RET_NOT_SUPPORTED;
             break;
         }
         break;
     case QEMU_PSCI_0_1_FN_MIGRATE:
     case QEMU_PSCI_0_2_FN_MIGRATE:
     default:
         ret = QEMU_PSCI_RET_NOT_SUPPORTED;
         break;
     }
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 10e8dcf743..ee97219acb 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5725,176 +5725,176 @@ static void handle_fp_compare(DisasContext *s, int size,
 /* Floating point compare
  *   31  30  29 28       24 23  22  21 20  16 15 14 13  10    9    5 4     0
  * +---+---+---+-----------+------+---+------+-----+---------+------+-------+
  * | M | 0 | S | 1 1 1 1 0 | type | 1 |  Rm  | op  | 1 0 0 0 |  Rn  |  op2  |
  * +---+---+---+-----------+------+---+------+-----+---------+------+-------+
  */
 static void disas_fp_compare(DisasContext *s, uint32_t insn)
 {
     unsigned int mos, type, rm, op, rn, opc, op2r;
     int size;
 
     mos = extract32(insn, 29, 3);
     type = extract32(insn, 22, 2);
     rm = extract32(insn, 16, 5);
     op = extract32(insn, 14, 2);
     rn = extract32(insn, 5, 5);
     opc = extract32(insn, 3, 2);
     op2r = extract32(insn, 0, 3);
 
     if (mos || op || op2r) {
         unallocated_encoding(s);
         return;
     }
 
     switch (type) {
     case 0:
         size = MO_32;
         break;
     case 1:
         size = MO_64;
         break;
     case 3:
         size = MO_16;
         if (dc_isar_feature(aa64_fp16, s)) {
             break;
         }
-        /* fallthru */
+        fallthrough;
     default:
         unallocated_encoding(s);
         return;
     }
 
     if (!fp_access_check(s)) {
         return;
     }
 
     handle_fp_compare(s, size, rn, rm, opc & 1, opc & 2);
 }
 
 /* Floating point conditional compare
  *   31  30  29 28       24 23  22  21 20  16 15  12 11 10 9    5  4   3    0
  * +---+---+---+-----------+------+---+------+------+-----+------+----+------+
  * | M | 0 | S | 1 1 1 1 0 | type | 1 |  Rm  | cond | 0 1 |  Rn  | op | nzcv |
  * +---+---+---+-----------+------+---+------+------+-----+------+----+------+
  */
 static void disas_fp_ccomp(DisasContext *s, uint32_t insn)
 {
     unsigned int mos, type, rm, cond, rn, op, nzcv;
     TCGLabel *label_continue = NULL;
     int size;
 
     mos = extract32(insn, 29, 3);
     type = extract32(insn, 22, 2);
     rm = extract32(insn, 16, 5);
     cond = extract32(insn, 12, 4);
     rn = extract32(insn, 5, 5);
     op = extract32(insn, 4, 1);
     nzcv = extract32(insn, 0, 4);
 
     if (mos) {
         unallocated_encoding(s);
         return;
     }
 
     switch (type) {
     case 0:
         size = MO_32;
         break;
     case 1:
         size = MO_64;
         break;
     case 3:
         size = MO_16;
         if (dc_isar_feature(aa64_fp16, s)) {
             break;
         }
-        /* fallthru */
+        fallthrough;
     default:
         unallocated_encoding(s);
         return;
     }
 
     if (!fp_access_check(s)) {
         return;
     }
 
     if (cond < 0x0e) { /* not always */
         TCGLabel *label_match = gen_new_label();
         label_continue = gen_new_label();
         arm_gen_test_cc(cond, label_match);
         /* nomatch: */
         gen_set_nzcv(tcg_constant_i64(nzcv << 28));
         tcg_gen_br(label_continue);
         gen_set_label(label_match);
     }
 
     handle_fp_compare(s, size, rn, rm, false, op);
 
     if (cond < 0x0e) {
         gen_set_label(label_continue);
     }
 }
 
 /* Floating point conditional select
  *   31  30  29 28       24 23  22  21 20  16 15  12 11 10 9    5 4    0
  * +---+---+---+-----------+------+---+------+------+-----+------+------+
  * | M | 0 | S | 1 1 1 1 0 | type | 1 |  Rm  | cond | 1 1 |  Rn  |  Rd  |
  * +---+---+---+-----------+------+---+------+------+-----+------+------+
  */
 static void disas_fp_csel(DisasContext *s, uint32_t insn)
 {
     unsigned int mos, type, rm, cond, rn, rd;
     TCGv_i64 t_true, t_false;
     DisasCompare64 c;
     MemOp sz;
 
     mos = extract32(insn, 29, 3);
     type = extract32(insn, 22, 2);
     rm = extract32(insn, 16, 5);
     cond = extract32(insn, 12, 4);
     rn = extract32(insn, 5, 5);
     rd = extract32(insn, 0, 5);
 
     if (mos) {
         unallocated_encoding(s);
         return;
     }
 
     switch (type) {
     case 0:
         sz = MO_32;
         break;
     case 1:
         sz = MO_64;
         break;
     case 3:
         sz = MO_16;
         if (dc_isar_feature(aa64_fp16, s)) {
             break;
         }
-        /* fallthru */
+        fallthrough;
     default:
         unallocated_encoding(s);
         return;
     }
 
     if (!fp_access_check(s)) {
         return;
     }
 
     /* Zero extend sreg & hreg inputs to 64 bits now.  */
     t_true = tcg_temp_new_i64();
     t_false = tcg_temp_new_i64();
     read_vec_element(s, t_true, rn, 0, sz);
     read_vec_element(s, t_false, rm, 0, sz);
 
     a64_test_cc(&c, cond);
     tcg_gen_movcond_i64(c.cond, t_true, c.value, tcg_constant_i64(0),
                         t_true, t_false);
 
     /* Note that sregs & hregs write back zeros to the high bits,
        and we've already done the zero-extension.  */
     write_fp_dreg(s, rd, t_true);
 }
 
 /* Floating-point data-processing (1 source) - half precision */
@@ -6159,95 +6159,95 @@ static void handle_fp_fcvt(DisasContext *s, int opcode,
 /* Floating point data-processing (1 source)
  *   31  30  29 28       24 23  22  21 20    15 14       10 9    5 4    0
  * +---+---+---+-----------+------+---+--------+-----------+------+------+
  * | M | 0 | S | 1 1 1 1 0 | type | 1 | opcode | 1 0 0 0 0 |  Rn  |  Rd  |
  * +---+---+---+-----------+------+---+--------+-----------+------+------+
  */
 static void disas_fp_1src(DisasContext *s, uint32_t insn)
 {
     int mos = extract32(insn, 29, 3);
     int type = extract32(insn, 22, 2);
     int opcode = extract32(insn, 15, 6);
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
 
     if (mos) {
         goto do_unallocated;
     }
 
     switch (opcode) {
     case 0x4: case 0x5: case 0x7:
     {
         /* FCVT between half, single and double precision */
         int dtype = extract32(opcode, 0, 2);
         if (type == 2 || dtype == type) {
             goto do_unallocated;
         }
         if (!fp_access_check(s)) {
             return;
         }
 
         handle_fp_fcvt(s, opcode, rd, rn, dtype, type);
         break;
     }
 
     case 0x10 ... 0x13: /* FRINT{32,64}{X,Z} */
         if (type > 1 || !dc_isar_feature(aa64_frint, s)) {
             goto do_unallocated;
         }
-        /* fall through */
+        fallthrough;
     case 0x0 ... 0x3:
     case 0x8 ... 0xc:
     case 0xe ... 0xf:
         /* 32-to-32 and 64-to-64 ops */
         switch (type) {
         case 0:
             if (!fp_access_check(s)) {
                 return;
             }
             handle_fp_1src_single(s, opcode, rd, rn);
             break;
         case 1:
             if (!fp_access_check(s)) {
                 return;
             }
             handle_fp_1src_double(s, opcode, rd, rn);
             break;
         case 3:
             if (!dc_isar_feature(aa64_fp16, s)) {
                 goto do_unallocated;
             }
 
             if (!fp_access_check(s)) {
                 return;
             }
             handle_fp_1src_half(s, opcode, rd, rn);
             break;
         default:
             goto do_unallocated;
         }
         break;
 
     case 0x6:
         switch (type) {
         case 1: /* BFCVT */
             if (!dc_isar_feature(aa64_bf16, s)) {
                 goto do_unallocated;
             }
             if (!fp_access_check(s)) {
                 return;
             }
             handle_fp_1src_single(s, opcode, rd, rn);
             break;
         default:
             goto do_unallocated;
         }
         break;
 
     default:
     do_unallocated:
         unallocated_encoding(s);
         break;
     }
 }
 
 /* Floating-point data-processing (2 source) - single precision */
@@ -6593,52 +6593,52 @@ static void disas_fp_3src(DisasContext *s, uint32_t insn)
 /* Floating point immediate
  *   31  30  29 28       24 23  22  21 20        13 12   10 9    5 4    0
  * +---+---+---+-----------+------+---+------------+-------+------+------+
  * | M | 0 | S | 1 1 1 1 0 | type | 1 |    imm8    | 1 0 0 | imm5 |  Rd  |
  * +---+---+---+-----------+------+---+------------+-------+------+------+
  */
 static void disas_fp_imm(DisasContext *s, uint32_t insn)
 {
     int rd = extract32(insn, 0, 5);
     int imm5 = extract32(insn, 5, 5);
     int imm8 = extract32(insn, 13, 8);
     int type = extract32(insn, 22, 2);
     int mos = extract32(insn, 29, 3);
     uint64_t imm;
     MemOp sz;
 
     if (mos || imm5) {
         unallocated_encoding(s);
         return;
     }
 
     switch (type) {
     case 0:
         sz = MO_32;
         break;
     case 1:
         sz = MO_64;
         break;
     case 3:
         sz = MO_16;
         if (dc_isar_feature(aa64_fp16, s)) {
             break;
         }
-        /* fallthru */
+        fallthrough;
     default:
         unallocated_encoding(s);
         return;
     }
 
     if (!fp_access_check(s)) {
         return;
     }
 
     imm = vfp_expand_imm(sz, imm8);
     write_fp_dreg(s, rd, tcg_constant_i64(imm));
 }
 
 /* Handle floating point <=> fixed point conversions. Note that we can
  * also deal with fp <=> integer conversions as a special case (scale == 64)
  * OPTME: consider handling that special case specially or at least skipping
  * the call to scalbn in the helpers for zero shifts.
  */
@@ -6803,57 +6803,57 @@ static void handle_fpfpcvt(DisasContext *s, int rd, int rn, int opcode,
 /* Floating point <-> fixed point conversions
  *   31   30  29 28       24 23  22  21 20   19 18    16 15   10 9    5 4    0
  * +----+---+---+-----------+------+---+-------+--------+-------+------+------+
  * | sf | 0 | S | 1 1 1 1 0 | type | 0 | rmode | opcode | scale |  Rn  |  Rd  |
  * +----+---+---+-----------+------+---+-------+--------+-------+------+------+
  */
 static void disas_fp_fixed_conv(DisasContext *s, uint32_t insn)
 {
     int rd = extract32(insn, 0, 5);
     int rn = extract32(insn, 5, 5);
     int scale = extract32(insn, 10, 6);
     int opcode = extract32(insn, 16, 3);
     int rmode = extract32(insn, 19, 2);
     int type = extract32(insn, 22, 2);
     bool sbit = extract32(insn, 29, 1);
     bool sf = extract32(insn, 31, 1);
     bool itof;
 
     if (sbit || (!sf && scale < 32)) {
         unallocated_encoding(s);
         return;
     }
 
     switch (type) {
     case 0: /* float32 */
     case 1: /* float64 */
         break;
     case 3: /* float16 */
         if (dc_isar_feature(aa64_fp16, s)) {
             break;
         }
-        /* fallthru */
+        fallthrough;
     default:
         unallocated_encoding(s);
         return;
     }
 
     switch ((rmode << 3) | opcode) {
     case 0x2: /* SCVTF */
     case 0x3: /* UCVTF */
         itof = true;
         break;
     case 0x18: /* FCVTZS */
     case 0x19: /* FCVTZU */
         itof = false;
         break;
     default:
         unallocated_encoding(s);
         return;
     }
 
     if (!fp_access_check(s)) {
         return;
     }
 
     handle_fpfpcvt(s, rd, rn, opcode, itof, FPROUNDING_ZERO, scale, sf, type);
 }
@@ -6936,98 +6936,98 @@ static void handle_fjcvtzs(DisasContext *s, int rd, int rn)
 /* Floating point <-> integer conversions
  *   31   30  29 28       24 23  22  21 20   19 18 16 15         10 9  5 4  0
  * +----+---+---+-----------+------+---+-------+-----+-------------+----+----+
  * | sf | 0 | S | 1 1 1 1 0 | type | 1 | rmode | opc | 0 0 0 0 0 0 | Rn | Rd |
  * +----+---+---+-----------+------+---+-------+-----+-------------+----+----+
  */
 static void disas_fp_int_conv(DisasContext *s, uint32_t insn)
 {
     int rd = extract32(insn, 0, 5);
     int rn = extract32(insn, 5, 5);
     int opcode = extract32(insn, 16, 3);
     int rmode = extract32(insn, 19, 2);
     int type = extract32(insn, 22, 2);
     bool sbit = extract32(insn, 29, 1);
     bool sf = extract32(insn, 31, 1);
     bool itof = false;
 
     if (sbit) {
         goto do_unallocated;
     }
 
     switch (opcode) {
     case 2: /* SCVTF */
     case 3: /* UCVTF */
         itof = true;
-        /* fallthru */
+        fallthrough;
     case 4: /* FCVTAS */
     case 5: /* FCVTAU */
         if (rmode != 0) {
             goto do_unallocated;
         }
-        /* fallthru */
+        fallthrough;
     case 0: /* FCVT[NPMZ]S */
     case 1: /* FCVT[NPMZ]U */
         switch (type) {
         case 0: /* float32 */
         case 1: /* float64 */
             break;
         case 3: /* float16 */
             if (!dc_isar_feature(aa64_fp16, s)) {
                 goto do_unallocated;
             }
             break;
         default:
             goto do_unallocated;
         }
         if (!fp_access_check(s)) {
             return;
         }
         handle_fpfpcvt(s, rd, rn, opcode, itof, rmode, 64, sf, type);
         break;
 
     default:
         switch (sf << 7 | type << 5 | rmode << 3 | opcode) {
         case 0b01100110: /* FMOV half <-> 32-bit int */
         case 0b01100111:
         case 0b11100110: /* FMOV half <-> 64-bit int */
         case 0b11100111:
             if (!dc_isar_feature(aa64_fp16, s)) {
                 goto do_unallocated;
             }
-            /* fallthru */
+            fallthrough;
         case 0b00000110: /* FMOV 32-bit */
         case 0b00000111:
         case 0b10100110: /* FMOV 64-bit */
         case 0b10100111:
         case 0b11001110: /* FMOV top half of 128-bit */
         case 0b11001111:
             if (!fp_access_check(s)) {
                 return;
             }
             itof = opcode & 1;
             handle_fmov(s, rd, rn, type, itof);
             break;
 
         case 0b00111110: /* FJCVTZS */
             if (!dc_isar_feature(aa64_jscvt, s)) {
                 goto do_unallocated;
             } else if (fp_access_check(s)) {
                 handle_fjcvtzs(s, rd, rn);
             }
             break;
 
         default:
         do_unallocated:
             unallocated_encoding(s);
             return;
         }
         break;
     }
 }
 
 /* FP-specific subcases of table C3-6 (SIMD and FP data processing)
  *   31  30  29 28     25 24                          0
  * +---+---+---+---------+-----------------------------+
  * |   | 0 |   | 1 1 1 1 |                             |
  * +---+---+---+---------+-----------------------------+
  */
@@ -7362,159 +7362,159 @@ static TCGv_i32 do_reduction_op(DisasContext *s, int fpopcode, int rn,
 /* AdvSIMD across lanes
  *   31  30  29 28       24 23  22 21       17 16    12 11 10 9    5 4    0
  * +---+---+---+-----------+------+-----------+--------+-----+------+------+
  * | 0 | Q | U | 0 1 1 1 0 | size | 1 1 0 0 0 | opcode | 1 0 |  Rn  |  Rd  |
  * +---+---+---+-----------+------+-----------+--------+-----+------+------+
  */
 static void disas_simd_across_lanes(DisasContext *s, uint32_t insn)
 {
     int rd = extract32(insn, 0, 5);
     int rn = extract32(insn, 5, 5);
     int size = extract32(insn, 22, 2);
     int opcode = extract32(insn, 12, 5);
     bool is_q = extract32(insn, 30, 1);
     bool is_u = extract32(insn, 29, 1);
     bool is_fp = false;
     bool is_min = false;
     int esize;
     int elements;
     int i;
     TCGv_i64 tcg_res, tcg_elt;
 
     switch (opcode) {
     case 0x1b: /* ADDV */
         if (is_u) {
             unallocated_encoding(s);
             return;
         }
-        /* fall through */
+        fallthrough;
     case 0x3: /* SADDLV, UADDLV */
     case 0xa: /* SMAXV, UMAXV */
     case 0x1a: /* SMINV, UMINV */
         if (size == 3 || (size == 2 && !is_q)) {
             unallocated_encoding(s);
             return;
         }
         break;
     case 0xc: /* FMAXNMV, FMINNMV */
     case 0xf: /* FMAXV, FMINV */
         /* Bit 1 of size field encodes min vs max and the actual size
          * depends on the encoding of the U bit. If not set (and FP16
          * enabled) then we do half-precision float instead of single
          * precision.
          */
         is_min = extract32(size, 1, 1);
         is_fp = true;
         if (!is_u && dc_isar_feature(aa64_fp16, s)) {
             size = 1;
         } else if (!is_u || !is_q || extract32(size, 0, 1)) {
             unallocated_encoding(s);
             return;
         } else {
             size = 2;
         }
         break;
     default:
         unallocated_encoding(s);
         return;
     }
 
     if (!fp_access_check(s)) {
         return;
     }
 
     esize = 8 << size;
     elements = (is_q ? 128 : 64) / esize;
 
     tcg_res = tcg_temp_new_i64();
     tcg_elt = tcg_temp_new_i64();
 
     /* These instructions operate across all lanes of a vector
      * to produce a single result. We can guarantee that a 64
      * bit intermediate is sufficient:
      *  + for [US]ADDLV the maximum element size is 32 bits, and
      *    the result type is 64 bits
      *  + for FMAX*V, FMIN*V, ADDV the intermediate type is the
      *    same as the element size, which is 32 bits at most
      * For the integer operations we can choose to work at 64
      * or 32 bits and truncate at the end; for simplicity
      * we use 64 bits always. The floating point
      * ops do require 32 bit intermediates, though.
      */
     if (!is_fp) {
         read_vec_element(s, tcg_res, rn, 0, size | (is_u ? 0 : MO_SIGN));
 
         for (i = 1; i < elements; i++) {
             read_vec_element(s, tcg_elt, rn, i, size | (is_u ? 0 : MO_SIGN));
 
             switch (opcode) {
             case 0x03: /* SADDLV / UADDLV */
             case 0x1b: /* ADDV */
                 tcg_gen_add_i64(tcg_res, tcg_res, tcg_elt);
                 break;
             case 0x0a: /* SMAXV / UMAXV */
                 if (is_u) {
                     tcg_gen_umax_i64(tcg_res, tcg_res, tcg_elt);
                 } else {
                     tcg_gen_smax_i64(tcg_res, tcg_res, tcg_elt);
                 }
                 break;
             case 0x1a: /* SMINV / UMINV */
                 if (is_u) {
                     tcg_gen_umin_i64(tcg_res, tcg_res, tcg_elt);
                 } else {
                     tcg_gen_smin_i64(tcg_res, tcg_res, tcg_elt);
                 }
                 break;
             default:
                 g_assert_not_reached();
             }
 
         }
     } else {
         /* Floating point vector reduction ops which work across 32
          * bit (single) or 16 bit (half-precision) intermediates.
          * Note that correct NaN propagation requires that we do these
          * operations in exactly the order specified by the pseudocode.
          */
         TCGv_ptr fpst = fpstatus_ptr(size == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
         int fpopcode = opcode | is_min << 4 | is_u << 5;
         int vmap = (1 << elements) - 1;
         TCGv_i32 tcg_res32 = do_reduction_op(s, fpopcode, rn, esize,
                                              (is_q ? 128 : 64), vmap, fpst);
         tcg_gen_extu_i32_i64(tcg_res, tcg_res32);
     }
 
     /* Now truncate the result to the width required for the final output */
     if (opcode == 0x03) {
         /* SADDLV, UADDLV: result is 2*esize */
         size++;
     }
 
     switch (size) {
     case 0:
         tcg_gen_ext8u_i64(tcg_res, tcg_res);
         break;
     case 1:
         tcg_gen_ext16u_i64(tcg_res, tcg_res);
         break;
     case 2:
         tcg_gen_ext32u_i64(tcg_res, tcg_res);
         break;
     case 3:
         break;
     default:
         g_assert_not_reached();
     }
 
     write_fp_dreg(s, rd, tcg_res);
 }
 
 /* DUP (Element, Vector)
  *
  *  31  30   29              21 20    16 15        10  9    5 4    0
  * +---+---+-------------------+--------+-------------+------+------+
  * | 0 | Q | 0 0 1 1 1 0 0 0 0 |  imm5  | 0 0 0 0 0 1 |  Rn  |  Rd  |
  * +---+---+-------------------+--------+-------------+------+------+
  *
  * size: encoded in imm5 (see ARM ARM LowestSetBit())
  */
@@ -8269,111 +8269,111 @@ static void handle_vec_simd_sqshrn(DisasContext *s, bool is_scalar, bool is_q,
 /* SQSHLU, UQSHL, SQSHL: saturating left shifts */
 static void handle_simd_qshl(DisasContext *s, bool scalar, bool is_q,
                              bool src_unsigned, bool dst_unsigned,
                              int immh, int immb, int rn, int rd)
 {
     int immhb = immh << 3 | immb;
     int size = 32 - clz32(immh) - 1;
     int shift = immhb - (8 << size);
     int pass;
 
     assert(immh != 0);
     assert(!(scalar && is_q));
 
     if (!scalar) {
         if (!is_q && extract32(immh, 3, 1)) {
             unallocated_encoding(s);
             return;
         }
 
         /* Since we use the variable-shift helpers we must
          * replicate the shift count into each element of
          * the tcg_shift value.
          */
         switch (size) {
         case 0:
             shift |= shift << 8;
-            /* fall through */
+            fallthrough;
         case 1:
             shift |= shift << 16;
             break;
         case 2:
         case 3:
             break;
         default:
             g_assert_not_reached();
         }
     }
 
     if (!fp_access_check(s)) {
         return;
     }
 
     if (size == 3) {
         TCGv_i64 tcg_shift = tcg_constant_i64(shift);
         static NeonGenTwo64OpEnvFn * const fns[2][2] = {
             { gen_helper_neon_qshl_s64, gen_helper_neon_qshlu_s64 },
             { NULL, gen_helper_neon_qshl_u64 },
         };
         NeonGenTwo64OpEnvFn *genfn = fns[src_unsigned][dst_unsigned];
         int maxpass = is_q ? 2 : 1;
 
         for (pass = 0; pass < maxpass; pass++) {
             TCGv_i64 tcg_op = tcg_temp_new_i64();
 
             read_vec_element(s, tcg_op, rn, pass, MO_64);
             genfn(tcg_op, tcg_env, tcg_op, tcg_shift);
             write_vec_element(s, tcg_op, rd, pass, MO_64);
         }
         clear_vec_high(s, is_q, rd);
     } else {
         TCGv_i32 tcg_shift = tcg_constant_i32(shift);
         static NeonGenTwoOpEnvFn * const fns[2][2][3] = {
             {
                 { gen_helper_neon_qshl_s8,
                   gen_helper_neon_qshl_s16,
                   gen_helper_neon_qshl_s32 },
                 { gen_helper_neon_qshlu_s8,
                   gen_helper_neon_qshlu_s16,
                   gen_helper_neon_qshlu_s32 }
             }, {
                 { NULL, NULL, NULL },
                 { gen_helper_neon_qshl_u8,
                   gen_helper_neon_qshl_u16,
                   gen_helper_neon_qshl_u32 }
             }
         };
         NeonGenTwoOpEnvFn *genfn = fns[src_unsigned][dst_unsigned][size];
         MemOp memop = scalar ? size : MO_32;
         int maxpass = scalar ? 1 : is_q ? 4 : 2;
 
         for (pass = 0; pass < maxpass; pass++) {
             TCGv_i32 tcg_op = tcg_temp_new_i32();
 
             read_vec_element_i32(s, tcg_op, rn, pass, memop);
             genfn(tcg_op, tcg_env, tcg_op, tcg_shift);
             if (scalar) {
                 switch (size) {
                 case 0:
                     tcg_gen_ext8u_i32(tcg_op, tcg_op);
                     break;
                 case 1:
                     tcg_gen_ext16u_i32(tcg_op, tcg_op);
                     break;
                 case 2:
                     break;
                 default:
                     g_assert_not_reached();
                 }
                 write_fp_sreg(s, rd, tcg_op);
             } else {
                 write_vec_element_i32(s, tcg_op, rd, pass, MO_32);
             }
         }
 
         if (!scalar) {
             clear_vec_high(s, is_q, rd);
         }
     }
 }
 
 /* Common vector code for handling integer to FP conversion */
@@ -8614,170 +8614,170 @@ static void handle_simd_shift_fpint_conv(DisasContext *s, bool is_scalar,
 /* AdvSIMD scalar shift by immediate
  *  31 30  29 28         23 22  19 18  16 15    11  10 9    5 4    0
  * +-----+---+-------------+------+------+--------+---+------+------+
  * | 0 1 | U | 1 1 1 1 1 0 | immh | immb | opcode | 1 |  Rn  |  Rd  |
  * +-----+---+-------------+------+------+--------+---+------+------+
  *
  * This is the scalar version so it works on a fixed sized registers
  */
 static void disas_simd_scalar_shift_imm(DisasContext *s, uint32_t insn)
 {
     int rd = extract32(insn, 0, 5);
     int rn = extract32(insn, 5, 5);
     int opcode = extract32(insn, 11, 5);
     int immb = extract32(insn, 16, 3);
     int immh = extract32(insn, 19, 4);
     bool is_u = extract32(insn, 29, 1);
 
     if (immh == 0) {
         unallocated_encoding(s);
         return;
     }
 
     switch (opcode) {
     case 0x08: /* SRI */
         if (!is_u) {
             unallocated_encoding(s);
             return;
         }
-        /* fall through */
+        fallthrough;
     case 0x00: /* SSHR / USHR */
     case 0x02: /* SSRA / USRA */
     case 0x04: /* SRSHR / URSHR */
     case 0x06: /* SRSRA / URSRA */
         handle_scalar_simd_shri(s, is_u, immh, immb, opcode, rn, rd);
         break;
     case 0x0a: /* SHL / SLI */
         handle_scalar_simd_shli(s, is_u, immh, immb, opcode, rn, rd);
         break;
     case 0x1c: /* SCVTF, UCVTF */
         handle_simd_shift_intfp_conv(s, true, false, is_u, immh, immb,
                                      opcode, rn, rd);
         break;
     case 0x10: /* SQSHRUN, SQSHRUN2 */
     case 0x11: /* SQRSHRUN, SQRSHRUN2 */
         if (!is_u) {
             unallocated_encoding(s);
             return;
         }
         handle_vec_simd_sqshrn(s, true, false, false, true,
                                immh, immb, opcode, rn, rd);
         break;
     case 0x12: /* SQSHRN, SQSHRN2, UQSHRN */
     case 0x13: /* SQRSHRN, SQRSHRN2, UQRSHRN, UQRSHRN2 */
         handle_vec_simd_sqshrn(s, true, false, is_u, is_u,
                                immh, immb, opcode, rn, rd);
         break;
     case 0xc: /* SQSHLU */
         if (!is_u) {
             unallocated_encoding(s);
             return;
         }
         handle_simd_qshl(s, true, false, false, true, immh, immb, rn, rd);
         break;
     case 0xe: /* SQSHL, UQSHL */
         handle_simd_qshl(s, true, false, is_u, is_u, immh, immb, rn, rd);
         break;
     case 0x1f: /* FCVTZS, FCVTZU */
         handle_simd_shift_fpint_conv(s, true, false, is_u, immh, immb, rn, rd);
         break;
     default:
         unallocated_encoding(s);
         break;
     }
 }
 
 /* AdvSIMD scalar three different
  *  31 30  29 28       24 23  22  21 20  16 15    12 11 10 9    5 4    0
  * +-----+---+-----------+------+---+------+--------+-----+------+------+
  * | 0 1 | U | 1 1 1 1 0 | size | 1 |  Rm  | opcode | 0 0 |  Rn  |  Rd  |
  * +-----+---+-----------+------+---+------+--------+-----+------+------+
  */
 static void disas_simd_scalar_three_reg_diff(DisasContext *s, uint32_t insn)
 {
     bool is_u = extract32(insn, 29, 1);
     int size = extract32(insn, 22, 2);
     int opcode = extract32(insn, 12, 4);
     int rm = extract32(insn, 16, 5);
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
 
     if (is_u) {
         unallocated_encoding(s);
         return;
     }
 
     switch (opcode) {
     case 0x9: /* SQDMLAL, SQDMLAL2 */
     case 0xb: /* SQDMLSL, SQDMLSL2 */
     case 0xd: /* SQDMULL, SQDMULL2 */
         if (size == 0 || size == 3) {
             unallocated_encoding(s);
             return;
         }
         break;
     default:
         unallocated_encoding(s);
         return;
     }
 
     if (!fp_access_check(s)) {
         return;
     }
 
     if (size == 2) {
         TCGv_i64 tcg_op1 = tcg_temp_new_i64();
         TCGv_i64 tcg_op2 = tcg_temp_new_i64();
         TCGv_i64 tcg_res = tcg_temp_new_i64();
 
         read_vec_element(s, tcg_op1, rn, 0, MO_32 | MO_SIGN);
         read_vec_element(s, tcg_op2, rm, 0, MO_32 | MO_SIGN);
 
         tcg_gen_mul_i64(tcg_res, tcg_op1, tcg_op2);
         gen_helper_neon_addl_saturate_s64(tcg_res, tcg_env, tcg_res, tcg_res);
 
         switch (opcode) {
         case 0xd: /* SQDMULL, SQDMULL2 */
             break;
         case 0xb: /* SQDMLSL, SQDMLSL2 */
             tcg_gen_neg_i64(tcg_res, tcg_res);
-            /* fall through */
+            fallthrough;
         case 0x9: /* SQDMLAL, SQDMLAL2 */
             read_vec_element(s, tcg_op1, rd, 0, MO_64);
             gen_helper_neon_addl_saturate_s64(tcg_res, tcg_env,
                                               tcg_res, tcg_op1);
             break;
         default:
             g_assert_not_reached();
         }
 
         write_fp_dreg(s, rd, tcg_res);
     } else {
         TCGv_i32 tcg_op1 = read_fp_hreg(s, rn);
         TCGv_i32 tcg_op2 = read_fp_hreg(s, rm);
         TCGv_i64 tcg_res = tcg_temp_new_i64();
 
         gen_helper_neon_mull_s16(tcg_res, tcg_op1, tcg_op2);
         gen_helper_neon_addl_saturate_s32(tcg_res, tcg_env, tcg_res, tcg_res);
 
         switch (opcode) {
         case 0xd: /* SQDMULL, SQDMULL2 */
             break;
         case 0xb: /* SQDMLSL, SQDMLSL2 */
             gen_helper_neon_negl_u32(tcg_res, tcg_res);
-            /* fall through */
+            fallthrough;
         case 0x9: /* SQDMLAL, SQDMLAL2 */
         {
             TCGv_i64 tcg_op3 = tcg_temp_new_i64();
             read_vec_element(s, tcg_op3, rd, 0, MO_32);
             gen_helper_neon_addl_saturate_s32(tcg_res, tcg_env,
                                               tcg_res, tcg_op3);
             break;
         }
         default:
             g_assert_not_reached();
         }
 
         tcg_gen_ext32u_i64(tcg_res, tcg_res);
         write_fp_dreg(s, rd, tcg_res);
     }
 }
@@ -8866,183 +8866,183 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
 /* Handle the 3-same-operands float operations; shared by the scalar
  * and vector encodings. The caller must filter out any encodings
  * not allocated for the encoding it is dealing with.
  */
 static void handle_3same_float(DisasContext *s, int size, int elements,
                                int fpopcode, int rd, int rn, int rm)
 {
     int pass;
     TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
 
     for (pass = 0; pass < elements; pass++) {
         if (size) {
             /* Double */
             TCGv_i64 tcg_op1 = tcg_temp_new_i64();
             TCGv_i64 tcg_op2 = tcg_temp_new_i64();
             TCGv_i64 tcg_res = tcg_temp_new_i64();
 
             read_vec_element(s, tcg_op1, rn, pass, MO_64);
             read_vec_element(s, tcg_op2, rm, pass, MO_64);
 
             switch (fpopcode) {
             case 0x39: /* FMLS */
                 /* As usual for ARM, separate negation for fused multiply-add */
                 gen_helper_vfp_negd(tcg_op1, tcg_op1);
-                /* fall through */
+                fallthrough;
             case 0x19: /* FMLA */
                 read_vec_element(s, tcg_res, rd, pass, MO_64);
                 gen_helper_vfp_muladdd(tcg_res, tcg_op1, tcg_op2,
                                        tcg_res, fpst);
                 break;
             case 0x18: /* FMAXNM */
                 gen_helper_vfp_maxnumd(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x1a: /* FADD */
                 gen_helper_vfp_addd(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x1b: /* FMULX */
                 gen_helper_vfp_mulxd(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x1c: /* FCMEQ */
                 gen_helper_neon_ceq_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x1e: /* FMAX */
                 gen_helper_vfp_maxd(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x1f: /* FRECPS */
                 gen_helper_recpsf_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x38: /* FMINNM */
                 gen_helper_vfp_minnumd(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x3a: /* FSUB */
                 gen_helper_vfp_subd(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x3e: /* FMIN */
                 gen_helper_vfp_mind(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x3f: /* FRSQRTS */
                 gen_helper_rsqrtsf_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x5b: /* FMUL */
                 gen_helper_vfp_muld(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x5c: /* FCMGE */
                 gen_helper_neon_cge_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x5d: /* FACGE */
                 gen_helper_neon_acge_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x5f: /* FDIV */
                 gen_helper_vfp_divd(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x7a: /* FABD */
                 gen_helper_vfp_subd(tcg_res, tcg_op1, tcg_op2, fpst);
                 gen_helper_vfp_absd(tcg_res, tcg_res);
                 break;
             case 0x7c: /* FCMGT */
                 gen_helper_neon_cgt_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x7d: /* FACGT */
                 gen_helper_neon_acgt_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             default:
                 g_assert_not_reached();
             }
 
             write_vec_element(s, tcg_res, rd, pass, MO_64);
         } else {
             /* Single */
             TCGv_i32 tcg_op1 = tcg_temp_new_i32();
             TCGv_i32 tcg_op2 = tcg_temp_new_i32();
             TCGv_i32 tcg_res = tcg_temp_new_i32();
 
             read_vec_element_i32(s, tcg_op1, rn, pass, MO_32);
             read_vec_element_i32(s, tcg_op2, rm, pass, MO_32);
 
             switch (fpopcode) {
             case 0x39: /* FMLS */
                 /* As usual for ARM, separate negation for fused multiply-add */
                 gen_helper_vfp_negs(tcg_op1, tcg_op1);
-                /* fall through */
+                fallthrough;
             case 0x19: /* FMLA */
                 read_vec_element_i32(s, tcg_res, rd, pass, MO_32);
                 gen_helper_vfp_muladds(tcg_res, tcg_op1, tcg_op2,
                                        tcg_res, fpst);
                 break;
             case 0x1a: /* FADD */
                 gen_helper_vfp_adds(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x1b: /* FMULX */
                 gen_helper_vfp_mulxs(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x1c: /* FCMEQ */
                 gen_helper_neon_ceq_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x1e: /* FMAX */
                 gen_helper_vfp_maxs(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x1f: /* FRECPS */
                 gen_helper_recpsf_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x18: /* FMAXNM */
                 gen_helper_vfp_maxnums(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x38: /* FMINNM */
                 gen_helper_vfp_minnums(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x3a: /* FSUB */
                 gen_helper_vfp_subs(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x3e: /* FMIN */
                 gen_helper_vfp_mins(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x3f: /* FRSQRTS */
                 gen_helper_rsqrtsf_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x5b: /* FMUL */
                 gen_helper_vfp_muls(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x5c: /* FCMGE */
                 gen_helper_neon_cge_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x5d: /* FACGE */
                 gen_helper_neon_acge_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x5f: /* FDIV */
                 gen_helper_vfp_divs(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x7a: /* FABD */
                 gen_helper_vfp_subs(tcg_res, tcg_op1, tcg_op2, fpst);
                 gen_helper_vfp_abss(tcg_res, tcg_res);
                 break;
             case 0x7c: /* FCMGT */
                 gen_helper_neon_cgt_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x7d: /* FACGT */
                 gen_helper_neon_acgt_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             default:
                 g_assert_not_reached();
             }
 
             if (elements == 1) {
                 /* scalar single so clear high part */
                 TCGv_i64 tcg_tmp = tcg_temp_new_i64();
 
                 tcg_gen_extu_i32_i64(tcg_tmp, tcg_res);
                 write_vec_element(s, tcg_tmp, rd, pass, MO_64);
             } else {
                 write_vec_element_i32(s, tcg_res, rd, pass, MO_32);
             }
         }
     }
 
     clear_vec_high(s, elements * (size ? 8 : 4) > 8, rd);
 }
 
 /* AdvSIMD scalar three same
  *  31 30  29 28       24 23  22  21 20  16 15    11  10 9    5 4    0
  * +-----+---+-----------+------+---+------+--------+---+------+------+
  * | 0 1 | U | 1 1 1 1 0 | size | 1 |  Rm  | opcode | 1 |  Rn  |  Rd  |
  * +-----+---+-----------+------+---+------+--------+---+------+------+
  */
@@ -9468,128 +9468,128 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
 static void handle_2misc_fcmp_zero(DisasContext *s, int opcode,
                                    bool is_scalar, bool is_u, bool is_q,
                                    int size, int rn, int rd)
 {
     bool is_double = (size == MO_64);
     TCGv_ptr fpst;
 
     if (!fp_access_check(s)) {
         return;
     }
 
     fpst = fpstatus_ptr(size == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
 
     if (is_double) {
         TCGv_i64 tcg_op = tcg_temp_new_i64();
         TCGv_i64 tcg_zero = tcg_constant_i64(0);
         TCGv_i64 tcg_res = tcg_temp_new_i64();
         NeonGenTwoDoubleOpFn *genfn;
         bool swap = false;
         int pass;
 
         switch (opcode) {
         case 0x2e: /* FCMLT (zero) */
             swap = true;
-            /* fallthrough */
+            fallthrough;
         case 0x2c: /* FCMGT (zero) */
             genfn = gen_helper_neon_cgt_f64;
             break;
         case 0x2d: /* FCMEQ (zero) */
             genfn = gen_helper_neon_ceq_f64;
             break;
         case 0x6d: /* FCMLE (zero) */
             swap = true;
-            /* fall through */
+            fallthrough;
         case 0x6c: /* FCMGE (zero) */
             genfn = gen_helper_neon_cge_f64;
             break;
         default:
             g_assert_not_reached();
         }
 
         for (pass = 0; pass < (is_scalar ? 1 : 2); pass++) {
             read_vec_element(s, tcg_op, rn, pass, MO_64);
             if (swap) {
                 genfn(tcg_res, tcg_zero, tcg_op, fpst);
             } else {
                 genfn(tcg_res, tcg_op, tcg_zero, fpst);
             }
             write_vec_element(s, tcg_res, rd, pass, MO_64);
         }
 
         clear_vec_high(s, !is_scalar, rd);
     } else {
         TCGv_i32 tcg_op = tcg_temp_new_i32();
         TCGv_i32 tcg_zero = tcg_constant_i32(0);
         TCGv_i32 tcg_res = tcg_temp_new_i32();
         NeonGenTwoSingleOpFn *genfn;
         bool swap = false;
         int pass, maxpasses;
 
         if (size == MO_16) {
             switch (opcode) {
             case 0x2e: /* FCMLT (zero) */
                 swap = true;
-                /* fall through */
+                fallthrough;
             case 0x2c: /* FCMGT (zero) */
                 genfn = gen_helper_advsimd_cgt_f16;
                 break;
             case 0x2d: /* FCMEQ (zero) */
                 genfn = gen_helper_advsimd_ceq_f16;
                 break;
             case 0x6d: /* FCMLE (zero) */
                 swap = true;
-                /* fall through */
+                fallthrough;
             case 0x6c: /* FCMGE (zero) */
                 genfn = gen_helper_advsimd_cge_f16;
                 break;
             default:
                 g_assert_not_reached();
             }
         } else {
             switch (opcode) {
             case 0x2e: /* FCMLT (zero) */
                 swap = true;
-                /* fall through */
+                fallthrough;
             case 0x2c: /* FCMGT (zero) */
                 genfn = gen_helper_neon_cgt_f32;
                 break;
             case 0x2d: /* FCMEQ (zero) */
                 genfn = gen_helper_neon_ceq_f32;
                 break;
             case 0x6d: /* FCMLE (zero) */
                 swap = true;
-                /* fall through */
+                fallthrough;
             case 0x6c: /* FCMGE (zero) */
                 genfn = gen_helper_neon_cge_f32;
                 break;
             default:
                 g_assert_not_reached();
             }
         }
 
         if (is_scalar) {
             maxpasses = 1;
         } else {
             int vector_size = 8 << is_q;
             maxpasses = vector_size >> size;
         }
 
         for (pass = 0; pass < maxpasses; pass++) {
             read_vec_element_i32(s, tcg_op, rn, pass, size);
             if (swap) {
                 genfn(tcg_res, tcg_zero, tcg_op, fpst);
             } else {
                 genfn(tcg_res, tcg_op, tcg_zero, fpst);
             }
             if (is_scalar) {
                 write_fp_sreg(s, rd, tcg_res);
             } else {
                 write_vec_element_i32(s, tcg_res, rd, pass, size);
             }
         }
 
         if (!is_scalar) {
             clear_vec_high(s, is_q, rd);
         }
     }
 }
@@ -9859,194 +9859,194 @@ static void handle_2misc_satacc(DisasContext *s, bool is_scalar, bool is_u,
 /* AdvSIMD scalar two reg misc
  *  31 30  29 28       24 23  22 21       17 16    12 11 10 9    5 4    0
  * +-----+---+-----------+------+-----------+--------+-----+------+------+
  * | 0 1 | U | 1 1 1 1 0 | size | 1 0 0 0 0 | opcode | 1 0 |  Rn  |  Rd  |
  * +-----+---+-----------+------+-----------+--------+-----+------+------+
  */
 static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
 {
     int rd = extract32(insn, 0, 5);
     int rn = extract32(insn, 5, 5);
     int opcode = extract32(insn, 12, 5);
     int size = extract32(insn, 22, 2);
     bool u = extract32(insn, 29, 1);
     bool is_fcvt = false;
     int rmode;
     TCGv_i32 tcg_rmode;
     TCGv_ptr tcg_fpstatus;
 
     switch (opcode) {
     case 0x3: /* USQADD / SUQADD*/
         if (!fp_access_check(s)) {
             return;
         }
         handle_2misc_satacc(s, true, u, false, size, rn, rd);
         return;
     case 0x7: /* SQABS / SQNEG */
         break;
     case 0xa: /* CMLT */
         if (u) {
             unallocated_encoding(s);
             return;
         }
-        /* fall through */
+        fallthrough;
     case 0x8: /* CMGT, CMGE */
     case 0x9: /* CMEQ, CMLE */
     case 0xb: /* ABS, NEG */
         if (size != 3) {
             unallocated_encoding(s);
             return;
         }
         break;
     case 0x12: /* SQXTUN */
         if (!u) {
             unallocated_encoding(s);
             return;
         }
-        /* fall through */
+        fallthrough;
     case 0x14: /* SQXTN, UQXTN */
         if (size == 3) {
             unallocated_encoding(s);
             return;
         }
         if (!fp_access_check(s)) {
             return;
         }
         handle_2misc_narrow(s, true, opcode, u, false, size, rn, rd);
         return;
     case 0xc ... 0xf:
     case 0x16 ... 0x1d:
     case 0x1f:
         /* Floating point: U, size[1] and opcode indicate operation;
          * size[0] indicates single or double precision.
          */
         opcode |= (extract32(size, 1, 1) << 5) | (u << 6);
         size = extract32(size, 0, 1) ? 3 : 2;
         switch (opcode) {
         case 0x2c: /* FCMGT (zero) */
         case 0x2d: /* FCMEQ (zero) */
         case 0x2e: /* FCMLT (zero) */
         case 0x6c: /* FCMGE (zero) */
         case 0x6d: /* FCMLE (zero) */
             handle_2misc_fcmp_zero(s, opcode, true, u, true, size, rn, rd);
             return;
         case 0x1d: /* SCVTF */
         case 0x5d: /* UCVTF */
         {
             bool is_signed = (opcode == 0x1d);
             if (!fp_access_check(s)) {
                 return;
             }
             handle_simd_intfp_conv(s, rd, rn, 1, is_signed, 0, size);
             return;
         }
         case 0x3d: /* FRECPE */
         case 0x3f: /* FRECPX */
         case 0x7d: /* FRSQRTE */
             if (!fp_access_check(s)) {
                 return;
             }
             handle_2misc_reciprocal(s, opcode, true, u, true, size, rn, rd);
             return;
         case 0x1a: /* FCVTNS */
         case 0x1b: /* FCVTMS */
         case 0x3a: /* FCVTPS */
         case 0x3b: /* FCVTZS */
         case 0x5a: /* FCVTNU */
         case 0x5b: /* FCVTMU */
         case 0x7a: /* FCVTPU */
         case 0x7b: /* FCVTZU */
             is_fcvt = true;
             rmode = extract32(opcode, 5, 1) | (extract32(opcode, 0, 1) << 1);
             break;
         case 0x1c: /* FCVTAS */
         case 0x5c: /* FCVTAU */
             /* TIEAWAY doesn't fit in the usual rounding mode encoding */
             is_fcvt = true;
             rmode = FPROUNDING_TIEAWAY;
             break;
         case 0x56: /* FCVTXN, FCVTXN2 */
             if (size == 2) {
                 unallocated_encoding(s);
                 return;
             }
             if (!fp_access_check(s)) {
                 return;
             }
             handle_2misc_narrow(s, true, opcode, u, false, size - 1, rn, rd);
             return;
         default:
             unallocated_encoding(s);
             return;
         }
         break;
     default:
         unallocated_encoding(s);
         return;
     }
 
     if (!fp_access_check(s)) {
         return;
     }
 
     if (is_fcvt) {
         tcg_fpstatus = fpstatus_ptr(FPST_FPCR);
         tcg_rmode = gen_set_rmode(rmode, tcg_fpstatus);
     } else {
         tcg_fpstatus = NULL;
         tcg_rmode = NULL;
     }
 
     if (size == 3) {
         TCGv_i64 tcg_rn = read_fp_dreg(s, rn);
         TCGv_i64 tcg_rd = tcg_temp_new_i64();
 
         handle_2misc_64(s, opcode, u, tcg_rd, tcg_rn, tcg_rmode, tcg_fpstatus);
         write_fp_dreg(s, rd, tcg_rd);
     } else {
         TCGv_i32 tcg_rn = tcg_temp_new_i32();
         TCGv_i32 tcg_rd = tcg_temp_new_i32();
 
         read_vec_element_i32(s, tcg_rn, rn, 0, size);
 
         switch (opcode) {
         case 0x7: /* SQABS, SQNEG */
         {
             NeonGenOneOpEnvFn *genfn;
             static NeonGenOneOpEnvFn * const fns[3][2] = {
                 { gen_helper_neon_qabs_s8, gen_helper_neon_qneg_s8 },
                 { gen_helper_neon_qabs_s16, gen_helper_neon_qneg_s16 },
                 { gen_helper_neon_qabs_s32, gen_helper_neon_qneg_s32 },
             };
             genfn = fns[size][u];
             genfn(tcg_rd, tcg_env, tcg_rn);
             break;
         }
         case 0x1a: /* FCVTNS */
         case 0x1b: /* FCVTMS */
         case 0x1c: /* FCVTAS */
         case 0x3a: /* FCVTPS */
         case 0x3b: /* FCVTZS */
             gen_helper_vfp_tosls(tcg_rd, tcg_rn, tcg_constant_i32(0),
                                  tcg_fpstatus);
             break;
         case 0x5a: /* FCVTNU */
         case 0x5b: /* FCVTMU */
         case 0x5c: /* FCVTAU */
         case 0x7a: /* FCVTPU */
         case 0x7b: /* FCVTZU */
             gen_helper_vfp_touls(tcg_rd, tcg_rn, tcg_constant_i32(0),
                                  tcg_fpstatus);
             break;
         default:
             g_assert_not_reached();
         }
 
         write_fp_sreg(s, rd, tcg_rd);
     }
 
     if (is_fcvt) {
         gen_restore_rmode(tcg_rmode, tcg_fpstatus);
     }
 }
 
 /* SSHR[RA]/USHR[RA] - Vector shift right (optional rounding/accumulate) */
@@ -10230,78 +10230,78 @@ static void handle_vec_simd_shrn(DisasContext *s, bool is_q,
 /* AdvSIMD shift by immediate
  *  31  30   29 28         23 22  19 18  16 15    11  10 9    5 4    0
  * +---+---+---+-------------+------+------+--------+---+------+------+
  * | 0 | Q | U | 0 1 1 1 1 0 | immh | immb | opcode | 1 |  Rn  |  Rd  |
  * +---+---+---+-------------+------+------+--------+---+------+------+
  */
 static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
 {
     int rd = extract32(insn, 0, 5);
     int rn = extract32(insn, 5, 5);
     int opcode = extract32(insn, 11, 5);
     int immb = extract32(insn, 16, 3);
     int immh = extract32(insn, 19, 4);
     bool is_u = extract32(insn, 29, 1);
     bool is_q = extract32(insn, 30, 1);
 
     /* data_proc_simd[] has sent immh == 0 to disas_simd_mod_imm. */
     assert(immh != 0);
 
     switch (opcode) {
     case 0x08: /* SRI */
         if (!is_u) {
             unallocated_encoding(s);
             return;
         }
-        /* fall through */
+        fallthrough;
     case 0x00: /* SSHR / USHR */
     case 0x02: /* SSRA / USRA (accumulate) */
     case 0x04: /* SRSHR / URSHR (rounding) */
     case 0x06: /* SRSRA / URSRA (accum + rounding) */
         handle_vec_simd_shri(s, is_q, is_u, immh, immb, opcode, rn, rd);
         break;
     case 0x0a: /* SHL / SLI */
         handle_vec_simd_shli(s, is_q, is_u, immh, immb, opcode, rn, rd);
         break;
     case 0x10: /* SHRN */
     case 0x11: /* RSHRN / SQRSHRUN */
         if (is_u) {
             handle_vec_simd_sqshrn(s, false, is_q, false, true, immh, immb,
                                    opcode, rn, rd);
         } else {
             handle_vec_simd_shrn(s, is_q, immh, immb, opcode, rn, rd);
         }
         break;
     case 0x12: /* SQSHRN / UQSHRN */
     case 0x13: /* SQRSHRN / UQRSHRN */
         handle_vec_simd_sqshrn(s, false, is_q, is_u, is_u, immh, immb,
                                opcode, rn, rd);
         break;
     case 0x14: /* SSHLL / USHLL */
         handle_vec_simd_wshli(s, is_q, is_u, immh, immb, opcode, rn, rd);
         break;
     case 0x1c: /* SCVTF / UCVTF */
         handle_simd_shift_intfp_conv(s, false, is_q, is_u, immh, immb,
                                      opcode, rn, rd);
         break;
     case 0xc: /* SQSHLU */
         if (!is_u) {
             unallocated_encoding(s);
             return;
         }
         handle_simd_qshl(s, false, is_q, false, true, immh, immb, rn, rd);
         break;
     case 0xe: /* SQSHL, UQSHL */
         handle_simd_qshl(s, false, is_q, is_u, is_u, immh, immb, rn, rd);
         break;
     case 0x1f: /* FCVTZS/ FCVTZU */
         handle_simd_shift_fpint_conv(s, false, is_q, is_u, immh, immb, rn, rd);
         return;
     default:
         unallocated_encoding(s);
         return;
     }
 }
 
 /* Generate code to do a "long" addition or subtraction, ie one done in
  * TCGv_i64 on vector lanes twice the width specified by size.
  */
@@ -10598,118 +10598,118 @@ static void handle_3rd_narrowing(DisasContext *s, int is_q, int is_u, int size,
 /* AdvSIMD three different
  *   31  30  29 28       24 23  22  21 20  16 15    12 11 10 9    5 4    0
  * +---+---+---+-----------+------+---+------+--------+-----+------+------+
  * | 0 | Q | U | 0 1 1 1 0 | size | 1 |  Rm  | opcode | 0 0 |  Rn  |  Rd  |
  * +---+---+---+-----------+------+---+------+--------+-----+------+------+
  */
 static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
 {
     /* Instructions in this group fall into three basic classes
      * (in each case with the operation working on each element in
      * the input vectors):
      * (1) widening 64 x 64 -> 128 (with possibly Vd as an extra
      *     128 bit input)
      * (2) wide 64 x 128 -> 128
      * (3) narrowing 128 x 128 -> 64
      * Here we do initial decode, catch unallocated cases and
      * dispatch to separate functions for each class.
      */
     int is_q = extract32(insn, 30, 1);
     int is_u = extract32(insn, 29, 1);
     int size = extract32(insn, 22, 2);
     int opcode = extract32(insn, 12, 4);
     int rm = extract32(insn, 16, 5);
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
 
     switch (opcode) {
     case 1: /* SADDW, SADDW2, UADDW, UADDW2 */
     case 3: /* SSUBW, SSUBW2, USUBW, USUBW2 */
         /* 64 x 128 -> 128 */
         if (size == 3) {
             unallocated_encoding(s);
             return;
         }
         if (!fp_access_check(s)) {
             return;
         }
         handle_3rd_wide(s, is_q, is_u, size, opcode, rd, rn, rm);
         break;
     case 4: /* ADDHN, ADDHN2, RADDHN, RADDHN2 */
     case 6: /* SUBHN, SUBHN2, RSUBHN, RSUBHN2 */
         /* 128 x 128 -> 64 */
         if (size == 3) {
             unallocated_encoding(s);
             return;
         }
         if (!fp_access_check(s)) {
             return;
         }
         handle_3rd_narrowing(s, is_q, is_u, size, opcode, rd, rn, rm);
         break;
     case 14: /* PMULL, PMULL2 */
         if (is_u) {
             unallocated_encoding(s);
             return;
         }
         switch (size) {
         case 0: /* PMULL.P8 */
             if (!fp_access_check(s)) {
                 return;
             }
             /* The Q field specifies lo/hi half input for this insn.  */
             gen_gvec_op3_ool(s, true, rd, rn, rm, is_q,
                              gen_helper_neon_pmull_h);
             break;
 
         case 3: /* PMULL.P64 */
             if (!dc_isar_feature(aa64_pmull, s)) {
                 unallocated_encoding(s);
                 return;
             }
             if (!fp_access_check(s)) {
                 return;
             }
             /* The Q field specifies lo/hi half input for this insn.  */
             gen_gvec_op3_ool(s, true, rd, rn, rm, is_q,
                              gen_helper_gvec_pmull_q);
             break;
 
         default:
             unallocated_encoding(s);
             break;
         }
         return;
     case 9: /* SQDMLAL, SQDMLAL2 */
     case 11: /* SQDMLSL, SQDMLSL2 */
     case 13: /* SQDMULL, SQDMULL2 */
         if (is_u || size == 0) {
             unallocated_encoding(s);
             return;
         }
-        /* fall through */
+        fallthrough;
     case 0: /* SADDL, SADDL2, UADDL, UADDL2 */
     case 2: /* SSUBL, SSUBL2, USUBL, USUBL2 */
     case 5: /* SABAL, SABAL2, UABAL, UABAL2 */
     case 7: /* SABDL, SABDL2, UABDL, UABDL2 */
     case 8: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
     case 10: /* SMLSL, SMLSL2, UMLSL, UMLSL2 */
     case 12: /* SMULL, SMULL2, UMULL, UMULL2 */
         /* 64 x 64 -> 128 */
         if (size == 3) {
             unallocated_encoding(s);
             return;
         }
         if (!fp_access_check(s)) {
             return;
         }
 
         handle_3rd_widening(s, is_q, is_u, size, opcode, rd, rn, rm);
         break;
     default:
         /* opcode 15 not allocated */
         unallocated_encoding(s);
         break;
     }
 }
 
 /* Logic op (opcode == 3) subgroup of C3.6.16. */
@@ -10993,260 +10993,260 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
 /* Integer op subgroup of C3.6.16. */
 static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
 {
     int is_q = extract32(insn, 30, 1);
     int u = extract32(insn, 29, 1);
     int size = extract32(insn, 22, 2);
     int opcode = extract32(insn, 11, 5);
     int rm = extract32(insn, 16, 5);
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
     int pass;
     TCGCond cond;
 
     switch (opcode) {
     case 0x13: /* MUL, PMUL */
         if (u && size != 0) {
             unallocated_encoding(s);
             return;
         }
-        /* fall through */
+        fallthrough;
     case 0x0: /* SHADD, UHADD */
     case 0x2: /* SRHADD, URHADD */
     case 0x4: /* SHSUB, UHSUB */
     case 0xc: /* SMAX, UMAX */
     case 0xd: /* SMIN, UMIN */
     case 0xe: /* SABD, UABD */
     case 0xf: /* SABA, UABA */
     case 0x12: /* MLA, MLS */
         if (size == 3) {
             unallocated_encoding(s);
             return;
         }
         break;
     case 0x16: /* SQDMULH, SQRDMULH */
         if (size == 0 || size == 3) {
             unallocated_encoding(s);
             return;
         }
         break;
     default:
         if (size == 3 && !is_q) {
             unallocated_encoding(s);
             return;
         }
         break;
     }
 
     if (!fp_access_check(s)) {
         return;
     }
 
     switch (opcode) {
     case 0x01: /* SQADD, UQADD */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uqadd_qc, size);
         } else {
             gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sqadd_qc, size);
         }
         return;
     case 0x05: /* SQSUB, UQSUB */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uqsub_qc, size);
         } else {
             gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sqsub_qc, size);
         }
         return;
     case 0x08: /* SSHL, USHL */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_ushl, size);
         } else {
             gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sshl, size);
         }
         return;
     case 0x0c: /* SMAX, UMAX */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
         } else {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_smax, size);
         }
         return;
     case 0x0d: /* SMIN, UMIN */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umin, size);
         } else {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_smin, size);
         }
         return;
     case 0xe: /* SABD, UABD */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uabd, size);
         } else {
             gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sabd, size);
         }
         return;
     case 0xf: /* SABA, UABA */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uaba, size);
         } else {
             gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_saba, size);
         }
         return;
     case 0x10: /* ADD, SUB */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_sub, size);
         } else {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_add, size);
         }
         return;
     case 0x13: /* MUL, PMUL */
         if (!u) { /* MUL */
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_mul, size);
         } else {  /* PMUL */
             gen_gvec_op3_ool(s, is_q, rd, rn, rm, 0, gen_helper_gvec_pmul_b);
         }
         return;
     case 0x12: /* MLA, MLS */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_mls, size);
         } else {
             gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_mla, size);
         }
         return;
     case 0x16: /* SQDMULH, SQRDMULH */
         {
             static gen_helper_gvec_3_ptr * const fns[2][2] = {
                 { gen_helper_neon_sqdmulh_h, gen_helper_neon_sqrdmulh_h },
                 { gen_helper_neon_sqdmulh_s, gen_helper_neon_sqrdmulh_s },
             };
             gen_gvec_op3_qc(s, is_q, rd, rn, rm, fns[size - 1][u]);
         }
         return;
     case 0x11:
         if (!u) { /* CMTST */
             gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_cmtst, size);
             return;
         }
         /* else CMEQ */
         cond = TCG_COND_EQ;
         goto do_gvec_cmp;
     case 0x06: /* CMGT, CMHI */
         cond = u ? TCG_COND_GTU : TCG_COND_GT;
         goto do_gvec_cmp;
     case 0x07: /* CMGE, CMHS */
         cond = u ? TCG_COND_GEU : TCG_COND_GE;
     do_gvec_cmp:
         tcg_gen_gvec_cmp(cond, size, vec_full_reg_offset(s, rd),
                          vec_full_reg_offset(s, rn),
                          vec_full_reg_offset(s, rm),
                          is_q ? 16 : 8, vec_full_reg_size(s));
         return;
     }
 
     if (size == 3) {
         assert(is_q);
         for (pass = 0; pass < 2; pass++) {
             TCGv_i64 tcg_op1 = tcg_temp_new_i64();
             TCGv_i64 tcg_op2 = tcg_temp_new_i64();
             TCGv_i64 tcg_res = tcg_temp_new_i64();
 
             read_vec_element(s, tcg_op1, rn, pass, MO_64);
             read_vec_element(s, tcg_op2, rm, pass, MO_64);
 
             handle_3same_64(s, opcode, u, tcg_res, tcg_op1, tcg_op2);
 
             write_vec_element(s, tcg_res, rd, pass, MO_64);
         }
     } else {
         for (pass = 0; pass < (is_q ? 4 : 2); pass++) {
             TCGv_i32 tcg_op1 = tcg_temp_new_i32();
             TCGv_i32 tcg_op2 = tcg_temp_new_i32();
             TCGv_i32 tcg_res = tcg_temp_new_i32();
             NeonGenTwoOpFn *genfn = NULL;
             NeonGenTwoOpEnvFn *genenvfn = NULL;
 
             read_vec_element_i32(s, tcg_op1, rn, pass, MO_32);
             read_vec_element_i32(s, tcg_op2, rm, pass, MO_32);
 
             switch (opcode) {
             case 0x0: /* SHADD, UHADD */
             {
                 static NeonGenTwoOpFn * const fns[3][2] = {
                     { gen_helper_neon_hadd_s8, gen_helper_neon_hadd_u8 },
                     { gen_helper_neon_hadd_s16, gen_helper_neon_hadd_u16 },
                     { gen_helper_neon_hadd_s32, gen_helper_neon_hadd_u32 },
                 };
                 genfn = fns[size][u];
                 break;
             }
             case 0x2: /* SRHADD, URHADD */
             {
                 static NeonGenTwoOpFn * const fns[3][2] = {
                     { gen_helper_neon_rhadd_s8, gen_helper_neon_rhadd_u8 },
                     { gen_helper_neon_rhadd_s16, gen_helper_neon_rhadd_u16 },
                     { gen_helper_neon_rhadd_s32, gen_helper_neon_rhadd_u32 },
                 };
                 genfn = fns[size][u];
                 break;
             }
             case 0x4: /* SHSUB, UHSUB */
             {
                 static NeonGenTwoOpFn * const fns[3][2] = {
                     { gen_helper_neon_hsub_s8, gen_helper_neon_hsub_u8 },
                     { gen_helper_neon_hsub_s16, gen_helper_neon_hsub_u16 },
                     { gen_helper_neon_hsub_s32, gen_helper_neon_hsub_u32 },
                 };
                 genfn = fns[size][u];
                 break;
             }
             case 0x9: /* SQSHL, UQSHL */
             {
                 static NeonGenTwoOpEnvFn * const fns[3][2] = {
                     { gen_helper_neon_qshl_s8, gen_helper_neon_qshl_u8 },
                     { gen_helper_neon_qshl_s16, gen_helper_neon_qshl_u16 },
                     { gen_helper_neon_qshl_s32, gen_helper_neon_qshl_u32 },
                 };
                 genenvfn = fns[size][u];
                 break;
             }
             case 0xa: /* SRSHL, URSHL */
             {
                 static NeonGenTwoOpFn * const fns[3][2] = {
                     { gen_helper_neon_rshl_s8, gen_helper_neon_rshl_u8 },
                     { gen_helper_neon_rshl_s16, gen_helper_neon_rshl_u16 },
                     { gen_helper_neon_rshl_s32, gen_helper_neon_rshl_u32 },
                 };
                 genfn = fns[size][u];
                 break;
             }
             case 0xb: /* SQRSHL, UQRSHL */
             {
                 static NeonGenTwoOpEnvFn * const fns[3][2] = {
                     { gen_helper_neon_qrshl_s8, gen_helper_neon_qrshl_u8 },
                     { gen_helper_neon_qrshl_s16, gen_helper_neon_qrshl_u16 },
                     { gen_helper_neon_qrshl_s32, gen_helper_neon_qrshl_u32 },
                 };
                 genenvfn = fns[size][u];
                 break;
             }
             default:
                 g_assert_not_reached();
             }
 
             if (genenvfn) {
                 genenvfn(tcg_res, tcg_env, tcg_op1, tcg_op2);
             } else {
                 genfn(tcg_res, tcg_op1, tcg_op2);
             }
 
             write_vec_element_i32(s, tcg_res, rd, pass, MO_32);
         }
     }
     clear_vec_high(s, is_q, rd);
 }
 
 /* AdvSIMD three same
  *  31  30  29  28       24 23  22  21 20  16 15    11  10 9    5 4    0
  * +---+---+---+-----------+------+---+------+--------+---+------+------+
  * | 0 | Q | U | 0 1 1 1 0 | size | 1 |  Rm  | opcode | 1 |  Rn  |  Rd  |
  * +---+---+---+-----------+------+---+------+--------+---+------+------+
  */
@@ -11894,489 +11894,489 @@ static void handle_shll(DisasContext *s, bool is_q, int size, int rn, int rd)
 /* AdvSIMD two reg misc
  *   31  30  29 28       24 23  22 21       17 16    12 11 10 9    5 4    0
  * +---+---+---+-----------+------+-----------+--------+-----+------+------+
  * | 0 | Q | U | 0 1 1 1 0 | size | 1 0 0 0 0 | opcode | 1 0 |  Rn  |  Rd  |
  * +---+---+---+-----------+------+-----------+--------+-----+------+------+
  */
 static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
 {
     int size = extract32(insn, 22, 2);
     int opcode = extract32(insn, 12, 5);
     bool u = extract32(insn, 29, 1);
     bool is_q = extract32(insn, 30, 1);
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
     bool need_fpstatus = false;
     int rmode = -1;
     TCGv_i32 tcg_rmode;
     TCGv_ptr tcg_fpstatus;
 
     switch (opcode) {
     case 0x0: /* REV64, REV32 */
     case 0x1: /* REV16 */
         handle_rev(s, opcode, u, is_q, size, rn, rd);
         return;
     case 0x5: /* CNT, NOT, RBIT */
         if (u && size == 0) {
             /* NOT */
             break;
         } else if (u && size == 1) {
             /* RBIT */
             break;
         } else if (!u && size == 0) {
             /* CNT */
             break;
         }
         unallocated_encoding(s);
         return;
     case 0x12: /* XTN, XTN2, SQXTUN, SQXTUN2 */
     case 0x14: /* SQXTN, SQXTN2, UQXTN, UQXTN2 */
         if (size == 3) {
             unallocated_encoding(s);
             return;
         }
         if (!fp_access_check(s)) {
             return;
         }
 
         handle_2misc_narrow(s, false, opcode, u, is_q, size, rn, rd);
         return;
     case 0x4: /* CLS, CLZ */
         if (size == 3) {
             unallocated_encoding(s);
             return;
         }
         break;
     case 0x2: /* SADDLP, UADDLP */
     case 0x6: /* SADALP, UADALP */
         if (size == 3) {
             unallocated_encoding(s);
             return;
         }
         if (!fp_access_check(s)) {
             return;
         }
         handle_2misc_pairwise(s, opcode, u, is_q, size, rn, rd);
         return;
     case 0x13: /* SHLL, SHLL2 */
         if (u == 0 || size == 3) {
             unallocated_encoding(s);
             return;
         }
         if (!fp_access_check(s)) {
             return;
         }
         handle_shll(s, is_q, size, rn, rd);
         return;
     case 0xa: /* CMLT */
         if (u == 1) {
             unallocated_encoding(s);
             return;
         }
-        /* fall through */
+        fallthrough;
     case 0x8: /* CMGT, CMGE */
     case 0x9: /* CMEQ, CMLE */
     case 0xb: /* ABS, NEG */
         if (size == 3 && !is_q) {
             unallocated_encoding(s);
             return;
         }
         break;
     case 0x3: /* SUQADD, USQADD */
         if (size == 3 && !is_q) {
             unallocated_encoding(s);
             return;
         }
         if (!fp_access_check(s)) {
             return;
         }
         handle_2misc_satacc(s, false, u, is_q, size, rn, rd);
         return;
     case 0x7: /* SQABS, SQNEG */
         if (size == 3 && !is_q) {
             unallocated_encoding(s);
             return;
         }
         break;
     case 0xc ... 0xf:
     case 0x16 ... 0x1f:
     {
         /* Floating point: U, size[1] and opcode indicate operation;
          * size[0] indicates single or double precision.
          */
         int is_double = extract32(size, 0, 1);
         opcode |= (extract32(size, 1, 1) << 5) | (u << 6);
         size = is_double ? 3 : 2;
         switch (opcode) {
         case 0x2f: /* FABS */
         case 0x6f: /* FNEG */
             if (size == 3 && !is_q) {
                 unallocated_encoding(s);
                 return;
             }
             break;
         case 0x1d: /* SCVTF */
         case 0x5d: /* UCVTF */
         {
             bool is_signed = (opcode == 0x1d) ? true : false;
             int elements = is_double ? 2 : is_q ? 4 : 2;
             if (is_double && !is_q) {
                 unallocated_encoding(s);
                 return;
             }
             if (!fp_access_check(s)) {
                 return;
             }
             handle_simd_intfp_conv(s, rd, rn, elements, is_signed, 0, size);
             return;
         }
         case 0x2c: /* FCMGT (zero) */
         case 0x2d: /* FCMEQ (zero) */
         case 0x2e: /* FCMLT (zero) */
         case 0x6c: /* FCMGE (zero) */
         case 0x6d: /* FCMLE (zero) */
             if (size == 3 && !is_q) {
                 unallocated_encoding(s);
                 return;
             }
             handle_2misc_fcmp_zero(s, opcode, false, u, is_q, size, rn, rd);
             return;
         case 0x7f: /* FSQRT */
             if (size == 3 && !is_q) {
                 unallocated_encoding(s);
                 return;
             }
             break;
         case 0x1a: /* FCVTNS */
         case 0x1b: /* FCVTMS */
         case 0x3a: /* FCVTPS */
         case 0x3b: /* FCVTZS */
         case 0x5a: /* FCVTNU */
         case 0x5b: /* FCVTMU */
         case 0x7a: /* FCVTPU */
         case 0x7b: /* FCVTZU */
             need_fpstatus = true;
             rmode = extract32(opcode, 5, 1) | (extract32(opcode, 0, 1) << 1);
             if (size == 3 && !is_q) {
                 unallocated_encoding(s);
                 return;
             }
             break;
         case 0x5c: /* FCVTAU */
         case 0x1c: /* FCVTAS */
             need_fpstatus = true;
             rmode = FPROUNDING_TIEAWAY;
             if (size == 3 && !is_q) {
                 unallocated_encoding(s);
                 return;
             }
             break;
         case 0x3c: /* URECPE */
             if (size == 3) {
                 unallocated_encoding(s);
                 return;
             }
-            /* fall through */
+            fallthrough;
         case 0x3d: /* FRECPE */
         case 0x7d: /* FRSQRTE */
             if (size == 3 && !is_q) {
                 unallocated_encoding(s);
                 return;
             }
             if (!fp_access_check(s)) {
                 return;
             }
             handle_2misc_reciprocal(s, opcode, false, u, is_q, size, rn, rd);
             return;
         case 0x56: /* FCVTXN, FCVTXN2 */
             if (size == 2) {
                 unallocated_encoding(s);
                 return;
             }
-            /* fall through */
+            fallthrough;
         case 0x16: /* FCVTN, FCVTN2 */
             /* handle_2misc_narrow does a 2*size -> size operation, but these
              * instructions encode the source size rather than dest size.
              */
             if (!fp_access_check(s)) {
                 return;
             }
             handle_2misc_narrow(s, false, opcode, 0, is_q, size - 1, rn, rd);
             return;
         case 0x36: /* BFCVTN, BFCVTN2 */
             if (!dc_isar_feature(aa64_bf16, s) || size != 2) {
                 unallocated_encoding(s);
                 return;
             }
             if (!fp_access_check(s)) {
                 return;
             }
             handle_2misc_narrow(s, false, opcode, 0, is_q, size - 1, rn, rd);
             return;
         case 0x17: /* FCVTL, FCVTL2 */
             if (!fp_access_check(s)) {
                 return;
             }
             handle_2misc_widening(s, opcode, is_q, size, rn, rd);
             return;
         case 0x18: /* FRINTN */
         case 0x19: /* FRINTM */
         case 0x38: /* FRINTP */
         case 0x39: /* FRINTZ */
             rmode = extract32(opcode, 5, 1) | (extract32(opcode, 0, 1) << 1);
-            /* fall through */
+            fallthrough;
         case 0x59: /* FRINTX */
         case 0x79: /* FRINTI */
             need_fpstatus = true;
             if (size == 3 && !is_q) {
                 unallocated_encoding(s);
                 return;
             }
             break;
         case 0x58: /* FRINTA */
             rmode = FPROUNDING_TIEAWAY;
             need_fpstatus = true;
             if (size == 3 && !is_q) {
                 unallocated_encoding(s);
                 return;
             }
             break;
         case 0x7c: /* URSQRTE */
             if (size == 3) {
                 unallocated_encoding(s);
                 return;
             }
             break;
         case 0x1e: /* FRINT32Z */
         case 0x1f: /* FRINT64Z */
             rmode = FPROUNDING_ZERO;
-            /* fall through */
+            fallthrough;
         case 0x5e: /* FRINT32X */
         case 0x5f: /* FRINT64X */
             need_fpstatus = true;
             if ((size == 3 && !is_q) || !dc_isar_feature(aa64_frint, s)) {
                 unallocated_encoding(s);
                 return;
             }
             break;
         default:
             unallocated_encoding(s);
             return;
         }
         break;
     }
     default:
         unallocated_encoding(s);
         return;
     }
 
     if (!fp_access_check(s)) {
         return;
     }
 
     if (need_fpstatus || rmode >= 0) {
         tcg_fpstatus = fpstatus_ptr(FPST_FPCR);
     } else {
         tcg_fpstatus = NULL;
     }
     if (rmode >= 0) {
         tcg_rmode = gen_set_rmode(rmode, tcg_fpstatus);
     } else {
         tcg_rmode = NULL;
     }
 
     switch (opcode) {
     case 0x5:
         if (u && size == 0) { /* NOT */
             gen_gvec_fn2(s, is_q, rd, rn, tcg_gen_gvec_not, 0);
             return;
         }
         break;
     case 0x8: /* CMGT, CMGE */
         if (u) {
             gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_cge0, size);
         } else {
             gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_cgt0, size);
         }
         return;
     case 0x9: /* CMEQ, CMLE */
         if (u) {
             gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_cle0, size);
         } else {
             gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_ceq0, size);
         }
         return;
     case 0xa: /* CMLT */
         gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_clt0, size);
         return;
     case 0xb:
         if (u) { /* ABS, NEG */
             gen_gvec_fn2(s, is_q, rd, rn, tcg_gen_gvec_neg, size);
         } else {
             gen_gvec_fn2(s, is_q, rd, rn, tcg_gen_gvec_abs, size);
         }
         return;
     }
 
     if (size == 3) {
         /* All 64-bit element operations can be shared with scalar 2misc */
         int pass;
 
         /* Coverity claims (size == 3 && !is_q) has been eliminated
          * from all paths leading to here.
          */
         tcg_debug_assert(is_q);
         for (pass = 0; pass < 2; pass++) {
             TCGv_i64 tcg_op = tcg_temp_new_i64();
             TCGv_i64 tcg_res = tcg_temp_new_i64();
 
             read_vec_element(s, tcg_op, rn, pass, MO_64);
 
             handle_2misc_64(s, opcode, u, tcg_res, tcg_op,
                             tcg_rmode, tcg_fpstatus);
 
             write_vec_element(s, tcg_res, rd, pass, MO_64);
         }
     } else {
         int pass;
 
         for (pass = 0; pass < (is_q ? 4 : 2); pass++) {
             TCGv_i32 tcg_op = tcg_temp_new_i32();
             TCGv_i32 tcg_res = tcg_temp_new_i32();
 
             read_vec_element_i32(s, tcg_op, rn, pass, MO_32);
 
             if (size == 2) {
                 /* Special cases for 32 bit elements */
                 switch (opcode) {
                 case 0x4: /* CLS */
                     if (u) {
                         tcg_gen_clzi_i32(tcg_res, tcg_op, 32);
                     } else {
                         tcg_gen_clrsb_i32(tcg_res, tcg_op);
                     }
                     break;
                 case 0x7: /* SQABS, SQNEG */
                     if (u) {
                         gen_helper_neon_qneg_s32(tcg_res, tcg_env, tcg_op);
                     } else {
                         gen_helper_neon_qabs_s32(tcg_res, tcg_env, tcg_op);
                     }
                     break;
                 case 0x2f: /* FABS */
                     gen_helper_vfp_abss(tcg_res, tcg_op);
                     break;
                 case 0x6f: /* FNEG */
                     gen_helper_vfp_negs(tcg_res, tcg_op);
                     break;
                 case 0x7f: /* FSQRT */
                     gen_helper_vfp_sqrts(tcg_res, tcg_op, tcg_env);
                     break;
                 case 0x1a: /* FCVTNS */
                 case 0x1b: /* FCVTMS */
                 case 0x1c: /* FCVTAS */
                 case 0x3a: /* FCVTPS */
                 case 0x3b: /* FCVTZS */
                     gen_helper_vfp_tosls(tcg_res, tcg_op,
                                          tcg_constant_i32(0), tcg_fpstatus);
                     break;
                 case 0x5a: /* FCVTNU */
                 case 0x5b: /* FCVTMU */
                 case 0x5c: /* FCVTAU */
                 case 0x7a: /* FCVTPU */
                 case 0x7b: /* FCVTZU */
                     gen_helper_vfp_touls(tcg_res, tcg_op,
                                          tcg_constant_i32(0), tcg_fpstatus);
                     break;
                 case 0x18: /* FRINTN */
                 case 0x19: /* FRINTM */
                 case 0x38: /* FRINTP */
                 case 0x39: /* FRINTZ */
                 case 0x58: /* FRINTA */
                 case 0x79: /* FRINTI */
                     gen_helper_rints(tcg_res, tcg_op, tcg_fpstatus);
                     break;
                 case 0x59: /* FRINTX */
                     gen_helper_rints_exact(tcg_res, tcg_op, tcg_fpstatus);
                     break;
                 case 0x7c: /* URSQRTE */
                     gen_helper_rsqrte_u32(tcg_res, tcg_op);
                     break;
                 case 0x1e: /* FRINT32Z */
                 case 0x5e: /* FRINT32X */
                     gen_helper_frint32_s(tcg_res, tcg_op, tcg_fpstatus);
                     break;
                 case 0x1f: /* FRINT64Z */
                 case 0x5f: /* FRINT64X */
                     gen_helper_frint64_s(tcg_res, tcg_op, tcg_fpstatus);
                     break;
                 default:
                     g_assert_not_reached();
                 }
             } else {
                 /* Use helpers for 8 and 16 bit elements */
                 switch (opcode) {
                 case 0x5: /* CNT, RBIT */
                     /* For these two insns size is part of the opcode specifier
                      * (handled earlier); they always operate on byte elements.
                      */
                     if (u) {
                         gen_helper_neon_rbit_u8(tcg_res, tcg_op);
                     } else {
                         gen_helper_neon_cnt_u8(tcg_res, tcg_op);
                     }
                     break;
                 case 0x7: /* SQABS, SQNEG */
                 {
                     NeonGenOneOpEnvFn *genfn;
                     static NeonGenOneOpEnvFn * const fns[2][2] = {
                         { gen_helper_neon_qabs_s8, gen_helper_neon_qneg_s8 },
                         { gen_helper_neon_qabs_s16, gen_helper_neon_qneg_s16 },
                     };
                     genfn = fns[size][u];
                     genfn(tcg_res, tcg_env, tcg_op);
                     break;
                 }
                 case 0x4: /* CLS, CLZ */
                     if (u) {
                         if (size == 0) {
                             gen_helper_neon_clz_u8(tcg_res, tcg_op);
                         } else {
                             gen_helper_neon_clz_u16(tcg_res, tcg_op);
                         }
                     } else {
                         if (size == 0) {
                             gen_helper_neon_cls_s8(tcg_res, tcg_op);
                         } else {
                             gen_helper_neon_cls_s16(tcg_res, tcg_op);
                         }
                     }
                     break;
                 default:
                     g_assert_not_reached();
                 }
             }
 
             write_vec_element_i32(s, tcg_res, rd, pass, MO_32);
         }
     }
     clear_vec_high(s, is_q, rd);
 
     if (tcg_rmode) {
         gen_restore_rmode(tcg_rmode, tcg_fpstatus);
     }
 }
 
 /* AdvSIMD [scalar] two register miscellaneous (FP16)
  *
  *   31  30  29 28  27     24  23 22 21       17 16    12 11 10 9    5 4    0
  * +---+---+---+---+---------+---+-------------+--------+-----+------+------+
  * | 0 | Q | U | S | 1 1 1 0 | a | 1 1 1 1 0 0 | opcode | 1 0 |  Rn  |  Rd  |
  * +---+---+---+---+---------+---+-------------+--------+-----+------+------+
  *   mask: 1000 1111 0111 1110 0000 1100 0000 0000 0x8f7e 0c00
  *   val:  0000 1110 0111 1000 0000 1000 0000 0000 0x0e78 0800
  *
  * This actually covers two groups where scalar access is governed by
  * bit 28. A bunch of the instructions (float to integral) only exist
  * in the vector form and are un-allocated for the scalar decode. Also
  * in the scalar decode Q is always 1.
  */
@@ -12637,716 +12637,716 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
 /* AdvSIMD scalar x indexed element
  *  31 30  29 28       24 23  22 21  20  19  16 15 12  11  10 9    5 4    0
  * +-----+---+-----------+------+---+---+------+-----+---+---+------+------+
  * | 0 1 | U | 1 1 1 1 1 | size | L | M |  Rm  | opc | H | 0 |  Rn  |  Rd  |
  * +-----+---+-----------+------+---+---+------+-----+---+---+------+------+
  * AdvSIMD vector x indexed element
  *   31  30  29 28       24 23  22 21  20  19  16 15 12  11  10 9    5 4    0
  * +---+---+---+-----------+------+---+---+------+-----+---+---+------+------+
  * | 0 | Q | U | 0 1 1 1 1 | size | L | M |  Rm  | opc | H | 0 |  Rn  |  Rd  |
  * +---+---+---+-----------+------+---+---+------+-----+---+---+------+------+
  */
 static void disas_simd_indexed(DisasContext *s, uint32_t insn)
 {
     /* This encoding has two kinds of instruction:
      *  normal, where we perform elt x idxelt => elt for each
      *     element in the vector
      *  long, where we perform elt x idxelt and generate a result of
      *     double the width of the input element
      * The long ops have a 'part' specifier (ie come in INSN, INSN2 pairs).
      */
     bool is_scalar = extract32(insn, 28, 1);
     bool is_q = extract32(insn, 30, 1);
     bool u = extract32(insn, 29, 1);
     int size = extract32(insn, 22, 2);
     int l = extract32(insn, 21, 1);
     int m = extract32(insn, 20, 1);
     /* Note that the Rm field here is only 4 bits, not 5 as it usually is */
     int rm = extract32(insn, 16, 4);
     int opcode = extract32(insn, 12, 4);
     int h = extract32(insn, 11, 1);
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
     bool is_long = false;
     int is_fp = 0;
     bool is_fp16 = false;
     int index;
     TCGv_ptr fpst;
 
     switch (16 * u + opcode) {
     case 0x08: /* MUL */
     case 0x10: /* MLA */
     case 0x14: /* MLS */
         if (is_scalar) {
             unallocated_encoding(s);
             return;
         }
         break;
     case 0x02: /* SMLAL, SMLAL2 */
     case 0x12: /* UMLAL, UMLAL2 */
     case 0x06: /* SMLSL, SMLSL2 */
     case 0x16: /* UMLSL, UMLSL2 */
     case 0x0a: /* SMULL, SMULL2 */
     case 0x1a: /* UMULL, UMULL2 */
         if (is_scalar) {
             unallocated_encoding(s);
             return;
         }
         is_long = true;
         break;
     case 0x03: /* SQDMLAL, SQDMLAL2 */
     case 0x07: /* SQDMLSL, SQDMLSL2 */
     case 0x0b: /* SQDMULL, SQDMULL2 */
         is_long = true;
         break;
     case 0x0c: /* SQDMULH */
     case 0x0d: /* SQRDMULH */
         break;
     case 0x01: /* FMLA */
     case 0x05: /* FMLS */
     case 0x09: /* FMUL */
     case 0x19: /* FMULX */
         is_fp = 1;
         break;
     case 0x1d: /* SQRDMLAH */
     case 0x1f: /* SQRDMLSH */
         if (!dc_isar_feature(aa64_rdm, s)) {
             unallocated_encoding(s);
             return;
         }
         break;
     case 0x0e: /* SDOT */
     case 0x1e: /* UDOT */
         if (is_scalar || size != MO_32 || !dc_isar_feature(aa64_dp, s)) {
             unallocated_encoding(s);
             return;
         }
         break;
     case 0x0f:
         switch (size) {
         case 0: /* SUDOT */
         case 2: /* USDOT */
             if (is_scalar || !dc_isar_feature(aa64_i8mm, s)) {
                 unallocated_encoding(s);
                 return;
             }
             size = MO_32;
             break;
         case 1: /* BFDOT */
             if (is_scalar || !dc_isar_feature(aa64_bf16, s)) {
                 unallocated_encoding(s);
                 return;
             }
             size = MO_32;
             break;
         case 3: /* BFMLAL{B,T} */
             if (is_scalar || !dc_isar_feature(aa64_bf16, s)) {
                 unallocated_encoding(s);
                 return;
             }
             /* can't set is_fp without other incorrect size checks */
             size = MO_16;
             break;
         default:
             unallocated_encoding(s);
             return;
         }
         break;
     case 0x11: /* FCMLA #0 */
     case 0x13: /* FCMLA #90 */
     case 0x15: /* FCMLA #180 */
     case 0x17: /* FCMLA #270 */
         if (is_scalar || !dc_isar_feature(aa64_fcma, s)) {
             unallocated_encoding(s);
             return;
         }
         is_fp = 2;
         break;
     case 0x00: /* FMLAL */
     case 0x04: /* FMLSL */
     case 0x18: /* FMLAL2 */
     case 0x1c: /* FMLSL2 */
         if (is_scalar || size != MO_32 || !dc_isar_feature(aa64_fhm, s)) {
             unallocated_encoding(s);
             return;
         }
         size = MO_16;
         /* is_fp, but we pass tcg_env not fp_status.  */
         break;
     default:
         unallocated_encoding(s);
         return;
     }
 
     switch (is_fp) {
     case 1: /* normal fp */
         /* convert insn encoded size to MemOp size */
         switch (size) {
         case 0: /* half-precision */
             size = MO_16;
             is_fp16 = true;
             break;
         case MO_32: /* single precision */
         case MO_64: /* double precision */
             break;
         default:
             unallocated_encoding(s);
             return;
         }
         break;
 
     case 2: /* complex fp */
         /* Each indexable element is a complex pair.  */
         size += 1;
         switch (size) {
         case MO_32:
             if (h && !is_q) {
                 unallocated_encoding(s);
                 return;
             }
             is_fp16 = true;
             break;
         case MO_64:
             break;
         default:
             unallocated_encoding(s);
             return;
         }
         break;
 
     default: /* integer */
         switch (size) {
         case MO_8:
         case MO_64:
             unallocated_encoding(s);
             return;
         }
         break;
     }
     if (is_fp16 && !dc_isar_feature(aa64_fp16, s)) {
         unallocated_encoding(s);
         return;
     }
 
     /* Given MemOp size, adjust register and indexing.  */
     switch (size) {
     case MO_16:
         index = h << 2 | l << 1 | m;
         break;
     case MO_32:
         index = h << 1 | l;
         rm |= m << 4;
         break;
     case MO_64:
         if (l || !is_q) {
             unallocated_encoding(s);
             return;
         }
         index = h;
         rm |= m << 4;
         break;
     default:
         g_assert_not_reached();
     }
 
     if (!fp_access_check(s)) {
         return;
     }
 
     if (is_fp) {
         fpst = fpstatus_ptr(is_fp16 ? FPST_FPCR_F16 : FPST_FPCR);
     } else {
         fpst = NULL;
     }
 
     switch (16 * u + opcode) {
     case 0x0e: /* SDOT */
     case 0x1e: /* UDOT */
         gen_gvec_op4_ool(s, is_q, rd, rn, rm, rd, index,
                          u ? gen_helper_gvec_udot_idx_b
                          : gen_helper_gvec_sdot_idx_b);
         return;
     case 0x0f:
         switch (extract32(insn, 22, 2)) {
         case 0: /* SUDOT */
             gen_gvec_op4_ool(s, is_q, rd, rn, rm, rd, index,
                              gen_helper_gvec_sudot_idx_b);
             return;
         case 1: /* BFDOT */
             gen_gvec_op4_ool(s, is_q, rd, rn, rm, rd, index,
                              gen_helper_gvec_bfdot_idx);
             return;
         case 2: /* USDOT */
             gen_gvec_op4_ool(s, is_q, rd, rn, rm, rd, index,
                              gen_helper_gvec_usdot_idx_b);
             return;
         case 3: /* BFMLAL{B,T} */
             gen_gvec_op4_fpst(s, 1, rd, rn, rm, rd, 0, (index << 1) | is_q,
                               gen_helper_gvec_bfmlal_idx);
             return;
         }
         g_assert_not_reached();
     case 0x11: /* FCMLA #0 */
     case 0x13: /* FCMLA #90 */
     case 0x15: /* FCMLA #180 */
     case 0x17: /* FCMLA #270 */
         {
             int rot = extract32(insn, 13, 2);
             int data = (index << 2) | rot;
             tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, rd),
                                vec_full_reg_offset(s, rn),
                                vec_full_reg_offset(s, rm),
                                vec_full_reg_offset(s, rd), fpst,
                                is_q ? 16 : 8, vec_full_reg_size(s), data,
                                size == MO_64
                                ? gen_helper_gvec_fcmlas_idx
                                : gen_helper_gvec_fcmlah_idx);
         }
         return;
 
     case 0x00: /* FMLAL */
     case 0x04: /* FMLSL */
     case 0x18: /* FMLAL2 */
     case 0x1c: /* FMLSL2 */
         {
             int is_s = extract32(opcode, 2, 1);
             int is_2 = u;
             int data = (index << 2) | (is_2 << 1) | is_s;
             tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
                                vec_full_reg_offset(s, rn),
                                vec_full_reg_offset(s, rm), tcg_env,
                                is_q ? 16 : 8, vec_full_reg_size(s),
                                data, gen_helper_gvec_fmlal_idx_a64);
         }
         return;
 
     case 0x08: /* MUL */
         if (!is_long && !is_scalar) {
             static gen_helper_gvec_3 * const fns[3] = {
                 gen_helper_gvec_mul_idx_h,
                 gen_helper_gvec_mul_idx_s,
                 gen_helper_gvec_mul_idx_d,
             };
             tcg_gen_gvec_3_ool(vec_full_reg_offset(s, rd),
                                vec_full_reg_offset(s, rn),
                                vec_full_reg_offset(s, rm),
                                is_q ? 16 : 8, vec_full_reg_size(s),
                                index, fns[size - 1]);
             return;
         }
         break;
 
     case 0x10: /* MLA */
         if (!is_long && !is_scalar) {
             static gen_helper_gvec_4 * const fns[3] = {
                 gen_helper_gvec_mla_idx_h,
                 gen_helper_gvec_mla_idx_s,
                 gen_helper_gvec_mla_idx_d,
             };
             tcg_gen_gvec_4_ool(vec_full_reg_offset(s, rd),
                                vec_full_reg_offset(s, rn),
                                vec_full_reg_offset(s, rm),
                                vec_full_reg_offset(s, rd),
                                is_q ? 16 : 8, vec_full_reg_size(s),
                                index, fns[size - 1]);
             return;
         }
         break;
 
     case 0x14: /* MLS */
         if (!is_long && !is_scalar) {
             static gen_helper_gvec_4 * const fns[3] = {
                 gen_helper_gvec_mls_idx_h,
                 gen_helper_gvec_mls_idx_s,
                 gen_helper_gvec_mls_idx_d,
             };
             tcg_gen_gvec_4_ool(vec_full_reg_offset(s, rd),
                                vec_full_reg_offset(s, rn),
                                vec_full_reg_offset(s, rm),
                                vec_full_reg_offset(s, rd),
                                is_q ? 16 : 8, vec_full_reg_size(s),
                                index, fns[size - 1]);
             return;
         }
         break;
     }
 
     if (size == 3) {
         TCGv_i64 tcg_idx = tcg_temp_new_i64();
         int pass;
 
         assert(is_fp && is_q && !is_long);
 
         read_vec_element(s, tcg_idx, rm, index, MO_64);
 
         for (pass = 0; pass < (is_scalar ? 1 : 2); pass++) {
             TCGv_i64 tcg_op = tcg_temp_new_i64();
             TCGv_i64 tcg_res = tcg_temp_new_i64();
 
             read_vec_element(s, tcg_op, rn, pass, MO_64);
 
             switch (16 * u + opcode) {
             case 0x05: /* FMLS */
                 /* As usual for ARM, separate negation for fused multiply-add */
                 gen_helper_vfp_negd(tcg_op, tcg_op);
-                /* fall through */
+                fallthrough;
             case 0x01: /* FMLA */
                 read_vec_element(s, tcg_res, rd, pass, MO_64);
                 gen_helper_vfp_muladdd(tcg_res, tcg_op, tcg_idx, tcg_res, fpst);
                 break;
             case 0x09: /* FMUL */
                 gen_helper_vfp_muld(tcg_res, tcg_op, tcg_idx, fpst);
                 break;
             case 0x19: /* FMULX */
                 gen_helper_vfp_mulxd(tcg_res, tcg_op, tcg_idx, fpst);
                 break;
             default:
                 g_assert_not_reached();
             }
 
             write_vec_element(s, tcg_res, rd, pass, MO_64);
         }
 
         clear_vec_high(s, !is_scalar, rd);
     } else if (!is_long) {
         /* 32 bit floating point, or 16 or 32 bit integer.
          * For the 16 bit scalar case we use the usual Neon helpers and
          * rely on the fact that 0 op 0 == 0 with no side effects.
          */
         TCGv_i32 tcg_idx = tcg_temp_new_i32();
         int pass, maxpasses;
 
         if (is_scalar) {
             maxpasses = 1;
         } else {
             maxpasses = is_q ? 4 : 2;
         }
 
         read_vec_element_i32(s, tcg_idx, rm, index, size);
 
         if (size == 1 && !is_scalar) {
             /* The simplest way to handle the 16x16 indexed ops is to duplicate
              * the index into both halves of the 32 bit tcg_idx and then use
              * the usual Neon helpers.
              */
             tcg_gen_deposit_i32(tcg_idx, tcg_idx, tcg_idx, 16, 16);
         }
 
         for (pass = 0; pass < maxpasses; pass++) {
             TCGv_i32 tcg_op = tcg_temp_new_i32();
             TCGv_i32 tcg_res = tcg_temp_new_i32();
 
             read_vec_element_i32(s, tcg_op, rn, pass, is_scalar ? size : MO_32);
 
             switch (16 * u + opcode) {
             case 0x08: /* MUL */
             case 0x10: /* MLA */
             case 0x14: /* MLS */
             {
                 static NeonGenTwoOpFn * const fns[2][2] = {
                     { gen_helper_neon_add_u16, gen_helper_neon_sub_u16 },
                     { tcg_gen_add_i32, tcg_gen_sub_i32 },
                 };
                 NeonGenTwoOpFn *genfn;
                 bool is_sub = opcode == 0x4;
 
                 if (size == 1) {
                     gen_helper_neon_mul_u16(tcg_res, tcg_op, tcg_idx);
                 } else {
                     tcg_gen_mul_i32(tcg_res, tcg_op, tcg_idx);
                 }
                 if (opcode == 0x8) {
                     break;
                 }
                 read_vec_element_i32(s, tcg_op, rd, pass, MO_32);
                 genfn = fns[size - 1][is_sub];
                 genfn(tcg_res, tcg_op, tcg_res);
                 break;
             }
             case 0x05: /* FMLS */
             case 0x01: /* FMLA */
                 read_vec_element_i32(s, tcg_res, rd, pass,
                                      is_scalar ? size : MO_32);
                 switch (size) {
                 case 1:
                     if (opcode == 0x5) {
                         /* As usual for ARM, separate negation for fused
                          * multiply-add */
                         tcg_gen_xori_i32(tcg_op, tcg_op, 0x80008000);
                     }
                     if (is_scalar) {
                         gen_helper_advsimd_muladdh(tcg_res, tcg_op, tcg_idx,
                                                    tcg_res, fpst);
                     } else {
                         gen_helper_advsimd_muladd2h(tcg_res, tcg_op, tcg_idx,
                                                     tcg_res, fpst);
                     }
                     break;
                 case 2:
                     if (opcode == 0x5) {
                         /* As usual for ARM, separate negation for
                          * fused multiply-add */
                         tcg_gen_xori_i32(tcg_op, tcg_op, 0x80000000);
                     }
                     gen_helper_vfp_muladds(tcg_res, tcg_op, tcg_idx,
                                            tcg_res, fpst);
                     break;
                 default:
                     g_assert_not_reached();
                 }
                 break;
             case 0x09: /* FMUL */
                 switch (size) {
                 case 1:
                     if (is_scalar) {
                         gen_helper_advsimd_mulh(tcg_res, tcg_op,
                                                 tcg_idx, fpst);
                     } else {
                         gen_helper_advsimd_mul2h(tcg_res, tcg_op,
                                                  tcg_idx, fpst);
                     }
                     break;
                 case 2:
                     gen_helper_vfp_muls(tcg_res, tcg_op, tcg_idx, fpst);
                     break;
                 default:
                     g_assert_not_reached();
                 }
                 break;
             case 0x19: /* FMULX */
                 switch (size) {
                 case 1:
                     if (is_scalar) {
                         gen_helper_advsimd_mulxh(tcg_res, tcg_op,
                                                  tcg_idx, fpst);
                     } else {
                         gen_helper_advsimd_mulx2h(tcg_res, tcg_op,
                                                   tcg_idx, fpst);
                     }
                     break;
                 case 2:
                     gen_helper_vfp_mulxs(tcg_res, tcg_op, tcg_idx, fpst);
                     break;
                 default:
                     g_assert_not_reached();
                 }
                 break;
             case 0x0c: /* SQDMULH */
                 if (size == 1) {
                     gen_helper_neon_qdmulh_s16(tcg_res, tcg_env,
                                                tcg_op, tcg_idx);
                 } else {
                     gen_helper_neon_qdmulh_s32(tcg_res, tcg_env,
                                                tcg_op, tcg_idx);
                 }
                 break;
             case 0x0d: /* SQRDMULH */
                 if (size == 1) {
                     gen_helper_neon_qrdmulh_s16(tcg_res, tcg_env,
                                                 tcg_op, tcg_idx);
                 } else {
                     gen_helper_neon_qrdmulh_s32(tcg_res, tcg_env,
                                                 tcg_op, tcg_idx);
                 }
                 break;
             case 0x1d: /* SQRDMLAH */
                 read_vec_element_i32(s, tcg_res, rd, pass,
                                      is_scalar ? size : MO_32);
                 if (size == 1) {
                     gen_helper_neon_qrdmlah_s16(tcg_res, tcg_env,
                                                 tcg_op, tcg_idx, tcg_res);
                 } else {
                     gen_helper_neon_qrdmlah_s32(tcg_res, tcg_env,
                                                 tcg_op, tcg_idx, tcg_res);
                 }
                 break;
             case 0x1f: /* SQRDMLSH */
                 read_vec_element_i32(s, tcg_res, rd, pass,
                                      is_scalar ? size : MO_32);
                 if (size == 1) {
                     gen_helper_neon_qrdmlsh_s16(tcg_res, tcg_env,
                                                 tcg_op, tcg_idx, tcg_res);
                 } else {
                     gen_helper_neon_qrdmlsh_s32(tcg_res, tcg_env,
                                                 tcg_op, tcg_idx, tcg_res);
                 }
                 break;
             default:
                 g_assert_not_reached();
             }
 
             if (is_scalar) {
                 write_fp_sreg(s, rd, tcg_res);
             } else {
                 write_vec_element_i32(s, tcg_res, rd, pass, MO_32);
             }
         }
 
         clear_vec_high(s, is_q, rd);
     } else {
         /* long ops: 16x16->32 or 32x32->64 */
         TCGv_i64 tcg_res[2];
         int pass;
         bool satop = extract32(opcode, 0, 1);
         MemOp memop = MO_32;
 
         if (satop || !u) {
             memop |= MO_SIGN;
         }
 
         if (size == 2) {
             TCGv_i64 tcg_idx = tcg_temp_new_i64();
 
             read_vec_element(s, tcg_idx, rm, index, memop);
 
             for (pass = 0; pass < (is_scalar ? 1 : 2); pass++) {
                 TCGv_i64 tcg_op = tcg_temp_new_i64();
                 TCGv_i64 tcg_passres;
                 int passelt;
 
                 if (is_scalar) {
                     passelt = 0;
                 } else {
                     passelt = pass + (is_q * 2);
                 }
 
                 read_vec_element(s, tcg_op, rn, passelt, memop);
 
                 tcg_res[pass] = tcg_temp_new_i64();
 
                 if (opcode == 0xa || opcode == 0xb) {
                     /* Non-accumulating ops */
                     tcg_passres = tcg_res[pass];
                 } else {
                     tcg_passres = tcg_temp_new_i64();
                 }
 
                 tcg_gen_mul_i64(tcg_passres, tcg_op, tcg_idx);
 
                 if (satop) {
                     /* saturating, doubling */
                     gen_helper_neon_addl_saturate_s64(tcg_passres, tcg_env,
                                                       tcg_passres, tcg_passres);
                 }
 
                 if (opcode == 0xa || opcode == 0xb) {
                     continue;
                 }
 
                 /* Accumulating op: handle accumulate step */
                 read_vec_element(s, tcg_res[pass], rd, pass, MO_64);
 
                 switch (opcode) {
                 case 0x2: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
                     tcg_gen_add_i64(tcg_res[pass], tcg_res[pass], tcg_passres);
                     break;
                 case 0x6: /* SMLSL, SMLSL2, UMLSL, UMLSL2 */
                     tcg_gen_sub_i64(tcg_res[pass], tcg_res[pass], tcg_passres);
                     break;
                 case 0x7: /* SQDMLSL, SQDMLSL2 */
                     tcg_gen_neg_i64(tcg_passres, tcg_passres);
-                    /* fall through */
+                    fallthrough;
                 case 0x3: /* SQDMLAL, SQDMLAL2 */
                     gen_helper_neon_addl_saturate_s64(tcg_res[pass], tcg_env,
                                                       tcg_res[pass],
                                                       tcg_passres);
                     break;
                 default:
                     g_assert_not_reached();
                 }
             }
 
             clear_vec_high(s, !is_scalar, rd);
         } else {
             TCGv_i32 tcg_idx = tcg_temp_new_i32();
 
             assert(size == 1);
             read_vec_element_i32(s, tcg_idx, rm, index, size);
 
             if (!is_scalar) {
                 /* The simplest way to handle the 16x16 indexed ops is to
                  * duplicate the index into both halves of the 32 bit tcg_idx
                  * and then use the usual Neon helpers.
                  */
                 tcg_gen_deposit_i32(tcg_idx, tcg_idx, tcg_idx, 16, 16);
             }
 
             for (pass = 0; pass < (is_scalar ? 1 : 2); pass++) {
                 TCGv_i32 tcg_op = tcg_temp_new_i32();
                 TCGv_i64 tcg_passres;
 
                 if (is_scalar) {
                     read_vec_element_i32(s, tcg_op, rn, pass, size);
                 } else {
                     read_vec_element_i32(s, tcg_op, rn,
                                          pass + (is_q * 2), MO_32);
                 }
 
                 tcg_res[pass] = tcg_temp_new_i64();
 
                 if (opcode == 0xa || opcode == 0xb) {
                     /* Non-accumulating ops */
                     tcg_passres = tcg_res[pass];
                 } else {
                     tcg_passres = tcg_temp_new_i64();
                 }
 
                 if (memop & MO_SIGN) {
                     gen_helper_neon_mull_s16(tcg_passres, tcg_op, tcg_idx);
                 } else {
                     gen_helper_neon_mull_u16(tcg_passres, tcg_op, tcg_idx);
                 }
                 if (satop) {
                     gen_helper_neon_addl_saturate_s32(tcg_passres, tcg_env,
                                                       tcg_passres, tcg_passres);
                 }
 
                 if (opcode == 0xa || opcode == 0xb) {
                     continue;
                 }
 
                 /* Accumulating op: handle accumulate step */
                 read_vec_element(s, tcg_res[pass], rd, pass, MO_64);
 
                 switch (opcode) {
                 case 0x2: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
                     gen_helper_neon_addl_u32(tcg_res[pass], tcg_res[pass],
                                              tcg_passres);
                     break;
                 case 0x6: /* SMLSL, SMLSL2, UMLSL, UMLSL2 */
                     gen_helper_neon_subl_u32(tcg_res[pass], tcg_res[pass],
                                              tcg_passres);
                     break;
                 case 0x7: /* SQDMLSL, SQDMLSL2 */
                     gen_helper_neon_negl_u32(tcg_passres, tcg_passres);
-                    /* fall through */
+                    fallthrough;
                 case 0x3: /* SQDMLAL, SQDMLAL2 */
                     gen_helper_neon_addl_saturate_s32(tcg_res[pass], tcg_env,
                                                       tcg_res[pass],
                                                       tcg_passres);
                     break;
                 default:
                     g_assert_not_reached();
                 }
             }
 
             if (is_scalar) {
                 tcg_gen_ext32u_i64(tcg_res[0], tcg_res[0]);
             }
         }
 
         if (is_scalar) {
             tcg_res[1] = tcg_constant_i64(0);
         }
 
         for (pass = 0; pass < 2; pass++) {
             write_vec_element(s, tcg_res[pass], rd, pass, MO_64);
         }
     }
 }
 
 /* Crypto AES
  *  31             24 23  22 21       17 16    12 11 10 9    5 4    0
  * +-----------------+------+-----------+--------+-----+------+------+
  * | 0 1 0 0 1 1 1 0 | size | 1 0 1 0 0 | opcode | 1 0 |  Rn  |  Rd  |
  * +-----------------+------+-----------+--------+-----+------+------+
  */
@@ -14202,67 +14202,67 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
     if (unlikely(dc->ss_active)) {
         /* Note that this means single stepping WFI doesn't halt the CPU.
          * For conditional branch insns this is harmless unreachable code as
          * gen_goto_tb() has already handled emitting the debug exception
          * (and thus a tb-jump is not possible when singlestepping).
          */
         switch (dc->base.is_jmp) {
         default:
             gen_a64_update_pc(dc, 4);
-            /* fall through */
+            fallthrough;
         case DISAS_EXIT:
         case DISAS_JUMP:
             gen_step_complete_exception(dc);
             break;
         case DISAS_NORETURN:
             break;
         }
     } else {
         switch (dc->base.is_jmp) {
         case DISAS_NEXT:
         case DISAS_TOO_MANY:
             gen_goto_tb(dc, 1, 4);
             break;
         default:
         case DISAS_UPDATE_EXIT:
             gen_a64_update_pc(dc, 4);
-            /* fall through */
+            fallthrough;
         case DISAS_EXIT:
             tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_UPDATE_NOCHAIN:
             gen_a64_update_pc(dc, 4);
-            /* fall through */
+            fallthrough;
         case DISAS_JUMP:
             tcg_gen_lookup_and_goto_ptr();
             break;
         case DISAS_NORETURN:
         case DISAS_SWI:
             break;
         case DISAS_WFE:
             gen_a64_update_pc(dc, 4);
             gen_helper_wfe(tcg_env);
             break;
         case DISAS_YIELD:
             gen_a64_update_pc(dc, 4);
             gen_helper_yield(tcg_env);
             break;
         case DISAS_WFI:
             /*
              * This is a special case because we don't want to just halt
              * the CPU if trying to debug across a WFI.
              */
             gen_a64_update_pc(dc, 4);
             gen_helper_wfi(tcg_env, tcg_constant_i32(4));
             /*
              * The helper doesn't necessarily throw an exception, but we
              * must go back to the main loop to check for interrupts anyway.
              */
             tcg_gen_exit_tb(NULL, 0);
             break;
         }
     }
 }
diff --git a/target/arm/tcg/translate-m-nocp.c b/target/arm/tcg/translate-m-nocp.c
index f564d06ccf..42d6f516ba 100644
--- a/target/arm/tcg/translate-m-nocp.c
+++ b/target/arm/tcg/translate-m-nocp.c
@@ -305,122 +305,122 @@ static void gen_branch_fpInactive(DisasContext *s, TCGCond cond,
 static bool gen_M_fp_sysreg_write(DisasContext *s, int regno,
                                   fp_sysreg_loadfn *loadfn,
                                   void *opaque)
 {
     /* Do a write to an M-profile floating point system register */
     TCGv_i32 tmp;
     TCGLabel *lab_end = NULL;
 
     switch (fp_sysreg_checks(s, regno)) {
     case FPSysRegCheckFailed:
         return false;
     case FPSysRegCheckDone:
         return true;
     case FPSysRegCheckContinue:
         break;
     }
 
     switch (regno) {
     case ARM_VFP_FPSCR:
         tmp = loadfn(s, opaque, true);
         gen_helper_vfp_set_fpscr(tcg_env, tmp);
         gen_lookup_tb(s);
         break;
     case ARM_VFP_FPSCR_NZCVQC:
     {
         TCGv_i32 fpscr;
         tmp = loadfn(s, opaque, true);
         if (dc_isar_feature(aa32_mve, s)) {
             /* QC is only present for MVE; otherwise RES0 */
             TCGv_i32 qc = tcg_temp_new_i32();
             tcg_gen_andi_i32(qc, tmp, FPCR_QC);
             /*
              * The 4 vfp.qc[] fields need only be "zero" vs "non-zero";
              * here writing the same value into all elements is simplest.
              */
             tcg_gen_gvec_dup_i32(MO_32, offsetof(CPUARMState, vfp.qc),
                                  16, 16, qc);
         }
         tcg_gen_andi_i32(tmp, tmp, FPCR_NZCV_MASK);
         fpscr = load_cpu_field(vfp.xregs[ARM_VFP_FPSCR]);
         tcg_gen_andi_i32(fpscr, fpscr, ~FPCR_NZCV_MASK);
         tcg_gen_or_i32(fpscr, fpscr, tmp);
         store_cpu_field(fpscr, vfp.xregs[ARM_VFP_FPSCR]);
         break;
     }
     case ARM_VFP_FPCXT_NS:
     {
         TCGLabel *lab_active = gen_new_label();
 
         lab_end = gen_new_label();
         gen_branch_fpInactive(s, TCG_COND_EQ, lab_active);
         /*
          * fpInactive case: write is a NOP, so only do side effects
          * like register writeback before we branch to end
          */
         loadfn(s, opaque, false);
         tcg_gen_br(lab_end);
 
         gen_set_label(lab_active);
         /*
          * !fpInactive: if FPU disabled, take NOCP exception;
          * otherwise PreserveFPState(), and then FPCXT_NS writes
          * behave the same as FPCXT_S writes.
          */
         if (!vfp_access_check_m(s, true)) {
             /*
              * This was only a conditional exception, so override
              * gen_exception_insn_el()'s default to DISAS_NORETURN
              */
             s->base.is_jmp = DISAS_NEXT;
             break;
         }
+        fallthrough;
     }
-    /* fall through */
     case ARM_VFP_FPCXT_S:
     {
         TCGv_i32 sfpa, control;
         /*
          * Set FPSCR and CONTROL.SFPA from value; the new FPSCR takes
          * bits [27:0] from value and zeroes bits [31:28].
          */
         tmp = loadfn(s, opaque, true);
         sfpa = tcg_temp_new_i32();
         tcg_gen_shri_i32(sfpa, tmp, 31);
         control = load_cpu_field(v7m.control[M_REG_S]);
         tcg_gen_deposit_i32(control, control, sfpa,
                             R_V7M_CONTROL_SFPA_SHIFT, 1);
         store_cpu_field(control, v7m.control[M_REG_S]);
         tcg_gen_andi_i32(tmp, tmp, ~FPCR_NZCV_MASK);
         gen_helper_vfp_set_fpscr(tcg_env, tmp);
         s->base.is_jmp = DISAS_UPDATE_NOCHAIN;
         break;
     }
     case ARM_VFP_VPR:
         /* Behaves as NOP if not privileged */
         if (IS_USER(s)) {
             loadfn(s, opaque, false);
             break;
         }
         tmp = loadfn(s, opaque, true);
         store_cpu_field(tmp, v7m.vpr);
         s->base.is_jmp = DISAS_UPDATE_NOCHAIN;
         break;
     case ARM_VFP_P0:
     {
         TCGv_i32 vpr;
         tmp = loadfn(s, opaque, true);
         vpr = load_cpu_field(v7m.vpr);
         tcg_gen_deposit_i32(vpr, vpr, tmp,
                             R_V7M_VPR_P0_SHIFT, R_V7M_VPR_P0_LENGTH);
         store_cpu_field(vpr, v7m.vpr);
         s->base.is_jmp = DISAS_UPDATE_NOCHAIN;
         break;
     }
     default:
         g_assert_not_reached();
     }
     if (lab_end) {
         gen_set_label(lab_end);
     }
     return true;
 }
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index b9af03b7c3..57d3c41596 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -743,140 +743,140 @@ static bool trans_VDUP(DisasContext *s, arg_VDUP *a)
 static bool trans_VMSR_VMRS(DisasContext *s, arg_VMSR_VMRS *a)
 {
     TCGv_i32 tmp;
     bool ignore_vfp_enabled = false;
 
     if (arm_dc_feature(s, ARM_FEATURE_M)) {
         /* M profile version was already handled in m-nocp.decode */
         return false;
     }
 
     if (!dc_isar_feature(aa32_fpsp_v2, s)) {
         return false;
     }
 
     switch (a->reg) {
     case ARM_VFP_FPSID:
         /*
          * VFPv2 allows access to FPSID from userspace; VFPv3 restricts
          * all ID registers to privileged access only.
          */
         if (IS_USER(s) && dc_isar_feature(aa32_fpsp_v3, s)) {
             return false;
         }
         ignore_vfp_enabled = true;
         break;
     case ARM_VFP_MVFR0:
     case ARM_VFP_MVFR1:
         if (IS_USER(s) || !arm_dc_feature(s, ARM_FEATURE_MVFR)) {
             return false;
         }
         ignore_vfp_enabled = true;
         break;
     case ARM_VFP_MVFR2:
         if (IS_USER(s) || !arm_dc_feature(s, ARM_FEATURE_V8)) {
             return false;
         }
         ignore_vfp_enabled = true;
         break;
     case ARM_VFP_FPSCR:
         break;
     case ARM_VFP_FPEXC:
         if (IS_USER(s)) {
             return false;
         }
         ignore_vfp_enabled = true;
         break;
     case ARM_VFP_FPINST:
     case ARM_VFP_FPINST2:
         /* Not present in VFPv3 */
         if (IS_USER(s) || dc_isar_feature(aa32_fpsp_v3, s)) {
             return false;
         }
         break;
     default:
         return false;
     }
 
     /*
      * Call vfp_access_check_a() directly, because we need to tell
      * it to ignore FPEXC.EN for some register accesses.
      */
     if (!vfp_access_check_a(s, ignore_vfp_enabled)) {
         return true;
     }
 
     if (a->l) {
         /* VMRS, move VFP special register to gp register */
         switch (a->reg) {
         case ARM_VFP_MVFR0:
         case ARM_VFP_MVFR1:
         case ARM_VFP_MVFR2:
         case ARM_VFP_FPSID:
             if (s->current_el == 1) {
                 gen_set_condexec(s);
                 gen_update_pc(s, 0);
                 gen_helper_check_hcr_el2_trap(tcg_env,
                                               tcg_constant_i32(a->rt),
                                               tcg_constant_i32(a->reg));
             }
-            /* fall through */
+            fallthrough;
         case ARM_VFP_FPEXC:
         case ARM_VFP_FPINST:
         case ARM_VFP_FPINST2:
             tmp = load_cpu_field(vfp.xregs[a->reg]);
             break;
         case ARM_VFP_FPSCR:
             if (a->rt == 15) {
                 tmp = load_cpu_field(vfp.xregs[ARM_VFP_FPSCR]);
                 tcg_gen_andi_i32(tmp, tmp, FPCR_NZCV_MASK);
             } else {
                 tmp = tcg_temp_new_i32();
                 gen_helper_vfp_get_fpscr(tmp, tcg_env);
             }
             break;
         default:
             g_assert_not_reached();
         }
 
         if (a->rt == 15) {
             /* Set the 4 flag bits in the CPSR.  */
             gen_set_nzcv(tmp);
         } else {
             store_reg(s, a->rt, tmp);
         }
     } else {
         /* VMSR, move gp register to VFP special register */
         switch (a->reg) {
         case ARM_VFP_FPSID:
         case ARM_VFP_MVFR0:
         case ARM_VFP_MVFR1:
         case ARM_VFP_MVFR2:
             /* Writes are ignored.  */
             break;
         case ARM_VFP_FPSCR:
             tmp = load_reg(s, a->rt);
             gen_helper_vfp_set_fpscr(tcg_env, tmp);
             gen_lookup_tb(s);
             break;
         case ARM_VFP_FPEXC:
             /*
              * TODO: VFP subarchitecture support.
              * For now, keep the EN bit only
              */
             tmp = load_reg(s, a->rt);
             tcg_gen_andi_i32(tmp, tmp, 1 << 30);
             store_cpu_field(tmp, vfp.xregs[a->reg]);
             gen_lookup_tb(s);
             break;
         case ARM_VFP_FPINST:
         case ARM_VFP_FPINST2:
             tmp = load_reg(s, a->rt);
             store_cpu_field(tmp, vfp.xregs[a->reg]);
             break;
         default:
             g_assert_not_reached();
         }
     }
 
     return true;
 }
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 48927fbb8c..595ef02f0d 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -1486,975 +1486,975 @@ static inline int gen_iwmmxt_shift(uint32_t insn, uint32_t mask, TCGv_i32 dest)
 /* Disassemble an iwMMXt instruction.  Returns nonzero if an error occurred
    (ie. an undefined instruction).  */
 static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
 {
     int rd, wrd;
     int rdhi, rdlo, rd0, rd1, i;
     TCGv_i32 addr;
     TCGv_i32 tmp, tmp2, tmp3;
 
     if ((insn & 0x0e000e00) == 0x0c000000) {
         if ((insn & 0x0fe00ff0) == 0x0c400000) {
             wrd = insn & 0xf;
             rdlo = (insn >> 12) & 0xf;
             rdhi = (insn >> 16) & 0xf;
             if (insn & ARM_CP_RW_BIT) {                         /* TMRRC */
                 iwmmxt_load_reg(cpu_V0, wrd);
                 tcg_gen_extrl_i64_i32(cpu_R[rdlo], cpu_V0);
                 tcg_gen_extrh_i64_i32(cpu_R[rdhi], cpu_V0);
             } else {                                    /* TMCRR */
                 tcg_gen_concat_i32_i64(cpu_V0, cpu_R[rdlo], cpu_R[rdhi]);
                 iwmmxt_store_reg(cpu_V0, wrd);
                 gen_op_iwmmxt_set_mup();
             }
             return 0;
         }
 
         wrd = (insn >> 12) & 0xf;
         addr = tcg_temp_new_i32();
         if (gen_iwmmxt_address(s, insn, addr)) {
             return 1;
         }
         if (insn & ARM_CP_RW_BIT) {
             if ((insn >> 28) == 0xf) {                  /* WLDRW wCx */
                 tmp = tcg_temp_new_i32();
                 gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
                 iwmmxt_store_creg(wrd, tmp);
             } else {
                 i = 1;
                 if (insn & (1 << 8)) {
                     if (insn & (1 << 22)) {             /* WLDRD */
                         gen_aa32_ld64(s, cpu_M0, addr, get_mem_index(s));
                         i = 0;
                     } else {                            /* WLDRW wRd */
                         tmp = tcg_temp_new_i32();
                         gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
                     }
                 } else {
                     tmp = tcg_temp_new_i32();
                     if (insn & (1 << 22)) {             /* WLDRH */
                         gen_aa32_ld16u(s, tmp, addr, get_mem_index(s));
                     } else {                            /* WLDRB */
                         gen_aa32_ld8u(s, tmp, addr, get_mem_index(s));
                     }
                 }
                 if (i) {
                     tcg_gen_extu_i32_i64(cpu_M0, tmp);
                 }
                 gen_op_iwmmxt_movq_wRn_M0(wrd);
             }
         } else {
             if ((insn >> 28) == 0xf) {                  /* WSTRW wCx */
                 tmp = iwmmxt_load_creg(wrd);
                 gen_aa32_st32(s, tmp, addr, get_mem_index(s));
             } else {
                 gen_op_iwmmxt_movq_M0_wRn(wrd);
                 tmp = tcg_temp_new_i32();
                 if (insn & (1 << 8)) {
                     if (insn & (1 << 22)) {             /* WSTRD */
                         gen_aa32_st64(s, cpu_M0, addr, get_mem_index(s));
                     } else {                            /* WSTRW wRd */
                         tcg_gen_extrl_i64_i32(tmp, cpu_M0);
                         gen_aa32_st32(s, tmp, addr, get_mem_index(s));
                     }
                 } else {
                     if (insn & (1 << 22)) {             /* WSTRH */
                         tcg_gen_extrl_i64_i32(tmp, cpu_M0);
                         gen_aa32_st16(s, tmp, addr, get_mem_index(s));
                     } else {                            /* WSTRB */
                         tcg_gen_extrl_i64_i32(tmp, cpu_M0);
                         gen_aa32_st8(s, tmp, addr, get_mem_index(s));
                     }
                 }
             }
         }
         return 0;
     }
 
     if ((insn & 0x0f000000) != 0x0e000000)
         return 1;
 
     switch (((insn >> 12) & 0xf00) | ((insn >> 4) & 0xff)) {
     case 0x000:                                                 /* WOR */
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 0) & 0xf;
         rd1 = (insn >> 16) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         gen_op_iwmmxt_orq_M0_wRn(rd1);
         gen_op_iwmmxt_setpsr_nz();
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
     case 0x011:                                                 /* TMCR */
         if (insn & 0xf)
             return 1;
         rd = (insn >> 12) & 0xf;
         wrd = (insn >> 16) & 0xf;
         switch (wrd) {
         case ARM_IWMMXT_wCID:
         case ARM_IWMMXT_wCASF:
             break;
         case ARM_IWMMXT_wCon:
             gen_op_iwmmxt_set_cup();
-            /* Fall through.  */
+            fallthrough;
         case ARM_IWMMXT_wCSSF:
             tmp = iwmmxt_load_creg(wrd);
             tmp2 = load_reg(s, rd);
             tcg_gen_andc_i32(tmp, tmp, tmp2);
             iwmmxt_store_creg(wrd, tmp);
             break;
         case ARM_IWMMXT_wCGR0:
         case ARM_IWMMXT_wCGR1:
         case ARM_IWMMXT_wCGR2:
         case ARM_IWMMXT_wCGR3:
             gen_op_iwmmxt_set_cup();
             tmp = load_reg(s, rd);
             iwmmxt_store_creg(wrd, tmp);
             break;
         default:
             return 1;
         }
         break;
     case 0x100:                                                 /* WXOR */
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 0) & 0xf;
         rd1 = (insn >> 16) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         gen_op_iwmmxt_xorq_M0_wRn(rd1);
         gen_op_iwmmxt_setpsr_nz();
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
     case 0x111:                                                 /* TMRC */
         if (insn & 0xf)
             return 1;
         rd = (insn >> 12) & 0xf;
         wrd = (insn >> 16) & 0xf;
         tmp = iwmmxt_load_creg(wrd);
         store_reg(s, rd, tmp);
         break;
     case 0x300:                                                 /* WANDN */
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 0) & 0xf;
         rd1 = (insn >> 16) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         tcg_gen_neg_i64(cpu_M0, cpu_M0);
         gen_op_iwmmxt_andq_M0_wRn(rd1);
         gen_op_iwmmxt_setpsr_nz();
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
     case 0x200:                                                 /* WAND */
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 0) & 0xf;
         rd1 = (insn >> 16) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         gen_op_iwmmxt_andq_M0_wRn(rd1);
         gen_op_iwmmxt_setpsr_nz();
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
     case 0x810: case 0xa10:                             /* WMADD */
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 0) & 0xf;
         rd1 = (insn >> 16) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         if (insn & (1 << 21))
             gen_op_iwmmxt_maddsq_M0_wRn(rd1);
         else
             gen_op_iwmmxt_madduq_M0_wRn(rd1);
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         break;
     case 0x10e: case 0x50e: case 0x90e: case 0xd0e:     /* WUNPCKIL */
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         rd1 = (insn >> 0) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         switch ((insn >> 22) & 3) {
         case 0:
             gen_op_iwmmxt_unpacklb_M0_wRn(rd1);
             break;
         case 1:
             gen_op_iwmmxt_unpacklw_M0_wRn(rd1);
             break;
         case 2:
             gen_op_iwmmxt_unpackll_M0_wRn(rd1);
             break;
         case 3:
             return 1;
         }
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
     case 0x10c: case 0x50c: case 0x90c: case 0xd0c:     /* WUNPCKIH */
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         rd1 = (insn >> 0) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         switch ((insn >> 22) & 3) {
         case 0:
             gen_op_iwmmxt_unpackhb_M0_wRn(rd1);
             break;
         case 1:
             gen_op_iwmmxt_unpackhw_M0_wRn(rd1);
             break;
         case 2:
             gen_op_iwmmxt_unpackhl_M0_wRn(rd1);
             break;
         case 3:
             return 1;
         }
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
     case 0x012: case 0x112: case 0x412: case 0x512:     /* WSAD */
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         rd1 = (insn >> 0) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         if (insn & (1 << 22))
             gen_op_iwmmxt_sadw_M0_wRn(rd1);
         else
             gen_op_iwmmxt_sadb_M0_wRn(rd1);
         if (!(insn & (1 << 20)))
             gen_op_iwmmxt_addl_M0_wRn(wrd);
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         break;
     case 0x010: case 0x110: case 0x210: case 0x310:     /* WMUL */
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         rd1 = (insn >> 0) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         if (insn & (1 << 21)) {
             if (insn & (1 << 20))
                 gen_op_iwmmxt_mulshw_M0_wRn(rd1);
             else
                 gen_op_iwmmxt_mulslw_M0_wRn(rd1);
         } else {
             if (insn & (1 << 20))
                 gen_op_iwmmxt_muluhw_M0_wRn(rd1);
             else
                 gen_op_iwmmxt_mululw_M0_wRn(rd1);
         }
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         break;
     case 0x410: case 0x510: case 0x610: case 0x710:     /* WMAC */
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         rd1 = (insn >> 0) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         if (insn & (1 << 21))
             gen_op_iwmmxt_macsw_M0_wRn(rd1);
         else
             gen_op_iwmmxt_macuw_M0_wRn(rd1);
         if (!(insn & (1 << 20))) {
             iwmmxt_load_reg(cpu_V1, wrd);
             tcg_gen_add_i64(cpu_M0, cpu_M0, cpu_V1);
         }
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         break;
     case 0x006: case 0x406: case 0x806: case 0xc06:     /* WCMPEQ */
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         rd1 = (insn >> 0) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         switch ((insn >> 22) & 3) {
         case 0:
             gen_op_iwmmxt_cmpeqb_M0_wRn(rd1);
             break;
         case 1:
             gen_op_iwmmxt_cmpeqw_M0_wRn(rd1);
             break;
         case 2:
             gen_op_iwmmxt_cmpeql_M0_wRn(rd1);
             break;
         case 3:
             return 1;
         }
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
     case 0x800: case 0x900: case 0xc00: case 0xd00:     /* WAVG2 */
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         rd1 = (insn >> 0) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         if (insn & (1 << 22)) {
             if (insn & (1 << 20))
                 gen_op_iwmmxt_avgw1_M0_wRn(rd1);
             else
                 gen_op_iwmmxt_avgw0_M0_wRn(rd1);
         } else {
             if (insn & (1 << 20))
                 gen_op_iwmmxt_avgb1_M0_wRn(rd1);
             else
                 gen_op_iwmmxt_avgb0_M0_wRn(rd1);
         }
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
     case 0x802: case 0x902: case 0xa02: case 0xb02:     /* WALIGNR */
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         rd1 = (insn >> 0) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         tmp = iwmmxt_load_creg(ARM_IWMMXT_wCGR0 + ((insn >> 20) & 3));
         tcg_gen_andi_i32(tmp, tmp, 7);
         iwmmxt_load_reg(cpu_V1, rd1);
         gen_helper_iwmmxt_align(cpu_M0, cpu_M0, cpu_V1, tmp);
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         break;
     case 0x601: case 0x605: case 0x609: case 0x60d:     /* TINSR */
         if (((insn >> 6) & 3) == 3)
             return 1;
         rd = (insn >> 12) & 0xf;
         wrd = (insn >> 16) & 0xf;
         tmp = load_reg(s, rd);
         gen_op_iwmmxt_movq_M0_wRn(wrd);
         switch ((insn >> 6) & 3) {
         case 0:
             tmp2 = tcg_constant_i32(0xff);
             tmp3 = tcg_constant_i32((insn & 7) << 3);
             break;
         case 1:
             tmp2 = tcg_constant_i32(0xffff);
             tmp3 = tcg_constant_i32((insn & 3) << 4);
             break;
         case 2:
             tmp2 = tcg_constant_i32(0xffffffff);
             tmp3 = tcg_constant_i32((insn & 1) << 5);
             break;
         default:
             g_assert_not_reached();
         }
         gen_helper_iwmmxt_insr(cpu_M0, cpu_M0, tmp, tmp2, tmp3);
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         break;
     case 0x107: case 0x507: case 0x907: case 0xd07:     /* TEXTRM */
         rd = (insn >> 12) & 0xf;
         wrd = (insn >> 16) & 0xf;
         if (rd == 15 || ((insn >> 22) & 3) == 3)
             return 1;
         gen_op_iwmmxt_movq_M0_wRn(wrd);
         tmp = tcg_temp_new_i32();
         switch ((insn >> 22) & 3) {
         case 0:
             tcg_gen_shri_i64(cpu_M0, cpu_M0, (insn & 7) << 3);
             tcg_gen_extrl_i64_i32(tmp, cpu_M0);
             if (insn & 8) {
                 tcg_gen_ext8s_i32(tmp, tmp);
             } else {
                 tcg_gen_andi_i32(tmp, tmp, 0xff);
             }
             break;
         case 1:
             tcg_gen_shri_i64(cpu_M0, cpu_M0, (insn & 3) << 4);
             tcg_gen_extrl_i64_i32(tmp, cpu_M0);
             if (insn & 8) {
                 tcg_gen_ext16s_i32(tmp, tmp);
             } else {
                 tcg_gen_andi_i32(tmp, tmp, 0xffff);
             }
             break;
         case 2:
             tcg_gen_shri_i64(cpu_M0, cpu_M0, (insn & 1) << 5);
             tcg_gen_extrl_i64_i32(tmp, cpu_M0);
             break;
         }
         store_reg(s, rd, tmp);
         break;
     case 0x117: case 0x517: case 0x917: case 0xd17:     /* TEXTRC */
         if ((insn & 0x000ff008) != 0x0003f000 || ((insn >> 22) & 3) == 3)
             return 1;
         tmp = iwmmxt_load_creg(ARM_IWMMXT_wCASF);
         switch ((insn >> 22) & 3) {
         case 0:
             tcg_gen_shri_i32(tmp, tmp, ((insn & 7) << 2) + 0);
             break;
         case 1:
             tcg_gen_shri_i32(tmp, tmp, ((insn & 3) << 3) + 4);
             break;
         case 2:
             tcg_gen_shri_i32(tmp, tmp, ((insn & 1) << 4) + 12);
             break;
         }
         tcg_gen_shli_i32(tmp, tmp, 28);
         gen_set_nzcv(tmp);
         break;
     case 0x401: case 0x405: case 0x409: case 0x40d:     /* TBCST */
         if (((insn >> 6) & 3) == 3)
             return 1;
         rd = (insn >> 12) & 0xf;
         wrd = (insn >> 16) & 0xf;
         tmp = load_reg(s, rd);
         switch ((insn >> 6) & 3) {
         case 0:
             gen_helper_iwmmxt_bcstb(cpu_M0, tmp);
             break;
         case 1:
             gen_helper_iwmmxt_bcstw(cpu_M0, tmp);
             break;
         case 2:
             gen_helper_iwmmxt_bcstl(cpu_M0, tmp);
             break;
         }
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         break;
     case 0x113: case 0x513: case 0x913: case 0xd13:     /* TANDC */
         if ((insn & 0x000ff00f) != 0x0003f000 || ((insn >> 22) & 3) == 3)
             return 1;
         tmp = iwmmxt_load_creg(ARM_IWMMXT_wCASF);
         tmp2 = tcg_temp_new_i32();
         tcg_gen_mov_i32(tmp2, tmp);
         switch ((insn >> 22) & 3) {
         case 0:
             for (i = 0; i < 7; i ++) {
                 tcg_gen_shli_i32(tmp2, tmp2, 4);
                 tcg_gen_and_i32(tmp, tmp, tmp2);
             }
             break;
         case 1:
             for (i = 0; i < 3; i ++) {
                 tcg_gen_shli_i32(tmp2, tmp2, 8);
                 tcg_gen_and_i32(tmp, tmp, tmp2);
             }
             break;
         case 2:
             tcg_gen_shli_i32(tmp2, tmp2, 16);
             tcg_gen_and_i32(tmp, tmp, tmp2);
             break;
         }
         gen_set_nzcv(tmp);
         break;
     case 0x01c: case 0x41c: case 0x81c: case 0xc1c:     /* WACC */
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         switch ((insn >> 22) & 3) {
         case 0:
             gen_helper_iwmmxt_addcb(cpu_M0, cpu_M0);
             break;
         case 1:
             gen_helper_iwmmxt_addcw(cpu_M0, cpu_M0);
             break;
         case 2:
             gen_helper_iwmmxt_addcl(cpu_M0, cpu_M0);
             break;
         case 3:
             return 1;
         }
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         break;
     case 0x115: case 0x515: case 0x915: case 0xd15:     /* TORC */
         if ((insn & 0x000ff00f) != 0x0003f000 || ((insn >> 22) & 3) == 3)
             return 1;
         tmp = iwmmxt_load_creg(ARM_IWMMXT_wCASF);
         tmp2 = tcg_temp_new_i32();
         tcg_gen_mov_i32(tmp2, tmp);
         switch ((insn >> 22) & 3) {
         case 0:
             for (i = 0; i < 7; i ++) {
                 tcg_gen_shli_i32(tmp2, tmp2, 4);
                 tcg_gen_or_i32(tmp, tmp, tmp2);
             }
             break;
         case 1:
             for (i = 0; i < 3; i ++) {
                 tcg_gen_shli_i32(tmp2, tmp2, 8);
                 tcg_gen_or_i32(tmp, tmp, tmp2);
             }
             break;
         case 2:
             tcg_gen_shli_i32(tmp2, tmp2, 16);
             tcg_gen_or_i32(tmp, tmp, tmp2);
             break;
         }
         gen_set_nzcv(tmp);
         break;
     case 0x103: case 0x503: case 0x903: case 0xd03:     /* TMOVMSK */
         rd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         if ((insn & 0xf) != 0 || ((insn >> 22) & 3) == 3)
             return 1;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         tmp = tcg_temp_new_i32();
         switch ((insn >> 22) & 3) {
         case 0:
             gen_helper_iwmmxt_msbb(tmp, cpu_M0);
             break;
         case 1:
             gen_helper_iwmmxt_msbw(tmp, cpu_M0);
             break;
         case 2:
             gen_helper_iwmmxt_msbl(tmp, cpu_M0);
             break;
         }
         store_reg(s, rd, tmp);
         break;
     case 0x106: case 0x306: case 0x506: case 0x706:     /* WCMPGT */
     case 0x906: case 0xb06: case 0xd06: case 0xf06:
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         rd1 = (insn >> 0) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         switch ((insn >> 22) & 3) {
         case 0:
             if (insn & (1 << 21))
                 gen_op_iwmmxt_cmpgtsb_M0_wRn(rd1);
             else
                 gen_op_iwmmxt_cmpgtub_M0_wRn(rd1);
             break;
         case 1:
             if (insn & (1 << 21))
                 gen_op_iwmmxt_cmpgtsw_M0_wRn(rd1);
             else
                 gen_op_iwmmxt_cmpgtuw_M0_wRn(rd1);
             break;
         case 2:
             if (insn & (1 << 21))
                 gen_op_iwmmxt_cmpgtsl_M0_wRn(rd1);
             else
                 gen_op_iwmmxt_cmpgtul_M0_wRn(rd1);
             break;
         case 3:
             return 1;
         }
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
     case 0x00e: case 0x20e: case 0x40e: case 0x60e:     /* WUNPCKEL */
     case 0x80e: case 0xa0e: case 0xc0e: case 0xe0e:
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         switch ((insn >> 22) & 3) {
         case 0:
             if (insn & (1 << 21))
                 gen_op_iwmmxt_unpacklsb_M0();
             else
                 gen_op_iwmmxt_unpacklub_M0();
             break;
         case 1:
             if (insn & (1 << 21))
                 gen_op_iwmmxt_unpacklsw_M0();
             else
                 gen_op_iwmmxt_unpackluw_M0();
             break;
         case 2:
             if (insn & (1 << 21))
                 gen_op_iwmmxt_unpacklsl_M0();
             else
                 gen_op_iwmmxt_unpacklul_M0();
             break;
         case 3:
             return 1;
         }
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
     case 0x00c: case 0x20c: case 0x40c: case 0x60c:     /* WUNPCKEH */
     case 0x80c: case 0xa0c: case 0xc0c: case 0xe0c:
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         switch ((insn >> 22) & 3) {
         case 0:
             if (insn & (1 << 21))
                 gen_op_iwmmxt_unpackhsb_M0();
             else
                 gen_op_iwmmxt_unpackhub_M0();
             break;
         case 1:
             if (insn & (1 << 21))
                 gen_op_iwmmxt_unpackhsw_M0();
             else
                 gen_op_iwmmxt_unpackhuw_M0();
             break;
         case 2:
             if (insn & (1 << 21))
                 gen_op_iwmmxt_unpackhsl_M0();
             else
                 gen_op_iwmmxt_unpackhul_M0();
             break;
         case 3:
             return 1;
         }
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
     case 0x204: case 0x604: case 0xa04: case 0xe04:     /* WSRL */
     case 0x214: case 0x614: case 0xa14: case 0xe14:
         if (((insn >> 22) & 3) == 0)
             return 1;
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         tmp = tcg_temp_new_i32();
         if (gen_iwmmxt_shift(insn, 0xff, tmp)) {
             return 1;
         }
         switch ((insn >> 22) & 3) {
         case 1:
             gen_helper_iwmmxt_srlw(cpu_M0, tcg_env, cpu_M0, tmp);
             break;
         case 2:
             gen_helper_iwmmxt_srll(cpu_M0, tcg_env, cpu_M0, tmp);
             break;
         case 3:
             gen_helper_iwmmxt_srlq(cpu_M0, tcg_env, cpu_M0, tmp);
             break;
         }
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
     case 0x004: case 0x404: case 0x804: case 0xc04:     /* WSRA */
     case 0x014: case 0x414: case 0x814: case 0xc14:
         if (((insn >> 22) & 3) == 0)
             return 1;
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         tmp = tcg_temp_new_i32();
         if (gen_iwmmxt_shift(insn, 0xff, tmp)) {
             return 1;
         }
         switch ((insn >> 22) & 3) {
         case 1:
             gen_helper_iwmmxt_sraw(cpu_M0, tcg_env, cpu_M0, tmp);
             break;
         case 2:
             gen_helper_iwmmxt_sral(cpu_M0, tcg_env, cpu_M0, tmp);
             break;
         case 3:
             gen_helper_iwmmxt_sraq(cpu_M0, tcg_env, cpu_M0, tmp);
             break;
         }
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
     case 0x104: case 0x504: case 0x904: case 0xd04:     /* WSLL */
     case 0x114: case 0x514: case 0x914: case 0xd14:
         if (((insn >> 22) & 3) == 0)
             return 1;
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         tmp = tcg_temp_new_i32();
         if (gen_iwmmxt_shift(insn, 0xff, tmp)) {
             return 1;
         }
         switch ((insn >> 22) & 3) {
         case 1:
             gen_helper_iwmmxt_sllw(cpu_M0, tcg_env, cpu_M0, tmp);
             break;
         case 2:
             gen_helper_iwmmxt_slll(cpu_M0, tcg_env, cpu_M0, tmp);
             break;
         case 3:
             gen_helper_iwmmxt_sllq(cpu_M0, tcg_env, cpu_M0, tmp);
             break;
         }
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
     case 0x304: case 0x704: case 0xb04: case 0xf04:     /* WROR */
     case 0x314: case 0x714: case 0xb14: case 0xf14:
         if (((insn >> 22) & 3) == 0)
             return 1;
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         tmp = tcg_temp_new_i32();
         switch ((insn >> 22) & 3) {
         case 1:
             if (gen_iwmmxt_shift(insn, 0xf, tmp)) {
                 return 1;
             }
             gen_helper_iwmmxt_rorw(cpu_M0, tcg_env, cpu_M0, tmp);
             break;
         case 2:
             if (gen_iwmmxt_shift(insn, 0x1f, tmp)) {
                 return 1;
             }
             gen_helper_iwmmxt_rorl(cpu_M0, tcg_env, cpu_M0, tmp);
             break;
         case 3:
             if (gen_iwmmxt_shift(insn, 0x3f, tmp)) {
                 return 1;
             }
             gen_helper_iwmmxt_rorq(cpu_M0, tcg_env, cpu_M0, tmp);
             break;
         }
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
     case 0x116: case 0x316: case 0x516: case 0x716:     /* WMIN */
     case 0x916: case 0xb16: case 0xd16: case 0xf16:
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         rd1 = (insn >> 0) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         switch ((insn >> 22) & 3) {
         case 0:
             if (insn & (1 << 21))
                 gen_op_iwmmxt_minsb_M0_wRn(rd1);
             else
                 gen_op_iwmmxt_minub_M0_wRn(rd1);
             break;
         case 1:
             if (insn & (1 << 21))
                 gen_op_iwmmxt_minsw_M0_wRn(rd1);
             else
                 gen_op_iwmmxt_minuw_M0_wRn(rd1);
             break;
         case 2:
             if (insn & (1 << 21))
                 gen_op_iwmmxt_minsl_M0_wRn(rd1);
             else
                 gen_op_iwmmxt_minul_M0_wRn(rd1);
             break;
         case 3:
             return 1;
         }
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         break;
     case 0x016: case 0x216: case 0x416: case 0x616:     /* WMAX */
     case 0x816: case 0xa16: case 0xc16: case 0xe16:
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         rd1 = (insn >> 0) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         switch ((insn >> 22) & 3) {
         case 0:
             if (insn & (1 << 21))
                 gen_op_iwmmxt_maxsb_M0_wRn(rd1);
             else
                 gen_op_iwmmxt_maxub_M0_wRn(rd1);
             break;
         case 1:
             if (insn & (1 << 21))
                 gen_op_iwmmxt_maxsw_M0_wRn(rd1);
             else
                 gen_op_iwmmxt_maxuw_M0_wRn(rd1);
             break;
         case 2:
             if (insn & (1 << 21))
                 gen_op_iwmmxt_maxsl_M0_wRn(rd1);
             else
                 gen_op_iwmmxt_maxul_M0_wRn(rd1);
             break;
         case 3:
             return 1;
         }
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         break;
     case 0x002: case 0x102: case 0x202: case 0x302:     /* WALIGNI */
     case 0x402: case 0x502: case 0x602: case 0x702:
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         rd1 = (insn >> 0) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         iwmmxt_load_reg(cpu_V1, rd1);
         gen_helper_iwmmxt_align(cpu_M0, cpu_M0, cpu_V1,
                                 tcg_constant_i32((insn >> 20) & 3));
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         break;
     case 0x01a: case 0x11a: case 0x21a: case 0x31a:     /* WSUB */
     case 0x41a: case 0x51a: case 0x61a: case 0x71a:
     case 0x81a: case 0x91a: case 0xa1a: case 0xb1a:
     case 0xc1a: case 0xd1a: case 0xe1a: case 0xf1a:
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         rd1 = (insn >> 0) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         switch ((insn >> 20) & 0xf) {
         case 0x0:
             gen_op_iwmmxt_subnb_M0_wRn(rd1);
             break;
         case 0x1:
             gen_op_iwmmxt_subub_M0_wRn(rd1);
             break;
         case 0x3:
             gen_op_iwmmxt_subsb_M0_wRn(rd1);
             break;
         case 0x4:
             gen_op_iwmmxt_subnw_M0_wRn(rd1);
             break;
         case 0x5:
             gen_op_iwmmxt_subuw_M0_wRn(rd1);
             break;
         case 0x7:
             gen_op_iwmmxt_subsw_M0_wRn(rd1);
             break;
         case 0x8:
             gen_op_iwmmxt_subnl_M0_wRn(rd1);
             break;
         case 0x9:
             gen_op_iwmmxt_subul_M0_wRn(rd1);
             break;
         case 0xb:
             gen_op_iwmmxt_subsl_M0_wRn(rd1);
             break;
         default:
             return 1;
         }
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
     case 0x01e: case 0x11e: case 0x21e: case 0x31e:     /* WSHUFH */
     case 0x41e: case 0x51e: case 0x61e: case 0x71e:
     case 0x81e: case 0x91e: case 0xa1e: case 0xb1e:
     case 0xc1e: case 0xd1e: case 0xe1e: case 0xf1e:
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         tmp = tcg_constant_i32(((insn >> 16) & 0xf0) | (insn & 0x0f));
         gen_helper_iwmmxt_shufh(cpu_M0, tcg_env, cpu_M0, tmp);
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
     case 0x018: case 0x118: case 0x218: case 0x318:     /* WADD */
     case 0x418: case 0x518: case 0x618: case 0x718:
     case 0x818: case 0x918: case 0xa18: case 0xb18:
     case 0xc18: case 0xd18: case 0xe18: case 0xf18:
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         rd1 = (insn >> 0) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         switch ((insn >> 20) & 0xf) {
         case 0x0:
             gen_op_iwmmxt_addnb_M0_wRn(rd1);
             break;
         case 0x1:
             gen_op_iwmmxt_addub_M0_wRn(rd1);
             break;
         case 0x3:
             gen_op_iwmmxt_addsb_M0_wRn(rd1);
             break;
         case 0x4:
             gen_op_iwmmxt_addnw_M0_wRn(rd1);
             break;
         case 0x5:
             gen_op_iwmmxt_adduw_M0_wRn(rd1);
             break;
         case 0x7:
             gen_op_iwmmxt_addsw_M0_wRn(rd1);
             break;
         case 0x8:
             gen_op_iwmmxt_addnl_M0_wRn(rd1);
             break;
         case 0x9:
             gen_op_iwmmxt_addul_M0_wRn(rd1);
             break;
         case 0xb:
             gen_op_iwmmxt_addsl_M0_wRn(rd1);
             break;
         default:
             return 1;
         }
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
     case 0x008: case 0x108: case 0x208: case 0x308:     /* WPACK */
     case 0x408: case 0x508: case 0x608: case 0x708:
     case 0x808: case 0x908: case 0xa08: case 0xb08:
     case 0xc08: case 0xd08: case 0xe08: case 0xf08:
         if (!(insn & (1 << 20)) || ((insn >> 22) & 3) == 0)
             return 1;
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         rd1 = (insn >> 0) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         switch ((insn >> 22) & 3) {
         case 1:
             if (insn & (1 << 21))
                 gen_op_iwmmxt_packsw_M0_wRn(rd1);
             else
                 gen_op_iwmmxt_packuw_M0_wRn(rd1);
             break;
         case 2:
             if (insn & (1 << 21))
                 gen_op_iwmmxt_packsl_M0_wRn(rd1);
             else
                 gen_op_iwmmxt_packul_M0_wRn(rd1);
             break;
         case 3:
             if (insn & (1 << 21))
                 gen_op_iwmmxt_packsq_M0_wRn(rd1);
             else
                 gen_op_iwmmxt_packuq_M0_wRn(rd1);
             break;
         }
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
     case 0x201: case 0x203: case 0x205: case 0x207:
     case 0x209: case 0x20b: case 0x20d: case 0x20f:
     case 0x211: case 0x213: case 0x215: case 0x217:
     case 0x219: case 0x21b: case 0x21d: case 0x21f:
         wrd = (insn >> 5) & 0xf;
         rd0 = (insn >> 12) & 0xf;
         rd1 = (insn >> 0) & 0xf;
         if (rd0 == 0xf || rd1 == 0xf)
             return 1;
         gen_op_iwmmxt_movq_M0_wRn(wrd);
         tmp = load_reg(s, rd0);
         tmp2 = load_reg(s, rd1);
         switch ((insn >> 16) & 0xf) {
         case 0x0:                                       /* TMIA */
             gen_helper_iwmmxt_muladdsl(cpu_M0, cpu_M0, tmp, tmp2);
             break;
         case 0x8:                                       /* TMIAPH */
             gen_helper_iwmmxt_muladdsw(cpu_M0, cpu_M0, tmp, tmp2);
             break;
         case 0xc: case 0xd: case 0xe: case 0xf:                 /* TMIAxy */
             if (insn & (1 << 16))
                 tcg_gen_shri_i32(tmp, tmp, 16);
             if (insn & (1 << 17))
                 tcg_gen_shri_i32(tmp2, tmp2, 16);
             gen_helper_iwmmxt_muladdswl(cpu_M0, cpu_M0, tmp, tmp2);
             break;
         default:
             return 1;
         }
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         break;
     default:
         return 1;
     }
 
     return 0;
 }
 
 /* Disassemble an XScale DSP instruction.  Returns nonzero if an error occurred
    (ie. an undefined instruction).  */
@@ -9544,111 +9544,111 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
     /* At this stage dc->condjmp will only be set when the skipped
        instruction was a conditional branch or trap, and the PC has
        already been written.  */
     gen_set_condexec(dc);
     if (dc->base.is_jmp == DISAS_BX_EXCRET) {
         /* Exception return branches need some special case code at the
          * end of the TB, which is complex enough that it has to
          * handle the single-step vs not and the condition-failed
          * insn codepath itself.
          */
         gen_bx_excret_final_code(dc);
     } else if (unlikely(dc->ss_active)) {
         /* Unconditional and "condition passed" instruction codepath. */
         switch (dc->base.is_jmp) {
         case DISAS_SWI:
             gen_ss_advance(dc);
             gen_exception(EXCP_SWI, syn_aa32_svc(dc->svc_imm, dc->thumb));
             break;
         case DISAS_HVC:
             gen_ss_advance(dc);
             gen_exception_el(EXCP_HVC, syn_aa32_hvc(dc->svc_imm), 2);
             break;
         case DISAS_SMC:
             gen_ss_advance(dc);
             gen_exception_el(EXCP_SMC, syn_aa32_smc(), 3);
             break;
         case DISAS_NEXT:
         case DISAS_TOO_MANY:
         case DISAS_UPDATE_EXIT:
         case DISAS_UPDATE_NOCHAIN:
             gen_update_pc(dc, curr_insn_len(dc));
-            /* fall through */
+            fallthrough;
         default:
             /* FIXME: Single stepping a WFI insn will not halt the CPU. */
             gen_singlestep_exception(dc);
             break;
         case DISAS_NORETURN:
             break;
         }
     } else {
         /* While branches must always occur at the end of an IT block,
            there are a few other things that can cause us to terminate
            the TB in the middle of an IT block:
             - Exception generating instructions (bkpt, swi, undefined).
             - Page boundaries.
             - Hardware watchpoints.
            Hardware breakpoints have already been handled and skip this code.
          */
         switch (dc->base.is_jmp) {
         case DISAS_NEXT:
         case DISAS_TOO_MANY:
             gen_goto_tb(dc, 1, curr_insn_len(dc));
             break;
         case DISAS_UPDATE_NOCHAIN:
             gen_update_pc(dc, curr_insn_len(dc));
-            /* fall through */
+            fallthrough;
         case DISAS_JUMP:
             gen_goto_ptr();
             break;
         case DISAS_UPDATE_EXIT:
             gen_update_pc(dc, curr_insn_len(dc));
-            /* fall through */
+            fallthrough;
         default:
             /* indicate that the hash table must be used to find the next TB */
             tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_NORETURN:
             /* nothing more to generate */
             break;
         case DISAS_WFI:
             gen_helper_wfi(tcg_env, tcg_constant_i32(curr_insn_len(dc)));
             /*
              * The helper doesn't necessarily throw an exception, but we
              * must go back to the main loop to check for interrupts anyway.
              */
             tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_WFE:
             gen_helper_wfe(tcg_env);
             break;
         case DISAS_YIELD:
             gen_helper_yield(tcg_env);
             break;
         case DISAS_SWI:
             gen_exception(EXCP_SWI, syn_aa32_svc(dc->svc_imm, dc->thumb));
             break;
         case DISAS_HVC:
             gen_exception_el(EXCP_HVC, syn_aa32_hvc(dc->svc_imm), 2);
             break;
         case DISAS_SMC:
             gen_exception_el(EXCP_SMC, syn_aa32_smc(), 3);
             break;
         }
     }
 
     if (dc->condjmp) {
         /* "Condition failed" instruction codepath for the branch/trap insn */
         set_disas_label(dc, dc->condlabel);
         gen_set_condexec(dc);
         if (unlikely(dc->ss_active)) {
             gen_update_pc(dc, curr_insn_len(dc));
             gen_singlestep_exception(dc);
         } else {
             gen_goto_tb(dc, 1, curr_insn_len(dc));
         }
     }
 }
-- 
2.39.2


