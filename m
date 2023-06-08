Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 697397280FE
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:17:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FU1-0001Wx-C2; Thu, 08 Jun 2023 09:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7FTx-0001W7-SG
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:15:17 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7FTu-0000jD-Vv
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:15:17 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5151934a4e3so896887a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 06:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686230112; x=1688822112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ndFdePHwJt8km/rx80WSJ7Cy25VXSqurfdXMlOHSND4=;
 b=C9tG86FxIKUdQqEZUKnZoGDclIhDhuLJU6KlNy86R5kpNNFN/22YXSlF1NQBZ5ky9R
 aUk4RPV5LS/TidLhldpaEWxwhU4umSkY4J4bBnD+ep1SKXW24z/rAupaUOjYL/XMqITz
 0emVaO52UOJQJqGV2H6YmxHYbtR8gcSkX9oND3XFfsB78rK6xfplCbWZgfsNSezkRsQr
 yOn2IFqFKyZzeNnoe5lc/i2aGpSNNjEGn9V5KmefIdrOY1HdLao8VKC23xiU9oY+0sbC
 FY/k+4AR8l0en9sRJe/HxCgoAbjouwLBOJSRw+dZpvIb/XM5KiMXWxznZG1sKbDmQQer
 /fGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686230112; x=1688822112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ndFdePHwJt8km/rx80WSJ7Cy25VXSqurfdXMlOHSND4=;
 b=LlyvFeOpQGPysoNQ66C0uN8ypEm7qX4AyTQ69oi74m0b3k82qzumLpKGks54hxMT27
 tezfwOtF+IBxFh9ouy2gIKL8dPXmMeOIhfAYmHOclpnI8qHe4hagT1tGBUs5DaTTPbku
 fpIYo9YPjkIfQK7fvynE2ygVPhfGwUOd9oEUkE6MFztkRCJByBh0jGkXAB6aSYDBpunA
 zKM13vWCRUzhytGTOtuHiTDXqWIv5hfV6FWODIi8Au+KTlNUhzK0+DW73E7Fr/fmceXS
 jqZxcRwUEOzFpwvxdotcqvIU4dzIAn2Aun+9N4IjfjfaItBEmIT1ofdqO7hWao2/3PW3
 dIKA==
X-Gm-Message-State: AC+VfDy68TXKO7nVOum6NB+dMz/MGEoLthBQlbCJc8qrefywwq9geXtB
 7DANmQFigg9gnCdTr7k7wMoa0E9XEV7BHROHItUpgA==
X-Google-Smtp-Source: ACHHUZ5NmdD6TJd3WOgGrX5KbcFdbK3a8E9rK93U6gVHbwDNsL854BlRxmSISOUDAc35gmIREnm2U2bV2kcTwhNJbSQ=
X-Received: by 2002:a05:6402:6c6:b0:50b:d75d:3155 with SMTP id
 n6-20020a05640206c600b0050bd75d3155mr7932429edy.37.1686230112422; Thu, 08 Jun
 2023 06:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230517081204.30333-1-m.elsayed4420@gmail.com>
 <20230517081204.30333-2-m.elsayed4420@gmail.com>
In-Reply-To: <20230517081204.30333-2-m.elsayed4420@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Jun 2023 14:15:01 +0100
Message-ID: <CAFEAcA_0uEPuTKKGbaRNN4ytUzSaNbyP+GyHHCL-m8zhDRvdGg@mail.gmail.com>
Subject: Re: [PATCH 1/8] The tivac board initial machine definition
To: Mohamed ElSayed <m.elsayed4420@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Wed, 17 May 2023 at 09:13, Mohamed ElSayed <m.elsayed4420@gmail.com> wrote:
>
> Signed-off-by: Mohamed ElSayed <m.elsayed4420@gmail.com>
> ---
>  hw/arm/tivac.c                    |  56 ++++++
>  hw/arm/tm4c123gh6pm_soc.c         | 275 ++++++++++++++++++++++++++++++
>  include/hw/arm/tm4c123gh6pm_soc.h |  71 ++++++++
>  3 files changed, 402 insertions(+)
>  create mode 100644 hw/arm/tivac.c
>  create mode 100644 hw/arm/tm4c123gh6pm_soc.c
>  create mode 100644 include/hw/arm/tm4c123gh6pm_soc.h

