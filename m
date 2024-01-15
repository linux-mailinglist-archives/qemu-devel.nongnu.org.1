Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B75082D787
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:40:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPKOB-0001P6-UF; Mon, 15 Jan 2024 05:40:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKO5-0001HD-Rx
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:40:14 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKO2-0002kC-Le
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705315211; x=1736851211;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RI8it2Ry8rXjKKnuM5t0zkEXkCaEw++ETOugRQImZ/U=;
 b=Q0vfczzWMjT1V40ax8e9DEKFD9ikEoZRn4MyWA1N53M9qR/DxQ540Op1
 iDoio7gaRvYtoG8aH/Ik7KofiCe2vfJZtI8mlvqEE5h72wYoVHddpOdCM
 ZnlKYoI7TqMiP7QR5cJx3KlHBPggEJ9bXh+BMajB7AyhsNEKJC+3lk1Yj
 n1RVnLsx2Rbd83dumjvlM6C5LERpNq9OuODyFGXf1qyBzv5zYDZ7NCAUi
 7B3DV9rlE+ibP/jAhIUKo6JqsCkt6cyc0tC3goh6EvH5KAAw/KPotV+yo
 Wam/AW1mpvVqMMlnnke6xPnVxyWiC1syJ/IShog6a20QDBFEggahpqweX w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="13067650"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="13067650"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:40:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="874065345"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="874065345"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:40:04 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH rfcv1 08/23] intel_iommu: add PASID cache management
 infrastructure
Date: Mon, 15 Jan 2024 18:37:20 +0800
Message-Id: <20240115103735.132209-9-zhenzhong.duan@intel.com>
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

This adds a PASID cache management infrastructure based on
new added structure VTDPASIDAddressSpace, which is used to track
the PASID usage and future PASID tagged DMA address translation
support in vIOMMU.

    struct VTDPASIDAddressSpace {
        PCIBus *bus;
        uint8_t devfn;
        AddressSpace as;
        uint32_t pasid;
        IntelIOMMUState *iommu_state;
        VTDContextCacheEntry context_cache_entry;
        QLIST_ENTRY(VTDPASIDAddressSpace) next;
        VTDPASIDCacheEntry pasid_cache_entry;
    };

The implementation manages VTDPASIDAddressSpace instances per
PASID+BDF (lookup and insert will use PASID and BDF) since
Intel VT-d spec allows per-BDF PASID Table.

A VTDPASIDAddressSpace instance is created/destroyed per the guest
pasid entry set up/destroy for passthrough devices. While for emulated
devices, VTDPASIDAddressSpace instance is created in the PASID tagged
DMA translation and be destroyed per guest PASID cache invalidation.
This focuses on the PASID cache management for passthrough devices
as there is no PASID-capable emulated devices yet.

When guest modifies a PASID entry, QEMU will capture the guest
pasid selective pasid cache invalidation, allocate or remove
a VTDPASIDAddressSpace instance per the invalidation reasons:

    *) a present pasid entry moved to non-present
    *) a present pasid entry to be a present entry
    *) a non-present pasid entry moved to present

