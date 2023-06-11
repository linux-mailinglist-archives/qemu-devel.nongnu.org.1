Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9D572B4A8
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 00:44:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8Tlm-0000JK-Ts; Sun, 11 Jun 2023 18:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q8Tll-0000Gb-3F; Sun, 11 Jun 2023 18:42:45 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q8Tlj-0004i7-DG; Sun, 11 Jun 2023 18:42:44 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id B6591748A6E;
 Mon, 12 Jun 2023 00:42:38 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 92CB9748A6D; Mon, 12 Jun 2023 00:42:38 +0200 (CEST)
Message-Id: <7ae167986e18144bc665bbdd836b49fe723a90a1.1686522199.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1686522199.git.balaton@eik.bme.hu>
References: <cover.1686522199.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 08/10] target/ppc: Fix gen_sc to use correct nip
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 12 Jun 2023 00:42:38 +0200 (CEST)
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

Most exceptions are raised with nip pointing to the faulting
instruction but the sc instruction generating a syscall exception
leaves nip pointing to next instruction. Fix gen_sc to not use
gen_exception_err() which sets nip back but correctly set nip to
pc_next so we don't have to patch this in the exception handlers.

This changes the nip logged in dump_syscall and dump_hcall debug
functions but now this matches how nip would be on a real CPU.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/excp_helper.c | 39 ---------------------------------------
 target/ppc/translate.c   |  8 +++++---
 2 files changed, 5 insertions(+), 42 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 885e479301..4f6a6dfb19 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -493,12 +493,6 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
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
@@ -609,12 +603,6 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
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
@@ -757,13 +745,6 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
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
@@ -908,13 +889,6 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
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
@@ -1073,12 +1047,6 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
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
@@ -1320,13 +1288,6 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
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
index a32a9b8a5f..4260d3d66f 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4419,10 +4419,12 @@ static void gen_hrfid(DisasContext *ctx)
 #endif
 static void gen_sc(DisasContext *ctx)
 {
-    uint32_t lev;
+    uint32_t lev = (ctx->opcode >> 5) & 0x7F;
 
-    lev = (ctx->opcode >> 5) & 0x7F;
-    gen_exception_err(ctx, POWERPC_SYSCALL, lev);
+    gen_update_nip(ctx, ctx->base.pc_next);
+    gen_helper_raise_exception_err(cpu_env, tcg_constant_i32(POWERPC_SYSCALL),
+                                   tcg_constant_i32(lev));
+    ctx->base.is_jmp = DISAS_NORETURN;
 }
 
 #if defined(TARGET_PPC64)
-- 
2.30.9


