Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7992370F495
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 12:51:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1m58-0005az-7J; Wed, 24 May 2023 06:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q1m55-0005aT-Uz
 for qemu-devel@nongnu.org; Wed, 24 May 2023 06:51:00 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q1m54-0005zK-9a
 for qemu-devel@nongnu.org; Wed, 24 May 2023 06:50:59 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2af2696fd1cso10475101fa.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 03:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684925456; x=1687517456;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IL6Ttl+nbXCgstUFPXpwdGdyy9LC5mjm5oGa50AqgtY=;
 b=muTbtFx5pY/ASe+54SW26aUaBp0ddrho4z9sZ/mxCRjUKrAnd/1wudyudaZIiCLfjJ
 4VL5i6pJzRUrWpbhgAaEsKZq9jCAN2kmz+LMImYSnLVeYuaYgggy0yQI9zaZvmwzowTE
 Dapg27FJKdTawVxJ520v8fKcb6mO2/169h6UlSSaudL+dQPGQp+sCsRQ1ypsDGhSOA5U
 HIjcKTJ7nfhoJKEw5LlrUBTwGO9tz24g4kDATqbpeAL2cKdKzkiIMUBppDYu85zCcKrT
 9dXJLgz+kVRq6i+LiN/87lV+vSxg5LlExYys8xecXWEIX6GL3GAQuol1nHGDxlTNHJXs
 8QUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684925456; x=1687517456;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IL6Ttl+nbXCgstUFPXpwdGdyy9LC5mjm5oGa50AqgtY=;
 b=P7AQV3rWRJFZ7KXW3ikG5/Sx0ZdNJN8hsN3Qw428NhKLScnE+JLPCnf17FvnOOAu0j
 EcRlcYzc/T8Qt69pIGFyfDIqyv5qond0lWfRpOHmcFBQM5t7d819tfa3T9QIF4XRfvCt
 FINlJvFiUZezfFwMv3PkGrOW8m+w9uylVQFo4jx4O/Bgs4Hln2P406NSMMpkpvIziACp
 Cf6zaD8OK9l3hRHdVC/ogrQ/LLNNaLz0/8O1TUQHnw44gMp+A36GGaqBYvWcpm+8wy81
 OrMhnRYOBjj/hQKHsKijPf0FF13us35pCBpEpIflnhXwPcwAv1DdC/2FRS43YTYpZfKS
 clwA==
X-Gm-Message-State: AC+VfDxT3TyuYIe7sPHmT2ltgURXb1Z4s2XPVWaAa78SmMyrZEP8sFpR
 HLTd0B7e5fXFYFuMBHtVK3C+aJtTdsVNXYBhZJw=
X-Google-Smtp-Source: ACHHUZ65ghK46iI0X3f4L9PiIPdItwW4Wo/b4ILwRu7+7iJIj3Yr1ssQnR3JJDnwIYU7CxgeyFBSKnZz0vxX1CNnS4g=
X-Received: by 2002:a2e:8845:0:b0:2ac:840c:4cb2 with SMTP id
 z5-20020a2e8845000000b002ac840c4cb2mr6245470ljj.25.1684925455397; Wed, 24 May
 2023 03:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230515132518.1025853-1-marcandre.lureau@redhat.com>
 <20230518173438-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230518173438-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 24 May 2023 14:50:44 +0400
Message-ID: <CAJ+F1CLnw5e1qsf2TC96F1dmXzk+gmja1mUeQeOZCEpob9upYg@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu: add a FIXME for virtio_gpu_load()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Content-Type: multipart/alternative; boundary="0000000000003df6eb05fc6e472a"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000003df6eb05fc6e472a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael

On Fri, May 19, 2023 at 1:35=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:

> On Mon, May 15, 2023 at 05:25:18PM +0400, marcandre.lureau@redhat.com
> wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > It looks like the virtio_gpu_load() does not compute and set the offset=
,
> > the same way virtio_gpu_set_scanout() does. This probably results in
> > incorrect display until the scanout/framebuffer is updated again, I
> > guess we should fix it, although I haven't checked this yet.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> I guess it's a way to ping Gerd ;)
> Better to just fix it though, no?
>

Indeed, it's just lack of time and priority, and also figure out a good way
to test this.

thanks


> > ---
> >  hw/display/virtio-gpu.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index 66ac9b6cc5..66cddd94d9 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -1289,6 +1289,7 @@ static int virtio_gpu_load(QEMUFile *f, void
> *opaque, size_t size,
> >      /* load & apply scanout state */
> >      vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1);
> >      for (i =3D 0; i < g->parent_obj.conf.max_outputs; i++) {
> > +        /* FIXME: should take scanout.r.{x,y} into account */
> >          scanout =3D &g->parent_obj.scanout[i];
> >          if (!scanout->resource_id) {
> >              continue;
> > --
> > 2.40.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000003df6eb05fc6e472a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Michael<br></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 19, 2023 at 1:3=
5=E2=80=AFAM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@r=
edhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Mon, May 15, 2023 at 05:25:18PM +0400, <a href=3D"mailto:marc=
andre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a> =
wrote:<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt; <br>
&gt; It looks like the virtio_gpu_load() does not compute and set the offse=
t,<br>
&gt; the same way virtio_gpu_set_scanout() does. This probably results in<b=
r>
&gt; incorrect display until the scanout/framebuffer is updated again, I<br=
>
&gt; guess we should fix it, although I haven&#39;t checked this yet.<br>
&gt; <br>
&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br=
>
<br>
I guess it&#39;s a way to ping Gerd ;)<br>
Better to just fix it though, no?<br></blockquote><div><br></div><div>Indee=
d, it&#39;s just lack of time and priority, and also figure out a good way =
to test this.</div><div>=C2=A0</div><div>thanks</div><div><br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; ---<br>
&gt;=C2=A0 hw/display/virtio-gpu.c | 1 +<br>
&gt;=C2=A0 1 file changed, 1 insertion(+)<br>
&gt; <br>
&gt; diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c<br>
&gt; index 66ac9b6cc5..66cddd94d9 100644<br>
&gt; --- a/hw/display/virtio-gpu.c<br>
&gt; +++ b/hw/display/virtio-gpu.c<br>
&gt; @@ -1289,6 +1289,7 @@ static int virtio_gpu_load(QEMUFile *f, void *op=
aque, size_t size,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* load &amp; apply scanout state */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 vmstate_load_state(f, &amp;vmstate_virtio_gpu_scan=
outs, g, 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; g-&gt;parent_obj.conf.max_out=
puts; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* FIXME: should take scanout.r.{x,y} int=
o account */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 scanout =3D &amp;g-&gt;parent_obj.sc=
anout[i];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!scanout-&gt;resource_id) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; -- <br>
&gt; 2.40.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--0000000000003df6eb05fc6e472a--

