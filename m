Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 825637A8C08
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:49:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj2Fw-0002Ze-Go; Wed, 20 Sep 2023 14:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj2Fu-0002ZU-LG
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:48:58 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj2Fs-0005zS-Pz
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:48:58 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-503065c4b25so304132e87.1
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 11:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695235735; x=1695840535;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WhEhXfjBaQ3Og08qaOMhvnuC7/u0T5RnYHxRc7S6uc0=;
 b=UlHU6PUSRk+jm092X1UjiSlWlL5SaQ6DcY3CZBwL8ckqzAC98f8QuZhbgOHEUe5YSw
 0CiD9ARc9Ly3m3Vp4VvLd/rLWl9TUfTP8364spbgcKAMzMYtnPekBFVzLOu2ZXGa9Rvb
 +OM1gnwKHjTOJVE8BKQV3HJSsMs1teQkz7Gw0cxYd60csu6oyy5++Ur5J3bfKLxOfEut
 w1R9FwJSVh33b29uSRqCik8Uh/cKieMWHQAnM6pw5QqN/zK05CaZ8FBulN0BNfqm2Lbc
 pXBGPeYbChvfL7nmlAt+wGm5NUhnC/QjbexKpW8FDHJTVkiFJO/n5duS5IDSDzAumliO
 ZJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695235735; x=1695840535;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WhEhXfjBaQ3Og08qaOMhvnuC7/u0T5RnYHxRc7S6uc0=;
 b=CQeIq9xLbWxgHfHwmz9snXbIXacrYQJnrZ3HmH5B8rZtVBk6RZhju0YlGDrp+TPUHm
 4hnOc3zi9b7bi9R0O/yCkg6ULIyI/9yZiUpQwu/6gAsQZ71ESndG+wAgfwfPUw4ENi0X
 lVL3wFCtFJXzlrbzFgZ3wJRFWna7NXGGst8tEtUSAVhPcI/3D0RK/6PysEfnOaA82wbL
 EclhnZkCDw6YZiZD7+9Vu1Q/UQvNzzJiSHT7JH3eWaJSGV591kA7E5VHm/5X55O1jgE7
 +yI1gABZJ9jgM60G2qSkxAmDvoPEi2WdJhQ1JTdKyiAn22shmIAndEuFY58rYpabjVHn
 SLZA==
X-Gm-Message-State: AOJu0YyYxmDDpR+UsorlFg24gjCrp6jGSvBkx/hj4KW6GHofPb7X2BPA
 4YUL1XPdWnnHASGf0s29ghwL/CS66+fR29VBDEPX3Q==
X-Google-Smtp-Source: AGHT+IGRL8AkamBWLOY2jVjaw4AVLTTEmUftk0qvEz5GVLYedR0HBO0BRTzgPP8Sq6E9hgBUm5te+x8QRP+8iWqk61U=
X-Received: by 2002:a05:6512:3c85:b0:503:18c3:d87a with SMTP id
 h5-20020a0565123c8500b0050318c3d87amr4036800lfv.21.1695235734778; Wed, 20 Sep
 2023 11:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
 <20230917213803.20683-19-kariem.taha2.7@gmail.com>
In-Reply-To: <20230917213803.20683-19-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 20 Sep 2023 19:48:43 +0100
Message-ID: <CANCZdfqGyqWPYk-RS47RByNpo-hLe3wdOe3rRpeNSqJZ6DT-0g@mail.gmail.com>
Subject: Re: [PATCH v2 18/28] bsd-user: Implement getpriority(2) and
 setpriority(2).
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000c850fb0605ced33b"
Received-SPF: none client-ip=2a00:1450:4864:20::12c;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x12c.google.com
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

--000000000000c850fb0605ced33b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 10:39=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.c=
om>
wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/bsd-proc.h           | 24 ++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |  8 ++++++++
>  2 files changed, 32 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

Looks right to my eye.  Let's see if Richard catches anything.



> diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
> index fff1d4cded..89792d26c6 100644
> --- a/bsd-user/bsd-proc.h
> +++ b/bsd-user/bsd-proc.h
> @@ -390,4 +390,28 @@ static inline abi_long do_bsd_ptrace(abi_long arg1,
> abi_long arg2,
>      return -TARGET_ENOSYS;
>  }
>
> +/* getpriority(2) */
> +static inline abi_long do_bsd_getpriority(abi_long which, abi_long who)
> +{
> +    abi_long ret;
> +    /*
> +     * Note that negative values are valid for getpriority, so we must
> +     * differentiate based on errno settings.
> +     */
> +    errno =3D 0;
> +    ret =3D getpriority(which, who);
> +    if (ret =3D=3D -1 && errno !=3D 0) {
> +        return -host_to_target_errno(errno);
> +    }
> +
> +    return ret;
> +}
> +
> +/* setpriority(2) */
> +static inline abi_long do_bsd_setpriority(abi_long which, abi_long who,
> +                                          abi_long prio)
> +{
> +    return get_errno(setpriority(which, who, prio));
> +}
> +
>  #endif /* !BSD_PROC_H_ */
> diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.=
c
> index 1a760b1380..71a2657dd0 100644
> --- a/bsd-user/freebsd/os-syscall.c
> +++ b/bsd-user/freebsd/os-syscall.c
> @@ -359,6 +359,14 @@ static abi_long freebsd_syscall(void *cpu_env, int
> num, abi_long arg1,
>          ret =3D do_bsd_ptrace(arg1, arg2, arg3, arg4);
>          break;
>
> +    case TARGET_FREEBSD_NR_getpriority: /* getpriority(2) */
> +        ret =3D do_bsd_getpriority(arg1, arg2);
> +        break;
> +
> +    case TARGET_FREEBSD_NR_setpriority: /* setpriority(2) */
> +        ret =3D do_bsd_setpriority(arg1, arg2, arg3);
> +        break;
> +
>
>          /*
>           * File system calls.
> --
> 2.42.0
>
>

--000000000000c850fb0605ced33b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 17, 2023 at 10:39=E2=80=
=AFPM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.tah=
a2.7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-proc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 24 ++++=
++++++++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 8 ++++++++<br>
=C2=A02 files changed, 32 insertions(+)<br></blockquote><div><br></div><div=
>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.=
com</a>&gt;</div><div><br></div><div>Looks right to my eye.=C2=A0 Let&#39;s=
 see if Richard catches anything.</div><div><br></div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h<br>
index fff1d4cded..89792d26c6 100644<br>
--- a/bsd-user/bsd-proc.h<br>
+++ b/bsd-user/bsd-proc.h<br>
@@ -390,4 +390,28 @@ static inline abi_long do_bsd_ptrace(abi_long arg1, ab=
i_long arg2,<br>
=C2=A0 =C2=A0 =C2=A0return -TARGET_ENOSYS;<br>
=C2=A0}<br>
<br>
+/* getpriority(2) */<br>
+static inline abi_long do_bsd_getpriority(abi_long which, abi_long who)<br=
>
+{<br>
+=C2=A0 =C2=A0 abi_long ret;<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Note that negative values are valid for getpriority,=
 so we must<br>
+=C2=A0 =C2=A0 =C2=A0* differentiate based on errno settings.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 errno =3D 0;<br>
+=C2=A0 =C2=A0 ret =3D getpriority(which, who);<br>
+=C2=A0 =C2=A0 if (ret =3D=3D -1 &amp;&amp; errno !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -host_to_target_errno(errno);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+/* setpriority(2) */<br>
+static inline abi_long do_bsd_setpriority(abi_long which, abi_long who,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a=
bi_long prio)<br>
+{<br>
+=C2=A0 =C2=A0 return get_errno(setpriority(which, who, prio));<br>
+}<br>
+<br>
=C2=A0#endif /* !BSD_PROC_H_ */<br>
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c<=
br>
index 1a760b1380..71a2657dd0 100644<br>
--- a/bsd-user/freebsd/os-syscall.c<br>
+++ b/bsd-user/freebsd/os-syscall.c<br>
@@ -359,6 +359,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num=
, abi_long arg1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D do_bsd_ptrace(arg1, arg2, arg3, a=
rg4);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
+=C2=A0 =C2=A0 case TARGET_FREEBSD_NR_getpriority: /* getpriority(2) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_bsd_getpriority(arg1, arg2);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case TARGET_FREEBSD_NR_setpriority: /* setpriority(2) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_bsd_setpriority(arg1, arg2, arg3);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * File system calls.<br>
-- <br>
2.42.0<br>
<br>
</blockquote></div></div>

--000000000000c850fb0605ced33b--