Hi; thanks for this patchseries; sorry it's taken me a while
to get to reviewing it.

A note on patch series order -- generally the patch adding
the board model goes last, because otherwise it's just dead
code not being compiled. If you put it at the end of the series
then the patch adding it can also add it to the meson.build file.

>
> diff --git a/hw/arm/tivac.c b/hw/arm/tivac.c
> new file mode 100644
> index 0000000000..5d917a8f9e
> --- /dev/null
> +++ b/hw/arm/tivac.c
> @@ -0,0 +1,56 @@
> +/*
> + * TivaC Board Implementation
> + *
> + * Copyright (c) 2023 Mohamed ElSayed <m.elsayed4420@gmail.com>
> + *
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

It's usually a good idea to have a comment here with the URL of
the documentation of the hardware, in this case
https://www.ti.com/tool/EK-TM4C123GXL . I know you've put that
in the docs, but often developers look at the sources first,
so having it in both places is handy.



> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/boards.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/qdev-clock.h"
> +#include "qemu/error-report.h"
> +#include "hw/arm/tm4c123gh6pm_soc.h"
> +#include "hw/arm/boot.h"
> +
> +
> +/* Main SYSCLK frequency in Hz (24MHz) */
> +#define SYSCLK_FRQ 24000000ULL

Where has this number come from? The docs suggest the SoC runs
at 80MHz. It seems like the SoC doesn't support the board
giving it a non-standard external clock, though, so better
to just do all the clock logic inside the SoC model.

> +
> +static void tivac_init(MachineState *machine)
> +{
> +    DeviceState *dev;
> +    dev = qdev_new(TYPE_TM4C123GH6PM_SOC);
> +
> +    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));

Assuming the SoC is always a Cortex-M4, you don't really
need the machinery to set the CPU type from the board model:
you can just hard-wire it as an M4 in the SoC model.

> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    armv7m_load_kernel(ARM_CPU(first_cpu),
> +            machine->kernel_filename,
> +            0, FLASH_SIZE);

The indentation here is a bit off -- our style generally lines up
subsequent lines with the part inside the brackets in the first line,
so here the 'm' and '0' should line up with the 'A'.

More generally, scripts/checkpatch.pl will do some style checks
on your patches. It doesn't catch everything (it didn't catch
this, for instance), and sometimes it warns about things that
aren't really style issues because it misparses the C code,
so you need to be a bit cautious in interpreting its output,
but it's a good thing to get in the habit of running.

> +}
> +
> +static void tivac_machine_init(MachineClass *mc)
> +{
> +    mc->desc = "Tiva C (Cortex-M4)";
> +    mc->init = tivac_init;
> +}
> +DEFINE_MACHINE("tivac", tivac_machine_init)

Looking at the TI website, "Tiva C Series" seems to be TI's name
for the whole series of microcontrollers, not for the specific
evaluation board. This board seems to be called the
EK-TM4C123GXL or the "TM4C123G LaunchPad Evaluation Board".
I think the board name (and correspondingly the source file
name, etc) should be something matching the hardware board name.
(TI might put out some other Tiva C series evaluation board
or boards that we might want to model in future, so we shouldn't
use an over-generic name here.) The board PDF calls it a
"Tiva C Series LaunchPad" so perhaps something like that would
do if you don't want the rather unmemorable product number in it.
(Other boards in the series seem to include the "Connected
LaunchPad" and the "Crypto Connected LaunchPad", so we're
probably OK assuming the product number alone won't be used
as a differentiator.)

