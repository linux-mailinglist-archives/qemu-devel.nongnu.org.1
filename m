Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 470DE7B663E
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 12:18:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qncRj-0007TI-Mh; Tue, 03 Oct 2023 06:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qncRh-0007T9-PM
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 06:16:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qncRe-0004Rp-3n
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 06:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696328161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XDpbe+mOxilwH/vaolTekL6XmlHMpnxDi8ih3JxfguM=;
 b=driCusO3yU4YjPGKUh4RBihsANZx1GalLIu0VddAjQ5alXbw1dnval5BeLltDjPG4gR6hd
 awkZr0fW/gx9k2fcXujvGik425PNkkcOnuKlMk0cHuPrguJCj8qDppPdzVaeZrQl+9aVcz
 FVm/DLKol5bozozh14IDpqdJPvt0jBU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-eFhXNDPOPduqAt8oiUsCEg-1; Tue, 03 Oct 2023 06:15:55 -0400
X-MC-Unique: eFhXNDPOPduqAt8oiUsCEg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3AE188007A4;
 Tue,  3 Oct 2023 10:15:55 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F7A4492B16;
 Tue,  3 Oct 2023 10:15:52 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com, clg@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 peterx@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, mjrosato@linux.ibm.com
Subject: [PATCH v3 03/15] vfio/common: Move IOMMU agnostic helpers to a
 separate file
Date: Tue,  3 Oct 2023 12:14:00 +0200
Message-ID: <20231003101530.288864-4-eric.auger@redhat.com>
In-Reply-To: <20231003101530.288864-1-eric.auger@redhat.com>
References: <20231003101530.288864-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Yi Liu <yi.l.liu@intel.com>

Move low-level iommu agnostic helpers to a separate helpers.c
file. They relate to regions, interrupts, device/region
capabilities and etc.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |   9 +
 hw/vfio/common.c              | 588 --------------------------------
 hw/vfio/helpers.c             | 611 ++++++++++++++++++++++++++++++++++
 hw/vfio/meson.build           |   1 +
 4 files changed, 621 insertions(+), 588 deletions(-)
 create mode 100644 hw/vfio/helpers.c

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index e9b8954595..e0483893d1 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -196,6 +196,12 @@ typedef struct VFIODisplay {
     } dmabuf;
 } VFIODisplay;
 
+typedef struct {
+    unsigned long *bitmap;
+    hwaddr size;
+    hwaddr pages;
+} VFIOBitmap;
+
 void vfio_put_base_device(VFIODevice *vbasedev);
 void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
 void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
@@ -245,6 +251,8 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
                              unsigned int *avail);
 struct vfio_info_cap_header *
 vfio_get_device_info_cap(struct vfio_device_info *info, uint16_t id);
+struct vfio_info_cap_header *
+vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id);
 #endif
 extern const MemoryListener vfio_prereg_listener;
 
@@ -257,4 +265,5 @@ int vfio_spapr_remove_window(VFIOContainer *container,
 bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
 void vfio_migration_exit(VFIODevice *vbasedev);
 
+int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
 #endif /* HW_VFIO_VFIO_COMMON_H */
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 134649226d..4e122fc4e4 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -62,84 +62,6 @@ static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =
 static int vfio_kvm_device_fd = -1;
 #endif
 
-/*
- * Common VFIO interrupt disable
- */
-void vfio_disable_irqindex(VFIODevice *vbasedev, int index)
-{
-    struct vfio_irq_set irq_set = {
-        .argsz = sizeof(irq_set),
-        .flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_TRIGGER,
-        .index = index,
-        .start = 0,
-        .count = 0,
-    };
-
-    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
-}
-
-void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index)
-{
-    struct vfio_irq_set irq_set = {
-        .argsz = sizeof(irq_set),
-        .flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_UNMASK,
-        .index = index,
-        .start = 0,
-        .count = 1,
-    };
-
-    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
-}
-
-void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index)
-{
-    struct vfio_irq_set irq_set = {
-        .argsz = sizeof(irq_set),
-        .flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_MASK,
-        .index = index,
-        .start = 0,
-        .count = 1,
-    };
-
-    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
-}
-
-static inline const char *action_to_str(int action)
-{
-    switch (action) {
-    case VFIO_IRQ_SET_ACTION_MASK:
-        return "MASK";
-    case VFIO_IRQ_SET_ACTION_UNMASK:
-        return "UNMASK";
-    case VFIO_IRQ_SET_ACTION_TRIGGER:
-        return "TRIGGER";
-    default:
-        return "UNKNOWN ACTION";
-    }
-}
-
-static const char *index_to_str(VFIODevice *vbasedev, int index)
-{
-    if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
-        return NULL;
-    }
-
-    switch (index) {
-    case VFIO_PCI_INTX_IRQ_INDEX:
-        return "INTX";
-    case VFIO_PCI_MSI_IRQ_INDEX:
-        return "MSI";
-    case VFIO_PCI_MSIX_IRQ_INDEX:
-        return "MSIX";
-    case VFIO_PCI_ERR_IRQ_INDEX:
-        return "ERR";
-    case VFIO_PCI_REQ_IRQ_INDEX:
-        return "REQ";
-    default:
-        return NULL;
-    }
-}
-
 static int vfio_ram_block_discard_disable(VFIOContainer *container, bool state)
 {
     switch (container->iommu_type) {
@@ -163,183 +85,10 @@ static int vfio_ram_block_discard_disable(VFIOContainer *container, bool state)
     }
 }
 
