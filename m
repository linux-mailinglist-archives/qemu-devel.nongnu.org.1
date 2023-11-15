Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 876427ED62F
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 22:47:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Nic-00008v-2k; Wed, 15 Nov 2023 16:46:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3NiW-00008Q-W3
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 16:46:37 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3NiU-0002Uc-8D
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 16:46:36 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32fb1c35fe0so89712f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 13:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700084792; x=1700689592; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IkwgAPFqJrJdyc+JLc/0HNzASdbUhI6QQiXEGMmpZEU=;
 b=tF9nsGR9mZncRyzYK4xvKLRkgVFN49ftEnuZ2xjZziFlgOKS7h+930p7jOH8ujIoSW
 /gUdHkLuBfui1JAyHc+IWPXrJilJiEzaQzsB02sBTjPDqTe5jehAbqya++3FXvSG1Lbw
 024H7iJ3mXNzZLEe0b59liZzh6ivwi1sbjidi33edjeNtRHChZFcSF0JbpOGt+9Rx5fI
 PP+ZRVCj+ld+k+HdF9J9fMPLma48daToN8MdIJbmi+30DFsupnAg1H1BhtFdtPEnQhjb
 Ne3kUejvlnJ1A8Xjab5ReXG7e9CBAQs10jeiGLM6moUpAiHnu+8PluBLxMGB8f3D23Pn
 +KZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700084792; x=1700689592;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IkwgAPFqJrJdyc+JLc/0HNzASdbUhI6QQiXEGMmpZEU=;
 b=NFkHL2zDqREUXbKSEu9AZxt6+RLZH76efYxFHBcUnhBWEOyhf5TsoYAW4OvjD0WyA4
 Yy5Wsdpzqq6CU/nbsee568LXb7sRkyXWuL59qlcAHHAKSaZzAebjuBKi9/2qptkOomlT
 LJqy4CPmspdo3QhE8slE/hwuhlsNE4geDFTbHn68F8RsyPkOy2TcTAz348BGwRZa44H+
 KO/EbDlacvFaZsTs8LI42InNm/vU7ggDF3gDT2H2zJKPXfr4IuV9iF6VRR4bIA8AxxJn
 Xyt00rJTD07QhzW7ZlbhZwOAKnK1Uma3l0ITTSdv+WEePtr4uyzvPQWm/y/S8/+Tcpw9
 y3Tg==
X-Gm-Message-State: AOJu0YxTw1guHSYFmtPiCiaRX4RblCWRMUAhV3fEi4okX1uxTgrDP6T0
 HL65cXfYS+RHbrQDwN1yPKY3t54f4vBIbgMN8ww=
X-Google-Smtp-Source: AGHT+IHgw/UNr9QVsgeVb8rFu6DXgCpvgRRxu7eqClshwqSq/tk8nRbvZYCMaTonRJ4s5mvHmn0jcA==
X-Received: by 2002:adf:f048:0:b0:32d:6031:2824 with SMTP id
 t8-20020adff048000000b0032d60312824mr10822617wro.24.1700084792185; 
 Wed, 15 Nov 2023 13:46:32 -0800 (PST)
Received: from [192.168.69.100] ([176.176.130.62])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a5d48c1000000b0032fdcbfb093sm11564727wrs.81.2023.11.15.13.46.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 13:46:31 -0800 (PST)
Message-ID: <f3e08b1c-de71-4394-8617-db21dceaf5e7@linaro.org>
Date: Wed, 15 Nov 2023 22:46:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] hw/arm: Add minimal support for the STM32L475VG
 SoC
Content-Language: en-US
To: ~inesvarhol <inesvarhol@proton.me>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm <qemu-arm@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>
References: <170003673257.14701.8139061802716120109-1@git.sr.ht>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <170003673257.14701.8139061802716120109-1@git.sr.ht>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Hi Inès,

On 15/11/23 08:59, ~inesvarhol wrote:
> From: Inès Varhol <ines.varhol@telecom-paris.fr>
> 
> This patch adds a new STM32L475VG SoC, it is necessary to add support for
> the B-L475E-IOT01A board.

Thanks for your first contribution! See my comments inline.

> The implementation is derived from the STM32F405 SoC.

You might want to Cc the STM32F405 maintainer to get more reviewers
(doing that for you).

$ ./scripts/get_maintainer.pl -f hw/arm/stm32f405_soc.c
Alistair Francis <alistair@alistair23.me> (maintainer:STM32F405)
Peter Maydell <peter.maydell@linaro.org> (maintainer:STM32F405)
qemu-arm@nongnu.org (open list:STM32F405)
qemu-devel@nongnu.org (open list:All patches CC here)

