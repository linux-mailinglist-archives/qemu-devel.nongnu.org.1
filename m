Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF907E6A3D
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 13:02:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r13k9-0002xM-KN; Thu, 09 Nov 2023 07:02:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r13jo-0002dH-Lv
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:02:22 -0500
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r13jj-0001ej-AG
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:02:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699531335; x=1731067335;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4Bbj42T/4tRYWkgKM+VfLJjxY5boplBsXEJPbwe5PHQ=;
 b=Mk/QE6mj05WIQ4XCpbHdm2obdgXtF05ufUDWmc5rjhAjZgxptooVZAgX
 anaml6FjYg/iXDaxMaPZwZcSlDXMGSOhaox9UxpZ5iYP69Rqb7Rm8jTlZ
 VlFv/Rl4YJsk5287iMHDxCdiJbuiEcWAZKd7cJUkzkbNKJ4Dt7Z5ku3wg
 GGAetbX/sO7jzBwpVuSpgmK5mvFvLsb6wXi4WMYm9pyUriCgsjGEW9EDo
 y3vznNsDWfP2hO3GAWvZJCuAVyqFC6eK6U3yRpFoK8iTLrOFQCH+0OdbM
 am7RFXre/b1g+y1Dq8g+tSpUg+P9j117rgzUhaVnBPLu1QDflI+S6XVqx A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="369305903"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; d="scan'208";a="369305903"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 04:02:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; d="scan'208";a="11516222"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 04:02:00 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 17/20] vfio: Make VFIOContainerBase poiner parameter const
 in VFIOIOMMUOps callbacks
Date: Thu,  9 Nov 2023 19:45:26 +0800
Message-Id: <20231109114529.1904193-18-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
References: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Some of the callbacks in VFIOIOMMUOps pass VFIOContainerBase poiner,
those callbacks only need read access to the sub object of VFIOContainerBase.
So make VFIOContainerBase, VFIOContainer and VFIOIOMMUFDContainer as const
in these callbacks.

Local functions called by those callbacks also need same changes to avoid
build error.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h         | 12 ++++++----
 include/hw/vfio/vfio-container-base.h | 12 ++++++----
 hw/vfio/common.c                      |  9 +++----
 hw/vfio/container-base.c              |  2 +-
 hw/vfio/container.c                   | 34 ++++++++++++++-------------
 hw/vfio/iommufd.c                     |  8 +++----
 6 files changed, 42 insertions(+), 35 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 960a14e8d8..b3ba22acc3 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -245,11 +245,13 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
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
 #endif /* HW_VFIO_VFIO_COMMON_H */
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 45bb19c767..2ae297ccda 100644
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
index 3b7e11158f..8ca52d9636 100644
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
index eee2dcfe76..1ffd25bbfa 100644
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
index cb957d063b..6180e71e3a 100644
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
index fd30477275..e13c685255 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -26,10 +26,10 @@
 #include "qemu/chardev_open.h"
 #include "pci.h"
 
-static int iommufd_map(VFIOContainerBase *bcontainer, hwaddr iova,
+static int iommufd_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                        ram_addr_t size, void *vaddr, bool readonly)
 {
-    VFIOIOMMUFDContainer *container =
+    const VFIOIOMMUFDContainer *container =
         container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
 
     return iommufd_backend_map_dma(container->be,
@@ -37,11 +37,11 @@ static int iommufd_map(VFIOContainerBase *bcontainer, hwaddr iova,
                                    iova, size, vaddr, readonly);
 }
 
-static int iommufd_unmap(VFIOContainerBase *bcontainer,
+static int iommufd_unmap(const VFIOContainerBase *bcontainer,
                          hwaddr iova, ram_addr_t size,
                          IOMMUTLBEntry *iotlb)
 {
-    VFIOIOMMUFDContainer *container =
+    const VFIOIOMMUFDContainer *container =
         container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
 
     /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
-- 
2.34.1


