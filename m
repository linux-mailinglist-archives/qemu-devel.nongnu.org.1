Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE64682D797
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:42:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPKOU-0001mg-BR; Mon, 15 Jan 2024 05:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKOH-0001ic-SF
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:40:28 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKOC-0002kC-Fz
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:40:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705315220; x=1736851220;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=F+vI2gnZC8OhgKuPwXC7M/r937Pf3KWSvF9lwExyz+o=;
 b=LM5xUpi/qjrODbYu1ZKc6vya/XAVGOa0ph64ABDkRfJ0NuOl5GPt3nZP
 EE1WrWRRDNR0nAIN+Vpl6B4ZjRDb0iNQ4zi8+b38QKMRc4La2JYoNHS7p
 OjNEj7ozMV5wzNuofl+/rJg5FuNE+0JF+dNikp6rSnWW/QzcsKuv2DQ94
 2CGb/141SDUbmwBfTywJISZ731eHogqwoFqeXg0HG63nU1F5tE+GyBt2L
 Z5pXV8qpwkXt1iXOGvPMlGb3Uy4NiMZUrhAaa04vgEWiP00VREZm6v/sC
 tarvj3cr1CXf8Krc5vOMvTPbWbJyKqRnu/CdajuMvH50yQgTlegeOuA3l Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="13067689"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="13067689"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:40:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="874065353"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="874065353"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:40:13 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH rfcv1 10/23] intel_iommu: bind/unbind guest page table to host
Date: Mon, 15 Jan 2024 18:37:22 +0800
Message-Id: <20240115103735.132209-11-zhenzhong.duan@intel.com>
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

This captures the guest PASID table entry modifications and
propagates the changes to host to attach a hwpt with type determined
per guest PGTT configuration.

When PGTT is Pass-through(100b), the hwpt on host side is a stage-2
page table(GPA->HPA). When PGTT is First-stage Translation only(001b),
the hwpt on host side is a nested page table.

The guest page table is configured as stage-1 page table (gIOVA->GPA)
whose translation result would further go through host VT-d stage-2
page table(GPA->HPA) under nested translation mode. This is the key
to support gIOVA over stage-1 page table for Intel VT-d in
virtualization environment.

Stage-2 page table could be shared by different devices if there is
no conflict and devices link to same iommufd object, i.e. devices
under same host IOMMU can share same stage-2 page table. If there
is conflict, i.e. there is one device under non cache coherency
mode which is different from others, it requires a separate
stage-2 page table in non-CC mode.

See below example diagram:

      IntelIOMMUState
             |
             V
    .------------------.    .------------------.
    | VTDIOASContainer |--->| VTDIOASContainer |--->...
    |    (iommufd0)    |    |    (iommufd1)    |
    .------------------.    .------------------.
             |                       |
             |                       .-->...
             V
      .-------------------.    .-------------------.
      |   VTDS2Hwpt(CC)   |--->| VTDS2Hwpt(non-CC) |-->...
      .-------------------.    .-------------------.
          |            |               |
          |            |               |
    .-----------.  .-----------.  .------------.
    | IOMMUFD   |  | IOMMUFD   |  | IOMMUFD    |
    | Device(CC)|  | Device(CC)|  | Device     |
    | (iommufd0)|  | (iommufd0)|  | (non-CC)   |
    |           |  |           |  | (iommufd0) |
    .-----------.  .-----------.  .------------.

Co-Authored-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  16 +
 include/hw/i386/intel_iommu.h  |  30 ++
 hw/i386/intel_iommu.c          | 641 ++++++++++++++++++++++++++++++++-
 hw/i386/trace-events           |   8 +
 4 files changed, 677 insertions(+), 18 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 16dc712e94..e33c9f54b5 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -199,6 +199,7 @@
 #define VTD_ECAP_SMTS               (1ULL << 43)
 #define VTD_ECAP_SLTS               (1ULL << 46)
 #define VTD_ECAP_FLTS               (1ULL << 47)
+#define VTD_ECAP_RPS                (1ULL << 49)
 
 #define VTD_ECAP_MASK               (VTD_ECAP_SRS | VTD_ECAP_EAFS)
 #define VTD_GET_PSS(val)            (((val) >> 35) & 0x1f)
@@ -518,6 +519,14 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
 
