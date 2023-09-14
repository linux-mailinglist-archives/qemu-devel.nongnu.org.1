Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0341579F92D
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 05:53:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgdP1-0007FM-8R; Wed, 13 Sep 2023 23:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qgdOz-0007Dl-Bo
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 23:52:25 -0400
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qgdOx-0000r7-Kp
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 23:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694663543; x=1726199543;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eKloPCcRi+HIRDzS+h7jCyuEt7bYm6PhIvGdqysJsx8=;
 b=CODPZ7y83/toBuJ3Pa9/G2/PjbH4unXpjTi+5msW0fxteLbWFkhxEoKk
 hDCb0GfUllPgV20Vrlk6LsJNeKA3vndNP/2o+PszsQfRUk6mQqNSKuF2I
 5qszPDMaB9WzQdiZRg6ba17skSUTStQBwVKNVxMEk2iD6RDdEo7zV+naY
 yPmVIB2e7cztFgZf+pxkCzL4nfqQomqxT3Rr30mjZQYw+IM+ngYs7JS6r
 p3XazqPwwBGeqVZX1/Bpe8hPNP8ImmZXT5HC4QTffd58cxY/91l1twc3J
 F4FuHvE3mPtbEQZDXZALIjm68t9oDwk/Y9X3Xk1mQzHR1zQf3Av96g4Kw w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="381528480"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; d="scan'208";a="381528480"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2023 20:52:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="814500625"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; d="scan'208";a="814500625"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmsmga004.fm.intel.com with ESMTP; 13 Sep 2023 20:52:18 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, xiaoyao.li@intel.com,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 Sean Christopherson <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>
Subject: [RFC PATCH v2 13/21] i386/kvm: Set memory to default private for
 KVM_X86_SW_PROTECTED_VM
Date: Wed, 13 Sep 2023 23:51:09 -0400
Message-Id: <20230914035117.3285885-14-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914035117.3285885-1-xiaoyao.li@intel.com>
References: <20230914035117.3285885-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.24; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Register a memory listener for KVM_X86_SW_PROVTED_VM. It set RAM to
private by default.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 include/exec/memory.h             |  1 +
 target/i386/kvm/sw-protected-vm.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 2c738b5dc420..a2602b783a38 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -820,6 +820,7 @@ struct IOMMUMemoryRegion {
 #define MEMORY_LISTENER_PRIORITY_MIN            0
 #define MEMORY_LISTENER_PRIORITY_ACCEL          10
 #define MEMORY_LISTENER_PRIORITY_DEV_BACKEND    10
+#define MEMORY_LISTENER_PRIORITY_ACCEL_HIGH     20
 
 /**
  * struct MemoryListener: callbacks structure for updates to the physical memory map
diff --git a/target/i386/kvm/sw-protected-vm.c b/target/i386/kvm/sw-protected-vm.c
index 3cfcc89202a6..f47ac383e1dd 100644
--- a/target/i386/kvm/sw-protected-vm.c
+++ b/target/i386/kvm/sw-protected-vm.c
@@ -12,14 +12,32 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
+#include "exec/address-spaces.h"
+#include "sysemu/kvm.h"
 
 #include "hw/i386/x86.h"
 #include "sw-protected-vm.h"
 
+static void kvm_x86_sw_protected_vm_region_add(MemoryListener *listenr,
+                                               MemoryRegionSection *section)
+{
+    memory_region_set_default_private(section->mr);
+}
+
+static MemoryListener kvm_x86_sw_protected_vm_memory_listener = {
+    .name = "kvm_x86_sw_protected_vm_memory_listener",
+    .region_add = kvm_x86_sw_protected_vm_region_add,
+    /* Higher than KVM memory listener = 10. */
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL_HIGH,
+};
+
 int sw_protected_vm_kvm_init(MachineState *ms, Error **errp)
 {
     SwProtectedVm *spvm = SW_PROTECTED_VM(OBJECT(ms->cgs));
 
+    memory_listener_register(&kvm_x86_sw_protected_vm_memory_listener,
+                             &address_space_memory);
+
     spvm->parent_obj.ready = true;
     return 0;
 }
-- 
2.34.1


