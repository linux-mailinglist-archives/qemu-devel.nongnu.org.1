Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7297EBD7A
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 08:16:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3A8X-0005DV-Dq; Wed, 15 Nov 2023 02:16:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3A7y-00055L-Si
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:15:59 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3A7p-0001xk-Gw
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700032549; x=1731568549;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+mLDdr3qDlOyBz88xZvnEkcshGU+lPR4qEIbX+0WP2w=;
 b=m4dICPh8Vs0bZFkxWd/ZQoCHd55G99ttbOMtcigKqD4MMtoW9EE2PbMP
 4V9HJ2A9qxFeWrs7/nce99VLoVi2bOHQh+fgVi+x6nL9vTDTQxds59MGY
 lZPHO+3H+E0cuQH34EmbLd0WLEo86kJzNhqT/o2Oy9HxO2oSfC8bohgLJ
 /Ubw3A+iddC4pXYOZWbiSjUpCtEN+YTFoS9SynmNfqZX+ApzjS7DTUdzz
 B9krPIN6EjYWGkSOFU6GjotlwTWop7df/gYmqkWyy49oLPZgznk61l3yT
 XDegKHXMjUzgjU+3oT8otXYU2hLDAcflifGsym1oRUE4dmiV1sRYBtBLo w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390622053"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="390622053"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 23:15:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="714796784"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="714796784"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orsmga003.jf.intel.com with ESMTP; 14 Nov 2023 23:15:38 -0800
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
Subject: [PATCH v3 02/70] RAMBlock: Add support of KVM private guest memfd
Date: Wed, 15 Nov 2023 02:14:11 -0500
Message-Id: <20231115071519.2864957-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115071519.2864957-1-xiaoyao.li@intel.com>
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.115; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Add KVM guest_memfd support to RAMBlock so both normal hva based memory
and kvm guest memfd based private memory can be associated in one RAMBlock.

Introduce new flag RAM_GUEST_MEMFD. When it's set, it calls KVM ioctl to
create private guest_memfd during RAMBlock setup.

Note, RAM_GUEST_MEMFD is supposed to be set for memory backends of
confidential guests, such as TDX VM. How and when to set it for memory
backends will be implemented in the following patches.

Introduce memory_region_has_guest_memfd() to query if the MemoryRegion has
KVM guest_memfd allocated.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v3:
- rename gmem to guest_memfd;
- close(guest_memfd) when RAMBlock is released; (Daniel P. Berrangé)
- Suqash the patch that introduces memory_region_has_guest_memfd().
---
 accel/kvm/kvm-all.c     | 24 ++++++++++++++++++++++++
 include/exec/memory.h   | 13 +++++++++++++
 include/exec/ramblock.h |  1 +
 include/sysemu/kvm.h    |  2 ++
 system/memory.c         |  5 +++++
 system/physmem.c        | 27 ++++++++++++++++++++++++---
 6 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c1b40e873531..9f751d4971f8 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -101,6 +101,7 @@ bool kvm_msi_use_devid;
 bool kvm_has_guest_debug;
 static int kvm_sstep_flags;
 static bool kvm_immediate_exit;
+static bool kvm_guest_memfd_supported;
 static hwaddr kvm_max_slot_size = ~0;
 
 static const KVMCapabilityInfo kvm_required_capabilites[] = {
@@ -2397,6 +2398,8 @@ static int kvm_init(MachineState *ms)
     }
     s->as = g_new0(struct KVMAs, s->nr_as);
 
+    kvm_guest_memfd_supported = kvm_check_extension(s, KVM_CAP_GUEST_MEMFD);
+
     if (object_property_find(OBJECT(current_machine), "kvm-type")) {
         g_autofree char *kvm_type = object_property_get_str(OBJECT(current_machine),
                                                             "kvm-type",
@@ -4078,3 +4081,24 @@ void query_stats_schemas_cb(StatsSchemaList **result, Error **errp)
         query_stats_schema_vcpu(first_cpu, &stats_args);
     }
 }
