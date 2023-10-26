Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E727D8110
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 12:47:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvxsc-0007Km-Iz; Thu, 26 Oct 2023 06:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxsa-0007Jy-PH; Thu, 26 Oct 2023 06:46:20 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxsY-0001Gp-Ip; Thu, 26 Oct 2023 06:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698317178; x=1729853178;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FWH8NzIQfnAtMON1iP6JV05ZRsxBefa3j3QkoTLfZ+0=;
 b=eNZVFh1L8leq/V4FJzpIupYRz5y/vUuyXr9ynL3DKQlf1B7rlq5e1umr
 0KaRQPSEaIvVE2pK0s3wb5PHhznQ2wa0+2AwKrrfLhr+lCi2iK7v1csgY
 lqFKrPP1d9G99JXhzk9fbS5PDfImRdKmIqCFyNqKo/mH1exIDq8yDNQLp
 9osnsVafzDCCmUQHWNTXCHeCUK2mnjPfNxuzDbPkus47rQg/6pl9X6jKp
 nmRssGst8WWE3H7qWezeCRbj+gyxdtS+jBk0aPfm1H1wIweKo9fH0Pn3y
 vFasx2uvR7KocYo2aF7l8M/ydZUMT2gyXEDtVZ56MGXbmRzdVcWrSkzZa A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="372563193"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; d="scan'208";a="372563193"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:46:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="463567"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:46:02 -0700
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
Subject: [PATCH v3 02/37] vfio/container: Move
 vfio_container_add/del_section_window into spapr.c
Date: Thu, 26 Oct 2023 18:30:29 +0800
Message-Id: <20231026103104.1686921-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

vfio_container_add/del_section_window are spapr specific functions,
so move them into spapr.c to make container.c cleaner.

No functional changes intended.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/container.c | 90 ---------------------------------------------
 hw/vfio/spapr.c     | 90 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 90 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 83c0f05bba..7a3f005d1b 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -20,9 +20,6 @@
 
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
-#ifdef CONFIG_KVM
-#include <linux/kvm.h>
-#endif
 #include <linux/vfio.h>
 
 #include "hw/vfio/vfio-common.h"
@@ -32,7 +29,6 @@
 #include "hw/hw.h"
 #include "qemu/error-report.h"
 #include "qemu/range.h"
-#include "sysemu/kvm.h"
 #include "sysemu/reset.h"
 #include "trace.h"
 #include "qapi/error.h"
@@ -204,92 +200,6 @@ int vfio_dma_map(VFIOContainer *container, hwaddr iova,
     return -errno;
 }
 
