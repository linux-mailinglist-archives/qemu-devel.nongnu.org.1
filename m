Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8B6722372
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 12:29:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q67SG-0007IF-Vm; Mon, 05 Jun 2023 06:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q67SB-0007Bi-Si
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:28:48 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q67SA-0004xc-22
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:28:47 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5148e4a2f17so7155989a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 03:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685960924; x=1688552924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YXHrsYssW93rRIURMtpOIJ8nIm1VFFWJWuyqxP/l/1c=;
 b=BZpwG0w4tUNncxn2YmPjFAeMAFOiKoKV79cpWApTO8zBiuuKnvMUbnKeOVNMDZ70Gs
 LbAbo9oWdMFFyeUyJEf5OhkgMTWQObUFJaPPZjaBfd3grVUZf/tLe73bgtbVuhaH/DAF
 ghfoJXXv2/9kQyjISwdNKwW9BdZSrRda5r4dhxCT1HL0uA84sEJs3iL+jfQeue4QujhL
 reOk2kw5pXedV9RW24DtBklmMPUtzYgN7HbJs7HHRVaMmWpYjAWj2KZlVnqd1a9YcfWW
 u+VHeJcBWjUUXLwyFeB3SRlyvgwsI/nm6iZVgMRECCaweJJokaLhBwe64lz3h+BH4FL0
 ehWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685960924; x=1688552924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YXHrsYssW93rRIURMtpOIJ8nIm1VFFWJWuyqxP/l/1c=;
 b=fyGLcfRriy8TlORDBnyyC9b/A1weMFEMQ2FzV04Xx/ht8kNohsgpiIDO2X742iNEsh
 NJFm27qdj8t2gFbJiW/DdxfKxe8bAe7pewtcKDA5rETS8xb+bgW2t7QhOxdqameg0kRl
 f6Z84Lnr9tK/JenhTBj8NLC9CbjznFKlmRRX1ZXkgTNKcFXrATV/+qrTqyW1ro83MWKw
 acJiMoggp0fPeSvJbUvi3Dgizx9mCTZwHFAOGKgcvQL7KbFoJqim8L7Yanp2yy4iJXGk
 6gmC1kTEu/a6Kxg5nUbLLmjFgwBs0O8TO+EcUJRHvpNr36rwyPTz7EKA/A2a2IsYCIq5
 80mg==
X-Gm-Message-State: AC+VfDzl6/z6HQxQikSUmD6vHo6yhKvYn4LL7pVJ/qvJlUZBgeA57X1m
 aObY3iPj11N9XAePYuFy7Y3g35XaIDZ6D2KNtp+CoA==
X-Google-Smtp-Source: ACHHUZ4xOWEtfj+H3dElmxkarcS632DwwNirY470d4S5wcnCmysaXTnI2UBMRzdoGSUKasXLZflB99zIklvpDVr00gM=
X-Received: by 2002:aa7:c997:0:b0:50b:c630:a956 with SMTP id
 c23-20020aa7c997000000b0050bc630a956mr7113515edt.17.1685960924494; Mon, 05
 Jun 2023 03:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230531203559.29140-1-philmd@linaro.org>
 <20230531203559.29140-16-philmd@linaro.org>
 <43f014f5-6dd7-7c46-eea4-ed9cffe8ec48@ilande.co.uk>
 <33d6d99f-5a75-9891-b43f-c9caf40a62de@linaro.org>
In-Reply-To: <33d6d99f-5a75-9891-b43f-c9caf40a62de@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Jun 2023 11:28:11 +0100
Message-ID: <CAFEAcA_xQ3LseLrSTNQCj5VUNh1jiPdbpPWMLT=yp=VBKL2gAg@mail.gmail.com>
Subject: Re: [PATCH 15/15] hw/timer/arm_timer: QOM'ify ARM_TIMER
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, 
 Sergey Kambalin <serg.oker@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 5 Jun 2023 at 11:20, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> On 3/6/23 20:07, Mark Cave-Ayland wrote:
> > On 31/05/2023 21:35, Philippe Mathieu-Daud=C3=A9 wrote:
> >
> >> Introduce the ARM_TIMER sysbus device.
> >>
> >> arm_timer_new() is converted as QOM instance init()/finalize()
> >> handlers. Note in arm_timer_finalize() we release a ptimer handle
> >> which was previously leaked.
> >>
> >> ArmTimerState is directly embedded into SP804State/IcpPitState,
> >> and is initialized as a QOM child.
> >>
> >> Since the timer frequency belongs to ARM_TIMER, have it hold the
> >> QOM property. SP804State/IcpPitState directly access it.
> >>
> >> Similarly the SP804State/IcpPitState input IRQ becomes the
> >> ARM_TIMER sysbus output IRQ.
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >> ---
> >>   hw/timer/arm_timer.c | 109 +++++++++++++++++++++++++++--------------=
--
> >>   1 file changed, 70 insertions(+), 39 deletions(-)
>
>
> >> -static void arm_timer_reset(ArmTimerState *s)
> >> +static void arm_timer_reset(DeviceState *dev)
> >>   {
> >> +    ArmTimerState *s =3D ARM_TIMER(dev);
> >> +
> >>       s->control =3D TIMER_CTRL_IE;
> >>   }
> >
> > If you're currently set up to test the ARM timers with these changes, i=
s
> > it worth considering converting this to use the Resettable interface at
> > the same time?
>
> Good point. Then ARM_TIMER doesn't need to inherit from SysBus: if the
> parent device resets it explicitly, it can be a plan QDev.
>
> Peter, what do you think?

I'm not a super-fan of either plain qdevs or devices explicitly
resetting other devices. What we have today isn't great
(reset along the sysbus tree) but I feel like ad-hoc deviations
from it don't help and arguably hinder in any future attempts
to attack the problem more systematically.

> Even generically, I wonder if a QDev could resets all its QOM children,
> propagating each ResetType.

Propagating reset along the QOM tree is something I've thought
about, yes. The other option is to have a 'reset tree' (distinct
from both the QOM tree and the 'bus tree', but perhaps defaulting
to the QOM tree if not explicitly set otherwise). As usual, the
difficulty is the transition from the current setup to any
proposed new reset handling model. I haven't really had time
to think about this recently.

-- PMM

