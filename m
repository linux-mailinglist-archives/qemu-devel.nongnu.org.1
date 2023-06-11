Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A260272B4AA
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 00:45:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8Tll-0000GT-2A; Sun, 11 Jun 2023 18:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q8Tli-0000FZ-Tt; Sun, 11 Jun 2023 18:42:42 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q8Tlh-0004hE-7W; Sun, 11 Jun 2023 18:42:42 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 8C6D4748A6B;
 Mon, 12 Jun 2023 00:42:35 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 65973748A64; Mon, 12 Jun 2023 00:42:35 +0200 (CEST)
Message-Id: <7e6b3c01d5c48a4d32c92b578565c28f0173c6f6.1686522199.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1686522199.git.balaton@eik.bme.hu>
References: <cover.1686522199.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 05/10] target/ppc: Change parameter of cpu_interrupt_exittb()
 to an env pointer
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 12 Jun 2023 00:42:35 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Changing the parameter of cpu_interrupt_exittb() from CPUState to env
allows removing some more local CPUState variables in callers.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/excp_helper.c |  9 +++------
 target/ppc/helper_regs.c | 15 ++++++---------
 target/ppc/helper_regs.h |  2 +-
 3 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 51202f7028..b681edbdcf 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -416,7 +416,7 @@ static void powerpc_checkstop_state(CPUPPCState *env)
                      "Entering checkstop state\n");
         }
         cs->halted = 1;
-        cpu_interrupt_exittb(cs);
+        cpu_interrupt_exittb(env);
     }
 }
 
@@ -2549,8 +2549,7 @@ void helper_store_msr(CPUPPCState *env, target_ulong val)
     uint32_t excp = hreg_store_msr(env, val, 0);
 
     if (excp != 0) {
-        CPUState *cs = env_cpu(env);
-        cpu_interrupt_exittb(cs);
+        cpu_interrupt_exittb(env);
         raise_exception(env, excp);
     }
 }
@@ -2587,8 +2586,6 @@ void helper_pminsn(CPUPPCState *env, uint32_t insn)
 
 static void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
 {
-    CPUState *cs = env_cpu(env);
-
     /* MSR:POW cannot be set by any form of rfi */
     msr &= ~(1ULL << MSR_POW);
 
@@ -2612,7 +2609,7 @@ static void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
      * No need to raise an exception here, as rfi is always the last
      * insn of a TB
      */
-    cpu_interrupt_exittb(cs);
+    cpu_interrupt_exittb(env);
     /* Reset the reservation */
     env->reserve_addr = -1;
 
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index bc7e9d7eda..ffedd38985 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -237,7 +237,7 @@ void cpu_get_tb_cpu_state(CPUPPCState *env, target_ulong *pc,
 }
 #endif
 
-void cpu_interrupt_exittb(CPUState *cs)
+void cpu_interrupt_exittb(CPUPPCState *env)
 {
     /*
      * We don't need to worry about translation blocks
@@ -245,18 +245,14 @@ void cpu_interrupt_exittb(CPUState *cs)
      */
     if (tcg_enabled()) {
         QEMU_IOTHREAD_LOCK_GUARD();
-        cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
+        cpu_interrupt(env_cpu(env), CPU_INTERRUPT_EXITTB);
     }
 }
 
 int hreg_store_msr(CPUPPCState *env, target_ulong value, int alter_hv)
 {
-    int excp;
-#if !defined(CONFIG_USER_ONLY)
-    CPUState *cs = env_cpu(env);
-#endif
+    int excp = 0;
 
-    excp = 0;
     value &= env->msr_mask;
 #if !defined(CONFIG_USER_ONLY)
     /* Neither mtmsr nor guest state can alter HV */
@@ -265,12 +261,12 @@ int hreg_store_msr(CPUPPCState *env, target_ulong value, int alter_hv)
         value |= env->msr & MSR_HVB;
     }
     if ((value ^ env->msr) & (R_MSR_IR_MASK | R_MSR_DR_MASK)) {
-        cpu_interrupt_exittb(cs);
+        cpu_interrupt_exittb(env);
     }
     if ((env->mmu_model == POWERPC_MMU_BOOKE ||
          env->mmu_model == POWERPC_MMU_BOOKE206) &&
         ((value ^ env->msr) & R_MSR_GS_MASK)) {
-        cpu_interrupt_exittb(cs);
+        cpu_interrupt_exittb(env);
     }
     if (unlikely((env->flags & POWERPC_FLAG_TGPR) &&
                  ((value ^ env->msr) & (1 << MSR_TGPR)))) {
@@ -301,6 +297,7 @@ int hreg_store_msr(CPUPPCState *env, target_ulong value, int alter_hv)
 
     if (unlikely(FIELD_EX64(env->msr, MSR, POW))) {
         if (!env->pending_interrupts && (*env->check_pow)(env)) {
+            CPUState *cs = env_cpu(env);
             cs->halted = 1;
             excp = EXCP_HALTED;
         }
diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h
index 8196c1346d..3e1606f293 100644
--- a/target/ppc/helper_regs.h
+++ b/target/ppc/helper_regs.h
@@ -23,7 +23,7 @@
 void hreg_swap_gpr_tgpr(CPUPPCState *env);
 void hreg_compute_hflags(CPUPPCState *env);
 void hreg_update_pmu_hflags(CPUPPCState *env);
-void cpu_interrupt_exittb(CPUState *cs);
+void cpu_interrupt_exittb(CPUPPCState *env);
 int hreg_store_msr(CPUPPCState *env, target_ulong value, int alter_hv);
 
 #ifdef CONFIG_USER_ONLY
-- 
2.30.9


