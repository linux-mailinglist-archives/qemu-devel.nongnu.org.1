Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DCC7F7A1E
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 18:15:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Zlv-0004zW-UH; Fri, 24 Nov 2023 12:15:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1r6Zlb-0004u8-FD
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 12:14:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1r6ZlZ-0007Uq-VT
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 12:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700846097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=03R2z9ZlBcOIADCEWXSEL4pv+V1SmYU3+GZXyJ/Mxtc=;
 b=a+XgHc8NUYcE+4KjiyuItGjZMrBn64qt082Ivs+rEN36Wh9eZvpEFUeoye2uzlIahX7g4n
 XD/6ON+NjXUnPJ8wSJkAD9nK0QqkkRY6WfxCrMMPjd/RSL3pmj9CFs1H/gi/fyAF4Cez3o
 onuXUmSa6EHab8oo5VuuGXqyEpptbCg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-Iw3yztSWNTaegFx_I8qBFA-1; Fri, 24 Nov 2023 12:14:51 -0500
X-MC-Unique: Iw3yztSWNTaegFx_I8qBFA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1DAB82A6C4;
 Fri, 24 Nov 2023 17:14:50 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.192.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 13F4E40C6EB9;
 Fri, 24 Nov 2023 17:14:48 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Parav Pandit <parav@mellanox.com>, si-wei.liu@oracle.com,
 Stefano Garzarella <sgarzare@redhat.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Lei Yang <leiyang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 9.0 09/13] vdpa: remove msg type of vhost_vdpa
Date: Fri, 24 Nov 2023 18:14:26 +0100
Message-Id: <20231124171430.2964464-10-eperezma@redhat.com>
In-Reply-To: <20231124171430.2964464-1-eperezma@redhat.com>
References: <20231124171430.2964464-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

It is always VHOST_IOTLB_MSG_V2. We can always make it back per
vhost_dev if needed.

This change makes easier for vhost_vdpa_map and unmap not to depend on
vhost_vdpa but only in VhostVDPAShared.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h | 1 -
 hw/virtio/vhost-vdpa.c         | 9 ++++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 11ac14085a..5bd964dac5 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -49,7 +49,6 @@ typedef struct vhost_vdpa_shared {
 
 typedef struct vhost_vdpa {
     int index;
-    uint32_t msg_type;
     uint32_t address_space_id;
     MemoryListener listener;
     uint64_t acked_features;
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 458e46befd..38afcbf1c9 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -93,7 +93,7 @@ int vhost_vdpa_dma_map(struct vhost_vdpa *v, uint32_t asid, hwaddr iova,
     int fd = v->shared->device_fd;
     int ret = 0;
 
-    msg.type = v->msg_type;
+    msg.type = VHOST_IOTLB_MSG_V2;
     msg.asid = asid;
     msg.iotlb.iova = iova;
     msg.iotlb.size = size;
@@ -125,7 +125,7 @@ int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, uint32_t asid, hwaddr iova,
     int fd = v->shared->device_fd;
     int ret = 0;
 
-    msg.type = v->msg_type;
+    msg.type = VHOST_IOTLB_MSG_V2;
     msg.asid = asid;
     msg.iotlb.iova = iova;
     msg.iotlb.size = size;
@@ -147,7 +147,7 @@ static void vhost_vdpa_listener_begin_batch(struct vhost_vdpa *v)
 {
     int fd = v->shared->device_fd;
     struct vhost_msg_v2 msg = {
-        .type = v->msg_type,
+        .type = VHOST_IOTLB_MSG_V2,
         .iotlb.type = VHOST_IOTLB_BATCH_BEGIN,
     };
 
@@ -183,7 +183,7 @@ static void vhost_vdpa_listener_commit(MemoryListener *listener)
         return;
     }
 
-    msg.type = v->msg_type;
+    msg.type = VHOST_IOTLB_MSG_V2;
     msg.iotlb.type = VHOST_IOTLB_BATCH_END;
 
     trace_vhost_vdpa_listener_commit(v->shared, fd, msg.type, msg.iotlb.type);
@@ -593,7 +593,6 @@ static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque, Error **errp)
     v->dev = dev;
     dev->opaque =  opaque ;
     v->listener = vhost_vdpa_memory_listener;
-    v->msg_type = VHOST_IOTLB_MSG_V2;
     vhost_vdpa_init_svq(dev, v);
 
     error_propagate(&dev->migration_blocker, v->migration_blocker);
-- 
2.39.3


