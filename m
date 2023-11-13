Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E027E9883
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 10:06:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2St3-0008Ch-M0; Mon, 13 Nov 2023 04:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=R31O=G2=kaod.org=clg@ozlabs.org>)
 id 1r2Ssx-0008CV-LS; Mon, 13 Nov 2023 04:05:35 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=R31O=G2=kaod.org=clg@ozlabs.org>)
 id 1r2Ssv-0003HX-KB; Mon, 13 Nov 2023 04:05:35 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4STNn40gW1z4x5G;
 Mon, 13 Nov 2023 20:05:28 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4STNn22m0yz4x2W;
 Mon, 13 Nov 2023 20:05:26 +1100 (AEDT)
Message-ID: <dd114f3e-93e1-4fb3-80e8-45fb17725b31@kaod.org>
Date: Mon, 13 Nov 2023 10:05:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] ppc/pnv: Add pca9552 to powernv10 for PCIe hotplug
 power control
Content-Language: en-US
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
References: <20231110194925.475909-1-milesg@linux.vnet.ibm.com>
 <20231110194925.475909-2-milesg@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231110194925.475909-2-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=R31O=G2=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 11/10/23 20:49, Glenn Miles wrote:
> The Power Hypervisor code expects to see a pca9552 device connected
> to the 3rd PNV I2C engine on port 1 at I2C address 0x63 (or left-
> justified address of 0xC6).  This is used by hypervisor code to
> control PCIe slot power during hotplug events.
> 
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> ---
> Based-on: <20231024181144.4045056-3-milesg@linux.vnet.ibm.com>
> [PATCH v3 2/2] misc/pca9552: Let external devices set pca9552 inputs

Has this series been reviewed / merged ? If not, I would include the
patches in this one.

> 
>   hw/ppc/Kconfig | 1 +
>   hw/ppc/pnv.c   | 7 +++++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index 56f0475a8e..f77ca773cf 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -32,6 +32,7 @@ config POWERNV
>       select XIVE
>       select FDT_PPC
>       select PCI_POWERNV
> +    select PCA9552
>   
>   config PPC405
>       bool
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 9c29727337..7afaf1008f 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1877,6 +1877,13 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>                                 qdev_get_gpio_in(DEVICE(&chip10->psi),
>                                                  PSIHB9_IRQ_SBE_I2C));
>       }
> +
> +    /*
> +     * Add a PCA9552 I2C device for PCIe hotplug control
> +     * to engine 2, bus 1, address 0x63
> +     */
> +    i2c_slave_create_simple(chip10->i2c[2].busses[1], "pca9552", 0x63);
> +

Are all POWER10 chips wired this way (on rainier, denali, etc) ?
or is this device board specific ? If this is the case, then we
should introduce a new custom powernv10 machine. Please take a
look at the Aspeed machines for an example.


Thanks,

C.



>   }
>   
>   static uint32_t pnv_chip_power10_xscom_pcba(PnvChip *chip, uint64_t addr)


