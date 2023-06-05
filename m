Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A02722449
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 13:12:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q686v-0000U6-M3; Mon, 05 Jun 2023 07:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q686l-0000T2-Oe; Mon, 05 Jun 2023 07:10:45 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q686i-00041k-Pc; Mon, 05 Jun 2023 07:10:43 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5556e2bddf9so2196445eaf.1; 
 Mon, 05 Jun 2023 04:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685963439; x=1688555439;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q/p/eCqaRLBWUXYl2UTr/bYZ9Tzt2WJXV7x9A4/YGFQ=;
 b=EX5CBjv8WOLNUnJwIflRPer4DyjOPrFCzXEHRK/Deod9iNn8DgSFF8H6F27lVf7ryJ
 uzhlSUt/z6iBOFRe49japX24cbjWgmf99mRrXu8unWFsD9GllkTi5IxugfoRxZbT/lbv
 f+Xi+M4S8rr9oHPy/aVkTchCFqHjbX3gbRdotGvUGhqh8xWod6+W0ebNaLvzNUnzCMga
 HGq6n3ovXIpCBegHstT5Hd4n1ZsgFn16oV6BJecf9QP1xacjvXAuOr15Q+HLlvqXOOEs
 RYhGwUF4CyYMJpeu9i8IdsTP8HAzb4/NiN2XU/hdfUtbDj2bGuyA0atkjZeAKjY9y9CI
 af+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685963439; x=1688555439;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q/p/eCqaRLBWUXYl2UTr/bYZ9Tzt2WJXV7x9A4/YGFQ=;
 b=KnMcAxQI+rzx46z1kOWsYMvDHH7qN2wtn1XDGqKbFx92rqvrcruV4SJBSL3NUg1G6Q
 Os9lsLifFWBuvlxdorJCDrCryUH5qIojIJxNUQGSL8PCbff9jRfDJkk1MxzMVetxY9Ae
 6X9LgoU3kKFybMty3dMGiB4NSbhbpAvWbhA7K6+HLY15SIu0alPsMXbYJgYdjI2aIZ4D
 ppqnOF5nu1CyvAXcUeGS3+lCpOxMepx+7HzB2fXlpHm+Ufj0BF5Y5D6Od796MeTwgBpE
 kskAu5crWS5S/kq+8cZRNV/eVuO2Od7di9Ajam5t9ZdSP6QvvXHU4RrPlnTX1KvG149r
 gJ+g==
X-Gm-Message-State: AC+VfDz8Tc7lzCxwTwlKdpIid9Qt6PImgjxFG0Q+SAlRqJgPLnKGSS+w
 pte3AhV7VbZA+WuYRL5rGT0=
X-Google-Smtp-Source: ACHHUZ72shKPfLuru8zKwvQCfqJFBCzrF1U69bsXtRX3eNnwAj/CAFZWKHfHDI/CDUggmy+Q4LNb/A==
X-Received: by 2002:a4a:cb84:0:b0:558:b482:c3b3 with SMTP id
 y4-20020a4acb84000000b00558b482c3b3mr2167912ooq.1.1685963439122; 
 Mon, 05 Jun 2023 04:10:39 -0700 (PDT)
Received: from [192.168.68.107] ([177.170.117.52])
 by smtp.gmail.com with ESMTPSA id
 k15-20020a4ad98f000000b0054fcc25de1fsm3035096oou.2.2023.06.05.04.10.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 04:10:38 -0700 (PDT)
Message-ID: <081a6728-8ad9-4a05-c846-16baaa6d57f5@gmail.com>
Date: Mon, 5 Jun 2023 08:10:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 2/2] target/ppc: PMU implement PERFM interrupts
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>
References: <20230530134313.387252-1-npiggin@gmail.com>
 <20230530134313.387252-2-npiggin@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230530134313.387252-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc31.google.com
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



On 5/30/23 10:43, Nicholas Piggin wrote:
> The PMU raises a performance monitor exception (causing an interrupt
> when MSR[EE]=1) when MMCR0[PMAO] is set, and lowers it when clear.
> 
> Wire this up and implement the interrupt delivery for books. Linux perf
> record can now collect PMI-driven samples.
> 
> fire_PMC_interrupt is renamed to perfm_alert, which matches a bit closer
> to the new terminology used in the ISA and distinguishes the alert
> condition (e.g., counter overflow) from the PERFM (or EBB) interrupts.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

And queued.


