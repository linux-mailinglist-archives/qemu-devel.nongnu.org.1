Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9B5B8CA36
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Sep 2025 16:07:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzyBO-0006uH-CI; Sat, 20 Sep 2025 10:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uzyBI-0006sg-Dp
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:03:16 -0400
Received: from p-east3-cluster5-host7-snip4-1.eps.apple.com ([57.103.86.192]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uzyBE-00088K-Eb
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:03:16 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPS id
 ADDBD18170A6; Sat, 20 Sep 2025 14:02:54 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=9DO7ZLqoZet8+Bm6olCSBQSMPUSwsTR+/VVlSy+vLBc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=CuMK2txQdvJYrpYlEsBp07zEouN6OGEq89c//SyfFzpEEy4kta8l4KlrfgotHWBZoWxIA88eIFju/GhJeCsmAzvHKhcddXkOpIyFBGR0fp3NboiFx8DuxWPNbCCwiR3DEGLtvYO/d5husytvcusxANPw0iLy3JeDh9FnQGgp3ebBWl7YFM1NRottwtR2feKijClrOngJiU1r+L1TRhMAKXrtsVt0IkDRpBbecgaC6kdlckybHmiZwVSSbMtFaVetxQhEmi1zZSE43JFCcSuGS0/f3ImoCKgO7OV9RlthhHTVQm6LXWOnOr5CFYHWxyC7uEYznTu7L6bz9rNaEm/9dg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPSA id
 F1D1C1817258; Sat, 20 Sep 2025 14:02:17 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 kvm@vger.kernel.org, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Eduardo Habkost <eduardo@habkost.net>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v6 17/23] whpx: arm64: implement -cpu host
Date: Sat, 20 Sep 2025 16:01:18 +0200
Message-ID: <20250920140124.63046-18-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250920140124.63046-1-mohamed@unpredictable.fr>
References: <20250920140124.63046-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9gF7vpZOBk08lKvJMpoQvBQUwzXDM-aG
X-Proofpoint-GUID: 9gF7vpZOBk08lKvJMpoQvBQUwzXDM-aG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDEzNiBTYWx0ZWRfX0mL34bpXiaXB
 ihzgMu3sgok6YwonwcSJe851utuRcAGSBmZ/fSD5dMTbbI5orojMYlzasRnJg7MxcUoEVGhTLs7
 QJH7W94Q6HZOhs8L2kE2vGFl7DQmxX7YLjvuwqTsnqgA5nXAIecrjQ3WD6ihkNs5vn2u+fOR++T
 Kq1LniRDJiTLHRGVWGHkAdNeg9bAFUkAnr6EtnIPuS82AlTB0QuCR4I3LNI4kPueDnHjNG2QCPc
 oona+7l00unxSfoJpSvUluvGEr6rI9icXAp1FcDpmslhkTpXH3USlLtpBNPQFpnoe40ZLb12I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_05,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509200136
