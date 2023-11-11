Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9557E8BE1
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 18:29:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1rm3-0007LV-AX; Sat, 11 Nov 2023 12:27:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=UdCb=GY=kaod.org=clg@ozlabs.org>)
 id 1r1rm1-0007LB-RA; Sat, 11 Nov 2023 12:27:57 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=UdCb=GY=kaod.org=clg@ozlabs.org>)
 id 1r1rlv-0004Fd-P2; Sat, 11 Nov 2023 12:27:57 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SSN1X4Hkkz4wy1;
 Sun, 12 Nov 2023 04:27:44 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SSN1V0h4qz4wnv;
 Sun, 12 Nov 2023 04:27:41 +1100 (AEDT)
Message-ID: <f09db428-8828-460e-b9ce-eb123dce87af@kaod.org>
Date: Sat, 11 Nov 2023 18:27:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] hw/ppc: Add nest1 chiplet model
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 calebs@us.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.vnet.ibm.com,
 Chalapathi V <chalapathi.v@linux.ibm.com>
References: <20231107074127.31821-1-chalap1@gfwr516.rchland.ibm.com>
 <20231107074127.31821-3-chalap1@gfwr516.rchland.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231107074127.31821-3-chalap1@gfwr516.rchland.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=UdCb=GY=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

On 11/7/23 08:41, Chalapathi V wrote:
> From: Chalapathi V <chalapathi.v@linux.ibm.com>
> 
> The nest1 chiplet handle the high speed i/o traffic over PCIe and others.
> The nest1 chiplet consists of PowerBus Fabric controller,
> nest Memory Management Unit, chiplet control unit and more.
> 
> This commit creates a nest1 chiplet model and initialize and realize the
> pervasive chiplet model where chiplet control registers are implemented.
> 
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>   hw/ppc/meson.build                |  1 +
>   hw/ppc/pnv_nest1_chiplet.c        | 94 +++++++++++++++++++++++++++++++++++++++
>   include/hw/ppc/pnv_nest_chiplet.h | 41 +++++++++++++++++
>   3 files changed, 136 insertions(+)
>   create mode 100644 hw/ppc/pnv_nest1_chiplet.c
>   create mode 100644 include/hw/ppc/pnv_nest_chiplet.h
> 
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index c80d2f6..4e45e5c 100644
> --- a/hw/ppc/meson.build
> +++ b/hw/ppc/meson.build
> @@ -51,6 +51,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
>     'pnv_homer.c',
>     'pnv_pnor.c',
>     'pnv_pervasive.c',
> +  'pnv_nest1_chiplet.c',
>   ))
>   # PowerPC 4xx boards
>   ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
> diff --git a/hw/ppc/pnv_nest1_chiplet.c b/hw/ppc/pnv_nest1_chiplet.c
> new file mode 100644
> index 0000000..e078076
> --- /dev/null
> +++ b/hw/ppc/pnv_nest1_chiplet.c
> @@ -0,0 +1,94 @@
> +/*
> + * QEMU PowerPC nest1 chiplet model
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
> +#include "hw/ppc/pnv_nest_chiplet.h"
> +#include "hw/ppc/pnv_pervasive.h"
> +#include "hw/ppc/fdt.h"
> +#include <libfdt.h>
> +
> +/*
> + * The nest1 chiplet contains chiplet control unit,
> + * PowerBus/RaceTrack/Bridge logic, nest Memory Management Unit(nMMU)
> + * and more.
> + */
> +
> +static void pnv_nest1_chiplet_realize(DeviceState *dev, Error **errp)
> +{
> +    PnvNest1Chiplet *nest1_chiplet = PNV_NEST1CHIPLET(dev);
> +
> +    object_initialize_child(OBJECT(nest1_chiplet), "perv_chiplet",
> +                            &nest1_chiplet->perv_chiplet,
> +                            TYPE_PNV_PERV_CHIPLET);
> +
> +    if (!qdev_realize(DEVICE(&nest1_chiplet->perv_chiplet), NULL, errp)) {

I think we will save some bytes and ease reading by removing the '_chiplet'
suffix in the variable names and types. A QEMU model is generally an HW
logic unit or sub-unit. We don't need to add a Chip* suffix.

PnvChip is an exception to this comment, because it represent a socket or
processor, and is referred to as a chip in the POWER documentation AFAICR.

For instance, this routine would become :


   static void pnv_nest1_realize(DeviceState *dev, Error **errp)
   {
       PnvNest1 *nest1 = PNV_NEST1(dev);
   
       object_initialize_child(OBJECT(nest1), "perv", &nest1->perv,
                               TYPE_PNV_PERV);
   
       if (!qdev_realize(DEVICE(&nest1->perv), NULL, errp)) {
	      return;
       }
   }


which is clear enough for me. What do you think ? We can still use the
term chiplet in the documentation.


> +        return;
> +    }
> +}
> +
> +static int pnv_nest1_chiplet_dt_xscom(PnvXScomInterface *dev, void *fdt,
> +                             int offset)
> +{
> +    g_autofree char *name = NULL;
> +    int nest1_chiplet_offset;
> +    const char compat[] = "ibm,power10-nest1-chiplet";
> +
> +    name = g_strdup_printf("nest1_chiplet@%x",
> +                           PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE);
> +    nest1_chiplet_offset = fdt_add_subnode(fdt, offset, name);
> +    _FDT(nest1_chiplet_offset);
> +
> +    _FDT(fdt_setprop(fdt, nest1_chiplet_offset, "compatible",
> +                            compat, sizeof(compat)));
> +    return 0;
> +}
> +
> +static void pnv_nest1_dt_populate(void *fdt)
> +{
> +

Please remove white line.

> +    uint32_t nest1_base = cpu_to_be32(PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE);
> +    pnv_perv_dt(nest1_base, fdt, 0);
> +}
> +
> +static void pnv_nest1_chiplet_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PnvNest1Class *nest1_class = PNV_NEST1CHIPLET_CLASS(klass);
> +    PnvXScomInterfaceClass *xscomc = PNV_XSCOM_INTERFACE_CLASS(klass);
> +
> +    xscomc->dt_xscom = pnv_nest1_chiplet_dt_xscom;
> +
> +    dc->desc = "PowerNV nest1 chiplet";
> +    dc->realize = pnv_nest1_chiplet_realize;
> +    nest1_class->nest1_dt_populate = pnv_nest1_dt_populate;

