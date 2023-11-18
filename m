Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D52727EFE4F
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Nov 2023 08:37:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4Fsk-0001xC-V4; Sat, 18 Nov 2023 02:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9Slt=G7=kaod.org=clg@ozlabs.org>)
 id 1r4Fsh-0001gJ-Ua; Sat, 18 Nov 2023 02:36:44 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9Slt=G7=kaod.org=clg@ozlabs.org>)
 id 1r4Fsg-0007R6-1n; Sat, 18 Nov 2023 02:36:43 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SXQZD2mgZz4x5G;
 Sat, 18 Nov 2023 18:36:36 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SXQZB5XpMz4x5m;
 Sat, 18 Nov 2023 18:36:34 +1100 (AEDT)
Message-ID: <456ef745-46c1-4dc2-baf7-ce1c146955b5@kaod.org>
Date: Sat, 18 Nov 2023 08:36:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] ppc/pnv: Fix PNV I2C invalid status after reset
Content-Language: en-US
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
References: <20231114195659.1219821-1-milesg@linux.vnet.ibm.com>
 <20231114195659.1219821-5-milesg@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231114195659.1219821-5-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=9Slt=G7=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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
> The PNV I2C Controller was clearing the status register
> after a reset without repopulating the "upper threshold
> for I2C ports", "Command Complete" and the SCL/SDA input
> level fields.
> 
> Fixed this for resets caused by a system reset as well
> as from writing to the "Immediate Reset" register.
> 
> Fixes: 263b81ee15af ("ppc/pnv: Add an I2C controller model")
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> ---


Applied to ppc-next.

Thanks,

C.


> Changes from v2:
>      -Added Fixes: tag
> 
>   hw/ppc/pnv_i2c.c | 42 ++++++++++++++++++------------------------
>   1 file changed, 18 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
> index b2c738da50..f80589157b 100644
> --- a/hw/ppc/pnv_i2c.c
> +++ b/hw/ppc/pnv_i2c.c
> @@ -462,6 +462,23 @@ static uint64_t pnv_i2c_xscom_read(void *opaque, hwaddr addr,
>       return val;
>   }
>   
> +static void pnv_i2c_reset(void *dev)
> +{
> +    PnvI2C *i2c = PNV_I2C(dev);
> +
> +    memset(i2c->regs, 0, sizeof(i2c->regs));
> +
> +    i2c->regs[I2C_STAT_REG] =
> +        SETFIELD(I2C_STAT_UPPER_THRS, 0ull, i2c->num_busses - 1) |
> +        I2C_STAT_CMD_COMP | I2C_STAT_SCL_INPUT_LEVEL |
> +        I2C_STAT_SDA_INPUT_LEVEL;
> +    i2c->regs[I2C_EXTD_STAT_REG] =
> +        SETFIELD(I2C_EXTD_STAT_FIFO_SIZE, 0ull, PNV_I2C_FIFO_SIZE) |
> +        SETFIELD(I2C_EXTD_STAT_I2C_VERSION, 0ull, 23); /* last version */
> +
> +    fifo8_reset(&i2c->fifo);
> +}
> +
>   static void pnv_i2c_xscom_write(void *opaque, hwaddr addr,
>                                   uint64_t val, unsigned size)
>   {
> @@ -499,16 +516,7 @@ static void pnv_i2c_xscom_write(void *opaque, hwaddr addr,
>           break;
>   
>       case I2C_RESET_I2C_REG:
> -        i2c->regs[I2C_MODE_REG] = 0;
> -        i2c->regs[I2C_CMD_REG] = 0;
> -        i2c->regs[I2C_WATERMARK_REG] = 0;
> -        i2c->regs[I2C_INTR_MASK_REG] = 0;
> -        i2c->regs[I2C_INTR_COND_REG] = 0;
> -        i2c->regs[I2C_INTR_RAW_COND_REG] = 0;
> -        i2c->regs[I2C_STAT_REG] = 0;
> -        i2c->regs[I2C_RESIDUAL_LEN_REG] = 0;
> -        i2c->regs[I2C_EXTD_STAT_REG] &=
> -            (I2C_EXTD_STAT_FIFO_SIZE | I2C_EXTD_STAT_I2C_VERSION);
> +        pnv_i2c_reset(i2c);
>           break;
>   
>       case I2C_RESET_ERRORS:
> @@ -620,20 +628,6 @@ static int pnv_i2c_dt_xscom(PnvXScomInterface *dev, void *fdt,
>       return 0;
>   }
>   
> -static void pnv_i2c_reset(void *dev)
> -{
> -    PnvI2C *i2c = PNV_I2C(dev);
> -
> -    memset(i2c->regs, 0, sizeof(i2c->regs));
> -
> -    i2c->regs[I2C_STAT_REG] = I2C_STAT_CMD_COMP;
> -    i2c->regs[I2C_EXTD_STAT_REG] =
> -        SETFIELD(I2C_EXTD_STAT_FIFO_SIZE, 0ull, PNV_I2C_FIFO_SIZE) |
> -        SETFIELD(I2C_EXTD_STAT_I2C_VERSION, 0ull, 23); /* last version */
> -
> -    fifo8_reset(&i2c->fifo);
> -}
> -
>   static void pnv_i2c_realize(DeviceState *dev, Error **errp)
>   {
>       PnvI2C *i2c = PNV_I2C(dev);


