Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9B9752E5E
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 02:53:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK72B-0007C0-JN; Thu, 13 Jul 2023 20:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qK729-0007BV-Tm
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 20:51:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qK728-0008CC-5E
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 20:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689295902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vk4ZZPMawWuVAv+zhZ14UFLC8eiGva5gnA3MiCwCLsg=;
 b=SkpE6mrTucnfhUvRsIL5qhO0CBeyHA5jk5r5HrXVKrP/ZkvJG4g1Rc+bM/YvmFpg1meO/a
 BSUwpmaogwxdpHrgJ9egDdSBCm7qAQvxG4vIxs70Fx31YDO87ebbbF28+rIebH7/aQYWIS
 fV3CrQKo4X13rKu1btIefj+ZJoVXXZY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-PRSrT0wjMtSZGrZ3urD2fg-1; Thu, 13 Jul 2023 20:51:40 -0400
X-MC-Unique: PRSrT0wjMtSZGrZ3urD2fg-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1b8bbe7a86eso5920685ad.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 17:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689295899; x=1691887899;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vk4ZZPMawWuVAv+zhZ14UFLC8eiGva5gnA3MiCwCLsg=;
 b=R+i2+zX8Bb/DA049pk1pRrnIUmBf1hNSwwaIfBtNNGmRchOHNtOiE3Zg7dZpkCOGre
 2rt/yY/YRnUtoBjcXESNIN6HE8aAuIfsJliXF71AifdIQIRQWi1PMiHkzMpDQM5aUZj8
 1GyZvz4Iok7mvmIpdh46fgGeeM1jf1duij1F+Gq6UB3vTz3sDj8ER1L/9+Qdfa3W19A8
 VBx9Tp1hgVGoBq6dNq6rLBcJcKri8uzuAqKjnCYCilWDp6GxM0+/GAz4+mSJdC9Fh22u
 Q8BWJxsrKZ4cbOLTSv2URcbTHCQqiFgqxaSYHiQ++25zw0/jkGV2QmBvwpbKN4tjtTeR
 kHAA==
X-Gm-Message-State: ABy/qLb3aQ3vonFY/mQgketrjOCMUDZvfvmYviYNpHeXvw0oVkPoEs8N
 uzb0b1BbxC+kcQiIzIHAnY+MhcpLo4tZSoJTW3CpQmnHUUDzt+/cq/YkGoNuFfxNyLMrObdCyOp
 ea6Ju/4LiYKk5QwM=
X-Received: by 2002:a17:903:32c4:b0:1b3:d4ed:8306 with SMTP id
 i4-20020a17090332c400b001b3d4ed8306mr3005080plr.19.1689295899424; 
 Thu, 13 Jul 2023 17:51:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFpcymaBlG9DV6ZThgV2d/pOAWiGadpfTo/k1/eFbdUxV2njrqwF2CPDFl87Lv2LtQRN440SQ==
X-Received: by 2002:a17:903:32c4:b0:1b3:d4ed:8306 with SMTP id
 i4-20020a17090332c400b001b3d4ed8306mr3005063plr.19.1689295899114; 
 Thu, 13 Jul 2023 17:51:39 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 l21-20020a170902d35500b001b9dab0397bsm6483625plk.29.2023.07.13.17.51.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 17:51:37 -0700 (PDT)
Message-ID: <ad1d9972-bb77-b7ad-4a89-2cb7019a79a7@redhat.com>
Date: Fri, 14 Jul 2023 10:51:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/3] hw/arm/virt: Use generic CPU invalidation
Content-Language: en-US
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
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <7ad244d7-2e29-74b4-e8bf-949925697880@linaro.org>
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

Hi Philippe,

On 7/14/23 02:29, Philippe Mathieu-Daudé wrote:
> On 13/7/23 14:34, Gavin Shan wrote:
>> On 7/13/23 21:52, Marcin Juszkiewicz wrote:
>>> W dniu 13.07.2023 o 13:44, Peter Maydell pisze:
>>>
>>>> I see this isn't a change in this patch, but given that
>>>> what the user specifies is not "cortex-a8-arm-cpu" but
>>>> "cortex-a8", why do we include the "-arm-cpu" suffix in
>>>> the error messages? It's not valid syntax to say
>>>> "-cpu cortex-a8-arm-cpu", so it's a bit misleading...
>>>
>>> Internally those cpu names are "max-{TYPE_ARM_CPU}" and similar for other architectures.
>>>
>>> I like the change but it (IMHO) needs to cut "-{TYPE_*_CPU}" string from names:
>>>
>>> 13:37 marcin@applejack:qemu$ ./build/aarch64-softmmu/qemu-system-aarch64 -M virt -cpu cortex-r5
>>> qemu-system-aarch64: Invalid CPU type: cortex-r5-arm-cpu
>>> The valid types are: cortex-a7-arm-cpu, cortex-a15-arm-cpu, cortex-a35-arm-cpu, cortex-a55-arm-cpu, cortex-a72-arm-cpu, cortex-a76-arm-cpu, a64fx-arm-cpu, neoverse-n1-arm-cpu, neoverse-v1-arm-cpu, cortex-a53-arm-cpu, cortex-a57-arm-cpu, host-arm-cpu, max-arm-cpu
>>>
>>> 13:37 marcin@applejack:qemu$ ./build/aarch64-softmmu/qemu-system-aarch64 -M virt -cpu cortex-a57-arm-cpu
>>> qemu-system-aarch64: unable to find CPU model 'cortex-a57-arm-cpu'
>>>
>>
>> The suffix of CPU types are provided in hw/arm/virt.c::valid_cpu_types in PATCH[2].
>> In the generic validation, the complete CPU type is used. The error message also
>> have complete CPU type there.
> 
> In some places (arm_cpu_list_entry, arm_cpu_add_definition) we use:
> 
>    g_strndup(typename, strlen(typename) - strlen("-" TYPE_ARM_CPU))
> 
> Maybe extract as a helper? cpu_typename_name()? :)
> 

Yeah, it's definitely a good idea. The helper is needed by all architectures,
not ARM alone. The following CPU types don't have explicit definition of
XXXX_CPU_TYPE_SUFFIX. We need take "-" TYPE_CPU as the suffix.

     target/microblaze/cpu.c  TYPE_MICROBLAZE_CPU
     target/hppa/cpu.c        TYPE_HPPA_CPU
     target/nios2/cpu.c       TYPE_NIOS2_CPU

     target/microblaze/cpu-qom.h:#define TYPE_MICROBLAZE_CPU "microblaze-cpu"
     target/hppa/cpu-qom.h:      #define TYPE_HPPA_CPU       "hppa-cpu"
     target/nios2/cpu.h:         #define TYPE_NIOS2_CPU      "nios2-cpu"

I think the function name can be cpu_model_name() since we have called it
as 'model' in cpu.c::parse_cpu_option(). Something like below. Please let
me know if you have more comments.

     target/xxxx/cpu.h
     -----------------

     static inline char *cpu_model_name(const char *typename)
     {
         return g_strndup(typename, strlen(typename) - strlen(TYPE_XXX_CPU_SUFFIX));
     }

Thanks,
Gavin

     





