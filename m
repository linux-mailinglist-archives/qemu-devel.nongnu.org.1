Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 306257D8118
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 12:48:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvxtp-0008SA-6q; Thu, 26 Oct 2023 06:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxth-0008Dq-Df
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:47:29 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxte-0001Nv-Rq
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698317246; x=1729853246;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zZK0COSD976kyMw31NflsdQhbowTcJEQCFzTXT4zXkw=;
 b=hUOQYVq56Psdp53KIEYDp+d6/hrZ3j0hWcmPM7DvCSUBEpCn+wvBffeo
 F6cNrYwQibmFhl5hoCT3yTj0rYHBiHJSF/9kXJDBMAdzrLTpV8DFfybap
 Je5psGc8PquKbAsEXSmvYj9KZ+w2VCeeXdSFRsh5VfbyXAYSJiVXSjNGI
 icWlowIwue/u4izybKrkCLeSvPqH9QJd3p7axP0Sdhb5h/O8D9uKfKxDF
 kNhKQn0YIQi7vNnEOS5eGSopVCwBsbYy/5qm/6CAo0oKOErO60sCIJxQN
 EtxZB53P2AdSo+Qv/xZBhLsh0Yx96eTnggCkoaAhH1zsp5olk0OV5Uv0E Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="372563370"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; d="scan'208";a="372563370"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:47:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="463663"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:46:47 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 13/37] vfio/container: Convert functions to base container
Date: Thu, 26 Oct 2023 18:30:40 +0800
Message-Id: <20231026103104.1686921-14-zhenzhong.duan@intel.com>
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

In the prospect to get rid of VFIOContainer refs
in common.c lets convert misc functions to use the base
container object instead:

