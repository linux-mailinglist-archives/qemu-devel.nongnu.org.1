Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBE6808257
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 09:01:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rB9Ja-0001KD-SM; Thu, 07 Dec 2023 03:00:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=788X=HS=kaod.org=clg@ozlabs.org>)
 id 1rB9JY-0001Jr-Bk; Thu, 07 Dec 2023 03:00:56 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=788X=HS=kaod.org=clg@ozlabs.org>)
 id 1rB9JW-00058n-JG; Thu, 07 Dec 2023 03:00:55 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Sm6CS2DZHz4xCp;
 Thu,  7 Dec 2023 19:00:52 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sm6CP2s6Vz4wcj;
 Thu,  7 Dec 2023 19:00:49 +1100 (AEDT)
Message-ID: <72c33a18-a48e-4f76-b0dc-cbf30de79e4d@kaod.org>
Date: Thu, 7 Dec 2023 09:00:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] hw/ppc: N1 chiplet wiring
Content-Language: en-US
To: Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 calebs@us.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.vnet.ibm.com
References: <20231207024331.5237-1-chalapathi.v@linux.ibm.com>
 <20231207024331.5237-4-chalapathi.v@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231207024331.5237-4-chalapathi.v@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=788X=HS=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 12/7/23 03:43, Chalapathi V wrote:
> This part of the patchset connects the nest1 chiplet model to p10 chip.
> 
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   include/hw/ppc/pnv_chip.h |  2 ++
>   hw/ppc/pnv.c              | 15 +++++++++++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> index 0ab5c42308..9b06c8d87c 100644
> --- a/include/hw/ppc/pnv_chip.h
> +++ b/include/hw/ppc/pnv_chip.h
> @@ -4,6 +4,7 @@
>   #include "hw/pci-host/pnv_phb4.h"
>   #include "hw/ppc/pnv_core.h"
>   #include "hw/ppc/pnv_homer.h"
> +#include "hw/ppc/pnv_n1_chiplet.h"
>   #include "hw/ppc/pnv_lpc.h"
>   #include "hw/ppc/pnv_occ.h"
>   #include "hw/ppc/pnv_psi.h"
> @@ -113,6 +114,7 @@ struct Pnv10Chip {
>       PnvOCC       occ;
>       PnvSBE       sbe;
>       PnvHomer     homer;
> +    PnvN1Chiplet     n1_chiplet;
>   
>       uint32_t     nr_quads;
>       PnvQuad      *quads;
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 0297871bdd..be3e922644 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1680,6 +1680,8 @@ static void pnv_chip_power10_instance_init(Object *obj)
>       object_initialize_child(obj, "occ",  &chip10->occ, TYPE_PNV10_OCC);
>       object_initialize_child(obj, "sbe",  &chip10->sbe, TYPE_PNV10_SBE);
>       object_initialize_child(obj, "homer", &chip10->homer, TYPE_PNV10_HOMER);
> +    object_initialize_child(obj, "n1-chiplet", &chip10->n1_chiplet,
> +                            TYPE_PNV_N1_CHIPLET);
>   
>       chip->num_pecs = pcc->num_pecs;
>   
> @@ -1849,6 +1851,19 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>       memory_region_add_subregion(get_system_memory(), PNV10_HOMER_BASE(chip),
>                                   &chip10->homer.regs);
>   
> +    /* N1 chiplet */
> +    if (!qdev_realize(DEVICE(&chip10->n1_chiplet), NULL, errp)) {
> +        return;
> +    }
> +    pnv_xscom_add_subregion(chip, PNV10_XSCOM_N1_CHIPLET_CTRL_REGS_BASE,
> +             &chip10->n1_chiplet.nest_pervasive.xscom_ctrl_regs_mr);
> +
> +    pnv_xscom_add_subregion(chip, PNV10_XSCOM_N1_PB_SCOM_EQ_BASE,
> +                           &chip10->n1_chiplet.xscom_pb_eq_mr);
> +
> +    pnv_xscom_add_subregion(chip, PNV10_XSCOM_N1_PB_SCOM_ES_BASE,
> +                           &chip10->n1_chiplet.xscom_pb_es_mr);
> +
>       /* PHBs */
>       pnv_chip_power10_phb_realize(chip, &local_err);
>       if (local_err) {


