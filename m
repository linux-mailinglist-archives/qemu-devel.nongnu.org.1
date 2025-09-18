Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18612B18ACB
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Aug 2025 07:43:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ui501-0000NR-5o; Sat, 02 Aug 2025 01:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ui4zw-0000GB-F4
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 01:41:36 -0400
Received: from p-east3-cluster1-host4-snip4-6.eps.apple.com ([57.103.87.39]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ui4zs-00067n-V8
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 01:41:35 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPS id
 EE6DA1800A8E; Sat,  2 Aug 2025 05:41:29 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=Xjn/7JH7TNET4FnKAh9AsOquJY6AmVFJa+7iy51ezoQ=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=UxF/vjB7yKpsb4Fn+QUhbfdEazUdKB4a59ranECMmUXSFsxIOf/PzNk0g4CANd7LV3wnO/EytoKbZEySVZFURFidYDuPlqwJuUdWRpg3PWSXb17+cC5PDTgY8SAr2Wr8alAs/juZ6zC5M56dgt+T8N36/N8E1HUkh4aIZSw5+l6Ms9fdnj68w6PHBg+tMrQFnFlT4biAje2RMQuwHZVFiydm2Rn6/RJbIuMB7dmd5eFI1IUI8EmYY0c+Trhy9Z78OlgUgbECj+4xBRRJZ95hskNReLAwUqnDYePKd6DHXcJMAtmt3My/rrqv2janm2sN12ejgjtPLJ91nfzH5s2TVg==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPSA id
 6B4C118008B2; Sat,  2 Aug 2025 05:41:27 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 12/14] whpx: arm64: implement -cpu host
Date: Sat,  2 Aug 2025 07:40:53 +0200
Message-Id: <20250802054055.74013-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250802054055.74013-1-mohamed@unpredictable.fr>
References: <20250802054055.74013-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDA0NyBTYWx0ZWRfX4fl33yYHw/ma
 6Z6HmG5PBU5XdB/6T6Z2KX5MfB8xpPCC7nPZBM+EukL4Sej/j7R99W2fVlKsC4jlxJYejDwhMYT
 KmlSfYpQLLa5JpsCgnD3f5zoQ17mQYhXE9uKONhfYG+t/v6f59yOBXrOcQy0HHTTWmC1t+0t8Gy
 z2vB6LutuicIf1cOmRpgdIVlpcMaTLNU/3I80kmBRParc+ik+bvqPBoa/D/5vEEeFefgBwMa2ZD
 Hn4dXtHJ9bweoLJ6ivuzmqc5S26h9NpuUujL4bZt1qXCIJ1gYcclXZGb9J4F8EPt2FDk0CY4w=
X-Proofpoint-GUID: JJJV_HsRlqAww9FsEdswU24nEc8TUuQe
X-Proofpoint-ORIG-GUID: JJJV_HsRlqAww9FsEdswU24nEc8TUuQe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1030 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508020047
Received-SPF: pass client-ip=57.103.87.39;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

OpenProcessorKey and ReadRegU64 adapted from:
https://github.com/FEX-Emu/FEX/blob/e6de17e72ef03aa88ba14fa0ec13163061608c74/Source/Windows/Common/CPUFeatures.cpp#L62

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/arm/virt.c              |   2 +-
 target/arm/cpu64.c         |  14 ++--
 target/arm/whpx/whpx-all.c | 130 +++++++++++++++++++++++++++++++++++++
 target/arm/whpx_arm.h      |   1 +
 4 files changed, 142 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3682d42482..321f6c6612 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3249,7 +3249,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
 #ifdef TARGET_AARCH64
         ARM_CPU_TYPE_NAME("cortex-a53"),
         ARM_CPU_TYPE_NAME("cortex-a57"),
-#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
+#if defined(CONFIG_KVM) || defined(CONFIG_HVF) || defined(CONFIG_WHPX)
         ARM_CPU_TYPE_NAME("host"),
 #endif /* CONFIG_KVM || CONFIG_HVF */
 #endif /* TARGET_AARCH64 */
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 26cf7e6dfa..894b2934fa 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -26,10 +26,12 @@
 #include "qemu/units.h"
 #include "system/kvm.h"
 #include "system/hvf.h"
+#include "system/whpx.h"
 #include "system/qtest.h"
 #include "system/tcg.h"
 #include "kvm_arm.h"
 #include "hvf_arm.h"
+#include "whpx_arm.h"
 #include "qapi/visitor.h"
 #include "hw/qdev-properties.h"
 #include "internals.h"
@@ -522,7 +524,7 @@ void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
     isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, APA3, 0);
     isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, GPA3, 0);
 
-    if (kvm_enabled() || hvf_enabled()) {
+    if (kvm_enabled() || hvf_enabled() || whpx_enabled()) {
         /*
          * Exit early if PAuth is enabled and fall through to disable it.
          * The algorithm selection properties are not present.
@@ -599,7 +601,7 @@ void aarch64_add_pauth_properties(Object *obj)
 
     /* Default to PAUTH on, with the architected algorithm on TCG. */
     qdev_property_add_static(DEVICE(obj), &arm_cpu_pauth_property);
-    if (kvm_enabled() || hvf_enabled()) {
+    if (kvm_enabled() || hvf_enabled() || whpx_enabled()) {
         /*
          * Mirror PAuth support from the probed sysregs back into the
          * property for KVM or hvf. Is it just a bit backward? Yes it is!
@@ -773,6 +775,10 @@ static void aarch64_host_initfn(Object *obj)
     ARMCPU *cpu = ARM_CPU(obj);
     hvf_arm_set_cpu_features_from_host(cpu);
     aarch64_add_pauth_properties(obj);
+#elif defined(CONFIG_WHPX)
+    ARMCPU *cpu = ARM_CPU(obj);
+    whpx_arm_set_cpu_features_from_host(cpu);
+    aarch64_add_pauth_properties(obj);
 #else
     g_assert_not_reached();
 #endif
@@ -780,7 +786,7 @@ static void aarch64_host_initfn(Object *obj)
 
 static void aarch64_max_initfn(Object *obj)
 {
-    if (kvm_enabled() || hvf_enabled()) {
+    if (kvm_enabled() || hvf_enabled() || whpx_enabled()) {
         /* With KVM or HVF, '-cpu max' is identical to '-cpu host' */
         aarch64_host_initfn(obj);
         return;
@@ -800,7 +806,7 @@ static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "cortex-a57",         .initfn = aarch64_a57_initfn },
     { .name = "cortex-a53",         .initfn = aarch64_a53_initfn },
     { .name = "max",                .initfn = aarch64_max_initfn },
-#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
+#if defined(CONFIG_KVM) || defined(CONFIG_HVF) || defined(CONFIG_WHPX)
     { .name = "host",               .initfn = aarch64_host_initfn },
 #endif
 };
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 76e6419efe..8d705abdc5 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -41,6 +41,17 @@
 
 #include <winhvplatform.h>
 #include <winhvplatformdefs.h>
+#include <winreg.h>
+
+typedef struct ARMHostCPUFeatures {
+    ARMISARegisters isar;
+    uint64_t features;
+    uint64_t midr;
+    uint32_t reset_sctlr;
+    const char *dtb_compatible;
+} ARMHostCPUFeatures;
+
+static ARMHostCPUFeatures arm_host_cpu_features;
 
 struct whpx_reg_match {
     WHV_REGISTER_NAME reg;
@@ -676,6 +687,125 @@ static void clamp_id_aa64mmfr0_parange_to_ipa_size(ARMISARegisters *isar)
     SET_IDREG(isar, ID_AA64MMFR0, id_aa64mmfr0);
 }
 
+static HKEY OpenProcessorKey(void)
+{
+  HKEY Out;
+  const char *path = "Hardware\\Description\\System\\CentralProcessor\\0\\";
+  if (RegOpenKeyExA(HKEY_LOCAL_MACHINE, path, 0, KEY_READ, &Out)) {
+    return NULL;
+  }
+  return Out;
+}
+
+static uint64_t ReadRegU64(HKEY Key, const char *name)
+{
+  uint64_t Value = 0;
+  DWORD Size = sizeof(Value);
+  LONG res = RegGetValueA(Key, NULL, name, RRF_RT_REG_QWORD, NULL, &Value, &Size);
+  if (res != ERROR_SUCCESS) {
+    printf("Failed to get register value: error: 0x%x\n", res);
+  }
+  return Value;
+}
+
+static bool whpx_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
+{
+    ARMISARegisters host_isar = {};
+    const struct isar_regs {
+        WHV_REGISTER_NAME reg;
+        uint64_t *val;
+    } regs[] = {
+        { WHvArm64RegisterIdAa64Pfr0El1, &host_isar.idregs[ID_AA64PFR0_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Pfr1El1, &host_isar.idregs[ID_AA64PFR1_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Dfr0El1, &host_isar.idregs[ID_AA64DFR0_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Dfr1El1 , &host_isar.idregs[ID_AA64DFR1_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Isar0El1, &host_isar.idregs[ID_AA64ISAR0_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Isar1El1, &host_isar.idregs[ID_AA64ISAR1_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Isar2El1, &host_isar.idregs[ID_AA64ISAR1_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Mmfr0El1, &host_isar.idregs[ID_AA64MMFR0_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Mmfr1El1, &host_isar.idregs[ID_AA64MMFR1_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Mmfr2El1, &host_isar.idregs[ID_AA64MMFR2_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Mmfr3El1, &host_isar.idregs[ID_AA64MMFR2_EL1_IDX] }
+    };
+
+    int i;
+    WHV_REGISTER_VALUE val;
+
+    ahcf->dtb_compatible = "arm,armv8";
+    ahcf->features = (1ULL << ARM_FEATURE_V8) |
+                     (1ULL << ARM_FEATURE_NEON) |
+                     (1ULL << ARM_FEATURE_AARCH64) |
+                     (1ULL << ARM_FEATURE_PMU) |
+                     (1ULL << ARM_FEATURE_GENERIC_TIMER);
+
+    for (i = 0; i < ARRAY_SIZE(regs); i++) {
+        clean_whv_register_value(&val);
+        whpx_get_global_reg(regs[i].reg, &val);
+        *regs[i].val = val.Reg64;
+    }
+
+    /*
+     * MIDR_EL1 is not a global register on WHPX
+     * As such, read the CPU0 from the registry to get a consistent value.
+     * Otherwise, on heterogenous systems, you'll get variance between CPUs.
+     */
+    HKEY ProcessorKey = OpenProcessorKey();
+    ahcf->midr = ReadRegU64(ProcessorKey, "CP 4000");
+    RegCloseKey(ProcessorKey);
+
+    clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar);
+
+    /*
+     * Disable SME, which is not properly handled by QEMU hvf yet.
+     * To allow this through we would need to:
+     * - make sure that the SME state is correctly handled in the
+     *   get_registers/put_registers functions
+     * - get the SME-specific CPU properties to work with accelerators
+     *   other than TCG
+     * - fix any assumptions we made that SME implies SVE (since
+     *   on the M4 there is SME but not SVE)
+     */
+    SET_IDREG(&host_isar, ID_AA64PFR1,
+              GET_IDREG(&host_isar, ID_AA64PFR1) & ~R_ID_AA64PFR1_SME_MASK);
+
+    ahcf->isar = host_isar;
+
+    /*
+     * A scratch vCPU returns SCTLR 0, so let's fill our default with the M1
+     * boot SCTLR from https://github.com/AsahiLinux/m1n1/issues/97
+     */
+    ahcf->reset_sctlr = 0x30100180;
+    /*
+     * SPAN is disabled by default when SCTLR.SPAN=1. To improve compatibility,
+     * let's disable it on boot and then allow guest software to turn it on by
+     * setting it to 0.
+     */
+    ahcf->reset_sctlr |= 0x00800000;
+
+    return true;
+}
+
+void whpx_arm_set_cpu_features_from_host(ARMCPU *cpu)
+{
+    if (!arm_host_cpu_features.dtb_compatible) {
+        if (!whpx_enabled() ||
+            !whpx_arm_get_host_cpu_features(&arm_host_cpu_features)) {
+            /*
+             * We can't report this error yet, so flag that we need to
+             * in arm_cpu_realizefn().
+             */
+            cpu->host_cpu_probe_failed = true;
+            return;
+        }
+    }
+
+    cpu->dtb_compatible = arm_host_cpu_features.dtb_compatible;
+    cpu->isar = arm_host_cpu_features.isar;
+    cpu->env.features = arm_host_cpu_features.features;
+    cpu->midr = arm_host_cpu_features.midr;
+    cpu->reset_sctlr = arm_host_cpu_features.reset_sctlr;
+}
+
 int whpx_init_vcpu(CPUState *cpu)
 {
     HRESULT hr;
diff --git a/target/arm/whpx_arm.h b/target/arm/whpx_arm.h
index de7406b66f..df65fd753c 100644
--- a/target/arm/whpx_arm.h
+++ b/target/arm/whpx_arm.h
@@ -12,5 +12,6 @@
 #include "target/arm/cpu-qom.h"
 
 uint32_t whpx_arm_get_ipa_bit_size(void);
+void whpx_arm_set_cpu_features_from_host(ARMCPU *cpu);
 
 #endif
-- 
2.39.5 (Apple Git-154)