Also, do not forget to Cc the qemu-arm@nongnu.org list which
is almost a subset of qemu-devel@ subscribers.

> The implementation contains no peripherals, only memory regions are
> implemented.
> 
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   hw/arm/Kconfig                   |   5 +
>   hw/arm/meson.build               |   1 +
>   hw/arm/stm32l475vg_soc.c         | 241 +++++++++++++++++++++++++++++++
>   include/hw/arm/stm32l475vg_soc.h |  60 ++++++++
>   4 files changed, 307 insertions(+)
>   create mode 100644 hw/arm/stm32l475vg_soc.c
>   create mode 100644 include/hw/arm/stm32l475vg_soc.h
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 3ada335a24..763510afeb 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -448,6 +448,11 @@ config STM32F405_SOC
>       select STM32F4XX_SYSCFG
>       select STM32F4XX_EXTI
>   
> +config STM32L475VG_SOC
> +    bool
> +    select ARM_V7M
> +    select OR_IRQ
> +
>   config XLNX_ZYNQMP_ARM
>       bool
>       default y if PIXMAN
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 68245d3ad1..6b2e1228e5 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -42,6 +42,7 @@ arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2836.c', 'raspi.c'))
>   arm_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
>   arm_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
>   arm_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c'))
> +arm_ss.add(when: 'CONFIG_STM32L475VG_SOC', if_true: files('stm32l475vg_soc.c'))

"V" refers to the packaging. This SoC can be encapsulated in multiple
formats, for example as 64-pin LQFP or as 100-pin.

For QEMU the packaging is irrelevant, so you can strip the -V suffix.

"G" refers to the flash/sram size (here 1 MiB / 320 KiB).
With few more lines we can support the "C" (256 KiB / 128 KiB) and "E"
(512 / 128).

(See for example how hw/avr/atmega.c uses a class_init() method to
set the flash_size/sram_size values for the different SoC it models).
(I'm not asking to do that now, just giving you references. This can
be done later on top).

This SoC is from the USB OTG lines family, maybe better name it
generically as STM32L4x5, so we can reuse the base class for the
whole family?

>   arm_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqmp.c', 'xlnx-zcu102.c'))
>   arm_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal.c', 'xlnx-versal-virt.c'))
>   arm_ss.add(when: 'CONFIG_FSL_IMX25', if_true: files('fsl-imx25.c', 'imx25_pdk.c'))
> diff --git a/hw/arm/stm32l475vg_soc.c b/hw/arm/stm32l475vg_soc.c
> new file mode 100644
> index 0000000000..7dd5d70eb3
> --- /dev/null
> +++ b/hw/arm/stm32l475vg_soc.c
> @@ -0,0 +1,241 @@
> +/*
> + * STM32L475VG SoC
> + *
> + * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
> + * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
> + * Copyright (c) 2023 Inès Varhol <ines.varhol@telecom-paris.fr>
> + *

Consider including a SPDX tag which is easier to process than a full
license:

  * SPDX-License-Identifier: MIT

> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "exec/address-spaces.h"
> +#include "sysemu/sysemu.h"
> +#include "hw/arm/stm32l475vg_soc.h"
> +#include "hw/qdev-clock.h"
> +#include "hw/misc/unimp.h"
> +
> +/* stm32l475vg_soc implementation is derived from stm32f405_soc */
> +
> +static void stm32l475vg_soc_initfn(Object *obj)
> +{
> +    STM32L475VGState *s = STM32L475VG_SOC(obj);
> +
> +    object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);

Since you only "forward" the 'cpu-type' property from the board to
the ARM core, you can do:

        object_property_add_alias(obj, "cpu-type",
                                  OBJECT(&s->armv7m), "cpu-type");

So the board code setting this property directly sets the core cpu type,
and you don't need to register any stm32l475vg_soc_properties[].

*But* this SoC family can only accept Cortex-M4 cores. Better would be
to hardcode the type previous to the realize call, instead of letting
the board code decide which CPU type to use. Also we could check at the
SoC level that the board CPU type requested is really a Cortex-M4,
returning an error otherwise.

I see you follow the template from hw/arm/netduino2.c. Hmm OK then,
no need to over-engineer at this point.

