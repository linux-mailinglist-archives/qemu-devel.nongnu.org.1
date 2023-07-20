Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D62975A37E
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 02:33:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMHa8-0007xY-3C; Wed, 19 Jul 2023 20:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qMHa3-0007xE-Cl
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 20:31:45 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qMHa0-0006cY-JB
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 20:31:42 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-666e97fcc60so129565b3a.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 17:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1689813097; x=1690417897;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=psuGo0UEGXdoUYth8xHuXUCxuEYRRhYEiokk3WjanSs=;
 b=ydpfwtG+UgijV/wwnfc9x1sKriUhhLEpdx1Lozd/wtw0dw7yTiCrNMtjA20WUziRhq
 wOpUj48TEdup63MruaAevDnrTn3SDUmruN8wBPcqcu7RhcVanQ7DqxXsCg+dEwQyjudn
 6iHqYKjEANMnfufHP9cj/M1p8zRnOP4iv8bHuDmIoOOhPOs6UUzakk33PhYHajccwnRi
 cB0k+jNeae0LWl83HGlQgDBDqadXHy6qq1OUYuoP8Kdg/grn0Fnj0K0yySrvGCImrrvY
 0uwuFDxEnVAWY+UmOa7MziZgouYVbgir6dgoqSTbk+JkXYlq24Y+xLXSM/r22PqslKOv
 ZGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689813097; x=1690417897;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=psuGo0UEGXdoUYth8xHuXUCxuEYRRhYEiokk3WjanSs=;
 b=LV0fHOXYFETA8GFS32RfEYeBzU6joX6eOicyRaFliK4TYggKJ/EoVFjzQ1I7M/4wnB
 9l0CepXM6MbcHcsraXNRq77JRrThyPskijxz2RTOT8ZYDXOQZ/4m1Aq+yBPsqf/zhXUO
 lOLZ9qxJ5wAl06YZ+nGnW6gdF51Zsq192kwFagzGrGYvRYMqsJwZhbH7Gstzye2H8j1V
 9+UcYEst/seG0umNHbaalYE398Z79Wo0ANDKRKdXFf+TP7On1gWF6NN7R4QUFi7B03t1
 AGmJKaVkhlBZKBwJYCRgz0rmvKnewUjMvuK3eaFSoM0xCH7jROftohe2S2kkpbuTxnz5
 rcuw==
X-Gm-Message-State: ABy/qLbSgGYJmvd9zHXm31Sd+bRf95wq/DAG3jrpURTyCqOgQVXyeP/O
 sqFDMEJoF5EnxODe3uVCWhx11A==
X-Google-Smtp-Source: APBJJlHyDGTAyRo+cHU5G7I4qpzGxBvZku8xjoMJFn/U/Mxn2JrOdSXd4KuQ6pDxdUkKHWKBAkcv7w==
X-Received: by 2002:a05:6a00:178f:b0:666:81ae:fec0 with SMTP id
 s15-20020a056a00178f00b0066681aefec0mr4966571pfg.25.1689813096798; 
 Wed, 19 Jul 2023 17:31:36 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 z19-20020aa785d3000000b0063d24fcc2besm3797132pfn.125.2023.07.19.17.31.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 17:31:36 -0700 (PDT)
Message-ID: <d6906dd9-cb4a-065d-1755-c8cf9b5dcda8@daynix.com>
Date: Thu, 20 Jul 2023 09:31:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] tap: Added USO support to tap device.
To: Yuri Benditovich <yuri.benditovich@daynix.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 mst@redhat.com, Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
Cc: yan@daynix.com, andrew@daynix.com
References: <20230719152139.1316570-1-yuri.benditovich@daynix.com>
 <20230719152139.1316570-2-yuri.benditovich@daynix.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230719152139.1316570-2-yuri.benditovich@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42d.google.com
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

Nitpicking: the subject of this patch is somewhat unconventional. What 
about: "tap: Add USO support to tap device"?

