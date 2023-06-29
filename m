Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D24B742513
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 13:42:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEq0v-00030V-6L; Thu, 29 Jun 2023 07:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEq0r-0002zi-9N
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 07:40:37 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEq0p-0005I4-8m
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 07:40:36 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5634d8d1db0so373487eaf.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 04:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688038834; x=1690630834;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uFyok/UFZoKMfyxwKl4lVidO4fwklyfuTxeT29CJgQw=;
 b=LrKYTFw9edXOM5mDgNpetLsijJTO+VFlqaZp+CmuGNlgdxM5+g16MAGpZszjtlSOct
 GvOJDkIuAonXZzvd624YG8x2H5oj2rnmq3ORpQdqiraK4rNV/IvRSC4lahf4S7frpaFZ
 8t130pBN81qvR34eHEUk78BbYISaD/Ot85PHiIiXFAs9zhriWi8ojnyiYdD8HmTax3CH
 +mAD/qN2aIL5lwI7B/Kl5/f/16HDJM85WRYzABUkvuYJQWOMGqWLlqX4eArGLbAiyZAQ
 eWgh+6sBUYCTDmwvQDyoUfQNX6xsZbTrA9eg5K+D5SiH+mxYLDlq++ScKFCdtOrqRtTb
 WFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688038834; x=1690630834;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uFyok/UFZoKMfyxwKl4lVidO4fwklyfuTxeT29CJgQw=;
 b=H0fVcqynRzbcSGu/PH51WkY2DvM84iTA+i4D7UV9w4rKmvYP4qs2BNrBrnUlOae58h
 bprxUOeZr5hDX/Fu34vsrzLBuzd+FkfjcELe7WWkSbzvJ5lny+/WZyvyfL08EKO4RKgr
 uHu26Sese8eFc+EydwiGfw8bWnR+I0yQB2N1v4dy2uI9EZK2i9WaYiu7vYK2Jmm9KDhF
 5MnjJFJainohWZnUvH7Wxu2nNg3qKpgWajeSHX/UPAA6/zuYMe00yiVx6hcdv1VU0VAr
 4evIO546y2bO+80L61swxmkAGRsMpEhLyN8xOEraNgNjf8W5ypXUu4tMFDKp1DeFkifP
 7VHQ==
X-Gm-Message-State: AC+VfDzCGVoR1s+s9XiL+K7XNLHqCHc21tMPr0bqvVWzF6Cn6WG+Wtss
 qw2H4Y3RZ0AJsCVZY1hH1xMqjA==
X-Google-Smtp-Source: ACHHUZ6ndyOqKjZT/3P0KGHTdBB7u1HAR6GHAQ1wwtmv9SJ0s16BFayVH7D4VXVaGQU+r0zElLJjXw==
X-Received: by 2002:a4a:dbca:0:b0:563:568d:e274 with SMTP id
 t10-20020a4adbca000000b00563568de274mr8766991oou.7.1688038833864; 
 Thu, 29 Jun 2023 04:40:33 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:bdf2:b7ba:a476:c0e3:fb59?
 ([2804:7f0:bcc0:bdf2:b7ba:a476:c0e3:fb59])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a4ad8c7000000b00562f3936c01sm1692948oov.45.2023.06.29.04.40.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 04:40:33 -0700 (PDT)
Message-ID: <301b09a1-11dd-3413-15d3-c7bdd1f81dde@ventanamicro.com>
Date: Thu, 29 Jun 2023 08:40:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 11/20] target/riscv/cpu: add misa_ext_info_arr[]
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, philmd@linaro.org
References: <20230628213033.170315-1-dbarboza@ventanamicro.com>
 <20230628213033.170315-12-dbarboza@ventanamicro.com>
 <20230629-6a932f8d5f71fefc9afbd974@orel>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230629-6a932f8d5f71fefc9afbd974@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc29.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 6/29/23 05:59, Andrew Jones wrote:
