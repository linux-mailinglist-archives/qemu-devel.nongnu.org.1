Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B557FAFDE
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 03:05:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7nSd-00045R-LO; Mon, 27 Nov 2023 21:04:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r7nSZ-00045C-M1; Mon, 27 Nov 2023 21:04:23 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r7nSX-0000UO-5L; Mon, 27 Nov 2023 21:04:23 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1cf7a8ab047so37709545ad.1; 
 Mon, 27 Nov 2023 18:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701137059; x=1701741859; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rEgkOoaNRYewRhLg8nZN+vdIgCGMbu5k53LiNN72wII=;
 b=WWA9LeO/YsvzBWyGpWB6O7CoCnLlUqPChcOM0b3MSm7A4+PX9oZE4vRrp1urOIfXhu
 8/Zd3rquyqHHBzZvnMbTJBoWiMtJvY4adRn9Tl5UgDTEzabhKPhC04ml2vodKiHgZuYd
 TU1g2iJ/UU1/qvHLpgond2ZvIYzn+dFD1VUqUPqlvSsSSrH0TYlscJVpaN47rnfWNRAp
 QwD9xHpJHsOchtks9cr20CMlebaxwshfwbrxv9OYzKmnnJbvUOA1MJb9uUt5OzX+0ycH
 LtZx3xo2ArlZZ9A4H7wZ2+5hLhnGXuqHOAr/Lg1ZWtABG7nA8dH01wZ/puHpXNQUA1qM
 /lXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701137059; x=1701741859;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rEgkOoaNRYewRhLg8nZN+vdIgCGMbu5k53LiNN72wII=;
 b=nVMnYl+GzxMowLZ891L58grND5V+0oz79jJ+NMkAeOUflklMKqUfpAziM7k5o2pPml
 HpYAGqojSqaN1Xr7d+HASVl/c71Cn9rsH9dtomP3xSM8Zx1xs1D0cNqOnhJNaCcZ+8u9
 vQ2s5kHpNGOFHkiOOkZlpgt2Z6hbVl60lYTjCsg1Lo6HHe3mdx2mz6/Nd8bVPvTHQ+LV
 2L7YMOXgK7MSXfEV6fM0o9vOl0ssI/v32M2zYjOCOQI4636zn7Mayh1MH6Jbc2J6OBK0
 MNLKbXJl+91y1/B7syVioRV/qu7Wwz3gT1rsgfwT5VkoRLY2elvDix1IR0UC/fRe3AGx
 9J/A==
X-Gm-Message-State: AOJu0Yx4lAL2Cyu2g/6/QJZ2lf6kljSTWMSjyDzaCqOYK7d40bEQZA5Y
 7cRWd42PoXeE0cWyhCd9Wx4=
X-Google-Smtp-Source: AGHT+IF71FDHpuqPlAnbYevt25K7KawgTa9EX9V7+LXzDDXqEoVKZUlhacJXUGQyZjjyl0FSy5TBQw==
X-Received: by 2002:a17:902:aa8e:b0:1cf:63ca:95d7 with SMTP id
 d14-20020a170902aa8e00b001cf63ca95d7mr11143326plr.63.1701137058765; 
 Mon, 27 Nov 2023 18:04:18 -0800 (PST)
Received: from localhost (121-44-66-27.tpgi.com.au. [121.44.66.27])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a170902ee8500b001cf8a4882absm8981435pld.196.2023.11.27.18.04.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Nov 2023 18:04:17 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Nov 2023 12:04:11 +1000
Message-Id: <CXA2R8RQG6IC.18YVEFUPO3P62@wheely>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <clg@kaod.org>,
 <calebs@us.ibm.com>, <chalapathi.v@ibm.com>,
 <saif.abrar@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 1/3] hw/ppc: Add pnv nest pervasive common chiplet model
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Chalapathi V" <chalapathi.v@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20231127171307.5237-1-chalapathi.v@linux.ibm.com>
 <20231127171307.5237-2-chalapathi.v@linux.ibm.com>
