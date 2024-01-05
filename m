Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDF9825506
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 15:16:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLkyz-0006XE-3j; Fri, 05 Jan 2024 09:15:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rLkyx-0006X2-K9
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 09:15:31 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rLkyv-0001l6-IM
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 09:15:31 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-28bd85bda06so1057664a91.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 06:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1704464128; x=1705068928; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zajdsmJirqsO3ZnoyVwOUJGmlB77C+64f78IABkAuHY=;
 b=ayd9mwCp938Mck6Ip6zfvfD1Q7cpboSwezAaZnTcVZLQ88De/vw0msjwlbvj0v2pkt
 qZldgf6bggs+nSoNQ5HszvnAsNQ6ZZWi1qOLzxavY5sdpK2MIW8j5hbddspCH567zGjI
 CR9Pc+KFOnAm5yZyDPJvM1PlCu28mNkgayY6SOXABbF6Fdcj6tnGXezXPlvGICM+HEe7
 pJajAiFoGqs3QU0EQrTHBrUys3MPM+NWisBsbC3/eNGGKFPQsr5mPOht3+sDK6q43Wiz
 eD1ve/BXCLvjg06udPtjNoOuBmkInv82gAPM/n+766lbCca3BeRRWOtX8BEIhLvL7Jr5
 LGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704464128; x=1705068928;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zajdsmJirqsO3ZnoyVwOUJGmlB77C+64f78IABkAuHY=;
 b=c70jFfQsUXG569e45T6g8JBJuJ5dryRxfqmPoc3SLC/3Q8zrrZdzKd2o9/9uLymkb8
 JPN6Wo5F4TQNPiq3AQJrdOiSNleltFbsm+mjI8AcqFhT+Q5b4aj6TiROgpqGuGIQM4Tk
 R4N0R1DTa8f5SZ/rCK8AXVpiK3uY3GA/OYQ1QCsaqGdfv5WwIyKNDoernq1tI3QLG0I7
 Dnty2OZDE92nUNObH+PrWnG1yORgWfeGaKeSg5KaNha/g+cfemAk9pQ91M3rC6tEUfUt
 PN8TVUAZuqGM14e9HV9f71/jWZPJOp4uY5ukQ0e09a7oCSP+lFOtQYt4trwuRRWVOs4b
 M29Q==
X-Gm-Message-State: AOJu0YxnvJz3Z64TfxTnjmTkpLIGukxmTNVWuyzggEC4msdYWrjXuNJy
 3oUVeT1VwYFoSDTiFoVmpPlOEEHqUvIIcYqvOS46eAfKtB7zTNSSkRv2oaQ=
X-Google-Smtp-Source: AGHT+IGDtMR1guA+GPPGEaB1/gONC3WA1dc2F4Hv9hnCBUo48mpyU9dqxVsExQmEsRnW4Xld7URdVPxTA6T9g2mOLZM=
X-Received: by 2002:a17:90a:d814:b0:28b:d919:f577 with SMTP id
 a20-20020a17090ad81400b0028bd919f577mr1804975pjv.47.1704464128111; Fri, 05
 Jan 2024 06:15:28 -0800 (PST)
MIME-Version: 1.0
References: <20240105102421.163554-1-chigot@adacore.com>
 <20240105102421.163554-4-chigot@adacore.com>
 <702936da-4931-40b7-8f82-b256cdf8d9f1@linaro.org>
 <CAJ307EiJ1SEdnnqEFFL-=YeO3XNtAJLLctixvxxFasQBhu0eFQ@mail.gmail.com>
 <a103ed7a-aeeb-4d51-b0e7-996897e30658@linaro.org>
In-Reply-To: <a103ed7a-aeeb-4d51-b0e7-996897e30658@linaro.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Fri, 5 Jan 2024 15:15:17 +0100
Message-ID: <CAJ307EhF9oiL1v30nWAy9ftqOKreqieVUX+VUWHV4Zcbefe6Vg@mail.gmail.com>
Subject: Re: [PATCH 3/9] intc/grlib_irqmp: implements the multiprocessor
 status register
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Frederic Konrad <konrad.frederic@yahoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=chigot@adacore.com; helo=mail-pj1-x102a.google.com
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

On Fri, Jan 5, 2024 at 2:37=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> On 5/1/24 14:23, Cl=C3=A9ment Chigot wrote:
> > On Fri, Jan 5, 2024 at 12:32=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> > <philmd@linaro.org> wrote:
> >>
> >> Hi Cl=C3=A9ment,
> >>
> >> On 5/1/24 11:24, Cl=C3=A9ment Chigot wrote:
> >>> This implements the multiprocessor status register in grlib-irqmp and=
 bind
> >>> it to a start signal, which will be later wired in leon3-generic to
> >>> start a cpu.
> >>>
> >>> Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
> >>> Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> >>> ---
> >>>    hw/intc/grlib_irqmp.c | 22 +++++++++++++++++++---
> >>>    1 file changed, 19 insertions(+), 3 deletions(-)
> >>
> >>
> >>> @@ -323,6 +334,8 @@ static void grlib_irqmp_reset(DeviceState *d)
> >>>
> >>>        memset(irqmp->state, 0, sizeof *irqmp->state);
> >>>        irqmp->state->parent =3D irqmp;
> >>> +    irqmp->state->mpstatus =3D ((irqmp->ncpus - 1) << 28)
> >>
> >> Can you #define this magic '28' number?
> >>
> >>> +        | ((1 << irqmp->ncpus) - 2);
> >>>    }
> >>>
> >>>    static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
> >>> @@ -336,6 +349,9 @@ static void grlib_irqmp_realize(DeviceState *dev,=
 Error **errp)
> >>>        }
> >>>
> >>>        qdev_init_gpio_in(dev, grlib_irqmp_set_irq, MAX_PILS);
> >>> +    /* Transitionning from 0 to 1 starts the CPUs.  */
> >>
> >> What about 1 -> 0?
> >
> > It does nothing. I have updated the comment to mention it.
> > For the doc (also mention it in the commit message now).
> >    | [15:1] Power-down status of CPU [n]: reads =E2=80=981=E2=80=99 =3D=
 power-down, =E2=80=980=E2=80=99 =3D running.
> >    | Write to start processor n: =E2=80=981=E2=80=99=3Dto start =E2=80=
=980'=3Dhas no effect.
>
> Then grlib_irqmp_write() could be simplified as:
>
>       case MP_STATUS_OFFSET:
> -        /* Read Only (no SMP support) */
> +        state->mpstatus =3D deposit32(state->mpstatus,
> +                                    value, 0, IRQMP_MAX_CPU);
> +        for (unsigned i =3D 0; i < irqmp->ncpus; i++) {
> +            qemu_set_irq(irqmp->start_signal[i],
> +                         extract32(value, i, 1));
> +        }
>           return;

No, because the logic between write and read is reversed.
Writing "1" starts the CPU but reading 1 means that the CPU is not
started. Therefore, when writing 1, we must trigger the start signal
and then write 0 in mpstatus.

