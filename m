Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5557C80CC
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:52:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqG-0008Di-M2; Fri, 13 Oct 2023 04:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpw-0007hb-L8
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:07 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDps-0000rM-Md
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:00 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5046bf37ec1so2489062e87.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186873; x=1697791673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XaRABGdreikay04+AeAyrNnueQq9sZduRy/psonsURU=;
 b=kCUAw1YmqKroKF/0eYjMXq3T5ikW/DtZ8T5WdtbX9TdyvHy3BlLYKYnKiNtpvHHeTo
 LIOtFf+KS2nz3ppPyT29fneMwKF+8BiXLG9AQS1X6TeszKhl9R7mXgFHlf44fjJJQmlr
 5i7S3DWlzYPX8OXK27PeE3O8qgmlWGBunUlQFsqczsbPm6k3VukC1e9Reny6feNFhJ3k
 ZUa8Zt8aDIgzNZ6GH0LI4wzhgF3LTLHNL71igUzKev5ZcYUVbJyvwnVDGAPEgjVYn9E7
 9+/TqgXX3+RP+eUoreukFx2wLbpueoJapuni2bgOP+zB8yexuN19JA9Z9+TbuB6IthBO
 qvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186873; x=1697791673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XaRABGdreikay04+AeAyrNnueQq9sZduRy/psonsURU=;
 b=HUgcc6rfVjaJvoDvUdItcYzJ7naYI9VS3MKDk9mqPtGNpdQJwWjbEWIRgs9hbCbq4F
 iJs1Xbmvl03TiMOWkyvHyT82uXS+03UQjNJXjLgUXSkb0+nJpbuJfLYJOKNAw514Ih/q
 v4JfrEgxZvs99PpDklOXMfBPi7r7VXsVi+WOoc9WUVvQMMWIqhx6DVAh6snQzVyUtNX9
 orhs0lZ/R3PLTQpro/gPD8XuA9+vys0NQIYKvZ8CX9fqPzwtARq6FdwVVJMxgTg4KNzr
 hRBRZRcfaZVezm1tqrE2ncuVOD6gLGSxwcURlinMfrJ/gEs5EQ/mNkUqvN9J4B4/ZFTj
 JG5A==
X-Gm-Message-State: AOJu0Yxsn4m+V7SGdAxWgLXwpR0KilEax+6BLf88Y/B5Zs8UB6hTVzrc
 2nWQFhXBmMEP2lc74uzmd9I6fZmuhBmss+wU3bA=
X-Google-Smtp-Source: AGHT+IHq1qSAvgenJLKq4WGzjSyyw06Q9aFRAHhnSwwG4cqMNgboBcnjm5CjRO6iVHj0aVR4k8QRmg==
X-Received: by 2002:ac2:4d87:0:b0:4fb:77d6:89c3 with SMTP id
 g7-20020ac24d87000000b004fb77d689c3mr20546476lfe.12.1697186873188; 
 Fri, 13 Oct 2023 01:47:53 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:47:52 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [RFC PATCH v3 23/78] target/arm: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:45:51 +0300
