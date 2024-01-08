Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCD8827AEC
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 23:57:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMyXn-0001cj-Sl; Mon, 08 Jan 2024 17:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMyXk-0001be-B8
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 17:56:28 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMyXh-0005ME-0C
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 17:56:28 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3367a304091so2277372f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 14:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704754583; x=1705359383; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RQ7tMiFUBZpc7a/GWseZV8JMPs0jLW4xfpFMkgMbUSo=;
 b=NqK8LMx+9hTxKq73IU/l2CJb78vmZL35snRiDsWctGToKjKu2pbDRWxNBgGiiKh+oB
 aociYihdinHe+1UZMVcC8fUQkxMNgWcj5lwIziAG5gQdmYjyFsZSkZ+pv0EOF2OU34TJ
 cQFSGb5Cy/3ANvLNaoaRSdXhi9mhs+MwqyoGugPmgQkC1tJgkvEJkVHKZoOcYEuS82PJ
 7I5x3IVuQ0ezBxw4F3ghiyZGGeZ1RiysTIJBMlpapXSQP3ntBZfAHfl6GEzhsJafaJCm
 RP/zhGJ5AzlWU/yFaLymYxNMyfpfF/OumSEgSh9+p6rgdz7o+wUi4hi7xxvOayzF5Zr+
 g/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704754583; x=1705359383;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RQ7tMiFUBZpc7a/GWseZV8JMPs0jLW4xfpFMkgMbUSo=;
 b=UvTBXgJfrdnYJ0szgDMS6XUUx6xMDLS2cYoRUH7rkpQ4gKeIjZUyxRjnltU1Fr7/Pk
 XQlVK52LQdqh67wqy10dwdtKHYzzUJ+M68H+X1kmina8HdMlQPMbA2+eDLS2yLGl6gxf
 dUKLFP9CIaqxun0nKw+BL+BdPLkroPLrekppZ4YRSJLriU1lVCtEg8Pv1vslSUdzyWNp
 BC7wISl0GqavTHSs5a6yAZtPdExTgZ1qbpjTtI0V/SCEoskze8bI+CojzojEW59g9z7I
 njm2gpYUQ/8jDCzUDRihel0Amgzr7n8KOYsWnYuC1R7AEnXtBP9Jr8wqIbzBbH6+Tlxj
 r6VA==
X-Gm-Message-State: AOJu0YwEuESRLEtM+R2cDNsM1lN8DK71ySVS0pD7mvq+20I6LtzOskh5
 QGnBiXboL9xUi2I9Ma55ZMDuMFwMCVo5QA==
X-Google-Smtp-Source: AGHT+IHXVrJWGYqZzCwFG8zgo3eB8ygbikrSQn9k11+kJMpr1AnF/LRoql7pCExc5adfzM4BwjxfZw==
X-Received: by 2002:adf:fb83:0:b0:336:c4c1:2d7d with SMTP id
 a3-20020adffb83000000b00336c4c12d7dmr40979wrr.60.1704754583222; 
 Mon, 08 Jan 2024 14:56:23 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.16])
 by smtp.gmail.com with ESMTPSA id
 bs7-20020a056000070700b003368100ff71sm770294wrb.10.2024.01.08.14.56.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 14:56:22 -0800 (PST)
Message-ID: <ec9af4db-5159-4123-ab91-eef3dbb82ed6@linaro.org>
Date: Mon, 8 Jan 2024 23:56:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] hw/misc: Implement STM32L4x5 EXTI
Content-Language: en-US
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240108181104.46880-1-ines.varhol@telecom-paris.fr>
 <20240108181104.46880-2-ines.varhol@telecom-paris.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240108181104.46880-2-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=unavailable autolearn_force=no
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

On 8/1/24 19:03, Inès Varhol wrote:
> Although very similar to the STM32F4xx EXTI, STM32L4x5 EXTI generates
> more than 32 event/interrupt requests and thus uses more registers
> than STM32F4xx EXTI which generates 23 event/interrupt requests.
> 
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
> 
> Should the for loop variables be `unsigned` rather than `int` ?

It depends on the iterated range. Here you iterate over
ARRAY_SIZE(Stm32l4x5ExtiState::irq) which is a size_t type,
which is unsigned. Amusingly we use both similarly:

$ git grep 'for (size_t' | wc -l
       56
$ git grep 'for (unsigned' | wc -l
       59

