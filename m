Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB17823B46
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 04:45:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLEdx-0004un-1v; Wed, 03 Jan 2024 22:43:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rLEdZ-0004qv-SH; Wed, 03 Jan 2024 22:43:19 -0500
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rLEdX-0006tK-La; Wed, 03 Jan 2024 22:43:17 -0500
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-4b732dfa6e4so28253e0c.1; 
 Wed, 03 Jan 2024 19:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704339794; x=1704944594; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CDW1i/LNCdDrDdmh5cUciopryzeORMo2ZkjJjPLY5vw=;
 b=fSn7sgNP1LDwjYHDjwcE3hW892VFvyeSZCFY6pmXHblKqXH8GDQt3J3UA6bVK1SEQM
 SUV7CAibRiSM2Ep6wrzjT0c+FkYq9o+Cq+RSVV6IP1alstGHfiN/A4qM/9Y/puQlEvPd
 pgrbKnpwZ0FO2A2NyAVNgzXMHWyfirnJ94HHhweQ3GoltKvC8yFrnpRVHMi27PBLF8Q3
 OtFrI3ZwqzexZf9fce+lYhSgLDOH+VvL7GSMFENvdn1TYFiCywasEC34Ir5OBl49EtoV
 4+PR9NenrUA9RD+rty3IsUrEq1yR2DIi3nf34PqRAafGeC9scLKppGZ7IZ0BUSg29dFP
 cVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704339794; x=1704944594;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CDW1i/LNCdDrDdmh5cUciopryzeORMo2ZkjJjPLY5vw=;
 b=C235J0Aaf1N3CZEDuf7P3F9a0xkV97nN2U9zyezNklE7M4A6Xf0TpAgprTfLFViup3
 69ezSuf9vHpr/cz4BnM+5HykeSOaHhdm76u51aF9z+WqJJegm4pr3MgTGB8Wx67yR8G9
 XB9q3/MNTKP018lOTLHfSuNTP2dKKMwQbTDnTvLgTpPigBoD16CDMGy3KbT+neLYm/Rr
 j6UEkrgjG/sysXHFZkZ/V88MDSAZ9BPuldco47FiIArZhAViD4Dd19Qf5lDYzvFk++31
 49cLQJNdyT/GbC3cVEdbHPIf5i50J0V1PncSmNrnN4KAlvD5dUsGhTJMHku+AvWFi6cL
 HxFg==
X-Gm-Message-State: AOJu0YzR7n9tNicAPCXZ6EnsSx37YQymTlEdWKkrffHFNxYPSVjRhA7Z
 CFd/FHANh4yEriTyDfg5z0TR5Vq4z6KckJPv7UE=
X-Google-Smtp-Source: AGHT+IHGTvSwaoi7/ZqabKfGtaxx3rFPvfrL2IlMI+jdMpbpgarRDruK4y/WfIbL54PX/y8Ch672gv1hz3En5vgr+xo=
X-Received: by 2002:ac5:c28e:0:b0:4b7:3875:72d2 with SMTP id
 h14-20020ac5c28e000000b004b7387572d2mr10817vkk.1.1704339793987; Wed, 03 Jan
 2024 19:43:13 -0800 (PST)
MIME-Version: 1.0
References: <20231228161944.303768-1-ines.varhol@telecom-paris.fr>
 <20231228161944.303768-4-ines.varhol@telecom-paris.fr>
In-Reply-To: <20231228161944.303768-4-ines.varhol@telecom-paris.fr>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 4 Jan 2024 13:42:48 +1000
Message-ID: <CAKmqyKM8qPYkKUnMni8kRwQSDZW+eZc7RcQ+GPHFs16Y0-YwAA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] hw/arm: Connect STM32L4x5 EXTI to STM32L4x5 SoC
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2d.google.com
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

On Fri, Dec 29, 2023 at 2:21=E2=80=AFAM In=C3=A8s Varhol
<ines.varhol@telecom-paris.fr> wrote:
>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/Kconfig                 |  1 +
>  hw/arm/stm32l4x5_soc.c         | 56 ++++++++++++++++++++++++++++++++--
>  include/hw/arm/stm32l4x5_soc.h |  3 ++
>  3 files changed, 58 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 7520dc5cc0..9c9d5bb541 100644
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
> index 7513db0d6a..08b8a4c2ed 100644
> --- a/hw/arm/stm32l4x5_soc.c
> +++ b/hw/arm/stm32l4x5_soc.c
> @@ -36,10 +36,51 @@
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
> @@ -50,7 +91,9 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc,=
 Error **errp)
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
> @@ -115,6 +158,16 @@ static void stm32l4x5_soc_realize(DeviceState *dev_s=
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
> +        sysbus_connect_irq(busdev, i, qdev_get_gpio_in(armv7m, exti_irq[=
i]));
> +    }
> +
>      /* APB1 BUS */
>      create_unimplemented_device("TIM2",      0x40000000, 0x400);
>      create_unimplemented_device("TIM3",      0x40000400, 0x400);
> @@ -155,7 +208,6 @@ static void stm32l4x5_soc_realize(DeviceState *dev_so=
c, Error **errp)
>      create_unimplemented_device("SYSCFG",    0x40010000, 0x30);
>      create_unimplemented_device("VREFBUF",   0x40010030, 0x1D0);
>      create_unimplemented_device("COMP",      0x40010200, 0x200);
> -    create_unimplemented_device("EXTI",      0x40010400, 0x400);
>      /* RESERVED:    0x40010800, 0x1400 */
>      create_unimplemented_device("FIREWALL",  0x40011C00, 0x400);
>      /* RESERVED:    0x40012000, 0x800 */
> diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_so=
c.h
> index dce13a023d..6cba566a31 100644
> --- a/include/hw/arm/stm32l4x5_soc.h
> +++ b/include/hw/arm/stm32l4x5_soc.h
> @@ -28,6 +28,7 @@
>  #include "qemu/units.h"
>  #include "hw/qdev-core.h"
>  #include "hw/arm/armv7m.h"
> +#include "hw/misc/stm32l4x5_exti.h"
>  #include "qom/object.h"
>
>  #define TYPE_STM32L4X5_SOC "stm32l4x5-soc"
> @@ -41,6 +42,8 @@ struct Stm32l4x5SocState {
>
>      ARMv7MState armv7m;
>
> +    Stm32l4x5ExtiState exti;
> +
>      MemoryRegion sram1;
>      MemoryRegion sram2;
>      MemoryRegion flash;
> --
> 2.43.0
>
>

