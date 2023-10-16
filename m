Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5487CA27F
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:50:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJGW-0007iZ-Kd; Mon, 16 Oct 2023 04:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJGU-0007hu-Jg
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:47:54 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJGS-0001Al-E3
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697446072; x=1728982072;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yvpa3fvG/HrnClTGDpUIvnBZsd0pi9zd/hyMrUc3+q8=;
 b=FenwdPfN0wt/381/wO1eBZq0WDt8Fj9/rEV62VYSNaGZ4U67QVGkrelL
 Bb8VJKRIO9BR9XIwm1dYaVZpODIwskmJ59VOKjui+MFn3+9p4BvlJjtdV
 55Ta0cQvugBlA0rUGw6r3NLfxwVEyoPIgxrLE9wZcHe02I5fteJ/xg3Sb
 A7sD06xwdHI+9t3ubprEtlgOq+uBwr5Jw0XDiyRIQXcLh9/PZSulEL6P+
 mX2gp4o1/k5/Q/qLVy+s6w16wUxmBE3mNStR1EvIc7PpWTq2WZWaRilDi
 dz01S8J0jOpVumx/TfymUXyIuILzfHO4eDgxVDuTZKylBq8u9Whi9Uf3u g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365737577"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="365737577"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:47:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="749222828"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="749222828"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:47:46 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 08/27] vfio/container: Move hostwin_list in base container
Date: Mon, 16 Oct 2023 16:32:04 +0800
Message-Id: <20231016083223.1519410-9-zhenzhong.duan@intel.com>
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

Move hostwin_list in base container. This conducts to
passing a base container to vfio_host_win_add/del and
vfio_find_hostwin.

