Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD38CAF7C6C
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Jul 2025 17:36:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXLy0-0000Cq-CA; Thu, 03 Jul 2025 11:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@randomman.co.uk>)
 id 1uXLxw-0000BR-Ss
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 11:35:13 -0400
Received: from smtp-out-60.livemail.co.uk ([213.171.216.60]
 helo=dkim.livemail.co.uk)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@randomman.co.uk>)
 id 1uXLxr-00043K-Uz
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 11:35:11 -0400
Received: from smtp.livemail.co.uk (unknown [10.44.132.81])
 by dkim.livemail.co.uk (Postfix) with ESMTPS id 6161A401B2;
 Thu,  3 Jul 2025 16:35:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=randomman.co.uk;
 s=livemail2; t=1751556906;
 bh=CRFX4sUp3kM5VlfKLtjC2Nfc99o3yCj2WPpX5WpLfLA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hyTOF82Ys9CWMMHuBSgWXe7F/52KOHRSvlM6bXpW0OcuAUOtMMTu8ZXqx4A3fy/4N
 dsFmI/+9/xXmnKJrIdeyPCiQ6/EVmkcbPUfkTUAB6UIutZVa1CfGeZ2pkhnjbfn+j0
 53o158/gJ7rO+QrYwF+FOd7FtHFnVO4danqJrh/Y=
Received: from localhost.localdomain (unknown [145.40.191.116])
 (Authenticated sender: roy.hopkins@randomman.co.uk)
 by smtp.livemail.co.uk (Postfix) with ESMTPSA id D7E7840171;
 Thu,  3 Jul 2025 16:35:01 +0100 (BST)
From: Roy Hopkins <roy.hopkins@randomman.co.uk>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v9 09/16] i386/sev: Implement ConfidentialGuestSupport
 functions for SEV
Date: Thu,  3 Jul 2025 16:34:41 +0100
Message-ID: <7145835f729e6195f2fbda308aa90e089a96ae6e.1751554099.git.roy.hopkins@randomman.co.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1751554099.git.roy.hopkins@randomman.co.uk>
References: <cover.1751554099.git.roy.hopkins@randomman.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.171.216.60;
 envelope-from=roy.hopkins@randomman.co.uk; helo=dkim.livemail.co.uk
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The ConfidentialGuestSupport object defines a number of virtual
functions that are called during processing of IGVM directives to query
or configure initial guest state. In order to support processing of IGVM
files, these functions need to be implemented by relevant isolation
hardware support code such as SEV.

This commit implements the required functions for SEV-ES and adds
support for processing IGVM files for configuring the guest.

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Gerd Hoffman <kraxel@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/sev.c | 254 ++++++++++++++++++++++++++++++++++++++++++++--
 target/i386/sev.h |   2 +
 2 files changed, 246 insertions(+), 10 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index a13f91e615..1296f4feb6 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -41,7 +41,9 @@
 #include "confidential-guest.h"
 #include "hw/i386/pc.h"
 #include "system/address-spaces.h"
+#include "hw/i386/e820_memory_layout.h"
 #include "qemu/queue.h"
+#include "qemu/cutils.h"
 
 OBJECT_DECLARE_TYPE(SevCommonState, SevCommonStateClass, SEV_COMMON)
 OBJECT_DECLARE_TYPE(SevGuestState, SevCommonStateClass, SEV_GUEST)
@@ -50,6 +52,9 @@ OBJECT_DECLARE_TYPE(SevSnpGuestState, SevCommonStateClass, SEV_SNP_GUEST)
 /* hard code sha256 digest size */
 #define HASH_SIZE 32
 
+/* Hard coded GPA that KVM uses for the VMSA */
+#define KVM_VMSA_GPA 0xFFFFFFFFF000
+
 /* Convert between SEV-ES VMSA and SegmentCache flags/attributes */
 #define FLAGS_VMSA_TO_SEGCACHE(flags) \
     ((((flags) & 0xff00) << 12) | (((flags) & 0xff) << 8))
@@ -480,6 +485,103 @@ static void sev_apply_cpu_context(CPUState *cpu)
     }
 }
 
