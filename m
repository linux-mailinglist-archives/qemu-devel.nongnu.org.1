Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECA87465A2
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 00:05:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGRdR-0003ig-8N; Mon, 03 Jul 2023 18:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGRdP-0003er-7d; Mon, 03 Jul 2023 18:03:03 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGRdN-0004CK-Fi; Mon, 03 Jul 2023 18:03:02 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 36290748A5D;
 Tue,  4 Jul 2023 00:02:44 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 16051748A4D; Tue,  4 Jul 2023 00:02:44 +0200 (CEST)
Message-Id: <e674bbedc437fa486f7e9690be14f1015bf54e88.1688421085.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1688421085.git.balaton@eik.bme.hu>
References: <cover.1688421085.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 11/13] ppc440_pcix: Rename QOM type define abd move it to
 common header
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Tue,  4 Jul 2023 00:02:44 +0200 (CEST)
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

Rename TYPE_PPC440_PCIX_HOST_BRIDGE to better match its string value,
move it to common header and use it also in sam460ex to replace hard
coded type name.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/ppc440_pcix.c    | 9 ++++-----
 hw/ppc/sam460ex.c       | 2 +-
 include/hw/ppc/ppc4xx.h | 1 +
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index dfec25ac83..adfecf1e76 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -44,8 +44,7 @@ struct PLBInMap {
     MemoryRegion mr;
 };
 
-#define TYPE_PPC440_PCIX_HOST_BRIDGE "ppc440-pcix-host"
-OBJECT_DECLARE_SIMPLE_TYPE(PPC440PCIXState, PPC440_PCIX_HOST_BRIDGE)
+OBJECT_DECLARE_SIMPLE_TYPE(PPC440PCIXState, PPC440_PCIX_HOST)
 
 #define PPC440_PCIX_NR_POMS 3
 #define PPC440_PCIX_NR_PIMS 3
@@ -397,7 +396,7 @@ static const MemoryRegionOps pci_reg_ops = {
 
 static void ppc440_pcix_reset(DeviceState *dev)
 {
-    struct PPC440PCIXState *s = PPC440_PCIX_HOST_BRIDGE(dev);
+    struct PPC440PCIXState *s = PPC440_PCIX_HOST(dev);
     int i;
 
     for (i = 0; i < PPC440_PCIX_NR_POMS; i++) {
@@ -487,7 +486,7 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
     PCIHostState *h;
 
     h = PCI_HOST_BRIDGE(dev);
-    s = PPC440_PCIX_HOST_BRIDGE(dev);
+    s = PPC440_PCIX_HOST(dev);
 
     sysbus_init_irq(sbd, &s->irq);
     memory_region_init(&s->busmem, OBJECT(dev), "pci bus memory", UINT64_MAX);
@@ -525,7 +524,7 @@ static void ppc440_pcix_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo ppc440_pcix_info = {
-    .name          = TYPE_PPC440_PCIX_HOST_BRIDGE,
+    .name          = TYPE_PPC440_PCIX_HOST,
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(PPC440PCIXState),
     .class_init    = ppc440_pcix_class_init,
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index d446cfc37b..8d0e551d14 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -439,7 +439,7 @@ static void sam460ex_init(MachineState *machine)
 
     /* PCI bus */
     /* All PCI irqs are connected to the same UIC pin (cf. UBoot source) */
-    dev = sysbus_create_simple("ppc440-pcix-host", 0xc0ec00000,
+    dev = sysbus_create_simple(TYPE_PPC440_PCIX_HOST, 0xc0ec00000,
                                qdev_get_gpio_in(uic[1], 0));
     pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
 
diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index 766d575e86..ea7740239b 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -31,6 +31,7 @@
 
 #define TYPE_PPC4xx_HOST_BRIDGE "ppc4xx-host-bridge"
 #define TYPE_PPC4xx_PCI_HOST "ppc4xx-pci-host"
+#define TYPE_PPC440_PCIX_HOST "ppc440-pcix-host"
 #define TYPE_PPC460EX_PCIE_HOST "ppc460ex-pcie-host"
 
 /*
-- 
2.30.9


