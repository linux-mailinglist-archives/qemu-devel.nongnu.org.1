Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A29D97653F0
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 14:30:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP05T-0001Eg-Mh; Thu, 27 Jul 2023 08:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=csIm=DN=kaod.org=clg@ozlabs.org>)
 id 1qP05H-0001EQ-Nn; Thu, 27 Jul 2023 08:27:13 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=csIm=DN=kaod.org=clg@ozlabs.org>)
 id 1qP05F-0001Q9-7n; Thu, 27 Jul 2023 08:27:11 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RBVPr4mzhz4wjG;
 Thu, 27 Jul 2023 22:26:56 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RBVPp1wdKz4wb0;
 Thu, 27 Jul 2023 22:26:54 +1000 (AEST)
Message-ID: <8d485d17-2f96-8517-6607-7344d0aa178c@kaod.org>
Date: Thu, 27 Jul 2023 14:26:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/6] hw/ppc: Always store the decrementer value
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230726182230.433945-1-npiggin@gmail.com>
 <20230726182230.433945-6-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230726182230.433945-6-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=csIm=DN=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

Hello Nick,

On 7/26/23 20:22, Nicholas Piggin wrote:
> When writing a value to the decrementer that raises an exception, the
> irq is raised, but the value is not stored so the store doesn't appear
> to have changed the register when it is read again.
> 
> Always store the write value to the register.

This change has a serious performance impact when a guest is run under
PowerNV. Could you please take a look ?

Thanks,

C.

PS: We should really introduce avocado tests for nested.
  
> Fixes: e81a982aa53 ("PPC: Clean up DECR implementation")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/ppc/ppc.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index fa60f76dd4..cd1993e9c1 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -812,6 +812,11 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
>           return;
>       }
>   
> +    /* Calculate the next timer event */
> +    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    next = muldiv64(now, tb_env->decr_freq, NANOSECONDS_PER_SECOND) + value;
> +    *nextp = next; /* nextp is in timebase units */
> +
>       /*
>        * Going from 1 -> 0 or 0 -> -1 is the event to generate a DEC interrupt.
>        *
> @@ -833,11 +838,6 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
>           (*lower_excp)(cpu);
>       }
>   
> -    /* Calculate the next timer event */
> -    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -    next = muldiv64(now, tb_env->decr_freq, NANOSECONDS_PER_SECOND) + value;
> -    *nextp = next; /* nextp is in timebase units */
> -
>       /* Adjust timer */
>       timer_mod(timer, muldiv64(next, NANOSECONDS_PER_SECOND, tb_env->decr_freq));
>   }


