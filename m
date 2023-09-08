Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED42798896
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 16:23:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qecNC-0001UK-VB; Fri, 08 Sep 2023 10:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qecNB-0001QP-5w
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:22:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qecN6-0001gx-6n
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694182927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IcjRBlX23B58QlEcv5JOZ+Baolj2SxlkLTfiV4y7RyI=;
 b=HMUGXfsIPG/mhdK9VP37Sw8ExfQLU6EkOeI6Ng/MPvJQ/PYvrE/Vj0AFoDhYSMDmGPPbBu
 dwx+YlVIAs7XBD12IcWS3n7Gm1qQ0zs39k2KNf/yQ2+UK8OrilsByyjC0Ke/z2AQ62Z1SE
 Ynd+DcM+NFEB6HfKHK8bkUorRfHShcw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-016hA699OFCXNjq0SAiorw-1; Fri, 08 Sep 2023 10:22:04 -0400
X-MC-Unique: 016hA699OFCXNjq0SAiorw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0CAB816525;
 Fri,  8 Sep 2023 14:22:03 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A20AC03295;
 Fri,  8 Sep 2023 14:22:00 +0000 (UTC)
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
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, kvm@vger.kernel.org
Subject: [PATCH v3 08/16] memory-device: Track required and actually used
 memslots in DeviceMemoryState
Date: Fri,  8 Sep 2023 16:21:28 +0200
Message-ID: <20230908142136.403541-9-david@redhat.com>
In-Reply-To: <20230908142136.403541-1-david@redhat.com>
References: <20230908142136.403541-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

Let's track how many memslots are required by plugged memory devices and
how many are currently actually getting used by plugged memory
devices.

"required - used" is the number of reserved memslots. For now, the number
of used and required memslots is always equal, and there are no
reservations. This is a preparation for memory devices that want to
dynamically consume memslots after initially specifying how many they
require -- where we'll end up with reserved memslots.

To track the number of used memslots, create a new address space for
our device memory and register a memory listener (add/remove) for that
address space.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c | 54 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/boards.h    | 10 +++++++-
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 0eec0872a9..d37cfbd65d 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -286,6 +286,7 @@ void memory_device_plug(MemoryDeviceState *md, MachineState *ms)
     g_assert(ms->device_memory);
 
     ms->device_memory->used_region_size += memory_region_size(mr);
+    ms->device_memory->required_memslots += memory_device_get_memslots(md);
     memory_region_add_subregion(&ms->device_memory->mr,
                                 addr - ms->device_memory->base, mr);
     trace_memory_device_plug(DEVICE(md)->id ? DEVICE(md)->id : "", addr);
@@ -305,6 +306,7 @@ void memory_device_unplug(MemoryDeviceState *md, MachineState *ms)
 
     memory_region_del_subregion(&ms->device_memory->mr, mr);
     ms->device_memory->used_region_size -= memory_region_size(mr);
+    ms->device_memory->required_memslots -= memory_device_get_memslots(md);
     trace_memory_device_unplug(DEVICE(md)->id ? DEVICE(md)->id : "",
                                mdc->get_addr(md));
 }
@@ -324,6 +326,50 @@ uint64_t memory_device_get_region_size(const MemoryDeviceState *md,
     return memory_region_size(mr);
 }
 
+static void memory_devices_region_mod(MemoryListener *listener,
+                                      MemoryRegionSection *mrs, bool add)
+{
+    DeviceMemoryState *dms = container_of(listener, DeviceMemoryState,
+                                          listener);
+
+    if (!memory_region_is_ram(mrs->mr)) {
+        warn_report("Unexpected memory region mapped into device memory region.");
+        return;
+    }
+
+    /*
+     * The expectation is that each distinct RAM memory region section in
+     * our region for memory devices consumes exactly one memslot in KVM
+     * and in vhost. For vhost, this is true, except:
+     * * ROM memory regions don't consume a memslot. These get used very
+     *   rarely for memory devices (R/O NVDIMMs).
+     * * Memslots without a fd (memory-backend-ram) don't necessarily
+     *   consume a memslot. Such setups are quite rare and possibly bogus:
+     *   the memory would be inaccessible by such vhost devices.
+     *
+     * So for vhost, in corner cases we might over-estimate the number of
+     * memslots that are currently used or that might still be reserved
+     * (required - used).
+     */
+    dms->used_memslots += add ? 1 : -1;
+
+    if (dms->used_memslots > dms->required_memslots) {
+        warn_report("Memory devices use more memory slots than indicated as required.");
+    }
+}
+
+static void memory_devices_region_add(MemoryListener *listener,
+                                      MemoryRegionSection *mrs)
+{
+    return memory_devices_region_mod(listener, mrs, true);
+}
+
+static void memory_devices_region_del(MemoryListener *listener,
+                                      MemoryRegionSection *mrs)
+{
+    return memory_devices_region_mod(listener, mrs, false);
+}
+
 void machine_memory_devices_init(MachineState *ms, hwaddr base, uint64_t size)
 {
     g_assert(size);
@@ -333,8 +379,16 @@ void machine_memory_devices_init(MachineState *ms, hwaddr base, uint64_t size)
 
     memory_region_init(&ms->device_memory->mr, OBJECT(ms), "device-memory",
                        size);
+    address_space_init(&ms->device_memory->as, &ms->device_memory->mr,
+                       "device-memory");
     memory_region_add_subregion(get_system_memory(), ms->device_memory->base,
                                 &ms->device_memory->mr);
+
+    /* Track the number of memslots used by memory devices. */
+    ms->device_memory->listener.region_add = memory_devices_region_add;
+    ms->device_memory->listener.region_del = memory_devices_region_del;
+    memory_listener_register(&ms->device_memory->listener,
+                             &ms->device_memory->as);
 }
 
 static const TypeInfo memory_device_info = {
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 3b541ffd24..e344ded607 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -296,15 +296,23 @@ struct MachineClass {
  * DeviceMemoryState:
  * @base: address in guest physical address space where the memory
  * address space for memory devices starts
- * @mr: address space container for memory devices
+ * @mr: memory region container for memory devices
+ * @as: address space for memory devices
+ * @listener: memory listener used to track used memslots in the address space
  * @dimm_size: the sum of plugged DIMMs' sizes
  * @used_region_size: the part of @mr already used by memory devices
+ * @required_memslots: the number of memslots required by memory devices
+ * @used_memslots: the number of memslots currently used by memory devices
  */
 typedef struct DeviceMemoryState {
     hwaddr base;
     MemoryRegion mr;
+    AddressSpace as;
+    MemoryListener listener;
     uint64_t dimm_size;
     uint64_t used_region_size;
+    unsigned int required_memslots;
+    unsigned int used_memslots;
 } DeviceMemoryState;
 
 /**
-- 
2.41.0


