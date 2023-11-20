Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C25727F1BAD
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 18:54:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r58TZ-0004TV-74; Mon, 20 Nov 2023 12:54:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r58TX-0004TE-Qq
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 12:54:23 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r58TV-0000Bp-SZ
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 12:54:23 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-507a62d4788so6580866e87.0
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 09:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700502859; x=1701107659; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eFbN8k47NjWd0k7i1IsxGVW2Va/kCQb/lJGRrI1QVjU=;
 b=tMOXf+49EhfOtiDnSEwFkO+3s+I48OcZyZEKvh5wSUFEwsosFicHK7nzLSLWO0RQvA
 r5bRDjd6sV5d8Hlbj02gN/UhreMqaQsVCFX91HsXe7sY0mAY8QYFNBsHbQTfFVmqaVpL
 uMMVq9MSOnByhtDzqmlFpGYNV9i+mXmBAZC5uRvxW7RdaFZVFdaxtiT+YmVqS0/8ehXG
 KNbyMNjOe597Rfq73kf+58cyR3MQSMaUUEXTQH7l4VvBnpPrQMOax058cNuKor/YP515
 oGmhaXuzPrutJh6doBe2yF7sveASzYHi7dgKecUrPI7YQ+lq1TMZ6QOOVzjHyotm7SVE
 I2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700502859; x=1701107659;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eFbN8k47NjWd0k7i1IsxGVW2Va/kCQb/lJGRrI1QVjU=;
 b=YaZ6EYfOTgo9cJvLtgbHjDjUdfrgHeO7UNnuBW+qtQmUt8H0rP0PZZlJnLnt2s6Ldn
 b2teYt8QWzYi1t3WyaB73fztUu9lqgHuBi69tKd1ddgKbGF4zrfmM1bIQ6198ev2crbX
 rEx/bPF/+S9+0xuoYFEWy2yr2Sy/tLl5wRohDT60mxfFNLn+0e7YxEAT0akmle9KsTYd
 2120GVkZbA8t9HFsoGaxCWBL8LKlZxShLU5LWmlLyVc+saHlCjL6vOGTBWB8EBGHL9cS
 2MJqVI/ikFdA2tXadQv5HQl5Ll5hHuDugIuCOPQUDRZz7DZ2PhSQDi+Usr2BsjS38nex
 nC1w==
X-Gm-Message-State: AOJu0Yxs3Jz7EwX/y7qulhoZKKZ/crXjPs8RaeJ5eBVMXH6luaNPfD5f
 SIiu0NZEANFwvcAkljm8aGwAQ/p3ozMR7nVISNfSxQ==
X-Google-Smtp-Source: AGHT+IGLBAtBifGXTuJ7eT3GbWNZPACQTdmciKbJQmLQIc5qKaOinPuXTEb2suCkW4h1Iawy7TrnolKqydN3SKp2gnY=
X-Received: by 2002:ac2:515b:0:b0:507:a33f:135d with SMTP id
 q27-20020ac2515b000000b00507a33f135dmr6022321lfd.4.1700502859320; Mon, 20 Nov
 2023 09:54:19 -0800 (PST)
MIME-Version: 1.0
References: <20231120173506.3729884-1-peter.maydell@linaro.org>
 <bd03b433-da83-4ea2-bba8-57a1eaaa5d79@linaro.org>
In-Reply-To: <bd03b433-da83-4ea2-bba8-57a1eaaa5d79@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2023 17:54:08 +0000
Message-ID: <CAFEAcA-kaKKrKLgSq_3wBpsjorUequ=ZMZ7hC58E0F6TK5vVaA@mail.gmail.com>
Subject: Re: [PATCH for-8.2] target/arm: Handle overflow in calculation of
 next timer tick
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Leonid Komarianskyi <leonid_komarianskyi@epam.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 20 Nov 2023 at 17:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/20/23 09:35, Peter Maydell wrote:
> > In commit edac4d8a168 back in 2015 when we added support for
> > the virtual timer offset CNTVOFF_EL2, we didn't correctly update
> > the timer-recalculation code that figures out when the timer
> > interrupt is next going to change state. We got it wrong in
> > two ways:
> >   * for the 0->1 transition, we didn't notice that gt->cval + offset
> >     can overflow a uint64_t
> >   * for the 1->0 transition, we didn't notice that the transition
> >     might now happen before the count rolls over, if offset > count
> >
> > In the former case, we end up trying to set the next interrupt
> > for a time in the past, which results in QEMU hanging as the
> > timer fires continuously.
> >
> > In the latter case, we would fail to update the interrupt
> > status when we are supposed to.
> >
> > Fix the calculations in both cases.
> >
> > The test case is Alex Benn=C3=A9e's from the bug report, and tests
> > the 0->1 transition overflow case.
> >
> > Fixes: edac4d8a168 ("target-arm: Add CNTVOFF_EL2")
> > Cc: qemu-stable@nongnu.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/60
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > Thanks to Leonid for his recent patch which prodded me
> > into looking at this again. I preferred to fix both halves
> > of the if(), rather than just one, and I have thrown in
> > Alex's test case since it was conveniently to hand.
> > ---
> >   target/arm/helper.c                       | 25 ++++++++++--
> >   tests/tcg/aarch64/system/vtimer.c         | 48 ++++++++++++++++++++++=
+
> >   tests/tcg/aarch64/Makefile.softmmu-target |  7 +++-
> >   3 files changed, 75 insertions(+), 5 deletions(-)
> >   create mode 100644 tests/tcg/aarch64/system/vtimer.c
> >
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index ff1970981ee..0430ae55edf 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -2646,11 +2646,28 @@ static void gt_recalc_timer(ARMCPU *cpu, int ti=
meridx)
> >           gt->ctl =3D deposit32(gt->ctl, 2, 1, istatus);
> >
> >           if (istatus) {
> > -            /* Next transition is when count rolls back over to zero *=
/
> > -            nexttick =3D UINT64_MAX;
> > +            /*
> > +             * Next transition is when (count - offset) rolls back ove=
r to 0.
> > +             * If offset > count then this is when count =3D=3D offset=
;
> > +             * if offset <=3D count then this is when count =3D=3D off=
set + UINT64_MAX
>
> Is it really UINT64_MAX or 2**64, i.e. UINT64_MAX + 1?

Yes, it should be the latter, though as you say it doesn't
affect the code.

thanks
-- PMM

