Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC007E9B59
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 12:45:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2VMk-0006Nj-Mh; Mon, 13 Nov 2023 06:44:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1r2VMi-0006NE-Hr
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 06:44:28 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1r2VMf-0007qO-HH
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 06:44:28 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2c6b30aca06so56731341fa.3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 03:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1699875863; x=1700480663;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8MeBVPbi402xlNda1qfnUGIhRj5mgiH8tjcgPDtZtzM=;
 b=yfhPWKeN/bQk7Hmb08KbBfSfyj0LiFMuvRnfAq24S3hOjcBMnt0MWUYzZGKv9FCNRu
 Glp6NEMu2soysUHsFU+Uc+t8alc1mPbrkgzKddqZfPMc6wRnE5LASZHnQ+ABtsTk0JOm
 QeeCeXI01DCnXkX0hUcL99kpn1kl7fB4njfVaReeKHWIk/MQLLk9urPi68luyP2VCt2h
 z6ulqluwVxZzj70obK1U4nlNKxsiXPkdoZ0vCp9IxDHmOtH/DD8KqCSGVz0B4OO0xX1N
 6CJDryPMtYf6kh4fT4rbup6xSPBg2q3CulDeWNJ9fiLhwFQbbSC+042alPzPYKUJKRck
 htgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699875863; x=1700480663;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8MeBVPbi402xlNda1qfnUGIhRj5mgiH8tjcgPDtZtzM=;
 b=wUA2fIPK63fGhZ2KNP247XNexYnBffql00e7clPlpQu4HwVDPXL+/zALefvzcInk1E
 RHubMy6XXQvWGtoZkBqAzUF4PaxUFnc6BMivX/H1YsGg9IM63sZKu+YP96zudZt22qit
 P0Q7e9qbW9/wxJwrgXqKJrSjPvYr1DABeJZhZI1k9gB1wGOCWi5DrXqWHc9Y7JSEdpX+
 KYpQvjQy6kiro8RvV5KRNg3sTHBDW5GmZZU4rJWSZ2caEHV67DdN+rWNWSqLCWjgKoQ7
 ujEzwKHDR6+TQzIu7eAuCl4nb+/5ELXu7VH/5oJrSfL6x6h/oMHZaqLuZeJCXpjRHK4x
 V8lQ==
X-Gm-Message-State: AOJu0YyjoiT2L2Sh4yNAPlk1/mFgYbDpC/E59yfKGM3iXufGxpuL8dDp
 G+3X/OZuYWHWg8xq9fI23/qGXWcrkyIziicUQHTbww==
X-Google-Smtp-Source: AGHT+IHOuYf4wmt6BBWcoiudOEEI/jzVu0LpyF/13/psfyOO7OVtYUfEWqYO1caewRsc0H+Q8u2ty9V6IBI0ke7lF8k=
X-Received: by 2002:a2e:9dda:0:b0:2c5:234c:86f2 with SMTP id
 x26-20020a2e9dda000000b002c5234c86f2mr4213814ljj.13.1699875862713; Mon, 13
 Nov 2023 03:44:22 -0800 (PST)
MIME-Version: 1.0
References: <58fb3b75-dd69-4715-a8ec-4c3df3b7e4c5@daynix.com>
 <CAOEp5Oern10jW8Pi-_mceU_ZJVD=a1f3tW8rB2O4efLX45-nvw@mail.gmail.com>
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
In-Reply-To: <8439be4e-a739-4cbd-a569-89b6c7f68ab9@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 13 Nov 2023 13:44:10 +0200
Message-ID: <CAOEp5Oee2qinrZJgMMxUQt6zmPVFPCnThfqnLFSWqsSyAoHpjQ@mail.gmail.com>
Subject: Re: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Andrew Melnychenko <andrew@daynix.com>
Content-Type: multipart/alternative; boundary="000000000000f5a94b060a0730d5"
Received-SPF: none client-ip=2a00:1450:4864:20::235;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-lj1-x235.google.com
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

--000000000000f5a94b060a0730d5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 5:28=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com>
wrote:

> On 2023/11/03 22:14, Yuri Benditovich wrote:
> >
> >
> > On Fri, Nov 3, 2023 at 11:55=E2=80=AFAM Akihiko Odaki <akihiko.odaki@da=
ynix.com
> > <mailto:akihiko.odaki@daynix.com>> wrote:
> >
> >     On 2023/11/03 18:35, Yuri Benditovich wrote:
> >      >
> >      >
> >      > On Thu, Nov 2, 2023 at 4:56=E2=80=AFPM Akihiko Odaki
> >     <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
> >      > <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>> wrote:
> >      >
> >      >     On 2023/11/02 19:20, Yuri Benditovich wrote:
> >      >      >
> >      >      >
> >      >      > On Thu, Nov 2, 2023 at 11:33=E2=80=AFAM Michael S. Tsirki=
n
> >      >     <mst@redhat.com <mailto:mst@redhat.com>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>
> >      >      > <mailto:mst@redhat.com <mailto:mst@redhat.com>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>> wrote:
> >      >      >
> >      >      >     On Thu, Nov 02, 2023 at 11:09:27AM +0200, Yuri
> >     Benditovich wrote:
> >      >      >      > Probably we mix two different patches in this
> >     discussion.
> >      >      >      > Focusing on the patch in the e-mail header:
> >      >      >      >
> >      >      >      > IMO it is not acceptable to fail QEMU run for one
> >     feature
> >      >     that we
> >      >      >     can't make
> >      >      >      > active when we silently drop all other features in
> >     such a
> >      >     case.
> >      >      >
> >      >      >     If the feature is off by default then it seems more
> >     reasonable
> >      >      >     and silent masking can be seen as a bug.
> >      >      >     Most virtio features are on by default this is why it=
's
> >      >      >     reasonable to mask them.
> >      >      >
> >      >      >
> >      >      > If we are talking about RSS: setting it initially off is
> the
> >      >     development
> >      >      > time decision.
> >      >      > When it will be completely stable there is no reason to
> >     keep it
> >      >     off by
> >      >      > default, so this is more a question of time and of a
> >     readiness of
> >      >     libvirt.
> >      >
> >      >     It is not ok to make "on" the default; that will enable RSS
> >     even when
> >      >     eBPF steering support is not present and can result in
> >     performance
> >      >     degradation.
> >      >
> >      >
> >      > Exactly as it is today - with vhost=3Don the host does not sugge=
st
> RSS
> >      > without  eBPF.
> >      > I do not understand what you call "performance degradation", can
> you
> >      > describe the scenario?
> >
> >     I was not clear, but I was talking about the case of vhost=3Doff or
> peers
> >     other than tap (e.g., user). rss=3Don employs in-qemu RSS, which in=
curs
> >     overheads for such configurations.
> >
> >
> > So, vhost=3Doff OR peers other than tap:
> >
> > In the case of peers other than tap (IMO) we're not talking about
> > performance at all.
> > Backends like "user" (without vnet_hdr) do not support _many_
> > performance-oriented features.
> > If RSS is somehow "supported" for such backends this is rather a
> > misunderstanding (IMO again).
>
> We do not need to ensure good performance when RSS is enabled by the
> guest for backends without eBPF steering program as you say. In-QEMU RSS
> is only useful for testing and not meant to improve the performance.
>
> However, if you set rss=3Don, QEMU will advertise the availability of RSS
> feature. The guest will have no mean to know if it's implemented in a
> way not performance-wise so it may decide to use the feature to improve
> the performance, which can result in performance degradation. Therefore,
> it's better not to set rss=3Don for such backends.
>

I still do not understand what is the scenario where you see or suspect the
mentioned "performance degradation".
We can discuss whether such a problem exists as soon as you explain it.

--000000000000f5a94b060a0730d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Nov 11, 2023 at 5:28=E2=80=AF=
PM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.od=
aki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On 2023/11/03 22:14, Yuri Benditovich wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Fri, Nov 3, 2023 at 11:55=E2=80=AFAM Akihiko Odaki &lt;<a href=3D"m=
ailto:akihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com<=
/a> <br>
&gt; &lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blan=
k">akihiko.odaki@daynix.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 2023/11/03 18:35, Yuri Benditovich wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Thu, Nov 2, 2023 at 4:56=E2=80=AFPM Akihik=
o Odaki<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:akihiko.odaki@daynix.com" tar=
get=3D"_blank">akihiko.odaki@daynix.com</a> &lt;mailto:<a href=3D"mailto:ak=
ihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &lt;mailto:<a href=3D"mailto:akihiko.odaki@da=
ynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.c=
om" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0On 2023/11/02 19:20, Yuri =
Benditovich wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Thu, Nov 2, 2023 =
at 11:33=E2=80=AFAM Michael S. Tsirkin<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:mst@=
redhat.com" target=3D"_blank">mst@redhat.com</a> &lt;mailto:<a href=3D"mail=
to:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:mst@redhat.com" target=
=3D"_blank">mst@redhat.com</a> &lt;mailto:<a href=3D"mailto:mst@redhat.com"=
 target=3D"_blank">mst@redhat.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; &lt;mailto:<a href=