+static int check_vmsa_supported(hwaddr gpa, const struct sev_es_save_area *vmsa,
+                                Error **errp)
+{
+    struct sev_es_save_area vmsa_check;
+
+    /*
+     * KVM always populates the VMSA at a fixed GPA which cannot be modified
+     * from userspace. Specifying a different GPA will not prevent the guest
+     * from starting but will cause the launch measurement to be different
+     * from expected. Therefore check that the provided GPA matches the KVM
+     * hardcoded value.
+     */
+    if (gpa != KVM_VMSA_GPA) {
+        error_setg(errp,
+                "%s: The VMSA GPA must be %lX but is specified as %lX",
+                __func__, KVM_VMSA_GPA, gpa);
+        return -1;
+    }
+
+    /*
+     * Clear all supported fields so we can then check the entire structure
+     * is zero.
+     */
+    memcpy(&vmsa_check, vmsa, sizeof(struct sev_es_save_area));
+    memset(&vmsa_check.es, 0, sizeof(vmsa_check.es));
+    memset(&vmsa_check.cs, 0, sizeof(vmsa_check.cs));
+    memset(&vmsa_check.ss, 0, sizeof(vmsa_check.ss));
+    memset(&vmsa_check.ds, 0, sizeof(vmsa_check.ds));
+    memset(&vmsa_check.fs, 0, sizeof(vmsa_check.fs));
+    memset(&vmsa_check.gs, 0, sizeof(vmsa_check.gs));
+    memset(&vmsa_check.gdtr, 0, sizeof(vmsa_check.gdtr));
+    memset(&vmsa_check.idtr, 0, sizeof(vmsa_check.idtr));
+    memset(&vmsa_check.ldtr, 0, sizeof(vmsa_check.ldtr));
+    memset(&vmsa_check.tr, 0, sizeof(vmsa_check.tr));
+    vmsa_check.efer = 0;
+    vmsa_check.cr0 = 0;
+    vmsa_check.cr3 = 0;
+    vmsa_check.cr4 = 0;
+    vmsa_check.xcr0 = 0;
+    vmsa_check.dr6 = 0;
+    vmsa_check.dr7 = 0;
+    vmsa_check.rax = 0;
+    vmsa_check.rcx = 0;
+    vmsa_check.rdx = 0;
+    vmsa_check.rbx = 0;
+    vmsa_check.rsp = 0;
+    vmsa_check.rbp = 0;
+    vmsa_check.rsi = 0;
+    vmsa_check.rdi = 0;
+    vmsa_check.r8 = 0;
+    vmsa_check.r9 = 0;
+    vmsa_check.r10 = 0;
+    vmsa_check.r11 = 0;
+    vmsa_check.r12 = 0;
+    vmsa_check.r13 = 0;
+    vmsa_check.r14 = 0;
+    vmsa_check.r15 = 0;
+    vmsa_check.rip = 0;
+    vmsa_check.rflags = 0;
+
+    vmsa_check.g_pat = 0;
+    vmsa_check.xcr0 = 0;
+
+    vmsa_check.x87_fcw = 0;
+    vmsa_check.mxcsr = 0;
+
+    if (sev_snp_enabled()) {
+        if (vmsa_check.sev_features != SVM_SEV_FEAT_SNP_ACTIVE) {
+            error_setg(errp,
+                       "%s: sev_features in the VMSA contains an unsupported "
+                       "value. For SEV-SNP, sev_features must be set to %x.",
+                       __func__, SVM_SEV_FEAT_SNP_ACTIVE);
+            return -1;
+        }
+        vmsa_check.sev_features = 0;
+    } else {
+        if (vmsa_check.sev_features != 0) {
+            error_setg(errp,
+                       "%s: sev_features in the VMSA contains an unsupported "
+                       "value. For SEV-ES and SEV, sev_features must be "
+                       "set to 0.", __func__);
+            return -1;
+        }
+    }
+
+    if (!buffer_is_zero(&vmsa_check, sizeof(vmsa_check))) {
+        error_setg(errp,
+                "%s: The VMSA contains fields that are not "
+                "synchronized with KVM. Continuing would result in "
+                "either unpredictable guest behavior, or a "
+                "mismatched launch measurement.",
+                __func__);
+        return -1;
+    }
+    return 0;
+}
+
 static int sev_set_cpu_context(uint16_t cpu_index, const void *ctx,
                                uint32_t ctx_len, hwaddr gpa, Error **errp)
 {
@@ -1491,18 +1593,26 @@ sev_snp_launch_finish(SevCommonState *sev_common)
     struct kvm_sev_snp_launch_finish *finish = &sev_snp->kvm_finish_conf;
 
     /*
-     * To boot the SNP guest, the hypervisor is required to populate the CPUID
-     * and Secrets page before finalizing the launch flow. The location of
-     * the secrets and CPUID page is available through the OVMF metadata GUID.
+     * Populate all the metadata pages if not using an IGVM file. In the case
+     * where an IGVM file is provided it will be used to configure the metadata
+     * pages directly.
      */
-    metadata = pc_system_get_ovmf_sev_metadata_ptr();
-    if (metadata == NULL) {
-        error_report("%s: Failed to locate SEV metadata header", __func__);
-        exit(1);
-    }
+    if (!X86_MACHINE(qdev_get_machine())->igvm) {
+        /*
+         * To boot the SNP guest, the hypervisor is required to populate the
+         * CPUID and Secrets page before finalizing the launch flow. The
+         * location of the secrets and CPUID page is available through the
+         * OVMF metadata GUID.
+         */
+        metadata = pc_system_get_ovmf_sev_metadata_ptr();
+        if (metadata == NULL) {
+            error_report("%s: Failed to locate SEV metadata header", __func__);
+            exit(1);
+        }
 
-    /* Populate all the metadata pages */
-    snp_populate_metadata_pages(sev_snp, metadata);
+        /* Populate all the metadata pages */
+        snp_populate_metadata_pages(sev_snp, metadata);
+    }
 
     QTAILQ_FOREACH(data, &launch_update, next) {
         ret = sev_snp_launch_update(sev_snp, data);
@@ -2290,6 +2400,124 @@ static void sev_common_set_kernel_hashes(Object *obj, bool value, Error **errp)
     SEV_COMMON(obj)->kernel_hashes = value;
 }
 
+static bool cgs_check_support(ConfidentialGuestPlatformType platform,
+                             uint16_t platform_version, uint8_t highest_vtl,
+                             uint64_t shared_gpa_boundary)
+{
+    return (((platform == CGS_PLATFORM_SEV_SNP) && sev_snp_enabled()) ||
+            ((platform == CGS_PLATFORM_SEV_ES) && sev_es_enabled()) ||
+            ((platform == CGS_PLATFORM_SEV) && sev_enabled()));
+}
+
+static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
+                               ConfidentialGuestPageType memory_type,
+                               uint16_t cpu_index, Error **errp)
+{
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+    SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(sev_common);
+
+    if (!sev_enabled()) {
+        error_setg(errp, "%s: attempt to configure guest memory, but SEV "
+                     "is not enabled", __func__);
+        return -1;
+    }
+
+    switch (memory_type) {
+    case CGS_PAGE_TYPE_NORMAL:
+    case CGS_PAGE_TYPE_ZERO:
+        return klass->launch_update_data(sev_common, gpa, ptr, len, errp);
+
+    case CGS_PAGE_TYPE_VMSA:
+        if (!sev_es_enabled()) {
+            error_setg(errp,
+                       "%s: attempt to configure initial VMSA, but SEV-ES "
+                       "is not supported",
+                       __func__);
+            return -1;
+        }
+        if (check_vmsa_supported(gpa, (const struct sev_es_save_area *)ptr,
+                                 errp) < 0) {
+            return -1;
+        }
+        return sev_set_cpu_context(cpu_index, ptr, len, gpa, errp);
+
+    case CGS_PAGE_TYPE_UNMEASURED:
+        if (sev_snp_enabled()) {
+            return snp_launch_update_data(
+                gpa, ptr, len, KVM_SEV_SNP_PAGE_TYPE_UNMEASURED, errp);
+        }
+        /* No action required if not SEV-SNP */
+        return 0;
+
+    case CGS_PAGE_TYPE_SECRETS:
+        if (!sev_snp_enabled()) {
+            error_setg(errp,
+                       "%s: attempt to configure secrets page, but SEV-SNP "
+                       "is not supported",
+                       __func__);
+            return -1;
+        }
+        return snp_launch_update_data(gpa, ptr, len,
+                                      KVM_SEV_SNP_PAGE_TYPE_SECRETS, errp);
+
+    case CGS_PAGE_TYPE_REQUIRED_MEMORY:
+        if (kvm_convert_memory(gpa, len, true) < 0) {
+            error_setg(
+                errp,
+                "%s: failed to configure required memory. gpa: %lX, type: %d",
+                __func__, gpa, memory_type);
+            return -1;
+        }
+        return 0;
+
+    case CGS_PAGE_TYPE_CPUID:
+        if (!sev_snp_enabled()) {
+            error_setg(errp,
+                       "%s: attempt to configure CPUID page, but SEV-SNP "
+                       "is not supported",
+                       __func__);
+            return -1;
+        }
+        return snp_launch_update_cpuid(gpa, ptr, len, errp);
+    }
+    error_setg(errp, "%s: failed to update guest. gpa: %lX, type: %d", __func__,
+               gpa, memory_type);
+    return -1;
+}
+
+static int cgs_get_mem_map_entry(int index,
+                                 ConfidentialGuestMemoryMapEntry *entry,
+                                 Error **errp)
+{
+    struct e820_entry *table;
+    int num_entries;
+
+    num_entries = e820_get_table(&table);
+    if ((index < 0) || (index >= num_entries)) {
+        return 1;
+    }
+    entry->gpa = table[index].address;
+    entry->size = table[index].length;
+    switch (table[index].type) {
+    case E820_RAM:
+        entry->type = CGS_MEM_RAM;
+        break;
+    case E820_RESERVED:
+        entry->type = CGS_MEM_RESERVED;
+        break;
+    case E820_ACPI:
+        entry->type = CGS_MEM_ACPI;
+        break;
+    case E820_NVS:
+        entry->type = CGS_MEM_NVS;
+        break;
+    case E820_UNUSABLE:
+        entry->type = CGS_MEM_UNUSABLE;
+        break;
+    }
+    return 0;
+}
+
 static void
 sev_common_class_init(ObjectClass *oc, const void *data)
 {
@@ -2313,6 +2541,8 @@ static void
 sev_common_instance_init(Object *obj)
 {
     SevCommonState *sev_common = SEV_COMMON(obj);
+    ConfidentialGuestSupportClass *cgs =
+        CONFIDENTIAL_GUEST_SUPPORT_GET_CLASS(obj);
 
     sev_common->kvm_type = -1;
 
@@ -2323,6 +2553,10 @@ sev_common_instance_init(Object *obj)
     object_property_add_uint32_ptr(obj, "reduced-phys-bits",
                                    &sev_common->reduced_phys_bits,
                                    OBJ_PROP_FLAG_READWRITE);
+    cgs->check_support = cgs_check_support;
+    cgs->set_guest_state = cgs_set_guest_state;
+    cgs->get_mem_map_entry = cgs_get_mem_map_entry;
+
     QTAILQ_INIT(&sev_common->launch_vmsa);
 }
 
diff --git a/target/i386/sev.h b/target/i386/sev.h
index 38caa849f5..d2eb06db32 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -44,6 +44,8 @@ bool sev_snp_enabled(void);
 #define SEV_SNP_POLICY_SMT      0x10000
 #define SEV_SNP_POLICY_DBG      0x80000
 
+#define SVM_SEV_FEAT_SNP_ACTIVE 1
+
 typedef struct SevKernelLoaderContext {
     char *setup_data;
     size_t setup_size;
-- 
2.43.0


