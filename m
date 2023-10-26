Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8B97D8112
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 12:47:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvxsx-0007O3-1a; Thu, 26 Oct 2023 06:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxso-0007Ng-Dv; Thu, 26 Oct 2023 06:46:35 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxsm-0001Hy-Dh; Thu, 26 Oct 2023 06:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698317192; x=1729853192;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iIgRmxMm0dvXKkWlz6MJBc7IUSupn8oIFecS49huiLs=;
 b=K0qrTX9xeIt/pc3XX/4NU/N77VTXbeQ4aeDJsyKUEnE+7xbUG215RnsE
 9SJADqFsUobPffK7mOK0qru7zRP0vmmTHppIc/x8m4jwN14IAdEBKwYP2
 f15XCO5AQKhz25NhNt93x3/9IzPWauCTPljz1nikLDH+yq8xatQQX0XzZ
 9/uqPrSGL0iN5XQU4fyKBsbKCApibTPNCMdMJNdiOJRbrhPn+VY9dZhcd
 1avpOTxl/HiNJYsDe9MC6N8orHXawe3Y02L1xNFoiASHehGELSSfLLfpR
 IPQHvWFEpsdeHymA8989AujbUfT461211GNT7hAmpXn0R7JC57b76pk+m Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="372563235"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; d="scan'208";a="372563235"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:46:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="463591"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:46:16 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 qemu-ppc@nongnu.org (open list:sPAPR (pseries))
Subject: [PATCH v3 05/37] vfio/common: Move vfio_host_win_add/del into spapr.c
Date: Thu, 26 Oct 2023 18:30:32 +0800
Message-Id: <20231026103104.1686921-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Only spapr supports a customed host window list, other vfio driver
assume 64bit host window. So remove the check in listener callback
and move vfio_host_win_add/del into spapr.c and make static.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h |  5 ---
 hw/vfio/common.c              | 64 -----------------------------------
 hw/vfio/container.c           | 16 ---------
 hw/vfio/spapr.c               | 38 +++++++++++++++++++++
 4 files changed, 38 insertions(+), 85 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index f3174b3c5c..b9c7a7e588 100644
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
index e72055e752..0ebf4d9256 100644
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
@@ -647,13 +593,6 @@ static void vfio_listener_region_add(MemoryListener *listener,
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
@@ -835,9 +774,6 @@ static void vfio_listener_region_del(MemoryListener *listener,
         hwaddr pgmask;
         VFIOHostDMAWindow *hostwin;
 
-        hostwin = vfio_find_hostwin(container, iova, end);
-        assert(hostwin); /* or region_add() would have failed */
-
         pgmask = (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
         try_unmap = !((iova & pgmask) || (int128_get64(llsize) & pgmask));
     } else if (memory_region_has_ram_discard_manager(section->mr)) {
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 204b244b11..242010036a 100644
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
index 43adbdb7b3..3495737ab2 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -146,6 +146,44 @@ static const MemoryListener vfio_prereg_listener = {
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
 static int vfio_spapr_remove_window(VFIOContainer *container,
                                     hwaddr offset_within_address_space)
 {
-- 
2.34.1


