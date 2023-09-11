Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A74079DB02
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 23:35:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgB1e-0008Cj-KU; Tue, 12 Sep 2023 17:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mglenn@mamboa4.aus.stglabs.ibm.com>)
 id 1qgB1c-0008CR-6I; Tue, 12 Sep 2023 17:34:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mglenn@mamboa4.aus.stglabs.ibm.com>)
 id 1qgB1Y-0000bs-RN; Tue, 12 Sep 2023 17:34:23 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38BKgMdI025482; Mon, 11 Sep 2023 21:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9zUUmh2XoJCCi73iaRRYvrpoAVDwauxQlxN96k55PJ4=;
 b=Fmo9UfFHV7x0nyzYvmerlI5/ViYmqCo09q3Xn4WeABtif+sZAmdD9ttSzN+GDe7nYx9B
 liioQFRn+xVMeMHRFqXvPiW5kGAIM/sGAE1+OLuXpzRwxmrtAqARu9YNoKX51PWtFwBK
 etDLlnXVkcib+enYV2GTRcQn7PIUZBiTgUEYw2fc94ILYFPHzHLz2PrtsVsKRT4F9fOI
 Bn3XwdJ69bEMUpO0Bjw6KiyP82scMur5CRslXeV5qYdy8iENmwm3ViUHcb2ljNBCMRg9
 gpcvQZkOqzkKGEsqAQ+D5iQKpqLFOwiA3+IVevhfYzLa7ai1vzCjXkJRWZCAVwmYNuKS IQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2a5j1cwe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 21:23:45 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38BKhdWj030332;
 Mon, 11 Sep 2023 21:23:44 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2a5j1cw5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 21:23:44 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38BJoG0i002967; Mon, 11 Sep 2023 21:23:43 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t14hknq06-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 21:23:43 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38BLNhYc66060566
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Sep 2023 21:23:43 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 08A9158050;
 Mon, 11 Sep 2023 21:23:43 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC79358045;
 Mon, 11 Sep 2023 21:23:42 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 11 Sep 2023 21:23:42 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (localhost [127.0.0.1])
 by mamboa4.aus.stglabs.ibm.com (Postfix) with ESMTPS id F37D716A05EF;
 Mon, 11 Sep 2023 16:23:41 -0500 (CDT)
Received: (from mglenn@localhost)
 by mamboa4.aus.stglabs.ibm.com (8.15.2/8.15.2/Submit) id 38BLNfpO2260445;
 Mon, 11 Sep 2023 16:23:41 -0500
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs)
Subject: [PATCH 2/4] target/ppc: Add recording of taken branches to BHRB
Date: Mon, 11 Sep 2023 16:23:38 -0500
Message-Id: <20230911212340.2260383-3-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230911212340.2260383-1-milesg@linux.vnet.ibm.com>
References: <20230911212340.2260383-1-milesg@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HnzjnzYO2PtkgG74tbAL-joenUNBqXgY
X-Proofpoint-ORIG-GUID: vurZpoWc6T3ZZE5qKf5J7f6AfCcpI_rA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_16,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 mlxscore=0 impostorscore=0 mlxlogscore=736 bulkscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110194
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

This commit continues adding support for the Branch History
Rolling Buffer (BHRB) as is provided starting with the P8
processor and continuing with its successors.  This commit
is limited to the recording and filtering of taken branches.

