Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE65750147
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 10:21:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJV3V-0004DX-Av; Wed, 12 Jul 2023 04:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJV3S-0004D7-JG
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 04:18:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJV3Q-0000ZW-K4
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 04:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689149912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2cuG8t28qW3CT8XKA3qVRh+Fs5YFTGEBgH3rhTSnF7o=;
 b=EsIT0JGKJyo/juMJ8LjelqGoYsKnoXhV6HRvmC14bahqb26+/GA2i32LOCCi42jLEL7vZ6
 EHR7Fw/UEO5DJgxver2XCT8+bpClA6GaDuoyjzSYSp3hH7uR2SFYfGJ+EZer8b/uq4mPva
 dQZQfshmAjpuwDptVgz6w1UI0wZHXfE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-FCNLv4QBPP2unW_bqDL6hA-1; Wed, 12 Jul 2023 04:18:27 -0400
X-MC-Unique: FCNLv4QBPP2unW_bqDL6hA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 957768FBA2B;
 Wed, 12 Jul 2023 08:18:26 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2FE01492C13;
 Wed, 12 Jul 2023 08:18:24 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>
Subject: [GIT PULL 16/21] pc: Factor out (un)plug handling of virtio-md-pci
 devices
Date: Wed, 12 Jul 2023 10:17:45 +0200
Message-ID: <20230712081750.80852-17-david@redhat.com>
In-Reply-To: <20230712081750.80852-1-david@redhat.com>
References: <20230712081750.80852-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Let's factor out (un)plug handling, to be reused from arm/virt code.

Provide stubs for the case that CONFIG_VIRTIO_MD is not selected because
neither virtio-mem nor virtio-pmem is enabled. While this cannot
currently happen for x86, it will be possible for arm/virt.

Message-ID: <20230711153445.514112-3-david@redhat.com>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 MAINTAINERS                       |  1 +
 hw/i386/pc.c                      | 90 ++++---------------------------
 hw/virtio/virtio-md-pci.c         | 63 ++++++++++++++++++++++
 include/hw/virtio/virtio-md-pci.h |  6 +++
 stubs/meson.build                 |  1 +
 stubs/virtio-md-pci.c             | 24 +++++++++
 6 files changed, 106 insertions(+), 79 deletions(-)
 create mode 100644 stubs/virtio-md-pci.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bb4626faf7..12e59b6b27 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2234,6 +2234,7 @@ M: David Hildenbrand <david@redhat.com>
 S: Supported
 F: hw/virtio/virtio-md-pci.c
 F: include/hw/virtio/virtio-md-pci.h
+F: stubs/virtio-md-pci.c
 
 virtio-mem
 M: David Hildenbrand <david@redhat.com>
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 1bd1e5ead1..3109d5e0e0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -88,13 +88,11 @@
 #include "hw/net/ne2000-isa.h"
 #include "standard-headers/asm-x86/bootparam.h"
 #include "hw/virtio/virtio-iommu.h"
-#include "hw/virtio/virtio-pmem-pci.h"
-#include "hw/virtio/virtio-mem-pci.h"
+#include "hw/virtio/virtio-md-pci.h"
 #include "hw/i386/kvm/xen_overlay.h"
 #include "hw/i386/kvm/xen_evtchn.h"
 #include "hw/i386/kvm/xen_gnttab.h"
 #include "hw/i386/kvm/xen_xenstore.h"
-#include "hw/mem/memory-device.h"
 #include "sysemu/replay.h"
 #include "target/i386/cpu.h"
 #include "e820_memory_layout.h"
@@ -1493,68 +1491,6 @@ static void pc_memory_unplug(HotplugHandler *hotplug_dev,
     error_propagate(errp, local_err);
 }
 
