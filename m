Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8A37DED43
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:30:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyS8F-0003FJ-6Y; Thu, 02 Nov 2023 03:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS8D-0003Ep-CG; Thu, 02 Nov 2023 03:28:45 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS8A-0003H2-46; Thu, 02 Nov 2023 03:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698910122; x=1730446122;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fa1hVBkiJF9ggE12WPPLphRmMrq/8tCZaj5CDa4UGGk=;
 b=ETvMvDyAoNWwMldyXwAOlAcp6becLuOoCSfvESQtNYl0yYHxwaWag4lC
 0v9cib9vh+6Nib1y9IWmmWKmKkTo0gw6bKgBvNuQI4Pq+Kt7ilUONnBcx
 fOfoE8unzQVX9XVHI5OpOXwJKZiKI0/5p/cU1o+skskLzJYolF+QRbcQM
 WyGX3NHxO6G9b4XCg2DEiGosJ0t7BljpE/nASh05jrhksGY5ojO+VBitl
 M+3eaEkmhfGiIvOB4yy6iuyDAh8TIZA6afIrPNLBAZ4eXybMxWj8sUCsy
 hieZlTWWj5DCGiOEa3jGEJo6pKp0wDBGuFo4Icux2uHt2hykEgJyr3CCY Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452952983"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="452952983"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:28:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711055122"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="711055122"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:28:33 -0700
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
Subject: [PATCH v4 03/41] vfio/container: Move spapr specific init/deinit into
 spapr.c
Date: Thu,  2 Nov 2023 15:12:24 +0800
Message-Id: <20231102071302.1818071-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Move spapr specific init/deinit code into spapr.c and wrap
them with vfio_spapr_container_init/deinit, this way footprint
of spapr is further reduced, vfio_prereg_listener could also
be made static.

vfio_listener_release is unnecessary when prereg_listener is
moved out, so have it removed.

No functional changes intended.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |  4 +-
 hw/vfio/container.c           | 82 +++++------------------------------
 hw/vfio/spapr.c               | 81 +++++++++++++++++++++++++++++++++-
 3 files changed, 95 insertions(+), 72 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 0c3d390e8b..ed5a8e4754 100644
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
+int vfio_spapr_container_init(VFIOContainer *container, Error **errp);
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
index 9a7517c042..00dbd7af11 100644
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
@@ -343,3 +344,81 @@ void vfio_container_del_section_window(VFIOContainer *container,
                  __func__, section->offset_within_address_space);
     }
 }
+
+int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
+{
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
+    return 0;
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


