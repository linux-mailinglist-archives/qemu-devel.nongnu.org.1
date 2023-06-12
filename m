Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E6E72BBF9
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 11:22:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8djz-0000Ls-LS; Mon, 12 Jun 2023 05:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q8djx-0000Ld-S1
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 05:21:33 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q8djv-0005QL-Ik
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 05:21:33 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2b203360d93so47309791fa.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 02:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686561689; x=1689153689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=noa2LT/NuqKe/tmhyHgC2b7llZqCakVejpapEWc6P0Y=;
 b=gPsqvj6b94Aeguf/riEEHgU68I8vNADmpTCiNLZzV/3xSJ3P3SJ7SYdNUM52Mx7PEy
 vPB4hEcpqRBno+lfGNi9vkExy93PtXavry4fimyPYHNJ6U1Yg9U77EzUNYsgFspuWJOi
 gDihoOQiXXnbuiog55fGeTpnTnMFo/RH1Dn3oYmDNx9qZcK9za8jHyJmV3W9Gde7DUiN
 h9c43NCDMkdS9vWXILXOv6a8IaJNkqr60sn7Q3FLAiLorE9XO7X7rSQdHnrGUgTuy2hg
 uH8zt8Mz7xOTCOCURGYh013eZfpozifE43G/eq1EBXbDQr6PzOE5Oqcjzkn4dxen4ARF
 qEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686561689; x=1689153689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=noa2LT/NuqKe/tmhyHgC2b7llZqCakVejpapEWc6P0Y=;
 b=Y4AfufiQryu4Q+m7zJzgugDH81IcLHkDVALRTGx0S+AxrFLfZci84Zhzup/5WLHttY
 1XqIXRWGJgGrEzVGFducY/fB0DvfCLZqRisbuhkVb2ax7uy0NF0qYTO0J7RxBHaZmvqZ
 EkR+sKAt3c34ZG0jDF0NBFMIEUwzyj0nAa/aRWcP4EuS46BIXl/5od8CImv5QTDVKuPX
 RnAE3a3PdZweqPHc52pJbIWQ6KLuESCV1nGoiuR9nk8ML2AFaZ/+UAIcGfWChs+YVxtI
 Ie7ux6gv1Bd1+lG84jbA9AN8i/lOUwcQEgpGAZQu4P078VFuqtnNfzhIFr22q2xzmwsJ
 scSw==
X-Gm-Message-State: AC+VfDzg5rxnb1pWmCSUQVTiyxpPmXk24TYDP9W2/kPcfWKJ9I5prCQ3
 NEHGlwHrXeTLGA8rMAiAEJ/0eCWvNui5VlgEj0o=
X-Google-Smtp-Source: ACHHUZ7RIO96IWHuK7BLCDDWI8BMhTVFEaLsflPedEs+WOWKJLTYbgEaPk1eZJRiIEuh/5YH00BbEM4Yxcu0vecLqSE=
X-Received: by 2002:a2e:95cf:0:b0:2b1:d9eb:34b9 with SMTP id
 y15-20020a2e95cf000000b002b1d9eb34b9mr2106238ljh.40.1686561689336; Mon, 12
 Jun 2023 02:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230607090434.53682-1-quic_acaggian@quicinc.com>
 <CAMxuvaxGSdtO-i+ktzE3YpndfuhWCDoR6JqEoautt10adGXndg@mail.gmail.com>
 <f64e93e3-20d2-06a8-3784-999087ea6996@quicinc.com>
In-Reply-To: <f64e93e3-20d2-06a8-3784-999087ea6996@quicinc.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 12 Jun 2023 11:21:14 +0200
Message-ID: <CAJ+F1C+H+0_W0FztAoGV0qLxAtKh3fM4YXZh4WFHABz5cvbSTA@mail.gmail.com>
Subject: Re: [PATCH] ui/sdl2: Allow high-dpi
To: Antonio Caggiano <quic_acaggian@quicinc.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000062827f05fdeb3e29"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-lj1-x230.google.com
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

--00000000000062827f05fdeb3e29
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Antonio

On Thu, Jun 8, 2023 at 1:33=E2=80=AFPM Antonio Caggiano <quic_acaggian@quic=
inc.com>
wrote:

> Hi Marc-Andr=C3=A9,
>
> On 07/06/2023 12:21, Marc-Andr=C3=A9 Lureau wrote:
> > Hi Antonio
> >
> > On Wed, Jun 7, 2023 at 1:05=E2=80=AFPM Antonio Caggiano <
> quic_acaggian@quicinc.com>
> > wrote:
> >
> >> Add the SDL_WINDOW_ALLOW_HIGHDPI flag when creating a window and get t=
he
> >> drawable size instead of the window size when setting up the framebuff=
er
> >> and the viewport.
> >>
> >>
> > What does this actually change?
>
> The sdl2-gl backend does not work properly on high-DPI windows. [0]
> My understanding is that by allowing high-DPI, SDL creates a framebuffer
> with the right size in pixels which might be different than the size of
> the window. [1]
> I believe we just need to use the framebuffer size for GL viewport and
> texture, by retrieving it with SDL_GL_GetDrawableSize.
>
> > What about non-gl display, Mouse motion, and display resize?
>
>  From what I can see by testing the SDL2 renderer, it seems to handle
> all of this transparently, so there is nothing we need to do in sdl2-2d.
>
> Same for mouse motion, which I believe is using window "screen
> coordinates".
>
> Display resize is a bit weird for a bunch of frames, but then it fixes
> itself.
>
> [0]
>
> https://user-images.githubusercontent.com/6058008/244368628-329241dc-267d=
-452f-b8ce-816ae1623131.png


I am using SDL2-2.26.3-1.fc38.x86_64 on wayland, and it doesn't have this
issue.

Your patch doesn't seem to change the behaviour.

Maybe there is something to investigate at SDL level instead.

btw, "allow hi-dpi" isn't a good description imho, since the guest still
doesn't receive real physical hi-dpi details of the client, and remains
scaled-up.


