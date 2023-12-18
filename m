Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5128177BC
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 17:42:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFGgW-00065o-Kq; Mon, 18 Dec 2023 11:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFGgU-00065T-Be
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 11:41:38 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFGgS-0001vv-Qr
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 11:41:38 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-54c5d041c23so3978726a12.2
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 08:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702917695; x=1703522495; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DnRd5fNcsD03vuFGrT23ASKpRhWRVtXIKT5M3YKw78I=;
 b=VW3ssgUwvF9wmX322i96XKfeTjIs1du3BuDs8laFac8YjQ2lQhL9PZZ8eoaE4ZfVqF
 NqBq64gsmaE/cKwBnqUHjBd+RMQJ6OvKgjFN8/zpB7U3qNHS+kiBnsSFOkILgxp2bmRF
 zXiWgiXBsNRRgE1oCo0z0pZ5zjLaHFHWkxDLRV61hgMueyJGCerSsMXLavIkFyYG+D1I
 4t6TmqRPZMIMSD73fBgvqIWeiG0XnuxP60YVBiWnENT6mLG4mB9JDXQ+Uw9w/oyNPil3
 zraKfgNNadSXKClMJoxB+25CRKh8nZ6TiOkVVsbjsxNdeF7+7upgdFxfQX6YeQhVexbP
 c4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702917695; x=1703522495;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DnRd5fNcsD03vuFGrT23ASKpRhWRVtXIKT5M3YKw78I=;
 b=YDiaejNV9tKyQpwRdYRwW5ES+9TPElJR42FdCsXly9sTTv5MmM1xi6BNppDsOsvLsR
 InTyo/QhufYETPp6ukQCFi60im0ELKuq2CtC+sXdIxg9WS/8eumT/cMk1uDuCYh2/JAQ
 LggdoiTrCFWSvzFCGMfSKbfe5SpFGNz0YHdirBAPcI+wuhXlF2viAfFL4z7YJ/2V+iaA
 pfEhEPglHJZ1cvvcXaly6YDsctC+Fssm2baYFubLGXPLxGu+6u/8NYRyi47OhxaWG8W3
 cNu2o2JWg7Ywpes6P3fKw/T4EtFExxMicvvDVDm2sFjtPWa8e5ZsjugrLdZHFfsfhFDn
 pmTg==
X-Gm-Message-State: AOJu0YyP4xEo34ZtzScvQndc/8y7wytBzY2hLiFhLpG+qsimzQVj7CjY
 dLnA5m6INV7QoTJR1afNaOBuu02YrcL2+3I6Ba7f4w==
X-Google-Smtp-Source: AGHT+IFN1NUT0RvUZeqCSWVOzarxWdFq04jbIp2E/+EBO3XND0x3Cb01Jho9+jtUY8Bvjc4pO42FHwzZgz0LeO/YgLM=
X-Received: by 2002:a50:e60b:0:b0:54c:4fec:11a with SMTP id
 y11-20020a50e60b000000b0054c4fec011amr4927814edm.169.1702917695279; Mon, 18
 Dec 2023 08:41:35 -0800 (PST)
MIME-Version: 1.0
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
 <20231208023145.1385775-10-sergey.kambalin@auriga.com>
In-Reply-To: <20231208023145.1385775-10-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Dec 2023 16:41:24 +0000
Message-ID: <CAFEAcA9HM14SO_eA+5RdpxABTk0M82+e625feJCuZBafA+sdUg@mail.gmail.com>
Subject: Re: [PATCH v4 09/45] Add GPIO and SD to BCM2838 periph
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Fri, 8 Dec 2023 at 02:37, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2838_peripherals.c         | 140 +++++++++++++++++++++++++++
>  include/hw/arm/bcm2838_peripherals.h |   9 ++
>  2 files changed, 149 insertions(+)


> @@ -42,6 +73,115 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
>                                          BCM2838_VC_PERI_LOW_BASE,
>                                          &s->peri_low_mr_alias, 1);
>
> +    /* Extended Mass Media Controller 2 */
> +    object_property_set_uint(OBJECT(&s->emmc2), "sd-spec-version", 3,
> +                             &error_abort);
> +    object_property_set_uint(OBJECT(&s->emmc2), "capareg",
> +                             BCM2835_SDHC_CAPAREG, &error_abort);
> +    object_property_set_bool(OBJECT(&s->emmc2), "pending-insert-quirk", true,
> +                             &error_abort);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->emmc2), errp)) {
> +        return;
> +    }
> +
> +    memory_region_add_subregion(
> +        &s_base->peri_mr, EMMC2_OFFSET,
> +        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->emmc2), 0));

Odd indent again here...

> +
> +    /* According to DTS, EMMC and EMMC2 share one irq */
> +    if (!qdev_realize(DEVICE(&s->mmc_irq_orgate), NULL, errp)) {
> +        return;
> +    }
> +
> +    DeviceState *mmc_irq_orgate = DEVICE(&s->mmc_irq_orgate);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->emmc2), 0,
> +                        qdev_get_gpio_in(mmc_irq_orgate, 0));
> +
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s_base->sdhci), 0,
> +                        qdev_get_gpio_in(mmc_irq_orgate, 1));

...and here.

> +
> +   /* Connect EMMC and EMMC2 to the interrupt controller */
> +    qdev_connect_gpio_out(mmc_irq_orgate, 0,
> +                          qdev_get_gpio_in_named(DEVICE(&s_base->ic),
> +                                                 BCM2835_IC_GPU_IRQ,
> +                                                 INTERRUPT_ARASANSDIO));
> +
> +    /* Connect DMA 0-6 to the interrupt controller */
> +    for (n = 0; n < 7; n++) {
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s_base->dma), n,
> +                           qdev_get_gpio_in_named(DEVICE(&s_base->ic),
> +                                                  BCM2835_IC_GPU_IRQ,
> +                                                  GPU_INTERRUPT_DMA0 + n));
> +    }
> +
> +   /* According to DTS, DMA 7 and 8 share one irq */
> +    if (!qdev_realize(DEVICE(&s->dma_7_8_irq_orgate), NULL, errp)) {
> +        return;
> +    }
> +    DeviceState *dma_7_8_irq_orgate = DEVICE(&s->dma_7_8_irq_orgate);

Declaration not at top of code block (here and below).


Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

