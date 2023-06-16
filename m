Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB34D732B83
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 11:28:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA5kH-0005Af-J0; Fri, 16 Jun 2023 05:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qA5kF-0005AD-Rc
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 05:27:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qA5kE-0000MP-62
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 05:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686907669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hAWEbuOoJIfCBYKOU4fdhfU8su5N6z8gqggRVHf2zIk=;
 b=h6RuUbyDOPWAxzqLTcjXZM0AJWKaIJBSjawvDYuK2vU8JP8xmj5mia+HFecl9IHC+MhZcC
 WbBLd/CxTr9c/OEryyOsI4dgAGnTiOyj2KyN9tM7bcg1ntHKc1UHifkAycuo9xVozBAshX
 hWtqkvl1PldlSNOigMJWOQekevleb5s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-278-nxneG7QxNQGHyfmE1QxJwg-1; Fri, 16 Jun 2023 05:27:46 -0400
X-MC-Unique: nxneG7QxNQGHyfmE1QxJwg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C951680123E;
 Fri, 16 Jun 2023 09:27:45 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.194.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 998921121314;
 Fri, 16 Jun 2023 09:27:42 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Michal Privoznik <mprivozn@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gavin Shan <gshan@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v1 11/15] memory-device: Support memory-devices with
 auto-detection of the number of memslots
Date: Fri, 16 Jun 2023 11:26:50 +0200
Message-Id: <20230616092654.175518-12-david@redhat.com>
In-Reply-To: <20230616092654.175518-1-david@redhat.com>
References: <20230616092654.175518-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We want to support memory devices that detect at runtime how many
memslots they will use. The target use case is virtio-mem.

Let's suggest a memslot limit to the device, such that the device can
use that number to determine the number of memslots it wants to use.

To make a sane suggestion that doesn't cause trouble elsewhere, implement
a heuristic that considers
* The memslot soft-limit for all memory devices
* Unpopulated DIMM slots
* Actually still free and not reserved memslots
* The percentage of the remaining device memory region that memory device
  will occupy.

For example, if existing memory devices require 100 memslots, we have
>= 256 free (and not reserved) memslot and we have 28 unpopulated DIMM
slots, a device that occupies half of the device memory region would get a
suggestion of (256 - 100 - 28) * 1/2 = 64. [note that our soft-limit is
256]

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c         | 66 +++++++++++++++++++++++++++++++++-
 include/hw/mem/memory-device.h | 10 ++++++
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 2e6536c841..3099d346d7 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "hw/mem/memory-device.h"
+#include "hw/mem/pc-dimm.h"
 #include "qapi/error.h"
 #include "hw/boards.h"
 #include "qemu/range.h"
@@ -166,6 +167,16 @@ void memory_devices_notify_vhost_device_added(void)
     memory_devices_check_memslot_soft_limit(ms);
 }
 
+static void memory_device_set_suggested_memslot_limit(MemoryDeviceState *md,
+                                                      unsigned int limit)
+{
+    const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
+
+    if (mdc->set_suggested_memslot_limit) {
+        mdc->set_suggested_memslot_limit(md, limit);
+    }
+}
+
 static unsigned int memory_device_get_memslots(MemoryDeviceState *md)
 {
     const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
@@ -176,13 +187,58 @@ static unsigned int memory_device_get_memslots(MemoryDeviceState *md)
     return 1;
 }
 
+/*
+ * Suggested maximum number of memslots for a memory device with the given
+ * region size. Not exceeding this number will make most setups not run
+ * into the soft limit or even out of available memslots, even when multiple
+ * memory devices automatically determine the number of memslots to use.
+ */
+static unsigned int memory_device_suggested_memslot_limit(MachineState *ms,
+                                                          MemoryRegion *mr)
+{
+    const unsigned int soft_limit = memory_devices_memslot_soft_limit(ms);
+    const unsigned int free_dimm_slots = pc_dimm_get_free_slots(ms);
+    const uint64_t size = memory_region_size(mr);
+    uint64_t available_space;
+    unsigned int memslots;
+
+    /* Consider the soft-limit for all memory devices. */
+    if (soft_limit <= ms->device_memory->required_memslots) {
+        return 1;
+    }
+    memslots = soft_limit - ms->device_memory->required_memslots;
+
+    /* Consider the actually available memslots. */
+    memslots = MIN(memslots, get_available_memslots(ms));
+
+    /* It's the single memory device? We cannot plug something else. */
+    if (size == ms->maxram_size - ms->ram_size) {
+        return memslots;
+    }
+
+    /* Try setting one memmemslots for each empty DIMM slot aside. */
+    if (memslots <= free_dimm_slots) {
+        return 1;
+    }
+    memslots -= free_dimm_slots;
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
     const uint64_t used_region_size = ms->device_memory->used_region_size;
     const unsigned int available_memslots = get_available_memslots(ms);
     const uint64_t size = memory_region_size(mr);
-    unsigned int required_memslots;
+    unsigned int required_memslots, suggested_memslot_limit;
 
     /* will we exceed the total amount of memory specified */
     if (used_region_size + size < used_region_size ||
@@ -193,6 +249,14 @@ static void memory_device_check_addable(MachineState *ms, MemoryDeviceState *md,
         return;
     }
 
+    /*
+     * Determine the per-device memslot limit for this device and
+     * communicate it to the device such that it can determine the number
+     * of memslots to use before we query them.
+     */
+    suggested_memslot_limit = memory_device_suggested_memslot_limit(ms, mr);
+    memory_device_set_suggested_memslot_limit(md, suggested_memslot_limit);
+
     /* ... are there still sufficient memslots available? */
     required_memslots = memory_device_get_memslots(md);
     if (available_memslots < required_memslots) {
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 7e8e4452cb..c09a2f0a7c 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -100,6 +100,16 @@ struct MemoryDeviceClass {
      */
     MemoryRegion *(*get_memory_region)(MemoryDeviceState *md, Error **errp);
 
+    /*
+     * Optional: Set the suggested memslot limit, such that a device than
+     * can auto-detect the number of memslots to use based on this limit.
+     *
+     * Called exactly once when pre-plugging the memory device, before
+     * querying the number of memslots using @get_memslots the first time.
+     */
+    void (*set_suggested_memslot_limit)(MemoryDeviceState *md,
+                                        unsigned int limit);
+
     /*
      * Optional for memory devices that consume only a single memslot,
      * required for all other memory devices: Return the number of memslots
-- 
2.40.1


