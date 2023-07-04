Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9387574761B
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 18:09:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGiYn-0001Sa-Bo; Tue, 04 Jul 2023 12:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qGiYg-0001S4-Ua
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:07:18 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qGiYf-00032Q-1A
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:07:18 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-403429b33f5so24444921cf.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 09:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688486836; x=1691078836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I2VC/g4RypunwtFsnbH2WEQv8dS52kkRdck1Dlp+RWw=;
 b=IaNMWc7D4VCI1dMF05eXzuoe8ECDBUh+3Xghq1tkhuxrh44Cs6XXWsX6qV3m7wIRYu
 OHObiOK6jdImMYfURArx7rbh61RMhVlNJhhIkgBDPebUNY/dntlCpyVp7MteD93lO0n4
 hNv6Wq0RSdv7ULtrtGJZ7AOHQ/wX02a4uKrNFyTrlP8ODTIj9Kf1L8Tg6gyC/Xnfvl1Y
 KtZiEwGr2fkUQQFTKuOJfzTIkyNQ1DkF2d4rYW6QR5qo56bX8Hvc4QgwCEnSpkP3PSmO
 pnUev19fmydfs8P2vc1aYzuBfiYfwhQ7WTepEDvMzIfxetWYxwrySsOid58akpMK07rm
 NhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688486836; x=1691078836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I2VC/g4RypunwtFsnbH2WEQv8dS52kkRdck1Dlp+RWw=;
 b=KpbNAFzBynoKhP9ISignex6xLLBKJnTHKL+OnoE8zrqlhsB6ie/sfMqXFuTf3q/Weu
 thaUx9ntvEzrLx0JLvsKN8oTslGlDqUKSm5zXhkJ/J86PQGUUC1nzP8ssICu7jYO2aMh
 4mZ76ynWDObNw4kPW9FTibr8hlYitzgUO18VQR6pFKMaYhqIz+T9xMf0Ipttk10O+Nbj
 eUuuuzMCe+zrBiQgreCt6xaesVvcMlStzUmq8cNcHlMprgeroHFSrwYfI+77G9288mOW
 6SqKGodliotW/8CXWgYDBRZhVkaHSwQ4wbHpf4JBVJxhw9rm4V3QuORGqiaWro1jgPbS
 3Now==
X-Gm-Message-State: AC+VfDy0e/h9jmLFQw2KNrw9M6QoS2WTheVXrGjxcEpHSfVSYSi55GI5
 j2dOCCBa3n0cwbMcoJFtcfV5KuZuIC9oJI9m/WdKXTl5KtCf2w==
X-Google-Smtp-Source: ACHHUZ6arm0XTVDIdxQ4Av94kKZT8KGinPWGn2bfC0FYjKV7AH1mfLm3B59NWidXq+akGMdztAYj5vvDvzs1kX6aR1Y=
X-Received: by 2002:ac8:5b03:0:b0:3ff:33fb:50d5 with SMTP id
 m3-20020ac85b03000000b003ff33fb50d5mr13710576qtw.12.1688486835822; Tue, 04
 Jul 2023 09:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230621213150.29573-1-dongwon.kim@intel.com>
 <CAJ+F1CJ2cVDAOTY-j77QGj5W1d4wrphcQ2oEUqkw0R4hBX3q0w@mail.gmail.com>
 <6556daf6-a3a3-132d-df2c-2914c6bb2e47@intel.com>
In-Reply-To: <6556daf6-a3a3-132d-df2c-2914c6bb2e47@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 4 Jul 2023 18:07:05 +0200
Message-ID: <CAJ+F1CJOPqXE-uuDOG7Ftz2-ju94hy49XqW9AszEiUtBKoCrRg@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: set the area of the scanout texture correctly
To: "Kim, Dongwon" <dongwon.kim@intel.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Content-Type: multipart/alternative; boundary="0000000000000ea55505ffab7aa0"
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x835.google.com
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

--0000000000000ea55505ffab7aa0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Jun 26, 2023 at 9:49=E2=80=AFPM Kim, Dongwon <dongwon.kim@intel.com=
> wrote:

> Hi Marc-Andr=C3=A9 Lureau,
>
> On 6/26/2023 4:56 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Wed, Jun 21, 2023 at 11:53=E2=80=AFPM Dongwon Kim <dongwon.kim@intel=
.com>
> > wrote:
> >
> >     x and y offsets and width and height of the scanout texture
> >     is not correctly configured in case guest scanout frame is
> >     dmabuf.
> >
> >     Cc: Gerd Hoffmann <kraxel@redhat.com>
> >     Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >     Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >     Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> >
> >
> > I find this a bit confusing, and I don't know how to actually test it.
> >
> > The only place where scanout_{width, height} are set is
> > virtio_gpu_create_dmabuf() and there, they have the same values as
> > width and height. it's too easy to get confused with the values imho.
>
> Yes, scanout_width/height are same as width/height as far as there is
> only one guest display exist. But they will be different in case there
> multiple displays on the guest side, configured in extended mode (when
> the guest is running Xorg).
>
> In this case, blob for the guest display is same for scanout 1 and 2 but
> each scanout will have different offset and scanout_width/scanout_height
> to reference a sub region in the same blob(dmabuf).
>
> I added x/y/scanout_width/scanout_height with a previous commit:
>
> commit e86a93f55463c088aa0b5260e915ffbf9f86c62b
> Author: Dongwon Kim <dongwon.kim@intel.com>
> Date:   Wed Nov 3 23:51:52 2021 -0700
>
>      virtio-gpu: splitting one extended mode guest fb into n-scanouts
>
> > I find the terminology we use for ScanoutTexture much clearer. It uses
> > backing_{width, height} instead, which indicates quite clearly that
> > the usual x/y/w/h are for the sub-region to be shown.
> yeah agreed. Then dmabuf->width/height should be changed to
> dmabuf->backing_width/height and dmabuf->width/height will be replacing
> dmabuf->scanout_width/scanout_height. I guess this is what you meant,
> right?
>

right, can you send a new patch?
thanks


