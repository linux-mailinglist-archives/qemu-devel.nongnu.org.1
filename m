Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FD280EF4D
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 15:50:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD45S-0001fV-Qg; Tue, 12 Dec 2023 09:50:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=DDG+=HX=kaod.org=clg@ozlabs.org>)
 id 1rD45A-0001R1-8f; Tue, 12 Dec 2023 09:50:00 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=DDG+=HX=kaod.org=clg@ozlabs.org>)
 id 1rD457-0004Yr-M2; Tue, 12 Dec 2023 09:50:00 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SqM372qmRz4xS9;
 Wed, 13 Dec 2023 01:49:55 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SqM306jHhz4xNH;
 Wed, 13 Dec 2023 01:49:48 +1100 (AEDT)
Message-ID: <9139c58e-4a76-4b13-a1da-c1aafc37fad2@kaod.org>
Date: Tue, 12 Dec 2023 15:49:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: [PATCH v8 06/10] hw/fsi: Aspeed APB2OPB interface
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20231128235700.599584-1-ninad@linux.ibm.com>
 <20231128235700.599584-7-ninad@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20231128235700.599584-7-ninad@linux.ibm.com>
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
> An APB-to-OPB bridge enabling access to the OPB from the ARM core in
> the AST2600. Hardware limitations prevent the OPB from being directly
> mapped into APB, so all accesses are indirect through the bridge.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> [ clg: - moved FSIMasterState under AspeedAPB2OPBState
>         - modified fsi_opb_fsi_master_address() and
>           fsi_opb_opb2fsi_address()
>         - instroduced fsi_aspeed_apb2opb_init()
>         - reworked fsi_aspeed_apb2opb_realize() ]
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   include/hw/fsi/aspeed-apb2opb.h |  34 ++++
>   hw/fsi/aspeed-apb2opb.c         | 316 ++++++++++++++++++++++++++++++++
>   hw/arm/Kconfig                  |   1 +
>   hw/fsi/Kconfig                  |   4 +
>   hw/fsi/meson.build              |   1 +
>   hw/fsi/trace-events             |   2 +
>   6 files changed, 358 insertions(+)
>   create mode 100644 include/hw/fsi/aspeed-apb2opb.h
>   create mode 100644 hw/fsi/aspeed-apb2opb.c
> 
> diff --git a/include/hw/fsi/aspeed-apb2opb.h b/include/hw/fsi/aspeed-apb2opb.h
> new file mode 100644
> index 0000000000..c51fbeda9f
> --- /dev/null
> +++ b/include/hw/fsi/aspeed-apb2opb.h
> @@ -0,0 +1,34 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * ASPEED APB2OPB Bridge
> + */
> +#ifndef FSI_ASPEED_APB2OPB_H
> +#define FSI_ASPEED_APB2OPB_H
> +
> +#include "hw/sysbus.h"
> +#include "hw/fsi/opb.h"
> +
> +#define TYPE_ASPEED_APB2OPB "aspeed.apb2opb"
> +OBJECT_DECLARE_SIMPLE_TYPE(AspeedAPB2OPBState, ASPEED_APB2OPB)
> +
> +#define ASPEED_APB2OPB_NR_REGS ((0xe8 >> 2) + 1)
> +
> +#define ASPEED_FSI_NUM 2
> +
> +typedef struct AspeedAPB2OPBState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    MemoryRegion iomem;
> +
> +    uint32_t regs[ASPEED_APB2OPB_NR_REGS];
> +    qemu_irq irq;
> +
> +    OPBus opb[ASPEED_FSI_NUM];
> +    FSIMasterState fsi[ASPEED_FSI_NUM];
> +} AspeedAPB2OPBState;
> +
> +#endif /* FSI_ASPEED_APB2OPB_H */
> diff --git a/hw/fsi/aspeed-apb2opb.c b/hw/fsi/aspeed-apb2opb.c
> new file mode 100644
> index 0000000000..70b3fe2587
> --- /dev/null
> +++ b/hw/fsi/aspeed-apb2opb.c
> @@ -0,0 +1,316 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * ASPEED APB-OPB FSI interface
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qom/object.h"
> +#include "qapi/error.h"
> +#include "trace.h"
> +
> +#include "hw/fsi/aspeed-apb2opb.h"
> +#include "hw/qdev-core.h"
> +
> +#define TO_REG(x) (x >> 2)
> +
> +#define APB2OPB_VERSION                    TO_REG(0x00)
> +#define APB2OPB_TRIGGER                    TO_REG(0x04)
> +
> +#define APB2OPB_CONTROL                    TO_REG(0x08)
> +#define   APB2OPB_CONTROL_OFF              BE_GENMASK(31, 13)
> +
> +#define APB2OPB_OPB2FSI                    TO_REG(0x0c)
> +#define   APB2OPB_OPB2FSI_OFF              BE_GENMASK(31, 22)
> +
> +#define APB2OPB_OPB0_SEL                   TO_REG(0x10)
> +#define APB2OPB_OPB1_SEL                   TO_REG(0x28)
> +#define   APB2OPB_OPB_SEL_EN               BIT(0)
> +
> +#define APB2OPB_OPB0_MODE                  TO_REG(0x14)
> +#define APB2OPB_OPB1_MODE                  TO_REG(0x2c)
> +#define   APB2OPB_OPB_MODE_RD              BIT(0)
> +
> +#define APB2OPB_OPB0_XFER                  TO_REG(0x18)
> +#define APB2OPB_OPB1_XFER                  TO_REG(0x30)
> +#define   APB2OPB_OPB_XFER_FULL            BIT(1)
> +#define   APB2OPB_OPB_XFER_HALF            BIT(0)
> +
> +#define APB2OPB_OPB0_ADDR                  TO_REG(0x1c)
> +#define APB2OPB_OPB0_WRITE_DATA            TO_REG(0x20)
> +
> +#define APB2OPB_OPB1_ADDR                  TO_REG(0x34)
> +#define APB2OPB_OPB1_WRITE_DATA                  TO_REG(0x38)
> +
> +#define APB2OPB_IRQ_STS                    TO_REG(0x48)
> +#define   APB2OPB_IRQ_STS_OPB1_TX_ACK      BIT(17)
> +#define   APB2OPB_IRQ_STS_OPB0_TX_ACK      BIT(16)
> +
> +#define APB2OPB_OPB0_WRITE_WORD_ENDIAN     TO_REG(0x4c)
> +#define   APB2OPB_OPB0_WRITE_WORD_ENDIAN_BE 0x0011101b
> +#define APB2OPB_OPB0_WRITE_BYTE_ENDIAN     TO_REG(0x50)
> +#define   APB2OPB_OPB0_WRITE_BYTE_ENDIAN_BE 0x0c330f3f
> +#define APB2OPB_OPB1_WRITE_WORD_ENDIAN     TO_REG(0x54)
> +#define APB2OPB_OPB1_WRITE_BYTE_ENDIAN     TO_REG(0x58)
> +#define APB2OPB_OPB0_READ_BYTE_ENDIAN      TO_REG(0x5c)
> +#define APB2OPB_OPB1_READ_BYTE_ENDIAN      TO_REG(0x60)
> +#define   APB2OPB_OPB0_READ_WORD_ENDIAN_BE  0x00030b1b
> +
> +#define APB2OPB_OPB0_READ_DATA         TO_REG(0x84)
> +#define APB2OPB_OPB1_READ_DATA         TO_REG(0x90)
> +
> +/*
> + * The following magic values came from AST2600 data sheet
> + * The register values are defined under section "FSI controller"
> + * as initial values.
> + */
> +static const uint32_t aspeed_apb2opb_reset[ASPEED_APB2OPB_NR_REGS] = {
> +     [APB2OPB_VERSION]                = 0x000000a1,
> +     [APB2OPB_OPB0_WRITE_WORD_ENDIAN] = 0x0044eee4,
> +     [APB2OPB_OPB0_WRITE_BYTE_ENDIAN] = 0x0055aaff,
> +     [APB2OPB_OPB1_WRITE_WORD_ENDIAN] = 0x00117717,
> +     [APB2OPB_OPB1_WRITE_BYTE_ENDIAN] = 0xffaa5500,
> +     [APB2OPB_OPB0_READ_BYTE_ENDIAN]  = 0x0044eee4,
> +     [APB2OPB_OPB1_READ_BYTE_ENDIAN]  = 0x00117717
> +};
> +
> +static void fsi_opb_fsi_master_address(OPBus *opb, FSIMasterState* fsi,
> +                                       hwaddr addr)

