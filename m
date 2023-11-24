Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DEE7F727D
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 12:12:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6U6o-0002MA-6o; Fri, 24 Nov 2023 06:12:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6U6j-0002HE-RY; Fri, 24 Nov 2023 06:12:25 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6U6X-0008IP-U4; Fri, 24 Nov 2023 06:12:25 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-285636785ddso1229740a91.3; 
 Fri, 24 Nov 2023 03:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700824330; x=1701429130; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rZdYu69/6zm6VlYOci868O1KYlTosyFok52b6yBoFGk=;
 b=lJOQI2VsnR2PX9Bah01Gk0QC7eNSMbes78xuz2l75Yy1UTLvJZzvp+dLklF2r4bZAq
 7K0UIESfsrqxkV7zjY7Nvwv8cQMOXMKAA2O3A08QVRmgjS5tdIBx+W2QRMbAt6ELqwTQ
 j3fQZjVuLxMBlMlJBssWTfrxEDYxqLOG7Bl3kcferMW4sEpUN/GwyyNOiOTCeTI6HMuB
 Zvqkzf68rXlGnHDpznkQicjyHGuwNjQyYSLZDiWKypJG+pxIC+xuf2njnBMnX7SmtTat
 IjQowctGIHLexXkutSPflVXUuOerDmlUYNuas7/oG29OXeu0CmAZ+5n6d7VFqp/0JMpE
 Ae5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700824330; x=1701429130;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rZdYu69/6zm6VlYOci868O1KYlTosyFok52b6yBoFGk=;
 b=oaca4wtcsbY92a9+uuvBPJTPvKTY5QMteOKirLdZt6yFWguGP6zhC8Li6H3+fbIZvF
 QdEo6gtkMkJ0SigZrFKHlMp43wbaJU93Cf52PNs5XSYne1pkWtlFsexUu0R5Kx2GjeW5
 vh6NEmw0pVXmPswn1i7/fGLUOCue49js0Iwjk55yjoNndOuRBRrt7iTURtUXerCrwcw8
 5ggHz0hdqn+0/RoA3eS/3LGc01vA/iZmZWMRUS84wx8v9ZOLsc87UhAoZIvFmtS2hCOo
 LxvxYjSeMw6mLCv1usbqTl0XeP8A64wjQPPkzFWJakK1iU/d8799NCCINusItTR3NoqP
 rdLA==
X-Gm-Message-State: AOJu0Yw4gSzvdZd6sSpsuWfTw6LEjq7Y1gW7XFdG9RbT+chREMOBOtQl
 spsPRyWUyV2gnO/9FkHxez4=
X-Google-Smtp-Source: AGHT+IEAo66f4fALGpkjD96TQrZTk2xJ+WIFLtry3gZQektjer+MG8m0pMTIthyis5ekEgK1XrFiqA==
X-Received: by 2002:a17:90b:4c8f:b0:281:20a0:dae3 with SMTP id
 my15-20020a17090b4c8f00b0028120a0dae3mr1979757pjb.40.1700824330499; 
 Fri, 24 Nov 2023 03:12:10 -0800 (PST)
Received: from localhost (121-44-66-27.tpgi.com.au. [121.44.66.27])
 by smtp.gmail.com with ESMTPSA id
 102-20020a17090a09ef00b002800e0b4852sm3355223pjo.22.2023.11.24.03.12.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 03:12:09 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Nov 2023 21:12:03 +1000
Message-Id: <CX6ZWJOZ2QCQ.3LNMAZAVW61IJ@wheely>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <clg@kaod.org>,
 <calebs@us.ibm.com>, <chalapathi.v@ibm.com>,
 <saif.abrar@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 1/3] hw/ppc: Add pnv pervasive common chiplet units
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Chalapathi V" <chalapathi.v@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20231124101534.19454-1-chalapathi.v@linux.ibm.com>
 <20231124101534.19454-2-chalapathi.v@linux.ibm.com>