>   docs/system/arm/b-l475e-iot01a.rst |   5 +-
>   hw/misc/Kconfig                    |   3 +
>   hw/misc/meson.build                |   1 +
>   hw/misc/stm32l4x5_exti.c           | 292 +++++++++++++++++++++++++++++
>   hw/misc/trace-events               |   5 +
>   include/hw/misc/stm32l4x5_exti.h   |  51 +++++
>   6 files changed, 354 insertions(+), 3 deletions(-)
>   create mode 100644 hw/misc/stm32l4x5_exti.c
>   create mode 100644 include/hw/misc/stm32l4x5_exti.h
> 
> diff --git a/docs/system/arm/b-l475e-iot01a.rst b/docs/system/arm/b-l475e-iot01a.rst
> index 2b128e6b84..72f256ace7 100644
> --- a/docs/system/arm/b-l475e-iot01a.rst
> +++ b/docs/system/arm/b-l475e-iot01a.rst
> @@ -12,17 +12,16 @@ USART, I2C, SPI, CAN and USB OTG, as well as a variety of sensors.
>   Supported devices
>   """""""""""""""""
>   
> -Currently, B-L475E-IOT01A machine's implementation is minimal,
> -it only supports the following device:
> +Currently B-L475E-IOT01A machine's only supports the following devices:
>   
>   - Cortex-M4F based STM32L4x5 SoC
> +- STM32L4x5 EXTI (Extended interrupts and events controller)
>   
>   Missing devices
>   """""""""""""""
>   
>   The B-L475E-IOT01A does *not* support the following devices:
>   
> -- Extended interrupts and events controller (EXTI)
>   - Reset and clock control (RCC)
>   - Serial ports (UART)
>   - System configuration controller (SYSCFG)
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index cc8a8c1418..3efe3dc2cc 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -87,6 +87,9 @@ config STM32F4XX_SYSCFG
>   config STM32F4XX_EXTI
>       bool
>   
> +config STM32L4X5_EXTI
> +    bool
> +
>   config MIPS_ITU
>       bool
>   
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 36c20d5637..16db6e228d 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -110,6 +110,7 @@ system_ss.add(when: 'CONFIG_XLNX_VERSAL_TRNG', if_true: files(
>   system_ss.add(when: 'CONFIG_STM32F2XX_SYSCFG', if_true: files('stm32f2xx_syscfg.c'))
>   system_ss.add(when: 'CONFIG_STM32F4XX_SYSCFG', if_true: files('stm32f4xx_syscfg.c'))
>   system_ss.add(when: 'CONFIG_STM32F4XX_EXTI', if_true: files('stm32f4xx_exti.c'))
> +system_ss.add(when: 'CONFIG_STM32L4X5_EXTI', if_true: files('stm32l4x5_exti.c'))
>   system_ss.add(when: 'CONFIG_MPS2_FPGAIO', if_true: files('mps2-fpgaio.c'))
>   system_ss.add(when: 'CONFIG_MPS2_SCC', if_true: files('mps2-scc.c'))
>   
> diff --git a/hw/misc/stm32l4x5_exti.c b/hw/misc/stm32l4x5_exti.c
> new file mode 100644
> index 0000000000..aedf1fb370
> --- /dev/null
> +++ b/hw/misc/stm32l4x5_exti.c
> @@ -0,0 +1,292 @@
> +/*
> + * STM32L4x5 EXTI (Extended interrupts and events controller)
> + *
> + * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
> + * Copyright (c) 2023 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>
> + * Copyright (c) 2023 Inès Varhol <ines.varhol@telecom-paris.fr>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + * This work is based on the stm32f4xx_exti by Alistair Francis.
> + * Original code is licensed under the MIT License:
> + *
> + * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
> + */
> +
> +/*
> + * The reference used is the STMicroElectronics RM0351 Reference manual
> + * for STM32L4x5 and STM32L4x6 advanced Arm ® -based 32-bit MCUs.
> + * https://www.st.com/en/microcontrollers-microprocessors/stm32l4x5/documentation.html
> + */
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

   #define EXTI_MAX_IRQ_PER_BANK 32

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


You might want to declare:

   #define EXTI_IRQS_BANK0  32
   #define EXTI_IRQS_BANK1  8

   static const unsigned irqs_per_bank[EXTI_NUM_REGISTER] = {
       EXTI_IRQS_BANK0,
       EXTI_IRQS_BANK1,
   };

   static const uint32_t exti_romask[EXTI_NUM_REGISTER] = {
       0xff820000, /* 0b11111111_10000010_00000000_00000000 */
       0x00000087, /* 0b00000000_00000000_00000000_10000111 */
   };

And add descriptive helpers such:

static unsigned regbank_index_by_irq(unsigned irq)
{
     return irq >= EXTI_MAX_IRQ_PER_BANK ? 1 : 0;
}

static unsigned regbank_index_by_addr(hwaddr addr)
{
     return addr >= EXTI_IMR2 ? 1 : 0;
}

static unsigned valid_mask(unsigned bank)
{
     return MAKE_64BIT_MASK(0, irqs_per_bank[bank]);
}

(then see below)

> +static void stm32l4x5_exti_reset_hold(Object *obj)
> +{
> +    Stm32l4x5ExtiState *s = STM32L4X5_EXTI(obj);
> +
> +    s->imr[0] = DIRECT_LINE_MASK1;
> +    s->emr[0] = 0x00000000;
> +    s->rtsr[0] = 0x00000000;
> +    s->ftsr[0] = 0x00000000;
> +    s->swier[0] = 0x00000000;
> +    s->pr[0] = 0x00000000;
> +
> +    s->imr[1] = DIRECT_LINE_MASK2;
> +    s->emr[1] = 0x00000000;
> +    s->rtsr[1] = 0x00000000;
> +    s->ftsr[1] = 0x00000000;
> +    s->swier[1] = 0x00000000;
> +    s->pr[1] = 0x00000000;
> +}

BTW stm32l4x5_exti_reset_hold() can also be unified:

    static void stm32l4x5_exti_reset_hold(Object *obj)
    {
        Stm32l4x5ExtiState *s = STM32L4X5_EXTI(obj);

        for (unsigned bank = 0; bank < EXTI_NUM_REGISTER; bank++) {
            s->imr[bank] = exti_romask[bank];
            s->emr[bank] = 0;
            s->rtsr[bank] = 0;
            s->ftsr[bank] = 0;
            s->swier[bank] = 0;
            s->pr[bank] = 0;
        }
    }

> +static void stm32l4x5_exti_set_irq(void *opaque, int irq, int level)
> +{
> +    Stm32l4x5ExtiState *s = opaque;
> +    const unsigned n = irq >= 32;

Then:

       n = regbank_index_by_irq(irq);

Maybe 'bank' is a better variable name instead of 'n', in particular
in stm32l4x5_exti_read() it makes it clear registers behave identically
for each bank of registers.

> +    const int oirq = irq;
> +
> +    trace_stm32l4x5_exti_set_irq(irq, level);
> +
> +    if (irq >= 32) {
> +        /* Shift the value to enable access in x2 registers. */
> +        irq -= 32;
> +    }

Alternatively:

       irq %= EXTI_MAX_IRQ_PER_BANK;

> +    /* If the interrupt is masked, pr won't be raised */
> +    if (!((1 << irq) & s->imr[n])) {

Alternatively:

        if (!extract32(s->imr[n], irq, 1)) {

> +        return;
> +    }
> +
> +    if (((1 << irq) & s->rtsr[n]) && level) {
> +        /* Rising Edge */
> +        s->pr[n] |= 1 << irq;
> +        qemu_irq_pulse(s->irq[oirq]);
> +    } else if (((1 << irq) & s->ftsr[n]) && !level) {
> +        /* Falling Edge */
> +        s->pr[n] |= 1 << irq;
> +        qemu_irq_pulse(s->irq[oirq]);
> +    }

        else { // Can we get here?

> +}
> +
> +static uint64_t stm32l4x5_exti_read(void *opaque, hwaddr addr,
> +                                    unsigned int size)
> +{
> +    Stm32l4x5ExtiState *s = opaque;
> +    uint32_t r = 0;
> +    const unsigned n = addr >= EXTI_IMR2;

       bank = regbank_index_by_addr(addr);

> +
> +    switch (addr) {
> +    case EXTI_IMR1:
> +    case EXTI_IMR2:
> +        r = s->imr[n];
> +        break;
> +    case EXTI_EMR1:
> +    case EXTI_EMR2:
> +        r = s->emr[n];
> +        break;
> +    case EXTI_RTSR1:
> +    case EXTI_RTSR2:
> +        r = s->rtsr[n];
> +        break;
> +    case EXTI_FTSR1:
> +    case EXTI_FTSR2:
> +        r = s->ftsr[n];
> +        break;
> +    case EXTI_SWIER1:
> +    case EXTI_SWIER2:
> +        r = s->swier[n];
> +        break;
> +    case EXTI_PR1:
> +    case EXTI_PR2:
> +        r = s->pr[n];
> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "STM32L4X5_exti_read: Bad offset 0x%x\n", (int)addr);

Here you can avoid the cast by using the HWADDR_PRIx format.

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
> +    Stm32l4x5ExtiState *s = opaque;
> +    const uint32_t value = (uint32_t)val64;

I don't see the benefit of casting to 32-bits, besides we have
".valid.max_access_size = 4" so the caller always pass 32-bits.

> +
> +    trace_stm32l4x5_exti_write(addr, value);
> +
> +    switch (addr) {
> +    case EXTI_IMR1:
> +        s->imr[0] = value;
> +        return;

You can unify banks:

        case EXTI_IMR1:
        case EXTI_IMR2:
            s->imr[bank] = value & valid_mask(bank);
            return;

> +    case EXTI_EMR1:
> +        s->emr[0] = value;
> +        return;

        case EXTI_EMR1:
        case EXTI_EMR2:
            s->emr[bank] = value & valid_mask(bank);
            return;

> +    case EXTI_RTSR1:
> +        s->rtsr[0] = value & ~DIRECT_LINE_MASK1;
> +        return;

        case EXTI_RTSR1:
        case EXTI_RTSR2:
            s->rtsr[bank] = value & ~exti_romask[bank];
            return;

> +    case EXTI_FTSR1:
> +        s->ftsr[0] = value & ~DIRECT_LINE_MASK1;
> +        return;

        case EXTI_FTSR1:
        case EXTI_FTSR2:
            s->ftsr[bank] = value & ~exti_romask[bank];
            return;

> +    case EXTI_SWIER1: {
> +        const uint32_t set1 = value & ~DIRECT_LINE_MASK1;
> +        const uint32_t pend1 = set1 & ~s->swier[0] & s->imr[0] & ~s->pr[0];
> +        s->swier[0] = set1;
> +        s->pr[0] |= pend1;
> +        for (int i = 0; i < 32; i++) {
> +            if (pend1 & (1 << i)) {
> +                qemu_irq_pulse(s->irq[i]);
> +            }
> +        }
> +        return;

      case EXTI_SWIER1:
      case EXTI_SWIER2:
           set = value & ~exti_romask[bank];
           pend = set & ~s->swier[bank] & s->imr[bank] & ~s->pr[bank];
           s->swier[bank] = set;
           s->pr[bank] |= pend;
           for (unsigned i = 0; i < irqs_per_bank[bank]; i++) {
               if (pend & (1 << i)) { // or extract32()
                   qemu_irq_pulse(s->irq[i]);
               }
           }
           return;

> +    }
> +    case EXTI_PR1: {
> +        const uint32_t cleared1 = s->pr[0] & value & ~DIRECT_LINE_MASK1;
> +        /* This bit is cleared by writing a 1 to it */
> +        s->pr[0] &= ~cleared1;
> +        /* Software triggered interrupts are cleared as well */
> +        s->swier[0] &= ~cleared1;
> +        return;

Ditto.

> +    }
> +    case EXTI_IMR2:
> +        s->imr[1] = value & ~RESERVED_BITS_MASK2;
> +        return;
> +    case EXTI_EMR2:
> +        s->emr[1] = value & ~RESERVED_BITS_MASK2;
> +        return;
> +    case EXTI_RTSR2:
> +        s->rtsr[1] = value & ACTIVABLE_MASK2;
> +        return;
> +    case EXTI_FTSR2:
> +        s->ftsr[1] = value & ACTIVABLE_MASK2;
> +        return;
> +    case EXTI_SWIER2: {
> +        const uint32_t set2 = value & ACTIVABLE_MASK2;
> +        const uint32_t pend2 = set2 & ~s->swier[1] & s->imr[1] & ~s->pr[1];
> +        s->swier[1] = set2;
> +        s->pr[1] |= pend2;
> +        for (int i = 0; i < 8; i++) {
> +            if (pend2 & (1 << i)) {
> +                qemu_irq_pulse(s->irq[32 + i]);
> +            }
> +        }
> +        return;
> +    }
> +    case EXTI_PR2: {
> +        const uint32_t cleared = s->pr[1] & value & ACTIVABLE_MASK2;
> +        /* This bit is cleared by writing a 1 to it */
> +        s->pr[1] &= ~cleared;
> +        /* Software triggered interrupts are cleared as well */
> +        s->swier[1] &= ~cleared;
> +        return;
> +    }
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "STM32L4X5_exti_write: Bad offset 0x%x\n", (int)addr);
> +    }
> +}
> +
> +static const MemoryRegionOps stm32l4x5_exti_ops = {
> +    .read = stm32l4x5_exti_read,
> +    .write = stm32l4x5_exti_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .impl.min_access_size = 4,
> +    .impl.max_access_size = 4,
> +    .impl.unaligned = false,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,
> +    .valid.unaligned = false,
> +};

Code totally untested =)

Regards,

Phil.

