Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 456947715A4
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 16:32:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSenc-00052p-1m; Sun, 06 Aug 2023 10:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSenZ-00051w-VB
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 10:32:01 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSenY-0001Ad-EJ
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 10:32:01 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-686b9920362so2421073b3a.1
 for <qemu-devel@nongnu.org>; Sun, 06 Aug 2023 07:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691332319; x=1691937119;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vWYOQs0dwgze/P9y7KCiOFGmgEivOl58I5wqpH4/zgg=;
 b=ssSjHemZ21CP2zmLmKSAj5fwfF7bw/wU5jVmG63RNolJ0NGJHHhCxNkjt139owtbim
 5UI0pNyBHhlfVaXQpSXRaEE2vbwcxu1JuCtwUnN5ck5TeS4DziwWjiHqWd0/oN152QPI
 FAsYWTivnPozTysbaRmu3YFn4QmKk/s5p5zfqafjzhBgIgOwBTb8bv8Q3mZY4L1Rj9X2
 OI2gUQS8NiC1rU14iTNY7AVIKgei0zD52XZywdlTHjjA1ApuEJRjjMnzNpw6PdKLQiFN
 TDhvS3qC68fULw6QHKd8XaiwShcsWejjaMSd1vVOe3NStkzuO6fZYjkLxveD54aVQspX
 IyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691332319; x=1691937119;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vWYOQs0dwgze/P9y7KCiOFGmgEivOl58I5wqpH4/zgg=;
 b=epcz5YuDhKR2emNU3VBLwzR/6nsH/B9Dyu4gxpXhdZqcNNUkIo34lHuUQRpW9RlBcl
 +OwqpPSCYoKA7yBUR8EMiHTcoL6jXs707UVSb8XigJLj0mJqiueoinMCVWcYd3TiRY7P
 G5+r3x1t0af0RC+7vMRZsUu6p82MxeG3FKncdP8O5x5I4hMuNGop0AQkbIb0PwJoHoyy
 F+bIi7TwY5GHwO4KYsGTlpM1+fLyWwKLgkJn6UkS6jGMiWs4+PI2jCot1CzwDhqAc3xp
 1gDVbT47iZwxg7W7n50QXPujmW6q7bDkjpozupm3QPEbG9fwPTSIM3Pnam8jONCZmJnb
 empA==
X-Gm-Message-State: AOJu0YxItyppKx8+Yh0k2cdJdI3V2zlamtXsGFz3sE5yydjouN010zmw
 q3O62OlxYFrJMCgpUwmeFbRAsacFAVSuMdqjW9Q=
X-Google-Smtp-Source: AGHT+IEbTwAfiBCWiUcrCNOJbN9iTYADyGzx7z65RG4lVNB6+3aWwmqUN7oHV/gQeusZm+KjyApAqA==
X-Received: by 2002:a05:6a21:3d85:b0:13e:fe55:b99f with SMTP id
 bj5-20020a056a213d8500b0013efe55b99fmr5434381pzc.56.1691332319222; 
 Sun, 06 Aug 2023 07:31:59 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:e72:57bd:c5e4:990c?
 ([2602:47:d490:6901:e72:57bd:c5e4:990c])
 by smtp.gmail.com with ESMTPSA id
 q24-20020a637518000000b0050f85ef50d1sm3756208pgc.26.2023.08.06.07.31.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Aug 2023 07:31:58 -0700 (PDT)
Message-ID: <a93cc9b3-35ab-5386-9518-8f5023f71206@linaro.org>
Date: Sun, 6 Aug 2023 07:31:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 14/23] target/arm: Use MMU_INDEX() helper
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20230806121732.91853-1-deller@gmx.de>
 <20230806121732.91853-15-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230806121732.91853-15-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.139,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/6/23 05:17, Helge Deller wrote:
> Use the new MMU_INDEX() helper to specify the index of the CPUTLB which
> should be used.  Additionally, in a follow-up patch this helper allows
> then to optimize the tcg code generation.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   target/arm/cpu.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 88e5accda6..16e18fb22a 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2930,7 +2930,7 @@ typedef enum ARMMMUIdxBit {
> 
>   #undef TO_CORE_BIT
> 
> -#define MMU_USER_IDX 0
> +#define MMU_USER_IDX MMU_INDEX(0)
> 
>   /* Indexes used when registering address spaces with cpu_address_space_init */
>   typedef enum ARMASIdx {
> @@ -3166,7 +3166,7 @@ FIELD(TBFLAG_A64, NAA, 30, 1)
>    */
>   static inline int cpu_mmu_index(CPUARMState *env, bool ifetch)
>   {
> -    return EX_TBFLAG_ANY(env->hflags, MMUIDX);
> +    return MMU_INDEX(EX_TBFLAG_ANY(env->hflags, MMUIDX));
>   }

This cannot possibly work, since you've not changed any of the real mmu idx (ARMMMUIdx).


r~


