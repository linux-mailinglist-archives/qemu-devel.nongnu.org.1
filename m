Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B38B2777EC3
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 19:06:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU96V-0008Pr-Hm; Thu, 10 Aug 2023 13:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qU96T-0008Oy-Rh
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 13:05:41 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qU96S-000600-0X
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 13:05:41 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-686efa1804eso851271b3a.3
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 10:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691687138; x=1692291938;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bHlZGMkapcKLLIr41RCc4qF3Clv1trayfwPgsmkFMyE=;
 b=ytUvNGYBQaWn1KW6HyAOQhM+1WFwJ1FPmpesF1t5H0kyOZ67+KJu14UzmAVDkNGHGq
 3cII2bqEkBV2lpy/0VS7qsLGuoaSxL3VZXeRZ1/NOVdvdBEAgMNnK8ogNz0OlJgUHdSS
 NJnowRKgTtgMs9hpMKai4VNolslY6UytZN7nO6MmYryyFmOVcNo5PvUWNqShjuvdxYVS
 8GVEETRDswOp9j7Fh5qf2m/bRpJ6jM1lpzIzlTxXJJl7DyaHEzzmX5Sm0jq5nZYuHtZQ
 POihmzrBPOKEQyabQeLS9PvAhjkYkUJfLB5JnuVdSc925J2PZIb7IgmJ7HHYTRHwi7K8
 svmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691687138; x=1692291938;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bHlZGMkapcKLLIr41RCc4qF3Clv1trayfwPgsmkFMyE=;
 b=FrH7mTiIDJIK8NhSCkHf4X/Y+Sk6hxErCG+Znh7YaNH5kAXspCt0XoZ6mUOAN6hkiB
 RvixJW+EV68gzTd0XGk1uFcMMnVN/WqVizINiwuINeesnhpfHs+yM+TdiZyp57nZFrRn
 kuVhzDx8yTznD6mpzcsiQlPDU141D9tj5TjxmvQnUzmkjE+iAE5FWapofN/otHn5GSbq
 a+BvzWE+OwvaYoEM5JgKji5jd71arWKfPLSgptlVcxZx87MjDTo1uAX+p8+mraTY+ygI
 KMBAr4M4QBOwBvRPJrjVKzCXR+Cp+CbWuNszrCptE4AnPYAyxqylYEy/4Y9kvu1IIGso
 v34w==
X-Gm-Message-State: AOJu0YyEL8Oof3Ly02dZ1tB4DAqdtvDZrHQsY990Bp/KTSlBSi5gHRrZ
 M/Up0YYy97OmJ9vrNiUWCgvULg==
X-Google-Smtp-Source: AGHT+IFRNi/SJSJv999xCPKlVY73i8QzvpoUEmYMq1nj7FK98ZVkEPhUsWxC5MTRHx5eofQJWjy1Bg==
X-Received: by 2002:a05:6a00:1943:b0:687:5763:ef27 with SMTP id
 s3-20020a056a00194300b006875763ef27mr3849663pfk.33.1691687138413; 
 Thu, 10 Aug 2023 10:05:38 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:9e4d:b830:d4fd:9164?
 ([2602:47:d483:7301:9e4d:b830:d4fd:9164])
 by smtp.gmail.com with ESMTPSA id
 x27-20020a056a00271b00b006827c26f147sm1761345pfv.138.2023.08.10.10.05.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 10:05:37 -0700 (PDT)
Message-ID: <17230fdc-6daf-82be-e665-97ca64d16feb@linaro.org>
Date: Thu, 10 Aug 2023 10:05:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/5] target/arm: Implement cortex-a710
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20230810023548.412310-1-richard.henderson@linaro.org>
 <20230810023548.412310-6-richard.henderson@linaro.org>
 <CAFEAcA_Lzj1LEutMro72fCfqiCWtOpd+5b-YPcfKv8Bg1f+rCg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_Lzj1LEutMro72fCfqiCWtOpd+5b-YPcfKv8Bg1f+rCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.156,
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

