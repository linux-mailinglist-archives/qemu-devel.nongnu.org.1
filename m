Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 540E67D3D91
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 19:27:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quygZ-00060u-LC; Mon, 23 Oct 2023 13:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1quygW-00060Y-20
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 13:25:49 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1quygU-0007gu-FG
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 13:25:47 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1quygN-0002st-P2; Mon, 23 Oct 2023 19:25:39 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, David Hildenbrand <david@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v8 8/9] hw/i386/pc: Support hv-balloon
Date: Mon, 23 Oct 2023 19:24:34 +0200
Message-ID: <8c07ce85a3d32cadd7f0f75a8098e8d860041754.1698064313.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1698064312.git.maciej.szmigiero@oracle.com>
References: <cover.1698064312.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 9051083c1e78..349cf0d32fad 100644
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
index bb3854d1d089..5f202cc32801 100644
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
@@ -1426,6 +1428,21 @@ static void pc_memory_unplug(HotplugHandler *hotplug_dev,
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
@@ -1456,6 +1473,8 @@ static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
             return;
         }
         pcms->iommu = dev;
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_HV_BALLOON)) {
+        pc_hv_balloon_pre_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -1468,6 +1487,8 @@ static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
         x86_cpu_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
         virtio_md_pci_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_HV_BALLOON)) {
+        pc_hv_balloon_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -1509,6 +1530,7 @@ static HotplugHandler *pc_get_hotplug_handler(MachineState *machine,
         object_dynamic_cast(OBJECT(dev), TYPE_CPU) ||
         object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI) ||
         object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_HV_BALLOON) ||
         object_dynamic_cast(OBJECT(dev), TYPE_X86_IOMMU_DEVICE)) {
         return HOTPLUG_HANDLER(machine);
     }

