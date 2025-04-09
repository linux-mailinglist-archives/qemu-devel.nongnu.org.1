Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 121C0A82852
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Apr 2025 16:45:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2WeY-0008Hq-C3; Wed, 09 Apr 2025 10:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1u2WeM-0008FH-Kc
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 10:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1u2WeI-00068I-DF
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 10:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744209808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZSBkA+zqw5R/IufhHEGuNZwZVqEv/46TgFvEM+OgFYM=;
 b=RTOqGiAkaUCLbPJLcYmHoQFkglMmqSc+OP4qWTwYPGNKhLw2nbNx4fCgaCtnkVZrs3HNxM
 nxrIP2sszCOLceFslQJuju8RktDooy84Obk734dv54fRARLvxQZdmk5/HAunypRmcEKBar
 B5y3m2YXvNWjcg4UAKgqQDrFGljZ2aM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-8TbrCal_O-CyvUoLWqxiQQ-1; Wed,
 09 Apr 2025 10:43:26 -0400
X-MC-Unique: 8TbrCal_O-CyvUoLWqxiQQ-1
X-Mimecast-MFC-AGG-ID: 8TbrCal_O-CyvUoLWqxiQQ_1744209804
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 775CB1800260; Wed,  9 Apr 2025 14:43:23 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.45.227.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C9E951828A83; Wed,  9 Apr 2025 14:43:16 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 agraf@csgraf.de
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH for-10.1 v5 01/13] arm/cpu: Add sysreg definitions in
 cpu-sysregs.h
Date: Wed,  9 Apr 2025 16:42:52 +0200
Message-ID: <20250409144304.912325-2-cohuck@redhat.com>
In-Reply-To: <20250409144304.912325-1-cohuck@redhat.com>
References: <20250409144304.912325-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Eric Auger <eric.auger@redhat.com>

This new header contains macros that define aarch64 registers.
In a subsequent patch, this will be replaced by a more exhaustive
version that will be generated from linux arch/arm64/tools/sysreg
file. Those macros are sufficient to migrate the storage of those
ID regs from named fields in isar struct to an array cell.

[CH: reworked to use different structures]
[CH: moved accessors from the patches first using them to here,
     dropped interaction with writable registers, which will happen
     later]
[CH: use DEF magic suggested by rth]
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/arm/cpu-sysregs.h     | 42 +++++++++++++++++++++++++++++++
 target/arm/cpu-sysregs.h.inc | 35 ++++++++++++++++++++++++++
 target/arm/cpu.h             | 49 ++++++++++++++++++++++++++++++++++++
 target/arm/cpu64.c           | 22 ++++++++++++++++
 4 files changed, 148 insertions(+)
 create mode 100644 target/arm/cpu-sysregs.h
 create mode 100644 target/arm/cpu-sysregs.h.inc

