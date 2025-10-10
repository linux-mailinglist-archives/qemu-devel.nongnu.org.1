Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE492BCC228
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Oct 2025 10:29:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v78Ta-0007DA-Hm; Fri, 10 Oct 2025 04:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v78TV-0007CM-7u
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:27:41 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v78TN-0004Uj-NZ
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:27:40 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxbNJrw+hoC5sUAA--.44247S3;
 Fri, 10 Oct 2025 16:27:23 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBxzsFpw+hos0LYAA--.56940S7;
 Fri, 10 Oct 2025 16:27:23 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 5/8] hw/loongarch/virt: Get PCI info from gpex config info
Date: Fri, 10 Oct 2025 16:27:17 +0800
Message-Id: <20251010082720.3943996-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251010082720.3943996-1-maobibo@loongson.cn>
References: <20251010082720.3943996-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxzsFpw+hos0LYAA--.56940S7
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

PCIE host bridge configuration information such as MMIO/Conf/IO base
and size can come from gpex config info.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt-acpi-build.c |  4 ++--
 hw/loongarch/virt-fdt-build.c  | 14 +++++++-------
 hw/loongarch/virt.c            | 16 +++++++++-------
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 8f3f1afac5..ca4ebf52eb 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -566,8 +566,8 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     acpi_add_table(table_offsets, tables_blob);
     {
         AcpiMcfgInfo mcfg = {
-           .base = VIRT_PCI_CFG_BASE,
-           .size = VIRT_PCI_CFG_SIZE,
+           .base = lvms->gpex.ecam.base,
+           .size = lvms->gpex.ecam.size,
         };
         build_mcfg(tables_blob, tables->linker, &mcfg, lvms->oem_id,
                    lvms->oem_table_id);
diff --git a/hw/loongarch/virt-fdt-build.c b/hw/loongarch/virt-fdt-build.c
index 728ce46699..5453805ca1 100644
--- a/hw/loongarch/virt-fdt-build.c
+++ b/hw/loongarch/virt-fdt-build.c
@@ -367,12 +367,12 @@ static void fdt_add_pcie_node(const LoongArchVirtMachineState *lvms,
                               uint32_t *pch_msi_phandle)
 {
     char *nodename;
-    hwaddr base_mmio = VIRT_PCI_MEM_BASE;
-    hwaddr size_mmio = VIRT_PCI_MEM_SIZE;
-    hwaddr base_pio = VIRT_PCI_IO_BASE;
-    hwaddr size_pio = VIRT_PCI_IO_SIZE;
-    hwaddr base_pcie = VIRT_PCI_CFG_BASE;
-    hwaddr size_pcie = VIRT_PCI_CFG_SIZE;
+    hwaddr base_mmio = lvms->gpex.mmio64.base;
+    hwaddr size_mmio = lvms->gpex.mmio64.size;
+    hwaddr base_pio = lvms->gpex.pio.base;
+    hwaddr size_pio = lvms->gpex.pio.size;
+    hwaddr base_pcie = lvms->gpex.ecam.base;
+    hwaddr size_pcie = lvms->gpex.ecam.size;
     hwaddr base = base_pcie;
     const MachineState *ms = MACHINE(lvms);
 
@@ -385,7 +385,7 @@ static void fdt_add_pcie_node(const LoongArchVirtMachineState *lvms,
     qemu_fdt_setprop_cell(ms->fdt, nodename, "#size-cells", 2);
     qemu_fdt_setprop_cell(ms->fdt, nodename, "linux,pci-domain", 0);
     qemu_fdt_setprop_cells(ms->fdt, nodename, "bus-range", 0,
-                           PCIE_MMCFG_BUS(VIRT_PCI_CFG_SIZE - 1));
+                           PCIE_MMCFG_BUS(size_pcie - 1));
     qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
     qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                  2, base_pcie, 2, size_pcie);
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index d3793ba8bc..ad891a5972 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -293,6 +293,7 @@ static void virt_devices_init(DeviceState *pch_pic,
     PCIBus *pci_bus;
     MemoryRegion *ecam_alias, *ecam_reg, *pio_alias, *pio_reg;
     MemoryRegion *mmio_alias, *mmio_reg;
+    hwaddr mmio_base, mmio_size;
     int i, irq;
 
     gpex_dev = qdev_new(TYPE_GPEX_HOST);
@@ -307,29 +308,30 @@ static void virt_devices_init(DeviceState *pch_pic,
     lvms->gpex.ecam.size = VIRT_PCI_CFG_SIZE;
     lvms->gpex.irq = VIRT_GSI_BASE + VIRT_DEVICE_IRQS;
     lvms->gpex.bus = pci_bus;
+    mmio_base = lvms->gpex.mmio64.base;
+    mmio_size = lvms->gpex.mmio64.size;
 
     /* Map only part size_ecam bytes of ECAM space */
     ecam_alias = g_new0(MemoryRegion, 1);
     ecam_reg = sysbus_mmio_get_region(d, 0);
     memory_region_init_alias(ecam_alias, OBJECT(gpex_dev), "pcie-ecam",
-                             ecam_reg, 0, VIRT_PCI_CFG_SIZE);
-    memory_region_add_subregion(get_system_memory(), VIRT_PCI_CFG_BASE,
+                             ecam_reg, 0, lvms->gpex.ecam.size);
+    memory_region_add_subregion(get_system_memory(), lvms->gpex.ecam.base,
                                 ecam_alias);
 
     /* Map PCI mem space */
     mmio_alias = g_new0(MemoryRegion, 1);
     mmio_reg = sysbus_mmio_get_region(d, 1);
     memory_region_init_alias(mmio_alias, OBJECT(gpex_dev), "pcie-mmio",
-                             mmio_reg, VIRT_PCI_MEM_BASE, VIRT_PCI_MEM_SIZE);
-    memory_region_add_subregion(get_system_memory(), VIRT_PCI_MEM_BASE,
-                                mmio_alias);
+                             mmio_reg, mmio_base, mmio_size);
+    memory_region_add_subregion(get_system_memory(), mmio_base, mmio_alias);
 
     /* Map PCI IO port space. */
     pio_alias = g_new0(MemoryRegion, 1);
     pio_reg = sysbus_mmio_get_region(d, 2);
     memory_region_init_alias(pio_alias, OBJECT(gpex_dev), "pcie-io", pio_reg,
-                             VIRT_PCI_IO_OFFSET, VIRT_PCI_IO_SIZE);
-    memory_region_add_subregion(get_system_memory(), VIRT_PCI_IO_BASE,
+                             VIRT_PCI_IO_OFFSET, lvms->gpex.pio.size);
+    memory_region_add_subregion(get_system_memory(), lvms->gpex.pio.base,
                                 pio_alias);
 
     for (i = 0; i < PCI_NUM_PINS; i++) {
-- 
2.39.3


