Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3987F6E42
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 09:34:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Rcl-00070x-05; Fri, 24 Nov 2023 03:33:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org>)
 id 1r6Rch-000704-PZ; Fri, 24 Nov 2023 03:33:15 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org>)
 id 1r6Rcd-0007eY-21; Fri, 24 Nov 2023 03:33:12 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Sc7Xd0hFhz4wdF;
 Fri, 24 Nov 2023 19:33:05 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sc7Xb2y5dz4wcX;
 Fri, 24 Nov 2023 19:33:02 +1100 (AEDT)
Message-ID: <dc2953bd-586d-41f6-9cdb-384140c40a73@kaod.org>
Date: Fri, 24 Nov 2023 09:33:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] ppc/pnv: New powernv10-rainier machine type
Content-Language: en-US
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
References: <20231121190945.3140221-1-milesg@linux.vnet.ibm.com>
 <20231121190945.3140221-4-milesg@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231121190945.3140221-4-milesg@linux.vnet.ibm.com>
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
> Create a new powernv machine type, powernv10-rainier, that
> will contain rainier-specific devices.
> 
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
> 
> Changes from previous version:
>    - Formatting changes
>    - Capitalized "Rainier" in machine description string
>    - Changed powernv10-rainier parent to MACHINE_TYPE_NAME("powernv10")
> 
>   hw/ppc/pnv.c | 24 ++++++++++++++++++++++--
>   1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 0297871bdd..08704ce695 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -2251,7 +2251,7 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
>   }
>   
> -static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
> +static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
>       PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
> @@ -2263,7 +2263,6 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
>           { TYPE_PNV_PHB_ROOT_PORT, "version", "5" },
>       };
>   
> -    mc->desc = "IBM PowerNV (Non-Virtualized) POWER10";
>       mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
>       compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
>   
> @@ -2276,6 +2275,22 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
>   }
>   
> +static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    pnv_machine_p10_common_class_init(oc, data);
> +    mc->desc = "IBM PowerNV (Non-Virtualized) POWER10";
> +}
> +
> +static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    pnv_machine_p10_common_class_init(oc, data);
> +    mc->desc = "IBM PowerNV (Non-Virtualized) POWER10 Rainier";
> +}
> +
>   static bool pnv_machine_get_hb(Object *obj, Error **errp)
>   {
>       PnvMachineState *pnv = PNV_MACHINE(obj);
> @@ -2381,6 +2396,11 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
>       }
>   
>   static const TypeInfo types[] = {
> +    {
> +        .name          = MACHINE_TYPE_NAME("powernv10-rainier"),
> +        .parent        = MACHINE_TYPE_NAME("powernv10"),
> +        .class_init    = pnv_machine_p10_rainier_class_init,
> +    },
>       {
>           .name          = MACHINE_TYPE_NAME("powernv10"),
>           .parent        = TYPE_PNV_MACHINE,


