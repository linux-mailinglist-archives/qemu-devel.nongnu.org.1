Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 388047CA27B
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:50:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJH7-00009h-MQ; Mon, 16 Oct 2023 04:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJGx-0008Ic-Ed; Mon, 16 Oct 2023 04:48:25 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJGr-0001Al-9i; Mon, 16 Oct 2023 04:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697446097; x=1728982097;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oPwi6eVw5K0v9Z9FjdMpzuizve7IfLaTuIh1dcsksdc=;
 b=jslN8OkMqc/lEZxkdCmcIyo14TFz59+WQDUXHnBd2IkNiM3BlVQ0Fbfn
 bUmBGhjaMdJmMZ6hPTAm1+ZA+4P4Eeic3AY5d0kWOH4vM26KDgghJGZEb
 VzFNFsjcJFMfetRm3LTLq33aL7ebiFoGxL3YPiT0WWP+Shq8uWtC4ykWM
 xg2kkBlc6MUczTdXSIEl/uXmQYs8AFp+tJZ9BO16sdZJ1JQIHi9bjyY61
 KdijJLvqVHup7jnGQAUckUzoq4v5vnrBKo1uDa2XEomnv7bawvl1rK8+0
 ubJoTFG3DrhPFObg9yTI8aU2HtqzSVRruJa2JBQPxCoGqIvrWN5nlu3Ke g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365737639"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="365737639"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:48:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="749222913"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="749222913"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:48:09 -0700
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
Subject: [PATCH v2 13/27] vfio/container: Move listener to base container
Date: Mon, 16 Oct 2023 16:32:09 +0800
Message-Id: <20231016083223.1519410-14-zhenzhong.duan@intel.com>
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

Move listener to base container. Also error and initialized fields
are moved at the same time.

