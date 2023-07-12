Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 234BB750040
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 09:41:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJURv-0004GU-Em; Wed, 12 Jul 2023 03:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJURt-0004Fg-Ou
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:39:45 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJURp-0006nC-9R
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689147581; x=1720683581;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=x7tn/jDEew/yZDJEY4bgoEMktKzkmOBsiHtrLgAdpkc=;
 b=LpsdAXUgm2PVV9F1y7xO9OFDf4+f1jmPkVcpVb7sM6f33WdCCzuPsIlU
 F7446182IY+AwWguDWce27XN65DCcR05s40yPtxWCii0U95McO/LDpVF1
 xFjj5RKsv2I43qKOoW3iWmpGwhqkk27h0lbu0VHp5EOfAieMAufv54A/2
 jqNNag2TEPoTFkhloDEaKMjDmLwLqycvBAItL4PlmoDxWm73Atq/fSike
 Bl0Skr9uKUVhNAijNAJ690iZRvruwQzuIW57rWJd6i3Bb+zNRHnWd32pQ
 wHfmkDM/YGfP7Y/3ifsYLRIeRaVlokmcDJmy8xE7bbOfd4oJMMLGGwt4r g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="430953653"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="430953653"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:39:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="835024003"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="835024003"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:39:19 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, eric.auger@redhat.com, peterx@redhat.com,
 jasonwang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [RFC PATCH v4 08/24] vfio/common: Move legacy VFIO backend code into
 separate container.c
Date: Wed, 12 Jul 2023 15:25:12 +0800
Message-Id: <20230712072528.275577-9-zhenzhong.duan@intel.com>
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

Move all the code really dependent on the legacy VFIO container/group
into a separate file: container.c. What does remain in common.c is
the code related to VFIOAddressSpace and MemoryListeners and migration
general operations.

Move struct VFIOBitmap declaration to vfio-common.h also for containter.c
usage.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
---
 hw/vfio/common.c              | 1091 +--------------------------------
 hw/vfio/container.c           | 1091 +++++++++++++++++++++++++++++++++
 hw/vfio/meson.build           |    1 +
 include/hw/vfio/vfio-common.h |   45 ++
 4 files changed, 1153 insertions(+), 1075 deletions(-)
 create mode 100644 hw/vfio/container.c

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index a1fb0dafda..55a9f274f7 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -45,8 +45,6 @@
 #include "migration/qemu-file.h"
 #include "sysemu/tpm.h"
 
-VFIOGroupList vfio_group_list =
-    QLIST_HEAD_INITIALIZER(vfio_group_list);
 static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =
     QLIST_HEAD_INITIALIZER(vfio_address_spaces);
 
@@ -58,63 +56,14 @@ static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =
  * initialized, this file descriptor is only released on QEMU exit and
  * we'll re-use it should another vfio device be attached before then.
  */
-static int vfio_kvm_device_fd = -1;
+int vfio_kvm_device_fd = -1;
 #endif
 
-static int vfio_ram_block_discard_disable(VFIOContainer *container, bool state)
-{
-    switch (container->iommu_type) {
-    case VFIO_TYPE1v2_IOMMU:
-    case VFIO_TYPE1_IOMMU:
-        /*
-         * We support coordinated discarding of RAM via the RamDiscardManager.
-         */
-        return ram_block_uncoordinated_discard_disable(state);
-    default:
-        /*
-         * VFIO_SPAPR_TCE_IOMMU most probably works just fine with
-         * RamDiscardManager, however, it is completely untested.
-         *
-         * VFIO_SPAPR_TCE_v2_IOMMU with "DMA memory preregistering" does
-         * completely the opposite of managing mapping/pinning dynamically as
-         * required by RamDiscardManager. We would have to special-case sections
-         * with a RamDiscardManager.
-         */
-        return ram_block_discard_disable(state);
-    }
-}
-
-static VFIODevice *vfio_container_dev_iter_next(VFIOContainer *container,
-                                                VFIODevice *curr)
-{
-    VFIOGroup *group;
-
-    if (!curr) {
-        group = QLIST_FIRST(&container->group_list);
-    } else {
-        if (curr->next.le_next) {
-            return curr->next.le_next;
-        }
-        group = curr->group->container_next.le_next;
-    }
-
-    if (!group) {
-        return NULL;
-    }
-    return QLIST_FIRST(&group->device_list);
-}
-
 /*
  * Device state interfaces
  */
 
-typedef struct {
-    unsigned long *bitmap;
-    hwaddr size;
-    hwaddr pages;
-} VFIOBitmap;
-
-static int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size)
+int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size)
 {
     vbmap->pages = REAL_HOST_PAGE_ALIGN(size) / qemu_real_host_page_size();
     vbmap->size = ROUND_UP(vbmap->pages, sizeof(__u64) * BITS_PER_BYTE) /
@@ -127,9 +76,6 @@ static int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size)
     return 0;
 }
 
-static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
-                                 uint64_t size, ram_addr_t ram_addr);
-
 bool vfio_mig_active(void)
 {
     VFIOAddressSpace *space;
@@ -272,7 +218,7 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
     return true;
 }
 
-static bool vfio_devices_all_device_dirty_tracking(VFIOContainer *container)
+bool vfio_devices_all_device_dirty_tracking(VFIOContainer *container)
 {
     VFIODevice *vbasedev = NULL;
 
@@ -289,7 +235,7 @@ static bool vfio_devices_all_device_dirty_tracking(VFIOContainer *container)
  * Check if all VFIO devices are running and migration is active, which is
  * essentially equivalent to the migration being in pre-copy phase.
  */
-static bool vfio_devices_all_running_and_mig_active(VFIOContainer *container)
+bool vfio_devices_all_running_and_mig_active(VFIOContainer *container)
 {
     VFIODevice *vbasedev = NULL;
 
@@ -314,150 +260,8 @@ static bool vfio_devices_all_running_and_mig_active(VFIOContainer *container)
     return true;
 }
 
-static int vfio_dma_unmap_bitmap(VFIOContainer *container,
-                                 hwaddr iova, ram_addr_t size,
-                                 IOMMUTLBEntry *iotlb)
-{
-    struct vfio_iommu_type1_dma_unmap *unmap;
-    struct vfio_bitmap *bitmap;
-    VFIOBitmap vbmap;
-    int ret;
-
-    ret = vfio_bitmap_alloc(&vbmap, size);
-    if (ret) {
-        return ret;
-    }
-
-    unmap = g_malloc0(sizeof(*unmap) + sizeof(*bitmap));
-
-    unmap->argsz = sizeof(*unmap) + sizeof(*bitmap);
-    unmap->iova = iova;
-    unmap->size = size;
-    unmap->flags |= VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP;
-    bitmap = (struct vfio_bitmap *)&unmap->data;
-
-    /*
-     * cpu_physical_memory_set_dirty_lebitmap() supports pages in bitmap of
-     * qemu_real_host_page_size to mark those dirty. Hence set bitmap_pgsize
-     * to qemu_real_host_page_size.
-     */
-    bitmap->pgsize = qemu_real_host_page_size();
-    bitmap->size = vbmap.size;
-    bitmap->data = (__u64 *)vbmap.bitmap;
-
-    if (vbmap.size > container->max_dirty_bitmap_size) {
-        error_report("UNMAP: Size of bitmap too big 0x%"PRIx64, vbmap.size);
-        ret = -E2BIG;
-        goto unmap_exit;
-    }
-
-    ret = ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, unmap);
-    if (!ret) {
-        cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap,
-                iotlb->translated_addr, vbmap.pages);
-    } else {
-        error_report("VFIO_UNMAP_DMA with DIRTY_BITMAP : %m");
-    }
-
-unmap_exit:
-    g_free(unmap);
-    g_free(vbmap.bitmap);
-
-    return ret;
-}
-
-/*
- * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
- */
-static int vfio_dma_unmap(VFIOContainer *container,
-                          hwaddr iova, ram_addr_t size,
-                          IOMMUTLBEntry *iotlb)
-{
-    struct vfio_iommu_type1_dma_unmap unmap = {
-        .argsz = sizeof(unmap),
-        .flags = 0,
-        .iova = iova,
-        .size = size,
-    };
-    bool need_dirty_sync = false;
-    int ret;
-
-    if (iotlb && vfio_devices_all_running_and_mig_active(container)) {
-        if (!vfio_devices_all_device_dirty_tracking(container) &&
-            container->dirty_pages_supported) {
-            return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
-        }
-
-        need_dirty_sync = true;
-    }
-
-    while (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
-        /*
-         * The type1 backend has an off-by-one bug in the kernel (71a7d3d78e3c
-         * v4.15) where an overflow in its wrap-around check prevents us from
-         * unmapping the last page of the address space.  Test for the error
-         * condition and re-try the unmap excluding the last page.  The
-         * expectation is that we've never mapped the last page anyway and this
-         * unmap request comes via vIOMMU support which also makes it unlikely
-         * that this page is used.  This bug was introduced well after type1 v2
-         * support was introduced, so we shouldn't need to test for v1.  A fix
-         * is queued for kernel v5.0 so this workaround can be removed once
-         * affected kernels are sufficiently deprecated.
-         */
-        if (errno == EINVAL && unmap.size && !(unmap.iova + unmap.size) &&
-            container->iommu_type == VFIO_TYPE1v2_IOMMU) {
-            trace_vfio_dma_unmap_overflow_workaround();
-            unmap.size -= 1ULL << ctz64(container->pgsizes);
-            continue;
-        }
-        error_report("VFIO_UNMAP_DMA failed: %s", strerror(errno));
-        return -errno;
-    }
-
-    if (need_dirty_sync) {
-        ret = vfio_get_dirty_bitmap(container, iova, size,
-                                    iotlb->translated_addr);
-        if (ret) {
-            return ret;
-        }
-    }
-
-    return 0;
-}
-
-static int vfio_dma_map(VFIOContainer *container, hwaddr iova,
-                        ram_addr_t size, void *vaddr, bool readonly)
-{
-    struct vfio_iommu_type1_dma_map map = {
-        .argsz = sizeof(map),
-        .flags = VFIO_DMA_MAP_FLAG_READ,
-        .vaddr = (__u64)(uintptr_t)vaddr,
-        .iova = iova,
-        .size = size,
-    };
-
-    if (!readonly) {
-        map.flags |= VFIO_DMA_MAP_FLAG_WRITE;
-    }
-
-    /*
-     * Try the mapping, if it fails with EBUSY, unmap the region and try
-     * again.  This shouldn't be necessary, but we sometimes see it in
-     * the VGA ROM space.
-     */
-    if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0 ||
-        (errno == EBUSY && vfio_dma_unmap(container, iova, size, NULL) == 0 &&
-         ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0)) {
-        return 0;
-    }
-
-    error_report("VFIO_MAP_DMA failed: %s", strerror(errno));
-    return -errno;
-}
-
-static void vfio_host_win_add(VFIOContainer *container,
-                              hwaddr min_iova, hwaddr max_iova,
-                              uint64_t iova_pgsizes)
+void vfio_host_win_add(VFIOContainer *container, hwaddr min_iova,
+                       hwaddr max_iova, uint64_t iova_pgsizes)
 {
     VFIOHostDMAWindow *hostwin;
 
@@ -478,8 +282,8 @@ static void vfio_host_win_add(VFIOContainer *container,
     QLIST_INSERT_HEAD(&container->hostwin_list, hostwin, hostwin_next);
 }
 
-static int vfio_host_win_del(VFIOContainer *container, hwaddr min_iova,
-                             hwaddr max_iova)
+int vfio_host_win_del(VFIOContainer *container,
+                      hwaddr min_iova, hwaddr max_iova)
 {
     VFIOHostDMAWindow *hostwin;
 
@@ -828,92 +632,6 @@ static bool vfio_get_section_iova_range(VFIOContainer *container,
     return true;
 }
 
-static int vfio_container_add_section_window(VFIOContainer *container,
-                                             MemoryRegionSection *section,
-                                             Error **errp)
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
-                    error_report("vfio: failed to setup fd %d "
-                                 "for a group with fd %d: %s",
-                                 param.tablefd, param.groupfd,
-                                 strerror(errno));
-                    return 0;
-                }
-                trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
-            }
-        }
-    }
-#endif
-    return 0;
-}
-
-static void vfio_container_del_section_window(VFIOContainer *container,
-                                              MemoryRegionSection *section)
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
 static void vfio_listener_region_add(MemoryListener *listener,
                                      MemoryRegionSection *section)
 {
@@ -1161,33 +879,6 @@ static void vfio_listener_region_del(MemoryListener *listener,
     vfio_container_del_section_window(container, section);
 }
 
-static int vfio_set_dirty_page_tracking(VFIOContainer *container, bool start)
-{
-    int ret;
-    struct vfio_iommu_type1_dirty_bitmap dirty = {
-        .argsz = sizeof(dirty),
-    };
-
-    if (!container->dirty_pages_supported) {
-        return 0;
-    }
-
-    if (start) {
-        dirty.flags = VFIO_IOMMU_DIRTY_PAGES_FLAG_START;
-    } else {
-        dirty.flags = VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP;
-    }
-
-    ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, &dirty);
-    if (ret) {
-        ret = -errno;
-        error_report("Failed to set dirty tracking flag 0x%x errno: %d",
-                     dirty.flags, errno);
-    }
-
-    return ret;
-}
-
 typedef struct VFIODirtyRanges {
     hwaddr min32;
     hwaddr max32;
@@ -1462,9 +1153,9 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
     return 0;
 }
 
