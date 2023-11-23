Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4218A7F6575
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 18:32:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6DY1-00015x-2a; Thu, 23 Nov 2023 12:31:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6DXa-00015T-1l
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 12:31:02 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6DXY-00088o-8R
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 12:31:01 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40b27726369so7409575e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 09:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700760658; x=1701365458; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vwPN2hypCUQWCsULpj9bVM2BJNth0pNf1bvC0uKO+qQ=;
 b=ccuePExhdUKhOvetCWzv14IfyNz/32ccH++ZINGq1mglvB1ejETRN4BQg1TSgtY4A8
 2Gge3BY4YULw3rc4pkKwkHK1JTDFRLGkaTG/ndVvhULA3M3wJujpI6S4htv9PWRzP90Y
 3enGdf1O+ltac+1LHWO79SolqGWHNH+/EdxLwezi98e/1seovF+ehQCL+FoVGQGs8axB
 7e+vLPOBDp0n3AAEg3cgHVsqPKd3L9yQx9mPPvy530uFqxzJEPq459ePR8K5mX8XivPt
 Qs02EgAJ01VV1U5kcvi7SA01cBsJHmx+4CTVcsbiZMB59Jk34bvYbzXx8C9eUf7D1oi6
 FKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700760658; x=1701365458;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vwPN2hypCUQWCsULpj9bVM2BJNth0pNf1bvC0uKO+qQ=;
 b=ENZ3qTNJaaIntL7BHb/gT0BhPx6s2zRv3RCXZAG8B+CwasjDqL4f2aRvSWISxV53Rz
 ynEeiUqP6M+gBn4+rPRsZscVT4ZXoY9f1VP1jVqL7VzhkGtEhYLG4S74yAJJKdG5kIEM
 sFa/8DJdiRVdMtNSxNubQOB2ekzGWa2UkNI++47ijJtuHYwopjcbS9HPn9Xh8rTlelGr
 R2fSUwf7S+usl1UZuAgm8Fenru/GpWs1bLKZ2SgxhOkyB9WqW9fAZ0uTIFZ5M/9wW0QR
 QPvIcEmgaA+I5mmIXjTCy/oQwzezSggSjDCeRNy6G9UonVMiuSbmTbXi1pw8mGkmlJ3a
 1gSg==
X-Gm-Message-State: AOJu0Yw1CTWqMYpGR/HuX2L9tyDiMx32MnnhrGVsOAeYZI5jXlL0A3ji
 z/m7ewDvMOh39NLlTJJSdNCqUQ==
X-Google-Smtp-Source: AGHT+IG+zuJqouHrqIfpLrz3vvIvd3tSx0M7HEyzYwm+rZb9zqvESyR0oRsPuqig00AAycTQe0XoPA==
X-Received: by 2002:a05:600c:35d5:b0:401:bcd9:4871 with SMTP id
 r21-20020a05600c35d500b00401bcd94871mr235048wmq.21.1700760658524; 
 Thu, 23 Nov 2023 09:30:58 -0800 (PST)
Received: from [192.168.69.100] ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 p18-20020a05600c359200b0040b360cc65csm2613436wmq.0.2023.11.23.09.30.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 09:30:58 -0800 (PST)
Message-ID: <2db81947-648f-421d-86f1-b48cdab55852@linaro.org>
Date: Thu, 23 Nov 2023 18:30:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-9.0 01/11] qom: Introduce the
 TypeInfo::can_register() handler
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20231122183048.17150-1-philmd@linaro.org>
 <20231122183048.17150-2-philmd@linaro.org>
 <dc8664c2-c1d4-4e11-8bcd-9465a2d97174@redhat.com>
 <59101052-6446-443c-8934-581b90a9bd2b@linaro.org>
 <010c573d-17e6-43be-bb8f-6c3ff934bf4a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <010c573d-17e6-43be-bb8f-6c3ff934bf4a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 23/11/23 17:24, Thomas Huth wrote:
