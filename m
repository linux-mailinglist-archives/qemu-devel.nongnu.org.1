Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9231E7DED69
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:33:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyS92-0003Tz-VR; Thu, 02 Nov 2023 03:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS91-0003TV-9D; Thu, 02 Nov 2023 03:29:35 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS8z-0003Iu-3p; Thu, 02 Nov 2023 03:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698910173; x=1730446173;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=isyJZX6GqnJB+enC/OfCc7VnmeD1C9hXkNCedvWoDLE=;
 b=QKcC/bsc0HABy8VJ3N3uzqJ9cEchK8biZ7q0OvI9gCeFNlVVDBrzdW1O
 k0wVmNwJHIOGdgSrE29KH1HN7b0XDIAZ/On/Ld72ai0DLoQd/n5cv2Zsq
 wJAZLyuViEG7oCqGMV8Oi7CkpeGZLXdt/inw3dH6/BC7sfEA14q96qtK0
 nysv/upo/0Tb5V02SmgWLzk7qremdWJyYBN5i2OCmKhis4RvbKXlccX00
 jTchnITpv0YO0XNNj7VplNqTczOfxlmzNgMOyKdOWnZPXRdSAkcqrdrow
 zUc18jQXMyKpRHYh+jP3nMMjy4dghxN95afZUOsEgvF2RQXNj45zXHngo A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452953177"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="452953177"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:29:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711055385"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="711055385"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:29:25 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 qemu-ppc@nongnu.org (open list:sPAPR (pseries))
Subject: [PATCH v4 15/41] vfio/container: Move pgsizes and dma_max_mappings to
 base container
Date: Thu,  2 Nov 2023 15:12:36 +0800
Message-Id: <20231102071302.1818071-16-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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

From: Eric Auger <eric.auger@redhat.com>

