Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F5B7E01D1
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 12:14:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qys7N-0004bu-KU; Fri, 03 Nov 2023 07:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qys74-0004aZ-GO
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 07:13:20 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qys72-0002Ow-QR
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 07:13:18 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5a7af20c488so22768527b3.1
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 04:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699009995; x=1699614795; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JA3RR4rtm2a/sTahFfyNSqYzyXXStrRf5q8McaLuW8A=;
 b=XAhHuJAv8EBMj6C/TGRxsfrqzvKBBpLi9CDVaLyRU/82v9oO1EKOec0kgyiQP4aqUW
 IcbT62Wez3HWXTHcN4JJv/AzYB/S7DQTaTTdP+FE7PdZAVHj15l9/jaI/5yzl9YU7Nfn
 fIDkDeYsnzLOP3ImdmlannlBSVnchPHLXiewbtryiwYOuGgjTayd/WaosYY1MJFTJbGh
 iDPcnNXqzckOMZ3py369EDU1YKVnm6ENuGcO3OBZ7/0DcSOzB207O5r0E21bRT3MgOIG
 J26KezzD8uBscHc1xHZ1IUy+WirRMBkgOwOnWI4WCSAyaYZzI3fV6qP+n792rC6pqQT2
 l+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699009995; x=1699614795;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JA3RR4rtm2a/sTahFfyNSqYzyXXStrRf5q8McaLuW8A=;
 b=ANWCQHlX6V5+Jpj+7+WNlvN25jf0cOKuXjPPRuQ5jXzlQU6XoiIU1gkO7JZob5fL4I
 0gbNj/wAF/05Ixv1PEsDoITv1ogzgVAXrt4+WCO9vippQR557arzkv8aEXZ8N5ueik8z
 maAKVbkcHQn/Ug1m8DdsSEPo4fMnJcE6xGDW8gRL0aHVSEn4aU9nXGkzDierRPDK4IoR
 Bf+1YI6KQS/s1cIi/xGu7jlE6qGnr/dAgf0268klSBfybC2uAUgBTN0UobUNh/B1vCDJ
 E81eFi1QsWmsE3Fk3XpY0nEGTT0GUjd/TklmjVgUDDfdQecjOkqEO2j8WGdknbHZktlJ
 SMcQ==
X-Gm-Message-State: AOJu0YxhmtZzDtxMbnVkQvzzL9RCOPb2cRbFRknFwDtLIQzd3o7pwWAv
 4AFai8DfPrj3XFRY1P/Re8IqnA==
X-Google-Smtp-Source: AGHT+IHCO3pyWWAuOgt/8H46cKVYLgGrRQAnPf9oktkD2Sx/d12xFH8fbEFff8eNx23rXUoYZ2i5gQ==
X-Received: by 2002:a81:658b:0:b0:583:a3ab:b950 with SMTP id
 z133-20020a81658b000000b00583a3abb950mr2292368ywb.50.1699009995463; 
 Fri, 03 Nov 2023 04:13:15 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bdcd:fb00:6501:2693:db52:c621?
 ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 k10-20020a81ff0a000000b00576c727498dsm782800ywn.92.2023.11.03.04.13.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Nov 2023 04:13:15 -0700 (PDT)
Message-ID: <489c957d-f4e0-41f4-968c-bea369680a72@ventanamicro.com>
Date: Fri, 3 Nov 2023 08:13:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 19/19] target/riscv/tcg: do not support profiles for
 'max' CPU
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com
References: <20231102224445.527355-1-dbarboza@ventanamicro.com>
 <20231102224445.527355-20-dbarboza@ventanamicro.com>
 <20231103-00c3877949914a4e56f4be79@orel>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231103-00c3877949914a4e56f4be79@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 11/3/23 06:01, Andrew Jones wrote:
> On Thu, Nov 02, 2023 at 07:44:45PM -0300, Daniel Henrique Barboza wrote:
>> There's no gain in allowing the 'max' CPU to support profiles, since it
>> already contains everything that QEMU can support. And we'll open the
>> door for 'unorthodox' stuff like users disabling profiles of the 'max'
>> CPU.
> 
> I don't see a lot of value in this patch, but maybe I'm just too cruel to
> users that don't know what they're doing. I even see a negative value to
> this patch because I can conceive of writing a script where I generally
> want to use rv64i with my explicit list of profiles/extensions, but then
> I may want to temporarily "boost" my CPU to 'max' for some reason. If
> I write my script like
> 
>   CPU=rv64i
>   EXTENSIONS=profile=on,extension=on
>   qemu -cpu $CPU,$EXTENSIONS ...
> 
> then I can't just do
> 
>   CPU=max ./my-script
> 
> to boost my CPU, since max will error out when it sees profiles being
> enabled (even though that should be no-op for it). Instead, I need to
> do
> 
>   CPU=max EXTENSIONS= ./my-script
> 
> which isn't horrible, but a bit annoying.
> 
> So, personally, I would drop this patch.


Fair enough. I wasn't creative enough with scripting to see the value of 'max' and
profiles. Let's drop it.

Thanks,

Daniel

> 
> Thanks,
> drew
> 
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/tcg/tcg-cpu.c | 16 +++++++++++-----
>>   1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
>> index 553fb337e7..9a964a426e 100644
>> --- a/target/riscv/tcg/tcg-cpu.c
>> +++ b/target/riscv/tcg/tcg-cpu.c
>> @@ -825,6 +825,11 @@ static bool riscv_cpu_is_vendor(Object *cpu_obj)
>>       return object_dynamic_cast(cpu_obj, TYPE_RISCV_VENDOR_CPU) != NULL;
>>   }
>>   
>> +static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
>> +{
>> +    return object_dynamic_cast(cpu_obj, TYPE_RISCV_CPU_MAX) != NULL;
>> +}
>> +
>>   /*
>>    * We'll get here via the following path:
>>    *
>> @@ -1003,6 +1008,12 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
>>           return;
>>       }
>>   
>> +    if (riscv_cpu_has_max_extensions(obj)) {
>> +        error_setg(errp, "Profile %s is not available for the 'max' CPU",
>> +                   profile->name);
>> +        return;
>> +    }
>> +
>>       if (cpu->env.misa_mxl != MXL_RV64) {
>>           error_setg(errp, "Profile %s only available for 64 bit CPUs",
>>                      profile->name);
>> @@ -1251,11 +1262,6 @@ static void riscv_init_max_cpu_extensions(Object *obj)
>>       }
>>   }
>>   
>> -static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
>> -{
>> -    return object_dynamic_cast(cpu_obj, TYPE_RISCV_CPU_MAX) != NULL;
>> -}
>> -
>>   static void tcg_cpu_instance_init(CPUState *cs)
>>   {
>>       RISCVCPU *cpu = RISCV_CPU(cs);
>> -- 
>> 2.41.0
>>

