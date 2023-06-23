Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FC873AE65
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 03:39:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCVkP-0002Rq-4R; Thu, 22 Jun 2023 21:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qCVkN-0002RM-4x; Thu, 22 Jun 2023 21:37:59 -0400
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qCVkK-0003wf-Ck; Thu, 22 Jun 2023 21:37:58 -0400
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-440cff7870aso943252137.1; 
 Thu, 22 Jun 2023 18:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687484274; x=1690076274;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e27fUhqNOLbplBkkrIGFoFH92mbPDVveE0Gs3sJaIKc=;
 b=Z0Ty3Lt+k+eKCTOuZKWrgj3sjl3u4WCU4oVzfkgQzjGqM0EgDeyzqL64je1vYk4rBW
 vVhQhfm2c+GiEGNPNiGTv9eKfArUmPDtdAb2HEb00ufD/qVCXWMgTFOTT5CGQ2/MOYVM
 jHJBUnNakZNHQMV5TRgYJB+alCTsntu7hAo7fX2msiP8tBIDwBHQ9IB3ihQ5JawHA4wO
 xr3+7Em2pd4C70hUvtUWH7XpfzzHFZXVQiYioLNZ2HSCGPfXaJCK61hAd1EsPfCpwr4Y
 CXYFx8Cf4mSg0JcC6gaqg+MOFZZAoJB2Z/I/149pAmX2QvNCiXfdPMnFfuahmDzkhuOu
 ZIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687484274; x=1690076274;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e27fUhqNOLbplBkkrIGFoFH92mbPDVveE0Gs3sJaIKc=;
 b=LNFw7zqmDM1nbsS0eQDnT/asmvGrRXhlmeaAUqeu8ghAODSO3mt4truz7VRT6G7YfV
 Fx3YEP26VZwe8xcl4MPobliM2wCe9Pykejj/lvHYBiWAYPKypKb2OrZROH3WpnLCqv+7
 xnGfL2Z9sO82Dl9zxsPiiQnvWK3+k3llCQSqyhEJXgMa8ELFpCpWNFTCrX9o4oL7tJBl
 mYDjqR3di9hQTnSD/W6eYNXs8Nm9TiMf1oH9vr9l2/x0THj5V3byYkBJNj1dXBiXBuI1
 wc2d4b7TglJCKA05Dg+1Ub3xUdU978SgeGAlgib+qO4HWQIxQrSAPHqz09/W/qpaFIw/
 52Ug==
X-Gm-Message-State: AC+VfDxiqjVEz+W+18UIz/vwkdJKIh/j/MiTQszDgyPpowC1+AQ5mo9N
 wI7s4VCbRjVi4SNCWG/zaiTnKi+sCCNYFNK0hDE=
X-Google-Smtp-Source: ACHHUZ7aVrGiduY89kVs8xOKPW3q1Y/K7Wfbl+07fYAKUHEUMmstUK7lM4Dw6SABxvy0U5TmJzvcs8TiOKw9D+bo/SU=
X-Received: by 2002:a05:6102:1516:b0:43f:34a0:cc92 with SMTP id
 f22-20020a056102151600b0043f34a0cc92mr5874185vsv.1.1687484274173; Thu, 22 Jun
 2023 18:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230619221819.6882-1-lucas@osdyne.com>
 <20230620194317.45772-1-lucas@osdyne.com>
In-Reply-To: <20230620194317.45772-1-lucas@osdyne.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 Jun 2023 11:37:28 +1000
Message-ID: <CAKmqyKM1T6n3pKQV3ZuxDTHXurOOLE4W_33mk8cc9hM3cuGNpA@mail.gmail.com>
Subject: Re: [PATCH] STM32F100: add support for external memory via FSMC
To: Lucas Villa Real <lucas@osdyne.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, erdnaxe@crans.org, 
 "Lucas C . Villa Real" <lucas@odsyne.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e30;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe30.google.com
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

On Wed, Jun 21, 2023 at 5:44=E2=80=AFAM Lucas Villa Real <lucas@osdyne.com>=
 wrote:
>
> Add support for FSMC on high-density STM32F100 devices and enable
> mapping of additional memory via the `-m SIZE` command-line option.
> FSMC Bank1 can address up to 4x64MB of PSRAM memory at 0x60000000.

Thanks for the patches!

>
> RCC is needed to enable peripheral clock for FSMC; this commit
> implements support for RCC through the MMIO interface.

