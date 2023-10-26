Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E487D8133
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 12:51:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvxv0-000352-MA; Thu, 26 Oct 2023 06:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxuR-0002Gm-Pp; Thu, 26 Oct 2023 06:48:20 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxuO-0001PR-Ew; Thu, 26 Oct 2023 06:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698317292; x=1729853292;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Xq4kUGwNmzseTosgBBkQHV6Ilmdyoea1Ti8uTgY5BNs=;
 b=LvcFYouZi+n2Ut4z1iagcez449FqAMl42aOyvUrQ0BRF76ESM+txzU2f
 xWA9wNl0Auo5QdFg3Qq3iona2BE3L9UsGUvX9AAhXbPMsXIfVxLn7I2cJ
 A3XZL1V977WaitnzR7iKnW3LUXfKdMRp9uVluxH1NN3H/JTEWU9jYjvWO
 VMxCgQ75lnpLlKbHW2b8PZQkeU+W4LiL0Ms0Sskbp5m3uZ+hGO563ocH+
 35rBtDX3x4la/SEkdO86Oa+MZp+IjfwrIch7He2ZBoPfScMbCRzxj/gP5
 acY8PzZ1gLjZWFhj6cdZAoHzoCCYlEpAOE7JqvItodY9DHQSU1f9ZZsZc A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="372563633"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; d="scan'208";a="372563633"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:47:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="463749"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:47:24 -0700
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
Subject: [PATCH v3 22/37] vfio/spapr: Move hostwin_list into spapr container
Date: Thu, 26 Oct 2023 18:30:49 +0800
Message-Id: <20231026103104.1686921-23-zhenzhong.duan@intel.com>
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

No functional changes intended.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h |  1 -
 hw/vfio/spapr.c               | 30 +++++++++++++++++-------------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 913e9f5771..4f46af1ef4 100644
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
index 566a79906c..70b59e858c 100644
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
@@ -312,6 +313,8 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
 {
     VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                             bcontainer);
+    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
+                                                  container);
     VFIOHostDMAWindow *hostwin;
     hwaddr pgsize = 0;
     int ret;
@@ -321,7 +324,7 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
     }
 
     /* For now intersections are not allowed, we may relax this later */
-    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
+    QLIST_FOREACH(hostwin, &scontainer->hostwin_list, hostwin_next) {
         if (ranges_overlap(hostwin->min_iova,
                            hostwin->max_iova - hostwin->min_iova + 1,
                            section->offset_within_address_space,
@@ -343,7 +346,7 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
         return ret;
     }
 
-    vfio_host_win_add(container, section->offset_within_address_space,
+    vfio_host_win_add(scontainer, section->offset_within_address_space,
                       section->offset_within_address_space +
                       int128_get64(section->size) - 1, pgsize);
 #ifdef CONFIG_KVM
@@ -382,6 +385,8 @@ vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
 {
     VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                             bcontainer);
+    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
+                                                  container);
 
     if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
         return;
@@ -389,7 +394,7 @@ vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
 
     vfio_spapr_remove_window(container,
                              section->offset_within_address_space);
-    if (vfio_host_win_del(container,
+    if (vfio_host_win_del(scontainer,
                           section->offset_within_address_space,
                           section->offset_within_address_space +
                           int128_get64(section->size) - 1) < 0) {
@@ -462,7 +467,7 @@ bool vfio_spapr_container_init(VFIOContainer *container, Error **errp)
     } else {
         /* The default table uses 4K pages */
         bcontainer->pgsizes = 0x1000;
-        vfio_host_win_add(container, info.dma32_window_start,
+        vfio_host_win_add(scontainer, info.dma32_window_start,
                           info.dma32_window_start +
                           info.dma32_window_size - 1,
                           0x1000);
@@ -479,15 +484,14 @@ listener_unregister_exit:
 
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


