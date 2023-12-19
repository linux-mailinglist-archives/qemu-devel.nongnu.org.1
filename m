Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0357A81901D
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 19:59:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfHw-0002C2-AY; Tue, 19 Dec 2023 13:57:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfHu-00027j-V8
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:57:54 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfHs-00072E-Fh
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:57:54 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SvmCy3h0Xz4xPh;
 Wed, 20 Dec 2023 05:57:50 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvmCs6Frgz4xCp;
 Wed, 20 Dec 2023 05:57:45 +1100 (AEDT)
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
Subject: [PULL 10/47] vfio/container: Move pgsizes and dma_max_mappings to
 base container
Date: Tue, 19 Dec 2023 19:56:06 +0100
Message-ID: <20231219185643.725448-11-clg@redhat.com>
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

No functional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h         |  2 --
 include/hw/vfio/vfio-container-base.h |  2 ++
 hw/vfio/common.c                      | 17 +++++++++--------
 hw/vfio/container-base.c              |  1 +
 hw/vfio/container.c                   | 11 +++++------
 hw/vfio/spapr.c                       | 10 ++++++----
 6 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index bc67e1316ceeaf4439aa9dd71d8c35cc5f34366c..d3dc2f9dcbde9abf57fa1592604f60caa3cb0137 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -85,8 +85,6 @@ typedef struct VFIOContainer {
     bool initialized;
     uint64_t dirty_pgsizes;
     uint64_t max_dirty_bitmap_size;
-    unsigned long pgsizes;
-    unsigned int dma_max_mappings;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     QLIST_HEAD(, VFIOGroup) group_list;
     QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 709096249642c7c597aa789264a09389e53664f3..85ec7e1a561af641ae2261c775332afb8e76c838 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -36,6 +36,8 @@ typedef struct VFIOAddressSpace {
 typedef struct VFIOContainerBase {
     const VFIOIOMMUOps *ops;
     VFIOAddressSpace *space;
+    unsigned long pgsizes;
+    unsigned int dma_max_mappings;
     bool dirty_pages_supported;
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
     QLIST_ENTRY(VFIOContainerBase) next;
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index cf6618f6ed3d16a4c76d641d7bdb4958dd2bd8ef..1cb53d369e871090b4d58dc6d5dd4d6cdfe455c4 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -401,6 +401,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
 static void vfio_register_ram_discard_listener(VFIOContainer *container,
                                                MemoryRegionSection *section)
 {
+    VFIOContainerBase *bcontainer = &container->bcontainer;
     RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
     VFIORamDiscardListener *vrdl;
 
@@ -419,8 +420,8 @@ static void vfio_register_ram_discard_listener(VFIOContainer *container,
                                                                 section->mr);
 
     g_assert(vrdl->granularity && is_power_of_2(vrdl->granularity));
-    g_assert(container->pgsizes &&
-             vrdl->granularity >= 1ULL << ctz64(container->pgsizes));
+    g_assert(bcontainer->pgsizes &&
+             vrdl->granularity >= 1ULL << ctz64(bcontainer->pgsizes));
 
     ram_discard_listener_init(&vrdl->listener,
                               vfio_ram_discard_notify_populate,
@@ -441,7 +442,7 @@ static void vfio_register_ram_discard_listener(VFIOContainer *container,
      * number of sections in the address space we could have over time,
      * also consuming DMA mappings.
      */
-    if (container->dma_max_mappings) {
+    if (bcontainer->dma_max_mappings) {
         unsigned int vrdl_count = 0, vrdl_mappings = 0, max_memslots = 512;
 
 #ifdef CONFIG_KVM
@@ -462,11 +463,11 @@ static void vfio_register_ram_discard_listener(VFIOContainer *container,
         }
 
         if (vrdl_mappings + max_memslots - vrdl_count >
-            container->dma_max_mappings) {
+            bcontainer->dma_max_mappings) {
             warn_report("%s: possibly running out of DMA mappings. E.g., try"
                         " increasing the 'block-size' of virtio-mem devies."
                         " Maximum possible DMA mappings: %d, Maximum possible"
-                        " memslots: %d", __func__, container->dma_max_mappings,
+                        " memslots: %d", __func__, bcontainer->dma_max_mappings,
                         max_memslots);
         }
     }
@@ -626,7 +627,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
                             iommu_idx);
 
         ret = memory_region_iommu_set_page_size_mask(giommu->iommu_mr,
-                                                     container->pgsizes,
+                                                     bcontainer->pgsizes,
                                                      &err);
         if (ret) {
             g_free(giommu);
@@ -675,7 +676,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
     llsize = int128_sub(llend, int128_make64(iova));
 
     if (memory_region_is_ram_device(section->mr)) {
-        hwaddr pgmask = (1ULL << ctz64(container->pgsizes)) - 1;
+        hwaddr pgmask = (1ULL << ctz64(bcontainer->pgsizes)) - 1;
 
         if ((iova & pgmask) || (int128_get64(llsize) & pgmask)) {
             trace_vfio_listener_region_add_no_dma_map(
@@ -777,7 +778,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
     if (memory_region_is_ram_device(section->mr)) {
         hwaddr pgmask;
 
-        pgmask = (1ULL << ctz64(container->pgsizes)) - 1;
+        pgmask = (1ULL << ctz64(bcontainer->pgsizes)) - 1;
         try_unmap = !((iova & pgmask) || (int128_get64(llsize) & pgmask));
     } else if (memory_region_has_ram_discard_manager(section->mr)) {
         vfio_unregister_ram_discard_listener(container, section);
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 5d654ae17233fe06c235d33d981eb8fa92128536..dcce111349f9ded6beb72efc7a4ddd86ab7df184 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -52,6 +52,7 @@ void vfio_container_init(VFIOContainerBase *bcontainer, VFIOAddressSpace *space,
     bcontainer->ops = ops;
     bcontainer->space = space;
     bcontainer->dirty_pages_supported = false;
+    bcontainer->dma_max_mappings = 0;
     QLIST_INIT(&bcontainer->giommu_list);
 }
 
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 7bd81eab09008530294757a81429bfea1b147815..c5a62628826c6426e8cd67ff53e73c502d7f73ba 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -154,7 +154,7 @@ static int vfio_legacy_dma_unmap(VFIOContainerBase *bcontainer, hwaddr iova,
         if (errno == EINVAL && unmap.size && !(unmap.iova + unmap.size) &&
             container->iommu_type == VFIO_TYPE1v2_IOMMU) {
             trace_vfio_legacy_dma_unmap_overflow_workaround();
-            unmap.size -= 1ULL << ctz64(container->pgsizes);
+            unmap.size -= 1ULL << ctz64(bcontainer->pgsizes);
             continue;
         }
         error_report("VFIO_UNMAP_DMA failed: %s", strerror(errno));
@@ -559,7 +559,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container = g_malloc0(sizeof(*container));
     container->fd = fd;
     container->error = NULL;
-    container->dma_max_mappings = 0;
     container->iova_ranges = NULL;
     QLIST_INIT(&container->vrdl_list);
     bcontainer = &container->bcontainer;
@@ -589,13 +588,13 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         }
 
         if (info->flags & VFIO_IOMMU_INFO_PGSIZES) {
-            container->pgsizes = info->iova_pgsizes;
+            bcontainer->pgsizes = info->iova_pgsizes;
         } else {
-            container->pgsizes = qemu_real_host_page_size();
+            bcontainer->pgsizes = qemu_real_host_page_size();
         }
 
-        if (!vfio_get_info_dma_avail(info, &container->dma_max_mappings)) {
-            container->dma_max_mappings = 65535;
+        if (!vfio_get_info_dma_avail(info, &bcontainer->dma_max_mappings)) {
+            bcontainer->dma_max_mappings = 65535;
         }
 
         vfio_get_info_iova_range(info, container);
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 83da2f7ec213dab2acca9b96a1d07a22a49d22c4..4f76bdd3cadfd282b7f2a01c19ee772be5627068 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -226,6 +226,7 @@ static int vfio_spapr_create_window(VFIOContainer *container,
                                     hwaddr *pgsize)
 {
     int ret = 0;
+    VFIOContainerBase *bcontainer = &container->bcontainer;
     IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
     uint64_t pagesize = memory_region_iommu_get_min_page_size(iommu_mr), pgmask;
     unsigned entries, bits_total, bits_per_level, max_levels;
@@ -239,13 +240,13 @@ static int vfio_spapr_create_window(VFIOContainer *container,
     if (pagesize > rampagesize) {
         pagesize = rampagesize;
     }
-    pgmask = container->pgsizes & (pagesize | (pagesize - 1));
+    pgmask = bcontainer->pgsizes & (pagesize | (pagesize - 1));
     pagesize = pgmask ? (1ULL << (63 - clz64(pgmask))) : 0;
     if (!pagesize) {
         error_report("Host doesn't support page size 0x%"PRIx64
                      ", the supported mask is 0x%lx",
                      memory_region_iommu_get_min_page_size(iommu_mr),
-                     container->pgsizes);
+                     bcontainer->pgsizes);
         return -EINVAL;
     }
 
@@ -421,6 +422,7 @@ void vfio_container_del_section_window(VFIOContainer *container,
 
 int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
 {
+    VFIOContainerBase *bcontainer = &container->bcontainer;
     struct vfio_iommu_spapr_tce_info info;
     bool v2 = container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU;
     int ret, fd = container->fd;
@@ -461,7 +463,7 @@ int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
     }
 
     if (v2) {
-        container->pgsizes = info.ddw.pgsizes;
+        bcontainer->pgsizes = info.ddw.pgsizes;
         /*
          * There is a default window in just created container.
          * To make region_add/del simpler, we better remove this
@@ -476,7 +478,7 @@ int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
         }
     } else {
         /* The default table uses 4K pages */
-        container->pgsizes = 0x1000;
+        bcontainer->pgsizes = 0x1000;
         vfio_host_win_add(container, info.dma32_window_start,
                           info.dma32_window_start +
                           info.dma32_window_size - 1,
-- 
2.43.0


