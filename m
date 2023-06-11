Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5415272B4A6
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 00:44:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8Tlm-0000HD-1U; Sun, 11 Jun 2023 18:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q8Tlk-0000GF-8g; Sun, 11 Jun 2023 18:42:44 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q8Tlh-0004hO-CU; Sun, 11 Jun 2023 18:42:43 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id AE29E748A6C;
 Mon, 12 Jun 2023 00:42:36 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 77BF3748A64; Mon, 12 Jun 2023 00:42:36 +0200 (CEST)
Message-Id: <edbb93cb67b72bb948155932767ef989cddc8aa0.1686522199.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1686522199.git.balaton@eik.bme.hu>
References: <cover.1686522199.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 06/10] target/ppc: Readability improvements in exception
 handlers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 12 Jun 2023 00:42:36 +0200 (CEST)
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

Improve readability by shortening some long comments, removing
comments that state the obvious and dropping some empty lines so they
don't distract when reading the code.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/cpu.h         |   1 +
 target/ppc/excp_helper.c | 180 +++++++--------------------------------
 2 files changed, 33 insertions(+), 148 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0ee2adc105..d7acd65176 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2739,6 +2739,7 @@ static inline bool ppc_has_spr(PowerPCCPU *cpu, int spr)
 }
 
 #if !defined(CONFIG_USER_ONLY)
+/* Sort out endianness of interrupt. Depends on the CPU, HV mode, etc. */
 static inline bool ppc_interrupts_little_endian(PowerPCCPU *cpu, bool hv)
 {
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index b681edbdcf..885e479301 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -382,9 +382,8 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu, target_ulong vector,
      * We don't use hreg_store_msr here as already have treated any
      * special case that could occur. Just store MSR and update hflags
      *
-     * Note: We *MUST* not use hreg_store_msr() as-is anyway because it
-     * will prevent setting of the HV bit which some exceptions might need
-     * to do.
+     * Note: We *MUST* not use hreg_store_msr() as-is anyway because it will
+     * prevent setting of the HV bit which some exceptions might need to do.
      */
     env->nip = vector;
     env->msr = msr;
@@ -424,25 +423,15 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
-    int srr0, srr1;
+    int srr0 = SPR_SRR0, srr1 = SPR_SRR1;
 
     /* new srr1 value excluding must-be-zero bits */
     msr = env->msr & ~0x783f0000ULL;
 
-    /*
-     * new interrupt handler msr preserves existing ME unless
-     * explicitly overriden.
-     */
+    /* new interrupt handler msr preserves ME unless explicitly overriden */
     new_msr = env->msr & (((target_ulong)1 << MSR_ME));
 
-    /* target registers */
-    srr0 = SPR_SRR0;
-    srr1 = SPR_SRR1;
-
-    /*
-     * Hypervisor emulation assistance interrupt only exists on server
-     * arch 2.05 server or later.
-     */
+    /* HV emu assistance interrupt only exists on server arch 2.05 or later */
     if (excp == POWERPC_EXCP_HV_EMU) {
         excp = POWERPC_EXCP_PROGRAM;
     }
@@ -452,7 +441,6 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
         cpu_abort(env_cpu(env),
                   "Raised an exception without defined vector %d\n", excp);
     }
-
     vector |= env->excp_prefix;
 
     switch (excp) {
@@ -464,7 +452,6 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
         powerpc_checkstop_state(env);
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
-
         srr0 = SPR_40x_SRR2;
         srr1 = SPR_40x_SRR3;
         break;
@@ -535,12 +522,8 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
         break;
     }
 
-    /* Save PC */
     env->spr[srr0] = env->nip;
-
-    /* Save MSR */
     env->spr[srr1] = msr;
-
     powerpc_set_excp_state(cpu, vector, new_msr);
 }
 
@@ -552,16 +535,10 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
     /* new srr1 value excluding must-be-zero bits */
     msr = env->msr & ~0x783f0000ULL;
 
-    /*
-     * new interrupt handler msr preserves existing ME unless
-     * explicitly overriden
-     */
+    /* new interrupt handler msr preserves ME unless explicitly overriden */
     new_msr = env->msr & ((target_ulong)1 << MSR_ME);
 
-    /*
-     * Hypervisor emulation assistance interrupt only exists on server
-     * arch 2.05 server or later.
-     */
+    /* HV emu assistance interrupt only exists on server arch 2.05 or later */
     if (excp == POWERPC_EXCP_HV_EMU) {
         excp = POWERPC_EXCP_PROGRAM;
     }
