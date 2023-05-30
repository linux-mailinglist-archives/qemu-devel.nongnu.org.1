Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A081716110
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:06:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3z2C-00055l-J0; Tue, 30 May 2023 09:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3z26-00054N-0S; Tue, 30 May 2023 09:05:02 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3z22-0002AU-Ho; Tue, 30 May 2023 09:05:00 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-64d2a613ec4so3193483b3a.1; 
 Tue, 30 May 2023 06:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685451896; x=1688043896;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3B79jnozX24XnPT6EsO7VVe3TOCmoEvYe7Xc4k3sk4s=;
 b=GGNPeCl2etQb9+N5l9p1XZQOuAh5PZkaLb1/RjAa5vW1VT72Fvsy6zhiM5BKX9JwyM
 8pj19od2dORy8OJo2dF7J+GzOKf2MA5iBsDc3tDba+GKypdlkK/JsYsxE73rDyeex42P
 q7ETl4ZmWpIMSssh5QtVJVsdGgDHuJhD3oFFJWyeKN103CKIJ5oHb3XWdfEIY9+7gD3+
 NKjEa4I1tJrut2rj3c/iR7ik6x66y53Uu0K8z+KhpFyY2U2G2BQoLsgelq8NZrlqzGa1
 JFaQNiZcIQTCKjBRGzEPVAU3pm8jILTRjkeWbaBeMLeb7vtUcL30eKfBeb+FEW9Sl83a
 EibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685451896; x=1688043896;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3B79jnozX24XnPT6EsO7VVe3TOCmoEvYe7Xc4k3sk4s=;
 b=XT9qALfdzWdMAu5VTugdVn19Oqqr21B1ZBd4B20kT8mb8X5I5NVeGA5rhHlrTcTsgA
 JpVT5B9Tz8KLNAf8cfxFF5Id7wJx2q3MmDj53YC87VL5oHs1a9bWx/0MoLhu+hqG3RtY
 PO5eLCVbGYmyLSM+A+4QFZNvjnYipR0iqsWSUhhh7GtPtEqW2mIcPLHYDjdt9Jj8k/CM
 2ny7oHqwrOeh2/G1mbcg5xO+I/WcNfxN1Z+8q36jrl1KBkyxRtVWdYrrJ6sanD9yYecn
 Zebl1W/+fGdL5BE3K2RdpnwnRnh+7qBfI5hmSj0nvTiwcjA4ejx5Cs1NEtC6jHKlzPWS
 lRqg==
X-Gm-Message-State: AC+VfDwlyW9Pc3GJ2Vcq+A4PE6q7xDmXuuGuv5sSMCEpDqSppFy2J7uT
 bjGSLjBSk5PEyUDXJr/a2OYCM7ZrChc=
X-Google-Smtp-Source: ACHHUZ7W3J5VM+Sqlis5DvmXk0Er0/CPMGT1U0EKPQTnUMskvNTpW7UfFs4afKSz7ja85SmOaF5FbQ==
X-Received: by 2002:a17:902:e844:b0:1b0:36b5:dd6c with SMTP id
 t4-20020a170902e84400b001b036b5dd6cmr2592882plg.26.1685451895498; 
 Tue, 30 May 2023 06:04:55 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 k18-20020a170902761200b0019309be03e7sm10229158pll.66.2023.05.30.06.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:04:54 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4] target/ppc: Fix PMU hflags calculation
Date: Tue, 30 May 2023 23:04:47 +1000
Message-Id: <20230530130447.372617-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

Some of the PMU hflags bits can go out of synch, for example a store to
MMCR0 with PMCjCE=1 fails to update hflags correctly and results in
hflags mismatch:

  qemu: fatal: TCG hflags mismatch (current:0x2408003d rebuilt:0x240a003d)

This can be reproduced by running perf on a recent machine.

Some of the fragility here is the duplication of PMU hflags calculations.
This change consolidates that in a single place to update pmu-related
hflags, to be called after a well defined state changes.

The post-load PMU update is pulled out of the MSR update because it does
not depend on the MSR value.

