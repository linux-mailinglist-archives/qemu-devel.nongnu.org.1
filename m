Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B74A7D75A3
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 22:27:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvkSi-0005I2-0C; Wed, 25 Oct 2023 16:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvkSf-0005Hj-V7
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 16:26:42 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvkSe-0007ph-38
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 16:26:41 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6b20577ef7bso126596b3a.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 13:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698265598; x=1698870398; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0FyOe0IRKpFI1erCpN6BCtMWvZSuTSWrywI6BoBtqVU=;
 b=Rk4eIEFYuud1Da7E1bprFu3XDyEhWs/uS7WtVz8fpDHUc8fifVsPEBHGmb3HG7VTK9
 waPROkr0e7ZbEaPTIdklsLpJH89SETjI1Dk4DOxDF5nCCc1VrR6w5JndI7EEtxNDfkhn
 GaHljgWffOswTGLTyh6AB1clt/ZcSR2pMy0NifxuheeFW6EECxZk6MrNSnRcXqtusyLv
 jlXJmOON3nWPCHPhITt025xgfBlHgKU9LK8/NOLDZfhtWl+yZJzlaYrnlF3Ocll+qNMF
 Px6EdzEx8kwVJ4AH9+N8rzbNJ0LwVSTpuZ/VqiafM8lwekN4XbqjLkQQnwxajOf7elxh
 /Aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698265598; x=1698870398;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0FyOe0IRKpFI1erCpN6BCtMWvZSuTSWrywI6BoBtqVU=;
 b=FUufjVNENbgKCqqWrn5T8+FSZpwyDYMFLmBkMtFkRum54NCJmuQJ+vhdCbRBj7cZqA
 zuYVWBsK4k2IkV4E5g5klvRcTD50fJ6wx6gfdJTrZotmUIXoWRMkf5GQOX5hKUjeVp/Z
 s6d/4n7f9umYreZEC3GvN3/OFaYPzAt+4IWGnvfxOjioz+VdO/lnhLf6CVgDX/MhVQ8g
 qt7yYjTdLuK57cp9u5vMB3SJ+LlAPz9T/03NMUaKpAsJ9ViJDo02EFCz66dXmQedQJoX
 PUe8NnXG8yebYu/cRX8RD30S0xNZUpZF0+M/QEA7iTEPpKJl/Lm72HA3Oyyq0tnwGfTo
 uF/A==
X-Gm-Message-State: AOJu0YyxgospNAF4Dn+YZilNbfrHUcNlUUR8Xps92/kY+yk7FuLEyLMu
 DPiXMHy2b5f2l+AAwWaA7mOOeZxFUjbBM3Nn+4g=
X-Google-Smtp-Source: AGHT+IETAV4MZKkrYa5kXsNNVhMOueJaWuzq7rL0aaiPGtjXhcegEJjZC+bT85HNO8C5/O220pQIAw==
X-Received: by 2002:a05:6a20:394a:b0:16b:c8f8:a53c with SMTP id
 r10-20020a056a20394a00b0016bc8f8a53cmr6483221pzg.47.1698265598474; 
 Wed, 25 Oct 2023 13:26:38 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 e29-20020aa7981d000000b00690daae925bsm9739547pfl.51.2023.10.25.13.26.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 13:26:38 -0700 (PDT)
Message-ID: <6694df94-a28e-4853-b3f2-272f29f4f251@linaro.org>
Date: Wed, 25 Oct 2023 13:26:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 9/9] target/ppc: Use tcg_gen_sextract_tl
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20231023160944.10692-1-philmd@linaro.org>
 <20231023160944.10692-10-philmd@linaro.org>
 <b9d9c1a0-5b20-4d33-aaf2-f12097122004@linaro.org>
 <CWHBYSZE3X91.1YCI4JXJ3H2SE@wheely>
 <9da94605-2320-d90d-7caf-847e615f730b@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <9da94605-2320-d90d-7caf-847e615f730b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/25/23 00:33, Philippe Mathieu-Daudé wrote:
> Hi Nicholas,
> 
> On 25/10/23 09:09, Nicholas Piggin wrote:
>> On Tue Oct 24, 2023 at 11:04 AM AEST, Richard Henderson wrote:
>>> On 10/23/23 09:09, Philippe Mathieu-Daudé wrote:
>>>> Inspired-by: Richard Henderson <richard.henderson@linaro.org>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>> RFC: Please double-check 32/64 & bits
>>>> ---
>>>>    target/ppc/translate.c | 22 ++++------------------
>>>>    1 file changed, 4 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>>>> index c6e1f7c2ca..1370db9bd5 100644
>>>> --- a/target/ppc/translate.c
>>>> +++ b/target/ppc/translate.c
>>>> @@ -2892,13 +2892,7 @@ static void gen_slw(DisasContext *ctx)
>>>>        t0 = tcg_temp_new();
>>>>        /* AND rS with a mask that is 0 when rB >= 0x20 */
>>>> -#if defined(TARGET_PPC64)
>>>> -    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x3a);
>>>> -    tcg_gen_sari_tl(t0, t0, 0x3f);
>>>> -#else
>>>> -    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x1a);
>>>> -    tcg_gen_sari_tl(t0, t0, 0x1f);
>>>> -#endif
>>>> +    tcg_gen_sextract_tl(t0, cpu_gpr[rB(ctx->opcode)], 5, 1);
>>>>        tcg_gen_andc_tl(t0, cpu_gpr[rS(ctx->opcode)], t0);
>>>
>>> Patch looks correct as is, so
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 
> So are you OK to take this patch as-is as a first iteration?

I am, yes.  The simple fact of the ifdef removal is worth it.


r~