-int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
-                           int action, int fd, Error **errp)
-{
-    struct vfio_irq_set *irq_set;
-    int argsz, ret = 0;
-    const char *name;
-    int32_t *pfd;
-
-    argsz = sizeof(*irq_set) + sizeof(*pfd);
-
-    irq_set = g_malloc0(argsz);
-    irq_set->argsz = argsz;
-    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD | action;
-    irq_set->index = index;
-    irq_set->start = subindex;
-    irq_set->count = 1;
-    pfd = (int32_t *)&irq_set->data;
-    *pfd = fd;
-
-    if (ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
-        ret = -errno;
-    }
-    g_free(irq_set);
-
-    if (!ret) {
-        return 0;
-    }
-
-    error_setg_errno(errp, -ret, "VFIO_DEVICE_SET_IRQS failure");
-
-    name = index_to_str(vbasedev, index);
-    if (name) {
-        error_prepend(errp, "%s-%d: ", name, subindex);
-    } else {
-        error_prepend(errp, "index %d-%d: ", index, subindex);
-    }
-    error_prepend(errp,
-                  "Failed to %s %s eventfd signaling for interrupt ",
-                  fd < 0 ? "tear down" : "set up", action_to_str(action));
-    return ret;
-}
-
-/*
- * IO Port/MMIO - Beware of the endians, VFIO is always little endian
- */
-void vfio_region_write(void *opaque, hwaddr addr,
-                       uint64_t data, unsigned size)
-{
-    VFIORegion *region = opaque;
-    VFIODevice *vbasedev = region->vbasedev;
-    union {
-        uint8_t byte;
-        uint16_t word;
-        uint32_t dword;
-        uint64_t qword;
-    } buf;
-
-    switch (size) {
-    case 1:
-        buf.byte = data;
-        break;
-    case 2:
-        buf.word = cpu_to_le16(data);
-        break;
-    case 4:
-        buf.dword = cpu_to_le32(data);
-        break;
-    case 8:
-        buf.qword = cpu_to_le64(data);
-        break;
-    default:
-        hw_error("vfio: unsupported write size, %u bytes", size);
-        break;
-    }
-
-    if (pwrite(vbasedev->fd, &buf, size, region->fd_offset + addr) != size) {
-        error_report("%s(%s:region%d+0x%"HWADDR_PRIx", 0x%"PRIx64
-                     ",%d) failed: %m",
-                     __func__, vbasedev->name, region->nr,
-                     addr, data, size);
-    }
-
-    trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size);
-
-    /*
-     * A read or write to a BAR always signals an INTx EOI.  This will
-     * do nothing if not pending (including not in INTx mode).  We assume
-     * that a BAR access is in response to an interrupt and that BAR
-     * accesses will service the interrupt.  Unfortunately, we don't know
-     * which access will service the interrupt, so we're potentially
-     * getting quite a few host interrupts per guest interrupt.
-     */
-    vbasedev->ops->vfio_eoi(vbasedev);
-}
-
-uint64_t vfio_region_read(void *opaque,
-                          hwaddr addr, unsigned size)
-{
-    VFIORegion *region = opaque;
-    VFIODevice *vbasedev = region->vbasedev;
-    union {
-        uint8_t byte;
-        uint16_t word;
-        uint32_t dword;
-        uint64_t qword;
-    } buf;
-    uint64_t data = 0;
-
-    if (pread(vbasedev->fd, &buf, size, region->fd_offset + addr) != size) {
-        error_report("%s(%s:region%d+0x%"HWADDR_PRIx", %d) failed: %m",
-                     __func__, vbasedev->name, region->nr,
-                     addr, size);
-        return (uint64_t)-1;
-    }
-    switch (size) {
-    case 1:
-        data = buf.byte;
-        break;
-    case 2:
-        data = le16_to_cpu(buf.word);
-        break;
-    case 4:
-        data = le32_to_cpu(buf.dword);
-        break;
-    case 8:
-        data = le64_to_cpu(buf.qword);
-        break;
-    default:
-        hw_error("vfio: unsupported read size, %u bytes", size);
-        break;
-    }
-
-    trace_vfio_region_read(vbasedev->name, region->nr, addr, size, data);
-
-    /* Same as write above */
-    vbasedev->ops->vfio_eoi(vbasedev);
-
-    return data;
-}
-
-const MemoryRegionOps vfio_region_ops = {
-    .read = vfio_region_read,
-    .write = vfio_region_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 8,
-    },
-    .impl = {
-        .min_access_size = 1,
-        .max_access_size = 8,
-    },
-};
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
-{
-    vbmap->pages = REAL_HOST_PAGE_ALIGN(size) / qemu_real_host_page_size();
-    vbmap->size = ROUND_UP(vbmap->pages, sizeof(__u64) * BITS_PER_BYTE) /
-                                         BITS_PER_BYTE;
-    vbmap->bitmap = g_try_malloc0(vbmap->size);
-    if (!vbmap->bitmap) {
-        return -ENOMEM;
-    }
-
-    return 0;
-}
-
 static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
                                  uint64_t size, ram_addr_t ram_addr);
 
