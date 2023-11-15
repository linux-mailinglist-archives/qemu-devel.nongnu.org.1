Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2237ED719
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 23:21:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3OEx-0003mM-OJ; Wed, 15 Nov 2023 17:20:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=a0ac=G4=kaod.org=clg@ozlabs.org>)
 id 1r3OEn-0003m8-Pr; Wed, 15 Nov 2023 17:19:58 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=a0ac=G4=kaod.org=clg@ozlabs.org>)
 id 1r3OEl-00044l-6h; Wed, 15 Nov 2023 17:19:57 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SVyJh06l5z4xNG;
 Thu, 16 Nov 2023 09:19:48 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SVyJd6RVhz4xDB;
 Thu, 16 Nov 2023 09:19:45 +1100 (AEDT)
Message-ID: <97633a7a-4f31-4cb3-b2b4-4dd181a69fb7@kaod.org>
Date: Wed, 15 Nov 2023 23:19:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] ppc/pnv: PNV I2C engines assigned incorrect XSCOM
 addresses
Content-Language: en-US
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
References: <20231114195659.1219821-1-milesg@linux.vnet.ibm.com>
 <20231114195659.1219821-4-milesg@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231114195659.1219821-4-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=a0ac=G4=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 11/14/23 20:56, Glenn Miles wrote:
> The PNV I2C engines for power9 and power10 were being assigned a base
> XSCOM address that was off by one I2C engine's address range such
> that engine 0 had engine 1's address and so on.  The xscom address
> assignment was being based on the device tree engine numbering, which
> starts at 1.  Rather than changing the device tree numbering to start
> with 0, the addressing was changed to be based on the existing device
> tree numbers minus one.
> 
> Fixes: 1ceda19c28a1 ("ppc/pnv: Connect PNV I2C controller to powernv10)
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> ---

This is 8.2 material.

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> 
> Changes from v2:
>      - Added Fixes: tag
> 
>   hw/ppc/pnv.c     | 6 ++++--
>   hw/ppc/pnv_i2c.c | 2 +-
>   2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 645379d5bf..e82e9b30ec 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1623,7 +1623,8 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
>               return;
>           }
>           pnv_xscom_add_subregion(chip, PNV9_XSCOM_I2CM_BASE +
> -                               chip9->i2c[i].engine * PNV9_XSCOM_I2CM_SIZE,
> +                                (chip9->i2c[i].engine - 1) *
> +                                        PNV9_XSCOM_I2CM_SIZE,
>                                   &chip9->i2c[i].xscom_regs);
>           qdev_connect_gpio_out(DEVICE(&chip9->i2c[i]), 0,
>                                 qdev_get_gpio_in(DEVICE(&chip9->psi),
> @@ -1871,7 +1872,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>               return;
>           }
>           pnv_xscom_add_subregion(chip, PNV10_XSCOM_I2CM_BASE +
> -                                chip10->i2c[i].engine * PNV10_XSCOM_I2CM_SIZE,
> +                                (chip10->i2c[i].engine - 1) *
> +                                        PNV10_XSCOM_I2CM_SIZE,
>                                   &chip10->i2c[i].xscom_regs);
>           qdev_connect_gpio_out(DEVICE(&chip10->i2c[i]), 0,
>                                 qdev_get_gpio_in(DEVICE(&chip10->psi),
> diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
> index f75e59e709..b2c738da50 100644
> --- a/hw/ppc/pnv_i2c.c
> +++ b/hw/ppc/pnv_i2c.c
> @@ -593,7 +593,7 @@ static int pnv_i2c_dt_xscom(PnvXScomInterface *dev, void *fdt,
>       int i2c_offset;
>       const char i2c_compat[] = "ibm,power8-i2cm\0ibm,power9-i2cm";
>       uint32_t i2c_pcba = PNV9_XSCOM_I2CM_BASE +
> -        i2c->engine * PNV9_XSCOM_I2CM_SIZE;
> +        (i2c->engine - 1) * PNV9_XSCOM_I2CM_SIZE;
>       uint32_t reg[2] = {
>           cpu_to_be32(i2c_pcba),
>           cpu_to_be32(PNV9_XSCOM_I2CM_SIZE)


