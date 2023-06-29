Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B2D742668
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 14:28:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEqjY-0001mv-8v; Thu, 29 Jun 2023 08:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=1kQ5=CR=kaod.org=clg@ozlabs.org>)
 id 1qEqjV-0001mg-AW; Thu, 29 Jun 2023 08:26:45 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=1kQ5=CR=kaod.org=clg@ozlabs.org>)
 id 1qEqjO-00056e-0u; Thu, 29 Jun 2023 08:26:45 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QsHk65ShGz4wgk;
 Thu, 29 Jun 2023 22:26:22 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QsHk43Shmz4wbg;
 Thu, 29 Jun 2023 22:26:20 +1000 (AEST)
Message-ID: <fe741d9e-b64b-65ac-af45-a553c4aed6f8@kaod.org>
Date: Thu, 29 Jun 2023 14:26:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] target/ppc: Make HDECR underflow edge triggered
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20230625122045.15544-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230625122045.15544-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=1kQ5=CR=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.093, SPF_HELO_PASS=-0.001,
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

On 6/25/23 14:20, Nicholas Piggin wrote:
> HDEC interrupts are edge-triggered on HDECR underflow (notably different
> from DEC which is level-triggered).

yes.
  
> HDEC interrupts already clear the irq on delivery so that does not need
> to be changed.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>   hw/ppc/ppc.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index 7b7db30f95..f4fe1767d6 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -789,8 +789,8 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
>                                    QEMUTimer *timer,
>                                    void (*raise_excp)(void *),
>                                    void (*lower_excp)(PowerPCCPU *),
> -                                 target_ulong decr, target_ulong value,
> -                                 int nr_bits)
> +                                 uint32_t flags, target_ulong decr,
> +                                 target_ulong value, int nr_bits)
>   {
>       CPUPPCState *env = &cpu->env;
>       ppc_tb_t *tb_env = env->tb_env;
> @@ -820,15 +820,15 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
>        * On MSB edge based DEC implementations the MSB going from 0 -> 1 triggers
>        * an edge interrupt, so raise it here too.
>        */
> -    if (((tb_env->flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
> -        ((tb_env->flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
> +    if (((flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
> +        ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
>             && signed_decr >= 0)) {
>           (*raise_excp)(cpu);
>           return;
>       }
>   
>       /* On MSB level based systems a 0 for the MSB stops interrupt delivery */
> -    if (signed_value >= 0 && (tb_env->flags & PPC_DECR_UNDERFLOW_LEVEL)) {
> +    if (signed_value >= 0 && (flags & PPC_DECR_UNDERFLOW_LEVEL)) {
>           (*lower_excp)(cpu);
>       }
>   
> @@ -847,8 +847,8 @@ static inline void _cpu_ppc_store_decr(PowerPCCPU *cpu, target_ulong decr,
>       ppc_tb_t *tb_env = cpu->env.tb_env;
>   
>       __cpu_ppc_store_decr(cpu, &tb_env->decr_next, tb_env->decr_timer,
> -                         tb_env->decr_timer->cb, &cpu_ppc_decr_lower, decr,
> -                         value, nr_bits);
> +                         tb_env->decr_timer->cb, &cpu_ppc_decr_lower,
> +                         tb_env->flags, decr, value, nr_bits);
>   }
>   
>   void cpu_ppc_store_decr(CPUPPCState *env, target_ulong value)
> @@ -877,8 +877,10 @@ static inline void _cpu_ppc_store_hdecr(PowerPCCPU *cpu, target_ulong hdecr,
>       ppc_tb_t *tb_env = cpu->env.tb_env;
>   
>       if (tb_env->hdecr_timer != NULL) {
> +        /* HDECR (Book3S 64bit) is edge-based, not level like DECR */
>           __cpu_ppc_store_decr(cpu, &tb_env->hdecr_next, tb_env->hdecr_timer,
>                                tb_env->hdecr_timer->cb, &cpu_ppc_hdecr_lower,
> +                             PPC_DECR_UNDERFLOW_TRIGGERED,
>                                hdecr, value, nr_bits);
>       }
>   }


