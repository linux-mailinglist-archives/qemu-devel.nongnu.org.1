Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB40E75A388
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 02:43:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMHk3-0002Mb-9w; Wed, 19 Jul 2023 20:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qMHk1-0002MH-77
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 20:42:02 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qMHjz-0000x6-C6
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 20:42:00 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1b056276889so184538fac.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 17:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1689813718; x=1690418518;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b986sThxm+B2ufQzn8ktFg/y2xZVhvuUzxWgokvgncg=;
 b=vobdIZQgtkBpmlqIY2kfKV75g5SLmBYKA9OgEjdEvaQklDziL3+NVTEzR5rFsG/gLE
 +8pEnqd04IkEudYrDuQhAuxKZXR2anoK7fKHtNHESmUNFQIH2Wdx3J0fT0fqAelOdNJN
 rClkTkQ1n+rBD2PtJ/6AMarszCk5aw4qb3D5GwFVVfAwSPsOdar4adpmcWH+ZBRF2W3x
 I8D2hebHaMZek7DGXS2gqtF1ZkiPzFjIn+Bi8RZlfj7BOr9H5lYIEpMwDA+e4JG+K3IJ
 hklQadQ6zIKWgFYiG5cELiqbGXPyhsJU2tWcrwpcKZ0t0IYPOou9m+Ec4LZLdilsIYiq
 qIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689813718; x=1690418518;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b986sThxm+B2ufQzn8ktFg/y2xZVhvuUzxWgokvgncg=;
 b=g03Bk7G25AmfuBmzmGuCoMDdgY8JtqEp8xhLZxuhTJGXOjF8sUQ6RJr9SshrfNHAx6
 /5haHhg0YQaooVhPLquO1/soJfwhrE0sZUDM6KAYiJex18ZzuBAEJwsdcFvVmBwy6CTy
 KCCu1N3ZwYfbdAqUBnip7JfjtAupL1SFple3JHxXeCQJmQOBKpVe1mqXs1/dKHfNQWDR
 3NsGUEytyButJKwQo6edE7FxZKhTdEcfwa3KhN6ETSLSj2rdEqium17uCCcheLnKr8BC
 Hyz3rhHP/1vs9ch/ci1y3vWjcHT82Ysg5Kh5flqIsXF20xMt5AiDjg5LG0t3OGclIZnr
 NeVQ==
X-Gm-Message-State: ABy/qLYYVV49uUeHQD1ty6yhj7vyEccpLp7vQnC7qhoimrqgnxrwqV4C
 1/ac4m8f9wlHnQdzxfIK/VRnWA==
X-Google-Smtp-Source: APBJJlEzwQOzPUbqnWqm1KqC4uFa6FDS2LXb32u1CWhHgiEUkzUBU1i22dqKZmHWpCkIm3zLoU6myA==
X-Received: by 2002:a05:6871:54d:b0:1b4:4935:653f with SMTP id
 t13-20020a056871054d00b001b44935653fmr65016oal.49.1689813717769; 
 Wed, 19 Jul 2023 17:41:57 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 j15-20020a62b60f000000b00682bbb65852sm3933374pff.176.2023.07.19.17.41.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 17:41:57 -0700 (PDT)
Message-ID: <402ffcf2-198d-7da1-5048-b58fe5d1e0fd@daynix.com>
Date: Thu, 20 Jul 2023 09:41:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] virtio-net: Added uso check
Content-Language: en-US
To: Yuri Benditovich <yuri.benditovich@daynix.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 mst@redhat.com, Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
Cc: yan@daynix.com, andrew@daynix.com
References: <20230719152139.1316570-1-yuri.benditovich@daynix.com>
 <20230719152139.1316570-5-yuri.benditovich@daynix.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230719152139.1316570-5-yuri.benditovich@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2001:4860:4864:20::2f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Placing this patch after "[PATCH 3/4] virtio-net: added USO support" may 
interfer with "git bisect" on a host that does not support USO as 
virtio-net can advertise USO support where it's not supported.

I suggest to combine this patch with the earlier patch aforementioned. 
It will make the entire patch big so I think it's also better to extract 
the change for tap into another patch.

