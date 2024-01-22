Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1808835D86
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 10:03:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRqBy-0006D2-UV; Mon, 22 Jan 2024 04:02:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rRqBq-0006C8-3I
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 04:01:59 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rRqBo-0001iO-1M
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 04:01:57 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40e7e2e04f0so32769735e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 01:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705914114; x=1706518914; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nbIGC8VZOkXEyDqY3vWBHqXPELJWNVJ0VIJNL+ZjFxg=;
 b=laEojdLGyDTKuT5Z6m0U+faGdmGoDFdvbSNHVbfA1GX0ChmeuGjL6IWv8JL1OXCQIp
 ZkkOduqnAAGQ8fvNcBD/fZkf4+C4q62MNeJ4OflAnxbuebEKK/TGAUxN5UZasXKAflG9
 9lPIqMpcCaTySQuoxvUjmJJn+TjfEadTCU/X5YBpDVVJlUJeoKUWOiLujHWc0Rmu65+f
 qJqdyLMw3H9QlnehGcv92ATn/5jexfKHyDr6/GaPeqB0EleJcmuJYjGMyTl1TTc6Cr+m
 G12sd4EFjhX55mkzLeYsR0Wm4aFWaNL9yfXvVuS1dY8/8DC+VEPGE3ANDLlQyVIERQLa
 FNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705914114; x=1706518914;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nbIGC8VZOkXEyDqY3vWBHqXPELJWNVJ0VIJNL+ZjFxg=;
 b=EciQLoeEDCJE0IDW2Ix2gPaTq1ZTo+gAVirwh7lnEZMIeP4pO7mrOyiAWXG4qnKa/9
 LGta0jlHYifawsAbvMrVQlZsutBD19PztJbO3jpvrw0k5EZFH7yE1GeV0VAekt4DkCO7
 WNIxS0uaWGsOV4iGucsBxsZmD1x6Ue4jeQo4VQAHER+k4s/Cn5H+cXeWZHEUrvDtLBY4
 +fncfgLy/uhUuL4z7cNYmkbG8Z8fLkszZtzQltiHWlGSkICuE+JUV2VYbos3Rr3v/sD0
 dtpRAI2ATfErTVzL+PCYoZRXIVjFgkBrl26DgBRchwmu3qAaax9Wx1U+ECOy+HTE3/2O
 rQkg==
X-Gm-Message-State: AOJu0YyETMHqq4CuorInk2fkjXbn3H1M7Cf7YSJ8bTZ4HEH0hi6zSaHD
 Wm4nZBimRzSSPO/BqLmji89gPm99s2ijn9y/CpmGhy1bPIkHeZ/CE5sTeoEA9aU=
X-Google-Smtp-Source: AGHT+IFiWp85hfRQnRipI8TCQGanj/35962p/1WKiWnaYqquYty6WaRkheQkGEcXP9R6JlWGqLgF2A==
X-Received: by 2002:a05:600c:248b:b0:40e:6939:c483 with SMTP id
 11-20020a05600c248b00b0040e6939c483mr2026650wms.83.1705914114169; 
 Mon, 22 Jan 2024 01:01:54 -0800 (PST)
Received: from [192.168.2.4] (tmo-082-165.customers.d1-online.com.
 [80.187.82.165]) by smtp.gmail.com with ESMTPSA id
 hg14-20020a05600c538e00b0040e5cf9a6c7sm38530464wmb.13.2024.01.22.01.01.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 01:01:53 -0800 (PST)
Message-ID: <87cee76d-3190-4e5d-bdd4-0cc4733843a5@linaro.org>
Date: Mon, 22 Jan 2024 10:01:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] nubus: add nubus-virtio-mmio device
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org, elliotnunn@fastmail.com
References: <20240111102954.449462-1-mark.cave-ayland@ilande.co.uk>
 <20240111102954.449462-4-mark.cave-ayland@ilande.co.uk>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240111102954.449462-4-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Cc'ing Manos.

