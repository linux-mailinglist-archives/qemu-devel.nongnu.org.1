Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7DD808243
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 08:59:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rB9H9-0008Lt-Fo; Thu, 07 Dec 2023 02:58:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=788X=HS=kaod.org=clg@ozlabs.org>)
 id 1rB9H6-0008I7-5E; Thu, 07 Dec 2023 02:58:24 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=788X=HS=kaod.org=clg@ozlabs.org>)
 id 1rB9H1-0004CX-I6; Thu, 07 Dec 2023 02:58:22 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Sm68C4678z4x3D;
 Thu,  7 Dec 2023 18:58:03 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sm6882LkXz4wnv;
 Thu,  7 Dec 2023 18:57:59 +1100 (AEDT)
Message-ID: <73e1ea3b-ae2a-41cd-8a00-f018fe0281d4@kaod.org>
Date: Thu, 7 Dec 2023 08:57:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] hw/ppc: Add pnv nest pervasive common chiplet model
To: Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 calebs@us.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.vnet.ibm.com
References: <20231207024331.5237-1-chalapathi.v@linux.ibm.com>
 <20231207024331.5237-2-chalapathi.v@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231207024331.5237-2-chalapathi.v@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=788X=HS=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 12/7/23 03:43, Chalapathi V wrote:
> A POWER10 chip is divided into logical pieces called chiplets. Chiplets
> are broadly divided into "core chiplets" (with the processor cores) and
> "nest chiplets" (with everything else). Each chiplet has an attachment
> to the pervasive bus (PIB) and with chiplet-specific registers. All nest
> chiplets have a common basic set of registers and This model will provide
> the registers functionality for common registers of nest chiplet (Pervasive
> Chiplet, PB Chiplet, PCI Chiplets, MC Chiplet, PAU Chiplets)
> 
> This commit implement the read/write functions of chiplet control registers.
> 
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>

