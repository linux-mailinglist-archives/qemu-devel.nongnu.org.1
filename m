Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6DC7EBE05
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 08:25:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3AEn-0007YG-J7; Wed, 15 Nov 2023 02:23:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3AED-0007Hu-Ff
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:22:25 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3AEB-0005ES-J4
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700032943; x=1731568943;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LuQYoY64ikGaeBp35SW30lDHCFZIEayqxFnoiF4T540=;
 b=fteRLHKutUqaidMyx6fjaLdsT4EKX3ztUqiQQ+NQJ00lMe6rVvMV1T48
 pd4EL14RTAZEqibNJm1j+Sz505kDiKI8UjkYkcXTX/fmd68hKFPMs1+mG
 slojdizrweoL8Wy3qY8ByqVn6gremiveDvFfLvPsqNKQDYpdHnywHlEab
 2LJdTdvR41pOY+AVIvsVcmY32kz60b49iHMyvx2AFfy+y+dM0bRokjmq+
 TE2qWRcBYWKzSxqW3VeoFS8JRD1653JkZhg3tnMM5PbCx3NBDwvV15Lgi
 A8R6jg/4gbR8cB6ecIkFWmdvmMy/0rwi8iVIyDO8VAWOdAYWTbvzEs0Fc Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390623418"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="390623418"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 23:22:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="714800208"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="714800208"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orsmga003.jf.intel.com with ESMTP; 14 Nov 2023 23:22:16 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, xiaoyao.li@intel.com,
 Michael Roth <michael.roth@amd.com>,
 Sean Christopherson <seanjc@google.com>,
 Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: [PATCH v3 51/70] i386/tdx: handle
 TDG.VP.VMCALL<SetupEventNotifyInterrupt>
Date: Wed, 15 Nov 2023 02:15:00 -0500
Message-Id: <20231115071519.2864957-52-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115071519.2864957-1-xiaoyao.li@intel.com>
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.115; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 target/i386/kvm/tdx-stub.c |  5 ++++
 target/i386/kvm/tdx.c      | 61 ++++++++++++++++++++++++++++++++++++++
 target/i386/kvm/tdx.h      |  6 ++++
 4 files changed, 81 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index d09d9f4eee94..f1c4dd759b3e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5414,6 +5414,15 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
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
index 587dbeeed196..14c11a2338fc 100644
--- a/target/i386/kvm/tdx-stub.c
+++ b/target/i386/kvm/tdx-stub.c
@@ -16,3 +16,8 @@ int tdx_parse_tdvf(void *flash_ptr, int size)
 {
     return -EINVAL;
 }
+
+void tdx_handle_exit(X86CPU *cpu, struct kvm_tdx_exit *tdx_exit)
+{
+    abort();
+}
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index fc71038d7808..5fc5d857fb6f 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -956,6 +956,9 @@ static void tdx_guest_init(Object *obj)
     object_property_add_str(obj, "mrownerconfig",
                             tdx_guest_get_mrownerconfig,
                             tdx_guest_set_mrownerconfig);
+
+    tdx->event_notify_interrupt = -1;
+    tdx->event_notify_apic_id = -1;
 }
 
 static void tdx_guest_finalize(Object *obj)
@@ -965,3 +968,61 @@ static void tdx_guest_finalize(Object *obj)
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
index 5fb20a5f06bb..4a8d67cc9fdb 100644
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
 int tdx_pre_create_vcpu(CPUState *cpu, Error **errp);
 void tdx_set_tdvf_region(MemoryRegion *tdvf_region);
 int tdx_parse_tdvf(void *flash_ptr, int size);
+void tdx_handle_exit(X86CPU *cpu, struct kvm_tdx_exit *tdx_exit);
 
 #endif /* QEMU_I386_TDX_H */
-- 
2.34.1


