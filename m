Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7A5B05435
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Jul 2025 10:11:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubakl-0001Lb-OC; Tue, 15 Jul 2025 04:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ubaki-0001Eq-OM
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 04:11:04 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ubakf-0002r6-S6
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 04:11:04 -0400
Received: from [10.105.8.218] ([192.51.222.130]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56F85KO3032018
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 15 Jul 2025 17:05:20 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=JyViDsh1eXEiM4hte2yquPE81rIabYAJdGz71WuDofU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1752566720; v=1;
 b=TpN9mnV2UZAoSBBF9Stds2knCpZspcJxU+R8g8bnji0OzxczkiRpUc3XCMjrUchb
 qmoLge3Z5NA8qcX3dVNDq8Gj2c7J2q/5bPZ517XDm9I4NIUeuDIOraS65mccmeW8
 1upK9xiNMobBI8VyM9vUem47eg1xkEq3Iy4yWO74fc5nbk+Cai7rCWsWOmLBZXWq
 +9lMGF+LTiJqcCWQew6WzAPZBw6HFDWu/oEiAf1yQgqZr9/lySfpc/T1dVTwzFtT
 j6fpgeDHk+JYxEfTj5sBvXuAZBvRwN7tDnC/HFIOeLAhKBgkdWU1YUTP6DPQVjgL
 Kg4+pB5prCwFjJuRjMnjEw==
Message-ID: <93de161a-3867-46aa-bfc0-2da951981bcf@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 15 Jul 2025 17:05:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 12/13] net: implement tunnel probing
To: Paolo Abeni <pabeni@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 kvm@vger.kernel.org
References: <cover.1752229731.git.pabeni@redhat.com>
 <94ffdec876d61f22a90e63d6a79ff5517d1c727c.1752229731.git.pabeni@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <94ffdec876d61f22a90e63d6a79ff5517d1c727c.1752229731.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/07/11 22:02, Paolo Abeni wrote:
