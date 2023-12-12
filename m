Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A4780EF46
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 15:49:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD43x-0008A4-6K; Tue, 12 Dec 2023 09:48:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=DDG+=HX=kaod.org=clg@ozlabs.org>)
 id 1rD43l-00087M-Ig; Tue, 12 Dec 2023 09:48:33 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=DDG+=HX=kaod.org=clg@ozlabs.org>)
 id 1rD43h-0004Nt-Hq; Tue, 12 Dec 2023 09:48:32 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SqM1N4GCsz4xQj;
 Wed, 13 Dec 2023 01:48:24 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SqM1F17sRz4xNH;
 Wed, 13 Dec 2023 01:48:16 +1100 (AEDT)
Message-ID: <4bce745f-c70f-414a-bf1a-f53503d5bc1a@kaod.org>
Date: Tue, 12 Dec 2023 15:48:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: [PATCH v8 03/10] hw/fsi: Introduce IBM's cfam,fsi-slave,scratchpad
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20231128235700.599584-1-ninad@linux.ibm.com>
 <20231128235700.599584-4-ninad@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20231128235700.599584-4-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=DDG+=HX=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 11/29/23 00:56, Ninad Palsule wrote:
> This is a part of patchset where IBM's Flexible Service Interface is
> introduced.
> 
> The Common FRU Access Macro (CFAM), an address space containing
> various "engines" that drive accesses on busses internal and external
> to the POWER chip. Examples include the SBEFIFO and I2C masters. The
> engines hang off of an internal Local Bus (LBUS) which is described
> by the CFAM configuration block.
> 
> The FSI slave: The slave is the terminal point of the FSI bus for
> FSI symbols addressed to it. Slaves can be cascaded off of one
> another. The slave's configuration registers appear in address space
> of the CFAM to which it is attached.
> 
> The scratchpad provides a set of non-functional registers. The firmware
> is free to use them, hardware does not support any special management
> support. The scratchpad registers can be read or written from LBUS
> slave. The scratch pad is managed under FSI CFAM state.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> [ clg: - moved object FSIScratchPad under FSICFAMState
>         - moved FSIScratchPad code under cfam.c
>         - introduced fsi_cfam_instance_init()
>         - reworked fsi_cfam_realize() ]
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   include/hw/fsi/cfam.h      |  45 +++++++
>   include/hw/fsi/fsi-slave.h |  29 +++++
>   include/hw/fsi/fsi.h       |   5 +
>   hw/fsi/cfam.c              | 261 +++++++++++++++++++++++++++++++++++++
>   hw/fsi/fsi-slave.c         |  78 +++++++++++
>   hw/fsi/Kconfig             |   8 ++
>   hw/fsi/meson.build         |   3 +-
>   hw/fsi/trace-events        |  10 +-
>   8 files changed, 437 insertions(+), 2 deletions(-)
>   create mode 100644 include/hw/fsi/cfam.h
>   create mode 100644 include/hw/fsi/fsi-slave.h
>   create mode 100644 hw/fsi/cfam.c
>   create mode 100644 hw/fsi/fsi-slave.c
> 
> diff --git a/include/hw/fsi/cfam.h b/include/hw/fsi/cfam.h
> new file mode 100644
> index 0000000000..9d3da727ff
> --- /dev/null
> +++ b/include/hw/fsi/cfam.h
> @@ -0,0 +1,45 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM Common FRU Access Macro
> + */
> +#ifndef FSI_CFAM_H
> +#define FSI_CFAM_H
> +
> +#include "exec/memory.h"
> +
> +#include "hw/fsi/fsi-slave.h"
> +#include "hw/fsi/lbus.h"
> +
> +
> +#define TYPE_FSI_SCRATCHPAD "fsi.scratchpad"
> +#define SCRATCHPAD(obj) OBJECT_CHECK(FSIScratchPad, (obj), TYPE_FSI_SCRATCHPAD)
> +
> +typedef struct FSIScratchPad {
> +        FSILBusDevice parent;
> +
> +        uint32_t reg;
> +} FSIScratchPad;

