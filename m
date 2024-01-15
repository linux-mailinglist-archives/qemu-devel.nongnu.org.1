Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C670882D9BE
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 14:13:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPMlT-0005oH-3O; Mon, 15 Jan 2024 08:12:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPMlG-0005lD-IV
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 08:12:20 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPMlE-00020I-40
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 08:12:18 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-55969c01168so678282a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 05:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705324331; x=1705929131; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=utOW4KHiyUGEp6pFYtWe3XbaL9IhUgwTvb30EZyAdQI=;
 b=KZp7QaLpG2oEsHqaJDcvBE1gNWRfpDq/OUiMHPwvtmzdjDtlSjKNpxhvQIX1y3K+1U
 8RBcSBq7Dql4x+NaECr2laLoOwG6oyyXkW8pit5U405L7UcSxo7oXAJqfjdkYJ05xO8P
 2d6TBbbR/CUs1G6s8cyIoD+vJG9rzuIintQAfmO2/I41r0q8Udu1qTNJaMiwUdJMItUI
 MNpST8jszbd5to5UTK7JcELnMrr99WRVdeTbTO/9RX0b/gWhsb3E3JOr1vuY7pBF8HmJ
 VIxaCY66tcVjH1M+b9JrEJOAZDmCQ336BXHuJf+9tRV9DC7XhhybxzUX71qNy1/3wtWf
 gJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705324331; x=1705929131;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=utOW4KHiyUGEp6pFYtWe3XbaL9IhUgwTvb30EZyAdQI=;
 b=BLNKJrYmFpgSGmSHCtOIMtl2ZXIxKqVjutAv9qx3KdRyBWSBz2WejLOvk8WKTIgNDJ
 rB7QaLuin+O+RMsZoC9gUOEHTI3Gao+T6NQgLQdAKBtLJfewoM8QEj/2Swa3JUJHzxY1
 VU/KOfYv0lmjxCfws2BvGe/fxMKB+QtS3ZiyF0MPZHj6j9U/tzJmgABDazQiwVf9eKHj
 C4VVWhJ4a9Fluxmd0Nkz3WUaO019yQo2MZ69MOICxqcEUkRLma2/kiygH7w/bHX8vA2W
 vZGJNIMh2PbaBonrWZl7D5UNXjCCu5aMkDM30zwwiQ3oquArJ4ymlFzwwSuiyyK5I0V1
 swXQ==
X-Gm-Message-State: AOJu0YzM5bo+JLmZ5QBOO5eLtpaKj8y9GVW4WiFY3FuJe76l8WI9gbHX
 ayiruqVGfdF96GITztV68NM5glCWeWOOSTpCaWloqjcIp8+PyQ==
X-Google-Smtp-Source: AGHT+IGti2X1GYgMHs4Zq3UxCF/5U7Qwe0ERkbeIHPivm4+0nILMfCXMtBzkp3Eq98kZselIDgAVCAhbq0nVspVvzL4=
X-Received: by 2002:a05:6402:1747:b0:558:308f:db04 with SMTP id
 v7-20020a056402174700b00558308fdb04mr5071223edx.18.1705324331357; Mon, 15 Jan
 2024 05:12:11 -0800 (PST)
MIME-Version: 1.0
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
 <20231208023145.1385775-14-sergey.kambalin@auriga.com>
In-Reply-To: <20231208023145.1385775-14-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2024 13:12:00 +0000
Message-ID: <CAFEAcA8XxM7SuSdJAM=wGwUH=KxO-s7+idEeKYuZ9bE+YpU09w@mail.gmail.com>
Subject: Re: [PATCH v4 13/45] Add memory region for BCM2837 RPiVid ASB
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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
>  hw/arm/bcm2838_peripherals.c         | 3 +++
>  include/hw/arm/bcm2838_peripherals.h | 3 ++-
>  include/hw/arm/raspi_platform.h      | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
> index 196fb890a2..d3b42cf25b 100644
> --- a/hw/arm/bcm2838_peripherals.c
> +++ b/hw/arm/bcm2838_peripherals.c
> @@ -182,6 +182,9 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
>          sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gpio), 0));
>
>      object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->gpio), "sd-bus");
> +
> +    /* BCM2838 RPiVid ASB must be mapped to prevent kernel crash */
> +    create_unimp(s_base, &s->asb, "bcm2838-asb", RPI4B_ASB_OFFSET, 0x24);
>  }
>
>  static void bcm2838_peripherals_class_init(ObjectClass *oc, void *data)
> diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
> index 0a87645e01..af085934c9 100644
> --- a/include/hw/arm/bcm2838_peripherals.h
> +++ b/include/hw/arm/bcm2838_peripherals.h
> @@ -64,12 +64,13 @@ struct BCM2838PeripheralState {
>      MemoryRegion mphi_mr_alias;
>
>      SDHCIState emmc2;
> -    UnimplementedDeviceState clkisp;

This seems like it should be in some other patch ?

>      BCM2838GpioState gpio;
>
>      OrIRQState mmc_irq_orgate;
>      OrIRQState dma_7_8_irq_orgate;
>      OrIRQState dma_9_10_irq_orgate;
> +
> +    UnimplementedDeviceState asb;
>  };
>
>  struct BCM2838PeripheralClass {
> diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
> index 0db146e592..537fc6b4af 100644
> --- a/include/hw/arm/raspi_platform.h
> +++ b/include/hw/arm/raspi_platform.h
> @@ -74,6 +74,7 @@ uint64_t board_ram_size(uint32_t board_rev);
>  #define DMA_OFFSET              0x7000   /* DMA controller, channels 0-14 */
>  #define ARBA_OFFSET             0x9000
>  #define BRDG_OFFSET             0xa000
> +#define RPI4B_ASB_OFFSET        0xa000   /* BCM2838 (BCM2711) RPiVid ASB */

I think the existing BRDG_OFFSET was intended to be the
define for the address of this bridge device, so we can just use
it rather than adding a new define.

>  #define ARM_OFFSET              0xB000   /* ARM control block */
>  #define ARMCTRL_OFFSET          (ARM_OFFSET + 0x000)
>  #define ARMCTRL_IC_OFFSET       (ARM_OFFSET + 0x200) /* Interrupt controller */

thanks
-- PMM

