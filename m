Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFB5BD1B1B
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Oct 2025 08:36:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8C9k-0003Oa-2Y; Mon, 13 Oct 2025 02:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v8C9b-0003Nn-MA
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 02:35:31 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v8C9Y-0008Br-6c
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 02:35:31 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Axjr+mnexoWHkVAA--.44279S3;
 Mon, 13 Oct 2025 14:35:18 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBxC8GlnexozkDdAA--.57976S3;
 Mon, 13 Oct 2025 14:35:18 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/loongarch/virt: Remove header file ls7a.h
Date: Mon, 13 Oct 2025 14:35:15 +0800
Message-Id: <20251013063516.688936-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251013063516.688936-1-maobibo@loongson.cn>
References: <20251013063516.688936-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxC8GlnexozkDdAA--.57976S3
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

LoongArch virt machine uses GPEX PCIE host bridge rather than 7A host
bridge. Remove header file ls7a.h and put hardware information to file
include/hw/loongarch/virt.h

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 MAINTAINERS                            |  1 -
 hw/intc/loongarch_pic_kvm.c            |  1 -
 hw/loongarch/virt-acpi-build.c         |  1 -
 hw/loongarch/virt-fdt-build.c          |  1 -
 hw/loongarch/virt.c                    |  1 -
 include/hw/intc/loongarch_pic_common.h |  2 +-
 include/hw/loongarch/virt.h            | 39 ++++++++++++++++++++++++++
 include/hw/pci-host/ls7a.h             | 39 --------------------------
 8 files changed, 40 insertions(+), 45 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 84cfd85e1f..0c766961f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1308,7 +1308,6 @@ F: include/hw/intc/loongarch_*.h
 F: include/hw/intc/loongson_ipi_common.h
 F: hw/intc/loongarch_*.c
 F: hw/intc/loongson_ipi_common.c
-F: include/hw/pci-host/ls7a.h
 F: hw/rtc/ls7a_rtc.c
 F: gdb-xml/loongarch*.xml
 
diff --git a/hw/intc/loongarch_pic_kvm.c b/hw/intc/loongarch_pic_kvm.c
index dd504ec6a6..6cfddf4520 100644
--- a/hw/intc/loongarch_pic_kvm.c
+++ b/hw/intc/loongarch_pic_kvm.c
@@ -10,7 +10,6 @@
 #include "hw/boards.h"
 #include "hw/intc/loongarch_pch_pic.h"
 #include "hw/loongarch/virt.h"
-#include "hw/pci-host/ls7a.h"
 #include "system/kvm.h"
 
 static void kvm_pch_pic_access_reg(int fd, uint64_t addr, void *val, bool write)
diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 8c2228a772..3694c9827f 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -21,7 +21,6 @@
 #include "system/reset.h"
 
 /* Supported chipsets: */
-#include "hw/pci-host/ls7a.h"
 #include "hw/loongarch/virt.h"
 
 #include "hw/acpi/utils.h"
diff --git a/hw/loongarch/virt-fdt-build.c b/hw/loongarch/virt-fdt-build.c
index 728ce46699..1f0ba01f71 100644
--- a/hw/loongarch/virt-fdt-build.c
+++ b/hw/loongarch/virt-fdt-build.c
@@ -12,7 +12,6 @@
 #include "hw/loader.h"
 #include "hw/loongarch/virt.h"
 #include "hw/pci-host/gpex.h"
-#include "hw/pci-host/ls7a.h"
 #include "system/device_tree.h"
 #include "system/reset.h"
 #include "target/loongarch/cpu.h"
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index c1760423ee..efd1f9ac49 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -29,7 +29,6 @@
 #include "hw/intc/loongarch_pch_pic.h"
 #include "hw/intc/loongarch_pch_msi.h"
 #include "hw/intc/loongarch_dintc.h"
-#include "hw/pci-host/ls7a.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/misc/unimp.h"
 #include "hw/loongarch/fw_cfg.h"
diff --git a/include/hw/intc/loongarch_pic_common.h b/include/hw/intc/loongarch_pic_common.h
index f774c975d4..675ba96e64 100644
--- a/include/hw/intc/loongarch_pic_common.h
+++ b/include/hw/intc/loongarch_pic_common.h
@@ -7,7 +7,7 @@
 #ifndef HW_LOONGARCH_PIC_COMMON_H
 #define HW_LOONGARCH_PIC_COMMON_H
 
-#include "hw/pci-host/ls7a.h"
+#include "hw/loongarch/virt.h"
 #include "hw/sysbus.h"
 
 #define PCH_PIC_INT_ID                  0x00
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 76fa57cd07..0cc1b499a7 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -25,6 +25,7 @@
 #define IOCSRF_VM               11
 #define IOCSRF_DMSI             15
 
+/* IOCSR region */
 #define VERSION_REG             0x0
 #define FEATURE_REG             0x8
 #define VENDOR_REG              0x10
@@ -36,6 +37,18 @@
 
 #define LOONGARCH_MAX_CPUS      256
 
+/* MMIO memory region */
+#define VIRT_PCH_REG_BASE       0x10000000UL
+#define VIRT_PCH_REG_SIZE       0x400
+#define VIRT_IOAPIC_REG_BASE    (VIRT_PCH_REG_BASE)
+#define VIRT_MISC_REG_BASE      (VIRT_PCH_REG_BASE + 0x00080000)
+#define VIRT_RTC_REG_BASE       (VIRT_MISC_REG_BASE + 0x00050100)
+#define VIRT_RTC_LEN            0x100
+#define VIRT_PLATFORM_BUS_BASEADDRESS   0x16000000UL
+#define VIRT_PLATFORM_BUS_SIZE          0x02000000
+#define VIRT_PCI_IO_BASE        0x18004000UL
+#define VIRT_PCI_IO_OFFSET      0x4000
+#define VIRT_PCI_IO_SIZE        0xC000
 #define VIRT_FWCFG_BASE         0x1e020000UL
 #define VIRT_BIOS_BASE          0x1c000000UL
 #define VIRT_BIOS_SIZE          (16 * MiB)
