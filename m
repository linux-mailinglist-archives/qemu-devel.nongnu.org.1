Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2194A7F5A80
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 09:51:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r65Q9-0006Hr-P4; Thu, 23 Nov 2023 03:50:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=WthQ=HE=kaod.org=clg@ozlabs.org>)
 id 1r65Q7-0006HV-5D; Thu, 23 Nov 2023 03:50:47 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=WthQ=HE=kaod.org=clg@ozlabs.org>)
 id 1r65Q3-0007gI-Oz; Thu, 23 Nov 2023 03:50:46 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SbWzC275Kz4x2N;
 Thu, 23 Nov 2023 19:50:31 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SbWz90wxNz4wdF;
 Thu, 23 Nov 2023 19:50:28 +1100 (AEDT)
Message-ID: <1523c986-7022-4b3f-8e26-b25d8621c623@kaod.org>
Date: Thu, 23 Nov 2023 09:50:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] ppc/spapr: Introduce SPAPR_IRQ_NR_IPIS to refer
 IRQ range for CPU IPIs.
Content-Language: en-US
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, npiggin@gmail.com,
 qemu-ppc@nongnu.org
Cc: danielhb413@gmail.com, david@gibson.dropbear.id.au, qemu-devel@nongnu.org
References: <20231123055733.1002890-1-harshpb@linux.ibm.com>
 <20231123055733.1002890-2-harshpb@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231123055733.1002890-2-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=WthQ=HE=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 11/23/23 06:57, Harsh Prateek Bora wrote:
> spapr_irq_init currently uses existing macro SPAPR_XIRQ_BASE to refer to
> the range of CPU IPIs during initialization of nr-irqs property.
> It is more appropriate to have its own define which can be further
> reused as appropriate for correct interpretation.
> 
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Suggested-by: Cedric Le Goater <clg@kaod.org>

One comment below

Reviewed-by: Cédric Le Goater <clg@kaod.org>

> ---
>   include/hw/ppc/spapr_irq.h | 14 +++++++++++++-
>   hw/ppc/spapr_irq.c         |  6 ++++--
>   2 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index c22a72c9e2..4fd2d5853d 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -14,9 +14,21 @@
>   #include "qom/object.h"
>   
>   /*
> - * IRQ range offsets per device type
> + * The XIVE IRQ backend uses the same layout as the XICS backend but
> + * covers the full range of the IRQ number space. The IRQ numbers for
> + * the CPU IPIs are allocated at the bottom of this space, below 4K,
> + * to preserve compatibility with XICS which does not use that range.
> + */
> +
> +/*
> + * CPU IPI range (XIVE only)
>    */
>   #define SPAPR_IRQ_IPI        0x0
> +#define SPAPR_IRQ_NR_IPIS    0x1000
> +
> +/*
> + * IRQ range offsets per device type
> + */
>   
>   #define SPAPR_XIRQ_BASE      XICS_IRQ_BASE /* 0x1000 */
>   #define SPAPR_IRQ_EPOW       (SPAPR_XIRQ_BASE + 0x0000)
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index a0d1e1298e..97b2fc42ab 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -23,6 +23,8 @@
>   
>   #include "trace.h"
>   
> +QEMU_BUILD_BUG_ON(SPAPR_IRQ_NR_IPIS > SPAPR_XIRQ_BASE);
> +

I would have put the check in include/hw/ppc/spapr_irq.h but since
SPAPR_XIRQ_BASE is only used in hw/ppc/spapr_irq.c which is always
compiled, this is fine. You might want to change that in case a
respin is asked for.

Thanks,

C.


>   static const TypeInfo spapr_intc_info = {
>       .name = TYPE_SPAPR_INTC,
>       .parent = TYPE_INTERFACE,
> @@ -329,7 +331,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>           int i;
>   
>           dev = qdev_new(TYPE_SPAPR_XIVE);
> -        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + SPAPR_XIRQ_BASE);
> +        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + SPAPR_IRQ_NR_IPIS);
>           /*
>            * 8 XIVE END structures per CPU. One for each available
>            * priority
> @@ -356,7 +358,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>       }
>   
>       spapr->qirqs = qemu_allocate_irqs(spapr_set_irq, spapr,
> -                                      smc->nr_xirqs + SPAPR_XIRQ_BASE);
> +                                      smc->nr_xirqs + SPAPR_IRQ_NR_IPIS);
>   
>       /*
>        * Mostly we don't actually need this until reset, except that not


