Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1718C07F7
	for <lists+qemu-devel@lfdr.de>; Thu,  9 May 2024 01:44:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4qpZ-0002zG-Up; Wed, 08 May 2024 19:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4qpV-0002or-Nd; Wed, 08 May 2024 19:36:09 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4qpT-0002Sg-JO; Wed, 08 May 2024 19:36:09 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AB5114E64CB;
 Thu, 09 May 2024 01:36:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id mWp1tNPNgyoc; Thu,  9 May 2024 01:36:03 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B6F9B4E6426; Thu, 09 May 2024 01:36:03 +0200 (CEST)
Message-Id: <2ff176c8ab216ff63e7b7708f3390594532052ec.1715209155.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715209155.git.balaton@eik.bme.hu>
References: <cover.1715209155.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 01/33] target/ppc: Fix gen_sc to use correct nip
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 09 May 2024 01:36:03 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Most exceptions are raised with nip pointing to the faulting
instruction but the sc instruction generating a syscall exception
leaves nip pointing to next instruction. Fix gen_sc to not use
gen_exception_err() which sets nip back but correctly set nip to
pc_next so we don't have to patch this in the exception handlers.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 linux-user/ppc/cpu_loop.c |  2 --
 target/ppc/excp_helper.c  | 43 ++-------------------------------------
 target/ppc/translate.c    |  6 ++----
 3 files changed, 4 insertions(+), 47 deletions(-)

diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
index 02204ad8be..0ebf7e9808 100644
--- a/linux-user/ppc/cpu_loop.c
+++ b/linux-user/ppc/cpu_loop.c
@@ -332,12 +332,10 @@ void cpu_loop(CPUPPCState *env)
              * in syscalls.
              */
             env->crf[0] &= ~0x1;
-            env->nip += 4;
             ret = do_syscall(env, env->gpr[0], env->gpr[3], env->gpr[4],
                              env->gpr[5], env->gpr[6], env->gpr[7],
                              env->gpr[8], 0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
-                env->nip -= 4;
                 break;
             }
             if (ret == (target_ulong)(-QEMU_ESIGRETURN)) {
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 0712098cf7..92fe535815 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -116,7 +116,7 @@ static void dump_syscall(CPUPPCState *env)
                   ppc_dump_gpr(env, 0), ppc_dump_gpr(env, 3),
                   ppc_dump_gpr(env, 4), ppc_dump_gpr(env, 5),
                   ppc_dump_gpr(env, 6), ppc_dump_gpr(env, 7),
-                  ppc_dump_gpr(env, 8), env->nip);
+                  ppc_dump_gpr(env, 8), env->nip - 4);
 }
 
 static void dump_hcall(CPUPPCState *env)
@@ -131,7 +131,7 @@ static void dump_hcall(CPUPPCState *env)
                   ppc_dump_gpr(env, 7), ppc_dump_gpr(env, 8),
                   ppc_dump_gpr(env, 9), ppc_dump_gpr(env, 10),
                   ppc_dump_gpr(env, 11), ppc_dump_gpr(env, 12),
-                  env->nip);
+                  env->nip - 4);
 }
 
 #ifdef CONFIG_TCG
@@ -516,12 +516,6 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_SYSCALL:   /* System call exception                    */
         dump_syscall(env);
-
-        /*
-         * We need to correct the NIP which in this case is supposed
-         * to point to the next instruction
-         */
-        env->nip += 4;
         break;
     case POWERPC_EXCP_FIT:       /* Fixed-interval timer interrupt           */
         trace_ppc_excp_print("FIT");
@@ -632,12 +626,6 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_SYSCALL:   /* System call exception                    */
         dump_syscall(env);
-
-        /*
-         * We need to correct the NIP which in this case is supposed
-         * to point to the next instruction
-         */
-        env->nip += 4;
         break;
     case POWERPC_EXCP_FPU:       /* Floating-point unavailable exception     */
     case POWERPC_EXCP_DECR:      /* Decrementer exception                    */
@@ -780,13 +768,6 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
         } else {
             dump_syscall(env);
         }
-
-        /*
-         * We need to correct the NIP which in this case is supposed
-         * to point to the next instruction
-         */
-        env->nip += 4;
-
         /*
          * The Virtual Open Firmware (VOF) relies on the 'sc 1'
          * instruction to communicate with QEMU. The pegasos2 machine
@@ -932,13 +913,6 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
         } else {
             dump_syscall(env);
         }
-
-        /*
-         * We need to correct the NIP which in this case is supposed
-         * to point to the next instruction
-         */
-        env->nip += 4;
-
         /*
          * The Virtual Open Firmware (VOF) relies on the 'sc 1'
          * instruction to communicate with QEMU. The pegasos2 machine
@@ -1098,12 +1072,6 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_SYSCALL:   /* System call exception                    */
         dump_syscall(env);
-
-        /*
-         * We need to correct the NIP which in this case is supposed
-         * to point to the next instruction
-         */
-        env->nip += 4;
         break;
     case POWERPC_EXCP_FPU:       /* Floating-point unavailable exception     */
     case POWERPC_EXCP_APU:       /* Auxiliary processor unavailable          */
@@ -1428,13 +1396,6 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
         } else {
             dump_syscall(env);
         }
-
-        /*
-         * We need to correct the NIP which in this case is supposed
-         * to point to the next instruction
-         */
-        env->nip += 4;
-
         /* "PAPR mode" built-in hypercall emulation */
         if (lev == 1 && books_vhyp_handles_hcall(cpu)) {
             PPCVirtualHypervisorClass *vhc =
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 93ffec787c..fa72f17c3e 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4479,15 +4479,13 @@ static void gen_hrfid(DisasContext *ctx)
 #endif
 static void gen_sc(DisasContext *ctx)
 {
-    uint32_t lev;
-
     /*
      * LEV is a 7-bit field, but the top 6 bits are treated as a reserved
      * field (i.e., ignored). ISA v3.1 changes that to 5 bits, but that is
      * for Ultravisor which TCG does not support, so just ignore the top 6.
      */
-    lev = (ctx->opcode >> 5) & 0x1;
-    gen_exception_err(ctx, POWERPC_SYSCALL, lev);
+    uint32_t lev = (ctx->opcode >> 5) & 0x1;
+    gen_exception_err_nip(ctx, POWERPC_SYSCALL, lev, ctx->base.pc_next);
 }
 
 #if defined(TARGET_PPC64)
-- 
2.30.9


