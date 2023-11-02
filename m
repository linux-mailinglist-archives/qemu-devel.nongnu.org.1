Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F8D7DED45
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:30:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyS99-0003nn-Dc; Thu, 02 Nov 2023 03:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS93-0003UW-RR
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:29:38 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS91-0003OA-Uh
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698910175; x=1730446175;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9p/nY/JHKHl9Dombgfsh3VRNf+QMpQ4oRhV9AFjEKEA=;
 b=NsW6qx8WKeLxkDySi/nPHB4VgfMpainGGnjRLwOiw/BwTg5kd1ctNDJs
 e+C6u3sM8a8IAd6nEfoPfFFUODmyPCEVWxQJDRGZBrB9nfr4VPAQVXiCw
 jighwSYGgJB8PG3rdi/7iQGKGxe4W4mxRyY7dEsqNdQBprcKimDH6oI7G
 A1IlGs6Q5o/hlRAqcJzr3WCtNscWg6fICS6LIRPC1yYk48mUJV8mukHTx
 9+1b3/Qs/oD+HIhGfbSC/vJ0a1tF6FQMr6P8g7ABiDdHhMJWcCGszqM71
 1sNFYR+CY8e5z+DuL6to8mhJEiCz5Pi0ZWP3FnbrKdOutnlxWj1oylwqZ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452953185"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="452953185"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:29:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711055402"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="711055402"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:29:30 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 16/41] vfio/container: Move vrdl_list to base container
Date: Thu,  2 Nov 2023 15:12:37 +0800
Message-Id: <20231102071302.1818071-17-zhenzhong.duan@intel.com>
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

No functional change intended.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h         | 11 --------
 include/hw/vfio/vfio-container-base.h | 11 ++++++++
 hw/vfio/common.c                      | 38 +++++++++++++--------------
 hw/vfio/container-base.c              |  1 +
 hw/vfio/container.c                   |  1 -
 5 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index d3dc2f9dcb..8a607a4c17 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -87,20 +87,9 @@ typedef struct VFIOContainer {
     uint64_t max_dirty_bitmap_size;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     QLIST_HEAD(, VFIOGroup) group_list;
-    QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
     GList *iova_ranges;
 } VFIOContainer;
 
-typedef struct VFIORamDiscardListener {
-    VFIOContainer *container;
-    MemoryRegion *mr;
-    hwaddr offset_within_address_space;
-    hwaddr size;
-    uint64_t granularity;
-    RamDiscardListener listener;
-    QLIST_ENTRY(VFIORamDiscardListener) next;
-} VFIORamDiscardListener;
-
 typedef struct VFIOHostDMAWindow {
     hwaddr min_iova;
     hwaddr max_iova;
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 85ec7e1a56..8e05b5ac5a 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -40,6 +40,7 @@ typedef struct VFIOContainerBase {
     unsigned int dma_max_mappings;
     bool dirty_pages_supported;
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
+    QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
     QLIST_ENTRY(VFIOContainerBase) next;
     QLIST_HEAD(, VFIODevice) device_list;
 } VFIOContainerBase;
@@ -52,6 +53,16 @@ typedef struct VFIOGuestIOMMU {
     QLIST_ENTRY(VFIOGuestIOMMU) giommu_next;
 } VFIOGuestIOMMU;
 
+typedef struct VFIORamDiscardListener {
+    VFIOContainerBase *bcontainer;
+    MemoryRegion *mr;
+    hwaddr offset_within_address_space;
+    hwaddr size;
+    uint64_t granularity;
+    RamDiscardListener listener;
+    QLIST_ENTRY(VFIORamDiscardListener) next;
+} VFIORamDiscardListener;
+
 int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            hwaddr iova, ram_addr_t size,
                            void *vaddr, bool readonly);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 1cb53d369e..f15665789f 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -351,13 +351,13 @@ static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
 {
     VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
                                                 listener);
+    VFIOContainerBase *bcontainer = vrdl->bcontainer;
     const hwaddr size = int128_get64(section->size);
     const hwaddr iova = section->offset_within_address_space;
     int ret;
 
     /* Unmap with a single call. */
