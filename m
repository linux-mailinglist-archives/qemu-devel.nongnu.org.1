Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3395D81B562
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 12:56:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGHcn-0008UF-KK; Thu, 21 Dec 2023 06:54:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rGHcj-0008Ka-Ri
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 06:53:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rGHci-00083j-6c
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 06:53:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703159635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cuBFWfNNtw64fAJhsw7LPpnb02Jg4XxtbrnhOX0GkdM=;
 b=XxHhyTdJAvCnevw2bi9QvOcxRfUHeVfo34bhkzLb4QvkG1EOV19PxpoWC/4MsTNJ7kvVgj
 Wy4JjlBlcTPp+n/ULplfkwsdRA5k6yR6ZXGP0DnnMxLbRmjrpDPcXuVuO/qNlRxf1DnviF
 4HQWmbDJbyGa1rp2mU5pDnAvULV4/RQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-4dmxgevWP9i2ApDKL-a6fw-1; Thu, 21 Dec 2023 06:53:51 -0500
X-MC-Unique: 4dmxgevWP9i2ApDKL-a6fw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 421808F5DA1;
 Thu, 21 Dec 2023 11:53:50 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F60F40C6EB9;
 Thu, 21 Dec 2023 11:53:48 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Parav Pandit <parav@mellanox.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>,
 si-wei.liu@oracle.com, Zhu Lingshan <lingshan.zhu@intel.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v3 12/14] vdpa: use dev_shared in vdpa_iommu
Date: Thu, 21 Dec 2023 12:53:17 +0100
Message-Id: <20231221115319.3067586-13-eperezma@redhat.com>
In-Reply-To: <20231221115319.3067586-1-eperezma@redhat.com>
References: <20231221115319.3067586-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The memory listener functions can call these too.  Make vdpa_iommu work
with VhostVDPAShared.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
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


