Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C4D81BD87
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:45:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGN5Q-000293-Ev; Thu, 21 Dec 2023 12:43:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rGN5I-00025p-O9
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:43:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rGN5H-0004UB-8k
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703180626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X1DbYgqk7ziG6yx4zIVFuyjJx5NuNdzxtgur0I7rsm0=;
 b=D2+6Bw0zfK0CavfvYHF18WBw+nSGnmHs6TdREO+IE2u4hHvaKlD/ti1YdDZ2CzanmBvuQo
 owmH9tipWbHwhkTs9KK9/fp87KybEXbCRZz1yL2Wo2jdrTisTWhD2J6hKMhTZ/wCGjXuVT
 mTy5sj3CnHxWz+A5aGaLoZ5sYxthpu8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-3EQqOzZBP4m3aFpb8475Qw-1; Thu,
 21 Dec 2023 12:43:42 -0500
X-MC-Unique: 3EQqOzZBP4m3aFpb8475Qw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CD223C2B60B;
 Thu, 21 Dec 2023 17:43:42 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6F7F492BC6;
 Thu, 21 Dec 2023 17:43:40 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 si-wei.liu@oracle.com, Laurent Vivier <lvivier@redhat.com>,
 Lei Yang <leiyang@redhat.com>
Subject: [PATCH v4 08/13] vdpa: move backend_cap to vhost_vdpa_shared
Date: Thu, 21 Dec 2023 18:43:17 +0100
Message-Id: <20231221174322.3130442-9-eperezma@redhat.com>
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

Move the backend_cap member to VhostVDPAShared so all vhost_vdpa can use
it, rather than always in the first / last vhost_vdpa.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h | 3 +++
 hw/virtio/vhost-vdpa.c         | 8 +++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 05219bbcf7..11ac14085a 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -38,6 +38,9 @@ typedef struct vhost_vdpa_shared {
     /* IOVA mapping used by the Shadow Virtqueue */
     VhostIOVATree *iova_tree;
 
+    /* Copy of backend features */
+    uint64_t backend_cap;
+
     bool iotlb_batch_begin_sent;
 
     /* Vdpa must send shadow addresses as IOTLB key for data queues, not GPA */
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 85b13e09f4..458e46befd 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -161,7 +161,7 @@ static void vhost_vdpa_listener_begin_batch(struct vhost_vdpa *v)
 
 static void vhost_vdpa_iotlb_batch_begin_once(struct vhost_vdpa *v)
 {
-    if (v->dev->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH) &&
+    if (v->shared->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH) &&
         !v->shared->iotlb_batch_begin_sent) {
         vhost_vdpa_listener_begin_batch(v);
     }
@@ -172,11 +172,10 @@ static void vhost_vdpa_iotlb_batch_begin_once(struct vhost_vdpa *v)
 static void vhost_vdpa_listener_commit(MemoryListener *listener)
 {
     struct vhost_vdpa *v = container_of(listener, struct vhost_vdpa, listener);
-    struct vhost_dev *dev = v->dev;
     struct vhost_msg_v2 msg = {};
     int fd = v->shared->device_fd;
 
-    if (!(dev->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH))) {
+    if (!(v->shared->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH))) {
         return;
     }
 
@@ -834,6 +833,8 @@ static int vhost_vdpa_set_features(struct vhost_dev *dev,
 
 static int vhost_vdpa_set_backend_cap(struct vhost_dev *dev)
 {
+    struct vhost_vdpa *v = dev->opaque;
+
     uint64_t features;
     uint64_t f = 0x1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2 |
         0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH |
@@ -855,6 +856,7 @@ static int vhost_vdpa_set_backend_cap(struct vhost_dev *dev)
     }
 
     dev->backend_cap = features;
+    v->shared->backend_cap = features;
 
     return 0;
 }
-- 
2.39.3


