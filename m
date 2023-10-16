Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4947CB225
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 20:17:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsS7y-0000MS-Oh; Mon, 16 Oct 2023 14:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qsS7r-0000IW-Gf
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 14:15:35 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qsS7m-0000hz-7b
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 14:15:33 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5079f9675c6so3917773e87.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 11:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697480128; x=1698084928; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IYbux+zadBFS1HjA2luOplK3AtgPDd2Kog+TNeE+pb0=;
 b=VjpZWnO8JoZRQIDq8jm8xJ1oinyQ+vXoc1xlsGSydZ5UcMLm1IRPdne9wLSvJGhu/6
 5C1EJq+VTfo5vzvRdr1Sgn+U9GDONdz+aqJV7qkCwYItzU1XplzGtAKEOKgCqAgmqngE
 phQorZzeoHgptSuBupNzNn5zIEu0RAYt28q+X7u2FgLnS0RjL6eHUUTCDgIKGzYM7aFF
 GLKRpwt+lT1Ge7wunc6pryrAUKToofbgb0Q3BKbAmCwgAE42YHuYe/aVGDzP0YyaTozu
 UfoNrT8iYU1B5v/1KDs83t9zEL3TdI05gXHLZ9qnrWRSz8YF6uJ/SK70cL4QL887MD4Q
 j/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697480128; x=1698084928;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IYbux+zadBFS1HjA2luOplK3AtgPDd2Kog+TNeE+pb0=;
 b=Eu0IteMxvXCqbA6sh7Z7buj5TIQnC25ciD6UCitxXD9UALfORhdLdpOA+OK/fxyM+J
 Ihym9GD0NlcHfhx2NFw3cgO3MR70ifdWYeS9MZ2BkTl9yaLrEqTFG66rfJXHjT3zgRiN
 b4qN6VQk5K3vHgNB4TKTEvzKZp6uWKvet+mpwdOfxU61hOR8rSWXw/Hq3MlDX90+zfGv
 RA2VHStBriE3gVXrBzn/3cbSS0Gf1I60kM/QkF6igeBWI0+6+LW80wOSC8P/VjKU16ka
 FbK2G4M5eh9VRxi8PIeKcTS/GSFXWReCR83dGv8U65mQ4vnLveZ1A8aAMz38IhsKbSQV
 JY8w==
X-Gm-Message-State: AOJu0YyX95K19e06as79EZ0cDlXVBpr1MKYF8EiTC9CIfqBndWSeNw4i
 U90RMyg10S3mrbnIfUwKsNIGRchvBi85gmu+et0EwQ==
X-Google-Smtp-Source: AGHT+IEoJS4spPSjkWvR2ebg4rAtd32X1WNSEXWrj1sQHGvvdAORmvKcslK0lWWkrjVcrXrvUGqm/femr4uSLy1qrCo=
X-Received: by 2002:a05:6512:220e:b0:507:b853:c96 with SMTP id
 h14-20020a056512220e00b00507b8530c96mr76636lfu.48.1697480127476; Mon, 16 Oct
 2023 11:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
 <87o7h2hey5.fsf@pond.sub.org>
 <CAFEAcA-LQP_dQ0mjeNe8nOtMVy22iwJt2yfG5m_f4oQjQ9ts7w@mail.gmail.com>
 <CAAjaMXYfu2rVVUkwAczqQRHxgFrYr=hQHP_UGn7LVUks+DFz4A@mail.gmail.com>
 <CAFEAcA_fLBe9CuWFYpeuejj8dcerhFtPNX+iVaVFvH4SXx1oAg@mail.gmail.com>
In-Reply-To: <CAFEAcA_fLBe9CuWFYpeuejj8dcerhFtPNX+iVaVFvH4SXx1oAg@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 16 Oct 2023 21:15:13 +0300
Message-ID: <CAAjaMXYJXRNqmbiY8SSXbr1hFcsN14kZp=_acXx-3f++Y-d74w@mail.gmail.com>
Subject: Re: [RFC PATCH 00/78] Strict disable implicit fallthrough
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 "open list:ARM SMMU" <qemu-arm@nongnu.org>,
 "open list:Block Jobs" <qemu-block@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000030ed60607d96428"
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000030ed60607d96428
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Oct 2023, 18:04 Peter Maydell, <peter.maydell@linaro.org> wrote:

> On Mon, 16 Oct 2023 at 15:58, Manos Pitsidianakis
> <manos.pitsidianakis@linaro.org> wrote:
> >
> > Hello Peter,
> >
> > On Mon, 16 Oct 2023, 17:13 Peter Maydell, <peter.maydell@linaro.org>
> wrote:
> >>
> >> On Fri, 13 Oct 2023 at 13:42, Markus Armbruster <armbru@redhat.com>
> wrote:
> >> >
> >> > Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
> >> >
> >> > > Hello,
> >> > >
> >> > > This RFC is inspired by the kernel's move to
> -Wimplicit-fallthrough=3
> >> > > back in 2019.[0]
> >> > > We take one step (or two) further by increasing it to 5 which
> rejects
> >> > > fall through comments and requires an attribute statement.
> >> > >
> >> > > [0]:
> >> > >
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a035d552a93b
> >> > >
> >> > > The line differences are not many, but they spread all over
> different
> >> > > subsystems, architectures and devices. An attempt has been made to
> split
> >> > > them in cohesive patches to aid post-RFC review. Part of the RFC is
> to
> >> > > determine whether these patch divisions needs improvement.
> >> > >
> >> > > Main questions this RFC poses
> >> > > =============================
> >> > >
> >> > > - Is this change desirable and net-positive.
> >> >
> >> > Unwanted fallthrough is an easy mistake to make, and
> >> > -Wimplicit-fallthrough=N helps avoid it.  The question is how far up
> we
> >> > need to push N.  Right now we're at N=2.  Has unwanted fallthrough
> been
> >> > a problem?
> >>
> >> Mmm, this is my opinion I think. We have a mechanism for
> >> catching "forgot the 'break'" already (our =2 setting) and
> >> a way to say "intentional" in a fairly natural way (add the
> >> comment). Does pushing N up any further gain us anything
> >> except a load of churn?
> >>
> >> Also, the compiler is not the only thing that processes our
> >> code: Coverity also looks for "unexpected fallthrough" issues,
> >> so if we wanted to switch away from our current practice we
> >> should check whether what we're switching to is an idiom
> >> that Coverity recognises.
> >
> >
> > It is a code style change as the cover letter mentions, it's not related
> to the static analysis itself.
>
> Yes, exactly. As a code style change it needs a fairly high level
> of justification for the code churn, and the cover letter
> doesn't really provide one...
>


