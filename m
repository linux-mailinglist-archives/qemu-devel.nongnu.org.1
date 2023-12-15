Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F625814EC0
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 18:30:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEBzc-00061x-3r; Fri, 15 Dec 2023 12:28:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rEBzZ-000616-Sz
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 12:28:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rEBzX-000134-NM
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 12:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702661330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+BGT/yzYmzJAONhIt/PjwHin02VEjL/ZDy2J/3Z2IoQ=;
 b=Djt4lI2M3msXhj8L3ElqLrHsHwik+d/EwIsYj2U9tk6cHhGEIeaDPX9f7gwDgEqRnI+Kyc
 aFqfTeSqy8YGfoFH1Cq5nyHI7pOmxsU/NDuCCGe2CIF7oWtA+rFPYulOe8iccGBkOEPrYs
 iytjSVsmS/oLmL7c/QHsu0lcttqmksI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-0BZj4Sk_NxaR5dRR7ni-ng-1; Fri, 15 Dec 2023 12:28:49 -0500
X-MC-Unique: 0BZj4Sk_NxaR5dRR7ni-ng-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D670C83DDE0;
 Fri, 15 Dec 2023 17:28:48 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.194.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A5C640C6EB9;
 Fri, 15 Dec 2023 17:28:47 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, si-wei.liu@oracle.com,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH for 9.0 08/12] vdpa: add vhost_vdpa_load_setup
Date: Fri, 15 Dec 2023 18:28:26 +0100
Message-Id: <20231215172830.2540987-9-eperezma@redhat.com>
In-Reply-To: <20231215172830.2540987-1-eperezma@redhat.com>
References: <20231215172830.2540987-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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

Callers can use this function to setup the incoming migration thread.

This thread is able to map the guest memory while the migration is
ongoing, without blocking QMP or other important tasks. While this
allows the destination QEMU not to block, it expands the mapping time
during migration instead of making it pre-migration.

This thread joins at vdpa backend device start, so it could happen that
the guest memory is so large that we still have guest memory to map
before this time.  This can be improved in later iterations, when the
destination device can inform QEMU that it is not ready to complete the
migration.

If the device is not started, the clean of the mapped memory is done at
.load_cleanup.  This is far from ideal, as the destination machine has
mapped all the guest ram for nothing, and now it needs to unmap it.
However, we don't have information about the state of the device so its
the best we can do.  Once iterative migration is supported, this will be
improved as we know the virtio state of the device.

If the VM migrates before finishing all the maps, the source will stop
but the destination is still not ready to continue, and it will wait
until all guest RAM is mapped.  It is still an improvement over doing
all the map when the migration finish, but next patches use the
switchover_ack method to prevent source to stop until all the memory is
mapped at the destination.

The memory unmapping if the device is not started is weird
too, as ideally nothing would be mapped.  This can be fixed when we
migrate the device state iteratively, and we know for sure if the device
is started or not.  At this moment we don't have such information so
there is no better alternative.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>

---
v1:
* Moved all the map thread members to another struct than
  VhostVDPAShared, so its memory and usage can be free from the moment
  the thread joins.

RFC v2:
* Use a dedicated thread for map instead of doing all in .load_setup,
  blocking QMP etc.

Other options considered:
* ThreadPool: It is hard to keep the order of the requests in this form.
  To send the worker thread to threadpool is also nice as the number of
  qemu threads can be controlled that way, but then vhost_vdpa_dev_map
  and similar cannot know if they are in the worker thread by checking
  with pthread_self. We can split the dma_map and similar in two
  functions, one checking if we can offload to thread map and other
  without it.
  Synchronization with qemu_thread_join is also lost. A semaphore,
  QemuEvent, or plain Mutex + Cond would be needed to synchronize list
  access, complicating the solution. Maps are heavy enough.
  Using coroutines have the same result.
* QIOTask: This is very nice as it does even have the task cleaner to
  run in the main thread, and I have a model to follow in
  dns-resolver.c. However, I still need to check if I'm in the main
  thread or not.

