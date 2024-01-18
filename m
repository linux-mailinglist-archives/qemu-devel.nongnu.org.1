Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A9C831C1B
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:13:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQU00-0008TP-QL; Thu, 18 Jan 2024 10:08:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTzw-0008S5-W2; Thu, 18 Jan 2024 10:08:05 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTzu-00086q-Ma; Thu, 18 Jan 2024 10:08:04 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d70c3c2212so3780265ad.1; 
 Thu, 18 Jan 2024 07:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705590480; x=1706195280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2YjxijclcunGwfkEQlW4kE3mu67VAm4WZYc/rA6lfYc=;
 b=cxwmeJp1xJN6rejsvVS8hR0O95mhZVrjxWlz+5FfS99eGHjB3RIgtnC+YU4WjMAHkE
 9fzdn2/Q10JZRTVgW1gAe0AklclWmhh/+gryAh7s9D/6rjJWt2WRZd1tVM+FHuBWmYl2
 uP/F8H9BPXQZXy5tq/FBlEgzSSB/jTiOnUtdYBM2QigpH/eDmQN2l7l9v+611M/HtLR9
 Yb0A/qfjSduyV3+Dnw2bN82eTTytfgAQz7fDzmF5HYRJ6a2sTqI/2vCpJUa68TQ9rPjK
 kRv0xDNQZldXPtvwx9Sx2YEJabNVVBUIRcWuEyZ4Yy63FyYTpGMTGBwbzDEN8n+chEzK
 Qfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705590480; x=1706195280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2YjxijclcunGwfkEQlW4kE3mu67VAm4WZYc/rA6lfYc=;
 b=StfdfNpdn4qmYj1ydQO0TP1uIZQnS5+82pi4AR9aeFWNQpz9YLm2rOJhoNThjIy94k
 SieeCkVcGe1tt44FvaFJlIRR12hui0sylIJiBbTdKR6mDuRpr07sD96JzOXziCgnvbs3
 9FrXo7rgKyFLINrgp3KGnxKqfiSZog1RE0r5SuwKJHvlcfSZM+pYrmsIoXXYLHDUXRJH
 4JYAPCEzlM3yl04BjW+/Gwx0skDjrCb8krLqdgAIt6b5EoxvavJ0kFPR9QFzN7tlZ8B3
 4Urlk5spTP3xrp3MEPwWY+5fzlSrrZV/VOJBNgGBOUWOyCjUgt5LLhVZXGc93C2Mbng4
 x2cw==
X-Gm-Message-State: AOJu0Yw1MGYFsbeLTCFeS4WKdMT5mET0KpAaBc2PfiHDn9YgwcIw7Cg3
 NFtGP+OhHw2ce4FFoC8eKh9AbLbHvcZpIsvFdWUmlVBpEnqJkYA116rMSphn
X-Google-Smtp-Source: AGHT+IFgeWr1YpaA5VAunQuID1hzle0+pRWqaHxhC0+PJV7Rl9VZUY0cp36HndQ2Gec9L3Jof//GbQ==
X-Received: by 2002:a17:903:1c4:b0:1d5:ee58:7a03 with SMTP id
 e4-20020a17090301c400b001d5ee587a03mr1458704plh.38.1705590480424; 
 Thu, 18 Jan 2024 07:08:00 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a170902cf5100b001d052d1aaf2sm1509401plg.101.2024.01.18.07.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:08:00 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PATCH 14/26] target/ppc: Add new hflags to support BHRB
Date: Fri, 19 Jan 2024 01:06:32 +1000
Message-ID: <20240118150644.177371-15-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118150644.177371-1-npiggin@gmail.com>
References: <20240118150644.177371-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

This commit is preparatory to the addition of Branch History
Rolling Buffer (BHRB) functionality, which is being provided
today starting with the P8 processor.

BHRB uses several SPR register fields to control whether or not
a branch instruction's address (and sometimes target address)
should be recorded.  Checking each of these fields with each
branch instruction using jitted code would lead to a significant
decrease in performance.

Therefore, it was decided that BHRB configuration bits that are
not expected to change frequently should have their state summarized
in an hflag so that the amount of checking done by jitted code can
be reduced.

