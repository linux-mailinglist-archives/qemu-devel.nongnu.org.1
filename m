Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 753B6814884
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 13:54:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE7gn-0001g7-Af; Fri, 15 Dec 2023 07:53:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rE7gj-0001fi-C1
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 07:53:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rE7gh-0001VS-Fl
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 07:53:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702644786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6+QK/N2PZdG4lv35CVCveKrlfGmbDCglKspi37Q1jgc=;
 b=c73gZ7qeyCSCebxdwucOTuTGg3s8kivzZEZ55VQLuFjDZjtmpPiA682sEDuDiuX/77hz5D
 ntUuZ87bbAIAUe0b5WSLQlLo2S8xbNQh+c+WIjKtjL4rIqkMFjpNL6XthjvcW4TlSX09AK
 LLjfmspHfjnlP2+GyvOrCn1xG4rfXNE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-2mfs1eu_O6SrnFRNC35nDw-1; Fri, 15 Dec 2023 07:53:04 -0500
X-MC-Unique: 2mfs1eu_O6SrnFRNC35nDw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B59F8101A52A;
 Fri, 15 Dec 2023 12:53:03 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.194.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19EDC492BC6;
 Fri, 15 Dec 2023 12:53:01 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, si-wei.liu@oracle.com,
 Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Lei Yang <leiyang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 9.0 v2 05/13] vdpa: use vdpa shared for tracing
Date: Fri, 15 Dec 2023 13:52:42 +0100
Message-Id: <20231215125250.2483663-6-eperezma@redhat.com>
In-Reply-To: <20231215125250.2483663-1-eperezma@redhat.com>
References: <20231215125250.2483663-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

