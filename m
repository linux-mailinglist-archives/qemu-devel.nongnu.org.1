Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1416F7FA5C0
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 17:10:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7eB9-0005kh-Fb; Mon, 27 Nov 2023 11:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5Qwu=HI=kaod.org=clg@ozlabs.org>)
 id 1r7eB7-0005kE-Vo; Mon, 27 Nov 2023 11:09:45 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5Qwu=HI=kaod.org=clg@ozlabs.org>)
 id 1r7eB5-000297-KI; Mon, 27 Nov 2023 11:09:45 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Sf9X26Tlvz4xNG;
 Tue, 28 Nov 2023 03:09:38 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sf9Wx4Th9z4wb0;
 Tue, 28 Nov 2023 03:09:33 +1100 (AEDT)
Message-ID: <edf7f3f9-c758-40a0-bcdc-d1f2607cbdbc@kaod.org>
Date: Mon, 27 Nov 2023 17:09:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/10] hw/fsi: Introduce IBM's scratchpad
Content-Language: en-US
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20231026164741.1184058-1-ninad@linux.ibm.com>
 <20231026164741.1184058-3-ninad@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231026164741.1184058-3-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=5Qwu=HI=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 10/26/23 18:47, Ninad Palsule wrote:
> This is a part of patchset where scratchpad is introduced.
> 
> The scratchpad provides a set of non-functional registers. The firmware
> is free to use them, hardware does not support any special management
> support. The scratchpad registers can be read or written from LBUS
> slave.
> 
> In this model, The LBUS device is parent for the scratchpad.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
> v2:
> - Incorporated Joel's review comments.
> v5:
> - Incorporated review comments by Cedric.
> v6:
> - Incorporated review comments by Daniel.
> v7:
> - Incorporated review comments by Philippe.
> - Cleaned up unused bits.
> ---
>   meson.build                        |  1 +
>   hw/fsi/trace.h                     |  1 +
>   include/hw/fsi/engine-scratchpad.h | 27 +++++++++
>   include/hw/fsi/fsi.h               | 16 +++++
>   hw/fsi/engine-scratchpad.c         | 93 ++++++++++++++++++++++++++++++
>   hw/fsi/Kconfig                     |  4 ++
>   hw/fsi/meson.build                 |  1 +
>   hw/fsi/trace-events                |  2 +
>   8 files changed, 145 insertions(+)
>   create mode 100644 hw/fsi/trace.h
>   create mode 100644 include/hw/fsi/engine-scratchpad.h
>   create mode 100644 include/hw/fsi/fsi.h
>   create mode 100644 hw/fsi/engine-scratchpad.c
>   create mode 100644 hw/fsi/trace-events
> 
> diff --git a/meson.build b/meson.build
> index dcef8b1e79..793c7c1f20 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3257,6 +3257,7 @@ if have_system
>       'hw/char',
>       'hw/display',
>       'hw/dma',
> +    'hw/fsi',

This should be introduced in the first patch.

>       'hw/hyperv',
>       'hw/i2c',
>       'hw/i386',
> diff --git a/hw/fsi/trace.h b/hw/fsi/trace.h
> new file mode 100644
> index 0000000000..ee67c7fb04
> --- /dev/null
> +++ b/hw/fsi/trace.h
> @@ -0,0 +1 @@
> +#include "trace/trace-hw_fsi.h"
> diff --git a/include/hw/fsi/engine-scratchpad.h b/include/hw/fsi/engine-scratchpad.h
> new file mode 100644
> index 0000000000..4ffa871965
> --- /dev/null
> +++ b/include/hw/fsi/engine-scratchpad.h

This model is introduced to early please drop from this patch.

> @@ -0,0 +1,27 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM scratchpad engne
> + */
> +#ifndef FSI_ENGINE_SCRATCHPAD_H
> +#define FSI_ENGINE_SCRATCHPAD_H
> +
> +#include "hw/fsi/lbus.h"
> +#include "hw/fsi/fsi.h"
> +
> +#define ENGINE_CONFIG_NEXT            BE_BIT(0)
> +#define ENGINE_CONFIG_TYPE_PEEK       (0x02 << 4)
> +#define ENGINE_CONFIG_TYPE_FSI        (0x03 << 4)
> +#define ENGINE_CONFIG_TYPE_SCRATCHPAD (0x06 << 4)
> +
> +#define TYPE_FSI_SCRATCHPAD "fsi.scratchpad"
> +#define SCRATCHPAD(obj) OBJECT_CHECK(FSIScratchPad, (obj), TYPE_FSI_SCRATCHPAD)
> +
> +typedef struct FSIScratchPad {
> +        FSILBusDevice parent;
> +
> +        uint32_t reg;
> +} FSIScratchPad;
> +
> +#endif /* FSI_ENGINE_SCRATCHPAD_H */
> diff --git a/include/hw/fsi/fsi.h b/include/hw/fsi/fsi.h
> new file mode 100644
> index 0000000000..b08b97f62b
> --- /dev/null
> +++ b/include/hw/fsi/fsi.h
> @@ -0,0 +1,16 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM Flexible Service Interface
> + */
> +#ifndef FSI_FSI_H
> +#define FSI_FSI_H
> +
> +#include "qemu/bitops.h"
> +
> +/* Bitwise operations at the word level. */
> +#define BE_BIT(x)           BIT(31 - (x))

