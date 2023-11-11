Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4047E8BCC
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 18:09:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1rT8-0003rD-26; Sat, 11 Nov 2023 12:08:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=UdCb=GY=kaod.org=clg@ozlabs.org>)
 id 1r1rT6-0003qj-E2; Sat, 11 Nov 2023 12:08:24 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=UdCb=GY=kaod.org=clg@ozlabs.org>)
 id 1r1rT3-0005xw-UE; Sat, 11 Nov 2023 12:08:24 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SSMb36XFHz4xGQ;
 Sun, 12 Nov 2023 04:08:15 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SSMZw2TLbz4x5s;
 Sun, 12 Nov 2023 04:08:07 +1100 (AEDT)
Message-ID: <cc07a0be-9e75-460b-8ade-95c32cc2d98f@kaod.org>
Date: Sat, 11 Nov 2023 18:08:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] hw/ppc: Add pnv pervasive common chiplet units
Content-Language: en-US
To: qemu-devel@nongnu.org, Chalapathi V <chalapathi.v@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 calebs@us.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.vnet.ibm.com,
 Chalapathi V <chalapathi.v@linux.ibm.com>
References: <20231107074127.31821-1-chalap1@gfwr516.rchland.ibm.com>
 <20231107074127.31821-2-chalap1@gfwr516.rchland.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231107074127.31821-2-chalap1@gfwr516.rchland.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=UdCb=GY=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hello Chalapathi,

Please add to your ~/.gitconfig :

   [diff]
	  orderFile = /path/to/qemu/scripts/git.orderfile

It will order the header file first in the patch.

