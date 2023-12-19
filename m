Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEE581902C
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:00:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfHj-00020h-Gf; Tue, 19 Dec 2023 13:57:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfHh-000201-0C
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:57:41 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfHe-00070j-Dg
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:57:40 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SvmCh0GP0z4xLy;
 Wed, 20 Dec 2023 05:57:36 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvmCb2K8tz4xCp;
 Wed, 20 Dec 2023 05:57:31 +1100 (AEDT)
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
Subject: [PULL 07/47] vfio/container: Switch to IOMMU BE
 set_dirty_page_tracking/query_dirty_bitmap API
Date: Tue, 19 Dec 2023 19:56:03 +0100
Message-ID: <20231219185643.725448-8-clg@redhat.com>
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

dirty_pages_supported field is also moved to the base container

No functional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h         |  6 ------
 include/hw/vfio/vfio-container-base.h |  6 ++++++
 hw/vfio/common.c                      | 12 ++++++++----
 hw/vfio/container-base.c              | 16 ++++++++++++++++
 hw/vfio/container.c                   | 21 ++++++++++++++-------
 5 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index bd4de6cb3aff7cb85e34960fe4238d82b30867cd..60f2785fe07cf71e3c65e85d933536c09170f4c6 100644
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
index c7cc6ec9c55e93e4f7c6be5576ed59b5dea58b1e..f244f003d080a30e95b6daa97a132eeb5a271ae4 100644
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
index 1d8202537ea4f27f49f2d477537d6c7c557bd61f..b1a875ca93a44347f3652298995b89b5d9aed045 100644
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
index 3933391e0db26116401509c5917eaceabcd98443..5d654ae17233fe06c235d33d981eb8fa92128536 100644
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
index f12fcb6fe11d578838b1052f70ee5099b9018e94..3ab74e26151efd7ae4027ed3b4cf04a835083ccc 100644
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
2.43.0


