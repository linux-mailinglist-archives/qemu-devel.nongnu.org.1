Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A1D7DADB1
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 19:36:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxAdu-0007Ke-UX; Sun, 29 Oct 2023 14:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=0fc4=GL=kaod.org=clg@ozlabs.org>)
 id 1qxAds-0007K5-9x; Sun, 29 Oct 2023 14:36:08 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=0fc4=GL=kaod.org=clg@ozlabs.org>)
 id 1qxAdp-0006Wm-Us; Sun, 29 Oct 2023 14:36:08 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SJQ8M2Cdnz4wcX;
 Mon, 30 Oct 2023 05:36:03 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SJQ8H19Gtz4wc1;
 Mon, 30 Oct 2023 05:35:58 +1100 (AEDT)
Message-ID: <f3e64748-b885-462b-b2aa-edf656427530@kaod.org>
Date: Sun, 29 Oct 2023 19:35:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] hw/ppc: Add nest1 chiplet model
Content-Language: en-US
To: Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 calebs@us.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.vnet.ibm.com
References: <20231028113026.23510-1-chalapathi.v@linux.ibm.com>
 <20231028113026.23510-3-chalapathi.v@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231028113026.23510-3-chalapathi.v@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=0fc4=GL=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/28/23 13:30, Chalapathi V wrote:
> The nest1 chiplet handle the high speed i/o traffic over PCIe and others.
> The nest1 chiplet consists of PowerBus Fabric controller,
> nest Memory Management Unit, chiplet control unit and more.
> 
> This commit creates a nest1 chiplet model and initialize and realize the
> pervasive chiplet model where chiplet control registers are implemented.
> 
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>   hw/ppc/meson.build                |   1 +
>   hw/ppc/pnv_nest1_chiplet.c        | 104 ++++++++++++++++++++++++++++++
>   include/hw/ppc/pnv_nest_chiplet.h |  39 +++++++++++
>   3 files changed, 144 insertions(+)
>   create mode 100644 hw/ppc/pnv_nest1_chiplet.c
>   create mode 100644 include/hw/ppc/pnv_nest_chiplet.h
> 
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index c80d2f6cfb..4e45e5c1a7 100644
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
> index 0000000000..160e2ba4cb
> --- /dev/null
> +++ b/hw/ppc/pnv_nest1_chiplet.c
> @@ -0,0 +1,104 @@
> +/*
> + * QEMU PowerPC nest1 chiplet model
> + *
> + * Copyright (c) 2023, IBM Corporation.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
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
> +    assert(nest1_chiplet->chip);
> +
> +    object_initialize_child(OBJECT(nest1_chiplet), "perv_chiplet",
> +                            &nest1_chiplet->perv_chiplet,
> +                            TYPE_PNV_PERV_CHIPLET);
> +
> +    if (!qdev_realize(DEVICE(&nest1_chiplet->perv_chiplet), NULL, errp)) {
> +        return;
> +    }
> +}
> +
> +static int pnv_nest1_chiplet_dt_xscom(PnvXScomInterface *dev, void *fdt,
> +                             int offset)
> +{
> +    char *name;
> +    int nest1_chiplet_offset;
> +    const char compat[] = "ibm,power10-nest1-chiplet";
> +
> +    name = g_strdup_printf("nest1_chiplet@%x",
> +                           PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE);
> +    nest1_chiplet_offset = fdt_add_subnode(fdt, offset, name);
> +    _FDT(nest1_chiplet_offset);
> +    g_free(name);
> +
> +    _FDT(fdt_setprop(fdt, nest1_chiplet_offset, "compatible",
> +                            compat, sizeof(compat)));
> +    return 0;
> +}
> +
> +static Property pnv_nest1_chiplet_properties[] = {
> +    DEFINE_PROP_LINK("chip", PnvNest1Chiplet, chip, TYPE_PNV_CHIP, PnvChip *),

Where is chip being used ?

Thanks,

C.

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
> diff --git a/include/hw/ppc/pnv_nest_chiplet.h b/include/hw/ppc/pnv_nest_chiplet.h
> new file mode 100644
> index 0000000000..b2ffe128bd
> --- /dev/null
> +++ b/include/hw/ppc/pnv_nest_chiplet.h
> @@ -0,0 +1,39 @@
> +/*
> + * QEMU PowerPC nest chiplet model
> + *
> + * Copyright (c) 2023, IBM Corporation.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
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
> +    /* common pervasive chiplet unit */
> +    PnvPervChiplet perv_chiplet;
> +} PnvNest1Chiplet;
> +
> +#endif /*PPC_PNV_NEST1_CHIPLET_H */


