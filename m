Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D32D27EBDC9
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 08:21:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3ABr-0004pj-Tf; Wed, 15 Nov 2023 02:19:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3ABp-0004bE-3S
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:19:57 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3ABm-0003bE-34
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700032794; x=1731568794;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YEcoHggTNp3SWmCyqSzPRp4dnOuhAVXArV6J4/gEuPY=;
 b=WB391ZDmQUU5KZBXTj6h2qd9FIXRYK5Zvrw8Nk1PCRkVK4QE8sHIdj+C
 zg1Hrz7b+kHsgBs77nna2WcXQb65xHxBtfKzyBcxueNN55HRIV4UPbzSh
 QviqhoiDXEJ124/QzlrUjOO+yYAXaQ5gzvCDcqAYUT6SMwbHgBp9Ia0hB
 U1HvqfS0ITEUJQNvU167pqlhnqa33OW0rwlbjjq0ij1cCyleIFp3HbqeI
 T7CN0NzdGrwkMxObPnTTOjXTYyxO/F1wBNasuNJtWt7CegklEoJYLkh57
 XQQ18d1DZnxYqDPAWlNCjrs/BC5QxnhPvUziZe7RzBf0x8P+wPUVvpuJn g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390623017"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="390623017"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 23:19:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="714799276"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="714799276"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orsmga003.jf.intel.com with ESMTP; 14 Nov 2023 23:19:43 -0800
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
Subject: [PATCH v3 35/70] i386/tdx: Make memory type private by default
Date: Wed, 15 Nov 2023 02:14:44 -0500
Message-Id: <20231115071519.2864957-36-xiaoyao.li@intel.com>
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

By default (due to the recent UPM change), restricted memory attribute is
shared.  Convert the memory region from shared to private at the memory
slot creation time.

add kvm region registering function to check the flag
and convert the region, and add memory listener to TDX guest code to set
the flag to the possible memory region.

Without this patch
- Secure-EPT violation on private area
- KVM_MEMORY_FAULT EXIT (kvm -> qemu)
- qemu converts the 4K page from shared to private
- Resume VCPU execution
- Secure-EPT violation again
- KVM resolves EPT Violation
This also prevents huge page because page conversion is done at 4K
granularity.  Although it's possible to merge 4K private mapping into
2M large page, it slows guest boot.

With this patch
- After memory slot creation, convert the region from private to shared
- Secure-EPT violation on private area.
- KVM resolves EPT Violation

Originated-from: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 include/exec/memory.h |  1 +
 target/i386/kvm/tdx.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index bdc4b98efe70..c8b0385b19ad 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -850,6 +850,7 @@ struct IOMMUMemoryRegion {
 #define MEMORY_LISTENER_PRIORITY_MIN            0
 #define MEMORY_LISTENER_PRIORITY_ACCEL          10
 #define MEMORY_LISTENER_PRIORITY_DEV_BACKEND    10
+#define MEMORY_LISTENER_PRIORITY_ACCEL_HIGH     20
 
 /**
  * struct MemoryListener: callbacks structure for updates to the physical memory map
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 50e68f9c1a41..82a1b010746a 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -19,6 +19,7 @@
 #include "standard-headers/asm-x86/kvm_para.h"
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
+#include "exec/address-spaces.h"
 
 #include "hw/i386/x86.h"
 #include "kvm_i386.h"
@@ -619,6 +620,19 @@ out:
     return r;
 }
 
+static void tdx_guest_region_add(MemoryListener *listener,
+                                 MemoryRegionSection *section)
+{
+    memory_region_set_default_private(section->mr);
+}
+
+static MemoryListener tdx_memory_listener = {
+    .name = TYPE_TDX_GUEST,
+    .region_add = tdx_guest_region_add,
+    /* Higher than KVM memory listener = 10. */
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL_HIGH,
+};
+
 static bool tdx_guest_get_sept_ve_disable(Object *obj, Error **errp)
 {
     TdxGuest *tdx = TDX_GUEST(obj);
@@ -690,6 +704,12 @@ OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
 static void tdx_guest_init(Object *obj)
 {
     TdxGuest *tdx = TDX_GUEST(obj);
+    static bool memory_listener_registered = false;
+
+    if (!memory_listener_registered) {
+        memory_listener_register(&tdx_memory_listener, &address_space_memory);
+        memory_listener_registered = true;
+    }
 
     qemu_mutex_init(&tdx->lock);
 
-- 
2.34.1


