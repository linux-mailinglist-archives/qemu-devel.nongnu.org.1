Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 860E0719381
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 08:47:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4c4t-0004Ip-8Q; Thu, 01 Jun 2023 02:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q4c4q-0004IM-Ta
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 02:46:28 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q4c4p-00077p-1s
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 02:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685601986; x=1717137986;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CNHEDBOtjkxHzvRFPTKz/4r+ykDOvMqN3IHTzpMvfwk=;
 b=dqE4+WCUvpVqwivjahLn8+iqM6oYS3NJ7KPYubLVQR2z3s6gPpzrJbna
 w9vWguGkthAIXATeSZOYMYH2tHtYQbIHFCR+9KTX4kxnb9rUMRsFMRpS6
 TirF60HMKR8+Vwl+NCymiGupwvHZh2fivNXzchw7DZ08JDE/RweWVIUoM
 i5VunM2yK7rPcc+GJKfxI9xSSWKHGGxVm/6aSM+yB0NZ+/AKfrivSJz/W
 CSm0/lfO54bda01iGkr6w0NyCdcS/9OPLLCv30tm9cPKRttBILBp7aSg/
 LQw5uCWlwEWAdFV5U2yPiHs6cNaktNsPPThUGLQ9Ms8TehXL2uMc9b/De g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="421249338"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="421249338"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 23:46:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="953953074"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="953953074"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 23:46:21 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, peterx@redhat.com, jasowang@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com, clg@redhat.com,
 david@redhat.com, philmd@linaro.org, kwankhede@nvidia.com, cjia@nvidia.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com
Subject: [PATCH v2 2/4] intel_iommu: Fix a potential issue in VFIO dirty page
 sync
Date: Thu,  1 Jun 2023 14:33:18 +0800
Message-Id: <20230601063320.139308-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601063320.139308-1-zhenzhong.duan@intel.com>
References: <20230601063320.139308-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=zhenzhong.duan@intel.com; helo=mga07.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Peter Xu found a potential issue:

"The other thing is when I am looking at the new code I found that we
actually extended the replay() to be used also in dirty tracking of vfio,
in vfio_sync_dirty_bitmap().  For that maybe it's already broken if
unmap_all() because afaiu log_sync() can be called in migration thread
anytime during DMA so I think it means the device is prone to DMA with the
IOMMU pgtable quickly erased and rebuilt here, which means the DMA could
fail unexpectedly.  Copy Alex, Kirti and Neo."

To eliminate this small window with empty mapping, we should remove the
call to unmap_all(). Besides that, introduce a new notifier type called
IOMMU_NOTIFIER_FULL_MAP to get full mappings as intel_iommu only notifies
changed mappings while VFIO dirty page sync needs full mappings. Thanks
to current implementation of iova tree, we could pick mappings from iova
trees directly instead of walking through guest IOMMU page table.

IOMMU_NOTIFIER_MAP is still used to get changed mappings for optimization
purpose. As long as notification for IOMMU_NOTIFIER_MAP could ensure shadow
page table in sync, then it's OK.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 49 +++++++++++++++++++++++++++++++++++--------
 hw/vfio/common.c      |  2 +-
 include/exec/memory.h | 13 ++++++++++++
 softmmu/memory.c      |  4 ++++
 4 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 94d52f4205d2..061fcded0dfb 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3819,6 +3819,41 @@ static int vtd_replay_hook(IOMMUTLBEvent *event, void *private)
     return 0;
 }
 
