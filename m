Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 035F982429D
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 14:21:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLNeX-0006M8-EP; Thu, 04 Jan 2024 08:20:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLNeV-0006LN-6f
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 08:20:51 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLNeT-0006BD-I7
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 08:20:50 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40d60ad5f0bso5328955e9.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 05:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704374447; x=1704979247; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i0X/gENd0lp00ZKQzSO/OCuz4ztqy3uU3tq+bWast84=;
 b=DjHDx9LebgGKkeMaO/TN3gWwG5ffrrnxziGsi93TsMbY7G6PEyBStzVREtvmxo6M5r
 MGdsC+JQbUAAC30+4FoQZhaKsHTNRfSNF86z/ItliPI0knSxolyrLBfln0te7uqb3sVs
 O+LL09WbbNhK8M6vPOMki5YLMuQVNe2s3jTTPwHiyWP+SgYaW0S83NNYOu7AfmNYGemv
 yy7MTcIPCSq36nR161Xscj0Dr+ORlq7kVK/4g0yWXVtM03OluvptJRoQ2C4uE5ms+ytr
 uIE9ZUrdrs52jSQCLQRoX2kBFWwp9AoBQygJ9QoGdU2SfXrpx6GfBBik0w2jESE4UQ4P
 HyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704374447; x=1704979247;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i0X/gENd0lp00ZKQzSO/OCuz4ztqy3uU3tq+bWast84=;
 b=iVi8KJveba33dOD2AHE+jKFbCahE50/3XrwcJ2AgSyyso499Q8cIawN7vWVTj/flSQ
 GjMBExGEqEoo8vL6dlTbYRDv+dO9uH11a3MjYFrtp7mVB+I6b4q09dzQqAbeTCfLTDlL
 7hyvJzUyBdo/ZKmIq0WK1TAEzsVp9/A8+Qhf93NWbgw8jebNfkVT7PYQIqVomPHo6BJt
 8V4fGs52eGtWh+PqsjKG07G6lgw1/uq7cpiX3zC6yLKmOsk8NNHXSI66bQuGS8iMrHeh
 LwVnIFGSV+SH1PVpRGEJBjZratRC14rNrqAFpqGbwxRMfdP3kVqY0RsEQ0skLYtOdsy1
 e61A==
X-Gm-Message-State: AOJu0YydjvWGsWZ8kYyAydlf86afiAR3meZnBR+IqhpRQEpvWlZ+Z2Xf
 ixyU+J8du18EDo3vrlQeciI1jpzvkvKmEg==
X-Google-Smtp-Source: AGHT+IHgfQiWQESRQtDpu16AxE6FBsd6J/3JZ9LDMGtIODEflxg7L6OItZsiqQ+8ykCouhOJsXKOwg==
X-Received: by 2002:a05:600c:540a:b0:40c:610d:c2bf with SMTP id
 he10-20020a05600c540a00b0040c610dc2bfmr411775wmb.16.1704374447241; 
 Thu, 04 Jan 2024 05:20:47 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.232])
 by smtp.gmail.com with ESMTPSA id
 t8-20020adfe448000000b003367eae8e18sm32998077wrm.57.2024.01.04.05.20.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jan 2024 05:20:46 -0800 (PST)
Message-ID: <6cc8aa4d-33de-47e2-aa34-d22f2877d7c6@linaro.org>
Date: Thu, 4 Jan 2024 14:20:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] hw/arm: Connect STM32L4x5 SYSCFG to STM32L4x5 SoC
Content-Language: en-US
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20231229164915.133199-1-ines.varhol@telecom-paris.fr>
 <20231229164915.133199-4-ines.varhol@telecom-paris.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231229164915.133199-4-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 29/12/23 17:47, Inès Varhol wrote:
> The SYSCFG input GPIOs aren't connected yet. When the STM32L4x5 GPIO
> device will be implemented, its output GPIOs will be connected to the
> SYSCFG input GPIOs.
> 
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   hw/arm/Kconfig                 |  1 +
>   hw/arm/stm32l4x5_soc.c         | 23 ++++++++++++++++++++++-
>   include/hw/arm/stm32l4x5_soc.h |  2 ++
>   3 files changed, 25 insertions(+), 1 deletion(-)


> diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
> index 08b8a4c2ed..0581f4ce30 100644
> --- a/hw/arm/stm32l4x5_soc.c
> +++ b/hw/arm/stm32l4x5_soc.c
> @@ -37,6 +37,7 @@
>   #define SRAM2_SIZE (32 * KiB)
>   
>   #define EXTI_ADDR 0x40010400
> +#define SYSCFG_ADDR 0x40010000
>   
>   #define NUM_EXTI_IRQ 40
>   /* Match exti line connections with their CPU IRQ number */
> @@ -81,6 +82,8 @@ static void stm32l4x5_soc_initfn(Object *obj)
>   
>       object_initialize_child(obj, "exti", &s->exti, TYPE_STM32L4X5_EXTI);
>   
> +    object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_STM32L4X5_SYSCFG);
> +
>       s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
>       s->refclk = qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0);
>   }
> @@ -158,6 +161,20 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
>           return;
>       }
>   
> +    /* System configuration controller */
> +    dev = DEVICE(&s->syscfg);

No need for 'dev', use 'busdev' directly.

> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->syscfg), errp)) {
> +        return;
> +    }
> +    busdev = SYS_BUS_DEVICE(dev);
> +    sysbus_mmio_map(busdev, 0, SYSCFG_ADDR);
> +    /*
> +     * TODO: when the GPIO device is implemented, connect it
> +     * to SYCFG using `qdev_connect_gpio_out`, NUM_GPIOS and
> +     * GPIO_NUM_PINS.
> +     */
> +
> +    /* EXTI device */
>       dev = DEVICE(&s->exti);
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->exti), errp)) {
>           return;
> @@ -168,6 +185,11 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
>           sysbus_connect_irq(busdev, i, qdev_get_gpio_in(armv7m, exti_irq[i]));
>       }
>   
> +    for (i = 0; i < 16; i++) {

You can reduce 'i' scope.

> +        qdev_connect_gpio_out(DEVICE(&s->syscfg), i,
> +                              qdev_get_gpio_in(dev, i));
> +    }

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Preferably using 'busdev':
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


