Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD5D709AB1
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:58:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01TD-0005LG-Of; Fri, 19 May 2023 10:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Sy-0004vE-UP
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:52:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Sh-0003iT-VO
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8bazluS/HWGCkbOQX31x8muj323D+ZTb5+7E+xu4F88=;
 b=ETLkk21GhejurhWmLhdzsFdp+E3f3ySO5TVz58bx5dLs0yLbSpcEhhIpR3FxmF5/YXUsN9
 JVBBShYOxr+f8zevPNVE22v34Vz8KGJNWv6xMvu2jw2e1NK4PUPNOg2dI7tDm//DcgykTX
 f/EEdLdXxTIMoCPfHHqZ+I8gdyCi/g8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-9zan63QoNfWkFAFbPWzoCg-1; Fri, 19 May 2023 10:52:04 -0400
X-MC-Unique: 9zan63QoNfWkFAFbPWzoCg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4f3932e595dso2264000e87.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507922; x=1687099922;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8bazluS/HWGCkbOQX31x8muj323D+ZTb5+7E+xu4F88=;
 b=OwyNhGU6gfOheAvA0Hq+76sYsyM03p4ZmUuVn3kLiqLpwKMiA2yKA10adrx0K6aLD+
 2sV7PfY7KAxnefpt30ojESFT/NGrPbdP2K/wt0JEJ/85JZ8Gy8fiqVfY3tL2IsTqCS5P
 d/++3J53gx5LUWGcY/dLyRoYa37fYTw2+3SGpd59DKwPkPEdoW6ljfi0yY5OWyBh9A4i
 s/tKHINkwILeNgwNXJz9t33sSi0j025JZdazkTp0BKKQJSwooJFwk3L5/tFKWGBs7pra
 57cSZnmC/pK90rlnilN/1HnEnWCtmSz7vA/1WZDFI4zV3TgneDoryc1lbXqXwk7/dfp3
 fp2w==
X-Gm-Message-State: AC+VfDxm0vmPYMDYdAcKdXXphXKZDAOMed9MQNPibesk5xR20jerlRA8
 2qVTckE1IPCPp9PSm66WTpq41PnpGQlug7MEymdcipyGsWWmn9ohSUr+t1BC1DcfPt+GvBj5X/4
 M+zvS6AHAakd0vem+qym7ljxF1ECxCPHjqwqbJqQYvyfqkNir+jbuX7Vxd3PGr5/De5uv
X-Received: by 2002:ac2:519c:0:b0:4ef:efb5:bfea with SMTP id
 u28-20020ac2519c000000b004efefb5bfeamr961878lfi.37.1684507922447; 
 Fri, 19 May 2023 07:52:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5UjaVs2fb1/YyD0KUCqFlopXZQZrUjQNDdd+XgpifaFzMHS2W+babVZidWXjBqa+tTLWNCXA==
X-Received: by 2002:ac2:519c:0:b0:4ef:efb5:bfea with SMTP id
 u28-20020ac2519c000000b004efefb5bfeamr961868lfi.37.1684507922109; 
 Fri, 19 May 2023 07:52:02 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 w25-20020a05651204d900b004f37ae2e718sm634075lfq.3.2023.05.19.07.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:52:01 -0700 (PDT)
Date: Fri, 19 May 2023 10:51:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Cindy Lu <lulu@redhat.com>
Subject: [PULL 27/40] vhost-vdpa: Add support for vIOMMU.
Message-ID: <bc7b0cac7bf41f24ceb84a03b491f93c378529a4.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Cindy Lu <lulu@redhat.com>

1. The vIOMMU support will make vDPA can work in IOMMU mode. This
will fix security issues while using the no-IOMMU mode.
To support this feature we need to add new functions for IOMMU MR adds and
deletes.

Also since the SVQ does not support vIOMMU yet, add the check for IOMMU
in vhost_vdpa_dev_start, if the SVQ and IOMMU enable at the same time
the function will return fail.

2. Skip the iova_max check vhost_vdpa_listener_skipped_section(). While
MR is IOMMU, move this check to vhost_vdpa_iommu_map_notify()

