Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D692E74341C
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 07:24:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF6cd-0001Gs-TR; Fri, 30 Jun 2023 01:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Okcj=CS=kaod.org=clg@ozlabs.org>)
 id 1qF6cO-00017z-GR; Fri, 30 Jun 2023 01:24:31 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Okcj=CS=kaod.org=clg@ozlabs.org>)
 id 1qF6cM-00069B-8I; Fri, 30 Jun 2023 01:24:28 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QskJk6pmDz4wpc;
 Fri, 30 Jun 2023 15:24:22 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QskJj0BVyz4wpb;
 Fri, 30 Jun 2023 15:24:20 +1000 (AEST)
Message-ID: <4ed31b49-1b67-e871-3aa7-e9b0134b3bf9@kaod.org>
Date: Fri, 30 Jun 2023 07:24:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/4] ppc/pnv: Subclass quad xscom callbacks
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20230630035547.80329-1-joel@jms.id.au>
 <20230630035547.80329-3-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230630035547.80329-3-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Okcj=CS=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 6/30/23 05:55, Joel Stanley wrote:
> Make the existing pnv_quad_xscom_read/write be P9 specific, in
> preparation for a different P10 callback.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>   include/hw/ppc/pnv_core.h | 12 +++++++++++-
>   hw/ppc/pnv.c              | 11 +++++++----
>   hw/ppc/pnv_core.c         | 36 ++++++++++++++++++++++++------------
>   3 files changed, 42 insertions(+), 17 deletions(-)
> 
> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> index 3d75706e95da..ab3f6d6c2843 100644
> --- a/include/hw/ppc/pnv_core.h
> +++ b/include/hw/ppc/pnv_core.h
> @@ -60,8 +60,18 @@ static inline PnvCPUState *pnv_cpu_state(PowerPCCPU *cpu)
>       return (PnvCPUState *)cpu->machine_data;
>   }
>   
> +struct PnvQuadClass {
> +    DeviceClass parent_class;
> +
> +    const MemoryRegionOps *xscom_ops;
> +};
> +
>   #define TYPE_PNV_QUAD "powernv-cpu-quad"
> -OBJECT_DECLARE_SIMPLE_TYPE(PnvQuad, PNV_QUAD)
> +
> +#define PNV_QUAD_TYPE_SUFFIX "-" TYPE_PNV_QUAD
> +#define PNV_QUAD_TYPE_NAME(cpu_model) cpu_model PNV_QUAD_TYPE_SUFFIX
> +
> +OBJECT_DECLARE_TYPE(PnvQuad, PnvQuadClass, PNV_QUAD)
>   
>   struct PnvQuad {
>       DeviceState parent_obj;
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index fc083173f346..c77fdb6747a4 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1429,14 +1429,15 @@ static void pnv_chip_power9_instance_init(Object *obj)
>   }
>   
>   static void pnv_chip_quad_realize_one(PnvChip *chip, PnvQuad *eq,
> -                                      PnvCore *pnv_core)
> +                                      PnvCore *pnv_core,
> +                                      const char *type)
>   {
>       char eq_name[32];
>       int core_id = CPU_CORE(pnv_core)->core_id;
>   
>       snprintf(eq_name, sizeof(eq_name), "eq[%d]", core_id);
>       object_initialize_child_with_props(OBJECT(chip), eq_name, eq,
> -                                       sizeof(*eq), TYPE_PNV_QUAD,
> +                                       sizeof(*eq), type,
>                                          &error_fatal, NULL);
>   
>       object_property_set_int(OBJECT(eq), "quad-id", core_id, &error_fatal);
> @@ -1454,7 +1455,8 @@ static void pnv_chip_quad_realize(Pnv9Chip *chip9, Error **errp)
>       for (i = 0; i < chip9->nr_quads; i++) {
>           PnvQuad *eq = &chip9->quads[i];
>   
> -        pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4]);
> +        pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4],
> +                                  PNV_QUAD_TYPE_NAME("power9"));
>   
>           pnv_xscom_add_subregion(chip, PNV9_XSCOM_EQ_BASE(eq->quad_id),
>                                   &eq->xscom_regs);
> @@ -1666,7 +1668,8 @@ static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
>       for (i = 0; i < chip10->nr_quads; i++) {
>           PnvQuad *eq = &chip10->quads[i];
>   
> -        pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4]);
> +        pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4],
> +                                  PNV_QUAD_TYPE_NAME("power9"));
>   
>           pnv_xscom_add_subregion(chip, PNV10_XSCOM_EQ_BASE(eq->quad_id),
>                                   &eq->xscom_regs);
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 0b1c3cccfebc..b9a57463aec4 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -407,11 +407,12 @@ static const MemoryRegionOps pnv_quad_power9_xscom_ops = {
>   static void pnv_quad_realize(DeviceState *dev, Error **errp)
>   {
>       PnvQuad *eq = PNV_QUAD(dev);
> +    PnvQuadClass *pqc = PNV_QUAD_GET_CLASS(eq);
>       char name[32];
>   
>       snprintf(name, sizeof(name), "xscom-quad.%d", eq->quad_id);
>       pnv_xscom_region_init(&eq->xscom_regs, OBJECT(dev),
> -                          &pnv_quad_power9_xscom_ops,
> +                          pqc->xscom_ops,
>                             eq, name, PNV9_XSCOM_EQ_SIZE);
>   }
>   
> @@ -420,6 +421,13 @@ static Property pnv_quad_properties[] = {
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> +static void pnv_quad_power9_class_init(ObjectClass *oc, void *data)
> +{
> +    PnvQuadClass *pqc = PNV_QUAD_CLASS(oc);
> +
> +    pqc->xscom_ops = &pnv_quad_power9_xscom_ops;
> +}
> +
>   static void pnv_quad_class_init(ObjectClass *oc, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(oc);
> @@ -429,16 +437,20 @@ static void pnv_quad_class_init(ObjectClass *oc, void *data)
>       dc->user_creatable = false;
>   }
>   
> -static const TypeInfo pnv_quad_info = {
> -    .name          = TYPE_PNV_QUAD,
> -    .parent        = TYPE_DEVICE,
> -    .instance_size = sizeof(PnvQuad),
> -    .class_init    = pnv_quad_class_init,
> +static const TypeInfo pnv_quad_infos[] = {
> +    {
> +        .name          = TYPE_PNV_QUAD,
> +        .parent        = TYPE_DEVICE,
> +        .instance_size = sizeof(PnvQuad),
> +        .class_size    = sizeof(PnvQuadClass),
> +        .class_init    = pnv_quad_class_init,
> +        .abstract      = true,
> +    },
> +    {
> +        .parent = TYPE_PNV_QUAD,
> +        .name = PNV_QUAD_TYPE_NAME("power9"),
> +        .class_init = pnv_quad_power9_class_init,
> +    },
>   };
>   
> -static void pnv_core_register_types(void)
> -{
> -    type_register_static(&pnv_quad_info);
> -}
> -
> -type_init(pnv_core_register_types)
> +DEFINE_TYPES(pnv_quad_infos);


