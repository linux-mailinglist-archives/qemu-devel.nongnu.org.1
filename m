Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 659F17D6652
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:11:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvZtK-0005mR-E4; Wed, 25 Oct 2023 05:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1qvWSk-0006sl-21; Wed, 25 Oct 2023 01:29:50 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1qvWSh-0001Km-UN; Wed, 25 Oct 2023 01:29:49 -0400
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
 by Atcsqr.andestech.com with ESMTP id 39P5FnpH024776;
 Wed, 25 Oct 2023 13:15:49 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 39P5FSdZ024655;
 Wed, 25 Oct 2023 13:15:28 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from ethan84-VirtualBox.andestech.com (10.0.12.51) by
 ATCPCS16.andestech.com (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; 
 Wed, 25 Oct 2023 13:15:23 +0800
To: <qemu-devel@nongnu.org>
CC: Ethan Chen <ethan84@andestech.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>, Weiwei Li
 <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, "open list:RISC-V TCG CPUs"
 <qemu-riscv@nongnu.org>
Subject: [PATCH 6/6] hw/riscv/virt: Add IOPMP support
Date: Wed, 25 Oct 2023 13:14:30 +0800
Message-ID: <20231025051430.493079-7-ethan84@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025051430.493079-1-ethan84@andestech.com>
References: <20231025051430.493079-1-ethan84@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.12.51]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 39P5FnpH024776
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 25 Oct 2023 05:09:28 -0400
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
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

- Add 'iopmp=on' option to enable iopmp
- Add 'iopmp_cascade=on' option to enable iopmp cascading.

Signed-off-by: Ethan Chen <ethan84@andestech.com>
---
 hw/riscv/Kconfig        |  2 ++
 hw/riscv/virt.c         | 72 +++++++++++++++++++++++++++++++++++++++--
 include/hw/riscv/virt.h | 10 +++++-
 3 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index b6a5eb4452..c30a104aa4 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -45,6 +45,8 @@ config RISCV_VIRT
     select FW_CFG_DMA
     select PLATFORM_BUS
     select ACPI
+    select ATCDMAC300
+    select RISCV_IOPMP
 
 config SHAKTI_C
     bool
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 9de578c756..d3d4320c73 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -53,6 +53,9 @@
 #include "hw/display/ramfb.h"
 #include "hw/acpi/aml-build.h"
 #include "qapi/qapi-visit-common.h"
