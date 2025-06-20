Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF45AE14D7
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Jun 2025 09:24:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSW5Y-0004fP-92; Fri, 20 Jun 2025 03:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW5V-0004fB-NH
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:23:01 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW5S-0008IS-W0
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750404179; x=1781940179;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fM8vpJl9hZIM27w/9IgNjuh0cmwQShO0EoXVYcKlQfg=;
 b=GhCouaJhgSnQwTbubpUKrL3csWY+uk2ml6jzRu6w2ng84Et+7wnXtGHI
 VONhjWgEyRj1IQGaNKTuKIFt6j/HyMInXcWt8DR6sP93M8kF89QHdRLYf
 UwzfJ9wnC+MyJxF4PWLI/pplBQBYLcHfeqvlc1xA+VEJoAcyLgg6AoGGK
 5zkwmieW6t7VNROtJL9WdVvFHdtrlnVa7k1HLGFKCtIWtz/nd/TEpKjQm
 UpNsf2yeWg64GOvqKB5tILXVGJtkcY1R9NFtOdwuYjT9ARc+UxtHRYyeU
 QduZHHmpWengMeRk31nUVInc86+2MtRJw3pjZHTSlEuUtNG5LHfSL1J77 g==;
X-CSE-ConnectionGUID: VySAIbX8Ri20xi+IFqCfcw==
X-CSE-MsgGUID: PqjN+6bPRIywSaVes4oDNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52532406"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="52532406"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:22:58 -0700
X-CSE-ConnectionGUID: ibd0fMxvSpuh1pddYRgTRQ==
X-CSE-MsgGUID: FPOBzrp8SgiQIrQZRoXNUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="181863164"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:22:54 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 10/19] intel_iommu: Handle PASID entry removing and updating
Date: Fri, 20 Jun 2025 15:18:04 +0800
Message-Id: <20250620071813.55571-11-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620071813.55571-1-zhenzhong.duan@intel.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This adds an new entry VTDPASIDCacheEntry in VTDAddressSpace to cache the
pasid entry and track PASID usage and future PASID tagged DMA address
translation support in vIOMMU.

VTDAddressSpace of PCI_NO_PASID is allocated when device is plugged and
never freed. For other pasid, VTDAddressSpace instance is created/destroyed
per the guest pasid entry set up/destroy for passthrough devices. While for
emulated devices, VTDAddressSpace instance is created in the PASID tagged DMA
translation and be destroyed per guest PASID cache invalidation. This focuses
on the PASID cache management for passthrough devices as there is no PASID
capable emulated devices yet.

When guest modifies a PASID entry, QEMU will capture the guest pasid selective
pasid cache invalidation, allocate or remove a VTDAddressSpace instance per the
invalidation reasons:

    a) a present pasid entry moved to non-present
    b) a present pasid entry to be a present entry
    c) a non-present pasid entry moved to present

This handles a) and b), following patch will handle c).

