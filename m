Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 145B586C9FF
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Feb 2024 14:16:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfgD8-0005vr-Bq; Thu, 29 Feb 2024 08:12:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rfgCc-0005co-Ef; Thu, 29 Feb 2024 08:11:58 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rfgCZ-0002ds-71; Thu, 29 Feb 2024 08:11:58 -0500
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tls7M6RrCz1FLRM;
 Thu, 29 Feb 2024 21:11:43 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 9E335140390;
 Thu, 29 Feb 2024 21:11:45 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 29 Feb
 2024 21:11:45 +0800
To: <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <ruanjinjie@huawei.com>
Subject: [RFC PATCH v5 06/22] target/arm: Add support for Non-maskable
 Interrupt
Date: Thu, 29 Feb 2024 13:10:23 +0000
Message-ID: <20240229131039.1868904-7-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229131039.1868904-1-ruanjinjie@huawei.com>
References: <20240229131039.1868904-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=ruanjinjie@huawei.com; helo=szxga05-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jinjie Ruan <ruanjinjie@huawei.com>
From:  Jinjie Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This only implements the external delivery method via the GICv3.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v4:
- Accept NMI unconditionally for arm_cpu_has_work() but add comment.
- Change from & to && for EXCP_IRQ or EXCP_FIQ.
- Refator nmi mask in arm_excp_unmasked().
- Also handle VNMI in arm_cpu_exec_interrupt() and arm_cpu_set_irq().
- Rename virtual to Virtual.
v3:
- Not include CPU_INTERRUPT_NMI when FEAT_NMI not enabled
- Add ARM_CPU_VNMI.
- Refator nmi mask in arm_excp_unmasked().
- Test SCTLR_ELx.NMI for ALLINT mask for NMI.
---
 target/arm/cpu-qom.h   |  4 +-
 target/arm/cpu.c       | 88 +++++++++++++++++++++++++++++++++++++++---
 target/arm/cpu.h       |  4 ++
 target/arm/helper.c    |  2 +
 target/arm/internals.h | 10 +++++
 5 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index 8e032691db..e0c9e18036 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -36,11 +36,13 @@ DECLARE_CLASS_CHECKERS(AArch64CPUClass, AARCH64_CPU,
 #define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
 #define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
 
-/* Meanings of the ARMCPU object's four inbound GPIO lines */
+/* Meanings of the ARMCPU object's six inbound GPIO lines */
 #define ARM_CPU_IRQ 0
 #define ARM_CPU_FIQ 1
 #define ARM_CPU_VIRQ 2
 #define ARM_CPU_VFIQ 3
+#define ARM_CPU_NMI 4
+#define ARM_CPU_VNMI 5
 
 /* For M profile, some registers are banked secure vs non-secure;
  * these are represented as a 2-element array where the first element
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5fa86bc8d5..ad6e6200f6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -122,6 +122,13 @@ void arm_restore_state_to_opc(CPUState *cs,
 }
 #endif /* CONFIG_TCG */
 
+/*
+ * With SCTLR_ELx.NMI == 0, IRQ with Superpriority is masked identically with
+ * IRQ without Superpriority. Moreover, if the GIC is configured so that
+ * FEAT_GICv3_NMI is only set if FEAT_NMI is set, then we won't ever see
+ * CPU_INTERRUPT_*NMI anyway. So we might as well accept NMI here
+ * unconditionally.
+ */
 static bool arm_cpu_has_work(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -129,6 +136,7 @@ static bool arm_cpu_has_work(CPUState *cs)
     return (cpu->power_state != PSCI_OFF)
         && cs->interrupt_request &
         (CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
+         | CPU_INTERRUPT_NMI | CPU_INTERRUPT_VNMI
          | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ | CPU_INTERRUPT_VSERR
          | CPU_INTERRUPT_EXITTB);
 }
@@ -668,6 +676,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
     CPUARMState *env = cpu_env(cs);
     bool pstate_unmasked;
     bool unmasked = false;
+    bool allIntMask = false;
 
     /*
      * Don't take exceptions if they target a lower EL.
@@ -678,13 +687,31 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
         return false;
     }
 
+    if (cpu_isar_feature(aa64_nmi, env_archcpu(env)) &&
+        env->cp15.sctlr_el[target_el] & SCTLR_NMI && cur_el == target_el) {
+        allIntMask = env->pstate & PSTATE_ALLINT ||
+                     ((env->cp15.sctlr_el[target_el] & SCTLR_SPINTMASK) &&
+                      (env->pstate & PSTATE_SP));
+    }
+
     switch (excp_idx) {
+    case EXCP_NMI:
+        pstate_unmasked = !allIntMask;
+        break;
+
+    case EXCP_VNMI:
+        if ((!(hcr_el2 & HCR_IMO) && !(hcr_el2 & HCR_FMO)) ||
+             (hcr_el2 & HCR_TGE)) {
+            /* VNMIs(VIRQs or VFIQs) are only taken when hypervized.  */
+            return false;
+        }
+        return !allIntMask;
     case EXCP_FIQ:
