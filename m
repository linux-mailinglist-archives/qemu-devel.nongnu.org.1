Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5377310F5
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 09:38:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9hXu-0006Uf-No; Thu, 15 Jun 2023 03:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9hXs-0006UO-VP
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 03:37:29 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9hXr-0003gE-8p
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 03:37:28 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51a2661614cso491089a12.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jun 2023 00:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686814645; x=1689406645;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8uVvozQSTRBpavqZYKs3Bh3OoIGaU+GDq61JALEmdpQ=;
 b=f1QBFbvqAfq9pxTya8AQiA5R7xeWyYf0IYNNAkY+QBwo2/LLQFKKwrsApVJZGRFmzA
 aGUCD8Ugn28nnq+mfYa45AIYt5y4Qi8dqI7yQ8TR5YwCHdR99F04lqJcYjf+ctxVFeXO
 HEFc6arnRrYE05BCeWgbfYYjlOyotQ1RzmnnowK81YLzEsZeuNgbKlx+HNfYeHFf64YL
 pbCPSdMN+DTh6TrpR+IbxDv/o6Bt3G5ETwE779ec6nQWi0KLbXaoS1yg7S/7xtbXtZol
 r2V22bM7NnvymE7jjIkCTAa4jp0KoIMRWlTv2+tR+krrV/TOXLRB8R4OPPgjnC13j468
 THJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686814645; x=1689406645;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8uVvozQSTRBpavqZYKs3Bh3OoIGaU+GDq61JALEmdpQ=;
 b=J8UqPtVmVp7DTwji/DSv10qu6UmYsj3fxRQw+An+EEr1GRBvzxuPKunFK7boKv8iqL
 yUbFTSSyoCl8Z60gJkcGfrGsW5LXHS4W4NHTiLA+1TVOaDGvSaweQ9q5f9vkAnoU567D
 o2wpYpU0of5jX2UGNSxo3AajFFmo1hkezhXMXbEpsDT68Y4clPGO7Qs3V8m3v0eXc/8V
 8WVjEbVa4XgtKsTV2ZD6J7KcavAnwzHHo1j/Pef1HCKVZCcjAGQrwmNa+d99YCvKD/et
 l9Cb2GDYuIPCfyu+FnBRmK0LxviqUdhlbP3bIBzqR9plcQVhe42w0TIGg39UrkSugONV
 S1uw==
X-Gm-Message-State: AC+VfDyrQgc5DXQ4i/gJ+xAm5PPV9k40mrdjjO4hVizPTS0j41EnpVPj
 a0Kof6X8QQ5BNsLJ4RumVExkVg==
X-Google-Smtp-Source: ACHHUZ49PxkMabh0RE0ySFAyPcNXNBmF2Vf4aRE9Wo67Yq0nykrjrMv9LV0Cu47RbG4tNeBVV/B0Jg==
X-Received: by 2002:aa7:da83:0:b0:51a:23fb:355c with SMTP id
 q3-20020aa7da83000000b0051a23fb355cmr996291eds.10.1686814645138; 
 Thu, 15 Jun 2023 00:37:25 -0700 (PDT)
Received: from [10.14.201.121] ([213.175.39.66])
 by smtp.gmail.com with ESMTPSA id
 m8-20020a056402050800b005149cb5ee2dsm8574691edv.82.2023.06.15.00.37.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jun 2023 00:37:24 -0700 (PDT)
Message-ID: <293ea058-8380-0610-80f3-a0bf089245dc@linaro.org>
Date: Thu, 15 Jun 2023 09:37:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] target/tricore: Honour privilege changes on PSW write
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20230614165934.1370440-1-kbastian@mail.uni-paderborn.de>
 <20230614165934.1370440-4-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230614165934.1370440-4-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 6/14/23 18:59, Bastian Koppelmann wrote:
>   void helper_psw_write(CPUTriCoreState *env, uint32_t arg)
>   {
> +    uint32_t old_priv, new_priv;
> +    CPUState *cs;
> +
> +    old_priv = extract32(env->PSW, 10, 2);
>       psw_write(env, arg);
> +    new_priv = extract32(env->PSW, 10, 2);
> +
> +    if (old_priv != new_priv) {
> +        cs = env_cpu(env);
> +        env->PC = env->PC + 4;
> +        cpu_loop_exit(cs);
> +    }
>   }

I think you should unconditionally end the TB after write to PSW. I think that you should 
not manipulate the PC here, nor use cpu_loop_exit.

You should add

#define DISAS_EXIT         DISAS_TARGET_0
#define DISAS_EXIT_UPDATE  DISAS_TARGET_1

> @@ -378,6 +379,7 @@ static inline void gen_mtcr(DisasContext *ctx, TCGv r1,
>      if (ctx->priv == TRICORE_PRIV_SM) {
>          /* since we're caching PSW make this a special case */
>          if (offset == 0xfe04) {
> +            gen_save_pc(ctx->base.pc_next);
>              gen_helper_psw_write(cpu_env, r1);

Instead set ctx->base.is_jmp = DISAS_EXIT,

and in tricore_tr_tb_stop add

     case DISAS_EXIT_UPDATE:
         gen_save_pc(ctx->base.pc_next);
         /* fall through */
     case DISAS_EXIT:
         tcg_gen_exit_tb(NULL, 0);
         break;

There are a number of places (e.g. rfe), which can then use DISAS_EXIT instead of issuing 
the exit directly.

I'll also say that there are a number of other places using tcg_gen_exit_tb which should 
instead be using tcg_gen_lookup_and_goto_ptr -- all of the indirect branches for instance. 
  I would suggest adding

#define DISAS_JUMP    DISAS_TARGET_2

to handle those, again with the code within tricore_tr_tb_stop.

Finally, does JLI really clobber A[11] before branching to A[a]?
If so, this could use a comment, because it looks like a bug.


r~


