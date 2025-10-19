Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D786BEE88C
	for <lists+qemu-devel@lfdr.de>; Sun, 19 Oct 2025 17:19:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAV97-0001vU-ND; Sun, 19 Oct 2025 11:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAV91-0001uY-Oc
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:16:28 -0400
Received: from mailgate01.uberspace.is ([95.143.172.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAV90-0003Aa-32
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:16:27 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 0AE1F60A6C
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 17:16:25 +0200 (CEST)
Received: (qmail 22893 invoked by uid 990); 19 Oct 2025 15:16:24 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 19 Oct 2025 17:16:20 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH v8 06/25] target/arm: call plugin trap callbacks
Date: Sun, 19 Oct 2025 17:14:55 +0200
Message-ID: <57010cfd617c50a0d539d7d69b2ef5c891f2f360.1760884672.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1760884672.git.neither@nut.email>
References: <cover.1760884672.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999999) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.599999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=eTrUncCA6C2WPlUgxKZyYZpPBpx50vqDZF2D9sdp358=;
 b=pdsX6meunpR1mlv3GZWlKkcnPiZVp00qMihKqdzhYftImRoJ9MKoGLYnWZkst8RN9Y5lvmZ+Sk
 WFqO43NpafuKD9JGAD0WUO9N80qbu6dns90F+fVzOOVLwbRDZe8k5lMxoOM73nkkqVybfvLjl/6V
 s/oafSILhXAcyzFJq5BzNqGSrtyfht7AwvbrltV714Z40ZIkaqIXd9NrKeT/H0AWJ9QutAJwIRj7
 AW98oS9nHjZZlxyymXrH/LHgEkwDgDW2ywcvzi5Xey6+4037cDggtTWVCm3x8Q3jXKRHym5MpDVi
 sVl0ABWC9Yym84Wdr0M/Qi4+Dj6pnjutTI5RkrRxBikbUbh4VaLht/dJPoWvsutzhGZEmXdS1oWk
 RNWOX1wjhvyuQnzzHUGhOgDd+W7YLwtYPUvZZh0vMGa+pQWOZe7gx7jKl+n/DiBV5ityOBfIGjiq
 T/LGF6le1M8WEvlbrJTiK0eN/oRZdFOIQxY67f/yG7YStoUa/Vr2E9r1Bu5tPMaskbIM1x4rC/ZE
 IIEsmFWQtNLFPMuQ4TDE2H2mRtixVOGbnLKl7G/SmzgqObnTMJGI99Z9lVUJkWmFJipmFq+NpBDM
 yYiKTA/vh9YAkgA7fw/MvHOmAO90e4aoGidU2gPfXeePDUoCD1psukMqt5Z577jNS6DuoSk0pAgd
 Y=
Received-SPF: pass client-ip=95.143.172.20; envelope-from=neither@nut.email;
 helo=mailgate01.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places hooks for ARM (and Aarch64) targets. We decided to
treat the (V)IRQ, (VI/VF)NMI, (V)FIQ and VSERR exceptions as interrupts
since they are, presumably, async in nature.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/arm/helper.c       | 24 ++++++++++++++++++++++++
 target/arm/internals.h    |  1 +
 target/arm/tcg/m_helper.c |  5 +++++
 3 files changed, 30 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 167f2909b3..c30d77bee9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -34,6 +34,7 @@
 #endif
 #include "cpregs.h"
 #include "target/arm/gtimer.h"
+#include "qemu/plugin.h"
 
 #define HELPER_H "tcg/helper.h"
 #include "exec/helper-proto.h.inc"
@@ -8715,6 +8716,24 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
     }
 }
 
+void arm_do_plugin_vcpu_discon_cb(CPUState *cs, uint64_t from)
+{
+    switch (cs->exception_index) {
+    case EXCP_IRQ:
+    case EXCP_VIRQ:
+    case EXCP_NMI:
+    case EXCP_VINMI:
+    case EXCP_FIQ:
+    case EXCP_VFIQ:
+    case EXCP_VFNMI:
+    case EXCP_VSERR:
+        qemu_plugin_vcpu_interrupt_cb(cs, from);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, from);
+    }
+}
+
 static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
 {
     /*
@@ -9405,6 +9424,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     unsigned int new_el = env->exception.target_el;
+    uint64_t last_pc = cs->cc->get_pc(cs);
 
     assert(!arm_feature(env, ARM_FEATURE_M));
 
@@ -9421,6 +9441,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
     if (tcg_enabled() && arm_is_psci_call(cpu, cs->exception_index)) {
         arm_handle_psci_call(cpu);
         qemu_log_mask(CPU_LOG_INT, "...handled as PSCI call\n");
+        qemu_plugin_vcpu_hostcall_cb(cs, last_pc);
         return;
     }
 
@@ -9432,6 +9453,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
 #ifdef CONFIG_TCG
     if (cs->exception_index == EXCP_SEMIHOST) {
         tcg_handle_semihosting(cs);
+        qemu_plugin_vcpu_hostcall_cb(cs, last_pc);
         return;
     }
 #endif
@@ -9457,6 +9479,8 @@ void arm_cpu_do_interrupt(CPUState *cs)
     if (!kvm_enabled()) {
         cpu_set_interrupt(cs, CPU_INTERRUPT_EXITTB);
     }
+
+    arm_do_plugin_vcpu_discon_cb(cs, last_pc);
 }
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index f539bbe58e..6be044b29d 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -375,6 +375,7 @@ static inline int r14_bank_number(int mode)
 
 void arm_cpu_register(const ARMCPUInfo *info);
 
+void arm_do_plugin_vcpu_discon_cb(CPUState *cs, uint64_t from);
 void register_cp_regs_for_features(ARMCPU *cpu);
 void init_cpreg_list(ARMCPU *cpu);
 
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index d856e3bc8e..3fb24c7790 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -23,6 +23,7 @@
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/intc/armv7m_nvic.h"
 #endif
+#include "qemu/plugin.h"
 
 static void v7m_msr_xpsr(CPUARMState *env, uint32_t mask,
                          uint32_t reg, uint32_t val)
@@ -2194,6 +2195,7 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
     CPUARMState *env = &cpu->env;
     uint32_t lr;
     bool ignore_stackfaults;
+    uint64_t last_pc = env->regs[15];
 
     arm_log_exception(cs);
 
@@ -2361,6 +2363,7 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
         g_assert_not_reached();
 #endif
         env->regs[15] += env->thumb ? 2 : 4;
+        qemu_plugin_vcpu_hostcall_cb(cs, last_pc);
         return;
     case EXCP_BKPT:
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_DEBUG, false);
@@ -2427,6 +2430,8 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
 
     ignore_stackfaults = v7m_push_stack(cpu);
     v7m_exception_taken(cpu, lr, false, ignore_stackfaults);
+
+    arm_do_plugin_vcpu_discon_cb(cs, last_pc);
 }
 
 uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
-- 
2.49.1


