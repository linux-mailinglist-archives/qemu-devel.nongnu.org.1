Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 833B17DED75
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:36:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyS9T-0005DN-Su; Thu, 02 Nov 2023 03:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS9R-00053L-5o
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:30:01 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS9P-0003PH-8Q
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698910199; x=1730446199;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mTN336HkMtcIJyI1oPV+52daJ6m8f9QoN514J7P+dWs=;
 b=LKGX8sHeTsTrSh6gcB/pzKvQ3SnJPC2ALBrkW1tskCkEs7SMMBVkD2T2
 1w4Rk634kPpWD6S6d4lGStE+dAg8wKLEBCUVST7wJ89KUivl7mMSulT8g
 oRwT2AXbzThhlaIGX+bztcNbsMy/Z0OFg6ZTW3e3sTLZjmhdTwP/XTtzP
 TNe2wz+CqIzSOL2HOuPB00mx/3cL9jUCKom5/NWyjXL8/+5K1Vz7IaOYT
 09BFAZYwlnxH/inixUjAf4s0U7+zsx6IkLDJlPjQaLeIlpIA+AqHnEt9a
 Gucj9FARY11FyvQsr2Ekc9mM3MilxvVq8Fy+qe3Yc7xUZD/nlcfbvLWzz g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452953218"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="452953218"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:29:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711055436"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="711055436"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:29:43 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 19/41] vfio/container: Move iova_ranges to base container
Date: Thu,  2 Nov 2023 15:12:40 +0800
Message-Id: <20231102071302.1818071-20-zhenzhong.duan@intel.com>
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

Meanwhile remove the helper function vfio_free_container as it
only calls g_free now.

No functional change intended.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h         |  1 -
 include/hw/vfio/vfio-container-base.h |  1 +
 hw/vfio/common.c                      |  5 +++--
 hw/vfio/container-base.c              |  3 +++
 hw/vfio/container.c                   | 19 ++++++-------------
 5 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index b1c9fe711b..b9e5a0e64b 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -82,7 +82,6 @@ typedef struct VFIOContainer {
     unsigned iommu_type;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     QLIST_HEAD(, VFIOGroup) group_list;
-    GList *iova_ranges;
 } VFIOContainer;
 
 typedef struct VFIOHostDMAWindow {
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 80e4a993c5..9658ffb526 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -48,6 +48,7 @@ typedef struct VFIOContainerBase {
     QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
     QLIST_ENTRY(VFIOContainerBase) next;
     QLIST_HEAD(, VFIODevice) device_list;
+    GList *iova_ranges;
 } VFIOContainerBase;
 
 typedef struct VFIOGuestIOMMU {
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index be623e544b..8ef2e7967d 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -637,9 +637,10 @@ static void vfio_listener_region_add(MemoryListener *listener,
             goto fail;
         }
 
-        if (container->iova_ranges) {
+        if (bcontainer->iova_ranges) {
             ret = memory_region_iommu_set_iova_ranges(giommu->iommu_mr,
-                    container->iova_ranges, &err);
+                                                      bcontainer->iova_ranges,
+                                                      &err);
             if (ret) {
                 g_free(giommu);
                 goto fail;
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 7f508669f5..0177f43741 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -54,6 +54,7 @@ void vfio_container_init(VFIOContainerBase *bcontainer, VFIOAddressSpace *space,
     bcontainer->error = NULL;
     bcontainer->dirty_pages_supported = false;
     bcontainer->dma_max_mappings = 0;
+    bcontainer->iova_ranges = NULL;
     QLIST_INIT(&bcontainer->giommu_list);
     QLIST_INIT(&bcontainer->vrdl_list);
 }
@@ -70,4 +71,6 @@ void vfio_container_destroy(VFIOContainerBase *bcontainer)
         QLIST_REMOVE(giommu, giommu_next);
         g_free(giommu);
     }
+
+    g_list_free_full(bcontainer->iova_ranges, g_free);
 }
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index c8088a8174..721c0d7375 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -308,7 +308,7 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
 }
 
 static bool vfio_get_info_iova_range(struct vfio_iommu_type1_info *info,
-                                     VFIOContainer *container)
+                                     VFIOContainerBase *bcontainer)
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_iommu_type1_info_cap_iova_range *cap;
@@ -326,8 +326,8 @@ static bool vfio_get_info_iova_range(struct vfio_iommu_type1_info *info,
 
         range_set_bounds(range, cap->iova_ranges[i].start,
                          cap->iova_ranges[i].end);
-        container->iova_ranges =
-            range_list_insert(container->iova_ranges, range);
+        bcontainer->iova_ranges =
+            range_list_insert(bcontainer->iova_ranges, range);
     }
 
     return true;
@@ -475,12 +475,6 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
     }
 }
 
-static void vfio_free_container(VFIOContainer *container)
-{
-    g_list_free_full(container->iova_ranges, g_free);
-    g_free(container);
-}
-
 static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
                                   Error **errp)
 {
@@ -560,7 +554,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
 
     container = g_malloc0(sizeof(*container));
     container->fd = fd;
-    container->iova_ranges = NULL;
     bcontainer = &container->bcontainer;
     vfio_container_init(bcontainer, space, &vfio_legacy_ops);
 
@@ -597,7 +590,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
             bcontainer->dma_max_mappings = 65535;
         }
 
-        vfio_get_info_iova_range(info, container);
+        vfio_get_info_iova_range(info, bcontainer);
 
         vfio_get_iommu_info_migration(container, info);
         g_free(info);
@@ -649,7 +642,7 @@ enable_discards_exit:
     vfio_ram_block_discard_disable(container, false);
 
 free_container_exit:
-    vfio_free_container(container);
+    g_free(container);
 
 close_fd_exit:
     close(fd);
@@ -693,7 +686,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
 
         trace_vfio_disconnect_container(container->fd);
         close(container->fd);
-        vfio_free_container(container);
+        g_free(container);
 
         vfio_put_address_space(space);
     }
-- 
2.34.1


