Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1CB835B2A
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 07:43:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRo1O-0005K6-3Y; Mon, 22 Jan 2024 01:43:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rRo1D-0005A1-Il; Mon, 22 Jan 2024 01:42:51 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rRo19-0007FD-Nl; Mon, 22 Jan 2024 01:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705905768; x=1737441768;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sd2qhbDS+R0CvE0gfiTA/WvHWETVcnWh56P7wXLnVzg=;
 b=Qg9Ne1HPrhPMl62g8DvvVkN4Gy/dDZ17xtSM+utGPWDh6BKqWoeOqakm
 uk+sB0hNeza7FVloYH1vvzFJfO39zV6Ze9LGoqcAL5HVZYhkS6G7oDTgN
 sGBu4xUtn+6JyEnrWRFHvjOLREJyU3hS0qSAyNEzaNTRaGpB1V5SVR2xF
 aJFCshTPCv7QQD34PgfZe/Zr9dl6ovLqd3X5szgCES4abi6KOIcBlnS48
 DkjYq3rXARqrmSGt1G6XBOmbUP/Q16XFtpl4vsZoEKVAXGBMM1aB5guwo
 ODzyvPz8zJQxZqqqf9TasI9sZQGQQxmJU7jFS6iELV+IX1LFiansvslEB g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="7792088"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="7792088"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2024 22:42:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="761646691"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; d="scan'208";a="761646691"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2024 22:42:34 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: eric.auger@redhat.com, jean-philippe@linaro.org,
 alex.williamson@redhat.com, clg@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Helge Deller <deller@gmx.de>, Andrey Smirnov <andrew.smirnov@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-ppc@nongnu.org (open list:PowerNV Non-Virt...),
 qemu-s390x@nongnu.org (open list:S390 PCI)
Subject: [PATCH 2/3] hw/pci: Add two parameters to get_address_space
Date: Mon, 22 Jan 2024 14:40:14 +0800
Message-Id: <20240122064015.94630-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122064015.94630-1-zhenzhong.duan@intel.com>
References: <20240122064015.94630-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This adds PCI device's real bus and devfn to API get_address_space(),
for vIOMMU which also wants real BDF, i.e., virtio-iommu.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/pci/pci.h     | 11 ++++++++---
 hw/alpha/typhoon.c       |  3 ++-
 hw/arm/smmu-common.c     |  3 ++-
 hw/i386/amd_iommu.c      |  6 ++++--
 hw/i386/intel_iommu.c    |  6 ++++--
 hw/pci-host/astro.c      |  3 ++-
 hw/pci-host/designware.c |  3 ++-
 hw/pci-host/dino.c       |  3 ++-
 hw/pci-host/pnv_phb3.c   |  3 ++-
 hw/pci-host/pnv_phb4.c   |  3 ++-
 hw/pci-host/ppce500.c    |  3 ++-
 hw/pci-host/raven.c      |  3 ++-
 hw/pci-host/sabre.c      |  3 ++-
 hw/pci/pci.c             |  3 ++-
 hw/ppc/ppc440_pcix.c     |  3 ++-
 hw/ppc/spapr_pci.c       |  3 ++-
 hw/remote/iommu.c        |  3 ++-
 hw/s390x/s390-pci-bus.c  |  3 ++-
 hw/virtio/virtio-iommu.c |  3 ++-
 19 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index fa6313aabc..2483d61a8c 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -378,13 +378,18 @@ typedef struct PCIIOMMUOps {
      *
      * Mandatory callback which returns a pointer to an #AddressSpace
      *
-     * @bus: the #PCIBus being accessed.
+     * @bus: the aliased #PCIBus being accessed.
      *
      * @opaque: the data passed to pci_setup_iommu().
      *
-     * @devfn: device and function number
+     * @devfn: aliased device and function number
+     *
+     * @real_bus: the #PCIBus being accessed.
+     *
+     * @real_devfn: device and function number
      */
-   AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int devfn);
+   AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int devfn,
+                                       PCIBus *real_bus, int real_devfn);
 } PCIIOMMUOps;
 
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index e8711ae16a..eda5a1c391 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -732,7 +732,8 @@ static IOMMUTLBEntry typhoon_translate_iommu(IOMMUMemoryRegion *iommu,
     return ret;
 }
 
-static AddressSpace *typhoon_pci_dma_iommu(PCIBus *bus, void *opaque, int devfn)
+static AddressSpace *typhoon_pci_dma_iommu(PCIBus *bus, void *opaque, int devfn,
+                                           PCIBus *real_bus, int real_devfn)
 {
     TyphoonState *s = opaque;
     return &s->pchip.iommu_as;
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 9a8ac45431..c3a8f84c38 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -569,7 +569,8 @@ SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num)
     return NULL;
 }
 
