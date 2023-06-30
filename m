Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86386743424
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 07:25:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF6br-0008Mm-3K; Fri, 30 Jun 2023 01:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Okcj=CS=kaod.org=clg@ozlabs.org>)
 id 1qF6bl-0008MW-B1; Fri, 30 Jun 2023 01:23:49 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Okcj=CS=kaod.org=clg@ozlabs.org>)
 id 1qF6bj-0005Ns-Cu; Fri, 30 Jun 2023 01:23:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QskHx5h8jz4wpb;
 Fri, 30 Jun 2023 15:23:41 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QskHw11bSz4wZy;
 Fri, 30 Jun 2023 15:23:39 +1000 (AEST)
Message-ID: <74f6d9dd-f5ff-53fa-0c49-1b2eccbdaefd@kaod.org>
Date: Fri, 30 Jun 2023 07:23:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/4] ppc/pnv: quad xscom callbacks are P9 specific
To: Joel Stanley <joel@jms.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20230630035547.80329-1-joel@jms.id.au>
 <20230630035547.80329-2-joel@jms.id.au>
Content-Language: en-US
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230630035547.80329-2-joel@jms.id.au>
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
> Rename the to include P9 in the name in preparation for adding P10
> versions.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   hw/ppc/pnv_core.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 0bc3ad41c81c..0b1c3cccfebc 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -360,8 +360,8 @@ DEFINE_TYPES(pnv_core_infos)
>   
>   #define P9X_EX_NCU_SPEC_BAR                     0x11010
>   
> -static uint64_t pnv_quad_xscom_read(void *opaque, hwaddr addr,
> -                                    unsigned int width)
> +static uint64_t pnv_quad_power9_xscom_read(void *opaque, hwaddr addr,
> +                                           unsigned int width)
>   {
>       uint32_t offset = addr >> 3;
>       uint64_t val = -1;
> @@ -379,8 +379,8 @@ static uint64_t pnv_quad_xscom_read(void *opaque, hwaddr addr,
>       return val;
>   }
>   
> -static void pnv_quad_xscom_write(void *opaque, hwaddr addr, uint64_t val,
> -                                 unsigned int width)
> +static void pnv_quad_power9_xscom_write(void *opaque, hwaddr addr, uint64_t val,
> +                                        unsigned int width)
>   {
>       uint32_t offset = addr >> 3;
>   
> @@ -394,9 +394,9 @@ static void pnv_quad_xscom_write(void *opaque, hwaddr addr, uint64_t val,
>       }
>   }
>   
> -static const MemoryRegionOps pnv_quad_xscom_ops = {
> -    .read = pnv_quad_xscom_read,
> -    .write = pnv_quad_xscom_write,
> +static const MemoryRegionOps pnv_quad_power9_xscom_ops = {
> +    .read = pnv_quad_power9_xscom_read,
> +    .write = pnv_quad_power9_xscom_write,
>       .valid.min_access_size = 8,
>       .valid.max_access_size = 8,
>       .impl.min_access_size = 8,
> @@ -410,7 +410,8 @@ static void pnv_quad_realize(DeviceState *dev, Error **errp)
>       char name[32];
>   
>       snprintf(name, sizeof(name), "xscom-quad.%d", eq->quad_id);
> -    pnv_xscom_region_init(&eq->xscom_regs, OBJECT(dev), &pnv_quad_xscom_ops,
> +    pnv_xscom_region_init(&eq->xscom_regs, OBJECT(dev),
> +                          &pnv_quad_power9_xscom_ops,
>                             eq, name, PNV9_XSCOM_EQ_SIZE);
>   }
>   


