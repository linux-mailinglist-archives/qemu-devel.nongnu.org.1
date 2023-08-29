Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D830778D09A
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:29:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nv-0001rX-Jm; Tue, 29 Aug 2023 19:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qb5sm-0005gr-EP
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:04:17 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qb5sh-00023L-OO
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:04:14 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4ff09632194so7826426e87.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 14:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693343048; x=1693947848;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KsbazWlIkeZXZDuNINCHB4kgfu78ixEFuWVS8jGCLsw=;
 b=j097qC0741QWb/Nl+oh8GmPF7+OtK5KZjlieemG5SoTG4dsLdnAW/wmfHbanMDojH3
 JWD62zssl1XK3JxSRmNY8RqmtZRcEPfKgZmkRKM8OwlbFc67qIZtw2OBVRVlivh1ekLV
 nQ9u0pbMDozvqRwtCqqLYv7XfX8dbxtJr17xv0hdqRVDWK6D+lI8fzudp1MS7YrZ/Dp2
 lbolxQ9AA1ZVdz5rJKS7FViICnRoSEc9axEozbOwHcv7XB6MCqRKbtHn3kgOAfv1+rKA
 B7ctkVrsHSW3L+Y1FAxqhlTl0sxPUckk9BYubexo88w2gkth06pg/5XZsxnV/w4S8x/k
 fHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693343048; x=1693947848;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KsbazWlIkeZXZDuNINCHB4kgfu78ixEFuWVS8jGCLsw=;
 b=bfMIvm3ZcohnMTFrp7os3fBa89UVj+/GQmxikBq2ZkORfOE4tp8t0E08lA5klDGftM
 FtNf1jq6sM8IKfssJBb96KnhQ5HXmnFPqvhd6wi8Ua8QKF0QQp9X0nVn+Pta6bl1h62o
 SZ41AvoaZdjckUGajhEw9wYdVvu4RpXf+F2SLr8Xxp5m3HuirW/oKnymWc+qEldSXLI5
 8hI62FlygD6i8bDffZTCCPs9zGjL5c7pFwpj0aaU3vkI8VHw5rGSHYI0YWyDXKb7xlF6
 qNFkI+gTwlc6coL8fMGKjMhxhBWs2ixlCh3aYa7aWw8z7llBktdRDEqlTnczNngEjfEj
 3HIA==
X-Gm-Message-State: AOJu0YxdrZ7cHXWPX9unpsFlJlFy5hYNVDWlnk5CS5YRBmN4mT8qUl65
 hhUwJiLTWjvD1V0zP4+udf+gHzTEKlZ7YnpkjwSNhegpu2RA5atPJ0g=
X-Google-Smtp-Source: AGHT+IHqOG9pkig5tvVgB9xrUKZ8lQ5TunmxcD8lJ5H4Zzna8zgb8kHh663GF2jIrdgjjaJfUCN9D1C2AtpepvpDhig=
X-Received: by 2002:a05:6512:3da6:b0:500:b2c9:7da9 with SMTP id
 k38-20020a0565123da600b00500b2c97da9mr67310lfv.45.1693343048423; Tue, 29 Aug
 2023 14:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-12-kariem.taha2.7@gmail.com>
 <5578994f-591c-c687-6352-026fea8d9307@linaro.org>
In-Reply-To: <5578994f-591c-c687-6352-026fea8d9307@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 29 Aug 2023 15:03:56 -0600
Message-ID: <CANCZdfp64pscO_gsxjk_ie55JCbrmYSPxxm_O4XKMENP6V6zmA@mail.gmail.com>
Subject: Re: [PATCH 11/32] bsd-user: Get number of cpus.
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org, 
 Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000e276240604162631"
Received-SPF: none client-ip=2a00:1450:4864:20::12f;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x12f.google.com
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

--000000000000e276240604162631
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2023 at 1:50=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/27/23 08:57, Karim Taha wrote:
> > From: Kyle Evans <kevans@FreeBSD.org>
> >
> > Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> > Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> > ---
> >   bsd-user/bsd-proc.c | 39 +++++++++++++++++++++++++++++++++++++++
> >   bsd-user/bsd-proc.h |  2 ++
> >   2 files changed, 41 insertions(+)
> >
> > diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
> > index 49c0fb67d0..dd6bad6de3 100644
> > --- a/bsd-user/bsd-proc.c
> > +++ b/bsd-user/bsd-proc.c
> > @@ -185,3 +185,42 @@ int host_to_target_waitstatus(int status)
> >       return status;
> >   }
> >
> > +int bsd_get_ncpu(void)
> > +{
> > +    static int ncpu =3D -1;
> > +
> > +    if (ncpu !=3D -1) {
> > +        return ncpu;
> > +    }
> > +    if (ncpu =3D=3D -1) {
> > +        cpuset_t mask;
> > +
> > +        CPU_ZERO(&mask);
> > +
> > +        if (cpuset_getaffinity(CPU_LEVEL_WHICH, CPU_WHICH_TID, -1,
> sizeof(mask),
> > +                               &mask) =3D=3D 0) {
> > +            ncpu =3D CPU_COUNT(&mask);
> > +        }
> > +    }
> > +#ifdef _SC_NPROCESSORS_ONLN
> > +    if (ncpu =3D=3D -1)
> > +        ncpu =3D sysconf(_SC_NPROCESSORS_ONLN);
> > +#endif
> > +#if defined(CTL_HW) && defined(HW_NCPU)
> > +    if (ncpu =3D=3D -1) {
> > +        int mib[2] =3D {CTL_HW, HW_NCPU};
> > +        size_t sz;
> > +
> > +        sz =3D sizeof(ncpu);
> > +        if (sysctl(mib, 2, &ncpu, &sz, NULL, NULL) =3D=3D -1) {
> > +            ncpu =3D -1;
> > +        }
> > +    }
> > +#endif
> > +    if (ncpu =3D=3D -1) {
> > +        gemu_log("XXX Missing bsd_get_ncpu() implementation\n");
> > +        ncpu =3D 1;
> > +    }
> > +    return ncpu;
> > +}
>
> This has the look of odd compatibility code.  Surely all three of these
> alternatives are
> functional, and that sysconf() is easiest to use.
>

