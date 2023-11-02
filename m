Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE5C7DED4E
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:30:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyS8g-0003MA-CP; Thu, 02 Nov 2023 03:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS8d-0003Lj-Un
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:29:11 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS8a-0003Iu-VY
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698910149; x=1730446149;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wBFdYQwS8ayEuu44wagwcT+o6v+ysmUkaKsw6smiBH0=;
 b=UucAgDNmR0dfXKxXUM/QRe7aUdTN8guJw63ZVyUyysU5fUAAKtZBr/Rc
 5kthv2lotz9Yy3ZD2RCp8l4FDFXmLA5hgpACMFSbg3XqRCy7Idu0t7396
 rPoon3gi8k24VQLCvL0XeyrKV9VQLg6N3a5HMo7Lju4/w1LRY7WrTD+BH
 P8F3T2qj+LRcfeFSPznyrJkwCkIDg26fGkXncwZtFOqCiukpSF2DKQdWM
 YVPV1tbdH1105yHZCyWLuJzSlzrevyCj8e1qvc03Gzr6L4LO+iokErSuz
 g/pgwi8SSmDqlwIPhHgbqLxfxa/xjitcsnvFo2WY5SzTV3W2W1P1Zq9io Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452953124"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="452953124"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:29:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711055300"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="711055300"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:29:04 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 10/41] vfio/common: Move giommu_list in base container
Date: Thu,  2 Nov 2023 15:12:31 +0800
Message-Id: <20231102071302.1818071-11-zhenzhong.duan@intel.com>
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

From: Eric Auger <eric.auger@redhat.com>

Move the giommu_list field in the base container and store
the base container in the VFIOGuestIOMMU.