Why do you need a class handler for the Nest1 unit ? Do you have plans
to have multiple implementations ?

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
> diff --git a/include/hw/ppc/pnv_nest_chiplet.h b/include/hw/ppc/pnv_nest_chiplet.h
> new file mode 100644
> index 0000000..12525d3
> --- /dev/null
> +++ b/include/hw/ppc/pnv_nest_chiplet.h
> @@ -0,0 +1,41 @@
> +/*
> + * QEMU PowerPC nest chiplet model
> + *
> + * Copyright (c) 2023, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef PPC_PNV_NEST1_CHIPLET_H
> +#define PPC_PNV_NEST1_CHIPLET_H
> +
> +#include "hw/ppc/pnv_pervasive.h"
> +
> +#define TYPE_PNV_NEST1_CHIPLET "pnv-nest1-chiplet"
> +typedef struct PnvNest1Class PnvNest1Class;
> +typedef struct PnvNest1Chiplet PnvNest1Chiplet;
> +DECLARE_OBJ_CHECKERS(PnvNest1Chiplet, PnvNest1Class,
> +                     PNV_NEST1CHIPLET, TYPE_PNV_NEST1_CHIPLET)
> +
> +typedef struct PnvNest1Chiplet {
> +    DeviceState parent;
> +
> +    struct PnvChip *chip;

Please remove chip, it is unused.

> +
> +    /* common pervasive chiplet unit */
> +    PnvPervChiplet perv_chiplet;
> +} PnvNest1Chiplet;
> +
> +struct PnvNest1Class {
> +    DeviceClass parent_class;
> +
> +    DeviceRealize parent_realize;
> +
> +    void (*nest1_dt_populate)(void *fdt);

This class needs some justification.


Thanks,

C.



> +};
> +
> +#endif /*PPC_PNV_NEST1_CHIPLET_H */


