Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D69B71A30B
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 17:48:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4kXB-00069l-Cn; Thu, 01 Jun 2023 11:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1q4kX9-00069N-CX
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:48:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1q4kX7-0007eG-Mt
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685634492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PmECezFmkjAPxHgbdPlRsvhGcS8r2ehLRgLme/mHl2E=;
 b=gH8+k0CicHgCg+6vQnDbe5I0xDe0AZgaCNH59RS9NrZtBXYPEdpTPX/EzUmrzOm2sbZz0j
 vQTAyOgRDB29d3z0POVWqD9wnvmfv1l/wP6w5dmUkNbYl5bUsJ3sXW+1WOlJi1W9vs7bMm
 tFm2pWEozIwPFCXedzQIbQOz8FGEaTs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-AIICZyyhOF-XELKmAAxYhg-1; Thu, 01 Jun 2023 11:48:11 -0400
X-MC-Unique: AIICZyyhOF-XELKmAAxYhg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2af2790f4a2so9318981fa.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 08:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685634489; x=1688226489;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PmECezFmkjAPxHgbdPlRsvhGcS8r2ehLRgLme/mHl2E=;
 b=Of/+mhT6VOdBRqCxHzyrLEUIOAIHvxmedAtllz2zYxkN0Dg9pL6h1q5kxTCG9IiOV1
 VGFmniNSDzdO4x2M3BdanVsi6sIOLsERIT/R+HCB8WMkSp44vhvJA2ooldqzvklAYsl4
 hM+FpMGKKVNeD3WsDRhbQNmjs0kQWJ/XoutIgRAO3iZw6aCzJnYsIo9Xz1CkDyK8aJy3
 DksVtyKIdKzeAOr9x7uFP+Envf30CIfF44TKjMO+aw1VDNvQQ0Drk/7r2gBw6JXErtJO
 mC6hDG8KcBqzat5eazCQNK5bmoQdetyt6hENbJ2Ql9nmTC3RQh+ck9ZaAOlR/MTVWyLd
 V5vQ==
X-Gm-Message-State: AC+VfDzUsB+mO4rlPMuKM1NXT2Hnema+wB2DAyA4LZGMk4o84BPkXcpl
 VKDh9Zpti4eVTan6QsxmlpxuxQI+MifprIKilXMQp9FcXL6NZRMjoIGsQ6YLT5LLzBzvkbZQSb3
 yga3PcGJF3/f8xvgqZYEbgtscfpfPnuO+xOtor6w=
X-Received: by 2002:a2e:9ec5:0:b0:2ae:e214:482f with SMTP id
 h5-20020a2e9ec5000000b002aee214482fmr4676006ljk.52.1685634488978; 
 Thu, 01 Jun 2023 08:48:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5tEfDLfDTTQ3SPCAoD9EVVpuEJX6XYv9SNTct/ItH41o0ERFzDoM4PC9IIudt4jfLoNSBvyVn7Ykyj3mWSfXs=
X-Received: by 2002:a2e:9ec5:0:b0:2ae:e214:482f with SMTP id
 h5-20020a2e9ec5000000b002aee214482fmr4675999ljk.52.1685634488707; Thu, 01 Jun
 2023 08:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230601140019.66013-1-quic_acaggian@quicinc.com>
In-Reply-To: <20230601140019.66013-1-quic_acaggian@quicinc.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 1 Jun 2023 19:47:57 +0400
Message-ID: <CAMxuvayfM_EY3JVWxEc6izG_7gLf0Lp-6jcUd6R5Seng5gB1yQ@mail.gmail.com>
Subject: Re: [PATCH] SDL: OpenGL 3 window context
To: Antonio Caggiano <quic_acaggian@quicinc.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ebd06705fd135cfd"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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

--000000000000ebd06705fd135cfd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Jun 1, 2023 at 6:30=E2=80=AFPM Antonio Caggiano <quic_acaggian@quic=
inc.com>
wrote:

> SDL renderer creates an OpenGL 2.1 context while QEMU expects minimum
> OpenGL version 3.3 or ES 3.0. To fix this we create an OpenGL context
> directly, ignoring the SDL renderer when OpenGL is enabled.
>
> Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
> ---
>  ui/sdl2.c | 34 ++++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index 9d703200bf..42512588b5 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -104,7 +104,24 @@ void sdl2_window_create(struct sdl2_console *scon)
>                                           surface_width(scon->surface),
>                                           surface_height(scon->surface),
>                                           flags);
> +
>      if (scon->opengl) {
> +        /* Set the minimum version required by the texture blit shaders =
*/
> +        SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3);
> +        SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 3);
> +
> +        if (scon->opts->gl =3D=3D DISPLAYGL_MODE_ES) {
> +            SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
> +                                SDL_GL_CONTEXT_PROFILE_ES);
> +            SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 0);
> +        }
> +
> +        scon->winctx =3D SDL_GL_CreateContext(scon->real_window);
> +    } else {
> +        /*
> +         * The SDL renderer is only used by sdl2 2D callbacks, when
> OpenGL is
> +         * disabled at configuration time
> +         */
>

"configuration" time usually means during compilation configuration. Here I
guess you also mean during runtime configuration.

I suggest you simply drop "at configuation time", as it is confusing imho.



>          const char *driver =3D "opengl";
>
>          if (scon->opts->gl =3D=3D DISPLAYGL_MODE_ES) {
> @@ -113,11 +130,8 @@ void sdl2_window_create(struct sdl2_console *scon)
>
>          SDL_SetHint(SDL_HINT_RENDER_DRIVER, driver);
>          SDL_SetHint(SDL_HINT_RENDER_BATCHING, "1");
> -    }
> -    scon->real_renderer =3D SDL_CreateRenderer(scon->real_window, -1, 0)=
;
>
> -    if (scon->opengl) {
> -        scon->winctx =3D SDL_GL_CreateContext(scon->real_window);
> +        scon->real_renderer =3D SDL_CreateRenderer(scon->real_window, -1=
,
> 0);
>      }
>      sdl_update_caption(scon);
>  }
> @@ -128,10 +142,14 @@ void sdl2_window_destroy(struct sdl2_console *scon)
>          return;
>      }
>
> -    SDL_GL_DeleteContext(scon->winctx);
> -    scon->winctx =3D NULL;
> -    SDL_DestroyRenderer(scon->real_renderer);
> -    scon->real_renderer =3D NULL;
> +    if (scon->winctx) {
> +        SDL_GL_DeleteContext(scon->winctx);
> +        scon->winctx =3D NULL;
> +    }
> +    if (scon->real_renderer) {
> +        SDL_DestroyRenderer(scon->real_renderer);
> +        scon->real_renderer =3D NULL;
> +    }
>      SDL_DestroyWindow(scon->real_window);
>      scon->real_window =3D NULL;
>  }
> --
> 2.40.0
>
>
Have you checked the behaviour on Windows?

