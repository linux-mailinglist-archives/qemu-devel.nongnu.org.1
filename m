Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7FF7996DA
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 10:27:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qetI2-00011W-J0; Sat, 09 Sep 2023 04:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SY1+=EZ=kaod.org=clg@ozlabs.org>)
 id 1qetHz-00010e-V8; Sat, 09 Sep 2023 04:26:00 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SY1+=EZ=kaod.org=clg@ozlabs.org>)
 id 1qetHw-00073m-N0; Sat, 09 Sep 2023 04:25:59 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RjQz92shgz4x5r;
 Sat,  9 Sep 2023 18:25:41 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RjQz40k3rz4wy0;
 Sat,  9 Sep 2023 18:25:35 +1000 (AEST)
Message-ID: <e25d0310-72f0-8bb0-2538-dad86f407e01@kaod.org>
Date: Sat, 9 Sep 2023 10:25:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 01/10] hw/fsi: Introduce IBM's Local bus
Content-Language: en-US
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@aj.id.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org
References: <20230908222859.3381003-1-ninad@linux.ibm.com>
 <20230908222859.3381003-2-ninad@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230908222859.3381003-2-ninad@linux.ibm.com>
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
> The LBUS is modelled to maintain the qdev bus hierarchy and to take
> advantage of the object model to automatically generate the CFAM
> configuration block. The configuration block presents engines in the
> order they are attached to the CFAM's LBUS. Engine implementations
> should subclass the LBusDevice and set the 'config' member of
> LBusDeviceClass to match the engine's type.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
> v2:
> - Incorporated Joel's review comments.
> ---


It is nice to have the header files upfront.

   orderFile = /path/to/qemu/scripts/git.orderfile


>   hw/Kconfig            |  1 +
>   hw/fsi/Kconfig        |  2 +
>   hw/fsi/lbus.c         | 94 +++++++++++++++++++++++++++++++++++++++++++
>   hw/fsi/meson.build    |  1 +
>   hw/meson.build        |  1 +
>   include/hw/fsi/lbus.h | 48 ++++++++++++++++++++++
>   include/qemu/bitops.h |  6 +++
>   7 files changed, 153 insertions(+)
>   create mode 100644 hw/fsi/Kconfig
>   create mode 100644 hw/fsi/lbus.c
>   create mode 100644 hw/fsi/meson.build
>   create mode 100644 include/hw/fsi/lbus.h
> 
> diff --git a/hw/Kconfig b/hw/Kconfig
> index ba62ff6417..2ccb73add5 100644
> --- a/hw/Kconfig
> +++ b/hw/Kconfig
> @@ -9,6 +9,7 @@ source core/Kconfig
>   source cxl/Kconfig
>   source display/Kconfig
>   source dma/Kconfig
> +source fsi/Kconfig
>   source gpio/Kconfig
>   source hyperv/Kconfig
>   source i2c/Kconfig
> diff --git a/hw/fsi/Kconfig b/hw/fsi/Kconfig
> new file mode 100644
> index 0000000000..687449e14e
> --- /dev/null
> +++ b/hw/fsi/Kconfig
> @@ -0,0 +1,2 @@
> +config LBUS
> +    bool
> diff --git a/hw/fsi/lbus.c b/hw/fsi/lbus.c
> new file mode 100644
> index 0000000000..afb26ef7ea
> --- /dev/null
> +++ b/hw/fsi/lbus.c
> @@ -0,0 +1,94 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM Local bus where FSI slaves are connected
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +
> +#include "hw/fsi/lbus.h"
> +
> +#include "hw/qdev-properties.h"
> +
> +static void lbus_realize(BusState *bus, Error **errp)
> +{
> +    LBusNode *node;
> +    LBus *lbus = LBUS(bus);
> +
> +    memory_region_init(&lbus->mr, OBJECT(lbus), TYPE_LBUS,
> +                       (2 * 1024 * 1024) - 0x400);

please use some define

> +
> +    QLIST_FOREACH(node, &lbus->devices, next) {
> +        memory_region_add_subregion(&lbus->mr, node->ldev->address,
> +                                    &node->ldev->iomem);
> +    }
> +}
> +
> +static void lbus_init(Object *o)
> +{
> +}
> +

please remove if unused


