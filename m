Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 441B87C7073
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:38:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqwof-0003N5-3t; Thu, 12 Oct 2023 10:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qqwoc-0003Cc-KU
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:37:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qqwoN-0005gf-3h
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697121434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q9uPUoCGZxs8OWNV1ZrMfmnR1pgnjx2J5ggpM4pCF6M=;
 b=WDpldYssJxGlk5MQwF/87Ba9rbnhMzYsW9koOdH1P6qenBu4Lgu2CGmSkDPAVjHpUb8UKt
 Tt5nzKAj50H5JBjVzwAiI1jEfv9BaEQXAEWzpxexqAj9UYBAnkHwxRVYwglu+LfeIXYz9c
 ethvto6qgejj1LJPvu/bsU8x+ToUsys=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-DWKmUp__O2uyDuVR9_XvuA-1; Thu, 12 Oct 2023 10:37:11 -0400
X-MC-Unique: DWKmUp__O2uyDuVR9_XvuA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9E6E104D99E;
 Thu, 12 Oct 2023 14:37:10 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BEB261C06534;
 Thu, 12 Oct 2023 14:37:09 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [GIT PULL 12/18] memory-device,
 vhost: Support automatic decision on the number of memslots
Date: Thu, 12 Oct 2023 16:36:49 +0200
Message-ID: <20231012143655.114631-13-david@redhat.com>
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

We want to support memory devices that can automatically decide how many
memslots they will use. In the worst case, they have to use a single
memslot.

The target use cases are virtio-mem and the hyper-v balloon.

Let's calculate a reasonable limit such a memory device may use, and
instruct the device to make a decision based on that limit. Use a simple
heuristic that considers:
* A memslot soft-limit for all memory devices of 256; also, to not
  consume too many memslots -- which could harm performance.
* Actually still free and unreserved memslots
* The percentage of the remaining device memory region that memory device
  will occupy.

Further, while we properly check before plugging a memory device whether
there still is are free memslots, we have other memslot consumers (such as
boot memory, PCI BARs) that don't perform any checks and might dynamically
consume memslots without any prior reservation. So we might succeed in
plugging a memory device, but once we dynamically map a PCI BAR we would
be in trouble. Doing accounting / reservation / checks for all such
users is problematic (e.g., sometimes we might temporarily split boot
memory into two memslots, triggered by the BIOS).

We use the historic magic memslot number of 509 as orientation to when
supporting 256 memory devices -> memslots (leaving 253 for boot memory and
other devices) has been proven to work reliable. We'll fallback to
suggesting a single memslot if we don't have at least 509 total memslots.

Plugging vhost devices with less than 509 memslots available while we
have memory devices plugged that consume multiple memslots due to
automatic decisions can be problematic. Most configurations might just fail
due to "limit < used + reserved", however, it can also happen that these
memory devices would suddenly consume memslots that would actually be
required by other memslot consumers (boot, PCI BARs) later. Note that this
has always been sketchy with vhost devices that support only a small number
of memslots; but we don't want to make it any worse.So let's keep it simple
and simply reject plugging such vhost devices in such a configuration.

Eventually, all vhost devices that want to be fully compatible with such
memory devices should support a decent number of memslots (>= 509).

Message-ID: <20230926185738.277351-13-david@redhat.com>
Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c         | 96 ++++++++++++++++++++++++++++++++--
 hw/virtio/vhost.c              | 14 ++++-
 include/hw/boards.h            |  4 ++
 include/hw/mem/memory-device.h | 32 ++++++++++++
 stubs/memory_device.c          |  5 ++
 5 files changed, 147 insertions(+), 4 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 1b14ba5661..ae38f48f16 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -85,13 +85,93 @@ unsigned int memory_devices_get_reserved_memslots(void)
     return get_reserved_memslots(current_machine);
 }
 
