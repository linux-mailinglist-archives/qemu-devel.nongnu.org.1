Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D2E7CA262
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:49:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJGU-0007hX-DU; Mon, 16 Oct 2023 04:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJGQ-0007dv-SD
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:47:52 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJGP-0001Al-0J
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697446069; x=1728982069;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uws+EGYfXV5EQWphM/+91nJNeLUFq7VcNsOP4PXGk/k=;
 b=a/AtunlTUPHRc5UmuV1TbVqACJpywwsqo3EpaOQS/jaViV+GJKAdbJhi
 AHkQ7Czq5FJxdx5f+jNWzumTmTJn6tkgUqHI3Ugo9BbLbBcmvXK8Km+UA
 HnlEMvKxznmEDssYVIeabhf3+0jFrwgz8ymMdHqyTRAxo/696+c5WXb5K
 K2lTwVL1GmqhBKZ8WF98TkNrdXaqirErMU2OpO+cYcc3x9XC2vtyi6XmA
 AM9hfgHW02yidD1I71aN7mUkYZjICRqptNvLfJCSN1NsPPIO5D6zfnmK6
 PX1iAPdBMHIrr5zgHyeWdeM9SBeLloV1nfEmXN92WOpqFoFantNfYZtxJ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365737563"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="365737563"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:47:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="749222770"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="749222770"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:47:42 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 07/27] vfio/container: switch to IOMMU BE
 add/del_section_window
Date: Mon, 16 Oct 2023 16:32:03 +0800
Message-Id: <20231016083223.1519410-8-zhenzhong.duan@intel.com>
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

No fucntional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h         |  6 ------
 include/hw/vfio/vfio-container-base.h |  5 +++++
 hw/vfio/common.c                      |  4 ++--
 hw/vfio/container-base.c              | 21 +++++++++++++++++++++
 hw/vfio/container.c                   | 19 ++++++++++++++-----
 5 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 33f475957c..b83ae4b3b6 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -199,12 +199,6 @@ int vfio_set_dirty_page_tracking(VFIOLegacyContainer *container, bool start);
 int vfio_query_dirty_bitmap(VFIOLegacyContainer *container, VFIOBitmap *vbmap,
                             hwaddr iova, hwaddr size);
 
-int vfio_container_add_section_window(VFIOLegacyContainer *container,
-                                      MemoryRegionSection *section,
-                                      Error **errp);
-void vfio_container_del_section_window(VFIOLegacyContainer *container,
-                                       MemoryRegionSection *section);
-
 void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
 void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
 void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 9504564f4e..1f6d5fd229 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -69,6 +69,11 @@ int vfio_container_dma_map(VFIOContainer *bcontainer,
 int vfio_container_dma_unmap(VFIOContainer *bcontainer,
                              hwaddr iova, ram_addr_t size,
                              IOMMUTLBEntry *iotlb);
+int vfio_container_add_section_window(VFIOContainer *bcontainer,
+                                      MemoryRegionSection *section,
+                                      Error **errp);
+void vfio_container_del_section_window(VFIOContainer *bcontainer,
+                                       MemoryRegionSection *section);
 
 void vfio_container_init(VFIOContainer *bcontainer,
                          VFIOAddressSpace *space,
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index c92af34eed..49cb5b6958 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -655,7 +655,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
         return;
     }
 
-    if (vfio_container_add_section_window(container, section, &err)) {
+    if (vfio_container_add_section_window(bcontainer, section, &err)) {
         goto fail;
     }
 
@@ -879,7 +879,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
 
     memory_region_unref(section->mr);
 
-    vfio_container_del_section_window(container, section);
+    vfio_container_del_section_window(&container->bcontainer, section);
 }
 
 typedef struct VFIODirtyRanges {
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index e1056dd78e..f2a9a33465 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -48,6 +48,27 @@ int vfio_container_dma_unmap(VFIOContainer *bcontainer,
     return bcontainer->ops->dma_unmap(bcontainer, iova, size, iotlb);
 }
 
+int vfio_container_add_section_window(VFIOContainer *bcontainer,
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
+void vfio_container_del_section_window(VFIOContainer *bcontainer,
+                                       MemoryRegionSection *section)
+{
+    if (!bcontainer->ops->del_window) {
+        return;
+    }
+
+    return bcontainer->ops->del_window(bcontainer, section);
+}
+
 void vfio_container_init(VFIOContainer *bcontainer,
                          VFIOAddressSpace *space,
                          struct VFIOIOMMUBackendOpsClass *ops)
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index fd2d602fb9..7ca61a7d36 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -215,10 +215,13 @@ static int vfio_legacy_dma_map(VFIOContainer *bcontainer, hwaddr iova,
     return -errno;
 }
 
-int vfio_container_add_section_window(VFIOLegacyContainer *container,
-                                      MemoryRegionSection *section,
-                                      Error **errp)
+static int vfio_legacy_add_section_window(VFIOContainer *bcontainer,
+                                          MemoryRegionSection *section,
+                                          Error **errp)
 {
+    VFIOLegacyContainer *container = container_of(bcontainer,
+                                                  VFIOLegacyContainer,
+                                                  bcontainer);
     VFIOHostDMAWindow *hostwin;
     hwaddr pgsize = 0;
     int ret;
@@ -283,9 +286,13 @@ int vfio_container_add_section_window(VFIOLegacyContainer *container,
     return 0;
 }
 
-void vfio_container_del_section_window(VFIOLegacyContainer *container,
-                                       MemoryRegionSection *section)
+static void vfio_legacy_del_section_window(VFIOContainer *bcontainer,
+                                           MemoryRegionSection *section)
 {
+    VFIOLegacyContainer *container = container_of(bcontainer,
+                                                  VFIOLegacyContainer,
+                                                  bcontainer);
+
     if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
         return;
     }
@@ -1174,6 +1181,8 @@ static void vfio_iommu_backend_legacy_ops_class_init(ObjectClass *oc,
 
     ops->dma_map = vfio_legacy_dma_map;
     ops->dma_unmap = vfio_legacy_dma_unmap;
+    ops->add_window = vfio_legacy_add_section_window;
+    ops->del_window = vfio_legacy_del_section_window;
 }
 
 static const TypeInfo vfio_iommu_backend_legacy_ops_type = {
-- 
2.34.1


