Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6B6746A28
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 08:56:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGZwl-0003Sa-SE; Tue, 04 Jul 2023 02:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=18er=CW=kaod.org=clg@ozlabs.org>)
 id 1qGZwi-0003SK-T8; Tue, 04 Jul 2023 02:55:32 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=18er=CW=kaod.org=clg@ozlabs.org>)
 id 1qGZwg-0001bE-6A; Tue, 04 Jul 2023 02:55:32 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QwD7n1fMyz4wxW;
 Tue,  4 Jul 2023 16:55:17 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QwD7l00bHz4wZs;
 Tue,  4 Jul 2023 16:55:14 +1000 (AEST)
Message-ID: <03314ebb-00c2-84c6-98a0-63dd94f6b449@kaod.org>
Date: Tue, 4 Jul 2023 08:55:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/5] ppc/pnv: Add P10 quad xscom model
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20230704054204.168547-1-joel@jms.id.au>
 <20230704054204.168547-4-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230704054204.168547-4-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=18er=CW=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/4/23 07:42, Joel Stanley wrote:
> Add a PnvQuad class for the P10 powernv machine. No xscoms are
> implemented yet, but this allows them to be added.
> 
> The size is reduced to avoid the quad region from overlapping with the
> core region.
> 
>    address-space: xscom-0
>      0000000000000000-00000003ffffffff (prio 0, i/o): xscom-0
>        0000000100000000-00000001000fffff (prio 0, i/o): xscom-quad.0
>        0000000100108000-0000000100907fff (prio 0, i/o): xscom-core.3
>        0000000100110000-000000010090ffff (prio 0, i/o): xscom-core.2
>        0000000100120000-000000010091ffff (prio 0, i/o): xscom-core.1
>        0000000100140000-000000010093ffff (prio 0, i/o): xscom-core.0
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
> v2: Fix unimp read message
>      Wrap lines at 80 col
>      Set size
> ---
>   include/hw/ppc/pnv_xscom.h |  2 +-
>   hw/ppc/pnv.c               |  2 +-
>   hw/ppc/pnv_core.c          | 54 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 56 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index cbe848d27ba0..f7da9a1dc617 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -129,7 +129,7 @@ struct PnvXScomInterfaceClass {
>   
>   #define PNV10_XSCOM_EQ_BASE(core)     \
>       ((uint64_t) PNV10_XSCOM_EQ(PNV10_XSCOM_EQ_CHIPLET(core)))
> -#define PNV10_XSCOM_EQ_SIZE        0x100000
> +#define PNV10_XSCOM_EQ_SIZE        0x20000
>   
>   #define PNV10_XSCOM_EC_BASE(core) \
>       ((uint64_t) PNV10_XSCOM_EQ_BASE(core) | PNV10_XSCOM_EC(core & 0x3))
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
> index 73d25409c937..e4df435b15e9 100644
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
> +        qemu_log_mask(LOG_UNIMP, "%s: reading @0x%08x\n", __func__,
> +                      offset);
> +    }
> +
> +    return val;
> +}
> +
> +static void pnv_quad_power10_xscom_write(void *opaque, hwaddr addr,
> +                                         uint64_t val, unsigned int width)
> +{
> +    uint32_t offset = addr >> 3;
> +
> +    switch (offset) {
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: writing @0x%08x\n", __func__,
> +                      offset);
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
> @@ -430,6 +471,14 @@ static void pnv_quad_power9_class_init(ObjectClass *oc, void *data)
>       pqc->xscom_size = PNV9_XSCOM_EQ_SIZE;
>   }
>   
> +static void pnv_quad_power10_class_init(ObjectClass *oc, void *data)
> +{
> +    PnvQuadClass *pqc = PNV_QUAD_CLASS(oc);
> +
> +    pqc->xscom_ops = &pnv_quad_power10_xscom_ops;
> +    pqc->xscom_size = PNV10_XSCOM_EQ_SIZE;
> +}
> +
>   static void pnv_quad_class_init(ObjectClass *oc, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(oc);
> @@ -453,6 +502,11 @@ static const TypeInfo pnv_quad_infos[] = {
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


