Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED212799A07
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 18:39:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf0yN-0006KQ-96; Sat, 09 Sep 2023 12:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf0yF-0006Je-LN
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 12:38:08 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf0yD-0002Lg-7N
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 12:38:07 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso22665345ad.2
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 09:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694277483; x=1694882283; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nDH0A+kySIprd7xO6ETAgCXpOXFe0/aQs6xi225ROyc=;
 b=ZGOL65cOyt1e8j7Gd9uVKsjF+1KlmTXvTNrlfeOiJgOI7iIv/EeUNWKyL1Jv4yU11D
 0WML13/pc0bEHhln2ZABnCSLrdZMtw8ZGWApjvM4+c9nBGeiEE9uwTWDKqu6ltAitW5z
 C+F6QUCfGgxkHchlE2flhKHDrUYuBolv/zZoU/ddJcQZ7oKabbQODLTMQYWgZCq+Pz/i
 SWN3Ralknxhx8/XlQ3w2nFEGkejdSjkI4rIs2VX4HAPcQS/LjsJJeHQqIpfJ3XdTr98a
 NPOCtX/rbM/l9pyn36Ne05aJXogYe46oekbY0YJ9ejyffUyCGDlKHcJXj6mjRknAoS7q
 VAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694277483; x=1694882283;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nDH0A+kySIprd7xO6ETAgCXpOXFe0/aQs6xi225ROyc=;
 b=J5tdw3Ntfb9yMIqJskbqCLayzRfHx+9HGKHZTUyooWHCvcQ6tJaznyF4D9W0XfkJPX
 f05XRG/v3Du9WLqWfqpJdQyWzautCHxIJcXg2e5yr0musrQduF2HLk1gu7b4wCHP3t33
 mK30b9fPZ+16HeUGXVT5VMO2p+vEiRAtI7NgIgTsBrb2zq5IuJf3KjWJ4X900pPLN6Sp
 duBjCVW7Lp7a/ilEaU/iNAMOpwVb4wIoAlrWuyyoLq1N+IjBE8AeThw9+f5VWzUN5O5a
 DVf5u++22id+ON8NqAFVWZQhv2q5a5+NLYL+JUTIXwY2ubszPlbVKBWfIa1Zu5PoCs/x
 gebA==
X-Gm-Message-State: AOJu0Yznl2q3l7tbbcUMxBv/DveJohRkqXVADjmx8RemBVFaXo8rDbvb
 /7X8ACuepxai5L9POHZ7UVfkyU8k5E/PU4jUFnQ=
X-Google-Smtp-Source: AGHT+IEA3gSYcS2GOGDWn7XnJxchqEX5FL4jtzfJ5YCQ6rMbBRwZOa7TKKbpLqbU81aQQAlAkRxWeA==
X-Received: by 2002:a17:902:d2c8:b0:1bc:224a:45c1 with SMTP id
 n8-20020a170902d2c800b001bc224a45c1mr5381946plc.55.1694277482963; 
 Sat, 09 Sep 2023 09:38:02 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 e13-20020a170902d38d00b001c1f4edfb87sm3484577pld.92.2023.09.09.09.38.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 09:38:02 -0700 (PDT)
Message-ID: <fbc33e98-2f8e-d503-c219-20c2b6eb02d2@linaro.org>
Date: Sat, 9 Sep 2023 09:38:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 11/14] target/arm: Implement the SETG* instructions
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230907160340.260094-1-peter.maydell@linaro.org>
 <20230907160340.260094-12-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907160340.260094-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/7/23 09:03, Peter Maydell wrote:
