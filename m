Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E90587A8CA9
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 21:17:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj2gW-0005pJ-Ox; Wed, 20 Sep 2023 15:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj2gU-0005p2-9V
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 15:16:26 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj2gS-000242-FH
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 15:16:26 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-530a6cbbb47so107789a12.0
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 12:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695237382; x=1695842182;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Dk0O6OmRLTOAYG0i2HSoqT3DTjuEaulZQ8mEKGhpP6I=;
 b=gEhN7pu83fWAHhbJQosAR8gZ2zzf/yEpTX/griuQJjfnJww2q1GkldO15DZjsqgZko
 Fu0ZZfZ49jBnPbFi6oDcoVrqUB/UbPkR2MhE1sAShHZkASWHYibJKnE6p+fY75DJ6w87
 FfPVhJ+HbK7n/+qSjao2OWHwf5kAuI0uPArb5lxCZpSJMUlrxK2J+O56a0bmY1eDm4e2
 fTkgW9ueLF5fRxQSpcI0FHjEko76TSzMylRUl6HTGp0ixhzgaKj4T5Ut5oka29kqheJW
 onxMPyQ6RySZBmb2FjpVbs2Gb/pL95etPhfZVKOprmpSIMkCwAaDctFhhaSF0O5CKK1i
 dURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695237382; x=1695842182;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dk0O6OmRLTOAYG0i2HSoqT3DTjuEaulZQ8mEKGhpP6I=;
 b=Vc569cEcgU2AHvSrv/e+W+WtxxY2iDNhgKo21BjJFvSqWrKsawinMpoSQb9YI5CS4H
 yuah/Y/ODUaQ+5aCclV1aWnSXq9f5hndhQi9Q2iKMUiA7rVF1YaTLTr2d/oYHpw6z05D
 qIVvuaUbFu3mhya8wbxKJRJRxmpaBdU1vWKX8RcXVhmqu5Uj/E51E8c6SP0Keb2OZbmB
 gjmBdW/uTrQYsVqDTGbgVTnEndBt389jzvvHfKJLwQYGzFfOcpTnhGxx+o5w+knh5Av0
 aKwHHcBNfr2R55J+1U/QF0UX1dX2uGXTyg/XpWmJwI2pFLmyRSqiEUWX+zhMebBgYbXN
 sEAg==
X-Gm-Message-State: AOJu0Yxf/O0p6sp9nkCkzDZToE7w64DGsi0fS5d6VAV9rHOOhWn1TYy8
 h2Aw+4ZS44nj1GZkeG5FXTvZL4qOen+plfZdfPdyWg==
X-Google-Smtp-Source: AGHT+IFbof/toYGx93YIU2/15cqoG++L2kJvZbP9a5crrzziw9Hf2kjpaqenWr2XwTl6SnfG39wJbvn7zVNuClmRod4=
X-Received: by 2002:aa7:d414:0:b0:525:6d6e:ed53 with SMTP id
 z20-20020aa7d414000000b005256d6eed53mr3443446edq.27.1695237382566; Wed, 20
 Sep 2023 12:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
 <20230917213803.20683-26-kariem.taha2.7@gmail.com>
In-Reply-To: <20230917213803.20683-26-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 20 Sep 2023 20:16:11 +0100
Message-ID: <CANCZdfrGjjiPt1UDOSLZwCO2tEmch6XAHnGzaBojmccVFfR=Hw@mail.gmail.com>
Subject: Re: [PATCH v2 25/28] bsd-user: Implement pdgetpid(2) and the
 undocumented setugid.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000ff88450605cf353b"
Received-SPF: none client-ip=2a00:1450:4864:20::52d;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x52d.google.com
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

