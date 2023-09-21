Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F6E7A92A3
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 10:36:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjFA9-0006Tn-II; Thu, 21 Sep 2023 04:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qjF9l-0005yy-15; Thu, 21 Sep 2023 04:35:29 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qjF9i-0001H1-MS; Thu, 21 Sep 2023 04:35:28 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 23F1B23DA8;
 Thu, 21 Sep 2023 11:35:34 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C263229A02;
 Thu, 21 Sep 2023 11:35:12 +0300 (MSK)
Received: (nullmailer pid 509097 invoked by uid 1000);
 Thu, 21 Sep 2023 08:35:11 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/17] hw/pci: spelling fixes
Date: Thu, 21 Sep 2023 11:34:54 +0300
Message-Id: <20230921083506.509032-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230921083506.509032-1-mjt@tls.msk.ru>
References: <20230921083506.509032-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/pci-bridge/cxl_downstream.c      | 2 +-
 hw/pci-bridge/pci_expander_bridge.c | 2 +-
 hw/pci-host/bonito.c                | 2 +-
 hw/pci-host/designware.c            | 4 ++--
 hw/pci-host/dino.c                  | 2 +-
 hw/pci-host/gpex-acpi.c             | 2 +-
 hw/pci-host/gt64120.c               | 4 ++--
 hw/pci-host/pnv_phb.c               | 2 +-
 hw/pci-host/pnv_phb3.c              | 2 +-
 hw/pci-host/pnv_phb3_msi.c          | 2 +-
 hw/pci-host/pnv_phb4.c              | 6 +++---
 hw/pci/pcie_aer.c                   | 2 +-
 hw/pci/shpc.c                       | 2 +-
 13 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 54f507318f..5a2b749c8e 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -42,7 +42,7 @@ static void latch_registers(CXLDownstreamPort *dsp)
                                        CXL2_DOWNSTREAM_PORT);
 }
 
-/* TODO: Look at sharing this code acorss all CXL port types */
+/* TODO: Look at sharing this code across all CXL port types */
 static void cxl_dsp_dvsec_write_config(PCIDevice *dev, uint32_t addr,
                                       uint32_t val, int len)
 {
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 613857b601..535889f7c2 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -263,7 +263,7 @@ static int pxb_map_irq_fn(PCIDevice *pci_dev, int pin)
 
     /*
      * First carry out normal swizzle to handle
-     * multple root ports on a pxb instance.
+     * multiple root ports on a pxb instance.
      */
     pin = pci_swizzle_map_irq_fn(pci_dev, pin);
 
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 4701481b9b..ee6cb85e97 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -62,7 +62,7 @@
 #define DPRINTF(fmt, ...)
 #endif
 
-/* from linux soure code. include/asm-mips/mips-boards/bonito64.h*/
+/* from linux source code. include/asm-mips/mips-boards/bonito64.h*/
 #define BONITO_BOOT_BASE        0x1fc00000
 #define BONITO_BOOT_SIZE        0x00100000
 #define BONITO_BOOT_TOP         (BONITO_BOOT_BASE + BONITO_BOOT_SIZE - 1)
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 388d252ee2..6f5442f108 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -488,7 +488,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
 
     /*
      * If no inbound iATU windows are configured, HW defaults to
-     * letting inbound TLPs to pass in. We emulate that by exlicitly
+     * letting inbound TLPs to pass in. We emulate that by explicitly
      * configuring first inbound window to cover all of target's
      * address space.
      *
@@ -503,7 +503,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
                           &designware_pci_host_msi_ops,
                           root, "pcie-msi", 0x4);
     /*
-     * We initially place MSI interrupt I/O region a adress 0 and
+     * We initially place MSI interrupt I/O region at address 0 and
      * disable it. It'll be later moved to correct offset and enabled
      * in designware_pcie_root_update_msi_mapping() as a part of
      * initialization done by guest OS
diff --git a/hw/pci-host/dino.c b/hw/pci-host/dino.c
index e8eaebca54..82503229fa 100644
--- a/hw/pci-host/dino.c
+++ b/hw/pci-host/dino.c
@@ -1,5 +1,5 @@
 /*
- * HP-PARISC Dino PCI chipset emulation, as in B160L and similiar machines
+ * HP-PARISC Dino PCI chipset emulation, as in B160L and similar machines
  *
  * (C) 2017-2019 by Helge Deller <deller@gmx.de>
  *
diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index 7c7316bc96..1092dc3b70 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -177,7 +177,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
             acpi_dsdt_add_pci_route_table(dev, cfg->irq);
 
             /*
-             * Resources defined for PXBs are composed by the folling parts:
+             * Resources defined for PXBs are composed of the following parts:
              * 1. The resources the pci-brige/pcie-root-port need.
              * 2. The resources the devices behind pxb need.
              */
diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index 82c15edb46..143bf053d7 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -331,9 +331,9 @@ static void gt64120_update_pci_cfgdata_mapping(GT64120State *s)
     /*
      * The setting of the MByteSwap bit and MWordSwap bit in the PCI Internal
      * Command Register determines how data transactions from the CPU to/from
-     * PCI are handled along with the setting of the Endianess bit in the CPU
+     * PCI are handled along with the setting of the Endianness bit in the CPU
      * Configuration Register. See:
-     * - Table 16: 32-bit PCI Transaction Endianess
+     * - Table 16: 32-bit PCI Transaction Endianness
      * - Table 158: PCI_0 Command, Offset: 0xc00
      */
 
diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
index 82332d7a05..157c00782c 100644
--- a/hw/pci-host/pnv_phb.c
+++ b/hw/pci-host/pnv_phb.c
@@ -25,7 +25,7 @@
  * state associated with the child has an id, use it as QOM id.
  * Otherwise use object_typename[index] as QOM id.
  *
- * This helper does both operations at the same time because seting
+ * This helper does both operations at the same time because setting
  * a new QOM child will erase the bus parent of the device. This happens
  * because object_unparent() will call object_property_del_child(),
  * which in turn calls the property release callback prop->release if
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index 7a21497cf8..c5e58f4086 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -757,7 +757,7 @@ static void pnv_phb3_translate_tve(PnvPhb3DMASpace *ds, hwaddr addr,
          * We only support non-translate in top window.
          *
          * TODO: Venice/Murano support it on bottom window above 4G and
-         * Naples suports it on everything
+         * Naples supports it on everything
          */
         if (!(tve & PPC_BIT(51))) {
             phb3_error(phb, "xlate for invalid non-translate TVE");
diff --git a/hw/pci-host/pnv_phb3_msi.c b/hw/pci-host/pnv_phb3_msi.c
index 41e63b066f..dc8d8637f2 100644
--- a/hw/pci-host/pnv_phb3_msi.c
+++ b/hw/pci-host/pnv_phb3_msi.c
@@ -281,7 +281,7 @@ static void phb3_msi_instance_init(Object *obj)
                              object_property_allow_set_link,
                              OBJ_PROP_LINK_STRONG);
 
-    /* Will be overriden later */
+    /* Will be overridden later */
     ics->offset = 0;
 }
 
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 6232cbeee1..29cb11a5d9 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -207,7 +207,7 @@ static void pnv_phb4_check_mbt(PnvPHB4 *phb, uint32_t index)
         start = base | (phb->regs[PHB_M64_UPPER_BITS >> 3]);
     }
 
