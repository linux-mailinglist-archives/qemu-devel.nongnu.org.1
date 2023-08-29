Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6174A78D065
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:23:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7n6-0000sl-Ns; Tue, 29 Aug 2023 19:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qb6F9-0004EG-He
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:27:23 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qb6F5-0006LE-En
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:27:22 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9936b3d0286so661974166b.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 14:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693344436; x=1693949236;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3BYn4CV545aznpVXRHgtllKVDKW5VNlXd15uK+HWD08=;
 b=mnVtDsxHapHIBYzl2GZnJIAa4T08DUThqLONp0M5B8Is6kmGneiHaxWRh9wAyzNO8t
 GQQIoF/TyHEZGZfEzthC7G1/XivAVTmD5xHd8pD9oT/frvQ5UPF4FS5sKdIpsGqtbsK0
 6lGsrivyIBHML8mlA+7sOvsRupEvwGQilcKb3NdRZdyNEyzRQtwNRL3gPArLkGQek30I
 h2LXMGPZxtTSzHVLNVShqu3LGvninqYFBeeV4M+QheR/zChWX2kFemfuwCQdGpd6vEbE
 /8zPSflt9FbKZXSsPr1nkowC5+NQMc33lTM5j5KZRtiGAw/eYL9ZxzxJfUJo76iBJesl
 ODvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693344436; x=1693949236;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3BYn4CV545aznpVXRHgtllKVDKW5VNlXd15uK+HWD08=;
 b=k266uVs/goOYtZQHitAU5fvUhfKPCfBG5q7u7G2YchxJHOka4IQLteNvpN0yR7njqh
 EaGQDQudgkXAi4xlx3V1cBvqQOO/0oD5qTq3pZW0+wQKaq4lNmtFfStOZPFvOyixs5+x
 2+3acuNGUl17HftJ1/FeTpCLuO2cpW30b1EBDmvnWgPiozZAzMMLe8Ly8die270E/4LJ
 QrjTlpkd62/x9BeA75Rmbv1tSXRXt3FAJKWvwcH8QiGW+tXgLOihhGxIVvsU/PbdKss6
 6QSIXZBpoWJxOH0dTB1oGloy/ok4/zlan8Be5+ddxfXZ/cPMDGn8xYfu0/Dt3/hYOM2+
 Vy6Q==
X-Gm-Message-State: AOJu0YwFlMPx6OCk1pcMLBYIlptT30pgeeZg+Kjb3zh1Cr7qBBzPdlru
 a+vmoPCJKdjgfdOMMh7cFOsL9Y57MxBxVV2+meDVDA==
X-Google-Smtp-Source: AGHT+IFMZ7QFHxZkMkYWIOsb6r6iK3LO+Ff0yklVP6RoYTGeXiCbHPI7O1RRYSrQUKtBZyg7urLh0eVcCeJ/OZWlU0I=
X-Received: by 2002:a17:906:289:b0:9a1:d087:e0bf with SMTP id
 9-20020a170906028900b009a1d087e0bfmr152320ejf.43.1693344435619; Tue, 29 Aug
 2023 14:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-33-kariem.taha2.7@gmail.com>
 <02510730-72e8-9b0e-483c-048c7301328f@linaro.org>
In-Reply-To: <02510730-72e8-9b0e-483c-048c7301328f@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 29 Aug 2023 15:27:04 -0600
Message-ID: <CANCZdfoKOotS+S01bFbSXYFrqwOaFYf6xb_aAOR5eq13jYeKmg@mail.gmail.com>
Subject: Re: [PATCH 32/32] bsd-user: Implement pdfork(2) system call.
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000915e48060416796e"
Received-SPF: none client-ip=2a00:1450:4864:20::62b;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x62b.google.com
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

