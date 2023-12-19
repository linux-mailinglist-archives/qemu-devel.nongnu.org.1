Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0105819039
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:03:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfHZ-0001ye-78; Tue, 19 Dec 2023 13:57:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfHW-0001yS-Vv
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:57:31 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfHU-0006zr-OJ
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:57:30 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SvmCT3sXNz4wcJ;
 Wed, 20 Dec 2023 05:57:25 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvmCN6SRSz4wx5;
 Wed, 20 Dec 2023 05:57:20 +1100 (AEDT)
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
Subject: [PULL 05/47] vfio/common: Move giommu_list in base container
Date: Tue, 19 Dec 2023 19:56:01 +0100
Message-ID: <20231219185643.725448-6-clg@redhat.com>
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

From: Eric Auger <eric.auger@redhat.com>

Move the giommu_list field in the base container and store
the base container in the VFIOGuestIOMMU.

No functional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h         |  9 ---------
 include/hw/vfio/vfio-container-base.h |  9 +++++++++
 hw/vfio/common.c                      | 17 +++++++++++------
 hw/vfio/container-base.c              |  9 +++++++++
 hw/vfio/container.c                   |  8 --------
 5 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 24a26345e5aa6094706dcf1301eeaf44ac91840d..6be082b8f20c2dfa28dbed85c343667ea20e2b73 100644
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
index 577f52ccbc0e6d3b48d733c3bec0c1a2435d3e32..a11aec575544d7a4f29c0e33200ed962568372cf 100644
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
index e610771888491c8cd19883cdf91ad1589c843e27..43580bcc43c72336a50b002e17f4415035aa8798 100644
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
index e929435751d3bef179218f667f48e0419c352df4..20bcb9669a6122f951119c025b9950854c53f88e 100644
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
index 32a0251dd1673ef9f47f8a0db9f7dd113841b7d8..133d3c8f5c08e6476cebb3c707ebd115a068af2d 100644
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
2.43.0


