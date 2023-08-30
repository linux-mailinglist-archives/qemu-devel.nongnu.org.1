Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BAC78D548
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 12:55:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbIoz-0004FA-AZ; Wed, 30 Aug 2023 06:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qbIow-0004EQ-AL
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:53:10 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qbIos-0007fH-R3
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693392786; x=1724928786;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AZlTzsz7sjLkxbo98T5TeReGMRoYap7+PFgc2Cox5bQ=;
 b=bUR8tadD8mVE1sYumayC7hDdCQitO8mEqprTep6kW+FThFwmmxtatejC
 0qNwxkCdFGj7k9atkOkiXfqtpqe9C5OcvpGJByD1lbWRprGaGbgFH8TXa
 Oz4E7kWmhRWRlTWSYPDE5mYdQaOqyghsWQ96RFCDHv3ye4EmaNAX8KGIA
 Wx1NMHsAWPlvoxHI7cEmYLNnDC/ZpaSqHbyOMIyMEbxWdZCBZYkCAN9dK
 p3a8bbsxMHgmJ3KcwgKIFwepMiPbgLs6nqz+sw+ltSZGbLkORp6uO4nBx
 KYW/fQZTDZOGVEv1Oa58pHPXDZzRrFcUXh1zmSAlJ5vUReIkpO3Z6+ta7 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="373016403"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; d="scan'208";a="373016403"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2023 03:52:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="715866051"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; d="scan'208";a="715866051"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2023 03:52:43 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v1 04/22] vfio/common: Introduce
 vfio_container_add|del_section_window()
Date: Wed, 30 Aug 2023 18:37:36 +0800
Message-Id: <20230830103754.36461-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830103754.36461-1-zhenzhong.duan@intel.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.93;
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

Introduce helper functions that isolate the code used for
VFIO_SPAPR_TCE_v2_IOMMU. This code reliance is IOMMU backend
specific whereas the rest of the code in the callers, ie.
vfio_listener_region_add|del is not.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/common.c | 156 +++++++++++++++++++++++++++--------------------
 1 file changed, 89 insertions(+), 67 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 9ca695837f..67150e4575 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -796,6 +796,92 @@ static bool vfio_get_section_iova_range(VFIOContainer *container,
     return true;
 }
 
+static int vfio_container_add_section_window(VFIOContainer *container,
+                                             MemoryRegionSection *section,
+                                             Error **errp)
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
+                    error_report("vfio: failed to setup fd %d "
+                                 "for a group with fd %d: %s",
+                                 param.tablefd, param.groupfd,
+                                 strerror(errno));
+                    return 0;
+                }
+                trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
+            }
+        }
+    }
+#endif
+    return 0;
+}
+
+static void vfio_container_del_section_window(VFIOContainer *container,
+                                              MemoryRegionSection *section)
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
+
 static void vfio_listener_region_add(MemoryListener *listener,
                                      MemoryRegionSection *section)
 {
@@ -822,62 +908,8 @@ static void vfio_listener_region_add(MemoryListener *listener,
         return;
     }
 
-    if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
-        hwaddr pgsize = 0;
-
-        /* For now intersections are not allowed, we may relax this later */
-        QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
-            if (ranges_overlap(hostwin->min_iova,
-                               hostwin->max_iova - hostwin->min_iova + 1,
-                               section->offset_within_address_space,
-                               int128_get64(section->size))) {
-                error_setg(&err,
-                    "region [0x%"PRIx64",0x%"PRIx64"] overlaps with existing"
-                    "host DMA window [0x%"PRIx64",0x%"PRIx64"]",
-                    section->offset_within_address_space,
-                    section->offset_within_address_space +
-                        int128_get64(section->size) - 1,
-                    hostwin->min_iova, hostwin->max_iova);
-                goto fail;
-            }
-        }
-
-        ret = vfio_spapr_create_window(container, section, &pgsize);
-        if (ret) {
-            error_setg_errno(&err, -ret, "Failed to create SPAPR window");
-            goto fail;
-        }
-
-        vfio_host_win_add(container, section->offset_within_address_space,
-                          section->offset_within_address_space +
-                          int128_get64(section->size) - 1, pgsize);
-#ifdef CONFIG_KVM
-        if (kvm_enabled()) {
-            VFIOGroup *group;
-            IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
-            struct kvm_vfio_spapr_tce param;
-            struct kvm_device_attr attr = {
-                .group = KVM_DEV_VFIO_GROUP,
-                .attr = KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE,
-                .addr = (uint64_t)(unsigned long)&param,
-            };
-
-            if (!memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_SPAPR_TCE_FD,
-                                              &param.tablefd)) {
-                QLIST_FOREACH(group, &container->group_list, container_next) {
-                    param.groupfd = group->fd;
-                    if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
-                        error_report("vfio: failed to setup fd %d "
-                                     "for a group with fd %d: %s",
-                                     param.tablefd, param.groupfd,
-                                     strerror(errno));
-                        return;
-                    }
-                    trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
-                }
-            }
-        }
-#endif
+    if (vfio_container_add_section_window(container, section, &err)) {
+        goto fail;
     }
 
     hostwin = vfio_find_hostwin(container, iova, end);
@@ -1094,17 +1126,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
 
     memory_region_unref(section->mr);
 
-    if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
-        vfio_spapr_remove_window(container,
-                                 section->offset_within_address_space);
-        if (vfio_host_win_del(container,
-                              section->offset_within_address_space,
-                              section->offset_within_address_space +
-                              int128_get64(section->size) - 1) < 0) {
-            hw_error("%s: Cannot delete missing window at %"HWADDR_PRIx,
-                     __func__, section->offset_within_address_space);
-        }
-    }
+    vfio_container_del_section_window(container, section);
 }
 
 static int vfio_set_dirty_page_tracking(VFIOContainer *container, bool start)
-- 
2.34.1


