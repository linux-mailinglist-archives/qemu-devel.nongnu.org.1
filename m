Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC9DAC89FF
	for <lists+qemu-devel@lfdr.de>; Fri, 30 May 2025 10:35:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKvC8-0007ZZ-UI; Fri, 30 May 2025 04:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uKvC6-0007Yj-Ab
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:34:26 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uKvC2-0007uO-Vs
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748594063; x=1780130063;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Jcki6Ig/z48Z8/JtNpEEwi+YNYwIfy2K7ci4NMGgwgc=;
 b=VzDzKuCt+En5fzsDg+a7tv9GKFsLZ7Swxxo7t0byFHUav2czywrhY4Xj
 +qEUnbWD3sVFoO/Uhby7NmP0Uor3tS08yIVy3dkIgK4Zg+ItweyGdMq1C
 yllqETkl/VrqVEnlqoZh22VU7LpKMBsHudrs31c2USgeoFRsxu9EA+WmY
 Y/QEFHRC6JIf323uXSySz9oa85QRLDayaTk14r5G/z31H7B7o90eFtart
 bu/A8kdAE3JLVBKHliantmqV6eeTjLG0hqQLUgjd3txUvl/vdDxLcP8IT
 GAGbVUbwshByy5RqqYHYFFOKH2IiuRFXzYXekB6/dZRDMojym6XNTJI7Q w==;
X-CSE-ConnectionGUID: btDajEmQQGKguCF6pfQivQ==
X-CSE-MsgGUID: /+A9he+pQUK++dtZRMTCAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="62081544"
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; d="scan'208";a="62081544"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2025 01:34:15 -0700
X-CSE-ConnectionGUID: JB0NGskLRH6e8HPblP87hw==
X-CSE-MsgGUID: Y0kyjBP1RSeuJp0BROqhbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; d="scan'208";a="144453790"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2025 01:34:11 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>,
 Gao Chao <chao.gao@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v6 4/5] ram-block-attributes: Introduce RamBlockAttributes to
 manage RAMBlock with guest_memfd