No functional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h         |   3 -
 include/hw/vfio/vfio-container-base.h |   3 +
 hw/vfio/common.c                      | 116 +++++++++++---------------
 hw/vfio/container-base.c              |   1 +
 hw/vfio/container.c                   |  31 +++----
 hw/vfio/spapr.c                       |   7 +-
 6 files changed, 72 insertions(+), 89 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 18dd676a2a..8771160849 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -78,11 +78,8 @@ struct VFIOGroup;
 typedef struct VFIOLegacyContainer {
     VFIOContainer bcontainer;
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
-    MemoryListener listener;
     MemoryListener prereg_listener;
     unsigned iommu_type;
-    Error *error;
-    bool initialized;
     uint64_t dirty_pgsizes;
     uint64_t max_dirty_bitmap_size;
     QLIST_HEAD(, VFIOGroup) group_list;
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index d6ffd7efc4..96d33495c1 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -76,6 +76,9 @@ typedef struct {
 struct VFIOContainer {
     VFIOIOMMUBackendOpsClass *ops;
     VFIOAddressSpace *space;
+    MemoryListener listener;
+    Error *error;
+    bool initialized;
     unsigned long pgsizes;
     unsigned int dma_max_mappings;
     bool dirty_pages_supported;
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index b833def682..da1d64efca 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -602,7 +602,7 @@ static bool vfio_listener_valid_section(MemoryRegionSection *section,
     return true;
 }
 
-static bool vfio_get_section_iova_range(VFIOLegacyContainer *container,
+static bool vfio_get_section_iova_range(VFIOContainer *bcontainer,
                                         MemoryRegionSection *section,
                                         hwaddr *out_iova, hwaddr *out_end,
                                         Int128 *out_llend)
@@ -630,10 +630,7 @@ static bool vfio_get_section_iova_range(VFIOLegacyContainer *container,
 static void vfio_listener_region_add(MemoryListener *listener,
                                      MemoryRegionSection *section)
 {
-    VFIOLegacyContainer *container = container_of(listener,
-                                                  VFIOLegacyContainer,
-                                                  listener);
-    VFIOContainer *bcontainer = &container->bcontainer;
+    VFIOContainer *bcontainer = container_of(listener, VFIOContainer, listener);
     hwaddr iova, end;
     Int128 llend, llsize;
     void *vaddr;
@@ -645,7 +642,8 @@ static void vfio_listener_region_add(MemoryListener *listener,
         return;
     }
 
-    if (!vfio_get_section_iova_range(container, section, &iova, &end, &llend)) {
+    if (!vfio_get_section_iova_range(bcontainer, section, &iova, &end,
+                                     &llend)) {
         if (memory_region_is_ram_device(section->mr)) {
             trace_vfio_listener_region_add_no_dma_map(
                 memory_region_name(section->mr),
@@ -663,7 +661,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
     hostwin = vfio_find_hostwin(bcontainer, iova, end);
     if (!hostwin) {
         error_setg(&err, "Container %p can't map guest IOVA region"
-                   " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx, container, iova, end);
+                   " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx, bcontainer, iova, end);
         goto fail;
     }
 
@@ -750,13 +748,12 @@ static void vfio_listener_region_add(MemoryListener *listener,
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
@@ -778,9 +775,9 @@ fail:
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
@@ -795,10 +792,7 @@ fail:
 static void vfio_listener_region_del(MemoryListener *listener,
                                      MemoryRegionSection *section)
 {
-    VFIOLegacyContainer *container = container_of(listener,
-                                                  VFIOLegacyContainer,
-                                                  listener);
-    VFIOContainer *bcontainer = &container->bcontainer;
+    VFIOContainer *bcontainer = container_of(listener, VFIOContainer, listener);
     hwaddr iova, end;
     Int128 llend, llsize;
     int ret;
@@ -831,7 +825,8 @@ static void vfio_listener_region_del(MemoryListener *listener,
          */
     }
 
-    if (!vfio_get_section_iova_range(container, section, &iova, &end, &llend)) {
+    if (!vfio_get_section_iova_range(bcontainer, section, &iova, &end,
+                                     &llend)) {
         return;
     }
 
@@ -858,29 +853,29 @@ static void vfio_listener_region_del(MemoryListener *listener,
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
 
     memory_region_unref(section->mr);
 
-    vfio_container_del_section_window(&container->bcontainer, section);
+    vfio_container_del_section_window(bcontainer, section);
 }
 
 typedef struct VFIODirtyRanges {
@@ -893,16 +888,15 @@ typedef struct VFIODirtyRanges {
 } VFIODirtyRanges;
 
 typedef struct VFIODirtyRangesListener {
-    VFIOLegacyContainer *container;
+    VFIOContainer *bcontainer;
     VFIODirtyRanges ranges;
     MemoryListener listener;
 } VFIODirtyRangesListener;
 
 static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
-                                     VFIOLegacyContainer *container)
+                                     VFIOContainer *bcontainer)
 {
     VFIOPCIDevice *pcidev;
-    VFIOContainer *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
     Object *owner;
 
@@ -931,7 +925,7 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
     hwaddr iova, end, *min, *max;
 
     if (!vfio_listener_valid_section(section, "tracking_update") ||
-        !vfio_get_section_iova_range(dirty->container, section,
+        !vfio_get_section_iova_range(dirty->bcontainer, section,
                                      &iova, &end, NULL)) {
         return;
     }
@@ -955,7 +949,7 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
      * The alternative would be an IOVATree but that has a much bigger runtime
      * overhead and unnecessary complexity.
      */
-    if (vfio_section_is_vfio_pci(section, dirty->container) &&
+    if (vfio_section_is_vfio_pci(section, dirty->bcontainer) &&
         iova >= UINT32_MAX) {
         min = &range->minpci64;
         max = &range->maxpci64;
@@ -979,7 +973,7 @@ static const MemoryListener vfio_dirty_tracking_listener = {
     .region_add = vfio_dirty_tracking_update,
 };
 
-static void vfio_dirty_tracking_init(VFIOLegacyContainer *container,
+static void vfio_dirty_tracking_init(VFIOContainer *bcontainer,
                                      VFIODirtyRanges *ranges)
 {
     VFIODirtyRangesListener dirty;
@@ -989,10 +983,10 @@ static void vfio_dirty_tracking_init(VFIOLegacyContainer *container,
     dirty.ranges.min64 = UINT64_MAX;
     dirty.ranges.minpci64 = UINT64_MAX;
     dirty.listener = vfio_dirty_tracking_listener;
-    dirty.container = container;
+    dirty.bcontainer = bcontainer;
 
     memory_listener_register(&dirty.listener,
-                             container->bcontainer.space->as);
+                             bcontainer->space->as);
 
     *ranges = dirty.ranges;
 
@@ -1004,12 +998,11 @@ static void vfio_dirty_tracking_init(VFIOLegacyContainer *container,
     memory_listener_unregister(&dirty.listener);
 }
 
-static void vfio_devices_dma_logging_stop(VFIOLegacyContainer *container)
+static void vfio_devices_dma_logging_stop(VFIOContainer *bcontainer)
 {
     uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
                               sizeof(uint64_t))] = {};
     struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
-    VFIOContainer *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
 
     feature->argsz = sizeof(buf);
@@ -1030,7 +1023,7 @@ static void vfio_devices_dma_logging_stop(VFIOLegacyContainer *container)
 }
 
 static struct vfio_device_feature *
-vfio_device_feature_dma_logging_start_create(VFIOLegacyContainer *container,
+vfio_device_feature_dma_logging_start_create(VFIOContainer *bcontainer,
                                              VFIODirtyRanges *tracking)
 {
     struct vfio_device_feature *feature;
@@ -1103,16 +1096,15 @@ static void vfio_device_feature_dma_logging_start_destroy(
     g_free(feature);
 }
 
-static int vfio_devices_dma_logging_start(VFIOLegacyContainer *container)
+static int vfio_devices_dma_logging_start(VFIOContainer *bcontainer)
 {
     struct vfio_device_feature *feature;
     VFIODirtyRanges ranges;
-    VFIOContainer *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
     int ret = 0;
 
-    vfio_dirty_tracking_init(container, &ranges);
-    feature = vfio_device_feature_dma_logging_start_create(container,
+    vfio_dirty_tracking_init(bcontainer, &ranges);
+    feature = vfio_device_feature_dma_logging_start_create(bcontainer,
                                                            &ranges);
     if (!feature) {
         return -errno;
@@ -1135,7 +1127,7 @@ static int vfio_devices_dma_logging_start(VFIOLegacyContainer *container)
 
 out:
     if (ret) {
-        vfio_devices_dma_logging_stop(container);
+        vfio_devices_dma_logging_stop(bcontainer);
     }
 
     vfio_device_feature_dma_logging_start_destroy(feature);
@@ -1145,16 +1137,13 @@ out:
 
 static void vfio_listener_log_global_start(MemoryListener *listener)
 {
-    VFIOLegacyContainer *container = container_of(listener,
-                                                  VFIOLegacyContainer,
-                                                  listener);
+    VFIOContainer *bcontainer = container_of(listener, VFIOContainer, listener);
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
@@ -1166,16 +1155,13 @@ static void vfio_listener_log_global_start(MemoryListener *listener)
 
 static void vfio_listener_log_global_stop(MemoryListener *listener)
 {
-    VFIOLegacyContainer *container = container_of(listener,
-                                                  VFIOLegacyContainer,
-                                                  listener);
+    VFIOContainer *bcontainer = container_of(listener, VFIOContainer, listener);
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
@@ -1286,9 +1272,6 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
                                                 vfio_giommu_dirty_notifier, n);
     VFIOGuestIOMMU *giommu = gdn->giommu;
     VFIOContainer *bcontainer = giommu->bcontainer;
-    VFIOLegacyContainer *container = container_of(bcontainer,
-                                                  VFIOLegacyContainer,
-                                                  bcontainer);
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
     ram_addr_t translated_addr;
     int ret = -EINVAL;
@@ -1303,12 +1286,12 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
 
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
@@ -1364,10 +1347,9 @@ vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainer *bcontainer,
                                                 &vrdl);
 }
 
-static int vfio_sync_dirty_bitmap(VFIOLegacyContainer *container,
+static int vfio_sync_dirty_bitmap(VFIOContainer *bcontainer,
                                   MemoryRegionSection *section)
 {
-    VFIOContainer *bcontainer = &container->bcontainer;
     ram_addr_t ram_addr;
 
     if (memory_region_is_iommu(section->mr)) {
@@ -1403,7 +1385,7 @@ static int vfio_sync_dirty_bitmap(VFIOLegacyContainer *container,
     ram_addr = memory_region_get_ram_addr(section->mr) +
                section->offset_within_region;
 
-    return vfio_get_dirty_bitmap(&container->bcontainer,
+    return vfio_get_dirty_bitmap(bcontainer,
                    REAL_HOST_PAGE_ALIGN(section->offset_within_address_space),
                    int128_get64(section->size), ram_addr);
 }
@@ -1411,17 +1393,15 @@ static int vfio_sync_dirty_bitmap(VFIOLegacyContainer *container,
 static void vfio_listener_log_sync(MemoryListener *listener,
         MemoryRegionSection *section)
 {
-    VFIOLegacyContainer *container = container_of(listener,
-                                                  VFIOLegacyContainer,
-                                                  listener);
+    VFIOContainer *bcontainer = container_of(listener, VFIOContainer, listener);
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
index c5a4c5afed..29cf954019 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -97,6 +97,7 @@ void vfio_container_init(VFIOContainer *bcontainer,
 {
     bcontainer->ops = ops;
     bcontainer->space = space;
+    bcontainer->error = NULL;
     bcontainer->dirty_pages_supported = false;
     bcontainer->dma_max_mappings = 0;
     QLIST_INIT(&bcontainer->giommu_list);
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 66fad1c280..5b14a9b307 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -382,7 +382,9 @@ static int vfio_legacy_query_dirty_bitmap(VFIOContainer *bcontainer,
 
 static void vfio_listener_release(VFIOLegacyContainer *container)
 {
-    memory_listener_unregister(&container->listener);
+    VFIOContainer *bcontainer = &container->bcontainer;
+
+    memory_listener_unregister(&bcontainer->listener);
     if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
         memory_listener_unregister(&container->prereg_listener);
     }
@@ -540,6 +542,7 @@ static void vfio_get_iommu_info_migration(VFIOLegacyContainer *container,
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_iommu_type1_info_cap_migration *cap_mig;
+    VFIOContainer *bcontainer = &container->bcontainer;
 
     hdr = vfio_get_iommu_info_cap(info, VFIO_IOMMU_TYPE1_INFO_CAP_MIGRATION);
     if (!hdr) {
@@ -554,7 +557,7 @@ static void vfio_get_iommu_info_migration(VFIOLegacyContainer *container,
      * qemu_real_host_page_size to mark those dirty.
      */
     if (cap_mig->pgsize_bitmap & qemu_real_host_page_size()) {
-        container->bcontainer.dirty_pages_supported = true;
+        bcontainer->dirty_pages_supported = true;
         container->max_dirty_bitmap_size = cap_mig->max_dirty_bitmap_size;
         container->dirty_pgsizes = cap_mig->pgsize_bitmap;
     }
@@ -641,7 +644,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
 
     container = g_malloc0(sizeof(*container));
     container->fd = fd;
-    container->error = NULL;
     bcontainer = &container->bcontainer;
     vfio_container_init(bcontainer, space, ops);
 
@@ -669,9 +671,9 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         }
 
         if (info->flags & VFIO_IOMMU_INFO_PGSIZES) {
-            container->bcontainer.pgsizes = info->iova_pgsizes;
+            bcontainer->pgsizes = info->iova_pgsizes;
         } else {
-            container->bcontainer.pgsizes = qemu_real_host_page_size();
+            bcontainer->pgsizes = qemu_real_host_page_size();
         }
 
         if (!vfio_get_info_dma_avail(info, &bcontainer->dma_max_mappings)) {
@@ -712,10 +714,10 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
 
             memory_listener_register(&container->prereg_listener,
                                      &address_space_memory);
-            if (container->error) {
+            if (bcontainer->error) {
                 memory_listener_unregister(&container->prereg_listener);
                 ret = -1;
-                error_propagate_prepend(errp, container->error,
+                error_propagate_prepend(errp, bcontainer->error,
                     "RAM memory listener initialization failed: ");
                 goto enable_discards_exit;
             }
@@ -734,7 +736,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         }
 
         if (v2) {
-            container->bcontainer.pgsizes = info.ddw.pgsizes;
+            bcontainer->pgsizes = info.ddw.pgsizes;
             /*
              * There is a default window in just created container.
              * To make region_add/del simpler, we better remove this
@@ -749,7 +751,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
             }
         } else {
             /* The default table uses 4K pages */
-            container->bcontainer.pgsizes = 0x1000;
+            bcontainer->pgsizes = 0x1000;
             vfio_host_win_add(bcontainer, info.dma32_window_start,
                               info.dma32_window_start +
                               info.dma32_window_size - 1,
@@ -766,19 +768,18 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     group->container = container;
     QLIST_INSERT_HEAD(&container->group_list, group, container_next);
 
-    container->listener = vfio_memory_listener;
+    bcontainer->listener = vfio_memory_listener;
 
-    memory_listener_register(&container->listener,
-                             container->bcontainer.space->as);
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
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 3fdad9d227..7df2a7a672 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -41,6 +41,7 @@ static void vfio_prereg_listener_region_add(MemoryListener *listener,
 {
     VFIOLegacyContainer *container = container_of(listener, VFIOLegacyContainer,
                                                   prereg_listener);
+    VFIOContainer *bcontainer = &container->bcontainer;
     const hwaddr gpa = section->offset_within_address_space;
     hwaddr end;
     int ret;
@@ -83,9 +84,9 @@ static void vfio_prereg_listener_region_add(MemoryListener *listener,
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
-- 
2.34.1


