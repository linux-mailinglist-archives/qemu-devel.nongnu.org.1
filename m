Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A987CA272
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:49:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJGa-0007jN-7Z; Mon, 16 Oct 2023 04:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJGY-0007iu-8d
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:47:58 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJGW-0001Al-6p
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697446076; x=1728982076;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b4N0W6TutyN/g+zWp0dJTUQb5rH+g3STsV4RonC02Ns=;
 b=Ouefi7Y+CpP7EB0oYomvYWgJFG8Ks3FMhWclKVBE0SrTfkoJLTFaQHlE
 NWlSOC7DWdAfwnIJ7T1LJN4fL7U5aIYFV5bCafehvs/d0PXs5pjdUlIsb
 bfWTpW99dz3scrQ4PjiJX8oSTTmJS66mDU8AN4O4TrY6BU5ASZMK4MwzW
 2uGI8ItiphnSjLu2Z/QHp6dHvvL7sDTtbFUzWWC/39LkFUI9K1jxyu5Ut
 q61ceRvQOYC+dZlWF4WBuRW6ZQn7eC/nhtbGXPTCiXi7mOtW8MgMCLSMw
 /L271AO6ksBGXoEX09RKNxYXe5ygi8XIfJORZ4UCOGx46EqI5lij+PkR2 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365737590"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="365737590"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:47:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="749222852"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="749222852"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:47:51 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 09/27] vfio/container: Switch to IOMMU BE
 set_dirty_page_tracking/query_dirty_bitmap API
Date: Mon, 16 Oct 2023 16:32:05 +0800
Message-Id: <20231016083223.1519410-10-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
References: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.151;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Eric Auger <eric.auger@redhat.com>

dirty_pages_supported field is also moved to the base container

