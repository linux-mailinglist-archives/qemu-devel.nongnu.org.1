Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 556CBA2C130
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Feb 2025 12:04:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgM95-0002ZU-71; Fri, 07 Feb 2025 06:03:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tgM93-0002ZG-0r
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 06:03:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tgM90-0006Qb-VR
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 06:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738926214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8vB/F330imXfrbPqPK7zIsCGJwFTCx56GOWuag21sG8=;
 b=cCJ2rJE8/83dqGtYjZTakDh7NRXjR2JgfqjbXsz+paWIZ1Xy+dpz+dmQQPaBf3XiGuIJa1
 H28XOWjQO0j/g7oU3a2Lzh0Lr+VO+N2uBCyTaNAXB3/426S774vpOBfSS47DRMLDtsNBRk
 OlxAXqGi+ZrvxKKbP0OgPByP+jyZglA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-SCNAa5myMXe2YrqIKjR1ZA-1; Fri,
 07 Feb 2025 06:03:30 -0500
X-MC-Unique: SCNAa5myMXe2YrqIKjR1ZA-1
X-Mimecast-MFC-AGG-ID: SCNAa5myMXe2YrqIKjR1ZA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4457F195609F; Fri,  7 Feb 2025 11:03:27 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.67.24.130])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0A40719560A3; Fri,  7 Feb 2025 11:03:12 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 01/15] arm/cpu: Add sysreg definitions in cpu-sysregs.h
Date: Fri,  7 Feb 2025 12:02:34 +0100
Message-ID: <20250207110248.1580465-2-cohuck@redhat.com>
In-Reply-To: <20250207110248.1580465-1-cohuck@redhat.com>
References: <20250207110248.1580465-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/arm/cpu-sysregs.h | 131 +++++++++++++++++++++++++++++++++++++++
 target/arm/cpu.h         |  42 +++++++++++++
 2 files changed, 173 insertions(+)
 create mode 100644 target/arm/cpu-sysregs.h