@@ -571,7 +548,6 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
         cpu_abort(env_cpu(env),
                   "Raised an exception without defined vector %d\n", excp);
     }
-
     vector |= env->excp_prefix;
 
     switch (excp) {
@@ -581,7 +557,6 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
         powerpc_checkstop_state(env);
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
-
         break;
     case POWERPC_EXCP_DSI:       /* Data storage exception                   */
         trace_ppc_excp_dsi(env->spr[SPR_DSISR], env->spr[SPR_DAR]);
@@ -609,11 +584,9 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
                 powerpc_reset_excp_state(cpu);
                 return;
             }
-
             /*
-             * FP exceptions always have NIP pointing to the faulting
-             * instruction, so always use store_next and claim we are
-             * precise in the MSR.
+             * NIP always points to the faulting instruction for FP exceptions,
+             * so always use store_next and claim we are precise in the MSR.
              */
             msr |= 0x00100000;
             break;
@@ -689,20 +662,11 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
         break;
     }
 
-    /*
-     * Sort out endianness of interrupt, this differs depending on the
-     * CPU, the HV mode, etc...
-     */
     if (ppc_interrupts_little_endian(cpu, !!(new_msr & MSR_HVB))) {
         new_msr |= (target_ulong)1 << MSR_LE;
     }
-
-    /* Save PC */
     env->spr[SPR_SRR0] = env->nip;
-
-    /* Save MSR */
     env->spr[SPR_SRR1] = msr;
-
     powerpc_set_excp_state(cpu, vector, new_msr);
 }
 
@@ -714,16 +678,10 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
     /* new srr1 value excluding must-be-zero bits */
     msr = env->msr & ~0x783f0000ULL;
 
-    /*
-     * new interrupt handler msr preserves existing ME unless
-     * explicitly overriden
-     */
+    /* new interrupt handler msr preserves ME unless explicitly overriden */
     new_msr = env->msr & ((target_ulong)1 << MSR_ME);
 
-    /*
-     * Hypervisor emulation assistance interrupt only exists on server
-     * arch 2.05 server or later.
-     */
+    /* HV emu assistance interrupt only exists on server arch 2.05 or later */
     if (excp == POWERPC_EXCP_HV_EMU) {
         excp = POWERPC_EXCP_PROGRAM;
     }
@@ -733,7 +691,6 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
         cpu_abort(env_cpu(env),
                   "Raised an exception without defined vector %d\n", excp);
     }
-
     vector |= env->excp_prefix;
 
     switch (excp) {
@@ -741,7 +698,6 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
         powerpc_checkstop_state(env);
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
-
         break;
     case POWERPC_EXCP_DSI:       /* Data storage exception                   */
         trace_ppc_excp_dsi(env->spr[SPR_DSISR], env->spr[SPR_DAR]);
@@ -769,11 +725,9 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
                 powerpc_reset_excp_state(cpu);
                 return;
             }
-
             /*
-             * FP exceptions always have NIP pointing to the faulting
-             * instruction, so always use store_next and claim we are
-             * precise in the MSR.
+             * NIP always points to the faulting instruction for FP exceptions,
+             * so always use store_next and claim we are precise in the MSR.
              */
             msr |= 0x00100000;
             break;
@@ -841,12 +795,10 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_DLTLB:     /* Data load TLB miss                       */
     case POWERPC_EXCP_DSTLB:     /* Data store TLB miss                      */
         ppc_excp_debug_sw_tlb(env, excp);
-
         msr |= env->crf[0] << 28;
         msr |= env->error_code; /* key, D/I, S/L bits */
         /* Set way using a LRU mechanism */
         msr |= ((env->last_way + 1) & (env->nb_ways - 1)) << 17;
-
         break;
     case POWERPC_EXCP_IABR:      /* Instruction address breakpoint           */
     case POWERPC_EXCP_SMI:       /* System management interrupt              */
@@ -861,20 +813,11 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
         break;
     }
 
-    /*
-     * Sort out endianness of interrupt, this differs depending on the
-     * CPU, the HV mode, etc...
-     */
     if (ppc_interrupts_little_endian(cpu, !!(new_msr & MSR_HVB))) {
         new_msr |= (target_ulong)1 << MSR_LE;
     }