> diff --git a/hw/arm/tm4c123gh6pm_soc.c b/hw/arm/tm4c123gh6pm_soc.c
> new file mode 100644
> index 0000000000..3e61911bba
> --- /dev/null
> +++ b/hw/arm/tm4c123gh6pm_soc.c
> @@ -0,0 +1,275 @@
> +/*
> + * TM4C123GH6PM SoC
> + *
> + * Copyright (c) 2023 Mohamed ElSayed <m.elsayed4420@gmail.com>
> + *
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
> +#include "qemu/module.h"
> +#include "hw/arm/boot.h"

Do you really need boot.h here?

> +#include "exec/address-spaces.h"
> +#include "hw/arm/tm4c123gh6pm_soc.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/qdev-clock.h"
> +#include "hw/misc/unimp.h"
> +#include "sysemu/sysemu.h"
> +
> +static const uint32_t gpio_addrs[GPIO_COUNT] = {
> +    0x40004000,
> +    0x40005000,
> +    0x40006000,
> +    0x40007000,
> +    0x40024000,
> +    0x40025000
> +};
> +
> +static const uint32_t usart_addrs[USART_COUNT] = {
> +    0x4000C000,
> +    0x4000D000,
> +    0x4000E000,
> +    0x4000F000,
> +    0x40010000,
> +    0x40011000,
> +    0x40012000,
> +    0x40013000
> +};
> +
> +static const uint32_t wdt_addrs[WDT_COUNT] = {
> +    0x40000000,
> +    0x40001000
> +};
> +
> +static const uint32_t gptm_addrs[GPTM_COUNT] = {
> +    0x40030000,
> +    0x40031000,
> +    0x40032000,
> +    0x40033000,
> +    0x40034000,
> +    0x40035000,
> +    0x40036000,
> +    0x40037000,
> +    0x4003C800,
> +    0x4003D000,
> +    0x4003E000,
> +    0x4003F000,
> +};
> +
> +static const uint16_t usart_irqs[USART_COUNT] = {5, 6, 33, 59, 60, 61, 62, 63};
> +static const uint16_t gpio_irqs[GPIO_COUNT] = {0, 1, 2, 3, 4, 30};
> +static const uint16_t wdt_irqs[WDT_COUNT] = {18, 18};
> +static const uint16_t gptm_irqs[GPTM_COUNT * 2] = {
> +    19, 20, 21, 22, 23, 24, 35, 36, 70, 71, 92, 93,
> +    94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105};
> +
> +static void tm4c123gh6pm_soc_initfn(Object *obj)
> +{
> +    int i;
> +    TM4C123GH6PMState *s = TM4C123GH6PM_SOC(obj);
> +
> +    object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
> +    object_initialize_child(obj, "sysctl", &s->sysctl, TYPE_TM4C123_SYSCTL);
> +
> +    for (i = 0; i < USART_COUNT; i++) {
> +        object_initialize_child(obj, "usart[*]",
> +                                &s->usart[i], TYPE_TM4C123_USART);
> +    }
> +
> +    for (i = 0; i < GPIO_COUNT; i++) {
> +        object_initialize_child(obj, "gpio[*]", &s->gpio[i], TYPE_TM4C123_GPIO);
> +    }
> +
> +    for (i = 0; i < WDT_COUNT; i++) {
> +        object_initialize_child(obj, "watchdog-timer[*]",
> +                                &s->wdt[i], TYPE_TM4C123_WATCHDOG);
> +    }
> +
> +    for (i = 0; i < GPTM_COUNT; i++) {
> +        object_initialize_child(obj, "gptm[*]", &s->gptm[i], TYPE_TM4C123_GPTM);
> +    }
> +}
> +
> +static void tm4c123gh6pm_soc_realize(DeviceState *dev_soc, Error **errp)
> +{
> +    TM4C123GH6PMState *s = TM4C123GH6PM_SOC(dev_soc);
> +    DeviceState *armv7m;
> +    DeviceState *dev;
> +    SysBusDevice *busdev;
> +    int i;
> +
> +    MemoryRegion *system_memory = get_system_memory();
> +
> +    /* init flash memory */
> +    memory_region_init_rom(
> +            &s->flash, OBJECT(dev_soc),
> +            "TM4C123GH6PM.flash", FLASH_SIZE, &error_fatal
> +            );

This is weirdly indented -- generally don't put a newline immediately
after the opening bracket, and don't put the closing bracket on a line
of its own.

> +    memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->flash);
> +
> +    /* init sram and the sram alias region */
> +    memory_region_init_ram(
> +            &s->sram, OBJECT(dev_soc),
> +            "TM4C123GH6PM.sram", SRAM_SIZE, &error_fatal);
> +    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, &s->sram);

The comment says there's an SRAM alias region, but the code doesn't
create one...

