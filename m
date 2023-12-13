Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBDB80EF4C
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 15:49:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD44i-00016X-Un; Tue, 12 Dec 2023 09:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=DDG+=HX=kaod.org=clg@ozlabs.org>)
 id 1rD44f-0000yE-SP; Tue, 12 Dec 2023 09:49:29 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=DDG+=HX=kaod.org=clg@ozlabs.org>)
 id 1rD44d-0004Ul-D0; Tue, 12 Dec 2023 09:49:29 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SqM2W6fFBz4xS7;
 Wed, 13 Dec 2023 01:49:23 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SqM2N63dbz4xNH;
 Wed, 13 Dec 2023 01:49:16 +1100 (AEDT)
Message-ID: <4b0a1cea-5a51-46aa-83ff-144b498a7556@kaod.org>
Date: Tue, 12 Dec 2023 15:49:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: [PATCH v8 05/10] hw/fsi: Introduce IBM's FSI master
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20231128235700.599584-1-ninad@linux.ibm.com>
 <20231128235700.599584-6-ninad@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20231128235700.599584-6-ninad@linux.ibm.com>
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
> This commit models the FSI master. CFAM is hanging out of FSI master which is a bus controller.
> 
> The FSI master: A controller in the platform service processor (e.g.
> BMC) driving CFAM engine accesses into the POWER chip. At the
> hardware level FSI is a bit-based protocol supporting synchronous and
> DMA-driven accesses of engines in a CFAM.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> [ clg: - move FSICFAMState object under FSIMasterState
>         - introduced fsi_master_init()
>         - reworked fsi_master_realize()
>         - dropped FSIBus definition ]
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   include/hw/fsi/fsi-master.h |  32 +++++++
>   hw/fsi/fsi-master.c         | 165 ++++++++++++++++++++++++++++++++++++
>   hw/fsi/meson.build          |   2 +-
>   hw/fsi/trace-events         |   2 +
>   4 files changed, 200 insertions(+), 1 deletion(-)
>   create mode 100644 include/hw/fsi/fsi-master.h
>   create mode 100644 hw/fsi/fsi-master.c
> 
> diff --git a/include/hw/fsi/fsi-master.h b/include/hw/fsi/fsi-master.h
> new file mode 100644
> index 0000000000..3830869877
> --- /dev/null
> +++ b/include/hw/fsi/fsi-master.h
> @@ -0,0 +1,32 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2019 IBM Corp.
> + *
> + * IBM Flexible Service Interface Master
> + */
> +#ifndef FSI_FSI_MASTER_H
> +#define FSI_FSI_MASTER_H
> +
> +#include "exec/memory.h"
> +#include "hw/qdev-core.h"
> +#include "hw/fsi/fsi.h"
> +#include "hw/fsi/cfam.h"
> +
> +#define TYPE_FSI_MASTER "fsi.master"
> +OBJECT_DECLARE_SIMPLE_TYPE(FSIMasterState, FSI_MASTER)
> +
> +#define FSI_MASTER_NR_REGS ((0x2e0 >> 2) + 1)
> +
> +typedef struct FSIMasterState {
> +    DeviceState parent;
> +    MemoryRegion iomem;
> +    MemoryRegion opb2fsi;
> +
> +    FSIBus bus;
> +
> +    uint32_t regs[FSI_MASTER_NR_REGS];
> +    FSICFAMState cfam;
> +} FSIMasterState;
> +
> +
> +#endif /* FSI_FSI_H */
> diff --git a/hw/fsi/fsi-master.c b/hw/fsi/fsi-master.c
> new file mode 100644
> index 0000000000..fb80976bc3
> --- /dev/null
> +++ b/hw/fsi/fsi-master.c
> @@ -0,0 +1,165 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM Flexible Service Interface master
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +#include "trace.h"
> +
> +#include "hw/fsi/fsi-master.h"
> +
> +#define TYPE_OP_BUS "opb"
> +
> +#define TO_REG(x)                               ((x) >> 2)
> +
> +#define FSI_MENP0                               TO_REG(0x010)
> +#define FSI_MENP32                              TO_REG(0x014)
> +#define FSI_MSENP0                              TO_REG(0x018)
> +#define FSI_MLEVP0                              TO_REG(0x018)
> +#define FSI_MSENP32                             TO_REG(0x01c)
> +#define FSI_MLEVP32                             TO_REG(0x01c)
> +#define FSI_MCENP0                              TO_REG(0x020)
> +#define FSI_MREFP0                              TO_REG(0x020)
> +#define FSI_MCENP32                             TO_REG(0x024)
> +#define FSI_MREFP32                             TO_REG(0x024)
> +
> +#define FSI_MVER                                TO_REG(0x074)
> +#define FSI_MRESP0                              TO_REG(0x0d0)
> +
> +#define FSI_MRESB0                              TO_REG(0x1d0)
> +#define   FSI_MRESB0_RESET_GENERAL              BE_BIT(0)
> +#define   FSI_MRESB0_RESET_ERROR                BE_BIT(1)
> +
> +static uint64_t fsi_master_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    FSIMasterState *s = FSI_MASTER(opaque);
> +
> +    trace_fsi_master_read(addr, size);
> +
> +    if (addr + size > sizeof(s->regs)) {

See comment on patch 3

> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out of bounds read: 0x%"HWADDR_PRIx" for %u\n",
> +                      __func__, addr, size);
> +        return 0;
> +    }
> +
> +    return s->regs[TO_REG(addr)];
> +}
> +
> +static void fsi_master_write(void *opaque, hwaddr addr, uint64_t data,
> +                             unsigned size)
> +{
> +    FSIMasterState *s = FSI_MASTER(opaque);
> +
> +    trace_fsi_master_write(addr, size, data);
> +
> +    if (addr + size > sizeof(s->regs)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out of bounds write: %"HWADDR_PRIx" for %u\n",
> +                      __func__, addr, size);
> +        return;
> +    }
> +
> +    switch (TO_REG(addr)) {
> +    case FSI_MENP0:
> +        s->regs[FSI_MENP0] = data;
> +        break;
> +    case FSI_MENP32:
> +        s->regs[FSI_MENP32] = data;
> +        break;
> +    case FSI_MSENP0:
> +        s->regs[FSI_MENP0] |= data;
> +        break;
> +    case FSI_MSENP32:
> +        s->regs[FSI_MENP32] |= data;
> +        break;
> +    case FSI_MCENP0:
> +        s->regs[FSI_MENP0] &= ~data;
> +        break;
> +    case FSI_MCENP32:
> +        s->regs[FSI_MENP32] &= ~data;
> +        break;
> +    case FSI_MRESP0:
> +        /* Perform necessary resets leave register 0 to indicate no errors */
> +        break;
> +    case FSI_MRESB0:
> +        if (data & FSI_MRESB0_RESET_GENERAL) {
> +            device_cold_reset(DEVICE(opaque));
> +        }
> +        if (data & FSI_MRESB0_RESET_ERROR) {
> +            /* FIXME: this seems dubious */
> +            device_cold_reset(DEVICE(opaque));
> +        }
> +        break;
> +    default:
> +        s->regs[TO_REG(addr)] = data;
> +    }
> +}
> +
> +static const struct MemoryRegionOps fsi_master_ops = {
> +    .read = fsi_master_read,
> +    .write = fsi_master_write,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +};
> +
> +static void fsi_master_init(Object *o)
> +{
> +    FSIMasterState *s = FSI_MASTER(o);
> +
> +    object_initialize_child(o, "cfam", &s->cfam, TYPE_FSI_CFAM);
> +
> +    qbus_init(&s->bus, sizeof(s->bus), TYPE_FSI_BUS, DEVICE(s), NULL);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &fsi_master_ops, s,
> +                          TYPE_FSI_MASTER, 0x10000000);
> +    memory_region_init(&s->opb2fsi, OBJECT(s), "fsi.opb2fsi", 0x10000000);
> +}
> +
> +static void fsi_master_realize(DeviceState *dev, Error **errp)
> +{
> +    FSIMasterState *s = FSI_MASTER(dev);
> +
> +    if (!qdev_realize(DEVICE(&s->cfam), BUS(&s->bus), errp)) {
> +        return;
> +    }
> +
> +    /* address ? */
> +    memory_region_add_subregion(&s->opb2fsi, 0, &s->cfam.mr);
> +}
> +
> +static void fsi_master_reset(DeviceState *dev)
> +{
> +    FSIMasterState *s = FSI_MASTER(dev);

Don't we want to set all values to some default ?


Thanks,

C.


  
> +    /* ASPEED default */
> +    s->regs[FSI_MVER] = 0xe0050101;
> +}
> +
> +static void fsi_master_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->bus_type = TYPE_OP_BUS;
> +    dc->desc = "FSI Master";
> +    dc->realize = fsi_master_realize;
> +    dc->reset = fsi_master_reset;
> +}
> +
> +static const TypeInfo fsi_master_info = {
> +    .name = TYPE_FSI_MASTER,
> +    .parent = TYPE_DEVICE,
> +    .instance_init = fsi_master_init,
> +    .instance_size = sizeof(FSIMasterState),
> +    .class_init = fsi_master_class_init,
> +};
> +
> +static void fsi_register_types(void)
> +{
> +    type_register_static(&fsi_master_info);
> +}
> +
> +type_init(fsi_register_types);
> diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
> index ba92881370..038c4468ee 100644
> --- a/hw/fsi/meson.build
> +++ b/hw/fsi/meson.build
> @@ -1,4 +1,4 @@
>   system_ss.add(when: 'CONFIG_FSI_LBUS', if_true: files('lbus.c'))
>   system_ss.add(when: 'CONFIG_FSI_CFAM', if_true: files('cfam.c'))
> -system_ss.add(when: 'CONFIG_FSI', if_true: files('fsi.c','fsi-slave.c'))
> +system_ss.add(when: 'CONFIG_FSI', if_true: files('fsi.c','fsi-master.c','fsi-slave.c'))
>   system_ss.add(when: 'CONFIG_FSI_OPB', if_true: files('opb.c'))
> diff --git a/hw/fsi/trace-events b/hw/fsi/trace-events
> index b57b2dcc86..89d8cd62c8 100644
> --- a/hw/fsi/trace-events
> +++ b/hw/fsi/trace-events
> @@ -7,3 +7,5 @@ fsi_cfam_unimplemented_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%"
>   fsi_cfam_config_write_noaddr(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
>   fsi_slave_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
>   fsi_slave_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
> +fsi_master_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
> +fsi_master_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64