The following changes were made:

  - Added a BHRB buffer for storing branch instruction and
    target addresses for taken branches
  - Renamed gen_update_cfar to gen_update_branch_history and
    added a 'target' parameter to hold the branch target
    address and 'inst_type' parameter to use for filtering
  - Added a combination of jit-time and run-time checks to
    gen_update_branch_history for determining if a branch
    should be recorded
  - Added TCG code to gen_update_branch_history that stores
    data to the BHRB and updates the BHRB offset.
  - Added BHRB resource initialization and reset functions
  - Enabled functionality for P8, P9 and P10 processors.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---
 target/ppc/cpu.h                       |  18 +++-
 target/ppc/cpu_init.c                  |  41 ++++++++-
 target/ppc/helper_regs.c               |  32 +++++++
 target/ppc/helper_regs.h               |   1 +
 target/ppc/power8-pmu.c                |   2 +
 target/ppc/power8-pmu.h                |   7 ++
 target/ppc/translate.c                 | 114 +++++++++++++++++++++++--
 target/ppc/translate/branch-impl.c.inc |   2 +-
 8 files changed, 205 insertions(+), 12 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 20ae1466a5..bda1afb700 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -454,8 +454,9 @@ FIELD(MSR, LE, MSR_LE, 1)
 #define MMCR2_UREG_MASK (MMCR2_FC1P0 | MMCR2_FC2P0 | MMCR2_FC3P0 | \
                          MMCR2_FC4P0 | MMCR2_FC5P0 | MMCR2_FC6P0)
 
-#define MMCRA_BHRBRD    PPC_BIT(26)            /* BHRB Recording Disable */
-
+#define MMCRA_BHRBRD    PPC_BIT(26)         /* BHRB Recording Disable */
+#define MMCRA_IFM_MASK  PPC_BITMASK(32, 33) /* BHRB Instruction Filtering */
+#define MMCRA_IFM_SHIFT PPC_BIT_NR(33)
 
 #define MMCR1_EVT_SIZE 8
 /* extract64() does a right shift before extracting */
@@ -682,6 +683,8 @@ enum {
     POWERPC_FLAG_SMT      = 0x00400000,
     /* Using "LPAR per core" mode  (as opposed to per-thread)                */
     POWERPC_FLAG_SMT_1LPAR = 0x00800000,
+    /* Has BHRB */
+    POWERPC_FLAG_BHRB      = 0x01000000,
 };
 
 /*
@@ -1110,6 +1113,9 @@ DEXCR_ASPECT(PHIE, 6)
 #define PPC_CPU_OPCODES_LEN          0x40
 #define PPC_CPU_INDIRECT_OPCODES_LEN 0x20
 
+#define BHRB_MAX_NUM_ENTRIES_LOG2 (5)
+#define BHRB_MAX_NUM_ENTRIES      (1 << BHRB_MAX_NUM_ENTRIES_LOG2)
+
 struct CPUArchState {
     /* Most commonly used resources during translated code execution first */
     target_ulong gpr[32];  /* general purpose registers */
@@ -1196,6 +1202,14 @@ struct CPUArchState {
     int dcache_line_size;
     int icache_line_size;
 
+    /* Branch History Rolling Buffer (BHRB) resources */
+    target_ulong bhrb_num_entries;
+    target_ulong bhrb_base;
+    target_ulong bhrb_filter;
+    target_ulong bhrb_offset;
+    target_ulong bhrb_offset_mask;
+    uint64_t bhrb[BHRB_MAX_NUM_ENTRIES];
+
     /* These resources are used during exception processing */
     /* CPU model definition */
     target_ulong msr_mask;
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 568f9c3b88..19d7505a73 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6100,6 +6100,28 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data)
     pcc->l1_icache_size = 0x8000;
 }
 
+static void bhrb_init_state(CPUPPCState *env, target_long num_entries_log2)
+{
+    if (env->flags & POWERPC_FLAG_BHRB) {
+        if (num_entries_log2 > BHRB_MAX_NUM_ENTRIES_LOG2) {
+            num_entries_log2 = BHRB_MAX_NUM_ENTRIES_LOG2;
+        }
+        env->bhrb_num_entries = 1 << num_entries_log2;
+        env->bhrb_base = (target_long)&env->bhrb[0];
+        env->bhrb_offset_mask = (env->bhrb_num_entries * sizeof(uint64_t)) - 1;
+    }
+}
+
+static void bhrb_reset_state(CPUPPCState *env)
+{
+    if (env->flags & POWERPC_FLAG_BHRB) {
+        env->bhrb_offset = 0;
+        env->bhrb_filter = 0;
+        memset(env->bhrb, 0, sizeof(env->bhrb));
+    }
+}
+
+#define POWER8_BHRB_ENTRIES_LOG2 5
 static void init_proc_POWER8(CPUPPCState *env)
 {
     /* Common Registers */
@@ -6141,6 +6163,8 @@ static void init_proc_POWER8(CPUPPCState *env)
     env->dcache_line_size = 128;
     env->icache_line_size = 128;
 
+    bhrb_init_state(env, POWER8_BHRB_ENTRIES_LOG2);
+
     /* Allocate hardware IRQ controller */
     init_excp_POWER8(env);
     ppcPOWER7_irq_init(env_archcpu(env));
@@ -6241,7 +6265,8 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
     pcc->flags = POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
                  POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
                  POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
-                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM;
+                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM |
+                 POWERPC_FLAG_BHRB;
     pcc->l1_dcache_size = 0x8000;
     pcc->l1_icache_size = 0x8000;
 }
