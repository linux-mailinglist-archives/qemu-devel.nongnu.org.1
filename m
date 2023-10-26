Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BB17D8130
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 12:51:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvxuu-0002dA-Vv; Thu, 26 Oct 2023 06:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxuL-0002EB-Nw; Thu, 26 Oct 2023 06:48:16 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxu9-0001PR-Hs; Thu, 26 Oct 2023 06:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698317277; x=1729853277;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Cgs1UlOu9KSvDtr3cTTJNPXjMQDSb8lNfbQ0g80dHeA=;
 b=SMg0b3+I3WpEqesLkb6Q9bYTdx8gVI0m+sqUe48xYaoz1z1JnXdSjnUa
 YSJeWXVvPnSvMW4bB091JiwEuHH5j9phjDnVVqjDYOcWp/OHpr4WtM9GL
 KMURxw9lSYkObV5Knb8EpZE1XkikVlnzooN7fELjNVGwNPNowru8Z1orR
 N4hdiPELfxXaMy/OYL7Fl7R+6FbQ4gwx5ClPLmxkVDYwFoKb0CL6vbZ8i
 cP7e3CfTlqB5Y7cyYYbTt9mhI4bEVXXEDAL4VSZOdqw9WssUjRd03vmLl
 5ijVLyNvOy9rzv3syPdPfI4xcNZUR7ilU7TtFZBdtf7QBLZraOdtF1WBE w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="372563560"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; d="scan'208";a="372563560"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:47:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="463727"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:47:15 -0700
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
Subject: [PATCH v3 20/37] vfio/spapr: switch to spapr IOMMU BE
 add/del_section_window
Date: Thu, 26 Oct 2023 18:30:47 +0800
Message-Id: <20231026103104.1686921-21-zhenzhong.duan@intel.com>
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

No fucntional change intended.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h         |  5 -----
 include/hw/vfio/vfio-container-base.h |  5 +++++
 hw/vfio/common.c                      |  8 ++------
 hw/vfio/container-base.c              | 23 ++++++++++++++++++++++-
 hw/vfio/spapr.c                       | 22 ++++++++++++++++------
 5 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index a74e60e677..1489b49d71 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -177,11 +177,6 @@ typedef struct VFIOIOMMUSpaprOps {
                        MemoryRegionSection *section);
 } VFIOIOMMUSpaprOps;
 
-int vfio_container_add_section_window(VFIOContainer *container,
-                                      MemoryRegionSection *section,
-                                      Error **errp);
-void vfio_container_del_section_window(VFIOContainer *container,
-                                       MemoryRegionSection *section);
 bool vfio_spapr_container_init(VFIOContainer *container, Error **errp);
 void vfio_spapr_container_deinit(VFIOContainer *container);
 
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 1e1854d24f..88463bcf24 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -91,6 +91,11 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
                              IOMMUTLBEntry *iotlb);
+int vfio_container_add_section_window(VFIOContainerBase *bcontainer,
+                                      MemoryRegionSection *section,
+                                      Error **errp);
+void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
+                                       MemoryRegionSection *section);
 int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
                                            bool start);
 int vfio_container_query_dirty_bitmap(VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 64565b4ae9..41a5609e33 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -571,8 +571,6 @@ static void vfio_listener_region_add(MemoryListener *listener,
 {
     VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
                                                  listener);
-    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                            bcontainer);
     hwaddr iova, end;
     Int128 llend, llsize;
     void *vaddr;
@@ -596,7 +594,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
         return;
     }
 
-    if (vfio_container_add_section_window(container, section, &err)) {
+    if (vfio_container_add_section_window(bcontainer, section, &err)) {
         goto fail;
     }
 
@@ -739,8 +737,6 @@ static void vfio_listener_region_del(MemoryListener *listener,
 {
     VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
                                                  listener);
-    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                            bcontainer);
     hwaddr iova, end;
     Int128 llend, llsize;
     int ret;
@@ -820,7 +816,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
 
     memory_region_unref(section->mr);
 
-    vfio_container_del_section_window(container, section);
+    vfio_container_del_section_window(bcontainer, section);
 }
 
 typedef struct VFIODirtyRanges {
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 6363ed3552..2efb26cfe4 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "hw/vfio/vfio-container-base.h"
+#include "hw/vfio/vfio-common.h"
 
 int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            hwaddr iova, ram_addr_t size,
@@ -48,6 +48,27 @@ int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
     return bcontainer->ops->dma_unmap(bcontainer, iova, size, iotlb);
 }
 
+int vfio_container_add_section_window(VFIOContainerBase *bcontainer,
+                                      MemoryRegionSection *section,
+                                      Error **errp)
+{
+    if (!bcontainer->spapr_ops || !bcontainer->spapr_ops->add_window) {
+        return 0;
+    }
+
+    return bcontainer->spapr_ops->add_window(bcontainer, section, errp);
+}
+
+void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
+                                       MemoryRegionSection *section)
+{
+    if (!bcontainer->spapr_ops || !bcontainer->spapr_ops->del_window) {
+        return;
+    }
+
+    return bcontainer->spapr_ops->del_window(bcontainer, section);
+}
+
 int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
                                            bool start)
 {
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 3739004151..43e32e544b 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -302,10 +302,13 @@ static int vfio_spapr_create_window(VFIOContainer *container,
     return 0;
 }
 
-int vfio_container_add_section_window(VFIOContainer *container,
-                                      MemoryRegionSection *section,
-                                      Error **errp)
+static int
+vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
+                                        MemoryRegionSection *section,
+                                        Error **errp)
 {
+    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
+                                            bcontainer);
     VFIOHostDMAWindow *hostwin;
     hwaddr pgsize = 0;
     int ret;
@@ -370,9 +373,13 @@ int vfio_container_add_section_window(VFIOContainer *container,
     return 0;
 }
 
-void vfio_container_del_section_window(VFIOContainer *container,
-                                       MemoryRegionSection *section)
+static void
+vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
+                                        MemoryRegionSection *section)
 {
+    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
+                                            bcontainer);
+
     if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
         return;
     }
@@ -388,7 +395,10 @@ void vfio_container_del_section_window(VFIOContainer *container,
     }
 }
 
-const VFIOIOMMUSpaprOps vfio_iommu_spapr_ops;
+const VFIOIOMMUSpaprOps vfio_iommu_spapr_ops = {
+    .add_window = vfio_spapr_container_add_section_window,
+    .del_window = vfio_spapr_container_del_section_window,
+};
 
 bool vfio_spapr_container_init(VFIOContainer *container, Error **errp)
 {
-- 
2.34.1