> On Wed, Jun 28, 2023 at 06:30:24PM -0300, Daniel Henrique Barboza wrote:
>> Next patch will add KVM specific user properties for both MISA and
>> multi-letter extensions. For MISA extensions we want to make use of what
>> is already available in misa_ext_cfgs[] to avoid code repetition.
>>
>> misa_ext_info_arr[] array will hold name and description for each MISA
>> extension that misa_ext_cfgs[] is declaring. We'll then use this new
>> array in KVM code to avoid duplicating strings.
>>
>> There's nothing holding us back from doing the same with multi-letter
>> extensions. For now doing just with MISA extensions is enough.
>>
>> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/cpu.c | 83 ++++++++++++++++++++++++++++++----------------
>>   target/riscv/cpu.h |  7 +++-
>>   2 files changed, 61 insertions(+), 29 deletions(-)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 2485e820f8..90dd2078ae 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -1558,33 +1558,57 @@ static void cpu_get_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
>>       visit_type_bool(v, name, &value, errp);
>>   }
>>   
>> -static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
>> -    {.name = "a", .description = "Atomic instructions",
>> -     .misa_bit = RVA, .enabled = true},
>> -    {.name = "c", .description = "Compressed instructions",
>> -     .misa_bit = RVC, .enabled = true},
>> -    {.name = "d", .description = "Double-precision float point",
>> -     .misa_bit = RVD, .enabled = true},
>> -    {.name = "f", .description = "Single-precision float point",
>> -     .misa_bit = RVF, .enabled = true},
>> -    {.name = "i", .description = "Base integer instruction set",
>> -     .misa_bit = RVI, .enabled = true},
>> -    {.name = "e", .description = "Base integer instruction set (embedded)",
>> -     .misa_bit = RVE, .enabled = false},
>> -    {.name = "m", .description = "Integer multiplication and division",
>> -     .misa_bit = RVM, .enabled = true},
>> -    {.name = "s", .description = "Supervisor-level instructions",
>> -     .misa_bit = RVS, .enabled = true},
>> -    {.name = "u", .description = "User-level instructions",
>> -     .misa_bit = RVU, .enabled = true},
>> -    {.name = "h", .description = "Hypervisor",
>> -     .misa_bit = RVH, .enabled = true},
>> -    {.name = "x-j", .description = "Dynamic translated languages",
>> -     .misa_bit = RVJ, .enabled = false},
>> -    {.name = "v", .description = "Vector operations",
>> -     .misa_bit = RVV, .enabled = false},
>> -    {.name = "g", .description = "General purpose (IMAFD_Zicsr_Zifencei)",
>> -     .misa_bit = RVG, .enabled = false},
>> +typedef struct misa_ext_info {
>> +    const char *name;
>> +    const char *description;
>> +} MISAExtInfo;
>> +
>> +#define MISA_EXT_INFO(_idx, _propname, _descr) \
>> +    [(_idx - 'A')] = {.name = _propname, .description = _descr}
> 
> We don't have to give up on passing RV* to this macro. Directly
> using __builtin_ctz() with a constant should work, i.e.
> 
>   #define MISA_EXT_INFO(_bit, _propname, _descr) \
>       [__builtin_ctz(_bit)] = {.name = _propname, .description = _descr}
> 
> and then
> 
>   MISA_EXT_INFO(RVA, "a", "Atomic instructions"),
>   MISA_EXT_INFO(RVD, "d", "Double-precision float point"),
>   ...
> 
> (We don't need the ctz32() wrapper since we know we'll never input zero to
> __builtin_ctz().)

I'll give it a try. I'll spare us from having to assign name and descr during
runtime (at least for this file).

Daniel

