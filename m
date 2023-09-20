Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 697D57A8C4F
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 21:11:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj2av-0003Ga-BY; Wed, 20 Sep 2023 15:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj2as-0003GO-LN
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 15:10:38 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj2ap-0000yL-6F
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 15:10:37 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2bffd6c1460so1978941fa.3
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 12:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695237033; x=1695841833;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KtF5DxsCDcWiiGko67aj7rrimdzk/T7+HpwRqBwp8v0=;
 b=yKp8Y1KpeuKo4G6Ylq7as09gcoXv4dSFsXKL9qIblz7F085Ik9lroQK8wIJxGAFBUY
 vZI55ZKzLSZAk6egUHRv7a+0kuPoSGZUdqviSRXFPvGK/5thKVKujiGrU+9y7Oiw63s7
 h5/YhLIU8MMWe6qJWYcQbcWENeXsXRoCM4C8gYSrSX2dtqBQq93VxyiRncGUEAFG4viJ
 hDaPIm7QHPxVh2GE4Zl9cii7GG9MeFNtuYGFMfZBk3rI7VBL5vY8fndBJqeg+vA/ddK4
 jRzV3QEDB/+V3YEKW9bTvo43lc4/HeiasjrqlKH97oNafc4BZyRl+EvHTetWurbrFHxJ
 BQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695237033; x=1695841833;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KtF5DxsCDcWiiGko67aj7rrimdzk/T7+HpwRqBwp8v0=;
 b=se8Cm99F0g9K68FPXcKdyu/CqyTIKqADESpYFG8UpJ9GoI8TrWwbd9k6GJsx0M36up
 OcGluPJY0DMnLgtr1ozMGWAOq9/gjAM5hH/1WWO0yrjDqZdbCim/WTIjLLyVYdJ95Kbq
 3QEMGqpP5huRSbaRAFEHqLsihhvnXj482v2IpSzvDb82vEdy9JN3L2TGh2PJJJc9v7V/
 TegQVVYcKi5siG5E2D3cLJjJrpy30OA4apjrAnk2dpSlZbChLKcBic+/GmnPd4fKRLSx
 Timj9snkOaFvVZKRfDKZzPVlxcUyI/PcUePz8xl2+maMKoETjg35VtKDYARY/auuWWGR
 zxeg==
X-Gm-Message-State: AOJu0YwVGFq4afI9eo5l2uVy2JC1w0IGkP7n3dPbGGyFKif5kjw7lKj0
 dNmOhYS8z+VfXMyOlWaA+GfB8ShoIoS5YEuD2bbkfw==
X-Google-Smtp-Source: AGHT+IHt+1N1rjWnvw4usn9wJFzpg5BM5ooiErHFNY4N73YoCVI67Rplq9yvRYkTA6Db5vcKhnYv1Wxv0RpOt5Mhii8=
X-Received: by 2002:a05:6512:340a:b0:4fb:bef0:948e with SMTP id
 i10-20020a056512340a00b004fbbef0948emr3471380lfr.5.1695237033303; Wed, 20 Sep
 2023 12:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
 <20230917213803.20683-24-kariem.taha2.7@gmail.com>
In-Reply-To: <20230917213803.20683-24-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 20 Sep 2023 20:10:22 +0100
Message-ID: <CANCZdfowd_9_uv1wxvk9jkLqXcBAakenEJsCBygcY5+RW6Jhsg@mail.gmail.com>
Subject: Re: [PATCH v2 23/28] bsd-user: Implement wait4(2) and wait6(2) system
 calls.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="0000000000002e394a0605cf21e4"
Received-SPF: none client-ip=2a00:1450:4864:20::234;
 envelope-from=wlosh@bsdimp.com; helo=mail-lj1-x234.google.com
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

