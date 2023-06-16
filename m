Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AAE732B80
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 11:28:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA5k9-00055X-9T; Fri, 16 Jun 2023 05:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qA5k6-00054y-Vn
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 05:27:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qA5k5-0000LV-CV
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 05:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686907660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rxp9aQJbdO7YPukV3KcasUUlhaPToacJ7ZXPjhPwib0=;
 b=R09UEFCnVHfHeY5dMmfgAMnevMfWARGrGs3+vrKBSCaOZ8MoWCudSZk4DY9/ocyyYk5yV7
 OtU+NsvUWnBDMUMZafdg1b3uRYJEQ72KNdpskoQS5sRqFBWTkPmQ/kJNhPw1zcnkROqDcR
 mD4TO6FkAUz3soxH1Jh04ksvfs/Imro=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-1LEM7-YGMkiXaoy7aMfVRA-1; Fri, 16 Jun 2023 05:27:36 -0400
X-MC-Unique: 1LEM7-YGMkiXaoy7aMfVRA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F17885A5AA;
 Fri, 16 Jun 2023 09:27:36 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.194.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C26E91121314;
 Fri, 16 Jun 2023 09:27:32 +0000 (UTC)
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
Subject: [PATCH v1 08/15] memory-device: Track the actually used memslots in
 DeviceMemoryState
Date: Fri, 16 Jun 2023 11:26:47 +0200
Message-Id: <20230616092654.175518-9-david@redhat.com>
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

Let's track how many memslots are currently getting used by memory
devices in the device memory region, and how many could be used at
maximum ("required"). "required - used" is the number of reserved memslots
that will get used in the future: we'll have to consider them when plugging
new vhost devices or new memory devices.

For now, the number of used and required memslots is always equal and
directly matches the number of memory devices. This is a preparation for
memory devices that want to dynamically consume memslots at runtime.

To track the number of used memslots, create a new address space for
our device memory and register a memory listener (add/remove) for that
address space.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c | 52 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/boards.h    |  8 ++++++-
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index a9dcc0c4ef..752258333b 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -406,6 +406,50 @@ uint64_t memory_device_get_region_size(const MemoryDeviceState *md,
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
@@ -415,8 +459,16 @@ void machine_memory_devices_init(MachineState *ms, hwaddr base, uint64_t size)
 
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
index a346b4ec4a..dcb6dc83ec 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -294,17 +294,23 @@ struct MachineClass {
  * DeviceMemoryState:
  * @base: address in guest physical address space where the memory
  * address space for memory devices starts
- * @mr: address space container for memory devices
+ * @mr: memory region container for memory devices
+ * @as: address space for memory devices
+ * @listener: memory listener used to track used memslots in the addres space
  * @dimm_size: the sum of plugged DIMMs' sizes
  * @used_region_size: the part of @mr already used by memory devices
  * @required_memslots: the number of memslots required by memory devices
+ * @used_memslots: the number of memslots currently used by memory devices
  */
 typedef struct DeviceMemoryState {
     hwaddr base;
     MemoryRegion mr;
+    AddressSpace as;
+    MemoryListener listener;
     uint64_t dimm_size;
     uint64_t used_region_size;
     unsigned int required_memslots;
+    unsigned int used_memslots;
 } DeviceMemoryState;
 
 /**
-- 
2.40.1


