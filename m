Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0F3844D9E
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Feb 2024 01:11:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVKev-0008TZ-Ox; Wed, 31 Jan 2024 19:10:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rVKer-0008Sh-E5; Wed, 31 Jan 2024 19:10:21 -0500
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rVKen-0004hA-QN; Wed, 31 Jan 2024 19:10:21 -0500
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7d5bbbe57b9so199468241.3; 
 Wed, 31 Jan 2024 16:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706746215; x=1707351015; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eFy4HxDzBmYgkvc7J/beWjCEzXbm9e79eFNj+nAyq4c=;
 b=LM6Za/CCAKYwSKVrSVztzWtzQOFiM8m8W5dY6Pzf8MFj22Q4jod+AaY2aC1tU+PKrD
 ytjRfqBVXmkLYwIBW3E3buOaSuYBUgUoozkMoxgpU+ccuo2BH4q5bVJCQyn5n+a7ryDW
 W8NTez26zmdSmpx8YNRXDXhVaFyS5Mfgo/5cxRMAW87ZC8BDvEVtD11teQWxZBAvFQ2J
 IluMxpaqHJZQnReuwVYqQEJkMh4t/LqSl/4Q4HUk7Z0PxQjNNUjQwAtcV2NDHfH0FZk6
 Cq5qu66HAY7+ul7C53MST3g3FHPcWBeBMLH50V4w2GfidpyYMhkhgHCJQrFvX0/Mu+u1
 OGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706746215; x=1707351015;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eFy4HxDzBmYgkvc7J/beWjCEzXbm9e79eFNj+nAyq4c=;
 b=w0LDtIqgTq7dNdUwCV0U01tTn33MLLRZJItUMFkC3ZkCRN+zLEO6IAxT2tUeEmCJJd
 0Ot9TfHo3ie5npAPzbUop6TUuO1RdaUzUb/w4uxvkBHRVIo6T4QcWfBrfNQqc2URbbxn
 7IfaXFsSN3X6oKHXkFyT+tctBoZdZdIippl6qppt+Qex7UJI8PSN1/579voMQROLFdHt
 cDZBrvoQPppAZQ0oaAFQqhkxf5x7U9uX/FkOdudpp7jLTR6GEU8pJRnxSBzgN1vq0Gis
 DaFweMYPGds3e12VLghrROGbAdzuoV7eBX9WMJPQahaP7Rz/ssRt7qqhTX2s/i7eCkpt
 KkhA==
X-Gm-Message-State: AOJu0YzryH72kakUPCfONLVEArdkUQ9lAaDpNgifDWMku8M0+/7I6vEB
 P5am2eG6pTvQe+vne8xMfFIR7ibgakiDax+eDz0uWdqr1Op8Qa3eP3DN40Ic7b6UCE9e7t4e5EY
 RgB+RqGuE64BVWI7TNIWuKDZgeFA=
X-Google-Smtp-Source: AGHT+IEgwlfa7g/2mr1jXx/u2Kb7hEaM7SDvxsMsUmrV4Dauxq0X1Fm8iXlW1jNRtGvPmlcpPo+BpVvZ7gZYG9ygGyE=
X-Received: by 2002:a05:6102:5f71:b0:46c:b106:d730 with SMTP id
 ix17-20020a0561025f7100b0046cb106d730mr1842363vsb.4.1706746214707; Wed, 31
 Jan 2024 16:10:14 -0800 (PST)
MIME-Version: 1.0
References: <20240130160656.113112-1-arnaud.minier@telecom-paris.fr>
 <20240130160656.113112-2-arnaud.minier@telecom-paris.fr>
In-Reply-To: <20240130160656.113112-2-arnaud.minier@telecom-paris.fr>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 Feb 2024 10:09:48 +1000
Message-ID: <CAKmqyKNO1YbkBunEPsvGFFfYzu5dBZJzg6+nv9PTop5Yc4cQ4g@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] Implement STM32L4x5_RCC skeleton
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