-        pstate_unmasked = !(env->daif & PSTATE_F);
+        pstate_unmasked = (!(env->daif & PSTATE_F)) && (!allIntMask);
         break;
 
     case EXCP_IRQ:
-        pstate_unmasked = !(env->daif & PSTATE_I);
+        pstate_unmasked = (!(env->daif & PSTATE_I)) && (!allIntMask);
         break;
 
     case EXCP_VFIQ:
@@ -692,13 +719,13 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
             /* VFIQs are only taken when hypervized.  */
             return false;
         }
-        return !(env->daif & PSTATE_F);
+        return !(env->daif & PSTATE_F) && (!allIntMask);
     case EXCP_VIRQ:
         if (!(hcr_el2 & HCR_IMO) || (hcr_el2 & HCR_TGE)) {
             /* VIRQs are only taken when hypervized.  */
             return false;
         }
-        return !(env->daif & PSTATE_I);
+        return !(env->daif & PSTATE_I) && (!allIntMask);
     case EXCP_VSERR:
         if (!(hcr_el2 & HCR_AMO) || (hcr_el2 & HCR_TGE)) {
             /* VIRQs are only taken when hypervized.  */
@@ -804,6 +831,24 @@ static bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 
     /* The prioritization of interrupts is IMPLEMENTATION DEFINED. */
 
+    if (cpu_isar_feature(aa64_nmi, env_archcpu(env))) {
+        if (interrupt_request & CPU_INTERRUPT_NMI) {
+            excp_idx = EXCP_NMI;
+            target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
+            if (arm_excp_unmasked(cs, excp_idx, target_el,
+                                  cur_el, secure, hcr_el2)) {
+                goto found;
+            }
+        }
+        if (interrupt_request & CPU_INTERRUPT_VNMI) {
+            excp_idx = EXCP_VNMI;
+            target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
+            if (arm_excp_unmasked(cs, excp_idx, target_el,
+                                  cur_el, secure, hcr_el2)) {
+                goto found;
+            }
+        }
+    }
     if (interrupt_request & CPU_INTERRUPT_FIQ) {
         excp_idx = EXCP_FIQ;
         target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
@@ -900,6 +945,31 @@ void arm_cpu_update_vfiq(ARMCPU *cpu)
     }
 }
 