@@ -6265,6 +6290,7 @@ static struct ppc_radix_page_info POWER9_radix_page_info = {
 };
 #endif /* CONFIG_USER_ONLY */
 
+#define POWER9_BHRB_ENTRIES_LOG2 5
 static void init_proc_POWER9(CPUPPCState *env)
 {
     /* Common Registers */
@@ -6315,6 +6341,8 @@ static void init_proc_POWER9(CPUPPCState *env)
     env->dcache_line_size = 128;
     env->icache_line_size = 128;
 
+    bhrb_init_state(env, POWER9_BHRB_ENTRIES_LOG2);
+
     /* Allocate hardware IRQ controller */
     init_excp_POWER9(env);
     ppcPOWER9_irq_init(env_archcpu(env));
@@ -6434,7 +6462,8 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
     pcc->flags = POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
                  POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
                  POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
-                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM | POWERPC_FLAG_SCV;
+                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM | POWERPC_FLAG_SCV |
+                 POWERPC_FLAG_BHRB;
     pcc->l1_dcache_size = 0x8000;
     pcc->l1_icache_size = 0x8000;
 }
@@ -6458,6 +6487,7 @@ static struct ppc_radix_page_info POWER10_radix_page_info = {
 };
 #endif /* !CONFIG_USER_ONLY */
 
+#define POWER10_BHRB_ENTRIES_LOG2 5
 static void init_proc_POWER10(CPUPPCState *env)
 {
     /* Common Registers */
@@ -6505,6 +6535,8 @@ static void init_proc_POWER10(CPUPPCState *env)
     env->dcache_line_size = 128;
     env->icache_line_size = 128;
 
+    bhrb_init_state(env, POWER10_BHRB_ENTRIES_LOG2);
+
     /* Allocate hardware IRQ controller */
     init_excp_POWER10(env);
     ppcPOWER9_irq_init(env_archcpu(env));
@@ -6610,7 +6642,8 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
     pcc->flags = POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
                  POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
                  POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
-                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM | POWERPC_FLAG_SCV;
+                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM | POWERPC_FLAG_SCV |
+                 POWERPC_FLAG_BHRB;
     pcc->l1_dcache_size = 0x8000;
     pcc->l1_icache_size = 0x8000;
 }
@@ -7178,6 +7211,8 @@ static void ppc_cpu_reset_hold(Object *obj)
         }
         env->spr[i] = spr->default_value;
     }
+
+    bhrb_reset_state(env);
 }
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 4ff054063d..68b27196d9 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -752,3 +752,35 @@ void register_usprgh_sprs(CPUPPCState *env)
                  &spr_read_ureg, SPR_NOACCESS,
                  0x00000000);
 }