-    ret = vfio_container_dma_unmap(&vrdl->container->bcontainer,
-                                   iova, size , NULL);
+    ret = vfio_container_dma_unmap(bcontainer, iova, size , NULL);
     if (ret) {
         error_report("%s: vfio_container_dma_unmap() failed: %s", __func__,
                      strerror(-ret));
@@ -369,6 +369,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
 {
     VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
                                                 listener);
+    VFIOContainerBase *bcontainer = vrdl->bcontainer;
     const hwaddr end = section->offset_within_region +
                        int128_get64(section->size);
     hwaddr start, next, iova;
@@ -387,8 +388,8 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
                section->offset_within_address_space;
         vaddr = memory_region_get_ram_ptr(section->mr) + start;
 
-        ret = vfio_container_dma_map(&vrdl->container->bcontainer, iova,
-                                     next - start, vaddr, section->readonly);
+        ret = vfio_container_dma_map(bcontainer, iova, next - start,
+                                     vaddr, section->readonly);
         if (ret) {
             /* Rollback */
             vfio_ram_discard_notify_discard(rdl, section);
@@ -398,10 +399,9 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
     return 0;
 }
 
-static void vfio_register_ram_discard_listener(VFIOContainer *container,
+static void vfio_register_ram_discard_listener(VFIOContainerBase *bcontainer,
                                                MemoryRegionSection *section)
 {
-    VFIOContainerBase *bcontainer = &container->bcontainer;
     RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
     VFIORamDiscardListener *vrdl;
 
@@ -412,7 +412,7 @@ static void vfio_register_ram_discard_listener(VFIOContainer *container,
     g_assert(QEMU_IS_ALIGNED(int128_get64(section->size), TARGET_PAGE_SIZE));
 
     vrdl = g_new0(VFIORamDiscardListener, 1);
-    vrdl->container = container;
+    vrdl->bcontainer = bcontainer;
     vrdl->mr = section->mr;
     vrdl->offset_within_address_space = section->offset_within_address_space;
     vrdl->size = int128_get64(section->size);
@@ -427,7 +427,7 @@ static void vfio_register_ram_discard_listener(VFIOContainer *container,
                               vfio_ram_discard_notify_populate,
                               vfio_ram_discard_notify_discard, true);
     ram_discard_manager_register_listener(rdm, &vrdl->listener, section);
-    QLIST_INSERT_HEAD(&container->vrdl_list, vrdl, next);
+    QLIST_INSERT_HEAD(&bcontainer->vrdl_list, vrdl, next);
 
     /*
      * Sanity-check if we have a theoretically problematic setup where we could
@@ -451,7 +451,7 @@ static void vfio_register_ram_discard_listener(VFIOContainer *container,
         }
 #endif
 
-        QLIST_FOREACH(vrdl, &container->vrdl_list, next) {
+        QLIST_FOREACH(vrdl, &bcontainer->vrdl_list, next) {
             hwaddr start, end;
 
             start = QEMU_ALIGN_DOWN(vrdl->offset_within_address_space,
@@ -473,13 +473,13 @@ static void vfio_register_ram_discard_listener(VFIOContainer *container,
     }
 }
 
-static void vfio_unregister_ram_discard_listener(VFIOContainer *container,
+static void vfio_unregister_ram_discard_listener(VFIOContainerBase *bcontainer,
                                                  MemoryRegionSection *section)
 {
     RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
     VFIORamDiscardListener *vrdl = NULL;
 
-    QLIST_FOREACH(vrdl, &container->vrdl_list, next) {
+    QLIST_FOREACH(vrdl, &bcontainer->vrdl_list, next) {
         if (vrdl->mr == section->mr &&
             vrdl->offset_within_address_space ==
             section->offset_within_address_space) {
@@ -663,7 +663,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
      * about changes.
      */
     if (memory_region_has_ram_discard_manager(section->mr)) {
-        vfio_register_ram_discard_listener(container, section);
+        vfio_register_ram_discard_listener(bcontainer, section);
         return;
     }
 
@@ -781,7 +781,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
         pgmask = (1ULL << ctz64(bcontainer->pgsizes)) - 1;
         try_unmap = !((iova & pgmask) || (int128_get64(llsize) & pgmask));
     } else if (memory_region_has_ram_discard_manager(section->mr)) {
-        vfio_unregister_ram_discard_listener(container, section);
+        vfio_unregister_ram_discard_listener(bcontainer, section);
         /* Unregistering will trigger an unmap. */
         try_unmap = false;
     }
@@ -1260,17 +1260,17 @@ static int vfio_ram_discard_get_dirty_bitmap(MemoryRegionSection *section,
      * Sync the whole mapped region (spanning multiple individual mappings)
      * in one go.
      */
-    return vfio_get_dirty_bitmap(&vrdl->container->bcontainer, iova, size,
-                                 ram_addr);
+    return vfio_get_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr);
 }
 
-static int vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainer *container,
-                                                   MemoryRegionSection *section)
+static int
+vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainerBase *bcontainer,
+                                            MemoryRegionSection *section)
 {
     RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
     VFIORamDiscardListener *vrdl = NULL;
 
-    QLIST_FOREACH(vrdl, &container->vrdl_list, next) {
+    QLIST_FOREACH(vrdl, &bcontainer->vrdl_list, next) {
         if (vrdl->mr == section->mr &&
             vrdl->offset_within_address_space ==
             section->offset_within_address_space) {
@@ -1324,7 +1324,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainer *container,
         }
         return 0;
     } else if (memory_region_has_ram_discard_manager(section->mr)) {
-        return vfio_sync_ram_discard_listener_dirty_bitmap(container, section);
+        return vfio_sync_ram_discard_listener_dirty_bitmap(bcontainer, section);
     }
 
     ram_addr = memory_region_get_ram_addr(section->mr) +
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index dcce111349..584eee4ba1 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -54,6 +54,7 @@ void vfio_container_init(VFIOContainerBase *bcontainer, VFIOAddressSpace *space,
     bcontainer->dirty_pages_supported = false;
     bcontainer->dma_max_mappings = 0;
     QLIST_INIT(&bcontainer->giommu_list);
+    QLIST_INIT(&bcontainer->vrdl_list);
 }
 
 void vfio_container_destroy(VFIOContainerBase *bcontainer)
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index c5a6262882..6ba2e2f8c4 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -560,7 +560,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container->fd = fd;
     container->error = NULL;
     container->iova_ranges = NULL;
-    QLIST_INIT(&container->vrdl_list);
     bcontainer = &container->bcontainer;
     vfio_container_init(bcontainer, space, &vfio_legacy_ops);
 
-- 
2.34.1


