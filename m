Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CB37CFCE1
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 16:36:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtU7p-0006qD-2k; Thu, 19 Oct 2023 10:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qtU7n-0006pm-5e
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:35:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qtU7l-0000Nj-Kh
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697726144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1y/1WSiwgGjE4QfLcAwvPLiOL/6iLsgZkANLHblLYmU=;
 b=Vr0k0zUfFPI4Zl8v3XIiW2sao1tcQrIT2NS9NOpxSX/l37B69QlATriuSMZRJ8RgdT4jA+
 Y5UlVNpbu+P5bFGR4tX86X6GsqvOlTz68imbOhq9iP1oyx0ynpN2eAUjvQGuuOyHup2Kv3
 AP++8/mNN38YdUVZnUa8qdm5U4qI5Gc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-DYOsSDZoN8SWHhdIGOJxvQ-1; Thu, 19 Oct 2023 10:35:31 -0400
X-MC-Unique: DYOsSDZoN8SWHhdIGOJxvQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70F213816B41;
 Thu, 19 Oct 2023 14:35:29 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.192.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38417C15BB8;
 Thu, 19 Oct 2023 14:35:27 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Shannon <shannon.nelson@amd.com>, Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, yin31149@gmail.com,
 Jason Wang <jasowang@redhat.com>, Yajun Wu <yajunw@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Lei Yang <leiyang@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, si-wei.liu@oracle.com,
 Gautam Dawar <gdawar@xilinx.com>
Subject: [RFC PATCH 12/18] vdpa: use dev_shared in vdpa_iommu
Date: Thu, 19 Oct 2023 16:34:49 +0200
Message-Id: <20231019143455.2377694-13-eperezma@redhat.com>
In-Reply-To: <20231019143455.2377694-1-eperezma@redhat.com>
References: <20231019143455.2377694-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The memory listener functions can call these too.  Make vdpa_iommu work
with VhostVDPAShared.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h |  2 +-
 hw/virtio/vhost-vdpa.c         | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 705c754776..2abee2164a 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -75,7 +75,7 @@ int vhost_vdpa_dma_unmap(VhostVDPAShared *s, uint32_t asid, hwaddr iova,
                          hwaddr size);
 
 typedef struct vdpa_iommu {
-    struct vhost_vdpa *dev;
+    VhostVDPAShared *dev_shared;
     IOMMUMemoryRegion *iommu_mr;
     hwaddr iommu_offset;
     IOMMUNotifier n;
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 0ed6550aad..61553ad196 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -199,7 +199,7 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     struct vdpa_iommu *iommu = container_of(n, struct vdpa_iommu, n);
 
     hwaddr iova = iotlb->iova + iommu->iommu_offset;
-    struct vhost_vdpa *v = iommu->dev;
+    VhostVDPAShared *s = iommu->dev_shared;
     void *vaddr;
     int ret;
     Int128 llend;
@@ -212,10 +212,10 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     RCU_READ_LOCK_GUARD();
     /* check if RAM section out of device range */
     llend = int128_add(int128_makes64(iotlb->addr_mask), int128_makes64(iova));
-    if (int128_gt(llend, int128_make64(v->shared->iova_range.last))) {
+    if (int128_gt(llend, int128_make64(s->iova_range.last))) {
         error_report("RAM section out of device range (max=0x%" PRIx64
                      ", end addr=0x%" PRIx64 ")",
-                     v->shared->iova_range.last, int128_get64(llend));
+                     s->iova_range.last, int128_get64(llend));
         return;
     }
 
@@ -225,20 +225,20 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
         if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL)) {
             return;
         }
-        ret = vhost_vdpa_dma_map(v->shared, VHOST_VDPA_GUEST_PA_ASID, iova,
+        ret = vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_ASID, iova,
                                  iotlb->addr_mask + 1, vaddr, read_only);
         if (ret) {
             error_report("vhost_vdpa_dma_map(%p, 0x%" HWADDR_PRIx ", "
                          "0x%" HWADDR_PRIx ", %p) = %d (%m)",
-                         v, iova, iotlb->addr_mask + 1, vaddr, ret);
+                         s, iova, iotlb->addr_mask + 1, vaddr, ret);
         }
     } else {
-        ret = vhost_vdpa_dma_unmap(v->shared, VHOST_VDPA_GUEST_PA_ASID, iova,
+        ret = vhost_vdpa_dma_unmap(s, VHOST_VDPA_GUEST_PA_ASID, iova,
                                    iotlb->addr_mask + 1);
         if (ret) {
             error_report("vhost_vdpa_dma_unmap(%p, 0x%" HWADDR_PRIx ", "
                          "0x%" HWADDR_PRIx ") = %d (%m)",
-                         v, iova, iotlb->addr_mask + 1, ret);
+                         s, iova, iotlb->addr_mask + 1, ret);
         }
     }
 }
@@ -270,7 +270,7 @@ static void vhost_vdpa_iommu_region_add(MemoryListener *listener,
                         iommu_idx);
     iommu->iommu_offset = section->offset_within_address_space -
                           section->offset_within_region;
-    iommu->dev = v;
+    iommu->dev_shared = v->shared;
 
     ret = memory_region_register_iommu_notifier(section->mr, &iommu->n, NULL);
     if (ret) {
-- 
2.39.3


