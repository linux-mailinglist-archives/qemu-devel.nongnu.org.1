Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A28B782C246
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 15:55:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOIvF-0002Mr-N1; Fri, 12 Jan 2024 09:54:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=qInK=IW=kaod.org=clg@ozlabs.org>)
 id 1rOIuy-0002Hl-BV; Fri, 12 Jan 2024 09:53:56 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=qInK=IW=kaod.org=clg@ozlabs.org>)
 id 1rOIuu-0006q2-Ij; Fri, 12 Jan 2024 09:53:54 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TBPgH2DMpz4x5l;
 Sat, 13 Jan 2024 01:53:47 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TBPgC31nWz4x2P;
 Sat, 13 Jan 2024 01:53:43 +1100 (AEDT)
Message-ID: <c85c8ce7-38cf-410a-b226-5810793295a6@kaod.org>
Date: Fri, 12 Jan 2024 15:53:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/9] hw/fsi: Introduce IBM's Local bus and scratchpad
Content-Language: en-US
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20240110231537.1654478-1-ninad@linux.ibm.com>
 <20240110231537.1654478-2-ninad@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240110231537.1654478-2-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=qInK=IW=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 1/11/24 00:15, Ninad Palsule wrote:
> This is a part of patchset where IBM's Flexible Service Interface is
> introduced.
> 
> The LBUS is modelled to maintain mapped memory for the devices. The
> memory is mapped after CFAM config, peek table and FSI slave registers.
> 
> The scratchpad provides a set of non-functional registers. The firmware
> is free to use them, hardware does not support any special management
> support. The scratchpad registers can be read or written from LBUS
> slave. The scratch pad is managed under FSI CFAM state.

This scratchpad mode should be in its own patch and thanks for the
extending the number of registers

> [ clg: - removed lbus_add_device() bc unused
>         - removed lbus_create_device() bc used only once
>         - removed "address" property
>         - updated meson.build to build fsi dir
>         - included an empty hw/fsi/trace-events ]

this list of modifications should be before my S-o-b.

> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
> v9:
>    - Changed LBUS memory region to 1MB.
> ---
>   meson.build           |   1 +
>   hw/fsi/trace.h        |   1 +
>   include/hw/fsi/lbus.h |  52 ++++++++++++++++++
>   hw/fsi/lbus.c         | 121 ++++++++++++++++++++++++++++++++++++++++++
>   hw/Kconfig            |   1 +
>   hw/fsi/Kconfig        |   2 +
>   hw/fsi/meson.build    |   1 +
>   hw/fsi/trace-events   |   2 +
>   hw/meson.build        |   1 +
>   9 files changed, 182 insertions(+)
>   create mode 100644 hw/fsi/trace.h
>   create mode 100644 include/hw/fsi/lbus.h
>   create mode 100644 hw/fsi/lbus.c
>   create mode 100644 hw/fsi/Kconfig
>   create mode 100644 hw/fsi/meson.build
>   create mode 100644 hw/fsi/trace-events
> 
> diff --git a/meson.build b/meson.build
> index 371edafae6..498d08b866 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3273,6 +3273,7 @@ if have_system
>       'hw/char',
>       'hw/display',
>       'hw/dma',
> +    'hw/fsi',
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
> diff --git a/include/hw/fsi/lbus.h b/include/hw/fsi/lbus.h
> new file mode 100644
> index 0000000000..8bacdded7f
> --- /dev/null
> +++ b/include/hw/fsi/lbus.h
> @@ -0,0 +1,52 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2024 IBM Corp.
> + *
> + * IBM Local bus and connected device structures.
> + */
> +#ifndef FSI_LBUS_H
> +#define FSI_LBUS_H
> +
> +#include "hw/qdev-core.h"
> +#include "qemu/units.h"
> +#include "exec/memory.h"
> +
> +#define TYPE_FSI_LBUS_DEVICE "fsi.lbus.device"
> +OBJECT_DECLARE_TYPE(FSILBusDevice, FSILBusDeviceClass, FSI_LBUS_DEVICE)
> +
> +#define FSI_LBUS_MEM_REGION_SIZE  (1 * MiB)
> +#define FSI_LBUSDEV_IOMEM_START   0xc00 /* 3K used by CFAM config etc */

These define are not very useful. Please remove (see comments in
lbus.c)

