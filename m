Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9352B7F35D6
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 19:20:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5VML-0003ls-Rq; Tue, 21 Nov 2023 13:20:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=nm9w=HC=kaod.org=clg@ozlabs.org>)
 id 1r5VMF-0003lU-Fl; Tue, 21 Nov 2023 13:20:24 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=nm9w=HC=kaod.org=clg@ozlabs.org>)
 id 1r5VM6-0001Xz-6A; Tue, 21 Nov 2023 13:20:23 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SZXjR5XqTz4wx7;
 Wed, 22 Nov 2023 05:20:11 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SZXjQ11STz4wx5;
 Wed, 22 Nov 2023 05:20:09 +1100 (AEDT)
Message-ID: <8c22bc90-40bd-4439-bdf9-188c351c467f@kaod.org>
Date: Tue, 21 Nov 2023 19:20:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/11] ppc/pnv: Use resettable interface to reset child
 I2C buses
Content-Language: en-US
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
References: <20231120235112.1951342-1-milesg@linux.vnet.ibm.com>
 <20231120235112.1951342-9-milesg@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231120235112.1951342-9-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=nm9w=HC=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 11/21/23 00:51, Glenn Miles wrote:
> The QEMU I2C buses and devices use the resettable
> interface for resetting while the PNV I2C controller
> and parent buses and devices have not yet transitioned
> to this new interface and use the old reset strategy.
> This was preventing the I2C buses and devices wired
> to the PNV I2C controller from being reset.
> 
> The short term fix for this is to have the PNV I2C
> Controller's reset function explicitly call the resettable
> interface function, bus_cold_reset(), on all child
> I2C buses.
> 
> The long term fix should be to transition all PNV parent
> devices and buses to use the resettable interface so that
> all child buses and devices are automatically reset.
> 
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> ---


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> 
> No changes from previous version
> 
>   hw/ppc/pnv_i2c.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
> index f80589157b..9ced596b98 100644
> --- a/hw/ppc/pnv_i2c.c
> +++ b/hw/ppc/pnv_i2c.c
> @@ -628,6 +628,19 @@ static int pnv_i2c_dt_xscom(PnvXScomInterface *dev, void *fdt,
>       return 0;
>   }
>   
> +static void pnv_i2c_sys_reset(void *dev)
> +{
> +    int port;
> +    PnvI2C *i2c = PNV_I2C(dev);
> +
> +    pnv_i2c_reset(dev);
> +
> +    /* reset all buses connected to this i2c controller */
> +    for (port = 0; port < i2c->num_busses; port++) {
> +        bus_cold_reset(BUS(i2c->busses[port]));
> +    }
> +}
> +
>   static void pnv_i2c_realize(DeviceState *dev, Error **errp)
>   {
>       PnvI2C *i2c = PNV_I2C(dev);
> @@ -648,7 +661,7 @@ static void pnv_i2c_realize(DeviceState *dev, Error **errp)
>   
>       fifo8_create(&i2c->fifo, PNV_I2C_FIFO_SIZE);
>   
> -    qemu_register_reset(pnv_i2c_reset, dev);
> +    qemu_register_reset(pnv_i2c_sys_reset, dev);
>   
>       qdev_init_gpio_out(DEVICE(dev), &i2c->psi_irq, 1);
>   }