+static gboolean vtd_replay_full_map(DMAMap *map, gpointer *private)
+{
+    IOMMUTLBEvent event;
+
+    event.type = IOMMU_NOTIFIER_MAP;
+    event.entry.iova = map->iova;
+    event.entry.addr_mask = map->size;
+    event.entry.target_as = &address_space_memory;
+    event.entry.perm = map->perm;
+    event.entry.translated_addr = map->translated_addr;
+
+    return vtd_replay_hook(&event, private);
+}
+
+/*
+ * This is a fast path to notify the full mappings falling in the scope
+ * of IOMMU notifier. The call site should ensure no iova tree update by
+ * taking necessary locks(e.x. BQL).
+ */
+static int vtd_page_walk_full_map_fast_path(IOVATree *iova_tree,
+                                            IOMMUNotifier *n)
+{
+    DMAMap map;
+
+    map.iova = n->start;
+    map.size = n->end - n->start;
+    if (!iova_tree_find(iova_tree, &map)) {
+        return 0;
+    }
+
+    iova_tree_foreach_range_data(iova_tree, &map, vtd_replay_full_map,
+                                 (gpointer *)n);
+    return 0;
+}
+
 static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
 {
     VTDAddressSpace *vtd_as = container_of(iommu_mr, VTDAddressSpace, iommu);
@@ -3826,13 +3861,6 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
     uint8_t bus_n = pci_bus_num(vtd_as->bus);
     VTDContextEntry ce;
 
-    /*
-     * The replay can be triggered by either a invalidation or a newly
-     * created entry. No matter what, we release existing mappings
-     * (it means flushing caches for UNMAP-only registers).
-     */
-    vtd_address_space_unmap(vtd_as, n);
-
     if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
         trace_vtd_replay_ce_valid(s->root_scalable ? "scalable mode" :
                                   "legacy mode",
@@ -3850,8 +3878,11 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
                 .as = vtd_as,
                 .domain_id = vtd_get_domain_id(s, &ce, vtd_as->pasid),
             };
-
-            vtd_page_walk(s, &ce, 0, ~0ULL, &info, vtd_as->pasid);
+            if (n->notifier_flags & IOMMU_NOTIFIER_FULL_MAP) {
+                vtd_page_walk_full_map_fast_path(vtd_as->iova_tree, n);
+            } else {
+                vtd_page_walk(s, &ce, 0, ~0ULL, &info, vtd_as->pasid);
+            }
         }
     } else {
         trace_vtd_replay_ce_invalid(bus_n, PCI_SLOT(vtd_as->devfn),
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 78358ede2764..5dae4502b908 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1890,7 +1890,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainer *container,
 
                 iommu_notifier_init(&gdn.n,
                                     vfio_iommu_map_dirty_notify,
-                                    IOMMU_NOTIFIER_MAP,
+                                    IOMMU_NOTIFIER_FULL_MAP,
                                     section->offset_within_region,
                                     int128_get64(llend),
                                     idx);
diff --git a/include/exec/memory.h b/include/exec/memory.h
index c3661b2276c7..eecc3eec6702 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -142,6 +142,10 @@ struct IOMMUTLBEntry {
  *       events (e.g. VFIO). Both notifications must be accurate so that
  *       the shadow page table is fully in sync with the guest view.
  *
+ *       Besides MAP, there is a special use case called FULL_MAP which
+ *       requests notification for all the existent mappings (e.g. VFIO
+ *       dirty page sync).
+ *
  *   (2) When the device doesn't need accurate synchronizations of the
  *       vIOMMU page tables, it needs to register only with UNMAP or
  *       DEVIOTLB_UNMAP notifies.
@@ -164,6 +168,8 @@ typedef enum {
     IOMMU_NOTIFIER_MAP = 0x2,
     /* Notify changes on device IOTLB entries */
     IOMMU_NOTIFIER_DEVIOTLB_UNMAP = 0x04,
+    /* Notify every existent entries */
+    IOMMU_NOTIFIER_FULL_MAP = 0x8,
 } IOMMUNotifierFlag;
 
 #define IOMMU_NOTIFIER_IOTLB_EVENTS (IOMMU_NOTIFIER_MAP | IOMMU_NOTIFIER_UNMAP)
@@ -237,6 +243,13 @@ static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
                                        hwaddr start, hwaddr end,
                                        int iommu_idx)
 {
+    /*
+     * memory_region_notify_iommu_one() needs IOMMU_NOTIFIER_MAP set to
+     * trigger notifier.
+     */
+    if (flags & IOMMU_NOTIFIER_FULL_MAP) {
+        flags |= IOMMU_NOTIFIER_MAP;
+    }
     n->notify = fn;
     n->notifier_flags = flags;
     n->start = start;
diff --git a/softmmu/memory.c b/softmmu/memory.c
index 7d9494ce7028..0a8465007c66 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1922,6 +1922,10 @@ int memory_region_register_iommu_notifier(MemoryRegion *mr,
     assert(n->iommu_idx >= 0 &&
            n->iommu_idx < memory_region_iommu_num_indexes(iommu_mr));
 
+    if (n->notifier_flags & IOMMU_NOTIFIER_FULL_MAP) {
+        error_setg(errp, "FULL_MAP could only be used in replay");
+    }
+
     QLIST_INSERT_HEAD(&iommu_mr->iommu_notify, n, node);
     ret = memory_region_update_iommu_notify_flags(iommu_mr, errp);
     if (ret) {
-- 
2.34.1


