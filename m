Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89752791468
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:10:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd5Xy-0001QH-V0; Mon, 04 Sep 2023 05:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Xu-0001IQ-Sl; Mon, 04 Sep 2023 05:06:59 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Xr-0003df-Ko; Mon, 04 Sep 2023 05:06:58 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RfN711msjz4x2Y;
 Mon,  4 Sep 2023 19:06:53 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfN6z2qDcz4x2D;
 Mon,  4 Sep 2023 19:06:51 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 06/35] target/ppc: Implement breakpoint debug facility for
 v2.07S
Date: Mon,  4 Sep 2023 11:06:01 +0200
Message-ID: <20230904090630.725952-7-clg@kaod.org>
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

ISA v2.07S introduced the breakpoint facility based on the CIABR SPR.
Implement this in TCG.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 target/ppc/cpu.h         |  3 +++
 target/ppc/helper.h      |  1 +
 target/ppc/internal.h    |  2 ++
 target/ppc/spr_common.h  |  1 +
 target/ppc/cpu.c         | 27 ++++++++++++++++++++++++++
 target/ppc/cpu_init.c    |  5 ++++-
 target/ppc/excp_helper.c | 42 ++++++++++++++++++++++++++++++++++++++++
 target/ppc/machine.c     |  4 ++++
 target/ppc/misc_helper.c |  5 +++++
 target/ppc/translate.c   | 10 +++++++++-
 10 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 6826702ea658..264a915ad929 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1137,6 +1137,7 @@ struct CPUArchState {
     /* MMU context, only relevant for full system emulation */
 #if defined(TARGET_PPC64)
     ppc_slb_t slb[MAX_SLB_ENTRIES]; /* PowerPC 64 SLB area */
+    struct CPUBreakpoint *ciabr_breakpoint;
 #endif
     target_ulong sr[32];   /* segment registers */
     uint32_t nb_BATs;      /* number of BATs */
@@ -1403,6 +1404,8 @@ void ppc_translate_init(void);
 #if !defined(CONFIG_USER_ONLY)
 void ppc_store_sdr1(CPUPPCState *env, target_ulong value);
 void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val);
+void ppc_update_ciabr(CPUPPCState *env);
+void ppc_store_ciabr(CPUPPCState *env, target_ulong value);
 #endif /* !defined(CONFIG_USER_ONLY) */
 void ppc_store_msr(CPUPPCState *env, target_ulong value);
 
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index f4db32ee1a28..83d5deec0772 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -25,6 +25,7 @@ DEF_HELPER_1(hrfid, void, env)
 DEF_HELPER_2(rfebb, void, env, tl)
 DEF_HELPER_2(store_lpcr, void, env, tl)
 DEF_HELPER_2(store_pcr, void, env, tl)
+DEF_HELPER_2(store_ciabr, void, env, tl)
 DEF_HELPER_2(store_mmcr0, void, env, tl)
 DEF_HELPER_2(store_mmcr1, void, env, tl)
 DEF_HELPER_3(store_pmc, void, env, i32, i64)
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 57acb3212c71..16f02fd9c47c 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -301,6 +301,8 @@ void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                    MMUAccessType access_type,
                                    int mmu_idx, MemTxAttrs attrs,
                                    MemTxResult response, uintptr_t retaddr);
+void ppc_cpu_debug_excp_handler(CPUState *cs);
+bool ppc_cpu_debug_check_breakpoint(CPUState *cs);
 #endif
 
 FIELD(GER_MSK, XMSK, 0, 4)
diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index 5995070eafe9..b7bedd9ef1db 100644
--- a/target/ppc/spr_common.h
+++ b/target/ppc/spr_common.h
@@ -159,6 +159,7 @@ void spr_read_mas73(DisasContext *ctx, int gprn, int sprn);
 #ifdef TARGET_PPC64
 void spr_read_cfar(DisasContext *ctx, int gprn, int sprn);
 void spr_write_cfar(DisasContext *ctx, int sprn, int gprn);
+void spr_write_ciabr(DisasContext *ctx, int sprn, int gprn);
 void spr_write_ureg(DisasContext *ctx, int sprn, int gprn);
 void spr_read_purr(DisasContext *ctx, int gprn, int sprn);
 void spr_write_purr(DisasContext *ctx, int sprn, int gprn);
diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index 424f2e174160..d9c665ce1819 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -102,6 +102,33 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val)
 
     ppc_maybe_interrupt(env);
 }
+
+#if defined(TARGET_PPC64)
+void ppc_update_ciabr(CPUPPCState *env)
+{
+    CPUState *cs = env_cpu(env);
+    target_ulong ciabr = env->spr[SPR_CIABR];
+    target_ulong ciea, priv;
+
+    ciea = ciabr & PPC_BITMASK(0, 61);
+    priv = ciabr & PPC_BITMASK(62, 63);
+
+    if (env->ciabr_breakpoint) {
+        cpu_breakpoint_remove_by_ref(cs, env->ciabr_breakpoint);
+        env->ciabr_breakpoint = NULL;
+    }
+
+    if (priv) {
+        cpu_breakpoint_insert(cs, ciea, BP_CPU, &env->ciabr_breakpoint);
+    }
+}
+
+void ppc_store_ciabr(CPUPPCState *env, target_ulong val)
+{
+    env->spr[SPR_CIABR] = val;
+    ppc_update_ciabr(env);
+}
+#endif
 #endif
 
 static inline void fpscr_set_rounding_mode(CPUPPCState *env)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 3b6ccb5ea4e6..18b4757faa87 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5127,7 +5127,7 @@ static void register_book3s_207_dbg_sprs(CPUPPCState *env)
     spr_register_kvm_hv(env, SPR_CIABR, "CIABR",
                         SPR_NOACCESS, SPR_NOACCESS,
                         SPR_NOACCESS, SPR_NOACCESS,
-                        &spr_read_generic, &spr_write_generic,
+                        &spr_read_generic, &spr_write_ciabr,
                         KVM_REG_PPC_CIABR, 0x00000000);
 }
 
