Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B69E77EA1D4
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:28:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2aiA-0006vr-Om; Mon, 13 Nov 2023 12:26:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1r2ai4-0006vd-Er
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:26:53 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1r2ai1-00081b-Sc
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:26:52 -0500
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2c5b7764016so56898911fa.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1699896408; x=1700501208;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gz83Dlt9d8qC/opNP8IWH83BC04U2dMchhja3ii5VJw=;
 b=uRSaKed62rK/m+pZ4ObJqKqrXabWZiaBN5MY0NS4euMYjCn1aWbk5PXjxD+edwiXFf
 DsR55pAViUj84EXp7jRKfPB9zBHYj1ZSQ7D5eXJm6sN1v/hK5imWZucith5Ex8/4GX8n
 AwTXA6dURacw46Wgnjr9EgwIcQnGl7JyKMlxNoF7MNMyViALWigcTHob+mKeSG8T/V2F
 Rvu6G0JgJLG1tx/clZihhobEuVXvqR5fUiOWm91AfGGm7tJGqjZrMkeBLyqrlQQrlOSa
 qmoXSbmuMCsYbzLHxlCrw4K8XEQ42WZppsEzgJbcUf07bLFSE7f7ib/BAvo9kxjMJ5KN
 rc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699896408; x=1700501208;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gz83Dlt9d8qC/opNP8IWH83BC04U2dMchhja3ii5VJw=;
 b=UGFnWnGVdQQ1eeP3tqWhxrBXGSgKpjPqLgM9FLd3ejUCHyJwq/2OQn9hE3pIpPfomq
 l9gRVkuop703awLcssPZdTPAEsMkMZUY44X8d5LQwz7qoQbhOGsQfHVl6O8NMyXevcVr
 V4yq92nGA+FVt+MlOf4cM1BjLgZB5dX/XbTJyHx6pOHERgZbPs3yZCNh1GDkiBVhqYgR
 0m04y/Hq+H8Jxxu5eldS7ro9oENP/2GXFSwN4lxAoJmIbUnq8aB+ulUDGD0vleulreC8
 LtqZnuniadwUhQSXAa4Ysky92QrPPQisbQokNDJWZrSlWtRP4n1J9APtGBQjLYTf869K
 fugw==
X-Gm-Message-State: AOJu0YzxT4l6iLpc3lSFN1YCe/snwr13zlCF/CvcUoyW6f7FPT9j51MH
 3KjXn1TFf3fr8cBZMmyISGgJYuybuDPya7+uu7N2uA==
X-Google-Smtp-Source: AGHT+IEDquXLiH95JYCN+Olb22eEn6rb+0wzeVcsjZnNFnwknBjkj10HfT0wW2ia00DZ68bmIbixxC05VAiVqL+30pM=
X-Received: by 2002:a2e:a726:0:b0:2c5:1bd3:5658 with SMTP id
 s38-20020a2ea726000000b002c51bd35658mr4991283lje.28.1699896407541; Mon, 13
 Nov 2023 09:26:47 -0800 (PST)
MIME-Version: 1.0
References: <58fb3b75-dd69-4715-a8ec-4c3df3b7e4c5@daynix.com>
 <8880b6f9-f556-46f7-a191-eeec0fe208b0@daynix.com>
 <CACGkMEv=A0KS-LtgZmsMehdoUL=EuQzhkfNipKaV1kdUr2Y5Bw@mail.gmail.com>
 <d0db0fb1-0a58-45b7-a623-df6ee9096e2e@daynix.com>
 <20231101023805-mutt-send-email-mst@kernel.org>
 <39a02a4c-f8fa-437c-892f-caca84b8d85d@daynix.com>
 <20231101050838-mutt-send-email-mst@kernel.org>
 <e469b33b-c3f3-4d88-bdf2-508c4a35c827@daynix.com>
 <CAOEp5OcDMdKKPHSVd-GxT-GkBpvbWkMijSBgwihPsEnxmDR7eA@mail.gmail.com>
 <20231102053202-mutt-send-email-mst@kernel.org>
 <CAOEp5OefD2LN2MDnEkE=DOMSX0Jw8Z6gAiKAag4dtkecmr1Jgg@mail.gmail.com>
 <2fbdee21-60f4-49ff-b61b-923c895f90ba@daynix.com>
 <CAOEp5Oc+wGmxTAezMz4f03kuqsngHAcpi7pqPQDT=PWuy=L7BA@mail.gmail.com>
 <dbd1d662-bf90-4982-b316-281923a0d778@daynix.com>
 <CAOEp5Oc5VzWk7e8gKHfHan1odge39bRUh-ZMojCvkQiTFpXdGg@mail.gmail.com>
 <8439be4e-a739-4cbd-a569-89b6c7f68ab9@daynix.com>
 <CAOEp5Oee2qinrZJgMMxUQt6zmPVFPCnThfqnLFSWqsSyAoHpjQ@mail.gmail.com>
 <3c8af942-ca7d-4528-975e-2935718a2428@daynix.com>
