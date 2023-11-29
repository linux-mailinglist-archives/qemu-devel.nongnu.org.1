Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E9C7FDBE0
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 16:47:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8MlZ-0004gN-Ba; Wed, 29 Nov 2023 10:46:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1r8Mkk-0004W2-6u
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 10:45:32 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1r8Mkg-0000YN-47
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 10:45:29 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-54b8a4d64b5so4097987a12.0
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 07:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1701272722; x=1701877522;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/urIYvISorp11S22g91YjdaocJ3v4MjeDZDmhdTf1Zg=;
 b=xm2mzSFaV5SfeAO1XCeKtjIIzqxquz5Rus7wm4P5K8MZb2567a8wsGW6TRKl/0Wdl/
 ax75oK6RXz9t73r2pyQS0b4Q+wC+1nu3GLaBzAMacE+uZ1ESl5/mQjQpC9XvgF0YTI+i
 jPC9Z+rxkcSRV50qV4nZWrW7LA/rYJ9QfSIEjxMMRwWkO0UpquSQ9DlU8A5oQdR2rlWc
 /ssuIz2H5j1J1sYtx0LfNdoileyV5IHVQj8aNANJxN5lYafvGlOmCRmcmLpilKmnF39s
 +Cucc6seFGZgusKCebwisnvICHMgt5SvA5t8abW94nJ4kjIQOM0PIb/VTasQNcf43PZl
 jOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701272722; x=1701877522;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/urIYvISorp11S22g91YjdaocJ3v4MjeDZDmhdTf1Zg=;
 b=BdFUNNp5GmxKGsXxvpnsFLizavYjfAcpgb/zuWvPCQHWpezH3xO6eaFzNRiPt6NuAi
 ozkM+q18IymhNtWIKPPdKLrqtWZdBLjplicCrxq67gk30eOXQibuYeXyWAiQnBDc2LTm
 v6YrKAMs7bJjMyhG8DlE+LIr653/pId63W6qe3prwyulfgCUrh2O28tDR3PxUg+TMeXc
 7yGqSpZK+WCYJ0+uN6Za1J+3sA0pJBHXUpUGBFPRxcBB1V+xydqPH8f1HW9em2z8jtWA
 mzSxJEtL3jIKvA4wgBviQ66S1Ys2uGAvVEPf2bs8evarckbB4nM87tRyk+dJE3+iSOmg
 Ue8w==
X-Gm-Message-State: AOJu0YyEKVqDcpHO9aA5qw0hrSOzmaSvNzWc3bqSHmzKbnBqLZEGq5p1
 dV3BPCS1tksnw1JoAec2H+7EoMHotnCEy7gUmT8L5w==
X-Google-Smtp-Source: AGHT+IGovQd4XC0RYf90+VbwiQSQCJZtBdwbEP4bnaGZiYFwyAECXizBC0AwGHaBNKuW0Gm1TFCTy9Ec1NYiUt2VVik=
X-Received: by 2002:a17:906:195b:b0:9fe:6349:d8ba with SMTP id
 b27-20020a170906195b00b009fe6349d8bamr13529625eje.27.1701272721796; Wed, 29
 Nov 2023 07:45:21 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA_rziBuSwgJ9cg9m1PS5pNG58eyim+_P9hMu5nF7G70XA@mail.gmail.com>
 <87edgjf2v4.fsf@draig.linaro.org>
 <ef77ed27-8b95-480e-97da-8e0c53bf3aa1@redhat.com>
 <ZWYsMsgxjDZ_T2zA@redhat.com>
 <68337349-a8c7-4520-a381-a359bf8f8438@linaro.org>
In-Reply-To: <68337349-a8c7-4520-a381-a359bf8f8438@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 29 Nov 2023 08:45:15 -0700
Message-ID: <CANCZdfqMyemEMXs0xtHbZ+_Ebk2UGc++gPbO4e8svTaYTCEGpQ@mail.gmail.com>
Subject: Re: QEMU Summit Minutes 2023
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000003fc6a8060b4c6cbb"
Received-SPF: none client-ip=2a00:1450:4864:20::52e;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x52e.google.com
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

