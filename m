Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A9881E660
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 10:27:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI3gq-00051B-CN; Tue, 26 Dec 2023 04:25:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3gn-0004sO-MS
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:25:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3gl-0000HP-Gw
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703582726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o0S1EGWalT9mc5fSDPitMMFcpDcP6GvPJwnq9hG5/c8=;
 b=iB5B6yVMC908Hx7/toOvo22cShvU4F7U41HkQvvK1Ls+xMvIepUvspzM20TECxgPozx6kx
 LJXOL+byy7KKXaZRfXyAadEXIrWv7HMXUl/F9VeOu0nblDpdSNmJBR3/LrCn+4AZP9G5E+
 SdtXTg6NSY/AoS13cp30AyR24wl7j98=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-UTP067Z0OkCrCqtG7tF1pA-1; Tue, 26 Dec 2023 04:25:24 -0500
X-MC-Unique: UTP067Z0OkCrCqtG7tF1pA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40d54db2ab5so20914875e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 01:25:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703582723; x=1704187523;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o0S1EGWalT9mc5fSDPitMMFcpDcP6GvPJwnq9hG5/c8=;
 b=gAiU4o3iQuazncZaFcnIifWUot9qmREwaHYJeeAyJEBcVXwy4DZRd0P+Q95RTBDCQt
 Dv8V9Cb/w7bOEQmQOQx2Aq2d6FyOQVimmqqSxWsG2lYZYqd5WJHDbCwZxDT7yrUW2keJ
 mmlOC1Pg5JtMMJhxxrs9PmJjpKHfjcPbU7fqyvgzTNNIym6pILmtI6HN/k9dQZO/WJxu
 i44i8EeZBva2VTvZsbji8gZCIzkm8x+SFsrwRb4r2dzWsQtq6cREhMI3xTSt2sjn3Klz
 oJnghEOPrf6C9w+SM2h/gBdMRf59qd8KHmcj6Vola7IR5/MMYTf/oQjcMZ1waJpqGKDt
 0flw==
X-Gm-Message-State: AOJu0Yxr+1AuGrAcb06Q+xoW92LUYbEIyLLkRaKaJJ+qXEdHrJpTYh4U
 kxDrGDOKU43OHSBd0KcKXoen6uiMU+dzQapDMHvLuogqiFJ9K3V+WsxxWnMXHyunojSNP929efQ
 s9+svn44sKYK/VV5Ux7vyezcmKGlfAnXeSLBEMe+zdXhmLLSLGQVPRmfcNirypu+WbwwDVH//29
 Ln
X-Received: by 2002:a05:600c:22ca:b0:40d:4a5e:e4f2 with SMTP id
 10-20020a05600c22ca00b0040d4a5ee4f2mr2898476wmg.125.1703582722893; 
 Tue, 26 Dec 2023 01:25:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElSf2jtupM7KpRYjpndKIPxpuwRtqQJBuXFGVq4b9PosqqLTpUYXIFI1fYwmVQixouZRhJHQ==
X-Received: by 2002:a05:600c:22ca:b0:40d:4a5e:e4f2 with SMTP id
 10-20020a05600c22ca00b0040d4a5ee4f2mr2898466wmg.125.1703582722562; 
 Tue, 26 Dec 2023 01:25:22 -0800 (PST)
Received: from redhat.com ([2.55.177.189]) by smtp.gmail.com with ESMTPSA id
 j16-20020a05600c191000b0040c11fbe581sm20159153wmq.27.2023.12.26.01.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 01:25:21 -0800 (PST)
Date: Tue, 26 Dec 2023 04:25:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>
Subject: [PULL 20/21] vdpa: use dev_shared in vdpa_iommu
Message-ID: <878f1e7dd9acc736e7a0f5a205c278c8ae769d39.1703582625.git.mst@redhat.com>
References: <cover.1703582625.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1703582625.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.977,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Eugenio Pérez <eperezma@redhat.com>

The memory listener functions can call these too.  Make vdpa_iommu work
with VhostVDPAShared.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20231221174322.3130442-13-eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
index ada3cc5d7c..e6276fb1e4 100644
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
MST


