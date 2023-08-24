Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB97A786BD8
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:29:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6ee-00070C-HD; Thu, 24 Aug 2023 05:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6eR-0006J4-0J
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:29:15 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6eA-00052S-M1
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:29:07 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4018af1038cso2833915e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869334; x=1693474134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mDaX+a4l06xKdJMZ3Tp/MaphcENrSP7ODugLAJhWYRI=;
 b=halsMds3qUNg57SXxi/WTLu8Au3JXlLKDCtVNhotF/yUMq9lLg4BYhQJcnzr0OVPZE
 +sAPeCGUo/IKVbOxMbCKch0q+4EEa/NQLGkB/ec0djrG0k4ctYLGsReDCBjRPD/5/4o1
 pX6/njERiCd2PmrmBRaV2fYzf9kR4RRg/fhf67SyszTyFUDYIpQfTlhOUgRhBacqraqU
 8Ol1D2Z1I7aSEa/JWqLCWWtJfXC7AiVP1/lTujQnL/GlUS0IT5fZ3J8UGL2nReR3Q5V+
 zYVuq+TDyjrbnaBMKs74lZC9bgW4bm09MwdxkbSoTIiUaALbkCKpllCJaFps5p93YXHe
 cTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869334; x=1693474134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mDaX+a4l06xKdJMZ3Tp/MaphcENrSP7ODugLAJhWYRI=;
 b=eR8uLXPaCoYF3pT3XO4YYqhnzRuNhTq8Kso2Bh4UBD2n4/M73ZqrJfIPCvjIwpA42w
 7F5SIwMUSwyHFQ0LMLQ9f3ldI5IW3w2VTMgReGeS07rlkTvYAvIFXxZEpbua+P+8zHHD
 Lz40NeqqV+IwOW3lLUqwsUZESpVvVO2cQdNV3lTUGNjh+NSCh8kDSivR86rCWJzbAkIh
 pslRp9pOvYPYnxogapaP+KQwUt0z5AO6Ntcz1ze1zZQpp5EaRDzzV8gKiI3GolwDfZx+
 /btT8YXVqccM8luXpcVp+uJHdLabXd5YJH834F/bPJMp6cVUYzZqMgj98XZiw0NX9jYl
 kXoA==
X-Gm-Message-State: AOJu0Yz5vhr9kyymPOKujf9LSbjSb+aovB9yspwypfOAkQRMpEcX1oR5
 ghl9E3XjUrDOIWhE65Mrh91uWE+es5JbHL8BI7I=
X-Google-Smtp-Source: AGHT+IHtQ6XzBS1q6gcIOY0Ow+MHQ0om2PDBV4YgJ/3hfmv3wGtwat7W/NurYNZg2Bbd7scngTBF+w==
X-Received: by 2002:a7b:cd0d:0:b0:401:7d3b:ccaf with SMTP id
 f13-20020a7bcd0d000000b004017d3bccafmr811202wmj.4.1692869334079; 
 Thu, 24 Aug 2023 02:28:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/35] target/arm/helper: Implement CNTHCTL_EL2.CNT[VP]MASK
Date: Thu, 24 Aug 2023 10:28:34 +0100
Message-Id: <20230824092836.2239644-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

When FEAT_RME is implemented, these bits override the value of
CNT[VP]_CTL_EL0.IMASK in Realm and Root state. Move the IRQ state update
into a new gt_update_irq() function and test those bits every time we
recompute the IRQ state.

Since we're removing the IRQ state from some trace events, add a new
trace event for gt_update_irq().

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-id: 20230809123706.1842548-7-jean-philippe@linaro.org
[PMM: only register change hook if not USER_ONLY and if TCG]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h        |  4 +++
 target/arm/cpu.c        |  6 ++++
 target/arm/helper.c     | 65 ++++++++++++++++++++++++++++++++++-------
 target/arm/trace-events |  7 +++--
 4 files changed, 68 insertions(+), 14 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 02bc8f0e8e0..cdf8600b96a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1115,6 +1115,7 @@ struct ArchCPU {
 };
 
 unsigned int gt_cntfrq_period_ns(ARMCPU *cpu);
