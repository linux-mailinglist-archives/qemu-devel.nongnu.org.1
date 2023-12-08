Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6975680AE4C
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 21:52:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBhpr-0002x0-Kb; Fri, 08 Dec 2023 15:52:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1rBhpp-0002wY-QN
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 15:52:33 -0500
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1rBhpn-0006pR-Fo
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 15:52:33 -0500
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-42598c2b0b7so8111cf.1
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 12:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1702068749; x=1702673549; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a0/EDuyqvTQIVQM243eff4xGJ6Q5HWyGb7l9SbG4RKI=;
 b=zcZDddjIU+ZDYmBcuV2bLpxt2yKDWMAnaCrfLsHLw+qA73iDGGpSGKzJtRE1GmQhb5
 gTbj82EknrVy6KeuZxquIk3EyXDU07oViGhMCyFqWx/UlIBLPBRzNsEIudIOCO7MNL/z
 i8/AdvKzwFLS/tYsWvp2INPF31yu48M2VnJ7majPg5n+pFEyY5bJ2y4FvcplACJWDUSK
 StIYKh8UpChAEmMn67C9P4zuwynZQGzMRGrll6XT2LrGzWp3AiaZuJfjiYpdR/UDDt0V
 J8/HPkAl8Gnn9+8yMfeHKwiGAtEyOkErnjAd+w3wDpGsq7U2gS+zjfiR2sh7UbcGroqW
 h15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702068749; x=1702673549;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a0/EDuyqvTQIVQM243eff4xGJ6Q5HWyGb7l9SbG4RKI=;
 b=uZNFXn2Wvo6wJwl6xvhYLFgM48IjNrgjHMQtVRwdIyc8xmHgHASTmbRC2hIls/qXcl
 xfnwaFPCNA+DnFPEYsqg5SkoNd+F8kcyTRU8hQV7eX82b9g1i/UrhkX+KbK4mx+8bSeH
 JG6febqu791d2vJAdvuQIu1MmVt23zlSQY/zlF4Q/vwhLn4uVMDz9llDFs6tkW3aiN65
 6KezHSvPld/ZRr0i94Kqu+7kI6Rrkj9G89W0hNOs96JWE2ZTxeBzimPxzPb0UAmTzfbL
 EQ3g6S/Y5My7jp5j3mX7sskTGSEfORfn9+1Ou9U2/hWhLSYYctUlR3uskwZjx0nz43rD
 VsNw==
X-Gm-Message-State: AOJu0YxZEjouI1UfhTnaB3vyQ4CULOCuA1eXLp72JtZ3vSTFev5ihin5
 QSTH+OB8yJCOvXLQJ+ayNXDfzE0O3zsn51f8llnjCA==
X-Google-Smtp-Source: AGHT+IHspBJJ7rnevVD1CDJYGKbddvn8A/cbzNHQWCH5/6qtfipt9acP3djTv/SenuE2JuWfQObREu1MII4d6B4zYfE=
X-Received: by 2002:a05:622a:190c:b0:421:2389:5a2 with SMTP id
 w12-20020a05622a190c00b00421238905a2mr253479qtc.18.1702068749156; Fri, 08 Dec
 2023 12:52:29 -0800 (PST)
MIME-Version: 1.0
References: <20231201032140.2470599-1-scw@google.com>
 <20231201032140.2470599-3-scw@google.com>
 <ZW4FOs3LwSyVD7Xf@redhat.com>
In-Reply-To: <ZW4FOs3LwSyVD7Xf@redhat.com>
From: Shu-Chun Weng <scw@google.com>
Date: Fri, 8 Dec 2023 12:52:13 -0800
Message-ID: <CAF3nBxgBZUt6NkKUwy0W2ice6jXbJF-trJzA+0o-wrosNoHJDw@mail.gmail.com>
Subject: Re: [PATCH 2/2] linux-user: Fix openat() emulation to not modify atime
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="00000000000035a8a3060c05c38d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=scw@google.com; helo=mail-qt1-x835.google.com
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

--00000000000035a8a3060c05c38d
Content-Type: multipart/alternative; boundary="0000000000002d8d49060c05c381"

--0000000000002d8d49060c05c381
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 8:58=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com>
wrote:

> On Thu, Nov 30, 2023 at 07:21:40PM -0800, Shu-Chun Weng wrote:
> > Commit b8002058 strengthened openat()'s /proc detection by calling
> > realpath(3) on the given path, which allows various paths and symlinks
> > that points to the /proc file system to be intercepted correctly.
> >
> > Using realpath(3), though, has a side effect that it reads the symlinks
> > along the way, and thus changes their atime. The results in the
> > following code snippet already get ~now instead of the real atime:
> >
> >   int fd =3D open("/path/to/a/symlink", O_PATH | O_NOFOLLOW);
> >   struct stat st;
> >   fstat(fd, st);
> >   return st.st_atime;
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
>
> I wonder if we can detect that by opening with O_NOFOLLOW, then
> calling fstatfs() on the FD, and checking f_type =3D=3D PROCFS_SUPER_MAGI=
C
>

