Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCA97DA5F4
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 10:49:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwez5-0007gv-BQ; Sat, 28 Oct 2023 04:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amit251098@gmail.com>)
 id 1qwez3-0007gX-57
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 04:47:53 -0400
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amit251098@gmail.com>)
 id 1qwez1-0002uB-I4
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 04:47:52 -0400
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6707401e1edso4184006d6.1
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 01:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698482870; x=1699087670; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pAGN2sCf12/YFu2zghEX7UTwLeRrSCD0PE4vkkkfCwE=;
 b=nCiBVmhnfLTnRTjb+vvo1Nt/+AnBBpCmRsGMP8JBdplBT2B/GT3Tfjn8Vs5amBtDgn
 zel3ipSZ3G9+Oh6SpPG6KULw4N1bPp9miUwfR5q5X71s9DfGP2p74d+o6c0fDnCKrdiI
 45AeC4zhfhYsT7lvy+/DnnnhrUGJLf7jUtOWFH8Bz6v6TF8EHY4Ozjm68/SvLjrIoNIQ
 N34yinqsDU9itFxLgfJaNpdGeHseuw+dJAZJxYq1iuBizgpIqYbdkG17Uxv95KfN3uYc
 /RqBouBSvQ/pUy4qNd5OlIOY09UX3KOKGN98wS2EKLAiZdjbPg4fwHuAehdfSg3+zklL
 Yqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698482870; x=1699087670;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pAGN2sCf12/YFu2zghEX7UTwLeRrSCD0PE4vkkkfCwE=;
 b=tyfKlbRAaEXVirfiMNoU/rBrRfCD4Qt2ib4J2ymQKmZCqMZ0/3JIRfvgR7WrnyjULY
 tHUkYB+Q2u5GbYTiaK3zxJqyfO0f0M+SBDN4L1yvfDQrQDWm6fZnCEX6QrCTlZpj5v8L
 +WNLCgdmBhgEgLwpg1JlmnqNDchwvtspAZOXZFrruj92V6kZRDqfxuBMC3Cm3N4V98v7
 3Y6bRhkmSYyZxA6DqHwTiW1LURkOX6/dJaRn53syHPbCL1bmK9z7KjIn1rrLXo76A582
 rl3Aepb5TxWk8fMB4yDm0k+cQR35VsAztNOuT/npAzUSP+vtcFk3kBQsHiVLl73PJE12
 9Brg==
X-Gm-Message-State: AOJu0YzylVv/3bzG9XjTAXXOhZdWA97QYnNvB6vaaVXWhGzzWSGbk4UV
 HV8iZRNbFkUBNXrgBfilZYK9kDHCDar7wibN4Paa96No
X-Google-Smtp-Source: AGHT+IFBwoxCM7pDwDsgLtd8WKYVZEL5Janr9+/BTk5SG1NdJ4cWy9rEfNqTMbSoaCEqxjvbf9GqqpKTkSqTs7Zu0No=
X-Received: by 2002:a0c:f446:0:b0:66d:2b0a:bf0f with SMTP id
 h6-20020a0cf446000000b0066d2b0abf0fmr4105891qvm.46.1698482870049; Sat, 28 Oct
 2023 01:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhcV8-HHG36Ndv7Y-K5FrUTb-WwVoRW3PPzaiM4hEesGA-iWw@mail.gmail.com>
 <CAHhcV89tKJiFz6CW5Xm6XP5pDs1uLBew=kjC5qd-k+fNVmdt1g@mail.gmail.com>
 <875y35b1xb.fsf@linaro.org>
In-Reply-To: <875y35b1xb.fsf@linaro.org>
From: Amit Kumar <amit251098@gmail.com>
Date: Sat, 28 Oct 2023 14:17:39 +0530
Message-ID: <CAHhcV8-DFn7zS1pZkKCSmjFzybkqkagmhzZtEoYfW7UMnijgMA@mail.gmail.com>
Subject: Re: [Beginner-Help] Help understanding the migration Code
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000002062490608c2dcd2"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=amit251098@gmail.com; helo=mail-qv1-xf2c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--0000000000002062490608c2dcd2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex
This was a great help, I found out VMStateDescription is defined in
vmstate.h file and furthermore I was able to trace files using this struct.
I am specifically looking to find the pre-copy algorithm for live
migration.
I found the following files which "may" contain it
- migration.c
- migration/ram.c
- migration/qemu-file-channel.c
- migration/colo.c
- migration/savevm.c

