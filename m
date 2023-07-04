Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 198B67475B7
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 17:55:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGiMq-0000cF-5t; Tue, 04 Jul 2023 11:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qGiMo-0000c7-Es
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:55:02 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qGiMm-0008QR-3b
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:55:02 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-403715da067so5463401cf.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 08:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688486099; x=1691078099;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KHwk0s6TIC76zmRwWnh0ysFU3JVElP0IWa/HvwaSLXE=;
 b=POPDKCalhcc6VDEMdJsdYA3rfO94Rpkh+EvAzPVLfYVZNmWKSBgVi4dYOWtbn9kbvl
 dgGQ9xQQptuWiJ53d9FdeZWHr06ag+NPANII/ReBste9J3WSJ2nTKv1WJW/ESBLU9yvR
 9jFPvK8Qki5ifNcWkM2K8TZNFsui96A74LvvnK/o+cxbocnFrrPbUkhiTHx9X5rgvsLJ
 ShODiR4ykfZ3X5SmHp+D1kUiHyW7+abQwDpKSavM8BD05CTC2st4E0VNyKB2E5LJM+1V
 asFocEfbn/Tz4OA+y2XIjJLheSWffIDKNopk+iIacwhqY0GpEh9Qa8qRAWV0CYU16NTM
 Wr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688486099; x=1691078099;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KHwk0s6TIC76zmRwWnh0ysFU3JVElP0IWa/HvwaSLXE=;
 b=XX03GKXUjSalHTO2ogjYkObK4EDWCIzq69wJeBFliMm4DRWIrp4jzr9iWn0dtjRefL
 cpglDkLv7z97gzFgJZ2soP4eTD/m9YWaAFHjhdOCcnhLcMOWolAXxYdaIHQENwwbXQGK
 vxZueHwSjzlbXQAnMNNM9gsdZdv7VPMd3D41xyF5KLMZI4SMVNc3KN90GZBJUhobrnCm
 wmmI2C06xOWEJSgIa0CaOi5PEQNbUdU5+WXn5bDwlMOZLt0UcmheBDHucQBiibXz51IB
 czH8BtUBmZh9XTaHYOeFN7jVQTuj9ac2MDKY2LMhFakIveBfLXqoZ3uHdQv0aJ/HSdva
 b0Vw==
X-Gm-Message-State: AC+VfDxkpxTtwnfmCH97BZiXThO34nu/l1R4RTwhyM4H4U+Hzs2gGn9z
 lMBf7W67+QtUltKyAM895m8+PMd9ijHBiE4/QFc=
X-Google-Smtp-Source: ACHHUZ76FpMkaThXcyQBDrNd1E9Zb2alstwr7B9enZSQHxHFDnEdVO3hM/XroBUw+JYgWw3GBMEcLv5+8LA8jyZohdY=
X-Received: by 2002:ac8:5a8b:0:b0:400:aabe:a334 with SMTP id
 c11-20020ac85a8b000000b00400aabea334mr19749100qtc.7.1688486099034; Tue, 04
 Jul 2023 08:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230628185108.16697-1-dongwon.kim@intel.com>
In-Reply-To: <20230628185108.16697-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 4 Jul 2023 17:54:47 +0200
Message-ID: <CAJ+F1C+9hbdgv7tLibnYKS-3fOBotVU=MHwYq6Ly2Wccf-Dd_g@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: skip refresh if new dmabuf is submitted
To: Dongwon Kim <dongwon.kim@intel.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Vivek Kasireddy <vivek.kasireddy@intel.com>
Content-Type: multipart/alternative; boundary="00000000000024266405ffab4eae"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82c.google.com
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

--00000000000024266405ffab4eae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jun 28, 2023 at 9:12=E2=80=AFPM Dongwon Kim <dongwon.kim@intel.com>=
 wrote:

> Skip refresh if a new dmabuf (guest scanout frame) is submitted
> and ready to be drawn because the scanout will be refreshed with
> new frame anyway.
>
> Also, setting scanout mode is better to be done right before
> a draw event is scheduled because the mode can be reset anytime
> after it is set in dpy_gl_scanout_texture by any asynchronouse
> dpy_refresh call, which eventually cancels the drawing of the
> guest scanout texture.
>

This is actually quite difficult to analyze. Can you be more explicit? Can
you split the patch and add comments, because the state conditions &
behavours aren't obvious.