+
+int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
+{
+    int fd;
+    struct kvm_create_guest_memfd guest_memfd = {
+        .size = size,
+        .flags = flags,
+    };
+
+    if (!kvm_guest_memfd_supported) {
+        error_setg(errp, "KVM doesn't support guest memfd\n");
+        return -EOPNOTSUPP;
+    }
+
+    fd = kvm_vm_ioctl(kvm_state, KVM_CREATE_GUEST_MEMFD, &guest_memfd);
+    if (fd < 0) {
+        error_setg_errno(errp, errno, "%s: error creating kvm guest memfd\n", __func__);
+    }
+
+    return fd;
+}
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 831f7c996d9d..f780367ab1bd 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -243,6 +243,9 @@ typedef struct IOMMUTLBEvent {
 /* RAM FD is opened read-only */
 #define RAM_READONLY_FD (1 << 11)
 
+/* RAM can be private that has kvm gmem backend */
+#define RAM_GUEST_MEMFD   (1 << 12)
+
 static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
                                        IOMMUNotifierFlag flags,
                                        hwaddr start, hwaddr end,
@@ -1702,6 +1705,16 @@ static inline bool memory_region_is_romd(MemoryRegion *mr)
  */
 bool memory_region_is_protected(MemoryRegion *mr);
 
+/**
+ * memory_region_has_guest_memfd: check whether a memory region has guest_memfd
+ *     associated
+ *
+ * Returns %true if a memory region's ram_block has valid guest_memfd assigned.
+ *
+ * @mr: the memory region being queried
+ */
+bool memory_region_has_guest_memfd(MemoryRegion *mr);
+
 /**
  * memory_region_get_iommu: check whether a memory region is an iommu
  *
diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
index 69c6a5390293..0a17ba882729 100644
--- a/include/exec/ramblock.h
+++ b/include/exec/ramblock.h
@@ -41,6 +41,7 @@ struct RAMBlock {
     QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
     int fd;
     uint64_t fd_offset;
+    int guest_memfd;
     size_t page_size;
     /* dirty bitmap used during migration */
     unsigned long *bmap;
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index d61487816421..fedc28c7d17f 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -538,4 +538,6 @@ bool kvm_arch_cpu_check_are_resettable(void);
 bool kvm_dirty_ring_enabled(void);
 
 uint32_t kvm_dirty_ring_size(void);
+
+int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp);
 #endif
diff --git a/system/memory.c b/system/memory.c
index 304fa843ea12..69741d91bbb7 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1862,6 +1862,11 @@ bool memory_region_is_protected(MemoryRegion *mr)
     return mr->ram && (mr->ram_block->flags & RAM_PROTECTED);
 }
 
+bool memory_region_has_guest_memfd(MemoryRegion *mr)
+{
+    return mr->ram_block && mr->ram_block->guest_memfd >= 0;
+}
+
 uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr)
 {
     uint8_t mask = mr->dirty_log_mask;
diff --git a/system/physmem.c b/system/physmem.c
index fc2b0fee0188..0af2213cbd9c 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1841,6 +1841,20 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         }
     }
 
+#ifdef CONFIG_KVM
+    if (kvm_enabled() && new_block->flags & RAM_GUEST_MEMFD &&
+        new_block->guest_memfd < 0) {
+        /* TODO: to decide if KVM_GUEST_MEMFD_ALLOW_HUGEPAGE is supported */
+        uint64_t flags = 0;
+        new_block->guest_memfd = kvm_create_guest_memfd(new_block->max_length,
+                                                        flags, errp);
+        if (new_block->guest_memfd < 0) {
+            qemu_mutex_unlock_ramlist();
+            return;
+        }
+    }
+#endif
+
     new_ram_size = MAX(old_ram_size,
               (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS);
     if (new_ram_size > old_ram_size) {
@@ -1903,7 +1917,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     /* Just support these ram flags by now. */
     assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
                           RAM_PROTECTED | RAM_NAMED_FILE | RAM_READONLY |
-                          RAM_READONLY_FD)) == 0);
+                          RAM_READONLY_FD | RAM_GUEST_MEMFD)) == 0);
 
     if (xen_enabled()) {
         error_setg(errp, "-mem-path not supported with Xen");
@@ -1938,6 +1952,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     new_block->used_length = size;
     new_block->max_length = size;
     new_block->flags = ram_flags;
+    new_block->guest_memfd = -1;
     new_block->host = file_ram_alloc(new_block, size, fd, !file_size, offset,
                                      errp);
     if (!new_block->host) {
@@ -2016,7 +2031,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     Error *local_err = NULL;
 
     assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
-                          RAM_NORESERVE)) == 0);
+                          RAM_NORESERVE| RAM_GUEST_MEMFD)) == 0);
     assert(!host ^ (ram_flags & RAM_PREALLOC));
 
     size = HOST_PAGE_ALIGN(size);
@@ -2028,6 +2043,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     new_block->max_length = max_size;
     assert(max_size >= size);
     new_block->fd = -1;
+    new_block->guest_memfd = -1;
     new_block->page_size = qemu_real_host_page_size();
     new_block->host = host;
     new_block->flags = ram_flags;
@@ -2050,7 +2066,7 @@ RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
 RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags,
                          MemoryRegion *mr, Error **errp)
 {
-    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE)) == 0);
+    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE | RAM_GUEST_MEMFD)) == 0);
     return qemu_ram_alloc_internal(size, size, NULL, NULL, ram_flags, mr, errp);
 }
 
@@ -2078,6 +2094,11 @@ static void reclaim_ramblock(RAMBlock *block)
     } else {
         qemu_anon_ram_free(block->host, block->max_length);
     }
+
+    if (block->guest_memfd >= 0) {
+        close(block->guest_memfd);
+    }
+
     g_free(block);
 }
 
-- 
2.34.1


