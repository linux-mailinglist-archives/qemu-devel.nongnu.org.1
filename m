Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E53A7E273B
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:41:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00kN-0007GW-AF; Mon, 06 Nov 2023 09:38:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org>)
 id 1r00k1-00071a-EQ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:38:17 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org>)
 id 1r00js-00010D-7k
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:38:08 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SPDV32g43z4xkT;
 Tue,  7 Nov 2023 01:38:03 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SPDV153r5z4xkM;
 Tue,  7 Nov 2023 01:38:01 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 20/22] vfio/container: Move spapr specific init/deinit into
 spapr.c
Date: Mon,  6 Nov 2023 15:36:51 +0100
Message-ID: <20231106143653.302391-21-clg@redhat.com>
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
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |  4 +-
 hw/vfio/container.c           | 82 +++++------------------------------
 hw/vfio/spapr.c               | 81 +++++++++++++++++++++++++++++++++-
 3 files changed, 95 insertions(+), 72 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 0c3d390e8bd5e990e1ccb1c7e077bde0baa812e9..ed5a8e4754d8105ce1a41ef72168473b2d5d239f 100644
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
index 7a3f005d1b615ba0fd95ab48d9a8babf452649a5..204b244b114c465e4a62d46bef78f472e268620d 100644
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
index 9a7517c0421090b82c2dc5508b2aa9670287fbe7..00dbd7af11faa0222609a40818ba846e0411ba27 100644
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
2.41.0


