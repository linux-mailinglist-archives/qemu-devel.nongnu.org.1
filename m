Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E5A749A6A
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 13:17:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHMzG-0004gU-HB; Thu, 06 Jul 2023 07:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qHMyy-0004WS-GS; Thu, 06 Jul 2023 07:17:09 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qHMyt-0007gM-2v; Thu, 06 Jul 2023 07:17:04 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id AE344748A5C;
 Thu,  6 Jul 2023 13:16:44 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 91281748A55; Thu,  6 Jul 2023 13:16:44 +0200 (CEST)
Message-Id: <f6e2956b3a09ee481b970ef7873b374c846ba0a8.1688641673.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1688641673.git.balaton@eik.bme.hu>
References: <cover.1688641673.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [RESEND PATCH v3 3/4] ppc4xx_pci: Add define for ppc4xx-host-bridge
 type name
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
    philmd@linaro.org
Date: Thu,  6 Jul 2023 13:16:44 +0200 (CEST)
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

Add a QOM type name define for ppc4xx-host-bridge in the common header
and replace direct use of the string name with the constant.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/ppc440_pcix.c    | 3 ++-
 hw/ppc/ppc4xx_pci.c     | 4 ++--
 include/hw/ppc/ppc4xx.h | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index 54286cfef4..9321ca0abd 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -498,7 +498,8 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
                          ppc440_pcix_map_irq, &s->irq, &s->busmem, &s->iomem,
                          PCI_DEVFN(0, 0), 1, TYPE_PCI_BUS);
 
-    s->dev = pci_create_simple(h->bus, PCI_DEVFN(0, 0), "ppc4xx-host-bridge");
+    s->dev = pci_create_simple(h->bus, PCI_DEVFN(0, 0),
+                               TYPE_PPC4xx_HOST_BRIDGE);
 
     memory_region_init(&s->bm, OBJECT(s), "bm-ppc440-pcix", UINT64_MAX);
     memory_region_add_subregion(&s->bm, 0x0, &s->busmem);
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index fbdf8266d8..6652119008 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -333,7 +333,7 @@ static void ppc4xx_pcihost_realize(DeviceState *dev, Error **errp)
                               TYPE_PCI_BUS);
     h->bus = b;
 
-    pci_create_simple(b, 0, "ppc4xx-host-bridge");
+    pci_create_simple(b, 0, TYPE_PPC4xx_HOST_BRIDGE);
 
     /* XXX split into 2 memory regions, one for config space, one for regs */
     memory_region_init(&s->container, OBJECT(s), "pci-container", PCI_ALL_SIZE);
@@ -367,7 +367,7 @@ static void ppc4xx_host_bridge_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo ppc4xx_host_bridge_info = {
-    .name          = "ppc4xx-host-bridge",
+    .name          = TYPE_PPC4xx_HOST_BRIDGE,
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIDevice),
     .class_init    = ppc4xx_host_bridge_class_init,
diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index e053b9751b..766d575e86 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -29,6 +29,7 @@
 #include "exec/memory.h"
 #include "hw/sysbus.h"
 
+#define TYPE_PPC4xx_HOST_BRIDGE "ppc4xx-host-bridge"
 #define TYPE_PPC4xx_PCI_HOST "ppc4xx-pci-host"
 #define TYPE_PPC460EX_PCIE_HOST "ppc460ex-pcie-host"
 
-- 
2.30.9


