Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D925B798A67
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 18:05:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qedyb-0000ak-E2; Fri, 08 Sep 2023 12:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qedyJ-0000XB-Fi
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 12:04:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qedyG-0001QF-S2
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 12:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694189074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tLGsPx2tqVC1Ih0eoKpLe9UXbrD9iLtJUCNNHBaLJrQ=;
 b=fEBk49aqfQS+TPu27U8TmFiDOSV10ysorJS0IMi5nIj1MekTCntPQKEkKzabdu3QKQbahf
 sAsp90JymjcB7tSxUxUyAaN1JqIHnzPf79E1GUdZ/MxrhWs76n55mMeP24rnNFUctDNVne
 I7M9MDuLN+mmioHB50dExfLdDjcUjTY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-hea3Zyt5OmGrGmiBasA8oQ-1; Fri, 08 Sep 2023 12:04:33 -0400
X-MC-Unique: hea3Zyt5OmGrGmiBasA8oQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31ad607d383so1404280f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 09:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694189072; x=1694793872;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tLGsPx2tqVC1Ih0eoKpLe9UXbrD9iLtJUCNNHBaLJrQ=;
 b=AuhIFlQauAvvoaCR55c4tEZjUxH0Tqyv3S57I7N1htbsgKG8QBbjhx/4wnHS5QTwuk
 8RIuntF7b1fiEyYZGvatiRfcar40U9FRJJJy0KWUqW9aOzNyi2EESSemXvxDSJo9/vX1
 ann2jUrntbckZ4wIDLJspKNjM1AvTe/Gh1hh2sIaJanaBJSy0g3VVVdHOXfdWxTsiJ6x
 2f/KXknpET811+fj0Vrxz3ApbfVqYJFkmD/jvVyAGJ/Cwit7mtZcfGlZxQvPF01a78DP
 vO6hfCI0B/M7F0/VwI7AOM5ABqrC2ybYc3ahCUVt5FrWuUSiCceQtOSsyb8LtDhNlQJl
 5vIg==
X-Gm-Message-State: AOJu0YxYVEc5m61O9u4/ru0Xh0KDzQoVr61LwYaqL5zxeTejDev8IWKj
 YBuF9QblItm7MZAhRKaqvf59HnqONUj5yriW5IG9g8MJWaKoJIfpjmNZZqy1clfNjsZlC1JLrzI
 TBdWfCeLR4jGeAqE=
X-Received: by 2002:a5d:4386:0:b0:315:ae39:27c with SMTP id
 i6-20020a5d4386000000b00315ae39027cmr1886994wrq.70.1694189071980; 
 Fri, 08 Sep 2023 09:04:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCw0wQ1vAwCknZ50+KFJsl78QLsq6sPMOD9vOUNsEgWDN7v5F6imZWVwVhaMQxmBbOgb8F/w==
X-Received: by 2002:a5d:4386:0:b0:315:ae39:27c with SMTP id
 i6-20020a5d4386000000b00315ae39027cmr1886974wrq.70.1694189071424; 
 Fri, 08 Sep 2023 09:04:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c720:d00:61ea:eace:637c:3f0f?
 (p200300cbc7200d0061eaeace637c3f0f.dip0.t-ipconnect.de.
 [2003:cb:c720:d00:61ea:eace:637c:3f0f])
 by smtp.gmail.com with ESMTPSA id
 g8-20020a5d4888000000b0031912c0ffebsm2431802wrq.23.2023.09.08.09.04.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 09:04:30 -0700 (PDT)
Message-ID: <219452f0-72b4-06bf-1b56-849e98efa384@redhat.com>
Date: Fri, 8 Sep 2023 18:04:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mem/x86: add processor address space check for VM memory
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel <qemu-devel@nongnu.org>
References: <20230908095024.270946-1-anisinha@redhat.com>
 <77284898-c540-31ac-d438-ebff52f6d75d@redhat.com>
 <1911B17C-24F2-406B-9ED4-DCF98E794A09@redhat.com>
 <730648ed-55ac-aa2c-58d2-d79224aeb586@redhat.com>
 <1574DF3A-7E1F-4C4F-9087-6E8DEE456906@redhat.com>
 <6cbca7b9-381b-6268-27f0-d7ea1c5ed1bd@redhat.com>
