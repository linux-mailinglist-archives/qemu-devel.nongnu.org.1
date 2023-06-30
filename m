Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6A87442C8
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 21:40:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFJxp-0005Gb-LK; Fri, 30 Jun 2023 15:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFJxn-0005AQ-9B; Fri, 30 Jun 2023 15:39:27 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFJxl-0007ti-Ea; Fri, 30 Jun 2023 15:39:26 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1b01b43577fso1975136fac.0; 
 Fri, 30 Jun 2023 12:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688153962; x=1690745962;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=awus4a1Ei6NAbQhnWhVtMayrT1TgnjN/T/6ql3XaUdU=;
 b=D/UcoZgF3vBmK08DqZYdjScjKh94mW4254Ii63TMuDDjCD4Pt/qKpzz1CXaJjmzqGD
 dF6GH7qZnFMpxWeNPUxJ0KW8egpOwc7Yuqsbs00WRqBkqdKi6kc7DimOhQoa4mRjN+Fw
 BCOoX4OitzUxYc0fVhluZUFGbJuXf1bC62iw83u+XJxRjI/Sw8MqTeirOrVmbYRyBMt1
 0Zo/go7QUlkaNJfmeNLzxfZBInJlYg1rONHNq5CS7TIgRE5/98SpOPN0SHUs+MPHCUjR
 3jnFLkW15IugzOdjhOBRnX4MAcAypTC967oFHQtkUklEQd0vBg3BXYqieLuQGIK1MUDR
 cEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688153962; x=1690745962;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=awus4a1Ei6NAbQhnWhVtMayrT1TgnjN/T/6ql3XaUdU=;
 b=fF444s95JvvoUxqfDLT+3uwzx7ORaVRjf9M5VO8b3po3zpp4ZAeIgWqJ+Sm9pgnbjw
 sp5FYWOtutZm0JCJhLH6U2KlW2GoRsPC5KNDIvSBEAsFmBWmj5AYuQNFSpPOIMepkUhW
 /nsYZj4WibzU+5oqBCyDFBoUtzH5zixwF6qnXgwwg1BPbYeN5FYDZZIxUPzLmuaiFB60
 LE+ZZ34MAP6NHZl2WSknG12ZA66bzB3P+aQs3mclTAWEdUSJzNYHfM9KrYXusnOrCM/m
 3hHU/ZNwy2s17qDpD82yFP+RTEEePb81d8jDNf+7/6MnQDKSBtn501DXmCQVxthSLg/a
 FJKw==
X-Gm-Message-State: ABy/qLZ4TQN90TWCOH5uk9G+O/o2niFY1j9PlgpmBbxRVFFQ7aIE/N/9
 dE49E72xEITvBBeHgBKXt5I=
X-Google-Smtp-Source: APBJJlEwGXOTL7uB2zzQ9WtsX+b4Y+oK74OSttL2nwat9JB6b4m5zq+AIhpiljXAdtDtE7hyJcMAOA==
X-Received: by 2002:a05:6870:b246:b0:1b0:56d3:5cdb with SMTP id
 b6-20020a056870b24600b001b056d35cdbmr4425712oam.53.1688153962657; 
 Fri, 30 Jun 2023 12:39:22 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 gu17-20020a056870ab1100b001a3093ec23fsm9326151oab.32.2023.06.30.12.39.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 12:39:22 -0700 (PDT)
Message-ID: <34f18b91-c4fd-35f7-680c-7c6473640f10@gmail.com>
Date: Fri, 30 Jun 2023 16:39:19 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] target/ppc: Fix icount access for some hypervisor
 instructions
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20230625103700.8992-1-npiggin@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230625103700.8992-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x2a.google.com
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



On 6/25/23 07:36, Nicholas Piggin wrote:
> Several instructions and register access require icount reads and are
> missing translator_io_start().
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

>   target/ppc/translate.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index eb278c2683..c1c3cd8767 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -1177,6 +1177,7 @@ void spr_write_hmer(DisasContext *ctx, int sprn, int gprn)
>   
>   void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn)
>   {
> +    translator_io_start(&ctx->base);
>       gen_helper_store_lpcr(cpu_env, cpu_gpr[gprn]);
>   }
>   #endif /* !defined(CONFIG_USER_ONLY) */
> @@ -4002,6 +4003,7 @@ static void gen_doze(DisasContext *ctx)
>       TCGv_i32 t;
>   
>       CHK_HV(ctx);
> +    translator_io_start(&ctx->base);
>       t = tcg_constant_i32(PPC_PM_DOZE);
>       gen_helper_pminsn(cpu_env, t);
>       /* Stop translation, as the CPU is supposed to sleep from now */
> @@ -4017,6 +4019,7 @@ static void gen_nap(DisasContext *ctx)
>       TCGv_i32 t;
>   
>       CHK_HV(ctx);
> +    translator_io_start(&ctx->base);
>       t = tcg_constant_i32(PPC_PM_NAP);
>       gen_helper_pminsn(cpu_env, t);
>       /* Stop translation, as the CPU is supposed to sleep from now */
> @@ -4032,6 +4035,7 @@ static void gen_stop(DisasContext *ctx)
>       TCGv_i32 t;
>   
>       CHK_HV(ctx);
> +    translator_io_start(&ctx->base);
>       t = tcg_constant_i32(PPC_PM_STOP);
>       gen_helper_pminsn(cpu_env, t);
>       /* Stop translation, as the CPU is supposed to sleep from now */
> @@ -4047,6 +4051,7 @@ static void gen_sleep(DisasContext *ctx)
>       TCGv_i32 t;
>   
>       CHK_HV(ctx);
> +    translator_io_start(&ctx->base);
>       t = tcg_constant_i32(PPC_PM_SLEEP);
>       gen_helper_pminsn(cpu_env, t);
>       /* Stop translation, as the CPU is supposed to sleep from now */
> @@ -4062,6 +4067,7 @@ static void gen_rvwinkle(DisasContext *ctx)
>       TCGv_i32 t;
>   
>       CHK_HV(ctx);
> +    translator_io_start(&ctx->base);
>       t = tcg_constant_i32(PPC_PM_RVWINKLE);
>       gen_helper_pminsn(cpu_env, t);
>       /* Stop translation, as the CPU is supposed to sleep from now */
> @@ -4458,6 +4464,7 @@ static void gen_hrfid(DisasContext *ctx)
>   #else
>       /* Restore CPU state */
>       CHK_HV(ctx);
> +    translator_io_start(&ctx->base);
>       gen_helper_hrfid(cpu_env);
>       ctx->base.is_jmp = DISAS_EXIT;
>   #endif

