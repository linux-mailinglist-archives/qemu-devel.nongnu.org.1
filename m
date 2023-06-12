Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 090F572BB81
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 11:02:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8dQH-0002Vm-Gl; Mon, 12 Jun 2023 05:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q8dQD-0002VZ-GF
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 05:01:09 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q8dQA-0002GW-Br
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 05:01:09 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4f63a2e1c5fso4736760e87.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 02:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686560464; x=1689152464;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZMUzECyv4IH5ccJvf0b3uHZ2DwkJy53EP3Pw0iCo9y8=;
 b=pUVfOJ+7KEt5snwCRYx7RVfPPw2SRSV8xo7+RAukpsGdpDtpn1Ji/2UsLYlZnKI1CP
 Wdb2g2p5u00agkdijkm9zZWDDc3lCXYjFje4uqfPm5rmxVXgsrl4Nsn59Gzg+m4RBMtz
 RDaCDxhkIE2aBm9sZ8wlBdQgCT1HL1xAKrqPIHA3Chquykt6kLN5mhXxuWYAQEIB2Cdq
 SHTVFoQL/sKdLyI3FKQKSNArTEkOUqmXAVGhgguejIG5D0WSQPiNpmIww2iqLzTaOR0j
 lgScLA1Sg904dsEc7Thr4RunCnaVE5pUMUwr2MxK6Kdsd6fNC++nKtAZRpdLAfpwadS7
 vkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686560464; x=1689152464;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZMUzECyv4IH5ccJvf0b3uHZ2DwkJy53EP3Pw0iCo9y8=;
 b=OcvviiIWAoKtzB0Fwv/I7Ey3+AlLP7OZcEjscSNXrj+xuJdv6zN8gslfTlffAL6oYn
 p4kygzHLyZZzQubxa73ZyJtSouT9DhSliHEYLqk3AnuExkyp2HDKt+oD39F/3IYzl+x7
 /2i0ecRGg5oF1Kj2i/8/JhH7g64WKDwL6XMBe7jbYwTpdo2OTikmnO2GDu2AVk+rUbJb
 XrWz9Fi4QxdMc3i59L9i7BbFHWc47cNbXb6Si9QrJV8WNLhrwvtIoVNHBEMlGFuDvmZZ
 l4bDkkfLpj4uMsFARe8Qk4qf2RRVtXp9E4CWxRo9qaAmTExv0OP4zirQVnpHc1/gRfjQ
 JZ5Q==
X-Gm-Message-State: AC+VfDx5EQ4H2/uwYupK0EU0YKihFm8vq0TC82GNpMaoclfARhrxbTCY
 wfLoYKKUxumtbDRwWx3nLN9AYaEHmyJodo5mYoU=
X-Google-Smtp-Source: ACHHUZ75ksbTp34Trg8tN5NEVd+W95CzADFvV0jxYX2VnSM+2gMWAS5dWontGTw2m/+IC4W+OKJ9U1r+JIXiYmAdUrk=
X-Received: by 2002:a05:651c:104:b0:2b1:e501:99a5 with SMTP id
 a4-20020a05651c010400b002b1e50199a5mr2399600ljb.36.1686560464256; Mon, 12 Jun
 2023 02:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230608145512.25970-1-akihiko.odaki@daynix.com>
In-Reply-To: <20230608145512.25970-1-akihiko.odaki@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 12 Jun 2023 11:00:49 +0200
Message-ID: <CAJ+F1CKZ4h8r-G9UoWnawWSxGNfoCQqzd7hxMWWRJJ=bJ875JQ@mail.gmail.com>
Subject: Re: [PATCH] sdl2: Check if window exists before updating it
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Antonio Caggiano <quic_acaggian@quicinc.com>, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005d427805fdeaf514"
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-lf1-x12f.google.com
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

--0000000000005d427805fdeaf514
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Jun 8, 2023 at 4:56=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com>
wrote:

> A console does not have a window if the surface is a placeholder and
> the console is not the first one. sdl2 cannot update the texture in
> such a case.
>
> Add a proper check for window existence. Such a check is only necessary
> for the "gl" implementation as the "2d" implementation checks for the
> texture, which is set only if a window exists.
>
> Fixes: c821a58ee7 ("ui/console: Pass placeholder surface to displays")
> Reported-by: Antonio Caggiano <quic_acaggian@quicinc.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>


Unless I am mistaken, this is fixed in git already:
commit b3a654d82ecf276b59a67b2fd688e11a0d8a0064
Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Date:   Thu May 11 11:42:17 2023 +0400

    ui/sdl2: fix surface_gl_update_texture: Assertion 'gls' failed

thanks

---
>  ui/sdl2-gl.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
> index 39cab8cde7..bbfa70eac3 100644
> --- a/ui/sdl2-gl.c
> +++ b/ui/sdl2-gl.c
> @@ -67,6 +67,10 @@ void sdl2_gl_update(DisplayChangeListener *dcl,
>
>      assert(scon->opengl);
>
> +    if (!scon->real_window) {
> +        return;
> +    }
> +
>      SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
>      surface_gl_update_texture(scon->gls, scon->surface, x, y, w, h);
>      scon->updates++;
> --
> 2.40.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000005d427805fdeaf514
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 8, 2023 at 4:56=E2=80=
=AFPM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko=
.odaki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">A console does not have a window if the surface is a place=
holder and<br>
the console is not the first one. sdl2 cannot update the texture in<br>
such a case.<br>
<br>
Add a proper check for window existence. Such a check is only necessary<br>
for the &quot;gl&quot; implementation as the &quot;2d&quot; implementation =
checks for the<br>
texture, which is set only if a window exists.<br>
<br>
Fixes: c821a58ee7 (&quot;ui/console: Pass placeholder surface to displays&q=
uot;)<br>
Reported-by: Antonio Caggiano &lt;<a href=3D"mailto:quic_acaggian@quicinc.c=
om" target=3D"_blank">quic_acaggian@quicinc.com</a>&gt;<br>
Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com=
" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br></blockquote><div><=
br></div><div><br></div><div>Unless I am mistaken, this is fixed in git alr=
eady:</div><div>commit b3a654d82ecf276b59a67b2fd688e11a0d8a0064<br>Author: =
Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">m=
arcandre.lureau@redhat.com</a>&gt;<br>Date: =C2=A0 Thu May 11 11:42:17 2023=
 +0400<br><br>=C2=A0 =C2=A0 ui/sdl2: fix surface_gl_update_texture: Asserti=
on &#39;gls&#39; failed</div><div><br></div><div>thanks<br></div><div><br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0ui/sdl2-gl.c | 4 ++++<br>
=C2=A01 file changed, 4 insertions(+)<br>
<br>
diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c<br>
index 39cab8cde7..bbfa70eac3 100644<br>
--- a/ui/sdl2-gl.c<br>
+++ b/ui/sdl2-gl.c<br>
@@ -67,6 +67,10 @@ void sdl2_gl_update(DisplayChangeListener *dcl,<br>
<br>
=C2=A0 =C2=A0 =C2=A0assert(scon-&gt;opengl);<br>
<br>
+=C2=A0 =C2=A0 if (!scon-&gt;real_window) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0SDL_GL_MakeCurrent(scon-&gt;real_window, scon-&gt;winct=
x);<br>
=C2=A0 =C2=A0 =C2=A0surface_gl_update_texture(scon-&gt;gls, scon-&gt;surfac=
e, x, y, w, h);<br>
=C2=A0 =C2=A0 =C2=A0scon-&gt;updates++;<br>
-- <br>
2.40.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--0000000000005d427805fdeaf514--

