Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E42282D79B
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:42:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPKP2-0003bD-3q; Mon, 15 Jan 2024 05:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKOp-0003RA-JV
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:41:00 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKOn-0003GV-8E
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:40:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705315257; x=1736851257;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e7d7tmJy6UgKJguG1e3a0+VD1XweimWsRvnuDM6vvDI=;
 b=UgJ7FWBdqsLPpUN7EZVr/GOft919yL3440fZiZ1kxjO0Hi83yRVyCSxp
 VCq1gxnhxf01LM++T53iCy+tPGHZW4VKSHFEyJ+qVVO3q9cLGsF2fyLOG
 MkYtsu8sBoj8iFo6YKGnfmMMKIJc0Ts8ib+QIYPk4eifWvTgxsBEwjGfW
 Q5cDL/zro+MvY+E8IAb60l01MCcBhhnZYg0caeW3tmcf65vMNHSsQspeh
 fR/s1elD6oGZ5/6SHGgIl7faetlbfMLKeP6UMgXuQgFqGy3EwsclL9Mko
 sEV7VNN3ez4U/JU7g6F5IYSePkFQuVoiypxgs38nwqOynNReTHdtTl0Zj w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="13067884"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="13067884"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:40:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="874065453"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="874065453"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:40:51 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH rfcv1 17/23] intel_iommu: implement firt level translation
Date: Mon, 15 Jan 2024 18:37:29 +0800
Message-Id: <20240115103735.132209-18-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115103735.132209-1-zhenzhong.duan@intel.com>
References: <20240115103735.132209-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
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

From: Yi Liu <yi.l.liu@intel.com>

This adds stage-1 page table walking to support stage-1 only
transltion in scalable mode.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  16 +++
 hw/i386/intel_iommu.c          | 242 ++++++++++++++++++++++++++++++++-
 hw/i386/trace-events           |   2 +
 3 files changed, 258 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index dcf1410fcf..41b958cd5d 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -598,6 +598,22 @@ typedef struct VTDPIOTLBInvInfo VTDPIOTLBInvInfo;
 #define VTD_SM_PASID_ENTRY_WPE_BIT(val)  (!!(((val) >> 4) & 1ULL))
 #define VTD_SM_PASID_ENTRY_EAFE_BIT(val) (!!(((val) >> 7) & 1ULL))
 
+#define VTD_PASID_IOTLB_MAX_SIZE       1024 /* Max size of the hash table */
+
+/* Paging Structure common */
+#define VTD_FL_PT_PAGE_SIZE_MASK    (1ULL << 7)
+/* Bits to decide the offset for each level */
+#define VTD_FL_LEVEL_BITS           9
+
+/* First Level Paging Structure */
+#define VTD_FL_PT_LEVEL             1
+#define VTD_FL_PT_ENTRY_NR          512
+
+/* Masks for First Level Paging Entry */
+#define VTD_FL_RW_MASK              (1ULL << 1)
+#define VTD_FL_PT_BASE_ADDR_MASK(aw) (~(VTD_PAGE_SIZE - 1) & VTD_HAW_MASK(aw))
+#define VTD_PASID_ENTRY_FPD         (1ULL << 1) /* Fault Processing Disable */
+
 /* Second Level Page Translation Pointer*/
 #define VTD_SM_PASID_ENTRY_SLPTPTR     (~0xfffULL)
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 7c24f8f677..1c21f40ccd 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -78,6 +78,10 @@ static void vtd_pasid_cache_sync(IntelIOMMUState *s,
                                  VTDPASIDCacheInfo *pc_info);
 static void vtd_pasid_cache_devsi(IntelIOMMUState *s,
                                   PCIBus *bus, uint16_t devfn);
+static VTDPASIDAddressSpace *vtd_add_find_pasid_as(IntelIOMMUState *s,
+                                                   PCIBus *bus,
+                                                   int devfn,
+                                                   uint32_t pasid);
 
 static void vtd_panic_require_caching_mode(void)
 {
@@ -1888,6 +1892,114 @@ out:
     trace_vtd_pt_enable_fast_path(source_id, success);
 }
 
