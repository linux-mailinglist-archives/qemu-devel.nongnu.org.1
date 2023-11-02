Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5479F7DED54
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:31:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyS8o-0003Qh-Q7; Thu, 02 Nov 2023 03:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS8m-0003QW-Fh
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:29:20 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS8k-0003Iu-Az
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698910158; x=1730446158;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ctq67vD+99Xopap7tH2d0vKzlrZ5Ssejmx6yfYitmAk=;
 b=ZYCveTV/ZGPmpM7LZCjMk4XjE5XzCzwP3Wo8jsk0fRSmTHnQHRI11gLJ
 U1j8bWodAb39aSYjzOdoJfQyfDqaxHV1KrlOjvfx0dWXUPJoAp/tLsyAL
 JzbtieXaWP1uywDLqksFCujsMCnr/Hzyjrw/pQvPmFdAj2lmQ6GeZYEeZ
 L0wSQ7fn27NMBKjbXx+1E7x0uD+r6H+tP/ONnRmODw/3gBaBqbLR3P5EI
 2XRj4micSMBFyrvIe07tS292EhLUtyaEuBRhxqV2jlYpARpSPl8+bxQBg
 L7cWq/f6wmG7N088dBa7bTpzmuPu/L6FXfVhFTQVWG7INAkcg/Jx9aPX7 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452953144"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="452953144"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:29:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711055339"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="711055339"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:29:13 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 12/41] vfio/container: Switch to IOMMU BE
 set_dirty_page_tracking/query_dirty_bitmap API
Date: Thu,  2 Nov 2023 15:12:33 +0800
Message-Id: <20231102071302.1818071-13-zhenzhong.duan@intel.com>
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

dirty_pages_supported field is also moved to the base container

