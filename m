Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D853B01CFF
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Jul 2025 15:08:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDSZ-0004gy-EZ; Fri, 11 Jul 2025 09:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uaDPz-0000ll-67
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:04:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uaDPx-0004A3-5f
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752239036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=32lZPJFOdTlazqMfP+4COXRGoU2Ht4q+BadMeycbCg0=;
 b=Lf6jS8DIOtzDVCObtezGWRs63/UrxfzwL8qB1jqP+O7NYK+vW3hkLNbnUDQaQUcE4qXdti
 nCjBc1A2Ztne+zyUcHrfwQN/nqsbsa1m7Zbcrnvfc2SMX07XFndGQ2FXiB4BAYy5gvKAxb
 fyqYZQJO/hPZOmKDsLH3GAYwCMnrWb8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-eqARMib3Na28K_UUr0ZYHQ-1; Fri,
 11 Jul 2025 09:03:51 -0400
X-MC-Unique: eqARMib3Na28K_UUr0ZYHQ-1
X-Mimecast-MFC-AGG-ID: eqARMib3Na28K_UUr0ZYHQ_1752239029
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88FBC1808984; Fri, 11 Jul 2025 13:03:49 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.145])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BFD7D19560B6; Fri, 11 Jul 2025 13:03:43 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH RFC v2 10/13] vhost-net: implement extended features support
Date: Fri, 11 Jul 2025 15:02:15 +0200
Message-ID: <ad97c548f4c5c169ac322d0beb23976f8353be28.1752229731.git.pabeni@redhat.com>
In-Reply-To: <cover.1752229731.git.pabeni@redhat.com>
References: <cover.1752229731.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Provide extended version of the features manipulation helpers,
and let the device initialization deal with the full features space,
adjusting the relevant format strings accordingly.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
  - uint128_t -> uint64_t[]
  - provide extended variant of the features manipulation helpers
---
 hw/net/vhost_net-stub.c |  8 +++----
 hw/net/vhost_net.c      | 48 +++++++++++++++++++++++------------------
 include/net/vhost_net.h | 33 +++++++++++++++++++++++++---
 3 files changed, 60 insertions(+), 29 deletions(-)

diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
index 72df6d757e..f20b8a216d 100644
--- a/hw/net/vhost_net-stub.c
+++ b/hw/net/vhost_net-stub.c
@@ -47,9 +47,8 @@ void vhost_net_cleanup(struct vhost_net *net)
 {
 }
 
-uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features)
+void vhost_net_get_features_ex(struct vhost_net *net, uint64_t *features)
 {
-    return features;
 }
 
 int vhost_net_get_config(struct vhost_net *net,  uint8_t *config,
@@ -63,13 +62,12 @@ int vhost_net_set_config(struct vhost_net *net, const uint8_t *data,
     return 0;
 }
 
-void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
+void vhost_net_ack_features_ex(struct vhost_net *net, const uint64_t *features)
 {
 }
 
-uint64_t vhost_net_get_acked_features(VHostNetState *net)
+void vhost_net_get_acked_features_ex(VHostNetState *net, uint64_t *features)
 {
-    return 0;
 }
 
 bool vhost_net_virtqueue_pending(VHostNetState *net, int idx)
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 891f235a0a..bae595607a 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -121,10 +121,9 @@ static const int *vhost_net_get_feature_bits(struct vhost_net *net)
     return feature_bits;
 }
 
-uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features)
+void vhost_net_get_features_ex(struct vhost_net *net, uint64_t *features)
 {
-    return vhost_get_features(&net->dev, vhost_net_get_feature_bits(net),
-            features);
+    vhost_get_features_ex(&net->dev, vhost_net_get_feature_bits(net), features);
 }
 int vhost_net_get_config(struct vhost_net *net,  uint8_t *config,
                          uint32_t config_len)
@@ -137,10 +136,11 @@ int vhost_net_set_config(struct vhost_net *net, const uint8_t *data,
     return vhost_dev_set_config(&net->dev, data, offset, size, flags);
 }
 
-void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
+void vhost_net_ack_features_ex(struct vhost_net *net, const uint64_t *features)
 {
-    net->dev.acked_features = net->dev.backend_features;
-    vhost_ack_features(&net->dev, vhost_net_get_feature_bits(net), features);
+    virtio_features_copy(net->dev.acked_features_array,
+                         net->dev.backend_features_array);
+    vhost_ack_features_ex(&net->dev, vhost_net_get_feature_bits(net), features);
 }
 
 uint64_t vhost_net_get_max_queues(VHostNetState *net)
@@ -148,9 +148,9 @@ uint64_t vhost_net_get_max_queues(VHostNetState *net)
     return net->dev.max_queues;
 }
 
-uint64_t vhost_net_get_acked_features(VHostNetState *net)
+void vhost_net_get_acked_features_ex(VHostNetState *net, uint64_t *features)
 {
-    return net->dev.acked_features;
+    virtio_features_copy(features, net->dev.acked_features_array);
 }
 
 void vhost_net_save_acked_features(NetClientState *nc)
