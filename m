Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7017E03A6
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 14:15:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyu0n-0003JH-Vd; Fri, 03 Nov 2023 09:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qyu0k-0003Iv-Up
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 09:14:55 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qyu0f-0007Jx-97
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 09:14:54 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c50fbc218bso25441881fa.3
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 06:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1699017287; x=1699622087;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TJAdGxGkJtYuHI8jN2/XXW3wFSJpL2mZ5XuMnPYq9IA=;
 b=vGsTA+cF8NnrMrq9JkKd2bs8mzoTimLiDH8Gdld3qdcESB2D8peV6teMEvQhqTGpWq
 D9oafa1d3dgKvq+W8V2At0OAnuO/qMqHQXFHhycw0IEgws2NL5OSmmtU4sIjYQ/nhf30
 KnNL8w1RnVzg4+WKeiTjvk5NAWUIfIpsJ0btl87WBIxeYFVECBu+jcOPd8wyp2JFCLOh
 1GfpF+cocT+LIBIPnUEoVDZ8Vfp/pu1mFPZOypJM2WjKyH+magnpuHqUNUUqJSxt32bQ
 tUM/8TYbOWXhufdWJ/XS0cWquPelsThq6ObrIRUn7R6bFSVevfHv9znlDrU8k3zvMsZV
 lkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699017287; x=1699622087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TJAdGxGkJtYuHI8jN2/XXW3wFSJpL2mZ5XuMnPYq9IA=;
 b=nnLWk/LodgJFtI1E7i/lRXN/3ZbRF5MsR2NOK8JkobzKkRFGOq1AeiidHsR1iP7Axw
 OK7LowVTkVtSRWHEZbCZ/WlKAkr2EwyHgEacIRdiswMTGJdhQ9H84Kn+ZVZnxEDVCxJl
 TC1cEVYtnJfvhQ7s5VRN6bZUEX4y/0BlSBwD/0lpdEpMCRZvdx4/nsMfu08hvGXruxVU
 RUfzU7nmY0IfvWwfCic5Ij2y3dP5q3LEk5rZPOJe+3qLTilTKjlf6aBOqo7Z7cffHrWY
 6QEBqk9g0xICeAdPONiuSrZg2oxzmwW4mAF+RwNjtXyqRVRO8KyBrJdVZcqonNzGyvJx
 YG+w==
X-Gm-Message-State: AOJu0Yzs0RpozaojJTasxa6D8jI016YfL1S20R+M1M0ihcXseDnlukqI
 y0ybBfuvZC+NXC6LrhRsfpFRJHo4HioK2z8O+qjBtRCSSKfeFi90pkU=
X-Google-Smtp-Source: AGHT+IHKS4RZAT/tViQ3wf0PQE6UzNs012Zfax4HdVivw0yiwIKs91KwYhIwieFq2qHZJIx2DTFxW6FYEPo2J/R4Jw4=
X-Received: by 2002:a2e:8e32:0:b0:2bc:b54b:c03f with SMTP id
 r18-20020a2e8e32000000b002bcb54bc03fmr16156616ljk.5.1699017287134; Fri, 03
 Nov 2023 06:14:47 -0700 (PDT)
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
In-Reply-To: <dbd1d662-bf90-4982-b316-281923a0d778@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Fri, 3 Nov 2023 15:14:35 +0200
Message-ID: <CAOEp5Oc5VzWk7e8gKHfHan1odge39bRUh-ZMojCvkQiTFpXdGg@mail.gmail.com>
Subject: Re: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Andrew Melnychenko <andrew@daynix.com>
Content-Type: multipart/alternative; boundary="000000000000de066806093f4914"
Received-SPF: none client-ip=2a00:1450:4864:20::231;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-lj1-x231.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--000000000000de066806093f4914
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 11:55=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com>
wrote:

> On 2023/11/03 18:35, Yuri Benditovich wrote:
> >
> >
> > On Thu, Nov 2, 2023 at 4:56=E2=80=AFPM Akihiko Odaki <akihiko.odaki@day=
nix.com
> > <mailto:akihiko.odaki@daynix.com>> wrote:
> >
> >     On 2023/11/02 19:20, Yuri Benditovich wrote:
> >      >
> >      >
> >      > On Thu, Nov 2, 2023 at 11:33=E2=80=AFAM Michael S. Tsirkin
> >     <mst@redhat.com <mailto:mst@redhat.com>
> >      > <mailto:mst@redhat.com <mailto:mst@redhat.com>>> wrote:
> >      >
> >      >     On Thu, Nov 02, 2023 at 11:09:27AM +0200, Yuri Benditovich
> wrote:
> >      >      > Probably we mix two different patches in this discussion.
> >      >      > Focusing on the patch in the e-mail header:
> >      >      >
> >      >      > IMO it is not acceptable to fail QEMU run for one feature
> >     that we
> >      >     can't make
> >      >      > active when we silently drop all other features in such a
> >     case.
> >      >
> >      >     If the feature is off by default then it seems more reasonab=
le
> >      >     and silent masking can be seen as a bug.
> >      >     Most virtio features are on by default this is why it's
> >      >     reasonable to mask them.
> >      >
> >      >
> >      > If we are talking about RSS: setting it initially off is the
> >     development
> >      > time decision.
> >      > When it will be completely stable there is no reason to keep it
> >     off by
> >      > default, so this is more a question of time and of a readiness o=
f
> >     libvirt.
> >
> >     It is not ok to make "on" the default; that will enable RSS even wh=
en
> >     eBPF steering support is not present and can result in performance
> >     degradation.
> >
> >
> > Exactly as it is today - with vhost=3Don the host does not suggest RSS
> > without  eBPF.
> > I do not understand what you call "performance degradation", can you
> > describe the scenario?
>
> I was not clear, but I was talking about the case of vhost=3Doff or peers
> other than tap (e.g., user). rss=3Don employs in-qemu RSS, which incurs
> overheads for such configurations.
>

