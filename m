Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF81798A66
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 18:05:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qedyi-0000g7-VN; Fri, 08 Sep 2023 12:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qedyN-0000av-RW
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 12:04:45 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qedyL-0001QQ-4A
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 12:04:43 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-500b66f8b27so3825316e87.3
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 09:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694189079; x=1694793879; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lPtRKORGWwv1JHBP/r4D3Up/HvNSSXSQOJJFM9vkBhE=;
 b=UEArE9nhSlmBJW2uZ205L22L9DgdTABENbWNW43JMGbS195QsccastKiUV6G2mchKk
 +nmxx6iTY/J6R0BpCcEB6N74yyYmbEXelJ8YqBDS5A82RuMq0Onqy4AmtZG1qEAzgI9x
 qPu9ETUTLOaAYoOoR7VSLDX/vw0FSyODK4Weu6aburoLSmMc0KeN9+o1EiC2fvAFnV43
 yM7X/SLPkPAl/GlhrJ3dHENKJf/M95N2wrfUe8k3VtbqHhEUp7Gmk8iYAF8t4hLdbxcW
 xvYhd1YHJa2oRmdfvgESt7oH5hMM6OE+Bosj4dNQH0r6u8LlTAv2b5lyP3j/ew7g1pqN
 hv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694189079; x=1694793879;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lPtRKORGWwv1JHBP/r4D3Up/HvNSSXSQOJJFM9vkBhE=;
 b=vZY6QWD5IrgIkVoi2YlGdE5ghtfXHA/XaT4Kj559VQQoT1yiL/D2MKzMmN1TNCFiik
 Gm6h8dQhdhw3YImYy/eziE2LStZbfmkZ807m18NHdP6XQyi4cPy5C471UJSrVbMJxp13
 /tLUC3Z4oIWr+plUPswqlsueCKGbNLnEqSaFjWXZfyjioUldv1pE7aelTGBe5PTolo1v
 96YLjkSlnQsJppG5DHDaXVMb1UWIzgstXibd6hi1g0LbIfK0UxQ6HZ8ssAwFsS1VpN/m
 gvwi9bDC1TmzUux95mpFpWw5iKRevj8PYwsFOgA0sItCfmlSolBnNM83GJmAe5mF3AlO
 TqEA==
X-Gm-Message-State: AOJu0YwOTHzttaNiEiZnls9EbsHiqArvO9657QZIY32DP2usk/TpxvRx
 DOQhEfSAN7hraaoXTx3E6Xutwg==
X-Google-Smtp-Source: AGHT+IE07MzEstJqUCAZHOIqaUrUzfOhLDtnHcOd7OsdIaZ65gW40aBTfcbYAdcLjPvu97A9gfZASg==
X-Received: by 2002:ac2:5e8a:0:b0:500:9f03:9157 with SMTP id
 b10-20020ac25e8a000000b005009f039157mr2230586lfq.65.1694189078897; 
 Fri, 08 Sep 2023 09:04:38 -0700 (PDT)
Received: from [192.168.69.115]
 (lfb24-h01-176-173-167-175.dsl.sta.abo.bbox.fr. [176.173.167.175])
 by smtp.gmail.com with ESMTPSA id
 m16-20020aa7c490000000b005236410a16bsm1212442edq.35.2023.09.08.09.04.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 09:04:38 -0700 (PDT)
Message-ID: <cef1a2f6-47d0-7fc5-5ca6-303930684f67@linaro.org>
Date: Fri, 8 Sep 2023 18:04:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] mem/x86: add processor address space check for VM memory
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel <qemu-devel@nongnu.org>
References: <20230908095024.270946-1-anisinha@redhat.com>
 <77284898-c540-31ac-d438-ebff52f6d75d@redhat.com>
 <1911B17C-24F2-406B-9ED4-DCF98E794A09@redhat.com>
 <730648ed-55ac-aa2c-58d2-d79224aeb586@redhat.com>
 <1574DF3A-7E1F-4C4F-9087-6E8DEE456906@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <1574DF3A-7E1F-4C4F-9087-6E8DEE456906@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

On 8/9/23 17:13, Ani Sinha wrote:
> 
> 
>> On 08-Sep-2023, at 7:46 PM, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 08.09.23 16:12, Ani Sinha wrote:
>>>> On 08-Sep-2023, at 3:58 PM, David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 08.09.23 11:50, Ani Sinha wrote:
>>>>> Depending on the number of available address bits of the current processor, a
>>>>> VM can only use a certain maximum amount of memory and no more. This change
>>>>> makes sure that a VM is not configured to have more memory than what it can use
>>>>> with the current processor settings when started. Additionally, the change adds
>>>>> checks during memory hotplug to ensure that the VM does not end up getting more
>>>>> memory than what it can actually use after hotplug.
>>>>> Currently, both the above checks are only for pc (x86) platform.
>>>>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1235403
>>>>> CC: imammedo@redhat.com
>>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>>> ---
>>>>>   hw/i386/pc.c           | 45 ++++++++++++++++++++++++++++++++++++++++++
>>>>>   hw/mem/memory-device.c |  6 ++++++
>>>>>   include/hw/boards.h    |  9 +++++++++
>>>>>   3 files changed, 60 insertions(+)
>>>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>>>> index 54838c0c41..f84e4c4916 100644
>>>>> --- a/hw/i386/pc.c
>>>>> +++ b/hw/i386/pc.c
>>>>> @@ -31,6 +31,7 @@
>>>>>   #include "hw/i386/topology.h"
>>>>>   #include "hw/i386/fw_cfg.h"
>>>>>   #include "hw/i386/vmport.h"
>>>>> +#include "hw/mem/memory-device.h"
>>>>>   #include "sysemu/cpus.h"
>>>>>   #include "hw/block/fdc.h"
>>>>>   #include "hw/ide/internal.h"
>>>>> @@ -1006,6 +1007,17 @@ void pc_memory_init(PCMachineState *pcms,
>>>>>           exit(EXIT_FAILURE);
>>>>>       }
>>>>>   +    /*
>>>>> +     * check if the VM started with more ram configured than max physical
>>>>> +     * address available with the current processor.
>>>>> +     */
>>>>> +    if (machine->ram_size > maxphysaddr + 1) {
>>>>> +        error_report("Address space limit 0x%"PRIx64" < 0x%"PRIx64
>>>>> +                     " (max configured memory), phys-bits too low (%u)",
>>>>> +                     maxphysaddr, machine->ram_size, cpu->phys_bits);
>>>>> +        exit(EXIT_FAILURE);
>>>>> +    }
>>>>
>>>> ... I know that this used to be a problem in the past, but nowadays we already do have similar checks in place?
>>>>
>>>> $ ./build/qemu-system-x86_64 -m 4T -machine q35,memory-backend=mem0 -object memory-backend-ram,id=mem0,size=4T,reserve=off
>>>> qemu-system-x86_64: Address space limit 0xffffffffff < 0x5077fffffff phys-bits too low (40)
>>> So you are saying that this is OK and should be allowed? On a 32 bit processor that can access only 4G memory, I am spinning up a 10G VM.
>>
>> Would that 32bit process have PAE (Physical Address Extension) and still be able to access that memory?
> 
> 
> You are sidestepping my point. Sure, we can improve the condition check by checking for PAE CPUID etc but that is not the issue I am trying too point out. What if the processor did not have PAE? Would we allow a VM to have memory size which the processor can’t access? There is no such check today it would seem.

Which processor, the host or the guest?

Even if the guest CPU can't access all the VM memory, this memory can be
used by devices without interaction with the CPU (see i.e. PCI).