We could extend to 4 regs possibly.
  
> +
> +#define TYPE_FSI_CFAM "cfam"
> +#define FSI_CFAM(obj) OBJECT_CHECK(FSICFAMState, (obj), TYPE_FSI_CFAM)
> +
> +/* P9-ism */
> +#define CFAM_CONFIG_NR_REGS 0x28
> +
> +typedef struct FSICFAMState {
> +    /* < private > */
> +    FSISlaveState parent;
> +
> +    /* CFAM config address space */
> +    MemoryRegion config_iomem;
> +
> +    MemoryRegion mr;
> +    AddressSpace as;

The address space is not used. please remove.

> +
> +    FSILBus lbus;
> +    FSIScratchPad scratchpad;
> +} FSICFAMState;
> +
> +#endif /* FSI_CFAM_H */
> diff --git a/include/hw/fsi/fsi-slave.h b/include/hw/fsi/fsi-slave.h
> new file mode 100644
> index 0000000000..f5f23f4457
> --- /dev/null
> +++ b/include/hw/fsi/fsi-slave.h
> @@ -0,0 +1,29 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM Flexible Service Interface slave
> + */
> +#ifndef FSI_FSI_SLAVE_H
> +#define FSI_FSI_SLAVE_H
> +
> +#include "exec/memory.h"
> +#include "hw/qdev-core.h"
> +
> +#include "hw/fsi/lbus.h"
> +
> +#include <stdint.h>

Not needed. Please remove.

