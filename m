Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71162781C59
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 06:17:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXZrb-00066Y-8d; Sun, 20 Aug 2023 00:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXZrZ-00066L-7y
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:16:29 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXZrW-0006Om-OU
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:16:28 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-51cff235226so4597926a12.0
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 21:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692504985; x=1693109785;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZYyaegt9TN3krI5nYGEP8DnZDz2/ZbgywWXOxWfXQug=;
 b=Fgo9q/qrRm6uvA4hUHCWFDNgULLb0FnkcNquSWaRdL9/ZFkayI87rD5/CbcKp4Tbg5
 4//gya1ueZKOWU/mpjtCPASUzkh2oATZ+MtJs+jgHgliLu0epng8Ybqe4fdf0aM+fe7Z
 7/lon+LwrG7VFm5eSVb3fOQ/v2YC6ZwE8EwWUpLAM7+ft/ab8N2DNRlRZYV+PuBqgNUC
 /1gmTkfq+ZLIkDyzBvhLF9hT4Rn+tsM3ovByxQfs/ooUf7zz0VsdDLB2p8lasjZkiG7w
 KwCUJNTTIYjvYCqKiFI8r5bgR8DsQgRJZdY7f4P3srL7opNjAZMIb7Cjo21qh5Mh4PWF
 Rocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692504985; x=1693109785;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZYyaegt9TN3krI5nYGEP8DnZDz2/ZbgywWXOxWfXQug=;
 b=X/C6ANvE758Zj2Lvm7u3WBMjkn2Ypfv/ZvDwnQ7IF5030SLUFRywLVvBrfNg0Y95en
 Ux8hTnozwojt+tvOhCKG+6n7wMwNOPBURIGm5Uz6B7bJbet19y/ngxoyPEoEoN5shIJ4
 EcVh3lM6HKbv1/KIbDvX2woAa8i06RwWn9NHCDeIXe3MqW2RJpD6bScd2widNmRTceHk
 aj0Y/GZWv2i3jQl31bJCADaQAg1jc8tnEzqBz7elW6zqOHC9kiHitoo7pFLP38Pfk6RK
 4OoJgDKbZSTiiHhhAOzLqeoFXQRpi88JDYocDYS0xLlvGlhxtTZYRgPuIhqSbEWsWRJ2
 oUYA==
X-Gm-Message-State: AOJu0YxKR5EAusjORnQWI5DqOTsbTutx+mFgMvSd0bQTQ3YLcJDr9bwm
 G/ZdFNy6QEMbrMSRGPggq6FZPvCwVto2FVklLLTrUg==
X-Google-Smtp-Source: AGHT+IHeeuUAdEZoZ1rtC1h5GtbOykv28gqT1cUIes7L6ih+OVyoGjOAJ3fCWvXwXTREuj1iom1PMaBz6VBzfLYWIB4=
X-Received: by 2002:aa7:db47:0:b0:523:b37e:b83b with SMTP id
 n7-20020aa7db47000000b00523b37eb83bmr3317294edt.13.1692504985122; Sat, 19 Aug
 2023 21:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-6-kariem.taha2.7@gmail.com>
 <e631bda3-d722-66d2-2774-1af9823ab0eb@linaro.org>
In-Reply-To: <e631bda3-d722-66d2-2774-1af9823ab0eb@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Aug 2023 22:16:17 -0600
Message-ID: <CANCZdfooOYC2jnbG+MX8ib=bn_OSXkrmTJnjC+ODBxYF9JAUHg@mail.gmail.com>
Subject: Re: [PATCH 05/22] Implement shm_open2(2) system call
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org, 
 Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="0000000000006b4d000603530647"
Received-SPF: none client-ip=2a00:1450:4864:20::531;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x531.google.com
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

