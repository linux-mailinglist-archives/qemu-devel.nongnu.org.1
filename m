Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A28F0732B8A
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 11:29:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA5k2-00054D-N1; Fri, 16 Jun 2023 05:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qA5k0-00053n-Mx
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 05:27:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qA5jz-0000Kp-1W
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 05:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686907654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qXmqZ0NqwuS8jR7uBp7mMBXLm/o6YAZgNQHf3c5IcyA=;
 b=c2BDILUbew07yf/aeOHz1J9SJljmXzyrc6iCNxGUsEYWwoyP9uyOwOu5p0HQzjTLfkI05B
 mwG1aY5HPUsIs3JPmjF//UfGJcJ+FBTmJp7i2H+qNJ7SOBj3RTvHu9zcemcKMS8Rr89SaK
 c4djHpfh8m4iLeGuhExwctpBGVnYhvA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-HSZbfOTJO9arMAKckwDhAw-1; Fri, 16 Jun 2023 05:27:32 -0400
X-MC-Unique: HSZbfOTJO9arMAKckwDhAw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 638198028AF;
 Fri, 16 Jun 2023 09:27:32 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.194.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EE4E1121314;
 Fri, 16 Jun 2023 09:27:29 +0000 (UTC)
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
Subject: [PATCH v1 07/15] memory-device: Support memory devices that
 statically consume multiple memslots
Date: Fri, 16 Jun 2023 11:26:46 +0200
Message-Id: <20230616092654.175518-8-david@redhat.com>
In-Reply-To: <20230616092654.175518-1-david@redhat.com>
References: <20230616092654.175518-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

We want to support memory devices that have a memory region container as
device memory region where they statically map multiple RAM memory
regions.

We already have one device that uses a container as device memory region:
NVDIMMs. However, a NVDIMM always ends up consuming exactly one memslot.

Let's add support for that by asking the memory device via a new
callback how many memslots it consumes.

While at it in memory_device_check_addable(), perform the region size
check first and don't check separately for KVM and vhost, both things will
come in handy later.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c         | 46 +++++++++++++++++++++++-----------
 include/hw/mem/memory-device.h | 18 +++++++++++++
 2 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 2f19183a25..a9dcc0c4ef 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -82,6 +82,12 @@ static unsigned int get_max_memslots(void)
     return MIN(vhost_get_max_memslots(), kvm_get_max_memslots());
 }
 
+/* Overall number of free memslots */
+static unsigned int get_free_memslots(void)
+{
+    return MIN(vhost_get_free_memslots(), kvm_get_free_memslots());
+}
+
 /*
  * The memslot soft limit for memory devices. The soft limit might change at
  * runtime in corner cases (that should certainly be avoided), for example, when
@@ -126,21 +132,23 @@ void memory_devices_notify_vhost_device_added(void)
     memory_devices_check_memslot_soft_limit(ms);
 }
 
-static void memory_device_check_addable(MachineState *ms, MemoryRegion *mr,
-                                        Error **errp)
+static unsigned int memory_device_get_memslots(MemoryDeviceState *md)
 {
-    const uint64_t used_region_size = ms->device_memory->used_region_size;
-    const uint64_t size = memory_region_size(mr);
+    const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
 
-    /* we will need a new memory slot for kvm and vhost */
-    if (!kvm_get_free_memslots()) {
-        error_setg(errp, "hypervisor has no free memory slots left");
-        return;
-    }
-    if (!vhost_get_free_memslots()) {
-        error_setg(errp, "a used vhost backend has no free memory slots left");
-        return;
+    if (mdc->get_memslots) {
+        return mdc->get_memslots(md);
     }
+    return 1;
+}
+
+static void memory_device_check_addable(MachineState *ms, MemoryDeviceState *md,
+                                        MemoryRegion *mr, Error **errp)
+{
+    const uint64_t used_region_size = ms->device_memory->used_region_size;
+    const unsigned int available_memslots = get_free_memslots();
+    const uint64_t size = memory_region_size(mr);
+    unsigned int required_memslots;
 
     /* will we exceed the total amount of memory specified */
     if (used_region_size + size < used_region_size ||
@@ -151,6 +159,14 @@ static void memory_device_check_addable(MachineState *ms, MemoryRegion *mr,
         return;
     }
 
+    /* ... are there still sufficient memslots available? */
+    required_memslots = memory_device_get_memslots(md);
+    if (available_memslots < required_memslots) {
+        error_setg(errp, "Insufficient memory slots for memory device"
+                   "available. Available: %u, Required: %u",
+                   available_memslots, required_memslots);
+        return;
+    }
 }
 
 static uint64_t memory_device_get_free_addr(MachineState *ms,
@@ -307,7 +323,7 @@ void memory_device_pre_plug(MemoryDeviceState *md, MachineState *ms,
         goto out;
     }
 
-    memory_device_check_addable(ms, mr, &local_err);
+    memory_device_check_addable(ms, md, mr, &local_err);
     if (local_err) {
         goto out;
     }
@@ -349,7 +365,7 @@ void memory_device_plug(MemoryDeviceState *md, MachineState *ms)
     g_assert(ms->device_memory);
 
     ms->device_memory->used_region_size += memory_region_size(mr);
-    ms->device_memory->required_memslots++;
+    ms->device_memory->required_memslots += memory_device_get_memslots(md);
     memory_devices_check_memslot_soft_limit(ms);
     memory_region_add_subregion(&ms->device_memory->mr,
                                 addr - ms->device_memory->base, mr);
@@ -370,7 +386,7 @@ void memory_device_unplug(MemoryDeviceState *md, MachineState *ms)
 
     memory_region_del_subregion(&ms->device_memory->mr, mr);
     ms->device_memory->used_region_size -= memory_region_size(mr);
-    ms->device_memory->required_memslots--;
+    ms->device_memory->required_memslots -= memory_device_get_memslots(md);
     trace_memory_device_unplug(DEVICE(md)->id ? DEVICE(md)->id : "",
                                mdc->get_addr(md));
 }
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 813c3b9da6..755f6304c6 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -42,6 +42,11 @@ typedef struct MemoryDeviceState MemoryDeviceState;
  * successive memory regions are used, a covering memory region has to
  * be provided. Scattered memory regions are not supported for single
  * devices.
+ *
+ * The device memory region returned via @get_memory_region may either be a
+ * single RAM/ROM memory region or a memory region container with subregions
+ * that are RAM/ROM memory regions or aliases to RAM/ROM memory regions. Other
+ * memory regions or subregions are not supported.
  */
 struct MemoryDeviceClass {
     /* private */
@@ -89,6 +94,19 @@ struct MemoryDeviceClass {
      */
     MemoryRegion *(*get_memory_region)(MemoryDeviceState *md, Error **errp);
 
+    /*
+     * Optional for memory devices that consume only a single memslot,
+     * required for all other memory devices: Return the number of memslots
+     * (distinct RAM memory regions in the device memory region) that are
+     * required by the device.
+     *
+     * If this function is not implemented, the assumption is "1".
+     *
+     * Called when (un)plugging the memory device, to check if the requirements
+     * can be satisfied, and to do proper accounting.
+     */
+    unsigned int (*get_memslots)(MemoryDeviceState *md);
+
     /*
      * Optional: Return the desired minimum alignment of the device in guest
      * physical address space. The final alignment is computed based on this
-- 
2.40.1


