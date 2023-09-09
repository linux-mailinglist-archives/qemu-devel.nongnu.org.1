Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1037996EB
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 10:39:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qetTe-0008Ct-3j; Sat, 09 Sep 2023 04:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SY1+=EZ=kaod.org=clg@ozlabs.org>)
 id 1qetTc-0008Ce-1N; Sat, 09 Sep 2023 04:38:00 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SY1+=EZ=kaod.org=clg@ozlabs.org>)
 id 1qetTY-0000dE-SE; Sat, 09 Sep 2023 04:37:59 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RjRFC2Vdfz4x5q;
 Sat,  9 Sep 2023 18:37:51 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RjRF70KtXz4x4T;
 Sat,  9 Sep 2023 18:37:46 +1000 (AEST)
Message-ID: <7f5e6677-4601-8a9a-77b5-5aad535e453b@kaod.org>
Date: Sat, 9 Sep 2023 10:37:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 02/10] hw/fsi: Introduce IBM's scratchpad
Content-Language: en-US
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@aj.id.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org
References: <20230908222859.3381003-1-ninad@linux.ibm.com>
 <20230908222859.3381003-3-ninad@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230908222859.3381003-3-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=SY1+=EZ=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

On 9/9/23 00:28, Ninad Palsule wrote:
> This is a part of patchset where IBM's Flexible Service Interface is
> introduced.
> 
> The LBUS device is embeded inside the scratchpad. The scratchpad

embedded

> provides a non-functional registers. There is a 1-1 relation between
> scratchpad and LBUS devices. Each LBUS device has 1K memory mapped in
> the LBUS.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
> v2:
> - Incorporated Joel's review comments.
> ---
>   hw/fsi/Kconfig                     |   4 ++
>   hw/fsi/engine-scratchpad.c         | 100 +++++++++++++++++++++++++++++
>   hw/fsi/meson.build                 |   1 +
>   include/hw/fsi/engine-scratchpad.h |  33 ++++++++++
>   4 files changed, 138 insertions(+)
>   create mode 100644 hw/fsi/engine-scratchpad.c
>   create mode 100644 include/hw/fsi/engine-scratchpad.h
> 
> diff --git a/hw/fsi/Kconfig b/hw/fsi/Kconfig
> index 687449e14e..2a9c49f2c9 100644
> --- a/hw/fsi/Kconfig
> +++ b/hw/fsi/Kconfig
> @@ -1,2 +1,6 @@
> +config SCRATCHPAD
> +    bool
> +    select LBUS
> +
>   config LBUS
>       bool
> diff --git a/hw/fsi/engine-scratchpad.c b/hw/fsi/engine-scratchpad.c
> new file mode 100644
> index 0000000000..15a8f8cc66
> --- /dev/null
> +++ b/hw/fsi/engine-scratchpad.c
> @@ -0,0 +1,100 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM scratchpad engine
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +
> +#include "hw/fsi/engine-scratchpad.h"
> +
> +static uint64_t scratchpad_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    ScratchPad *s = SCRATCHPAD(opaque);
> +
> +    qemu_log_mask(LOG_UNIMP, "%s: read @0x%" HWADDR_PRIx " size=%d\n",
> +                  __func__, addr, size);

This should be a trace event. The comment applies to all similar usage.

> +
> +    if (addr) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out of bounds read: 0x%"HWADDR_PRIx" for %u\n",
> +                      __func__, addr, size);
> +        return 0;

if the MMIO region is correctly sized, this should not be necessary. Do
you plans to add support for registers ?