Gerd, any chance you look at it too?


> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  ui/gtk-egl.c     | 6 +++++-
>  ui/gtk-gl-area.c | 6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index 19130041bc..62ff6812b6 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -143,6 +143,10 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
>      gd_update_monitor_refresh_rate(
>              vc, vc->window ? vc->window : vc->gfx.drawing_area);
>
> +    if (vc->gfx.guest_fb.dmabuf &&
> vc->gfx.guest_fb.dmabuf->draw_submitted) {
> +        return;
> +    }
> +
>      if (!vc->gfx.esurface) {
>          gd_egl_init(vc);
>          if (!vc->gfx.esurface) {
> @@ -236,7 +240,6 @@ void gd_egl_scanout_texture(DisplayChangeListener *dc=
l,
>      eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
>                     vc->gfx.esurface, vc->gfx.ectx);
>
> -    gtk_egl_set_scanout_mode(vc, true);
>      egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_heigh=
t,
>                           backing_id, false);
>  }
> @@ -344,6 +347,7 @@ void gd_egl_flush(DisplayChangeListener *dcl,
>      if (vc->gfx.guest_fb.dmabuf &&
> !vc->gfx.guest_fb.dmabuf->draw_submitted) {
>          graphic_hw_gl_block(vc->gfx.dcl.con, true);
>          vc->gfx.guest_fb.dmabuf->draw_submitted =3D true;
> +        gtk_egl_set_scanout_mode(vc, true);
>          gtk_widget_queue_draw_area(area, x, y, w, h);
>          return;
>      }
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index c384a1516b..68eff3435b 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -123,6 +123,10 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
>
>      gd_update_monitor_refresh_rate(vc, vc->window ? vc->window :
> vc->gfx.drawing_area);
>
> +    if (vc->gfx.guest_fb.dmabuf &&
> vc->gfx.guest_fb.dmabuf->draw_submitted) {
> +        return;
> +    }
> +
>      if (!vc->gfx.gls) {
>          if (!gtk_widget_get_realized(vc->gfx.drawing_area)) {
>              return;
> @@ -261,7 +265,6 @@ void gd_gl_area_scanout_texture(DisplayChangeListener
> *dcl,
>          return;
>      }
>
> -    gtk_gl_area_set_scanout_mode(vc, true);
>      egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_heigh=
t,
>                           backing_id, false);
>  }
> @@ -281,6 +284,7 @@ void gd_gl_area_scanout_flush(DisplayChangeListener
> *dcl,
>      if (vc->gfx.guest_fb.dmabuf &&
> !vc->gfx.guest_fb.dmabuf->draw_submitted) {
>          graphic_hw_gl_block(vc->gfx.dcl.con, true);
>          vc->gfx.guest_fb.dmabuf->draw_submitted =3D true;
> +        gtk_gl_area_set_scanout_mode(vc, true);
>      }
>      gtk_gl_area_queue_render(GTK_GL_AREA(vc->gfx.drawing_area));
>  }
> --
> 2.34.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000024266405ffab4eae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 28, 2023 at 9:12=E2=80=
=AFPM Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com">dongwon.kim@=
intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Skip refresh if a new dmabuf (guest scanout frame) is submitted<=
br>
and ready to be drawn because the scanout will be refreshed with<br>
new frame anyway.<br>
<br>
Also, setting scanout mode is better to be done right before<br>
a draw event is scheduled because the mode can be reset anytime<br>
after it is set in dpy_gl_scanout_texture by any asynchronouse<br>
dpy_refresh call, which eventually cancels the drawing of the<br>
guest scanout texture.<br></blockquote><div><br></div><div>This is actually=
 quite difficult to analyze. Can you be more explicit? Can you split the pa=
tch and add comments, because the state conditions &amp; behavours aren&#39=
;t obvious.<br></div><div>=C2=A0</div><div>Gerd, any chance you look at it =
too?</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Cc: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank=
">kraxel@redhat.com</a>&gt;<br>
Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.co=
m" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Cc: Vivek Kasireddy &lt;<a href=3D"mailto:vivek.kasireddy@intel.com" target=
=3D"_blank">vivek.kasireddy@intel.com</a>&gt;<br>
Signed-off-by: Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com" tar=
get=3D"_blank">dongwon.kim@intel.com</a>&gt;<br>
---<br>
=C2=A0ui/gtk-egl.c=C2=A0 =C2=A0 =C2=A0| 6 +++++-<br>
=C2=A0ui/gtk-gl-area.c | 6 +++++-<br>
=C2=A02 files changed, 10 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c<br>
index 19130041bc..62ff6812b6 100644<br>
--- a/ui/gtk-egl.c<br>
+++ b/ui/gtk-egl.c<br>
@@ -143,6 +143,10 @@ void gd_egl_refresh(DisplayChangeListener *dcl)<br>
=C2=A0 =C2=A0 =C2=A0gd_update_monitor_refresh_rate(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vc, vc-&gt;window ? vc-&gt;=
window : vc-&gt;gfx.drawing_area);<br>
<br>
+=C2=A0 =C2=A0 if (vc-&gt;gfx.guest_fb.dmabuf &amp;&amp; vc-&gt;gfx.guest_f=
b.dmabuf-&gt;draw_submitted) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (!vc-&gt;gfx.esurface) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gd_egl_init(vc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!vc-&gt;gfx.esurface) {<br>
@@ -236,7 +240,6 @@ void gd_egl_scanout_texture(DisplayChangeListener *dcl,=
<br>
=C2=A0 =C2=A0 =C2=A0eglMakeCurrent(qemu_egl_display, vc-&gt;gfx.esurface,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vc-&g=
t;gfx.esurface, vc-&gt;gfx.ectx);<br>
<br>
-=C2=A0 =C2=A0 gtk_egl_set_scanout_mode(vc, true);<br>
=C2=A0 =C2=A0 =C2=A0egl_fb_setup_for_tex(&amp;vc-&gt;gfx.guest_fb, backing_=
width, backing_height,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 backing_id, false);<br>
=C2=A0}<br>
@@ -344,6 +347,7 @@ void gd_egl_flush(DisplayChangeListener *dcl,<br>
=C2=A0 =C2=A0 =C2=A0if (vc-&gt;gfx.guest_fb.dmabuf &amp;&amp; !vc-&gt;gfx.g=
uest_fb.dmabuf-&gt;draw_submitted) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0graphic_hw_gl_block(vc-&gt;gfx.dcl.con, t=
rue);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vc-&gt;gfx.guest_fb.dmabuf-&gt;draw_submi=
tted =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gtk_egl_set_scanout_mode(vc, true);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gtk_widget_queue_draw_area(area, x, y, w,=
 h);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c<br>
index c384a1516b..68eff3435b 100644<br>
--- a/ui/gtk-gl-area.c<br>
+++ b/ui/gtk-gl-area.c<br>
@@ -123,6 +123,10 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0gd_update_monitor_refresh_rate(vc, vc-&gt;window ? vc-&=
gt;window : vc-&gt;gfx.drawing_area);<br>
<br>
+=C2=A0 =C2=A0 if (vc-&gt;gfx.guest_fb.dmabuf &amp;&amp; vc-&gt;gfx.guest_f=
b.dmabuf-&gt;draw_submitted) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (!vc-&gt;gfx.gls) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!gtk_widget_get_realized(vc-&gt;gfx.d=
rawing_area)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
@@ -261,7 +265,6 @@ void gd_gl_area_scanout_texture(DisplayChangeListener *=
dcl,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 gtk_gl_area_set_scanout_mode(vc, true);<br>
=C2=A0 =C2=A0 =C2=A0egl_fb_setup_for_tex(&amp;vc-&gt;gfx.guest_fb, backing_=
width, backing_height,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 backing_id, false);<br>
=C2=A0}<br>
@@ -281,6 +284,7 @@ void gd_gl_area_scanout_flush(DisplayChangeListener *dc=
l,<br>
=C2=A0 =C2=A0 =C2=A0if (vc-&gt;gfx.guest_fb.dmabuf &amp;&amp; !vc-&gt;gfx.g=
uest_fb.dmabuf-&gt;draw_submitted) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0graphic_hw_gl_block(vc-&gt;gfx.dcl.con, t=
rue);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vc-&gt;gfx.guest_fb.dmabuf-&gt;draw_submi=
tted =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gtk_gl_area_set_scanout_mode(vc, true);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0gtk_gl_area_queue_render(GTK_GL_AREA(vc-&gt;gfx.drawing=
_area));<br>
=C2=A0}<br>
-- <br>
2.34.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--00000000000024266405ffab4eae--