>
> [1] https://wiki.libsdl.org/SDL2/SDL_GetWindowSize#remarks
>
> >
> > thanks
> >
> > Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
> >> ---
> >>   ui/sdl2-gl.c | 4 ++--
> >>   ui/sdl2.c    | 2 +-
> >>   2 files changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
> >> index bbfa70eac3..251b7d56d6 100644
> >> --- a/ui/sdl2-gl.c
> >> +++ b/ui/sdl2-gl.c
> >> @@ -53,7 +53,7 @@ static void sdl2_gl_render_surface(struct sdl2_conso=
le
> >> *scon)
> >>       SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
> >>       sdl2_set_scanout_mode(scon, false);
> >>
> >> -    SDL_GetWindowSize(scon->real_window, &ww, &wh);
> >> +    SDL_GL_GetDrawableSize(scon->real_window, &ww, &wh);
> >>       surface_gl_setup_viewport(scon->gls, scon->surface, ww, wh);
> >>
> >>       surface_gl_render_texture(scon->gls, scon->surface);
> >> @@ -239,7 +239,7 @@ void sdl2_gl_scanout_flush(DisplayChangeListener
> *dcl,
> >>
> >>       SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
> >>
> >> -    SDL_GetWindowSize(scon->real_window, &ww, &wh);
> >> +    SDL_GL_GetDrawableSize(scon->real_window, &ww, &wh);
> >>       egl_fb_setup_default(&scon->win_fb, ww, wh);
> >>       egl_fb_blit(&scon->win_fb, &scon->guest_fb, !scon->y0_top);
> >>
> >> diff --git a/ui/sdl2.c b/ui/sdl2.c
> >> index 9d703200bf..c9c83815ca 100644
> >> --- a/ui/sdl2.c
> >> +++ b/ui/sdl2.c
> >> @@ -95,7 +95,7 @@ void sdl2_window_create(struct sdl2_console *scon)
> >>       }
> >>   #ifdef CONFIG_OPENGL
> >>       if (scon->opengl) {
> >> -        flags |=3D SDL_WINDOW_OPENGL;
> >> +        flags |=3D SDL_WINDOW_OPENGL | SDL_WINDOW_ALLOW_HIGHDPI;
> >>       }
> >>   #endif
> >>
> >> --
> >> 2.40.0
> >>
> >>
> >
>
> Cheers,
> Antonio
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000062827f05fdeb3e29
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Antonio<br></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 8, 2023 at 1:33=
=E2=80=AFPM Antonio Caggiano &lt;<a href=3D"mailto:quic_acaggian@quicinc.co=
m">quic_acaggian@quicinc.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">Hi Marc-Andr=C3=A9,<br>
<br>
On 07/06/2023 12:21, Marc-Andr=C3=A9 Lureau wrote:<br>
&gt; Hi Antonio<br>
&gt; <br>
&gt; On Wed, Jun 7, 2023 at 1:05=E2=80=AFPM Antonio Caggiano &lt;<a href=3D=
"mailto:quic_acaggian@quicinc.com" target=3D"_blank">quic_acaggian@quicinc.=
com</a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt;&gt; Add the SDL_WINDOW_ALLOW_HIGHDPI flag when creating a window and g=
et the<br>
&gt;&gt; drawable size instead of the window size when setting up the frame=
buffer<br>
&gt;&gt; and the viewport.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; What does this actually change?<br>
<br>
The sdl2-gl backend does not work properly on high-DPI windows. [0]<br>
My understanding is that by allowing high-DPI, SDL creates a framebuffer <b=
r>
with the right size in pixels which might be different than the size of <br=
>
the window. [1]<br>
I believe we just need to use the framebuffer size for GL viewport and <br>
texture, by retrieving it with SDL_GL_GetDrawableSize.<br>
<br>
&gt; What about non-gl display, Mouse motion, and display resize?<br>
<br>
=C2=A0From what I can see by testing the SDL2 renderer, it seems to handle =
<br>
all of this transparently, so there is nothing we need to do in sdl2-2d.<br=
>
<br>
Same for mouse motion, which I believe is using window &quot;screen coordin=
ates&quot;.<br>
<br>
Display resize is a bit weird for a bunch of frames, but then it fixes <br>
itself.<br>
<br>
[0] <br>
<a href=3D"https://user-images.githubusercontent.com/6058008/244368628-3292=
41dc-267d-452f-b8ce-816ae1623131.png" rel=3D"noreferrer" target=3D"_blank">=
https://user-images.githubusercontent.com/6058008/244368628-329241dc-267d-4=
52f-b8ce-816ae1623131.png</a></blockquote><div><br></div><div>I am using SD=
L2-2.26.3-1.fc38.x86_64 on wayland, and it doesn&#39;t have this issue.</di=
v><div><br></div><div>Your patch doesn&#39;t seem to change the behaviour.<=
/div><div><br></div><div>Maybe there is something to investigate at SDL lev=
el instead.</div><div><br></div><div>btw, &quot;allow hi-dpi&quot; isn&#39;=
t a good description imho, since the guest still doesn&#39;t receive real p=
hysical hi-dpi details of the client, and remains scaled-up.<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
[1] <a href=3D"https://wiki.libsdl.org/SDL2/SDL_GetWindowSize#remarks" rel=
=3D"noreferrer" target=3D"_blank">https://wiki.libsdl.org/SDL2/SDL_GetWindo=
wSize#remarks</a><br>
<br>
&gt; <br>
&gt; thanks<br>
&gt; <br>
&gt; Signed-off-by: Antonio Caggiano &lt;<a href=3D"mailto:quic_acaggian@qu=
icinc.com" target=3D"_blank">quic_acaggian@quicinc.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0ui/sdl2-gl.c | 4 ++--<br>
&gt;&gt;=C2=A0 =C2=A0ui/sdl2.c=C2=A0 =C2=A0 | 2 +-<br>
&gt;&gt;=C2=A0 =C2=A02 files changed, 3 insertions(+), 3 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c<br>
&gt;&gt; index bbfa70eac3..251b7d56d6 100644<br>
&gt;&gt; --- a/ui/sdl2-gl.c<br>
&gt;&gt; +++ b/ui/sdl2-gl.c<br>
&gt;&gt; @@ -53,7 +53,7 @@ static void sdl2_gl_render_surface(struct sdl2_c=
onsole<br>
&gt;&gt; *scon)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0SDL_GL_MakeCurrent(scon-&gt;real_window,=
 scon-&gt;winctx);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sdl2_set_scanout_mode(scon, false);<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 SDL_GetWindowSize(scon-&gt;real_window, &amp;ww, &a=
mp;wh);<br>
&gt;&gt; +=C2=A0 =C2=A0 SDL_GL_GetDrawableSize(scon-&gt;real_window, &amp;w=
w, &amp;wh);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0surface_gl_setup_viewport(scon-&gt;gls, =
scon-&gt;surface, ww, wh);<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0surface_gl_render_texture(scon-&gt;gls, =
scon-&gt;surface);<br>
&gt;&gt; @@ -239,7 +239,7 @@ void sdl2_gl_scanout_flush(DisplayChangeListen=
er *dcl,<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0SDL_GL_MakeCurrent(scon-&gt;real_window,=
 scon-&gt;winctx);<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 SDL_GetWindowSize(scon-&gt;real_window, &amp;ww, &a=
mp;wh);<br>
&gt;&gt; +=C2=A0 =C2=A0 SDL_GL_GetDrawableSize(scon-&gt;real_window, &amp;w=
w, &amp;wh);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0egl_fb_setup_default(&amp;scon-&gt;win_f=
b, ww, wh);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0egl_fb_blit(&amp;scon-&gt;win_fb, &amp;s=
con-&gt;guest_fb, !scon-&gt;y0_top);<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/ui/sdl2.c b/ui/sdl2.c<br>
&gt;&gt; index 9d703200bf..c9c83815ca 100644<br>
&gt;&gt; --- a/ui/sdl2.c<br>
&gt;&gt; +++ b/ui/sdl2.c<br>
&gt;&gt; @@ -95,7 +95,7 @@ void sdl2_window_create(struct sdl2_console *sco=
n)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;=C2=A0 =C2=A0#ifdef CONFIG_OPENGL<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (scon-&gt;opengl) {<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 flags |=3D SDL_WINDOW_OPENGL;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 flags |=3D SDL_WINDOW_OPENGL | SDL_WI=
NDOW_ALLOW_HIGHDPI;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;=C2=A0 =C2=A0#endif<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; 2.40.0<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; <br>
<br>
Cheers,<br>
Antonio<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--00000000000062827f05fdeb3e29--

