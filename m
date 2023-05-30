Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9478171626C
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:44:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zdl-0003HM-RW; Tue, 30 May 2023 09:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3zdQ-0002rt-9x; Tue, 30 May 2023 09:43:36 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3zdO-0007HI-Gs; Tue, 30 May 2023 09:43:36 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-25665d2a8bdso1634892a91.0; 
 Tue, 30 May 2023 06:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685454212; x=1688046212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=64PutwNoGX+k9rIrPEItAJ+9u/E0ZfRZtyC7k0jHFxw=;
 b=MiaNKf9JLNhouqDj+ZbIt1jH23s6+BG7P0TFmae/ZOJhVFQfs1hkaygvxKF2sgMHlv
 ui0BCoHzovjO5uIq8cPPxj/882aBBGx9FK3tXvbMvQbkFYifOAO5p9ckbwiLWiFaAphk
 M9kUjmTl0wJ/kcdGLiWEtYlU6yn9+hvt+GXq5uVTKDQXqDkfRtTg67wscomxIVmYVcJ6
 Iqg93DIDiAGvz2/nv2doKLHkbGJ/EaMlzQg8NRilFQRDndEtHX8XqypAFtbXqIe+JRCB
 EyZvDYHpDkubVLTVOXfVcrMtIDqjFXk3R+rQwLhxV1Heqonw98q0Juq3S9qUYfSPLi5+
 EgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685454212; x=1688046212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=64PutwNoGX+k9rIrPEItAJ+9u/E0ZfRZtyC7k0jHFxw=;
 b=TU0UblOHhA+E29Kl6YwnBkK+MNVK8YRsBhlu4L0Ef8IY/4CA3xDc7T9/b3n3RsAO9r
 wgsq16eL+ch0CZq6F3s4dd9z64mY/0AElafOPjbdEjJLzXjYP0Zx5tbaTuQjdSjwiBqw
 mLvbTeynyKoLgDw55Bkb+VdFNPBlL1LLd4XlCzq//qHVBRb9axJS9/qmzN23EbQEpq48
 Y6jaIpZElq9uRPn54IqNenzCflY0XDBRhSjIhAEGkOdUdjllnqWEBRIlKaYxfxkwga6y
 F0Rbly7283O08NInpEKs4KThtQbipdl0QrwMlbNWJV7Y+/S8QzUPpP29Rc+aGf7VvG34
 mfGQ==
X-Gm-Message-State: AC+VfDxDpyMsQAA4Tzhhj+UudG6LwZbOckZWGw6bieP2d0fR3oUY2fcF
 9AVad2az78myTQs76CUwGyW3aAUT/ak=
X-Google-Smtp-Source: ACHHUZ6rrrxB8Ybl8evSnmg4nqpqrJtCy40Uuh+9lBrzL7FBR2V7FadSPaZdYuarkcVOj6k4u91mfw==
X-Received: by 2002:a17:90a:c78c:b0:256:47f3:73d3 with SMTP id
 gn12-20020a17090ac78c00b0025647f373d3mr2473821pjb.29.1685454212349; 
 Tue, 30 May 2023 06:43:32 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 s3-20020a170902a50300b001ab12ccc2a7sm10314568plq.98.2023.05.30.06.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:43:31 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH v1 2/2] target/ppc: PMU implement PERFM interrupts
Date: Tue, 30 May 2023 23:43:13 +1000
Message-Id: <20230530134313.387252-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530134313.387252-1-npiggin@gmail.com>
References: <20230530134313.387252-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The PMU raises a performance monitor exception (causing an interrupt
when MSR[EE]=1) when MMCR0[PMAO] is set, and lowers it when clear.

Wire this up and implement the interrupt delivery for books. Linux perf
record can now collect PMI-driven samples.

fire_PMC_interrupt is renamed to perfm_alert, which matches a bit closer
to the new terminology used in the ISA and distinguishes the alert
condition (e.g., counter overflow) from the PERFM (or EBB) interrupts.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c |  2 +-
 target/ppc/power8-pmu.c  | 20 +++++++++++++-------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 0f7ed58673..4925996cf3 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1611,6 +1611,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_ISEG:      /* Instruction segment exception            */
     case POWERPC_EXCP_TRACE:     /* Trace exception                          */
     case POWERPC_EXCP_SDOOR:     /* Doorbell interrupt                       */
+    case POWERPC_EXCP_PERFM:     /* Performance monitor interrupt            */
         break;
     case POWERPC_EXCP_HISI:      /* Hypervisor instruction storage exception */
         msr |= env->error_code;
@@ -1664,7 +1665,6 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
          */
         return;
     case POWERPC_EXCP_THERM:     /* Thermal interrupt                        */
-    case POWERPC_EXCP_PERFM:     /* Embedded performance monitor interrupt   */
     case POWERPC_EXCP_VPUA:      /* Vector assist exception                  */
     case POWERPC_EXCP_MAINT:     /* Maintenance exception                    */
     case POWERPC_EXCP_HV_MAINT:  /* Hypervisor Maintenance exception         */
diff --git a/target/ppc/power8-pmu.c b/target/ppc/power8-pmu.c
index af065115f2..48f2868f8b 100644
--- a/target/ppc/power8-pmu.c
+++ b/target/ppc/power8-pmu.c
@@ -84,8 +84,16 @@ static void pmu_update_summaries(CPUPPCState *env)
 
 void pmu_mmcr01_updated(CPUPPCState *env)
 {
+    PowerPCCPU *cpu = env_archcpu(env);
+
     pmu_update_summaries(env);
     hreg_update_pmu_hflags(env);
+
+    if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMAO)
+        ppc_set_irq(cpu, PPC_INTERRUPT_PERFM, 1);
+    else
+        ppc_set_irq(cpu, PPC_INTERRUPT_PERFM, 0);
+
     /*
      * Should this update overflow timers (if mmcr0 is updated) so they
      * get set in cpu_post_load?
@@ -282,7 +290,7 @@ void helper_store_pmc(CPUPPCState *env, uint32_t sprn, uint64_t value)
     pmc_update_overflow_timer(env, sprn);
 }
 
-static void fire_PMC_interrupt(PowerPCCPU *cpu)
+static void perfm_alert(PowerPCCPU *cpu)
 {
     CPUPPCState *env = &cpu->env;
 
@@ -306,6 +314,7 @@ static void fire_PMC_interrupt(PowerPCCPU *cpu)
         /* These MMCR0 bits do not require summaries or hflags update. */
         env->spr[SPR_POWER_MMCR0] &= ~MMCR0_PMAE;
         env->spr[SPR_POWER_MMCR0] |= MMCR0_PMAO;
+        ppc_set_irq(cpu, PPC_INTERRUPT_PERFM, 1);
     }
 
     raise_ebb_perfm_exception(env);
@@ -314,20 +323,17 @@ static void fire_PMC_interrupt(PowerPCCPU *cpu)
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
 
@@ -335,7 +341,7 @@ static void cpu_ppc_pmu_timer_cb(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
 
-    fire_PMC_interrupt(cpu);
+    perfm_alert(cpu);
 }
 
 void cpu_ppc_pmu_init(CPUPPCState *env)
-- 
2.40.1


