Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E4FB0A1CD
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Jul 2025 13:19:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucj5y-0003qt-AA; Fri, 18 Jul 2025 07:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1ucj5o-0003oV-3y
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 07:17:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1ucj5l-0003uM-4g
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 07:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752837446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YReVffLO7ccUZ36cLOAWpiUJLjVS6oz9vXx9Vt/2vjk=;
 b=d9pujy9P4S3FRGiRsIN761PV9EIJbWZDsAj2wjVql2UIIk5SAyQ9fHQCKnFe6nAzfVtSmy
 peiGKGLrsGeWc8amUj5EHX8rLNT7PraV8vi5Eyvebc3KOVw1wiZnm3dwzB7y5F4XAok0fA
 Fxmib+qR3MdhURTxKBxg/9CMC5aujNg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-8lkM0xPOMVCxDY0nJhZuLw-1; Fri, 18 Jul 2025 07:17:24 -0400
X-MC-Unique: 8lkM0xPOMVCxDY0nJhZuLw-1
X-Mimecast-MFC-AGG-ID: 8lkM0xPOMVCxDY0nJhZuLw_1752837444
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7d44a260e45so293378685a.1
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 04:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752837444; x=1753442244;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YReVffLO7ccUZ36cLOAWpiUJLjVS6oz9vXx9Vt/2vjk=;
 b=XncJDirUykdSeeUe5n/QUq0LTJ4MdVBfqMDBpB+urtmJ2C0Yc32jprnPlLp8idQES3
 2HTIxEuQ0rkO/mYvGP+quF+KPAEkZG1eB0uGvU0RfSAB+YIj63cA0Lmaz2SfH1LUf/24
 +hNSOBgLqIT6lYCXFVi7+h1tVt5VIRIJx+K8sTJNPeFXg7uB7aWmYuKqBCrpiT/Fm0gM
 7TlAVispTNUlrUgDv5WhezNPFcUi4JOJhW1hypksI8AbSX3FNwjvu5J1wcpdeX+yaZVt
 kU+1R6bBJE5LxGmg14JNb2KhW9XW/VnnnMz6/J0M7KzyKr1aoxI+ZYgSEeNXTugbV+MK
 nw6A==
X-Gm-Message-State: AOJu0YzHkdLlBTiLfpUkad/utxPGv2UOLjsMw0REVLiUByZFi9T/3rwC
 w5JQDgKD4DZSA0l2mAoF+iGv/iKRnv2qTPWCJ4/ipfuU+wMIkNn09wJwYrji8oDNjR9mdzqp5fd
 d+qPRlqTmWYucTpZ73HdU2tHhjL1N9p69wTndW4FzdnmuBw9yWhxlE79W
X-Gm-Gg: ASbGncu41aBAtVdbZsYtn4DvQTcMJpzQWRO00KwjBjpFbZ1qA2T8Evi70NobM/di2TI
 AzqtRRjrrxZlhVGtEDceNX+NuJswHvlCncbIC73B6lExFzOe+HpUonfXHNnNvOcVXm6taeJuQE3
 EJls+hS4qfJZ2FpNFYVcp08FUCGRsxO1ucREIMQM6VAaPAwn+mTr4QBMUpmMBxtYlx1xG3xLI9h
 sCzSbv6VUdx1J71oQ4N+KsVd3q/doWS6EoNqysELSdeHiiKDn1KSCV61qJOhvt/OeS3778t4ck5
 WTzz+fksb8Q47EIrSgh3V4THBhzGnG+a5iRolDdAcqCFtZPq+S41iJNbLET0+0uGmUnWgSkyNQJ
 KM3YqBO/Xppx/AN0=
X-Received: by 2002:a05:620a:2307:b0:7e3:328c:b7eb with SMTP id
 af79cd13be357-7e34d25445cmr682677185a.21.1752837443726; 
 Fri, 18 Jul 2025 04:17:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeoTSCjNEDn6YPOcXJLjfEl/iaVC/Ax9s7b/Y58omqdTAce6UViDaLRWgZFRYvScwPqWnkZQ==
X-Received: by 2002:a05:620a:2307:b0:7e3:328c:b7eb with SMTP id
 af79cd13be357-7e34d25445cmr682673385a.21.1752837443185; 
 Fri, 18 Jul 2025 04:17:23 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it.
 [79.45.205.118]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356c63460sm73175885a.78.2025.07.18.04.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 04:17:22 -0700 (PDT)