--0000000000002e394a0605cf21e4
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
>  bsd-user/freebsd/os-proc.h    | 77 +++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c | 15 +++++++
>  2 files changed, 92 insertions(+)
>
> diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
> index 75ed39f8dd..8a0b6e25bb 100644
> --- a/bsd-user/freebsd/os-proc.h
> +++ b/bsd-user/freebsd/os-proc.h
> @@ -30,6 +30,10 @@
>
>  #include "target_arch_cpu.h"
>
> +pid_t safe_wait4(pid_t wpid, int *status, int options, struct rusage
> *rusage);
> +pid_t safe_wait6(idtype_t idtype, id_t id, int *status, int options,
> +    struct __wrusage *wrusage, siginfo_t *infop);
> +
>  /* execve(2) */
>  static inline abi_long do_freebsd_execve(abi_ulong path_or_fd, abi_ulong
> argp,
>          abi_ulong envp)
> @@ -46,4 +50,77 @@ static inline abi_long do_freebsd_fexecve(abi_ulong
> path_or_fd, abi_ulong argp,
>      return freebsd_exec_common(path_or_fd, argp, envp, 1);
>  }
>
> +/* wait4(2) */
> +static inline abi_long do_freebsd_wait4(abi_long arg1, abi_ulong
> target_status,
> +        abi_long arg3, abi_ulong target_rusage)
> +{
> +    abi_long ret;
> +    int status;
> +    struct rusage rusage, *rusage_ptr =3D NULL;
> +
> +    if (target_rusage) {
> +        rusage_ptr =3D &rusage;
> +    }
> +    ret =3D get_errno(safe_wait4(arg1, &status, arg3, rusage_ptr));
> +    if (target_status !=3D 0) {
> +        status =3D host_to_target_waitstatus(status);
> +        if (put_user_s32(status, target_status) !=3D 0) {
> +            return -TARGET_EFAULT;
> +        }
> +    }
> +    if (target_rusage !=3D 0) {
> +        host_to_target_rusage(target_rusage, &rusage);
> +    }
> +    return ret;
>

I think that both of these 'if' statements should only be done if ret =3D=
=3D 0.
Otherwise
it's an error return which doesn't usually write any arguments (unless the
error
is because of a fault on trying to write a return value).

Warner


> +}
> +
> +/* wait6(2) */
> +static inline abi_long do_freebsd_wait6(void *cpu_env, abi_long idtype,
> +    abi_long id1, abi_long id2,
> +    abi_ulong target_status, abi_long options, abi_ulong target_wrusage,
> +    abi_ulong target_infop, abi_ulong pad1)
> +{
> +    abi_long ret;
> +    int status;
> +    struct __wrusage wrusage, *wrusage_ptr =3D NULL;
> +    siginfo_t info;
> +    void *p;
> +
> +    if (regpairs_aligned(cpu_env) !=3D 0) {
> +        /* printf("shifting args\n"); */
> +        /* 64-bit id is aligned, so shift all the arguments over by one =
*/
> +        id1 =3D id2;
> +        id2 =3D target_status;
> +        target_status =3D options;
> +        options =3D target_wrusage;
> +        target_wrusage =3D target_infop;
> +        target_infop =3D pad1;
> +    }
> +
> +    if (target_wrusage) {
> +        wrusage_ptr =3D &wrusage;
> +    }
> +    ret =3D safe_wait6(idtype, target_arg64(id1, id2),
> +                     &status, options, wrusage_ptr, &info);
> +    ret =3D get_errno(ret);
> +    if (target_status !=3D 0) {
> +        status =3D host_to_target_waitstatus(status);
> +        if (put_user_s32(status, target_status) !=3D 0) {
> +            return -TARGET_EFAULT;
> +        }
> +    }
> +    if (target_wrusage !=3D 0) {
> +        host_to_target_wrusage(target_wrusage, &wrusage);
> +    }
> +    if (target_infop !=3D 0) {
> +        p =3D lock_user(VERIFY_WRITE, target_infop,
> sizeof(target_siginfo_t), 0);
> +        if (p =3D=3D NULL) {
> +            return -TARGET_EFAULT;
> +        }
> +        host_to_target_siginfo(p, &info);
> +        unlock_user(p, target_infop, sizeof(target_siginfo_t));
> +    }
> +    return ret;
> +}
> +
>  #endif /* BSD_USER_FREEBSD_OS_PROC_H */
> diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.=
c
> index 515eaaf31f..55e68e4815 100644
> --- a/bsd-user/freebsd/os-syscall.c
> +++ b/bsd-user/freebsd/os-syscall.c
> @@ -40,6 +40,12 @@
>  #include "os-stat.h"
>  #include "os-proc.h"
>
> +/* used in os-proc */
> +safe_syscall4(pid_t, wait4, pid_t, wpid, int *, status, int, options,
> +    struct rusage *, rusage);
> +safe_syscall6(pid_t, wait6, idtype_t, idtype, id_t, id, int *, status,
> int,
> +    options, struct __wrusage *, wrusage, siginfo_t *, infop);
> +
>  /* I/O */
>  safe_syscall3(int, open, const char *, path, int, flags, mode_t, mode);
>  safe_syscall4(int, openat, int, fd, const char *, path, int, flags,
> mode_t,
> @@ -228,6 +234,15 @@ static abi_long freebsd_syscall(void *cpu_env, int
> num, abi_long arg1,
>          ret =3D do_freebsd_fexecve(arg1, arg2, arg3);
>          break;
>
> +    case TARGET_FREEBSD_NR_wait4: /* wait4(2) */
> +        ret =3D do_freebsd_wait4(arg1, arg2, arg3, arg4);
> +        break;
> +
> +    case TARGET_FREEBSD_NR_wait6: /* wait6(2) */
> +        ret =3D do_freebsd_wait6(cpu_env, arg1, arg2, arg3,
> +                               arg4, arg5, arg6, arg7, arg8);
> +        break;
> +
>      case TARGET_FREEBSD_NR_exit: /* exit(2) */
>          ret =3D do_bsd_exit(cpu_env, arg1);
>          break;
> --
> 2.42.0
>
>

--0000000000002e394a0605cf21e4
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
=C2=A0bsd-user/freebsd/os-proc.h=C2=A0 =C2=A0 | 77 ++++++++++++++++++++++++=
+++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c | 15 +++++++<br>
=C2=A02 files changed, 92 insertions(+)<br>
<br>
diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h<br>
index 75ed39f8dd..8a0b6e25bb 100644<br>
--- a/bsd-user/freebsd/os-proc.h<br>
+++ b/bsd-user/freebsd/os-proc.h<br>
@@ -30,6 +30,10 @@<br>
<br>
=C2=A0#include &quot;target_arch_cpu.h&quot;<br>
<br>
+pid_t safe_wait4(pid_t wpid, int *status, int options, struct rusage *rusa=
ge);<br>
+pid_t safe_wait6(idtype_t idtype, id_t id, int *status, int options,<br>
+=C2=A0 =C2=A0 struct __wrusage *wrusage, siginfo_t *infop);<br>
+<br>
=C2=A0/* execve(2) */<br>
=C2=A0static inline abi_long do_freebsd_execve(abi_ulong path_or_fd, abi_ul=
ong argp,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0abi_ulong envp)<br>
@@ -46,4 +50,77 @@ static inline abi_long do_freebsd_fexecve(abi_ulong path=
_or_fd, abi_ulong argp,<br>
=C2=A0 =C2=A0 =C2=A0return freebsd_exec_common(path_or_fd, argp, envp, 1);<=
br>
=C2=A0}<br>
<br>
+/* wait4(2) */<br>
+static inline abi_long do_freebsd_wait4(abi_long arg1, abi_ulong target_st=
atus,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_long arg3, abi_ulong target_rusage)<br>
+{<br>
+=C2=A0 =C2=A0 abi_long ret;<br>
+=C2=A0 =C2=A0 int status;<br>
+=C2=A0 =C2=A0 struct rusage rusage, *rusage_ptr =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 if (target_rusage) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rusage_ptr =3D &amp;rusage;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 ret =3D get_errno(safe_wait4(arg1, &amp;status, arg3, rusage=
_ptr));<br>
+=C2=A0 =C2=A0 if (target_status !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D host_to_target_waitstatus(status);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (put_user_s32(status, target_status) !=3D 0=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (target_rusage !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_to_target_rusage(target_rusage, &amp;rusa=
ge);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return ret;<br></blockquote><div><br></div><div>I think that=
 both of these &#39;if&#39; statements should only be done if ret =3D=3D 0.=
 Otherwise</div><div>it&#39;s an error return which doesn&#39;t usually wri=
te any arguments (unless the error</div><div>is because of a fault on tryin=
g to write a return value).</div><div><br></div><div>Warner</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+}<br>
+<br>
+/* wait6(2) */<br>
+static inline abi_long do_freebsd_wait6(void *cpu_env, abi_long idtype,<br=
>
+=C2=A0 =C2=A0 abi_long id1, abi_long id2,<br>
+=C2=A0 =C2=A0 abi_ulong target_status, abi_long options, abi_ulong target_=
wrusage,<br>
+=C2=A0 =C2=A0 abi_ulong target_infop, abi_ulong pad1)<br>
+{<br>
+=C2=A0 =C2=A0 abi_long ret;<br>
+=C2=A0 =C2=A0 int status;<br>
+=C2=A0 =C2=A0 struct __wrusage wrusage, *wrusage_ptr =3D NULL;<br>
+=C2=A0 =C2=A0 siginfo_t info;<br>
+=C2=A0 =C2=A0 void *p;<br>
+<br>
+=C2=A0 =C2=A0 if (regpairs_aligned(cpu_env) !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* printf(&quot;shifting args\n&quot;); */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 64-bit id is aligned, so shift all the argu=
ments over by one */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 id1 =3D id2;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 id2 =3D target_status;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_status =3D options;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 options =3D target_wrusage;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_wrusage =3D target_infop;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_infop =3D pad1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (target_wrusage) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wrusage_ptr =3D &amp;wrusage;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 ret =3D safe_wait6(idtype, target_arg64(id1, id2),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&amp;status, options, wrusage_ptr, &amp;info);<br>
+=C2=A0 =C2=A0 ret =3D get_errno(ret);<br>
+=C2=A0 =C2=A0 if (target_status !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D host_to_target_waitstatus(status);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (put_user_s32(status, target_status) !=3D 0=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (target_wrusage !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_to_target_wrusage(target_wrusage, &amp;wr=
usage);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (target_infop !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 p =3D lock_user(VERIFY_WRITE, target_infop, si=
zeof(target_siginfo_t), 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (p =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_to_target_siginfo(p, &amp;info);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unlock_user(p, target_infop, sizeof(target_sig=
info_t));<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
=C2=A0#endif /* BSD_USER_FREEBSD_OS_PROC_H */<br>
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c<=
br>
index 515eaaf31f..55e68e4815 100644<br>
--- a/bsd-user/freebsd/os-syscall.c<br>
+++ b/bsd-user/freebsd/os-syscall.c<br>
@@ -40,6 +40,12 @@<br>
=C2=A0#include &quot;os-stat.h&quot;<br>
=C2=A0#include &quot;os-proc.h&quot;<br>
<br>
+/* used in os-proc */<br>
+safe_syscall4(pid_t, wait4, pid_t, wpid, int *, status, int, options,<br>
+=C2=A0 =C2=A0 struct rusage *, rusage);<br>
+safe_syscall6(pid_t, wait6, idtype_t, idtype, id_t, id, int *, status, int=
,<br>
+=C2=A0 =C2=A0 options, struct __wrusage *, wrusage, siginfo_t *, infop);<b=
r>
+<br>
=C2=A0/* I/O */<br>
=C2=A0safe_syscall3(int, open, const char *, path, int, flags, mode_t, mode=
);<br>
=C2=A0safe_syscall4(int, openat, int, fd, const char *, path, int, flags, m=
ode_t,<br>
@@ -228,6 +234,15 @@ static abi_long freebsd_syscall(void *cpu_env, int num=
, abi_long arg1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D do_freebsd_fexecve(arg1, arg2, ar=
g3);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
+=C2=A0 =C2=A0 case TARGET_FREEBSD_NR_wait4: /* wait4(2) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_freebsd_wait4(arg1, arg2, arg3, arg=
4);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case TARGET_FREEBSD_NR_wait6: /* wait6(2) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_freebsd_wait6(cpu_env, arg1, arg2, =
arg3,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arg4, arg5, arg6, arg7, arg8);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0case TARGET_FREEBSD_NR_exit: /* exit(2) */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D do_bsd_exit(cpu_env, arg1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-- <br>
2.42.0<br>
<br>
</blockquote></div></div>

--0000000000002e394a0605cf21e4--