Daniel

>   target/ppc/excp_helper.c |  2 +-
>   target/ppc/power8-pmu.c  | 20 +++++++++++++-------
>   2 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 0f7ed58673..4925996cf3 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -1611,6 +1611,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>       case POWERPC_EXCP_ISEG:      /* Instruction segment exception            */
>       case POWERPC_EXCP_TRACE:     /* Trace exception                          */
>       case POWERPC_EXCP_SDOOR:     /* Doorbell interrupt                       */
> +    case POWERPC_EXCP_PERFM:     /* Performance monitor interrupt            */
>           break;
>       case POWERPC_EXCP_HISI:      /* Hypervisor instruction storage exception */
>           msr |= env->error_code;
> @@ -1664,7 +1665,6 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>            */
>           return;
>       case POWERPC_EXCP_THERM:     /* Thermal interrupt                        */
> -    case POWERPC_EXCP_PERFM:     /* Embedded performance monitor interrupt   */
>       case POWERPC_EXCP_VPUA:      /* Vector assist exception                  */
>       case POWERPC_EXCP_MAINT:     /* Maintenance exception                    */
>       case POWERPC_EXCP_HV_MAINT:  /* Hypervisor Maintenance exception         */
> diff --git a/target/ppc/power8-pmu.c b/target/ppc/power8-pmu.c
> index af065115f2..48f2868f8b 100644
> --- a/target/ppc/power8-pmu.c
> +++ b/target/ppc/power8-pmu.c
> @@ -84,8 +84,16 @@ static void pmu_update_summaries(CPUPPCState *env)
>   
>   void pmu_mmcr01_updated(CPUPPCState *env)
>   {
> +    PowerPCCPU *cpu = env_archcpu(env);
> +
>       pmu_update_summaries(env);
>       hreg_update_pmu_hflags(env);
> +
> +    if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMAO)
> +        ppc_set_irq(cpu, PPC_INTERRUPT_PERFM, 1);
> +    else
> +        ppc_set_irq(cpu, PPC_INTERRUPT_PERFM, 0);
> +
>       /*
>        * Should this update overflow timers (if mmcr0 is updated) so they
>        * get set in cpu_post_load?
> @@ -282,7 +290,7 @@ void helper_store_pmc(CPUPPCState *env, uint32_t sprn, uint64_t value)
>       pmc_update_overflow_timer(env, sprn);
>   }
>   
> -static void fire_PMC_interrupt(PowerPCCPU *cpu)
> +static void perfm_alert(PowerPCCPU *cpu)
>   {
>       CPUPPCState *env = &cpu->env;
>   
> @@ -306,6 +314,7 @@ static void fire_PMC_interrupt(PowerPCCPU *cpu)
>           /* These MMCR0 bits do not require summaries or hflags update. */
>           env->spr[SPR_POWER_MMCR0] &= ~MMCR0_PMAE;
>           env->spr[SPR_POWER_MMCR0] |= MMCR0_PMAO;
> +        ppc_set_irq(cpu, PPC_INTERRUPT_PERFM, 1);
>       }
>   
>       raise_ebb_perfm_exception(env);
> @@ -314,20 +323,17 @@ static void fire_PMC_interrupt(PowerPCCPU *cpu)
>   void helper_handle_pmc5_overflow(CPUPPCState *env)
>   {
>       env->spr[SPR_POWER_PMC5] = PMC_COUNTER_NEGATIVE_VAL;
> -    fire_PMC_interrupt(env_archcpu(env));
> +    perfm_alert(env_archcpu(env));
>   }
>   
>   /* This helper assumes that the PMC is running. */
>   void helper_insns_inc(CPUPPCState *env, uint32_t num_insns)
>   {
>       bool overflow_triggered;
> -    PowerPCCPU *cpu;
>   
>       overflow_triggered = pmu_increment_insns(env, num_insns);
> -
>       if (overflow_triggered) {
> -        cpu = env_archcpu(env);
> -        fire_PMC_interrupt(cpu);
> +        perfm_alert(env_archcpu(env));
>       }
>   }
>   
> @@ -335,7 +341,7 @@ static void cpu_ppc_pmu_timer_cb(void *opaque)
>   {
>       PowerPCCPU *cpu = opaque;
>   
> -    fire_PMC_interrupt(cpu);
> +    perfm_alert(cpu);
>   }
>   
>   void cpu_ppc_pmu_init(CPUPPCState *env)

