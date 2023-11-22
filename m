Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2774C7F44F1
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 12:33:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5lRx-0001ba-FT; Wed, 22 Nov 2023 06:31:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=osAF=HD=kaod.org=clg@ozlabs.org>)
 id 1r5lRv-0001b0-9S; Wed, 22 Nov 2023 06:31:19 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=osAF=HD=kaod.org=clg@ozlabs.org>)
 id 1r5lRt-0005sK-BN; Wed, 22 Nov 2023 06:31:18 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SZzb36nF7z4xWJ;
 Wed, 22 Nov 2023 22:31:11 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SZzb2083Zz4xW9;
 Wed, 22 Nov 2023 22:31:09 +1100 (AEDT)
Message-ID: <cfcbfcd0-8d46-4360-badd-ec44de587c34@kaod.org>
Date: Wed, 22 Nov 2023 12:31:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ppc/spapr: Introduce SPAPR_NR_IPIS to refer IRQ
 range for CPU IPIs.
Content-Language: en-US
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, npiggin@gmail.com,
 qemu-ppc@nongnu.org
Cc: danielhb413@gmail.com, david@gibson.dropbear.id.au, qemu-devel@nongnu.org
References: <20231122092845.973949-1-harshpb@linux.ibm.com>
 <20231122092845.973949-2-harshpb@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231122092845.973949-2-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=osAF=HD=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

Hello Harsh,

Please add to your .git/config file:

[diff]
	orderFile = /path/to/qemu/scripts/git.orderfile


On 11/22/23 10:28, Harsh Prateek Bora wrote:
> spapr_irq_init currently uses existing macro SPAPR_XIRQ_BASE to refer to
> the range of CPU IPIs during initialization of nr-irqs property.
> It is more appropriate to have its own define which can be further
> reused as appropriate for correct interpretation.
> 
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Suggested-by: Cedric Le Goater <clg@kaod.org>
> ---
>   hw/ppc/spapr_irq.c         | 4 ++--
>   include/hw/ppc/spapr_irq.h | 1 +
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index a0d1e1298e..0c5db6b161 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -329,7 +329,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>           int i;
>   
>           dev = qdev_new(TYPE_SPAPR_XIVE);
> -        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + SPAPR_XIRQ_BASE);
> +        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + SPAPR_NR_IPIS);

SPAPR_IRQ_NR_IPIS ?

>           /*
>            * 8 XIVE END structures per CPU. One for each available
>            * priority
> @@ -356,7 +356,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>       }
>   
>       spapr->qirqs = qemu_allocate_irqs(spapr_set_irq, spapr,
> -                                      smc->nr_xirqs + SPAPR_XIRQ_BASE);
> +                                      smc->nr_xirqs + SPAPR_NR_IPIS);
>   
>       /*
>        * Mostly we don't actually need this until reset, except that not
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index c22a72c9e2..e7a80a8349 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -28,6 +28,7 @@

In include/hw/ppc/spapr_irq.h, we should describe the ranges a bit more.
See commit dcc345b61ebe and ad8de98636e7 for more info. Something like :

   /*
    * The XIVE IRQ backend uses the same layout as the XICS backend but
    * covers the full range of the IRQ number space. The IRQ numbers for
    * the CPU IPIs are allocated at the bottom of this space, below 4K,
    * to preserve compatibility with XICS which does not use that range.
    */

   /*
    * CPU IPI range (XIVE only)
    */
   #define SPAPR_IRQ_IPI        0x0
   #define SPAPR_IRQ_NR_IPIS    0x1000

   /*
    * IRQ range offsets per device type
    */
   #define SPAPR_XIRQ_BASE      XICS_IRQ_BASE /* 0x1000 */


And to make sure the ranges don't overlap, let's add :

   QEMU_BUILD_BUG_ON(SPAPR_IRQ_NR_IPIS > SPAPR_XIRQ_BASE)


Thanks,

C.



