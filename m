Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2977479F931
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 05:53:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgdOE-0005lV-Vf; Wed, 13 Sep 2023 23:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qgdOD-0005lI-6X
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 23:51:37 -0400
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qgdOB-0000r7-9g
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 23:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694663495; x=1726199495;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hZCUPboW6UfJI06fOT3oOcMz9rEziUW2umb4XG87Vss=;
 b=WYyHhUB5zLRDm0IKZ2yOmczURPjSSgClZAe98Y5Eq1p+EH4ohNDcoQK/
 n2hio6EcfC+IBzb14UJevNgdKW4N8TZKxCCob/+EGzYG6ix11U78N++HK
 Pqb/J1rHnEV7GtkeEcqvrXgAZs8NAsVos8wSQF9uhfKj7f/5DvXkwuW/4
 yCrkgpsNpaY8nKtxHP1eHrM8wzkWYScpYa2X0F3Em7NQ3NWIQ1FGeDdRB
 qK+Tzlw2kadrHKKK3crygidkwQvAG4RfqymgjjvHCpEV7htUzjltNsep7
 v0ZllkrGvqdnG5wwPeDlUHiBjCeMw2WiVsBThpTH/tBnQlTVLOopuOUHq w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="381528299"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; d="scan'208";a="381528299"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2023 20:51:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="814500547"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; d="scan'208";a="814500547"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmsmga004.fm.intel.com with ESMTP; 13 Sep 2023 20:51:28 -0700
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
Subject: [RFC PATCH v2 02/21] RAMBlock: Add support of KVM private gmem
Date: Wed, 13 Sep 2023 23:50:58 -0400
Message-Id: <20230914035117.3285885-3-xiaoyao.li@intel.com>
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

From: Chao Peng <chao.p.peng@linux.intel.com>

Add KVM gmem support to RAMBlock so both normal hva based memory
and kvm gmem fd based private memory can be associated in one RAMBlock.

Introduce new flag RAM_KVM_GMEM. It calls KVM ioctl to create private
gmem for the RAMBlock when it's set.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 accel/kvm/kvm-all.c     | 17 +++++++++++++++++
 include/exec/memory.h   |  3 +++
 include/exec/ramblock.h |  1 +
 include/sysemu/kvm.h    |  2 ++
 softmmu/physmem.c       | 18 +++++++++++++++---
 5 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 60aacd925393..185ae16d9620 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -4225,3 +4225,20 @@ void query_stats_schemas_cb(StatsSchemaList **result, Error **errp)
         query_stats_schema_vcpu(first_cpu, &stats_args);
     }
 }
+
+int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
+{
+    int fd;
+    struct kvm_create_guest_memfd gmem = {
+        .size = size,
+        /* TODO: to decide whether KVM_GUEST_MEMFD_ALLOW_HUGEPAGE is supported */
+        .flags = flags,
+    };
+
+    fd = kvm_vm_ioctl(kvm_state, KVM_CREATE_GUEST_MEMFD, &gmem);
+    if (fd < 0) {
+        error_setg_errno(errp, errno, "%s: error creating kvm gmem\n", __func__);
+    }
+
+    return fd;
+}
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 68284428f87c..227cb2578e95 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -235,6 +235,9 @@ typedef struct IOMMUTLBEvent {
 /* RAM is an mmap-ed named file */
 #define RAM_NAMED_FILE (1 << 9)
 
+/* RAM can be private that has kvm gmem backend */
+#define RAM_KVM_GMEM    (1 << 10)
+
 static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
                                        IOMMUNotifierFlag flags,
                                        hwaddr start, hwaddr end,
diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
index 69c6a5390293..0d158b3909c9 100644
--- a/include/exec/ramblock.h
+++ b/include/exec/ramblock.h
@@ -41,6 +41,7 @@ struct RAMBlock {
     QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
     int fd;
     uint64_t fd_offset;
+    int gmem_fd;
     size_t page_size;
     /* dirty bitmap used during migration */
     unsigned long *bmap;
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 115f0cca79d1..f5b74c8dd8c5 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -580,4 +580,6 @@ bool kvm_arch_cpu_check_are_resettable(void);
 bool kvm_dirty_ring_enabled(void);
 
 uint32_t kvm_dirty_ring_size(void);
+
+int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp);
 #endif
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 3df73542e1fe..2d98a88f41f0 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -1824,6 +1824,16 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         }
     }
 
+    if (kvm_enabled() && new_block->flags & RAM_KVM_GMEM &&
+        new_block->gmem_fd < 0) {
+        new_block->gmem_fd = kvm_create_guest_memfd(new_block->max_length,
+                                                    0, errp);
+        if (new_block->gmem_fd < 0) {
+            qemu_mutex_unlock_ramlist();
+            return;
+        }
+    }
+
     new_ram_size = MAX(old_ram_size,
               (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS);
     if (new_ram_size > old_ram_size) {
@@ -1885,7 +1895,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
 
     /* Just support these ram flags by now. */
     assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
-                          RAM_PROTECTED | RAM_NAMED_FILE)) == 0);
+                          RAM_PROTECTED | RAM_NAMED_FILE | RAM_KVM_GMEM)) == 0);
 
     if (xen_enabled()) {
         error_setg(errp, "-mem-path not supported with Xen");
@@ -1920,6 +1930,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     new_block->used_length = size;
     new_block->max_length = size;
     new_block->flags = ram_flags;
+    new_block->gmem_fd = -1;
     new_block->host = file_ram_alloc(new_block, size, fd, readonly,
                                      !file_size, offset, errp);
     if (!new_block->host) {
@@ -1978,7 +1989,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     Error *local_err = NULL;
 
     assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
-                          RAM_NORESERVE)) == 0);
+                          RAM_NORESERVE| RAM_KVM_GMEM)) == 0);
     assert(!host ^ (ram_flags & RAM_PREALLOC));
 
     size = HOST_PAGE_ALIGN(size);
@@ -1990,6 +2001,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     new_block->max_length = max_size;
     assert(max_size >= size);
     new_block->fd = -1;
+    new_block->gmem_fd = -1;
     new_block->page_size = qemu_real_host_page_size();
     new_block->host = host;
     new_block->flags = ram_flags;
@@ -2012,7 +2024,7 @@ RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
 RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags,
                          MemoryRegion *mr, Error **errp)
 {
-    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE)) == 0);
+    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE | RAM_KVM_GMEM)) == 0);
     return qemu_ram_alloc_internal(size, size, NULL, NULL, ram_flags, mr, errp);
 }
 
-- 
2.34.1