@@ -1994,30 +1743,6 @@ static void vfio_listener_release(VFIOContainer *container)
     }
 }
 
-static struct vfio_info_cap_header *
-vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id)
-{
-    struct vfio_info_cap_header *hdr;
-
-    for (hdr = ptr + cap_offset; hdr != ptr; hdr = ptr + hdr->next) {
-        if (hdr->id == id) {
-            return hdr;
-        }
-    }
-
-    return NULL;
-}
-
-struct vfio_info_cap_header *
-vfio_get_region_info_cap(struct vfio_region_info *info, uint16_t id)
-{
-    if (!(info->flags & VFIO_REGION_INFO_FLAG_CAPS)) {
-        return NULL;
-    }
-
-    return vfio_get_cap((void *)info, info->cap_offset, id);
-}
-
 static struct vfio_info_cap_header *
 vfio_get_iommu_type1_info_cap(struct vfio_iommu_type1_info *info, uint16_t id)
 {
@@ -2028,16 +1753,6 @@ vfio_get_iommu_type1_info_cap(struct vfio_iommu_type1_info *info, uint16_t id)
     return vfio_get_cap((void *)info, info->cap_offset, id);
 }
 
-struct vfio_info_cap_header *
-vfio_get_device_info_cap(struct vfio_device_info *info, uint16_t id)
-{
-    if (!(info->flags & VFIO_DEVICE_FLAGS_CAPS)) {
-        return NULL;
-    }
-
-    return vfio_get_cap((void *)info, info->cap_offset, id);
-}
-
 bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
                              unsigned int *avail)
 {
@@ -2059,232 +1774,6 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
     return true;
 }
 