No fucntional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h         |  6 ------
 include/hw/vfio/vfio-container-base.h |  6 ++++++
 hw/vfio/common.c                      | 12 ++++++++----
 hw/vfio/container-base.c              | 23 +++++++++++++++++++++++
 hw/vfio/container.c                   | 23 ++++++++++++++++-------
 5 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 85dbda296a..39bcc7ec33 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -83,7 +83,6 @@ typedef struct VFIOLegacyContainer {
     unsigned iommu_type;
     Error *error;
     bool initialized;
-    bool dirty_pages_supported;
     uint64_t dirty_pgsizes;
     uint64_t max_dirty_bitmap_size;
     unsigned long pgsizes;
@@ -186,11 +185,6 @@ VFIOAddressSpace *vfio_get_address_space(AddressSpace *as);
 void vfio_put_address_space(VFIOAddressSpace *space);
 bool vfio_devices_all_running_and_saving(VFIOLegacyContainer *container);
 
-/* container->fd */
-int vfio_set_dirty_page_tracking(VFIOLegacyContainer *container, bool start);
-int vfio_query_dirty_bitmap(VFIOLegacyContainer *container, VFIOBitmap *vbmap,
-                            hwaddr iova, hwaddr size);
-
 void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
 void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
 void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 03bffbff73..5ab52774b5 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -66,6 +66,7 @@ typedef struct {
 struct VFIOContainer {
     VFIOIOMMUBackendOpsClass *ops;
     VFIOAddressSpace *space;
+    bool dirty_pages_supported;
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     QLIST_ENTRY(VFIOContainer) next;
@@ -77,6 +78,11 @@ int vfio_container_dma_map(VFIOContainer *bcontainer,
 int vfio_container_dma_unmap(VFIOContainer *bcontainer,
                              hwaddr iova, ram_addr_t size,
                              IOMMUTLBEntry *iotlb);
+int vfio_container_set_dirty_page_tracking(VFIOContainer *bcontainer,
+                                           bool start);
+int vfio_container_query_dirty_bitmap(VFIOContainer *bcontainer,
+                                      VFIOBitmap *vbmap,
+                                      hwaddr iova, hwaddr size);
 int vfio_container_add_section_window(VFIOContainer *bcontainer,
                                       MemoryRegionSection *section,
                                       Error **errp);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 511f538c00..855d6d82d0 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1149,7 +1149,8 @@ static void vfio_listener_log_global_start(MemoryListener *listener)
     if (vfio_devices_all_device_dirty_tracking(container)) {
         ret = vfio_devices_dma_logging_start(container);
     } else {
-        ret = vfio_set_dirty_page_tracking(container, true);
+        ret = vfio_container_set_dirty_page_tracking(&container->bcontainer,
+                                                     true);
     }
 
     if (ret) {
@@ -1169,7 +1170,8 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
     if (vfio_devices_all_device_dirty_tracking(container)) {
         vfio_devices_dma_logging_stop(container);
     } else {
-        ret = vfio_set_dirty_page_tracking(container, false);
+        ret = vfio_container_set_dirty_page_tracking(&container->bcontainer,
+                                                     false);
     }
 
     if (ret) {
@@ -1237,7 +1239,8 @@ int vfio_get_dirty_bitmap(VFIOLegacyContainer *container, uint64_t iova,
     VFIOBitmap vbmap;
     int ret;
 
-    if (!container->dirty_pages_supported && !all_device_dirty_tracking) {
+    if (!container->bcontainer.dirty_pages_supported &&
+        !all_device_dirty_tracking) {
         cpu_physical_memory_set_dirty_range(ram_addr, size,
                                             tcg_enabled() ? DIRTY_CLIENTS_ALL :
                                             DIRTY_CLIENTS_NOCODE);
@@ -1252,7 +1255,8 @@ int vfio_get_dirty_bitmap(VFIOLegacyContainer *container, uint64_t iova,
     if (all_device_dirty_tracking) {
         ret = vfio_devices_query_dirty_bitmap(container, &vbmap, iova, size);
     } else {
-        ret = vfio_query_dirty_bitmap(container, &vbmap, iova, size);
+        ret = vfio_container_query_dirty_bitmap(&container->bcontainer, &vbmap,
+                                                iova, size);
     }
 
     if (ret) {
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 12b256c70e..530ad42c0d 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -48,6 +48,28 @@ int vfio_container_dma_unmap(VFIOContainer *bcontainer,
     return bcontainer->ops->dma_unmap(bcontainer, iova, size, iotlb);
 }
 
+int vfio_container_set_dirty_page_tracking(VFIOContainer *bcontainer,
+                                            bool start)
+{
+    /* Fallback to all pages dirty if dirty page sync isn't supported */
+    if (!bcontainer->ops->set_dirty_page_tracking) {
+        return 0;
+    }
+
+    return bcontainer->ops->set_dirty_page_tracking(bcontainer, start);
+}
+
+int vfio_container_query_dirty_bitmap(VFIOContainer *bcontainer,
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
 int vfio_container_add_section_window(VFIOContainer *bcontainer,
                                       MemoryRegionSection *section,
                                       Error **errp)
@@ -75,6 +97,7 @@ void vfio_container_init(VFIOContainer *bcontainer,
 {
     bcontainer->ops = ops;
     bcontainer->space = space;
+    bcontainer->dirty_pages_supported = false;
     QLIST_INIT(&bcontainer->giommu_list);
     QLIST_INIT(&bcontainer->hostwin_list);
 }
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 5d111f69c9..26617afaa9 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -139,7 +139,7 @@ static int vfio_legacy_dma_unmap(VFIOContainer *bcontainer, hwaddr iova,
 
     if (iotlb && vfio_devices_all_running_and_mig_active(container)) {
         if (!vfio_devices_all_device_dirty_tracking(container) &&
-            container->dirty_pages_supported) {
+            container->bcontainer.dirty_pages_supported) {
             return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
         }
 
@@ -308,14 +308,18 @@ static void vfio_legacy_del_section_window(VFIOContainer *bcontainer,
     }
 }
 
-int vfio_set_dirty_page_tracking(VFIOLegacyContainer *container, bool start)
+static int vfio_legacy_set_dirty_page_tracking(VFIOContainer *bcontainer,
+                                               bool start)
 {
+    VFIOLegacyContainer *container = container_of(bcontainer,
+                                                  VFIOLegacyContainer,
+                                                  bcontainer);
     int ret;
     struct vfio_iommu_type1_dirty_bitmap dirty = {
         .argsz = sizeof(dirty),
     };
 
-    if (!container->dirty_pages_supported) {
+    if (!bcontainer->dirty_pages_supported) {
         return 0;
     }
 
@@ -335,9 +339,13 @@ int vfio_set_dirty_page_tracking(VFIOLegacyContainer *container, bool start)
     return ret;
 }
 
-int vfio_query_dirty_bitmap(VFIOLegacyContainer *container, VFIOBitmap *vbmap,
-                            hwaddr iova, hwaddr size)
+static int vfio_legacy_query_dirty_bitmap(VFIOContainer *bcontainer,
+                                          VFIOBitmap *vbmap,
+                                          hwaddr iova, hwaddr size)
 {
+    VFIOLegacyContainer *container = container_of(bcontainer,
+                                                  VFIOLegacyContainer,
+                                                  bcontainer);
     struct vfio_iommu_type1_dirty_bitmap *dbitmap;
     struct vfio_iommu_type1_dirty_bitmap_get *range;
     int ret;
@@ -546,7 +554,7 @@ static void vfio_get_iommu_info_migration(VFIOLegacyContainer *container,
      * qemu_real_host_page_size to mark those dirty.
      */
     if (cap_mig->pgsize_bitmap & qemu_real_host_page_size()) {
-        container->dirty_pages_supported = true;
+        container->bcontainer.dirty_pages_supported = true;
         container->max_dirty_bitmap_size = cap_mig->max_dirty_bitmap_size;
         container->dirty_pgsizes = cap_mig->pgsize_bitmap;
     }
@@ -634,7 +642,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container = g_malloc0(sizeof(*container));
     container->fd = fd;
     container->error = NULL;
-    container->dirty_pages_supported = false;
     container->dma_max_mappings = 0;
     QLIST_INIT(&container->vrdl_list);
     bcontainer = &container->bcontainer;
@@ -1173,6 +1180,8 @@ static void vfio_iommu_backend_legacy_ops_class_init(ObjectClass *oc,
 
     ops->dma_map = vfio_legacy_dma_map;
     ops->dma_unmap = vfio_legacy_dma_unmap;
+    ops->set_dirty_page_tracking = vfio_legacy_set_dirty_page_tracking;
+    ops->query_dirty_bitmap = vfio_legacy_query_dirty_bitmap;
     ops->add_window = vfio_legacy_add_section_window;
     ops->del_window = vfio_legacy_del_section_window;
 }
-- 
2.34.1


