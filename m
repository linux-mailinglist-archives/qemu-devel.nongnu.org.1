Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAAA7FA5A0
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 17:07:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7e7P-0003jW-B2; Mon, 27 Nov 2023 11:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5Qwu=HI=kaod.org=clg@ozlabs.org>)
 id 1r7e6v-0003Sd-QY; Mon, 27 Nov 2023 11:05:27 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5Qwu=HI=kaod.org=clg@ozlabs.org>)
 id 1r7e6s-0001Xp-PH; Mon, 27 Nov 2023 11:05:25 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Sf9Qw3DzMz4xPf;
 Tue, 28 Nov 2023 03:05:12 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sf9Qm667Mz4wc0;
 Tue, 28 Nov 2023 03:05:04 +1100 (AEDT)
Message-ID: <145edc6c-2684-45bd-a4e7-399c98e2a3dc@kaod.org>
Date: Mon, 27 Nov 2023 17:04:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/10] hw/fsi: Introduce IBM's Local bus
Content-Language: en-US
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20231026164741.1184058-1-ninad@linux.ibm.com>
 <20231026164741.1184058-2-ninad@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231026164741.1184058-2-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=5Qwu=HI=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 10/26/23 18:47, Ninad Palsule wrote:
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
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
> v2:
> - Incorporated Joel's review comments.
> v5:
> - Incorporated review comments by Cedric.
> v6:
> - Incorporated review comments by Cedric & Daniel.
> v7:
> - Incorporated review comments by Philippe.
> ---
>   include/hw/fsi/lbus.h | 43 +++++++++++++++++++++++++
>   hw/fsi/lbus.c         | 74 +++++++++++++++++++++++++++++++++++++++++++
>   hw/Kconfig            |  1 +
>   hw/fsi/Kconfig        |  2 ++
>   hw/fsi/meson.build    |  1 +
>   hw/meson.build        |  1 +
>   6 files changed, 122 insertions(+)
>   create mode 100644 include/hw/fsi/lbus.h
>   create mode 100644 hw/fsi/lbus.c
>   create mode 100644 hw/fsi/Kconfig
>   create mode 100644 hw/fsi/meson.build
> 
> diff --git a/include/hw/fsi/lbus.h b/include/hw/fsi/lbus.h
> new file mode 100644
> index 0000000000..4fa696bbdb
> --- /dev/null
> +++ b/include/hw/fsi/lbus.h
> @@ -0,0 +1,43 @@
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
> +#define TYPE_FSI_LBUS_DEVICE "fsi.lbus.device"
> +OBJECT_DECLARE_TYPE(FSILBusDevice, FSILBusDeviceClass, FSI_LBUS_DEVICE)
> +
> +#define FSI_LBUS_MEM_REGION_SIZE  (2 * 1024 * 1024)
> +#define FSI_LBUSDEV_IOMEM_SIZE    0x400
> +
> +typedef struct FSILBusDevice {
> +    DeviceState parent;
> +
> +    MemoryRegion iomem;
> +    uint32_t address;

This is address attribute is not useful. Models/HW unit generally do not
know where their MMIO regions are mmapped in the address space.

> +} FSILBusDevice;
> +
> +typedef struct FSILBusDeviceClass {
> +    DeviceClass parent;
> +
> +    uint32_t config;
> +} FSILBusDeviceClass;
> +
> +#define TYPE_FSI_LBUS "fsi.lbus"
> +OBJECT_DECLARE_SIMPLE_TYPE(FSILBus, FSI_LBUS)
> +
> +typedef struct FSILBus {
> +    BusState bus;
> +
> +    MemoryRegion mr;
> +} FSILBus;
> +
> +DeviceState *lbus_create_device(FSILBus *bus, const char *type, uint32_t addr);
> +int lbus_add_device(FSILBus *bus, FSILBusDevice *dev);
> +#endif /* FSI_LBUS_H */
> diff --git a/hw/fsi/lbus.c b/hw/fsi/lbus.c
> new file mode 100644
> index 0000000000..3a7335dde5
> --- /dev/null
> +++ b/hw/fsi/lbus.c
> @@ -0,0 +1,74 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM Local bus where FSI slaves are connected
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/fsi/lbus.h"
> +
> +#include "hw/qdev-properties.h"
> +
> +static void lbus_init(Object *o)
> +{
> +    FSILBus *lbus = FSI_LBUS(o);
> +
> +    memory_region_init(&lbus->mr, OBJECT(lbus), TYPE_FSI_LBUS,
> +                       FSI_LBUS_MEM_REGION_SIZE - FSI_LBUSDEV_IOMEM_SIZE);
> +}
> +
> +static const TypeInfo lbus_info = {
> +    .name = TYPE_FSI_LBUS,
> +    .parent = TYPE_BUS,
> +    .instance_init = lbus_init,
> +    .instance_size = sizeof(FSILBus),
> +};
> +
> +static Property lbus_device_props[] = {
> +    DEFINE_PROP_UINT32("address", FSILBusDevice, address, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};

Please remove lbus_device_props

> +DeviceState *lbus_create_device(FSILBus *bus, const char *type, uint32_t addr)

This routine is only used once in a realize handler which could propagate
a possible error. Please remove.

> +{
> +    DeviceState *ds;
> +    BusState *state = BUS(bus);
> +    FSILBusDevice *dev;
> +
> +    ds = qdev_new(type);
> +    qdev_prop_set_uint32(ds, "address", addr);
> +    qdev_realize_and_unref(ds, state, &error_fatal);
> +
> +    dev = FSI_LBUS_DEVICE(ds);
> +    memory_region_add_subregion(&bus->mr, dev->address,
> +                                &dev->iomem);
> +
> +    return ds;
> +}
> +
> +static void lbus_device_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->bus_type = TYPE_FSI_LBUS;
> +    device_class_set_props(dc, lbus_device_props);
> +}
> +
> +static const TypeInfo lbus_device_type_info = {
> +    .name = TYPE_FSI_LBUS_DEVICE,
> +    .parent = TYPE_DEVICE,
> +    .instance_size = sizeof(FSILBusDevice),
> +    .abstract = true,
> +    .class_init = lbus_device_class_init,
> +    .class_size = sizeof(FSILBusDeviceClass),
> +};
> +
> +static void lbus_register_types(void)
> +{
> +    type_register_static(&lbus_info);
> +    type_register_static(&lbus_device_type_info);
> +}
> +
> +type_init(lbus_register_types);
> diff --git a/hw/Kconfig b/hw/Kconfig
> index 9ca7b38c31..2c00936c28 100644
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
> index 0000000000..e650c660f0
> --- /dev/null
> +++ b/hw/fsi/Kconfig
> @@ -0,0 +1,2 @@
> +config FSI_LBUS
> +    bool
> diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
> new file mode 100644
> index 0000000000..4074d3a7d2
> --- /dev/null
> +++ b/hw/fsi/meson.build
> @@ -0,0 +1 @@
> +system_ss.add(when: 'CONFIG_FSI_LBUS', if_true: files('lbus.c'))
> diff --git a/hw/meson.build b/hw/meson.build
> index f01fac4617..463d702683 100644
> --- a/hw/meson.build
> +++ b/hw/meson.build
> @@ -44,6 +44,7 @@ subdir('virtio')
>   subdir('watchdog')
>   subdir('xen')
>   subdir('xenpv')
> +subdir('fsi')
>   
>   subdir('alpha')
>   subdir('arm')

The meson.build file is not modified which means the new files are compiled.

Thanks,

C.


