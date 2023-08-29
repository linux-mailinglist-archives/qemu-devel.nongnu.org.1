Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D60B078D06B
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:24:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nt-0001iE-T3; Tue, 29 Aug 2023 19:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qb6Md-0005LD-4a
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:35:07 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qb6MY-0007kx-2n
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:35:04 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-500a8b2b73eso7167488e87.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 14:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693344899; x=1693949699;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h1VcnrUggAeSGyukGBgL29MBIj7ziF69Boi0Emvlu68=;
 b=tRS1t40WLl1DXpmOji4uCOaonxKfLl37j5clF4pz6qMHR6nHmeUpYJbYRr/W2B8bMG
 ldc+i9HqVHvNqUijXvAMBAu1hFTJ543f5gjZ0THoXvnQEXOJAOJ3HQCAiTyILTKLXotF
 +oWm8cfXDsayqTxRmJoWFOGKty0PIBT3desorPee1Zcv+8Q5nwHe7lxNkYJr5cvqGFvD
 BOYnm2ScuZGLY8gyj46yYuwe/4SnAX1mLFe03V0TxJcZld4CPjBImFkNlsHk5IIDPoDt
 fdYijjHLO2AYnZfB34v9Mxwg3f3NITncJ/P+MFGYXrOpeMyI8h7i1TT5EsKcRvo/v7oG
 ZEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693344899; x=1693949699;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h1VcnrUggAeSGyukGBgL29MBIj7ziF69Boi0Emvlu68=;
 b=PckhRAv5S2dLy0sqKgwcvR6GbaBBi64sUei5mDkHJ/g3cwkxq4xxtpCXgXFDgRXiA2
 MwoExFWWPoIPvqkOxcHv2WizABCsYzXSClAJr8rHzcZcbbaKfkgL2n8utWbNoUytbfSo
 Rg2oWmDkbwJwd7Obb1f4CUeIxGq6gXYH7NgHjbR0884SrP/WqYB7u898m4bcgg6kGRFL
 aNmBH0Uior8iPTDwNLLJzjwLpUUTF6egjR+JCyCihdS7JTj4Sf0L1gIAb5tlI7haqgGr
 3RLKb5wp77nmgjBlUgcxvIF+cOAeHoV25sDheZ9jCTmNykM8pNnOZZwXsUBNRPDzAPl3
 cTkw==
X-Gm-Message-State: AOJu0YywpEmdnjdgVfr144mDFZ4x+ltTkfiQO+RB0YBKS0vhF2AZdK9g
 cL/5bpvylf1fjai7s6gYZ8P0Wtd/t6VrLQvircCTSA==
X-Google-Smtp-Source: AGHT+IH2Si4qzVwhQB0XOUCEvCiuvi+47fizvXbpJKUQ/Xh1mHjtKG3ih3K06JrbBALNBfsRZX096SctvtJMfNSxyqQ=
X-Received: by 2002:a05:6512:31c7:b0:500:98ff:4162 with SMTP id
 j7-20020a05651231c700b0050098ff4162mr116048lfe.40.1693344899408; Tue, 29 Aug
 2023 14:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-23-kariem.taha2.7@gmail.com>
 <c9567536-237e-f587-2d1e-db38d6b6eb30@linaro.org>
In-Reply-To: <c9567536-237e-f587-2d1e-db38d6b6eb30@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 29 Aug 2023 15:34:48 -0600
Message-ID: <CANCZdfoVb2QxFZDrN_-1YiEYwZ_6BSMvE_Zt4GSBgsmqGESUvw@mail.gmail.com>
Subject: Re: [PATCH 22/32] bsd-user: Implement freebsd_exec_common, used in
 implementing execve/fexecve.
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000363afd0604169574"
Received-SPF: none client-ip=2a00:1450:4864:20::131;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x131.google.com
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

