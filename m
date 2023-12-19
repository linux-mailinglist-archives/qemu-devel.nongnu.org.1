Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C06819017
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 19:58:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfI2-0002KJ-30; Tue, 19 Dec 2023 13:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfI0-0002Jj-B3
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:58:00 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfHy-00072g-74
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:58:00 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SvmD312vjz4xQZ;
 Wed, 20 Dec 2023 05:57:55 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvmCz0gCpz4xCp;
 Wed, 20 Dec 2023 05:57:50 +1100 (AEDT)
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
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 11/47] vfio/container: Move vrdl_list to base container
Date: Tue, 19 Dec 2023 19:56:07 +0100
Message-ID: <20231219185643.725448-12-clg@redhat.com>
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

No functional change intended.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h         | 11 --------
 include/hw/vfio/vfio-container-base.h | 11 ++++++++
 hw/vfio/common.c                      | 38 +++++++++++++--------------
 hw/vfio/container-base.c              |  1 +
 hw/vfio/container.c                   |  1 -
 5 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index d3dc2f9dcbde9abf57fa1592604f60caa3cb0137..8a607a4c1762afbd2f9525c69bb9ba83d194d8f6 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -87,20 +87,9 @@ typedef struct VFIOContainer {
     uint64_t max_dirty_bitmap_size;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     QLIST_HEAD(, VFIOGroup) group_list;
-    QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
     GList *iova_ranges;
 } VFIOContainer;
 
-typedef struct VFIORamDiscardListener {
-    VFIOContainer *container;
-    MemoryRegion *mr;
-    hwaddr offset_within_address_space;
-    hwaddr size;
-    uint64_t granularity;
-    RamDiscardListener listener;
-    QLIST_ENTRY(VFIORamDiscardListener) next;
-} VFIORamDiscardListener;
-
 typedef struct VFIOHostDMAWindow {
     hwaddr min_iova;
     hwaddr max_iova;
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 85ec7e1a561af641ae2261c775332afb8e76c838..8e05b5ac5a1b252365c39310c64e77fd63dbb9ee 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -40,6 +40,7 @@ typedef struct VFIOContainerBase {
     unsigned int dma_max_mappings;
     bool dirty_pages_supported;
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
+    QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
     QLIST_ENTRY(VFIOContainerBase) next;
     QLIST_HEAD(, VFIODevice) device_list;
 } VFIOContainerBase;
@@ -52,6 +53,16 @@ typedef struct VFIOGuestIOMMU {
     QLIST_ENTRY(VFIOGuestIOMMU) giommu_next;
 } VFIOGuestIOMMU;
 
+typedef struct VFIORamDiscardListener {
+    VFIOContainerBase *bcontainer;
+    MemoryRegion *mr;
+    hwaddr offset_within_address_space;
+    hwaddr size;
+    uint64_t granularity;
+    RamDiscardListener listener;
+    QLIST_ENTRY(VFIORamDiscardListener) next;
+} VFIORamDiscardListener;
+
 int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            hwaddr iova, ram_addr_t size,
                            void *vaddr, bool readonly);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 1cb53d369e871090b4d58dc6d5dd4d6cdfe455c4..f15665789fa5f99e0ec440696434679a8142fb48 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -351,13 +351,13 @@ static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
 {
     VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
                                                 listener);
+    VFIOContainerBase *bcontainer = vrdl->bcontainer;
     const hwaddr size = int128_get64(section->size);
     const hwaddr iova = section->offset_within_address_space;
     int ret;
 
     /* Unmap with a single call. */
