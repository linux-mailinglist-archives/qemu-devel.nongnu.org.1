Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F1C7D8123
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 12:50:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvxuv-0002le-Ny; Thu, 26 Oct 2023 06:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxuM-0002Et-Vs; Thu, 26 Oct 2023 06:48:17 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxuC-0001Q0-5E; Thu, 26 Oct 2023 06:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698317280; x=1729853280;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w5+kwyEFTNpXEaRbCnpjDpn9Oq8F5pci+Oh4DxWnBwQ=;
 b=d0lPCVv7Aq2eiGNgAiHSCAxUO/YdGDYvnUh6F263jADf5Yo7LMseU2Uv
 toDwpInTscSXLA2ILHuahd9aJE5H13Q+HJnipcx1DXemu2s+MMfR34xHH
 lUY8leqW82QnLqGBb6O/+GCLjxYWhiSi97sRxf+uRe9Yaa9PdhET5Um4O
 izld+jTcqAB93JluclstLcY+wSpULqVM8nVoVFHqmJJAdy/d4L7wdmys2
 7WauZhTf4DtSscYB/GEADmcGfA5ePSUeVB3X3gPbXWuihv2N2rEr+xhJa
 0Gradb5Ze8LJo75DlkdKESCelmVHYq3isxMAm+WSS/xXXY0vMnNOoDX+4 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="372563605"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; d="scan'208";a="372563605"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:47:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="463737"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:47:20 -0700
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
Subject: [PATCH v3 21/37] vfio/spapr: Move prereg_listener into spapr container
Date: Thu, 26 Oct 2023 18:30:48 +0800
Message-Id: <20231026103104.1686921-22-zhenzhong.duan@intel.com>
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
 hw/vfio/spapr.c               | 24 ++++++++++++++++--------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 1489b49d71..913e9f5771 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -78,7 +78,6 @@ struct VFIOGroup;
 typedef struct VFIOContainer {
     VFIOContainerBase bcontainer;
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
-    MemoryListener prereg_listener;
     unsigned iommu_type;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     QLIST_HEAD(, VFIOGroup) group_list;
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 43e32e544b..566a79906c 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -26,6 +26,7 @@
 
 typedef struct VFIOSpaprContainer {
     VFIOContainer container;
+    MemoryListener prereg_listener;
 } VFIOSpaprContainer;
 
 static bool vfio_prereg_listener_skipped_section(MemoryRegionSection *section)
@@ -48,8 +49,9 @@ static void *vfio_prereg_gpa_to_vaddr(MemoryRegionSection *section, hwaddr gpa)
 static void vfio_prereg_listener_region_add(MemoryListener *listener,
                                             MemoryRegionSection *section)
 {
-    VFIOContainer *container = container_of(listener, VFIOContainer,
-                                            prereg_listener);
+    VFIOSpaprContainer *scontainer = container_of(listener, VFIOSpaprContainer,
+                                                  prereg_listener);
+    VFIOContainer *container = &scontainer->container;
     VFIOContainerBase *bcontainer = &container->bcontainer;
     const hwaddr gpa = section->offset_within_address_space;
     hwaddr end;
@@ -107,8 +109,9 @@ static void vfio_prereg_listener_region_add(MemoryListener *listener,
 static void vfio_prereg_listener_region_del(MemoryListener *listener,
                                             MemoryRegionSection *section)
 {
-    VFIOContainer *container = container_of(listener, VFIOContainer,
-                                            prereg_listener);
+    VFIOSpaprContainer *scontainer = container_of(listener, VFIOSpaprContainer,
+                                                  prereg_listener);
+    VFIOContainer *container = &scontainer->container;
     const hwaddr gpa = section->offset_within_address_space;
     hwaddr end;
     int ret;
@@ -403,6 +406,8 @@ const VFIOIOMMUSpaprOps vfio_iommu_spapr_ops = {
 bool vfio_spapr_container_init(VFIOContainer *container, Error **errp)
 {
     VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
+                                                  container);
     struct vfio_iommu_spapr_tce_info info;
     bool v2 = container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU;
     int ret, fd = container->fd;
@@ -419,9 +424,9 @@ bool vfio_spapr_container_init(VFIOContainer *container, Error **errp)
             return -errno;
         }
     } else {
-        container->prereg_listener = vfio_prereg_listener;
+        scontainer->prereg_listener = vfio_prereg_listener;
 
-        memory_listener_register(&container->prereg_listener,
+        memory_listener_register(&scontainer->prereg_listener,
                                  &address_space_memory);
         if (bcontainer->error) {
             ret = -1;
@@ -467,7 +472,7 @@ bool vfio_spapr_container_init(VFIOContainer *container, Error **errp)
 
 listener_unregister_exit:
     if (v2) {
-        memory_listener_unregister(&container->prereg_listener);
+        memory_listener_unregister(&scontainer->prereg_listener);
     }
     return ret;
 }
@@ -477,7 +482,10 @@ void vfio_spapr_container_deinit(VFIOContainer *container)
     VFIOHostDMAWindow *hostwin, *next;
 
     if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
-        memory_listener_unregister(&container->prereg_listener);
+        VFIOSpaprContainer *scontainer = container_of(container,
+                                                      VFIOSpaprContainer,
+                                                      container);
+        memory_listener_unregister(&scontainer->prereg_listener);
     }
     QLIST_FOREACH_SAFE(hostwin, &container->hostwin_list, hostwin_next,
                        next) {
-- 
2.34.1


