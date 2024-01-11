Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 081A982B813
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 00:32:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO4XB-0000W2-BP; Thu, 11 Jan 2024 18:32:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rO4X8-0000TI-QU; Thu, 11 Jan 2024 18:32:22 -0500
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rO4Wz-0001Pp-Rg; Thu, 11 Jan 2024 18:32:15 -0500
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-4b739b29686so3290420e0c.0; 
 Thu, 11 Jan 2024 15:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705015931; x=1705620731; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ecoc00QYwaJz8dIkPPEYb205rWMV7qbZJM9fu2YOHGU=;
 b=brf/ll8cMCgEYD08U1Bc+PTQvezyVlSvRQENg0/1Fpue9JAAuH7RGX6tMpr7LaZmTu
 51h1570irpjv6bTERAo3H2SWrs6Nj3uRLlUHWyHHdGHyAL8uHwr0RCfSRyyVegeVri4c
 rHNpF0Glx0Q532MetutEovV4uH6w19I9QIykk/BYaSxVcwyAM37syNeqIz3VX9W+t4+4
 0lOpj+7qGzTyLdNVLloxEHF8gNc0I8L4XTPdOeZzW1WpMKcLeNiAGBdmkuyssdTa4Zda
 eB7b4+z9MJSKa+xVIiGOkrtoBXe0GXFX9c2ICJGn1mDQaX56Xz7YrZxz4B5PUklcnzqH
 tyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705015931; x=1705620731;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ecoc00QYwaJz8dIkPPEYb205rWMV7qbZJM9fu2YOHGU=;
 b=ZGR3+Mg6EhoG0X5WdH5zl1VnVH4gRowPp1B8T5iB/o8yxBp8oxUVkmyMwjKYzWHNGz
 DNkYHnCP76VENAk1U3BRGQVOFmKFtK0C2wsQC9/+Uc5BzY4WL9sBjmtfFZ/u/D69VOWM
 VLOrMwQmvfEpxEQW4PLDtYcAK49XvDEla2SbOggfahHMB2ZtsapCbpbVUtliAL26iC4t
 Ay3d/TsirrIB9CG3jlXShGk8K4H4K5CtgWJrCYHZ5wPSVq5lvUw8Uve7IusZp9JPuE4i
 /ozQBSrNCkhwe+X2xTv1Zijw7eWN+PzHIY7KiS366HdTYPHlp6xf1CAjczY6u2Ao2+8D
 FGEg==
X-Gm-Message-State: AOJu0YyDSJ+4qIHcFFYS0i5Z+JOIVCFV5sV6nOJV+ag87Xp8H/v0WQ8E
 dlnl613ntWS5bj2OMPxZgbRWLpOmcRx0Rw9Nci4=
X-Google-Smtp-Source: AGHT+IGZZofHM36OVFmuC+dTfWaaKOCvbzwm84tNB2ktk2Ryx/SWPYEd+RO4qM+742UcyyNJPVH/RDPxw2SQ8ZFNqR8=
X-Received: by 2002:a1f:e784:0:b0:4b6:e3b6:41ea with SMTP id
 e126-20020a1fe784000000b004b6e3b641eamr681462vkh.4.1705015930734; Thu, 11 Jan
 2024 15:32:10 -0800 (PST)
MIME-Version: 1.0
References: <20240109194438.70934-1-ines.varhol@telecom-paris.fr>
 <20240109194438.70934-3-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240109194438.70934-3-ines.varhol@telecom-paris.fr>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 12 Jan 2024 09:31:44 +1000
Message-ID: <CAKmqyKMqM=8SQpbdviMnVBcFdChRUmk5C-SW=dB-RMKP=L+zzA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] hw/arm: Connect STM32L4x5 SYSCFG to STM32L4x5 SoC
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
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

