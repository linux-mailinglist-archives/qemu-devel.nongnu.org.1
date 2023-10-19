Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DDC7CF79A
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 13:55:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtRc4-0004uZ-2X; Thu, 19 Oct 2023 07:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=vSYV=GB=redhat.com=clg@ozlabs.org>)
 id 1qtRc2-0004u6-1n
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:54:50 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=vSYV=GB=redhat.com=clg@ozlabs.org>)
 id 1qtRbx-0005q0-UB
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:54:49 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SB5jn0Tq6z4xf1;
 Thu, 19 Oct 2023 22:54:37 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SB5jX2h1cz4xck;
 Thu, 19 Oct 2023 22:54:24 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Joao Martins <joao.m.martins@oracle.com>, Liu Yi L <yi.l.liu@intel.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Peter Xu <peterx@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3] hw/pci: modify pci_setup_iommu() to set PCIIOMMUOps
Date: Thu, 19 Oct 2023 13:54:17 +0200
Message-ID: <20231019115417.951497-1-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=vSYV=GB=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Liu Yi L <yi.l.liu@intel.com>

This patch modifies pci_setup_iommu() to set PCIIOMMUOps
instead of setting PCIIOMMUFunc. PCIIOMMUFunc is used to
get an address space for a PCI device in vendor specific
way. The PCIIOMMUOps still offers this functionality. But
using PCIIOMMUOps leaves space to add more iommu related
vendor specific operations.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Hervé Poussineau <hpoussin@reactos.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Cc: Jagannathan Raman <jag.raman@oracle.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[ clg: - refreshed on latest QEMU
       - included hw/remote/iommu.c
       - documentation update
       - asserts in pci_setup_iommu()
       - removed checks on iommu_bus->iommu_ops->get_address_space ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 Hello,

 Initially sent by Yi Liu as part of series "intel_iommu: expose
 Shared Virtual Addressing to VMs" [1], this patch would also simplify
 the changes Joao wants to introduce in "vfio: VFIO migration support
 with vIOMMU" [2].

 Has anyone objections ?

 Thanks,

 C.

 [1] https://lore.kernel.org/qemu-devel/20210302203827.437645-5-yi.l.liu@intel.com/
 [2] https://lore.kernel.org/qemu-devel/20230622214845.3980-1-joao.m.martins@oracle.com/

 Changes in v3 :

 - New Documentation 
 - Create a pci.rst for the kernel-doc comments of
   include/hw/pci/pci.h
 - asserts in pci_setup_iommu()
 - removed checks on iommu_bus->iommu_ops->get_address_space

 Changes in v2 :

 - PCIIOMMUOps definition cleanups
 
 docs/devel/index-api.rst |  1 +
 docs/devel/pci.rst       |  8 ++++++++
 include/hw/pci/pci.h     | 39 +++++++++++++++++++++++++++++++++++++--
 include/hw/pci/pci_bus.h |  2 +-
 hw/alpha/typhoon.c       |  6 +++++-
 hw/arm/smmu-common.c     |  6 +++++-
 hw/i386/amd_iommu.c      |  6 +++++-
 hw/i386/intel_iommu.c    |  6 +++++-
 hw/pci-host/designware.c |  6 +++++-
 hw/pci-host/dino.c       |  6 +++++-
 hw/pci-host/pnv_phb3.c   |  6 +++++-
 hw/pci-host/pnv_phb4.c   |  6 +++++-
 hw/pci-host/ppce500.c    |  6 +++++-
 hw/pci-host/raven.c      |  6 +++++-
 hw/pci-host/sabre.c      |  6 +++++-
 hw/pci/pci.c             | 18 +++++++++++++-----
 hw/ppc/ppc440_pcix.c     |  6 +++++-
 hw/ppc/spapr_pci.c       |  6 +++++-
 hw/remote/iommu.c        |  6 +++++-
 hw/s390x/s390-pci-bus.c  |  8 ++++++--
 hw/virtio/virtio-iommu.c |  6 +++++-
 21 files changed, 141 insertions(+), 25 deletions(-)
 create mode 100644 docs/devel/pci.rst

diff --git a/docs/devel/index-api.rst b/docs/devel/index-api.rst
index 539ad29c215e803568b1d7b0ba6766c0cc9d2b8b..fe01b2b488d0b61376560011a660389603e4ce8e 100644
--- a/docs/devel/index-api.rst
+++ b/docs/devel/index-api.rst
@@ -11,6 +11,7 @@ generated from in-code annotations to function prototypes.
    loads-stores
    memory
    modules
+   pci
    qom-api
    qdev-api
    ui
diff --git a/docs/devel/pci.rst b/docs/devel/pci.rst
new file mode 100644
index 0000000000000000000000000000000000000000..68739334f3c936cc28b8fceac6dbebbfe68e78a2
--- /dev/null
+++ b/docs/devel/pci.rst
@@ -0,0 +1,8 @@
+=============
+PCI subsystem
+=============
+
+API Reference
+-------------
+
+.. kernel-doc:: include/hw/pci/pci.h
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index b70a0b95ff5ae367ed7f98483ec8d1d1b6274530..0a4bcd13f39fde60326a548a3cd6637ec2287475 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -366,10 +366,45 @@ void pci_bus_get_w64_range(PCIBus *bus, Range *range);
 
 void pci_device_deassert_intx(PCIDevice *dev);
 
-typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *, int);
+
+/**
+ * struct PCIIOMMUOps: callbacks structure for specific IOMMU handlers
+ * of a PCIBus
+ *
+ * Allows to modify the behavior of some IOMMU operations of the PCI
+ * framework for a set of devices on a PCI bus.
+ */
+typedef struct PCIIOMMUOps {
+    /**
+     * @get_address_space: get the address space for a set of devices
+     * on a PCI bus.
+     *
+     * Returns a pointer to AddressSpace, otherwise NULL.
+     *
+     * Optional method: if this method is not set, then the default
+     * address_space is used.
+     *
+     * @bus: the #PCIBus being accessed.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number
+     */
+   AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int devfn);
+} PCIIOMMUOps;
 
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
-void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque);
+
+/**
+ * pci_setup_iommu: Initialize specific IOMMU handlers for a PCIBus
+ *
+ * Let PCI host bridges define specific operations.
+ *
+ * @bus: the #PCIBus being updated.
+ * @ops: the #PCIIOMMUOps
+ * @opaque: passed to callbacks of the @ops structure.
+ */
+void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque);
 
 pcibus_t pci_bar_address(PCIDevice *d,
                          int reg, uint8_t type, pcibus_t size);
diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index 56531759578ffe2c6eccc92ebae4acabf47e390d..226131254621f257eefb45356489c125381e6a87 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -33,7 +33,7 @@ enum PCIBusFlags {
 struct PCIBus {
     BusState qbus;
     enum PCIBusFlags flags;
-    PCIIOMMUFunc iommu_fn;
+    const PCIIOMMUOps *iommu_ops;
     void *iommu_opaque;
     uint8_t devfn_min;
     uint32_t slot_reserved_mask;
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 49a80550c54d4ed9ee40f9959cbf2c83240d8e39..e8711ae16a3e16c733405034be5e65688ef4d3df 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -738,6 +738,10 @@ static AddressSpace *typhoon_pci_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     return &s->pchip.iommu_as;
 }
 
+static const PCIIOMMUOps typhoon_iommu_ops = {
+    .get_address_space = typhoon_pci_dma_iommu,
+};
+
 static void typhoon_set_irq(void *opaque, int irq, int level)
 {
     TyphoonState *s = opaque;
@@ -897,7 +901,7 @@ PCIBus *typhoon_init(MemoryRegion *ram, qemu_irq *p_isa_irq,
                              "iommu-typhoon", UINT64_MAX);
     address_space_init(&s->pchip.iommu_as, MEMORY_REGION(&s->pchip.iommu),
                        "pchip0-pci");
-    pci_setup_iommu(b, typhoon_pci_dma_iommu, s);
+    pci_setup_iommu(b, &typhoon_iommu_ops, s);
 
     /* Pchip0 PCI special/interrupt acknowledge, 0x801.F800.0000, 64MB.  */
     memory_region_init_io(&s->pchip.reg_iack, OBJECT(s), &alpha_pci_iack_ops,
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index f35ae9aa22cb1a62cc16c2534cb3c290862b0799..9a8ac45431abb80fc5e9f60104248cb356509088 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -605,6 +605,10 @@ static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
     return &sdev->as;
 }
 
+static const PCIIOMMUOps smmu_ops = {
+    .get_address_space = smmu_find_add_as,
+};
+
 IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid)
 {
     uint8_t bus_n, devfn;
@@ -661,7 +665,7 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
     s->smmu_pcibus_by_busptr = g_hash_table_new(NULL, NULL);
 
     if (s->primary_bus) {
-        pci_setup_iommu(s->primary_bus, smmu_find_add_as, s);
+        pci_setup_iommu(s->primary_bus, &smmu_ops, s);
     } else {
         error_setg(errp, "SMMU is not attached to any PCI bus!");
     }
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 8d0f2f99ddbf49c3df834b6d40d2b23cafbb81ea..94f0f8a7f22130e5684926a8790182376723e58e 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1450,6 +1450,10 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     return &iommu_as[devfn]->as;
 }
 
+static const PCIIOMMUOps amdvi_iommu_ops = {
+    .get_address_space = amdvi_host_dma_iommu,
+};
+
 static const MemoryRegionOps mmio_mem_ops = {
     .read = amdvi_mmio_read,
     .write = amdvi_mmio_write,
@@ -1582,7 +1586,7 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
 
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->mmio);
     sysbus_mmio_map(SYS_BUS_DEVICE(s), 0, AMDVI_BASE_ADDR);
-    pci_setup_iommu(bus, amdvi_host_dma_iommu, s);
+    pci_setup_iommu(bus, &amdvi_iommu_ops, s);
     amdvi_init(s);
 }
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 2c832ab68b3774dbec6eee4ffe7c13e7a1bf7bcc..87b07a390482160e6db630a2c2c4f6f522e0dc72 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4034,6 +4034,10 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     return &vtd_as->as;
 }
 