diff --git a/target/arm/cpu-sysregs.h b/target/arm/cpu-sysregs.h
new file mode 100644
index 000000000000..7877a3b06a8e
--- /dev/null
+++ b/target/arm/cpu-sysregs.h
@@ -0,0 +1,42 @@
+/*
+ * Definitions for Arm ID system registers
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef ARM_CPU_SYSREGS_H
+#define ARM_CPU_SYSREGS_H
+
+/*
+ * Following is similar to the coprocessor regs encodings, but with an argument
+ * ordering that matches the ARM ARM. We also reuse the various CP_REG_ defines
+ * that actually are the same as the equivalent KVM_REG_ values.
+ */
+#define ENCODE_ID_REG(op0, op1, crn, crm, op2)          \
+    (((op0) << CP_REG_ARM64_SYSREG_OP0_SHIFT) |         \
+     ((op1) << CP_REG_ARM64_SYSREG_OP1_SHIFT) |         \
+     ((crn) << CP_REG_ARM64_SYSREG_CRN_SHIFT) |         \
+     ((crm) << CP_REG_ARM64_SYSREG_CRM_SHIFT) |         \
+     ((op2) << CP_REG_ARM64_SYSREG_OP2_SHIFT))
+
+#define DEF(NAME, OP0, OP1, CRN, CRM, OP2) NAME##_IDX,
+
+typedef enum ARMIDRegisterIdx {
+#include "cpu-sysregs.h.inc"
+    NUM_ID_IDX,
+} ARMIDRegisterIdx;
+
+#undef DEF
+#define DEF(NAME, OP0, OP1, CRN, CRM, OP2) \
+    SYS_##NAME = ENCODE_ID_REG(OP0, OP1, CRN, CRM, OP2),
+
+typedef enum ARMSysRegs {
+#include "cpu-sysregs.h.inc"
+} ARMSysRegs;
+
+#undef DEF
+
+extern const uint32_t id_register_sysreg[NUM_ID_IDX];
+
+int get_sysreg_idx(ARMSysRegs sysreg);
+
+#endif /* ARM_CPU_SYSREGS_H */
diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
new file mode 100644
index 000000000000..6c9f9981cc5d
--- /dev/null
+++ b/target/arm/cpu-sysregs.h.inc
@@ -0,0 +1,35 @@
+DEF(ID_AA64PFR0_EL1, 3, 0, 0, 4, 0)
+DEF(ID_AA64PFR1_EL1, 3, 0, 0, 4, 1)
+DEF(ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
+DEF(ID_AA64DFR0_EL1, 3, 0, 0, 5, 0)
+DEF(ID_AA64DFR1_EL1, 3, 0, 0, 5, 1)
+DEF(ID_AA64ISAR0_EL1, 3, 0, 0, 6, 0)
+DEF(ID_AA64ISAR1_EL1, 3, 0, 0, 6, 1)
+DEF(ID_AA64ISAR2_EL1, 3, 0, 0, 6, 2)
+DEF(ID_AA64MMFR0_EL1, 3, 0, 0, 7, 0)
+DEF(ID_AA64MMFR1_EL1, 3, 0, 0, 7, 1)
+DEF(ID_AA64MMFR2_EL1, 3, 0, 0, 7, 2)
+DEF(ID_AA64MMFR3_EL1, 3, 0, 0, 7, 3)
+DEF(ID_PFR0_EL1, 3, 0, 0, 1, 0)
+DEF(ID_PFR1_EL1, 3, 0, 0, 1, 1)
+DEF(ID_DFR0_EL1, 3, 0, 0, 1, 2)
+DEF(ID_MMFR0_EL1, 3, 0, 0, 1, 4)
+DEF(ID_MMFR1_EL1, 3, 0, 0, 1, 5)
+DEF(ID_MMFR2_EL1, 3, 0, 0, 1, 6)
+DEF(ID_MMFR3_EL1, 3, 0, 0, 1, 7)
+DEF(ID_ISAR0_EL1, 3, 0, 0, 2, 0)
+DEF(ID_ISAR1_EL1, 3, 0, 0, 2, 1)
+DEF(ID_ISAR2_EL1, 3, 0, 0, 2, 2)
+DEF(ID_ISAR3_EL1, 3, 0, 0, 2, 3)
+DEF(ID_ISAR4_EL1, 3, 0, 0, 2, 4)
+DEF(ID_ISAR5_EL1, 3, 0, 0, 2, 5)
+DEF(ID_MMFR4_EL1, 3, 0, 0, 2, 6)
+DEF(ID_ISAR6_EL1, 3, 0, 0, 2, 7)
+DEF(MVFR0_EL1, 3, 0, 0, 3, 0)
+DEF(MVFR1_EL1, 3, 0, 0, 3, 1)
+DEF(MVFR2_EL1, 3, 0, 0, 3, 2)
+DEF(ID_PFR2_EL1, 3, 0, 0, 3, 4)
+DEF(ID_DFR1_EL1, 3, 0, 0, 3, 5)
+DEF(ID_MMFR5_EL1, 3, 0, 0, 3, 6)
+DEF(ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
+DEF(CTR_EL0, 3, 3, 0, 0, 1)
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a8177c6c2e89..5048c85b188c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -30,6 +30,7 @@
 #include "qapi/qapi-types-common.h"
 #include "target/arm/multiprocessing.h"
 #include "target/arm/gtimer.h"
+#include "target/arm/cpu-sysregs.h"
 
 #ifdef TARGET_AARCH64
 #define KVM_HAVE_MCE_INJECTION 1
@@ -855,6 +856,53 @@ typedef struct {
     uint32_t map, init, supported;
 } ARMVQMap;
 
+/* REG is ID_XXX */
+#define FIELD_DP64_IDREG(ISAR, REG, FIELD, VALUE)                       \
+    ({                                                                  \
+        ARMISARegisters *i_ = (ISAR);                                   \
+        uint64_t regval = i_->idregs[REG ## _EL1_IDX];                  \
+        regval = FIELD_DP64(regval, REG, FIELD, VALUE);                 \
+        i_->idregs[REG ## _EL1_IDX] = regval;                           \
+    })
+
+#define FIELD_DP32_IDREG(ISAR, REG, FIELD, VALUE)                       \
+    ({                                                                  \
+        ARMISARegisters *i_ = (ISAR);                                   \
+        uint64_t regval = i_->idregs[REG ## _EL1_IDX];                  \
+        regval = FIELD_DP32(regval, REG, FIELD, VALUE);                 \
+        i_->idregs[REG ## _EL1_IDX] = regval;                           \
+    })
+
+#define FIELD_EX64_IDREG(ISAR, REG, FIELD)                              \
+    ({                                                                  \
+        const ARMISARegisters *i_ = (ISAR);                             \
+        FIELD_EX64(i_->idregs[REG ## _EL1_IDX], REG, FIELD);            \
+    })
+
+#define FIELD_EX32_IDREG(ISAR, REG, FIELD)                              \
+    ({                                                                  \
+        const ARMISARegisters *i_ = (ISAR);                             \
+        FIELD_EX32(i_->idregs[REG ## _EL1_IDX], REG, FIELD);            \
+    })
+
+#define FIELD_SEX64_IDREG(ISAR, REG, FIELD)                             \
+    ({                                                                  \
+        const ARMISARegisters *i_ = (ISAR);                             \
+        FIELD_SEX64(i_->idregs[REG ## _EL1_IDX], REG, FIELD);           \
+    })
+
+#define SET_IDREG(ISAR, REG, VALUE)                                     \
+    ({                                                                  \
+        ARMISARegisters *i_ = (ISAR);                                   \
+        i_->idregs[REG ## _EL1_IDX] = VALUE;                            \
+    })
+
+#define GET_IDREG(ISAR, REG)                                            \
+    ({                                                                  \
+        const ARMISARegisters *i_ = (ISAR);                             \
+        i_->idregs[REG ## _EL1_IDX];                                    \
+    })
+
 /**
  * ARMCPU:
  * @env: #CPUARMState
@@ -1063,6 +1111,7 @@ struct ArchCPU {
         uint64_t id_aa64zfr0;
         uint64_t id_aa64smfr0;
         uint64_t reset_pmcr_el0;
+        uint64_t idregs[NUM_ID_IDX];
     } isar;
     uint64_t midr;
     uint32_t revidr;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 8188ede5cc8a..62eff5375c19 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -36,6 +36,28 @@
 #include "cpu-features.h"
 #include "cpregs.h"
 
+/* convert between <register>_IDX and SYS_<register> */
+#define DEF(NAME, OP0, OP1, CRN, CRM, OP2)      \
+    [NAME##_IDX] = SYS_##NAME,
+
+const uint32_t id_register_sysreg[NUM_ID_IDX] = {
+#include "cpu-sysregs.h.inc"
+};
+
+#undef DEF
+#define DEF(NAME, OP0, OP1, CRN, CRM, OP2) \
+    case SYS_##NAME: return NAME##_IDX;
+
+int get_sysreg_idx(ARMSysRegs sysreg)
+{
+    switch (sysreg) {
+#include "cpu-sysregs.h.inc"
+    }
+    g_assert_not_reached();
+}
+
+#undef DEF
+
 void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
 {
     /*
-- 
2.48.1


