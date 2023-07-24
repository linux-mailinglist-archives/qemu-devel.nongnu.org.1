Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFEB75FA5C
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 17:03:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNx4E-0001wV-PC; Mon, 24 Jul 2023 11:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNx49-0001w0-Gu
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 11:01:42 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNx46-0004hN-7e
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 11:01:40 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4fdd31bf179so6625245e87.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 08:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690210895; x=1690815695;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+BKvwNBXiR8ToZCcduRzqfCJfeFNN3EIFViHd8mstXA=;
 b=NEjh8G3Z656MK4p9CYoi2MqX0iab9lbLjdjnGoYYUNiH+imMEAPzcBuogL8xSN/zoR
 3hnCq74QLnL9QBjY0VVL2jEcrq9DugUkp8ZuUm4G1mNqSoBtudEMYsJLFyEv2SG45/JF
 pWLFrnghLksIYlarAy26Js15GIr1H83i0+AXAVv4bPQylEIYO4vYB3EYjwSagwMxVILj
 2VKCRQKBFWz1gczwTqzsOD4LKrb8odK/vP0I1p25zvMmcURg/JsQTraSM+395WRJYvUD
 Z4rSAjEXkKyJ4QG+xzoLpSuStsZmg0/bA5CVEOB8IwQZTdEJbOS0j5TAP8nEjU4geyVE
 Zepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690210895; x=1690815695;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+BKvwNBXiR8ToZCcduRzqfCJfeFNN3EIFViHd8mstXA=;
 b=Swb5LRFyl9p/mR0QlZHOEd22bkbPX6y2wMwi1uh4eUsURvRDn8Y1I5uJUodlq1EYJ0
 Dt40JkdwJqFHodZNQnVN29X+B5jBjJODalfuqzJlkMvkw2zrDO0ICmp6c4gBHyOP+q1/
 3gOQq3x9Zsaj9XSkwhpiwWQvnJ6i4njW2g/KJQZEJKzzCkPwe9DZ7xfLHEePyXe76qVk
 b4Z9ckZRFzQhECzOBssNcVBqG2ySqOhK3unCJZisoEsSh5hJFBUL3RBm56KPC+wWJfhh
 kc6BpcMzMO5v4j5XB7ugZ7hcixwPJpCRYCWCJTTOGnQeiYH5oRF4GTxU7aSixu9AENHG
 puYA==
X-Gm-Message-State: ABy/qLanGuzVgZcDrU/uXjC0Yg8ZBUdpWwJW7Q/7x3cTm1qez0NaNXzp
 U/7xZPinVbHa15FcXiCH4et/jkWAM7O1v77s4yXGfA==
X-Google-Smtp-Source: APBJJlEhRb/Gk9/42N/cvAebjho2qDJkLlzNjlIlH0ekDN0Z1190dLNyBFggFKH8D4CcM+35mDQLShlm2tej/tfrxeA=
X-Received: by 2002:a05:6512:128a:b0:4fb:74da:989a with SMTP id
 u10-20020a056512128a00b004fb74da989amr6452284lfs.3.1690210895234; Mon, 24 Jul
 2023 08:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230704145012.49870-1-philmd@linaro.org>
 <20230704145012.49870-18-philmd@linaro.org>
In-Reply-To: <20230704145012.49870-18-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2023 16:01:24 +0100
Message-ID: <CAFEAcA9Qk2jMLdM+3zjAvFj0wF6NBhH+wB7zpeU-zE5e9a_RJw@mail.gmail.com>
Subject: Re: [PATCH v2 17/19] hw/timer/arm_timer: QDev'ify ARM_TIMER
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Sergey Kambalin <serg.oker@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

On Tue, 4 Jul 2023 at 15:51, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Introduce the ARM_TIMER sysbus device, exposing one output IRQ
> and a single MMIO region.
>
> arm_timer_new() is converted as QOM instance init()/finalize()
> handlers. Note in arm_timer_finalize() we release a ptimer handle
> which was previously leaked.
>
> ArmTimer is directly embedded into SP804Timer/IntegratorPIT,
> and is initialized as a QOM child.
>
> Since the timer frequency belongs to ARM_TIMER, have it hold the
> QOM property. SP804Timer/IntegratorPIT directly access it.
>
> For IntegratorPIT, each ARM_TIMER sysbus output IRQ is wired as
> input IRQ.
>
> For the SP804Timer, we add a TYPE_OR_IRQ to OR the ARM_TIMER sysbus
> output IRQs together, exposing a single output IRQ.
> The Kconfig entry have to select the OR_IRQ dependency.

How much did you test the migration compat handling in this patch?
TYPE_OR_IRQ has its own migration state, and I forget how
it works when you migrate from a machine without a device
to one that has it. Does it just work and the extra device
ends up with the same state it has at reset?

Anyway, we should list in the commit message all the
affected boards (whether that's "migration break" or
"migration compat, forwards only").

> +static int sp804_post_load(void *opaque, int version_id)
> +{
> +    SP804Timer *s =3D opaque;
> +
> +    if (version_id < 2) {
> +        for (unsigned i =3D 0; i < ARRAY_SIZE(s->timer); i++) {
> +            qemu_set_irq(qdev_get_gpio_in(DEVICE(&s->irq_orgate), i),
> +                         s->mig_v1_level[i]);
> +        }
> +    }
> +    return 0;
> +}

Is it really OK to call qemu_set_irq() in a post_load
handler? This is going to end up causing the OR gate
to call qemu_set_irq() on whatever its output is connected
to, and there's no guarantee about migration order between
us and whatever that other device is...

thanks
-- PMM

