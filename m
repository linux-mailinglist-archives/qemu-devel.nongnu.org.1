Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D44D816576
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 04:54:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rF4gR-0001k2-MV; Sun, 17 Dec 2023 22:52:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rF4gO-0001jC-O5; Sun, 17 Dec 2023 22:52:45 -0500
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rF4gM-0008B7-57; Sun, 17 Dec 2023 22:52:44 -0500
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7caa6ec63aaso790350241.2; 
 Sun, 17 Dec 2023 19:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702871560; x=1703476360; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uHLDoLQeQIqg6hapRpVW6VLGaNZ1YybiLx8fc8VOCv4=;
 b=Ot+LfYtpxNPYnvVlv05YNPy+XI3AExKnqJBOsPs/mvvSyKeVnXS1ppnoPuHzdsnQdh
 WNgd5/PdsZ1X1XFM9QhII/xFghM+rzfNse+X1tjPlLQJj9wOFSx+RC7xa7dVMxT3P4Iy
 u4zCfbF0sFghRNFF4qLjYLhIVsIemgf771rnXKdtI7RDm/IAOi+52U/OLogDe002TCii
 qExzfK6KFxBh1Sgo0niiqB4A2M2DIHUuaPj6Lpaq99BHdAiFLL8COZitrxB+0b1fEMtv
 O5kx6NBk+fBunLeSWSKW+ELDsH2BuwpAaaY0JwuPOsDFZr9TBYlam8wiSmsokcUExUCu
 gWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702871560; x=1703476360;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uHLDoLQeQIqg6hapRpVW6VLGaNZ1YybiLx8fc8VOCv4=;
 b=iAenGsHs/TEVP1MuHk2KiiIjvbWEMLdEhuvAYItbHiyxtIVuetttLtmhZPuys8QEIp
 Up5d2AVRgNC7Cu0OY3RsZ4cDW0R8DLq2g3ybqigfIGFDeqBuDMQgxSG3yrO5jaVMxn40
 AB3E756pPMYTRNZegeqYvvcbE8OhDqJl5VZg9MPqK/JmRwsjwYJoTErp7zquRvahFgQz
 P1H5zvnus3+SW2bdIuKx4m8PXYBNns0IdDDXhQM0BUzaKOEWw6tKOmyoYPVbAzm5mkyA
 JfQcZPKQE+Iu6aNx7AdFT0RG22v1qA39Qmnt/iuKsz5JhovjmEwUedIdAonTHNyyUAmE
 cHTg==
X-Gm-Message-State: AOJu0YzBMEKTGUSZeB8JbUr5NP97+KCG6dgLtA7zEZtJe9GGFMP+0wjn
 WJxxosIDjkk8SuSFD9GBAq/ZFEo/pxDZ0YkE7yk=
X-Google-Smtp-Source: AGHT+IFqmf8waIKeJIWmujensHQpVH/erJpkqO2ecwewMiTtNKUzEGUlyN4tj2fNay+qWeijApI0YeSOzGgBODCFMaw=
X-Received: by 2002:a05:6102:2d07:b0:466:9ec3:5cd2 with SMTP id
 ih7-20020a0561022d0700b004669ec35cd2mr112926vsb.50.1702871560346; Sun, 17 Dec
 2023 19:52:40 -0800 (PST)
MIME-Version: 1.0
References: <170223510627.13579.3191933474458037037-0@git.sr.ht>
 <170223510627.13579.3191933474458037037-1@git.sr.ht>
In-Reply-To: <170223510627.13579.3191933474458037037-1@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 Dec 2023 13:52:13 +1000
Message-ID: <CAKmqyKNAGdc0fTErV4yb0PZYdJ9YraEn0EnRbWYcRCuwymoQvQ@mail.gmail.com>
Subject: Re: [PATCH qemu 1/3] hw/misc: Implement STM32L4xx SYSCFG
To: "~inesvarhol" <inesvarhol@proton.me>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alistair@alistair23.me, 
 philmd@linaro.org, peter.maydell@linaro.org, ines.varhol@telecom-paris.fr, 
 arnaud.minier@telecom-paris.fr
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