This commit contains the changes for summarizing the state of the
following register fields in the HFLAGS_BHRB_ENABLE hflag:

	MMCR0[FCP] - Determines if BHRB recording is frozen in the
                     problem state

	MMCR0[FCPC] - A modifier for MMCR0[FCP]

	MMCRA[BHRBRD] - Disables all BHRB recording for a thread

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
[npiggin: rebase and minor compile fixes]
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h                 |  5 +++++
 target/ppc/helper.h              |  1 +
 target/ppc/power8-pmu.h          |  4 ++--
 target/ppc/spr_common.h          |  1 +
 target/ppc/cpu_init.c            |  4 ++--
 target/ppc/helper_regs.c         | 37 ++++++++++++++++++++++++++++++++
 target/ppc/machine.c             |  2 +-
 target/ppc/power8-pmu.c          | 15 +++++++++----
 target/ppc/translate.c           |  2 ++
 target/ppc/power8-pmu-regs.c.inc |  5 +++++
 10 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 54150d5a08..60dd644cb9 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -535,6 +535,8 @@ FIELD(MSR, LE, MSR_LE, 1)
 #define MMCR0_FC56   PPC_BIT(59)         /* PMC Freeze Counters 5-6 bit */
 #define MMCR0_PMC1CE PPC_BIT(48)         /* MMCR0 PMC1 Condition Enabled */
 #define MMCR0_PMCjCE PPC_BIT(49)         /* MMCR0 PMCj Condition Enabled */
+#define MMCR0_FCP    PPC_BIT(34)         /* Freeze Counters/BHRB if PR=1 */
+#define MMCR0_FCPC   PPC_BIT(51)         /* Condition for FCP bit */
 /* MMCR0 userspace r/w mask */
 #define MMCR0_UREG_MASK (MMCR0_FC | MMCR0_PMAO | MMCR0_PMAE)
 /* MMCR2 userspace r/w mask */
@@ -547,6 +549,8 @@ FIELD(MSR, LE, MSR_LE, 1)
 #define MMCR2_UREG_MASK (MMCR2_FC1P0 | MMCR2_FC2P0 | MMCR2_FC3P0 | \
                          MMCR2_FC4P0 | MMCR2_FC5P0 | MMCR2_FC6P0)
 
+#define MMCRA_BHRBRD    PPC_BIT(26)         /* BHRB Recording Disable */
+
 #define MMCR1_EVT_SIZE 8
 /* extract64() does a right shift before extracting */
 #define MMCR1_PMC1SEL_START 32