vIOMMU emulator could figure out the reason by fetching latest
guest pasid entry and compare it with the PASID cache.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  21 ++
 include/hw/i386/intel_iommu.h  |  26 ++
 hw/i386/intel_iommu.c          | 468 +++++++++++++++++++++++++++++++++
 hw/i386/trace-events           |   1 +
 4 files changed, 516 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 10117e2f25..16dc712e94 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -325,6 +325,7 @@ typedef enum VTDFaultReason {
     VTD_FR_IR_SID_ERR = 0x26,   /* Invalid Source-ID */
 
     VTD_FR_PASID_TABLE_INV = 0x58,  /*Invalid PASID table entry */
+    VTD_FR_PASID_ENTRY_P = 0x59, /* The Present(P) field of pasidt-entry is 0 */
 
     /* Output address in the interrupt address range for scalable mode */
     VTD_FR_SM_INTERRUPT_ADDR = 0x87,
@@ -512,10 +513,29 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_CTX_ENTRY_LEGACY_SIZE     16
 #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
 
+#define VTD_SM_CONTEXT_ENTRY_PDTS(val)      (((val) >> 9) & 0x7)
 #define VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK 0xfffff
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
 
+typedef enum VTDPCInvType {
+    /* force reset all */
+    VTD_PASID_CACHE_FORCE_RESET = 0,
+    /* pasid cache invalidation rely on guest PASID entry */
+    VTD_PASID_CACHE_GLOBAL_INV,
+    VTD_PASID_CACHE_DOMSI,
+    VTD_PASID_CACHE_PASIDSI,
+} VTDPCInvType;
+
+struct VTDPASIDCacheInfo {
+    VTDPCInvType type;
+    uint16_t domain_id;
+    uint32_t pasid;
+    PCIBus *bus;
+    uint16_t devfn;
+};
+typedef struct VTDPASIDCacheInfo VTDPASIDCacheInfo;
+
 /* PASID Table Related Definitions */
 #define VTD_PASID_DIR_BASE_ADDR_MASK  (~0xfffULL)
 #define VTD_PASID_TABLE_BASE_ADDR_MASK (~0xfffULL)
@@ -527,6 +547,7 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_PASID_TABLE_BITS_MASK     (0x3fULL)
 #define VTD_PASID_TABLE_INDEX(pasid)  ((pasid) & VTD_PASID_TABLE_BITS_MASK)
 #define VTD_PASID_ENTRY_FPD           (1ULL << 1) /* Fault Processing Disable */
+#define VTD_PASID_TBL_ENTRY_NUM       (1ULL << 6)
 
 /* PASID Granular Translation Type Mask */
 #define VTD_PASID_ENTRY_P              1ULL
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 006cec116b..c7b707a3d5 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -63,6 +63,8 @@ typedef union VTD_IR_MSIAddress VTD_IR_MSIAddress;
 typedef struct VTDPASIDDirEntry VTDPASIDDirEntry;
 typedef struct VTDPASIDEntry VTDPASIDEntry;
 typedef struct VTDIOMMUFDDevice VTDIOMMUFDDevice;
+typedef struct VTDPASIDCacheEntry VTDPASIDCacheEntry;
+typedef struct VTDPASIDAddressSpace VTDPASIDAddressSpace;
 
 /* Context-Entry */
 struct VTDContextEntry {
@@ -95,6 +97,25 @@ struct VTDPASIDEntry {
     uint64_t val[8];
 };
 
+struct pasid_key {
+    uint32_t pasid;
+    uint16_t sid;
+};
+
+struct VTDPASIDCacheEntry {
+    struct VTDPASIDEntry pasid_entry;
+};
+
+struct VTDPASIDAddressSpace {
+    PCIBus *bus;
+    uint8_t devfn;
+    uint32_t pasid;
+    IntelIOMMUState *iommu_state;
+    VTDContextCacheEntry context_cache_entry;
+    QLIST_ENTRY(VTDPASIDAddressSpace) next;
+    VTDPASIDCacheEntry pasid_cache_entry;
+};
+
 struct VTDAddressSpace {
     PCIBus *bus;
     uint8_t devfn;
@@ -154,6 +175,7 @@ struct VTDIOMMUFDDevice {
     uint8_t devfn;
     IOMMUFDDevice *idev;
     IntelIOMMUState *iommu_state;
+    QLIST_ENTRY(VTDIOMMUFDDevice) next;
 };
 
 struct VTDIOTLBEntry {
@@ -301,9 +323,13 @@ struct IntelIOMMUState {
 
     GHashTable *vtd_address_spaces;             /* VTD address spaces */
     VTDAddressSpace *vtd_as_cache[VTD_PCI_BUS_MAX]; /* VTD address space cache */
+    GHashTable *vtd_pasid_as;       /* VTDPASIDAddressSpace instances */
     /* list of registered notifiers */
     QLIST_HEAD(, VTDAddressSpace) vtd_as_with_notifiers;
 
+    /* list of VTDIOMMUFDDevices */
+    QLIST_HEAD(, VTDIOMMUFDDevice) vtd_idev_list;
+
     GHashTable *vtd_iommufd_dev;             /* VTDIOMMUFDDevice */
 
     /* interrupt remapping */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index effbeed8a3..a1a1f23246 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -39,6 +39,7 @@
 #include "kvm/kvm_i386.h"
 #include "migration/vmstate.h"
 #include "trace.h"
+#include "qemu/jhash.h"
 
 /* context entry operations */
 #define VTD_CE_GET_RID2PASID(ce) \
@@ -71,6 +72,8 @@ struct vtd_iotlb_key {
 static void vtd_address_space_refresh_all(IntelIOMMUState *s);
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
 
+static void vtd_pasid_cache_reset(IntelIOMMUState *s);
+
 static void vtd_panic_require_caching_mode(void)
 {
     error_report("We need to set caching-mode=on for intel-iommu to enable "
@@ -326,6 +329,7 @@ static void vtd_reset_caches(IntelIOMMUState *s)
     vtd_iommu_lock(s);
     vtd_reset_iotlb_locked(s);
     vtd_reset_context_cache_locked(s);
+    vtd_pasid_cache_reset(s);
     vtd_iommu_unlock(s);
 }
 
@@ -757,6 +761,16 @@ static inline bool vtd_pe_type_check(X86IOMMUState *x86_iommu,
     return true;
 }
 
+static inline uint16_t vtd_pe_get_domain_id(VTDPASIDEntry *pe)
+{
+    return VTD_SM_PASID_ENTRY_DID((pe)->val[1]);
+}
+
+static inline uint32_t vtd_sm_ce_get_pdt_entry_num(VTDContextEntry *ce)
+{
+    return 1U << (VTD_SM_CONTEXT_ENTRY_PDTS(ce->val[0]) + 7);
+}
+
 static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
 {
     return pdire->val & 1;
@@ -2635,9 +2649,443 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
     return true;
 }
 
+static inline void vtd_init_pasid_key(uint32_t pasid,
+                                     uint16_t sid,
+                                     struct pasid_key *key)
+{
+    key->pasid = pasid;
+    key->sid = sid;
+}
+
+static guint vtd_pasid_as_key_hash(gconstpointer v)
+{
+    struct pasid_key *key = (struct pasid_key *)v;
+    uint32_t a, b, c;
+
+    /* Jenkins hash */
+    a = b = c = JHASH_INITVAL + sizeof(*key);
+    a += key->sid;
+    b += extract32(key->pasid, 0, 16);
+    c += extract32(key->pasid, 16, 16);
+
+    __jhash_mix(a, b, c);
+    __jhash_final(a, b, c);
+
+    return c;
+}
+
+static gboolean vtd_pasid_as_key_equal(gconstpointer v1, gconstpointer v2)
+{
+    const struct pasid_key *k1 = v1;
+    const struct pasid_key *k2 = v2;
+
+    return (k1->pasid == k2->pasid) && (k1->sid == k2->sid);
+}
+
+static inline int vtd_dev_get_pe_from_pasid(IntelIOMMUState *s,
+                                            uint8_t bus_num,
+                                            uint8_t devfn,
+                                            uint32_t pasid,
+                                            VTDPASIDEntry *pe)
+{
+    VTDContextEntry ce;
+    int ret;
+    dma_addr_t pasid_dir_base;
+
+    if (!s->root_scalable) {
+        return -VTD_FR_PASID_TABLE_INV;
+    }
+
+    ret = vtd_dev_to_context_entry(s, bus_num, devfn, &ce);
+    if (ret) {
+        return ret;
+    }
+
+    pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(&ce);
+    ret = vtd_get_pe_from_pasid_table(s,
+                                  pasid_dir_base, pasid, pe);
+
+    return ret;
+}
+
+static bool vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
+{
+    return !memcmp(p1, p2, sizeof(*p1));
+}
+
+/*
+ * This function fills in the pasid entry in &vtd_pasid_as. Caller
+ * of this function should hold iommu_lock.
+ */
+static void vtd_fill_pe_in_cache(IntelIOMMUState *s,
+                                 VTDPASIDAddressSpace *vtd_pasid_as,
+                                 VTDPASIDEntry *pe)
+{
+    VTDPASIDCacheEntry *pc_entry = &vtd_pasid_as->pasid_cache_entry;
+
+    if (vtd_pasid_entry_compare(pe, &pc_entry->pasid_entry)) {
+        /* No need to go further as cached pasid entry is latest */
+        return;
+    }
+
+    pc_entry->pasid_entry = *pe;
+    /*
+     * TODO:
+     * - send pasid bind to host for passthru devices
+     */
+}
+
+/*
+ * This function is used to clear cached pasid entry in vtd_pasid_as
+ * instances. Caller of this function should hold iommu_lock.
+ */
+static gboolean vtd_flush_pasid(gpointer key, gpointer value,
+                                gpointer user_data)
+{
+    VTDPASIDCacheInfo *pc_info = user_data;
+    VTDPASIDAddressSpace *vtd_pasid_as = value;
+    IntelIOMMUState *s = vtd_pasid_as->iommu_state;
+    VTDPASIDCacheEntry *pc_entry = &vtd_pasid_as->pasid_cache_entry;
+    PCIBus *bus = vtd_pasid_as->bus;
+    VTDPASIDEntry pe;
+    uint16_t did;
+    uint32_t pasid;
+    uint16_t devfn;
+    int ret;
+
+    did = vtd_pe_get_domain_id(&pc_entry->pasid_entry);
+    pasid = vtd_pasid_as->pasid;
+    devfn = vtd_pasid_as->devfn;
+
+    switch (pc_info->type) {
+    case VTD_PASID_CACHE_FORCE_RESET:
+        goto remove;
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
+    ret = vtd_dev_get_pe_from_pasid(s, pci_bus_num(bus),
+                                    devfn, pasid, &pe);
+    if (ret) {
+        /*
+         * No valid pasid entry in guest memory. e.g. pasid entry
+         * was modified to be either all-zero or non-present. Either
+         * case means existing pasid cache should be removed.
+         */
+        goto remove;
+    }
+
+    vtd_fill_pe_in_cache(s, vtd_pasid_as, &pe);
+    /*
+     * TODO:
+     * - when pasid-base-iotlb(piotlb) infrastructure is ready,
+     *   should invalidate QEMU piotlb togehter with this change.
+     */
+    return false;
+remove:
+    /*
+     * TODO:
+     * - send pasid bind to host for passthru devices
+     * - when pasid-base-iotlb(piotlb) infrastructure is ready,
+     *   should invalidate QEMU piotlb togehter with this change.
+     */
+    return true;
+}
+
+/*
+ * This function finds or adds a VTDPASIDAddressSpace for a device
+ * when it is bound to a pasid. Caller of this function should hold
+ * iommu_lock.
+ */
+static VTDPASIDAddressSpace *vtd_add_find_pasid_as(IntelIOMMUState *s,
+                                                   PCIBus *bus,
+                                                   int devfn,
+                                                   uint32_t pasid)
+{
+    struct pasid_key key;
+    struct pasid_key *new_key;
+    VTDPASIDAddressSpace *vtd_pasid_as;
+    uint16_t sid;
+
+    sid = PCI_BUILD_BDF(pci_bus_num(bus), devfn);
+    vtd_init_pasid_key(pasid, sid, &key);
+    vtd_pasid_as = g_hash_table_lookup(s->vtd_pasid_as, &key);
+
+    if (!vtd_pasid_as) {
+        new_key = g_malloc0(sizeof(*new_key));
+        vtd_init_pasid_key(pasid, sid, new_key);
+        /*
+         * Initiate the vtd_pasid_as structure.
+         *
+         * This structure here is used to track the guest pasid
+         * binding and also serves as pasid-cache mangement entry.
+         *
+         * TODO: in future, if wants to support the SVA-aware DMA
+         *       emulation, the vtd_pasid_as should have include
+         *       AddressSpace to support DMA emulation.
+         */
+        vtd_pasid_as = g_malloc0(sizeof(VTDPASIDAddressSpace));
+        vtd_pasid_as->iommu_state = s;
+        vtd_pasid_as->bus = bus;
+        vtd_pasid_as->devfn = devfn;
+        vtd_pasid_as->pasid = pasid;
+        g_hash_table_insert(s->vtd_pasid_as, new_key, vtd_pasid_as);
+    }
+    return vtd_pasid_as;
+}
+
+/* Caller of this function should hold iommu_lock. */
+static void vtd_sm_pasid_table_walk_one(IntelIOMMUState *s,
+                                        dma_addr_t pt_base,
+                                        int start,
+                                        int end,
+                                        VTDPASIDCacheInfo *info)
+{
+    VTDPASIDEntry pe;
+    int pasid = start;
+    int pasid_next;
+    VTDPASIDAddressSpace *vtd_pasid_as;
+
+    while (pasid < end) {
+        pasid_next = pasid + 1;
+
+        if (!vtd_get_pe_in_pasid_leaf_table(s, pasid, pt_base, &pe)
+            && vtd_pe_present(&pe)) {
+            vtd_pasid_as = vtd_add_find_pasid_as(s,
+                                       info->bus, info->devfn, pasid);
+            if ((info->type == VTD_PASID_CACHE_DOMSI ||
+                 info->type == VTD_PASID_CACHE_PASIDSI) &&
+                !(info->domain_id == vtd_pe_get_domain_id(&pe))) {
+                /*
+                 * VTD_PASID_CACHE_DOMSI and VTD_PASID_CACHE_PASIDSI
+                 * requires domain ID check. If domain Id check fail,
+                 * go to next pasid.
+                 */
+                pasid = pasid_next;
+                continue;
+            }
+            vtd_fill_pe_in_cache(s, vtd_pasid_as, &pe);
+        }
+        pasid = pasid_next;
+    }
+}
+
+/*
+ * Currently, VT-d scalable mode pasid table is a two level table,
+ * this function aims to loop a range of PASIDs in a given pasid
+ * table to identify the pasid config in guest.
+ * Caller of this function should hold iommu_lock.
+ */
+static void vtd_sm_pasid_table_walk(IntelIOMMUState *s,
+                                    dma_addr_t pdt_base,
+                                    int start,
+                                    int end,
+                                    VTDPASIDCacheInfo *info)
+{
+    VTDPASIDDirEntry pdire;
+    int pasid = start;
+    int pasid_next;
+    dma_addr_t pt_base;
+
+    while (pasid < end) {
+        pasid_next = ((end - pasid) > VTD_PASID_TBL_ENTRY_NUM) ?
+                      (pasid + VTD_PASID_TBL_ENTRY_NUM) : end;
+        if (!vtd_get_pdire_from_pdir_table(pdt_base, pasid, &pdire)
+            && vtd_pdire_present(&pdire)) {
+            pt_base = pdire.val & VTD_PASID_TABLE_BASE_ADDR_MASK;
+            vtd_sm_pasid_table_walk_one(s, pt_base, pasid, pasid_next, info);
+        }
+        pasid = pasid_next;
+    }
+}
+
+static void vtd_replay_pasid_bind_for_dev(IntelIOMMUState *s,
+                                          int start, int end,
+                                          VTDPASIDCacheInfo *info)
+{
+    VTDContextEntry ce;
+    int bus_n, devfn;
+
+    bus_n = pci_bus_num(info->bus);
+    devfn = info->devfn;
+
+    if (!vtd_dev_to_context_entry(s, bus_n, devfn, &ce)) {
+        uint32_t max_pasid;
+
+        max_pasid = vtd_sm_ce_get_pdt_entry_num(&ce) * VTD_PASID_TBL_ENTRY_NUM;
+        if (end > max_pasid) {
+            end = max_pasid;
+        }
+        vtd_sm_pasid_table_walk(s,
+                                VTD_CE_GET_PASID_DIR_TABLE(&ce),
+                                start,
+                                end,
+                                info);
+    }
+}
+
+/*
+ * This function replay the guest pasid bindings to hots by
+ * walking the guest PASID table. This ensures host will have
+ * latest guest pasid bindings. Caller should hold iommu_lock.
+ */
+static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
+                                            VTDPASIDCacheInfo *pc_info)
+{
+    VTDIOMMUFDDevice *vtd_idev;
+    int start = 0, end = 1; /* only rid2pasid is supported */
+    VTDPASIDCacheInfo walk_info;
+
+    switch (pc_info->type) {
+    case VTD_PASID_CACHE_PASIDSI:
+        start = pc_info->pasid;
+        end = pc_info->pasid + 1;
+        /*
+         * PASID selective invalidation is within domain,
+         * thus fall through.
+         */
+    case VTD_PASID_CACHE_DOMSI:
+    case VTD_PASID_CACHE_GLOBAL_INV:
+        /* loop all assigned devices */
+        break;
+    case VTD_PASID_CACHE_FORCE_RESET:
+        /* For force reset, no need to go further replay */
+        return;
+    default:
+        error_report("invalid pc_info->type for replay");
+        abort();
+    }
+
+    /*
+     * In this replay, only needs to care about the devices which
+     * are backed by host IOMMU. For such devices, their vtd_idev
+     * instances are in the s->vtd_idev_list. For devices which
+     * are not backed byhost IOMMU, it is not necessary to replay
+     * the bindings since their cache could be re-created in the future
+     * DMA address transaltion.
+     */
+    walk_info = *pc_info;
+    QLIST_FOREACH(vtd_idev, &s->vtd_idev_list, next) {
+        /* bus|devfn fields are not identical with pc_info */
+        walk_info.bus = vtd_idev->bus;
+        walk_info.devfn = vtd_idev->devfn;
+        vtd_replay_pasid_bind_for_dev(s, start, end, &walk_info);
+    }
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
+    if (!s->scalable_modern || !s->root_scalable || !s->dmar_enabled) {
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
+     * 1) loop all the existing vtd_pasid_as instances to update them
+     *    according to the latest guest pasid entry in pasid table.
+     *    this will make sure affected existing vtd_pasid_as instances
+     *    cached the latest pasid entries. Also, during the loop, the
+     *    host should be notified if needed. e.g. pasid unbind or pasid
+     *    update. Should be able to cover case a) and case b).
+     *
+     * 2) loop all devices to cover case c)
+     *    - For devices which have IOMMUFDDevice instances,
+     *      we loop them and check if guest pasid entry exists. If yes,
+     *      it is case c), we update the pasid cache and also notify
+     *      host.
+     *    - For devices which have no IOMMUFDDevice, it is not
+     *      necessary to create pasid cache at this phase since it
+     *      could be created when vIOMMU does DMA address translation.
+     *      This is not yet implemented since there is no emulated
+     *      pasid-capable devices today. If we have such devices in
+     *      future, the pasid cache shall be created there.
+     * Other granularity follow the same steps, just with different scope
+     *
+     */
+
+    vtd_iommu_lock(s);
+    /* Step 1: loop all the exisitng vtd_pasid_as instances */
+    g_hash_table_foreach_remove(s->vtd_pasid_as,
+                                vtd_flush_pasid, pc_info);
+
+    /*
+     * Step 2: loop all the exisitng vtd_idev instances.
+     * Ideally, needs to loop all devices to find if there is any new
+     * PASID binding regards to the PASID cache invalidation request.
+     * But it is enough to loop the devices which are backed by host
+     * IOMMU. For devices backed by vIOMMU (a.k.a emulated devices),
+     * if new PASID happened on them, their vtd_pasid_as instance could
+     * be created during future vIOMMU DMA translation.
+     */
+    vtd_replay_guest_pasid_bindings(s, pc_info);
+    vtd_iommu_unlock(s);
+}
+
+/* Caller of this function should hold iommu_lock */
+static void vtd_pasid_cache_reset(IntelIOMMUState *s)
+{
+    VTDPASIDCacheInfo pc_info;
+
+    trace_vtd_pasid_cache_reset();
+
+    pc_info.type = VTD_PASID_CACHE_FORCE_RESET;
+
+    /*
+     * Reset pasid cache is a big hammer, so use
+     * g_hash_table_foreach_remove which will free
+     * the vtd_pasid_as instances. Also, as a big
+     * hammer, use VTD_PASID_CACHE_FORCE_RESET to
+     * ensure all the vtd_pasid_as instances are
+     * dropped, meanwhile the change will be pass
+     * to host if IOMMUFDDevice is available.
+     */
+    g_hash_table_foreach_remove(s->vtd_pasid_as,
+                                vtd_flush_pasid, &pc_info);
+}
+
 static bool vtd_process_pasid_desc(IntelIOMMUState *s,
                                    VTDInvDesc *inv_desc)
 {
+    uint16_t domain_id;
+    uint32_t pasid;
+    VTDPASIDCacheInfo pc_info;
+
     if ((inv_desc->val[0] & VTD_INV_DESC_PASIDC_RSVD_VAL0) ||
         (inv_desc->val[1] & VTD_INV_DESC_PASIDC_RSVD_VAL1) ||
         (inv_desc->val[2] & VTD_INV_DESC_PASIDC_RSVD_VAL2) ||
@@ -2647,14 +3095,27 @@ static bool vtd_process_pasid_desc(IntelIOMMUState *s,
         return false;
     }
 
+    domain_id = VTD_INV_DESC_PASIDC_DID(inv_desc->val[0]);
+    pasid = VTD_INV_DESC_PASIDC_PASID(inv_desc->val[0]);
+
     switch (inv_desc->val[0] & VTD_INV_DESC_PASIDC_G) {
     case VTD_INV_DESC_PASIDC_DSI:
+        trace_vtd_pasid_cache_dsi(domain_id);
+        pc_info.type = VTD_PASID_CACHE_DOMSI;
+        pc_info.domain_id = domain_id;
         break;
 
     case VTD_INV_DESC_PASIDC_PASID_SI:
+        /* PASID selective implies a DID selective */
+        trace_vtd_pasid_cache_psi(domain_id, pasid);
+        pc_info.type = VTD_PASID_CACHE_PASIDSI;
+        pc_info.domain_id = domain_id;
+        pc_info.pasid = pasid;
         break;
 
     case VTD_INV_DESC_PASIDC_GLOBAL:
+        trace_vtd_pasid_cache_gsi();
+        pc_info.type = VTD_PASID_CACHE_GLOBAL_INV;
         break;
 
     default:
@@ -2663,6 +3124,7 @@ static bool vtd_process_pasid_desc(IntelIOMMUState *s,
         return false;
     }
 
+    vtd_pasid_cache_sync(s, &pc_info);
     return true;
 }
 
@@ -3997,6 +4459,7 @@ static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int32_t devfn,
     vtd_idev->devfn = (uint8_t)devfn;
     vtd_idev->iommu_state = s;
     vtd_idev->idev = idev;
+    QLIST_INSERT_HEAD(&s->vtd_idev_list, vtd_idev, next);
 
     g_hash_table_insert(s->vtd_iommufd_dev, new_key, vtd_idev);
 
@@ -4024,6 +4487,7 @@ static void vtd_dev_unset_iommu_device(PCIBus *bus, void *opaque, int32_t devfn)
         return;
     }
 
+    QLIST_REMOVE(vtd_idev, next);
     g_hash_table_remove(s->vtd_iommufd_dev, &key);
 
     vtd_iommu_unlock(s);
@@ -4460,6 +4924,7 @@ static void vtd_realize(DeviceState *dev, Error **errp)
     }
 
     QLIST_INIT(&s->vtd_as_with_notifiers);
+    QLIST_INIT(&s->vtd_idev_list);
     qemu_mutex_init(&s->iommu_lock);
     s->cap_finalized = false;
     memory_region_init_io(&s->csrmem, OBJECT(s), &vtd_mem_ops, s,
@@ -4487,6 +4952,9 @@ static void vtd_realize(DeviceState *dev, Error **errp)
                                       g_free, g_free);
     s->vtd_iommufd_dev = g_hash_table_new_full(vtd_as_hash, vtd_as_idev_equal,
                                                g_free, g_free);
+    s->vtd_pasid_as = g_hash_table_new_full(vtd_pasid_as_key_hash,
+                                            vtd_pasid_as_key_equal,
+                                            g_free, g_free);
     vtd_init(s);
     pci_setup_iommu(bus, &vtd_iommu_ops, dev);
     /* Pseudo address space under root PCI bus. */
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index e54799ee82..91d6c400b4 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -25,6 +25,7 @@ vtd_inv_qi_tail(uint16_t head) "write tail %d"
 vtd_inv_qi_fetch(void) ""
 vtd_context_cache_reset(void) ""
 vtd_pasid_cache_gsi(void) ""
+vtd_pasid_cache_reset(void) ""
 vtd_pasid_cache_dsi(uint16_t domain) "Domian slective PC invalidation domain 0x%"PRIx16
 vtd_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID slective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
 vtd_re_not_present(uint8_t bus) "Root entry bus %"PRIu8" not present"
-- 
2.34.1


