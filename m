Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 235A677378A
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:18:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTD8a-0000F8-MV; Mon, 07 Aug 2023 23:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTD8W-0000Ac-Lg; Mon, 07 Aug 2023 23:11:56 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTD8P-00008Y-6S; Mon, 07 Aug 2023 23:11:56 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-686ed1d2594so5018717b3a.2; 
 Mon, 07 Aug 2023 20:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691464307; x=1692069107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ubGDB2qj8/qo/M7/3E+WlIgrPNVGuE9tGgWRkmW+aeo=;
 b=W+97vf+P6yxlzhVdPA8EnJ7g5Qpc/6jARDmmdKk4JEAQMQOTWScsT7B2xHZWJRX65v
 4YESCxDmTkxpRKuRo3kg0oynq9DZGxdazN++A3ILWQUf7t4VnsEpoJuKEphJb/GGT5KC
 MIUDPp+GdLfAC68rAYbpTPLNJqTMhpqjVNhWjJNS4yo092r4NqbFZM9tXIsqhLj3/qyU
 MVnKtkIu0U7yUM/LqEaws72phF3f46v64DqqxT1KbLGUDWbbiOakzJp/cjDTh/HRQeeF
 Vjs5N2/2BwObryANLfUZRABCslcKF6cLUngwWLzf/WT7p7hw73xRkE0Qe12olznOZRYJ
 WVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691464307; x=1692069107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ubGDB2qj8/qo/M7/3E+WlIgrPNVGuE9tGgWRkmW+aeo=;
 b=QAs61S4tKztSm6QBeNG+YyPC9LBM7JOSmkuxA8Qps3ocMDmbwDPfKUX9f+6Us8eRDk
 Mv5HXMCBIRpWR8hxFHdX8XKWp/V43IK/B5NzLeuINUUZpYEPD/UGUU0HUKk2p5thcY/U
 jsTVds4V/ZffT5ZuXBR6irgAoAqjhmh/XPXLEnHkJFKSBI+dqkjk2Sm2vm+KUG1v1BsO
 bpZK9Uw+xoHslOGzTrMwpxXnTnftmJ7YKO90yEMHGjrM5n6Bi96Cw/n/akkYV7KRfQ1Z
 Gkaw23c4aNPlHQb1nm5wWGZdfrY/wsrvtgz627zOX/VfR4wgMrTpsYXG31e73zuMX1U0
 ybBw==
X-Gm-Message-State: AOJu0YzsyEV0QzoOfvFBPhpuhH40jRJWI72CHlP5OnTjAnHXRi2vuT60
 UePI97Z/REvsI1UmCacXHME=
X-Google-Smtp-Source: AGHT+IHemeHd2yw143JuZGoW9Q76hNA2DX5rkCaDB6AUHpCIYR5W/WCA6YslUTb8k8JP1ccw0LdaWQ==
X-Received: by 2002:a05:6a21:6da6:b0:140:54ab:7f3f with SMTP id
 wl38-20020a056a216da600b0014054ab7f3fmr11142392pzb.50.1691464307572; 
 Mon, 07 Aug 2023 20:11:47 -0700 (PDT)
Received: from wheely.local0.net (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 i21-20020aa79095000000b00687ce7c6540sm482642pfa.99.2023.08.07.20.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 20:11:47 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 5/6] target/ppc: Implement watchpoint debug facility for v2.07S
Date: Tue,  8 Aug 2023 13:11:15 +1000
Message-Id: <20230808031116.398205-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808031116.398205-1-npiggin@gmail.com>
References: <20230808031116.398205-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

ISA v2.07S introduced the watchpoint facility based on the DAWR0
and DAWRX0 SPRs. Implement this in TCG.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.c         | 59 ++++++++++++++++++++++++++++++++++++++++
 target/ppc/cpu.h         |  4 +++
 target/ppc/cpu_init.c    |  6 ++--
 target/ppc/excp_helper.c | 52 ++++++++++++++++++++++++++++++++++-
 target/ppc/helper.h      |  2 ++
 target/ppc/internal.h    |  1 +
 target/ppc/machine.c     |  1 +
 target/ppc/misc_helper.c | 10 +++++++
 target/ppc/spr_common.h  |  2 ++
 target/ppc/translate.c   | 13 +++++++++
 10 files changed, 147 insertions(+), 3 deletions(-)

diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index d9c665ce18..62e1c15e3d 100644
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
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index d97fabd8f6..2777ea3110 100644
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
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index a2820839b3..9c1c045d1b 100644
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
@@ -7150,6 +7150,7 @@ static void ppc_cpu_reset_hold(Object *obj)
 
     if (tcg_enabled()) {
         cpu_breakpoint_remove_all(s, BP_CPU);
+        cpu_watchpoint_remove_all(s, BP_CPU);
         if (env->mmu_model != POWERPC_MMU_REAL) {
             ppc_tlb_invalidate_all(env);
         }
@@ -7339,6 +7340,7 @@ static const struct TCGCPUOps ppc_tcg_ops = {
   .do_transaction_failed = ppc_cpu_do_transaction_failed,
   .debug_excp_handler = ppc_cpu_debug_excp_handler,
   .debug_check_breakpoint = ppc_cpu_debug_check_breakpoint,
+  .debug_check_watchpoint = ppc_cpu_debug_check_watchpoint,
 #endif /* !CONFIG_USER_ONLY */
 };
 #endif /* CONFIG_TCG */
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 9c9881ae19..32e46e56b3 100644
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
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 83d5deec07..86f97ee1e7 100644
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
index 16f02fd9c4..15803bc313 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -303,6 +303,7 @@ void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                    MemTxResult response, uintptr_t retaddr);
 void ppc_cpu_debug_excp_handler(CPUState *cs);
 bool ppc_cpu_debug_check_breakpoint(CPUState *cs);
+bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
 #endif
 
 FIELD(GER_MSK, XMSK, 0, 4)
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 560a875454..8234e35d69 100644
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
index 0b0f2e59a7..a05bdf78c9 100644
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
diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index b7bedd9ef1..8a9d6cd994 100644
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
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 69dd1ba036..b8c7f38ccd 100644
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
2.40.1


