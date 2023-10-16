Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F27E47CA246
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:48:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJGS-0007as-S4; Mon, 16 Oct 2023 04:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJGI-0007a8-BS
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:47:42 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJGF-0001AB-Hj
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697446059; x=1728982059;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wwMa75z1K7uUrZlbf9iq+WuE2zAedNKoviONdhuiOVU=;
 b=XpLD+0XN8s3E+ljsoxQDHuZJeV8Lb3wSEMHH0h1MxngLQFM/psVK+IQ8
 haXiDDRZkJzVLs5DG4bIeU65YAwVAAkwBr/dSAZX/h+rgXQibSN5nVJEJ
 lbyhyzvhUteJiD6ndS1iyvM1HPhsKlsEEcnCYTTZdZsOzzukUDyyl5wOG
 yxrVH5+ibSp6Ta419yPSOKUygRBRc2enPDDsDQ5qaR0VjoGla18u0Eflf
 23awH3oQF9GFPF5qKZyorISguoXTIUmU0xOvyDN9VtFxr2o29hMXyPnE+
 tcT2G81hpEpYwKxuf81TlvrcNgNTJqIbevO3BPd2jB+GV2MGqCCyH6EsX Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365737538"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="365737538"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:47:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="749222703"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="749222703"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:47:33 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 05/27] vfio/common: Move giommu_list in base container
Date: Mon, 16 Oct 2023 16:32:01 +0800
Message-Id: <20231016083223.1519410-6-zhenzhong.duan@intel.com>
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

Move the giommu_list field in the base object and store the
base container in the VFIOGuestIOMMU.

We introduce vfio_container_init/destroy helper on the base
container.

