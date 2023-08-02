Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 199FB76C4C0
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 07:19:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR4Eq-0007bC-5W; Wed, 02 Aug 2023 01:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qR4El-0007b4-Ks
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 01:17:32 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qR4Eh-0000I8-QQ
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 01:17:30 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6bc8d1878a0so3763870a34.1
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 22:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690953445; x=1691558245;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=reZJiDGXb08Qj54ZmNY5PpO5rBLkfdMiqHtTvwWLcko=;
 b=JKutauZMfQ6DrDFbFX24810i6ixjo/dP25jKNx5t8bYMSQCEpB9XaLB0wltRCtoqXV
 PokZFIi93fxPrwZY91YzQifkwCKZOUvgc5AYM2sycXPwkTgOrd5yXLHdv89uRs7yixqb
 JcNN6FnM2bvsDJTzdY+o6Z8IWD5TAGTW3nKlIDoC45W8SugebbL0pyZS8qQ1tvbdkIwE
 Ota/3033xGN00LHURxYJz6Yup93YqVJzmEmnaFgl+/iQnPcCJErkIG2qfQHJoQJscA0d
 FDwA0Ns45OBqQsROxZYRIGesStQvwTwv8m2z3JaqybBwNzOnGmuLXC7S3jQseXWv/vE2
 HQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690953445; x=1691558245;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=reZJiDGXb08Qj54ZmNY5PpO5rBLkfdMiqHtTvwWLcko=;
 b=eJmwc74DxVdS2FTEHKwt9OnTlgCq+AYiV3R8gy/CzJ6kZ1mCYJEh/XJMEQN+DNy2LL
 8VnqRhQrItYjDyfMBBTDYFwNcvf30VV1h/vbo5sSPh+ew3aKZ/g3C7tHxKpBMahgmzS7
 jEe4DihkPkWAaJCxieQ+T7yv92xgiAwqmQQHdeoK9Ysr1d4wDHRrCHGEw+PaU6hIE8am
 v42w0C9o2YBBsyCcS8CBgtrpRJlwsuNmdR40ATalgqjky52ACI5n/zLKlwSeVZrXtBnN
 cBnMDBMAFYZDVyG9350aABt3nGTQaMXEpAnq5MQIdRfASiSvbA1mBjdWEgg5N8Gyu9a3
 qILA==
X-Gm-Message-State: ABy/qLa2+TxFiLpqwLYZ4gtJ9AU7E25HG9GjsF/dmbuPFkjeXnGv3iJx
 +Gc656OAmD4OUUAn7gu1KtrO8w==
X-Google-Smtp-Source: APBJJlHvIxB/4dXjH8+juUFv56Do+yMibXv9Z6LsR24nxWPJ9+RI9sm54VUh0H8uXaKxE+aE5U4kYg==
X-Received: by 2002:a05:6830:148f:b0:6b1:d368:557c with SMTP id
 s15-20020a056830148f00b006b1d368557cmr16063788otq.30.1690953445390; 
 Tue, 01 Aug 2023 22:17:25 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 c8-20020a17090ad90800b002682392506bsm332695pjv.50.2023.08.01.22.17.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 22:17:24 -0700 (PDT)
Message-ID: <7ae967c9-6577-6935-4fe6-96eb0d848349@daynix.com>
Date: Wed, 2 Aug 2023 14:17:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Content-Language: en-US
To: Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 dmitry.fleytman@gmail.com, jasowang@redhat.com, sriram.yagnaraman@est.tech,
 mst@redhat.com, sw@weilnetz.de, qemu-devel@nongnu.org
Cc: yan@daynix.com
References: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
 <20230731223148.1002258-5-yuri.benditovich@daynix.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230731223148.1002258-5-yuri.benditovich@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::334;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x334.google.com
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

On 2023/08/01 7:31, Yuri Benditovich wrote:
> USO features of virtio-net device depend on kernel ability
> to support them, for backward compatibility by default the
> features are disabled on 8.0 and earlier.
> 
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> Signed-off-by: Andrew Melnychecnko <andrew@daynix.com>
> ---
>   hw/core/machine.c   |  4 ++++
>   hw/net/virtio-net.c | 31 +++++++++++++++++++++++++++++--
>   2 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index f0d35c6401..a725e76738 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -38,10 +38,14 @@
>   #include "exec/confidential-guest-support.h"
>   #include "hw/virtio/virtio.h"
>   #include "hw/virtio/virtio-pci.h"
> +#include "hw/virtio/virtio-net.h"
>   
>   GlobalProperty hw_compat_8_0[] = {
>       { "migration", "multifd-flush-after-each-section", "on"},
>       { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
> +    { TYPE_VIRTIO_NET, "host_uso", "off"},
> +    { TYPE_VIRTIO_NET, "guest_uso4", "off"},
> +    { TYPE_VIRTIO_NET, "guest_uso6", "off"},

Nitpick: Add a whitespace before closing brackets '}'.

>   };
>   const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
>   
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index d2311e7d6e..bd0ead94fe 100644
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
> @@ -796,6 +805,10 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
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
> @@ -804,6 +817,12 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
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
> @@ -864,14 +883,16 @@ static void virtio_net_apply_guest_offloads(VirtIONet *n)
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
> @@ -3924,6 +3945,12 @@ static Property virtio_net_properties[] = {
>       DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
>       DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
>       DEFINE_PROP_BOOL("failover", VirtIONet, failover, false),
> +    DEFINE_PROP_BIT64("guest_uso4", VirtIONet, host_features,
> +                      VIRTIO_NET_F_GUEST_USO4, true),
> +    DEFINE_PROP_BIT64("guest_uso6", VirtIONet, host_features,
> +                      VIRTIO_NET_F_GUEST_USO6, true),
> +    DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
> +                      VIRTIO_NET_F_HOST_USO, true),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   