+bool memory_devices_memslot_auto_decision_active(void)
+{
+    if (!current_machine->device_memory) {
+        return false;
+    }
+
+    return current_machine->device_memory->memslot_auto_decision_active;
+}
+
+static unsigned int memory_device_memslot_decision_limit(MachineState *ms,
+                                                         MemoryRegion *mr)
+{
+    const unsigned int reserved = get_reserved_memslots(ms);
+    const uint64_t size = memory_region_size(mr);
+    unsigned int max = vhost_get_max_memslots();
+    unsigned int free = vhost_get_free_memslots();
+    uint64_t available_space;
+    unsigned int memslots;
+
+    if (kvm_enabled()) {
+        max = MIN(max, kvm_get_max_memslots());
+        free = MIN(free, kvm_get_free_memslots());
+    }
+
+    /*
+     * If we only have less overall memslots than what we consider reasonable,
+     * just keep it to a minimum.
+     */
+    if (max < MEMORY_DEVICES_SAFE_MAX_MEMSLOTS) {
+        return 1;
+    }
+
+    /*
+     * Consider our soft-limit across all memory devices. We don't really
+     * expect to exceed this limit in reasonable configurations.
+     */
+    if (MEMORY_DEVICES_SOFT_MEMSLOT_LIMIT <=
+        ms->device_memory->required_memslots) {
+        return 1;
+    }
+    memslots = MEMORY_DEVICES_SOFT_MEMSLOT_LIMIT -
+               ms->device_memory->required_memslots;
+
+    /*
+     * Consider the actually still free memslots. This is only relevant if
+     * other memslot consumers would consume *significantly* more memslots than
+     * what we prepared for (> 253). Unlikely, but let's just handle it
+     * cleanly.
+     */
+    memslots = MIN(memslots, free - reserved);
+    if (memslots < 1 || unlikely(free < reserved)) {
+        return 1;
+    }
+
+    /* We cannot have any other memory devices? So give all to this device. */
+    if (size == ms->maxram_size - ms->ram_size) {
+        return memslots;
+    }
+
+    /*
+     * Simple heuristic: equally distribute the memslots over the space
+     * still available for memory devices.
+     */
+    available_space = ms->maxram_size - ms->ram_size -
+                      ms->device_memory->used_region_size;
+    memslots = (double)memslots * size / available_space;
+    return memslots < 1 ? 1 : memslots;
+}
+
 static void memory_device_check_addable(MachineState *ms, MemoryDeviceState *md,
                                         MemoryRegion *mr, Error **errp)
 {
+    const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
     const uint64_t used_region_size = ms->device_memory->used_region_size;
     const uint64_t size = memory_region_size(mr);
-    const unsigned int required_memslots = memory_device_get_memslots(md);
     const unsigned int reserved_memslots = get_reserved_memslots(ms);
+    unsigned int required_memslots, memslot_limit;
+
+    /*
+     * Instruct the device to decide how many memslots to use, if applicable,
+     * before we query the number of required memslots the first time.
+     */
+    if (mdc->decide_memslots) {
+        memslot_limit = memory_device_memslot_decision_limit(ms, mr);
+        mdc->decide_memslots(md, memslot_limit);
+    }
+    required_memslots = memory_device_get_memslots(md);
 
     /* we will need memory slots for kvm and vhost */
     if (kvm_enabled() &&
@@ -300,6 +380,7 @@ out:
 void memory_device_plug(MemoryDeviceState *md, MachineState *ms)
 {
     const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
+    const unsigned int memslots = memory_device_get_memslots(md);
     const uint64_t addr = mdc->get_addr(md);
     MemoryRegion *mr;
 
@@ -311,7 +392,11 @@ void memory_device_plug(MemoryDeviceState *md, MachineState *ms)
     g_assert(ms->device_memory);
 
     ms->device_memory->used_region_size += memory_region_size(mr);
-    ms->device_memory->required_memslots += memory_device_get_memslots(md);
+    ms->device_memory->required_memslots += memslots;
+    if (mdc->decide_memslots && memslots > 1) {
+        ms->device_memory->memslot_auto_decision_active++;
+    }
+
     memory_region_add_subregion(&ms->device_memory->mr,
                                 addr - ms->device_memory->base, mr);
     trace_memory_device_plug(DEVICE(md)->id ? DEVICE(md)->id : "", addr);
@@ -320,6 +405,7 @@ void memory_device_plug(MemoryDeviceState *md, MachineState *ms)
 void memory_device_unplug(MemoryDeviceState *md, MachineState *ms)
 {
     const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
+    const unsigned int memslots = memory_device_get_memslots(md);
     MemoryRegion *mr;
 
     /*
@@ -330,8 +416,12 @@ void memory_device_unplug(MemoryDeviceState *md, MachineState *ms)
     g_assert(ms->device_memory);
 
     memory_region_del_subregion(&ms->device_memory->mr, mr);
+
+    if (mdc->decide_memslots && memslots > 1) {
+        ms->device_memory->memslot_auto_decision_active--;
+    }
     ms->device_memory->used_region_size -= memory_region_size(mr);
-    ms->device_memory->required_memslots -= memory_device_get_memslots(md);
+    ms->device_memory->required_memslots -= memslots;
     trace_memory_device_unplug(DEVICE(md)->id ? DEVICE(md)->id : "",
                                mdc->get_addr(md));
 }
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 2bdb4fb231..a546a585da 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1462,6 +1462,19 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
+    limit = hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
+    if (limit < MEMORY_DEVICES_SAFE_MAX_MEMSLOTS &&
+        memory_devices_memslot_auto_decision_active()) {
+        error_setg(errp, "some memory device (like virtio-mem)"
+            " decided how many memory slots to use based on the overall"
+            " number of memory slots; this vhost backend would further"
+            " restricts the overall number of memory slots");
+        error_append_hint(errp, "Try plugging this vhost backend before"
+            " plugging such memory devices.\n");
+        r = -EINVAL;
+        goto fail;
+    }
+
     for (i = 0; i < hdev->nvqs; ++i, ++n_initialized_vqs) {
         r = vhost_virtqueue_init(hdev, hdev->vqs + i, hdev->vq_index + i);
         if (r < 0) {
@@ -1548,7 +1561,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
      * but we'll need additional information about the reservations.
      */
     reserved = memory_devices_get_reserved_memslots();
-    limit = hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
     if (used + reserved > limit) {
         error_setg(errp, "vhost backend memory slots limit (%d) is less"
                    " than current number of used (%d) and reserved (%d)"
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 01bddb258f..43a56dc51e 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -304,6 +304,9 @@ struct MachineClass {
  * @used_region_size: the part of @mr already used by memory devices
  * @required_memslots: the number of memslots required by memory devices
  * @used_memslots: the number of memslots currently used by memory devices
+ * @memslot_auto_decision_active: whether any plugged memory device
+ *                                automatically decided to use more than
+ *                                one memslot
  */
 typedef struct DeviceMemoryState {
     hwaddr base;
@@ -314,6 +317,7 @@ typedef struct DeviceMemoryState {
     uint64_t used_region_size;
     unsigned int required_memslots;
     unsigned int used_memslots;
+    unsigned int memslot_auto_decision_active;
 } DeviceMemoryState;
 
 /**
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index c7b624da6a..3354d6c166 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -14,6 +14,7 @@
 #define MEMORY_DEVICE_H
 
 #include "hw/qdev-core.h"
+#include "qemu/typedefs.h"
 #include "qapi/qapi-types-machine.h"
 #include "qom/object.h"
 
@@ -99,6 +100,15 @@ struct MemoryDeviceClass {
      */
     MemoryRegion *(*get_memory_region)(MemoryDeviceState *md, Error **errp);
 
+    /*
+     * Optional: Instruct the memory device to decide how many memory slots
+     * it requires, not exceeding the given limit.
+     *
+     * Called exactly once when pre-plugging the memory device, before
+     * querying the number of memslots using @get_memslots the first time.
+     */
+    void (*decide_memslots)(MemoryDeviceState *md, unsigned int limit);
+
     /*
      * Optional for memory devices that require only a single memslot,
      * required for all other memory devices: Return the number of memslots
@@ -129,9 +139,31 @@ struct MemoryDeviceClass {
                              MemoryDeviceInfo *info);
 };
 
+/*
+ * Traditionally, KVM/vhost in many setups supported 509 memslots, whereby
+ * 253 memslots were "reserved" for boot memory and other devices (such
+ * as PCI BARs, which can get mapped dynamically) and 256 memslots were
+ * dedicated for DIMMs. These magic numbers worked reliably in the past.
+ *
+ * Further, using many memslots can negatively affect performance, so setting
+ * the soft-limit of memslots used by memory devices to the traditional
+ * DIMM limit of 256 sounds reasonable.
+ *
+ * If we have less than 509 memslots, we will instruct memory devices that
+ * support automatically deciding how many memslots to use to only use a single
+ * one.
+ *
+ * Hotplugging vhost devices with at least 509 memslots is not expected to
+ * cause problems, not even when devices automatically decided how many memslots
+ * to use.
+ */
+#define MEMORY_DEVICES_SOFT_MEMSLOT_LIMIT 256
+#define MEMORY_DEVICES_SAFE_MAX_MEMSLOTS 509
+
 MemoryDeviceInfoList *qmp_memory_device_list(void);
 uint64_t get_plugged_memory_size(void);
 unsigned int memory_devices_get_reserved_memslots(void);
+bool memory_devices_memslot_auto_decision_active(void);
 void memory_device_pre_plug(MemoryDeviceState *md, MachineState *ms,
                             const uint64_t *legacy_align, Error **errp);
 void memory_device_plug(MemoryDeviceState *md, MachineState *ms);
diff --git a/stubs/memory_device.c b/stubs/memory_device.c
index 318a5d4187..15fd93ff67 100644
--- a/stubs/memory_device.c
+++ b/stubs/memory_device.c
@@ -15,3 +15,8 @@ unsigned int memory_devices_get_reserved_memslots(void)
 {
     return 0;
 }
+
+bool memory_devices_memslot_auto_decision_active(void)
+{
+    return false;
+}
-- 
2.41.0


