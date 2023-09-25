Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9630A7ADD4D
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 18:38:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkoaa-00065i-FL; Mon, 25 Sep 2023 12:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qkoaY-00065T-B2
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 12:37:38 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qkoaW-0004ib-5g
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 12:37:38 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50437f39c9dso8706727e87.3
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 09:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695659854; x=1696264654;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1Rsqm8JgXzWwamONegf/Lrnq3cmiEQv1Af8ZXLhPlwU=;
 b=OQqJTM9Q2jlfwtbiYgehaWeQbsQdZx/I0BpeCOrLQ6Z9Pc/Awi9wW7GrXNAkwTpcBF
 O0lMyhc70YhFZUV9g52iSzTEoUho162E6pZ/aDfSl0CCWZ/dYjhmwcNFmL6nHR/JViPl
 GiOqacWA18klwzMPxAY5k3e6kOeFSisMBuIoA6EGai2tCmKVYMtRNRJ/H0KUUjAieaUi
 no84zFae6vSmpIa2PPVU1Mw7Mq0t7EQehnT3M1Kr57u0v9I/1D0+s62asdIYv1cFzcmv
 fBuOzx0+2r2SVKRS/o39jQY+bo9F97QJwrflckh82K/7CzK+oi8HJ1nquFltgze8aYSa
 lgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695659854; x=1696264654;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1Rsqm8JgXzWwamONegf/Lrnq3cmiEQv1Af8ZXLhPlwU=;
 b=q+ilbtHbXT/rIPKo/eLWCOZ9Fh9HG1AZcXdiBoLpZdhPonAFeKos1G9goDjC/KFItG
 r6miHmAlG9IR65NrVVW2xMsK76+JzDoozKca5p21qmjzvZhZ6nWGdyRo5a9Nqw4mtg09
 wAq6AuQ1+yejtEKsDNx9mKmYtP83fGh7B9HqaTgCwviINUnU61tt4H7z6ew8lTnRjCOj
 JbPzlQr9vEzVOBYlNEw1DPWiSkfOIQ83D95+GrydACH9y/ER4EUZgxN3VWLcZV2JrFIP
 g4amXXXkgHye76l9Zs9FFcsXZOFPz7jIik+FCbU60Y3diX5GOmr3MTX2sEExuRu9OZ4h
 YZBA==
X-Gm-Message-State: AOJu0YzrgJRu6uiIeNxtOYBH+TPJAuZvjhdh7Hr+UKySM2+2pK3r7RSw
 JzYD3aQowr62e3uud4o6c9hy0H6dIvT7z0h3IMSkgA==
X-Google-Smtp-Source: AGHT+IED3hpS2RoYndBIznd7dmeR+vZQ6WKIK7H8TFWbqOOGMLUObSAaBXiC4TkVb8UdfenCckM/YVzmsKIvVxHP3EI=
X-Received: by 2002:ac2:5e34:0:b0:500:9734:545a with SMTP id
 o20-20020ac25e34000000b005009734545amr5392135lfg.5.1695659853664; Mon, 25 Sep
 2023 09:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <87r0mqlf9x.fsf@pond.sub.org>
 <f7fca6b0-ed28-8f72-e960-f73f2bc8fcbe@gmail.com>
 <CAFEAcA9Mi0rwUo5x0ejQdvosokALc5XFT2oLqgHuaXLZWNom0w@mail.gmail.com>
 <CANCZdfpKyAf+pSwv-A7JeDFF0+Q4jiV_Dmg=SGJG_+w-68LzRw@mail.gmail.com>
 <CAFEAcA9QKUYYpqnpKQfKrhPOWpzmwNcuz+PcJgnSNJ2cDec87Q@mail.gmail.com>
In-Reply-To: <CAFEAcA9QKUYYpqnpKQfKrhPOWpzmwNcuz+PcJgnSNJ2cDec87Q@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 25 Sep 2023 10:37:22 -0600
Message-ID: <CANCZdfrQHgvozKTHrRuRh=e4EK6kXor=uq+PcesrUc4W18rcnQ@mail.gmail.com>
Subject: Re: Help wanted for enabling -Wshadow=local
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 Alberto Garcia <berto@igalia.com>, Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jeffery <andrew@aj.id.au>, Ani Sinha <anisinha@redhat.com>,
 Brian Cain <bcain@quicinc.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 "Daniel P. Berrange" <berrange@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, 
 Eduardo Habkost <eduardo@habkost.net>, Eric Auger <eric.auger@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>,
 Fan Ni <fan.ni@samsung.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Joel Stanley <joel@jms.id.au>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Laurent Vivier <laurent@vivier.eu>, 
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Thomas Huth <thuth@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000003cedbe0606319344"
Received-SPF: none client-ip=2a00:1450:4864:20::129;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x129.google.com
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

