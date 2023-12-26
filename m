Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7002281EAB8
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 00:07:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIGV1-0006oK-R9; Tue, 26 Dec 2023 18:06:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1rIGUz-0006o9-HK
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 18:06:09 -0500
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1rIGUx-0005hl-Ej
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 18:06:09 -0500
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-427b515c2bbso841661cf.0
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 15:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1703631966; x=1704236766; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=msSW2nHGiP/D9t3po8an3pSGdWwnchr7w150pK9FVEs=;
 b=GCOSbPLc7x9PYtl2YDqlOl4Y+iHd6Xtr97b9KbGQkLBtTvrQNVcCtpYZ89PllSpRgn
 RRJ9rdcjI1pVA0/7CnlkQS1+oxRGOR0J/RHef4QVYEdrjwcJ8IBP3+bxrQDSmZpMSvXl
 ptzgBvCaHd1LEo5/7e6324xocdEbqTJG0GUFUQLgfRraZ/bd/E6rhjJt8U9Oct9TA6Ok
 4zXHXay4qa2lPLRVlAaA7XEJ325iu5XZJmV/UGht0X2oQUVGyyChPzrvyb+nLF1T/lMi
 H/d3+tsUETHzz1ehFmZAIsf3a4Lb81HVCmPahhvzh6xoJC7CtiVxZNSlOCs+ZFYJHC1a
 JKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703631966; x=1704236766;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=msSW2nHGiP/D9t3po8an3pSGdWwnchr7w150pK9FVEs=;
 b=gMmhb5YDf5L1mizAFBeWuKTBSOvJydRFZyNdeV86CKpTiLQ139kRhNididrTXrUITq
 wXqIJEqLwtMzc9m+sKtgDlCDYBKC35l5x3MUm5PRGSnbXaVqXRKW+MVvCfNSv2aokTyG
 QeqiIXL2TnhTlE2HzOslgyiqlAHD/nOsXS7pNhzmTdLRbsm0Y/XuqvoZaVT5mi8j1RkE
 8Tp7sZJC7W1dq9e3EznQvxOLZwQNTR4QD8QU+n3RdHJ9gHfg7sMV5y+c1nl4pIvQNqFC
 6bK9TQ4WnLNIO+kQtrIBY7fH4dT3eCwsWx9RIUPqLw96/A4O8/O8c5b+/U2daVnfJYS/
 lsbw==
X-Gm-Message-State: AOJu0Ywnz3pqhC+9/oPVtfesOMa6Vf29BpuGD6AhvzGdnHtzhQi30nXY
 bIqNNnVoebA+r2sK35SvAtD44l/qtR/pcjvMkuVq2oAa52CUePgS35ejYoiLxIIA
X-Google-Smtp-Source: AGHT+IEnPFuv8UVeZ5k4N4iVmvhJbw3UVhxkDPPcgCYZ1ZDwgybIMPSEUp46bMVsfGXHCdB4EpDJ0xlWjJp1COWGuPw=
X-Received: by 2002:a05:622a:178e:b0:427:ea7f:e746 with SMTP id
 s14-20020a05622a178e00b00427ea7fe746mr63923qtk.7.1703631965431; Tue, 26 Dec
 2023 15:06:05 -0800 (PST)
MIME-Version: 1.0
References: <20231208224207.613445-1-scw@google.com>
 <20231208224207.613445-3-scw@google.com>
In-Reply-To: <20231208224207.613445-3-scw@google.com>
From: Shu-Chun Weng <scw@google.com>
Date: Tue, 26 Dec 2023 15:05:51 -0800
Message-ID: <CAF3nBxj=TPNeugGhG=zTR6uMurvW2RxJQeM2jnQzPZx7vBycuQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] linux-user: Fix openat() emulation to not modify
 atime
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="00000000000029cb4d060d71ba39"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=scw@google.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--00000000000029cb4d060d71ba39
Content-Type: multipart/alternative; boundary="00000000000020f3af060d71ba72"

--00000000000020f3af060d71ba72
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping~

On Fri, Dec 8, 2023 at 2:42=E2=80=AFPM Shu-Chun Weng <scw@google.com> wrote=
:

> Commit b8002058 strengthened openat()'s /proc detection by calling
> realpath(3) on the given path, which allows various paths and symlinks
> that points to the /proc file system to be intercepted correctly.
>
> Using realpath(3), though, has a side effect that it reads the symlinks
> along the way, and thus changes their atime. The results in the
> following code snippet already get ~now instead of the real atime:
>
>   int fd =3D open("/path/to/a/symlink", O_PATH | O_NOFOLLOW);
>   struct stat st;
>   fstat(fd, st);
>   return st.st_atime;
>
> This change opens a path that doesn't appear to be part of /proc
> directly and checks the destination of /proc/self/fd/n to determine if
> it actually refers to a file in /proc.
>
> Neither this nor the existing code works with symlinks or indirect paths
> (e.g.  /tmp/../proc/self/exe) that points to /proc/self/exe because it
> is itself a symlink, and both realpath(3) and /proc/self/fd/n will
> resolve into the location of QEMU.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2004
> Signed-off-by: Shu-Chun Weng <scw@google.com>
> ---
>  linux-user/syscall.c | 47 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 38 insertions(+), 9 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index e384e14248..7c3772301f 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8308,8 +8308,7 @@ static int open_net_route(CPUArchState *cpu_env, in=
t
> fd)
>  int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
>                      int flags, mode_t mode, bool safe)
>  {
> -    g_autofree char *proc_name =3D NULL;
> -    const char *pathname;
> +    g_autofree char *pathname =3D NULL;
>      struct fake_open {
>          const char *filename;
>          int (*fill)(CPUArchState *cpu_env, int fd);
> @@ -8334,12 +8333,42 @@ int do_guest_openat(CPUArchState *cpu_env, int
> dirfd, const char *fname,
>          { NULL, NULL, NULL }
>      };
>
> -    /* if this is a file from /proc/ filesystem, expand full name */
> -    proc_name =3D realpath(fname, NULL);
> -    if (proc_name && strncmp(proc_name, "/proc/", 6) =3D=3D 0) {
> -        pathname =3D proc_name;
> +    if (strncmp(fname, "/proc/", 6) =3D=3D 0) {
> +        pathname =3D g_strdup(fname);
>      } else {
> -        pathname =3D fname;
> +        g_autofree char *proc_name =3D NULL;
> +        struct stat proc_stat;
> +        int fd;
> +
> +        if (safe) {
> +            fd =3D safe_openat(dirfd, path(fname), flags, mode);
> +        } else {
> +            fd =3D openat(dirfd, path(fname), flags, mode);
> +        }
> +        if (fd < 0) {
> +            return fd;
> +        }
> +
> +        /*
> +         * Try to get the real path of the file we just opened. We avoid
> calling
> +         * `realpath(3)` because it calls `readlink(2)` on symlinks whic=
h
> +         * changes their atime. Note that since `/proc/self/exe` is a
> symlink,
> +         * `pathname` will never resolve to it (neither will
> `realpath(3)`).
> +         * That's why we check `fname` against the "/proc/" prefix first=
.
> +         */
> +        proc_name =3D g_strdup_printf("/proc/self/fd/%d", fd);
> +        if (lstat(proc_name, &proc_stat) < 0 ||
> !S_ISLNK(proc_stat.st_mode)) {
> +            /* No procfs or something weird. Not going to dig further. *=
/
> +            return fd;
> +        }
> +        pathname =3D g_new(char, proc_stat.st_size + 1);
> +        readlink(proc_name, pathname, proc_stat.st_size + 1);
> +
> +        /* if this is not a file from /proc/ filesystem, the fd is good
> as-is */
> +        if (strncmp(pathname, "/proc/", 6) !=3D 0) {
> +            return fd;
> +        }
> +        close(fd);
>      }
>
>      if (is_proc_myself(pathname, "exe")) {
> @@ -8390,9 +8419,9 @@ int do_guest_openat(CPUArchState *cpu_env, int
> dirfd, const char *fname,
>      }
>
>      if (safe) {
> -        return safe_openat(dirfd, path(pathname), flags, mode);
> +        return safe_openat(dirfd, pathname, flags, mode);
>      } else {
> -        return openat(dirfd, path(pathname), flags, mode);
> +        return openat(dirfd, pathname, flags, mode);
>      }
>  }
>
>

--00000000000020f3af060d71ba72
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">ping~<br></div><br><div class=3D"gmail_quote"><div dir=3D"=
ltr" class=3D"gmail_attr">On Fri, Dec 8, 2023 at 2:42=E2=80=AFPM Shu-Chun W=
eng &lt;<a href=3D"mailto:scw@google.com">scw@google.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">Commit b8002058 str=
engthened openat()&#39;s /proc detection by calling<br>
realpath(3) on the given path, which allows various paths and symlinks<br>
that points to the /proc file system to be intercepted correctly.<br>
<br>
Using realpath(3), though, has a side effect that it reads the symlinks<br>
along the way, and thus changes their atime. The results in the<br>
following code snippet already get ~now instead of the real atime:<br>
<br>
=C2=A0 int fd =3D open(&quot;/path/to/a/symlink&quot;, O_PATH | O_NOFOLLOW)=
;<br>
=C2=A0 struct stat st;<br>
=C2=A0 fstat(fd, st);<br>
=C2=A0 return st.st_atime;<br>
<br>
This change opens a path that doesn&#39;t appear to be part of /proc<br>
directly and checks the destination of /proc/self/fd/n to determine if<br>
it actually refers to a file in /proc.<br>
<br>
Neither this nor the existing code works with symlinks or indirect paths<br=
>
(e.g.=C2=A0 /tmp/../proc/self/exe) that points to /proc/self/exe because it=
<br>
is itself a symlink, and both realpath(3) and /proc/self/fd/n will<br>
resolve into the location of QEMU.<br>
<br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2004" re=
l=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/i=
ssues/2004</a><br>
Signed-off-by: Shu-Chun Weng &lt;<a href=3D"mailto:scw@google.com" target=
=3D"_blank">scw@google.com</a>&gt;<br>
---<br>
=C2=A0linux-user/syscall.c | 47 +++++++++++++++++++++++++++++++++++--------=
-<br>
=C2=A01 file changed, 38 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/linux-user/syscall.c b/linux-user/syscall.c<br>
index e384e14248..7c3772301f 100644<br>
--- a/linux-user/syscall.c<br>
+++ b/linux-user/syscall.c<br>
@@ -8308,8 +8308,7 @@ static int open_net_route(CPUArchState *cpu_env, int =
fd)<br>
=C2=A0int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fna=
me,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0int flags, mode_t mode, bool safe)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 g_autofree char *proc_name =3D NULL;<br>
-=C2=A0 =C2=A0 const char *pathname;<br>
+=C2=A0 =C2=A0 g_autofree char *pathname =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0struct fake_open {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *filename;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int (*fill)(CPUArchState *cpu_env, int fd=
);<br>
@@ -8334,12 +8333,42 @@ int do_guest_openat(CPUArchState *cpu_env, int dirf=
d, const char *fname,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ NULL, NULL, NULL }<br>
=C2=A0 =C2=A0 =C2=A0};<br>
<br>
-=C2=A0 =C2=A0 /* if this is a file from /proc/ filesystem, expand full nam=
e */<br>
-=C2=A0 =C2=A0 proc_name =3D realpath(fname, NULL);<br>
-=C2=A0 =C2=A0 if (proc_name &amp;&amp; strncmp(proc_name, &quot;/proc/&quo=
t;, 6) =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pathname =3D proc_name;<br>
+=C2=A0 =C2=A0 if (strncmp(fname, &quot;/proc/&quot;, 6) =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pathname =3D g_strdup(fname);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pathname =3D fname;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *proc_name =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct stat proc_stat;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int fd;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (safe) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fd =3D safe_openat(dirfd, path(f=
name), flags, mode);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fd =3D openat(dirfd, path(fname)=
, flags, mode);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return fd;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Try to get the real path of the file w=
e just opened. We avoid calling<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* `realpath(3)` because it calls `readli=
nk(2)` on symlinks which<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* changes their atime. Note that since `=
/proc/self/exe` is a symlink,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* `pathname` will never resolve to it (n=
either will `realpath(3)`).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* That&#39;s why we check `fname` agains=
t the &quot;/proc/&quot; prefix first.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 proc_name =3D g_strdup_printf(&quot;/proc/self=
/fd/%d&quot;, fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (lstat(proc_name, &amp;proc_stat) &lt; 0 ||=
 !S_ISLNK(proc_stat.st_mode)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* No procfs or something weird.=
 Not going to dig further. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return fd;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pathname =3D g_new(char, proc_stat.st_size + 1=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 readlink(proc_name, pathname, proc_stat.st_siz=
e + 1);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* if this is not a file from /proc/ filesyste=
m, the fd is good as-is */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strncmp(pathname, &quot;/proc/&quot;, 6) !=
=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return fd;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(fd);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (is_proc_myself(pathname, &quot;exe&quot;)) {<br>
@@ -8390,9 +8419,9 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd,=
 const char *fname,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (safe) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return safe_openat(dirfd, path(pathname), flag=
s, mode);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return safe_openat(dirfd, pathname, flags, mod=
e);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return openat(dirfd, path(pathname), flags, mo=
de);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return openat(dirfd, pathname, flags, mode);<b=
r>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
</blockquote></div>

--00000000000020f3af060d71ba72--

--00000000000029cb4d060d71ba39
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPoAYJKoZIhvcNAQcCoIIPkTCCD40CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz6MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
ntFX6HMwVwYDVR0gBFAwTjAJBgdngQwBBQEBMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZo
dHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAMBgNVHRMBAf8EAjAAMIGaBggr
BgEFBQcBAQSBjTCBijA+BggrBgEFBQcwAYYyaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vY2Ev
Z3NhdGxhc3Izc21pbWVjYTIwMjAwSAYIKwYBBQUHMAKGPGh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2ln
bi5jb20vY2FjZXJ0L2dzYXRsYXNyM3NtaW1lY2EyMDIwLmNydDAfBgNVHSMEGDAWgBR8zApo16Lr
HixyG9HNXZVvjfvyYzBGBgNVHR8EPzA9MDugOaA3hjVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29t
L2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwLmNybDANBgkqhkiG9w0BAQsFAAOCAQEATNQsRyrYexxI
brRqQbycsBDuR8bKRXtZnWRKoKbLkP5WUoyTziRQxX87y7t5+HulkvcHv+iN4NXsE34NBcNJhtGs
D4jXPDYBUkCheUTRNezlU3uo9XegMj7CpgPAjve1C5bX0003iXWpE+61UbPqCJc8Ko/i3BP6qUNJ
rt0xX6FSMibe3h3vhJzRuHp0SHtU4XuQDeyeMPo2dS15ZbRgi62k+I4BIw1XPnzpFDB+Vqqg4ezU
9lycvOtLk6T5oBrG1F+SDG8tm5M9e3XxEGez5FPSgkLTfQOCcDMzYQfmWL2NgB3FV/4REZLeoHd1
mbTKETYl94c2zp85DnzksvjWADGCAmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoT
EEdsb2JhbFNpZ24gbnYtc2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0Eg
MjAyMAIQAT8LWTW8LldwYsDkJlcz3zANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQg
WRh3bgWPK3KcqOLvLY8ATBzXkwQe1VrBGL9Wbi3DoCEwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjMxMjI2MjMwNjA2WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjAL
BgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBADcoxvCOVeic8izJ88um
z8u0idBnMqAQza2shVazlp1jfsD1X4R+Joq92TLjybnMmMDUW9Brv/TvR4XDxi/xCPxhcMKLn044
JMJMEXBpKd+6+ZBaofjOxtvSUBDsFO4N2Z0y7CGuC8YXaHJUxuUBYBZSVlJ5JSnXsupLGaUt7RWI
HYIIEpu4wEmzMsEQXaf910AzPVvGzhnWIlvfhdhDfvaVXM8YJmHazV8032JkoszyuxfZMyKbNk/L
LddxTGI/rtads1ztm1ZhTIX09IJx+8VNQOmwx9h/VEDZs/DfWNxaUhUYcmGaH/EB5KtnfEa+X22N
2hiSNZ2P1xGqS9f5/6E=
--00000000000029cb4d060d71ba39--