+static PCIIOMMUOps vtd_iommu_ops = {
+    .get_address_space = vtd_host_dma_iommu,
+};
+
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
 {
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
@@ -4157,7 +4161,7 @@ static void vtd_realize(DeviceState *dev, Error **errp)
                                       g_free, g_free);
     vtd_init(s);
     sysbus_mmio_map(SYS_BUS_DEVICE(s), 0, Q35_HOST_BRIDGE_IOMMU_ADDR);
-    pci_setup_iommu(bus, vtd_host_dma_iommu, dev);
+    pci_setup_iommu(bus, &vtd_iommu_ops, dev);
     /* Pseudo address space under root PCI bus. */
     x86ms->ioapic_as = vtd_host_dma_iommu(bus, s, Q35_PSEUDO_DEVFN_IOAPIC);
     qemu_add_machine_init_done_notifier(&vtd_machine_done_notify);
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 6f5442f108874f6217fa122ac08c1ce27ad20cb9..f477f97847d753341f341281ed2abed2ce242574 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -663,6 +663,10 @@ static AddressSpace *designware_pcie_host_set_iommu(PCIBus *bus, void *opaque,
     return &s->pci.address_space;
 }
 
+static const PCIIOMMUOps designware_iommu_ops = {
+    .get_address_space = designware_pcie_host_set_iommu,
+};
+
 static void designware_pcie_host_realize(DeviceState *dev, Error **errp)
 {
     PCIHostState *pci = PCI_HOST_BRIDGE(dev);
@@ -705,7 +709,7 @@ static void designware_pcie_host_realize(DeviceState *dev, Error **errp)
     address_space_init(&s->pci.address_space,
                        &s->pci.address_space_root,
                        "pcie-bus-address-space");
-    pci_setup_iommu(pci->bus, designware_pcie_host_set_iommu, s);
+    pci_setup_iommu(pci->bus, &designware_iommu_ops, s);
 
     qdev_realize(DEVICE(&s->root), BUS(pci->bus), &error_fatal);
 }
diff --git a/hw/pci-host/dino.c b/hw/pci-host/dino.c
index 82503229faf8a44b3974b2256b641ce18a77692b..5b0947a16c9ec4abf8668bc4563b1cc181f154f3 100644
--- a/hw/pci-host/dino.c
+++ b/hw/pci-host/dino.c
@@ -354,6 +354,10 @@ static AddressSpace *dino_pcihost_set_iommu(PCIBus *bus, void *opaque,
     return &s->bm_as;
 }
 