diff --git a/target/arm/cpu-sysregs.h b/target/arm/cpu-sysregs.h
new file mode 100644
index 000000000000..de09ebae91a5
--- /dev/null
+++ b/target/arm/cpu-sysregs.h
@@ -0,0 +1,131 @@
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
+typedef enum ARMIDRegisterIdx {
+    ID_AA64PFR0_EL1_IDX,
+    ID_AA64PFR1_EL1_IDX,
+    ID_AA64SMFR0_EL1_IDX,
+    ID_AA64DFR0_EL1_IDX,
+    ID_AA64DFR1_EL1_IDX,
+    ID_AA64ISAR0_EL1_IDX,
+    ID_AA64ISAR1_EL1_IDX,
+    ID_AA64ISAR2_EL1_IDX,
+    ID_AA64MMFR0_EL1_IDX,
+    ID_AA64MMFR1_EL1_IDX,
+    ID_AA64MMFR2_EL1_IDX,
+    ID_AA64MMFR3_EL1_IDX,
+    ID_PFR0_EL1_IDX,
+    ID_PFR1_EL1_IDX,
+    ID_DFR0_EL1_IDX,
+    ID_MMFR0_EL1_IDX,
+    ID_MMFR1_EL1_IDX,
+    ID_MMFR2_EL1_IDX,
+    ID_MMFR3_EL1_IDX,
+    ID_ISAR0_EL1_IDX,
+    ID_ISAR1_EL1_IDX,
+    ID_ISAR2_EL1_IDX,
+    ID_ISAR3_EL1_IDX,
+    ID_ISAR4_EL1_IDX,
+    ID_ISAR5_EL1_IDX,
+    ID_MMFR4_EL1_IDX,
+    ID_ISAR6_EL1_IDX,
+    MVFR0_EL1_IDX,
+    MVFR1_EL1_IDX,
+    MVFR2_EL1_IDX,
+    ID_PFR2_EL1_IDX,
+    ID_DFR1_EL1_IDX,
+    ID_MMFR5_EL1_IDX,
+    ID_AA64ZFR0_EL1_IDX,
+    CTR_EL0_IDX,
+    NUM_ID_IDX,
+} ARMIDRegisterIdx;
+
+typedef enum ARMSysRegs {
+    SYS_ID_AA64PFR0_EL1 = ENCODE_ID_REG(3, 0, 0, 4, 0),
+    SYS_ID_AA64PFR1_EL1 = ENCODE_ID_REG(3, 0, 0, 4, 1),
+    SYS_ID_AA64SMFR0_EL1 = ENCODE_ID_REG(3, 0, 0, 4, 5),
+    SYS_ID_AA64DFR0_EL1 = ENCODE_ID_REG(3, 0, 0, 5, 0),
+    SYS_ID_AA64DFR1_EL1 = ENCODE_ID_REG(3, 0, 0, 5, 1),
+    SYS_ID_AA64ISAR0_EL1 = ENCODE_ID_REG(3, 0, 0, 6, 0),
+    SYS_ID_AA64ISAR1_EL1 = ENCODE_ID_REG(3, 0, 0, 6, 1),
+    SYS_ID_AA64ISAR2_EL1 = ENCODE_ID_REG(3, 0, 0, 6, 2),
+    SYS_ID_AA64MMFR0_EL1 = ENCODE_ID_REG(3, 0, 0, 7, 0),
+    SYS_ID_AA64MMFR1_EL1 = ENCODE_ID_REG(3, 0, 0, 7, 1),
+    SYS_ID_AA64MMFR2_EL1 = ENCODE_ID_REG(3, 0, 0, 7, 2),
+    SYS_ID_AA64MMFR3_EL1 = ENCODE_ID_REG(3, 0, 0, 7, 3),
+    SYS_ID_PFR0_EL1 = ENCODE_ID_REG(3, 0, 0, 1, 0),
+    SYS_ID_PFR1_EL1 = ENCODE_ID_REG(3, 0, 0, 1, 1),
+    SYS_ID_DFR0_EL1 = ENCODE_ID_REG(3, 0, 0, 1, 2),
+    SYS_ID_MMFR0_EL1 = ENCODE_ID_REG(3, 0, 0, 1, 4),
+    SYS_ID_MMFR1_EL1 = ENCODE_ID_REG(3, 0, 0, 1, 5),
+    SYS_ID_MMFR2_EL1 = ENCODE_ID_REG(3, 0, 0, 1, 6),
+    SYS_ID_MMFR3_EL1 = ENCODE_ID_REG(3, 0, 0, 1, 7),
+    SYS_ID_ISAR0_EL1 = ENCODE_ID_REG(3, 0, 0, 2, 0),
+    SYS_ID_ISAR1_EL1 = ENCODE_ID_REG(3, 0, 0, 2, 1),
+    SYS_ID_ISAR2_EL1 = ENCODE_ID_REG(3, 0, 0, 2, 2),
+    SYS_ID_ISAR3_EL1 = ENCODE_ID_REG(3, 0, 0, 2, 3),
+    SYS_ID_ISAR4_EL1 = ENCODE_ID_REG(3, 0, 0, 2, 4),
+    SYS_ID_ISAR5_EL1 = ENCODE_ID_REG(3, 0, 0, 2, 5),
+    SYS_ID_MMFR4_EL1 = ENCODE_ID_REG(3, 0, 0, 2, 6),
+    SYS_ID_ISAR6_EL1 = ENCODE_ID_REG(3, 0, 0, 2, 7),
+    SYS_MVFR0_EL1 = ENCODE_ID_REG(3, 0, 0, 3, 0),
+    SYS_MVFR1_EL1 = ENCODE_ID_REG(3, 0, 0, 3, 1),
+    SYS_MVFR2_EL1 = ENCODE_ID_REG(3, 0, 0, 3, 2),
+    SYS_ID_PFR2_EL1 = ENCODE_ID_REG(3, 0, 0, 3, 4),
+    SYS_ID_DFR1_EL1 = ENCODE_ID_REG(3, 0, 0, 3, 5),
+    SYS_ID_MMFR5_EL1 = ENCODE_ID_REG(3, 0, 0, 3, 6),
+    SYS_ID_AA64ZFR0_EL1 = ENCODE_ID_REG(3, 0, 0, 4, 4),
+    SYS_CTR_EL0 = ENCODE_ID_REG(3, 3, 0, 0, 1),
+} ARMSysRegs;
+
+static const uint32_t id_register_sysreg[NUM_ID_IDX] = {
+    [ID_AA64PFR0_EL1_IDX] = SYS_ID_AA64PFR0_EL1,
+    [ID_AA64PFR1_EL1_IDX] = SYS_ID_AA64PFR1_EL1,
+    [ID_AA64SMFR0_EL1_IDX] = SYS_ID_AA64SMFR0_EL1,
+    [ID_AA64DFR0_EL1_IDX] = SYS_ID_AA64DFR0_EL1,
+    [ID_AA64DFR1_EL1_IDX] = SYS_ID_AA64DFR1_EL1,
+    [ID_AA64ISAR0_EL1_IDX] = SYS_ID_AA64ISAR0_EL1,
+    [ID_AA64ISAR1_EL1_IDX] = SYS_ID_AA64ISAR1_EL1,
+    [ID_AA64ISAR2_EL1_IDX] = SYS_ID_AA64ISAR2_EL1,
+    [ID_AA64MMFR0_EL1_IDX] = SYS_ID_AA64MMFR0_EL1,
+    [ID_AA64MMFR1_EL1_IDX] = SYS_ID_AA64MMFR1_EL1,
+    [ID_AA64MMFR2_EL1_IDX] = SYS_ID_AA64MMFR2_EL1,
+    [ID_AA64MMFR3_EL1_IDX] = SYS_ID_AA64MMFR3_EL1,
+    [ID_PFR0_EL1_IDX] = SYS_ID_PFR0_EL1,
+    [ID_PFR1_EL1_IDX] = SYS_ID_PFR1_EL1,
+    [ID_DFR0_EL1_IDX] = SYS_ID_DFR0_EL1,
+    [ID_MMFR0_EL1_IDX] = SYS_ID_MMFR0_EL1,
+    [ID_MMFR1_EL1_IDX] = SYS_ID_MMFR1_EL1,
+    [ID_MMFR2_EL1_IDX] = SYS_ID_MMFR2_EL1,
+    [ID_MMFR3_EL1_IDX] = SYS_ID_MMFR3_EL1,
+    [ID_ISAR0_EL1_IDX] = SYS_ID_ISAR0_EL1,
+    [ID_ISAR1_EL1_IDX] = SYS_ID_ISAR1_EL1,
+    [ID_ISAR2_EL1_IDX] = SYS_ID_ISAR2_EL1,
+    [ID_ISAR3_EL1_IDX] = SYS_ID_ISAR3_EL1,
+    [ID_ISAR4_EL1_IDX] = SYS_ID_ISAR4_EL1,
+    [ID_ISAR5_EL1_IDX] = SYS_ID_ISAR5_EL1,
+    [ID_MMFR4_EL1_IDX] = SYS_ID_MMFR4_EL1,
+    [ID_ISAR6_EL1_IDX] = SYS_ID_ISAR6_EL1,
+    [MVFR0_EL1_IDX] = SYS_MVFR0_EL1,
+    [MVFR1_EL1_IDX] = SYS_MVFR1_EL1,
+    [MVFR2_EL1_IDX] = SYS_MVFR2_EL1,
+    [ID_PFR2_EL1_IDX] = SYS_ID_PFR2_EL1,
+    [ID_DFR1_EL1_IDX] = SYS_ID_DFR1_EL1,
+    [ID_MMFR5_EL1_IDX] = SYS_ID_MMFR5_EL1,
+    [ID_AA64ZFR0_EL1_IDX] = SYS_ID_AA64ZFR0_EL1,
+    [CTR_EL0_IDX] = SYS_CTR_EL0,
+};
+
+#endif /* ARM_CPU_SYSREGS_H */
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2213c277348d..4bbce34e268d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -30,6 +30,7 @@
 #include "qapi/qapi-types-common.h"
 #include "target/arm/multiprocessing.h"
 #include "target/arm/gtimer.h"
