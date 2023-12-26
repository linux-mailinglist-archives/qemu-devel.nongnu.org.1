Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 418A381E65C
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 10:26:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI3gm-0004jK-0N; Tue, 26 Dec 2023 04:25:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3gj-0004aI-RS
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:25:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3gh-0000A3-NY
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703582723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=83xRNao3wYJ+xT44DNwZkqp56Au3afhfwnreo+lS1GM=;
 b=KaoFdhjuTAMAWpAzrR69XuRj9nToBWrw1w62aSLFblKzrawDkfUxaK+FfQjNt14407uKXy
 pCSKYFcLM6q0bnymOSjS6KEH3hBW6qZsjGTLQDbt3YF0IFlSUIVXACWAty6Xl1YaHnF5Ht
 4IHJFyiLSLzcDwUOMIe7GEr6nzBSjZY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-7ebDJWZNPE6tPNpExdRZdg-1; Tue, 26 Dec 2023 04:25:21 -0500
X-MC-Unique: 7ebDJWZNPE6tPNpExdRZdg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33666ece1c6so3278278f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 01:25:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703582720; x=1704187520;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=83xRNao3wYJ+xT44DNwZkqp56Au3afhfwnreo+lS1GM=;
 b=BXZIWz4WGo7K9WXwdeoL1Ro3LAfnptC006R/VzywVO9eTyh3GKX4+z3p30zuSw2fwO
 /0tEZOPeD9OI6GIZ6+gqYBpSMw6Zx9H5hkgJZQvdLjNH5Og+8PfkxrN4j7dTwQ5U5aAm
 O60UTpKl/CforDpBHLSGKhe9icm5WxjnlqOdiz0aPABgNV0r7dfX9BQSsh5dOirGpOvL
 kz78Lb95NZV3CTXC9HcUy1XRDpJWDQwFMgpEGNZPpUCO3ef6KGMTMMn1T8W6JZiaKUpa
 BBH/bfy7ZcnbgoaZ96YgNO0HpwysiWvJ5sLkRdehc8nXlhYoa+w7xJQw8uALhhOQgdBI
 BQ9w==
X-Gm-Message-State: AOJu0Yxcrhk0HWtOVZlyHZ7YF/YCASIevbzEu0GLUPLUqgoQxWKrHgVB
 KJ5++2d6qVz3JbN8kpNL8UYAFV+BeC78lnGILxOzj9zPHohEz9XtYCzrwh86iwGI7QXc7rpepVU
 ZsyfkBoW4zv7/6yTPjxLFTpeo+XM4aQFQWxRLEJJbe6u+cjzBZLBsfrVQBl000WqteHeojwuEof
 Jj
X-Received: by 2002:a05:6000:2a9:b0:336:c82b:dc0e with SMTP id
 l9-20020a05600002a900b00336c82bdc0emr764490wry.201.1703582719688; 
 Tue, 26 Dec 2023 01:25:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFowlAp/ghY0eUmtk4TYG/aVfpUY80Y2+213mI5rbU6phxChWXYabYg1AHnFrZ7fj6Vb38n9A==
X-Received: by 2002:a05:6000:2a9:b0:336:c82b:dc0e with SMTP id
 l9-20020a05600002a900b00336c82bdc0emr764481wry.201.1703582719307; 
 Tue, 26 Dec 2023 01:25:19 -0800 (PST)
Received: from redhat.com ([2.55.177.189]) by smtp.gmail.com with ESMTPSA id
 a8-20020a5d53c8000000b00336905ad6d4sm9741753wrw.86.2023.12.26.01.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 01:25:18 -0800 (PST)
Date: Tue, 26 Dec 2023 04:25:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>
Subject: [PULL 19/21] vdpa: use VhostVDPAShared in vdpa_dma_map and unmap
Message-ID: <d60c9befc32ebee78a73ee3284ebf71785310ffe.1703582625.git.mst@redhat.com>
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

