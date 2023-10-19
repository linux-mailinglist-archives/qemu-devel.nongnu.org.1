Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B850A7CFCE2
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 16:36:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtU7W-0006kW-81; Thu, 19 Oct 2023 10:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qtU7T-0006jr-VS
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qtU7R-0000IS-4k
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697726124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0XfB+DObIiP4eTvSg1PgoX5MhSZT9hnKmTE2+ovbFn8=;
 b=hgLRcsFshhws8EGe+e+FZZhN79RYP/1AIfwLcm9JgefyCS7p6llNo0swl9HkYyzVoG5bjb
 h/oVFQadkau4cfBGhO9DIvsx71vCfsHoZV8zgiNWJ9yQUfMWhHGHGkJ/769FSpstlDHRbF
 w/SsjuRrtT8zxsQ6gWzRc3/ysl8OVV8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-8M-yedorOBm9yQcmBljMUg-1; Thu, 19 Oct 2023 10:35:15 -0400
X-MC-Unique: 8M-yedorOBm9yQcmBljMUg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E90E185A795;
 Thu, 19 Oct 2023 14:35:14 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.192.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67E05C15BB8;
 Thu, 19 Oct 2023 14:35:12 +0000 (UTC)
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
Subject: [RFC PATCH 06/18] vdpa: move file descriptor to vhost_vdpa_shared
Date: Thu, 19 Oct 2023 16:34:43 +0200
Message-Id: <20231019143455.2377694-7-eperezma@redhat.com>
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

Next patches will register the vhost_vdpa memory listener while the VM
is migrating at the destination, so we can map the memory to the device
before stopping the VM at the source.  The main goal is to reduce the
downtime.

However, the destination QEMU is unaware of which vhost_vdpa device will
register its memory_listener.  If the source guest has CVQ enabled, it
will be the CVQ device.  Otherwise, it  will be the first one.

Move the file descriptor to VhostVDPAShared so all vhost_vdpa can use
it, rather than always in the first / last vhost_vdpa.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h |  2 +-
 hw/virtio/vdpa-dev.c           |  2 +-
 hw/virtio/vhost-vdpa.c         | 14 +++++++-------
 net/vhost-vdpa.c               | 11 ++++-------
 4 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 01e0f25e27..796a180afa 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -32,6 +32,7 @@ typedef struct VhostVDPAHostNotifier {
 
 /* Info shared by all vhost_vdpa device models */
 typedef struct vhost_vdpa_shared {
+    int device_fd;
     struct vhost_vdpa_iova_range iova_range;
 
     /* IOVA mapping used by the Shadow Virtqueue */
@@ -42,7 +43,6 @@ typedef struct vhost_vdpa_shared {
 } VhostVDPAShared;
 
 typedef struct vhost_vdpa {
-    int device_fd;
     int index;
     uint32_t msg_type;
     bool iotlb_batch_begin_sent;
diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 457960d28a..8774986571 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -66,7 +66,6 @@ static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp)
     if (*errp) {
         return;
     }
-    v->vdpa.device_fd = v->vhostfd;
 
     v->vdev_id = vhost_vdpa_device_get_u32(v->vhostfd,
                                            VHOST_VDPA_GET_DEVICE_ID, errp);
@@ -115,6 +114,7 @@ static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp)
         goto free_vqs;
     }
     v->vdpa.shared = g_new0(VhostVDPAShared, 1);
