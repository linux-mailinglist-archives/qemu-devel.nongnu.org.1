Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A342173EAEB
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 21:09:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrTG-00006W-Gg; Mon, 26 Jun 2023 15:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrSm-0008TT-Tj; Mon, 26 Jun 2023 15:01:25 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrSk-0007mB-5P; Mon, 26 Jun 2023 15:01:24 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EE6B1EFBD;
 Mon, 26 Jun 2023 21:59:12 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7EB98F7F9;
 Mon, 26 Jun 2023 21:59:11 +0300 (MSK)
Received: (nullmailer pid 1575360 invoked by uid 1000);
 Mon, 26 Jun 2023 18:59:05 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.4 28/43] target/ppc: Fix PMU hflags calculation
Date: Mon, 26 Jun 2023 21:58:46 +0300
Message-Id: <20230626185902.1575177-28-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.4-20230626215033@cover.tls.msk.ru>
References: <qemu-stable-7.2.4-20230626215033@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20230530130447.372617-1-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
(cherry picked from commit 6494d2c1fd4ebc37b575130399a97a1fcfff1afc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index cbf0081374..294a18a5b7 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7085,7 +7085,7 @@ static void ppc_cpu_reset(DeviceState *dev)
         if (env->mmu_model != POWERPC_MMU_REAL) {
             ppc_tlb_invalidate_all(env);
         }
-        pmu_update_summaries(env);
+        pmu_mmcr01_updated(env);
     }
 
     /* clean any pending stop state */
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index c0aee5855b..e200091a23 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -46,6 +46,48 @@ void hreg_swap_gpr_tgpr(CPUPPCState *env)
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
@@ -103,30 +145,12 @@ static uint32_t hreg_compute_hflags_value(CPUPPCState *env)
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
@@ -171,6 +195,8 @@ static uint32_t hreg_compute_hflags_value(CPUPPCState *env)
     hflags |= dmmu_idx << HFLAGS_DMMU_IDX;
 #endif
 
+    hflags |= hreg_compute_pmu_hflags_value(env);
+
     return hflags | (msr & msr_mask);
 }
 
@@ -179,6 +205,17 @@ void hreg_compute_hflags(CPUPPCState *env)
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
index 1381072b9e..fccd011088 100644
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
2.39.2


