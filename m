Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE74A769C96
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 18:33:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQVpf-00030g-G2; Mon, 31 Jul 2023 12:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQVpb-0002YI-PR
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:33:15 -0400
Received: from [134.134.136.126] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQVpa-0001LE-32
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690821194; x=1722357194;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vc/AA0VTFSVygJctuEuxWBeG2HxDcS51m4hly05CELA=;
 b=h50jh97bx2RJk5kW4UfUItrvDnzC4YD2R31qL8zy2nnIDKbE2YHYi7yd
 mvJdAqTCQMIOAEhQ0MvnJT1oBfwj+dbfhWK5qKB87HszoKs9R/XhdwKGn
 YiVqeVR3i7pWFVB9H1EUGqBwJDWNHSe+kbxk5JZPw0+RMOO2jfKSXYNDs
 zWwyJ769ReFqGaFj9EpYRIu7JTHSau4Q6sSI/YvrHXX77ROyLpao2O/eA
 UovDt+xTpn5KF9OD1D5KaixxyCd19Yf0VbWT0dtLeXsnB1UeDoyPFNLEc
 jLE79PmIOkvyVqSC/Ycd8xjt+AzxwgyfclKMmf6NWLsS+xim5jNAm2TM3 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="353993495"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="353993495"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 09:25:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="757984252"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="757984252"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by orsmga008.jf.intel.com with ESMTP; 31 Jul 2023 09:25:33 -0700
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
Subject: [RFC PATCH 10/19] kvm: Introduce support for memory_attributes
Date: Mon, 31 Jul 2023 12:21:52 -0400
Message-Id: <20230731162201.271114-11-xiaoyao.li@intel.com>
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

Introcude the helper functions to set the attributes of a range of
memory to private and shared.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 accel/kvm/kvm-all.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
 include/sysemu/kvm.h |  3 +++
 2 files changed, 46 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 7b1818334ba7..6dd22fa4fd6f 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -105,6 +105,7 @@ bool kvm_msi_use_devid;
 bool kvm_has_guest_debug;
 static int kvm_sstep_flags;
 static bool kvm_immediate_exit;
+static uint64_t kvm_supported_memory_attributes;
 static hwaddr kvm_max_slot_size = ~0;
 
 static const KVMCapabilityInfo kvm_required_capabilites[] = {
@@ -1343,6 +1344,44 @@ void kvm_set_max_memslot_size(hwaddr max_slot_size)
     kvm_max_slot_size = max_slot_size;
 }
 
+static int kvm_set_memory_attributes(hwaddr start, hwaddr size, uint64_t attr)
+{
+    struct kvm_memory_attributes attrs;
+    int r;
+
+    attrs.attributes = attr;
+    attrs.address = start;
+    attrs.size = size;
+    attrs.flags = 0;
+
+    r = kvm_vm_ioctl(kvm_state, KVM_SET_MEMORY_ATTRIBUTES, &attrs);
+    if (r) {
+        warn_report("%s: failed to set memory (0x%lx+%#zx) with attr 0x%lx error '%s'",
+                     __func__, start, size, attr, strerror(errno));
+    }
+    return r;
+}
+
+int kvm_set_memory_attributes_private(hwaddr start, hwaddr size)
+{
+    if (!(kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
+        error_report("KVM doesn't support PRIVATE memory attribute\n");
+        return -EINVAL;
+    }
+
+    return kvm_set_memory_attributes(start, size, KVM_MEMORY_ATTRIBUTE_PRIVATE);
+}
+
+int kvm_set_memory_attributes_shared(hwaddr start, hwaddr size)
+{
+    if (!(kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
+        error_report("KVM doesn't support PRIVATE memory attribute\n");
+        return -EINVAL;
+    }
+
+    return kvm_set_memory_attributes(start, size, 0);
+}
+
 /* Called with KVMMemoryListener.slots_lock held */
 static void kvm_set_phys_mem(KVMMemoryListener *kml,
                              MemoryRegionSection *section, bool add)
@@ -2556,6 +2595,10 @@ static int kvm_init(MachineState *ms)
     }
     s->as = g_new0(struct KVMAs, s->nr_as);
 
+    if (kvm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES)) {
+        kvm_supported_memory_attributes = kvm_ioctl(s, KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES, 0);
+    }
+
     if (object_property_find(OBJECT(current_machine), "kvm-type")) {
         g_autofree char *kvm_type = object_property_get_str(OBJECT(current_machine),
                                                             "kvm-type",
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 115f0cca79d1..49c896d8a512 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -580,4 +580,7 @@ bool kvm_arch_cpu_check_are_resettable(void);
 bool kvm_dirty_ring_enabled(void);
 
 uint32_t kvm_dirty_ring_size(void);
+
+int kvm_set_memory_attributes_private(hwaddr start, hwaddr size);
+int kvm_set_memory_attributes_shared(hwaddr start, hwaddr size);
 #endif
-- 
2.34.1