+void gt_rme_post_el_change(ARMCPU *cpu, void *opaque);
 
 void arm_cpu_post_init(Object *obj);
 
@@ -1743,6 +1744,9 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define HSTR_TTEE (1 << 16)
 #define HSTR_TJDBX (1 << 17)
 
+#define CNTHCTL_CNTVMASK      (1 << 18)
+#define CNTHCTL_CNTPMASK      (1 << 19)
+
 /* Return the current FPSCR value.  */
 uint32_t vfp_get_fpscr(CPUARMState *env);
 void vfp_set_fpscr(CPUARMState *env, uint32_t val);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 93c28d50e58..d906d2b1caa 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2169,6 +2169,12 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         set_feature(env, ARM_FEATURE_VBAR);
     }
 
+#ifndef CONFIG_USER_ONLY
+    if (tcg_enabled() && cpu_isar_feature(aa64_rme, cpu)) {
+        arm_register_el_change_hook(cpu, &gt_rme_post_el_change, 0);
+    }
+#endif
+
     register_cp_regs_for_features(cpu);
     arm_cpu_register_gdb_regs_for_features(cpu);
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b4618ee2b95..85291d5b8e2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2608,6 +2608,39 @@ static uint64_t gt_get_countervalue(CPUARMState *env)
     return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / gt_cntfrq_period_ns(cpu);
 }
 
+static void gt_update_irq(ARMCPU *cpu, int timeridx)
+{
+    CPUARMState *env = &cpu->env;
+    uint64_t cnthctl = env->cp15.cnthctl_el2;
+    ARMSecuritySpace ss = arm_security_space(env);
+    /* ISTATUS && !IMASK */
+    int irqstate = (env->cp15.c14_timer[timeridx].ctl & 6) == 4;
+
+    /*
+     * If bit CNTHCTL_EL2.CNT[VP]MASK is set, it overrides IMASK.
+     * It is RES0 in Secure and NonSecure state.
+     */
+    if ((ss == ARMSS_Root || ss == ARMSS_Realm) &&
+        ((timeridx == GTIMER_VIRT && (cnthctl & CNTHCTL_CNTVMASK)) ||
+         (timeridx == GTIMER_PHYS && (cnthctl & CNTHCTL_CNTPMASK)))) {
+        irqstate = 0;
+    }
+
+    qemu_set_irq(cpu->gt_timer_outputs[timeridx], irqstate);
+    trace_arm_gt_update_irq(timeridx, irqstate);
+}
+
+void gt_rme_post_el_change(ARMCPU *cpu, void *ignored)
+{
+    /*
+     * Changing security state between Root and Secure/NonSecure, which may
+     * happen when switching EL, can change the effective value of CNTHCTL_EL2
+     * mask bits. Update the IRQ state accordingly.
+     */
+    gt_update_irq(cpu, GTIMER_VIRT);
+    gt_update_irq(cpu, GTIMER_PHYS);
+}
+
 static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
 {
     ARMGenericTimer *gt = &cpu->env.cp15.c14_timer[timeridx];
@@ -2623,13 +2656,9 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
         /* Note that this must be unsigned 64 bit arithmetic: */
         int istatus = count - offset >= gt->cval;
         uint64_t nexttick;
-        int irqstate;
 
         gt->ctl = deposit32(gt->ctl, 2, 1, istatus);
 
-        irqstate = (istatus && !(gt->ctl & 2));
-        qemu_set_irq(cpu->gt_timer_outputs[timeridx], irqstate);
-
         if (istatus) {
             /* Next transition is when count rolls back over to zero */
             nexttick = UINT64_MAX;
@@ -2648,14 +2677,14 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
         } else {
             timer_mod(cpu->gt_timer[timeridx], nexttick);
         }
-        trace_arm_gt_recalc(timeridx, irqstate, nexttick);
+        trace_arm_gt_recalc(timeridx, nexttick);
     } else {
         /* Timer disabled: ISTATUS and timer output always clear */
         gt->ctl &= ~4;
-        qemu_set_irq(cpu->gt_timer_outputs[timeridx], 0);
         timer_del(cpu->gt_timer[timeridx]);
         trace_arm_gt_recalc_disabled(timeridx);
     }
