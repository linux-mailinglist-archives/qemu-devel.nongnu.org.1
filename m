Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1AA7739FB
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 13:59:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTLMS-0003ql-0F; Tue, 08 Aug 2023 07:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qTLMO-0003q0-MY
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 07:58:48 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qTLMM-0001bh-Ex
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 07:58:48 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RKs7Z4sKFz6J6mV;
 Tue,  8 Aug 2023 19:55:06 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 12:58:44 +0100
To: <qemu-devel@nongnu.org>
CC: Gavin Shan <gshan@redhat.com>, <linuxarm@huawei.com>, James Morse
 <james.morse@arm.com>, "peter . maydell @ linaro . org"
 <peter.maydell@linaro.org>, <zhao1.liu@linux.intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Shameerali Kolothum
 Thodi <shameerali.kolothum.thodi@huawei.com>, Yicong Yang
 <yangyicong@huawei.com>
Subject: [RFC PATCH 3/5] target/arm: Add support for MPAM CPU registers
Date: Tue, 8 Aug 2023 12:57:11 +0100
Message-ID: <20230808115713.2613-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230808115713.2613-1-Jonathan.Cameron@huawei.com>
References: <20230808115713.2613-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

It is common to support MPAM on CPU cores, but not in the rest
of the system, so there is little disadvantage in always enabling
these.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 target/arm/cpu.h    | 15 +++++++++++++++
 target/arm/cpu.c    | 10 +++++++++-
 target/arm/helper.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 88e5accda6..8d28e22291 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -735,6 +735,10 @@ typedef struct CPUArchState {
      * to keep the offsets into the rest of the structure smaller.
      */
     ARMVectorReg zarray[ARM_MAX_VQ * 16];
+
+    uint64_t mpam0_el1;
+    uint64_t mpam1_el1;
+
 #endif
 
     struct CPUBreakpoint *cpu_breakpoint[16];
@@ -1043,6 +1047,7 @@ struct ArchCPU {
         uint64_t id_aa64zfr0;
         uint64_t id_aa64smfr0;
         uint64_t reset_pmcr_el0;
+        uint64_t mpamidr_el1;
     } isar;
     uint64_t midr;
     uint32_t revidr;
@@ -2327,6 +2332,16 @@ FIELD(DBGDEVID, DOUBLELOCK, 20, 4)
 FIELD(DBGDEVID, AUXREGS, 24, 4)
 FIELD(DBGDEVID, CIDMASK, 28, 4)
 
+FIELD(MPAMIDR, PARTID_MAX, 0, 16)
+FIELD(MPAMIDR, HAS_HCR, 17, 1)
+FIELD(MPAMIDR, VMR_MAX, 18, 3)
+FIELD(MPAMIDR, PMG_MAX, 32, 8)
+FIELD(MPAMIDR, HAS_ALTSP, 57, 1)
+FIELD(MPAMIDR, HAS_TIDR, 58, 1)
+FIELD(MPAMIDR, SP4, 59, 1)
+FIELD(MPAMIDR, HAS_FORCE_NS, 60, 1)
+FIELD(MPAMIDR, HAS_SDEFLT, 61, 1)
+
 FIELD(MVFR0, SIMDREG, 0, 4)
 FIELD(MVFR0, FPSP, 4, 4)
 FIELD(MVFR0, FPDP, 8, 4)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 93c28d50e5..d85a3ec8a2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -305,6 +305,9 @@ static void arm_cpu_reset_hold(Object *obj)
         env->cp15.rvbar = cpu->rvbar_prop;
         env->pc = env->cp15.rvbar;
 #endif
+
+        env->mpam1_el1 = 1ULL << 63;
+
     } else {
 #if defined(CONFIG_USER_ONLY)
         /* Userspace expects access to cp10 and cp11 for FP/Neon */
@@ -2097,7 +2100,12 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
             FIELD_DP32(cpu->isar.id_pfr0, ID_PFR0, AMU, 0);
         /* FEAT_MPAM (Memory Partitioning and Monitoring Extension) */
         cpu->isar.id_aa64pfr0 =
-            FIELD_DP64(cpu->isar.id_aa64pfr0, ID_AA64PFR0, MPAM, 0);
+            FIELD_DP64(cpu->isar.id_aa64pfr0, ID_AA64PFR0, MPAM, 1);
+        cpu->isar.mpamidr_el1 =
+            FIELD_DP64(cpu->isar.mpamidr_el1, MPAMIDR, PARTID_MAX, 63);
+        cpu->isar.mpamidr_el1 =
+            FIELD_DP64(cpu->isar.mpamidr_el1, MPAMIDR, PMG_MAX, 3);
+
         /* FEAT_NV (Nested Virtualization) */
         cpu->isar.id_aa64mmfr2 =
             FIELD_DP64(cpu->isar.id_aa64mmfr2, ID_AA64MMFR2, NV, 0);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 50f61e42ca..dbeb8d9fa6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8072,7 +8072,17 @@ static const ARMCPRegInfo actlr2_hactlr2_reginfo[] = {
       .access = PL2_RW, .type = ARM_CP_CONST,
       .resetvalue = 0 },
 };
+/*
+static uint64_t mpam_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    return 0;
+}
 
+static void mpam_el1_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t val)
+{
+    return;
+}
+*/
 void register_cp_regs_for_features(ARMCPU *cpu)
 {
     /* Register all the coprocessor registers based on feature bits */
@@ -8404,6 +8414,26 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
               .resetvalue = 0 },
+
+            /* Should be separate feature */
+            { .name = "MPAMIDR_EL1", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 0, .crn = 0xa, .crm = 4, .opc2 = 4,
+              .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
+              .resetvalue = cpu->isar.mpamidr_el1 },
+            /* TODO: check the accessfn and whether we need a reset value for these */
+            { .name = "MPAM0_EL1", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 0, .crn = 0xa, .crm = 5, .opc2 = 1,
+              .access = PL1_RW, .type = ARM_CP_ALIAS,
+              .accessfn = access_aa64_tid3,
+              .fieldoffset = offsetof(CPUARMState, mpam0_el1),
+            },
+            { .name = "MPAM1_EL1", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 0, .crn = 0xa, .crm = 5, .opc2 = 0,
+              .access = PL1_RW, .type = ARM_CP_ALIAS,
+              .accessfn = access_aa64_tid3,
+              .fieldoffset = offsetof(CPUARMState, mpam1_el1),
+            },
             { .name = "MVFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
-- 
2.39.2


