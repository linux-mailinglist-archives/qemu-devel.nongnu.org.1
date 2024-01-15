Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E6582DB83
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 15:43:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPOAq-0005Ei-95; Mon, 15 Jan 2024 09:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPOAh-0005De-3A
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 09:42:39 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPOAf-00055p-1d
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 09:42:38 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-558b5f4cf2dso3941411a12.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 06:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705329755; x=1705934555; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jmNL6rvUIVwFe8YplRIts5k2qqn7IcbJ0GnsoDHlyKc=;
 b=cmBl1PsU/dAw9JPjLCoFMU4v+RLiRAVY8LxadhXmCOqex6K7+RG+Gp4ORQ0n+Zc9tQ
 yqtF3DIprv7tih2ypfOLY510fcD+ogxnpHi/MID1KvoRKoDLaB63AACMAwAyL3bvvOoQ
 zrxEhao1kTVnlyA2xs1lQ+RRMuNVIuOB3KDeipt0fKvntw67N/FlNc86dDuFDyDaaK4R
 X4OSoPtP1Cx5H2ihZEZV+snkMWmUOYn8S1k9Z4pfkwPeisk9wfJFxmx14Lmf0oH5deKX
 rj5uybOsfNSUbPHlAagwOjqNbCFJQvDgtHtL8GnEyqviH8cIACmmDDLto+sHBgLSPKgo
 uBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705329755; x=1705934555;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jmNL6rvUIVwFe8YplRIts5k2qqn7IcbJ0GnsoDHlyKc=;
 b=Alz3HVqAHRUa08OMDbFaPbwgaYvGnZMVKkMSgBpM/oZ9+CYWm2Ab0Yl5cilkQbfhhL
 sp3uxOE0G72S2+c715XusdI9Ks0hNs3jbmJ+9exc44QIA+YYTJPvMWCGkYybnIbnmuqX
 DPVubow1K++Lwdx8Z8HAQTE4M8fjBQrk6ns9mgAX3Ovw82El1M9XvlUw5WNABvh3ArN4
 Kl5bNaes2m2/VFvd9mCzJlitrnBQTsYDfKLCU5RCBstTDuChoUdDD69atXIA92WQcvKu
 3r+au58r2MLSg18+aNy22wU7wukMDl3drTXJEuJxIFJLSrj5n1rpiO41TO7bMXjpJsNb
 q7gg==
X-Gm-Message-State: AOJu0YyGXJfntSFhJAr4821+5Yq19QW6IOImiHddyBg4AIrIhhilYNsT
 mZ9m6VfhBFjFulk4c/p9WHMjykLBsDIVy54jwHytPPCc5jJnAg==
X-Google-Smtp-Source: AGHT+IGR418RFPGaiYnXDzx7CzEt1+aKA57IK9ZU4ZxYVWe1q/DN3jiCYt5S57DsrPGL4gF7xG8ep3tBN3633wXpR0M=
X-Received: by 2002:aa7:d390:0:b0:553:e3f2:3c74 with SMTP id
 x16-20020aa7d390000000b00553e3f23c74mr3096895edq.38.1705329755252; Mon, 15
 Jan 2024 06:42:35 -0800 (PST)
MIME-Version: 1.0
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
 <20231208023145.1385775-21-sergey.kambalin@auriga.com>
In-Reply-To: <20231208023145.1385775-21-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2024 14:42:23 +0000
Message-ID: <CAFEAcA-Uc0DGUdSUHf+SLdUwaEksawGErdRUMarbHOndKCFCxw@mail.gmail.com>
Subject: Re: [PATCH v4 20/45] Implement BCM2838 thermal sensor
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Fri, 8 Dec 2023 at 02:33, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2838_peripherals.c         | 27 ++++++--
>  hw/arm/raspi4b.c                     |  1 -
>  hw/misc/bcm2838_thermal.c            | 98 ++++++++++++++++++++++++++++
>  hw/misc/meson.build                  |  3 +-
>  include/hw/arm/bcm2838_peripherals.h |  2 +
>  include/hw/misc/bcm2838_thermal.h    | 24 +++++++
>  6 files changed, 147 insertions(+), 8 deletions(-)
>  create mode 100644 hw/misc/bcm2838_thermal.c
>  create mode 100644 include/hw/misc/bcm2838_thermal.h
>
> diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
> index 7c489c8e8a..e9c6d47ba6 100644
> --- a/hw/arm/bcm2838_peripherals.c
> +++ b/hw/arm/bcm2838_peripherals.c
> @@ -37,6 +37,9 @@ static void bcm2838_peripherals_init(Object *obj)
>      /* Random Number Generator */
>      object_initialize_child(obj, "rng200", &s->rng200, TYPE_BCM2838_RNG2=
00);
>
> +    /* Thermal */
> +    object_initialize_child(obj, "thermal", &s->thermal, TYPE_BCM2838_TH=
ERMAL);
> +
>      /* PCIe Host Bridge */
>      object_initialize_child(obj, "pcie-host", &s->pcie_host,
>                              TYPE_BCM2838_PCIE_HOST);
> @@ -75,6 +78,9 @@ static void bcm2838_peripherals_realize(DeviceState *de=
v, Error **errp)
>      BCMSocPeripheralBaseState *s_base =3D BCM_SOC_PERIPHERALS_BASE(dev);
>      MemoryRegion *regs_mr;
>      MemoryRegion *mmio_mr;
> +    MemoryRegion *rng200_mr;
> +    MemoryRegion *thermal_mr;
> +    qemu_irq rng_200_irq;
>
>      int n;
>
> @@ -92,12 +98,20 @@ static void bcm2838_peripherals_realize(DeviceState *=
dev, Error **errp)
>      if (!sysbus_realize(SYS_BUS_DEVICE(&s->rng200), errp)) {
>          return;
>      }
> -    memory_region_add_subregion(
> -        &s_base->peri_mr, RNG_OFFSET,
> -        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rng200), 0));
> -    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rng200), 0,
> -        qdev_get_gpio_in_named(DEVICE(&s_base->ic), BCM2835_IC_GPU_IRQ,
> -                               INTERRUPT_RNG));
> +    rng200_mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rng200), 0);
> +    memory_region_add_subregion(&s_base->peri_mr, RNG_OFFSET, rng200_mr)=
;
> +
> +    rng_200_irq =3D qdev_get_gpio_in_named(DEVICE(&s_base->ic),
> +                                         BCM2835_IC_GPU_IRQ, INTERRUPT_R=
NG);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rng200), 0, rng_200_irq);