-static int vfio_devices_query_dirty_bitmap(VFIOContainer *container,
-                                           VFIOBitmap *vbmap, hwaddr iova,
-                                           hwaddr size)
+int vfio_devices_query_dirty_bitmap(VFIOContainer *container,
+                                    VFIOBitmap *vbmap, hwaddr iova,
+                                    hwaddr size)
 {
     VFIODevice *vbasedev = NULL;
     int ret;
@@ -1485,45 +1176,8 @@ static int vfio_devices_query_dirty_bitmap(VFIOContainer *container,
     return 0;
 }
 
-static int vfio_query_dirty_bitmap(VFIOContainer *container, VFIOBitmap *vbmap,
-                                   hwaddr iova, hwaddr size)
-{
-    struct vfio_iommu_type1_dirty_bitmap *dbitmap;
-    struct vfio_iommu_type1_dirty_bitmap_get *range;
-    int ret;
-
-    dbitmap = g_malloc0(sizeof(*dbitmap) + sizeof(*range));
-
-    dbitmap->argsz = sizeof(*dbitmap) + sizeof(*range);
-    dbitmap->flags = VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP;
-    range = (struct vfio_iommu_type1_dirty_bitmap_get *)&dbitmap->data;
-    range->iova = iova;
-    range->size = size;
-
-    /*
-     * cpu_physical_memory_set_dirty_lebitmap() supports pages in bitmap of
-     * qemu_real_host_page_size to mark those dirty. Hence set bitmap's pgsize
-     * to qemu_real_host_page_size.
-     */
-    range->bitmap.pgsize = qemu_real_host_page_size();
-    range->bitmap.size = vbmap->size;
-    range->bitmap.data = (__u64 *)vbmap->bitmap;
-
-    ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, dbitmap);
-    if (ret) {
-        ret = -errno;
-        error_report("Failed to get dirty bitmap for iova: 0x%"PRIx64
-                " size: 0x%"PRIx64" err: %d", (uint64_t)range->iova,
-                (uint64_t)range->size, errno);
-    }
-
-    g_free(dbitmap);
-
-    return ret;
-}
-
-static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
-                                 uint64_t size, ram_addr_t ram_addr)
+int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
+                          uint64_t size, ram_addr_t ram_addr)
 {
     bool all_device_dirty_tracking =
         vfio_devices_all_device_dirty_tracking(container);
@@ -1712,7 +1366,7 @@ static void vfio_listener_log_sync(MemoryListener *listener,
     }
 }
 
-static const MemoryListener vfio_memory_listener = {
+const MemoryListener vfio_memory_listener = {
     .name = "vfio",
     .region_add = vfio_listener_region_add,
     .region_del = vfio_listener_region_del,
@@ -1721,45 +1375,6 @@ static const MemoryListener vfio_memory_listener = {
     .log_sync = vfio_listener_log_sync,
 };
 
-static void vfio_listener_release(VFIOContainer *container)
-{
-    memory_listener_unregister(&container->listener);
-    if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
-        memory_listener_unregister(&container->prereg_listener);
-    }
-}
-
-static struct vfio_info_cap_header *
-vfio_get_iommu_type1_info_cap(struct vfio_iommu_type1_info *info, uint16_t id)
-{
-    if (!(info->flags & VFIO_IOMMU_INFO_CAPS)) {
-        return NULL;
-    }
-
-    return vfio_get_cap((void *)info, info->cap_offset, id);
-}
-
-bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
-                             unsigned int *avail)
-{
-    struct vfio_info_cap_header *hdr;
-    struct vfio_iommu_type1_info_dma_avail *cap;
-
-    /* If the capability cannot be found, assume no DMA limiting */
-    hdr = vfio_get_iommu_type1_info_cap(info,
-                                        VFIO_IOMMU_TYPE1_INFO_DMA_AVAIL);
-    if (hdr == NULL) {
-        return false;
-    }
-
-    if (avail != NULL) {
-        cap = (void *) hdr;
-        *avail = cap->avail;
-    }
-
-    return true;
-}
-
 void vfio_reset_handler(void *opaque)
 {
     VFIOAddressSpace *space;
@@ -1826,14 +1441,6 @@ int vfio_kvm_device_add_fd(int fd)
     return 0;
 }
 
-static void vfio_kvm_device_add_group(VFIOGroup *group)
-{
-    if (vfio_kvm_device_add_fd(group->fd)) {
-        error_report("Failed to add group %d to KVM VFIO device",
-                     group->groupid);
-    }
-}
-
 int vfio_kvm_device_del_fd(int fd)
 {
 #ifdef CONFIG_KVM
@@ -1856,15 +1463,7 @@ int vfio_kvm_device_del_fd(int fd)
     return 0;
 }
 
-static void vfio_kvm_device_del_group(VFIOGroup *group)
-{
-    if (vfio_kvm_device_del_fd(group->fd)) {
-        error_report("Failed to remove group %d from KVM VFIO device",
-                     group->groupid);
-    }
-}
-
-static VFIOAddressSpace *vfio_get_address_space(AddressSpace *as)
+VFIOAddressSpace *vfio_get_address_space(AddressSpace *as)
 {
     VFIOAddressSpace *space;
 
@@ -1888,7 +1487,7 @@ static VFIOAddressSpace *vfio_get_address_space(AddressSpace *as)
     return space;
 }
 
