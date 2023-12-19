Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F3F81903B
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:03:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfL2-0007ow-Dg; Tue, 19 Dec 2023 14:01:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfK4-0005ue-Ju
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:00:10 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfK2-0007kE-8M
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:00:08 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SvmGX1QjLz4wc3;
 Wed, 20 Dec 2023 06:00:04 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvmGR5gzSz4xQj;
 Wed, 20 Dec 2023 05:59:59 +1100 (AEDT)
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
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Subject: [PULL 37/47] vfio: Make VFIOContainerBase poiner parameter const in
 VFIOIOMMUOps callbacks
Date: Tue, 19 Dec 2023 19:56:33 +0100
Message-ID: <20231219185643.725448-38-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219185643.725448-1-clg@redhat.com>
References: <20231219185643.725448-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=7/MV=H6=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Some of the callbacks in VFIOIOMMUOps pass VFIOContainerBase poiner,
those callbacks only need read access to the sub object of VFIOContainerBase.
So make VFIOContainerBase, VFIOContainer and VFIOIOMMUFDContainer as const
in these callbacks.

Local functions called by those callbacks also need same changes to avoid
build error.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h         | 12 ++++++----
 include/hw/vfio/vfio-container-base.h | 12 ++++++----
 hw/vfio/common.c                      |  9 +++----
 hw/vfio/container-base.c              |  2 +-
 hw/vfio/container.c                   | 34 ++++++++++++++-------------
 hw/vfio/iommufd.c                     |  8 +++----
 6 files changed, 42 insertions(+), 35 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 697bf24a350d5880e59811322d9037575a90d9a2..efcba19f6663af28bffacf954469a9986b8ae8f0 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -244,13 +244,15 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
 void vfio_migration_exit(VFIODevice *vbasedev);
 
 int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
-bool vfio_devices_all_running_and_mig_active(VFIOContainerBase *bcontainer);
-bool vfio_devices_all_device_dirty_tracking(VFIOContainerBase *bcontainer);
-int vfio_devices_query_dirty_bitmap(VFIOContainerBase *bcontainer,
+bool
+vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer);
+bool
+vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
+int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                                     VFIOBitmap *vbmap, hwaddr iova,
                                     hwaddr size);
-int vfio_get_dirty_bitmap(VFIOContainerBase *bcontainer, uint64_t iova,
-                                 uint64_t size, ram_addr_t ram_addr);
+int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
+                          uint64_t size, ram_addr_t ram_addr);
 
 /* Returns 0 on success, or a negative errno. */
 int vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 45bb19c7670e76ae142dbcd2bfc96f6e74ae160b..2ae297ccda93fd97986c852a8329b390fa1ab91f 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -82,7 +82,7 @@ void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
                                        MemoryRegionSection *section);
 int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
                                            bool start);
-int vfio_container_query_dirty_bitmap(VFIOContainerBase *bcontainer,
+int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                                       VFIOBitmap *vbmap,
                                       hwaddr iova, hwaddr size);
 
@@ -93,18 +93,20 @@ void vfio_container_destroy(VFIOContainerBase *bcontainer);
 
 struct VFIOIOMMUOps {
     /* basic feature */
-    int (*dma_map)(VFIOContainerBase *bcontainer,
+    int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
                    void *vaddr, bool readonly);
-    int (*dma_unmap)(VFIOContainerBase *bcontainer,
+    int (*dma_unmap)(const VFIOContainerBase *bcontainer,
                      hwaddr iova, ram_addr_t size,
                      IOMMUTLBEntry *iotlb);
     int (*attach_device)(const char *name, VFIODevice *vbasedev,
                          AddressSpace *as, Error **errp);
     void (*detach_device)(VFIODevice *vbasedev);
     /* migration feature */
-    int (*set_dirty_page_tracking)(VFIOContainerBase *bcontainer, bool start);
-    int (*query_dirty_bitmap)(VFIOContainerBase *bcontainer, VFIOBitmap *vbmap,
+    int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
+                                   bool start);
+    int (*query_dirty_bitmap)(const VFIOContainerBase *bcontainer,
+                              VFIOBitmap *vbmap,
                               hwaddr iova, hwaddr size);
     /* PCI specific */
     int (*pci_hot_reset)(VFIODevice *vbasedev, bool single);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 6569732b7a1d894ae08e38adb93dfd94aeca4075..08a3e576725b1fc9f2f7e425375df3b827c4fe56 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -204,7 +204,7 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
     return true;
 }
 
-bool vfio_devices_all_device_dirty_tracking(VFIOContainerBase *bcontainer)
+bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
 
@@ -221,7 +221,8 @@ bool vfio_devices_all_device_dirty_tracking(VFIOContainerBase *bcontainer)
  * Check if all VFIO devices are running and migration is active, which is
  * essentially equivalent to the migration being in pre-copy phase.
  */
-bool vfio_devices_all_running_and_mig_active(VFIOContainerBase *bcontainer)
+bool
+vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
 
@@ -1139,7 +1140,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
     return 0;
 }
 
