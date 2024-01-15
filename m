Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9025182D79E
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:43:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPKPn-0005h4-DY; Mon, 15 Jan 2024 05:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKPG-0004TG-9q
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:41:26 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKPC-0003Jt-N0
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705315283; x=1736851283;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Drqd7XZ0POrpiPaI6AYByololYTsjcc0JUEruQOVOfs=;
 b=Pj7HObdx8wS0TDXX4KbQDEhuCX9XY2ZStwj3vnMblfgwRDFKJ48e2idO
 mH/eOk5+K0qyoaU0b387bKpxr2SoKI82JWzw0s8piYsbiyjXysySNRsJS
 97hV8QfCETE1PWEiXPZfc0r1/U8m9Pvr7YK4XrjNrXbhi4fWNuu73BMDU
 2ICCzayqUQSieT11NePWXoWYBsJtSdW3cW+xx7dSPp8eKoBUsw6zeCdZt
 KUT9b4Y8fK+7eDmw1LqLRn4ZdVDOaSgytHk7leSromWip3Ng/m/6a46iF
 i7hnG/ADnzKTBNk09k0PRNdpoLPxQJmu+ZfG4vb+F0c7qBkeD2FBu9JyQ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="13067942"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="13067942"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:41:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="874065582"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="874065582"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:41:02 -0800
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
Subject: [PATCH rfcv1 19/23] intel_iommu: introduce pasid iotlb cache
Date: Mon, 15 Jan 2024 18:37:31 +0800
Message-Id: <20240115103735.132209-20-zhenzhong.duan@intel.com>
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

