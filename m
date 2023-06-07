Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBED725B84
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 12:23:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6qI7-0007Bq-DK; Wed, 07 Jun 2023 06:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1q6qI4-0007Bd-NE
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 06:21:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1q6qI3-0004D7-5t
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 06:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686133278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Yu+tyN7KVZrnJTH/nuli+DPfiEDu42EXIQUi0MRbGw=;
 b=fwqY5C8yOFTquc6Znma08M2Y+bBNKb4RarsfbwMZW97P0EJ2xfAN4h88sC6Z43duVldhE4
 pgDgVosHq2UhCR0+c72QZDGv6lAoHXaTZxaE+qpzovLJvkKhvQk3flbtv7LPnYtSNyVWBe
 Tf8u9+T5DzQdZAMWxnrhavWhI5TUhzs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-6XF8haktP5u8OoOEiITBKQ-1; Wed, 07 Jun 2023 06:21:16 -0400
X-MC-Unique: 6XF8haktP5u8OoOEiITBKQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94a356c74e0so548165166b.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 03:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686133275; x=1688725275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6Yu+tyN7KVZrnJTH/nuli+DPfiEDu42EXIQUi0MRbGw=;
 b=dEhR4HaEYowJ29BzJaTnwlGJKrsVJrGmF5lpdiTEC8imL0kkcO94c9uhCxWX6PwiJ7
 zpWzSpLP0UYn96pUGz1O70f49Sy/D5u9RBm1J/nEPYzOiFwPwYDFpPQ4m8J9Blk2gP2l
 7AX/MVk8xnOmxO5OTjRp+T7P8hRxf14Amdtzq+cH26yVdiCqUP/2w7mIwnlMsVmLfIki
 IYP2HjCGObjKLi9b2/WnM/igaE4+LrBPjEeTkc68iVcFaPEpRjhp54Dlt/ytn3hooahR
 a0IUZ8e6dhk8NrTBPgnegNSnLHVV9Vv4mGYc6NJvs6ZHfCz4dG/LPMlKBAKhcTIIvYu8
 o8OA==
X-Gm-Message-State: AC+VfDyqLGK549goCRltI8X/rZcMTWGz4ZcuW4ictlDeDwTHiPjrKYDy
 eb2Lw6DfHDlj/0HC9b4GspaDTfQ+uArBsGhXiuzP/M2/rk7mVBXsENGZd9+aOFqWu2GGSJWfrG1
 TOfKXeXHC5qtSdSWnTAnZo1HcnfpGPQI=
X-Received: by 2002:a17:907:7baa:b0:94a:74c9:3611 with SMTP id
 ne42-20020a1709077baa00b0094a74c93611mr5286473ejc.35.1686133275608; 
 Wed, 07 Jun 2023 03:21:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5KzibWfoHX2R8p1i4PM4vJfZD5WPPtkwnSu7EP7e61CjsF7eznxVaPCLqZrerWD9+kC4E22rBosmkH30gzVMY=
X-Received: by 2002:a17:907:7baa:b0:94a:74c9:3611 with SMTP id
 ne42-20020a1709077baa00b0094a74c93611mr5286456ejc.35.1686133275332; Wed, 07
 Jun 2023 03:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230607090434.53682-1-quic_acaggian@quicinc.com>
In-Reply-To: <20230607090434.53682-1-quic_acaggian@quicinc.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 7 Jun 2023 14:21:03 +0400
Message-ID: <CAMxuvaxGSdtO-i+ktzE3YpndfuhWCDoR6JqEoautt10adGXndg@mail.gmail.com>
Subject: Re: [PATCH] ui/sdl2: Allow high-dpi
To: Antonio Caggiano <quic_acaggian@quicinc.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000eba88d05fd877e20"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

--000000000000eba88d05fd877e20
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Antonio

On Wed, Jun 7, 2023 at 1:05=E2=80=AFPM Antonio Caggiano <quic_acaggian@quic=
inc.com>
wrote:

> Add the SDL_WINDOW_ALLOW_HIGHDPI flag when creating a window and get the
> drawable size instead of the window size when setting up the framebuffer
> and the viewport.
>
>
What does this actually change?
What about non-gl display, Mouse motion, and display resize?

