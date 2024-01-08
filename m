Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA687826D7D
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 13:11:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMoSD-0003bC-BG; Mon, 08 Jan 2024 07:10:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMoRz-0003Yg-Sl
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:09:53 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMoRu-0007nO-Jq
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:09:51 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3376d424a79so419436f8f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 04:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704715780; x=1705320580; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jtXe+dzhAMlSGPEyFqRBRbFDpgDuMj3sGQqYIC+uJM0=;
 b=GaNryTUiscxnYiQc7a8nPWtnXdljjKe2Sh9WdIfSj3pEwSCc81RRXLv3BhJb8D8V2E
 RpNcfpr219myQJO/e5RXql5EXR5tIUianfwF0dxR41RxvSYrAfkhzYLw1dYQxXrsiz0B
 5vVc+AFtInK26bFwpli75eKzl/4NcUUjZ4l/wzh2TryN2YsCPrsPGXpyMUTSFx52BAkL
 4zz157rDTptHstXDi/ZHPU3cYIdGvyWcW2hOLy7m5H2SyIEIHdb85SsP1uZu/Bx5D6fi
 Sw11oZBEhCXOZGKO0m4MpgpBMEh/MxQGYUOJ3WkKFNH66Qjiaut4q4w27FsOGfHwbexk
 4bWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704715780; x=1705320580;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jtXe+dzhAMlSGPEyFqRBRbFDpgDuMj3sGQqYIC+uJM0=;
 b=VfKe3ylrF6GaMSjNR1JXe5zLWeRa+BX2/gL8kaJpa/2M7ljebj/6Gj9rfx6bjkYYm2
 uzhzEGeK6/rxv/iU22/NlKlkjWgA+FnojWGHMhzFElYMVbFC6DR36Qr75SvRKt6KN2B6
 tVLyxr5sq1NvLrH3B+Uks8gHclLoqatVckm/M613+QdIt7ooZvurWwIwIF6E1XNKV+V/
 gzsrOrsWiRl7Hhxf5oP/wdHq+uE8z7FwNT/MQ9lmgWOEtyribgeQlVraFzEYc9AnLZ8U
 UYWumb4YaU4ADa1cur309ZHw+SBuYrdnnxwlUW8v/QSrNV/II+Qv87A73f9PBi87wk23
 Z2yg==
X-Gm-Message-State: AOJu0YxURCam7CaeLRB12K0gJn5fb8pF7+apEsxGTvX/50tLH/fRfJo+
 Os4R+C32XzuxN3d5W5Ximngmyd1XPx1d/g==
X-Google-Smtp-Source: AGHT+IEnOBJ+L0Gi0tKn74h+yZNaHh7sPRJ9ZxFQsEfyG04C7Z7WSuDpbgEN/udW9/qFDeeCuCRk0A==
X-Received: by 2002:adf:a45b:0:b0:336:67bd:49f6 with SMTP id
 e27-20020adfa45b000000b0033667bd49f6mr1623450wra.53.1704715780334; 
 Mon, 08 Jan 2024 04:09:40 -0800 (PST)
Received: from [192.168.1.102] ([176.176.175.62])
 by smtp.gmail.com with ESMTPSA id
 l15-20020a5d410f000000b00336e43e8e57sm7617754wrp.58.2024.01.08.04.09.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 04:09:39 -0800 (PST)
Message-ID: <7a19dcea-4e54-4347-9bc4-1122c41273d2@linaro.org>
Date: Mon, 8 Jan 2024 13:09:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] hw/arm: Add minimal support for the STM32L4x5 SoC
Content-Language: en-US
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Samuel Tardieu <sam@rfc1149.net>
References: <20240106163905.42027-1-ines.varhol@telecom-paris.fr>
 <20240106163905.42027-2-ines.varhol@telecom-paris.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240106163905.42027-2-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Hi Inès,

On 6/1/24 17:38, Inès Varhol wrote:
> This patch adds a new STM32L4x5 SoC, it is necessary to add support for
> the B-L475E-IOT01A board.
> The implementation is derived from the STM32F405 SoC.
> The implementation contains no peripherals, only memory regions are
> implemented.
> 
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   MAINTAINERS                    |   8 +
>   hw/arm/Kconfig                 |   5 +
>   hw/arm/meson.build             |   1 +
>   hw/arm/stm32l4x5_soc.c         | 268 +++++++++++++++++++++++++++++++++
>   include/hw/arm/stm32l4x5_soc.h |  57 +++++++
>   5 files changed, 339 insertions(+)
>   create mode 100644 hw/arm/stm32l4x5_soc.c
>   create mode 100644 include/hw/arm/stm32l4x5_soc.h