-static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
+static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn,
+                                      PCIBus *real_bus, int real_devfn)
 {
     SMMUState *s = opaque;
     SMMUPciBus *sbus = g_hash_table_lookup(s->smmu_pcibus_by_busptr, bus);
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 4203144da9..0cc63fd050 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1390,7 +1390,8 @@ static const MemoryRegionOps amdvi_ir_ops = {
     }
 };
 
-static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
+static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn,
+                                          PCIBus *real_bus, int real_devfn)
 {
     char name[128];
     AMDVIState *s = opaque;
@@ -1578,7 +1579,8 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     }
 
     /* Pseudo address space under root PCI bus. */
-    x86ms->ioapic_as = amdvi_host_dma_iommu(bus, s, AMDVI_IOAPIC_SB_DEVID);
+    x86ms->ioapic_as = amdvi_host_dma_iommu(bus, s, AMDVI_IOAPIC_SB_DEVID,
+                                            NULL, 0);
 
     /* set up MMIO */
     memory_region_init_io(&s->mmio, OBJECT(s), &mmio_mem_ops, s, "amdvi-mmio",
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 1a07faddb4..9d8c8e1d03 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4094,7 +4094,8 @@ static void vtd_reset(DeviceState *dev)
     vtd_address_space_refresh_all(s);
 }
 
-static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
+static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn,
+                                        PCIBus *real_bus, int real_devfn)
 {
     IntelIOMMUState *s = opaque;
     VTDAddressSpace *vtd_as;
@@ -4233,7 +4234,8 @@ static void vtd_realize(DeviceState *dev, Error **errp)
     vtd_init(s);
     pci_setup_iommu(bus, &vtd_iommu_ops, dev);
     /* Pseudo address space under root PCI bus. */
-    x86ms->ioapic_as = vtd_host_dma_iommu(bus, s, Q35_PSEUDO_DEVFN_IOAPIC);
+    x86ms->ioapic_as = vtd_host_dma_iommu(bus, s, Q35_PSEUDO_DEVFN_IOAPIC,
+                                          NULL, 0);
     qemu_add_machine_init_done_notifier(&vtd_machine_done_notify);
 }
 
diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 37d271118c..c6c0f3f95f 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -337,7 +337,8 @@ static IOMMUTLBEntry astro_translate_iommu(IOMMUMemoryRegion *iommu,
 }
 
 static AddressSpace *elroy_pcihost_set_iommu(PCIBus *bus, void *opaque,
-                                            int devfn)
+                                             int devfn,
+                                             PCIBus *real_bus, int real_devfn)
 {
     ElroyState *s = opaque;
     return &s->astro->iommu_as;
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index dd9e389c07..fc652e6609 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -656,7 +656,8 @@ static const MemoryRegionOps designware_pci_mmio_ops = {
 };
 
 static AddressSpace *designware_pcie_host_set_iommu(PCIBus *bus, void *opaque,
-                                                    int devfn)
+                                                    int devfn, PCIBus *real_bus,
+                                                    int real_devfn)
 {
     DesignwarePCIEHost *s = DESIGNWARE_PCIE_HOST(opaque);
 
diff --git a/hw/pci-host/dino.c b/hw/pci-host/dino.c
index d992c4bb69..45f8784b2b 100644
--- a/hw/pci-host/dino.c
+++ b/hw/pci-host/dino.c
@@ -347,7 +347,8 @@ static const MemoryRegionOps dino_config_addr_ops = {
 };
 
 static AddressSpace *dino_pcihost_set_iommu(PCIBus *bus, void *opaque,
-                                            int devfn)
+                                            int devfn, PCIBus *real_bus,
+                                            int real_devfn)
 {
     DinoState *s = opaque;
 
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index 2a74dbe45f..a0c4235fae 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -935,7 +935,8 @@ static const MemoryRegionOps pnv_phb3_msi_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN
 };
 
-static AddressSpace *pnv_phb3_dma_iommu(PCIBus *bus, void *opaque, int devfn)
+static AddressSpace *pnv_phb3_dma_iommu(PCIBus *bus, void *opaque, int devfn,
+                                        PCIBus *real_bus, int real_devfn)
 {
     PnvPHB3 *phb = opaque;
     PnvPhb3DMASpace *ds;
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 075499d36d..fee34f376e 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1450,7 +1450,8 @@ static PnvPhb4DMASpace *pnv_phb4_dma_find(PnvPHB4 *phb, PCIBus *bus, int devfn)
     return ds;
 }
 
