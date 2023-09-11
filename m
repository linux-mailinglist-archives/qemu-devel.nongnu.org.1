Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2691779ABFF
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 00:16:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfpBj-0003j3-Jv; Mon, 11 Sep 2023 18:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mglenn@mamboa4.aus.stglabs.ibm.com>)
 id 1qfoqu-0008Iq-8V; Mon, 11 Sep 2023 17:53:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mglenn@mamboa4.aus.stglabs.ibm.com>)
 id 1qfoqq-000531-Ur; Mon, 11 Sep 2023 17:53:51 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38BL7sxf006735; Mon, 11 Sep 2023 21:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=YL1CMr4J8fhdP3TBodkHgFfsK5UWm2nuV9X2vPbCHcQ=;
 b=f3eXhfH4QL/NPbnBfWAXPFFpj9TISj6YDHYnUXRq3HmRfANyOJbG/5ybwWLx4tdgWU3g
 uVhjXuMSQUWvA62Y7XY9geMiquZUgGnAvIjsOmFA8VR4omQLeQ1ZY1QMr4MkIClzY9t9
 I2alJCKQ/x/us0SjpjPxu67M7ztLfN7H0XkF65C0ifRrsSho51iGibihBR3R4Wo3O0kj
 kzEVjmKiqot3RahWB6xeK4bFAErWbD2Ewjy5knuSoXfGJXxcsN8aYmUQTPV1wUgQqzqP
 Q/TfuO1PCV+vtGur6Huw2dirs3FeTkEchoQeXhZknVSzcHVOJEONDQ5QPPjyAyIcJEnI PQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2a9qgpd2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 21:23:44 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38BLKxhE013250;
 Mon, 11 Sep 2023 21:23:43 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2a9qgpcx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 21:23:43 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38BJcFWj022744; Mon, 11 Sep 2023 21:23:43 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t141ndusv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 21:23:43 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38BLNgit6750728
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Sep 2023 21:23:42 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 86FF658056;
 Mon, 11 Sep 2023 21:23:42 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C75D58060;
 Mon, 11 Sep 2023 21:23:42 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 11 Sep 2023 21:23:42 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (localhost [127.0.0.1])
 by mamboa4.aus.stglabs.ibm.com (Postfix) with ESMTPS id 912B016A0839;
 Mon, 11 Sep 2023 16:23:41 -0500 (CDT)
Received: (from mglenn@localhost)
 by mamboa4.aus.stglabs.ibm.com (8.15.2/8.15.2/Submit) id 38BLNfE02260442;
 Mon, 11 Sep 2023 16:23:41 -0500
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs)
Subject: [PATCH 1/4] target/ppc: Add new hflags to support BHRB
Date: Mon, 11 Sep 2023 16:23:37 -0500
Message-Id: <20230911212340.2260383-2-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230911212340.2260383-1-milesg@linux.vnet.ibm.com>
References: <20230911212340.2260383-1-milesg@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ta7Njb4butFCLEW184eBEdlUH5OUHtnV
X-Proofpoint-ORIG-GUID: xZSUJ0VRcpCXNZwAjpohgA_Ki0MmcjjT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_16,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=960 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309110194
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=mglenn@mamboa4.aus.stglabs.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 11 Sep 2023 18:15:13 -0400
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

This commit is preparatory to the addition of Branch History
Rolling Buffer (BHRB) functionality, which is being provided
today starting with the P8 processor.

BHRB uses several SPR register fields to control whether or not
a branch instruction's address (and sometimes target address)
should be recorded.  Checking each of these fields with each
branch instruction using jitted code would lead to a significant
decrease in performance.

Therefore, it was decided that BHRB configuration bits that are
not expected to change frequently should have their state stored in
hflags so that the amount of checking done by jitted code can
be reduced.

