Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7D6769C8E
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 18:33:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQVpB-0001so-KK; Mon, 31 Jul 2023 12:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQVp9-0001sB-L1
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:32:47 -0400
Received: from [134.134.136.126] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQVp7-000165-Pg
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690821165; x=1722357165;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nzxnw5G/eoYdNN3k9mPcm6LNL3IW0dYwkL/0HXSYmE8=;
 b=QHwSfntX0syL/zvMfyeElxcs3Mu8j7NjVAMSgcaENS7a5gEK1rEgXAP/
 AHKxTRI/Ck9RlmFa0N6H9bEZPY04Q5QLf/bqQAISTKbRDf8UI6Rb4tWWM
 cxuj+yAJfdDu+KNpJfHGjN0eiET2CCQ/fN8DMMqPDkROup2V9xJfHh+b0
 ZsDBVE3O0XRQkuULEbEIa7My+F+2mfuoFNEwoO9ViXrJJXilmMSX0U+l+
 n2B+7oQofb9VSXejkSESzkwodKPTPaZcbOj3KQDEZDnxWNS+OIxYQRJry
 Y/9dBW3RScO0tMimvH1qQhHfTA1i53iG0Uc4qAbTwULxD0/uGZu+vBfsF A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="353993432"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="353993432"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 09:25:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="757984084"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="757984084"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by orsmga008.jf.intel.com with ESMTP; 31 Jul 2023 09:25:10 -0700
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
Subject: [RFC PATCH 05/19] kvm: Enable KVM_SET_USER_MEMORY_REGION2 for memslot
Date: Mon, 31 Jul 2023 12:21:47 -0400
Message-Id: <20230731162201.271114-6-xiaoyao.li@intel.com>
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

From: Chao Peng <chao.p.peng@linux.intel.com>

Switch to KVM_SET_USER_MEMORY_REGION2 when supported by KVM.

With KVM_SET_USER_MEMORY_REGION2, QEMU can set up memory region that
backen'ed both by hva-based shared memory and gmem fd based private
memory.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Codeveloped-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 accel/kvm/kvm-all.c      | 57 +++++++++++++++++++++++++++++++++-------
 accel/kvm/trace-events   |  2 +-
 include/sysemu/kvm_int.h |  2 ++
 3 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d8eee405de24..7b1818334ba7 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -288,35 +288,68 @@ int kvm_physical_memory_addr_from_host(KVMState *s, void *ram,
 static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot, bool new)
 {
     KVMState *s = kvm_state;
-    struct kvm_userspace_memory_region mem;
+    struct kvm_userspace_memory_region2 mem;
+    static int cap_user_memory2 = -1;
     int ret;
 
+    if (cap_user_memory2 == -1) {
+        cap_user_memory2 = kvm_check_extension(s, KVM_CAP_USER_MEMORY2);
+    }
+
+    if (!cap_user_memory2 && slot->fd >= 0) {
+        error_report("%s, KVM doesn't support gmem!", __func__);
+        exit(1);
+    }
+
     mem.slot = slot->slot | (kml->as_id << 16);
     mem.guest_phys_addr = slot->start_addr;
     mem.userspace_addr = (unsigned long)slot->ram;
     mem.flags = slot->flags;
+    mem.gmem_fd = slot->fd;
+    mem.gmem_offset = slot->ofs;
 
-    if (slot->memory_size && !new && (mem.flags ^ slot->old_flags) & KVM_MEM_READONLY) {
+    if (slot->memory_size && !new && (slot->flags ^ slot->old_flags) & KVM_MEM_READONLY) {
         /* Set the slot size to 0 before setting the slot to the desired
          * value. This is needed based on KVM commit 75d61fbc. */
         mem.memory_size = 0;
-        ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
+
+        if (cap_user_memory2) {
+            ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION2, &mem);
+        } else {
+            ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
+	    }
         if (ret < 0) {
             goto err;
         }
     }
     mem.memory_size = slot->memory_size;
-    ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
+    if (cap_user_memory2) {
+        ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION2, &mem);
+    } else {
+        ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
+    }
     slot->old_flags = mem.flags;
 err:
     trace_kvm_set_user_memory(mem.slot >> 16, (uint16_t)mem.slot, mem.flags,
                               mem.guest_phys_addr, mem.memory_size,
-                              mem.userspace_addr, ret);
+                              mem.userspace_addr, mem.gmem_fd,
+			      mem.gmem_offset, ret);
     if (ret < 0) {
-        error_report("%s: KVM_SET_USER_MEMORY_REGION failed, slot=%d,"
-                     " start=0x%" PRIx64 ", size=0x%" PRIx64 ": %s",
-                     __func__, mem.slot, slot->start_addr,
-                     (uint64_t)mem.memory_size, strerror(errno));
+        if (cap_user_memory2) {
+                error_report("%s: KVM_SET_USER_MEMORY_REGION2 failed, slot=%d,"
+                        " start=0x%" PRIx64 ", size=0x%" PRIx64 ","
+                        " flags=0x%" PRIx32 ","
+                        " gmem_fd=%" PRId32 ", gmem_offset=0x%" PRIx64 ": %s",
+                        __func__, mem.slot, slot->start_addr,
+                (uint64_t)mem.memory_size, mem.flags,
+                        mem.gmem_fd, (uint64_t)mem.gmem_offset,
+                        strerror(errno));
+        } else {
+                error_report("%s: KVM_SET_USER_MEMORY_REGION failed, slot=%d,"
+                            " start=0x%" PRIx64 ", size=0x%" PRIx64 ": %s",
+                __func__, mem.slot, slot->start_addr,
+                (uint64_t)mem.memory_size, strerror(errno));
+        }
     }
     return ret;
 }