+/* The shift of an addr for a certain level of paging structure */
+static inline uint32_t vtd_flpt_level_shift(uint32_t level)
+{
+    assert(level != 0);
+    return VTD_PAGE_SHIFT_4K + (level - 1) * VTD_FL_LEVEL_BITS;
+}
+
+static inline uint64_t vtd_flpt_level_page_mask(uint32_t level)
+{
+    return ~((1ULL << vtd_flpt_level_shift(level)) - 1);
+}
+
+static inline dma_addr_t vtd_pe_get_flpt_level(VTDPASIDEntry *pe)
+{
+    return 4 + ((pe->val[2] >> 2) & VTD_SM_PASID_ENTRY_FLPM);
+}
+
+/*
+ * Given an iova and the level of paging structure, return the offset
+ * of current level.
+ */
+static inline uint32_t vtd_iova_fl_level_offset(uint64_t iova, uint32_t level)
+{
+    return (iova >> vtd_flpt_level_shift(level)) &
+            ((1ULL << VTD_FL_LEVEL_BITS) - 1);
+}
+
+/* Get the content of a flpte located in @base_addr[@index] */
+static uint64_t vtd_get_flpte(dma_addr_t base_addr, uint32_t index)
+{
+    uint64_t flpte;
+
+    assert(index < VTD_FL_PT_ENTRY_NR);
+
+    if (dma_memory_read(&address_space_memory,
+                        base_addr + index * sizeof(flpte), &flpte,
+                        sizeof(flpte), MEMTXATTRS_UNSPECIFIED)) {
+        flpte = (uint64_t)-1;
+        return flpte;
+    }
+    flpte = le64_to_cpu(flpte);
+    return flpte;
+}
+
+static inline bool vtd_flpte_present(uint64_t flpte)
+{
+    return !!(flpte & 0x1);
+}
+
+/* Whether the pte indicates the address of the page frame */
+static inline bool vtd_is_last_flpte(uint64_t flpte, uint32_t level)
+{
+    return level == VTD_FL_PT_LEVEL || (flpte & VTD_FL_PT_PAGE_SIZE_MASK);
+}
+
+static inline uint64_t vtd_get_flpte_addr(uint64_t flpte, uint8_t aw)
+{
+    return flpte & VTD_FL_PT_BASE_ADDR_MASK(aw);
+}
+
+/*
+ * Given the @iova, get relevant @flptep. @flpte_level will be the last level
+ * of the translation, can be used for deciding the size of large page.
+ */
+static int vtd_iova_to_flpte(VTDPASIDEntry *pe, uint64_t iova, bool is_write,
+                             uint64_t *flptep, uint32_t *flpte_level,
+                             bool *reads, bool *writes, uint8_t aw_bits)
+{
+    dma_addr_t addr = vtd_pe_get_flpt_base(pe);
+    uint32_t level = vtd_pe_get_flpt_level(pe);
+    uint32_t offset;
+    uint64_t flpte;
+
+    while (true) {
+        offset = vtd_iova_fl_level_offset(iova, level);
+        flpte = vtd_get_flpte(addr, offset);
+        if (flpte == (uint64_t)-1) {
+            if (level == VTD_PE_GET_LEVEL(pe)) {
+                /* Invalid programming of context-entry */
+                return -VTD_FR_CONTEXT_ENTRY_INV;
+            } else {
+                return -VTD_FR_PAGING_ENTRY_INV;
+            }
+        }
+
+        if (!vtd_flpte_present(flpte)) {
+            *reads = false;
+            *writes = false;
+            return -VTD_FR_PAGING_ENTRY_INV;
+        }
+
+        *reads = true;
+        *writes = (*writes) && (flpte & VTD_FL_RW_MASK);
+        if (is_write && !(flpte & VTD_FL_RW_MASK)) {
+            return -VTD_FR_WRITE;
+        }
+
+        if (vtd_is_last_flpte(flpte, level)) {
+            *flptep = flpte;
+            *flpte_level = level;
+            return 0;
+        }
+
+        addr = vtd_get_flpte_addr(flpte, aw_bits);
+        level--;
+    }
+}
+
 static void vtd_report_fault(IntelIOMMUState *s,
                              int err, bool is_fpd_set,
                              uint16_t source_id,
@@ -1904,6 +2016,105 @@ static void vtd_report_fault(IntelIOMMUState *s,
     }
 }
 
