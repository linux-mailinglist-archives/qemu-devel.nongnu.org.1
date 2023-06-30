Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC7D744020
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 18:52:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFHLM-0002wF-2V; Fri, 30 Jun 2023 12:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFHLK-0002w2-JR; Fri, 30 Jun 2023 12:51:34 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFHLI-0002s6-UG; Fri, 30 Jun 2023 12:51:34 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6b71ee710edso1770337a34.2; 
 Fri, 30 Jun 2023 09:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688143891; x=1690735891;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3ZwaSX8sXIsuPasXw7dCwD69GQObsr+dSR3PceIodPo=;
 b=rqcjKDqobfyqeXJUuhKcVK94A9jv5qJw+0YALQF8gp6CVNXvyMknuROOwNdzC9sIfh
 TdWP/4YNUS8OquD1qMHTCnnOZ7GaA6E3a7p9Cq3OzrdT3g327VP6emC1+Lo+roAb71vz
 1JN7FZpwnrPcA5RAO1JIKjdoEQoIrtBuNBCRMTqqunmDFZ+GHqlFvGVyHyorGzgyhXxH
 6Hez64oGa5NvtmT+7cgKhOPVeySp4nRwU3fOqTMjXk3FpFBhriV7ebzKG7M3gn7PxRb0
 mB/odha+KCJ4UEk8UhsSwhqhNA0TCWuVZe+rRMWGJlTU279NfyozbpHFgzvsnauXl1zp
 MYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688143891; x=1690735891;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3ZwaSX8sXIsuPasXw7dCwD69GQObsr+dSR3PceIodPo=;
 b=Y/nkFpdiEyLLUiz2mvGurpfnoTKNItSw2LTNXP9j3nwFNhUomjnYjGItPOiWcf4vdy
 HKJSMP2FXBwq8Eake5MogfXHExU4ap5XgsfnVoHZKAY15Zfwv9EmUtbhpZgRt9vx/pMV
 86vBf8N7UL4y+K75EVtmjx5oOA97VXaAyOWyBpjxc6F4++WBrgUCpei7ZSFs7ttjtuka
 QW6gv7eO+smudWcIl6fV2d8fjDay2XzX4anCIsZFTKPQXgbc4XUjfc56pZ183lpbRHSP
 OTnmGBNA77willnMbRzuceGjSg1RRWI3vgsQivTrBwZy8n6uZRYEeviNEYGuiZKQGu5V
 8t4A==
X-Gm-Message-State: ABy/qLaqfwbaOitHWU+ErZNoKjDwxuR6CVzT7DuVM66ilOURF32l34MA
 qYIyQI3e1TX/Zj2l/tGwBKp/YNylw5w=
X-Google-Smtp-Source: APBJJlGMIREJ0+h5/RzG5AnrpHz30kPyUANBYTpAxRSuZ3LLKA/HrqRHXXRheNupnyvR551PmzD1Zg==
X-Received: by 2002:a05:6870:9125:b0:19c:b5bc:e868 with SMTP id
 o37-20020a056870912500b0019cb5bce868mr3783185oae.58.1688143891179; 
 Fri, 30 Jun 2023 09:51:31 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 t39-20020a05687063a700b001b04434d934sm6594807oap.34.2023.06.30.09.51.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 09:51:30 -0700 (PDT)
Message-ID: <61f8892b-37cf-0b52-b76e-0f5c0d2560af@gmail.com>
Date: Fri, 30 Jun 2023 13:51:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] target/ppc: Make HDECR underflow edge triggered
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20230625122045.15544-1-npiggin@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230625122045.15544-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x329.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.095,
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



On 6/25/23 09:20, Nicholas Piggin wrote:
> HDEC interrupts are edge-triggered on HDECR underflow (notably different
> from DEC which is level-triggered).
> 
> HDEC interrupts already clear the irq on delivery so that does not need
> to be changed.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

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