To be able to get rid of qemu_thread_is_self, we could create another
set of .dma_map_sync, .dma_unmap_sync, etc, and call the
(potentially) async versions from the listener or the 100% sure sync
version from the map thread. This makes the code more complex in my
opinion.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h |  28 ++++++
 hw/virtio/vhost-vdpa.c         | 166 ++++++++++++++++++++++++++++++++-
 2 files changed, 193 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 8f54e5edd4..b49286b327 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -17,6 +17,7 @@
 #include "hw/virtio/vhost-iova-tree.h"
 #include "hw/virtio/vhost-shadow-virtqueue.h"
 #include "hw/virtio/virtio.h"
+#include "qemu/thread.h"
 #include "standard-headers/linux/vhost_types.h"
 
 /*
@@ -30,6 +31,12 @@ typedef struct VhostVDPAHostNotifier {
     void *addr;
 } VhostVDPAHostNotifier;
 
+typedef struct VhostVDPAMapThread {
+    QemuThread thread;
+    GAsyncQueue *queue;
+    bool map_thread_enabled;
+} VhostVDPAMapThread;
+
 /* Info shared by all vhost_vdpa device models */
 typedef struct vhost_vdpa_shared {
     int device_fd;
@@ -43,8 +50,27 @@ typedef struct vhost_vdpa_shared {
     /* Copy of backend features */
     uint64_t backend_cap;
 
+    /*
+     * Thread to map memory in QEMU incoming migration.
+     *
+     * Incoming migration calls devices ->load_setup in the main thread, but
+     * map operations can take a long time with BLQ acquired.  This forbids
+     * QEMU to serve other requests like QMP.
+     *
+     * To solve it, offload the first listener operations until the first
+     * listener commit from the main thread.  Once these are served, join the
+     * map thread.
+     */
+    VhostVDPAMapThread *map_thread;
+
     bool iotlb_batch_begin_sent;
 
+    /*
+     * The memory listener has been registered, so DMA maps have been sent to
+     * the device.
+     */
+    bool listener_registered;
+
     /* Vdpa must send shadow addresses as IOTLB key for data queues, not GPA */
     bool shadow_data;
 } VhostVDPAShared;
@@ -73,6 +99,8 @@ int vhost_vdpa_dma_map(VhostVDPAShared *s, uint32_t asid, hwaddr iova,
                        hwaddr size, void *vaddr, bool readonly);
 int vhost_vdpa_dma_unmap(VhostVDPAShared *s, uint32_t asid, hwaddr iova,
                          hwaddr size);
+int vhost_vdpa_load_setup(VhostVDPAShared *s, AddressSpace *dma_as);
+int vhost_vdpa_load_cleanup(VhostVDPAShared *s, bool vhost_will_start);
 
 typedef struct vdpa_iommu {
     VhostVDPAShared *dev_shared;
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 43f7c382b1..339e11c58a 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -101,6 +101,16 @@ int vhost_vdpa_dma_map(VhostVDPAShared *s, uint32_t asid, hwaddr iova,
     msg.iotlb.perm = readonly ? VHOST_ACCESS_RO : VHOST_ACCESS_RW;
     msg.iotlb.type = VHOST_IOTLB_UPDATE;
 
+    if (s->map_thread && s->map_thread->map_thread_enabled &&
+        !qemu_thread_is_self(&s->map_thread->thread)) {
+        struct vhost_msg_v2 *new_msg = g_new(struct vhost_msg_v2, 1);
+
+        *new_msg = msg;
+        g_async_queue_push(s->map_thread->queue, new_msg);
+
+        return 0;
+    }
+
     trace_vhost_vdpa_dma_map(s, fd, msg.type, msg.asid, msg.iotlb.iova,
                              msg.iotlb.size, msg.iotlb.uaddr, msg.iotlb.perm,
                              msg.iotlb.type);
@@ -131,6 +141,16 @@ int vhost_vdpa_dma_unmap(VhostVDPAShared *s, uint32_t asid, hwaddr iova,
     msg.iotlb.size = size;
     msg.iotlb.type = VHOST_IOTLB_INVALIDATE;
 
+    if (s->map_thread && s->map_thread->map_thread_enabled &&
+        !qemu_thread_is_self(&s->map_thread->thread)) {
+        struct vhost_msg_v2 *new_msg = g_new(struct vhost_msg_v2, 1);
+
+        *new_msg = msg;
+        g_async_queue_push(s->map_thread->queue, new_msg);
+
+        return 0;
+    }
+
     trace_vhost_vdpa_dma_unmap(s, fd, msg.type, msg.asid, msg.iotlb.iova,
                                msg.iotlb.size, msg.iotlb.type);
 
@@ -156,6 +176,16 @@ static void vhost_vdpa_iotlb_batch_begin_once(VhostVDPAShared *s)
         return;
     }
 
+    if (s->map_thread && s->map_thread->map_thread_enabled &&
+        !qemu_thread_is_self(&s->map_thread->thread)) {
+        struct vhost_msg_v2 *new_msg = g_new(struct vhost_msg_v2, 1);
+
+        *new_msg = msg;
+        g_async_queue_push(s->map_thread->queue, new_msg);
+
+        return;
+    }
+
     trace_vhost_vdpa_listener_begin_batch(s, fd, msg.type, msg.iotlb.type);
     if (write(fd, &msg, sizeof(msg)) != sizeof(msg)) {
         error_report("failed to write, fd=%d, errno=%d (%s)",
@@ -180,6 +210,17 @@ static void vhost_vdpa_dma_end_batch(VhostVDPAShared *s)
     msg.type = VHOST_IOTLB_MSG_V2;
     msg.iotlb.type = VHOST_IOTLB_BATCH_END;
 
+    if (s->map_thread && s->map_thread->map_thread_enabled &&
+        !qemu_thread_is_self(&s->map_thread->thread)) {
+        struct vhost_msg_v2 *new_msg = g_new(struct vhost_msg_v2, 1);
+
+        *new_msg = msg;
+        g_async_queue_push(s->map_thread->queue, new_msg);
+        s->map_thread->map_thread_enabled = false;
+
+        return;
+    }
+
     trace_vhost_vdpa_listener_commit(s, fd, msg.type, msg.iotlb.type);
     if (write(fd, &msg, sizeof(msg)) != sizeof(msg)) {
         error_report("failed to write, fd=%d, errno=%d (%s)",
@@ -1288,6 +1329,88 @@ static void vhost_vdpa_suspend(struct vhost_dev *dev)
     vhost_vdpa_reset_device(dev);
 }
 
+static void *vhost_vdpa_load_map_worker(void *opaque)
+{
+    VhostVDPAShared *shared = opaque;
+    GPtrArray *ret = NULL;
+
+    while (true) {
+        g_autofree struct vhost_msg_v2 *msg = NULL;
+        int r = 0;
+
+        msg = g_async_queue_pop(shared->map_thread->queue);
+        switch (msg->iotlb.type) {
+        case VHOST_IOTLB_UPDATE:
+            r = vhost_vdpa_dma_map(shared, msg->asid, msg->iotlb.iova,
+                                   msg->iotlb.size,
+                                   (void *)(uintptr_t)msg->iotlb.uaddr,
+                                   msg->iotlb.perm == VHOST_ACCESS_RO);
+            break;
+        case VHOST_IOTLB_INVALIDATE:
+            r = vhost_vdpa_dma_unmap(shared, msg->asid, msg->iotlb.iova,
+                                     msg->iotlb.size);
+            break;
+        case VHOST_IOTLB_BATCH_BEGIN:
+            vhost_vdpa_iotlb_batch_begin_once(shared);
+            break;
+        case VHOST_IOTLB_BATCH_END:
+            vhost_vdpa_dma_end_batch(shared);
+            goto end;
+        default:
+            error_report("Invalid IOTLB msg type %d", msg->iotlb.type);
+            break;
+        };
+
+        if (unlikely(r != 0)) {
+            /* Add to failed iotlbs so we can remove it from iova_tree */
+            if (ret == NULL) {
+                ret = g_ptr_array_new_full(1, g_free);
+            }
+
+            g_ptr_array_add(ret, g_steal_pointer(&msg));
+        }
+    }
+
+end:
+    return ret;
+}
+
+static void vhost_vdpa_spawn_maps_thread(VhostVDPAShared *shared)
+{
+    shared->map_thread = g_new0(VhostVDPAMapThread, 1);
+    shared->map_thread->queue = g_async_queue_new();
+    qemu_thread_create(&shared->map_thread->thread, "vdpa map thread",
+                       vhost_vdpa_load_map_worker, shared,
+                       QEMU_THREAD_JOINABLE);
+    shared->map_thread->map_thread_enabled = true;
+}
+
+static bool vhost_vdpa_join_maps_thread(VhostVDPAShared *shared)
+{
+    g_autoptr(GPtrArray) failed_iova = NULL;
+
+    failed_iova = qemu_thread_join(&shared->map_thread->thread);
+    g_async_queue_unref(shared->map_thread->queue);
+    g_clear_pointer(&shared->map_thread, g_free);
+
+    if (likely(!failed_iova)) {
+        return true;
+    }
+
+    /* If it is a failed IOVA, abort starting */
+    for (size_t i = 0; failed_iova->len; ++i) {
+        struct vhost_msg_v2 *msg = g_ptr_array_index(failed_iova, i);
+        DMAMap mem_region = {
+            .iova = msg->iotlb.iova,
+            .size = msg->iotlb.size - 1, /* Inclusive */
+        };
+
+        vhost_iova_tree_remove(shared->iova_tree, mem_region);
+    }
+
+    return false;
+}
+
 static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
 {
     struct vhost_vdpa *v = dev->opaque;
@@ -1315,7 +1438,15 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
                          "IOMMU and try again");
             return -1;
         }
-        memory_listener_register(&v->shared->listener, dev->vdev->dma_as);
+        if (!v->shared->listener_registered) {
+            memory_listener_register(&v->shared->listener, dev->vdev->dma_as);
+            v->shared->listener_registered = true;
+        } else {
+            ok = vhost_vdpa_join_maps_thread(v->shared);
+            if (unlikely(!ok)) {
+                goto out_stop;
+            }
+        }
 
         return vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
     }
@@ -1340,6 +1471,8 @@ static void vhost_vdpa_reset_status(struct vhost_dev *dev)
     vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
                                VIRTIO_CONFIG_S_DRIVER);
     memory_listener_unregister(&v->shared->listener);
+    v->shared->listener_registered = false;
+
 }
 
 static int vhost_vdpa_set_log_base(struct vhost_dev *dev, uint64_t base,
@@ -1522,3 +1655,34 @@ const VhostOps vdpa_ops = {
         .vhost_set_config_call = vhost_vdpa_set_config_call,
         .vhost_reset_status = vhost_vdpa_reset_status,
 };
+
+int vhost_vdpa_load_setup(VhostVDPAShared *shared, AddressSpace *dma_as)
+{
+    uint8_t s = VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER;
+    int r = ioctl(shared->device_fd, VHOST_VDPA_SET_STATUS, &s);
+    if (unlikely(r < 0)) {
+        return r;
+    }
+
+    vhost_vdpa_spawn_maps_thread(shared);
+    memory_listener_register(&shared->listener, dma_as);
+    shared->listener_registered = true;
+    return 0;
+}
+
+int vhost_vdpa_load_cleanup(VhostVDPAShared *shared, bool vhost_will_start)
+{
+    if (shared->map_thread && !shared->map_thread->map_thread_enabled) {
+        return 0;
+    }
+
+    if (vhost_will_start) {
+        /*
+         * Delegate the join of map thread to vhost_vdpa_dev_start, as it runs
+         * out of main qemu lock.
+         */
+        return 0;
+    }
+
+    return vhost_vdpa_join_maps_thread(shared) ? 0 : -1;
+}
-- 
2.39.3