Can you point me in the right direction? Where exactly should I look for?
Function names would be very helpful.

Thanks


On Tue, Oct 17, 2023 at 10:51=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lina=
ro.org> wrote:

>
> Amit Kumar <amit251098@gmail.com> writes:
>
> > Following up on the previous email I sent. I want to understand the
> migration code, I have read a couple of papers on
> > how it works in theory, but I am finding it hard to find a starting
> > point where I can start to understand the code.
>
> Start looking at the VMStateDescription and what follows from there.
> This is the principle source of serialisation information when saving
> and restoring device state.
>
> The VMSTATE_* macros wrap up a lot of the structures.
>
> >
> > Any help would be appreciated.
> >
> > Thank you
> >
> > On Wed, Oct 11, 2023 at 9:40=E2=80=AFAM Amit Kumar <amit251098@gmail.co=
m> wrote:
> >
> >  Hi
> >  I am trying to understand how migration, more specifically
> live-migration works in QEMU. I've tried going
> >  through the source code but didn't understand much, and couldn't find
> documentation either. I want to work on
> >  live migration and need help getting to know the code.
> >  More specifically I want to understand
> >  - where the pre/post copy algorithms are implemented
> >  - which files/data-structures that I should look at
> >  - should I need to make changes, where and how should I start?
> >
> >  I am new to working with such large code bases, hence need some
> guidance.
> >
> >  Thanks
> >
> >  Amit Kumar
>
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--0000000000002062490608c2dcd2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Alex</div><div>This was a great help, I found out =
VMStateDescription is defined in vmstate.h file and furthermore I was able =
to trace files using this struct. <br></div><div>I am specifically looking =
to find the pre-copy algorithm for live migration. <br></div><div>I found t=
he following files which &quot;may&quot; contain it</div><div>- migration.c=
</div><div>- migration/ram.c</div><div>- migration/qemu-file-channel.c</div=
><div>- migration/colo.c</div><div>- migration/savevm.c</div><div><br></div=
><div>Can you point me in the right direction? Where exactly should I look =
for? Function names would be very helpful.</div><div><br></div><div>Thanks<=
/div><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gma=
il_attr">On Tue, Oct 17, 2023 at 10:51=E2=80=AFPM Alex Benn=C3=A9e &lt;<a h=
ref=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
Amit Kumar &lt;<a href=3D"mailto:amit251098@gmail.com" target=3D"_blank">am=
it251098@gmail.com</a>&gt; writes:<br>
<br>
&gt; Following up on the previous email I sent. I want to understand the mi=
gration code, I have read a couple of papers on<br>
&gt; how it works in theory, but I am finding it hard to find a starting<br=
>
&gt; point where I can start to understand the code.<br>
<br>
Start looking at the VMStateDescription and what follows from there.<br>
This is the principle source of serialisation information when saving<br>
and restoring device state.<br>
<br>
The VMSTATE_* macros wrap up a lot of the structures.<br>
<br>
&gt;<br>
&gt; Any help would be appreciated.<br>
&gt;<br>
&gt; Thank you<br>
&gt;<br>
&gt; On Wed, Oct 11, 2023 at 9:40=E2=80=AFAM Amit Kumar &lt;<a href=3D"mail=
to:amit251098@gmail.com" target=3D"_blank">amit251098@gmail.com</a>&gt; wro=
te:<br>
&gt;<br>
&gt;=C2=A0 Hi<br>
&gt;=C2=A0 I am trying to understand how migration, more specifically live-=
migration works in QEMU. I&#39;ve tried going<br>
&gt;=C2=A0 through the source code but didn&#39;t understand much, and coul=
dn&#39;t find documentation either. I want to work on<br>
&gt;=C2=A0 live migration and need help getting to know the code. <br>
&gt;=C2=A0 More specifically I want to understand<br>
&gt;=C2=A0 - where the pre/post copy algorithms are implemented<br>
&gt;=C2=A0 - which files/data-structures that I should look at<br>
&gt;=C2=A0 - should I need to make changes, where and how should I start?<b=
r>
&gt;<br>
&gt;=C2=A0 I am new to working with such large code bases, hence need some =
guidance.<br>
&gt;<br>
&gt;=C2=A0 Thanks<br>
&gt;<br>
&gt;=C2=A0 Amit Kumar<br>
<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div>

--0000000000002062490608c2dcd2--

