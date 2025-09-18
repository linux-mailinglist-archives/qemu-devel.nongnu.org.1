Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5432EB14B24
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Jul 2025 11:23:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uggXs-0007jA-0N; Tue, 29 Jul 2025 05:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uggXg-0006YS-6e
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 05:22:40 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uggXd-0002ij-Ok
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 05:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753780958; x=1785316958;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A7ziMebD1eq3SZROnPapkMEc5GJkaqLHyMAAW5H6z3A=;
 b=L3QEjUBj9rePGTOSV09VHOtiQ4ev+FOVSf2ZUfrjmcQlhBaT1Xm4h0tG
 2JFW6qcplZR65JpBP1vFuw3q+AMTqBS2O5AG55a0tMng/f9bURVNE+khX
 mGspvJ9byaBALv/KA1DAtLzRC7NM2zvn0LXLzaCV3knP9LPbgFiWqKcu3
 ZSf5TgJjwIHI6QJEpOse5inzilZCD3fITsRfAeSYsAMj0WXepTh+vugxs
 xlnN8Yiyp/pWgvNjmTugdyft3t/Lk72TxugHatuvYNb8ZsTUQ8FgWmLFd
 SxLtr4PipE21Jne3iT4l0daV7ssKPTaX96uKmiiYNLGD1RARYmdEDgzcj w==;
X-CSE-ConnectionGUID: oPOCvgrVTyy8aksCpN+K8w==
X-CSE-MsgGUID: M63kihxtT5aFDTjtI/0oYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="55982045"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="55982045"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2025 02:22:26 -0700
X-CSE-ConnectionGUID: 0C8IJTgtQ72AXrhcC9N2RA==
X-CSE-MsgGUID: MaehrCswTT6Nlh/SyBn+5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="162691441"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2025 02:22:07 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 16/20] intel_iommu: Propagate PASID-based iotlb
 invalidation to host
Date: Tue, 29 Jul 2025 05:20:38 -0400
Message-ID: <20250729092043.785836-17-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250729092043.785836-1-zhenzhong.duan@intel.com>
References: <20250729092043.785836-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Yi Liu <yi.l.liu@intel.com>

This traps the guest PASID-based iotlb invalidation request and propagate it
to host.

Intel VT-d 3.0 supports nested translation in PASID granularity. Guest SVA
support could be implemented by configuring nested translation on specific
pasid. This is also known as dual stage DMA translation.

Under such configuration, guest owns the GVA->GPA translation which is
configured as stage-1 page table on host side for a specific pasid, and host
owns GPA->HPA translation. As guest owns stage-1 translation table, piotlb
invalidation should be propagated to host since host IOMMU will cache first
level page table related mappings during DMA address translation.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  6 +++
 hw/i386/intel_iommu.c          | 95 +++++++++++++++++++++++++++++++++-
 2 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 8af1004888..c1a9263651 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -596,6 +596,12 @@ typedef struct VTDPASIDCacheInfo {
     uint16_t devfn;
 } VTDPASIDCacheInfo;
 
+typedef struct VTDPIOTLBInvInfo {
+    uint16_t domain_id;
+    uint32_t pasid;
+    struct iommu_hwpt_vtd_s1_invalidate *inv_data;
+} VTDPIOTLBInvInfo;
+
 /* PASID Table Related Definitions */
 #define VTD_PASID_DIR_BASE_ADDR_MASK  (~0xfffULL)
 #define VTD_PASID_TABLE_BASE_ADDR_MASK (~0xfffULL)
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 6620e975f3..27bd8c4c89 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2611,12 +2611,99 @@ static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, VTDPASIDOp op,
 
     return ret;
 }
