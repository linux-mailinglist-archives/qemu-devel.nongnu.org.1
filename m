Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD75B05433
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Jul 2025 10:11:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubajR-0005dQ-PY; Tue, 15 Jul 2025 04:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ubajC-0005bb-5O
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 04:09:30 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ubaj8-0002Pg-Db
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 04:09:29 -0400
Received: from [10.105.8.218] ([192.51.222.130]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56F87tWT033093
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 15 Jul 2025 17:07:56 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=HiQ/pSw7l2j0DIryjxyCnwtVk0l52eZq68BJAAQ1Xtk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1752566876; v=1;
 b=ENxKpLZ3f1fk5RuPvkVPiiHz8tP0w0IbdEretBBICh9UBIZEC7aoKrWFd1l0hY7d
 ryWI0uxxXY1r1wsfVujr2DR9z1OUzlGvDSOoOEW2Wgy7iISbzm0LidgGXc44Qtnb
 Zzu4kEDUvhy0j1VOc/plL1dO6/nHFIhASt3mpM2GxIWGmYkTC4SEc7+cEgZupMrE
 QIqLdExgNBHfvSCZWAddGLp7hrPt3bSdkxUm4FV/x6xcsIjY1K9U1tQC+3lv1rIe
 tHL4e1vzShs18CG2J0xVZCTxvw98cAFH+rF4DUhouAcoM7zX8zac4/KJcuADHtjz
 EP9r0WNtbB1kkKWq/u+T+g==
Message-ID: <f266ffe9-f601-46cc-85be-515475cbfe12@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 15 Jul 2025 17:07:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 13/13] net: implement UDP tunnel features offloading
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
 <509e49207e4dc4a10ef36492a2ee1f90f3c2c237.1752229731.git.pabeni@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <509e49207e4dc4a10ef36492a2ee1f90f3c2c237.1752229731.git.pabeni@redhat.com>
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
> When any host or guest GSO over UDP tunnel offload is enabled the
> virtio net header includes the additional tunnel-related fields,
> update the size accordingly.
> 
> Push the GSO over UDP tunnel offloads all the way down to the tap
> device extending the newly introduced NetFeatures struct, and
> eventually enable the associated features.
> 
> As per virtio specification, to convert features bit to offload bit,
> map the extended features into the reserved range.
> 
> Finally, make the vhost backend aware of the exact header layout, to
> copy it correctly. The tunnel-related field are present if either
> the guest or the host negotiated any UDP tunnel related feature:
> add them to host kernel supported features list, to allow qemu
> transfer to such backend the needed information.

Please also update: hw/virtio/virtio-qmp.c

> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>    - squashed vhost support into this patch
>    - dropped tun offload consistency checks; they are implemented in
>      the kernel side
>    - virtio_has_tnl_hdr ->virtio_has_tunnel_hdr
> ---
>   hw/net/vhost_net.c  |  2 ++
>   hw/net/virtio-net.c | 34 ++++++++++++++++++++++++++--------
>   include/net/net.h   |  2 ++
>   net/net.c           |  3 ++-
>   net/tap-linux.c     |  6 ++++++
>   5 files changed, 38 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index bae595607a..a15dc51d84 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -52,6 +52,8 @@ static const int kernel_feature_bits[] = {
>       VIRTIO_F_NOTIFICATION_DATA,
>       VIRTIO_NET_F_RSC_EXT,
>       VIRTIO_NET_F_HASH_REPORT,
> +    VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
> +    VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
>       VHOST_INVALID_FEATURE_BIT
>   };
>   
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 8ed1cad363..ff2f34d98a 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -103,6 +103,12 @@
>   #define VIRTIO_NET_F2O_SHIFT          (VIRTIO_NET_OFFLOAD_MAP_MIN - \
>                                          VIRTIO_NET_FEATURES_MAP_MIN + 64)
>   
> +static bool virtio_has_tunnel_hdr(const uint64_t *features)
> +{
> +    return virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
> +           virtio_has_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
> +}
> +
>   static const VirtIOFeature feature_sizes[] = {
>       {.flags = 1ULL << VIRTIO_NET_F_MAC,
>        .end = endof(struct virtio_net_config, mac)},
> @@ -659,7 +665,8 @@ static bool peer_has_tunnel(VirtIONet *n)
>   }
>   
>   static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
> -                                       int version_1, int hash_report)
> +                                       int version_1, int hash_report,
> +                                       int tunnel)
>   {
>       int i;
>       NetClientState *nc;
> @@ -667,9 +674,11 @@ static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
>       n->mergeable_rx_bufs = mergeable_rx_bufs;
>   
>       if (version_1) {
> -        n->guest_hdr_len = hash_report ?
> -            sizeof(struct virtio_net_hdr_v1_hash) :
> -            sizeof(struct virtio_net_hdr_mrg_rxbuf);
> +        n->guest_hdr_len = tunnel ?
> +            sizeof(struct virtio_net_hdr_v1_hash_tunnel) :
> +            (hash_report ?
> +             sizeof(struct virtio_net_hdr_v1_hash) :
> +             sizeof(struct virtio_net_hdr_mrg_rxbuf));
>           n->rss_data.populate_hash = !!hash_report;
>       } else {
>           n->guest_hdr_len = n->mergeable_rx_bufs ?
> @@ -886,6 +895,10 @@ static void virtio_net_apply_guest_offloads(VirtIONet *n)
>          .ufo  = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_UFO)),
>          .uso4 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO4)),
>          .uso6 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO6)),
> +       .tnl  = !!(n->curr_guest_offloads &
> +                  (1ULL << VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_MAPPED)),
> +       .tnl_csum = !!(n->curr_guest_offloads &
> +                      (1ULL << VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM_MAPPED)),
>       };
>   
>       qemu_set_offload(qemu_get_queue(n->nic)->peer, &ol);
> @@ -907,7 +920,9 @@ virtio_net_guest_offloads_by_features(const uint64_t *features)
>           (1ULL << VIRTIO_NET_F_GUEST_ECN)  |
>           (1ULL << VIRTIO_NET_F_GUEST_UFO)  |
>           (1ULL << VIRTIO_NET_F_GUEST_USO4) |
> -        (1ULL << VIRTIO_NET_F_GUEST_USO6);
> +        (1ULL << VIRTIO_NET_F_GUEST_USO6) |
> +        (1ULL << VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_MAPPED) |
> +        (1ULL << VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM_MAPPED);
>   
>       return guest_offloads_mask & virtio_net_features_to_offload(features);
>   }
> @@ -1020,7 +1035,8 @@ static void virtio_net_set_features(VirtIODevice *vdev,
>                                  virtio_has_feature_ex(features,
>                                                     VIRTIO_F_VERSION_1),
>                                  virtio_has_feature_ex(features,
> -                                                  VIRTIO_NET_F_HASH_REPORT));
> +                                                  VIRTIO_NET_F_HASH_REPORT),
> +                               virtio_has_tunnel_hdr(features));
>   
>       n->rsc4_enabled = virtio_has_feature_ex(features, VIRTIO_NET_F_RSC_EXT) &&
>           virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_TSO4);
> @@ -3132,13 +3148,15 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
>       VirtIONet *n = opaque;
>       VirtIODevice *vdev = VIRTIO_DEVICE(n);
>       int i, link_down;
> +    bool has_tunnel_hdr = virtio_has_tunnel_hdr(vdev->guest_features_array);
>   
>       trace_virtio_net_post_load_device();
>       virtio_net_set_mrg_rx_bufs(n, n->mergeable_rx_bufs,
>                                  virtio_vdev_has_feature(vdev,
>                                                          VIRTIO_F_VERSION_1),
>                                  virtio_vdev_has_feature(vdev,
> -                                                       VIRTIO_NET_F_HASH_REPORT));
> +                                                      VIRTIO_NET_F_HASH_REPORT),
> +                               has_tunnel_hdr);
>   
>       /* MAC_TABLE_ENTRIES may be different from the saved image */
>       if (n->mac_table.in_use > MAC_TABLE_ENTRIES) {
> @@ -3945,7 +3963,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>   
>       n->vqs[0].tx_waiting = 0;
>       n->tx_burst = n->net_conf.txburst;
> -    virtio_net_set_mrg_rx_bufs(n, 0, 0, 0);
> +    virtio_net_set_mrg_rx_bufs(n, 0, 0, 0, 0);
>       n->promisc = 1; /* for compatibility */
>   
>       n->mac_table.macs = g_malloc0(MAC_TABLE_ENTRIES * ETH_ALEN);
> diff --git a/include/net/net.h b/include/net/net.h
> index c71d7c6074..5049d293f2 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -43,6 +43,8 @@ typedef struct NetOffloads {
>       bool ufo;
>       bool uso4;
>       bool uso6;
> +    bool tnl;
> +    bool tnl_csum;
>   } NetOffloads;
>   
>   #define DEFINE_NIC_PROPERTIES(_state, _conf)                            \
> diff --git a/net/net.c b/net/net.c
> index 5a2f00c108..eb98c8a8b9 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -575,7 +575,8 @@ void qemu_set_vnet_hdr_len(NetClientState *nc, int len)
>   
>       assert(len == sizeof(struct virtio_net_hdr_mrg_rxbuf) ||
>              len == sizeof(struct virtio_net_hdr) ||
> -           len == sizeof(struct virtio_net_hdr_v1_hash));
> +           len == sizeof(struct virtio_net_hdr_v1_hash) ||
> +           len == sizeof(struct virtio_net_hdr_v1_hash_tunnel));
>   
>       nc->vnet_hdr_len = len;
>       nc->info->set_vnet_hdr_len(nc, len);
> diff --git a/net/tap-linux.c b/net/tap-linux.c
> index 4ec638add6..5e6c2d3cbd 100644
> --- a/net/tap-linux.c
> +++ b/net/tap-linux.c
> @@ -279,6 +279,12 @@ void tap_fd_set_offload(int fd, const NetOffloads *ol)
>           if (ol->uso6) {
>               offload |= TUN_F_USO6;
>           }
> +        if (ol->tnl) {
> +            offload |= TUN_F_UDP_TUNNEL_GSO;
> +        }
> +        if (ol->tnl_csum) {
> +            offload |= TUN_F_UDP_TUNNEL_GSO_CSUM;
> +        }
>       }
>   
>       if (ioctl(fd, TUNSETOFFLOAD, offload) != 0) {


