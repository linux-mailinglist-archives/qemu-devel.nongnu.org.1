Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4C9749A69
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 13:17:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHMz6-0004a2-36; Thu, 06 Jul 2023 07:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qHMyu-0004Tw-4D; Thu, 06 Jul 2023 07:17:04 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qHMyr-0007fY-IS; Thu, 06 Jul 2023 07:17:03 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id A11D4746E5A;
 Thu,  6 Jul 2023 13:16:42 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7689274645F; Thu,  6 Jul 2023 13:16:42 +0200 (CEST)
Message-Id: <f4ad9af42197a92dd1d0b56c21316dbdad240ee4.1688641673.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1688641673.git.balaton@eik.bme.hu>
References: <cover.1688641673.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [RESEND PATCH v3 1/4] ppc440_pcix: Stop using system io region for
 PCI bus
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
    philmd@linaro.org
Date: Thu,  6 Jul 2023 13:16:42 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

Reduce the iomem region to 64K and use it for the PCI io space and map
it directly from the board without an intermediate alias that is not
really needed.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/ppc440_pcix.c | 9 ++++++---
 hw/ppc/sam460ex.c    | 6 +-----
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index 899558b055..54286cfef4 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -23,6 +23,7 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "qemu/units.h"
 #include "hw/irq.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
@@ -491,10 +492,11 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
     s = PPC440_PCIX_HOST_BRIDGE(dev);
 
     sysbus_init_irq(sbd, &s->irq);
-    memory_region_init(&s->busmem, OBJECT(dev), "pci bus memory", UINT64_MAX);
+    memory_region_init(&s->busmem, OBJECT(dev), "pci-mem", UINT64_MAX);
+    memory_region_init(&s->iomem, OBJECT(dev), "pci-io", 64 * KiB);
     h->bus = pci_register_root_bus(dev, NULL, ppc440_pcix_set_irq,
-                         ppc440_pcix_map_irq, &s->irq, &s->busmem,
-                         get_system_io(), PCI_DEVFN(0, 0), 1, TYPE_PCI_BUS);
+                         ppc440_pcix_map_irq, &s->irq, &s->busmem, &s->iomem,
+                         PCI_DEVFN(0, 0), 1, TYPE_PCI_BUS);
 
     s->dev = pci_create_simple(h->bus, PCI_DEVFN(0, 0), "ppc4xx-host-bridge");
 
@@ -514,6 +516,7 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->container, PCIC0_CFGDATA, &h->data_mem);
     memory_region_add_subregion(&s->container, PPC440_REG_BASE, &s->regs);
     sysbus_init_mmio(sbd, &s->container);
+    sysbus_init_mmio(sbd, &s->iomem);
 }
 
 static void ppc440_pcix_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index d446cfc37b..7da38bd58e 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -269,7 +269,6 @@ static void main_cpu_reset(void *opaque)
 
 static void sam460ex_init(MachineState *machine)
 {
-    MemoryRegion *isa = g_new(MemoryRegion, 1);
     MemoryRegion *l2cache_ram = g_new(MemoryRegion, 1);
     DeviceState *uic[4];
     int i;
@@ -441,12 +440,9 @@ static void sam460ex_init(MachineState *machine)
     /* All PCI irqs are connected to the same UIC pin (cf. UBoot source) */
     dev = sysbus_create_simple("ppc440-pcix-host", 0xc0ec00000,
                                qdev_get_gpio_in(uic[1], 0));
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, 0xc08000000);
     pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
 
-    memory_region_init_alias(isa, NULL, "isa_mmio", get_system_io(),
-                             0, 0x10000);
-    memory_region_add_subregion(get_system_memory(), 0xc08000000, isa);
-
     /* PCI devices */
     pci_create_simple(pci_bus, PCI_DEVFN(6, 0), "sm501");
     /* SoC has a single SATA port but we don't emulate that yet
-- 
2.30.9


