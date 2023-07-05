Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59602748EA8
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 22:14:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH8sb-00032Y-EP; Wed, 05 Jul 2023 16:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qH8sF-0002kT-F7; Wed, 05 Jul 2023 16:13:15 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qH8sD-00065p-Ag; Wed, 05 Jul 2023 16:13:15 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 4A75D748A5E;
 Wed,  5 Jul 2023 22:12:55 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2E8DD748A4D; Wed,  5 Jul 2023 22:12:55 +0200 (CEST)
Message-Id: <be6664983db4cafa41c742c985ee4c4de53be361.1688586835.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1688586835.git.balaton@eik.bme.hu>
References: <cover.1688586835.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 10/14] ppc4xx_pci: Rename QOM type name define
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <"danielhb413@gmail.com>, philmd"@linaro.org>
Date: Wed,  5 Jul 2023 22:12:55 +0200 (CEST)
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

Rename the TYPE_PPC4xx_PCI_HOST_BRIDGE define and its string value to
match each other and other similar types and to avoid confusion with
"ppc4xx-host-bridge" type defined in same file.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/ppc440_bamboo.c  | 3 +--
 hw/ppc/ppc4xx_pci.c     | 6 +++---
 include/hw/ppc/ppc4xx.h | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index f061b8cf3b..45f409c838 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -205,8 +205,7 @@ static void bamboo_init(MachineState *machine)
     ppc4xx_sdram_ddr_enable(PPC4xx_SDRAM_DDR(dev));
 
     /* PCI */
-    dev = sysbus_create_varargs(TYPE_PPC4xx_PCI_HOST_BRIDGE,
-                                PPC440EP_PCI_CONFIG,
+    dev = sysbus_create_varargs(TYPE_PPC4xx_PCI_HOST, PPC440EP_PCI_CONFIG,
                                 qdev_get_gpio_in(uicdev, pci_irq_nrs[0]),
                                 qdev_get_gpio_in(uicdev, pci_irq_nrs[1]),
                                 qdev_get_gpio_in(uicdev, pci_irq_nrs[2]),
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index 1d4a50fa7c..fbdf8266d8 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -46,7 +46,7 @@ struct PCITargetMap {
     uint32_t la;
 };
 
-OBJECT_DECLARE_SIMPLE_TYPE(PPC4xxPCIState, PPC4xx_PCI_HOST_BRIDGE)
+OBJECT_DECLARE_SIMPLE_TYPE(PPC4xxPCIState, PPC4xx_PCI_HOST)
 
 #define PPC4xx_PCI_NR_PMMS 3
 #define PPC4xx_PCI_NR_PTMS 2
@@ -321,7 +321,7 @@ static void ppc4xx_pcihost_realize(DeviceState *dev, Error **errp)
     int i;
 
     h = PCI_HOST_BRIDGE(dev);
-    s = PPC4xx_PCI_HOST_BRIDGE(dev);
+    s = PPC4xx_PCI_HOST(dev);
 
     for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
         sysbus_init_irq(sbd, &s->irq[i]);
@@ -386,7 +386,7 @@ static void ppc4xx_pcihost_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo ppc4xx_pcihost_info = {
-    .name          = TYPE_PPC4xx_PCI_HOST_BRIDGE,
+    .name          = TYPE_PPC4xx_PCI_HOST,
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(PPC4xxPCIState),
     .class_init    = ppc4xx_pcihost_class_init,
diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index 39ca602442..e053b9751b 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -29,7 +29,7 @@
 #include "exec/memory.h"
 #include "hw/sysbus.h"
 
-#define TYPE_PPC4xx_PCI_HOST_BRIDGE "ppc4xx-pcihost"
+#define TYPE_PPC4xx_PCI_HOST "ppc4xx-pci-host"
 #define TYPE_PPC460EX_PCIE_HOST "ppc460ex-pcie-host"
 
 /*
-- 
2.30.9


