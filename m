Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3185F73B763
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:34:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfxN-0002iW-9J; Fri, 23 Jun 2023 08:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx9-0001oQ-K9
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:51 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx6-0000i6-3j
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:51 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4f86e1bdce5so721989e87.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523506; x=1690115506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tsDph97KlzmWiyxrLtjGvlqph+Y12wRBtKMr3A9atw0=;
 b=gI7klK6by719w/enslatQyCmUwxMR0RB/81v2f1qgULxEPbyrI9eagtzK0awf0QZaF
 IVrsRwk4Dzc8yggrb3BUrd0hkyWIAh8xFiaT5M9f+XLzS1WcXlsVDBn3kJVjGcO7O0+s
 LPemFEKsSqfYDnoV7MNrg2JFlLfXSBbd+d+g2hr4pWgKqfvn924bEUTfUMlDsfe04qB0
 g5h3K8j2bQhtkxQi5uGgMJlyjEF8FzKAGl+Q+AMKADCTps2JBGm1o6HOGUPDLHzY0TDq
 j5ISeDfefKVy9We0dasyeA9FW0IBpTK4pX+e96qSOn8Mr7f0RD/9G+mKmXNy4KWgktsg
 U2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523506; x=1690115506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tsDph97KlzmWiyxrLtjGvlqph+Y12wRBtKMr3A9atw0=;
 b=HeLpbga8FQMuiI1M3nQ+7wh0jPIcvqxjdZt8BVEcGEE3DQbb/IAIixVO3UrZkvVOsj
 2jmDcBcTA1PoNnIZSYZdVG9GSghYoaMaebjwuaC2gaz0+ycJc/tLkg9cSpQeKJLzNtDd
 vIpI78CFxVI+gL44GLP0ZswmHj3xWNYC5GPku+wN+A45d3n6teNvuxyV5rOWZ1vEXWc3
 6fVQ1P+BrUWx2JT9jNQThGlHH3vX+ADxOt12IicpWtpiMXAoHcGtpsHuQUa1GGKrLP6+
 hM+fegMWk5+migpsgIZru7eW50blbTmAXU9pB/ZeX5pxUOFjy4Yn45B8lJoSW3BOMWfn
 5+XQ==
X-Gm-Message-State: AC+VfDx2q5uL9z+aFLZIs1x/pHHvxqXDMnw3QCj1/mgHablGy2MzbO9q
 FikNQ9xwm/Tj+HFZHlg5JjMRZHyfCcZpsRHXz90=
X-Google-Smtp-Source: ACHHUZ69gyYxRODhLsxYyPmXANGsYxBRgKJRCvKvgshJIt1PwKqxRwZdMTO5qPhCvspRd1LNWqOM6A==
X-Received: by 2002:ac2:4d8d:0:b0:4f8:75b0:2295 with SMTP id
 g13-20020ac24d8d000000b004f875b02295mr4327039lfe.4.1687523505895; 
 Fri, 23 Jun 2023 05:31:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1c4c07000000b003f819dfa0ddsm2232622wmf.28.2023.06.23.05.31.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:31:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/26] target/arm: Implement GPC exceptions
Date: Fri, 23 Jun 2023 13:31:27 +0100
Message-Id: <20230623123135.1788191-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623123135.1788191-1-peter.maydell@linaro.org>
References: <20230623123135.1788191-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Handle GPC Fault types in arm_deliver_fault, reporting as
either a GPC exception at EL3, or falling through to insn
or data aborts at various exception levels.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230620124418.805717-19-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h            |  1 +
 target/arm/internals.h      | 27 +++++++++++
 target/arm/helper.c         |  5 ++
 target/arm/tcg/tlb_helper.c | 96 +++++++++++++++++++++++++++++++++++--
 4 files changed, 126 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 590216b8559..11c3850ad94 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -57,6 +57,7 @@
 #define EXCP_UNALIGNED      22   /* v7M UNALIGNED UsageFault */
 #define EXCP_DIVBYZERO      23   /* v7M DIVBYZERO UsageFault */
 #define EXCP_VSERR          24
+#define EXCP_GPC            25   /* v9 Granule Protection Check Fault */
 /* NB: add new EXCP_ defines to the array in arm_log_exception() too */
 
 #define ARMV7M_EXCP_RESET   1
