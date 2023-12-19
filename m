Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 643E1819053
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:06:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfHV-0001yC-Gp; Tue, 19 Dec 2023 13:57:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfHT-0001xs-DN
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:57:27 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfHL-0006xl-0n
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:57:27 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SvmCH4zgpz4xG8;
 Wed, 20 Dec 2023 05:57:15 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvmCC0N6Jz4wx5;
 Wed, 20 Dec 2023 05:57:10 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Yi Liu <yi.l.liu@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 03/47] vfio/container: Switch to dma_map|unmap API
Date: Tue, 19 Dec 2023 19:55:59 +0100
Message-ID: <20231219185643.725448-4-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219185643.725448-1-clg@redhat.com>
References: <20231219185643.725448-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=7/MV=H6=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: Eric Auger <eric.auger@redhat.com>

No functional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h         |  4 ---
 include/hw/vfio/vfio-container-base.h |  7 +++++
 hw/vfio/common.c                      | 45 +++++++++++++++------------
 hw/vfio/container-base.c              | 32 +++++++++++++++++++
 hw/vfio/container.c                   | 22 ++++++++-----
 hw/vfio/meson.build                   |  1 +
 hw/vfio/trace-events                  |  2 +-
 7 files changed, 81 insertions(+), 32 deletions(-)
 create mode 100644 hw/vfio/container-base.c

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 678161f2079b20aae9317d67e5a94696ea269248..24a26345e5aa6094706dcf1301eeaf44ac91840d 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -208,10 +208,6 @@ void vfio_put_address_space(VFIOAddressSpace *space);
 bool vfio_devices_all_running_and_saving(VFIOContainer *container);
 
 /* container->fd */
-int vfio_dma_unmap(VFIOContainer *container, hwaddr iova,
-                   ram_addr_t size, IOMMUTLBEntry *iotlb);
-int vfio_dma_map(VFIOContainer *container, hwaddr iova,
-                 ram_addr_t size, void *vaddr, bool readonly);
 int vfio_set_dirty_page_tracking(VFIOContainer *container, bool start);
 int vfio_query_dirty_bitmap(VFIOContainer *container, VFIOBitmap *vbmap,
                             hwaddr iova, hwaddr size);
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 1d6daaea5d54775221d36bff98590472e0cf25e2..56b033f59f13684a56824929c16d9445a6efc5ff 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -31,6 +31,13 @@ typedef struct VFIOContainerBase {
     const VFIOIOMMUOps *ops;
 } VFIOContainerBase;
 