This commit contains the changes for storing the state of the
following register fields as hflags:

	MMCR0[FCP] - Determines if BHRB recording is frozen in the
                     problem state

	MMCR0[FCPC] - A modifier for MMCR0[FCP]

	MMCRA[BHRBRD] - Disables all BHRB recording for a thread

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---
 target/ppc/cpu.h                 |  9 +++++++++
 target/ppc/cpu_init.c            |  4 ++--
 target/ppc/helper.h              |  1 +
 target/ppc/helper_regs.c         | 12 ++++++++++++
 target/ppc/machine.c             |  2 +-
 target/ppc/power8-pmu-regs.c.inc |  5 +++++
 target/ppc/power8-pmu.c          | 15 +++++++++++----
 target/ppc/power8-pmu.h          |  4 ++--
 target/ppc/spr_common.h          |  1 +
 target/ppc/translate.c           |  6 ++++++
 10 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 25fac9577a..20ae1466a5 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -439,6 +439,9 @@ FIELD(MSR, LE, MSR_LE, 1)
 #define MMCR0_FC56   PPC_BIT(59)         /* PMC Freeze Counters 5-6 bit */
 #define MMCR0_PMC1CE PPC_BIT(48)         /* MMCR0 PMC1 Condition Enabled */
 #define MMCR0_PMCjCE PPC_BIT(49)         /* MMCR0 PMCj Condition Enabled */
+#define MMCR0_BHRBA  PPC_BIT_NR(42)      /* BHRB Available */
+#define MMCR0_FCP    PPC_BIT(34)         /* Freeze Counters/BHRB if PR=1 */
+#define MMCR0_FCPC   PPC_BIT(51)         /* Condition for FCP bit */
 /* MMCR0 userspace r/w mask */
 #define MMCR0_UREG_MASK (MMCR0_FC | MMCR0_PMAO | MMCR0_PMAE)
 /* MMCR2 userspace r/w mask */
@@ -451,6 +454,9 @@ FIELD(MSR, LE, MSR_LE, 1)
 #define MMCR2_UREG_MASK (MMCR2_FC1P0 | MMCR2_FC2P0 | MMCR2_FC3P0 | \
                          MMCR2_FC4P0 | MMCR2_FC5P0 | MMCR2_FC6P0)
 
+#define MMCRA_BHRBRD    PPC_BIT(26)            /* BHRB Recording Disable */
+
+
 #define MMCR1_EVT_SIZE 8
 /* extract64() does a right shift before extracting */
 #define MMCR1_PMC1SEL_START 32
@@ -703,6 +709,9 @@ enum {
     HFLAGS_PMCJCE = 17, /* MMCR0 PMCjCE bit */
     HFLAGS_PMC_OTHER = 18, /* PMC other than PMC5-6 is enabled */
     HFLAGS_INSN_CNT = 19, /* PMU instruction count enabled */
+    HFLAGS_FCPC = 20,   /* MMCR0 FCPC bit */
+    HFLAGS_FCP = 21,    /* MMCR0 FCP bit */
+    HFLAGS_BHRBRD = 22, /* MMCRA BHRBRD bit */
     HFLAGS_VSX = 23, /* MSR_VSX if cpu has VSX */
     HFLAGS_VR = 25,  /* MSR_VR if cpu has VRE */
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 02b7aad9b0..568f9c3b88 100644
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
@@ -7152,7 +7152,7 @@ static void ppc_cpu_reset_hold(Object *obj)
         if (env->mmu_model != POWERPC_MMU_REAL) {
             ppc_tlb_invalidate_all(env);
         }
-        pmu_mmcr01_updated(env);
+        pmu_mmcr01a_updated(env);
     }
 
     /* clean any pending stop state */
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index abec6fe341..1a3d9a7e57 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -27,6 +27,7 @@ DEF_HELPER_2(store_lpcr, void, env, tl)
 DEF_HELPER_2(store_pcr, void, env, tl)
 DEF_HELPER_2(store_mmcr0, void, env, tl)
 DEF_HELPER_2(store_mmcr1, void, env, tl)
