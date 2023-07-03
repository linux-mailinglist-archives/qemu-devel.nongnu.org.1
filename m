Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8C474659A
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 00:04:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGRdO-0003cp-Tg; Mon, 03 Jul 2023 18:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGRdL-0003aQ-Sz; Mon, 03 Jul 2023 18:02:59 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGRdJ-0004BJ-TW; Mon, 03 Jul 2023 18:02:59 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 12881748A5E;
 Tue,  4 Jul 2023 00:02:41 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E441D748A4D; Tue,  4 Jul 2023 00:02:40 +0200 (CEST)
Message-Id: <9b24ce79c6181a9cd49eab09a1291eb1f039a26a.1688421085.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1688421085.git.balaton@eik.bme.hu>
References: <cover.1688421085.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 08/13] ppc440: Remove ppc460ex_pcie_init legacy init function
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Tue,  4 Jul 2023 00:02:40 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

After previous changes we can now remove the legacy init function and
move the device creation to board code.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/ppc440.h         |  1 -
 hw/ppc/ppc440_uc.c      | 21 ---------------------
 hw/ppc/sam460ex.c       | 17 ++++++++++++++++-
 include/hw/ppc/ppc4xx.h |  1 +
 4 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/hw/ppc/ppc440.h b/hw/ppc/ppc440.h
index ae42bcf0c8..909373fb38 100644
--- a/hw/ppc/ppc440.h
+++ b/hw/ppc/ppc440.h
@@ -18,6 +18,5 @@ void ppc4xx_cpr_init(CPUPPCState *env);
 void ppc4xx_sdr_init(CPUPPCState *env);
 void ppc4xx_ahb_init(CPUPPCState *env);
 void ppc4xx_dma_init(CPUPPCState *env, int dcr_base);
-void ppc460ex_pcie_init(PowerPCCPU *cpu);
 
 #endif /* PPC440_H */
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 61782a5c1e..545f36edce 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -770,7 +770,6 @@ void ppc4xx_dma_init(CPUPPCState *env, int dcr_base)
  */
 #include "hw/pci/pcie_host.h"
 
-#define TYPE_PPC460EX_PCIE_HOST "ppc460ex-pcie-host"
 OBJECT_DECLARE_SIMPLE_TYPE(PPC460EXPCIEState, PPC460EX_PCIE_HOST)
 
 struct PPC460EXPCIEState {
@@ -799,9 +798,6 @@ struct PPC460EXPCIEState {
     uint32_t cfg;
 };
 
-#define DCRN_PCIE0_BASE 0x100
-#define DCRN_PCIE1_BASE 0x120
-
 enum {
     PEGPL_CFGBAH = 0x0,
     PEGPL_CFGBAL,
@@ -1096,20 +1092,3 @@ static void ppc460ex_pcie_register(void)
 }
 
 type_init(ppc460ex_pcie_register)
-
-void ppc460ex_pcie_init(PowerPCCPU *cpu)
-{
-    DeviceState *dev;
-
-    dev = qdev_new(TYPE_PPC460EX_PCIE_HOST);
-    qdev_prop_set_int32(dev, "busnum", 0);
-    qdev_prop_set_int32(dev, "dcrn-base", DCRN_PCIE0_BASE);
-    object_property_set_link(OBJECT(dev), "cpu", OBJECT(cpu), &error_abort);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-
-    dev = qdev_new(TYPE_PPC460EX_PCIE_HOST);
-    qdev_prop_set_int32(dev, "busnum", 1);
-    qdev_prop_set_int32(dev, "dcrn-base", DCRN_PCIE1_BASE);
-    object_property_set_link(OBJECT(dev), "cpu", OBJECT(cpu), &error_abort);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-}
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index f098226974..d446cfc37b 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -45,6 +45,9 @@
 /* dd bs=1 skip=$(($(stat -c '%s' updater/updater-460) - 0x80000)) \
      if=updater/updater-460 of=u-boot-sam460-20100605.bin */
 
+#define PCIE0_DCRN_BASE 0x100
+#define PCIE1_DCRN_BASE 0x120
+
 /* from Sam460 U-Boot include/configs/Sam460ex.h */
 #define FLASH_BASE             0xfff00000
 #define FLASH_BASE_H           0x4
@@ -421,8 +424,20 @@ static void sam460ex_init(MachineState *machine)
     usb_create_simple(usb_bus_find(-1), "usb-kbd");
     usb_create_simple(usb_bus_find(-1), "usb-mouse");
 
+    /* PCIe buses */
+    dev = qdev_new(TYPE_PPC460EX_PCIE_HOST);
+    qdev_prop_set_int32(dev, "busnum", 0);
+    qdev_prop_set_int32(dev, "dcrn-base", PCIE0_DCRN_BASE);
+    object_property_set_link(OBJECT(dev), "cpu", OBJECT(cpu), &error_abort);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    dev = qdev_new(TYPE_PPC460EX_PCIE_HOST);
+    qdev_prop_set_int32(dev, "busnum", 1);
+    qdev_prop_set_int32(dev, "dcrn-base", PCIE1_DCRN_BASE);
+    object_property_set_link(OBJECT(dev), "cpu", OBJECT(cpu), &error_abort);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
     /* PCI bus */
-    ppc460ex_pcie_init(cpu);
     /* All PCI irqs are connected to the same UIC pin (cf. UBoot source) */
     dev = sysbus_create_simple("ppc440-pcix-host", 0xc0ec00000,
                                qdev_get_gpio_in(uic[1], 0));
diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index f8c86e09ec..39ca602442 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -30,6 +30,7 @@
 #include "hw/sysbus.h"
 
 #define TYPE_PPC4xx_PCI_HOST_BRIDGE "ppc4xx-pcihost"
+#define TYPE_PPC460EX_PCIE_HOST "ppc460ex-pcie-host"
 
 /*
  * Generic DCR device
-- 
2.30.9


