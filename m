Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BCF791482
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:12:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd5Xx-0001MI-MR; Mon, 04 Sep 2023 05:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Xs-0001H5-RZ; Mon, 04 Sep 2023 05:06:56 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Xn-0003ct-P4; Mon, 04 Sep 2023 05:06:56 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RfN6w3kYrz4wy1;
 Mon,  4 Sep 2023 19:06:48 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfN6t4vHNz4wxN;
 Mon,  4 Sep 2023 19:06:46 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 04/35] target/ppc: Improve book3s branch trace interrupt for
 v2.07S
Date: Mon,  4 Sep 2023 11:05:59 +0200
Message-ID: <20230904090630.725952-5-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904090630.725952-1-clg@kaod.org>
References: <20230904090630.725952-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=kZzc=EU=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Improve the emulation accuracy of the single step and branch trace
interrupts for v2.07S. Set SRR1[33]=1, and set SIAR to completed
instruction address.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 target/ppc/helper.h      |  1 +
 target/ppc/excp_helper.c | 16 +++++++++++++++-
 target/ppc/translate.c   | 21 +++++++++++----------
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index abec6fe34190..f4db32ee1a28 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -32,6 +32,7 @@ DEF_HELPER_2(read_pmc, tl, env, i32)
 DEF_HELPER_2(insns_inc, void, env, i32)
 DEF_HELPER_1(handle_pmc5_overflow, void, env)
 #endif
+DEF_HELPER_2(book3s_trace, void, env, tl)
 DEF_HELPER_1(check_tlb_flush_local, void, env)
 DEF_HELPER_1(check_tlb_flush_global, void, env)
 #endif
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 9aa8e465669d..2d6aef5e66c8 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1571,9 +1571,11 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
             }
         }
         break;
+    case POWERPC_EXCP_TRACE:     /* Trace exception                          */
+        msr |= env->error_code;
+        /* fall through */
     case POWERPC_EXCP_DSEG:      /* Data segment exception                   */
     case POWERPC_EXCP_ISEG:      /* Instruction segment exception            */
-    case POWERPC_EXCP_TRACE:     /* Trace exception                          */
     case POWERPC_EXCP_SDOOR:     /* Doorbell interrupt                       */
     case POWERPC_EXCP_PERFM:     /* Performance monitor interrupt            */
         break;
@@ -3168,6 +3170,18 @@ void helper_book3s_msgsndp(CPUPPCState *env, target_ulong rb)
 }
 #endif /* TARGET_PPC64 */
 
+/* Single-step tracing */
+void helper_book3s_trace(CPUPPCState *env, target_ulong prev_ip)
+{
+    uint32_t error_code = 0;
+    if (env->insns_flags2 & PPC2_ISA207S) {
+        /* Load/store reporting, SRR1[35, 36] and SDAR, are not implemented. */
+        env->spr[SPR_POWER_SIAR] = prev_ip;
+        error_code = PPC_BIT(33);
+    }
+    raise_exception_err(env, POWERPC_EXCP_TRACE, error_code);
+}
+
 void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
                                  MMUAccessType access_type,
                                  int mmu_idx, uintptr_t retaddr)
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 06530dd78228..505159667083 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -338,8 +338,9 @@ static void gen_ppc_maybe_interrupt(DisasContext *ctx)
  * The exception can be either POWERPC_EXCP_TRACE (on most PowerPCs) or
  * POWERPC_EXCP_DEBUG (on BookE).
  */
-static uint32_t gen_prep_dbgex(DisasContext *ctx)
+static void gen_debug_exception(DisasContext *ctx)
 {
+#if !defined(CONFIG_USER_ONLY)
     if (ctx->flags & POWERPC_FLAG_DE) {
         target_ulong dbsr = 0;
         if (ctx->singlestep_enabled & CPU_SINGLE_STEP) {
@@ -352,16 +353,16 @@ static uint32_t gen_prep_dbgex(DisasContext *ctx)
         gen_load_spr(t0, SPR_BOOKE_DBSR);
         tcg_gen_ori_tl(t0, t0, dbsr);
         gen_store_spr(SPR_BOOKE_DBSR, t0);
-        return POWERPC_EXCP_DEBUG;
+        gen_helper_raise_exception(cpu_env,
+                                   tcg_constant_i32(POWERPC_EXCP_DEBUG));
+        ctx->base.is_jmp = DISAS_NORETURN;
     } else {
-        return POWERPC_EXCP_TRACE;
+        TCGv t0 = tcg_temp_new();
+        tcg_gen_movi_tl(t0, ctx->cia);
+        gen_helper_book3s_trace(cpu_env, t0);
+        ctx->base.is_jmp = DISAS_NORETURN;
     }
-}
-
-static void gen_debug_exception(DisasContext *ctx)
-{
-    gen_helper_raise_exception(cpu_env, tcg_constant_i32(gen_prep_dbgex(ctx)));
-    ctx->base.is_jmp = DISAS_NORETURN;
+#endif
 }
 
 static inline void gen_inval_exception(DisasContext *ctx, uint32_t error)
@@ -4184,7 +4185,7 @@ static inline bool use_goto_tb(DisasContext *ctx, target_ulong dest)
 static void gen_lookup_and_goto_ptr(DisasContext *ctx)
 {
     if (unlikely(ctx->singlestep_enabled)) {
-        gen_debug_exception(ctx);
+        gen_debug_exception(ctx, false);
     } else {
         /*
          * tcg_gen_lookup_and_goto_ptr will exit the TB if
-- 
2.41.0


