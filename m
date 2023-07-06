Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5898749583
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 08:23:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHIOF-0003Yf-8c; Thu, 06 Jul 2023 02:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=00IJ=CY=kaod.org=clg@ozlabs.org>)
 id 1qHIO3-0003PB-2g; Thu, 06 Jul 2023 02:22:44 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=00IJ=CY=kaod.org=clg@ozlabs.org>)
 id 1qHINy-0004jA-J1; Thu, 06 Jul 2023 02:22:42 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QxRK75fC7z4wxT;
 Thu,  6 Jul 2023 16:22:35 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QxRK56rgRz4wZt;
 Thu,  6 Jul 2023 16:22:33 +1000 (AEST)
Message-ID: <8f3c356d-d2bf-3c8e-4d69-1e0c5553d943@kaod.org>
Date: Thu, 6 Jul 2023 08:22:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ppc/pnv: Log all unimp warnings with similar message
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20230706024528.40065-1-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230706024528.40065-1-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=00IJ=CY=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.089,
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

On 7/6/23 04:45, Joel Stanley wrote:
> Add the function name so there's an indication as to where the message
> is coming from. Change all prints to use the offset instead of the
> address.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
> Happy to use the address instead of the offset (or print both), but I
> like the idea of being consistent.
> ---
>   hw/ppc/pnv_core.c | 34 ++++++++++++++++++----------------
>   1 file changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index ffbc29cbf4f9..3eb95670d6a3 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -85,8 +85,8 @@ static uint64_t pnv_core_power8_xscom_read(void *opaque, hwaddr addr,
>           val = 0x24f000000000000ull;
>           break;
>       default:
> -        qemu_log_mask(LOG_UNIMP, "Warning: reading reg=0x%" HWADDR_PRIx "\n",
> -                  addr);
> +        qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
> +                      offset);
>       }
>   
>       return val;
> @@ -95,8 +95,10 @@ static uint64_t pnv_core_power8_xscom_read(void *opaque, hwaddr addr,
>   static void pnv_core_power8_xscom_write(void *opaque, hwaddr addr, uint64_t val,
>                                           unsigned int width)
>   {
> -    qemu_log_mask(LOG_UNIMP, "Warning: writing to reg=0x%" HWADDR_PRIx "\n",
> -                  addr);
> +    uint32_t offset = addr >> 3;
> +
> +    qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
> +                  offset);
>   }
>   
>   static const MemoryRegionOps pnv_core_power8_xscom_ops = {
> @@ -140,8 +142,8 @@ static uint64_t pnv_core_power9_xscom_read(void *opaque, hwaddr addr,
>           val = 0;
>           break;
>       default:
> -        qemu_log_mask(LOG_UNIMP, "Warning: reading reg=0x%" HWADDR_PRIx "\n",
> -                  addr);
> +        qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
> +                      offset);
>       }
>   
>       return val;
> @@ -157,8 +159,8 @@ static void pnv_core_power9_xscom_write(void *opaque, hwaddr addr, uint64_t val,
>       case PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_OTR:
>           break;
>       default:
> -        qemu_log_mask(LOG_UNIMP, "Warning: writing to reg=0x%" HWADDR_PRIx "\n",
> -                      addr);
> +        qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
> +                      offset);
>       }
>   }
>   
> @@ -189,8 +191,8 @@ static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
>           val = 0;
>           break;
>       default:
> -        qemu_log_mask(LOG_UNIMP, "Warning: reading reg=0x%" HWADDR_PRIx "\n",
> -                  addr);
> +        qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
> +                      offset);
>       }
>   
>       return val;
> @@ -203,8 +205,8 @@ static void pnv_core_power10_xscom_write(void *opaque, hwaddr addr,
>   
>       switch (offset) {
>       default:
> -        qemu_log_mask(LOG_UNIMP, "Warning: writing to reg=0x%" HWADDR_PRIx "\n",
> -                      addr);
> +        qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
> +                      offset);
>       }
>   }
>   
> @@ -421,7 +423,7 @@ static uint64_t pnv_quad_power9_xscom_read(void *opaque, hwaddr addr,
>           val = 0;
>           break;
>       default:
> -        qemu_log_mask(LOG_UNIMP, "%s: reading @0x%08x\n", __func__,
> +        qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
>                         offset);
>       }
>   
> @@ -438,7 +440,7 @@ static void pnv_quad_power9_xscom_write(void *opaque, hwaddr addr, uint64_t val,
>       case P9X_EX_NCU_SPEC_BAR + 0x400: /* Second EX */
>           break;
>       default:
> -        qemu_log_mask(LOG_UNIMP, "%s: writing @0x%08x\n", __func__,
> +        qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
>                     offset);
>       }
>   }
> @@ -465,7 +467,7 @@ static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
>   
>       switch (offset) {
>       default:
> -        qemu_log_mask(LOG_UNIMP, "%s: reading @0x%08x\n", __func__,
> +        qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
>                         offset);
>       }
>   
> @@ -479,7 +481,7 @@ static void pnv_quad_power10_xscom_write(void *opaque, hwaddr addr,
>   
>       switch (offset) {
>       default:
> -        qemu_log_mask(LOG_UNIMP, "%s: writing @0x%08x\n", __func__,
> +        qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
>                         offset);
>       }
>   }


