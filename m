Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE17AA879D
	for <lists+qemu-devel@lfdr.de>; Sun,  4 May 2025 18:03:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBbmz-0005UO-IF; Sun, 04 May 2025 12:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uBbmm-0005C4-Lt; Sun, 04 May 2025 12:01:48 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uBbmk-0004ED-SD; Sun, 04 May 2025 12:01:48 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 53D7355D23A;
 Sun, 04 May 2025 18:01:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id WUYX34EdIkCM; Sun,  4 May 2025 18:01:43 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 68E4655D235; Sun, 04 May 2025 18:01:43 +0200 (CEST)
Message-ID: <26b4e976fe52243e26d495d8332186aff02d0a86.1746374076.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1746374076.git.balaton@eik.bme.hu>
References: <cover.1746374076.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 16/16] hw/ppc/prep: Fix non-contiguous IO control bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Date: Sun, 04 May 2025 18:01:43 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The bit that is supposed to control if ISA IO ports are accessed with
discontinuous addresses was not connected so it did nothing. We can
now directly enable or disable the discontinuous region so allow the
bit to function. This did not cause a problem so far as nothing seems
to use this bit or discontinuous IO addresses.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/pci-host/raven.c    |  9 ---------
 hw/ppc/prep.c          |  3 +++
 hw/ppc/prep_systemio.c | 14 ++++++++------
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index c9df3db401..66ab940061 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -157,13 +157,6 @@ static const PCIIOMMUOps raven_iommu_ops = {
     .get_address_space = raven_pcihost_set_iommu,
 };
 
-static void raven_change_gpio(void *opaque, int n, int level)
-{
-    PREPPCIState *s = opaque;
-
-    memory_region_set_enabled(&s->pci_discontiguous_io, !!level);
-}
-
 static void raven_pcihost_realize(DeviceState *d, Error **errp)
 {
     SysBusDevice *dev = SYS_BUS_DEVICE(d);
@@ -172,8 +165,6 @@ static void raven_pcihost_realize(DeviceState *d, Error **errp)
     Object *o = OBJECT(d);
     MemoryRegion *mr, *bm, *address_space_mem = get_system_memory();
 
-    qdev_init_gpio_in(d, raven_change_gpio, 1);
-
     memory_region_init(&s->pci_io, o, "pci-io", 0x3f800000);
     memory_region_init_io(&s->pci_discontiguous_io, o,
                           &raven_io_ops, &s->pci_io,
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 23d0e1eeaa..678682fdd2 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -358,6 +358,9 @@ static void ibm_40p_init(MachineState *machine)
         dev = DEVICE(isa_dev);
         qdev_prop_set_uint32(dev, "ibm-planar-id", 0xfc);
         qdev_prop_set_uint32(dev, "equipment", 0xc0);
+        object_property_set_link(OBJECT(dev), "discontiguous-io",
+                                 OBJECT(sysbus_mmio_get_region(pcihost, 1)),
+                                 &error_fatal);
         isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
 
         dev = DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(1, 0),
diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
index 41cd923b94..fe767cc4ac 100644
--- a/hw/ppc/prep_systemio.c
+++ b/hw/ppc/prep_systemio.c
@@ -44,9 +44,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(PrepSystemIoState, PREP_SYSTEMIO)
 
 struct PrepSystemIoState {
     ISADevice parent_obj;
+
     MemoryRegion ppc_parity_mem;
+    MemoryRegion *discontiguous_io;
 
-    qemu_irq non_contiguous_io_map_irq;
     uint8_t sreset; /* 0x0092 */
     uint8_t equipment; /* 0x080c */
     uint8_t system_control; /* 0x081c */
@@ -206,8 +207,8 @@ static void prep_port0850_write(void *opaque, uint32_t addr, uint32_t val)
     PrepSystemIoState *s = opaque;
 
     trace_prep_systemio_write(addr, val);
-    qemu_set_irq(s->non_contiguous_io_map_irq,
-                 val & PORT0850_IOMAP_NONCONTIGUOUS);
+    memory_region_set_enabled(s->discontiguous_io,
+                              !(val & PORT0850_IOMAP_NONCONTIGUOUS));
     s->iomap_type = val & PORT0850_IOMAP_NONCONTIGUOUS;
 }
 
@@ -257,10 +258,9 @@ static void prep_systemio_realize(DeviceState *dev, Error **errp)
     PrepSystemIoState *s = PREP_SYSTEMIO(dev);
     PowerPCCPU *cpu;
 
-    qdev_init_gpio_out(dev, &s->non_contiguous_io_map_irq, 1);
     s->iomap_type = PORT0850_IOMAP_NONCONTIGUOUS;
-    qemu_set_irq(s->non_contiguous_io_map_irq,
-                 s->iomap_type & PORT0850_IOMAP_NONCONTIGUOUS);
+    memory_region_set_enabled(s->discontiguous_io,
+                              !(s->iomap_type & PORT0850_IOMAP_NONCONTIGUOUS));
     cpu = POWERPC_CPU(first_cpu);
     s->softreset_irq = qdev_get_gpio_in(DEVICE(cpu), PPC6xx_INPUT_HRESET);
 
@@ -288,6 +288,8 @@ static const VMStateDescription vmstate_prep_systemio = {
 static const Property prep_systemio_properties[] = {
     DEFINE_PROP_UINT8("ibm-planar-id", PrepSystemIoState, ibm_planar_id, 0),
     DEFINE_PROP_UINT8("equipment", PrepSystemIoState, equipment, 0),
+    DEFINE_PROP_LINK("discontiguous-io", PrepSystemIoState, discontiguous_io,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
 };
 
 static void prep_systemio_class_initfn(ObjectClass *klass, const void *data)
-- 
2.41.3


