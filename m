Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B4182C272
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 16:04:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOJ4D-0006mR-6N; Fri, 12 Jan 2024 10:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=qInK=IW=kaod.org=clg@ozlabs.org>)
 id 1rOJ48-0006l0-Vk; Fri, 12 Jan 2024 10:03:24 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=qInK=IW=kaod.org=clg@ozlabs.org>)
 id 1rOJ44-0002RZ-Qt; Fri, 12 Jan 2024 10:03:24 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TBPsz4ydtz4x7q;
 Sat, 13 Jan 2024 02:03:03 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TBPsv6sFKz4x5k;
 Sat, 13 Jan 2024 02:02:59 +1100 (AEDT)
Message-ID: <a7f8e651-025a-4252-931f-f05ad86e8c6e@kaod.org>
Date: Fri, 12 Jan 2024 16:02:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/9] hw/fsi: Introduce IBM's cfam
Content-Language: en-US
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20240110231537.1654478-1-ninad@linux.ibm.com>
 <20240110231537.1654478-4-ninad@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240110231537.1654478-4-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=qInK=IW=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_MED=-2.3,
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

On 1/11/24 00:15, Ninad Palsule wrote:
> This is a part of patchset where IBM's Flexible Service Interface is
> introduced.
> 
> The Common FRU Access Macro (CFAM), an address space containing
> various "engines" that drive accesses on busses internal and external
> to the POWER chip. Examples include the SBEFIFO and I2C masters. The
> engines hang off of an internal Local Bus (LBUS) which is described
> by the CFAM configuration block.
> 
> [ clg: - moved object FSIScratchPad under FSICFAMState
>         - moved FSIScratchPad code under cfam.c
>         - introduced fsi_cfam_instance_init()
>         - reworked fsi_cfam_realize() ]


Move the list down before my S-o-b.

> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
> v9:
>    - Added more registers to scratchpad
>    - Removed unnecessary address space
>    - Removed unnecessary header file
>    - Defined macros for config values.
>    - Cleaned up cfam config read.
> ---
>   include/hw/fsi/cfam.h |  34 ++++++++
>   hw/fsi/cfam.c         | 182 ++++++++++++++++++++++++++++++++++++++++++
>   hw/fsi/meson.build    |   2 +-
>   hw/fsi/trace-events   |   5 ++
>   4 files changed, 222 insertions(+), 1 deletion(-)
>   create mode 100644 include/hw/fsi/cfam.h
>   create mode 100644 hw/fsi/cfam.c
> 
> diff --git a/include/hw/fsi/cfam.h b/include/hw/fsi/cfam.h
> new file mode 100644
> index 0000000000..bba5e3323a
> --- /dev/null
> +++ b/include/hw/fsi/cfam.h
> @@ -0,0 +1,34 @@
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
> +#include "hw/fsi/fsi.h"
> +#include "hw/fsi/lbus.h"
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
> +
> +    FSILBus lbus;
> +    FSIScratchPad scratchpad;
> +} FSICFAMState;
> +
> +#endif /* FSI_CFAM_H */
> diff --git a/hw/fsi/cfam.c b/hw/fsi/cfam.c
> new file mode 100644
> index 0000000000..d9ed1b532a
> --- /dev/null
> +++ b/hw/fsi/cfam.c
> @@ -0,0 +1,182 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM Common FRU Access Macro
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
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
> +/* Valid, slots, version, type, crc */
> +#define CFAM_CONFIG_REG_PEEK               (ENGINE_CONFIG_NEXT       | \
> +                                            0x00010000               | \
> +                                            0x00001000               | \
> +                                            ENGINE_CONFIG_TYPE_PEEK  | \
> +                                            0x0000000c)
> +
> +/* Valid, slots, version, type, crc */
> +#define CFAM_CONFIG_REG_FSI_SLAVE          (ENGINE_CONFIG_NEXT       | \
> +                                            0x00010000               | \
> +                                            0x00005000               | \
> +                                            ENGINE_CONFIG_TYPE_FSI   | \
> +                                            0x0000000a)
> +
> +/* Valid, slots, version, type, crc */
> +#define CFAM_CONFIG_REG_SCRATCHPAD         (ENGINE_CONFIG_NEXT       | \
> +                                            0x00010000               | \
> +                                            0x00001000               | \
> +                                            ENGINE_CONFIG_TYPE_SCRATCHPAD | \
> +                                            0x00000007)

I was expecting a macro taking argument to build the config reg value
of each sub engine but that's fine also.

> +#define TO_REG(x)                          ((x) >> 2)
> +
> +#define CFAM_CONFIG_CHIP_ID                TO_REG(0x00)
> +#define CFAM_CONFIG_PEEK_STATUS            TO_REG(0x04)
> +#define CFAM_CONFIG_CHIP_ID_P9             0xc0022d15
> +#define CFAM_CONFIG_CHIP_ID_BREAK          0xc0de0000
> +
> +static uint64_t fsi_cfam_config_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    trace_fsi_cfam_config_read(addr, size);
> +
> +    switch (addr) {
> +    case 0x00:
> +        return CFAM_CONFIG_CHIP_ID_P9;
> +    case 0x04:
> +        return CFAM_CONFIG_REG_PEEK;
> +    case 0x08:
> +        return CFAM_CONFIG_REG_FSI_SLAVE;
> +    case 0xc:
> +        return CFAM_CONFIG_REG_SCRATCHPAD;
> +    default:
> +        /*
> +         * The config table contains different engines from 0xc onwards.
> +         * The scratch pad is already added at address 0xc. We need to add
> +         * future engines from address 0x10 onwards. Returning 0 as engine
> +         * is not implemented.
> +         */
> +        return 0;
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
> +    case CFAM_CONFIG_PEEK_STATUS:
> +        if (data == CFAM_CONFIG_CHIP_ID_BREAK) {
> +            bus_cold_reset(BUS(&cfam->lbus));
> +        }
> +        break;
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
> +                          cfam, TYPE_FSI_CFAM, 2 * MiB);
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
> +    if (!qdev_realize(DEVICE(&cfam->scratchpad), BUS(&cfam->lbus),
> +                                errp)) {

could be a single line.

Thanks,

C.



> +        return;
> +    }
> +
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
> +static void fsi_cfam_register_types(void)
> +{
> +    type_register_static(&fsi_cfam_info);
> +}
> +
> +type_init(fsi_cfam_register_types);
> diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
> index 574f5f9289..96403d4efc 100644
> --- a/hw/fsi/meson.build
> +++ b/hw/fsi/meson.build
> @@ -1 +1 @@
> -system_ss.add(when: 'CONFIG_FSI', if_true: files('lbus.c','fsi.c'))
> +system_ss.add(when: 'CONFIG_FSI', if_true: files('lbus.c','fsi.c','cfam.c'))
> diff --git a/hw/fsi/trace-events b/hw/fsi/trace-events
> index 8f29adb7df..b542956fb3 100644
> --- a/hw/fsi/trace-events
> +++ b/hw/fsi/trace-events
> @@ -2,3 +2,8 @@ fsi_scratchpad_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
>   fsi_scratchpad_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
>   fsi_slave_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
>   fsi_slave_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
> +fsi_cfam_config_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
> +fsi_cfam_config_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
> +fsi_cfam_unimplemented_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
> +fsi_cfam_unimplemented_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
> +fsi_cfam_config_write_noaddr(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64


