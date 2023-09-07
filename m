Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB98797047
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 08:26:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe8SX-0004Kg-LU; Thu, 07 Sep 2023 02:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaotianrui@loongson.cn>)
 id 1qe8SO-0004DU-I3
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 02:25:37 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhaotianrui@loongson.cn>) id 1qe8SJ-0005Yo-SB
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 02:25:36 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxJujPbPlkeR4hAA--.7126S3;
 Thu, 07 Sep 2023 14:25:19 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxDCPPbPlkbiRwAA--.53472S2; 
 Thu, 07 Sep 2023 14:25:19 +0800 (CST)
From: Tianrui Zhao <zhaotianrui@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, zhaotianrui@loongson.cn, gaosong@loongson.cn
Subject: [PATCH v2] hw/loongarch: Add virtio-mmio bus support
Date: Thu,  7 Sep 2023 14:25:19 +0800
Message-Id: <20230907062519.3304854-1-zhaotianrui@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxDCPPbPlkbiRwAA--.53472S2
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=zhaotianrui@loongson.cn; helo=mail.loongson.cn
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

Add virtio-mmio bus support for LoongArch, so that devices
could be added in the virtio-mmio bus. And add it's address
info and interrupt number into fdt and dsdt.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
---
 hw/loongarch/Kconfig       |  1 +
 hw/loongarch/acpi-build.c  | 20 ++++++++++++++++++++
 hw/loongarch/virt.c        | 22 ++++++++++++++++++++++
 include/hw/pci-host/ls7a.h |  3 +++
 4 files changed, 46 insertions(+)

diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
index 1e7c5b43c5..01ab8ce8e7 100644
--- a/hw/loongarch/Kconfig
+++ b/hw/loongarch/Kconfig
@@ -22,3 +22,4 @@ config LOONGARCH_VIRT
     select DIMM
     select PFLASH_CFI01
     select ACPI_HMAT
+    select VIRTIO_MMIO
diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index ae292fc543..304bfe3958 100644
--- a/hw/loongarch/acpi-build.c
+++ b/hw/loongarch/acpi-build.c
@@ -363,6 +363,25 @@ static void acpi_dsdt_add_tpm(Aml *scope, LoongArchMachineState *vms)
 }
 #endif
 
+static void acpi_dsdt_add_virtio(Aml *scope)
+{
+    uint32_t irq = VIRT_VIRTIO_MMIO_IRQ;
+    hwaddr base = VIRT_VIRTIO_MMIO_BASE;
+    hwaddr size = VIRT_VIRTIO_MMIO_SIZE;
+    Aml *dev = aml_device("VR%02u", 0);
+
+    aml_append(dev, aml_name_decl("_HID", aml_string("LNRO0005")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
+    aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
+
+    Aml *crs = aml_resource_template();
+    aml_append(crs, aml_memory32_fixed(base, size, AML_READ_WRITE));
+    aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
+               AML_EXCLUSIVE, &irq, 1));
+    aml_append(dev, aml_name_decl("_CRS", crs));
+    aml_append(scope, dev);
+}
+
 /* build DSDT */
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
@@ -381,6 +400,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 #ifdef CONFIG_TPM
     acpi_dsdt_add_tpm(dsdt, lams);
 #endif
+    acpi_dsdt_add_virtio(dsdt);
     /* System State Package */
     scope = aml_scope("\\");
     pkg = aml_package(4);
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 2629128aed..4732a1bc21 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -116,6 +116,22 @@ static void fdt_add_rtc_node(LoongArchMachineState *lams)
     g_free(nodename);
 }
 
+static void fdt_add_virtio_mmio_node(LoongArchMachineState *lams)
+{
+    char *nodename;
+    hwaddr base = VIRT_VIRTIO_MMIO_BASE;
+    hwaddr size = VIRT_VIRTIO_MMIO_SIZE;
+    MachineState *ms = MACHINE(lams);
+
+    nodename = g_strdup_printf("/virtio_mmio@%" PRIx64, base);
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop_string(ms->fdt, nodename,
+                            "compatible", "virtio,mmio");
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
+                                 2, base, 2, size);
+    g_free(nodename);
+}
+
 static void fdt_add_uart_node(LoongArchMachineState *lams)
 {
     char *nodename;
@@ -560,6 +576,12 @@ static void loongarch_devices_init(DeviceState *pch_pic, LoongArchMachineState *
                          VIRT_RTC_IRQ - VIRT_GSI_BASE));
     fdt_add_rtc_node(lams);
 
+    /* virtio-mmio device */
+    sysbus_create_simple("virtio-mmio", VIRT_VIRTIO_MMIO_BASE,
+                         qdev_get_gpio_in(pch_pic,
+                         VIRT_VIRTIO_MMIO_IRQ - VIRT_GSI_BASE));
+    fdt_add_virtio_mmio_node(lams);
+
     pm_mem = g_new(MemoryRegion, 1);
     memory_region_init_io(pm_mem, NULL, &loongarch_virt_pm_ops,
                           NULL, "loongarch_virt_pm", PM_SIZE);
diff --git a/include/hw/pci-host/ls7a.h b/include/hw/pci-host/ls7a.h
index e753449593..38bcc41dee 100644
--- a/include/hw/pci-host/ls7a.h
+++ b/include/hw/pci-host/ls7a.h
@@ -42,6 +42,9 @@
 #define VIRT_RTC_REG_BASE        (VIRT_MISC_REG_BASE + 0x00050100)
 #define VIRT_RTC_LEN             0x100
 #define VIRT_SCI_IRQ             (VIRT_GSI_BASE + 4)
+#define VIRT_VIRTIO_MMIO_IRQ     (VIRT_GSI_BASE + 7)
+#define VIRT_VIRTIO_MMIO_BASE    0x1e200000
+#define VIRT_VIRTIO_MMIO_SIZE    0x200
 
 #define VIRT_PLATFORM_BUS_BASEADDRESS   0x16000000
 #define VIRT_PLATFORM_BUS_SIZE          0x2000000
-- 
2.39.1


