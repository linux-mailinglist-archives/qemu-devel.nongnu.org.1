Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF51755F3C
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 11:30:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLKXr-0006ZM-2z; Mon, 17 Jul 2023 05:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qLKXo-0006Z6-VA
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 05:29:28 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qLKXm-0002Yp-3u
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 05:29:28 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-403a3df88a8so31958321cf.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 02:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689586163; x=1692178163;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jkznGYwAaTbTRQFw5DTmBsZL8Nn+BscNfQ6ARfVwTzc=;
 b=F0q34Zo9c3yHIkpRMpdjqs4w8Zr6/RSyesQi9RQBb/KJ20iLufn9M6DQt+gRIsN153
 X5pv8bYN7wwZ0W057opDT6c+ZO6qI/cCIv/VJp0niet8A/nVDKgDdd3TbaKONbZWvSUI
 Lmf1V7oyDxQHcDCltktJdmbgLWvMlBZVYd97ndLhQkFsV+BBUzPGFjJkzzO13SeOM+vk
 1ckgl5t3fHGLhR1h1ZmRuqNvIlrH/7fngboK7zunlcNgi+NIkYnyRsZzFU0NLVoqysQd
 YBl16x2mREv2PghsULBD2RwCnvfRLaNhG8emzGwFrVyeKPNbH32ZVWytMDSa2XqBt8vS
 aBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689586163; x=1692178163;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jkznGYwAaTbTRQFw5DTmBsZL8Nn+BscNfQ6ARfVwTzc=;
 b=Ng9HF8GMU6oFHQh7THzeAz6+/841OK3mm5dwYF09hx929DQJZpukbyVLRrWtMCjrz5
 AN0hsBJ9xKJLIU45J1/vlaPItOF1VEH6THVkdYAXrX7ICLRSL8YYEOXewQZ2XajB47JA
 5zd4akP+oIjaSOQTXxXmP+zehhGaw/N8RiIM79Gg9Q5Fn0xGqqWewNZGF9kMSFSvkqsH
 BglpumIuMXaN37HkNZsYTPPOkw7QNApVd9BJXe0lhdbERRljs9LUxXnv6V/bMy4C561C
 0fLxwK3TTEPo7kBLMGNKj9zRxmt/B7Y9dB2VcVPz0y1Gf0JWcqEYRonQc8AWaiVyKlsN
 ImWQ==
X-Gm-Message-State: ABy/qLamtyRhK7DsFwolC8iCCC95xk8Tq0QxsSNwLUjpqD+PbWdWETha
 FNzO9JHj37E+BizlCVKqlocmPoOfB4XH072pQms=
X-Google-Smtp-Source: APBJJlE115vnG7u+UK/o1dYprvkQUPJD8jKrcFtdmo1QjD4ktd/zz3MWIeZYpPkqWZvq7rskThrVrO1XAC4KyJATUcQ=
X-Received: by 2002:a05:622a:1750:b0:403:ebb2:de57 with SMTP id
 l16-20020a05622a175000b00403ebb2de57mr3694575qtk.37.1689586163360; Mon, 17
 Jul 2023 02:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+F1C+9hbdgv7tLibnYKS-3fOBotVU=MHwYq6Ly2Wccf-Dd_g@mail.gmail.com>
 <20230706183355.29361-1-dongwon.kim@intel.com>
In-Reply-To: <20230706183355.29361-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 17 Jul 2023 13:29:12 +0400
Message-ID: <CAJ+F1C+S7tXfRr+uVV-__62emThSqdscpgEvXBOqK1d6gjvX2g@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: set scanout-mode right before scheduling draw
To: Dongwon Kim <dongwon.kim@intel.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Content-Type: multipart/alternative; boundary="00000000000015a9350600ab6ff6"
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

--00000000000015a9350600ab6ff6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 6, 2023 at 10:57=E2=80=AFPM Dongwon Kim <dongwon.kim@intel.com>=
 wrote:

> Setting scanout mode is better to be done very last minute
> right because the mode can be reset anytime after it is set in
> dpy_gl_scanout_texture by any asynchronouse dpy_refresh call,
> which eventually cancels drawing of the guest scanout texture.
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
>

Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  ui/gtk-egl.c     | 2 +-
>  ui/gtk-gl-area.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index d59b8cd7d7..b0356d1969 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -238,7 +238,6 @@ void gd_egl_scanout_texture(DisplayChangeListener *dc=
l,
>      eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
>                     vc->gfx.esurface, vc->gfx.ectx);
>
> -    gtk_egl_set_scanout_mode(vc, true);
>      egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_heigh=
t,
>                           backing_id, false);
>  }
> @@ -347,6 +346,7 @@ void gd_egl_flush(DisplayChangeListener *dcl,
>      if (vc->gfx.guest_fb.dmabuf &&
> !vc->gfx.guest_fb.dmabuf->draw_submitted) {
>          graphic_hw_gl_block(vc->gfx.dcl.con, true);
>          vc->gfx.guest_fb.dmabuf->draw_submitted =3D true;
> +        gtk_egl_set_scanout_mode(vc, true);
>          gtk_widget_queue_draw_area(area, x, y, w, h);
>          return;
>      }
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index 7367dfd793..cc8c2f8061 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -262,7 +262,6 @@ void gd_gl_area_scanout_texture(DisplayChangeListener
> *dcl,
>          return;
>      }
>
> -    gtk_gl_area_set_scanout_mode(vc, true);
>      egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_heigh=
t,
>                           backing_id, false);
>  }
> @@ -282,6 +281,7 @@ void gd_gl_area_scanout_flush(DisplayChangeListener
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

--00000000000015a9350600ab6ff6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 6, 2023 at 10:57=E2=80=AF=
PM Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com">dongwon.kim@int=
el.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Setting scanout mode is better to be done very last minute<br>
right because the mode can be reset anytime after it is set in<br>
dpy_gl_scanout_texture by any asynchronouse dpy_refresh call,<br>
which eventually cancels drawing of the guest scanout texture.<br>
<br>
Cc: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank=
">kraxel@redhat.com</a>&gt;<br>
Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.co=
m" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Cc: Vivek Kasireddy &lt;<a href=3D"mailto:vivek.kasireddy@intel.com" target=
=3D"_blank">vivek.kasireddy@intel.com</a>&gt;<br>
Signed-off-by: Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com" tar=
get=3D"_blank">dongwon.kim@intel.com</a>&gt;<br></blockquote><div><br></div=
><div>Acked-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lure=
au@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0ui/gtk-egl.c=C2=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A0ui/gtk-gl-area.c | 2 +-<br>
=C2=A02 files changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c<br>
index d59b8cd7d7..b0356d1969 100644<br>
--- a/ui/gtk-egl.c<br>
+++ b/ui/gtk-egl.c<br>
@@ -238,7 +238,6 @@ void gd_egl_scanout_texture(DisplayChangeListener *dcl,=
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
@@ -347,6 +346,7 @@ void gd_egl_flush(DisplayChangeListener *dcl,<br>
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
index 7367dfd793..cc8c2f8061 100644<br>
--- a/ui/gtk-gl-area.c<br>
+++ b/ui/gtk-gl-area.c<br>
@@ -262,7 +262,6 @@ void gd_gl_area_scanout_texture(DisplayChangeListener *=
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
@@ -282,6 +281,7 @@ void gd_gl_area_scanout_flush(DisplayChangeListener *dc=
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

--00000000000015a9350600ab6ff6--

