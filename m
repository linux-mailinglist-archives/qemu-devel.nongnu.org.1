Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D5E743CBD
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:27:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE9T-0003rJ-Rv; Fri, 30 Jun 2023 09:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE9F-0003lW-7J
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:26:54 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE8z-0004b1-Ay
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:26:52 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3128fcd58f3so2113889f8f.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688131595; x=1690723595;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zO+MiD0vvqFvSc9RbHUTYL1g23zi99p73Vc40SoL74Y=;
 b=lFmLVpfNejeN1TMQgO0v6ao70ZgPOcxocb8wXd0lkRdulSo3d8mj8fEYUIoaMfO3yA
 syuLh8LDOmKZHwqDVKrvcN5J386dRHHq5mWksDhKo3Z843moYCszYWGVIWQs7D69kilr
 1lqL6P9m12MHrI33HQsGa8EHFKqmztRk7jgZJCOGLgcBa0DuQrICm+08M100RqhfdK1y
 yzzKPwMTxDnNMjECMc0pKdFSpcPjqlBqj8mg3jV1cZHHWSXsdQ/JzWzAg2p6neSnDeqZ
 ppSGB61uWPbcUOZrD0Dt/kZ8p/nFTEeSLJZBzOzm8FtjPPmBJ2oprUwPO8M1blTAsRx8
 V8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688131595; x=1690723595;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zO+MiD0vvqFvSc9RbHUTYL1g23zi99p73Vc40SoL74Y=;
 b=OQnGO2FlDnnXhqHSEjDwzTcOz5c6/nlrGm6b0U23JHm9FnesACnx+gm4y/La/gCpmp
 C8r2FcjmyTQqN5FRgJKdDjNeDF3R7JmPsz4Lgfryjf57owclKDa8CDiMM+m/hXOcOHzl
 iqfhVJOne4hAbsz4yAw7StvlXHtFqtYF3Q2ZQ+8oIC4pZ2jG9WuhamUtjf8O7AzatDnb
 5vueM3Airix4G5YR+h9UGAnIWUW/9dWdwMLIMuy7CB6Kv23zvK0I3V1E0dndYEG51IB+
 g0ttGVh83nSlG43++iKIDnT9A8BfUbiR3iLOZQm9ZGoY8vCKna+RGRlBsUtcrmcOtcRD
 Y73A==
X-Gm-Message-State: ABy/qLZeRzQ+7I0Ac6EW/vV896GdsYgliKoIgn85E2npHyvVRt9q0/Uk
 3+ZcjySRzFg2frT5QFQtGdcD298t+lTorJ4qBxZoFg==
X-Google-Smtp-Source: APBJJlECowUQ31uVuXZ5NC3ox0oWtgd4OOwEGXHqRAG82Yzhfv5lXaXLS8TM7GsnJy+qYK6WorF65g==
X-Received: by 2002:a5d:4f11:0:b0:313:df08:7b7e with SMTP id
 c17-20020a5d4f11000000b00313df087b7emr2192727wru.14.1688131595355; 
 Fri, 30 Jun 2023 06:26:35 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a5d504a000000b00313e8dc7facsm16569370wrt.116.2023.06.30.06.26.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 06:26:34 -0700 (PDT)
Message-ID: <9ee9c3fc-47cd-25de-f876-7edbd874862a@linaro.org>
Date: Fri, 30 Jun 2023 15:26:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] target/arm: make arm_casq_ptw CONFIG_TCG only
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
References: <20230630110757.417758-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630110757.417758-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/30/23 13:07, Alex Bennée wrote:
> The ptw code is accessed by non-TCG code (specifically arm_pamax and
> arm_cpu_get_phys_page_attrs_debug) but most of it is really only for
> TCG emulation. Seeing as we already assert for a non TARGET_AARCH64
> build lets extend the test rather than further messing with the ifdef
> ladder.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> NB: I need this because I'm about to change the probe action is calls
> and probes are very definitely TCG only operations through cputlb.c.
> ---
>   target/arm/ptw.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 422bf7e3b1..8cac685aa6 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -628,7 +628,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
>                                uint64_t new_val, S1Translate *ptw,
>                                ARMMMUFaultInfo *fi)
>   {
> -#ifdef TARGET_AARCH64
> +#if defined(TARGET_AARCH64) && defined(CONFIG_TCG)
>       uint64_t cur_val;
>       void *host = ptw->out_host;
>   
> @@ -708,7 +708,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
>   
>       return cur_val;
>   #else
> -    /* AArch32 does not have FEAT_HADFS. */
> +    /* AArch32 and non TCG guests do not have FEAT_HADFS. */
Better as

   AArch32 does not have FEAT_HADFS; non-TCG guests only use debug-mode.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

