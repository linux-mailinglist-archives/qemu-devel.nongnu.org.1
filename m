Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF34E799D68
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 10:59:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfGGh-00064Q-Up; Sun, 10 Sep 2023 04:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qfGGf-00063q-Jy
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 04:58:09 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qfGGc-0001bX-Ow
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 04:58:08 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3a9f88b657eso2459316b6e.3
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 01:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694336285; x=1694941085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ymja7zgXhMDeNB0Z4YKM/jr+HzjYlq1FnrK/Qx6u7Ko=;
 b=VJ+S4nNmBswlFOVKwQFoBlE3fkJSkiOAl0DweLBeBxyADEENgmrZ3fuj6ZFa8dL4Pt
 loY5tIbx8ie1AR5PBPlx8wDFf1Sf0ZlzJRvUcVcSJT5fD48WDRG6lCa/o2TECjU5Vd0V
 ROdYe+dA9Mj5UF1FJE/wx9CaqpqfCD3ZA4Vwg0+ssH1up6T6PJD3ePnv9KmTLvVgwA+b
 QBuOK2WL2e2OWTRBzeuR/y3oIMAsX8jO8P3QqVJlYAJoaOh1Lc1sOlklpSxpFqtHvpDJ
 k6wUSNUY4V0VZTt1BF1LrU/QfQvWkS2v7AKTFWvi6vQUjlKiozWLYUtdRqvj99KOX+3w
 cOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694336285; x=1694941085;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ymja7zgXhMDeNB0Z4YKM/jr+HzjYlq1FnrK/Qx6u7Ko=;
 b=rqPp54MkvcZRlELNfpBvkYD7JklLc6ffGx/gzKl1u2i1bRG+gq4c/WxEa6C6Nuc/E2
 6xebqmVdBbf20Q8pdhvuVvGHyXHZZdtWoOE8kqSYBTt2Cyc4S5RwGVUZBrrRo6b7sHev
 FZfOLT/Olw/DAiXIyuBYl0VCV1zXbpXdOxgPGdbukXa/qGzXejWdkuo8wXH4aZxG7QhE
 pMug/re65EllPJm71dZ0v1mXA1u73Y6pOkEtLHDoRrG5AsS7OeuKs41Fcu1EjUPo46HS
 MUGda1ZbZjuzPal7JLaKtz7t37IwO9lqQ6iitDdXge9D2kyRtCVZvC+/0PX+txDr9P54
 iLZw==
X-Gm-Message-State: AOJu0YyWzE+9OJX8/TTrp3NlrEQj8oEg5sBePsC4vwbqbio2vPMUkUxn
 LS1SUBeo7z7CQBAHuhI5Z8ZriA==
X-Google-Smtp-Source: AGHT+IG2vw27+PHHb5AP4Ed/823OYFJVgryEyENpQkHKuviBuI0MR+L7D/TFS4Icucu3i/MNAsYnQA==
X-Received: by 2002:a05:6808:1153:b0:3aa:86e:2c95 with SMTP id
 u19-20020a056808115300b003aa086e2c95mr10500523oiu.6.1694336284933; 
 Sun, 10 Sep 2023 01:58:04 -0700 (PDT)
Received: from [192.168.68.107] ([177.9.182.82])
 by smtp.gmail.com with ESMTPSA id
 be3-20020a056808218300b003a5b027ccb2sm2248840oib.38.2023.09.10.01.58.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Sep 2023 01:58:04 -0700 (PDT)
Message-ID: <271e0ae3-86c2-870a-f596-55755e67c6f0@ventanamicro.com>
Date: Sun, 10 Sep 2023 05:58:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 48/65] target/riscv/cpu.c: split kvm prop handling to its
 own helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Weiwei Li <liweiwei@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
 <20230908060431.1903919-49-alistair.francis@wdc.com>
 <0bdad3e3-bfd6-ffea-a725-46b9e4629756@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <0bdad3e3-bfd6-ffea-a725-46b9e4629756@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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



