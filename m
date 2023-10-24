Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9157D56A4
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:37:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJQn-00078D-DX; Tue, 24 Oct 2023 11:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qvJQ8-0006Ie-JV; Tue, 24 Oct 2023 11:34:18 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qvJPz-0005jb-LY; Tue, 24 Oct 2023 11:34:15 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id D770F7560A8;
 Tue, 24 Oct 2023 17:34:04 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AF0DB7560A7; Tue, 24 Oct 2023 17:34:04 +0200 (CEST)
Message-Id: <2b1cde3a3a2b0c621ebffce73a13fde0ba0103ba.1698158152.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1698158152.git.balaton@eik.bme.hu>
References: <cover.1698158152.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 3/8] target/ppc: Fix gen_sc to use correct nip
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 24 Oct 2023 17:34:04 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

This changes the nip logged in dump_syscall and dump_hcall debug
functions but now this matches how nip would be on a real CPU.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/excp_helper.c | 39 ---------------------------------------
 target/ppc/translate.c   | 10 ++++++----
 2 files changed, 6 insertions(+), 43 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index a92a2170d8..22361b6c17 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
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