On Wed, Jan 31, 2024 at 2:09=E2=80=AFAM Arnaud Minier
<arnaud.minier@telecom-paris.fr> wrote:
>
> Add the necessary files to add a simple RCC implementation with just
> reads from and writes to registers. Also instanciate the RCC in the
> STM32L4x5_SoC. It is needed for accurate emulation of all the SoC
> clocks and timers.
>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  MAINTAINERS                               |   5 +-
>  docs/system/arm/b-l475e-iot01a.rst        |   2 +-
>  hw/arm/Kconfig                            |   1 +
>  hw/arm/stm32l4x5_soc.c                    |  12 +-
>  hw/misc/Kconfig                           |   3 +
>  hw/misc/meson.build                       |   1 +
>  hw/misc/stm32l4x5_rcc.c                   | 433 ++++++++++++++++++++++
>  hw/misc/trace-events                      |   4 +
>  include/hw/arm/stm32l4x5_soc.h            |   2 +
>  include/hw/misc/stm32l4x5_rcc.h           |  80 ++++
>  include/hw/misc/stm32l4x5_rcc_internals.h | 286 ++++++++++++++
>  11 files changed, 826 insertions(+), 3 deletions(-)
>  create mode 100644 hw/misc/stm32l4x5_rcc.c
>  create mode 100644 include/hw/misc/stm32l4x5_rcc.h
>  create mode 100644 include/hw/misc/stm32l4x5_rcc_internals.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dfaca8323e..50ab2982bb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1128,7 +1128,10 @@ M: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
>  L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/arm/stm32l4x5_soc.c
> -F: include/hw/arm/stm32l4x5_soc.h
> +F: hw/misc/stm32l4x5_exti.c
> +F: hw/misc/stm32l4x5_syscfg.c
> +F: hw/misc/stm32l4x5_rcc.c
> +F: include/hw/*/stm32l4x5_*.h
>
>  B-L475E-IOT01A IoT Node
>  M: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> diff --git a/docs/system/arm/b-l475e-iot01a.rst b/docs/system/arm/b-l475e=
-iot01a.rst
> index 1a021b306a..b857a56ca4 100644
> --- a/docs/system/arm/b-l475e-iot01a.rst
> +++ b/docs/system/arm/b-l475e-iot01a.rst
> @@ -17,13 +17,13 @@ Currently B-L475E-IOT01A machine's only supports the =
following devices:
>  - Cortex-M4F based STM32L4x5 SoC
>  - STM32L4x5 EXTI (Extended interrupts and events controller)
>  - STM32L4x5 SYSCFG (System configuration controller)
> +- STM32L4x5 RCC (Reset and clock control)
>
>  Missing devices
>  """""""""""""""
>
>  The B-L475E-IOT01A does *not* support the following devices:
>
> -- Reset and clock control (RCC)
>  - Serial ports (UART)
>  - General-purpose I/Os (GPIO)
>  - Analog to Digital Converter (ADC)
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index f927878152..92b72d56dc 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -465,6 +465,7 @@ config STM32L4X5_SOC
>      select OR_IRQ
>      select STM32L4X5_SYSCFG
>      select STM32L4X5_EXTI
> +    select STM32L4X5_RCC
>
>  config XLNX_ZYNQMP_ARM
>      bool
> diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
> index f470ff74ec..d5c04b446d 100644
> --- a/hw/arm/stm32l4x5_soc.c
> +++ b/hw/arm/stm32l4x5_soc.c
> @@ -75,6 +75,8 @@ static const int exti_irq[NUM_EXTI_IRQ] =3D {
>      1,                      /* PVM4 wakeup             */
>      78                      /* LCD wakeup, Direct      */
>  };
> +#define RCC_BASE_ADDRESS 0x40021000
> +#define RCC_IRQ 5
>
>  static void stm32l4x5_soc_initfn(Object *obj)
>  {
> @@ -82,6 +84,7 @@ static void stm32l4x5_soc_initfn(Object *obj)
>
>      object_initialize_child(obj, "exti", &s->exti, TYPE_STM32L4X5_EXTI);
>      object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_STM32L4X5_SY=
SCFG);
> +    object_initialize_child(obj, "rcc", &s->rcc, TYPE_STM32L4X5_RCC);
>
>      s->sysclk =3D qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0)=
;
>      s->refclk =3D qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0)=
;
> @@ -184,6 +187,14 @@ static void stm32l4x5_soc_realize(DeviceState *dev_s=
oc, Error **errp)
>                                qdev_get_gpio_in(DEVICE(&s->exti), i));
>      }
>
> +    /* RCC device */
> +    busdev =3D SYS_BUS_DEVICE(&s->rcc);
> +    if (!sysbus_realize(busdev, errp)) {
> +        return;
> +    }
> +    sysbus_mmio_map(busdev, 0, RCC_BASE_ADDRESS);
> +    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, RCC_IRQ));
> +
>      /* APB1 BUS */
>      create_unimplemented_device("TIM2",      0x40000000, 0x400);
>      create_unimplemented_device("TIM3",      0x40000400, 0x400);
> @@ -246,7 +257,6 @@ static void stm32l4x5_soc_realize(DeviceState *dev_so=
c, Error **errp)
>      create_unimplemented_device("DMA1",      0x40020000, 0x400);
>      create_unimplemented_device("DMA2",      0x40020400, 0x400);
>      /* RESERVED:    0x40020800, 0x800 */
> -    create_unimplemented_device("RCC",       0x40021000, 0x400);
>      /* RESERVED:    0x40021400, 0xC00 */
>      create_unimplemented_device("FLASH",     0x40022000, 0x400);
>      /* RESERVED:    0x40022400, 0xC00 */
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 4fc6b29b43..727386fa4b 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -93,6 +93,9 @@ config STM32L4X5_EXTI
>  config STM32L4X5_SYSCFG
>      bool
>
> +config STM32L4X5_RCC
> +    bool
> +
>  config MIPS_ITU
>      bool
>
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index e4ef1da5a5..afd344b374 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -112,6 +112,7 @@ system_ss.add(when: 'CONFIG_STM32F4XX_SYSCFG', if_tru=
e: files('stm32f4xx_syscfg.
>  system_ss.add(when: 'CONFIG_STM32F4XX_EXTI', if_true: files('stm32f4xx_e=
xti.c'))
>  system_ss.add(when: 'CONFIG_STM32L4X5_EXTI', if_true: files('stm32l4x5_e=
xti.c'))
>  system_ss.add(when: 'CONFIG_STM32L4X5_SYSCFG', if_true: files('stm32l4x5=
_syscfg.c'))
> +system_ss.add(when: 'CONFIG_STM32L4X5_RCC', if_true: files('stm32l4x5_rc=
c.c'))
>  system_ss.add(when: 'CONFIG_MPS2_FPGAIO', if_true: files('mps2-fpgaio.c'=
))
>  system_ss.add(when: 'CONFIG_MPS2_SCC', if_true: files('mps2-scc.c'))
>
> diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
> new file mode 100644
> index 0000000000..38ca8aad7d
> --- /dev/null
> +++ b/hw/misc/stm32l4x5_rcc.c
> @@ -0,0 +1,433 @@
> +/*
> + * STM32L4X5 RCC (Reset and clock control)
> + *
> + * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
> + * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + *
> + * The reference used is the STMicroElectronics RM0351 Reference manual
> + * for STM32L4x5 and STM32L4x6 advanced Arm =C2=AE -based 32-bit MCUs.
> + *
> + * Inspired by the BCM2835 CPRMAN clock manager implementation by Luc Mi=
chel.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qemu/timer.h"
> +#include "qapi/error.h"
> +#include "migration/vmstate.h"
> +#include "hw/misc/stm32l4x5_rcc.h"
> +#include "hw/misc/stm32l4x5_rcc_internals.h"
> +#include "hw/clock.h"
> +#include "hw/irq.h"
> +#include "hw/qdev-clock.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
> +#include "trace.h"
> +
> +#define HSE_DEFAULT_FRQ 48000000ULL
> +#define HSI_FRQ 16000000ULL
> +#define MSI_DEFAULT_FRQ 4000000ULL
> +#define LSE_FRQ 32768ULL
> +#define LSI_FRQ 32000ULL
> +
> +static void rcc_update_irq(Stm32l4x5RccState *s)
> +{
> +    if (s->cifr & CIFR_IRQ_MASK) {
> +        qemu_irq_raise(s->irq);
> +    } else {
> +        qemu_irq_lower(s->irq);
> +    }
> +}
> +
> +static void stm32l4x5_rcc_reset_hold(Object *obj)
> +{
> +    Stm32l4x5RccState *s =3D STM32L4X5_RCC(obj);
> +    s->cr =3D 0x00000063;
> +    /*
> +     * Factory-programmed calibration data
> +     * From the reference manual: 0x10XX 00XX
> +     * Value taken from a real card.
> +     */
> +    s->icscr =3D 0x106E0082;
> +    s->cfgr =3D 0x0;
> +    s->pllcfgr =3D 0x00001000;
> +    s->pllsai1cfgr =3D 0x00001000;
> +    s->pllsai2cfgr =3D 0x00001000;
> +    s->cier =3D 0x0;
> +    s->cifr =3D 0x0;
> +    s->ahb1rstr =3D 0x0;
> +    s->ahb2rstr =3D 0x0;
> +    s->ahb3rstr =3D 0x0;
> +    s->apb1rstr1 =3D 0x0;
> +    s->apb1rstr2 =3D 0x0;
> +    s->apb2rstr =3D 0x0;
> +    s->ahb1enr =3D 0x00000100;
> +    s->ahb2enr =3D 0x0;
> +    s->ahb3enr =3D 0x0;
> +    s->apb1enr1 =3D 0x0;
> +    s->apb1enr2 =3D 0x0;
> +    s->apb2enr =3D 0x0;
> +    s->ahb1smenr =3D 0x00011303;
> +    s->ahb2smenr =3D 0x000532FF;
> +    s->ahb3smenr =3D  0x00000101;
> +    s->apb1smenr1 =3D 0xF2FECA3F;
> +    s->apb1smenr2 =3D 0x00000025;
> +    s->apb2smenr =3D 0x01677C01;
> +    s->ccipr =3D 0x0;
> +    s->bdcr =3D 0x0;
> +    s->csr =3D 0x0C000600;
> +}
> +
> +static uint64_t stm32l4x5_rcc_read(void *opaque, hwaddr addr,
> +                                     unsigned int size)
> +{
> +    Stm32l4x5RccState *s =3D opaque;
> +    uint64_t retvalue =3D 0;
> +
> +    switch (addr) {
> +    case A_CR:
> +        retvalue =3D s->cr;
> +        break;
> +    case A_ICSCR:
> +        retvalue =3D s->icscr;
> +        break;
> +    case A_CFGR:
> +        retvalue =3D s->cfgr;
> +        break;
> +    case A_PLLCFGR:
> +        retvalue =3D s->pllcfgr;
> +        break;
> +    case A_PLLSAI1CFGR:
> +        retvalue =3D s->pllsai1cfgr;
> +        break;
> +    case A_PLLSAI2CFGR:
> +        retvalue =3D s->pllsai2cfgr;
> +        break;
> +    case A_CIER:
> +        retvalue =3D s->cier;
> +        break;
> +    case A_CIFR:
> +        retvalue =3D s->cifr;
> +        break;
> +    case A_CICR:
> +        /* CICR is write only, return the reset value =3D 0 */
> +        break;
> +    case A_AHB1RSTR:
> +        retvalue =3D s->ahb1rstr;
> +        break;
> +    case A_AHB2RSTR:
> +        retvalue =3D s->ahb2rstr;
> +        break;
> +    case A_AHB3RSTR:
> +        retvalue =3D s->ahb3rstr;
> +        break;
> +    case A_APB1RSTR1:
> +        retvalue =3D s->apb1rstr1;
> +        break;
> +    case A_APB1RSTR2:
> +        retvalue =3D s->apb1rstr2;
> +        break;
> +    case A_APB2RSTR:
> +        retvalue =3D s->apb2rstr;
> +        break;
> +    case A_AHB1ENR:
> +        retvalue =3D s->ahb1enr;
> +        break;
> +    case A_AHB2ENR:
> +        retvalue =3D s->ahb2enr;
> +        break;
> +    case A_AHB3ENR:
> +        retvalue =3D s->ahb3enr;
> +        break;
> +    case A_APB1ENR1:
> +        retvalue =3D s->apb1enr1;
> +        break;
> +    case A_APB1ENR2:
> +        retvalue =3D s->apb1enr2;
> +        break;
> +    case A_APB2ENR:
> +        retvalue =3D s->apb2enr;
> +        break;
> +    case A_AHB1SMENR:
> +        retvalue =3D s->ahb1smenr;
> +        break;
> +    case A_AHB2SMENR:
> +        retvalue =3D s->ahb2smenr;
> +        break;
> +    case A_AHB3SMENR:
> +        retvalue =3D s->ahb3smenr;
> +        break;
> +    case A_APB1SMENR1:
> +        retvalue =3D s->apb1smenr1;
> +        break;
> +    case A_APB1SMENR2:
> +        retvalue =3D s->apb1smenr2;
> +        break;
> +    case A_APB2SMENR:
> +        retvalue =3D s->apb2smenr;
> +        break;
> +    case A_CCIPR:
> +        retvalue =3D s->ccipr;
> +        break;
> +    case A_BDCR:
> +        retvalue =3D s->bdcr;
> +        break;
> +    case A_CSR:
> +        retvalue =3D s->csr;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, add=
r);
> +        break;
> +    }
> +
> +    trace_stm32l4x5_rcc_read(addr, retvalue);
> +
> +    return retvalue;
> +}
> +
> +static void stm32l4x5_rcc_write(void *opaque, hwaddr addr,
> +                                  uint64_t val64, unsigned int size)
> +{
> +    Stm32l4x5RccState *s =3D opaque;
> +    const uint32_t value =3D val64;
> +
> +    trace_stm32l4x5_rcc_write(addr, value);
> +
> +    switch (addr) {
> +    case A_CR:
> +        s->cr =3D (s->cr & CR_READ_SET_MASK) |
> +                (value & (CR_READ_SET_MASK | ~CR_READ_ONLY_MASK));
> +        break;
> +    case A_ICSCR:
> +        s->icscr =3D value & ~ICSCR_READ_ONLY_MASK;
> +        break;
> +    case A_CFGR:
> +        s->cfgr =3D value & ~CFGR_READ_ONLY_MASK;
> +        break;
> +    case A_PLLCFGR:
> +        s->pllcfgr =3D value;
> +        break;
> +    case A_PLLSAI1CFGR:
> +        s->pllsai1cfgr =3D value;
> +        break;
> +    case A_PLLSAI2CFGR:
> +        s->pllsai2cfgr =3D value;
> +        break;
> +    case A_CIER:
> +        s->cier =3D value;
> +        break;
> +    case A_CIFR:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "%s: Write attempt into read-only register (CIFR) 0x%"PRIx32=
"\n",
> +            __func__, value);
> +        break;
> +    case A_CICR:
> +        /* Clear interrupt flags by writing a 1 to the CICR register */
> +        s->cifr &=3D ~value;
> +        rcc_update_irq(s);
> +        break;
> +    /* Reset behaviors are not implemented */
> +    case A_AHB1RSTR:
> +        s->ahb1rstr =3D value;
> +        break;
> +    case A_AHB2RSTR:
> +        s->ahb2rstr =3D value;
> +        break;
> +    case A_AHB3RSTR:
> +        s->ahb3rstr =3D value;
> +        break;
> +    case A_APB1RSTR1:
> +        s->apb1rstr1 =3D value;
> +        break;
> +    case A_APB1RSTR2:
> +        s->apb1rstr2 =3D value;
> +        break;
> +    case A_APB2RSTR:
> +        s->apb2rstr =3D value;
> +        break;
> +    case A_AHB1ENR:
> +        s->ahb1enr =3D value;
> +        break;
> +    case A_AHB2ENR:
> +        s->ahb2enr =3D value;
> +        break;
> +    case A_AHB3ENR:
> +        s->ahb3enr =3D value;
> +        break;
> +    case A_APB1ENR1:
> +        s->apb1enr1 =3D value;
> +        break;
> +    case A_APB1ENR2:
> +        s->apb1enr2 =3D value;
> +        break;
> +    case A_APB2ENR:
> +        s->apb2enr =3D (s->apb2enr & APB2ENR_READ_SET_MASK) | value;
> +        break;
> +    /* Behaviors for Sleep and Stop modes are not implemented */
> +    case A_AHB1SMENR:
> +        s->ahb1smenr =3D value;
> +        break;
> +    case A_AHB2SMENR:
> +        s->ahb2smenr =3D value;
> +        break;
> +    case A_AHB3SMENR:
> +        s->ahb3smenr =3D value;
> +        break;
> +    case A_APB1SMENR1:
> +        s->apb1smenr1 =3D value;
> +        break;
> +    case A_APB1SMENR2:
> +        s->apb1smenr2 =3D value;
> +        break;
> +    case A_APB2SMENR:
> +        s->apb2smenr =3D value;
> +        break;
> +    case A_CCIPR:
> +        s->ccipr =3D value;
> +        break;
> +    case A_BDCR:
> +        s->bdcr =3D value & ~BDCR_READ_ONLY_MASK;
> +        break;
> +    case A_CSR:
> +        s->csr =3D value & ~CSR_READ_ONLY_MASK;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, add=
r);
> +    }
> +}
> +
> +static const MemoryRegionOps stm32l4x5_rcc_ops =3D {
> +    .read =3D stm32l4x5_rcc_read,
> +    .write =3D stm32l4x5_rcc_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .valid =3D {
> +        .max_access_size =3D 4,
> +        .unaligned =3D false
> +    },
> +};
> +
> +static const ClockPortInitArray stm32l4x5_rcc_clocks =3D {
> +    QDEV_CLOCK_IN(Stm32l4x5RccState, hsi16_rc, NULL, 0),
> +    QDEV_CLOCK_IN(Stm32l4x5RccState, msi_rc, NULL, 0),
> +    QDEV_CLOCK_IN(Stm32l4x5RccState, hse, NULL, 0),
> +    QDEV_CLOCK_IN(Stm32l4x5RccState, lsi_rc, NULL, 0),
> +    QDEV_CLOCK_IN(Stm32l4x5RccState, lse_crystal, NULL, 0),
> +    QDEV_CLOCK_IN(Stm32l4x5RccState, sai1_extclk, NULL, 0),
> +    QDEV_CLOCK_IN(Stm32l4x5RccState, sai2_extclk, NULL, 0),
> +    QDEV_CLOCK_END
> +};
> +
> +
> +static void stm32l4x5_rcc_init(Object *obj)
> +{
> +    Stm32l4x5RccState *s =3D STM32L4X5_RCC(obj);
> +
> +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
> +
> +    memory_region_init_io(&s->mmio, obj, &stm32l4x5_rcc_ops, s,
> +                          TYPE_STM32L4X5_RCC, 0x400);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +
> +    qdev_init_clocks(DEVICE(s), stm32l4x5_rcc_clocks);
> +
> +    s->gnd =3D clock_new(obj, "gnd");
> +}
> +
> +static const VMStateDescription vmstate_stm32l4x5_rcc =3D {
> +    .name =3D TYPE_STM32L4X5_RCC,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32(cr, Stm32l4x5RccState),
> +        VMSTATE_UINT32(icscr, Stm32l4x5RccState),
> +        VMSTATE_UINT32(cfgr, Stm32l4x5RccState),
> +        VMSTATE_UINT32(pllcfgr, Stm32l4x5RccState),
> +        VMSTATE_UINT32(pllsai1cfgr, Stm32l4x5RccState),
> +        VMSTATE_UINT32(pllsai2cfgr, Stm32l4x5RccState),
> +        VMSTATE_UINT32(cier, Stm32l4x5RccState),
> +        VMSTATE_UINT32(cifr, Stm32l4x5RccState),
> +        VMSTATE_UINT32(ahb1rstr, Stm32l4x5RccState),
> +        VMSTATE_UINT32(ahb2rstr, Stm32l4x5RccState),
> +        VMSTATE_UINT32(ahb3rstr, Stm32l4x5RccState),
> +        VMSTATE_UINT32(apb1rstr1, Stm32l4x5RccState),
> +        VMSTATE_UINT32(apb1rstr2, Stm32l4x5RccState),
> +        VMSTATE_UINT32(apb2rstr, Stm32l4x5RccState),
> +        VMSTATE_UINT32(ahb1enr, Stm32l4x5RccState),
> +        VMSTATE_UINT32(ahb2enr, Stm32l4x5RccState),
> +        VMSTATE_UINT32(ahb3enr, Stm32l4x5RccState),
> +        VMSTATE_UINT32(apb1enr1, Stm32l4x5RccState),
> +        VMSTATE_UINT32(apb1enr2, Stm32l4x5RccState),
> +        VMSTATE_UINT32(apb2enr, Stm32l4x5RccState),
> +        VMSTATE_UINT32(ahb1smenr, Stm32l4x5RccState),
> +        VMSTATE_UINT32(ahb2smenr, Stm32l4x5RccState),
> +        VMSTATE_UINT32(ahb3smenr, Stm32l4x5RccState),
> +        VMSTATE_UINT32(apb1smenr1, Stm32l4x5RccState),
> +        VMSTATE_UINT32(apb1smenr2, Stm32l4x5RccState),
> +        VMSTATE_UINT32(apb2smenr, Stm32l4x5RccState),
> +        VMSTATE_UINT32(ccipr, Stm32l4x5RccState),
> +        VMSTATE_UINT32(bdcr, Stm32l4x5RccState),
> +        VMSTATE_UINT32(csr, Stm32l4x5RccState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +
> +static void stm32l4x5_rcc_realize(DeviceState *dev, Error **errp)
> +{
> +    Stm32l4x5RccState *s =3D STM32L4X5_RCC(dev);
> +
> +    if (s->hse_frequency <  4000000ULL ||
> +        s->hse_frequency > 48000000ULL) {
> +            error_setg(errp,
> +                "HSE frequency is outside of the allowed [4-48]Mhz range=
: %" PRIx64 "",
> +                s->hse_frequency);
> +            return;
> +        }
> +
> +    clock_update_hz(s->msi_rc, MSI_DEFAULT_FRQ);
> +    clock_update_hz(s->sai1_extclk, s->sai1_extclk_frequency);
> +    clock_update_hz(s->sai2_extclk, s->sai2_extclk_frequency);
> +    clock_update(s->gnd, 0);
> +}
> +
> +static Property stm32l4x5_rcc_properties[] =3D {
> +    DEFINE_PROP_UINT64("hse_frequency", Stm32l4x5RccState,
> +        hse_frequency, HSE_DEFAULT_FRQ),
> +    DEFINE_PROP_UINT64("sai1_extclk_frequency", Stm32l4x5RccState,
> +        sai1_extclk_frequency, 0),
> +    DEFINE_PROP_UINT64("sai2_extclk_frequency", Stm32l4x5RccState,
> +        sai2_extclk_frequency, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void stm32l4x5_rcc_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> +
> +
> +    rc->phases.hold =3D stm32l4x5_rcc_reset_hold;
> +    device_class_set_props(dc, stm32l4x5_rcc_properties);
> +    dc->realize =3D stm32l4x5_rcc_realize;
> +    dc->vmsd =3D &vmstate_stm32l4x5_rcc;
> +}
> +
> +static const TypeInfo stm32l4x5_rcc_types[] =3D {
> +    {
> +        .name           =3D TYPE_STM32L4X5_RCC,
> +        .parent         =3D TYPE_SYS_BUS_DEVICE,
> +        .instance_size  =3D sizeof(Stm32l4x5RccState),
> +        .instance_init  =3D stm32l4x5_rcc_init,
> +        .class_init     =3D stm32l4x5_rcc_class_init,
> +    }
> +};
> +
> +DEFINE_TYPES(stm32l4x5_rcc_types)
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 5f5bc92222..62a7599353 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -174,6 +174,10 @@ stm32l4x5_exti_set_irq(int irq, int level) "Set EXTI=
: %d to %d"
>  stm32l4x5_exti_read(uint64_t addr, uint64_t data) "reg read: addr: 0x%" =
PRIx64 " val: 0x%" PRIx64 ""
>  stm32l4x5_exti_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%=
" PRIx64 " val: 0x%" PRIx64 ""
>
> +# stm32l4x5_rcc.c
> +stm32l4x5_rcc_read(uint64_t addr, uint32_t data) "RCC: Read <0x%" PRIx64=
 "> -> 0x%" PRIx32 ""
> +stm32l4x5_rcc_write(uint64_t addr, uint32_t data) "RCC: Write <0x%" PRIx=
64 "> <- 0x%" PRIx32 ""
> +
>  # tz-mpc.c
>  tz_mpc_reg_read(uint32_t offset, uint64_t data, unsigned size) "TZ MPC r=
egs read: offset 0x%x data 0x%" PRIx64 " size %u"
>  tz_mpc_reg_write(uint32_t offset, uint64_t data, unsigned size) "TZ MPC =
regs write: offset 0x%x data 0x%" PRIx64 " size %u"
> diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_so=
c.h
> index baf70410b5..e480fcc976 100644
> --- a/include/hw/arm/stm32l4x5_soc.h
> +++ b/include/hw/arm/stm32l4x5_soc.h
> @@ -28,6 +28,7 @@
>  #include "hw/arm/armv7m.h"
>  #include "hw/misc/stm32l4x5_syscfg.h"
>  #include "hw/misc/stm32l4x5_exti.h"
> +#include "hw/misc/stm32l4x5_rcc.h"
>  #include "qom/object.h"
>
>  #define TYPE_STM32L4X5_SOC "stm32l4x5-soc"
> @@ -43,6 +44,7 @@ struct Stm32l4x5SocState {
>
>      Stm32l4x5ExtiState exti;
>      Stm32l4x5SyscfgState syscfg;
> +    Stm32l4x5RccState rcc;
>
>      MemoryRegion sram1;
>      MemoryRegion sram2;
> diff --git a/include/hw/misc/stm32l4x5_rcc.h b/include/hw/misc/stm32l4x5_=
rcc.h
> new file mode 100644
> index 0000000000..5157e96635
> --- /dev/null
> +++ b/include/hw/misc/stm32l4x5_rcc.h
> @@ -0,0 +1,80 @@
> +/*
> + * STM32L4X5 RCC (Reset and clock control)
> + *
> + * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
> + * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + *
> + * The reference used is the STMicroElectronics RM0351 Reference manual
> + * for STM32L4x5 and STM32L4x6 advanced Arm =C2=AE -based 32-bit MCUs.
> + *
> + * Inspired by the BCM2835 CPRMAN clock manager by Luc Michel.
> + */
> +
> +#ifndef HW_STM32L4X5_RCC_H
> +#define HW_STM32L4X5_RCC_H
> +
> +#include "hw/sysbus.h"
> +#include "qom/object.h"
> +
> +#define TYPE_STM32L4X5_RCC "stm32l4x5-rcc"
> +OBJECT_DECLARE_SIMPLE_TYPE(Stm32l4x5RccState, STM32L4X5_RCC)
> +
> +/* In the Stm32l4x5 clock tree, mux have at most 7 sources */
> +#define RCC_NUM_CLOCK_MUX_SRC 7
> +struct Stm32l4x5RccState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mmio;
> +
> +    uint32_t cr;
> +    uint32_t icscr;
> +    uint32_t cfgr;
> +    uint32_t pllcfgr;
> +    uint32_t pllsai1cfgr;
> +    uint32_t pllsai2cfgr;
> +    uint32_t cier;
> +    uint32_t cifr;
> +    uint32_t ahb1rstr;
> +    uint32_t ahb2rstr;
> +    uint32_t ahb3rstr;
> +    uint32_t apb1rstr1;
> +    uint32_t apb1rstr2;
> +    uint32_t apb2rstr;
> +    uint32_t ahb1enr;
> +    uint32_t ahb2enr;
> +    uint32_t ahb3enr;
> +    uint32_t apb1enr1;
> +    uint32_t apb1enr2;
> +    uint32_t apb2enr;
> +    uint32_t ahb1smenr;
> +    uint32_t ahb2smenr;
> +    uint32_t ahb3smenr;
> +    uint32_t apb1smenr1;
> +    uint32_t apb1smenr2;
> +    uint32_t apb2smenr;
> +    uint32_t ccipr;
> +    uint32_t bdcr;
> +    uint32_t csr;
> +
> +    /* Clock sources */
> +    Clock *gnd;
> +    Clock *hsi16_rc;
> +    Clock *msi_rc;
> +    Clock *hse;
> +    Clock *lsi_rc;
> +    Clock *lse_crystal;
> +    Clock *sai1_extclk;
> +    Clock *sai2_extclk;
> +
> +    qemu_irq irq;
> +    uint64_t hse_frequency;
> +    uint64_t sai1_extclk_frequency;
> +    uint64_t sai2_extclk_frequency;
> +};
> +
> +#endif /* HW_STM32L4X5_RCC_H */
> diff --git a/include/hw/misc/stm32l4x5_rcc_internals.h b/include/hw/misc/=
stm32l4x5_rcc_internals.h
> new file mode 100644
> index 0000000000..331ea30db5
> --- /dev/null
> +++ b/include/hw/misc/stm32l4x5_rcc_internals.h
> @@ -0,0 +1,286 @@
> +/*
> + * STM32L4X5 RCC (Reset and clock control)
> + *
> + * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
> + * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + *
> + * The reference used is the STMicroElectronics RM0351 Reference manual
> + * for STM32L4x5 and STM32L4x6 advanced Arm =C2=AE -based 32-bit MCUs.
> + *
> + * Inspired by the BCM2835 CPRMAN clock manager implementation by Luc Mi=
chel.
> + */
> +
> +#ifndef HW_STM32L4X5_RCC_INTERNALS_H
> +#define HW_STM32L4X5_RCC_INTERNALS_H
> +
> +#include "hw/registerfields.h"
> +#include "hw/misc/stm32l4x5_rcc.h"
> +
> +
> +/* Register map */
> +REG32(CR, 0x00)
> +    FIELD(CR, PLLSAI2RDY, 29, 1)
> +    FIELD(CR, PLLSAI2ON, 28, 1)
> +    FIELD(CR, PLLSAI1RDY, 27, 1)
> +    FIELD(CR, PLLSAI1ON, 26, 1)
> +    FIELD(CR, PLLRDY, 25, 1)
> +    FIELD(CR, PLLON, 24, 1)
> +    FIELD(CR, CSSON, 19, 1)
> +    FIELD(CR, HSEBYP, 18, 1)
> +    FIELD(CR, HSERDY, 17, 1)
> +    FIELD(CR, HSEON, 16, 1)
> +    FIELD(CR, HSIASFS, 11, 1)
> +    FIELD(CR, HSIRDY, 10, 1)
> +    FIELD(CR, HSIKERON, 9, 1)
> +    FIELD(CR, HSION, 8, 1)
> +    FIELD(CR, MSIRANGE, 4, 4)
> +    FIELD(CR, MSIRGSEL, 3, 1)
> +    FIELD(CR, MSIPLLEN, 2, 1)
> +    FIELD(CR, MSIRDY, 1, 1)
> +    FIELD(CR, MSION, 0, 1)
> +REG32(ICSCR, 0x04)
> +    FIELD(ICSCR, HSITRIM, 24, 7)
> +    FIELD(ICSCR, HSICAL, 16, 8)
> +    FIELD(ICSCR, MSITRIM, 8, 8)
> +    FIELD(ICSCR, MSICAL, 0, 8)
> +REG32(CFGR, 0x08)
> +    FIELD(CFGR, MCOPRE, 28, 3)
> +    /* MCOSEL[2:0] only for STM32L475xx/476xx/486xx devices */
> +    FIELD(CFGR, MCOSEL, 24, 3)
> +    FIELD(CFGR, STOPWUCK, 15, 1)
> +    FIELD(CFGR, PPRE2, 11, 3)
> +    FIELD(CFGR, PPRE1, 8, 3)
> +    FIELD(CFGR, HPRE, 4, 4)
> +    FIELD(CFGR, SWS, 2, 2)
> +    FIELD(CFGR, SW, 0, 2)
> +REG32(PLLCFGR, 0x0C)
> +    FIELD(PLLCFGR, PLLPDIV, 27, 5)
> +    FIELD(PLLCFGR, PLLR, 25, 2)
> +    FIELD(PLLCFGR, PLLREN, 24, 1)
> +    FIELD(PLLCFGR, PLLQ, 21, 2)
> +    FIELD(PLLCFGR, PLLQEN, 20, 1)
> +    FIELD(PLLCFGR, PLLP, 17, 1)
> +    FIELD(PLLCFGR, PLLPEN, 16, 1)
> +    FIELD(PLLCFGR, PLLN, 8, 7)
> +    FIELD(PLLCFGR, PLLM, 4, 3)
> +    FIELD(PLLCFGR, PLLSRC, 0, 2)
> +REG32(PLLSAI1CFGR, 0x10)
> +    FIELD(PLLSAI1CFGR, PLLSAI1PDIV, 27, 5)
> +    FIELD(PLLSAI1CFGR, PLLSAI1R, 25, 2)
> +    FIELD(PLLSAI1CFGR, PLLSAI1REN, 24, 1)
> +    FIELD(PLLSAI1CFGR, PLLSAI1Q, 21, 2)
> +    FIELD(PLLSAI1CFGR, PLLSAI1QEN, 20, 1)
> +    FIELD(PLLSAI1CFGR, PLLSAI1P, 17, 1)
> +    FIELD(PLLSAI1CFGR, PLLSAI1PEN, 16, 1)
> +    FIELD(PLLSAI1CFGR, PLLSAI1N, 8, 7)
> +REG32(PLLSAI2CFGR, 0x14)
> +    FIELD(PLLSAI2CFGR, PLLSAI2PDIV, 27, 5)
> +    FIELD(PLLSAI2CFGR, PLLSAI2R, 25, 2)
> +    FIELD(PLLSAI2CFGR, PLLSAI2REN, 24, 1)
> +    FIELD(PLLSAI2CFGR, PLLSAI2Q, 21, 2)
> +    FIELD(PLLSAI2CFGR, PLLSAI2QEN, 20, 1)
> +    FIELD(PLLSAI2CFGR, PLLSAI2P, 17, 1)
> +    FIELD(PLLSAI2CFGR, PLLSAI2PEN, 16, 1)
> +    FIELD(PLLSAI2CFGR, PLLSAI2N, 8, 7)
> +REG32(CIER, 0x18)
> +    /* HSI48RDYIE: only on STM32L496xx/4A6xx devices */
> +    FIELD(CIER, LSECSSIE, 9, 1)
> +    FIELD(CIER, PLLSAI2RDYIE, 7, 1)
> +    FIELD(CIER, PLLSAI1RDYIE, 6, 1)
> +    FIELD(CIER, PLLRDYIE, 5, 1)
> +    FIELD(CIER, HSERDYIE, 4, 1)
> +    FIELD(CIER, HSIRDYIE, 3, 1)
> +    FIELD(CIER, MSIRDYIE, 2, 1)
> +    FIELD(CIER, LSERDYIE, 1, 1)
> +    FIELD(CIER, LSIRDYIE, 0, 1)
> +REG32(CIFR, 0x1C)
> +    /* HSI48RDYF: only on STM32L496xx/4A6xx devices */
> +    FIELD(CIFR, LSECSSF, 9, 1)
> +    FIELD(CIFR, CSSF, 8, 1)
> +    FIELD(CIFR, PLLSAI2RDYF, 7, 1)
> +    FIELD(CIFR, PLLSAI1RDYF, 6, 1)
> +    FIELD(CIFR, PLLRDYF, 5, 1)
> +    FIELD(CIFR, HSERDYF, 4, 1)
> +    FIELD(CIFR, HSIRDYF, 3, 1)
> +    FIELD(CIFR, MSIRDYF, 2, 1)
> +    FIELD(CIFR, LSERDYF, 1, 1)
> +    FIELD(CIFR, LSIRDYF, 0, 1)
> +REG32(CICR, 0x20)
> +    /* HSI48RDYC: only on STM32L496xx/4A6xx devices */
> +    FIELD(CICR, LSECSSC, 9, 1)
> +    FIELD(CICR, CSSC, 8, 1)
> +    FIELD(CICR, PLLSAI2RDYC, 7, 1)
> +    FIELD(CICR, PLLSAI1RDYC, 6, 1)
> +    FIELD(CICR, PLLRDYC, 5, 1)
> +    FIELD(CICR, HSERDYC, 4, 1)
> +    FIELD(CICR, HSIRDYC, 3, 1)
> +    FIELD(CICR, MSIRDYC, 2, 1)
> +    FIELD(CICR, LSERDYC, 1, 1)
> +    FIELD(CICR, LSIRDYC, 0, 1)
> +REG32(AHB1RSTR, 0x28)
> +REG32(AHB2RSTR, 0x2C)
> +REG32(AHB3RSTR, 0x30)
> +REG32(APB1RSTR1, 0x38)
> +REG32(APB1RSTR2, 0x3C)
> +REG32(APB2RSTR, 0x40)
> +REG32(AHB1ENR, 0x48)
> +    /* DMA2DEN: reserved for STM32L475xx */
> +    FIELD(AHB1ENR, TSCEN, 16, 1)
> +    FIELD(AHB1ENR, CRCEN, 12, 1)
> +    FIELD(AHB1ENR, FLASHEN, 8, 1)
> +    FIELD(AHB1ENR, DMA2EN, 1, 1)
> +    FIELD(AHB1ENR, DMA1EN, 0, 1)
> +REG32(AHB2ENR, 0x4C)
> +    FIELD(AHB2ENR, RNGEN, 18, 1)
> +    /* HASHEN: reserved for STM32L475xx */
> +    FIELD(AHB2ENR, AESEN, 16, 1)
> +    /* DCMIEN: reserved for STM32L475xx */
> +    FIELD(AHB2ENR, ADCEN, 13, 1)
> +    FIELD(AHB2ENR, OTGFSEN, 12, 1)
> +    /* GPIOIEN: reserved for STM32L475xx */
> +    FIELD(AHB2ENR, GPIOHEN, 7, 1)
> +    FIELD(AHB2ENR, GPIOGEN, 6, 1)
> +    FIELD(AHB2ENR, GPIOFEN, 5, 1)
> +    FIELD(AHB2ENR, GPIOEEN, 4, 1)
> +    FIELD(AHB2ENR, GPIODEN, 3, 1)
> +    FIELD(AHB2ENR, GPIOCEN, 2, 1)
> +    FIELD(AHB2ENR, GPIOBEN, 1, 1)
> +    FIELD(AHB2ENR, GPIOAEN, 0, 1)
> +REG32(AHB3ENR, 0x50)
> +    FIELD(AHB3ENR, QSPIEN, 8, 1)
> +    FIELD(AHB3ENR, FMCEN, 0, 1)
> +REG32(APB1ENR1, 0x58)
> +    FIELD(APB1ENR1, LPTIM1EN, 31, 1)
> +    FIELD(APB1ENR1, OPAMPEN, 30, 1)
> +    FIELD(APB1ENR1, DAC1EN, 29, 1)
> +    FIELD(APB1ENR1, PWREN, 28, 1)
> +    FIELD(APB1ENR1, CAN2EN, 26, 1)
> +    FIELD(APB1ENR1, CAN1EN, 25, 1)
> +    /* CRSEN: reserved for STM32L475xx */
> +    FIELD(APB1ENR1, I2C3EN, 23, 1)
> +    FIELD(APB1ENR1, I2C2EN, 22, 1)
> +    FIELD(APB1ENR1, I2C1EN, 21, 1)
> +    FIELD(APB1ENR1, UART5EN, 20, 1)
> +    FIELD(APB1ENR1, UART4EN, 19, 1)
> +    FIELD(APB1ENR1, USART3EN, 18, 1)
> +    FIELD(APB1ENR1, USART2EN, 17, 1)
> +    FIELD(APB1ENR1, SPI3EN, 15, 1)
> +    FIELD(APB1ENR1, SPI2EN, 14, 1)
> +    FIELD(APB1ENR1, WWDGEN, 11, 1)
> +    /* RTCAPBEN: reserved for STM32L475xx */
> +    FIELD(APB1ENR1, LCDEN, 9, 1)
> +    FIELD(APB1ENR1, TIM7EN, 5, 1)
> +    FIELD(APB1ENR1, TIM6EN, 4, 1)
> +    FIELD(APB1ENR1, TIM5EN, 3, 1)
> +    FIELD(APB1ENR1, TIM4EN, 2, 1)
> +    FIELD(APB1ENR1, TIM3EN, 1, 1)
> +    FIELD(APB1ENR1, TIM2EN, 0, 1)
> +REG32(APB1ENR2, 0x5C)
> +    FIELD(APB1ENR2, LPTIM2EN, 5, 1)
> +    FIELD(APB1ENR2, SWPMI1EN, 2, 1)
> +    /* I2C4EN: reserved for STM32L475xx */
> +    FIELD(APB1ENR2, LPUART1EN, 0, 1)
> +REG32(APB2ENR, 0x60)
> +    FIELD(APB2ENR, DFSDM1EN, 24, 1)
> +    FIELD(APB2ENR, SAI2EN, 22, 1)
> +    FIELD(APB2ENR, SAI1EN, 21, 1)
> +    FIELD(APB2ENR, TIM17EN, 18, 1)
> +    FIELD(APB2ENR, TIM16EN, 17, 1)
> +    FIELD(APB2ENR, TIM15EN, 16, 1)
> +    FIELD(APB2ENR, USART1EN, 14, 1)
> +    FIELD(APB2ENR, TIM8EN, 13, 1)
> +    FIELD(APB2ENR, SPI1EN, 12, 1)
> +    FIELD(APB2ENR, TIM1EN, 11, 1)
> +    FIELD(APB2ENR, SDMMC1EN, 10, 1)
> +    FIELD(APB2ENR, FWEN, 7, 1)
> +    FIELD(APB2ENR, SYSCFGEN, 0, 1)
> +REG32(AHB1SMENR, 0x68)
> +REG32(AHB2SMENR, 0x6C)
> +REG32(AHB3SMENR, 0x70)
> +REG32(APB1SMENR1, 0x78)
> +REG32(APB1SMENR2, 0x7C)
> +REG32(APB2SMENR, 0x80)
> +REG32(CCIPR, 0x88)
> +    FIELD(CCIPR, DFSDM1SEL, 31, 1)
> +    FIELD(CCIPR, SWPMI1SEL, 30, 1)
> +    FIELD(CCIPR, ADCSEL, 28, 2)
> +    FIELD(CCIPR, CLK48SEL, 26, 2)
> +    FIELD(CCIPR, SAI2SEL, 24, 2)
> +    FIELD(CCIPR, SAI1SEL, 22, 2)
> +    FIELD(CCIPR, LPTIM2SEL, 20, 2)
> +    FIELD(CCIPR, LPTIM1SEL, 18, 2)
> +    FIELD(CCIPR, I2C3SEL, 16, 2)
> +    FIELD(CCIPR, I2C2SEL, 14, 2)
> +    FIELD(CCIPR, I2C1SEL, 12, 2)
> +    FIELD(CCIPR, LPUART1SEL, 10, 2)
> +    FIELD(CCIPR, UART5SEL, 8, 2)
> +    FIELD(CCIPR, UART4SEL, 6, 2)
> +    FIELD(CCIPR, USART3SEL, 4, 2)
> +    FIELD(CCIPR, USART2SEL, 2, 2)
> +    FIELD(CCIPR, USART1SEL, 0, 2)
> +REG32(BDCR, 0x90)
> +    FIELD(BDCR, LSCOSEL, 25, 1)
> +    FIELD(BDCR, LSCOEN, 24, 1)
> +    FIELD(BDCR, BDRST, 16, 1)
> +    FIELD(BDCR, RTCEN, 15, 1)
> +    FIELD(BDCR, RTCSEL, 8, 2)
> +    FIELD(BDCR, LSECSSD, 6, 1)
> +    FIELD(BDCR, LSECSSON, 5, 1)
> +    FIELD(BDCR, LSEDRV, 3, 2)
> +    FIELD(BDCR, LSEBYP, 2, 1)
> +    FIELD(BDCR, LSERDY, 1, 1)
> +    FIELD(BDCR, LSEON, 0, 1)
> +REG32(CSR, 0x94)
> +    FIELD(CSR, LPWRRSTF, 31, 1)
> +    FIELD(CSR, WWDGRSTF, 30, 1)
> +    FIELD(CSR, IWWGRSTF, 29, 1)
> +    FIELD(CSR, SFTRSTF, 28, 1)
> +    FIELD(CSR, BORRSTF, 27, 1)
> +    FIELD(CSR, PINRSTF, 26, 1)
> +    FIELD(CSR, OBLRSTF, 25, 1)
> +    FIELD(CSR, FWRSTF, 24, 1)
> +    FIELD(CSR, RMVF, 23, 1)
> +    FIELD(CSR, MSISRANGE, 8, 4)
> +    FIELD(CSR, LSIRDY, 1, 1)
> +    FIELD(CSR, LSION, 0, 1)
> +/* CRRCR and CCIPR2 registers are present on L496/L4A6 devices only. */
> +
> +/* Read Only masks to prevent writes in unauthorized bits */
> +#define CR_READ_ONLY_MASK (R_CR_PLLSAI2RDY_MASK | \
> +                           R_CR_PLLSAI1RDY_MASK | \
> +                           R_CR_PLLRDY_MASK     | \
> +                           R_CR_HSERDY_MASK     | \
> +                           R_CR_HSIRDY_MASK     | \
> +                           R_CR_MSIRDY_MASK)
> +#define CR_READ_SET_MASK (R_CR_CSSON_MASK | R_CR_MSIRGSEL_MASK)
> +#define ICSCR_READ_ONLY_MASK (R_ICSCR_HSICAL_MASK | R_ICSCR_MSICAL_MASK)
> +#define CFGR_READ_ONLY_MASK (R_CFGR_SWS_MASK)
> +#define CIFR_READ_ONLY_MASK (R_CIFR_LSECSSF_MASK     | \
> +                             R_CIFR_CSSF_MASK        | \
> +                             R_CIFR_PLLSAI2RDYF_MASK | \
> +                             R_CIFR_PLLSAI1RDYF_MASK | \
> +                             R_CIFR_PLLRDYF_MASK     | \
> +                             R_CIFR_HSERDYF_MASK     | \
> +                             R_CIFR_HSIRDYF_MASK     | \
> +                             R_CIFR_MSIRDYF_MASK     | \
> +                             R_CIFR_LSERDYF_MASK     | \
> +                             R_CIFR_LSIRDYF_MASK)
> +#define CIFR_IRQ_MASK CIFR_READ_ONLY_MASK
> +#define APB2ENR_READ_SET_MASK (R_APB2ENR_FWEN_MASK)
> +#define BDCR_READ_ONLY_MASK (R_BDCR_LSECSSD_MASK | R_BDCR_LSERDY_MASK)
> +#define CSR_READ_ONLY_MASK (R_CSR_LPWRRSTF_MASK | \
> +                            R_CSR_WWDGRSTF_MASK | \
> +                            R_CSR_IWWGRSTF_MASK | \
> +                            R_CSR_SFTRSTF_MASK  | \
> +                            R_CSR_BORRSTF_MASK  | \
> +                            R_CSR_PINRSTF_MASK  | \
> +                            R_CSR_OBLRSTF_MASK  | \
> +                            R_CSR_FWRSTF_MASK   | \
> +                            R_CSR_LSIRDY_MASK)
> +
> +#endif /* HW_STM32L4X5_RCC_INTERNALS_H */
> --
> 2.34.1
>
>