-static void vfio_put_address_space(VFIOAddressSpace *space)
+void vfio_put_address_space(VFIOAddressSpace *space)
 {
     if (QLIST_EMPTY(&space->containers)) {
         QLIST_REMOVE(space, list);
@@ -1899,499 +1498,6 @@ static void vfio_put_address_space(VFIOAddressSpace *space)
     }
 }
 
-/*
- * vfio_get_iommu_type - selects the richest iommu_type (v2 first)
- */
-static int vfio_get_iommu_type(VFIOContainer *container,
-                               Error **errp)
-{
-    int iommu_types[] = { VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
-                          VFIO_SPAPR_TCE_v2_IOMMU, VFIO_SPAPR_TCE_IOMMU };
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(iommu_types); i++) {
-        if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu_types[i])) {
-            return iommu_types[i];
-        }
-    }
-    error_setg(errp, "No available IOMMU models");
-    return -EINVAL;
-}
-
-static int vfio_init_container(VFIOContainer *container, int group_fd,
-                               Error **errp)
-{
-    int iommu_type, ret;
-
-    iommu_type = vfio_get_iommu_type(container, errp);
-    if (iommu_type < 0) {
-        return iommu_type;
-    }
-
-    ret = ioctl(group_fd, VFIO_GROUP_SET_CONTAINER, &container->fd);
-    if (ret) {
-        error_setg_errno(errp, errno, "Failed to set group container");
-        return -errno;
-    }
-
-    while (ioctl(container->fd, VFIO_SET_IOMMU, iommu_type)) {
-        if (iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
-            /*
-             * On sPAPR, despite the IOMMU subdriver always advertises v1 and
-             * v2, the running platform may not support v2 and there is no
-             * way to guess it until an IOMMU group gets added to the container.
-             * So in case it fails with v2, try v1 as a fallback.
-             */
-            iommu_type = VFIO_SPAPR_TCE_IOMMU;
-            continue;
-        }
-        error_setg_errno(errp, errno, "Failed to set iommu for container");
-        return -errno;
-    }
-
-    container->iommu_type = iommu_type;
-    return 0;
-}
-
-static int vfio_get_iommu_info(VFIOContainer *container,
-                               struct vfio_iommu_type1_info **info)
-{
-
-    size_t argsz = sizeof(struct vfio_iommu_type1_info);
-
-    *info = g_new0(struct vfio_iommu_type1_info, 1);
-again:
-    (*info)->argsz = argsz;
-
-    if (ioctl(container->fd, VFIO_IOMMU_GET_INFO, *info)) {
-        g_free(*info);
-        *info = NULL;
-        return -errno;
-    }
-
-    if (((*info)->argsz > argsz)) {
-        argsz = (*info)->argsz;
-        *info = g_realloc(*info, argsz);
-        goto again;
-    }
-
-    return 0;
-}
-
-static struct vfio_info_cap_header *
-vfio_get_iommu_info_cap(struct vfio_iommu_type1_info *info, uint16_t id)
-{
-    struct vfio_info_cap_header *hdr;
-    void *ptr = info;
-
-    if (!(info->flags & VFIO_IOMMU_INFO_CAPS)) {
-        return NULL;
-    }
-
-    for (hdr = ptr + info->cap_offset; hdr != ptr; hdr = ptr + hdr->next) {
-        if (hdr->id == id) {
-            return hdr;
-        }
-    }
-
-    return NULL;
-}
-
-static void vfio_get_iommu_info_migration(VFIOContainer *container,
-                                         struct vfio_iommu_type1_info *info)
-{
-    struct vfio_info_cap_header *hdr;
-    struct vfio_iommu_type1_info_cap_migration *cap_mig;
-
-    hdr = vfio_get_iommu_info_cap(info, VFIO_IOMMU_TYPE1_INFO_CAP_MIGRATION);
-    if (!hdr) {
-        return;
-    }
-
-    cap_mig = container_of(hdr, struct vfio_iommu_type1_info_cap_migration,
-                            header);
-
-    /*
-     * cpu_physical_memory_set_dirty_lebitmap() supports pages in bitmap of
-     * qemu_real_host_page_size to mark those dirty.
-     */
-    if (cap_mig->pgsize_bitmap & qemu_real_host_page_size()) {
-        container->dirty_pages_supported = true;
-        container->max_dirty_bitmap_size = cap_mig->max_dirty_bitmap_size;
-        container->dirty_pgsizes = cap_mig->pgsize_bitmap;
-    }
-}
-
-static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
-                                  Error **errp)
-{
-    VFIOContainer *container;
-    int ret, fd;
-    VFIOAddressSpace *space;
-
-    space = vfio_get_address_space(as);
-
-    /*
-     * VFIO is currently incompatible with discarding of RAM insofar as the
-     * madvise to purge (zap) the page from QEMU's address space does not
-     * interact with the memory API and therefore leaves stale virtual to
-     * physical mappings in the IOMMU if the page was previously pinned.  We
-     * therefore set discarding broken for each group added to a container,
-     * whether the container is used individually or shared.  This provides
-     * us with options to allow devices within a group to opt-in and allow
-     * discarding, so long as it is done consistently for a group (for instance
-     * if the device is an mdev device where it is known that the host vendor
-     * driver will never pin pages outside of the working set of the guest
-     * driver, which would thus not be discarding candidates).
-     *
-     * The first opportunity to induce pinning occurs here where we attempt to
-     * attach the group to existing containers within the AddressSpace.  If any
-     * pages are already zapped from the virtual address space, such as from
-     * previous discards, new pinning will cause valid mappings to be
-     * re-established.  Likewise, when the overall MemoryListener for a new
-     * container is registered, a replay of mappings within the AddressSpace
-     * will occur, re-establishing any previously zapped pages as well.
-     *
-     * Especially virtio-balloon is currently only prevented from discarding
-     * new memory, it will not yet set ram_block_discard_set_required() and
-     * therefore, neither stops us here or deals with the sudden memory
-     * consumption of inflated memory.
-     *
-     * We do support discarding of memory coordinated via the RamDiscardManager
-     * with some IOMMU types. vfio_ram_block_discard_disable() handles the
-     * details once we know which type of IOMMU we are using.
-     */
-
-    QLIST_FOREACH(container, &space->containers, next) {
-        if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
-            ret = vfio_ram_block_discard_disable(container, true);
-            if (ret) {
-                error_setg_errno(errp, -ret,
-                                 "Cannot set discarding of RAM broken");
-                if (ioctl(group->fd, VFIO_GROUP_UNSET_CONTAINER,
-                          &container->fd)) {
-                    error_report("vfio: error disconnecting group %d from"
-                                 " container", group->groupid);
-                }
-                return ret;
-            }
-            group->container = container;
-            QLIST_INSERT_HEAD(&container->group_list, group, container_next);
-            vfio_kvm_device_add_group(group);
-            return 0;
-        }
-    }
-
-    fd = qemu_open_old("/dev/vfio/vfio", O_RDWR);
-    if (fd < 0) {
-        error_setg_errno(errp, errno, "failed to open /dev/vfio/vfio");
-        ret = -errno;
-        goto put_space_exit;
-    }
-
-    ret = ioctl(fd, VFIO_GET_API_VERSION);
-    if (ret != VFIO_API_VERSION) {
-        error_setg(errp, "supported vfio version: %d, "
-                   "reported version: %d", VFIO_API_VERSION, ret);
-        ret = -EINVAL;
-        goto close_fd_exit;
-    }
-
-    container = g_malloc0(sizeof(*container));
-    container->space = space;
-    container->fd = fd;
-    container->error = NULL;
-    container->dirty_pages_supported = false;
-    container->dma_max_mappings = 0;
-    QLIST_INIT(&container->giommu_list);
-    QLIST_INIT(&container->hostwin_list);
-    QLIST_INIT(&container->vrdl_list);
-
-    ret = vfio_init_container(container, group->fd, errp);
-    if (ret) {
-        goto free_container_exit;
-    }
-
-    ret = vfio_ram_block_discard_disable(container, true);
-    if (ret) {
-        error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
-        goto free_container_exit;
-    }
-
-    switch (container->iommu_type) {
-    case VFIO_TYPE1v2_IOMMU:
-    case VFIO_TYPE1_IOMMU:
-    {
-        struct vfio_iommu_type1_info *info;
-
-        ret = vfio_get_iommu_info(container, &info);
-        if (ret) {
-            error_setg_errno(errp, -ret, "Failed to get VFIO IOMMU info");
-            goto enable_discards_exit;
-        }
-
-        if (info->flags & VFIO_IOMMU_INFO_PGSIZES) {
-            container->pgsizes = info->iova_pgsizes;
-        } else {
-            container->pgsizes = qemu_real_host_page_size();
-        }
-
-        if (!vfio_get_info_dma_avail(info, &container->dma_max_mappings)) {
-            container->dma_max_mappings = 65535;
-        }
-        vfio_get_iommu_info_migration(container, info);
-        g_free(info);
-
-        /*
-         * FIXME: We should parse VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE
-         * information to get the actual window extent rather than assume
-         * a 64-bit IOVA address space.
-         */
-        vfio_host_win_add(container, 0, (hwaddr)-1, container->pgsizes);
-
-        break;
-    }
-    case VFIO_SPAPR_TCE_v2_IOMMU:
-    case VFIO_SPAPR_TCE_IOMMU:
-    {
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
-        if (ret) {
-            error_setg_errno(errp, errno,
-                             "VFIO_IOMMU_SPAPR_TCE_GET_INFO failed");
-            ret = -errno;
-            if (v2) {
-                memory_listener_unregister(&container->prereg_listener);
-            }
-            goto enable_discards_exit;
-        }
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
-    }
-    }
-
-    vfio_kvm_device_add_group(group);
-
-    QLIST_INIT(&container->group_list);
-    QLIST_INSERT_HEAD(&space->containers, container, next);
-
-    group->container = container;
-    QLIST_INSERT_HEAD(&container->group_list, group, container_next);
-
-    container->listener = vfio_memory_listener;
-
-    memory_listener_register(&container->listener, container->space->as);
-
-    if (container->error) {
-        ret = -1;
-        error_propagate_prepend(errp, container->error,
-            "memory listener initialization failed: ");
-        goto listener_release_exit;
-    }
-
-    container->initialized = true;
-
-    return 0;
-listener_release_exit:
-    QLIST_REMOVE(group, container_next);
-    QLIST_REMOVE(container, next);
-    vfio_kvm_device_del_group(group);
-    vfio_listener_release(container);
-
-enable_discards_exit:
-    vfio_ram_block_discard_disable(container, false);
-
-free_container_exit:
-    g_free(container);
-
-close_fd_exit:
-    close(fd);
-
-put_space_exit:
-    vfio_put_address_space(space);
-
-    return ret;
-}
-
-static void vfio_disconnect_container(VFIOGroup *group)
-{
-    VFIOContainer *container = group->container;
-
-    QLIST_REMOVE(group, container_next);
-    group->container = NULL;
-
-    /*
-     * Explicitly release the listener first before unset container,
-     * since unset may destroy the backend container if it's the last
-     * group.
-     */
-    if (QLIST_EMPTY(&container->group_list)) {
-        vfio_listener_release(container);
-    }
-
-    if (ioctl(group->fd, VFIO_GROUP_UNSET_CONTAINER, &container->fd)) {
-        error_report("vfio: error disconnecting group %d from container",
-                     group->groupid);
-    }
-
-    if (QLIST_EMPTY(&container->group_list)) {
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
-
-        trace_vfio_disconnect_container(container->fd);
-        close(container->fd);
-        g_free(container);
-
-        vfio_put_address_space(space);
-    }
-}
-
-VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
-{
-    VFIOGroup *group;
-    char path[32];
-    struct vfio_group_status status = { .argsz = sizeof(status) };
-
-    QLIST_FOREACH(group, &vfio_group_list, next) {
-        if (group->groupid == groupid) {
-            /* Found it.  Now is it already in the right context? */
-            if (group->container->space->as == as) {
-                return group;
-            } else {
-                error_setg(errp, "group %d used in multiple address spaces",
-                           group->groupid);
-                return NULL;
-            }
-        }
-    }
-
-    group = g_malloc0(sizeof(*group));
-
-    snprintf(path, sizeof(path), "/dev/vfio/%d", groupid);
-    group->fd = qemu_open_old(path, O_RDWR);
-    if (group->fd < 0) {
-        error_setg_errno(errp, errno, "failed to open %s", path);
-        goto free_group_exit;
-    }
-
-    if (ioctl(group->fd, VFIO_GROUP_GET_STATUS, &status)) {
-        error_setg_errno(errp, errno, "failed to get group %d status", groupid);
-        goto close_fd_exit;
-    }
-
-    if (!(status.flags & VFIO_GROUP_FLAGS_VIABLE)) {
-        error_setg(errp, "group %d is not viable", groupid);
-        error_append_hint(errp,
-                          "Please ensure all devices within the iommu_group "
-                          "are bound to their vfio bus driver.\n");
-        goto close_fd_exit;
-    }
-
-    group->groupid = groupid;
-    QLIST_INIT(&group->device_list);
-
-    if (vfio_connect_container(group, as, errp)) {
-        error_prepend(errp, "failed to setup container for group %d: ",
-                      groupid);
-        goto close_fd_exit;
-    }
-
-    QLIST_INSERT_HEAD(&vfio_group_list, group, next);
-
-    return group;
-
-close_fd_exit:
-    close(group->fd);
-
-free_group_exit:
-    g_free(group);
-
-    return NULL;
-}
-
-void vfio_put_group(VFIOGroup *group)
-{
-    if (!group || !QLIST_EMPTY(&group->device_list)) {
-        return;
-    }
-
-    if (!group->ram_block_discard_allowed) {
-        vfio_ram_block_discard_disable(group->container, false);
-    }
-    vfio_kvm_device_del_group(group);
-    vfio_disconnect_container(group);
-    QLIST_REMOVE(group, next);
-    trace_vfio_put_group(group->fd);
-    close(group->fd);
-    g_free(group);
-}
-
 struct vfio_device_info *vfio_get_device_info(int fd)
 {
     struct vfio_device_info *info;
@@ -2415,168 +1521,3 @@ retry:
 
     return info;
 }