> +    }
> +
> +    return s->reg;
> +}
> +
> +static void scratchpad_write(void *opaque, hwaddr addr, uint64_t data,
> +                                 unsigned size)
> +{
> +    ScratchPad *s = SCRATCHPAD(opaque);
> +
> +    qemu_log_mask(LOG_UNIMP, "%s: write @0x%" HWADDR_PRIx " size=%d "
> +                  "value=%"PRIx64"\n", __func__, addr, size, data);

trace event

> +
> +    if (addr) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out of bounds write: 0x%"HWADDR_PRIx" for %u\n",
> +                      __func__, addr, size);
> +        return;
> +    }
> +
> +    s->reg = data;
> +}
> +
> +static const struct MemoryRegionOps scratchpad_ops = {
> +    .read = scratchpad_read,
> +    .write = scratchpad_write,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +};
> +
> +static void scratchpad_realize(DeviceState *dev, Error **errp)
> +{
> +    LBusDevice *ldev = LBUS_DEVICE(dev);
> +
> +    memory_region_init_io(&ldev->iomem, OBJECT(ldev), &scratchpad_ops,
> +                          ldev, TYPE_SCRATCHPAD, 0x400);
> +}
> +
> +static void scratchpad_reset(DeviceState *dev)
> +{
> +    ScratchPad *s = SCRATCHPAD(dev);
> +
> +    s->reg = 0;
> +}
> +
> +static void scratchpad_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    LBusDeviceClass *ldc = LBUS_DEVICE_CLASS(klass);
> +
> +    dc->realize = scratchpad_realize;
> +    dc->reset = scratchpad_reset;
> +
> +    ldc->config =
> +          ENGINE_CONFIG_NEXT            /* valid */
> +        | 0x00010000                    /* slots */
> +        | 0x00001000                    /* version */
> +        | ENGINE_CONFIG_TYPE_SCRATCHPAD /* type */
> +        | 0x00000007;                   /* crc */

where is ->config used ?


> +}
> +
> +static const TypeInfo scratchpad_info = {
> +    .name = TYPE_SCRATCHPAD,
> +    .parent = TYPE_LBUS_DEVICE,
> +    .instance_size = sizeof(ScratchPad),
> +    .class_init = scratchpad_class_init,
> +    .class_size = sizeof(LBusDeviceClass),
> +};
> +
> +static void scratchpad_register_types(void)
> +{
> +    type_register_static(&scratchpad_info);
> +}
> +
> +type_init(scratchpad_register_types);
> diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
> index e1007d5fea..f90e09ddab 100644
> --- a/hw/fsi/meson.build
> +++ b/hw/fsi/meson.build
> @@ -1 +1,2 @@
>   system_ss.add(when: 'CONFIG_LBUS', if_true: files('lbus.c'))
> +system_ss.add(when: 'CONFIG_SCRATCHPAD', if_true: files('engine-scratchpad.c'))
> diff --git a/include/hw/fsi/engine-scratchpad.h b/include/hw/fsi/engine-scratchpad.h
> new file mode 100644
> index 0000000000..63bf89ac5a
> --- /dev/null
> +++ b/include/hw/fsi/engine-scratchpad.h
> @@ -0,0 +1,33 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM scratchpad engne
> + */
> +#ifndef FSI_ENGINE_SCRATCHPAD_H
> +#define FSI_ENGINE_SCRATCHPAD_H
> +
> +#include "qemu/bitops.h"
> +
> +#include "hw/fsi/lbus.h"
> +
> +#define ENGINE_CONFIG_NEXT              BE_BIT(0)
> +#define ENGINE_CONFIG_VPD               BE_BIT(1)
> +#define ENGINE_CONFIG_SLOTS             BE_GENMASK(8, 15)
> +#define ENGINE_CONFIG_VERSION           BE_GENMASK(16, 19)
> +#define ENGINE_CONFIG_TYPE              BE_GENMASK(20, 27)
> +#define   ENGINE_CONFIG_TYPE_PEEK       (0x02 << 4)
> +#define   ENGINE_CONFIG_TYPE_FSI        (0x03 << 4)
> +#define   ENGINE_CONFIG_TYPE_SCRATCHPAD (0x06 << 4)
> +#define ENGINE_CONFIG_CRC              BE_GENMASK(28, 31)
> +
> +#define TYPE_SCRATCHPAD "scratchpad"
> +#define SCRATCHPAD(obj) OBJECT_CHECK(ScratchPad, (obj), TYPE_SCRATCHPAD)
> +
> +typedef struct ScratchPad {
> +        LBusDevice parent;
> +
> +        uint32_t reg;
> +} ScratchPad;
> +
> +#endif /* FSI_ENGINE_SCRATCHPAD_H */