So, vhost=3Doff OR peers other than tap:

In the case of peers other than tap (IMO) we're not talking about
performance at all.
Backends like "user" (without vnet_hdr) do not support _many_
performance-oriented features.
If RSS is somehow "supported" for such backends this is rather a
misunderstanding (IMO again).

In the case of tap with vhost=3Doff the RSS support does not create any
performance degradation without eBPF.

--000000000000de066806093f4914
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 3, 2023 at 11:55=E2=80=AF=
AM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.od=
aki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On 2023/11/03 18:35, Yuri Benditovich wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Thu, Nov 2, 2023 at 4:56=E2=80=AFPM Akihiko Odaki &lt;<a href=3D"ma=
ilto:akihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</=
a> <br>
&gt; &lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blan=
k">akihiko.odaki@daynix.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 2023/11/02 19:20, Yuri Benditovich wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Thu, Nov 2, 2023 at 11:33=E2=80=AFAM Micha=
el S. Tsirkin<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:mst@redhat.com" target=3D"_bl=
ank">mst@redhat.com</a> &lt;mailto:<a href=3D"mailto:mst@redhat.com" target=
=3D"_blank">mst@redhat.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &lt;mailto:<a href=3D"mailto:mst@redhat.com" =
target=3D"_blank">mst@redhat.com</a> &lt;mailto:<a href=3D"mailto:mst@redha=
t.com" target=3D"_blank">mst@redhat.com</a>&gt;&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0On Thu, Nov 02, 2023 at 11=
:09:27AM +0200, Yuri Benditovich wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Probably we mix two =
different patches in this discussion.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Focusing on the patc=
h in the e-mail header:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; IMO it is not accept=
able to fail QEMU run for one feature<br>
&gt;=C2=A0 =C2=A0 =C2=A0that we<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0can&#39;t make<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; active when we silen=
tly drop all other features in such a<br>
&gt;=C2=A0 =C2=A0 =C2=A0case.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0If the feature is off by d=
efault then it seems more reasonable<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0and silent masking can be =
seen as a bug.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Most virtio features are o=
n by default this is why it&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0reasonable to mask them.<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; If we are talking about RSS: setting it initi=
ally off is the<br>
&gt;=C2=A0 =C2=A0 =C2=A0development<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; time decision.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; When it will be completely stable there is no=
 reason to keep it<br>
&gt;=C2=A0 =C2=A0 =C2=A0off by<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; default, so this is more a question of time a=
nd of a readiness of<br>
&gt;=C2=A0 =C2=A0 =C2=A0libvirt.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0It is not ok to make &quot;on&quot; the default; th=
at will enable RSS even when<br>
&gt;=C2=A0 =C2=A0 =C2=A0eBPF steering support is not present and can result=
 in performance<br>
&gt;=C2=A0 =C2=A0 =C2=A0degradation.<br>
&gt; <br>
&gt; <br>
&gt; Exactly as it is today - with vhost=3Don the host does not suggest RSS=
 <br>
&gt; without=C2=A0 eBPF.<br>
&gt; I do not understand what you call &quot;performance degradation&quot;,=
 can you <br>
&gt; describe the scenario?<br>
<br>
I was not clear, but I was talking about the case of vhost=3Doff or peers <=
br>
other than tap (e.g., user). rss=3Don employs in-qemu RSS, which incurs <br=
>
overheads for such configurations.<br></blockquote><div><br></div><div>So, =
vhost=3Doff OR peers other than tap:</div><div><br></div><div>In the case o=
f peers other than tap (IMO) we&#39;re not talking about performance at all=
.</div><div>Backends like &quot;user&quot; (without vnet_hdr) do not suppor=
t _many_ performance-oriented features.</div><div>If RSS is somehow &quot;s=
upported&quot; for such backends this is rather a misunderstanding (IMO aga=
in).</div><div><br></div><div>In the case of tap with vhost=3Doff the RSS s=
upport does not create any performance degradation without eBPF.<br></div><=
div><br></div></div></div>

--000000000000de066806093f4914--