-int vfio_devices_query_dirty_bitmap(VFIOContainerBase *bcontainer,
+int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                                     VFIOBitmap *vbmap, hwaddr iova,
                                     hwaddr size)
 {
@@ -1162,7 +1163,7 @@ int vfio_devices_query_dirty_bitmap(VFIOContainerBase *bcontainer,
     return 0;
 }
 
-int vfio_get_dirty_bitmap(VFIOContainerBase *bcontainer, uint64_t iova,
+int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
                           uint64_t size, ram_addr_t ram_addr)
 {
     bool all_device_dirty_tracking =
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index eee2dcfe760b5530ef428fe341d376a85b47344a..1ffd25bbfa8bd3d404e43b96357273b95f5a0031 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -63,7 +63,7 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
     return bcontainer->ops->set_dirty_page_tracking(bcontainer, start);
 }
 
-int vfio_container_query_dirty_bitmap(VFIOContainerBase *bcontainer,
+int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                                       VFIOBitmap *vbmap,
                                       hwaddr iova, hwaddr size)
 {
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 1dbf9b9a17e070ded853931757f5852d1e4568aa..b22feb8ded0a0d9ed98d6e206b78c0c6e2554d5c 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -61,11 +61,11 @@ static int vfio_ram_block_discard_disable(VFIOContainer *container, bool state)
     }
 }
 
-static int vfio_dma_unmap_bitmap(VFIOContainer *container,
+static int vfio_dma_unmap_bitmap(const VFIOContainer *container,
                                  hwaddr iova, ram_addr_t size,
                                  IOMMUTLBEntry *iotlb)
 {
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    const VFIOContainerBase *bcontainer = &container->bcontainer;
     struct vfio_iommu_type1_dma_unmap *unmap;
     struct vfio_bitmap *bitmap;
     VFIOBitmap vbmap;
@@ -117,11 +117,12 @@ unmap_exit:
 /*
  * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
  */
-static int vfio_legacy_dma_unmap(VFIOContainerBase *bcontainer, hwaddr iova,
-                                 ram_addr_t size, IOMMUTLBEntry *iotlb)
+static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
+                                 hwaddr iova, ram_addr_t size,
+                                 IOMMUTLBEntry *iotlb)
 {
-    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                            bcontainer);
+    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
+                                                  bcontainer);
     struct vfio_iommu_type1_dma_unmap unmap = {
         .argsz = sizeof(unmap),
         .flags = 0,
@@ -174,11 +175,11 @@ static int vfio_legacy_dma_unmap(VFIOContainerBase *bcontainer, hwaddr iova,
     return 0;
 }
 
-static int vfio_legacy_dma_map(VFIOContainerBase *bcontainer, hwaddr iova,
+static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                                ram_addr_t size, void *vaddr, bool readonly)
 {
-    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                            bcontainer);
+    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
+                                                  bcontainer);
     struct vfio_iommu_type1_dma_map map = {
         .argsz = sizeof(map),
         .flags = VFIO_DMA_MAP_FLAG_READ,
@@ -207,11 +208,12 @@ static int vfio_legacy_dma_map(VFIOContainerBase *bcontainer, hwaddr iova,
     return -errno;
 }
 
-static int vfio_legacy_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
-                                               bool start)
+static int
+vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
+                                    bool start)
 {
-    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                            bcontainer);
+    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
+                                                  bcontainer);
     int ret;
     struct vfio_iommu_type1_dirty_bitmap dirty = {
         .argsz = sizeof(dirty),
@@ -233,12 +235,12 @@ static int vfio_legacy_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
     return ret;
 }
 
-static int vfio_legacy_query_dirty_bitmap(VFIOContainerBase *bcontainer,
+static int vfio_legacy_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                                           VFIOBitmap *vbmap,
                                           hwaddr iova, hwaddr size)
 {
-    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                            bcontainer);
+    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
+                                                  bcontainer);
     struct vfio_iommu_type1_dirty_bitmap *dbitmap;
     struct vfio_iommu_type1_dirty_bitmap_get *range;
     int ret;
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 5accd2648444defcd698bd6d0cefe11d255b4cfb..87a561c54580adc6d7b2711331a00940ff13bd43 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -26,10 +26,10 @@
 #include "qemu/chardev_open.h"
 #include "pci.h"
 
-static int iommufd_cdev_map(VFIOContainerBase *bcontainer, hwaddr iova,
+static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly)
 {
-    VFIOIOMMUFDContainer *container =
+    const VFIOIOMMUFDContainer *container =
         container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
 
     return iommufd_backend_map_dma(container->be,
@@ -37,11 +37,11 @@ static int iommufd_cdev_map(VFIOContainerBase *bcontainer, hwaddr iova,
                                    iova, size, vaddr, readonly);
 }
 
-static int iommufd_cdev_unmap(VFIOContainerBase *bcontainer,
+static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
                               hwaddr iova, ram_addr_t size,
                               IOMMUTLBEntry *iotlb)
 {
-    VFIOIOMMUFDContainer *container =
+    const VFIOIOMMUFDContainer *container =
         container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
 
     /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
-- 
2.43.0