On 8/10/23 08:49, Peter Maydell wrote:
> On Thu, 10 Aug 2023 at 03:36, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> The cortex-a710 is a first generation ARMv9.0-A processor.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   docs/system/arm/virt.rst |   1 +
>>   hw/arm/virt.c            |   1 +
>>   target/arm/tcg/cpu64.c   | 167 +++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 169 insertions(+)
>>
>> diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
>> index 51cdac6841..e1697ac8f4 100644
>> --- a/docs/system/arm/virt.rst
>> +++ b/docs/system/arm/virt.rst
>> @@ -58,6 +58,7 @@ Supported guest CPU types:
>>   - ``cortex-a57`` (64-bit)
>>   - ``cortex-a72`` (64-bit)
>>   - ``cortex-a76`` (64-bit)
>> +- ``cortex-a710`` (64-bit)
>>   - ``a64fx`` (64-bit)
>>   - ``host`` (with KVM only)
>>   - ``neoverse-n1`` (64-bit)
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 7d9dbc2663..d1522c305d 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -211,6 +211,7 @@ static const char *valid_cpus[] = {
>>       ARM_CPU_TYPE_NAME("cortex-a55"),
>>       ARM_CPU_TYPE_NAME("cortex-a72"),
>>       ARM_CPU_TYPE_NAME("cortex-a76"),
>> +    ARM_CPU_TYPE_NAME("cortex-a710"),
>>       ARM_CPU_TYPE_NAME("a64fx"),
>>       ARM_CPU_TYPE_NAME("neoverse-n1"),
>>       ARM_CPU_TYPE_NAME("neoverse-v1"),
> 
> Will sbsa-ref want this core ?

It only has 40 PA bits, and I think sbsa-ref requires 48.

>> +static void define_cortex_a710_cp_reginfo(ARMCPU *cpu)
>> +{
>> +    /*
>> +     * The Cortex A710 has all of the Neoverse V1's IMPDEF
>> +     * registers and a few more of its own.
>> +     */
>> +    define_arm_cp_regs(cpu, neoverse_n1_cp_reginfo);
>> +    define_arm_cp_regs(cpu, neoverse_v1_cp_reginfo);
>> +    define_arm_cp_regs(cpu, cortex_a710_cp_reginfo);
> 
> The TRM doesn't document the existence of these regs
> from the n1 reginfo:
> 
>      { .name = "ERXPFGCDN_EL1", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 2, .opc2 = 2,
>        .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
>      { .name = "ERXPFGCTL_EL1", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 2, .opc2 = 1,
>        .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
>      { .name = "ERXPFGF_EL1", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 2, .opc2 = 0,
>        .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
> 
> This one in the v1 reginfo:
> 
>      { .name = "CPUPPMCR3_EL3", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 2, .opc2 = 6,
>        .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
> 
> exists but has been renamed CPUPPMCR6_EL3, which means it's
> a duplicate of an entry in your new array. Meanwhile the
> A710's actual CPUPPMCR3_EL3 at 3, 0, c15, c2, 4 isn't in
> your new array.
> 
> (I thought we had an assert to detect duplicate regdefs,
> so I'm surprised this didn't fall over.)

It did fall over.  Pre-send-email testing mistake, which I found immediately after (of 
course).

>> +    cpu->revidr = cpu->midr;         /* mirror midr: "no significance" */
> 
> The bit about "no significance" is just the boilerplate text from
> the architecture manual. I think we should continue our usual
> practice of setting the revidr to 0.

Ok.

>> +    cpu->isar.id_dfr0  = 0x06011099; /* w/o FEAT_TRF */
> 
> You don't have to suppress FEAT_TRF manually, we do
> it in cpu.c.

Ok.

>> +    cpu->isar.id_isar5 = 0x11011121;
> 
> For isar5 we could say /* with Crypto */

Ok.

>> +    cpu->isar.id_mmfr4 = 0x21021110;
> 
> I don't think we implement HPDS == 2 (that's FEAT_HPDS2).
> I guess we should push it down to HPDS 1 only in cpu.c
> for now. (Or implement it, it's probably simple.)

Feh.  I thought I'd double-checked all of the features.
I'll have a look at implementing that.

>> +    cpu->ctr               = 0x00000004b444c004ull; /* with DIC set */
> 
> Why set DIC? The h/w doesn't.

Heh.  From the comment in neoverse-v1, I thought you had force enabled it there.  But it 
must simply be a h/w option?

>> +    cpu->ccsidr[0] = 0x000000ff0000001aull; /* 64KB L1 dcache */
>> +    cpu->ccsidr[1] = 0x000000ff0000001aull; /* 64KB L1 icache */
>> +    cpu->ccsidr[2] = 0x000003ff0000003aull; /* 512KB L2 cache */
> 
> I was too lazy to do this for neoverse-v1, so I don't insist
> on it here, but if we're going to find ourselves calculating
> new-format ccsidr values by hand for each new CPU, I wonder if we
> should define a macro that takes numsets, assoc, linesize,
> subtracts 1 where relevant, and shifts them into the right bit
> fields? (Shame the preprocessor can't do a log2() operation ;-))

I'll create something for this.
It doesn't need to be in the preprocessor.  :-)

Thanks for the careful review.


r~

