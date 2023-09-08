Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCBE798863
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 16:17:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qecHw-0006HH-Jn; Fri, 08 Sep 2023 10:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qecHu-0006H3-H6
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:16:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qecHr-00009F-Oj
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694182603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JaEZcDC/xzQarik4P2ToLwpvaE6AWW5umR+nGfyNTkk=;
 b=WPTTffTZB2qGos4MxEvumJq6LckTr5iGxyCExr85NRoXMC6cmoVu43Zc4+5gY+Bgbpoprj
 uin9aZzUMdSijZgPtkdBqKuHWAhwQcErEoFgTM3BZovHn7UGGK0RmzjUZhtX2sUiA5mV/6
 De1IPW9BMab0+RNUi2t5qhTNnPeCfHk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659--pRVytspOn-oMbgZvKZ1eg-1; Fri, 08 Sep 2023 10:16:37 -0400
X-MC-Unique: -pRVytspOn-oMbgZvKZ1eg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4020645b2a2so14340995e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 07:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694182596; x=1694787396;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JaEZcDC/xzQarik4P2ToLwpvaE6AWW5umR+nGfyNTkk=;
 b=xBcVJDQfgHkqIQNf2QOIOd+JEz2K7wxT9/JdD0qkzAdRj8oTreW/6JaDufolA5wL8E
 DzbwxXj4/Qd7Z+L+jfQYq5UsJ9VTLecvOBTGOXfADSY3jxfwG9aVxt0LJlLUueVoP6SD
 vsVfD7WswY5KH7VNb5f9rzBqx+4gvmBfL36US9iYQyJg4XG8PzXL/wYsqqpcUUsSs4Jx
 ydd9YCeQOulBqBxk357E4ILeeKC8YaARzMaw0JHydUEB8tnbp/eOGpIjcQUlSNh2HgV2
 zvXcA0EMf3F1UerDn9n+d6f+KB5gLSSeHxHJhksnyqbKoCa+4FHHTuzGI/ejkeXgaCJK
 9t/w==
X-Gm-Message-State: AOJu0YxNzHfMDfGRwoToeWJfH6ejDe6Xj//Xz5kTPE/52+mjofj2qHOk
 0Lrxv1lWHWPq88oG3Vmr2gzFISnb2Qf6kYOcAOdb6nbMuH18sqXfRYYR7Yn6+9gH6TYcCwfvBkA
 34xC5nTNs21VTytY=
X-Received: by 2002:a7b:c4d8:0:b0:401:5443:5591 with SMTP id
 g24-20020a7bc4d8000000b0040154435591mr2207258wmk.20.1694182595831; 
 Fri, 08 Sep 2023 07:16:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeYdALtfVYd5JfEpnPa8lCg9uK0dTSzi2PraGjEklnwDoAdlNOuIIDfxNzLQVGDKYw+6sO1A==
X-Received: by 2002:a7b:c4d8:0:b0:401:5443:5591 with SMTP id
 g24-20020a7bc4d8000000b0040154435591mr2207208wmk.20.1694182594797; 
 Fri, 08 Sep 2023 07:16:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c720:d00:61ea:eace:637c:3f0f?
 (p200300cbc7200d0061eaeace637c3f0f.dip0.t-ipconnect.de.
 [2003:cb:c720:d00:61ea:eace:637c:3f0f])
 by smtp.gmail.com with ESMTPSA id
 e12-20020a5d594c000000b0031ad5470f89sm2208854wri.18.2023.09.08.07.16.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 07:16:34 -0700 (PDT)
Message-ID: <730648ed-55ac-aa2c-58d2-d79224aeb586@redhat.com>
Date: Fri, 8 Sep 2023 16:16:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mem/x86: add processor address space check for VM memory
Content-Language: en-US
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
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <1911B17C-24F2-406B-9ED4-DCF98E794A09@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 08.09.23 16:12, Ani Sinha wrote:
> 
> 
>> On 08-Sep-2023, at 3:58 PM, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 08.09.23 11:50, Ani Sinha wrote:
>>> Depending on the number of available address bits of the current processor, a
>>> VM can only use a certain maximum amount of memory and no more. This change
>>> makes sure that a VM is not configured to have more memory than what it can use
>>> with the current processor settings when started. Additionally, the change adds
>>> checks during memory hotplug to ensure that the VM does not end up getting more
>>> memory than what it can actually use after hotplug.
>>> Currently, both the above checks are only for pc (x86) platform.
>>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1235403
>>> CC: imammedo@redhat.com
>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>> ---
>>>   hw/i386/pc.c           | 45 ++++++++++++++++++++++++++++++++++++++++++
>>>   hw/mem/memory-device.c |  6 ++++++
>>>   include/hw/boards.h    |  9 +++++++++
>>>   3 files changed, 60 insertions(+)
>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>> index 54838c0c41..f84e4c4916 100644
>>> --- a/hw/i386/pc.c
>>> +++ b/hw/i386/pc.c
>>> @@ -31,6 +31,7 @@
>>>   #include "hw/i386/topology.h"
>>>   #include "hw/i386/fw_cfg.h"
>>>   #include "hw/i386/vmport.h"
>>> +#include "hw/mem/memory-device.h"
>>>   #include "sysemu/cpus.h"
>>>   #include "hw/block/fdc.h"
>>>   #include "hw/ide/internal.h"
>>> @@ -1006,6 +1007,17 @@ void pc_memory_init(PCMachineState *pcms,
>>>           exit(EXIT_FAILURE);
>>>       }
>>>   +    /*
>>> +     * check if the VM started with more ram configured than max physical
>>> +     * address available with the current processor.
>>> +     */
>>> +    if (machine->ram_size > maxphysaddr + 1) {
>>> +        error_report("Address space limit 0x%"PRIx64" < 0x%"PRIx64
>>> +                     " (max configured memory), phys-bits too low (%u)",
>>> +                     maxphysaddr, machine->ram_size, cpu->phys_bits);
>>> +        exit(EXIT_FAILURE);
>>> +    }
>>
>> ... I know that this used to be a problem in the past, but nowadays we already do have similar checks in place?
>>
>> $ ./build/qemu-system-x86_64 -m 4T -machine q35,memory-backend=mem0 -object memory-backend-ram,id=mem0,size=4T,reserve=off
>> qemu-system-x86_64: Address space limit 0xffffffffff < 0x5077fffffff phys-bits too low (40)
> 
> So you are saying that this is OK and should be allowed? On a 32 bit processor that can access only 4G memory, I am spinning up a 10G VM.

Would that 32bit process have PAE (Physical Address Extension) and still 
be able to access that memory?

-- 
Cheers,

David / dhildenb