On 2023/07/20 0:21, Yuri Benditovich wrote:
> From: Andrew Melnychenko <andrew@daynix.com>
> 
> Added tap uso check with stubs for non-Linux systems.
> 
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>   hw/net/virtio-net.c | 15 +++++++++++++++
>   include/net/net.h   |  3 +++
>   net/net.c           |  9 +++++++++
>   net/tap-bsd.c       |  5 +++++
>   net/tap-linux.c     | 12 ++++++++++++
>   net/tap-solaris.c   |  5 +++++
>   net/tap-stub.c      |  5 +++++
>   net/tap.c           | 12 ++++++++++++
>   net/tap_int.h       |  1 +
>   9 files changed, 67 insertions(+)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index e76cad923b..d950d3a77f 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -659,6 +659,15 @@ static int peer_has_ufo(VirtIONet *n)
>       return n->has_ufo;
>   }
>   
> +static int peer_has_uso(VirtIONet *n)
> +{
> +    if (!peer_has_vnet_hdr(n)) {
> +        return 0;
> +    }
> +
> +    return qemu_has_uso(qemu_get_queue(n->nic)->peer);
> +}
> +
>   static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
>                                          int version_1, int hash_report)
>   {
> @@ -808,6 +817,12 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
>           virtio_clear_feature(&features, VIRTIO_NET_F_HOST_UFO);
>       }
>   
> +    if (!peer_has_uso(n)) {
> +        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
> +        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
> +        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
> +    }
> +
>       if (!get_vhost_net(nc->peer)) {
>           return features;
>       }
> diff --git a/include/net/net.h b/include/net/net.h
> index b5ccfbbffb..330d285930 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -54,6 +54,7 @@ typedef void (LinkStatusChanged)(NetClientState *);
>   typedef void (NetClientDestructor)(NetClientState *);
>   typedef RxFilterInfo *(QueryRxFilter)(NetClientState *);
>   typedef bool (HasUfo)(NetClientState *);
> +typedef bool (HasUso)(NetClientState *);
>   typedef bool (HasVnetHdr)(NetClientState *);
>   typedef bool (HasVnetHdrLen)(NetClientState *, int);
>   typedef bool (GetUsingVnetHdr)(NetClientState *);
> @@ -84,6 +85,7 @@ typedef struct NetClientInfo {
>       QueryRxFilter *query_rx_filter;
>       NetPoll *poll;
>       HasUfo *has_ufo;
> +    HasUso *has_uso;
>       HasVnetHdr *has_vnet_hdr;
>       HasVnetHdrLen *has_vnet_hdr_len;
>       GetUsingVnetHdr *get_using_vnet_hdr;
> @@ -187,6 +189,7 @@ void qemu_set_info_str(NetClientState *nc,
>                          const char *fmt, ...) G_GNUC_PRINTF(2, 3);
>   void qemu_format_nic_info_str(NetClientState *nc, uint8_t macaddr[6]);
>   bool qemu_has_ufo(NetClientState *nc);
> +bool qemu_has_uso(NetClientState *nc);
>   bool qemu_has_vnet_hdr(NetClientState *nc);
>   bool qemu_has_vnet_hdr_len(NetClientState *nc, int len);
>   bool qemu_get_using_vnet_hdr(NetClientState *nc);
> diff --git a/net/net.c b/net/net.c
> index 543e6dec43..b110e61f66 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -495,6 +495,15 @@ bool qemu_has_ufo(NetClientState *nc)
>       return nc->info->has_ufo(nc);
>   }
>   
> +bool qemu_has_uso(NetClientState *nc)
> +{
> +    if (!nc || !nc->info->has_uso) {
> +        return false;
> +    }
> +
> +    return nc->info->has_uso(nc);
> +}
> +
>   bool qemu_has_vnet_hdr(NetClientState *nc)
>   {
>       if (!nc || !nc->info->has_vnet_hdr) {
> diff --git a/net/tap-bsd.c b/net/tap-bsd.c
> index abd16a2ad2..274ea7bd2c 100644
> --- a/net/tap-bsd.c
> +++ b/net/tap-bsd.c
> @@ -212,6 +212,11 @@ int tap_probe_has_ufo(int fd)
>       return 0;
>   }
>   
> +int tap_probe_has_uso(int fd)
> +{
> +    return 0;
> +}
> +
>   int tap_probe_vnet_hdr_len(int fd, int len)
>   {
>       return 0;
> diff --git a/net/tap-linux.c b/net/tap-linux.c
> index 30fcca1bc2..c7e514ecb0 100644
> --- a/net/tap-linux.c
> +++ b/net/tap-linux.c
> @@ -173,6 +173,18 @@ int tap_probe_has_ufo(int fd)
>       return 1;
>   }
>   
> +int tap_probe_has_uso(int fd)
> +{
> +    unsigned offload;
> +
> +    offload = TUN_F_CSUM | TUN_F_USO4 | TUN_F_USO6;
> +
> +    if (ioctl(fd, TUNSETOFFLOAD, offload) < 0) {
> +        return 0;
> +    }
> +    return 1;
> +}
> +
>   /* Verify that we can assign given length */
>   int tap_probe_vnet_hdr_len(int fd, int len)
>   {
> diff --git a/net/tap-solaris.c b/net/tap-solaris.c
> index a617a10e5c..08b13af512 100644
> --- a/net/tap-solaris.c
> +++ b/net/tap-solaris.c
> @@ -216,6 +216,11 @@ int tap_probe_has_ufo(int fd)
>       return 0;
>   }
>   
> +int tap_probe_has_uso(int fd)
> +{
> +    return 0;
> +}
> +
>   int tap_probe_vnet_hdr_len(int fd, int len)
>   {
>       return 0;
> diff --git a/net/tap-stub.c b/net/tap-stub.c
> index ac8dfc03b4..4b24f61e3a 100644
> --- a/net/tap-stub.c
> +++ b/net/tap-stub.c
> @@ -47,6 +47,11 @@ int tap_probe_has_ufo(int fd)
>       return 0;
>   }
>   
> +int tap_probe_has_uso(int fd)
> +{
> +    return 0;
> +}
> +
>   int tap_probe_vnet_hdr_len(int fd, int len)
>   {
>       return 0;
> diff --git a/net/tap.c b/net/tap.c
> index 14ea4ef26f..bcea8d03f9 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -57,6 +57,7 @@ typedef struct TAPState {
>       bool write_poll;
>       bool using_vnet_hdr;
>       bool has_ufo;
> +    bool has_uso;
>       bool enabled;
>       VHostNetState *vhost_net;
>       unsigned host_vnet_hdr_len;
> @@ -237,6 +238,15 @@ static bool tap_has_ufo(NetClientState *nc)
>       return s->has_ufo;
>   }
>   
> +static bool tap_has_uso(NetClientState *nc)
> +{
> +    TAPState *s = DO_UPCAST(TAPState, nc, nc);
> +
> +    assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
> +
> +    return s->has_uso;
> +}
> +
>   static bool tap_has_vnet_hdr(NetClientState *nc)
>   {
>       TAPState *s = DO_UPCAST(TAPState, nc, nc);
> @@ -384,6 +394,7 @@ static NetClientInfo net_tap_info = {
>       .poll = tap_poll,
>       .cleanup = tap_cleanup,
>       .has_ufo = tap_has_ufo,
> +    .has_uso = tap_has_uso,
>       .has_vnet_hdr = tap_has_vnet_hdr,
>       .has_vnet_hdr_len = tap_has_vnet_hdr_len,
>       .get_using_vnet_hdr = tap_get_using_vnet_hdr,
> @@ -413,6 +424,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
>       s->host_vnet_hdr_len = vnet_hdr ? sizeof(struct virtio_net_hdr) : 0;
>       s->using_vnet_hdr = false;
>       s->has_ufo = tap_probe_has_ufo(s->fd);
> +    s->has_uso = tap_probe_has_uso(s->fd);
>       s->enabled = true;
>       tap_set_offload(&s->nc, 0, 0, 0, 0, 0, 0, 0);
>       /*
> diff --git a/net/tap_int.h b/net/tap_int.h
> index d8861d81ba..9a2175655b 100644
> --- a/net/tap_int.h
> +++ b/net/tap_int.h
> @@ -37,6 +37,7 @@ void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp);
>   int tap_probe_vnet_hdr(int fd, Error **errp);
>   int tap_probe_vnet_hdr_len(int fd, int len);
>   int tap_probe_has_ufo(int fd);
> +int tap_probe_has_uso(int fd);
>   void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn, int ufo,
>                           int uso4, int uso6);
>   void tap_fd_set_vnet_hdr_len(int fd, int len);