opb parameter is not useful anymore.

> +{
> +    memory_region_transaction_begin();
> +    memory_region_set_address(&fsi->iomem, addr);
> +    memory_region_transaction_commit();
> +}
> +
> +static void fsi_opb_opb2fsi_address(OPBus *opb, FSIMasterState* fsi,
> +                                    hwaddr addr)

same here.

> +{
> +    memory_region_transaction_begin();
> +    memory_region_set_address(&fsi->opb2fsi, addr);
> +    memory_region_transaction_commit();
> +}
> +
> +static uint64_t fsi_aspeed_apb2opb_read(void *opaque, hwaddr addr,
> +                                        unsigned size)
> +{
> +    AspeedAPB2OPBState *s = ASPEED_APB2OPB(opaque);
> +    unsigned int reg = TO_REG(addr);
> +
> +    trace_fsi_aspeed_apb2opb_read(addr, size);
> +
> +    if (reg >= ASPEED_APB2OPB_NR_REGS) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out of bounds read: 0x%"HWADDR_PRIx" for %u\n",
> +                      __func__, addr, size);
> +        return 0;
> +    }
> +
> +    return s->regs[reg];
> +}
> +
> +static void fsi_aspeed_apb2opb_write(void *opaque, hwaddr addr, uint64_t data,
> +                                     unsigned size)
> +{
> +    AspeedAPB2OPBState *s = ASPEED_APB2OPB(opaque);
> +    unsigned int reg = TO_REG(addr);
> +
> +    trace_fsi_aspeed_apb2opb_write(addr, size, data);
> +
> +    if (reg >= ASPEED_APB2OPB_NR_REGS) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out of bounds write: %"HWADDR_PRIx" for %u\n",
> +                      __func__, addr, size);
> +        return;
> +    }
> +
> +    switch (reg) {
> +    case APB2OPB_CONTROL:
> +        fsi_opb_fsi_master_address(&s->opb[0], &s->fsi[0],
> +                data & APB2OPB_CONTROL_OFF);
> +        break;
> +    case APB2OPB_OPB2FSI:
> +        fsi_opb_opb2fsi_address(&s->opb[0], &s->fsi[0],
> +                data & APB2OPB_OPB2FSI_OFF);
> +        break;
> +    case APB2OPB_OPB0_WRITE_WORD_ENDIAN:
> +        if (data != APB2OPB_OPB0_WRITE_WORD_ENDIAN_BE) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Bridge needs to be driven as BE (0x%x)\n",
> +                          __func__, APB2OPB_OPB0_WRITE_WORD_ENDIAN_BE);
> +        }
> +        break;
> +    case APB2OPB_OPB0_WRITE_BYTE_ENDIAN:
> +        if (data != APB2OPB_OPB0_WRITE_BYTE_ENDIAN_BE) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Bridge needs to be driven as BE (0x%x)\n",
> +                          __func__, APB2OPB_OPB0_WRITE_BYTE_ENDIAN_BE);
> +        }
> +        break;
> +    case APB2OPB_OPB0_READ_BYTE_ENDIAN:
> +        if (data != APB2OPB_OPB0_READ_WORD_ENDIAN_BE) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Bridge needs to be driven as BE (0x%x)\n",
> +                          __func__, APB2OPB_OPB0_READ_WORD_ENDIAN_BE);
> +        }
> +        break;
> +    case APB2OPB_TRIGGER:
> +    {
> +        uint32_t opb, op_mode, op_size, op_addr, op_data;
> +        MemTxResult result;
> +        bool is_write;
> +        int index;
> +        AddressSpace *as;
> +
> +        assert((s->regs[APB2OPB_OPB0_SEL] & APB2OPB_OPB_SEL_EN) ^
> +               (s->regs[APB2OPB_OPB1_SEL] & APB2OPB_OPB_SEL_EN));
> +
> +        if (s->regs[APB2OPB_OPB0_SEL] & APB2OPB_OPB_SEL_EN) {
> +            opb = 0;
> +            op_mode = s->regs[APB2OPB_OPB0_MODE];
> +            op_size = s->regs[APB2OPB_OPB0_XFER];
> +            op_addr = s->regs[APB2OPB_OPB0_ADDR];
> +            op_data = s->regs[APB2OPB_OPB0_WRITE_DATA];
> +        } else if (s->regs[APB2OPB_OPB1_SEL] & APB2OPB_OPB_SEL_EN) {
> +            opb = 1;
> +            op_mode = s->regs[APB2OPB_OPB1_MODE];
> +            op_size = s->regs[APB2OPB_OPB1_XFER];
> +            op_addr = s->regs[APB2OPB_OPB1_ADDR];
> +            op_data = s->regs[APB2OPB_OPB1_WRITE_DATA];
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Invalid operation: 0x%"HWADDR_PRIx" for %u\n",
> +                          __func__, addr, size);
> +            return;
> +        }
> +
> +        if (op_size & ~(APB2OPB_OPB_XFER_HALF | APB2OPB_OPB_XFER_FULL)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "OPB transaction failed: Unrecognized access width: %d\n",
> +                          op_size);
> +            return;
> +        }
> +
> +        op_size += 1;
> +        is_write = !(op_mode & APB2OPB_OPB_MODE_RD);
> +        index = opb ? APB2OPB_OPB1_READ_DATA : APB2OPB_OPB0_READ_DATA;
> +        as = &s->opb[opb].as;
> +
> +        result = address_space_rw(as, op_addr, MEMTXATTRS_UNSPECIFIED,
> +                                  &op_data, op_size, is_write);
> +        if (result != MEMTX_OK) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: OPB %s failed @%08x\n",
> +                          __func__, is_write ? "write" : "read", op_addr);
> +            return;
> +        }
> +
> +        if (!is_write) {
> +            s->regs[index] = op_data;
> +        }
> +
> +        s->regs[APB2OPB_IRQ_STS] |= opb ? APB2OPB_IRQ_STS_OPB1_TX_ACK
> +            : APB2OPB_IRQ_STS_OPB0_TX_ACK;
> +        break;
> +    }
> +    }
> +
> +    s->regs[reg] = data;
> +}
> +
> +static const struct MemoryRegionOps aspeed_apb2opb_ops = {
> +    .read = fsi_aspeed_apb2opb_read,
> +    .write = fsi_aspeed_apb2opb_write,
> +    .valid.max_access_size = 4,
> +    .valid.min_access_size = 4,
> +    .impl.max_access_size = 4,
> +    .impl.min_access_size = 4,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
> +static void fsi_aspeed_apb2opb_init(Object *o)
> +{
> +    AspeedAPB2OPBState *s = ASPEED_APB2OPB(o);
> +    int i;
> +
> +    for (i = 0; i < ASPEED_FSI_NUM; i++) {
> +        qbus_init(&s->opb[i], sizeof(s->opb[i]), TYPE_OP_BUS, DEVICE(s),
> +                  NULL);
> +    }
> +
> +    for (i = 0; i < ASPEED_FSI_NUM; i++) {
> +        object_initialize_child(o, "fsi-master[*]", &s->fsi[i],
> +                                TYPE_FSI_MASTER);
> +    }
> +}
> +
> +static void fsi_aspeed_apb2opb_realize(DeviceState *dev, Error **errp)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    AspeedAPB2OPBState *s = ASPEED_APB2OPB(dev);
> +    int i;
> +
> +    sysbus_init_irq(sbd, &s->irq);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_apb2opb_ops, s,
> +                          TYPE_ASPEED_APB2OPB, 0x1000);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +
> +    for (i = 0; i < ASPEED_FSI_NUM; i++) {
> +        if (!qdev_realize_and_unref(DEVICE(&s->fsi[i]), BUS(&s->opb[i]),


s->fsi[i] is not allocated. We should use qdev_realize instead.


Thanks,

C.



> +                errp)) {
> +            return;
> +        }
> +
> +        memory_region_add_subregion(&s->opb[i].mr, 0x80000000,
> +                &s->fsi[i].iomem);
> +
> +        /* OPB2FSI region */
> +        /*
> +         * Avoid endianness issues by mapping each slave's memory region
> +         * directly. Manually bridging multiple address-spaces causes endian
> +         * swapping headaches as memory_region_dispatch_read() and
> +         * memory_region_dispatch_write() correct the endianness based on the
> +         * target machine endianness and not relative to the device endianness
> +         * on either side of the bridge.
> +         */
> +        /*
> +         * XXX: This is a bit hairy and will need to be fixed when I sort out
> +         * the bus/slave relationship and any changes to the CFAM modelling
> +         * (multiple slaves, LBUS)
> +         */
> +        memory_region_add_subregion(&s->opb[i].mr, 0xa0000000,
> +                &s->fsi[i].opb2fsi);
> +    }
> +}
> +
> +static void fsi_aspeed_apb2opb_reset(DeviceState *dev)
> +{
> +    AspeedAPB2OPBState *s = ASPEED_APB2OPB(dev);
> +
> +    memcpy(s->regs, aspeed_apb2opb_reset, ASPEED_APB2OPB_NR_REGS);
> +}
> +
> +static void fsi_aspeed_apb2opb_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "ASPEED APB2OPB Bridge";
> +    dc->realize = fsi_aspeed_apb2opb_realize;
> +    dc->reset = fsi_aspeed_apb2opb_reset;
> +}
> +
> +static const TypeInfo aspeed_apb2opb_info = {
> +    .name = TYPE_ASPEED_APB2OPB,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_init = fsi_aspeed_apb2opb_init,
> +    .instance_size = sizeof(AspeedAPB2OPBState),
> +    .class_init = fsi_aspeed_apb2opb_class_init,
> +};
> +
> +static void aspeed_apb2opb_register_types(void)
> +{
> +    type_register_static(&aspeed_apb2opb_info);
> +}
> +
> +type_init(aspeed_apb2opb_register_types);
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 3ada335a24..0a3bc712a4 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -559,6 +559,7 @@ config ASPEED_SOC
>       select LED
>       select PMBUS
>       select MAX31785
> +    select FSI_APB2OPB_ASPEED
>   
>   config MPS2
>       bool
> diff --git a/hw/fsi/Kconfig b/hw/fsi/Kconfig
> index 9755baa8cc..9e92b07930 100644
> --- a/hw/fsi/Kconfig
> +++ b/hw/fsi/Kconfig
> @@ -1,3 +1,7 @@
> +config FSI_APB2OPB_ASPEED
> +    bool
> +    select FSI_OPB
> +
>   config FSI_OPB
>       bool
>       select FSI_CFAM
> diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
> index 038c4468ee..d0910627f9 100644
> --- a/hw/fsi/meson.build
> +++ b/hw/fsi/meson.build
> @@ -2,3 +2,4 @@ system_ss.add(when: 'CONFIG_FSI_LBUS', if_true: files('lbus.c'))
>   system_ss.add(when: 'CONFIG_FSI_CFAM', if_true: files('cfam.c'))
>   system_ss.add(when: 'CONFIG_FSI', if_true: files('fsi.c','fsi-master.c','fsi-slave.c'))
>   system_ss.add(when: 'CONFIG_FSI_OPB', if_true: files('opb.c'))
> +system_ss.add(when: 'CONFIG_FSI_APB2OPB_ASPEED', if_true: files('aspeed-apb2opb.c'))
> diff --git a/hw/fsi/trace-events b/hw/fsi/trace-events
> index 89d8cd62c8..3af4755995 100644
> --- a/hw/fsi/trace-events
> +++ b/hw/fsi/trace-events
> @@ -9,3 +9,5 @@ fsi_slave_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
>   fsi_slave_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
>   fsi_master_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
>   fsi_master_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
> +fsi_aspeed_apb2opb_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
> +fsi_aspeed_apb2opb_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64