No fucntional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
v4: use assert

 include/hw/vfio/vfio-common.h         |  6 ------
 include/hw/vfio/vfio-container-base.h |  6 ++++++
 hw/vfio/common.c                      | 12 ++++++++----
 hw/vfio/container-base.c              | 16 ++++++++++++++++
 hw/vfio/container.c                   | 21 ++++++++++++++-------
 5 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index bd4de6cb3a..60f2785fe0 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -83,7 +83,6 @@ typedef struct VFIOContainer {
     unsigned iommu_type;
     Error *error;
     bool initialized;
-    bool dirty_pages_supported;
     uint64_t dirty_pgsizes;
     uint64_t max_dirty_bitmap_size;
     unsigned long pgsizes;
@@ -190,11 +189,6 @@ VFIOAddressSpace *vfio_get_address_space(AddressSpace *as);
 void vfio_put_address_space(VFIOAddressSpace *space);
 bool vfio_devices_all_running_and_saving(VFIOContainer *container);
 
-/* container->fd */
-int vfio_set_dirty_page_tracking(VFIOContainer *container, bool start);
-int vfio_query_dirty_bitmap(VFIOContainer *container, VFIOBitmap *vbmap,
-                            hwaddr iova, hwaddr size);
-
 /* SPAPR specific */
 int vfio_container_add_section_window(VFIOContainer *container,
                                       MemoryRegionSection *section,
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index c7cc6ec9c5..f244f003d0 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -36,6 +36,7 @@ typedef struct VFIOAddressSpace {
 typedef struct VFIOContainerBase {
     const VFIOIOMMUOps *ops;
     VFIOAddressSpace *space;
+    bool dirty_pages_supported;
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
     QLIST_ENTRY(VFIOContainerBase) next;
 } VFIOContainerBase;
@@ -54,6 +55,11 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
                              IOMMUTLBEntry *iotlb);
+int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
+                                           bool start);
+int vfio_container_query_dirty_bitmap(VFIOContainerBase *bcontainer,
+                                      VFIOBitmap *vbmap,
+                                      hwaddr iova, hwaddr size);
 
 void vfio_container_init(VFIOContainerBase *bcontainer,
                          VFIOAddressSpace *space,
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 1d8202537e..b1a875ca93 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1079,7 +1079,8 @@ static void vfio_listener_log_global_start(MemoryListener *listener)
     if (vfio_devices_all_device_dirty_tracking(container)) {
         ret = vfio_devices_dma_logging_start(container);
     } else {
-        ret = vfio_set_dirty_page_tracking(container, true);
+        ret = vfio_container_set_dirty_page_tracking(&container->bcontainer,
+                                                     true);
     }
 
     if (ret) {
@@ -1097,7 +1098,8 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
     if (vfio_devices_all_device_dirty_tracking(container)) {
         vfio_devices_dma_logging_stop(container);
     } else {
-        ret = vfio_set_dirty_page_tracking(container, false);
+        ret = vfio_container_set_dirty_page_tracking(&container->bcontainer,
+                                                     false);
     }
 
     if (ret) {
@@ -1165,7 +1167,8 @@ int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
     VFIOBitmap vbmap;
     int ret;
 
-    if (!container->dirty_pages_supported && !all_device_dirty_tracking) {
+    if (!container->bcontainer.dirty_pages_supported &&
+        !all_device_dirty_tracking) {
         cpu_physical_memory_set_dirty_range(ram_addr, size,
                                             tcg_enabled() ? DIRTY_CLIENTS_ALL :
                                             DIRTY_CLIENTS_NOCODE);
@@ -1180,7 +1183,8 @@ int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
     if (all_device_dirty_tracking) {
         ret = vfio_devices_query_dirty_bitmap(container, &vbmap, iova, size);
     } else {
-        ret = vfio_query_dirty_bitmap(container, &vbmap, iova, size);
+        ret = vfio_container_query_dirty_bitmap(&container->bcontainer, &vbmap,
+                                                iova, size);
     }
 
     if (ret) {
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 3933391e0d..5d654ae172 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -31,11 +31,27 @@ int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
     return bcontainer->ops->dma_unmap(bcontainer, iova, size, iotlb);
 }
 
+int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
+                                           bool start)
+{
+    g_assert(bcontainer->ops->set_dirty_page_tracking);
+    return bcontainer->ops->set_dirty_page_tracking(bcontainer, start);
+}
+
+int vfio_container_query_dirty_bitmap(VFIOContainerBase *bcontainer,
+                                      VFIOBitmap *vbmap,
+                                      hwaddr iova, hwaddr size)
+{
+    g_assert(bcontainer->ops->query_dirty_bitmap);
+    return bcontainer->ops->query_dirty_bitmap(bcontainer, vbmap, iova, size);
+}
+
 void vfio_container_init(VFIOContainerBase *bcontainer, VFIOAddressSpace *space,
                          const VFIOIOMMUOps *ops)
 {
     bcontainer->ops = ops;
     bcontainer->space = space;
+    bcontainer->dirty_pages_supported = false;
     QLIST_INIT(&bcontainer->giommu_list);
 }
 
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index f12fcb6fe1..3ab74e2615 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -131,7 +131,7 @@ static int vfio_legacy_dma_unmap(VFIOContainerBase *bcontainer, hwaddr iova,
 
     if (iotlb && vfio_devices_all_running_and_mig_active(container)) {
         if (!vfio_devices_all_device_dirty_tracking(container) &&
-            container->dirty_pages_supported) {
+            container->bcontainer.dirty_pages_supported) {
             return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
         }
 
@@ -205,14 +205,17 @@ static int vfio_legacy_dma_map(VFIOContainerBase *bcontainer, hwaddr iova,
     return -errno;
 }
 
-int vfio_set_dirty_page_tracking(VFIOContainer *container, bool start)
+static int vfio_legacy_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
+                                               bool start)
 {
+    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
+                                            bcontainer);
     int ret;
     struct vfio_iommu_type1_dirty_bitmap dirty = {
         .argsz = sizeof(dirty),
     };
 
-    if (!container->dirty_pages_supported) {
+    if (!bcontainer->dirty_pages_supported) {
         return 0;
     }
 
@@ -232,9 +235,12 @@ int vfio_set_dirty_page_tracking(VFIOContainer *container, bool start)
     return ret;
 }
 
-int vfio_query_dirty_bitmap(VFIOContainer *container, VFIOBitmap *vbmap,
-                            hwaddr iova, hwaddr size)
+static int vfio_legacy_query_dirty_bitmap(VFIOContainerBase *bcontainer,
+                                          VFIOBitmap *vbmap,
+                                          hwaddr iova, hwaddr size)
 {
+    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
+                                            bcontainer);
     struct vfio_iommu_type1_dirty_bitmap *dbitmap;
     struct vfio_iommu_type1_dirty_bitmap_get *range;
     int ret;
@@ -461,7 +467,7 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
      * qemu_real_host_page_size to mark those dirty.
      */
     if (cap_mig->pgsize_bitmap & qemu_real_host_page_size()) {
-        container->dirty_pages_supported = true;
+        container->bcontainer.dirty_pages_supported = true;
         container->max_dirty_bitmap_size = cap_mig->max_dirty_bitmap_size;
         container->dirty_pgsizes = cap_mig->pgsize_bitmap;
     }
@@ -553,7 +559,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container = g_malloc0(sizeof(*container));
     container->fd = fd;
     container->error = NULL;
-    container->dirty_pages_supported = false;
     container->dma_max_mappings = 0;
     container->iova_ranges = NULL;
     QLIST_INIT(&container->vrdl_list);
@@ -937,4 +942,6 @@ void vfio_detach_device(VFIODevice *vbasedev)
 const VFIOIOMMUOps vfio_legacy_ops = {
     .dma_map = vfio_legacy_dma_map,
     .dma_unmap = vfio_legacy_dma_unmap,
+    .set_dirty_page_tracking = vfio_legacy_set_dirty_page_tracking,
+    .query_dirty_bitmap = vfio_legacy_query_dirty_bitmap,
 };
-- 
2.34.1