> +static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
> +{
> +    ERRP_GUARD();
> +    Stm32l4x5SocState *s = STM32L4X5_SOC(dev_soc);
> +    const Stm32l4x5SocClass *sc = STM32L4X5_SOC_GET_CLASS(dev_soc);
> +    MemoryRegion *system_memory = get_system_memory();
> +    DeviceState *armv7m;
> +
> +    /*
> +     * We use s->refclk internally and only define it with qdev_init_clock_in()
> +     * so it is correctly parented and not leaked on an init/deinit; it is not
> +     * intended as an externally exposed clock.
> +     */
> +    if (clock_has_source(s->refclk)) {
> +        error_setg(errp, "refclk clock must not be wired up by the board code");
> +        return;
> +    }
> +
> +    if (!clock_has_source(s->sysclk)) {
> +        error_setg(errp, "sysclk clock must be wired up by the board code");
> +        return;
> +    }
> +
> +    /*
> +     * TODO: ideally we should model the SoC RCC and its ability to
> +     * change the sysclk frequency and define different sysclk sources.
> +     */
> +
> +    /* The refclk always runs at frequency HCLK / 8 */
> +    clock_set_mul_div(s->refclk, 8, 1);
> +    clock_set_source(s->refclk, s->sysclk);
> +
> +    memory_region_init_rom(&s->flash, OBJECT(dev_soc), "flash",
> +                           sc->flash_size, errp);
> +    if (*errp) {
> +        return;

Since commit b9159451d3 ("memory: Have memory_region_init_rom
handler return a boolean") you don't need that anymore.

> +    }
> +    memory_region_init_alias(&s->flash_alias, OBJECT(dev_soc),
> +                             "flash_boot_alias", &s->flash, 0,
> +                             sc->flash_size);
> +
> +    memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->flash);
> +    memory_region_add_subregion(system_memory, 0, &s->flash_alias);
> +
> +    memory_region_init_ram(&s->sram1, OBJECT(dev_soc), "SRAM1", SRAM1_SIZE,
> +                           errp);
> +    if (*errp) {
> +        return;

Ditto with commit fe5f33d6b0 ("memory: Have memory_region_init_ram
handler return a boolean").

> +    }
> +    memory_region_add_subregion(system_memory, SRAM1_BASE_ADDRESS, &s->sram1);
> +
> +    memory_region_init_ram(&s->sram2, OBJECT(dev_soc), "SRAM2", SRAM2_SIZE,
> +                           errp);
> +    if (*errp) {
> +        return;

Ditto.

Can be done as a cleanup patch on top if you don't have time to post
a v6 before Peter queue your v5.

> +    }
> +    memory_region_add_subregion(system_memory, SRAM2_BASE_ADDRESS, &s->sram2);
> +
> +    object_initialize_child(OBJECT(dev_soc), "armv7m", &s->armv7m, TYPE_ARMV7M);
> +    armv7m = DEVICE(&s->armv7m);
> +    qdev_prop_set_uint32(armv7m, "num-irq", 96);
> +    qdev_prop_set_string(armv7m, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
> +    qdev_prop_set_bit(armv7m, "enable-bitband", true);
> +    qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
> +    qdev_connect_clock_in(armv7m, "refclk", s->refclk);
> +    object_property_set_link(OBJECT(&s->armv7m), "memory",
> +                             OBJECT(system_memory), &error_abort);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
> +        return;
> +    }
> +
> +    /* APB1 BUS */
> +    create_unimplemented_device("TIM2",      0x40000000, 0x400);
> +    create_unimplemented_device("TIM3",      0x40000400, 0x400);
> +    create_unimplemented_device("TIM4",      0x40000800, 0x400);
> +    create_unimplemented_device("TIM5",      0x40000C00, 0x400);
> +    create_unimplemented_device("TIM6",      0x40001000, 0x400);
> +    create_unimplemented_device("TIM7",      0x40001400, 0x400);
> +    /* RESERVED:    0x40001800, 0x1000 */
> +    create_unimplemented_device("RTC",       0x40002800, 0x400);
> +    create_unimplemented_device("WWDG",      0x40002C00, 0x400);
> +    create_unimplemented_device("IWDG",      0x40003000, 0x400);
> +    /* RESERVED:    0x40001800, 0x400 */
> +    create_unimplemented_device("SPI2",      0x40003800, 0x400);
> +    create_unimplemented_device("SPI3",      0x40003C00, 0x400);
> +    /* RESERVED:    0x40004000, 0x400 */
> +    create_unimplemented_device("USART2",    0x40004400, 0x400);
> +    create_unimplemented_device("USART3",    0x40004800, 0x400);
> +    create_unimplemented_device("UART4",     0x40004C00, 0x400);
> +    create_unimplemented_device("UART5",     0x40005000, 0x400);
> +    create_unimplemented_device("I2C1",      0x40005400, 0x400);
> +    create_unimplemented_device("I2C2",      0x40005800, 0x400);
> +    create_unimplemented_device("I2C3",      0x40005C00, 0x400);
> +    /* RESERVED:    0x40006000, 0x400 */
> +    create_unimplemented_device("CAN1",      0x40006400, 0x400);
> +    /* RESERVED:    0x40006800, 0x400 */
> +    create_unimplemented_device("PWR",       0x40007000, 0x400);
> +    create_unimplemented_device("DAC1",      0x40007400, 0x400);
> +    create_unimplemented_device("OPAMP",     0x40007800, 0x400);
> +    create_unimplemented_device("LPTIM1",    0x40007C00, 0x400);
> +    create_unimplemented_device("LPUART1",   0x40008000, 0x400);
> +    /* RESERVED:    0x40008400, 0x400 */
> +    create_unimplemented_device("SWPMI1",    0x40008800, 0x400);
> +    /* RESERVED:    0x40008C00, 0x800 */
> +    create_unimplemented_device("LPTIM2",    0x40009400, 0x400);
> +    /* RESERVED:    0x40009800, 0x6800 */
> +
> +    /* APB2 BUS */
> +    create_unimplemented_device("SYSCFG",    0x40010000, 0x30);
> +    create_unimplemented_device("VREFBUF",   0x40010030, 0x1D0);
> +    create_unimplemented_device("COMP",      0x40010200, 0x200);
> +    create_unimplemented_device("EXTI",      0x40010400, 0x400);
> +    /* RESERVED:    0x40010800, 0x1400 */
> +    create_unimplemented_device("FIREWALL",  0x40011C00, 0x400);
> +    /* RESERVED:    0x40012000, 0x800 */
> +    create_unimplemented_device("SDMMC1",    0x40012800, 0x400);
> +    create_unimplemented_device("TIM1",      0x40012C00, 0x400);
> +    create_unimplemented_device("SPI1",      0x40013000, 0x400);
> +    create_unimplemented_device("TIM8",      0x40013400, 0x400);
> +    create_unimplemented_device("USART1",    0x40013800, 0x400);
> +    /* RESERVED:    0x40013C00, 0x400 */
> +    create_unimplemented_device("TIM15",     0x40014000, 0x400);
> +    create_unimplemented_device("TIM16",     0x40014400, 0x400);
> +    create_unimplemented_device("TIM17",     0x40014800, 0x400);
> +    /* RESERVED:    0x40014C00, 0x800 */
> +    create_unimplemented_device("SAI1",      0x40015400, 0x400);
> +    create_unimplemented_device("SAI2",      0x40015800, 0x400);
> +    /* RESERVED:    0x40015C00, 0x400 */
> +    create_unimplemented_device("DFSDM1",    0x40016000, 0x400);
> +    /* RESERVED:    0x40016400, 0x9C00 */
> +
> +    /* AHB1 BUS */
> +    create_unimplemented_device("DMA1",      0x40020000, 0x400);
> +    create_unimplemented_device("DMA2",      0x40020400, 0x400);
> +    /* RESERVED:    0x40020800, 0x800 */
> +    create_unimplemented_device("RCC",       0x40021000, 0x400);
> +    /* RESERVED:    0x40021400, 0xC00 */
> +    create_unimplemented_device("FLASH",     0x40022000, 0x400);
> +    /* RESERVED:    0x40022400, 0xC00 */
> +    create_unimplemented_device("CRC",       0x40023000, 0x400);
> +    /* RESERVED:    0x40023400, 0x400 */
> +    create_unimplemented_device("TSC",       0x40024000, 0x400);
> +
> +    /* RESERVED:    0x40024400, 0x7FDBC00 */
> +
> +    /* AHB2 BUS */
> +    create_unimplemented_device("GPIOA",     0x48000000, 0x400);
> +    create_unimplemented_device("GPIOB",     0x48000400, 0x400);
> +    create_unimplemented_device("GPIOC",     0x48000800, 0x400);
> +    create_unimplemented_device("GPIOD",     0x48000C00, 0x400);
> +    create_unimplemented_device("GPIOE",     0x48001000, 0x400);
> +    create_unimplemented_device("GPIOF",     0x48001400, 0x400);
> +    create_unimplemented_device("GPIOG",     0x48001800, 0x400);
> +    create_unimplemented_device("GPIOH",     0x48001C00, 0x400);
> +    /* RESERVED:    0x48002000, 0x7FDBC00 */
> +    create_unimplemented_device("OTG_FS",    0x50000000, 0x40000);
> +    create_unimplemented_device("ADC",       0x50040000, 0x400);
> +    /* RESERVED:    0x50040400, 0x20400 */
> +    create_unimplemented_device("RNG",       0x50060800, 0x400);
> +
> +    /* AHB3 BUS */
> +    create_unimplemented_device("FMC",       0xA0000000, 0x1000);
> +    create_unimplemented_device("QUADSPI",   0xA0001000, 0x400);
> +}


