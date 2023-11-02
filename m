Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9587DED85
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:37:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyS9t-0006mK-EG; Thu, 02 Nov 2023 03:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS9r-0006XJ-1t; Thu, 02 Nov 2023 03:30:27 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS9o-0003PH-HY; Thu, 02 Nov 2023 03:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698910224; x=1730446224;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/KZAB1sGU6lU1/7WA1ztyPgXR60ROtf6O0wC7GYMFpQ=;
 b=BRIz+9NBsQNptwPwPd04xL4kBRabSWURC4/IYKUxNagg67XRMbD2a+0C
 AJ90dAMxFgE/aegFcJqHUmk1P6Jh54jmprEJ2MCeJT6Bu2vxzbeTCMkIB
 u7rrGJBzJB/dbl/hlzNlcmikpFTbKCZGSzIM9pGDvcBAQ4NI7VxjzAwPY
 c8MwYYi8rPBlKP+hoxNKWIw6uKf6Any36QlT+hbdvbtxeQ1z6bM6Nh3Kl
 JHYy7dt1iB5Bl1yLcKFnMRp0wPJ4Ap8+E2zjTtdxgUjWFQRrzpt7cg5k8
 nXIVUcq2zCTX2M8Ga8bPLDO8FwWPOrpcEj57X7TQFP6Bz/lzuFjJRh1r7 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452953276"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="452953276"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:30:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711055544"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="711055544"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:30:06 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 qemu-ppc@nongnu.org (open list:sPAPR (pseries))
Subject: [PATCH v4 24/41] vfio/spapr: Move hostwin_list into spapr container
Date: Thu,  2 Nov 2023 15:12:45 +0800
Message-Id: <20231102071302.1818071-25-zhenzhong.duan@intel.com>
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

No functional changes intended.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h |  1 -
 hw/vfio/spapr.c               | 36 +++++++++++++++++++----------------
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index ed6148c058..24ecc0e7ee 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -79,7 +79,6 @@ typedef struct VFIOContainer {
     VFIOContainerBase bcontainer;
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
     unsigned iommu_type;
-    QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     QLIST_HEAD(, VFIOGroup) group_list;
 } VFIOContainer;
 
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 68c3dd6c75..5c6426e697 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -27,6 +27,7 @@
 typedef struct VFIOSpaprContainer {
     VFIOContainer container;
     MemoryListener prereg_listener;
+    QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
 } VFIOSpaprContainer;
 
 static bool vfio_prereg_listener_skipped_section(MemoryRegionSection *section)
@@ -154,12 +155,12 @@ static const MemoryListener vfio_prereg_listener = {
     .region_del = vfio_prereg_listener_region_del,
 };
 
