Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9487EDC5F
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:51:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3X9g-0007HK-1L; Thu, 16 Nov 2023 02:51:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3X9e-00076u-AN
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:51:14 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3X9b-0000YY-Td
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:51:14 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32fbf271346so339550f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 23:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700121069; x=1700725869; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=imm3XmsJBY7QdQDipdQqcYQNZts8WUb83R3yaIZiVOY=;
 b=qIDg3aM1PhXCE3bkGWrRb9uoKzK4GfHcmXlTp+/dXNqvmGSBdvztVM13MbU4jcyx3s
 oI/tjx9h5wTLEOhV4p7xDaC77s/veZgBw9uC3K81Ht97wrPWPdc06iIp6WzefEeHfhfa
 D3M9/3tlf/ysOV7WFUbVuFam1YMSbhH5Ai4XqfriQ7GR25Z0I8Qnun+w38R9QPMVF4DH
 P3YMhHZyMMAdXQ8GXnKFnFvsmB4jAT9bVX4NIr5ILjPvv5A2GtC2rW+hljoJNulFCLla
 /Go6Ct78hExi68cKSl2vEjHCRzmA632epnnUzOfVE0DI7cusyJZH318M6sdU6M/JuJVs
 3kCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700121069; x=1700725869;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=imm3XmsJBY7QdQDipdQqcYQNZts8WUb83R3yaIZiVOY=;
 b=aiTllPnIbDaA9hwX6e5WqJCptZRQERhC8lz9mQDG+dHX/V1uXxB9WyMtsY3rzeC5LA
 HY+mkwATC+ip1M2J6BvsRBEcloD+NIt0EkYodoX3/8iqdCTqk0GgSOiRXQqPD909RyC2
 QxstWlCrIWzAZJvyY8KpVx5YwBS08oW8Uscyyj0vuUdKSUbaZu8iLc1UEOc71s33MhXU
 Rezz5rwmcGi3HEISLOqDTACV/1YvEG2ckgYycZBIbVatfst+lQFxh98zSG19OfYJel6g
 y9/V7dpKQfqnchGjCbJaiHoZME3vZVYgbDH+pcT0AWgP2rB+S1mVWX+dtAOvv72C+ukL
 fmPw==
X-Gm-Message-State: AOJu0YzhfJn0hvreQq7TAG9yCsVHJ27FacQDL01Z5jlB86uHEIppliay
 8w6XqdF3jiyY7UgsDx/5j2RUqg==
X-Google-Smtp-Source: AGHT+IFcX1LLFmdNgHCNHwlK2ODHL3cK+XCbzkfi3elzg1To0kDsXyUUJCoW5n2efj1JupkbGiY+Bg==
X-Received: by 2002:a05:6000:1378:b0:32f:c369:6aff with SMTP id
 q24-20020a056000137800b0032fc3696affmr1003052wrz.28.1700121069127; 
 Wed, 15 Nov 2023 23:51:09 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 m4-20020a056000024400b0032fb0e2087asm12582889wrz.82.2023.11.15.23.51.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 23:51:08 -0800 (PST)
Message-ID: <55922c30-be4b-459d-835b-819e1dcd2437@linaro.org>
Date: Thu, 16 Nov 2023 08:51:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/31] cpu: Add generic cpu_list()
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 imp@bsdimp.com, kevans@freebsd.org, richard.henderson@linaro.org,
 pbonzini@redhat.com, peter.maydell@linaro.org, imammedo@redhat.com,
 b.galvani@gmail.com, strahinja.p.jankovic@gmail.com, sundeep.lkml@gmail.com,
 kfting@nuvoton.com, wuhaotsh@google.com, nieklinnenbank@gmail.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 laurent@vivier.eu, vijai@behindbytes.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, mrolnik@gmail.com,
 edgar.iglesias@gmail.com, bcain@quicinc.com, gaosong@loongson.cn,
 aurelien@aurel32.net, jiaxun.yang@flygoat.com, aleksandar.rikalo@syrmia.com,
 chenhuacai@kernel.org, shorne@gmail.com, npiggin@gmail.com, clg@kaod.org,
 ysato@users.sourceforge.jp, kbastian@mail.uni-paderborn.de,
 jcmvbkbc@gmail.com, shan.gavin@gmail.com
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-7-gshan@redhat.com>
 <80da2d00-0d96-4252-b2aa-f7859e44bece@linaro.org>
In-Reply-To: <80da2d00-0d96-4252-b2aa-f7859e44bece@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 16/11/23 08:39, Philippe Mathieu-Daudé wrote:
> Hi Gavin,
> 
> On 15/11/23 00:56, Gavin Shan wrote:
>> Add generic cpu_list() to replace the individual target's implementation
>> in the subsequent commits. Currently, there are 3 targets with no 
>> cpu_list()
>> implementation: microblaze and nios2. With this applied, those two 
>> targets
>> switch to the generic cpu_list().
>>
>> [gshan@gshan q]$ ./build/qemu-system-microblaze -cpu ?
>> Available CPUs:
>>    microblaze-cpu
>>
>> [gshan@gshan q]$ ./build/qemu-system-nios2 -cpu ?
>> Available CPUs:
>>    nios2-cpu
>>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   bsd-user/main.c |  5 +----
>>   cpu-target.c    | 29 ++++++++++++++++++++++++++---
>>   2 files changed, 27 insertions(+), 7 deletions(-)
> 
> 
>> diff --git a/cpu-target.c b/cpu-target.c
>> index c078c0e91b..acfc654b95 100644
>> --- a/cpu-target.c
>> +++ b/cpu-target.c
>> @@ -24,6 +24,7 @@
>>   #include "hw/qdev-core.h"
>>   #include "hw/qdev-properties.h"
>>   #include "qemu/error-report.h"
>> +#include "qemu/qemu-print.h"
>>   #include "migration/vmstate.h"
>>   #ifdef CONFIG_USER_ONLY
>>   #include "qemu.h"
>> @@ -283,12 +284,34 @@ const char *parse_cpu_option(const char 
>> *cpu_option)
>>       return cpu_type;
>>   }
>> +#ifndef cpu_list
>> +static void cpu_list_entry(gpointer data, gpointer user_data)
>> +{
>> +    CPUClass *cc = CPU_CLASS(OBJECT_CLASS(data));
>> +    const char *typename = object_class_get_name(OBJECT_CLASS(data));
>> +    g_autofree char *model = cpu_model_from_type(typename);
>> +
>> +    if (cc->deprecation_note) {
>> +        qemu_printf("  %s (deprecated)\n", model);
>> +    } else {
>> +        qemu_printf("  %s\n", model);
>> +    }
>> +}
>> +
>> +static void cpu_list(void)
>> +{
>> +    GSList *list;
>> +
>> +    list = object_class_get_list_sorted(TYPE_CPU, false);
>> +    qemu_printf("Available CPUs:\n");
> 
> Since this output will likely be displayed a lot, IMHO it is worth
> doing a first pass to get the number of available CPUs. If it is 1,
> print using singular but even better smth like:
> 
>         "This machine can only be used with the following CPU:"

Hmm I missed this code is common to user/system emulation.

System helper could be clever by using the intersection of cpu_list()
and MachineClass::valid_cpu_types[] sets.

> That said, this can be done later on top, so:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>> +    g_slist_foreach(list, cpu_list_entry, NULL);
>> +    g_slist_free(list);
>> +}
>> +#endif
> 
> 


