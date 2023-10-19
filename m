Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1D97CFCF6
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 16:38:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtU7d-0006mZ-U7; Thu, 19 Oct 2023 10:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qtU7b-0006m8-8f
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:35:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qtU7Z-0000Jz-Ae
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697726132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iT0BXXEUyME+KN3u2mye77WhWN6v9vDgJEMA646Z5v0=;
 b=I7tiP+2y3vJBtx6j3o6lN+VCnza7EZi9bIKNwRW21ziqCJPqZm0Zm9vHgxfNoDHHPNvgdu
 gJ/JfIUd0RGpHgY2/yRgmPrskr4kXKwSw0iZu6hd1+rqLGr/nV97NQFU4X40XxyxoeEQ4c
 ueXb+CQAqFNDE/mkOvOQgqF7cfTjfow=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-222-YZoN037FMCyaY9Br9p1EJw-1; Thu, 19 Oct 2023 10:35:27 -0400
X-MC-Unique: YZoN037FMCyaY9Br9p1EJw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFDA72810D47;
 Thu, 19 Oct 2023 14:35:26 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.192.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B94EFC15BB8;
 Thu, 19 Oct 2023 14:35:24 +0000 (UTC)
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
Subject: [RFC PATCH 11/18] vdpa: use VhostVDPAShared in vdpa_dma_map and unmap
Date: Thu, 19 Oct 2023 16:34:48 +0200
Message-Id: <20231019143455.2377694-12-eperezma@redhat.com>
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

The callers only have the shared information by the end of this series.
Start converting this functions.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h |  4 +--
 hw/virtio/vhost-vdpa.c         | 47 +++++++++++++++++-----------------
 net/vhost-vdpa.c               |  5 ++--
 3 files changed, 29 insertions(+), 27 deletions(-)

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
index 2295daa7cc..0ed6550aad 100644
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
@@ -131,7 +131,7 @@ int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, uint32_t asid, hwaddr iova,
     msg.iotlb.size = size;
     msg.iotlb.type = VHOST_IOTLB_INVALIDATE;
 
-    trace_vhost_vdpa_dma_unmap(v->shared, fd, msg.type, msg.asid, msg.iotlb.iova,
+    trace_vhost_vdpa_dma_unmap(s, fd, msg.type, msg.asid, msg.iotlb.iova,
                                msg.iotlb.size, msg.iotlb.type);
 
     if (write(fd, &msg, sizeof(msg)) != sizeof(msg)) {
@@ -143,29 +143,29 @@ int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, uint32_t asid, hwaddr iova,
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
 
-    trace_vhost_vdpa_listener_begin_batch(v->shared, fd, msg.type, msg.iotlb.type);
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
@@ -225,7 +225,7 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
         if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL)) {
             return;
         }
-        ret = vhost_vdpa_dma_map(v, VHOST_VDPA_GUEST_PA_ASID, iova,
+        ret = vhost_vdpa_dma_map(v->shared, VHOST_VDPA_GUEST_PA_ASID, iova,
                                  iotlb->addr_mask + 1, vaddr, read_only);
         if (ret) {
             error_report("vhost_vdpa_dma_map(%p, 0x%" HWADDR_PRIx ", "
@@ -233,7 +233,7 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
                          v, iova, iotlb->addr_mask + 1, vaddr, ret);
         }
     } else {
-        ret = vhost_vdpa_dma_unmap(v, VHOST_VDPA_GUEST_PA_ASID, iova,
+        ret = vhost_vdpa_dma_unmap(v->shared, VHOST_VDPA_GUEST_PA_ASID, iova,
                                    iotlb->addr_mask + 1);
         if (ret) {
             error_report("vhost_vdpa_dma_unmap(%p, 0x%" HWADDR_PRIx ", "
@@ -369,8 +369,8 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
         iova = mem_region.iova;
     }
 
-    vhost_vdpa_iotlb_batch_begin_once(v);
-    ret = vhost_vdpa_dma_map(v, VHOST_VDPA_GUEST_PA_ASID, iova,
+    vhost_vdpa_iotlb_batch_begin_once(v->shared);
+    ret = vhost_vdpa_dma_map(v->shared, VHOST_VDPA_GUEST_PA_ASID, iova,
                              int128_get64(llsize), vaddr, section->readonly);
     if (ret) {
         error_report("vhost vdpa map fail!");
@@ -454,13 +454,13 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
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
@@ -470,7 +470,7 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
         }
         iova += int128_get64(llsize);
     }
-    ret = vhost_vdpa_dma_unmap(v, VHOST_VDPA_GUEST_PA_ASID, iova,
+    ret = vhost_vdpa_dma_unmap(v->shared, VHOST_VDPA_GUEST_PA_ASID, iova,
                                int128_get64(llsize));
 
     if (ret) {
@@ -1076,7 +1076,8 @@ static void vhost_vdpa_svq_unmap_ring(struct vhost_vdpa *v, hwaddr addr)
     }
 
     size = ROUND_UP(result->size, qemu_real_host_page_size());
-    r = vhost_vdpa_dma_unmap(v, v->address_space_id, result->iova, size);
+    r = vhost_vdpa_dma_unmap(v->shared, v->address_space_id, result->iova,
+                             size);
     if (unlikely(r < 0)) {
         error_report("Unable to unmap SVQ vring: %s (%d)", g_strerror(-r), -r);
         return;
@@ -1116,7 +1117,7 @@ static bool vhost_vdpa_svq_map_ring(struct vhost_vdpa *v, DMAMap *needle,
         return false;
     }
 
-    r = vhost_vdpa_dma_map(v, v->address_space_id, needle->iova,
+    r = vhost_vdpa_dma_map(v->shared, v->address_space_id, needle->iova,
                            needle->size + 1,
                            (void *)(uintptr_t)needle->translated_addr,
                            needle->perm == IOMMU_RO);
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 4d42d7a742..31df7e91a1 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -462,7 +462,8 @@ static void vhost_vdpa_cvq_unmap_buf(struct vhost_vdpa *v, void *addr)
         return;
     }
 
-    r = vhost_vdpa_dma_unmap(v, v->address_space_id, map->iova, map->size + 1);
+    r = vhost_vdpa_dma_unmap(v->shared, v->address_space_id, map->iova,
+                             map->size + 1);
     if (unlikely(r != 0)) {
         error_report("Device cannot unmap: %s(%d)", g_strerror(r), r);
     }
@@ -486,7 +487,7 @@ static int vhost_vdpa_cvq_map_buf(struct vhost_vdpa *v, void *buf, size_t size,
         return r;
     }
 
-    r = vhost_vdpa_dma_map(v, v->address_space_id, map.iova,
+    r = vhost_vdpa_dma_map(v->shared, v->address_space_id, map.iova,
                            vhost_vdpa_net_cvq_cmd_page_len(), buf, !write);
     if (unlikely(r < 0)) {
         goto dma_map_err;
-- 
2.39.3


