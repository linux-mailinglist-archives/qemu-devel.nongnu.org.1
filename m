Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C291781C65
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 06:37:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXaBn-00059n-Jx; Sun, 20 Aug 2023 00:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXaBl-00059e-A4
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:37:21 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXaBg-0001fd-6J
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:37:18 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-99c353a395cso288461766b.2
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 21:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692506234; x=1693111034;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UH4cTGWJ2yzN1PxtBgme1mfzW8YXhmONJLByWE6kanU=;
 b=Fniqm1ohOXV7A5BohXZL81EKr5ajNN9JOkRq38t+mef/BBhfgi/zhLuwGHOx5irq1K
 VZmiQufgOxMDOt/Z4b/6yxiMvgkcaarKgUWLBmpRn1yAtF7YmgdlQSLJO1yrGqksvA86
 WtF2AUpyZvDxYb7kWJKixj6+UgGuBjF4YpvR8fEWwnV5msnet7IgBnjyS+AZZb/iNgWw
 jYP2mGa5ur9SR8uiHHrdey6d8s25BX3B7aK9IcO9aDQgu5iaRanQ9Y3wlAxHE1hT045g
 9nHnd6MrgP/YuyRIBiuOEQMXpPbobq/c91yhWlSqmBImGtpGTWVmNre4HaIr3/bW8h78
 cARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692506234; x=1693111034;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UH4cTGWJ2yzN1PxtBgme1mfzW8YXhmONJLByWE6kanU=;
 b=jaX0LlhLcDU0jmYoiqDfaWwOWS+2vzdCQHJVYw5+V71ceog9vZLi4LD/d/6SNDnwWv
 cAe/8Jbjm59Zn8XQ0xujMKX1pbwSJP7q5UDYbtUfD3t1wASLyz30QrthoeMMuQQ6Neyb
 D14wly0GtNYOk80sqGt8Kb1zWVyn9qtZe5551z0kWzCUzIB8gl4hyCkOsWBmk1MQaWAu
 tw++Bl/N1kx8NnCV7y8snpo7YoDCWT9Kw2dAy1JdZrl4i2b94ORPhB9Er1OJqVWfvhpd
 Ul0GRjIAhFgQ6aInr3JYHhwe2z0KxY6Lg4GE8+SfOqTfOmrXWHkaOxk/uWXwHJp2MVsd
 UFPA==
X-Gm-Message-State: AOJu0Yx6WpkMeh5LzY4emh4AUqS4Q0I/6RjQWJaVmn+h7fbnBVOmaNbc
 pCoBKJ+83oN2iyIM39+174F7z9ACYeX4A198AYqu8Axa1lghIrLR
X-Google-Smtp-Source: AGHT+IHMVkrBe/s6d+dy3CqV6BLepQe9UVgmh7Te1L9HuhNctPpZP3dBQM6mRp6iaRTM9kGXqdrwROQekzjxUAy8aPI=
X-Received: by 2002:a17:906:3caa:b0:99d:f7f3:5218 with SMTP id
 b10-20020a1709063caa00b0099df7f35218mr2360410ejh.25.1692506234106; Sat, 19
 Aug 2023 21:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-16-kariem.taha2.7@gmail.com>
In-Reply-To: <20230819094806.14965-16-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Aug 2023 22:37:07 -0600
Message-ID: <CANCZdfoTq3oYL007soQTn-4XhtxchqBkWecUk6QiEOcTNMvoFA@mail.gmail.com>
Subject: Re: [PATCH 15/22] Implement mlock(2), munlock(2), mlockall(2),
 munlockall(2), madvise(2), minherit(2)
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000dd47e806035350fc"
Received-SPF: none client-ip=2a00:1450:4864:20::631;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x631.google.com
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

