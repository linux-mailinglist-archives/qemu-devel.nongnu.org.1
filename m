Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F431AFD910
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Jul 2025 23:01:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFIc-0005IX-4S; Tue, 08 Jul 2025 16:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uZE81-0000r9-Ob; Tue, 08 Jul 2025 15:37:28 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uZE7y-000504-AK; Tue, 08 Jul 2025 15:37:19 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bc51D3ypYz6GDnS;
 Tue,  8 Jul 2025 23:41:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id B0D001404C5;
 Tue,  8 Jul 2025 23:42:08 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Jul 2025 17:41:59 +0200
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <imammedo@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <gustavo.romero@linaro.org>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <linuxarm@huawei.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH v7 05/12] hw/arm/virt: Factor out common SMMUV3 dt bindings
 code
Date: Tue, 8 Jul 2025 16:40:48 +0100
Message-ID: <20250708154055.101012-6-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20250708154055.101012-1-shameerali.kolothum.thodi@huawei.com>
References: <20250708154055.101012-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.203.177.241]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

No functional changes intended. This will be useful when we
add support for user-creatable smmuv3 device.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nathan Chen <nathanc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/virt.c | 54 +++++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 61a9a4fdc8..ee272b5b34 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1409,19 +1409,43 @@ static void create_pcie_irq_map(const MachineState *ms,
                            0x7           /* PCI irq */);
 }
 
+static void create_smmuv3_dt_bindings(const VirtMachineState *vms, hwaddr base,
+                                      hwaddr size, int irq)
+{
+    char *node;
+    const char compat[] = "arm,smmu-v3";
+    const char irq_names[] = "eventq\0priq\0cmdq-sync\0gerror";
+    MachineState *ms = MACHINE(vms);
+
+    node = g_strdup_printf("/smmuv3@%" PRIx64, base);
+    qemu_fdt_add_subnode(ms->fdt, node);
+    qemu_fdt_setprop(ms->fdt, node, "compatible", compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(ms->fdt, node, "reg", 2, base, 2, size);
+
+    qemu_fdt_setprop_cells(ms->fdt, node, "interrupts",
+            GIC_FDT_IRQ_TYPE_SPI, irq    , GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
+            GIC_FDT_IRQ_TYPE_SPI, irq + 1, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
+            GIC_FDT_IRQ_TYPE_SPI, irq + 2, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
+            GIC_FDT_IRQ_TYPE_SPI, irq + 3, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
+
+    qemu_fdt_setprop(ms->fdt, node, "interrupt-names", irq_names,
+                     sizeof(irq_names));
+
+    qemu_fdt_setprop(ms->fdt, node, "dma-coherent", NULL, 0);
+    qemu_fdt_setprop_cell(ms->fdt, node, "#iommu-cells", 1);
+    qemu_fdt_setprop_cell(ms->fdt, node, "phandle", vms->iommu_phandle);
+    g_free(node);
+}
+
 static void create_smmu(const VirtMachineState *vms,
                         PCIBus *bus)
 {
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
-    char *node;
-    const char compat[] = "arm,smmu-v3";
     int irq =  vms->irqmap[VIRT_SMMU];
     int i;
     hwaddr base = vms->memmap[VIRT_SMMU].base;
     hwaddr size = vms->memmap[VIRT_SMMU].size;
-    const char irq_names[] = "eventq\0priq\0cmdq-sync\0gerror";
     DeviceState *dev;
-    MachineState *ms = MACHINE(vms);
 
     if (vms->iommu != VIRT_IOMMU_SMMUV3 || !vms->iommu_phandle) {
         return;
@@ -1440,27 +1464,7 @@ static void create_smmu(const VirtMachineState *vms,
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
                            qdev_get_gpio_in(vms->gic, irq + i));
     }
-
-    node = g_strdup_printf("/smmuv3@%" PRIx64, base);
-    qemu_fdt_add_subnode(ms->fdt, node);
-    qemu_fdt_setprop(ms->fdt, node, "compatible", compat, sizeof(compat));
-    qemu_fdt_setprop_sized_cells(ms->fdt, node, "reg", 2, base, 2, size);
-
-    qemu_fdt_setprop_cells(ms->fdt, node, "interrupts",
-            GIC_FDT_IRQ_TYPE_SPI, irq    , GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
-            GIC_FDT_IRQ_TYPE_SPI, irq + 1, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
-            GIC_FDT_IRQ_TYPE_SPI, irq + 2, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
-            GIC_FDT_IRQ_TYPE_SPI, irq + 3, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
-
-    qemu_fdt_setprop(ms->fdt, node, "interrupt-names", irq_names,
-                     sizeof(irq_names));
-
-    qemu_fdt_setprop(ms->fdt, node, "dma-coherent", NULL, 0);
-
-    qemu_fdt_setprop_cell(ms->fdt, node, "#iommu-cells", 1);
-
-    qemu_fdt_setprop_cell(ms->fdt, node, "phandle", vms->iommu_phandle);
-    g_free(node);
+    create_smmuv3_dt_bindings(vms, base, size, irq);
 }
 
 static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
-- 
2.47.0