vIOMMU emulator could figure out the reason by fetching latest guest pasid entry
and compare it with the PASID cache.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  27 ++++
 include/hw/i386/intel_iommu.h  |   6 +
 hw/i386/intel_iommu.c          | 265 +++++++++++++++++++++++++++++++--
 hw/i386/trace-events           |   3 +
 4 files changed, 291 insertions(+), 10 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 18bc22fc72..01c881ed4d 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -315,6 +315,7 @@ typedef enum VTDFaultReason {
                                   * request while disabled */
     VTD_FR_IR_SID_ERR = 0x26,   /* Invalid Source-ID */
 
+    VTD_FR_RTADDR_INV_TTM = 0x31,  /* Invalid TTM in RTADDR */
     /* PASID directory entry access failure */
     VTD_FR_PASID_DIR_ACCESS_ERR = 0x50,
     /* The Present(P) field of pasid directory entry is 0 */
@@ -492,6 +493,15 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000f1c0ULL
 #define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
 
+#define VTD_INV_DESC_PASIDC_G          (3ULL << 4)
+#define VTD_INV_DESC_PASIDC_PASID(val) (((val) >> 32) & 0xfffffULL)
+#define VTD_INV_DESC_PASIDC_DID(val)   (((val) >> 16) & VTD_DOMAIN_ID_MASK)
+#define VTD_INV_DESC_PASIDC_RSVD_VAL0  0xfff000000000f1c0ULL
+
+#define VTD_INV_DESC_PASIDC_DSI        (0ULL << 4)
+#define VTD_INV_DESC_PASIDC_PASID_SI   (1ULL << 4)
+#define VTD_INV_DESC_PASIDC_GLOBAL     (3ULL << 4)
+
 /* Information about page-selective IOTLB invalidate */
 struct VTDIOTLBPageInvInfo {
     uint16_t domain_id;
@@ -552,6 +562,22 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
 
+typedef enum VTDPCInvType {
+    /* pasid cache invalidation rely on guest PASID entry */
+    VTD_PASID_CACHE_GLOBAL_INV, /* pasid cache global invalidation */
+    VTD_PASID_CACHE_DOMSI,      /* pasid cache domain selective invalidation */
+    VTD_PASID_CACHE_PASIDSI,    /* pasid cache pasid selective invalidation */
+} VTDPCInvType;
+
+typedef struct VTDPASIDCacheInfo {
+    VTDPCInvType type;
+    uint16_t domain_id;
+    uint32_t pasid;
+    PCIBus *bus;
+    uint16_t devfn;
+    bool error_happened;
+} VTDPASIDCacheInfo;
+
 /* PASID Table Related Definitions */
 #define VTD_PASID_DIR_BASE_ADDR_MASK  (~0xfffULL)
 #define VTD_PASID_TABLE_BASE_ADDR_MASK (~0xfffULL)
@@ -563,6 +589,7 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_PASID_TABLE_BITS_MASK     (0x3fULL)
 #define VTD_PASID_TABLE_INDEX(pasid)  ((pasid) & VTD_PASID_TABLE_BITS_MASK)
 #define VTD_PASID_ENTRY_FPD           (1ULL << 1) /* Fault Processing Disable */
+#define VTD_PASID_TBL_ENTRY_NUM       (1ULL << 6)
 
 /* PASID Granular Translation Type Mask */
 #define VTD_PASID_ENTRY_P              1ULL
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 50f9b27a45..fbc9da903a 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -95,6 +95,11 @@ struct VTDPASIDEntry {
     uint64_t val[8];
 };
 
+typedef struct VTDPASIDCacheEntry {
+    struct VTDPASIDEntry pasid_entry;
+    bool cache_filled;
+} VTDPASIDCacheEntry;
+
 struct VTDAddressSpace {
     PCIBus *bus;
     uint8_t devfn;
@@ -107,6 +112,7 @@ struct VTDAddressSpace {
     MemoryRegion iommu_ir_fault; /* Interrupt region for catching fault */
     IntelIOMMUState *iommu_state;
     VTDContextCacheEntry context_cache_entry;
+    VTDPASIDCacheEntry pasid_cache_entry;
     QLIST_ENTRY(VTDAddressSpace) next;
     /* Superset of notifier flags that this address space has */
     IOMMUNotifierFlag notifier_flags;
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 8948b8370f..1db581d14a 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -826,11 +826,24 @@ static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
     }
 }
 
+static inline uint16_t vtd_pe_get_did(VTDPASIDEntry *pe)
+{
+    return VTD_SM_PASID_ENTRY_DID((pe)->val[1]);
+}
+
 static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
 {
     return pdire->val & 1;
 }
 
+static inline void pasid_cache_info_set_error(VTDPASIDCacheInfo *pc_info)
+{
+    if (pc_info->error_happened) {
+        return;
+    }
+    pc_info->error_happened = true;
+}
+
 /**
  * Caller of this function should check present bit if wants
  * to use pdir entry for further usage except for fpd bit check.
@@ -3103,6 +3116,241 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
     return true;
 }
 
+static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
+                                            uint32_t pasid, VTDPASIDEntry *pe)
+{
+    IntelIOMMUState *s = vtd_as->iommu_state;
+    VTDContextEntry ce;
+    int ret;
+
+    if (!s->root_scalable) {
+        return -VTD_FR_RTADDR_INV_TTM;
+    }
+
+    ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus), vtd_as->devfn,
+                                   &ce);
+    if (ret) {
+        return ret;
+    }
+
+    return vtd_ce_get_pasid_entry(s, &ce, pe, pasid);
+}
+
+static bool vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
+{
+    return !memcmp(p1, p2, sizeof(*p1));
+}
+
+/*
+ * This function fills in the pasid entry in &vtd_as. Caller
+ * of this function should hold iommu_lock.
+ */
+static int vtd_fill_pe_in_cache(IntelIOMMUState *s, VTDAddressSpace *vtd_as,
+                                VTDPASIDEntry *pe)
+{
+    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
+
+    if (vtd_pasid_entry_compare(pe, &pc_entry->pasid_entry)) {
+        /* No need to go further as cached pasid entry is latest */
+        return 0;
+    }
+
+    pc_entry->pasid_entry = *pe;
+    pc_entry->cache_filled = true;
+
+    /*
+     * TODO: send pasid bind to host for passthru devices
+     */
+
+    return 0;
+}
+
+/*
+ * This function is used to update or clear cached pasid entry in vtd_as
+ * instances. Caller of this function should hold iommu_lock.
+ */
+static gboolean vtd_flush_pasid(gpointer key, gpointer value,
+                                gpointer user_data)
+{
+    VTDPASIDCacheInfo *pc_info = user_data;
+    VTDAddressSpace *vtd_as = value;
+    IntelIOMMUState *s = vtd_as->iommu_state;
+    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
+    VTDPASIDEntry pe;
+    uint16_t did;
+    uint32_t pasid;
+    int ret;
+
+    if (!pc_entry->cache_filled) {
+        return false;
+    }
+    did = vtd_pe_get_did(&pc_entry->pasid_entry);
+
+    if (vtd_as_to_iommu_pasid_locked(vtd_as, &pasid)) {
+        goto remove;
+    }
+
+    switch (pc_info->type) {
+    case VTD_PASID_CACHE_PASIDSI:
+        if (pc_info->pasid != pasid) {
+            return false;
+        }
+        /* Fall through */
+    case VTD_PASID_CACHE_DOMSI:
+        if (pc_info->domain_id != did) {
+            return false;
+        }
+        /* Fall through */
+    case VTD_PASID_CACHE_GLOBAL_INV:
+        break;
+    default:
+        error_report("invalid pc_info->type");
+        abort();
+    }
+
+    /*
+     * pasid cache invalidation may indicate a present pasid
+     * entry to present pasid entry modification. To cover such
+     * case, vIOMMU emulator needs to fetch latest guest pasid
+     * entry and check cached pasid entry, then update pasid
+     * cache and send pasid bind/unbind to host properly.
+     */
+    ret = vtd_dev_get_pe_from_pasid(vtd_as, pasid, &pe);
+    if (ret) {
+        /*
+         * No valid pasid entry in guest memory. e.g. pasid entry
+         * was modified to be either all-zero or non-present. Either
+         * case means existing pasid cache should be removed.
+         */
+        goto remove;
+    }
+
+    if (vtd_fill_pe_in_cache(s, vtd_as, &pe)) {
+        pasid_cache_info_set_error(pc_info);
+    }
+    return false;
+
+remove:
+    /*
+     * TODO: send pasid unbind to host for passthru devices
+     */
+    pc_entry->cache_filled = false;
+
+    /*
+     * Don't remove address space of PCI_NO_PASID which is created by PCI
+     * sub-system.
+     */
+    if (vtd_as->pasid == PCI_NO_PASID) {
+        return false;
+    }
+    return true;
+}
+
+/*
+ * This function syncs the pasid bindings between guest and host.
+ * It includes updating the pasid cache in vIOMMU and updating the
+ * pasid bindings per guest's latest pasid entry presence.
+ */
+static void vtd_pasid_cache_sync(IntelIOMMUState *s,
+                                 VTDPASIDCacheInfo *pc_info)
+{
+    if (!s->flts || !s->root_scalable || !s->dmar_enabled) {
+        return;
+    }
+
+    /*
+     * Regards to a pasid cache invalidation, e.g. a PSI.
+     * it could be either cases of below:
+     * a) a present pasid entry moved to non-present
+     * b) a present pasid entry to be a present entry
+     * c) a non-present pasid entry moved to present
+     *
+     * Different invalidation granularity may affect different device
+     * scope and pasid scope. But for each invalidation granularity,
+     * it needs to do two steps to sync host and guest pasid binding.
+     *
+     * Here is the handling of a PSI:
+     * 1) loop all the existing vtd_as instances to update them
+     *    according to the latest guest pasid entry in pasid table.
+     *    this will make sure affected existing vtd_as instances
+     *    cached the latest pasid entries. Also, during the loop, the
+     *    host should be notified if needed. e.g. pasid unbind or pasid
+     *    update. Should be able to cover case a) and case b).
+     *
+     * 2) loop all devices to cover case c)
+     *    - For devices which are backed by HostIOMMUDeviceIOMMUFD instances,
+     *      we loop them and check if guest pasid entry exists. If yes,
+     *      it is case c), we update the pasid cache and also notify
+     *      host.
+     *    - For devices which are not backed by HostIOMMUDeviceIOMMUFD,
+     *      it is not necessary to create pasid cache at this phase since
+     *      it could be created when vIOMMU does DMA address translation.
+     *      This is not yet implemented since there is no emulated
+     *      pasid-capable devices today. If we have such devices in
+     *      future, the pasid cache shall be created there.
+     * Other granularity follow the same steps, just with different scope
+     *
+     */
+
+    vtd_iommu_lock(s);
+    /*
+     * Step 1: loop all the existing vtd_as instances for pasid unbind and
+     * update.
+     */
+    g_hash_table_foreach_remove(s->vtd_address_spaces, vtd_flush_pasid,
+                                pc_info);
+    vtd_iommu_unlock(s);
+
+    /* TODO: Step 2: loop all the existing vtd_hiod instances for pasid bind. */
+}
+
+static bool vtd_process_pasid_desc(IntelIOMMUState *s,
+                                   VTDInvDesc *inv_desc)
+{
+    uint16_t domain_id;
+    uint32_t pasid;
+    VTDPASIDCacheInfo pc_info = {};
+    uint64_t mask[4] = {VTD_INV_DESC_PASIDC_RSVD_VAL0, VTD_INV_DESC_ALL_ONE,
+                        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
+
+    if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, true,
+                                     __func__, "pasid cache inv")) {
+        return false;
+    }
+
+    domain_id = VTD_INV_DESC_PASIDC_DID(inv_desc->val[0]);
+    pasid = VTD_INV_DESC_PASIDC_PASID(inv_desc->val[0]);
+
+    switch (inv_desc->val[0] & VTD_INV_DESC_PASIDC_G) {
+    case VTD_INV_DESC_PASIDC_DSI:
+        trace_vtd_pasid_cache_dsi(domain_id);
+        pc_info.type = VTD_PASID_CACHE_DOMSI;
+        pc_info.domain_id = domain_id;
+        break;
+
+    case VTD_INV_DESC_PASIDC_PASID_SI:
+        /* PASID selective implies a DID selective */
+        trace_vtd_pasid_cache_psi(domain_id, pasid);
+        pc_info.type = VTD_PASID_CACHE_PASIDSI;
+        pc_info.domain_id = domain_id;
+        pc_info.pasid = pasid;
+        break;
+
+    case VTD_INV_DESC_PASIDC_GLOBAL:
+        trace_vtd_pasid_cache_gsi();
+        pc_info.type = VTD_PASID_CACHE_GLOBAL_INV;
+        break;
+
+    default:
+        error_report_once("invalid-inv-granu-in-pc_inv_desc hi: 0x%" PRIx64
+                  " lo: 0x%" PRIx64, inv_desc->val[1], inv_desc->val[0]);
+        return false;
+    }
+
+    vtd_pasid_cache_sync(s, &pc_info);
+    return !pc_info.error_happened ? true : false;
+}
+
 static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
                                      VTDInvDesc *inv_desc)
 {
@@ -3264,6 +3512,13 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
         }
         break;
 
