Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6313D781C62
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 06:28:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXa2Q-0002d5-K0; Sun, 20 Aug 2023 00:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXa2N-0002ch-NH
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:27:39 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXa2L-0007wh-BY
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:27:39 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2b9b904bb04so35852941fa.1
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 21:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692505656; x=1693110456;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y3PPgdBgxlPGShPaxBaBFcSINlsBL6uUqWxiAhVH8pQ=;
 b=ZF8Y14X6mKA8NUqjrA05BsCZC2p8ydIpEm05SnwRffjMQtxsxonZIZ0dRzQmAxkXmB
 xRvdc2hiiqWN/lmZShPJ4Pu/Nr7lgoN6gzn+IylSHjO2grvCrPhf6bw7wHJuWiL1Q8FR
 ibLOg0bnzqr7UQ34PlH3oWXcn92ZNc3hl/1+NDhkUuM05oVZZ5T9CNzl2zebMoi0Cg0w
 xZLzqU0rINkfZg+cuV4vp9zQM2h1vH8oYrqNyEb/bCeq7xfpVnqSCyBNGtlGbNdvA+I2
 AGdfP+Tj2mxe92Zur4jxITZ1eKlESYCBIMdVrRz4GOZf90+oZk2Mc2guqQM5AzYZdodg
 MHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692505656; x=1693110456;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y3PPgdBgxlPGShPaxBaBFcSINlsBL6uUqWxiAhVH8pQ=;
 b=KM0LofGQQHoHx0d8KNUg+Fajnyg3JYLH2aJ8Nk8zYH57UaDJZM9jDySoB+02piOTvO
 2fmLKJSUNiT9DQb+uk592YmaiNtRVuwvPGFdqgA4m8e7kDm/zk7KjOskksPzf8VdfrOZ
 TFCZ3mK6QX5MBRGvei2OyAu+dxDBDh2P9+dJg3/JtIrbJNv+OsfV5Cnln45sb2Bt1gB3
 mu5buZMfGLUG4R9Pg7b48tidkoAAaRpAgJUz6h+oxw/uSb3plDOYpI6Im4aQm8/PtbTH
 FioM/9FNWefZacpbnZEel28v+p7SgjXYE2B4HAp4kYu9VrOe8LMfM2NdWzbCdEEL5wKd
 FL9A==
X-Gm-Message-State: AOJu0YywyODwR/O6vVKBr2178tjfz/d1erI/bkASGcflN2G/DNWB9+kY
 z/fD5q/bRFA4370e2KOMp3SfXO5ROrsiWUbDN8qZLw==
X-Google-Smtp-Source: AGHT+IEmwycc8D4rGsNpp04CSenlgKYXpowLFglUMG4H+0sAggQWg76idB3+CoKLXyBbd1/a8+Ku1lJtq9vnsWBYcwQ=
X-Received: by 2002:a05:6512:a94:b0:4fe:c4e:709f with SMTP id
 m20-20020a0565120a9400b004fe0c4e709fmr2404369lfu.20.1692505655843; Sat, 19
 Aug 2023 21:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-13-kariem.taha2.7@gmail.com>
In-Reply-To: <20230819094806.14965-13-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Aug 2023 22:27:28 -0600
Message-ID: <CANCZdfp3rDTqk2Ztxd1J_CGQJEiJXFJunhC1vEFewDJZhJ7paQ@mail.gmail.com>
Subject: Re: [PATCH 12/22] Implement mmap(2) and munmap(2)
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000065b4320603532e4e"
Received-SPF: none client-ip=2a00:1450:4864:20::236;
 envelope-from=wlosh@bsdimp.com; helo=mail-lj1-x236.google.com
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

--00000000000065b4320603532e4e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 19, 2023 at 3:49=E2=80=AFAM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/bsd-mem.h            | 20 ++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |  9 +++++++++
>  2 files changed, 29 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>


> diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
> index fed7b7cd80..057c995a6e 100644
> --- a/bsd-user/bsd-mem.h
> +++ b/bsd-user/bsd-mem.h
> @@ -62,4 +62,24 @@ extern abi_ulong bsd_target_brk;
>  extern abi_ulong bsd_target_original_brk;
>  extern abi_ulong brk_page;
>
> +/* mmap(2) */
> +static inline abi_long do_bsd_mmap(void *cpu_env, abi_long arg1, abi_lon=
g
> arg2,
> +    abi_long arg3, abi_long arg4, abi_long arg5, abi_long arg6, abi_long
> arg7,
> +    abi_long arg8)
> +{
> +    if (regpairs_aligned(cpu_env) !=3D 0) {
> +        arg6 =3D arg7;
> +        arg7 =3D arg8;
> +    }
> +    return get_errno(target_mmap(arg1, arg2, arg3,
> +                                 target_to_host_bitmask(arg4,
> mmap_flags_tbl),
> +                                 arg5, target_arg64(arg6, arg7)));
> +}
> +
> +/* munmap(2) */
> +static inline abi_long do_bsd_munmap(abi_long arg1, abi_long arg2)
> +{
> +    return get_errno(target_munmap(arg1, arg2));
> +}
> +
>  #endif /* BSD_USER_BSD_MEM_H */
> diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.=
c
> index 7e2a395e0f..3525d39d7b 100644
> --- a/bsd-user/freebsd/os-syscall.c
> +++ b/bsd-user/freebsd/os-syscall.c
> @@ -486,6 +486,15 @@ static abi_long freebsd_syscall(void *cpu_env, int
> num, abi_long arg1,
>          /*
>           * Memory management system calls.
>           */
> +    case TARGET_FREEBSD_NR_mmap: /* mmap(2) */
> +        ret =3D do_bsd_mmap(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6,
> arg7,
> +           arg8);
> +        break;
> +
> +    case TARGET_FREEBSD_NR_munmap: /* munmap(2) */
> +        ret =3D do_bsd_munmap(arg1, arg2);
> +        break;
> +
>  #if defined(__FreeBSD_version) && __FreeBSD_version >=3D 1300048
>      case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
>          ret =3D do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
> --
> 2.40.0
>
>

--00000000000065b4320603532e4e
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
=C2=A0bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 20 ++++=
++++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 9 +++++++++<br>
=C2=A02 files changed, 29 insertions(+)<br></blockquote><div><br></div><div=
>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.=
com</a>&gt;</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h<br>
index fed7b7cd80..057c995a6e 100644<br>
--- a/bsd-user/bsd-mem.h<br>
+++ b/bsd-user/bsd-mem.h<br>
@@ -62,4 +62,24 @@ extern abi_ulong bsd_target_brk;<br>
=C2=A0extern abi_ulong bsd_target_original_brk;<br>
=C2=A0extern abi_ulong brk_page;<br>
<br>
+/* mmap(2) */<br>
+static inline abi_long do_bsd_mmap(void *cpu_env, abi_long arg1, abi_long =
arg2,<br>
+=C2=A0 =C2=A0 abi_long arg3, abi_long arg4, abi_long arg5, abi_long arg6, =
abi_long arg7,<br>
+=C2=A0 =C2=A0 abi_long arg8)<br>
+{<br>
+=C2=A0 =C2=A0 if (regpairs_aligned(cpu_env) !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 arg6 =3D arg7;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 arg7 =3D arg8;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return get_errno(target_mmap(arg1, arg2, arg3,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_to_host_bitmask(arg4, m=
map_flags_tbl),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arg5, target_arg64(arg6, arg7)=
));<br>
+}<br>
+<br>
+/* munmap(2) */<br>
+static inline abi_long do_bsd_munmap(abi_long arg1, abi_long arg2)<br>
+{<br>
+=C2=A0 =C2=A0 return get_errno(target_munmap(arg1, arg2));<br>
+}<br>
+<br>
=C2=A0#endif /* BSD_USER_BSD_MEM_H */<br>
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c<=
br>
index 7e2a395e0f..3525d39d7b 100644<br>
--- a/bsd-user/freebsd/os-syscall.c<br>
+++ b/bsd-user/freebsd/os-syscall.c<br>
@@ -486,6 +486,15 @@ static abi_long freebsd_syscall(void *cpu_env, int num=
, abi_long arg1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Memory management system calls.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 case TARGET_FREEBSD_NR_mmap: /* mmap(2) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_bsd_mmap(cpu_env, arg1, arg2, arg3,=
 arg4, arg5, arg6, arg7,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arg8);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case TARGET_FREEBSD_NR_munmap: /* munmap(2) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_bsd_munmap(arg1, arg2);<br>
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

--00000000000065b4320603532e4e--