Message-Id: <ce5e63c8c293fb4799d896be68d88a407f5953b7.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
@@ -2526,7 +2526,7 @@ static CPAccessResult gt_timer_access(CPUARMState *env, int timeridx,
         if (!extract32(env->cp15.c14_cntkctl, 9 - timeridx, 1)) {
             return CP_ACCESS_TRAP;
         }
-        /* fall through */
+        fallthrough;
 
     case 1:
         if (has_el2 && timeridx == GTIMER_PHYS) {
@@ -3588,7 +3588,7 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
             break;
         case 2:
             g_assert(ss != ARMSS_Secure);  /* ARMv8.4-SecEL2 is 64-bit only */
-            /* fall through */
+            fallthrough;
         case 1:
             if (ri->crm == 9 && (env->uncached_cpsr & CPSR_PAN)) {
                 mmu_idx = ARMMMUIdx_Stage1_E1_PAN;
@@ -4657,7 +4657,7 @@ static CPAccessResult aa64_cacheop_poc_access(CPUARMState *env,
         if (!(arm_sctlr(env, 0) & SCTLR_UCI)) {
             return CP_ACCESS_TRAP;
         }
-        /* fall through */
+        fallthrough;
     case 1:
         /* ... EL1 must trap to EL2 if HCR_EL2.TPCP is set.  */
         if (arm_hcr_el2_eff(env) & HCR_TPCP) {
@@ -4677,7 +4677,7 @@ static CPAccessResult do_cacheop_pou_access(CPUARMState *env, uint64_t hcrflags)
         if (!(arm_sctlr(env, 0) & SCTLR_UCI)) {
             return CP_ACCESS_TRAP;
         }
-        /* fall through */
+        fallthrough;
     case 1:
         /* ... EL1 must trap to EL2 if relevant HCR_EL2 flags are set.  */
         if (arm_hcr_el2_eff(env) & hcrflags) {
@@ -6757,7 +6757,7 @@ int sve_exception_el(CPUARMState *env, int el)
             if (el != 0) {
                 break;
             }
-            /* fall through */
+            fallthrough;
         case 0:
         case 2:
             return 1;
@@ -6772,7 +6772,7 @@ int sve_exception_el(CPUARMState *env, int el)
                 if (el != 0 || !(env->cp15.hcr_el2 & HCR_TGE)) {
                     break;
                 }
-                /* fall through */
+                fallthrough;
             case 0:
             case 2:
                 return 2;
@@ -6806,7 +6806,7 @@ int sme_exception_el(CPUARMState *env, int el)
             if (el != 0) {
                 break;
             }
-            /* fall through */
+            fallthrough;
         case 0:
         case 2:
             return 1;
@@ -6821,7 +6821,7 @@ int sme_exception_el(CPUARMState *env, int el)
                 if (el != 0 || !(env->cp15.hcr_el2 & HCR_TGE)) {
                     break;
                 }
-                /* fall through */
+                fallthrough;
             case 0:
             case 2:
                 return 2;
@@ -9731,7 +9731,7 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
         if (r->cp == 0) {
             break;
         }
-        /* fall through */
+        fallthrough;
     case ARM_CP_STATE_AA32:
         if (arm_feature(&cpu->env, ARM_FEATURE_V8) &&
             !arm_feature(&cpu->env, ARM_FEATURE_M)) {
@@ -10660,7 +10660,7 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
                     break;
                 }
                 /* ... the target is EL3, from secure state ... */
-                /* fall through */
+                fallthrough;
             case 1:
                 /* ... the target is EL1 and SCTLR.SPAN is 0.  */
                 if (!(env->cp15.sctlr_el[new_el] & SCTLR_SPAN)) {
@@ -10712,6 +10712,7 @@ static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
         break;
     case EXCP_BKPT:
         /* Fall through to prefetch abort.  */
+        fallthrough;
     case EXCP_PREFETCH_ABORT:
         env->cp15.ifar_s = env->exception.vaddress;
         qemu_log_mask(CPU_LOG_INT, "...with HIFAR 0x%x\n",
@@ -10837,6 +10838,7 @@ static void arm_cpu_do_interrupt_aarch32(CPUState *cs)
         break;
     case EXCP_BKPT:
         /* Fall through to prefetch abort.  */
+        fallthrough;
     case EXCP_PREFETCH_ABORT:
         A32_BANKED_CURRENT_REG_SET(env, ifsr, env->exception.fsr);
         A32_BANKED_CURRENT_REG_SET(env, ifar, env->exception.vaddress);
@@ -11091,7 +11093,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
                 is_aa64 = (hcr & HCR_RW) != 0;
                 break;
             }
-            /* fall through */
+            fallthrough;
         case 1:
             is_aa64 = is_a64(env);
             break;
@@ -11112,7 +11114,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     case EXCP_GPC:
         qemu_log_mask(CPU_LOG_INT, "...with MFAR 0x%" PRIx64 "\n",
                       env->cp15.mfar_el3);
-        /* fall through */
+        fallthrough;
     case EXCP_PREFETCH_ABORT:
     case EXCP_DATA_ABORT:
         /*
@@ -11126,7 +11128,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
         env->cp15.far_el[new_el] = env->exception.vaddress;
         qemu_log_mask(CPU_LOG_INT, "...with FAR 0x%" PRIx64 "\n",
                       env->cp15.far_el[new_el]);
-        /* fall through */
+        fallthrough;
     case EXCP_BKPT:
     case EXCP_UDEF:
     case EXCP_SWI:
@@ -11218,7 +11220,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
                 != (HCR_E2H | HCR_TGE)) {
                 break;
             }
-            /* fall through */
+            fallthrough;
         case 1:
             /* ... the target is EL1 ... */
             /* ... and SCTLR_ELx.SPAN == 0, then set to 1.  */
@@ -11956,7 +11958,7 @@ int fp_exception_el(CPUARMState *env, int cur_el)
             if (cur_el != 0) {
                 break;
             }
-            /* fall through */
+            fallthrough;
         case 0:
         case 2:
             /* Trap from Secure PL0 or PL1 to Secure PL1. */
@@ -11995,7 +11997,7 @@ int fp_exception_el(CPUARMState *env, int cur_el)
                 if (cur_el != 0 || !(hcr_el2 & HCR_TGE)) {
                     break;
                 }
-                /* fall through */
+                fallthrough;
             case 0:
             case 2:
                 return 2;
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 95db9ec4c3..3f6783c100 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2374,7 +2374,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,
                     break; /* no access */
                 case 3:
                     result->f.prot |= PAGE_WRITE;
-                    /* fall through */
+                    fallthrough;
                 case 2:
                 case 6:
                     result->f.prot |= PAGE_READ | PAGE_EXEC;
@@ -2385,7 +2385,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,
                         result->f.prot |= PAGE_READ | PAGE_EXEC;
                         break;
                     }
-                    /* fall through */
+                    fallthrough;
                 default:
                     qemu_log_mask(LOG_GUEST_ERROR,
                                   "DRACR[%d]: Bad value for AP bits: 0x%"
@@ -2399,7 +2399,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,
                 case 2:
                 case 3:
                     result->f.prot |= PAGE_WRITE;
-                    /* fall through */
+                    fallthrough;
                 case 5:
                 case 6:
                     result->f.prot |= PAGE_READ | PAGE_EXEC;
@@ -2410,7 +2410,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,
                         result->f.prot |= PAGE_READ | PAGE_EXEC;
                         break;
                     }
-                    /* fall through */
+                    fallthrough;
                 default:
                     qemu_log_mask(LOG_GUEST_ERROR,
                                   "DRACR[%d]: Bad value for AP bits: 0x%"
@@ -3333,7 +3333,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
             return get_phys_addr_twostage(env, ptw, address, access_type,
                                           result, fi);
         }
-        /* fall through */
+        fallthrough;
 
     default:
         /* Single stage uses physical for ptw. */
diff --git a/target/arm/tcg/psci.c b/target/arm/tcg/psci.c
index 6c1239bb96..dafc39c3d7 100644
--- a/target/arm/tcg/psci.c
+++ b/target/arm/tcg/psci.c
@@ -191,7 +191,7 @@ void arm_handle_psci_call(ARMCPU *cpu)
                 ret = 0;
                 break;
             }
-            /* fallthrough */
+            fallthrough;
         case QEMU_PSCI_0_1_FN_MIGRATE:
         case QEMU_PSCI_0_2_FN_MIGRATE:
         default:
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 10e8dcf743..ee97219acb 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5758,7 +5758,7 @@ static void disas_fp_compare(DisasContext *s, uint32_t insn)
         if (dc_isar_feature(aa64_fp16, s)) {
             break;
         }
-        /* fallthru */
+        fallthrough;
     default:
         unallocated_encoding(s);
         return;
@@ -5808,7 +5808,7 @@ static void disas_fp_ccomp(DisasContext *s, uint32_t insn)
         if (dc_isar_feature(aa64_fp16, s)) {
             break;
         }
-        /* fallthru */
+        fallthrough;
     default:
         unallocated_encoding(s);
         return;
@@ -5872,7 +5872,7 @@ static void disas_fp_csel(DisasContext *s, uint32_t insn)
         if (dc_isar_feature(aa64_fp16, s)) {
             break;
         }
-        /* fallthru */
+        fallthrough;
     default:
         unallocated_encoding(s);
         return;
@@ -6194,7 +6194,7 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
         if (type > 1 || !dc_isar_feature(aa64_frint, s)) {
             goto do_unallocated;
         }
-        /* fall through */
+        fallthrough;
     case 0x0 ... 0x3:
     case 0x8 ... 0xc:
     case 0xe ... 0xf:
@@ -6623,7 +6623,7 @@ static void disas_fp_imm(DisasContext *s, uint32_t insn)
         if (dc_isar_feature(aa64_fp16, s)) {
             break;
         }
-        /* fallthru */
+        fallthrough;
     default:
         unallocated_encoding(s);
         return;
@@ -6831,7 +6831,7 @@ static void disas_fp_fixed_conv(DisasContext *s, uint32_t insn)
         if (dc_isar_feature(aa64_fp16, s)) {
             break;
         }
-        /* fallthru */
+        fallthrough;
     default:
         unallocated_encoding(s);
         return;
@@ -6958,13 +6958,13 @@ static void disas_fp_int_conv(DisasContext *s, uint32_t insn)
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
@@ -6994,7 +6994,7 @@ static void disas_fp_int_conv(DisasContext *s, uint32_t insn)
             if (!dc_isar_feature(aa64_fp16, s)) {
                 goto do_unallocated;
             }
-            /* fallthru */
+            fallthrough;
         case 0b00000110: /* FMOV 32-bit */
         case 0b00000111:
         case 0b10100110: /* FMOV 64-bit */
@@ -7386,7 +7386,7 @@ static void disas_simd_across_lanes(DisasContext *s, uint32_t insn)
             unallocated_encoding(s);
             return;
         }
-        /* fall through */
+        fallthrough;
     case 0x3: /* SADDLV, UADDLV */
     case 0xa: /* SMAXV, UMAXV */
     case 0x1a: /* SMINV, UMINV */
@@ -8292,7 +8292,7 @@ static void handle_simd_qshl(DisasContext *s, bool scalar, bool is_q,
         switch (size) {
         case 0:
             shift |= shift << 8;
-            /* fall through */
+            fallthrough;
         case 1:
             shift |= shift << 16;
             break;
@@ -8639,7 +8639,7 @@ static void disas_simd_scalar_shift_imm(DisasContext *s, uint32_t insn)
             unallocated_encoding(s);
             return;
         }
-        /* fall through */
+        fallthrough;
     case 0x00: /* SSHR / USHR */
     case 0x02: /* SSRA / USRA */
     case 0x04: /* SRSHR / URSHR */
@@ -8740,7 +8740,7 @@ static void disas_simd_scalar_three_reg_diff(DisasContext *s, uint32_t insn)
             break;
         case 0xb: /* SQDMLSL, SQDMLSL2 */
             tcg_gen_neg_i64(tcg_res, tcg_res);
-            /* fall through */
+            fallthrough;
         case 0x9: /* SQDMLAL, SQDMLAL2 */
             read_vec_element(s, tcg_op1, rd, 0, MO_64);
             gen_helper_neon_addl_saturate_s64(tcg_res, tcg_env,
@@ -8764,7 +8764,7 @@ static void disas_simd_scalar_three_reg_diff(DisasContext *s, uint32_t insn)
             break;
         case 0xb: /* SQDMLSL, SQDMLSL2 */
             gen_helper_neon_negl_u32(tcg_res, tcg_res);
-            /* fall through */
+            fallthrough;
         case 0x9: /* SQDMLAL, SQDMLAL2 */
         {
             TCGv_i64 tcg_op3 = tcg_temp_new_i64();
@@ -8887,7 +8887,7 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             case 0x39: /* FMLS */
                 /* As usual for ARM, separate negation for fused multiply-add */
                 gen_helper_vfp_negd(tcg_op1, tcg_op1);
-                /* fall through */
+                fallthrough;
             case 0x19: /* FMLA */
                 read_vec_element(s, tcg_res, rd, pass, MO_64);
                 gen_helper_vfp_muladdd(tcg_res, tcg_op1, tcg_op2,
@@ -8963,7 +8963,7 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             case 0x39: /* FMLS */
                 /* As usual for ARM, separate negation for fused multiply-add */
                 gen_helper_vfp_negs(tcg_op1, tcg_op1);
-                /* fall through */
+                fallthrough;
             case 0x19: /* FMLA */
                 read_vec_element_i32(s, tcg_res, rd, pass, MO_32);
                 gen_helper_vfp_muladds(tcg_res, tcg_op1, tcg_op2,
@@ -9489,7 +9489,7 @@ static void handle_2misc_fcmp_zero(DisasContext *s, int opcode,
         switch (opcode) {
         case 0x2e: /* FCMLT (zero) */
             swap = true;
-            /* fallthrough */
+            fallthrough;
         case 0x2c: /* FCMGT (zero) */
             genfn = gen_helper_neon_cgt_f64;
             break;
@@ -9498,7 +9498,7 @@ static void handle_2misc_fcmp_zero(DisasContext *s, int opcode,
             break;
         case 0x6d: /* FCMLE (zero) */
             swap = true;
-            /* fall through */
+            fallthrough;
         case 0x6c: /* FCMGE (zero) */
             genfn = gen_helper_neon_cge_f64;
             break;
@@ -9529,7 +9529,7 @@ static void handle_2misc_fcmp_zero(DisasContext *s, int opcode,
             switch (opcode) {
             case 0x2e: /* FCMLT (zero) */
                 swap = true;
-                /* fall through */
+                fallthrough;
             case 0x2c: /* FCMGT (zero) */
                 genfn = gen_helper_advsimd_cgt_f16;
                 break;
@@ -9538,7 +9538,7 @@ static void handle_2misc_fcmp_zero(DisasContext *s, int opcode,
                 break;
             case 0x6d: /* FCMLE (zero) */
                 swap = true;
-                /* fall through */
+                fallthrough;
             case 0x6c: /* FCMGE (zero) */
                 genfn = gen_helper_advsimd_cge_f16;
                 break;
@@ -9549,7 +9549,7 @@ static void handle_2misc_fcmp_zero(DisasContext *s, int opcode,
             switch (opcode) {
             case 0x2e: /* FCMLT (zero) */
                 swap = true;
-                /* fall through */
+                fallthrough;
             case 0x2c: /* FCMGT (zero) */
                 genfn = gen_helper_neon_cgt_f32;
                 break;
@@ -9558,7 +9558,7 @@ static void handle_2misc_fcmp_zero(DisasContext *s, int opcode,
                 break;
             case 0x6d: /* FCMLE (zero) */
                 swap = true;
-                /* fall through */
+                fallthrough;
             case 0x6c: /* FCMGE (zero) */
                 genfn = gen_helper_neon_cge_f32;
                 break;
@@ -9888,7 +9888,7 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
             unallocated_encoding(s);
             return;
         }
-        /* fall through */
+        fallthrough;
     case 0x8: /* CMGT, CMGE */
     case 0x9: /* CMEQ, CMLE */
     case 0xb: /* ABS, NEG */
@@ -9902,7 +9902,7 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
             unallocated_encoding(s);
             return;
         }
-        /* fall through */
+        fallthrough;
     case 0x14: /* SQXTN, UQXTN */
         if (size == 3) {
             unallocated_encoding(s);
@@ -10252,7 +10252,7 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
             unallocated_encoding(s);
             return;
         }
-        /* fall through */
+        fallthrough;
     case 0x00: /* SSHR / USHR */
     case 0x02: /* SSRA / USRA (accumulate) */
     case 0x04: /* SRSHR / URSHR (rounding) */
@@ -10686,7 +10686,7 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
             unallocated_encoding(s);
             return;
         }
-        /* fall through */
+        fallthrough;
     case 0: /* SADDL, SADDL2, UADDL, UADDL2 */
     case 2: /* SSUBL, SSUBL2, USUBL, USUBL2 */
     case 5: /* SABAL, SABAL2, UABAL, UABAL2 */
@@ -11009,7 +11009,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
             unallocated_encoding(s);
             return;
         }
-        /* fall through */
+        fallthrough;
     case 0x0: /* SHADD, UHADD */
     case 0x2: /* SRHADD, URHADD */
     case 0x4: /* SHSUB, UHSUB */
@@ -11972,7 +11972,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             unallocated_encoding(s);
             return;
         }
-        /* fall through */
+        fallthrough;
     case 0x8: /* CMGT, CMGE */
     case 0x9: /* CMEQ, CMLE */
     case 0xb: /* ABS, NEG */
@@ -12075,7 +12075,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                 unallocated_encoding(s);
                 return;
             }
-            /* fall through */
+            fallthrough;
         case 0x3d: /* FRECPE */
         case 0x7d: /* FRSQRTE */
             if (size == 3 && !is_q) {
@@ -12092,7 +12092,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                 unallocated_encoding(s);
                 return;
             }
-            /* fall through */
+            fallthrough;
         case 0x16: /* FCVTN, FCVTN2 */
             /* handle_2misc_narrow does a 2*size -> size operation, but these
              * instructions encode the source size rather than dest size.
@@ -12123,7 +12123,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         case 0x38: /* FRINTP */
         case 0x39: /* FRINTZ */
             rmode = extract32(opcode, 5, 1) | (extract32(opcode, 0, 1) << 1);
-            /* fall through */
+            fallthrough;
         case 0x59: /* FRINTX */
         case 0x79: /* FRINTI */
             need_fpstatus = true;
@@ -12149,7 +12149,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         case 0x1e: /* FRINT32Z */
         case 0x1f: /* FRINT64Z */
             rmode = FPROUNDING_ZERO;
-            /* fall through */
+            fallthrough;
         case 0x5e: /* FRINT32X */
         case 0x5f: /* FRINT64X */
             need_fpstatus = true;
@@ -12988,7 +12988,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
             case 0x05: /* FMLS */
                 /* As usual for ARM, separate negation for fused multiply-add */
                 gen_helper_vfp_negd(tcg_op, tcg_op);
-                /* fall through */
+                fallthrough;
             case 0x01: /* FMLA */
                 read_vec_element(s, tcg_res, rd, pass, MO_64);
                 gen_helper_vfp_muladdd(tcg_res, tcg_op, tcg_idx, tcg_res, fpst);
@@ -13244,7 +13244,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                     break;
                 case 0x7: /* SQDMLSL, SQDMLSL2 */
                     tcg_gen_neg_i64(tcg_passres, tcg_passres);
-                    /* fall through */
+                    fallthrough;
                 case 0x3: /* SQDMLAL, SQDMLAL2 */
                     gen_helper_neon_addl_saturate_s64(tcg_res[pass], tcg_env,
                                                       tcg_res[pass],
@@ -13318,7 +13318,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                     break;
                 case 0x7: /* SQDMLSL, SQDMLSL2 */
                     gen_helper_neon_negl_u32(tcg_passres, tcg_passres);
-                    /* fall through */
+                    fallthrough;
                 case 0x3: /* SQDMLAL, SQDMLAL2 */
                     gen_helper_neon_addl_saturate_s32(tcg_res[pass], tcg_env,
                                                       tcg_res[pass],
@@ -14212,7 +14212,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         switch (dc->base.is_jmp) {
         default:
             gen_a64_update_pc(dc, 4);
-            /* fall through */
+            fallthrough;
         case DISAS_EXIT:
         case DISAS_JUMP:
             gen_step_complete_exception(dc);
@@ -14229,13 +14229,13 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
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
diff --git a/target/arm/tcg/translate-m-nocp.c b/target/arm/tcg/translate-m-nocp.c
index f564d06ccf..42d6f516ba 100644
--- a/target/arm/tcg/translate-m-nocp.c
+++ b/target/arm/tcg/translate-m-nocp.c
@@ -374,8 +374,8 @@ static bool gen_M_fp_sysreg_write(DisasContext *s, int regno,
             s->base.is_jmp = DISAS_NEXT;
             break;
         }
+        fallthrough;
     }
-    /* fall through */
     case ARM_VFP_FPCXT_S:
     {
         TCGv_i32 sfpa, control;
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index b9af03b7c3..57d3c41596 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -819,7 +819,7 @@ static bool trans_VMSR_VMRS(DisasContext *s, arg_VMSR_VMRS *a)
                                               tcg_constant_i32(a->rt),
                                               tcg_constant_i32(a->reg));
             }
-            /* fall through */
+            fallthrough;
         case ARM_VFP_FPEXC:
         case ARM_VFP_FPINST:
         case ARM_VFP_FPINST2:
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 48927fbb8c..595ef02f0d 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -1596,7 +1596,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
             break;
         case ARM_IWMMXT_wCon:
             gen_op_iwmmxt_set_cup();
-            /* Fall through.  */
+            fallthrough;
         case ARM_IWMMXT_wCSSF:
             tmp = iwmmxt_load_creg(wrd);
             tmp2 = load_reg(s, rd);
@@ -9576,7 +9576,7 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         case DISAS_UPDATE_EXIT:
         case DISAS_UPDATE_NOCHAIN:
             gen_update_pc(dc, curr_insn_len(dc));
-            /* fall through */
+            fallthrough;
         default:
             /* FIXME: Single stepping a WFI insn will not halt the CPU. */
             gen_singlestep_exception(dc);
@@ -9600,13 +9600,13 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
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
-- 
2.39.2


