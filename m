Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B3B7CB026
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 18:48:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsQl1-00065A-5V; Mon, 16 Oct 2023 12:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=JYZe=F6=kaod.org=clg@ozlabs.org>)
 id 1qsQkw-000648-DX; Mon, 16 Oct 2023 12:47:51 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=JYZe=F6=kaod.org=clg@ozlabs.org>)
 id 1qsQkq-0005tK-Oc; Mon, 16 Oct 2023 12:47:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S8NMD4TzDz4x5K;
 Tue, 17 Oct 2023 03:47:36 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S8NMB3W7lz4x5J;
 Tue, 17 Oct 2023 03:47:34 +1100 (AEDT)
Message-ID: <2559a74c-3546-4923-a64c-6aa70fec8032@kaod.org>
Date: Mon, 16 Oct 2023 18:47:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] hw/ppc: Add pnv pervasive common chiplet units
Content-Language: en-US
To: Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 calebs@us.ibm.com, saif.abrar@linux.vnet.ibm.com
References: <20231012160610.2428-1-chalapathi.v@linux.ibm.com>
 <20231012160610.2428-2-chalapathi.v@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231012160610.2428-2-chalapathi.v@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=JYZe=F6=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/12/23 18:06, Chalapathi V wrote:
> This part of the patchset creates a common pervasive chiplet model where it
> houses the common units of a chiplets.
> 
> The chiplet control unit is common across chiplets and this commit implements
> the chiplet control registers.
> 
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
If I am correct and remember well, this models the (HW) logic
common to all chiplets part of a POWER process, connecting them to
the Pervasive bus (PCB). This "subunit" acts as a communication
engine and to operate, has a set of registers mapped in the SCOM
space of the chiplet.

Why don't you model this unit as such ? Add a new QOM model,
that's more or less PnvChipletControlRegs with a memory region
and implement the access to the registers with the routines
pnv_chiplet_ctrl_write/read.

The object should be initialized/realized under the chiplet and
its sub SCOM region mapped in the chiplet region. This would
be cleaner.

If you need a backpointer to the chiplet, you would then need to
introduce a QOIM link to the parent object with a property.

Thanks,

C.


> ---
>   hw/ppc/meson.build             |   1 +
>   hw/ppc/pnv_pervasive.c         | 151 +++++++++++++++++++++++++++++++++
>   include/hw/ppc/pnv_pervasive.h |  39 +++++++++
>   3 files changed, 191 insertions(+)
>   create mode 100644 hw/ppc/pnv_pervasive.c
>   create mode 100644 include/hw/ppc/pnv_pervasive.h
> 
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index 7c2c52434a..c80d2f6cfb 100644
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
> index 0000000000..ef337625eb
> --- /dev/null
> +++ b/hw/ppc/pnv_pervasive.c
> @@ -0,0 +1,151 @@
> +/*
> + * QEMU PowerPC pervasive common chiplet model
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
> +    return;
> +}
> diff --git a/include/hw/ppc/pnv_pervasive.h b/include/hw/ppc/pnv_pervasive.h
> new file mode 100644
> index 0000000000..53c40e473c
> --- /dev/null
> +++ b/include/hw/ppc/pnv_pervasive.h
> @@ -0,0 +1,39 @@
> +/*
> + * QEMU PowerPC pervasive common chiplet model
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
> +#ifndef PPC_PNV_PERVASIVE_H
> +#define PPC_PNV_PERVASIVE_H
> +
> +typedef struct PnvChipletControlRegs {
> +    uint64_t cplt_ctrl[6];
> +    uint64_t cplt_cfg0;
> +    uint64_t cplt_cfg1;
> +    uint64_t cplt_stat0;
> +    uint64_t cplt_mask0;
> +    uint64_t ctrl_protect_mode;
> +    uint64_t ctrl_atomic_lock;
> +} PnvChipletControlRegs;
> +
> +uint64_t pnv_chiplet_ctrl_read(PnvChipletControlRegs *ctrl_regs, hwaddr reg,
> +                unsigned size);
> +void pnv_chiplet_ctrl_write(PnvChipletControlRegs *ctrl_regs, hwaddr reg,
> +                uint64_t val, unsigned size);
> +#endif /*PPC_PNV_PERVASIVE_H */