In-Reply-To: <3c8af942-ca7d-4528-975e-2935718a2428@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 13 Nov 2023 19:26:35 +0200
Message-ID: <CAOEp5OfXH-1ygYMJxq1phwbOJkkvnwBce=TDVLwjsXG6UgwPGA@mail.gmail.com>
Subject: Re: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Andrew Melnychenko <andrew@daynix.com>
Content-Type: multipart/alternative; boundary="00000000000086dc38060a0bf9c2"
Received-SPF: none client-ip=2a00:1450:4864:20::22c;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-lj1-x22c.google.com
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

--00000000000086dc38060a0bf9c2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 2:44=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com>
wrote:

> On 2023/11/13 20:44, Yuri Benditovich wrote:
> >
> >
> > On Sat, Nov 11, 2023 at 5:28=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com
> > <mailto:akihiko.odaki@daynix.com>> wrote:
> >
> >     On 2023/11/03 22:14, Yuri Benditovich wrote:
> >      >
> >      >
> >      > On Fri, Nov 3, 2023 at 11:55=E2=80=AFAM Akihiko Odaki
> >     <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
> >      > <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>> wrote:
> >      >
> >      >     On 2023/11/03 18:35, Yuri Benditovich wrote:
> >      >      >
> >      >      >
> >      >      > On Thu, Nov 2, 2023 at 4:56=E2=80=AFPM Akihiko Odaki
> >      >     <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
> >     <mailto:akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>>
> >      >      > <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>
> >      >     <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>>> wrote:
> >      >      >
> >      >      >     On 2023/11/02 19:20, Yuri Benditovich wrote:
> >      >      >      >
> >      >      >      >
> >      >      >      > On Thu, Nov 2, 2023 at 11:33=E2=80=AFAM Michael S.=
 Tsirkin
> >      >      >     <mst@redhat.com <mailto:mst@redhat.com>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>
> >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>
> >      >      >      > <mailto:mst@redhat.com <mailto:mst@redhat.com>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>
> >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>>> wrote:
> >      >      >      >
> >      >      >      >     On Thu, Nov 02, 2023 at 11:09:27AM +0200, Yuri
> >      >     Benditovich wrote:
> >      >      >      >      > Probably we mix two different patches in th=
is
> >      >     discussion.
> >      >      >      >      > Focusing on the patch in the e-mail header:
> >      >      >      >      >
> >      >      >      >      > IMO it is not acceptable to fail QEMU run
> >     for one
> >      >     feature
> >      >      >     that we
> >      >      >      >     can't make
> >      >      >      >      > active when we silently drop all other
> >     features in
> >      >     such a
> >      >      >     case.
> >      >      >      >
> >      >      >      >     If the feature is off by default then it seems
> more
> >      >     reasonable
> >      >      >      >     and silent masking can be seen as a bug.
> >      >      >      >     Most virtio features are on by default this is
> >     why it's
> >      >      >      >     reasonable to mask them.
> >      >      >      >
> >      >      >      >
> >      >      >      > If we are talking about RSS: setting it initially
> >     off is the
> >      >      >     development
> >      >      >      > time decision.
> >      >      >      > When it will be completely stable there is no
> reason to
> >      >     keep it
> >      >      >     off by
> >      >      >      > default, so this is more a question of time and of=
 a
> >      >     readiness of
> >      >      >     libvirt.
> >      >      >
> >      >      >     It is not ok to make "on" the default; that will
> >     enable RSS
> >      >     even when
> >      >      >     eBPF steering support is not present and can result i=
n
> >      >     performance
> >      >      >     degradation.
> >      >      >
> >      >      >
> >      >      > Exactly as it is today - with vhost=3Don the host does no=
t
> >     suggest RSS
> >      >      > without  eBPF.
> >      >      > I do not understand what you call "performance
> >     degradation", can you
> >      >      > describe the scenario?
> >      >
> >      >     I was not clear, but I was talking about the case of
> >     vhost=3Doff or peers
> >      >     other than tap (e.g., user). rss=3Don employs in-qemu RSS,
> >     which incurs
> >      >     overheads for such configurations.
> >      >
> >      >
> >      > So, vhost=3Doff OR peers other than tap:
> >      >
> >      > In the case of peers other than tap (IMO) we're not talking abou=
t
> >      > performance at all.
> >      > Backends like "user" (without vnet_hdr) do not support _many_
> >      > performance-oriented features.
> >      > If RSS is somehow "supported" for such backends this is rather a
> >      > misunderstanding (IMO again).
> >
> >     We do not need to ensure good performance when RSS is enabled by th=
e
> >     guest for backends without eBPF steering program as you say. In-QEM=
U
> >     RSS
> >     is only useful for testing and not meant to improve the performance=
.
> >
> >     However, if you set rss=3Don, QEMU will advertise the availability =
of
> RSS
> >     feature. The guest will have no mean to know if it's implemented in=
 a