X-JNJ: AAAAAAABDghZUYCnsPJffSug5GHWPfvl0maBV01nHFhpQlRKtLNBI3TG74OR4Z3wtRpfQcCBSnxYgrl+KKtEaevSiOyewZ7Yk0I5HgMI8K377nr7jgTICJ4Qm+wDKOxy9m9jMcWw3yqXLx1aXsRP+JdGyRdw6SHz90KlzBUa6rNavb7/Zyrstk9hizSDVfYhimPtxopeTcng9h7JxQsibiT9CnV97Ua36VXwX0z114Om5NrJDQOwz0UyU34gFFyM5KrzTD8psMLhtPwMxVBlD3uHWD5mR6BPqadJT8F6VHfWTjUegUFE+ApZT8V8Ly5VVOKaF0J86L3efhiwwn2zANSoJIJnwm94mtHEqgjL5U2KGj2ep05g6+sIYu3WghYxGr/VvAaLWH1VugCzRQT1aXJhlGwvke0j+wdKLHr/K3nILfb40DebnPxlP1+3rvyEVJuEfwyhcxLEEjeGnuCI7AyM/sdH995WZQ3VNlUemwwcL6zuARSVe9gHgJ7yCik4pgXspEbz9Vgd9r+iO59IFWNWw8q7wMU/zHhVYus/Zn9U4KAoDAOLNpFqo+ef0JYXLeLBoXGXhkVSgzZaNgG5lvZCiV7CH3s8XZisPteS1JGAaGc+h0eErF6ZGsEi+KTcVqCu9BOzSYT0pKX6oOa7FA6nkvAdYT4QuXZDfCrWdkRAktACunrUaBeLK6Cm3vdGylC8iiLGWU20RLPuBS80hwbobIt97RqgWWf3kXoO1sjCQPWRBbkY9BvMHGRx6+O03WcafCY0yA3jmHX/9UjfJHKvUWCOuagSNM1n5f3Z2p7F2qT7C8xRouJGj/iN4XbWsM5koAL/RE4jx/VDOolXQRkpQTcTCdlrH9YSFgaKcW9bTVe4NmgqaRPXCR+WdhBGYJo=
Received-SPF: pass client-ip=57.103.86.192;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Logic to fetch MIDR_EL1 for cpu 0 adapted from:
https://github.com/FEX-Emu/FEX/blob/e6de17e72ef03aa88ba14fa0ec13163061608c74/Source/Windows/Common/CPUFeatures.cpp#L62

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/arm/virt.c              |   2 +-
 target/arm/cpu64.c         |  19 ++++---
 target/arm/whpx/whpx-all.c | 104 +++++++++++++++++++++++++++++++++++++
 target/arm/whpx_arm.h      |   1 +
 4 files changed, 119 insertions(+), 7 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index fd4eaee68d..f9485fb119 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3291,7 +3291,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
 #ifdef TARGET_AARCH64
         ARM_CPU_TYPE_NAME("cortex-a53"),
         ARM_CPU_TYPE_NAME("cortex-a57"),
-#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
+#if defined(CONFIG_KVM) || defined(CONFIG_HVF) || defined(CONFIG_WHPX)
         ARM_CPU_TYPE_NAME("host"),
 #endif /* CONFIG_KVM || CONFIG_HVF */
 #endif /* TARGET_AARCH64 */
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 26cf7e6dfa..3f00071081 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -26,10 +26,13 @@
 #include "qemu/units.h"
 #include "system/kvm.h"
 #include "system/hvf.h"
+#include "system/whpx.h"
+#include "system/hw_accel.h"
 #include "system/qtest.h"
 #include "system/tcg.h"
 #include "kvm_arm.h"
 #include "hvf_arm.h"
+#include "whpx_arm.h"
 #include "qapi/visitor.h"
 #include "hw/qdev-properties.h"
 #include "internals.h"
@@ -522,7 +525,7 @@ void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
     isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, APA3, 0);
     isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, GPA3, 0);
 