=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a> &lt;mailto:=
<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:mst@redhat.com" target=
=3D"_blank">mst@redhat.com</a> &lt;mailto:<a href=3D"mailto:mst@redhat.com"=
 target=3D"_blank">mst@redhat.com</a>&gt;&gt;&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0O=
n Thu, Nov 02, 2023 at 11:09:27AM +0200, Yuri<br>
&gt;=C2=A0 =C2=A0 =C2=A0Benditovich wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; Probably we mix two different patches in this<br>
&gt;=C2=A0 =C2=A0 =C2=A0discussion.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; Focusing on the patch in the e-mail header:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; IMO it is not acceptable to fail QEMU run for one<br>
&gt;=C2=A0 =C2=A0 =C2=A0feature<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0that we<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0c=
an&#39;t make<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; active when we silently drop all other features in<br>
&gt;=C2=A0 =C2=A0 =C2=A0such a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0case.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0I=
f the feature is off by default then it seems more<br>
&gt;=C2=A0 =C2=A0 =C2=A0reasonable<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0a=
nd silent masking can be seen as a bug.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0M=
ost virtio features are on by default this is why it&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0r=
easonable to mask them.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; If we are talking ab=
out RSS: setting it initially off is the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0development<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; time decision.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; When it will be comp=
letely stable there is no reason to<br>
&gt;=C2=A0 =C2=A0 =C2=A0keep it<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0off by<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; default, so this is =
more a question of time and of a<br>
&gt;=C2=A0 =C2=A0 =C2=A0readiness of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0libvirt.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0It is not ok to make &quot=
;on&quot; the default; that will enable RSS<br>
&gt;=C2=A0 =C2=A0 =C2=A0even when<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0eBPF steering support is n=
ot present and can result in<br>
&gt;=C2=A0 =C2=A0 =C2=A0performance<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0degradation.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Exactly as it is today - with vhost=3Don the =
host does not suggest RSS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; without=C2=A0 eBPF.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; I do not understand what you call &quot;perfo=
rmance degradation&quot;, can you<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; describe the scenario?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I was not clear, but I was talking about the case o=
f vhost=3Doff or peers<br>
&gt;=C2=A0 =C2=A0 =C2=A0other than tap (e.g., user). rss=3Don employs in-qe=
mu RSS, which incurs<br>
&gt;=C2=A0 =C2=A0 =C2=A0overheads for such configurations.<br>
&gt; <br>
&gt; <br>
&gt; So, vhost=3Doff OR peers other than tap:<br>
&gt; <br>
&gt; In the case of peers other than tap (IMO) we&#39;re not talking about =
<br>
&gt; performance at all.<br>
&gt; Backends like &quot;user&quot; (without vnet_hdr) do not support _many=
_ <br>
&gt; performance-oriented features.<br>
&gt; If RSS is somehow &quot;supported&quot; for such backends this is rath=
er a <br>
&gt; misunderstanding (IMO again).<br>
<br>
We do not need to ensure good performance when RSS is enabled by the <br>
guest for backends without eBPF steering program as you say. In-QEMU RSS <b=
r>
is only useful for testing and not meant to improve the performance.<br>
<br>
However, if you set rss=3Don, QEMU will advertise the availability of RSS <=
br>
feature. The guest will have no mean to know if it&#39;s implemented in a <=
br>
way not performance-wise so it may decide to use the feature to improve <br=
>
the performance, which can result in performance degradation. Therefore, <b=
r>
it&#39;s better not to set rss=3Don for such backends.<br></blockquote><div=
><br></div><div>I still do not understand what is the scenario where you se=
e or suspect the mentioned &quot;performance degradation&quot;.</div><div>W=
e can discuss whether such a problem exists as soon as you explain it.</div=
><div><br></div><div><br></div></div></div>

--000000000000f5a94b060a0730d5--

