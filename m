Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D52A77CC7
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Apr 2025 15:52:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbsN-0005JG-TK; Tue, 01 Apr 2025 09:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbsF-0005EX-QO
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:41:53 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbsC-0006ZP-5f
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743514908; x=1775050908;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EKsK8PWjYl3QvrFgMx0oUHC9LNiAUtXBkauBMePChbY=;
 b=lEc4OUuto1NUmq/RI4SKGrtOpF4xSAhcW6Ndo5nBJdSIHZEajooVmQPF
 A69bGbm4b4P3+EXUC01fmvHppC7UTplsDNd7p0W3KjK3iLHpOrPaj50HN
 ulzGdAew/4y1MXYjZAhC2hbhP9tms9UuKTpq7k/e9j7kRfZYko0ngCcm+
 oYo06n6Ip+ie90pVVKHSE2/1GvVYV9fDuCQoWjnFE5weAA+juoRF+pg0S
 pHHmniIYhIN0MjXcRMaC+Nkq2qjG5/zHAWVwAVvqL4/CF8JyMeQp5DNIo
 1TKRpi60T9/dZa3lGgizoevjIp5H4EJItNEbdlYj1qkpxrAjgTU7kawgs g==;
X-CSE-ConnectionGUID: UOTnBfdhQEOgBelqMe9jOw==
X-CSE-MsgGUID: gR8QM8UoSgKiN+dP5ETntA==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="32433201"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="32433201"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 06:41:34 -0700
X-CSE-ConnectionGUID: nj9SsVT1TNaIO1U0n+CIDA==
X-CSE-MsgGUID: edftOmDeRruST44kgJ4n5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="126639935"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 01 Apr 2025 06:41:28 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v8 08/55] i386/tdx: Initialize TDX before creating TD vcpus
Date: Tue,  1 Apr 2025 09:01:18 -0400
Message-Id: <20250401130205.2198253-9-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250401130205.2198253-1-xiaoyao.li@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

Invoke KVM_TDX_INIT_VM in kvm_arch_pre_create_vcpu() that
KVM_TDX_INIT_VM configures global TD configurations, e.g. the canonical
CPUID config, and must be executed prior to creating vCPUs.

Use kvm_x86_arch_cpuid() to setup the CPUID settings for TDX VM.

Note, this doesn't address the fact that QEMU may change the CPUID
configuration when creating vCPUs, i.e. punts on refactoring QEMU to
provide a stable CPUID config prior to kvm_arch_init().

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
Changes in v8:
- Drop the code that initializes cpu->kvm_state before
  kvm_arch_pre_create_vcpu() because it's not needed anymore.

Changes in v7:
- Add comments to explain why KVM_TDX_INIT_VM should retry on -EAGAIN;
- Add retry limit of 10000 times for -EAGAIN on KVM_TDX_INIT_VM;

Changes in v6:
- setup xfam explicitly to fit with new uapi;
- use tdx_caps->cpuid to filter the input of cpuids because now KVM only
  allows the leafs that reported via KVM_TDX_GET_CAPABILITIES;

Changes in v4:
- mark init_vm with g_autofree() and use QEMU_LOCK_GUARD() to eliminate
  the goto labels; (Daniel)
Changes in v3:
- Pass @errp in tdx_pre_create_vcpu() and pass error info to it. (Daniel)
---
 target/i386/kvm/kvm.c       |  16 +++---
 target/i386/kvm/kvm_i386.h  |   5 ++
 target/i386/kvm/meson.build |   2 +-
 target/i386/kvm/tdx-stub.c  |  10 ++++
 target/i386/kvm/tdx.c       | 105 ++++++++++++++++++++++++++++++++++++
 target/i386/kvm/tdx.h       |   6 +++
 6 files changed, 137 insertions(+), 7 deletions(-)
 create mode 100644 target/i386/kvm/tdx-stub.c

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 1a4dd19e24ab..a537699bb7df 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -38,6 +38,7 @@
 #include "kvm_i386.h"
 #include "../confidential-guest.h"
 #include "sev.h"