This works with indirect or relative paths, yes, but still not symlinks. I
decided not to complicate the logic further.


>
>
> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > index e384e14248..25e2cda10a 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -8308,8 +8308,6 @@ static int open_net_route(CPUArchState *cpu_env,
> int fd)
> >  int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fnam=
e,
> >                      int flags, mode_t mode, bool safe)
> >  {
> > -    g_autofree char *proc_name =3D NULL;
> > -    const char *pathname;
> >      struct fake_open {
> >          const char *filename;
> >          int (*fill)(CPUArchState *cpu_env, int fd);
> > @@ -8333,13 +8331,39 @@ int do_guest_openat(CPUArchState *cpu_env, int
> dirfd, const char *fname,
> >  #endif
> >          { NULL, NULL, NULL }
> >      };
> > +    char pathname[PATH_MAX];
> >
> > -    /* if this is a file from /proc/ filesystem, expand full name */
> > -    proc_name =3D realpath(fname, NULL);
> > -    if (proc_name && strncmp(proc_name, "/proc/", 6) =3D=3D 0) {
> > -        pathname =3D proc_name;
> > +    if (strncmp(fname, "/proc/", 6) =3D=3D 0) {
> > +        pstrcpy(pathname, sizeof(pathname), fname);
> >      } else {
> > -        pathname =3D fname;
> > +        char procpath[PATH_MAX];
> > +        int fd, n;
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
> > +         * `pathname` will never resolves to it (neither will
> `realpath(3)`).
> > +         * That's why we check `fname` against the "/proc/" prefix
> first.
> > +         */
> > +        snprintf(procpath, sizeof(procpath), "/proc/self/fd/%d", fd);
>
> g_strdup_printf() + g_autofree to avoid this PATH_MAX buffer
>
> > +        n =3D readlink(procpath, pathname, sizeof(pathname));
> > +        pathname[n < sizeof(pathname) ? n : sizeof(pathname)] =3D '\0'=
;
>
> If you call lstat() then sb_size will tell you how big the buffer
> needs to be for a subsequent readlink(), whcih can be allocated
> on the heap and released with g_autofree, avoiding the othuer PATH_MAX
> buffer
>

Thanks for the suggestions, sent out v2 of the patch series eliminating
both static buffers.

Shu-Chun


> > +
> > +        /* if this is not a file from /proc/ filesystem, the fd is goo=
d
> as-is */
> > +        if (strncmp(pathname, "/proc/", 6) !=3D 0) {
> > +            return fd;
> > +        }
> > +        close(fd);
> >      }
> >
> >      if (is_proc_myself(pathname, "exe")) {
> > @@ -8390,9 +8414,9 @@ int do_guest_openat(CPUArchState *cpu_env, int
> dirfd, const char *fname,
> >      }
> >
> >      if (safe) {
> > -        return safe_openat(dirfd, path(pathname), flags, mode);
> > +        return safe_openat(dirfd, pathname, flags, mode);
> >      } else {
> > -        return openat(dirfd, path(pathname), flags, mode);
> > +        return openat(dirfd, pathname, flags, mode);
> >      }
> >  }
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--0000000000002d8d49060c05c381
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 4, 2023 at 8:58=E2=80=AFA=
M Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berran=
ge@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">On Thu, Nov 30, 2023 at 07:21:40PM -0800, Shu-Chun Weng wrote:=
<br>
&gt; Commit b8002058 strengthened openat()&#39;s /proc detection by calling=
<br>
&gt; realpath(3) on the given path, which allows various paths and symlinks=
<br>
&gt; that points to the /proc file system to be intercepted correctly.<br>
&gt; <br>
&gt; Using realpath(3), though, has a side effect that it reads the symlink=
s<br>
&gt; along the way, and thus changes their atime. The results in the<br>
&gt; following code snippet already get ~now instead of the real atime:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0int fd =3D open(&quot;/path/to/a/symlink&quot;, O_PATH | O=
_NOFOLLOW);<br>
&gt;=C2=A0 =C2=A0struct stat st;<br>
&gt;=C2=A0 =C2=A0fstat(fd, st);<br>
&gt;=C2=A0 =C2=A0return st.st_atime;<br>
&gt; <br>
&gt; This change opens a path that doesn&#39;t appear to be part of /proc<b=
r>
&gt; directly and checks the destination of /proc/self/fd/n to determine if=
<br>
&gt; it actually refers to a file in /proc.<br>
&gt; <br>
&gt; Neither this nor the existing code works with symlinks or indirect pat=
hs<br>
&gt; (e.g.=C2=A0 /tmp/../proc/self/exe) that points to /proc/self/exe becau=
se it<br>
&gt; is itself a symlink, and both realpath(3) and /proc/self/fd/n will<br>
&gt; resolve into the location of QEMU.<br>
<br>
I wonder if we can detect that by opening with O_NOFOLLOW, then<br>
calling fstatfs() on the FD, and checking f_type =3D=3D PROCFS_SUPER_MAGIC<=
br></blockquote><div><br></div><div>This works with indirect or relative pa=
ths, yes, but still not symlinks. I decided not to complicate the logic fur=
ther.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
<br>
<br>
&gt; diff --git a/linux-user/syscall.c b/linux-user/syscall.c<br>
&gt; index e384e14248..25e2cda10a 100644<br>
&gt; --- a/linux-user/syscall.c<br>
&gt; +++ b/linux-user/syscall.c<br>
&gt; @@ -8308,8 +8308,6 @@ static int open_net_route(CPUArchState *cpu_env,=
 int fd)<br>
&gt;=C2=A0 int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char=
 *fname,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 int flags, mode_t mode, bool safe)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 g_autofree char *proc_name =3D NULL;<br>
&gt; -=C2=A0 =C2=A0 const char *pathname;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 struct fake_open {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *filename;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int (*fill)(CPUArchState *cpu_env, i=
nt fd);<br>
&gt; @@ -8333,13 +8331,39 @@ int do_guest_openat(CPUArchState *cpu_env, int=
 dirfd, const char *fname,<br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { NULL, NULL, NULL }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 char pathname[PATH_MAX];<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 /* if this is a file from /proc/ filesystem, expand ful=
l name */<br>
&gt; -=C2=A0 =C2=A0 proc_name =3D realpath(fname, NULL);<br>
&gt; -=C2=A0 =C2=A0 if (proc_name &amp;&amp; strncmp(proc_name, &quot;/proc=
/&quot;, 6) =3D=3D 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 pathname =3D proc_name;<br>
&gt; +=C2=A0 =C2=A0 if (strncmp(fname, &quot;/proc/&quot;, 6) =3D=3D 0) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pstrcpy(pathname, sizeof(pathname), fname=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 pathname =3D fname;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 char procpath[PATH_MAX];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int fd, n;<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* `pathname` will never resolves to=
 it (neither will `realpath(3)`).<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* That&#39;s why we check `fname` a=
gainst the &quot;/proc/&quot; prefix first.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(procpath, sizeof(procpath), &quo=
t;/proc/self/fd/%d&quot;, fd);<br>
<br>
g_strdup_printf() + g_autofree to avoid this PATH_MAX buffer<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n =3D readlink(procpath, pathname, sizeof=
(pathname));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pathname[n &lt; sizeof(pathname) ? n : si=
zeof(pathname)] =3D &#39;\0&#39;;<br>
<br>
If you call lstat() then sb_size will tell you how big the buffer<br>
needs to be for a subsequent readlink(), whcih can be allocated<br>
on the heap and released with g_autofree, avoiding the othuer PATH_MAX<br>
buffer<br></blockquote><div><br></div><div>Thanks for the suggestions, sent=
 out v2 of the patch series eliminating both static buffers.<br></div><div>=
<br></div><div>Shu-Chun=C2=A0</div><div><br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* if this is not a file from /proc/ file=
system, the fd is good as-is */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strncmp(pathname, &quot;/proc/&quot;,=
 6) !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return fd;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(fd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (is_proc_myself(pathname, &quot;exe&quot;)) {<b=
r>
&gt; @@ -8390,9 +8414,9 @@ int do_guest_openat(CPUArchState *cpu_env, int d=
irfd, const char *fname,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (safe) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return safe_openat(dirfd, path(pathname),=
 flags, mode);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return safe_openat(dirfd, pathname, flags=
, mode);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return openat(dirfd, path(pathname), flag=
s, mode);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return openat(dirfd, pathname, flags, mod=
e);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; <br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div></div>

--0000000000002d8d49060c05c381--

--00000000000035a8a3060c05c38d
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
5x52CtWXY+Vqm9Uqy/xCU2NBq6OFmfngMIMZuZLndhkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjMxMjA4MjA1MjI5WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjAL
BgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAJJ8u4MikMduvyvdL2/d
pDYGzIBWGUDjwJt34WxZtTRUfNHpkc2mKVBvEHiKADMA3DOayxiYEwsDMrcXzpzk6e78gtpC4jCm
vNHIL2NI7ZGGyntL71dga33QKu2QRdH06DjtqyKI2pbSR3Y0WEWBMXJBCECaKDH+ma8z5uVRNcJ9
TzSitg43hPdgnwIc/vpVcOgKznEKTXgwyMyGtfi2TuF/IQB7D9PxOCFgRaJK90M7D34wgnrvxiqP
9gBX0KrrNiXvtUtNo88vNoeFhLcLEL2QBlC5izF+bOtoyUSK1H7PWiLTHAGr1UZBots9Tl2FQ6nK
nR88xPKJvS+pcr6N6mM=
--00000000000035a8a3060c05c38d--

