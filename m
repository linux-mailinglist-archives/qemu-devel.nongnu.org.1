Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 491507EB5D4
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 18:52:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2xYk-000060-3n; Tue, 14 Nov 2023 12:50:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r2xYX-0008T4-2a
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 12:50:33 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r2xYT-0006yz-NI
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 12:50:31 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1cc9b626a96so44106545ad.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 09:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699984227; x=1700589027; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b8g4aEzC7MDrvie62XuhD4OwHUARoyUTJrBmidINrEA=;
 b=XG4xAUXtWKSxfr5o/i0HXLYYO82DukMvp/VLiEL3wTW3Gk+jLfyofokAcmD0O6QPsD
 +LJOCYLa+pZHzzxm1EELdg4Li68brBPFOrthxP8WHyfQGOxQai5iuG3KTpFORJvwvFoY
 Cw0zsnEAxwVglZtB1G23CPeNpvGFLRxyCL8liiBAvQ28q5vWuhTWVStZwTvjhSjHA5yc
 0QJtRbBRadzbRbE2RGf3kkYT/fg4UsvbqEZIcHkcT5G4mpZcUnvJfpJf4XFXJf1otJ3O
 tajKmxCeWSoPK2XRj4C5budJbNsZoJuPEibIIfNRE9MlqHoRgGhZ4CuZcL9nolqAosIq
 IXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699984227; x=1700589027;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b8g4aEzC7MDrvie62XuhD4OwHUARoyUTJrBmidINrEA=;
 b=Kd21VBj1GbUcD+QW9HxsTU0CxaRQCXq0/VKQJ9CalgWThcrhMX20nXIhrY9EZ78Ocw
 6tMRhWIdZwkNf6FJ1toX3f+G7szxC9vymc7kSaQWDIM3o64d+wbY9hn++yd4fyQt849C
 tYtEl+uyGaRthyJpVu5Wbfg/UI5QbhTfK4E9BB7NQto6p1TmjQcjdXNbj24lSsVFJdJm
 J9rR9VVNf1cbahFV4eRIIRQKrUIMp8le6NyrVnlx2d1anLi4+nHY3MslIGXZbknUSqFM
 LXWF1VUfMoJF8ogTXnZZQ3ubZzP03PWgW1rPF0eSjmdg3FE1qDFVce7nWiW2vd84KkRP
 y3Rg==
X-Gm-Message-State: AOJu0Yy/E7oz0QBtxsp4k4lt7HDN6nE2IiKJhQXIZQsfZ4k4pQ27MFol
 bCpFe1QyUy08pf7757vCpNuYew==
X-Google-Smtp-Source: AGHT+IHrsUaNqq7GmSH/FArq9RtXh2AdM/kH2o6gLTMp08p01KbsXrj6GHaudqdxHxNKeuiA4KBM0A==
X-Received: by 2002:a17:902:da89:b0:1cc:3932:4a95 with SMTP id
 j9-20020a170902da8900b001cc39324a95mr3610401plx.62.1699984227546; 
 Tue, 14 Nov 2023 09:50:27 -0800 (PST)
Received: from [192.168.68.109] ([152.250.131.148])
 by smtp.gmail.com with ESMTPSA id
 jf14-20020a170903268e00b001b89891bfc4sm5919677plb.199.2023.11.14.09.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 09:50:27 -0800 (PST)
Message-ID: <21de33ac-5f9c-46c6-bca0-3de2116e71a6@ventanamicro.com>
Date: Tue, 14 Nov 2023 14:50:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] hw/riscv/virt: Add IOPMP support
Content-Language: en-US
To: Ethan Chen <ethan84@andestech.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, edgar.iglesias@gmail.com,
 richard.henderson@linaro.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, in.meng@windriver.com, liweiwei@iscas.ac.cn,
 hiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, peterx@redhat.com,
 david@redhat.com
References: <20231114094705.109146-1-ethan84@andestech.com>
 <20231114094705.109146-5-ethan84@andestech.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231114094705.109146-5-ethan84@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
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