-    /* TODO: Figure out how to implemet/decode AOMASK */
+    /* TODO: Figure out how to implement/decode AOMASK */
 
     /* Check if it matches an enabled MMIO region in the PEC stack */
     if (memory_region_is_mapped(&phb->mmbar0) &&
@@ -391,7 +391,7 @@ static void pnv_phb4_ioda_write(PnvPHB4 *phb, uint64_t val)
     case IODA3_TBL_MBT:
         *tptr = val;
 
-        /* Copy accross the valid bit to the other half */
+        /* Copy across the valid bit to the other half */
         phb->ioda_MBT[idx ^ 1] &= 0x7fffffffffffffffull;
         phb->ioda_MBT[idx ^ 1] |= 0x8000000000000000ull & val;
 
@@ -1408,7 +1408,7 @@ static void pnv_phb4_msi_write(void *opaque, hwaddr addr,
         return;
     }
 
-    /* TODO: check PE/MSI assignement */
+    /* TODO: check PE/MSI assignment */
 
     qemu_irq_pulse(phb->qirqs[src]);
 }
diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index 374d593ead..b68c7ecb49 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -324,7 +324,7 @@ static void pcie_aer_msg_root_port(PCIDevice *dev, const PCIEAERMsg *msg)
          * it isn't implemented in qemu right now.
          * So just discard the error for now.
          * OS which cares of aer would receive errors via
-         * native aer mechanims, so this wouldn't matter.
+         * native aer mechanisms, so this wouldn't matter.
          */
     }
 
diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index e7bc7192f1..df7f370111 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -615,7 +615,7 @@ int shpc_init(PCIDevice *d, PCIBus *sec_bus, MemoryRegion *bar,
     }
     if (nslots > SHPC_MAX_SLOTS ||
         SHPC_IDX_TO_PCI(nslots) > PCI_SLOT_MAX) {
-        /* TODO: report an error mesage that makes sense. */
+        /* TODO: report an error message that makes sense. */
         return -EINVAL;
     }
     shpc->nslots = nslots;
-- 
2.39.2


