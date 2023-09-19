Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8C67A6EE5
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 01:03:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qijih-0005A8-GC; Tue, 19 Sep 2023 19:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mglenn@mamboa4.aus.stglabs.ibm.com>)
 id 1qijic-00059Z-03; Tue, 19 Sep 2023 19:01:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mglenn@mamboa4.aus.stglabs.ibm.com>)
 id 1qijiZ-0003MP-4Q; Tue, 19 Sep 2023 19:01:21 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38JMxa3r015558; Tue, 19 Sep 2023 23:00:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UEXKM5u08cx/+bDXAUtgrFd34qKdJKYHML8UhkkRLhk=;
 b=lf5nbpOa+mDbZF7vPTBMzOqhEFL70+dmFaB19JoRyfWCSUfBoqr69OF+yW4eJVgHvX/C
 TPCU3l3KjDyOs2EfZhtutrcdOzdmzwt2n5E+oHifE4M2cw1o8xH8mAqGpNPNWMEyenJA
 u1fe6vQHrfe12qx9gWWRp8LbOpNtqk0RGsKeffiIGG9HQpjuZNIjuq6PccIPb/dglLJA
 kHjnBXWoFDJispuEiL38B9CsfD0LNznfEazCX4Z120X6zzBgyDGcpTuROd2dpELDmdDj
 ig3R5y9mZ/d9BztJjR7fJ1cihsAoynPEAny6J5YarQHgPGzcGi/7SDXjo/zMNwpklyKD Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t7hrjcj15-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 23:00:48 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38JMoJxs024109;
 Tue, 19 Sep 2023 23:00:48 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t7hrjchyv-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 23:00:48 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38JMTnb7011677; Tue, 19 Sep 2023 22:30:58 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t5qpnghh8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 22:30:58 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38JMUw2K4457100
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Sep 2023 22:30:58 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E645258052;
 Tue, 19 Sep 2023 22:30:57 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4F5F58045;
 Tue, 19 Sep 2023 22:30:57 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 19 Sep 2023 22:30:57 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (localhost [127.0.0.1])
 by mamboa4.aus.stglabs.ibm.com (Postfix) with ESMTPS id F372D16A05D9;
 Tue, 19 Sep 2023 17:30:56 -0500 (CDT)
Received: (from mglenn@localhost)
 by mamboa4.aus.stglabs.ibm.com (8.15.2/8.15.2/Submit) id 38JMUu1u3442584;
 Tue, 19 Sep 2023 17:30:56 -0500
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v2 1/4] target/ppc: Add new hflags to support BHRB
Date: Tue, 19 Sep 2023 17:30:02 -0500
Message-Id: <20230919223005.3441713-2-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230919223005.3441713-1-milesg@linux.vnet.ibm.com>
References: <20230919223005.3441713-1-milesg@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wvGJ1gsgIi22RWyPwng-ggAapchBrcav
X-Proofpoint-ORIG-GUID: 2CyqCoAPmFM4sP7ECCMOINKiy45eSGGo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_12,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190193
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=mglenn@mamboa4.aus.stglabs.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
---
 target/ppc/cpu.h                 |  5 +++++
 target/ppc/cpu_init.c            |  4 ++--
 target/ppc/helper.h              |  1 +
 target/ppc/helper_regs.c         | 35 ++++++++++++++++++++++++++++++++
 target/ppc/machine.c             |  2 +-
 target/ppc/power8-pmu-regs.c.inc |  5 +++++
 target/ppc/power8-pmu.c          | 15 ++++++++++----
 target/ppc/power8-pmu.h          |  4 ++--
 target/ppc/spr_common.h          |  1 +
 target/ppc/translate.c           |  2 ++
 10 files changed, 65 insertions(+), 9 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 173e4c351a..55985fb84f 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -439,6 +439,8 @@ FIELD(MSR, LE, MSR_LE, 1)
 #define MMCR0_FC56   PPC_BIT(59)         /* PMC Freeze Counters 5-6 bit */
 #define MMCR0_PMC1CE PPC_BIT(48)         /* MMCR0 PMC1 Condition Enabled */
 #define MMCR0_PMCjCE PPC_BIT(49)         /* MMCR0 PMCj Condition Enabled */
