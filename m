Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F9A73A587
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:07:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCMoj-0000xc-2A; Thu, 22 Jun 2023 12:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCMoX-0000wW-Kr
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:05:45 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCMoT-000620-Li
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:05:39 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4f8777caaa1so5668592e87.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 09:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687449934; x=1690041934;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GKSFzHfoOe8E2L1wD0MShd505mBa2EuWuWm9TG36N5g=;
 b=LGu0aD8V0nQVF/44KlKCuzurl1chD9j6pU76xxLfD+DTfx/syVNryceP4tSGn60t2S
 P+G22BC1ZjIlymizrXU37AKF3BWJ5WBe4ZWOUZlkthNIhM/w8iggqKtzAA1y97NM+PmD
 fNMLPFDk/BVos0cAFIoDFOzHj8+1KlAgynXaZksWWKTEdvMj+yfyRPWbOPXed/ys5hn3
 QFhnuHcMGg4Op0fyl/fY/sAlmK9Iazqw8XOR4o1cCB7Fesf/1kbpniVI105gnCUlExrZ
 0tLpzoOpQD+9e9eP6fUDw7H/nz2++3SSHnT5zKykjkF6F3lITSxuNgh5fKyaDbCujzkw
 6JQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687449934; x=1690041934;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GKSFzHfoOe8E2L1wD0MShd505mBa2EuWuWm9TG36N5g=;
 b=DDHdii0EABH9CjXUeRF/TXdCNHfmkxEAiLQh0snb4dV6VBmSEaxzhJiRz/Sk6vYvlM
 RwtSiYKnGBCn/IFAq95itVZuDRXIhxFfZN50bibfL5drlplwgkjWpqg/GwldVpkWLXxM
 LpgwbSPzpglMJ2wpdAgLnqQaU+2/X02Lxo3JlQgibiUmLnErzyhx4Oz0wcsnIEnaENIL
 yFGRdCg/LDQS2iI3tWHdBO883p412JhQ2eG/80N1jl3o0H5WkT1Sx0IJ77i9KTmRxCZs
 8XR0ArwA+U/A6OFoEy3GLgezvje9o4/+JMnBIjgDXigZW0bexmTWqh8iSLyvQ9v+aMS/
 U69Q==
X-Gm-Message-State: AC+VfDwZC8hyo8OcCjyCWgQbwaHiiTPVLMo7R9GwvEF7/RXxkR1vtadP
 Tkr+wWF9CYji/zyPMmrhaDWGV3wm0s7D09BAlbzZcIFS
X-Google-Smtp-Source: ACHHUZ65XRt6FxAowZF7/Hvm/ppBHouutuP5Kj53LYpfMbCDCixdEQYFT/OxXtaj8y+tY+InTZfLbw==
X-Received: by 2002:a05:6512:3985:b0:4f9:615f:14dd with SMTP id
 j5-20020a056512398500b004f9615f14ddmr2577505lfu.11.1687449934516; 
 Thu, 22 Jun 2023 09:05:34 -0700 (PDT)
Received: from [192.168.157.227] ([91.223.100.38])
 by smtp.gmail.com with ESMTPSA id
 u23-20020ac24c37000000b004f86df7b2ffsm1140903lfq.267.2023.06.22.09.05.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 09:05:34 -0700 (PDT)
Message-ID: <d232206c-7bd1-ccc0-5eb9-da295628444a@linaro.org>
Date: Thu, 22 Jun 2023 18:05:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/9] accel/tcg: Store some tlb flags in CPUTLBEntryFull
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20230621121902.1392277-1-richard.henderson@linaro.org>
 <20230621121902.1392277-2-richard.henderson@linaro.org>
 <405f3697-9cc8-3a19-ee79-094e6e130c29@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <405f3697-9cc8-3a19-ee79-094e6e130c29@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/22/23 11:58, Philippe Mathieu-Daudé wrote:
> On 21/6/23 14:18, Richard Henderson wrote:
>> We have run out of bits we can use within the CPUTLBEntry comparators,
>> as TLB_FLAGS_MASK cannot overlap alignment.
>>
>> Store slow_flags[] in CPUTLBEntryFull, and merge with the flags from
>> the comparator.  A new TLB_FORCE_SLOW bit is set within the comparator
>> as an indication that the slow path must be used.
>>
>> Move TLB_BSWAP to TLB_SLOW_FLAGS_MASK.  Since we are out of bits,
>> we cannot create a new bit without moving an old one.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/exec/cpu-all.h  | 21 +++++++--
>>   include/exec/cpu-defs.h |  6 +++
>>   accel/tcg/cputlb.c      | 96 ++++++++++++++++++++++++-----------------
>>   3 files changed, 80 insertions(+), 43 deletions(-)
> 
> Do you mind squashing this for clarity?
> 
> -- >8 --
> diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
> index c174d5371a..c0f19e5893 100644
> --- a/include/exec/cpu-defs.h
> +++ b/include/exec/cpu-defs.h
> @@ -130,3 +130,3 @@ typedef struct CPUTLBEntryFull {
>        */
> -    uint8_t slow_flags[3];
> +    uint8_t slow_flags[MMU_ACCESS_COUNT];
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 4871ad85f0..d07763fdeb 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -86,2 +86,3 @@ typedef enum MMUAccessType {
>       MMU_INST_FETCH = 2
> +#define MMU_ACCESS_COUNT 3
>   } MMUAccessType;


Done.


r~

