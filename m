Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD247E276F
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:45:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00kJ-000754-Qj; Mon, 06 Nov 2023 09:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org>)
 id 1r00js-0006yY-GF
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:38:05 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org>)
 id 1r00jp-00011S-UN
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:38:04 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SPDV117rgz4xWl;
 Tue,  7 Nov 2023 01:38:01 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SPDTz39zMz4wc1;
 Tue,  7 Nov 2023 01:37:59 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 19/22] vfio/container: Move
 vfio_container_add/del_section_window into spapr.c
Date: Mon,  6 Nov 2023 15:36:50 +0100
Message-ID: <20231106143653.302391-20-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106143653.302391-1-clg@redhat.com>
References: <20231106143653.302391-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

vfio_container_add/del_section_window are spapr specific functions,
so move them into spapr.c to make container.c cleaner.

No functional changes intended.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container.c | 90 ---------------------------------------------
 hw/vfio/spapr.c     | 90 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 90 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 83c0f05bbaa3f43d4c56e1718eda8451bb59e9f1..7a3f005d1b615ba0fd95ab48d9a8babf452649a5 100644
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
index 9ec1e95f6da7f920f368a61932dab8471b1856cf..9a7517c0421090b82c2dc5508b2aa9670287fbe7 100644
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
2.41.0


