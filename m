Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A80B68361CD
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 12:34:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRsXh-0008P0-B1; Mon, 22 Jan 2024 06:32:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rRsXe-0008Oc-Qu
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 06:32:38 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rRsXc-0001cV-Sd
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 06:32:38 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3367a304091so3389455f8f.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 03:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705923155; x=1706527955; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Spj1DEQ3yDjTcC3IiWC7nEQw5VCoZYJNLSP2vwP4t8U=;
 b=O5RBX/ETcKylqELG5zgoyrDWzvpmzIEbh6ABM8wQ7NKHLtRqOOR/jWfBA9FQxGHAIb
 +Bf7V8FYPYYyXWQMcXVTYp2jpuUbM5WX4wK6Kyo12rwv2CHeVv4JJYtgBhrHXvo3HwFO
 LtJQRMK2GXXzVIpUTLDaA3xTWTZqkqND4U5X75572/Ll6BPDLqjlnh0ItKWtMILhpksj
 XdqX1XVQTFT6UIoa1bYicNOHZWoqIFNyLJlLRWTKHvhaeis3kIwvSwBKE/tl9DshawXw
 WEA0Mo2mAN1KGeb37tRx2rlAvrVABML77uXAY+JbfQ3yk8S4mpxUIvFIqowY2CkLHGMo
 Ymcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705923155; x=1706527955;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Spj1DEQ3yDjTcC3IiWC7nEQw5VCoZYJNLSP2vwP4t8U=;
 b=aoQvfS6Ns2Bq4YV9S0IQvr5FQh4ZLKGlLDo6y7XiI1lrJO+SMEDaxwadUCv/CzmqKe
 J0bfyyChOWYXyhU0YpX+ZoCa1kd3Rjs4H7xm+xF/MsssF/uomIoIYz9qsrM5yzk6Ze8G
 cYT7g+RqC0LlDiWnY4M+R7u1rhiJrle4ixIcP5qndNMbRBApPB9yuR/RDh0l7x4tpvOD
 eog69/rKhqjzSeAh0JYttdjFEthFz/f4cjwNyT+GsfCoKtFF1GIVquA/3O84x3hDhIWT
 DkWyjH6DQftL49sAWVu2Dxrq/SygmepaUir8jreSLwkZOm+hTUoBTxAh1sltzfmh84jM
 XZIA==
X-Gm-Message-State: AOJu0YygSSUPH5yAwSOssdvMN2wWi2vv+/OvLucYR3CE/49HQTxwlawf
 j3f9BLOqctY44mKeJF4W3ABSr/vt5iDvD6OR1+32Y5SKzBN8IsdaZXSlP1sYlu4=
X-Google-Smtp-Source: AGHT+IEFlDMS4oQRzYOtDLAgDnsYmfcqHHOGL7CwzxbqBVHe9Hc/oqPvZ1aM3x23sVVgiPCYNyuiHQ==
X-Received: by 2002:a5d:6186:0:b0:337:c700:460e with SMTP id
 j6-20020a5d6186000000b00337c700460emr1556519wru.160.1705923154983; 
 Mon, 22 Jan 2024 03:32:34 -0800 (PST)
Received: from [192.168.149.175] ([92.88.171.62])
 by smtp.gmail.com with ESMTPSA id
 y3-20020adfee03000000b003368c8d120fsm13662931wrn.7.2024.01.22.03.32.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 03:32:34 -0800 (PST)
Message-ID: <3f2bbcb1-9552-46e1-8bd9-de3e626d0de6@linaro.org>
Date: Mon, 22 Jan 2024 12:32:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/gpio: Implement STM32L4x5 GPIO
Content-Language: en-US
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
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
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Hello Inès,

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