No functional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
v4: Split vrdl_list change out in a seperate patch

 include/hw/vfio/vfio-common.h         |  2 --
 include/hw/vfio/vfio-container-base.h |  2 ++
 hw/vfio/common.c                      | 17 +++++++++--------
 hw/vfio/container-base.c              |  1 +
 hw/vfio/container.c                   | 11 +++++------
 hw/vfio/spapr.c                       | 10 ++++++----
 6 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index bc67e1316c..d3dc2f9dcb 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -85,8 +85,6 @@ typedef struct VFIOContainer {
     bool initialized;
     uint64_t dirty_pgsizes;
     uint64_t max_dirty_bitmap_size;
-    unsigned long pgsizes;
-    unsigned int dma_max_mappings;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     QLIST_HEAD(, VFIOGroup) group_list;
     QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 7090962496..85ec7e1a56 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -36,6 +36,8 @@ typedef struct VFIOAddressSpace {
 typedef struct VFIOContainerBase {
     const VFIOIOMMUOps *ops;
     VFIOAddressSpace *space;
+    unsigned long pgsizes;
+    unsigned int dma_max_mappings;
     bool dirty_pages_supported;
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
     QLIST_ENTRY(VFIOContainerBase) next;
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index cf6618f6ed..1cb53d369e 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -401,6 +401,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
 static void vfio_register_ram_discard_listener(VFIOContainer *container,
                                                MemoryRegionSection *section)
 {
+    VFIOContainerBase *bcontainer = &container->bcontainer;
     RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
     VFIORamDiscardListener *vrdl;
 
@@ -419,8 +420,8 @@ static void vfio_register_ram_discard_listener(VFIOContainer *container,
                                                                 section->mr);
 
     g_assert(vrdl->granularity && is_power_of_2(vrdl->granularity));
-    g_assert(container->pgsizes &&
-             vrdl->granularity >= 1ULL << ctz64(container->pgsizes));
+    g_assert(bcontainer->pgsizes &&
+             vrdl->granularity >= 1ULL << ctz64(bcontainer->pgsizes));
 
     ram_discard_listener_init(&vrdl->listener,
                               vfio_ram_discard_notify_populate,
@@ -441,7 +442,7 @@ static void vfio_register_ram_discard_listener(VFIOContainer *container,
      * number of sections in the address space we could have over time,
      * also consuming DMA mappings.
      */
-    if (container->dma_max_mappings) {
+    if (bcontainer->dma_max_mappings) {
         unsigned int vrdl_count = 0, vrdl_mappings = 0, max_memslots = 512;
 
 #ifdef CONFIG_KVM
@@ -462,11 +463,11 @@ static void vfio_register_ram_discard_listener(VFIOContainer *container,
         }
 
         if (vrdl_mappings + max_memslots - vrdl_count >
-            container->dma_max_mappings) {
+            bcontainer->dma_max_mappings) {
             warn_report("%s: possibly running out of DMA mappings. E.g., try"
                         " increasing the 'block-size' of virtio-mem devies."
                         " Maximum possible DMA mappings: %d, Maximum possible"
-                        " memslots: %d", __func__, container->dma_max_mappings,
+                        " memslots: %d", __func__, bcontainer->dma_max_mappings,
                         max_memslots);
         }
     }
@@ -626,7 +627,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
                             iommu_idx);
 
         ret = memory_region_iommu_set_page_size_mask(giommu->iommu_mr,
-                                                     container->pgsizes,
+                                                     bcontainer->pgsizes,
                                                      &err);
         if (ret) {
             g_free(giommu);
@@ -675,7 +676,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
     llsize = int128_sub(llend, int128_make64(iova));
 
     if (memory_region_is_ram_device(section->mr)) {
-        hwaddr pgmask = (1ULL << ctz64(container->pgsizes)) - 1;
+        hwaddr pgmask = (1ULL << ctz64(bcontainer->pgsizes)) - 1;
 
         if ((iova & pgmask) || (int128_get64(llsize) & pgmask)) {
             trace_vfio_listener_region_add_no_dma_map(
@@ -777,7 +778,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
     if (memory_region_is_ram_device(section->mr)) {
         hwaddr pgmask;
 
-        pgmask = (1ULL << ctz64(container->pgsizes)) - 1;
+        pgmask = (1ULL << ctz64(bcontainer->pgsizes)) - 1;
         try_unmap = !((iova & pgmask) || (int128_get64(llsize) & pgmask));
     } else if (memory_region_has_ram_discard_manager(section->mr)) {
         vfio_unregister_ram_discard_listener(container, section);
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 5d654ae172..dcce111349 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -52,6 +52,7 @@ void vfio_container_init(VFIOContainerBase *bcontainer, VFIOAddressSpace *space,
     bcontainer->ops = ops;
     bcontainer->space = space;
     bcontainer->dirty_pages_supported = false;
+    bcontainer->dma_max_mappings = 0;
     QLIST_INIT(&bcontainer->giommu_list);
 }
 
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 7bd81eab09..c5a6262882 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -154,7 +154,7 @@ static int vfio_legacy_dma_unmap(VFIOContainerBase *bcontainer, hwaddr iova,
         if (errno == EINVAL && unmap.size && !(unmap.iova + unmap.size) &&
             container->iommu_type == VFIO_TYPE1v2_IOMMU) {
             trace_vfio_legacy_dma_unmap_overflow_workaround();
-            unmap.size -= 1ULL << ctz64(container->pgsizes);
+            unmap.size -= 1ULL << ctz64(bcontainer->pgsizes);
             continue;
         }
         error_report("VFIO_UNMAP_DMA failed: %s", strerror(errno));
@@ -559,7 +559,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container = g_malloc0(sizeof(*container));
     container->fd = fd;
     container->error = NULL;
-    container->dma_max_mappings = 0;
     container->iova_ranges = NULL;
     QLIST_INIT(&container->vrdl_list);
     bcontainer = &container->bcontainer;
@@ -589,13 +588,13 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         }
 
         if (info->flags & VFIO_IOMMU_INFO_PGSIZES) {
-            container->pgsizes = info->iova_pgsizes;
+            bcontainer->pgsizes = info->iova_pgsizes;
         } else {
-            container->pgsizes = qemu_real_host_page_size();
+            bcontainer->pgsizes = qemu_real_host_page_size();
         }
 
-        if (!vfio_get_info_dma_avail(info, &container->dma_max_mappings)) {
-            container->dma_max_mappings = 65535;
+        if (!vfio_get_info_dma_avail(info, &bcontainer->dma_max_mappings)) {
+            bcontainer->dma_max_mappings = 65535;
         }
 
         vfio_get_info_iova_range(info, container);
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 83da2f7ec2..4f76bdd3ca 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -226,6 +226,7 @@ static int vfio_spapr_create_window(VFIOContainer *container,
                                     hwaddr *pgsize)
 {
     int ret = 0;
+    VFIOContainerBase *bcontainer = &container->bcontainer;
     IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
     uint64_t pagesize = memory_region_iommu_get_min_page_size(iommu_mr), pgmask;
     unsigned entries, bits_total, bits_per_level, max_levels;
@@ -239,13 +240,13 @@ static int vfio_spapr_create_window(VFIOContainer *container,
     if (pagesize > rampagesize) {
         pagesize = rampagesize;
     }
-    pgmask = container->pgsizes & (pagesize | (pagesize - 1));
+    pgmask = bcontainer->pgsizes & (pagesize | (pagesize - 1));
     pagesize = pgmask ? (1ULL << (63 - clz64(pgmask))) : 0;
     if (!pagesize) {
         error_report("Host doesn't support page size 0x%"PRIx64
                      ", the supported mask is 0x%lx",
                      memory_region_iommu_get_min_page_size(iommu_mr),
-                     container->pgsizes);
+                     bcontainer->pgsizes);
         return -EINVAL;
     }
 
@@ -421,6 +422,7 @@ void vfio_container_del_section_window(VFIOContainer *container,
 
 int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
 {
+    VFIOContainerBase *bcontainer = &container->bcontainer;
     struct vfio_iommu_spapr_tce_info info;
     bool v2 = container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU;
     int ret, fd = container->fd;
@@ -461,7 +463,7 @@ int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
     }
 
     if (v2) {
-        container->pgsizes = info.ddw.pgsizes;
+        bcontainer->pgsizes = info.ddw.pgsizes;
         /*
          * There is a default window in just created container.
          * To make region_add/del simpler, we better remove this
@@ -476,7 +478,7 @@ int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
         }
     } else {
         /* The default table uses 4K pages */
-        container->pgsizes = 0x1000;
+        bcontainer->pgsizes = 0x1000;
         vfio_host_win_add(container, info.dma32_window_start,
                           info.dma32_window_start +
                           info.dma32_window_size - 1,
-- 
2.34.1


