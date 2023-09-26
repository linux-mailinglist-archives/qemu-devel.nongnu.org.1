Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A048E7AEBD3
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 13:50:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql6Xh-0002A6-WB; Tue, 26 Sep 2023 07:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ql6Xb-00024Q-8M
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:47:47 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ql6XY-0002MI-3u
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695728864; x=1727264864;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TK3d0qtLOxhEQsxHEcCeWZJD9Hdf0KosaxX5ejifXvk=;
 b=CZFG0Le+S5X8t5RZ2Y5k9VSMvYVh3WS0JqG/WjqQACRBNR3GEjkAo/CL
 QQt5USogqlKlszS7rlL32x0HNNEhgRE41yo+I/8OXcv6GD8ozFDwJLai8
 ipN18eB6ctDcBLVv7ybxFQoTG3vhxrILKGTPRPjNH0XJVhMx1MLUQVBdZ
 Acq1Scfz/a1DsRP/R16TJJV9F+GyGp9BD8ZJN0Sw2TBvMFuudu0gCL8A2
 /mPbDQUJkYtEFyyv4boBgnF7V05f/CQfNPEEKaPaHS7BIUCTtbobONqsp
 OGzoIvYbMiNfGq+JqeZ7Mc8NAQOzgdhb8z0gvGL9NbZXMWVv9uemYNDZM A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="378825421"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; d="scan'208";a="378825421"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 04:47:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="748789645"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; d="scan'208";a="748789645"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 04:47:38 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 04/12] vfio/common: Introduce
 vfio_container_add|del_section_window()
Date: Tue, 26 Sep 2023 19:32:47 +0800
Message-Id: <20230926113255.1177834-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
References: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
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
VFIO_SPAPR_TCE_v2_IOMMU.

Those helpers hide implementation details beneath the container object
and make the vfio_listener_region_add/del() implementations more
readable. No code change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/common.c | 156 +++++++++++++++++++++++++++--------------------
 1 file changed, 89 insertions(+), 67 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 4e122fc4e4..de6b4a86e2 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -807,6 +807,92 @@ static bool vfio_get_section_iova_range(VFIOContainer *container,
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
@@ -833,62 +919,8 @@ static void vfio_listener_region_add(MemoryListener *listener,
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
@@ -1105,17 +1137,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
 
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


