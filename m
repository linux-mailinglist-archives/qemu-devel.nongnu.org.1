Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC7181FB7D
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 23:16:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIyfK-0005aB-Dv; Thu, 28 Dec 2023 17:15:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1rIyfG-0005ZQ-0j
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:15:42 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1rIyfD-0006ez-Pa
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:15:41 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4279c2ada00so1575651cf.1
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 14:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1703801736; x=1704406536; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b2i/12dfZUNrI4IuTZe1nd/BJkF3Vn8FjEMGv7xUQro=;
 b=1yWpjtaY3EKwdgLKpgSWCVbNrjiqFwPEmW3JLwXP693y4QmpXenemS86XucAhOlRW6
 Vg/EG0iW4+3uiSKEVhew0VMGaDLRvu3dHY8s1DaMIvTbK1WB/HrroRI4bKQpHBWKukme
 TF3KrIGiqhtopU61ojrz2ugvUsobZiw5VZU8A70t/MXcLFvwnwNiP9jjEpPoYh9SR2Lb
 +RpHEMe1isByceqZxlT3IUBOWdXHvPUv810ejW9IlTchOqo//Zvzqm9iBIQwSIMwFeYI
 tqy+WawCA0bCRzyfx2K79a5feZBVSx/VFIrTdaX64/bIWo6I+emEDVaTQoMYBZ/WiJPG
 kc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703801736; x=1704406536;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b2i/12dfZUNrI4IuTZe1nd/BJkF3Vn8FjEMGv7xUQro=;
 b=TZKixz3sMwWMgERsMv85SbIYLmtoAFlHgsJkVm/5sfXqvYV4VtejVJqHN62tREyCg7
 grFrbNSo+/PW+tALGi2pecWo7cCSnTvJJgF77xfSvpMbgM7H+/Pp5bvCWPvidmunoTsT
 IA3SeGBYcoe8K7eTnxA4XjWQOOnBKRBWWsQ6Zk9199euAaamDLuqNuedclJXZ7nMl3sU
 2vdGP9vP+DxAgC7MDUGNsOkMovvcmP/yFLCCzLHFHImUQp0ADT/spD2H9eC0wCNaIG9s
 yxuTh2ueYk3D3C2AkorAAbg9J+TQWginkQodpfcpqOjftg0mATt3GPKSCTTX0gu8O0Fw
 3jPA==
X-Gm-Message-State: AOJu0YzmekYoTCTmoTZN4tTL68jxwZ3pjWHtbIdU2leOS58KQSFhnnDc
 1xHiiS5aUQ81pYCGQ44Ey70NlK9hlFZPNF8OT7PNXrQXadnT
X-Google-Smtp-Source: AGHT+IHqYecsWkpf93yjf6a29Hs295MarOyQo4lR3f1a3+FYuUBM6Qyxmf78ks++lYr3IDNbz6h4DRFHgwK/08pFqXI=
X-Received: by 2002:a05:622a:5cd:b0:427:e83d:c3ce with SMTP id
 d13-20020a05622a05cd00b00427e83dc3cemr447742qtb.27.1703801736417; Thu, 28 Dec
 2023 14:15:36 -0800 (PST)
MIME-Version: 1.0
References: <20231208224207.613445-1-scw@google.com>
 <20231208224207.613445-3-scw@google.com>
 <e7ce2432-aba7-4893-b828-7f5df6cbe9a6@gmx.de>
In-Reply-To: <e7ce2432-aba7-4893-b828-7f5df6cbe9a6@gmx.de>
From: Shu-Chun Weng <scw@google.com>
Date: Thu, 28 Dec 2023 14:15:21 -0800
Message-ID: <CAF3nBxi2Vbtr-Xj_JimygioYOcSC4YMixS6JdRwHO+rCSrBdjg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] linux-user: Fix openat() emulation to not modify
 atime
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000004b692e060d99412d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=scw@google.com; helo=mail-qt1-x832.google.com
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

--0000000000004b692e060d99412d
Content-Type: multipart/alternative; boundary="0000000000004492b1060d9941fc"

--0000000000004492b1060d9941fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yup, reproduced on a system with glibc built with fortified source. Sending
out version 4.

On Thu, Dec 28, 2023 at 7:49=E2=80=AFAM Helge Deller <deller@gmx.de> wrote:

> On 12/8/23 23:42, Shu-Chun Weng wrote:
> > Commit b8002058 strengthened openat()'s /proc detection by calling
> > realpath(3) on the given path, which allows various paths and symlinks
> > that points to the /proc file system to be intercepted correctly.
> >
> > Using realpath(3), though, has a side effect that it reads the symlinks
> > along the way, and thus changes their atime. The results in the
> > following code snippet already get ~now instead of the real atime:
> >
> >    int fd =3D open("/path/to/a/symlink", O_PATH | O_NOFOLLOW);
> >    struct stat st;
> >    fstat(fd, st);
> >    return st.st_atime;
> >
> > This change opens a path that doesn't appear to be part of /proc
> > directly and checks the destination of /proc/self/fd/n to determine if
> > it actually refers to a file in /proc.
> >
> > Neither this nor the existing code works with symlinks or indirect path=
s
> > (e.g.  /tmp/../proc/self/exe) that points to /proc/self/exe because it
> > is itself a symlink, and both realpath(3) and /proc/self/fd/n will
> > resolve into the location of QEMU.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2004
> > Signed-off-by: Shu-Chun Weng <scw@google.com>
> > ---
> >   linux-user/syscall.c | 47 +++++++++++++++++++++++++++++++++++--------=
-
> >   1 file changed, 38 insertions(+), 9 deletions(-)
> >
> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > index e384e14248..7c3772301f 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -8308,8 +8308,7 @@ static int open_net_route(CPUArchState *cpu_env,
> int fd)
> >   int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char
> *fname,
> >                       int flags, mode_t mode, bool safe)
> >   {
> > -    g_autofree char *proc_name =3D NULL;
> > -    const char *pathname;
> > +    g_autofree char *pathname =3D NULL;
> >       struct fake_open {
> >           const char *filename;
> >           int (*fill)(CPUArchState *cpu_env, int fd);
> > @@ -8334,12 +8333,42 @@ int do_guest_openat(CPUArchState *cpu_env, int
> dirfd, const char *fname,
> >           { NULL, NULL, NULL }
> >       };
> >
> > -    /* if this is a file from /proc/ filesystem, expand full name */
> > -    proc_name =3D realpath(fname, NULL);
> > -    if (proc_name && strncmp(proc_name, "/proc/", 6) =3D=3D 0) {
> > -        pathname =3D proc_name;
> > +    if (strncmp(fname, "/proc/", 6) =3D=3D 0) {
> > +        pathname =3D g_strdup(fname);
> >       } else {
> > -        pathname =3D fname;
> > +        g_autofree char *proc_name =3D NULL;
> > +        struct stat proc_stat;
> > +        int fd;
> > +
> > +        if (safe) {
> > +            fd =3D safe_openat(dirfd, path(fname), flags, mode);
> > +        } else {
> > +            fd =3D openat(dirfd, path(fname), flags, mode);
> > +        }
> > +        if (fd < 0) {
> > +            return fd;
> > +        }
> > +
> > +        /*
> > +         * Try to get the real path of the file we just opened. We
> avoid calling
> > +         * `realpath(3)` because it calls `readlink(2)` on symlinks
> which
> > +         * changes their atime. Note that since `/proc/self/exe` is a
> symlink,
> > +         * `pathname` will never resolve to it (neither will
> `realpath(3)`).
> > +         * That's why we check `fname` against the "/proc/" prefix
> first.
> > +         */
> > +        proc_name =3D g_strdup_printf("/proc/self/fd/%d", fd);
> > +        if (lstat(proc_name, &proc_stat) < 0 ||
> !S_ISLNK(proc_stat.st_mode)) {
> > +            /* No procfs or something weird. Not going to dig further.
> */
> > +            return fd;
> > +        }
> > +        pathname =3D g_new(char, proc_stat.st_size + 1);
> > +        readlink(proc_name, pathname, proc_stat.st_size + 1);
>
> this gives a build error for me:
> ./qemu/linux-user/syscall.c:8365:9: error: ignoring return value of
> =E2=80=98readlink=E2=80=99 declared with attribute =E2=80=98warn_unused_r=
esult=E2=80=99
> [-Werror=3Dunused-result]
>
> Other than that, this patch indeed fixes the issue #2004
>
> Reviewed-by: Helge Deller <deller@gmx.de>
>
>
> Helge
>
> > +
> > +        /* if this is not a file from /proc/ filesystem, the fd is goo=
d
> as-is */
> > +        if (strncmp(pathname, "/proc/", 6) !=3D 0) {
> > +            return fd;
> > +        }
> > +        close(fd);
> >       }
> >
> >       if (is_proc_myself(pathname, "exe")) {
> > @@ -8390,9 +8419,9 @@ int do_guest_openat(CPUArchState *cpu_env, int
> dirfd, const char *fname,
> >       }
> >
> >       if (safe) {
> > -        return safe_openat(dirfd, path(pathname), flags, mode);
> > +        return safe_openat(dirfd, pathname, flags, mode);
> >       } else {
> > -        return openat(dirfd, path(pathname), flags, mode);
> > +        return openat(dirfd, pathname, flags, mode);
> >       }
> >   }
> >
> >
>
>

--0000000000004492b1060d9941fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yup, reproduced on a system with glibc built with fortifie=
d source. Sending out version 4.<br></div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 28, 2023 at 7:49=E2=80=AFAM=
 Helge Deller &lt;<a href=3D"mailto:deller@gmx.de">deller@gmx.de</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 12/8/23 =
23:42, Shu-Chun Weng wrote:<br>
&gt; Commit b8002058 strengthened openat()&#39;s /proc detection by calling=
<br>
&gt; realpath(3) on the given path, which allows various paths and symlinks=
<br>
&gt; that points to the /proc file system to be intercepted correctly.<br>
&gt;<br>
&gt; Using realpath(3), though, has a side effect that it reads the symlink=
s<br>
&gt; along the way, and thus changes their atime. The results in the<br>
&gt; following code snippet already get ~now instead of the real atime:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 int fd =3D open(&quot;/path/to/a/symlink&quot;, O_PATH | =
O_NOFOLLOW);<br>
&gt;=C2=A0 =C2=A0 struct stat st;<br>
&gt;=C2=A0 =C2=A0 fstat(fd, st);<br>
&gt;=C2=A0 =C2=A0 return st.st_atime;<br>
&gt;<br>
&gt; This change opens a path that doesn&#39;t appear to be part of /proc<b=
r>
&gt; directly and checks the destination of /proc/self/fd/n to determine if=
<br>
&gt; it actually refers to a file in /proc.<br>
&gt;<br>
&gt; Neither this nor the existing code works with symlinks or indirect pat=
hs<br>
&gt; (e.g.=C2=A0 /tmp/../proc/self/exe) that points to /proc/self/exe becau=
se it<br>
&gt; is itself a symlink, and both realpath(3) and /proc/self/fd/n will<br>
&gt; resolve into the location of QEMU.<br>
&gt;<br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/200=
4" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qem=
u/-/issues/2004</a><br>
&gt; Signed-off-by: Shu-Chun Weng &lt;<a href=3D"mailto:scw@google.com" tar=
get=3D"_blank">scw@google.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0linux-user/syscall.c | 47 ++++++++++++++++++++++++++++++++=
+++---------<br>
&gt;=C2=A0 =C2=A01 file changed, 38 insertions(+), 9 deletions(-)<br>
&gt;<br>
&gt; diff --git a/linux-user/syscall.c b/linux-user/syscall.c<br>
&gt; index e384e14248..7c3772301f 100644<br>
&gt; --- a/linux-user/syscall.c<br>
&gt; +++ b/linux-user/syscall.c<br>
&gt; @@ -8308,8 +8308,7 @@ static int open_net_route(CPUArchState *cpu_env,=
 int fd)<br>
&gt;=C2=A0 =C2=A0int do_guest_openat(CPUArchState *cpu_env, int dirfd, cons=
t char *fname,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0int flags, mode_t mode, bool safe)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 g_autofree char *proc_name =3D NULL;<br>
&gt; -=C2=A0 =C2=A0 const char *pathname;<br>
&gt; +=C2=A0 =C2=A0 g_autofree char *pathname =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct fake_open {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *filename;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int (*fill)(CPUArchState *cpu_=
env, int fd);<br>
&gt; @@ -8334,12 +8333,42 @@ int do_guest_openat(CPUArchState *cpu_env, int=
 dirfd, const char *fname,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ NULL, NULL, NULL }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 /* if this is a file from /proc/ filesystem, expand ful=
l name */<br>
&gt; -=C2=A0 =C2=A0 proc_name =3D realpath(fname, NULL);<br>
&gt; -=C2=A0 =C2=A0 if (proc_name &amp;&amp; strncmp(proc_name, &quot;/proc=
/&quot;, 6) =3D=3D 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 pathname =3D proc_name;<br>
&gt; +=C2=A0 =C2=A0 if (strncmp(fname, &quot;/proc/&quot;, 6) =3D=3D 0) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pathname =3D g_strdup(fname);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 pathname =3D fname;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *proc_name =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct stat proc_stat;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int fd;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (safe) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fd =3D safe_openat(dirfd, p=
ath(fname), flags, mode);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fd =3D openat(dirfd, path(f=
name), flags, mode);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return fd;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Try to get the real path of the f=
ile we just opened. We avoid calling<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* `realpath(3)` because it calls `r=
eadlink(2)` on symlinks which<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* changes their atime. Note that si=
nce `/proc/self/exe` is a symlink,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* `pathname` will never resolve to =
it (neither will `realpath(3)`).<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* That&#39;s why we check `fname` a=
gainst the &quot;/proc/&quot; prefix first.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 proc_name =3D g_strdup_printf(&quot;/proc=
/self/fd/%d&quot;, fd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (lstat(proc_name, &amp;proc_stat) &lt;=
 0 || !S_ISLNK(proc_stat.st_mode)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* No procfs or something w=
eird. Not going to dig further. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return fd;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pathname =3D g_new(char, proc_stat.st_siz=
e + 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 readlink(proc_name, pathname, proc_stat.s=
t_size + 1);<br>
<br>
this gives a build error for me:<br>
./qemu/linux-user/syscall.c:8365:9: error: ignoring return value of =E2=80=
=98readlink=E2=80=99 declared with attribute =E2=80=98warn_unused_result=E2=
=80=99 [-Werror=3Dunused-result]<br>
<br>
Other than that, this patch indeed fixes the issue #2004<br>
<br>
Reviewed-by: Helge Deller &lt;<a href=3D"mailto:deller@gmx.de" target=3D"_b=
lank">deller@gmx.de</a>&gt;<br>
<br>
<br>
Helge<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* if this is not a file from /proc/ file=
system, the fd is good as-is */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strncmp(pathname, &quot;/proc/&quot;,=
 6) !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return fd;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(fd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_proc_myself(pathname, &quot;exe&quot;=
)) {<br>
&gt; @@ -8390,9 +8419,9 @@ int do_guest_openat(CPUArchState *cpu_env, int d=
irfd, const char *fname,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (safe) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return safe_openat(dirfd, path(pathname),=
 flags, mode);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return safe_openat(dirfd, pathname, flags=
, mode);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return openat(dirfd, path(pathname), flag=
s, mode);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return openat(dirfd, pathname, flags, mod=
e);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;<br>
&gt;<br>
<br>
</blockquote></div>

--0000000000004492b1060d9941fc--

--0000000000004b692e060d99412d
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
XfuRv7aGLuwPktH3is21kBRSD/+NFwQBNYt3w0Ae3rEwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjMxMjI4MjIxNTM2WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjAL
BgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAGxKnIds42sZPmZacyOR
KxXThUJltRCa0+F+mgWTOGjPhD8M8E93gnbW2AJ0KRXq1XICYRm+n31VrWQz4UoKKO9L2gmvOlo2
FdXvC6ayumg6amOfcDf3528JszcldI8Tf+B0mHSUQn4WSswQ1I6OwC6fdmmb9EZRSyQvhmvDjsHr
m+K9hnHbcgyeLgsgLRoyDRBb54GHqX293BQkhXF1nQP3kz/DFQCfUBOYgiWU+ipX8sl174vnsIbt
vfdr26c560IoseY1IRP8cCRRl7C22xgqq+5XaxxIN4iF35+rDoxmJnIw/yX2T1MjgkJqQuo+uD12
HHJjUs5zsjCrqfh05tc=
--0000000000004b692e060d99412d--