-static void pc_virtio_md_pci_pre_plug(HotplugHandler *hotplug_dev,
-                                      DeviceState *dev, Error **errp)
-{
-    HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
-    Error *local_err = NULL;
-
-    if (!hotplug_dev2 && dev->hotplugged) {
-        /*
-         * Without a bus hotplug handler, we cannot control the plug/unplug
-         * order. We should never reach this point when hotplugging on x86,
-         * however, better add a safety net.
-         */
-        error_setg(errp, "hotplug of virtio based memory devices not supported"
-                   " on this bus.");
-        return;
-    }
-    /*
-     * First, see if we can plug this memory device at all. If that
-     * succeeds, branch of to the actual hotplug handler.
-     */
-    memory_device_pre_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev), NULL,
-                           &local_err);
-    if (!local_err && hotplug_dev2) {
-        hotplug_handler_pre_plug(hotplug_dev2, dev, &local_err);
-    }
-    error_propagate(errp, local_err);
-}
-
-static void pc_virtio_md_pci_plug(HotplugHandler *hotplug_dev,
-                                  DeviceState *dev, Error **errp)
-{
-    HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
-    Error *local_err = NULL;
-
-    /*
-     * Plug the memory device first and then branch off to the actual
-     * hotplug handler. If that one fails, we can easily undo the memory
-     * device bits.
-     */
-    memory_device_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
-    if (hotplug_dev2) {
-        hotplug_handler_plug(hotplug_dev2, dev, &local_err);
-        if (local_err) {
-            memory_device_unplug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
-        }
-    }
-    error_propagate(errp, local_err);
-}
-
-static void pc_virtio_md_pci_unplug_request(HotplugHandler *hotplug_dev,
-                                            DeviceState *dev, Error **errp)
-{
-    /* We don't support hot unplug of virtio based memory devices */
-    error_setg(errp, "virtio based memory devices cannot be unplugged.");
-}
-
-static void pc_virtio_md_pci_unplug(HotplugHandler *hotplug_dev,
-                                    DeviceState *dev, Error **errp)
-{
-    /* We don't support hot unplug of virtio based memory devices */
-}
-
 static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                           DeviceState *dev, Error **errp)
 {
@@ -1562,9 +1498,8 @@ static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
         pc_memory_pre_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         x86_cpu_pre_plug(hotplug_dev, dev, errp);
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
-               object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
-        pc_virtio_md_pci_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
+        virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
         /* Declare the APIC range as the reserved MSI region */
         char *resv_prop_str = g_strdup_printf("0xfee00000:0xfeefffff:%d",
@@ -1596,9 +1531,8 @@ static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
         pc_memory_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         x86_cpu_plug(hotplug_dev, dev, errp);
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
-               object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
-        pc_virtio_md_pci_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
+        virtio_md_pci_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
     }
 }
 
