Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4CD811AD1
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 18:21:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDSuu-00067V-SR; Wed, 13 Dec 2023 12:21:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rDSut-00066w-51
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:21:03 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rDSur-0000xi-Ej
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:21:02 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-551e6b99490so1658339a12.0
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 09:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702488060; x=1703092860; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M0atWKa26FsGgBVT+MCafJYHimET8lqY3IETPDTAc6Q=;
 b=vq1ePlrztahqViucHBg/bVirT931k9zBiGcMs8QqnZkCJ3pUXRppiCSMJleMRvlOPV
 e0lJ3kIX8aTYVAmkW726sz3nN1/xEgFlpv/r30B3CvAeWScjViJlXQ+zwgjy2x5kvSLf
 nNbYkZxwaym/gu9p5EaKaHe8nCBiw591w9DDTgIufzUbUxmasWN1G485lTmh5Cn9ldCx
 y1JdzxqpqIOegMNokBQ1GNXHYCXq2ROvMUpsiMbKicH5wkgbno1JyI26mzE3RvWIWjVF
 MAKTcQ4HH++oIPqtRoWU2/kR28nc5nAP7HmzeMHYppGY2W9VwSoS1JgpKTIgIJfmCbOc
 rN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702488060; x=1703092860;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M0atWKa26FsGgBVT+MCafJYHimET8lqY3IETPDTAc6Q=;
 b=uTDg7ICrCfEs6N3gKttlLxVIVas3hAx08IgwiIW6WsCbZmvtX9rC0zwUkDR1Ya/SwA
 mvbjBMpmqWBS2ow6l9LuJuFAS1uEzaB2toqhhIjvvQK8lv2RMHT7L3BddQtNwZLHBd2l
 XsKYws+aL9g4YvSFR9vsTy5llMGcCMeFTXZmSpFdTDn5KoJPsZqAu+BIJOMb7kjDI5Sa
 isIDQB4+I1U9/jG03j/8BACYjsHu7vjSqKYRGddqVBfZZQSac31R6IJeJT9KSbgK3WBE
 QlOUToJ4U0NY2+W+7OfbawXS9wlyQCBt9arRNqhQ79MUfzLsSWSXzpXvFBHlySYpR1N6
 m9BQ==
X-Gm-Message-State: AOJu0YyItyQYAz8YW7ww3uO46CKRkkarvQBuAVkssMNlnTVUc4rAXqLH
 P+UcH2NYjS0E4JCgbuloWFKzMoU01aIca+H7tevhcQ==
X-Google-Smtp-Source: AGHT+IFEGYkKZ0Py4tdvaTJXArcAt/M5T9yGAL5nGLhbKjdg69nuEd1Vlo2DyFdNdNvyFxu6bq0R/kL3HyM3LXFhJtg=
X-Received: by 2002:a50:d71d:0:b0:54b:2894:d1d8 with SMTP id
 t29-20020a50d71d000000b0054b2894d1d8mr2350738edi.27.1702488059819; Wed, 13
 Dec 2023 09:20:59 -0800 (PST)
MIME-Version: 1.0
References: <20231112092232.131-1-n.ostrenkov@gmail.com>
 <CAFEAcA8A8sGjknad1QpeJ8qank-mWWw+gRvR4PVBHk2zAHrEnQ@mail.gmail.com>
 <fbab82ef-bb45-417a-932e-99089dd4d4a5@linaro.org>
In-Reply-To: <fbab82ef-bb45-417a-932e-99089dd4d4a5@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2023 17:20:21 +0000
Message-ID: <CAFEAcA-NVrx+q6XLX02vuwD274THh5N7NJExVzvtD5zKaFa4HQ@mail.gmail.com>
Subject: Re: [PATCH] fsl-imx: Add simple RTC emulation for i.MX6 and i.MX7
 boards
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Nikita Ostrenkov <n.ostrenkov@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Wed, 13 Dec 2023 at 17:17, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Peter,
>
> On 12/12/23 15:18, Peter Maydell wrote:
> > On Sun, 12 Nov 2023 at 09:22, Nikita Ostrenkov <n.ostrenkov@gmail.com> =
wrote:
> >
> > Hi; thanks for this patch, and sorry I haven't got round
> > to reviewing it earlier.
> >
> >> Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
> >> ---
> >>   hw/misc/imx7_snvs.c         | 59 ++++++++++++++++++++++++++++++++---=
--
> >>   hw/misc/trace-events        |  4 +--
> >>   include/hw/misc/imx7_snvs.h | 14 ++++++++-
> >>   3 files changed, 67 insertions(+), 10 deletions(-)
>
>
> >> @@ -31,6 +33,16 @@ struct IMX7SNVSState {
> >>       SysBusDevice parent_obj;
> >>
> >>       MemoryRegion mmio;
> >> +
> >> +    /*
> >> +     * Needed to preserve the tick_count across migration, even if th=
e
> >> +     * absolute value of the rtc_clock is different on the source and
> >> +     * destination.
> >> +     */
> >> +    int64_t tick_offset_vmstate;
> >
> > You don't need tick_offset_vmstate -- it is only in the p031
> > RTC device as a backwards-compatibility thing for older versions
> > of QEMU. Migrating tick_offset alone is sufficient in a new
> > device. (It seems to have been unfortunately copied-and-pasted
> > into the goldfish RTC device; we should probably fix that bug.)
> >
> >> +    int64_t tick_offset;
> >> +
> >> +    uint64_t lpcr;
> >
> > We've now added state to this device, which means that it needs
> > a VMState structure to handle migration, and it needs a reset
> > function.
>
> I just noticed your v1 review after reviewing v2. Indeed
> 'tick_offset' need to be migrated. Now about reset(), RTC
> are somehow different. When resetting a machine in the same
> QEMU process I'd expect the RTC offset to not be reset.
>
> Could this be clarified by adding a reset handler with no
> code but a comment /* RTC state is usually kept by CMOS
> battery and is not reset */ maybe?

The lpcr register state needs to be reset.

thanks
-- PMM

