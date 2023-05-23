Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDE570E4EE
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 20:53:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1X7B-0007RL-8L; Tue, 23 May 2023 14:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q1X78-0007JA-L2
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:52:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q1X76-0000dZ-6m
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684867922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tqgoMx3VGq/IcEUJhCLlD0ORcUiqe8OqGgyCdOS0Zyo=;
 b=AukMM1j+TcdsYoy1M4fh0s/+Cfamg17aJZvOYfFAxXw2RGH2lTvHSLkZyVIlRWIErOfxDw
 NRDNWu6v238j4QHBJTx/rfLQFecInMZfXODqBhVXjhI7a9FbvO2RZZp0DRngt7RQ8lm57y
 RFReGFH1fqa8g1G/1R1ABjlR48Q2lkc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-as8nrjWUM-mq_PVVRPnJVw-1; Tue, 23 May 2023 14:51:59 -0400
X-MC-Unique: as8nrjWUM-mq_PVVRPnJVw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AF2685A5BE;
 Tue, 23 May 2023 18:51:58 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.194.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C10BB40CFD45;
 Tue, 23 May 2023 18:51:54 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v1 2/3] memory-device: Factor out device memory initialization
 into memory_devices_init()
Date: Tue, 23 May 2023 20:51:43 +0200
Message-Id: <20230523185144.533592-3-david@redhat.com>
In-Reply-To: <20230523185144.533592-1-david@redhat.com>
References: <20230523185144.533592-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Let's factor the common setup out, to prepare for further changes.

On arm64, we'll add the subregion to system RAM now earlier -- which
shouldn't matter, because the system RAM memory region should already be
alive at that point.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/arm/virt.c                  |  9 +--------
 hw/i386/pc.c                   | 17 ++++++-----------
 hw/loongarch/virt.c            | 14 ++++----------
 hw/mem/memory-device.c         | 20 ++++++++++++++++++++
 hw/ppc/spapr.c                 | 15 ++++++---------
 include/hw/mem/memory-device.h |  2 ++
 6 files changed, 39 insertions(+), 38 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b99ae18501..284f45d998 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1816,10 +1816,7 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
     virt_set_high_memmap(vms, base, pa_bits);
 
     if (device_memory_size > 0) {
-        ms->device_memory = g_malloc0(sizeof(*ms->device_memory));
-        ms->device_memory->base = device_memory_base;
-        memory_region_init(&ms->device_memory->mr, OBJECT(vms),
-                           "device-memory", device_memory_size);
+        memory_devices_init(ms, device_memory_base, device_memory_size);
     }
 }
 
@@ -2260,10 +2257,6 @@ static void machvirt_init(MachineState *machine)
 
     memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base,
                                 machine->ram);
-    if (machine->device_memory) {
-        memory_region_add_subregion(sysmem, machine->device_memory->base,
-                                    &machine->device_memory->mr);
-    }
 
     virt_flash_fdt(vms, sysmem, secure_sysmem ?: sysmem);
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bb62c994fa..9d215df92e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1039,13 +1039,11 @@ void pc_memory_init(PCMachineState *pcms,
         exit(EXIT_FAILURE);
     }
 