On 11/1/24 11:29, Mark Cave-Ayland wrote:
> The nubus-virtio-mmio device is a Nubus card that contains a set of 32 virtio-mmio
> devices and a goldfish PIC similar to the m68k virt machine that can be plugged
> into the m68k q800 machine.
> 
> There are currently a number of drivers under development that can be used in
> conjunction with this device to provide accelerated and/or additional hypervisor
> services to 68k Classic MacOS.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/nubus/meson.build                 |   1 +
>   hw/nubus/nubus-virtio-mmio.c         | 102 +++++++++++++++++++++++++++
>   include/hw/nubus/nubus-virtio-mmio.h |  36 ++++++++++
>   3 files changed, 139 insertions(+)
>   create mode 100644 hw/nubus/nubus-virtio-mmio.c
>   create mode 100644 include/hw/nubus/nubus-virtio-mmio.h
> 
> diff --git a/hw/nubus/meson.build b/hw/nubus/meson.build
> index e7ebda8993..9a7a12ea68 100644
> --- a/hw/nubus/meson.build
> +++ b/hw/nubus/meson.build
> @@ -2,6 +2,7 @@ nubus_ss = ss.source_set()
>   nubus_ss.add(files('nubus-device.c'))
>   nubus_ss.add(files('nubus-bus.c'))
>   nubus_ss.add(files('nubus-bridge.c'))
> +nubus_ss.add(files('nubus-virtio-mmio.c'))
>   nubus_ss.add(when: 'CONFIG_Q800', if_true: files('mac-nubus-bridge.c'))
>   
>   system_ss.add_all(when: 'CONFIG_NUBUS', if_true: nubus_ss)
> diff --git a/hw/nubus/nubus-virtio-mmio.c b/hw/nubus/nubus-virtio-mmio.c
> new file mode 100644
> index 0000000000..58a63c84d0
> --- /dev/null
> +++ b/hw/nubus/nubus-virtio-mmio.c
> @@ -0,0 +1,102 @@
> +/*
> + * QEMU Macintosh Nubus Virtio MMIO card
> + *
> + * Copyright (c) 2024 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/nubus/nubus-virtio-mmio.h"
> +
> +
> +#define NUBUS_VIRTIO_MMIO_PIC_OFFSET   0
> +#define NUBUS_VIRTIO_MMIO_DEV_OFFSET   0x200
> +
> +
> +static void nubus_virtio_mmio_set_input_irq(void *opaque, int n, int level)
> +{
> +    NubusDevice *nd = NUBUS_DEVICE(opaque);
> +
> +    nubus_set_irq(nd, level);
> +}
> +
> +static void nubus_virtio_mmio_realize(DeviceState *dev, Error **errp)
> +{
> +    NubusVirtioMMIODeviceClass *nvmdc = NUBUS_VIRTIO_MMIO_GET_CLASS(dev);
> +    NubusVirtioMMIO *s = NUBUS_VIRTIO_MMIO(dev);
> +    NubusDevice *nd = NUBUS_DEVICE(dev);
> +    SysBusDevice *sbd;
> +    int i, offset;
> +
> +    nvmdc->parent_realize(dev, errp);
> +    if (*errp) {
> +        return;
> +    }
> +
> +    /* Goldfish PIC */
> +    sbd = SYS_BUS_DEVICE(&s->pic);
> +    if (!sysbus_realize(sbd, errp)) {
> +        return;
> +    }
> +    memory_region_add_subregion(&nd->slot_mem, NUBUS_VIRTIO_MMIO_PIC_OFFSET,
> +                                sysbus_mmio_get_region(sbd, 0));
> +    sysbus_connect_irq(sbd, 0,
> +                       qdev_get_gpio_in_named(dev, "pic-input-irq", 0));
> +
> +    /* virtio-mmio devices */
> +    offset = NUBUS_VIRTIO_MMIO_DEV_OFFSET;
> +    for (i = 0; i < NUBUS_VIRTIO_MMIO_NUM_DEVICES; i++) {
> +        sbd = SYS_BUS_DEVICE(&s->virtio_mmio[i]);
> +        qdev_prop_set_bit(DEVICE(sbd), "force-legacy", false);
> +        if (!sysbus_realize_and_unref(sbd, errp)) {
> +            return;
> +        }
> +
> +        memory_region_add_subregion(&nd->slot_mem, offset,
> +                                    sysbus_mmio_get_region(sbd, 0));
> +        offset += 0x200;
> +
> +        sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(DEVICE(&s->pic), i));
> +    }
> +}
> +
> +static void nubus_virtio_mmio_init(Object *obj)
> +{
> +    NubusVirtioMMIO *s = NUBUS_VIRTIO_MMIO(obj);
> +    int i;
> +
> +    object_initialize_child(obj, "pic", &s->pic, TYPE_GOLDFISH_PIC);
> +    for (i = 0; i < NUBUS_VIRTIO_MMIO_NUM_DEVICES; i++) {
> +        char *name = g_strdup_printf("virtio-mmio[%d]", i);
> +        object_initialize_child(obj, name, &s->virtio_mmio[i],
> +                                TYPE_VIRTIO_MMIO);
> +        g_free(name);
> +    }
> +
> +    /* Input from goldfish PIC */
> +    qdev_init_gpio_in_named(DEVICE(obj), nubus_virtio_mmio_set_input_irq,
> +                            "pic-input-irq", 1);
> +}
> +
> +static void nubus_virtio_mmio_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    NubusVirtioMMIODeviceClass *nvmdc = NUBUS_VIRTIO_MMIO_CLASS(oc);
> +
> +    device_class_set_parent_realize(dc, nubus_virtio_mmio_realize,
> +                                    &nvmdc->parent_realize);
> +}
> +
> +static const TypeInfo nubus_virtio_mmio_types[] = {
> +    {
> +        .name = TYPE_NUBUS_VIRTIO_MMIO,
> +        .parent = TYPE_NUBUS_DEVICE,
> +        .instance_init = nubus_virtio_mmio_init,
> +        .instance_size = sizeof(NubusVirtioMMIO),
> +        .class_init = nubus_virtio_mmio_class_init,
> +        .class_size = sizeof(NubusVirtioMMIODeviceClass),
> +    },
> +};
> +
> +DEFINE_TYPES(nubus_virtio_mmio_types)
> diff --git a/include/hw/nubus/nubus-virtio-mmio.h b/include/hw/nubus/nubus-virtio-mmio.h
> new file mode 100644
> index 0000000000..de497b7f76
> --- /dev/null
> +++ b/include/hw/nubus/nubus-virtio-mmio.h
> @@ -0,0 +1,36 @@
> +/*
> + * QEMU Macintosh Nubus Virtio MMIO card
> + *
> + * Copyright (c) 2023 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_NUBUS_VIRTIO_MMIO_H
> +#define HW_NUBUS_VIRTIO_MMIO_H
> +
> +#include "hw/nubus/nubus.h"
> +#include "qom/object.h"
> +#include "hw/intc/goldfish_pic.h"
> +#include "hw/virtio/virtio-mmio.h"
> +
> +#define TYPE_NUBUS_VIRTIO_MMIO "nubus-virtio-mmio"
> +OBJECT_DECLARE_TYPE(NubusVirtioMMIO, NubusVirtioMMIODeviceClass,
> +                    NUBUS_VIRTIO_MMIO)
> +
> +struct NubusVirtioMMIODeviceClass {
> +    DeviceClass parent_class;
> +
> +    DeviceRealize parent_realize;
> +};
> +
> +#define NUBUS_VIRTIO_MMIO_NUM_DEVICES 32
> +
> +struct NubusVirtioMMIO {
> +    NubusDevice parent_obj;
> +
> +    GoldfishPICState pic;
> +    VirtIOMMIOProxy virtio_mmio[NUBUS_VIRTIO_MMIO_NUM_DEVICES];
> +};
> +
> +#endif


