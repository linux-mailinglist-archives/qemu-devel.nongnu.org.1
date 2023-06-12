Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F6772BB14
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 10:45:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8dBC-0006KF-8B; Mon, 12 Jun 2023 04:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q8dAp-0006CC-MG
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 04:45:15 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q8dAn-0007wD-NH
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 04:45:15 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2b1a7e31dcaso45598731fa.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 01:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686559511; x=1689151511;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ie3jIR9cC2DPt8l8rjCp+ll/IfcK8ILMVJOO5vmZE9o=;
 b=sLuz0LfRpIil69I0GSjprMHOPj70V42CYqMvlmOIsNqgea9fYY3Uaqtk6q7i0si0Jv
 qcM0K736zDT5wx46lMq8hPJbCqwy5xzvJsSln4tq15i1owuQcYbgQy25Pl4OQnFUwnN5
 2xVyAoFzk27qt2rKVTOa01WVUASSb4zKCYydGIWSby+J/0CjDmPFz4OC5UvlOY4LzDYV
 RdlquOIqH869gMA+5gzR+6lyFrshVXBtElnS+r7jWBXK4pp45erWU3Bhetimw1toAfsw
 F8ZsLl5eiJTJRBdH/qtcUCK+bKOrVvoPw95mO/P7EDyiyFz3rWUWBKGsVXU+BTR51d9F
 pV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686559511; x=1689151511;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ie3jIR9cC2DPt8l8rjCp+ll/IfcK8ILMVJOO5vmZE9o=;
 b=crwsORs4AwAqDg5WdhdbS7dgISDdZyUCAVHAe2v9xgTZAiiA2uDYPNGfMoML2Ki9zD
 P4Z8fo7xrsSS4JKkwbL0VFRquLEXTJ71WIEky+oJ2yJ/yWlhlPGyKS8SuT1F9rx5xvJ2
 rLIprJNhumiC88Ogn8EOB9UvWkLXGhRlW8SLK5QtJ2rPuuDukFXdr84MSYDbhGr1EWaE
 9PZeGbVZJQZnwJ5WWpq85D8EelqZH28/TWl2WlroTDOXqoe5uU00aVL99jlSyIhEpK8g
 6XxFVtre27H1JnwI3O4Ud0dd5rYEO9c3oNILh1i56L9RKqpWgPzusTb10Gk/Qznys751
 I+uA==
X-Gm-Message-State: AC+VfDwSiWP0Ee2abWzceLp4ALLzJfFCXKDjHfyju0I3eB/sBlhlhMic
 YiQ62axhBaRqNO3ID+lxVyvx7ldpEadpabrqd5k=
X-Google-Smtp-Source: ACHHUZ4OzQL8h7cNg/4cjA/4INhpyr7r3TBlvuqL+5IaBD9qA2Kt9QIOY4yu5NfiEjY4YzwXPBpeTBGK4zRATtDqJm8=
X-Received: by 2002:a2e:9d8c:0:b0:2b1:c0d3:72cb with SMTP id
 c12-20020a2e9d8c000000b002b1c0d372cbmr2287445ljj.23.1686559511067; Mon, 12
 Jun 2023 01:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230612083802.2045-1-quic_acaggian@quicinc.com>
In-Reply-To: <20230612083802.2045-1-quic_acaggian@quicinc.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 12 Jun 2023 10:44:56 +0200
Message-ID: <CAJ+F1C+emDgJFb5KB8N=Peues7COazazJo9wmNf3hKkZbJSkrg@mail.gmail.com>
Subject: Re: [PATCH] ui/sdl2: OpenGL window context
To: Antonio Caggiano <quic_acaggian@quicinc.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008cc0e505fdeabc70"
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-lj1-x22a.google.com
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

--0000000000008cc0e505fdeabc70
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2023 at 10:39=E2=80=AFAM Antonio Caggiano <quic_acaggian@qu=
icinc.com>
wrote:

> When OpenGL is enabled, create only the OpenGL context, ignoring the SDL
> renderer as it is unused anyway.
>
> Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  ui/sdl2.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index 9d703200bf..0d91b555e3 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -113,11 +113,11 @@ void sdl2_window_create(struct sdl2_console *scon)
>
>          SDL_SetHint(SDL_HINT_RENDER_DRIVER, driver);
>          SDL_SetHint(SDL_HINT_RENDER_BATCHING, "1");
> -    }
> -    scon->real_renderer =3D SDL_CreateRenderer(scon->real_window, -1, 0)=
;
>
> -    if (scon->opengl) {
>          scon->winctx =3D SDL_GL_CreateContext(scon->real_window);
> +    } else {
> +        /* The SDL renderer is only used by sdl2-2D, when OpenGL is
> disabled */
> +        scon->real_renderer =3D SDL_CreateRenderer(scon->real_window, -1=
,
> 0);
>      }
>      sdl_update_caption(scon);
>  }
> @@ -128,10 +128,14 @@ void sdl2_window_destroy(struct sdl2_console *scon)
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
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000008cc0e505fdeabc70
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 12, 2023 at 10:39=E2=80=
=AFAM Antonio Caggiano &lt;<a href=3D"mailto:quic_acaggian@quicinc.com">qui=
c_acaggian@quicinc.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">When OpenGL is enabled, create only the OpenGL contex=
t, ignoring the SDL<br>
renderer as it is unused anyway.<br>
<br>
Signed-off-by: Antonio Caggiano &lt;<a href=3D"mailto:quic_acaggian@quicinc=
.com" target=3D"_blank">quic_acaggian@quicinc.com</a>&gt;<br></blockquote><=
div><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailt=
o:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><di=
v>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0ui/sdl2.c | 18 +++++++++++-------<br>
=C2=A01 file changed, 11 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/ui/sdl2.c b/ui/sdl2.c<br>
index 9d703200bf..0d91b555e3 100644<br>
--- a/ui/sdl2.c<br>
+++ b/ui/sdl2.c<br>
@@ -113,11 +113,11 @@ void sdl2_window_create(struct sdl2_console *scon)<br=
>
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
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0scon-&gt;winctx =3D SDL_GL_CreateContext(=
scon-&gt;real_window);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The SDL renderer is only used by sdl2-2D, w=
hen OpenGL is disabled */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scon-&gt;real_renderer =3D SDL_CreateRenderer(=
scon-&gt;real_window, -1, 0);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0sdl_update_caption(scon);<br>
=C2=A0}<br>
@@ -128,10 +128,14 @@ void sdl2_window_destroy(struct sdl2_console *scon)<b=
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
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--0000000000008cc0e505fdeabc70--

