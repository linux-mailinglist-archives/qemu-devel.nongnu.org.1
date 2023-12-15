Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF82C814146
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 06:31:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE0n8-0000Ge-TT; Fri, 15 Dec 2023 00:31:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rE0n6-00009u-4u; Fri, 15 Dec 2023 00:31:16 -0500
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rE0n4-0002fS-63; Fri, 15 Dec 2023 00:31:15 -0500
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7cb00cc0b5fso33541241.2; 
 Thu, 14 Dec 2023 21:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702618271; x=1703223071; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0dBDKhF1rKJO9VmGaHA/tBQURDu+VIWdefPrgCVLbx8=;
 b=Vu1/+STnar8++RfXlsuq7qQZAe6Me67qNtGGntkYEDbIuRhdvTu3FYPFAw6UQrkpQr
 QDuidXRTIhhwI+wj+4x+Vfb6HPbtwP9NGnVppYAQ3EEu8I/RXay6o2GLJGzXsftqgTa9
 zAGMRliEoLCktgkJaQxUVa25qgPVCjnOaQIXDf3bX4bpOXuO7beurBDgDfibrLDhGUrY
 lG6a27l/y2BD8rlri5UsaxzKc31ZxV6/e2tGiWjbYHEkGwJC3TZkQ2SNtBTGfEwSYcKx
 EJoLt40giYf95gh8akWv6etj8e4d4CKw6zzEdFrGsVgtDnjurftWNv/5VCBOVIXegyJ0
 9MBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702618271; x=1703223071;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0dBDKhF1rKJO9VmGaHA/tBQURDu+VIWdefPrgCVLbx8=;
 b=qgN61se7CpncL+cbLxwTyC8vysv3ylWDW5YH/xIJYAXxNrWpKAgd1Q088Szv/7B5d0
 0JhrrMBx3O23AHsXJ5vMFgCd+WAK6Qkv/tzI/JvqMs5e9GUvOuJuVu34F7DCFIbMSJUQ
 mYvi/O8OsVphUQusufa5RComOMLSrwexjAkwSZ9QCv1hka+vCOptUqs0/M+UXeq0mmXJ
 ZZAL4M2NGEZhKVhk0YlwfiHtcBWfdoDtVBdT+Md9nlMFdy1Un6iPm7Ieg/qNlGT94uWa
 JOMUkyT5YKElyRJrda1wZ3PxJVra3WwO/xfXar4b3+9xPg5m5novIWAgN4314kFk2f5/
 fjIA==
X-Gm-Message-State: AOJu0Yxh7tgpUNzVMDvRcIGUmgNqj1+TrzzjbwBYkaj+ys6BO9HsuuAt
 uIItjt7J9Rqlmfnh2AvhlH37gzOIiirpdcx5Ai5qbYlcl0c=
X-Google-Smtp-Source: AGHT+IHuUKRZoc3lTs/1JD8dwSTtTTXKx75cyxPbD88OGrxfkE1AQDXW0KdEjl9z5xHzJk8G3tT/8sVHri8Rsqc3DI8=
X-Received: by 2002:a05:6102:b08:b0:464:94b1:1119 with SMTP id
 b8-20020a0561020b0800b0046494b11119mr8019028vst.1.1702618271533; Thu, 14 Dec
 2023 21:31:11 -0800 (PST)
MIME-Version: 1.0
References: <170256739558.25729.14053113716470464567-0@git.sr.ht>
 <170256739558.25729.14053113716470464567-2@git.sr.ht>
In-Reply-To: <170256739558.25729.14053113716470464567-2@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 15 Dec 2023 15:30:45 +1000
Message-ID: <CAKmqyKMTvUgoA4vmPbMmymH4XyPDYKdnDzhL+ej3MbeiT9+2OQ@mail.gmail.com>
Subject: Re: [PATCH qemu v3 2/2] hw/arm: Add minimal support for the
 B-L475E-IOT01A board
To: "~inesvarhol" <inesvarhol@proton.me>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alistair@alistair23.me, 
 philmd@linaro.org, peter.maydell@linaro.org, ines.varhol@telecom-paris.fr, 
 arnaud.minier@telecom-paris.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
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

