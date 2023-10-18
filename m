Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E574B7CD481
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 08:32:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt05k-0007Xt-4e; Wed, 18 Oct 2023 02:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=IJBG=GA=kaod.org=clg@ozlabs.org>)
 id 1qt05Y-0007XV-9j; Wed, 18 Oct 2023 02:31:28 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=IJBG=GA=kaod.org=clg@ozlabs.org>)
 id 1qt05U-0000XF-P8; Wed, 18 Oct 2023 02:31:27 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S9Lb76jrsz4x80;
 Wed, 18 Oct 2023 17:31:15 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9Lb62S7zz4x5l;
 Wed, 18 Oct 2023 17:31:14 +1100 (AEDT)
Message-ID: <07bbedb9-1596-4b3b-910e-c18e6d6fbbf5@kaod.org>
Date: Wed, 18 Oct 2023 08:31:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/pnv: Connect PNV I2C controller to powernv10
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, fbarrat@linux.ibm.com
References: <20231017221434.810363-1-milesg@linux.vnet.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231017221434.810363-1-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=IJBG=GA=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 10/18/23 00:14, Glenn Miles wrote:
> Wires up four I2C controller instances to the powernv10 chip
> XSCOM address space.
> 
> Each controller instance is wired up to two I2C buses of
> its own.  No other I2C devices are connected to the buses
> at this time.
> 
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> ---
> Based-on: <20231016222013.3739530-1-milesg@linux.vnet.ibm.com>
> ([PATCH v3 0/2] Add PowerNV I2C Controller Model)


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> 
>   hw/ppc/pnv.c               | 29 +++++++++++++++++++++++++++++
>   include/hw/ppc/pnv_chip.h  |  4 ++++
>   include/hw/ppc/pnv_xscom.h |  3 +++
>   3 files changed, 36 insertions(+)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index e0b3478325..2655b6e506 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1695,6 +1695,10 @@ static void pnv_chip_power10_instance_init(Object *obj)
>           object_initialize_child(obj, "pec[*]", &chip10->pecs[i],
>                                   TYPE_PNV_PHB5_PEC);
>       }
> +
> +    for (i = 0; i < pcc->i2c_num_engines; i++) {
> +        object_initialize_child(obj, "i2c[*]", &chip10->i2c[i], TYPE_PNV_I2C);
> +    }
>   }
>   
>   static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
> @@ -1753,6 +1757,7 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>       PnvChip *chip = PNV_CHIP(dev);
>       Pnv10Chip *chip10 = PNV10_CHIP(dev);
>       Error *local_err = NULL;
> +    int i;
>   
>       /* XSCOM bridge is first */
>       pnv_xscom_realize(chip, PNV10_XSCOM_SIZE, &local_err);
> @@ -1863,6 +1868,28 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>           error_propagate(errp, local_err);
>           return;
>       }
> +
> +
> +    /*
> +     * I2C
> +     */
> +    for (i = 0; i < pcc->i2c_num_engines; i++) {
> +        Object *obj =  OBJECT(&chip10->i2c[i]);
> +
> +        object_property_set_int(obj, "engine", i + 1, &error_fatal);
> +        object_property_set_int(obj, "num-busses", pcc->i2c_num_ports,
> +                                &error_fatal);
> +        object_property_set_link(obj, "chip", OBJECT(chip), &error_abort);
> +        if (!qdev_realize(DEVICE(obj), NULL, errp)) {
> +            return;
> +        }
> +        pnv_xscom_add_subregion(chip, PNV10_XSCOM_I2CM_BASE +
> +                                chip10->i2c[i].engine * PNV10_XSCOM_I2CM_SIZE,
> +                                &chip10->i2c[i].xscom_regs);
> +        qdev_connect_gpio_out(DEVICE(&chip10->i2c[i]), 0,
> +                              qdev_get_gpio_in(DEVICE(&chip10->psi),
> +                                               PSIHB9_IRQ_SBE_I2C));
> +    }
>   }
>   
>   static uint32_t pnv_chip_power10_xscom_pcba(PnvChip *chip, uint64_t addr)
> @@ -1890,6 +1917,8 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
>       k->xscom_pcba = pnv_chip_power10_xscom_pcba;
>       dc->desc = "PowerNV Chip POWER10";
>       k->num_pecs = PNV10_CHIP_MAX_PEC;
> +    k->i2c_num_engines = PNV10_CHIP_MAX_I2C;
> +    k->i2c_num_ports = PNV10_CHIP_MAX_I2C_PORTS;
>   
>       device_class_set_parent_realize(dc, pnv_chip_power10_realize,
>                                       &k->parent_realize);
> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> index 90cfbad1a5..5815d96ecf 100644
> --- a/include/hw/ppc/pnv_chip.h
> +++ b/include/hw/ppc/pnv_chip.h
> @@ -120,6 +120,10 @@ struct Pnv10Chip {
>   
>   #define PNV10_CHIP_MAX_PEC 2
>       PnvPhb4PecState pecs[PNV10_CHIP_MAX_PEC];
> +
> +#define PNV10_CHIP_MAX_I2C 4
> +#define PNV10_CHIP_MAX_I2C_PORTS 2
> +    PnvI2C       i2c[PNV10_CHIP_MAX_I2C];
>   };
>   
>   #define PNV10_PIR2FUSEDCORE(pir) (((pir) >> 3) & 0xf)
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index 0c8b873c4c..2b607b22c9 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -152,6 +152,9 @@ struct PnvXScomInterfaceClass {
>   #define PNV10_XSCOM_PSIHB_BASE     0x3011D00
>   #define PNV10_XSCOM_PSIHB_SIZE     0x100
>   
> +#define PNV10_XSCOM_I2CM_BASE      PNV9_XSCOM_I2CM_BASE
> +#define PNV10_XSCOM_I2CM_SIZE      PNV9_XSCOM_I2CM_SIZE
> +
>   #define PNV10_XSCOM_OCC_BASE       PNV9_XSCOM_OCC_BASE
>   #define PNV10_XSCOM_OCC_SIZE       PNV9_XSCOM_OCC_SIZE
>   


