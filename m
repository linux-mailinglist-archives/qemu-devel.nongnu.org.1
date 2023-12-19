Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8BC81901A
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 19:59:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfI7-0002LW-Lu; Tue, 19 Dec 2023 13:58:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfI5-0002L7-IL
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:58:05 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfI2-000732-RI
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:58:05 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SvmD82WLLz4xR5;
 Wed, 20 Dec 2023 05:58:00 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvmD35952z4xCp;
 Wed, 20 Dec 2023 05:57:55 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Yi Liu <yi.l.liu@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 12/47] vfio/container: Move listener to base container
Date: Tue, 19 Dec 2023 19:56:08 +0100
Message-ID: <20231219185643.725448-13-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219185643.725448-1-clg@redhat.com>
References: <20231219185643.725448-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=7/MV=H6=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Move listener to base container. Also error and initialized fields
are moved at the same time.

No functional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h         |   3 -
 include/hw/vfio/vfio-container-base.h |   3 +
 hw/vfio/common.c                      | 110 +++++++++++++-------------
 hw/vfio/container-base.c              |   1 +
 hw/vfio/container.c                   |  19 +++--
 hw/vfio/spapr.c                       |  11 +--
 6 files changed, 74 insertions(+), 73 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 8a607a4c1762afbd2f9525c69bb9ba83d194d8f6..922022cbc6c69ddb39c7241fc983b959be566d33 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -78,11 +78,8 @@ struct VFIOGroup;
 typedef struct VFIOContainer {
     VFIOContainerBase bcontainer;
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
-    MemoryListener listener;
     MemoryListener prereg_listener;
     unsigned iommu_type;
-    Error *error;
-    bool initialized;
     uint64_t dirty_pgsizes;
     uint64_t max_dirty_bitmap_size;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 8e05b5ac5a1b252365c39310c64e77fd63dbb9ee..95f8d319e0c6cf490a3e92dbf1735ad12b53fc65 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -36,6 +36,9 @@ typedef struct VFIOAddressSpace {
 typedef struct VFIOContainerBase {
     const VFIOIOMMUOps *ops;
     VFIOAddressSpace *space;
+    MemoryListener listener;
+    Error *error;
+    bool initialized;
     unsigned long pgsizes;
     unsigned int dma_max_mappings;
     bool dirty_pages_supported;
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index f15665789fa5f99e0ec440696434679a8142fb48..be623e544b641c0bc202b30ed350911b3ec99078 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -541,7 +541,7 @@ static bool vfio_listener_valid_section(MemoryRegionSection *section,
     return true;
 }
 
-static bool vfio_get_section_iova_range(VFIOContainer *container,
+static bool vfio_get_section_iova_range(VFIOContainerBase *bcontainer,
                                         MemoryRegionSection *section,
                                         hwaddr *out_iova, hwaddr *out_end,
                                         Int128 *out_llend)
@@ -569,8 +569,10 @@ static bool vfio_get_section_iova_range(VFIOContainer *container,
 static void vfio_listener_region_add(MemoryListener *listener,
                                      MemoryRegionSection *section)
 {
-    VFIOContainer *container = container_of(listener, VFIOContainer, listener);
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
+                                                 listener);
+    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
+                                            bcontainer);
     hwaddr iova, end;
     Int128 llend, llsize;
     void *vaddr;
@@ -581,7 +583,8 @@ static void vfio_listener_region_add(MemoryListener *listener,
         return;
     }
 
-    if (!vfio_get_section_iova_range(container, section, &iova, &end, &llend)) {
+    if (!vfio_get_section_iova_range(bcontainer, section, &iova, &end,
+                                     &llend)) {
         if (memory_region_is_ram_device(section->mr)) {
             trace_vfio_listener_region_add_no_dma_map(
                 memory_region_name(section->mr),
@@ -688,13 +691,12 @@ static void vfio_listener_region_add(MemoryListener *listener,
         }
     }
 
-    ret = vfio_container_dma_map(&container->bcontainer,
-                                 iova, int128_get64(llsize), vaddr,
-                                 section->readonly);
+    ret = vfio_container_dma_map(bcontainer, iova, int128_get64(llsize),
+                                 vaddr, section->readonly);
     if (ret) {
         error_setg(&err, "vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
                    "0x%"HWADDR_PRIx", %p) = %d (%s)",
-                   container, iova, int128_get64(llsize), vaddr, ret,
+                   bcontainer, iova, int128_get64(llsize), vaddr, ret,
                    strerror(-ret));
         if (memory_region_is_ram_device(section->mr)) {
             /* Allow unexpected mappings not to be fatal for RAM devices */
@@ -716,9 +718,9 @@ fail:
      * can gracefully fail.  Runtime, there's not much we can do other
      * than throw a hardware error.
      */
-    if (!container->initialized) {
-        if (!container->error) {
-            error_propagate_prepend(&container->error, err,
+    if (!bcontainer->initialized) {
+        if (!bcontainer->error) {
+            error_propagate_prepend(&bcontainer->error, err,
                                     "Region %s: ",
                                     memory_region_name(section->mr));
         } else {
@@ -733,8 +735,10 @@ fail:
 static void vfio_listener_region_del(MemoryListener *listener,
                                      MemoryRegionSection *section)
 {
-    VFIOContainer *container = container_of(listener, VFIOContainer, listener);
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
+                                                 listener);
+    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
+                                            bcontainer);
     hwaddr iova, end;
     Int128 llend, llsize;
     int ret;
@@ -767,7 +771,8 @@ static void vfio_listener_region_del(MemoryListener *listener,
          */
     }
 
-    if (!vfio_get_section_iova_range(container, section, &iova, &end, &llend)) {
+    if (!vfio_get_section_iova_range(bcontainer, section, &iova, &end,
+                                     &llend)) {
         return;
     }
 
@@ -790,22 +795,22 @@ static void vfio_listener_region_del(MemoryListener *listener,
         if (int128_eq(llsize, int128_2_64())) {
             /* The unmap ioctl doesn't accept a full 64-bit span. */
             llsize = int128_rshift(llsize, 1);
-            ret = vfio_container_dma_unmap(&container->bcontainer, iova,
+            ret = vfio_container_dma_unmap(bcontainer, iova,
                                            int128_get64(llsize), NULL);
             if (ret) {
                 error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                              "0x%"HWADDR_PRIx") = %d (%s)",
-                             container, iova, int128_get64(llsize), ret,
+                             bcontainer, iova, int128_get64(llsize), ret,
                              strerror(-ret));
             }
             iova += int128_get64(llsize);
         }
-        ret = vfio_container_dma_unmap(&container->bcontainer, iova,
+        ret = vfio_container_dma_unmap(bcontainer, iova,
                                        int128_get64(llsize), NULL);
         if (ret) {
             error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%s)",
-                         container, iova, int128_get64(llsize), ret,
+                         bcontainer, iova, int128_get64(llsize), ret,
                          strerror(-ret));
         }
     }
@@ -825,16 +830,15 @@ typedef struct VFIODirtyRanges {
 } VFIODirtyRanges;
 
 typedef struct VFIODirtyRangesListener {
-    VFIOContainer *container;
+    VFIOContainerBase *bcontainer;
     VFIODirtyRanges ranges;
     MemoryListener listener;
 } VFIODirtyRangesListener;
 
 static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
-                                     VFIOContainer *container)
+                                     VFIOContainerBase *bcontainer)
 {
     VFIOPCIDevice *pcidev;
-    VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
     Object *owner;
 
@@ -863,7 +867,7 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
     hwaddr iova, end, *min, *max;
 
     if (!vfio_listener_valid_section(section, "tracking_update") ||
-        !vfio_get_section_iova_range(dirty->container, section,
+        !vfio_get_section_iova_range(dirty->bcontainer, section,
                                      &iova, &end, NULL)) {
         return;
     }
@@ -887,7 +891,7 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
      * The alternative would be an IOVATree but that has a much bigger runtime
      * overhead and unnecessary complexity.
      */
-    if (vfio_section_is_vfio_pci(section, dirty->container) &&
+    if (vfio_section_is_vfio_pci(section, dirty->bcontainer) &&
         iova >= UINT32_MAX) {
         min = &range->minpci64;
         max = &range->maxpci64;
@@ -911,7 +915,7 @@ static const MemoryListener vfio_dirty_tracking_listener = {
     .region_add = vfio_dirty_tracking_update,
 };
 
-static void vfio_dirty_tracking_init(VFIOContainer *container,
+static void vfio_dirty_tracking_init(VFIOContainerBase *bcontainer,
                                      VFIODirtyRanges *ranges)
 {
     VFIODirtyRangesListener dirty;
@@ -921,10 +925,10 @@ static void vfio_dirty_tracking_init(VFIOContainer *container,
     dirty.ranges.min64 = UINT64_MAX;
     dirty.ranges.minpci64 = UINT64_MAX;
     dirty.listener = vfio_dirty_tracking_listener;
-    dirty.container = container;
+    dirty.bcontainer = bcontainer;
 
     memory_listener_register(&dirty.listener,
-                             container->bcontainer.space->as);
+                             bcontainer->space->as);
 
     *ranges = dirty.ranges;
 
@@ -936,12 +940,11 @@ static void vfio_dirty_tracking_init(VFIOContainer *container,
     memory_listener_unregister(&dirty.listener);
 }
 
-static void vfio_devices_dma_logging_stop(VFIOContainer *container)
+static void vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
 {
     uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
                               sizeof(uint64_t))] = {};
     struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
-    VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
 
     feature->argsz = sizeof(buf);
@@ -962,7 +965,7 @@ static void vfio_devices_dma_logging_stop(VFIOContainer *container)
 }
 
 static struct vfio_device_feature *
-vfio_device_feature_dma_logging_start_create(VFIOContainer *container,
+vfio_device_feature_dma_logging_start_create(VFIOContainerBase *bcontainer,
                                              VFIODirtyRanges *tracking)
 {
     struct vfio_device_feature *feature;
@@ -1035,16 +1038,15 @@ static void vfio_device_feature_dma_logging_start_destroy(
     g_free(feature);
 }
 
-static int vfio_devices_dma_logging_start(VFIOContainer *container)
+static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer)
 {
     struct vfio_device_feature *feature;
     VFIODirtyRanges ranges;
-    VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
     int ret = 0;
 
-    vfio_dirty_tracking_init(container, &ranges);
-    feature = vfio_device_feature_dma_logging_start_create(container,
+    vfio_dirty_tracking_init(bcontainer, &ranges);
+    feature = vfio_device_feature_dma_logging_start_create(bcontainer,
                                                            &ranges);
     if (!feature) {
         return -errno;
@@ -1067,7 +1069,7 @@ static int vfio_devices_dma_logging_start(VFIOContainer *container)
 
 out:
     if (ret) {
-        vfio_devices_dma_logging_stop(container);
+        vfio_devices_dma_logging_stop(bcontainer);
     }
 
     vfio_device_feature_dma_logging_start_destroy(feature);
@@ -1077,14 +1079,14 @@ out:
 
 static void vfio_listener_log_global_start(MemoryListener *listener)
 {
-    VFIOContainer *container = container_of(listener, VFIOContainer, listener);
+    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
+                                                 listener);
     int ret;
 
-    if (vfio_devices_all_device_dirty_tracking(&container->bcontainer)) {
-        ret = vfio_devices_dma_logging_start(container);
+    if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
+        ret = vfio_devices_dma_logging_start(bcontainer);
     } else {
-        ret = vfio_container_set_dirty_page_tracking(&container->bcontainer,
-                                                     true);
+        ret = vfio_container_set_dirty_page_tracking(bcontainer, true);
     }
 
     if (ret) {
@@ -1096,14 +1098,14 @@ static void vfio_listener_log_global_start(MemoryListener *listener)
 
 static void vfio_listener_log_global_stop(MemoryListener *listener)
 {
-    VFIOContainer *container = container_of(listener, VFIOContainer, listener);
+    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
+                                                 listener);
     int ret = 0;
 
-    if (vfio_devices_all_device_dirty_tracking(&container->bcontainer)) {
-        vfio_devices_dma_logging_stop(container);
+    if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
+        vfio_devices_dma_logging_stop(bcontainer);
     } else {
-        ret = vfio_container_set_dirty_page_tracking(&container->bcontainer,
-                                                     false);
+        ret = vfio_container_set_dirty_page_tracking(bcontainer, false);
     }
 
     if (ret) {
@@ -1214,8 +1216,6 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
                                                 vfio_giommu_dirty_notifier, n);
     VFIOGuestIOMMU *giommu = gdn->giommu;
     VFIOContainerBase *bcontainer = giommu->bcontainer;
-    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                            bcontainer);
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
     ram_addr_t translated_addr;
     int ret = -EINVAL;
@@ -1230,12 +1230,12 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
 
     rcu_read_lock();
     if (vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
-        ret = vfio_get_dirty_bitmap(&container->bcontainer, iova,
-                                    iotlb->addr_mask + 1, translated_addr);
+        ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
+                                    translated_addr);
         if (ret) {
             error_report("vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%s)",
-                         container, iova, iotlb->addr_mask + 1, ret,
+                         bcontainer, iova, iotlb->addr_mask + 1, ret,
                          strerror(-ret));
         }
     }
@@ -1291,10 +1291,9 @@ vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainerBase *bcontainer,
                                                 &vrdl);
 }
 
-static int vfio_sync_dirty_bitmap(VFIOContainer *container,
+static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
                                   MemoryRegionSection *section)
 {
-    VFIOContainerBase *bcontainer = &container->bcontainer;
     ram_addr_t ram_addr;
 
     if (memory_region_is_iommu(section->mr)) {
@@ -1330,7 +1329,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainer *container,
     ram_addr = memory_region_get_ram_addr(section->mr) +
                section->offset_within_region;
 
-    return vfio_get_dirty_bitmap(&container->bcontainer,
+    return vfio_get_dirty_bitmap(bcontainer,
                    REAL_HOST_PAGE_ALIGN(section->offset_within_address_space),
                    int128_get64(section->size), ram_addr);
 }
@@ -1338,15 +1337,16 @@ static int vfio_sync_dirty_bitmap(VFIOContainer *container,
 static void vfio_listener_log_sync(MemoryListener *listener,
         MemoryRegionSection *section)
 {
-    VFIOContainer *container = container_of(listener, VFIOContainer, listener);
+    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
+                                                 listener);
     int ret;
 
     if (vfio_listener_skipped_section(section)) {
         return;
     }
 
-    if (vfio_devices_all_dirty_tracking(&container->bcontainer)) {
-        ret = vfio_sync_dirty_bitmap(container, section);
+    if (vfio_devices_all_dirty_tracking(bcontainer)) {
+        ret = vfio_sync_dirty_bitmap(bcontainer, section);
         if (ret) {
             error_report("vfio: Failed to sync dirty bitmap, err: %d (%s)", ret,
                          strerror(-ret));
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 584eee4ba1170e103fb45003c514084ee3326353..7f508669f5dbdab211bed217c143c2c8387b5ae4 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -51,6 +51,7 @@ void vfio_container_init(VFIOContainerBase *bcontainer, VFIOAddressSpace *space,
 {
     bcontainer->ops = ops;
     bcontainer->space = space;
+    bcontainer->error = NULL;
     bcontainer->dirty_pages_supported = false;
     bcontainer->dma_max_mappings = 0;
     QLIST_INIT(&bcontainer->giommu_list);
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 6ba2e2f8c41e72d24b32f3efa31c9683da18387c..5c1dee8c9f889fb6746449fe4fe611289cb247db 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -453,6 +453,7 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_iommu_type1_info_cap_migration *cap_mig;
+    VFIOContainerBase *bcontainer = &container->bcontainer;
 
     hdr = vfio_get_iommu_info_cap(info, VFIO_IOMMU_TYPE1_INFO_CAP_MIGRATION);
     if (!hdr) {
@@ -467,7 +468,7 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
      * qemu_real_host_page_size to mark those dirty.
      */
     if (cap_mig->pgsize_bitmap & qemu_real_host_page_size()) {
-        container->bcontainer.dirty_pages_supported = true;
+        bcontainer->dirty_pages_supported = true;
         container->max_dirty_bitmap_size = cap_mig->max_dirty_bitmap_size;
         container->dirty_pgsizes = cap_mig->pgsize_bitmap;
     }
@@ -558,7 +559,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
 
     container = g_malloc0(sizeof(*container));
     container->fd = fd;
-    container->error = NULL;
     container->iova_ranges = NULL;
     bcontainer = &container->bcontainer;
     vfio_container_init(bcontainer, space, &vfio_legacy_ops);
@@ -621,25 +621,24 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     group->container = container;
     QLIST_INSERT_HEAD(&container->group_list, group, container_next);
 
-    container->listener = vfio_memory_listener;
-
-    memory_listener_register(&container->listener, bcontainer->space->as);
+    bcontainer->listener = vfio_memory_listener;
+    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
 
-    if (container->error) {
+    if (bcontainer->error) {
         ret = -1;
-        error_propagate_prepend(errp, container->error,
+        error_propagate_prepend(errp, bcontainer->error,
             "memory listener initialization failed: ");
         goto listener_release_exit;
     }
 
-    container->initialized = true;
+    bcontainer->initialized = true;
 
     return 0;
 listener_release_exit:
     QLIST_REMOVE(group, container_next);
     QLIST_REMOVE(bcontainer, next);
     vfio_kvm_device_del_group(group);
-    memory_listener_unregister(&container->listener);
+    memory_listener_unregister(&bcontainer->listener);
     if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU ||
         container->iommu_type == VFIO_SPAPR_TCE_IOMMU) {
         vfio_spapr_container_deinit(container);
@@ -674,7 +673,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
      * group.
      */
     if (QLIST_EMPTY(&container->group_list)) {
-        memory_listener_unregister(&container->listener);
+        memory_listener_unregister(&bcontainer->listener);
         if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU ||
             container->iommu_type == VFIO_SPAPR_TCE_IOMMU) {
             vfio_spapr_container_deinit(container);
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 4f76bdd3cadfd282b7f2a01c19ee772be5627068..7a50975f2598b5e58a3dfae552ee49999516df99 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -46,6 +46,7 @@ static void vfio_prereg_listener_region_add(MemoryListener *listener,
 {
     VFIOContainer *container = container_of(listener, VFIOContainer,
                                             prereg_listener);
+    VFIOContainerBase *bcontainer = &container->bcontainer;
     const hwaddr gpa = section->offset_within_address_space;
     hwaddr end;
     int ret;
@@ -88,9 +89,9 @@ static void vfio_prereg_listener_region_add(MemoryListener *listener,
          * can gracefully fail.  Runtime, there's not much we can do other
          * than throw a hardware error.
          */
-        if (!container->initialized) {
-            if (!container->error) {
-                error_setg_errno(&container->error, -ret,
+        if (!bcontainer->initialized) {
+            if (!bcontainer->error) {
+                error_setg_errno(&bcontainer->error, -ret,
                                  "Memory registering failed");
             }
         } else {
@@ -445,9 +446,9 @@ int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
 
         memory_listener_register(&container->prereg_listener,
                                  &address_space_memory);
-        if (container->error) {
+        if (bcontainer->error) {
             ret = -1;
-            error_propagate_prepend(errp, container->error,
+            error_propagate_prepend(errp, bcontainer->error,
                     "RAM memory listener initialization failed: ");
             goto listener_unregister_exit;
         }
-- 
2.43.0


