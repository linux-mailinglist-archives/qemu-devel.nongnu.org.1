Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 698017E2759
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:44:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00kc-0007kH-0E; Mon, 06 Nov 2023 09:38:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org>)
 id 1r00kM-0007Oj-9u
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:38:34 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org>)
 id 1r00kB-00014a-8Y
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:38:27 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SPDV75b6Dz4xkR;
 Tue,  7 Nov 2023 01:38:07 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SPDV60vJ7z4xkX;
 Tue,  7 Nov 2023 01:38:05 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 22/22] vfio/common: Move vfio_host_win_add/del into spapr.c
Date: Mon,  6 Nov 2023 15:36:53 +0100
Message-ID: <20231106143653.302391-23-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106143653.302391-1-clg@redhat.com>
References: <20231106143653.302391-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

Only spapr supports a customed host window list, other vfio driver
assume 64bit host window. So remove the check in listener callback
and move vfio_host_win_add/del into spapr.c and make it static.

With the check removed, we still need to do the same check for
VFIO_SPAPR_TCE_IOMMU which allows a single host window range
[dma32_window_start, dma32_window_size). Move vfio_find_hostwin
into spapr.c and do same check in vfio_container_add_section_window
instead.

When mapping a ram device section, if it's unaligned with
hostwin->iova_pgsizes, this mapping is bypassed. With hostwin
moved into spapr, we changed to check container->pgsizes.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |  5 ---
 hw/vfio/common.c              | 70 +----------------------------
 hw/vfio/container.c           | 16 -------
 hw/vfio/spapr.c               | 83 +++++++++++++++++++++++++++++++++++
 4 files changed, 85 insertions(+), 89 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 87848982bd7c2920a76db2274d039728c6485ae5..a4a22accb9434c5d04bef73172a0ccbe182405cb 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -207,11 +207,6 @@ typedef struct {
     hwaddr pages;
 } VFIOBitmap;
 
-void vfio_host_win_add(VFIOContainer *container,
-                       hwaddr min_iova, hwaddr max_iova,
-                       uint64_t iova_pgsizes);
-int vfio_host_win_del(VFIOContainer *container, hwaddr min_iova,
-                      hwaddr max_iova);
 VFIOAddressSpace *vfio_get_address_space(AddressSpace *as);
 void vfio_put_address_space(VFIOAddressSpace *space);
 bool vfio_devices_all_running_and_saving(VFIOContainer *container);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index e72055e752d9cccda8fb6379c0dd3f733cfc3294..e70fdf5e0cacf756fb8dcce2bfd906c65ae71684 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -245,44 +245,6 @@ bool vfio_devices_all_running_and_mig_active(VFIOContainer *container)
     return true;
 }
 