+#include "tdx.h"
 #include "xen-emu.h"
 #include "hyperv.h"
 #include "hyperv-proto.h"
@@ -414,9 +415,9 @@ static uint32_t cpuid_entry_get_reg(struct kvm_cpuid_entry2 *entry, int reg)
 
 /* Find matching entry for function/index on kvm_cpuid2 struct
  */
-static struct kvm_cpuid_entry2 *cpuid_find_entry(struct kvm_cpuid2 *cpuid,
-                                                 uint32_t function,
-                                                 uint32_t index)
+struct kvm_cpuid_entry2 *cpuid_find_entry(struct kvm_cpuid2 *cpuid,
+                                          uint32_t function,
+                                          uint32_t index)
 {
     int i;
     for (i = 0; i < cpuid->nent; ++i) {
@@ -1821,9 +1822,8 @@ static void kvm_init_nested_state(CPUX86State *env)
     }
 }
 
-static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
-                                    struct kvm_cpuid_entry2 *entries,
-                                    uint32_t cpuid_i)
+uint32_t kvm_x86_build_cpuid(CPUX86State *env, struct kvm_cpuid_entry2 *entries,
+                             uint32_t cpuid_i)
 {
     uint32_t limit, i, j;
     uint32_t unused;
@@ -2052,6 +2052,10 @@ full:
 
 int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
 {
+    if (is_tdx_vm()) {
+        return tdx_pre_create_vcpu(cpu, errp);
+    }
+
     return 0;
 }
 
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index ed1e61fb8ba9..dc696cb7238a 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -59,6 +59,11 @@ uint64_t kvm_swizzle_msi_ext_dest_id(uint64_t address);
 void kvm_update_msi_routes_all(void *private, bool global,
                                uint32_t index, uint32_t mask);
 
+struct kvm_cpuid_entry2 *cpuid_find_entry(struct kvm_cpuid2 *cpuid,
+                                          uint32_t function,
+                                          uint32_t index);
+uint32_t kvm_x86_build_cpuid(CPUX86State *env, struct kvm_cpuid_entry2 *entries,
+                             uint32_t cpuid_i);
 #endif /* CONFIG_KVM */
 
 void kvm_pc_setup_irq_routing(bool pci_enabled);
diff --git a/target/i386/kvm/meson.build b/target/i386/kvm/meson.build
index 466bccb9cb17..3f44cdedb758 100644
--- a/target/i386/kvm/meson.build
+++ b/target/i386/kvm/meson.build
@@ -8,7 +8,7 @@ i386_kvm_ss.add(files(
 
 i386_kvm_ss.add(when: 'CONFIG_XEN_EMU', if_true: files('xen-emu.c'))
 
-i386_kvm_ss.add(when: 'CONFIG_TDX', if_true: files('tdx.c'))
+i386_kvm_ss.add(when: 'CONFIG_TDX', if_true: files('tdx.c'), if_false: files('tdx-stub.c'))
 
 i386_system_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'), if_false: files('hyperv-stub.c'))
 
diff --git a/target/i386/kvm/tdx-stub.c b/target/i386/kvm/tdx-stub.c
new file mode 100644
index 000000000000..2344433594ea
--- /dev/null
+++ b/target/i386/kvm/tdx-stub.c
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+
+#include "tdx.h"
+
+int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
+    return -EINVAL;
+}
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 16f67e18ae78..0afaf739c09f 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -149,6 +149,109 @@ static int tdx_kvm_type(X86ConfidentialGuest *cg)
     return KVM_X86_TDX_VM;
 }
 
+static int setup_td_xfam(X86CPU *x86cpu, Error **errp)
+{
+    CPUX86State *env = &x86cpu->env;
+    uint64_t xfam;
+
+    xfam = env->features[FEAT_XSAVE_XCR0_LO] |
+           env->features[FEAT_XSAVE_XCR0_HI] |
+           env->features[FEAT_XSAVE_XSS_LO] |
+           env->features[FEAT_XSAVE_XSS_HI];
+
+    if (xfam & ~tdx_caps->supported_xfam) {
+        error_setg(errp, "Invalid XFAM 0x%lx for TDX VM (supported: 0x%llx))",
+                   xfam, tdx_caps->supported_xfam);
+        return -1;
+    }
+
+    tdx_guest->xfam = xfam;
+    return 0;
+}
+
+static void tdx_filter_cpuid(struct kvm_cpuid2 *cpuids)
+{
+    int i, dest_cnt = 0;
+    struct kvm_cpuid_entry2 *src, *dest, *conf;
+
+    for (i = 0; i < cpuids->nent; i++) {
+        src = cpuids->entries + i;
+        conf = cpuid_find_entry(&tdx_caps->cpuid, src->function, src->index);
+        if (!conf) {
+            continue;
+        }
+        dest = cpuids->entries + dest_cnt;
+
+        dest->function = src->function;
+        dest->index = src->index;
+        dest->flags = src->flags;
+        dest->eax = src->eax & conf->eax;
+        dest->ebx = src->ebx & conf->ebx;
+        dest->ecx = src->ecx & conf->ecx;
+        dest->edx = src->edx & conf->edx;
+
+        dest_cnt++;
+    }
+    cpuids->nent = dest_cnt++;
+}
+
+int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    g_autofree struct kvm_tdx_init_vm *init_vm = NULL;
+    Error *local_err = NULL;
+    int retry = 10000;
+    int r = 0;
+
+    QEMU_LOCK_GUARD(&tdx_guest->lock);
+    if (tdx_guest->initialized) {
+        return r;
+    }
+
+    init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
+                        sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
+
+    r = setup_td_xfam(x86cpu, errp);
+    if (r) {
+        return r;
+    }
+
+    init_vm->cpuid.nent = kvm_x86_build_cpuid(env, init_vm->cpuid.entries, 0);
+    tdx_filter_cpuid(&init_vm->cpuid);
+
+    init_vm->attributes = tdx_guest->attributes;
+    init_vm->xfam = tdx_guest->xfam;
+
+    /*
+     * KVM_TDX_INIT_VM gets -EAGAIN when KVM side SEAMCALL(TDH_MNG_CREATE)
+     * gets TDX_RND_NO_ENTROPY due to Random number generation (e.g., RDRAND or
+     * RDSEED) is busy.
+     *
+     * Retry for the case.
+     */
+    do {
+        error_free(local_err);
+        local_err = NULL;
+        r = tdx_vm_ioctl(KVM_TDX_INIT_VM, 0, init_vm, &local_err);
+    } while (r == -EAGAIN && --retry);
+
+    if (r < 0) {
+        if (!retry) {
+            error_report("Hardware RNG (Random Number Generator) is busy "
+                         "occupied by someone (via RDRAND/RDSEED) maliciously, "
+                         "which leads to KVM_TDX_INIT_VM keeping failure "
+                         "due to lack of entropy.");
+        }
+        error_propagate(errp, local_err);
+        return r;
+    }
+
+    tdx_guest->initialized = true;
+
+    return 0;
+}
+
 /* tdx guest */
 OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
                                    tdx_guest,
@@ -162,6 +265,8 @@ static void tdx_guest_init(Object *obj)
     ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
     TdxGuest *tdx = TDX_GUEST(obj);
 
+    qemu_mutex_init(&tdx->lock);
+
     cgs->require_guest_memfd = true;
     tdx->attributes = 0;
 
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index de8ae9196163..4e2b5c61ff5b 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -19,7 +19,11 @@ typedef struct TdxGuestClass {
 typedef struct TdxGuest {
     X86ConfidentialGuest parent_obj;
 
+    QemuMutex lock;
+
+    bool initialized;
     uint64_t attributes;    /* TD attributes */
+    uint64_t xfam;
 } TdxGuest;
 
 #ifdef CONFIG_TDX
@@ -28,4 +32,6 @@ bool is_tdx_vm(void);
 #define is_tdx_vm() 0
 #endif /* CONFIG_TDX */
 
+int tdx_pre_create_vcpu(CPUState *cpu, Error **errp);
+
 #endif /* QEMU_I386_TDX_H */
-- 
2.34.1