Organization: Red Hat
In-Reply-To: <6cbca7b9-381b-6268-27f0-d7ea1c5ed1bd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 08.09.23 18:02, David Hildenbrand wrote:
> On 08.09.23 17:13, Ani Sinha wrote:
>>
>>
>>> On 08-Sep-2023, at 7:46 PM, David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 08.09.23 16:12, Ani Sinha wrote:
>>>>> On 08-Sep-2023, at 3:58 PM, David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>> On 08.09.23 11:50, Ani Sinha wrote:
>>>>>> Depending on the number of available address bits of the current processor, a
>>>>>> VM can only use a certain maximum amount of memory and no more. This change
>>>>>> makes sure that a VM is not configured to have more memory than what it can use
>>>>>> with the current processor settings when started. Additionally, the change adds
>>>>>> checks during memory hotplug to ensure that the VM does not end up getting more
>>>>>> memory than what it can actually use after hotplug.
>>>>>> Currently, both the above checks are only for pc (x86) platform.
>>>>>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1235403
>>>>>> CC: imammedo@redhat.com
>>>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>>>> ---
>>>>>>    hw/i386/pc.c           | 45 ++++++++++++++++++++++++++++++++++++++++++
>>>>>>    hw/mem/memory-device.c |  6 ++++++
>>>>>>    include/hw/boards.h    |  9 +++++++++
>>>>>>    3 files changed, 60 insertions(+)
>>>>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>>>>> index 54838c0c41..f84e4c4916 100644
>>>>>> --- a/hw/i386/pc.c
>>>>>> +++ b/hw/i386/pc.c
>>>>>> @@ -31,6 +31,7 @@
>>>>>>    #include "hw/i386/topology.h"
>>>>>>    #include "hw/i386/fw_cfg.h"
>>>>>>    #include "hw/i386/vmport.h"
>>>>>> +#include "hw/mem/memory-device.h"
>>>>>>    #include "sysemu/cpus.h"
>>>>>>    #include "hw/block/fdc.h"
>>>>>>    #include "hw/ide/internal.h"
>>>>>> @@ -1006,6 +1007,17 @@ void pc_memory_init(PCMachineState *pcms,
>>>>>>            exit(EXIT_FAILURE);
>>>>>>        }
>>>>>>    +    /*
>>>>>> +     * check if the VM started with more ram configured than max physical
>>>>>> +     * address available with the current processor.
>>>>>> +     */
>>>>>> +    if (machine->ram_size > maxphysaddr + 1) {
>>>>>> +        error_report("Address space limit 0x%"PRIx64" < 0x%"PRIx64
>>>>>> +                     " (max configured memory), phys-bits too low (%u)",
>>>>>> +                     maxphysaddr, machine->ram_size, cpu->phys_bits);
>>>>>> +        exit(EXIT_FAILURE);
>>>>>> +    }
>>>>>
>>>>> ... I know that this used to be a problem in the past, but nowadays we already do have similar checks in place?
>>>>>
>>>>> $ ./build/qemu-system-x86_64 -m 4T -machine q35,memory-backend=mem0 -object memory-backend-ram,id=mem0,size=4T,reserve=off
>>>>> qemu-system-x86_64: Address space limit 0xffffffffff < 0x5077fffffff phys-bits too low (40)
>>>> So you are saying that this is OK and should be allowed? On a 32 bit processor that can access only 4G memory, I am spinning up a 10G VM.
>>>
>>> Would that 32bit process have PAE (Physical Address Extension) and still be able to access that memory?
>>
>>
>> You are sidestepping my point. Sure, we can improve the condition check by checking for PAE CPUID etc but that is not the issue I am trying too point out. What if the processor did not have PAE? Would we allow a VM to have memory size which the processor can’t access? There is no such check today it would seem.
>>
> 
> Indeed, because the implementation for 32bit in pc_max_used_gpa() is wrong.
> 
> Note that for 64bit it does the right thing, even with memory hotplug,
> because the PCI64 hole is placed above the memory device region.
> 
> So I think we should tackle that via pc_max_used_gpa().
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 54838c0c41..d187890675 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -908,9 +908,12 @@ static hwaddr pc_max_used_gpa(PCMachineState *pcms,
> uint64_t pci_hole64_size)
>    {
>        X86CPU *cpu = X86_CPU(first_cpu);
> 
> -    /* 32-bit systems don't have hole64 thus return max CPU address */
> -    if (cpu->phys_bits <= 32) {
> -        return ((hwaddr)1 << cpu->phys_bits) - 1;
> +    /*
> +     * 32-bit systems don't have hole64, but we might have a region for
> +     * memory hotplug.
> +     */
> +    if (!(cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM)) {
> +        return pc_pci_hole64_start() - 1;
>        }
> 
>        return pc_pci_hole64_start() + pci_hole64_size - 1;
> 
> 
> That implies:
> 
> ./build/qemu-system-x86_64 -cpu pentium -m size=4G -nodefaults -nographic
> qemu-system-x86_64: Address space limit 0xffffffff < 0x13fffffff
> phys-bits too low (32)
> 
> As we have memory over 4G (due to PCI hole), that would now correctly fail.
> 
> However, what works is:
> 
> ./build/qemu-system-x86_64 -cpu pentium -m size=3G -nodefaults -nographic
> 
> 
> Weirdly enough, when setting cpu->phys_bits, we take care of PSE36 and
> allow for 36bits in the address space.
> 
> 
> So what works:
> 
> ./build/qemu-system-x86_64 -cpu pentium,pse36=on -m size=32G -nodefaults
> -nographic
> 
> And what doesn't:
> 
>    ./build/qemu-system-x86_64 -cpu pentium,pse36=on -m size=64G
> -nodefaults -nographic -S
> qemu-system-x86_64: Address space limit 0xfffffffff < 0x103fffffff
> phys-bits too low (36)
> 
> 
> However, we don't seem to have such handling in place for PAE (do we
> have to extend that handling in x86_cpu_realizefn()?). Maybe pae should
> always imply pse36, not sure ...
> 

Reading trustworthy wikipedia:

"Physical Address Extension (PAE) is an alternative to PSE-36 which also 
allows 36-bit addressing."

So maybe we have to consider PAE as well.

-- 
Cheers,

David / dhildenb


