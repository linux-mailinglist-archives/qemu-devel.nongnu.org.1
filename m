Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3982A79A7EB
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 14:30:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfg3J-0001xI-88; Mon, 11 Sep 2023 08:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=62xJ=E3=kaod.org=clg@ozlabs.org>)
 id 1qfg3G-0001lT-Qy; Mon, 11 Sep 2023 08:30:02 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=62xJ=E3=kaod.org=clg@ozlabs.org>)
 id 1qfg3A-0002Pr-5h; Mon, 11 Sep 2023 08:30:02 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RkmHx6KMKz4xGR;
 Mon, 11 Sep 2023 22:29:49 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RkmHt2HMhz4x7V;
 Mon, 11 Sep 2023 22:29:46 +1000 (AEST)
Message-ID: <d82f227d-834c-1302-cf0b-11e06d09ec29@kaod.org>
Date: Mon, 11 Sep 2023 14:29:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 05/10] hw/fsi: IBM's On-chip Peripheral Bus
Content-Language: en-US
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@aj.id.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org
References: <20230908222859.3381003-1-ninad@linux.ibm.com>
 <20230908222859.3381003-6-ninad@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230908222859.3381003-6-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=62xJ=E3=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.473, SPF_HELO_PASS=-0.001,
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
> ---
>   hw/fsi/Kconfig       |   4 +
>   hw/fsi/fsi-master.c  |   6 +-
>   hw/fsi/meson.build   |   1 +
>   hw/fsi/opb.c         | 194 +++++++++++++++++++++++++++++++++++++++++++
>   include/hw/fsi/opb.h |  43 ++++++++++
>   5 files changed, 244 insertions(+), 4 deletions(-)
>   create mode 100644 hw/fsi/opb.c
>   create mode 100644 include/hw/fsi/opb.h
> 
> diff --git a/hw/fsi/Kconfig b/hw/fsi/Kconfig
> index 087980be22..560ce536db 100644
> --- a/hw/fsi/Kconfig
> +++ b/hw/fsi/Kconfig
> @@ -1,3 +1,7 @@
> +config OPB
> +    bool
> +    select CFAM
> +
>   config CFAM
>       bool
>       select FSI
> diff --git a/hw/fsi/fsi-master.c b/hw/fsi/fsi-master.c
> index fe1693539a..46103f84e9 100644
> --- a/hw/fsi/fsi-master.c
> +++ b/hw/fsi/fsi-master.c
> @@ -7,14 +7,12 @@
>   
>   #include "qemu/osdep.h"
>   
> +#include "qemu/bitops.h"
>   #include "qapi/error.h"
> -
>   #include "qemu/log.h"
>   
> -#include "hw/fsi/bits.h"
>   #include "hw/fsi/fsi-master.h"
> -
> -#define TYPE_OP_BUS "opb"
> +#include "hw/fsi/opb.h"
>   
>   #define TO_REG(x)                               ((x) >> 2)


These change do not belong to this patch.

> diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
> index ca80d11cb9..cab645f4ea 100644
> --- a/hw/fsi/meson.build
> +++ b/hw/fsi/meson.build
> @@ -2,3 +2,4 @@ system_ss.add(when: 'CONFIG_LBUS', if_true: files('lbus.c'))
>   system_ss.add(when: 'CONFIG_SCRATCHPAD', if_true: files('engine-scratchpad.c'))
>   system_ss.add(when: 'CONFIG_CFAM', if_true: files('cfam.c'))
>   system_ss.add(when: 'CONFIG_FSI', if_true: files('fsi.c','fsi-master.c','fsi-slave.c'))
> +system_ss.add(when: 'CONFIG_OPB', if_true: files('opb.c'))
> diff --git a/hw/fsi/opb.c b/hw/fsi/opb.c
> new file mode 100644
> index 0000000000..ac7693c001
> --- /dev/null
> +++ b/hw/fsi/opb.c
> @@ -0,0 +1,194 @@
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
> +
> +#include "hw/fsi/opb.h"
> +
> +static MemTxResult opb_read(OPBus *opb, hwaddr addr, void *data, size_t len)
> +{
> +    return address_space_read(&opb->as, addr, MEMTXATTRS_UNSPECIFIED, data,
> +                              len);
> +}

This routine doesn't look very useful. Same for the write.

> +
> +uint8_t opb_read8(OPBus *opb, hwaddr addr)
> +{
> +    MemTxResult tx;
> +    uint8_t data;
> +
> +    tx = opb_read(opb, addr, &data, sizeof(data));
> +    /* FIXME: improve error handling */
> +    assert(!tx);

should output a qemu_log_mask(LOG_GUEST_ERROR) may be ? But I don't think
we should assert.

> +
> +    return data;
> +}
> +
> +uint16_t opb_read16(OPBus *opb, hwaddr addr)
> +{
> +    MemTxResult tx;
> +    uint16_t data;
> +
> +    tx = opb_read(opb, addr, &data, sizeof(data));
> +    /* FIXME: improve error handling */
> +    assert(!tx);

same

> +
> +    return data;
> +}
> +
> +uint32_t opb_read32(OPBus *opb, hwaddr addr)
> +{
> +    MemTxResult tx;
> +    uint32_t data;
> +
> +    tx = opb_read(opb, addr, &data, sizeof(data));
> +    /* FIXME: improve error handling */
> +    assert(!tx);
> +
> +    return data;
> +}
> +
> +static MemTxResult opb_write(OPBus *opb, hwaddr addr, void *data, size_t len)
> +{
> +    return address_space_write(&opb->as, addr, MEMTXATTRS_UNSPECIFIED, data,
> +                               len);
> +}
> +
> +void opb_write8(OPBus *opb, hwaddr addr, uint8_t data)
> +{
> +    MemTxResult tx;
> +
> +    tx = opb_write(opb, addr, &data, sizeof(data));
> +    /* FIXME: improve error handling */
> +    assert(!tx);
> +}
> +
> +void opb_write16(OPBus *opb, hwaddr addr, uint16_t data)
> +{
> +    MemTxResult tx;
> +
> +    tx = opb_write(opb, addr, &data, sizeof(data));
> +    /* FIXME: improve error handling */
> +    assert(!tx);
> +}
> +
> +void opb_write32(OPBus *opb, hwaddr addr, uint32_t data)
> +{
> +    MemTxResult tx;
> +
> +    tx = opb_write(opb, addr, &data, sizeof(data));
> +    /* FIXME: improve error handling */
> +    assert(!tx);
> +}
> +
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
> +
> +static uint64_t opb_unimplemented_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s: read @0x%" HWADDR_PRIx " size=%d\n",
> +                  __func__, addr, size);
> +
> +    return 0;
> +}
> +
> +static void opb_unimplemented_write(void *opaque, hwaddr addr, uint64_t data,
> +                                 unsigned size)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s: write @0x%" HWADDR_PRIx " size=%d "
> +                  "value=%"PRIx64"\n", __func__, addr, size, data);
> +}
> +
> +static const struct MemoryRegionOps opb_unimplemented_ops = {
> +    .read = opb_unimplemented_read,
> +    .write = opb_unimplemented_write,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +};
> +
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
> +}
> +
> +static void opb_finalize(Object *o)
> +{
> +    OPBus *opb = OP_BUS(o);
> +
> +    address_space_destroy(&opb->as);
> +}
> +
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


