Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BC97CA294
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:51:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJGT-0007h0-Sm; Mon, 16 Oct 2023 04:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJGK-0007ab-Up
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:47:46 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJGC-00019z-9O
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697446056; x=1728982056;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5yEvxT2rXMhOpXnprf4FOirUqI+6sQBhYa/RMnVdfFM=;
 b=XUFEETqzoX2ymPJ1G6Fok0J6WoKbDc+u/yMKuG/MUSG2EnrHAWTPNW4e
 UPTy4f6uJSwXduat/6hxFhzDzH0KTEFV/u6QsR93MVwu2Tt/mSj9XbeBp
 Y3Zn4OQceriqwHTUBxAiVIUWNnPGKw6ntAOTq+UZ1+7ILzPBovw2ela4a
 P0ixhvMXA4yYn18/fKww23hUMJ7+riIkvajOCgC829A2cCtpkZCGfcVK/
 AefJoltnVdMn8s5BChu1GeqSWCp0WOkUU0zL7sVIkwAReGZ49rwbPiBgb
 ftA7Th8RnU4jWffjM1jdnRyXlEhO4PKc+TDC/okK1y+Cswzz1ZA1qJZ5r w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365737535"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="365737535"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:47:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="749222699"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="749222699"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:47:28 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 04/27] vfio/container: Switch to dma_map|unmap API
Date: Mon, 16 Oct 2023 16:32:00 +0800
Message-Id: <20231016083223.1519410-5-zhenzhong.duan@intel.com>
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

No fucntional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h         |  4 ---
 include/hw/vfio/vfio-container-base.h |  7 +++++
 hw/vfio/common.c                      | 45 +++++++++++++++------------
 hw/vfio/container-base.c              | 22 +++++++++++++
 hw/vfio/container.c                   | 25 +++++++++++----
 hw/vfio/trace-events                  |  2 +-
 6 files changed, 74 insertions(+), 31 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 9651cf921c..f2aa122c47 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -212,10 +212,6 @@ void vfio_put_address_space(VFIOAddressSpace *space);
 bool vfio_devices_all_running_and_saving(VFIOLegacyContainer *container);
 
 /* container->fd */
-int vfio_dma_unmap(VFIOLegacyContainer *container, hwaddr iova,
-                   ram_addr_t size, IOMMUTLBEntry *iotlb);
-int vfio_dma_map(VFIOLegacyContainer *container, hwaddr iova,
-                 ram_addr_t size, void *vaddr, bool readonly);
 int vfio_set_dirty_page_tracking(VFIOLegacyContainer *container, bool start);
 int vfio_query_dirty_bitmap(VFIOLegacyContainer *container, VFIOBitmap *vbmap,
                             hwaddr iova, hwaddr size);
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 226e960fb5..1483e77441 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -46,6 +46,13 @@ struct VFIOContainer {
     VFIOIOMMUBackendOpsClass *ops;
 };
 
+int vfio_container_dma_map(VFIOContainer *bcontainer,
+                           hwaddr iova, ram_addr_t size,
+                           void *vaddr, bool readonly);
+int vfio_container_dma_unmap(VFIOContainer *bcontainer,
+                             hwaddr iova, ram_addr_t size,
+                             IOMMUTLBEntry *iotlb);
+
 #define TYPE_VFIO_IOMMU_BACKEND_LEGACY_OPS "vfio-iommu-backend-legacy-ops"
 #define TYPE_VFIO_IOMMU_BACKEND_OPS "vfio-iommu-backend-ops"
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index b51ef3a15a..6be1526d79 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -337,7 +337,7 @@ static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
 static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
 {
     VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
-    VFIOLegacyContainer *container = giommu->container;
+    VFIOContainer *bcontainer = &giommu->container->bcontainer;
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
     void *vaddr;
     int ret;
@@ -367,21 +367,22 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
          * of vaddr will always be there, even if the memory object is
          * destroyed and its backing memory munmap-ed.
          */
-        ret = vfio_dma_map(container, iova,
-                           iotlb->addr_mask + 1, vaddr,
-                           read_only);
+        ret = vfio_container_dma_map(bcontainer, iova,
+                                     iotlb->addr_mask + 1, vaddr,
+                                     read_only);
         if (ret) {
-            error_report("vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
+            error_report("vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx", %p) = %d (%s)",
-                         container, iova,
+                         bcontainer, iova,
                          iotlb->addr_mask + 1, vaddr, ret, strerror(-ret));
         }
     } else {
-        ret = vfio_dma_unmap(container, iova, iotlb->addr_mask + 1, iotlb);
+        ret = vfio_container_dma_unmap(bcontainer, iova,
+                                       iotlb->addr_mask + 1, iotlb);
         if (ret) {
-            error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
+            error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%s)",
-                         container, iova,
+                         bcontainer, iova,
                          iotlb->addr_mask + 1, ret, strerror(-ret));
             vfio_set_migration_error(ret);
         }