To accelerate stage-1 translation, introduce pasid iotlb cache.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |   1 +
 include/hw/i386/intel_iommu.h  |   1 +
 hw/i386/intel_iommu.c          | 126 +++++++++++++++++++++++++++++++--
 hw/i386/trace-events           |   1 +
 4 files changed, 124 insertions(+), 5 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 21fa767740..08701f5457 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -480,6 +480,7 @@ typedef union VTDInvDesc VTDInvDesc;
 
 /* Information about page-selective IOTLB invalidate */
 struct VTDIOTLBPageInvInfo {
+    bool is_piotlb;
     uint16_t domain_id;
     uint32_t pasid;
     uint64_t addr;
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index dedaab5ac9..f3e75263b7 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -348,6 +348,7 @@ struct IntelIOMMUState {
 
     uint32_t context_cache_gen;     /* Should be in [1,MAX] */
     GHashTable *iotlb;              /* IOTLB */
+    GHashTable *p_iotlb;            /* pasid based IOTLB */
 
     GHashTable *vtd_address_spaces;             /* VTD address spaces */
     VTDAddressSpace *vtd_as_cache[VTD_PCI_BUS_MAX]; /* VTD address space cache */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 1e87383a41..e9480608a5 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -82,6 +82,8 @@ static VTDPASIDAddressSpace *vtd_add_find_pasid_as(IntelIOMMUState *s,
                                                    PCIBus *bus,
                                                    int devfn,
                                                    uint32_t pasid);
+static int vtd_dev_get_rid2pasid(IntelIOMMUState *s, uint8_t bus_num,
+                                 uint8_t devfn, uint32_t *rid_pasid);
 
 static void vtd_panic_require_caching_mode(void)
 {
@@ -297,6 +299,7 @@ static gboolean vtd_hash_remove_by_page(gpointer key, gpointer value,
     uint64_t gfn = (info->addr >> VTD_PAGE_SHIFT_4K) & info->mask;
     uint64_t gfn_tlb = (info->addr & entry->mask) >> VTD_PAGE_SHIFT_4K;
     return (entry->domain_id == info->domain_id) &&
+            (info->is_piotlb ? (entry->pasid == info->pasid) : 1) &&
             (((entry->gfn & info->mask) == gfn) ||
              (entry->gfn == gfn_tlb));
 }
@@ -333,12 +336,19 @@ static void vtd_reset_iotlb(IntelIOMMUState *s)
     vtd_iommu_unlock(s);
 }
 
+static void vtd_reset_piotlb(IntelIOMMUState *s)
+{
+    assert(s->p_iotlb);
+    g_hash_table_remove_all(s->p_iotlb);
+}
+
 static void vtd_reset_caches(IntelIOMMUState *s)
 {
     vtd_iommu_lock(s);
     vtd_reset_iotlb_locked(s);
     vtd_reset_context_cache_locked(s);
     vtd_pasid_cache_reset(s);
+    vtd_reset_piotlb(s);
     vtd_iommu_unlock(s);
 }
 
@@ -2026,6 +2036,63 @@ static void vtd_report_fault(IntelIOMMUState *s,
     }
 }
 
+static uint64_t vtd_get_piotlb_gfn(hwaddr addr, uint32_t level)
+{
+    return (addr & vtd_flpt_level_page_mask(level)) >> VTD_PAGE_SHIFT_4K;
+}
+
+static int vtd_get_piotlb_key(char *key, int key_size, uint64_t gfn,
+                              uint32_t pasid, uint32_t level,
+                              uint16_t source_id)
+{
+    return snprintf(key, key_size,
+                    "rsv%010dsid%06dpasid%010dgfn%017lldlevel%01d",
+                    0, source_id, pasid, (unsigned long long int)gfn, level);
+}
+
+static VTDIOTLBEntry *vtd_lookup_piotlb(IntelIOMMUState *s, uint32_t pasid,
+                                        hwaddr addr, uint16_t source_id)
+{
+    VTDIOTLBEntry *entry;
+    char key[64];
+    int level;
+
+    for (level = VTD_SL_PT_LEVEL; level < VTD_SL_PML4_LEVEL; level++) {
+        vtd_get_piotlb_key(&key[0], 64, vtd_get_piotlb_gfn(addr, level),
+                           pasid, level, source_id);
+        entry = g_hash_table_lookup(s->p_iotlb, &key[0]);
+        if (entry) {
+            goto out;
+        }
+    }
+
+out:
+    return entry;
+}
+
+static void vtd_update_piotlb(IntelIOMMUState *s, uint32_t pasid,
+                              uint16_t domain_id, hwaddr addr, uint64_t flpte,
+                              uint8_t access_flags, uint32_t level,
+                              uint16_t source_id)
+{
+    VTDIOTLBEntry *entry = g_malloc(sizeof(*entry));
+    char *key = g_malloc(64);
+    uint64_t gfn = vtd_get_piotlb_gfn(addr, level);
+
+    if (g_hash_table_size(s->p_iotlb) >= VTD_PASID_IOTLB_MAX_SIZE) {
+        vtd_reset_piotlb(s);
+    }
+
+    entry->gfn = gfn;
+    entry->domain_id = domain_id;
+    entry->pte = flpte;
+    entry->pasid = pasid;
+    entry->access_flags = access_flags;
+    entry->mask = vtd_flpt_level_page_mask(level);
+    vtd_get_piotlb_key(key, 64, gfn, pasid, level, source_id);
+    g_hash_table_replace(s->p_iotlb, key, entry);
+}
+
 /*
  * Map dev to pasid-entry then do a paging-structures walk to do a iommu
  * translation.
@@ -2056,6 +2123,8 @@ static bool vtd_do_iommu_fl_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     bool reads = true;
     bool writes = true;
     uint8_t access_flags;
+    uint32_t pasid;
+    VTDIOTLBEntry *piotlb_entry;
 
     /*
      * We have standalone memory region for interrupt addresses, we
@@ -2074,8 +2143,30 @@ static bool vtd_do_iommu_fl_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
         return false;
     }
 
+    /* For emulated device IOVA translation, use RID2PASID. */
+    if (vtd_dev_get_rid2pasid(s, pci_bus_num(bus), devfn, &pasid)) {
+        error_report_once("%s: detected translation failure 2 "
+                          "(dev=%02x:%02x:%02x, iova=0x%" PRIx64 ")",
+                          __func__, pci_bus_num(bus),
+                          VTD_PCI_SLOT(devfn),
+                          VTD_PCI_FUNC(devfn),
+                          addr);
+        return false;
+    }
+
     vtd_iommu_lock(s);
 
+    /* Try to fetch flpte form IOTLB */
+    piotlb_entry = vtd_lookup_piotlb(s, pasid, addr, source_id);
+    if (piotlb_entry) {
+        trace_vtd_piotlb_page_hit(source_id, pasid, addr, piotlb_entry->pte,
+                                  piotlb_entry->domain_id);
+        flpte = piotlb_entry->pte;
+        access_flags = piotlb_entry->access_flags;
+        page_mask = piotlb_entry->mask;
+        goto out;
+    }
+
     ret = vtd_ce_get_rid2pasid_entry(s, &ce, &pe, PCI_NO_PASID);
     is_fpd_set = pe.val[0] & VTD_PASID_ENTRY_FPD;
     if (ret) {
@@ -2108,6 +2199,9 @@ static bool vtd_do_iommu_fl_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     page_mask = vtd_flpt_level_page_mask(level);
     access_flags = IOMMU_ACCESS_FLAG(reads, writes);
 
+    vtd_update_piotlb(s, pasid, vtd_pe_get_domain_id(&pe), addr, flpte,
+                      access_flags, level, source_id);
+out:
     vtd_iommu_unlock(s);
 
     entry->iova = addr & page_mask;
@@ -3080,6 +3174,7 @@ static void vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
     trace_vtd_inv_desc_iotlb_pages(domain_id, addr, am);
 
     assert(am <= VTD_MAMV);
+    info.is_piotlb = false;
     info.domain_id = domain_id;
     info.addr = addr;
     info.mask = ~((1 << am) - 1);
@@ -4063,12 +4158,16 @@ static void vtd_flush_pasid_iotlb(gpointer key, gpointer value,
         vtd_invalidate_piotlb(vtd_pasid_as,
                               piotlb_info->inv_data);
     }
+}
 
-    /*
-     * TODO: needs to add QEMU piotlb flush when QEMU piotlb
-     * infrastructure is ready. For now, it is enough for passthru
-     * devices.
-     */
+static gboolean vtd_hash_remove_by_pasid(gpointer key, gpointer value,
+                                         gpointer user_data)
+{
+    VTDIOTLBEntry *entry = (VTDIOTLBEntry *)value;
+    VTDIOTLBPageInvInfo *info = (VTDIOTLBPageInvInfo *)user_data;
+
+    return ((entry->domain_id == info->domain_id) &&
+            (entry->pasid == info->pasid));
 }
 
 static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
@@ -4076,6 +4175,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
 {
     struct iommu_hwpt_vtd_s1_invalidate cache_info = { 0 };
     VTDPIOTLBInvInfo piotlb_info;
+    VTDIOTLBPageInvInfo info;
 
     cache_info.addr = 0;
     cache_info.npages = (uint64_t)-1;
@@ -4084,6 +4184,9 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
     piotlb_info.pasid = pasid;
     piotlb_info.inv_data = &cache_info;
 
+    info.domain_id = domain_id;
+    info.pasid = pasid;
+
     vtd_iommu_lock(s);
     /*
      * Here loops all the vtd_pasid_as instances in s->vtd_pasid_as
@@ -4092,6 +4195,8 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
      */
     g_hash_table_foreach(s->vtd_pasid_as,
                          vtd_flush_pasid_iotlb, &piotlb_info);
+    g_hash_table_foreach_remove(s->p_iotlb, vtd_hash_remove_by_pasid,
+                                &info);
     vtd_iommu_unlock(s);
 }
 
@@ -4101,6 +4206,7 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
 {
     struct iommu_hwpt_vtd_s1_invalidate cache_info = { 0 };
     VTDPIOTLBInvInfo piotlb_info;
+    VTDIOTLBPageInvInfo info;
 
     cache_info.addr = addr;
     cache_info.npages = 1 << am;
@@ -4110,6 +4216,12 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
     piotlb_info.pasid = pasid;
     piotlb_info.inv_data = &cache_info;
 
+    info.is_piotlb = true;
+    info.domain_id = domain_id;
+    info.pasid = pasid;
+    info.addr = addr;
+    info.mask = ~((1 << am) - 1);
+
     vtd_iommu_lock(s);
     /*
      * Here loops all the vtd_pasid_as instances in s->vtd_pasid_as
@@ -4118,6 +4230,8 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
      */
     g_hash_table_foreach(s->vtd_pasid_as,
                          vtd_flush_pasid_iotlb, &piotlb_info);
+    g_hash_table_foreach_remove(s->p_iotlb,
+                                vtd_hash_remove_by_page, &info);
     vtd_iommu_unlock(s);
 }
 
@@ -6034,6 +6148,8 @@ static void vtd_realize(DeviceState *dev, Error **errp)
     /* No corresponding destroy */
     s->iotlb = g_hash_table_new_full(vtd_iotlb_hash, vtd_iotlb_equal,
                                      g_free, g_free);
+    s->p_iotlb = g_hash_table_new_full(&g_str_hash, &g_str_equal,
+                                       g_free, g_free);
     s->vtd_address_spaces = g_hash_table_new_full(vtd_as_hash, vtd_as_equal,
                                       g_free, g_free);
     s->vtd_iommufd_dev = g_hash_table_new_full(vtd_as_hash, vtd_as_idev_equal,
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 00b27bc5b1..7c36f34ae8 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -31,6 +31,7 @@ vtd_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID slective PC invalida
 vtd_pasid_cache_devsi(uint16_t devfn) "Dev selective PC invalidation dev: 0x%"PRIx16
 vtd_re_not_present(uint8_t bus) "Root entry bus %"PRIu8" not present"
 vtd_ce_not_present(uint8_t bus, uint8_t devfn) "Context entry bus %"PRIu8" devfn %"PRIu8" not present"
+vtd_piotlb_page_hit(uint16_t sid, uint32_t pasid, uint64_t addr, uint64_t pte, uint16_t domain) "PIOTLB page hit sid 0x%"PRIx16" pasid %"PRIu32" iova 0x%"PRIx64" pte 0x%"PRIx64" domain 0x%"PRIx16
 vtd_iotlb_page_hit(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page hit sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16
 vtd_iotlb_page_update(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page update sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16
 vtd_iotlb_pe_hit(uint32_t pasid, uint64_t val0, uint32_t gen) "IOTLB pasid hit pasid %"PRIu32" val[0] 0x%"PRIx64" gen %"PRIu32
-- 
2.34.1


