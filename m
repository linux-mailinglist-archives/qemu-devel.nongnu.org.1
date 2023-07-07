Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8587774ABBC
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 09:20:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHflC-00040E-Ur; Fri, 07 Jul 2023 03:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHfl9-0003z5-QE; Fri, 07 Jul 2023 03:20:07 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHfl7-0007TG-I6; Fri, 07 Jul 2023 03:20:07 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-55e1ae72dceso1176829eaf.3; 
 Fri, 07 Jul 2023 00:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688714403; x=1691306403;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fxWVWHsL9zLvcbUvuc5VJrt2egH/Bw+972JVEqZKs7I=;
 b=nI5LpxfQpckTRaNg+rUgQavZuE5ug65nGeKaAms7Zu5Fo6+BPQ5QvmyQcOwBN7s9IF
 pggFLpSB7mrEyK9KUHYGKOou6RIvJBzPb50WcZYHPDVygFU7ntoVxgelYLRsyKIN8OSJ
 8X1CeJXW0831to/gyYT+xT5H0nJkZTFRUATghF0tIwrxivlMTENQAlJaGbDgRBpX6mlT
 ZIeJr7DqgwVXnc00qgnsrcYdIY5LkOWilOeDfarrkf6fQUkIbf0CqtCQdyqxF1Y5/dlI
 7JFqCs/z9LX/2rmkQtqMbhYTNMqv7BiK15SWaDfLkQYkt7gzH3xL4yTR/uch/fm20PyI
 EQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688714403; x=1691306403;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fxWVWHsL9zLvcbUvuc5VJrt2egH/Bw+972JVEqZKs7I=;
 b=IECtOjcLqMzordUw4mSreZMnYL3/lG8Js+bu89gpAC/fCLyWjUBFvqlDB+N3CSRs6D
 iTCKu1mIe22ZjEj3AL/WMzN+ZGmLf4My8I9EEWAQNRanc1suan4wEXGX1vITW0+mQjsS
 F4B6NzOAmpdZr/WIZw+ujQtcJ8RByEvqPazdh0c1Uiph1veh2R/Zoo7TgObKPoT8reSJ
 GOy1OXEroT381qOQmd1YrEueqDxuklHsGac+7vJcOYLifxbkmRK/jlp7cjFshj1ndf0X
 d8iEmz7ySON9EbUXr04v2KRT/SQElb77IXkP3QFi2i+ydIen25cAq/y4VHnbcr4i43yL
 Egqg==
X-Gm-Message-State: ABy/qLY3hUKbyO9E5HMYoYVS2Yaay8ak6OzrxuinUWwsaq6APFs0fbU3
 VMikBQwtQxG3EK4pS7+XEaIImGwtLOo=
X-Google-Smtp-Source: APBJJlEsK3zvnwbzVCG2n/Pry5uk3AqVDrdxMpi13Pj76kBcDncObEsu3sujBnZFkUOP5jXfzIta5A==
X-Received: by 2002:a05:6808:4d1:b0:3a3:6331:fd74 with SMTP id
 a17-20020a05680804d100b003a36331fd74mr4125300oie.43.1688714403671; 
 Fri, 07 Jul 2023 00:20:03 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-19.dial-up.telesp.net.br.
 [201.69.66.19]) by smtp.gmail.com with ESMTPSA id
 4-20020a544184000000b003a361fbec60sm1388426oiy.47.2023.07.07.00.20.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 00:20:03 -0700 (PDT)
Message-ID: <bd65b9e8-3307-77c5-a5b9-27b4650aa623@gmail.com>
Date: Fri, 7 Jul 2023 04:20:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] target/ppc: Machine check on invalid real address
 access on POWER9/10
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20230703120301.45313-1-npiggin@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230703120301.45313-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc29.google.com
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