+static const PCIIOMMUOps dino_iommu_ops = {
+    .get_address_space = dino_pcihost_set_iommu,
+};
+
 /*
  * Dino interrupts are connected as shown on Page 78, Table 23
  * (Little-endian bit numbers)
@@ -481,7 +485,7 @@ static void dino_pcihost_init(Object *obj)
         g_free(name);
     }
 
-    pci_setup_iommu(phb->bus, dino_pcihost_set_iommu, s);
+    pci_setup_iommu(phb->bus, &dino_iommu_ops, s);
 
     sysbus_init_mmio(sbd, &s->this_mem);
 
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index c5e58f4086aef34fa0b5307c10b261c0c6e3ac34..2a74dbe45f59b207b57b3b8af8856ac5cf04d114 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -968,6 +968,10 @@ static AddressSpace *pnv_phb3_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     return &ds->dma_as;
 }
 
+static PCIIOMMUOps pnv_phb3_iommu_ops = {
+    .get_address_space = pnv_phb3_dma_iommu,
+};
+
 static void pnv_phb3_instance_init(Object *obj)
 {
     PnvPHB3 *phb = PNV_PHB3(obj);
@@ -1012,7 +1016,7 @@ void pnv_phb3_bus_init(DeviceState *dev, PnvPHB3 *phb)
     object_property_set_int(OBJECT(pci->bus), "chip-id", phb->chip_id,
                             &error_abort);
 
-    pci_setup_iommu(pci->bus, pnv_phb3_dma_iommu, phb);
+    pci_setup_iommu(pci->bus, &pnv_phb3_iommu_ops, phb);
 }
 
 static void pnv_phb3_realize(DeviceState *dev, Error **errp)
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 29cb11a5d94c6a72a8111dd95346be906a7bc4fe..37c7afc18c9b17b25df8356907f0d87d7d621ac2 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1518,6 +1518,10 @@ static void pnv_phb4_xscom_realize(PnvPHB4 *phb)
                             &phb->phb_regs_mr);
 }
 
+static PCIIOMMUOps pnv_phb4_iommu_ops = {
+    .get_address_space = pnv_phb4_dma_iommu,
+};
+
 static void pnv_phb4_instance_init(Object *obj)
 {
     PnvPHB4 *phb = PNV_PHB4(obj);
@@ -1557,7 +1561,7 @@ void pnv_phb4_bus_init(DeviceState *dev, PnvPHB4 *phb)
     object_property_set_int(OBJECT(pci->bus), "chip-id", phb->chip_id,
                             &error_abort);
 
-    pci_setup_iommu(pci->bus, pnv_phb4_dma_iommu, phb);
+    pci_setup_iommu(pci->bus, &pnv_phb4_iommu_ops, phb);
     pci->bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
 }
 
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 38814247f2a5b7c1a6b55e18673f3fe8c348fbee..453a4e6ed3b02ed448c3fad71bd45eb73a5dbbb3 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -435,6 +435,10 @@ static AddressSpace *e500_pcihost_set_iommu(PCIBus *bus, void *opaque,
     return &s->bm_as;
 }
 
+static const PCIIOMMUOps ppce500_iommu_ops = {
+    .get_address_space = e500_pcihost_set_iommu,
+};
+
 static void e500_pcihost_realize(DeviceState *dev, Error **errp)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
@@ -469,7 +473,7 @@ static void e500_pcihost_realize(DeviceState *dev, Error **errp)
     memory_region_init(&s->bm, OBJECT(s), "bm-e500", UINT64_MAX);
     memory_region_add_subregion(&s->bm, 0x0, &s->busmem);
     address_space_init(&s->bm_as, &s->bm, "pci-bm");
-    pci_setup_iommu(b, e500_pcihost_set_iommu, s);
+    pci_setup_iommu(b, &ppce500_iommu_ops, s);
 
     pci_create_simple(b, 0, "e500-host-bridge");
 
diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index 9a11ac4b2b610646790ed2016f73a16bce4fa42f..86c3a4908712988637484967e88155afb1413742 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -223,6 +223,10 @@ static AddressSpace *raven_pcihost_set_iommu(PCIBus *bus, void *opaque,
     return &s->bm_as;
 }
 
+static const PCIIOMMUOps raven_iommu_ops = {
+    .get_address_space = raven_pcihost_set_iommu,
+};
+
 static void raven_change_gpio(void *opaque, int n, int level)
 {
     PREPPCIState *s = opaque;
@@ -320,7 +324,7 @@ static void raven_pcihost_initfn(Object *obj)
     memory_region_add_subregion(&s->bm, 0         , &s->bm_pci_memory_alias);
     memory_region_add_subregion(&s->bm, 0x80000000, &s->bm_ram_alias);
     address_space_init(&s->bm_as, &s->bm, "raven-bm");
-    pci_setup_iommu(&s->pci_bus, raven_pcihost_set_iommu, s);
+    pci_setup_iommu(&s->pci_bus, &raven_iommu_ops, s);
 
     h->bus = &s->pci_bus;
 
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index dcb2e230b67274d4b87c86eb884e052c26031c27..d0851b48b02237d41f64f6cce6f0aa4740ca0d87 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -112,6 +112,10 @@ static AddressSpace *sabre_pci_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     return &is->iommu_as;
 }
 
+static const PCIIOMMUOps sabre_iommu_ops = {
+    .get_address_space = sabre_pci_dma_iommu,
+};
+
 static void sabre_config_write(void *opaque, hwaddr addr,
                                uint64_t val, unsigned size)
 {
@@ -384,7 +388,7 @@ static void sabre_realize(DeviceState *dev, Error **errp)
     /* IOMMU */
     memory_region_add_subregion_overlap(&s->sabre_config, 0x200,
                     sysbus_mmio_get_region(SYS_BUS_DEVICE(s->iommu), 0), 1);