-static void vfio_host_win_add(VFIOContainer *container, hwaddr min_iova,
+static void vfio_host_win_add(VFIOSpaprContainer *scontainer, hwaddr min_iova,
                               hwaddr max_iova, uint64_t iova_pgsizes)
 {
     VFIOHostDMAWindow *hostwin;
 
-    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
+    QLIST_FOREACH(hostwin, &scontainer->hostwin_list, hostwin_next) {
         if (ranges_overlap(hostwin->min_iova,
                            hostwin->max_iova - hostwin->min_iova + 1,
                            min_iova,
@@ -173,15 +174,15 @@ static void vfio_host_win_add(VFIOContainer *container, hwaddr min_iova,
     hostwin->min_iova = min_iova;
     hostwin->max_iova = max_iova;
     hostwin->iova_pgsizes = iova_pgsizes;
-    QLIST_INSERT_HEAD(&container->hostwin_list, hostwin, hostwin_next);
+    QLIST_INSERT_HEAD(&scontainer->hostwin_list, hostwin, hostwin_next);
 }
 
-static int vfio_host_win_del(VFIOContainer *container,
+static int vfio_host_win_del(VFIOSpaprContainer *scontainer,
                              hwaddr min_iova, hwaddr max_iova)
 {
     VFIOHostDMAWindow *hostwin;
 
-    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
+    QLIST_FOREACH(hostwin, &scontainer->hostwin_list, hostwin_next) {
         if (hostwin->min_iova == min_iova && hostwin->max_iova == max_iova) {
             QLIST_REMOVE(hostwin, hostwin_next);
             g_free(hostwin);
@@ -192,7 +193,7 @@ static int vfio_host_win_del(VFIOContainer *container,
     return -1;
 }
 
-static VFIOHostDMAWindow *vfio_find_hostwin(VFIOContainer *container,
+static VFIOHostDMAWindow *vfio_find_hostwin(VFIOSpaprContainer *container,
                                             hwaddr iova, hwaddr end)
 {
     VFIOHostDMAWindow *hostwin;
@@ -329,6 +330,8 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
 {
     VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                             bcontainer);
+    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
+                                                  container);
     VFIOHostDMAWindow *hostwin;
     hwaddr pgsize = 0;
     int ret;
@@ -344,7 +347,7 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
         iova = section->offset_within_address_space;
         end = iova + int128_get64(section->size) - 1;
 
-        if (!vfio_find_hostwin(container, iova, end)) {
+        if (!vfio_find_hostwin(scontainer, iova, end)) {
             error_setg(errp, "Container %p can't map guest IOVA region"
                        " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx, container,
                        iova, end);
@@ -358,7 +361,7 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
     }
 
     /* For now intersections are not allowed, we may relax this later */
-    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
+    QLIST_FOREACH(hostwin, &scontainer->hostwin_list, hostwin_next) {
         if (ranges_overlap(hostwin->min_iova,
                            hostwin->max_iova - hostwin->min_iova + 1,
                            section->offset_within_address_space,
@@ -380,7 +383,7 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
         return ret;
     }
 
-    vfio_host_win_add(container, section->offset_within_address_space,
+    vfio_host_win_add(scontainer, section->offset_within_address_space,
                       section->offset_within_address_space +
                       int128_get64(section->size) - 1, pgsize);
 #ifdef CONFIG_KVM
@@ -419,6 +422,8 @@ vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
 {
     VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                             bcontainer);
+    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
+                                                  container);
 
     if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
         return;
@@ -426,7 +431,7 @@ vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
 
     vfio_spapr_remove_window(container,
                              section->offset_within_address_space);
-    if (vfio_host_win_del(container,
+    if (vfio_host_win_del(scontainer,
                           section->offset_within_address_space,
                           section->offset_within_address_space +
                           int128_get64(section->size) - 1) < 0) {
@@ -454,7 +459,7 @@ int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
     bool v2 = container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU;
     int ret, fd = container->fd;
 
-    QLIST_INIT(&container->hostwin_list);
+    QLIST_INIT(&scontainer->hostwin_list);
 
     /*
      * The host kernel code implementing VFIO_IOMMU_DISABLE is called
@@ -506,7 +511,7 @@ int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
     } else {
         /* The default table uses 4K pages */
         bcontainer->pgsizes = 0x1000;
-        vfio_host_win_add(container, info.dma32_window_start,
+        vfio_host_win_add(scontainer, info.dma32_window_start,
                           info.dma32_window_start +
                           info.dma32_window_size - 1,
                           0x1000);
@@ -525,15 +530,14 @@ listener_unregister_exit:
 
 void vfio_spapr_container_deinit(VFIOContainer *container)
 {
+    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
+                                                  container);
     VFIOHostDMAWindow *hostwin, *next;
 
     if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
-        VFIOSpaprContainer *scontainer = container_of(container,
-                                                      VFIOSpaprContainer,
-                                                      container);
         memory_listener_unregister(&scontainer->prereg_listener);
     }
-    QLIST_FOREACH_SAFE(hostwin, &container->hostwin_list, hostwin_next,
+    QLIST_FOREACH_SAFE(hostwin, &scontainer->hostwin_list, hostwin_next,
                        next) {
         QLIST_REMOVE(hostwin, hostwin_next);
         g_free(hostwin);
-- 
2.34.1