No functional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h         |  9 ---------
 include/hw/vfio/vfio-container-base.h |  9 +++++++++
 hw/vfio/common.c                      | 17 +++++++++++------
 hw/vfio/container-base.c              |  9 +++++++++
 hw/vfio/container.c                   |  8 --------
 5 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 24a26345e5..6be082b8f2 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -95,7 +95,6 @@ typedef struct VFIOContainer {
     uint64_t max_dirty_bitmap_size;
     unsigned long pgsizes;
     unsigned int dma_max_mappings;
-    QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     QLIST_HEAD(, VFIOGroup) group_list;
     QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
@@ -104,14 +103,6 @@ typedef struct VFIOContainer {
     GList *iova_ranges;
 } VFIOContainer;
 
-typedef struct VFIOGuestIOMMU {
-    VFIOContainer *container;
-    IOMMUMemoryRegion *iommu_mr;
-    hwaddr iommu_offset;
-    IOMMUNotifier n;
-    QLIST_ENTRY(VFIOGuestIOMMU) giommu_next;
-} VFIOGuestIOMMU;
-
 typedef struct VFIORamDiscardListener {
     VFIOContainer *container;
     MemoryRegion *mr;
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 577f52ccbc..a11aec5755 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -29,8 +29,17 @@ typedef struct {
  */
 typedef struct VFIOContainerBase {
     const VFIOIOMMUOps *ops;
+    QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
 } VFIOContainerBase;
 
+typedef struct VFIOGuestIOMMU {
+    VFIOContainerBase *bcontainer;
+    IOMMUMemoryRegion *iommu_mr;
+    hwaddr iommu_offset;
+    IOMMUNotifier n;
+    QLIST_ENTRY(VFIOGuestIOMMU) giommu_next;
+} VFIOGuestIOMMU;
+
 int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            hwaddr iova, ram_addr_t size,
                            void *vaddr, bool readonly);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index e610771888..43580bcc43 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -292,7 +292,7 @@ static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
 static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
 {
     VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
-    VFIOContainerBase *bcontainer = &giommu->container->bcontainer;
+    VFIOContainerBase *bcontainer = giommu->bcontainer;
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
     void *vaddr;
     int ret;
@@ -569,6 +569,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
                                      MemoryRegionSection *section)
 {
     VFIOContainer *container = container_of(listener, VFIOContainer, listener);
+    VFIOContainerBase *bcontainer = &container->bcontainer;
     hwaddr iova, end;
     Int128 llend, llsize;
     void *vaddr;
@@ -612,7 +613,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
         giommu->iommu_mr = iommu_mr;
         giommu->iommu_offset = section->offset_within_address_space -
                                section->offset_within_region;
-        giommu->container = container;
+        giommu->bcontainer = bcontainer;
         llend = int128_add(int128_make64(section->offset_within_region),
                            section->size);
         llend = int128_sub(llend, int128_one());
@@ -647,7 +648,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
             g_free(giommu);
             goto fail;
         }
-        QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
+        QLIST_INSERT_HEAD(&bcontainer->giommu_list, giommu, giommu_next);
         memory_region_iommu_replay(giommu->iommu_mr, &giommu->n);
 
         return;
@@ -732,6 +733,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
                                      MemoryRegionSection *section)
 {
     VFIOContainer *container = container_of(listener, VFIOContainer, listener);
+    VFIOContainerBase *bcontainer = &container->bcontainer;
     hwaddr iova, end;
     Int128 llend, llsize;
     int ret;
@@ -744,7 +746,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
     if (memory_region_is_iommu(section->mr)) {
         VFIOGuestIOMMU *giommu;
 
-        QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
+        QLIST_FOREACH(giommu, &bcontainer->giommu_list, giommu_next) {
             if (MEMORY_REGION(giommu->iommu_mr) == section->mr &&
                 giommu->n.start == section->offset_within_region) {
                 memory_region_unregister_iommu_notifier(section->mr,
@@ -1206,7 +1208,9 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     vfio_giommu_dirty_notifier *gdn = container_of(n,
                                                 vfio_giommu_dirty_notifier, n);
     VFIOGuestIOMMU *giommu = gdn->giommu;
-    VFIOContainer *container = giommu->container;
+    VFIOContainerBase *bcontainer = giommu->bcontainer;
+    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
+                                            bcontainer);
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
     ram_addr_t translated_addr;
     int ret = -EINVAL;
@@ -1284,12 +1288,13 @@ static int vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainer *container,
 static int vfio_sync_dirty_bitmap(VFIOContainer *container,
                                   MemoryRegionSection *section)
 {
+    VFIOContainerBase *bcontainer = &container->bcontainer;
     ram_addr_t ram_addr;
 
     if (memory_region_is_iommu(section->mr)) {
         VFIOGuestIOMMU *giommu;
 
-        QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
+        QLIST_FOREACH(giommu, &bcontainer->giommu_list, giommu_next) {
             if (MEMORY_REGION(giommu->iommu_mr) == section->mr &&
                 giommu->n.start == section->offset_within_region) {
                 Int128 llend;
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index e929435751..20bcb9669a 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -34,8 +34,17 @@ int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
 void vfio_container_init(VFIOContainerBase *bcontainer, const VFIOIOMMUOps *ops)
 {
     bcontainer->ops = ops;
+    QLIST_INIT(&bcontainer->giommu_list);
 }
 
 void vfio_container_destroy(VFIOContainerBase *bcontainer)
 {
+    VFIOGuestIOMMU *giommu, *tmp;
+
+    QLIST_FOREACH_SAFE(giommu, &bcontainer->giommu_list, giommu_next, tmp) {
+        memory_region_unregister_iommu_notifier(
+                MEMORY_REGION(giommu->iommu_mr), &giommu->n);
+        QLIST_REMOVE(giommu, giommu_next);
+        g_free(giommu);
+    }
 }
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 32a0251dd1..133d3c8f5c 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -556,7 +556,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container->dirty_pages_supported = false;
     container->dma_max_mappings = 0;
     container->iova_ranges = NULL;
-    QLIST_INIT(&container->giommu_list);
     QLIST_INIT(&container->vrdl_list);
     bcontainer = &container->bcontainer;
     vfio_container_init(bcontainer, &vfio_legacy_ops);
@@ -686,16 +685,9 @@ static void vfio_disconnect_container(VFIOGroup *group)
 
     if (QLIST_EMPTY(&container->group_list)) {
         VFIOAddressSpace *space = container->space;
-        VFIOGuestIOMMU *giommu, *tmp;
 
         QLIST_REMOVE(container, next);
 
-        QLIST_FOREACH_SAFE(giommu, &container->giommu_list, giommu_next, tmp) {
-            memory_region_unregister_iommu_notifier(
-                    MEMORY_REGION(giommu->iommu_mr), &giommu->n);
-            QLIST_REMOVE(giommu, giommu_next);
-            g_free(giommu);
-        }
         vfio_container_destroy(bcontainer);
 
         trace_vfio_disconnect_container(container->fd);
-- 
2.34.1


