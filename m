Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 088BF750052
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 09:43:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJUS0-0004I8-Gl; Wed, 12 Jul 2023 03:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJURx-0004H4-EZ; Wed, 12 Jul 2023 03:39:49 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJURs-0006nZ-UH; Wed, 12 Jul 2023 03:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689147584; x=1720683584;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Vm32YtQ1ANia/rY579BNJlNYt1i3sYc0ooR9xFjAoSw=;
 b=KnGgwC/TMqbBphKJXY2lUFK+Pedk/fLMVzOadDsrnY0cCmQdMlCJF2v5
 rkVRrieev+JubLcRCKLIM5c+UIs01bBZpgDARguT+2a8YMtQiz/ZD1FKW
 JHw1c2L4PEmXRiYodqmn+GuvPG34LHeDMfhdOjcY/sA0JlhHFuZKfiYub
 VMEoX3Yud8eRRvjwv11KLHJ5pIns8+Xe0nIHrkZMlxSHClO8gVAsrjS26
 GJqxXUWpLHWXFHH6eYLKKRfpFq6DQ5LMpcKDNqYlJ9bg9BNYlROFzliGv
 jnzEjSOCz8TMW7Kr3aSw6wdGMPMT1rTQyVIr6SCGEdEU7Aa9yXxc/qF9+ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="430953678"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="430953678"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:39:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="835024030"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="835024030"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:39:27 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, eric.auger@redhat.com, peterx@redhat.com,
 jasonwang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 qemu-ppc@nongnu.org (open list:sPAPR (pseries))
Subject: [RFC PATCH v4 10/24] vfio: Add base container
Date: Wed, 12 Jul 2023 15:25:14 +0800
Message-Id: <20230712072528.275577-11-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712072528.275577-1-zhenzhong.duan@intel.com>
References: <20230712072528.275577-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=zhenzhong.duan@intel.com; helo=mga07.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Yi Liu <yi.l.liu@intel.com>

Abstract the VFIOContainer to be a base object. It is supposed to be
embedded by legacy VFIO container and later on, into the new iommufd
based container.

The base container implements generic code such as code related to
memory_listener and address space management. The VFIOContainerOps
implements callbacks that depend on the kernel user space being used.

'as.c' only manipulates the base container with wrapper functions that
calls the functions defined in VFIOContainerOps. Existing 'container.c'
code is converted to implement the legacy container ops functions.

Existing migration code only works with the legacy container.
Also 'spapr.c' isn't BE agnostic.

Below is the base container. It's named as VFIOContainer, old VFIOContainer
is replaced with VFIOLegacyContainer.

struct VFIOContainer {
    VFIOContainerOps *ops;
    VFIOAddressSpace *space;
    MemoryListener listener;
    Error *error;
    bool initialized;
    bool dirty_pages_supported;
    uint64_t dirty_pgsizes;
    uint64_t max_dirty_bitmap_size;
    unsigned long pgsizes;
    unsigned int dma_max_mappings;
    QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
    QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
    QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
    QLIST_ENTRY(VFIOContainer) next;
};

struct VFIOLegacyContainer {
    VFIOContainer bcontainer;
    int fd; /* /dev/vfio/vfio, empowered by the attached groups */
    MemoryListener prereg_listener;
    unsigned iommu_type;
    QLIST_HEAD(, VFIOGroup) group_list;
};

Co-authored-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/as.c                          |  63 ++++---
 hw/vfio/container-base.c              | 146 ++++++++++++++++
 hw/vfio/container.c                   | 237 ++++++++++++++++----------
 hw/vfio/meson.build                   |   1 +
 hw/vfio/spapr.c                       |  22 +--
 hw/vfio/trace-events                  |   4 +-
 include/hw/vfio/vfio-common.h         |  84 +--------
 include/hw/vfio/vfio-container-base.h | 152 +++++++++++++++++
 8 files changed, 506 insertions(+), 203 deletions(-)
 create mode 100644 hw/vfio/container-base.c
 create mode 100644 include/hw/vfio/vfio-container-base.h

diff --git a/hw/vfio/as.c b/hw/vfio/as.c
index 55a9f274f7..1cdbeb3ce4 100644
--- a/hw/vfio/as.c
+++ b/hw/vfio/as.c
@@ -375,19 +375,20 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
          * of vaddr will always be there, even if the memory object is
          * destroyed and its backing memory munmap-ed.
          */
-        ret = vfio_dma_map(container, iova,
-                           iotlb->addr_mask + 1, vaddr,
-                           read_only);
+        ret = vfio_container_dma_map(container, iova,
+                                     iotlb->addr_mask + 1, vaddr,
+                                     read_only);
         if (ret) {
-            error_report("vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
+            error_report("vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx", %p) = %d (%s)",
                          container, iova,
                          iotlb->addr_mask + 1, vaddr, ret, strerror(-ret));
         }
     } else {
-        ret = vfio_dma_unmap(container, iova, iotlb->addr_mask + 1, iotlb);
+        ret = vfio_container_dma_unmap(container, iova,
+                                       iotlb->addr_mask + 1, iotlb);
         if (ret) {
-            error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
+            error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%s)",
                          container, iova,
                          iotlb->addr_mask + 1, ret, strerror(-ret));
@@ -403,14 +404,15 @@ static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
 {
     VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
                                                 listener);
+    VFIOContainer *container = vrdl->container;
     const hwaddr size = int128_get64(section->size);
     const hwaddr iova = section->offset_within_address_space;
     int ret;
 
     /* Unmap with a single call. */
-    ret = vfio_dma_unmap(vrdl->container, iova, size , NULL);
+    ret = vfio_container_dma_unmap(container, iova, size , NULL);
     if (ret) {
-        error_report("%s: vfio_dma_unmap() failed: %s", __func__,
+        error_report("%s: vfio_container_dma_unmap() failed: %s", __func__,
                      strerror(-ret));
     }
 }
@@ -420,6 +422,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
 {
     VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
                                                 listener);
+    VFIOContainer *container = vrdl->container;
     const hwaddr end = section->offset_within_region +
                        int128_get64(section->size);
     hwaddr start, next, iova;
@@ -438,8 +441,8 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
                section->offset_within_address_space;
         vaddr = memory_region_get_ram_ptr(section->mr) + start;
 
-        ret = vfio_dma_map(vrdl->container, iova, next - start,
-                           vaddr, section->readonly);
+        ret = vfio_container_dma_map(container, iova, next - start,
+                                     vaddr, section->readonly);
         if (ret) {
             /* Rollback */
             vfio_ram_discard_notify_discard(rdl, section);
@@ -752,10 +755,10 @@ static void vfio_listener_region_add(MemoryListener *listener,
         }
     }
 