No fucntional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h         | 12 ++----------
 include/hw/vfio/vfio-container-base.h |  8 ++++++++
 hw/vfio/common.c                      | 18 +++++++++---------
 hw/vfio/container-base.c              |  8 ++++++++
 hw/vfio/container.c                   | 18 +++++-------------
 5 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index b83ae4b3b6..85dbda296a 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -88,7 +88,6 @@ typedef struct VFIOLegacyContainer {
     uint64_t max_dirty_bitmap_size;
     unsigned long pgsizes;
     unsigned int dma_max_mappings;
-    QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     QLIST_HEAD(, VFIOGroup) group_list;
     QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
     QLIST_HEAD(, VFIODevice) device_list;
@@ -104,13 +103,6 @@ typedef struct VFIORamDiscardListener {
     QLIST_ENTRY(VFIORamDiscardListener) next;
 } VFIORamDiscardListener;
 
-typedef struct VFIOHostDMAWindow {
-    hwaddr min_iova;
-    hwaddr max_iova;
-    uint64_t iova_pgsizes;
-    QLIST_ENTRY(VFIOHostDMAWindow) hostwin_next;
-} VFIOHostDMAWindow;
-
 typedef struct VFIODeviceOps VFIODeviceOps;
 
 typedef struct VFIODevice {
@@ -185,10 +177,10 @@ typedef struct VFIODisplay {
     } dmabuf;
 } VFIODisplay;
 
-void vfio_host_win_add(VFIOLegacyContainer *container,
+void vfio_host_win_add(VFIOContainer *bcontainer,
                        hwaddr min_iova, hwaddr max_iova,
                        uint64_t iova_pgsizes);
-int vfio_host_win_del(VFIOLegacyContainer *container, hwaddr min_iova,
+int vfio_host_win_del(VFIOContainer *bcontainer, hwaddr min_iova,
                       hwaddr max_iova);
 VFIOAddressSpace *vfio_get_address_space(AddressSpace *as);
 void vfio_put_address_space(VFIOAddressSpace *space);
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 1f6d5fd229..03bffbff73 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -47,6 +47,13 @@ typedef struct VFIOGuestIOMMU {
     QLIST_ENTRY(VFIOGuestIOMMU) giommu_next;
 } VFIOGuestIOMMU;
 
+typedef struct VFIOHostDMAWindow {
+    hwaddr min_iova;
+    hwaddr max_iova;
+    uint64_t iova_pgsizes;
+    QLIST_ENTRY(VFIOHostDMAWindow) hostwin_next;
+} VFIOHostDMAWindow;
+
 typedef struct {
     unsigned long *bitmap;
     hwaddr size;
@@ -60,6 +67,7 @@ struct VFIOContainer {
     VFIOIOMMUBackendOpsClass *ops;
     VFIOAddressSpace *space;
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
+    QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     QLIST_ENTRY(VFIOContainer) next;
 };
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 49cb5b6958..511f538c00 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -252,12 +252,12 @@ bool vfio_devices_all_running_and_mig_active(VFIOLegacyContainer *container)
     return true;
 }
 
-void vfio_host_win_add(VFIOLegacyContainer *container, hwaddr min_iova,
+void vfio_host_win_add(VFIOContainer *bcontainer, hwaddr min_iova,
                        hwaddr max_iova, uint64_t iova_pgsizes)
 {
     VFIOHostDMAWindow *hostwin;
 
-    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
+    QLIST_FOREACH(hostwin, &bcontainer->hostwin_list, hostwin_next) {
         if (ranges_overlap(hostwin->min_iova,
                            hostwin->max_iova - hostwin->min_iova + 1,
                            min_iova,
@@ -271,15 +271,15 @@ void vfio_host_win_add(VFIOLegacyContainer *container, hwaddr min_iova,
     hostwin->min_iova = min_iova;
     hostwin->max_iova = max_iova;
     hostwin->iova_pgsizes = iova_pgsizes;
-    QLIST_INSERT_HEAD(&container->hostwin_list, hostwin, hostwin_next);
+    QLIST_INSERT_HEAD(&bcontainer->hostwin_list, hostwin, hostwin_next);
 }
 
-int vfio_host_win_del(VFIOLegacyContainer *container,
+int vfio_host_win_del(VFIOContainer *bcontainer,
                       hwaddr min_iova, hwaddr max_iova)
 {
     VFIOHostDMAWindow *hostwin;
 
-    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
+    QLIST_FOREACH(hostwin, &bcontainer->hostwin_list, hostwin_next) {
         if (hostwin->min_iova == min_iova && hostwin->max_iova == max_iova) {
             QLIST_REMOVE(hostwin, hostwin_next);
             g_free(hostwin);
@@ -540,13 +540,13 @@ static void vfio_unregister_ram_discard_listener(VFIOLegacyContainer *container,
     g_free(vrdl);
 }
 
-static VFIOHostDMAWindow *vfio_find_hostwin(VFIOLegacyContainer *container,
+static VFIOHostDMAWindow *vfio_find_hostwin(VFIOContainer *bcontainer,
                                             hwaddr iova, hwaddr end)
 {
     VFIOHostDMAWindow *hostwin;
     bool hostwin_found = false;
 
-    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
+    QLIST_FOREACH(hostwin, &bcontainer->hostwin_list, hostwin_next) {
         if (hostwin->min_iova <= iova && end <= hostwin->max_iova) {
             hostwin_found = true;
             break;
@@ -659,7 +659,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
         goto fail;
     }
 
-    hostwin = vfio_find_hostwin(container, iova, end);
+    hostwin = vfio_find_hostwin(bcontainer, iova, end);
     if (!hostwin) {
         error_setg(&err, "Container %p can't map guest IOVA region"
                    " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx, container, iova, end);
@@ -842,7 +842,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
         hwaddr pgmask;
         VFIOHostDMAWindow *hostwin;
 
-        hostwin = vfio_find_hostwin(container, iova, end);
+        hostwin = vfio_find_hostwin(bcontainer, iova, end);
         assert(hostwin); /* or region_add() would have failed */
 
         pgmask = (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index f2a9a33465..12b256c70e 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -76,11 +76,13 @@ void vfio_container_init(VFIOContainer *bcontainer,
     bcontainer->ops = ops;
     bcontainer->space = space;
     QLIST_INIT(&bcontainer->giommu_list);
+    QLIST_INIT(&bcontainer->hostwin_list);
 }
 
 void vfio_container_destroy(VFIOContainer *bcontainer)
 {
     VFIOGuestIOMMU *giommu, *tmp;
+    VFIOHostDMAWindow *hostwin, *next;
 
     QLIST_REMOVE(bcontainer, next);
 
@@ -90,6 +92,12 @@ void vfio_container_destroy(VFIOContainer *bcontainer)
         QLIST_REMOVE(giommu, giommu_next);
         g_free(giommu);
     }
+
+    QLIST_FOREACH_SAFE(hostwin, &bcontainer->hostwin_list, hostwin_next,
+                       next) {
+        QLIST_REMOVE(hostwin, hostwin_next);
+        g_free(hostwin);
+    }
 }
 
 static const TypeInfo vfio_iommu_backend_ops_type_info = {
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 7ca61a7d36..5d111f69c9 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -231,7 +231,7 @@ static int vfio_legacy_add_section_window(VFIOContainer *bcontainer,
     }
 
     /* For now intersections are not allowed, we may relax this later */
-    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
+    QLIST_FOREACH(hostwin, &bcontainer->hostwin_list, hostwin_next) {
         if (ranges_overlap(hostwin->min_iova,
                            hostwin->max_iova - hostwin->min_iova + 1,
                            section->offset_within_address_space,
@@ -253,7 +253,7 @@ static int vfio_legacy_add_section_window(VFIOContainer *bcontainer,
         return ret;
     }
 
-    vfio_host_win_add(container, section->offset_within_address_space,
+    vfio_host_win_add(bcontainer, section->offset_within_address_space,
                       section->offset_within_address_space +
                       int128_get64(section->size) - 1, pgsize);
 #ifdef CONFIG_KVM
@@ -299,7 +299,7 @@ static void vfio_legacy_del_section_window(VFIOContainer *bcontainer,
 
     vfio_spapr_remove_window(container,
                              section->offset_within_address_space);
-    if (vfio_host_win_del(container,
+    if (vfio_host_win_del(bcontainer,
                           section->offset_within_address_space,
                           section->offset_within_address_space +
                           int128_get64(section->size) - 1) < 0) {
@@ -636,7 +636,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container->error = NULL;
     container->dirty_pages_supported = false;
     container->dma_max_mappings = 0;
-    QLIST_INIT(&container->hostwin_list);
     QLIST_INIT(&container->vrdl_list);
     bcontainer = &container->bcontainer;
     vfio_container_init(bcontainer, space, ops);
@@ -681,7 +680,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
          * information to get the actual window extent rather than assume
          * a 64-bit IOVA address space.
          */
-        vfio_host_win_add(container, 0, (hwaddr)-1, container->pgsizes);
+        vfio_host_win_add(bcontainer, 0, (hwaddr)-1, container->pgsizes);
 
         break;
     }
@@ -746,7 +745,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         } else {
             /* The default table uses 4K pages */
             container->pgsizes = 0x1000;
-            vfio_host_win_add(container, info.dma32_window_start,
+            vfio_host_win_add(bcontainer, info.dma32_window_start,
                               info.dma32_window_start +
                               info.dma32_window_size - 1,
                               0x1000);
@@ -822,16 +821,9 @@ static void vfio_disconnect_container(VFIOGroup *group)
 
     if (QLIST_EMPTY(&container->group_list)) {
         VFIOAddressSpace *space = container->bcontainer.space;
-        VFIOHostDMAWindow *hostwin, *next;
 
         vfio_container_destroy(bcontainer);
 
-        QLIST_FOREACH_SAFE(hostwin, &container->hostwin_list, hostwin_next,
-                           next) {
-            QLIST_REMOVE(hostwin, hostwin_next);
-            g_free(hostwin);
-        }
-
         trace_vfio_disconnect_container(container->fd);
         close(container->fd);
         g_free(container);
-- 
2.34.1


