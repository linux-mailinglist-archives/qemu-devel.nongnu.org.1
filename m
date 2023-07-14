Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F187575363A
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 11:15:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKEt9-0004QD-Vw; Fri, 14 Jul 2023 05:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qKEt7-0004Pt-PD
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 05:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qKEt6-0006Jj-0L
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 05:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689326095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qnt9ufqh6riFsdVqRulJG/YnXNw9BjWSxyPU6ryKX/w=;
 b=Je3z/XIhphXSzn5b5wnpl4AyNu27Jk9FQ1zHbAGinvudFhNT1vxYY/HE1ya5CtrfC2AwNi
 C5cCYnOljkM/1VtLWWUVEVdAXJFt0zv52DS+at5DduC49VmNQo5UZRT6VlpfOIsR0E5c9o
 GCqUEwMeqSCDjN0A6h2ag63jRFJZlKM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-qVDibTDBOF2olgeuMD3xew-1; Fri, 14 Jul 2023 05:14:53 -0400
X-MC-Unique: qVDibTDBOF2olgeuMD3xew-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-55c79a5565aso807691a12.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 02:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689326092; x=1691918092;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qnt9ufqh6riFsdVqRulJG/YnXNw9BjWSxyPU6ryKX/w=;
 b=j+qQgMRJ348ecSgYXNJP303Ftx7PPVrIO9F05RJjSSuiy2pweWRkmopztYmsqVgKRF
 MuZifm73aDu/zdlojXg3LKMbJAwn8TRxe1h2J8xnfcZDeXRVE1Ry2RvjNcMTBCf7tRaO
 4+xVGdkVE4SOlremT+FTLKS3j3GSjewNhOd83q6k6NoJkXm+Qp13fzVqszIxRYjjKOn6
 Uzaq5iv0TsYRQVPEFULZWTABKLmyWl7rDzt7WZDPGE1M8HXCQ5RuHGVYVdF8+7NMnWTl
 k8Q/TQ8pUEBMysa+1xpOL/1ptr5xCqP2B3PELCAn4Ow/THroXaHNOjGpz5aVxk1GHZSd
 Rryg==
X-Gm-Message-State: ABy/qLZD/ByyFNs0LtjBCbWv1Ms6W6LNyB2raQFE851sLXeItHDR77xH
 T4X/oSr5NHfQOxhYxryduyGG0aidOGt3I0v7ugMb+lDjZsSFXQfOgJARMM8XkNcSx+3wg0leINA
 I2uejVVV5C5sVJ1Y=
X-Received: by 2002:a17:902:b487:b0:1b0:307c:e6fe with SMTP id
 y7-20020a170902b48700b001b0307ce6femr2926135plr.10.1689326092354; 
 Fri, 14 Jul 2023 02:14:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGwqS59zclolxR0ctJ3abpgQL/gVsdnNfC/HOXL7u3sp1TVD46xdQkqkwI5Hnxgb+xn6vxZ+Q==
X-Received: by 2002:a17:902:b487:b0:1b0:307c:e6fe with SMTP id
 y7-20020a170902b48700b001b0307ce6femr2926115plr.10.1689326091919; 
 Fri, 14 Jul 2023 02:14:51 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 y21-20020a1709027c9500b001b8a3729c23sm7311224pll.17.2023.07.14.02.14.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jul 2023 02:14:51 -0700 (PDT)
Message-ID: <1401a16b-ea85-19cb-c30b-37d645f2dab5@redhat.com>
Date: Fri, 14 Jul 2023 19:14:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/3] hw/arm/virt: Use generic CPU invalidation
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 shan.gavin@gmail.com
References: <20230713054502.410911-1-gshan@redhat.com>
 <CAFEAcA8197FCwfNZrnxfO-87RveOko0Ju-KcTJOEi0vfjVtDKg@mail.gmail.com>
 <2d21e89f-c965-e8f1-3705-dfea8367fc7e@linaro.org>
 <3a392615-5aca-f384-197f-84beb3086a29@redhat.com>
 <7ad244d7-2e29-74b4-e8bf-949925697880@linaro.org>
 <ad1d9972-bb77-b7ad-4a89-2cb7019a79a7@redhat.com>
