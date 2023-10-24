Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1ED7D470C
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 07:50:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvAHI-0007Cl-SW; Tue, 24 Oct 2023 01:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=1ohf=GG=kaod.org=clg@ozlabs.org>)
 id 1qvAH1-0007C4-DX; Tue, 24 Oct 2023 01:48:15 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=1ohf=GG=kaod.org=clg@ozlabs.org>)
 id 1qvAGw-0003tw-JF; Tue, 24 Oct 2023 01:48:14 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SF1LM6MbYz4x5K;
 Tue, 24 Oct 2023 16:47:55 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SF1LL2N7rz4wx7;
 Tue, 24 Oct 2023 16:47:53 +1100 (AEDT)
Message-ID: <2aadcbcf-cfc0-45d1-aaec-51aaa09cd7a7@kaod.org>
Date: Tue, 24 Oct 2023 07:47:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/pnv: Fix number of I2C engines and ports for power9/10
Content-Language: en-US
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, fbarrat@linux.ibm.com
References: <20231023165200.3846121-1-milesg@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231023165200.3846121-1-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=1ohf=GG=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

Hello Glenn,

On 10/23/23 18:52, Glenn Miles wrote:
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

Nice ! Do you have plans to populate the I2C busses ?
  
> Fixed this by adding separate tables for power9 and power10 that
> map the I2C controller number to the number of I2C buses that should
> be attached for that engine.
> 
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> ---
> 
> Based-on: <20231017221434.810363-1-milesg@linux.vnet.ibm.com>
> ([PATCH] ppc/pnv: Connect PNV I2C controller to powernv10)
> 
>   hw/ppc/pnv.c              | 12 ++++++++----
>   include/hw/ppc/pnv_chip.h |  5 +----
>   2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 2655b6e506..6ad4a1a7b1 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1507,6 +1507,8 @@ static void pnv_chip_power9_pec_realize(PnvChip *chip, Error **errp)
>       }
>   }
>   
> +static int pnv_power9_i2c_ports_per_ctlr[PNV9_CHIP_MAX_I2C] = {2, 13, 2, 2};

The ports array could be under PnvChipClass. Anyhow,

Reviewed-by: Cédric Le Goater <clg@kaod.org>

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
> +                                pnv_power9_i2c_ports_per_ctlr[i],
>                                   &error_fatal);
>           object_property_set_link(obj, "chip", OBJECT(chip), &error_abort);
>           if (!qdev_realize(DEVICE(obj), NULL, errp)) {
> @@ -1667,7 +1670,6 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
>       dc->desc = "PowerNV Chip POWER9";
>       k->num_pecs = PNV9_CHIP_MAX_PEC;
>       k->i2c_num_engines = PNV9_CHIP_MAX_I2C;
> -    k->i2c_num_ports = PNV9_CHIP_MAX_I2C_PORTS;
>   
>       device_class_set_parent_realize(dc, pnv_chip_power9_realize,
>                                       &k->parent_realize);
> @@ -1751,6 +1753,8 @@ static void pnv_chip_power10_phb_realize(PnvChip *chip, Error **errp)
>       }
>   }
>   
> +static int pnv_power10_i2c_ports_per_ctlr[PNV10_CHIP_MAX_I2C] = {14, 14, 2, 16};
> +
>   static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>   {
>       PnvChipClass *pcc = PNV_CHIP_GET_CLASS(dev);
> @@ -1877,7 +1881,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>           Object *obj =  OBJECT(&chip10->i2c[i]);
>   
>           object_property_set_int(obj, "engine", i + 1, &error_fatal);
> -        object_property_set_int(obj, "num-busses", pcc->i2c_num_ports,
> +        object_property_set_int(obj, "num-busses",
> +                                pnv_power10_i2c_ports_per_ctlr[i],
>                                   &error_fatal);
>           object_property_set_link(obj, "chip", OBJECT(chip), &error_abort);
>           if (!qdev_realize(DEVICE(obj), NULL, errp)) {
> @@ -1918,7 +1923,6 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
>       dc->desc = "PowerNV Chip POWER10";
>       k->num_pecs = PNV10_CHIP_MAX_PEC;
>       k->i2c_num_engines = PNV10_CHIP_MAX_I2C;
> -    k->i2c_num_ports = PNV10_CHIP_MAX_I2C_PORTS;
>   
>       device_class_set_parent_realize(dc, pnv_chip_power10_realize,
>                                       &k->parent_realize);
> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> index 5815d96ecf..be1fec5698 100644
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
> @@ -140,7 +138,6 @@ struct PnvChipClass {
>       uint32_t     num_phbs;
>   
>       uint32_t     i2c_num_engines;
> -    uint32_t     i2c_num_ports;
>   
>       DeviceRealize parent_realize;
>   