@@ -799,6 +803,7 @@ enum {
     HFLAGS_PMCJCE = 17, /* MMCR0 PMCjCE bit */
     HFLAGS_PMC_OTHER = 18, /* PMC other than PMC5-6 is enabled */
     HFLAGS_INSN_CNT = 19, /* PMU instruction count enabled */
+    HFLAGS_BHRB_ENABLE = 20, /* Summary flag for enabling BHRB */
     HFLAGS_VSX = 23, /* MSR_VSX if cpu has VSX */
     HFLAGS_VR = 25,  /* MSR_VR if cpu has VRE */
 
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 86f97ee1e7..3df360efe9 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -30,6 +30,7 @@ DEF_HELPER_2(store_dawr0, void, env, tl)
 DEF_HELPER_2(store_dawrx0, void, env, tl)
 DEF_HELPER_2(store_mmcr0, void, env, tl)
 DEF_HELPER_2(store_mmcr1, void, env, tl)
+DEF_HELPER_2(store_mmcrA, void, env, tl)
 DEF_HELPER_3(store_pmc, void, env, i32, i64)
 DEF_HELPER_2(read_pmc, tl, env, i32)
 DEF_HELPER_2(insns_inc, void, env, i32)
diff --git a/target/ppc/power8-pmu.h b/target/ppc/power8-pmu.h
index 775e640053..87fa8c9334 100644
--- a/target/ppc/power8-pmu.h
+++ b/target/ppc/power8-pmu.h
@@ -18,10 +18,10 @@
 #define PMC_COUNTER_NEGATIVE_VAL 0x80000000UL
 
 void cpu_ppc_pmu_init(CPUPPCState *env);
-void pmu_mmcr01_updated(CPUPPCState *env);
+void pmu_mmcr01a_updated(CPUPPCState *env);
 #else
 static inline void cpu_ppc_pmu_init(CPUPPCState *env) { }
-static inline void pmu_mmcr01_updated(CPUPPCState *env) { }
+static inline void pmu_mmcr01a_updated(CPUPPCState *env) { }
 #endif
 
 #endif
diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index 8a9d6cd994..eb2561f593 100644
--- a/target/ppc/spr_common.h
+++ b/target/ppc/spr_common.h
@@ -85,6 +85,7 @@ void spr_write_generic32(DisasContext *ctx, int sprn, int gprn);
 void spr_core_write_generic(DisasContext *ctx, int sprn, int gprn);
 void spr_write_MMCR0(DisasContext *ctx, int sprn, int gprn);
 void spr_write_MMCR1(DisasContext *ctx, int sprn, int gprn);
+void spr_write_MMCRA(DisasContext *ctx, int sprn, int gprn);
 void spr_write_PMC(DisasContext *ctx, int sprn, int gprn);
 void spr_write_CTRL(DisasContext *ctx, int sprn, int gprn);
 void spr_read_xer(DisasContext *ctx, int gprn, int sprn);
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 5c1d0adca8..72e0ac7029 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5152,7 +5152,7 @@ static void register_book3s_pmu_sup_sprs(CPUPPCState *env)
                      KVM_REG_PPC_MMCR1, 0x00000000);
     spr_register_kvm(env, SPR_POWER_MMCRA, "MMCRA",
                      SPR_NOACCESS, SPR_NOACCESS,
-                     &spr_read_generic, &spr_write_generic,
+                     &spr_read_generic, &spr_write_MMCRA,
                      KVM_REG_PPC_MMCRA, 0x00000000);
     spr_register_kvm(env, SPR_POWER_PMC1, "PMC1",
                      SPR_NOACCESS, SPR_NOACCESS,
@@ -7163,7 +7163,7 @@ static void ppc_cpu_reset_hold(Object *obj)
         if (env->mmu_model != POWERPC_MMU_REAL) {
             ppc_tlb_invalidate_all(env);
         }
-        pmu_mmcr01_updated(env);
+        pmu_mmcr01a_updated(env);
     }
 
     /* clean any pending stop state */
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 25258986e3..07a07ae720 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -47,6 +47,39 @@ void hreg_swap_gpr_tgpr(CPUPPCState *env)
     env->tgpr[3] = tmp;
 }
 
+#if defined(TARGET_PPC64)
+static bool hreg_check_bhrb_enable(CPUPPCState *env)
+{
+    bool pr = !!(env->msr & (1 << MSR_PR));
+    target_long mmcr0;
+    bool fcp;
+    bool hv;
+
+    /* ISA 3.1 adds the PMCRA[BRHBRD] and problem state checks */
+    if ((env->insns_flags2 & PPC2_ISA310) &&
+        ((env->spr[SPR_POWER_MMCRA] & MMCRA_BHRBRD) || !pr)) {
+        return false;
+    }
+
+    /* Check for BHRB "frozen" conditions */
+    mmcr0 = env->spr[SPR_POWER_MMCR0];
+    fcp = !!(mmcr0 & MMCR0_FCP);
+    if (mmcr0 & MMCR0_FCPC) {
+        hv = !!(env->msr & (1ull << MSR_HV));
+        if (fcp) {
+            if (hv && pr) {
+                return false;
+            }
+        } else if (!hv && pr) {
+            return false;
+        }
+    } else if (fcp && pr) {
+        return false;
+    }
+    return true;
+}
+#endif
+
 static uint32_t hreg_compute_pmu_hflags_value(CPUPPCState *env)
 {
     uint32_t hflags = 0;
@@ -61,6 +94,9 @@ static uint32_t hreg_compute_pmu_hflags_value(CPUPPCState *env)
     if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMCjCE) {
         hflags |= 1 << HFLAGS_PMCJCE;
     }
+    if (hreg_check_bhrb_enable(env)) {
+        hflags |= 1 << HFLAGS_BHRB_ENABLE;
+    }
 
 #ifndef CONFIG_USER_ONLY
     if (env->pmc_ins_cnt) {
@@ -85,6 +121,7 @@ static uint32_t hreg_compute_pmu_hflags_mask(CPUPPCState *env)
     hflags_mask |= 1 << HFLAGS_PMCJCE;
     hflags_mask |= 1 << HFLAGS_INSN_CNT;
     hflags_mask |= 1 << HFLAGS_PMC_OTHER;
+    hflags_mask |= 1 << HFLAGS_BHRB_ENABLE;
 #endif
     return hflags_mask;
 }
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 203fe28e01..6b6c31d903 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -333,7 +333,7 @@ static int cpu_post_load(void *opaque, int version_id)
          * triggered types (including HDEC) would need to carry more state.
          */
         cpu_ppc_store_decr(env, env->spr[SPR_DECR]);
