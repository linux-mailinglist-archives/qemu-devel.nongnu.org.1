Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B23088063FF
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 02:17:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAgWa-0001tI-3i; Tue, 05 Dec 2023 20:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rAgWU-0001sx-5D; Tue, 05 Dec 2023 20:16:22 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rAgWO-0006AJ-UZ; Tue, 05 Dec 2023 20:16:21 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50bf3efe2cbso3694230e87.2; 
 Tue, 05 Dec 2023 17:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701825373; x=1702430173; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VLKxWsKEQZsUsWE7rtTNZPVsejtpffjb6g+BmgkN4Go=;
 b=SdW0ahCj7xfYV0rk8f4AGOtUvmvFsqzxe1MZz53kW5TZPgMdD9G3N6gaNHMclmbc6u
 IYFGPgqlTC1WYYZzJXbKUFBWFvT6pTzx3Iobdl5a1x5XgxewEJxuAMOCyWnbyLFAk/Zq
 bzSQMAnbVWSsWvRH5dsUR2dzurHfFNWvKsYf15wWj+GsrQVSAtQjQ8OY6sX97VNkqlb5
 fhNB93y5F+fxGPpT0Vi5ONBvrqvOkKaEqlvahupfoLPYkJDAvv5jrgocstx7iYOWGbF1
 ogPx95lEnFLh4SB6cmaSvWClMW+gF7ITiuoDkIXirplNjtYXUC62jYHp8c4CSGaES+n0
 FG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701825373; x=1702430173;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VLKxWsKEQZsUsWE7rtTNZPVsejtpffjb6g+BmgkN4Go=;
 b=TUtjMkh+mg0EVBqzyhYoT1/jSPfu0sEr82BtEYG5iTM9973SUuht+UPEnZg3gAjeHn
 4QCEafDEPxu6ajyg8VGS/IS66tmiZG5h17JT6/XkE7RZ0H7VaN/X19TDxsCr3Avliqzm
 FoTlXOHQ0r7zW3cPd+SH1e+lZXqPx9Pg4YZJMGg2t7l0O5HAkpjHfbd6SNfCPohfqBbA
 ryaOLgDmHFHscU4G5r2DkCTS/tflqSVhf33PRxKuF/5Dglm1taDYd9di+VUrxxWy9Mr7
 vGk7p662VdVNMjfE7ivfe4/lTjlI0KknIQmCcXh0oeBnbrhDs8VoeI/We8V3j6NCOVyU
 hQkQ==
X-Gm-Message-State: AOJu0YzvpkFkr0G3QSZaqoPeeHWudC6mTkXRPAs8cE1djb8YODIv/u3M
 wYIwr5tv56u4IaHWSe33hO3XqM5JvNDWkNpAktg=
X-Google-Smtp-Source: AGHT+IFZZLptFsKFpTon5Tjn5K6A7H4bcR8ix1JW7OPzAmZ5BrQAC5fpp5CJfRK+Kq+DjU7oGdVCl+V6KQmX8HmEDcw=
X-Received: by 2002:a19:e05c:0:b0:50b:e8b2:a78f with SMTP id
 g28-20020a19e05c000000b0050be8b2a78fmr43350lfj.268.1701825372383; Tue, 05 Dec
 2023 17:16:12 -0800 (PST)
MIME-Version: 1.0
References: <170171757903.6536.10207274798404158986-0@git.sr.ht>
 <170171757903.6536.10207274798404158986-1@git.sr.ht>
In-Reply-To: <170171757903.6536.10207274798404158986-1@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Dec 2023 11:15:44 +1000
Message-ID: <CAKmqyKNH+vwXEBHgWkOeo0MWPL8Qm9XFuBZnnMk-hd3hd3iyaA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 1/1] Implement STM32L4x5 EXTI
To: "~inesvarhol" <inesvarhol@proton.me>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alistair@alistair23.me, 
 philmd@linaro.org, peter.maydell@linaro.org, ines.varhol@telecom-paris.fr, 
 arnaud.minier@telecom-paris.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=alistair23@gmail.com; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Dec 5, 2023 at 5:20=E2=80=AFAM ~inesvarhol <inesvarhol@git.sr.ht> w=