+int vfio_container_dma_map(VFIOContainerBase *bcontainer,
+                           hwaddr iova, ram_addr_t size,
+                           void *vaddr, bool readonly);
+int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
+                             hwaddr iova, ram_addr_t size,
+                             IOMMUTLBEntry *iotlb);
+
 struct VFIOIOMMUOps {
     /* basic feature */
     int (*dma_map)(VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index e70fdf5e0cacf756fb8dcce2bfd906c65ae71684..e610771888491c8cd19883cdf91ad1589c843e27 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -292,7 +292,7 @@ static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
 static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
 {
     VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
-    VFIOContainer *container = giommu->container;
+    VFIOContainerBase *bcontainer = &giommu->container->bcontainer;
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
     void *vaddr;
     int ret;
@@ -322,21 +322,22 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
          * of vaddr will always be there, even if the memory object is
          * destroyed and its backing memory munmap-ed.
          */
-        ret = vfio_dma_map(container, iova,
-                           iotlb->addr_mask + 1, vaddr,
-                           read_only);
+        ret = vfio_container_dma_map(bcontainer, iova,
+                                     iotlb->addr_mask + 1, vaddr,
+                                     read_only);
         if (ret) {
-            error_report("vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
+            error_report("vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx", %p) = %d (%s)",
-                         container, iova,
+                         bcontainer, iova,
                          iotlb->addr_mask + 1, vaddr, ret, strerror(-ret));
         }
     } else {
-        ret = vfio_dma_unmap(container, iova, iotlb->addr_mask + 1, iotlb);
+        ret = vfio_container_dma_unmap(bcontainer, iova,
+                                       iotlb->addr_mask + 1, iotlb);
         if (ret) {
-            error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
+            error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%s)",
-                         container, iova,
+                         bcontainer, iova,
                          iotlb->addr_mask + 1, ret, strerror(-ret));
             vfio_set_migration_error(ret);
         }
@@ -355,9 +356,10 @@ static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
     int ret;
 
     /* Unmap with a single call. */
-    ret = vfio_dma_unmap(vrdl->container, iova, size , NULL);
+    ret = vfio_container_dma_unmap(&vrdl->container->bcontainer,
+                                   iova, size , NULL);
     if (ret) {
-        error_report("%s: vfio_dma_unmap() failed: %s", __func__,
+        error_report("%s: vfio_container_dma_unmap() failed: %s", __func__,
                      strerror(-ret));
     }
 }
@@ -385,8 +387,8 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
                section->offset_within_address_space;
         vaddr = memory_region_get_ram_ptr(section->mr) + start;
 
-        ret = vfio_dma_map(vrdl->container, iova, next - start,
-                           vaddr, section->readonly);
+        ret = vfio_container_dma_map(&vrdl->container->bcontainer, iova,
+                                     next - start, vaddr, section->readonly);
         if (ret) {
             /* Rollback */
             vfio_ram_discard_notify_discard(rdl, section);
@@ -684,10 +686,11 @@ static void vfio_listener_region_add(MemoryListener *listener,
         }
     }
 
-    ret = vfio_dma_map(container, iova, int128_get64(llsize),
-                       vaddr, section->readonly);
+    ret = vfio_container_dma_map(&container->bcontainer,
+                                 iova, int128_get64(llsize), vaddr,
+                                 section->readonly);
     if (ret) {
-        error_setg(&err, "vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
+        error_setg(&err, "vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
                    "0x%"HWADDR_PRIx", %p) = %d (%s)",
                    container, iova, int128_get64(llsize), vaddr, ret,
                    strerror(-ret));
@@ -784,18 +787,20 @@ static void vfio_listener_region_del(MemoryListener *listener,
         if (int128_eq(llsize, int128_2_64())) {
             /* The unmap ioctl doesn't accept a full 64-bit span. */
             llsize = int128_rshift(llsize, 1);
-            ret = vfio_dma_unmap(container, iova, int128_get64(llsize), NULL);
+            ret = vfio_container_dma_unmap(&container->bcontainer, iova,
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
+        ret = vfio_container_dma_unmap(&container->bcontainer, iova,
+                                       int128_get64(llsize), NULL);
         if (ret) {
-            error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
+            error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%s)",
                          container, iova, int128_get64(llsize), ret,
                          strerror(-ret));
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
new file mode 100644
index 0000000000000000000000000000000000000000..55d3a35fa42b66e6590da8d699e60850c88ed74d
--- /dev/null
+++ b/hw/vfio/container-base.c
@@ -0,0 +1,32 @@
+/*
+ * VFIO BASE CONTAINER
+ *
+ * Copyright (C) 2023 Intel Corporation.
+ * Copyright Red Hat, Inc. 2023
+ *
+ * Authors: Yi Liu <yi.l.liu@intel.com>
+ *          Eric Auger <eric.auger@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "hw/vfio/vfio-container-base.h"
+
+int vfio_container_dma_map(VFIOContainerBase *bcontainer,
+                           hwaddr iova, ram_addr_t size,
+                           void *vaddr, bool readonly)
+{
+    g_assert(bcontainer->ops->dma_map);
+    return bcontainer->ops->dma_map(bcontainer, iova, size, vaddr, readonly);
+}
+
+int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
+                             hwaddr iova, ram_addr_t size,
+                             IOMMUTLBEntry *iotlb)
+{
+    g_assert(bcontainer->ops->dma_unmap);
+    return bcontainer->ops->dma_unmap(bcontainer, iova, size, iotlb);
+}
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 4bc43ddfa4441dc76950203903f22e5475574a47..c04df26323bd115af67ec10f851d61bf686534c2 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -115,9 +115,11 @@ unmap_exit:
 /*
  * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
  */
-int vfio_dma_unmap(VFIOContainer *container, hwaddr iova,
-                   ram_addr_t size, IOMMUTLBEntry *iotlb)
+static int vfio_legacy_dma_unmap(VFIOContainerBase *bcontainer, hwaddr iova,
+                                 ram_addr_t size, IOMMUTLBEntry *iotlb)
 {
+    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
+                                            bcontainer);
     struct vfio_iommu_type1_dma_unmap unmap = {
         .argsz = sizeof(unmap),
         .flags = 0,
@@ -151,7 +153,7 @@ int vfio_dma_unmap(VFIOContainer *container, hwaddr iova,
          */
         if (errno == EINVAL && unmap.size && !(unmap.iova + unmap.size) &&
             container->iommu_type == VFIO_TYPE1v2_IOMMU) {
-            trace_vfio_dma_unmap_overflow_workaround();
+            trace_vfio_legacy_dma_unmap_overflow_workaround();
             unmap.size -= 1ULL << ctz64(container->pgsizes);
             continue;
         }
@@ -170,9 +172,11 @@ int vfio_dma_unmap(VFIOContainer *container, hwaddr iova,
     return 0;
 }
 
-int vfio_dma_map(VFIOContainer *container, hwaddr iova,
-                 ram_addr_t size, void *vaddr, bool readonly)
+static int vfio_legacy_dma_map(VFIOContainerBase *bcontainer, hwaddr iova,
+                               ram_addr_t size, void *vaddr, bool readonly)
 {
+    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
+                                            bcontainer);
     struct vfio_iommu_type1_dma_map map = {
         .argsz = sizeof(map),
         .flags = VFIO_DMA_MAP_FLAG_READ,
@@ -191,7 +195,8 @@ int vfio_dma_map(VFIOContainer *container, hwaddr iova,
      * the VGA ROM space.
      */
     if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0 ||
-        (errno == EBUSY && vfio_dma_unmap(container, iova, size, NULL) == 0 &&
+        (errno == EBUSY &&
+         vfio_legacy_dma_unmap(bcontainer, iova, size, NULL) == 0 &&
          ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0)) {
         return 0;
     }
@@ -937,4 +942,7 @@ void vfio_detach_device(VFIODevice *vbasedev)
     vfio_put_group(group);
 }
 
-const VFIOIOMMUOps vfio_legacy_ops;
+const VFIOIOMMUOps vfio_legacy_ops = {
+    .dma_map = vfio_legacy_dma_map,
+    .dma_unmap = vfio_legacy_dma_unmap,
+};
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 2a6912c94027d6213144f910d64625a469cc2b1f..eb6ce6229daef67206d562e981898d62b105ece0 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -2,6 +2,7 @@ vfio_ss = ss.source_set()
 vfio_ss.add(files(
   'helpers.c',
   'common.c',
+  'container-base.c',
   'container.c',
   'spapr.c',
   'migration.c',
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 0eb2387cf24c920b0904ec4012b0fcd3f2e8b3cf..9f7fedee986de18d3f97f86bfb5db21b77175573 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -116,7 +116,7 @@ vfio_region_unmap(const char *name, unsigned long offset, unsigned long end) "Re
 vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Device %s region %d: %d sparse mmap entries"
 vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
 vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%08x"
-vfio_dma_unmap_overflow_workaround(void) ""
+vfio_legacy_dma_unmap_overflow_workaround(void) ""
 vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "container fd=%d, iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
 vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
 
-- 
2.43.0


