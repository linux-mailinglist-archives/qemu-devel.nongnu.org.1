Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A9376FFFE
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 14:12:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRtec-0006j1-BG; Fri, 04 Aug 2023 08:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRteY-0006iB-Fu
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 08:11:34 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRteV-0003eV-K7
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 08:11:33 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-523225dd110so195566a12.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 05:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691151089; x=1691755889;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y+Hv8BQzh4Qs4BvB0g70cY4FhUBuz2y/muRQNDegEyg=;
 b=RMBP2/cTO2MSckCH71oWmoDZQM79td7Ireayn8dTbjrfBA+7DSs4P2XudZvKaerZCO
 ewIj6RKwvqQvITJfhthE1JcBfFxrjQzwg8uhSjzz56phLiy+oWMvhqeAcN708YjDqL7p
 qR2NtUeOhw3Y7kGlVBuftfRTec34G/9J1capE0G9JpWZL43viDacQdkHPJNw/WhGA+8O
 8yym2lnNHR5P0Hac8r1UUAjae8pqk44pl2D+s3ufG7lV2ncBe9STb8pzFABsUxl64Zio
 tlxYpOetghbaXPjixMI58eT+0SjPDRXg3bIRjVft5iIgDmutux/wMpuzX68lIp6LzTLq
 HDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691151089; x=1691755889;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y+Hv8BQzh4Qs4BvB0g70cY4FhUBuz2y/muRQNDegEyg=;
 b=fuAE6N0wywWspf+AxrsWbE3wYQTQi+Hr3oV0TJQ/T5veP8uN3oY2IbWEQnM2pcNSmd
 SiFME/0jjgnFz/He3HXks+lMNtCxvBSF9coGhQg//PJoNOGwrzYH3LrVyxupnANYMTtl
 0fDaejeWdBnFZ3A1zKA3DCY9iVHz5iRTLX03mbFp8Ly9PHPkU8vuPTFJ8eGa34m97mwp
 P0bfuGB2ltAXJmGx8rRRDaDxNcfo7DQgM9D4uoyV9wczRYeBb4AbslHmYKQIUSWIZTGz
 5pcNtNu7Qz/9jmp1kFZEaaycytDN6fKJ2++2oCbs+qUkGwbFduOh07Z/RjSMMrDxh/CS
 iWug==
X-Gm-Message-State: AOJu0YwQnJRaO2so4S2+tTx3Emp+xsndmWvxfZ+tH9CxXU+vmqTHqOR8
 EFcClOqF2DQ8Lu2Z3MOgFCEhOrlmRzfm4DW+0XsjFA==
X-Google-Smtp-Source: AGHT+IEDnakX1rHeD4ZCZKzttYkdYhZL8qEkLPG1+ks0sBp9VbARMEUtCR+/GttQFu4Xbky9g+opY0wyB/GQjxCRW30=
X-Received: by 2002:a05:6402:110c:b0:523:1465:8876 with SMTP id
 u12-20020a056402110c00b0052314658876mr1439593edv.14.1691151089523; Fri, 04
 Aug 2023 05:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20230726132512.149618-7-sergey.kambalin@auriga.com>
