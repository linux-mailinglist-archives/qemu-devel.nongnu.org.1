Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AB47465A0
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 00:05:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGRdM-0003aT-Fp; Mon, 03 Jul 2023 18:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGRdK-0003ZR-JH; Mon, 03 Jul 2023 18:02:58 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGRdI-0004As-UD; Mon, 03 Jul 2023 18:02:58 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 046FD748A59;
 Tue,  4 Jul 2023 00:02:40 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D9001748A4D; Tue,  4 Jul 2023 00:02:39 +0200 (CEST)
Message-Id: <9ededc930d3ba2ea3f0748d71410d36b7b453fdb.1688421085.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1688421085.git.balaton@eik.bme.hu>
References: <cover.1688421085.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 07/13] ppc440: Add busnum property to PCIe controller model
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Tue,  4 Jul 2023 00:02:39 +0200 (CEST)
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

Instead of guessing controller number from dcrn_base add a property so
the device does not need knowledge about where it is used.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/ppc440_uc.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 0c5d999878..61782a5c1e 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -779,6 +779,7 @@ struct PPC460EXPCIEState {
     MemoryRegion busmem;
     MemoryRegion iomem;
     qemu_irq irq[4];
+    int32_t num;
     int32_t dcrn_base;
     PowerPCCPU *cpu;
 
@@ -1039,32 +1040,25 @@ static void ppc460ex_pcie_realize(DeviceState *dev, Error **errp)
 {
     PPC460EXPCIEState *s = PPC460EX_PCIE_HOST(dev);
     PCIHostState *pci = PCI_HOST_BRIDGE(dev);
-    int i, id;
-    char buf[16];
+    int i;
+    char buf[20];
 
     if (!s->cpu) {
         error_setg(errp, "cpu link property must be set");
         return;
     }
-    switch (s->dcrn_base) {
-    case DCRN_PCIE0_BASE:
-        id = 0;
-        break;
-    case DCRN_PCIE1_BASE:
-        id = 1;
-        break;
-    default:
-        error_setg(errp, "invalid PCIe DCRN base");
+    if (s->num < 0 || s->dcrn_base < 0) {
+        error_setg(errp, "busnum and dcrn-base properties must be set");
         return;
     }
-    snprintf(buf, sizeof(buf), "pcie%d-mem", id);
+    snprintf(buf, sizeof(buf), "pcie%d-mem", s->num);
     memory_region_init(&s->busmem, OBJECT(s), buf, UINT64_MAX);
-    snprintf(buf, sizeof(buf), "pcie%d-io", id);
+    snprintf(buf, sizeof(buf), "pcie%d-io", s->num);
     memory_region_init(&s->iomem, OBJECT(s), buf, 0x10000);
     for (i = 0; i < 4; i++) {
         sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[i]);
     }
-    snprintf(buf, sizeof(buf), "pcie.%d", id);
+    snprintf(buf, sizeof(buf), "pcie.%d", s->num);
     pci->bus = pci_register_root_bus(DEVICE(s), buf, ppc460ex_set_irq,
                                 pci_swizzle_map_irq_fn, s, &s->busmem,
                                 &s->iomem, 0, 4, TYPE_PCIE_BUS);
@@ -1072,6 +1066,7 @@ static void ppc460ex_pcie_realize(DeviceState *dev, Error **errp)
 }
 
 static Property ppc460ex_pcie_props[] = {
+    DEFINE_PROP_INT32("busnum", PPC460EXPCIEState, num, -1),
     DEFINE_PROP_INT32("dcrn-base", PPC460EXPCIEState, dcrn_base, -1),
     DEFINE_PROP_LINK("cpu", PPC460EXPCIEState, cpu, TYPE_POWERPC_CPU,
                      PowerPCCPU *),
@@ -1107,11 +1102,13 @@ void ppc460ex_pcie_init(PowerPCCPU *cpu)
     DeviceState *dev;
 
     dev = qdev_new(TYPE_PPC460EX_PCIE_HOST);
+    qdev_prop_set_int32(dev, "busnum", 0);
     qdev_prop_set_int32(dev, "dcrn-base", DCRN_PCIE0_BASE);
     object_property_set_link(OBJECT(dev), "cpu", OBJECT(cpu), &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     dev = qdev_new(TYPE_PPC460EX_PCIE_HOST);
+    qdev_prop_set_int32(dev, "busnum", 1);
     qdev_prop_set_int32(dev, "dcrn-base", DCRN_PCIE1_BASE);
     object_property_set_link(OBJECT(dev), "cpu", OBJECT(cpu), &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-- 
2.30.9


