Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 542E57A8C3F
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 21:06:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj2WF-0001sQ-O1; Wed, 20 Sep 2023 15:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj2WC-0001qb-EQ
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 15:05:48 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj2W7-0000K9-7F
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 15:05:46 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-530ce262ab2so74647a12.1
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 12:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695236740; x=1695841540;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fAx+qiagUvqMJjrh07FFLUBHvv3Z17w8OOrqxqu86Tg=;
 b=mfhGoC65a1P7YSOymIOPPyBctbDaPbfex73RS3bhMa3rxjIDjtVw6Rn9cnQ/Zju+QO
 RP5GxxZ7Gcvr0dY2xKBJJZoiDJpr28Pu6JzYkfGcWGu+1zOHp3HISWZqML3CUCBgY9/x
 S5imwEZTBfk/3CiSa+phL+eJm0vP+51sISO1r3LnH614ETQrfIf7sZUxp47iCxk8qmjA
 3+pkfmWAIpkoSfuUEh41PrE+1MVnY6OJh2J6Rue+kFNo39RlJ8a5pQRnkL8ofPZvU+4L
 KInWQMdL7v/lFUT8fp314/SZM9VAp8M1SVq4FiISJ+ibvo4+rio+uCrrFQKy8G+hbSxC
 gn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695236740; x=1695841540;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fAx+qiagUvqMJjrh07FFLUBHvv3Z17w8OOrqxqu86Tg=;
 b=pdXdMXJqTNw4X/jjgpf0wYRLHOajVmAUXYIKHPTeu4aQbBnX7G2R9QdoClJ/Bqy6Ot
 iY4L8qsK7HlTBtzLWdQOvp368sKHXNsF1xBypURSKrOe/XD5OZlYPoSRImrVRi3E0NkT
 htmfRwTUompvis2kz9mqZmi+q/4JqqwLpZzRASL1WyNEQcLxkr3fzfm084JRoUlFmB6U
 sBE2g2lP1gw97my4+addEnD1h2LhvP7ZMs8SGiYI7ZX3aiJfZOWbHEzL+yvWfYJt778A
 cAjOJFUwG6bVH6LK4Ng8g5oh9JPVsUvzwq57C4nq/sjgg1UJcu6gmg7ZajUNXE3U/kaB
 1mtw==
X-Gm-Message-State: AOJu0Yy9d/0d0Ohkku6yZCzw/FM3TcRDkBnDwhkBvH3q1sp2nSwTrYHs
 cgPkR8rMQ1i3WdWLf18jw4hL4Fq15s2Y/4bQW5RoD7Dv1QFzS1WAd7SSGKHB
X-Google-Smtp-Source: AGHT+IEWWOIXDjY5EDlMi9IB2BpAgpggzSnx0+8sGEuoxFFFOOv9LvLfbG4Hv118VdlgPd5GSExcKn+9vH0ncN45AmY=
X-Received: by 2002:aa7:c547:0:b0:522:31d5:ee8e with SMTP id
 s7-20020aa7c547000000b0052231d5ee8emr3102071edr.8.1695236740243; Wed, 20 Sep
 2023 12:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
 <20230917213803.20683-23-kariem.taha2.7@gmail.com>
In-Reply-To: <20230917213803.20683-23-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 20 Sep 2023 20:05:29 +0100
Message-ID: <CANCZdfoLQASRaEppi2+k1ZeeNv6tF9r4_dCh96YR7hEXUS+M0Q@mail.gmail.com>
Subject: Re: [PATCH v2 22/28] bsd-user: Implement execve(2) and fexecve(2)
 system calls.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000b67ea80605cf0fcc"
Received-SPF: none client-ip=2a00:1450:4864:20::530;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x530.google.com
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

--000000000000b67ea80605cf0fcc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 10:39=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.c=
om>
wrote:

> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  bsd-user/freebsd/os-proc.h    | 49 +++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c | 11 +++++++-
>  2 files changed, 59 insertions(+), 1 deletion(-)
>  create mode 100644 bsd-user/freebsd/os-proc.h
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

But make sure that the guard variable name is correct, I think with scripts=
/
clean-header-guards.pl


> diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
> new file mode 100644
> index 0000000000..75ed39f8dd
> --- /dev/null
> +++ b/bsd-user/freebsd/os-proc.h
> @@ -0,0 +1,49 @@
> +/*
> + *  process related system call shims and definitions
> + *
> + *  Copyright (c) 2013-14 Stacey D. Son
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef BSD_USER_FREEBSD_OS_PROC_H
> +#define BSD_USER_FREEBSD_OS_PROC_H
> +
> +#include <sys/param.h>
> +#include <sys/procctl.h>
> +#include <sys/signal.h>
> +#include <sys/types.h>
> +#include <sys/procdesc.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +
> +#include "target_arch_cpu.h"
> +
> +/* execve(2) */
> +static inline abi_long do_freebsd_execve(abi_ulong path_or_fd, abi_ulong
> argp,
> +        abi_ulong envp)
> +{
> +
> +    return freebsd_exec_common(path_or_fd, argp, envp, 0);
> +}
> +
> +/* fexecve(2) */
> +static inline abi_long do_freebsd_fexecve(abi_ulong path_or_fd, abi_ulon=
g
> argp,
> +        abi_ulong envp)
> +{
> +
> +    return freebsd_exec_common(path_or_fd, argp, envp, 1);
> +}
> +
> +#endif /* BSD_USER_FREEBSD_OS_PROC_H */
> diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.=
c
> index b7bd0b92a6..515eaaf31f 100644
> --- a/bsd-user/freebsd/os-syscall.c
> +++ b/bsd-user/freebsd/os-syscall.c
> @@ -36,8 +36,9 @@
>  #include "bsd-file.h"
>  #include "bsd-proc.h"
>
> -/* *BSD dependent syscall shims */
> +/* BSD dependent syscall shims */
>  #include "os-stat.h"
> +#include "os-proc.h"
>
>  /* I/O */
>  safe_syscall3(int, open, const char *, path, int, flags, mode_t, mode);
> @@ -219,6 +220,14 @@ static abi_long freebsd_syscall(void *cpu_env, int
> num, abi_long arg1,
>          /*
>           * process system calls
>           */
> +    case TARGET_FREEBSD_NR_execve: /* execve(2) */
> +        ret =3D do_freebsd_execve(arg1, arg2, arg3);
> +        break;
> +
> +    case TARGET_FREEBSD_NR_fexecve: /* fexecve(2) */
> +        ret =3D do_freebsd_fexecve(arg1, arg2, arg3);
> +        break;
> +
>      case TARGET_FREEBSD_NR_exit: /* exit(2) */
>          ret =3D do_bsd_exit(cpu_env, arg1);
>          break;
> --
> 2.42.0
>
>

--000000000000b67ea80605cf0fcc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 17, 2023 at 10:39=E2=80=
=AFPM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.tah=
a2.7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/freebsd/os-proc.h=C2=A0 =C2=A0 | 49 ++++++++++++++++++++++++=
+++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c | 11 +++++++-<br>
=C2=A02 files changed, 59 insertions(+), 1 deletion(-)<br>
=C2=A0create mode 100644 bsd-user/freebsd/os-proc.h<br></blockquote><div><b=
r></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com"=
>imp@bsdimp.com</a>&gt;<br></div><div><br></div><div>But make sure that the=
 guard variable name is correct, I think with scripts/<a href=3D"http://cle=
an-header-guards.pl">clean-header-guards.pl</a></div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h<br>
new file mode 100644<br>
index 0000000000..75ed39f8dd<br>
--- /dev/null<br>
+++ b/bsd-user/freebsd/os-proc.h<br>
@@ -0,0 +1,49 @@<br>
+/*<br>
+ *=C2=A0 process related system call shims and definitions<br>
+ *<br>
+ *=C2=A0 Copyright (c) 2013-14 Stacey D. Son<br>
+ *<br>
+ *=C2=A0 This program is free software; you can redistribute it and/or mod=
ify<br>
+ *=C2=A0 it under the terms of the GNU General Public License as published=
 by<br>
+ *=C2=A0 the Free Software Foundation; either version 2 of the License, or=
<br>
+ *=C2=A0 (at your option) any later version.<br>
+ *<br>
+ *=C2=A0 This program is distributed in the hope that it will be useful,<b=
r>
+ *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty of<br=
>
+ *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See th=
e<br>
+ *=C2=A0 GNU General Public License for more details.<br>
+ *<br>
+ *=C2=A0 You should have received a copy of the GNU General Public License=
<br>
+ *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://www.gn=
u.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.org/li=
censes/</a>&gt;.<br>
+ */<br>
+<br>
+#ifndef BSD_USER_FREEBSD_OS_PROC_H<br>
+#define BSD_USER_FREEBSD_OS_PROC_H<br>
+<br>
+#include &lt;sys/param.h&gt;<br>
+#include &lt;sys/procctl.h&gt;<br>
+#include &lt;sys/signal.h&gt;<br>
+#include &lt;sys/types.h&gt;<br>
+#include &lt;sys/procdesc.h&gt;<br>
+#include &lt;sys/wait.h&gt;<br>
+#include &lt;unistd.h&gt;<br>
+<br>
+#include &quot;target_arch_cpu.h&quot;<br>
+<br>
+/* execve(2) */<br>
+static inline abi_long do_freebsd_execve(abi_ulong path_or_fd, abi_ulong a=
rgp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong envp)<br>
+{<br>
+<br>
+=C2=A0 =C2=A0 return freebsd_exec_common(path_or_fd, argp, envp, 0);<br>
+}<br>
+<br>
+/* fexecve(2) */<br>
+static inline abi_long do_freebsd_fexecve(abi_ulong path_or_fd, abi_ulong =
argp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong envp)<br>
+{<br>
+<br>
+=C2=A0 =C2=A0 return freebsd_exec_common(path_or_fd, argp, envp, 1);<br>
+}<br>
+<br>
+#endif /* BSD_USER_FREEBSD_OS_PROC_H */<br>
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c<=
br>
index b7bd0b92a6..515eaaf31f 100644<br>
--- a/bsd-user/freebsd/os-syscall.c<br>
+++ b/bsd-user/freebsd/os-syscall.c<br>
@@ -36,8 +36,9 @@<br>
=C2=A0#include &quot;bsd-file.h&quot;<br>
=C2=A0#include &quot;bsd-proc.h&quot;<br>
<br>
-/* *BSD dependent syscall shims */<br>
+/* BSD dependent syscall shims */<br>
=C2=A0#include &quot;os-stat.h&quot;<br>
+#include &quot;os-proc.h&quot;<br>
<br>
=C2=A0/* I/O */<br>
=C2=A0safe_syscall3(int, open, const char *, path, int, flags, mode_t, mode=
);<br>
@@ -219,6 +220,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num=
, abi_long arg1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * process system calls<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 case TARGET_FREEBSD_NR_execve: /* execve(2) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_freebsd_execve(arg1, arg2, arg3);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case TARGET_FREEBSD_NR_fexecve: /* fexecve(2) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_freebsd_fexecve(arg1, arg2, arg3);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0case TARGET_FREEBSD_NR_exit: /* exit(2) */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D do_bsd_exit(cpu_env, arg1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-- <br>
2.42.0<br>
<br>
</blockquote></div></div>

--000000000000b67ea80605cf0fcc--

