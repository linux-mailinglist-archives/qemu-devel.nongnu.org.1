Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1136A72ABC6
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:36:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yhW-0004eJ-IM; Sat, 10 Jun 2023 09:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhT-0004cv-LA; Sat, 10 Jun 2023 09:32:15 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhR-0007cg-Ik; Sat, 10 Jun 2023 09:32:14 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-39c4c3da9cbso1232298b6e.2; 
 Sat, 10 Jun 2023 06:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403929; x=1688995929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5vP1rEWXoGwg1otjRX1PAqUYXnIyUL9RzcsP74e8n3w=;
 b=pU20ulP+1duUTX6g/e1yIOKZQ6esFZ4pY8QJu98Uor6Jtg/SaQvgnaljQ8TZPHB1sw
 iA/J0Rdsmi1/IzWVBdPdRnQl+0rKRRWADpi3d4cYmJ4aCmzes0QABdNHF4BxmhApGiYM
 YSppcWmoO1EhUXTpLWY9tlDMwFCVgd3WmlDaQPULJ9Nf7UgJMKahG6U2971vHJGW0svS
 XDtDixYlIGQFnqWrBdVkZ7bUUS9B51VIs+gW21boIHk8iW6bv1mIpgqLnxhxuHfJXgSX
 0UMrydigEHi8sctAaOSSAqrk36QO1PwgZoqkRgE7whuQyUPmc6890+tQcUhAd3aW8Nzt
 h/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403929; x=1688995929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5vP1rEWXoGwg1otjRX1PAqUYXnIyUL9RzcsP74e8n3w=;
 b=fYmSeKVyY14X1iyKBhTqZi65HhOgTZkKIqlERvaB+H+ZBYSt+WV/YFIprudFA1Xm21
 FC1RgOn1dVsLzMQ1Ha+aKlVUpMnd8DqYOjRfk8YpRwm1X91vsHGjUfOVtjkk1moTbaZD
 9AIZG2WQP9msMDFbKQGawYVhknsAkykFUvftzXbarrxXZ3luFkEhJczPRTfskMg08SAY
 eSkLE6dwCvS+vAWcFxdutI/9VsZxP9rNShw5sIacfsZ6elY36TRdKBQSF+FBo7Jj5d5Z
 jTYXmcNRxV7LR1BA08geRJRbLy9i6FvA/HEU3gma328PSS2sZlGE6ejpH80awCkSLpao
 Oydg==
X-Gm-Message-State: AC+VfDx3hChVdUHCblhKhCa1B3U+LePdZqaPwpZllcU0cbtFrtMsmonG
 EbIIaVbjBBguqghoEPCo7JImFdmn8a4=
X-Google-Smtp-Source: ACHHUZ7++0KuaVxAmXZ1HBZSGDJ1+yCrnuzjQFbgDr5naBH1cVGFhdMQNl2B72wWuVU9/z3W8lk/7g==
X-Received: by 2002:a05:6808:189e:b0:39a:ba2f:6ea6 with SMTP id
 bi30-20020a056808189e00b0039aba2f6ea6mr1045418oib.11.1686403929726; 
 Sat, 10 Jun 2023 06:32:09 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:32:09 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 12/29] target/ppc: PMU implement PERFM interrupts
Date: Sat, 10 Jun 2023 10:31:15 -0300
Message-Id: <20230610133132.290703-13-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

The PMU raises a performance monitor exception (causing an interrupt
when MSR[EE]=1) when MMCR0[PMAO] is set, and lowers it when clear.

Wire this up and implement the interrupt delivery for books. Linux perf
record can now collect PMI-driven samples.

fire_PMC_interrupt is renamed to perfm_alert, which matches a bit closer
to the new terminology used in the ISA and distinguishes the alert
condition (e.g., counter overflow) from the PERFM (or EBB) interrupts.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20230530134313.387252-2-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/excp_helper.c |  2 +-
 target/ppc/power8-pmu.c  | 21 ++++++++++++++-------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index befa9aab7f..8b95410c36 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1543,6 +1543,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_ISEG:      /* Instruction segment exception            */
     case POWERPC_EXCP_TRACE:     /* Trace exception                          */
     case POWERPC_EXCP_SDOOR:     /* Doorbell interrupt                       */
