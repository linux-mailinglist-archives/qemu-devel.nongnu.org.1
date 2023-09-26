Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DAA7AEC88
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 14:24:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql76O-00023h-IH; Tue, 26 Sep 2023 08:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1ql76M-00023V-MD
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 08:23:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1ql76K-0003mV-N1
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 08:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695731019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hoG3MMHZi/a80/K9G8nUQ/u0Ezp6YYIdlkGbLd2RDf4=;
 b=CqXdorP1t42yRieXIEmLtRCnIJbPtZ7kJC4+HvlFethiofhEd4uZocGPixUBEY8sZqrSnV
 Cn8qYBzbGbJRydK3u5YSZIluZjU8B1LRGn7do2z3b6HqQmInFdpjS3hMnmmq4A/lyLhnmq
 hs+Rpha00XvqxXrHQP10drc9D1xQDE0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-7jxeLjTVPGCbDOPTFCbhkg-1; Tue, 26 Sep 2023 08:23:37 -0400
X-MC-Unique: 7jxeLjTVPGCbDOPTFCbhkg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5041bea78a5so12544115e87.3
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 05:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695731016; x=1696335816;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hoG3MMHZi/a80/K9G8nUQ/u0Ezp6YYIdlkGbLd2RDf4=;
 b=jm4DVg+q65UOlwHLXeFiJlT2OJkADaW3VP0EAaDCTz98DO1KmSN5zWLBm+UGROTIZM
 r0P2f82OvDfGx0kB1HSVR1JD+PZUEnJk+ENyzM0CCyeVrC1AjEB8yHnQgQliH8ZIA/Z8
 zUsYcHR22svJhskND2Wx9AhM+sgb2nqk4/12dcOdktOEqVydcyldOY+a8EHEgaz+ubTH
 42yLsIFRhqODr+W/DVV6yOPfJUC05lUgG4V07AkGveJ+suaLaOAxcygNLStiRlYOxWDo
 1bJhp1+OONnaSTEwHL30PPKjhUu7QW+b7yxdCqe20KmZx85VCUxazZw5LyZklCTvkaW2
 dGRw==
X-Gm-Message-State: AOJu0YyhafWqiuMrK2nrFCjuRdWYPNbmJQsGt/dA7MzQo7jvw+hrdKQo
 JTshRPE3iTxhM/GsJU4kKxEQSOfpHDGZNDV2Wv6HgAcYVKV6P3rP5ai69GOXWnd97gZifYquaJa
 cqBByrmxVr4tmJpo=
X-Received: by 2002:ac2:5593:0:b0:503:186b:e0a8 with SMTP id
 v19-20020ac25593000000b00503186be0a8mr7017330lfg.60.1695731015947; 
 Tue, 26 Sep 2023 05:23:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ15e2yZG6ukTlCuiOlRii6bBEhe63iKSB/cVPYUkkzE7AhTqLiT41YL0tNPnbet4XxpM88Q==
X-Received: by 2002:ac2:5593:0:b0:503:186b:e0a8 with SMTP id
 v19-20020ac25593000000b00503186be0a8mr7017308lfg.60.1695731015380; 
 Tue, 26 Sep 2023 05:23:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:600:933b:ca69:5a80:230d?
 (p200300cbc73f0600933bca695a80230d.dip0.t-ipconnect.de.
 [2003:cb:c73f:600:933b:ca69:5a80:230d])
 by smtp.gmail.com with ESMTPSA id
 f11-20020a056402160b00b005231e3d89efsm6805040edv.31.2023.09.26.05.23.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 05:23:34 -0700 (PDT)
Message-ID: <40647bc5-6a2e-0b59-3605-0de8d4639f66@redhat.com>
Date: Tue, 26 Sep 2023 14:23:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 04/10] Introduce the CPU address space destruction
 function
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, lixianglai
 <lixianglai@loongson.cn>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Salil Mehta <salil.mehta@opnsrc.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Bibo Mao <maobibo@loongson.cn>
References: <cover.1694433326.git.lixianglai@loongson.cn>
 <3a4fc2a3df4b767c3c296a7da3bc15ca9c251316.1694433326.git.lixianglai@loongson.cn>
 <43f04ba4-3e16-ea5c-a212-66dda73a76c4@redhat.com>
 <20eb8316-22a2-c812-7172-6bd9016877cc@loongson.cn>
 <dd2b9190-c748-0ae2-b9de-8842e6e758e2@redhat.com>
 <7e0e1639-d821-fecb-b647-4a18afa600cc@loongson.cn>
 <e4e88068-4754-f7d4-e080-b7b8d5bcf006@loongson.cn>
 <5f610a1d-da1b-0094-41e7-f69164c4d0e0@redhat.com>
 <7906109a36c5467fa9b529520671fa77@huawei.com>
 <b8f256b3549e41a09119dee5ab5439d9@huawei.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <b8f256b3549e41a09119dee5ab5439d9@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 26.09.23 13:55, Salil Mehta wrote:
>> From: Salil Mehta
>> Sent: Tuesday, September 26, 2023 12:21 PM
>> To: 'David Hildenbrand' <david@redhat.com>; lixianglai
>> <lixianglai@loongson.cn>; qemu-devel@nongnu.org
>> Cc: Salil Mehta <salil.mehta@opnsrc.net>; Xiaojuan Yang
>> <yangxiaojuan@loongson.cn>; Song Gao <gaosong@loongson.cn>; Michael S.
>> Tsirkin <mst@redhat.com>; Igor Mammedov <imammedo@redhat.com>; Ani Sinha
>> <anisinha@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>; Richard
>> Henderson <richard.henderson@linaro.org>; Eduardo Habkost
>> <eduardo@habkost.net>; Marcel Apfelbaum <marcel.apfelbaum@gmail.com>;
>> Philippe Mathieu-Daudé <philmd@linaro.org>; wangyanan (Y)
>> <wangyanan55@huawei.com>; Daniel P. Berrangé <berrange@redhat.com>; Peter
>> Xu <peterx@redhat.com>; Bibo Mao <maobibo@loongson.cn>
>> Subject: RE: [PATCH v2 04/10] Introduce the CPU address space destruction
>> function
>>
>> Hi David,
>>
>>> From: David Hildenbrand <david@redhat.com>
>>> Sent: Friday, September 15, 2023 9:07 AM
>>> To: lixianglai <lixianglai@loongson.cn>; qemu-devel@nongnu.org; Salil
>> Mehta
>>> <salil.mehta@huawei.com>
>>> Cc: Salil Mehta <salil.mehta@opnsrc.net>; Xiaojuan Yang
>>> <yangxiaojuan@loongson.cn>; Song Gao <gaosong@loongson.cn>; Michael S.
>>> Tsirkin <mst@redhat.com>; Igor Mammedov <imammedo@redhat.com>; Ani Sinha
>>> <anisinha@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>; Richard
>>> Henderson <richard.henderson@linaro.org>; Eduardo Habkost
>>> <eduardo@habkost.net>; Marcel Apfelbaum <marcel.apfelbaum@gmail.com>;
>>> Philippe Mathieu-Daudé <philmd@linaro.org>; wangyanan (Y)
>>> <wangyanan55@huawei.com>; Daniel P. Berrangé <berrange@redhat.com>; Peter
>>> Xu <peterx@redhat.com>; Bibo Mao <maobibo@loongson.cn>
>>> Subject: Re: [PATCH v2 04/10] Introduce the CPU address space destruction
>>> function
>>>
>>> On 15.09.23 04:53, lixianglai wrote:
>>>> Hi David Hildenbrand:
>>>>
>>>>>
>>>>> Hi David Hildenbrand:
>>>>>> On 14.09.23 15:00, lixianglai wrote:
>>>>>>> Hi David:
>>>>>>
>>>>>> Hi!
>>>>>>
>>>>>>>
>>>>>>>> On 12.09.23 04:11, xianglai li wrote:
>>>>>>>>> Introduce new function to destroy CPU address space resources
>>>>>>>>> for cpu hot-(un)plug.
>>>>>>>>>
>>>>>>>> How do other archs handle that? Or how are they able to get away
>>>>>>>> without destroying?
>>>>>>>>
>>>>>>> They do not remove the cpu address space, taking the X86
>>>>>>> architecture as
>>>>>>> an example:
>>>>>>>
>>>>>>> 1.Start the x86 VM:
>>>>>>>
>>>>>>> ./qemu-system-x86_64 \
>>>>>>> -machine q35  \
>>>>>>> -cpu Broadwell-IBRS \
>>>>>>> -smp 1,maxcpus=100,sockets=100,cores=1,threads=1 \
>>>>>>> -m 4G \
>>>>>>> -drive file=~/anolis-8.8.qcow2  \
>>>>>>> -serial stdio   \
>>>>>>> -monitor telnet:localhost:4498,server,nowait   \
>>>>>>> -nographic
>>>>>>>
>>>>>>> 2.Connect the qemu monitor
>>>>>>>
>>>>>>> telnet 127.0.0.1 4498
>>>>>>>
>>>>>>> info mtree
>>>>>>>
>>>>>>> address-space: cpu-memory-0
>>>>>>> address-space: memory
>>>>>>>       0000000000000000-ffffffffffffffff (prio 0, i/o): system
>>>>>>>         0000000000000000-000000007fffffff (prio 0, ram): alias
>>>>>>> ram-below-4g
>>>>>>> @pc.ram 0000000000000000-000000007fffffff
>>>>>>>         0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>>>>>>>           00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
>>>>>>>
>>>>>>> 3.Perform cpu hot swap int qemu monitor
>>>>>>>
>>>>>>> device_add
>>>>>>> Broadwell-IBRS-x86_64-cpu,socket-id=1,core-id=0,thread-id=0,id=cpu1
>>>>>>> device_del cpu1
>>>>>>>
>>>>>>
>>>>>> Hm, doesn't seem to work for me on upstream QEMU for some reason:
>>>>>> "Error: acpi: device unplug request for not supported device type:
>>>>>> Broadwell-IBRS-x86_64-cpu"
>>>>>
>>>> First I use qemu tcg, and then the cpu needs to be removed after the
>>>> operating system is booted.
>>>
>>> Ah, the last thing is the important bit. I can reproduce this with KVM
>>> easily.
>>>
>>> Doing it a couple of times
>>>
>>> address-space: cpu-memory-0
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>>
>>> Looks like a resource/memory leak.
>>
>> Yes, there was. Thanks for identifying it. I have fixed in the
>> latest RFC V2. Please check here:
>>
>> https://lore.kernel.org/qemu-devel/20230926100436.28284-1-
>> salil.mehta@huawei.com/T/#m5f5ae40b091d69d01012880d7500d96874a9d39c
>>
>> I have tested and AddressSpace comes and goes away cleanly
>> on CPU hot(un)plug action.
> 
> Hi David/Xianglai,
> Are you okay if I put Reported-by and give reference to this
> conversation?

Yes. And ideally, send the fixes separately from the other arm patches.

-- 
Cheers,

David / dhildenb