@@ -320,7 +320,8 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
     int r;
     bool backend_kernel = options->backend_type == VHOST_BACKEND_TYPE_KERNEL;
     struct vhost_net *net = g_new0(struct vhost_net, 1);
-    uint64_t features = 0;
+    uint64_t missing_features[VIRTIO_FEATURES_DWORDS];
+    uint64_t features[VIRTIO_FEATURES_DWORDS];
     Error *local_err = NULL;
 
     if (!options->net_backend) {
@@ -343,7 +344,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
         net->backend = r;
         net->dev.protocol_features = 0;
     } else {
-        net->dev.backend_features = 0;
+        virtio_features_clear(net->dev.backend_features_array);
         net->dev.protocol_features = 0;
         net->backend = -1;
 
@@ -361,12 +362,15 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
     if (backend_kernel) {
         if (!qemu_has_vnet_hdr_len(options->net_backend,
                                sizeof(struct virtio_net_hdr_mrg_rxbuf))) {
-            net->dev.features &= ~(1ULL << VIRTIO_NET_F_MRG_RXBUF);
+            net->dev.features &= ~VIRTIO_BIT(VIRTIO_NET_F_MRG_RXBUF);
         }
-        if (~net->dev.features & net->dev.backend_features) {
-            fprintf(stderr, "vhost lacks feature mask 0x%" PRIx64
-                   " for backend\n",
-                   (uint64_t)(~net->dev.features & net->dev.backend_features));
+
+        virtio_features_andnot(missing_features,
+                               net->dev.backend_features_array,
+                               net->dev.features_array);
+        if (!virtio_features_is_empty(missing_features)) {
+            fprintf(stderr, "vhost lacks feature mask 0x" VIRTIO_FEATURES_FMT
+                   " for backend\n", VIRTIO_FEATURES_PR(missing_features));
             goto fail;
         }
     }
@@ -374,17 +378,19 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
     /* Set sane init value. Override when guest acks. */
 #ifdef CONFIG_VHOST_NET_USER
     if (net->nc->info->type == NET_CLIENT_DRIVER_VHOST_USER) {
-        features = vhost_user_get_acked_features(net->nc);
-        if (~net->dev.features & features) {
-            fprintf(stderr, "vhost lacks feature mask 0x%" PRIx64
-                    " for backend\n",
-                    (uint64_t)(~net->dev.features & features));
+        virtio_features_from_u64(features,
+                                 vhost_user_get_acked_features(net->nc));
+        virtio_features_andnot(missing_features, features,
+                               net->dev.features_array);
+        if (!virtio_features_is_empty(missing_features)) {
+            fprintf(stderr, "vhost lacks feature mask 0x" VIRTIO_FEATURES_FMT
+                    " for backend\n", VIRTIO_FEATURES_PR(missing_features));
             goto fail;
         }
     }
 #endif
 
-    vhost_net_ack_features(net, features);
+    vhost_net_ack_features_ex(net, features);
 
     return net;
 
diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index c6a5361a2a..f30a206e73 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -2,6 +2,7 @@
 #define VHOST_NET_H
 
 #include "net/net.h"
+#include "hw/virtio/virtio-features.h"
 #include "hw/virtio/vhost-backend.h"
 
 struct vhost_net;
@@ -25,8 +26,26 @@ void vhost_net_stop(VirtIODevice *dev, NetClientState *ncs,
 
 void vhost_net_cleanup(VHostNetState *net);
 
-uint64_t vhost_net_get_features(VHostNetState *net, uint64_t features);
-void vhost_net_ack_features(VHostNetState *net, uint64_t features);
+void vhost_net_get_features_ex(VHostNetState *net, uint64_t *features);
+static inline uint64_t vhost_net_get_features(VHostNetState *net,
+                                              uint64_t features)
+{
+    uint64_t features_array[VIRTIO_FEATURES_DWORDS];
+
+    virtio_features_from_u64(features_array, features);
+    vhost_net_get_features_ex(net, features_array);
+    return features_array[0];
+}
+
+void vhost_net_ack_features_ex(VHostNetState *net, const uint64_t *features);
+static inline void vhost_net_ack_features(VHostNetState *net,
+                                          uint64_t features)
+{
+    uint64_t features_array[VIRTIO_FEATURES_DWORDS];
+
+    virtio_features_from_u64(features_array, features);
+    vhost_net_ack_features_ex(net, features_array);
+}
 
 int vhost_net_get_config(struct vhost_net *net,  uint8_t *config,
                          uint32_t config_len);
@@ -43,7 +62,15 @@ VHostNetState *get_vhost_net(NetClientState *nc);
 
 int vhost_set_vring_enable(NetClientState * nc, int enable);
 
-uint64_t vhost_net_get_acked_features(VHostNetState *net);
+void vhost_net_get_acked_features_ex(VHostNetState *net, uint64_t *features);
+static inline uint64_t vhost_net_get_acked_features(VHostNetState *net)
+{
+    uint64_t features[VIRTIO_FEATURES_DWORDS];
+
+    vhost_net_get_acked_features_ex(net, features);
+    assert(!virtio_features_use_extended(features));
+    return features[0];
+}
 
 int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu);
 
-- 
2.50.0


