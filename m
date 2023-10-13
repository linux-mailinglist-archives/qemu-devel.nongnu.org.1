Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 888067C7E5C
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 09:06:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCFY-0003Nw-Ps; Fri, 13 Oct 2023 03:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=fS+4=F3=kaod.org=clg@ozlabs.org>)
 id 1qrCFV-0003KA-82; Fri, 13 Oct 2023 03:06:18 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=fS+4=F3=kaod.org=clg@ozlabs.org>)
 id 1qrCFS-0004pv-Lc; Fri, 13 Oct 2023 03:06:16 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S6Hbl1fXLz4xVb;
 Fri, 13 Oct 2023 18:06:11 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S6Hbj4sxxz4xVM;
 Fri, 13 Oct 2023 18:06:09 +1100 (AEDT)
Message-ID: <0e74b396-5c15-43e9-87b7-2f87c6a7dd6c@kaod.org>
Date: Fri, 13 Oct 2023 09:06:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ppc/pnv: Connect I2C controller model to powernv9
 chip
Content-Language: en-US
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, fbarrat@linux.ibm.com
References: <20231012200851.3020858-1-milesg@linux.vnet.ibm.com>
 <20231012200851.3020858-3-milesg@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231012200851.3020858-3-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=fS+4=F3=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 10/12/23 22:08, Glenn Miles wrote:
> From: Cédric Le Goater <clg@kaod.org>
> 
> Wires up three I2C controller instances to the powernv9 chip
> XSCOM address space.
> 
> Each controller instance is wired up to a single I2C bus of
> its own.  No other I2C devices are connected to the buses
> at this time.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> [milesg: Split wiring from addition of model itself]
> [milesg: Added new commit message]
> [milesg: Moved hardcoded attributes into PnvChipClass]
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> ---
> 
> Changes in v2:
>      - Moved some hardcoded attributes into PnvChipClass
> 
>   hw/ppc/pnv.c              | 29 +++++++++++++++++++++++++++++
>   include/hw/ppc/pnv_chip.h |  8 ++++++++
>   2 files changed, 37 insertions(+)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index eb54f93986..7db6f3abe5 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1438,6 +1438,10 @@ static void pnv_chip_power9_instance_init(Object *obj)
>           object_initialize_child(obj, "pec[*]", &chip9->pecs[i],
>                                   TYPE_PNV_PHB4_PEC);
>       }
> +
> +    for (i = 0; i < pcc->i2c_num_engines; i++) {
> +        object_initialize_child(obj, "i2c[*]", &chip9->i2c[i], TYPE_PNV_I2C);
> +    }
>   }
>   
>   static void pnv_chip_quad_realize_one(PnvChip *chip, PnvQuad *eq,
> @@ -1510,6 +1514,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
>       PnvChip *chip = PNV_CHIP(dev);
>       Pnv9Psi *psi9 = &chip9->psi;
>       Error *local_err = NULL;
> +    int i;
>   
>       /* XSCOM bridge is first */
>       pnv_xscom_realize(chip, PNV9_XSCOM_SIZE, &local_err);
> @@ -1613,6 +1618,28 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
>           error_propagate(errp, local_err);
>           return;
>       }
> +
> +    /*
> +     * I2C
> +     * TODO: The number of busses is specific to each platform


I would remove the TODO now,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> +     */
> +    for (i = 0; i < pcc->i2c_num_engines; i++) {
> +        Object *obj =  OBJECT(&chip9->i2c[i]);
> +
> +        object_property_set_int(obj, "engine", i + 1, &error_fatal);
> +        object_property_set_int(obj, "num-busses", pcc->i2c_num_ports,
> +                                &error_fatal);
> +        object_property_set_link(obj, "chip", OBJECT(chip), &error_abort);
> +        if (!qdev_realize(DEVICE(obj), NULL, errp)) {
> +            return;
> +        }
> +        pnv_xscom_add_subregion(chip, PNV9_XSCOM_I2CM_BASE +
> +                               chip9->i2c[i].engine * PNV9_XSCOM_I2CM_SIZE,
> +                                &chip9->i2c[i].xscom_regs);
> +        qdev_connect_gpio_out(DEVICE(&chip9->i2c[i]), 0,
> +                              qdev_get_gpio_in(DEVICE(&chip9->psi),
> +                                               PSIHB9_IRQ_SBE_I2C));
> +    }
>   }
>   
>   static uint32_t pnv_chip_power9_xscom_pcba(PnvChip *chip, uint64_t addr)
> @@ -1640,6 +1667,8 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
>       k->xscom_pcba = pnv_chip_power9_xscom_pcba;
>       dc->desc = "PowerNV Chip POWER9";
>       k->num_pecs = PNV9_CHIP_MAX_PEC;
> +    k->i2c_num_engines = PNV9_CHIP_MAX_I2C;
> +    k->i2c_num_ports = PNV9_CHIP_MAX_I2C_PORTS;
>   
>       device_class_set_parent_realize(dc, pnv_chip_power9_realize,
>                                       &k->parent_realize);
> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> index 53e1d921d7..90cfbad1a5 100644
> --- a/include/hw/ppc/pnv_chip.h
> +++ b/include/hw/ppc/pnv_chip.h
> @@ -9,6 +9,7 @@
>   #include "hw/ppc/pnv_psi.h"
>   #include "hw/ppc/pnv_sbe.h"
>   #include "hw/ppc/pnv_xive.h"
> +#include "hw/ppc/pnv_i2c.h"
>   #include "hw/sysbus.h"
>   
>   OBJECT_DECLARE_TYPE(PnvChip, PnvChipClass,
> @@ -86,6 +87,10 @@ struct Pnv9Chip {
>   
>   #define PNV9_CHIP_MAX_PEC 3
>       PnvPhb4PecState pecs[PNV9_CHIP_MAX_PEC];
> +
> +#define PNV9_CHIP_MAX_I2C 3
> +#define PNV9_CHIP_MAX_I2C_PORTS 1
> +    PnvI2C      i2c[PNV9_CHIP_MAX_I2C];
>   };
>   
>   /*
> @@ -130,6 +135,9 @@ struct PnvChipClass {
>       uint32_t     num_pecs;
>       uint32_t     num_phbs;
>   
> +    uint32_t     i2c_num_engines;
> +    uint32_t     i2c_num_ports;
> +
>       DeviceRealize parent_realize;
>   
>       uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);