@@ -44,6 +57,16 @@
 #define VIRT_FLASH0_SIZE        VIRT_BIOS_SIZE
 #define VIRT_FLASH1_BASE        0x1d000000UL
 #define VIRT_FLASH1_SIZE        (16 * MiB)
+#define VIRT_UART_BASE          0x1fe001e0UL
+#define VIRT_UART_SIZE          0x100
+#define VIRT_PCI_CFG_BASE       0x20000000UL
+#define VIRT_PCI_CFG_SIZE       0x08000000UL
+#define VIRT_DINTC_BASE         0x2FE00000UL
+#define VIRT_DINTC_SIZE         0x00100000UL
+#define VIRT_PCH_MSI_ADDR_LOW   0x2FF00000UL
+#define VIRT_PCH_MSI_SIZE       0x8
+#define VIRT_PCI_MEM_BASE       0x40000000UL
+#define VIRT_PCI_MEM_SIZE       0x40000000UL
 
 #define VIRT_LOWMEM_BASE        0
 #define VIRT_LOWMEM_SIZE        0x10000000
@@ -53,6 +76,22 @@
 #define VIRT_GED_REG_ADDR       QEMU_ALIGN_UP(VIRT_GED_MEM_ADDR + MEMORY_HOTPLUG_IO_LEN, 4)
 #define VIRT_GED_CPUHP_ADDR     QEMU_ALIGN_UP(VIRT_GED_REG_ADDR + ACPI_GED_REG_COUNT, 4)
 
+/*
+ * GSI_BASE is hard-coded with 64 in linux kernel, else kernel fails to boot
+ * 0  - 15  GSI for ISA devices even if there is no ISA devices
+ * 16 - 63  GSI for CPU devices such as timers/perf monitor etc
+ * 64 -     GSI for external devices
+ */
+#define VIRT_PCH_PIC_IRQ_NUM     32
+#define VIRT_GSI_BASE            64
+#define VIRT_DEVICE_IRQS         16
+#define VIRT_UART_IRQ            (VIRT_GSI_BASE + 2)
+#define VIRT_UART_COUNT          4
+#define VIRT_RTC_IRQ             (VIRT_GSI_BASE + 6)
+#define VIRT_SCI_IRQ             (VIRT_GSI_BASE + 7)
+#define VIRT_PLATFORM_BUS_IRQ    (VIRT_GSI_BASE + 8)
+#define VIRT_PLATFORM_BUS_NUM_IRQS      2
+
 #define COMMAND_LINE_SIZE       512
 
 #define FDT_BASE                0x100000
diff --git a/include/hw/pci-host/ls7a.h b/include/hw/pci-host/ls7a.h
index bfdbfe3614..33e7942de9 100644
--- a/include/hw/pci-host/ls7a.h
+++ b/include/hw/pci-host/ls7a.h
@@ -13,43 +13,4 @@
 #include "qemu/range.h"
 #include "qom/object.h"
 
-#define VIRT_PCI_MEM_BASE        0x40000000UL
-#define VIRT_PCI_MEM_SIZE        0x40000000UL
-#define VIRT_PCI_IO_OFFSET       0x4000
-#define VIRT_PCI_CFG_BASE        0x20000000
-#define VIRT_PCI_CFG_SIZE        0x08000000
-#define VIRT_PCI_IO_BASE         0x18004000UL
-#define VIRT_PCI_IO_SIZE         0xC000
-
-#define VIRT_PCH_REG_BASE        0x10000000UL
-#define VIRT_IOAPIC_REG_BASE     (VIRT_PCH_REG_BASE)
-#define VIRT_PCH_MSI_ADDR_LOW    0x2FF00000UL
-#define VIRT_DINTC_SIZE          0x100000UL
-#define VIRT_DINTC_BASE          0x2FE00000UL
-#define VIRT_PCH_REG_SIZE        0x400
-#define VIRT_PCH_MSI_SIZE        0x8
-
-/*
- * GSI_BASE is hard-coded with 64 in linux kernel, else kernel fails to boot
- * 0  - 15  GSI for ISA devices even if there is no ISA devices
- * 16 - 63  GSI for CPU devices such as timers/perf monitor etc
- * 64 -     GSI for external devices
- */
-#define VIRT_PCH_PIC_IRQ_NUM     32
-#define VIRT_GSI_BASE            64
-#define VIRT_DEVICE_IRQS         16
-#define VIRT_UART_COUNT          4
-#define VIRT_UART_IRQ            (VIRT_GSI_BASE + 2)
-#define VIRT_UART_BASE           0x1fe001e0
-#define VIRT_UART_SIZE           0x100
-#define VIRT_RTC_IRQ             (VIRT_GSI_BASE + 6)
-#define VIRT_MISC_REG_BASE       (VIRT_PCH_REG_BASE + 0x00080000)
-#define VIRT_RTC_REG_BASE        (VIRT_MISC_REG_BASE + 0x00050100)
-#define VIRT_RTC_LEN             0x100
-#define VIRT_SCI_IRQ             (VIRT_GSI_BASE + 7)
-
-#define VIRT_PLATFORM_BUS_BASEADDRESS   0x16000000
-#define VIRT_PLATFORM_BUS_SIZE          0x2000000
-#define VIRT_PLATFORM_BUS_NUM_IRQS      2
-#define VIRT_PLATFORM_BUS_IRQ           (VIRT_GSI_BASE + 8)
 #endif
-- 
2.39.3


