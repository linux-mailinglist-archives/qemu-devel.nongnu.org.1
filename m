Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C77767753
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 23:01:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPTfA-0003Zm-Es; Fri, 28 Jul 2023 16:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPTf7-0003ZQ-Vc
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 16:02:10 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPTf5-0000ho-TW
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 16:02:09 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1b8b2b60731so14950665ad.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 13:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690574526; x=1691179326;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jy12IvNj0z0tXUIZD/7gj6H47r0e4SHR9tENE+5ujuU=;
 b=zDG6OifPrPv2LR3IZqSjsRW7JC3ymEjGfSsnUsdoIJKX0zSkQCY8B9GeUPbOlGzx7l
 8wLotxJ+gjLuc3vIdl2GDtZKjHBadfwdKcL3knrVIjiAtWJ7lhYWEQSlVqgo2624z8jh
 M1vX/X2g8iGUxI6U33M2Tjm9jspptqfmrMVodAb+/NV6sVDbMepRT+1zstekFZqA+u8S
 EG78LNog3r6237Fcjq/sJpTsWBvXB0eroSUCMm30crz1fmtyYX4dwI00OBMiU9RnI2ru
 RkYnEi24n0503/eORfjJKSAzobAkleSgURge7J5Tlyfh2PXKhVI7B9iL+WHryV6pQV9+
 rHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690574526; x=1691179326;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jy12IvNj0z0tXUIZD/7gj6H47r0e4SHR9tENE+5ujuU=;
 b=Gv65++xxc/EyoQ45fCzTGyr1gPq5+bC4RiFqA1W1pmlGLkJ0YfyiwElCpmr++DMfVy
 Bl+oG+tCFOAhehj7KLf2Ce4VO3FN2B7pf6rzAkeQ8eZU/0uSZkH58fsEvbBpvwPvde6H
 e87Qjx4xYcwEwD3krDyXUl21GsFs82Eaa/Rm5ddp0OcUYH+ZGDRBhroMCzCf1WMBFHeN
 hmBcrSslEExQC6uQYFL0OpnyNXSC4ReCUXxS5psDB/pQ7BPxgFxGgnMWqRVHMKZoTfb3
 u6blPZexgrQYvpnGY3S81OXpVGhT7bNBxJBsHnLrrgqCSwV2gCNRO7jZzS6bFGQRp7Hd
 zgAg==
X-Gm-Message-State: ABy/qLZyIQnpe7bjkQku9SnJnvvQYH+G/hoL1LCGeXRO2/NxyIORqP6H
 x6lS5mSIGxtBIN70npVnQGaAugyF0fNCOqPNaNk=
X-Google-Smtp-Source: APBJJlFixXFgB2rArjDIBtokoWR1YRy4v3+9O4zSd5Cmf8xtKjNOCCVc+nbVn2v6Xh4Gy8YxQJmCSw==
X-Received: by 2002:a17:903:481:b0:1bb:c971:ef92 with SMTP id
 jj1-20020a170903048100b001bbc971ef92mr1891815plb.59.1690574526223; 
 Fri, 28 Jul 2023 13:02:06 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:cfba:2f6a:7070:67a9?
 ([2602:ae:154e:c001:cfba:2f6a:7070:67a9])
 by smtp.gmail.com with ESMTPSA id
 jg19-20020a17090326d300b001b8013ed362sm3974596plb.96.2023.07.28.13.02.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 13:02:05 -0700 (PDT)
Message-ID: <920b0af5-4acb-3eaa-755f-608359117cd2@linaro.org>
Date: Fri, 28 Jul 2023 13:02:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/s390x: Move trans_exc_code update to
 do_program_interrupt
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: iii@linux.ibm.com, david@redhat.com, qemu-s390x@nongnu.org,
 Claudio Fontana <cfontana@suse.de>
References: <20230728195538.488932-1-richard.henderson@linaro.org>
In-Reply-To: <20230728195538.488932-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 7/28/23 12:55, Richard Henderson wrote:
> This solves a problem in which the store to LowCore during tlb_fill
> triggers a clean-page TB invalidation for page0 during translation,
> which results in an assertion failure for locked pages.
> 
> By delaying the store until after the exception has been raised,
> we will have unwound the pages locked for translation and the
> problem does not arise.  There are plenty of other updates to
> LowCore while delivering an interrupt/exception; trans_exc_code
> does not need to be special.
> 
> Reported-by: Claudio Fontana <cfontana@suse.de>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/excp_helper.c | 42 +++++++++++++++++++++++-----------
>   1 file changed, 29 insertions(+), 13 deletions(-)
> 
> diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
> index 3da337f7c7..b260bf7331 100644
> --- a/target/s390x/tcg/excp_helper.c
> +++ b/target/s390x/tcg/excp_helper.c
> @@ -190,11 +190,6 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>           return false;
>       }
>   
> -    if (excp != PGM_ADDRESSING) {
> -        stq_phys(env_cpu(env)->as,
> -                 env->psa + offsetof(LowCore, trans_exc_code), tec);
> -    }
> -
>       /*
>        * For data accesses, ILEN will be filled in from the unwind info,
>        * within cpu_loop_exit_restore.  For code accesses, retaddr == 0,
> @@ -211,20 +206,34 @@ static void do_program_interrupt(CPUS390XState *env)
>       uint64_t mask, addr;
>       LowCore *lowcore;
>       int ilen = env->int_pgm_ilen;
> +    bool set_trans_exc_code = false;
> +    bool advance = false;
>   
>       assert((env->int_pgm_code == PGM_SPECIFICATION && ilen == 0) ||
>              ilen == 2 || ilen == 4 || ilen == 6);
>   
>       switch (env->int_pgm_code) {
>       case PGM_PER:
> -        if (env->per_perc_atmid & PER_CODE_EVENT_NULLIFICATION) {
> -            break;
> -        }
> -        /* FALL THROUGH */
> +        advance = !(env->per_perc_atmid & PER_CODE_EVENT_NULLIFICATION);
> +        break;
> +    case PGM_ASCE_TYPE:
> +    case PGM_REG_FIRST_TRANS:
> +    case PGM_REG_SEC_TRANS:
> +    case PGM_REG_THIRD_TRANS:
> +    case PGM_SEGMENT_TRANS:
> +    case PGM_PAGE_TRANS:
> +        assert(env->int_pgm_code == env->tlb_fill_exc);
> +        set_trans_exc_code = true;
> +        break;

I should have mentioned that this block of exceptions came from page 3-76 
(Translation-Exception Identification for DAT Exceptions) of the 13th edition of the PoO.

> +    case PGM_PROTECTION:
> +    case PGM_TRANS_SPEC:
> +        assert(env->int_pgm_code == env->tlb_fill_exc);
> +        set_trans_exc_code = true;
> +        advance = true;
> +        break;

These exceptions came from seeing an early kernel fault, grepping for the set of 
exceptions raised in mmu_helper.c, and eliminating PGM_ADDRESSING per the first hunk.

I wasn't sure where to look for the full specification of exception effects, but this did 
solve the kernel fault.


r~

