Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13298AF6F5B
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Jul 2025 11:54:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXGaX-0007wv-RW; Thu, 03 Jul 2025 05:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uXGZh-0007Hv-EQ
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:49:52 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uXGZc-0000RH-Vt
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:49:49 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxGHE0UmZoSMAhAQ--.10892S3;
 Thu, 03 Jul 2025 17:49:40 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCxM+QuUmZoNv4HAA--.46770S8;
 Thu, 03 Jul 2025 17:49:40 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH v4 06/11] hw/loongarch: AVEC controller add a MemoryRegion
Date: Thu,  3 Jul 2025 17:26:45 +0800
Message-Id: <20250703092650.2598059-7-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250703092650.2598059-1-gaosong@loongson.cn>
References: <20250703092650.2598059-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxM+QuUmZoNv4HAA--.46770S8
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

the AVEC controller use [2fe00000-2ff000000) Memory.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_avec.c         | 24 ++++++++++++++++++++
 hw/loongarch/virt.c              | 39 +++++++++++++++++++++++++++++++-
 include/hw/intc/loongarch_avec.h |  1 +
 include/hw/loongarch/virt.h      |  1 +
 include/hw/pci-host/ls7a.h       |  2 ++
 5 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/hw/intc/loongarch_avec.c b/hw/intc/loongarch_avec.c
index 5a3e7ecc03..253bab5461 100644
--- a/hw/intc/loongarch_avec.c
+++ b/hw/intc/loongarch_avec.c
@@ -17,6 +17,24 @@
 #include "trace.h"
 #include "hw/qdev-properties.h"
 
+static uint64_t loongarch_avec_mem_read(void *opaque,
+                                        hwaddr addr, unsigned size)
+{
+    return 0;
+}
+
+static void loongarch_avec_mem_write(void *opaque, hwaddr addr,
+                                     uint64_t val, unsigned size)
+{
+    return;
+}
+
+
+static const MemoryRegionOps loongarch_avec_ops = {
+    .read = loongarch_avec_mem_read,
+    .write = loongarch_avec_mem_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
 
 static void loongarch_avec_realize(DeviceState *dev, Error **errp)
 {
@@ -39,6 +57,12 @@ static void loongarch_avec_unrealize(DeviceState *dev)
 
 static void loongarch_avec_init(Object *obj)
 {
+    LoongArchAVECState *s = LOONGARCH_AVEC(obj);
+    SysBusDevice *shd = SYS_BUS_DEVICE(obj);
+    memory_region_init_io(&s->avec_mmio, OBJECT(s), &loongarch_avec_ops,
+                          s, TYPE_LOONGARCH_AVEC, VIRT_AVEC_MSG_OFFSET);
+    sysbus_init_mmio(shd, &s->avec_mmio);
+    msi_nonbroken = true;
     return;
 }
 
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 26db1bbd68..1245ff985e 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -28,6 +28,7 @@
 #include "hw/intc/loongarch_extioi.h"
 #include "hw/intc/loongarch_pch_pic.h"
 #include "hw/intc/loongarch_pch_msi.h"
+#include "hw/intc/loongarch_avec.h"
 #include "hw/pci-host/ls7a.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/misc/unimp.h"
@@ -382,7 +383,7 @@ static void virt_cpu_irq_init(LoongArchVirtMachineState *lvms)
 static void virt_irq_init(LoongArchVirtMachineState *lvms)
 {
     DeviceState *pch_pic, *pch_msi;
-    DeviceState *ipi, *extioi;
+    DeviceState *ipi, *extioi, *avec;
     SysBusDevice *d;
     int i, start, num;
 
@@ -428,6 +429,33 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
      *    +--------+ +---------+ +---------+
      *    | UARTs  | | Devices | | Devices |
      *    +--------+ +---------+ +---------+
+     *
+     *
+     *  Advanced Extended IRQ model
+     *
+     *  +-----+     +---------------------------------+     +-------+
+     *  | IPI | --> |        CPUINTC                  | <-- | Timer |
+     *  +-----+     +---------------------------------+     +-------+
+     *                      ^            ^          ^
+     *                      |            |          |
+     *             +-------------+ +----------+ +---------+     +-------+
+     *             |   EIOINTC   | | AVECINTC | | LIOINTC | <-- | UARTs |
+     *             +-------------+ +----------+ +---------+     +-------+
+     *             ^            ^       ^
+     *             |            |       |
+     *        +---------+  +---------+  |
+     *        | PCH-PIC |  | PCH-MSI |  |
+     *        +---------+  +---------+  |
+     *          ^     ^           ^     |
+     *          |     |           |     |
+     *  +---------+ +---------+ +---------+
+     *  | Devices | | PCH-LPC | | Devices |
+     *  +---------+ +---------+ +---------+
+     *                  ^
+     *                  |
+     *             +---------+
+     *             | Devices |
+     *             +---------+
      */
 
     /* Create IPI device */
@@ -435,6 +463,15 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
     lvms->ipi = ipi;
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
 
+    /* Create AVEC device*/
+    if (virt_is_avecintc_enabled(lvms)) {
+        avec = qdev_new(TYPE_LOONGARCH_AVEC);
+        lvms->avec = avec;
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(avec), &error_fatal);
+        memory_region_add_subregion(get_system_memory(), VIRT_AVEC_BASE,
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(avec), 0));
+    }
+
     /* Create EXTIOI device */
     extioi = qdev_new(TYPE_LOONGARCH_EXTIOI);
     lvms->extioi = extioi;
diff --git a/include/hw/intc/loongarch_avec.h b/include/hw/intc/loongarch_avec.h
index 92e2ca9590..3e8cf7d2c1 100644
--- a/include/hw/intc/loongarch_avec.h
+++ b/include/hw/intc/loongarch_avec.h
@@ -23,6 +23,7 @@ typedef struct AVECCore {
 
 struct LoongArchAVECState {
     SysBusDevice parent_obj;
+    MemoryRegion avec_mmio;
     AVECCore *cpu;
     uint32_t num_cpu;
 };
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 9e5b32292b..134a7e9763 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -89,6 +89,7 @@ struct LoongArchVirtMachineState {
     unsigned int memmap_entries;
     uint64_t misc_feature;
     uint64_t misc_status;
+    DeviceState *avec;
 };
 
 #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
diff --git a/include/hw/pci-host/ls7a.h b/include/hw/pci-host/ls7a.h
index 79d4ea8501..199f47ecc0 100644
--- a/include/hw/pci-host/ls7a.h
+++ b/include/hw/pci-host/ls7a.h
@@ -24,6 +24,8 @@
 #define VIRT_PCH_REG_BASE        0x10000000UL
 #define VIRT_IOAPIC_REG_BASE     (VIRT_PCH_REG_BASE)
 #define VIRT_PCH_MSI_ADDR_LOW    0x2FF00000UL
+#define VIRT_AVEC_MSG_OFFSET     0x1000000UL
+#define VIRT_AVEC_BASE           (VIRT_PCH_MSI_ADDR_LOW - VIRT_AVEC_MSG_OFFSET)
 #define VIRT_PCH_REG_SIZE        0x400
 #define VIRT_PCH_MSI_SIZE        0x8
 
-- 
2.34.1


