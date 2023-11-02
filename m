Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB4E7DED6E
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:36:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qySA0-0007SF-7E; Thu, 02 Nov 2023 03:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS9w-0007E7-Cp; Thu, 02 Nov 2023 03:30:32 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS9u-0003Ox-BN; Thu, 02 Nov 2023 03:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698910230; x=1730446230;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KXQqgqbLJd95sOJC11Mdq5aN1v8GXo0opX/2P4N8Aps=;
 b=Ov0/1EF0DCxpCOoONxbtSnqCvl+/2cd346zmNNULIzvLw8DTdeQ25YhR
 sPdLMcyKLk0QHSUUDe0FtVbwVN86opWoFmyaLdCRz8LceC5rSAFwBXLSa
 LPEJBrwR9oC+sDkbpaugpO1Bz5PA6V1rqXXm5+e0g/BpVy/96MuTYz1TJ
 zmu0YYdMxA0KYmYIDN7ikEFzsZGtmzAYEMWYFV3LQr6gZHOlp7nqoeU4C
 yjWBmb3y64ggvaR6AV2kOHSJtVw/TY32/JtvahZyDKOv4kwOKmSBlXty1
 MMVTJm4OK4U4JfJHmgtBJ91xF8bFRzq9d1VmVS2ipk/37rbHYvNax820L A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452953255"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="452953255"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:30:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711055510"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="711055510"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:30:01 -0700
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
Subject: [PATCH v4 23/41] vfio/spapr: Move prereg_listener into spapr container
Date: Thu,  2 Nov 2023 15:12:44 +0800
Message-Id: <20231102071302.1818071-24-zhenzhong.duan@intel.com>
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
 hw/vfio/spapr.c               | 24 ++++++++++++++++--------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 055f679363..ed6148c058 100644
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
index 5be1911aad..68c3dd6c75 100644
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
@@ -445,6 +448,8 @@ static void setup_spapr_ops(VFIOContainerBase *bcontainer)
 int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
 {
     VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
+                                                  container);
     struct vfio_iommu_spapr_tce_info info;
     bool v2 = container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU;
     int ret, fd = container->fd;
@@ -463,9 +468,9 @@ int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
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
@@ -513,7 +518,7 @@ int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
 
 listener_unregister_exit:
     if (v2) {
-        memory_listener_unregister(&container->prereg_listener);
+        memory_listener_unregister(&scontainer->prereg_listener);
     }
     return ret;
 }
@@ -523,7 +528,10 @@ void vfio_spapr_container_deinit(VFIOContainer *container)
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


