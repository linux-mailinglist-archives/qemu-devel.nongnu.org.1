Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B603883214A
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 23:03:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQaSR-0006yj-7j; Thu, 18 Jan 2024 17:01:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rQaSO-0006xg-Ko; Thu, 18 Jan 2024 17:01:52 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rQaSM-00055r-Ev; Thu, 18 Jan 2024 17:01:52 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7702D4E620A;
 Thu, 18 Jan 2024 23:01:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id y02lN4TyEZA8; Thu, 18 Jan 2024 23:01:45 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 830254E610E; Thu, 18 Jan 2024 23:01:45 +0100 (CET)
Message-Id: <d4067e4a11eeecd5902abfbdd22273020c6cb115.1705614747.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1705614747.git.balaton@eik.bme.hu>
References: <cover.1705614747.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 3/9] target/ppc: Fix gen_sc to use correct nip
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org
Date: Thu, 18 Jan 2024 23:01:45 +0100 (CET)
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

Most exceptions are raised with nip pointing to the faulting
instruction but the sc instruction generating a syscall exception
leaves nip pointing to next instruction. Fix gen_sc to not use
gen_exception_err() which sets nip back but correctly set nip to
pc_next so we don't have to patch this in the exception handlers.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 43 ++--------------------------------------
 target/ppc/translate.c   | 10 ++++++----
 2 files changed, 8 insertions(+), 45 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 39eefc168a..1c07a11405 100644
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
@@ -1418,13 +1386,6 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
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
index 329da4d518..a80d24143e 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4535,15 +4535,17 @@ static void gen_hrfid(DisasContext *ctx)
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
+
+    gen_update_nip(ctx, ctx->base.pc_next);
+    gen_helper_raise_exception_err(tcg_env, tcg_constant_i32(POWERPC_SYSCALL),
+                                   tcg_constant_i32(lev));
+    ctx->base.is_jmp = DISAS_NORETURN;
 }
 
 #if defined(TARGET_PPC64)
-- 
2.30.9


