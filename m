Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F474836203
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 12:38:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRsce-00015L-RF; Mon, 22 Jan 2024 06:37:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rRscc-00014T-CW
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 06:37:46 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rRsca-0002yO-Ef
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 06:37:46 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-337d58942c9so3306546f8f.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 03:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705923462; x=1706528262; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SVJfVQ2y2FtsZNCREqkky2ma7FevhYRPbqBBi8ZQPAc=;
 b=PNWsiR1extONPhaNP9WSRYpR9MyWLaZ6DxAq/1rALXtg5Y62+LFAfx9mOHvBG23YJr
 r0bpgC0kXN50zoPE3jOvpeLEtATJU+MYiMz07jetpn6bnAmug8NddrG+THul9w8xttXM
 4Wz+8lBH7MtAi22dAEBx7kDsUkHtHC77IACyArh40yMJFB1SN65VPnMc3Yla/6SDPsqr
 tB+nDhU4H8AynWg2bfOPxEjU2ZcPCPfLwQuciJ9V+csyVg6Izum9XG7M4YYtULHSZxG1
 3okW1rJwGItz86Hc57vjMFYrRj8imSSWYEV5tgP2aqCSe38nG4gJqRyO9DsIu+2XgssM
 30jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705923462; x=1706528262;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SVJfVQ2y2FtsZNCREqkky2ma7FevhYRPbqBBi8ZQPAc=;
 b=VnJ/BuntkWRa94pJhb+hNRiZjU3TeJQE/4T7T8FSLQCv6xB+M8RBWMql04wtt+x3hJ
 rRo6Oye8/E6VftQDWEWTcBKcu1veZotFY1leVSnsqFpR+gAidhWzwqsD7EibMX9Y1wlx
 uFqFsLMH7qwlG3+XTbz/ggvd3uMa0wYrLhPtrCFik9t/nJwhhSCWFFyHQhQiI1Ym0Znw
 azy5C+OxEc5XJwAv7IpuABx3G98xvMSbVrzfVRWl8azE6gidFi6Ovbcfy4Fgzyp4ItZl
 51vCuRcNkNuM84TiXp+8+N7hkP/m72pktgzAdsrYBrWuvwwYQLanuKt5CiJB1+7CuCXj
 5Gzg==
X-Gm-Message-State: AOJu0YweMFESToC+pCDOTVqHR8FqGbg2apfAKXrYKg4zeHP0rrZEc7rG
 1rnVZwGU68oMDFbs4ieWUuC5z0b9GHUecVar3A+hiOIed1k/rQMHOzNHA53NGHA=
X-Google-Smtp-Source: AGHT+IGzvWkKKY85bCGyC1RP0Yh5t69cfMg/jW+2VsOWhImhdew3MBx4Vg7HhCtOmjisC79i2d0OAA==
X-Received: by 2002:a05:600c:314e:b0:40e:4ab8:639a with SMTP id
 h14-20020a05600c314e00b0040e4ab8639amr2478165wmo.246.1705923462153; 
 Mon, 22 Jan 2024 03:37:42 -0800 (PST)
Received: from [192.168.149.175] ([92.88.171.62])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a05600c358a00b0040e559e0ba7sm42463804wmq.26.2024.01.22.03.37.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 03:37:41 -0800 (PST)
Message-ID: <8ba545d4-0a8d-4a8a-9e31-8b7b48b6c2e0@linaro.org>
Date: Mon, 22 Jan 2024 12:37:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/gpio: Implement STM32L4x5 GPIO
Content-Language: en-US
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: qemu-arm@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240122092005.30556-1-ines.varhol@telecom-paris.fr>
 <20240122092005.30556-2-ines.varhol@telecom-paris.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240122092005.30556-2-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Hi Inès,