Date: Fri, 18 Jul 2025 13:17:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH RFC v3 12/13] net: implement tunnel probing
Message-ID: <y5qbg4bbp7horugws4wwpqtqcbff47gt2lksc7ookom5mplcm5@7eesso3jebep>
References: <cover.1752828082.git.pabeni@redhat.com>
 <6ec36a1cc2497f827b9e024acc6adb2515dd9335.1752828082.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6ec36a1cc2497f827b9e024acc6adb2515dd9335.1752828082.git.pabeni@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 18, 2025 at 10:52:38AM +0200, Paolo Abeni wrote:
>Tap devices support GSO over UDP tunnel offload. Probe for such
>feature in a similar manner to other offloads.
>
>GSO over UDP tunnel needs to be enabled in addition to a "plain"
>offload (TSO or USO).
>
>No need to check separately for the outer header checksum offload:
>the kernel is going to support both of them or none.
>
>Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>---
>v2 -> v3:
>  - use bool type for tap_probe_has_tunnel()
>  - rebased on top of 2deec9ab7d ("virtio-net: Move
>        virtio_net_get_features() down")
>  - _array -> _ex
>
>v1 -> v2:
>  - peer_has_tunnel return a bool
>  - move TUN_F definition in net/tun-linux.h
>---
> hw/net/virtio-net.c | 37 +++++++++++++++++++++++++++++++++++++
> include/net/net.h   |  3 +++
> net/net.c           |  9 +++++++++
> net/tap-bsd.c       |  5 +++++
> net/tap-linux.c     | 11 +++++++++++
> net/tap-linux.h     |  9 +++++++++
> net/tap-solaris.c   |  5 +++++
> net/tap-stub.c      |  5 +++++
> net/tap.c           | 11 +++++++++++
> net/tap_int.h       |  1 +
> 10 files changed, 96 insertions(+)
>
>diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>index 53413ec4d5..70c85f7f77 100644
>--- a/hw/net/virtio-net.c
>+++ b/hw/net/virtio-net.c
>@@ -649,6 +649,15 @@ static int peer_has_uso(VirtIONet *n)
>     return qemu_has_uso(qemu_get_queue(n->nic)->peer);
> }
>
>+static bool peer_has_tunnel(VirtIONet *n)
>+{
>+    if (!peer_has_vnet_hdr(n)) {
>+        return false;
>+    }
>+
>+    return qemu_has_tunnel(qemu_get_queue(n->nic)->peer);
>+}
>+
> static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
>                                        int version_1, int hash_report)
> {
>@@ -3070,6 +3079,13 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
>         virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
>         virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
>
>+        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
>+        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
>+        virtio_clear_feature_ex(features,
>+                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
>+        virtio_clear_feature_ex(features,
>+                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
>+
>         virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
>     }
>
>@@ -3083,6 +3099,15 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
>         virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
>     }
>
>+    if (!peer_has_tunnel(n)) {
>+        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
>+        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
>+        virtio_clear_feature_ex(features,
>+                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
>+        virtio_clear_feature_ex(features,
>+                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
>+    }
>+
>     if (!get_vhost_net(nc->peer)) {
>         if (!use_own_hash) {
>             virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
>@@ -4137,6 +4162,10 @@ static const VMStateDescription vmstate_virtio_net = {
>     .dev_unplug_pending = dev_unplug_pending,
> };
>
>+#define DEFINE_PROP_FEATURE(_name, _state, _field, _bit, _defval)   \
>+    DEFINE_PROP_BIT64(_name, _state, _field[VIRTIO_DWORD(_bit)],    \
>+                      (_bit) % 64, _defval)
>+
> static const Property virtio_net_properties[] = {
>     DEFINE_PROP_BIT64("csum", VirtIONet, host_features,
>                     VIRTIO_NET_F_CSUM, true),
>@@ -4245,6 +4274,14 @@ static const Property virtio_net_properties[] = {
>                                   rss_data.specified_hash_types,
>                                   VIRTIO_NET_HASH_REPORT_UDPv6_EX - 1,
>                                   ON_OFF_AUTO_AUTO),
>+    DEFINE_PROP_FEATURE("host_tunnel", VirtIONet, host_features_ex,
>+                        VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO, true),
>+    DEFINE_PROP_FEATURE("host_tunnel_csum", VirtIONet, host_features_ex,
>+                        VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM, true),
>+    DEFINE_PROP_FEATURE("guest_tunnel", VirtIONet, host_features_ex,
>+                        VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO, true),
>+    DEFINE_PROP_FEATURE("guest_tunnel_csum", VirtIONet, host_features_ex,
>+                        VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM, true),

IIUC, to avoid issue with live-migration, we should disable all of them
in `hw_compat_10_0` in hw/core/machine.c (e.g. like `host_uso`, 
`guest_uso*` in hw_compat_8_1).

Thanks,
Stefano

> };
>
> static void virtio_net_class_init(ObjectClass *klass, const void *data)
>diff --git a/include/net/net.h b/include/net/net.h
>index 48ba333d02..9a9084690d 100644
>--- a/include/net/net.h
>+++ b/include/net/net.h
>@@ -65,6 +65,7 @@ typedef void (NetClientDestructor)(NetClientState *);
> typedef RxFilterInfo *(QueryRxFilter)(NetClientState *);
> typedef bool (HasUfo)(NetClientState *);
> typedef bool (HasUso)(NetClientState *);
>+typedef bool (HasTunnel)(NetClientState *);
> typedef bool (HasVnetHdr)(NetClientState *);
> typedef bool (HasVnetHdrLen)(NetClientState *, int);
> typedef void (SetOffload)(NetClientState *, const NetOffloads *);
>@@ -95,6 +96,7 @@ typedef struct NetClientInfo {
>     NetPoll *poll;
>     HasUfo *has_ufo;
>     HasUso *has_uso;
>+    HasTunnel *has_tunnel;
>     HasVnetHdr *has_vnet_hdr;
>     HasVnetHdrLen *has_vnet_hdr_len;
>     SetOffload *set_offload;
>@@ -197,6 +199,7 @@ void qemu_set_info_str(NetClientState *nc,
> void qemu_format_nic_info_str(NetClientState *nc, uint8_t macaddr[6]);
> bool qemu_has_ufo(NetClientState *nc);
> bool qemu_has_uso(NetClientState *nc);
>+bool qemu_has_tunnel(NetClientState *nc);
> bool qemu_has_vnet_hdr(NetClientState *nc);
> bool qemu_has_vnet_hdr_len(NetClientState *nc, int len);
> void qemu_set_offload(NetClientState *nc, const NetOffloads *ol);
>diff --git a/net/net.c b/net/net.c
>index 63872b6855..9536184a0c 100644
>--- a/net/net.c
>+++ b/net/net.c
>@@ -522,6 +522,15 @@ bool qemu_has_uso(NetClientState *nc)
>     return nc->info->has_uso(nc);
> }
>
>+bool qemu_has_tunnel(NetClientState *nc)
>+{
>+    if (!nc || !nc->info->has_tunnel) {
>+        return false;
>+    }
>+
>+    return nc->info->has_tunnel(nc);
>+}
>+
> bool qemu_has_vnet_hdr(NetClientState *nc)
> {
>     if (!nc || !nc->info->has_vnet_hdr) {
>diff --git a/net/tap-bsd.c b/net/tap-bsd.c
>index 86b6edee94..751d4c819c 100644
>--- a/net/tap-bsd.c
>+++ b/net/tap-bsd.c
>@@ -217,6 +217,11 @@ int tap_probe_has_uso(int fd)
>     return 0;
> }
>
>+bool tap_probe_has_tunnel(int fd)
>+{
>+    return false;
>+}
>+
> void tap_fd_set_vnet_hdr_len(int fd, int len)
> {
> }
>diff --git a/net/tap-linux.c b/net/tap-linux.c
>index a1c58f74f5..e2628be798 100644
>--- a/net/tap-linux.c
>+++ b/net/tap-linux.c
>@@ -196,6 +196,17 @@ int tap_probe_has_uso(int fd)
>     return 1;
> }
>
>+bool tap_probe_has_tunnel(int fd)
>+{
>+    unsigned offload;
>+
>+    offload = TUN_F_CSUM | TUN_F_TSO4 | TUN_F_UDP_TUNNEL_GSO;
>+    if (ioctl(fd, TUNSETOFFLOAD, offload) < 0) {
>+        return false;
>+    }
>+    return true;
>+}
>+
> void tap_fd_set_vnet_hdr_len(int fd, int len)
> {
>     if (ioctl(fd, TUNSETVNETHDRSZ, &len) == -1) {
>diff --git a/net/tap-linux.h b/net/tap-linux.h
>index 9a58cecb7f..8cd6b5874b 100644
>--- a/net/tap-linux.h
>+++ b/net/tap-linux.h
>@@ -53,4 +53,13 @@
> #define TUN_F_USO4    0x20    /* I can handle USO for IPv4 packets */
> #define TUN_F_USO6    0x40    /* I can handle USO for IPv6 packets */
>
>+/* I can handle TSO/USO for UDP tunneled packets */
>+#define TUN_F_UDP_TUNNEL_GSO       0x080
>+
>+/*
>+ * I can handle TSO/USO for UDP tunneled packets requiring csum offload for
>+ * the outer header
>+ */
>+#define TUN_F_UDP_TUNNEL_GSO_CSUM  0x100
>+
> #endif /* QEMU_TAP_LINUX_H */
>diff --git a/net/tap-solaris.c b/net/tap-solaris.c
>index 833c066bee..ac1ae25761 100644
>--- a/net/tap-solaris.c
>+++ b/net/tap-solaris.c
>@@ -222,6 +222,11 @@ int tap_probe_has_uso(int fd)
>     return 0;
> }
>
>+bool tap_probe_has_tunnel(int fd)
>+{
>+    return false;
>+}
>+
> void tap_fd_set_vnet_hdr_len(int fd, int len)
> {
> }
>diff --git a/net/tap-stub.c b/net/tap-stub.c
>index 67d14ad4d5..f7a5e0c163 100644
>--- a/net/tap-stub.c
>+++ b/net/tap-stub.c
>@@ -52,6 +52,11 @@ int tap_probe_has_uso(int fd)
>     return 0;
> }
>
>+bool tap_probe_has_tunnel(int fd)
>+{
>+    return false;
>+}
>+
> void tap_fd_set_vnet_hdr_len(int fd, int len)
> {
> }
>diff --git a/net/tap.c b/net/tap.c
>index b49db19f83..23c6c118e7 100644
>--- a/net/tap.c
>+++ b/net/tap.c
>@@ -76,6 +76,7 @@ typedef struct TAPState {
>     bool using_vnet_hdr;
>     bool has_ufo;
>     bool has_uso;
>+    bool has_tunnel;
>     bool enabled;
>     VHostNetState *vhost_net;
>     unsigned host_vnet_hdr_len;
>@@ -241,6 +242,14 @@ static bool tap_has_uso(NetClientState *nc)
>     return s->has_uso;
> }
>
>+static bool tap_has_tunnel(NetClientState *nc)
>+{
>+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
>+
>+    assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
>+    return s->has_tunnel;
>+}
>+
> static bool tap_has_vnet_hdr(NetClientState *nc)
> {
>     TAPState *s = DO_UPCAST(TAPState, nc, nc);
>@@ -369,6 +378,7 @@ static NetClientInfo net_tap_info = {
>     .cleanup = tap_cleanup,
>     .has_ufo = tap_has_ufo,
>     .has_uso = tap_has_uso,
>+    .has_tunnel = tap_has_tunnel,
>     .has_vnet_hdr = tap_has_vnet_hdr,
>     .has_vnet_hdr_len = tap_has_vnet_hdr_len,
>     .set_offload = tap_set_offload,
>@@ -398,6 +408,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
>     s->using_vnet_hdr = false;
>     s->has_ufo = tap_probe_has_ufo(s->fd);
>     s->has_uso = tap_probe_has_uso(s->fd);
>+    s->has_tunnel = tap_probe_has_tunnel(s->fd);
>     s->enabled = true;
>     tap_set_offload(&s->nc, &ol);
>     /*
>diff --git a/net/tap_int.h b/net/tap_int.h
>index f8bbe1cb0c..b76a05044b 100644
>--- a/net/tap_int.h
>+++ b/net/tap_int.h
>@@ -38,6 +38,7 @@ void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp);
> int tap_probe_vnet_hdr(int fd, Error **errp);
> int tap_probe_has_ufo(int fd);
> int tap_probe_has_uso(int fd);
>+bool tap_probe_has_tunnel(int fd);
> void tap_fd_set_offload(int fd, const NetOffloads *ol);
> void tap_fd_set_vnet_hdr_len(int fd, int len);
> int tap_fd_set_vnet_le(int fd, int vnet_is_le);
>-- 
>2.50.0
>


