Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 308B4BB9B97
	for <lists+qemu-devel@lfdr.de>; Sun, 05 Oct 2025 21:18:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UDr-0007Xg-Hm; Sun, 05 Oct 2025 15:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UDn-0007UC-5L
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UDl-0006Nm-2M
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GOY0xYbTallZrysMKoXU6E/qUfVtKp8T55T7WJoOLAE=;
 b=iqWTl6vKHomFOBRidzUKzPCvfR0wMxe485TOyD7rjVVw8OwRU8Y7pfmeGbu9dWcKMFV2DT
 mPiVOmvtEITMqY8y5smOoTrRYU0xPgALTRqbk48sZiSnTuGAmFE+utzGk9zJgyhrqQMmi/
 yIsXQzYVNq36jUbLILDaPS/sB64ljOE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-wMsA42EoOKKGU5UgszcCgg-1; Sun, 05 Oct 2025 15:16:34 -0400
X-MC-Unique: wMsA42EoOKKGU5UgszcCgg-1
X-Mimecast-MFC-AGG-ID: wMsA42EoOKKGU5UgszcCgg_1759691794
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42557bdbe50so2378846f8f.1
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691793; x=1760296593;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GOY0xYbTallZrysMKoXU6E/qUfVtKp8T55T7WJoOLAE=;
 b=udCkJW1J/CoJQMITMfoejgSEONxoDdAjXbnhjSVUpyWIrDmVN6xmRpPpzyC68V2dYg
 zqGhU58+t8noESEwwe88fUuBkU2BtCTyQti3J1jZgJGtRyzXdF9vMpJr3bYqRB8cMJd1
 KFfdCMAyuS7R73H0HGuD0rm3wLWzIkFb8UfGhFIaL8UW9J0vTng+3NHer2IXuSwTrl2I
 g6WiyB3sNbr6vGhVOI9y8qosAnImiQCm7FusSb2F9Gk+faktS/HQur/3m8hE2T+YlVTI
 PaF3VPWDlnzoTDoUTnRLsMzvFXl67LymhhxFXyHpzw3qw34DLoNn7jXkMCP8MLaC5g4b
 MiLw==
X-Gm-Message-State: AOJu0YwEgCHCQOnrcpSPEOUcqNGb4FHnbdnnaY9CbGI/TlFQNGt5gSGY
 6vY5NwyXpW9MkpHE6M2DLfl5l6uAItjcgc9eq/fs0CMV/brF/mpHoeX1uPcEpyYvAngjIkH7IM6
 4wlJ8dhvgJUc7E/tPb3lSqTcX22W39ZJrcw1Tyr3l4TdNtAwElFfccoZmcxRS650H2uvVoNqt8B
 lD8DAw8f/NNnHssxcyjr88ZumHZ+/UyEwrXg==
X-Gm-Gg: ASbGncuo5DliJDCx5gfMk6a2IwS9hWhWP9Km4xgiP8j9yJCcmHOH4Z3dcX7huphiQZX
 wDKKX0h5jIB8+WFd0hQrwfULJix+oZPgSOOj+aXboSrdoHSmvlrtdqx+DPE/XCfnYTxUXFWULMT
 8Ts66nXG9T6AuOCnxWRldYLaOEuLWU0vTTUffjJBRXBzjdz7nQmMsj6rqslfwWFUvKYZmpkmtH9
 RYIW86z246QiW/pGLA/q7m78CeovNaMxIP3LXG+3crmPTb39BGMu7CG6wV4g094m9V2Z8+wAtGa
 zCc2mdwR+L28MoT4twUQhGG5Iz0o8A9iob0JExA=
X-Received: by 2002:a05:600c:3404:b0:46e:25f2:705c with SMTP id
 5b1f17b1804b1-46e68bffeedmr72023635e9.13.1759691793144; 
 Sun, 05 Oct 2025 12:16:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFkL35SeNRQgm/lDSLzxAEg6n7QUVTB0rsoU/uQZ/9pJQE/AVfHkgz9qPjbgNx3Om+JOOytg==
X-Received: by 2002:a05:600c:3404:b0:46e:25f2:705c with SMTP id
 5b1f17b1804b1-46e68bffeedmr72023425e9.13.1759691792473; 
 Sun, 05 Oct 2025 12:16:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5c4afb3asm124981155e9.6.2025.10.05.12.16.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:16:31 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:16:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Abeni <pabeni@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 13/75] net: implement tunnel probing
Message-ID: <fffac046282c99801b62fa7fa1032cdc261bca6d.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Paolo Abeni <pabeni@redhat.com>

Tap devices support GSO over UDP tunnel offload. Probe for such
feature in a similar manner to other offloads.

GSO over UDP tunnel needs to be enabled in addition to a "plain"
offload (TSO or USO).

No need to check separately for the outer header checksum offload:
the kernel is going to support both of them or none.