--000000000000363afd0604169574
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2023 at 2:28=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/27/23 08:57, Karim Taha wrote:
> > From: Stacey Son<sson@FreeBSD.org>
> >
> > Signed-off-by: Stacey Son<sson@FreeBSD.org>
> > Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> > ---
> >   bsd-user/freebsd/os-proc.c | 177 ++++++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 177 insertions(+)
>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
>
> > +    if (do_fexec) {
> > +        if (((int)path_or_fd > 0 &&
> > +            is_target_elf_binary((int)path_or_fd)) =3D=3D 1) {
> > +            char execpath[PATH_MAX];
> > +
> > +            /*
> > +             * The executable is an elf binary for the target
> > +             * arch.  execve() it using the emulator if we can
> > +             * determine the filename path from the fd.
> > +             */
> > +            if (get_filename_from_fd(getpid(), (int)path_or_fd,
> execpath,
> > +                        sizeof(execpath)) !=3D NULL) {
> > +                memmove(qarg1 + 2, qarg1, (qargend-qarg1) *
> sizeof(*qarg1));
> > +             qarg1[1] =3D qarg1[0];
> > +             qarg1[0] =3D (char *)"-0";
> > +             qarg1 +=3D 2;
> > +             qargend +=3D 2;
> > +                *qarg1 =3D execpath;
> > +#ifndef DONT_INHERIT_INTERP_PREFIX
> > +                memmove(qarg1 + 2, qarg1, (qargend-qarg1) *
> sizeof(*qarg1));
> > +                *qarg1++ =3D (char *)"-L";
> > +                *qarg1++ =3D (char *)interp_prefix;
> > +#endif
>
> I'm not especailly keen on the ifdef, but I'll let that go.
>
> As for get_filename_from_fd, perhaps it would be cleaner to add a
> command-line parameter
> which would allow qemu to run from an open file descriptor?  Although
> perhaps that has
> CLOEXEC implications too...
>

This is one area that's in transition in the bsd-user stuff, but we've not
yet finished
that transition. Doug Rabson has created something that caches a reference
to
the interpreter, and if we exec the same kind of binary, it will reuse that
reference.
In a jail that Doug's code runs, this allows the interpreter to be running
a binary
from outside the jail, while restricting the emulated binary's reach to the
jail.
This eliminates, in some cases, the need to inherit this prefix. However,
in other
cases, it still seems to be needed (like when I'm not in a chroot
environment and
wanting to pull the shared libraries from a different location). How to
resolve
these two cases is an on-going area of discussions. And all the work may no=
t
yet be merged with the upstream tree.

Warner

--000000000000363afd0604169574
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 29, 2023 at 2:28=E2=80=AF=
PM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ri=
chard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On 8/27/23 08:57, Karim Taha wrote:<br>
&gt; From: Stacey Son&lt;sson@FreeBSD.org&gt;<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son&lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Karim Taha&lt;<a href=3D"mailto:kariem.taha2.7@gmail.co=
m" target=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/freebsd/os-proc.c | 177 +++++++++++++++++++++++++=
++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 177 insertions(+)<br>
<br>
Acked-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.=
org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
<br>
&gt; +=C2=A0 =C2=A0 if (do_fexec) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (((int)path_or_fd &gt; 0 &amp;&amp;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_target_elf_binary((int)p=
ath_or_fd)) =3D=3D 1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char execpath[PATH_MAX];<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The executable is a=
n elf binary for the target<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* arch.=C2=A0 execve(=
) it using the emulator if we can<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* determine the filen=
ame path from the fd.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_filename_from_fd(ge=
tpid(), (int)path_or_fd, execpath,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 sizeof(execpath)) !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memmove(qarg1=
 + 2, qarg1, (qargend-qarg1) * sizeof(*qarg1));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qarg1[1] =3D qarg1[0]=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qarg1[0] =3D (char *)=
&quot;-0&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qarg1 +=3D 2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qargend +=3D 2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *qarg1 =3D ex=
ecpath;<br>
&gt; +#ifndef DONT_INHERIT_INTERP_PREFIX<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memmove(qarg1=
 + 2, qarg1, (qargend-qarg1) * sizeof(*qarg1));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *qarg1++ =3D =
(char *)&quot;-L&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *qarg1++ =3D =
(char *)interp_prefix;<br>
&gt; +#endif<br>
<br>
I&#39;m not especailly keen on the ifdef, but I&#39;ll let that go.<br>
<br>
As for get_filename_from_fd, perhaps it would be cleaner to add a command-l=
ine parameter <br>
which would allow qemu to run from an open file descriptor?=C2=A0 Although =
perhaps that has <br>
CLOEXEC implications too...<br></blockquote><div><br></div><div>This is one=
 area that&#39;s in transition in the bsd-user stuff, but we&#39;ve not yet=
 finished</div><div>that transition. Doug Rabson has created something that=
 caches a reference to</div><div>the interpreter, and if we exec the same k=
ind of binary, it will reuse that reference.</div><div>In a jail that=C2=A0=
Doug&#39;s code runs, this allows the interpreter to be running a binary</d=
iv><div>from outside the jail, while restricting the emulated binary&#39;s =
reach to the jail.</div><div>This eliminates, in some cases, the need to in=
herit this prefix. However, in other</div><div>cases, it still seems to be =
needed (like when I&#39;m not in a chroot environment and</div><div>wanting=
 to pull the shared libraries from a different=C2=A0location). How to resol=
ve</div><div>these two cases is an on-going area of discussions. And all th=
e work may not</div><div>yet be merged with the upstream tree.</div><div><b=
r></div><div>Warner<br></div></div></div>

--000000000000363afd0604169574--

