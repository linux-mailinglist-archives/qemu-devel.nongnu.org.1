Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1D5A48E44
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Feb 2025 03:00:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnpfZ-0007by-Gs; Thu, 27 Feb 2025 21:00:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <4c7159ed.AWwAAGWzWYQAAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwRib@a3031119.bnc3.mailjet.com>)
 id 1tnpfW-0007b9-Fq
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 21:00:02 -0500
Received: from o12.p25.mailjet.com ([185.189.236.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <4c7159ed.AWwAAGWzWYQAAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwRib@a3031119.bnc3.mailjet.com>)
 id 1tnpfU-0007PD-1C
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 21:00:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; q=dns/txt;
 d=randomman.co.uk; i=roy.hopkins@randomman.co.uk; s=mailjet; x=1740715195;
 h=message-id:mime-version:from:from:to:to:subject:subject:date:date:list-unsubscribe:list-unsubscribe-post:
 cc:feedback-id:in-reply-to:references:x-csa-complaints:x-mj-mid:x-mj-smtpguid:
 x-report-abuse-to:content-transfer-encoding;
 bh=GXWbG44eui7Mwpp5Xz2SyJS+nkh+OwE/jSi4x/FzpTE=;
 b=QfMlE35Rl0uX3WorDby9N0WHilfSfNpZa2W4H+VEyFV+QX0R7k9D0j19u
 TOimsbzaHxpBFZTOrvg/SP8YOmDvkW3lZDzSASuqs0H8viFwqzyroRFVUMcC
 v4vdtDj+DT5fWa5j7DLg9O6uoIQj2hE49vlog92pPwQMBSS7ic5k1Evk9tYW
 FNKS5gQi68IZu7mo0WBOmeiTRl8RFrV372HMQGzYxst4ESFNVzIdUNUYYpXC
 P474HKf7Ek2KMFNl/y7AXnJ/QqzvRl+1H5KAqlV5EKjVJBy82qANfF76eBF9
 zJqlBnVK/VK9n41pK8xtw1Hm+RGV/uxAsZXScOnY8ZiKQ==
Message-Id: <4c7159ed.AWwAAGWzWYQAAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwRib@mailjet.com>
MIME-Version: 1.0
From: Roy Hopkins <roy.hopkins@randomman.co.uk>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 16/16] sev: Provide sev_features flags from IGVM VMSA to
 KVM_SEV_INIT2
Date: Thu, 27 Feb 2025 14:29:34 +0000
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>, Paolo Bonzini
 <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Alistair Francis
 <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>, Joerg Roedel <jroedel@suse.com>
Feedback-Id: 42.3031119.2785883:MJ
In-Reply-To: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
References: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
X-CSA-Complaints: csa-complaints@eco.de
X-MJ-Mid: AWwAAGWzWYQAAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwRibwQ-T-AXiRTKgcZEht5cGTAAqgls
X-MJ-SMTPGUID: 718a7d47-8b5b-4438-b1dc-96456ee847b9
X-REPORT-ABUSE-TO: Message sent by Mailjet please report to
 abuse@mailjet.com with a copy of the message
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.189.236.12;
 envelope-from=4c7159ed.AWwAAGWzWYQAAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwRib@a3031119.bnc3.mailjet.com;
 helo=o12.p25.mailjet.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

IGVM files can contain an initial VMSA that should be applied to each
vcpu as part of the initial guest state. The sev_features flags are
provided as part of the VMSA structure. However, KVM only allows
sev_features to be set during initialization and not as the guest is
being prepared for launch.

This patch queries KVM for the supported set of sev_features flags and
processes the IGVM file during kvm_init to determine any sev_features
flags set in the IGVM file. These are then provided in the call to
KVM_SEV_INIT2 to ensure the guest state matches that specified in the
IGVM file.

This does cause the IGVM file to be processed twice. Firstly to extract
the sev_features then secondly to actually configure the guest. However,
the first pass is largely ignored meaning the overhead is minimal.

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
---
 target/i386/sev.c | 160 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 141 insertions(+), 19 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index fa9b4bcad6..ef25e64b14 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -117,6 +117,8 @@ struct SevCommonState {
     uint32_t cbitpos;
     uint32_t reduced_phys_bits;
     bool kernel_hashes;
+    uint64_t sev_features;
+    uint64_t supported_sev_features;
 
     /* runtime state */
     uint8_t api_major;
@@ -492,7 +494,40 @@ static void sev_apply_cpu_context(CPUState *cpu)
     }
 }
 