On 22/1/24 10:18, Inès Varhol wrote:
> Features supported :
> - the 8 STM32L4x5 GPIOs are initialized with their reset values
>      (except IDR, see below)
> - input mode : setting a pin in input mode "externally" (using input
>      irqs) results in an out irq (transmitted to SYSCFG)
> - output mode : setting a bit in ODR sets the corresponding out irq
>      (if this line is configured in output mode)
> - pull-up, pull-down
> - push-pull, open-drain
> 
> Difference with the real GPIOs :
> - Alternate Function and Analog mode aren't implemented :
>      pins in AF/Analog behave like pins in input mode
> - floating pins stay at their last value
> - register IDR reset values differ from the real one :
>      values are coherent with the other registers reset values
>      and the fact that AF/Analog modes aren't implemented
> - setting I/O output speed isn't supported
> - locking port bits isn't supported
> - ADC function isn't supported
> - GPIOH has 16 pins instead of 2 pins
> - writing to registers LCKR, AFRL, AFRH and ASCR is ineffective
> 
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   MAINTAINERS                        |   1 +
>   docs/system/arm/b-l475e-iot01a.rst |   2 +-
>   hw/gpio/Kconfig                    |   3 +
>   hw/gpio/meson.build                |   1 +
>   hw/gpio/stm32l4x5_gpio.c           | 537 +++++++++++++++++++++++++++++
>   hw/gpio/trace-events               |   6 +
>   include/hw/gpio/stm32l4x5_gpio.h   |  80 +++++
>   7 files changed, 629 insertions(+), 1 deletion(-)
>   create mode 100644 hw/gpio/stm32l4x5_gpio.c
>   create mode 100644 include/hw/gpio/stm32l4x5_gpio.h


> +#define GPIO_MODER 0x00
> +#define GPIO_OTYPER 0x04
> +#define GPIO_OSPEEDR 0x08
> +#define GPIO_PUPDR 0x0C
> +#define GPIO_IDR 0x10
> +#define GPIO_ODR 0x14
> +#define GPIO_BSRR 0x18
> +#define GPIO_LCKR 0x1C
> +#define GPIO_AFRL 0x20
> +#define GPIO_AFRH 0x24
> +#define GPIO_BRR 0x28
> +#define GPIO_ASCR 0x2C
> +/*
> + * DISCONNECTED_PINS isn't actually a GPIO register.
> + * It exists to ensure that :
> + * - push-pull output pins can't be set externally
> + * - open-drain output pins can only be externally set to 0
> + *
> + * This field is accessed for test purposes.
> + */
> +#define GPIO_DISCONNECTED_PINS 0x30

[*]

> +static void stm32l4x5_gpio_write(void *opaque, hwaddr addr,
> +                                 uint64_t val64, unsigned int size)
> +{
> +    Stm32l4x5GpioState *s = opaque;
> +
> +    uint32_t value = val64;
> +    trace_stm32l4x5_gpio_write(addr, val64);
> +
> +    switch (addr) {


> +    /* a tweak to enable the qtest checking disconnected pins */
> +    case GPIO_DISCONNECTED_PINS:
> +        disconnect_gpio_pins(s, value);
> +        return;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, addr);
> +    }
> +}
> +
> +static uint64_t stm32l4x5_gpio_read(void *opaque, hwaddr addr,
> +                                    unsigned int size)
> +{
> +    Stm32l4x5GpioState *s = opaque;
> +
> +    trace_stm32l4x5_gpio_read(addr);
> +
> +    switch (addr) {


> +    /* a tweak to enable the qtest checking disconnected pins */
> +    case GPIO_DISCONNECTED_PINS:
> +        return s->disconnected_pins;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, addr);
> +        return 0;
> +    }
> +}


> +static void stm32l4x5_gpio_init(Object *obj)
> +{
> +    Stm32l4x5GpioState *s = STM32L4X5_GPIO(obj);
> +
> +    memory_region_init_io(&s->mmio, obj, &stm32l4x5_gpio_ops, s,
> +                          TYPE_STM32L4X5_GPIO, 0x400);

This "testing purpose" [*] register is accessible by the guest, so
this isn't a faithful emulation of the device, and could possibly
lead to unexpected guest behavior.
You can store testing fields in the device state, but don't expose
the as register. Expose them as QOM/QDev properties and access them
with the QOM QTest helpers.

Regards,

Phil.

> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +
> +    qdev_init_gpio_out(DEVICE(obj), s->pin, GPIO_NUM_PINS);
> +    qdev_init_gpio_in(DEVICE(obj), stm32l4x5_gpio_set, GPIO_NUM_PINS);
> +
> +    s->clk = qdev_init_clock_in(DEVICE(s), "clk", NULL, s, 0);
> +}


