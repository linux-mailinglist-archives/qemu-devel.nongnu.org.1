Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCF07EB92C
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 23:11:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r31bO-0001Lb-LJ; Tue, 14 Nov 2023 17:09:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1r31bM-0001LJ-61
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 17:09:44 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1r31bI-0003ew-HM
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 17:09:43 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c4fdf94666so82100031fa.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 14:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1699999771; x=1700604571;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7eoRQaLKPpn2C3mKEmchLlKIa3kJxqGoZy65eJrpTRA=;
 b=naEiuuGEBqwDBZ1NBUh3G74LQNL3h+HjD7MQAZ3fpvMi0FFHh8I9tmOTtRLEsGwF38
 pUunVCDBQpY5XYraFiCOjgWLnkxzPRnNoQaseNA9iA5bKs5xXKLatZ1rWiJ3LVjeF9Lf
 RhySaGySrgcvURveO/UXVOfBwYdnmeadvYQgWd0IhgrU0QjIvS8JQ7S0SlcAEBgirMi1
 wxTbjgfoO+OBVCYeal0NvPdWTHY7s8sAtX/L92M6+GXUVQJd2vvv6IOWiW7nW8SYn10z
 34P/eZurfEn0VTbv1Z/oiV4gWpWQJ7/C7g7mgNBMOOJzHNdWc2e+SYZ8muNUNB+DX8dX
 IG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699999771; x=1700604571;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7eoRQaLKPpn2C3mKEmchLlKIa3kJxqGoZy65eJrpTRA=;
 b=Kzuy56I5p7BSZLyEysZhpe5ZYSbjtY/sToeIbYLss53SXg4RF1IQxSTaTK4uatZ8OI
 nTETuCDuGj2njGEWtc2njsgsFNe4mGZgjk8/oDfgfhElBo8cNL1NmJpgwcwpgQp847iy
 F8nYRlS2nprbgofQM324DTxCwLVLvONDGphvcBGGMr8TfE4pgg0s6acfGSI8FHYmEUgL
 9hgL7Zcjl1Ejd6RxCBLzZ4ad71/EgsGbl9maacFozxxhb1nXWPYXMiVu+batsl4Vo16K
 vLwA1NPIJ+6X0dKYy0psN1l8eBSb+0qAecCCmOKJ7wiC1iNo3tHu26Nx/E5YsBhjfTLY
 oQhg==
X-Gm-Message-State: AOJu0YwTPM60RUxEntdJi/vGjsNeSsGpK+tk4gUm9GwrOih7QLgoTKww
 5tsu/5Idz9EPZysE8SMFUVEn5MZBsIM54E9U14rnGA==
X-Google-Smtp-Source: AGHT+IEanMbxfHQQF+VEsmIk4EqonxYe1qlvuoNXvMCKG2sh2Lj/183FaL830eFTsh6oGvcByWUUrMXluMG8E+loKg0=
X-Received: by 2002:a05:651c:1316:b0:2c7:2e27:5b46 with SMTP id
 u22-20020a05651c131600b002c72e275b46mr2335377lja.37.1699999771547; Tue, 14
 Nov 2023 14:09:31 -0800 (PST)
MIME-Version: 1.0
References: <58fb3b75-dd69-4715-a8ec-4c3df3b7e4c5@daynix.com>
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
 <CAOEp5OfXH-1ygYMJxq1phwbOJkkvnwBce=TDVLwjsXG6UgwPGA@mail.gmail.com>
 <637b0f33-6b12-4623-b504-d3ea64908813@daynix.com>
In-Reply-To: <637b0f33-6b12-4623-b504-d3ea64908813@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Wed, 15 Nov 2023 00:09:18 +0200
Message-ID: <CAOEp5Oc3mb=v-F3Xfx-ypzojq7hLeoPmxu53WA9_4mTx1j50BA@mail.gmail.com>
Subject: Re: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Andrew Melnychenko <andrew@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000806e40060a240a6d"
Received-SPF: none client-ip=2a00:1450:4864:20::22e;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-lj1-x22e.google.com
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

--000000000000806e40060a240a6d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 9:03=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com>
wrote:

> On 2023/11/14 2:26, Yuri Benditovich wrote:
> >
> >
> > On Mon, Nov 13, 2023 at 2:44=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com
> > <mailto:akihiko.odaki@daynix.com>> wrote:
> >
> >     On 2023/11/13 20:44, Yuri Benditovich wrote:
> >      >
> >      >
> >      > On Sat, Nov 11, 2023 at 5:28=E2=80=AFPM Akihiko Odaki
> >     <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
> >      > <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>> wrote:
> >      >
> >      >     On 2023/11/03 22:14, Yuri Benditovich wrote:
> >      >      >
> >      >      >
> >      >      > On Fri, Nov 3, 2023 at 11:55=E2=80=AFAM Akihiko Odaki
> >      >     <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
> >     <mailto:akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>>
> >      >      > <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>
> >      >     <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>>> wrote:
> >      >      >
> >      >      >     On 2023/11/03 18:35, Yuri Benditovich wrote:
> >      >      >      >
> >      >      >      >
> >      >      >      > On Thu, Nov 2, 2023 at 4:56=E2=80=AFPM Akihiko Oda=
ki
> >      >      >     <akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com> <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>
> >      >     <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com> <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>>
> >      >      >      > <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>
> >      >     <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>
> >      >      >     <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>
> >      >     <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>>>> wrote:
> >      >      >      >
> >      >      >      >     On 2023/11/02 19:20, Yuri Benditovich wrote:
> >      >      >      >      >
> >      >      >      >      >
> >      >      >      >      > On Thu, Nov 2, 2023 at 11:33=E2=80=AFAM Mic=
hael S.
> >     Tsirkin
> >      >      >      >     <mst@redhat.com <mailto:mst@redhat.com>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>
> >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>
> >      >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>
> >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>>
> >      >      >      >      > <mailto:mst@redhat.com
> >     <mailto:mst@redhat.com> <mailto:mst@redhat.com <mailto:
> mst@redhat.com>>
> >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>
> >      >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>
> >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
> >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>>>> wrote:
> >      >      >      >      >
> >      >      >      >      >     On Thu, Nov 02, 2023 at 11:09:27AM
> >     +0200, Yuri
> >      >      >     Benditovich wrote:
> >      >      >      >      >      > Probably we mix two different patche=
s
> >     in this
> >      >      >     discussion.
> >      >      >      >      >      > Focusing on the patch in the e-mail
> >     header:
> >      >      >      >      >      >
> >      >      >      >      >      > IMO it is not acceptable to fail QEM=
U
> run
> >      >     for one
> >      >      >     feature
> >      >      >      >     that we
> >      >      >      >      >     can't make
> >      >      >      >      >      > active when we silently drop all oth=
er
> >      >     features in
> >      >      >     such a
> >      >      >      >     case.
> >      >      >      >      >
> >      >      >      >      >     If the feature is off by default then i=
t
> >     seems more
> >      >      >     reasonable
> >      >      >      >      >     and silent masking can be seen as a bug=
.
> >      >      >      >      >     Most virtio features are on by default
> >     this is
> >      >     why it's
> >      >      >      >      >     reasonable to mask them.
> >      >      >      >      >
> >      >      >      >      >
> >      >      >      >      > If we are talking about RSS: setting it
> >     initially
> >      >     off is the
> >      >      >      >     development
> >      >      >      >      > time decision.
> >      >      >      >      > When it will be completely stable there is
> >     no reason to
> >      >      >     keep it
> >      >      >      >     off by
> >      >      >      >      > default, so this is more a question of time
> >     and of a
> >      >      >     readiness of
> >      >      >      >     libvirt.
> >      >      >      >
> >      >      >      >     It is not ok to make "on" the default; that wi=
ll
> >      >     enable RSS
> >      >      >     even when
> >      >      >      >     eBPF steering support is not present and can
> >     result in
> >      >      >     performance
> >      >      >      >     degradation.
> >      >      >      >
> >      >      >      >
> >      >      >      > Exactly as it is today - with vhost=3Don the host
> >     does not
> >      >     suggest RSS
> >      >      >      > without  eBPF.
> >      >      >      > I do not understand what you call "performance
> >      >     degradation", can you
> >      >      >      > describe the scenario?
> >      >      >
> >      >      >     I was not clear, but I was talking about the case of
> >      >     vhost=3Doff or peers
> >      >      >     other than tap (e.g., user). rss=3Don employs in-qemu
> RSS,
> >      >     which incurs
> >      >      >     overheads for such configurations.
> >      >      >
> >      >      >
> >      >      > So, vhost=3Doff OR peers other than tap:
> >      >      >
> >      >      > In the case of peers other than tap (IMO) we're not
> >     talking about
> >      >      > performance at all.
> >      >      > Backends like "user" (without vnet_hdr) do not support
> _many_
> >      >      > performance-oriented features.
> >      >      > If RSS is somehow "supported" for such backends this is
> >     rather a
> >      >      > misunderstanding (IMO again).
> >      >
> >      >     We do not need to ensure good performance when RSS is enable=
d
> >     by the
> >      >     guest for backends without eBPF steering program as you say.
> >     In-QEMU
> >      >     RSS
> >      >     is only useful for testing and not meant to improve the
> >     performance.
> >      >
> >      >     However, if you set rss=3Don, QEMU will advertise the
> >     availability of RSS
> >      >     feature. The guest will have no mean to know if it's
> >     implemented in a
> >      >     way not performance-wise so it may decide to use the feature
> >     to improve
> >      >     the performance, which can result in performance degradation=
.
> >      >     Therefore,
> >      >     it's better not to set rss=3Don for such backends.
> >      >
> >      >
> >      > I still do not understand what is the scenario where you see or
> >     suspect
> >      > the mentioned "performance degradation".
> >      > We can discuss whether such a problem exists as soon as you
> >     explain it.
> >
> >     The scenario is that:
> >     - rss=3Don,
> >     - A backend without eBPF steering support is in use, and
> >     - The guest expects VIRTIO_NET_F_RSS has little overheads as hardwa=
re
> >     RSS implementations do.
> >
> >     I consider the risk of the performance degradation in such a
> situation
> >     is the reason why virtio-net emits a warning ("Can't load eBPF RSS =
-
> >     fallback to software RSS") when in-QEMU RSS is in use.
> >
> >
> > In a described scenario (vhost=3Doff) I do not see why the performance
> > degradation should happen:
> > the SW RSS (if activated) will place each packet into proper queue (eve=
n
> > if the auto_mq in kernel is not able to do that) and such a way the
> > guest will not need to reschedule the packet to proper CPU
> >
>
> The scenario I'm concerned is that the guest has its own packet steering
> mechanism which is feature-wise superior to RSS. For example, Linux has
> such a mechanism called RPS, which has some advantages due to its
> extensible nature according to:
>
> https://www.kernel.org/doc/html/v6.6/networking/scaling.html#rps-receive-=
packet-steering
>
> Such a guest may still prefer hardware RSS if available since hardware
> RSS is expected to have less overheads. However, it is not true for
> in-qemu RSS, and using in-QEMU RSS instead of the guest-side steering
> mechanism may just hide useful features the guest-side steering
> mechanism has and result in performance degradation.
>

Note that in terms of per-packet computation for RSS the in-QEMU RSS does
exactly the same operations in native code that the eBPF does in the
emulation.
So, I wouldn't say that SW RSS brings some "performance degradation".
We prefer eBPF as it can serve both vhost and non-vhost setups.


> Andrew, I appreciate if you also tell the rationale behind the warning
> you put for software RSS ("Can't load eBPF RSS - fallback to software
> RSS").
>

--000000000000806e40060a240a6d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 14, 2023 at 9:03=E2=80=AF=
AM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.od=
aki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On 2023/11/14 2:26, Yuri Benditovich wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Mon, Nov 13, 2023 at 2:44=E2=80=AFPM Akihiko Odaki &lt;<a href=3D"m=
ailto:akihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com<=
/a> <br>
&gt; &lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blan=
k">akihiko.odaki@daynix.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 2023/11/13 20:44, Yuri Benditovich wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Sat, Nov 11, 2023 at 5:28=E2=80=AFPM Akihi=
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
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0On 2023/11/03 22:14, Yuri =
Benditovich wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Fri, Nov 3, 2023 =
at 11:55=E2=80=AFAM Akihiko Odaki<br>
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
n 2023/11/03 18:35, Yuri Benditovich wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; On Thu, Nov 2, 2023 at 4:56=E2=80=AFPM Akihiko Odaki<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&=
lt;<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blank">akihiko.od=
aki@daynix.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.c=
om" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt; &lt;mailto:<a href=
=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix=
.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.c=
om" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:akihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a>=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.c=
om" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt; &lt;mailto:<a href=
=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix=
.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.c=
om" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; &lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blan=
k">akihiko.odaki@daynix.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.c=
om" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:akihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a>=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.c=
om" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&=
lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blank">aki=
hiko.odaki@daynix.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.c=
om" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:akihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a>=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.c=
om" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;&gt;&gt;&gt;&gt; wrot=
e:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0On 2023/11/02 19:20, Yuri Benditovich wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Thu, Nov 2, 2023 at 11:33=E2=80=AFAM Micha=
el S.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Tsirkin<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:mst@redhat.com" target=3D"_bl=
ank">mst@redhat.com</a> &lt;mailto:<a href=3D"mailto:mst@redhat.com" target=
=3D"_blank">mst@redhat.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:mst@redhat.com" target=
=3D"_blank">mst@redhat.com</a> &lt;mailto:<a href=3D"mailto:mst@redhat.com"=
 target=3D"_blank">mst@redhat.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:mst@redhat.com" target=3D"_blank">mst@redhat.com</a> &lt;mailto:<a href=
=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:mst@redhat.com" target=
=3D"_blank">mst@redhat.com</a> &lt;mailto:<a href=3D"mailto:mst@redhat.com"=
 target=3D"_blank">mst@redhat.com</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&=
lt;mailto:<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.co=
m</a> &lt;mailto:<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@re=
dhat.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:mst@redhat.com" target=
=3D"_blank">mst@redhat.com</a> &lt;mailto:<a href=3D"mailto:mst@redhat.com"=
 target=3D"_blank">mst@redhat.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:mst@redhat.com" target=3D"_blank">mst@redhat.com</a> &lt;mailto:<a href=
=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:mst@redhat.com" target=
=3D"_blank">mst@redhat.com</a> &lt;mailto:<a href=3D"mailto:mst@redhat.com"=
 target=3D"_blank">mst@redhat.com</a>&gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &lt;mailto:<a href=3D"mailto:mst@redhat.com" =
target=3D"_blank">mst@redhat.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:mst@redhat.com" target=
=3D"_blank">mst@redhat.com</a>&gt; &lt;mailto:<a href=3D"mailto:mst@redhat.=
com" target=3D"_blank">mst@redhat.com</a> &lt;mailto:<a href=3D"mailto:mst@=
redhat.com" target=3D"_blank">mst@redhat.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:mst@redhat.com" target=3D"_blank">mst@redhat.com</a> &lt;mailto:<a href=
=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:mst@redhat.com" target=
=3D"_blank">mst@redhat.com</a> &lt;mailto:<a href=3D"mailto:mst@redhat.com"=
 target=3D"_blank">mst@redhat.com</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&=
lt;mailto:<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.co=
m</a> &lt;mailto:<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@re=
dhat.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:mst@redhat.com" target=
=3D"_blank">mst@redhat.com</a> &lt;mailto:<a href=3D"mailto:mst@redhat.com"=
 target=3D"_blank">mst@redhat.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:mst@redhat.com" target=3D"_blank">mst@redhat.com</a> &lt;mailto:<a href=
=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:mst@redhat.com" target=
=3D"_blank">mst@redhat.com</a> &lt;mailto:<a href=3D"mailto:mst@redhat.com"=
 target=3D"_blank">mst@redhat.com</a>&gt;&gt;&gt;&gt;&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0On Thu, Nov 02, 2023 at 11=
:09:27AM<br>
&gt;=C2=A0 =C2=A0 =C2=A0+0200, Yuri<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0B=
enditovich wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Probably we mix two =
different patches<br>
&gt;=C2=A0 =C2=A0 =C2=A0in this<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0d=
iscussion.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Focusing on the patc=
h in the e-mail<br>
&gt;=C2=A0 =C2=A0 =C2=A0header:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; IMO it is not accept=
able to fail QEMU run<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0for one<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0f=
eature<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0that we<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0can&#39;t make<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; active when we silen=
tly drop all other<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0features in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0s=
uch a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0case.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0If the feature is off by d=
efault then it<br>
&gt;=C2=A0 =C2=A0 =C2=A0seems more<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0r=
easonable<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0and silent masking can be =
seen as a bug.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Most virtio features are o=
n by default<br>
&gt;=C2=A0 =C2=A0 =C2=A0this is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0why it&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0reasonable to mask them.<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; If we are talking about RSS: setting it<br>
&gt;=C2=A0 =C2=A0 =C2=A0initially<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0off is the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0development<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; time decision.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; When it will be completely stable there is<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0no reason to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0k=
eep it<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0off by<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; default, so this is more a question of time<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0and of a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0r=
eadiness of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0libvirt.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0It is not ok to make &quot;on&quot; the default; th=
at will<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0enable RSS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0e=
ven when<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0eBPF steering support is not present and can<br>
&gt;=C2=A0 =C2=A0 =C2=A0result in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0p=
erformance<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0degradation.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; Exactly as it is today - with vhost=3Don the host<br>
&gt;=C2=A0 =C2=A0 =C2=A0does not<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0suggest RSS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; without=C2=A0 eBPF.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; I do not understand what you call &quot;performance<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0degradation&quot;, can you=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; describe the scenario?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0I=
 was not clear, but I was talking about the case of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0vhost=3Doff or peers<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0o=
ther than tap (e.g., user). rss=3Don employs in-qemu RSS,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0which incurs<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0o=
verheads for such configurations.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; So, vhost=3Doff OR p=
eers other than tap:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; In the case of peers=
 other than tap (IMO) we&#39;re not<br>
&gt;=C2=A0 =C2=A0 =C2=A0talking about<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; performance at all.<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Backends like &quot;=
user&quot; (without vnet_hdr) do not support _many_<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; performance-oriented=
 features.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; If RSS is somehow &q=
uot;supported&quot; for such backends this is<br>
&gt;=C2=A0 =C2=A0 =C2=A0rather a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; misunderstanding (IM=
O again).<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0We do not need to ensure g=
ood performance when RSS is enabled<br>
&gt;=C2=A0 =C2=A0 =C2=A0by the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0guest for backends without=
 eBPF steering program as you say.<br>
&gt;=C2=A0 =C2=A0 =C2=A0In-QEMU<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0RSS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0is only useful for testing=
 and not meant to improve the<br>
&gt;=C2=A0 =C2=A0 =C2=A0performance.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0However, if you set rss=3D=
on, QEMU will advertise the<br>
&gt;=C2=A0 =C2=A0 =C2=A0availability of RSS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0feature. The guest will ha=
ve no mean to know if it&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0implemented in a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0way not performance-wise s=
o it may decide to use the feature<br>
&gt;=C2=A0 =C2=A0 =C2=A0to improve<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0the performance, which can=
 result in performance degradation.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Therefore,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0it&#39;s better not to set=
 rss=3Don for such backends.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; I still do not understand what is the scenari=
o where you see or<br>
&gt;=C2=A0 =C2=A0 =C2=A0suspect<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; the mentioned &quot;performance degradation&q=
uot;.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; We can discuss whether such a problem exists =
as soon as you<br>
&gt;=C2=A0 =C2=A0 =C2=A0explain it.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0The scenario is that:<br>
&gt;=C2=A0 =C2=A0 =C2=A0- rss=3Don,<br>
&gt;=C2=A0 =C2=A0 =C2=A0- A backend without eBPF steering support is in use=
, and<br>
&gt;=C2=A0 =C2=A0 =C2=A0- The guest expects VIRTIO_NET_F_RSS has little ove=
rheads as hardware<br>
&gt;=C2=A0 =C2=A0 =C2=A0RSS implementations do.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I consider the risk of the performance degradation =
in such a situation<br>
&gt;=C2=A0 =C2=A0 =C2=A0is the reason why virtio-net emits a warning (&quot=
;Can&#39;t load eBPF RSS -<br>
&gt;=C2=A0 =C2=A0 =C2=A0fallback to software RSS&quot;) when in-QEMU RSS is=
 in use.<br>
&gt; <br>
&gt; <br>
&gt; In a described scenario (vhost=3Doff) I do not see why the performance=
 <br>
&gt; degradation should happen:<br>
&gt; the SW RSS (if activated) will place each packet into proper queue (ev=
en <br>
&gt; if the auto_mq in kernel is not able to do that) and such a way the <b=
r>
&gt; guest will not need to reschedule the packet to proper CPU<br>
&gt; <br>
<br>
The scenario I&#39;m concerned is that the guest has its own packet steerin=
g <br>
mechanism which is feature-wise superior to RSS. For example, Linux has <br=
>
such a mechanism called RPS, which has some advantages due to its <br>
extensible nature according to:<br>
<a href=3D"https://www.kernel.org/doc/html/v6.6/networking/scaling.html#rps=
-receive-packet-steering" rel=3D"noreferrer" target=3D"_blank">https://www.=
kernel.org/doc/html/v6.6/networking/scaling.html#rps-receive-packet-steerin=
g</a><br>
<br>
Such a guest may still prefer hardware RSS if available since hardware <br>
RSS is expected to have less overheads. However, it is not true for <br>
in-qemu RSS, and using in-QEMU RSS instead of the guest-side steering <br>
mechanism may just hide useful features the guest-side steering <br>
mechanism has and result in performance degradation.<br></blockquote><div><=
br></div><div>Note that in terms of per-packet computation for RSS the in-Q=
EMU RSS does exactly the same operations in native code that=C2=A0the eBPF =
does in the emulation.</div><div>So, I wouldn&#39;t say that SW RSS brings =
some &quot;performance degradation&quot;.</div><div>We prefer eBPF as it ca=
n serve both vhost and non-vhost setups.</div><div><br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<br>
Andrew, I appreciate if you also tell the rationale behind the warning <br>
you put for software RSS (&quot;Can&#39;t load eBPF RSS - fallback to softw=
are RSS&quot;).<br>
</blockquote></div></div>

--000000000000806e40060a240a6d--

