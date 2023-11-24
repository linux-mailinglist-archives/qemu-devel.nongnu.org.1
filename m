Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFE87F6E45
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 09:34:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6RdF-00079U-De; Fri, 24 Nov 2023 03:33:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org>)
 id 1r6RdD-00078s-Hl; Fri, 24 Nov 2023 03:33:47 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org>)
 id 1r6RdB-0007k6-JJ; Fri, 24 Nov 2023 03:33:47 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Sc7YJ0p7vz4wx7;
 Fri, 24 Nov 2023 19:33:40 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sc7YG3S7Hz4wcX;
 Fri, 24 Nov 2023 19:33:38 +1100 (AEDT)
Message-ID: <552b57da-8352-4860-945e-976e83152de5@kaod.org>
Date: Fri, 24 Nov 2023 09:33:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] ppc/pnv: Wire up pca9552 GPIO pins for PCIe
 hotplug power control
Content-Language: en-US
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
References: <20231121190945.3140221-1-milesg@linux.vnet.ibm.com>
 <20231121190945.3140221-6-milesg@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231121190945.3140221-6-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 11/21/23 20:09, Glenn Miles wrote:
> For power10-rainier, a pca9552 device is used for PCIe slot hotplug
> power control by the Power Hypervisor code.  The code expects that
> some time after it enables power to a PCIe slot by asserting one of
> the pca9552 GPIO pins 0-4, it should see a "power good" signal asserted
> on one of pca9552 GPIO pins 5-9.
> 
> To simulate this behavior, we simply connect the GPIO outputs for
> pins 0-4 to the GPIO inputs for pins 5-9.
> 
> Each PCIe slot is assigned 3 GPIO pins on the pca9552 device, for
> control of up to 5 PCIe slots.  The per-slot signal names are:
> 
>     SLOTx_EN.......PHYP uses this as an output to enable
>                    slot power.  We connect this to the
>                    SLOTx_PG pin to simulate a PGOOD signal.
>     SLOTx_PG.......PHYP uses this as in input to detect
>                    PGOOD for the slot.  For our purposes
>                    we just connect this to the SLOTx_EN
>                    output.
>     SLOTx_Control..PHYP uses this as an output to prevent
>                    a race condition in the real hotplug
>                    circuitry, but we can ignore this output
>                    for simulation.
> 
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
> 
> No change from previous version
> 
>   hw/ppc/pnv.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index d8d19fb065..088824fd9f 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1900,7 +1900,24 @@ static void pnv_rainier_i2c_init(PnvMachineState *pnv)
>            * Add a PCA9552 I2C device for PCIe hotplug control
>            * to engine 2, bus 1, address 0x63
>            */
> -        i2c_slave_create_simple(chip10->i2c[2].busses[1], "pca9552", 0x63);
> +        I2CSlave *hotplug = i2c_slave_create_simple(chip10->i2c[2].busses[1],
> +                                                    "pca9552", 0x63);
> +
> +        /*
> +         * Connect PCA9552 GPIO pins 0-4 (SLOTx_EN) outputs to GPIO pins 5-9
> +         * (SLOTx_PG) inputs in order to fake the pgood state of PCIe slots
> +         * after hypervisor code sets a SLOTx_EN pin high.
> +         */
> +        qdev_connect_gpio_out(DEVICE(hotplug), 0,
> +                              qdev_get_gpio_in(DEVICE(hotplug), 5));
> +        qdev_connect_gpio_out(DEVICE(hotplug), 1,
> +                              qdev_get_gpio_in(DEVICE(hotplug), 6));
> +        qdev_connect_gpio_out(DEVICE(hotplug), 2,
> +                              qdev_get_gpio_in(DEVICE(hotplug), 7));
> +        qdev_connect_gpio_out(DEVICE(hotplug), 3,
> +                              qdev_get_gpio_in(DEVICE(hotplug), 8));
> +        qdev_connect_gpio_out(DEVICE(hotplug), 4,
> +                              qdev_get_gpio_in(DEVICE(hotplug), 9));
>       }
>   }
>   


