Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EE8732B7E
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 11:28:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA5jv-000526-56; Fri, 16 Jun 2023 05:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qA5jt-00051y-D1
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 05:27:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qA5jr-0000K4-ES
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 05:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686907646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+DiCvZ1Fd9WTKWleBTFdTsPjzpSoNQre35OYeVOvqcg=;
 b=IxTjAeMXSii7Z0EzzOGGyMXcRVBnKBJIhV2kfR3ITF69yXr8xq+QSQs2Xz6gvhLOS44WXo
 B7rKvkD/1TA0CQ/KzVnsEMq8sJhkcUSL3wsk/s1u5bYp5L0WHXPWS3G/Lfj7eB0f1JRiS9
 ZY8q0PrcuE3NXgCJVTWM5ykyTciEftI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-WiWYOhk2Orqvdv4jTo43Fw-1; Fri, 16 Jun 2023 05:27:23 -0400
X-MC-Unique: WiWYOhk2Orqvdv4jTo43Fw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B92BB80006E;
 Fri, 16 Jun 2023 09:27:21 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.194.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A22991121315;
 Fri, 16 Jun 2023 09:27:18 +0000 (UTC)
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
Subject: [PATCH v1 04/15] memory-device,
 vhost: Add a memslot soft limit for memory devices
Date: Fri, 16 Jun 2023 11:26:43 +0200
Message-Id: <20230616092654.175518-5-david@redhat.com>
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

While we properly check before plugging a memory device whether there
still is a free memslot, we have other memslot consumers (such as boot
memory, PCI BARs) that don't perform any checks and might dynamically
consume memslots without any prior reservation. So we might succeed in
plugging a memory device, but once we dynamically map a PCI BAR we would
be in trouble. Doing accounting / reservation / checks for all such
users is problematic (e.g., sometimes we might temporarily split boot
memory into two memslots, triggered by the BIOS).

We much rather have some free memslots as a safety gap, than running out of
free memslots at runtime and crashing the VM.

Let's indicate to the user that we cannot guarantee that everything will
work as intended and that we might run out of free memslots later, by
warning the user in possibly problematic setups.

As long as we don't have to warn the user, we don't expect surprises.
It's worth noting that we'll now always warn the user when memory
devices are used along with some vhost devices (e.g., some vhost-user
devices only support 8 or even 32 memslots) -- until we support a
reasonable memslot number there as well.

We use the historic magic memslot number of 509 as orientation to when
supporting 256 memory devices (leaving 253 for boot memory and other
devices) has been proven to work reliable. We'll warn whenever we have
less than 253 memslots, or when exceeding the memslot soft limit that
we calculate based on the maximum number of memslots (max - 253).

For example, while the vhost-kernel driver has a default of 64 memslots,
Fedora manually raises that limit:
    $ cat /etc/modprobe.d/vhost.conf
    # Increase default vhost memory map limit to match
    # KVM's memory slot limit
    options vhost max_mem_regions=509

Whenever we plug a vhost device, we have to re-check, because the
vhost device might impose a new memslot limit.

We'll cap the soft limit for memslots used by memory devices at 256 (ACPI
DIMM limit), which no setup should currently really exceed. In the
future, we might want to increase that soft limit (512?), once some vhost
devices support more memslots.

Note that the soft-limit will be used in virtio-mem context soon, when
auto-detecting the number of memslots to use. For example, if we have
a soft-limit of 0 because we have less than 253 total memslots around,
virtio-mem will default to a single memslot to not cause trouble.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c         | 75 ++++++++++++++++++++++++++++++++++
 hw/virtio/vhost.c              |  4 ++
 include/hw/mem/memory-device.h |  2 +
 stubs/qmp_memory_device.c      |  4 ++
 4 files changed, 85 insertions(+)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 28ad419dc0..0d007e559c 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -20,6 +20,30 @@
 #include "exec/address-spaces.h"
 #include "trace.h"
 
+/*
+ * Traditionally, KVM/vhost in many setups supported 509 memslots, whereby
+ * 253 memslots were "reserved" for boot memory and other devices (such
+ * as PCI BARs, which can get mapped dynamically) and 256 memslots were
+ * dedicated for DIMMs. The magic number of "253" worked very reliably in
+ * the past.
+ *
+ * Other memslot users besides memory devices don't do any kind of memslot
+ * accounting / reservation / checks. So we'd be in trouble once e.g.,
+ * a BAR gets mapped dynamically and there are suddenly no free memslots
+ * around anymore. And we cannot really predict the future.
+ *
+ * Especially with vhost devices that support very little memslots, we
+ * might run out of free memslots at runtime when we consume too many for
+ * memory devices.
+ */
+#define MEMORY_DEVICES_BLOCKED_MAX_MEMSLOTS 253
+
+/*
+ * Using many memslots can negatively affect performance. Let's set the
+ * maximum soft limit to something reasonable.
+ */
+#define MEMORY_DEVICES_MEMSLOT_SOFT_LIMIT 256
+
 static gint memory_device_addr_sort(gconstpointer a, gconstpointer b)
 {
     const MemoryDeviceState *md_a = MEMORY_DEVICE(a);
@@ -52,6 +76,56 @@ static int memory_device_build_list(Object *obj, void *opaque)
     return 0;
 }
 