> 
>> +
>> +static const MISAExtInfo misa_ext_info_arr[] = {
>> +    MISA_EXT_INFO('A', "a", "Atomic instructions"),
>> +    MISA_EXT_INFO('C', "c", "Compressed instructions"),
>> +    MISA_EXT_INFO('D', "d", "Double-precision float point"),
>> +    MISA_EXT_INFO('F', "f", "Single-precision float point"),
>> +    MISA_EXT_INFO('I', "i", "Base integer instruction set"),
>> +    MISA_EXT_INFO('E', "e", "Base integer instruction set (embedded)"),
>> +    MISA_EXT_INFO('M', "m", "Integer multiplication and division"),
>> +    MISA_EXT_INFO('S', "s", "Supervisor-level instructions"),
>> +    MISA_EXT_INFO('U', "u", "User-level instructions"),
>> +    MISA_EXT_INFO('H', "h", "Hypervisor"),
>> +    MISA_EXT_INFO('J', "x-j", "Dynamic translated languages"),
>> +    MISA_EXT_INFO('V', "v", "Vector operations"),
>> +    MISA_EXT_INFO('G', "g", "General purpose (IMAFD_Zicsr_Zifencei)"),
>> +};
>> +
>> +const char *riscv_get_misa_ext_name(uint32_t bit)
>> +{
>> +    return misa_ext_info_arr[ctz32(bit)].name;
>> +}
>> +
>> +const char *riscv_get_misa_ext_descr(uint32_t bit)
> 
> nit: I'd prefer riscv_get_misa_ext_description() for the name.
> 
>> +{
>> +    return misa_ext_info_arr[ctz32(bit)].description;
>> +}
>> +
>> +#define MISA_CFG(_bit, _enabled) \
>> +    {.misa_bit = _bit, .enabled = _enabled}
>> +
>> +static RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
>> +    MISA_CFG(RVA, true),
>> +    MISA_CFG(RVC, true),
>> +    MISA_CFG(RVD, true),
>> +    MISA_CFG(RVF, true),
>> +    MISA_CFG(RVI, true),
>> +    MISA_CFG(RVE, false),
>> +    MISA_CFG(RVM, true),
>> +    MISA_CFG(RVS, true),
>> +    MISA_CFG(RVU, true),
>> +    MISA_CFG(RVH, true),
>> +    MISA_CFG(RVJ, false),
>> +    MISA_CFG(RVV, false),
>> +    MISA_CFG(RVG, false),
>>   };
>>   
>>   static void riscv_cpu_add_misa_properties(Object *cpu_obj)
>> @@ -1592,7 +1616,10 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
>>       int i;
>>   
>>       for (i = 0; i < ARRAY_SIZE(misa_ext_cfgs); i++) {
>> -        const RISCVCPUMisaExtConfig *misa_cfg = &misa_ext_cfgs[i];
>> +        RISCVCPUMisaExtConfig *misa_cfg = &misa_ext_cfgs[i];
>> +
>> +        misa_cfg->name = riscv_get_misa_ext_name(misa_cfg->misa_bit);
>> +        misa_cfg->description = riscv_get_misa_ext_descr(misa_cfg->misa_bit);
> 
> This might be necessary for the KVM side, but we should be able to avoid
> this runtime setting here where the compiler can be certain everything is
> a constant. We just need the old MISA_CFG() back, slightly tweaked to use
> __builtin_ctz().
> 
>>   
>>           object_property_add(cpu_obj, misa_cfg->name, "bool",
>>                               cpu_get_misa_ext_cfg,
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index cc20ee25a7..acae118b9b 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -41,7 +41,10 @@
>>   
>>   #define RV(x) ((target_ulong)1 << (x - 'A'))
>>   
>> -/* Consider updating misa_ext_cfgs[] when adding new MISA bits here */
>> +/*
>> + * Consider updating misa_ext_info_arr[] and misa_ext_cfgs[]
>> + * when adding new MISA bits here.
>> + */
>>   #define RVI RV('I')
>>   #define RVE RV('E') /* E and I are mutually exclusive */
>>   #define RVM RV('M')
>> @@ -56,6 +59,8 @@
>>   #define RVJ RV('J')
>>   #define RVG RV('G')
>>   
>> +const char *riscv_get_misa_ext_name(uint32_t bit);
>> +const char *riscv_get_misa_ext_descr(uint32_t bit);
>>   
>>   /* Privileged specification version */
>>   enum {
>> -- 
>> 2.41.0
>>
> 
> Thanks,
> drew

