Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C24773776
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:15:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTD8P-0008Ns-1o; Mon, 07 Aug 2023 23:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTD8M-0008Ma-S8; Mon, 07 Aug 2023 23:11:46 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTD8K-00006W-Rh; Mon, 07 Aug 2023 23:11:46 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-686f1240a22so5036671b3a.0; 
 Mon, 07 Aug 2023 20:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691464303; x=1692069103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w1q5Gsi/L3hnN6qOaWO0OZSWxAFKtlVpAZ7WsDVYQCY=;
 b=ObQ5J7ws7qyYD2MmWZxAFGTSDQDFoSM3wtBdCtGoXiQepjbrJSrytqJNZkjnARGFG3
 W3VZPY9a2VB1BPo+4AQHMjMKRJ/VPVxTwo+R6WUuKfDERAwnAYLD1L8FxOsCu0JRfrcg
 ACjKMETWS0p9EX5bn3jzakzX/BH2wdfvc+AvFo6jqelgANMY2am3KKB7ygJIUFNL+4F7
 hcqzqe9jy+aD7fMIlwXp/5JMQnXnH4n2jbk3ssgXQAQyUTlCk1Y22DGmDWD7F536NaVf
 8ylF/KrGiwMOZpCcOSW9DCxdBWaOphGxPQI2u2t+o0JIWlaGCZYhZ/NNyhsWN97oAL+K
 yOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691464303; x=1692069103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w1q5Gsi/L3hnN6qOaWO0OZSWxAFKtlVpAZ7WsDVYQCY=;
 b=JVyDpXxSova3fNtUaqEi5NcNCn2MUfE7B8dH2VN0AFEuxR7hBRBbMJVHHo1YZ8leLL
 FW5rbnuMK4itOjFt4qsTQ0Ani3yEio85nuR0i/a6Dr9KMAD2k0sHtRaWqIGU6zRELZ32
 rPcmvCbLcF84aqJRZogKXZLDKZle+6uCqKZe2nHuHEdjNx9nCyVGKhVW26peiMkIPmtS
 DBeFCRF5nnQdU5Z80+jH5WNSTXMCA00URSUtALdtUScjW2cFAzIiQIVmwseuJHe/Zlbj
 P6df8Mgoc4Pd25Asbikg0sLvFW8U4T+NlDOqyFp4hg8h1VMHbJ1Z7l+7f0OiwC4j1RFJ
 y7PQ==
X-Gm-Message-State: AOJu0Yz9zl93zDCjk6SjTMRLoX+KbymCs6aTI8Ja1QU5UeOCxH3gWUz0
 wQ+1OrQrMbhvYWmCiPm7m1o=
X-Google-Smtp-Source: AGHT+IGqkq5CCb4Mw1gbSE3q/qtW3ByEdh9vfhNn7npF/OCmCNM9pDCTA9Km2pLPSHaySoO41WAoow==
X-Received: by 2002:a05:6a20:258b:b0:13e:e3aa:d871 with SMTP id
 k11-20020a056a20258b00b0013ee3aad871mr14458846pzd.53.1691464303125; 
 Mon, 07 Aug 2023 20:11:43 -0700 (PDT)
Received: from wheely.local0.net (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 i21-20020aa79095000000b00687ce7c6540sm482642pfa.99.2023.08.07.20.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 20:11:42 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 4/6] target/ppc: Implement breakpoint debug facility for v2.07S
Date: Tue,  8 Aug 2023 13:11:14 +1000
Message-Id: <20230808031116.398205-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808031116.398205-1-npiggin@gmail.com>
References: <20230808031116.398205-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
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

ISA v2.07S introduced the breakpoint facility based on the CIABR SPR.
Implement this in TCG.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.c         | 27 ++++++++++++++++++++++++++
 target/ppc/cpu.h         |  3 +++
 target/ppc/cpu_init.c    |  5 ++++-
 target/ppc/excp_helper.c | 42 ++++++++++++++++++++++++++++++++++++++++
 target/ppc/helper.h      |  1 +
 target/ppc/internal.h    |  2 ++
 target/ppc/machine.c     |  4 ++++
 target/ppc/misc_helper.c |  5 +++++
 target/ppc/spr_common.h  |  1 +
 target/ppc/translate.c   | 10 +++++++++-
 10 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index 424f2e1741..d9c665ce18 100644
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
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 25fac9577a..d97fabd8f6 100644
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
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 02b7aad9b0..a2820839b3 100644
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
 
@@ -7149,6 +7149,7 @@ static void ppc_cpu_reset_hold(Object *obj)
     env->nip = env->hreset_vector | env->excp_prefix;
 
     if (tcg_enabled()) {
+        cpu_breakpoint_remove_all(s, BP_CPU);
         if (env->mmu_model != POWERPC_MMU_REAL) {
             ppc_tlb_invalidate_all(env);
         }
@@ -7336,6 +7337,8 @@ static const struct TCGCPUOps ppc_tcg_ops = {
   .cpu_exec_exit = ppc_cpu_exec_exit,
   .do_unaligned_access = ppc_cpu_do_unaligned_access,
   .do_transaction_failed = ppc_cpu_do_transaction_failed,
+  .debug_excp_handler = ppc_cpu_debug_excp_handler,
+  .debug_check_breakpoint = ppc_cpu_debug_check_breakpoint,
 #endif /* !CONFIG_USER_ONLY */
 };
 #endif /* CONFIG_TCG */
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 2d6aef5e66..9c9881ae19 100644
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
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index f4db32ee1a..83d5deec07 100644
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
index 57acb3212c..16f02fd9c4 100644
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
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 134b16c625..560a875454 100644
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
index 692d058665..0b0f2e59a7 100644
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
diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index 5995070eaf..b7bedd9ef1 100644
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
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 6e8f1797ac..69dd1ba036 100644
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
2.40.1