Verified in vp_vdpa and vdpa_sim_net driver

Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20230510054631.2951812-5-lulu@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h |  11 +++
 hw/virtio/vhost-vdpa.c         | 145 +++++++++++++++++++++++++++++++--
 2 files changed, 149 insertions(+), 7 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index c278a2a8de..e64bfc7f98 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -52,6 +52,8 @@ typedef struct vhost_vdpa {
     struct vhost_dev *dev;
     Error *migration_blocker;
     VhostVDPAHostNotifier notifier[VIRTIO_QUEUE_MAX];
+    QLIST_HEAD(, vdpa_iommu) iommu_list;
+    IOMMUNotifier n;
 } VhostVDPA;
 
 int vhost_vdpa_get_iova_range(int fd, struct vhost_vdpa_iova_range *iova_range);
@@ -61,4 +63,13 @@ int vhost_vdpa_dma_map(struct vhost_vdpa *v, uint32_t asid, hwaddr iova,
 int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, uint32_t asid, hwaddr iova,
                          hwaddr size);
 
+typedef struct vdpa_iommu {
+    struct vhost_vdpa *dev;
+    IOMMUMemoryRegion *iommu_mr;
+    hwaddr iommu_offset;
+    IOMMUNotifier n;
+    QLIST_ENTRY(vdpa_iommu) iommu_next;
+} VDPAIOMMUState;
+
+
 #endif
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 0c8c37e786..b3094e8a8b 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -26,6 +26,7 @@
 #include "cpu.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "hw/virtio/virtio-access.h"
 
 /*
  * Return one past the end of the end of section. Be careful with uint64_t
@@ -60,13 +61,21 @@ static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *section,
                      iova_min, section->offset_within_address_space);
         return true;
     }
+    /*
+     * While using vIOMMU, sometimes the section will be larger than iova_max,
+     * but the memory that actually maps is smaller, so move the check to
+     * function vhost_vdpa_iommu_map_notify(). That function will use the actual
+     * size that maps to the kernel
+     */
 
-    llend = vhost_vdpa_section_end(section);
-    if (int128_gt(llend, int128_make64(iova_max))) {
-        error_report("RAM section out of device range (max=0x%" PRIx64
-                     ", end addr=0x%" PRIx64 ")",
-                     iova_max, int128_get64(llend));
-        return true;
+    if (!memory_region_is_iommu(section->mr)) {
+        llend = vhost_vdpa_section_end(section);
+        if (int128_gt(llend, int128_make64(iova_max))) {
+            error_report("RAM section out of device range (max=0x%" PRIx64
+                         ", end addr=0x%" PRIx64 ")",
+                         iova_max, int128_get64(llend));
+            return true;
+        }
     }
 
     return false;
@@ -185,6 +194,115 @@ static void vhost_vdpa_listener_commit(MemoryListener *listener)
     v->iotlb_batch_begin_sent = false;
 }
 