+
+void hreg_bhrb_filter_update(CPUPPCState *env)
+{
+    target_long ifm;
+
+    if (!(env->spr[SPR_POWER_MMCR0] & MMCR0_PMAE)) {
+        /* disable recording to BHRB */
+        env->bhrb_filter = BHRB_TYPE_NORECORD;
+        return;
+    }
+
+    ifm = (env->spr[SPR_POWER_MMCRA] & MMCRA_IFM_MASK) >> MMCRA_IFM_SHIFT;
+    switch (ifm) {
+    case 0:
+        /* record all branches */
+        env->bhrb_filter = -1;
+        break;
+    case 1:
+        /* only record calls (LK = 1) */
+        env->bhrb_filter = BHRB_TYPE_CALL;
+        break;
+    case 2:
+        /* only record indirect branches */
+        env->bhrb_filter = BHRB_TYPE_INDIRECT;
+        break;
+    case 3:
+        /* only record conditional branches */
+        env->bhrb_filter = BHRB_TYPE_COND;
+        break;
+    }
+}
+
diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h
index 8196c1346d..ab6aba1c24 100644
--- a/target/ppc/helper_regs.h
+++ b/target/ppc/helper_regs.h
@@ -25,6 +25,7 @@ void hreg_compute_hflags(CPUPPCState *env);
 void hreg_update_pmu_hflags(CPUPPCState *env);
 void cpu_interrupt_exittb(CPUState *cs);
 int hreg_store_msr(CPUPPCState *env, target_ulong value, int alter_hv);
+void hreg_bhrb_filter_update(CPUPPCState *env);
 
 #ifdef CONFIG_USER_ONLY
 static inline void check_tlb_flush(CPUPPCState *env, bool global) { }
diff --git a/target/ppc/power8-pmu.c b/target/ppc/power8-pmu.c
index 6f5d4e1256..18149a15b2 100644
--- a/target/ppc/power8-pmu.c
+++ b/target/ppc/power8-pmu.c
@@ -261,6 +261,7 @@ void helper_store_mmcr0(CPUPPCState *env, target_ulong value)
     env->spr[SPR_POWER_MMCR0] = value;
 
     pmu_mmcr01a_updated(env);
+    hreg_bhrb_filter_update(env);
 
     /* Update cycle overflow timers with the current MMCR0 state */
     pmu_update_overflow_timers(env);
@@ -280,6 +281,7 @@ void helper_store_mmcrA(CPUPPCState *env, uint64_t value)
     env->spr[SPR_POWER_MMCRA] = value;
 
     pmu_mmcr01a_updated(env);
+    hreg_bhrb_filter_update(env);
 }
 
 target_ulong helper_read_pmc(CPUPPCState *env, uint32_t sprn)
diff --git a/target/ppc/power8-pmu.h b/target/ppc/power8-pmu.h
index 87fa8c9334..a887094045 100644
--- a/target/ppc/power8-pmu.h
+++ b/target/ppc/power8-pmu.h
@@ -17,6 +17,13 @@
 
 #define PMC_COUNTER_NEGATIVE_VAL 0x80000000UL
 
+#define BHRB_TYPE_NORECORD      0x00
+#define BHRB_TYPE_CALL          0x01
+#define BHRB_TYPE_INDIRECT      0x02
+#define BHRB_TYPE_COND          0x04
+#define BHRB_TYPE_OTHER         0x08
+#define BHRB_TYPE_XL_FORM       0x10
+
 void cpu_ppc_pmu_init(CPUPPCState *env);
 void pmu_mmcr01a_updated(CPUPPCState *env);
 #else
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index d93fbd4574..7824475f54 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -177,6 +177,7 @@ struct DisasContext {
 #if defined(TARGET_PPC64)
     bool sf_mode;
     bool has_cfar;
+    bool has_bhrb;
 #endif
     bool fpu_enabled;
     bool altivec_enabled;
@@ -4104,12 +4105,100 @@ static void gen_rvwinkle(DisasContext *ctx)
 }
 #endif /* #if defined(TARGET_PPC64) */
 
