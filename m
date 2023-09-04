Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F75791476
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:11:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd5Y2-0001YC-80; Mon, 04 Sep 2023 05:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Xy-0001R6-6w; Mon, 04 Sep 2023 05:07:02 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Xu-0003eA-U3; Mon, 04 Sep 2023 05:07:01 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RfN734HD0z4wxN;
 Mon,  4 Sep 2023 19:06:55 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfN715TGTz4x2D;
 Mon,  4 Sep 2023 19:06:53 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 07/35] target/ppc: Implement watchpoint debug facility for
 v2.07S
Date: Mon,  4 Sep 2023 11:06:02 +0200
Message-ID: <20230904090630.725952-8-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904090630.725952-1-clg@kaod.org>
References: <20230904090630.725952-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=kZzc=EU=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ISA v2.07S introduced the watchpoint facility based on the DAWR0
and DAWRX0 SPRs. Implement this in TCG.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 target/ppc/cpu.h         |  4 +++
 target/ppc/helper.h      |  2 ++
 target/ppc/internal.h    |  1 +
 target/ppc/spr_common.h  |  2 ++
 target/ppc/cpu.c         | 59 ++++++++++++++++++++++++++++++++++++++++
 target/ppc/cpu_init.c    |  6 ++--
 target/ppc/excp_helper.c | 52 ++++++++++++++++++++++++++++++++++-
 target/ppc/machine.c     |  1 +
 target/ppc/misc_helper.c | 10 +++++++
 target/ppc/translate.c   | 13 +++++++++
 10 files changed, 147 insertions(+), 3 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 264a915ad929..7e7a60f68f79 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1138,6 +1138,7 @@ struct CPUArchState {
 #if defined(TARGET_PPC64)
     ppc_slb_t slb[MAX_SLB_ENTRIES]; /* PowerPC 64 SLB area */
     struct CPUBreakpoint *ciabr_breakpoint;
+    struct CPUWatchpoint *dawr0_watchpoint;
 #endif
     target_ulong sr[32];   /* segment registers */
     uint32_t nb_BATs;      /* number of BATs */
@@ -1406,6 +1407,9 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong value);
 void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val);
 void ppc_update_ciabr(CPUPPCState *env);
 void ppc_store_ciabr(CPUPPCState *env, target_ulong value);
+void ppc_update_daw0(CPUPPCState *env);
+void ppc_store_dawr0(CPUPPCState *env, target_ulong value);
+void ppc_store_dawrx0(CPUPPCState *env, uint32_t value);
 #endif /* !defined(CONFIG_USER_ONLY) */
 void ppc_store_msr(CPUPPCState *env, target_ulong value);
 
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 83d5deec0772..86f97ee1e78b 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -26,6 +26,8 @@ DEF_HELPER_2(rfebb, void, env, tl)
 DEF_HELPER_2(store_lpcr, void, env, tl)
 DEF_HELPER_2(store_pcr, void, env, tl)
 DEF_HELPER_2(store_ciabr, void, env, tl)
+DEF_HELPER_2(store_dawr0, void, env, tl)
+DEF_HELPER_2(store_dawrx0, void, env, tl)
 DEF_HELPER_2(store_mmcr0, void, env, tl)
 DEF_HELPER_2(store_mmcr1, void, env, tl)
 DEF_HELPER_3(store_pmc, void, env, i32, i64)
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 16f02fd9c47c..15803bc3136b 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -303,6 +303,7 @@ void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                    MemTxResult response, uintptr_t retaddr);
 void ppc_cpu_debug_excp_handler(CPUState *cs);
 bool ppc_cpu_debug_check_breakpoint(CPUState *cs);
+bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
 #endif
 
 FIELD(GER_MSK, XMSK, 0, 4)
diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index b7bedd9ef1db..8a9d6cd994ca 100644
--- a/target/ppc/spr_common.h
+++ b/target/ppc/spr_common.h
@@ -160,6 +160,8 @@ void spr_read_mas73(DisasContext *ctx, int gprn, int sprn);
 void spr_read_cfar(DisasContext *ctx, int gprn, int sprn);
 void spr_write_cfar(DisasContext *ctx, int sprn, int gprn);
 void spr_write_ciabr(DisasContext *ctx, int sprn, int gprn);
+void spr_write_dawr0(DisasContext *ctx, int sprn, int gprn);
+void spr_write_dawrx0(DisasContext *ctx, int sprn, int gprn);
 void spr_write_ureg(DisasContext *ctx, int sprn, int gprn);
 void spr_read_purr(DisasContext *ctx, int gprn, int sprn);
 void spr_write_purr(DisasContext *ctx, int sprn, int gprn);
diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index d9c665ce1819..62e1c15e3d33 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -128,6 +128,65 @@ void ppc_store_ciabr(CPUPPCState *env, target_ulong val)
     env->spr[SPR_CIABR] = val;
     ppc_update_ciabr(env);
 }
+
+void ppc_update_daw0(CPUPPCState *env)
+{
+    CPUState *cs = env_cpu(env);
+    target_ulong deaw = env->spr[SPR_DAWR0] & PPC_BITMASK(0, 60);
+    uint32_t dawrx = env->spr[SPR_DAWRX0];
+    int mrd = extract32(dawrx, PPC_BIT_NR(48), 54 - 48);
+    bool dw = extract32(dawrx, PPC_BIT_NR(57), 1);
+    bool dr = extract32(dawrx, PPC_BIT_NR(58), 1);
+    bool hv = extract32(dawrx, PPC_BIT_NR(61), 1);
+    bool sv = extract32(dawrx, PPC_BIT_NR(62), 1);
+    bool pr = extract32(dawrx, PPC_BIT_NR(62), 1);
+    vaddr len;
+    int flags;
+
+    if (env->dawr0_watchpoint) {
+        cpu_watchpoint_remove_by_ref(cs, env->dawr0_watchpoint);
+        env->dawr0_watchpoint = NULL;
+    }
+
+    if (!dr && !dw) {
+        return;
+    }
+
+    if (!hv && !sv && !pr) {
+        return;
+    }
+
+    len = (mrd + 1) * 8;
+    flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
+    if (dr) {
+        flags |= BP_MEM_READ;
+    }
+    if (dw) {
+        flags |= BP_MEM_WRITE;
+    }
+
+    cpu_watchpoint_insert(cs, deaw, len, flags, &env->dawr0_watchpoint);
+}
+
+void ppc_store_dawr0(CPUPPCState *env, target_ulong val)
+{
+    env->spr[SPR_DAWR0] = val;
+    ppc_update_daw0(env);
+}
+
+void ppc_store_dawrx0(CPUPPCState *env, uint32_t val)
+{
+    int hrammc = extract32(val, PPC_BIT_NR(56), 1);
+
+    if (hrammc) {
+        /* This might be done with a second watchpoint at the xor of DEAW[0] */
+        qemu_log_mask(LOG_UNIMP, "%s: DAWRX0[HRAMMC] is unimplemented\n",
+                      __func__);
+    }
+
+    env->spr[SPR_DAWRX0] = val;
+    ppc_update_daw0(env);
+}
 #endif
 #endif
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 18b4757faa87..7ab5ee92d90b 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5117,12 +5117,12 @@ static void register_book3s_207_dbg_sprs(CPUPPCState *env)
     spr_register_kvm_hv(env, SPR_DAWR0, "DAWR0",
                         SPR_NOACCESS, SPR_NOACCESS,
                         SPR_NOACCESS, SPR_NOACCESS,
-                        &spr_read_generic, &spr_write_generic,
+                        &spr_read_generic, &spr_write_dawr0,
                         KVM_REG_PPC_DAWR, 0x00000000);
     spr_register_kvm_hv(env, SPR_DAWRX0, "DAWRX0",
                         SPR_NOACCESS, SPR_NOACCESS,
                         SPR_NOACCESS, SPR_NOACCESS,
-                        &spr_read_generic, &spr_write_generic32,
+                        &spr_read_generic, &spr_write_dawrx0,
                         KVM_REG_PPC_DAWRX, 0x00000000);
     spr_register_kvm_hv(env, SPR_CIABR, "CIABR",
                         SPR_NOACCESS, SPR_NOACCESS,
@@ -7160,6 +7160,7 @@ static void ppc_cpu_reset_hold(Object *obj)
 
     if (tcg_enabled()) {
         cpu_breakpoint_remove_all(s, BP_CPU);
+        cpu_watchpoint_remove_all(s, BP_CPU);
         if (env->mmu_model != POWERPC_MMU_REAL) {
             ppc_tlb_invalidate_all(env);
         }
@@ -7349,6 +7350,7 @@ static const struct TCGCPUOps ppc_tcg_ops = {
   .do_transaction_failed = ppc_cpu_do_transaction_failed,
   .debug_excp_handler = ppc_cpu_debug_excp_handler,
   .debug_check_breakpoint = ppc_cpu_debug_check_breakpoint,
+  .debug_check_watchpoint = ppc_cpu_debug_check_watchpoint,
 #endif /* !CONFIG_USER_ONLY */
 };
 #endif /* CONFIG_TCG */
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 9c9881ae19e1..32e46e56b3fc 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -3264,7 +3264,15 @@ void ppc_cpu_debug_excp_handler(CPUState *cs)
     CPUPPCState *env = cs->env_ptr;
 
     if (env->insns_flags2 & PPC2_ISA207S) {
-        if (cpu_breakpoint_test(cs, env->nip, BP_CPU)) {
+        if (cs->watchpoint_hit) {
+            if (cs->watchpoint_hit->flags & BP_CPU) {
+                env->spr[SPR_DAR] = cs->watchpoint_hit->hitaddr;
+                env->spr[SPR_DSISR] = PPC_BIT(41);
+                cs->watchpoint_hit = NULL;
+                raise_exception(env, POWERPC_EXCP_DSI);
+            }
+            cs->watchpoint_hit = NULL;
+        } else if (cpu_breakpoint_test(cs, env->nip, BP_CPU)) {
             raise_exception_err(env, POWERPC_EXCP_TRACE,
                                 PPC_BIT(33) | PPC_BIT(43));
         }
@@ -3299,5 +3307,47 @@ bool ppc_cpu_debug_check_breakpoint(CPUState *cs)
     return false;
 }
 
+bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
+{
+#if defined(TARGET_PPC64)
+    CPUPPCState *env = cs->env_ptr;
+
+    if (env->insns_flags2 & PPC2_ISA207S) {
+        if (wp == env->dawr0_watchpoint) {
+            uint32_t dawrx = env->spr[SPR_DAWRX0];
+            bool wt = extract32(dawrx, PPC_BIT_NR(59), 1);
+            bool wti = extract32(dawrx, PPC_BIT_NR(60), 1);
+            bool hv = extract32(dawrx, PPC_BIT_NR(61), 1);
+            bool sv = extract32(dawrx, PPC_BIT_NR(62), 1);
+            bool pr = extract32(dawrx, PPC_BIT_NR(62), 1);
+
+            if ((env->msr & ((target_ulong)1 << MSR_PR)) && !pr) {
+                return false;
+            } else if ((env->msr & ((target_ulong)1 << MSR_HV)) && !hv) {
+                return false;
+            } else if (!sv) {
+                return false;
+            }
+
+            if (!wti) {
+                if (env->msr & ((target_ulong)1 << MSR_DR)) {
+                    if (!wt) {
+                        return false;
+                    }
+                } else {
+                    if (wt) {
+                        return false;
+                    }
+                }
+            }
+
+            return true;
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
index 560a8754549f..8234e35d69f8 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -317,6 +317,7 @@ static int cpu_post_load(void *opaque, int version_id)
         /* Re-set breaks based on regs */
 #if defined(TARGET_PPC64)
         ppc_update_ciabr(env);
+        ppc_update_daw0(env);
 #endif
         pmu_mmcr01_updated(env);
     }
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 0b0f2e59a7f2..a05bdf78c982 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -204,6 +204,16 @@ void helper_store_ciabr(CPUPPCState *env, target_ulong value)
     ppc_store_ciabr(env, value);
 }
 
+void helper_store_dawr0(CPUPPCState *env, target_ulong value)
+{
+    ppc_store_dawr0(env, value);
+}
+
+void helper_store_dawrx0(CPUPPCState *env, target_ulong value)
+{
+    ppc_store_dawrx0(env, value);
+}
+
 /*
  * DPDES register is shared. Each bit reflects the state of the
  * doorbell interrupt of a thread of the same core.
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 69dd1ba03648..b8c7f38ccdec 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -578,6 +578,19 @@ void spr_write_ciabr(DisasContext *ctx, int sprn, int gprn)
     translator_io_start(&ctx->base);
     gen_helper_store_ciabr(cpu_env, cpu_gpr[gprn]);
 }
+
+/* Watchpoint */
+void spr_write_dawr0(DisasContext *ctx, int sprn, int gprn)
+{
+    translator_io_start(&ctx->base);
+    gen_helper_store_dawr0(cpu_env, cpu_gpr[gprn]);
+}
+
+void spr_write_dawrx0(DisasContext *ctx, int sprn, int gprn)
+{
+    translator_io_start(&ctx->base);
+    gen_helper_store_dawrx0(cpu_env, cpu_gpr[gprn]);
+}
 #endif /* defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY) */
 
 /* CTR */
-- 
2.41.0