> +static void lbus_class_init(ObjectClass *klass, void *data)
> +{
> +    BusClass *k = BUS_CLASS(klass);
> +    k->realize = lbus_realize;
> +}
> +
> +static const TypeInfo lbus_info = {
> +    .name = TYPE_LBUS,
> +    .parent = TYPE_BUS,
> +    .instance_init = lbus_init,
> +    .instance_size = sizeof(LBus),
> +    .class_init = lbus_class_init,
> +};
> +
> +static Property lbus_device_props[] = {
> +    DEFINE_PROP_UINT32("address", LBusDevice, address, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +DeviceState *lbus_create_device(LBus *bus, const char *type, uint32_t addr)
> +{
> +    DeviceState *dev;
> +    LBusNode *node;
> +
> +    dev = qdev_new(type);
> +    qdev_prop_set_uint8(dev, "address", addr);
> +    qdev_realize_and_unref(dev, &bus->bus, &error_fatal);

  BUS(bus) ?

> +
> +    /* Move to post_load */
> +    node = g_malloc(sizeof(struct LBusNode));
> +    node->ldev = LBUS_DEVICE(dev);
> +    QLIST_INSERT_HEAD(&bus->devices, node, next);

This list looks useless to me.

> +    return dev;
> +}
> +
> +static void lbus_device_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->bus_type = TYPE_LBUS;
> +    device_class_set_props(dc, lbus_device_props);
> +}
> +
> +static const TypeInfo lbus_device_type_info = {
> +    .name = TYPE_LBUS_DEVICE,
> +    .parent = TYPE_DEVICE,
> +    .instance_size = sizeof(LBusDevice),
> +    .abstract = true,
> +    .class_init = lbus_device_class_init,
> +    .class_size = sizeof(LBusDeviceClass),
> +};
> +
> +static void lbus_register_types(void)
> +{
> +    type_register_static(&lbus_info);
> +    type_register_static(&lbus_device_type_info);
> +}
> +
> +type_init(lbus_register_types);
> diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
> new file mode 100644
> index 0000000000..e1007d5fea
> --- /dev/null
> +++ b/hw/fsi/meson.build
> @@ -0,0 +1 @@
> +system_ss.add(when: 'CONFIG_LBUS', if_true: files('lbus.c'))
> diff --git a/hw/meson.build b/hw/meson.build
> index c7ac7d3d75..6c71ee9cfa 100644
> --- a/hw/meson.build
> +++ b/hw/meson.build
> @@ -43,6 +43,7 @@ subdir('virtio')
>   subdir('watchdog')
>   subdir('xen')
>   subdir('xenpv')
> +subdir('fsi')
>   
>   subdir('alpha')
>   subdir('arm')
> diff --git a/include/hw/fsi/lbus.h b/include/hw/fsi/lbus.h
> new file mode 100644
> index 0000000000..fafc065178
> --- /dev/null
> +++ b/include/hw/fsi/lbus.h
> @@ -0,0 +1,48 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM Local bus and connected device structures.
> + */
> +#ifndef FSI_LBUS_H
> +#define FSI_LBUS_H
> +
> +#include "exec/memory.h"
> +#include "hw/qdev-core.h"
> +
> +#define TYPE_LBUS_DEVICE "lbus.device"
> +OBJECT_DECLARE_TYPE(LBusDevice, LBusDeviceClass, LBUS_DEVICE)
>

Using an "fsi/FSI"  prefix for all definitions seems like a good idea
to avoid namespace conflicts.

> +typedef struct LBusDevice {
> +    DeviceState parent;
> +
> +    MemoryRegion iomem;
> +    uint32_t address;
> +} LBusDevice;
> +
> +typedef struct LBusDeviceClass {
> +    DeviceClass parent;
> +
> +    uint32_t config;
> +} LBusDeviceClass;
> +
> +typedef struct LBusNode {
> +    LBusDevice *ldev;
> +
> +    QLIST_ENTRY(LBusNode) next;
> +} LBusNode;
> +
> +#define TYPE_LBUS "lbus"
> +OBJECT_DECLARE_SIMPLE_TYPE(LBus, LBUS)
> +
> +typedef struct LBus {
> +    BusState bus;
> +
> +    MemoryRegion mr;
> +
> +    QLIST_HEAD(, LBusNode) devices;

BusState already has a list. I think this needs to be reworked.

  
> +} LBus;
> +
> +DeviceState *lbus_create_device(LBus *bus, const char *type, uint32_t addr);
> +int lbus_add_device(LBus *bus, LBusDevice *dev);
> +#endif /* FSI_LBUS_H */
> diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
> index cb3526d1f4..e12496f619 100644
> --- a/include/qemu/bitops.h
> +++ b/include/qemu/bitops.h
> @@ -618,4 +618,10 @@ static inline uint64_t half_unshuffle64(uint64_t x)
>       return x;
>   }
>   
> +/* Bitwise operations at the word level. */
> +#define BE_BIT(x)                          BIT(31 - (x))
> +#define GENMASK(t, b) \
> +    (((1ULL << ((t) + 1)) - 1) & ~((1ULL << (b)) - 1))
> +#define BE_GENMASK(t, b)                   GENMASK(BE_BIT(t), BE_BIT(b))

I think we should rework the code to make these macro local to the fsi
subsystem, in the fsi.h file, or even better get rid of them.

Thanks,

C.

  
>   #endif


