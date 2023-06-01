Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DC571F37F
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 22:15:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ogG-00005k-Ss; Thu, 01 Jun 2023 16:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4ogE-00005W-NZ
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 16:13:54 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4ogC-0006Eo-W7
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 16:13:54 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f6042d605dso12816585e9.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 13:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685650431; x=1688242431;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=94n0hEvw1bAUMIJLYD+sIcnMOdAM8yZqomQNrcgNcGM=;
 b=cq58WphF2zmXBPOFi1e3Qr+dHVeNxAahtHns2u79iynQX5vjG100+41pGTpIHsnt39
 c1GvPSU16ER5v03lXGEFGRJnKbFMtppdiFkEzRRzkOvKcK5+6y1bL4gJ6ODdrjIXar2W
 7T/IK85nXdddG6sA/iPPPjKlewADrYvKYEA0HSlZhShfIh0W6yv/b6Q9X5LZmD1MDf8f
 7tCKyfJ08os9BAL6JKzxb8E+MeP0UP9liPU8bzh01HCf5E3zZ3qQZ9MEXb23/zRQOODU
 DBt5HCwBvG5w5u+LVAtIhqUige8F+m92y7RzjVCbZM3n6BWtB+6Ozpm19NfuuygDALXh
 oCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685650431; x=1688242431;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=94n0hEvw1bAUMIJLYD+sIcnMOdAM8yZqomQNrcgNcGM=;
 b=dp5rb+mpCaZTpHyyZpOeBpmILp0s1xxE7z5QGWb0HY6JEfjS7awSoxCuz34yL5ErCn
 839IRZLuBIhpbukSJnWpEXeldfgwox6q4qPtM3SpykFvMS49jw5pjmsgnyiGcx2xlpBJ
 QlFQg4pthpMw4R4y/+AreKsI7h6djxam/YhFnKjH4coeYXZejAC94w/19tBeQ1tlN1IZ
 mlzzvBUmwF0VWEr80SJZGpPcDRHpfaDQyaiYkRl13l/n3jw+hrmuYF/iFNTd2kRAzCzS
 BgqdFGq1IUg8nY/vlu3yt730pHVt9/wYrWJhT7t6mIltNTsEyqxun+W2j5NSk0zMw62H
 pbzQ==
X-Gm-Message-State: AC+VfDzhl6pajXz0UQlTsWmXCMOeBPtdrR019LX68hdPxa05CwXuzMI8
 FPJ67v6b2J3NlNz3f2ZdoKfDOQ==
X-Google-Smtp-Source: ACHHUZ7UKETraHUvC0NRt/S+rjY/RriG+ie1wvyFEMvLzw9kJl24MhWGdacd8U3uck7cajYiJImWGw==
X-Received: by 2002:a1c:6a15:0:b0:3f6:26a1:1d58 with SMTP id
 f21-20020a1c6a15000000b003f626a11d58mr313965wmc.37.1685650430785; 
 Thu, 01 Jun 2023 13:13:50 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.141.224])
 by smtp.gmail.com with ESMTPSA id
 u22-20020a05600c211600b003f611b2aedesm3340090wml.38.2023.06.01.13.13.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 13:13:50 -0700 (PDT)
Message-ID: <bf90ccc8-de28-b166-ee34-f425ac55722f@linaro.org>
Date: Thu, 1 Jun 2023 22:13:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 12/48] target/arm: Fix test of TCG_OVERSIZED_GUEST
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-13-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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

On 31/5/23 06:02, Richard Henderson wrote:
> The symbol is always defined, even if to 0.
> We wanted to test for TCG_OVERSIZED_GUEST == 0.

Fixes: 71943a1e90 ("target/arm: Implement FEAT_HAFDBS, access flag portion")

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/ptw.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 69c05cd9da..b0d2a05403 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -418,6 +418,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
>                                uint64_t new_val, S1Translate *ptw,
>                                ARMMMUFaultInfo *fi)
>   {
> +#ifdef TARGET_AARCH64

This change ^ ...

>       uint64_t cur_val;
>       void *host = ptw->out_host;
>   
> @@ -473,7 +474,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
>        * we know that TCG_OVERSIZED_GUEST is set, which means that we are
>        * running in round-robin mode and could only race with dma i/o.
>        */
> -#ifndef TCG_OVERSIZED_GUEST
> +#if !TCG_OVERSIZED_GUEST
>   # error "Unexpected configuration"
>   #endif
>       bool locked = qemu_mutex_iothread_locked();
> @@ -497,6 +498,10 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
>   #endif
>   
>       return cur_val;
> +#else
> +    /* AArch32 does not have FEAT_HADFS. */
> +    g_assert_not_reached();

... isn't documented. Do you mind adding a quick line about it?

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +#endif
>   }
>   
>   static bool get_level1_table_address(CPUARMState *env, ARMMMUIdx mmu_idx,