+DEF_HELPER_2(store_mmcrA, void, env, tl)
 DEF_HELPER_3(store_pmc, void, env, i32, i64)
 DEF_HELPER_2(read_pmc, tl, env, i32)
 DEF_HELPER_2(insns_inc, void, env, i32)
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index f380342d4d..4ff054063d 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -61,6 +61,15 @@ static uint32_t hreg_compute_pmu_hflags_value(CPUPPCState *env)
     if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMCjCE) {
         hflags |= 1 << HFLAGS_PMCJCE;
     }
+    if (env->spr[SPR_POWER_MMCR0] & MMCR0_FCP) {
+        hflags |= 1 << HFLAGS_FCP;
+    }
+    if (env->spr[SPR_POWER_MMCR0] & MMCR0_FCPC) {
+        hflags |= 1 << HFLAGS_FCPC;
+    }
+    if (env->spr[SPR_POWER_MMCRA] & MMCRA_BHRBRD) {
+        hflags |= 1 << HFLAGS_BHRBRD;
+    }
 
 #ifndef CONFIG_USER_ONLY
     if (env->pmc_ins_cnt) {
@@ -85,6 +94,9 @@ static uint32_t hreg_compute_pmu_hflags_mask(CPUPPCState *env)
     hflags_mask |= 1 << HFLAGS_PMCJCE;
     hflags_mask |= 1 << HFLAGS_INSN_CNT;
     hflags_mask |= 1 << HFLAGS_PMC_OTHER;
+    hflags_mask |= 1 << HFLAGS_FCP;
+    hflags_mask |= 1 << HFLAGS_FCPC;
+    hflags_mask |= 1 << HFLAGS_BHRBRD;
 #endif
     return hflags_mask;
 }
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 1270a1f7fc..b195fb4dc8 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -313,7 +313,7 @@ static int cpu_post_load(void *opaque, int version_id)
     post_load_update_msr(env);
 
     if (tcg_enabled()) {
-        pmu_mmcr01_updated(env);
+        pmu_mmcr01a_updated(env);
     }
 
     return 0;
diff --git a/target/ppc/power8-pmu-regs.c.inc b/target/ppc/power8-pmu-regs.c.inc
index c82feedaff..cab488918a 100644
--- a/target/ppc/power8-pmu-regs.c.inc
+++ b/target/ppc/power8-pmu-regs.c.inc
@@ -175,6 +175,11 @@ void spr_write_MMCR2_ureg(DisasContext *ctx, int sprn, int gprn)
     gen_store_spr(SPR_POWER_MMCR2, masked_gprn);
 }
 
+void spr_write_MMCRA(DisasContext *ctx, int sprn, int gprn)
+{
+    gen_helper_store_mmcrA(cpu_env, cpu_gpr[gprn]);
+}
+
 void spr_read_PMC(DisasContext *ctx, int gprn, int sprn)
 {
     TCGv_i32 t_sprn = tcg_constant_i32(sprn);
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
index 5995070eaf..3c499c1ebd 100644
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
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 7111b34030..d93fbd4574 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -190,6 +190,9 @@ struct DisasContext {
     bool mmcr0_pmcjce;
     bool pmc_other;
     bool pmu_insn_cnt;
+    bool mmcr0_fcpc;
+    bool mmcr0_fcp;
+    bool mmcra_bhrbrd;
     ppc_spr_t *spr_cb; /* Needed to check rights for mfspr/mtspr */
     int singlestep_enabled;
     uint32_t flags;
@@ -7326,6 +7329,9 @@ static void ppc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->mmcr0_pmcjce = (hflags >> HFLAGS_PMCJCE) & 1;
     ctx->pmc_other = (hflags >> HFLAGS_PMC_OTHER) & 1;
     ctx->pmu_insn_cnt = (hflags >> HFLAGS_INSN_CNT) & 1;
+    ctx->mmcr0_fcpc = (hflags >> HFLAGS_FCPC) & 1;
+    ctx->mmcr0_fcp = (hflags >> HFLAGS_FCP) & 1;
+    ctx->mmcra_bhrbrd = (hflags >> HFLAGS_BHRBRD) & 1;
 
     ctx->singlestep_enabled = 0;
     if ((hflags >> HFLAGS_SE) & 1) {
-- 
2.31.1