-        pmu_mmcr01_updated(env);
+        pmu_mmcr01a_updated(env);
     }
 
     return 0;
diff --git a/target/ppc/power8-pmu.c b/target/ppc/power8-pmu.c
index cbc5889d91..6f5d4e1256 100644
--- a/target/ppc/power8-pmu.c
+++ b/target/ppc/power8-pmu.c
@@ -82,7 +82,7 @@ static void pmu_update_summaries(CPUPPCState *env)
     env->pmc_cyc_cnt = cyc_cnt;
 }
 
-void pmu_mmcr01_updated(CPUPPCState *env)
+void pmu_mmcr01a_updated(CPUPPCState *env)
 {
     PowerPCCPU *cpu = env_archcpu(env);
 
@@ -260,7 +260,7 @@ void helper_store_mmcr0(CPUPPCState *env, target_ulong value)
 
     env->spr[SPR_POWER_MMCR0] = value;
 
-    pmu_mmcr01_updated(env);
+    pmu_mmcr01a_updated(env);
 
     /* Update cycle overflow timers with the current MMCR0 state */
     pmu_update_overflow_timers(env);
@@ -272,7 +272,14 @@ void helper_store_mmcr1(CPUPPCState *env, uint64_t value)
 
     env->spr[SPR_POWER_MMCR1] = value;
 
-    pmu_mmcr01_updated(env);
+    pmu_mmcr01a_updated(env);
+}
+
+void helper_store_mmcrA(CPUPPCState *env, uint64_t value)
+{
+    env->spr[SPR_POWER_MMCRA] = value;
+
+    pmu_mmcr01a_updated(env);
 }
 
 target_ulong helper_read_pmc(CPUPPCState *env, uint32_t sprn)
@@ -301,7 +308,7 @@ static void perfm_alert(PowerPCCPU *cpu)
         env->spr[SPR_POWER_MMCR0] |= MMCR0_FC;
 
         /* Changing MMCR0_FC requires summaries and hflags update */
-        pmu_mmcr01_updated(env);
+        pmu_mmcr01a_updated(env);
 
         /*
          * Delete all pending timers if we need to freeze
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index bd103b1026..033d6f7bad 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -194,6 +194,7 @@ struct DisasContext {
     bool mmcr0_pmcjce;
     bool pmc_other;
     bool pmu_insn_cnt;
+    bool bhrb_enable;
     ppc_spr_t *spr_cb; /* Needed to check rights for mfspr/mtspr */
     int singlestep_enabled;
     uint32_t flags;
@@ -7392,6 +7393,7 @@ static void ppc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->mmcr0_pmcjce = (hflags >> HFLAGS_PMCJCE) & 1;
     ctx->pmc_other = (hflags >> HFLAGS_PMC_OTHER) & 1;
     ctx->pmu_insn_cnt = (hflags >> HFLAGS_INSN_CNT) & 1;
+    ctx->bhrb_enable = (hflags >> HFLAGS_BHRB_ENABLE) & 1;
 
     ctx->singlestep_enabled = 0;
     if ((hflags >> HFLAGS_SE) & 1) {
diff --git a/target/ppc/power8-pmu-regs.c.inc b/target/ppc/power8-pmu-regs.c.inc
index 4956a8b350..652cf20704 100644
--- a/target/ppc/power8-pmu-regs.c.inc
+++ b/target/ppc/power8-pmu-regs.c.inc
@@ -175,6 +175,11 @@ void spr_write_MMCR2_ureg(DisasContext *ctx, int sprn, int gprn)
     gen_store_spr(SPR_POWER_MMCR2, masked_gprn);
 }
 
+void spr_write_MMCRA(DisasContext *ctx, int sprn, int gprn)
+{
+    gen_helper_store_mmcrA(tcg_env, cpu_gpr[gprn]);
+}
+
 void spr_read_PMC(DisasContext *ctx, int gprn, int sprn)
 {
     TCGv_i32 t_sprn = tcg_constant_i32(sprn);
-- 
2.42.0