In-Reply-To: <20231127171307.5237-2-chalapathi.v@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue Nov 28, 2023 at 3:13 AM AEST, Chalapathi V wrote:
> A POWER10 chip is divided into logical pieces called chiplets. Chiplets
> are broadly divided into "core chiplets" (with the processor cores) and
> "nest chiplets" (with everything else). Each chiplet has an attachment
> to the pervasive bus (PIB) and with chiplet-specific registers. All nest
> chiplets have a common basic set of registers and This model will provide
> the registers functionality for common registers of nest chiplet (Pervasi=
ve
> Chiplet, PB Chiplet, PCI Chiplets, MC Chiplet, PAU Chiplets)
>
> This commit implement the read/write functions of chiplet control registe=
rs.
>
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>  include/hw/ppc/pnv_nest_pervasive.h |  36 +++++
>  include/hw/ppc/pnv_xscom.h          |   3 +
>  hw/ppc/pnv_nest_pervasive.c         | 219 ++++++++++++++++++++++++++++
>  hw/ppc/meson.build                  |   1 +
>  4 files changed, 259 insertions(+)
>  create mode 100644 include/hw/ppc/pnv_nest_pervasive.h
>  create mode 100644 hw/ppc/pnv_nest_pervasive.c
>
> diff --git a/include/hw/ppc/pnv_nest_pervasive.h b/include/hw/ppc/pnv_nes=
t_pervasive.h
> new file mode 100644
> index 0000000000..9f11531f52
> --- /dev/null
> +++ b/include/hw/ppc/pnv_nest_pervasive.h
> @@ -0,0 +1,36 @@
> +/*
> + * QEMU PowerPC nest pervasive common chiplet model
> + *
> + * Copyright (c) 2023, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.

Shouldn't need this line with the SPDX tag I think? There are a copule
of dozen files already in the tree that do have both, but hundreds that
only have the tag.

> + */
> +
> +#ifndef PPC_PNV_NEST_PERVASIVE_H
> +#define PPC_PNV_NEST_PERVASIVE_H
> +
> +#define TYPE_PNV_NEST_PERVASIVE "pnv-nest-chiplet-pervasive"
> +#define PNV_NEST_PERVASIVE(obj) OBJECT_CHECK(PnvNestChipletPervasive, (o=
bj), TYPE_PNV_NEST_PERVASIVE)

_NEXT_CHIPLET_PERVASIVE?

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
> +    char                    *parent_obj_name;
> +    MemoryRegion            xscom_ctrl_regs;
> +    PnvPervasiveCtrlRegs    control_regs;
> +} PnvNestChipletPervasive;

The file name doesn't quite match the type name, but that's probably
okay. This could be a good place for other misc pervasive helpers,
so keeping the name more general is fine.