+void arm_cpu_update_vnmi(ARMCPU *cpu)
+{
+    /*
+     * Update the interrupt level for VNMI, which is the logical OR of
+     * the HCRX_EL2.VINMI or HCRX_EL2.VFNMI bit and the input line level from
+     * the GIC.
+     */
+    CPUARMState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+
+    bool new_state = ((env->cp15.hcr_el2 & HCR_VI) &&
+                      (env->cp15.hcrx_el2 & HCRX_VINMI)) ||
+                     ((env->cp15.hcr_el2 & HCR_VF) &&
+                      (env->cp15.hcrx_el2 & HCRX_VFNMI)) ||
+        (env->irq_line_state & CPU_INTERRUPT_VNMI);
+
+    if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VNMI) != 0)) {
+        if (new_state) {
+            cpu_interrupt(cs, CPU_INTERRUPT_VNMI);
+        } else {
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_VNMI);
+        }
+    }
+}
+
 void arm_cpu_update_vserr(ARMCPU *cpu)
 {
     /*
@@ -929,7 +999,9 @@ static void arm_cpu_set_irq(void *opaque, int irq, int level)
         [ARM_CPU_IRQ] = CPU_INTERRUPT_HARD,
         [ARM_CPU_FIQ] = CPU_INTERRUPT_FIQ,
         [ARM_CPU_VIRQ] = CPU_INTERRUPT_VIRQ,
-        [ARM_CPU_VFIQ] = CPU_INTERRUPT_VFIQ
+        [ARM_CPU_VFIQ] = CPU_INTERRUPT_VFIQ,
+        [ARM_CPU_NMI] = CPU_INTERRUPT_NMI,
+        [ARM_CPU_VNMI] = CPU_INTERRUPT_VNMI
     };
 
     if (!arm_feature(env, ARM_FEATURE_EL2) &&
@@ -955,8 +1027,12 @@ static void arm_cpu_set_irq(void *opaque, int irq, int level)
     case ARM_CPU_VFIQ:
         arm_cpu_update_vfiq(cpu);
         break;
+    case ARM_CPU_VNMI:
+        arm_cpu_update_vnmi(cpu);
+        break;
     case ARM_CPU_IRQ:
     case ARM_CPU_FIQ:
+    case ARM_CPU_NMI:
         if (level) {
             cpu_interrupt(cs, mask[irq]);
         } else {
@@ -1355,7 +1431,7 @@ static void arm_cpu_initfn(Object *obj)
          */
         qdev_init_gpio_in(DEVICE(cpu), arm_cpu_kvm_set_irq, 4);
     } else {
-        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_set_irq, 4);
+        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_set_irq, 6);
     }
 
     qdev_init_gpio_out(DEVICE(cpu), cpu->gt_timer_outputs,
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index abb453f733..6aa9f1e9ba 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -60,6 +60,8 @@
 #define EXCP_DIVBYZERO      23   /* v7M DIVBYZERO UsageFault */
 #define EXCP_VSERR          24
 #define EXCP_GPC            25   /* v9 Granule Protection Check Fault */
+#define EXCP_NMI            26
+#define EXCP_VNMI           27
 /* NB: add new EXCP_ defines to the array in arm_log_exception() too */
 
 #define ARMV7M_EXCP_RESET   1
@@ -79,6 +81,8 @@
 #define CPU_INTERRUPT_VIRQ  CPU_INTERRUPT_TGT_EXT_2
 #define CPU_INTERRUPT_VFIQ  CPU_INTERRUPT_TGT_EXT_3
 #define CPU_INTERRUPT_VSERR CPU_INTERRUPT_TGT_INT_0
+#define CPU_INTERRUPT_NMI   CPU_INTERRUPT_TGT_EXT_4
+#define CPU_INTERRUPT_VNMI  CPU_INTERRUPT_TGT_EXT_0
 
 /* The usual mapping for an AArch64 system register to its AArch32
  * counterpart is for the 32 bit world to have access to the lower
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 497b6e4bdf..4b4c8e279d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10628,6 +10628,8 @@ void arm_log_exception(CPUState *cs)
             [EXCP_DIVBYZERO] = "v7M DIVBYZERO UsageFault",
             [EXCP_VSERR] = "Virtual SERR",
             [EXCP_GPC] = "Granule Protection Check",
+            [EXCP_NMI] = "NMI",
+            [EXCP_VNMI] = "Virtual NMI"
         };
 
         if (idx >= 0 && idx < ARRAY_SIZE(excnames)) {
diff --git a/target/arm/internals.h b/target/arm/internals.h
index fee65caba5..4ff19b1b44 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -958,6 +958,16 @@ void arm_cpu_update_virq(ARMCPU *cpu);
  */
 void arm_cpu_update_vfiq(ARMCPU *cpu);
 
+/**
+ * arm_cpu_update_vnmi: Update CPU_INTERRUPT_VNMI bit in cs->interrupt_request
+ *
+ * Update the CPU_INTERRUPT_VNMI bit in cs->interrupt_request, following
+ * a change to either the input VNMI line from the GIC or the HCRX_EL2.VINMI
+ * or the HCRX_EL2.VFNMI.
+ * Must be called with the BQL held.
+ */
+void arm_cpu_update_vnmi(ARMCPU *cpu);
+
 /**
  * arm_cpu_update_vserr: Update CPU_INTERRUPT_VSERR bit
  *
-- 
2.34.1