> >     way not performance-wise so it may decide to use the feature to
> improve
> >     the performance, which can result in performance degradation.
> >     Therefore,
> >     it's better not to set rss=3Don for such backends.
> >
> >
> > I still do not understand what is the scenario where you see or suspect
> > the mentioned "performance degradation".
> > We can discuss whether such a problem exists as soon as you explain it.
>
> The scenario is that:
> - rss=3Don,
> - A backend without eBPF steering support is in use, and
> - The guest expects VIRTIO_NET_F_RSS has little overheads as hardware
> RSS implementations do.
>
> I consider the risk of the performance degradation in such a situation
> is the reason why virtio-net emits a warning ("Can't load eBPF RSS -
> fallback to software RSS") when in-QEMU RSS is in use.
>

In a described scenario (vhost=3Doff) I do not see why the performance
degradation should happen:
the SW RSS (if activated) will place each packet into proper queue (even if
the auto_mq in kernel is not able to do that) and such a way the guest will
not need to reschedule the packet to proper CPU

--00000000000086dc38060a0bf9c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 13, 2023 at 2:44=E2=80=AF=
PM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.od=
aki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On 2023/11/13 20:44, Yuri Benditovich wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Sat, Nov 11, 2023 at 5:28=E2=80=AFPM Akihiko Odaki &lt;<a href=3D"m=
ailto:akihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com<=
/a> <br>
&gt; &lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blan=
k">akihiko.odaki@daynix.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 2023/11/03 22:14, Yuri Benditovich wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Fri, Nov 3, 2023 at 11:55=E2=80=AFAM Akihi=
ko Odaki<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:akihiko.odaki@daynix.com" tar=
get=3D"_blank">akihiko.odaki@daynix.com</a> &lt;mailto:<a href=3D"mailto:ak=
ihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &lt;mailto:<a href=3D"mailto:akihiko.odaki@da=
ynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.c=
om" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0On 2023/11/03 18:35, Yuri =
Benditovich wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Thu, Nov 2, 2023 =
at 4:56=E2=80=AFPM Akihiko Odaki<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:akih=
iko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a> &lt;ma=
ilto:<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blank">akihiko.=
odaki@daynix.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.c=
om" target=3D"_blank">akihiko.odaki@daynix.com</a> &lt;mailto:<a href=3D"ma=
ilto:akihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</=
a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; &lt;mailto:<a href=
=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix=
.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.c=
om" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:akihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a>=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.c=
om" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;&gt;&gt;&gt; wrote:<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0O=
n 2023/11/02 19:20, Yuri Benditovich wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; On Thu, Nov 2, 2023 at 11:33=E2=80=AFAM Michael S. Tsirkin<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&=
lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a> &=
lt;mailto:<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.co=
m</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:mst@redhat.com" target=
=3D"_blank">mst@redhat.com</a> &lt;mailto:<a href=3D"mailto:mst@redhat.com"=
 target=3D"_blank">mst@redhat.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:mst@redhat.com" target=3D"_blank">mst@redhat.com</a> &lt;mailto:<a href=
=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:mst@redhat.com" target=
=3D"_blank">mst@redhat.com</a> &lt;mailto:<a href=3D"mailto:mst@redhat.com"=
 target=3D"_blank">mst@redhat.com</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; &lt;mailto:<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@red=
hat.com</a> &lt;mailto:<a href=3D"mailto:mst@redhat.com" target=3D"_blank">=
mst@redhat.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:mst@redhat.com" target=
=3D"_blank">mst@redhat.com</a> &lt;mailto:<a href=3D"mailto:mst@redhat.com"=
 target=3D"_blank">mst@redhat.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:mst@redhat.com" target=3D"_blank">mst@redhat.com</a> &lt;mailto:<a href=
=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:mst@redhat.com" target=
=3D"_blank">mst@redhat.com</a> &lt;mailto:<a href=3D"mailto:mst@redhat.com"=
 target=3D"_blank">mst@redhat.com</a>&gt;&gt;&gt;&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0On Thu, Nov 02, 2023 at 11:09:27AM +0200, Yuri<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Benditovich wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Probably we mix two different patches in this=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0discussion.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Focusing on the patch in the e-mail header:<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; IMO it is not acceptable to fail QEMU run<br>
&gt;=C2=A0 =C2=A0 =C2=A0for one<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0feature<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0t=
hat we<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0can&#39;t make<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; active when we silently drop all other<br>
&gt;=C2=A0 =C2=A0 =C2=A0features in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0such a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0c=
ase.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0If the feature is off by default then it seems more=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0reasonable<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0and silent masking can be seen as a bug.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0Most virtio features are on by default this is<br>
&gt;=C2=A0 =C2=A0 =C2=A0why it&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0reasonable to mask them.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; If we are talking about RSS: setting it initially<br>
&gt;=C2=A0 =C2=A0 =C2=A0off is the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0d=
evelopment<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; time decision.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; When it will be completely stable there is no reason to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0keep it<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0o=
ff by<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; default, so this is more a question of time and of a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0readiness of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0l=
ibvirt.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0I=
t is not ok to make &quot;on&quot; the default; that will<br>
&gt;=C2=A0 =C2=A0 =C2=A0enable RSS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0even when<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0e=
BPF steering support is not present and can result in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0performance<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0d=
egradation.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Exactly as it is tod=
ay - with vhost=3Don the host does not<br>
&gt;=C2=A0 =C2=A0 =C2=A0suggest RSS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; without=C2=A0 eBPF.<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; I do not understand =
what you call &quot;performance<br>
&gt;=C2=A0 =C2=A0 =C2=A0degradation&quot;, can you<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; describe the scenari=
o?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0I was not clear, but I was=
 talking about the case of<br>
&gt;=C2=A0 =C2=A0 =C2=A0vhost=3Doff or peers<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0other than tap (e.g., user=
). rss=3Don employs in-qemu RSS,<br>
&gt;=C2=A0 =C2=A0 =C2=A0which incurs<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0overheads for such configu=
rations.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; So, vhost=3Doff OR peers other than tap:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; In the case of peers other than tap (IMO) we&=
#39;re not talking about<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; performance at all.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Backends like &quot;user&quot; (without vnet_=
hdr) do not support _many_<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; performance-oriented features.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; If RSS is somehow &quot;supported&quot; for s=
uch backends this is rather a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; misunderstanding (IMO again).<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0We do not need to ensure good performance when RSS =
is enabled by the<br>
&gt;=C2=A0 =C2=A0 =C2=A0guest for backends without eBPF steering program as=
 you say. In-QEMU<br>