> +
> +#endif /*PPC_PNV_NEST_PERVASIVE_H */
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index f5becbab41..3e15706dec 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -170,6 +170,9 @@ struct PnvXScomInterfaceClass {
>  #define PNV10_XSCOM_XIVE2_BASE     0x2010800
>  #define PNV10_XSCOM_XIVE2_SIZE     0x400
> =20
> +#define PNV10_XSCOM_N1_CHIPLET_CTRL_REGS_BASE      0x3000000
> +#define PNV10_XSCOM_CHIPLET_CTRL_REGS_SIZE         0x400
> +
>  #define PNV10_XSCOM_PEC_NEST_BASE  0x3011800 /* index goes downwards ...=
 */
>  #define PNV10_XSCOM_PEC_NEST_SIZE  0x100
> =20
> diff --git a/hw/ppc/pnv_nest_pervasive.c b/hw/ppc/pnv_nest_pervasive.c
> new file mode 100644
> index 0000000000..0575f87e8f
> --- /dev/null
> +++ b/hw/ppc/pnv_nest_pervasive.c
> @@ -0,0 +1,219 @@
> +/*
> + * QEMU PowerPC nest pervasive common chiplet model
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
> +#include "hw/ppc/pnv_nest_pervasive.h"
> +
> +/*
> + * Status, configuration, and control units in POWER chips is provided
> + * by the pervasive subsystem, which connects registers to the SCOM bus,
> + * which can be programmed by processor cores, other units on the chip,
> + * BMCs, or other POWER chips.
> + *
> + * A POWER10 chip is divided into logical pieces called chiplets. Chiple=
ts
> + * are broadly divided into "core chiplets" (with the processor cores) a=
nd
> + * "nest chiplets" (with everything else). Each chiplet has an attachmen=
t
> + * to the nest_pervasiveasive bus (PIB) and with chiplet-specific regist=
ers.
> + * All nest chiplets have a common basic set of registers.
> + *
> + * This model will provide the registers fuctionality for common registe=
rs of
> + * nest unit (PB Chiplet, PCI Chiplets, MC Chiplet, PAU Chiplets)
> + *
> + * Currently this model provide the read/write fuctionality of chiplet c=
ontrol
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
> +static uint64_t pnv_chiplet_ctrl_read(void *opaque, hwaddr addr, unsigne=
d size)
> +{
> +    PnvNestChipletPervasive *nest_pervasive =3D PNV_NEST_PERVASIVE(opaqu=
e);
> +    int reg =3D addr >> 3;
> +    uint64_t val =3D ~0ull;
> +
> +    /* CPLT_CTRL0 to CPLT_CTRL5 */
> +    for (int i =3D 0; i < CPLT_CTRL_SIZE; i++) {
> +        if (reg =3D=3D i) {
> +            return nest_pervasive->control_regs.cplt_ctrl[i];
> +        } else if ((reg =3D=3D (i + 0x10)) || (reg =3D=3D (i + 0x20))) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ign=
oring "
> +                                           "xscom read at 0x%" PRIx64 "\=
n",
> +                                           __func__, (unsigned long)reg)=
;
> +            return val;
> +        }
> +    }
> +
> +    switch (reg) {
> +    case CPLT_CONF0:
> +        val =3D nest_pervasive->control_regs.cplt_cfg0;
> +        break;
> +    case CPLT_CONF0_OR:
> +    case CPLT_CONF0_CLEAR:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignorin=
g "
> +                                   "xscom read at 0x%" PRIx64 "\n",
> +                                   __func__, (unsigned long)reg);
> +        break;
> +    case CPLT_CONF1:
> +        val =3D nest_pervasive->control_regs.cplt_cfg1;
> +        break;
> +    case CPLT_CONF1_OR:
> +    case CPLT_CONF1_CLEAR:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignorin=
g "
> +                                   "xscom read at 0x%" PRIx64 "\n",
> +                                   __func__, (unsigned long)reg);
> +        break;
> +    case CPLT_STAT0:
> +        val =3D nest_pervasive->control_regs.cplt_stat0;
> +        break;
> +    case CPLT_MASK0:
> +        val =3D nest_pervasive->control_regs.cplt_mask0;
> +        break;
> +    case CPLT_PROTECT_MODE:
> +        val =3D nest_pervasive->control_regs.ctrl_protect_mode;
> +        break;
> +    case CPLT_ATOMIC_CLOCK:
> +        val =3D nest_pervasive->control_regs.ctrl_atomic_lock;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: Chiplet_control_regs: Invalid xsco=
m "
> +                 "read at 0x%" PRIx64 "\n", __func__, (unsigned long)reg=
);
> +    }
> +    return val;
> +}
> +
> +static void pnv_chiplet_ctrl_write(void *opaque, hwaddr addr,
> +                                 uint64_t val, unsigned size)
> +{
> +    PnvNestChipletPervasive *nest_pervasive =3D PNV_NEST_PERVASIVE(opaqu=
e);
> +    int reg =3D addr >> 3;
> +
> +    /* CPLT_CTRL0 to CPLT_CTRL5 */
> +    for (int i =3D 0; i < CPLT_CTRL_SIZE; i++) {
> +        if (reg =3D=3D i) {
> +            nest_pervasive->control_regs.cplt_ctrl[i] =3D val;
> +            return;
> +        } else if (reg =3D=3D (i + 0x10)) {
> +            nest_pervasive->control_regs.cplt_ctrl[i] |=3D val;
> +            return;
> +        } else if (reg =3D=3D (i + 0x20)) {
> +            nest_pervasive->control_regs.cplt_ctrl[i] &=3D ~val;
> +            return;
> +        }
> +    }
> +
> +    switch (reg) {
> +    case CPLT_CONF0:
> +        nest_pervasive->control_regs.cplt_cfg0 =3D val;
> +        break;
> +    case CPLT_CONF0_OR:
> +        nest_pervasive->control_regs.cplt_cfg0 |=3D val;
> +        break;
> +    case CPLT_CONF0_CLEAR:
> +        nest_pervasive->control_regs.cplt_cfg0 &=3D ~val;
> +        break;
> +    case CPLT_CONF1:
> +        nest_pervasive->control_regs.cplt_cfg1 =3D val;
> +        break;
> +    case CPLT_CONF1_OR:
> +        nest_pervasive->control_regs.cplt_cfg1 |=3D val;
> +        break;
> +    case CPLT_CONF1_CLEAR:
> +        nest_pervasive->control_regs.cplt_cfg1 &=3D ~val;
> +        break;
> +    case CPLT_STAT0:
> +        nest_pervasive->control_regs.cplt_stat0 =3D val;
> +        break;
> +    case CPLT_MASK0:
> +        nest_pervasive->control_regs.cplt_mask0 =3D val;
> +        break;
> +    case CPLT_PROTECT_MODE:
> +        nest_pervasive->control_regs.ctrl_protect_mode =3D val;
> +        break;
> +    case CPLT_ATOMIC_CLOCK:
> +        nest_pervasive->control_regs.ctrl_atomic_lock =3D val;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: Chiplet_control_regs: Invalid xsco=
m "
> +                                 "write at 0x%" PRIx64 "\n",
> +                                 __func__, (unsigned long)reg);
> +    }
> +}
> +
> +static const MemoryRegionOps pnv_nest_pervasive_control_xscom_ops =3D {
> +    .read =3D pnv_chiplet_ctrl_read,
> +    .write =3D pnv_chiplet_ctrl_write,
> +    .valid.min_access_size =3D 8,
> +    .valid.max_access_size =3D 8,
> +    .impl.min_access_size =3D 8,
> +    .impl.max_access_size =3D 8,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
> +};
> +
> +static void pnv_nest_pervasive_realize(DeviceState *dev, Error **errp)
> +{
> +    PnvNestChipletPervasive *nest_pervasive =3D PNV_NEST_PERVASIVE(dev);
> +    g_autofree char *region_name =3D NULL;
> +    region_name =3D g_strdup_printf("xscom-%s-control-regs",
> +                                   nest_pervasive->parent_obj_name);

Should it be just control, or pervasive-control? Nest chiplets will
have control for other functions.

Those are all minor nits though. Generally looks good.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> +
> +    /* Chiplet control scoms */
> +    pnv_xscom_region_init(&nest_pervasive->xscom_ctrl_regs,
> +                          OBJECT(nest_pervasive),
> +                          &pnv_nest_pervasive_control_xscom_ops,
> +                          nest_pervasive, region_name,
> +                          PNV10_XSCOM_CHIPLET_CTRL_REGS_SIZE);
> +}
> +
> +static Property pnv_nest_pervasive_properties[] =3D {
> +    DEFINE_PROP_STRING("parent-obj-name", PnvNestChipletPervasive,
> +                        parent_obj_name),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void pnv_nest_pervasive_class_init(ObjectClass *klass, void *data=
)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->desc =3D "PowerNV nest_pervasive chiplet";
> +    dc->realize =3D pnv_nest_pervasive_realize;
> +    device_class_set_props(dc, pnv_nest_pervasive_properties);
> +}
> +
> +static const TypeInfo pnv_nest_pervasive_info =3D {
> +    .name          =3D TYPE_PNV_NEST_PERVASIVE,
> +    .parent        =3D TYPE_DEVICE,
> +    .instance_size =3D sizeof(PnvNestChipletPervasive),
> +    .class_init    =3D pnv_nest_pervasive_class_init,
> +    .interfaces    =3D (InterfaceInfo[]) {
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
>    'pnv_bmc.c',
>    'pnv_homer.c',
>    'pnv_pnor.c',
> +  'pnv_nest_pervasive.c',
>  ))
>  # PowerPC 4xx boards
>  ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(