> Tap devices support GSO over UDP tunnel offload. Probe for such
> feature in a similar manner to other offloads.
> 
> GSO over UDP tunnel needs to be enabled in addition to  a "plain"
> offload (TSO or USO).
> 
> No need to check separately for the outer header checksum offload:
> the kernel is going to support both of them or none.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>    - peer_has_tunnel return a bool
>    - move TUN_F definition in net/tun-linux.h
> ---
>   hw/net/virtio-net.c | 37 +++++++++++++++++++++++++++++++++++++
>   include/net/net.h   |  3 +++
>   net/net.c           |  9 +++++++++
>   net/tap-bsd.c       |  5 +++++
>   net/tap-linux.c     | 11 +++++++++++
>   net/tap-linux.h     |  9 +++++++++
>   net/tap-solaris.c   |  5 +++++
>   net/tap-stub.c      |  5 +++++
>   net/tap.c           | 11 +++++++++++
>   net/tap_int.h       |  1 +
>   10 files changed, 96 insertions(+)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 09d5ef1ece..8ed1cad363 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -649,6 +649,15 @@ static int peer_has_uso(VirtIONet *n)
>       return qemu_has_uso(qemu_get_queue(n->nic)->peer);
>   }
>   
> +static bool peer_has_tunnel(VirtIONet *n)
> +{
> +    if (!peer_has_vnet_hdr(n)) {
> +        return 0;

Please return "false" for type consistency.

> +    }
> +
> +    return qemu_has_tunnel(qemu_get_queue(n->nic)->peer);
> +}
> +
>   static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
>                                          int version_1, int hash_report)
>   {
> @@ -791,6 +800,13 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
>           virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
>           virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
>   
> +        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
> +        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
> +        virtio_clear_feature_ex(features,
> +                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
> +        virtio_clear_feature_ex(features,
> +                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
> +
>           virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
>       }
>   
> @@ -805,6 +821,15 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
>           virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
>       }
>   
> +    if (!peer_has_tunnel(n)) {
> +        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
> +        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
> +        virtio_clear_feature_ex(features,
> +                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
> +        virtio_clear_feature_ex(features,
> +                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
> +    }
> +
>       if (!get_vhost_net(nc->peer)) {
>           return;
>       }
> @@ -4087,6 +4112,10 @@ static const VMStateDescription vmstate_virtio_net = {
>       .dev_unplug_pending = dev_unplug_pending,
>   };
>   
> +#define DEFINE_PROP_FEATURE(_name, _state, _field, _bit, _defval)   \
> +    DEFINE_PROP_BIT64(_name, _state, _field[VIRTIO_DWORD(_bit)],    \
> +                      _bit & 0x3f, _defval)
> +
>   static const Property virtio_net_properties[] = {
>       DEFINE_PROP_BIT64("csum", VirtIONet, host_features,
>                       VIRTIO_NET_F_CSUM, true),
> @@ -4159,6 +4188,14 @@ static const Property virtio_net_properties[] = {
>                         VIRTIO_NET_F_GUEST_USO6, true),
>       DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
>                         VIRTIO_NET_F_HOST_USO, true),
> +    DEFINE_PROP_FEATURE("host_tunnel", VirtIONet, host_features_array,
> +                        VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO, true),
> +    DEFINE_PROP_FEATURE("host_tunnel_csum", VirtIONet, host_features_array,
> +                        VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM, true),
> +    DEFINE_PROP_FEATURE("guest_tunnel", VirtIONet, host_features_array,
> +                        VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO, true),
> +    DEFINE_PROP_FEATURE("guest_tunnel_csum", VirtIONet, host_features_array,
> +                        VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM, true),
>   };
>   
>   static void virtio_net_class_init(ObjectClass *klass, const void *data)
> diff --git a/include/net/net.h b/include/net/net.h
> index 5edea7671a..c71d7c6074 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -65,6 +65,7 @@ typedef void (NetClientDestructor)(NetClientState *);
>   typedef RxFilterInfo *(QueryRxFilter)(NetClientState *);
>   typedef bool (HasUfo)(NetClientState *);
>   typedef bool (HasUso)(NetClientState *);
> +typedef bool (HasTunnel)(NetClientState *);
>   typedef bool (HasVnetHdr)(NetClientState *);
>   typedef bool (HasVnetHdrLen)(NetClientState *, int);
>   typedef void (SetOffload)(NetClientState *, const NetOffloads *);
> @@ -93,6 +94,7 @@ typedef struct NetClientInfo {
>       NetPoll *poll;
>       HasUfo *has_ufo;
>       HasUso *has_uso;
> +    HasTunnel *has_tunnel;
>       HasVnetHdr *has_vnet_hdr;
>       HasVnetHdrLen *has_vnet_hdr_len;
>       SetOffload *set_offload;
> @@ -193,6 +195,7 @@ void qemu_set_info_str(NetClientState *nc,
>   void qemu_format_nic_info_str(NetClientState *nc, uint8_t macaddr[6]);
>   bool qemu_has_ufo(NetClientState *nc);
>   bool qemu_has_uso(NetClientState *nc);
> +bool qemu_has_tunnel(NetClientState *nc);
>   bool qemu_has_vnet_hdr(NetClientState *nc);
>   bool qemu_has_vnet_hdr_len(NetClientState *nc, int len);
>   void qemu_set_offload(NetClientState *nc, const NetOffloads *ol);
> diff --git a/net/net.c b/net/net.c
> index 053db7c314..5a2f00c108 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -522,6 +522,15 @@ bool qemu_has_uso(NetClientState *nc)
>       return nc->info->has_uso(nc);
>   }
>   
> +bool qemu_has_tunnel(NetClientState *nc)
> +{
> +    if (!nc || !nc->info->has_tunnel) {
> +        return false;
> +    }
> +
> +    return nc->info->has_tunnel(nc);
> +}
> +
>   bool qemu_has_vnet_hdr(NetClientState *nc)
>   {
>       if (!nc || !nc->info->has_vnet_hdr) {
> diff --git a/net/tap-bsd.c b/net/tap-bsd.c
> index 86b6edee94..e7de0672f4 100644
> --- a/net/tap-bsd.c
> +++ b/net/tap-bsd.c
> @@ -217,6 +217,11 @@ int tap_probe_has_uso(int fd)
>       return 0;
>   }
>   
> +int tap_probe_has_tunnel(int fd)

This should return bool for consistency.

> +{
> +    return 0;
> +}
> +
>   void tap_fd_set_vnet_hdr_len(int fd, int len)
>   {
>   }
> diff --git a/net/tap-linux.c b/net/tap-linux.c
> index a1c58f74f5..4ec638add6 100644
> --- a/net/tap-linux.c
> +++ b/net/tap-linux.c
> @@ -196,6 +196,17 @@ int tap_probe_has_uso(int fd)
>       return 1;
>   }
>   
> +int tap_probe_has_tunnel(int fd)
> +{
> +    unsigned offload;
> +
> +    offload = TUN_F_CSUM | TUN_F_TSO4 | TUN_F_UDP_TUNNEL_GSO;
> +    if (ioctl(fd, TUNSETOFFLOAD, offload) < 0) {
> +        return 0;
> +    }
> +    return 1;
> +}
> +
>   void tap_fd_set_vnet_hdr_len(int fd, int len)
>   {
>       if (ioctl(fd, TUNSETVNETHDRSZ, &len) == -1) {
> diff --git a/net/tap-linux.h b/net/tap-linux.h
> index 9a58cecb7f..8cd6b5874b 100644
> --- a/net/tap-linux.h
> +++ b/net/tap-linux.h
> @@ -53,4 +53,13 @@
>   #define TUN_F_USO4    0x20    /* I can handle USO for IPv4 packets */
>   #define TUN_F_USO6    0x40    /* I can handle USO for IPv6 packets */
>   
> +/* I can handle TSO/USO for UDP tunneled packets */
> +#define TUN_F_UDP_TUNNEL_GSO       0x080
> +
> +/*
> + * I can handle TSO/USO for UDP tunneled packets requiring csum offload for
> + * the outer header
> + */
> +#define TUN_F_UDP_TUNNEL_GSO_CSUM  0x100
> +
>   #endif /* QEMU_TAP_LINUX_H */
> diff --git a/net/tap-solaris.c b/net/tap-solaris.c
> index 833c066bee..ac09ae03c0 100644
> --- a/net/tap-solaris.c
> +++ b/net/tap-solaris.c
> @@ -222,6 +222,11 @@ int tap_probe_has_uso(int fd)
>       return 0;
>   }
>   
> +int tap_probe_has_tunnel(int fd)
> +{
> +    return 0;
> +}
> +
>   void tap_fd_set_vnet_hdr_len(int fd, int len)
>   {
>   }
> diff --git a/net/tap-stub.c b/net/tap-stub.c
> index 67d14ad4d5..66abbbc392 100644
> --- a/net/tap-stub.c
> +++ b/net/tap-stub.c
> @@ -52,6 +52,11 @@ int tap_probe_has_uso(int fd)
>       return 0;
>   }
>   
> +int tap_probe_has_tunnel(int fd)
> +{
> +    return 0;
> +}
> +
>   void tap_fd_set_vnet_hdr_len(int fd, int len)
>   {
>   }
> diff --git a/net/tap.c b/net/tap.c
> index 13e19130ce..c7612fb91b 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -58,6 +58,7 @@ typedef struct TAPState {
>       bool using_vnet_hdr;
>       bool has_ufo;
>       bool has_uso;
> +    bool has_tunnel;
>       bool enabled;
>       VHostNetState *vhost_net;
>       unsigned host_vnet_hdr_len;
> @@ -223,6 +224,14 @@ static bool tap_has_uso(NetClientState *nc)
>       return s->has_uso;
>   }
>   
> +static bool tap_has_tunnel(NetClientState *nc)
> +{
> +    TAPState *s = DO_UPCAST(TAPState, nc, nc);
> +
> +    assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
> +    return s->has_tunnel;
> +}
> +
>   static bool tap_has_vnet_hdr(NetClientState *nc)
>   {
>       TAPState *s = DO_UPCAST(TAPState, nc, nc);
> @@ -339,6 +348,7 @@ static NetClientInfo net_tap_info = {
>       .cleanup = tap_cleanup,
>       .has_ufo = tap_has_ufo,
>       .has_uso = tap_has_uso,
> +    .has_tunnel = tap_has_tunnel,
>       .has_vnet_hdr = tap_has_vnet_hdr,
>       .has_vnet_hdr_len = tap_has_vnet_hdr_len,
>       .set_offload = tap_set_offload,
> @@ -367,6 +377,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
>       s->using_vnet_hdr = false;
>       s->has_ufo = tap_probe_has_ufo(s->fd);
>       s->has_uso = tap_probe_has_uso(s->fd);
> +    s->has_tunnel = tap_probe_has_tunnel(s->fd);
>       s->enabled = true;
>       tap_set_offload(&s->nc, &ol);
>       /*
> diff --git a/net/tap_int.h b/net/tap_int.h
> index f8bbe1cb0c..327d10f68b 100644
> --- a/net/tap_int.h
> +++ b/net/tap_int.h
> @@ -38,6 +38,7 @@ void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp);
>   int tap_probe_vnet_hdr(int fd, Error **errp);
>   int tap_probe_has_ufo(int fd);
>   int tap_probe_has_uso(int fd);
> +int tap_probe_has_tunnel(int fd);
>   void tap_fd_set_offload(int fd, const NetOffloads *ol);
>   void tap_fd_set_vnet_hdr_len(int fd, int len);
>   int tap_fd_set_vnet_le(int fd, int vnet_is_le);