--000000000000dd47e806035350fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 19, 2023 at 3:49=E2=80=AFAM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/bsd-mem.h            | 44 +++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c | 24 +++++++++++++++++++
>  2 files changed, 68 insertions(+)
>
> diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
> index 68d79ac080..f76881519c 100644
> --- a/bsd-user/bsd-mem.h
> +++ b/bsd-user/bsd-mem.h
> @@ -100,4 +100,48 @@ static inline abi_long do_bsd_msync(abi_long addr,
> abi_long len, abi_long flags)
>      return get_errno(msync(g2h_untagged(addr), len, flags));
>  }
>
> +/* mlock(2) */
> +static inline abi_long do_bsd_mlock(abi_long arg1, abi_long arg2)
> +{
> +    return get_errno(mlock(g2h_untagged(arg1), arg2));
> +}
> +
> +/* munlock(2) */
> +static inline abi_long do_bsd_munlock(abi_long arg1, abi_long arg2)
> +{
> +    return get_errno(munlock(g2h_untagged(arg1), arg2));
> +}
> +
> +/* mlockall(2) */
> +static inline abi_long do_bsd_mlockall(abi_long arg1)
> +{
> +    return get_errno(mlockall(arg1));
> +}
> +
> +/* munlockall(2) */
> +static inline abi_long do_bsd_munlockall(void)
> +{
> +    return get_errno(munlockall());
> +}
> +
> +/* madvise(2) */
> +static inline abi_long do_bsd_madvise(abi_long arg1, abi_long arg2,
> +        abi_long arg3)
> +{
> +    /*
> +     * A straight passthrough may not be safe because qemu sometimes
> +     * turns private file-backed mapping into anonymous mappings. This
> +     * will break MADV_DONTNEED.  This is a hint, so ignoring and returi=
ng
> +     * success is ok.
> +     */
> +    return get_errno(0);
>

This looks like it was copied from an early linux-user implementation, and
that seems to have been fixed to no longer cause problems. Can someone
that knows about the linux-user history here comment?

Warner


> +}
> +
> +/* minherit(2) */
> +static inline abi_long do_bsd_minherit(abi_long addr, abi_long len,
> +        abi_long inherit)
> +{
> +    return get_errno(minherit(g2h_untagged(addr), len, inherit));
> +}
> +
>  #endif /* BSD_USER_BSD_MEM_H */
> diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.=
c
> index 3871b15309..96469f6a63 100644
> --- a/bsd-user/freebsd/os-syscall.c
> +++ b/bsd-user/freebsd/os-syscall.c
> @@ -503,6 +503,30 @@ static abi_long freebsd_syscall(void *cpu_env, int
> num, abi_long arg1,
>          ret =3D do_bsd_msync(arg1, arg2, arg3);
>          break;
>
> +    case TARGET_FREEBSD_NR_mlock: /* mlock(2) */
> +        ret =3D do_bsd_mlock(arg1, arg2);
> +        break;
> +
> +    case TARGET_FREEBSD_NR_munlock: /* munlock(2) */
> +        ret =3D do_bsd_munlock(arg1, arg2);
> +        break;
> +
> +    case TARGET_FREEBSD_NR_mlockall: /* mlockall(2) */
> +        ret =3D do_bsd_mlockall(arg1);
> +        break;
> +
> +    case TARGET_FREEBSD_NR_munlockall: /* munlockall(2) */
> +        ret =3D do_bsd_munlockall();
> +        break;
> +
> +    case TARGET_FREEBSD_NR_madvise: /* madvise(2) */
> +        ret =3D do_bsd_madvise(arg1, arg2, arg3);
> +        break;
> +
> +    case TARGET_FREEBSD_NR_minherit: /* minherit(2) */
> +        ret =3D do_bsd_minherit(arg1, arg2, arg3);
> +        break;
> +
>  #if defined(__FreeBSD_version) && __FreeBSD_version >=3D 1300048
>      case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
>          ret =3D do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
> --
> 2.40.0
>
>

--000000000000dd47e806035350fc
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
=C2=A0bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 44 ++++=
+++++++++++++++++++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c | 24 +++++++++++++++++++<br>
=C2=A02 files changed, 68 insertions(+)<br>
<br>
diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h<br>
index 68d79ac080..f76881519c 100644<br>
--- a/bsd-user/bsd-mem.h<br>
+++ b/bsd-user/bsd-mem.h<br>
@@ -100,4 +100,48 @@ static inline abi_long do_bsd_msync(abi_long addr, abi=
_long len, abi_long flags)<br>
=C2=A0 =C2=A0 =C2=A0return get_errno(msync(g2h_untagged(addr), len, flags))=
;<br>
=C2=A0}<br>
<br>
+/* mlock(2) */<br>
+static inline abi_long do_bsd_mlock(abi_long arg1, abi_long arg2)<br>
+{<br>
+=C2=A0 =C2=A0 return get_errno(mlock(g2h_untagged(arg1), arg2));<br>
+}<br>
+<br>
+/* munlock(2) */<br>
+static inline abi_long do_bsd_munlock(abi_long arg1, abi_long arg2)<br>
+{<br>
+=C2=A0 =C2=A0 return get_errno(munlock(g2h_untagged(arg1), arg2));<br>
+}<br>
+<br>
+/* mlockall(2) */<br>
+static inline abi_long do_bsd_mlockall(abi_long arg1)<br>
+{<br>
+=C2=A0 =C2=A0 return get_errno(mlockall(arg1));<br>
+}<br>
+<br>
+/* munlockall(2) */<br>
+static inline abi_long do_bsd_munlockall(void)<br>
+{<br>
+=C2=A0 =C2=A0 return get_errno(munlockall());<br>
+}<br>
+<br>
+/* madvise(2) */<br>
+static inline abi_long do_bsd_madvise(abi_long arg1, abi_long arg2,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_long arg3)<br>
+{<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* A straight passthrough may not be safe because qemu =
sometimes<br>
+=C2=A0 =C2=A0 =C2=A0* turns private file-backed mapping into anonymous map=
pings. This<br>
+=C2=A0 =C2=A0 =C2=A0* will break MADV_DONTNEED.=C2=A0 This is a hint, so i=
gnoring and returing<br>
+=C2=A0 =C2=A0 =C2=A0* success is ok.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 return get_errno(0);<br></blockquote><div><br></div><div>Thi=
s looks like it was copied from an early linux-user implementation, and</di=
v><div>that seems to have been fixed to no longer cause problems. Can someo=
ne</div><div>that knows about the linux-user history here comment?</div><di=
v><br></div><div>Warner<br></div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
+}<br>
+<br>
+/* minherit(2) */<br>
+static inline abi_long do_bsd_minherit(abi_long addr, abi_long len,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_long inherit)<br>
+{<br>
+=C2=A0 =C2=A0 return get_errno(minherit(g2h_untagged(addr), len, inherit))=
;<br>
+}<br>
+<br>
=C2=A0#endif /* BSD_USER_BSD_MEM_H */<br>
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c<=
br>
index 3871b15309..96469f6a63 100644<br>
--- a/bsd-user/freebsd/os-syscall.c<br>
+++ b/bsd-user/freebsd/os-syscall.c<br>
@@ -503,6 +503,30 @@ static abi_long freebsd_syscall(void *cpu_env, int num=
, abi_long arg1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D do_bsd_msync(arg1, arg2, arg3);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
+=C2=A0 =C2=A0 case TARGET_FREEBSD_NR_mlock: /* mlock(2) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_bsd_mlock(arg1, arg2);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case TARGET_FREEBSD_NR_munlock: /* munlock(2) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_bsd_munlock(arg1, arg2);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case TARGET_FREEBSD_NR_mlockall: /* mlockall(2) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_bsd_mlockall(arg1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case TARGET_FREEBSD_NR_munlockall: /* munlockall(2) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_bsd_munlockall();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case TARGET_FREEBSD_NR_madvise: /* madvise(2) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_bsd_madvise(arg1, arg2, arg3);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case TARGET_FREEBSD_NR_minherit: /* minherit(2) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_bsd_minherit(arg1, arg2, arg3);<br>
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

--000000000000dd47e806035350fc--

