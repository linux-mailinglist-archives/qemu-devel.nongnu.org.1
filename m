Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B36C7E1334
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 12:50:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzbco-000356-OQ; Sun, 05 Nov 2023 06:49:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qzbcm-00034s-T6
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 06:49:05 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qzbcl-0002Js-DG
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 06:49:04 -0500
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1qzbcj-0003Yg-Tk; Sun, 05 Nov 2023 12:49:01 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>
Subject: [PULL 8/9] hw/i386/pc: Support hv-balloon
Date: Sun,  5 Nov 2023 12:47:56 +0100
Message-ID: <4aa918607331990603479a9912d3c4d32504a0d0.1699184105.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1699184105.git.maciej.szmigiero@oracle.com>
References: <cover.1699184105.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Add the necessary plumbing for the hv-balloon driver to the PC machine.

Co-developed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/i386/Kconfig |  1 +
 hw/i386/pc.c    | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 94772c726b24..55850791df41 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -45,6 +45,7 @@ config PC
     select ACPI_VMGENID
     select VIRTIO_PMEM_SUPPORTED
     select VIRTIO_MEM_SUPPORTED
+    select HV_BALLOON_SUPPORTED
 
 config PC_PCI
     bool
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 6031234a73f1..1aef21aa2c25 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -27,6 +27,7 @@
 #include "hw/i386/pc.h"
 #include "hw/char/serial.h"
 #include "hw/char/parallel.h"
+#include "hw/hyperv/hv-balloon.h"
 #include "hw/i386/fw_cfg.h"
 #include "hw/i386/vmport.h"
 #include "sysemu/cpus.h"
@@ -57,6 +58,7 @@
 #include "hw/i386/kvm/xen_evtchn.h"
 #include "hw/i386/kvm/xen_gnttab.h"
 #include "hw/i386/kvm/xen_xenstore.h"
+#include "hw/mem/memory-device.h"
 #include "e820_memory_layout.h"
 #include "trace.h"
 #include CONFIG_DEVICES
@@ -1422,6 +1424,21 @@ static void pc_memory_unplug(HotplugHandler *hotplug_dev,
     error_propagate(errp, local_err);
 }
 
+static void pc_hv_balloon_pre_plug(HotplugHandler *hotplug_dev,
+                                   DeviceState *dev, Error **errp)
+{
+    /* The vmbus handler has no hotplug handler; we should never end up here. */
+    g_assert(!dev->hotplugged);
+    memory_device_pre_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev), NULL,
+                           errp);
+}
+
+static void pc_hv_balloon_plug(HotplugHandler *hotplug_dev,
+                               DeviceState *dev, Error **errp)
+{
+    memory_device_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
+}
+
 static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                           DeviceState *dev, Error **errp)
 {
@@ -1452,6 +1469,8 @@ static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
             return;
         }
         pcms->iommu = dev;
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_HV_BALLOON)) {
+        pc_hv_balloon_pre_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -1464,6 +1483,8 @@ static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
         x86_cpu_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
         virtio_md_pci_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_HV_BALLOON)) {
+        pc_hv_balloon_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -1505,6 +1526,7 @@ static HotplugHandler *pc_get_hotplug_handler(MachineState *machine,
         object_dynamic_cast(OBJECT(dev), TYPE_CPU) ||
         object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI) ||
         object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_HV_BALLOON) ||
         object_dynamic_cast(OBJECT(dev), TYPE_X86_IOMMU_DEVICE)) {
         return HOTPLUG_HANDLER(machine);
     }