No fucntional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h         |  9 ---------
 include/hw/vfio/vfio-container-base.h | 13 +++++++++++++
 hw/vfio/common.c                      | 18 ++++++++++++------
 hw/vfio/container-base.c              | 19 +++++++++++++++++++
 hw/vfio/container.c                   | 13 +++----------
 5 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index f2aa122c47..884d1627f4 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -95,7 +95,6 @@ typedef struct VFIOLegacyContainer {
     uint64_t max_dirty_bitmap_size;
     unsigned long pgsizes;
     unsigned int dma_max_mappings;
-    QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     QLIST_HEAD(, VFIOGroup) group_list;
     QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
@@ -103,14 +102,6 @@ typedef struct VFIOLegacyContainer {
     QLIST_HEAD(, VFIODevice) device_list;
 } VFIOLegacyContainer;
 
-typedef struct VFIOGuestIOMMU {
-    VFIOLegacyContainer *container;
-    IOMMUMemoryRegion *iommu_mr;
-    hwaddr iommu_offset;
-    IOMMUNotifier n;
-    QLIST_ENTRY(VFIOGuestIOMMU) giommu_next;
-} VFIOGuestIOMMU;
-
 typedef struct VFIORamDiscardListener {
     VFIOLegacyContainer *container;
     MemoryRegion *mr;
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 1483e77441..b6c8eb2313 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -33,6 +33,14 @@ typedef struct VFIOContainer VFIOContainer;
 typedef struct VFIODevice VFIODevice;
 typedef struct VFIOIOMMUBackendOpsClass VFIOIOMMUBackendOpsClass;
 
+typedef struct VFIOGuestIOMMU {
+    VFIOContainer *bcontainer;
+    IOMMUMemoryRegion *iommu_mr;
+    hwaddr iommu_offset;
+    IOMMUNotifier n;
+    QLIST_ENTRY(VFIOGuestIOMMU) giommu_next;
+} VFIOGuestIOMMU;
+
 typedef struct {
     unsigned long *bitmap;
     hwaddr size;
@@ -44,6 +52,7 @@ typedef struct {
  */
 struct VFIOContainer {
     VFIOIOMMUBackendOpsClass *ops;
+    QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
 };
 
 int vfio_container_dma_map(VFIOContainer *bcontainer,
@@ -53,6 +62,10 @@ int vfio_container_dma_unmap(VFIOContainer *bcontainer,
                              hwaddr iova, ram_addr_t size,
                              IOMMUTLBEntry *iotlb);
 
+void vfio_container_init(VFIOContainer *bcontainer,
+                         struct VFIOIOMMUBackendOpsClass *ops);
+void vfio_container_destroy(VFIOContainer *bcontainer);
+
 #define TYPE_VFIO_IOMMU_BACKEND_LEGACY_OPS "vfio-iommu-backend-legacy-ops"
 #define TYPE_VFIO_IOMMU_BACKEND_OPS "vfio-iommu-backend-ops"
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 6be1526d79..1adfdca4f5 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -337,7 +337,7 @@ static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
 static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
 {
     VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
-    VFIOContainer *bcontainer = &giommu->container->bcontainer;
+    VFIOContainer *bcontainer = giommu->bcontainer;
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
     void *vaddr;
     int ret;
@@ -632,6 +632,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
     VFIOLegacyContainer *container = container_of(listener,
                                                   VFIOLegacyContainer,
                                                   listener);
+    VFIOContainer *bcontainer = &container->bcontainer;
     hwaddr iova, end;
     Int128 llend, llsize;
     void *vaddr;
@@ -683,7 +684,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
         giommu->iommu_mr = iommu_mr;
         giommu->iommu_offset = section->offset_within_address_space -
                                section->offset_within_region;
-        giommu->container = container;
+        giommu->bcontainer = bcontainer;
         llend = int128_add(int128_make64(section->offset_within_region),
                            section->size);
         llend = int128_sub(llend, int128_one());
@@ -709,7 +710,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
             g_free(giommu);
             goto fail;
         }
-        QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
+        QLIST_INSERT_HEAD(&bcontainer->giommu_list, giommu, giommu_next);
         memory_region_iommu_replay(giommu->iommu_mr, &giommu->n);
 
         return;
@@ -796,6 +797,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
     VFIOLegacyContainer *container = container_of(listener,
                                                   VFIOLegacyContainer,
                                                   listener);
+    VFIOContainer *bcontainer = &container->bcontainer;
     hwaddr iova, end;
     Int128 llend, llsize;
     int ret;
@@ -808,7 +810,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
     if (memory_region_is_iommu(section->mr)) {
         VFIOGuestIOMMU *giommu;
 
-        QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
+        QLIST_FOREACH(giommu, &bcontainer->giommu_list, giommu_next) {
             if (MEMORY_REGION(giommu->iommu_mr) == section->mr &&
                 giommu->n.start == section->offset_within_region) {
                 memory_region_unregister_iommu_notifier(section->mr,
@@ -1278,7 +1280,10 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     vfio_giommu_dirty_notifier *gdn = container_of(n,
                                                 vfio_giommu_dirty_notifier, n);
     VFIOGuestIOMMU *giommu = gdn->giommu;
-    VFIOLegacyContainer *container = giommu->container;
+    VFIOContainer *bcontainer = giommu->bcontainer;
+    VFIOLegacyContainer *container = container_of(bcontainer,
+                                                  VFIOLegacyContainer,
+                                                  bcontainer);
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
     ram_addr_t translated_addr;
     int ret = -EINVAL;
@@ -1357,12 +1362,13 @@ vfio_sync_ram_discard_listener_dirty_bitmap(VFIOLegacyContainer *container,
 static int vfio_sync_dirty_bitmap(VFIOLegacyContainer *container,
                                   MemoryRegionSection *section)
 {
+    VFIOContainer *bcontainer = &container->bcontainer;
     ram_addr_t ram_addr;
 
     if (memory_region_is_iommu(section->mr)) {
         VFIOGuestIOMMU *giommu;
 
-        QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
+        QLIST_FOREACH(giommu, &bcontainer->giommu_list, giommu_next) {
             if (MEMORY_REGION(giommu->iommu_mr) == section->mr &&
                 giommu->n.start == section->offset_within_region) {
                 Int128 llend;
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 78329935f6..6da50e8151 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -48,6 +48,25 @@ int vfio_container_dma_unmap(VFIOContainer *bcontainer,
     return bcontainer->ops->dma_unmap(bcontainer, iova, size, iotlb);
 }
 
+void vfio_container_init(VFIOContainer *bcontainer,
+                         struct VFIOIOMMUBackendOpsClass *ops)
+{
+    bcontainer->ops = ops;
+    QLIST_INIT(&bcontainer->giommu_list);
+}
+
+void vfio_container_destroy(VFIOContainer *bcontainer)
+{
+    VFIOGuestIOMMU *giommu, *tmp;
+
+    QLIST_FOREACH_SAFE(giommu, &bcontainer->giommu_list, giommu_next, tmp) {
+        memory_region_unregister_iommu_notifier(
+                MEMORY_REGION(giommu->iommu_mr), &giommu->n);
+        QLIST_REMOVE(giommu, giommu_next);
+        g_free(giommu);
+    }
+}
+
 static const TypeInfo vfio_iommu_backend_ops_type_info = {
     .name = TYPE_VFIO_IOMMU_BACKEND_OPS,
     .parent = TYPE_OBJECT,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 80aafa21ed..de6b018eeb 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -629,11 +629,10 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container->error = NULL;
     container->dirty_pages_supported = false;
     container->dma_max_mappings = 0;
-    QLIST_INIT(&container->giommu_list);
     QLIST_INIT(&container->hostwin_list);
     QLIST_INIT(&container->vrdl_list);
     bcontainer = &container->bcontainer;
-    bcontainer->ops = ops;
+    vfio_container_init(bcontainer, ops);
 
     ret = vfio_init_container(container, group->fd, errp);
     if (ret) {
@@ -794,6 +793,7 @@ put_space_exit:
 static void vfio_disconnect_container(VFIOGroup *group)
 {
     VFIOLegacyContainer *container = group->container;
+    VFIOContainer *bcontainer = &container->bcontainer;
 
     QLIST_REMOVE(group, container_next);
     group->container = NULL;
@@ -814,17 +814,10 @@ static void vfio_disconnect_container(VFIOGroup *group)
 
     if (QLIST_EMPTY(&container->group_list)) {
         VFIOAddressSpace *space = container->space;
-        VFIOGuestIOMMU *giommu, *tmp;
         VFIOHostDMAWindow *hostwin, *next;
 
         QLIST_REMOVE(container, next);
-
-        QLIST_FOREACH_SAFE(giommu, &container->giommu_list, giommu_next, tmp) {
-            memory_region_unregister_iommu_notifier(
-                    MEMORY_REGION(giommu->iommu_mr), &giommu->n);
-            QLIST_REMOVE(giommu, giommu_next);
-            g_free(giommu);
-        }
+        vfio_container_destroy(bcontainer);
 
         QLIST_FOREACH_SAFE(hostwin, &container->hostwin_list, hostwin_next,
                            next) {
-- 
2.34.1


