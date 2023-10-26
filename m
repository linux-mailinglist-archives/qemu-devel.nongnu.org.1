Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2717D812B
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 12:50:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvxsh-0007M3-Op; Thu, 26 Oct 2023 06:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxsf-0007Lc-SE; Thu, 26 Oct 2023 06:46:26 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxsd-0001Hy-SM; Thu, 26 Oct 2023 06:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698317183; x=1729853183;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VfIkbI1fdwCJdZ1kaD6+6suI4Zq2iPxTLHayCXaq2U0=;
 b=ig+Hg5zo2CV5S5WsnAKsdj5RkND7LgQQxrCGiOo3gCb6qkxBgosy0z6d
 0y0tBDgemgDR134sfS6OWTV0CmALijdJQhZr6+j2dsF/2h9qa+WNl3l8e
 2NHCNdkkp9t5fvdK2hWzOn0B6WI48J3SAje/jbXRraXRfugQRjAzEjmW1
 uQw/Zi+zss7BnZ9ONEqEp6Us6QWzW0J9MpceT0f+2A8bRoLn400re1GZp
 2yGf/cE0bm9AZDT5xyDKKMT8pjTYbN08MjI0h4XBXCbF5TBSg40Dw77dL
 P2r0MFaqz3crWIGynsHNvDGjvErXDiTfpsqw8KtfrjKlYAxU5thCjLoqh Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="372563207"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; d="scan'208";a="372563207"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:46:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="463580"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:46:07 -0700
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
Subject: [PATCH v3 03/37] vfio/container: Move spapr specific init/deinit into
 spapr.c
Date: Thu, 26 Oct 2023 18:30:30 +0800
Message-Id: <20231026103104.1686921-4-zhenzhong.duan@intel.com>
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

Move spapr specific init/deinit code into spapr.c and wrap
them with vfio_spapr_container_init/deinit, this way footprint
of spapr is further reduced, vfio_prereg_listener could also
be made static.

vfio_listener_release is unnecessary when prereg_listener is
moved out, so have it removed.

No functional changes intended.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h |  4 +-
 hw/vfio/container.c           | 82 +++++------------------------------
 hw/vfio/spapr.c               | 80 +++++++++++++++++++++++++++++++++-
 3 files changed, 94 insertions(+), 72 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 0c3d390e8b..8d1d4f0a89 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -225,11 +225,14 @@ int vfio_set_dirty_page_tracking(VFIOContainer *container, bool start);
 int vfio_query_dirty_bitmap(VFIOContainer *container, VFIOBitmap *vbmap,
                             hwaddr iova, hwaddr size);
 
+/* SPAPR specific */
 int vfio_container_add_section_window(VFIOContainer *container,
                                       MemoryRegionSection *section,
                                       Error **errp);
 void vfio_container_del_section_window(VFIOContainer *container,
                                        MemoryRegionSection *section);
+bool vfio_spapr_container_init(VFIOContainer *container, Error **errp);
+void vfio_spapr_container_deinit(VFIOContainer *container);
 
 void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
 void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
@@ -289,7 +292,6 @@ vfio_get_device_info_cap(struct vfio_device_info *info, uint16_t id);
 struct vfio_info_cap_header *
 vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id);
 #endif
-extern const MemoryListener vfio_prereg_listener;
 
 int vfio_spapr_create_window(VFIOContainer *container,
                              MemoryRegionSection *section,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 7a3f005d1b..204b244b11 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -264,14 +264,6 @@ int vfio_query_dirty_bitmap(VFIOContainer *container, VFIOBitmap *vbmap,
     return ret;
 }
 
-static void vfio_listener_release(VFIOContainer *container)
-{
-    memory_listener_unregister(&container->listener);
-    if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
-        memory_listener_unregister(&container->prereg_listener);
-    }
-}
-
 static struct vfio_info_cap_header *
 vfio_get_iommu_type1_info_cap(struct vfio_iommu_type1_info *info, uint16_t id)
 {
@@ -612,69 +604,11 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     case VFIO_SPAPR_TCE_v2_IOMMU:
     case VFIO_SPAPR_TCE_IOMMU:
     {
-        struct vfio_iommu_spapr_tce_info info;
-        bool v2 = container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU;
-
-        /*
-         * The host kernel code implementing VFIO_IOMMU_DISABLE is called
-         * when container fd is closed so we do not call it explicitly
-         * in this file.
-         */
-        if (!v2) {
-            ret = ioctl(fd, VFIO_IOMMU_ENABLE);
-            if (ret) {
-                error_setg_errno(errp, errno, "failed to enable container");
-                ret = -errno;
-                goto enable_discards_exit;
-            }
-        } else {
-            container->prereg_listener = vfio_prereg_listener;
-
-            memory_listener_register(&container->prereg_listener,
-                                     &address_space_memory);
-            if (container->error) {
-                memory_listener_unregister(&container->prereg_listener);
-                ret = -1;
-                error_propagate_prepend(errp, container->error,
-                    "RAM memory listener initialization failed: ");
-                goto enable_discards_exit;
-            }
-        }
-
-        info.argsz = sizeof(info);
-        ret = ioctl(fd, VFIO_IOMMU_SPAPR_TCE_GET_INFO, &info);
+        ret = vfio_spapr_container_init(container, errp);
         if (ret) {
-            error_setg_errno(errp, errno,
-                             "VFIO_IOMMU_SPAPR_TCE_GET_INFO failed");
-            ret = -errno;
-            if (v2) {
-                memory_listener_unregister(&container->prereg_listener);
-            }
             goto enable_discards_exit;
         }
-
-        if (v2) {
-            container->pgsizes = info.ddw.pgsizes;
-            /*
-             * There is a default window in just created container.
-             * To make region_add/del simpler, we better remove this
-             * window now and let those iommu_listener callbacks
-             * create/remove them when needed.
-             */
-            ret = vfio_spapr_remove_window(container, info.dma32_window_start);
-            if (ret) {
-                error_setg_errno(errp, -ret,
-                                 "failed to remove existing window");
-                goto enable_discards_exit;
-            }
-        } else {
-            /* The default table uses 4K pages */
-            container->pgsizes = 0x1000;
-            vfio_host_win_add(container, info.dma32_window_start,
-                              info.dma32_window_start +
-                              info.dma32_window_size - 1,
-                              0x1000);
-        }
+        break;
     }
     }
 
