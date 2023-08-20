Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04404781C63
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 06:28:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXa2x-0003DP-0P; Sun, 20 Aug 2023 00:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXa2t-0003D7-Fo
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:28:11 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXa2r-0007y6-57
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:28:11 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-528913c261bso2470505a12.1
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 21:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692505687; x=1693110487;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7ATmYGH7IVj+M0otAm2dDd0UIyd/0wD+pjdugJ0i6eo=;
 b=SDvoUOuwOJvQinSihqMHisi0niElmAd4apA0RGLi0YoPwA2gXMx+AUsbEvRpoyoxwh
 WRYoeWMmQjHpddAsYUiUnr5oHKbHUBy1fpDH1WuOGBFK1vTfbDtPYEdY6CYVauWv/t7H
 DRBYL9MlPzH1lrJKazmqwTv2KqJOebBQVAh0+Og47k2jlru8ndlkBIeUeRBhW+9cvYMa
 /Vtwd74rMRWpw7QaH5XM/2qQ48WoACpdSNlTLC+OiQw6nrJosEoqBCK+lg7+J2CS/Ael
 g/DVNQHztNqAR3xXaBB16T27kLZ5caUfe8OMQOeJ7a+chMW1/fClOUWQMvNqvqtSlbZy
 +Z5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692505687; x=1693110487;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7ATmYGH7IVj+M0otAm2dDd0UIyd/0wD+pjdugJ0i6eo=;
 b=abk2pGKzMWYKZbcT19isrUpCaALwEH4X8Usn0gFQugdk2yOGFd4/HaPyIlxJEWHX2S
 I6Ga4kPuF85BbSLg9rrwdBDht3/1dSNN/994hWtECzrLaY3czZoRMD6E7K/aubLm7M/x
 sqnmdbG5zTUBGOr5JgW/egSxqx40qyqHSayt/oGG1IBIzZ6yjjwRczbZmzC9O5pLSSD4
 RbCT5cmhsh0oFXRJLgk/SAmLAcGPfCFq8xXV2f9m0AZsiLNqVW6YLP+UZGoNbizwD1zC
 9JQfBybXJAZ5cqEuaWAViNBp97hQsHNm7Q9A5do3F/hHsSTcRAvHwm3Zr4VXBQBg/9Tu
 5NKw==
X-Gm-Message-State: AOJu0Yx/2gptWZBhsjh42tP6udPgmq4/zPnVbBdLVRV4AwmbFrEiSDAW
 oPAlMkqzwJCwRKY6q/m5fATnzvO2xKG8VUiLlRhFaA==
X-Google-Smtp-Source: AGHT+IGSSJjj6F8SSs//9yfe/6AH9oZNtMxVz6JLmes1U7vrqJqH7X6Vl5v5guOhITUWUhQhu8QMqJnCIPeejgqi6Fg=
X-Received: by 2002:aa7:cb8f:0:b0:527:fa8d:d40b with SMTP id
 r15-20020aa7cb8f000000b00527fa8dd40bmr2350829edt.26.1692505687425; Sat, 19
 Aug 2023 21:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-14-kariem.taha2.7@gmail.com>
In-Reply-To: <20230819094806.14965-14-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Aug 2023 22:28:00 -0600
Message-ID: <CANCZdfr8TmgFL2UMZ1ptV_Sxf+8urjyc4p5ObwzrTCHQTfaQZg@mail.gmail.com>
Subject: Re: [PATCH 13/22] Implement mprotect(2)
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000047949e0603533082"
Received-SPF: none client-ip=2a00:1450:4864:20::536;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--00000000000047949e0603533082
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 19, 2023 at 3:49=E2=80=AFAM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/bsd-mem.h            | 7 +++++++
>  bsd-user/freebsd/os-syscall.c | 4 ++++
>  2 files changed, 11 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>


> diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
> index 057c995a6e..a6446a454c 100644
> --- a/bsd-user/bsd-mem.h
> +++ b/bsd-user/bsd-mem.h
> @@ -82,4 +82,11 @@ static inline abi_long do_bsd_munmap(abi_long arg1,
> abi_long arg2)
>      return get_errno(target_munmap(arg1, arg2));
>  }
>
> +/* mprotect(2) */
> +static inline abi_long do_bsd_mprotect(abi_long arg1, abi_long arg2,
> +        abi_long arg3)
> +{
> +    return get_errno(target_mprotect(arg1, arg2, arg3));
> +}
> +
>  #endif /* BSD_USER_BSD_MEM_H */
> diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.=
c
> index 3525d39d7b..aea4e337ff 100644
> --- a/bsd-user/freebsd/os-syscall.c
> +++ b/bsd-user/freebsd/os-syscall.c
> @@ -495,6 +495,10 @@ static abi_long freebsd_syscall(void *cpu_env, int
> num, abi_long arg1,
>          ret =3D do_bsd_munmap(arg1, arg2);
>          break;
>
> +    case TARGET_FREEBSD_NR_mprotect: /* mprotect(2) */
> +        ret =3D do_bsd_mprotect(arg1, arg2, arg3);
> +        break;
> +
>  #if defined(__FreeBSD_version) && __FreeBSD_version >=3D 1300048
>      case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
>          ret =3D do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
> --
> 2.40.0
>
>

--00000000000047949e0603533082
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Aug 19, 2023 at 3:49=E2=80=AF=
AM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.taha2.=
7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 7 +++++=
++<br>
=C2=A0bsd-user/freebsd/os-syscall.c | 4 ++++<br>
=C2=A02 files changed, 11 insertions(+)<br></blockquote><div><br></div><div=
>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.=
com</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h<br>
index 057c995a6e..a6446a454c 100644<br>
--- a/bsd-user/bsd-mem.h<br>
+++ b/bsd-user/bsd-mem.h<br>
@@ -82,4 +82,11 @@ static inline abi_long do_bsd_munmap(abi_long arg1, abi_=
long arg2)<br>
=C2=A0 =C2=A0 =C2=A0return get_errno(target_munmap(arg1, arg2));<br>
=C2=A0}<br>
<br>
+/* mprotect(2) */<br>
+static inline abi_long do_bsd_mprotect(abi_long arg1, abi_long arg2,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_long arg3)<br>
+{<br>
+=C2=A0 =C2=A0 return get_errno(target_mprotect(arg1, arg2, arg3));<br>
+}<br>
+<br>
=C2=A0#endif /* BSD_USER_BSD_MEM_H */<br>
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c<=
br>
index 3525d39d7b..aea4e337ff 100644<br>
--- a/bsd-user/freebsd/os-syscall.c<br>
+++ b/bsd-user/freebsd/os-syscall.c<br>
@@ -495,6 +495,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num=
, abi_long arg1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D do_bsd_munmap(arg1, arg2);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
+=C2=A0 =C2=A0 case TARGET_FREEBSD_NR_mprotect: /* mprotect(2) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_bsd_mprotect(arg1, arg2, arg3);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
=C2=A0#if defined(__FreeBSD_version) &amp;&amp; __FreeBSD_version &gt;=3D 1=
300048<br>
=C2=A0 =C2=A0 =C2=A0case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D do_freebsd_shm_open2(arg1, arg2, =
arg3, arg4, arg5);<br>
-- <br>
2.40.0<br>
<br>
</blockquote></div></div>

--00000000000047949e0603533082--