On 7/3/23 09:03, Nicholas Piggin wrote:
> ppc currently silently accepts invalid real address access. Catch
> these and turn them into machine checks on POWER9/10 machines.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> Since v1:
> - Only implement this for POWER9/10. Seems like previous IBM processors
>    may not catch this, trying to get info.
> 
> Since v2:
> - Split out from larger series since it is independent.
> 
>   target/ppc/cpu_init.c    |  1 +
>   target/ppc/excp_helper.c | 49 ++++++++++++++++++++++++++++++++++++++++
>   target/ppc/internal.h    |  5 ++++
>   3 files changed, 55 insertions(+)
> 
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 720aad9e05..6ac1765a8d 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7335,6 +7335,7 @@ static const struct TCGCPUOps ppc_tcg_ops = {
>     .cpu_exec_enter = ppc_cpu_exec_enter,
>     .cpu_exec_exit = ppc_cpu_exec_exit,
>     .do_unaligned_access = ppc_cpu_do_unaligned_access,
> +  .do_transaction_failed = ppc_cpu_do_transaction_failed,
>   #endif /* !CONFIG_USER_ONLY */
>   };
>   #endif /* CONFIG_TCG */
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 354392668e..e49e13a30d 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -1428,7 +1428,9 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>           /* machine check exceptions don't have ME set */
>           new_msr &= ~((target_ulong)1 << MSR_ME);
>   
> +        msr |= env->error_code;
>           break;
> +
>       case POWERPC_EXCP_DSI:       /* Data storage exception                   */
>           trace_ppc_excp_dsi(env->spr[SPR_DSISR], env->spr[SPR_DAR]);
>           break;
> @@ -3184,5 +3186,52 @@ void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
>       env->error_code = insn & 0x03FF0000;
>       cpu_loop_exit(cs);
>   }
> +
> +void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
> +                                   vaddr vaddr, unsigned size,
> +                                   MMUAccessType access_type,
> +                                   int mmu_idx, MemTxAttrs attrs,
> +                                   MemTxResult response, uintptr_t retaddr)
> +{
> +    CPUPPCState *env = cs->env_ptr;
> +
> +    switch (env->excp_model) {
> +#if defined(TARGET_PPC64)
> +    case POWERPC_EXCP_POWER9:
> +    case POWERPC_EXCP_POWER10:
> +        /*
> +         * Machine check codes can be found in processor User Manual or
> +         * Linux or skiboot source.
> +         */
> +        if (access_type == MMU_DATA_LOAD) {
> +            env->spr[SPR_DAR] = vaddr;
> +            env->spr[SPR_DSISR] = PPC_BIT(57);
> +            env->error_code = PPC_BIT(42);
> +
> +        } else if (access_type == MMU_DATA_STORE) {
> +            /*
> +             * MCE for stores in POWER is asynchronous so hardware does
> +             * not set DAR, but QEMU can do better.
> +             */
> +            env->spr[SPR_DAR] = vaddr;
> +            env->error_code = PPC_BIT(36) | PPC_BIT(43) | PPC_BIT(45);
> +            env->error_code |= PPC_BIT(42);
> +
> +        } else { /* Fetch */
> +            env->error_code = PPC_BIT(36) | PPC_BIT(44) | PPC_BIT(45);
> +        }
> +        break;
> +#endif
> +    default:
> +        /*
> +         * TODO: Check behaviour for other CPUs, for now do nothing.
> +         * Could add a basic MCE even if real hardware ignores.
> +         */
> +        return;
> +    }
> +
> +    cs->exception_index = POWERPC_EXCP_MCHECK;
> +    cpu_loop_exit_restore(cs, retaddr);
> +}
>   #endif /* CONFIG_TCG */
>   #endif /* !CONFIG_USER_ONLY */
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index 901bae6d39..57acb3212c 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -296,6 +296,11 @@ bool ppc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>   G_NORETURN void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>                                               MMUAccessType access_type, int mmu_idx,
>                                               uintptr_t retaddr);
> +void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
> +                                   vaddr addr, unsigned size,
> +                                   MMUAccessType access_type,
> +                                   int mmu_idx, MemTxAttrs attrs,
> +                                   MemTxResult response, uintptr_t retaddr);
>   #endif
>   
>   FIELD(GER_MSK, XMSK, 0, 4)