On 11/14/23 06:47, Ethan Chen wrote:
> - Add 'iopmp=on' option to enable a iopmp device and a dma device
>   connect to the iopmp device
> - Add 'iopmp_cascade=on' option to enable iopmp cascading.
> 
> Signed-off-by: Ethan Chen <ethan84@andestech.com>
> ---
>   hw/riscv/Kconfig        |  2 ++
>   hw/riscv/virt.c         | 72 +++++++++++++++++++++++++++++++++++++++--
>   include/hw/riscv/virt.h | 10 +++++-
>   3 files changed, 81 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index b6a5eb4452..c30a104aa4 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -45,6 +45,8 @@ config RISCV_VIRT
>       select FW_CFG_DMA
>       select PLATFORM_BUS
>       select ACPI
> +    select ATCDMAC300
> +    select RISCV_IOPMP
>   
>   config SHAKTI_C
>       bool
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index c7fc97e273..3e23ee3afc 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -53,6 +53,8 @@
>   #include "hw/display/ramfb.h"
>   #include "hw/acpi/aml-build.h"
>   #include "qapi/qapi-visit-common.h"
> +#include "hw/misc/riscv_iopmp.h"
> +#include "hw/dma/atcdmac300.h"
>   
>   /*
>    * The virt machine physical address space used by some of the devices
> @@ -97,6 +99,9 @@ static const MemMapEntry virt_memmap[] = {
>       [VIRT_UART0] =        { 0x10000000,         0x100 },
>       [VIRT_VIRTIO] =       { 0x10001000,        0x1000 },
>       [VIRT_FW_CFG] =       { 0x10100000,          0x18 },
> +    [VIRT_IOPMP] =        { 0x10200000,      0x100000 },
> +    [VIRT_IOPMP2] =       { 0x10300000,      0x100000 },
> +    [VIRT_DMAC] =         { 0x10400000,      0x100000 },
>       [VIRT_FLASH] =        { 0x20000000,     0x4000000 },
>       [VIRT_IMSIC_M] =      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
>       [VIRT_IMSIC_S] =      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
> @@ -1527,13 +1532,33 @@ static void virt_machine_init(MachineState *machine)
>   
>       create_platform_bus(s, mmio_irqchip);
>   
> -    serial_mm_init(system_memory, memmap[VIRT_UART0].base,
> -        0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
> +    serial_mm_init(system_memory, memmap[VIRT_UART0].base + 0x20,
> +        0x2, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 38400,
>           serial_hd(0), DEVICE_LITTLE_ENDIAN);

It would be good to have some variables/macros to hold these literals like '0x20'
since they aren't self-explanatory when reading the code.

>   
>       sysbus_create_simple("goldfish_rtc", memmap[VIRT_RTC].base,
>           qdev_get_gpio_in(mmio_irqchip, RTC_IRQ));
>   
> +    /* DMAC */
> +    DeviceState *dmac_dev = atcdmac300_create("atcdmac300",
> +        memmap[VIRT_DMAC].base, memmap[VIRT_DMAC].size,
> +        qdev_get_gpio_in(DEVICE(mmio_irqchip), DMAC_IRQ));
> +
> +    if (s->have_iopmp) {
> +        /* IOPMP */
> +        DeviceState *iopmp_dev = iopmp_create(memmap[VIRT_IOPMP].base,
> +            qdev_get_gpio_in(DEVICE(mmio_irqchip), IOPMP_IRQ));
> +        /* DMA with IOPMP */
> +        atcdmac300_connect_iopmp(dmac_dev, &(IOPMP(iopmp_dev)->iopmp_as),
> +            (StreamSink *)&(IOPMP(iopmp_dev)->transaction_info_sink), 0);
> +        if (s->have_iopmp_cascade) {
> +            DeviceState *iopmp_dev2 = iopmp_create(memmap[VIRT_IOPMP2].base,
> +                qdev_get_gpio_in(DEVICE(mmio_irqchip), IOPMP2_IRQ));
> +            cascade_iopmp(iopmp_dev, iopmp_dev2);
> +        }
> +    }
> +
> +

Extra blank line.

Everything else LGTM. Thanks,


Daniel

>       for (i = 0; i < ARRAY_SIZE(s->flash); i++) {
>           /* Map legacy -drive if=pflash to machine properties */
>           pflash_cfi01_legacy_drive(s->flash[i],
> @@ -1628,6 +1653,35 @@ static void virt_set_aclint(Object *obj, bool value, Error **errp)
>       s->have_aclint = value;
>   }
>   
> +static bool virt_get_iopmp(Object *obj, Error **errp)
> +{
> +    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
> +
> +    return s->have_iopmp;
> +}
> +
> +static void virt_set_iopmp(Object *obj, bool value, Error **errp)
> +{
> +    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
> +
> +    s->have_iopmp = value;
> +}
> +
> +static bool virt_get_iopmp_cascade(Object *obj, Error **errp)
> +{
> +    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
> +
> +    return s->have_iopmp_cascade;
> +}
> +
> +static void virt_set_iopmp_cascade(Object *obj, bool value, Error **errp)
> +{
> +    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
> +
> +    s->have_iopmp_cascade = value;
> +}
> +
> +
>   bool virt_is_acpi_enabled(RISCVVirtState *s)
>   {
>       return s->acpi != ON_OFF_AUTO_OFF;
> @@ -1730,6 +1784,20 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>                                 NULL, NULL);
>       object_class_property_set_description(oc, "acpi",
>                                             "Enable ACPI");
> +
> +    object_class_property_add_bool(oc, "iopmp", virt_get_iopmp,
> +                                   virt_set_iopmp);
> +    object_class_property_set_description(oc, "iopmp",
> +                                          "Set on/off to enable/disable "
> +                                          "iopmp device");
> +
> +    object_class_property_add_bool(oc, "iopmp-cascade",
> +                                   virt_get_iopmp_cascade,
> +                                   virt_set_iopmp_cascade);
> +    object_class_property_set_description(oc, "iopmp-cascade",
> +                                          "Set on/off to enable/disable "
> +                                          "iopmp2 device which is cascaded by "
> +                                          "iopmp1 device");
>   }
>   
>   static const TypeInfo virt_machine_typeinfo = {
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index e5c474b26e..5fa2944d29 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -54,6 +54,8 @@ struct RISCVVirtState {
>   
>       int fdt_size;
>       bool have_aclint;
> +    bool have_iopmp;
> +    bool have_iopmp_cascade;
>       RISCVVirtAIAType aia_type;
>       int aia_guests;
>       char *oem_id;
> @@ -82,12 +84,18 @@ enum {
>       VIRT_PCIE_MMIO,
>       VIRT_PCIE_PIO,
>       VIRT_PLATFORM_BUS,
> -    VIRT_PCIE_ECAM
> +    VIRT_PCIE_ECAM,
> +    VIRT_IOPMP,
> +    VIRT_IOPMP2,
> +    VIRT_DMAC,
>   };
>   
>   enum {
>       UART0_IRQ = 10,
>       RTC_IRQ = 11,
> +    DMAC_IRQ = 12,
> +    IOPMP_IRQ = 13,
> +    IOPMP2_IRQ = 14,
>       VIRTIO_IRQ = 1, /* 1 to 8 */
>       VIRTIO_COUNT = 8,
>       PCIE_IRQ = 0x20, /* 32 to 35 */

