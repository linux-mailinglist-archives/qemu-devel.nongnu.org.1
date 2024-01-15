Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF93E82DB0D
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 15:11:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPNfn-0002r4-OJ; Mon, 15 Jan 2024 09:10:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPNfi-0002ns-1p
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 09:10:38 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPNfe-0007R8-4R
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 09:10:36 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-558f523c072so2199088a12.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 06:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705327831; x=1705932631; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=epfBPg5XRbb4yGTmyrNtVuyfafA74tcJKJMpUdL1RLo=;
 b=IVQwBjGJdleqtndMuF2hKlIF3NFEf5OZlbUXEr8prlEa3uJ/J6y95T8H5W8p/QwLKD
 ZEpjZM8zAY9oSr1n5aCi1xbzXlGLpECjWWuukEgMiaBQoiorn2IdV41yUwN2TFW5NES2
 aF21z9ZT0vpM31gE5K9JUGSTnV5SzxbHTJ73knY6k0VouFRPbyWy3wZuBuO9dqIZ0t6D
 INsfKHmUd78aY2fozKjIuPnWsepuQTEDqNk/aMxQxc4h6jOCwRqIVkY3jf7C7C3g9w4W
 oAw3XHhEjonRiH3nX21XywMetzy0CSEMokAfnoXg9BQ5gkRGeEalZZd7pJC2IXB+w4Ru
 3scQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705327831; x=1705932631;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=epfBPg5XRbb4yGTmyrNtVuyfafA74tcJKJMpUdL1RLo=;
 b=LE7X+W+JXm5dAETiEnqLugNQ0NMWCxOMsdXPQ5IqO9QbCtNgmEx0BfxJY80CpjQiTV
 tvqQoFGfXay4N3+61s5WLztsqCgSNA9zmkv+DF/klYUa/276JIi1KUVdAjcxIWs+An1f
 /uVPUOJIzct97dwz85eOHzj1x/ifPcuxaZ8jddjIebGrxTyCnxVxrsrwrn3/P0fhuzYL
 m+3IwxV4xidAYYnclesLSNNQsbvIyLxXnHGJ0olgz/Pe/QvDcdWlTCle6EB6PTkSzWEv
 kCvTMsF7TeYgF2SKXwxyY4pgv4lW86GwGOBO1B+xKeeVp1MPEE7n6YUuB3Dh5vp0UK+p
 wWfw==
X-Gm-Message-State: AOJu0YyUSYLY0u+S3SbANzGuDssWy3jgFIOQUlX2CcmAXcU959EMO88t
 QtyD92dXthJFbIRRh/Zru3WfILmpOtVdE4yftRAiHSfjID+02/2XWyQpkYd0
X-Google-Smtp-Source: AGHT+IEZHpgttBjb7cyJ2JVSI91UyOdyTPYLlOxoeZwk6O2NmZlVOnwxIbUdBKzH+9nr/p8PS9aOvP6H/9JKItuVDyQ=
X-Received: by 2002:a05:6402:40c6:b0:558:b9ed:2efb with SMTP id
 z6-20020a05640240c600b00558b9ed2efbmr1747090edb.98.1705327831412; Mon, 15 Jan
 2024 06:10:31 -0800 (PST)
MIME-Version: 1.0
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
 <20231208023145.1385775-17-sergey.kambalin@auriga.com>