-int vfio_container_add_section_window(VFIOContainer *container,
-                                      MemoryRegionSection *section,
-                                      Error **errp)
-{
-    VFIOHostDMAWindow *hostwin;
-    hwaddr pgsize = 0;
-    int ret;
-
-    if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
-        return 0;
-    }
-
-    /* For now intersections are not allowed, we may relax this later */
-    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
-        if (ranges_overlap(hostwin->min_iova,
-                           hostwin->max_iova - hostwin->min_iova + 1,
-                           section->offset_within_address_space,
-                           int128_get64(section->size))) {
-            error_setg(errp,
-                "region [0x%"PRIx64",0x%"PRIx64"] overlaps with existing"
-                "host DMA window [0x%"PRIx64",0x%"PRIx64"]",
-                section->offset_within_address_space,
-                section->offset_within_address_space +
-                    int128_get64(section->size) - 1,
-                hostwin->min_iova, hostwin->max_iova);
-            return -EINVAL;
-        }
-    }
-
-    ret = vfio_spapr_create_window(container, section, &pgsize);
-    if (ret) {
-        error_setg_errno(errp, -ret, "Failed to create SPAPR window");
-        return ret;
-    }
-
-    vfio_host_win_add(container, section->offset_within_address_space,
-                      section->offset_within_address_space +
-                      int128_get64(section->size) - 1, pgsize);
-#ifdef CONFIG_KVM
-    if (kvm_enabled()) {
-        VFIOGroup *group;
-        IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
-        struct kvm_vfio_spapr_tce param;
-        struct kvm_device_attr attr = {
-            .group = KVM_DEV_VFIO_GROUP,
-            .attr = KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE,
-            .addr = (uint64_t)(unsigned long)&param,
-        };
-
-        if (!memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_SPAPR_TCE_FD,
-                                          &param.tablefd)) {
-            QLIST_FOREACH(group, &container->group_list, container_next) {
-                param.groupfd = group->fd;
-                if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
-                    error_setg_errno(errp, errno,
-                                     "vfio: failed GROUP_SET_SPAPR_TCE for "
-                                     "KVM VFIO device %d and group fd %d",
-                                     param.tablefd, param.groupfd);
-                    return -errno;
-                }
-                trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
-            }
-        }
-    }
-#endif
-    return 0;
-}
-
-void vfio_container_del_section_window(VFIOContainer *container,
-                                       MemoryRegionSection *section)
-{
-    if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
-        return;
-    }
-
-    vfio_spapr_remove_window(container,
-                             section->offset_within_address_space);
-    if (vfio_host_win_del(container,
-                          section->offset_within_address_space,
-                          section->offset_within_address_space +
-                          int128_get64(section->size) - 1) < 0) {
-        hw_error("%s: Cannot delete missing window at %"HWADDR_PRIx,
-                 __func__, section->offset_within_address_space);
-    }
-}
-
 int vfio_set_dirty_page_tracking(VFIOContainer *container, bool start)
 {
     int ret;
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 9ec1e95f6d..9a7517c042 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -11,6 +11,10 @@
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
+#ifdef CONFIG_KVM
+#include <linux/kvm.h>
+#endif
+#include "sysemu/kvm.h"
 
 #include "hw/vfio/vfio-common.h"
 #include "hw/hw.h"
@@ -253,3 +257,89 @@ int vfio_spapr_remove_window(VFIOContainer *container,
 
     return 0;
 }
+
+int vfio_container_add_section_window(VFIOContainer *container,
+                                      MemoryRegionSection *section,
+                                      Error **errp)
+{
+    VFIOHostDMAWindow *hostwin;
+    hwaddr pgsize = 0;
+    int ret;
+
+    if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
+        return 0;
+    }
+
+    /* For now intersections are not allowed, we may relax this later */
+    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
+        if (ranges_overlap(hostwin->min_iova,
+                           hostwin->max_iova - hostwin->min_iova + 1,
+                           section->offset_within_address_space,
+                           int128_get64(section->size))) {
+            error_setg(errp,
+                "region [0x%"PRIx64",0x%"PRIx64"] overlaps with existing"
+                "host DMA window [0x%"PRIx64",0x%"PRIx64"]",
+                section->offset_within_address_space,
+                section->offset_within_address_space +
+                    int128_get64(section->size) - 1,
+                hostwin->min_iova, hostwin->max_iova);
+            return -EINVAL;
+        }
+    }
+
+    ret = vfio_spapr_create_window(container, section, &pgsize);
+    if (ret) {
+        error_setg_errno(errp, -ret, "Failed to create SPAPR window");
+        return ret;
+    }
+
+    vfio_host_win_add(container, section->offset_within_address_space,
+                      section->offset_within_address_space +
+                      int128_get64(section->size) - 1, pgsize);
+#ifdef CONFIG_KVM
+    if (kvm_enabled()) {
+        VFIOGroup *group;
+        IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
+        struct kvm_vfio_spapr_tce param;
+        struct kvm_device_attr attr = {
+            .group = KVM_DEV_VFIO_GROUP,
+            .attr = KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE,
+            .addr = (uint64_t)(unsigned long)&param,
+        };
+
+        if (!memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_SPAPR_TCE_FD,
+                                          &param.tablefd)) {
+            QLIST_FOREACH(group, &container->group_list, container_next) {
+                param.groupfd = group->fd;
+                if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
+                    error_setg_errno(errp, errno,
+                                     "vfio: failed GROUP_SET_SPAPR_TCE for "
+                                     "KVM VFIO device %d and group fd %d",
+                                     param.tablefd, param.groupfd);
+                    return -errno;
+                }
+                trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
+            }
+        }
+    }
+#endif
+    return 0;
+}
+
+void vfio_container_del_section_window(VFIOContainer *container,
+                                       MemoryRegionSection *section)
+{
+    if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
+        return;
+    }
+
+    vfio_spapr_remove_window(container,
+                             section->offset_within_address_space);
+    if (vfio_host_win_del(container,
+                          section->offset_within_address_space,
+                          section->offset_within_address_space +
+                          int128_get64(section->size) - 1) < 0) {
+        hw_error("%s: Cannot delete missing window at %"HWADDR_PRIx,
+                 __func__, section->offset_within_address_space);
+    }
+}
-- 
2.34.1


