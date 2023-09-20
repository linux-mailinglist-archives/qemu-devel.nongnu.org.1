Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DD47A8C68
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 21:12:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj2cM-0003uc-Tb; Wed, 20 Sep 2023 15:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj2cK-0003uC-2i
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 15:12:09 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj2cI-0001En-1C
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 15:12:07 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5031426b626so322425e87.3
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 12:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695237124; x=1695841924;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mBanJwbsitYlCi++81ZIkqiRzkV7ct/YAXezzajYBUs=;
 b=pRsdnjVF2ALbKg1CHrBG7PFlCh+Htp8/1ALskGAKDbnhsPPhnoNwuJ5wz227aACOgv
 dK9GWvDymibotVzZAJac+0CoRZM8Q6ahYj6pXJ4YxDFPH9X8pL6YwNXQ5Vh+GUeRfP+9
 yvLmRL84T92ZDRBrm+hpMEB8v/mls+XeJLocMdXvaxG5W/0WUCIypEiMvQ1INva2CXAx
 gyGXtiv4yYWTzzVNClNVqJC0qGKMolco8VeqD1EnQabAqqhHkzCO7CnzhDbVlHMkFpsc
 mwsEcvWTVT0x5u0hBUe8sVWpZ2QLHdA1oGJnHi2of5VyygWZ7OEl7/6Xlu7p8o1KDRpC
 cdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695237124; x=1695841924;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mBanJwbsitYlCi++81ZIkqiRzkV7ct/YAXezzajYBUs=;
 b=mu7KIX9tLV0Zk2CqgyIUch8UNBg2807V38SEEN/U+l9HxG2YuqJ5F5WXexiQi784DA
 oT+4lPaSdMc/VZ0e+Ya5+Ut8FHPT1sm+WC1CBJ5UxPTvSX2O8s5eusGAi3rvOm1lX6UR
 t7a2gV4QgF51JasidH7w8lMoXNmme/NylsvnkYUUHx7+oKD/cL7LGVJj6QyGsS9ei428
 jsKyS1055sJJHMVVp8z59h4zJgLDsU+CvF010oDN1R+yO6y6QVYvebami5CT/PwuXCKF
 A0+wU1wCLYhY4gAJ3OonPZJfd1Gf5kmpg4iI7e9QGS7LUQCjXTJtmlcoQaeKoau3cFBT
 //nQ==
X-Gm-Message-State: AOJu0YyKoIl0BzCDXlRumJ7NnbpWx57jrAm4T7Wy61jfgL8rV2nQM8cj
 Vp6koO6kNtzMrFxkOw07+sWOF1YDBVv9Mf9MMh9OYQ==
X-Google-Smtp-Source: AGHT+IGERdsyZYndakGD71Qg0vQ0K+w/rwGD78y81i2Iv5Pq1QfFNCZ9qI5IMT+zzP6fTJvwc1K6e6n/gfQhAegiqIc=
X-Received: by 2002:a19:505c:0:b0:4fd:d92e:31ca with SMTP id
 z28-20020a19505c000000b004fdd92e31camr3377207lfj.36.1695237123985; Wed, 20
 Sep 2023 12:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
 <20230917213803.20683-25-kariem.taha2.7@gmail.com>
In-Reply-To: <20230917213803.20683-25-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 20 Sep 2023 20:11:53 +0100
Message-ID: <CANCZdfqC5qbgohVvoNBssFk7_8WZoEeJyXtiFvsP1SwF7v3L+Q@mail.gmail.com>
Subject: Re: [PATCH v2 24/28] bsd-user: Implement setloginclass(2) and
 getloginclass(2) system calls.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000095ec080605cf2679"
Received-SPF: none client-ip=2a00:1450:4864:20::129;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x129.google.com
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

