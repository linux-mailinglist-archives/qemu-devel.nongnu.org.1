Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA567BD46C
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 09:36:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpkma-0002R5-9k; Mon, 09 Oct 2023 03:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=fyWv=FX=kaod.org=clg@ozlabs.org>)
 id 1qpkmX-0002Qg-W7; Mon, 09 Oct 2023 03:34:26 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=fyWv=FX=kaod.org=clg@ozlabs.org>)
 id 1qpkmS-0006J8-Gw; Mon, 09 Oct 2023 03:34:25 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S3rPv5NYVz4xVv;
 Mon,  9 Oct 2023 18:34:11 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S3rPr1q5qz4xVt;
 Mon,  9 Oct 2023 18:34:08 +1100 (AEDT)
Message-ID: <54e7fb23-71f4-85be-1aea-2cc6c2e6f62d@kaod.org>
Date: Mon, 9 Oct 2023 09:34:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] hw/ppc: Add nest1 chiplet control scoms
Content-Language: en-US
To: Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 calebs@us.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.vnet.ibm.com
References: <20231006163446.3370-1-chalapathi.v@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231006163446.3370-1-chalapathi.v@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=fyWv=FX=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.818,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

Hello Chalapathi,

On 10/6/23 18:34, Chalapathi V wrote:
> -Create nest1 chiplet model and add nest1 chiplet control scoms.
> -Implementation of chiplet control scoms are put in pnv_pervasive.c
>   as control scoms are common for all chiplets.

I don't really understand the need for this pnv_pervasive.c file.
Do you have plans for more models using the same set of scoms
registers ?


Anyhow, overall it looks good.

Here are some suggestions for the next respin :

* Please split the model implementation from the wiring in the board.
   three patches with a cover letter would be nice. The first would
   introduce pnv_pervasive.c with some commit log explaining the
   rationale. Then the model, then the wiring.

   See https://lore.kernel.org/qemu-devel/ for series examples.

* In the commit log, pleas add more details on the unit being modeled,
   not the specs but a couple of words/sentences describing what is
   the nest1 unit and how it interacts with the rest of the machine.
   What is modeled, what is not, etc. People are simply curious.

* Get rid of the useless white lines

* Add a SPDX-License-Identifier tag in new files.

* Run scripts/checkpatch.pl

Thanks,

C.


> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>   hw/ppc/meson.build                |   2 +
>   hw/ppc/pnv.c                      |  11 +++
>   hw/ppc/pnv_nest1_chiplet.c        | 141 +++++++++++++++++++++++++++++
>   hw/ppc/pnv_pervasive.c            | 146 ++++++++++++++++++++++++++++++
>   include/hw/ppc/pnv_chip.h         |   2 +
>   include/hw/ppc/pnv_nest_chiplet.h |  27 ++++++
>   include/hw/ppc/pnv_pervasive.h    |  30 ++++++
>   include/hw/ppc/pnv_xscom.h        |   3 +
>   8 files changed, 362 insertions(+)
>   create mode 100644 hw/ppc/pnv_nest1_chiplet.c
>   create mode 100644 hw/ppc/pnv_pervasive.c
>   create mode 100644 include/hw/ppc/pnv_nest_chiplet.h
>   create mode 100644 include/hw/ppc/pnv_pervasive.h
> 
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index 7c2c52434a..541d69cf94 100644
> --- a/hw/ppc/meson.build
> +++ b/hw/ppc/meson.build
> @@ -50,6 +50,8 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
>     'pnv_bmc.c',
>     'pnv_homer.c',
>     'pnv_pnor.c',
> +  'pnv_nest1_chiplet.c',
> +  'pnv_pervasive.c',
>   ))
>   # PowerPC 4xx boards
>   ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index eb54f93986..0e1c944753 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1660,6 +1660,8 @@ static void pnv_chip_power10_instance_init(Object *obj)
>       object_initialize_child(obj, "occ",  &chip10->occ, TYPE_PNV10_OCC);
>       object_initialize_child(obj, "sbe",  &chip10->sbe, TYPE_PNV10_SBE);
>       object_initialize_child(obj, "homer", &chip10->homer, TYPE_PNV10_HOMER);
> +    object_initialize_child(obj, "nest1_chiplet", &chip10->nest1_chiplet,
> +                            TYPE_PNV_NEST1_CHIPLET);
>   
>       chip->num_pecs = pcc->num_pecs;
>   
> @@ -1829,6 +1831,15 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>       memory_region_add_subregion(get_system_memory(), PNV10_HOMER_BASE(chip),
>                                   &chip10->homer.regs);
>   
> +    /* nest1 chiplet control regs */
> +    object_property_set_link(OBJECT(&chip10->nest1_chiplet), "chip",
> +                             OBJECT(chip), &error_abort);
> +    if (!qdev_realize(DEVICE(&chip10->nest1_chiplet), NULL, errp)) {
> +        return;
> +    }
> +    pnv_xscom_add_subregion(chip, PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE,
> +                           &chip10->nest1_chiplet.xscom_ctrl_regs);
> +
>       /* PHBs */
>       pnv_chip_power10_phb_realize(chip, &local_err);
>       if (local_err) {
> diff --git a/hw/ppc/pnv_nest1_chiplet.c b/hw/ppc/pnv_nest1_chiplet.c
> new file mode 100644
> index 0000000000..c679428213
> --- /dev/null
> +++ b/hw/ppc/pnv_nest1_chiplet.c
> @@ -0,0 +1,141 @@
> +/*
> + * QEMU PowerPC nest1 chiplet model
> + *
> + * Copyright (c) 2023, IBM Corporation.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/qdev-properties.h"
> +
> +#include "hw/ppc/pnv.h"
> +#include "hw/ppc/pnv_xscom.h"
> +#include "hw/ppc/pnv_nest_chiplet.h"
> +#include "hw/ppc/pnv_pervasive.h"
> +#include "hw/ppc/fdt.h"
> +
> +#include <libfdt.h>
> +
> +/* This chiplet contains nest1 chiplet control unit. More to come later */
> +
> +static uint64_t pnv_nest1_chiplet_xscom_read(void *opaque, hwaddr addr,
> +                                             unsigned size)
> +{
> +    PnvNest1Chiplet *nest1_chiplet = PNV_NEST1CHIPLET(opaque);
> +    int reg = addr >> 3;
> +    uint64_t val = 0;
> +
> +    switch (reg) {
> +    case 0x000 ... 0x3FF:
> +        val = pnv_chiplet_ctrl_read(&nest1_chiplet->ctrl_regs, reg, size);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: Invalid xscom read at 0x%" PRIx32 "\n",
> +                      __func__, reg);
> +    }
> +
> +    return val;
> +}
> +
> +static void pnv_nest1_chiplet_xscom_write(void *opaque, hwaddr addr,
> +                                          uint64_t val, unsigned size)
> +{
> +    PnvNest1Chiplet *nest1_chiplet = PNV_NEST1CHIPLET(opaque);
> +    int reg = addr >> 3;
> +
> +    switch (reg) {
> +    case 0x000 ... 0x3FF:
> +        pnv_chiplet_ctrl_write(&nest1_chiplet->ctrl_regs, reg, val, size);
> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: Invalid xscom write at 0x%" PRIx32 "\n",
> +                      __func__, reg);
> +        return;
> +    }
> +    return;
> +}
> +
> +static const MemoryRegionOps pnv_nest1_chiplet_xscom_ops = {
> +    .read = pnv_nest1_chiplet_xscom_read,
> +    .write = pnv_nest1_chiplet_xscom_write,
> +    .valid.min_access_size = 8,
> +    .valid.max_access_size = 8,
> +    .impl.min_access_size = 8,
> +    .impl.max_access_size = 8,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +};
> +
> +static void pnv_nest1_chiplet_realize(DeviceState *dev, Error **errp)
> +{
> +    PnvNest1Chiplet *nest1_chiplet = PNV_NEST1CHIPLET(dev);
> +
> +    assert(nest1_chiplet->chip);
> +
> +    /* NMMU xscom region */
> +    pnv_xscom_region_init(&nest1_chiplet->xscom_ctrl_regs,
> +                          OBJECT(nest1_chiplet), &pnv_nest1_chiplet_xscom_ops,
> +                          nest1_chiplet, "xscom-nest1-chiplet",
> +                          PNV10_XSCOM_NEST1_CTRL_CHIPLET_SIZE);
> +}
> +
> +static int pnv_nest1_chiplet_dt_xscom(PnvXScomInterface *dev, void *fdt,
> +                             int offset)
> +{
> +    char *name;
> +    int nest1_chiplet_offset;
> +    const char compat[] = "ibm,power10-nest1-chiplet";
> +    uint32_t reg[2] = {
> +        cpu_to_be32(PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE),
> +        cpu_to_be32(PNV10_XSCOM_NEST1_CTRL_CHIPLET_SIZE)
> +    };
> +
> +    name = g_strdup_printf("nest1_chiplet@%x",
> +                           PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE);
> +    nest1_chiplet_offset = fdt_add_subnode(fdt, offset, name);
> +    _FDT(nest1_chiplet_offset);
> +    g_free(name);
> +
> +    _FDT(fdt_setprop(fdt, nest1_chiplet_offset, "reg", reg, sizeof(reg)));
> +    _FDT(fdt_setprop(fdt, nest1_chiplet_offset, "compatible",
> +                            compat, sizeof(compat)));
> +    return 0;
> +}
> +
> +static Property pnv_nest1_chiplet_properties[] = {
> +    DEFINE_PROP_LINK("chip", PnvNest1Chiplet, chip, TYPE_PNV_CHIP, PnvChip *),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void pnv_nest1_chiplet_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PnvXScomInterfaceClass *xscomc = PNV_XSCOM_INTERFACE_CLASS(klass);
> +
> +    xscomc->dt_xscom = pnv_nest1_chiplet_dt_xscom;
> +
> +    dc->desc = "PowerNV nest1 chiplet";
> +    dc->realize = pnv_nest1_chiplet_realize;
> +    device_class_set_props(dc, pnv_nest1_chiplet_properties);
> +}
> +
> +static const TypeInfo pnv_nest1_chiplet_info = {
> +    .name          = TYPE_PNV_NEST1_CHIPLET,
> +    .parent        = TYPE_DEVICE,
> +    .instance_size = sizeof(PnvNest1Chiplet),
> +    .class_init    = pnv_nest1_chiplet_class_init,
> +    .interfaces    = (InterfaceInfo[]) {
> +        { TYPE_PNV_XSCOM_INTERFACE },
> +        { }
> +    }
> +};
> +
> +static void pnv_nest1_chiplet_register_types(void)
> +{
> +    type_register_static(&pnv_nest1_chiplet_info);
> +}
> +
> +type_init(pnv_nest1_chiplet_register_types);
> diff --git a/hw/ppc/pnv_pervasive.c b/hw/ppc/pnv_pervasive.c
> new file mode 100644
> index 0000000000..292a2b31a0
> --- /dev/null
> +++ b/hw/ppc/pnv_pervasive.c
> @@ -0,0 +1,146 @@
> +/*
> + * QEMU PowerPC pervasive common chiplet model
> + *
> + * Copyright (c) 2023, IBM Corporation.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/qdev-properties.h"
> +
> +#include "hw/ppc/pnv.h"
> +#include "hw/ppc/pnv_xscom.h"
> +#include "hw/ppc/pnv_pervasive.h"
> +#include "hw/ppc/fdt.h"
> +
> +#include <libfdt.h>
> +
> +#define CPLT_CONF0               0x08
> +#define CPLT_CONF0_OR            0x18
> +#define CPLT_CONF0_CLEAR         0x28
> +
> +#define CPLT_CONF1               0x09
> +#define CPLT_CONF1_OR            0x19
> +#define CPLT_CONF1_CLEAR         0x29
> +
> +#define CPLT_STAT0               0x100
> +#define CPLT_MASK0               0x101
> +#define CPLT_PROTECT_MODE        0x3FE
> +#define CPLT_ATOMIC_CLOCK        0x3FF
> +
> +uint64_t pnv_chiplet_ctrl_read(PnvChipletControlRegs *ctrl_regs, hwaddr reg,
> +              unsigned size)
> +{
> +    uint64_t val = 0xffffffffffffffffull;
> +
> +    /* CPLT_CTRL0 to CPLT_CTRL5 */
> +    for (int i = 0; i <= 5; i++) {
> +        if (reg == i) {
> +            val = ctrl_regs->cplt_ctrl[i];
> +            return val;
> +        } else if ((reg == (i + 0x10)) || (reg == (i + 0x20))) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
> +                                           "xscom read at 0x%016lx\n",
> +                                          __func__, (unsigned long)reg);
> +            return val;
> +        }
> +    }
> +
> +    switch (reg) {
> +    case CPLT_CONF0:
> +        val = ctrl_regs->cplt_cfg0;
> +        break;
> +    case CPLT_CONF0_OR:
> +    case CPLT_CONF0_CLEAR:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
> +                                   "xscom read at 0x%016lx\n",
> +                                   __func__, (unsigned long)reg);
> +        break;
> +    case CPLT_CONF1:
> +        val = ctrl_regs->cplt_cfg1;
> +        break;
> +    case CPLT_CONF1_OR:
> +    case CPLT_CONF1_CLEAR:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
> +                                   "xscom read at 0x%016lx\n",
> +                                   __func__, (unsigned long)reg);
> +        break;
> +    case CPLT_STAT0:
> +        val = ctrl_regs->cplt_stat0;
> +        break;
> +    case CPLT_MASK0:
> +        val = ctrl_regs->cplt_mask0;
> +        break;
> +    case CPLT_PROTECT_MODE:
> +        val = ctrl_regs->ctrl_protect_mode;
> +        break;
> +    case CPLT_ATOMIC_CLOCK:
> +        val = ctrl_regs->ctrl_atomic_lock;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: Chiplet_control_regs: Invalid xscom "
> +                 "read at 0x%016lx\n", __func__, (unsigned long)reg);
> +    }
> +
> +    return val;
> +}
> +
> +void pnv_chiplet_ctrl_write(PnvChipletControlRegs *ctrl_regs, hwaddr reg,
> +                                 uint64_t val, unsigned size)
> +{
> +    /* CPLT_CTRL0 to CPLT_CTRL5 */
> +    for (int i = 0; i <= 5; i++) {
> +        if (reg == i) {
> +            ctrl_regs->cplt_ctrl[i] = val;
> +            return;
> +        } else if (reg == (i + 0x10)) {
> +            ctrl_regs->cplt_ctrl[i] |= val;
> +            return;
> +        } else if (reg == (i + 0x20)) {
> +            ctrl_regs->cplt_ctrl[i] &= ~val;
> +            return;
> +        }
> +    }
> +
> +    switch (reg) {
> +    case CPLT_CONF0:
> +        ctrl_regs->cplt_cfg0 = val;
> +        break;
> +    case CPLT_CONF0_OR:
> +        ctrl_regs->cplt_cfg0 |= val;
> +        break;
> +    case CPLT_CONF0_CLEAR:
> +        ctrl_regs->cplt_cfg0 &= ~val;
> +        break;
> +    case CPLT_CONF1:
> +        ctrl_regs->cplt_cfg1 = val;
> +        break;
> +    case CPLT_CONF1_OR:
> +        ctrl_regs->cplt_cfg1 |= val;
> +        break;
> +    case CPLT_CONF1_CLEAR:
> +        ctrl_regs->cplt_cfg1 &= ~val;
> +        break;
> +    case CPLT_STAT0:
> +        ctrl_regs->cplt_stat0 = val;
> +        break;
> +    case CPLT_MASK0:
> +        ctrl_regs->cplt_mask0 = val;
> +        break;
> +    case CPLT_PROTECT_MODE:
> +        ctrl_regs->ctrl_protect_mode = val;
> +        break;
> +    case CPLT_ATOMIC_CLOCK:
> +        ctrl_regs->ctrl_atomic_lock = val;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: Chiplet_control_regs: Invalid xscom "
> +                       "write at 0x%016lx\n", __func__, (unsigned long)reg);
> +    }
> +
> +    return;
> +}
> +
> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> index 53e1d921d7..4bcb92595a 100644
> --- a/include/hw/ppc/pnv_chip.h
> +++ b/include/hw/ppc/pnv_chip.h
> @@ -4,6 +4,7 @@
>   #include "hw/pci-host/pnv_phb4.h"
>   #include "hw/ppc/pnv_core.h"
>   #include "hw/ppc/pnv_homer.h"
> +#include "hw/ppc/pnv_nest_chiplet.h"
>   #include "hw/ppc/pnv_lpc.h"
>   #include "hw/ppc/pnv_occ.h"
>   #include "hw/ppc/pnv_psi.h"
> @@ -109,6 +110,7 @@ struct Pnv10Chip {
>       PnvOCC       occ;
>       PnvSBE       sbe;
>       PnvHomer     homer;
> +    PnvNest1Chiplet nest1_chiplet;
>   
>       uint32_t     nr_quads;
>       PnvQuad      *quads;
> diff --git a/include/hw/ppc/pnv_nest_chiplet.h b/include/hw/ppc/pnv_nest_chiplet.h
> new file mode 100644
> index 0000000000..76fa58342e
> --- /dev/null
> +++ b/include/hw/ppc/pnv_nest_chiplet.h
> @@ -0,0 +1,27 @@
> +/*
> + * QEMU PowerPC nest chiplet model
> + *
> + * Copyright (c) 2023, IBM Corporation.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + */
> +
> +#ifndef PPC_PNV_NEST1_CHIPLET_H
> +#define PPC_PNV_NEST1_CHIPLET_H
> +
> +#include "hw/ppc/pnv_pervasive.h"
> +
> +#define TYPE_PNV_NEST1_CHIPLET "pnv-nest1-chiplet"
> +#define PNV_NEST1CHIPLET(obj) OBJECT_CHECK(PnvNest1Chiplet, (obj), TYPE_PNV_NEST1_CHIPLET)
> +
> +typedef struct PnvNest1Chiplet {
> +    DeviceState parent;
> +
> +    struct PnvChip *chip;
> +
> +    MemoryRegion xscom_ctrl_regs;
> +    PnvChipletControlRegs ctrl_regs;
> +} PnvNest1Chiplet;
> +
> +#endif /*PPC_PNV_NEST1_CHIPLET_H */
> diff --git a/include/hw/ppc/pnv_pervasive.h b/include/hw/ppc/pnv_pervasive.h
> new file mode 100644
> index 0000000000..1df5883291
> --- /dev/null
> +++ b/include/hw/ppc/pnv_pervasive.h
> @@ -0,0 +1,30 @@
> +/*
> + * QEMU PowerPC pervasive common chiplet model
> + *
> + * Copyright (c) 2023, IBM Corporation.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + */
> +
> +#ifndef PPC_PNV_PERVASIVE_H
> +#define PPC_PNV_PERVASIVE_H
> +
> +
> +typedef struct PnvChipletControlRegs {
> +
> +    uint64_t cplt_ctrl[6];
> +    uint64_t cplt_cfg0;
> +    uint64_t cplt_cfg1;
> +    uint64_t cplt_stat0;
> +    uint64_t cplt_mask0;
> +    uint64_t ctrl_protect_mode;
> +    uint64_t ctrl_atomic_lock;
> +
> +} PnvChipletControlRegs;
> +
> +uint64_t pnv_chiplet_ctrl_read(PnvChipletControlRegs *ctrl_regs, hwaddr reg,
> +                unsigned size);
> +void pnv_chiplet_ctrl_write(PnvChipletControlRegs *ctrl_regs, hwaddr reg,
> +                uint64_t val, unsigned size);
> +#endif /*PPC_PNV_PERVASIVE_H */
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index 9bc6463547..c19042256b 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -164,6 +164,9 @@ struct PnvXScomInterfaceClass {
>   #define PNV10_XSCOM_XIVE2_BASE     0x2010800
>   #define PNV10_XSCOM_XIVE2_SIZE     0x400
>   
> +#define PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE      0x3000000
> +#define PNV10_XSCOM_NEST1_CTRL_CHIPLET_SIZE      0x400
> +
>   #define PNV10_XSCOM_PEC_NEST_BASE  0x3011800 /* index goes downwards ... */
>   #define PNV10_XSCOM_PEC_NEST_SIZE  0x100
>   