+/* Overall maximum number of memslots. */
+static unsigned int get_max_memslots(void)
+{
+    return MIN(vhost_get_max_memslots(), kvm_get_max_memslots());
+}
+
+/*
+ * The memslot soft limit for memory devices. The soft limit might change at
+ * runtime in corner cases (that should certainly be avoided), for example, when
+ * hotplugging vhost devices that impose new memslot limitations.
+ */
+static unsigned int memory_devices_memslot_soft_limit(MachineState *ms)
+{
+    const unsigned int max = get_max_memslots();
+
+    if (max < MEMORY_DEVICES_BLOCKED_MAX_MEMSLOTS) {
+        return 0;
+    }
+    return MIN(max - MEMORY_DEVICES_BLOCKED_MAX_MEMSLOTS,
+               MEMORY_DEVICES_MEMSLOT_SOFT_LIMIT);
+}
+
+static void memory_devices_check_memslot_soft_limit(MachineState *ms)
+{
+    const unsigned int soft_limit = memory_devices_memslot_soft_limit(ms);
+
+    if (!soft_limit) {
+        warn_report_once("The environment only supports a small number of"
+                         " memory slots (%u); use memory devices with care.",
+                         get_max_memslots());
+        return;
+    }
+    if (ms->device_memory->required_memslots > soft_limit) {
+        warn_report("Exceeding the soft limit (%u) of memory slots required for"
+                    " plugged memory devices (%u); use memory devices with"
+                    " care.", soft_limit, ms->device_memory->required_memslots);
+    }
+}
+
+void memory_devices_notify_vhost_device_added(void)
+{
+    MachineState *ms = current_machine;
+
+    if (!ms->device_memory || !ms->device_memory->required_memslots) {
+        return;
+    }
+    /* Re-check, now that we suddenly might have less memslots available. */
+    memory_devices_check_memslot_soft_limit(ms);
+}
+
 static void memory_device_check_addable(MachineState *ms, MemoryRegion *mr,
                                         Error **errp)
 {
@@ -276,6 +350,7 @@ void memory_device_plug(MemoryDeviceState *md, MachineState *ms)
 
     ms->device_memory->used_region_size += memory_region_size(mr);
     ms->device_memory->required_memslots++;
+    memory_devices_check_memslot_soft_limit(ms);
     memory_region_add_subregion(&ms->device_memory->mr,
                                 addr - ms->device_memory->base, mr);
     trace_memory_device_plug(DEVICE(md)->id ? DEVICE(md)->id : "", addr);
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 4b912709e8..5865049484 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -24,6 +24,7 @@
 #include "standard-headers/linux/vhost_types.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
+#include "hw/mem/memory-device.h"
 #include "migration/blocker.h"
 #include "migration/qemu-file-types.h"
 #include "sysemu/dma.h"
@@ -1534,6 +1535,9 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail_busyloop;
     }
 
+    /* Device is in the host_devices list, let's notify memory device code. */
+    memory_devices_notify_vhost_device_added();
+
     return 0;
 
 fail_busyloop:
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 48d2611fc5..813c3b9da6 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -14,6 +14,7 @@
 #define MEMORY_DEVICE_H
 
 #include "hw/qdev-core.h"
+#include "qemu/typedefs.h"
 #include "qapi/qapi-types-machine.h"
 #include "qom/object.h"
 
@@ -107,6 +108,7 @@ struct MemoryDeviceClass {
 
 MemoryDeviceInfoList *qmp_memory_device_list(void);
 uint64_t get_plugged_memory_size(void);
+void memory_devices_notify_vhost_device_added(void);
 void memory_device_pre_plug(MemoryDeviceState *md, MachineState *ms,
                             const uint64_t *legacy_align, Error **errp);
 void memory_device_plug(MemoryDeviceState *md, MachineState *ms);
diff --git a/stubs/qmp_memory_device.c b/stubs/qmp_memory_device.c
index e75cac62dc..b0e3e34f85 100644
--- a/stubs/qmp_memory_device.c
+++ b/stubs/qmp_memory_device.c
@@ -10,3 +10,7 @@ uint64_t get_plugged_memory_size(void)
 {
     return (uint64_t)-1;
 }
+
+void memory_devices_notify_vhost_device_added(void)
+{
+}
-- 
2.40.1