-
-    /* Save PC */
     env->spr[SPR_SRR0] = env->nip;
-
-    /* Save MSR */
     env->spr[SPR_SRR1] = msr;
-
     powerpc_set_excp_state(cpu, vector, new_msr);
 }
 
@@ -886,16 +829,10 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
     /* new srr1 value excluding must-be-zero bits */
     msr = env->msr & ~0x783f0000ULL;
 
-    /*
-     * new interrupt handler msr preserves existing ME unless
-     * explicitly overriden
-     */
+    /* new interrupt handler msr preserves ME unless explicitly overriden */
     new_msr = env->msr & ((target_ulong)1 << MSR_ME);
 
-    /*
-     * Hypervisor emulation assistance interrupt only exists on server
-     * arch 2.05 server or later.
-     */
+    /* HV emu assistance interrupt only exists on server arch 2.05 or later */
     if (excp == POWERPC_EXCP_HV_EMU) {
         excp = POWERPC_EXCP_PROGRAM;
     }
@@ -905,7 +842,6 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
         cpu_abort(env_cpu(env),
                   "Raised an exception without defined vector %d\n", excp);
     }
-
     vector |= env->excp_prefix;
 
     switch (excp) {
@@ -913,7 +849,6 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
         powerpc_checkstop_state(env);
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
-
         break;
     case POWERPC_EXCP_DSI:       /* Data storage exception                   */
         trace_ppc_excp_dsi(env->spr[SPR_DSISR], env->spr[SPR_DAR]);
@@ -941,11 +876,9 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
                 powerpc_reset_excp_state(cpu);
                 return;
             }
-
             /*
-             * FP exceptions always have NIP pointing to the faulting
-             * instruction, so always use store_next and claim we are
-             * precise in the MSR.
+             * NIP always points to the faulting instruction for FP exceptions,
+             * so always use store_next and claim we are precise in the MSR.
              */
             msr |= 0x00100000;
             break;
@@ -1025,20 +958,11 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
         break;
     }
 
-    /*
-     * Sort out endianness of interrupt, this differs depending on the
-     * CPU, the HV mode, etc...
-     */
     if (ppc_interrupts_little_endian(cpu, !!(new_msr & MSR_HVB))) {
         new_msr |= (target_ulong)1 << MSR_LE;
     }
-
-    /* Save PC */
     env->spr[SPR_SRR0] = env->nip;
-
-    /* Save MSR */
     env->spr[SPR_SRR1] = msr;
-
     powerpc_set_excp_state(cpu, vector, new_msr);
 }
 
@@ -1046,24 +970,18 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
-    int srr0, srr1;
-
-    msr = env->msr;
+    int srr0 = SPR_SRR0, srr1 = SPR_SRR1;
 
     /*
-     * new interrupt handler msr preserves existing ME unless
-     * explicitly overriden
+     * Book E does not play games with certain bits of xSRR1 being MSR save
+     * bits and others being error status. xSRR1 is the old MSR, period.
      */
-    new_msr = env->msr & ((target_ulong)1 << MSR_ME);
+    msr = env->msr;
 
-    /* target registers */
-    srr0 = SPR_SRR0;
-    srr1 = SPR_SRR1;
+    /* new interrupt handler msr preserves ME unless explicitly overriden */
+    new_msr = env->msr & ((target_ulong)1 << MSR_ME);
 
-    /*
-     * Hypervisor emulation assistance interrupt only exists on server
-     * arch 2.05 server or later.
-     */
+    /* HV emu assistance interrupt only exists on server arch 2.05 or later */
     if (excp == POWERPC_EXCP_HV_EMU) {
         excp = POWERPC_EXCP_PROGRAM;
     }
@@ -1083,7 +1001,6 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
         cpu_abort(env_cpu(env),
                   "Raised an exception without defined vector %d\n", excp);
     }
-
     vector |= env->excp_prefix;
 
     switch (excp) {
@@ -1127,11 +1044,9 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
                 powerpc_reset_excp_state(cpu);
                 return;
             }
-
             /*
-             * FP exceptions always have NIP pointing to the faulting
-             * instruction, so always use store_next and claim we are
-             * precise in the MSR.
+             * NIP always points to the faulting instruction for FP exceptions,
+             * so always use store_next and claim we are precise in the MSR.
              */
             msr |= 0x00100000;
             env->spr[SPR_BOOKE_ESR] = ESR_FP;