diff --git a/target/arm/internals.h b/target/arm/internals.h
index e3029bdc37a..0f01bc32a8a 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -358,14 +358,27 @@ typedef enum ARMFaultType {
     ARMFault_ICacheMaint,
     ARMFault_QEMU_NSCExec, /* v8M: NS executing in S&NSC memory */
     ARMFault_QEMU_SFault, /* v8M: SecureFault INVTRAN, INVEP or AUVIOL */
+    ARMFault_GPCFOnWalk,
+    ARMFault_GPCFOnOutput,
 } ARMFaultType;
 
+typedef enum ARMGPCF {
+    GPCF_None,
+    GPCF_AddressSize,
+    GPCF_Walk,
+    GPCF_EABT,
+    GPCF_Fail,
+} ARMGPCF;
+
 /**
  * ARMMMUFaultInfo: Information describing an ARM MMU Fault
  * @type: Type of fault
+ * @gpcf: Subtype of ARMFault_GPCFOn{Walk,Output}.
  * @level: Table walk level (for translation, access flag and permission faults)
  * @domain: Domain of the fault address (for non-LPAE CPUs only)
  * @s2addr: Address that caused a fault at stage 2
+ * @paddr: physical address that caused a fault for gpc
+ * @paddr_space: physical address space that caused a fault for gpc
  * @stage2: True if we faulted at stage 2
  * @s1ptw: True if we faulted at stage 2 while doing a stage 1 page-table walk
  * @s1ns: True if we faulted on a non-secure IPA while in secure state
@@ -374,7 +387,10 @@ typedef enum ARMFaultType {
 typedef struct ARMMMUFaultInfo ARMMMUFaultInfo;
 struct ARMMMUFaultInfo {
     ARMFaultType type;
+    ARMGPCF gpcf;
     target_ulong s2addr;
+    target_ulong paddr;
+    ARMSecuritySpace paddr_space;
     int level;
     int domain;
     bool stage2;
@@ -548,6 +564,17 @@ static inline uint32_t arm_fi_to_lfsc(ARMMMUFaultInfo *fi)
     case ARMFault_Exclusive:
         fsc = 0x35;
         break;
+    case ARMFault_GPCFOnWalk:
+        assert(fi->level >= -1 && fi->level <= 3);
+        if (fi->level < 0) {
+            fsc = 0b100011;
+        } else {
+            fsc = 0b100100 | fi->level;
+        }
+        break;
+    case ARMFault_GPCFOnOutput:
+        fsc = 0b101000;
+        break;
     default:
         /* Other faults can't occur in a context that requires a
          * long-format status code.
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f68923d73b4..323cadd3c80 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10184,6 +10184,7 @@ void arm_log_exception(CPUState *cs)
             [EXCP_UNALIGNED] = "v7M UNALIGNED UsageFault",
             [EXCP_DIVBYZERO] = "v7M DIVBYZERO UsageFault",
             [EXCP_VSERR] = "Virtual SERR",
+            [EXCP_GPC] = "Granule Protection Check",
         };
 
         if (idx >= 0 && idx < ARRAY_SIZE(excnames)) {
@@ -10915,6 +10916,10 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     }
 
     switch (cs->exception_index) {
+    case EXCP_GPC:
+        qemu_log_mask(CPU_LOG_INT, "...with MFAR 0x%" PRIx64 "\n",
+                      env->cp15.mfar_el3);
+        /* fall through */
     case EXCP_PREFETCH_ABORT:
     case EXCP_DATA_ABORT:
         /*
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 8df36c2cbf0..b22b2a4c6e7 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -107,17 +107,106 @@ static uint32_t compute_fsr_fsc(CPUARMState *env, ARMMMUFaultInfo *fi,
     return fsr;
 }
 
+static bool report_as_gpc_exception(ARMCPU *cpu, int current_el,
+                                    ARMMMUFaultInfo *fi)
+{
+    bool ret;
+
+    switch (fi->gpcf) {
+    case GPCF_None:
+        return false;
+    case GPCF_AddressSize:
+    case GPCF_Walk:
+    case GPCF_EABT:
+        /* R_PYTGX: GPT faults are reported as GPC. */
+        ret = true;
+        break;
+    case GPCF_Fail:
+        /*
+         * R_BLYPM: A GPF at EL3 is reported as insn or data abort.
+         * R_VBZMW, R_LXHQR: A GPF at EL[0-2] is reported as a GPC
+         * if SCR_EL3.GPF is set, otherwise an insn or data abort.
+         */
+        ret = (cpu->env.cp15.scr_el3 & SCR_GPF) && current_el != 3;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    assert(cpu_isar_feature(aa64_rme, cpu));
+    assert(fi->type == ARMFault_GPCFOnWalk ||
+           fi->type == ARMFault_GPCFOnOutput);
+    if (fi->gpcf == GPCF_AddressSize) {
+        assert(fi->level == 0);
+    } else {
+        assert(fi->level >= 0 && fi->level <= 1);
+    }
+
+    return ret;
+}
+
+static unsigned encode_gpcsc(ARMMMUFaultInfo *fi)
+{
+    static uint8_t const gpcsc[] = {
+        [GPCF_AddressSize] = 0b000000,
+        [GPCF_Walk]        = 0b000100,
+        [GPCF_Fail]        = 0b001100,
+        [GPCF_EABT]        = 0b010100,
+    };
+
+    /* Note that we've validated fi->gpcf and fi->level above. */
+    return gpcsc[fi->gpcf] | fi->level;
+}
+
 static G_NORETURN
 void arm_deliver_fault(ARMCPU *cpu, vaddr addr,
                        MMUAccessType access_type,
                        int mmu_idx, ARMMMUFaultInfo *fi)
 {
     CPUARMState *env = &cpu->env;
-    int target_el;
+    int target_el = exception_target_el(env);
+    int current_el = arm_current_el(env);
     bool same_el;
     uint32_t syn, exc, fsr, fsc;
 
-    target_el = exception_target_el(env);
+    if (report_as_gpc_exception(cpu, current_el, fi)) {
+        target_el = 3;
+
+        fsr = compute_fsr_fsc(env, fi, target_el, mmu_idx, &fsc);
+
+        syn = syn_gpc(fi->stage2 && fi->type == ARMFault_GPCFOnWalk,
+                      access_type == MMU_INST_FETCH,
+                      encode_gpcsc(fi), 0, fi->s1ptw,
+                      access_type == MMU_DATA_STORE, fsc);
+
+        env->cp15.mfar_el3 = fi->paddr;
+        switch (fi->paddr_space) {
+        case ARMSS_Secure:
+            break;
+        case ARMSS_NonSecure:
+            env->cp15.mfar_el3 |= R_MFAR_NS_MASK;
+            break;
+        case ARMSS_Root:
+            env->cp15.mfar_el3 |= R_MFAR_NSE_MASK;
+            break;
+        case ARMSS_Realm:
+            env->cp15.mfar_el3 |= R_MFAR_NSE_MASK | R_MFAR_NS_MASK;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+
+        exc = EXCP_GPC;
+        goto do_raise;
+    }
+
+    /* If SCR_EL3.GPF is unset, GPF may still be routed to EL2. */
+    if (fi->gpcf == GPCF_Fail && target_el < 2) {
+        if (arm_hcr_el2_eff(env) & HCR_GPF) {
+            target_el = 2;
+        }
+    }
+
     if (fi->stage2) {
         target_el = 2;
         env->cp15.hpfar_el2 = extract64(fi->s2addr, 12, 47) << 4;
@@ -125,8 +214,8 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr,
             env->cp15.hpfar_el2 |= HPFAR_NS;
         }
     }
-    same_el = (arm_current_el(env) == target_el);
 
+    same_el = current_el == target_el;
     fsr = compute_fsr_fsc(env, fi, target_el, mmu_idx, &fsc);
 
     if (access_type == MMU_INST_FETCH) {
@@ -143,6 +232,7 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr,
         exc = EXCP_DATA_ABORT;
     }
 
+ do_raise:
     env->exception.vaddress = addr;
     env->exception.fsr = fsr;
     raise_exception(env, exc, syn, target_el);
-- 
2.34.1