-static inline void gen_update_cfar(DisasContext *ctx, target_ulong nip)
+
+static inline void gen_update_branch_history(DisasContext *ctx,
+                                             target_ulong nip,
+                                             TCGv target,
+                                             target_long inst_type)
 {
 #if defined(TARGET_PPC64)
+    TCGv t0;
+    TCGv t1;
+    TCGv t2;
+    TCGv t3;
+    TCGLabel *no_update;
+
     if (ctx->has_cfar) {
         tcg_gen_movi_tl(cpu_cfar, nip);
     }
+
+    if (!ctx->has_bhrb || inst_type == BHRB_TYPE_NORECORD) {
+        return;
+    }
+
+    /* ISA 3.1 adds the PMCRA[BRHBRD] and problem state checks */
+    if ((ctx->insns_flags2 & PPC2_ISA310) && (ctx->mmcra_bhrbrd || !ctx->pr)) {
+        return;
+    }
+
+    /* Check for BHRB "frozen" conditions */
+    if (ctx->mmcr0_fcpc) {
+        if (ctx->mmcr0_fcp) {
+            if ((ctx->hv) && (ctx->pr)) {
+                return;
+            }
+        } else if (!(ctx->hv) && (ctx->pr)) {
+            return;
+        }
+    } else if ((ctx->mmcr0_fcp) && (ctx->pr)) {
+        return;
+    }
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+    t2 = tcg_temp_new();
+    t3 = tcg_temp_new();
+    no_update = gen_new_label();
+
+    /* check for bhrb filtering */
+    tcg_gen_ld_tl(t0, cpu_env, offsetof(CPUPPCState, bhrb_filter));
+    tcg_gen_andi_tl(t0, t0, inst_type);
+    tcg_gen_brcondi_tl(TCG_COND_EQ, t0, 0, no_update);
+
+    /* load bhrb base address into t2 */
+    tcg_gen_ld_tl(t2, cpu_env, offsetof(CPUPPCState, bhrb_base));
+
+    /* load current bhrb_offset into t0 */
+    tcg_gen_ld_tl(t0, cpu_env, offsetof(CPUPPCState, bhrb_offset));
+
+    /* load a BHRB offset mask into t3 */
+    tcg_gen_ld_tl(t3, cpu_env, offsetof(CPUPPCState, bhrb_offset_mask));
+
+    /* add t2 to t0 to get address of bhrb entry */
+    tcg_gen_add_tl(t1, t0, t2);
+
+    /* store nip into bhrb at bhrb_offset */
+    tcg_gen_st_i64(tcg_constant_i64(nip), (TCGv_ptr)t1, 0);
+
+    /* add 8 to current bhrb_offset */
+    tcg_gen_addi_tl(t0, t0, 8);
+
+    /* apply offset mask */
+    tcg_gen_and_tl(t0, t0, t3);
+
+    if (inst_type & BHRB_TYPE_XL_FORM) {
+        /* Also record the target address for XL-Form branches */
+
+        /* add t2 to t0 to get address of bhrb entry */
+        tcg_gen_add_tl(t1, t0, t2);
+
+        /* Set the 'T' bit for target entries */
+        tcg_gen_ori_tl(t2, target, 0x2);
+
+        /* Store target address in bhrb */
+        tcg_gen_st_tl(t2, (TCGv_ptr)t1, 0);
+
+        /* add 8 to current bhrb_offset */
+        tcg_gen_addi_tl(t0, t0, 8);
+
+        /* apply offset mask */
+        tcg_gen_and_tl(t0, t0, t3);
+    }
+
+    /* save updated bhrb_offset for next time */
+    tcg_gen_st_tl(t0, cpu_env, offsetof(CPUPPCState, bhrb_offset));
+
+    gen_set_label(no_update);
 #endif
 }
 
@@ -4239,8 +4328,10 @@ static void gen_b(DisasContext *ctx)
     }
     if (LK(ctx->opcode)) {
         gen_setlr(ctx, ctx->base.pc_next);
+        gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_CALL);
+    } else {
+        gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_OTHER);
     }
-    gen_update_cfar(ctx, ctx->cia);
     gen_goto_tb(ctx, 0, target);
     ctx->base.is_jmp = DISAS_NORETURN;
 }
@@ -4255,6 +4346,7 @@ static void gen_bcond(DisasContext *ctx, int type)
     uint32_t bo = BO(ctx->opcode);
     TCGLabel *l1;
     TCGv target;
+    target_long bhrb_type = BHRB_TYPE_OTHER;
 
     if (type == BCOND_LR || type == BCOND_CTR || type == BCOND_TAR) {
         target = tcg_temp_new();
@@ -4265,11 +4357,16 @@ static void gen_bcond(DisasContext *ctx, int type)
         } else {
             tcg_gen_mov_tl(target, cpu_lr);
         }