-static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
-                                          struct vfio_region_info *info)
-{
-    struct vfio_info_cap_header *hdr;
-    struct vfio_region_info_cap_sparse_mmap *sparse;
-    int i, j;
-
-    hdr = vfio_get_region_info_cap(info, VFIO_REGION_INFO_CAP_SPARSE_MMAP);
-    if (!hdr) {
-        return -ENODEV;
-    }
-
-    sparse = container_of(hdr, struct vfio_region_info_cap_sparse_mmap, header);
-
-    trace_vfio_region_sparse_mmap_header(region->vbasedev->name,
-                                         region->nr, sparse->nr_areas);
-
-    region->mmaps = g_new0(VFIOMmap, sparse->nr_areas);
-
-    for (i = 0, j = 0; i < sparse->nr_areas; i++) {
-        if (sparse->areas[i].size) {
-            trace_vfio_region_sparse_mmap_entry(i, sparse->areas[i].offset,
-                                            sparse->areas[i].offset +
-                                            sparse->areas[i].size - 1);
-            region->mmaps[j].offset = sparse->areas[i].offset;
-            region->mmaps[j].size = sparse->areas[i].size;
-            j++;
-        }
-    }
-
-    region->nr_mmaps = j;
-    region->mmaps = g_realloc(region->mmaps, j * sizeof(VFIOMmap));
-
-    return 0;
-}
-
-int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
-                      int index, const char *name)
-{
-    struct vfio_region_info *info;
-    int ret;
-
-    ret = vfio_get_region_info(vbasedev, index, &info);
-    if (ret) {
-        return ret;
-    }
-
-    region->vbasedev = vbasedev;
-    region->flags = info->flags;
-    region->size = info->size;
-    region->fd_offset = info->offset;
-    region->nr = index;
-
-    if (region->size) {
-        region->mem = g_new0(MemoryRegion, 1);
-        memory_region_init_io(region->mem, obj, &vfio_region_ops,
-                              region, name, region->size);
-
-        if (!vbasedev->no_mmap &&
-            region->flags & VFIO_REGION_INFO_FLAG_MMAP) {
-
-            ret = vfio_setup_region_sparse_mmaps(region, info);
-
-            if (ret) {
-                region->nr_mmaps = 1;
-                region->mmaps = g_new0(VFIOMmap, region->nr_mmaps);
-                region->mmaps[0].offset = 0;
-                region->mmaps[0].size = region->size;
-            }
-        }
-    }
-
-    g_free(info);
-
-    trace_vfio_region_setup(vbasedev->name, index, name,
-                            region->flags, region->fd_offset, region->size);
-    return 0;
-}
-
-static void vfio_subregion_unmap(VFIORegion *region, int index)
-{
-    trace_vfio_region_unmap(memory_region_name(&region->mmaps[index].mem),
-                            region->mmaps[index].offset,
-                            region->mmaps[index].offset +
-                            region->mmaps[index].size - 1);
-    memory_region_del_subregion(region->mem, &region->mmaps[index].mem);
-    munmap(region->mmaps[index].mmap, region->mmaps[index].size);
-    object_unparent(OBJECT(&region->mmaps[index].mem));
-    region->mmaps[index].mmap = NULL;
-}
-
-int vfio_region_mmap(VFIORegion *region)
-{
-    int i, prot = 0;
-    char *name;
-
-    if (!region->mem) {
-        return 0;
-    }
-
-    prot |= region->flags & VFIO_REGION_INFO_FLAG_READ ? PROT_READ : 0;
-    prot |= region->flags & VFIO_REGION_INFO_FLAG_WRITE ? PROT_WRITE : 0;
-
-    for (i = 0; i < region->nr_mmaps; i++) {
-        region->mmaps[i].mmap = mmap(NULL, region->mmaps[i].size, prot,
-                                     MAP_SHARED, region->vbasedev->fd,
-                                     region->fd_offset +
-                                     region->mmaps[i].offset);
-        if (region->mmaps[i].mmap == MAP_FAILED) {
-            int ret = -errno;
-
-            trace_vfio_region_mmap_fault(memory_region_name(region->mem), i,
-                                         region->fd_offset +
-                                         region->mmaps[i].offset,
-                                         region->fd_offset +
-                                         region->mmaps[i].offset +
-                                         region->mmaps[i].size - 1, ret);
-
-            region->mmaps[i].mmap = NULL;
-
-            for (i--; i >= 0; i--) {
-                vfio_subregion_unmap(region, i);
-            }
-
-            return ret;
-        }
-
-        name = g_strdup_printf("%s mmaps[%d]",
-                               memory_region_name(region->mem), i);
-        memory_region_init_ram_device_ptr(&region->mmaps[i].mem,
-                                          memory_region_owner(region->mem),
-                                          name, region->mmaps[i].size,
-                                          region->mmaps[i].mmap);
-        g_free(name);
-        memory_region_add_subregion(region->mem, region->mmaps[i].offset,
-                                    &region->mmaps[i].mem);
-
-        trace_vfio_region_mmap(memory_region_name(&region->mmaps[i].mem),
-                               region->mmaps[i].offset,
-                               region->mmaps[i].offset +
-                               region->mmaps[i].size - 1);
-    }
-
-    return 0;
-}
-
-void vfio_region_unmap(VFIORegion *region)
-{
-    int i;
-
-    if (!region->mem) {
-        return;
-    }
-
-    for (i = 0; i < region->nr_mmaps; i++) {
-        if (region->mmaps[i].mmap) {
-            vfio_subregion_unmap(region, i);
-        }
-    }
-}
-
-void vfio_region_exit(VFIORegion *region)
-{
-    int i;
-
-    if (!region->mem) {
-        return;
-    }
-
-    for (i = 0; i < region->nr_mmaps; i++) {
-        if (region->mmaps[i].mmap) {
-            memory_region_del_subregion(region->mem, &region->mmaps[i].mem);
-        }
-    }
-
-    trace_vfio_region_exit(region->vbasedev->name, region->nr);
-}
-
-void vfio_region_finalize(VFIORegion *region)
-{
-    int i;
-
-    if (!region->mem) {
-        return;
-    }
-
-    for (i = 0; i < region->nr_mmaps; i++) {
-        if (region->mmaps[i].mmap) {
-            munmap(region->mmaps[i].mmap, region->mmaps[i].size);
-            object_unparent(OBJECT(&region->mmaps[i].mem));
-        }
-    }
-
-    object_unparent(OBJECT(region->mem));
-
-    g_free(region->mem);
-    g_free(region->mmaps);
-
-    trace_vfio_region_finalize(region->vbasedev->name, region->nr);
-
-    region->mem = NULL;
-    region->mmaps = NULL;
-    region->nr_mmaps = 0;
-    region->size = 0;
-    region->flags = 0;
-    region->nr = 0;
-}
-
-void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled)
-{
-    int i;
-
-    if (!region->mem) {
-        return;
-    }
-
-    for (i = 0; i < region->nr_mmaps; i++) {
-        if (region->mmaps[i].mmap) {
-            memory_region_set_enabled(&region->mmaps[i].mem, enabled);
-        }
-    }
-
-    trace_vfio_region_mmaps_set_enabled(memory_region_name(region->mem),
-                                        enabled);
-}
-
 void vfio_reset_handler(void *opaque)
 {
     VFIOGroup *group;
@@ -2983,83 +2472,6 @@ void vfio_put_base_device(VFIODevice *vbasedev)
     close(vbasedev->fd);
 }
 