31 ? BITS_PER_LONG would be better I think.

> +#define BE_GENMASK(hb, lb)  MAKE_64BIT_MASK((lb), ((hb) - (lb) + 1))
> +
> +#endif
> diff --git a/hw/fsi/engine-scratchpad.c b/hw/fsi/engine-scratchpad.c
> new file mode 100644
> index 0000000000..a8887cd613
> --- /dev/null
> +++ b/hw/fsi/engine-scratchpad.c

DRop FSIScratchPad from this patch. It should be introduced later.

However, TYPE_FSI_BUS should be introcuded now because the following
patch needs it.


> @@ -0,0 +1,93 @@
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
> +#include "trace.h"
> +
> +#include "hw/fsi/engine-scratchpad.h"
> +
> +static uint64_t fsi_scratchpad_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    FSIScratchPad *s = SCRATCHPAD(opaque);
> +
> +    trace_fsi_scratchpad_read(addr, size);
> +
> +    if (addr) {
> +        return 0;
> +    }
> +
> +    return s->reg;
> +}
> +
> +static void fsi_scratchpad_write(void *opaque, hwaddr addr, uint64_t data,
> +                                 unsigned size)
> +{
> +    FSIScratchPad *s = SCRATCHPAD(opaque);
> +
> +    trace_fsi_scratchpad_write(addr, size, data);
> +
> +    if (addr) {
> +        return;
> +    }
> +
> +    s->reg = data;
> +}
> +
> +static const struct MemoryRegionOps scratchpad_ops = {
> +    .read = fsi_scratchpad_read,
> +    .write = fsi_scratchpad_write,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +};
> +
> +static void fsi_scratchpad_realize(DeviceState *dev, Error **errp)
> +{
> +    FSILBusDevice *ldev = FSI_LBUS_DEVICE(dev);
> +
> +    memory_region_init_io(&ldev->iomem, OBJECT(ldev), &scratchpad_ops,
> +                          ldev, TYPE_FSI_SCRATCHPAD, 0x400);
> +}
> +
> +static void fsi_scratchpad_reset(DeviceState *dev)
> +{
> +    FSIScratchPad *s = SCRATCHPAD(dev);
> +
> +    s->reg = 0;
> +}
> +
> +static void fsi_scratchpad_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    FSILBusDeviceClass *ldc = FSI_LBUS_DEVICE_CLASS(klass);
> +
> +    dc->realize = fsi_scratchpad_realize;
> +    dc->reset = fsi_scratchpad_reset;
> +
> +    ldc->config =
> +          ENGINE_CONFIG_NEXT            | /* valid */
> +          0x00010000                    | /* slots */
> +          0x00001000                    | /* version */
> +          ENGINE_CONFIG_TYPE_SCRATCHPAD | /* type */
> +          0x00000007;                     /* crc */
> +}
> +
> +static const TypeInfo fsi_scratchpad_info = {
> +    .name = TYPE_FSI_SCRATCHPAD,
> +    .parent = TYPE_FSI_LBUS_DEVICE,
> +    .instance_size = sizeof(FSIScratchPad),
> +    .class_init = fsi_scratchpad_class_init,
> +    .class_size = sizeof(FSILBusDeviceClass),
> +};
> +
> +static void fsi_scratchpad_register_types(void)
> +{
> +    type_register_static(&fsi_scratchpad_info);
> +}
> +
> +type_init(fsi_scratchpad_register_types);
> diff --git a/hw/fsi/Kconfig b/hw/fsi/Kconfig
> index e650c660f0..f7c7fd1b28 100644
> --- a/hw/fsi/Kconfig
> +++ b/hw/fsi/Kconfig
> @@ -1,2 +1,6 @@
> +config FSI_SCRATCHPAD
> +    bool
> +    select FSI_LBUS
> +
>   config FSI_LBUS
>       bool


I am not sure we need all this config option. We will see that at the end
when the models are ready.


Thanks,

C.



> diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
> index 4074d3a7d2..d45a98c223 100644
> --- a/hw/fsi/meson.build
> +++ b/hw/fsi/meson.build
> @@ -1 +1,2 @@
>   system_ss.add(when: 'CONFIG_FSI_LBUS', if_true: files('lbus.c'))
> +system_ss.add(when: 'CONFIG_FSI_SCRATCHPAD', if_true: files('engine-scratchpad.c'))
> diff --git a/hw/fsi/trace-events b/hw/fsi/trace-events
> new file mode 100644
> index 0000000000..c5753e2791
> --- /dev/null
> +++ b/hw/fsi/trace-events
> @@ -0,0 +1,2 @@
> +fsi_scratchpad_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
> +fsi_scratchpad_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64