> +static void stm32l4x5_gpio_a_class_init(ObjectClass *klass, void *data)
> +{
> +    Stm32l4x5GpioClass *sc = STM32L4X5_GPIO_CLASS(klass);
> +
> +    sc->moder_reset = 0xABFFFFFF;
> +    sc->ospeedr_reset = 0x0C000000;
> +    sc->pupdr_reset = 0x64000000;
> +}
> +
> +static void stm32l4x5_gpio_b_class_init(ObjectClass *klass, void *data)
> +{
> +    Stm32l4x5GpioClass *sc = STM32L4X5_GPIO_CLASS(klass);
> +
> +    sc->moder_reset = 0xFFFFFEBF;
> +    sc->ospeedr_reset = 0x00000000;
> +    sc->pupdr_reset = 0x00000100;
> +}
> +
> +static void stm32l4x5_gpio_c_class_init(ObjectClass *klass, void *data)
> +{
> +    Stm32l4x5GpioClass *sc = STM32L4X5_GPIO_CLASS(klass);
> +
> +    sc->moder_reset = 0xFFFFFFFF;
> +    sc->ospeedr_reset = 0x00000000;
> +    sc->pupdr_reset = 0x00000000;
> +}
> +
> +static void stm32l4x5_gpio_d_class_init(ObjectClass *klass, void *data)
> +{
> +    Stm32l4x5GpioClass *sc = STM32L4X5_GPIO_CLASS(klass);
> +
> +    sc->moder_reset = 0xFFFFFFFF;
> +    sc->ospeedr_reset = 0x00000000;
> +    sc->pupdr_reset = 0x00000000;
> +}
> +
> +static void stm32l4x5_gpio_e_class_init(ObjectClass *klass, void *data)
> +{
> +    Stm32l4x5GpioClass *sc = STM32L4X5_GPIO_CLASS(klass);
> +
> +    sc->moder_reset = 0xFFFFFFFF;
> +    sc->ospeedr_reset = 0x00000000;
> +    sc->pupdr_reset = 0x00000000;
> +}
> +
> +static void stm32l4x5_gpio_f_class_init(ObjectClass *klass, void *data)
> +{
> +    Stm32l4x5GpioClass *sc = STM32L4X5_GPIO_CLASS(klass);
> +
> +    sc->moder_reset = 0xFFFFFFFF;
> +    sc->ospeedr_reset = 0x00000000;
> +    sc->pupdr_reset = 0x00000000;
> +}
> +
> +static void stm32l4x5_gpio_g_class_init(ObjectClass *klass, void *data)
> +{
> +    Stm32l4x5GpioClass *sc = STM32L4X5_GPIO_CLASS(klass);
> +
> +    sc->moder_reset = 0xFFFFFFFF;
> +    sc->ospeedr_reset = 0x00000000;
> +    sc->pupdr_reset = 0x00000000;
> +}
> +
> +static void stm32l4x5_gpio_h_class_init(ObjectClass *klass, void *data)
> +{
> +    Stm32l4x5GpioClass *sc = STM32L4X5_GPIO_CLASS(klass);
> +
> +    sc->moder_reset = 0x0000000F;
> +    sc->ospeedr_reset = 0x00000000;
> +    sc->pupdr_reset = 0x00000000;
> +}
> +
> +static const TypeInfo stm32l4x5_gpio_types[] = {
> +    {
> +        .name = TYPE_STM32L4X5_GPIO,
> +        .parent = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(Stm32l4x5GpioState),
> +        .instance_init = stm32l4x5_gpio_init,
> +        .class_size     = sizeof(Stm32l4x5GpioClass),
> +        .class_init = stm32l4x5_gpio_class_init,
> +        .abstract = true,
> +    }, {
> +        .name = TYPE_STM32L4X5_GPIO_A,
> +        .parent = TYPE_STM32L4X5_GPIO,
> +        .class_init = stm32l4x5_gpio_a_class_init,
> +    }, {
> +        .name = TYPE_STM32L4X5_GPIO_B,
> +        .parent = TYPE_STM32L4X5_GPIO,
> +        .class_init = stm32l4x5_gpio_b_class_init,
> +    }, {
> +        .name = TYPE_STM32L4X5_GPIO_C,
> +        .parent = TYPE_STM32L4X5_GPIO,
> +        .class_init = stm32l4x5_gpio_c_class_init,
> +    }, {
> +        .name = TYPE_STM32L4X5_GPIO_D,
> +        .parent = TYPE_STM32L4X5_GPIO,
> +        .class_init = stm32l4x5_gpio_d_class_init,
> +    }, {

My understanding is the same GPIO block is used for the STM32L4*
family, and the reset values are specific to each SoC.

Therefore I'd keep a generic GPIO model in this file, and set the
reset values in stm32l4x5_soc.c, likely stm32l4x5_soc_realize().

Something like:

static const struct {
     uint32_t moder;
     uint32_t ospeedr;
     uint32_t pupdr;
} stm32l4x5_gpio_initval[NUM_GPIOS] = {
     { 0xABFFFFFF, 0x0C000000, 0x64000000 },
     { 0xFFFFFEBF, 0x00000000, 0x00000100 },
     { 0xFFFFFFFF, 0x00000000, 0x00000000 },
     ...
};

   for (unsigned i = 0; i < NUM_GPIOS; i++) {
       DeviceState *dev = DEVICE(&s->gpio[i]);
       g_autofree char *name = g_strdup_printf("%c", 'A' + i);

       qdev_prop_set_string(dev, "name", name);
       qdev_prop_set_uint32(dev, "mode-reset",
                            stm32l4x5_gpio_initval[i].moder);
       qdev_prop_set_uint32(dev, "ospeed-reset",
                            stm32l4x5_gpio_initval[i].ospeedr);
       qdev_prop_set_uint32(dev, "pupd-reset",
                            stm32l4x5_gpio_initval[i].pupdr);
       ...
   }

(Having "mode-reset", "ospeed-reset", "pupd-reset" exposed as
  DEFINE_PROP_UINT32() properties).

Regards,

Phil.