This should be a separate commit. The idea is to break commits up as
small as possible and send a patch series, this makes review much
easier. Each new feature should be its own commit.

>
> Last, high-density devices support up to 32KB of static SRAM, so
> adjust SRAM_SIZE accordingly.

Also, can you include a link to the documentation in the commit message?

>
> Signed-off-by: Lucas C. Villa Real <lucas@odsyne.com>
> ---
>  docs/system/arm/stm32.rst        |  12 ++-
>  hw/arm/Kconfig                   |   1 +
>  hw/arm/stm32f100_soc.c           | 102 +++++++++++++++++++-
>  hw/arm/stm32f1_generic.c         |  12 +++
>  hw/misc/Kconfig                  |   3 +
>  hw/misc/meson.build              |   1 +
>  hw/misc/stm32f1xx_fsmc.c         | 155 +++++++++++++++++++++++++++++++
>  include/hw/arm/stm32f100_soc.h   |  24 ++++-
>  include/hw/misc/stm32f1xx_fsmc.h |  62 +++++++++++++
>  9 files changed, 368 insertions(+), 4 deletions(-)
>  create mode 100644 hw/misc/stm32f1xx_fsmc.c
>  create mode 100644 include/hw/misc/stm32f1xx_fsmc.h
>
> diff --git a/docs/system/arm/stm32.rst b/docs/system/arm/stm32.rst
> index d0a3b1a7eb..40de58ed04 100644
> --- a/docs/system/arm/stm32.rst
> +++ b/docs/system/arm/stm32.rst
> @@ -40,6 +40,8 @@ Supported devices
>   * SPI controller
>   * System configuration (SYSCFG)
>   * Timer controller (TIMER)
> + * Reset and Clock Controller (RCC)
> + * Flexible static memory controller (FSMC)
>
>  Missing devices
>  ---------------
> @@ -57,7 +59,6 @@ Missing devices
>   * Power supply configuration (PWR)
>   * Random Number Generator (RNG)
>   * Real-Time Clock (RTC) controller
> - * Reset and Clock Controller (RCC)
>   * Secure Digital Input/Output (SDIO) interface
>   * USB OTG
>   * Watchdog controller (IWDG, WWDG)
> @@ -78,4 +79,11 @@ to select the device density line.  The following valu=
es are supported:
>
>  .. code-block:: bash
>
> -  $ qemu-system-arm -M stm32f1-generic -global stm32f100-soc.density=3Dm=
edium ...
> \ No newline at end of file
> +  $ qemu-system-arm -M stm32f1-generic -global stm32f100-soc.density=3Dm=
edium ...
> +
> +High-density devices can also enable up to 256 MB of external memory usi=
ng
> +the `-m SIZE` option. The memory is mapped at address 0x60000000. Exampl=
e:
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-arm -M stm32f1-generic -m 64M ...
> \ No newline at end of file
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 822441945c..dd48068108 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -433,6 +433,7 @@ config RASPI
>  config STM32F100_SOC
>      bool
>      select ARM_V7M
> +    select STM32F1XX_FSMC
>      select STM32F2XX_USART
>      select STM32F2XX_SPI
>
> diff --git a/hw/arm/stm32f100_soc.c b/hw/arm/stm32f100_soc.c
> index c157ffd644..a2b863d309 100644
> --- a/hw/arm/stm32f100_soc.c
> +++ b/hw/arm/stm32f100_soc.c
> @@ -26,6 +26,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qemu/module.h"
> +#include "qemu/log.h"
>  #include "hw/arm/boot.h"
>  #include "exec/address-spaces.h"
>  #include "hw/arm/stm32f100_soc.h"
> @@ -40,9 +41,85 @@ static const uint32_t usart_addr[STM_NUM_USARTS] =3D {=
 0x40013800, 0x40004400,
>      0x40004800 };
>  static const uint32_t spi_addr[STM_NUM_SPIS] =3D { 0x40013000, 0x4000380=
0,
>      0x40003C00 };
> +static const uint32_t fsmc_addr =3D 0xA0000000;
>
>  static const int usart_irq[STM_NUM_USARTS] =3D {37, 38, 39};
>  static const int spi_irq[STM_NUM_SPIS] =3D {35, 36, 51};
> +static const int fsmc_irq =3D 48;
> +
> +static uint64_t stm32f100_rcc_read(void *h, hwaddr offset, unsigned size=
)
> +{
> +    STM32F100State *s =3D (STM32F100State *) h;
> +    switch (offset) {
> +    case 0x00:
> +        return s->rcc.cr;
> +    case 0x04:
> +        return s->rcc.cfgr;
> +    case 0x08:
> +        return s->rcc.cir;
> +    case 0x0C:
> +        return s->rcc.apb2rstr;
> +    case 0x10:
> +        return s->rcc.apb1rstr;
> +    case 0x14:
> +        return s->rcc.ahbenr;
> +    case 0x18:
> +        return s->rcc.apb2enr;
> +    case 0x1C:
> +        return s->rcc.apb1enr;
> +    case 0x20:
> +        return s->rcc.bdcr;
> +    case 0x24:
> +        return s->rcc.csr;
> +    case 0x2C:
> +        return s->rcc.cfgr2;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, off=
set);
> +    }
> +    return 0;
> +}
> +
> +static void stm32f100_rcc_write(void *h, hwaddr offset, uint64_t value64=
,
> +                                unsigned size)
> +{
> +    STM32F100State *s =3D (STM32F100State *) h;
> +    uint32_t value =3D value64 & 0xffffffff;
> +
> +    switch (offset) {
> +    case 0x00:
> +        s->rcc.cr =3D value;
> +    case 0x04:
> +        s->rcc.cfgr =3D value;
> +    case 0x08:
> +        s->rcc.cir =3D value;
> +    case 0x0C:
> +        s->rcc.apb2rstr =3D value;
> +    case 0x10:
> +        s->rcc.apb1rstr =3D value;
> +    case 0x14:
> +        s->rcc.ahbenr =3D value;
> +    case 0x18:
> +        s->rcc.apb2enr =3D value;
> +    case 0x1C:
> +        s->rcc.apb1enr =3D value;
> +    case 0x20:
> +        s->rcc.bdcr =3D value;
> +    case 0x24:
> +        s->rcc.csr =3D value;
> +    case 0x2C:
> +        s->rcc.cfgr2 =3D value;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, off=
set);
> +    }
> +}
> +
> +static const MemoryRegionOps stm32f100_rcc_ops =3D {
> +    .read =3D stm32f100_rcc_read,
> +    .write =3D stm32f100_rcc_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +};