-
-int vfio_get_device(VFIOGroup *group, const char *name,
-                    VFIODevice *vbasedev, Error **errp)
-{
-    g_autofree struct vfio_device_info *info = NULL;
-    int fd;
-
-    fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
-    if (fd < 0) {
-        error_setg_errno(errp, errno, "error getting device from group %d",
-                         group->groupid);
-        error_append_hint(errp,
-                      "Verify all devices in group %d are bound to vfio-<bus> "
-                      "or pci-stub and not already in use\n", group->groupid);
-        return fd;
-    }
-
-    info = vfio_get_device_info(fd);
-    if (!info) {
-        error_setg_errno(errp, errno, "error getting device info");
-        close(fd);
-        return -1;
-    }
-
-    /*
-     * Set discarding of RAM as not broken for this group if the driver knows
-     * the device operates compatibly with discarding.  Setting must be
-     * consistent per group, but since compatibility is really only possible
-     * with mdev currently, we expect singleton groups.
-     */
-    if (vbasedev->ram_block_discard_allowed !=
-        group->ram_block_discard_allowed) {
-        if (!QLIST_EMPTY(&group->device_list)) {
-            error_setg(errp, "Inconsistent setting of support for discarding "
-                       "RAM (e.g., balloon) within group");
-            close(fd);
-            return -1;
-        }
-
-        if (!group->ram_block_discard_allowed) {
-            group->ram_block_discard_allowed = true;
-            vfio_ram_block_discard_disable(group->container, false);
-        }
-    }
-
-    vbasedev->fd = fd;
-    vbasedev->group = group;
-    QLIST_INSERT_HEAD(&group->device_list, vbasedev, next);
-
-    vbasedev->num_irqs = info->num_irqs;
-    vbasedev->num_regions = info->num_regions;
-    vbasedev->flags = info->flags;
-
-    trace_vfio_get_device(name, info->flags, info->num_regions, info->num_irqs);
-
-    vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
-
-    return 0;
-}
-
-void vfio_put_base_device(VFIODevice *vbasedev)
-{
-    if (!vbasedev->group) {
-        return;
-    }
-    QLIST_REMOVE(vbasedev, next);
-    vbasedev->group = NULL;
-    trace_vfio_put_base_device(vbasedev->fd);
-    close(vbasedev->fd);
-}
-
-/*
- * Interfaces for IBM EEH (Enhanced Error Handling)
- */
-static bool vfio_eeh_container_ok(VFIOContainer *container)
-{
-    /*
-     * As of 2016-03-04 (linux-4.5) the host kernel EEH/VFIO
-     * implementation is broken if there are multiple groups in a
-     * container.  The hardware works in units of Partitionable
-     * Endpoints (== IOMMU groups) and the EEH operations naively
-     * iterate across all groups in the container, without any logic
-     * to make sure the groups have their state synchronized.  For
-     * certain operations (ENABLE) that might be ok, until an error
-     * occurs, but for others (GET_STATE) it's clearly broken.
-     */
-
-    /*
-     * XXX Once fixed kernels exist, test for them here
-     */
-
-    if (QLIST_EMPTY(&container->group_list)) {
-        return false;
-    }
-
-    if (QLIST_NEXT(QLIST_FIRST(&container->group_list), container_next)) {
-        return false;
-    }
-
-    return true;
-}
-
-static int vfio_eeh_container_op(VFIOContainer *container, uint32_t op)
-{
-    struct vfio_eeh_pe_op pe_op = {
-        .argsz = sizeof(pe_op),
-        .op = op,
-    };
-    int ret;
-
-    if (!vfio_eeh_container_ok(container)) {
-        error_report("vfio/eeh: EEH_PE_OP 0x%x: "
-                     "kernel requires a container with exactly one group", op);
-        return -EPERM;
-    }
-
-    ret = ioctl(container->fd, VFIO_EEH_PE_OP, &pe_op);
-    if (ret < 0) {
-        error_report("vfio/eeh: EEH_PE_OP 0x%x failed: %m", op);
-        return -errno;
-    }
-
-    return ret;
-}
-
-static VFIOContainer *vfio_eeh_as_container(AddressSpace *as)
-{
-    VFIOAddressSpace *space = vfio_get_address_space(as);
-    VFIOContainer *container = NULL;
-
-    if (QLIST_EMPTY(&space->containers)) {
-        /* No containers to act on */
-        goto out;
-    }
-
-    container = QLIST_FIRST(&space->containers);
-
-    if (QLIST_NEXT(container, next)) {
-        /* We don't yet have logic to synchronize EEH state across
-         * multiple containers */
-        container = NULL;
-        goto out;
-    }
-
-out:
-    vfio_put_address_space(space);
-    return container;
-}
-
-bool vfio_eeh_as_ok(AddressSpace *as)
-{
-    VFIOContainer *container = vfio_eeh_as_container(as);
-
-    return (container != NULL) && vfio_eeh_container_ok(container);
-}
-
-int vfio_eeh_as_op(AddressSpace *as, uint32_t op)
-{
-    VFIOContainer *container = vfio_eeh_as_container(as);
-
-    if (!container) {
-        return -ENODEV;
-    }
-    return vfio_eeh_container_op(container, op);
-}
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
new file mode 100644
index 0000000000..5bfb057007
--- /dev/null
+++ b/hw/vfio/container.c
@@ -0,0 +1,1091 @@
+/*
+ * generic functions used by VFIO devices
+ *
+ * Copyright Red Hat, Inc. 2012
+ *
+ * Authors:
+ *  Alex Williamson <alex.williamson@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * Based on qemu-kvm device-assignment:
+ *  Adapted for KVM by Qumranet.
+ *  Copyright (c) 2007, Neocleus, Alex Novik (alex@neocleus.com)
+ *  Copyright (c) 2007, Neocleus, Guy Zana (guy@neocleus.com)
+ *  Copyright (C) 2008, Qumranet, Amit Shah (amit.shah@qumranet.com)
+ *  Copyright (C) 2008, Red Hat, Amit Shah (amit.shah@redhat.com)
+ *  Copyright (C) 2008, IBM, Muli Ben-Yehuda (muli@il.ibm.com)
+ */
+
+#include "qemu/osdep.h"
+#include <sys/ioctl.h>
+#ifdef CONFIG_KVM
+#include <linux/kvm.h>
+#endif
+#include <linux/vfio.h>
+
+#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio.h"
+#include "exec/address-spaces.h"
+#include "exec/memory.h"
+#include "exec/ram_addr.h"
+#include "hw/hw.h"
+#include "qemu/error-report.h"
+#include "qemu/range.h"
+#include "sysemu/kvm.h"
+#include "sysemu/reset.h"
+#include "trace.h"
+#include "qapi/error.h"
+#include "migration/migration.h"
+
+VFIOGroupList vfio_group_list =
+    QLIST_HEAD_INITIALIZER(vfio_group_list);
+
+static int vfio_ram_block_discard_disable(VFIOContainer *container, bool state)
+{
+    switch (container->iommu_type) {
+    case VFIO_TYPE1v2_IOMMU:
+    case VFIO_TYPE1_IOMMU:
+        /*
+         * We support coordinated discarding of RAM via the RamDiscardManager.
+         */
+        return ram_block_uncoordinated_discard_disable(state);
+    default:
+        /*
+         * VFIO_SPAPR_TCE_IOMMU most probably works just fine with
+         * RamDiscardManager, however, it is completely untested.
+         *
+         * VFIO_SPAPR_TCE_v2_IOMMU with "DMA memory preregistering" does
+         * completely the opposite of managing mapping/pinning dynamically as
+         * required by RamDiscardManager. We would have to special-case sections
+         * with a RamDiscardManager.
+         */
+        return ram_block_discard_disable(state);
+    }
+}
+
+VFIODevice *vfio_container_dev_iter_next(VFIOContainer *container,
+                                         VFIODevice *curr)
+{
+    VFIOGroup *group;
+
+    if (!curr) {
+        group = QLIST_FIRST(&container->group_list);
+    } else {
+        if (curr->next.le_next) {
+            return curr->next.le_next;
+        }
+        group = curr->group->container_next.le_next;
+    }
+
+    if (!group) {
+        return NULL;
+    }
+    return QLIST_FIRST(&group->device_list);
+}
+
+static int vfio_dma_unmap_bitmap(VFIOContainer *container,
+                                 hwaddr iova, ram_addr_t size,
+                                 IOMMUTLBEntry *iotlb)
+{
+    struct vfio_iommu_type1_dma_unmap *unmap;
+    struct vfio_bitmap *bitmap;
+    VFIOBitmap vbmap;
+    int ret;
+
+    ret = vfio_bitmap_alloc(&vbmap, size);
+    if (ret) {
+        return ret;
+    }
+
+    unmap = g_malloc0(sizeof(*unmap) + sizeof(*bitmap));
+
+    unmap->argsz = sizeof(*unmap) + sizeof(*bitmap);
+    unmap->iova = iova;
+    unmap->size = size;
+    unmap->flags |= VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP;
+    bitmap = (struct vfio_bitmap *)&unmap->data;
+
+    /*
+     * cpu_physical_memory_set_dirty_lebitmap() supports pages in bitmap of
+     * qemu_real_host_page_size to mark those dirty. Hence set bitmap_pgsize
+     * to qemu_real_host_page_size.
+     */
+    bitmap->pgsize = qemu_real_host_page_size();
+    bitmap->size = vbmap.size;
+    bitmap->data = (__u64 *)vbmap.bitmap;
+
+    if (vbmap.size > container->max_dirty_bitmap_size) {
+        error_report("UNMAP: Size of bitmap too big 0x%"PRIx64, vbmap.size);
+        ret = -E2BIG;
+        goto unmap_exit;
+    }
+
+    ret = ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, unmap);
+    if (!ret) {
+        cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap,
+                iotlb->translated_addr, vbmap.pages);
+    } else {
+        error_report("VFIO_UNMAP_DMA with DIRTY_BITMAP : %m");
+    }
+
+unmap_exit:
+    g_free(unmap);
+    g_free(vbmap.bitmap);
+
+    return ret;
+}
+
+/*
+ * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
+ */
+int vfio_dma_unmap(VFIOContainer *container, hwaddr iova,
+                   ram_addr_t size, IOMMUTLBEntry *iotlb)
+{
+    struct vfio_iommu_type1_dma_unmap unmap = {
+        .argsz = sizeof(unmap),
+        .flags = 0,
+        .iova = iova,
+        .size = size,
+    };
+    bool need_dirty_sync = false;
+    int ret;
+
+    if (iotlb && vfio_devices_all_running_and_mig_active(container)) {
+        if (!vfio_devices_all_device_dirty_tracking(container) &&
+            container->dirty_pages_supported) {
+            return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
+        }
+
+        need_dirty_sync = true;
+    }
+
+    while (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
+        /*
+         * The type1 backend has an off-by-one bug in the kernel (71a7d3d78e3c
+         * v4.15) where an overflow in its wrap-around check prevents us from
+         * unmapping the last page of the address space.  Test for the error
+         * condition and re-try the unmap excluding the last page.  The
+         * expectation is that we've never mapped the last page anyway and this
+         * unmap request comes via vIOMMU support which also makes it unlikely
+         * that this page is used.  This bug was introduced well after type1 v2
+         * support was introduced, so we shouldn't need to test for v1.  A fix
+         * is queued for kernel v5.0 so this workaround can be removed once
+         * affected kernels are sufficiently deprecated.
+         */
+        if (errno == EINVAL && unmap.size && !(unmap.iova + unmap.size) &&
+            container->iommu_type == VFIO_TYPE1v2_IOMMU) {
+            trace_vfio_dma_unmap_overflow_workaround();
+            unmap.size -= 1ULL << ctz64(container->pgsizes);
+            continue;
+        }
+        error_report("VFIO_UNMAP_DMA failed: %s", strerror(errno));
+        return -errno;
+    }
+
+    if (need_dirty_sync) {
+        ret = vfio_get_dirty_bitmap(container, iova, size,
+                                    iotlb->translated_addr);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
+int vfio_dma_map(VFIOContainer *container, hwaddr iova,
+                 ram_addr_t size, void *vaddr, bool readonly)
+{
+    struct vfio_iommu_type1_dma_map map = {
+        .argsz = sizeof(map),
+        .flags = VFIO_DMA_MAP_FLAG_READ,
+        .vaddr = (__u64)(uintptr_t)vaddr,
+        .iova = iova,
+        .size = size,
+    };
+
+    if (!readonly) {
+        map.flags |= VFIO_DMA_MAP_FLAG_WRITE;
+    }
+
+    /*
+     * Try the mapping, if it fails with EBUSY, unmap the region and try
+     * again.  This shouldn't be necessary, but we sometimes see it in
+     * the VGA ROM space.
+     */
+    if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0 ||
+        (errno == EBUSY && vfio_dma_unmap(container, iova, size, NULL) == 0 &&
+         ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0)) {
+        return 0;
+    }
+
+    error_report("VFIO_MAP_DMA failed: %s", strerror(errno));
+    return -errno;
+}
+
+int vfio_set_dirty_page_tracking(VFIOContainer *container, bool start)
+{
+    int ret;
+    struct vfio_iommu_type1_dirty_bitmap dirty = {
+        .argsz = sizeof(dirty),
+    };
+
+    if (!container->dirty_pages_supported) {
+        return 0;
+    }
+
+    if (start) {
+        dirty.flags = VFIO_IOMMU_DIRTY_PAGES_FLAG_START;
+    } else {
+        dirty.flags = VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP;
+    }
+
+    ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, &dirty);
+    if (ret) {
+        ret = -errno;
+        error_report("Failed to set dirty tracking flag 0x%x errno: %d",
+                     dirty.flags, errno);
+    }
+
+    return ret;
+}
+
+int vfio_query_dirty_bitmap(VFIOContainer *container, VFIOBitmap *vbmap,
+                            hwaddr iova, hwaddr size)
+{
+    struct vfio_iommu_type1_dirty_bitmap *dbitmap;
+    struct vfio_iommu_type1_dirty_bitmap_get *range;
+    int ret;
+
+    dbitmap = g_malloc0(sizeof(*dbitmap) + sizeof(*range));
+
+    dbitmap->argsz = sizeof(*dbitmap) + sizeof(*range);
+    dbitmap->flags = VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP;
+    range = (struct vfio_iommu_type1_dirty_bitmap_get *)&dbitmap->data;
+    range->iova = iova;
+    range->size = size;
+
+    /*
+     * cpu_physical_memory_set_dirty_lebitmap() supports pages in bitmap of
+     * qemu_real_host_page_size to mark those dirty. Hence set bitmap's pgsize
+     * to qemu_real_host_page_size.
+     */
+    range->bitmap.pgsize = qemu_real_host_page_size();
+    range->bitmap.size = vbmap->size;
+    range->bitmap.data = (__u64 *)vbmap->bitmap;
+
+    ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, dbitmap);
+    if (ret) {
+        ret = -errno;
+        error_report("Failed to get dirty bitmap for iova: 0x%"PRIx64
+                " size: 0x%"PRIx64" err: %d", (uint64_t)range->iova,
+                (uint64_t)range->size, errno);
+    }
+
+    g_free(dbitmap);
+
+    return ret;
+}
+
+static void vfio_listener_release(VFIOContainer *container)
+{
+    memory_listener_unregister(&container->listener);
+    if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
+        memory_listener_unregister(&container->prereg_listener);
+    }
+}
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
+
+static struct vfio_info_cap_header *
+vfio_get_iommu_type1_info_cap(struct vfio_iommu_type1_info *info, uint16_t id)
+{
+    if (!(info->flags & VFIO_IOMMU_INFO_CAPS)) {
+        return NULL;
+    }
+
+    return vfio_get_cap((void *)info, info->cap_offset, id);
+}
+
+bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
+                             unsigned int *avail)
+{
+    struct vfio_info_cap_header *hdr;
+    struct vfio_iommu_type1_info_dma_avail *cap;
+
+    /* If the capability cannot be found, assume no DMA limiting */
+    hdr = vfio_get_iommu_type1_info_cap(info,
+                                        VFIO_IOMMU_TYPE1_INFO_DMA_AVAIL);
+    if (hdr == NULL) {
+        return false;
+    }
+
+    if (avail != NULL) {
+        cap = (void *) hdr;
+        *avail = cap->avail;
+    }
+
+    return true;
+}
+
+static void vfio_kvm_device_add_group(VFIOGroup *group)
+{
+    if (vfio_kvm_device_add_fd(group->fd)) {
+        error_report("Failed to add group %d to KVM VFIO device",
+                     group->groupid);
+    }
+}
+
+static void vfio_kvm_device_del_group(VFIOGroup *group)
+{
+    if (vfio_kvm_device_del_fd(group->fd)) {
+        error_report("failed to remove group %d from kvm vfio device",
+                     group->groupid);
+    }
+}
+
+/*
+ * vfio_get_iommu_type - selects the richest iommu_type (v2 first)
+ */
+static int vfio_get_iommu_type(VFIOContainer *container,
+                               Error **errp)
+{
+    int iommu_types[] = { VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
+                          VFIO_SPAPR_TCE_v2_IOMMU, VFIO_SPAPR_TCE_IOMMU };
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(iommu_types); i++) {
+        if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu_types[i])) {
+            return iommu_types[i];
+        }
+    }
+    error_setg(errp, "No available IOMMU models");
+    return -EINVAL;
+}
+
+static int vfio_init_container(VFIOContainer *container, int group_fd,
+                               Error **errp)
+{
+    int iommu_type, ret;
+
+    iommu_type = vfio_get_iommu_type(container, errp);
+    if (iommu_type < 0) {
+        return iommu_type;
+    }
+
+    ret = ioctl(group_fd, VFIO_GROUP_SET_CONTAINER, &container->fd);
+    if (ret) {
+        error_setg_errno(errp, errno, "Failed to set group container");
+        return -errno;
+    }
+
+    while (ioctl(container->fd, VFIO_SET_IOMMU, iommu_type)) {
+        if (iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
+            /*
+             * On sPAPR, despite the IOMMU subdriver always advertises v1 and
+             * v2, the running platform may not support v2 and there is no
+             * way to guess it until an IOMMU group gets added to the container.
+             * So in case it fails with v2, try v1 as a fallback.
+             */
+            iommu_type = VFIO_SPAPR_TCE_IOMMU;
+            continue;
+        }
+        error_setg_errno(errp, errno, "Failed to set iommu for container");
+        return -errno;
+    }
+
+    container->iommu_type = iommu_type;
+    return 0;
+}
+
+static int vfio_get_iommu_info(VFIOContainer *container,
+                               struct vfio_iommu_type1_info **info)
+{
+
+    size_t argsz = sizeof(struct vfio_iommu_type1_info);
+
+    *info = g_new0(struct vfio_iommu_type1_info, 1);
+again:
+    (*info)->argsz = argsz;
+
+    if (ioctl(container->fd, VFIO_IOMMU_GET_INFO, *info)) {
+        g_free(*info);
+        *info = NULL;
+        return -errno;
+    }
+
+    if (((*info)->argsz > argsz)) {
+        argsz = (*info)->argsz;
+        *info = g_realloc(*info, argsz);
+        goto again;
+    }
+
+    return 0;
+}
+
+static struct vfio_info_cap_header *
+vfio_get_iommu_info_cap(struct vfio_iommu_type1_info *info, uint16_t id)
+{
+    struct vfio_info_cap_header *hdr;
+    void *ptr = info;
+
+    if (!(info->flags & VFIO_IOMMU_INFO_CAPS)) {
+        return NULL;
+    }
+
+    for (hdr = ptr + info->cap_offset; hdr != ptr; hdr = ptr + hdr->next) {
+        if (hdr->id == id) {
+            return hdr;
+        }
+    }
+
+    return NULL;
+}
+
+static void vfio_get_iommu_info_migration(VFIOContainer *container,
+                                         struct vfio_iommu_type1_info *info)
+{
+    struct vfio_info_cap_header *hdr;
+    struct vfio_iommu_type1_info_cap_migration *cap_mig;
+
+    hdr = vfio_get_iommu_info_cap(info, VFIO_IOMMU_TYPE1_INFO_CAP_MIGRATION);
+    if (!hdr) {
+        return;
+    }
+
+    cap_mig = container_of(hdr, struct vfio_iommu_type1_info_cap_migration,
+                            header);
+
+    /*
+     * cpu_physical_memory_set_dirty_lebitmap() supports pages in bitmap of
+     * qemu_real_host_page_size to mark those dirty.
+     */
+    if (cap_mig->pgsize_bitmap & qemu_real_host_page_size()) {
+        container->dirty_pages_supported = true;
+        container->max_dirty_bitmap_size = cap_mig->max_dirty_bitmap_size;
+        container->dirty_pgsizes = cap_mig->pgsize_bitmap;
+    }
+}
+
+static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
+                                  Error **errp)
+{
+    VFIOContainer *container;
+    int ret, fd;
+    VFIOAddressSpace *space;
+
+    space = vfio_get_address_space(as);
+
+    /*
+     * VFIO is currently incompatible with discarding of RAM insofar as the
+     * madvise to purge (zap) the page from QEMU's address space does not
+     * interact with the memory API and therefore leaves stale virtual to
+     * physical mappings in the IOMMU if the page was previously pinned.  We
+     * therefore set discarding broken for each group added to a container,
+     * whether the container is used individually or shared.  This provides
+     * us with options to allow devices within a group to opt-in and allow
+     * discarding, so long as it is done consistently for a group (for instance
+     * if the device is an mdev device where it is known that the host vendor
+     * driver will never pin pages outside of the working set of the guest
+     * driver, which would thus not be discarding candidates).
+     *
+     * The first opportunity to induce pinning occurs here where we attempt to
+     * attach the group to existing containers within the AddressSpace.  If any
+     * pages are already zapped from the virtual address space, such as from
+     * previous discards, new pinning will cause valid mappings to be
+     * re-established.  Likewise, when the overall MemoryListener for a new
+     * container is registered, a replay of mappings within the AddressSpace
+     * will occur, re-establishing any previously zapped pages as well.
+     *
+     * Especially virtio-balloon is currently only prevented from discarding
+     * new memory, it will not yet set ram_block_discard_set_required() and
+     * therefore, neither stops us here or deals with the sudden memory
+     * consumption of inflated memory.
+     *
+     * We do support discarding of memory coordinated via the RamDiscardManager
+     * with some IOMMU types. vfio_ram_block_discard_disable() handles the
+     * details once we know which type of IOMMU we are using.
+     */
+
+    QLIST_FOREACH(container, &space->containers, next) {
+        if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
+            ret = vfio_ram_block_discard_disable(container, true);
+            if (ret) {
+                error_setg_errno(errp, -ret,
+                                 "Cannot set discarding of RAM broken");
+                if (ioctl(group->fd, VFIO_GROUP_UNSET_CONTAINER,
+                          &container->fd)) {
+                    error_report("vfio: error disconnecting group %d from"
+                                 " container", group->groupid);
+                }
+                return ret;
+            }
+            group->container = container;
+            QLIST_INSERT_HEAD(&container->group_list, group, container_next);
+            vfio_kvm_device_add_group(group);
+            return 0;
+        }
+    }
+
+    fd = qemu_open_old("/dev/vfio/vfio", O_RDWR);
+    if (fd < 0) {
+        error_setg_errno(errp, errno, "failed to open /dev/vfio/vfio");
+        ret = -errno;
+        goto put_space_exit;
+    }
+
+    ret = ioctl(fd, VFIO_GET_API_VERSION);
+    if (ret != VFIO_API_VERSION) {
+        error_setg(errp, "supported vfio version: %d, "
+                   "reported version: %d", VFIO_API_VERSION, ret);
+        ret = -EINVAL;
+        goto close_fd_exit;
+    }
+
+    container = g_malloc0(sizeof(*container));
+    container->space = space;
+    container->fd = fd;
+    container->error = NULL;
+    container->dirty_pages_supported = false;
+    container->dma_max_mappings = 0;
+    QLIST_INIT(&container->giommu_list);
+    QLIST_INIT(&container->hostwin_list);
+    QLIST_INIT(&container->vrdl_list);
+
+    ret = vfio_init_container(container, group->fd, errp);
+    if (ret) {
+        goto free_container_exit;
+    }
+
+    ret = vfio_ram_block_discard_disable(container, true);
+    if (ret) {
+        error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
+        goto free_container_exit;
+    }
+
+    switch (container->iommu_type) {
+    case VFIO_TYPE1v2_IOMMU:
+    case VFIO_TYPE1_IOMMU:
+    {
+        struct vfio_iommu_type1_info *info;
+
+        ret = vfio_get_iommu_info(container, &info);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to get VFIO IOMMU info");
+            goto enable_discards_exit;
+        }
+
+        if (info->flags & VFIO_IOMMU_INFO_PGSIZES) {
+            container->pgsizes = info->iova_pgsizes;
+        } else {
+            container->pgsizes = qemu_real_host_page_size();
+        }
+
+        if (!vfio_get_info_dma_avail(info, &container->dma_max_mappings)) {
+            container->dma_max_mappings = 65535;
+        }
+        vfio_get_iommu_info_migration(container, info);
+        g_free(info);
+
+        /*
+         * FIXME: We should parse VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE
+         * information to get the actual window extent rather than assume
+         * a 64-bit IOVA address space.
+         */
+        vfio_host_win_add(container, 0, (hwaddr)-1, container->pgsizes);
+
+        break;
+    }
+    case VFIO_SPAPR_TCE_v2_IOMMU:
+    case VFIO_SPAPR_TCE_IOMMU:
+    {
+        struct vfio_iommu_spapr_tce_info info;
+        bool v2 = container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU;
+
+        /*
+         * The host kernel code implementing VFIO_IOMMU_DISABLE is called
+         * when container fd is closed so we do not call it explicitly
+         * in this file.
+         */
+        if (!v2) {
+            ret = ioctl(fd, VFIO_IOMMU_ENABLE);
+            if (ret) {
+                error_setg_errno(errp, errno, "failed to enable container");
+                ret = -errno;
+                goto enable_discards_exit;
+            }
+        } else {
+            container->prereg_listener = vfio_prereg_listener;
+
+            memory_listener_register(&container->prereg_listener,
+                                     &address_space_memory);
+            if (container->error) {
+                memory_listener_unregister(&container->prereg_listener);
+                ret = -1;
+                error_propagate_prepend(errp, container->error,
+                    "RAM memory listener initialization failed: ");
+                goto enable_discards_exit;
+            }
+        }
+
+        info.argsz = sizeof(info);
+        ret = ioctl(fd, VFIO_IOMMU_SPAPR_TCE_GET_INFO, &info);
+        if (ret) {
+            error_setg_errno(errp, errno,
+                             "VFIO_IOMMU_SPAPR_TCE_GET_INFO failed");
+            ret = -errno;
+            if (v2) {
+                memory_listener_unregister(&container->prereg_listener);
+            }
+            goto enable_discards_exit;
+        }
+
+        if (v2) {
+            container->pgsizes = info.ddw.pgsizes;
+            /*
+             * There is a default window in just created container.
+             * To make region_add/del simpler, we better remove this
+             * window now and let those iommu_listener callbacks
+             * create/remove them when needed.
+             */
+            ret = vfio_spapr_remove_window(container, info.dma32_window_start);
+            if (ret) {
+                error_setg_errno(errp, -ret,
+                                 "failed to remove existing window");
+                goto enable_discards_exit;
+            }
+        } else {
+            /* The default table uses 4K pages */
+            container->pgsizes = 0x1000;
+            vfio_host_win_add(container, info.dma32_window_start,
+                              info.dma32_window_start +
+                              info.dma32_window_size - 1,
+                              0x1000);
+        }
+    }
+    }
+
+    vfio_kvm_device_add_group(group);
+
+    QLIST_INIT(&container->group_list);
+    QLIST_INSERT_HEAD(&space->containers, container, next);
+
+    group->container = container;
+    QLIST_INSERT_HEAD(&container->group_list, group, container_next);
+
+    container->listener = vfio_memory_listener;
+
+    memory_listener_register(&container->listener, container->space->as);
+
+    if (container->error) {
+        ret = -1;
+        error_propagate_prepend(errp, container->error,
+            "memory listener initialization failed: ");
+        goto listener_release_exit;
+    }
+
+    container->initialized = true;
+
+    return 0;
+listener_release_exit:
+    QLIST_REMOVE(group, container_next);
+    QLIST_REMOVE(container, next);
+    vfio_kvm_device_del_group(group);
+    vfio_listener_release(container);
+
+enable_discards_exit:
+    vfio_ram_block_discard_disable(container, false);
+
+free_container_exit:
+    g_free(container);
+
+close_fd_exit:
+    close(fd);
+
+put_space_exit:
+    vfio_put_address_space(space);
+
+    return ret;
+}
+
+static void vfio_disconnect_container(VFIOGroup *group)
+{
+    VFIOContainer *container = group->container;
+
+    QLIST_REMOVE(group, container_next);
+    group->container = NULL;
+
+    /*
+     * Explicitly release the listener first before unset container,
+     * since unset may destroy the backend container if it's the last
+     * group.
+     */
+    if (QLIST_EMPTY(&container->group_list)) {
+        vfio_listener_release(container);
+    }
+
+    if (ioctl(group->fd, VFIO_GROUP_UNSET_CONTAINER, &container->fd)) {
+        error_report("vfio: error disconnecting group %d from container",
+                     group->groupid);
+    }
+
+    if (QLIST_EMPTY(&container->group_list)) {
+        VFIOAddressSpace *space = container->space;
+        VFIOGuestIOMMU *giommu, *tmp;
+        VFIOHostDMAWindow *hostwin, *next;
+
+        QLIST_REMOVE(container, next);
+
+        QLIST_FOREACH_SAFE(giommu, &container->giommu_list, giommu_next, tmp) {
+            memory_region_unregister_iommu_notifier(
+                    MEMORY_REGION(giommu->iommu_mr), &giommu->n);
+            QLIST_REMOVE(giommu, giommu_next);
+            g_free(giommu);
+        }
+
+        QLIST_FOREACH_SAFE(hostwin, &container->hostwin_list, hostwin_next,
+                           next) {
+            QLIST_REMOVE(hostwin, hostwin_next);
+            g_free(hostwin);
+        }
+
+        trace_vfio_disconnect_container(container->fd);
+        close(container->fd);
+        g_free(container);
+
+        vfio_put_address_space(space);
+    }
+}
+
+VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
+{
+    VFIOGroup *group;
+    char path[32];
+    struct vfio_group_status status = { .argsz = sizeof(status) };
+
+    QLIST_FOREACH(group, &vfio_group_list, next) {
+        if (group->groupid == groupid) {
+            /* Found it.  Now is it already in the right context? */
+            if (group->container->space->as == as) {
+                return group;
+            } else {
+                error_setg(errp, "group %d used in multiple address spaces",
+                           group->groupid);
+                return NULL;
+            }
+        }
+    }
+
+    group = g_malloc0(sizeof(*group));
+
+    snprintf(path, sizeof(path), "/dev/vfio/%d", groupid);
+    group->fd = qemu_open_old(path, O_RDWR);
+    if (group->fd < 0) {
+        error_setg_errno(errp, errno, "failed to open %s", path);
+        goto free_group_exit;
+    }
+
+    if (ioctl(group->fd, VFIO_GROUP_GET_STATUS, &status)) {
+        error_setg_errno(errp, errno, "failed to get group %d status", groupid);
+        goto close_fd_exit;
+    }
+
+    if (!(status.flags & VFIO_GROUP_FLAGS_VIABLE)) {
+        error_setg(errp, "group %d is not viable", groupid);
+        error_append_hint(errp,
+                          "Please ensure all devices within the iommu_group "
+                          "are bound to their vfio bus driver.\n");
+        goto close_fd_exit;
+    }
+
+    group->groupid = groupid;
+    QLIST_INIT(&group->device_list);
+
+    if (vfio_connect_container(group, as, errp)) {
+        error_prepend(errp, "failed to setup container for group %d: ",
+                      groupid);
+        goto close_fd_exit;
+    }
+
+    QLIST_INSERT_HEAD(&vfio_group_list, group, next);
+
+    return group;
+
+close_fd_exit:
+    close(group->fd);
+
+free_group_exit:
+    g_free(group);
+
+    return NULL;
+}
+
+void vfio_put_group(VFIOGroup *group)
+{
+    if (!group || !QLIST_EMPTY(&group->device_list)) {
+        return;
+    }
+
+    if (!group->ram_block_discard_allowed) {
+        vfio_ram_block_discard_disable(group->container, false);
+    }
+    vfio_kvm_device_del_group(group);
+    vfio_disconnect_container(group);
+    QLIST_REMOVE(group, next);
+    trace_vfio_put_group(group->fd);
+    close(group->fd);
+    g_free(group);
+}
+
+int vfio_get_device(VFIOGroup *group, const char *name,
+                    VFIODevice *vbasedev, Error **errp)
+{
+    g_autofree struct vfio_device_info *info = NULL;
+    int fd;
+
+    fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
+    if (fd < 0) {
+        error_setg_errno(errp, errno, "error getting device from group %d",
+                         group->groupid);
+        error_append_hint(errp,
+                      "Verify all devices in group %d are bound to vfio-<bus> "
+                      "or pci-stub and not already in use\n", group->groupid);
+        return fd;
+    }
+
+    info = vfio_get_device_info(fd);
+    if (!info) {
+        error_setg_errno(errp, errno, "error getting device info");
+        close(fd);
+        return -1;
+    }
+
+    /*
+     * Set discarding of RAM as not broken for this group if the driver knows
+     * the device operates compatibly with discarding.  Setting must be
+     * consistent per group, but since compatibility is really only possible
+     * with mdev currently, we expect singleton groups.
+     */
+    if (vbasedev->ram_block_discard_allowed !=
+        group->ram_block_discard_allowed) {
+        if (!QLIST_EMPTY(&group->device_list)) {
+            error_setg(errp, "Inconsistent setting of support for discarding "
+                       "RAM (e.g., balloon) within group");
+            close(fd);
+            return -1;
+        }
+
+        if (!group->ram_block_discard_allowed) {
+            group->ram_block_discard_allowed = true;
+            vfio_ram_block_discard_disable(group->container, false);
+        }
+    }
+
+    vbasedev->fd = fd;
+    vbasedev->group = group;
+    QLIST_INSERT_HEAD(&group->device_list, vbasedev, next);
+
+    vbasedev->num_irqs = info->num_irqs;
+    vbasedev->num_regions = info->num_regions;
+    vbasedev->flags = info->flags;
+
+    trace_vfio_get_device(name, info->flags, info->num_regions, info->num_irqs);
+
+    vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
+
+    return 0;
+}
+
+void vfio_put_base_device(VFIODevice *vbasedev)
+{
+    if (!vbasedev->group) {
+        return;
+    }
+    QLIST_REMOVE(vbasedev, next);
+    vbasedev->group = NULL;
+    trace_vfio_put_base_device(vbasedev->fd);
+    close(vbasedev->fd);
+}
+
+/*
+ * Interfaces for IBM EEH (Enhanced Error Handling)
+ */
+static bool vfio_eeh_container_ok(VFIOContainer *container)
+{
+    /*
+     * As of 2016-03-04 (linux-4.5) the host kernel EEH/VFIO
+     * implementation is broken if there are multiple groups in a
+     * container.  The hardware works in units of Partitionable
+     * Endpoints (== IOMMU groups) and the EEH operations naively
+     * iterate across all groups in the container, without any logic
+     * to make sure the groups have their state synchronized.  For
+     * certain operations (ENABLE) that might be ok, until an error
+     * occurs, but for others (GET_STATE) it's clearly broken.
+     */
+
+    /*
+     * XXX Once fixed kernels exist, test for them here
+     */
+
+    if (QLIST_EMPTY(&container->group_list)) {
+        return false;
+    }
+
+    if (QLIST_NEXT(QLIST_FIRST(&container->group_list), container_next)) {
+        return false;
+    }
+
+    return true;
+}
+
+static int vfio_eeh_container_op(VFIOContainer *container, uint32_t op)
+{
+    struct vfio_eeh_pe_op pe_op = {
+        .argsz = sizeof(pe_op),
+        .op = op,
+    };
+    int ret;
+
+    if (!vfio_eeh_container_ok(container)) {
+        error_report("vfio/eeh: EEH_PE_OP 0x%x: "
+                     "kernel requires a container with exactly one group", op);
+        return -EPERM;
+    }
+
+    ret = ioctl(container->fd, VFIO_EEH_PE_OP, &pe_op);
+    if (ret < 0) {
+        error_report("vfio/eeh: EEH_PE_OP 0x%x failed: %m", op);
+        return -errno;
+    }
+
+    return ret;
+}
+
+static VFIOContainer *vfio_eeh_as_container(AddressSpace *as)
+{
+    VFIOAddressSpace *space = vfio_get_address_space(as);
+    VFIOContainer *container = NULL;
+
+    if (QLIST_EMPTY(&space->containers)) {
+        /* No containers to act on */
+        goto out;
+    }
+
+    container = QLIST_FIRST(&space->containers);
+
+    if (QLIST_NEXT(container, next)) {
+        /*
+         * We don't yet have logic to synchronize EEH state across
+         * multiple containers
+         */
+        container = NULL;
+        goto out;
+    }
+
+out:
+    vfio_put_address_space(space);
+    return container;
+}
+
+bool vfio_eeh_as_ok(AddressSpace *as)
+{
+    VFIOContainer *container = vfio_eeh_as_container(as);
+
+    return (container != NULL) && vfio_eeh_container_ok(container);
+}
+
+int vfio_eeh_as_op(AddressSpace *as, uint32_t op)
+{
+    VFIOContainer *container = vfio_eeh_as_container(as);
+
+    if (!container) {
+        return -ENODEV;
+    }
+    return vfio_eeh_container_op(container, op);
+}
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 3746c9f984..2a6912c940 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -2,6 +2,7 @@ vfio_ss = ss.source_set()
 vfio_ss.add(files(
   'helpers.c',
   'common.c',
+  'container.c',
   'spapr.c',
   'migration.c',
 ))
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 598c3ce079..bb7f9fe9c4 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -33,6 +33,8 @@
 
 #define VFIO_MSG_PREFIX "vfio %s: "
 
