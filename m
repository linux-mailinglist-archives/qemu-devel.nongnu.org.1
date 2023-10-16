Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B8E7CACB7
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 17:00:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsP3O-0005aY-Io; Mon, 16 Oct 2023 10:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qsP3M-0005Za-BJ
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 10:58:44 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qsP3K-0005Ll-H4
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 10:58:44 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9becde9ea7bso415190166b.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 07:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697468321; x=1698073121; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=diUamlBHjZf6xyEHj/pxt4Vry4evnH5aDuUnyiLvoHM=;
 b=d7VKU/eZBXOmUWoClWGA8ynJyT09EqQpSK3H1LoFxJT5Ws7nJpxtv4qe9VQjVD+/Gi
 N4pP2uHncLdkriKccTfuWZk3U2T1yMI5mKX00/syn4c9TmhxAWmLrFZYC+n37E3StHaw
 9Ct7HiPTc+kqIm3S5sMNAxoRkoL5B4EXxwnZUAS99SlVHrevDUTZ/ndyt84sGA8v177S
 v6KJukZ/bXlPBK0m//vln5tQ8446in6T3goreXyrU1HRhnYbcFQSH51lTiWnnbX4L4u9
 9TI8fzS9mUx0nPmR2/rsQlEGGAoGuDGbZ5NRSXHQYm385UNZqaVNaM7H6ainL9gYnuYI
 q36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697468321; x=1698073121;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=diUamlBHjZf6xyEHj/pxt4Vry4evnH5aDuUnyiLvoHM=;
 b=vxxfyEF43z/rJrx2mDjry0qxmUMjPhD0DhFOFCMA+OkLj1VFaQNjISy40sDE27ob6b
 d2SOOWJZbMNG2JDmSnMZPD8URns+t+iksoiM74q7W97K/NGrKJVVtccMJZUnWfv8ZuR1
 Bt6LwX+XEbmbDCQgxgLKLcsfFbd8GkdXrYIkHkDXNfKJCpqwWKOL4RMY9SjeuhISo/j9
 gQirSv07XR8uzOvOIyQONJ5uPtfz+0D4uiJ5CVTLFKU1V+EK3TKydAccU/PezRcT+T0n
 9tBsTr4ReyXO3DwAWB/khPYi9NOZuXaM7CMgRG9TlWT06BkyjzD84xWEMDYkedJ+Vv4T
 fBCA==
X-Gm-Message-State: AOJu0YzUAwahYt3P+FnxD/lY1UcwYJ6UsmizrQjPIy4vvGk6yJY4z2lb
 BKjzQhQwcooDj8mch1fiIvQRfEyAIVnx5EhLGYnfo4W5JjjgJ0RC
X-Google-Smtp-Source: AGHT+IGKspy9MZEuY83DIJOZy8XLc4dkXkHkShz5qYNEJnM5Nod1n4w2QLB4qK1YGIiQFpDffCX+5QFasbSTxiDg8cc=
X-Received: by 2002:a17:907:c26:b0:9ad:8a96:ad55 with SMTP id
 ga38-20020a1709070c2600b009ad8a96ad55mr7717305ejc.14.1697468320868; Mon, 16
 Oct 2023 07:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
 <87o7h2hey5.fsf@pond.sub.org>
 <CAFEAcA-LQP_dQ0mjeNe8nOtMVy22iwJt2yfG5m_f4oQjQ9ts7w@mail.gmail.com>
In-Reply-To: <CAFEAcA-LQP_dQ0mjeNe8nOtMVy22iwJt2yfG5m_f4oQjQ9ts7w@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 16 Oct 2023 17:58:28 +0300
Message-ID: <CAAjaMXYfu2rVVUkwAczqQRHxgFrYr=hQHP_UGn7LVUks+DFz4A@mail.gmail.com>
Subject: Re: [RFC PATCH 00/78] Strict disable implicit fallthrough
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 "open list:ARM SMMU" <qemu-arm@nongnu.org>,
 "open list:Block Jobs" <qemu-block@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000487ca90607d6a4f7"
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000487ca90607d6a4f7
Content-Type: text/plain; charset="UTF-8"

Hello Peter,

On Mon, 16 Oct 2023, 17:13 Peter Maydell, <peter.maydell@linaro.org> wrote:

> On Fri, 13 Oct 2023 at 13:42, Markus Armbruster <armbru@redhat.com> wrote:
> >
> > Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
> >
> > > Hello,
> > >
> > > This RFC is inspired by the kernel's move to -Wimplicit-fallthrough=3
> > > back in 2019.[0]
> > > We take one step (or two) further by increasing it to 5 which rejects
> > > fall through comments and requires an attribute statement.
> > >
> > > [0]:
> > >
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a035d552a93b
> > >
> > > The line differences are not many, but they spread all over different
> > > subsystems, architectures and devices. An attempt has been made to
> split
> > > them in cohesive patches to aid post-RFC review. Part of the RFC is to
> > > determine whether these patch divisions needs improvement.
> > >
> > > Main questions this RFC poses
> > > =============================
> > >
> > > - Is this change desirable and net-positive.
> >
> > Unwanted fallthrough is an easy mistake to make, and
> > -Wimplicit-fallthrough=N helps avoid it.  The question is how far up we
> > need to push N.  Right now we're at N=2.  Has unwanted fallthrough been
> > a problem?
>
> Mmm, this is my opinion I think. We have a mechanism for
> catching "forgot the 'break'" already (our =2 setting) and
> a way to say "intentional" in a fairly natural way (add the
> comment). Does pushing N up any further gain us anything
> except a load of churn?
>
> Also, the compiler is not the only thing that processes our
> code: Coverity also looks for "unexpected fallthrough" issues,
> so if we wanted to switch away from our current practice we
> should check whether what we're switching to is an idiom
> that Coverity recognises.
>

It is a code style change as the cover letter mentions, it's not related to
the static analysis itself.

--
Manos

>

--000000000000487ca90607d6a4f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hello Peter,<br><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Mon, 16 Oct 2023, 17:13 Peter Maydell, =
&lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Fri, 13 Oct 2023 at=
 13:42, Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Emmanouil Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidianakis@lina=
ro.org" target=3D"_blank" rel=3D"noreferrer">manos.pitsidianakis@linaro.org=
</a>&gt; writes:<br>
&gt;<br>
&gt; &gt; Hello,<br>
&gt; &gt;<br>
&gt; &gt; This RFC is inspired by the kernel&#39;s move to -Wimplicit-fallt=
hrough=3D3<br>
&gt; &gt; back in 2019.[0]<br>
&gt; &gt; We take one step (or two) further by increasing it to 5 which rej=
ects<br>
&gt; &gt; fall through comments and requires an attribute statement.<br>
&gt; &gt;<br>
&gt; &gt; [0]:<br>
&gt; &gt; <a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/torval=
ds/linux.git/commit/?id=3Da035d552a93b" rel=3D"noreferrer noreferrer" targe=
t=3D"_blank">https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
.git/commit/?id=3Da035d552a93b</a><br>
&gt; &gt;<br>
&gt; &gt; The line differences are not many, but they spread all over diffe=
rent<br>
&gt; &gt; subsystems, architectures and devices. An attempt has been made t=
o split<br>
&gt; &gt; them in cohesive patches to aid post-RFC review. Part of the RFC =
is to<br>
&gt; &gt; determine whether these patch divisions needs improvement.<br>
&gt; &gt;<br>
&gt; &gt; Main questions this RFC poses<br>
&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; &gt;<br>
&gt; &gt; - Is this change desirable and net-positive.<br>
&gt;<br>
&gt; Unwanted fallthrough is an easy mistake to make, and<br>
&gt; -Wimplicit-fallthrough=3DN helps avoid it.=C2=A0 The question is how f=
ar up we<br>
&gt; need to push N.=C2=A0 Right now we&#39;re at N=3D2.=C2=A0 Has unwanted=
 fallthrough been<br>
&gt; a problem?<br>
<br>
Mmm, this is my opinion I think. We have a mechanism for<br>
catching &quot;forgot the &#39;break&#39;&quot; already (our =3D2 setting) =
and<br>
a way to say &quot;intentional&quot; in a fairly natural way (add the<br>
comment). Does pushing N up any further gain us anything<br>
except a load of churn?<br>
<br>
Also, the compiler is not the only thing that processes our<br>
code: Coverity also looks for &quot;unexpected fallthrough&quot; issues,<br=
>
so if we wanted to switch away from our current practice we<br>
should check whether what we&#39;re switching to is an idiom<br>
that Coverity recognises.<br></blockquote></div></div><div dir=3D"auto"><br=
></div><div dir=3D"auto">It is a code style change as the cover letter ment=
ions, it&#39;s not related to the static analysis itself.</div><div dir=3D"=
auto"><br></div><div dir=3D"auto">--</div><div dir=3D"auto">Manos</div><div=
 dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000487ca90607d6a4f7--

