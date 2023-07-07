Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C96174AA29
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 07:06:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHdeT-0003ZC-VI; Fri, 07 Jul 2023 01:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=P5Di=CZ=kaod.org=clg@ozlabs.org>)
 id 1qHdeJ-0003Yz-Se; Fri, 07 Jul 2023 01:04:55 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=P5Di=CZ=kaod.org=clg@ozlabs.org>)
 id 1qHdeH-0005KK-0i; Fri, 07 Jul 2023 01:04:55 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qy1Xk4jBbz4wxP;
 Fri,  7 Jul 2023 15:04:38 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qy1Xg40Lkz4wZs;
 Fri,  7 Jul 2023 15:04:35 +1000 (AEST)
Message-ID: <78344793-d55a-c8fb-bd1d-171064ad9ec7@kaod.org>
Date: Fri, 7 Jul 2023 07:04:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ppc/pnv: Add QME region for P10
To: Joel Stanley <joel@jms.id.au>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20230707040631.66021-1-joel@jms.id.au>
Content-Language: en-US
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230707040631.66021-1-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=P5Di=CZ=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.091, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 7/7/23 06:06, Joel Stanley wrote:
> The Quad Management Engine (QME) manages power related settings for its
> quad. The xscom region is separate from the quad xscoms, therefore a new
> region is added. The xscoms in a QME select a given core by selecting
> the forth nibble.
> 
> Implement dummy reads for the stop state history (SSH) and special
> wakeup (SPWU) registers. This quietens some sxcom errors when skiboot
> boots on p10.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   include/hw/ppc/pnv_core.h  |  4 +++
>   include/hw/ppc/pnv_xscom.h | 11 ++++++++
>   hw/ppc/pnv.c               |  5 ++++
>   hw/ppc/pnv_core.c          | 56 ++++++++++++++++++++++++++++++++++++++
>   4 files changed, 76 insertions(+)
> 
> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> index 77ef00f47a72..c829a18aa9c6 100644
> --- a/include/hw/ppc/pnv_core.h
> +++ b/include/hw/ppc/pnv_core.h
> @@ -65,6 +65,9 @@ struct PnvQuadClass {
>   
>       const MemoryRegionOps *xscom_ops;
>       uint64_t xscom_size;
> +
> +    const MemoryRegionOps *xscom_qme_ops;
> +    uint64_t xscom_qme_size;
>   };
>   
>   #define TYPE_PNV_QUAD "powernv-cpu-quad"
> @@ -79,5 +82,6 @@ struct PnvQuad {
>   
>       uint32_t quad_id;
>       MemoryRegion xscom_regs;
> +    MemoryRegion xscom_qme_regs;
>   };
>   #endif /* PPC_PNV_CORE_H */
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index a4c9d95dc5d3..9bc64635471e 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -127,6 +127,17 @@ struct PnvXScomInterfaceClass {
>   #define PNV10_XSCOM_EC(proc)                    \
>       ((0x2 << 16) | ((1 << (3 - (proc))) << 12))
>   
> +#define PNV10_XSCOM_QME(chiplet) \
> +        (PNV10_XSCOM_EQ(chiplet) | (0xE << 16))
> +
> +/*
> + * Make the region larger by 0x1000 (instead of starting at an offset) so the
> + * modelled addresses start from 0
> + */
> +#define PNV10_XSCOM_QME_BASE(core)     \
> +    ((uint64_t) PNV10_XSCOM_QME(PNV10_XSCOM_EQ_CHIPLET(core)))
> +#define PNV10_XSCOM_QME_SIZE        (0x8000 + 0x1000)
> +
>   #define PNV10_XSCOM_EQ_BASE(core)     \
>       ((uint64_t) PNV10_XSCOM_EQ(PNV10_XSCOM_EQ_CHIPLET(core)))
>   #define PNV10_XSCOM_EQ_SIZE        0x20000
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 5f25fe985ab2..6da25a676a0f 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1673,6 +1673,11 @@ static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
>   
>           pnv_xscom_add_subregion(chip, PNV10_XSCOM_EQ_BASE(eq->quad_id),
>                                   &eq->xscom_regs);
> +
> +        pnv_xscom_add_subregion(chip, PNV10_XSCOM_QME_BASE(eq->quad_id),
> +                                &eq->xscom_qme_regs);
> +
> +

extra new lines.

>       }
>   }
>   
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 3eb95670d6a3..35e219387918 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -496,6 +496,53 @@ static const MemoryRegionOps pnv_quad_power10_xscom_ops = {
>       .endianness = DEVICE_BIG_ENDIAN,
>   };
>   
> +#define P10_QME_SPWU_HYP 0x83c
> +#define P10_QME_SSH_HYP  0x82c
> +
> +static uint64_t pnv_qme_power10_xscom_read(void *opaque, hwaddr addr,
> +                                            unsigned int width)
> +{
> +    uint32_t offset = addr >> 3;
> +    uint64_t val = -1;
> +
> +    /*
> +     * Forth nibble selects the core within a quad, mask it to process read
> +     * for any core.
> +     */
> +    switch (offset & ~0xf000) {
> +    case P10_QME_SPWU_HYP:
> +    case P10_QME_SSH_HYP:
> +        return 0;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
> +                      offset);
> +    }
> +
> +    return val;
> +}
> +
> +static void pnv_qme_power10_xscom_write(void *opaque, hwaddr addr,
> +                                         uint64_t val, unsigned int width)
> +{
> +    uint32_t offset = addr >> 3;
> +
> +    switch (offset) {
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
> +                      offset);
> +    }
> +}
> +
> +static const MemoryRegionOps pnv_qme_power10_xscom_ops = {
> +    .read = pnv_qme_power10_xscom_read,
> +    .write = pnv_qme_power10_xscom_write,
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
> @@ -507,6 +554,12 @@ static void pnv_quad_realize(DeviceState *dev, Error **errp)
>                             pqc->xscom_ops,
>                             eq, name,
>                             pqc->xscom_size);
> +
> +    snprintf(name, sizeof(name), "xscom-qme.%d", eq->quad_id);
> +    pnv_xscom_region_init(&eq->xscom_qme_regs, OBJECT(dev),
> +                          pqc->xscom_qme_ops,
> +                          eq, name,
> +                          pqc->xscom_qme_size);

pnv_quad_realize realizes power9 and power10 quad objects but ...

>   }
>   
>   static Property pnv_quad_properties[] = {
> @@ -528,6 +581,9 @@ static void pnv_quad_power10_class_init(ObjectClass *oc, void *data)
>   
>       pqc->xscom_ops = &pnv_quad_power10_xscom_ops;
>       pqc->xscom_size = PNV10_XSCOM_EQ_SIZE;
> +
> +    pqc->xscom_qme_ops = &pnv_qme_power10_xscom_ops;
> +    pqc->xscom_qme_size = PNV10_XSCOM_QME_SIZE;

xscom_qme_size is only defined on power10 and it is 0 on power9. The region
is nevertheless initialized on power9 and never mapped.

I think we should introduce a specific realize routine for each proc now.

Thanks,

C.

>   }
>   
>   static void pnv_quad_class_init(ObjectClass *oc, void *data)


