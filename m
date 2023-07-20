Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E9875B3CB
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 18:07:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMWAQ-0007Up-2R; Thu, 20 Jul 2023 12:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qMWAA-0007Sf-IH
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 12:06:01 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qMWA7-0006qt-LC
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 12:05:57 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4fba03becc6so2717033e87.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 09:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1689869152; x=1690473952;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZnWpvS2s57SGmGldeYL3Vcig6RAdiIrTC6PoR7aT91A=;
 b=R6aOcdTYn3CIK9Bx0EbWpHypWIpNKBvkzvb8bvDcauZ2j5UQmXPegWOmPcgHVc1X4/
 ntQtjR0Lnyv2ZMWBOZ7/IpHbIm6ru/vLLPcw92xC6bFE65r/EWBmA5OYiaL6gdnTnAD3
 vKdSvWhoGieg7Eq/sd+64Sj83HZ/PzTZNQelVXZJNPOs/tqIic/AF+yD2yCg9STmeGgx
 Nm5xA6P+EoA8Ga05NL6d53PN8r/MzlaniT2lfwueEai5NOT27o/m2JJGJmlhdisXkFdk
 tyK5dQToR6X/Ti/naze4TgwugwQG1v6J9uhEyhTZs8r20RpysHOQpp2jmwyqe1x8R/Qp
 s82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689869152; x=1690473952;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZnWpvS2s57SGmGldeYL3Vcig6RAdiIrTC6PoR7aT91A=;
 b=eQFt9xo37C/4l0lVnrVmA6g2wcjyZZmhoZW0Kb+cbUwhzSLWjgKDJXZ2Hc3PvUWBU9
 /XX0WTxVi38ybydWYO50c+iSy29HfgFihQJLwvhWHtkFzo9vZ3nmEe722SLJcfusmmvr
 6Tp64zQHm6ssFCAo5SSKec+f6JGYsgT9CUvpclRI5d4wW8yP7YJLoUjUAvO1UAW7xKIm
 464GdLWRXQL7Jh4eIPiKI40G67C4Hvp91noh6YvD5eDspmDHghUGtg6YLLXTmkdpNBkz
 J74cv8GSSY8RLobznw29Juace6vzdXUlEpOpttyvKdfY6XvWROuVp7QwmYem263oykMA
 4Tfw==
X-Gm-Message-State: ABy/qLYftt2RHC7/9BM0SxEOkNmCgViCyw59/7HEPB5AD3MI1tiK0F2K
 lFGE16eBDfgwBHQedeK0wIIlaDmQFX44SR53EdWBoQ==
X-Google-Smtp-Source: APBJJlGh4a2/bHlOE8sgslzvXuTdYdS6cywS40yzEggPdcVw0oGMpZqRTBGS5Io6l996EcT9d2a84wqhC/yhe13LBMU=
X-Received: by 2002:ac2:5599:0:b0:4f8:6d9d:abe0 with SMTP id
 v25-20020ac25599000000b004f86d9dabe0mr1193369lfg.33.1689869152547; Thu, 20
 Jul 2023 09:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230719152139.1316570-1-yuri.benditovich@daynix.com>
 <20230719152139.1316570-4-yuri.benditovich@daynix.com>
 <73d6c937-07fe-f1fd-db8c-6cf13e9dcf4b@daynix.com>
In-Reply-To: <73d6c937-07fe-f1fd-db8c-6cf13e9dcf4b@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 20 Jul 2023 19:05:40 +0300
Message-ID: <CAOEp5OcWzZ9+EvsE=cgfUyj11ifTjZ-Lpm_BAxPX_gqxiYMang@mail.gmail.com>
Subject: Re: [PATCH 3/4] virtio-net: added USO support
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, mst@redhat.com,
 Stefan Weil <sw@weilnetz.de>, 
 qemu-devel@nongnu.org, yan@daynix.com, andrew@daynix.com
Content-Type: multipart/alternative; boundary="0000000000008e11760600ed529c"
Received-SPF: none client-ip=2a00:1450:4864:20::133;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

--0000000000008e11760600ed529c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 3:37=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com>
wrote:

> On 2023/07/20 0:21, Yuri Benditovich wrote:
> > virtio-net can suggest USO features TX, RX v4 and RX v6,
> > depending on kernel TUN ability to support them. These
> > features require explicit enable in command-line.
>
> Shouldn't we enable these by default as the other offload features are?
>

My suggestion is to add these features as disabled by default and
reevaluate the
possibility to enable later.
If we enable them by default we'll also need to disable them by default in
previous
generations of machine types.