-    pci_setup_iommu(phb->bus, sabre_pci_dma_iommu, s->iommu);
+    pci_setup_iommu(phb->bus, &sabre_iommu_ops, s->iommu);
 
     /* APB secondary busses */
     pci_dev = pci_new_multifunction(PCI_DEVFN(1, 0), TYPE_SIMBA_PCI_BRIDGE);
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index b0d21bf43a9da8e624507dad868f0aa775fb2ad6..553a91d53c24249bb28e336bce7ee3790ddbfbc9 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2685,7 +2685,7 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
     PCIBus *iommu_bus = bus;
     uint8_t devfn = dev->devfn;
 
-    while (iommu_bus && !iommu_bus->iommu_fn && iommu_bus->parent_dev) {
+    while (iommu_bus && !iommu_bus->iommu_ops && iommu_bus->parent_dev) {
         PCIBus *parent_bus = pci_get_bus(iommu_bus->parent_dev);
 
         /*
@@ -2724,15 +2724,23 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
 
         iommu_bus = parent_bus;
     }
-    if (!pci_bus_bypass_iommu(bus) && iommu_bus && iommu_bus->iommu_fn) {
-        return iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, devfn);
+    if (!pci_bus_bypass_iommu(bus) && iommu_bus->iommu_ops) {
+        return iommu_bus->iommu_ops->get_address_space(bus,
+                                 iommu_bus->iommu_opaque, devfn);
     }
     return &address_space_memory;
 }
 
-void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque)
+void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
 {
-    bus->iommu_fn = fn;
+    /*
+     * If called, pci_setup_iommu() should provide a minimum set of
+     * useful callbacks for the bus.
+     */
+    assert(ops);
+    assert(ops->get_address_space);
+
+    bus->iommu_ops = ops;
     bus->iommu_opaque = opaque;
 }
 
diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index 672090de9478e9c8e9ba8151b72bcaf93495d223..df4ee374d04bea092c4f81098f82514c12c0519c 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -449,6 +449,10 @@ static AddressSpace *ppc440_pcix_set_iommu(PCIBus *b, void *opaque, int devfn)
     return &s->bm_as;
 }
 