> > I think we should have a preliminary commit that renames
> > scanout_{width, height}.
> >
> > Please give some help/hints on how to actually test this code too.
>
> So this patch is just to make things look consistent in the code level.
> Having offset (0,0) in this function call for all different scanouts
> didn't look right to me. This code change won't make anything done
> differently though. So no test is applicable.
>
> >
> > Thanks!
> >
> >
> >     ---
> >      ui/gtk-egl.c     | 3 ++-
> >      ui/gtk-gl-area.c | 3 ++-
> >      2 files changed, 4 insertions(+), 2 deletions(-)
> >
> >     diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> >     index 19130041bc..e99e3b0d8c 100644
> >     --- a/ui/gtk-egl.c
> >     +++ b/ui/gtk-egl.c
> >     @@ -257,7 +257,8 @@ void
> >     gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
> >
> >          gd_egl_scanout_texture(dcl, dmabuf->texture,
> >                                 dmabuf->y0_top, dmabuf->width,
> >     dmabuf->height,
> >     -                           0, 0, dmabuf->width, dmabuf->height);
> >     +                           dmabuf->x, dmabuf->y,
> >     dmabuf->scanout_width,
> >     +                           dmabuf->scanout_height);
> >
> >          if (dmabuf->allow_fences) {
> >              vc->gfx.guest_fb.dmabuf =3D dmabuf;
> >     diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> >     index c384a1516b..1605818bd1 100644
> >     --- a/ui/gtk-gl-area.c
> >     +++ b/ui/gtk-gl-area.c
> >     @@ -299,7 +299,8 @@ void
> >     gd_gl_area_scanout_dmabuf(DisplayChangeListener *dcl,
> >
> >          gd_gl_area_scanout_texture(dcl, dmabuf->texture,
> >                                     dmabuf->y0_top, dmabuf->width,
> >     dmabuf->height,
> >     -                               0, 0, dmabuf->width, dmabuf->height=
);
> >     +                               dmabuf->x, dmabuf->y,
> >     dmabuf->scanout_width,
> >     +                               dmabuf->scanout_height);
> >
> >          if (dmabuf->allow_fences) {
> >              vc->gfx.guest_fb.dmabuf =3D dmabuf;
> >     --
> >     2.34.1
> >
> >
> >
> >
> > --
> > Marc-Andr=C3=A9 Lureau
>


--=20
Marc-Andr=C3=A9 Lureau

--0000000000000ea55505ffab7aa0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 26, 2023 at 9:49=E2=80=
=AFPM Kim, Dongwon &lt;<a href=3D"mailto:dongwon.kim@intel.com">dongwon.kim=
@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hi Marc-Andr=C3=A9 Lureau,<br>
<br>
On 6/26/2023 4:56 AM, Marc-Andr=C3=A9 Lureau wrote:<br>
&gt; Hi<br>
&gt;<br>
&gt; On Wed, Jun 21, 2023 at 11:53=E2=80=AFPM Dongwon Kim &lt;<a href=3D"ma=
ilto:dongwon.kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</a>&gt;=
 <br>
&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0x and y offsets and width and height of the scanout=
 texture<br>
&gt;=C2=A0 =C2=A0 =C2=A0is not correctly configured in case guest scanout f=
rame is<br>
&gt;=C2=A0 =C2=A0 =C2=A0dmabuf.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Cc: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redh=
at.com" target=3D"_blank">kraxel@redhat.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:ma=
rcandre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a=
>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Cc: Vivek Kasireddy &lt;<a href=3D"mailto:vivek.kas=
ireddy@intel.com" target=3D"_blank">vivek.kasireddy@intel.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Dongwon Kim &lt;<a href=3D"mailto:do=
ngwon.kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</a>&gt;<br>
&gt;<br>
&gt;<br>
&gt; I find this a bit confusing, and I don&#39;t know how to actually test=
 it.<br>
&gt;<br>
&gt; The only place where scanout_{width, height} are set is <br>
&gt; virtio_gpu_create_dmabuf() and there, they have the same values as <br=
>
&gt; width and height. it&#39;s too easy to get confused with the values im=
ho.<br>
<br>
Yes, scanout_width/height are same as width/height as far as there is <br>
only one guest display exist. But they will be different in case there <br>
multiple displays on the guest side, configured in extended mode (when <br>
the guest is running Xorg).<br>
<br>
In this case, blob for the guest display is same for scanout 1 and 2 but <b=
r>
each scanout will have different offset and scanout_width/scanout_height <b=
r>
to reference a sub region in the same blob(dmabuf).<br>
<br>
I added x/y/scanout_width/scanout_height with a previous commit:<br>
<br>
commit e86a93f55463c088aa0b5260e915ffbf9f86c62b<br>
Author: Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com" target=3D"=
_blank">dongwon.kim@intel.com</a>&gt;<br>
Date:=C2=A0=C2=A0 Wed Nov 3 23:51:52 2021 -0700<br>
<br>
=C2=A0=C2=A0=C2=A0=C2=A0 virtio-gpu: splitting one extended mode guest fb i=
nto n-scanouts<br>
<br>
&gt; I find the terminology we use for ScanoutTexture much clearer. It uses=
 <br>
&gt; backing_{width, height} instead, which indicates quite clearly that <b=
r>
&gt; the usual x/y/w/h are for the sub-region to be shown.<br>
yeah agreed. Then dmabuf-&gt;width/height should be changed to <br>
dmabuf-&gt;backing_width/height and dmabuf-&gt;width/height will be replaci=
ng <br>
dmabuf-&gt;scanout_width/scanout_height. I guess this is what you meant, ri=
ght?<br></blockquote><div><br></div><div>right, can you send a new patch?</=
div><div>thanks</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
&gt; I think we should have a preliminary commit that renames <br>
&gt; scanout_{width, height}.<br>
&gt;<br>
&gt; Please give some help/hints on how to actually test this code too.<br>
<br>
So this patch is just to make things look consistent in the code level. <br=
>
Having offset (0,0) in this function call for all different scanouts <br>
didn&#39;t look right to me. This code change won&#39;t make anything done =
<br>
differently though. So no test is applicable.<br>
<br>
&gt;<br>
&gt; Thanks!<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0ui/gtk-egl.c=C2=A0 =C2=A0 =C2=A0| 3 ++-<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0ui/gtk-gl-area.c | 3 ++-<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A02 files changed, 4 insertions(+), 2 deletions=
(-)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0index 19130041bc..e99e3b0d8c 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/ui/gtk-egl.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/ui/gtk-egl.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -257,7 +257,8 @@ void<br>
&gt;=C2=A0 =C2=A0 =C2=A0gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,<b=
r>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0gd_egl_scanout_texture(dcl, dma=
buf-&gt;texture,<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dmabuf-&gt;y0_top, dmabuf-=
&gt;width,<br>
&gt;=C2=A0 =C2=A0 =C2=A0dmabuf-&gt;height,<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00, 0, dmabuf-&gt;width, dma=
buf-&gt;height);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dmabuf-&gt;x, dmabuf-&gt;y,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0dmabuf-&gt;scanout_width,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dmabuf-&gt;scanout_height);=
<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0if (dmabuf-&gt;allow_fences) {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vc-&gt;gfx.guest_=
fb.dmabuf =3D dmabuf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0index c384a1516b..1605818bd1 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/ui/gtk-gl-area.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/ui/gtk-gl-area.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -299,7 +299,8 @@ void<br>
&gt;=C2=A0 =C2=A0 =C2=A0gd_gl_area_scanout_dmabuf(DisplayChangeListener *dc=
l,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0gd_gl_area_scanout_texture(dcl,=
 dmabuf-&gt;texture,<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dmabuf-&gt;y=
0_top, dmabuf-&gt;width,<br>
&gt;=C2=A0 =C2=A0 =C2=A0dmabuf-&gt;height,<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00, 0, dmabuf-=
&gt;width, dmabuf-&gt;height);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dmabuf-&gt;x,=
 dmabuf-&gt;y,<br>
&gt;=C2=A0 =C2=A0 =C2=A0dmabuf-&gt;scanout_width,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dmabuf-&gt;sc=
anout_height);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0if (dmabuf-&gt;allow_fences) {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vc-&gt;gfx.guest_=
fb.dmabuf =3D dmabuf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A02.34.1<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; -- <br>
&gt; Marc-Andr=C3=A9 Lureau<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--0000000000000ea55505ffab7aa0--