+    v->vdpa.shared->device_fd = v->vhostfd;
     v->vdpa.shared->iova_range = iova_range;
 
     ret = vhost_dev_init(&v->dev, &v->vdpa, VHOST_BACKEND_TYPE_VDPA, 0, NULL);
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 4f52bfa9ee..298aefd065 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -90,7 +90,7 @@ int vhost_vdpa_dma_map(struct vhost_vdpa *v, uint32_t asid, hwaddr iova,
                        hwaddr size, void *vaddr, bool readonly)
 {
     struct vhost_msg_v2 msg = {};
-    int fd = v->device_fd;
+    int fd = v->shared->device_fd;
     int ret = 0;
 
     msg.type = v->msg_type;
@@ -122,7 +122,7 @@ int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, uint32_t asid, hwaddr iova,
                          hwaddr size)
 {
     struct vhost_msg_v2 msg = {};
-    int fd = v->device_fd;
+    int fd = v->shared->device_fd;
     int ret = 0;
 
     msg.type = v->msg_type;
@@ -145,7 +145,7 @@ int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, uint32_t asid, hwaddr iova,
 
 static void vhost_vdpa_listener_begin_batch(struct vhost_vdpa *v)
 {
-    int fd = v->device_fd;
+    int fd = v->shared->device_fd;
     struct vhost_msg_v2 msg = {
         .type = v->msg_type,
         .iotlb.type = VHOST_IOTLB_BATCH_BEGIN,
@@ -173,7 +173,7 @@ static void vhost_vdpa_listener_commit(MemoryListener *listener)
     struct vhost_vdpa *v = container_of(listener, struct vhost_vdpa, listener);
     struct vhost_dev *dev = v->dev;
     struct vhost_msg_v2 msg = {};
-    int fd = v->device_fd;
+    int fd = v->shared->device_fd;
 
     if (!(dev->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH))) {
         return;
@@ -498,7 +498,7 @@ static int vhost_vdpa_call(struct vhost_dev *dev, unsigned long int request,
                              void *arg)
 {
     struct vhost_vdpa *v = dev->opaque;
-    int fd = v->device_fd;
+    int fd = v->shared->device_fd;
     int ret;
 
     assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_VDPA);
@@ -656,7 +656,7 @@ static int vhost_vdpa_host_notifier_init(struct vhost_dev *dev, int queue_index)
     struct vhost_vdpa *v = dev->opaque;
     VirtIODevice *vdev = dev->vdev;
     VhostVDPAHostNotifier *n;
-    int fd = v->device_fd;
+    int fd = v->shared->device_fd;
     void *addr;
     char *name;
 
@@ -1285,7 +1285,7 @@ static void vhost_vdpa_suspend(struct vhost_dev *dev)
 
     if (dev->backend_cap & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) {
         trace_vhost_vdpa_suspend(dev);
-        r = ioctl(v->device_fd, VHOST_VDPA_SUSPEND);
+        r = ioctl(v->shared->device_fd, VHOST_VDPA_SUSPEND);
         if (unlikely(r)) {
             error_report("Cannot suspend: %s(%d)", g_strerror(errno), errno);
         } else {
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 01202350ea..4d42d7a742 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -233,14 +233,11 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
         vhost_net_cleanup(s->vhost_net);
         g_free(s->vhost_net);
         s->vhost_net = NULL;
-    }
-     if (s->vhost_vdpa.device_fd >= 0) {
-        qemu_close(s->vhost_vdpa.device_fd);
-        s->vhost_vdpa.device_fd = -1;
     }
     if (s->vhost_vdpa.index != 0) {
         return;
     }
+    qemu_close(s->vhost_vdpa.shared->device_fd);
     g_free(s->vhost_vdpa.shared);
 }
 
@@ -439,7 +436,7 @@ static int vhost_vdpa_set_address_space_id(struct vhost_vdpa *v,
     };
     int r;
 
-    r = ioctl(v->device_fd, VHOST_VDPA_SET_GROUP_ASID, &asid);
+    r = ioctl(v->shared->device_fd, VHOST_VDPA_SET_GROUP_ASID, &asid);
     if (unlikely(r < 0)) {
         error_report("Can't set vq group %u asid %u, errno=%d (%s)",
                      asid.index, asid.num, errno, g_strerror(errno));
@@ -535,7 +532,7 @@ static int vhost_vdpa_net_cvq_start(NetClientState *nc)
         return 0;
     }
 
-    cvq_group = vhost_vdpa_get_vring_group(v->device_fd,
+    cvq_group = vhost_vdpa_get_vring_group(v->shared->device_fd,
                                            v->dev->vq_index_end - 1,
                                            &err);
     if (unlikely(cvq_group < 0)) {
@@ -1439,7 +1436,6 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
     qemu_set_info_str(nc, TYPE_VHOST_VDPA);
     s = DO_UPCAST(VhostVDPAState, nc, nc);
 
-    s->vhost_vdpa.device_fd = vdpa_device_fd;
     s->vhost_vdpa.index = queue_pair_index;
     s->always_svq = svq;
     s->migration_state.notify = vdpa_net_migration_state_notifier;
@@ -1448,6 +1444,7 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
         vhost_vdpa_net_valid_svq_features(features,
                                           &s->vhost_vdpa.migration_blocker);
         s->vhost_vdpa.shared = g_new0(VhostVDPAShared, 1);
+        s->vhost_vdpa.shared->device_fd = vdpa_device_fd;
         s->vhost_vdpa.shared->iova_range = iova_range;
         s->vhost_vdpa.shared->shadow_data = svq;
     } else if (!is_datapath) {
-- 
2.39.3


