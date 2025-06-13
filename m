Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2A7AD9000
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Jun 2025 16:48:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ5gb-0008KK-O5; Fri, 13 Jun 2025 10:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uQ5gX-0008Iv-02; Fri, 13 Jun 2025 10:47:13 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uQ5gV-0006lv-4s; Fri, 13 Jun 2025 10:47:12 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJhzz59d2z6M4h6;
 Fri, 13 Jun 2025 22:46:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 1EB971400DB;
 Fri, 13 Jun 2025 22:47:07 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Jun 2025 16:46:58 +0200
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <imammedo@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>
Subject: [PATCH v4 6/7] hw/arm/virt: Allow user-creatable SMMUv3 dev
 instantiation
Date: Fri, 13 Jun 2025 15:44:48 +0100
Message-ID: <20250613144449.60156-7-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com>
References: <20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.203.177.241]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
From:  Shameer Kolothum via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Allow cold-plug of smmuv3 device to virt if there is no machine
wide legacy smmuv3 or a virtio-iommu is specified.

Device tree support for new smmuv3 dev is limited to the case where
it is associated with the default pcie.0 RC.

Tested-by: Nathan Chen <nathanc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/smmuv3.c      |  2 ++
 hw/arm/virt.c        | 47 ++++++++++++++++++++++++++++++++++++++++++++
 hw/core/sysbus-fdt.c |  3 +++
 3 files changed, 52 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ab67972353..bcf8af8dc7 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1996,6 +1996,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     device_class_set_parent_realize(dc, smmu_realize,
                                     &c->parent_realize);
     device_class_set_props(dc, smmuv3_properties);
+    dc->hotpluggable = false;
+    dc->user_creatable = true;
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index eeace4754d..3be007d87c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -56,6 +56,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "hw/pci/pci_bus.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/virtio/virtio-pci.h"
 #include "hw/core/sysbus-fdt.h"
@@ -1443,6 +1444,28 @@ static void create_smmuv3_dt_bindings(const VirtMachineState *vms, hwaddr base,
     g_free(node);
 }
 
+static void create_smmuv3_dev_dtb(VirtMachineState *vms,
+                                  DeviceState *dev, PCIBus *bus)
+{
+    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
+    SysBusDevice *sbdev = SYS_BUS_DEVICE(dev);
+    int irq = platform_bus_get_irqn(pbus, sbdev, 0);
+    hwaddr base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
+    MachineState *ms = MACHINE(vms);
+
+    if (strcmp("pcie.0", bus->qbus.name)) {
+        warn_report("SMMUv3 device only supported with pcie.0 for DT");
+        return;
+    }
+    base += vms->memmap[VIRT_PLATFORM_BUS].base;
+    irq += vms->irqmap[VIRT_PLATFORM_BUS];
+
+    vms->iommu_phandle = qemu_fdt_alloc_phandle(ms->fdt);
+    create_smmuv3_dt_bindings(vms, base, SMMU_IO_LEN, irq);
+    qemu_fdt_setprop_cells(ms->fdt, vms->pciehb_nodename, "iommu-map",
+                           0x0, vms->iommu_phandle, 0x0, 0x10000);
+}
+
 static void create_smmu(const VirtMachineState *vms,
                         PCIBus *bus)
 {
@@ -2931,6 +2954,13 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
         qlist_append_str(reserved_regions, resv_prop_str);
         qdev_prop_set_array(dev, "reserved-regions", reserved_regions);
         g_free(resv_prop_str);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3)) {
+        if (vms->legacy_smmuv3_present || vms->iommu == VIRT_IOMMU_VIRTIO) {
+            error_setg(errp, "virt machine already has %s set. "
+                       "Doesn't support incompatible iommus",
+                       (vms->legacy_smmuv3_present) ?
+                       "iommu=smmuv3" : "virtio-iommu");
+        }
     }
 }
 
@@ -2954,6 +2984,22 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
         virtio_md_pci_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
     }
 
+    if (object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3)) {
+        if (!vms->legacy_smmuv3_present && vms->platform_bus_dev) {
+            PCIBus *bus;
+
+            bus = PCI_BUS(object_property_get_link(OBJECT(dev), "primary-bus",
+                                                   &error_abort));
+            if (pci_bus_bypass_iommu(bus)) {
+                error_setg(errp, "Bypass option cannot be set for SMMUv3 "
+                           "associated PCIe RC");
+                return;
+            }
+
+            create_smmuv3_dev_dtb(vms, dev, bus);
+        }
+    }
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
         PCIDevice *pdev = PCI_DEVICE(dev);
 
@@ -3156,6 +3202,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ARM_SMMUV3);
 #ifdef CONFIG_TPM
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
 #endif
diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
index c339a27875..e80776080b 100644
--- a/hw/core/sysbus-fdt.c
+++ b/hw/core/sysbus-fdt.c
@@ -31,6 +31,7 @@
 #include "qemu/error-report.h"
 #include "system/device_tree.h"
 #include "system/tpm.h"
+#include "hw/arm/smmuv3.h"
 #include "hw/platform-bus.h"
 #include "hw/vfio/vfio-platform.h"
 #include "hw/vfio/vfio-calxeda-xgmac.h"
@@ -518,6 +519,8 @@ static const BindingEntry bindings[] = {
 #ifdef CONFIG_TPM
     TYPE_BINDING(TYPE_TPM_TIS_SYSBUS, add_tpm_tis_fdt_node),
 #endif
+    /* No generic DT support for smmuv3 dev. Support added for arm virt only */
+    TYPE_BINDING(TYPE_ARM_SMMUV3, no_fdt_node),
     TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
     TYPE_BINDING(TYPE_UEFI_VARS_SYSBUS, add_uefi_vars_node),
     TYPE_BINDING("", NULL), /* last element */
-- 
2.47.0


