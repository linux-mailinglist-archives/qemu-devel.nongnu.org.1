Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 817F781BD80
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:44:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGN5L-00024h-4f; Thu, 21 Dec 2023 12:43:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rGN58-0001zZ-EV
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:43:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rGN54-0004OW-Ef
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:43:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703180613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YvA8DRQtDSqR0QnTAPfKnn8uM+q3xCroDQsExpaGUPw=;
 b=J5aoLn/2UAH/OSFZMkuqniM8fmSuHudB7xJqvsE+GaDlXi1Mc3oymnwuKvDXn0djtezZm+
 Z4NjV+9T0DP4dL2XhdbcgkluefW96V+PVewqKW2HrBQ3QkDfBC/TUGtSXS7eoZaZb20sZc
 a90JVy9FhjnTeKX1HCmLVG634/7qeJI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-Ai62b3-1NUC72qPUMYHF5Q-1; Thu,
 21 Dec 2023 12:43:30 -0500
X-MC-Unique: Ai62b3-1NUC72qPUMYHF5Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 132CA38143B6;
 Thu, 21 Dec 2023 17:43:30 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6DF07492BC6;
 Thu, 21 Dec 2023 17:43:28 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 si-wei.liu@oracle.com, Laurent Vivier <lvivier@redhat.com>,
 Lei Yang <leiyang@redhat.com>
Subject: [PATCH v4 02/13] vdpa: move iova tree to the shared struct
Date: Thu, 21 Dec 2023 18:43:11 +0100
Message-Id: <20231221174322.3130442-3-eperezma@redhat.com>
In-Reply-To: <20231221174322.3130442-1-eperezma@redhat.com>
References: <20231221174322.3130442-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
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

Next patches will register the vhost_vdpa memory listener while the VM
is migrating at the destination, so we can map the memory to the device
before stopping the VM at the source.  The main goal is to reduce the
downtime.

However, the destination QEMU is unaware of which vhost_vdpa device will
register its memory_listener.  If the source guest has CVQ enabled, it
will be the CVQ device.  Otherwise, it  will be the first one.