> +#define TYPE_FSI_SLAVE "fsi.slave"
> +OBJECT_DECLARE_SIMPLE_TYPE(FSISlaveState, FSI_SLAVE)
> +
> +#define FSI_SLAVE_CONTROL_NR_REGS ((0x40 >> 2) + 1)
> +
> +typedef struct FSISlaveState {
> +    DeviceState parent;
> +
> +    MemoryRegion iomem;
> +    uint32_t regs[FSI_SLAVE_CONTROL_NR_REGS];
> +} FSISlaveState;
> +
> +#endif /* FSI_FSI_H */
> diff --git a/include/hw/fsi/fsi.h b/include/hw/fsi/fsi.h
> index a75e3e5bdc..af39f9b4ad 100644
> --- a/include/hw/fsi/fsi.h
> +++ b/include/hw/fsi/fsi.h
> @@ -8,6 +8,11 @@
>   #define FSI_FSI_H
>   
>   #include "hw/qdev-core.h"
> +#include "qemu/bitops.h"
> +
> +/* Bitwise operations at the word level. */
> +#define BE_BIT(x)           BIT(31 - (x))
> +#define BE_GENMASK(hb, lb)  MAKE_64BIT_MASK((lb), ((hb) - (lb) + 1))
>   
>   #define TYPE_FSI_BUS "fsi.bus"
>   OBJECT_DECLARE_SIMPLE_TYPE(FSIBus, FSI_BUS)
> diff --git a/hw/fsi/cfam.c b/hw/fsi/cfam.c
> new file mode 100644
> index 0000000000..5086a2c45c
> --- /dev/null
> +++ b/hw/fsi/cfam.c
> @@ -0,0 +1,261 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM Common FRU Access Macro
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "qapi/error.h"
> +#include "trace.h"
> +
> +#include "hw/fsi/cfam.h"
> +#include "hw/fsi/fsi.h"
> +
> +#include "hw/qdev-properties.h"
> +
> +#define ENGINE_CONFIG_NEXT            BE_BIT(0)
> +#define ENGINE_CONFIG_TYPE_PEEK       (0x02 << 4)
> +#define ENGINE_CONFIG_TYPE_FSI        (0x03 << 4)
> +#define ENGINE_CONFIG_TYPE_SCRATCHPAD (0x06 << 4)
> +
> +#define TO_REG(x)                          ((x) >> 2)
> +
> +#define CFAM_ENGINE_CONFIG                 TO_REG(0x04)
> +
> +#define CFAM_CONFIG_CHIP_ID                TO_REG(0x00)
> +#define CFAM_CONFIG_CHIP_ID_P9             0xc0022d15
> +#define CFAM_CONFIG_CHIP_ID_BREAK          0xc0de0000
> +
> +static uint64_t fsi_cfam_config_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    FSICFAMState *cfam = FSI_CFAM(opaque);
> +    BusChild *kid;
> +    int i;
> +
> +    trace_fsi_cfam_config_read(addr, size);
> +
> +    switch (addr) {
> +    case 0x00:
> +        return CFAM_CONFIG_CHIP_ID_P9;
> +    case 0x04:
> +        return ENGINE_CONFIG_NEXT       |   /* valid */
> +               0x00010000               |   /* slots */
> +               0x00001000               |   /* version */
> +               ENGINE_CONFIG_TYPE_PEEK  |   /* type */
> +               0x0000000c;                  /* crc */
> +    case 0x08:
> +        return ENGINE_CONFIG_NEXT       |   /* valid */
> +               0x00010000               |   /* slots */
> +               0x00005000               |   /* version */
> +               ENGINE_CONFIG_TYPE_FSI   |   /* type */
> +               0x0000000a;                  /* crc */

Please introduce a macro to build these register values.

> +        break;
> +    default:
> +        /* The config table contains different engines from 0xc onwards. */
> +        i = 0xc;
> +        QTAILQ_FOREACH(kid, &cfam->lbus.bus.children, sibling) {
> +            if (i == addr) {
> +                DeviceState *ds = kid->child;
> +                FSILBusDevice *dev = FSI_LBUS_DEVICE(ds);
> +                return FSI_LBUS_DEVICE_GET_CLASS(dev)->config;
> +            }
> +            i += size;
> +        }
> +
> +        if (i == addr) {
> +            return 0;
> +        }

If I understand correctly, the register 0xC contains some static config
value for the first device engine, the scratchpad device mapped at 0xC00,
and following registers would do the same for other devices if they were
modelled.

This is certtainly hardwired in HW, so I would simplify to :
  
	case 0xC:
		return ldc->config
	default:
		/* log not implemented */

And extend the list when more devices are modeled.

> +        /*
> +         * As per FSI specification, This is a magic value at address 0 of
> +         * given FSI port. This causes FSI master to send BREAK command for
> +         * initialization and recovery.
> +         */
> +        return CFAM_CONFIG_CHIP_ID_BREAK;

This looks weird. I don't understant to which offset this value belongs.
  
> +    }
> +}
> +
> +static void fsi_cfam_config_write(void *opaque, hwaddr addr, uint64_t data,
> +                                  unsigned size)
> +{
> +    FSICFAMState *cfam = FSI_CFAM(opaque);
> +
> +    trace_fsi_cfam_config_write(addr, size, data);
> +
> +    switch (TO_REG(addr)) {
> +    case CFAM_CONFIG_CHIP_ID:
> +    case CFAM_CONFIG_CHIP_ID + 4:

Couldn't we introduce a proper define for this reg ? and can we write to
the config space ? This break command seems to be sent to the FSI master,
according to Linux. Why is it handled in the CFAM config space ?

> +        if (data == CFAM_CONFIG_CHIP_ID_BREAK) {
> +            bus_cold_reset(BUS(&cfam->lbus));
> +        }
> +    break;

alignment is not good.

> +    default:
> +        trace_fsi_cfam_config_write_noaddr(addr, size, data);
> +    }
> +}
> +
> +static const struct MemoryRegionOps cfam_config_ops = {
> +    .read = fsi_cfam_config_read,
> +    .write = fsi_cfam_config_write,
> +    .valid.max_access_size = 4,
> +    .valid.min_access_size = 4,
> +    .impl.max_access_size = 4,
> +    .impl.min_access_size = 4,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +};
> +
> +static uint64_t fsi_cfam_unimplemented_read(void *opaque, hwaddr addr,
> +                                            unsigned size)
> +{
> +    trace_fsi_cfam_unimplemented_read(addr, size);
> +
> +    return 0;
> +}
> +
> +static void fsi_cfam_unimplemented_write(void *opaque, hwaddr addr,
> +                                         uint64_t data, unsigned size)
> +{
> +    trace_fsi_cfam_unimplemented_write(addr, size, data);
> +}
> +
> +static const struct MemoryRegionOps fsi_cfam_unimplemented_ops = {
> +    .read = fsi_cfam_unimplemented_read,
> +    .write = fsi_cfam_unimplemented_write,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +};
> +
> +static void fsi_cfam_instance_init(Object *obj)
> +{
> +    FSICFAMState *s = FSI_CFAM(obj);
> +
> +    object_initialize_child(obj, "scratchpad", &s->scratchpad,
> +                            TYPE_FSI_SCRATCHPAD);
> +}
> +
> +static void fsi_cfam_realize(DeviceState *dev, Error **errp)
> +{
> +    FSICFAMState *cfam = FSI_CFAM(dev);
> +    FSISlaveState *slave = FSI_SLAVE(dev);
> +
> +    /* Each slave has a 2MiB address space */
> +    memory_region_init_io(&cfam->mr, OBJECT(cfam), &fsi_cfam_unimplemented_ops,
> +                          cfam, TYPE_FSI_CFAM, 2 * 1024 * 1024);

2 * MiB

> +    address_space_init(&cfam->as, &cfam->mr, TYPE_FSI_CFAM);
> +
> +    qbus_init(&cfam->lbus, sizeof(cfam->lbus), TYPE_FSI_LBUS, DEVICE(cfam),
> +              NULL);
> +
> +    memory_region_init_io(&cfam->config_iomem, OBJECT(cfam), &cfam_config_ops,
> +                          cfam, TYPE_FSI_CFAM ".config", 0x400);
> +
> +    memory_region_add_subregion(&cfam->mr, 0, &cfam->config_iomem);
> +    memory_region_add_subregion(&cfam->mr, 0x800, &slave->iomem);
> +    memory_region_add_subregion(&cfam->mr, 0xc00, &cfam->lbus.mr);
> +
> +    /* Add scratchpad engine */
> +    if (!qdev_realize_and_unref(DEVICE(&cfam->scratchpad), BUS(&cfam->lbus),

cfam->scratchpad is not allocated. We should use qdev_realize instead.

> +                                errp)) {
> +        return;
> +    }
> +
> +    /* TODO: clarify scratchpad mapping */

You can remove the TODO now. All Local bus devices are mapped at offset
0xc00.
  
> +    FSILBusDevice *fsi_dev = FSI_LBUS_DEVICE(&cfam->scratchpad);
> +    memory_region_add_subregion(&cfam->lbus.mr, 0, &fsi_dev->iomem);
> +}
> +
> +static void fsi_cfam_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    dc->bus_type = TYPE_FSI_BUS;
> +    dc->realize = fsi_cfam_realize;
> +}
> +
> +static const TypeInfo fsi_cfam_info = {
> +    .name = TYPE_FSI_CFAM,
> +    .parent = TYPE_FSI_SLAVE,
> +    .instance_init = fsi_cfam_instance_init,
> +    .instance_size = sizeof(FSICFAMState),
> +    .class_init = fsi_cfam_class_init,
> +};
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

