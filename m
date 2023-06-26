Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D5673DE4E
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:57:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkpl-0003i4-Lt; Mon, 26 Jun 2023 07:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qDkpj-0003gR-G1
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:56:39 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qDkph-0003BI-KJ
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:56:39 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4fb7589b187so1140028e87.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687780596; x=1690372596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VCanx4GpY30HugkKNP6HvRmWKazD93CZwlnSUTnme9U=;
 b=EIgnr2PwqcDsWiRHA1r/dUwSJz1WWPwLvJELcjAOMae0GLVOQXXflWXe2nUqp4mNrx
 MSFZm1UN4oU7XmNsmxa3zdPXN6jz7bVhQlHApUWZcurwbiy6Dnt0Cpl+u95JOMcQy4iR
 bDpluuIxIWeviW0+vGhJs5F5wc0PtytPVRzaWuqJoP501kn3sm0/kTDky6BSUtUZO21Z
 lLTdVbjWu/KmXolFYNgkIQaKsSNscKLxMyfbweIpjwwJFq/vBfCzgSg4fct+9r7tOPoj
 A4x+7CByiObYesna5+dP4LbrQeR9AFFwE8ar3K5x0xQqYj779MDMNZiPKxswO0cExYes
 ogow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687780596; x=1690372596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VCanx4GpY30HugkKNP6HvRmWKazD93CZwlnSUTnme9U=;
 b=G5NVnYynXeMi1l1pUS58Pt1GddS3PYy2s3cAHXwjtZ/sjr2L0wemSvRYGeJ/ESZgJf
 3aUtaq6DfPTxrYl6ua2kLqnWzOn3OV8bkaq7vTsCu+6W1Z4/YO6tQNRJKPR/gUBteeT/
 TER2yoqv8ZeRJiBkUyQFO7Lv24z7GbGn+wMNUSq91JaJTiNC3og/RER4qYu3DW1A6OST
 ZToFd7LKN1zZ4O08jILjRZi7YH3Gk1k7AYcTeFp+vAnLuCBjXAjSQS7YHjAg0crelGL9
 ePUZhE1bzVPD1Wui42Vbz9dpdpjgurEmKVVZCVgTl7zhwGpwi0qeCRqQuXj5Uvng6+Pr
 2PAQ==
X-Gm-Message-State: AC+VfDz7E52vGYAaWBEfhbPOdiIISq3p+0KAtV3PaxcV1C7upJWroPGe
 yoDCvkWDfkgAj1o5geQHg8ruP6leRRjYwyI3490=
X-Google-Smtp-Source: ACHHUZ6dAzJAEQO7V4v/I8oqBy3hkBpG1LC5Jp/Ufo0AL0ERttVUXHetnsShb+q30ECbTKl62R6/zJWbm9jY9kq0RVQ=
X-Received: by 2002:a05:6512:b0e:b0:4f8:75cf:fdd7 with SMTP id
 w14-20020a0565120b0e00b004f875cffdd7mr12354418lfu.22.1687780595545; Mon, 26
 Jun 2023 04:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230621213150.29573-1-dongwon.kim@intel.com>
In-Reply-To: <20230621213150.29573-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 26 Jun 2023 13:56:24 +0200
Message-ID: <CAJ+F1CJ2cVDAOTY-j77QGj5W1d4wrphcQ2oEUqkw0R4hBX3q0w@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: set the area of the scanout texture correctly
To: Dongwon Kim <dongwon.kim@intel.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Content-Type: multipart/alternative; boundary="000000000000db3c7305ff070a57"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-lf1-x12c.google.com
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

--000000000000db3c7305ff070a57
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jun 21, 2023 at 11:53=E2=80=AFPM Dongwon Kim <dongwon.kim@intel.com=
> wrote:

> x and y offsets and width and height of the scanout texture
> is not correctly configured in case guest scanout frame is
> dmabuf.
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
>

I find this a bit confusing, and I don't know how to actually test it.

The only place where scanout_{width, height} are set is
virtio_gpu_create_dmabuf() and there, they have the same values as width
and height. it's too easy to get confused with the values imho.

I find the terminology we use for ScanoutTexture much clearer. It uses
backing_{width, height} instead, which indicates quite clearly that the
usual x/y/w/h are for the sub-region to be shown.

I think we should have a preliminary commit that renames scanout_{width,
height}.

Please give some help/hints on how to actually test this code too.

Thanks!