On 11/7/23 08:41, Chalapathi V wrote:
> From: Chalapathi V <chalapathi.v@linux.ibm.com>
> 
> This part of the patchset creates a common pervasive chiplet model where it
> houses the common units of a chiplets.
> 
> The chiplet control unit is common across chiplets and this commit implements
> the pervasive chiplet model with chiplet control registers.
> 
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>   hw/ppc/meson.build             |   1 +
>   hw/ppc/pnv_pervasive.c         | 213 +++++++++++++++++++++++++++++++++++++++++
>   include/hw/ppc/pnv_pervasive.h |  39 ++++++++
>   include/hw/ppc/pnv_xscom.h     |   3 +
>   4 files changed, 256 insertions(+)
>   create mode 100644 hw/ppc/pnv_pervasive.c
>   create mode 100644 include/hw/ppc/pnv_pervasive.h
> 
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index 7c2c524..c80d2f6 100644
> --- a/hw/ppc/meson.build
> +++ b/hw/ppc/meson.build
> @@ -50,6 +50,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
>     'pnv_bmc.c',
>     'pnv_homer.c',
>     'pnv_pnor.c',
> +  'pnv_pervasive.c',
>   ))
>   # PowerPC 4xx boards
>   ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
> diff --git a/hw/ppc/pnv_pervasive.c b/hw/ppc/pnv_pervasive.c
> new file mode 100644
> index 0000000..40f60b5
> --- /dev/null
> +++ b/hw/ppc/pnv_pervasive.c
> @@ -0,0 +1,213 @@
> +/*
> + * QEMU PowerPC pervasive common chiplet model
> + *
> + * Copyright (c) 2023, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/ppc/pnv.h"
> +#include "hw/ppc/pnv_xscom.h"
> +#include "hw/ppc/pnv_pervasive.h"
> +#include "hw/ppc/fdt.h"
> +#include <libfdt.h>
> +
> +#define CPLT_CONF0               0x08
> +#define CPLT_CONF0_OR            0x18
> +#define CPLT_CONF0_CLEAR         0x28
> +#define CPLT_CONF1               0x09
> +#define CPLT_CONF1_OR            0x19
> +#define CPLT_CONF1_CLEAR         0x29
> +#define CPLT_STAT0               0x100
> +#define CPLT_MASK0               0x101
> +#define CPLT_PROTECT_MODE        0x3FE
> +#define CPLT_ATOMIC_CLOCK        0x3FF
> +
> +static uint64_t pnv_chiplet_ctrl_read(void *opaque, hwaddr addr,
> +                                 unsigned size)
> +{
> +    PnvPervChiplet *perv_chiplet = PNV_PERVCHIPLET(opaque);
> +    int reg = addr >> 3;
> +    uint64_t val = ~0ull;

White line please

> +    /* CPLT_CTRL0 to CPLT_CTRL5 */
> +    for (int i = 0; i <= 5; i++) {

I would introduce a #define for this "5" value, and use it in ControlRegs also.

> +        if (reg == i) {
> +            val = perv_chiplet->control_regs.cplt_ctrl[i];
> +            return val;

or may be :

        return perv_chiplet->control_regs.cplt_ctrl[i];  ?
  

> +        } else if ((reg == (i + 0x10)) || (reg == (i + 0x20))) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
> +                                           "xscom read at 0x%" PRIx64 "\n",
> +                                           __func__, (unsigned long)reg);
> +            return val;
> +        }
> +    }
> +
> +    switch (reg) {
> +    case CPLT_CONF0:
> +        val = perv_chiplet->control_regs.cplt_cfg0;
> +        break;
> +    case CPLT_CONF0_OR:
> +    case CPLT_CONF0_CLEAR:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
> +                                   "xscom read at 0x%" PRIx64 "\n",
> +                                   __func__, (unsigned long)reg);
> +        break;
> +    case CPLT_CONF1:
> +        val = perv_chiplet->control_regs.cplt_cfg1;
> +        break;
> +    case CPLT_CONF1_OR:
> +    case CPLT_CONF1_CLEAR:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
> +                                   "xscom read at 0x%" PRIx64 "\n",
> +                                   __func__, (unsigned long)reg);
> +        break;
> +    case CPLT_STAT0:
> +        val = perv_chiplet->control_regs.cplt_stat0;
> +        break;
> +    case CPLT_MASK0:
> +        val = perv_chiplet->control_regs.cplt_mask0;
> +        break;
> +    case CPLT_PROTECT_MODE:
> +        val = perv_chiplet->control_regs.ctrl_protect_mode;
> +        break;
> +    case CPLT_ATOMIC_CLOCK:
> +        val = perv_chiplet->control_regs.ctrl_atomic_lock;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: Chiplet_control_regs: Invalid xscom "
> +                 "read at 0x%" PRIx64 "\n", __func__, (unsigned long)reg);
> +    }
> +    return val;
> +}
> +
> +static void pnv_chiplet_ctrl_write(void *opaque, hwaddr addr,
> +                                 uint64_t val, unsigned size)
> +{
> +    PnvPervChiplet *perv_chiplet = PNV_PERVCHIPLET(opaque);
> +    int reg = addr >> 3;
> +    /* CPLT_CTRL0 to CPLT_CTRL5 */
> +    for (int i = 0; i <= 5; i++) {
> +        if (reg == i) {
> +            perv_chiplet->control_regs.cplt_ctrl[i] = val;
> +            return;
> +        } else if (reg == (i + 0x10)) {
> +            perv_chiplet->control_regs.cplt_ctrl[i] |= val;
> +            return;
> +        } else if (reg == (i + 0x20)) {
> +            perv_chiplet->control_regs.cplt_ctrl[i] &= ~val;
> +            return;
> +        }
> +    }
> +
> +    switch (reg) {
> +    case CPLT_CONF0:
> +        perv_chiplet->control_regs.cplt_cfg0 = val;
> +        break;
> +    case CPLT_CONF0_OR:
> +        perv_chiplet->control_regs.cplt_cfg0 |= val;
> +        break;
> +    case CPLT_CONF0_CLEAR:
> +        perv_chiplet->control_regs.cplt_cfg0 &= ~val;
> +        break;
> +    case CPLT_CONF1:
> +        perv_chiplet->control_regs.cplt_cfg1 = val;
> +        break;
> +    case CPLT_CONF1_OR:
> +        perv_chiplet->control_regs.cplt_cfg1 |= val;
> +        break;
> +    case CPLT_CONF1_CLEAR:
> +        perv_chiplet->control_regs.cplt_cfg1 &= ~val;
> +        break;
> +    case CPLT_STAT0:
> +        perv_chiplet->control_regs.cplt_stat0 = val;
> +        break;
> +    case CPLT_MASK0:
> +        perv_chiplet->control_regs.cplt_mask0 = val;
> +        break;
> +    case CPLT_PROTECT_MODE:
> +        perv_chiplet->control_regs.ctrl_protect_mode = val;
> +        break;
> +    case CPLT_ATOMIC_CLOCK:
> +        perv_chiplet->control_regs.ctrl_atomic_lock = val;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: Chiplet_control_regs: Invalid xscom "
> +                                 "write at 0x%" PRIx64 "\n",
> +                                 __func__, (unsigned long)reg);
> +    }
> +    return;

This return is useless.