Just one reg ! Too easy :) let's have a few more.


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

This class and attribute do not  look useful. Please use a macro
to build the value and return it in the CFAM config read operation.


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
> +static void fsi_cfam_register_types(void)
> +{
> +    type_register_static(&fsi_scratchpad_info);
> +    type_register_static(&fsi_cfam_info);
> +}
> +
> +type_init(fsi_cfam_register_types);
> diff --git a/hw/fsi/fsi-slave.c b/hw/fsi/fsi-slave.c
> new file mode 100644
> index 0000000000..70386c0bb8
> --- /dev/null
> +++ b/hw/fsi/fsi-slave.c
> @@ -0,0 +1,78 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM Flexible Service Interface slave
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +#include "trace.h"
> +
> +#include "hw/fsi/fsi-slave.h"
> +#include "hw/fsi/fsi.h"
> +
> +#define TO_REG(x)                               ((x) >> 2)
> +
> +static uint64_t fsi_slave_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    FSISlaveState *s = FSI_SLAVE(opaque);
> +
> +    trace_fsi_slave_read(addr, size);
> +
> +    if (addr + size > sizeof(s->regs)) {

This test is mixing memory region offsets and memop size. These are two
fields of different nature. So this is quite incorrect !

Ideally, we should have a switch statement with handlers for implemented
registers and a default for the rest. Please see the aspeed_scu model
for an example.
  
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out of bounds read: 0x%"HWADDR_PRIx" for %u\n",
> +                      __func__, addr, size);
> +        return 0;
> +    }
> +
> +    return s->regs[TO_REG(addr)];
> +}
> +
> +static void fsi_slave_write(void *opaque, hwaddr addr, uint64_t data,
> +                                 unsigned size)
> +{
> +    FSISlaveState *s = FSI_SLAVE(opaque);
> +
> +    trace_fsi_slave_write(addr, size, data);
> +
> +    if (addr + size > sizeof(s->regs)) {

Same here.

> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out of bounds write: 0x%"HWADDR_PRIx" for %u\n",
> +                      __func__, addr, size);
> +        return;
> +    }
> +
> +    s->regs[TO_REG(addr)] = data;
> +}
> +
> +static const struct MemoryRegionOps fsi_slave_ops = {
> +    .read = fsi_slave_read,
> +    .write = fsi_slave_write,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +};
> +
> +static void fsi_slave_init(Object *o)
> +{
> +    FSISlaveState *s = FSI_SLAVE(o);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &fsi_slave_ops,
> +                          s, TYPE_FSI_SLAVE, 0x400);
> +}


