Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E89FADF20C
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Jun 2025 17:59:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRvAc-0003Fk-60; Wed, 18 Jun 2025 11:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uRvAX-0003F5-Ts
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 11:57:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uRvAV-00089h-4M
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 11:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750262262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VT/epj+hWtrtTUYjkPFrWfPk206BN+ojqPS0GojuHPA=;
 b=K33GB92FlTSGUcHC8/G2Z00WNIDSQUWd6DbjU58Bf46tWIGDP/OE5+/nntx6d+3U+dv4kM
 wrtxXLEYrXSOE7TwoTqO1zZX6kUZ33vzDomWFCmZ6bDjBwH+VRyAjVcC1O/hn5CbAmDXsR
 KTILoeeFRSMFvLEpM1bPa7GRCNZZUKA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-5Hjs37pcPOmeMabTHRDdfA-1; Wed,
 18 Jun 2025 11:57:39 -0400
X-MC-Unique: 5Hjs37pcPOmeMabTHRDdfA-1
X-Mimecast-MFC-AGG-ID: 5Hjs37pcPOmeMabTHRDdfA_1750262258
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B66B1956096; Wed, 18 Jun 2025 15:57:38 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.44.33.123])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E307218003FC; Wed, 18 Jun 2025 15:57:33 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 03/10] net: Introduce helper to identify vhost-user clients
Date: Wed, 18 Jun 2025 17:57:11 +0200
Message-ID: <20250618155718.550968-4-lvivier@redhat.com>
In-Reply-To: <20250618155718.550968-1-lvivier@redhat.com>
References: <20250618155718.550968-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
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

Currently, several parts of the codebase check if a network client is a
vhost-user backend by directly comparing its type against the
NET_CLIENT_DRIVER_VHOST_USER enum. This creates a tight coupling
between virtio/vhost-net drivers and the internal implementation
details of the vhost-user net client.

To improve abstraction and reduce this coupling, this patch introduces a
new helper function, qemu_is_vhost_user(). This function allows
callers to query if a client is of the vhost-user type without
needing to know about the specific enum value.

The mechanism uses a new is_vhost_user function pointer in the
NetClientInfo structure, which is implemented by the vhost-user
backend.

All existing direct checks are replaced with calls to the new helper.
This simplifies the logic in vhost_net.c and virtio-net.c,
making the code cleaner and more maintainable.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/net/vhost_net.c  | 33 +++++++++++++++------------------
 hw/net/virtio-net.c | 18 ++++++++++--------
 include/net/net.h   |  3 +++
 net/net.c           |  9 +++++++++
 net/vhost-user.c    |  8 ++++++++
 5 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 891f235a0a6e..41d21e687ed9 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -98,27 +98,24 @@ static const int user_feature_bits[] = {
 
 static const int *vhost_net_get_feature_bits(struct vhost_net *net)
 {
-    const int *feature_bits = 0;
+    if (net->nc->info->type == NET_CLIENT_DRIVER_TAP) {
+        return kernel_feature_bits;
+    }
+
+    if (qemu_is_vhost_user(net->nc)) {
+        return user_feature_bits;
+    }
 
-    switch (net->nc->info->type) {
-    case NET_CLIENT_DRIVER_TAP:
-        feature_bits = kernel_feature_bits;
-        break;
-    case NET_CLIENT_DRIVER_VHOST_USER:
-        feature_bits = user_feature_bits;
-        break;
 #ifdef CONFIG_VHOST_NET_VDPA
-    case NET_CLIENT_DRIVER_VHOST_VDPA:
-        feature_bits = vdpa_feature_bits;
-        break;
-#endif
-    default:
-        error_report("Feature bits not defined for this type: %d",
-                net->nc->info->type);
-        break;
+    if (net->nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
+        return vdpa_feature_bits;
     }
+#endif
 
-    return feature_bits;
+    error_report("Feature bits not defined for this type: %d",
+                 net->nc->info->type);
+
+    return 0;
 }
 
 uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features)
@@ -525,7 +522,7 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
          * because vhost user doesn't interrupt masking/unmasking
          * properly.
          */
-        if (net->nc->info->type == NET_CLIENT_DRIVER_VHOST_USER) {
+        if (qemu_is_vhost_user(net->nc)) {
             dev->use_guest_notifier_mask = false;
         }
      }
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index eb93607b8c76..1367d2b581b1 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -679,13 +679,15 @@ static int virtio_net_max_tx_queue_size(VirtIONet *n)
         return VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE;
     }
 