This code dates to the earliest days of the emulator when it ran on all
three BSDs. NetBSD
does support _SC_NPROCESSORS_ONLN, so we should leave that case.

I think the getaffinity stuff is there so that one can restrict a process
group to a subset of
the CPUs in the system for nicer build farms, but I could be mistaken about
that.  NetBSD
doesn't support this call, AFAICT, but I'd rather not add #ifdef's for
NetBSD until we actually
do a NetBSD port. I'll have to check with Kyle to see if that was really
needed, or if the
code was cut and pasted from elsewhere.

I don't think we need to fall back to the 4.4BSD hw.ncpu sysctl. Everybody
supports the sysconf
interface.


> Looking at the freebsd implementation of sysconf, it uses AT_NCPUS if
> available, so the
> value is already cached within the process in the common case.  So I also
> don't see a need
> for the ncpu local static either.
>

I agree with this... We only use it to impelment hw.ncpu emulation, and to
set AT_NCPUS
when we load, so who cares if it's expensive :).

Warner

--000000000000e276240604162631
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 29, 2023 at 1:50=E2=80=AF=
PM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ri=
chard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On 8/27/23 08:57, Karim Taha wrote:<br>
&gt; From: Kyle Evans &lt;kevans@FreeBSD.org&gt;<br>
&gt; <br>
&gt; Signed-off-by: Kyle Evans &lt;kevans@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.c=
om" target=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/bsd-proc.c | 39 +++++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 =C2=A0bsd-user/bsd-proc.h |=C2=A0 2 ++<br>
&gt;=C2=A0 =C2=A02 files changed, 41 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c<br>
&gt; index 49c0fb67d0..dd6bad6de3 100644<br>
&gt; --- a/bsd-user/bsd-proc.c<br>
&gt; +++ b/bsd-user/bsd-proc.c<br>
&gt; @@ -185,3 +185,42 @@ int host_to_target_waitstatus(int status)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return status;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +int bsd_get_ncpu(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 static int ncpu =3D -1;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (ncpu !=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ncpu;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (ncpu =3D=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpuset_t mask;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CPU_ZERO(&amp;mask);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpuset_getaffinity(CPU_LEVEL_WHICH, C=
PU_WHICH_TID, -1, sizeof(mask),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;mask) =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ncpu =3D CPU_COUNT(&amp;mas=
k);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +#ifdef _SC_NPROCESSORS_ONLN<br>
&gt; +=C2=A0 =C2=A0 if (ncpu =3D=3D -1)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ncpu =3D sysconf(_SC_NPROCESSORS_ONLN);<b=
r>
&gt; +#endif<br>
&gt; +#if defined(CTL_HW) &amp;&amp; defined(HW_NCPU)<br>
&gt; +=C2=A0 =C2=A0 if (ncpu =3D=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int mib[2] =3D {CTL_HW, HW_NCPU};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t sz;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sz =3D sizeof(ncpu);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sysctl(mib, 2, &amp;ncpu, &amp;sz, NU=
LL, NULL) =3D=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ncpu =3D -1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +#endif<br>
&gt; +=C2=A0 =C2=A0 if (ncpu =3D=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gemu_log(&quot;XXX Missing bsd_get_ncpu()=
 implementation\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ncpu =3D 1;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return ncpu;<br>
&gt; +}<br>
<br>
This has the look of odd compatibility code.=C2=A0 Surely all three of thes=
e alternatives are <br>
functional, and that sysconf() is easiest to use.<br></blockquote><div><br>=
</div><div>This code dates to the earliest days of the emulator when it ran=
 on all three BSDs. NetBSD</div><div>does support _SC_NPROCESSORS_ONLN, so =
we should leave that case.</div><div><br></div><div>I think the getaffinity=
 stuff is there so that one can restrict a process group to a subset of</di=
v><div>the CPUs in the system for nicer build farms, but I could be mistake=
n about that.=C2=A0 NetBSD</div><div>doesn&#39;t support this call, AFAICT,=
 but I&#39;d rather not add #ifdef&#39;s for NetBSD until we actually</div>=
<div>do a NetBSD port. I&#39;ll have to check with Kyle to see if that was =
really needed, or if the</div><div>code was cut and pasted from elsewhere.<=
/div><div><br></div><div><div>I don&#39;t think we need to fall back to the=
 4.4BSD hw.ncpu sysctl. Everybody supports the sysconf</div></div><div>inte=
rface.</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
Looking at the freebsd implementation of sysconf, it uses AT_NCPUS if avail=
able, so the <br>
value is already cached within the process in the common case.=C2=A0 So I a=
lso don&#39;t see a need <br>
for the ncpu local static either.<br></blockquote><div><br></div><div>I agr=
ee with this... We only use it to impelment=C2=A0hw.ncpu emulation, and to =
set AT_NCPUS</div><div>when we load, so who cares if it&#39;s expensive :).=
</div><div><br></div><div>Warner</div></div></div>

--000000000000e276240604162631--

