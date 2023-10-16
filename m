Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 476667CA28F
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:51:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJH7-0008JX-8k; Mon, 16 Oct 2023 04:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJGn-00081Q-Kz; Mon, 16 Oct 2023 04:48:15 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJGk-0001Al-R6; Mon, 16 Oct 2023 04:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697446090; x=1728982090;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Rj1lV+86wlvl4h1F503Bqf0fwK/5J5WBfjLXGPuAsnM=;
 b=LT+eMfXRDURn1UmXbU5du4DARXJSYefkUdU8gsS6awtwASRvMXCbDOC4
 NZl890bMl6tEtsvLp8Hvk0KVxMYJlGmzLTrhdhkg3a7VAJngIB7HHksCS
 CtBnP4wMgWDSKiLu1NcJ7UCyiCNVw0pmZaosCg3BMj7HvuUQzkyhEjk9a
 /5wG97CvqtyUL89+SK2gdUlFopfUfP9+edtomldGomAZhP7AZoIbWOuBJ
 RmIr5wef+YNPBpeZH9Mu/JLzjHVNGx6af7WlnU+3dvwZFdtH/+rXPcmXk
 8UqsdrTzVwWHo1d+crUxadqEeeuXdwnX/IzwsIFtmN/RofuVakBNgDXHK Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365737627"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="365737627"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:48:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="749222885"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="749222885"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:48:03 -0700
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
Subject: [PATCH v2 12/27] vfio/container: Move vrdl_list,
 pgsizes and dma_max_mappings to base container
Date: Mon, 16 Oct 2023 16:32:08 +0800
Message-Id: <20231016083223.1519410-13-zhenzhong.duan@intel.com>
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

Move vrdl_list, pgsizes and dma_max_mappings to the base
container object

No functional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h         | 13 --------
 include/hw/vfio/vfio-container-base.h | 13 ++++++++
 hw/vfio/common.c                      | 48 +++++++++++++--------------
 hw/vfio/container-base.c              | 12 +++++++
 hw/vfio/container.c                   | 18 +++++-----
 hw/vfio/spapr.c                       |  4 +--
 6 files changed, 59 insertions(+), 49 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 7bb75bc7cd..18dd676a2a 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -85,22 +85,9 @@ typedef struct VFIOLegacyContainer {
     bool initialized;
     uint64_t dirty_pgsizes;
     uint64_t max_dirty_bitmap_size;
-    unsigned long pgsizes;
-    unsigned int dma_max_mappings;
     QLIST_HEAD(, VFIOGroup) group_list;
-    QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
 } VFIOLegacyContainer;
 