> >
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > ---
> >   hw/net/virtio-net.c | 16 ++++++++++++++--
> >   1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index d2311e7d6e..e76cad923b 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -796,6 +796,10 @@ static uint64_t
> virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
> >           virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
> >           virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);
> >
> > +        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
> > +        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
> > +        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
> > +
> >           virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
> >       }
> >
> > @@ -864,14 +868,16 @@ static void
> virtio_net_apply_guest_offloads(VirtIONet *n)
> >               !!(n->curr_guest_offloads & (1ULL <<
> VIRTIO_NET_F_GUEST_USO6)));
> >   }
> >
> > -static uint64_t virtio_net_guest_offloads_by_features(uint32_t feature=
s)
> > +static uint64_t virtio_net_guest_offloads_by_features(uint64_t feature=
s)
> >   {
> >       static const uint64_t guest_offloads_mask =3D
> >           (1ULL << VIRTIO_NET_F_GUEST_CSUM) |
> >           (1ULL << VIRTIO_NET_F_GUEST_TSO4) |
> >           (1ULL << VIRTIO_NET_F_GUEST_TSO6) |
> >           (1ULL << VIRTIO_NET_F_GUEST_ECN)  |
> > -        (1ULL << VIRTIO_NET_F_GUEST_UFO);
> > +        (1ULL << VIRTIO_NET_F_GUEST_UFO)  |
> > +        (1ULL << VIRTIO_NET_F_GUEST_USO4) |
> > +        (1ULL << VIRTIO_NET_F_GUEST_USO6);
> >
> >       return guest_offloads_mask & features;
> >   }
> > @@ -3924,6 +3930,12 @@ static Property virtio_net_properties[] =3D {
> >       DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed,
> SPEED_UNKNOWN),
> >       DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
> >       DEFINE_PROP_BOOL("failover", VirtIONet, failover, false),
> > +    DEFINE_PROP_BIT64("guest_uso4", VirtIONet, host_features,
> > +                      VIRTIO_NET_F_GUEST_USO4, false),
> > +    DEFINE_PROP_BIT64("guest_uso6", VirtIONet, host_features,
> > +                      VIRTIO_NET_F_GUEST_USO6, false),
> > +    DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
> > +                      VIRTIO_NET_F_HOST_USO, false),
> >       DEFINE_PROP_END_OF_LIST(),
> >   };
> >
>

--0000000000008e11760600ed529c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 20, 2023 at 3:37=E2=80=AF=
AM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.od=
aki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On 2023/07/20 0:21, Yuri Benditovich wrote:<br>
&gt; virtio-net can suggest USO features TX, RX v4 and RX v6,<br>
&gt; depending on kernel TUN ability to support them. These<br>
&gt; features require explicit enable in command-line.<br>
<br>
Shouldn&#39;t we enable these by default as the other offload features are?=
<br></blockquote><div><br></div><div>My suggestion is to add these features=
 as disabled by default and reevaluate the</div><div>possibility to enable=
=C2=A0later.</div><div>If we enable them by default we&#39;ll=20

also=20

need to disable them by default in previous</div><div>generations of machin=
e types.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
<br>
&gt; <br>
&gt; Signed-off-by: Yuri Benditovich &lt;<a href=3D"mailto:yuri.benditovich=
@daynix.com" target=3D"_blank">yuri.benditovich@daynix.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/net/virtio-net.c | 16 ++++++++++++++--<br>
&gt;=C2=A0 =C2=A01 file changed, 14 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
&gt; index d2311e7d6e..e76cad923b 100644<br>
&gt; --- a/hw/net/virtio-net.c<br>
&gt; +++ b/hw/net/virtio-net.c<br>
&gt; @@ -796,6 +796,10 @@ static uint64_t virtio_net_get_features(VirtIODev=
ice *vdev, uint64_t features,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_clear_feature(&amp;feat=
ures, VIRTIO_NET_F_GUEST_TSO6);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_clear_feature(&amp;feat=
ures, VIRTIO_NET_F_GUEST_ECN);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_clear_feature(&amp;features, VIRTI=
O_NET_F_HOST_USO);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_clear_feature(&amp;features, VIRTI=
O_NET_F_GUEST_USO4);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_clear_feature(&amp;features, VIRTI=
O_NET_F_GUEST_USO6);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_clear_feature(&amp;feat=
ures, VIRTIO_NET_F_HASH_REPORT);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -864,14 +868,16 @@ static void virtio_net_apply_guest_offloads(Virt=
IONet *n)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!!(n-&gt;curr_gu=
est_offloads &amp; (1ULL &lt;&lt; VIRTIO_NET_F_GUEST_USO6)));<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -static uint64_t virtio_net_guest_offloads_by_features(uint32_t featur=
es)<br>
&gt; +static uint64_t virtio_net_guest_offloads_by_features(uint64_t featur=
es)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0static const uint64_t guest_offloads_mask =
=3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1ULL &lt;&lt; VIRTIO_NET_F_GU=
EST_CSUM) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1ULL &lt;&lt; VIRTIO_NET_F_GU=
EST_TSO4) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1ULL &lt;&lt; VIRTIO_NET_F_GU=
EST_TSO6) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1ULL &lt;&lt; VIRTIO_NET_F_GU=
EST_ECN)=C2=A0 |<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1ULL &lt;&lt; VIRTIO_NET_F_GUEST_UFO);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1ULL &lt;&lt; VIRTIO_NET_F_GUEST_UFO)=C2=
=A0 |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1ULL &lt;&lt; VIRTIO_NET_F_GUEST_USO4) |=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1ULL &lt;&lt; VIRTIO_NET_F_GUEST_USO6);<=
br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return guest_offloads_mask &amp; features;<b=
r>
&gt;=C2=A0 =C2=A0}<br>
&gt; @@ -3924,6 +3930,12 @@ static Property virtio_net_properties[] =3D {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_PROP_INT32(&quot;speed&quot;, VirtION=
et, net_conf.speed, SPEED_UNKNOWN),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_PROP_STRING(&quot;duplex&quot;, VirtI=
ONet, net_conf.duplex_str),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_PROP_BOOL(&quot;failover&quot;, VirtI=
ONet, failover, false),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_BIT64(&quot;guest_uso4&quot;, VirtIONet, ho=
st_features,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 VIRTIO_NET_F_GUEST_USO4, false),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_BIT64(&quot;guest_uso6&quot;, VirtIONet, ho=
st_features,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 VIRTIO_NET_F_GUEST_USO6, false),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_BIT64(&quot;host_uso&quot;, VirtIONet, host=
_features,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 VIRTIO_NET_F_HOST_USO, false),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_PROP_END_OF_LIST(),<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
</blockquote></div></div>

--0000000000008e11760600ed529c--