-    if (kvm_enabled() || hvf_enabled()) {
+    if (hwaccel_enabled()) {
         /*
          * Exit early if PAuth is enabled and fall through to disable it.
          * The algorithm selection properties are not present.
@@ -599,10 +602,10 @@ void aarch64_add_pauth_properties(Object *obj)
 
     /* Default to PAUTH on, with the architected algorithm on TCG. */
     qdev_property_add_static(DEVICE(obj), &arm_cpu_pauth_property);
-    if (kvm_enabled() || hvf_enabled()) {
+    if (hwaccel_enabled()) {
         /*
          * Mirror PAuth support from the probed sysregs back into the
-         * property for KVM or hvf. Is it just a bit backward? Yes it is!
+         * property for HW accel. Is it just a bit backward? Yes it is!
          * Note that prop_pauth is true whether the host CPU supports the
          * architected QARMA5 algorithm or the IMPDEF one. We don't
          * provide the separate pauth-impdef property for KVM or hvf,
@@ -773,6 +776,10 @@ static void aarch64_host_initfn(Object *obj)
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
@@ -780,8 +787,8 @@ static void aarch64_host_initfn(Object *obj)
 
 static void aarch64_max_initfn(Object *obj)
 {
-    if (kvm_enabled() || hvf_enabled()) {
-        /* With KVM or HVF, '-cpu max' is identical to '-cpu host' */
+    if (hwaccel_enabled()) {
+        /* When hardware acceleration enabled, '-cpu max' is identical to '-cpu host' */
         aarch64_host_initfn(obj);
         return;
     }
@@ -800,7 +807,7 @@ static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "cortex-a57",         .initfn = aarch64_a57_initfn },
     { .name = "cortex-a53",         .initfn = aarch64_a53_initfn },
     { .name = "max",                .initfn = aarch64_max_initfn },
-#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
+#if defined(CONFIG_KVM) || defined(CONFIG_HVF) || defined(CONFIG_WHPX)
     { .name = "host",               .initfn = aarch64_host_initfn },
 #endif
 };
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 19513b50a3..680954f4b5 100644
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
@@ -695,6 +706,99 @@ static void clamp_id_aa64mmfr0_parange_to_ipa_size(ARMISARegisters *isar)
     SET_IDREG(isar, ID_AA64MMFR0, id_aa64mmfr0);
 }
 
+static uint64_t whpx_read_midr(void)
+{
+    HKEY key;
+    uint64_t midr_el1;
+    DWORD size = sizeof(midr_el1);
+    const char *path = "Hardware\\Description\\System\\CentralProcessor\\0\\";
+    assert(!RegOpenKeyExA(HKEY_LOCAL_MACHINE, path, 0, KEY_READ, &key));
+    assert(!RegGetValueA(key, NULL, "CP 4000", RRF_RT_REG_QWORD, NULL, &midr_el1, &size));
+    RegCloseKey(key);
+    return midr_el1;
+}
+
+static bool whpx_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
+{
+    const struct isar_regs {
+        WHV_REGISTER_NAME reg;
+        uint64_t *val;
+    } regs[] = {
+        { WHvArm64RegisterIdAa64Pfr0El1, &ahcf->isar.idregs[ID_AA64PFR0_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Pfr1El1, &ahcf->isar.idregs[ID_AA64PFR1_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Dfr0El1, &ahcf->isar.idregs[ID_AA64DFR0_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Dfr1El1 , &ahcf->isar.idregs[ID_AA64DFR1_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Isar0El1, &ahcf->isar.idregs[ID_AA64ISAR0_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Isar1El1, &ahcf->isar.idregs[ID_AA64ISAR1_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Isar2El1, &ahcf->isar.idregs[ID_AA64ISAR2_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Mmfr0El1, &ahcf->isar.idregs[ID_AA64MMFR0_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Mmfr1El1, &ahcf->isar.idregs[ID_AA64MMFR1_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Mmfr2El1, &ahcf->isar.idregs[ID_AA64MMFR2_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Mmfr3El1, &ahcf->isar.idregs[ID_AA64MMFR2_EL1_IDX] }
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
+    ahcf->midr = whpx_read_midr();
+
+    clamp_id_aa64mmfr0_parange_to_ipa_size(&ahcf->isar);
+
+    /*
+     * Disable SVE, which is not supported by QEMU whpx yet.
+     * Work needed for SVE support:
+     * - SVE state save/restore
+     * - any potentially needed VL management
+     * Also disable SME at the same time. (not currently supported by Hyper-V)
+     */
+    SET_IDREG(&ahcf->isar, ID_AA64PFR0,
+              GET_IDREG(&ahcf->isar, ID_AA64PFR0) & ~R_ID_AA64PFR0_SVE_MASK);
+
+    SET_IDREG(&ahcf->isar, ID_AA64PFR1,
+              GET_IDREG(&ahcf->isar, ID_AA64PFR1) & ~R_ID_AA64PFR1_SME_MASK);
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
2.50.1 (Apple Git-155)


