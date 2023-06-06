Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E4372494D
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 18:38:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6ZgH-0001ng-2P; Tue, 06 Jun 2023 12:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsun@junsun.net>) id 1q6ZgC-0001kL-1G
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 12:37:08 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jsun@junsun.net>) id 1q6Zg4-0005rR-Uu
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 12:37:07 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-ba81ded8d3eso7538405276.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 09:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=junsun-net.20221208.gappssmtp.com; s=20221208; t=1686069417; x=1688661417;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=du6FolFauPkWsIPDuDA9LpPxOqacVGGJ6by6Rl3FD+w=;
 b=YgPKpcX0g/CFZAOWt+CRxiTbE3Z8jB6TH+reUEm+405HV5DYaNJH4bUO3RTgLr+iO7
 EjRun/O+YWJvU4Fp9gADbZCe01IPkHT7Uii7BOpyFega/gOfyNnlSuqvpgRCW3+kzNDS
 5oC/pikM1qn+J9afRs39ziJCxl43VqRdofuGGrAvnEz7Mw4+KJBLETD0hI/4TBB69xS5
 2lnLAdHrqLtlCEL+RpRK+pb2XyAAUgoU2mTIMcO0yjzauUEgxn6xlT3Rf6SDW9WJejS3
 UeSH0P5dda1z9bsNTnprI6bmKSMwGthNwFYX7mql2l4eT/clLvILz5mKOlNAKu/HI1mF
 TMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686069417; x=1688661417;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=du6FolFauPkWsIPDuDA9LpPxOqacVGGJ6by6Rl3FD+w=;
 b=AYfSeua03kWJqnI6IfB7bz55uKHktARG9GUqsZECSUKs2YecbsS6fHr7kc8iVkr3lx
 OYoD9gx4dQwmvUxla7pQOFm4HXHobxg9pOZm90JOvJoyZp0oM/Dyy+7tBZmolKcf20sC
 2ivPsWK2SPSb423c2NoQj+WdRbnoXHfW5r4RtGtnIBnFZ+Trk8+OQZdqcF/M5euDNlIs
 k3HzM2+g15FxlwcO4R3oajgwvG1nyxjWPT2mIuYR8rNLGC0Voyao2pQAg28+6eK+f/sc
 ZVojRhOO6FjmlwR+kg7Lp2gZesa7CGMa8Oz7CIQUJhG8x7I6do+5Vsw0IhAeeB7Cec4i
 ukIg==
X-Gm-Message-State: AC+VfDyy1Xxu/QAIurJhwSvM/5NVxbg6dxyyK+w9RVrBAYTSqIOQyWmr
 mbMoh1BHQh8zPzQszVeafqQcVZXr+TB3Pp1RJ9T89Q==
X-Google-Smtp-Source: ACHHUZ6VHgTlKJT2MFY0B1L/3tnNbY2FlcEOgn8u0odh0vOYLcd/jdmuRU8KApYuxmYZXuoBcV7X8uQQ6dHGMpNQEmc=
X-Received: by 2002:a25:f204:0:b0:ba8:54c4:3136 with SMTP id
 i4-20020a25f204000000b00ba854c43136mr2625354ybe.52.1686069417401; Tue, 06 Jun
 2023 09:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAP5Nno6wrz4qEMK70KFwxoZWeo89+SAyXDXFW8A30mJ-WeFi4A@mail.gmail.com>
 <87ttwts5ur.fsf@linaro.org>
 <CAP5Nno4C6C-sfj73NM92Gstnw8mm7A7RwEYT=oUZm1Fh0QqFYQ@mail.gmail.com>
 <CAFEAcA-wT3OUZzkVA8riMRDWE4M_f3yZD2HLHSTksLUVM+kH3Q@mail.gmail.com>
 <87wn15lrab.fsf@linaro.org>
In-Reply-To: <87wn15lrab.fsf@linaro.org>
From: Jun Sun <jsun@junsun.net>
Date: Tue, 6 Jun 2023 09:36:49 -0700
Message-ID: <CAP5Nno7q2hh-aJit08BqMww5S1sKq9vmP5_2gtunhxR=CYLovg@mail.gmail.com>
Subject: Re: [PATCH risu] use time() as random seed and introduce --randseed
 option
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000b0fad205fd78a0f6"
Received-SPF: none client-ip=2607:f8b0:4864:20::b29;
 envelope-from=jsun@junsun.net; helo=mail-yb1-xb29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000b0fad205fd78a0f6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It seems to me that we are OK with random as default behavior but we should
print out the seed (and abstract it into a shared function across arches).

