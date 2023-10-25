Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE6A7D61F0
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 08:57:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvXpQ-0007rg-Kf; Wed, 25 Oct 2023 02:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=4l40=GH=kaod.org=clg@ozlabs.org>)
 id 1qvXpN-0007rH-Jz; Wed, 25 Oct 2023 02:57:17 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=4l40=GH=kaod.org=clg@ozlabs.org>)
 id 1qvXpK-0007VB-IE; Wed, 25 Oct 2023 02:57:17 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SFfqd0lM6z4wx7;
 Wed, 25 Oct 2023 17:57:01 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SFfqb3Y39z4wd2;
 Wed, 25 Oct 2023 17:56:59 +1100 (AEDT)
Message-ID: <8400292d-0098-432a-a49b-ac658264c3ff@kaod.org>
Date: Wed, 25 Oct 2023 08:56:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND] ppc/pnv: Fix number of I2C engines and ports
 for power9/10
Content-Language: en-US
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, fbarrat@linux.ibm.com
References: <20231024212944.34043-1-milesg@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231024212944.34043-1-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=4l40=GH=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 10/24/23 23:29, Glenn Miles wrote:
> Power9 is supposed to have 4 PIB-connected I2C engines with the
> following number of ports on each engine:
> 
>      0: 2
>      1: 13
>      2: 2
>      3: 2
> 
> Power10 also has 4 engines but has the following number of ports
> on each engine:
> 
>      0: 14
>      1: 14
>      2: 2
>      3: 16
> 
> Current code assumes that they all have the same (maximum) number.
> This can be a problem if software expects to see a certain number
> of ports present (Power Hypervisor seems to care).
> 
> Fixed this by adding separate tables for power9 and power10 that
> map the I2C controller number to the number of I2C buses that should
> be attached for that engine.
> 
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>

you could have kept :

Reviewed-by: Cédric Le Goater <clg@kaod.org>

one comment below,

> ---
> Based-on: <20231017221434.810363-1-milesg@linux.vnet.ibm.com>
> ([PATCH] ppc/pnv: Connect PNV I2C controller to powernv10)
> 
> Changes from v1:
>      - Added i2c_ports_per_engine to PnvChipClass
>      - replaced the word "ctlr" with "engine"
> 
>   hw/ppc/pnv.c              | 14 ++++++++++----
>   include/hw/ppc/pnv_chip.h |  6 ++----
>   2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 2655b6e506..f6dc84b869 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1507,6 +1507,8 @@ static void pnv_chip_power9_pec_realize(PnvChip *chip, Error **errp)
>       }
>   }
>   
> +static int pnv_power9_i2c_ports_per_engine[PNV9_CHIP_MAX_I2C] = {2, 13, 2, 2};
> +

Generally, these class constants are located close to the class definitions
in the file.

Thanks,

C.



>   static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
>   {
>       PnvChipClass *pcc = PNV_CHIP_GET_CLASS(dev);
> @@ -1626,7 +1628,8 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
>           Object *obj =  OBJECT(&chip9->i2c[i]);
>   
>           object_property_set_int(obj, "engine", i + 1, &error_fatal);
> -        object_property_set_int(obj, "num-busses", pcc->i2c_num_ports,
> +        object_property_set_int(obj, "num-busses",
> +                                pcc->i2c_ports_per_engine[i],
>                                   &error_fatal);
>           object_property_set_link(obj, "chip", OBJECT(chip), &error_abort);
>           if (!qdev_realize(DEVICE(obj), NULL, errp)) {
> @@ -1667,7 +1670,7 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
>       dc->desc = "PowerNV Chip POWER9";
>       k->num_pecs = PNV9_CHIP_MAX_PEC;
>       k->i2c_num_engines = PNV9_CHIP_MAX_I2C;
> -    k->i2c_num_ports = PNV9_CHIP_MAX_I2C_PORTS;
> +    k->i2c_ports_per_engine = pnv_power9_i2c_ports_per_engine;
>   
>       device_class_set_parent_realize(dc, pnv_chip_power9_realize,
>                                       &k->parent_realize);
> @@ -1751,6 +1754,8 @@ static void pnv_chip_power10_phb_realize(PnvChip *chip, Error **errp)
>       }
>   }
>   
> +static int pnv_power10_i2c_ports_per_engine[PNV10_CHIP_MAX_I2C] = {14, 14, 2, 16};
> +
>   static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>   {
>       PnvChipClass *pcc = PNV_CHIP_GET_CLASS(dev);
> @@ -1877,7 +1882,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>           Object *obj =  OBJECT(&chip10->i2c[i]);
>   
>           object_property_set_int(obj, "engine", i + 1, &error_fatal);
> -        object_property_set_int(obj, "num-busses", pcc->i2c_num_ports,
> +        object_property_set_int(obj, "num-busses",
> +                                pcc->i2c_ports_per_engine[i],
>                                   &error_fatal);
>           object_property_set_link(obj, "chip", OBJECT(chip), &error_abort);
>           if (!qdev_realize(DEVICE(obj), NULL, errp)) {
> @@ -1918,7 +1924,7 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
>       dc->desc = "PowerNV Chip POWER10";
>       k->num_pecs = PNV10_CHIP_MAX_PEC;
>       k->i2c_num_engines = PNV10_CHIP_MAX_I2C;
> -    k->i2c_num_ports = PNV10_CHIP_MAX_I2C_PORTS;
> +    k->i2c_ports_per_engine = pnv_power10_i2c_ports_per_engine;
>   
>       device_class_set_parent_realize(dc, pnv_chip_power10_realize,
>                                       &k->parent_realize);
> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> index 5815d96ecf..3643e0fd86 100644
> --- a/include/hw/ppc/pnv_chip.h
> +++ b/include/hw/ppc/pnv_chip.h
> @@ -88,8 +88,7 @@ struct Pnv9Chip {
>   #define PNV9_CHIP_MAX_PEC 3
>       PnvPhb4PecState pecs[PNV9_CHIP_MAX_PEC];
>   
> -#define PNV9_CHIP_MAX_I2C 3
> -#define PNV9_CHIP_MAX_I2C_PORTS 1
> +#define PNV9_CHIP_MAX_I2C 4
>       PnvI2C      i2c[PNV9_CHIP_MAX_I2C];
>   };
>   
> @@ -122,7 +121,6 @@ struct Pnv10Chip {
>       PnvPhb4PecState pecs[PNV10_CHIP_MAX_PEC];
>   
>   #define PNV10_CHIP_MAX_I2C 4
> -#define PNV10_CHIP_MAX_I2C_PORTS 2
>       PnvI2C       i2c[PNV10_CHIP_MAX_I2C];
>   };
>   
> @@ -140,7 +138,7 @@ struct PnvChipClass {
>       uint32_t     num_phbs;
>   
>       uint32_t     i2c_num_engines;
> -    uint32_t     i2c_num_ports;
> +    int          *i2c_ports_per_engine;
>   
>       DeviceRealize parent_realize;
>   


