Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C530F780D9E
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 16:12:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX05p-0004zi-94; Fri, 18 Aug 2023 10:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwGc-0004rU-Tt
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:59:43 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwG0-0000JL-Bm
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692352744; x=1723888744;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sEFAuOuYkkaJXCVD/heveV87x0pz7TRKfZ4JVIhhcVs=;
 b=MX8Dt4CmkPv/ShXDcGI4+1btZPP5xajaEANEIBr8IXURFHkl+isOfTSE
 x++Y0ZeqYp2FWQKO6O1lmuC4SOxZlEM9p2pKGTjIxzCMFphjAmWD9lvWK
 N9eGwPDpVswlCWB38wiXj3tG7i/yj3IhZyDy5MqMfF9IWElCscd+Ph6oS
 o9H8WjxYJ5tIvPmhQGw2erXhCJla2tWBtoKjcGSfhgAE/d6/IPJTl9p/V
 +DiZmuL59yiBQLqR/7AEbJcOP1mssTMGdI0TBljVCxwfYogxXXLY9lNWd
 4FtxN2927tmft6L7cF28cxKnKFQilx43dlm8bGoxTDS88g6pBVuQNaHg4 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="371966624"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="371966624"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2023 02:57:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="849235454"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="849235454"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by fmsmga002.fm.intel.com with ESMTP; 18 Aug 2023 02:57:50 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Laszlo Ersek <lersek@redhat.com>,
 xiaoyao.li@intel.com, Isaku Yamahata <isaku.yamahata@gmail.com>,
 erdemaktas@google.com, Chenyi Qiang <chenyi.qiang@intel.com>
Subject: [PATCH v2 40/58] i386/tdx: handle
 TDG.VP.VMCALL<SetupEventNotifyInterrupt>
Date: Fri, 18 Aug 2023 05:50:23 -0400
Message-Id: <20230818095041.1973309-41-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818095041.1973309-1-xiaoyao.li@intel.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

For SetupEventNotifyInterrupt, record interrupt vector and the apic id
of the vcpu that received this TDVMCALL.

Later it can inject interrupt with given vector to the specific vcpu
that received SetupEventNotifyInterrupt.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/kvm.c      |  9 ++++++
 target/i386/kvm/tdx-stub.c |  4 +++
 target/i386/kvm/tdx.c      | 61 ++++++++++++++++++++++++++++++++++++++
 target/i386/kvm/tdx.h      |  6 ++++
 4 files changed, 80 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 4a146bc42f63..601683d836c8 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5657,6 +5657,15 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
         ret = kvm_xen_handle_exit(cpu, &run->xen);
         break;
 #endif
+    case KVM_EXIT_TDX:
+        if (!is_tdx_vm()) {
+            error_report("KVM: get KVM_EXIT_TDX for a non-TDX VM.");
+            ret = -1;
+            break;
+        }
+        tdx_handle_exit(cpu, &run->tdx);
+        ret = 0;
+        break;
     default:
         fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reason);
         ret = -1;
diff --git a/target/i386/kvm/tdx-stub.c b/target/i386/kvm/tdx-stub.c
index 3cd114476d78..e26e2111f606 100644
--- a/target/i386/kvm/tdx-stub.c
+++ b/target/i386/kvm/tdx-stub.c
@@ -16,3 +16,7 @@ int tdx_parse_tdvf(void *flash_ptr, int size)
 {
     return -EINVAL;
 }
+
+void tdx_handle_exit(X86CPU *cpu, struct kvm_tdx_exit *tdx_exit)
+{
+}
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 5eabdafbe95c..1b444886e294 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -894,6 +894,9 @@ static void tdx_guest_init(Object *obj)
                                OBJ_PROP_FLAG_READWRITE);
     object_property_add_sha384(obj, "mrownerconfig", tdx->mrownerconfig,
                                OBJ_PROP_FLAG_READWRITE);
+
+    tdx->event_notify_interrupt = -1;
+    tdx->event_notify_apic_id = -1;
 }
 
 static void tdx_guest_finalize(Object *obj)