On 2023/07/20 0:21, Yuri Benditovich wrote:
> From: Andrew Melnychenko <andrew@daynix.com>
> 
> Passing additional parameters (USOv4 and USOv6 offloads) when
> setting TAP offloads
> 
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>   hw/net/e1000e_core.c |  2 +-
>   hw/net/igb_core.c    |  2 +-
>   hw/net/virtio-net.c  |  4 +++-
>   hw/net/vmxnet3.c     |  2 ++
>   include/net/net.h    |  4 ++--
>   net/net.c            |  4 ++--
>   net/tap-bsd.c        |  2 +-
>   net/tap-linux.c      | 15 ++++++++++++---
>   net/tap-linux.h      |  2 ++
>   net/tap-solaris.c    |  2 +-
>   net/tap-stub.c       |  2 +-
>   net/tap-win32.c      |  2 +-
>   net/tap.c            |  6 +++---
>   net/tap_int.h        |  3 ++-
>   14 files changed, 34 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index f8aeafa16b..d4055956ad 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -2852,7 +2852,7 @@ e1000e_update_rx_offloads(E1000ECore *core)
>   
>       if (core->has_vnet) {
>           qemu_set_offload(qemu_get_queue(core->owner_nic)->peer,
> -                         cso_state, 0, 0, 0, 0);
> +                         cso_state, 0, 0, 0, 0, 0, 0);
>       }
>   }
>   
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index 8b6b75c522..389eef1549 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -2753,7 +2753,7 @@ igb_update_rx_offloads(IGBCore *core)
>   
>       if (core->has_vnet) {
>           qemu_set_offload(qemu_get_queue(core->owner_nic)->peer,
> -                         cso_state, 0, 0, 0, 0);
> +                         cso_state, 0, 0, 0, 0, 0, 0);
>       }
>   }
>   
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 7102ec4817..d2311e7d6e 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -859,7 +859,9 @@ static void virtio_net_apply_guest_offloads(VirtIONet *n)
>               !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_TSO4)),
>               !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_TSO6)),
>               !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_ECN)),
> -            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_UFO)));
> +            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_UFO)),
> +            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO4)),
> +            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO6)));
>   }
>   
>   static uint64_t virtio_net_guest_offloads_by_features(uint32_t features)
> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> index 5dfacb1098..886adae42b 100644
> --- a/hw/net/vmxnet3.c
> +++ b/hw/net/vmxnet3.c
> @@ -1341,6 +1341,8 @@ static void vmxnet3_update_features(VMXNET3State *s)
>                            s->lro_supported,
>                            s->lro_supported,
>                            0,
> +                         0,
> +                         0,
>                            0);
>       }
>   }
> diff --git a/include/net/net.h b/include/net/net.h
> index 1448d00afb..b5ccfbbffb 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -58,7 +58,7 @@ typedef bool (HasVnetHdr)(NetClientState *);
>   typedef bool (HasVnetHdrLen)(NetClientState *, int);
>   typedef bool (GetUsingVnetHdr)(NetClientState *);
>   typedef void (UsingVnetHdr)(NetClientState *, bool);
> -typedef void (SetOffload)(NetClientState *, int, int, int, int, int);
> +typedef void (SetOffload)(NetClientState *, int, int, int, int, int, int, int);
>   typedef int (GetVnetHdrLen)(NetClientState *);
>   typedef void (SetVnetHdrLen)(NetClientState *, int);
>   typedef int (SetVnetLE)(NetClientState *, bool);
> @@ -192,7 +192,7 @@ bool qemu_has_vnet_hdr_len(NetClientState *nc, int len);
>   bool qemu_get_using_vnet_hdr(NetClientState *nc);
>   void qemu_using_vnet_hdr(NetClientState *nc, bool enable);
>   void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
> -                      int ecn, int ufo);
> +                      int ecn, int ufo, int uso4, int uso6);
>   int qemu_get_vnet_hdr_len(NetClientState *nc);
>   void qemu_set_vnet_hdr_len(NetClientState *nc, int len);
>   int qemu_set_vnet_le(NetClientState *nc, bool is_le);
> diff --git a/net/net.c b/net/net.c
> index 6492ad530e..543e6dec43 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -532,13 +532,13 @@ void qemu_using_vnet_hdr(NetClientState *nc, bool enable)
>   }
>   
>   void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
> -                          int ecn, int ufo)
> +                          int ecn, int ufo, int uso4, int uso6)
>   {
>       if (!nc || !nc->info->set_offload) {
>           return;
>       }
>   
> -    nc->info->set_offload(nc, csum, tso4, tso6, ecn, ufo);
> +    nc->info->set_offload(nc, csum, tso4, tso6, ecn, ufo, uso4, uso6);
>   }
>   
>   int qemu_get_vnet_hdr_len(NetClientState *nc)
> diff --git a/net/tap-bsd.c b/net/tap-bsd.c
> index 4c98fdd337..abd16a2ad2 100644
> --- a/net/tap-bsd.c
> +++ b/net/tap-bsd.c
> @@ -232,7 +232,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)
>   }
>   
>   void tap_fd_set_offload(int fd, int csum, int tso4,
> -                        int tso6, int ecn, int ufo)
> +                        int tso6, int ecn, int ufo, int uso4, int uso6)
>   {
>   }
>   
> diff --git a/net/tap-linux.c b/net/tap-linux.c
> index f54f308d35..30fcca1bc2 100644
> --- a/net/tap-linux.c
> +++ b/net/tap-linux.c
> @@ -237,7 +237,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)
>   }
>   
>   void tap_fd_set_offload(int fd, int csum, int tso4,
> -                        int tso6, int ecn, int ufo)
> +                        int tso6, int ecn, int ufo, int uso4, int uso6)
>   {
>       unsigned int offload = 0;
>   
> @@ -256,13 +256,22 @@ void tap_fd_set_offload(int fd, int csum, int tso4,
>               offload |= TUN_F_TSO_ECN;
>           if (ufo)
>               offload |= TUN_F_UFO;
> +        if (uso4) {
> +            offload |= TUN_F_USO4;
> +        }
> +        if (uso6) {
> +            offload |= TUN_F_USO6;
> +        }
>       }
>   
>       if (ioctl(fd, TUNSETOFFLOAD, offload) != 0) {
> -        offload &= ~TUN_F_UFO;
> +        offload &= ~(TUN_F_USO4 | TUN_F_USO6);

Shouldn't we just report an error when USO is requested on a system that 
does not support it?

>           if (ioctl(fd, TUNSETOFFLOAD, offload) != 0) {
> -            fprintf(stderr, "TUNSETOFFLOAD ioctl() failed: %s\n",
> +            offload &= ~TUN_F_UFO;
> +            if (ioctl(fd, TUNSETOFFLOAD, offload) != 0) {
> +                fprintf(stderr, "TUNSETOFFLOAD ioctl() failed: %s\n",
>                       strerror(errno));
> +            }
>           }
>       }
>   }
> diff --git a/net/tap-linux.h b/net/tap-linux.h
> index bbbb62c2a7..9a58cecb7f 100644
> --- a/net/tap-linux.h
> +++ b/net/tap-linux.h
> @@ -50,5 +50,7 @@
>   #define TUN_F_TSO6    0x04    /* I can handle TSO for IPv6 packets */
>   #define TUN_F_TSO_ECN 0x08    /* I can handle TSO with ECN bits. */
>   #define TUN_F_UFO     0x10    /* I can handle UFO packets */
> +#define TUN_F_USO4    0x20    /* I can handle USO for IPv4 packets */
> +#define TUN_F_USO6    0x40    /* I can handle USO for IPv6 packets */
>   
>   #endif /* QEMU_TAP_LINUX_H */
> diff --git a/net/tap-solaris.c b/net/tap-solaris.c
> index 38e15028bf..a617a10e5c 100644
> --- a/net/tap-solaris.c
> +++ b/net/tap-solaris.c
> @@ -236,7 +236,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)
>   }
>   
>   void tap_fd_set_offload(int fd, int csum, int tso4,
> -                        int tso6, int ecn, int ufo)
> +                        int tso6, int ecn, int ufo, int uso4, int uso6)
>   {
>   }
>   
> diff --git a/net/tap-stub.c b/net/tap-stub.c
> index a0fa25804b..ac8dfc03b4 100644
> --- a/net/tap-stub.c
> +++ b/net/tap-stub.c
> @@ -67,7 +67,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)
>   }
>   
>   void tap_fd_set_offload(int fd, int csum, int tso4,
> -                        int tso6, int ecn, int ufo)
> +                        int tso6, int ecn, int ufo, int uso4, int uso6)
>   {
>   }
>   
> diff --git a/net/tap-win32.c b/net/tap-win32.c
> index f327d62ab0..7b8b4be02c 100644
> --- a/net/tap-win32.c
> +++ b/net/tap-win32.c
> @@ -741,7 +741,7 @@ static void tap_using_vnet_hdr(NetClientState *nc, bool using_vnet_hdr)
>   }
>   
>   static void tap_set_offload(NetClientState *nc, int csum, int tso4,
> -                     int tso6, int ecn, int ufo)
> +                     int tso6, int ecn, int ufo, int uso4, int uso6)
>   {
>   }
>   
> diff --git a/net/tap.c b/net/tap.c
> index 1bf085d422..14ea4ef26f 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -307,14 +307,14 @@ static int tap_set_vnet_be(NetClientState *nc, bool is_be)
>   }
>   
>   static void tap_set_offload(NetClientState *nc, int csum, int tso4,
> -                     int tso6, int ecn, int ufo)
> +                     int tso6, int ecn, int ufo, int uso4, int uso6)
>   {
>       TAPState *s = DO_UPCAST(TAPState, nc, nc);
>       if (s->fd < 0) {
>           return;
>       }
>   
> -    tap_fd_set_offload(s->fd, csum, tso4, tso6, ecn, ufo);
> +    tap_fd_set_offload(s->fd, csum, tso4, tso6, ecn, ufo, uso4, uso6);
>   }
>   
>   static void tap_exit_notify(Notifier *notifier, void *data)
> @@ -414,7 +414,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
>       s->using_vnet_hdr = false;
>       s->has_ufo = tap_probe_has_ufo(s->fd);
>       s->enabled = true;
> -    tap_set_offload(&s->nc, 0, 0, 0, 0, 0);
> +    tap_set_offload(&s->nc, 0, 0, 0, 0, 0, 0, 0);
>       /*
>        * Make sure host header length is set correctly in tap:
>        * it might have been modified by another instance of qemu.
> diff --git a/net/tap_int.h b/net/tap_int.h
> index 547f8a5a28..d8861d81ba 100644
> --- a/net/tap_int.h
> +++ b/net/tap_int.h
> @@ -37,7 +37,8 @@ void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp);
>   int tap_probe_vnet_hdr(int fd, Error **errp);
>   int tap_probe_vnet_hdr_len(int fd, int len);
>   int tap_probe_has_ufo(int fd);
> -void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn, int ufo);
> +void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn, int ufo,
> +                        int uso4, int uso6);
>   void tap_fd_set_vnet_hdr_len(int fd, int len);
>   int tap_fd_set_vnet_le(int fd, int vnet_is_le);
>   int tap_fd_set_vnet_be(int fd, int vnet_is_be);

