Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E911A747520
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 17:19:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhna-0006xd-44; Tue, 04 Jul 2023 11:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qGhnW-0006xE-Ds
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:18:34 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qGhnU-00015z-KV
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:18:34 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4036d80caaeso5688901cf.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 08:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688483911; x=1691075911;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iGzhtRZ/KQa0mnvc+wnqjA6zh+gOREyum/8z/CuwOr0=;
 b=nKJzM9Jj3G8cieytXP7/bbXg6JAME0Y49/KeSQqQxD41T6+vqfQqUjK3WlUPx+y7m/
 WvIIOM47SELtcbVWMMNH4RgyuO5LI7yfKMpk67Fj+AOyjqRN+aXf8Sb9eObkd5IEsAxj
 WaRVZblTivD7hVI0Q6Rh64sGbvnVtCAmqiOsNx2w1PLt7bDxqRzg04Mk0cTuVZWB+2rl
 CwS3RJZq+X6LyKYwQwYYPGtexdHmau/r08eHL2EULtbMJsVlfNv/9KBi8bTg1CZTUL4e
 9pjcyUR1ID84liizE6fpcu+1gElm3wGm0i4QL37rvujUZJC1wZIP5LbzDsxaM64/PLlC
 KTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688483911; x=1691075911;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iGzhtRZ/KQa0mnvc+wnqjA6zh+gOREyum/8z/CuwOr0=;
 b=LtdDKF5MGKbj59w+b7zQGohuVyoit4ow37dUIHPgrMNORJw8JLmWF4nDE95Mx8Xvnw
 DFIOYaZHPOmnzyJeoEQwued8u3eE854t5ipJOe+Xzs4uton/A8ryDO9b0AUxBu1c/LN1
 zCyh+31409Q4ky73du0Bj1DGX45ZYaCGUg0kW82l1X09kNvs2x1eSlVxt+BpIVHpWP8A
 B4l1B9YGiepITUIumNsw3tNYvksudMaTqjrN6oZcrQhd3WC0LBXb4CDUCFfQD9aab8wi
 5UDft1sSeAVg3cA8NJk6xTNbbOWlC1TSWbioDHU008k3Ko+VmIJEvOEzoSus0i/0F4Q/
 I7xA==
X-Gm-Message-State: AC+VfDxNx1ZXOHmC8l7l5roJOHFuTY2VjWnQpb+UeNDaYFp/wi6XN3o4
 vkgGlDdVZa+3JOrCPY6Gx6FgIixAHT7y/RmGbdA=
X-Google-Smtp-Source: ACHHUZ6OhrJVHaI4xvIfabwQSvdWlIZHeDqVvc9BQvBsPaRrubzr16WhEWyAdUskq6kjUF1ykUnr5Wvi8B4clsHUHzM=
X-Received: by 2002:a05:622a:1986:b0:400:aaaf:694 with SMTP id
 u6-20020a05622a198600b00400aaaf0694mr14558289qtc.47.1688483911512; Tue, 04
 Jul 2023 08:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230628191504.17185-1-dongwon.kim@intel.com>
In-Reply-To: <20230628191504.17185-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 4 Jul 2023 17:18:20 +0200
Message-ID: <CAJ+F1CJcJ3cecZ6Qe3rUz68BXHxEJA4B8H4zTjtW00JGixNGyw@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: Make sure the right EGL context is currently bound
To: Dongwon Kim <dongwon.kim@intel.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Content-Type: multipart/alternative; boundary="000000000000c1386305ffaacbe9"
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

--000000000000c1386305ffaacbe9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2023 at 9:36=E2=80=AFPM Dongwon Kim <dongwon.kim@intel.com>=
 wrote:

