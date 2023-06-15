Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CDE7315F9
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 12:59:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9kgJ-0006R5-89; Thu, 15 Jun 2023 06:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1q9kgG-0006Qr-LU
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 06:58:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1q9kgE-0000PQ-RE
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 06:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686826697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7th6PkipmyJZQoN8VJmVMRkViIKKOVVQFHt78dCE+jU=;
 b=Tg7VhzcmUGLnlIWUpxNEDoccCTWVMXwJVTDFnjLrZD+l/I8xHiRVIhBn4FckAfSmlO/Kli
 bl7qS4UVcyAwM2TEU5Xn0hMzvDGXyhMD1vSG8YtYEZvQGFC1zTqHHYtYjqmzWN+SR97PLI
 /I21nmW087x3IeHmZ2CeNc6bqCAV/9M=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-K5UVIiknMFyjnUlLIUNoPA-1; Thu, 15 Jun 2023 06:58:15 -0400
X-MC-Unique: K5UVIiknMFyjnUlLIUNoPA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4f5847463baso6605958e87.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jun 2023 03:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686826693; x=1689418693;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7th6PkipmyJZQoN8VJmVMRkViIKKOVVQFHt78dCE+jU=;
 b=WflWYRXOIZzhiblvOP/t0LZzxAmHI8dabloQOOMznoStX1BJBvRFsUbLt8HWfDoJoL
 azgrQFDT8k0wRc7wMA8ccu6bJ42933T3HG5oyh/lcyTcwOVYwFEjyaPJ40ce4OEpeWWk
 M80WR0SlFMQoBIswb2Xj4VsfVawAGhb4JWvCeqIDDg4729EnwhAG69uPiY1vVV+qgHTg
 gVNUFOY3fVp6UfijVzK4m/LYJP/hLBI5R45P5P+T5rRAAz+5zMDE/wK5IbbyUcbbT2bG
 Z8Fyn2AkiJJ6+G0+mjsSrL5oXwu5q9wg7gGcwahdzmC4bnun2HnI63W4h6T4e4nGy47C
 RUXA==
X-Gm-Message-State: AC+VfDzred4m58U6Dr+Tm85hxwGWouoJ15NVBHuJg4QqvXoqR1t4vBwx
 Vi76EXyc4fufQKpD4tnY43jyNnuopLGkMBMIt65CIZxpidk0X7o3w5oBknzQ0A3MfA4CUqIO1Jj
 vlG6nr3Fj4gn6OX7SwiF/6YH+Pi8lMjPeHqcAKdc=
X-Received: by 2002:a2e:874a:0:b0:2b4:473e:8cbc with SMTP id
 q10-20020a2e874a000000b002b4473e8cbcmr718834ljj.52.1686826693500; 
 Thu, 15 Jun 2023 03:58:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6WLGrNsFw/Ov2ltg2ZhWk+uvkUMYxPm85ov6Suxi2Mt1DQ9KLIhqZykYQZcr22y2jAjhgK9wkzW5qXNmSBciI=
X-Received: by 2002:a2e:874a:0:b0:2b4:473e:8cbc with SMTP id
 q10-20020a2e874a000000b002b4473e8cbcmr718818ljj.52.1686826693008; Thu, 15 Jun
 2023 03:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_8DA57B405D427A560FD40F8FB0C0B1ADDE09@qq.com>
In-Reply-To: <tencent_8DA57B405D427A560FD40F8FB0C0B1ADDE09@qq.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 15 Jun 2023 12:57:55 +0200
Message-ID: <CAMxuvawc2x2mt4Kk4V1U0fMeNKZj5qE_Lai8Gjo38T_Q_cVdpQ@mail.gmail.com>
Subject: Re: [PATCH] chardev/char-win-stdio: Support VT sequences on Windows
 11 host
To: Zhang Huasen <huasenzhang@foxmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d5b8b505fe28f140"
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

--000000000000d5b8b505fe28f140
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Jun 15, 2023 at 12:36=E2=80=AFPM Zhang Huasen <huasenzhang@foxmail.=
com>
wrote:

> If the monitor or the serial port use STDIO as backend on Windows 11 host=
,
> e.g. -nographic options is used, the monitor or the guest Linux do not
> response to arrow keys.
>
> When Windows creates a console, ENABLE_VIRTUAL_PROCESS_INPUT is disabled
> by default. Arrow keys cannot be retrieved by ReadFile or ReadConsoleInpu=
t
> functions.
>
> Add ENABLE_VIRTUAL_PROCESS_INPUT to the flag which is passed to
> SetConsoleMode,
> when opening stdio console.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1674
>
> Signed-off-by: Zhang Huasen <huasenzhang@foxmail.com>
> ---
>  chardev/char-win-stdio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
> index eb830eabd9..1a18999e78 100644
> --- a/chardev/char-win-stdio.c
> +++ b/chardev/char-win-stdio.c
> @@ -190,7 +190,7 @@ static void qemu_chr_open_stdio(Chardev *chr,
>          }
>      }
>
> -    dwMode |=3D ENABLE_LINE_INPUT;
> +    dwMode |=3D ENABLE_LINE_INPUT | ENABLE_VIRTUAL_TERMINAL_INPUT;
>

I think we should set it only when is_console (although that may not make a
difference otherwise)

thanks


>      if (is_console) {
>          /* set the terminal in raw mode */
> --
> 2.41.0.windows.1
>
>

--000000000000d5b8b505fe28f140
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 15, 2023 at 12:36=E2=80=
=AFPM Zhang Huasen &lt;<a href=3D"mailto:huasenzhang@foxmail.com">huasenzha=
ng@foxmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">If the monitor or the serial port use STDIO as backend on Win=
dows 11 host,<br>
e.g. -nographic options is used, the monitor or the guest Linux do not<br>
response to arrow keys.<br>
<br>
When Windows creates a console, ENABLE_VIRTUAL_PROCESS_INPUT is disabled<br=
>
by default. Arrow keys cannot be retrieved by ReadFile or ReadConsoleInput<=
br>
functions.<br>
<br>
Add ENABLE_VIRTUAL_PROCESS_INPUT to the flag which is passed to SetConsoleM=
ode,<br>
when opening stdio console.<br>
<br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/1674" re=
l=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/i=
ssues/1674</a><br>
<br>
Signed-off-by: Zhang Huasen &lt;<a href=3D"mailto:huasenzhang@foxmail.com" =
target=3D"_blank">huasenzhang@foxmail.com</a>&gt;<br>
---<br>
=C2=A0chardev/char-win-stdio.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c<br>
index eb830eabd9..1a18999e78 100644<br>
--- a/chardev/char-win-stdio.c<br>
+++ b/chardev/char-win-stdio.c<br>
@@ -190,7 +190,7 @@ static void qemu_chr_open_stdio(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 dwMode |=3D ENABLE_LINE_INPUT;<br>
+=C2=A0 =C2=A0 dwMode |=3D ENABLE_LINE_INPUT | ENABLE_VIRTUAL_TERMINAL_INPU=
T;<br></blockquote><div><br></div><div>I think we should set it only when i=
s_console (although that may not make a difference otherwise) <br></div><di=
v><br></div><div>thanks</div><div><br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0if (is_console) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* set the terminal in raw mode */<br>
-- <br>
2.41.0.windows.1<br>
<br>
</blockquote></div></div>

--000000000000d5b8b505fe28f140--


