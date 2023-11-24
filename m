Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5BF7F6E46
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 09:34:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6RdZ-0007Ss-MS; Fri, 24 Nov 2023 03:34:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org>)
 id 1r6RdY-0007PS-Eu; Fri, 24 Nov 2023 03:34:08 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org>)
 id 1r6RdW-0007vb-NE; Fri, 24 Nov 2023 03:34:08 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Sc7Ym3KjXz4wdF;
 Fri, 24 Nov 2023 19:34:04 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sc7Yk5qLqz4wcX;
 Fri, 24 Nov 2023 19:34:02 +1100 (AEDT)
Message-ID: <1a1bc732-2879-4f59-83d5-62985141c8d9@kaod.org>
Date: Fri, 24 Nov 2023 09:34:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] ppc/pnv: Add a pca9554 I2C device to
 powernv10-rainier
Content-Language: en-US
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
References: <20231121190945.3140221-1-milesg@linux.vnet.ibm.com>
 <20231121190945.3140221-9-milesg@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231121190945.3140221-9-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
> For powernv10-rainier, the Power Hypervisor code expects to see a
> pca9554 device connected to the 3rd PNV I2C engine on port 1 at I2C
> address 0x25 (or left-justified address of 0x4A).  This is used by
> the hypervisor code to detect if a "Cable Card" is present.
> 
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
> 
> No change from previous version
> 
>   hw/misc/Kconfig     | 4 ++++
>   hw/misc/meson.build | 1 +
>   hw/ppc/Kconfig      | 1 +
>   hw/ppc/pnv.c        | 6 ++++++
>   4 files changed, 12 insertions(+)
> 
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index cc8a8c1418..c347a132c2 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -34,6 +34,10 @@ config PCA9552
>       bool
>       depends on I2C
>   
> +config PCA9554
> +    bool
> +    depends on I2C
> +
>   config I2C_ECHO
>       bool
>       default y if TEST_DEVICES
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 36c20d5637..c39410e4a7 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -4,6 +4,7 @@ system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmcoreinfo.c'))
>   system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugexit.c'))
>   system_ss.add(when: 'CONFIG_ISA_TESTDEV', if_true: files('pc-testdev.c'))
>   system_ss.add(when: 'CONFIG_PCA9552', if_true: files('pca9552.c'))
> +system_ss.add(when: 'CONFIG_PCA9554', if_true: files('pca9554.c'))
>   system_ss.add(when: 'CONFIG_PCI_TESTDEV', if_true: files('pci-testdev.c'))
>   system_ss.add(when: 'CONFIG_UNIMP', if_true: files('unimp.c'))
>   system_ss.add(when: 'CONFIG_EMPTY_SLOT', if_true: files('empty_slot.c'))
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index f77ca773cf..2302778265 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -33,6 +33,7 @@ config POWERNV
>       select FDT_PPC
>       select PCI_POWERNV
>       select PCA9552
> +    select PCA9554
>   
>   config PPC405
>       bool
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 088824fd9f..1dab7c57e8 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1918,6 +1918,12 @@ static void pnv_rainier_i2c_init(PnvMachineState *pnv)
>                                 qdev_get_gpio_in(DEVICE(hotplug), 8));
>           qdev_connect_gpio_out(DEVICE(hotplug), 4,
>                                 qdev_get_gpio_in(DEVICE(hotplug), 9));
> +
> +        /*
> +         * Add a PCA9554 I2C device for cable card presence detection
> +         * to engine 2, bus 1, address 0x25
> +         */
> +        i2c_slave_create_simple(chip10->i2c[2].busses[1], "pca9554", 0x25);
>       }
>   }
>   