+#include "hw/misc/riscv_iopmp.h"
+#include "hw/dma/atcdmac300.h"
+
 
 /*
  * The virt machine physical address space used by some of the devices
@@ -97,6 +100,9 @@ static const MemMapEntry virt_memmap[] = {
     [VIRT_UART0] =        { 0x10000000,         0x100 },
     [VIRT_VIRTIO] =       { 0x10001000,        0x1000 },
     [VIRT_FW_CFG] =       { 0x10100000,          0x18 },
+    [VIRT_IOPMP] =        { 0x10200000,      0x100000 },
+    [VIRT_IOPMP2] =       { 0x10300000,      0x100000 },
+    [VIRT_DMAC] =         { 0x10400000,      0x100000 },
     [VIRT_FLASH] =        { 0x20000000,     0x4000000 },
     [VIRT_IMSIC_M] =      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
     [VIRT_IMSIC_S] =      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
@@ -1527,13 +1533,32 @@ static void virt_machine_init(MachineState *machine)
 
     create_platform_bus(s, mmio_irqchip);
 
-    serial_mm_init(system_memory, memmap[VIRT_UART0].base,
-        0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
+    serial_mm_init(system_memory, memmap[VIRT_UART0].base + 0x20,
+        0x2, qdev_get_gpio_in(DEVICE(mmio_irqchip), UART0_IRQ), 38400,
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
     sysbus_create_simple("goldfish_rtc", memmap[VIRT_RTC].base,
         qdev_get_gpio_in(mmio_irqchip, RTC_IRQ));
 
+    /* DMAC */
+    DeviceState *dmac_dev = atcdmac300_create("atcdmac300",
+        memmap[VIRT_DMAC].base, memmap[VIRT_DMAC].size,
+        qdev_get_gpio_in(DEVICE(mmio_irqchip), DMAC_IRQ));
+
+    if (s->have_iopmp) {
+        /* IOPMP */
+        DeviceState *iopmp_dev = iopmp_create(memmap[VIRT_IOPMP].base,
+            qdev_get_gpio_in(DEVICE(mmio_irqchip), IOPMP_IRQ));
+        /* DMA with IOPMP */
+        atcdmac300_connect_iopmp_as(dmac_dev, &(IOPMP(iopmp_dev)->iopmp_as), 0);
+        if (s->have_iopmp_cascade) {
+            DeviceState *iopmp_dev2 = iopmp_create(memmap[VIRT_IOPMP2].base,
+                qdev_get_gpio_in(DEVICE(mmio_irqchip), IOPMP2_IRQ));
+            cascade_iopmp(iopmp_dev, iopmp_dev2);
+        }
+    }
+
+
     for (i = 0; i < ARRAY_SIZE(s->flash); i++) {
         /* Map legacy -drive if=pflash to machine properties */
         pflash_cfi01_legacy_drive(s->flash[i],
@@ -1628,6 +1653,35 @@ static void virt_set_aclint(Object *obj, bool value, Error **errp)
     s->have_aclint = value;
 }
 
+static bool virt_get_iopmp(Object *obj, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+
+    return s->have_iopmp;
+}
+
+static void virt_set_iopmp(Object *obj, bool value, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+
+    s->have_iopmp = value;
+}
+
+static bool virt_get_iopmp_cascade(Object *obj, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+
+    return s->have_iopmp_cascade;
+}
+
+static void virt_set_iopmp_cascade(Object *obj, bool value, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+
+    s->have_iopmp_cascade = value;
+}
+
+
 bool virt_is_acpi_enabled(RISCVVirtState *s)
 {
     return s->acpi != ON_OFF_AUTO_OFF;
@@ -1730,6 +1784,20 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
                               NULL, NULL);
     object_class_property_set_description(oc, "acpi",
                                           "Enable ACPI");
+
+    object_class_property_add_bool(oc, "iopmp", virt_get_iopmp,
+                                   virt_set_iopmp);
+    object_class_property_set_description(oc, "iopmp",
+                                          "Set on/off to enable/disable "
+                                          "iopmp device");
+
+    object_class_property_add_bool(oc, "iopmp-cascade",
+                                   virt_get_iopmp_cascade,
+                                   virt_set_iopmp_cascade);
+    object_class_property_set_description(oc, "iopmp-cascade",
+                                          "Set on/off to enable/disable "
+                                          "iopmp2 device which is cascaded by "
+                                          "iopmp1 device");
 }
 
 static const TypeInfo virt_machine_typeinfo = {
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index e5c474b26e..5fa2944d29 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -54,6 +54,8 @@ struct RISCVVirtState {
 
     int fdt_size;
     bool have_aclint;
+    bool have_iopmp;
+    bool have_iopmp_cascade;
     RISCVVirtAIAType aia_type;
     int aia_guests;
     char *oem_id;
@@ -82,12 +84,18 @@ enum {
     VIRT_PCIE_MMIO,
     VIRT_PCIE_PIO,
     VIRT_PLATFORM_BUS,
-    VIRT_PCIE_ECAM
+    VIRT_PCIE_ECAM,
+    VIRT_IOPMP,
+    VIRT_IOPMP2,
+    VIRT_DMAC,
 };
 
 enum {
     UART0_IRQ = 10,
     RTC_IRQ = 11,
+    DMAC_IRQ = 12,
+    IOPMP_IRQ = 13,
+    IOPMP2_IRQ = 14,
     VIRTIO_IRQ = 1, /* 1 to 8 */
     VIRTIO_COUNT = 8,
     PCIE_IRQ = 0x20, /* 32 to 35 */
-- 
2.34.1