> +    s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
> +    s->refclk = qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0);
> +}
> +
> +static void stm32l475vg_soc_realize(DeviceState *dev_soc, Error **errp)
> +{
> +    STM32L475VGState *s = STM32L475VG_SOC(dev_soc);
> +    MemoryRegion *system_memory = get_system_memory();

Note for myself, this SoC aperture is 4GiB. get_system_memory() is
wider. Not an issue.

> +    DeviceState *armv7m;
> +    Error *err = NULL;

Using the ERRP_GUARD() macro is safer. See include/qapi/error.h.

> +
> +    /*
> +     * We use s->refclk internally and only define it with qdev_init_clock_in()
> +     * so it is correctly parented and not leaked on an init/deinit; it is not
> +     * intended as an externally exposed clock.
> +     */
> +    if (clock_has_source(s->refclk)) {
> +        error_setg(errp, "refclk clock must not be wired up by the board code");
> +        return;
> +    }
> +
> +    if (!clock_has_source(s->sysclk)) {
> +        error_setg(errp, "sysclk clock must be wired up by the board code");
> +        return;
> +    }
> +
> +    /*
> +     * TODO: ideally we should model the SoC RCC and its ability to
> +     * change the sysclk frequency and define different sysclk sources.
> +     */
> +
> +    /* The refclk always runs at frequency HCLK / 8 */
> +    clock_set_mul_div(s->refclk, 8, 1);
> +    clock_set_source(s->refclk, s->sysclk);
> +
> +    memory_region_init_rom(&s->flash, OBJECT(dev_soc), "STM32L475VG.flash",

Just name it "flash" as in datasheet.

> +                           FLASH_SIZE, &err);
> +    if (err != NULL) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    memory_region_init_alias(&s->flash_alias, OBJECT(dev_soc),
> +                             "STM32L475VG.flash.alias", &s->flash, 0,

"flash_boot_alias".

> +                             FLASH_SIZE);
> +
> +    memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->flash);
> +    memory_region_add_subregion(system_memory, 0, &s->flash_alias);
> +
> +    memory_region_init_ram(&s->sram1, NULL, "STM32L475VG.sram1", SRAM1_SIZE,

Why NULL and not OBJECT(dev_soc) like for the flash earlier?

> +                           &err);

"SRAM1".

> +    if (err != NULL) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    memory_region_add_subregion(system_memory, SRAM1_BASE_ADDRESS, &s->sram1);
> +
> +    memory_region_init_ram(&s->sram2, NULL, "STM32L475VG.sram2", SRAM2_SIZE,

Ditto OBJECT(dev_soc) parent.

> +                           &err);

"SRAM2"

> +    if (err != NULL) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    memory_region_add_subregion(system_memory, SRAM2_BASE_ADDRESS, &s->sram2);
> +
> +    armv7m = DEVICE(&s->armv7m);
> +    qdev_prop_set_uint32(armv7m, "num-irq", 96);
> +    qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);

This SoC family can only accept Cortex-M4 cores. Better would be to
hardcode it here. Hmm I see, the code you used as template,
hw/arm/netduino2.c, do the same. OK.

