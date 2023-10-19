Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0AA7CF139
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 09:28:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtNQe-00072m-7z; Thu, 19 Oct 2023 03:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=PA0m=GB=kaod.org=clg@ozlabs.org>)
 id 1qtNQb-000721-Oh; Thu, 19 Oct 2023 03:26:45 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=PA0m=GB=kaod.org=clg@ozlabs.org>)
 id 1qtNQY-0008NV-It; Thu, 19 Oct 2023 03:26:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S9zmX1X8Jz4xcT;
 Thu, 19 Oct 2023 18:26:36 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9zmS3XsWz4x3D;
 Thu, 19 Oct 2023 18:26:32 +1100 (AEDT)
Message-ID: <3b1cd559-3d1f-4631-9511-44b6cf72f96b@kaod.org>
Date: Thu, 19 Oct 2023 09:26:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/10] hw/fsi: IBM's On-chip Peripheral Bus
Content-Language: en-US
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@aj.id.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org
References: <20231011151339.2782132-1-ninad@linux.ibm.com>
 <20231011151339.2782132-6-ninad@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231011151339.2782132-6-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=PA0m=GB=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/11/23 17:13, Ninad Palsule wrote:
> This is a part of patchset where IBM's Flexible Service Interface is
> introduced.
> 
> The On-Chip Peripheral Bus (OPB): A low-speed bus typically found in
> POWER processors. This now makes an appearance in the ASPEED SoC due
> to tight integration of the FSI master IP with the OPB, mainly the
> existence of an MMIO-mapping of the CFAM address straight onto a
> sub-region of the OPB address space.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> ---
> v2:
> - Incorporated review comment by Joel.
> v5:
> - Incorporated review comments by Cedric.
> ---
>   include/hw/fsi/opb.h |  43 ++++++++++
>   hw/fsi/fsi-master.c  |   3 +-
>   hw/fsi/opb.c         | 185 +++++++++++++++++++++++++++++++++++++++++++
>   hw/fsi/Kconfig       |   4 +
>   hw/fsi/meson.build   |   1 +
>   hw/fsi/trace-events  |   2 +
>   6 files changed, 236 insertions(+), 2 deletions(-)
>   create mode 100644 include/hw/fsi/opb.h
>   create mode 100644 hw/fsi/opb.c
> 
> diff --git a/include/hw/fsi/opb.h b/include/hw/fsi/opb.h
> new file mode 100644
> index 0000000000..f8ce00383e
> --- /dev/null
> +++ b/include/hw/fsi/opb.h
> @@ -0,0 +1,43 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM On-Chip Peripheral Bus
> + */
> +#ifndef FSI_OPB_H
> +#define FSI_OPB_H
> +
> +#include "exec/memory.h"
> +#include "hw/fsi/fsi-master.h"
> +
> +#define TYPE_OP_BUS "opb"
> +OBJECT_DECLARE_SIMPLE_TYPE(OPBus, OP_BUS)
> +
> +typedef struct OPBus {
> +        /*< private >*/
> +        BusState bus;
> +
> +        /*< public >*/
> +        MemoryRegion mr;
> +        AddressSpace as;
> +
> +        /* Model OPB as dumb enough just to provide an address-space */
> +        /* TODO: Maybe don't store device state in the bus? */
> +        FSIMasterState fsi;
> +} OPBus;
> +
> +typedef struct OPBusClass {
> +        BusClass parent_class;
> +} OPBusClass;
> +
> +uint8_t opb_read8(OPBus *opb, hwaddr addr);
> +uint16_t opb_read16(OPBus *opb, hwaddr addr);
> +uint32_t opb_read32(OPBus *opb, hwaddr addr);
> +void opb_write8(OPBus *opb, hwaddr addr, uint8_t data);
> +void opb_write16(OPBus *opb, hwaddr addr, uint16_t data);
> +void opb_write32(OPBus *opb, hwaddr addr, uint32_t data);
> +
> +void opb_fsi_master_address(OPBus *opb, hwaddr addr);
> +void opb_opb2fsi_address(OPBus *opb, hwaddr addr);
> +
> +#endif /* FSI_OPB_H */
> diff --git a/hw/fsi/fsi-master.c b/hw/fsi/fsi-master.c
> index 8f4ae641c7..ede1a58e98 100644
> --- a/hw/fsi/fsi-master.c
> +++ b/hw/fsi/fsi-master.c
> @@ -11,8 +11,7 @@
>   #include "trace.h"
>   
>   #include "hw/fsi/fsi-master.h"
> -
> -#define TYPE_OP_BUS "opb"
> +#include "hw/fsi/opb.h"
>   
>   #define TO_REG(x)                               ((x) >> 2)
>   
> diff --git a/hw/fsi/opb.c b/hw/fsi/opb.c
> new file mode 100644
> index 0000000000..7ffd7730f7
> --- /dev/null
> +++ b/hw/fsi/opb.c
> @@ -0,0 +1,185 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM On-chip Peripheral Bus
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +#include "trace.h"
> +
> +#include "hw/fsi/opb.h"
> +
> +static MemTxResult opb_read(OPBus *opb, hwaddr addr, void *data, size_t len)
> +{
> +    MemTxResult tx;
> +    tx = address_space_read(&opb->as, addr, MEMTXATTRS_UNSPECIFIED, data,
> +                              len);
> +    if (tx) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: OPB read failed: 0x%"HWADDR_PRIx" for %lu\n",
> +                      __func__, addr, len);
> +    }
> +    return tx;
> +}
> +
> +uint8_t opb_read8(OPBus *opb, hwaddr addr)
> +{
> +    uint8_t data = -1;
> +
> +    (void)opb_read(opb, addr, &data, sizeof(data));
> +
> +    return data;
> +}
> +
> +uint16_t opb_read16(OPBus *opb, hwaddr addr)
> +{
> +    uint16_t data = -1;
> +
> +    (void)opb_read(opb, addr, &data, sizeof(data));
> +
> +    return data;
> +}
> +
> +uint32_t opb_read32(OPBus *opb, hwaddr addr)
> +{
> +    uint32_t data = -1;
> +
> +    (void)opb_read(opb, addr, &data, sizeof(data));
> +
> +    return data;
> +}
> +
> +static void opb_write(OPBus *opb, hwaddr addr, void *data, size_t len)
> +{
> +    MemTxResult tx;
> +    tx = address_space_write(&opb->as, addr, MEMTXATTRS_UNSPECIFIED, data,
> +                               len);
> +    if (tx) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: OPB write failed: %"HWADDR_PRIx" for %lu\n",
> +                      __func__, addr, len);
> +    }
> +}
> +
> +void opb_write8(OPBus *opb, hwaddr addr, uint8_t data)
> +{
> +    opb_write(opb, addr, &data, sizeof(data));
> +}
> +
> +void opb_write16(OPBus *opb, hwaddr addr, uint16_t data)
> +{
> +    opb_write(opb, addr, &data, sizeof(data));
> +}
> +
> +void opb_write32(OPBus *opb, hwaddr addr, uint32_t data)
> +{
> +    opb_write(opb, addr, &data, sizeof(data));
> +}

