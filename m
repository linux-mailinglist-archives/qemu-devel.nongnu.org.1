Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC067743BD3
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 14:27:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFDDB-0007m3-Uu; Fri, 30 Jun 2023 08:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qFDCW-0007i1-TI
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 08:26:13 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qFDCU-0007pU-9n
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 08:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=p9Wxsfez663U0a0n8CU8dQHR0dYItJ/VYkumGeyDKcU=; b=JExO3pRuptB/w+SY4eivhhy+fA
 WmMe6m/moQO/X+qtr7Tvytwlzbq5HEq6s8ckd6FRxxtpxaIQjLaPYQAkwUTHm0p9HCoJPLnWtpS+c
 t74e6XRJauzx0iH375yWZBHCuwB5kEEsVN2qTOHk3qAKSBp4g4lE4njtxiqduCKdafkg=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 peter.maydell@linaro.org, wangyanan55@huawei.com
Subject: [PATCH 6/9] Move IcountDecr to CPUState and assert offset
Date: Fri, 30 Jun 2023 14:25:48 +0200
Message-ID: <20230630122551.21766-7-anjo@rev.ng>
In-Reply-To: <20230630122551.21766-1-anjo@rev.ng>
References: <20230630122551.21766-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Instead of using CPUNegativeOffsetState to ensure that negative offset
between IcountDecr and CPUArchState is small enough, it can be
statically asserted to be greater than CPU_MAX_NEGATIVE_ENV_OFFSET.

Additionally, moving IcountDecr to CPUState allows for reducing the
dependency of common code on CPUArchState (in the future).

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/exec/cpu-all.h           |  2 +-
 include/exec/cpu-defs.h          |  1 -
 include/exec/exec-all.h          |  2 +-
 include/hw/core/cpu.h            |  1 +
 accel/tcg/cpu-exec.c             | 14 +++++++-------
 accel/tcg/tcg-accel-ops-icount.c |  6 +++---
 accel/tcg/tcg-accel-ops.c        |  2 +-
 accel/tcg/translate-all.c        |  6 +++---
 accel/tcg/translator.c           | 15 +++++++++++----
 softmmu/icount.c                 |  2 +-
 10 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 706daa49ec..a31df11770 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -396,7 +396,7 @@ void tcg_exec_unrealizefn(CPUState *cpu);
 static inline void cpu_set_cpustate_pointers(ArchCPU *cpu)
 {
     cpu->parent_obj.env_ptr = &cpu->env;
-    cpu->parent_obj.icount_decr_ptr = &cpu->neg.icount_decr;
+    cpu->parent_obj.icount_decr_ptr = &cpu->parent_obj.icount_decr;
 }
 
 /**
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index add0f3c541..429d9525f7 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -82,7 +82,6 @@
  * before CPUArchState, as a field named "neg".
  */
 typedef struct CPUNegativeOffsetState {
-    IcountDecr icount_decr;
 } CPUNegativeOffsetState;
 
 #endif
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 200c27eadf..3bc4e34909 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -71,7 +71,7 @@ G_NORETURN void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc);
  */
 static inline bool cpu_loop_exit_requested(CPUState *cpu)
 {
-    return (int32_t)qatomic_read(&cpu_neg(cpu)->icount_decr.u32) < 0;
+    return (int32_t)qatomic_read(&cpu->icount_decr.u32) < 0;
 }
 
 #if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index adf6158899..c2e78b5fa9 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -455,6 +455,7 @@ struct CPUState {
      * ArchCPU struct these are placed last.  This is checked statically.
      */
     CPUTLB tlb;
+    IcountDecr icount_decr;
 };
 
 typedef QTAILQ_HEAD(CPUTailQ, CPUState) CPUTailQ;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index ba1890a373..0a49b6fd7e 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -73,7 +73,7 @@ static void align_clocks(SyncClocks *sc, CPUState *cpu)
         return;
     }
 
-    cpu_icount = cpu->icount_extra + cpu_neg(cpu)->icount_decr.u16.low;
+    cpu_icount = cpu->icount_extra + cpu->icount_decr.u16.low;
     sc->diff_clk += icount_to_ns(sc->last_cpu_icount - cpu_icount);
     sc->last_cpu_icount = cpu_icount;
 
