Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4817817782
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 17:29:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFGUA-0000ip-2J; Mon, 18 Dec 2023 11:28:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFGU7-0000iH-7s
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 11:28:51 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFGU4-0006oG-QG
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 11:28:50 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5534abbc637so1614806a12.0
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 08:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702916924; x=1703521724; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=25IIXBonTjtNAAdtpKjGM3WakvUkpmjdYpaZ1WQD5GY=;
 b=h6cbRAI1TmAq2erk7lMS/u9zNwCVr9BJHSuqvqzcdhCL5tk01/kYwIycX0UmFxaIGA
 6p9rDdz3a3uea87eTHgU4o505DQWbRb/8X+Dsm6/Qjb1r50SpwTo0fLVCkM+rZDnzbcZ
 HOZO/KXUBuZo9C/6XPPcqJwi5dAKVJk2WetfSRhM8VbIQrKnOhb4pRTHLB43us36XdU3
 fG2BROZ6mEvzBD3cd37ylsgnbjP0/NTW7dW4FZSLKShS0PZlFSpC9CJtZ0X/BIkUrhr0
 kG2QOdnhXjuIgJ3Gc3iHCMoXJACuedITRpUa7Hq7JUuRdPp/sF1a4YubKr+l8kqzXQ0h
 4+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702916924; x=1703521724;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=25IIXBonTjtNAAdtpKjGM3WakvUkpmjdYpaZ1WQD5GY=;
 b=OvSaC0glLrxLJxNt+qnyCpcQudILE4H3a8h1FGBq5ozwpmzJAE+yFzyUhGr3zvzfxu
 ZxJXm1GCjgpmEgCzLoHEe4opgbQB+I/NGqpAeLAyqkIi4VY8DUw5l7u/Sjptbpk8z8i4
 fMA1hPlRse1v8Dzqb1NpFCYNHko9sN/mTHVnCud6+71Pdq6VMfC8+BT0WNnB03a+PS2g
 Q1SVae1eimAN/VTygiWdZyVoEtDXtRphEMI3A1nM0kGDU1yszoP/mTYOiOoShKe0b8o0
 Hefutsed7YXAvM1Q2u//Bww6TPE7yxDC1Hf7fXdFs/NkF8zxrBWJ3g+NM5rqGdRb+98a
 kg6Q==
X-Gm-Message-State: AOJu0YyFXKHNohR65BBNZ830aHS7cRaJXSPNxQG4p3R4F2VF/lKCH47U
 ctvyy2/t7Tp7YWApmZWahEx84i3UxfWnQ6BciePOCAGSgr54xDIP
X-Google-Smtp-Source: AGHT+IGpH8u79MJCEJHcN5VHFdhEUxbYS8/NMj2iK1Xgi49ITnGvvRiyDDrO/SeHa5SDL295AWDJ3YGXa9S0QDjjdOI=
X-Received: by 2002:a50:cdcd:0:b0:54c:5d36:42e6 with SMTP id
 h13-20020a50cdcd000000b0054c5d3642e6mr8695603edj.81.1702916923721; Mon, 18
 Dec 2023 08:28:43 -0800 (PST)
MIME-Version: 1.0
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
 <20231208023145.1385775-7-sergey.kambalin@auriga.com>
In-Reply-To: <20231208023145.1385775-7-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Dec 2023 16:28:32 +0000
Message-ID: <CAFEAcA_fFXV9zfsYYzowxrcHQT4e4mSLr-55MLp85b0J=AVJ+g@mail.gmail.com>
Subject: Re: [PATCH v4 06/45] Add BCM2838 GPIO stub
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Fri, 8 Dec 2023 at 02:39, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2838.c                     |   4 +-
>  hw/gpio/bcm2838_gpio.c               | 152 +++++++++++++++++++++++++++
>  hw/gpio/meson.build                  |   5 +-
>  include/hw/arm/bcm2838_peripherals.h |   2 -
>  include/hw/gpio/bcm2838_gpio.h       |  40 +++++++
>  5 files changed, 198 insertions(+), 5 deletions(-)
>  create mode 100644 hw/gpio/bcm2838_gpio.c
>  create mode 100644 include/hw/gpio/bcm2838_gpio.h
>
> diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
> index 042e543006..8925957c6c 100644
> --- a/hw/arm/bcm2838.c
> +++ b/hw/arm/bcm2838.c
> @@ -14,7 +14,7 @@
>  #include "hw/arm/bcm2838.h"
>  #include "trace.h"
>
> -#define GIC400_MAINTAINANCE_IRQ      9
> +#define GIC400_MAINTENANCE_IRQ      9
>  #define GIC400_TIMER_NS_EL2_IRQ     10
>  #define GIC400_TIMER_VIRT_IRQ       11
>  #define GIC400_LEGACY_FIQ           12
> @@ -163,7 +163,7 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
>
>          sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), n + 4 * BCM283X_NCPUS,
>                             qdev_get_gpio_in(gicdev,
> -                                            PPI(n, GIC400_MAINTAINANCE_IRQ)));
> +                                            PPI(n, GIC400_MAINTENANCE_IRQ)));
>
>          /* Connect timers from the CPU to the interrupt controller */
>          qdev_connect_gpio_out(cpudev, GTIMER_PHYS,

Squash these changes into the previous patch :-)

> diff --git a/hw/gpio/bcm2838_gpio.c b/hw/gpio/bcm2838_gpio.c
> new file mode 100644
> index 0000000000..15b66cb559
> --- /dev/null
> +++ b/hw/gpio/bcm2838_gpio.c
> @@ -0,0 +1,152 @@
> +/*
> + * Raspberry Pi (BCM2838) GPIO Controller
> + * This implementation is based on bcm2835_gpio (hw/gpio/bcm2835_gpio.c)
> + *
> + * Copyright (c) 2022 Auriga LLC
> + *
> + * Authors:
> + *  Lotosh, Aleksey <aleksey.lotosh@auriga.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.

It would be nice to be consistent about whether you want to use
SPDX-License-Identifier tags or not in the new files you're adding.
(Patch 4's bcm2838.c uses it; this one doesn't.)

> + */

> +#define RESET_VAL_CNTRL_REG0 0xAAA95555;
> +#define RESET_VAL_CNTRL_REG1 0xA0AAAAAA;
> +#define RESET_VAL_CNTRL_REG2 0x50AAA95A;
> +#define RESET_VAL_CNTRL_REG3 0x00055555;

These shouldn't have trailing semicolons.

> +
> +#define BYTES_IN_WORD        4

> diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
> index 066ea96480..8a8d03d885 100644
> --- a/hw/gpio/meson.build
> +++ b/hw/gpio/meson.build
> @@ -9,6 +9,9 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_gpio.c'))
>  system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_gpio.c'))
>  system_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_gpio.c'))
>  system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_gpio.c'))
> -system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_gpio.c'))
> +system_ss.add(when: 'CONFIG_RASPI', if_true: files(
> +    'bcm2835_gpio.c',
> +    'bcm2838_gpio.c'
> +))
>  system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
> diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
> index 5a72355183..d07831753a 100644
> --- a/include/hw/arm/bcm2838_peripherals.h
> +++ b/include/hw/arm/bcm2838_peripherals.h
> @@ -11,8 +11,6 @@
>
>  #include "hw/arm/bcm2835_peripherals.h"
>
> -#define GENET_OFFSET            0x1580000
> -

Why does this line get deleted ?

>  /* SPI */
>  #define GIC_SPI_INTERRUPT_MBOX         33
>  #define GIC_SPI_INTERRUPT_MPHI         40

thanks
-- PMM