> +}
> +
> +static const MemoryRegionOps pnv_perv_chiplet_control_xscom_ops = {
> +    .read = pnv_chiplet_ctrl_read,
> +    .write = pnv_chiplet_ctrl_write,
> +    .valid.min_access_size = 8,
> +    .valid.max_access_size = 8,
> +    .impl.min_access_size = 8,
> +    .impl.max_access_size = 8,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +};
> +
> +static void pnv_perv_chiplet_realize(DeviceState *dev, Error **errp)
> +{
> +    PnvPervChiplet *perv_chiplet = PNV_PERVCHIPLET(dev);
> +
> +    /* Chiplet control scoms */
> +    pnv_xscom_region_init(&perv_chiplet->xscom_perv_ctrl_regs,
> +                          OBJECT(perv_chiplet),
> +                          &pnv_perv_chiplet_control_xscom_ops,
> +                          perv_chiplet, "xscom-chiplet-control-regs",
> +                          PNV10_XSCOM_CTRL_CHIPLET_SIZE);
> +}
> +
> +void pnv_perv_dt(uint32_t base_addr, void *fdt,
> +                             int offset)
> +{
> +    g_autofree char *name = NULL;
> +    int perv_chiplet_offset;
> +
> +    const char compat[] = "ibm,power10-perv-chiplet";
> +    uint32_t reg[] = {
> +        base_addr,
> +        cpu_to_be32(PNV10_XSCOM_CTRL_CHIPLET_SIZE)
> +    };
> +    name = g_strdup_printf("perv_chiplet@%x", base_addr);
> +    perv_chiplet_offset = fdt_add_subnode(fdt, offset, name);
> +    _FDT(perv_chiplet_offset);
> +
> +    _FDT(fdt_setprop(fdt, perv_chiplet_offset, "reg", reg, sizeof(reg)));
> +    _FDT(fdt_setprop(fdt, perv_chiplet_offset, "compatible",
> +                     compat, sizeof(compat)));
> +}
> +
> +static void pnv_perv_chiplet_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "PowerNV perv chiplet";
> +    dc->realize = pnv_perv_chiplet_realize;
> +}
> +
> +static const TypeInfo pnv_perv_chiplet_info = {
> +    .name          = TYPE_PNV_PERV_CHIPLET,
> +    .parent        = TYPE_DEVICE,
> +    .instance_size = sizeof(PnvPervChiplet),
> +    .class_init    = pnv_perv_chiplet_class_init,
> +    .interfaces    = (InterfaceInfo[]) {
> +        { TYPE_PNV_XSCOM_INTERFACE },
> +        { }
> +    }
> +};
> +
> +static void pnv_perv_chiplet_register_types(void)
> +{
> +    type_register_static(&pnv_perv_chiplet_info);
> +}
> +
> +type_init(pnv_perv_chiplet_register_types);
> diff --git a/include/hw/ppc/pnv_pervasive.h b/include/hw/ppc/pnv_pervasive.h
> new file mode 100644
> index 0000000..61be4cf
> --- /dev/null
> +++ b/include/hw/ppc/pnv_pervasive.h
> @@ -0,0 +1,39 @@
> +/*
> + * QEMU PowerPC pervasive common chiplet model
> + *
> + * Copyright (c) 2023, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + */
> +
> +#ifndef PPC_PNV_PERVASIVE_H
> +#define PPC_PNV_PERVASIVE_H
> +
> +#define TYPE_PNV_PERV_CHIPLET "pnv-pervasive-chiplet"
> +#define PNV_PERVCHIPLET(obj) OBJECT_CHECK(PnvPervChiplet, (obj), TYPE_PNV_PERV_CHIPLET)
> +
> +typedef struct ControlRegs {

This needs some prefix : PnvPervChipletRegs ?

> +

Please remove the extra white line.
  
> +    uint64_t cplt_ctrl[6];

Introduce a #define since you need it in the memops.

> +    uint64_t cplt_cfg0;
> +    uint64_t cplt_cfg1;
> +    uint64_t cplt_stat0;
> +    uint64_t cplt_mask0;
> +    uint64_t ctrl_protect_mode;
> +    uint64_t ctrl_atomic_lock;
> +} ControlRegs;
> +
> +typedef struct PnvPervChiplet {
> +
> +    DeviceState parent;
> +    struct PnvChip *chip;

chip is unused, please remove.

> +    MemoryRegion xscom_perv_ctrl_regs;
> +    ControlRegs control_regs;
> +

Drop white line.


> +} PnvPervChiplet;
> +
> +void pnv_perv_dt(uint32_t base, void *fdt, int offset);
> +#endif /*PPC_PNV_PERVASIVE_H */
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index 35b1961..87bbee8 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -164,6 +164,9 @@ struct PnvXScomInterfaceClass {
>   #define PNV10_XSCOM_XIVE2_BASE     0x2010800
>   #define PNV10_XSCOM_XIVE2_SIZE     0x400
>   
> +#define PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE      0x3000000
> +#define PNV10_XSCOM_CTRL_CHIPLET_SIZE            0x400
> +
>   #define PNV10_XSCOM_PEC_NEST_BASE  0x3011800 /* index goes downwards ... */
>   #define PNV10_XSCOM_PEC_NEST_SIZE  0x100
>   