As I state in the cover letter, I personally find that using one macro
instead of a comment regex feels more consistent. But your view is valid as
well!

Let's consider the RFC retracted then.

--
Manos

>

--000000000000030ed60607d96428
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Mon, 16 Oct 2023, 18:04 Peter Maydell, &lt;<a href=3D"mailt=
o:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">On Mon, 16 Oct 2023 at 15:58, Manos Pitsid=
ianakis<br>
&lt;<a href=3D"mailto:manos.pitsidianakis@linaro.org" target=3D"_blank" rel=
=3D"noreferrer">manos.pitsidianakis@linaro.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Hello Peter,<br>
&gt;<br>
&gt; On Mon, 16 Oct 2023, 17:13 Peter Maydell, &lt;<a href=3D"mailto:peter.=
maydell@linaro.org" target=3D"_blank" rel=3D"noreferrer">peter.maydell@lina=
ro.org</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Fri, 13 Oct 2023 at 13:42, Markus Armbruster &lt;<a href=3D"mai=
lto:armbru@redhat.com" target=3D"_blank" rel=3D"noreferrer">armbru@redhat.c=
om</a>&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Emmanouil Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidian=
akis@linaro.org" target=3D"_blank" rel=3D"noreferrer">manos.pitsidianakis@l=
inaro.org</a>&gt; writes:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; &gt; Hello,<br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; This RFC is inspired by the kernel&#39;s move to -Wimpli=
cit-fallthrough=3D3<br>
&gt;&gt; &gt; &gt; back in 2019.[0]<br>
&gt;&gt; &gt; &gt; We take one step (or two) further by increasing it to 5 =
which rejects<br>
&gt;&gt; &gt; &gt; fall through comments and requires an attribute statemen=
t.<br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; [0]:<br>
&gt;&gt; &gt; &gt; <a href=3D"https://git.kernel.org/pub/scm/linux/kernel/g=
it/torvalds/linux.git/commit/?id=3Da035d552a93b" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://git.kernel.org/pub/scm/linux/kernel/git/torva=
lds/linux.git/commit/?id=3Da035d552a93b</a><br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; The line differences are not many, but they spread all o=
ver different<br>
&gt;&gt; &gt; &gt; subsystems, architectures and devices. An attempt has be=
en made to split<br>
&gt;&gt; &gt; &gt; them in cohesive patches to aid post-RFC review. Part of=
 the RFC is to<br>
&gt;&gt; &gt; &gt; determine whether these patch divisions needs improvemen=
t.<br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; Main questions this RFC poses<br>
&gt;&gt; &gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; - Is this change desirable and net-positive.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Unwanted fallthrough is an easy mistake to make, and<br>
&gt;&gt; &gt; -Wimplicit-fallthrough=3DN helps avoid it.=C2=A0 The question=
 is how far up we<br>
&gt;&gt; &gt; need to push N.=C2=A0 Right now we&#39;re at N=3D2.=C2=A0 Has=
 unwanted fallthrough been<br>
&gt;&gt; &gt; a problem?<br>
&gt;&gt;<br>
&gt;&gt; Mmm, this is my opinion I think. We have a mechanism for<br>
&gt;&gt; catching &quot;forgot the &#39;break&#39;&quot; already (our =3D2 =
setting) and<br>
&gt;&gt; a way to say &quot;intentional&quot; in a fairly natural way (add =
the<br>
&gt;&gt; comment). Does pushing N up any further gain us anything<br>
&gt;&gt; except a load of churn?<br>
&gt;&gt;<br>
&gt;&gt; Also, the compiler is not the only thing that processes our<br>
&gt;&gt; code: Coverity also looks for &quot;unexpected fallthrough&quot; i=
ssues,<br>
&gt;&gt; so if we wanted to switch away from our current practice we<br>
&gt;&gt; should check whether what we&#39;re switching to is an idiom<br>
&gt;&gt; that Coverity recognises.<br>
&gt;<br>
&gt;<br>
&gt; It is a code style change as the cover letter mentions, it&#39;s not r=
elated to the static analysis itself.<br>
<br>
Yes, exactly. As a code style change it needs a fairly high level<br>
of justification for the code churn, and the cover letter<br>
doesn&#39;t really provide one...<br></blockquote></div></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto">As I state in =
the cover letter, I personally find that using one macro instead of a comme=
nt regex feels more consistent. But your view is valid as well!</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">Let&#39;s consider the RFC retracte=
d then.</div><div dir=3D"auto"><br></div><div dir=3D"auto">--</div><div dir=
=3D"auto">Manos</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000030ed60607d96428--