+enum VTDPASIDOp {
+    VTD_PASID_BIND,
+    VTD_PASID_UPDATE,
+    VTD_PASID_UNBIND,
+    VTD_OP_NUM
+};
+typedef enum VTDPASIDOp VTDPASIDOp;
+
 typedef enum VTDPCInvType {
     /* force reset all */
     VTD_PASID_CACHE_FORCE_RESET = 0,
@@ -533,6 +542,7 @@ struct VTDPASIDCacheInfo {
     uint32_t pasid;
     PCIBus *bus;
     uint16_t devfn;
+    bool error_happened;
 };
 typedef struct VTDPASIDCacheInfo VTDPASIDCacheInfo;
 
@@ -560,6 +570,12 @@ typedef struct VTDPASIDCacheInfo VTDPASIDCacheInfo;
 #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
 #define VTD_SM_PASID_ENTRY_DID(val)    ((val) & VTD_DOMAIN_ID_MASK)
 
+#define VTD_SM_PASID_ENTRY_FLPM          3ULL
+#define VTD_SM_PASID_ENTRY_FLPTPTR       (~0xfffULL)
+#define VTD_SM_PASID_ENTRY_SRE_BIT(val)  (!!((val) & 1ULL))
+#define VTD_SM_PASID_ENTRY_WPE_BIT(val)  (!!(((val) >> 4) & 1ULL))
+#define VTD_SM_PASID_ENTRY_EAFE_BIT(val) (!!(((val) >> 7) & 1ULL))
+
 /* Second Level Page Translation Pointer*/
 #define VTD_SM_PASID_ENTRY_SLPTPTR     (~0xfffULL)
 
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index c7b707a3d5..d3122cf699 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -65,6 +65,9 @@ typedef struct VTDPASIDEntry VTDPASIDEntry;
 typedef struct VTDIOMMUFDDevice VTDIOMMUFDDevice;
 typedef struct VTDPASIDCacheEntry VTDPASIDCacheEntry;
 typedef struct VTDPASIDAddressSpace VTDPASIDAddressSpace;
+typedef struct VTDHwpt VTDHwpt;
+typedef struct VTDIOASContainer VTDIOASContainer;
+typedef struct VTDS2Hwpt VTDS2Hwpt;
 
 /* Context-Entry */
 struct VTDContextEntry {
@@ -102,14 +105,37 @@ struct pasid_key {
     uint16_t sid;
 };
 
+struct VTDIOASContainer {
+    IOMMUFDBackend *iommufd;
+    uint32_t ioas_id;
+    MemoryListener listener;
+    QLIST_HEAD(, VTDS2Hwpt) s2_hwpt_list;
+    QLIST_ENTRY(VTDIOASContainer) next;
+    Error *error;
+};
+
+struct VTDS2Hwpt {
+    uint32_t users;
+    uint32_t hwpt_id;
+    VTDIOASContainer *container;
+    QLIST_ENTRY(VTDS2Hwpt) next;
+};
+
+struct VTDHwpt {
+    uint32_t hwpt_id;
+    VTDS2Hwpt *s2_hwpt;
+};
+
 struct VTDPASIDCacheEntry {
     struct VTDPASIDEntry pasid_entry;
+    bool cache_filled;
 };
 
 struct VTDPASIDAddressSpace {
     PCIBus *bus;
     uint8_t devfn;
     uint32_t pasid;
+    VTDHwpt hwpt;
     IntelIOMMUState *iommu_state;
     VTDContextCacheEntry context_cache_entry;
     QLIST_ENTRY(VTDPASIDAddressSpace) next;
@@ -330,8 +356,12 @@ struct IntelIOMMUState {
     /* list of VTDIOMMUFDDevices */
     QLIST_HEAD(, VTDIOMMUFDDevice) vtd_idev_list;
 
+    QLIST_HEAD(, VTDIOASContainer) containers;
+
     GHashTable *vtd_iommufd_dev;             /* VTDIOMMUFDDevice */
 
+    VTDHwpt *s2_hwpt;
+
     /* interrupt remapping */
     bool intr_enabled;              /* Whether guest enabled IR */
     dma_addr_t intr_root;           /* Interrupt remapping table pointer */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a1a1f23246..df93fcacd8 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -40,6 +40,7 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 #include "qemu/jhash.h"
+#include "sysemu/iommufd.h"
 
 /* context entry operations */
 #define VTD_CE_GET_RID2PASID(ce) \
@@ -771,6 +772,24 @@ static inline uint32_t vtd_sm_ce_get_pdt_entry_num(VTDContextEntry *ce)
     return 1U << (VTD_SM_CONTEXT_ENTRY_PDTS(ce->val[0]) + 7);
 }
 
+static inline uint32_t vtd_pe_get_fl_aw(VTDPASIDEntry *pe)
+{
+    return 48 + ((pe->val[2] >> 2) & VTD_SM_PASID_ENTRY_FLPM) * 9;
+}
+
+static inline dma_addr_t vtd_pe_get_flpt_base(VTDPASIDEntry *pe)
+{
+    return pe->val[2] & VTD_SM_PASID_ENTRY_FLPTPTR;
+}
+
+static inline void pasid_cache_info_set_error(VTDPASIDCacheInfo *pc_info)
+{
+    if (pc_info->error_happened) {
+        return;
+    }
+    pc_info->error_happened = true;
+}
+
 static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
 {
     return pdire->val & 1;
@@ -1631,6 +1650,17 @@ static int vtd_address_space_sync(VTDAddressSpace *vtd_as)
     return vtd_sync_shadow_page_table_range(vtd_as, &ce, 0, UINT64_MAX);
 }
 
+static bool vtd_pe_pgtt_is_pt(VTDPASIDEntry *pe)
+{
+    return (VTD_PE_GET_TYPE(pe) == VTD_SM_PASID_ENTRY_PT);
+}
+
+/* check if pgtt is first stage translation */
+static bool vtd_pe_pgtt_is_flt(VTDPASIDEntry *pe)
+{
+    return (VTD_PE_GET_TYPE(pe) == VTD_SM_PASID_ENTRY_FLT);
+}
+
 /*
  * Check if specific device is configured to bypass address
  * translation for DMA requests. In Scalable Mode, bypass
@@ -1652,7 +1682,7 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
              */
             return false;
         }
-        return (VTD_PE_GET_TYPE(&pe) == VTD_SM_PASID_ENTRY_PT);
+        return vtd_pe_pgtt_is_pt(&pe);
     }
 
     return (vtd_ce_get_type(ce) == VTD_CONTEXT_TT_PASS_THROUGH);
@@ -2091,6 +2121,543 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
     vtd_iommu_replay_all(s);
 }
 
