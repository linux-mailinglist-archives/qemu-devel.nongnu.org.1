Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A476182DBC4
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 15:49:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPOGs-0000T6-Bz; Mon, 15 Jan 2024 09:49:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPOGq-0000Sb-K2
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 09:49:00 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPOGo-0005u9-UE
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 09:49:00 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-559565a3008so914300a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 06:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705330137; x=1705934937; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MdvAY/skoETI9w55rN1NhBh3iyNacjjRloSMwJKhO0s=;
 b=alykRHwx/tET7pJ3CjWTbbJlJXqVW30wIvNDeMuCD64ToFyqODg+D0v7ZhBnDNZCMH
 fga1JaZ4p6hekKut3I9Zan/9KA2ONeX1Tj8y5sy6jRPNdNLqXZ30ZBLfLyvTv8ZBxfuZ
 +XhhNOsHE559S5jCZ4+SmJGDKSEr0pTOnn0DMgm72Hy1DZrpzKzZ3tjXe5Jhskgkm3Nt
 7PayDZItp7HnSkOs1K3VvnWt+7YIFgOL1r0plcj8c9E3LJacSWsLE4RxAObl0TGk7jHc
 hdQQOBPdK6tFoZHgRisRgKk3AlX3QUICquCTGRYft51TXUi7tNCFIZgCgDI3Gi8Mbpqg
 Qnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705330137; x=1705934937;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MdvAY/skoETI9w55rN1NhBh3iyNacjjRloSMwJKhO0s=;
 b=SWG2Tii/bFmGuyn1egNEnNnmEvjW6Cpw8fL6b2pNP68PCX23XHt7NYk3gH6itP/hk8
 07X6HILHnsIuUbosNQT3WMNzLo4JdtcK7FOS6qv8kjGEIELErt5UYRWwj4roZcldAwhW
 9zm606cK+FRUchy+7g0VEzB/C+AIKV6O7nr9lgybojjB3jz9SQ5zS7GxwHUE8s50BKWq
 mq1gdQ7Y8Ne71B4cqAmTmU24M17CYS5xyRqlabjSyVRk1DcGAKypQTrcMoE2ZMOZk/kD
 oJrFR0UNF2SBDodM8CnCZYzjWfKLR5VGcuyhQzDPXseclLaoD+3a33o12IVzZM2J3CKA
 jbTw==
X-Gm-Message-State: AOJu0YytLTj3+/zpulxTHv0ZPSpktSexe1gCypETdTWKBWua/TSRVoKV
 hVzHPrE92UGMuYObAscThSXsGPq9GIUwJpGnpirX5px5Lj1dMA==
X-Google-Smtp-Source: AGHT+IGnFhyCEKMuTryk8/eSA7SduqwzLHq4cWVCESE9UHOfjBE9zVAr/mEttyrj8YEhZplGrkcbNWNzL/1/lLftTAU=
X-Received: by 2002:aa7:d048:0:b0:559:1ff3:d05d with SMTP id
 n8-20020aa7d048000000b005591ff3d05dmr1411530edo.19.1705330137298; Mon, 15 Jan
 2024 06:48:57 -0800 (PST)
MIME-Version: 1.0
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
 <20231208023145.1385775-34-sergey.kambalin@auriga.com>
In-Reply-To: <20231208023145.1385775-34-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2024 14:48:46 +0000
Message-ID: <CAFEAcA8i4bmELL=R7peZ48UaUdwWxXXK4v2beB4p72=Wj5GH=A@mail.gmail.com>
Subject: Re: [PATCH v4 33/45] Connect RNG200, PCIE and GENET to GIC
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Fri, 8 Dec 2023 at 02:34, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2838.c                     | 19 +++++++++++++++++++
>  include/hw/arm/bcm2838_peripherals.h |  2 ++
>  2 files changed, 21 insertions(+)
>
> diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
> index 89cd9d5d8c..83f84b22ad 100644
> --- a/hw/arm/bcm2838.c
> +++ b/hw/arm/bcm2838.c
> @@ -210,6 +210,10 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
>      sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->dwc2), 0,
>                         qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_DWC2));
>
> +    /* Connect RNG200 to the interrupt controller */
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&ps->rng200), 0,
> +                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_RNG200));
> +
>      /* Connect DMA 0-6 to the interrupt controller */
>      for (int_n = GIC_SPI_INTERRUPT_DMA_0; int_n <= GIC_SPI_INTERRUPT_DMA_6;
>           int_n++) {
> @@ -232,6 +236,21 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
>      qdev_connect_gpio_out(dma_9_10_irq_orgate, 0,
>                            qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_DMA_9_10));
>
> +    /* Connect PCIe host bridge to the interrupt controller */
> +    for (n = 0; n < BCM2838_PCIE_NUM_IRQS; n++) {
> +        int_n = GIC_SPI_INTERRUPT_PCI_INT_A + n;
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&ps->pcie_host), n,
> +                           qdev_get_gpio_in(gicdev, int_n));
> +        bcm2838_pcie_host_set_irq_num(BCM2838_PCIE_HOST(&ps->pcie_host), n,
> +                                      int_n);
> +    }
> +
> +    /* Connect Gigabit Ethernet controller to the interrupt controller */
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&ps->genet), 0,
> +                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_GENET_A));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&ps->genet), 1,
> +                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_GENET_B));
> +
>      /* Pass through inbound GPIO lines to the GIC */
>      qdev_init_gpio_in(dev, bcm2838_gic_set_irq, GIC_NUM_IRQS);

These lines of code that wire up the interrupt lines for
the RNG200, PCIE controller, and ethernet controller,
should instead go in the various patches that add those
devices to the SoC.

> diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
> index 1cfcf5dcce..cdeb892f04 100644
> --- a/include/hw/arm/bcm2838_peripherals.h
> +++ b/include/hw/arm/bcm2838_peripherals.h
> @@ -17,6 +17,8 @@
>  #include "hw/sd/sdhci.h"
>  #include "hw/gpio/bcm2838_gpio.h"
>
> +#define GENET_OFFSET            0x1580000

This isn't used in this patch -- presumably it should be in
some other patch.

> +
>  /* SPI */
>  #define GIC_SPI_INTERRUPT_MBOX         33
>  #define GIC_SPI_INTERRUPT_MPHI         40
> --

thanks
-- PMM