On Fri, Dec 15, 2023 at 1:24=E2=80=AFAM ~inesvarhol <inesvarhol@git.sr.ht> =
wrote:
>
> From: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
>
> This commit adds a new B-L475E-IOT01A board using the STM32L475VG SoC.
> The implementation is derived from the Netduino Plus 2 machine.
> There are no peripherals implemented yet, only memory regions.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  MAINTAINERS                             |  7 +++
>  configs/devices/arm-softmmu/default.mak |  1 +
>  hw/arm/Kconfig                          |  6 +++
>  hw/arm/b-l475e-iot01a.c                 | 70 +++++++++++++++++++++++++
>  hw/arm/meson.build                      |  1 +
>  5 files changed, 85 insertions(+)
>  create mode 100644 hw/arm/b-l475e-iot01a.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e5b28aee28..3f3831c92a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1131,6 +1131,13 @@ S: Maintained
>  F: hw/arm/stm32l4x5_soc.c
>  F: include/hw/arm/stm32l4x5_soc.h
>
> +B-L475E-IOT01A IoT Node
> +M: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> +M: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> +L: qemu-arm@nongnu.org
> +S: Maintained
> +F: hw/arm/b-l475e-iot01a.c
> +
>  SmartFusion2
>  M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
>  M: Peter Maydell <peter.maydell@linaro.org>
> diff --git a/configs/devices/arm-softmmu/default.mak b/configs/devices/ar=
m-softmmu/default.mak
> index 980c48a7d9..023faa2f75 100644
> --- a/configs/devices/arm-softmmu/default.mak
> +++ b/configs/devices/arm-softmmu/default.mak
> @@ -19,6 +19,7 @@ CONFIG_ARM_VIRT=3Dy
>  # CONFIG_NSERIES=3Dn
>  # CONFIG_STELLARIS=3Dn
>  # CONFIG_STM32VLDISCOVERY=3Dn
> +# CONFIG_B_L475E_IOT01A=3Dn
>  # CONFIG_REALVIEW=3Dn
>  # CONFIG_VERSATILE=3Dn
>  # CONFIG_VEXPRESS=3Dn
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index d2b94d9a47..7520dc5cc0 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -448,6 +448,12 @@ config STM32F405_SOC
>      select STM32F4XX_SYSCFG
>      select STM32F4XX_EXTI
>
> +config B_L475E_IOT01A
> +    bool
> +    default y
> +    depends on TCG && ARM
> +    select STM32L4X5_SOC
> +
>  config STM32L4X5_SOC
>      bool
>      select ARM_V7M
> diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
> new file mode 100644
> index 0000000000..c3790e3dc8
> --- /dev/null
> +++ b/hw/arm/b-l475e-iot01a.c
> @@ -0,0 +1,70 @@
> +/*
> + * B-L475E-IOT01A Discovery Kit machine
> + * (B-L475E-IOT01A IoT Node)
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
> + * This work is heavily inspired by the netduinoplus2 by Alistair Franci=
s.
> + * Original code is licensed under the MIT License:
> + *
> + * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
> + */
> +
> +/*
> + * The reference used is the STMicroElectronics UM2153 User manual
> + * Discovery kit for IoT node, multi-channel communication with STM32L4.
> + * https://www.st.com/en/evaluation-tools/b-l475e-iot01a.html#documentat=
ion
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/boards.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/qdev-clock.h"
> +#include "qemu/error-report.h"
> +#include "hw/arm/stm32l4x5_soc.h"
> +#include "hw/arm/boot.h"
> +
> +/* Main SYSCLK frequency in Hz (80MHz) */
> +#define SYSCLK_FRQ 80000000ULL
> +
> +static void b_l475e_iot01a_init(MachineState *machine)
> +{
> +    const Stm32l4x5SocClass *sc;
> +    DeviceState *dev;
> +    Clock *sysclk;
> +
> +    /* This clock doesn't need migration because it is fixed-frequency *=
/
> +    sysclk =3D clock_new(OBJECT(machine), "SYSCLK");
> +    clock_set_hz(sysclk, SYSCLK_FRQ);
> +
> +    dev =3D qdev_new(TYPE_STM32L4X5XG_SOC);
> +    sc =3D STM32L4X5_SOC_GET_CLASS(dev);
> +    qdev_connect_clock_in(dev, "sysclk", sysclk);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    armv7m_load_kernel(ARM_CPU(first_cpu),
> +                       machine->kernel_filename,
> +                       0, sc->flash_size);
> +}
> +
> +static void b_l475e_iot01a_machine_init(MachineClass *mc)
> +{
> +    static const char *machine_valid_cpu_types[] =3D {
> +        ARM_CPU_TYPE_NAME("cortex-m4"),
> +        NULL};
> +    mc->desc =3D "B-L475E-IOT01A Discovery Kit (Cortex-M4)";
> +    mc->init =3D b_l475e_iot01a_init;
> +    mc->valid_cpu_types =3D machine_valid_cpu_types;
> +
> +    /* SRAM pre-allocated as part of the SoC instantiation */
> +    mc->default_ram_size =3D 0;
> +}
> +
> +DEFINE_MACHINE("b-l475e-iot01a", b_l475e_iot01a_machine_init)
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 9766da10c4..bb92b27db3 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -42,6 +42,7 @@ arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm283=
6.c', 'raspi.c'))
>  arm_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c=
'))
>  arm_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c=
'))
>  arm_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c=
'))
> +arm_ss.add(when: 'CONFIG_B_L475E_IOT01A', if_true: files('b-l475e-iot01a=
.c'))
>  arm_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: files('stm32l4x5_soc.c=
'))
>  arm_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqmp.c=
', 'xlnx-zcu102.c'))
>  arm_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal.c', '=
xlnx-versal-virt.c'))
> --
> 2.38.5
>