--0000000000003cedbe0606319344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 23, 2023 at 6:33=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Fri, 22 Sept 2023 at 19:59, Warner Losh <imp@bsdimp.com> wrote:
> > The third one, though, makes me ask the question: When should we
> > pass in cpu_env to functions and when should we use the global value?
> >
> > I have a lot of changes that look like:
> >
> > -static inline abi_long do_freebsd_thr_exit(CPUArchState *cpu_env,
> > +static inline abi_long do_freebsd_thr_exit(CPUArchState *env,
> >          abi_ulong tid_addr)
> >  {
> > -    CPUState *cpu =3D env_cpu(cpu_env);
> > +    CPUState *cpu =3D env_cpu(env);
> >      TaskState *ts;
> > ...
> > <other cases of cpu_env -> env>
> >
> > Should I just drop the arg, or do the arg rename? Or "Gee, Warner,
> > that really depends since it's context sensitive" in which case
> > I'll just post a review to the list.
>
> Is this the "extern TCGv_env cpu_env;" in tcg/tcg.h ?
>

Yes.


> As a TCGv_env, that is only of any use in the TCG frontends,
> not in the bsd-user/ or linux-user/ code. In fact almost
> all of tcg/tcg.h is intended for the TCG frontends, so the
> "ideal" solution to this would be to not include it in the
> bsd-user code. This might mean figuring out what parts of
> it need to be split out into different headers. (linux-user
> also includes tcg/tcg.h.)
>

I saw your other changes, and I think that would be good for
bsd-user as well. I don't think we're using it anywhere directly.


> However, this isn't necessary for the current effort, because
> -Wshadow=3Dlocal only warns about local-to-local shadowing,
> not cases where a local shadows a global.
>

Yea, clang was having heartburn with -Wshadow=3D<anything> so
I had to run things with -Wshadow.

Warner


> thanks
> -- PMM
>

--0000000000003cedbe0606319344
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Sep 23, 2023 at 6:33=E2=80=AF=
AM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.mayd=
ell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Fri, 22 Sept 2023 at 19:59, Warner Losh &lt;<a href=3D"mai=
lto:imp@bsdimp.com" target=3D"_blank">imp@bsdimp.com</a>&gt; wrote:<br>
&gt; The third one, though, makes me ask the question: When should we<br>
&gt; pass in cpu_env to functions and when should we use the global value?<=
br>
&gt;<br>
&gt; I have a lot of changes that look like:<br>
&gt;<br>
&gt; -static inline abi_long do_freebsd_thr_exit(CPUArchState *cpu_env,<br>
&gt; +static inline abi_long do_freebsd_thr_exit(CPUArchState *env,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong tid_addr)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 CPUState *cpu =3D env_cpu(cpu_env);<br>
&gt; +=C2=A0 =C2=A0 CPUState *cpu =3D env_cpu(env);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 TaskState *ts;<br>
&gt; ...<br>
&gt; &lt;other cases of cpu_env -&gt; env&gt;<br>
&gt;<br>
&gt; Should I just drop the arg, or do the arg rename? Or &quot;Gee, Warner=
,<br>
&gt; that really depends since it&#39;s context sensitive&quot; in which ca=
se<br>
&gt; I&#39;ll just post a review to the list.<br>
<br>
Is this the &quot;extern TCGv_env cpu_env;&quot; in tcg/tcg.h ?<br></blockq=
uote><div><br></div><div>Yes.</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
As a TCGv_env, that is only of any use in the TCG frontends,<br>
not in the bsd-user/ or linux-user/ code. In fact almost<br>
all of tcg/tcg.h is intended for the TCG frontends, so the<br>
&quot;ideal&quot; solution to this would be to not include it in the<br>
bsd-user code. This might mean figuring out what parts of<br>
it need to be split out into different headers. (linux-user<br>
also includes tcg/tcg.h.)<br></blockquote><div><br></div><div>I saw your ot=
her changes, and I think that would be good for</div><div>bsd-user as well.=
 I don&#39;t think we&#39;re using it anywhere directly.</div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
However, this isn&#39;t necessary for the current effort, because<br>
-Wshadow=3Dlocal only warns about local-to-local shadowing,<br>
not cases where a local shadows a global.<br></blockquote><div><br></div><d=
iv>Yea, clang was having heartburn with -Wshadow=3D&lt;anything&gt; so</div=
><div>I had to run things with -Wshadow.</div><div><br></div><div>Warner</d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
thanks<br>
-- PMM<br>
</blockquote></div></div>

--0000000000003cedbe0606319344--