+static const PCIIOMMUOps ppc440_iommu_ops = {
+    .get_address_space = ppc440_pcix_set_iommu,
+};
+
 /*
  * Some guests on sam460ex write all kinds of garbage here such as
  * missing enable bit and low bits set and still expect this to work
@@ -503,7 +507,7 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
     memory_region_init(&s->bm, OBJECT(s), "bm-ppc440-pcix", UINT64_MAX);
     memory_region_add_subregion(&s->bm, 0x0, &s->busmem);
     address_space_init(&s->bm_as, &s->bm, "pci-bm");
-    pci_setup_iommu(h->bus, ppc440_pcix_set_iommu, s);
+    pci_setup_iommu(h->bus, &ppc440_iommu_ops, s);
 
     memory_region_init(&s->container, OBJECT(s), "pci-container", PCI_ALL_SIZE);
     memory_region_init_io(&h->conf_mem, OBJECT(s), &ppc440_pcix_host_conf_ops,
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 370c5a90f2184bbe75de9a3b950096960c67189e..a27024e45a4188c5b21e7d41ecf3d337bbbb47f0 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -780,6 +780,10 @@ static AddressSpace *spapr_pci_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     return &phb->iommu_as;
 }
 
+static const PCIIOMMUOps spapr_iommu_ops = {
+    .get_address_space = spapr_pci_dma_iommu,
+};
+
 static char *spapr_phb_vfio_get_loc_code(SpaprPhbState *sphb,  PCIDevice *pdev)
 {
     g_autofree char *path = NULL;
@@ -1978,7 +1982,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&sphb->iommu_root, SPAPR_PCI_MSI_WINDOW,
                                 &sphb->msiwindow);
 
-    pci_setup_iommu(bus, spapr_pci_dma_iommu, sphb);
+    pci_setup_iommu(bus, &spapr_iommu_ops, sphb);
 
     pci_bus_set_route_irq_fn(bus, spapr_route_intx_pin_to_irq);
 
diff --git a/hw/remote/iommu.c b/hw/remote/iommu.c
index 1391dd712ceda0bb5b524651362350471f31f93a..7c56aad0fc14a3a411303dcf3baacef5edfd3d1e 100644
--- a/hw/remote/iommu.c
+++ b/hw/remote/iommu.c
@@ -100,6 +100,10 @@ static void remote_iommu_finalize(Object *obj)
     iommu->elem_by_devfn = NULL;
 }
 
+static const PCIIOMMUOps remote_iommu_ops = {
+    .get_address_space = remote_iommu_find_add_as,
+};
+
 void remote_iommu_setup(PCIBus *pci_bus)
 {
     RemoteIommu *iommu = NULL;
@@ -108,7 +112,7 @@ void remote_iommu_setup(PCIBus *pci_bus)
 
     iommu = REMOTE_IOMMU(object_new(TYPE_REMOTE_IOMMU));
 
-    pci_setup_iommu(pci_bus, remote_iommu_find_add_as, iommu);
+    pci_setup_iommu(pci_bus, &remote_iommu_ops, iommu);
 
     object_property_add_child(OBJECT(pci_bus), "remote-iommu", OBJECT(iommu));
 
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 2ca36f9f3be11866b6c9cb83a61da01d93a4b7c0..347580ebacfe1dd832063b667aa593097ba6926d 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -652,6 +652,10 @@ static AddressSpace *s390_pci_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     return &iommu->as;
 }
 
+static const PCIIOMMUOps s390_iommu_ops = {
+    .get_address_space = s390_pci_dma_iommu,
+};
+
 static uint8_t set_ind_atomic(uint64_t ind_loc, uint8_t to_be_set)
 {
     uint8_t expected, actual;
@@ -839,7 +843,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
     b = pci_register_root_bus(dev, NULL, s390_pci_set_irq, s390_pci_map_irq,
                               NULL, get_system_memory(), get_system_io(), 0,
                               64, TYPE_PCI_BUS);
-    pci_setup_iommu(b, s390_pci_dma_iommu, s);
+    pci_setup_iommu(b, &s390_iommu_ops, s);
 
     bus = BUS(b);
     qbus_set_hotplug_handler(bus, OBJECT(dev));
@@ -1058,7 +1062,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
         pdev = PCI_DEVICE(dev);
         pci_bridge_map_irq(pb, dev->id, s390_pci_map_irq);
-        pci_setup_iommu(&pb->sec_bus, s390_pci_dma_iommu, s);
+        pci_setup_iommu(&pb->sec_bus, &s390_iommu_ops, s);
 
         qbus_set_hotplug_handler(BUS(&pb->sec_bus), OBJECT(s));
 
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index be51635895ce88cb69ec987a5c7d3fa33a703c9e..4c62378f210a63dcd49e596a56802101bb14f0af 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -444,6 +444,10 @@ static AddressSpace *virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
     return &sdev->as;
 }
 
+static const PCIIOMMUOps virtio_iommu_ops = {
+    .get_address_space = virtio_iommu_find_add_as,
+};
+
 static int virtio_iommu_attach(VirtIOIOMMU *s,
                                struct virtio_iommu_req_attach *req)
 {
@@ -1206,7 +1210,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
     s->as_by_busptr = g_hash_table_new_full(NULL, NULL, NULL, g_free);
 
     if (s->primary_bus) {
-        pci_setup_iommu(s->primary_bus, virtio_iommu_find_add_as, s);
+        pci_setup_iommu(s->primary_bus, &virtio_iommu_ops, s);
     } else {
         error_setg(errp, "VIRTIO-IOMMU is not attached to any PCI bus!");
     }
-- 
2.41.0