+
+static void
+vtd_invalidate_piotlb_locked(VTDAddressSpace *vtd_as,
+                             struct iommu_hwpt_vtd_s1_invalidate *cache)
+{
+    IntelIOMMUState *s = vtd_as->iommu_state;
+    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(s, vtd_as);
+    HostIOMMUDeviceIOMMUFD *idev;
+    uint32_t entry_num = 1; /* Only implement one request for simplicity */
+    Error *local_err = NULL;
+
+    if (!vtd_hiod || !vtd_as->s1_hwpt) {
+        return;
+    }
+    idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+
+    if (!iommufd_backend_invalidate_cache(idev->iommufd, vtd_as->s1_hwpt,
+                                          IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
+                                          sizeof(*cache), &entry_num, cache,
+                                          &local_err)) {
+        /* Something wrong in kernel, but trying to continue */
+        error_report_err(local_err);
+    }
+}
+
+/*
+ * This function is a loop function for the s->vtd_address_spaces
+ * list with VTDPIOTLBInvInfo as execution filter. It propagates
+ * the piotlb invalidation to host.
+ */
+static void vtd_flush_host_piotlb_locked(gpointer key, gpointer value,
+                                         gpointer user_data)
+{
+    VTDPIOTLBInvInfo *piotlb_info = user_data;
+    VTDAddressSpace *vtd_as = value;
+    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
+    uint32_t pasid;
+    uint16_t did;
+
+    /* Replay only fills pasid entry cache for passthrough device */
+    if (!pc_entry->valid ||
+        !vtd_pe_pgtt_is_flt(&pc_entry->pasid_entry)) {
+        return;
+    }
+
+    if (vtd_as_to_iommu_pasid_locked(vtd_as, &pasid)) {
+        return;
+    }
+
+    did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
+
+    if (piotlb_info->domain_id == did && piotlb_info->pasid == pasid) {
+        vtd_invalidate_piotlb_locked(vtd_as, piotlb_info->inv_data);
+    }
+}
+
+static void
+vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s,
+                                 uint16_t domain_id, uint32_t pasid,
+                                 hwaddr addr, uint64_t npages, bool ih)
+{
+    struct iommu_hwpt_vtd_s1_invalidate cache_info = { 0 };
+    VTDPIOTLBInvInfo piotlb_info;
+
+    cache_info.addr = addr;
+    cache_info.npages = npages;
+    cache_info.flags = ih ? IOMMU_VTD_INV_FLAGS_LEAF : 0;
+
+    piotlb_info.domain_id = domain_id;
+    piotlb_info.pasid = pasid;
+    piotlb_info.inv_data = &cache_info;
+
+    /*
+     * Go through each vtd_as instance in s->vtd_address_spaces, find out
+     * the affected host device which need host piotlb invalidation. Piotlb
+     * invalidation should check pasid cache per architecture point of view.
+     */
+    g_hash_table_foreach(s->vtd_address_spaces,
+                         vtd_flush_host_piotlb_locked, &piotlb_info);
+}
 #else
 static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, VTDPASIDOp op,
                                 Error **errp)
 {
     return 0;
 }
+
+static void
+vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s,
+                                 uint16_t domain_id, uint32_t pasid,
+                                 hwaddr addr, uint64_t npages, bool ih)
+{
+}
 #endif
 
 static int vtd_bind_guest_pasid_report_err(VTDAddressSpace *vtd_as,
@@ -3292,6 +3379,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
     vtd_iommu_lock(s);
     g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_pasid,
                                 &info);
+    vtd_flush_host_piotlb_all_locked(s, domain_id, pasid, 0, (uint64_t)-1, 0);
     vtd_iommu_unlock(s);
 
     QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
@@ -3313,7 +3401,8 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
 }
 
 static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
-                                       uint32_t pasid, hwaddr addr, uint8_t am)
+                                       uint32_t pasid, hwaddr addr, uint8_t am,
+                                       bool ih)
 {
     VTDIOTLBPageInvInfo info;
 
@@ -3325,6 +3414,7 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
     vtd_iommu_lock(s);
     g_hash_table_foreach_remove(s->iotlb,
                                 vtd_hash_remove_by_page_piotlb, &info);
+    vtd_flush_host_piotlb_all_locked(s, domain_id, pasid, addr, 1 << am, ih);
     vtd_iommu_unlock(s);
 
     vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am, pasid);
@@ -3356,7 +3446,8 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
     case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
         am = VTD_INV_DESC_PIOTLB_AM(inv_desc->val[1]);
         addr = (hwaddr) VTD_INV_DESC_PIOTLB_ADDR(inv_desc->val[1]);
-        vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am);
+        vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am,
+                                   VTD_INV_DESC_PIOTLB_IH(inv_desc->val[1]));
         break;
 
     default:
-- 
2.47.1