In-Reply-To: <20231124101534.19454-2-chalapathi.v@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri Nov 24, 2023 at 8:15 PM AEST, Chalapathi V wrote:
> This part of the patchset creates a common pervasive chiplet model where =
it
> houses the common units of a chiplets.
>
> The chiplet control unit is common across chiplets and this commit implem=
ents
> the pervasive chiplet model with chiplet control registers.

This might be reworded to be a bit clearer, could provide a bit of
background information too (in changelog or header comment):

 Status, configuration, and control of units in POWER chips is provided
 by the pervasive subsystem, which connects registers to the SCOM bus,
 which can be programmed by processor cores, other units on the chip,
 BMCs, or other POWER chips.

 A POWER10 chip is divided into logical pieces called chiplets. Chiplets
 are broadly divided into "core chiplets" (with the processor cores) and
 "nest chiplets" (with everything else). Each chiplet has an attachment
 to the pervasive bus (PIB) and with chiplet-specific registers. All nest
 chiplets have a common basic set of registers, which this model
 provides. They may also implement additional registers.

That's my undertsanding, does it look right? If yes and this file is
specifically for nest chiplets (not core), maybe the name should
reflect that?

>
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>  include/hw/ppc/pnv_pervasive.h |  37 ++++++
>  include/hw/ppc/pnv_xscom.h     |   3 +
>  hw/ppc/pnv_pervasive.c         | 217 +++++++++++++++++++++++++++++++++
>  hw/ppc/meson.build             |   1 +
>  4 files changed, 258 insertions(+)
>  create mode 100644 include/hw/ppc/pnv_pervasive.h
>  create mode 100644 hw/ppc/pnv_pervasive.c
>
> diff --git a/include/hw/ppc/pnv_pervasive.h b/include/hw/ppc/pnv_pervasiv=
e.h
> new file mode 100644
> index 0000000000..d83f86df7b
> --- /dev/null
> +++ b/include/hw/ppc/pnv_pervasive.h
> @@ -0,0 +1,37 @@
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
> +#define TYPE_PNV_PERV "pnv-pervasive-chiplet"
> +#define PNV_PERV(obj) OBJECT_CHECK(PnvPerv, (obj), TYPE_PNV_PERV)
> +
> +typedef struct PnvPervCtrlRegs {
> +#define CPLT_CTRL_SIZE 6
> +    uint64_t cplt_ctrl[CPLT_CTRL_SIZE];
> +    uint64_t cplt_cfg0;
> +    uint64_t cplt_cfg1;
> +    uint64_t cplt_stat0;
> +    uint64_t cplt_mask0;
> +    uint64_t ctrl_protect_mode;
> +    uint64_t ctrl_atomic_lock;
> +} PnvPervCtrlRegs;
> +
> +typedef struct PnvPerv {

I don't want to bikeshed the name too much, but we have perv and
pervasive, I'd prefer to use pervasive consistently.

I would like the name to reflect that it is for common nest chiplet
registers too, but maybe that's getting too ambitious...

PnvNestChipletCommonRegs
PnvNestChipletPervasive

?


> +    DeviceState parent;
> +    char *parent_obj_name;
> +    MemoryRegion xscom_perv_ctrl_regs;
> +    PnvPervCtrlRegs control_regs;
> +} PnvPerv;
> +
> +void pnv_perv_dt(PnvPerv *perv, uint32_t base_addr, void *fdt, int offse=
t);
> +#endif /*PPC_PNV_PERVASIVE_H */
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index f5becbab41..d09d10f32b 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -170,6 +170,9 @@ struct PnvXScomInterfaceClass {
>  #define PNV10_XSCOM_XIVE2_BASE     0x2010800
>  #define PNV10_XSCOM_XIVE2_SIZE     0x400
> =20
> +#define PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE      0x3000000
> +#define PNV10_XSCOM_CTRL_CHIPLET_SIZE            0x400
> +
>  #define PNV10_XSCOM_PEC_NEST_BASE  0x3011800 /* index goes downwards ...=
 */
>  #define PNV10_XSCOM_PEC_NEST_SIZE  0x100
> =20
> diff --git a/hw/ppc/pnv_pervasive.c b/hw/ppc/pnv_pervasive.c
> new file mode 100644
> index 0000000000..c925070798
> --- /dev/null
> +++ b/hw/ppc/pnv_pervasive.c
> @@ -0,0 +1,217 @@
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
> +static uint64_t pnv_chiplet_ctrl_read(void *opaque, hwaddr addr, unsigne=
d size)
> +{
> +    PnvPerv *perv =3D PNV_PERV(opaque);
> +    int reg =3D addr >> 3;
> +    uint64_t val =3D ~0ull;
> +
> +    /* CPLT_CTRL0 to CPLT_CTRL5 */
> +    for (int i =3D 0; i < CPLT_CTRL_SIZE; i++) {
> +        if (reg =3D=3D i) {
> +            return perv->control_regs.cplt_ctrl[i];
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
> +        val =3D perv->control_regs.cplt_cfg0;
> +        break;
> +    case CPLT_CONF0_OR:
> +    case CPLT_CONF0_CLEAR:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignorin=
g "
> +                                   "xscom read at 0x%" PRIx64 "\n",
> +                                   __func__, (unsigned long)reg);
> +        break;
> +    case CPLT_CONF1:
> +        val =3D perv->control_regs.cplt_cfg1;
> +        break;
> +    case CPLT_CONF1_OR:
> +    case CPLT_CONF1_CLEAR:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignorin=
g "
> +                                   "xscom read at 0x%" PRIx64 "\n",
> +                                   __func__, (unsigned long)reg);
> +        break;
> +    case CPLT_STAT0:
> +        val =3D perv->control_regs.cplt_stat0;
> +        break;
> +    case CPLT_MASK0:
> +        val =3D perv->control_regs.cplt_mask0;
> +        break;
> +    case CPLT_PROTECT_MODE:
> +        val =3D perv->control_regs.ctrl_protect_mode;
> +        break;
> +    case CPLT_ATOMIC_CLOCK:
> +        val =3D perv->control_regs.ctrl_atomic_lock;
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
> +    PnvPerv *perv =3D PNV_PERV(opaque);
> +    int reg =3D addr >> 3;
> +
> +    /* CPLT_CTRL0 to CPLT_CTRL5 */
> +    for (int i =3D 0; i < CPLT_CTRL_SIZE; i++) {
> +        if (reg =3D=3D i) {
> +            perv->control_regs.cplt_ctrl[i] =3D val;
> +            return;
> +        } else if (reg =3D=3D (i + 0x10)) {
> +            perv->control_regs.cplt_ctrl[i] |=3D val;
> +            return;
> +        } else if (reg =3D=3D (i + 0x20)) {
> +            perv->control_regs.cplt_ctrl[i] &=3D ~val;
> +            return;
> +        }
> +    }
> +
> +    switch (reg) {
> +    case CPLT_CONF0:
> +        perv->control_regs.cplt_cfg0 =3D val;
> +        break;
> +    case CPLT_CONF0_OR:
> +        perv->control_regs.cplt_cfg0 |=3D val;
> +        break;
> +    case CPLT_CONF0_CLEAR:
> +        perv->control_regs.cplt_cfg0 &=3D ~val;
> +        break;
> +    case CPLT_CONF1:
> +        perv->control_regs.cplt_cfg1 =3D val;
> +        break;
> +    case CPLT_CONF1_OR:
> +        perv->control_regs.cplt_cfg1 |=3D val;
> +        break;
> +    case CPLT_CONF1_CLEAR:
> +        perv->control_regs.cplt_cfg1 &=3D ~val;
> +        break;
> +    case CPLT_STAT0:
> +        perv->control_regs.cplt_stat0 =3D val;
> +        break;
> +    case CPLT_MASK0:
> +        perv->control_regs.cplt_mask0 =3D val;
> +        break;
> +    case CPLT_PROTECT_MODE:
> +        perv->control_regs.ctrl_protect_mode =3D val;
> +        break;
> +    case CPLT_ATOMIC_CLOCK:
> +        perv->control_regs.ctrl_atomic_lock =3D val;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: Chiplet_control_regs: Invalid xsco=
m "
> +                                 "write at 0x%" PRIx64 "\n",
> +                                 __func__, (unsigned long)reg);
> +    }
> +}
> +
> +static const MemoryRegionOps pnv_perv_control_xscom_ops =3D {
> +    .read =3D pnv_chiplet_ctrl_read,
> +    .write =3D pnv_chiplet_ctrl_write,
> +    .valid.min_access_size =3D 8,
> +    .valid.max_access_size =3D 8,
> +    .impl.min_access_size =3D 8,
> +    .impl.max_access_size =3D 8,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
> +};
> +
> +static void pnv_perv_realize(DeviceState *dev, Error **errp)
> +{
> +    PnvPerv *perv =3D PNV_PERV(dev);
> +    g_autofree char *region_name =3D NULL;
> +    region_name =3D g_strdup_printf("xscom-%s-control-regs",
> +                                   perv->parent_obj_name);
> +
> +    /* Chiplet control scoms */
> +    pnv_xscom_region_init(&perv->xscom_perv_ctrl_regs, OBJECT(perv),
> +                          &pnv_perv_control_xscom_ops, perv, region_name=
,
> +                          PNV10_XSCOM_CTRL_CHIPLET_SIZE);
> +}
> +
> +void pnv_perv_dt(PnvPerv *perv, uint32_t base_addr, void *fdt, int offse=
t)
> +{
> +    g_autofree char *name =3D NULL;
> +    int perv_offset;
> +    const char compat[] =3D "ibm,power10-perv-chiplet";

Should we provide this dt node?

powernv boot environment is basically the end of hostboot boot but
with device-tree instead of HDAT.

The way OPAL (skiboot) works when booting hostboot is to first
convert HDAT into device-tree. When booting QEMU it just uses QEMU
device-tree directly.

So adding new dt nodes is a bit strange. Normally if skiboot needs
something new, it will extend the HDAT converter to find that
thing and create a new device-tree entry from it. Then the QEMU
model would add that same dt entry.

So it's really skiboot that defines the device-tree IMO, and QEMU
should just follow it. Unless there is good reason to do something
else.

Thanks,
Nick

> +    uint32_t reg[] =3D {
> +        cpu_to_be32(base_addr),
> +        cpu_to_be32(PNV10_XSCOM_CTRL_CHIPLET_SIZE)
> +    };
> +
> +    name =3D g_strdup_printf("%s-perv@%x", perv->parent_obj_name, base_a=
ddr);
> +    perv_offset =3D fdt_add_subnode(fdt, offset, name);
> +    _FDT(perv_offset);
> +
> +    _FDT(fdt_setprop(fdt, perv_offset, "reg", reg, sizeof(reg)));
> +    _FDT(fdt_setprop(fdt, perv_offset, "compatible", compat, sizeof(comp=
at)));
> +}
> +
> +static Property pnv_perv_properties[] =3D {
> +    DEFINE_PROP_STRING("parent-obj-name", PnvPerv, parent_obj_name),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void pnv_perv_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->desc =3D "PowerNV perv chiplet";
> +    dc->realize =3D pnv_perv_realize;
> +    device_class_set_props(dc, pnv_perv_properties);
> +}
> +
> +static const TypeInfo pnv_perv_info =3D {
> +    .name          =3D TYPE_PNV_PERV,
> +    .parent        =3D TYPE_DEVICE,
> +    .instance_size =3D sizeof(PnvPerv),
> +    .class_init    =3D pnv_perv_class_init,
> +    .interfaces    =3D (InterfaceInfo[]) {
> +        { TYPE_PNV_XSCOM_INTERFACE },
> +        { }
> +    }
> +};
> +
> +static void pnv_perv_register_types(void)
> +{
> +    type_register_static(&pnv_perv_info);
> +}
> +
> +type_init(pnv_perv_register_types);
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index ea44856d43..37a7a8935d 100644
> --- a/hw/ppc/meson.build
> +++ b/hw/ppc/meson.build
> @@ -51,6 +51,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
>    'pnv_bmc.c',
>    'pnv_homer.c',
>    'pnv_pnor.c',
> +  'pnv_pervasive.c',
>  ))
>  # PowerPC 4xx boards
>  ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(