Fixes: 8b3d1c49a9f0 ("target/ppc: Add new PMC HFLAGS")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
This is a significant rework from v3, which missed a couple of hflags.
I think it's more robust.

Question came up whether we should rearm overflow timers in something
like cpu post load, but that's for a later patch.

This is probably a stable candidate but I will wait for upstream
before ccing.

Thanks,
Nick
---

 target/ppc/cpu_init.c    |  2 +-
 target/ppc/helper_regs.c | 73 ++++++++++++++++++++++++++++++----------
 target/ppc/helper_regs.h |  1 +
 target/ppc/machine.c     |  8 ++---
 target/ppc/power8-pmu.c  | 38 ++++++++++++---------
 target/ppc/power8-pmu.h  |  4 +--
 6 files changed, 85 insertions(+), 41 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 05bf73296b..398f2d9966 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7083,7 +7083,7 @@ static void ppc_cpu_reset_hold(Object *obj)
         if (env->mmu_model != POWERPC_MMU_REAL) {
             ppc_tlb_invalidate_all(env);
         }
-        pmu_update_summaries(env);
+        pmu_mmcr01_updated(env);
     }
 
     /* clean any pending stop state */
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index fb351c303f..bc7e9d7eda 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -47,6 +47,48 @@ void hreg_swap_gpr_tgpr(CPUPPCState *env)
     env->tgpr[3] = tmp;
 }
 
+static uint32_t hreg_compute_pmu_hflags_value(CPUPPCState *env)
+{
+    uint32_t hflags = 0;
+
+#if defined(TARGET_PPC64)
+    if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMCC0) {
+        hflags |= 1 << HFLAGS_PMCC0;
+    }
+    if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMCC1) {
+        hflags |= 1 << HFLAGS_PMCC1;
+    }
+    if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMCjCE) {
+        hflags |= 1 << HFLAGS_PMCJCE;
+    }
+
+#ifndef CONFIG_USER_ONLY
+    if (env->pmc_ins_cnt) {
+        hflags |= 1 << HFLAGS_INSN_CNT;
+    }
+    if (env->pmc_ins_cnt & 0x1e) {
+        hflags |= 1 << HFLAGS_PMC_OTHER;
+    }
+#endif
+#endif
+
+    return hflags;
+}
+
+/* Mask of all PMU hflags */
+static uint32_t hreg_compute_pmu_hflags_mask(CPUPPCState *env)
+{
+    uint32_t hflags_mask = 0;
+#if defined(TARGET_PPC64)
+    hflags_mask |= 1 << HFLAGS_PMCC0;
+    hflags_mask |= 1 << HFLAGS_PMCC1;
+    hflags_mask |= 1 << HFLAGS_PMCJCE;
+    hflags_mask |= 1 << HFLAGS_INSN_CNT;
+    hflags_mask |= 1 << HFLAGS_PMC_OTHER;
+#endif
+    return hflags_mask;
+}
+
 static uint32_t hreg_compute_hflags_value(CPUPPCState *env)
 {
     target_ulong msr = env->msr;
@@ -104,30 +146,12 @@ static uint32_t hreg_compute_hflags_value(CPUPPCState *env)
     if (env->spr[SPR_LPCR] & LPCR_HR) {
         hflags |= 1 << HFLAGS_HR;
     }
-    if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMCC0) {
-        hflags |= 1 << HFLAGS_PMCC0;
-    }
-    if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMCC1) {
-        hflags |= 1 << HFLAGS_PMCC1;
-    }
-    if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMCjCE) {
-        hflags |= 1 << HFLAGS_PMCJCE;
-    }
 
 #ifndef CONFIG_USER_ONLY
     if (!env->has_hv_mode || (msr & (1ull << MSR_HV))) {
         hflags |= 1 << HFLAGS_HV;
     }
 