+static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
+{
+    struct vdpa_iommu *iommu = container_of(n, struct vdpa_iommu, n);
+
+    hwaddr iova = iotlb->iova + iommu->iommu_offset;
+    struct vhost_vdpa *v = iommu->dev;
+    void *vaddr;
+    int ret;
+    Int128 llend;
+
+    if (iotlb->target_as != &address_space_memory) {
+        error_report("Wrong target AS \"%s\", only system memory is allowed",
+                     iotlb->target_as->name ? iotlb->target_as->name : "none");
+        return;
+    }
+    RCU_READ_LOCK_GUARD();
+    /* check if RAM section out of device range */
+    llend = int128_add(int128_makes64(iotlb->addr_mask), int128_makes64(iova));
+    if (int128_gt(llend, int128_make64(v->iova_range.last))) {
+        error_report("RAM section out of device range (max=0x%" PRIx64
+                     ", end addr=0x%" PRIx64 ")",
+                     v->iova_range.last, int128_get64(llend));
+        return;
+    }
+
+    if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
+        bool read_only;
+
+        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL)) {
+            return;
+        }
+        ret = vhost_vdpa_dma_map(v, VHOST_VDPA_GUEST_PA_ASID, iova,
+                                 iotlb->addr_mask + 1, vaddr, read_only);
+        if (ret) {
+            error_report("vhost_vdpa_dma_map(%p, 0x%" HWADDR_PRIx ", "
+                         "0x%" HWADDR_PRIx ", %p) = %d (%m)",
+                         v, iova, iotlb->addr_mask + 1, vaddr, ret);
+        }
+    } else {
+        ret = vhost_vdpa_dma_unmap(v, VHOST_VDPA_GUEST_PA_ASID, iova,
+                                   iotlb->addr_mask + 1);
+        if (ret) {
+            error_report("vhost_vdpa_dma_unmap(%p, 0x%" HWADDR_PRIx ", "
+                         "0x%" HWADDR_PRIx ") = %d (%m)",
+                         v, iova, iotlb->addr_mask + 1, ret);
+        }
+    }
+}
+
+static void vhost_vdpa_iommu_region_add(MemoryListener *listener,
+                                        MemoryRegionSection *section)
+{
+    struct vhost_vdpa *v = container_of(listener, struct vhost_vdpa, listener);
+
+    struct vdpa_iommu *iommu;
+    Int128 end;
+    int iommu_idx;
+    IOMMUMemoryRegion *iommu_mr;
+    int ret;
+
+    iommu_mr = IOMMU_MEMORY_REGION(section->mr);
+
+    iommu = g_malloc0(sizeof(*iommu));
+    end = int128_add(int128_make64(section->offset_within_region),
+                     section->size);
+    end = int128_sub(end, int128_one());
+    iommu_idx = memory_region_iommu_attrs_to_index(iommu_mr,
+                                                   MEMTXATTRS_UNSPECIFIED);
+    iommu->iommu_mr = iommu_mr;
+    iommu_notifier_init(&iommu->n, vhost_vdpa_iommu_map_notify,
+                        IOMMU_NOTIFIER_IOTLB_EVENTS,
+                        section->offset_within_region,
+                        int128_get64(end),
+                        iommu_idx);
+    iommu->iommu_offset = section->offset_within_address_space -
+                          section->offset_within_region;
+    iommu->dev = v;
+
+    ret = memory_region_register_iommu_notifier(section->mr, &iommu->n, NULL);
+    if (ret) {
+        g_free(iommu);
+        return;
+    }
+
+    QLIST_INSERT_HEAD(&v->iommu_list, iommu, iommu_next);
+    memory_region_iommu_replay(iommu->iommu_mr, &iommu->n);
+
+    return;
+}
+
+static void vhost_vdpa_iommu_region_del(MemoryListener *listener,
+                                        MemoryRegionSection *section)
+{
+    struct vhost_vdpa *v = container_of(listener, struct vhost_vdpa, listener);
+
+    struct vdpa_iommu *iommu;
+
+    QLIST_FOREACH(iommu, &v->iommu_list, iommu_next)
+    {
+        if (MEMORY_REGION(iommu->iommu_mr) == section->mr &&
+            iommu->n.start == section->offset_within_region) {
+            memory_region_unregister_iommu_notifier(section->mr, &iommu->n);
+            QLIST_REMOVE(iommu, iommu_next);
+            g_free(iommu);
+            break;
+        }
+    }
+}
+
 static void vhost_vdpa_listener_region_add(MemoryListener *listener,
                                            MemoryRegionSection *section)
 {
@@ -199,6 +317,10 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
                                             v->iova_range.last)) {
         return;
     }
+    if (memory_region_is_iommu(section->mr)) {
+        vhost_vdpa_iommu_region_add(listener, section);
+        return;
+    }
 
     if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_MASK) !=
                  (section->offset_within_region & ~TARGET_PAGE_MASK))) {
@@ -278,6 +400,9 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
                                             v->iova_range.last)) {
         return;
     }
+    if (memory_region_is_iommu(section->mr)) {
+        vhost_vdpa_iommu_region_del(listener, section);
+    }
 
     if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_MASK) !=
                  (section->offset_within_region & ~TARGET_PAGE_MASK))) {
@@ -1182,7 +1307,13 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
     }
 
     if (started) {
-        memory_listener_register(&v->listener, &address_space_memory);
+        if (vhost_dev_has_iommu(dev) && (v->shadow_vqs_enabled)) {
+            error_report("SVQ can not work while IOMMU enable, please disable"
+                         "IOMMU and try again");
+            return -1;
+        }
+        memory_listener_register(&v->listener, dev->vdev->dma_as);
+
         return vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
     }
 
-- 
MST