@@ -400,9 +401,10 @@ static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
     int ret;
 
     /* Unmap with a single call. */
-    ret = vfio_dma_unmap(vrdl->container, iova, size , NULL);
+    ret = vfio_container_dma_unmap(&vrdl->container->bcontainer,
+                                   iova, size , NULL);
     if (ret) {
-        error_report("%s: vfio_dma_unmap() failed: %s", __func__,
+        error_report("%s: vfio_container_dma_unmap() failed: %s", __func__,
                      strerror(-ret));
     }
 }
@@ -430,8 +432,8 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
                section->offset_within_address_space;
         vaddr = memory_region_get_ram_ptr(section->mr) + start;
 
-        ret = vfio_dma_map(vrdl->container, iova, next - start,
-                           vaddr, section->readonly);
+        ret = vfio_container_dma_map(&vrdl->container->bcontainer, iova,
+                                     next - start, vaddr, section->readonly);
         if (ret) {
             /* Rollback */
             vfio_ram_discard_notify_discard(rdl, section);
@@ -746,10 +748,11 @@ static void vfio_listener_region_add(MemoryListener *listener,
         }
     }
 
-    ret = vfio_dma_map(container, iova, int128_get64(llsize),
-                       vaddr, section->readonly);
+    ret = vfio_container_dma_map(&container->bcontainer,
+                                 iova, int128_get64(llsize), vaddr,
+                                 section->readonly);
     if (ret) {
-        error_setg(&err, "vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
+        error_setg(&err, "vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
                    "0x%"HWADDR_PRIx", %p) = %d (%s)",
                    container, iova, int128_get64(llsize), vaddr, ret,
                    strerror(-ret));
@@ -852,18 +855,20 @@ static void vfio_listener_region_del(MemoryListener *listener,
         if (int128_eq(llsize, int128_2_64())) {
             /* The unmap ioctl doesn't accept a full 64-bit span. */
             llsize = int128_rshift(llsize, 1);
-            ret = vfio_dma_unmap(container, iova, int128_get64(llsize), NULL);
+            ret = vfio_container_dma_unmap(&container->bcontainer, iova,
+                                           int128_get64(llsize), NULL);
             if (ret) {
-                error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
+                error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                              "0x%"HWADDR_PRIx") = %d (%s)",
                              container, iova, int128_get64(llsize), ret,
                              strerror(-ret));
             }
             iova += int128_get64(llsize);
         }
-        ret = vfio_dma_unmap(container, iova, int128_get64(llsize), NULL);
+        ret = vfio_container_dma_unmap(&container->bcontainer, iova,
+                                       int128_get64(llsize), NULL);
         if (ret) {
-            error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
+            error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%s)",
                          container, iova, int128_get64(llsize), ret,
                          strerror(-ret));
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 0c21e77039..78329935f6 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -26,6 +26,28 @@
 #include "qemu/error-report.h"
 #include "hw/vfio/vfio-container-base.h"
 
+int vfio_container_dma_map(VFIOContainer *bcontainer,
+                           hwaddr iova, ram_addr_t size,
+                           void *vaddr, bool readonly)
+{
+    if (!bcontainer->ops->dma_map) {
+        return -EINVAL;
+    }
+
+    return bcontainer->ops->dma_map(bcontainer, iova, size, vaddr, readonly);
+}
+
+int vfio_container_dma_unmap(VFIOContainer *bcontainer,
+                             hwaddr iova, ram_addr_t size,
+                             IOMMUTLBEntry *iotlb)
+{
+    if (!bcontainer->ops->dma_unmap) {
+        return -EINVAL;
+    }
+
+    return bcontainer->ops->dma_unmap(bcontainer, iova, size, iotlb);
+}
+
 static const TypeInfo vfio_iommu_backend_ops_type_info = {
     .name = TYPE_VFIO_IOMMU_BACKEND_OPS,
     .parent = TYPE_OBJECT,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index acc4a6bf8a..80aafa21ed 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -121,9 +121,13 @@ unmap_exit:
 /*
  * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
  */
-int vfio_dma_unmap(VFIOLegacyContainer *container, hwaddr iova,
-                   ram_addr_t size, IOMMUTLBEntry *iotlb)
+static int vfio_legacy_dma_unmap(VFIOContainer *bcontainer, hwaddr iova,
+                                 ram_addr_t size, IOMMUTLBEntry *iotlb)
 {
+    VFIOLegacyContainer *container = container_of(bcontainer,
+                                                  VFIOLegacyContainer,
+                                                  bcontainer);
+
     struct vfio_iommu_type1_dma_unmap unmap = {
         .argsz = sizeof(unmap),
         .flags = 0,
@@ -157,7 +161,7 @@ int vfio_dma_unmap(VFIOLegacyContainer *container, hwaddr iova,
          */
         if (errno == EINVAL && unmap.size && !(unmap.iova + unmap.size) &&
             container->iommu_type == VFIO_TYPE1v2_IOMMU) {
-            trace_vfio_dma_unmap_overflow_workaround();
+            trace_vfio_legacy_dma_unmap_overflow_workaround();
             unmap.size -= 1ULL << ctz64(container->pgsizes);
             continue;
         }
@@ -176,9 +180,13 @@ int vfio_dma_unmap(VFIOLegacyContainer *container, hwaddr iova,
     return 0;
 }
 
-int vfio_dma_map(VFIOLegacyContainer *container, hwaddr iova,
-                 ram_addr_t size, void *vaddr, bool readonly)
+static int vfio_legacy_dma_map(VFIOContainer *bcontainer, hwaddr iova,
+                               ram_addr_t size, void *vaddr, bool readonly)
 {
+    VFIOLegacyContainer *container = container_of(bcontainer,
+                                                  VFIOLegacyContainer,
+                                                  bcontainer);
+
     struct vfio_iommu_type1_dma_map map = {
         .argsz = sizeof(map),
         .flags = VFIO_DMA_MAP_FLAG_READ,
@@ -197,7 +205,8 @@ int vfio_dma_map(VFIOLegacyContainer *container, hwaddr iova,
      * the VGA ROM space.
      */
     if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0 ||
-        (errno == EBUSY && vfio_dma_unmap(container, iova, size, NULL) == 0 &&
+        (errno == EBUSY &&
+         vfio_legacy_dma_unmap(bcontainer, iova, size, NULL) == 0 &&
          ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0)) {
         return 0;
     }
@@ -1168,6 +1177,10 @@ void vfio_detach_device(VFIODevice *vbasedev)
 
 static void vfio_iommu_backend_legacy_ops_class_init(ObjectClass *oc,
                                                      void *data) {
+    VFIOIOMMUBackendOpsClass *ops = VFIO_IOMMU_BACKEND_OPS_CLASS(oc);
+
+    ops->dma_map = vfio_legacy_dma_map;
+    ops->dma_unmap = vfio_legacy_dma_unmap;
 }
 
 static const TypeInfo vfio_iommu_backend_legacy_ops_type = {
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 0eb2387cf2..9f7fedee98 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -116,7 +116,7 @@ vfio_region_unmap(const char *name, unsigned long offset, unsigned long end) "Re
 vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Device %s region %d: %d sparse mmap entries"
 vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
 vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%08x"
-vfio_dma_unmap_overflow_workaround(void) ""
+vfio_legacy_dma_unmap_overflow_workaround(void) ""
 vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "container fd=%d, iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
 vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
 
-- 
2.34.1