--0000000000003fc6a8060b4c6cbb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 8:33=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> On 28/11/23 19:06, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Nov 28, 2023 at 06:54:42PM +0100, C=C3=A9dric Le Goater wrote:
>
> > Anyway, when a maintainer wants to merge a tree, I would expect to
> > have a MR opened against 'master' in qemu-project/qemu.  The CI
> > ought to then run and if it is all green, then someone would approve
> > it to merge to master.
> >
> >> It seems to me that we should also have a group of people approving
> >> the MR.
> >
> > Yes, while we could have one designated gate keeper approving all
> > MRs, that would defeat some of the benefit of MRs. So likely would
> > be good to have a pool, and also setup the config so that the owner
> > of an MR is not allow to approve their own MR, to guarantee there
> > is always a 2nd pair of eyes as sanity check.
>
> Are all our tests already on GitLab? Last time I remember Peter still
> had manual tests.
>

As a low-volume maintainer, I'd love nothing more than to push my PR
asynchronously to the release cycle. I'll get immediate yes/no feedback and
have a chance to fix the 'no' from the CI and/or reviewers. I'd know early
in the review when CI tests break that I can deal with in parallel. All as
part of the normal process. Now I have to publish in email, and push to
gitlab and it's very manual, not integrated and a large source of friction
for me as someone who does things from time to time rather than all the
time (since it's the most radically different set or processes from
anything else I contribute to). This way, I don't have to care about
freezes or whatever. During the non-freeze times it goes in once whatever
criteria are ticked (reviewers and no objections, my say so, CI working,
etc) During the freeze times the release engineer ticks another box for it
to go in... or not... and after the freeze, we'll have a battle royale of
accumulated MRs that will go in, though not all queued once since we'll
have to re-run the CI with the new changes.

And maybe we could consider just branching for release. Freeze master for
as long as it takes to branch (which needn't be tip) and then master goes
on with life and the release engineer lands bug fixes to the release branch
like we do now in frozen master. That way we don't get the big in-rush
effects when the freeze lifts. FreeBSD went to this a decade ago and makes
releases so much easier.

Warner

--0000000000003fc6a8060b4c6cbb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 29, 2023 at 8:33=E2=80=AF=
AM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">phi=
lmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On 28/11/23 19:06, Daniel P. Berrang=C3=A9 wrote:<br>
&gt; On Tue, Nov 28, 2023 at 06:54:42PM +0100, C=C3=A9dric Le Goater wrote:=
<br>
<br>
&gt; Anyway, when a maintainer wants to merge a tree, I would expect to<br>
&gt; have a MR opened against &#39;master&#39; in qemu-project/qemu.=C2=A0 =
The CI<br>
&gt; ought to then run and if it is all green, then someone would approve<b=
r>
&gt; it to merge to master.<br>
&gt; <br>
&gt;&gt; It seems to me that we should also have a group of people approvin=
g<br>
&gt;&gt; the MR.<br>
&gt; <br>
&gt; Yes, while we could have one designated gate keeper approving all<br>
&gt; MRs, that would defeat some of the benefit of MRs. So likely would<br>
&gt; be good to have a pool, and also setup the config so that the owner<br=
>
&gt; of an MR is not allow to approve their own MR, to guarantee there<br>
&gt; is always a 2nd pair of eyes as sanity check.<br>
<br>
Are all our tests already on GitLab? Last time I remember Peter still<br>
had manual tests.<br></blockquote><div><br></div><div>As a low-volume maint=
ainer, I&#39;d love nothing more than to push my PR asynchronously to the r=
elease cycle. I&#39;ll get immediate yes/no feedback and have a chance to f=
ix the &#39;no&#39; from the CI and/or reviewers. I&#39;d know early in the=
 review when CI tests break that I can deal with in parallel. All as part o=
f the normal process. Now I have to publish in email, and push to gitlab an=
d it&#39;s very manual, not integrated and a large source of friction for m=
e as someone who does things from time to time rather than all the time (si=
nce it&#39;s the most radically different set or processes from anything el=
se I contribute to). This way, I don&#39;t have to care about freezes or wh=
atever. During the non-freeze times it goes in once whatever criteria are t=
icked (reviewers and no objections, my say so, CI working, etc) During the =
freeze times the release engineer ticks another box for it to go in... or n=
ot... and after the freeze, we&#39;ll have a battle royale of accumulated M=
Rs that will go in, though not all queued once since we&#39;ll have to re-r=
un the CI with the new changes.</div><div><br></div><div>And maybe we could=
 consider just branching for release. Freeze master for as long as it takes=
 to branch (which needn&#39;t be tip) and then master goes on with life and=
 the release engineer lands bug fixes to the release branch like we do now =
in frozen master. That way we don&#39;t get the big in-rush effects when th=
e freeze lifts. FreeBSD went to this a decade ago and makes releases so muc=
h easier.</div><div><br></div><div>Warner<br></div></div></div>

--0000000000003fc6a8060b4c6cbb--