> The FEAT_MOPS SETG* instructions are very similar to the SET*
> instructions, but as well as setting memory contents they also
> set the MTE tags. They are architecturally required to operate
> on tag-granule aligned regions only.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/internals.h         | 10 ++++
>   target/arm/tcg/a64.decode      |  5 ++
>   target/arm/tcg/helper-a64.c    | 92 +++++++++++++++++++++++++++++++---
>   target/arm/tcg/mte_helper.c    | 40 +++++++++++++++
>   target/arm/tcg/translate-a64.c | 20 +++++---
>   5 files changed, 155 insertions(+), 12 deletions(-)
> 
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index a70a7fd50f6..642f77df29b 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1300,6 +1300,16 @@ uint64_t mte_mops_probe(CPUARMState *env, uint64_t ptr, uint64_t size,
>   void mte_check_fail(CPUARMState *env, uint32_t desc,
>                       uint64_t dirty_ptr, uintptr_t ra);
>   
> +/**
> + * mte_mops_set_tags: Set MTE tags for a portion of a FEAT_MOPS operation
> + * @env: CPU env
> + * @dirty_ptr: Start address of memory region (dirty pointer)
> + * @size: length of region (guaranteed not to cross page boundary)
> + * @desc: MTEDESC descriptor word
> + */
> +void mte_mops_set_tags(CPUARMState *env, uint64_t dirty_ptr, uint64_t size,
> +                       uint32_t desc);
> +
>   static inline int allocation_tag_from_addr(uint64_t ptr)
>   {
>       return extract64(ptr, 56, 4);
> diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
> index 8cddc207a6f..46caeb59fe5 100644
> --- a/target/arm/tcg/a64.decode
> +++ b/target/arm/tcg/a64.decode
> @@ -569,3 +569,8 @@ STZ2G           11011001 11 1 ......... 11 ..... ..... @ldst_tag p=0 w=1
>   SETP            00 011001110 ..... 00 . . 01 ..... ..... @set
>   SETM            00 011001110 ..... 01 . . 01 ..... ..... @set
>   SETE            00 011001110 ..... 10 . . 01 ..... ..... @set
> +
> +# Like SET, but also setting MTE tags
> +SETGP           00 011101110 ..... 00 . . 01 ..... ..... @set
> +SETGM           00 011101110 ..... 01 . . 01 ..... ..... @set
> +SETGE           00 011101110 ..... 10 . . 01 ..... ..... @set
> diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
> index 73169eb0b56..96780067262 100644
> --- a/target/arm/tcg/helper-a64.c
> +++ b/target/arm/tcg/helper-a64.c
> @@ -1103,6 +1103,54 @@ static uint64_t set_step(CPUARMState *env, uint64_t toaddr,
>       return setsize;
>   }
>   
> +/*
> + * Similar, but setting tags. The architecture requires us to do this
> + * in 16-byte chunks. SETP accesses are not tag checked; they set
> + * the tags.
> + */
> +static uint64_t set_step_tags(CPUARMState *env, uint64_t toaddr,
> +                              uint64_t setsize, uint32_t data, int memidx,
> +                              uint32_t *mtedesc, uintptr_t ra)
> +{
> +    void *mem;
> +    uint64_t cleanaddr;
> +
> +    setsize = MIN(setsize, page_limit(toaddr));
> +
> +    cleanaddr = useronly_clean_ptr(toaddr);
> +    /*
> +     * Trapless lookup: returns NULL for invalid page, I/O,
> +     * watchpoints, clean pages, etc.
> +     */
> +    mem = tlb_vaddr_to_host(env, cleanaddr, MMU_DATA_STORE, memidx);
> +
> +#ifndef CONFIG_USER_ONLY
> +    if (unlikely(!mem)) {
> +        /*
> +         * Slow-path: just do one write. This will handle the
> +         * watchpoint, invalid page, etc handling correctly.
> +         * The architecture requires that we do 16 bytes at a time,
> +         * and we know both ptr and size are 16 byte aligned.
> +         * For clean code pages, the next iteration will see
> +         * the page dirty and will use the fast path.
> +         */
> +        uint64_t repldata = data * 0x0101010101010101ULL;
> +        cpu_stq_mmuidx_ra(env, toaddr, repldata, memidx, ra);
> +        cpu_stq_mmuidx_ra(env, toaddr + 8, repldata, memidx, ra);
> +        mte_mops_set_tags(env, toaddr, 16, *mtedesc);
> +        return 16;

You can use cpu_st16_mmu for one store.

> @@ -1154,20 +1219,27 @@ void HELPER(setp)(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc)
>       int rd = mops_destreg(syndrome);
>       int rs = mops_srcreg(syndrome);
>       int rn = mops_sizereg(syndrome);
> +    bool set_tags = mops_is_setg(syndrome);
>       uint8_t data = env->xregs[rs];
>       uint32_t memidx = FIELD_EX32(mtedesc, MTEDESC, MIDX);
>       uint64_t toaddr = env->xregs[rd];
>       uint64_t setsize = env->xregs[rn];
>       uint64_t stagesetsize, step;
>       uintptr_t ra = GETPC();
> +    StepFn *stepfn = set_tags ? set_step_tags : set_step;
>   
>       check_mops_enabled(env, ra);
>   
>       if (setsize > INT64_MAX) {
>           setsize = INT64_MAX;
> +        if (set_tags) {
> +            setsize &= ~0xf;
> +        }
>       }

I think it would be a little better if set_tags was visible to the compiler, via inlining, 
so that all of the conditions can be folded away.

That said, all of the above is optimization not bugs.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