-    switch(peer->info->type) {
-    case NET_CLIENT_DRIVER_VHOST_USER:
-    case NET_CLIENT_DRIVER_VHOST_VDPA:
+    if (qemu_is_vhost_user(peer)) {
         return VIRTQUEUE_MAX_SIZE;
-    default:
-        return VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE;
-    };
+    }
+
+    if (peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
+        return VIRTQUEUE_MAX_SIZE;
+    }
+
+    return VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE;
 }
 
 static int peer_attach(VirtIONet *n, int index)
@@ -696,7 +698,7 @@ static int peer_attach(VirtIONet *n, int index)
         return 0;
     }
 
-    if (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_USER) {
+    if (qemu_is_vhost_user(nc->peer)) {
         vhost_set_vring_enable(nc->peer, 1);
     }
 
@@ -719,7 +721,7 @@ static int peer_detach(VirtIONet *n, int index)
         return 0;
     }
 
-    if (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_USER) {
+    if (qemu_is_vhost_user(nc->peer)) {
         vhost_set_vring_enable(nc->peer, 0);
     }
 
diff --git a/include/net/net.h b/include/net/net.h
index ac59b593ba48..2c3b22f564b6 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -67,6 +67,7 @@ typedef void (SocketReadStateFinalize)(SocketReadState *rs);
 typedef void (NetAnnounce)(NetClientState *);
 typedef bool (SetSteeringEBPF)(NetClientState *, int);
 typedef bool (NetCheckPeerType)(NetClientState *, ObjectClass *, Error **);
+typedef bool (IsVHostUser)(NetClientState *);
 
 typedef struct NetClientInfo {
     NetClientDriver type;
@@ -92,6 +93,7 @@ typedef struct NetClientInfo {
     NetAnnounce *announce;
     SetSteeringEBPF *set_steering_ebpf;
     NetCheckPeerType *check_peer_type;
+    IsVHostUser *is_vhost_user;
 } NetClientInfo;
 
 struct NetClientState {
@@ -191,6 +193,7 @@ int qemu_get_vnet_hdr_len(NetClientState *nc);
 void qemu_set_vnet_hdr_len(NetClientState *nc, int len);
 int qemu_set_vnet_le(NetClientState *nc, bool is_le);
 int qemu_set_vnet_be(NetClientState *nc, bool is_be);
+bool qemu_is_vhost_user(NetClientState *nc);
 void qemu_macaddr_default_if_unset(MACAddr *macaddr);
 /**
  * qemu_find_nic_info: Obtain NIC configuration information
diff --git a/net/net.c b/net/net.c
index cfa2d8e95827..8726c59915a3 100644
--- a/net/net.c
+++ b/net/net.c
@@ -586,6 +586,15 @@ int qemu_set_vnet_le(NetClientState *nc, bool is_le)
 #endif
 }
 
+bool qemu_is_vhost_user(NetClientState *nc)
+{
+    if (nc->info->is_vhost_user) {
+        return nc->info->is_vhost_user(nc);
+    }
+
+    return false;
+}
+
 int qemu_set_vnet_be(NetClientState *nc, bool is_be)
 {
 #if HOST_BIG_ENDIAN
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 10ac8dc0b3d7..4b4d02c56740 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -221,6 +221,13 @@ static bool vhost_user_check_peer_type(NetClientState *nc, ObjectClass *oc,
     return true;
 }
 
+static bool vhost_user_is_vhost_user(NetClientState *nc)
+{
+    assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_USER);
+
+    return true;
+}
+
 static NetClientInfo net_vhost_user_info = {
         .type = NET_CLIENT_DRIVER_VHOST_USER,
         .size = sizeof(NetVhostUserState),
@@ -231,6 +238,7 @@ static NetClientInfo net_vhost_user_info = {
         .set_vnet_be = vhost_user_set_vnet_endianness,
         .set_vnet_le = vhost_user_set_vnet_endianness,
         .check_peer_type = vhost_user_check_peer_type,
+        .is_vhost_user = vhost_user_is_vhost_user,
 };
 
 static gboolean net_vhost_user_watch(void *do_not_use, GIOCondition cond,
-- 
2.49.0


