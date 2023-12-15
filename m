Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D52181488B
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 13:54:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE7gq-0001hd-6E; Fri, 15 Dec 2023 07:53:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rE7go-0001h1-7I
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 07:53:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rE7gm-0001W8-IP
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 07:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702644791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5U4m8fIAMN0n6WTo/QLzpZYbobkarUjTFlCLBwhwyvM=;
 b=J1lw/SNvRSC0WxLUHOD/r9wVGWuUKu4EvuUAAX/WPzJ/TAbbBcVwmsVMKP1pEJBBD+FX7u
 LN43LKmg5wmJc4Rz4MCC9jpxKtc9yC88mVdt0evGKbwYjRE0yH0Sp9hoU+vUkl7/L0Wuom
 kk9HoMxGLVb2BoFwKX5r5/vX6hf9OPA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442--EuUT78aMXuvgikAZkjgqg-1; Fri, 15 Dec 2023 07:53:08 -0500
X-MC-Unique: -EuUT78aMXuvgikAZkjgqg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80BE085A58A;
 Fri, 15 Dec 2023 12:53:07 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.194.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA9E8492BC6;
 Fri, 15 Dec 2023 12:53:05 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, si-wei.liu@oracle.com,
 Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Lei Yang <leiyang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 9.0 v2 07/13] vdpa: move iotlb_batch_begin_sent to
 vhost_vdpa_shared
Date: Fri, 15 Dec 2023 13:52:44 +0100
Message-Id: <20231215125250.2483663-8-eperezma@redhat.com>
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

Next patches will register the vhost_vdpa memory listener while the VM
is migrating at the destination, so we can map the memory to the device
before stopping the VM at the source.  The main goal is to reduce the
downtime.

However, the destination QEMU is unaware of which vhost_vdpa device will
register its memory_listener.  If the source guest has CVQ enabled, it
will be the CVQ device.  Otherwise, it  will be the first one.

Move the iotlb_batch_begin_sent member to VhostVDPAShared so all
vhost_vdpa can use it, rather than always in the first / last
vhost_vdpa.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h | 3 ++-
 hw/virtio/vhost-vdpa.c         | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 796a180afa..05219bbcf7 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -38,6 +38,8 @@ typedef struct vhost_vdpa_shared {
     /* IOVA mapping used by the Shadow Virtqueue */
     VhostIOVATree *iova_tree;
 
+    bool iotlb_batch_begin_sent;
+
     /* Vdpa must send shadow addresses as IOTLB key for data queues, not GPA */
     bool shadow_data;
 } VhostVDPAShared;
@@ -45,7 +47,6 @@ typedef struct vhost_vdpa_shared {
 typedef struct vhost_vdpa {
     int index;
     uint32_t msg_type;
-    bool iotlb_batch_begin_sent;
     uint32_t address_space_id;
     MemoryListener listener;
     uint64_t acked_features;
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 095543395b..85b13e09f4 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -162,11 +162,11 @@ static void vhost_vdpa_listener_begin_batch(struct vhost_vdpa *v)
 static void vhost_vdpa_iotlb_batch_begin_once(struct vhost_vdpa *v)
 {
     if (v->dev->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH) &&
-        !v->iotlb_batch_begin_sent) {
+        !v->shared->iotlb_batch_begin_sent) {
         vhost_vdpa_listener_begin_batch(v);
     }
 
-    v->iotlb_batch_begin_sent = true;
+    v->shared->iotlb_batch_begin_sent = true;
 }
 
 static void vhost_vdpa_listener_commit(MemoryListener *listener)
@@ -180,7 +180,7 @@ static void vhost_vdpa_listener_commit(MemoryListener *listener)
         return;
     }
 
-    if (!v->iotlb_batch_begin_sent) {
+    if (!v->shared->iotlb_batch_begin_sent) {
         return;
     }
 
@@ -193,7 +193,7 @@ static void vhost_vdpa_listener_commit(MemoryListener *listener)
                      fd, errno, strerror(errno));
     }
 
-    v->iotlb_batch_begin_sent = false;
+    v->shared->iotlb_batch_begin_sent = false;
 }
 
 static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
-- 
2.39.3