> +
> +typedef struct FSILBusDevice {
> +    DeviceState parent;
> +
> +    MemoryRegion iomem;
> +} FSILBusDevice;
> +
> +typedef struct FSILBusDeviceClass {
> +    DeviceClass parent;
> +
> +    uint32_t config;
> +} FSILBusDeviceClass;

This class is unused now.

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
> +#define TYPE_FSI_SCRATCHPAD "fsi.scratchpad"
> +#define SCRATCHPAD(obj) OBJECT_CHECK(FSIScratchPad, (obj), TYPE_FSI_SCRATCHPAD)
> +
> +#define FSI_SCRATCHPAD_NR_REGS 4
> +
> +typedef struct FSIScratchPad {
> +        FSILBusDevice parent;
> +
> +        uint32_t reg[FSI_SCRATCHPAD_NR_REGS];
> +} FSIScratchPad;
> +
> +#endif /* FSI_LBUS_H */
> diff --git a/hw/fsi/lbus.c b/hw/fsi/lbus.c
> new file mode 100644
> index 0000000000..34c450cc68
> --- /dev/null
> +++ b/hw/fsi/lbus.c
> @@ -0,0 +1,121 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2024 IBM Corp.
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
> +#include "trace.h"
> +
> +static void lbus_init(Object *o)

I would prefix the lbus routine and struct with fsi_lbus to be
consistent with the types and macro.

> +{
> +    FSILBus *lbus = FSI_LBUS(o);
> +
> +    memory_region_init(&lbus->mr, OBJECT(lbus), TYPE_FSI_LBUS,
> +                       FSI_LBUS_MEM_REGION_SIZE - FSI_LBUSDEV_IOMEM_START);

This is enough :

     memory_region_init(&lbus->mr, OBJECT(lbus), TYPE_FSI_LBUS, 1 * MiB);

> +}
> +
> +static const TypeInfo lbus_info = {
> +    .name = TYPE_FSI_LBUS,
> +    .parent = TYPE_BUS,
> +    .instance_init = lbus_init,
> +    .instance_size = sizeof(FSILBus),
> +};
> +
> +static void lbus_device_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->bus_type = TYPE_FSI_LBUS;
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
> +static uint64_t fsi_scratchpad_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    FSIScratchPad *s = SCRATCHPAD(opaque);
> +
> +    trace_fsi_scratchpad_read(addr, size);
> +
> +    if (addr & ~(FSI_SCRATCHPAD_NR_REGS - 1)) {
> +        return 0;
> +    }
> +
> +    return s->reg[addr];
> +}
> +
> +static void fsi_scratchpad_write(void *opaque, hwaddr addr, uint64_t data,
> +                                 unsigned size)
> +{
> +    FSIScratchPad *s = SCRATCHPAD(opaque);
> +
> +    trace_fsi_scratchpad_write(addr, size, data);
> +
> +    if (addr & ~(FSI_SCRATCHPAD_NR_REGS - 1)) {

There is a type confusion. addr is an offset in a memory region and
FSI_SCRATCHPAD_NR_REGS is an index an array.


> +        return;
> +    }
> +
> +    s->reg[addr] = data;

same here.

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
> +    int i;
> +
> +    for (i = 0; i < FSI_SCRATCHPAD_NR_REGS; i++) {
> +        s->reg[i] = 0;

memset(s->regs, 0, sizeof(s->regs));


Thanks,

C.



> +    }
> +}
> +
> +static void fsi_scratchpad_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = fsi_scratchpad_realize;
> +    dc->reset = fsi_scratchpad_reset;
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
> +static void lbus_register_types(void)
> +{
> +    type_register_static(&lbus_info);
> +    type_register_static(&lbus_device_type_info);
> +    type_register_static(&fsi_scratchpad_info);
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
> index 0000000000..9c34a418d7
> --- /dev/null
> +++ b/hw/fsi/Kconfig
> @@ -0,0 +1,2 @@
> +config FSI
> +    bool
> diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
> new file mode 100644
> index 0000000000..93ba19dd04
> --- /dev/null
> +++ b/hw/fsi/meson.build
> @@ -0,0 +1 @@
> +system_ss.add(when: 'CONFIG_FSI', if_true: files('lbus.c'))
> diff --git a/hw/fsi/trace-events b/hw/fsi/trace-events
> new file mode 100644
> index 0000000000..c5753e2791
> --- /dev/null
> +++ b/hw/fsi/trace-events
> @@ -0,0 +1,2 @@
> +fsi_scratchpad_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
> +fsi_scratchpad_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
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