> Observed a wrong context is bound when changing the scanout mode.
> To prevent problem, it is needed to make sure to bind the right
> context in gtk_egl_set_scanout_mode/gtk_gl_area_set_scanout_mode
> as well as unbind one in the end of gd_egl_update/gd_gl_area_update.
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  ui/gtk-egl.c     | 4 ++++
>  ui/gtk-gl-area.c | 2 ++
>  2 files changed, 6 insertions(+)
>
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index 19130041bc..79f9f334f2 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -31,6 +31,8 @@ static void gtk_egl_set_scanout_mode(VirtualConsole *vc=
,
> bool scanout)
>
>      vc->gfx.scanout_mode =3D scanout;
>      if (!vc->gfx.scanout_mode) {
> +        eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
> +                       vc->gfx.esurface, vc->gfx.ectx);
>          egl_fb_destroy(&vc->gfx.guest_fb);
>          if (vc->gfx.surface) {
>              surface_gl_destroy_texture(vc->gfx.gls, vc->gfx.ds);
> @@ -134,6 +136,8 @@ void gd_egl_update(DisplayChangeListener *dcl,
>                     vc->gfx.esurface, vc->gfx.ectx);
>      surface_gl_update_texture(vc->gfx.gls, vc->gfx.ds, x, y, w, h);
>      vc->gfx.glupdates++;
> +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
> +                   EGL_NO_SURFACE, EGL_NO_CONTEXT);
>  }
>
>  void gd_egl_refresh(DisplayChangeListener *dcl)
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index c384a1516b..285e661071 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -26,6 +26,7 @@ static void gtk_gl_area_set_scanout_mode(VirtualConsole
> *vc, bool scanout)
>
>      vc->gfx.scanout_mode =3D scanout;
>      if (!vc->gfx.scanout_mode) {
> +        gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
>          egl_fb_destroy(&vc->gfx.guest_fb);
>          if (vc->gfx.surface) {
>              surface_gl_destroy_texture(vc->gfx.gls, vc->gfx.ds);
> @@ -115,6 +116,7 @@ void gd_gl_area_update(DisplayChangeListener *dcl,
>      gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
>      surface_gl_update_texture(vc->gfx.gls, vc->gfx.ds, x, y, w, h);
>      vc->gfx.glupdates++;
> +    gdk_gl_context_clear_current();
>  }
>
>  void gd_gl_area_refresh(DisplayChangeListener *dcl)
> --
> 2.34.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000c1386305ffaacbe9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 28, 2023 at 9:36=E2=80=AF=
PM Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com">dongwon.kim@int=
el.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Observed a wrong context is bound when changing the scanout mode.<br>
To prevent problem, it is needed to make sure to bind the right<br>
context in gtk_egl_set_scanout_mode/gtk_gl_area_set_scanout_mode<br>
as well as unbind one in the end of gd_egl_update/gd_gl_area_update.<br>
<br>
Cc: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank=
">kraxel@redhat.com</a>&gt;<br>
Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.co=
m" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Cc: Vivek Kasireddy &lt;<a href=3D"mailto:vivek.kasireddy@intel.com" target=
=3D"_blank">vivek.kasireddy@intel.com</a>&gt;<br>
Signed-off-by: Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com" tar=
get=3D"_blank">dongwon.kim@intel.com</a>&gt;<br></blockquote><div><br></div=
><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.l=
ureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0ui/gtk-egl.c=C2=A0 =C2=A0 =C2=A0| 4 ++++<br>
=C2=A0ui/gtk-gl-area.c | 2 ++<br>
=C2=A02 files changed, 6 insertions(+)<br>
<br>
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c<br>
index 19130041bc..79f9f334f2 100644<br>
--- a/ui/gtk-egl.c<br>
+++ b/ui/gtk-egl.c<br>
@@ -31,6 +31,8 @@ static void gtk_egl_set_scanout_mode(VirtualConsole *vc, =
bool scanout)<br>
<br>
=C2=A0 =C2=A0 =C2=A0vc-&gt;gfx.scanout_mode =3D scanout;<br>
=C2=A0 =C2=A0 =C2=A0if (!vc-&gt;gfx.scanout_mode) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 eglMakeCurrent(qemu_egl_display, vc-&gt;gfx.es=
urface,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0vc-&gt;gfx.esurface, vc-&gt;gfx.ectx);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0egl_fb_destroy(&amp;vc-&gt;gfx.guest_fb);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vc-&gt;gfx.surface) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0surface_gl_destroy_texture(=
vc-&gt;gfx.gls, vc-&gt;gfx.ds);<br>
@@ -134,6 +136,8 @@ void gd_egl_update(DisplayChangeListener *dcl,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vc-&g=
t;gfx.esurface, vc-&gt;gfx.ectx);<br>
=C2=A0 =C2=A0 =C2=A0surface_gl_update_texture(vc-&gt;gfx.gls, vc-&gt;gfx.ds=
, x, y, w, h);<br>
=C2=A0 =C2=A0 =C2=A0vc-&gt;gfx.glupdates++;<br>
+=C2=A0 =C2=A0 eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0EGL_N=
O_SURFACE, EGL_NO_CONTEXT);<br>
=C2=A0}<br>
<br>
=C2=A0void gd_egl_refresh(DisplayChangeListener *dcl)<br>
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c<br>
index c384a1516b..285e661071 100644<br>
--- a/ui/gtk-gl-area.c<br>
+++ b/ui/gtk-gl-area.c<br>
@@ -26,6 +26,7 @@ static void gtk_gl_area_set_scanout_mode(VirtualConsole *=
vc, bool scanout)<br>
<br>
=C2=A0 =C2=A0 =C2=A0vc-&gt;gfx.scanout_mode =3D scanout;<br>
=C2=A0 =C2=A0 =C2=A0if (!vc-&gt;gfx.scanout_mode) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gtk_gl_area_make_current(GTK_GL_AREA(vc-&gt;gf=
x.drawing_area));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0egl_fb_destroy(&amp;vc-&gt;gfx.guest_fb);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vc-&gt;gfx.surface) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0surface_gl_destroy_texture(=
vc-&gt;gfx.gls, vc-&gt;gfx.ds);<br>
@@ -115,6 +116,7 @@ void gd_gl_area_update(DisplayChangeListener *dcl,<br>
=C2=A0 =C2=A0 =C2=A0gtk_gl_area_make_current(GTK_GL_AREA(vc-&gt;gfx.drawing=
_area));<br>
=C2=A0 =C2=A0 =C2=A0surface_gl_update_texture(vc-&gt;gfx.gls, vc-&gt;gfx.ds=
, x, y, w, h);<br>
=C2=A0 =C2=A0 =C2=A0vc-&gt;gfx.glupdates++;<br>
+=C2=A0 =C2=A0 gdk_gl_context_clear_current();<br>
=C2=A0}<br>
<br>
=C2=A0void gd_gl_area_refresh(DisplayChangeListener *dcl)<br>
-- <br>
2.34.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000c1386305ffaacbe9--