-typedef struct VFIORamDiscardListener {
-    VFIOLegacyContainer *container;
-    MemoryRegion *mr;
-    hwaddr offset_within_address_space;
-    hwaddr size;
-    uint64_t granularity;
-    RamDiscardListener listener;
-    QLIST_ENTRY(VFIORamDiscardListener) next;
-} VFIORamDiscardListener;
-
 typedef struct VFIODeviceOps VFIODeviceOps;
 
 typedef struct VFIODevice {
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 49637a1e6c..d6ffd7efc4 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -47,6 +47,16 @@ typedef struct VFIOGuestIOMMU {
     QLIST_ENTRY(VFIOGuestIOMMU) giommu_next;
 } VFIOGuestIOMMU;
 
+typedef struct VFIORamDiscardListener {
+    VFIOContainer *bcontainer;
+    MemoryRegion *mr;
+    hwaddr offset_within_address_space;
+    hwaddr size;
+    uint64_t granularity;
+    RamDiscardListener listener;
+    QLIST_ENTRY(VFIORamDiscardListener) next;
+} VFIORamDiscardListener;
+
 typedef struct VFIOHostDMAWindow {
     hwaddr min_iova;
     hwaddr max_iova;
@@ -66,9 +76,12 @@ typedef struct {
 struct VFIOContainer {
     VFIOIOMMUBackendOpsClass *ops;
     VFIOAddressSpace *space;
+    unsigned long pgsizes;
+    unsigned int dma_max_mappings;
     bool dirty_pages_supported;
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
+    QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
     QLIST_ENTRY(VFIOContainer) next;
     QLIST_HEAD(, VFIODevice) device_list;
 };
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 1c47bcc478..b833def682 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -396,13 +396,13 @@ static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
 {
     VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
                                                 listener);
+    VFIOContainer *bcontainer = vrdl->bcontainer;
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
@@ -414,6 +414,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
 {
     VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
                                                 listener);
+    VFIOContainer *bcontainer = vrdl->bcontainer;
     const hwaddr end = section->offset_within_region +
                        int128_get64(section->size);
     hwaddr start, next, iova;
@@ -432,8 +433,8 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
                section->offset_within_address_space;
         vaddr = memory_region_get_ram_ptr(section->mr) + start;
 
-        ret = vfio_container_dma_map(&vrdl->container->bcontainer, iova,
-                                     next - start, vaddr, section->readonly);
+        ret = vfio_container_dma_map(bcontainer, iova, next - start,
+                                     vaddr, section->readonly);
         if (ret) {
             /* Rollback */
             vfio_ram_discard_notify_discard(rdl, section);
@@ -443,7 +444,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
     return 0;
 }
 
-static void vfio_register_ram_discard_listener(VFIOLegacyContainer *container,
+static void vfio_register_ram_discard_listener(VFIOContainer *bcontainer,
                                                MemoryRegionSection *section)
 {
     RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
@@ -456,7 +457,7 @@ static void vfio_register_ram_discard_listener(VFIOLegacyContainer *container,
     g_assert(QEMU_IS_ALIGNED(int128_get64(section->size), TARGET_PAGE_SIZE));
 
     vrdl = g_new0(VFIORamDiscardListener, 1);
-    vrdl->container = container;
+    vrdl->bcontainer = bcontainer;
     vrdl->mr = section->mr;
     vrdl->offset_within_address_space = section->offset_within_address_space;
     vrdl->size = int128_get64(section->size);
@@ -464,14 +465,14 @@ static void vfio_register_ram_discard_listener(VFIOLegacyContainer *container,
                                                                 section->mr);
 
     g_assert(vrdl->granularity && is_power_of_2(vrdl->granularity));
-    g_assert(container->pgsizes &&
-             vrdl->granularity >= 1ULL << ctz64(container->pgsizes));
+    g_assert(bcontainer->pgsizes &&
+             vrdl->granularity >= 1ULL << ctz64(bcontainer->pgsizes));
 
     ram_discard_listener_init(&vrdl->listener,
                               vfio_ram_discard_notify_populate,
                               vfio_ram_discard_notify_discard, true);
     ram_discard_manager_register_listener(rdm, &vrdl->listener, section);
-    QLIST_INSERT_HEAD(&container->vrdl_list, vrdl, next);
+    QLIST_INSERT_HEAD(&bcontainer->vrdl_list, vrdl, next);
 
     /*
      * Sanity-check if we have a theoretically problematic setup where we could
@@ -486,7 +487,7 @@ static void vfio_register_ram_discard_listener(VFIOLegacyContainer *container,
      * number of sections in the address space we could have over time,
      * also consuming DMA mappings.
      */
-    if (container->dma_max_mappings) {
+    if (bcontainer->dma_max_mappings) {
         unsigned int vrdl_count = 0, vrdl_mappings = 0, max_memslots = 512;
 
 #ifdef CONFIG_KVM
@@ -495,7 +496,7 @@ static void vfio_register_ram_discard_listener(VFIOLegacyContainer *container,
         }
 #endif
 
-        QLIST_FOREACH(vrdl, &container->vrdl_list, next) {
+        QLIST_FOREACH(vrdl, &bcontainer->vrdl_list, next) {
             hwaddr start, end;
 
             start = QEMU_ALIGN_DOWN(vrdl->offset_within_address_space,
@@ -507,23 +508,23 @@ static void vfio_register_ram_discard_listener(VFIOLegacyContainer *container,
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
 }
 
-static void vfio_unregister_ram_discard_listener(VFIOLegacyContainer *container,
+static void vfio_unregister_ram_discard_listener(VFIOContainer *bcontainer,
                                                  MemoryRegionSection *section)
 {
     RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
     VFIORamDiscardListener *vrdl = NULL;
 
-    QLIST_FOREACH(vrdl, &container->vrdl_list, next) {
+    QLIST_FOREACH(vrdl, &bcontainer->vrdl_list, next) {
         if (vrdl->mr == section->mr &&
             vrdl->offset_within_address_space ==
             section->offset_within_address_space) {
@@ -697,7 +698,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
                             iommu_idx);
 
         ret = memory_region_iommu_set_page_size_mask(giommu->iommu_mr,
-                                                     container->pgsizes,
+                                                     bcontainer->pgsizes,
                                                      &err);
         if (ret) {
             g_free(giommu);
@@ -724,7 +725,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
      * about changes.
      */
     if (memory_region_has_ram_discard_manager(section->mr)) {
-        vfio_register_ram_discard_listener(container, section);
+        vfio_register_ram_discard_listener(bcontainer, section);
         return;
     }
 
@@ -848,7 +849,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
         pgmask = (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
         try_unmap = !((iova & pgmask) || (int128_get64(llsize) & pgmask));
     } else if (memory_region_has_ram_discard_manager(section->mr)) {
-        vfio_unregister_ram_discard_listener(container, section);
+        vfio_unregister_ram_discard_listener(bcontainer, section);
         /* Unregistering will trigger an unmap. */
         try_unmap = false;
     }
@@ -1332,18 +1333,17 @@ static int vfio_ram_discard_get_dirty_bitmap(MemoryRegionSection *section,
      * Sync the whole mapped region (spanning multiple individual mappings)
      * in one go.
      */
-    return vfio_get_dirty_bitmap(&vrdl->container->bcontainer, iova, size,
-                                 ram_addr);
+    return vfio_get_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr);
 }
 
 static int
-vfio_sync_ram_discard_listener_dirty_bitmap(VFIOLegacyContainer *container,
-                                                   MemoryRegionSection *section)
+vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainer *bcontainer,
+                                            MemoryRegionSection *section)
 {
     RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
     VFIORamDiscardListener *vrdl = NULL;
 
-    QLIST_FOREACH(vrdl, &container->vrdl_list, next) {
+    QLIST_FOREACH(vrdl, &bcontainer->vrdl_list, next) {
         if (vrdl->mr == section->mr &&
             vrdl->offset_within_address_space ==
             section->offset_within_address_space) {
@@ -1397,7 +1397,7 @@ static int vfio_sync_dirty_bitmap(VFIOLegacyContainer *container,
         }
         return 0;
     } else if (memory_region_has_ram_discard_manager(section->mr)) {
-        return vfio_sync_ram_discard_listener_dirty_bitmap(container, section);
+        return vfio_sync_ram_discard_listener_dirty_bitmap(bcontainer, section);
     }
 
     ram_addr = memory_region_get_ram_addr(section->mr) +
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 530ad42c0d..c5a4c5afed 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -98,17 +98,29 @@ void vfio_container_init(VFIOContainer *bcontainer,
     bcontainer->ops = ops;
     bcontainer->space = space;
     bcontainer->dirty_pages_supported = false;
+    bcontainer->dma_max_mappings = 0;
     QLIST_INIT(&bcontainer->giommu_list);
     QLIST_INIT(&bcontainer->hostwin_list);
+    QLIST_INIT(&bcontainer->vrdl_list);
 }
 
 void vfio_container_destroy(VFIOContainer *bcontainer)
 {
+    VFIORamDiscardListener *vrdl, *vrdl_tmp;
     VFIOGuestIOMMU *giommu, *tmp;
     VFIOHostDMAWindow *hostwin, *next;
 
     QLIST_REMOVE(bcontainer, next);
 
+    QLIST_FOREACH_SAFE(vrdl, &bcontainer->vrdl_list, next, vrdl_tmp) {
+        RamDiscardManager *rdm;
+
+        rdm = memory_region_get_ram_discard_manager(vrdl->mr);
+        ram_discard_manager_unregister_listener(rdm, &vrdl->listener);
+        QLIST_REMOVE(vrdl, next);
+        g_free(vrdl);
+    }
+
     QLIST_FOREACH_SAFE(giommu, &bcontainer->giommu_list, giommu_next, tmp) {
         memory_region_unregister_iommu_notifier(
                 MEMORY_REGION(giommu->iommu_mr), &giommu->n);
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index e278321c0a..66fad1c280 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -162,7 +162,7 @@ static int vfio_legacy_dma_unmap(VFIOContainer *bcontainer, hwaddr iova,
         if (errno == EINVAL && unmap.size && !(unmap.iova + unmap.size) &&
             container->iommu_type == VFIO_TYPE1v2_IOMMU) {
             trace_vfio_legacy_dma_unmap_overflow_workaround();
-            unmap.size -= 1ULL << ctz64(container->pgsizes);
+            unmap.size -= 1ULL << ctz64(container->bcontainer.pgsizes);
             continue;
         }
         error_report("VFIO_UNMAP_DMA failed: %s", strerror(errno));
@@ -642,8 +642,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container = g_malloc0(sizeof(*container));
     container->fd = fd;
     container->error = NULL;
-    container->dma_max_mappings = 0;
-    QLIST_INIT(&container->vrdl_list);
     bcontainer = &container->bcontainer;
     vfio_container_init(bcontainer, space, ops);
 
@@ -671,13 +669,13 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         }
 
         if (info->flags & VFIO_IOMMU_INFO_PGSIZES) {
-            container->pgsizes = info->iova_pgsizes;
+            container->bcontainer.pgsizes = info->iova_pgsizes;
         } else {
-            container->pgsizes = qemu_real_host_page_size();
+            container->bcontainer.pgsizes = qemu_real_host_page_size();
         }
 
-        if (!vfio_get_info_dma_avail(info, &container->dma_max_mappings)) {
-            container->dma_max_mappings = 65535;
+        if (!vfio_get_info_dma_avail(info, &bcontainer->dma_max_mappings)) {
+            container->bcontainer.dma_max_mappings = 65535;
         }
         vfio_get_iommu_info_migration(container, info);
         g_free(info);
@@ -687,7 +685,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
          * information to get the actual window extent rather than assume
          * a 64-bit IOVA address space.
          */
-        vfio_host_win_add(bcontainer, 0, (hwaddr)-1, container->pgsizes);
+        vfio_host_win_add(bcontainer, 0, (hwaddr)-1, bcontainer->pgsizes);
 
         break;
     }
@@ -736,7 +734,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         }
 
         if (v2) {
-            container->pgsizes = info.ddw.pgsizes;
+            container->bcontainer.pgsizes = info.ddw.pgsizes;
             /*
              * There is a default window in just created container.
              * To make region_add/del simpler, we better remove this
@@ -751,7 +749,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
             }
         } else {
             /* The default table uses 4K pages */
-            container->pgsizes = 0x1000;
+            container->bcontainer.pgsizes = 0x1000;
             vfio_host_win_add(bcontainer, info.dma32_window_start,
                               info.dma32_window_start +
                               info.dma32_window_size - 1,
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 683252c506..3fdad9d227 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -159,13 +159,13 @@ int vfio_spapr_create_window(VFIOLegacyContainer *container,
     if (pagesize > rampagesize) {
         pagesize = rampagesize;
     }
-    pgmask = container->pgsizes & (pagesize | (pagesize - 1));
+    pgmask = container->bcontainer.pgsizes & (pagesize | (pagesize - 1));
     pagesize = pgmask ? (1ULL << (63 - clz64(pgmask))) : 0;
     if (!pagesize) {
         error_report("Host doesn't support page size 0x%"PRIx64
                      ", the supported mask is 0x%lx",
                      memory_region_iommu_get_min_page_size(iommu_mr),
-                     container->pgsizes);
+                     container->bcontainer.pgsizes);
         return -EINVAL;
     }
 
-- 
2.34.1


