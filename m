Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B639575B56B
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 19:18:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMXHT-0006rZ-KV; Thu, 20 Jul 2023 13:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qMXHQ-0006r3-Jl
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 13:17:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qMXHP-0002Nt-1j
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 13:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689873449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7acksfJCYmAawygVVNzpNTWtLypXaRLI4nb1XfBAty8=;
 b=T9Jr/ZsaGqIJXTIwDOrGHX0XpnKgVvRPpolBdJ0wMJhjxIv3mwv8JVrpxzZeQx/G4xwPXl
 HdIZ9Hi9nd1qoztppUDJ4ZGo5C0sGbit8Qtu/g3B8QwTo3NZmw9W+iB60qY/jY1eh3ze3r
 grjHmVrv8cFZDOyR9ifqI51lTTfU37U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-XiCIPMOrN5SzB-VOefNYWg-1; Thu, 20 Jul 2023 13:17:27 -0400
X-MC-Unique: XiCIPMOrN5SzB-VOefNYWg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31444df0fafso608885f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 10:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689873446; x=1690478246;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7acksfJCYmAawygVVNzpNTWtLypXaRLI4nb1XfBAty8=;
 b=c8+iikNazC8f82KpNa08gcIdJZQ/n5/i1InZV8dQwt4/1YMs2VQ0nGrjRevEWT7QPA
 GZhZi3JIYmFqqtsy3qEPGJtQycyuHc68XyeA0CZ7LYcpp+woPpTWHd3pBfoSTPOv3gye
 byYYd1A01f80c9rOhoxP/5NN1yTVG8Z0V+7xsm00c9x6ag+Usx/fhV1s0SouQ7SOA//T
 G/8n/WMc2gbWj8oEkL0CQPmDTpG/6vvUaop8EV/LPAd4THENEDV9zWPB3JHIRE3yW52s
 iKuWc13l2s2Iprq5Ym4HL8yRpx3ZTTZC9QMHSyfAaVz6+T+rFIYVSe3A3JlxylkG8wxn
 PajA==
X-Gm-Message-State: ABy/qLZkUTd+aWuewPOsDRi1zqzuG0CQZpD/WRqdJ7esAqoa+U+HLM4b
 Nc+Y414A66vvd6MsLKTo/OrDtDzYXJL0iswiQvIRIj2RIg6MCfR8h1TXb0IHERDZEMBKFFZbsxC
 arHN414WoyhBo4AA=
X-Received: by 2002:a5d:4388:0:b0:314:36c5:e4c0 with SMTP id
 i8-20020a5d4388000000b0031436c5e4c0mr3051858wrq.11.1689873446491; 
 Thu, 20 Jul 2023 10:17:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGj/5VL62DzjH9ZmDl2BY18l7bWopG9Y63dqBrr92XaSBjtpVwRfP91NL8kTklBF5DdiJjLVg==
X-Received: by 2002:a5d:4388:0:b0:314:36c5:e4c0 with SMTP id
 i8-20020a5d4388000000b0031436c5e4c0mr3051849wrq.11.1689873446191; 
 Thu, 20 Jul 2023 10:17:26 -0700 (PDT)
Received: from redhat.com ([2.52.16.41]) by smtp.gmail.com with ESMTPSA id
 u18-20020a5d5152000000b00314326c91e2sm1861531wrt.28.2023.07.20.10.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 10:17:25 -0700 (PDT)
Date: Thu, 20 Jul 2023 13:17:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org, yan@daynix.com,
 andrew@daynix.com
Subject: Re: [PATCH 3/4] virtio-net: added USO support
Message-ID: <20230720131646-mutt-send-email-mst@kernel.org>
References: <20230719152139.1316570-1-yuri.benditovich@daynix.com>
 <20230719152139.1316570-4-yuri.benditovich@daynix.com>
 <73d6c937-07fe-f1fd-db8c-6cf13e9dcf4b@daynix.com>
 <CAOEp5OcWzZ9+EvsE=cgfUyj11ifTjZ-Lpm_BAxPX_gqxiYMang@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOEp5OcWzZ9+EvsE=cgfUyj11ifTjZ-Lpm_BAxPX_gqxiYMang@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Jul 20, 2023 at 07:05:40PM +0300, Yuri Benditovich wrote:
> 
> 
> On Thu, Jul 20, 2023 at 3:37 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> 
>     On 2023/07/20 0:21, Yuri Benditovich wrote:
>     > virtio-net can suggest USO features TX, RX v4 and RX v6,
>     > depending on kernel TUN ability to support them. These
>     > features require explicit enable in command-line.
> 
>     Shouldn't we enable these by default as the other offload features are?
> 
> 
> My suggestion is to add these features as disabled by default and reevaluate
> the
> possibility to enable later.
> If we enable them by default we'll also need to disable them by default in
> previous
> generations of machine types.

Yea, let's do that, that's how we always did it traditionally.

> 
> 
>     >
>     > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>     > ---
>     >   hw/net/virtio-net.c | 16 ++++++++++++++--
>     >   1 file changed, 14 insertions(+), 2 deletions(-)
>     >
>     > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>     > index d2311e7d6e..e76cad923b 100644
>     > --- a/hw/net/virtio-net.c
>     > +++ b/hw/net/virtio-net.c
>     > @@ -796,6 +796,10 @@ static uint64_t virtio_net_get_features(VirtIODevice
>     *vdev, uint64_t features,
>     >           virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
>     >           virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);
>     >   
>     > +        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
>     > +        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
>     > +        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
>     > +
>     >           virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
>     >       }
>     >   
>     > @@ -864,14 +868,16 @@ static void virtio_net_apply_guest_offloads
>     (VirtIONet *n)
>     >               !!(n->curr_guest_offloads & (1ULL <<
>     VIRTIO_NET_F_GUEST_USO6)));
>     >   }
>     >   
>     > -static uint64_t virtio_net_guest_offloads_by_features(uint32_t features)
>     > +static uint64_t virtio_net_guest_offloads_by_features(uint64_t features)
>     >   {
>     >       static const uint64_t guest_offloads_mask =
>     >           (1ULL << VIRTIO_NET_F_GUEST_CSUM) |
>     >           (1ULL << VIRTIO_NET_F_GUEST_TSO4) |
>     >           (1ULL << VIRTIO_NET_F_GUEST_TSO6) |
>     >           (1ULL << VIRTIO_NET_F_GUEST_ECN)  |
>     > -        (1ULL << VIRTIO_NET_F_GUEST_UFO);
>     > +        (1ULL << VIRTIO_NET_F_GUEST_UFO)  |
>     > +        (1ULL << VIRTIO_NET_F_GUEST_USO4) |
>     > +        (1ULL << VIRTIO_NET_F_GUEST_USO6);
>     >   
>     >       return guest_offloads_mask & features;
>     >   }
>     > @@ -3924,6 +3930,12 @@ static Property virtio_net_properties[] = {
>     >       DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed,
>     SPEED_UNKNOWN),
>     >       DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
>     >       DEFINE_PROP_BOOL("failover", VirtIONet, failover, false),
>     > +    DEFINE_PROP_BIT64("guest_uso4", VirtIONet, host_features,
>     > +                      VIRTIO_NET_F_GUEST_USO4, false),
>     > +    DEFINE_PROP_BIT64("guest_uso6", VirtIONet, host_features,
>     > +                      VIRTIO_NET_F_GUEST_USO6, false),
>     > +    DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
>     > +                      VIRTIO_NET_F_HOST_USO, false),
>     >       DEFINE_PROP_END_OF_LIST(),
>     >   };
>     >   
> 