The new features are disabled by default to avoid compat issues,
and could be enabled, after that hw_compat_10_1 will be added,
together with the related compat entries.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <a987a8a7613cbf33bb2209c7c7f5889b512638a7.1758549625.git.pabeni@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/net/net.h   |  3 +++
 net/tap-linux.h     |  9 +++++++++
 net/tap_int.h       |  1 +
 hw/net/virtio-net.c | 41 +++++++++++++++++++++++++++++++++++++++++
 net/net.c           |  9 +++++++++
 net/tap-bsd.c       |  5 +++++
 net/tap-linux.c     | 11 +++++++++++
 net/tap-solaris.c   |  5 +++++
 net/tap-stub.c      |  5 +++++
 net/tap.c           | 11 +++++++++++
 10 files changed, 100 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index 48ba333d02..9a9084690d 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -65,6 +65,7 @@ typedef void (NetClientDestructor)(NetClientState *);
 typedef RxFilterInfo *(QueryRxFilter)(NetClientState *);
 typedef bool (HasUfo)(NetClientState *);
 typedef bool (HasUso)(NetClientState *);
+typedef bool (HasTunnel)(NetClientState *);
 typedef bool (HasVnetHdr)(NetClientState *);
 typedef bool (HasVnetHdrLen)(NetClientState *, int);
 typedef void (SetOffload)(NetClientState *, const NetOffloads *);
@@ -95,6 +96,7 @@ typedef struct NetClientInfo {
     NetPoll *poll;
     HasUfo *has_ufo;
     HasUso *has_uso;
+    HasTunnel *has_tunnel;
     HasVnetHdr *has_vnet_hdr;
     HasVnetHdrLen *has_vnet_hdr_len;
     SetOffload *set_offload;
@@ -197,6 +199,7 @@ void qemu_set_info_str(NetClientState *nc,
 void qemu_format_nic_info_str(NetClientState *nc, uint8_t macaddr[6]);
 bool qemu_has_ufo(NetClientState *nc);
 bool qemu_has_uso(NetClientState *nc);
+bool qemu_has_tunnel(NetClientState *nc);
 bool qemu_has_vnet_hdr(NetClientState *nc);
 bool qemu_has_vnet_hdr_len(NetClientState *nc, int len);
 void qemu_set_offload(NetClientState *nc, const NetOffloads *ol);
diff --git a/net/tap-linux.h b/net/tap-linux.h
index 9a58cecb7f..8cd6b5874b 100644
--- a/net/tap-linux.h
+++ b/net/tap-linux.h
@@ -53,4 +53,13 @@
 #define TUN_F_USO4    0x20    /* I can handle USO for IPv4 packets */
 #define TUN_F_USO6    0x40    /* I can handle USO for IPv6 packets */
 
+/* I can handle TSO/USO for UDP tunneled packets */
+#define TUN_F_UDP_TUNNEL_GSO       0x080
+
+/*
+ * I can handle TSO/USO for UDP tunneled packets requiring csum offload for
+ * the outer header
+ */
+#define TUN_F_UDP_TUNNEL_GSO_CSUM  0x100
+
 #endif /* QEMU_TAP_LINUX_H */
diff --git a/net/tap_int.h b/net/tap_int.h
index f8bbe1cb0c..b76a05044b 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -38,6 +38,7 @@ void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp);
 int tap_probe_vnet_hdr(int fd, Error **errp);
 int tap_probe_has_ufo(int fd);
 int tap_probe_has_uso(int fd);
+bool tap_probe_has_tunnel(int fd);
 void tap_fd_set_offload(int fd, const NetOffloads *ol);
 void tap_fd_set_vnet_hdr_len(int fd, int len);
 int tap_fd_set_vnet_le(int fd, int vnet_is_le);
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 39f2a8c987..f8e2b4823e 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -649,6 +649,15 @@ static int peer_has_uso(VirtIONet *n)
     return qemu_has_uso(qemu_get_queue(n->nic)->peer);
 }
 
