Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A455574AF82
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:09:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjL9-0004r3-5a; Fri, 07 Jul 2023 07:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjKl-0004mh-Gj; Fri, 07 Jul 2023 07:09:09 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjKi-00017m-0c; Fri, 07 Jul 2023 07:09:06 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1a1fa977667so1736293fac.1; 
 Fri, 07 Jul 2023 04:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688728138; x=1691320138;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UoaLEOktCYrLnZlcHppXdlPcB9N9ZIa6RmL0ReOBWvA=;
 b=TEBqt6yO11r5Z21ZihWhgOTXl1tl3VFfgV/eBINbn65JI4Vnrgtul7AAWkM4NPkcxk
 FVv5AVAc36GmxzLX3vi2D2fp8rEXK3orPbqsgp3uYSAwUNBpbeo8FRunDfXJEdpA0s1y
 3T8uoIAVeQhBDjeBDNTW2oEmL6k7+io8X1p/WEqS/DHFbGJtAgJMnukMqv6mktZ9LLds
 4FNXQCR58bcrXZ0bttP0oSm6mQ0YTFFhP6vayG9on1X+MtZ/1fk53DSJSrw4r810wBMJ
 K3ubt4LbFF4k2vcnxwR4uwbqGzcB6HzyRAAL73dg58ePlTnAH0/jgzk5rBPnnToghGqM
 VLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688728138; x=1691320138;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UoaLEOktCYrLnZlcHppXdlPcB9N9ZIa6RmL0ReOBWvA=;
 b=GBzoacElPNBpaxmzp9twpUuKDm62lX2+u+aaoftJSxWHCKQRsady+u9jfIbfZakNoY
 KGUoEJvtsNa+GuX8TRDGedUyRuaZOLlL9Vu/WY/ZyDdxVwafSCTjXY4aQR2wuAaQ66Zw
 1ZN9HfmMMkIIJAbOhMp9PgzOh6LYKad1driKFlkRcZ60so3r020nmXPpBYp620JlxhA/
 nUxXrCxtetZFXsgxzexT4WAoPd8+3heKanlmAU3jSYI+WU4mAZVb/q1DeeP1d7KAq4Ek
 Ucugi9hVg7jz9FQXf+ZPq6/R0cGaITXWUVA1S9suPS42E1j2n2U9gP/drpA3tf6zRTVk
 +mVw==
X-Gm-Message-State: ABy/qLaNKzbndy7VhPySDf+PGD2PIPZfjaXid05O38UPD3BfssnypK81
 0ZkVtGLRr4LmQSf5QK8QYSA=
X-Google-Smtp-Source: APBJJlEPABPsIZBkqRtNQBr/vdIszwvZMOoQC/NjtOfrksb0nVWYM2lWM+mt6Vi7tHtL+9YHJYa6QA==
X-Received: by 2002:a05:6871:6a4:b0:1b0:19a4:63f5 with SMTP id
 l36-20020a05687106a400b001b019a463f5mr6437981oao.52.1688728138290; 
 Fri, 07 Jul 2023 04:08:58 -0700 (PDT)
Received: from ?IPV6:2804:14c:f435:9162::1002? ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 y82-20020a4a4555000000b005667b061eebsm766349ooa.13.2023.07.07.04.08.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 04:08:58 -0700 (PDT)
Message-ID: <fa93bf11-d4f2-7e3b-1258-5a0d8a628927@gmail.com>
Date: Fri, 7 Jul 2023 08:08:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] ppc/pnv: Add QME region for P10
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20230707071213.9924-1-joel@jms.id.au>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230707071213.9924-1-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

