Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E8F7ED674
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 22:58:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Nsm-0002K1-Rb; Wed, 15 Nov 2023 16:57:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3Nsi-0002JF-EF
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 16:57:09 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3Nsg-0007rE-F1
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 16:57:08 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50a6ff9881fso177000e87.1
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 13:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700085424; x=1700690224; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M1JO7ihhB5LbZSslbYUbFMAg3vXJvwHL85W4itbvsOg=;
 b=pgOi4QXwNKIcvqyj8XRAWZWRUpy+meRNlWpcBRA2nZTeNeSKWauyf3RukDCoO14LMn
 PngmVW8sSRPyNxEjkZv4yWBBxGqYg/5+kkzK76PAHb/UJA+mrNvSOarBkzlfFDV8AAt9
 9H8zVi9bGwZHiTxX+0m4W9JI446D2dMI4Ix/nGyI6dMnDShzoRo13/GhkE4WHf513GqL
 lUuyOk5kZsLHIBcxg8VmhNzpp8TUPxslkMqAQs4F+jsytEz5P6Dx/+m5ObnnR5R5k/GE
 bo7ItnEfZGGDGDqdUx5b6+V5Kt7D5pug4UM9HpuGlSi/I9cS2rn3M6UEFUu6Vdj4nFE1
 gYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700085424; x=1700690224;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M1JO7ihhB5LbZSslbYUbFMAg3vXJvwHL85W4itbvsOg=;
 b=hI9hVXEVtTWjQGAgsMQTTAAnZtMjpvsEkMPueNLeMTpM6khgAv7GtXA8mcjQk7q1kj
 cNywu+R6V0NIW5E5AIqrFUao9E6Y8zfl/ah4Z0qWwCcfMCZKifHbkeYVAfp0cHVDNoLx
 UewyH1s6F+qGRmF+aTCvVZRQJYuxH1wz9y5K2mEl0hwkPPFRUlOY+DcJtD4aEMs4VNMB
 bjc4KapfNYpqUBv+4qbrsT1KcXpQ9d1q9BVowep2SwYUULF/mvu/+a5Sfl1336V6on7f
 gR/6UQseJAj4FYT3z0NW2+2hLAzVPhj87xEgpTnGh3aIjfn4h3shDaUi/7EHMu6c+Knk
 H5nw==
X-Gm-Message-State: AOJu0YwDOw9dg4g7dUGB1Wjf2nhC/wDh+EcDP9DGeaSB2LWMJ0rERpaK
 QSAQWBcituH1Go4rw92MBuq2GQ==
X-Google-Smtp-Source: AGHT+IEW76WvGMk3iEMWq5zNaWQMFsGOeFMoawuPRWWuUy9s90bYOni2ipUIVzuq3h8DtgaGbg7EXg==
X-Received: by 2002:a05:6512:468:b0:507:976d:89aa with SMTP id
 x8-20020a056512046800b00507976d89aamr8576643lfd.67.1700085424171; 
 Wed, 15 Nov 2023 13:57:04 -0800 (PST)
Received: from [192.168.69.100] ([176.176.130.62])
 by smtp.gmail.com with ESMTPSA id
 c7-20020aa7c987000000b00543525d9fddsm6898326edt.21.2023.11.15.13.57.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 13:57:03 -0800 (PST)
Message-ID: <c7706683-01ca-425f-957e-4caee97830ab@linaro.org>
Date: Wed, 15 Nov 2023 22:57:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] hw/arm: Add minimal support for the
 B-L475E-IOT01A board
Content-Language: en-US
To: ~inesvarhol <inesvarhol@proton.me>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm <qemu-arm@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>
References: <170003673257.14701.8139061802716120109-2@git.sr.ht>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <170003673257.14701.8139061802716120109-2@git.sr.ht>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

On 15/11/23 09:04, ~inesvarhol wrote:
> From: Inès Varhol <ines.varhol@telecom-paris.fr>
> 
> This commit adds a new B-L475E-IOT01A board using the STM32L475VG SoC.
> The implementation is derived from the Netduino Plus 2 machine.
> There are no peripherals implemented, only memory regions.
> 
> Signed-off-by: default avatarArnaud Minier <arnaud.minier@telecom-paris.fr>

"default avatar" got converted to text :)

> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   configs/devices/arm-softmmu/default.mak |  1 +
>   hw/arm/Kconfig                          |  6 +++
>   hw/arm/b-l475e-iot01a.c                 | 71 +++++++++++++++++++++++++
>   hw/arm/meson.build                      |  1 +
>   4 files changed, 79 insertions(+)
>   create mode 100644 hw/arm/b-l475e-iot01a.c
> 
> diff --git a/configs/devices/arm-softmmu/default.mak b/configs/devices/arm-softmmu/default.mak
> index 980c48a7d9..023faa2f75 100644
> --- a/configs/devices/arm-softmmu/default.mak
> +++ b/configs/devices/arm-softmmu/default.mak
> @@ -19,6 +19,7 @@ CONFIG_ARM_VIRT=y
>   # CONFIG_NSERIES=n
>   # CONFIG_STELLARIS=n
>   # CONFIG_STM32VLDISCOVERY=n
> +# CONFIG_B_L475E_IOT01A=n
>   # CONFIG_REALVIEW=n
>   # CONFIG_VERSATILE=n
>   # CONFIG_VEXPRESS=n
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 763510afeb..4d4ed96168 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -448,6 +448,12 @@ config STM32F405_SOC
>       select STM32F4XX_SYSCFG
>       select STM32F4XX_EXTI
>   
> +config B_L475E_IOT01A
> +    bool
> +    default y
> +    depends on TCG && ARM
> +    select STM32L475VG_SOC
> +
>   config STM32L475VG_SOC
>       bool
>       select ARM_V7M
> diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
> new file mode 100644
> index 0000000000..bfcb386d52
> --- /dev/null
> +++ b/hw/arm/b-l475e-iot01a.c
> @@ -0,0 +1,71 @@
> +/*
> + * B-L475E-IOT01A Discovery Kit machine
> + * (B-L475E-IOT01A IoT Node)
> + *
> + * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
> + * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
> + * Copyright (c) 2023 Ines Varhol <ines.varhol@telecom-paris.fr>
> + *

Please add a SPDX tag if possible.

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
> +#include "hw/boards.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/qdev-clock.h"
> +#include "qemu/error-report.h"
> +#include "hw/arm/stm32l475vg_soc.h"
> +#include "hw/arm/boot.h"
> +
> +/* B-L475E-IOT01A implementation is derived from netduinoplus2 */
> +
> +/* Main SYSCLK frequency in Hz (80MHz) */
> +#define SYSCLK_FRQ 80000000ULL
> +
> +static void b_l475e_iot01a_init(MachineState *machine)
> +{
> +    DeviceState *dev;
> +    Clock *sysclk;
> +
> +    /* This clock doesn't need migration because it is fixed-frequency */
> +    sysclk = clock_new(OBJECT(machine), "SYSCLK");
> +    clock_set_hz(sysclk, SYSCLK_FRQ);
> +
> +    dev = qdev_new(TYPE_STM32L475VG_SOC);
> +    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
> +    qdev_connect_clock_in(dev, "sysclk", sysclk);
> +    qdev_realize(DEVICE(dev), NULL, &error_fatal);
> +
> +    armv7m_load_kernel(ARM_CPU(first_cpu),
> +                       machine->kernel_filename,
> +                       0, FLASH_SIZE);
> +}
> +
 >
> +static void b_l475e_iot01a_machine_init(MachineClass *mc)
> +{

We can enforce the CPU type using:

        static const char *machine_valid_cpu_types[] = {
            ARM_CPU_TYPE_NAME("cortex-m4"),
            NULL
        };

> +    mc->desc = "B-L475E-IOT01A Discovery Kit (Cortex-M4)";
> +    mc->init = b_l475e_iot01a_init;
> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m4");

        mc->valid_cpu_types = machine_valid_cpu_types;

Otherwise, clean patch :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Regards,

Phil.

> +
> +    /* SRAM pre-allocated as part of the SoC instantiation */
> +    mc->default_ram_size = 0;
> +}
> +
> +DEFINE_MACHINE("b-l475e-iot01a", b_l475e_iot01a_machine_init)
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 6b2e1228e5..579c28f546 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -42,6 +42,7 @@ arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2836.c', 'raspi.c'))
>   arm_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
>   arm_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
>   arm_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c'))
> +arm_ss.add(when: 'CONFIG_B_L475E_IOT01A', if_true: files('b-l475e-iot01a.c'))
>   arm_ss.add(when: 'CONFIG_STM32L475VG_SOC', if_true: files('stm32l475vg_soc.c'))
>   arm_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqmp.c', 'xlnx-zcu102.c'))
>   arm_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal.c', 'xlnx-versal-virt.c'))