+static bool iommufd_listener_skipped_section(MemoryRegionSection *section)
+{
+    return !memory_region_is_ram(section->mr) ||
+           memory_region_is_protected(section->mr) ||
+           /*
+            * Sizing an enabled 64-bit BAR can cause spurious mappings to
+            * addresses in the upper part of the 64-bit address space.  These
+            * are never accessed by the CPU and beyond the address width of
+            * some IOMMU hardware.  TODO: VFIO should tell us the IOMMU width.
+            */
+           section->offset_within_address_space & (1ULL << 63);
+}
+
+static void iommufd_listener_region_add_s2domain(MemoryListener *listener,
+                                                 MemoryRegionSection *section)
+{
+    VTDIOASContainer *container = container_of(listener,
+                                               VTDIOASContainer, listener);
+    IOMMUFDBackend *iommufd = container->iommufd;
+    uint32_t ioas_id = container->ioas_id;
+    hwaddr iova;
+    Int128 llend, llsize;
+    void *vaddr;
+    Error *err = NULL;
+    int ret;
+
+    if (iommufd_listener_skipped_section(section)) {
+        return;
+    }
+    iova = REAL_HOST_PAGE_ALIGN(section->offset_within_address_space);
+    llend = int128_make64(section->offset_within_address_space);
+    llend = int128_add(llend, section->size);
+    llend = int128_and(llend, int128_exts64(qemu_real_host_page_mask()));
+    llsize = int128_sub(llend, int128_make64(iova));
+    vaddr = memory_region_get_ram_ptr(section->mr) +
+            section->offset_within_region +
+            (iova - section->offset_within_address_space);
+
+    memory_region_ref(section->mr);
+
+    ret = iommufd_backend_map_dma(iommufd, ioas_id, iova, int128_get64(llsize),
+                                  vaddr, section->readonly);
+    if (!ret) {
+        return;
+    }
+
+    error_setg(&err,
+               "iommufd_listener_region_add_s2domain(%p, 0x%"HWADDR_PRIx", "
+               "0x%"HWADDR_PRIx", %p) = %d (%s)",
+               container, iova, int128_get64(llsize), vaddr, ret,
+               strerror(-ret));
+
+    if (memory_region_is_ram_device(section->mr)) {
+        /* Allow unexpected mappings not to be fatal for RAM devices */
+        error_report_err(err);
+        return;
+    }
+
+    if (!container->error) {
+        error_propagate_prepend(&container->error, err, "Region %s: ",
+                                memory_region_name(section->mr));
+    } else {
+        error_free(err);
+    }
+}
+
+static void iommufd_listener_region_del_s2domain(MemoryListener *listener,
+                                                 MemoryRegionSection *section)
+{
+    VTDIOASContainer *container = container_of(listener,
+                                               VTDIOASContainer, listener);
+    IOMMUFDBackend *iommufd = container->iommufd;
+    uint32_t ioas_id = container->ioas_id;
+    hwaddr iova;
+    Int128 llend, llsize;
+    int ret;
+
+    if (iommufd_listener_skipped_section(section)) {
+        return;
+    }
+    iova = REAL_HOST_PAGE_ALIGN(section->offset_within_address_space);
+    llend = int128_make64(section->offset_within_address_space);
+    llend = int128_add(llend, section->size);
+    llend = int128_and(llend, int128_exts64(qemu_real_host_page_mask()));
+    llsize = int128_sub(llend, int128_make64(iova));
+
+    ret = iommufd_backend_unmap_dma(iommufd, ioas_id,
+                                    iova, int128_get64(llsize));
+    if (ret) {
+        error_report("iommufd_listener_region_del_s2domain(%p, "
+                     "0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx") = %d (%s)",
+                     container, iova, int128_get64(llsize), ret,
+                     strerror(-ret));
+    }
+
+    memory_region_unref(section->mr);
+}
+
+static const MemoryListener iommufd_s2domain_memory_listener = {
+    .name = "iommufd_s2domain",
+    .priority = 1000,
+    .region_add = iommufd_listener_region_add_s2domain,
+    .region_del = iommufd_listener_region_del_s2domain,
+};
+
+static void vtd_init_s1_hwpt_data(struct iommu_hwpt_vtd_s1 *vtd,
+                                  VTDPASIDEntry *pe)
+{
+    memset(vtd, 0, sizeof(*vtd));
+
+    vtd->flags =  (VTD_SM_PASID_ENTRY_SRE_BIT(pe->val[2]) ?
+                                        IOMMU_VTD_S1_SRE : 0) |
+                  (VTD_SM_PASID_ENTRY_WPE_BIT(pe->val[2]) ?
+                                        IOMMU_VTD_S1_WPE : 0) |
+                  (VTD_SM_PASID_ENTRY_EAFE_BIT(pe->val[2]) ?
+                                        IOMMU_VTD_S1_EAFE : 0);
+    vtd->addr_width = vtd_pe_get_fl_aw(pe);
+    vtd->pgtbl_addr = (uint64_t)vtd_pe_get_flpt_base(pe);
+}
+
+static int vtd_create_s1_hwpt(IOMMUFDDevice *idev,
+                              VTDS2Hwpt *s2_hwpt, VTDHwpt *hwpt,
+                              VTDPASIDEntry *pe, Error **errp)
+{
+    struct iommu_hwpt_vtd_s1 vtd;
+    uint32_t hwpt_id, s2_hwpt_id = s2_hwpt->hwpt_id;
+    int ret;
+
+    vtd_init_s1_hwpt_data(&vtd, pe);
+
+    ret = iommufd_backend_alloc_hwpt(idev->iommufd, idev->dev_id,
+                                     s2_hwpt_id, 0, IOMMU_HWPT_DATA_VTD_S1,
+                                     sizeof(vtd), &vtd, &hwpt_id);
+    if (ret) {
+        error_setg(errp, "Failed to allocate stage-1 page table, dev_id %d",
+                   idev->dev_id);
+        return ret;
+    }
+
+    hwpt->hwpt_id = hwpt_id;
+
+    return 0;
+}
+
+static void vtd_destroy_s1_hwpt(IOMMUFDDevice *idev, VTDHwpt *hwpt)
+{
+    iommufd_backend_free_id(idev->iommufd, hwpt->hwpt_id);
+}
+
+static VTDS2Hwpt *vtd_ioas_container_get_s2_hwpt(VTDIOASContainer *container,
+                                                 uint32_t hwpt_id)
+{
+    VTDS2Hwpt *s2_hwpt;
+
+    QLIST_FOREACH(s2_hwpt, &container->s2_hwpt_list, next) {
+        if (s2_hwpt->hwpt_id == hwpt_id) {
+            return s2_hwpt;
+        }
+    }
+
+    s2_hwpt = g_malloc0(sizeof(*s2_hwpt));
+
+    s2_hwpt->hwpt_id = hwpt_id;
+    s2_hwpt->container = container;
+    QLIST_INSERT_HEAD(&container->s2_hwpt_list, s2_hwpt, next);
+
+    return s2_hwpt;
+}
+
+static void vtd_ioas_container_put_s2_hwpt(VTDS2Hwpt *s2_hwpt)
+{
+    VTDIOASContainer *container = s2_hwpt->container;
+
+    if (s2_hwpt->users) {
+        return;
+    }
+
+    QLIST_REMOVE(s2_hwpt, next);
+    iommufd_backend_free_id(container->iommufd, s2_hwpt->hwpt_id);
+    g_free(s2_hwpt);
+}
+
+static void vtd_ioas_container_destroy(VTDIOASContainer *container)
+{
+    if (!QLIST_EMPTY(&container->s2_hwpt_list)) {
+        return;
+    }
+
+    QLIST_REMOVE(container, next);
+    memory_listener_unregister(&container->listener);
+    iommufd_backend_free_id(container->iommufd, container->ioas_id);
+    g_free(container);
+}
+
+static int vtd_device_attach_hwpt(VTDIOMMUFDDevice *vtd_idev,
+                                  uint32_t rid_pasid, VTDPASIDEntry *pe,
+                                  VTDS2Hwpt *s2_hwpt, VTDHwpt *hwpt,
+                                  Error **errp)
+{
+    IOMMUFDDevice *idev = vtd_idev->idev;
+    int ret;
+
+    if (vtd_pe_pgtt_is_flt(pe)) {
+        ret = vtd_create_s1_hwpt(vtd_idev->idev, s2_hwpt,
+                                 hwpt, pe, errp);
+        if (ret) {
+            return ret;
+        }
+    } else {
+        hwpt->hwpt_id = s2_hwpt->hwpt_id;
+    }
+
+    ret = iommufd_device_attach_hwpt(idev, hwpt->hwpt_id);
+    trace_vtd_device_attach_hwpt(idev->dev_id, rid_pasid, hwpt->hwpt_id, ret);
+    if (ret) {
+        if (vtd_pe_pgtt_is_flt(pe)) {
+            vtd_destroy_s1_hwpt(idev, hwpt);
+        }
+        hwpt->hwpt_id = 0;
+        error_setg(errp, "dev_id %d pasid %d failed to attach hwpt %d",
+                   idev->dev_id, rid_pasid, hwpt->hwpt_id);
+        return ret;
+    }
+
+    s2_hwpt->users++;
+    hwpt->s2_hwpt = s2_hwpt;
+
+    return 0;
+}
+
+static void vtd_device_detach_hwpt(VTDIOMMUFDDevice *vtd_idev,
+                                   uint32_t rid_pasid, VTDPASIDEntry *pe,
+                                   VTDHwpt *hwpt, Error **errp)
+{
+    IOMMUFDDevice *idev = vtd_idev->idev;
+    int ret;
+
+    if (vtd_idev->iommu_state->dmar_enabled) {
+        ret = iommufd_device_detach_hwpt(idev);
+        trace_vtd_device_detach_hwpt(idev->dev_id, rid_pasid, ret);
+    } else {
+        ret = iommufd_device_attach_hwpt(idev, idev->ioas_id);
+        trace_vtd_device_reattach_def_ioas(idev->dev_id, rid_pasid,
+                                           idev->ioas_id, ret);
+    }
+
+    if (ret) {
+        error_setg(errp, "dev_id %d pasid %d failed to attach hwpt %d",
+                   idev->dev_id, rid_pasid, hwpt->hwpt_id);
+    }
+
+    if (vtd_pe_pgtt_is_flt(pe)) {
+        vtd_destroy_s1_hwpt(idev, hwpt);
+    }
+
+    hwpt->s2_hwpt->users--;
+    hwpt->s2_hwpt = NULL;
+    hwpt->hwpt_id = 0;
+}
+
+static int vtd_device_attach_container(VTDIOMMUFDDevice *vtd_idev,
+                                       VTDIOASContainer *container,
+                                       uint32_t rid_pasid,
+                                       VTDPASIDEntry *pe,
+                                       VTDHwpt *hwpt,
+                                       Error **errp)
+{
+    IOMMUFDDevice *idev = vtd_idev->idev;
+    IOMMUFDBackend *iommufd = idev->iommufd;
+    VTDS2Hwpt *s2_hwpt;
+    uint32_t s2_hwpt_id;
+    Error *err = NULL;
+    int ret;
+
+    /* try to attach to an existing hwpt in this container */
+    QLIST_FOREACH(s2_hwpt, &container->s2_hwpt_list, next) {
+        ret = vtd_device_attach_hwpt(vtd_idev, rid_pasid, pe,
+                                     s2_hwpt, hwpt, &err);
+        if (ret) {
+            const char *msg = error_get_pretty(err);
+
+            trace_vtd_device_fail_attach_existing_hwpt(msg);
+            error_free(err);
+            err = NULL;
+        } else {
+            goto found_hwpt;
+        }
+    }
+
+    ret = iommufd_backend_alloc_hwpt(iommufd, idev->dev_id,
+                                     container->ioas_id,
+                                     IOMMU_HWPT_ALLOC_NEST_PARENT,
+                                     IOMMU_HWPT_DATA_NONE,
+                                     0, NULL, &s2_hwpt_id);
+    if (ret) {
+        error_setg_errno(errp, errno, "error alloc parent hwpt");
+        return ret;
+    }
+
+    s2_hwpt = vtd_ioas_container_get_s2_hwpt(container, s2_hwpt_id);
+
+    /* Attach vtd device to a new allocated hwpt within iommufd */
+    ret = vtd_device_attach_hwpt(vtd_idev, rid_pasid, pe, s2_hwpt, hwpt, &err);
+    if (ret) {
+        goto err_attach_hwpt;
+    }
+
+found_hwpt:
+    trace_vtd_device_attach_container(iommufd->fd, idev->dev_id, rid_pasid,
+                                      container->ioas_id, hwpt->hwpt_id);
+    return 0;
+
+err_attach_hwpt:
+    vtd_ioas_container_put_s2_hwpt(s2_hwpt);
+    return ret;
+}
+
+static void vtd_device_detach_container(VTDIOMMUFDDevice *vtd_idev,
+                                        uint32_t rid_pasid,
+                                        VTDPASIDEntry *pe,
+                                        VTDHwpt *hwpt,
+                                        Error **errp)
+{
+    IOMMUFDDevice *idev = vtd_idev->idev;
+    IOMMUFDBackend *iommufd = idev->iommufd;
+    VTDS2Hwpt *s2_hwpt = hwpt->s2_hwpt;
+
+    trace_vtd_device_detach_container(iommufd->fd, idev->dev_id, rid_pasid);
+    vtd_device_detach_hwpt(vtd_idev, rid_pasid, pe, hwpt, errp);
+    vtd_ioas_container_put_s2_hwpt(s2_hwpt);
+}
+
+static int vtd_device_attach_iommufd(VTDIOMMUFDDevice *vtd_idev,
+                                     uint32_t rid_pasid,
+                                     VTDPASIDEntry *pe,
+                                     VTDHwpt *hwpt,
+                                     Error **errp)
+{
+    IntelIOMMUState *s = vtd_idev->iommu_state;
+    VTDIOASContainer *container;
+    IOMMUFDBackend *iommufd = vtd_idev->idev->iommufd;
+    Error *err = NULL;
+    uint32_t ioas_id;
+    int ret;
+
+    /* try to attach to an existing container in this space */
+    QLIST_FOREACH(container, &s->containers, next) {
+        if (container->iommufd != iommufd) {
+            continue;
+        }
+
+        if (vtd_device_attach_container(vtd_idev, container,
+                                        rid_pasid, pe, hwpt, &err)) {
+            const char *msg = error_get_pretty(err);
+
+            trace_vtd_device_fail_attach_existing_container(msg);
+            error_free(err);
+            err = NULL;
+        } else {
+            return 0;
+        }
+    }
+
+    /* Need to allocate a new dedicated container */
+    ret = iommufd_backend_alloc_ioas(iommufd, &ioas_id, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    trace_vtd_device_alloc_ioas(iommufd->fd, ioas_id);
+
+    container = g_malloc0(sizeof(*container));
+    container->iommufd = iommufd;
+    container->ioas_id = ioas_id;
+    QLIST_INIT(&container->s2_hwpt_list);
+
+    if (vtd_device_attach_container(vtd_idev, container,
+                                    rid_pasid, pe, hwpt, errp)) {
+        goto err_attach_container;
+    }
+
+    container->listener = iommufd_s2domain_memory_listener;
+    memory_listener_register(&container->listener, &address_space_memory);
+
+    if (container->error) {
+        ret = -1;
+        error_propagate_prepend(errp, container->error,
+                                "memory listener initialization failed: ");
+        goto err_listener_register;
+    }
+
+    QLIST_INSERT_HEAD(&s->containers, container, next);
+
+    return 0;
+
+err_listener_register:
+    vtd_device_detach_container(vtd_idev, rid_pasid, pe, hwpt, errp);
+err_attach_container:
+    iommufd_backend_free_id(iommufd, container->ioas_id);
+    g_free(container);
+    return ret;
+}
+
+static void vtd_device_detach_iommufd(VTDIOMMUFDDevice *vtd_idev,
+                                      uint32_t rid_pasid,
+                                      VTDPASIDEntry *pe,
+                                      VTDHwpt *hwpt,
+                                      Error **errp)
+{
+    VTDIOASContainer *container = hwpt->s2_hwpt->container;
+
+    vtd_device_detach_container(vtd_idev, rid_pasid, pe, hwpt, errp);
+    vtd_ioas_container_destroy(container);
+}
+
+static int vtd_device_attach_pgtbl(VTDIOMMUFDDevice *vtd_idev,
+                                   VTDPASIDEntry *pe,
+                                   VTDPASIDAddressSpace *vtd_pasid_as,
+                                   uint32_t rid_pasid)
+{
+    /*
+     * If pe->gptt != FLT, should be go ahead to do bind as host only
+     * accepts guest FLT under nesting. If pe->pgtt==PT, should setup
+     * the pasid with GPA page table. Otherwise should return failure.
+     */
+    if (!vtd_pe_pgtt_is_flt(pe) && !vtd_pe_pgtt_is_pt(pe)) {
+        return -EINVAL;
+    }
+
+    /* Should fail if the FLPT base is 0 */
+    if (vtd_pe_pgtt_is_flt(pe) && !vtd_pe_get_flpt_base(pe)) {
+        return -EINVAL;
+    }
+
+    return vtd_device_attach_iommufd(vtd_idev, rid_pasid, pe,
+                                     &vtd_pasid_as->hwpt, &error_abort);
+}
+
+static int vtd_device_detach_pgtbl(VTDIOMMUFDDevice *vtd_idev,
+                                  VTDPASIDAddressSpace *vtd_pasid_as,
+                                  uint32_t rid_pasid)
+{
+    VTDPASIDEntry *cached_pe = vtd_pasid_as->pasid_cache_entry.cache_filled ?
+                       &vtd_pasid_as->pasid_cache_entry.pasid_entry : NULL;
+
+    if (!cached_pe ||
+        (!vtd_pe_pgtt_is_flt(cached_pe) && !vtd_pe_pgtt_is_pt(cached_pe))) {
+        return 0;
+    }
+
+    vtd_device_detach_iommufd(vtd_idev, rid_pasid, cached_pe,
+                              &vtd_pasid_as->hwpt, &error_abort);
+
+    return 0;
+}
+
+static int vtd_dev_get_rid2pasid(IntelIOMMUState *s, uint8_t bus_num,
+                                 uint8_t devfn, uint32_t *rid_pasid)
+{
+    VTDContextEntry ce;
+    int ret;
+
+    /*
+     * Currently, ECAP.RPS bit is likely to be reported as "Clear".
+     * And per VT-d 3.1 spec, it will use PASID #0 as RID2PASID when
+     * RPS bit is reported as "Clear".
+     */
+    if (likely(!(s->ecap & VTD_ECAP_RPS))) {
+        *rid_pasid = 0;
+        return 0;
+    }
+
+    /*
+     * In future, to improve performance, could try to fetch context
+     * entry from cache firstly.
+     */
+    ret = vtd_dev_to_context_entry(s, bus_num, devfn, &ce);
+    if (!ret) {
+        *rid_pasid = VTD_CE_GET_RID2PASID(&ce);
+    }
+
+    return ret;
+}
+
+/**
+ * Caller should hold iommu_lock.
+ */
+static int vtd_bind_guest_pasid(VTDPASIDAddressSpace *vtd_pasid_as,
+                                VTDPASIDEntry *pe, VTDPASIDOp op)
+{
+    IntelIOMMUState *s = vtd_pasid_as->iommu_state;
+    VTDIOMMUFDDevice *vtd_idev;
+    uint32_t rid_pasid;
+    int devfn = vtd_pasid_as->devfn;
+    int ret = -EINVAL;
+    struct vtd_as_key key = {
+        .bus = vtd_pasid_as->bus,
+        .devfn = devfn,
+    };
+
+    vtd_idev = g_hash_table_lookup(s->vtd_iommufd_dev, &key);
+    if (!vtd_idev || !vtd_idev->idev) {
+        /* means no need to go further, e.g. for emulated devices */
+        return 0;
+    }
+
+    if (vtd_dev_get_rid2pasid(s, pci_bus_num(vtd_pasid_as->bus),
+                              devfn, &rid_pasid)) {
+        error_report("Unable to get rid_pasid for devfn: %d!", devfn);
+        return ret;
+    }
+
+    if (vtd_pasid_as->pasid != rid_pasid) {
+        error_report("Non-rid_pasid %d not supported yet", vtd_pasid_as->pasid);
+        return ret;
+    }
+
+    switch (op) {
+    case VTD_PASID_UPDATE:
+    case VTD_PASID_BIND:
+    {
+        ret = vtd_device_attach_pgtbl(vtd_idev, pe, vtd_pasid_as, rid_pasid);
+        break;
+    }
+    case VTD_PASID_UNBIND:
+    {
+        ret = vtd_device_detach_pgtbl(vtd_idev, vtd_pasid_as, rid_pasid);
+        break;
+    }
+    default:
+        error_report_once("Unknown VTDPASIDOp!!!\n");
+        break;
+    }
+
+    return ret;
+}
+
 /* Do a context-cache device-selective invalidation.
  * @func_mask: FM field after shifting
  */
@@ -2717,22 +3284,30 @@ static bool vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
  * This function fills in the pasid entry in &vtd_pasid_as. Caller
  * of this function should hold iommu_lock.
  */
-static void vtd_fill_pe_in_cache(IntelIOMMUState *s,
-                                 VTDPASIDAddressSpace *vtd_pasid_as,
-                                 VTDPASIDEntry *pe)
+static int vtd_fill_pe_in_cache(IntelIOMMUState *s,
+                                VTDPASIDAddressSpace *vtd_pasid_as,
+                                VTDPASIDEntry *pe)
 {
     VTDPASIDCacheEntry *pc_entry = &vtd_pasid_as->pasid_cache_entry;
+    int ret;
 
-    if (vtd_pasid_entry_compare(pe, &pc_entry->pasid_entry)) {
-        /* No need to go further as cached pasid entry is latest */
-        return;
+    if (pc_entry->cache_filled) {
+        if (vtd_pasid_entry_compare(pe, &pc_entry->pasid_entry)) {
+            /* No need to go further as cached pasid entry is latest */
+            return 0;
+        }
+        ret = vtd_bind_guest_pasid(vtd_pasid_as,
+                                   pe, VTD_PASID_UPDATE);
+    } else {
+        ret = vtd_bind_guest_pasid(vtd_pasid_as,
+                                   pe, VTD_PASID_BIND);
     }
 
-    pc_entry->pasid_entry = *pe;
-    /*
-     * TODO:
-     * - send pasid bind to host for passthru devices
-     */
+    if (!ret) {
+        pc_entry->pasid_entry = *pe;
+        pc_entry->cache_filled = true;
+    }
+    return ret;
 }
 
 /*
@@ -2795,7 +3370,11 @@ static gboolean vtd_flush_pasid(gpointer key, gpointer value,
         goto remove;
     }
 
-    vtd_fill_pe_in_cache(s, vtd_pasid_as, &pe);
+    if (vtd_fill_pe_in_cache(s, vtd_pasid_as, &pe)) {
+        pasid_cache_info_set_error(pc_info);
+        return true;
+    }
+
     /*
      * TODO:
      * - when pasid-base-iotlb(piotlb) infrastructure is ready,
@@ -2805,10 +3384,14 @@ static gboolean vtd_flush_pasid(gpointer key, gpointer value,
 remove:
     /*
      * TODO:
-     * - send pasid bind to host for passthru devices
      * - when pasid-base-iotlb(piotlb) infrastructure is ready,
      *   should invalidate QEMU piotlb togehter with this change.
      */
+    if (vtd_bind_guest_pasid(vtd_pasid_as,
+                             NULL, VTD_PASID_UNBIND)) {
+        pasid_cache_info_set_error(pc_info);
+    }
+
     return true;
 }
 
@@ -2854,6 +3437,22 @@ static VTDPASIDAddressSpace *vtd_add_find_pasid_as(IntelIOMMUState *s,
     return vtd_pasid_as;
 }
 
+/* Caller of this function should hold iommu_lock. */
+static void vtd_remove_pasid_as(VTDPASIDAddressSpace *vtd_pasid_as)
+{
+    IntelIOMMUState *s = vtd_pasid_as->iommu_state;
+    PCIBus *bus = vtd_pasid_as->bus;
+    struct pasid_key key;
+    int devfn = vtd_pasid_as->devfn;
+    uint32_t pasid = vtd_pasid_as->pasid;
+    uint16_t sid;
+
+    sid = PCI_BUILD_BDF(pci_bus_num(bus), devfn);
+    vtd_init_pasid_key(pasid, sid, &key);
+
+    g_hash_table_remove(s->vtd_pasid_as, &key);
+}
+
 /* Caller of this function should hold iommu_lock. */
 static void vtd_sm_pasid_table_walk_one(IntelIOMMUState *s,
                                         dma_addr_t pt_base,
@@ -2884,7 +3483,10 @@ static void vtd_sm_pasid_table_walk_one(IntelIOMMUState *s,
                 pasid = pasid_next;
                 continue;
             }
-            vtd_fill_pe_in_cache(s, vtd_pasid_as, &pe);
+            if (vtd_fill_pe_in_cache(s, vtd_pasid_as, &pe)) {
+                vtd_remove_pasid_as(vtd_pasid_as);
+                pasid_cache_info_set_error(info);
+            }
         }
         pasid = pasid_next;
     }