Date: Fri, 30 May 2025 16:32:53 +0800
Message-ID: <20250530083256.105186-5-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250530083256.105186-1-chenyi.qiang@intel.com>
References: <20250530083256.105186-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Commit 852f0048f3 ("RAMBlock: make guest_memfd require uncoordinated
discard") highlighted that subsystems like VFIO may disable RAM block
discard. However, guest_memfd relies on discard operations for page
conversion between private and shared memory, potentially leading to
the stale IOMMU mapping issue when assigning hardware devices to
confidential VMs via shared memory. To address this and allow shared
device assignement, it is crucial to ensure the VFIO system refreshes
its IOMMU mappings.

RamDiscardManager is an existing interface (used by virtio-mem) to
adjust VFIO mappings in relation to VM page assignment. Effectively page
conversion is similar to hot-removing a page in one mode and adding it
back in the other. Therefore, similar actions are required for page
conversion events. Introduce the RamDiscardManager to guest_memfd to
facilitate this process.

Since guest_memfd is not an object, it cannot directly implement the
RamDiscardManager interface. Implementing it in HostMemoryBackend is
not appropriate because guest_memfd is per RAMBlock, and some RAMBlocks
have a memory backend while others do not. Notably, virtual BIOS
RAMBlocks using memory_region_init_ram_guest_memfd() do not have a
backend.

To manage RAMBlocks with guest_memfd, define a new object named
RamBlockAttributes to implement the RamDiscardManager interface. This
object can store the guest_memfd information such as bitmap for shared
memory and the registered listeners for event notification. In the
context of RamDiscardManager, shared state is analogous to populated, and
private state is signified as discarded. To notify the conversion events,
a new state_change() helper is exported for the users to notify the
listeners like VFIO, so that VFIO can dynamically DMA map/unmap the
shared mapping.

Note that the memory state is tracked at the host page size granularity,
as the minimum conversion size can be one page per request and VFIO
expects the DMA mapping for a specific iova to be mapped and unmapped
with the same granularity. Confidential VMs may perform partial
conversions, such as conversions on small regions within larger ones.
To prevent such invalid cases and until DMA mapping cut operation
support is available, all operations are performed with 4K granularity.

In addition, memory conversion failures cause QEMU to quit instead of
resuming the guest or retrying the operation at present. It would be
future work to add more error handling or rollback mechanisms once
conversion failures are allowed. For example, in-place conversion of
guest_memfd could retry the unmap operation during the conversion from
shared to private. For now, keep the complex error handling out of the
picture as it is not required.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
Changes in v6:
    - Change the object type name from RamBlockAttribute to
      RamBlockAttributes. (David)
    - Save the associated RAMBlock instead MemoryRegion in
      RamBlockAttributes. (David)
    - Squash the state_change() helper introduction in this commit as
      well as the mixture conversion case handling. (David)
    - Change the block_size type from int to size_t and some cleanup in
      validation check. (Alexey)
    - Add a tracepoint to track the state changes. (Alexey)

Changes in v5:
    - Revert to use RamDiscardManager interface instead of introducing
      new hierarchy of class to manage private/shared state, and keep
      using the new name of RamBlockAttribute compared with the
      MemoryAttributeManager in v3.
    - Use *simple* version of object_define and object_declare since the
      state_change() function is changed as an exported function instead
      of a virtual function in later patch.
    - Move the introduction of RamBlockAttribute field to this patch and
      rename it to ram_shared. (Alexey)
    - call the exit() when register/unregister failed. (Zhao)
    - Add the ram-block-attribute.c to Memory API related part in
      MAINTAINERS.

Changes in v4:
    - Change the name from memory-attribute-manager to
      ram-block-attribute.
    - Implement the newly-introduced PrivateSharedManager instead of
      RamDiscardManager and change related commit message.
    - Define the new object in ramblock.h instead of adding a new file.
---
 MAINTAINERS                   |   1 +
 include/system/ramblock.h     |  21 ++
 system/meson.build            |   1 +
 system/ram-block-attributes.c | 480 ++++++++++++++++++++++++++++++++++
 system/trace-events           |   3 +
 5 files changed, 506 insertions(+)
 create mode 100644 system/ram-block-attributes.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6dacd6d004..8ec39aa7f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3149,6 +3149,7 @@ F: system/memory.c
 F: system/memory_mapping.c
 F: system/physmem.c
 F: system/memory-internal.h
+F: system/ram-block-attributes.c
 F: scripts/coccinelle/memory-region-housekeeping.cocci
 
 Memory devices
diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index d8a116ba99..1bab9e2dac 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -22,6 +22,10 @@
 #include "exec/cpu-common.h"
 #include "qemu/rcu.h"
 #include "exec/ramlist.h"
+#include "system/hostmem.h"
+
+#define TYPE_RAM_BLOCK_ATTRIBUTES "ram-block-attributes"
+OBJECT_DECLARE_SIMPLE_TYPE(RamBlockAttributes, RAM_BLOCK_ATTRIBUTES)
 
 struct RAMBlock {
     struct rcu_head rcu;
@@ -91,4 +95,21 @@ struct RAMBlock {
     ram_addr_t postcopy_length;
 };
 
+struct RamBlockAttributes {
+    Object parent;
+
+    RAMBlock *ram_block;
+
+    /* 1-setting of the bitmap represents ram is populated (shared) */
+    unsigned bitmap_size;
+    unsigned long *bitmap;
+
+    QLIST_HEAD(, RamDiscardListener) rdl_list;
+};
+
+RamBlockAttributes *ram_block_attributes_create(RAMBlock *ram_block);
+void ram_block_attributes_destroy(RamBlockAttributes *attr);
+int ram_block_attributes_state_change(RamBlockAttributes *attr, uint64_t offset,
+                                      uint64_t size, bool to_discard);
+
 #endif
diff --git a/system/meson.build b/system/meson.build
index c2f0082766..2747dbde80 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -17,6 +17,7 @@ libsystem_ss.add(files(
   'dma-helpers.c',
   'globals.c',
   'ioport.c',
+  'ram-block-attributes.c',
   'memory_mapping.c',
   'memory.c',
   'physmem.c',
diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
new file mode 100644
index 0000000000..514252413f
--- /dev/null
+++ b/system/ram-block-attributes.c
@@ -0,0 +1,480 @@
+/*
+ * QEMU ram block attributes
+ *
+ * Copyright Intel
+ *
+ * Author:
+ *      Chenyi Qiang <chenyi.qiang@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "system/ramblock.h"
+#include "trace.h"
+
+OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RamBlockAttributes,
+                                          ram_block_attributes,
+                                          RAM_BLOCK_ATTRIBUTES,
+                                          OBJECT,
+                                          { TYPE_RAM_DISCARD_MANAGER },
+                                          { })
+
+static size_t
+ram_block_attributes_get_block_size(const RamBlockAttributes *attr)
+{
+    /*
+     * Because page conversion could be manipulated in the size of at least 4K
+     * or 4K aligned, Use the host page size as the granularity to track the
+     * memory attribute.
+     */
+    g_assert(attr && attr->ram_block);
+    g_assert(attr->ram_block->page_size == qemu_real_host_page_size());
+    return attr->ram_block->page_size;
+}
+
+
+static bool
+ram_block_attributes_rdm_is_populated(const RamDiscardManager *rdm,
+                                      const MemoryRegionSection *section)
+{
+    const RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rdm);
+    const size_t block_size = ram_block_attributes_get_block_size(attr);
+    const uint64_t first_bit = section->offset_within_region / block_size;
+    const uint64_t last_bit = first_bit + int128_get64(section->size) / block_size - 1;
+    unsigned long first_discarded_bit;
+
+    first_discarded_bit = find_next_zero_bit(attr->bitmap, last_bit + 1,
+                                           first_bit);
+    return first_discarded_bit > last_bit;
+}
+
+typedef int (*ram_block_attributes_section_cb)(MemoryRegionSection *s,
+                                               void *arg);
+
+static int
+ram_block_attributes_notify_populate_cb(MemoryRegionSection *section,
+                                        void *arg)
+{
+    RamDiscardListener *rdl = arg;
+
+    return rdl->notify_populate(rdl, section);
+}
+
+static int
+ram_block_attributes_notify_discard_cb(MemoryRegionSection *section,
+                                       void *arg)
+{
+    RamDiscardListener *rdl = arg;
+
+    rdl->notify_discard(rdl, section);
+    return 0;
+}
+
+static int
+ram_block_attributes_for_each_populated_section(const RamBlockAttributes *attr,
+                                                MemoryRegionSection *section,
+                                                void *arg,
+                                                ram_block_attributes_section_cb cb)
+{
+    unsigned long first_bit, last_bit;
+    uint64_t offset, size;
+    const size_t block_size = ram_block_attributes_get_block_size(attr);
+    int ret = 0;
+
+    first_bit = section->offset_within_region / block_size;
+    first_bit = find_next_bit(attr->bitmap, attr->bitmap_size,
+                              first_bit);
+
+    while (first_bit < attr->bitmap_size) {
+        MemoryRegionSection tmp = *section;
+
+        offset = first_bit * block_size;
+        last_bit = find_next_zero_bit(attr->bitmap, attr->bitmap_size,
+                                      first_bit + 1) - 1;
+        size = (last_bit - first_bit + 1) * block_size;
+
+        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
+            break;
+        }
+
+        ret = cb(&tmp, arg);
+        if (ret) {
+            error_report("%s: Failed to notify RAM discard listener: %s",
+                         __func__, strerror(-ret));
+            break;
+        }
+
+        first_bit = find_next_bit(attr->bitmap, attr->bitmap_size,
+                                  last_bit + 2);
+    }
+
+    return ret;
+}
+
+static int
+ram_block_attributes_for_each_discarded_section(const RamBlockAttributes *attr,
+                                                MemoryRegionSection *section,
+                                                void *arg,
+                                                ram_block_attributes_section_cb cb)
+{
+    unsigned long first_bit, last_bit;
+    uint64_t offset, size;
+    const size_t block_size = ram_block_attributes_get_block_size(attr);
+    int ret = 0;
+
+    first_bit = section->offset_within_region / block_size;
+    first_bit = find_next_zero_bit(attr->bitmap, attr->bitmap_size,
+                                   first_bit);
+
+    while (first_bit < attr->bitmap_size) {
+        MemoryRegionSection tmp = *section;
+
+        offset = first_bit * block_size;
+        last_bit = find_next_bit(attr->bitmap, attr->bitmap_size,
+                                 first_bit + 1) - 1;
+        size = (last_bit - first_bit + 1) * block_size;
+
+        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
+            break;
+        }
+
+        ret = cb(&tmp, arg);
+        if (ret) {
+            error_report("%s: Failed to notify RAM discard listener: %s",
+                         __func__, strerror(-ret));
+            break;
+        }
+
+        first_bit = find_next_zero_bit(attr->bitmap,
+                                       attr->bitmap_size,
+                                       last_bit + 2);
+    }
+
+    return ret;
+}
+
+static uint64_t
+ram_block_attributes_rdm_get_min_granularity(const RamDiscardManager *rdm,
+                                             const MemoryRegion *mr)
+{
+    const RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rdm);
+
+    g_assert(mr == attr->ram_block->mr);
+    return ram_block_attributes_get_block_size(attr);
+}
+
+static void
+ram_block_attributes_rdm_register_listener(RamDiscardManager *rdm,
+                                           RamDiscardListener *rdl,
+                                           MemoryRegionSection *section)
+{
+    RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rdm);
+    int ret;
+
+    g_assert(section->mr == attr->ram_block->mr);
+    rdl->section = memory_region_section_new_copy(section);
+
+    QLIST_INSERT_HEAD(&attr->rdl_list, rdl, next);
+
+    ret = ram_block_attributes_for_each_populated_section(attr, section, rdl,
+                                    ram_block_attributes_notify_populate_cb);
+    if (ret) {
+        error_report("%s: Failed to register RAM discard listener: %s",
+                     __func__, strerror(-ret));
+        exit(1);
+    }
+}
+
+static void
+ram_block_attributes_rdm_unregister_listener(RamDiscardManager *rdm,
+                                             RamDiscardListener *rdl)
+{
+    RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rdm);
+    int ret;
+
+    g_assert(rdl->section);
+    g_assert(rdl->section->mr == attr->ram_block->mr);
+
+    if (rdl->double_discard_supported) {
+        rdl->notify_discard(rdl, rdl->section);
+    } else {
+        ret = ram_block_attributes_for_each_populated_section(attr,
+                rdl->section, rdl, ram_block_attributes_notify_discard_cb);
+        if (ret) {
+            error_report("%s: Failed to unregister RAM discard listener: %s",
+                         __func__, strerror(-ret));
+            exit(1);
+        }
+    }
+
+    memory_region_section_free_copy(rdl->section);
+    rdl->section = NULL;
+    QLIST_REMOVE(rdl, next);
+}
+
+typedef struct RamBlockAttributesReplayData {
+    ReplayRamDiscardState fn;
+    void *opaque;
+} RamBlockAttributesReplayData;
+
+static int ram_block_attributes_rdm_replay_cb(MemoryRegionSection *section,
+                                              void *arg)
+{
+    RamBlockAttributesReplayData *data = arg;
+
+    return data->fn(section, data->opaque);
+}
+
+static int
+ram_block_attributes_rdm_replay_populated(const RamDiscardManager *rdm,
+                                          MemoryRegionSection *section,
+                                          ReplayRamDiscardState replay_fn,
+                                          void *opaque)
+{
+    RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rdm);
+    RamBlockAttributesReplayData data = { .fn = replay_fn, .opaque = opaque };
+
+    g_assert(section->mr == attr->ram_block->mr);
+    return ram_block_attributes_for_each_populated_section(attr, section, &data,
+                                            ram_block_attributes_rdm_replay_cb);
+}
+
+static int
+ram_block_attributes_rdm_replay_discarded(const RamDiscardManager *rdm,
+                                          MemoryRegionSection *section,
+                                          ReplayRamDiscardState replay_fn,
+                                          void *opaque)
+{
+    RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rdm);
+    RamBlockAttributesReplayData data = { .fn = replay_fn, .opaque = opaque };
+
+    g_assert(section->mr == attr->ram_block->mr);
+    return ram_block_attributes_for_each_discarded_section(attr, section, &data,
+                                            ram_block_attributes_rdm_replay_cb);
+}
+
+static bool
+ram_block_attributes_is_valid_range(RamBlockAttributes *attr, uint64_t offset,
+                                    uint64_t size)
+{
+    MemoryRegion *mr = attr->ram_block->mr;
+
+    g_assert(mr);
+
+    uint64_t region_size = memory_region_size(mr);
+    const size_t block_size = ram_block_attributes_get_block_size(attr);
+
+    if (!QEMU_IS_ALIGNED(offset, block_size) ||
+        !QEMU_IS_ALIGNED(size, block_size)) {
+        return false;
+    }
+    if (offset + size <= offset) {
+        return false;
+    }
+    if (offset + size > region_size) {
+        return false;
+    }
+    return true;
+}
+
+static void ram_block_attributes_notify_discard(RamBlockAttributes *attr,
+                                                uint64_t offset,
+                                                uint64_t size)
+{
+    RamDiscardListener *rdl;
+
+    QLIST_FOREACH(rdl, &attr->rdl_list, next) {
+        MemoryRegionSection tmp = *rdl->section;
+
+        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
+            continue;
+        }
+        rdl->notify_discard(rdl, &tmp);
+    }
+}
+
+static int
+ram_block_attributes_notify_populate(RamBlockAttributes *attr,
+                                     uint64_t offset, uint64_t size)
+{
+    RamDiscardListener *rdl;
+    int ret = 0;
+
+    QLIST_FOREACH(rdl, &attr->rdl_list, next) {
+        MemoryRegionSection tmp = *rdl->section;
+
+        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
+            continue;
+        }
+        ret = rdl->notify_populate(rdl, &tmp);
+        if (ret) {
+            break;
+        }
+    }
+
+    return ret;
+}
+
+static bool ram_block_attributes_is_range_populated(RamBlockAttributes *attr,
+                                                    uint64_t offset,
+                                                    uint64_t size)
+{
+    const size_t block_size = ram_block_attributes_get_block_size(attr);
+    const unsigned long first_bit = offset / block_size;
+    const unsigned long last_bit = first_bit + (size / block_size) - 1;
+    unsigned long found_bit;
+
+    found_bit = find_next_zero_bit(attr->bitmap, last_bit + 1,
+                                   first_bit);
+    return found_bit > last_bit;
+}
+
+static bool
+ram_block_attributes_is_range_discarded(RamBlockAttributes *attr,
+                                        uint64_t offset, uint64_t size)
+{
+    const size_t block_size = ram_block_attributes_get_block_size(attr);
+    const unsigned long first_bit = offset / block_size;
+    const unsigned long last_bit = first_bit + (size / block_size) - 1;
+    unsigned long found_bit;
+
+    found_bit = find_next_bit(attr->bitmap, last_bit + 1, first_bit);
+    return found_bit > last_bit;
+}
+
+int ram_block_attributes_state_change(RamBlockAttributes *attr,
+                                      uint64_t offset, uint64_t size,
+                                      bool to_discard)
+{
+    const size_t block_size = ram_block_attributes_get_block_size(attr);
+    const unsigned long first_bit = offset / block_size;
+    const unsigned long nbits = size / block_size;
+    bool is_range_discarded, is_range_populated;
+    const uint64_t end = offset + size;
+    unsigned long bit;
+    uint64_t cur;
+    int ret = 0;
+
+    if (!ram_block_attributes_is_valid_range(attr, offset, size)) {
+        error_report("%s, invalid range: offset 0x%lx, size 0x%lx",
+                     __func__, offset, size);
+        return -EINVAL;
+    }
+
+    is_range_discarded = ram_block_attributes_is_range_discarded(attr, offset,
+                                                                 size);
+    is_range_populated = ram_block_attributes_is_range_populated(attr, offset,
+                                                                 size);
+
+    trace_ram_block_attributes_state_change(offset, size,
+                                            is_range_discarded ? "discarded" :
+                                            is_range_populated ? "populated" :
+                                            "mixture",
+                                            to_discard ? "discarded" :
+                                            "populated");
+    if (to_discard) {
+        if (is_range_discarded) {
+            /* Already private */
+        } else if (is_range_populated) {
+            /* Completely shared */
+            bitmap_clear(attr->bitmap, first_bit, nbits);
+            ram_block_attributes_notify_discard(attr, offset, size);
+        } else {
+            /* Unexpected mixture: process individual blocks */
+            for (cur = offset; cur < end; cur += block_size) {
+                bit = cur / block_size;
+                if (!test_bit(bit, attr->bitmap)) {
+                    continue;
+                }
+                clear_bit(bit, attr->bitmap);
+                ram_block_attributes_notify_discard(attr, cur, block_size);
+            }
+        }
+    } else {
+        if (is_range_populated) {
+            /* Already shared */
+        } else if (is_range_discarded) {
+            /* Complete private */
+            bitmap_set(attr->bitmap, first_bit, nbits);
+            ret = ram_block_attributes_notify_populate(attr, offset, size);
+        } else {
+            /* Unexpected mixture: process individual blocks */
+            for (cur = offset; cur < end; cur += block_size) {
+                bit = cur / block_size;
+                if (test_bit(bit, attr->bitmap)) {
+                    continue;
+                }
+                set_bit(bit, attr->bitmap);
+                ret = ram_block_attributes_notify_populate(attr, cur,
+                                                           block_size);
+                if (ret) {
+                    break;
+                }
+            }
+        }
+    }
+
+    return ret;
+}
+
+RamBlockAttributes *ram_block_attributes_create(RAMBlock *ram_block)
+{
+    uint64_t bitmap_size;
+    const int block_size  = qemu_real_host_page_size();
+    RamBlockAttributes *attr;
+    int ret;
+    MemoryRegion *mr = ram_block->mr;
+
+    attr = RAM_BLOCK_ATTRIBUTES(object_new(TYPE_RAM_BLOCK_ATTRIBUTES));
+
+    attr->ram_block = ram_block;
+    ret = memory_region_set_ram_discard_manager(mr, RAM_DISCARD_MANAGER(attr));
+    if (ret) {
+        object_unref(OBJECT(attr));
+        return NULL;
+    }
+    bitmap_size = ROUND_UP(mr->size, block_size) / block_size;
+    attr->bitmap_size = bitmap_size;
+    attr->bitmap = bitmap_new(bitmap_size);
+
+    return attr;
+}
+
+void ram_block_attributes_destroy(RamBlockAttributes *attr)
+{
+    if (!attr) {
+        return;
+    }
+
+    g_free(attr->bitmap);
+    memory_region_set_ram_discard_manager(attr->ram_block->mr, NULL);
+    object_unref(OBJECT(attr));
+}
+
+static void ram_block_attributes_init(Object *obj)
+{
+    RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(obj);
+
+    QLIST_INIT(&attr->rdl_list);
+}
+
+static void ram_block_attributes_finalize(Object *obj)
+{
+}
+
+static void ram_block_attributes_class_init(ObjectClass *klass,
+                                            const void *data)
+{
+    RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_CLASS(klass);
+
+    rdmc->get_min_granularity = ram_block_attributes_rdm_get_min_granularity;
+    rdmc->register_listener = ram_block_attributes_rdm_register_listener;
+    rdmc->unregister_listener = ram_block_attributes_rdm_unregister_listener;
+    rdmc->is_populated = ram_block_attributes_rdm_is_populated;
+    rdmc->replay_populated = ram_block_attributes_rdm_replay_populated;
+    rdmc->replay_discarded = ram_block_attributes_rdm_replay_discarded;
+}
diff --git a/system/trace-events b/system/trace-events
index be12ebfb41..82856e44f2 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -52,3 +52,6 @@ dirtylimit_state_finalize(void)
 dirtylimit_throttle_pct(int cpu_index, uint64_t pct, int64_t time_us) "CPU[%d] throttle percent: %" PRIu64 ", throttle adjust time %"PRIi64 " us"
 dirtylimit_set_vcpu(int cpu_index, uint64_t quota) "CPU[%d] set dirty page rate limit %"PRIu64
 dirtylimit_vcpu_execute(int cpu_index, int64_t sleep_time_us) "CPU[%d] sleep %"PRIi64 " us"
+
+# ram-block-attributes.c
+ram_block_attributes_state_change(uint64_t offset, uint64_t size, const char *from, const char *to) "offset 0x%"PRIx64" size 0x%"PRIx64" from '%s' to '%s'"
-- 
2.43.5