+static bool peer_has_tunnel(VirtIONet *n)
+{
+    if (!peer_has_vnet_hdr(n)) {
+        return false;
+    }
+
+    return qemu_has_tunnel(qemu_get_queue(n->nic)->peer);
+}
+
 static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
                                        int version_1, int hash_report)
 {
@@ -3079,6 +3088,13 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
         virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
         virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
 
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
+        virtio_clear_feature_ex(features,
+                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
+        virtio_clear_feature_ex(features,
+                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
+
         virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
     }
 
@@ -3092,6 +3108,15 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
         virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
     }
 
+    if (!peer_has_tunnel(n)) {
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
+        virtio_clear_feature_ex(features,
+                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
+        virtio_clear_feature_ex(features,
+                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
+    }
+
     if (!get_vhost_net(nc->peer)) {
         if (!use_own_hash) {
             virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
@@ -4254,6 +4279,22 @@ static const Property virtio_net_properties[] = {
                                   rss_data.specified_hash_types,
                                   VIRTIO_NET_HASH_REPORT_UDPv6_EX - 1,
                                   ON_OFF_AUTO_AUTO),
+    VIRTIO_DEFINE_PROP_FEATURE("host_tunnel", VirtIONet,
+                               host_features_ex,
+                               VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
+                               false),
+    VIRTIO_DEFINE_PROP_FEATURE("host_tunnel_csum", VirtIONet,
+                               host_features_ex,
+                               VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM,
+                               false),
+    VIRTIO_DEFINE_PROP_FEATURE("guest_tunnel", VirtIONet,
+                               host_features_ex,
+                               VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
+                               false),
+    VIRTIO_DEFINE_PROP_FEATURE("guest_tunnel_csum", VirtIONet,
+                               host_features_ex,
+                               VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM,
+                               false),
 };
 
 static void virtio_net_class_init(ObjectClass *klass, const void *data)
diff --git a/net/net.c b/net/net.c
index 63872b6855..9536184a0c 100644
--- a/net/net.c
+++ b/net/net.c
@@ -522,6 +522,15 @@ bool qemu_has_uso(NetClientState *nc)
     return nc->info->has_uso(nc);
 }
 
+bool qemu_has_tunnel(NetClientState *nc)
+{
+    if (!nc || !nc->info->has_tunnel) {
+        return false;
+    }
+
+    return nc->info->has_tunnel(nc);
+}
+
 bool qemu_has_vnet_hdr(NetClientState *nc)
 {
     if (!nc || !nc->info->has_vnet_hdr) {
diff --git a/net/tap-bsd.c b/net/tap-bsd.c
index 38eb28cb58..bbf84d1828 100644
--- a/net/tap-bsd.c
+++ b/net/tap-bsd.c
@@ -225,6 +225,11 @@ int tap_probe_has_uso(int fd)
     return 0;
 }
 
+bool tap_probe_has_tunnel(int fd)
+{
+    return false;
+}
+
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
diff --git a/net/tap-linux.c b/net/tap-linux.c
index 79a9dd0da0..98b0ae9602 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -201,6 +201,17 @@ int tap_probe_has_uso(int fd)
     return 1;
 }
 
+bool tap_probe_has_tunnel(int fd)
+{
+    unsigned offload;
+
+    offload = TUN_F_CSUM | TUN_F_TSO4 | TUN_F_UDP_TUNNEL_GSO;
+    if (ioctl(fd, TUNSETOFFLOAD, offload) < 0) {
+        return false;
+    }
+    return true;
+}
+
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
     if (ioctl(fd, TUNSETVNETHDRSZ, &len) == -1) {
diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index ef8e0feeb0..75397e6c54 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -227,6 +227,11 @@ int tap_probe_has_uso(int fd)
     return 0;
 }
 
+bool tap_probe_has_tunnel(int fd)
+{
+    return false;
+}
+
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
diff --git a/net/tap-stub.c b/net/tap-stub.c
index 67d14ad4d5..f7a5e0c163 100644
--- a/net/tap-stub.c
+++ b/net/tap-stub.c
@@ -52,6 +52,11 @@ int tap_probe_has_uso(int fd)
     return 0;
 }
 
+bool tap_probe_has_tunnel(int fd)
+{
+    return false;
+}
+
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
diff --git a/net/tap.c b/net/tap.c
index df23283744..5124372316 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -76,6 +76,7 @@ typedef struct TAPState {
     bool using_vnet_hdr;
     bool has_ufo;
     bool has_uso;
+    bool has_tunnel;
     bool enabled;
     VHostNetState *vhost_net;
     unsigned host_vnet_hdr_len;
@@ -246,6 +247,14 @@ static bool tap_has_uso(NetClientState *nc)
     return s->has_uso;
 }
 
+static bool tap_has_tunnel(NetClientState *nc)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+
+    assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
+    return s->has_tunnel;
+}
+
 static bool tap_has_vnet_hdr(NetClientState *nc)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
@@ -374,6 +383,7 @@ static NetClientInfo net_tap_info = {
     .cleanup = tap_cleanup,
     .has_ufo = tap_has_ufo,
     .has_uso = tap_has_uso,
+    .has_tunnel = tap_has_tunnel,
     .has_vnet_hdr = tap_has_vnet_hdr,
     .has_vnet_hdr_len = tap_has_vnet_hdr_len,
     .set_offload = tap_set_offload,
@@ -403,6 +413,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
     s->using_vnet_hdr = false;
     s->has_ufo = tap_probe_has_ufo(s->fd);
     s->has_uso = tap_probe_has_uso(s->fd);
+    s->has_tunnel = tap_probe_has_tunnel(s->fd);
     s->enabled = true;
     tap_set_offload(&s->nc, &ol);
     /*
-- 
MST


