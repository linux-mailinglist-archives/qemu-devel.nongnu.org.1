Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ACD726005
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 14:49:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6saX-0000S8-Of; Wed, 07 Jun 2023 08:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q6saS-0000QZ-B7; Wed, 07 Jun 2023 08:48:28 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q6saN-0002LE-Cz; Wed, 07 Jun 2023 08:48:27 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6af7593ed5fso3188836a34.0; 
 Wed, 07 Jun 2023 05:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686142102; x=1688734102;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IdhssLmBtBBGU9H2gGPzFGyGxuRa9NMgYG1Bd68Vecc=;
 b=GUw72iNJr0HLu36sU10CReHgaksfQd/xk+7ygAdH+rdPl3LxRftkNTMM96F4qMiXqO
 aevJsRZPRif4sexq07b+DFr8/IBeXagkWVrNWoO5dmtA/oohrG3b+SuhcytwTtGAX+Oh
 cZzd3EC/YUCUPrk/pOrCs7B20f0s7NdSM1vh57e+k9A5Z+yWvv/GoVGGDSAt502KANHN
 /GJr3SKqrPfRc8ZWa90jl21R5K7+Xhdqyt2jagEd3krPwLh9Yt63FNcVCUxu4/g/V/sx
 m87yGBI2Rox769Ismd4CHDbyoPWgsF6wg1zuxg5CGp+IsNeGnZsSJ6VBEs/SEZvK6F0O
 mpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686142102; x=1688734102;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IdhssLmBtBBGU9H2gGPzFGyGxuRa9NMgYG1Bd68Vecc=;
 b=dv57btyB2dcvK1MyfKSgRI2Jz1pQ0iijeavogx0OzLs8NYpiiCXNlm+r4YXB4KBLT2
 O2EpRzbIGZNVjNusD4QfWXTU9haxZrApkLKtPYizICT5QI5K96WHq6zoPWWlJlLb6l1g
 0IXtiVGficRaogWC/Xv1vyeqoGHeYWzBOx2kYUyzVS5fwJfQCrbOWiKceRwF0X3x6qpg
 H0ovph7pE5DZY0VHoalcfSp7xHrZJCq+spOAheCeA/TOeTVdK1a/2+QoolcvXEl74/7B
 pNV6IwtwsR6iM8KVm16ug0fszdK7NHg3o7Is7NjUWyz0WgQcj8MNrha17hs8QRhez3Dv
 a86A==
X-Gm-Message-State: AC+VfDyPhczNTJPjYs98mJggL3Ojp7FqJjMeWSh/gDWb+hDDfPLTCpD9
 Lkn/roBiWQVxNHYoRdD7SZ7jSHruiYM=
X-Google-Smtp-Source: ACHHUZ7HQ8ZpOwKo0w5yIuh8dswuzgEAo1915JQuwLImNEm3yae7l4mD9irnZFqHHZaBOErd+uxcIA==
X-Received: by 2002:a05:6830:4d0:b0:6b0:c74b:3bcf with SMTP id
 s16-20020a05683004d000b006b0c74b3bcfmr1936226otd.37.1686142101763; 
 Wed, 07 Jun 2023 05:48:21 -0700 (PDT)
Received: from [192.168.68.107] ([177.170.117.52])
 by smtp.gmail.com with ESMTPSA id
 g1-20020a9d6b01000000b006b28edf195bsm2361106otp.78.2023.06.07.05.48.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 05:48:20 -0700 (PDT)
Message-ID: <104da931-c436-1b44-791c-68974f40fee0@gmail.com>
Date: Wed, 7 Jun 2023 09:48:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] target/ppc: Implement gathering irq statistics
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>
References: <20230606220200.7EBCC74635C@zero.eik.bme.hu>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230606220200.7EBCC74635C@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x332.google.com
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



On 6/6/23 19:02, BALATON Zoltan wrote:
> Count exceptions which can be queried with info irq monitor command.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---

Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

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