@@ -124,7 +124,7 @@ static void init_delay_params(SyncClocks *sc, CPUState *cpu)
     sc->realtime_clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT);
     sc->diff_clk = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - sc->realtime_clock;
     sc->last_cpu_icount
-        = cpu->icount_extra + cpu_neg(cpu)->icount_decr.u16.low;
+        = cpu->icount_extra + cpu->icount_decr.u16.low;
     if (sc->diff_clk < max_delay) {
         max_delay = sc->diff_clk;
     }
@@ -689,7 +689,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
     if (cpu->exception_index < 0) {
 #ifndef CONFIG_USER_ONLY
         if (replay_has_exception()
-            && cpu_neg(cpu)->icount_decr.u16.low + cpu->icount_extra == 0) {
+            && cpu->icount_decr.u16.low + cpu->icount_extra == 0) {
             /* Execute just one insn to trigger exception pending in the log */
             cpu->cflags_next_tb = (curr_cflags(cpu) & ~CF_USE_ICOUNT)
                 | CF_NOIRQ | 1;
@@ -779,7 +779,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
      * Ensure zeroing happens before reading cpu->exit_request or
      * cpu->interrupt_request (see also smp_wmb in cpu_exit())
      */
-    qatomic_set_mb(&cpu_neg(cpu)->icount_decr.u16.high, 0);
+    qatomic_set_mb(&cpu->icount_decr.u16.high, 0);
 
     if (unlikely(qatomic_read(&cpu->interrupt_request))) {
         int interrupt_request;
@@ -870,7 +870,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
     if (unlikely(qatomic_read(&cpu->exit_request))
         || (icount_enabled()
             && (cpu->cflags_next_tb == -1 || cpu->cflags_next_tb & CF_USE_ICOUNT)
-            && cpu_neg(cpu)->icount_decr.u16.low + cpu->icount_extra == 0)) {
+            && cpu->icount_decr.u16.low + cpu->icount_extra == 0)) {
         qatomic_set(&cpu->exit_request, 0);
         if (cpu->exception_index == -1) {
             cpu->exception_index = EXCP_INTERRUPT;
@@ -895,7 +895,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
     }
 
     *last_tb = NULL;
-    insns_left = qatomic_read(&cpu_neg(cpu)->icount_decr.u32);
+    insns_left = qatomic_read(&cpu->icount_decr.u32);
     if (insns_left < 0) {
         /* Something asked us to stop executing chained TBs; just
          * continue round the main loop. Whatever requested the exit
@@ -914,7 +914,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
     icount_update(cpu);
     /* Refill decrementer and continue execution.  */
     insns_left = MIN(0xffff, cpu->icount_budget);
-    cpu_neg(cpu)->icount_decr.u16.low = insns_left;
+    cpu->icount_decr.u16.low = insns_left;
     cpu->icount_extra = cpu->icount_budget - insns_left;
 
     /*
diff --git a/accel/tcg/tcg-accel-ops-icount.c b/accel/tcg/tcg-accel-ops-icount.c
index 3d2cfbbc97..1bb31fed2c 100644
--- a/accel/tcg/tcg-accel-ops-icount.c
+++ b/accel/tcg/tcg-accel-ops-icount.c
@@ -111,14 +111,14 @@ void icount_prepare_for_run(CPUState *cpu, int64_t cpu_budget)
      * each vCPU execution. However u16.high can be raised
      * asynchronously by cpu_exit/cpu_interrupt/tcg_handle_interrupt
      */
-    g_assert(cpu_neg(cpu)->icount_decr.u16.low == 0);
+    g_assert(cpu->icount_decr.u16.low == 0);
     g_assert(cpu->icount_extra == 0);
 
     replay_mutex_lock();
 
     cpu->icount_budget = MIN(icount_get_limit(), cpu_budget);
     insns_left = MIN(0xffff, cpu->icount_budget);
-    cpu_neg(cpu)->icount_decr.u16.low = insns_left;
+    cpu->icount_decr.u16.low = insns_left;
     cpu->icount_extra = cpu->icount_budget - insns_left;
 
     if (cpu->icount_budget == 0) {
@@ -138,7 +138,7 @@ void icount_process_data(CPUState *cpu)
     icount_update(cpu);
 
     /* Reset the counters */
-    cpu_neg(cpu)->icount_decr.u16.low = 0;
+    cpu->icount_decr.u16.low = 0;
     cpu->icount_extra = 0;
     cpu->icount_budget = 0;
 
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 3973591508..1b957eb37b 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -91,7 +91,7 @@ void tcg_handle_interrupt(CPUState *cpu, int mask)
     if (!qemu_cpu_is_self(cpu)) {
         qemu_cpu_kick(cpu);
     } else {
-        qatomic_set(&cpu_neg(cpu)->icount_decr.u16.high, -1);
+        qatomic_set(&cpu->icount_decr.u16.high, -1);
     }
 }
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 5582aaf653..6069f6b8ba 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -214,7 +214,7 @@ void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
          * Reset the cycle counter to the start of the block and
          * shift if to the number of actually executed instructions.
          */
-        cpu_neg(cpu)->icount_decr.u16.low += insns_left;
+        cpu->icount_decr.u16.low += insns_left;
     }
 
     cpu->cc->tcg_ops->restore_state_to_opc(cpu, tb, data);
@@ -598,7 +598,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
     cc = CPU_GET_CLASS(cpu);
     if (cc->tcg_ops->io_recompile_replay_branch &&
         cc->tcg_ops->io_recompile_replay_branch(cpu, tb)) {
-        cpu_neg(cpu)->icount_decr.u16.low++;
+        cpu->icount_decr.u16.low++;
         n = 2;
     }
 
@@ -754,7 +754,7 @@ void cpu_interrupt(CPUState *cpu, int mask)
 {
     g_assert(qemu_mutex_iothread_locked());
     cpu->interrupt_request |= mask;
-    qatomic_set(&cpu_neg(cpu)->icount_decr.u16.high, -1);
+    qatomic_set(&cpu->icount_decr.u16.high, -1);
 }
 
 #endif /* CONFIG_USER_ONLY */
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 0fd9efceba..7eba58137d 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -52,9 +52,16 @@ static TCGOp *gen_tb_start(uint32_t cflags)
     TCGv_i32 count = tcg_temp_new_i32();
     TCGOp *icount_start_insn = NULL;
 
-    tcg_gen_ld_i32(count, cpu_env,
-                   offsetof(ArchCPU, neg.icount_decr.u32) -
-                   offsetof(ArchCPU, env));
+#define ICOUNT_DECR_OFFSET \
+    ((int)offsetof(ArchCPU, parent_obj.icount_decr.u32) - \
+     (int)offsetof(ArchCPU, env))
+
+    QEMU_BUILD_BUG_ON(ICOUNT_DECR_OFFSET < CPU_MAX_NEGATIVE_ENV_OFFSET ||
+                      ICOUNT_DECR_OFFSET > 0);
+
+    tcg_gen_ld_i32(count, cpu_env, ICOUNT_DECR_OFFSET);
+
+#undef ICOUNT_DECR_OFFSET
 
     if (cflags & CF_USE_ICOUNT) {
         /*
@@ -82,7 +89,7 @@ static TCGOp *gen_tb_start(uint32_t cflags)
 
     if (cflags & CF_USE_ICOUNT) {
         tcg_gen_st16_i32(count, cpu_env,
-                         offsetof(ArchCPU, neg.icount_decr.u16.low) -
+                         offsetof(ArchCPU, parent_obj.icount_decr.u16.low) -
                          offsetof(ArchCPU, env));
         /*
          * cpu->can_do_io is cleared automatically here at the beginning of
diff --git a/softmmu/icount.c b/softmmu/icount.c
index a5cef9c60a..344af5fc3c 100644
--- a/softmmu/icount.c
+++ b/softmmu/icount.c
@@ -75,7 +75,7 @@ static void icount_enable_adaptive(void)
 static int64_t icount_get_executed(CPUState *cpu)
 {
     return (cpu->icount_budget -
-            (cpu_neg(cpu)->icount_decr.u16.low + cpu->icount_extra));
+            (cpu->icount_decr.u16.low + cpu->icount_extra));
 }
 
 /*
-- 
2.41.0


