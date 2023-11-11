Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0357E8BE3
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 18:32:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1rq3-0008J5-0u; Sat, 11 Nov 2023 12:32:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=UdCb=GY=kaod.org=clg@ozlabs.org>)
 id 1r1rq0-0008IR-Nd; Sat, 11 Nov 2023 12:32:04 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=UdCb=GY=kaod.org=clg@ozlabs.org>)
 id 1r1rpy-0007TW-OS; Sat, 11 Nov 2023 12:32:04 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SSN6S1xkZz4wy1;
 Sun, 12 Nov 2023 04:32:00 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SSN6P421Cz4wcg;
 Sun, 12 Nov 2023 04:31:57 +1100 (AEDT)
Message-ID: <37c6b37d-59e2-4a1d-8a62-fa934f4463ba@kaod.org>
Date: Sat, 11 Nov 2023 18:31:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] hw/ppc: Nest1 chiplet wiring
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 calebs@us.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.vnet.ibm.com,
 Chalapathi V <chalapathi.v@linux.ibm.com>
References: <20231107074127.31821-1-chalap1@gfwr516.rchland.ibm.com>
 <20231107074127.31821-4-chalap1@gfwr516.rchland.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231107074127.31821-4-chalap1@gfwr516.rchland.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=UdCb=GY=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 11/7/23 08:41, Chalapathi V wrote:
> From: Chalapathi V <chalapathi.v@linux.ibm.com>
> 
> This part of the patchset connects the nest1 chiplet model to p10 chip.
> 
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>   hw/ppc/pnv.c              | 14 ++++++++++++++
>   include/hw/ppc/pnv_chip.h |  2 ++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index c0e34ff..2b93cdd 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -351,6 +351,8 @@ static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
>       static const char compat[] = "ibm,power10-xscom\0ibm,xscom";
>       int i;
>   
> +    Pnv10Chip *chip10 = PNV10_CHIP(chip);
> +
>       pnv_dt_xscom(chip, fdt, 0,
>                    cpu_to_be64(PNV10_XSCOM_BASE(chip)),
>                    cpu_to_be64(PNV10_XSCOM_SIZE),
> @@ -366,6 +368,9 @@ static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
>           pnv_dt_memory(fdt, chip->chip_id, chip->ram_start, chip->ram_size);
>       }
>   
> +    /* Populate nest1_chiplet device tree */
> +    PNV_NEST1CHIPLET_GET_CLASS(&chip10->nest1_chiplet)->nest1_dt_populate(fdt);
you could call directly pnv_nest1_dt_populate() IMO.


Have you tried to start a 2 sockets machine ?

   -machine powernv10 -smp 16,sockets=2,cores=2,threads=4


Thanks,

C.



> +
>       pnv_dt_lpc(chip, fdt, 0, PNV10_LPCM_BASE(chip), PNV10_LPCM_SIZE);
>   }
>   
> @@ -1649,6 +1654,8 @@ static void pnv_chip_power10_instance_init(Object *obj)
>       object_initialize_child(obj, "occ",  &chip10->occ, TYPE_PNV10_OCC);
>       object_initialize_child(obj, "sbe",  &chip10->sbe, TYPE_PNV10_SBE);
>       object_initialize_child(obj, "homer", &chip10->homer, TYPE_PNV10_HOMER);
> +    object_initialize_child(obj, "nest1_chiplet", &chip10->nest1_chiplet,
> +                            TYPE_PNV_NEST1_CHIPLET);
>   
>       chip->num_pecs = pcc->num_pecs;
>   
> @@ -1813,6 +1820,13 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>       memory_region_add_subregion(get_system_memory(), PNV10_HOMER_BASE(chip),
>                                   &chip10->homer.regs);
>   
> +    /* nest1 chiplet control regs */
> +    if (!qdev_realize(DEVICE(&chip10->nest1_chiplet), NULL, errp)) {
> +        return;
> +    }
> +    pnv_xscom_add_subregion(chip, PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE,
> +                   &chip10->nest1_chiplet.perv_chiplet.xscom_perv_ctrl_regs);
> +
>       /* PHBs */
>       pnv_chip_power10_phb_realize(chip, &local_err);
>       if (local_err) {
> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> index 53e1d92..4bcb925 100644
> --- a/include/hw/ppc/pnv_chip.h
> +++ b/include/hw/ppc/pnv_chip.h
> @@ -4,6 +4,7 @@
>   #include "hw/pci-host/pnv_phb4.h"
>   #include "hw/ppc/pnv_core.h"
>   #include "hw/ppc/pnv_homer.h"
> +#include "hw/ppc/pnv_nest_chiplet.h"
>   #include "hw/ppc/pnv_lpc.h"
>   #include "hw/ppc/pnv_occ.h"
>   #include "hw/ppc/pnv_psi.h"
> @@ -109,6 +110,7 @@ struct Pnv10Chip {
>       PnvOCC       occ;
>       PnvSBE       sbe;
>       PnvHomer     homer;
> +    PnvNest1Chiplet nest1_chiplet;
>   
>       uint32_t     nr_quads;
>       PnvQuad      *quads;