On Mon, Dec 11, 2023 at 5:06=E2=80=AFAM ~inesvarhol <inesvarhol@git.sr.ht> =
wrote:
>
> From: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> ---
>  hw/misc/Kconfig                    |   3 +
>  hw/misc/meson.build                |   1 +
>  hw/misc/stm32l4xx_syscfg.c         | 277 +++++++++++++++++++++++++++++
>  hw/misc/trace-events               |   6 +
>  include/hw/misc/stm32l4xx_syscfg.h |  62 +++++++
>  5 files changed, 349 insertions(+)
>  create mode 100644 hw/misc/stm32l4xx_syscfg.c
>  create mode 100644 include/hw/misc/stm32l4xx_syscfg.h
>
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 3efe3dc2cc..a20427a9be 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -90,6 +90,9 @@ config STM32F4XX_EXTI
>  config STM32L4X5_EXTI
>      bool
>
> +config STM32L4XX_SYSCFG
> +    bool
> +
>  config MIPS_ITU
>      bool
>
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 16db6e228d..120c59d9f4 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -111,6 +111,7 @@ system_ss.add(when: 'CONFIG_STM32F2XX_SYSCFG', if_tru=
e: files('stm32f2xx_syscfg.
>  system_ss.add(when: 'CONFIG_STM32F4XX_SYSCFG', if_true: files('stm32f4xx=
_syscfg.c'))
>  system_ss.add(when: 'CONFIG_STM32F4XX_EXTI', if_true: files('stm32f4xx_e=
xti.c'))
>  system_ss.add(when: 'CONFIG_STM32L4X5_EXTI', if_true: files('stm32l4x5_e=
xti.c'))
> +system_ss.add(when: 'CONFIG_STM32L4XX_SYSCFG', if_true: files('stm32l4xx=
_syscfg.c'))
>  system_ss.add(when: 'CONFIG_MPS2_FPGAIO', if_true: files('mps2-fpgaio.c'=
))
>  system_ss.add(when: 'CONFIG_MPS2_SCC', if_true: files('mps2-scc.c'))
>
> diff --git a/hw/misc/stm32l4xx_syscfg.c b/hw/misc/stm32l4xx_syscfg.c
> new file mode 100644
> index 0000000000..a8ef370117
> --- /dev/null
> +++ b/hw/misc/stm32l4xx_syscfg.c
> @@ -0,0 +1,277 @@
> +/*
> + * STM32L4xx SYSCFG (System Configuration Controller)
> + *
> + * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
> + * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
> + * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
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
> + *
> + * Based on the stm32f4xx_syscfg by Alistair Francis.
> + * The reference used is the STMicroElectronics RM0351 Reference manual
> + * for STM32L4x5 and STM32L4x6 advanced Arm =C2=AE -based 32-bit MCUs.
> + * https://www.st.com/en/microcontrollers-microprocessors/stm32l4x5/docu=
mentation.html
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "trace.h"
> +#include "hw/irq.h"
> +#include "migration/vmstate.h"
> +#include "hw/misc/stm32l4xx_syscfg.h"
> +
> +#define NUM_GPIOS 7
> +
> +#define SYSCFG_MEMRMP 0x00
> +#define SYSCFG_CFGR1 0x04
> +#define SYSCFG_EXTICR1 0x08
> +#define SYSCFG_EXTICR2 0x0C
> +#define SYSCFG_EXTICR3 0x10
> +#define SYSCFG_EXTICR4 0x14
> +#define SYSCFG_SCSR 0x18
> +#define SYSCFG_CFGR2 0x1C
> +#define SYSCFG_SWPR 0x20
> +#define SYSCFG_SKR 0x24
> +#define SYSCFG_SWPR2 0x28
> +
> +/* 00000000_00000000_00000001_00000111 */
> +#define ACTIVABLE_BITS_MEMRP 0x00000107
> +
> +/* 11111100_11111111_00000001_00000000 */
> +#define ACTIVABLE_BITS_CFGR1 0xFCFF0100
> +/* 00000000_00000000_00000000_00000001 */
> +#define FIREWALL_DISABLE_CFGR1 0x00000001
> +
> +/* 00000000_00000000_00000000_00000001 */
> +#define ACTIVABLE_BITS_EXTICR 0x0000FFFF

This doesn't match the comment

> +
> +/* 00000000_00000000_00000000_00000011 */
> +/* #define ACTIVABLE_BITS_SCSR 0x00000003 */
> +
> +/* 00000000_00000000_00000000_00001111 */
> +#define ECC_LOCK_CFGR2 0x0000000F
> +/* 00000000_00000000_00000001_00000000 */
> +#define SRAM2_PARITY_ERROR_FLAG_CFGR2 0x00000100
> +
> +/* 00000000_00000000_00000000_11111111 */
> +#define ACTIVABLE_BITS_SKR 0x000000FF
> +
> +static void stm32l4xx_syscfg_hold_reset(Object *obj)
> +{
> +    STM32L4xxSyscfgState *s =3D STM32L4XX_SYSCFG(obj);
> +
> +    s->memrmp =3D 0x00000000;
> +    s->cfgr1 =3D 0x7C000001;
> +    s->exticr[0] =3D 0x00000000;
> +    s->exticr[1] =3D 0x00000000;
> +    s->exticr[2] =3D 0x00000000;
> +    s->exticr[3] =3D 0x00000000;
> +    s->scsr =3D 0x00000000;
> +    s->cfgr2 =3D 0x00000000;
> +    s->swpr =3D 0x00000000;
> +    s->skr =3D 0x00000000;
> +    s->swpr2 =3D 0x00000000;
> +}
> +
> +static void stm32l4xx_syscfg_set_irq(void *opaque, int irq, int level)
> +{
> +    STM32L4xxSyscfgState *s =3D opaque;
> +    uint8_t gpio =3D irq / 16;
> +    g_assert(gpio < NUM_GPIOS);
> +
> +    int line =3D irq % 16;
> +    int exticr_reg =3D line / 4;
> +    int startbit =3D (irq % 4) * 4;
> +
> +    trace_stm32l4xx_syscfg_set_irq(gpio, irq % 16, level);

`irq % 16` is just `line`

Also it would probably be worth replacing the 16 with a macro.

Otherwise looks good

Alistair

> +
> +    if (extract32(s->exticr[exticr_reg], startbit, 4) =3D=3D gpio) {
> +        trace_stm32l4xx_syscfg_pulse_exti(line);
> +        qemu_set_irq(s->gpio_out[line], level);
> +   }
> +}
> +
> +static uint64_t stm32l4xx_syscfg_read(void *opaque, hwaddr addr,
> +                                     unsigned int size)
> +{
> +    STM32L4xxSyscfgState *s =3D opaque;
> +
> +    trace_stm32l4xx_syscfg_read(addr);
> +
> +    switch (addr) {
> +    case SYSCFG_MEMRMP:
> +        return s->memrmp;
> +    case SYSCFG_CFGR1:
> +        return s->cfgr1;
> +    case SYSCFG_EXTICR1...SYSCFG_EXTICR4:
> +        return s->exticr[(addr - SYSCFG_EXTICR1) / 4];
> +    case SYSCFG_SCSR:
> +        return s->scsr;
> +    case SYSCFG_CFGR2:
> +        return s->cfgr2;
> +    case SYSCFG_SWPR:
> +        return s->swpr;
> +    case SYSCFG_SKR:
> +        return s->skr;
> +    case SYSCFG_SWPR2:
> +        return s->swpr2;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, add=
r);
> +        return 0;
> +    }
> +}
> +
> +static void stm32l4xx_syscfg_write(void *opaque, hwaddr addr,
> +                       uint64_t val64, unsigned int size)
> +{
> +    STM32L4xxSyscfgState *s =3D opaque;
> +    uint32_t value =3D val64;
> +
> +    trace_stm32l4xx_syscfg_write(value, addr);
> +
> +    switch (addr) {
> +    case SYSCFG_MEMRMP:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: Changing the memory mapping isn't supported\n=
",
> +                      __func__);
> +        s->memrmp =3D value & ACTIVABLE_BITS_MEMRP;
> +        return;
> +    case SYSCFG_CFGR1:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: Functions in CFGRx aren't supported\n",
> +                      __func__);
> +        /* bit 0 (firewall dis.) is cleared by software, set only by res=
et. */
> +        s->cfgr1 =3D (s->cfgr1 & value & FIREWALL_DISABLE_CFGR1) |
> +                          (value & ACTIVABLE_BITS_CFGR1);
> +        return;
> +    case SYSCFG_EXTICR1...SYSCFG_EXTICR4:
> +        s->exticr[(addr - SYSCFG_EXTICR1) / 4] =3D
> +                (value & ACTIVABLE_BITS_EXTICR);
> +        return;
> +    case SYSCFG_SCSR:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: Erasing SRAM2 isn't supported\n",
> +                      __func__);
> +        /*
> +         * only non reserved bits are :
> +         * bit 0 (write-protected by a passkey), bit 1 (meant to be read=
)
> +         * so it serves no purpose yet to add :
> +         * s->scsr =3D value & 0x3;
> +         */
> +        return;
> +    case SYSCFG_CFGR2:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: Functions in CFGRx aren't supported\n",
> +                      __func__);
> +        /* bit 8 (SRAM2 PEF) is cleared by software by writing a '1'.*/
> +        /* bits[3:0] (ECC Lock) are set by software, cleared only by res=
et.*/
> +        s->cfgr2 =3D (s->cfgr2 | (value & ECC_LOCK_CFGR2)) &
> +                          ~(value & SRAM2_PARITY_ERROR_FLAG_CFGR2);
> +        return;
> +    case SYSCFG_SWPR:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: Write protecting SRAM2 isn't supported\n",
> +                      __func__);
> +        /* These bits are set by software and cleared only by reset.*/
> +        s->swpr |=3D value;
> +        return;
> +    case SYSCFG_SKR:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: Erasing SRAM2 isn't supported\n",
> +                      __func__);
> +        s->skr =3D value & ACTIVABLE_BITS_SKR;
> +        return;
> +    case SYSCFG_SWPR2:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: Write protecting SRAM2 isn't supported\n",
> +                      __func__);
> +        /* These bits are set by software and cleared only by reset.*/
> +        s->swpr2 |=3D value;
> +        return;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, add=
r);
> +    }
> +}
> +
> +static const MemoryRegionOps stm32l4xx_syscfg_ops =3D {
> +    .read =3D stm32l4xx_syscfg_read,
> +    .write =3D stm32l4xx_syscfg_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .impl.min_access_size =3D 4,
> +    .impl.max_access_size =3D 4,
> +    .impl.unaligned =3D false,
> +    .valid.min_access_size =3D 4,
> +    .valid.max_access_size =3D 4,
> +    .valid.unaligned =3D false,
> +};
> +
> +static void stm32l4xx_syscfg_init(Object *obj)
> +{
> +    STM32L4xxSyscfgState *s =3D STM32L4XX_SYSCFG(obj);
> +
> +    memory_region_init_io(&s->mmio, obj, &stm32l4xx_syscfg_ops, s,
> +                          TYPE_STM32L4XX_SYSCFG, 0x400);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +
> +    qdev_init_gpio_in(DEVICE(obj), stm32l4xx_syscfg_set_irq, 16 * NUM_GP=
IOS);
> +    qdev_init_gpio_out(DEVICE(obj), s->gpio_out, 16);
> +}
> +
> +static const VMStateDescription vmstate_stm32l4xx_syscfg =3D {
> +    .name =3D TYPE_STM32L4XX_SYSCFG,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32(memrmp, STM32L4xxSyscfgState),
> +        VMSTATE_UINT32(cfgr1, STM32L4xxSyscfgState),
> +        VMSTATE_UINT32_ARRAY(exticr, STM32L4xxSyscfgState,
> +                             SYSCFG_NUM_EXTICR),
> +        VMSTATE_UINT32(scsr, STM32L4xxSyscfgState),
> +        VMSTATE_UINT32(cfgr2, STM32L4xxSyscfgState),
> +        VMSTATE_UINT32(swpr, STM32L4xxSyscfgState),
> +        VMSTATE_UINT32(skr, STM32L4xxSyscfgState),
> +        VMSTATE_UINT32(swpr2, STM32L4xxSyscfgState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void stm32l4xx_syscfg_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> +
> +    dc->vmsd =3D &vmstate_stm32l4xx_syscfg;
> +    rc->phases.hold =3D stm32l4xx_syscfg_hold_reset;
> +}
> +
> +static const TypeInfo stm32l4xx_syscfg_info[] =3D {
> +    {
> +        .name          =3D TYPE_STM32L4XX_SYSCFG,
> +        .parent        =3D TYPE_SYS_BUS_DEVICE,
> +        .instance_size =3D sizeof(STM32L4xxSyscfgState),
> +        .instance_init =3D stm32l4xx_syscfg_init,
> +        .class_init    =3D stm32l4xx_syscfg_class_init,
> +    }
> +};
> +
> +DEFINE_TYPES(stm32l4xx_syscfg_info)
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 2f01c62c0e..756cb45bd6 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -163,6 +163,12 @@ stm32f4xx_exti_set_irq(int irq, int level) "Set EXTI=
: %d to %d"
>  stm32f4xx_exti_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
>  stm32f4xx_exti_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%=
" PRIx64 " val: 0x%" PRIx64 ""
>
> +# stm32l4xx_syscfg.c
> +stm32l4xx_syscfg_set_irq(int gpio, int line, int level) "irq from GPIO: =
%d, line: %d, level: %d"
> +stm32l4xx_syscfg_pulse_exti(int irq) "irq %d forwarded to EXTI"
> +stm32l4xx_syscfg_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
> +stm32l4xx_syscfg_write(uint64_t addr, uint64_t data) "reg write: addr: 0=
x%" PRIx64 " val: 0x%" PRIx64 ""
> +
>  # stm32l4x5_exti.c
>  stm32l4x5_exti_set_irq(int irq, int level) "Set EXTI: %d to %d"
>  stm32l4x5_exti_read(uint64_t addr, uint64_t data) "reg read: addr: 0x%" =
PRIx64 " val: 0x%" PRIx64 ""
> diff --git a/include/hw/misc/stm32l4xx_syscfg.h b/include/hw/misc/stm32l4=
xx_syscfg.h
> new file mode 100644
> index 0000000000..d9ed4da74e
> --- /dev/null
> +++ b/include/hw/misc/stm32l4xx_syscfg.h
> @@ -0,0 +1,62 @@
> +/*
> + * STM32L4xx SYSCFG (System Configuration Controller)
> + *
> + * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
> + * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
> + * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
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
> + *
> + * Based on the stm32f4xx_syscfg by Alistair Francis.
> + * The reference used is the STMicroElectronics RM0351 Reference manual
> + * for STM32L4x5 and STM32L4x6 advanced Arm =C2=AE -based 32-bit MCUs.
> + * https://www.st.com/en/microcontrollers-microprocessors/stm32l4x5/docu=
mentation.html
> + */
> +
> +#ifndef HW_STM32L4XX_SYSCFG_H
> +#define HW_STM32L4XX_SYSCFG_H
> +
> +#include "hw/sysbus.h"
> +#include "qom/object.h"
> +
> +#define TYPE_STM32L4XX_SYSCFG "stm32l4xx-syscfg"
> +OBJECT_DECLARE_SIMPLE_TYPE(STM32L4xxSyscfgState, STM32L4XX_SYSCFG)
> +
> +#define SYSCFG_NUM_EXTICR 4
> +
> +struct STM32L4xxSyscfgState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mmio;
> +
> +    uint32_t memrmp;
> +    uint32_t cfgr1;
> +    uint32_t exticr[SYSCFG_NUM_EXTICR];
> +    uint32_t scsr;
> +    uint32_t cfgr2;
> +    uint32_t swpr;
> +    uint32_t skr;
> +    uint32_t swpr2;
> +
> +    qemu_irq gpio_out[16];
> +};
> +
> +#endif
> --
> 2.38.5
>
>