+#include "target/arm/cpu-sysregs.h"
 
 #ifdef TARGET_AARCH64
 #define KVM_HAVE_MCE_INJECTION 1
@@ -832,6 +833,46 @@ typedef struct {
     uint32_t map, init, supported;
 } ARMVQMap;
 
+static inline uint64_t _get_idreg(uint64_t *idregs, uint32_t index)
+{
+    return idregs[index];
+}
+
+static inline void _set_idreg(uint64_t *idregs, uint32_t index, uint64_t value)
+{
+    idregs[index] = value;
+}
+
+/* REG is ID_XXX */
+#define FIELD_DP64_IDREG(ARRAY, REG, FIELD, VALUE)              \
+{                                                             \
+    uint64_t regval = _get_idreg((uint64_t *)ARRAY, REG ## _EL1_IDX);   \
+        regval = FIELD_DP64(regval, REG, FIELD, VALUE);                 \
+    _set_idreg((uint64_t *)ARRAY, REG ## _EL1_IDX, regval);             \
+}
+
+#define FIELD_DP32_IDREG(ARRAY, REG, FIELD, VALUE)              \
+{                                                             \
+uint64_t regval = _get_idreg((uint64_t *)ARRAY, REG ## _EL1_IDX);       \
+regval = FIELD_DP32(regval, REG, FIELD, VALUE);               \
+_set_idreg((uint64_t *)ARRAY, REG ## _EL1_IDX, regval);                 \
+}
+
+#define FIELD_EX64_IDREG(ARRAY, REG, FIELD)                     \
+FIELD_EX64(_get_idreg((uint64_t *)ARRAY, REG ## _EL1_IDX), REG, FIELD)  \
+
+#define FIELD_EX32_IDREG(ARRAY, REG, FIELD)                     \
+FIELD_EX32(_get_idreg((uint64_t *)ARRAY, REG ## _EL1_IDX), REG, FIELD)  \
+
+#define FIELD_SEX64_IDREG(ARRAY, REG, FIELD)                     \
+FIELD_SEX64(_get_idreg((uint64_t *)ARRAY, REG ## _EL1_IDX), REG, FIELD)  \
+
+#define SET_IDREG(ARRAY, REG, VALUE)                            \
+_set_idreg((uint64_t *)ARRAY, REG ## _EL1_IDX, VALUE)
+
+#define GET_IDREG(ARRAY, REG)                                   \
+_get_idreg((uint64_t *)ARRAY, REG ## _EL1_IDX)
+
 /**
  * ARMCPU:
  * @env: #CPUARMState
@@ -1040,6 +1081,7 @@ struct ArchCPU {
         uint64_t id_aa64zfr0;
         uint64_t id_aa64smfr0;
         uint64_t reset_pmcr_el0;
+        uint64_t idregs[NUM_ID_IDX];
     } isar;
     uint64_t midr;
     uint32_t revidr;
-- 
2.48.1