In-Reply-To: <20230726132512.149618-7-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 13:11:18 +0100
Message-ID: <CAFEAcA-b8z09mRCH5ZarvSng7sCXyVqEyoF5VvHiscfcr6H72A@mail.gmail.com>
Subject: Re: [PATCH 06/44] Add BCM2838 GPIO stub
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Wed, 26 Jul 2023 at 15:29, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/gpio/bcm2838_gpio.c         | 136 +++++++++++++++++++++++++++++++++
>  hw/gpio/meson.build            |   5 +-
>  include/hw/gpio/bcm2838_gpio.h |  39 ++++++++++
>  3 files changed, 179 insertions(+), 1 deletion(-)
>  create mode 100644 hw/gpio/bcm2838_gpio.c
>  create mode 100644 include/hw/gpio/bcm2838_gpio.h
>
> diff --git a/hw/gpio/bcm2838_gpio.c b/hw/gpio/bcm2838_gpio.c
> new file mode 100644
> index 0000000000..59be608250
> --- /dev/null
> +++ b/hw/gpio/bcm2838_gpio.c
> @@ -0,0 +1,136 @@
> +/*
> + * Raspberry Pi (BCM2838) GPIO Controller
> + * This implementation is based on bcm2835_gpio (hw/gpio/bcm2835_gpio.c)
> + *
> + * Copyright (c) 2022 Auriga LLC
> + *
> + * Authors:
> + *  Lotosh, Aleksey <aleksey.lotosh@auriga.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qemu/timer.h"
> +#include "qapi/error.h"
> +#include "hw/sysbus.h"
> +#include "hw/gpio/bcm2838_gpio.h"
> +
> +#define GPFSEL0   0x00
> +#define GPFSEL1   0x04
> +#define GPFSEL2   0x08
> +#define GPFSEL3   0x0C
> +#define GPFSEL4   0x10
> +#define GPFSEL5   0x14
> +#define GPSET0    0x1C
> +#define GPSET1    0x20
> +#define GPCLR0    0x28
> +#define GPCLR1    0x2C
> +#define GPLEV0    0x34
> +#define GPLEV1    0x38
> +#define GPEDS0    0x40
> +#define GPEDS1    0x44
> +#define GPREN0    0x4C
> +#define GPREN1    0x50
> +#define GPFEN0    0x58
> +#define GPFEN1    0x5C
> +#define GPHEN0    0x64
> +#define GPHEN1    0x68
> +#define GPLEN0    0x70
> +#define GPLEN1    0x74
> +#define GPAREN0   0x7C
> +#define GPAREN1   0x80
> +#define GPAFEN0   0x88
> +#define GPAFEN1   0x8C
> +
> +#define GPIO_PUP_PDN_CNTRL_REG0 0xE4
> +#define GPIO_PUP_PDN_CNTRL_REG1 0xE8
> +#define GPIO_PUP_PDN_CNTRL_REG2 0xEC
> +#define GPIO_PUP_PDN_CNTRL_REG3 0xF0
> +
> +#define RESET_VAL_CNTRL_REG0 0xAAA95555;
> +#define RESET_VAL_CNTRL_REG1 0xA0AAAAAA;
> +#define RESET_VAL_CNTRL_REG2 0x50AAA95A;
> +#define RESET_VAL_CNTRL_REG3 0x00055555;
> +
> +#define BYTES_IN_WORD        4
> +
> +static uint64_t bcm2838_gpio_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    uint64_t value = 0;
> +
> +    qemu_log_mask(LOG_UNIMP, "%s: %s: not implemented for %"HWADDR_PRIx"\n",
> +                    TYPE_BCM2838_GPIO, __func__, offset);

Indentation is a bit off here -- usual QEMU standard is that on
subsequent lines, the first character of the argument lines
up with the first character of the argument on line 1, like this:


    qemu_log_mask(LOG_UNIMP, "%s: %s: not implemented for %"HWADDR_PRIx"\n",
                  TYPE_BCM2838_GPIO, __func__, offset);

> +
> +    return value;
> +}
> +
> +static void bcm2838_gpio_write(void *opaque, hwaddr offset, uint64_t value,
> +                               unsigned size)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s: %s: not implemented for %"HWADDR_PRIx"\n",
> +                    TYPE_BCM2838_GPIO, __func__, offset);
> +}
> +
> +static void bcm2838_gpio_reset(DeviceState *dev)
> +{
> +    BCM2838GpioState *s = BCM2838_GPIO(dev);
> +
> +    s->lev0 = 0;
> +    s->lev1 = 0;
> +
> +    s->pup_cntrl_reg[0] = RESET_VAL_CNTRL_REG0;
> +    s->pup_cntrl_reg[1] = RESET_VAL_CNTRL_REG1;
> +    s->pup_cntrl_reg[2] = RESET_VAL_CNTRL_REG2;
> +    s->pup_cntrl_reg[3] = RESET_VAL_CNTRL_REG3;
> +}
> +
> +static const MemoryRegionOps bcm2838_gpio_ops = {
> +    .read = bcm2838_gpio_read,
> +    .write = bcm2838_gpio_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static void bcm2838_gpio_init(Object *obj)
> +{
> +    BCM2838GpioState *s = BCM2838_GPIO(obj);
> +    DeviceState *dev = DEVICE(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +
> +    memory_region_init_io(
> +        &s->iomem, obj,
> +        &bcm2838_gpio_ops, s, "bcm2838_gpio", BCM2838_GPIO_REGS_SIZE);

Indentation is weird here too.

> +    sysbus_init_mmio(sbd, &s->iomem);
> +    qdev_init_gpio_out(dev, s->out, BCM2838_GPIO_NUM);
> +}
> +
> +static void bcm2838_gpio_realize(DeviceState *dev, Error **errp)
> +{
> +    /* Temporary stub. Do nothing */
> +}
> +
> +static void bcm2838_gpio_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = &bcm2838_gpio_realize;
> +    dc->reset = &bcm2838_gpio_reset;

You also need a vmstate struct, for migration and vmsave/load.

> +}
> +
> +static const TypeInfo bcm2838_gpio_info = {
> +    .name          = TYPE_BCM2838_GPIO,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(BCM2838GpioState),
> +    .instance_init = bcm2838_gpio_init,
> +    .class_init    = bcm2838_gpio_class_init,
> +};
> +
> +static void bcm2838_gpio_register_types(void)
> +{
> +    type_register_static(&bcm2838_gpio_info);
> +}

thanks
-- PMM

