Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F23B5743437
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 07:28:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF6cm-0001td-Iw; Fri, 30 Jun 2023 01:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Okcj=CS=kaod.org=clg@ozlabs.org>)
 id 1qF6cg-0001fe-Io; Fri, 30 Jun 2023 01:24:46 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Okcj=CS=kaod.org=clg@ozlabs.org>)
 id 1qF6ce-0006BU-BR; Fri, 30 Jun 2023 01:24:46 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QskK53lffz4wpb;
 Fri, 30 Jun 2023 15:24:41 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QskK31G3Sz4wZy;
 Fri, 30 Jun 2023 15:24:38 +1000 (AEST)
Message-ID: <2e97427b-e6a8-604a-3073-c7b7424d90d5@kaod.org>
Date: Fri, 30 Jun 2023 07:24:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/4] ppc/pnv: Add P10 quad ops
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20230630035547.80329-1-joel@jms.id.au>
 <20230630035547.80329-4-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230630035547.80329-4-joel@jms.id.au>
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
> Add a PnvQuad class for the P10 powernv machine. No xscoms are
> implemented yet, but this allows them to be added.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   hw/ppc/pnv.c      |  2 +-
>   hw/ppc/pnv_core.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index c77fdb6747a4..5f25fe985ab2 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1669,7 +1669,7 @@ static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
>           PnvQuad *eq = &chip10->quads[i];
>   
>           pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4],
> -                                  PNV_QUAD_TYPE_NAME("power9"));
> +                                  PNV_QUAD_TYPE_NAME("power10"));
>   
>           pnv_xscom_add_subregion(chip, PNV10_XSCOM_EQ_BASE(eq->quad_id),
>                                   &eq->xscom_regs);
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index b9a57463aec4..7fff2fd9e298 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -404,6 +404,47 @@ static const MemoryRegionOps pnv_quad_power9_xscom_ops = {
>       .endianness = DEVICE_BIG_ENDIAN,
>   };
>   
> +/*
> + * POWER10 Quads
> + */
> +
> +static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
> +                                            unsigned int width)
> +{
> +    uint32_t offset = addr >> 3;
> +    uint64_t val = -1;
> +
> +    switch (offset) {
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: writing @0x%08x\n", __func__,
> +                      offset);
> +    }
> +
> +    return val;
> +}
> +
> +static void pnv_quad_power10_xscom_write(void *opaque, hwaddr addr, uint64_t val,
> +                                         unsigned int width)
> +{
> +    uint32_t offset = addr >> 3;
> +
> +    switch (offset) {
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: writing @0x%08x\n", __func__,
> +                  offset);
> +    }
> +}
> +
> +static const MemoryRegionOps pnv_quad_power10_xscom_ops = {
> +    .read = pnv_quad_power10_xscom_read,
> +    .write = pnv_quad_power10_xscom_write,
> +    .valid.min_access_size = 8,
> +    .valid.max_access_size = 8,
> +    .impl.min_access_size = 8,
> +    .impl.max_access_size = 8,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +};
> +
>   static void pnv_quad_realize(DeviceState *dev, Error **errp)
>   {
>       PnvQuad *eq = PNV_QUAD(dev);
> @@ -428,6 +469,13 @@ static void pnv_quad_power9_class_init(ObjectClass *oc, void *data)
>       pqc->xscom_ops = &pnv_quad_power9_xscom_ops;
>   }
>   
> +static void pnv_quad_power10_class_init(ObjectClass *oc, void *data)
> +{
> +    PnvQuadClass *pqc = PNV_QUAD_CLASS(oc);
> +
> +    pqc->xscom_ops = &pnv_quad_power10_xscom_ops;
> +}
> +
>   static void pnv_quad_class_init(ObjectClass *oc, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(oc);
> @@ -451,6 +499,11 @@ static const TypeInfo pnv_quad_infos[] = {
>           .name = PNV_QUAD_TYPE_NAME("power9"),
>           .class_init = pnv_quad_power9_class_init,
>       },
> +    {
> +        .parent = TYPE_PNV_QUAD,
> +        .name = PNV_QUAD_TYPE_NAME("power10"),
> +        .class_init = pnv_quad_power10_class_init,
> +    },
>   };
>   
>   DEFINE_TYPES(pnv_quad_infos);