-    /* always allocate the device memory information */
-    machine->device_memory = g_malloc0(sizeof(*machine->device_memory));
-
     /* initialize device memory address space */
     if (pcmc->has_reserved_memory &&
         (machine->ram_size < machine->maxram_size)) {
         ram_addr_t device_mem_size;
+        hwaddr device_mem_base;
 
         if (machine->ram_slots > ACPI_MAX_RAM_SLOTS) {
             error_report("unsupported amount of memory slots: %"PRIu64,
@@ -1060,19 +1058,16 @@ void pc_memory_init(PCMachineState *pcms,
             exit(EXIT_FAILURE);
         }
 
-        pc_get_device_memory_range(pcms, &machine->device_memory->base, &device_mem_size);
+        pc_get_device_memory_range(pcms, &device_mem_base, &device_mem_size);
 
-        if ((machine->device_memory->base + device_mem_size) <
-            device_mem_size) {
+        if (device_mem_base + device_mem_size < device_mem_size) {
             error_report("unsupported amount of maximum memory: " RAM_ADDR_FMT,
                          machine->maxram_size);
             exit(EXIT_FAILURE);
         }
-
-        memory_region_init(&machine->device_memory->mr, OBJECT(pcms),
-                           "device-memory", device_mem_size);
-        memory_region_add_subregion(system_memory, machine->device_memory->base,
-                                    &machine->device_memory->mr);
+        memory_devices_init(machine, device_mem_base, device_mem_size);
+    } else {
+        memory_devices_init(machine, 0, 0);
     }
 
     if (pcms->cxl_devices_state.is_enabled) {
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 2b7588e32a..2ccc90feb4 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -45,7 +45,7 @@
 #include "sysemu/block-backend.h"
 #include "hw/block/flash.h"
 #include "qemu/error-report.h"
-
+#include "hw/mem/memory-device.h"
 
 static void virt_flash_create(LoongArchMachineState *lams)
 {
@@ -804,8 +804,8 @@ static void loongarch_init(MachineState *machine)
 
     /* initialize device memory address space */
     if (machine->ram_size < machine->maxram_size) {
-        machine->device_memory = g_malloc0(sizeof(*machine->device_memory));
         ram_addr_t device_mem_size = machine->maxram_size - machine->ram_size;
+        hwaddr device_mem_base;
 
         if (machine->ram_slots > ACPI_MAX_RAM_SLOTS) {
             error_report("unsupported amount of memory slots: %"PRIu64,
@@ -820,14 +820,8 @@ static void loongarch_init(MachineState *machine)
             exit(EXIT_FAILURE);
         }
         /* device memory base is the top of high memory address. */
-        machine->device_memory->base = 0x90000000 + highram_size;
-        machine->device_memory->base =
-            ROUND_UP(machine->device_memory->base, 1 * GiB);
-
-        memory_region_init(&machine->device_memory->mr, OBJECT(lams),
-                           "device-memory", device_mem_size);
-        memory_region_add_subregion(address_space_mem, machine->device_memory->base,
-                                    &machine->device_memory->mr);
+        device_mem_base = ROUND_UP(0x90000000 + highram_size, 1 * GiB);
+        memory_devices_init(machine, device_mem_base, device_mem_size);
     }
 
     /* Add isa io region */
diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 6c025b02c1..d99ceb621a 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -17,6 +17,7 @@
 #include "qemu/range.h"
 #include "hw/virtio/vhost.h"
 #include "sysemu/kvm.h"
+#include "exec/address-spaces.h"
 #include "trace.h"
 
 static gint memory_device_addr_sort(gconstpointer a, gconstpointer b)
@@ -333,6 +334,25 @@ uint64_t memory_device_get_region_size(const MemoryDeviceState *md,
     return memory_region_size(mr);
 }
 
+void memory_devices_init(MachineState *ms, hwaddr base, uint64_t size)
+{
+    g_assert(!ms->device_memory);
+    ms->device_memory = g_new0(DeviceMemoryState, 1);
+    ms->device_memory->base = base;
+
+    /*
+     * See memory_device_get_free_addr(): An empty device memory region
+     * means "this machine supports memory devices, but they are not enabled".
+     */
+    if (size > 0) {
+        memory_region_init(&ms->device_memory->mr, OBJECT(ms), "device-memory",
+                           size);
+        memory_region_add_subregion(get_system_memory(),
+                                    ms->device_memory->base,
+                                    &ms->device_memory->mr);
+    }
+}
+
 static const TypeInfo memory_device_info = {
     .name          = TYPE_MEMORY_DEVICE,
     .parent        = TYPE_INTERFACE,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1baea16c96..d66dc00ea5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2866,12 +2866,11 @@ static void spapr_machine_init(MachineState *machine)
     /* map RAM */
     memory_region_add_subregion(sysmem, 0, machine->ram);
 
-    /* always allocate the device memory information */
-    machine->device_memory = g_malloc0(sizeof(*machine->device_memory));
-
     /* initialize hotplug memory address space */
     if (machine->ram_size < machine->maxram_size) {
         ram_addr_t device_mem_size = machine->maxram_size - machine->ram_size;
+        hwaddr device_mem_base;
+
         /*
          * Limit the number of hotpluggable memory slots to half the number
          * slots that KVM supports, leaving the other half for PCI and other
@@ -2890,12 +2889,10 @@ static void spapr_machine_init(MachineState *machine)
             exit(1);
         }
 
-        machine->device_memory->base = ROUND_UP(machine->ram_size,
-                                                SPAPR_DEVICE_MEM_ALIGN);
-        memory_region_init(&machine->device_memory->mr, OBJECT(spapr),
-                           "device-memory", device_mem_size);
-        memory_region_add_subregion(sysmem, machine->device_memory->base,
-                                    &machine->device_memory->mr);
+        device_mem_base = ROUND_UP(machine->ram_size, SPAPR_DEVICE_MEM_ALIGN);
+        memory_devices_init(machine, device_mem_base, device_mem_size);
+    } else {
+        memory_devices_init(machine, 0, 0);
     }
 
     if (smc->dr_lmb_enabled) {
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 48d2611fc5..6e8a10e2f5 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -16,6 +16,7 @@
 #include "hw/qdev-core.h"
 #include "qapi/qapi-types-machine.h"
 #include "qom/object.h"
+#include "exec/hwaddr.h"
 
 #define TYPE_MEMORY_DEVICE "memory-device"
 
@@ -113,5 +114,6 @@ void memory_device_plug(MemoryDeviceState *md, MachineState *ms);
 void memory_device_unplug(MemoryDeviceState *md, MachineState *ms);
 uint64_t memory_device_get_region_size(const MemoryDeviceState *md,
                                        Error **errp);
+void memory_devices_init(MachineState *ms, hwaddr base, uint64_t size);
 
 #endif
-- 
2.40.1


