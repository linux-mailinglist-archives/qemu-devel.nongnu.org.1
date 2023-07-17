Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDAA755F42
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 11:32:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLKZm-0007Xh-7J; Mon, 17 Jul 2023 05:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qLKZg-0007XS-M4
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 05:31:24 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qLKZe-00038z-Mi
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 05:31:24 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-403a7066bc8so31327871cf.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 02:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689586281; x=1692178281;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=90FPhX5LO/9ZiuXA/j5Xf1aIBx6mXIh5x7Zbca5rMtM=;
 b=htBqlvnnHZNwXO705NBL9WzXrMUO6dff7TR9J0cdGtEfn4thP9dJRJmeumaBlUUbLl
 JnWTeur8pDHx3BEX/NeCJUG8FgI+dY+ZjNK9r8Oi4hGKetlAfsveGh9d2RA9GDgTFRSh
 rG9o0DLP3u9V0AK0bSPIwb2JwJZJs39Qn2kZvZFld5lKaVQ88kVFwd6wFxqEC8Y9zyHs
 pIItJikLnqdp5jEx9u0wNfTU1Js95ys4NXHja5GOuZJU+4Owo/uPKKJgonqIsmUovb3p
 1NE4QiE7vfzCjyILrSrH3bZiGxbvoPO61IPUhBqJxAN5xRgRyOne3gmW31yJEM7J00Wp
 dS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689586281; x=1692178281;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=90FPhX5LO/9ZiuXA/j5Xf1aIBx6mXIh5x7Zbca5rMtM=;
 b=YfhYBzp8wf/XistDkupVXbWBznsYVM4/p5iLSToeeQTx2NsZP35p8ZECVCwcfYlAhz
 MEJq6aWdx96QaIZ53hTcXd3LdEg3uSX/yRROhsCshk2qc4USQDM8cp3TaHCYO6vIC7m7
 9TKCGwpsA+ismsu9ZLlAurlvGa0fZqXUu7JeyxNgxgWRaAl9zmGdvq6baAp99Br71LjA
 8JYMb6yph0BqG5yOYry+sCjg8rkRvSGGjkCkG7any8S6rFF7OfAvDqQ3wdm/ZK8vwST6
 e76mbuZ68mgydQdR9SXLd2pyU+kiRngP1J3IORLc1X/Q8U6/NWOFbV4evfEwJX6goXAD
 gEoQ==
X-Gm-Message-State: ABy/qLaN+wnGUC2kbFdCCiL5I2Hb4synCtU7ET56SPT0TvAa1a1x6T8J
 arDLFgR1+r1jrQ8bWcCRJXFq5b/cxchF28Dp2fE=
X-Google-Smtp-Source: APBJJlEnL9KUaBA42GYq13vcSKd9ZLQxf8kyMWQdP0qGJvmlCSHr8cQOomKLFGA2Devwyl0kY9tlYT528RIHkvJfBiw=
X-Received: by 2002:a05:622a:48a:b0:403:e84a:6ef5 with SMTP id
 p10-20020a05622a048a00b00403e84a6ef5mr6511356qtx.12.1689586281609; Mon, 17
 Jul 2023 02:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+F1C+9hbdgv7tLibnYKS-3fOBotVU=MHwYq6Ly2Wccf-Dd_g@mail.gmail.com>
 <20230706183355.29361-1-dongwon.kim@intel.com>
 <20230706183355.29361-2-dongwon.kim@intel.com>
In-Reply-To: <20230706183355.29361-2-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 17 Jul 2023 13:31:10 +0400
Message-ID: <CAJ+F1CKtdkE1JMT-mQ921oGX=wY+1RkmO3EEP2nd2G8mToEx9Q@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: skip refresh if new dmabuf has been submitted
To: Dongwon Kim <dongwon.kim@intel.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Content-Type: multipart/alternative; boundary="00000000000021fdf90600ab76fd"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
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

--00000000000021fdf90600ab76fd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 6, 2023 at 10:57=E2=80=AFPM Dongwon Kim <dongwon.kim@intel.com>=
 wrote:

> Skip refresh if a new dmabuf (guest scanout frame) has already been
> submitted and ready to be drawn because the scanout will be updated
> with new frame anyway.
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
>

Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  ui/gtk-egl.c     | 4 ++++
>  ui/gtk-gl-area.c | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index d59b8cd7d7..859aa8185e 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -144,6 +144,10 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
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
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index 7367dfd793..7da75bd025 100644
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
> --
> 2.34.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000021fdf90600ab76fd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 6, 2023 at 10:57=E2=80=AF=
PM Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com">dongwon.kim@int=
el.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Skip refresh if a new dmabuf (guest scanout frame) has already been<b=
r>
submitted and ready to be drawn because the scanout will be updated<br>
with new frame anyway.<br>
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
=C2=A0ui/gtk-egl.c=C2=A0 =C2=A0 =C2=A0| 4 ++++<br>
=C2=A0ui/gtk-gl-area.c | 4 ++++<br>
=C2=A02 files changed, 8 insertions(+)<br>
<br>
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c<br>
index d59b8cd7d7..859aa8185e 100644<br>
--- a/ui/gtk-egl.c<br>
+++ b/ui/gtk-egl.c<br>
@@ -144,6 +144,10 @@ void gd_egl_refresh(DisplayChangeListener *dcl)<br>
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
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c<br>
index 7367dfd793..7da75bd025 100644<br>
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
-- <br>
2.34.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--00000000000021fdf90600ab76fd--