-    ret = vfio_dma_map(container, iova, int128_get64(llsize),
-                       vaddr, section->readonly);
+    ret = vfio_container_dma_map(container, iova, int128_get64(llsize),
+                                 vaddr, section->readonly);
     if (ret) {
-        error_setg(&err, "vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
+        error_setg(&err, "vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
                    "0x%"HWADDR_PRIx", %p) = %d (%s)",
                    container, iova, int128_get64(llsize), vaddr, ret,
                    strerror(-ret));
@@ -771,7 +774,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
 
 fail:
     if (memory_region_is_ram_device(section->mr)) {
-        error_report("failed to vfio_dma_map. pci p2p may not work");
+        error_report("failed to vfio_container_dma_map. pci p2p may not work");
         return;
     }
     /*
@@ -856,18 +859,20 @@ static void vfio_listener_region_del(MemoryListener *listener,
         if (int128_eq(llsize, int128_2_64())) {
             /* The unmap ioctl doesn't accept a full 64-bit span. */
             llsize = int128_rshift(llsize, 1);
-            ret = vfio_dma_unmap(container, iova, int128_get64(llsize), NULL);
+            ret = vfio_container_dma_unmap(container, iova,
+                                           int128_get64(llsize), NULL);
             if (ret) {
-                error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
+                error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                              "0x%"HWADDR_PRIx") = %d (%s)",
                              container, iova, int128_get64(llsize), ret,
                              strerror(-ret));
             }
             iova += int128_get64(llsize);
         }
-        ret = vfio_dma_unmap(container, iova, int128_get64(llsize), NULL);
+        ret = vfio_container_dma_unmap(container, iova,
+                                       int128_get64(llsize), NULL);
         if (ret) {
-            error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
+            error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%s)",
                          container, iova, int128_get64(llsize), ret,
                          strerror(-ret));