@@ -1609,9 +1543,9 @@ static void pc_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
         pc_memory_unplug_request(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         x86_cpu_unplug_request_cb(hotplug_dev, dev, errp);
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
-               object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
-        pc_virtio_md_pci_unplug_request(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
+        virtio_md_pci_unplug_request(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev),
+                                     errp);
     } else {
         error_setg(errp, "acpi: device unplug request for not supported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -1625,9 +1559,8 @@ static void pc_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
         pc_memory_unplug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         x86_cpu_unplug_cb(hotplug_dev, dev, errp);
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
-               object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
-        pc_virtio_md_pci_unplug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
+        virtio_md_pci_unplug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
     } else {
         error_setg(errp, "acpi: device unplug for not supported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -1639,8 +1572,7 @@ static HotplugHandler *pc_get_hotplug_handler(MachineState *machine,
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
         object_dynamic_cast(OBJECT(dev), TYPE_CPU) ||
-        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
-        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI) ||
         object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
         object_dynamic_cast(OBJECT(dev), TYPE_X86_IOMMU_DEVICE)) {
         return HOTPLUG_HANDLER(machine);
diff --git a/hw/virtio/virtio-md-pci.c b/hw/virtio/virtio-md-pci.c
index 6b02ff908e..e849c3131d 100644
--- a/hw/virtio/virtio-md-pci.c
+++ b/hw/virtio/virtio-md-pci.c
@@ -13,6 +13,69 @@
 #include "qemu/osdep.h"
 #include "hw/virtio/virtio-md-pci.h"
 #include "hw/mem/memory-device.h"
+#include "qapi/error.h"
+
+void virtio_md_pci_pre_plug(VirtIOMDPCI *vmd, MachineState *ms, Error **errp)
+{
+    DeviceState *dev = DEVICE(vmd);
+    HotplugHandler *bus_handler = qdev_get_bus_hotplug_handler(dev);
+    MemoryDeviceState *md = MEMORY_DEVICE(vmd);
+    Error *local_err = NULL;
+
+    if (!bus_handler && dev->hotplugged) {
+        /*
+         * Without a bus hotplug handler, we cannot control the plug/unplug
+         * order. We should never reach this point when hotplugging on x86,
+         * however, better add a safety net.
+         */
+        error_setg(errp, "hotplug of virtio based memory devices not supported"
+                   " on this bus.");
+        return;
+    }
+    /*
+     * First, see if we can plug this memory device at all. If that
+     * succeeds, branch of to the actual hotplug handler.
+     */
+    memory_device_pre_plug(md, ms, NULL, &local_err);
+    if (!local_err && bus_handler) {
+        hotplug_handler_pre_plug(bus_handler, dev, &local_err);
+    }
+    error_propagate(errp, local_err);
+}
+
+void virtio_md_pci_plug(VirtIOMDPCI *vmd, MachineState *ms, Error **errp)
+{
+    DeviceState *dev = DEVICE(vmd);
+    HotplugHandler *bus_handler = qdev_get_bus_hotplug_handler(dev);
+    MemoryDeviceState *md = MEMORY_DEVICE(vmd);
+    Error *local_err = NULL;
+
+    /*
+     * Plug the memory device first and then branch off to the actual
+     * hotplug handler. If that one fails, we can easily undo the memory
+     * device bits.
+     */
+    memory_device_plug(md, ms);
+    if (bus_handler) {
+        hotplug_handler_plug(bus_handler, dev, &local_err);
+        if (local_err) {
+            memory_device_unplug(md, ms);
+        }
+    }
+    error_propagate(errp, local_err);
+}
+
+void virtio_md_pci_unplug_request(VirtIOMDPCI *vmd, MachineState *ms,
+                                  Error **errp)
+{
+    /* We don't support hot unplug of virtio based memory devices */
+    error_setg(errp, "virtio based memory devices cannot be unplugged.");
+}
+
+void virtio_md_pci_unplug(VirtIOMDPCI *vmd, MachineState *ms, Error **errp)
+{
+    /* We don't support hot unplug of virtio based memory devices */
+}
 
 static const TypeInfo virtio_md_pci_info = {
     .name = TYPE_VIRTIO_MD_PCI,
diff --git a/include/hw/virtio/virtio-md-pci.h b/include/hw/virtio/virtio-md-pci.h
index a241b54fcd..f9fa857aec 100644
--- a/include/hw/virtio/virtio-md-pci.h
+++ b/include/hw/virtio/virtio-md-pci.h
@@ -32,4 +32,10 @@ struct VirtIOMDPCI {
     VirtIOPCIProxy parent_obj;
 };
 
+void virtio_md_pci_pre_plug(VirtIOMDPCI *vmd, MachineState *ms, Error **errp);
+void virtio_md_pci_plug(VirtIOMDPCI *vmd, MachineState *ms, Error **errp);
+void virtio_md_pci_unplug_request(VirtIOMDPCI *vmd, MachineState *ms,
+                                  Error **errp);
+void virtio_md_pci_unplug(VirtIOMDPCI *vmd, MachineState *ms, Error **errp);
+
 #endif
diff --git a/stubs/meson.build b/stubs/meson.build
index a56645e2f7..ef6e39a64d 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -60,6 +60,7 @@ if have_system
   stub_ss.add(files('semihost.c'))
   stub_ss.add(files('usb-dev-stub.c'))
   stub_ss.add(files('xen-hw-stub.c'))
+  stub_ss.add(files('virtio-md-pci.c'))
 else
   stub_ss.add(files('qdev.c'))
 endif
diff --git a/stubs/virtio-md-pci.c b/stubs/virtio-md-pci.c
new file mode 100644
index 0000000000..ce5bba0c9d
--- /dev/null
+++ b/stubs/virtio-md-pci.c
@@ -0,0 +1,24 @@
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/virtio/virtio-md-pci.h"
+
+void virtio_md_pci_pre_plug(VirtIOMDPCI *vmd, MachineState *ms, Error **errp)
+{
+    error_setg(errp, "virtio based memory devices not supported");
+}
+
+void virtio_md_pci_plug(VirtIOMDPCI *vmd, MachineState *ms, Error **errp)
+{
+    error_setg(errp, "virtio based memory devices not supported");
+}
+
+void virtio_md_pci_unplug_request(VirtIOMDPCI *vmd, MachineState *ms,
+                                  Error **errp)
+{
+    error_setg(errp, "virtio based memory devices not supported");
+}
+
+void virtio_md_pci_unplug(VirtIOMDPCI *vmd, MachineState *ms, Error **errp)
+{
+    error_setg(errp, "virtio based memory devices not supported");
+}
-- 
2.41.0


