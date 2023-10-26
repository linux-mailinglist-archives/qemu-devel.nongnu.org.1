Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 745937D811E
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 12:48:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvxu3-0000Yl-GU; Thu, 26 Oct 2023 06:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxtl-0008SF-VA
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:47:33 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxtk-0001Nq-2H
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698317252; x=1729853252;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pwBe+xn2AUzZ6ILX7f+ggHubuGoU7neJxXFsv65WvK4=;
 b=Bhef+jj1Wz/3YMGOY1e9x7JHcC53iqeFdi8bzU/Mmzy7NYmglbEq67pC
 9Lugrpbdaeo82n1fEB/WFqQ/2Q0M+s7j2X0fXUrFyzATgQn19eAKtSjmt
 oVz5rEjl/Ik1wdIsCK0zHhsHCRQdYzLIoHvbU7Mt9Go9Kj3e6j65d02He
 rD4ldImp2cxalytZ5avfkjOkWdvq0P4+IfY/g5HxBdMDBWFoNenODaIjW
 hB5aW4Pbx1kYIYUxLBX/y4z+x/3ZYRzrDLX8bjYgLidfFrEfSjxTO4LrS
 IuvF4TDwXc9aAxtjWhB8p86XEp/Wb7gw/KDsNnRqIGv0fgZ3VoeRL7XBB g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="372563472"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; d="scan'208";a="372563472"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:47:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="463702"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:47:04 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 17/37] vfio/container: Move iova_ranges to base container
Date: Thu, 26 Oct 2023 18:30:44 +0800
Message-Id: <20231026103104.1686921-18-zhenzhong.duan@intel.com>
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
index 423ab2436c..938f75e70c 100644
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
index 526d23acfd..2ffafb0d58 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -62,6 +62,7 @@ typedef struct VFIOContainerBase {
     QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
     QLIST_ENTRY(VFIOContainerBase) next;
     QLIST_HEAD(, VFIODevice) device_list;
+    GList *iova_ranges;
 } VFIOContainerBase;
 
 typedef struct VFIOGuestIOMMU {
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 52872f515a..d62c815d7f 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -638,9 +638,10 @@ static void vfio_listener_region_add(MemoryListener *listener,
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
index b57fdede91..6363ed3552 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -78,6 +78,7 @@ void vfio_container_init(VFIOContainerBase *bcontainer, VFIOAddressSpace *space,
     bcontainer->error = NULL;
     bcontainer->dirty_pages_supported = false;
     bcontainer->dma_max_mappings = 0;
+    bcontainer->iova_ranges = NULL;
     QLIST_INIT(&bcontainer->giommu_list);
     QLIST_INIT(&bcontainer->vrdl_list);
 }
@@ -104,4 +105,6 @@ void vfio_container_destroy(VFIOContainerBase *bcontainer)
         QLIST_REMOVE(giommu, giommu_next);
         g_free(giommu);
     }
+
+    g_list_free_full(bcontainer->iova_ranges, g_free);
 }
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 68dc6d240f..36c34683ad 100644
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
             container->bcontainer.dma_max_mappings = 65535;
         }
 
-        vfio_get_info_iova_range(info, container);
+        vfio_get_info_iova_range(info, bcontainer);
 
         vfio_get_iommu_info_migration(container, info);
         g_free(info);
@@ -650,7 +643,7 @@ enable_discards_exit:
     vfio_ram_block_discard_disable(container, false);
 
 free_container_exit:
-    vfio_free_container(container);
+    g_free(container);
 
 close_fd_exit:
     close(fd);
@@ -694,7 +687,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
 
         trace_vfio_disconnect_container(container->fd);
         close(container->fd);
-        vfio_free_container(container);
+        g_free(container);
 
         vfio_put_address_space(space);
     }
-- 
2.34.1