@@ -472,6 +505,9 @@ static int kvm_mem_flags(MemoryRegion *mr)
     if (readonly && kvm_readonly_mem_allowed) {
         flags |= KVM_MEM_READONLY;
     }
+    if (memory_region_can_be_private(mr)) {
+        flags |= KVM_MEM_PRIVATE;
+    }
     return flags;
 }
 
@@ -1402,6 +1438,9 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         mem->ram_start_offset = ram_start_offset;
         mem->ram = ram;
         mem->flags = kvm_mem_flags(mr);
+        mem->fd = mr->ram_block->gmem_fd;
+        mem->ofs = (uint8_t*)ram - mr->ram_block->host;
+
         kvm_slot_init_dirty_bitmap(mem);
         err = kvm_set_user_memory_region(kml, mem, true);
         if (err) {
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index 14ebfa1b991c..80694683acea 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -15,7 +15,7 @@ kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
 kvm_irqchip_release_virq(int virq) "virq %d"
 kvm_set_ioeventfd_mmio(int fd, uint64_t addr, uint32_t val, bool assign, uint32_t size, bool datamatch) "fd: %d @0x%" PRIx64 " val=0x%x assign: %d size: %d match: %d"
 kvm_set_ioeventfd_pio(int fd, uint16_t addr, uint32_t val, bool assign, uint32_t size, bool datamatch) "fd: %d @0x%x val=0x%x assign: %d size: %d match: %d"
-kvm_set_user_memory(uint16_t as, uint16_t slot, uint32_t flags, uint64_t guest_phys_addr, uint64_t memory_size, uint64_t userspace_addr, int ret) "AddrSpace#%d Slot#%d flags=0x%x gpa=0x%"PRIx64 " size=0x%"PRIx64 " ua=0x%"PRIx64 " ret=%d"
+kvm_set_user_memory(uint16_t as, uint16_t slot, uint32_t flags, uint64_t guest_phys_addr, uint64_t memory_size, uint64_t userspace_addr, uint32_t fd, uint64_t fd_offset, int ret) "AddrSpace#%d Slot#%d flags=0x%x gpa=0x%"PRIx64 " size=0x%"PRIx64 " ua=0x%"PRIx64 " gmem_fd=%d" " gmem_fd_offset=0x%" PRIx64 " ret=%d"
 kvm_clear_dirty_log(uint32_t slot, uint64_t start, uint32_t size) "slot#%"PRId32" start 0x%"PRIx64" size 0x%"PRIx32
 kvm_resample_fd_notify(int gsi) "gsi %d"
 kvm_dirty_ring_full(int id) "vcpu %d"
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 511b42bde5c4..48220c0793ac 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -30,6 +30,8 @@ typedef struct KVMSlot
     int as_id;
     /* Cache of the offset in ram address space */
     ram_addr_t ram_start_offset;
+    int fd;
+    hwaddr ofs;
 } KVMSlot;
 
 typedef struct KVMMemoryUpdate {
-- 
2.34.1