@@ -903,3 +906,61 @@ static void tdx_guest_finalize(Object *obj)
 static void tdx_guest_class_init(ObjectClass *oc, void *data)
 {
 }
+
+#define TDG_VP_VMCALL_SETUP_EVENT_NOTIFY_INTERRUPT      0x10004ULL
+
+#define TDG_VP_VMCALL_SUCCESS           0x0000000000000000ULL
+#define TDG_VP_VMCALL_RETRY             0x0000000000000001ULL
+#define TDG_VP_VMCALL_INVALID_OPERAND   0x8000000000000000ULL
+#define TDG_VP_VMCALL_GPA_INUSE         0x8000000000000001ULL
+#define TDG_VP_VMCALL_ALIGN_ERROR       0x8000000000000002ULL
+
+static void tdx_handle_setup_event_notify_interrupt(X86CPU *cpu,
+                                                    struct kvm_tdx_vmcall *vmcall)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    TdxGuest *tdx = TDX_GUEST(ms->cgs);
+    int event_notify_interrupt = vmcall->in_r12;
+
+    if (32 <= event_notify_interrupt && event_notify_interrupt <= 255) {
+        qemu_mutex_lock(&tdx->lock);
+        tdx->event_notify_interrupt = event_notify_interrupt;
+        tdx->event_notify_apic_id = cpu->apic_id;
+        qemu_mutex_unlock(&tdx->lock);
+        vmcall->status_code = TDG_VP_VMCALL_SUCCESS;
+    }
+}
+
+static void tdx_handle_vmcall(X86CPU *cpu, struct kvm_tdx_vmcall *vmcall)
+{
+    vmcall->status_code = TDG_VP_VMCALL_INVALID_OPERAND;
+
+    /* For now handle only TDG.VP.VMCALL. */
+    if (vmcall->type != 0) {
+        warn_report("unknown tdg.vp.vmcall type 0x%llx subfunction 0x%llx",
+                    vmcall->type, vmcall->subfunction);
+        return;
+    }
+
+    switch (vmcall->subfunction) {
+    case TDG_VP_VMCALL_SETUP_EVENT_NOTIFY_INTERRUPT:
+        tdx_handle_setup_event_notify_interrupt(cpu, vmcall);
+        break;
+    default:
+        warn_report("unknown tdg.vp.vmcall type 0x%llx subfunction 0x%llx",
+                    vmcall->type, vmcall->subfunction);
+        break;
+    }
+}
+
+void tdx_handle_exit(X86CPU *cpu, struct kvm_tdx_exit *tdx_exit)
+{
+    switch (tdx_exit->type) {
+    case KVM_EXIT_TDX_VMCALL:
+        tdx_handle_vmcall(cpu, &tdx_exit->u.vmcall);
+        break;
+    default:
+        warn_report("unknown tdx exit type 0x%x", tdx_exit->type);
+        break;
+    }
+}
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index 1c444b6cdb3f..50a151fc79c2 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -7,6 +7,7 @@
 
 #include "exec/confidential-guest-support.h"
 #include "hw/i386/tdvf.h"
+#include "sysemu/kvm.h"
 
 #define TYPE_TDX_GUEST "tdx-guest"
 #define TDX_GUEST(obj)  OBJECT_CHECK(TdxGuest, (obj), TYPE_TDX_GUEST)
@@ -42,6 +43,10 @@ typedef struct TdxGuest {
 
     uint32_t nr_ram_entries;
     TdxRamEntry *ram_entries;
+
+    /* runtime state */
+    int event_notify_interrupt;
+    uint32_t event_notify_apic_id;
 } TdxGuest;
 
 #ifdef CONFIG_TDX
@@ -56,5 +61,6 @@ void tdx_get_supported_cpuid(uint32_t function, uint32_t index, int reg,
 int tdx_pre_create_vcpu(CPUState *cpu);
 void tdx_set_tdvf_region(MemoryRegion *tdvf_region);
 int tdx_parse_tdvf(void *flash_ptr, int size);
+void tdx_handle_exit(X86CPU *cpu, struct kvm_tdx_exit *tdx_exit);
 
 #endif /* QEMU_I386_TDX_H */
-- 
2.34.1