> On 23/11/2023 17.03, Philippe Mathieu-Daudé wrote:
>> On 23/11/23 16:09, Thomas Huth wrote:
>>> On 22/11/2023 19.30, Philippe Mathieu-Daudé wrote:
>>>> Add a helper to decide at runtime whether a type can
>>>> be registered to the QOM framework or not.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>   include/qom/object.h | 4 ++++
>>>>   qom/object.c         | 3 +++
>>>>   2 files changed, 7 insertions(+)
>>>>
>>>> diff --git a/include/qom/object.h b/include/qom/object.h
>>>> index afccd24ca7..0d42fe17de 100644
>>>> --- a/include/qom/object.h
>>>> +++ b/include/qom/object.h
>>>> @@ -372,6 +372,8 @@ struct Object
>>>>    * struct TypeInfo:
>>>>    * @name: The name of the type.
>>>>    * @parent: The name of the parent type.
>>>> + * @can_register: This optional function is called before a type is 
>>>> registered.
>>>> + *   If it exists and returns false, the type is not registered.
>>>
>>> The second sentence is quite hard to parse, since it is not quite 
>>> clear what "it" refers to (type or function) and what "registered" 
>>> means in this context (you don't mention type_register() here).
>>>
>>> Maybe rather something like:
>>>
>>> If set, type_register() uses this function to decide whether the type 
>>> can be registered or not.
>>>
>>> ?
>>>
>>>>    * @instance_size: The size of the object (derivative of 
>>>> #Object).  If
>>>>    *   @instance_size is 0, then the size of the object will be the 
>>>> size of the
>>>>    *   parent object.
>>>> @@ -414,6 +416,8 @@ struct TypeInfo
>>>>       const char *name;
>>>>       const char *parent;
>>>> +    bool (*can_register)(void);
>>>> +
>>>>       size_t instance_size;
>>>>       size_t instance_align;
>>>>       void (*instance_init)(Object *obj);
>>>> diff --git a/qom/object.c b/qom/object.c
>>>> index 95c0dc8285..f09b6b5a92 100644
>>>> --- a/qom/object.c
>>>> +++ b/qom/object.c
>>>> @@ -150,6 +150,9 @@ static TypeImpl *type_register_internal(const 
>>>> TypeInfo *info)
>>>>   TypeImpl *type_register(const TypeInfo *info)
>>>>   {
>>>>       assert(info->parent);
>>>> +    if (info->can_register && !info->can_register()) {
>>>> +        return NULL;
>>>> +    }
>>>
>>> I have to say that I don't like it too much, since you're trying to 
>>> fix a problem here in common code that clearly belongs to the code in 
>>> hw/arm/ instead.
>>>
>>> What about dropping it, and changing your last patch to replace the 
>>> DEFINE_TYPES(raspi_machine_types) in hw/arm/raspi.c with your own 
>>> implementation of type_register_static_array() that checks the 
>>> condition there?
>>
>> This isn't ARM specific, it happens I started to unify ARM/aarch64
>> binaries.
>>
>> Types can be registered depending on build-time (config/host specific)
>> definitions and runtime ones. How can we check for runtime if not via
>> this simple helper?
>>
>> Still ARM, but as example what I have then is (module meson):
> ...
>> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
>> index 1e9c6c85ae..c3b7e5666c 100644
>> --- a/target/arm/cpu64.c
>> +++ b/target/arm/cpu64.c
>> @@ -744,7 +744,8 @@ static void aarch64_max_initfn(Object *obj)
>>   static const ARMCPUInfo aarch64_cpus[] = {
>>       { .name = "cortex-a57",         .initfn = aarch64_a57_initfn },
>>       { .name = "cortex-a53",         .initfn = aarch64_a53_initfn },
>> -    { .name = "max",                .initfn = aarch64_max_initfn },
>> +    { .name = "max",                .initfn = aarch64_max_initfn,
>> +                                    .can_register = 
>> target_aarch64_available },
>>   #if defined(CONFIG_KVM) || defined(CONFIG_HVF)
>>       { .name = "host",               .initfn = aarch64_host_initfn },
>>   #endif
> 
> Picking this one as an example, I think I'd rather modify the for-loop in
> aarch64_cpu_register_types() to check for the availability there... 
> sounds much easier to understand for me than having a callback function.

OK.

> Anyway, that's just my personal taste - if others agree with your 
> solution instead, I won't insist on my idea.

This is a RFC so let's discuss :) I think there is a need to filter
QOM types at runtime (at least in "Single Binary" or "Heterogeneous
machines"), but I might be wrong.
Maybe we can filter that elsewhere (here seemed the simplest / more
natural place). I'll keep looking.

Regards,

Phil.

