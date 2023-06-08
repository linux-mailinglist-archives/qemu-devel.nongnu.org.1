Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A858E7278E5
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 09:34:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7A8w-0007Ty-Nw; Thu, 08 Jun 2023 03:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=uqJq=B4=kaod.org=clg@ozlabs.org>)
 id 1q7A8v-0007Tm-MK; Thu, 08 Jun 2023 03:33:13 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=uqJq=B4=kaod.org=clg@ozlabs.org>)
 id 1q7A8t-0008J5-Ea; Thu, 08 Jun 2023 03:33:13 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QcGCC4vFgz4x4K;
 Thu,  8 Jun 2023 17:32:55 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QcGC96CPCz4x4B;
 Thu,  8 Jun 2023 17:32:52 +1000 (AEST)
Message-ID: <a274071c-b2c0-8371-b10d-82a883edef1f@kaod.org>
Date: Thu, 8 Jun 2023 09:32:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] target/ppc: Implement gathering irq statistics
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20230606220200.7EBCC74635C@zero.eik.bme.hu>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230606220200.7EBCC74635C@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=uqJq=B4=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.091,
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

On 6/7/23 00:02, BALATON Zoltan wrote:
> Count exceptions which can be queried with info irq monitor command.

I don't think the TYPE_INTERRUPT_STATS_PROVIDER interface was designed
for CPUs. It is more suitable for interrupt controllers.

C.

> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   target/ppc/cpu.h         |  1 +
>   target/ppc/cpu_init.c    | 18 ++++++++++++++++++
>   target/ppc/excp_helper.c |  1 +
>   3 files changed, 20 insertions(+)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index c7c2a5534c..d3a9197e02 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1194,6 +1194,7 @@ struct CPUArchState {
>       int error_code;
>       uint32_t pending_interrupts;
>   #if !defined(CONFIG_USER_ONLY)
> +    uint64_t excp_stats[POWERPC_EXCP_NB];
>       /*
>        * This is the IRQ controller, which is implementation dependent and only
>        * relevant when emulating a complete machine. Note that this isn't used
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 05bf73296b..716f2b5d64 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -48,6 +48,7 @@
>   
>   #ifndef CONFIG_USER_ONLY
>   #include "hw/boards.h"
> +#include "hw/intc/intc.h"
>   #endif
>   
>   /* #define PPC_DEBUG_SPR */
> @@ -7123,6 +7124,16 @@ static bool ppc_cpu_is_big_endian(CPUState *cs)
>       return !FIELD_EX64(env->msr, MSR, LE);
>   }
>   
> +static bool ppc_get_irq_stats(InterruptStatsProvider *obj,
> +                              uint64_t **irq_counts, unsigned int *nb_irqs)
> +{
> +    CPUPPCState *env = &POWERPC_CPU(obj)->env;
> +
> +    *irq_counts = env->excp_stats;
> +    *nb_irqs = ARRAY_SIZE(env->excp_stats);
> +    return true;
> +}
> +
>   #ifdef CONFIG_TCG
>   static void ppc_cpu_exec_enter(CPUState *cs)
>   {
> @@ -7286,6 +7297,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
>       cc->gdb_write_register = ppc_cpu_gdb_write_register;
>   #ifndef CONFIG_USER_ONLY
>       cc->sysemu_ops = &ppc_sysemu_ops;
> +    INTERRUPT_STATS_PROVIDER_CLASS(oc)->get_statistics = ppc_get_irq_stats;
>   #endif
>   
>       cc->gdb_num_core_regs = 71;
> @@ -7323,6 +7335,12 @@ static const TypeInfo ppc_cpu_type_info = {
>       .abstract = true,
>       .class_size = sizeof(PowerPCCPUClass),
>       .class_init = ppc_cpu_class_init,
> +#ifndef CONFIG_USER_ONLY
> +    .interfaces = (InterfaceInfo[]) {
> +          { TYPE_INTERRUPT_STATS_PROVIDER },
> +          { }
> +    },
> +#endif
>   };
>   
>   #ifndef CONFIG_USER_ONLY
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index fea9221501..5480d9d2c7 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -1652,6 +1652,7 @@ static void powerpc_excp(PowerPCCPU *cpu, int excp)
>       qemu_log_mask(CPU_LOG_INT, "Raise exception at " TARGET_FMT_lx
>                     " => %s (%d) error=%02x\n", env->nip, powerpc_excp_name(excp),
>                     excp, env->error_code);
> +    env->excp_stats[excp]++;
>   
>       switch (env->excp_model) {
>       case POWERPC_EXCP_40x:


