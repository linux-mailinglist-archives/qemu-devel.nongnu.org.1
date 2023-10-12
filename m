Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 152B37C706B
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:37:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqwoV-0002rQ-9I; Thu, 12 Oct 2023 10:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qqwoS-0002q7-QY
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:37:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qqwoP-0005hI-Fo
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697121436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mvjy9MwW0Zjt4pWk3ELzW5sO18/aPlZW1rOT1VdVhig=;
 b=eq6H1zNgopniQbHbU7XRoFcWeoysQaJGs9vYAMzf4vjRLEbv8rqJKfOdDgCfqLN0FOxoKB
 xZ7bMvJnGze+BaI6Ot1wzmSZ/WMi89Hkme1VkLW3Lj1MPao+AJ75sEdCN5b7MODBodD/gU
 4l+anm+lC4AR8w9CAuhQ+bfsNaENU4g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-6gjRh7nxOgqH3bIFB6YH3A-1; Thu, 12 Oct 2023 10:37:15 -0400
X-MC-Unique: 6gjRh7nxOgqH3bIFB6YH3A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2AA010597C4;
 Thu, 12 Oct 2023 14:37:14 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05AC91C06534;
 Thu, 12 Oct 2023 14:37:13 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [GIT PULL 16/18] virtio-mem: Expose device memory dynamically via
 multiple memslots if enabled
Date: Thu, 12 Oct 2023 16:36:53 +0200
Message-ID: <20231012143655.114631-17-david@redhat.com>
In-Reply-To: <20231012143655.114631-1-david@redhat.com>
References: <20231012143655.114631-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Having large virtio-mem devices that only expose little memory to a VM
is currently a problem: we map the whole sparse memory region into the
guest using a single memslot, resulting in one gigantic memslot in KVM.
KVM allocates metadata for the whole memslot, which can result in quite
some memory waste.

Assuming we have a 1 TiB virtio-mem device and only expose little (e.g.,
1 GiB) memory, we would create a single 1 TiB memslot and KVM has to
allocate metadata for that 1 TiB memslot: on x86, this implies allocating
a significant amount of memory for metadata:

(1) RMAP: 8 bytes per 4 KiB, 8 bytes per 2 MiB, 8 bytes per 1 GiB
    -> For 1 TiB: 2147483648 + 4194304 + 8192 = ~ 2 GiB (0.2 %)

    With the TDP MMU (cat /sys/module/kvm/parameters/tdp_mmu) this gets
    allocated lazily when required for nested VMs
(2) gfn_track: 2 bytes per 4 KiB
    -> For 1 TiB: 536870912 = ~512 MiB (0.05 %)
(3) lpage_info: 4 bytes per 2 MiB, 4 bytes per 1 GiB
    -> For 1 TiB: 2097152 + 4096 = ~2 MiB (0.0002 %)
(4) 2x dirty bitmaps for tracking: 2x 1 bit per 4 KiB page
    -> For 1 TiB: 536870912 = 64 MiB (0.006 %)

So we primarily care about (1) and (2). The bad thing is, that the
memory consumption *doubles* once SMM is enabled, because we create the
memslot once for !SMM and once for SMM.

Having a 1 TiB memslot without the TDP MMU consumes around:
* With SMM: 5 GiB
* Without SMM: 2.5 GiB
Having a 1 TiB memslot with the TDP MMU consumes around:
* With SMM: 1 GiB
* Without SMM: 512 MiB

... and that's really something we want to optimize, to be able to just
start a VM with small boot memory (e.g., 4 GiB) and a virtio-mem device
that can grow very large (e.g., 1 TiB).

Consequently, using multiple memslots and only mapping the memslots we
really need can significantly reduce memory waste and speed up
memslot-related operations. Let's expose the sparse RAM memory region using
multiple memslots, mapping only the memslots we currently need into our
device memory region container.

The feature can be enabled using "dynamic-memslots=on" and requires
"unplugged-inaccessible=on", which is nowadays the default.

Once enabled, we'll auto-detect the number of memslots to use based on the
memslot limit provided by the core. We'll use at most 1 memslot per
gigabyte. Note that our global limit of memslots accross all memory devices
is currently set to 256: even with multiple large virtio-mem devices,
we'd still have a sane limit on the number of memslots used.

The default is to not dynamically map memslot for now
("dynamic-memslots=off"). The optimization must be enabled manually,
because some vhost setups (e.g., hotplug of vhost-user devices) might be
problematic until we support more memslots especially in vhost-user backends.

Note that "dynamic-memslots=on" is just a hint that multiple memslots
*may* be used for internal optimizations, not that multiple memslots
*must* be used. The actual number of memslots that are used is an
internal detail: for example, once memslot metadata is no longer an
issue, we could simply stop optimizing for that. Migration source and
destination can differ on the setting of "dynamic-memslots".

Message-ID: <20230926185738.277351-17-david@redhat.com>
Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem-pci.c     |  21 +++
 hw/virtio/virtio-mem.c         | 288 +++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-mem.h |  32 +++-
 3 files changed, 340 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
index c4597e029e..1b4e9a3284 100644
--- a/hw/virtio/virtio-mem-pci.c
+++ b/hw/virtio/virtio-mem-pci.c
@@ -48,6 +48,25 @@ static MemoryRegion *virtio_mem_pci_get_memory_region(MemoryDeviceState *md,
     return vmc->get_memory_region(vmem, errp);
 }
 
+static void virtio_mem_pci_decide_memslots(MemoryDeviceState *md,
+                                           unsigned int limit)
+{
+    VirtIOMEMPCI *pci_mem = VIRTIO_MEM_PCI(md);
+    VirtIOMEM *vmem = VIRTIO_MEM(&pci_mem->vdev);
+    VirtIOMEMClass *vmc = VIRTIO_MEM_GET_CLASS(vmem);
+
+    vmc->decide_memslots(vmem, limit);
+}
+
+static unsigned int virtio_mem_pci_get_memslots(MemoryDeviceState *md)
+{
+    VirtIOMEMPCI *pci_mem = VIRTIO_MEM_PCI(md);
+    VirtIOMEM *vmem = VIRTIO_MEM(&pci_mem->vdev);
+    VirtIOMEMClass *vmc = VIRTIO_MEM_GET_CLASS(vmem);
+
+    return vmc->get_memslots(vmem);
+}
+
 static uint64_t virtio_mem_pci_get_plugged_size(const MemoryDeviceState *md,
                                                 Error **errp)
 {
@@ -150,6 +169,8 @@ static void virtio_mem_pci_class_init(ObjectClass *klass, void *data)
     mdc->set_addr = virtio_mem_pci_set_addr;
     mdc->get_plugged_size = virtio_mem_pci_get_plugged_size;
     mdc->get_memory_region = virtio_mem_pci_get_memory_region;
+    mdc->decide_memslots = virtio_mem_pci_decide_memslots;
+    mdc->get_memslots = virtio_mem_pci_get_memslots;
     mdc->fill_device_info = virtio_mem_pci_fill_device_info;
     mdc->get_min_alignment = virtio_mem_pci_get_min_alignment;
 
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 0cf47df9cf..e1e4250e69 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -66,6 +66,13 @@ static uint32_t virtio_mem_default_thp_size(void)
     return default_thp_size;
 }
 
+/*
+ * The minimum memslot size depends on this setting ("sane default"), the
+ * device block size, and the memory backend page size. The last (or single)
+ * memslot might be smaller than this constant.
+ */
+#define VIRTIO_MEM_MIN_MEMSLOT_SIZE (1 * GiB)
+
 /*
  * We want to have a reasonable default block size such that
  * 1. We avoid splitting THPs when unplugging memory, which degrades
@@ -483,6 +490,96 @@ static bool virtio_mem_valid_range(const VirtIOMEM *vmem, uint64_t gpa,
     return true;
 }
 
+static void virtio_mem_activate_memslot(VirtIOMEM *vmem, unsigned int idx)
+{
+    const uint64_t memslot_offset = idx * vmem->memslot_size;
+
+    assert(vmem->memslots);
+
+    /*
+     * Instead of enabling/disabling memslots, we add/remove them. This should
+     * make address space updates faster, because we don't have to loop over
+     * many disabled subregions.
+     */
+    if (memory_region_is_mapped(&vmem->memslots[idx])) {
+        return;
+    }
+    memory_region_add_subregion(vmem->mr, memslot_offset, &vmem->memslots[idx]);
+}
+
+static void virtio_mem_deactivate_memslot(VirtIOMEM *vmem, unsigned int idx)
+{
+    assert(vmem->memslots);
+
+    if (!memory_region_is_mapped(&vmem->memslots[idx])) {
+        return;
+    }
+    memory_region_del_subregion(vmem->mr, &vmem->memslots[idx]);
+}
+
+static void virtio_mem_activate_memslots_to_plug(VirtIOMEM *vmem,
+                                                 uint64_t offset, uint64_t size)
+{
+    const unsigned int start_idx = offset / vmem->memslot_size;
+    const unsigned int end_idx = (offset + size + vmem->memslot_size - 1) /
+                                 vmem->memslot_size;
+    unsigned int idx;
+
+    if (!vmem->dynamic_memslots) {
+        return;
+    }
+
+    /* Activate all involved memslots in a single transaction. */
+    memory_region_transaction_begin();
+    for (idx = start_idx; idx < end_idx; idx++) {
+        virtio_mem_activate_memslot(vmem, idx);
+    }
+    memory_region_transaction_commit();
+}
+
+static void virtio_mem_deactivate_unplugged_memslots(VirtIOMEM *vmem,
+                                                     uint64_t offset,
+                                                     uint64_t size)
+{
+    const uint64_t region_size = memory_region_size(&vmem->memdev->mr);
+    const unsigned int start_idx = offset / vmem->memslot_size;
+    const unsigned int end_idx = (offset + size + vmem->memslot_size - 1) /
+                                 vmem->memslot_size;
+    unsigned int idx;
+
+    if (!vmem->dynamic_memslots) {
+        return;
+    }
+
+    /* Deactivate all memslots with unplugged blocks in a single transaction. */
+    memory_region_transaction_begin();
+    for (idx = start_idx; idx < end_idx; idx++) {
+        const uint64_t memslot_offset = idx * vmem->memslot_size;
+        uint64_t memslot_size = vmem->memslot_size;
+
+        /* The size of the last memslot might be smaller. */
+        if (idx == vmem->nb_memslots - 1) {
+            memslot_size = region_size - memslot_offset;
+        }
+
+        /*
+         * Partially covered memslots might still have some blocks plugged and
+         * have to remain active if that's the case.
+         */
+        if (offset > memslot_offset ||
+            offset + size < memslot_offset + memslot_size) {
+            const uint64_t gpa = vmem->addr + memslot_offset;
+
+            if (!virtio_mem_is_range_unplugged(vmem, gpa, memslot_size)) {
+                continue;
+            }
+        }
+
+        virtio_mem_deactivate_memslot(vmem, idx);
+    }
+    memory_region_transaction_commit();
+}
+
 static int virtio_mem_set_block_state(VirtIOMEM *vmem, uint64_t start_gpa,
                                       uint64_t size, bool plug)
 {
@@ -500,6 +597,8 @@ static int virtio_mem_set_block_state(VirtIOMEM *vmem, uint64_t start_gpa,
         }
         virtio_mem_notify_unplug(vmem, offset, size);
         virtio_mem_set_range_unplugged(vmem, start_gpa, size);
+        /* Deactivate completely unplugged memslots after updating the state. */
+        virtio_mem_deactivate_unplugged_memslots(vmem, offset, size);
         return 0;
     }
 
@@ -527,7 +626,20 @@ static int virtio_mem_set_block_state(VirtIOMEM *vmem, uint64_t start_gpa,
     }
 
     if (!ret) {
+        /*
+         * Activate before notifying and rollback in case of any errors.
+         *
+         * When activating a yet inactive memslot, memory notifiers will get
+         * notified about the added memory region and can register with the
+         * RamDiscardManager; this will traverse all plugged blocks and skip the
+         * blocks we are plugging here. The following notification will inform
+         * registered listeners about the blocks we're plugging.
+         */
+        virtio_mem_activate_memslots_to_plug(vmem, offset, size);
         ret = virtio_mem_notify_plug(vmem, offset, size);
+        if (ret) {
+            virtio_mem_deactivate_unplugged_memslots(vmem, offset, size);
+        }
     }
     if (ret) {
         /* Could be preallocation or a notifier populated memory. */
@@ -620,6 +732,7 @@ static void virtio_mem_resize_usable_region(VirtIOMEM *vmem,
 
 static int virtio_mem_unplug_all(VirtIOMEM *vmem)
 {
+    const uint64_t region_size = memory_region_size(&vmem->memdev->mr);
     RAMBlock *rb = vmem->memdev->mr.ram_block;
 
     if (vmem->size) {
@@ -634,6 +747,9 @@ static int virtio_mem_unplug_all(VirtIOMEM *vmem)
         bitmap_clear(vmem->bitmap, 0, vmem->bitmap_size);
         vmem->size = 0;
         notifier_list_notify(&vmem->size_change_notifiers, &vmem->size);
+
+        /* Deactivate all memslots after updating the state. */
+        virtio_mem_deactivate_unplugged_memslots(vmem, 0, region_size);
     }
 
     trace_virtio_mem_unplugged_all();
@@ -790,6 +906,43 @@ static void virtio_mem_system_reset(void *opaque)
     virtio_mem_unplug_all(vmem);
 }
 
+static void virtio_mem_prepare_mr(VirtIOMEM *vmem)
+{
+    const uint64_t region_size = memory_region_size(&vmem->memdev->mr);
+
+    assert(!vmem->mr && vmem->dynamic_memslots);
+    vmem->mr = g_new0(MemoryRegion, 1);
+    memory_region_init(vmem->mr, OBJECT(vmem), "virtio-mem",
+                       region_size);
+    vmem->mr->align = memory_region_get_alignment(&vmem->memdev->mr);
+}
+
+static void virtio_mem_prepare_memslots(VirtIOMEM *vmem)
+{
+    const uint64_t region_size = memory_region_size(&vmem->memdev->mr);
+    unsigned int idx;
+
+    g_assert(!vmem->memslots && vmem->nb_memslots && vmem->dynamic_memslots);
+    vmem->memslots = g_new0(MemoryRegion, vmem->nb_memslots);
+
+    /* Initialize our memslots, but don't map them yet. */
+    for (idx = 0; idx < vmem->nb_memslots; idx++) {
+        const uint64_t memslot_offset = idx * vmem->memslot_size;
+        uint64_t memslot_size = vmem->memslot_size;
+        char name[20];
+
+        /* The size of the last memslot might be smaller. */
+        if (idx == vmem->nb_memslots - 1) {
+            memslot_size = region_size - memslot_offset;
+        }
+
+        snprintf(name, sizeof(name), "memslot-%u", idx);
+        memory_region_init_alias(&vmem->memslots[idx], OBJECT(vmem), name,
+                                 &vmem->memdev->mr, memslot_offset,
+                                 memslot_size);
+    }
+}
+
 static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -861,6 +1014,14 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
     vmem->unplugged_inaccessible = ON_OFF_AUTO_ON;
 #endif /* VIRTIO_MEM_HAS_LEGACY_GUESTS */
 
+    if (vmem->dynamic_memslots &&
+        vmem->unplugged_inaccessible != ON_OFF_AUTO_ON) {
+        error_setg(errp, "'%s' property set to 'on' requires '%s' to be 'on'",
+                   VIRTIO_MEM_DYNAMIC_MEMSLOTS_PROP,
+                   VIRTIO_MEM_UNPLUGGED_INACCESSIBLE_PROP);
+        return;
+    }
+
     /*
      * If the block size wasn't configured by the user, use a sane default. This
      * allows using hugetlbfs backends of any page size without manual
@@ -930,6 +1091,25 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
     virtio_init(vdev, VIRTIO_ID_MEM, sizeof(struct virtio_mem_config));
     vmem->vq = virtio_add_queue(vdev, 128, virtio_mem_handle_request);
 
+    /*
+     * With "dynamic-memslots=off" (old behavior) we always map the whole
+     * RAM memory region directly.
+     */
+    if (vmem->dynamic_memslots) {
+        if (!vmem->mr) {
+            virtio_mem_prepare_mr(vmem);
+        }
+        if (vmem->nb_memslots <= 1) {
+            vmem->nb_memslots = 1;
+            vmem->memslot_size = memory_region_size(&vmem->memdev->mr);
+        }
+        if (!vmem->memslots) {
+            virtio_mem_prepare_memslots(vmem);
+        }
+    } else {
+        assert(!vmem->mr && !vmem->nb_memslots && !vmem->memslots);
+    }
+
     host_memory_backend_set_mapped(vmem->memdev, true);
     vmstate_register_ram(&vmem->memdev->mr, DEVICE(vmem));
     if (vmem->early_migration) {
@@ -984,11 +1164,31 @@ static int virtio_mem_restore_unplugged(VirtIOMEM *vmem)
                                                virtio_mem_discard_range_cb);
 }
 
+static int virtio_mem_activate_memslot_range_cb(VirtIOMEM *vmem, void *arg,
+                                                uint64_t offset, uint64_t size)
+{
+    virtio_mem_activate_memslots_to_plug(vmem, offset, size);
+    return 0;
+}
+
 static int virtio_mem_post_load_bitmap(VirtIOMEM *vmem)
 {
     RamDiscardListener *rdl;
     int ret;
 
+    /*
+     * We restored the bitmap and updated the requested size; activate all
+     * memslots (so listeners register) before notifying about plugged blocks.
+     */
+    if (vmem->dynamic_memslots) {
+        /*
+         * We don't expect any active memslots at this point to deactivate: no
+         * memory was plugged on the migration destination.
+         */
+        virtio_mem_for_each_plugged_range(vmem, NULL,
+                                          virtio_mem_activate_memslot_range_cb);
+    }
+
     /*
      * We started out with all memory discarded and our memory region is mapped
      * into an address space. Replay, now that we updated the bitmap.
@@ -1251,11 +1451,79 @@ static MemoryRegion *virtio_mem_get_memory_region(VirtIOMEM *vmem, Error **errp)
     if (!vmem->memdev) {
         error_setg(errp, "'%s' property must be set", VIRTIO_MEM_MEMDEV_PROP);
         return NULL;
+    } else if (vmem->dynamic_memslots) {
+        if (!vmem->mr) {
+            virtio_mem_prepare_mr(vmem);
+        }
+        return vmem->mr;
     }
 
     return &vmem->memdev->mr;
 }
 
+static void virtio_mem_decide_memslots(VirtIOMEM *vmem, unsigned int limit)
+{
+    uint64_t region_size, memslot_size, min_memslot_size;
+    unsigned int memslots;
+    RAMBlock *rb;
+
+    if (!vmem->dynamic_memslots) {
+        return;
+    }
+
+    /* We're called exactly once, before realizing the device. */
+    assert(!vmem->nb_memslots);
+
+    /* If realizing the device will fail, just assume a single memslot. */
+    if (limit <= 1 || !vmem->memdev || !vmem->memdev->mr.ram_block) {
+        vmem->nb_memslots = 1;
+        return;
+    }
+
+    rb = vmem->memdev->mr.ram_block;
+    region_size = memory_region_size(&vmem->memdev->mr);
+
+    /*
+     * Determine the default block size now, to determine the minimum memslot
+     * size. We want the minimum slot size to be at least the device block size.
+     */
+    if (!vmem->block_size) {
+        vmem->block_size = virtio_mem_default_block_size(rb);
+    }
+    /* If realizing the device will fail, just assume a single memslot. */
+    if (vmem->block_size < qemu_ram_pagesize(rb) ||
+        !QEMU_IS_ALIGNED(region_size, vmem->block_size)) {
+        vmem->nb_memslots = 1;
+        return;
+    }
+
+    /*
+     * All memslots except the last one have a reasonable minimum size, and
+     * and all memslot sizes are aligned to the device block size.
+     */
+    memslot_size = QEMU_ALIGN_UP(region_size / limit, vmem->block_size);
+    min_memslot_size = MAX(vmem->block_size, VIRTIO_MEM_MIN_MEMSLOT_SIZE);
+    memslot_size = MAX(memslot_size, min_memslot_size);
+
+    memslots = QEMU_ALIGN_UP(region_size, memslot_size) / memslot_size;
+    if (memslots != 1) {
+        vmem->memslot_size = memslot_size;
+    }
+    vmem->nb_memslots = memslots;
+}
+
+static unsigned int virtio_mem_get_memslots(VirtIOMEM *vmem)
+{
+    if (!vmem->dynamic_memslots) {
+        /* Exactly one static RAM memory region. */
+        return 1;
+    }
+
+    /* We're called after instructed to make a decision. */
+    g_assert(vmem->nb_memslots);
+    return vmem->nb_memslots;
+}
+
 static void virtio_mem_add_size_change_notifier(VirtIOMEM *vmem,
                                                 Notifier *notifier)
 {
@@ -1393,6 +1661,21 @@ static void virtio_mem_instance_init(Object *obj)
                         NULL, NULL);
 }
 
+static void virtio_mem_instance_finalize(Object *obj)
+{
+    VirtIOMEM *vmem = VIRTIO_MEM(obj);
+
+    /*
+     * Note: the core already dropped the references on all memory regions
+     * (it's passed as the owner to memory_region_init_*()) and finalized
+     * these objects. We can simply free the memory.
+     */
+    g_free(vmem->memslots);
+    vmem->memslots = NULL;
+    g_free(vmem->mr);
+    vmem->mr = NULL;
+}
+
 static Property virtio_mem_properties[] = {
     DEFINE_PROP_UINT64(VIRTIO_MEM_ADDR_PROP, VirtIOMEM, addr, 0),
     DEFINE_PROP_UINT32(VIRTIO_MEM_NODE_PROP, VirtIOMEM, node, 0),
@@ -1405,6 +1688,8 @@ static Property virtio_mem_properties[] = {
 #endif
     DEFINE_PROP_BOOL(VIRTIO_MEM_EARLY_MIGRATION_PROP, VirtIOMEM,
                      early_migration, true),
+    DEFINE_PROP_BOOL(VIRTIO_MEM_DYNAMIC_MEMSLOTS_PROP, VirtIOMEM,
+                     dynamic_memslots, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -1572,6 +1857,8 @@ static void virtio_mem_class_init(ObjectClass *klass, void *data)
 
     vmc->fill_device_info = virtio_mem_fill_device_info;
     vmc->get_memory_region = virtio_mem_get_memory_region;
+    vmc->decide_memslots = virtio_mem_decide_memslots;
+    vmc->get_memslots = virtio_mem_get_memslots;
     vmc->add_size_change_notifier = virtio_mem_add_size_change_notifier;
     vmc->remove_size_change_notifier = virtio_mem_remove_size_change_notifier;
     vmc->unplug_request_check = virtio_mem_unplug_request_check;
@@ -1589,6 +1876,7 @@ static const TypeInfo virtio_mem_info = {
     .parent = TYPE_VIRTIO_DEVICE,
     .instance_size = sizeof(VirtIOMEM),
     .instance_init = virtio_mem_instance_init,
+    .instance_finalize = virtio_mem_instance_finalize,
     .class_init = virtio_mem_class_init,
     .class_size = sizeof(VirtIOMEMClass),
     .interfaces = (InterfaceInfo[]) {
diff --git a/include/hw/virtio/virtio-mem.h b/include/hw/virtio/virtio-mem.h
index ab0fe2b4f2..5f5b02b8f9 100644
--- a/include/hw/virtio/virtio-mem.h
+++ b/include/hw/virtio/virtio-mem.h
@@ -33,6 +33,7 @@ OBJECT_DECLARE_TYPE(VirtIOMEM, VirtIOMEMClass,
 #define VIRTIO_MEM_UNPLUGGED_INACCESSIBLE_PROP "unplugged-inaccessible"
 #define VIRTIO_MEM_EARLY_MIGRATION_PROP "x-early-migration"
 #define VIRTIO_MEM_PREALLOC_PROP "prealloc"
+#define VIRTIO_MEM_DYNAMIC_MEMSLOTS_PROP "dynamic-memslots"
 
 struct VirtIOMEM {
     VirtIODevice parent_obj;
@@ -44,7 +45,28 @@ struct VirtIOMEM {
     int32_t bitmap_size;
     unsigned long *bitmap;
 
-    /* assigned memory backend and memory region */
+    /*
+     * With "dynamic-memslots=on": Device memory region in which we dynamically
+     * map the memslots.
+     */
+    MemoryRegion *mr;
+
+    /*
+     * With "dynamic-memslots=on": The individual memslots (aliases into the
+     * memory backend).
+     */
+    MemoryRegion *memslots;
+
+    /* With "dynamic-memslots=on": The total number of memslots. */
+    uint16_t nb_memslots;
+
+    /*
+     * With "dynamic-memslots=on": Size of one memslot (the size of the
+     * last one can differ).
+     */
+    uint64_t memslot_size;
+
+    /* Assigned memory backend with the RAM memory region. */
     HostMemoryBackend *memdev;
 
     /* NUMA node */
@@ -82,6 +104,12 @@ struct VirtIOMEM {
      */
     bool early_migration;
 
+    /*
+     * Whether we dynamically map (multiple, if possible) memslots instead of
+     * statically mapping the whole RAM memory region.
+     */
+    bool dynamic_memslots;
+
     /* notifiers to notify when "size" changes */
     NotifierList size_change_notifiers;
 
@@ -96,6 +124,8 @@ struct VirtIOMEMClass {
     /* public */
     void (*fill_device_info)(const VirtIOMEM *vmen, VirtioMEMDeviceInfo *vi);
     MemoryRegion *(*get_memory_region)(VirtIOMEM *vmem, Error **errp);
+    void (*decide_memslots)(VirtIOMEM *vmem, unsigned int limit);
+    unsigned int (*get_memslots)(VirtIOMEM *vmem);
     void (*add_size_change_notifier)(VirtIOMEM *vmem, Notifier *notifier);
     void (*remove_size_change_notifier)(VirtIOMEM *vmem, Notifier *notifier);
     void (*unplug_request_check)(VirtIOMEM *vmem, Error **errp);
-- 
2.41.0


