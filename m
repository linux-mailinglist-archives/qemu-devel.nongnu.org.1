Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F9E7DED72
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:36:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qySBN-0005N7-GH; Thu, 02 Nov 2023 03:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qySB9-0004n5-Hw
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:31:50 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qySB4-0003OZ-1g
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698910302; x=1730446302;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=V79B63jbxqsm8f4qWarh0zT/m5obcDJzksGaxcQ4Q3s=;
 b=ICVsx2AjqY5kBHfxyHmdTh19n0G9lm1NN+CrkcT5x2mU85Aw02jHQNj9
 Fowj1pzwgi3MJyIVV/+rv22mY9bXghdOajaYAh/7jvER2ZoyxHuMYmZNm
 QeEOnLglcvb2mpbmPRvVQWRu7UiDNIT+zYmlSJsekHYW3QhbIBWw2E6tW
 fpyQRwjttTnTrTO2UTysk6wHS8izxfkfSPW65XcTm5/S9oz59Sa3Cx4EF
 acFvjt+bBHVdv/4pu46m+XXwvyjFqwIDg32kTf0os+tXvesw+BeJwwvge
 uxhQKtMQhcDcG02SDvrYAi127bwy4ialE7Ea0tdBPSktkB1oz9S5YzYNu g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452953560"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="452953560"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:31:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711055830"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="711055830"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:31:15 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 40/41] vfio: Make VFIOContainerBase poiner parameter const
 in VFIOIOMMUOps callbacks
Date: Thu,  2 Nov 2023 15:13:01 +0800
Message-Id: <20231102071302.1818071-41-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 854c32e4ce..2fc976c7f0 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -257,11 +257,13 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
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
index a61dce2845..1c9203183d 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -203,7 +203,7 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
     return true;
 }
 
-bool vfio_devices_all_device_dirty_tracking(VFIOContainerBase *bcontainer)
+bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
 
@@ -220,7 +220,8 @@ bool vfio_devices_all_device_dirty_tracking(VFIOContainerBase *bcontainer)
  * Check if all VFIO devices are running and migration is active, which is
  * essentially equivalent to the migration being in pre-copy phase.
  */
-bool vfio_devices_all_running_and_mig_active(VFIOContainerBase *bcontainer)
+bool
+vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
 
@@ -1138,7 +1139,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
     return 0;
 }
 
-int vfio_devices_query_dirty_bitmap(VFIOContainerBase *bcontainer,
+int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                                     VFIOBitmap *vbmap, hwaddr iova,
                                     hwaddr size)
 {
@@ -1161,7 +1162,7 @@ int vfio_devices_query_dirty_bitmap(VFIOContainerBase *bcontainer,
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
index f27cc15d09..31681db52b 100644
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
index 1fb1c7e853..ea33e64933 100644
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