Some minor comments below which would be nice to fix. Anyhow,

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   include/hw/ppc/pnv_nest_pervasive.h |  32 +++++
>   include/hw/ppc/pnv_xscom.h          |   3 +
>   hw/ppc/pnv_nest_pervasive.c         | 208 ++++++++++++++++++++++++++++
>   hw/ppc/meson.build                  |   1 +
>   4 files changed, 244 insertions(+)
>   create mode 100644 include/hw/ppc/pnv_nest_pervasive.h
>   create mode 100644 hw/ppc/pnv_nest_pervasive.c
> 
> diff --git a/include/hw/ppc/pnv_nest_pervasive.h b/include/hw/ppc/pnv_nest_pervasive.h
> new file mode 100644
> index 0000000000..270d84ff9d
> --- /dev/null
> +++ b/include/hw/ppc/pnv_nest_pervasive.h
> @@ -0,0 +1,32 @@
> +/*
> + * QEMU PowerPC nest pervasive common chiplet model
> + *
> + * Copyright (c) 2023, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef PPC_PNV_NEST_CHIPLET_PERVASIVE_H
> +#define PPC_PNV_NEST_CHIPLET_PERVASIVE_H
> +
> +#define TYPE_PNV_NEST_CHIPLET_PERVASIVE "pnv-nest-chiplet-pervasive"
> +#define PNV_NEST_CHIPLET_PERVASIVE(obj) OBJECT_CHECK(PnvNestChipletPervasive, (obj), TYPE_PNV_NEST_CHIPLET_PERVASIVE)
> +
> +typedef struct PnvPervasiveCtrlRegs {
> +#define CPLT_CTRL_SIZE 6
> +    uint64_t cplt_ctrl[CPLT_CTRL_SIZE];
> +    uint64_t cplt_cfg0;
> +    uint64_t cplt_cfg1;
> +    uint64_t cplt_stat0;
> +    uint64_t cplt_mask0;
> +    uint64_t ctrl_protect_mode;
> +    uint64_t ctrl_atomic_lock;
> +} PnvPervasiveCtrlRegs;
> +
> +typedef struct PnvNestChipletPervasive {
> +    DeviceState             parent;
> +    MemoryRegion            xscom_ctrl_regs_mr;
> +    PnvPervasiveCtrlRegs    control_regs;
> +} PnvNestChipletPervasive;
> +
> +#endif /*PPC_PNV_NEST_CHIPLET_PERVASIVE_H */
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index f5becbab41..3e15706dec 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -170,6 +170,9 @@ struct PnvXScomInterfaceClass {
>   #define PNV10_XSCOM_XIVE2_BASE     0x2010800
>   #define PNV10_XSCOM_XIVE2_SIZE     0x400
>   
> +#define PNV10_XSCOM_N1_CHIPLET_CTRL_REGS_BASE      0x3000000
> +#define PNV10_XSCOM_CHIPLET_CTRL_REGS_SIZE         0x400
> +
>   #define PNV10_XSCOM_PEC_NEST_BASE  0x3011800 /* index goes downwards ... */
>   #define PNV10_XSCOM_PEC_NEST_SIZE  0x100
>   
> diff --git a/hw/ppc/pnv_nest_pervasive.c b/hw/ppc/pnv_nest_pervasive.c
> new file mode 100644
> index 0000000000..886e0d2491
> --- /dev/null
> +++ b/hw/ppc/pnv_nest_pervasive.c
> @@ -0,0 +1,208 @@
> +/*
> + * QEMU PowerPC nest pervasive common chiplet model
> + *
> + * Copyright (c) 2023, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/ppc/pnv.h"
> +#include "hw/ppc/pnv_xscom.h"
> +#include "hw/ppc/pnv_nest_pervasive.h"
> +
> +/*
> + * Status, configuration, and control units in POWER chips is provided
> + * by the pervasive subsystem, which connects registers to the SCOM bus,
> + * which can be programmed by processor cores, other units on the chip,
> + * BMCs, or other POWER chips.
> + *
> + * A POWER10 chip is divided into logical pieces called chiplets. Chiplets

pieces -> units ?

> + * are broadly divided into "core chiplets" (with the processor cores) and
> + * "nest chiplets" (with everything else). Each chiplet has an attachment
> + * to the nest_pervasiveasive bus (PIB) and with chiplet-specific registers.

nest_pervasive

> + * All nest chiplets have a common basic set of registers.
> + *
> + * This model will provide the registers fuctionality for common registers of
> + * nest unit (PB Chiplet, PCI Chiplets, MC Chiplet, PAU Chiplets)
> + *
> + * Currently this model provide the read/write fuctionality of chiplet control

functionality

> + * scom registers.
> + */
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
> +static uint64_t pnv_chiplet_ctrl_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    PnvNestChipletPervasive *nest_pervasive = PNV_NEST_CHIPLET_PERVASIVE(
> +                                              opaque);
> +    uint32_t reg = addr >> 3;
> +    uint64_t val = ~0ull;
> +
> +    /* CPLT_CTRL0 to CPLT_CTRL5 */
> +    for (int i = 0; i < CPLT_CTRL_SIZE; i++) {
> +        if (reg == i) {
> +            return nest_pervasive->control_regs.cplt_ctrl[i];
> +        } else if ((reg == (i + 0x10)) || (reg == (i + 0x20))) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
> +                                           "xscom read at 0x%" PRIx32 "\n",
> +                                           __func__, reg);
> +            return val;
> +        }
> +    }
> +
> +    switch (reg) {
> +    case CPLT_CONF0:
> +        val = nest_pervasive->control_regs.cplt_cfg0;
> +        break;
> +    case CPLT_CONF0_OR:
> +    case CPLT_CONF0_CLEAR:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
> +                                   "xscom read at 0x%" PRIx32 "\n",
> +                                   __func__, reg);
> +        break;
> +    case CPLT_CONF1:
> +        val = nest_pervasive->control_regs.cplt_cfg1;
> +        break;
> +    case CPLT_CONF1_OR:
> +    case CPLT_CONF1_CLEAR:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
> +                                   "xscom read at 0x%" PRIx32 "\n",
> +                                   __func__, reg);
> +        break;
> +    case CPLT_STAT0:
> +        val = nest_pervasive->control_regs.cplt_stat0;
> +        break;
> +    case CPLT_MASK0:
> +        val = nest_pervasive->control_regs.cplt_mask0;
> +        break;
> +    case CPLT_PROTECT_MODE:
> +        val = nest_pervasive->control_regs.ctrl_protect_mode;
> +        break;
> +    case CPLT_ATOMIC_CLOCK:
> +        val = nest_pervasive->control_regs.ctrl_atomic_lock;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: Chiplet_control_regs: Invalid xscom "
> +                 "read at 0x%" PRIx32 "\n", __func__, reg);
> +    }
> +    return val;
> +}
> +
> +static void pnv_chiplet_ctrl_write(void *opaque, hwaddr addr,
> +                                 uint64_t val, unsigned size)
> +{
> +    PnvNestChipletPervasive *nest_pervasive = PNV_NEST_CHIPLET_PERVASIVE(
> +                                              opaque);
> +    uint32_t reg = addr >> 3;
> +
> +    /* CPLT_CTRL0 to CPLT_CTRL5 */
> +    for (int i = 0; i < CPLT_CTRL_SIZE; i++) {
> +        if (reg == i) {
> +            nest_pervasive->control_regs.cplt_ctrl[i] = val;
> +            return;
> +        } else if (reg == (i + 0x10)) {
> +            nest_pervasive->control_regs.cplt_ctrl[i] |= val;
> +            return;
> +        } else if (reg == (i + 0x20)) {
> +            nest_pervasive->control_regs.cplt_ctrl[i] &= ~val;
> +            return;
> +        }
> +    }
> +
> +    switch (reg) {
> +    case CPLT_CONF0:
> +        nest_pervasive->control_regs.cplt_cfg0 = val;
> +        break;
> +    case CPLT_CONF0_OR:
> +        nest_pervasive->control_regs.cplt_cfg0 |= val;
> +        break;
> +    case CPLT_CONF0_CLEAR:
> +        nest_pervasive->control_regs.cplt_cfg0 &= ~val;
> +        break;
> +    case CPLT_CONF1:
> +        nest_pervasive->control_regs.cplt_cfg1 = val;
> +        break;
> +    case CPLT_CONF1_OR:
> +        nest_pervasive->control_regs.cplt_cfg1 |= val;
> +        break;
> +    case CPLT_CONF1_CLEAR:
> +        nest_pervasive->control_regs.cplt_cfg1 &= ~val;
> +        break;
> +    case CPLT_STAT0:
> +        nest_pervasive->control_regs.cplt_stat0 = val;
> +        break;
> +    case CPLT_MASK0:
> +        nest_pervasive->control_regs.cplt_mask0 = val;
> +        break;
> +    case CPLT_PROTECT_MODE:
> +        nest_pervasive->control_regs.ctrl_protect_mode = val;
> +        break;
> +    case CPLT_ATOMIC_CLOCK:
> +        nest_pervasive->control_regs.ctrl_atomic_lock = val;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: Chiplet_control_regs: Invalid xscom "
> +                                 "write at 0x%" PRIx32 "\n",
> +                                 __func__, reg);
> +    }
> +}
> +
> +static const MemoryRegionOps pnv_nest_pervasive_control_xscom_ops = {
> +    .read = pnv_chiplet_ctrl_read,
> +    .write = pnv_chiplet_ctrl_write,
> +    .valid.min_access_size = 8,
> +    .valid.max_access_size = 8,
> +    .impl.min_access_size = 8,
> +    .impl.max_access_size = 8,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +};
> +
> +static void pnv_nest_pervasive_realize(DeviceState *dev, Error **errp)
> +{
> +    PnvNestChipletPervasive *nest_pervasive = PNV_NEST_CHIPLET_PERVASIVE(dev);
> +
> +    /* Chiplet control scoms */
> +    pnv_xscom_region_init(&nest_pervasive->xscom_ctrl_regs_mr,
> +                          OBJECT(nest_pervasive),
> +                          &pnv_nest_pervasive_control_xscom_ops,
> +                          nest_pervasive, "pervasive-control",
> +                          PNV10_XSCOM_CHIPLET_CTRL_REGS_SIZE);
> +}
> +
> +static void pnv_nest_pervasive_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "PowerNV nest pervasive chiplet";
> +    dc->realize = pnv_nest_pervasive_realize;
> +}
> +
> +static const TypeInfo pnv_nest_pervasive_info = {
> +    .name          = TYPE_PNV_NEST_CHIPLET_PERVASIVE,
> +    .parent        = TYPE_DEVICE,
> +    .instance_size = sizeof(PnvNestChipletPervasive),
> +    .class_init    = pnv_nest_pervasive_class_init,
> +    .interfaces    = (InterfaceInfo[]) {
> +        { TYPE_PNV_XSCOM_INTERFACE },
> +        { }
> +    }
> +};
> +
> +static void pnv_nest_pervasive_register_types(void)
> +{
> +    type_register_static(&pnv_nest_pervasive_info);
> +}
> +
> +type_init(pnv_nest_pervasive_register_types);
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index ea44856d43..d6f6f94fcc 100644
> --- a/hw/ppc/meson.build
> +++ b/hw/ppc/meson.build
> @@ -51,6 +51,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
>     'pnv_bmc.c',
>     'pnv_homer.c',
>     'pnv_pnor.c',
> +  'pnv_nest_pervasive.c',
>   ))
>   # PowerPC 4xx boards
>   ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(