By the end of this series dma_map and dma_unmap functions don't have the
vdpa device for tracing.  Movinge trace function to shared member one.
Print it also in the vdpa initialization so log reader can relate them.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 26 ++++++++++++++------------
 hw/virtio/trace-events | 14 +++++++-------
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index ec028e4c56..85de60b184 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -101,7 +101,7 @@ int vhost_vdpa_dma_map(struct vhost_vdpa *v, uint32_t asid, hwaddr iova,
     msg.iotlb.perm = readonly ? VHOST_ACCESS_RO : VHOST_ACCESS_RW;
     msg.iotlb.type = VHOST_IOTLB_UPDATE;
 
-    trace_vhost_vdpa_dma_map(v, fd, msg.type, msg.asid, msg.iotlb.iova,
+    trace_vhost_vdpa_dma_map(v->shared, fd, msg.type, msg.asid, msg.iotlb.iova,
                              msg.iotlb.size, msg.iotlb.uaddr, msg.iotlb.perm,
                              msg.iotlb.type);
 
@@ -131,8 +131,8 @@ int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, uint32_t asid, hwaddr iova,
     msg.iotlb.size = size;
     msg.iotlb.type = VHOST_IOTLB_INVALIDATE;
 
-    trace_vhost_vdpa_dma_unmap(v, fd, msg.type, msg.asid, msg.iotlb.iova,
-                               msg.iotlb.size, msg.iotlb.type);
+    trace_vhost_vdpa_dma_unmap(v->shared, fd, msg.type, msg.asid,
+                               msg.iotlb.iova, msg.iotlb.size, msg.iotlb.type);
 
     if (write(fd, &msg, sizeof(msg)) != sizeof(msg)) {
         error_report("failed to write, fd=%d, errno=%d (%s)",
@@ -151,7 +151,8 @@ static void vhost_vdpa_listener_begin_batch(struct vhost_vdpa *v)
         .iotlb.type = VHOST_IOTLB_BATCH_BEGIN,
     };
 
-    trace_vhost_vdpa_listener_begin_batch(v, fd, msg.type, msg.iotlb.type);
+    trace_vhost_vdpa_listener_begin_batch(v->shared, fd, msg.type,
+                                          msg.iotlb.type);
     if (write(fd, &msg, sizeof(msg)) != sizeof(msg)) {
         error_report("failed to write, fd=%d, errno=%d (%s)",
                      fd, errno, strerror(errno));
@@ -186,7 +187,7 @@ static void vhost_vdpa_listener_commit(MemoryListener *listener)
     msg.type = v->msg_type;
     msg.iotlb.type = VHOST_IOTLB_BATCH_END;
 
-    trace_vhost_vdpa_listener_commit(v, fd, msg.type, msg.iotlb.type);
+    trace_vhost_vdpa_listener_commit(v->shared, fd, msg.type, msg.iotlb.type);
     if (write(fd, &msg, sizeof(msg)) != sizeof(msg)) {
         error_report("failed to write, fd=%d, errno=%d (%s)",
                      fd, errno, strerror(errno));
@@ -329,7 +330,8 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
 
     if (unlikely((section->offset_within_address_space & ~page_mask) !=
                  (section->offset_within_region & ~page_mask))) {
-        trace_vhost_vdpa_listener_region_add_unaligned(v, section->mr->name,
+        trace_vhost_vdpa_listener_region_add_unaligned(v->shared,
+                       section->mr->name,
                        section->offset_within_address_space & ~page_mask,
                        section->offset_within_region & ~page_mask);
         return;
@@ -349,7 +351,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
             section->offset_within_region +
             (iova - section->offset_within_address_space);
 
-    trace_vhost_vdpa_listener_region_add(v, iova, int128_get64(llend),
+    trace_vhost_vdpa_listener_region_add(v->shared, iova, int128_get64(llend),
                                          vaddr, section->readonly);
 
     llsize = int128_sub(llend, int128_make64(iova));
@@ -417,7 +419,8 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
 
     if (unlikely((section->offset_within_address_space & ~page_mask) !=
                  (section->offset_within_region & ~page_mask))) {
-        trace_vhost_vdpa_listener_region_del_unaligned(v, section->mr->name,
+        trace_vhost_vdpa_listener_region_del_unaligned(v->shared,
+                       section->mr->name,
                        section->offset_within_address_space & ~page_mask,
                        section->offset_within_region & ~page_mask);
         return;
@@ -426,7 +429,7 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
     iova = ROUND_UP(section->offset_within_address_space, page_size);
     llend = vhost_vdpa_section_end(section, page_mask);
 
-    trace_vhost_vdpa_listener_region_del(v, iova,
+    trace_vhost_vdpa_listener_region_del(v->shared, iova,
         int128_get64(int128_sub(llend, int128_one())));
 
     if (int128_ge(int128_make64(iova), llend)) {
@@ -583,12 +586,11 @@ static void vhost_vdpa_init_svq(struct vhost_dev *hdev, struct vhost_vdpa *v)
 
 static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque, Error **errp)
 {
-    struct vhost_vdpa *v;
+    struct vhost_vdpa *v = opaque;
     assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_VDPA);
-    trace_vhost_vdpa_init(dev, opaque);
+    trace_vhost_vdpa_init(dev, v->shared, opaque);
     int ret;
 
-    v = opaque;
     v->dev = dev;
     dev->opaque =  opaque ;
     v->listener = vhost_vdpa_memory_listener;
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 637cac4edf..77905d1994 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -30,16 +30,16 @@ vhost_user_write(uint32_t req, uint32_t flags) "req:%d flags:0x%"PRIx32""
 vhost_user_create_notifier(int idx, void *n) "idx:%d n:%p"
 
 # vhost-vdpa.c
-vhost_vdpa_dma_map(void *vdpa, int fd, uint32_t msg_type, uint32_t asid, uint64_t iova, uint64_t size, uint64_t uaddr, uint8_t perm, uint8_t type) "vdpa:%p fd: %d msg_type: %"PRIu32" asid: %"PRIu32" iova: 0x%"PRIx64" size: 0x%"PRIx64" uaddr: 0x%"PRIx64" perm: 0x%"PRIx8" type: %"PRIu8
-vhost_vdpa_dma_unmap(void *vdpa, int fd, uint32_t msg_type, uint32_t asid, uint64_t iova, uint64_t size, uint8_t type) "vdpa:%p fd: %d msg_type: %"PRIu32" asid: %"PRIu32" iova: 0x%"PRIx64" size: 0x%"PRIx64" type: %"PRIu8
-vhost_vdpa_listener_begin_batch(void *v, int fd, uint32_t msg_type, uint8_t type)  "vdpa:%p fd: %d msg_type: %"PRIu32" type: %"PRIu8
-vhost_vdpa_listener_commit(void *v, int fd, uint32_t msg_type, uint8_t type)  "vdpa:%p fd: %d msg_type: %"PRIu32" type: %"PRIu8
-vhost_vdpa_listener_region_add_unaligned(void *v, const char *name, uint64_t offset_as, uint64_t offset_page) "vdpa: %p region %s offset_within_address_space %"PRIu64" offset_within_region %"PRIu64
+vhost_vdpa_dma_map(void *vdpa, int fd, uint32_t msg_type, uint32_t asid, uint64_t iova, uint64_t size, uint64_t uaddr, uint8_t perm, uint8_t type) "vdpa_shared:%p fd: %d msg_type: %"PRIu32" asid: %"PRIu32" iova: 0x%"PRIx64" size: 0x%"PRIx64" uaddr: 0x%"PRIx64" perm: 0x%"PRIx8" type: %"PRIu8
+vhost_vdpa_dma_unmap(void *vdpa, int fd, uint32_t msg_type, uint32_t asid, uint64_t iova, uint64_t size, uint8_t type) "vdpa_shared:%p fd: %d msg_type: %"PRIu32" asid: %"PRIu32" iova: 0x%"PRIx64" size: 0x%"PRIx64" type: %"PRIu8
+vhost_vdpa_listener_begin_batch(void *v, int fd, uint32_t msg_type, uint8_t type)  "vdpa_shared:%p fd: %d msg_type: %"PRIu32" type: %"PRIu8
+vhost_vdpa_listener_commit(void *v, int fd, uint32_t msg_type, uint8_t type)  "vdpa_shared:%p fd: %d msg_type: %"PRIu32" type: %"PRIu8
+vhost_vdpa_listener_region_add_unaligned(void *v, const char *name, uint64_t offset_as, uint64_t offset_page) "vdpa_shared: %p region %s offset_within_address_space %"PRIu64" offset_within_region %"PRIu64
 vhost_vdpa_listener_region_add(void *vdpa, uint64_t iova, uint64_t llend, void *vaddr, bool readonly) "vdpa: %p iova 0x%"PRIx64" llend 0x%"PRIx64" vaddr: %p read-only: %d"
-vhost_vdpa_listener_region_del_unaligned(void *v, const char *name, uint64_t offset_as, uint64_t offset_page) "vdpa: %p region %s offset_within_address_space %"PRIu64" offset_within_region %"PRIu64
+vhost_vdpa_listener_region_del_unaligned(void *v, const char *name, uint64_t offset_as, uint64_t offset_page) "vdpa_shared: %p region %s offset_within_address_space %"PRIu64" offset_within_region %"PRIu64
 vhost_vdpa_listener_region_del(void *vdpa, uint64_t iova, uint64_t llend) "vdpa: %p iova 0x%"PRIx64" llend 0x%"PRIx64
 vhost_vdpa_add_status(void *dev, uint8_t status) "dev: %p status: 0x%"PRIx8
-vhost_vdpa_init(void *dev, void *vdpa) "dev: %p vdpa: %p"
+vhost_vdpa_init(void *dev, void *s, void *vdpa) "dev: %p, common dev: %p vdpa: %p"
 vhost_vdpa_cleanup(void *dev, void *vdpa) "dev: %p vdpa: %p"
 vhost_vdpa_memslots_limit(void *dev, int ret) "dev: %p = 0x%x"
 vhost_vdpa_set_mem_table(void *dev, uint32_t nregions, uint32_t padding) "dev: %p nregions: %"PRIu32" padding: 0x%"PRIx32
-- 
2.39.3