+extern const MemoryListener vfio_memory_listener;
+
 enum {
     VFIO_DEVICE_TYPE_PCI = 0,
     VFIO_DEVICE_TYPE_PLATFORM = 1,
@@ -196,6 +198,38 @@ typedef struct VFIODisplay {
     } dmabuf;
 } VFIODisplay;
 
+typedef struct {
+    unsigned long *bitmap;
+    hwaddr size;
+    hwaddr pages;
+} VFIOBitmap;
+
+void vfio_host_win_add(VFIOContainer *container,
+                       hwaddr min_iova, hwaddr max_iova,
+                       uint64_t iova_pgsizes);
+int vfio_host_win_del(VFIOContainer *container, hwaddr min_iova,
+                      hwaddr max_iova);
+VFIOAddressSpace *vfio_get_address_space(AddressSpace *as);
+void vfio_put_address_space(VFIOAddressSpace *space);
+bool vfio_devices_all_running_and_saving(VFIOContainer *container);
+
+/* container->fd */
+VFIODevice *vfio_container_dev_iter_next(VFIOContainer *container,
+                                         VFIODevice *curr);
+int vfio_dma_unmap(VFIOContainer *container, hwaddr iova,
+                   ram_addr_t size, IOMMUTLBEntry *iotlb);
+int vfio_dma_map(VFIOContainer *container, hwaddr iova,
+                 ram_addr_t size, void *vaddr, bool readonly);
+int vfio_set_dirty_page_tracking(VFIOContainer *container, bool start);
+int vfio_query_dirty_bitmap(VFIOContainer *container, VFIOBitmap *vbmap,
+                            hwaddr iova, hwaddr size);
+
+int vfio_container_add_section_window(VFIOContainer *container,
+                                      MemoryRegionSection *section,
+                                      Error **errp);
+void vfio_container_del_section_window(VFIOContainer *container,
+                                       MemoryRegionSection *section);
+
 void vfio_put_base_device(VFIODevice *vbasedev);
 void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
 void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
@@ -220,6 +254,8 @@ struct vfio_device_info *vfio_get_device_info(int fd);
 int vfio_get_device(VFIOGroup *group, const char *name,
                     VFIODevice *vbasedev, Error **errp);
 
+extern int vfio_kvm_device_fd;
+
 int vfio_kvm_device_add_fd(int fd);
 int vfio_kvm_device_del_fd(int fd);
 
@@ -260,4 +296,13 @@ int vfio_spapr_remove_window(VFIOContainer *container,
 bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
 void vfio_migration_exit(VFIODevice *vbasedev);
 
+int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
+bool vfio_devices_all_running_and_mig_active(VFIOContainer *container);
+bool vfio_devices_all_device_dirty_tracking(VFIOContainer *container);
+int vfio_devices_query_dirty_bitmap(VFIOContainer *container,
+                                    VFIOBitmap *vbmap, hwaddr iova,
+                                    hwaddr size);
+int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
+                                 uint64_t size, ram_addr_t ram_addr);
+
 #endif /* HW_VFIO_VFIO_COMMON_H */
-- 
2.34.1