-#if defined(TARGET_PPC64)
-    if (env->pmc_ins_cnt) {
-        hflags |= 1 << HFLAGS_INSN_CNT;
-    }
-    if (env->pmc_ins_cnt & 0x1e) {
-        hflags |= 1 << HFLAGS_PMC_OTHER;
-    }
-#endif
-
     /*
      * This is our encoding for server processors. The architecture
      * specifies that there is no such thing as userspace with
@@ -172,6 +196,8 @@ static uint32_t hreg_compute_hflags_value(CPUPPCState *env)
     hflags |= dmmu_idx << HFLAGS_DMMU_IDX;
 #endif
 
+    hflags |= hreg_compute_pmu_hflags_value(env);
+
     return hflags | (msr & msr_mask);
 }
 
@@ -180,6 +206,17 @@ void hreg_compute_hflags(CPUPPCState *env)
     env->hflags = hreg_compute_hflags_value(env);
 }
 
+/*
+ * This can be used as a lighter-weight alternative to hreg_compute_hflags
+ * when PMU MMCR0 or pmc_ins_cnt changes. pmc_ins_cnt is changed by
+ * pmu_update_summaries.
+ */
+void hreg_update_pmu_hflags(CPUPPCState *env)
+{
+    env->hflags &= ~hreg_compute_pmu_hflags_mask(env);
+    env->hflags |= hreg_compute_pmu_hflags_value(env);
+}
+
 #ifdef CONFIG_DEBUG_TCG
 void cpu_get_tb_cpu_state(CPUPPCState *env, target_ulong *pc,
                           target_ulong *cs_base, uint32_t *flags)
diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h
index 42f26870b9..8196c1346d 100644
--- a/target/ppc/helper_regs.h
+++ b/target/ppc/helper_regs.h
@@ -22,6 +22,7 @@
 
 void hreg_swap_gpr_tgpr(CPUPPCState *env);
 void hreg_compute_hflags(CPUPPCState *env);
+void hreg_update_pmu_hflags(CPUPPCState *env);
 void cpu_interrupt_exittb(CPUState *cs);
 int hreg_store_msr(CPUPPCState *env, target_ulong value, int alter_hv);
 
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index be6eb3d968..134b16c625 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -21,10 +21,6 @@ static void post_load_update_msr(CPUPPCState *env)
      */
     env->msr ^= env->msr_mask & ~((1ULL << MSR_TGPR) | MSR_HVB);
     ppc_store_msr(env, msr);
-
-    if (tcg_enabled()) {
-        pmu_update_summaries(env);
-    }
 }
 
 static int get_avr(QEMUFile *f, void *pv, size_t size,
@@ -317,6 +313,10 @@ static int cpu_post_load(void *opaque, int version_id)
 
     post_load_update_msr(env);
 
+    if (tcg_enabled()) {
+        pmu_mmcr01_updated(env);
+    }
+
     return 0;
 }
 
diff --git a/target/ppc/power8-pmu.c b/target/ppc/power8-pmu.c
index 64a64865d7..c4c331c6b5 100644
--- a/target/ppc/power8-pmu.c
+++ b/target/ppc/power8-pmu.c
@@ -31,7 +31,11 @@ static bool pmc_has_overflow_enabled(CPUPPCState *env, int sprn)
     return env->spr[SPR_POWER_MMCR0] & MMCR0_PMCjCE;
 }
 
