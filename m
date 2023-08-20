Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 877E7781C5B
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 06:19:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXZtz-0006q2-2A; Sun, 20 Aug 2023 00:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXZtx-0006p0-Ez
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:18:57 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXZtv-0006iF-2n
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:18:57 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-99bc9e3cbf1so459075266b.0
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 21:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692505133; x=1693109933;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aMqPMyV5ZZ7iokzwMHKw7TjgJP984lNH2x+33oB/Vz8=;
 b=BzcpcTYFXh7vS/pDzZzoEFxrbRPHZ2iBCtopZ+FNPfLnbrkf6AAF6YW9GXPSZ/U48e
 Olck0sGdM60RDDwh3bcV3+EfYQ3gmaTgrDfvud36oer/7FB27DwwMvUcz0uuPNX7epze
 amoZumynK/2eS86+NeoEQWqn1PqoNgZkQQEfm4XDVregkfwSOXT9w4Wvky+gTmOT3PLL
 evYFTs0PYQlbSw1ujSvR5oVLUE1UW3MJ05hDts4PVzN3B1BJXwxbA/8WDDrd+HoxbZpR
 psxcEq9Ox+zUYeTU8YCdFjnBk1Yz6QuKCkIXdTB4FrI+WnndNHiNkR7Cah/jU99hUOZo
 qy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692505133; x=1693109933;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aMqPMyV5ZZ7iokzwMHKw7TjgJP984lNH2x+33oB/Vz8=;
 b=eMYLJ/0O/f+c36UprOlB8zU1AtIwDL+2Nn9uiAT9/sL+VXSxv9O7mlehg72OYHrlIM
 J8Wp6kom8ZyWTqDHcCwc4xZT40u4AfNA+SMi9wRujY5AWp25uUseouIbueYTAacjVl0J
 oSIYtk44ezjvan1um8tF6Bp3WWP6XZp+ibKGQ1IDBCV1KJxI3hc9C7ESb9zIxgVDEXT6
 UKGCVqkucd99IY8/53PsmYxzEjBDsCJcv11cmf69gi0+LYsNO6djQ/aDOdh0EWxYcYTx
 1DR+2YBEWY7srn0nfncBE4fj5Grsq6ZAzc+6dU7EuASWKdLdkSqj/dktBTmH/DizCN8j
 w/aA==
X-Gm-Message-State: AOJu0YwPCq+vlA7fQWqsVcuIH0yTCqJKOFYDLZhfk9s8Z4f+9zLA+nfv
 8aU9828jH8iuAVQsnV0Yy4TXIu4971ary72Ba6tYOA==
X-Google-Smtp-Source: AGHT+IEHg6qTv4PUykVfLqusaX2zu0XAr8DaRxiXEvuAOYqQtSXdJGrXSRlDWIIMBEaNln0EmWdteiesdKZAEo6OAsU=
X-Received: by 2002:a17:906:3299:b0:99b:65fa:fc24 with SMTP id
 25-20020a170906329900b0099b65fafc24mr3041780ejw.36.1692505133393; Sat, 19 Aug
 2023 21:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-7-kariem.taha2.7@gmail.com>
In-Reply-To: <20230819094806.14965-7-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Aug 2023 22:18:46 -0600
Message-ID: <CANCZdfouCkT6pyXT_Ua4KV_1nx8_xY6r1dyChLjkHkfVxBvjyw@mail.gmail.com>
Subject: Re: [PATCH 06/22] Implement shm_rename(2) system call
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000041bc420603530f55"
Received-SPF: none client-ip=2a00:1450:4864:20::62c;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x62c.google.com
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

--00000000000041bc420603530f55
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 19, 2023 at 3:48=E2=80=AFAM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Kyle Evans <kevans@FreeBSD.org>
>
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/freebsd/os-misc.h    | 24 ++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |  6 ++++++
>  2 files changed, 30 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

The FreeBSD 13 ifdef below still is needed since FreeBSD 12 is still
supported by the
project until the end of the year.


> diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
> index 993e4598f9..3509ef026e 100644
> --- a/bsd-user/freebsd/os-misc.h
> +++ b/bsd-user/freebsd/os-misc.h
> @@ -76,5 +76,29 @@ static inline abi_long do_freebsd_shm_open2(abi_ulong
> pathptr, abi_ulong flags,
>  #undef SHM_PATH
>  #endif /* __FreeBSD_version >=3D 1300048 */
>
> +#if defined(__FreeBSD_version) && __FreeBSD_version >=3D 1300049
> +/* shm_rename(2) */
> +static inline abi_long do_freebsd_shm_rename(abi_ulong fromptr, abi_ulon=
g
> toptr,
> +        abi_ulong flags)
> +{
> +    int ret;
> +    void *ufrom, *uto;
> +
> +    ufrom =3D lock_user_string(fromptr);
> +    if (ufrom =3D=3D NULL) {
> +        return -TARGET_EFAULT;
> +    }
> +    uto =3D lock_user_string(toptr);
> +    if (uto =3D=3D NULL) {
> +        unlock_user(ufrom, fromptr, 0);
> +        return -TARGET_EFAULT;
> +    }
> +    ret =3D get_errno(shm_rename(ufrom, uto, flags));
> +    unlock_user(ufrom, fromptr, 0);
> +    unlock_user(uto, toptr, 0);
> +
> +    return ret;
> +}
> +#endif /* __FreeBSD_version >=3D 1300049 */
>
>  #endif /* OS_MISC_H */
> diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.=
c
> index b4311db578..2920370ad2 100644
> --- a/bsd-user/freebsd/os-syscall.c
> +++ b/bsd-user/freebsd/os-syscall.c
> @@ -495,6 +495,12 @@ static abi_long freebsd_syscall(void *cpu_env, int
> num, abi_long arg1,
>          break;
>  #endif
>
> +#if defined(__FreeBSD_version) && __FreeBSD_version >=3D 1300049
> +    case TARGET_FREEBSD_NR_shm_rename: /* shm_rename(2) */
> +        ret =3D do_freebsd_shm_rename(arg1, arg2, arg3);
> +        break;
> +#endif
> +
>          /*
>           * sys{ctl, arch, call}
>           */
> --
> 2.40.0
>
>

--00000000000041bc420603530f55
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Aug 19, 2023 at 3:48=E2=80=AF=
AM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.taha2.=
7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Kyle Evans &lt;kevans@FreeBSD.org&gt;<br>
<br>
Signed-off-by: Kyle Evans &lt;kevans@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/freebsd/os-misc.h=C2=A0 =C2=A0 | 24 ++++++++++++++++++++++++=
<br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 6 ++++++<br>
=C2=A02 files changed, 30 insertions(+)<br></blockquote><div><br></div><div=
>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.=
com</a>&gt;</div><div><br></div><div>The FreeBSD 13 ifdef below still is ne=
eded since FreeBSD 12 is still supported by the</div><div>project until the=
 end of the year.<br></div><div>=C2=A0<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h<br>
index 993e4598f9..3509ef026e 100644<br>
--- a/bsd-user/freebsd/os-misc.h<br>
+++ b/bsd-user/freebsd/os-misc.h<br>
@@ -76,5 +76,29 @@ static inline abi_long do_freebsd_shm_open2(abi_ulong pa=
thptr, abi_ulong flags,<br>
=C2=A0#undef SHM_PATH<br>
=C2=A0#endif /* __FreeBSD_version &gt;=3D 1300048 */<br>
<br>
+#if defined(__FreeBSD_version) &amp;&amp; __FreeBSD_version &gt;=3D 130004=
9<br>
+/* shm_rename(2) */<br>
+static inline abi_long do_freebsd_shm_rename(abi_ulong fromptr, abi_ulong =
toptr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong flags)<br>
+{<br>
+=C2=A0 =C2=A0 int ret;<br>
+=C2=A0 =C2=A0 void *ufrom, *uto;<br>
+<br>
+=C2=A0 =C2=A0 ufrom =3D lock_user_string(fromptr);<br>
+=C2=A0 =C2=A0 if (ufrom =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 uto =3D lock_user_string(toptr);<br>
+=C2=A0 =C2=A0 if (uto =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unlock_user(ufrom, fromptr, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 ret =3D get_errno(shm_rename(ufrom, uto, flags));<br>
+=C2=A0 =C2=A0 unlock_user(ufrom, fromptr, 0);<br>
+=C2=A0 =C2=A0 unlock_user(uto, toptr, 0);<br>
+<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+#endif /* __FreeBSD_version &gt;=3D 1300049 */<br>
<br>
=C2=A0#endif /* OS_MISC_H */<br>
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c<=
br>
index b4311db578..2920370ad2 100644<br>
--- a/bsd-user/freebsd/os-syscall.c<br>
+++ b/bsd-user/freebsd/os-syscall.c<br>
@@ -495,6 +495,12 @@ static abi_long freebsd_syscall(void *cpu_env, int num=
, abi_long arg1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0#endif<br>
<br>
+#if defined(__FreeBSD_version) &amp;&amp; __FreeBSD_version &gt;=3D 130004=
9<br>
+=C2=A0 =C2=A0 case TARGET_FREEBSD_NR_shm_rename: /* shm_rename(2) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_freebsd_shm_rename(arg1, arg2, arg3=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+#endif<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * sys{ctl, arch, call}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-- <br>
2.40.0<br>
<br>
</blockquote></div></div>

--00000000000041bc420603530f55--

