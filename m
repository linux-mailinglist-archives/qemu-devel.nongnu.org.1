Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5EC7F7A23
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 18:16:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6ZlM-0004pT-Po; Fri, 24 Nov 2023 12:14:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1r6ZlK-0004of-Gq
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 12:14:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1r6ZlI-0007SL-JT
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 12:14:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700846080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JXCH/z44fCfzIXYUpuGN4qdD+G+/rDHtJEGJFxXKKX8=;
 b=fMJ1I6TIy8UBi9RCv8jsIcN9pbjhS0+HAHhfvjqeUSipuIrNF6OFXEAGJjyAL2C37tNAA1
 mUpOu7IIarIxCyJbPglVi1QmixT6+o+WH8QqVWcZaDWklfqnBbe4dT3k8Nu5Dr3IbYhngd
 4MF948zxMLd8rLBarGuRuHb9XB+rXyY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-2G8XsFVRP12FdDCMhkYjEg-1; Fri, 24 Nov 2023 12:14:36 -0500
X-MC-Unique: 2G8XsFVRP12FdDCMhkYjEg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02C5A811E8D;
 Fri, 24 Nov 2023 17:14:36 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.192.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48FBE40C6EBD;
 Fri, 24 Nov 2023 17:14:34 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Parav Pandit <parav@mellanox.com>, si-wei.liu@oracle.com,
 Stefano Garzarella <sgarzare@redhat.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Lei Yang <leiyang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 9.0 01/13] vdpa: add VhostVDPAShared
Date: Fri, 24 Nov 2023 18:14:18 +0100
Message-Id: <20231124171430.2964464-2-eperezma@redhat.com>
In-Reply-To: <20231124171430.2964464-1-eperezma@redhat.com>
References: <20231124171430.2964464-1-eperezma@redhat.com>
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

It will hold properties shared among all vhost_vdpa instances associated
with of the same device.  For example, we just need one iova_tree or one
memory listener for the entire device.

Next patches will register the vhost_vdpa memory listener at the
beginning of the VM migration at the destination. This enables QEMU to
map the memory to the device before stopping the VM at the source,
instead of doing while both source and destination are stopped, thus
minimizing the downtime.

However, the destination QEMU is unaware of which vhost_vdpa struct will
register its memory_listener.  If the source guest has CVQ enabled, it
will be the one associated with the CVQ.  Otherwise, it will be the
first one.

Save the memory operations related members in a common place rather than
always in the first / last vhost_vdpa.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h |  5 +++++
 net/vhost-vdpa.c               | 24 ++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 5407d54fd7..eb1a56d75a 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -30,6 +30,10 @@ typedef struct VhostVDPAHostNotifier {
     void *addr;
 } VhostVDPAHostNotifier;
 
+/* Info shared by all vhost_vdpa device models */
+typedef struct vhost_vdpa_shared {
+} VhostVDPAShared;
+
 typedef struct vhost_vdpa {
     int device_fd;
     int index;
@@ -46,6 +50,7 @@ typedef struct vhost_vdpa {
     bool suspended;
     /* IOVA mapping used by the Shadow Virtqueue */
     VhostIOVATree *iova_tree;
+    VhostVDPAShared *shared;
     GPtrArray *shadow_vqs;
     const VhostShadowVirtqueueOps *shadow_vq_ops;
     void *shadow_vq_ops_opaque;
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index d0614d7954..8b661b9e6d 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -240,6 +240,10 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
         qemu_close(s->vhost_vdpa.device_fd);
         s->vhost_vdpa.device_fd = -1;
     }
+    if (s->vhost_vdpa.index != 0) {
+        return;
+    }
+    g_free(s->vhost_vdpa.shared);
 }
 
 /** Dummy SetSteeringEBPF to support RSS for vhost-vdpa backend  */
@@ -1661,6 +1665,7 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
                                        bool svq,
                                        struct vhost_vdpa_iova_range iova_range,
                                        uint64_t features,
+                                       VhostVDPAShared *shared,
                                        Error **errp)
 {
     NetClientState *nc = NULL;
@@ -1696,6 +1701,7 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
     if (queue_pair_index == 0) {
         vhost_vdpa_net_valid_svq_features(features,
                                           &s->vhost_vdpa.migration_blocker);
+        s->vhost_vdpa.shared = g_new0(VhostVDPAShared, 1);
     } else if (!is_datapath) {
         s->cvq_cmd_out_buffer = mmap(NULL, vhost_vdpa_net_cvq_cmd_page_len(),
                                      PROT_READ | PROT_WRITE,
@@ -1708,11 +1714,16 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
         s->vhost_vdpa.shadow_vq_ops_opaque = s;
         s->cvq_isolated = cvq_isolated;
     }
+    if (queue_pair_index != 0) {
+        s->vhost_vdpa.shared = shared;
+    }
+
     ret = vhost_vdpa_add(nc, (void *)&s->vhost_vdpa, queue_pair_index, nvqs);
     if (ret) {
         qemu_del_net_client(nc);
         return NULL;
     }
+
     return nc;
 }
 
@@ -1824,17 +1835,26 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
     ncs = g_malloc0(sizeof(*ncs) * queue_pairs);
 
     for (i = 0; i < queue_pairs; i++) {
+        VhostVDPAShared *shared = NULL;
+
+        if (i) {
+            shared = DO_UPCAST(VhostVDPAState, nc, ncs[0])->vhost_vdpa.shared;
+        }
         ncs[i] = net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
                                      vdpa_device_fd, i, 2, true, opts->x_svq,
-                                     iova_range, features, errp);
+                                     iova_range, features, shared, errp);
         if (!ncs[i])
             goto err;
     }
 
     if (has_cvq) {
+        VhostVDPAState *s0 = DO_UPCAST(VhostVDPAState, nc, ncs[0]);
+        VhostVDPAShared *shared = s0->vhost_vdpa.shared;
+
         nc = net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
                                  vdpa_device_fd, i, 1, false,
-                                 opts->x_svq, iova_range, features, errp);
+                                 opts->x_svq, iova_range, features, shared,
+                                 errp);
         if (!nc)
             goto err;
     }
-- 
2.39.3