---
>  ui/gtk-egl.c     | 3 ++-
>  ui/gtk-gl-area.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index 19130041bc..e99e3b0d8c 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -257,7 +257,8 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl=
,
>
>      gd_egl_scanout_texture(dcl, dmabuf->texture,
>                             dmabuf->y0_top, dmabuf->width, dmabuf->height=
,
> -                           0, 0, dmabuf->width, dmabuf->height);
> +                           dmabuf->x, dmabuf->y, dmabuf->scanout_width,
> +                           dmabuf->scanout_height);
>
>      if (dmabuf->allow_fences) {
>          vc->gfx.guest_fb.dmabuf =3D dmabuf;
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index c384a1516b..1605818bd1 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -299,7 +299,8 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener
> *dcl,
>
>      gd_gl_area_scanout_texture(dcl, dmabuf->texture,
>                                 dmabuf->y0_top, dmabuf->width,
> dmabuf->height,
> -                               0, 0, dmabuf->width, dmabuf->height);
> +                               dmabuf->x, dmabuf->y,
> dmabuf->scanout_width,
> +                               dmabuf->scanout_height);
>
>      if (dmabuf->allow_fences) {
>          vc->gfx.guest_fb.dmabuf =3D dmabuf;
> --
> 2.34.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000db3c7305ff070a57
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 21, 2023 at 11:53=E2=80=
=AFPM Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com">dongwon.kim@=
intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">x and y offsets and width and height of the scanout texture<br>
is not correctly configured in case guest scanout frame is<br>
dmabuf.<br>
<br>
Cc: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank=
">kraxel@redhat.com</a>&gt;<br>
Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.co=
m" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Cc: Vivek Kasireddy &lt;<a href=3D"mailto:vivek.kasireddy@intel.com" target=
=3D"_blank">vivek.kasireddy@intel.com</a>&gt;<br>
Signed-off-by: Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com" tar=
get=3D"_blank">dongwon.kim@intel.com</a>&gt;<br></blockquote><div><br></div=
><div>I find this a bit confusing, and I don&#39;t know how to actually tes=
t it.</div><div><br></div><div>The only place where scanout_{width, height}=
 are set is virtio_gpu_create_dmabuf() and there, they have the same values=
 as width and height. it&#39;s too easy to get confused with the values imh=
o.</div><div><br></div><div>I find the terminology we use for ScanoutTextur=
e much clearer. It uses backing_{width, height} instead, which indicates qu=
ite clearly that the usual x/y/w/h are for the sub-region to be shown.<br><=
/div><div><br></div><div>I think we should have a preliminary commit that r=
enames scanout_{width, height}.</div><div><br></div><div>Please give some h=
elp/hints on how to actually test this code too.<br></div><div><br></div><d=
iv>Thanks!<br></div><div><br></div><div><br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
---<br>
=C2=A0ui/gtk-egl.c=C2=A0 =C2=A0 =C2=A0| 3 ++-<br>
=C2=A0ui/gtk-gl-area.c | 3 ++-<br>
=C2=A02 files changed, 4 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c<br>
index 19130041bc..e99e3b0d8c 100644<br>
--- a/ui/gtk-egl.c<br>
+++ b/ui/gtk-egl.c<br>
@@ -257,7 +257,8 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0gd_egl_scanout_texture(dcl, dmabuf-&gt;texture,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 dmabuf-&gt;y0_top, dmabuf-&gt;width, dmabuf-&gt;he=
ight,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00, 0, dmabuf-&gt;width, dmabuf-&gt;height);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0dmabuf-&gt;x, dmabuf-&gt;y, dmabuf-&gt;scanout_widt=
h,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0dmabuf-&gt;scanout_height);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (dmabuf-&gt;allow_fences) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vc-&gt;gfx.guest_fb.dmabuf =3D dmabuf;<br=
>
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c<br>
index c384a1516b..1605818bd1 100644<br>
--- a/ui/gtk-gl-area.c<br>
+++ b/ui/gtk-gl-area.c<br>
@@ -299,7 +299,8 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener *d=
cl,<br>
<br>
=C2=A0 =C2=A0 =C2=A0gd_gl_area_scanout_texture(dcl, dmabuf-&gt;texture,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dmabuf-&gt;y0_top, dmabuf-&gt;width,=
 dmabuf-&gt;height,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00, 0, dmabuf-&gt;width, dmabuf-&gt;he=
ight);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dmabuf-&gt;x, dmabuf-&gt;y, dmabuf-&g=
t;scanout_width,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dmabuf-&gt;scanout_height);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (dmabuf-&gt;allow_fences) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vc-&gt;gfx.guest_fb.dmabuf =3D dmabuf;<br=
>
-- <br>
2.34.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000db3c7305ff070a57--