On 7/7/23 04:12, Joel Stanley wrote:
> The Quad Management Engine (QME) manages power related settings for its
> quad. The xscom region is separate from the quad xscoms, therefore a new
> region is added. The xscoms in a QME select a given core by selecting
> the forth nibble.
> 
> Implement dummy reads for the stop state history (SSH) and special
> wakeup (SPWU) registers. This quietens some sxcom errors when skiboot
> boots on p10.
> 
> Power9 does not have a QME.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v2:
>   Clean up extra whitespace
>   Make realize quad specific so power9 doesn't end up with the qme region
> ---
>   include/hw/ppc/pnv_core.h  |  4 ++
>   include/hw/ppc/pnv_xscom.h | 11 ++++++
>   hw/ppc/pnv.c               |  3 ++
>   hw/ppc/pnv_core.c          | 78 +++++++++++++++++++++++++++++++++++++-
>   4 files changed, 94 insertions(+), 2 deletions(-)
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
> index 23740f9d0733..eb54f93986df 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1685,6 +1685,9 @@ static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
>   
>           pnv_xscom_add_subregion(chip, PNV10_XSCOM_EQ_BASE(eq->quad_id),
>                                   &eq->xscom_regs);
> +
> +        pnv_xscom_add_subregion(chip, PNV10_XSCOM_QME_BASE(eq->quad_id),
> +                                &eq->xscom_qme_regs);
>       }
>   }
>   
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 1f244ed181d0..09eb2bf94b9e 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -493,7 +493,67 @@ static const MemoryRegionOps pnv_quad_power10_xscom_ops = {
>       .endianness = DEVICE_BIG_ENDIAN,
>   };
>   
> -static void pnv_quad_realize(DeviceState *dev, Error **errp)
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
> +static void pnv_quad_power9_realize(DeviceState *dev, Error **errp)
> +{
> +    PnvQuad *eq = PNV_QUAD(dev);
> +    PnvQuadClass *pqc = PNV_QUAD_GET_CLASS(eq);
> +    char name[32];
> +
> +    snprintf(name, sizeof(name), "xscom-quad.%d", eq->quad_id);
> +    pnv_xscom_region_init(&eq->xscom_regs, OBJECT(dev),
> +                          pqc->xscom_ops,
> +                          eq, name,
> +                          pqc->xscom_size);
> +}
> +
> +static void pnv_quad_power10_realize(DeviceState *dev, Error **errp)
>   {
>       PnvQuad *eq = PNV_QUAD(dev);
>       PnvQuadClass *pqc = PNV_QUAD_GET_CLASS(eq);
> @@ -504,6 +564,12 @@ static void pnv_quad_realize(DeviceState *dev, Error **errp)
>                             pqc->xscom_ops,
>                             eq, name,
>                             pqc->xscom_size);
> +
> +    snprintf(name, sizeof(name), "xscom-qme.%d", eq->quad_id);
> +    pnv_xscom_region_init(&eq->xscom_qme_regs, OBJECT(dev),
> +                          pqc->xscom_qme_ops,
> +                          eq, name,
> +                          pqc->xscom_qme_size);
>   }
>   
>   static Property pnv_quad_properties[] = {
> @@ -514,6 +580,9 @@ static Property pnv_quad_properties[] = {
>   static void pnv_quad_power9_class_init(ObjectClass *oc, void *data)
>   {
>       PnvQuadClass *pqc = PNV_QUAD_CLASS(oc);
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    dc->realize = pnv_quad_power9_realize;
>   
>       pqc->xscom_ops = &pnv_quad_power9_xscom_ops;
>       pqc->xscom_size = PNV9_XSCOM_EQ_SIZE;
> @@ -522,16 +591,21 @@ static void pnv_quad_power9_class_init(ObjectClass *oc, void *data)
>   static void pnv_quad_power10_class_init(ObjectClass *oc, void *data)
>   {
>       PnvQuadClass *pqc = PNV_QUAD_CLASS(oc);
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    dc->realize = pnv_quad_power10_realize;
>   
>       pqc->xscom_ops = &pnv_quad_power10_xscom_ops;
>       pqc->xscom_size = PNV10_XSCOM_EQ_SIZE;
> +
> +    pqc->xscom_qme_ops = &pnv_qme_power10_xscom_ops;
> +    pqc->xscom_qme_size = PNV10_XSCOM_QME_SIZE;
>   }
>   
>   static void pnv_quad_class_init(ObjectClass *oc, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(oc);
>   
> -    dc->realize = pnv_quad_realize;
>       device_class_set_props(dc, pnv_quad_properties);
>       dc->user_creatable = false;
>   }