Please remove all the above opb_* helpers and replace them with
address_space_rw() where they are use. Previous patch.


> +void opb_fsi_master_address(OPBus *opb, hwaddr addr)
> +{
> +    memory_region_transaction_begin();
> +    memory_region_set_address(&opb->fsi.iomem, addr);
> +    memory_region_transaction_commit();
> +}
> +
> +void opb_opb2fsi_address(OPBus *opb, hwaddr addr)
> +{
> +    memory_region_transaction_begin();
> +    memory_region_set_address(&opb->fsi.opb2fsi, addr);
> +    memory_region_transaction_commit();
> +}


These opb_opb2fs_* routines belong to PATCH 6.

> +static uint64_t opb_unimplemented_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    trace_opb_unimplemented_read(addr, size);
> +
> +    return 0;
> +}
> +
> +static void opb_unimplemented_write(void *opaque, hwaddr addr, uint64_t data,
> +                                 unsigned size)
> +{
> +    trace_opb_unimplemented_write(addr, size, data);
> +}
> +
> +static const struct MemoryRegionOps opb_unimplemented_ops = {
> +    .read = opb_unimplemented_read,
> +    .write = opb_unimplemented_write,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +};


have you checked if create_unimplemented_device() could be used ?
  

> +static void opb_realize(BusState *bus, Error **errp)
> +{
> +    OPBus *opb = OP_BUS(bus);
> +    Error *err = NULL;
> +
> +    memory_region_init_io(&opb->mr, OBJECT(opb), &opb_unimplemented_ops, opb,
> +                          NULL, UINT32_MAX);
> +    address_space_init(&opb->as, &opb->mr, "opb");
> +
> +    object_property_set_bool(OBJECT(&opb->fsi), "realized", true, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    memory_region_add_subregion(&opb->mr, 0x80000000, &opb->fsi.iomem);
> +
> +    /* OPB2FSI region */
> +    /*
> +     * Avoid endianness issues by mapping each slave's memory region directly.
> +     * Manually bridging multiple address-spaces causes endian swapping
> +     * headaches as memory_region_dispatch_read() and
> +     * memory_region_dispatch_write() correct the endianness based on the
> +     * target machine endianness and not relative to the device endianness on
> +     * either side of the bridge.
> +     */
> +    /*
> +     * XXX: This is a bit hairy and will need to be fixed when I sort out the
> +     * bus/slave relationship and any changes to the CFAM modelling (multiple
> +     * slaves, LBUS)
> +     */
> +    memory_region_add_subregion(&opb->mr, 0xa0000000, &opb->fsi.opb2fsi);
> +}
> +
> +static void opb_init(Object *o)
> +{
> +    OPBus *opb = OP_BUS(o);
> +
> +    object_initialize_child(o, "fsi-master", &opb->fsi, TYPE_FSI_MASTER);
> +    qdev_set_parent_bus(DEVICE(&opb->fsi), BUS(o), &error_abort);


This fsi object should be a child of TYPE_ASPEED_APB2OPB and created
with qdev_realize_and_unref() in aspeed_apb2opb_realize().

  
> +}
> +
> +static void opb_finalize(Object *o)
> +{
> +    OPBus *opb = OP_BUS(o);
> +
> +    address_space_destroy(&opb->as);
> +}

The finalize op is not strictly necessary.

Thanks,

C.


> +static void opb_class_init(ObjectClass *klass, void *data)
> +{
> +    BusClass *bc = BUS_CLASS(klass);
> +    bc->realize = opb_realize;
> +}
> +
> +static const TypeInfo opb_info = {
> +    .name = TYPE_OP_BUS,
> +    .parent = TYPE_BUS,
> +    .instance_init = opb_init,
> +    .instance_finalize = opb_finalize,
> +    .instance_size = sizeof(OPBus),
> +    .class_init = opb_class_init,
> +    .class_size = sizeof(OPBusClass),
> +};
> +
> +static void opb_register_types(void)
> +{
> +    type_register_static(&opb_info);
> +}
> +
> +type_init(opb_register_types);
> diff --git a/hw/fsi/Kconfig b/hw/fsi/Kconfig
> index 8d712e77ed..0f6e6d331a 100644
> --- a/hw/fsi/Kconfig
> +++ b/hw/fsi/Kconfig
> @@ -1,3 +1,7 @@
> +config FSI_OPB
> +    bool
> +    select FSI_CFAM
> +
>   config FSI_CFAM
>       bool
>       select FSI
> diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
> index f617943b4a..407b8c2775 100644
> --- a/hw/fsi/meson.build
> +++ b/hw/fsi/meson.build
> @@ -2,3 +2,4 @@ system_ss.add(when: 'CONFIG_FSI_LBUS', if_true: files('lbus.c'))
>   system_ss.add(when: 'CONFIG_FSI_SCRATCHPAD', if_true: files('engine-scratchpad.c'))
>   system_ss.add(when: 'CONFIG_FSI_CFAM', if_true: files('cfam.c'))
>   system_ss.add(when: 'CONFIG_FSI', if_true: files('fsi.c','fsi-master.c','fsi-slave.c'))
> +system_ss.add(when: 'CONFIG_FSI_OPB', if_true: files('opb.c'))
> diff --git a/hw/fsi/trace-events b/hw/fsi/trace-events
> index d7afef0460..ec9bab2fe8 100644
> --- a/hw/fsi/trace-events
> +++ b/hw/fsi/trace-events
> @@ -9,3 +9,5 @@ fsi_slave_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
>   fsi_slave_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
>   fsi_master_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
>   fsi_master_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
> +opb_unimplemented_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
> +opb_unimplemented_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64