This should be its own file and device that is included

Alistair

>
>  static void stm32f100_soc_initfn(Object *obj)
>  {
> @@ -66,6 +143,11 @@ static void stm32f100_soc_initfn(Object *obj)
>
>      /* Default density. May be overridden by the machine or cmdline opti=
on */
>      s->density =3D STM32F100_DENSITY_HIGH;
> +
> +    memset(&s->rcc, 0, sizeof(s->rcc));
> +    s->rcc.cr =3D 0x00000083;
> +    s->rcc.ahbenr =3D 0x00000014;
> +    s->rcc.csr =3D 0x0C000000;
>  }
>
>  static void stm32f100_soc_realize(DeviceState *dev_soc, Error **errp)
> @@ -168,6 +250,25 @@ static void stm32f100_soc_realize(DeviceState *dev_s=
oc, Error **errp)
>          sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, spi_irq[i=
]));
>      }
>
> +    /* Declare a simple memory-mapped I/O region for RCC */
> +    memory_region_init_io(&s->iomem, OBJECT(dev_soc), &stm32f100_rcc_ops=
, s,
> +                          "STM32F100.mmio.rcc", 0x400);
> +    memory_region_add_subregion(system_memory, 0x40021000, &s->iomem);
> +
> +    /* Declare an I/O region for FSMC */
> +    if (s->density =3D=3D STM32F100_DENSITY_HIGH) {
> +        object_initialize_child(OBJECT(dev_soc), "fsmc", &s->fsmc,
> +                                TYPE_STM32F1XX_FSMC);
> +
> +        dev =3D DEVICE(&s->fsmc);
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->fsmc), errp)) {
> +            return;
> +        }
> +        busdev =3D SYS_BUS_DEVICE(dev);
> +        sysbus_mmio_map(busdev, 0, fsmc_addr);
> +        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, fsmc_irq)=
);
> +    }
> +
>      create_unimplemented_device("timer[2]",  0x40000000, 0x400);
>      create_unimplemented_device("timer[3]",  0x40000400, 0x400);
>      create_unimplemented_device("timer[4]",  0x40000800, 0x400);
> @@ -203,7 +304,6 @@ static void stm32f100_soc_realize(DeviceState *dev_so=
c, Error **errp)
>      create_unimplemented_device("timer[17]", 0x40014800, 0x400);
>      create_unimplemented_device("DMA1",      0x40020000, 0x400);
>      create_unimplemented_device("DMA2",      0x40020400, 0x400);
> -    create_unimplemented_device("RCC",       0x40021000, 0x400);
>      create_unimplemented_device("Flash Int", 0x40022000, 0x400);
>      create_unimplemented_device("CRC",       0x40023000, 0x400);
>  }
> diff --git a/hw/arm/stm32f1_generic.c b/hw/arm/stm32f1_generic.c
> index 63d2a58bdc..6420542f1b 100644
> --- a/hw/arm/stm32f1_generic.c
> +++ b/hw/arm/stm32f1_generic.c
> @@ -30,6 +30,7 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/qdev-clock.h"
>  #include "qemu/error-report.h"
> +#include "exec/address-spaces.h"
>  #include "hw/arm/stm32f100_soc.h"
>  #include "hw/arm/boot.h"
>
> @@ -38,6 +39,7 @@
>
>  static void stm32f1_generic_init(MachineState *machine)
>  {
> +    MemoryRegion *psram1;
>      STM32F100State *s;
>      DeviceState *dev;
>      Clock *sysclk;
> @@ -59,6 +61,16 @@ static void stm32f1_generic_init(MachineState *machine=
)
>      armv7m_load_kernel(ARM_CPU(first_cpu),
>                         machine->kernel_filename,
>                         0, s->flash_size);
> +
> +    /* Allow assigning more RAM via FSMC on high-density devices */
> +    if (s->density =3D=3D STM32F100_DENSITY_HIGH) {
> +        assert(machine->ram_size <=3D PSRAM1_SIZE);
> +        psram1 =3D g_new(MemoryRegion, 1);
> +        memory_region_init_ram(psram1, NULL, "STM32F1-generic.psram1",
> +                               machine->ram_size, &error_fatal);
> +        memory_region_add_subregion(get_system_memory(),
> +                                    PSRAM1_BASE_ADDRESS, psram1);
> +    }
>  }
>
>  static void stm32f1_generic_machine_init(MachineClass *mc)
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index e4c2149175..002d34a123 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -73,6 +73,9 @@ config IMX
>      select SSI
>      select USB_EHCI_SYSBUS
>
> +config STM32F1XX_FSMC
> +    bool
> +
>  config STM32F2XX_SYSCFG
>      bool
>
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 78ca857c9d..a0b0786fd3 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -97,6 +97,7 @@ softmmu_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: fil=
es(
>    'xlnx-versal-xramc.c',
>    'xlnx-versal-pmc-iou-slcr.c',
>  ))
> +softmmu_ss.add(when: 'CONFIG_STM32F1XX_FSMC', if_true: files('stm32f1xx_=
fsmc.c'))
>  softmmu_ss.add(when: 'CONFIG_STM32F2XX_SYSCFG', if_true: files('stm32f2x=
x_syscfg.c'))
>  softmmu_ss.add(when: 'CONFIG_STM32F4XX_SYSCFG', if_true: files('stm32f4x=
x_syscfg.c'))
>  softmmu_ss.add(when: 'CONFIG_STM32F4XX_EXTI', if_true: files('stm32f4xx_=
exti.c'))
> diff --git a/hw/misc/stm32f1xx_fsmc.c b/hw/misc/stm32f1xx_fsmc.c
> new file mode 100644
> index 0000000000..8a9618bb31
> --- /dev/null
> +++ b/hw/misc/stm32f1xx_fsmc.c
> @@ -0,0 +1,155 @@
> +/*
> + * STM32F1XX FSMC
> + *
> + * Copyright (c) 2023 Lucas C. Villa Real <lucas@osdyne.com>
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
> +#include "qemu/osdep.h"
> +#include "hw/misc/stm32f1xx_fsmc.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +
> +static void stm32f1xx_fsmc_reset(DeviceState *dev)
> +{
> +    STM32F1XXFsmcState *s =3D STM32F1XX_FSMC(dev);
> +
> +    s->fsmc_bcr[0] =3D 0x000030DB;
> +    for (int i=3D1; i<4; ++i)
> +        s->fsmc_bcr[i] =3D 0x000030D2;
> +    for (int i=3D0; i<4; ++i) {
> +        s->fsmc_btr[i] =3D 0xffffffff;
> +        s->fsmc_bwtr[i] =3D 0xffffffff;
> +    }
> +}
> +
> +static uint64_t stm32f1xx_fsmc_read(void *opaque, hwaddr addr,
> +                                     unsigned int size)
> +{
> +    STM32F1XXFsmcState *s =3D opaque;
> +
> +    switch (addr) {
> +    case FSMC_BCR1:
> +        return s->fsmc_bcr[0];
> +    case FSMC_BCR2:
> +        return s->fsmc_bcr[1];
> +    case FSMC_BCR3:
> +        return s->fsmc_bcr[2];
> +    case FSMC_BCR4:
> +        return s->fsmc_bcr[3];
> +    case FSMC_BTR1:
> +        return s->fsmc_btr[0];
> +    case FSMC_BTR2:
> +        return s->fsmc_btr[1];
> +    case FSMC_BTR3:
> +        return s->fsmc_btr[2];
> +    case FSMC_BTR4:
> +        return s->fsmc_btr[3];
> +    case FSMC_BWTR1:
> +        return s->fsmc_bwtr[0];
> +    case FSMC_BWTR2:
> +        return s->fsmc_bwtr[1];
> +    case FSMC_BWTR3:
> +        return s->fsmc_bwtr[2];
> +    case FSMC_BWTR4:
> +        return s->fsmc_bwtr[3];
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, add=
r);
> +    }
> +
> +    return 0;
> +}
> +
> +static void stm32f1xx_fsmc_write(void *opaque, hwaddr addr,
> +                       uint64_t val64, unsigned int size)
> +{
> +    STM32F1XXFsmcState *s =3D opaque;
> +    uint32_t value =3D val64 & 0xffffffff;
> +
> +    switch (addr) {
> +    case FSMC_BCR1:
> +        s->fsmc_bcr[0] =3D value;
> +    case FSMC_BCR2:
> +        s->fsmc_bcr[1] =3D value;
> +    case FSMC_BCR3:
> +        s->fsmc_bcr[2] =3D value;
> +    case FSMC_BCR4:
> +        s->fsmc_bcr[3] =3D value;
> +    case FSMC_BTR1:
> +        s->fsmc_btr[0] =3D value;
> +    case FSMC_BTR2:
> +        s->fsmc_btr[1] =3D value;
> +    case FSMC_BTR3:
> +        s->fsmc_btr[2] =3D value;
> +    case FSMC_BTR4:
> +        s->fsmc_btr[3] =3D value;
> +    case FSMC_BWTR1:
> +        s->fsmc_bwtr[0] =3D value;
> +    case FSMC_BWTR2:
> +        s->fsmc_bwtr[1] =3D value;
> +    case FSMC_BWTR3:
> +        s->fsmc_bwtr[2] =3D value;
> +    case FSMC_BWTR4:
> +        s->fsmc_bwtr[3] =3D value;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, add=
r);
> +    }
> +}
> +
> +static const MemoryRegionOps stm32f1xx_fsmc_ops =3D {
> +    .read =3D stm32f1xx_fsmc_read,
> +    .write =3D stm32f1xx_fsmc_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static void stm32f1xx_fsmc_init(Object *obj)
> +{
> +    STM32F1XXFsmcState *s =3D STM32F1XX_FSMC(obj);
> +
> +    memory_region_init_io(&s->mmio, obj, &stm32f1xx_fsmc_ops, s,
> +                          TYPE_STM32F1XX_FSMC, 0x400);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +
> +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
> +}
> +
> +static void stm32f1xx_fsmc_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +
> +    dc->reset =3D stm32f1xx_fsmc_reset;
> +}
> +
> +static const TypeInfo stm32f1xx_fsmc_info =3D {
> +    .name          =3D TYPE_STM32F1XX_FSMC,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(STM32F1XXFsmcState),
> +    .instance_init =3D stm32f1xx_fsmc_init,
> +    .class_init    =3D stm32f1xx_fsmc_class_init,
> +};
> +
> +static void stm32f1xx_fsmc_register_types(void)
> +{
> +    type_register_static(&stm32f1xx_fsmc_info);
> +}
> +
> +type_init(stm32f1xx_fsmc_register_types)
> diff --git a/include/hw/arm/stm32f100_soc.h b/include/hw/arm/stm32f100_so=
c.h
> index 5305e342e3..0ce2439e38 100644
> --- a/include/hw/arm/stm32f100_soc.h
> +++ b/include/hw/arm/stm32f100_soc.h
> @@ -26,6 +26,7 @@
>  #define HW_ARM_STM32F100_SOC_H
>
>  #include "hw/char/stm32f2xx_usart.h"
> +#include "hw/misc/stm32f1xx_fsmc.h"
>  #include "hw/ssi/stm32f2xx_spi.h"
>  #include "hw/arm/armv7m.h"
>  #include "qom/object.h"
> @@ -42,8 +43,12 @@ OBJECT_DECLARE_SIMPLE_TYPE(STM32F100State, STM32F100_S=
OC)
>  #define FLASH_SIZE_LD (32 * 1024)
>  #define FLASH_SIZE_MD (128 * 1024)
>  #define FLASH_SIZE_HD (512 * 1024)
> +
>  #define SRAM_BASE_ADDRESS 0x20000000
> -#define SRAM_SIZE (8 * 1024)
> +#define SRAM_SIZE (32 * 1024)
> +
> +#define PSRAM1_BASE_ADDRESS 0x60000000
> +#define PSRAM1_SIZE (256 * 1024 * 1024)
>
>  /* Supported density value lines */
>  typedef enum {
> @@ -52,6 +57,20 @@ typedef enum {
>      STM32F100_DENSITY_HIGH,
>  } STM32F100Density;
>
> +typedef struct {
> +    uint32_t cr;
> +    uint32_t cfgr;
> +    uint32_t cir;
> +    uint32_t apb2rstr;
> +    uint32_t apb1rstr;
> +    uint32_t ahbenr;
> +    uint32_t apb2enr;
> +    uint32_t apb1enr;
> +    uint32_t bdcr;
> +    uint32_t csr;
> +    uint32_t cfgr2;
> +} STM32F1XXRccState;
> +
>  struct STM32F100State {
>      /*< private >*/
>      SysBusDevice parent_obj;
> @@ -63,10 +82,13 @@ struct STM32F100State {
>
>      STM32F2XXUsartState usart[STM_NUM_USARTS];
>      STM32F2XXSPIState spi[STM_NUM_SPIS];
> +    STM32F1XXFsmcState fsmc;
> +    STM32F1XXRccState rcc;
>
>      MemoryRegion sram;
>      MemoryRegion flash;
>      MemoryRegion flash_alias;
> +    MemoryRegion iomem;
>
>      Clock *sysclk;
>      Clock *refclk;
> diff --git a/include/hw/misc/stm32f1xx_fsmc.h b/include/hw/misc/stm32f1xx=
_fsmc.h
> new file mode 100644
> index 0000000000..1432d2da9e
> --- /dev/null
> +++ b/include/hw/misc/stm32f1xx_fsmc.h
> @@ -0,0 +1,62 @@
> +/*
> + * STM32F1xx FSMC
> + *
> + * Copyright (c) 2023 Lucas C. Villa Real <lucas@osdyne.com>
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
> +#ifndef HW_STM32F1XX_FSMC_H
> +#define HW_STM32F1XX_FSMC_H
> +
> +#include "hw/sysbus.h"
> +#include "qom/object.h"
> +
> +#define FSMC_BCR1  0x000
> +#define FSMC_BCR2  0x008
> +#define FSMC_BCR3  0x010
> +#define FSMC_BCR4  0x018
> +#define FSMC_BTR1  0x004
> +#define FSMC_BTR2  0x00C
> +#define FSMC_BTR3  0x014
> +#define FSMC_BTR4  0x01C
> +#define FSMC_BWTR1 0x104
> +#define FSMC_BWTR2 0x10C
> +#define FSMC_BWTR3 0x114
> +#define FSMC_BWTR4 0x11C
> +#define NUM_BANKS  4
> +
> +#define TYPE_STM32F1XX_FSMC "stm32f1xx-fsmc"
> +OBJECT_DECLARE_SIMPLE_TYPE(STM32F1XXFsmcState, STM32F1XX_FSMC)
> +
> +struct STM32F1XXFsmcState {
> +    /* <private> */
> +    SysBusDevice parent_obj;
> +
> +    /* <public> */
> +    MemoryRegion mmio;
> +
> +    uint32_t fsmc_bcr[NUM_BANKS];
> +    uint32_t fsmc_btr[NUM_BANKS];
> +    uint32_t fsmc_bwtr[NUM_BANKS];
> +
> +    qemu_irq irq;
> +};
> +
> +#endif
> --
> 2.39.2 (Apple Git-143)
>
>

