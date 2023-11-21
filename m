Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ED27F25FB
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 07:55:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Kdt-0008L0-1g; Tue, 21 Nov 2023 01:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=nm9w=HC=kaod.org=clg@ozlabs.org>)
 id 1r5Kdq-0008KV-3K; Tue, 21 Nov 2023 01:53:50 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=nm9w=HC=kaod.org=clg@ozlabs.org>)
 id 1r5Kdo-0006mT-4E; Tue, 21 Nov 2023 01:53:49 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SZFTL6lXXz4x3D;
 Tue, 21 Nov 2023 17:53:42 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SZFTJ6xcqz4wcj;
 Tue, 21 Nov 2023 17:53:40 +1100 (AEDT)
Message-ID: <baf3bdeb-d6c7-40b1-89aa-2045e6443b2f@kaod.org>
Date: Tue, 21 Nov 2023 07:53:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/11] ppc/pnv: Add pca9552 to powernv10-rainier for
 PCIe hotplug power control
Content-Language: en-US
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
References: <20231120235112.1951342-1-milesg@linux.vnet.ibm.com>
 <20231120235112.1951342-5-milesg@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231120235112.1951342-5-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=nm9w=HC=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 11/21/23 00:51, Glenn Miles wrote:
> The Power Hypervisor code expects to see a pca9552 device connected
> to the 3rd PNV I2C engine on port 1 at I2C address 0x63 (or left-
> justified address of 0xC6).  This is used by hypervisor code to
> control PCIe slot power during hotplug events.
> 
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> ---
> 
> Changes from previous version:
>    -  Code moved from pnv_chip_power10_realize to pnv_rainier_i2c_init
> 
>   hw/ppc/Kconfig       |  1 +
>   hw/ppc/pnv.c         | 26 ++++++++++++++++++++++++++
>   include/hw/ppc/pnv.h |  1 +
>   3 files changed, 28 insertions(+)
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
> index 3481a1220e..9cefcd0fd6 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -790,6 +790,7 @@ static void pnv_init(MachineState *machine)
>       const char *bios_name = machine->firmware ?: FW_FILE_NAME;
>       PnvMachineState *pnv = PNV_MACHINE(machine);
>       MachineClass *mc = MACHINE_GET_CLASS(machine);
> +    PnvMachineClass *pmc = PNV_MACHINE_GET_CLASS(machine);
>       char *fw_filename;
>       long fw_size;
>       uint64_t chip_ram_start = 0;
> @@ -979,6 +980,13 @@ static void pnv_init(MachineState *machine)
>        */
>       pnv->powerdown_notifier.notify = pnv_powerdown_notify;
>       qemu_register_powerdown_notifier(&pnv->powerdown_notifier);
> +
> +    /*
> +     * Create/Connect any machine-specific I2C devices
> +     */
> +    if (pmc->i2c_init) {
> +        pmc->i2c_init(pnv);
> +    }
>   }
>   
>   /*
> @@ -1877,6 +1885,22 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>                                 qdev_get_gpio_in(DEVICE(&chip10->psi),
>                                                  PSIHB9_IRQ_SBE_I2C));
>       }
> +
> +}
> +
> +static void pnv_rainier_i2c_init(PnvMachineState *pnv)
> +{
> +    int i;
> +    for (i = 0; i < pnv->num_chips; i++) {
> +        Pnv10Chip *chip10 = PNV10_CHIP(pnv->chips[i]);
> +
> +        /*
> +         * Add a PCA9552 I2C device for PCIe hotplug control
> +         * to engine 2, bus 1, address 0x63
> +         */
> +        i2c_slave_create_simple(chip10->i2c[2].busses[1],
> +                                "pca9552", 0x63);

This could fit on one line.

The rest looks good.


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.



> +    }
>   }
>   
>   static uint32_t pnv_chip_power10_xscom_pcba(PnvChip *chip, uint64_t addr)
> @@ -2285,9 +2309,11 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
>   static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
> +    PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
>   
>       pnv_machine_p10_common_class_init(oc, data);
>       mc->desc = "IBM PowerNV (Non-Virtualized) POWER10 rainier";
> +    pmc->i2c_init = pnv_rainier_i2c_init;
>   }
>   
>   static bool pnv_machine_get_hb(Object *obj, Error **errp)
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 7e5fef7c43..110ac9aace 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -76,6 +76,7 @@ struct PnvMachineClass {
>       int compat_size;
>   
>       void (*dt_power_mgt)(PnvMachineState *pnv, void *fdt);
> +    void (*i2c_init)(PnvMachineState *pnv);
>   };
>   
>   struct PnvMachineState {


