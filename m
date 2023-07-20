Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C53075A383
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 02:38:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMHfk-0001JQ-Pz; Wed, 19 Jul 2023 20:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qMHfi-0001J4-RF
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 20:37:34 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qMHfh-0008Pu-AB
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 20:37:34 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6b9c9089d01so172042a34.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 17:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1689813451; x=1690418251;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D7Tb14cPLKm0/iFOtM1xT17CdG6cZ/Ty3ZCSMp0Kz3M=;
 b=EHCVcWTwoojktlfpTwl4izyf3eVRnk1ZXZgw+Q5IAFG+eJPaTyyoog78kly/4NofMo
 aKJJYIgVWveUlOzbqtGOAL346NJaSmY5ugabIoENv7zAF3CqnXZ0HfWLn43vOT8sTMaf
 608qurnUtAE0I5WaQX51VxX+Ar3kH7tHccSy2iVBaIZq8/O2Cc16SsgRkSWyqNc2U4nQ
 QmyytF6+9NQLk70j6WU/WJ9Dnj0OvUN6Z5cEP7wEULTm9DsP3EH8iRA46wGAS+4+eZk1
 cDytTVqkiF0o3DdayKiTGHmR/Tr9z87C5Fzpc/BFd3fAjtQonH1QmAvUd8AxZxJiUSut
 ekmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689813451; x=1690418251;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D7Tb14cPLKm0/iFOtM1xT17CdG6cZ/Ty3ZCSMp0Kz3M=;
 b=hrofjQqFO8VqztrsOT06X0iYF3Ch7oBLNvg7/dscAhzfKp2nM7CLbNEQ5titI7MykE
 Wg9JzqRkR5B3MIS9yT+powFmPdLr2+r+wo/+eTumEshWYwo4ApFlWh+D6udoAmhWM5Uv
 ORMhygPZXwbV7ISXvA40AR7UbXA1/cCmda5EqKZn1lBHOC3wnDY/6w5AUje+bSiLKPPi
 c4ubDguh997hFBqQKkLLDtiwwpSSD6NKhtK2JxBLNWja+pLfr+LIWE9+R1f46MMUZTMk
 EVIpGrUfahyOV7nPmC/0nVpsdPVvt7F4Sj0yBUZLu/2577KNNBAFgjU5IBM8NLBtefB+
 OLhw==
X-Gm-Message-State: ABy/qLZeYYB9cPHFRWdQAT/baai2v27hBKfcyB5l0zr/frGcorqUQXb5
 6wicisuDj3tZuHiND5SBSQYeqQ==
X-Google-Smtp-Source: APBJJlHlTr1aUzlfrvTRSuELuFIQ/DhtmVrCTncPqdAUUAswBddZTqoz8zmbDKUoM+dfuaZRKtFsZA==
X-Received: by 2002:a05:6808:170e:b0:3a4:5063:dd94 with SMTP id
 bc14-20020a056808170e00b003a45063dd94mr78228oib.42.1689813451631; 
 Wed, 19 Jul 2023 17:37:31 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 in23-20020a17090b439700b00262eccfa29fsm1626842pjb.33.2023.07.19.17.37.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 17:37:31 -0700 (PDT)
Message-ID: <73d6c937-07fe-f1fd-db8c-6cf13e9dcf4b@daynix.com>
Date: Thu, 20 Jul 2023 09:37:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] virtio-net: added USO support
Content-Language: en-US
To: Yuri Benditovich <yuri.benditovich@daynix.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 mst@redhat.com, Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
Cc: yan@daynix.com, andrew@daynix.com
References: <20230719152139.1316570-1-yuri.benditovich@daynix.com>
 <20230719152139.1316570-4-yuri.benditovich@daynix.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230719152139.1316570-4-yuri.benditovich@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32f.google.com
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

On 2023/07/20 0:21, Yuri Benditovich wrote:
> virtio-net can suggest USO features TX, RX v4 and RX v6,
> depending on kernel TUN ability to support them. These
> features require explicit enable in command-line.

Shouldn't we enable these by default as the other offload features are?

> 
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>   hw/net/virtio-net.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index d2311e7d6e..e76cad923b 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -796,6 +796,10 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
>           virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
>           virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);
>   
> +        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
> +        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
> +        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
> +
>           virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
>       }
>   
> @@ -864,14 +868,16 @@ static void virtio_net_apply_guest_offloads(VirtIONet *n)
>               !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO6)));
>   }
>   
> -static uint64_t virtio_net_guest_offloads_by_features(uint32_t features)
> +static uint64_t virtio_net_guest_offloads_by_features(uint64_t features)
>   {
>       static const uint64_t guest_offloads_mask =
>           (1ULL << VIRTIO_NET_F_GUEST_CSUM) |
>           (1ULL << VIRTIO_NET_F_GUEST_TSO4) |
>           (1ULL << VIRTIO_NET_F_GUEST_TSO6) |
>           (1ULL << VIRTIO_NET_F_GUEST_ECN)  |
> -        (1ULL << VIRTIO_NET_F_GUEST_UFO);
> +        (1ULL << VIRTIO_NET_F_GUEST_UFO)  |
> +        (1ULL << VIRTIO_NET_F_GUEST_USO4) |
> +        (1ULL << VIRTIO_NET_F_GUEST_USO6);
>   
>       return guest_offloads_mask & features;
>   }
> @@ -3924,6 +3930,12 @@ static Property virtio_net_properties[] = {
>       DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
>       DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
>       DEFINE_PROP_BOOL("failover", VirtIONet, failover, false),
> +    DEFINE_PROP_BIT64("guest_uso4", VirtIONet, host_features,
> +                      VIRTIO_NET_F_GUEST_USO4, false),
> +    DEFINE_PROP_BIT64("guest_uso6", VirtIONet, host_features,
> +                      VIRTIO_NET_F_GUEST_USO6, false),
> +    DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
> +                      VIRTIO_NET_F_HOST_USO, false),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   

