Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB4277112F
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 19:59:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSLXt-0000Ji-2g; Sat, 05 Aug 2023 13:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSLXq-0000JK-Mg
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 13:58:30 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSLXn-0004OP-U0
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 13:58:30 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-564ef63a010so21821a12.0
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 10:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691258306; x=1691863106;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8y/eHBmxVsLmGma2dyR9Q5dtplTXJNr7OgFVvcQ9v3s=;
 b=EYUJp0VR/XpPfl7AYXcf5panqYnaHxw5D93xswSQh/YV7SHzNQeCAXJOL2wMRGMMUg
 otK4+ql98tZ3PXR3OTDuTNPimgisNGlE19mytequFrfZUj2OzkyY2qALVeB/8KXLJPOR
 7DID46LWOfFFMa84pdmJ79LADMUg4NDlc1IQK2vmYy9v6XeZ8jGKb0viq2zHL52nPhrX
 +97f3YfAy/lvTZphhVwNcMV2Txe0Y0MRhlkm7n3XYxX+b9Om17jxUMiIn4f3jGGMPWP9
 ABfYjMPN+aGcx55MgmzDvT+uft97Ooses+fR8e63xGoM7ySjju5JeR39mqnaVFBtS4gr
 5Mlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691258306; x=1691863106;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8y/eHBmxVsLmGma2dyR9Q5dtplTXJNr7OgFVvcQ9v3s=;
 b=jEXKG3cTTBxA+wFny9BoGBHPQAu/PwgeQBaQ4s1ElLDr8wBaeaw1jz0tjesW/k2JWq
 ZO4ULkk5Vavz/9ZL57XVyh+VVZDk/530lFaKi4K3AsHCURedjYA9oek88VZrOWwnAVZE
 AACSpYnI6ZDXoRoGxs2S4DlPZ1lHK3kPtlKz3No2R1LTcG7KOA6xN3lQLKokebuIcdgW
 MYzpL2/1tPtMJTKoTBS9sdbixhqW44LhtZ3iJTA3NJ8Jul85BWPf9h8GHGvPOGauJwO8
 pZvQ0TfM1nonahc74fMuzXHecxZe0+6J94phi9U+d8HLpjGrFYd+rDk5JJY1N9RVJp+H
 9kDQ==
X-Gm-Message-State: AOJu0Yy5zQQQNPTwd+C7DIQWu54jiPJrCFE9Chmy7A/TW1KtVnxd/AtJ
 tel7dnYMWhA+wjVPewQrm7SJWXO8oB6jXoQboWw=
X-Google-Smtp-Source: AGHT+IGbvddJ5iaCg8zWcoE9Qbx4tHrdo0Jgl6YE1REPCdqAY4X4tDpdeHzpYMnN0qb31xUBQQZmjQ==
X-Received: by 2002:a17:90a:d348:b0:267:f1d7:ed68 with SMTP id
 i8-20020a17090ad34800b00267f1d7ed68mr3713644pjx.14.1691258305838; 
 Sat, 05 Aug 2023 10:58:25 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:9454:a46f:1c22:a7c6?
 ([2602:47:d490:6901:9454:a46f:1c22:a7c6])
 by smtp.gmail.com with ESMTPSA id
 em5-20020a17090b014500b002680b2d2ab6sm5942129pjb.19.2023.08.05.10.58.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Aug 2023 10:58:25 -0700 (PDT)
Message-ID: <e4c887b7-a055-3b30-8d41-0e8be0bc5d30@linaro.org>
Date: Sat, 5 Aug 2023 10:58:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC][PATCH] Reduce generated code by 3% by increasing MMU indices
Content-Language: en-US
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org
References: <ZM59CkNZg5n4WXO3@p100>
 <53a2d13f-b508-0dba-5f0a-1b158372d1a4@linaro.org> <ZM6KOBfqFLumgpwm@p100>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZM6KOBfqFLumgpwm@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 8/5/23 10:43, Helge Deller wrote:
>> If there were a way to change no more than two lines of code, that would be
>> fine.  But otherwise I don't see this as being worth making the rest of the
>> code base any more complex.
> 
> Ok. What about that 6-line patch below for x86?
> It's trivial and all what's needed for x86.
> Btw, any index which is >= 9 will use the shorter code sequence.
> 
> Helge
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index e0771a1043..3e71e666db 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2251,11 +2251,11 @@ uint64_t cpu_get_tsc(CPUX86State *env);
>   #define cpu_list x86_cpu_list
> 
>   /* MMU modes definitions */
> -#define MMU_KSMAP_IDX   0
> -#define MMU_USER_IDX    1
> -#define MMU_KNOSMAP_IDX 2
> -#define MMU_NESTED_IDX  3
> -#define MMU_PHYS_IDX    4
> +#define MMU_KSMAP_IDX   11
> +#define MMU_USER_IDX    12
> +#define MMU_KNOSMAP_IDX 13
> +#define MMU_NESTED_IDX  14
> +#define MMU_PHYS_IDX    15

No.  The small patch would need to apply to all guests.

Perhaps something to handle indexing of CPUTLBDescFast, e.g.

static inline CPUTLBDescFast cputlb_fast(CPUTLB *tlb, unsigned idx)
{
     return &tlb->f[NB_MMU_MODES - 1 - idx];
}

There's already tlb_mask_table_ofs, which handles all tcg backends; you just need to 
adjust that and cputlb.c.

Introduce cputlb_fast with normal indexing in one patch, and then the second patch to 
invert the indexing may well be exactly two lines.  :-)


r~