+        if (!LK(ctx->opcode)) {
+            bhrb_type |= BHRB_TYPE_INDIRECT;
+        }
+        bhrb_type |= BHRB_TYPE_XL_FORM;
     } else {
         target = NULL;
     }
     if (LK(ctx->opcode)) {
         gen_setlr(ctx, ctx->base.pc_next);
+        bhrb_type |= BHRB_TYPE_CALL;
     }
     l1 = gen_new_label();
     if ((bo & 0x4) == 0) {
@@ -4320,6 +4417,7 @@ static void gen_bcond(DisasContext *ctx, int type)
                 tcg_gen_brcondi_tl(TCG_COND_EQ, temp, 0, l1);
             }
         }
+        bhrb_type |= BHRB_TYPE_COND;
     }
     if ((bo & 0x10) == 0) {
         /* Test CR */
@@ -4334,8 +4432,11 @@ static void gen_bcond(DisasContext *ctx, int type)
             tcg_gen_andi_i32(temp, cpu_crf[bi >> 2], mask);
             tcg_gen_brcondi_i32(TCG_COND_NE, temp, 0, l1);
         }
+        bhrb_type |= BHRB_TYPE_COND;
     }
-    gen_update_cfar(ctx, ctx->cia);
+
+    gen_update_branch_history(ctx, ctx->cia, target, bhrb_type);
+
     if (type == BCOND_IM) {
         target_ulong li = (target_long)((int16_t)(BD(ctx->opcode)));
         if (likely(AA(ctx->opcode) == 0)) {
@@ -4451,7 +4552,7 @@ static void gen_rfi(DisasContext *ctx)
     /* Restore CPU state */
     CHK_SV(ctx);
     translator_io_start(&ctx->base);
-    gen_update_cfar(ctx, ctx->cia);
+    gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_NORECORD);
     gen_helper_rfi(cpu_env);
     ctx->base.is_jmp = DISAS_EXIT;
 #endif
@@ -4466,7 +4567,7 @@ static void gen_rfid(DisasContext *ctx)
     /* Restore CPU state */
     CHK_SV(ctx);
     translator_io_start(&ctx->base);
-    gen_update_cfar(ctx, ctx->cia);
+    gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_NORECORD);
     gen_helper_rfid(cpu_env);
     ctx->base.is_jmp = DISAS_EXIT;
 #endif
@@ -4481,7 +4582,7 @@ static void gen_rfscv(DisasContext *ctx)
     /* Restore CPU state */
     CHK_SV(ctx);
     translator_io_start(&ctx->base);
-    gen_update_cfar(ctx, ctx->cia);
+    gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_NORECORD);
     gen_helper_rfscv(cpu_env);
     ctx->base.is_jmp = DISAS_EXIT;
 #endif
@@ -7313,6 +7414,7 @@ static void ppc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 #if defined(TARGET_PPC64)
     ctx->sf_mode = (hflags >> HFLAGS_64) & 1;
     ctx->has_cfar = !!(env->flags & POWERPC_FLAG_CFAR);
+    ctx->has_bhrb = !!(env->flags & POWERPC_FLAG_BHRB);
 #endif
     ctx->lazy_tlb_flush = env->mmu_model == POWERPC_MMU_32B
         || env->mmu_model & POWERPC_MMU_64;
diff --git a/target/ppc/translate/branch-impl.c.inc b/target/ppc/translate/branch-impl.c.inc
index f9931b9d73..a76ec6f77e 100644
--- a/target/ppc/translate/branch-impl.c.inc
+++ b/target/ppc/translate/branch-impl.c.inc
@@ -17,7 +17,7 @@ static bool trans_RFEBB(DisasContext *ctx, arg_XL_s *arg)
     REQUIRE_INSNS_FLAGS2(ctx, ISA207S);
 
     translator_io_start(&ctx->base);
-    gen_update_cfar(ctx, ctx->cia);
+    gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_NORECORD);
     gen_helper_rfebb(cpu_env, cpu_gpr[arg->s]);
 
     ctx->base.is_jmp = DISAS_CHAIN;
-- 
2.31.1