These parts related to the RNG should presumably have been in
the patch which added the RNG device.

> +
> +
> +    /* THERMAL */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->thermal), errp)) {
> +        return;
> +    }
> +    thermal_mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->thermal), 0=
);
> +    memory_region_add_subregion( &s->peri_low_mr, 0x15D2000, thermal_mr)=
;
>
>      /* Extended Mass Media Controller 2 */
>      object_property_set_uint(OBJECT(&s->emmc2), "sd-spec-version", 3,
> @@ -198,6 +212,7 @@ static void bcm2838_peripherals_realize(DeviceState *=
dev, Error **errp)
>                               BCM2838_MPHI_SIZE);
>      memory_region_add_subregion(&s_base->peri_mr, BCM2838_MPHI_OFFSET,
>                                  &s->mphi_mr_alias);
> +
>      /* PCIe Root Complex */
>      if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie_host), errp)) {
>          return;

Stray extra whitespace change -- should probably be in whichever patch
is adding the PCI device to the SoC.

> diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
> index 7b5385b8dd..fda27d36cb 100644
> --- a/hw/arm/raspi4b.c
> +++ b/hw/arm/raspi4b.c
> @@ -67,7 +67,6 @@ static void raspi4_modify_dtb(const struct arm_boot_inf=
o *info, void *fdt)
>
>      /* Temporarily disable following devices until they are implemented*=
/
>      const char *to_be_removed_from_dt_as_wa[] =3D {
> -        "brcm,bcm2711-thermal",
>          "brcm,bcm2711-genet-v5",
>      };
>
> diff --git a/hw/misc/bcm2838_thermal.c b/hw/misc/bcm2838_thermal.c
> new file mode 100644
> index 0000000000..2301f657d0
> --- /dev/null
> +++ b/hw/misc/bcm2838_thermal.c
> @@ -0,0 +1,98 @@
> +/*
> + * BCM2838 dummy thermal sensor
> + *
> + * Copyright (C) 2022 Maksim Kopusov <maksim.kopusov@auriga.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "hw/misc/bcm2838_thermal.h"
> +#include "hw/registerfields.h"
> +#include "migration/vmstate.h"
> +#include "qemu/error-report.h"
> +
> +REG32(STAT, 0x200)
> +FIELD(STAT, DATA, 0, 10)
> +FIELD(STAT, VALID_1, 10, 1)
> +FIELD(STAT, VALID_2, 16, 1)
> +
> +#define BCM2838_THERMAL_SIZE 0xf00
> +
> +#define THERMAL_OFFSET_C 410040
> +#define THERMAL_COEFF  (-487.0f)
> +#define MILLIDEGREE_COEFF 1000
> +
> +static uint16_t bcm2838_thermal_temp2adc(int temp_C)
> +{
> +    return (temp_C * MILLIDEGREE_COEFF - THERMAL_OFFSET_C) / THERMAL_COE=
FF;
> +}
> +
> +static uint64_t bcm2838_thermal_read(void *opaque, hwaddr addr, unsigned=
 size)
> +{
> +    uint32_t val =3D 0;
> +
> +    switch (addr) {
> +    case A_STAT:
> +        /* Temperature is always 25=C2=B0C */
> +        val =3D FIELD_DP32(val, STAT, DATA, bcm2838_thermal_temp2adc(25)=
);
> +        val =3D FIELD_DP32(val, STAT, VALID_1, 1);
> +        val =3D FIELD_DP32(val, STAT, VALID_2, 1);
> +
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s can't access addr: 0x%"PRIx64=
,

addr here is a hwaddr, so HWADDR_PRIx is the right format string.

> +                     TYPE_BCM2838_THERMAL, addr);
> +    }
> +    return val;
> +}

> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index b899e6b596..386471a5e4 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -91,7 +91,8 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
>    'bcm2835_thermal.c',
>    'bcm2835_cprman.c',
>    'bcm2835_powermgt.c',
> -  'bcm2838_rng200.c'
> +  'bcm2838_rng200.c',
> +  'bcm2838_thermal.c'

If you always keep a trailing comma at the end of this kind of list,
then when you add a new item to it you don't need to also edit
the previous line.

>  ))
>  system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
>  system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