@@ -1099,7 +1104,7 @@ static void vfio_listener_log_global_start(MemoryListener *listener)
     if (vfio_devices_all_device_dirty_tracking(container)) {
         ret = vfio_devices_dma_logging_start(container);
     } else {
-        ret = vfio_set_dirty_page_tracking(container, true);
+        ret = vfio_container_set_dirty_page_tracking(container, true);
     }
 
     if (ret) {
@@ -1117,7 +1122,7 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
     if (vfio_devices_all_device_dirty_tracking(container)) {
         vfio_devices_dma_logging_stop(container);
     } else {
-        ret = vfio_set_dirty_page_tracking(container, false);
+        ret = vfio_container_set_dirty_page_tracking(container, false);
     }
 
     if (ret) {
@@ -1200,7 +1205,7 @@ int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
     if (all_device_dirty_tracking) {
         ret = vfio_devices_query_dirty_bitmap(container, &vbmap, iova, size);
     } else {
-        ret = vfio_query_dirty_bitmap(container, &vbmap, iova, size);
+        ret = vfio_container_query_dirty_bitmap(container, &vbmap, iova, size);
     }
 
     if (ret) {
@@ -1210,8 +1215,7 @@ int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
     dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
                                                          vbmap.pages);
 
-    trace_vfio_get_dirty_bitmap(container->fd, iova, size, vbmap.size,
-                                ram_addr, dirty_pages);
+    trace_vfio_get_dirty_bitmap(iova, size, vbmap.size, ram_addr, dirty_pages);
 out:
     g_free(vbmap.bitmap);
 
@@ -1521,3 +1525,16 @@ retry:
 
     return info;
 }
+
+static const TypeInfo vfio_iommu_backend_ops_type_info = {
+    .name = TYPE_VFIO_IOMMU_BACKEND_OPS,
+    .parent = TYPE_OBJECT,
+    .abstract = true,
+    .class_size = sizeof(VFIOIOMMUBackendOpsClass),
+};
+
+static void vfio_iommu_backend_ops_register_types(void)
+{
+    type_register_static(&vfio_iommu_backend_ops_type_info);
+}
+type_init(vfio_iommu_backend_ops_register_types);
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
new file mode 100644
index 0000000000..4590568442
--- /dev/null
+++ b/hw/vfio/container-base.c
@@ -0,0 +1,146 @@
+/*
+ * VFIO BASE CONTAINER
+ *
+ * Copyright (C) 2023 Intel Corporation.
+ * Copyright Red Hat, Inc. 2023
+ *
+ * Authors: Yi Liu <yi.l.liu@intel.com>
+ *          Eric Auger <eric.auger@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "hw/vfio/vfio-container-base.h"
+
+VFIODevice *vfio_container_dev_iter_next(VFIOContainer *container,
+                                 VFIODevice *curr)
+{
+    if (!container->ops->dev_iter_next) {
+        return NULL;
+    }
+
+    return container->ops->dev_iter_next(container, curr);
+}
+
+int vfio_container_dma_map(VFIOContainer *container,
+                           hwaddr iova, ram_addr_t size,
+                           void *vaddr, bool readonly)
+{
+    if (!container->ops->dma_map) {
+        return -EINVAL;
+    }
+
+    return container->ops->dma_map(container, iova, size, vaddr, readonly);
+}
+
+int vfio_container_dma_unmap(VFIOContainer *container,
+                             hwaddr iova, ram_addr_t size,
+                             IOMMUTLBEntry *iotlb)
+{
+    if (!container->ops->dma_unmap) {
+        return -EINVAL;
+    }
+
+    return container->ops->dma_unmap(container, iova, size, iotlb);
+}
+
+int vfio_container_set_dirty_page_tracking(VFIOContainer *container,
+                                            bool start)
+{
+    if (!container->ops->set_dirty_page_tracking) {
+        return -EINVAL;
+    }
+
+    return container->ops->set_dirty_page_tracking(container, start);
+}
+
+int vfio_container_query_dirty_bitmap(VFIOContainer *container,
+                                      VFIOBitmap *vbmap,
+                                      hwaddr iova, hwaddr size)
+{
+    if (!container->ops->query_dirty_bitmap) {
+        return -EINVAL;
+    }
+
+    return container->ops->query_dirty_bitmap(container, vbmap, iova, size);
+}
+
+int vfio_container_add_section_window(VFIOContainer *container,
+                                      MemoryRegionSection *section,
+                                      Error **errp)
+{
+    if (!container->ops->add_window) {
+        return 0;
+    }
+
+    return container->ops->add_window(container, section, errp);
+}
+
+void vfio_container_del_section_window(VFIOContainer *container,
+                                       MemoryRegionSection *section)
+{
+    if (!container->ops->del_window) {
+        return;
+    }
+
+    return container->ops->del_window(container, section);
+}
+
+void vfio_container_init(VFIOContainer *container,
+                         VFIOAddressSpace *space,
+                         struct VFIOIOMMUBackendOpsClass *ops)
+{
+    container->ops = ops;
+    container->space = space;
+    container->error = NULL;
+    container->dirty_pages_supported = false;
+    container->dma_max_mappings = 0;
+    QLIST_INIT(&container->giommu_list);
+    QLIST_INIT(&container->hostwin_list);
+    QLIST_INIT(&container->vrdl_list);
+}
+
+void vfio_container_destroy(VFIOContainer *container)
+{
+    VFIORamDiscardListener *vrdl, *vrdl_tmp;
+    VFIOGuestIOMMU *giommu, *tmp;
+    VFIOHostDMAWindow *hostwin, *next;
+
+    QLIST_SAFE_REMOVE(container, next);
+
+    QLIST_FOREACH_SAFE(vrdl, &container->vrdl_list, next, vrdl_tmp) {
+        RamDiscardManager *rdm;
+
+        rdm = memory_region_get_ram_discard_manager(vrdl->mr);
+        ram_discard_manager_unregister_listener(rdm, &vrdl->listener);
+        QLIST_REMOVE(vrdl, next);
+        g_free(vrdl);
+    }
+
+    QLIST_FOREACH_SAFE(giommu, &container->giommu_list, giommu_next, tmp) {
+        memory_region_unregister_iommu_notifier(
+                MEMORY_REGION(giommu->iommu_mr), &giommu->n);
+        QLIST_REMOVE(giommu, giommu_next);
+        g_free(giommu);
+    }
+
+    QLIST_FOREACH_SAFE(hostwin, &container->hostwin_list, hostwin_next,
+                       next) {
+        QLIST_REMOVE(hostwin, hostwin_next);
+        g_free(hostwin);
+    }
+}
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 5bfb057007..f45a2f6e66 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -42,7 +42,8 @@
 VFIOGroupList vfio_group_list =
     QLIST_HEAD_INITIALIZER(vfio_group_list);
 
-static int vfio_ram_block_discard_disable(VFIOContainer *container, bool state)
+static int vfio_ram_block_discard_disable(VFIOLegacyContainer *container,
+                                          bool state)
 {
     switch (container->iommu_type) {
     case VFIO_TYPE1v2_IOMMU:
@@ -65,11 +66,18 @@ static int vfio_ram_block_discard_disable(VFIOContainer *container, bool state)
     }
 }
 
-VFIODevice *vfio_container_dev_iter_next(VFIOContainer *container,
-                                         VFIODevice *curr)
+static VFIODevice *vfio_legacy_dev_iter_next(VFIOContainer *bcontainer,
+                                             VFIODevice *curr)
 {
     VFIOGroup *group;
 
+    assert(object_class_dynamic_cast(OBJECT_CLASS(bcontainer->ops),
+                                     TYPE_VFIO_IOMMU_BACKEND_LEGACY_OPS));
+
+    VFIOLegacyContainer *container = container_of(bcontainer,
+                                                  VFIOLegacyContainer,
+                                                  bcontainer);
+
     if (!curr) {
         group = QLIST_FIRST(&container->group_list);
     } else {
@@ -85,10 +93,11 @@ VFIODevice *vfio_container_dev_iter_next(VFIOContainer *container,
     return QLIST_FIRST(&group->device_list);
 }
 
-static int vfio_dma_unmap_bitmap(VFIOContainer *container,
+static int vfio_dma_unmap_bitmap(VFIOLegacyContainer *container,
                                  hwaddr iova, ram_addr_t size,
                                  IOMMUTLBEntry *iotlb)
 {
+    VFIOContainer *bcontainer = &container->bcontainer;
     struct vfio_iommu_type1_dma_unmap *unmap;
     struct vfio_bitmap *bitmap;
     VFIOBitmap vbmap;
@@ -116,7 +125,7 @@ static int vfio_dma_unmap_bitmap(VFIOContainer *container,
     bitmap->size = vbmap.size;
     bitmap->data = (__u64 *)vbmap.bitmap;
 
-    if (vbmap.size > container->max_dirty_bitmap_size) {
+    if (vbmap.size > bcontainer->max_dirty_bitmap_size) {
         error_report("UNMAP: Size of bitmap too big 0x%"PRIx64, vbmap.size);
         ret = -E2BIG;
         goto unmap_exit;
@@ -140,9 +149,13 @@ unmap_exit:
 /*
  * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
  */
-int vfio_dma_unmap(VFIOContainer *container, hwaddr iova,
-                   ram_addr_t size, IOMMUTLBEntry *iotlb)
+static int vfio_legacy_dma_unmap(VFIOContainer *bcontainer, hwaddr iova,
+                          ram_addr_t size, IOMMUTLBEntry *iotlb)
 {
+    VFIOLegacyContainer *container = container_of(bcontainer,
+                                                  VFIOLegacyContainer,
+                                                  bcontainer);
+
     struct vfio_iommu_type1_dma_unmap unmap = {
         .argsz = sizeof(unmap),
         .flags = 0,
@@ -152,9 +165,9 @@ int vfio_dma_unmap(VFIOContainer *container, hwaddr iova,
     bool need_dirty_sync = false;
     int ret;
 
-    if (iotlb && vfio_devices_all_running_and_mig_active(container)) {
-        if (!vfio_devices_all_device_dirty_tracking(container) &&
-            container->dirty_pages_supported) {
+    if (iotlb && vfio_devices_all_running_and_mig_active(bcontainer)) {
+        if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
+            bcontainer->dirty_pages_supported) {
             return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
         }
 
@@ -176,8 +189,8 @@ int vfio_dma_unmap(VFIOContainer *container, hwaddr iova,
          */
         if (errno == EINVAL && unmap.size && !(unmap.iova + unmap.size) &&
             container->iommu_type == VFIO_TYPE1v2_IOMMU) {
-            trace_vfio_dma_unmap_overflow_workaround();
-            unmap.size -= 1ULL << ctz64(container->pgsizes);
+            trace_vfio_legacy_dma_unmap_overflow_workaround();
+            unmap.size -= 1ULL << ctz64(bcontainer->pgsizes);
             continue;
         }
         error_report("VFIO_UNMAP_DMA failed: %s", strerror(errno));
@@ -185,7 +198,7 @@ int vfio_dma_unmap(VFIOContainer *container, hwaddr iova,
     }
 
     if (need_dirty_sync) {
-        ret = vfio_get_dirty_bitmap(container, iova, size,
+        ret = vfio_get_dirty_bitmap(bcontainer, iova, size,
                                     iotlb->translated_addr);
         if (ret) {
             return ret;
@@ -195,9 +208,13 @@ int vfio_dma_unmap(VFIOContainer *container, hwaddr iova,
     return 0;
 }
 
-int vfio_dma_map(VFIOContainer *container, hwaddr iova,
-                 ram_addr_t size, void *vaddr, bool readonly)
+static int vfio_legacy_dma_map(VFIOContainer *bcontainer, hwaddr iova,
+                               ram_addr_t size, void *vaddr, bool readonly)
 {
+    VFIOLegacyContainer *container = container_of(bcontainer,
+                                                  VFIOLegacyContainer,
+                                                  bcontainer);
+
     struct vfio_iommu_type1_dma_map map = {
         .argsz = sizeof(map),
         .flags = VFIO_DMA_MAP_FLAG_READ,
@@ -216,7 +233,8 @@ int vfio_dma_map(VFIOContainer *container, hwaddr iova,
      * the VGA ROM space.
      */
     if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0 ||
-        (errno == EBUSY && vfio_dma_unmap(container, iova, size, NULL) == 0 &&
+        (errno == EBUSY &&
+         vfio_legacy_dma_unmap(bcontainer, iova, size, NULL) == 0 &&
          ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0)) {
         return 0;
     }
@@ -225,14 +243,18 @@ int vfio_dma_map(VFIOContainer *container, hwaddr iova,
     return -errno;
 }
 
-int vfio_set_dirty_page_tracking(VFIOContainer *container, bool start)
+static int vfio_legacy_set_dirty_page_tracking(VFIOContainer *bcontainer,
+                                               bool start)
 {
+    VFIOLegacyContainer *container = container_of(bcontainer,
+                                                  VFIOLegacyContainer,
+                                                  bcontainer);
     int ret;
     struct vfio_iommu_type1_dirty_bitmap dirty = {
         .argsz = sizeof(dirty),
     };
 
-    if (!container->dirty_pages_supported) {
+    if (!bcontainer->dirty_pages_supported) {
         return 0;
     }
 
@@ -252,9 +274,13 @@ int vfio_set_dirty_page_tracking(VFIOContainer *container, bool start)
     return ret;
 }
 
-int vfio_query_dirty_bitmap(VFIOContainer *container, VFIOBitmap *vbmap,
-                            hwaddr iova, hwaddr size)
+static int vfio_legacy_query_dirty_bitmap(VFIOContainer *bcontainer,
+                                          VFIOBitmap *vbmap,
+                                          hwaddr iova, hwaddr size)
 {
+    VFIOLegacyContainer *container = container_of(bcontainer,
+                                                  VFIOLegacyContainer,
+                                                  bcontainer);
     struct vfio_iommu_type1_dirty_bitmap *dbitmap;
     struct vfio_iommu_type1_dirty_bitmap_get *range;
     int ret;
@@ -289,18 +315,24 @@ int vfio_query_dirty_bitmap(VFIOContainer *container, VFIOBitmap *vbmap,
     return ret;
 }
 
-static void vfio_listener_release(VFIOContainer *container)
+static void vfio_listener_release(VFIOLegacyContainer *container)
 {
-    memory_listener_unregister(&container->listener);
+    VFIOContainer *bcontainer = &container->bcontainer;
+
+    memory_listener_unregister(&bcontainer->listener);
     if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
         memory_listener_unregister(&container->prereg_listener);
     }
 }
 
-int vfio_container_add_section_window(VFIOContainer *container,
-                                      MemoryRegionSection *section,
-                                      Error **errp)
+static int
+vfio_legacy_add_section_window(VFIOContainer *bcontainer,
+                               MemoryRegionSection *section,
+                               Error **errp)
 {
+    VFIOLegacyContainer *container = container_of(bcontainer,
+                                                  VFIOLegacyContainer,
+                                                  bcontainer);
     VFIOHostDMAWindow *hostwin;
     hwaddr pgsize = 0;
     int ret;
@@ -310,7 +342,7 @@ int vfio_container_add_section_window(VFIOContainer *container,
     }
 
     /* For now intersections are not allowed, we may relax this later */
-    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
+    QLIST_FOREACH(hostwin, &bcontainer->hostwin_list, hostwin_next) {
         if (ranges_overlap(hostwin->min_iova,
                            hostwin->max_iova - hostwin->min_iova + 1,
                            section->offset_within_address_space,
@@ -332,7 +364,7 @@ int vfio_container_add_section_window(VFIOContainer *container,
         return ret;
     }
 
-    vfio_host_win_add(container, section->offset_within_address_space,
+    vfio_host_win_add(bcontainer, section->offset_within_address_space,
                       section->offset_within_address_space +
                       int128_get64(section->size) - 1, pgsize);
 #ifdef CONFIG_KVM
@@ -365,16 +397,21 @@ int vfio_container_add_section_window(VFIOContainer *container,
     return 0;
 }
 
-void vfio_container_del_section_window(VFIOContainer *container,
-                                       MemoryRegionSection *section)
+static void
+vfio_legacy_del_section_window(VFIOContainer *bcontainer,
+                               MemoryRegionSection *section)
 {
+    VFIOLegacyContainer *container = container_of(bcontainer,
+                                                  VFIOLegacyContainer,
+                                                  bcontainer);
+
     if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
         return;
     }
 
     vfio_spapr_remove_window(container,
                              section->offset_within_address_space);
-    if (vfio_host_win_del(container,
+    if (vfio_host_win_del(bcontainer,
                           section->offset_within_address_space,
                           section->offset_within_address_space +
                           int128_get64(section->size) - 1) < 0) {
@@ -433,7 +470,7 @@ static void vfio_kvm_device_del_group(VFIOGroup *group)
 /*
  * vfio_get_iommu_type - selects the richest iommu_type (v2 first)
  */
-static int vfio_get_iommu_type(VFIOContainer *container,
+static int vfio_get_iommu_type(VFIOLegacyContainer *container,
                                Error **errp)
 {
     int iommu_types[] = { VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
@@ -449,7 +486,7 @@ static int vfio_get_iommu_type(VFIOContainer *container,
     return -EINVAL;
 }
 
-static int vfio_init_container(VFIOContainer *container, int group_fd,
+static int vfio_init_container(VFIOLegacyContainer *container, int group_fd,
                                Error **errp)
 {
     int iommu_type, ret;
@@ -484,7 +521,7 @@ static int vfio_init_container(VFIOContainer *container, int group_fd,
     return 0;
 }
 
-static int vfio_get_iommu_info(VFIOContainer *container,
+static int vfio_get_iommu_info(VFIOLegacyContainer *container,
                                struct vfio_iommu_type1_info **info)
 {
 
@@ -528,11 +565,12 @@ vfio_get_iommu_info_cap(struct vfio_iommu_type1_info *info, uint16_t id)
     return NULL;
 }
 
-static void vfio_get_iommu_info_migration(VFIOContainer *container,
-                                         struct vfio_iommu_type1_info *info)
+static void vfio_get_iommu_info_migration(VFIOLegacyContainer *container,
+                                          struct vfio_iommu_type1_info *info)
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_iommu_type1_info_cap_migration *cap_mig;
+    VFIOContainer *bcontainer = &container->bcontainer;
 
     hdr = vfio_get_iommu_info_cap(info, VFIO_IOMMU_TYPE1_INFO_CAP_MIGRATION);
     if (!hdr) {
@@ -547,16 +585,19 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
      * qemu_real_host_page_size to mark those dirty.
      */
     if (cap_mig->pgsize_bitmap & qemu_real_host_page_size()) {
-        container->dirty_pages_supported = true;
-        container->max_dirty_bitmap_size = cap_mig->max_dirty_bitmap_size;
-        container->dirty_pgsizes = cap_mig->pgsize_bitmap;
+        bcontainer->dirty_pages_supported = true;
+        bcontainer->max_dirty_bitmap_size = cap_mig->max_dirty_bitmap_size;
+        bcontainer->dirty_pgsizes = cap_mig->pgsize_bitmap;
     }
 }
 
 static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
                                   Error **errp)
 {
-    VFIOContainer *container;
+    VFIOIOMMUBackendOpsClass *ops = VFIO_IOMMU_BACKEND_OPS_CLASS(
+        object_class_by_name(TYPE_VFIO_IOMMU_BACKEND_LEGACY_OPS));
+    VFIOContainer *bcontainer;
+    VFIOLegacyContainer *container;
     int ret, fd;
     VFIOAddressSpace *space;
 
@@ -593,7 +634,8 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
      * details once we know which type of IOMMU we are using.
      */
 
-    QLIST_FOREACH(container, &space->containers, next) {
+    QLIST_FOREACH(bcontainer, &space->containers, next) {
+        container = container_of(bcontainer, VFIOLegacyContainer, bcontainer);
         if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
             ret = vfio_ram_block_discard_disable(container, true);
             if (ret) {
@@ -629,14 +671,9 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     }
 
     container = g_malloc0(sizeof(*container));
-    container->space = space;
     container->fd = fd;
-    container->error = NULL;
-    container->dirty_pages_supported = false;
-    container->dma_max_mappings = 0;
-    QLIST_INIT(&container->giommu_list);
-    QLIST_INIT(&container->hostwin_list);
-    QLIST_INIT(&container->vrdl_list);
+    bcontainer = &container->bcontainer;
+    vfio_container_init(bcontainer, space, ops);
 
     ret = vfio_init_container(container, group->fd, errp);
     if (ret) {
@@ -662,13 +699,13 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         }
 
         if (info->flags & VFIO_IOMMU_INFO_PGSIZES) {
-            container->pgsizes = info->iova_pgsizes;
+            bcontainer->pgsizes = info->iova_pgsizes;
         } else {
-            container->pgsizes = qemu_real_host_page_size();
+            bcontainer->pgsizes = qemu_real_host_page_size();
         }
 
-        if (!vfio_get_info_dma_avail(info, &container->dma_max_mappings)) {
-            container->dma_max_mappings = 65535;
+        if (!vfio_get_info_dma_avail(info, &bcontainer->dma_max_mappings)) {
+            bcontainer->dma_max_mappings = 65535;
         }
         vfio_get_iommu_info_migration(container, info);
         g_free(info);
@@ -678,7 +715,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
          * information to get the actual window extent rather than assume
          * a 64-bit IOVA address space.
          */
-        vfio_host_win_add(container, 0, (hwaddr)-1, container->pgsizes);
+        vfio_host_win_add(bcontainer, 0, (hwaddr)-1, bcontainer->pgsizes);
 
         break;
     }
@@ -705,10 +742,10 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
 
             memory_listener_register(&container->prereg_listener,
                                      &address_space_memory);
-            if (container->error) {
+            if (bcontainer->error) {
                 memory_listener_unregister(&container->prereg_listener);
                 ret = -1;
-                error_propagate_prepend(errp, container->error,
+                error_propagate_prepend(errp, bcontainer->error,
                     "RAM memory listener initialization failed: ");
                 goto enable_discards_exit;
             }
@@ -727,7 +764,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         }
 
         if (v2) {
-            container->pgsizes = info.ddw.pgsizes;
+            bcontainer->pgsizes = info.ddw.pgsizes;
             /*
              * There is a default window in just created container.
              * To make region_add/del simpler, we better remove this
@@ -742,8 +779,8 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
             }
         } else {
             /* The default table uses 4K pages */
-            container->pgsizes = 0x1000;
-            vfio_host_win_add(container, info.dma32_window_start,
+            bcontainer->pgsizes = 0x1000;
+            vfio_host_win_add(bcontainer, info.dma32_window_start,
                               info.dma32_window_start +
                               info.dma32_window_size - 1,
                               0x1000);
@@ -754,28 +791,28 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     vfio_kvm_device_add_group(group);
 
     QLIST_INIT(&container->group_list);
-    QLIST_INSERT_HEAD(&space->containers, container, next);
+    QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
 
     group->container = container;
     QLIST_INSERT_HEAD(&container->group_list, group, container_next);
 
-    container->listener = vfio_memory_listener;
+    bcontainer->listener = vfio_memory_listener;
 
-    memory_listener_register(&container->listener, container->space->as);
+    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
 
-    if (container->error) {
+    if (bcontainer->error) {
         ret = -1;
-        error_propagate_prepend(errp, container->error,
+        error_propagate_prepend(errp, bcontainer->error,
             "memory listener initialization failed: ");
         goto listener_release_exit;
     }
 
-    container->initialized = true;
+    bcontainer->initialized = true;
 
     return 0;
 listener_release_exit:
     QLIST_REMOVE(group, container_next);
-    QLIST_REMOVE(container, next);
+    QLIST_REMOVE(bcontainer, next);
     vfio_kvm_device_del_group(group);
     vfio_listener_release(container);
 
@@ -796,7 +833,8 @@ put_space_exit:
 
 static void vfio_disconnect_container(VFIOGroup *group)
 {
-    VFIOContainer *container = group->container;
+    VFIOLegacyContainer *container = group->container;
+    VFIOContainer *bcontainer = &container->bcontainer;
 
     QLIST_REMOVE(group, container_next);
     group->container = NULL;
@@ -816,25 +854,9 @@ static void vfio_disconnect_container(VFIOGroup *group)
     }
 
     if (QLIST_EMPTY(&container->group_list)) {
-        VFIOAddressSpace *space = container->space;
-        VFIOGuestIOMMU *giommu, *tmp;
-        VFIOHostDMAWindow *hostwin, *next;
-
-        QLIST_REMOVE(container, next);
-
-        QLIST_FOREACH_SAFE(giommu, &container->giommu_list, giommu_next, tmp) {
-            memory_region_unregister_iommu_notifier(
-                    MEMORY_REGION(giommu->iommu_mr), &giommu->n);
-            QLIST_REMOVE(giommu, giommu_next);
-            g_free(giommu);
-        }
-
-        QLIST_FOREACH_SAFE(hostwin, &container->hostwin_list, hostwin_next,
-                           next) {
-            QLIST_REMOVE(hostwin, hostwin_next);
-            g_free(hostwin);
-        }
+        VFIOAddressSpace *space = bcontainer->space;
 
+        vfio_container_destroy(bcontainer);
         trace_vfio_disconnect_container(container->fd);
         close(container->fd);
         g_free(container);
@@ -846,13 +868,15 @@ static void vfio_disconnect_container(VFIOGroup *group)
 VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
 {
     VFIOGroup *group;
+    VFIOContainer *bcontainer;
     char path[32];
     struct vfio_group_status status = { .argsz = sizeof(status) };
 
     QLIST_FOREACH(group, &vfio_group_list, next) {
         if (group->groupid == groupid) {
             /* Found it.  Now is it already in the right context? */
-            if (group->container->space->as == as) {
+            bcontainer = &group->container->bcontainer;
+            if (bcontainer->space->as == as) {
                 return group;
             } else {
                 error_setg(errp, "group %d used in multiple address spaces",
@@ -996,7 +1020,7 @@ void vfio_put_base_device(VFIODevice *vbasedev)
 /*
  * Interfaces for IBM EEH (Enhanced Error Handling)
  */
-static bool vfio_eeh_container_ok(VFIOContainer *container)
+static bool vfio_eeh_container_ok(VFIOLegacyContainer *container)
 {
     /*
      * As of 2016-03-04 (linux-4.5) the host kernel EEH/VFIO
@@ -1024,7 +1048,7 @@ static bool vfio_eeh_container_ok(VFIOContainer *container)
     return true;
 }
 
-static int vfio_eeh_container_op(VFIOContainer *container, uint32_t op)
+static int vfio_eeh_container_op(VFIOLegacyContainer *container, uint32_t op)
 {
     struct vfio_eeh_pe_op pe_op = {
         .argsz = sizeof(pe_op),
@@ -1047,19 +1071,21 @@ static int vfio_eeh_container_op(VFIOContainer *container, uint32_t op)
     return ret;
 }
 
-static VFIOContainer *vfio_eeh_as_container(AddressSpace *as)
+static VFIOLegacyContainer *vfio_eeh_as_container(AddressSpace *as)
 {
     VFIOAddressSpace *space = vfio_get_address_space(as);
-    VFIOContainer *container = NULL;
+    VFIOLegacyContainer *container = NULL;
+    VFIOContainer *bcontainer = NULL;
 
     if (QLIST_EMPTY(&space->containers)) {
         /* No containers to act on */
         goto out;
     }
 
-    container = QLIST_FIRST(&space->containers);
+    bcontainer = QLIST_FIRST(&space->containers);
+    container = container_of(bcontainer, VFIOLegacyContainer, bcontainer);
 
-    if (QLIST_NEXT(container, next)) {
+    if (QLIST_NEXT(bcontainer, next)) {
         /*
          * We don't yet have logic to synchronize EEH state across
          * multiple containers
@@ -1075,17 +1101,44 @@ out:
 
 bool vfio_eeh_as_ok(AddressSpace *as)
 {
-    VFIOContainer *container = vfio_eeh_as_container(as);
+    VFIOLegacyContainer *container = vfio_eeh_as_container(as);
 
     return (container != NULL) && vfio_eeh_container_ok(container);
 }
 
 int vfio_eeh_as_op(AddressSpace *as, uint32_t op)
 {
-    VFIOContainer *container = vfio_eeh_as_container(as);
+    VFIOLegacyContainer *container = vfio_eeh_as_container(as);
 
     if (!container) {
         return -ENODEV;
     }
     return vfio_eeh_container_op(container, op);
 }
+
+static void vfio_iommu_backend_legacy_ops_class_init(ObjectClass *oc,
+                                                     void *data) {
+    VFIOIOMMUBackendOpsClass *ops = VFIO_IOMMU_BACKEND_OPS_CLASS(oc);
+
+    ops->dev_iter_next = vfio_legacy_dev_iter_next;
+    ops->dma_map = vfio_legacy_dma_map;
+    ops->dma_unmap = vfio_legacy_dma_unmap;
+    ops->set_dirty_page_tracking = vfio_legacy_set_dirty_page_tracking;
+    ops->query_dirty_bitmap = vfio_legacy_query_dirty_bitmap;
+    ops->add_window = vfio_legacy_add_section_window;
+    ops->del_window = vfio_legacy_del_section_window;
+}
+
+static const TypeInfo vfio_iommu_backend_legacy_ops_type = {
+    .name = TYPE_VFIO_IOMMU_BACKEND_LEGACY_OPS,
+
+    .parent = TYPE_VFIO_IOMMU_BACKEND_OPS,
+    .class_init = vfio_iommu_backend_legacy_ops_class_init,
+    .abstract = true,
+};
+static void vfio_iommu_backend_legacy_ops_register_types(void)
+{
+    type_register_static(&vfio_iommu_backend_legacy_ops_type);
+}
+type_init(vfio_iommu_backend_legacy_ops_register_types);
+
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 7937dab078..fd0dfd198a 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -2,6 +2,7 @@ vfio_ss = ss.source_set()
 vfio_ss.add(files(
   'helpers.c',
   'as.c',
+  'container-base.c',
   'container.c',
   'spapr.c',
   'migration.c',
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 9ec1e95f6d..7647e7d492 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -39,8 +39,8 @@ static void *vfio_prereg_gpa_to_vaddr(MemoryRegionSection *section, hwaddr gpa)
 static void vfio_prereg_listener_region_add(MemoryListener *listener,
                                             MemoryRegionSection *section)
 {
-    VFIOContainer *container = container_of(listener, VFIOContainer,
-                                            prereg_listener);
+    VFIOLegacyContainer *container = container_of(listener, VFIOLegacyContainer,
+                                                  prereg_listener);
     const hwaddr gpa = section->offset_within_address_space;
     hwaddr end;
     int ret;
@@ -83,9 +83,9 @@ static void vfio_prereg_listener_region_add(MemoryListener *listener,
          * can gracefully fail.  Runtime, there's not much we can do other
          * than throw a hardware error.
          */
-        if (!container->initialized) {
-            if (!container->error) {
-                error_setg_errno(&container->error, -ret,
+        if (!container->bcontainer.initialized) {
+            if (!container->bcontainer.error) {
+                error_setg_errno(&container->bcontainer.error, -ret,
                                  "Memory registering failed");
             }
         } else {
@@ -97,8 +97,8 @@ static void vfio_prereg_listener_region_add(MemoryListener *listener,
 static void vfio_prereg_listener_region_del(MemoryListener *listener,
                                             MemoryRegionSection *section)
 {
-    VFIOContainer *container = container_of(listener, VFIOContainer,
-                                            prereg_listener);
+    VFIOLegacyContainer *container = container_of(listener, VFIOLegacyContainer,
+                                                  prereg_listener);
     const hwaddr gpa = section->offset_within_address_space;
     hwaddr end;
     int ret;
@@ -141,7 +141,7 @@ const MemoryListener vfio_prereg_listener = {
     .region_del = vfio_prereg_listener_region_del,
 };
 
-int vfio_spapr_create_window(VFIOContainer *container,
+int vfio_spapr_create_window(VFIOLegacyContainer *container,
                              MemoryRegionSection *section,
                              hwaddr *pgsize)
 {
@@ -159,13 +159,13 @@ int vfio_spapr_create_window(VFIOContainer *container,
     if (pagesize > rampagesize) {
         pagesize = rampagesize;
     }
-    pgmask = container->pgsizes & (pagesize | (pagesize - 1));
+    pgmask = container->bcontainer.pgsizes & (pagesize | (pagesize - 1));
     pagesize = pgmask ? (1ULL << (63 - clz64(pgmask))) : 0;
     if (!pagesize) {
         error_report("Host doesn't support page size 0x%"PRIx64
                      ", the supported mask is 0x%lx",
                      memory_region_iommu_get_min_page_size(iommu_mr),
-                     container->pgsizes);
+                     container->bcontainer.pgsizes);
         return -EINVAL;
     }
 
@@ -233,7 +233,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
     return 0;
 }
 
-int vfio_spapr_remove_window(VFIOContainer *container,
+int vfio_spapr_remove_window(VFIOLegacyContainer *container,
                              hwaddr offset_within_address_space)
 {
     struct vfio_iommu_spapr_tce_remove remove = {
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index ee7509e68e..3f1a7e1c3e 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -119,8 +119,8 @@ vfio_region_unmap(const char *name, unsigned long offset, unsigned long end) "Re
 vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Device %s region %d: %d sparse mmap entries"
 vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
 vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%08x"
-vfio_dma_unmap_overflow_workaround(void) ""
-vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "container fd=%d, iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
+vfio_legacy_dma_unmap_overflow_workaround(void) ""
+vfio_get_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
 vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
 
 # platform.c
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index bb7f9fe9c4..cd11ffa01b 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -30,6 +30,7 @@
 #include <linux/vfio.h>
 #endif
 #include "sysemu/sysemu.h"
+#include "hw/vfio/vfio-container-base.h"
 
 #define VFIO_MSG_PREFIX "vfio %s: "
 
@@ -74,58 +75,15 @@ typedef struct VFIOMigration {
     bool initial_data_sent;
 } VFIOMigration;
 
-typedef struct VFIOAddressSpace {
-    AddressSpace *as;
-    QLIST_HEAD(, VFIOContainer) containers;
-    QLIST_ENTRY(VFIOAddressSpace) list;
-} VFIOAddressSpace;
-
 struct VFIOGroup;
 
-typedef struct VFIOContainer {
-    VFIOAddressSpace *space;
+typedef struct VFIOLegacyContainer {
+    VFIOContainer bcontainer;
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
-    MemoryListener listener;
     MemoryListener prereg_listener;
     unsigned iommu_type;
-    Error *error;
-    bool initialized;
-    bool dirty_pages_supported;
-    uint64_t dirty_pgsizes;
-    uint64_t max_dirty_bitmap_size;
-    unsigned long pgsizes;
-    unsigned int dma_max_mappings;
-    QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
-    QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     QLIST_HEAD(, VFIOGroup) group_list;
-    QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
-    QLIST_ENTRY(VFIOContainer) next;
-} VFIOContainer;
-
-typedef struct VFIOGuestIOMMU {
-    VFIOContainer *container;
-    IOMMUMemoryRegion *iommu_mr;
-    hwaddr iommu_offset;
-    IOMMUNotifier n;
-    QLIST_ENTRY(VFIOGuestIOMMU) giommu_next;
-} VFIOGuestIOMMU;
-
-typedef struct VFIORamDiscardListener {
-    VFIOContainer *container;
-    MemoryRegion *mr;
-    hwaddr offset_within_address_space;
-    hwaddr size;
-    uint64_t granularity;
-    RamDiscardListener listener;
-    QLIST_ENTRY(VFIORamDiscardListener) next;
-} VFIORamDiscardListener;
-
-typedef struct VFIOHostDMAWindow {
-    hwaddr min_iova;
-    hwaddr max_iova;
-    uint64_t iova_pgsizes;
-    QLIST_ENTRY(VFIOHostDMAWindow) hostwin_next;
-} VFIOHostDMAWindow;
+} VFIOLegacyContainer;
 
 typedef struct VFIODeviceOps VFIODeviceOps;
 
@@ -165,7 +123,7 @@ struct VFIODeviceOps {
 typedef struct VFIOGroup {
     int fd;
     int groupid;
-    VFIOContainer *container;
+    VFIOLegacyContainer *container;
     QLIST_HEAD(, VFIODevice) device_list;
     QLIST_ENTRY(VFIOGroup) next;
     QLIST_ENTRY(VFIOGroup) container_next;
@@ -198,37 +156,13 @@ typedef struct VFIODisplay {
     } dmabuf;
 } VFIODisplay;
 
-typedef struct {
-    unsigned long *bitmap;
-    hwaddr size;
-    hwaddr pages;
-} VFIOBitmap;
-
-void vfio_host_win_add(VFIOContainer *container,
+void vfio_host_win_add(VFIOContainer *bcontainer,
                        hwaddr min_iova, hwaddr max_iova,
                        uint64_t iova_pgsizes);
-int vfio_host_win_del(VFIOContainer *container, hwaddr min_iova,
+int vfio_host_win_del(VFIOContainer *bcontainer, hwaddr min_iova,
                       hwaddr max_iova);
 VFIOAddressSpace *vfio_get_address_space(AddressSpace *as);
 void vfio_put_address_space(VFIOAddressSpace *space);
-bool vfio_devices_all_running_and_saving(VFIOContainer *container);
-
-/* container->fd */
-VFIODevice *vfio_container_dev_iter_next(VFIOContainer *container,
-                                         VFIODevice *curr);
-int vfio_dma_unmap(VFIOContainer *container, hwaddr iova,
-                   ram_addr_t size, IOMMUTLBEntry *iotlb);
-int vfio_dma_map(VFIOContainer *container, hwaddr iova,
-                 ram_addr_t size, void *vaddr, bool readonly);
-int vfio_set_dirty_page_tracking(VFIOContainer *container, bool start);
-int vfio_query_dirty_bitmap(VFIOContainer *container, VFIOBitmap *vbmap,
-                            hwaddr iova, hwaddr size);
-
-int vfio_container_add_section_window(VFIOContainer *container,
-                                      MemoryRegionSection *section,
-                                      Error **errp);
-void vfio_container_del_section_window(VFIOContainer *container,
-                                       MemoryRegionSection *section);
 
 void vfio_put_base_device(VFIODevice *vbasedev);
 void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
@@ -287,10 +221,10 @@ vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id);
 #endif
 extern const MemoryListener vfio_prereg_listener;
 
-int vfio_spapr_create_window(VFIOContainer *container,
+int vfio_spapr_create_window(VFIOLegacyContainer *container,
                              MemoryRegionSection *section,
                              hwaddr *pgsize);
-int vfio_spapr_remove_window(VFIOContainer *container,
+int vfio_spapr_remove_window(VFIOLegacyContainer *container,
                              hwaddr offset_within_address_space);
 
 bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
new file mode 100644
index 0000000000..74ccb7255f
--- /dev/null
+++ b/include/hw/vfio/vfio-container-base.h
@@ -0,0 +1,152 @@
+/*
+ * VFIO BASE CONTAINER
+ *
+ * Copyright (C) 2023 Intel Corporation.
+ * Copyright Red Hat, Inc. 2023
+ *
+ * Authors: Yi Liu <yi.l.liu@intel.com>
+ *          Eric Auger <eric.auger@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_VFIO_VFIO_BASE_CONTAINER_H
+#define HW_VFIO_VFIO_BASE_CONTAINER_H
+
+#include "exec/memory.h"
+#ifndef CONFIG_USER_ONLY
+#include "exec/hwaddr.h"
+#endif
+
+typedef struct VFIOContainer VFIOContainer;
+
+typedef struct VFIOAddressSpace {
+    AddressSpace *as;
+    QLIST_HEAD(, VFIOContainer) containers;
+    QLIST_ENTRY(VFIOAddressSpace) list;
+} VFIOAddressSpace;
+
+typedef struct VFIOGuestIOMMU {
+    VFIOContainer *container;
+    IOMMUMemoryRegion *iommu_mr;
+    hwaddr iommu_offset;
+    IOMMUNotifier n;
+    QLIST_ENTRY(VFIOGuestIOMMU) giommu_next;
+} VFIOGuestIOMMU;
+
+typedef struct VFIORamDiscardListener {
+    VFIOContainer *container;
+    MemoryRegion *mr;
+    hwaddr offset_within_address_space;
+    hwaddr size;
+    uint64_t granularity;
+    RamDiscardListener listener;
+    QLIST_ENTRY(VFIORamDiscardListener) next;
+} VFIORamDiscardListener;
+
+typedef struct VFIOHostDMAWindow {
+    hwaddr min_iova;
+    hwaddr max_iova;
+    uint64_t iova_pgsizes;
+    QLIST_ENTRY(VFIOHostDMAWindow) hostwin_next;
+} VFIOHostDMAWindow;
+
+typedef struct {
+    unsigned long *bitmap;
+    hwaddr size;
+    hwaddr pages;
+} VFIOBitmap;
+
+typedef struct VFIODevice VFIODevice;
+typedef struct VFIOIOMMUBackendOpsClass VFIOIOMMUBackendOpsClass;
+
+/*
+ * This is the base object for vfio container backends
+ */
+struct VFIOContainer {
+    VFIOIOMMUBackendOpsClass *ops;
+    VFIOAddressSpace *space;
+    MemoryListener listener;
+    Error *error;
+    bool initialized;
+    bool dirty_pages_supported;
+    uint64_t dirty_pgsizes;
+    uint64_t max_dirty_bitmap_size;
+    unsigned long pgsizes;
+    unsigned int dma_max_mappings;
+    QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
+    QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
+    QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
+    QLIST_ENTRY(VFIOContainer) next;
+};
+
+VFIODevice *vfio_container_dev_iter_next(VFIOContainer *container,
+                                 VFIODevice *curr);
+int vfio_container_dma_map(VFIOContainer *container,
+                           hwaddr iova, ram_addr_t size,
+                           void *vaddr, bool readonly);
+int vfio_container_dma_unmap(VFIOContainer *container,
+                             hwaddr iova, ram_addr_t size,
+                             IOMMUTLBEntry *iotlb);
+bool vfio_container_devices_all_dirty_tracking(VFIOContainer *container);
+int vfio_container_set_dirty_page_tracking(VFIOContainer *container,
+                                            bool start);
+int vfio_container_query_dirty_bitmap(VFIOContainer *container,
+                                      VFIOBitmap *vbmap,
+                                      hwaddr iova, hwaddr size);
+int vfio_container_add_section_window(VFIOContainer *container,
+                                      MemoryRegionSection *section,
+                                      Error **errp);
+void vfio_container_del_section_window(VFIOContainer *container,
+                                       MemoryRegionSection *section);
+
+void vfio_container_init(VFIOContainer *container,
+                         VFIOAddressSpace *space,
+                         struct VFIOIOMMUBackendOpsClass *ops);
+void vfio_container_destroy(VFIOContainer *container);
+
+#define TYPE_VFIO_IOMMU_BACKEND_LEGACY_OPS "vfio-iommu-backend-legacy-ops"
+#define TYPE_VFIO_IOMMU_BACKEND_OPS "vfio-iommu-backend-ops"
+
+DECLARE_CLASS_CHECKERS(VFIOIOMMUBackendOpsClass,
+                       VFIO_IOMMU_BACKEND_OPS, TYPE_VFIO_IOMMU_BACKEND_OPS)
+
+struct VFIOIOMMUBackendOpsClass {
+    /*< private >*/
+    ObjectClass parent_class;
+
+    /*< public >*/
+    /* required */
+    VFIODevice *(*dev_iter_next)(VFIOContainer *container, VFIODevice *curr);
+    int (*dma_map)(VFIOContainer *container,
+                   hwaddr iova, ram_addr_t size,
+                   void *vaddr, bool readonly);
+    int (*dma_unmap)(VFIOContainer *container,
+                     hwaddr iova, ram_addr_t size,
+                     IOMMUTLBEntry *iotlb);
+    /* migration feature */
+    int (*set_dirty_page_tracking)(VFIOContainer *container, bool start);
+    int (*query_dirty_bitmap)(VFIOContainer *bcontainer, VFIOBitmap *vbmap,
+                              hwaddr iova, hwaddr size);
+
+    /* SPAPR specific */
+    int (*add_window)(VFIOContainer *container,
+                      MemoryRegionSection *section,
+                      Error **errp);
+    void (*del_window)(VFIOContainer *container,
+                       MemoryRegionSection *section);
+};
+
+
+#endif /* HW_VFIO_VFIO_BASE_CONTAINER_H */
-- 
2.34.1


