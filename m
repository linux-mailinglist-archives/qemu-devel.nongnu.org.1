Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E15AF6509
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Jul 2025 00:17:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX5jp-0001gU-4r; Wed, 02 Jul 2025 18:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uX5jk-0001cG-UR; Wed, 02 Jul 2025 18:15:29 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uX5jT-00061o-9m; Wed, 02 Jul 2025 18:15:28 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 41E9055CA5E;
 Thu, 03 Jul 2025 00:09:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id x6v5V7ZYnQrO; Thu,  3 Jul 2025 00:08:58 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 48AE755CA60; Thu, 03 Jul 2025 00:08:58 +0200 (CEST)
Message-ID: <917239c78c53493a6ab8b7f40d7dbcdfe7cf76b5.1751493467.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1751493467.git.balaton@eik.bme.hu>
References: <cover.1751493467.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 04/14] hw/pci-host/raven: Simplify PCI bus creation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 03 Jul 2025 00:08:58 +0200 (CEST)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

Instead of doing it manually use pci_register_root_bus() to create and
register the PCI bus.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/pci-host/raven.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index e0f98afebf..51427553b2 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -46,7 +46,6 @@ struct PREPPCIState {
 
     OrIRQState *or_irq;
     qemu_irq pci_irqs[PCI_NUM_PINS];
-    PCIBus pci_bus;
     AddressSpace pci_io_as;
     MemoryRegion pci_io;
     MemoryRegion pci_io_non_contiguous;
@@ -239,8 +238,9 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
 
     qdev_init_gpio_in(d, raven_change_gpio, 1);
 
-    pci_bus_irqs(&s->pci_bus, raven_set_irq, s, PCI_NUM_PINS);
-    pci_bus_map_irqs(&s->pci_bus, raven_map_irq);
+    h->bus = pci_register_root_bus(d, NULL, raven_set_irq, raven_map_irq,
+                                   s, &s->pci_memory, &s->pci_io, 0, 4,
+                                   TYPE_PCI_BUS);
 
     memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_le_ops, s,
                           "pci-conf-idx", 4);
@@ -258,12 +258,14 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
                           "pci-intack", 1);
     memory_region_add_subregion(address_space_mem, 0xbffffff0, &s->pci_intack);
 
-    pci_create_simple(&s->pci_bus, PCI_DEVFN(0, 0), TYPE_RAVEN_PCI_DEVICE);
+    pci_create_simple(h->bus, PCI_DEVFN(0, 0), TYPE_RAVEN_PCI_DEVICE);
+
+    address_space_init(&s->bm_as, &s->bm, "raven-bm");
+    pci_setup_iommu(h->bus, &raven_iommu_ops, s);
 }
 
 static void raven_pcihost_initfn(Object *obj)
 {
-    PCIHostState *h = PCI_HOST_BRIDGE(obj);
     PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(obj);
     MemoryRegion *address_space_mem = get_system_memory();
 
@@ -286,8 +288,6 @@ static void raven_pcihost_initfn(Object *obj)
     memory_region_add_subregion_overlap(address_space_mem, PCI_IO_BASE_ADDR,
                                         &s->pci_io_non_contiguous, 1);
     memory_region_add_subregion(address_space_mem, 0xc0000000, &s->pci_memory);
-    pci_root_bus_init(&s->pci_bus, sizeof(s->pci_bus), DEVICE(obj), NULL,
-                      &s->pci_memory, &s->pci_io, 0, TYPE_PCI_BUS);
 
     /* Bus master address space */
     memory_region_init(&s->bm, obj, "bm-raven", 4 * GiB);
@@ -298,10 +298,6 @@ static void raven_pcihost_initfn(Object *obj)
                              get_system_memory(), 0, 0x80000000);
     memory_region_add_subregion(&s->bm, 0         , &s->bm_pci_memory_alias);
     memory_region_add_subregion(&s->bm, 0x80000000, &s->bm_ram_alias);
-    address_space_init(&s->bm_as, &s->bm, "raven-bm");
-    pci_setup_iommu(&s->pci_bus, &raven_iommu_ops, s);
-
-    h->bus = &s->pci_bus;
 }
 
 static void raven_pcihost_class_init(ObjectClass *klass, const void *data)
-- 
2.41.3