@@ -704,7 +638,11 @@ listener_release_exit:
     QLIST_REMOVE(group, container_next);
     QLIST_REMOVE(container, next);
     vfio_kvm_device_del_group(group);
-    vfio_listener_release(container);
+    memory_listener_unregister(&container->listener);
+    if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU ||
+        container->iommu_type == VFIO_SPAPR_TCE_IOMMU) {
+        vfio_spapr_container_deinit(container);
+    }
 
 enable_discards_exit:
     vfio_ram_block_discard_disable(container, false);
@@ -734,7 +672,11 @@ static void vfio_disconnect_container(VFIOGroup *group)
      * group.
      */
     if (QLIST_EMPTY(&container->group_list)) {
-        vfio_listener_release(container);
+        memory_listener_unregister(&container->listener);
+        if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU ||
+            container->iommu_type == VFIO_SPAPR_TCE_IOMMU) {
+            vfio_spapr_container_deinit(container);
+        }
     }
 
     if (ioctl(group->fd, VFIO_GROUP_UNSET_CONTAINER, &container->fd)) {
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 9a7517c042..fd0613dfde 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -15,6 +15,7 @@
 #include <linux/kvm.h>
 #endif
 #include "sysemu/kvm.h"
+#include "exec/address-spaces.h"
 
 #include "hw/vfio/vfio-common.h"
 #include "hw/hw.h"
@@ -139,7 +140,7 @@ static void vfio_prereg_listener_region_del(MemoryListener *listener,
     trace_vfio_prereg_unregister(reg.vaddr, reg.size, ret ? -errno : 0);
 }
 
-const MemoryListener vfio_prereg_listener = {
+static const MemoryListener vfio_prereg_listener = {
     .name = "vfio-pre-reg",
     .region_add = vfio_prereg_listener_region_add,
     .region_del = vfio_prereg_listener_region_del,
@@ -343,3 +344,80 @@ void vfio_container_del_section_window(VFIOContainer *container,
                  __func__, section->offset_within_address_space);
     }
 }
+
+bool vfio_spapr_container_init(VFIOContainer *container, Error **errp)
+{
+
+    struct vfio_iommu_spapr_tce_info info;
+    bool v2 = container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU;
+    int ret, fd = container->fd;
+
+    /*
+     * The host kernel code implementing VFIO_IOMMU_DISABLE is called
+     * when container fd is closed so we do not call it explicitly
+     * in this file.
+     */
+    if (!v2) {
+        ret = ioctl(fd, VFIO_IOMMU_ENABLE);
+        if (ret) {
+            error_setg_errno(errp, errno, "failed to enable container");
+            return -errno;
+        }
+    } else {
+        container->prereg_listener = vfio_prereg_listener;
+
+        memory_listener_register(&container->prereg_listener,
+                                 &address_space_memory);
+        if (container->error) {
+            ret = -1;
+            error_propagate_prepend(errp, container->error,
+                    "RAM memory listener initialization failed: ");
+            goto listener_unregister_exit;
+        }
+    }
+
+    info.argsz = sizeof(info);
+    ret = ioctl(fd, VFIO_IOMMU_SPAPR_TCE_GET_INFO, &info);
+    if (ret) {
+        error_setg_errno(errp, errno,
+                         "VFIO_IOMMU_SPAPR_TCE_GET_INFO failed");
+        ret = -errno;
+        goto listener_unregister_exit;
+    }
+
+    if (v2) {
+        container->pgsizes = info.ddw.pgsizes;
+        /*
+         * There is a default window in just created container.
+         * To make region_add/del simpler, we better remove this
+         * window now and let those iommu_listener callbacks
+         * create/remove them when needed.
+         */
+        ret = vfio_spapr_remove_window(container, info.dma32_window_start);
+        if (ret) {
+            error_setg_errno(errp, -ret,
+                             "failed to remove existing window");
+            goto listener_unregister_exit;
+        }
+    } else {
+        /* The default table uses 4K pages */
+        container->pgsizes = 0x1000;
+        vfio_host_win_add(container, info.dma32_window_start,
+                          info.dma32_window_start +
+                          info.dma32_window_size - 1,
+                          0x1000);
+    }
+
+listener_unregister_exit:
+    if (v2) {
+        memory_listener_unregister(&container->prereg_listener);
+    }
+    return ret;
+}
+
+void vfio_spapr_container_deinit(VFIOContainer *container)
+{
+    if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
+        memory_listener_unregister(&container->prereg_listener);
+    }
+}
-- 
2.34.1