Move the iova tree to VhostVDPAShared so all vhost_vdpa can use it,
rather than always in the first or last vhost_vdpa.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h |  4 +--
 hw/virtio/vhost-vdpa.c         | 19 ++++++------
 net/vhost-vdpa.c               | 54 +++++++++++++++-------------------
 3 files changed, 35 insertions(+), 42 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index eb1a56d75a..ac036055d3 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -32,6 +32,8 @@ typedef struct VhostVDPAHostNotifier {
 
 /* Info shared by all vhost_vdpa device models */
 typedef struct vhost_vdpa_shared {
+    /* IOVA mapping used by the Shadow Virtqueue */
+    VhostIOVATree *iova_tree;
 } VhostVDPAShared;
 
 typedef struct vhost_vdpa {
@@ -48,8 +50,6 @@ typedef struct vhost_vdpa {
     bool shadow_data;
     /* Device suspended successfully */
     bool suspended;
-    /* IOVA mapping used by the Shadow Virtqueue */
-    VhostIOVATree *iova_tree;
     VhostVDPAShared *shared;
     GPtrArray *shadow_vqs;
     const VhostShadowVirtqueueOps *shadow_vq_ops;
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 819b2d811a..9cee38cb6d 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -358,7 +358,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
         mem_region.size = int128_get64(llsize) - 1,
         mem_region.perm = IOMMU_ACCESS_FLAG(true, section->readonly),
 
-        r = vhost_iova_tree_map_alloc(v->iova_tree, &mem_region);
+        r = vhost_iova_tree_map_alloc(v->shared->iova_tree, &mem_region);
         if (unlikely(r != IOVA_OK)) {
             error_report("Can't allocate a mapping (%d)", r);
             goto fail;
@@ -379,7 +379,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
 
 fail_map:
     if (v->shadow_data) {
-        vhost_iova_tree_remove(v->iova_tree, mem_region);
+        vhost_iova_tree_remove(v->shared->iova_tree, mem_region);
     }
 
 fail:
@@ -441,13 +441,13 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
             .size = int128_get64(llsize) - 1,
         };
 
-        result = vhost_iova_tree_find_iova(v->iova_tree, &mem_region);
+        result = vhost_iova_tree_find_iova(v->shared->iova_tree, &mem_region);
         if (!result) {
             /* The memory listener map wasn't mapped */
             return;
         }
         iova = result->iova;
-        vhost_iova_tree_remove(v->iova_tree, *result);
+        vhost_iova_tree_remove(v->shared->iova_tree, *result);
     }
     vhost_vdpa_iotlb_batch_begin_once(v);
     /*
@@ -1059,7 +1059,8 @@ static void vhost_vdpa_svq_unmap_ring(struct vhost_vdpa *v, hwaddr addr)
     const DMAMap needle = {
         .translated_addr = addr,
     };
-    const DMAMap *result = vhost_iova_tree_find_iova(v->iova_tree, &needle);
+    const DMAMap *result = vhost_iova_tree_find_iova(v->shared->iova_tree,
+                                                     &needle);
     hwaddr size;
     int r;
 
@@ -1075,7 +1076,7 @@ static void vhost_vdpa_svq_unmap_ring(struct vhost_vdpa *v, hwaddr addr)
         return;
     }
 
-    vhost_iova_tree_remove(v->iova_tree, *result);
+    vhost_iova_tree_remove(v->shared->iova_tree, *result);
 }
 
 static void vhost_vdpa_svq_unmap_rings(struct vhost_dev *dev,
@@ -1103,7 +1104,7 @@ static bool vhost_vdpa_svq_map_ring(struct vhost_vdpa *v, DMAMap *needle,
 {
     int r;
 
-    r = vhost_iova_tree_map_alloc(v->iova_tree, needle);
+    r = vhost_iova_tree_map_alloc(v->shared->iova_tree, needle);
     if (unlikely(r != IOVA_OK)) {
         error_setg(errp, "Cannot allocate iova (%d)", r);
         return false;
@@ -1115,7 +1116,7 @@ static bool vhost_vdpa_svq_map_ring(struct vhost_vdpa *v, DMAMap *needle,
                            needle->perm == IOMMU_RO);
     if (unlikely(r != 0)) {
         error_setg_errno(errp, -r, "Cannot map region to device");
-        vhost_iova_tree_remove(v->iova_tree, *needle);
+        vhost_iova_tree_remove(v->shared->iova_tree, *needle);
     }
 
     return r == 0;
@@ -1216,7 +1217,7 @@ static bool vhost_vdpa_svqs_start(struct vhost_dev *dev)
             goto err;
         }
 
-        vhost_svq_start(svq, dev->vdev, vq, v->iova_tree);
+        vhost_svq_start(svq, dev->vdev, vq, v->shared->iova_tree);
         ok = vhost_vdpa_svq_map_rings(dev, svq, &addr, &err);
         if (unlikely(!ok)) {
             goto err_map;
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 8b661b9e6d..10703e5833 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -354,8 +354,8 @@ static void vhost_vdpa_net_data_start_first(VhostVDPAState *s)
     migration_add_notifier(&s->migration_state,
                            vdpa_net_migration_state_notifier);
     if (v->shadow_vqs_enabled) {
-        v->iova_tree = vhost_iova_tree_new(v->iova_range.first,
-                                           v->iova_range.last);
+        v->shared->iova_tree = vhost_iova_tree_new(v->iova_range.first,
+                                                   v->iova_range.last);
     }
 }
 
@@ -380,11 +380,6 @@ static int vhost_vdpa_net_data_start(NetClientState *nc)
         return 0;
     }
 
-    if (v->shadow_vqs_enabled) {
-        VhostVDPAState *s0 = vhost_vdpa_net_first_nc_vdpa(s);
-        v->iova_tree = s0->vhost_vdpa.iova_tree;
-    }
-
     return 0;
 }
 
@@ -417,9 +412,8 @@ static void vhost_vdpa_net_client_stop(NetClientState *nc)
 
     dev = s->vhost_vdpa.dev;
     if (dev->vq_index + dev->nvqs == dev->vq_index_end) {
-        g_clear_pointer(&s->vhost_vdpa.iova_tree, vhost_iova_tree_delete);
-    } else {
-        s->vhost_vdpa.iova_tree = NULL;
+        g_clear_pointer(&s->vhost_vdpa.shared->iova_tree,
+                        vhost_iova_tree_delete);
     }
 }
 
@@ -474,7 +468,7 @@ static int vhost_vdpa_set_address_space_id(struct vhost_vdpa *v,
 
 static void vhost_vdpa_cvq_unmap_buf(struct vhost_vdpa *v, void *addr)
 {
-    VhostIOVATree *tree = v->iova_tree;
+    VhostIOVATree *tree = v->shared->iova_tree;
     DMAMap needle = {
         /*
          * No need to specify size or to look for more translations since
@@ -508,7 +502,7 @@ static int vhost_vdpa_cvq_map_buf(struct vhost_vdpa *v, void *buf, size_t size,
     map.translated_addr = (hwaddr)(uintptr_t)buf;
     map.size = size - 1;
     map.perm = write ? IOMMU_RW : IOMMU_RO,
-    r = vhost_iova_tree_map_alloc(v->iova_tree, &map);
+    r = vhost_iova_tree_map_alloc(v->shared->iova_tree, &map);
     if (unlikely(r != IOVA_OK)) {
         error_report("Cannot map injected element");
         return r;
@@ -523,7 +517,7 @@ static int vhost_vdpa_cvq_map_buf(struct vhost_vdpa *v, void *buf, size_t size,
     return 0;
 
 dma_map_err:
-    vhost_iova_tree_remove(v->iova_tree, map);
+    vhost_iova_tree_remove(v->shared->iova_tree, map);
     return r;
 }
 
@@ -583,24 +577,22 @@ out:
         return 0;
     }
 
-    if (s0->vhost_vdpa.iova_tree) {
-        /*
-         * SVQ is already configured for all virtqueues.  Reuse IOVA tree for
-         * simplicity, whether CVQ shares ASID with guest or not, because:
-         * - Memory listener need access to guest's memory addresses allocated
-         *   in the IOVA tree.
-         * - There should be plenty of IOVA address space for both ASID not to
-         *   worry about collisions between them.  Guest's translations are
-         *   still validated with virtio virtqueue_pop so there is no risk for
-         *   the guest to access memory that it shouldn't.
-         *
-         * To allocate a iova tree per ASID is doable but it complicates the
-         * code and it is not worth it for the moment.
-         */
-        v->iova_tree = s0->vhost_vdpa.iova_tree;
-    } else {
-        v->iova_tree = vhost_iova_tree_new(v->iova_range.first,
-                                           v->iova_range.last);
+    /*
+     * If other vhost_vdpa already have an iova_tree, reuse it for simplicity,
+     * whether CVQ shares ASID with guest or not, because:
+     * - Memory listener need access to guest's memory addresses allocated in
+     *   the IOVA tree.
+     * - There should be plenty of IOVA address space for both ASID not to
+     *   worry about collisions between them.  Guest's translations are still
+     *   validated with virtio virtqueue_pop so there is no risk for the guest
+     *   to access memory that it shouldn't.
+     *
+     * To allocate a iova tree per ASID is doable but it complicates the code
+     * and it is not worth it for the moment.
+     */
+    if (!v->shared->iova_tree) {
+        v->shared->iova_tree = vhost_iova_tree_new(v->iova_range.first,
+                                                   v->iova_range.last);
     }
 
     r = vhost_vdpa_cvq_map_buf(&s->vhost_vdpa, s->cvq_cmd_out_buffer,
-- 
2.39.3


