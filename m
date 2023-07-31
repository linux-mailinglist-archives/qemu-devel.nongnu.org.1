Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E00A769CA1
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 18:33:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQVpd-0002fQ-M1; Mon, 31 Jul 2023 12:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQVpS-0002B3-QA
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:33:11 -0400
Received: from [134.134.136.126] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQVpR-0001Iz-4p
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690821185; x=1722357185;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Kl0SGGt7OdcIiPqVNrEI2K05JRMW2feCGQzusuuxZsU=;
 b=OpuveuUNgRq8Qgx7S4a0eV9amt/S2+fgsAZfMMSZSNdVXTjEMBuT+0i7
 CMOQbifU/T+aZshToEMHNvjJ+bzYmxeKBeU9AR/Wjz6WLxwj4Cp/9EQdZ
 CLo1QGkyQqdQu6CU5+BBokcP6aUwCPfhgdT0Edc/m/5r5CYjI2IB8yK+Z
 dHldOd0vdF5FO/3Tb7zKGn0OFH6tjFY6EOztqgEryjaYRTsw+8yfK6ZJ2
 Fsyk6x5K5ykIn/6dvR9EZgBB4cpDfwTTskQlpziAD2TVVUTg7U4D53Uha
 YTUCLwGs0/zJtSvy0gALWVd8l/aeXPPiGrFQeJAeWVy/aB5ELKTfsJ0eH Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="353993483"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="353993483"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 09:25:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="757984213"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="757984213"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by orsmga008.jf.intel.com with ESMTP; 31 Jul 2023 09:25:29 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 xiaoyao.li@intel.com, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: [RFC PATCH 09/19] i386/kvm: Create gmem fd for KVM_X86_SW_PROTECTED_VM
Date: Mon, 31 Jul 2023 12:21:51 -0400
Message-Id: <20230731162201.271114-10-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731162201.271114-1-xiaoyao.li@intel.com>
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 134.134.136.126 (failed)
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=xiaoyao.li@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Register a memory listener for KVM_X86_SW_PROVTED_VM. It creates gmem
for the backend who sets the private property.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 include/exec/memory.h |  1 +
 target/i386/kvm/kvm.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e119d3ce1a1d..ddf0e14970b0 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -814,6 +814,7 @@ struct IOMMUMemoryRegion {
 #define MEMORY_LISTENER_PRIORITY_MIN            0
 #define MEMORY_LISTENER_PRIORITY_ACCEL          10
 #define MEMORY_LISTENER_PRIORITY_DEV_BACKEND    10
+#define MEMORY_LISTENER_PRIORITY_ACCEL_HIGH     20
 
 /**
  * struct MemoryListener: callbacks structure for updates to the physical memory map
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 7971f0fd74b1..df3a5f89396e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -37,6 +37,7 @@
 #include "hyperv-proto.h"
 
 #include "exec/gdbstub.h"
+#include "exec/ramblock.h"
 #include "qemu/host-utils.h"
 #include "qemu/main-loop.h"
 #include "qemu/ratelimit.h"
@@ -2591,8 +2592,41 @@ static void register_smram_listener(Notifier *n, void *unused)
                                  &smram_address_space, 1, "kvm-smram");
 }
 
+static void kvm_x86_sw_protected_vm_region_add(MemoryListener *listenr,
+                                       MemoryRegionSection *section)
+{
+    MemoryRegion *mr = section->mr;
+    Object *owner = memory_region_owner(mr);
+    int fd;
+
+    if (owner && object_dynamic_cast(owner, TYPE_MEMORY_BACKEND) &&
+        object_property_get_bool(owner, "private", NULL) &&
+        mr->ram_block && mr->ram_block->gmem_fd < 0) {
+        struct kvm_create_guest_memfd gmem = {
+            .size = memory_region_size(mr),
+            /* TODO: to decide whether KVM_GUEST_MEMFD_ALLOW_HUGEPAGE is supported */
+            .flags = KVM_GUEST_MEMFD_ALLOW_HUGEPAGE,
+        };
+
+        fd = kvm_vm_ioctl(kvm_state, KVM_CREATE_GUEST_MEMFD, &gmem);
+        if (fd < 0) {
+            error_report("%s: error creating gmem: %s\n", __func__, strerror(-fd));
+            exit(1);
+        }
+        memory_region_set_gmem_fd(mr, fd);
+    }
+}
+
+static MemoryListener kvm_x86_sw_protected_vm_memory_listener = {
+    .name = "kvm_x86_sw_protected_vm_memory_listener",
+    .region_add = kvm_x86_sw_protected_vm_region_add,
+    /* Higher than KVM memory listener = 10. */
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL_HIGH,
+};
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
+    X86MachineState *x86ms = X86_MACHINE(ms);
     uint64_t identity_base = 0xfffbc000;
     uint64_t shadow_mem;
     int ret;
@@ -2617,6 +2651,10 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return ret;
     }
 
+    if (x86ms->vm_type == KVM_X86_SW_PROTECTED_VM) {
+        memory_listener_register(&kvm_x86_sw_protected_vm_memory_listener, &address_space_memory);
+    }
+
     if (!kvm_check_extension(s, KVM_CAP_IRQ_ROUTING)) {
         error_report("kvm: KVM_CAP_IRQ_ROUTING not supported by KVM");
         return -ENOTSUP;
-- 
2.34.1