&gt;=C2=A0 =C2=A0 =C2=A0RSS<br>
&gt;=C2=A0 =C2=A0 =C2=A0is only useful for testing and not meant to improve=
 the performance.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0However, if you set rss=3Don, QEMU will advertise t=
he availability of RSS<br>
&gt;=C2=A0 =C2=A0 =C2=A0feature. The guest will have no mean to know if it&=
#39;s implemented in a<br>
&gt;=C2=A0 =C2=A0 =C2=A0way not performance-wise so it may decide to use th=
e feature to improve<br>
&gt;=C2=A0 =C2=A0 =C2=A0the performance, which can result in performance de=
gradation.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Therefore,<br>
&gt;=C2=A0 =C2=A0 =C2=A0it&#39;s better not to set rss=3Don for such backen=
ds.<br>
&gt; <br>
&gt; <br>
&gt; I still do not understand what is the scenario where you see or suspec=
t <br>
&gt; the mentioned &quot;performance degradation&quot;.<br>
&gt; We can discuss whether such a problem exists as soon as you explain it=
.<br>
<br>
The scenario is that:<br>
- rss=3Don,<br>
- A backend without eBPF steering support is in use, and<br>
- The guest expects VIRTIO_NET_F_RSS has little overheads as hardware <br>
RSS implementations do.<br>
<br>
I consider the risk of the performance degradation in such a situation <br>
is the reason why virtio-net emits a warning (&quot;Can&#39;t load eBPF RSS=
 - <br>
fallback to software RSS&quot;) when in-QEMU RSS is in use.<br></blockquote=
><div><br></div><div>In a described scenario (vhost=3Doff) I do not see why=
 the performance degradation should happen:</div><div>the SW RSS (if activa=
ted) will place each packet into proper queue (even if the auto_mq in kerne=
l is not able to do that) and such a way the guest will not need to resched=
ule the packet to proper CPU<br></div><div><br></div></div></div>

--00000000000086dc38060a0bf9c2--