+    case VTD_INV_DESC_PC:
+        trace_vtd_inv_desc("pasid-cache", inv_desc.val[1], inv_desc.val[0]);
+        if (!vtd_process_pasid_desc(s, &inv_desc)) {
+            return false;
+        }
+        break;
+
     case VTD_INV_DESC_PIOTLB:
         trace_vtd_inv_desc("p-iotlb", inv_desc.val[1], inv_desc.val[0]);
         if (!vtd_process_piotlb_desc(s, &inv_desc)) {
@@ -3299,16 +3554,6 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
         }
         break;
 
-    /*
-     * TODO: the entity of below two cases will be implemented in future series.
-     * To make guest (which integrates scalable mode support patch set in
-     * iommu driver) work, just return true is enough so far.
-     */
-    case VTD_INV_DESC_PC:
-        if (s->scalable_mode) {
-            break;
-        }
-    /* fallthrough */
     default:
         error_report_once("%s: invalid inv desc: hi=%"PRIx64", lo=%"PRIx64
                           " (unknown type)", __func__, inv_desc.hi,
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index ac9e1a10aa..ae5bbfcdc0 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -24,6 +24,9 @@ vtd_inv_qi_head(uint16_t head) "read head %d"
 vtd_inv_qi_tail(uint16_t head) "write tail %d"
 vtd_inv_qi_fetch(void) ""
 vtd_context_cache_reset(void) ""
+vtd_pasid_cache_gsi(void) ""
+vtd_pasid_cache_dsi(uint16_t domain) "Domain selective PC invalidation domain 0x%"PRIx16
+vtd_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID selective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
 vtd_re_not_present(uint8_t bus) "Root entry bus %"PRIu8" not present"
 vtd_ce_not_present(uint8_t bus, uint8_t devfn) "Context entry bus %"PRIu8" devfn %"PRIu8" not present"
 vtd_iotlb_page_hit(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page hit sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16
-- 
2.34.1


