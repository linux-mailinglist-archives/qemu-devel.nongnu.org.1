Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2B18387E8
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 08:22:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSB5u-0003mT-PU; Tue, 23 Jan 2024 02:21:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9HdW=JB=kaod.org=clg@ozlabs.org>)
 id 1rSB5m-0003jd-PF; Tue, 23 Jan 2024 02:21:07 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9HdW=JB=kaod.org=clg@ozlabs.org>)
 id 1rSB5k-0006uZ-51; Tue, 23 Jan 2024 02:21:06 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TJz5f2jxGz4wcH;
 Tue, 23 Jan 2024 18:20:54 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TJz5c3b2gz4wc8;
 Tue, 23 Jan 2024 18:20:52 +1100 (AEDT)
Message-ID: <f8c8da63-31dd-4103-9d20-4a37b57ff7a1@kaod.org>
Date: Tue, 23 Jan 2024 08:20:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] ppc/pnv: Wire ChipTOD model to powernv9 and
 powernv10 machines
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
References: <20231201121636.142694-1-npiggin@gmail.com>
 <20231201121636.142694-6-npiggin@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231201121636.142694-6-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=9HdW=JB=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 12/1/23 13:16, Nicholas Piggin wrote:
> Wire the ChipTOD model to powernv9 and powernv10 machines.
> 
> Suggested-by-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   include/hw/ppc/pnv_chip.h |  3 +++
>   hw/ppc/pnv.c              | 30 ++++++++++++++++++++++++++++++
>   2 files changed, 33 insertions(+)
> 
> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> index 0ab5c42308..bfc4772cf3 100644
> --- a/include/hw/ppc/pnv_chip.h
> +++ b/include/hw/ppc/pnv_chip.h
> @@ -2,6 +2,7 @@
>   #define PPC_PNV_CHIP_H
>   
>   #include "hw/pci-host/pnv_phb4.h"
> +#include "hw/ppc/pnv_chiptod.h"
>   #include "hw/ppc/pnv_core.h"
>   #include "hw/ppc/pnv_homer.h"
>   #include "hw/ppc/pnv_lpc.h"
> @@ -78,6 +79,7 @@ struct Pnv9Chip {
>       PnvXive      xive;
>       Pnv9Psi      psi;
>       PnvLpcController lpc;
> +    PnvChipTOD   chiptod;
>       PnvOCC       occ;
>       PnvSBE       sbe;
>       PnvHomer     homer;
> @@ -110,6 +112,7 @@ struct Pnv10Chip {
>       PnvXive2     xive;
>       Pnv9Psi      psi;
>       PnvLpcController lpc;
> +    PnvChipTOD   chiptod;
>       PnvOCC       occ;
>       PnvSBE       sbe;
>       PnvHomer     homer;
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index b949398689..d38888cb76 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1419,6 +1419,8 @@ static void pnv_chip_power9_instance_init(Object *obj)
>   
>       object_initialize_child(obj, "lpc", &chip9->lpc, TYPE_PNV9_LPC);
>   
> +    object_initialize_child(obj, "chiptod", &chip9->chiptod, TYPE_PNV9_CHIPTOD);
> +
>       object_initialize_child(obj, "occ", &chip9->occ, TYPE_PNV9_OCC);
>   
>       object_initialize_child(obj, "sbe", &chip9->sbe, TYPE_PNV9_SBE);
> @@ -1565,6 +1567,19 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
>       chip->dt_isa_nodename = g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc@0",
>                                               (uint64_t) PNV9_LPCM_BASE(chip));
>   
> +    /* ChipTOD */
> +    object_property_set_bool(OBJECT(&chip9->chiptod), "primary",
> +                             chip->chip_id == 0, &error_abort);
> +    object_property_set_bool(OBJECT(&chip9->chiptod), "secondary",
> +                             chip->chip_id == 1, &error_abort);
> +    object_property_set_link(OBJECT(&chip9->chiptod), "chip", OBJECT(chip),
> +                             &error_abort);
> +    if (!qdev_realize(DEVICE(&chip9->chiptod), NULL, errp)) {
> +        return;
> +    }
> +    pnv_xscom_add_subregion(chip, PNV9_XSCOM_CHIPTOD_BASE,
> +                            &chip9->chiptod.xscom_regs);
> +
>       /* Create the simplified OCC model */
>       if (!qdev_realize(DEVICE(&chip9->occ), NULL, errp)) {
>           return;
> @@ -1677,6 +1692,8 @@ static void pnv_chip_power10_instance_init(Object *obj)
>                                 "xive-fabric");
>       object_initialize_child(obj, "psi", &chip10->psi, TYPE_PNV10_PSI);
>       object_initialize_child(obj, "lpc", &chip10->lpc, TYPE_PNV10_LPC);
> +    object_initialize_child(obj, "chiptod", &chip10->chiptod,
> +                            TYPE_PNV10_CHIPTOD);
>       object_initialize_child(obj, "occ",  &chip10->occ, TYPE_PNV10_OCC);
>       object_initialize_child(obj, "sbe",  &chip10->sbe, TYPE_PNV10_SBE);
>       object_initialize_child(obj, "homer", &chip10->homer, TYPE_PNV10_HOMER);
> @@ -1810,6 +1827,19 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>       chip->dt_isa_nodename = g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc@0",
>                                               (uint64_t) PNV10_LPCM_BASE(chip));
>   
> +    /* ChipTOD */
> +    object_property_set_bool(OBJECT(&chip10->chiptod), "primary",
> +                             chip->chip_id == 0, &error_abort);
> +    object_property_set_bool(OBJECT(&chip10->chiptod), "secondary",
> +                             chip->chip_id == 1, &error_abort);
> +    object_property_set_link(OBJECT(&chip10->chiptod), "chip", OBJECT(chip),
> +                             &error_abort);
> +    if (!qdev_realize(DEVICE(&chip10->chiptod), NULL, errp)) {
> +        return;
> +    }
> +    pnv_xscom_add_subregion(chip, PNV10_XSCOM_CHIPTOD_BASE,
> +                            &chip10->chiptod.xscom_regs);
> +
>       /* Create the simplified OCC model */
>       if (!qdev_realize(DEVICE(&chip10->occ), NULL, errp)) {
>           return;


