Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC39C7D8113
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 12:47:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvxtF-0007bN-9D; Thu, 26 Oct 2023 06:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxtB-0007ZD-Bt
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:46:57 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxt9-0001Kb-Ag
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698317215; x=1729853215;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GNRoFOe2mM/Er3WizCkJ+kBqmS/CXS+CIzmjKihYMio=;
 b=eXJ7CpOzWF1MmNN2ORNaslmS4jJxV1XZz2vtrRIUlWTZUBwMHNq815NC
 XW8AIwLN24AZCrtoyOl368AL4QHwNpyEg3twzqrl7mmoa9De9oYJQLWSu
 t4KtRrjdGAhHPNgAxcVUKfj6PcP32KDdIdcYU6TcmpA9Jp3ZTJ9lDqxMu
 sh6gXDFiEWfFiObFYiHKobXlvJtgwZWvTOb401Tn7rcFSwV6nExLZFnGN
 ELUsWprXQ3s91FmkXCtjRGrJBunqssHnN23VZMRfcrUwEewoap0W2N8tT
 EkXbnnVrepwsZAM/JmjIZwM/6CCUSiHbe4+5sOJzaxMU9zFxO2OAIyjmX w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="372563318"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; d="scan'208";a="372563318"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:46:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="463647"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:46:40 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 11/37] vfio/container: Switch to IOMMU BE
 set_dirty_page_tracking/query_dirty_bitmap API
Date: Thu, 26 Oct 2023 18:30:38 +0800
Message-Id: <20231026103104.1686921-12-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Eric Auger <eric.auger@redhat.com>

dirty_pages_supported field is also moved to the base container

No fucntional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h         |  6 ------
 include/hw/vfio/vfio-container-base.h |  6 ++++++
 hw/vfio/common.c                      | 12 ++++++++----
 hw/vfio/container-base.c              | 23 +++++++++++++++++++++++
 hw/vfio/container.c                   | 21 ++++++++++++++-------
 5 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 857d2b8076..d053c61872 100644
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
index a5fef3e6a8..ea8436a064 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -50,6 +50,7 @@ typedef struct VFIOAddressSpace {
 typedef struct VFIOContainerBase {
     const VFIOIOMMUOps *ops;
     VFIOAddressSpace *space;
+    bool dirty_pages_supported;
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
     QLIST_ENTRY(VFIOContainerBase) next;
 } VFIOContainerBase;
@@ -68,6 +69,11 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
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
index f87a0dcec3..7d9b87fc67 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1081,7 +1081,8 @@ static void vfio_listener_log_global_start(MemoryListener *listener)
     if (vfio_devices_all_device_dirty_tracking(container)) {
         ret = vfio_devices_dma_logging_start(container);
     } else {
-        ret = vfio_set_dirty_page_tracking(container, true);
+        ret = vfio_container_set_dirty_page_tracking(&container->bcontainer,
+                                                     true);
     }
 
     if (ret) {
@@ -1099,7 +1100,8 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
     if (vfio_devices_all_device_dirty_tracking(container)) {
         vfio_devices_dma_logging_stop(container);
     } else {
-        ret = vfio_set_dirty_page_tracking(container, false);
+        ret = vfio_container_set_dirty_page_tracking(&container->bcontainer,
+                                                     false);
     }
 
     if (ret) {
@@ -1167,7 +1169,8 @@ int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
     VFIOBitmap vbmap;
     int ret;
 
-    if (!container->dirty_pages_supported && !all_device_dirty_tracking) {
+    if (!container->bcontainer.dirty_pages_supported &&
+        !all_device_dirty_tracking) {
         cpu_physical_memory_set_dirty_range(ram_addr, size,
                                             tcg_enabled() ? DIRTY_CLIENTS_ALL :
                                             DIRTY_CLIENTS_NOCODE);
@@ -1182,7 +1185,8 @@ int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
     if (all_device_dirty_tracking) {
         ret = vfio_devices_query_dirty_bitmap(container, &vbmap, iova, size);
     } else {
-        ret = vfio_query_dirty_bitmap(container, &vbmap, iova, size);
+        ret = vfio_container_query_dirty_bitmap(&container->bcontainer, &vbmap,
+                                                iova, size);
     }
 
     if (ret) {
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 99b2957d7b..a7cf517dd2 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -48,11 +48,34 @@ int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
     return bcontainer->ops->dma_unmap(bcontainer, iova, size, iotlb);
 }
 
+int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
+                                           bool start)
+{
+    /* Fallback to all pages dirty if dirty page sync isn't supported */
+    if (!bcontainer->ops->set_dirty_page_tracking) {
+        return 0;
+    }
+
+    return bcontainer->ops->set_dirty_page_tracking(bcontainer, start);
+}
+
+int vfio_container_query_dirty_bitmap(VFIOContainerBase *bcontainer,
+                                      VFIOBitmap *vbmap,
+                                      hwaddr iova, hwaddr size)
+{
+    if (!bcontainer->ops->query_dirty_bitmap) {
+        return -EINVAL;
+    }
+
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
index 761310fa51..6f02ca133e 100644
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
@@ -938,4 +943,6 @@ void vfio_detach_device(VFIODevice *vbasedev)
 const VFIOIOMMUOps vfio_legacy_ops = {
     .dma_map = vfio_legacy_dma_map,
     .dma_unmap = vfio_legacy_dma_unmap,
+    .set_dirty_page_tracking = vfio_legacy_set_dirty_page_tracking,
+    .query_dirty_bitmap = vfio_legacy_query_dirty_bitmap,
 };
-- 
2.34.1