-    ret = vfio_container_dma_unmap(&vrdl->container->bcontainer,
-                                   iova, size , NULL);
+    ret = vfio_container_dma_unmap(bcontainer, iova, size , NULL);
     if (ret) {
         error_report("%s: vfio_container_dma_unmap() failed: %s", __func__,
                      strerror(-ret));
@@ -369,6 +369,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
 {
     VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
                                                 listener);
+    VFIOContainerBase *bcontainer = vrdl->bcontainer;
     const hwaddr end = section->offset_within_region +
                        int128_get64(section->size);
     hwaddr start, next, iova;
@@ -387,8 +388,8 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
                section->offset_within_address_space;
         vaddr = memory_region_get_ram_ptr(section->mr) + start;
 
-        ret = vfio_container_dma_map(&vrdl->container->bcontainer, iova,
-                                     next - start, vaddr, section->readonly);
+        ret = vfio_container_dma_map(bcontainer, iova, next - start,
+                                     vaddr, section->readonly);
         if (ret) {
             /* Rollback */
             vfio_ram_discard_notify_discard(rdl, section);
@@ -398,10 +399,9 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
     return 0;
 }
 
-static void vfio_register_ram_discard_listener(VFIOContainer *container,
+static void vfio_register_ram_discard_listener(VFIOContainerBase *bcontainer,
                                                MemoryRegionSection *section)
 {
-    VFIOContainerBase *bcontainer = &container->bcontainer;
     RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
     VFIORamDiscardListener *vrdl;
 
@@ -412,7 +412,7 @@ static void vfio_register_ram_discard_listener(VFIOContainer *container,
     g_assert(QEMU_IS_ALIGNED(int128_get64(section->size), TARGET_PAGE_SIZE));
 
     vrdl = g_new0(VFIORamDiscardListener, 1);
-    vrdl->container = container;
+    vrdl->bcontainer = bcontainer;
     vrdl->mr = section->mr;
     vrdl->offset_within_address_space = section->offset_within_address_space;
     vrdl->size = int128_get64(section->size);
@@ -427,7 +427,7 @@ static void vfio_register_ram_discard_listener(VFIOContainer *container,
                               vfio_ram_discard_notify_populate,
                               vfio_ram_discard_notify_discard, true);
     ram_discard_manager_register_listener(rdm, &vrdl->listener, section);
-    QLIST_INSERT_HEAD(&container->vrdl_list, vrdl, next);
+    QLIST_INSERT_HEAD(&bcontainer->vrdl_list, vrdl, next);
 
     /*
      * Sanity-check if we have a theoretically problematic setup where we could
@@ -451,7 +451,7 @@ static void vfio_register_ram_discard_listener(VFIOContainer *container,
         }
 #endif
 
-        QLIST_FOREACH(vrdl, &container->vrdl_list, next) {
+        QLIST_FOREACH(vrdl, &bcontainer->vrdl_list, next) {
             hwaddr start, end;
 
             start = QEMU_ALIGN_DOWN(vrdl->offset_within_address_space,
@@ -473,13 +473,13 @@ static void vfio_register_ram_discard_listener(VFIOContainer *container,
     }
 }
 
-static void vfio_unregister_ram_discard_listener(VFIOContainer *container,
+static void vfio_unregister_ram_discard_listener(VFIOContainerBase *bcontainer,
                                                  MemoryRegionSection *section)
 {
     RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
     VFIORamDiscardListener *vrdl = NULL;
 
-    QLIST_FOREACH(vrdl, &container->vrdl_list, next) {
+    QLIST_FOREACH(vrdl, &bcontainer->vrdl_list, next) {
         if (vrdl->mr == section->mr &&
             vrdl->offset_within_address_space ==
             section->offset_within_address_space) {
@@ -663,7 +663,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
      * about changes.
      */
     if (memory_region_has_ram_discard_manager(section->mr)) {
-        vfio_register_ram_discard_listener(container, section);
+        vfio_register_ram_discard_listener(bcontainer, section);
         return;
     }
 
@@ -781,7 +781,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
         pgmask = (1ULL << ctz64(bcontainer->pgsizes)) - 1;
         try_unmap = !((iova & pgmask) || (int128_get64(llsize) & pgmask));
     } else if (memory_region_has_ram_discard_manager(section->mr)) {
-        vfio_unregister_ram_discard_listener(container, section);
+        vfio_unregister_ram_discard_listener(bcontainer, section);
         /* Unregistering will trigger an unmap. */
         try_unmap = false;
     }
@@ -1260,17 +1260,17 @@ static int vfio_ram_discard_get_dirty_bitmap(MemoryRegionSection *section,
      * Sync the whole mapped region (spanning multiple individual mappings)
      * in one go.
      */
-    return vfio_get_dirty_bitmap(&vrdl->container->bcontainer, iova, size,
-                                 ram_addr);
+    return vfio_get_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr);
 }
 
-static int vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainer *container,
-                                                   MemoryRegionSection *section)
+static int
+vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainerBase *bcontainer,
+                                            MemoryRegionSection *section)
 {
     RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
     VFIORamDiscardListener *vrdl = NULL;
 
-    QLIST_FOREACH(vrdl, &container->vrdl_list, next) {
+    QLIST_FOREACH(vrdl, &bcontainer->vrdl_list, next) {
         if (vrdl->mr == section->mr &&
             vrdl->offset_within_address_space ==
             section->offset_within_address_space) {
@@ -1324,7 +1324,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainer *container,
         }
         return 0;
     } else if (memory_region_has_ram_discard_manager(section->mr)) {
-        return vfio_sync_ram_discard_listener_dirty_bitmap(container, section);
+        return vfio_sync_ram_discard_listener_dirty_bitmap(bcontainer, section);
     }
 
     ram_addr = memory_region_get_ram_addr(section->mr) +
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index dcce111349f9ded6beb72efc7a4ddd86ab7df184..584eee4ba1170e103fb45003c514084ee3326353 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -54,6 +54,7 @@ void vfio_container_init(VFIOContainerBase *bcontainer, VFIOAddressSpace *space,
     bcontainer->dirty_pages_supported = false;
     bcontainer->dma_max_mappings = 0;
     QLIST_INIT(&bcontainer->giommu_list);
+    QLIST_INIT(&bcontainer->vrdl_list);
 }
 
 void vfio_container_destroy(VFIOContainerBase *bcontainer)
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index c5a62628826c6426e8cd67ff53e73c502d7f73ba..6ba2e2f8c41e72d24b32f3efa31c9683da18387c 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -560,7 +560,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container->fd = fd;
     container->error = NULL;
     container->iova_ranges = NULL;
-    QLIST_INIT(&container->vrdl_list);
     bcontainer = &container->bcontainer;
     vfio_container_init(bcontainer, space, &vfio_legacy_ops);
 
-- 
2.43.0