-static int check_vmsa_supported(hwaddr gpa, const struct sev_es_save_area *vmsa,
+static int check_sev_features(SevCommonState *sev_common, uint64_t sev_features,
+                              Error **errp)
+{
+    /*
+     * Ensure SEV_FEATURES is configured for correct SEV hardware and that
+     * the requested features are supported. If SEV-SNP is enabled then
+     * that feature must be enabled, otherwise it must be cleared.
+     */
+    if (sev_snp_enabled() && !(sev_features & SVM_SEV_FEAT_SNP_ACTIVE)) {
+        error_setg(
+            errp,
+            "%s: SEV_SNP is enabled but is not enabled in VMSA sev_features",
+            __func__);
+        return -1;
+    } else if (!sev_snp_enabled() &&
+               (sev_features & SVM_SEV_FEAT_SNP_ACTIVE)) {
+        error_setg(
+            errp,
+            "%s: SEV_SNP is not enabled but is enabled in VMSA sev_features",
+            __func__);
+        return -1;
+    }
+    if (sev_features & ~sev_common->supported_sev_features) {
+        error_setg(errp,
+                   "%s: VMSA contains unsupported sev_features: %lX, "
+                   "supported features: %lX",
+                   __func__, sev_features, sev_common->supported_sev_features);
+        return -1;
+    }
+    return 0;
+}
+
+static int check_vmsa_supported(SevCommonState *sev_common, hwaddr gpa,
+                                const struct sev_es_save_area *vmsa,
                                 Error **errp)
 {
     struct sev_es_save_area vmsa_check;
@@ -558,24 +593,10 @@ static int check_vmsa_supported(hwaddr gpa, const struct sev_es_save_area *vmsa,
     vmsa_check.x87_fcw = 0;
     vmsa_check.mxcsr = 0;
 
-    if (sev_snp_enabled()) {
-        if (vmsa_check.sev_features != SVM_SEV_FEAT_SNP_ACTIVE) {
-            error_setg(errp,
-                       "%s: sev_features in the VMSA contains an unsupported "
-                       "value. For SEV-SNP, sev_features must be set to %x.",
-                       __func__, SVM_SEV_FEAT_SNP_ACTIVE);
-            return -1;
-        }
-        vmsa_check.sev_features = 0;
-    } else {
-        if (vmsa_check.sev_features != 0) {
-            error_setg(errp,
-                       "%s: sev_features in the VMSA contains an unsupported "
-                       "value. For SEV-ES and SEV, sev_features must be "
-                       "set to 0.", __func__);
-            return -1;
-        }
+    if (check_sev_features(sev_common, vmsa_check.sev_features, errp) < 0) {
+        return -1;
     }
+    vmsa_check.sev_features = 0;
 
     if (!buffer_is_zero(&vmsa_check, sizeof(vmsa_check))) {
         error_setg(errp,
@@ -1729,6 +1750,39 @@ static int sev_snp_kvm_type(X86ConfidentialGuest *cg)
     return KVM_X86_SNP_VM;
 }
 
+static int sev_init_supported_features(ConfidentialGuestSupport *cgs,
+                                       SevCommonState *sev_common, Error **errp)
+{
+    X86ConfidentialGuestClass *x86_klass =
+                               X86_CONFIDENTIAL_GUEST_GET_CLASS(cgs);
+    /*
+     * Older kernels do not support query or setting of sev_features. In this
+     * case the set of supported features must be zero to match the settings
+     * in the kernel.
+     */
+    if (x86_klass->kvm_type(X86_CONFIDENTIAL_GUEST(sev_common)) ==
+        KVM_X86_DEFAULT_VM) {
+        sev_common->supported_sev_features = 0;
+        return 0;
+    }
+
+    /* Query KVM for the supported set of sev_features */
+    struct kvm_device_attr attr = {
+        .group = KVM_X86_GRP_SEV,
+        .attr = KVM_X86_SEV_VMSA_FEATURES,
+        .addr = (unsigned long)&sev_common->supported_sev_features,
+    };
+    if (kvm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr) < 0) {
+        error_setg(errp, "%s: failed to query supported sev_features",
+                   __func__);
+        return -1;
+    }
+    if (sev_snp_enabled()) {
+        sev_common->supported_sev_features |= SVM_SEV_FEAT_SNP_ACTIVE;
+    }
+    return 0;
+}
+
 static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     char *devname;
@@ -1809,6 +1863,10 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         }
     }
 
+    if (sev_init_supported_features(cgs, sev_common, errp) < 0) {
+        return -1;
+    }
+
     trace_kvm_sev_init();
     switch (x86_klass->kvm_type(X86_CONFIDENTIAL_GUEST(sev_common))) {
     case KVM_X86_DEFAULT_VM:
@@ -1820,6 +1878,39 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     case KVM_X86_SEV_ES_VM:
     case KVM_X86_SNP_VM: {
         struct kvm_sev_init args = { 0 };
+        MachineState *machine = MACHINE(qdev_get_machine());
+        X86MachineState *x86machine = X86_MACHINE(qdev_get_machine());
+
+        /*
+         * If configuration is provided via an IGVM file then the IGVM file
+         * might contain configuration of the initial vcpu context. For SEV
+         * the vcpu context includes the sev_features which should be applied
+         * to the vcpu.
+         *
+         * KVM does not synchronize sev_features from CPU state. Instead it
+         * requires sev_features to be provided as part of this initialization
+         * call which is subsequently automatically applied to the VMSA of
+         * each vcpu.
+         *
+         * The IGVM file is normally processed after initialization. Therefore
+         * we need to pre-process it here to extract sev_features in order to
+         * provide it to KVM_SEV_INIT2. Each cgs_* function that is called by
+         * the IGVM processor detects this pre-process by observing the state
+         * as SEV_STATE_UNINIT.
+         */
+        if (x86machine->igvm) {
+            if (IGVM_CFG_GET_CLASS(x86machine->igvm)
+                    ->process(x86machine->igvm, machine->cgs, errp) == -1) {
+                return -1;
+            }
+            /*
+             * KVM maintains a bitmask of allowed sev_features. This does not
+             * include SVM_SEV_FEAT_SNP_ACTIVE which is set accordingly by KVM
+             * itself. Therefore we need to clear this flag.
+             */
+            args.vmsa_features = sev_common->sev_features &
+                                 ~SVM_SEV_FEAT_SNP_ACTIVE;
+        }
 
         ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_INIT2, &args, &fw_error);
         break;
@@ -2424,6 +2515,24 @@ static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
     SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
     SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(sev_common);
 
+    if (sev_common->state == SEV_STATE_UNINIT) {
+        /* Pre-processing of IGVM file called from sev_common_kvm_init() */
+        if ((cpu_index == 0) && (memory_type == CGS_PAGE_TYPE_VMSA)) {
+            const struct sev_es_save_area *sa =
+                (const struct sev_es_save_area *)ptr;
+            if (len < sizeof(*sa)) {
+                error_setg(errp, "%s: invalid VMSA length encountered",
+                           __func__);
+                return -1;
+            }
+            if (check_sev_features(sev_common, sa->sev_features, errp) < 0) {
+                return -1;
+            }
+            sev_common->sev_features = sa->sev_features;
+        }
+        return 0;
+    }
+
     if (!sev_enabled()) {
         error_setg(errp, "%s: attempt to configure guest memory, but SEV "
                      "is not enabled", __func__);
@@ -2443,7 +2552,8 @@ static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
                        __func__);
             return -1;
         }
-        if (check_vmsa_supported(gpa, (const struct sev_es_save_area *)ptr,
+        if (check_vmsa_supported(sev_common, gpa,
+                                 (const struct sev_es_save_area *)ptr,
                                  errp) < 0) {
             return -1;
         }
@@ -2500,6 +2610,12 @@ static int cgs_get_mem_map_entry(int index,
     struct e820_entry *table;
     int num_entries;
 
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+    if (sev_common->state == SEV_STATE_UNINIT) {
+        /* Pre-processing of IGVM file called from sev_common_kvm_init() */
+        return 1;
+    }
+
     num_entries = e820_get_table(&table);
     if ((index < 0) || (index >= num_entries)) {
         return 1;
@@ -2531,6 +2647,12 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
                                 uint32_t policy_data1_size, void *policy_data2,
                                 uint32_t policy_data2_size, Error **errp)
 {
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+    if (sev_common->state == SEV_STATE_UNINIT) {
+        /* Pre-processing of IGVM file called from sev_common_kvm_init() */
+        return 0;
+    }
+
     if (policy_type != GUEST_POLICY_SEV) {
         error_setg(errp, "%s: Invalid guest policy type provided for SEV: %d",
         __func__, policy_type);
-- 
2.43.0


