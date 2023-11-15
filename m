Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1017EBDA1
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 08:18:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3A94-0006Te-TD; Wed, 15 Nov 2023 02:17:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3A8W-0005t3-RG
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:16:33 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3A8T-0002Gw-Nh
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:16:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700032589; x=1731568589;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5oFP29/6hPQTSjt7+TkWWvWCU+lwZOG63ox2Xe0ioV4=;
 b=T+8BCeG5/ph4MkAb2iBdM9JRWVcLk9UOS9W++lHzgxe+8UxNRSeN/Klv
 2qC1WQBuwia8rGR1sD/p0KjD/XzLcwhLi4uO4Rihia2JPyAUA542UgGU8
 C4PHv6rriRbI/VsHaAj+ANKd1URKbXGT8bmUIAXLyNW6fkcahnvQoqqEd
 jnF+A0fK5eSRBr3hPXRM00rTN13fhE6nQi1k1ZBu2L1nLy0Y5taweRe6F
 bOfpSiA8FfXtsv+Bc/MuKH99cmSAwN07pma68XUBbE87CYI2/OWe9RVpv
 2w3qnyrMIPnFnj39YVC3mMdERdKOrDRug9upSixCXDd0Cx3j83QI/Lp3C Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390622164"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="390622164"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 23:16:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="714796990"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="714796990"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orsmga003.jf.intel.com with ESMTP; 14 Nov 2023 23:16:08 -0800
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
Subject: [PATCH v3 06/70] kvm: Introduce support for memory_attributes
Date: Wed, 15 Nov 2023 02:14:15 -0500
Message-Id: <20231115071519.2864957-7-xiaoyao.li@intel.com>
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

Introduce the helper functions to set the attributes of a range of
memory to private or shared.

This is necessary to notify KVM the private/shared attribute of each gpa
range. KVM needs the information to decide the GPA needs to be mapped at
hva-based shared memory or guest_memfd based private memory.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 accel/kvm/kvm-all.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/sysemu/kvm.h |  3 +++
 2 files changed, 45 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 69afeb47c9c0..76e2404d54d2 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -102,6 +102,7 @@ bool kvm_has_guest_debug;
 static int kvm_sstep_flags;
 static bool kvm_immediate_exit;
 static bool kvm_guest_memfd_supported;
+static uint64_t kvm_supported_memory_attributes;
 static hwaddr kvm_max_slot_size = ~0;
 
 static const KVMCapabilityInfo kvm_required_capabilites[] = {
@@ -1305,6 +1306,44 @@ void kvm_set_max_memslot_size(hwaddr max_slot_size)
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
@@ -2440,6 +2479,9 @@ static int kvm_init(MachineState *ms)
 
     kvm_guest_memfd_supported = kvm_check_extension(s, KVM_CAP_GUEST_MEMFD);
 
+    ret = kvm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
+    kvm_supported_memory_attributes = ret > 0 ? ret : 0;
+
     if (object_property_find(OBJECT(current_machine), "kvm-type")) {
         g_autofree char *kvm_type = object_property_get_str(OBJECT(current_machine),
                                                             "kvm-type",
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index fedc28c7d17f..0e88958190a4 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -540,4 +540,7 @@ bool kvm_dirty_ring_enabled(void);
 uint32_t kvm_dirty_ring_size(void);
 
 int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp);
+
+int kvm_set_memory_attributes_private(hwaddr start, hwaddr size);
+int kvm_set_memory_attributes_shared(hwaddr start, hwaddr size);
 #endif
-- 
2.34.1


