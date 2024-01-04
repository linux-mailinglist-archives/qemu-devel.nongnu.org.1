Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B4E824298
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 14:19:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLNcJ-0005P8-63; Thu, 04 Jan 2024 08:18:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLNbs-0005Di-8B
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 08:18:08 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLNbo-0005XG-AC
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 08:18:07 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50eaabc36bcso558617e87.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 05:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704374282; x=1704979082; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0nqpvXDtbcm8dXnlETyYiphTGxuBaT+IlARwQCABQIw=;
 b=gLR+S4BEaWvTFey0cUrCyHgnCppMDW6icA9/aTLgM0QBlAA1ZjWFjAhzeeZBKAd4f5
 ztQEY/SlQvqDpstYzRpBNWXz9rAbJwyugNHi2Fnos2Fl6dOy6B+C211xb4ZzC9W5Ht2J
 O+1VBSa5OJ3EX0dhSjGGRJBoY0u+V6XXjtAE4IkZ/nkU+5IhvbYuTrgsic+9/nxYNS0e
 QYJTelAAzFLHZSVswK5PW4jnvoxZGYBfIqb0FzbRmXaXLVyiIx0wmNv+/60POhCqZbHa
 nl0uUedtckwFg038/RQOy7AC5TQOJJmU89GNdK3Oisy04WesNMuKqknpQsG4FrD6kVHd
 lyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704374282; x=1704979082;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0nqpvXDtbcm8dXnlETyYiphTGxuBaT+IlARwQCABQIw=;
 b=lGDUPxg4QBI3fA58suaF7yFMV6rLni/Ebc+gA5aaT6wlnvhqIbhB4sEagjK4HOCUYV
 qSxntKVhNyVmIxpGlj3BS4YXo5FuJ8QmHtmTOPmZPKCb9zyYPg1SezjRuPYppmrVPrP3
 OAcVdah/tdhlfISzoMOJRKWpHNwDnbWCo046YWNnzeT9ABYonSJhBWEQ1ijYvRgtAgPB
 Untbb9Q+SrAxQx0cufhQuxZppj6FyF3QK7Xe0e2hHOh4zjZUK1EJzD9ibLrsVChZmmTQ
 SJdeyQAiZvhoPNDNZof+0UonEvEYpKjtiG3qsIwpk/3dHreAqlb+94hB1AauJclT4gNd
 ufyQ==
X-Gm-Message-State: AOJu0YwkKP/XojDSlPTu9xg2WnRrdjCL9fbG6L+kSabhyJjQLK9chcEE
 tJC1tVFNCi/IzPZT0prvKsThpT/IT/27uA==
X-Google-Smtp-Source: AGHT+IEwU9jTKYARthldhgOdyyqSdLVkPPO2I0y1gW5UCqFom0i5MvofuoKZkd5t3WjN7gQijFf82w==
X-Received: by 2002:a05:6512:1091:b0:50e:4598:b836 with SMTP id
 j17-20020a056512109100b0050e4598b836mr480262lfg.15.1704374282071; 
 Thu, 04 Jan 2024 05:18:02 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.232])
 by smtp.gmail.com with ESMTPSA id
 ck15-20020a0564021c0f00b00555f908b2e4sm7429756edb.40.2024.01.04.05.18.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jan 2024 05:18:01 -0800 (PST)
Message-ID: <88e6855d-4b5f-46aa-b926-142d60275d7c@linaro.org>
Date: Thu, 4 Jan 2024 14:17:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] hw/arm: Connect STM32L4x5 EXTI to STM32L4x5 SoC
Content-Language: en-US
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org
References: <20231228161944.303768-1-ines.varhol@telecom-paris.fr>
 <20231228161944.303768-4-ines.varhol@telecom-paris.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231228161944.303768-4-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
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

On 28/12/23 17:19, Inès Varhol wrote:
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   hw/arm/Kconfig                 |  1 +
>   hw/arm/stm32l4x5_soc.c         | 56 ++++++++++++++++++++++++++++++++--
>   include/hw/arm/stm32l4x5_soc.h |  3 ++
>   3 files changed, 58 insertions(+), 2 deletions(-)


>   static void stm32l4x5_soc_initfn(Object *obj)
>   {
>       Stm32l4x5SocState *s = STM32L4X5_SOC(obj);
>   
> +    object_initialize_child(obj, "exti", &s->exti, TYPE_STM32L4X5_EXTI);
> +
>       s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
>       s->refclk = qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0);
>   }
> @@ -50,7 +91,9 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
>       Stm32l4x5SocState *s = STM32L4X5_SOC(dev_soc);
>       const Stm32l4x5SocClass *sc = STM32L4X5_SOC_GET_CLASS(dev_soc);
>       MemoryRegion *system_memory = get_system_memory();
> -    DeviceState *armv7m;
> +    DeviceState *dev, *armv7m;
> +    SysBusDevice *busdev;
> +    int i;
>   
>       /*
>        * We use s->refclk internally and only define it with qdev_init_clock_in()
> @@ -115,6 +158,16 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
>           return;
>       }
>   
> +    dev = DEVICE(&s->exti);

'dev' isn't used, you can drop it and directly use:

        busdev = SYS_BUS_DEVICE(&s->exti);

> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->exti), errp)) {

Here you can use 'busdev' directly.

> +        return;
> +    }
> +    busdev = SYS_BUS_DEVICE(dev);
> +    sysbus_mmio_map(busdev, 0, EXTI_ADDR);
> +    for (i = 0; i < NUM_EXTI_IRQ; i++) {

Preferably reduce 'i' scope:

        for (unsigned i = 0; ...) {

> +        sysbus_connect_irq(busdev, i, qdev_get_gpio_in(armv7m, exti_irq[i]));
> +    }

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

With the comments addressed:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