In-Reply-To: <20231208023145.1385775-17-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2024 14:10:20 +0000
Message-ID: <CAFEAcA_O0+P2MTe8KLNz5PYqQG1xFAbFHGv5ANpj0d=OY123VQ@mail.gmail.com>
Subject: Re: [PATCH v4 16/45] Enable BCM2838 PCIE
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
>  hw/arm/bcm2838_pcie.c                |  3 +++
>  hw/arm/bcm2838_peripherals.c         | 26 ++++++++++++++++++++++++++
>  hw/arm/meson.build                   |  7 ++++---
>  hw/arm/raspi4b.c                     |  1 -
>  include/hw/arm/bcm2838_peripherals.h |  3 +++
>  5 files changed, 36 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/bcm2838_pcie.c b/hw/arm/bcm2838_pcie.c
> index 75146d6c2e..8e046d0ac7 100644
> --- a/hw/arm/bcm2838_pcie.c
> +++ b/hw/arm/bcm2838_pcie.c
> @@ -239,6 +239,9 @@ static void bcm2838_pcie_root_reg_reset(PCIDevice *dev)
>  }
>
>  static void bcm2838_pcie_root_realize(PCIDevice *dev, Error **errp) {
> +    BCM2838PcieRootClass *brpc = BCM2838_PCIE_ROOT_GET_CLASS(dev);
> +
> +    brpc->parent_realize(dev, errp);
>      bcm2838_pcie_root_reg_reset(dev);
>  }
>

I guess this change should have been in the previous patch ?

> diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
> index d3b42cf25b..ee06214715 100644
> --- a/hw/arm/bcm2838_peripherals.c
> +++ b/hw/arm/bcm2838_peripherals.c
> @@ -12,6 +12,11 @@
>  #include "hw/arm/raspi_platform.h"
>  #include "hw/arm/bcm2838_peripherals.h"
>
> +#define PCIE_RC_OFFSET          0x1500000
> +#define PCIE_MMIO_OFFSET        0xc0000000
> +#define PCIE_MMIO_ARM_OFFSET    0x600000000
> +#define PCIE_MMIO_SIZE          0x40000000
> +
>  /* Lower peripheral base address on the VC (GPU) system bus */
>  #define BCM2838_VC_PERI_LOW_BASE 0x7c000000
>
> @@ -29,6 +34,10 @@ static void bcm2838_peripherals_init(Object *obj)
>                         bc->peri_low_size);
>      sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->peri_low_mr);
>
> +    /* PCIe Host Bridge */
> +    object_initialize_child(obj, "pcie-host", &s->pcie_host,
> +                            TYPE_BCM2838_PCIE_HOST);
> +
>      /* Extended Mass Media Controller 2 */
>      object_initialize_child(obj, "emmc2", &s->emmc2, TYPE_SYSBUS_SDHCI);
>
> @@ -61,6 +70,9 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
>      MemoryRegion *mphi_mr;
>      BCM2838PeripheralState *s = BCM2838_PERIPHERALS(dev);
>      BCMSocPeripheralBaseState *s_base = BCM_SOC_PERIPHERALS_BASE(dev);
> +    MemoryRegion *regs_mr;
> +    MemoryRegion *mmio_mr;
> +
>      int n;
>
>      bcm_soc_peripherals_common_realize(dev, errp);
> @@ -172,6 +184,20 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
>                               BCM2838_MPHI_SIZE);
>      memory_region_add_subregion(&s_base->peri_mr, BCM2838_MPHI_OFFSET,
>                                  &s->mphi_mr_alias);
> +    /* PCIe Root Complex */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie_host), errp)) {
> +        return;
> +    }
> +    /* RC registers region */
> +    regs_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pcie_host), 0);
> +    memory_region_add_subregion(&s->peri_low_mr, PCIE_RC_OFFSET, regs_mr);
> +    /* MMIO region */
> +    mmio_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pcie_host), 1);
> +    memory_region_init_alias(&s->pcie_mmio_alias, OBJECT(&s->pcie_host),
> +                             "pcie-mmio", mmio_mr, PCIE_MMIO_OFFSET,
> +                             PCIE_MMIO_SIZE);
> +    memory_region_add_subregion(get_system_memory(), PCIE_MMIO_ARM_OFFSET,
> +                                &s->pcie_mmio_alias);

Why do we need an alias region here rather than just mapping
the region from the pcie host device directly ?

>
>      /* GPIO */
>      if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {

thanks
-- PMM