> +    qdev_prop_set_bit(armv7m, "enable-bitband", true);
> +    qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
> +    qdev_connect_clock_in(armv7m, "refclk", s->refclk);
> +    object_property_set_link(OBJECT(&s->armv7m), "memory",
> +                             OBJECT(system_memory), &error_abort);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
> +        return;
> +    }
> +
> +    /* APB1 BUS */
> +    create_unimplemented_device("TIM2",      0x40000000, 0x400);
> +    create_unimplemented_device("TIM3",      0x40000400, 0x400);
> +    create_unimplemented_device("TIM4",      0x40000800, 0x400);
> +    create_unimplemented_device("TIM5",      0x40000C00, 0x400);
> +    create_unimplemented_device("TIM6",      0x40001000, 0x400);
> +    create_unimplemented_device("TIM7",      0x40001400, 0x400);
> +    /* RESERVED:    0x40001800, 0x1000 */
> +    create_unimplemented_device("RTC",       0x40002800, 0x400);
> +    create_unimplemented_device("WWDG",      0x40002C00, 0x400);
> +    create_unimplemented_device("IWDG",      0x40003000, 0x400);
> +    /* RESERVED:    0x40001800, 0x400 */
> +    create_unimplemented_device("SPI2",      0x40003800, 0x400);
> +    create_unimplemented_device("SPI3",      0x40003C00, 0x400);
> +    /* RESERVED:    0x40004000, 0x400 */
> +    create_unimplemented_device("USART2",    0x40004400, 0x400);
> +    create_unimplemented_device("USART3",    0x40004800, 0x400);
> +    create_unimplemented_device("UART4",     0x40004C00, 0x400);
> +    create_unimplemented_device("UART5",     0x40005000, 0x400);
> +    create_unimplemented_device("I2C1",      0x40005400, 0x400);
> +    create_unimplemented_device("I2C2",      0x40005800, 0x400);
> +    create_unimplemented_device("I2C3",      0x40005C00, 0x400);
> +    /* RESERVED:    0x40006000, 0x400 */
> +    create_unimplemented_device("CAN1",      0x40006400, 0x400);
> +    /* RESERVED:    0x40006800, 0x400 */
> +    create_unimplemented_device("PWR",       0x40007000, 0x400);
> +    create_unimplemented_device("DAC1",      0x40007400, 0x400);
> +    create_unimplemented_device("OPAMP",     0x40007800, 0x400);
> +    create_unimplemented_device("LPTIM1",    0x40007C00, 0x400);
> +    create_unimplemented_device("LPUART1",   0x40008000, 0x400);
> +    /* RESERVED:    0x40008400, 0x400 */
> +    create_unimplemented_device("SWPMI1",    0x40008800, 0x400);
> +    /* RESERVED:    0x40008C00, 0x800 */
> +    create_unimplemented_device("LPTIM2",    0x40009400, 0x400);
> +    /* RESERVED:    0x40009800, 0x6800 */
> +
> +    /* APB2 BUS */
> +    create_unimplemented_device("SYSCFG",    0x40010000, 0x30);
> +    create_unimplemented_device("VREFBUF",   0x40010030, 0x1D0);
> +    create_unimplemented_device("COMP",      0x40010200, 0x200);
> +    create_unimplemented_device("EXTI",      0x40010400, 0x400);
> +    /* RESERVED:    0x40010800, 0x1400 */
> +    create_unimplemented_device("FIREWALL",  0x40011C00, 0x400);
> +    /* RESERVED:    0x40012000, 0x800 */
> +    create_unimplemented_device("SDMMC1",    0x40012800, 0x400);
> +    create_unimplemented_device("TIM1",      0x40012C00, 0x400);
> +    create_unimplemented_device("SPI1",      0x40013000, 0x400);
> +    create_unimplemented_device("TIM8",      0x40013400, 0x400);
> +    create_unimplemented_device("USART1",    0x40013800, 0x400);
> +    /* RESERVED:    0x40013C00, 0x400 */
> +    create_unimplemented_device("TIM15",     0x40014000, 0x400);
> +    create_unimplemented_device("TIM16",     0x40014400, 0x400);
> +    create_unimplemented_device("TIM17",     0x40014800, 0x400);
> +    /* RESERVED:    0x40014C00, 0x800 */
> +    create_unimplemented_device("SAI1",      0x40015400, 0x400);
> +    create_unimplemented_device("SAI2",      0x40015800, 0x400);
> +    /* RESERVED:    0x40015C00, 0x400 */
> +    create_unimplemented_device("DFSDM1",    0x40016000, 0x400);
> +    /* RESERVED:    0x40016400, 0x9C00 */
> +
> +    /* AHB1 BUS */
> +    create_unimplemented_device("DMA1",      0x40020000, 0x400);
> +    create_unimplemented_device("DMA2",      0x40020400, 0x400);
> +    /* RESERVED:    0x40020800, 0x800 */
> +    create_unimplemented_device("RCC",       0x40021000, 0x400);
> +    /* RESERVED:    0x40021400, 0xC00 */
> +    create_unimplemented_device("FLASH",     0x40022000, 0x400);
> +    /* RESERVED:    0x40022400, 0xC00 */
> +    create_unimplemented_device("CRC",       0x40023000, 0x400);
> +    /* RESERVED:    0x40023400, 0x400 */
> +    create_unimplemented_device("TSC",       0x40024000, 0x400);
> +
> +    /* RESERVED:    0x40024400, 0x7FDBC00 */
> +
> +    /* AHB2 BUS */
> +    create_unimplemented_device("GPIOA",     0x48000000, 0x400);
> +    create_unimplemented_device("GPIOB",     0x48000400, 0x400);
> +    create_unimplemented_device("GPIOC",     0x48000800, 0x400);
> +    create_unimplemented_device("GPIOD",     0x48000C00, 0x400);
> +    create_unimplemented_device("GPIOE",     0x48001000, 0x400);
> +    create_unimplemented_device("GPIOF",     0x48001400, 0x400);
> +    create_unimplemented_device("GPIOG",     0x48001800, 0x400);
> +    create_unimplemented_device("GPIOH",     0x48001C00, 0x400);
> +    /* RESERVED:    0x48002000, 0x7FDBC00 */
> +    create_unimplemented_device("OTG_FS",    0x50000000, 0x40000);
> +    create_unimplemented_device("ADC",       0x50040000, 0x400);
> +    /* RESERVED:    0x50040400, 0x20400 */
> +    create_unimplemented_device("RNG",       0x50060800, 0x400);
> +
> +    /* AHB3 BUS */
> +    create_unimplemented_device("FMC",       0xA0000000, 0x1000);
> +    create_unimplemented_device("QUADSPI",   0xA0001000, 0x400);
> +}
> +
> +static Property stm32l475vg_soc_properties[] = {
> +    DEFINE_PROP_STRING("cpu-type", STM32L475VGState, cpu_type),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void stm32l475vg_soc_class_init(ObjectClass *klass, void *data)
> +{
> +
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = stm32l475vg_soc_realize;
> +    device_class_set_props(dc, stm32l475vg_soc_properties);
> +    /* No vmstate or reset required: device has no internal state */
> +}
> +
> +static const TypeInfo stm32l475vg_soc_info = {
> +    .name          = TYPE_STM32L475VG_SOC,
> +    .parent        = TYPE_DEVICE,
> +    .instance_size = sizeof(STM32L475VGState),
> +    .instance_init = stm32l475vg_soc_initfn,
> +    .class_init    = stm32l475vg_soc_class_init,
> +};
> +
> +static void stm32l475vg_soc_register_types(void)
> +{
> +    type_register_static(&stm32l475vg_soc_info);
> +}
> +
> +type_init(stm32l475vg_soc_register_types)

Although for a single TypeInfo entry there is no difference,
DEFINE_TYPES() is preferred over type_init().

> diff --git a/include/hw/arm/stm32l475vg_soc.h b/include/hw/arm/stm32l475vg_soc.h
> new file mode 100644
> index 0000000000..a224cb6384
> --- /dev/null
> +++ b/include/hw/arm/stm32l475vg_soc.h
> @@ -0,0 +1,60 @@
> +/*
> + * STM32L475VG SoC

"STM32L4x5 SoC family"

> + *
> + * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
> + * Copyright (c) 2023 Inès Varhol <ines.varhol@telecom-paris.fr>
> + *

Again SPDX tag if possible.

> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef HW_ARM_STM32L475VG_SOC_H
> +#define HW_ARM_STM32L475VG_SOC_H
> +
> +#include "hw/arm/armv7m.h"
> +#include "qom/object.h"

You also need to include "hw/qdev-core.h" and "exec/memory.h"
to get the DeviceState and MemoryRegion definitions, because
STM32L475VGState uses these types.

For Clock* we don't need anything because it is forward declared
by "qemu/typedefs.h", which all QEMU source files already include.

> +#define TYPE_STM32L475VG_SOC "stm32l475vg-soc"
> +OBJECT_DECLARE_SIMPLE_TYPE(STM32L475VGState, STM32L475VG_SOC)
> +
> +#define FLASH_BASE_ADDRESS 0x08000000
> +#define FLASH_SIZE (1024 * 1024)
> +#define SRAM1_BASE_ADDRESS 0x20000000
> +#define SRAM1_SIZE (96 * 1024)
> +#define SRAM2_BASE_ADDRESS 0x10000000
> +#define SRAM2_SIZE (32 * 1024)

These definitions are specific to the SoC. No code out of the SoC should
require them, so no need to expose them. Better keep them local in the
stm32l4x5xx_soc.c source file.

> +struct STM32L475VGState {
> +    /*< private >*/
> +    DeviceState parent_obj;
> +    /*< public >*/

Please remove these <private/public> lines, we try to not use them
anymore.

> +    char *cpu_type;
> +
> +    ARMv7MState armv7m;
> +
> +    MemoryRegion sram1;
> +    MemoryRegion sram2;
> +    MemoryRegion flash;
> +    MemoryRegion flash_alias;
> +
> +    Clock *sysclk;
> +    Clock *refclk;
> +};
> +
> +#endif

Very good first contribution, I'm glad you posted it :)

I mostly asked for minor style change. Looking for your
next iteration!

Regards,

Phil.