--0000000000006b4d000603530647
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 19, 2023 at 9:10=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/19/23 02:47, Karim Taha wrote:
> > From: Kyle Evans <kevans@FreeBSD.org>
> >
> > Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> > Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> > ---
> >   bsd-user/freebsd/os-misc.h    | 52 ++++++++++++++++++++++++++++++++++=
+
> >   bsd-user/freebsd/os-syscall.c | 13 +++++++++
> >   2 files changed, 65 insertions(+)
> >
> > diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
> > index 8436ccb2f7..993e4598f9 100644
> > --- a/bsd-user/freebsd/os-misc.h
> > +++ b/bsd-user/freebsd/os-misc.h
> > @@ -24,5 +24,57 @@
> >   #include <sys/random.h>
> >   #include <sched.h>
> >
> > +int shm_open2(const char *path, int flags, mode_t mode, int shmflags,
> > +    const char *);
> > +
> > +#if defined(__FreeBSD_version) && __FreeBSD_version >=3D 1300048
> > +/* shm_open2(2) */
> > +static inline abi_long do_freebsd_shm_open2(abi_ulong pathptr,
> abi_ulong flags,
> > +    abi_long mode, abi_ulong shmflags, abi_ulong nameptr)
> > +{
> > +    int ret;
> > +    void *uname, *upath;
> > +
> > +#ifdef SHM_ANON
>
> Why would SHM_ANON not be defined?  You've already restricted the functio=
n
> to freebsd13+
> (presumably so that shm_open2() is in libc.a).
>

Good catch Richard. It's like this in the bsd-user fork, but after talking
it over with Kyle, we're
sure that's due to a cut and past from shm_open when this was implemented.
We should change
it before we submit it upstream absolutely. It's always defined on FreeBSD
and that will make
this code simpler.

Warner


> > +#define SHM_PATH(p) (p) =3D=3D SHM_ANON ? (p) : path(p)
> > +    if (pathptr =3D=3D (uintptr_t)SHM_ANON) {
> > +        upath =3D SHM_ANON;
> > +    } else
> > +#else
> > +#define SHM_PATH(p) path(p)
> > +#endif
> > +    {
> > +        upath =3D lock_user_string(pathptr);
> > +        if (upath =3D=3D NULL) {
> > +            return -TARGET_EFAULT;
> > +        }
> > +    }
> > +
> > +    uname =3D NULL;
> > +    if (nameptr !=3D 0) {
> > +        uname =3D lock_user_string(nameptr);
> > +        if (uname =3D=3D NULL) {
> > +            unlock_user(upath, pathptr, 0);
> > +            return -TARGET_EFAULT;
> > +        }
> > +    }
> > +    ret =3D get_errno(shm_open2(SHM_PATH(upath),
>
> There is no need for SHM_PATH because you've already handled the conditio=
n
> while setting
> upath above.
>
>
>
> r~
>

--0000000000006b4d000603530647
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Aug 19, 2023 at 9:10=E2=80=AF=
AM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ri=
chard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On 8/19/23 02:47, Karim Taha wrote:<br>
&gt; From: Kyle Evans &lt;kevans@FreeBSD.org&gt;<br>
&gt; <br>
&gt; Signed-off-by: Kyle Evans &lt;kevans@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.c=
om" target=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/freebsd/os-misc.h=C2=A0 =C2=A0 | 52 +++++++++++++=
++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0bsd-user/freebsd/os-syscall.c | 13 +++++++++<br>
&gt;=C2=A0 =C2=A02 files changed, 65 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h<b=
r>
&gt; index 8436ccb2f7..993e4598f9 100644<br>
&gt; --- a/bsd-user/freebsd/os-misc.h<br>
&gt; +++ b/bsd-user/freebsd/os-misc.h<br>
&gt; @@ -24,5 +24,57 @@<br>
&gt;=C2=A0 =C2=A0#include &lt;sys/random.h&gt;<br>
&gt;=C2=A0 =C2=A0#include &lt;sched.h&gt;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +int shm_open2(const char *path, int flags, mode_t mode, int shmflags,=
<br>
&gt; +=C2=A0 =C2=A0 const char *);<br>
&gt; +<br>
&gt; +#if defined(__FreeBSD_version) &amp;&amp; __FreeBSD_version &gt;=3D 1=
300048<br>
&gt; +/* shm_open2(2) */<br>
&gt; +static inline abi_long do_freebsd_shm_open2(abi_ulong pathptr, abi_ul=
ong flags,<br>
&gt; +=C2=A0 =C2=A0 abi_long mode, abi_ulong shmflags, abi_ulong nameptr)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int ret;<br>
&gt; +=C2=A0 =C2=A0 void *uname, *upath;<br>
&gt; +<br>
&gt; +#ifdef SHM_ANON<br>
<br>
Why would SHM_ANON not be defined?=C2=A0 You&#39;ve already restricted the =
function to freebsd13+ <br>
(presumably so that shm_open2() is in libc.a).<br></blockquote><div><br></d=
iv><div>Good catch Richard. It&#39;s like this in the bsd-user fork, but af=
ter talking it over with Kyle, we&#39;re <br></div><div>sure that&#39;s due=
 to a cut and past from shm_open when this was implemented. We should chang=
e</div><div>it before we submit it upstream absolutely. It&#39;s always def=
ined on FreeBSD and that will make</div><div>this code simpler.</div><div><=
br></div><div>Warner<br></div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
&gt; +#define SHM_PATH(p) (p) =3D=3D SHM_ANON ? (p) : path(p)<br>
&gt; +=C2=A0 =C2=A0 if (pathptr =3D=3D (uintptr_t)SHM_ANON) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 upath =3D SHM_ANON;<br>
&gt; +=C2=A0 =C2=A0 } else<br>
&gt; +#else<br>
&gt; +#define SHM_PATH(p) path(p)<br>
&gt; +#endif<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 upath =3D lock_user_string(pathptr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (upath =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uname =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 if (nameptr !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uname =3D lock_user_string(nameptr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (uname =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unlock_user(upath, pathptr,=
 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 ret =3D get_errno(shm_open2(SHM_PATH(upath),<br>
<br>
There is no need for SHM_PATH because you&#39;ve already handled the condit=
ion while setting <br>
upath above.<br>
<br>
<br>
<br>
r~<br>
</blockquote></div></div>

--0000000000006b4d000603530647--

