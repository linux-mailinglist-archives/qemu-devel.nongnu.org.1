Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0437F750134
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 10:19:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJV3X-0004Dk-K4; Wed, 12 Jul 2023 04:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJV3S-0004Cj-1R
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 04:18:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJV3Q-0000ZT-DV
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 04:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689149911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yR5531fqkyXPWK7cf414dTS91ida85cSee1+Zs/ZUqo=;
 b=PIxTFefK09J1CtnxP6wclljiyrrsa2WVdFPb20ATfwlDGKAx4053C/J7RGd0Lin/mo8Rck
 VpyFEmUp5geRVTsJ2HBW87ayH7jZWGueomFeOHyC2KH/YRulGdHdejmA5iX5tjv8J2xDRU
 TBauQYOlP0UTU9xZSHc1ntB3l7Un3+A=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-251-5PDvF-PHNauj4s2_U6jqzA-1; Wed, 12 Jul 2023 04:18:28 -0400
X-MC-Unique: 5PDvF-PHNauj4s2_U6jqzA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D4063C100A1;
 Wed, 12 Jul 2023 08:18:28 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D02D44CD0C6;
 Wed, 12 Jul 2023 08:18:26 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>
Subject: [GIT PULL 17/21] arm/virt: Use virtio-md-pci (un)plug functions
Date: Wed, 12 Jul 2023 10:17:46 +0200
Message-ID: <20230712081750.80852-18-david@redhat.com>
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

Let's use our new helper functions. Note that virtio-pmem-pci is not
enabled for arm and, therefore, not compiled in.

Message-ID: <20230711153445.514112-4-david@redhat.com>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/arm/virt.c | 81 ++++++++-------------------------------------------
 1 file changed, 12 insertions(+), 69 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0546e43448..7d9dbc2663 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -73,11 +73,10 @@
 #include "hw/arm/smmuv3.h"
 #include "hw/acpi/acpi.h"
 #include "target/arm/internals.h"
-#include "hw/mem/memory-device.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/acpi/generic_event_device.h"
-#include "hw/virtio/virtio-mem-pci.h"
+#include "hw/virtio/virtio-md-pci.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/char/pl011.h"
 #include "qemu/guest-random.h"
@@ -2733,64 +2732,6 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
                          dev, &error_abort);
 }
 
-static void virt_virtio_md_pci_pre_plug(HotplugHandler *hotplug_dev,
-                                        DeviceState *dev, Error **errp)
-{
-    HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
-    Error *local_err = NULL;
-
-    if (!hotplug_dev2 && dev->hotplugged) {
-        /*
-         * Without a bus hotplug handler, we cannot control the plug/unplug
-         * order. We should never reach this point when hotplugging on ARM.
-         * However, it's nice to add a safety net, similar to what we have
-         * on x86.
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
-static void virt_virtio_md_pci_plug(HotplugHandler *hotplug_dev,
-                                    DeviceState *dev, Error **errp)
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
-static void virt_virtio_md_pci_unplug_request(HotplugHandler *hotplug_dev,
-                                              DeviceState *dev, Error **errp)
-{
-    /* We don't support hot unplug of virtio based memory devices */
-    error_setg(errp, "virtio based memory devices cannot be unplugged.");
-}
-
-
 static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                             DeviceState *dev, Error **errp)
 {
@@ -2798,8 +2739,8 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         virt_memory_pre_plug(hotplug_dev, dev, errp);
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
-        virt_virtio_md_pci_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
+        virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
         hwaddr db_start = 0, db_end = 0;
         char *resv_prop_str;
@@ -2848,12 +2789,11 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                                      SYS_BUS_DEVICE(dev));
         }
     }
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         virt_memory_plug(hotplug_dev, dev, errp);
-    }
-
-    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
-        virt_virtio_md_pci_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
+        virtio_md_pci_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
     }
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
@@ -2908,8 +2848,9 @@ static void virt_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         virt_dimm_unplug_request(hotplug_dev, dev, errp);
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
-        virt_virtio_md_pci_unplug_request(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
+        virtio_md_pci_unplug_request(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev),
+                                     errp);
     } else {
         error_setg(errp, "device unplug request for unsupported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -2921,6 +2862,8 @@ static void virt_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         virt_dimm_unplug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
+        virtio_md_pci_unplug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
     } else {
         error_setg(errp, "virt: device unplug for unsupported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -2934,7 +2877,7 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
 
     if (device_is_dynamic_sysbus(mc, dev) ||
         object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
-        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI) ||
         object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
         return HOTPLUG_HANDLER(machine);
     }
-- 
2.41.0