Happy to re-work the patch if my understanding is correct.

Jun

On Thu, May 18, 2023 at 6:09=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:

>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Fri, 5 May 2023 at 01:23, Jun Sun <jsun@junsun.net> wrote:
> >>
> >> Agree on the usefulness of generating the same test. That is the
> >> reason behind adding --randseed option. Once a seed is set, it
> >> always generates the same sequence of instructions.
> >>
> >> Basically with this patch,
> >>
> >> by default you will generate random instruction sequences for most
> testing cases
> >> you can provide a random seed option in the commandline to generate a
> deterministic instruction sequence
> >>
> >> Without this patch,
> >>
> >> we always get one fixed sequence (ie. random seed =3D=3D 0 case)
> >> Otherwise we would have to manually modify code to generate random
> >> instruction sequences or generate a different fixed sequence.
> >>
> >> Hope this clarifies things a little bit.
> >
> > Mmm; it comes down to: should we default to 'time' and
> > require the user to specify --randseed 0 to get the old
> > behaviour; or do we retain the current behaviour as the
> > default and let the user pass an option if they want a
> > non-reproducibly random output.
> >
> > Alex, what do you reckon? You probably have been using
> > risugen more actively than me recently. I guess I vaguely
> > lean to "default to randomize(time)".
>
> I'm easy either way as long as we as long as we print out the seed so we
> can deterministically regenerate if we want to.
>
> >
> > Also, should we make risugen print the random seed to stdout
> > so you can repro it even if you didn't pass --randseed initially?
> >
> > Now that the random-seed-setting is 6 lines instead of 1,
> > this should definitely be abstracted out to a function
> > in the common code and not repeated in each per-arch file.
> >
> > thanks
> > -- PMM
>
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--000000000000b0fad205fd78a0f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">It seems=C2=A0to me that we are OK with random as default =
behavior but we should print out the seed (and abstract it into a shared fu=
nction across arches).<div><br></div><div>Happy to re-work the patch if my =
understanding is correct.</div><div><br></div><div>Jun</div></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 18,=
 2023 at 6:09=E2=80=AFAM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee=
@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><br>
Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"_bl=
ank">peter.maydell@linaro.org</a>&gt; writes:<br>
<br>
&gt; On Fri, 5 May 2023 at 01:23, Jun Sun &lt;<a href=3D"mailto:jsun@junsun=
.net" target=3D"_blank">jsun@junsun.net</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Agree on the usefulness of generating the same test. That is the<b=
r>
&gt;&gt; reason behind adding --randseed option. Once a seed is set, it<br>
&gt;&gt; always generates the same sequence of instructions.<br>
&gt;&gt;<br>
&gt;&gt; Basically with this patch,<br>
&gt;&gt;<br>
&gt;&gt; by default you will generate random instruction sequences for most=
 testing cases<br>
&gt;&gt; you can provide a random seed option in the commandline to generat=
e a deterministic instruction sequence<br>
&gt;&gt;<br>
&gt;&gt; Without this patch,<br>
&gt;&gt;<br>
&gt;&gt; we always get one fixed sequence (ie. random seed =3D=3D 0 case)<b=
r>
&gt;&gt; Otherwise we would have to manually modify code to generate random=
<br>
&gt;&gt; instruction sequences or generate a different fixed sequence.<br>
&gt;&gt;<br>
&gt;&gt; Hope this clarifies things a little bit.<br>
&gt;<br>
&gt; Mmm; it comes down to: should we default to &#39;time&#39; and<br>
&gt; require the user to specify --randseed 0 to get the old<br>
&gt; behaviour; or do we retain the current behaviour as the<br>
&gt; default and let the user pass an option if they want a<br>
&gt; non-reproducibly random output.<br>
&gt;<br>
&gt; Alex, what do you reckon? You probably have been using<br>
&gt; risugen more actively than me recently. I guess I vaguely<br>
&gt; lean to &quot;default to randomize(time)&quot;.<br>
<br>
I&#39;m easy either way as long as we as long as we print out the seed so w=
e<br>
can deterministically regenerate if we want to.<br>
<br>
&gt;<br>
&gt; Also, should we make risugen print the random seed to stdout<br>
&gt; so you can repro it even if you didn&#39;t pass --randseed initially?<=
br>
&gt;<br>
&gt; Now that the random-seed-setting is 6 lines instead of 1,<br>
&gt; this should definitely be abstracted out to a function<br>
&gt; in the common code and not repeated in each per-arch file.<br>
&gt;<br>
&gt; thanks<br>
&gt; -- PMM<br>
<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div>

--000000000000b0fad205fd78a0f6--