> +
> +    /* Init ARMv7m */
> +    armv7m = DEVICE(&s->armv7m);
> +    qdev_prop_set_uint32(armv7m, "num-irq", 138);
> +    qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
> +    qdev_prop_set_bit(armv7m, "enable-bitband", true);
> +    qdev_connect_clock_in(armv7m, "cpuclk", s->sysctl.mainclk);
> +    qdev_connect_clock_in(armv7m, "refclk", s->sysctl.mainclk);

The SoC docs say the systick is connected to
 * the system clock
 * the PIOSC / 4  (which will be 4MHz)
(which one is used depending on STCTRL.CLK_SRC).
So you don't want to connect both cpuclk and refclk to the same thing.
refclk here should be connected to a fixed 4MHz clksource.

Also, you generally don't want to reach directly into the internals
of other device objects. Instead of directly using s->sysctl.mainclk,
you have the sysctl device create the clock with
qdev_init_clock_out(..., "my-clock-name"), and then the code here
can use qdev_get_clock_out(DEVICE(s->sysctl), "my-clock-name")
to get the clock.

> +    object_property_set_link(OBJECT(&s->armv7m), "memory",
> +            OBJECT(get_system_memory()), &error_abort);
> +
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
> +        return;
> +    }
> +
> +    /* USART */
> +    for (i = 0; i < USART_COUNT; i++) {
> +        dev = DEVICE(&(s->usart[i]));
> +        s->usart[i].sysctl = &s->sysctl;
> +        qdev_prop_set_chr(dev, "chardev", serial_hd(i));
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usart[i]), errp)) {
> +            return;
> +        }
> +        busdev = SYS_BUS_DEVICE(dev);
> +        sysbus_mmio_map(busdev, 0, usart_addrs[i]);
> +        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, usart_irqs[i]));
> +    }
> +
> +    /* GPIO */
> +    for (i = 0; i < GPIO_COUNT; i++) {
> +        dev = DEVICE(&(s->gpio[i]));
> +        s->gpio[i].sysctl = &s->sysctl;
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), errp)) {
> +            return;
> +        }
> +        busdev = SYS_BUS_DEVICE(dev);
> +        sysbus_mmio_map(busdev, 0, gpio_addrs[i]);
> +        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, gpio_irqs[i]));
> +    }
> +
> +    /* Watchdog Timers */
> +    for (i = 0; i < WDT_COUNT; i++) {
> +        dev = DEVICE(&(s->wdt[i]));
> +        s->wdt[i].sysctl = &s->sysctl;
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
> +            return;
> +        }
> +        busdev = SYS_BUS_DEVICE(dev);
> +        sysbus_mmio_map(busdev, 0, wdt_addrs[i]);
> +        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, wdt_irqs[i]));
> +    }
> +
> +    /* General purpose timers */
> +    int j = 0;
> +    for (i = 0, j = 0; i < GPTM_COUNT; i++, j += 2) {
> +        dev = DEVICE(&(s->gptm[i]));
> +        s->gptm[i].sysctl = &s->sysctl;
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gptm[i]), errp)) {
> +            return;
> +        }
> +        busdev = SYS_BUS_DEVICE(dev);
> +        sysbus_mmio_map(busdev, 0, gptm_addrs[i]);
> +        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, gptm_irqs[j]));
> +        sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(armv7m, gptm_irqs[j + 1]));
> +    }
> +
> +    /* SYSCTL */
> +    dev = DEVICE(&(s->sysctl));
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sysctl), errp)) {
> +        return;
> +    }
> +    busdev = SYS_BUS_DEVICE(dev);
> +    sysbus_mmio_map(busdev, 0, SYSCTL_ADDR);

> +

> +
> +    create_unimplemented_device("SSI_0", 0x40008000, 0xFFF);

These lengths look very fishy. Is there really a 1 byte gap
between the end of SSI_0 and the start of SSI_1 ?  0x1000 seems
more plausible.

> +    create_unimplemented_device("SSI_1", 0x40009000, 0xFFF);
> +    create_unimplemented_device("SSI_2", 0x4000A000, 0xFFF);
> +    create_unimplemented_device("SSI_3", 0x4000B000, 0xFFF);

thanks
-- PMM