On Wed, Jan 10, 2024 at 5:47=E2=80=AFAM In=C3=A8s Varhol
<ines.varhol@telecom-paris.fr> wrote:
>
> The SYSCFG input GPIOs aren't connected yet. When the STM32L4x5 GPIO
> device will be implemented, its output GPIOs will be connected to the
> SYSCFG input GPIOs.
>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/Kconfig                 |  1 +
>  hw/arm/stm32l4x5_soc.c         | 21 ++++++++++++++++++++-
>  include/hw/arm/stm32l4x5_soc.h |  2 ++
>  3 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 8c8488a70a..bb4693bfbb 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -459,6 +459,7 @@ config STM32L4X5_SOC
>      bool
>      select ARM_V7M
>      select OR_IRQ
> +    select STM32L4X5_SYSCFG
>      select STM32L4X5_EXTI
>
>  config XLNX_ZYNQMP_ARM
> diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
> index fe46b7c6c0..431f982caf 100644
> --- a/hw/arm/stm32l4x5_soc.c
> +++ b/hw/arm/stm32l4x5_soc.c
> @@ -37,6 +37,7 @@
>  #define SRAM2_SIZE (32 * KiB)
>
>  #define EXTI_ADDR 0x40010400
> +#define SYSCFG_ADDR 0x40010000
>
>  #define NUM_EXTI_IRQ 40
>  /* Match exti line connections with their CPU IRQ number */
> @@ -80,6 +81,7 @@ static void stm32l4x5_soc_initfn(Object *obj)
>      Stm32l4x5SocState *s =3D STM32L4X5_SOC(obj);
>
>      object_initialize_child(obj, "exti", &s->exti, TYPE_STM32L4X5_EXTI);
> +    object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_STM32L4X5_SY=
SCFG);
>
>      s->sysclk =3D qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0)=
;
>      s->refclk =3D qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0)=
;
> @@ -154,6 +156,19 @@ static void stm32l4x5_soc_realize(DeviceState *dev_s=
oc, Error **errp)
>          return;
>      }
>
> +    /* System configuration controller */
> +    busdev =3D SYS_BUS_DEVICE(&s->syscfg);
> +    if (!sysbus_realize(busdev, errp)) {
> +        return;
> +    }
> +    sysbus_mmio_map(busdev, 0, SYSCFG_ADDR);
> +    /*
> +     * TODO: when the GPIO device is implemented, connect it
> +     * to SYCFG using `qdev_connect_gpio_out`, NUM_GPIOS and
> +     * GPIO_NUM_PINS.
> +     */
> +
> +    /* EXTI device */
>      busdev =3D SYS_BUS_DEVICE(&s->exti);
>      if (!sysbus_realize(busdev, errp)) {
>          return;
> @@ -163,6 +178,11 @@ static void stm32l4x5_soc_realize(DeviceState *dev_s=
oc, Error **errp)
>          sysbus_connect_irq(busdev, i, qdev_get_gpio_in(armv7m, exti_irq[=
i]));
>      }
>
> +    for (unsigned i =3D 0; i < 16; i++) {
> +        qdev_connect_gpio_out(DEVICE(&s->syscfg), i,
> +                              qdev_get_gpio_in(DEVICE(&s->exti), i));
> +    }
> +
>      /* APB1 BUS */
>      create_unimplemented_device("TIM2",      0x40000000, 0x400);
>      create_unimplemented_device("TIM3",      0x40000400, 0x400);
> @@ -200,7 +220,6 @@ static void stm32l4x5_soc_realize(DeviceState *dev_so=
c, Error **errp)
>      /* RESERVED:    0x40009800, 0x6800 */
>
>      /* APB2 BUS */
> -    create_unimplemented_device("SYSCFG",    0x40010000, 0x30);
>      create_unimplemented_device("VREFBUF",   0x40010030, 0x1D0);
>      create_unimplemented_device("COMP",      0x40010200, 0x200);
>      /* RESERVED:    0x40010800, 0x1400 */
> diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_so=
c.h
> index f7305568dc..baf70410b5 100644
> --- a/include/hw/arm/stm32l4x5_soc.h
> +++ b/include/hw/arm/stm32l4x5_soc.h
> @@ -26,6 +26,7 @@
>
>  #include "exec/memory.h"
>  #include "hw/arm/armv7m.h"
> +#include "hw/misc/stm32l4x5_syscfg.h"
>  #include "hw/misc/stm32l4x5_exti.h"
>  #include "qom/object.h"
>
> @@ -41,6 +42,7 @@ struct Stm32l4x5SocState {
>      ARMv7MState armv7m;
>
>      Stm32l4x5ExtiState exti;
> +    Stm32l4x5SyscfgState syscfg;
>
>      MemoryRegion sram1;
>      MemoryRegion sram2;
> --
> 2.43.0
>
>