On 9/8/23 10:21, Philippe Mathieu-Daudé wrote:
> On 8/9/23 08:04, Alistair Francis wrote:
>> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>
>> Future patches will split the existing Property arrays even further, and
>> the existing code in riscv_cpu_add_user_properties() will start to scale
>> bad with it because it's dealing with KVM constraints mixed in with TCG
>> constraints. We're going to pay a high price to share a couple of common
>> lines of code between the two.
>>
>> Create a new riscv_cpu_add_kvm_properties() that will be forked from
>> riscv_cpu_add_user_properties() if we're running KVM. The helper
>> includes all properties that a KVM CPU will add. The rest of
>> riscv_cpu_add_user_properties() body will then be relieved from having
>> to deal with KVM constraints.
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>> Message-ID: <20230901194627.1214811-4-dbarboza@ventanamicro.com>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>   target/riscv/cpu.c | 65 ++++++++++++++++++++++++++++++----------------
>>   1 file changed, 42 insertions(+), 23 deletions(-)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index db640e7460..8e6d316500 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -1943,6 +1943,46 @@ static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
>>   }
>>   #endif
>> +#ifndef CONFIG_USER_ONLY
> 
> #ifdef CONFIG_KVM ?

Yeah, CONFIG_KVM would be more fitting here. We're moving all this code to kvm.c
in "[PATCH v2 00/19] riscv: split TCG/KVM accelerators from cpu.c", and we won't
need neither in the end, so for now it's simpler to temporarily leave it like
this.


Thanks,

Daniel

> 
>> +static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *prop_name)
>> +{
>> +    /* Check if KVM created the property already */
>> +    if (object_property_find(obj, prop_name)) {
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * Set the default to disabled for every extension
>> +     * unknown to KVM and error out if the user attempts
>> +     * to enable any of them.
>> +     */
>> +    object_property_add(obj, prop_name, "bool",
>> +                        NULL, cpu_set_cfg_unavailable,
>> +                        NULL, (void *)prop_name);
>> +}
>> +
>> +static void riscv_cpu_add_kvm_properties(Object *obj)
>> +{
>> +    Property *prop;
>> +    DeviceState *dev = DEVICE(obj);
>> +
>> +    kvm_riscv_init_user_properties(obj);
>> +    riscv_cpu_add_misa_properties(obj);
>> +
>> +    for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
>> +        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
>> +    }
>> +
>> +    for (int i = 0; i < ARRAY_SIZE(riscv_cpu_options); i++) {
>> +        /* Check if KVM created the property already */
>> +        if (object_property_find(obj, riscv_cpu_options[i].name)) {
>> +            continue;
>> +        }
>> +        qdev_property_add_static(dev, &riscv_cpu_options[i]);
>> +    }
>> +}
>> +#endif
>> +
>>   /*
>>    * Add CPU properties with user-facing flags.
>>    *
>> @@ -1958,39 +1998,18 @@ static void riscv_cpu_add_user_properties(Object *obj)
>>       riscv_add_satp_mode_properties(obj);
>>       if (kvm_enabled()) {
>> -        kvm_riscv_init_user_properties(obj);
>> +        riscv_cpu_add_kvm_properties(obj);
>> +        return;
>>       }
>>   #endif
>>       riscv_cpu_add_misa_properties(obj);
>>       for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
>> -#ifndef CONFIG_USER_ONLY
>> -        if (kvm_enabled()) {
>> -            /* Check if KVM created the property already */
>> -            if (object_property_find(obj, prop->name)) {
>> -                continue;
>> -            }
>> -
>> -            /*
>> -             * Set the default to disabled for every extension
>> -             * unknown to KVM and error out if the user attempts
>> -             * to enable any of them.
>> -             */
>> -            object_property_add(obj, prop->name, "bool",
>> -                                NULL, cpu_set_cfg_unavailable,
>> -                                NULL, (void *)prop->name);
>> -            continue;
>> -        }
>> -#endif
>>           qdev_property_add_static(dev, prop);
>>       }
>>       for (int i = 0; i < ARRAY_SIZE(riscv_cpu_options); i++) {
>> -        /* Check if KVM created the property already */
>> -        if (object_property_find(obj, riscv_cpu_options[i].name)) {
>> -            continue;
>> -        }
>>           qdev_property_add_static(dev, &riscv_cpu_options[i]);
>>       }
>>   }
> 