thanks

--000000000000ebd06705fd135cfd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 1, 2023 at 6:30=E2=80=
=AFPM Antonio Caggiano &lt;<a href=3D"mailto:quic_acaggian@quicinc.com">qui=
c_acaggian@quicinc.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">SDL renderer creates an OpenGL 2.1 context while QEMU=
 expects minimum<br>
OpenGL version 3.3 or ES 3.0. To fix this we create an OpenGL context<br>
directly, ignoring the SDL renderer when OpenGL is enabled.<br>
<br>
Signed-off-by: Antonio Caggiano &lt;<a href=3D"mailto:quic_acaggian@quicinc=
.com" target=3D"_blank">quic_acaggian@quicinc.com</a>&gt;<br>
---<br>
=C2=A0ui/sdl2.c | 34 ++++++++++++++++++++++++++--------<br>
=C2=A01 file changed, 26 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/ui/sdl2.c b/ui/sdl2.c<br>
index 9d703200bf..42512588b5 100644<br>
--- a/ui/sdl2.c<br>
+++ b/ui/sdl2.c<br>
@@ -104,7 +104,24 @@ void sdl2_window_create(struct sdl2_console *scon)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s=
urface_width(scon-&gt;surface),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s=
urface_height(scon-&gt;surface),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f=
lags);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (scon-&gt;opengl) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set the minimum version required by the tex=
ture blit shaders */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSI=
ON, 3);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSI=
ON, 3);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (scon-&gt;opts-&gt;gl =3D=3D DISPLAYGL_MODE=
_ES) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SDL_GL_SetAttribute(SDL_GL_CONTE=
XT_PROFILE_MASK,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SDL_GL_CONTEXT_PROFILE_ES);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SDL_GL_SetAttribute(SDL_GL_CONTE=
XT_MINOR_VERSION, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scon-&gt;winctx =3D SDL_GL_CreateContext(scon-=
&gt;real_window);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The SDL renderer is only used by sdl2 =
2D callbacks, when OpenGL is<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* disabled at configuration time<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br></blockquote><div><br></div><div>&=
quot;configuration&quot; time usually means during compilation configuratio=
n. Here I guess you also mean during runtime configuration.</div><div><br><=
/div><div>I suggest you simply drop &quot;at configuation time&quot;, as it=
 is confusing imho.</div><div><br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *driver =3D &quot;opengl&quot;=
;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (scon-&gt;opts-&gt;gl =3D=3D DISPLAYGL=
_MODE_ES) {<br>
@@ -113,11 +130,8 @@ void sdl2_window_create(struct sdl2_console *scon)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SDL_SetHint(SDL_HINT_RENDER_DRIVER, drive=
r);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SDL_SetHint(SDL_HINT_RENDER_BATCHING, &qu=
ot;1&quot;);<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 scon-&gt;real_renderer =3D SDL_CreateRenderer(scon-&gt;real_=
window, -1, 0);<br>
<br>
-=C2=A0 =C2=A0 if (scon-&gt;opengl) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 scon-&gt;winctx =3D SDL_GL_CreateContext(scon-=
&gt;real_window);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scon-&gt;real_renderer =3D SDL_CreateRenderer(=
scon-&gt;real_window, -1, 0);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0sdl_update_caption(scon);<br>
=C2=A0}<br>
@@ -128,10 +142,14 @@ void sdl2_window_destroy(struct sdl2_console *scon)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 SDL_GL_DeleteContext(scon-&gt;winctx);<br>
-=C2=A0 =C2=A0 scon-&gt;winctx =3D NULL;<br>
-=C2=A0 =C2=A0 SDL_DestroyRenderer(scon-&gt;real_renderer);<br>
-=C2=A0 =C2=A0 scon-&gt;real_renderer =3D NULL;<br>
+=C2=A0 =C2=A0 if (scon-&gt;winctx) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 SDL_GL_DeleteContext(scon-&gt;winctx);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scon-&gt;winctx =3D NULL;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (scon-&gt;real_renderer) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 SDL_DestroyRenderer(scon-&gt;real_renderer);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scon-&gt;real_renderer =3D NULL;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0SDL_DestroyWindow(scon-&gt;real_window);<br>
=C2=A0 =C2=A0 =C2=A0scon-&gt;real_window =3D NULL;<br>
=C2=A0}<br>
-- <br>
2.40.0<br>
<br></blockquote><div><br></div><div>Have you checked the behaviour on Wind=
ows?</div><div><br></div><div>thanks<br></div></div></div>

--000000000000ebd06705fd135cfd--