rote:
>
> From: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> ---
>  hw/arm/Kconfig                    |   1 +
>  hw/arm/stm32l4x5_soc.c            |  65 +++-
>  hw/misc/Kconfig                   |   3 +
>  hw/misc/meson.build               |   1 +
>  hw/misc/stm32l4x5_exti.c          | 306 +++++++++++++++++++
>  hw/misc/trace-events              |   5 +
>  include/hw/arm/stm32l4x5_soc.h    |   3 +
>  include/hw/misc/stm32l4x5_exti.h  |  58 ++++
>  tests/qtest/meson.build           |   5 +
>  tests/qtest/stm32l4x5_exti-test.c | 485 ++++++++++++++++++++++++++++++
>  10 files changed, 930 insertions(+), 2 deletions(-)
>  create mode 100644 hw/misc/stm32l4x5_exti.c
>  create mode 100644 include/hw/misc/stm32l4x5_exti.h
>  create mode 100644 tests/qtest/stm32l4x5_exti-test.c
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index b95576fb0c..28d378ed83 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -458,6 +458,7 @@ config STM32L4X5_SOC
>      bool
>      select ARM_V7M
>      select OR_IRQ
> +    select STM32L4X5_EXTI
>
>  config XLNX_ZYNQMP_ARM
>      bool
> diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
> index f476878b2c..cf786eac1d 100644
> --- a/hw/arm/stm32l4x5_soc.c
> +++ b/hw/arm/stm32l4x5_soc.c
> @@ -45,10 +45,51 @@
>  #define SRAM2_BASE_ADDRESS 0x10000000
>  #define SRAM2_SIZE (32 * KiB)
>
> +#define EXTI_ADDR 0x40010400
> +
> +#define NUM_EXTI_IRQ 40
> +/* Match exti line connections with their CPU IRQ number */
> +/* See Vector Table (Reference Manual p.396) */
> +static const int exti_irq[NUM_EXTI_IRQ] =3D {
> +    6,                      /* GPIO[0]                 */
> +    7,                      /* GPIO[1]                 */
> +    8,                      /* GPIO[2]                 */
> +    9,                      /* GPIO[3]                 */
> +    10,                     /* GPIO[4]                 */
> +    23, 23, 23, 23, 23,     /* GPIO[5..9]              */
> +    40, 40, 40, 40, 40, 40, /* GPIO[10..15]            */
> +    1,                      /* PVD                     */
> +    67,                     /* OTG_FS_WKUP, Direct     */
> +    41,                     /* RTC_ALARM               */
> +    2,                      /* RTC_TAMP_STAMP2/CSS_LSE */
> +    3,                      /* RTC wakeup timer        */
> +    63,                     /* COMP1                   */
> +    63,                     /* COMP2                   */
> +    31,                     /* I2C1 wakeup, Direct     */
> +    33,                     /* I2C2 wakeup, Direct     */
> +    72,                     /* I2C3 wakeup, Direct     */
> +    37,                     /* USART1 wakeup, Direct   */
> +    38,                     /* USART2 wakeup, Direct   */
> +    39,                     /* USART3 wakeup, Direct   */
> +    52,                     /* UART4 wakeup, Direct    */
> +    53,                     /* UART4 wakeup, Direct    */
> +    70,                     /* LPUART1 wakeup, Direct  */
> +    65,                     /* LPTIM1, Direct          */
> +    66,                     /* LPTIM2, Direct          */
> +    76,                     /* SWPMI1 wakeup, Direct   */
> +    1,                      /* PVM1 wakeup             */
> +    1,                      /* PVM2 wakeup             */
> +    1,                      /* PVM3 wakeup             */
> +    1,                      /* PVM4 wakeup             */
> +    78                      /* LCD wakeup, Direct      */
> +};
> +
>  static void stm32l4x5_soc_initfn(Object *obj)
>  {
>      Stm32l4x5SocState *s =3D STM32L4X5_SOC(obj);
>
> +    object_initialize_child(obj, "exti", &s->exti, TYPE_STM32L4X5_EXTI);
> +
>      s->sysclk =3D qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0)=
;
>      s->refclk =3D qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0)=
;
>  }
> @@ -59,7 +100,9 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc=
, Error **errp)
>      Stm32l4x5SocState *s =3D STM32L4X5_SOC(dev_soc);
>      const Stm32l4x5SocClass *sc =3D STM32L4X5_SOC_GET_CLASS(dev_soc);
>      MemoryRegion *system_memory =3D get_system_memory();
> -    DeviceState *armv7m;
> +    DeviceState *dev, *armv7m;
> +    SysBusDevice *busdev;
> +    int i;
>
>      /*
>       * We use s->refclk internally and only define it with qdev_init_clo=
ck_in()
> @@ -124,6 +167,25 @@ static void stm32l4x5_soc_realize(DeviceState *dev_s=
oc, Error **errp)
>          return;
>      }
>
> +    dev =3D DEVICE(&s->exti);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->exti), errp)) {
> +        return;
> +    }
> +    busdev =3D SYS_BUS_DEVICE(dev);
> +    sysbus_mmio_map(busdev, 0, EXTI_ADDR);
> +    for (i =3D 0; i < NUM_EXTI_IRQ; i++) {
> +        /* IRQ seems not to be connected ? */
> +        sysbus_connect_irq(busdev, i, qdev_get_gpio_in(armv7m, exti_irq[=
i]));
> +    }
> +
> +    /*
> +     * Uncomment when Syscfg is implemented
> +     * for (i =3D 0; i < 16; i++) {
> +     *     qdev_connect_gpio_out(DEVICE(&s->syscfg), i,
> +     *                           qdev_get_gpio_in(dev, i));
> +     * }
> +     */
> +
>      /* APB1 BUS */
>      create_unimplemented_device("TIM2",      0x40000000, 0x400);
>      create_unimplemented_device("TIM3",      0x40000400, 0x400);
> @@ -164,7 +226,6 @@ static void stm32l4x5_soc_realize(DeviceState *dev_so=
c, Error **errp)
>      create_unimplemented_device("SYSCFG",    0x40010000, 0x30);
>      create_unimplemented_device("VREFBUF",   0x40010030, 0x1D0);
>      create_unimplemented_device("COMP",      0x40010200, 0x200);
> -    create_unimplemented_device("EXTI",      0x40010400, 0x400);
>      /* RESERVED:    0x40010800, 0x1400 */
>      create_unimplemented_device("FIREWALL",  0x40011C00, 0x400);
>      /* RESERVED:    0x40012000, 0x800 */

Connecting the device should be a separate patch. So something like
 - Patch 1, implement device
 - Patch 2, add tests
 - Patch 3, connect device

> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index cc8a8c1418..3efe3dc2cc 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -87,6 +87,9 @@ config STM32F4XX_SYSCFG
>  config STM32F4XX_EXTI
>      bool
>
> +config STM32L4X5_EXTI
> +    bool
> +
>  config MIPS_ITU
>      bool
>
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 36c20d5637..16db6e228d 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -110,6 +110,7 @@ system_ss.add(when: 'CONFIG_XLNX_VERSAL_TRNG', if_tru=
e: files(
>  system_ss.add(when: 'CONFIG_STM32F2XX_SYSCFG', if_true: files('stm32f2xx=
_syscfg.c'))
>  system_ss.add(when: 'CONFIG_STM32F4XX_SYSCFG', if_true: files('stm32f4xx=
_syscfg.c'))
>  system_ss.add(when: 'CONFIG_STM32F4XX_EXTI', if_true: files('stm32f4xx_e=
xti.c'))
> +system_ss.add(when: 'CONFIG_STM32L4X5_EXTI', if_true: files('stm32l4x5_e=
xti.c'))
>  system_ss.add(when: 'CONFIG_MPS2_FPGAIO', if_true: files('mps2-fpgaio.c'=
))
>  system_ss.add(when: 'CONFIG_MPS2_SCC', if_true: files('mps2-scc.c'))
>
> diff --git a/hw/misc/stm32l4x5_exti.c b/hw/misc/stm32l4x5_exti.c
> new file mode 100644
> index 0000000000..0f12a1f799
> --- /dev/null
> +++ b/hw/misc/stm32l4x5_exti.c
> @@ -0,0 +1,306 @@
> +/*
> + * STM32L4x5 EXTI (Extended interrupts and events controller)
> + *
> + * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
> + * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
> + * Copyright (c) 2023 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>
> + * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> + *
> + * SPDX-License-Identifier: MIT
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +
> +/* stm32l4x5_exti implementation is derived from stm32f4xx_exti */

Can you add a justification in the commit message of why we need a new
model here, instead of using the existing stm32f4xx_exti with changes

Otherwise looks fine. If you split it up into 3 patches it should be
close to mergable :)

Alistair

> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "trace.h"
> +#include "hw/irq.h"
> +#include "migration/vmstate.h"
> +#include "hw/misc/stm32l4x5_exti.h"
> +
> +#define EXTI_IMR1   0x00
> +#define EXTI_EMR1   0x04
> +#define EXTI_RTSR1  0x08
> +#define EXTI_FTSR1  0x0C
> +#define EXTI_SWIER1 0x10
> +#define EXTI_PR1    0x14
> +#define EXTI_IMR2   0x20
> +#define EXTI_EMR2   0x24
> +#define EXTI_RTSR2  0x28
> +#define EXTI_FTSR2  0x2C
> +#define EXTI_SWIER2 0x30
> +#define EXTI_PR2    0x34
> +
> +#define EXTI_NUM_GPIO_EVENT_IN_LINES 16
> +
> +/* 0b11111111_10000010_00000000_00000000 */
> +#define DIRECT_LINE_MASK1 0xFF820000
> +/* 0b00000000_00000000_00000000_10000111 */
> +#define DIRECT_LINE_MASK2 0x00000087
> +/* 0b11111111_11111111_11111111_00000000 */
> +#define RESERVED_BITS_MASK2 0xFFFFFF00
> +
> +/* 0b00000000_00000000_00000000_01111000 */
> +#define ACTIVABLE_MASK2 (~DIRECT_LINE_MASK2 & ~RESERVED_BITS_MASK2)
> +
> +static void stm32l4x5_exti_reset_hold(Object *obj)
> +{
> +    Stm32l4x5ExtiState *s =3D STM32L4X5_EXTI(obj);
> +
> +    s->imr[0] =3D DIRECT_LINE_MASK1;
> +    s->emr[0] =3D 0x00000000;
> +    s->rtsr[0] =3D 0x00000000;
> +    s->ftsr[0] =3D 0x00000000;
> +    s->swier[0] =3D 0x00000000;
> +    s->pr[0] =3D 0x00000000;
> +
> +    s->imr[1] =3D DIRECT_LINE_MASK2;
> +    s->emr[1] =3D 0x00000000;
> +    s->rtsr[1] =3D 0x00000000;
> +    s->ftsr[1] =3D 0x00000000;
> +    s->swier[1] =3D 0x00000000;
> +    s->pr[1] =3D 0x00000000;
> +}
> +
> +static void stm32l4x5_exti_set_irq(void *opaque, int irq, int level)
> +{
> +    Stm32l4x5ExtiState *s =3D opaque;
> +    const unsigned n =3D irq >=3D 32;
> +    const int oirq =3D irq;
> +
> +    trace_stm32l4x5_exti_set_irq(irq, level);
> +
> +    if (irq >=3D 32) {
> +        /* Shift the value to enable access in x2 registers. */
> +        irq -=3D 32;
> +    }
> +
> +    /* If the interrupt is masked, pr won't be raised */
> +    if (!((1 << irq) & s->imr[n])) {
> +        return;
> +    }
> +
> +    if (((1 << irq) & s->rtsr[n]) && level) {
> +        /* Rising Edge */
> +        s->pr[n] |=3D 1 << irq;
> +    }
> +
> +    if (((1 << irq) & s->ftsr[n]) && !level) {
> +        /* Falling Edge */
> +        s->pr[n] |=3D 1 << irq;
> +    }
> +
> +    qemu_irq_pulse(s->irq[oirq]);
> +}
> +
> +static uint64_t stm32l4x5_exti_read(void *opaque, hwaddr addr,
> +                                    unsigned int size)
> +{
> +    Stm32l4x5ExtiState *s =3D opaque;
> +    uint32_t r =3D 0;
> +    const unsigned n =3D addr >=3D EXTI_IMR2;
> +
> +    switch (addr) {
> +    case EXTI_IMR1:
> +    case EXTI_IMR2:
> +        r =3D s->imr[n];
> +        break;
> +    case EXTI_EMR1:
> +    case EXTI_EMR2:
> +        r =3D s->emr[n];
> +        break;
> +    case EXTI_RTSR1:
> +    case EXTI_RTSR2:
> +        r =3D s->rtsr[n];
> +        break;
> +    case EXTI_FTSR1:
> +    case EXTI_FTSR2:
> +        r =3D s->ftsr[n];
> +        break;
> +    case EXTI_SWIER1:
> +    case EXTI_SWIER2:
> +        r =3D s->swier[n];
> +        break;
> +    case EXTI_PR1:
> +    case EXTI_PR2:
> +        r =3D s->pr[n];
> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "STM32L4X5_exti_read: Bad offset 0x%x\n", (int)add=
r);
> +        break;
> +    }
> +
> +    trace_stm32l4x5_exti_read(addr, r);
> +
> +    return r;
> +}
> +
> +static void stm32l4x5_exti_write(void *opaque, hwaddr addr,
> +                                 uint64_t val64, unsigned int size)
> +{
> +    Stm32l4x5ExtiState *s =3D opaque;
> +    const uint32_t value =3D (uint32_t)val64;
> +
> +    trace_stm32l4x5_exti_write(addr, value);
> +
> +    switch (addr) {
> +    case EXTI_IMR1:
> +        s->imr[0] =3D value;
> +        return;
> +    case EXTI_EMR1:
> +        s->emr[0] =3D value;
> +        return;
> +    case EXTI_RTSR1:
> +        s->rtsr[0] =3D value & ~DIRECT_LINE_MASK1;
> +        return;
> +    case EXTI_FTSR1:
> +        s->ftsr[0] =3D value & ~DIRECT_LINE_MASK1;
> +        return;
> +    case EXTI_SWIER1:
> +        const uint32_t set1 =3D value & ~DIRECT_LINE_MASK1;
> +        const uint32_t pend1 =3D set1 & ~s->swier[0] & s->imr[0] & ~s->p=
r[0];
> +        s->swier[0] =3D set1;
> +        s->pr[0] |=3D pend1;
> +        for (int i =3D 0; i < 32; i++) {
> +            if (pend1 & (1 << i)) {
> +                qemu_irq_raise(s->irq[i]);
> +            }
> +        }
> +        return;
> +    case EXTI_PR1:
> +        const uint32_t cleared1 =3D s->pr[0] & value & ~DIRECT_LINE_MASK=
1;
> +        /* This bit is cleared by writing a 1 to it */
> +        s->pr[0] &=3D ~cleared1;
> +        /* Software triggered interrupts are cleared as well */
> +        s->swier[0] &=3D ~cleared1;
> +        for (int i =3D 0; i < 32; i++) {
> +            if (cleared1 & (1 << i)) {
> +                qemu_irq_lower(s->irq[i]);
> +            }
> +        }
> +        return;
> +    case EXTI_IMR2:
> +        s->imr[1] =3D value & ~RESERVED_BITS_MASK2;
> +        return;
> +    case EXTI_EMR2:
> +        s->emr[1] =3D value & ~RESERVED_BITS_MASK2;
> +        return;
> +    case EXTI_RTSR2:
> +        s->rtsr[1] =3D value & ACTIVABLE_MASK2;
> +        return;
> +    case EXTI_FTSR2:
> +        s->ftsr[1] =3D value & ACTIVABLE_MASK2;
> +        return;
> +    case EXTI_SWIER2:
> +        const uint32_t set2 =3D value & ACTIVABLE_MASK2;
> +        const uint32_t pend2 =3D set2 & ~s->swier[1] & s->imr[1] & ~s->p=
r[1];
> +        s->swier[1] =3D set2;
> +        s->pr[1] |=3D pend2;
> +        for (int i =3D 0; i < 8; i++) {
> +            if (pend2 & (1 << i)) {
> +                qemu_irq_raise(s->irq[32 + i]);
> +            }
> +        }
> +        return;
> +    case EXTI_PR2:
> +        const uint32_t cleared =3D s->pr[1] & value & ACTIVABLE_MASK2;
> +        /* This bit is cleared by writing a 1 to it */
> +        s->pr[1] &=3D ~cleared;
> +        /* Software triggered interrupts are cleared as well */
> +        s->swier[1] &=3D ~cleared;
> +        for (int i =3D 0; i < 8; i++) {
> +            if (cleared & (1 << i)) {
> +                qemu_irq_lower(s->irq[32 + i]);
> +            }
> +        }
> +        return;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "STM32L4X5_exti_write: Bad offset 0x%x\n", (int)ad=
dr);
> +    }
> +}
> +
> +static const MemoryRegionOps stm32l4x5_exti_ops =3D {
> +    .read =3D stm32l4x5_exti_read,
> +    .write =3D stm32l4x5_exti_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .impl.min_access_size =3D 4,
> +    .impl.max_access_size =3D 4,
> +    .impl.unaligned =3D false,
> +    .valid.min_access_size =3D 4,
> +    .valid.max_access_size =3D 4,
> +    .valid.unaligned =3D false,
> +};
> +
> +static void stm32l4x5_exti_init(Object *obj)
> +{
> +    Stm32l4x5ExtiState *s =3D STM32L4X5_EXTI(obj);
> +    int i;
> +
> +    for (i =3D 0; i < EXTI_NUM_INTERRUPT_OUT_LINES; i++) {
> +        sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[i]);
> +    }
> +
> +    memory_region_init_io(&s->mmio, obj, &stm32l4x5_exti_ops, s,
> +                          TYPE_STM32L4X5_EXTI, 0x400);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +
> +    qdev_init_gpio_in(DEVICE(obj), stm32l4x5_exti_set_irq,
> +                      EXTI_NUM_GPIO_EVENT_IN_LINES);
> +}
> +
> +static const VMStateDescription vmstate_stm32l4x5_exti =3D {
> +    .name =3D TYPE_STM32L4X5_EXTI,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(imr, Stm32l4x5ExtiState, EXTI_NUM_REGISTER)=
,
> +        VMSTATE_UINT32_ARRAY(emr, Stm32l4x5ExtiState, EXTI_NUM_REGISTER)=
,
> +        VMSTATE_UINT32_ARRAY(rtsr, Stm32l4x5ExtiState, EXTI_NUM_REGISTER=
),
> +        VMSTATE_UINT32_ARRAY(ftsr, Stm32l4x5ExtiState, EXTI_NUM_REGISTER=
),
> +        VMSTATE_UINT32_ARRAY(swier, Stm32l4x5ExtiState, EXTI_NUM_REGISTE=
R),
> +        VMSTATE_UINT32_ARRAY(pr, Stm32l4x5ExtiState, EXTI_NUM_REGISTER),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void stm32l4x5_exti_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> +
> +    dc->vmsd =3D &vmstate_stm32l4x5_exti;
> +    rc->phases.hold =3D stm32l4x5_exti_reset_hold;
> +}
> +
> +static const TypeInfo stm32l4x5_exti_types[] =3D {
> +    {
> +        .name          =3D TYPE_STM32L4X5_EXTI,
> +        .parent        =3D TYPE_SYS_BUS_DEVICE,
> +        .instance_size =3D sizeof(Stm32l4x5ExtiState),
> +        .instance_init =3D stm32l4x5_exti_init,
> +        .class_init    =3D stm32l4x5_exti_class_init,
> +    }
> +};
> +
> +DEFINE_TYPES(stm32l4x5_exti_types)
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 05ff692441..2f01c62c0e 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -163,6 +163,11 @@ stm32f4xx_exti_set_irq(int irq, int level) "Set EXTI=
: %d to %d"
>  stm32f4xx_exti_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
>  stm32f4xx_exti_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%=
" PRIx64 " val: 0x%" PRIx64 ""
>
> +# stm32l4x5_exti.c
> +stm32l4x5_exti_set_irq(int irq, int level) "Set EXTI: %d to %d"
> +stm32l4x5_exti_read(uint64_t addr, uint64_t data) "reg read: addr: 0x%" =
PRIx64 " val: 0x%" PRIx64 ""
> +stm32l4x5_exti_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%=
" PRIx64 " val: 0x%" PRIx64 ""
> +
>  # tz-mpc.c
>  tz_mpc_reg_read(uint32_t offset, uint64_t data, unsigned size) "TZ MPC r=
egs read: offset 0x%x data 0x%" PRIx64 " size %u"
>  tz_mpc_reg_write(uint32_t offset, uint64_t data, unsigned size) "TZ MPC =
regs write: offset 0x%x data 0x%" PRIx64 " size %u"
> diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_so=
c.h
> index 564201fee5..ac47158596 100644
> --- a/include/hw/arm/stm32l4x5_soc.h
> +++ b/include/hw/arm/stm32l4x5_soc.h
> @@ -37,6 +37,7 @@
>  #include "qemu/units.h"
>  #include "hw/qdev-core.h"
>  #include "hw/arm/armv7m.h"
> +#include "hw/misc/stm32l4x5_exti.h"
>  #include "qom/object.h"
>
>  #define TYPE_STM32L4X5_SOC "stm32l4x5-soc"
> @@ -50,6 +51,8 @@ struct Stm32l4x5SocState {
>
>      ARMv7MState armv7m;
>
> +    Stm32l4x5ExtiState exti;
> +
>      MemoryRegion sram1;
>      MemoryRegion sram2;
>      MemoryRegion flash;
> diff --git a/include/hw/misc/stm32l4x5_exti.h b/include/hw/misc/stm32l4x5=
_exti.h
> new file mode 100644
> index 0000000000..89b3e33b6b
> --- /dev/null
> +++ b/include/hw/misc/stm32l4x5_exti.h
> @@ -0,0 +1,58 @@
> +/*
> + * STM32L4x5 EXTI (Extended interrupts and events controller)
> + *
> + * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
> + * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
> + * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> + *
> + * SPDX-License-Identifier: MIT
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +
> +/* stm32l4x5_exti implementation is derived from stm32f4xx_exti */
> +
> +#ifndef HW_STM32L4X5_EXTI_H
> +#define HW_STM32L4X5_EXTI_H
> +
> +#include "hw/sysbus.h"
> +#include "qom/object.h"
> +
> +#define TYPE_STM32L4X5_EXTI "stm32l4x5-exti"
> +OBJECT_DECLARE_SIMPLE_TYPE(Stm32l4x5ExtiState, STM32L4X5_EXTI)
> +
> +#define EXTI_NUM_INTERRUPT_OUT_LINES 40
> +#define EXTI_NUM_REGISTER 2
> +
> +struct Stm32l4x5ExtiState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mmio;
> +
> +    uint32_t imr[EXTI_NUM_REGISTER];
> +    uint32_t emr[EXTI_NUM_REGISTER];
> +    uint32_t rtsr[EXTI_NUM_REGISTER];
> +    uint32_t ftsr[EXTI_NUM_REGISTER];
> +    uint32_t swier[EXTI_NUM_REGISTER];
> +    uint32_t pr[EXTI_NUM_REGISTER];
> +
> +    qemu_irq irq[EXTI_NUM_INTERRUPT_OUT_LINES];
> +};
> +
> +#endif
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index c9945e69b1..bc62f201a8 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -194,6 +194,10 @@ qtests_aspeed =3D \
>    ['aspeed_hace-test',
>     'aspeed_smc-test',
>     'aspeed_gpio-test']
> +
> +qtests_stm32l4x5 =3D \
> +  ['stm32l4x5_exti-test']
> +
>  qtests_arm =3D \
>    (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) =
+ \
>    (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-ap=
b-dualtimer-test'] : []) + \
> @@ -207,6 +211,7 @@ qtests_arm =3D \
>    (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test=
'] : []) + \
>    (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] =
: []) + \
>    (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : [=
]) + \
> +  (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5=
 : []) + \
>    ['arm-cpu-features',
>     'boot-serial-test']
>
> diff --git a/tests/qtest/stm32l4x5_exti-test.c b/tests/qtest/stm32l4x5_ex=
ti-test.c
> new file mode 100644
> index 0000000000..55094c1144
> --- /dev/null
> +++ b/tests/qtest/stm32l4x5_exti-test.c
> @@ -0,0 +1,485 @@
> +/*
> + * QTest testcase for STML4X5_EXTI
> + *
> + * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
> + * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest-single.h"
> +
> +#define EXTI_BASE_ADDR 0x40010400
> +#define EXTI_IMR1 0x00
> +#define EXTI_EMR1 0x04
> +#define EXTI_RTSR1 0x08
> +#define EXTI_FTSR1 0x0C
> +#define EXTI_SWIER1 0x10
> +#define EXTI_PR1 0x14
> +#define EXTI_IMR2 0x20
> +#define EXTI_EMR2 0x24
> +#define EXTI_RTSR2 0x28
> +#define EXTI_FTSR2 0x2C
> +#define EXTI_SWIER2 0x30
> +#define EXTI_PR2 0x34
> +
> +#define NVIC_ISER 0xE000E100
> +#define NVIC_ISPR 0xE000E200
> +#define NVIC_ICPR 0xE000E280
> +
> +#define EXTI0_IRQ 6
> +#define EXTI1_IRQ 7
> +#define EXTI35_IRQ 1
> +
> +static void enable_nvic_irq(unsigned int n)
> +{
> +    writel(NVIC_ISER, 1 << n);
> +}
> +
> +static void unpend_nvic_irq(unsigned int n)
> +{
> +    writel(NVIC_ICPR, 1 << n);
> +}
> +
> +static bool check_nvic_pending(unsigned int n)
> +{
> +    return readl(NVIC_ISPR) & (1 << n);
> +}
> +
> +static void exti_writel(unsigned int offset, uint32_t value)
> +{
> +    writel(EXTI_BASE_ADDR + offset, value);
> +}
> +
> +static uint32_t exti_readl(unsigned int offset)
> +{
> +    return readl(EXTI_BASE_ADDR + offset);
> +}
> +
> +static void test_reg_write_read(void)
> +{
> +    /* Test that non-reserved bits in xMR and xTSR can be set and cleare=
d */
> +
> +    exti_writel(EXTI_IMR1, 0xFFFFFFFF);
> +    uint32_t imr1 =3D exti_readl(EXTI_IMR1);
> +    g_assert_cmpuint(imr1, =3D=3D, 0xFFFFFFFF);
> +    exti_writel(EXTI_IMR1, 0x00000000);
> +    imr1 =3D exti_readl(EXTI_IMR1);
> +    g_assert_cmpuint(imr1, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_EMR1, 0xFFFFFFFF);
> +    uint32_t emr1 =3D exti_readl(EXTI_EMR1);
> +    g_assert_cmpuint(emr1, =3D=3D, 0xFFFFFFFF);
> +    exti_writel(EXTI_EMR1, 0x00000000);
> +    emr1 =3D exti_readl(EXTI_EMR1);
> +    g_assert_cmpuint(emr1, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_RTSR1, 0xFFFFFFFF);
> +    uint32_t rtsr1 =3D exti_readl(EXTI_RTSR1);
> +    g_assert_cmpuint(rtsr1, =3D=3D, 0x007DFFFF);
> +    exti_writel(EXTI_RTSR1, 0x00000000);
> +    rtsr1 =3D exti_readl(EXTI_RTSR1);
> +    g_assert_cmpuint(rtsr1, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_FTSR1, 0xFFFFFFFF);
> +    uint32_t ftsr1 =3D exti_readl(EXTI_FTSR1);
> +    g_assert_cmpuint(ftsr1, =3D=3D, 0x007DFFFF);
> +    exti_writel(EXTI_FTSR1, 0x00000000);
> +    ftsr1 =3D exti_readl(EXTI_FTSR1);
> +    g_assert_cmpuint(ftsr1, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_IMR2, 0xFFFFFFFF);
> +    uint32_t imr2 =3D exti_readl(EXTI_IMR2);
> +    g_assert_cmpuint(imr2, =3D=3D, 0x000000FF);
> +    exti_writel(EXTI_IMR2, 0x00000000);
> +    imr2 =3D exti_readl(EXTI_IMR2);
> +    g_assert_cmpuint(imr2, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_EMR2, 0xFFFFFFFF);
> +    uint32_t emr2 =3D exti_readl(EXTI_EMR2);
> +    g_assert_cmpuint(emr2, =3D=3D, 0x000000FF);
> +    exti_writel(EXTI_EMR2, 0x00000000);
> +    emr2 =3D exti_readl(EXTI_EMR2);
> +    g_assert_cmpuint(emr2, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_RTSR2, 0xFFFFFFFF);
> +    uint32_t rtsr2 =3D exti_readl(EXTI_RTSR2);
> +    g_assert_cmpuint(rtsr2, =3D=3D, 0x00000078);
> +    exti_writel(EXTI_RTSR2, 0x00000000);
> +    rtsr2 =3D exti_readl(EXTI_RTSR2);
> +    g_assert_cmpuint(rtsr2, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_FTSR2, 0xFFFFFFFF);
> +    uint32_t ftsr2 =3D exti_readl(EXTI_FTSR2);
> +    g_assert_cmpuint(ftsr2, =3D=3D, 0x00000078);
> +    exti_writel(EXTI_FTSR2, 0x00000000);
> +    ftsr2 =3D exti_readl(EXTI_FTSR2);
> +    g_assert_cmpuint(ftsr2, =3D=3D, 0x00000000);
> +}
> +
> +static void test_direct_lines_write(void)
> +{
> +    /* Test that direct lines reserved bits are not written to */
> +
> +    exti_writel(EXTI_RTSR1, 0xFF820000);
> +    uint32_t rtsr1 =3D exti_readl(EXTI_RTSR1);
> +    g_assert_cmpuint(rtsr1, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_FTSR1, 0xFF820000);
> +    uint32_t ftsr1 =3D exti_readl(EXTI_FTSR1);
> +    g_assert_cmpuint(ftsr1, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_SWIER1, 0xFF820000);
> +    uint32_t swier1 =3D exti_readl(EXTI_SWIER1);
> +    g_assert_cmpuint(swier1, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_PR1, 0xFF820000);
> +    uint32_t pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_RTSR2, 0x00000087);
> +    const uint32_t rtsr2 =3D exti_readl(EXTI_RTSR2);
> +    g_assert_cmpuint(rtsr2, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_FTSR2, 0x00000087);
> +    const uint32_t ftsr2 =3D exti_readl(EXTI_FTSR2);
> +    g_assert_cmpuint(ftsr2, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_SWIER2, 0x00000087);
> +    const uint32_t swier2 =3D exti_readl(EXTI_SWIER2);
> +    g_assert_cmpuint(swier2, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_PR2, 0x00000087);
> +    const uint32_t pr2 =3D exti_readl(EXTI_PR2);
> +    g_assert_cmpuint(pr2, =3D=3D, 0x00000000);
> +}
> +
> +static void test_reserved_bits_write(void)
> +{
> +    /* Test that reserved bits stay are not written to */
> +
> +    exti_writel(EXTI_IMR2, 0xFFFFFF00);
> +    uint32_t imr2 =3D exti_readl(EXTI_IMR2);
> +    g_assert_cmpuint(imr2, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_EMR2, 0xFFFFFF00);
> +    uint32_t emr2 =3D exti_readl(EXTI_EMR2);
> +    g_assert_cmpuint(emr2, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_RTSR2, 0xFFFFFF00);
> +    const uint32_t rtsr2 =3D exti_readl(EXTI_RTSR2);
> +    g_assert_cmpuint(rtsr2, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_FTSR2, 0xFFFFFF00);
> +    const uint32_t ftsr2 =3D exti_readl(EXTI_FTSR2);
> +    g_assert_cmpuint(ftsr2, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_SWIER2, 0xFFFFFF00);
> +    const uint32_t swier2 =3D exti_readl(EXTI_SWIER2);
> +    g_assert_cmpuint(swier2, =3D=3D, 0x00000000);
> +
> +    exti_writel(EXTI_PR2, 0xFFFFFF00);
> +    const uint32_t pr2 =3D exti_readl(EXTI_PR2);
> +    g_assert_cmpuint(pr2, =3D=3D, 0x00000000);
> +}
> +
> +static void test_software_interrupt(void)
> +{
> +    /*
> +     * Test that we can launch a software irq by :
> +     * - enabling its line in IMR
> +     * - and then setting a bit from '0' to '1' in SWIER
> +     *
> +     * And that the interruption stays pending in NVIC
> +     * even after clearing the pending bit in PR.
> +     */
> +
> +    /*
> +     * Testing interrupt line EXTI0
> +     * Bit 0 in EXTI_*1 registers (EXTI0) corresponds to GPIO Px_0
> +     */
> +
> +    enable_nvic_irq(EXTI0_IRQ);
> +    /* Check that there are no interrupts already pending in PR */
> +    uint32_t pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +    /* Check that this specific interrupt isn't pending in NVIC */
> +    g_assert_false(check_nvic_pending(EXTI0_IRQ));
> +
> +    /* Enable interrupt line EXTI0 */
> +    exti_writel(EXTI_IMR1, 0x00000001);
> +    /* Set the right SWIER bit from '0' to '1' */
> +    exti_writel(EXTI_SWIER1, 0x00000000);
> +    exti_writel(EXTI_SWIER1, 0x00000001);
> +
> +    /* Check that the write in SWIER was effective */
> +    uint32_t swier1 =3D exti_readl(EXTI_SWIER1);
> +    g_assert_cmpuint(swier1, =3D=3D, 0x00000001);
> +    /* Check that the corresponding pending bit in PR is set */
> +    pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000001);
> +    /* Check that the corresponding interrupt is pending in the NVIC */
> +    g_assert_true(check_nvic_pending(EXTI0_IRQ));
> +
> +    /* Clear the pending bit in PR */
> +    exti_writel(EXTI_PR1, 0x00000001);
> +
> +    /* Check that the write in PR was effective */
> +    pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +    /* Check that the corresponding bit in SWIER was cleared */
> +    swier1 =3D exti_readl(EXTI_SWIER1);
> +    g_assert_cmpuint(swier1, =3D=3D, 0x00000000);
> +    /* Check that the interrupt is still pending in the NVIC */
> +    g_assert_true(check_nvic_pending(EXTI0_IRQ));
> +
> +    /*
> +     * Testing interrupt line EXTI35
> +     * Bit 3 in EXTI_*2 registers (EXTI35) corresponds to PVM 1 Wakeup
> +     */
> +
> +    enable_nvic_irq(EXTI35_IRQ);
> +    /* Check that there are no interrupts already pending */
> +    uint32_t pr2 =3D exti_readl(EXTI_PR2);
> +    g_assert_cmpuint(pr2, =3D=3D, 0x00000000);
> +    g_assert_false(check_nvic_pending(EXTI35_IRQ));
> +
> +    /* Enable interrupt line EXTI0 */
> +    exti_writel(EXTI_IMR2, 0x00000008);
> +    /* Set the right SWIER bit from '0' to '1' */
> +    exti_writel(EXTI_SWIER2, 0x00000000);
> +    exti_writel(EXTI_SWIER2, 0x00000008);
> +
> +    /* Check that the write in SWIER was effective */
> +    uint32_t swier2 =3D exti_readl(EXTI_SWIER2);
> +    g_assert_cmpuint(swier2, =3D=3D, 0x00000008);
> +    /* Check that the corresponding pending bit in PR is set */
> +    pr2 =3D exti_readl(EXTI_PR2);
> +    g_assert_cmpuint(pr2, =3D=3D, 0x00000008);
> +    /* Check that the corresponding interrupt is pending in the NVIC */
> +    g_assert_true(check_nvic_pending(EXTI35_IRQ));
> +
> +    /* Clear the pending bit in PR */
> +    exti_writel(EXTI_PR2, 0x00000008);
> +
> +    /* Check that the write in PR was effective */
> +    pr2 =3D exti_readl(EXTI_PR2);
> +    g_assert_cmpuint(pr2, =3D=3D, 0x00000000);
> +    /* Check that the corresponding bit in SWIER was cleared */
> +    swier2 =3D exti_readl(EXTI_SWIER2);
> +    g_assert_cmpuint(swier2, =3D=3D, 0x00000000);
> +    /* Check that the interrupt is still pending in the NVIC */
> +    g_assert_true(check_nvic_pending(EXTI35_IRQ));
> +
> +    /* Clean NVIC */
> +    unpend_nvic_irq(EXTI0_IRQ);
> +    g_assert_false(check_nvic_pending(EXTI0_IRQ));
> +    unpend_nvic_irq(EXTI35_IRQ);
> +    g_assert_false(check_nvic_pending(EXTI35_IRQ));
> +}
> +
> +static void test_no_software_interrupt(void)
> +{
> +    /*
> +     * Test that software irq doesn't happen when :
> +     * - corresponding bit in IMR isn't set
> +     * - SWIER is set to 1 before IMR is set to 1
> +     */
> +
> +    /*
> +     * Testing interrupt line EXTI0
> +     * Bit 0 in EXTI_*1 registers (EXTI0) corresponds to GPIO Px_0
> +     */
> +
> +    enable_nvic_irq(EXTI0_IRQ);
> +    /* Check that there are no interrupts already pending in PR */
> +    uint32_t pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +    /* Check that this specific interrupt isn't pending in NVIC */
> +    g_assert_false(check_nvic_pending(EXTI0_IRQ));
> +
> +    /* Mask interrupt line EXTI0 */
> +    exti_writel(EXTI_IMR1, 0x00000000);
> +    /* Set the corresponding SWIER bit from '0' to '1' */
> +    exti_writel(EXTI_SWIER1, 0x00000000);
> +    exti_writel(EXTI_SWIER1, 0x00000001);
> +
> +    /* Check that the write in SWIER was effective */
> +    uint32_t swier1 =3D exti_readl(EXTI_SWIER1);
> +    g_assert_cmpuint(swier1, =3D=3D, 0x00000001);
> +    /* Check that the pending bit in PR wasn't set */
> +    pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +    /* Check that the interrupt isn't pending in NVIC */
> +    g_assert_false(check_nvic_pending(EXTI0_IRQ));
> +
> +    /* Enable interrupt line EXTI0 */
> +    exti_writel(EXTI_IMR1, 0x00000001);
> +
> +    /* Check that the pending bit in PR wasn't set */
> +    pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +    /* Check that the interrupt isn't pending in NVIC */
> +    g_assert_false(check_nvic_pending(EXTI0_IRQ));
> +
> +    /*
> +     * Testing interrupt line EXTI35
> +     * Bit 3 in EXTI_*2 registers (EXTI35) corresponds to PVM 1 Wakeup
> +     */
> +
> +    enable_nvic_irq(EXTI35_IRQ);
> +    /* Check that there are no interrupts already pending in PR */
> +    uint32_t pr2 =3D exti_readl(EXTI_PR2);
> +    g_assert_cmpuint(pr2, =3D=3D, 0x00000000);
> +    /* Check that this specific interrupt isn't pending in NVIC */
> +    g_assert_false(check_nvic_pending(EXTI35_IRQ));
> +
> +    /* Mask interrupt line EXTI35 */
> +    exti_writel(EXTI_IMR2, 0x00000000);
> +    /* Set the corresponding SWIER bit from '0' to '1' */
> +    exti_writel(EXTI_SWIER2, 0x00000000);
> +    exti_writel(EXTI_SWIER2, 0x00000008);
> +
> +    /* Check that the write in SWIER was effective */
> +    uint32_t swier2 =3D exti_readl(EXTI_SWIER2);
> +    g_assert_cmpuint(swier2, =3D=3D, 0x00000008);
> +    /* Check that the pending bit in PR wasn't set */
> +    pr2 =3D exti_readl(EXTI_PR2);
> +    g_assert_cmpuint(pr2, =3D=3D, 0x00000000);
> +    /* Check that the interrupt isn't pending in NVIC */
> +    g_assert_false(check_nvic_pending(EXTI35_IRQ));
> +
> +    /* Enable interrupt line EXTI35 */
> +    exti_writel(EXTI_IMR2, 0x00000008);
> +
> +    /* Check that the pending bit in PR wasn't set */
> +    pr2 =3D exti_readl(EXTI_PR2);
> +    g_assert_cmpuint(pr2, =3D=3D, 0x00000000);
> +    /* Check that the interrupt isn't pending in NVIC */
> +    g_assert_false(check_nvic_pending(EXTI35_IRQ));
> +}
> +
> +static void test_masked_interrupt(void)
> +{
> +    /*
> +     * Test that irq doesn't happen when :
> +     * - corresponding bit in IMR isn't set
> +     * - SWIER is set to 1 before IMR is set to 1
> +     */
> +
> +    /*
> +     * Testing interrupt line EXTI1
> +     * with rising edge from GPIOx pin 1
> +     */
> +
> +    enable_nvic_irq(EXTI1_IRQ);
> +    /* Check that there are no interrupts already pending in PR */
> +    uint32_t pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +    /* Check that this specific interrupt isn't pending in NVIC */
> +    g_assert_false(check_nvic_pending(EXTI1_IRQ));
> +
> +    /* Mask interrupt line EXTI1 */
> +    exti_writel(EXTI_IMR1, 0x00000000);
> +
> +    /* Configure interrupt on rising edge */
> +    exti_writel(EXTI_RTSR1, 0x00000002);
> +
> +    /* Simulate rising edge from GPIO line 1 */
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
> +                     NULL, 1, 1);
> +
> +    /* Check that the pending bit in PR wasn't set */
> +    pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +    /* Check that the interrupt isn't pending in NVIC */
> +    g_assert_false(check_nvic_pending(EXTI1_IRQ));
> +
> +    /* Enable interrupt line EXTI1 */
> +    exti_writel(EXTI_IMR1, 0x00000002);
> +
> +    /* Check that the pending bit in PR wasn't set */
> +    pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +    /* Check that the interrupt isn't pending in NVIC */
> +    g_assert_false(check_nvic_pending(EXTI1_IRQ));
> +}
> +
> +static void test_interrupt(void)
> +{
> +    /*
> +     * Test that we can launch an irq by :
> +     * - enabling its line in IMR
> +     * - configuring interrupt on rising edge
> +     * - and then setting the input line from '0' to '1'
> +     *
> +     * And that the interruption stays pending in NVIC
> +     * even after clearing the pending bit in PR.
> +     */
> +
> +    /*
> +     * Testing interrupt line EXTI1
> +     * with rising edge from GPIOx pin 1
> +     */
> +
> +    enable_nvic_irq(EXTI1_IRQ);
> +    /* Check that there are no interrupts already pending in PR */
> +    uint32_t pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +    /* Check that this specific interrupt isn't pending in NVIC */
> +    g_assert_false(check_nvic_pending(EXTI1_IRQ));
> +
> +    /* Enable interrupt line EXTI1 */
> +    exti_writel(EXTI_IMR1, 0x00000002);
> +
> +    /* Configure interrupt on rising edge */
> +    exti_writel(EXTI_RTSR1, 0x00000002);
> +
> +    /* Simulate rising edge from GPIO line 1 */
> +    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
> +                     NULL, 1, 1);
> +
> +    /* Check that the pending bit in PR was set */
> +    pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000002);
> +    /* Check that the interrupt is pending in NVIC */
> +    g_assert_true(check_nvic_pending(EXTI1_IRQ));
> +
> +    /* Clear the pending bit in PR */
> +    exti_writel(EXTI_PR1, 0x00000002);
> +
> +    /* Check that the write in PR was effective */
> +    pr1 =3D exti_readl(EXTI_PR1);
> +    g_assert_cmpuint(pr1, =3D=3D, 0x00000000);
> +    /* Check that the interrupt is still pending in the NVIC */
> +    g_assert_true(check_nvic_pending(EXTI1_IRQ));
> +
> +    /* Clean NVIC */
> +    unpend_nvic_irq(EXTI1_IRQ);
> +    g_assert_false(check_nvic_pending(EXTI1_IRQ));
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    int ret;
> +
> +    g_test_init(&argc, &argv, NULL);
> +    g_test_set_nonfatal_assertions();
> +    qtest_add_func("stm32l4x5/exti/direct_lines", test_direct_lines_writ=
e);
> +    qtest_add_func("stm32l4x5/exti/reserved_bits", test_reserved_bits_wr=
ite);
> +    qtest_add_func("stm32l4x5/exti/reg_write_read", test_reg_write_read)=
;
> +    qtest_add_func("stm32l4x5/exti/no_software_interrupt",
> +                   test_no_software_interrupt);
> +    qtest_add_func("stm32l4x5/exti/software_interrupt",
> +                   test_software_interrupt);
> +    qtest_add_func("stm32l4x5/exti/masked_interrupt", test_masked_interr=
upt);
> +    qtest_add_func("stm32l4x5/exti/interrupt", test_interrupt);
> +
> +    qtest_start("-machine b-l475e-iot01a");
> +    ret =3D g_test_run();
> +    qtest_end();
> +
> +    return ret;
> +}
> --
> 2.38.5
>