-void pmu_update_summaries(CPUPPCState *env)
+/*
+ * Called after MMCR0 or MMCR1 changes to update pmc_ins_cnt and pmc_cyc_cnt.
+ * hflags must subsequently be updated.
+ */
+static void pmu_update_summaries(CPUPPCState *env)
 {
     target_ulong mmcr0 = env->spr[SPR_POWER_MMCR0];
     target_ulong mmcr1 = env->spr[SPR_POWER_MMCR1];
@@ -39,7 +43,7 @@ void pmu_update_summaries(CPUPPCState *env)
     int cyc_cnt = 0;
 
     if (mmcr0 & MMCR0_FC) {
-        goto hflags_calc;
+        goto out;
     }
 
     if (!(mmcr0 & MMCR0_FC14) && mmcr1 != 0) {
@@ -73,10 +77,19 @@ void pmu_update_summaries(CPUPPCState *env)
     ins_cnt |= !(mmcr0 & MMCR0_FC56) << 5;
     cyc_cnt |= !(mmcr0 & MMCR0_FC56) << 6;
 
- hflags_calc:
+ out:
     env->pmc_ins_cnt = ins_cnt;
     env->pmc_cyc_cnt = cyc_cnt;
-    env->hflags = deposit32(env->hflags, HFLAGS_INSN_CNT, 1, ins_cnt != 0);
+}
+
+void pmu_mmcr01_updated(CPUPPCState *env)
+{
+    pmu_update_summaries(env);
+    hreg_update_pmu_hflags(env);
+    /*
+     * Should this update overflow timers (if mmcr0 is updated) so they
+     * get set in cpu_post_load?
+     */
 }
 
 static bool pmu_increment_insns(CPUPPCState *env, uint32_t num_insns)
@@ -234,18 +247,11 @@ static void pmu_delete_timers(CPUPPCState *env)
 
 void helper_store_mmcr0(CPUPPCState *env, target_ulong value)
 {
-    bool hflags_pmcc0 = (value & MMCR0_PMCC0) != 0;
-    bool hflags_pmcc1 = (value & MMCR0_PMCC1) != 0;
-
     pmu_update_cycles(env);
 
     env->spr[SPR_POWER_MMCR0] = value;
 
-    /* MMCR0 writes can change HFLAGS_PMCC[01] and HFLAGS_INSN_CNT */
-    env->hflags = deposit32(env->hflags, HFLAGS_PMCC0, 1, hflags_pmcc0);
-    env->hflags = deposit32(env->hflags, HFLAGS_PMCC1, 1, hflags_pmcc1);
-
-    pmu_update_summaries(env);
+    pmu_mmcr01_updated(env);
 
     /* Update cycle overflow timers with the current MMCR0 state */
     pmu_update_overflow_timers(env);
@@ -257,8 +263,7 @@ void helper_store_mmcr1(CPUPPCState *env, uint64_t value)
 
     env->spr[SPR_POWER_MMCR1] = value;
 
-    /* MMCR1 writes can change HFLAGS_INSN_CNT */
-    pmu_update_summaries(env);
+    pmu_mmcr01_updated(env);
 }
 
 target_ulong helper_read_pmc(CPUPPCState *env, uint32_t sprn)
@@ -287,8 +292,8 @@ static void fire_PMC_interrupt(PowerPCCPU *cpu)
         env->spr[SPR_POWER_MMCR0] &= ~MMCR0_FCECE;
         env->spr[SPR_POWER_MMCR0] |= MMCR0_FC;
 
-        /* Changing MMCR0_FC requires a new HFLAGS_INSN_CNT calc */
-        pmu_update_summaries(env);
+        /* Changing MMCR0_FC requires summaries and hflags update */
+        pmu_mmcr01_updated(env);
 
         /*
          * Delete all pending timers if we need to freeze
@@ -299,6 +304,7 @@ static void fire_PMC_interrupt(PowerPCCPU *cpu)
     }
 
     if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMAE) {
+        /* These MMCR0 bits do not require summaries or hflags update. */
         env->spr[SPR_POWER_MMCR0] &= ~MMCR0_PMAE;
         env->spr[SPR_POWER_MMCR0] |= MMCR0_PMAO;
     }
diff --git a/target/ppc/power8-pmu.h b/target/ppc/power8-pmu.h
index c0093e2219..775e640053 100644
--- a/target/ppc/power8-pmu.h
+++ b/target/ppc/power8-pmu.h
@@ -18,10 +18,10 @@
 #define PMC_COUNTER_NEGATIVE_VAL 0x80000000UL
 
 void cpu_ppc_pmu_init(CPUPPCState *env);
-void pmu_update_summaries(CPUPPCState *env);
+void pmu_mmcr01_updated(CPUPPCState *env);
 #else
 static inline void cpu_ppc_pmu_init(CPUPPCState *env) { }
-static inline void pmu_update_summaries(CPUPPCState *env) { }
+static inline void pmu_mmcr01_updated(CPUPPCState *env) { }
 #endif
 
 #endif
-- 
2.40.1