--00000000000095ec080605cf2679
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 10:39=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.c=
om>
wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  bsd-user/freebsd/os-proc.h    | 32 ++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |  8 ++++++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
> index 8a0b6e25bb..1866f0b2d6 100644
> --- a/bsd-user/freebsd/os-proc.h
> +++ b/bsd-user/freebsd/os-proc.h
> @@ -123,4 +123,36 @@ static inline abi_long do_freebsd_wait6(void
> *cpu_env, abi_long idtype,
>      return ret;
>  }
>
> +/* setloginclass(2) */
> +static inline abi_long do_freebsd_setloginclass(abi_ulong arg1)
> +{
> +    abi_long ret;
> +    void *p;
> +
> +    p =3D lock_user_string(arg1);
> +    if (p =3D=3D NULL) {
> +        return -TARGET_EFAULT;
> +    }
> +    ret =3D get_errno(setloginclass(p));
> +    unlock_user(p, arg1, 0);
> +
> +    return ret;
> +}
> +
> +/* getloginclass(2) */
> +static inline abi_long do_freebsd_getloginclass(abi_ulong arg1, abi_ulon=
g
> arg2)
> +{
> +    abi_long ret;
> +    void *p;
> +
> +    p =3D lock_user_string(arg1);
>

This has the same problem that I highlighted in _getlogin() has. The kernel
returns a string, so we have to lock the buffer for it, not the string.

Warner


> +    if (p =3D=3D NULL) {
> +        return -TARGET_EFAULT;
> +    }
> +    ret =3D get_errno(getloginclass(p, arg2));
> +    unlock_user(p, arg1, 0);
> +
> +    return ret;
> +}
> +
>  #endif /* BSD_USER_FREEBSD_OS_PROC_H */
> diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.=
c
> index 55e68e4815..d614409e69 100644
> --- a/bsd-user/freebsd/os-syscall.c
> +++ b/bsd-user/freebsd/os-syscall.c
> @@ -375,6 +375,14 @@ static abi_long freebsd_syscall(void *cpu_env, int
> num, abi_long arg1,
>          ret =3D do_bsd_ktrace(arg1, arg2, arg3, arg4);
>          break;
>
> +    case TARGET_FREEBSD_NR_setloginclass: /* setloginclass(2) */
> +        ret =3D do_freebsd_setloginclass(arg1);
> +        break;
> +
> +    case TARGET_FREEBSD_NR_getloginclass: /* getloginclass(2) */
> +        ret =3D do_freebsd_getloginclass(arg1, arg2);
> +        break;
> +
>      case TARGET_FREEBSD_NR_utrace: /* utrace(2) */
>          ret =3D do_bsd_utrace(arg1, arg2);
>          break;
> --
> 2.42.0
>
>

--00000000000095ec080605cf2679
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
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/freebsd/os-proc.h=C2=A0 =C2=A0 | 32 ++++++++++++++++++++++++=
++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 8 ++++++++<br>
=C2=A02 files changed, 40 insertions(+)<br>
<br>
diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h<br>
index 8a0b6e25bb..1866f0b2d6 100644<br>
--- a/bsd-user/freebsd/os-proc.h<br>
+++ b/bsd-user/freebsd/os-proc.h<br>
@@ -123,4 +123,36 @@ static inline abi_long do_freebsd_wait6(void *cpu_env,=
 abi_long idtype,<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
+/* setloginclass(2) */<br>
+static inline abi_long do_freebsd_setloginclass(abi_ulong arg1)<br>
+{<br>
+=C2=A0 =C2=A0 abi_long ret;<br>
+=C2=A0 =C2=A0 void *p;<br>
+<br>
+=C2=A0 =C2=A0 p =3D lock_user_string(arg1);<br>
+=C2=A0 =C2=A0 if (p =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 ret =3D get_errno(setloginclass(p));<br>
+=C2=A0 =C2=A0 unlock_user(p, arg1, 0);<br>
+<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+/* getloginclass(2) */<br>
+static inline abi_long do_freebsd_getloginclass(abi_ulong arg1, abi_ulong =
arg2)<br>
+{<br>
+=C2=A0 =C2=A0 abi_long ret;<br>
+=C2=A0 =C2=A0 void *p;<br>
+<br>
+=C2=A0 =C2=A0 p =3D lock_user_string(arg1);<br></blockquote><div><br></div=
><div>This has the same problem that I highlighted in _getlogin() has. The =
kernel</div><div>returns a string, so we have to lock the buffer for it, no=
t the string.</div><div><br></div><div>Warner</div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 if (p =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 ret =3D get_errno(getloginclass(p, arg2));<br>
+=C2=A0 =C2=A0 unlock_user(p, arg1, 0);<br>
+<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
=C2=A0#endif /* BSD_USER_FREEBSD_OS_PROC_H */<br>
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c<=
br>
index 55e68e4815..d614409e69 100644<br>
--- a/bsd-user/freebsd/os-syscall.c<br>
+++ b/bsd-user/freebsd/os-syscall.c<br>
@@ -375,6 +375,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num=
, abi_long arg1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D do_bsd_ktrace(arg1, arg2, arg3, a=
rg4);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
+=C2=A0 =C2=A0 case TARGET_FREEBSD_NR_setloginclass: /* setloginclass(2) */=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_freebsd_setloginclass(arg1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case TARGET_FREEBSD_NR_getloginclass: /* getloginclass(2) */=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_freebsd_getloginclass(arg1, arg2);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0case TARGET_FREEBSD_NR_utrace: /* utrace(2) */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D do_bsd_utrace(arg1, arg2);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-- <br>
2.42.0<br>
<br>
</blockquote></div></div>

--00000000000095ec080605cf2679--

