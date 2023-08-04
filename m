Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9934C770397
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 16:53:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRwB3-00065o-FB; Fri, 04 Aug 2023 10:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRwB1-00065I-Jj
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 10:53:15 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRwB0-0000wo-06
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 10:53:15 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5222c5d71b8so2817547a12.2
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 07:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691160792; x=1691765592;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dPgzANNjAIJu38nV7Kmp6FmoYSaRLm5N/CCpwK/mNPs=;
 b=yhdzu+/LKtuTDv1PbP+rTZjml+s/BbpkyKav+b/QR97xiL12gPotFM3WEH7rypBaAN
 7fRgOyZmsFWHc8HoTxU3uE/2NA+76Mn+PYT3MaB3kgmDtAdf5t0dJOiWnAHOA90EvXg3
 G/bTgArmZhPn0AMbNaPlmt/qcdCwrrvxEQmK1K2Zy45OCn8mjIYZJzstvVh26FP0WBTQ
 uC6ycTOuDhnj56nkVV8h6jT3KsghHJH+fGz86SR0gwEfydOu1dP2QtoC+POMEx6M3I9k
 NnD4uy0ccHvH0t3V91gCr8PC5XPAoa/FNCMEmf+odr+pB2c6xcI09V8zK25a11wHjsZx
 NgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691160792; x=1691765592;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dPgzANNjAIJu38nV7Kmp6FmoYSaRLm5N/CCpwK/mNPs=;
 b=ZKMMtkrVEj1XMILrzltyRB+Ky10h50g7SqaJI8u2cOJ19wra9RATkppObMpfHBKWrr
 7Sc5TsUWqUJNhZdfFo89F21ADQqfXjAZo+zCPMz7nzf+ZpPnCD9gEIDtcyNYbxzm5oH1
 W+ktSux152S5s9jpdwrCD+j6tC9/I9uJq+IiMIDsF4Z/Lai3yYEZpC1Wcp0uvF982oMa
 dbGPmPd4Se6EED+TVgzCOuvqrncDUdYMLBQpNf2Rkf2Ja3GFGGFeZqRadcWY2O7gTFcp
 hbUVg/PTSCM/G3bJBWa8zaLsmnI52/Ls2kJf96kokw2/SDLqu4+V8LXyBSXusjCI8Qx0
 Kn0Q==
X-Gm-Message-State: AOJu0YxxQm5a5U/JOUIkIceNr6UAajJx3Y2v80k/5+tYd4ikDOZV44Ku
 no/fuWNDH9CQskxTHaybh1K7bSuh8m7YKPrUEsK5UQ==
X-Google-Smtp-Source: AGHT+IEIWhSv8DLMFCIMBg2A6u7W6D2L0mL6DnuvZeLt+8z31p8R/ta6HWvSwADFH2W02LPOkquWtDIR+WQRWVkQPkc=
X-Received: by 2002:a05:6402:31f1:b0:522:289d:8dcd with SMTP id
 dy17-20020a05640231f100b00522289d8dcdmr1611515edb.35.1691160792325; Fri, 04
 Aug 2023 07:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20230726132512.149618-34-sergey.kambalin@auriga.com>
In-Reply-To: <20230726132512.149618-34-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 15:53:01 +0100
Message-ID: <CAFEAcA8L=FHerCHuWwmAhOJaNQapGx-YdWKJHYxzKed91Bm2Og@mail.gmail.com>
Subject: Re: [PATCH 33/44] Connect RNG200, PCIE and GENET to GIC
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 26 Jul 2023 at 15:22, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2838.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
> index a1980cc181..83bfbc2cae 100644
> --- a/hw/arm/bcm2838.c
> +++ b/hw/arm/bcm2838.c
> @@ -217,6 +217,10 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
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
> @@ -239,6 +243,21 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
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

I would be inclined to have the "connect device foo to the interrupt
controller" code change in the same patch that does "add device
foo to the board", but the code changes here are OK.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