@@ -7159,6 +7159,7 @@ static void ppc_cpu_reset_hold(Object *obj)
     env->nip = env->hreset_vector | env->excp_prefix;
 
     if (tcg_enabled()) {
+        cpu_breakpoint_remove_all(s, BP_CPU);
         if (env->mmu_model != POWERPC_MMU_REAL) {
             ppc_tlb_invalidate_all(env);
         }
@@ -7346,6 +7347,8 @@ static const struct TCGCPUOps ppc_tcg_ops = {
   .cpu_exec_exit = ppc_cpu_exec_exit,
   .do_unaligned_access = ppc_cpu_do_unaligned_access,
   .do_transaction_failed = ppc_cpu_do_transaction_failed,
+  .debug_excp_handler = ppc_cpu_debug_excp_handler,
+  .debug_check_breakpoint = ppc_cpu_debug_check_breakpoint,
 #endif /* !CONFIG_USER_ONLY */
 };
 #endif /* CONFIG_TCG */
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 2d6aef5e66c8..9c9881ae19e1 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -3257,5 +3257,47 @@ void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
     cs->exception_index = POWERPC_EXCP_MCHECK;
     cpu_loop_exit_restore(cs, retaddr);
 }
+
+void ppc_cpu_debug_excp_handler(CPUState *cs)
+{
+#if defined(TARGET_PPC64)
+    CPUPPCState *env = cs->env_ptr;
+
+    if (env->insns_flags2 & PPC2_ISA207S) {
+        if (cpu_breakpoint_test(cs, env->nip, BP_CPU)) {
+            raise_exception_err(env, POWERPC_EXCP_TRACE,
+                                PPC_BIT(33) | PPC_BIT(43));
+        }
+    }
+#endif
+}
+
+bool ppc_cpu_debug_check_breakpoint(CPUState *cs)
+{
+#if defined(TARGET_PPC64)
+    CPUPPCState *env = cs->env_ptr;
+
+    if (env->insns_flags2 & PPC2_ISA207S) {
+        target_ulong priv;
+
+        priv = env->spr[SPR_CIABR] & PPC_BITMASK(62, 63);
+        switch (priv) {
+        case 0x1: /* problem */
+            return env->msr & ((target_ulong)1 << MSR_PR);
+        case 0x2: /* supervisor */
+            return (!(env->msr & ((target_ulong)1 << MSR_PR)) &&
+                    !(env->msr & ((target_ulong)1 << MSR_HV)));
+        case 0x3: /* hypervisor */
+            return (!(env->msr & ((target_ulong)1 << MSR_PR)) &&
+                     (env->msr & ((target_ulong)1 << MSR_HV)));
+        default:
+            g_assert_not_reached();
+        }
+    }
+#endif
+
+    return false;
+}
+
 #endif /* CONFIG_TCG */
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 134b16c6255f..560a8754549f 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -314,6 +314,10 @@ static int cpu_post_load(void *opaque, int version_id)
     post_load_update_msr(env);
 
     if (tcg_enabled()) {
+        /* Re-set breaks based on regs */
+#if defined(TARGET_PPC64)
+        ppc_update_ciabr(env);
+#endif
         pmu_mmcr01_updated(env);
     }
 
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 692d0586657e..0b0f2e59a7f2 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -199,6 +199,11 @@ void helper_store_pcr(CPUPPCState *env, target_ulong value)
     env->spr[SPR_PCR] = value & pcc->pcr_mask;
 }
 
+void helper_store_ciabr(CPUPPCState *env, target_ulong value)
+{
+    ppc_store_ciabr(env, value);
+}
+
 /*
  * DPDES register is shared. Each bit reflects the state of the
  * doorbell interrupt of a thread of the same core.
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 6e8f1797ac95..69dd1ba03648 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -559,8 +559,9 @@ void spr_write_lr(DisasContext *ctx, int sprn, int gprn)
     tcg_gen_mov_tl(cpu_lr, cpu_gpr[gprn]);
 }
 
-/* CFAR */
 #if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
+/* Debug facilities */
+/* CFAR */
 void spr_read_cfar(DisasContext *ctx, int gprn, int sprn)
 {
     tcg_gen_mov_tl(cpu_gpr[gprn], cpu_cfar);
@@ -570,6 +571,13 @@ void spr_write_cfar(DisasContext *ctx, int sprn, int gprn)
 {
     tcg_gen_mov_tl(cpu_cfar, cpu_gpr[gprn]);
 }
+
+/* Breakpoint */
+void spr_write_ciabr(DisasContext *ctx, int sprn, int gprn)
+{
+    translator_io_start(&ctx->base);
+    gen_helper_store_ciabr(cpu_env, cpu_gpr[gprn]);
+}
 #endif /* defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY) */
 
 /* CTR */
-- 
2.41.0


