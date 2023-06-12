Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B28C72BA73
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 10:27:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8crv-0005kt-1q; Mon, 12 Jun 2023 04:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1q8crl-0005i4-NI
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 04:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1q8crj-0004mj-G2
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 04:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686558327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i6fd8F8HfN2+dWQEdbDBzN/Mvx2d4JZo0motWJvtsjM=;
 b=Y87EAbeb6KHSsNWp900XlIqF4cZ05xugfyNRmkingR29ltU9TOguvH0+FUMQBd4ehUSk13
 akORH68jrHrvmTEjqp+/fHS6Lmn+kT5bNH/XvqFtt/lT2h+1KD3OIPrTjsGYn6BA4Sxsfu
 +kxLnr6fXQvOaWIndRu16k+kDiM+MVc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-iT-Or84ZMDKL49lLZBTgtg-1; Mon, 12 Jun 2023 04:25:25 -0400
X-MC-Unique: iT-Or84ZMDKL49lLZBTgtg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b05b5a8c19so27550481fa.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 01:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686558323; x=1689150323;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i6fd8F8HfN2+dWQEdbDBzN/Mvx2d4JZo0motWJvtsjM=;
 b=VvmyN8E5TDjZVAhOfgumZEStuMdXggE5IN2bFX8zH+YmyjxYdP+SwDd+j+8vmWLpRc
 /3GXrEIpgP1WN5htkpa6AUEQ1syhNNdZgxZfSagDajTGl7e8Gu+s9QbFkE4LvGRw8DA2
 7lkNeQHhJrS/4BEEp3pvOZzByiTD49aQNKLQCoNdMFwGFBoCy4kAXK/eMmlPJTsrz+8C
 4pP6cYYtYN1I9ClKvY2N561bFWRiyUOVCKOJbm/Eiap5lJRwIzJl0C8A4MXD/2Zo+psX
 ZUnG435vak1GdjFxHQZtPInhKNpiDuW4G/p5/IDcE72tzKSOLzQbzQsQFps3Nf9IWBW6
 TA/w==
X-Gm-Message-State: AC+VfDyKI+iYMQ2m4aykd4v3z5+xFDSBKwsPlWKDsnFbNLP8JQ1mqLiQ
 HgCCiDgMGFj2Um99/x18w/BXeQOFKTMRK7t0T3/fE8rhENX6QGW4OraNYqKQzZ1blSlY9FqRNdE
 8rrAAY+gtDkjb1MbE6UCfgCdWujHHhPOWIpsBHbEzeQ==
X-Received: by 2002:a2e:3207:0:b0:2af:1944:3913 with SMTP id
 y7-20020a2e3207000000b002af19443913mr1989319ljy.37.1686558323206; 
 Mon, 12 Jun 2023 01:25:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ElZft1iv3qM19LZhD61MI9Y100TJ1JTLPJMXa7VTjurOkGpydJmuIdhekSPALS18lpAi4Gsx06BSNanDTQ+Y=
X-Received: by 2002:a2e:3207:0:b0:2af:1944:3913 with SMTP id
 y7-20020a2e3207000000b002af19443913mr1989306ljy.37.1686558322829; Mon, 12 Jun
 2023 01:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230609140752.69758-1-quic_acaggian@quicinc.com>
In-Reply-To: <20230609140752.69758-1-quic_acaggian@quicinc.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 12 Jun 2023 10:25:08 +0200
Message-ID: <CAMxuvaxtXA73nbvuWOBdo=Ve93XJ1yhpi5i64J7YyyTa2BEHGQ@mail.gmail.com>
Subject: Re: [PATCH v3] ui/sdl2: OpenGL window context
To: Antonio Caggiano <quic_acaggian@quicinc.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b9c36105fdea7516"
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

--000000000000b9c36105fdea7516
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Antonio

On Fri, Jun 9, 2023 at 4:08=E2=80=AFPM Antonio Caggiano <quic_acaggian@quic=
inc.com>
wrote:

> When OpenGL is enabled, create only the OpenGL context, ignoring the SDL
> renderer as it is unused anyway.
>
> Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
> ---
> v2: There is no need to specify major and minor version if the SDL
> renderer is
>     not created. Also, tested on Windows.
> v3: Completely messed up the commit, now fixed.
>
>  ui/sdl2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index 9d703200bf..82e6ee5511 100644
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
> --
> 2.40.0
>

sdl2_window_destroy() should still be updated to avoid calling Destroy
functions with NULL arguments. (we don't check the return value, but it's
being checked by SDL)

--000000000000b9c36105fdea7516
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Antonio<br></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 9, 2023 at 4:08=
=E2=80=AFPM Antonio Caggiano &lt;<a href=3D"mailto:quic_acaggian@quicinc.co=
m">quic_acaggian@quicinc.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">When OpenGL is enabled, create only the OpenGL =
context, ignoring the SDL<br>
renderer as it is unused anyway.<br>
<br>
Signed-off-by: Antonio Caggiano &lt;<a href=3D"mailto:quic_acaggian@quicinc=
.com" target=3D"_blank">quic_acaggian@quicinc.com</a>&gt;<br>
---<br>
v2: There is no need to specify major and minor version if the SDL renderer=
 is<br>
=C2=A0 =C2=A0 not created. Also, tested on Windows.<br>
v3: Completely messed up the commit, now fixed.<br>
<br>
=C2=A0ui/sdl2.c | 6 +++---<br>
=C2=A01 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/ui/sdl2.c b/ui/sdl2.c<br>
index 9d703200bf..82e6ee5511 100644<br>
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
-- <br>
2.40.0<br></blockquote><div><br></div><div>sdl2_window_destroy() should sti=
ll be updated to avoid calling Destroy functions with NULL arguments. (we d=
on&#39;t check the return value, but it&#39;s being checked by SDL)=C2=A0 <=
br></div></div></div>

--000000000000b9c36105fdea7516--