-int vfio_get_region_info(VFIODevice *vbasedev, int index,
-                         struct vfio_region_info **info)
-{
-    size_t argsz = sizeof(struct vfio_region_info);
-
-    *info = g_malloc0(argsz);
-
-    (*info)->index = index;
-retry:
-    (*info)->argsz = argsz;
-
-    if (ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, *info)) {
-        g_free(*info);
-        *info = NULL;
-        return -errno;
-    }
-
-    if ((*info)->argsz > argsz) {
-        argsz = (*info)->argsz;
-        *info = g_realloc(*info, argsz);
-
-        goto retry;
-    }
-
-    return 0;
-}
-
-int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
-                             uint32_t subtype, struct vfio_region_info **info)
-{
-    int i;
-
-    for (i = 0; i < vbasedev->num_regions; i++) {
-        struct vfio_info_cap_header *hdr;
-        struct vfio_region_info_cap_type *cap_type;
-
-        if (vfio_get_region_info(vbasedev, i, info)) {
-            continue;
-        }
-
-        hdr = vfio_get_region_info_cap(*info, VFIO_REGION_INFO_CAP_TYPE);
-        if (!hdr) {
-            g_free(*info);
-            continue;
-        }
-
-        cap_type = container_of(hdr, struct vfio_region_info_cap_type, header);
-
-        trace_vfio_get_dev_region(vbasedev->name, i,
-                                  cap_type->type, cap_type->subtype);
-
-        if (cap_type->type == type && cap_type->subtype == subtype) {
-            return 0;
-        }
-
-        g_free(*info);
-    }
-
-    *info = NULL;
-    return -ENODEV;
-}
-
-bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
-{
-    struct vfio_region_info *info = NULL;
-    bool ret = false;
-
-    if (!vfio_get_region_info(vbasedev, region, &info)) {
-        if (vfio_get_region_info_cap(info, cap_type)) {
-            ret = true;
-        }
-        g_free(info);
-    }
-
-    return ret;
-}
-
 /*
  * Interfaces for IBM EEH (Enhanced Error Handling)
  */
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
new file mode 100644
index 0000000000..717930b9d8
--- /dev/null
+++ b/hw/vfio/helpers.c
@@ -0,0 +1,611 @@
+/*
+ * low level and IOMMU backend agnostic helpers used by VFIO devices,
+ * related to regions, interrupts, capabilities
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
+
+#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio.h"
+#include "hw/hw.h"
+#include "trace.h"
+#include "qapi/error.h"
+
+/*
+ * Common VFIO interrupt disable
+ */
+void vfio_disable_irqindex(VFIODevice *vbasedev, int index)
+{
+    struct vfio_irq_set irq_set = {
+        .argsz = sizeof(irq_set),
+        .flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_TRIGGER,
+        .index = index,
+        .start = 0,
+        .count = 0,
+    };
+
+    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
+}
+
+void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index)
+{
+    struct vfio_irq_set irq_set = {
+        .argsz = sizeof(irq_set),
+        .flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_UNMASK,
+        .index = index,
+        .start = 0,
+        .count = 1,
+    };
+
+    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
+}
+
+void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index)
+{
+    struct vfio_irq_set irq_set = {
+        .argsz = sizeof(irq_set),
+        .flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_MASK,
+        .index = index,
+        .start = 0,
+        .count = 1,
+    };
+
+    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
+}
+
+static inline const char *action_to_str(int action)
+{
+    switch (action) {
+    case VFIO_IRQ_SET_ACTION_MASK:
+        return "MASK";
+    case VFIO_IRQ_SET_ACTION_UNMASK:
+        return "UNMASK";
+    case VFIO_IRQ_SET_ACTION_TRIGGER:
+        return "TRIGGER";
+    default:
+        return "UNKNOWN ACTION";
+    }
+}
+
+static const char *index_to_str(VFIODevice *vbasedev, int index)
+{
+    if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
+        return NULL;
+    }
+
+    switch (index) {
+    case VFIO_PCI_INTX_IRQ_INDEX:
+        return "INTX";
+    case VFIO_PCI_MSI_IRQ_INDEX:
+        return "MSI";
+    case VFIO_PCI_MSIX_IRQ_INDEX:
+        return "MSIX";
+    case VFIO_PCI_ERR_IRQ_INDEX:
+        return "ERR";
+    case VFIO_PCI_REQ_IRQ_INDEX:
+        return "REQ";
+    default:
+        return NULL;
+    }
+}
+
+int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
+                           int action, int fd, Error **errp)
+{
+    struct vfio_irq_set *irq_set;
+    int argsz, ret = 0;
+    const char *name;
+    int32_t *pfd;
+
+    argsz = sizeof(*irq_set) + sizeof(*pfd);
+
+    irq_set = g_malloc0(argsz);
+    irq_set->argsz = argsz;
+    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD | action;
+    irq_set->index = index;
+    irq_set->start = subindex;
+    irq_set->count = 1;
+    pfd = (int32_t *)&irq_set->data;
+    *pfd = fd;
+
+    if (ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
+        ret = -errno;
+    }
+    g_free(irq_set);
+
+    if (!ret) {
+        return 0;
+    }
+
+    error_setg_errno(errp, -ret, "VFIO_DEVICE_SET_IRQS failure");
+
+    name = index_to_str(vbasedev, index);
+    if (name) {
+        error_prepend(errp, "%s-%d: ", name, subindex);
+    } else {
+        error_prepend(errp, "index %d-%d: ", index, subindex);
+    }
+    error_prepend(errp,
+                  "Failed to %s %s eventfd signaling for interrupt ",
+                  fd < 0 ? "tear down" : "set up", action_to_str(action));
+    return ret;
+}
+
+/*
+ * IO Port/MMIO - Beware of the endians, VFIO is always little endian
+ */
+void vfio_region_write(void *opaque, hwaddr addr,
+                       uint64_t data, unsigned size)
+{
+    VFIORegion *region = opaque;
+    VFIODevice *vbasedev = region->vbasedev;
+    union {
+        uint8_t byte;
+        uint16_t word;
+        uint32_t dword;
+        uint64_t qword;
+    } buf;
+
+    switch (size) {
+    case 1:
+        buf.byte = data;
+        break;
+    case 2:
+        buf.word = cpu_to_le16(data);
+        break;
+    case 4:
+        buf.dword = cpu_to_le32(data);
+        break;
+    case 8:
+        buf.qword = cpu_to_le64(data);
+        break;
+    default:
+        hw_error("vfio: unsupported write size, %u bytes", size);
+        break;
+    }
+
+    if (pwrite(vbasedev->fd, &buf, size, region->fd_offset + addr) != size) {
+        error_report("%s(%s:region%d+0x%"HWADDR_PRIx", 0x%"PRIx64
+                     ",%d) failed: %m",
+                     __func__, vbasedev->name, region->nr,
+                     addr, data, size);
+    }
+
+    trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size);
+
+    /*
+     * A read or write to a BAR always signals an INTx EOI.  This will
+     * do nothing if not pending (including not in INTx mode).  We assume
+     * that a BAR access is in response to an interrupt and that BAR
+     * accesses will service the interrupt.  Unfortunately, we don't know
+     * which access will service the interrupt, so we're potentially
+     * getting quite a few host interrupts per guest interrupt.
+     */
+    vbasedev->ops->vfio_eoi(vbasedev);
+}
+
+uint64_t vfio_region_read(void *opaque,
+                          hwaddr addr, unsigned size)
+{
+    VFIORegion *region = opaque;
+    VFIODevice *vbasedev = region->vbasedev;
+    union {
+        uint8_t byte;
+        uint16_t word;
+        uint32_t dword;
+        uint64_t qword;
+    } buf;
+    uint64_t data = 0;
+
+    if (pread(vbasedev->fd, &buf, size, region->fd_offset + addr) != size) {
+        error_report("%s(%s:region%d+0x%"HWADDR_PRIx", %d) failed: %m",
+                     __func__, vbasedev->name, region->nr,
+                     addr, size);
+        return (uint64_t)-1;
+    }
+    switch (size) {
+    case 1:
+        data = buf.byte;
+        break;
+    case 2:
+        data = le16_to_cpu(buf.word);
+        break;
+    case 4:
+        data = le32_to_cpu(buf.dword);
+        break;
+    case 8:
+        data = le64_to_cpu(buf.qword);
+        break;
+    default:
+        hw_error("vfio: unsupported read size, %u bytes", size);
+        break;
+    }
+
+    trace_vfio_region_read(vbasedev->name, region->nr, addr, size, data);
+
+    /* Same as write above */
+    vbasedev->ops->vfio_eoi(vbasedev);
+
+    return data;
+}
+
+const MemoryRegionOps vfio_region_ops = {
+    .read = vfio_region_read,
+    .write = vfio_region_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
+};
+
+int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size)
+{
+    vbmap->pages = REAL_HOST_PAGE_ALIGN(size) / qemu_real_host_page_size();
+    vbmap->size = ROUND_UP(vbmap->pages, sizeof(__u64) * BITS_PER_BYTE) /
+                                         BITS_PER_BYTE;
+    vbmap->bitmap = g_try_malloc0(vbmap->size);
+    if (!vbmap->bitmap) {
+        return -ENOMEM;
+    }
+
+    return 0;
+}
+
+struct vfio_info_cap_header *
+vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id)
+{
+    struct vfio_info_cap_header *hdr;
+
+    for (hdr = ptr + cap_offset; hdr != ptr; hdr = ptr + hdr->next) {
+        if (hdr->id == id) {
+            return hdr;
+        }
+    }
+
+    return NULL;
+}
+
+struct vfio_info_cap_header *
+vfio_get_region_info_cap(struct vfio_region_info *info, uint16_t id)
+{
+    if (!(info->flags & VFIO_REGION_INFO_FLAG_CAPS)) {
+        return NULL;
+    }
+
+    return vfio_get_cap((void *)info, info->cap_offset, id);
+}
+
+struct vfio_info_cap_header *
+vfio_get_device_info_cap(struct vfio_device_info *info, uint16_t id)
+{
+    if (!(info->flags & VFIO_DEVICE_FLAGS_CAPS)) {
+        return NULL;
+    }
+
+    return vfio_get_cap((void *)info, info->cap_offset, id);
+}
+
+static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
+                                          struct vfio_region_info *info)
+{
+    struct vfio_info_cap_header *hdr;
+    struct vfio_region_info_cap_sparse_mmap *sparse;
+    int i, j;
+
+    hdr = vfio_get_region_info_cap(info, VFIO_REGION_INFO_CAP_SPARSE_MMAP);
+    if (!hdr) {
+        return -ENODEV;
+    }
+
+    sparse = container_of(hdr, struct vfio_region_info_cap_sparse_mmap, header);
+
+    trace_vfio_region_sparse_mmap_header(region->vbasedev->name,
+                                         region->nr, sparse->nr_areas);
+
+    region->mmaps = g_new0(VFIOMmap, sparse->nr_areas);
+
+    for (i = 0, j = 0; i < sparse->nr_areas; i++) {
+        if (sparse->areas[i].size) {
+            trace_vfio_region_sparse_mmap_entry(i, sparse->areas[i].offset,
+                                            sparse->areas[i].offset +
+                                            sparse->areas[i].size - 1);
+            region->mmaps[j].offset = sparse->areas[i].offset;
+            region->mmaps[j].size = sparse->areas[i].size;
+            j++;
+        }
+    }
+
+    region->nr_mmaps = j;
+    region->mmaps = g_realloc(region->mmaps, j * sizeof(VFIOMmap));
+
+    return 0;
+}
+
+int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
+                      int index, const char *name)
+{
+    struct vfio_region_info *info;
+    int ret;
+
+    ret = vfio_get_region_info(vbasedev, index, &info);
+    if (ret) {
+        return ret;
+    }
+
+    region->vbasedev = vbasedev;
+    region->flags = info->flags;
+    region->size = info->size;
+    region->fd_offset = info->offset;
+    region->nr = index;
+
+    if (region->size) {
+        region->mem = g_new0(MemoryRegion, 1);
+        memory_region_init_io(region->mem, obj, &vfio_region_ops,
+                              region, name, region->size);
+
+        if (!vbasedev->no_mmap &&
+            region->flags & VFIO_REGION_INFO_FLAG_MMAP) {
+
+            ret = vfio_setup_region_sparse_mmaps(region, info);
+
+            if (ret) {
+                region->nr_mmaps = 1;
+                region->mmaps = g_new0(VFIOMmap, region->nr_mmaps);
+                region->mmaps[0].offset = 0;
+                region->mmaps[0].size = region->size;
+            }
+        }
+    }
+
+    g_free(info);
+
+    trace_vfio_region_setup(vbasedev->name, index, name,
+                            region->flags, region->fd_offset, region->size);
+    return 0;
+}
+
+static void vfio_subregion_unmap(VFIORegion *region, int index)
+{
+    trace_vfio_region_unmap(memory_region_name(&region->mmaps[index].mem),
+                            region->mmaps[index].offset,
+                            region->mmaps[index].offset +
+                            region->mmaps[index].size - 1);
+    memory_region_del_subregion(region->mem, &region->mmaps[index].mem);
+    munmap(region->mmaps[index].mmap, region->mmaps[index].size);
+    object_unparent(OBJECT(&region->mmaps[index].mem));
+    region->mmaps[index].mmap = NULL;
+}
+
+int vfio_region_mmap(VFIORegion *region)
+{
+    int i, prot = 0;
+    char *name;
+
+    if (!region->mem) {
+        return 0;
+    }
+
+    prot |= region->flags & VFIO_REGION_INFO_FLAG_READ ? PROT_READ : 0;
+    prot |= region->flags & VFIO_REGION_INFO_FLAG_WRITE ? PROT_WRITE : 0;
+
+    for (i = 0; i < region->nr_mmaps; i++) {
+        region->mmaps[i].mmap = mmap(NULL, region->mmaps[i].size, prot,
+                                     MAP_SHARED, region->vbasedev->fd,
+                                     region->fd_offset +
+                                     region->mmaps[i].offset);
+        if (region->mmaps[i].mmap == MAP_FAILED) {
+            int ret = -errno;
+
+            trace_vfio_region_mmap_fault(memory_region_name(region->mem), i,
+                                         region->fd_offset +
+                                         region->mmaps[i].offset,
+                                         region->fd_offset +
+                                         region->mmaps[i].offset +
+                                         region->mmaps[i].size - 1, ret);
+
+            region->mmaps[i].mmap = NULL;
+
+            for (i--; i >= 0; i--) {
+                vfio_subregion_unmap(region, i);
+            }
+
+            return ret;
+        }
+
+        name = g_strdup_printf("%s mmaps[%d]",
+                               memory_region_name(region->mem), i);
+        memory_region_init_ram_device_ptr(&region->mmaps[i].mem,
+                                          memory_region_owner(region->mem),
+                                          name, region->mmaps[i].size,
+                                          region->mmaps[i].mmap);
+        g_free(name);
+        memory_region_add_subregion(region->mem, region->mmaps[i].offset,
+                                    &region->mmaps[i].mem);
+
+        trace_vfio_region_mmap(memory_region_name(&region->mmaps[i].mem),
+                               region->mmaps[i].offset,
+                               region->mmaps[i].offset +
+                               region->mmaps[i].size - 1);
+    }
+
+    return 0;
+}
+
+void vfio_region_unmap(VFIORegion *region)
+{
+    int i;
+
+    if (!region->mem) {
+        return;
+    }
+
+    for (i = 0; i < region->nr_mmaps; i++) {
+        if (region->mmaps[i].mmap) {
+            vfio_subregion_unmap(region, i);
+        }
+    }
+}
+
+void vfio_region_exit(VFIORegion *region)
+{
+    int i;
+
+    if (!region->mem) {
+        return;
+    }
+
+    for (i = 0; i < region->nr_mmaps; i++) {
+        if (region->mmaps[i].mmap) {
+            memory_region_del_subregion(region->mem, &region->mmaps[i].mem);
+        }
+    }
+
+    trace_vfio_region_exit(region->vbasedev->name, region->nr);
+}
+
+void vfio_region_finalize(VFIORegion *region)
+{
+    int i;
+
+    if (!region->mem) {
+        return;
+    }
+
+    for (i = 0; i < region->nr_mmaps; i++) {
+        if (region->mmaps[i].mmap) {
+            munmap(region->mmaps[i].mmap, region->mmaps[i].size);
+            object_unparent(OBJECT(&region->mmaps[i].mem));
+        }
+    }
+
+    object_unparent(OBJECT(region->mem));
+
+    g_free(region->mem);
+    g_free(region->mmaps);
+
+    trace_vfio_region_finalize(region->vbasedev->name, region->nr);
+
+    region->mem = NULL;
+    region->mmaps = NULL;
+    region->nr_mmaps = 0;
+    region->size = 0;
+    region->flags = 0;
+    region->nr = 0;
+}
+
+void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled)
+{
+    int i;
+
+    if (!region->mem) {
+        return;
+    }
+
+    for (i = 0; i < region->nr_mmaps; i++) {
+        if (region->mmaps[i].mmap) {
+            memory_region_set_enabled(&region->mmaps[i].mem, enabled);
+        }
+    }
+
+    trace_vfio_region_mmaps_set_enabled(memory_region_name(region->mem),
+                                        enabled);
+}
+
+int vfio_get_region_info(VFIODevice *vbasedev, int index,
+                         struct vfio_region_info **info)
+{
+    size_t argsz = sizeof(struct vfio_region_info);
+
+    *info = g_malloc0(argsz);
+
+    (*info)->index = index;
+retry:
+    (*info)->argsz = argsz;
+
+    if (ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, *info)) {
+        g_free(*info);
+        *info = NULL;
+        return -errno;
+    }
+
+    if ((*info)->argsz > argsz) {
+        argsz = (*info)->argsz;
+        *info = g_realloc(*info, argsz);
+
+        goto retry;
+    }
+
+    return 0;
+}
+
+int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
+                             uint32_t subtype, struct vfio_region_info **info)
+{
+    int i;
+
+    for (i = 0; i < vbasedev->num_regions; i++) {
+        struct vfio_info_cap_header *hdr;
+        struct vfio_region_info_cap_type *cap_type;
+
+        if (vfio_get_region_info(vbasedev, i, info)) {
+            continue;
+        }
+
+        hdr = vfio_get_region_info_cap(*info, VFIO_REGION_INFO_CAP_TYPE);
+        if (!hdr) {
+            g_free(*info);
+            continue;
+        }
+
+        cap_type = container_of(hdr, struct vfio_region_info_cap_type, header);
+
+        trace_vfio_get_dev_region(vbasedev->name, i,
+                                  cap_type->type, cap_type->subtype);
+
+        if (cap_type->type == type && cap_type->subtype == subtype) {
+            return 0;
+        }
+
+        g_free(*info);
+    }
+
+    *info = NULL;
+    return -ENODEV;
+}
+
+bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
+{
+    struct vfio_region_info *info = NULL;
+    bool ret = false;
+
+    if (!vfio_get_region_info(vbasedev, region, &info)) {
+        if (vfio_get_region_info_cap(info, cap_type)) {
+            ret = true;
+        }
+        g_free(info);
+    }
+
+    return ret;
+}
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index da9af297a0..3746c9f984 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -1,5 +1,6 @@
 vfio_ss = ss.source_set()
 vfio_ss.add(files(
+  'helpers.c',
   'common.c',
   'spapr.c',
   'migration.c',
-- 
2.41.0