The callers only have the shared information by the end of this series.
Start converting this functions.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20231221174322.3130442-12-eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h |  4 +--
 hw/virtio/vhost-vdpa.c         | 50 +++++++++++++++++-----------------
 net/vhost-vdpa.c               |  5 ++--
 3 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 3880b9e7f2..705c754776 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -69,9 +69,9 @@ typedef struct vhost_vdpa {
 int vhost_vdpa_get_iova_range(int fd, struct vhost_vdpa_iova_range *iova_range);
 int vhost_vdpa_set_vring_ready(struct vhost_vdpa *v, unsigned idx);
 
-int vhost_vdpa_dma_map(struct vhost_vdpa *v, uint32_t asid, hwaddr iova,
+int vhost_vdpa_dma_map(VhostVDPAShared *s, uint32_t asid, hwaddr iova,
                        hwaddr size, void *vaddr, bool readonly);
-int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, uint32_t asid, hwaddr iova,
+int vhost_vdpa_dma_unmap(VhostVDPAShared *s, uint32_t asid, hwaddr iova,
                          hwaddr size);
 
 typedef struct vdpa_iommu {
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index a2713b9f0b..ada3cc5d7c 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -86,11 +86,11 @@ static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *section,
  * The caller must set asid = 0 if the device does not support asid.
  * This is not an ABI break since it is set to 0 by the initializer anyway.
  */
-int vhost_vdpa_dma_map(struct vhost_vdpa *v, uint32_t asid, hwaddr iova,
+int vhost_vdpa_dma_map(VhostVDPAShared *s, uint32_t asid, hwaddr iova,
                        hwaddr size, void *vaddr, bool readonly)
 {
     struct vhost_msg_v2 msg = {};
-    int fd = v->shared->device_fd;
+    int fd = s->device_fd;
     int ret = 0;
 
     msg.type = VHOST_IOTLB_MSG_V2;
@@ -101,7 +101,7 @@ int vhost_vdpa_dma_map(struct vhost_vdpa *v, uint32_t asid, hwaddr iova,
     msg.iotlb.perm = readonly ? VHOST_ACCESS_RO : VHOST_ACCESS_RW;
     msg.iotlb.type = VHOST_IOTLB_UPDATE;
 
-    trace_vhost_vdpa_dma_map(v->shared, fd, msg.type, msg.asid, msg.iotlb.iova,
+    trace_vhost_vdpa_dma_map(s, fd, msg.type, msg.asid, msg.iotlb.iova,
                              msg.iotlb.size, msg.iotlb.uaddr, msg.iotlb.perm,
                              msg.iotlb.type);
 
@@ -118,11 +118,11 @@ int vhost_vdpa_dma_map(struct vhost_vdpa *v, uint32_t asid, hwaddr iova,
  * The caller must set asid = 0 if the device does not support asid.
  * This is not an ABI break since it is set to 0 by the initializer anyway.
  */
-int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, uint32_t asid, hwaddr iova,
+int vhost_vdpa_dma_unmap(VhostVDPAShared *s, uint32_t asid, hwaddr iova,
                          hwaddr size)
 {
     struct vhost_msg_v2 msg = {};
-    int fd = v->shared->device_fd;
+    int fd = s->device_fd;
     int ret = 0;
 
     msg.type = VHOST_IOTLB_MSG_V2;
@@ -131,8 +131,8 @@ int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, uint32_t asid, hwaddr iova,
     msg.iotlb.size = size;
     msg.iotlb.type = VHOST_IOTLB_INVALIDATE;
 
-    trace_vhost_vdpa_dma_unmap(v->shared, fd, msg.type, msg.asid,
-                               msg.iotlb.iova, msg.iotlb.size, msg.iotlb.type);
+    trace_vhost_vdpa_dma_unmap(s, fd, msg.type, msg.asid, msg.iotlb.iova,
+                               msg.iotlb.size, msg.iotlb.type);
 
     if (write(fd, &msg, sizeof(msg)) != sizeof(msg)) {
         error_report("failed to write, fd=%d, errno=%d (%s)",
@@ -143,30 +143,29 @@ int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, uint32_t asid, hwaddr iova,
     return ret;
 }
 
-static void vhost_vdpa_listener_begin_batch(struct vhost_vdpa *v)
+static void vhost_vdpa_listener_begin_batch(VhostVDPAShared *s)
 {
-    int fd = v->shared->device_fd;
+    int fd = s->device_fd;
     struct vhost_msg_v2 msg = {
         .type = VHOST_IOTLB_MSG_V2,
         .iotlb.type = VHOST_IOTLB_BATCH_BEGIN,
     };
 
-    trace_vhost_vdpa_listener_begin_batch(v->shared, fd, msg.type,
-                                          msg.iotlb.type);
+    trace_vhost_vdpa_listener_begin_batch(s, fd, msg.type, msg.iotlb.type);
     if (write(fd, &msg, sizeof(msg)) != sizeof(msg)) {
         error_report("failed to write, fd=%d, errno=%d (%s)",
                      fd, errno, strerror(errno));
     }
 }
 
-static void vhost_vdpa_iotlb_batch_begin_once(struct vhost_vdpa *v)
+static void vhost_vdpa_iotlb_batch_begin_once(VhostVDPAShared *s)
 {
-    if (v->shared->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH) &&
-        !v->shared->iotlb_batch_begin_sent) {
-        vhost_vdpa_listener_begin_batch(v);
+    if (s->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH) &&
+        !s->iotlb_batch_begin_sent) {
+        vhost_vdpa_listener_begin_batch(s);
     }
 
-    v->shared->iotlb_batch_begin_sent = true;
+    s->iotlb_batch_begin_sent = true;
 }
 
 static void vhost_vdpa_listener_commit(MemoryListener *listener)
@@ -226,7 +225,7 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
         if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL)) {
             return;
         }
-        ret = vhost_vdpa_dma_map(v, VHOST_VDPA_GUEST_PA_ASID, iova,
+        ret = vhost_vdpa_dma_map(v->shared, VHOST_VDPA_GUEST_PA_ASID, iova,
                                  iotlb->addr_mask + 1, vaddr, read_only);
         if (ret) {
             error_report("vhost_vdpa_dma_map(%p, 0x%" HWADDR_PRIx ", "
@@ -234,7 +233,7 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
                          v, iova, iotlb->addr_mask + 1, vaddr, ret);
         }
     } else {
-        ret = vhost_vdpa_dma_unmap(v, VHOST_VDPA_GUEST_PA_ASID, iova,
+        ret = vhost_vdpa_dma_unmap(v->shared, VHOST_VDPA_GUEST_PA_ASID, iova,
                                    iotlb->addr_mask + 1);
         if (ret) {
             error_report("vhost_vdpa_dma_unmap(%p, 0x%" HWADDR_PRIx ", "
@@ -370,8 +369,8 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
         iova = mem_region.iova;
     }
 
-    vhost_vdpa_iotlb_batch_begin_once(v);
-    ret = vhost_vdpa_dma_map(v, VHOST_VDPA_GUEST_PA_ASID, iova,
+    vhost_vdpa_iotlb_batch_begin_once(v->shared);
+    ret = vhost_vdpa_dma_map(v->shared, VHOST_VDPA_GUEST_PA_ASID, iova,
                              int128_get64(llsize), vaddr, section->readonly);
     if (ret) {
         error_report("vhost vdpa map fail!");
@@ -455,13 +454,13 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
         iova = result->iova;
         vhost_iova_tree_remove(v->shared->iova_tree, *result);
     }
-    vhost_vdpa_iotlb_batch_begin_once(v);
+    vhost_vdpa_iotlb_batch_begin_once(v->shared);
     /*
      * The unmap ioctl doesn't accept a full 64-bit. need to check it
      */
     if (int128_eq(llsize, int128_2_64())) {
         llsize = int128_rshift(llsize, 1);
-        ret = vhost_vdpa_dma_unmap(v, VHOST_VDPA_GUEST_PA_ASID, iova,
+        ret = vhost_vdpa_dma_unmap(v->shared, VHOST_VDPA_GUEST_PA_ASID, iova,
                                    int128_get64(llsize));
 
         if (ret) {
@@ -471,7 +470,7 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
         }
         iova += int128_get64(llsize);
     }
-    ret = vhost_vdpa_dma_unmap(v, VHOST_VDPA_GUEST_PA_ASID, iova,
+    ret = vhost_vdpa_dma_unmap(v->shared, VHOST_VDPA_GUEST_PA_ASID, iova,
                                int128_get64(llsize));
 
     if (ret) {
@@ -1081,7 +1080,8 @@ static void vhost_vdpa_svq_unmap_ring(struct vhost_vdpa *v, hwaddr addr)
     }
 
     size = ROUND_UP(result->size, qemu_real_host_page_size());
-    r = vhost_vdpa_dma_unmap(v, v->address_space_id, result->iova, size);
+    r = vhost_vdpa_dma_unmap(v->shared, v->address_space_id, result->iova,
+                             size);
     if (unlikely(r < 0)) {
         error_report("Unable to unmap SVQ vring: %s (%d)", g_strerror(-r), -r);
         return;
@@ -1121,7 +1121,7 @@ static bool vhost_vdpa_svq_map_ring(struct vhost_vdpa *v, DMAMap *needle,
         return false;
     }
 
-    r = vhost_vdpa_dma_map(v, v->address_space_id, needle->iova,
+    r = vhost_vdpa_dma_map(v->shared, v->address_space_id, needle->iova,
                            needle->size + 1,
                            (void *)(uintptr_t)needle->translated_addr,
                            needle->perm == IOMMU_RO);
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 10cf0027de..3726ee5d67 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -471,7 +471,8 @@ static void vhost_vdpa_cvq_unmap_buf(struct vhost_vdpa *v, void *addr)
         return;
     }
 
-    r = vhost_vdpa_dma_unmap(v, v->address_space_id, map->iova, map->size + 1);
+    r = vhost_vdpa_dma_unmap(v->shared, v->address_space_id, map->iova,
+                             map->size + 1);
     if (unlikely(r != 0)) {
         error_report("Device cannot unmap: %s(%d)", g_strerror(r), r);
     }
@@ -495,7 +496,7 @@ static int vhost_vdpa_cvq_map_buf(struct vhost_vdpa *v, void *buf, size_t size,
         return r;
     }
 
-    r = vhost_vdpa_dma_map(v, v->address_space_id, map.iova,
+    r = vhost_vdpa_dma_map(v->shared, v->address_space_id, map.iova,
                            vhost_vdpa_net_cvq_cmd_page_len(), buf, !write);
     if (unlikely(r < 0)) {
         goto dma_map_err;
-- 
MST