+    gt_update_irq(cpu, timeridx);
 }
 
 static void gt_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -2759,10 +2788,8 @@ static void gt_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
          * IMASK toggled: don't need to recalculate,
          * just set the interrupt line based on ISTATUS
          */
-        int irqstate = (oldval & 4) && !(value & 2);
-
-        trace_arm_gt_imask_toggle(timeridx, irqstate);
-        qemu_set_irq(cpu->gt_timer_outputs[timeridx], irqstate);
+        trace_arm_gt_imask_toggle(timeridx);
+        gt_update_irq(cpu, timeridx);
     }
 }
 
@@ -2888,6 +2915,21 @@ static void gt_virt_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
     gt_ctl_write(env, ri, GTIMER_VIRT, value);
 }
 
+static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    ARMCPU *cpu = env_archcpu(env);
+    uint32_t oldval = env->cp15.cnthctl_el2;
+
+    raw_write(env, ri, value);
+
+    if ((oldval ^ value) & CNTHCTL_CNTVMASK) {
+        gt_update_irq(cpu, GTIMER_VIRT);
+    } else if ((oldval ^ value) & CNTHCTL_CNTPMASK) {
+        gt_update_irq(cpu, GTIMER_PHYS);
+    }
+}
+
 static void gt_cntvoff_write(CPUARMState *env, const ARMCPRegInfo *ri,
                               uint64_t value)
 {
@@ -6203,7 +6245,8 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
        * reset values as IMPDEF. We choose to reset to 3 to comply with
        * both ARMv7 and ARMv8.
        */
-      .access = PL2_RW, .resetvalue = 3,
+      .access = PL2_RW, .type = ARM_CP_IO, .resetvalue = 3,
+      .writefn = gt_cnthctl_write, .raw_writefn = raw_write,
       .fieldoffset = offsetof(CPUARMState, cp15.cnthctl_el2) },
     { .name = "CNTVOFF_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 0, .opc2 = 3,
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 2a0ba7bffc1..48cc0512dbe 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -1,13 +1,14 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
 # helper.c
-arm_gt_recalc(int timer, int irqstate, uint64_t nexttick) "gt recalc: timer %d irqstate %d next tick 0x%" PRIx64
-arm_gt_recalc_disabled(int timer) "gt recalc: timer %d irqstate 0 timer disabled"
+arm_gt_recalc(int timer, uint64_t nexttick) "gt recalc: timer %d next tick 0x%" PRIx64
+arm_gt_recalc_disabled(int timer) "gt recalc: timer %d timer disabled"
 arm_gt_cval_write(int timer, uint64_t value) "gt_cval_write: timer %d value 0x%" PRIx64
 arm_gt_tval_write(int timer, uint64_t value) "gt_tval_write: timer %d value 0x%" PRIx64
 arm_gt_ctl_write(int timer, uint64_t value) "gt_ctl_write: timer %d value 0x%" PRIx64
-arm_gt_imask_toggle(int timer, int irqstate) "gt_ctl_write: timer %d IMASK toggle, new irqstate %d"
+arm_gt_imask_toggle(int timer) "gt_ctl_write: timer %d IMASK toggle"
 arm_gt_cntvoff_write(uint64_t value) "gt_cntvoff_write: value 0x%" PRIx64
+arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
 
 # kvm.c
 kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
-- 
2.34.1