In-Reply-To: <ad1d9972-bb77-b7ad-4a89-2cb7019a79a7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/14/23 10:51, Gavin Shan wrote:
> On 7/14/23 02:29, Philippe Mathieu-Daudé wrote:
>> On 13/7/23 14:34, Gavin Shan wrote:
>>> On 7/13/23 21:52, Marcin Juszkiewicz wrote:
>>>> W dniu 13.07.2023 o 13:44, Peter Maydell pisze:
>>>>
>>>>> I see this isn't a change in this patch, but given that
>>>>> what the user specifies is not "cortex-a8-arm-cpu" but
>>>>> "cortex-a8", why do we include the "-arm-cpu" suffix in
>>>>> the error messages? It's not valid syntax to say
>>>>> "-cpu cortex-a8-arm-cpu", so it's a bit misleading...
>>>>
>>>> Internally those cpu names are "max-{TYPE_ARM_CPU}" and similar for other architectures.
>>>>
>>>> I like the change but it (IMHO) needs to cut "-{TYPE_*_CPU}" string from names:
>>>>
>>>> 13:37 marcin@applejack:qemu$ ./build/aarch64-softmmu/qemu-system-aarch64 -M virt -cpu cortex-r5
>>>> qemu-system-aarch64: Invalid CPU type: cortex-r5-arm-cpu
>>>> The valid types are: cortex-a7-arm-cpu, cortex-a15-arm-cpu, cortex-a35-arm-cpu, cortex-a55-arm-cpu, cortex-a72-arm-cpu, cortex-a76-arm-cpu, a64fx-arm-cpu, neoverse-n1-arm-cpu, neoverse-v1-arm-cpu, cortex-a53-arm-cpu, cortex-a57-arm-cpu, host-arm-cpu, max-arm-cpu
>>>>
>>>> 13:37 marcin@applejack:qemu$ ./build/aarch64-softmmu/qemu-system-aarch64 -M virt -cpu cortex-a57-arm-cpu
>>>> qemu-system-aarch64: unable to find CPU model 'cortex-a57-arm-cpu'
>>>>
>>>
>>> The suffix of CPU types are provided in hw/arm/virt.c::valid_cpu_types in PATCH[2].
>>> In the generic validation, the complete CPU type is used. The error message also
>>> have complete CPU type there.
>>
>> In some places (arm_cpu_list_entry, arm_cpu_add_definition) we use:
>>
>>    g_strndup(typename, strlen(typename) - strlen("-" TYPE_ARM_CPU))
>>
>> Maybe extract as a helper? cpu_typename_name()? :)
>>
> 
> Yeah, it's definitely a good idea. The helper is needed by all architectures,
> not ARM alone. The following CPU types don't have explicit definition of
> XXXX_CPU_TYPE_SUFFIX. We need take "-" TYPE_CPU as the suffix.
> 
>      target/microblaze/cpu.c  TYPE_MICROBLAZE_CPU
>      target/hppa/cpu.c        TYPE_HPPA_CPU
>      target/nios2/cpu.c       TYPE_NIOS2_CPU
> 
>      target/microblaze/cpu-qom.h:#define TYPE_MICROBLAZE_CPU "microblaze-cpu"
>      target/hppa/cpu-qom.h:      #define TYPE_HPPA_CPU       "hppa-cpu"
>      target/nios2/cpu.h:         #define TYPE_NIOS2_CPU      "nios2-cpu"
> 
> I think the function name can be cpu_model_name() since we have called it
> as 'model' in cpu.c::parse_cpu_option(). Something like below. Please let
> me know if you have more comments.
> 
>      target/xxxx/cpu.h
>      -----------------
> 
>      static inline char *cpu_model_name(const char *typename)
>      {
>          return g_strndup(typename, strlen(typename) - strlen(TYPE_XXX_CPU_SUFFIX));
>      }
> 

I found the generic CPU type invalidation in hw/core/machine.c can't see functions
from target/xxx/, including cpu_model_name(). In order to call this function from
hw/core/machine.c, we need transit in cpu.c

     include/exec/cpu-common.h
     -------------------------
     char *cpu_get_model_name(const char *name);
     void list_cpus(void);
     
     cpu.c
     -----
     char *cpu_get_model_name(const char *name)
     {
        return cpu_model_name(name);
     }

With above hunk of changes, cpu_get_model_name() can be called in hw/core/machine.c,
to extract the CPU model name from the CPU type name.

Thanks,
Gavin