@@ -1232,12 +1147,8 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
     }
 #endif
 
-    /* Save PC */
     env->spr[srr0] = env->nip;
-
-    /* Save MSR */
     env->spr[srr1] = msr;
-
     powerpc_set_excp_state(cpu, vector, new_msr);
 }
 
@@ -1284,21 +1195,17 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
-    int srr0, srr1, lev = -1;
+    int srr0 = SPR_SRR0, srr1 = SPR_SRR1, lev = -1;
 
     /* new srr1 value excluding must-be-zero bits */
     msr = env->msr & ~0x783f0000ULL;
 
     /*
-     * new interrupt handler msr preserves existing HV and ME unless
-     * explicitly overriden
+     * new interrupt handler msr preserves HV and ME unless explicitly
+     * overriden
      */
     new_msr = env->msr & (((target_ulong)1 << MSR_ME) | MSR_HVB);
 
-    /* target registers */
-    srr0 = SPR_SRR0;
-    srr1 = SPR_SRR1;
-
     /*
      * check for special resume at 0x100 from doze/nap/sleep/winkle on
      * P7/P8/P9
@@ -1323,7 +1230,6 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
         cpu_abort(env_cpu(env),
                   "Raised an exception without defined vector %d\n", excp);
     }
-
     vector |= env->excp_prefix;
 
     switch (excp) {
@@ -1336,10 +1242,8 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
              */
             new_msr |= (target_ulong)MSR_HVB;
         }
-
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
-
         break;
     case POWERPC_EXCP_DSI:       /* Data storage exception                   */
         trace_ppc_excp_dsi(env->spr[SPR_DSISR], env->spr[SPR_DAR]);
@@ -1352,23 +1256,17 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     {
         bool lpes0;
 
-        /*
-         * LPES0 is only taken into consideration if we support HV
-         * mode for this CPU.
-         */
+        /* LPES0 is only taken into consideration if we support HV mode */
         if (!env->has_hv_mode) {
             break;
         }
-
         lpes0 = !!(env->spr[SPR_LPCR] & LPCR_LPES0);
-
         if (!lpes0) {
             new_msr |= (target_ulong)MSR_HVB;
             new_msr |= env->msr & ((target_ulong)1 << MSR_RI);
             srr0 = SPR_HSRR0;
             srr1 = SPR_HSRR1;
         }
-
         break;
     }
     case POWERPC_EXCP_ALIGN:     /* Alignment exception                      */
@@ -1391,11 +1289,9 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
                 powerpc_reset_excp_state(cpu);
                 return;
             }
-
             /*
-             * FP exceptions always have NIP pointing to the faulting
-             * instruction, so always use store_next and claim we are
-             * precise in the MSR.
+             * NIP always points to the faulting instruction for FP exceptions,
+             * so always use store_next and claim we are precise in the MSR.
              */
             msr |= 0x00100000;
             break;
@@ -1537,21 +1433,13 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
         break;
     }
 
-    /*
-     * Sort out endianness of interrupt, this differs depending on the
-     * CPU, the HV mode, etc...
-     */
     if (ppc_interrupts_little_endian(cpu, !!(new_msr & MSR_HVB))) {
         new_msr |= (target_ulong)1 << MSR_LE;
     }
-
     new_msr |= (target_ulong)1 << MSR_SF;
 
     if (excp != POWERPC_EXCP_SYSCALL_VECTORED) {
-        /* Save PC */
         env->spr[srr0] = env->nip;
-
-        /* Save MSR */
         env->spr[srr1] = msr;
     }
 
@@ -1560,19 +1448,15 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
             PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
         /* Deliver interrupt to L1 by returning from the H_ENTER_NESTED call */
         vhc->deliver_hv_excp(cpu, excp);
-
         powerpc_reset_excp_state(cpu);
-
     } else {
         /* Sanity check */
         if (!(env->msr_mask & MSR_HVB) && srr0 == SPR_HSRR0) {
             cpu_abort(env_cpu(env), "Trying to deliver HV exception (HSRR) %d "
                       "with no HV support\n", excp);
         }
-
         /* This can update new_msr and vector if AIL applies */
         ppc_excp_apply_ail(cpu, excp, msr, &new_msr, &vector);
-
         powerpc_set_excp_state(cpu, vector, new_msr);
     }
 }
-- 
2.30.9