vfio_devices_all_dirty_tracking
vfio_devices_all_device_dirty_tracking
vfio_devices_all_running_and_mig_active
vfio_devices_query_dirty_bitmap
vfio_get_dirty_bitmap

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |  9 ++++----
 hw/vfio/common.c              | 42 +++++++++++++++--------------------
 hw/vfio/container.c           |  6 ++---
 hw/vfio/trace-events          |  2 +-
 4 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index f7a84dc8d0..fb3c7aea8f 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -186,7 +186,6 @@ typedef struct VFIODisplay {
 
 VFIOAddressSpace *vfio_get_address_space(AddressSpace *as);
 void vfio_put_address_space(VFIOAddressSpace *space);
-bool vfio_devices_all_running_and_saving(VFIOContainer *container);
 
 /* SPAPR specific */
 int vfio_container_add_section_window(VFIOContainer *container,
@@ -260,11 +259,11 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
 void vfio_migration_exit(VFIODevice *vbasedev);
 
 int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
-bool vfio_devices_all_running_and_mig_active(VFIOContainer *container);
-bool vfio_devices_all_device_dirty_tracking(VFIOContainer *container);
-int vfio_devices_query_dirty_bitmap(VFIOContainer *container,
+bool vfio_devices_all_running_and_mig_active(VFIOContainerBase *bcontainer);
+bool vfio_devices_all_device_dirty_tracking(VFIOContainerBase *bcontainer);
+int vfio_devices_query_dirty_bitmap(VFIOContainerBase *bcontainer,
                                     VFIOBitmap *vbmap, hwaddr iova,
                                     hwaddr size);
-int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
+int vfio_get_dirty_bitmap(VFIOContainerBase *bcontainer, uint64_t iova,
                                  uint64_t size, ram_addr_t ram_addr);
 #endif /* HW_VFIO_VFIO_COMMON_H */
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index f8475348ad..91411d9844 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -177,9 +177,8 @@ bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
            migration->device_state == VFIO_DEVICE_STATE_PRE_COPY_P2P;
 }
 
-static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
+static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
 {
-    VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
     MigrationState *ms = migrate_get_current();
 
@@ -204,9 +203,8 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
     return true;
 }
 
-bool vfio_devices_all_device_dirty_tracking(VFIOContainer *container)
+bool vfio_devices_all_device_dirty_tracking(VFIOContainerBase *bcontainer)
 {
-    VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
 
     QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
@@ -222,9 +220,8 @@ bool vfio_devices_all_device_dirty_tracking(VFIOContainer *container)
  * Check if all VFIO devices are running and migration is active, which is
  * essentially equivalent to the migration being in pre-copy phase.
  */
-bool vfio_devices_all_running_and_mig_active(VFIOContainer *container)
+bool vfio_devices_all_running_and_mig_active(VFIOContainerBase *bcontainer)
 {
-    VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
 
     if (!migration_is_active(migrate_get_current())) {
@@ -1084,7 +1081,7 @@ static void vfio_listener_log_global_start(MemoryListener *listener)
     VFIOContainer *container = container_of(listener, VFIOContainer, listener);
     int ret;
 
-    if (vfio_devices_all_device_dirty_tracking(container)) {
+    if (vfio_devices_all_device_dirty_tracking(&container->bcontainer)) {
         ret = vfio_devices_dma_logging_start(container);
     } else {
         ret = vfio_container_set_dirty_page_tracking(&container->bcontainer,
@@ -1103,7 +1100,7 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
     VFIOContainer *container = container_of(listener, VFIOContainer, listener);
     int ret = 0;
 
-    if (vfio_devices_all_device_dirty_tracking(container)) {
+    if (vfio_devices_all_device_dirty_tracking(&container->bcontainer)) {
         vfio_devices_dma_logging_stop(container);
     } else {
         ret = vfio_container_set_dirty_page_tracking(&container->bcontainer,
@@ -1143,11 +1140,10 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
     return 0;
 }
 
-int vfio_devices_query_dirty_bitmap(VFIOContainer *container,
+int vfio_devices_query_dirty_bitmap(VFIOContainerBase *bcontainer,
                                     VFIOBitmap *vbmap, hwaddr iova,
                                     hwaddr size)
 {
-    VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
     int ret;
 
@@ -1167,17 +1163,16 @@ int vfio_devices_query_dirty_bitmap(VFIOContainer *container,
     return 0;
 }
 
-int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
+int vfio_get_dirty_bitmap(VFIOContainerBase *bcontainer, uint64_t iova,
                           uint64_t size, ram_addr_t ram_addr)
 {
     bool all_device_dirty_tracking =
-        vfio_devices_all_device_dirty_tracking(container);
+        vfio_devices_all_device_dirty_tracking(bcontainer);
     uint64_t dirty_pages;
     VFIOBitmap vbmap;
     int ret;
 
-    if (!container->bcontainer.dirty_pages_supported &&
-        !all_device_dirty_tracking) {
+    if (!bcontainer->dirty_pages_supported && !all_device_dirty_tracking) {
         cpu_physical_memory_set_dirty_range(ram_addr, size,
                                             tcg_enabled() ? DIRTY_CLIENTS_ALL :
                                             DIRTY_CLIENTS_NOCODE);
@@ -1190,10 +1185,9 @@ int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
     }
 
     if (all_device_dirty_tracking) {
-        ret = vfio_devices_query_dirty_bitmap(container, &vbmap, iova, size);
+        ret = vfio_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size);
     } else {
-        ret = vfio_container_query_dirty_bitmap(&container->bcontainer, &vbmap,
-                                                iova, size);
+        ret = vfio_container_query_dirty_bitmap(bcontainer, &vbmap, iova, size);
     }
 
     if (ret) {
@@ -1203,8 +1197,7 @@ int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
     dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
                                                          vbmap.pages);
 
-    trace_vfio_get_dirty_bitmap(container->fd, iova, size, vbmap.size,
-                                ram_addr, dirty_pages);
+    trace_vfio_get_dirty_bitmap(iova, size, vbmap.size, ram_addr, dirty_pages);
 out:
     g_free(vbmap.bitmap);
 
@@ -1238,8 +1231,8 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
 
     rcu_read_lock();
     if (vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
-        ret = vfio_get_dirty_bitmap(container, iova, iotlb->addr_mask + 1,
-                                    translated_addr);
+        ret = vfio_get_dirty_bitmap(&container->bcontainer, iova,
+                                    iotlb->addr_mask + 1, translated_addr);
         if (ret) {
             error_report("vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%s)",
@@ -1268,7 +1261,8 @@ static int vfio_ram_discard_get_dirty_bitmap(MemoryRegionSection *section,
      * Sync the whole mapped region (spanning multiple individual mappings)
      * in one go.
      */
-    return vfio_get_dirty_bitmap(vrdl->container, iova, size, ram_addr);
+    return vfio_get_dirty_bitmap(&vrdl->container->bcontainer, iova, size,
+                                 ram_addr);
 }
 
 static int vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainer *container,
@@ -1337,7 +1331,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainer *container,
     ram_addr = memory_region_get_ram_addr(section->mr) +
                section->offset_within_region;
 
-    return vfio_get_dirty_bitmap(container,
+    return vfio_get_dirty_bitmap(&container->bcontainer,
                    REAL_HOST_PAGE_ALIGN(section->offset_within_address_space),
                    int128_get64(section->size), ram_addr);
 }
@@ -1352,7 +1346,7 @@ static void vfio_listener_log_sync(MemoryListener *listener,
         return;
     }
 
-    if (vfio_devices_all_dirty_tracking(container)) {
+    if (vfio_devices_all_dirty_tracking(&container->bcontainer)) {
         ret = vfio_sync_dirty_bitmap(container, section);
         if (ret) {
             error_report("vfio: Failed to sync dirty bitmap, err: %d (%s)", ret,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 3228dd2109..8d5b408e86 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -129,8 +129,8 @@ static int vfio_legacy_dma_unmap(VFIOContainerBase *bcontainer, hwaddr iova,
     bool need_dirty_sync = false;
     int ret;
 
-    if (iotlb && vfio_devices_all_running_and_mig_active(container)) {
-        if (!vfio_devices_all_device_dirty_tracking(container) &&
+    if (iotlb && vfio_devices_all_running_and_mig_active(bcontainer)) {
+        if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
             container->bcontainer.dirty_pages_supported) {
             return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
         }
@@ -162,7 +162,7 @@ static int vfio_legacy_dma_unmap(VFIOContainerBase *bcontainer, hwaddr iova,
     }
 
     if (need_dirty_sync) {
-        ret = vfio_get_dirty_bitmap(container, iova, size,
+        ret = vfio_get_dirty_bitmap(bcontainer, iova, size,
                                     iotlb->translated_addr);
         if (ret) {
             return ret;
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 9f7fedee98..08a1f9dfa4 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -117,7 +117,7 @@ vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Devic
 vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
 vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%08x"
 vfio_legacy_dma_unmap_overflow_workaround(void) ""
-vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "container fd=%d, iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
+vfio_get_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
 vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
 
 # platform.c
-- 
2.34.1