+/*
+ * Map dev to pasid-entry then do a paging-structures walk to do a iommu
+ * translation.
+ *
+ * Called from RCU critical section.
+ *
+ * @vtd_as: The untranslated address space
+ * @bus_num: The bus number
+ * @devfn: The devfn, which is the  combined of device and function number
+ * @is_write: The access is a write operation
+ * @entry: IOMMUTLBEntry that contain the addr to be translated and result
+ *
+ * Returns true if translation is successful, otherwise false.
+ */
+static bool vtd_do_iommu_fl_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
+                                      uint8_t devfn, hwaddr addr, bool is_write,
+                                      IOMMUTLBEntry *entry)
+{
+    IntelIOMMUState *s = vtd_as->iommu_state;
+    VTDContextEntry ce;
+    VTDPASIDEntry pe;
+    uint8_t bus_num = pci_bus_num(bus);
+    uint64_t flpte, page_mask;
+    uint32_t level;
+    uint16_t source_id = PCI_BUILD_BDF(bus_num, devfn);
+    int ret;
+    bool is_fpd_set = false;
+    bool reads = true;
+    bool writes = true;
+    uint8_t access_flags;
+
+    /*
+     * We have standalone memory region for interrupt addresses, we
+     * should never receive translation requests in this region.
+     */
+    assert(!vtd_is_interrupt_addr(addr));
+
+    ret = vtd_dev_to_context_entry(s, pci_bus_num(bus), devfn, &ce);
+    if (ret) {
+        error_report_once("%s: detected translation failure 1 "
+                          "(dev=%02x:%02x:%02x, iova=0x%" PRIx64 ")",
+                          __func__, pci_bus_num(bus),
+                          VTD_PCI_SLOT(devfn),
+                          VTD_PCI_FUNC(devfn),
+                          addr);
+        return false;
+    }
+
+    vtd_iommu_lock(s);
+
+    ret = vtd_ce_get_rid2pasid_entry(s, &ce, &pe, PCI_NO_PASID);
+    is_fpd_set = pe.val[0] & VTD_PASID_ENTRY_FPD;
+    if (ret) {
+        vtd_report_fault(s, -ret, is_fpd_set, source_id, addr, is_write,
+                         false, PCI_NO_PASID);
+        goto error;
+    }
+
+    /*
+     * We don't need to translate for pass-through context entries.
+     * Also, let's ignore IOTLB caching as well for PT devices.
+     */
+    if (VTD_PE_GET_TYPE(&pe) == VTD_SM_PASID_ENTRY_PT) {
+        entry->iova = addr & VTD_PAGE_MASK_4K;
+        entry->translated_addr = entry->iova;
+        entry->addr_mask = ~VTD_PAGE_MASK_4K;
+        entry->perm = IOMMU_RW;
+        vtd_iommu_unlock(s);
+        return true;
+    }
+
+    ret = vtd_iova_to_flpte(&pe, addr, is_write, &flpte, &level,
+                            &reads, &writes, s->aw_bits);
+    if (ret) {
+        vtd_report_fault(s, -ret, is_fpd_set, source_id, addr, is_write,
+                         false, PCI_NO_PASID);
+        goto error;
+    }
+
+    page_mask = vtd_flpt_level_page_mask(level);
+    access_flags = IOMMU_ACCESS_FLAG(reads, writes);
+
+    vtd_iommu_unlock(s);
+
+    entry->iova = addr & page_mask;
+    entry->translated_addr = vtd_get_flpte_addr(flpte, s->aw_bits) & page_mask;
+    entry->addr_mask = ~page_mask;
+    entry->perm = access_flags;
+    return true;
+
+error:
+    vtd_iommu_unlock(s);
+    entry->iova = 0;
+    entry->translated_addr = 0;
+    entry->addr_mask = 0;
+    entry->perm = IOMMU_NONE;
+    return false;
+}
+
 /* Map dev to context-entry then do a paging-structures walk to do a iommu
  * translation.
  *
@@ -4516,10 +4727,37 @@ static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
         .target_as = &address_space_memory,
     };
     bool success;
+    VTDContextEntry ce;
+    VTDPASIDEntry pe;
+    int ret = 0;
 
     if (likely(s->dmar_enabled)) {
-        success = vtd_do_iommu_translate(vtd_as, vtd_as->bus, vtd_as->devfn,
-                                         addr, flag & IOMMU_WO, &iotlb);
+        if (s->root_scalable) {
+            ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
+                                           vtd_as->devfn, &ce);
+            ret = vtd_ce_get_rid2pasid_entry(s, &ce, &pe, PCI_NO_PASID);
+            if (ret) {
+                error_report_once("%s: detected translation failure 1 "
+                                  "(dev=%02x:%02x:%02x, iova=0x%" PRIx64 ")",
+                                  __func__, pci_bus_num(vtd_as->bus),
+                                  VTD_PCI_SLOT(vtd_as->devfn),
+                                  VTD_PCI_FUNC(vtd_as->devfn),
+                                  addr);
+                return iotlb;
+            }
+            if (VTD_PE_GET_TYPE(&pe) == VTD_SM_PASID_ENTRY_FLT) {
+                success = vtd_do_iommu_fl_translate(vtd_as, vtd_as->bus,
+                                                    vtd_as->devfn, addr,
+                                                    flag & IOMMU_WO, &iotlb);
+            } else {
+                success = vtd_do_iommu_translate(vtd_as, vtd_as->bus,
+                                                 vtd_as->devfn, addr,
+                                                 flag & IOMMU_WO, &iotlb);
+            }
+        } else {
+            success = vtd_do_iommu_translate(vtd_as, vtd_as->bus, vtd_as->devfn,
+                                             addr, flag & IOMMU_WO, &iotlb);
+        }
     } else {
         /* DMAR disabled, passthrough, use 4k-page*/
         iotlb.iova = addr & VTD_PAGE_MASK_4K;
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 66f7c1ba59..00b27bc5b1 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -33,6 +33,8 @@ vtd_re_not_present(uint8_t bus) "Root entry bus %"PRIu8" not present"
 vtd_ce_not_present(uint8_t bus, uint8_t devfn) "Context entry bus %"PRIu8" devfn %"PRIu8" not present"
 vtd_iotlb_page_hit(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page hit sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16
 vtd_iotlb_page_update(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page update sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16
+vtd_iotlb_pe_hit(uint32_t pasid, uint64_t val0, uint32_t gen) "IOTLB pasid hit pasid %"PRIu32" val[0] 0x%"PRIx64" gen %"PRIu32
+vtd_iotlb_pe_update(uint32_t pasid, uint64_t val0, uint32_t gen1, uint32_t gen2) "IOTLB pasid update pasid %"PRIu32" val[0] 0x%"PRIx64" gen %"PRIu32" -> gen %"PRIu32
 vtd_iotlb_cc_hit(uint8_t bus, uint8_t devfn, uint64_t high, uint64_t low, uint32_t gen) "IOTLB context hit bus 0x%"PRIx8" devfn 0x%"PRIx8" high 0x%"PRIx64" low 0x%"PRIx64" gen %"PRIu32
 vtd_iotlb_cc_update(uint8_t bus, uint8_t devfn, uint64_t high, uint64_t low, uint32_t gen1, uint32_t gen2) "IOTLB context update bus 0x%"PRIx8" devfn 0x%"PRIx8" high 0x%"PRIx64" low 0x%"PRIx64" gen %"PRIu32" -> gen %"PRIu32
 vtd_iotlb_reset(const char *reason) "IOTLB reset (reason: %s)"
-- 
2.34.1