--000000000000ff88450605cf353b
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
>  bsd-user/freebsd/os-proc.h    | 23 +++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |  8 ++++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
> index 1866f0b2d6..47bcdcf8a3 100644
> --- a/bsd-user/freebsd/os-proc.h
> +++ b/bsd-user/freebsd/os-proc.h
> @@ -34,6 +34,8 @@ pid_t safe_wait4(pid_t wpid, int *status, int options,
> struct rusage *rusage);
>  pid_t safe_wait6(idtype_t idtype, id_t id, int *status, int options,
>      struct __wrusage *wrusage, siginfo_t *infop);
>
> +extern int __setugid(int flag);
> +
>  /* execve(2) */
>  static inline abi_long do_freebsd_execve(abi_ulong path_or_fd, abi_ulong
> argp,
>          abi_ulong envp)
> @@ -155,4 +157,25 @@ static inline abi_long
> do_freebsd_getloginclass(abi_ulong arg1, abi_ulong arg2)
>      return ret;
>  }
>
> +/* pdgetpid(2) */
> +static inline abi_long do_freebsd_pdgetpid(abi_long fd, abi_ulong
> target_pidp)
> +{
> +    abi_long ret;
> +    pid_t pid;
> +
> +    ret =3D get_errno(pdgetpid(fd, &pid));
> +    if (!is_error(ret)) {
> +        if (put_user_u32(pid, target_pidp)) {
> +            return -TARGET_EFAULT;
> +        }
> +    }
> +    return ret;
> +}
> +
> +/* undocumented __setugid */
> +static inline abi_long do_freebsd___setugid(abi_long arg1)
> +{
> +    return get_errno(__setugid(arg1));
>

This should be return -TARGET_ENOSYS since the kernel doesn't implement
it for anything except a regression test....  And what it does is quite
dangerous,
so we don't want someone to think it's a good idea to implement it in the
future.

Warner


> +}
> +
>  #endif /* BSD_USER_FREEBSD_OS_PROC_H */
> diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.=
c
> index d614409e69..99af0f6b15 100644
> --- a/bsd-user/freebsd/os-syscall.c
> +++ b/bsd-user/freebsd/os-syscall.c
> @@ -383,6 +383,14 @@ static abi_long freebsd_syscall(void *cpu_env, int
> num, abi_long arg1,
>          ret =3D do_freebsd_getloginclass(arg1, arg2);
>          break;
>
> +    case TARGET_FREEBSD_NR_pdgetpid: /* pdgetpid(2) */
> +        ret =3D do_freebsd_pdgetpid(arg1, arg2);
> +        break;
> +
> +    case TARGET_FREEBSD_NR___setugid: /* undocumented */
> +        ret =3D do_freebsd___setugid(arg1);
> +        break;
> +
>      case TARGET_FREEBSD_NR_utrace: /* utrace(2) */
>          ret =3D do_bsd_utrace(arg1, arg2);
>          break;
> --
> 2.42.0
>
>

--000000000000ff88450605cf353b
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
=C2=A0bsd-user/freebsd/os-proc.h=C2=A0 =C2=A0 | 23 +++++++++++++++++++++++<=
br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 8 ++++++++<br>
=C2=A02 files changed, 31 insertions(+)<br>
<br>
diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h<br>
index 1866f0b2d6..47bcdcf8a3 100644<br>
--- a/bsd-user/freebsd/os-proc.h<br>
+++ b/bsd-user/freebsd/os-proc.h<br>
@@ -34,6 +34,8 @@ pid_t safe_wait4(pid_t wpid, int *status, int options, st=
ruct rusage *rusage);<br>
=C2=A0pid_t safe_wait6(idtype_t idtype, id_t id, int *status, int options,<=
br>
=C2=A0 =C2=A0 =C2=A0struct __wrusage *wrusage, siginfo_t *infop);<br>
<br>
+extern int __setugid(int flag);<br>
+<br>
=C2=A0/* execve(2) */<br>
=C2=A0static inline abi_long do_freebsd_execve(abi_ulong path_or_fd, abi_ul=
ong argp,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0abi_ulong envp)<br>
@@ -155,4 +157,25 @@ static inline abi_long do_freebsd_getloginclass(abi_ul=
ong arg1, abi_ulong arg2)<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
+/* pdgetpid(2) */<br>
+static inline abi_long do_freebsd_pdgetpid(abi_long fd, abi_ulong target_p=
idp)<br>
+{<br>
+=C2=A0 =C2=A0 abi_long ret;<br>
+=C2=A0 =C2=A0 pid_t pid;<br>
+<br>
+=C2=A0 =C2=A0 ret =3D get_errno(pdgetpid(fd, &amp;pid));<br>
+=C2=A0 =C2=A0 if (!is_error(ret)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (put_user_u32(pid, target_pidp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+/* undocumented __setugid */<br>
+static inline abi_long do_freebsd___setugid(abi_long arg1)<br>
+{<br>
+=C2=A0 =C2=A0 return get_errno(__setugid(arg1));<br></blockquote><div><br>=
</div><div>This should be return -TARGET_ENOSYS since the kernel doesn&#39;=
t implement</div><div>it for anything except a regression test....=C2=A0 An=
d what it does is quite dangerous,</div><div>so we don&#39;t want someone t=
o think it&#39;s a good idea to implement it in the future.</div><div><br><=
/div><div>Warner</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
+}<br>
+<br>
=C2=A0#endif /* BSD_USER_FREEBSD_OS_PROC_H */<br>
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c<=
br>
index d614409e69..99af0f6b15 100644<br>
--- a/bsd-user/freebsd/os-syscall.c<br>
+++ b/bsd-user/freebsd/os-syscall.c<br>
@@ -383,6 +383,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num=
, abi_long arg1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D do_freebsd_getloginclass(arg1, ar=
g2);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
+=C2=A0 =C2=A0 case TARGET_FREEBSD_NR_pdgetpid: /* pdgetpid(2) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_freebsd_pdgetpid(arg1, arg2);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case TARGET_FREEBSD_NR___setugid: /* undocumented */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_freebsd___setugid(arg1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0case TARGET_FREEBSD_NR_utrace: /* utrace(2) */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D do_bsd_utrace(arg1, arg2);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-- <br>
2.42.0<br>
<br>
</blockquote></div></div>

--000000000000ff88450605cf353b--

