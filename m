Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAAE825468
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 14:24:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLkAd-0000ks-Gp; Fri, 05 Jan 2024 08:23:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rLkAY-0000kj-VI
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 08:23:26 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rLkAU-0002IW-1T
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 08:23:26 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6d9bd63ec7fso994030b3a.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 05:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1704461000; x=1705065800; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wU2iA9i0jjzT4gcfzBnVB6Q8+uGxSYSuFvoFdTGYM4Q=;
 b=GHHIWOxUjtT6NO//W5QdRQsFDSGi4uwWzEVoe0Or3Ud2mYOmGFBq7lrbluF34ujvWd
 hDx+qhPoNJrl4NKFzJpFLgCCdm1rkwEDOeiLwrz0JFY47Q9Ekh5WHcaMOVG+uZL+58TD
 I8gdB5oBXY+32hN2gIkr1FRUK4wdSq3l+g3hDJpM3H6ds/rgIP0gOJdaeRf3jhFTYpEh
 8YXSyfxBfJTn6+tb51SIuvMPUmEYpRzxb4JAhmaKqFpsx/PiFPEB2Rxfvcxin2K/oeA9
 teaBFL8sbJ3GUznn8aSfiXS5EdDU7ADqifrfD7j69rJmE3u8aPtJ+qqcn8/CllVAqz1R
 1BHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704461000; x=1705065800;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wU2iA9i0jjzT4gcfzBnVB6Q8+uGxSYSuFvoFdTGYM4Q=;
 b=VVbVwAnxazsNXd/N18FQWFga2QGncVFBO63ER3rhl4N3Xi153Du2YVRqDvWn2chWzl
 KX+gncWjePea4g7KyL1o8t6qMCmCSVOaHz/LHtdrYg0UzBZkWKoX/q4EhnpQssDBdOMt
 i1SSOhcTeSrb4SeznleK0RW+gFl36EH+50fJgLXFYZlVU2f99WqgyA+K8nFMfVT+7yRG
 Zg8257dl3Mkl0fzRoAXihZcs/lKcXpbUumv5JaC4wDnowrtyWjRQBrxUFoP3bTLYHRuT
 ubLOgPep8vp65bMN2wA87SkgBfHkHih3cHaKnRftdDrWHQhBQezfvR+aDyDl9HPBlHuQ
 0Suw==
X-Gm-Message-State: AOJu0Yz+DoEKxcVynJ8kFcF65mK1Xl0/W/ZZpPKMq96jsLBpBYpYuYqV
 zQfxXTRFXAVghdNxGJZTQvrbhEq0uPd1WRzCiMIUsQmktQkP
X-Google-Smtp-Source: AGHT+IFTccjSCWTZEfwqT1qMvRdxZbR5ELloEds1HldrSFL3ShZkj8M6eWPoAT3fAhg5drWPYNBc+jCSFkKcbVTr634=
X-Received: by 2002:a05:6a20:4287:b0:199:3acc:3e00 with SMTP id
 o7-20020a056a20428700b001993acc3e00mr680893pzj.14.1704461000367; Fri, 05 Jan
 2024 05:23:20 -0800 (PST)
MIME-Version: 1.0
References: <20240105102421.163554-1-chigot@adacore.com>
 <20240105102421.163554-4-chigot@adacore.com>
 <702936da-4931-40b7-8f82-b256cdf8d9f1@linaro.org>
In-Reply-To: <702936da-4931-40b7-8f82-b256cdf8d9f1@linaro.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Fri, 5 Jan 2024 14:23:09 +0100
Message-ID: <CAJ307EiJ1SEdnnqEFFL-=YeO3XNtAJLLctixvxxFasQBhu0eFQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] intc/grlib_irqmp: implements the multiprocessor
 status register
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Frederic Konrad <konrad.frederic@yahoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=chigot@adacore.com; helo=mail-pf1-x433.google.com
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

On Fri, Jan 5, 2024 at 12:32=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Cl=C3=A9ment,
>
> On 5/1/24 11:24, Cl=C3=A9ment Chigot wrote:
> > This implements the multiprocessor status register in grlib-irqmp and b=
ind
> > it to a start signal, which will be later wired in leon3-generic to
> > start a cpu.
> >
> > Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
> > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> > ---
> >   hw/intc/grlib_irqmp.c | 22 +++++++++++++++++++---
> >   1 file changed, 19 insertions(+), 3 deletions(-)
>
>
> > @@ -323,6 +334,8 @@ static void grlib_irqmp_reset(DeviceState *d)
> >
> >       memset(irqmp->state, 0, sizeof *irqmp->state);
> >       irqmp->state->parent =3D irqmp;
> > +    irqmp->state->mpstatus =3D ((irqmp->ncpus - 1) << 28)
>
> Can you #define this magic '28' number?
>
> > +        | ((1 << irqmp->ncpus) - 2);
> >   }
> >
> >   static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
> > @@ -336,6 +349,9 @@ static void grlib_irqmp_realize(DeviceState *dev, E=
rror **errp)
> >       }
> >
> >       qdev_init_gpio_in(dev, grlib_irqmp_set_irq, MAX_PILS);
> > +    /* Transitionning from 0 to 1 starts the CPUs.  */
>
> What about 1 -> 0?

It does nothing. I have updated the comment to mention it.
For the doc (also mention it in the commit message now).
  | [15:1] Power-down status of CPU [n]: reads =E2=80=981=E2=80=99 =3D powe=
r-down, =E2=80=980=E2=80=99 =3D running.
  | Write to start processor n: =E2=80=981=E2=80=99=3Dto start =E2=80=980'=
=3Dhas no effect.


> > +    qdev_init_gpio_out_named(dev, irqmp->start_signal, "grlib-start-cp=
u",
> > +                             IRQMP_MAX_CPU);
> >       qdev_init_gpio_out_named(dev, &irqmp->irq, "grlib-irq", 1);
> >       memory_region_init_io(&irqmp->iomem, OBJECT(dev), &grlib_irqmp_op=
s, irqmp,
> >                             "irqmp", IRQMP_REG_SIZE);
>