+    case POWERPC_EXCP_PERFM:     /* Performance monitor interrupt            */
         break;
     case POWERPC_EXCP_HISI:      /* Hypervisor instruction storage exception */
         msr |= env->error_code;
@@ -1585,7 +1586,6 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
          */
         return;
     case POWERPC_EXCP_THERM:     /* Thermal interrupt                        */
-    case POWERPC_EXCP_PERFM:     /* Embedded performance monitor interrupt   */
     case POWERPC_EXCP_VPUA:      /* Vector assist exception                  */
     case POWERPC_EXCP_MAINT:     /* Maintenance exception                    */
     case POWERPC_EXCP_HV_MAINT:  /* Hypervisor Maintenance exception         */
diff --git a/target/ppc/power8-pmu.c b/target/ppc/power8-pmu.c
index af065115f2..7bb4bf81f7 100644
--- a/target/ppc/power8-pmu.c
+++ b/target/ppc/power8-pmu.c
@@ -84,8 +84,17 @@ static void pmu_update_summaries(CPUPPCState *env)
 
 void pmu_mmcr01_updated(CPUPPCState *env)
 {
+    PowerPCCPU *cpu = env_archcpu(env);
+
     pmu_update_summaries(env);
     hreg_update_pmu_hflags(env);
+
+    if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMAO) {
+        ppc_set_irq(cpu, PPC_INTERRUPT_PERFM, 1);
+    } else {
+        ppc_set_irq(cpu, PPC_INTERRUPT_PERFM, 0);
+    }
+
     /*
      * Should this update overflow timers (if mmcr0 is updated) so they
      * get set in cpu_post_load?
@@ -282,7 +291,7 @@ void helper_store_pmc(CPUPPCState *env, uint32_t sprn, uint64_t value)
     pmc_update_overflow_timer(env, sprn);
 }
 
-static void fire_PMC_interrupt(PowerPCCPU *cpu)
+static void perfm_alert(PowerPCCPU *cpu)
 {
     CPUPPCState *env = &cpu->env;
 
@@ -306,6 +315,7 @@ static void fire_PMC_interrupt(PowerPCCPU *cpu)
         /* These MMCR0 bits do not require summaries or hflags update. */
         env->spr[SPR_POWER_MMCR0] &= ~MMCR0_PMAE;
         env->spr[SPR_POWER_MMCR0] |= MMCR0_PMAO;
+        ppc_set_irq(cpu, PPC_INTERRUPT_PERFM, 1);
     }
 
     raise_ebb_perfm_exception(env);
@@ -314,20 +324,17 @@ static void fire_PMC_interrupt(PowerPCCPU *cpu)
 void helper_handle_pmc5_overflow(CPUPPCState *env)
 {
     env->spr[SPR_POWER_PMC5] = PMC_COUNTER_NEGATIVE_VAL;
-    fire_PMC_interrupt(env_archcpu(env));
+    perfm_alert(env_archcpu(env));
 }
 
 /* This helper assumes that the PMC is running. */
 void helper_insns_inc(CPUPPCState *env, uint32_t num_insns)
 {
     bool overflow_triggered;
-    PowerPCCPU *cpu;
 
     overflow_triggered = pmu_increment_insns(env, num_insns);
-
     if (overflow_triggered) {
-        cpu = env_archcpu(env);
-        fire_PMC_interrupt(cpu);
+        perfm_alert(env_archcpu(env));
     }
 }
 
@@ -335,7 +342,7 @@ static void cpu_ppc_pmu_timer_cb(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
 
-    fire_PMC_interrupt(cpu);
+    perfm_alert(cpu);
 }
 
 void cpu_ppc_pmu_init(CPUPPCState *env)
-- 
2.40.1