No reset handler ?


Thanks,

C.



> +static const TypeInfo fsi_slave_info = {
> +    .name = TYPE_FSI_SLAVE,
> +    .parent = TYPE_DEVICE,
> +    .instance_init = fsi_slave_init,
> +    .instance_size = sizeof(FSISlaveState),
> +};
> +
> +static void fsi_slave_register_types(void)
> +{
> +    type_register_static(&fsi_slave_info);
> +}
> +
> +type_init(fsi_slave_register_types);
> diff --git a/hw/fsi/Kconfig b/hw/fsi/Kconfig
> index f4869c209f..de1594a335 100644
> --- a/hw/fsi/Kconfig
> +++ b/hw/fsi/Kconfig
> @@ -1,3 +1,11 @@
> +config FSI_CFAM
> +    bool
> +    select FSI
> +    select FSI_LBUS
> +
> +config FSI
> +    bool
> +
>   config FSI
>       bool
>   
> diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
> index 487fb31cbc..cafd009c6d 100644
> --- a/hw/fsi/meson.build
> +++ b/hw/fsi/meson.build
> @@ -1,2 +1,3 @@
>   system_ss.add(when: 'CONFIG_FSI_LBUS', if_true: files('lbus.c'))
> -system_ss.add(when: 'CONFIG_FSI', if_true: files('fsi.c'))
> +system_ss.add(when: 'CONFIG_FSI_CFAM', if_true: files('cfam.c'))
> +system_ss.add(when: 'CONFIG_FSI', if_true: files('fsi.c','fsi-slave.c'))
> diff --git a/hw/fsi/trace-events b/hw/fsi/trace-events
> index 8b13789179..b57b2dcc86 100644
> --- a/hw/fsi/trace-events
> +++ b/hw/fsi/trace-events
> @@ -1 +1,9 @@
> -
> +fsi_scratchpad_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
> +fsi_scratchpad_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
> +fsi_cfam_config_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
> +fsi_cfam_config_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
> +fsi_cfam_unimplemented_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
> +fsi_cfam_unimplemented_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
> +fsi_cfam_config_write_noaddr(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
> +fsi_slave_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
> +fsi_slave_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64