thanks

Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
> ---
>  ui/sdl2-gl.c | 4 ++--
>  ui/sdl2.c    | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
> index bbfa70eac3..251b7d56d6 100644
> --- a/ui/sdl2-gl.c
> +++ b/ui/sdl2-gl.c
> @@ -53,7 +53,7 @@ static void sdl2_gl_render_surface(struct sdl2_console
> *scon)
>      SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
>      sdl2_set_scanout_mode(scon, false);
>
> -    SDL_GetWindowSize(scon->real_window, &ww, &wh);
> +    SDL_GL_GetDrawableSize(scon->real_window, &ww, &wh);
>      surface_gl_setup_viewport(scon->gls, scon->surface, ww, wh);
>
>      surface_gl_render_texture(scon->gls, scon->surface);
> @@ -239,7 +239,7 @@ void sdl2_gl_scanout_flush(DisplayChangeListener *dcl=
,
>
>      SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
>
> -    SDL_GetWindowSize(scon->real_window, &ww, &wh);
> +    SDL_GL_GetDrawableSize(scon->real_window, &ww, &wh);
>      egl_fb_setup_default(&scon->win_fb, ww, wh);
>      egl_fb_blit(&scon->win_fb, &scon->guest_fb, !scon->y0_top);
>
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index 9d703200bf..c9c83815ca 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -95,7 +95,7 @@ void sdl2_window_create(struct sdl2_console *scon)
>      }
>  #ifdef CONFIG_OPENGL
>      if (scon->opengl) {
> -        flags |=3D SDL_WINDOW_OPENGL;
> +        flags |=3D SDL_WINDOW_OPENGL | SDL_WINDOW_ALLOW_HIGHDPI;
>      }
>  #endif
>
> --
> 2.40.0
>
>

--000000000000eba88d05fd877e20
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Antonio<br></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 7, 2023 at 1:05=
=E2=80=AFPM Antonio Caggiano &lt;<a href=3D"mailto:quic_acaggian@quicinc.co=
m">quic_acaggian@quicinc.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">Add the SDL_WINDOW_ALLOW_HIGHDPI flag when crea=
ting a window and get the<br>
drawable size instead of the window size when setting up the framebuffer<br=
>
and the viewport.<br>
<br></blockquote><div>=C2=A0</div><div>What does this actually change?<br><=
/div><div>What about non-gl display, Mouse motion, and display resize?</div=
><div>=C2=A0</div><div>thanks</div><div><br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
Signed-off-by: Antonio Caggiano &lt;<a href=3D"mailto:quic_acaggian@quicinc=
.com" target=3D"_blank">quic_acaggian@quicinc.com</a>&gt;<br>
---<br>
=C2=A0ui/sdl2-gl.c | 4 ++--<br>
=C2=A0ui/sdl2.c=C2=A0 =C2=A0 | 2 +-<br>
=C2=A02 files changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c<br>
index bbfa70eac3..251b7d56d6 100644<br>
--- a/ui/sdl2-gl.c<br>
+++ b/ui/sdl2-gl.c<br>
@@ -53,7 +53,7 @@ static void sdl2_gl_render_surface(struct sdl2_console *s=
con)<br>
=C2=A0 =C2=A0 =C2=A0SDL_GL_MakeCurrent(scon-&gt;real_window, scon-&gt;winct=
x);<br>
=C2=A0 =C2=A0 =C2=A0sdl2_set_scanout_mode(scon, false);<br>
<br>
-=C2=A0 =C2=A0 SDL_GetWindowSize(scon-&gt;real_window, &amp;ww, &amp;wh);<b=
r>
+=C2=A0 =C2=A0 SDL_GL_GetDrawableSize(scon-&gt;real_window, &amp;ww, &amp;w=
h);<br>
=C2=A0 =C2=A0 =C2=A0surface_gl_setup_viewport(scon-&gt;gls, scon-&gt;surfac=
e, ww, wh);<br>
<br>
=C2=A0 =C2=A0 =C2=A0surface_gl_render_texture(scon-&gt;gls, scon-&gt;surfac=
e);<br>
@@ -239,7 +239,7 @@ void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0SDL_GL_MakeCurrent(scon-&gt;real_window, scon-&gt;winct=
x);<br>
<br>
-=C2=A0 =C2=A0 SDL_GetWindowSize(scon-&gt;real_window, &amp;ww, &amp;wh);<b=
r>
+=C2=A0 =C2=A0 SDL_GL_GetDrawableSize(scon-&gt;real_window, &amp;ww, &amp;w=
h);<br>
=C2=A0 =C2=A0 =C2=A0egl_fb_setup_default(&amp;scon-&gt;win_fb, ww, wh);<br>
=C2=A0 =C2=A0 =C2=A0egl_fb_blit(&amp;scon-&gt;win_fb, &amp;scon-&gt;guest_f=
b, !scon-&gt;y0_top);<br>
<br>
diff --git a/ui/sdl2.c b/ui/sdl2.c<br>
index 9d703200bf..c9c83815ca 100644<br>
--- a/ui/sdl2.c<br>
+++ b/ui/sdl2.c<br>
@@ -95,7 +95,7 @@ void sdl2_window_create(struct sdl2_console *scon)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#ifdef CONFIG_OPENGL<br>
=C2=A0 =C2=A0 =C2=A0if (scon-&gt;opengl) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 flags |=3D SDL_WINDOW_OPENGL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flags |=3D SDL_WINDOW_OPENGL | SDL_WINDOW_ALLO=
W_HIGHDPI;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif<br>
<br>
-- <br>
2.40.0<br>
<br>
</blockquote></div></div>

--000000000000eba88d05fd877e20--