-void vfio_host_win_add(VFIOContainer *container, hwaddr min_iova,
-                       hwaddr max_iova, uint64_t iova_pgsizes)
-{
-    VFIOHostDMAWindow *hostwin;
-
-    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
-        if (ranges_overlap(hostwin->min_iova,
-                           hostwin->max_iova - hostwin->min_iova + 1,
-                           min_iova,
-                           max_iova - min_iova + 1)) {
-            hw_error("%s: Overlapped IOMMU are not enabled", __func__);
-        }
-    }
-
-    hostwin = g_malloc0(sizeof(*hostwin));
-
-    hostwin->min_iova = min_iova;
-    hostwin->max_iova = max_iova;
-    hostwin->iova_pgsizes = iova_pgsizes;
-    QLIST_INSERT_HEAD(&container->hostwin_list, hostwin, hostwin_next);
-}
-
-int vfio_host_win_del(VFIOContainer *container,
-                      hwaddr min_iova, hwaddr max_iova)
-{
-    VFIOHostDMAWindow *hostwin;
-
-    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
-        if (hostwin->min_iova == min_iova && hostwin->max_iova == max_iova) {
-            QLIST_REMOVE(hostwin, hostwin_next);
-            g_free(hostwin);
-            return 0;
-        }
-    }
-
-    return -1;
-}
-
 static bool vfio_listener_skipped_section(MemoryRegionSection *section)
 {
     return (!memory_region_is_ram(section->mr) &&
@@ -531,22 +493,6 @@ static void vfio_unregister_ram_discard_listener(VFIOContainer *container,
     g_free(vrdl);
 }
 
-static VFIOHostDMAWindow *vfio_find_hostwin(VFIOContainer *container,
-                                            hwaddr iova, hwaddr end)
-{
-    VFIOHostDMAWindow *hostwin;
-    bool hostwin_found = false;
-
-    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
-        if (hostwin->min_iova <= iova && end <= hostwin->max_iova) {
-            hostwin_found = true;
-            break;
-        }
-    }
-
-    return hostwin_found ? hostwin : NULL;
-}
-
 static bool vfio_known_safe_misalignment(MemoryRegionSection *section)
 {
     MemoryRegion *mr = section->mr;
@@ -625,7 +571,6 @@ static void vfio_listener_region_add(MemoryListener *listener,
     Int128 llend, llsize;
     void *vaddr;
     int ret;
-    VFIOHostDMAWindow *hostwin;
     Error *err = NULL;
 
     if (!vfio_listener_valid_section(section, "region_add")) {
@@ -647,13 +592,6 @@ static void vfio_listener_region_add(MemoryListener *listener,
         goto fail;
     }
 
-    hostwin = vfio_find_hostwin(container, iova, end);
-    if (!hostwin) {
-        error_setg(&err, "Container %p can't map guest IOVA region"
-                   " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx, container, iova, end);
-        goto fail;
-    }
-
     memory_region_ref(section->mr);
 
     if (memory_region_is_iommu(section->mr)) {
@@ -734,7 +672,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
     llsize = int128_sub(llend, int128_make64(iova));
 
     if (memory_region_is_ram_device(section->mr)) {
-        hwaddr pgmask = (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
+        hwaddr pgmask = (1ULL << ctz64(container->pgsizes)) - 1;
 
         if ((iova & pgmask) || (int128_get64(llsize) & pgmask)) {
             trace_vfio_listener_region_add_no_dma_map(
@@ -833,12 +771,8 @@ static void vfio_listener_region_del(MemoryListener *listener,
 
     if (memory_region_is_ram_device(section->mr)) {
         hwaddr pgmask;
-        VFIOHostDMAWindow *hostwin;
-
-        hostwin = vfio_find_hostwin(container, iova, end);
-        assert(hostwin); /* or region_add() would have failed */
 
-        pgmask = (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
+        pgmask = (1ULL << ctz64(container->pgsizes)) - 1;
         try_unmap = !((iova & pgmask) || (int128_get64(llsize) & pgmask));
     } else if (memory_region_has_ram_discard_manager(section->mr)) {
         vfio_unregister_ram_discard_listener(container, section);
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 204b244b114c465e4a62d46bef78f472e268620d..242010036af33faa325a34008af40c2cc67a02ea 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -551,7 +551,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container->dma_max_mappings = 0;
     container->iova_ranges = NULL;
     QLIST_INIT(&container->giommu_list);
-    QLIST_INIT(&container->hostwin_list);
     QLIST_INIT(&container->vrdl_list);
 
     ret = vfio_init_container(container, group->fd, errp);
@@ -591,14 +590,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
 
         vfio_get_iommu_info_migration(container, info);
         g_free(info);
-
-        /*
-         * FIXME: We should parse VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE
-         * information to get the actual window extent rather than assume
-         * a 64-bit IOVA address space.
-         */
-        vfio_host_win_add(container, 0, (hwaddr)-1, container->pgsizes);
-
         break;
     }
     case VFIO_SPAPR_TCE_v2_IOMMU:
@@ -687,7 +678,6 @@ static void vfio_disconnect_container(VFIOGroup *group)
     if (QLIST_EMPTY(&container->group_list)) {
         VFIOAddressSpace *space = container->space;
         VFIOGuestIOMMU *giommu, *tmp;
-        VFIOHostDMAWindow *hostwin, *next;
 
         QLIST_REMOVE(container, next);
 
@@ -698,12 +688,6 @@ static void vfio_disconnect_container(VFIOGroup *group)
             g_free(giommu);
         }
 
-        QLIST_FOREACH_SAFE(hostwin, &container->hostwin_list, hostwin_next,
-                           next) {
-            QLIST_REMOVE(hostwin, hostwin_next);
-            g_free(hostwin);
-        }
-
         trace_vfio_disconnect_container(container->fd);
         close(container->fd);
         vfio_free_container(container);
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 4428990c28c9609cfa6211bfcfe063e104d5aee8..83da2f7ec213dab2acca9b96a1d07a22a49d22c4 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -146,6 +146,60 @@ static const MemoryListener vfio_prereg_listener = {
     .region_del = vfio_prereg_listener_region_del,
 };
 
+static void vfio_host_win_add(VFIOContainer *container, hwaddr min_iova,
+                              hwaddr max_iova, uint64_t iova_pgsizes)
+{
+    VFIOHostDMAWindow *hostwin;
+
+    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
+        if (ranges_overlap(hostwin->min_iova,
+                           hostwin->max_iova - hostwin->min_iova + 1,
+                           min_iova,
+                           max_iova - min_iova + 1)) {
+            hw_error("%s: Overlapped IOMMU are not enabled", __func__);
+        }
+    }
+
+    hostwin = g_malloc0(sizeof(*hostwin));
+
+    hostwin->min_iova = min_iova;
+    hostwin->max_iova = max_iova;
+    hostwin->iova_pgsizes = iova_pgsizes;
+    QLIST_INSERT_HEAD(&container->hostwin_list, hostwin, hostwin_next);
+}
+
+static int vfio_host_win_del(VFIOContainer *container,
+                             hwaddr min_iova, hwaddr max_iova)
+{
+    VFIOHostDMAWindow *hostwin;
+
+    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
+        if (hostwin->min_iova == min_iova && hostwin->max_iova == max_iova) {
+            QLIST_REMOVE(hostwin, hostwin_next);
+            g_free(hostwin);
+            return 0;
+        }
+    }
+
+    return -1;
+}
+
+static VFIOHostDMAWindow *vfio_find_hostwin(VFIOContainer *container,
+                                            hwaddr iova, hwaddr end)
+{
+    VFIOHostDMAWindow *hostwin;
+    bool hostwin_found = false;
+
+    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
+        if (hostwin->min_iova <= iova && end <= hostwin->max_iova) {
+            hostwin_found = true;
+            break;
+        }
+    }
+
+    return hostwin_found ? hostwin : NULL;
+}
+
 static int vfio_spapr_remove_window(VFIOContainer *container,
                                     hwaddr offset_within_address_space)
 {
@@ -267,6 +321,26 @@ int vfio_container_add_section_window(VFIOContainer *container,
     hwaddr pgsize = 0;
     int ret;
 
+    /*
+     * VFIO_SPAPR_TCE_IOMMU supports a single host window between
+     * [dma32_window_start, dma32_window_size), we need to ensure
+     * the section fall in this range.
+     */
+    if (container->iommu_type == VFIO_SPAPR_TCE_IOMMU) {
+        hwaddr iova, end;
+
+        iova = section->offset_within_address_space;
+        end = iova + int128_get64(section->size) - 1;
+
+        if (!vfio_find_hostwin(container, iova, end)) {
+            error_setg(errp, "Container %p can't map guest IOVA region"
+                       " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx, container,
+                       iova, end);
+            return -EINVAL;
+        }
+        return 0;
+    }
+
     if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
         return 0;
     }
@@ -351,6 +425,8 @@ int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
     bool v2 = container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU;
     int ret, fd = container->fd;
 
+    QLIST_INIT(&container->hostwin_list);
+
     /*
      * The host kernel code implementing VFIO_IOMMU_DISABLE is called
      * when container fd is closed so we do not call it explicitly
@@ -418,7 +494,14 @@ listener_unregister_exit:
 
 void vfio_spapr_container_deinit(VFIOContainer *container)
 {
+    VFIOHostDMAWindow *hostwin, *next;
+
     if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
         memory_listener_unregister(&container->prereg_listener);
     }
+    QLIST_FOREACH_SAFE(hostwin, &container->hostwin_list, hostwin_next,
+                       next) {
+        QLIST_REMOVE(hostwin, hostwin_next);
+        g_free(hostwin);
+    }
 }
-- 
2.41.0


