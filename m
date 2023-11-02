Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C28DF7DED6C
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:33:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyS9w-000727-A3; Thu, 02 Nov 2023 03:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS9s-0006mI-IT; Thu, 02 Nov 2023 03:30:28 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS9q-0003OZ-LS; Thu, 02 Nov 2023 03:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698910226; x=1730446226;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1jY3uHhxMwZwdNDtdWIik+YcNcyh+TkP1T3KvqzilT8=;
 b=aHwOXMOqWisCwbDhlmEU6BJ6+SVqEwXbQJBhXwHrrbwMloEJcHOyqD09
 xzBUCIofyM8vBDa/bER36jDnviXWiV3fcAxM0WMBGD9ImQzNoV6cRuEAx
 JxITeUN8/C3PUxqkh3zv2sJa8+0QeShSwgXCt87AW6O6ESYAUJElsScCF
 v/DfnIs23IoLoe5/C6HCZg3Wu+gR46pfqnNUkBicPziPiNzxX4iKTF52q
 9ylWHL8G0RJPYAbORfAX/rYQpP3R9PCfRJaLtJes6PN2DUa7J/e06beny
 M6ckAuqgeE9M8fNRevSQ6ohsgLfj+f3OR5HH7SOn71VCHnG2UuRMke4g0 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452953245"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="452953245"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:30:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711055473"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="711055473"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:29:56 -0700
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
Subject: [PATCH v4 22/41] vfio/spapr: switch to spapr IOMMU BE
 add/del_section_window
Date: Thu,  2 Nov 2023 15:12:43 +0800
Message-Id: <20231102071302.1818071-23-zhenzhong.duan@intel.com>
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

No fucntional change intended.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h         |  5 -----
 include/hw/vfio/vfio-container-base.h |  5 +++++
 hw/vfio/common.c                      |  8 ++------
 hw/vfio/container-base.c              | 21 +++++++++++++++++++++
 hw/vfio/spapr.c                       | 19 ++++++++++++++-----
 5 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index b9e5a0e64b..055f679363 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -169,11 +169,6 @@ VFIOAddressSpace *vfio_get_address_space(AddressSpace *as);
 void vfio_put_address_space(VFIOAddressSpace *space);
 
 /* SPAPR specific */
-int vfio_container_add_section_window(VFIOContainer *container,
-                                      MemoryRegionSection *section,
-                                      Error **errp);
-void vfio_container_del_section_window(VFIOContainer *container,
-                                       MemoryRegionSection *section);
 int vfio_spapr_container_init(VFIOContainer *container, Error **errp);
 void vfio_spapr_container_deinit(VFIOContainer *container);
 
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index f62a14ac73..4b6f017c6f 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -75,6 +75,11 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
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
index 483ba82089..572ae7c934 100644
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
@@ -595,7 +593,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
         return;
     }
 
-    if (vfio_container_add_section_window(container, section, &err)) {
+    if (vfio_container_add_section_window(bcontainer, section, &err)) {
         goto fail;
     }
 
@@ -738,8 +736,6 @@ static void vfio_listener_region_del(MemoryListener *listener,
 {
     VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
                                                  listener);
-    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                            bcontainer);
     hwaddr iova, end;
     Int128 llend, llsize;
     int ret;
@@ -818,7 +814,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
 
     memory_region_unref(section->mr);
 
-    vfio_container_del_section_window(container, section);
+    vfio_container_del_section_window(bcontainer, section);
 }
 
 typedef struct VFIODirtyRanges {
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 0177f43741..71f7274973 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -31,6 +31,27 @@ int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
     return bcontainer->ops->dma_unmap(bcontainer, iova, size, iotlb);
 }
 
+int vfio_container_add_section_window(VFIOContainerBase *bcontainer,
+                                      MemoryRegionSection *section,
+                                      Error **errp)
+{
+    if (!bcontainer->ops->add_window) {
+        return 0;
+    }
+
+    return bcontainer->ops->add_window(bcontainer, section, errp);
+}
+
+void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
+                                       MemoryRegionSection *section)
+{
+    if (!bcontainer->ops->del_window) {
+        return;
+    }
+
+    return bcontainer->ops->del_window(bcontainer, section);
+}
+
 int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
                                            bool start)
 {
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index e1a6b35563..5be1911aad 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -319,10 +319,13 @@ static int vfio_spapr_create_window(VFIOContainer *container,
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
@@ -407,9 +410,13 @@ int vfio_container_add_section_window(VFIOContainer *container,
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
@@ -430,6 +437,8 @@ static VFIOIOMMUOps vfio_iommu_spapr_ops;
 static void setup_spapr_ops(VFIOContainerBase *bcontainer)
 {
     vfio_iommu_spapr_ops = *bcontainer->ops;
+    vfio_iommu_spapr_ops.add_window = vfio_spapr_container_add_section_window;
+    vfio_iommu_spapr_ops.del_window = vfio_spapr_container_del_section_window;
     bcontainer->ops = &vfio_iommu_spapr_ops;
 }
 
-- 
2.34.1