--000000000000915e48060416796e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2023 at 2:58=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/27/23 08:57, Karim Taha wrote:
> > From: Stacey Son <sson@FreeBSD.org>
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> > ---
> >   bsd-user/freebsd/os-proc.h    | 32 ++++++++++++++++++++++++++++++++
> >   bsd-user/freebsd/os-syscall.c |  4 ++++
> >   2 files changed, 36 insertions(+)
> >
> > diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
> > index 94824d737a..1eaba908a5 100644
> > --- a/bsd-user/freebsd/os-proc.h
> > +++ b/bsd-user/freebsd/os-proc.h
> > @@ -248,4 +248,36 @@ static inline abi_long do_freebsd_rfork(void
> *cpu_env, abi_long flags)
> >
> >   }
> >
> > +/* pdfork(2) */
> > +static inline abi_long do_freebsd_pdfork(void *cpu_env, abi_ulong
> target_fdp,
> > +        abi_long flags)
> > +{
> > +    abi_long ret;
> > +    abi_ulong child_flag;
> > +    int fd;
> > +
> > +    fork_start();
> > +    ret =3D pdfork(&fd, flags);
> > +    if (ret =3D=3D 0) {
> > +        /* child */
> > +        child_flag =3D 1;
> > +        target_cpu_clone_regs(cpu_env, 0);
> > +    } else {
> > +        /* parent */
> > +        child_flag =3D 0;
> > +    }
> > +    if (put_user_s32(fd, target_fdp)) {
> > +        return -TARGET_EFAULT;
> > +    }
>
> I *think* this copy belongs in the parent?


I think that it's copied out in both cases. For normal fork, this would
be 0 for the pid. However, it appears to return the same FD to both
the parent and child (see your next comment), so it should be in both
paths. And even if it returned something different for parent and child
(which seems unlikely given how the code is setup), we want to return
the fd each one sees. So either way, I think this code is correct.


> It's really hard to follow the path of new
> process creation within the freebsd kernel.
>

Agreed.


> Anyway, the rest looks fine so I'll give an
>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--000000000000915e48060416796e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 29, 2023 at 2:58=E2=80=AF=
PM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ri=
chard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On 8/27/23 08:57, Karim Taha wrote:<br>
&gt; From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.c=
om" target=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/freebsd/os-proc.h=C2=A0 =C2=A0 | 32 +++++++++++++=
+++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 4 ++++<br>
&gt;=C2=A0 =C2=A02 files changed, 36 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h<b=
r>
&gt; index 94824d737a..1eaba908a5 100644<br>
&gt; --- a/bsd-user/freebsd/os-proc.h<br>
&gt; +++ b/bsd-user/freebsd/os-proc.h<br>
&gt; @@ -248,4 +248,36 @@ static inline abi_long do_freebsd_rfork(void *cpu=
_env, abi_long flags)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/* pdfork(2) */<br>
&gt; +static inline abi_long do_freebsd_pdfork(void *cpu_env, abi_ulong tar=
get_fdp,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_long flags)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 abi_long ret;<br>
&gt; +=C2=A0 =C2=A0 abi_ulong child_flag;<br>
&gt; +=C2=A0 =C2=A0 int fd;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 fork_start();<br>
&gt; +=C2=A0 =C2=A0 ret =3D pdfork(&amp;fd, flags);<br>
&gt; +=C2=A0 =C2=A0 if (ret =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* child */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 child_flag =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_cpu_clone_regs(cpu_env, 0);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* parent */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 child_flag =3D 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (put_user_s32(fd, target_fdp)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
I *think* this copy belongs in the parent?</blockquote><div><br></div><div>=
I think that it&#39;s copied out in both cases. For normal fork, this would=
</div><div>be 0 for the pid. However, it appears to return the same FD to b=
oth</div><div>the parent and child (see your next comment), so it should be=
 in both</div><div>paths. And even if it returned something different for p=
arent and child</div><div>(which seems unlikely given how the code is setup=
), we want to return</div><div>the fd each one sees. So either way, I think=
 this code is correct.</div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">It&#39;s really hard to follow the path of new <br>
process creation within the freebsd kernel.<br></blockquote><div><br></div>=
<div>Agreed.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
Anyway, the rest looks fine so I&#39;ll give an<br>
<br>
Acked-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.=
org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br></blockquote=
><div><br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsd=
imp.com">imp@bsdimp.com</a>&gt;</div><div>=C2=A0</div></div></div>

--000000000000915e48060416796e--

