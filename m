Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 883187181FE
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:34:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LxP-0007pJ-6J; Wed, 31 May 2023 09:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q4LxG-0007lM-T4; Wed, 31 May 2023 09:33:35 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q4LxF-0006RZ-6f; Wed, 31 May 2023 09:33:34 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2af2e1725bdso12561261fa.0; 
 Wed, 31 May 2023 06:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685539991; x=1688131991;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J1RytyhQ0oV637TaHLX45YBZhp6cUmV18ZaxLVemerc=;
 b=US2RdHlHtcraNgsO5biVvXnnErLRmd9JJdV0l7g4JuC17r48pg6/6cE0prELOj5E3u
 yT7LxVVbTBS9geUIRRLAynmm0UJeAvpPtX9HfDlvLAqJfX5iuxtv5si3SD+bo84Jorjk
 1pKT0nLz5Os3JhX0tyg3aAWLaZ2osj21Y0bHaaWv97YSEQoQCmMH02kKyWb3x9DcAB15
 B6oy5xLsuq77Wda10n4//ARvLzV6wGkwy2sOYobig/FIvBWw3CPDtXe614nR+njHE3lF
 udqwvocTdzfCI1XZOnMtXG2h3BfG40xzTCKz9Ho2agFqmvjzo+Xhso5DJqA+93L0nlh6
 +vLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685539991; x=1688131991;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J1RytyhQ0oV637TaHLX45YBZhp6cUmV18ZaxLVemerc=;
 b=BijxdknM71h6m7OpW4oVnmtuXf8HYJDIXr1ZZVjn4zjsTSRyBsps44EXLJ2MiXbHRK
 7iaiOK0TmyUTC4iFGCC1n5WhZh0hLd71KRNAb8QONB+8OYo4c6YjArnSl9vD59312Grn
 QQcCTopbz2dHQqCcALERtDgwV/nys12gQ4DB3o8wyjCcpeTiea860YD/IEORu7EobXDW
 /MC24EGp10YePeEK0/PHC1PYMRSQLRk9vr7RyvKZkIqlX8omtbQ7ZZQDF0JmTbFg60L0
 KZ60SvO1Th31VLQr4QgBtYA0WOznGezRNrxf/HsLBFuhTI9Pyo09uN44YVL1oxwCeaZM
 Feiw==
X-Gm-Message-State: AC+VfDz9ZIZ0aJVzo3LDJ0Xdq4G2WANddIaq+vIgjBsrayyyTIDfyjYJ
 GzMX0D6Ekxg0OmwjJL/+rScEtaUAgYfq0YaiyH2SPI+vWNOhvg==
X-Google-Smtp-Source: ACHHUZ5j+j1+FS2H3h4lv/ilwLgucRUlSMhlJvKNPSVw97xTVyyXI/xHpfDMsiAqWhI25RI0iZ3VhANSr2LPR2rPvTQ=
X-Received: by 2002:a2e:9048:0:b0:2b0:721c:1a0e with SMTP id
 n8-20020a2e9048000000b002b0721c1a0emr1910193ljg.1.1685539991145; Wed, 31 May
 2023 06:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230531093902.70695-1-thuth@redhat.com>
In-Reply-To: <20230531093902.70695-1-thuth@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 31 May 2023 17:32:59 +0400
Message-ID: <CAJ+F1CKOxCE23UnN=1iT5oJqzNaWeN_wNXrCuAZU=VVE9xSCUQ@mail.gmail.com>
Subject: Re: [PATCH] meson.build: Use -Wno-undef only for SDL 2.0.8 and older
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-trivial@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000006d534c05fcfd5c81"
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-lj1-x22c.google.com
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

--0000000000006d534c05fcfd5c81
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2023 at 1:40=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:

> There is no need to disable this useful compiler warning for
> newer versions of the SDL anymore.
>
> This also enables the printing of the version number with
> newer versions of the SDL in the summary of the meson output
> again.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  meson.build | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index bc76ea96bf..8ccd928dca 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1273,10 +1273,12 @@ if not get_option('sdl').auto() or have_system
>    sdl_image =3D not_found
>  endif
>  if sdl.found()
> -  # work around 2.0.8 bug
> -  sdl =3D declare_dependency(compile_args: '-Wno-undef',
> -                           dependencies: sdl,
> -                           version: sdl.version())
> +  if sdl.version().version_compare('<=3D2.0.8')
> +    # work around 2.0.8 bug
> +    sdl =3D declare_dependency(compile_args: '-Wno-undef',
> +                             dependencies: sdl,
> +                             version: sdl.version())
> +  endif
>    sdl_image =3D dependency('SDL2_image', required: get_option('sdl_image=
'),
>                           method: 'pkg-config')
>  else
> --
> 2.31.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000006d534c05fcfd5c81
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 31, 2023 at 1:40=E2=80=AF=
PM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Ther=
e is no need to disable this useful compiler warning for<br>
newer versions of the SDL anymore.<br>
<br>
This also enables the printing of the version number with<br>
newer versions of the SDL in the summary of the meson output<br>
again.<br>
<br>
Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=
=3D"_blank">thuth@redhat.com</a>&gt;<br></blockquote><div><br></div><div>Re=
viewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0meson.build | 10 ++++++----<br>
=C2=A01 file changed, 6 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/meson.build b/meson.build<br>
index bc76ea96bf..8ccd928dca 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -1273,10 +1273,12 @@ if not get_option(&#39;sdl&#39;).auto() or have_sys=
tem<br>
=C2=A0 =C2=A0sdl_image =3D not_found<br>
=C2=A0endif<br>
=C2=A0if sdl.found()<br>
-=C2=A0 # work around 2.0.8 bug<br>
-=C2=A0 sdl =3D declare_dependency(compile_args: &#39;-Wno-undef&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0dependencies: sdl,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0version: sdl.version())<br>
+=C2=A0 if sdl.version().version_compare(&#39;&lt;=3D2.0.8&#39;)<br>
+=C2=A0 =C2=A0 # work around 2.0.8 bug<br>
+=C2=A0 =C2=A0 sdl =3D declare_dependency(compile_args: &#39;-Wno-undef&#39=
;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dependencies: sdl,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0version: sdl.version())<br>
+=C2=A0 endif<br>
=C2=A0 =C2=A0sdl_image =3D dependency(&#39;SDL2_image&#39;, required: get_o=
ption(&#39;sdl_image&#39;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 method: &#39;pkg-config&#39;)<br>
=C2=A0else<br>
-- <br>
2.31.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--0000000000006d534c05fcfd5c81--

