Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA277CD898
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 11:52:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt38D-0000yT-ED; Wed, 18 Oct 2023 05:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=VFJy=GA=redhat.com=clg@ozlabs.org>)
 id 1qt37o-0000M2-Hd
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:46:13 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=VFJy=GA=redhat.com=clg@ozlabs.org>)
 id 1qt37m-0003Sb-1k
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:46:00 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S9Qvh3dVWz4xbK;
 Wed, 18 Oct 2023 20:45:52 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9Qvf2ztdz4xZg;
 Wed, 18 Oct 2023 20:45:50 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 05/22] vfio/common: Introduce
 vfio_container_add|del_section_window()
Date: Wed, 18 Oct 2023 11:45:14 +0200
Message-ID: <20231018094531.733211-6-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018094531.733211-1-clg@redhat.com>
References: <20231018094531.733211-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=VFJy=GA=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 156 +++++++++++++++++++++++++++--------------------
 1 file changed, 89 insertions(+), 67 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index c54a72ec803779b45803573c6c633a170c5bad1f..0397788aa58c8deaa8cf3ed19fa8eb40e91d7678 100644
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
-                        error_setg_errno(&err, errno,
-                                         "vfio: failed GROUP_SET_SPAPR_TCE for "
-                                         "KVM VFIO device %d and group fd %d",
-                                         param.tablefd, param.groupfd);
-                        goto fail;
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
2.41.0