-static AddressSpace *pnv_phb4_dma_iommu(PCIBus *bus, void *opaque, int devfn)
+static AddressSpace *pnv_phb4_dma_iommu(PCIBus *bus, void *opaque, int devfn,
+                                        PCIBus *real_bus, int real_devfn)
 {
     PnvPHB4 *phb = opaque;
     PnvPhb4DMASpace *ds;
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index fa0d67b342..52c17a8a02 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -428,7 +428,8 @@ static void e500_pcihost_bridge_realize(PCIDevice *d, Error **errp)
 }
 
 static AddressSpace *e500_pcihost_set_iommu(PCIBus *bus, void *opaque,
-                                            int devfn)
+                                            int devfn, PCIBus *real_bus,
+                                            int real_devfn)
 {
     PPCE500PCIState *s = opaque;
 
diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index c7a0a2878a..d1b7c1a847 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -216,7 +216,8 @@ static void raven_set_irq(void *opaque, int irq_num, int level)
 }
 
 static AddressSpace *raven_pcihost_set_iommu(PCIBus *bus, void *opaque,
-                                             int devfn)
+                                             int devfn, PCIBus *real_bus,
+                                             int real_devfn)
 {
     PREPPCIState *s = opaque;
 
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index d0851b48b0..c82c62c640 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -105,7 +105,8 @@ static inline void sabre_clear_request(SabreState *s, unsigned int irq_num)
     s->irq_request = NO_IRQ_REQUEST;
 }
 
-static AddressSpace *sabre_pci_dma_iommu(PCIBus *bus, void *opaque, int devfn)
+static AddressSpace *sabre_pci_dma_iommu(PCIBus *bus, void *opaque, int devfn,
+                                         PCIBus *real_bus, int real_devfn)
 {
     IOMMUState *is = opaque;
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 76080af580..2f91b87559 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2719,7 +2719,8 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
     }
     if (!pci_bus_bypass_iommu(bus) && iommu_bus->iommu_ops) {
         return iommu_bus->iommu_ops->get_address_space(bus,
-                                 iommu_bus->iommu_opaque, devfn);
+                                 iommu_bus->iommu_opaque, devfn,
+                                 pci_get_bus(dev), dev->devfn);
     }
     return &address_space_memory;
 }
diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index df4ee374d0..ea8fa28699 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -442,7 +442,8 @@ static void ppc440_pcix_set_irq(void *opaque, int irq_num, int level)
     qemu_set_irq(*pci_irq, level);
 }
 
-static AddressSpace *ppc440_pcix_set_iommu(PCIBus *b, void *opaque, int devfn)
+static AddressSpace *ppc440_pcix_set_iommu(PCIBus *b, void *opaque, int devfn,
+                                           PCIBus *real_bus, int real_devfn)
 {
     PPC440PCIXState *s = opaque;
 
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 25e0295d6f..4a2893c845 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -773,7 +773,8 @@ static const MemoryRegionOps spapr_msi_ops = {
 /*
  * PHB PCI device
  */
-static AddressSpace *spapr_pci_dma_iommu(PCIBus *bus, void *opaque, int devfn)
+static AddressSpace *spapr_pci_dma_iommu(PCIBus *bus, void *opaque, int devfn,
+                                         PCIBus *real_bus, int real_devfn)
 {
     SpaprPhbState *phb = opaque;
 
diff --git a/hw/remote/iommu.c b/hw/remote/iommu.c
index 7c56aad0fc..7e71647e79 100644
--- a/hw/remote/iommu.c
+++ b/hw/remote/iommu.c
@@ -37,7 +37,8 @@
  */
 
 static AddressSpace *remote_iommu_find_add_as(PCIBus *pci_bus,
-                                              void *opaque, int devfn)
+                                              void *opaque, int devfn,
+                                              PCIBus *real_bus, int real_devfn)
 {
     RemoteIommu *iommu = opaque;
     RemoteIommuElem *elem = NULL;
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 347580ebac..00de41df69 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -644,7 +644,8 @@ static S390PCIIOMMU *s390_pci_get_iommu(S390pciState *s, PCIBus *bus,
     return iommu;
 }
 
-static AddressSpace *s390_pci_dma_iommu(PCIBus *bus, void *opaque, int devfn)
+static AddressSpace *s390_pci_dma_iommu(PCIBus *bus, void *opaque, int devfn,
+                                        PCIBus *real_bus, int real_devfn)
 {
     S390pciState *s = opaque;
     S390PCIIOMMU *iommu = s390_pci_get_iommu(s, bus, devfn);
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index bfce3237f3..d99c1f0d64 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -395,7 +395,8 @@ static void add_prop_resv_regions(IOMMUDevice *sdev)
 }
 
 static AddressSpace *virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
-                                              int devfn)
+                                              int devfn, PCIBus *real_bus,
+                                              int real_devfn)
 {
     VirtIOIOMMU *s = opaque;
     IOMMUPciBus *sbus = g_hash_table_lookup(s->as_by_busptr, bus);
-- 
2.34.1