+#define MMCR0_FCP    PPC_BIT(34)         /* Freeze Counters/BHRB if PR=1 */
+#define MMCR0_FCPC   PPC_BIT(51)         /* Condition for FCP bit */
 /* MMCR0 userspace r/w mask */
 #define MMCR0_UREG_MASK (MMCR0_FC | MMCR0_PMAO | MMCR0_PMAE)
 /* MMCR2 userspace r/w mask */
@@ -451,6 +453,8 @@ FIELD(MSR, LE, MSR_LE, 1)
 #define MMCR2_UREG_MASK (MMCR2_FC1P0 | MMCR2_FC2P0 | MMCR2_FC3P0 | \
                          MMCR2_FC4P0 | MMCR2_FC5P0 | MMCR2_FC6P0)
 
+#define MMCRA_BHRBRD    PPC_BIT(26)         /* BHRB Recording Disable */
+
 #define MMCR1_EVT_SIZE 8
 /* extract64() does a right shift before extracting */
 #define MMCR1_PMC1SEL_START 32
@@ -703,6 +707,7 @@ enum {
     HFLAGS_PMCJCE = 17, /* MMCR0 PMCjCE bit */
     HFLAGS_PMC_OTHER = 18, /* PMC other than PMC5-6 is enabled */
     HFLAGS_INSN_CNT = 19, /* PMU instruction count enabled */
+    HFLAGS_BHRB_ENABLE = 20, /* Summary flag for enabling BHRB */
     HFLAGS_VSX = 23, /* MSR_VSX if cpu has VSX */
     HFLAGS_VR = 25,  /* MSR_VR if cpu has VRE */
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 7ab5ee92d9..8c81a75416 100644
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
@@ -7164,7 +7164,7 @@ static void ppc_cpu_reset_hold(Object *obj)
         if (env->mmu_model != POWERPC_MMU_REAL) {
             ppc_tlb_invalidate_all(env);
         }
-        pmu_mmcr01_updated(env);
+        pmu_mmcr01a_updated(env);
     }
 
     /* clean any pending stop state */
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
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index f380342d4d..5696338137 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -47,6 +47,37 @@ void hreg_swap_gpr_tgpr(CPUPPCState *env)
     env->tgpr[3] = tmp;
 }
 
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
+
 static uint32_t hreg_compute_pmu_hflags_value(CPUPPCState *env)
 {
     uint32_t hflags = 0;
@@ -61,6 +92,9 @@ static uint32_t hreg_compute_pmu_hflags_value(CPUPPCState *env)
     if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMCjCE) {
         hflags |= 1 << HFLAGS_PMCJCE;
     }
+    if (hreg_check_bhrb_enable(env)) {
+        hflags |= 1 << HFLAGS_BHRB_ENABLE;
+    }
 
 #ifndef CONFIG_USER_ONLY
     if (env->pmc_ins_cnt) {
@@ -85,6 +119,7 @@ static uint32_t hreg_compute_pmu_hflags_mask(CPUPPCState *env)
     hflags_mask |= 1 << HFLAGS_PMCJCE;
     hflags_mask |= 1 << HFLAGS_INSN_CNT;
     hflags_mask |= 1 << HFLAGS_PMC_OTHER;
+    hflags_mask |= 1 << HFLAGS_BHRB_ENABLE;
 #endif
     return hflags_mask;
 }
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 68cbdffecd..d42e475bfb 100644
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
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 5c28afbbb8..6bf2fb46d5 100644
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
@@ -7354,6 +7355,7 @@ static void ppc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->mmcr0_pmcjce = (hflags >> HFLAGS_PMCJCE) & 1;
     ctx->pmc_other = (hflags >> HFLAGS_PMC_OTHER) & 1;
     ctx->pmu_insn_cnt = (hflags >> HFLAGS_INSN_CNT) & 1;
+    ctx->bhrb_enable = (hflags >> HFLAGS_BHRB_ENABLE) & 1;
 
     ctx->singlestep_enabled = 0;
     if ((hflags >> HFLAGS_SE) & 1) {
-- 
2.31.1