@@ -2991,6 +3593,9 @@ static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
         walk_info.devfn = vtd_idev->devfn;
         vtd_replay_pasid_bind_for_dev(s, start, end, &walk_info);
     }
+    if (walk_info.error_happened) {
+        pasid_cache_info_set_error(pc_info);
+    }
 }
 
 /*
@@ -3060,7 +3665,7 @@ static void vtd_pasid_cache_sync(IntelIOMMUState *s,
 /* Caller of this function should hold iommu_lock */
 static void vtd_pasid_cache_reset(IntelIOMMUState *s)
 {
-    VTDPASIDCacheInfo pc_info;
+    VTDPASIDCacheInfo pc_info = { .error_happened = false, };
 
     trace_vtd_pasid_cache_reset();
 
@@ -3082,9 +3687,9 @@ static void vtd_pasid_cache_reset(IntelIOMMUState *s)
 static bool vtd_process_pasid_desc(IntelIOMMUState *s,
                                    VTDInvDesc *inv_desc)
 {
+    VTDPASIDCacheInfo pc_info = { .error_happened = false, };
     uint16_t domain_id;
     uint32_t pasid;
-    VTDPASIDCacheInfo pc_info;
 
     if ((inv_desc->val[0] & VTD_INV_DESC_PASIDC_RSVD_VAL0) ||
         (inv_desc->val[1] & VTD_INV_DESC_PASIDC_RSVD_VAL1) ||
@@ -3125,7 +3730,7 @@ static bool vtd_process_pasid_desc(IntelIOMMUState *s,
     }
 
     vtd_pasid_cache_sync(s, &pc_info);
-    return true;
+    return !pc_info.error_happened ? true : false;
 }
 
 static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 91d6c400b4..17e7191696 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -72,6 +72,14 @@ vtd_frr_new(int index, uint64_t hi, uint64_t lo) "index %d high 0x%"PRIx64" low
 vtd_warn_invalid_qi_tail(uint16_t tail) "tail 0x%"PRIx16
 vtd_warn_ir_vector(uint16_t sid, int index, int vec, int target) "sid 0x%"PRIx16" index %d vec %d (should be: %d)"
 vtd_warn_ir_trigger(uint16_t sid, int index, int trig, int target) "sid 0x%"PRIx16" index %d trigger %d (should be: %d)"
+vtd_device_attach_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
+vtd_device_detach_hwpt(uint32_t dev_id, uint32_t pasid, int ret) "dev_id %d pasid %d ret: %d"
+vtd_device_reattach_def_ioas(uint32_t dev_id, uint32_t pasid, uint32_t ioas_id, int ret) "dev_id %d pasid %d ioas_id %d, ret: %d"
+vtd_device_fail_attach_existing_hwpt(const char *msg) " %s"
+vtd_device_attach_container(int fd, uint32_t dev_id, uint32_t pasid, uint32_t ioas_id, uint32_t hwpt_id) "iommufd %d dev_id %d pasid %d ioas_id %d hwpt_id %d"
+vtd_device_detach_container(int fd, uint32_t dev_id, uint32_t pasid) "iommufd %d dev_id %d pasid %d"
+vtd_device_fail_attach_existing_container(const char *msg) " %s"
+vtd_device_alloc_ioas(int fd, uint32_t ioas_id) "iommufd %d ioas_id %d"
 
 # amd_iommu.c
 amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32
-- 
2.34.1


