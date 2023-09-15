Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1727A1801
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 10:07:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh3rJ-0006rr-3X; Fri, 15 Sep 2023 04:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qh3rG-0006rZ-Gl
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 04:07:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qh3rE-0006bA-Oo
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 04:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694765239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SWK8rtS3AZ2OVkc8yfQLqd5kazOPmksh/2wCvhn9Ns8=;
 b=fnrEq1vtNXCwLUbdAYDt2dEtH5gB3KkIAe4ZB7UEh+zhL6Dv+yd3LGczvOvgbbktSdO9f3
 4gN4oO06IdMc0U8aQQC2m3L1vMfVkgxyy6K0aYbN6dogZA3OlDzzPBzjDT5riIrHWQnSwJ
 6ORQ+1Tju9bdMNq59Yb5cZKQuMRGt+k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-6lEFHVNwPpyZJ9zkZbaTag-1; Fri, 15 Sep 2023 04:07:17 -0400
X-MC-Unique: 6lEFHVNwPpyZJ9zkZbaTag-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-402ff13f749so14310385e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 01:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694765236; x=1695370036;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :content-language:references:cc:to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SWK8rtS3AZ2OVkc8yfQLqd5kazOPmksh/2wCvhn9Ns8=;
 b=Mm8tXp5VQkQJMYNn0H3WYILQhTOwSqINW+M0hQQpV7uOkade7ZxNA5GVXoFE/+xiRn
 glzdNTX7OESrIjabdmK5DqhvQRP2t2GYT5Tm8DcKM2/qgDRURrWltz9XYpCFKPpJVde7
 VzsKIQwwI2sAIz6qWa/QUfwf6FVQ999IylPFZcam31kK+7s55ODlO4fXVf5GIHYlPyUp
 LXGqtx3suxve/QplpwJOD0M2WsZvbq89iVIoehFz1tDj+bR2OgBoftJmzUB5/ft9sHzw
 OK+fHurdxpkCSm5lCk6x6pjjWAGkgFC4wrf+RTLWcPQP0zFY+ABoWjCf03Ij7WELC9Hx
 YWmw==
X-Gm-Message-State: AOJu0YyWxCiOiNfhxfSMcI6xwp3wQJH613VG901XZZ1fR6V2weX7lbcg
 CV/u+ExG3itU49olj0Gu0nYCn/kk1YFZgvVACsclZUllQBYkU08Hcy+3QUaMG4rVvLwrZSYRVIT
 p8fLPaQrK+8fJkyc=
X-Received: by 2002:a7b:cd1a:0:b0:3fe:d630:f568 with SMTP id
 f26-20020a7bcd1a000000b003fed630f568mr766053wmj.39.1694765236484; 
 Fri, 15 Sep 2023 01:07:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZIiWJvti85xWHP7GUVQ9hZfrIvcXcgkB+lw85P4Rng4RK72xsixu+hI4htN46gXW2Z88yFQ==
X-Received: by 2002:a7b:cd1a:0:b0:3fe:d630:f568 with SMTP id
 f26-20020a7bcd1a000000b003fed630f568mr766023wmj.39.1694765236033; 
 Fri, 15 Sep 2023 01:07:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c728:e000:a4bd:1c35:a64e:5c70?
 (p200300cbc728e000a4bd1c35a64e5c70.dip0.t-ipconnect.de.
 [2003:cb:c728:e000:a4bd:1c35:a64e:5c70])
 by smtp.gmail.com with ESMTPSA id
 9-20020a05600c228900b003fff96bb62csm3924453wmf.16.2023.09.15.01.07.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 01:07:15 -0700 (PDT)
Message-ID: <5f610a1d-da1b-0094-41e7-f69164c4d0e0@redhat.com>
Date: Fri, 15 Sep 2023 10:07:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: lixianglai <lixianglai@loongson.cn>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Salil Mehta <salil.mehta@huawei.com>
Cc: Salil Mehta <salil.mehta@opnsrc.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>
References: <cover.1694433326.git.lixianglai@loongson.cn>
 <3a4fc2a3df4b767c3c296a7da3bc15ca9c251316.1694433326.git.lixianglai@loongson.cn>
 <43f04ba4-3e16-ea5c-a212-66dda73a76c4@redhat.com>
 <20eb8316-22a2-c812-7172-6bd9016877cc@loongson.cn>
 <dd2b9190-c748-0ae2-b9de-8842e6e758e2@redhat.com>
 <7e0e1639-d821-fecb-b647-4a18afa600cc@loongson.cn>
 <e4e88068-4754-f7d4-e080-b7b8d5bcf006@loongson.cn>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 04/10] Introduce the CPU address space destruction
 function
In-Reply-To: <e4e88068-4754-f7d4-e080-b7b8d5bcf006@loongson.cn>
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

On 15.09.23 04:53, lixianglai wrote:
> Hi David Hildenbrand:
> 
>>
>> Hi David Hildenbrand:
>>> On 14.09.23 15:00, lixianglai wrote:
>>>> Hi David:
>>>
>>> Hi!
>>>
>>>>
>>>>> On 12.09.23 04:11, xianglai li wrote:
>>>>>> Introduce new function to destroy CPU address space resources
>>>>>> for cpu hot-(un)plug.
>>>>>>
>>>>> How do other archs handle that? Or how are they able to get away
>>>>> without destroying?
>>>>>
>>>> They do not remove the cpu address space, taking the X86
>>>> architecture as
>>>> an example:
>>>>
>>>> 1.Start the x86 VM:
>>>>
>>>> ./qemu-system-x86_64 \
>>>> -machine q35  \
>>>> -cpu Broadwell-IBRS \
>>>> -smp 1,maxcpus=100,sockets=100,cores=1,threads=1 \
>>>> -m 4G \
>>>> -drive file=~/anolis-8.8.qcow2  \
>>>> -serial stdio   \
>>>> -monitor telnet:localhost:4498,server,nowait   \
>>>> -nographic
>>>>
>>>> 2.Connect the qemu monitor
>>>>
>>>> telnet 127.0.0.1 4498
>>>>
>>>> info mtree
>>>>
>>>> address-space: cpu-memory-0
>>>> address-space: memory
>>>>      0000000000000000-ffffffffffffffff (prio 0, i/o): system
>>>>        0000000000000000-000000007fffffff (prio 0, ram): alias
>>>> ram-below-4g
>>>> @pc.ram 0000000000000000-000000007fffffff
>>>>        0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>>>>          00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
>>>>
>>>> 3.Perform cpu hot swap int qemu monitor
>>>>
>>>> device_add
>>>> Broadwell-IBRS-x86_64-cpu,socket-id=1,core-id=0,thread-id=0,id=cpu1
>>>> device_del cpu1
>>>>
>>>
>>> Hm, doesn't seem to work for me on upstream QEMU for some reason:
>>> "Error: acpi: device unplug request for not supported device type:
>>> Broadwell-IBRS-x86_64-cpu"
>>
> First I use qemu tcg, and then the cpu needs to be removed after the
> operating system is booted.

Ah, the last thing is the important bit. I can reproduce this with KVM 
easily.

Doing it a couple of times

address-space: cpu-memory-0
address-space: cpu-memory-1
address-space: cpu-memory-1
address-space: cpu-memory-1
address-space: cpu-memory-1
address-space: cpu-memory-1
address-space: cpu-memory-1
address-space: cpu-memory-1
address-space: cpu-memory-1
address-space: cpu-memory-1
address-space: cpu-memory-1
address-space: cpu-memory-1
address-space: cpu-memory-1
address-space: cpu-memory-1
address-space: cpu-memory-1
address-space: cpu-memory-1
address-space: cpu-memory-1
address-space: cpu-memory-1
address-space: cpu-memory-1
address-space: cpu-memory-1

Looks like a resource/memory leak.

[...]

>> I think it can also be done in the public code flow. Since I refer to
>> arm's scheme
>>
>> (https://lore.kernel.org/all/20200613213629.21984-1-salil.mehta@huawei.com/),
>>
>>
>> and arm's patch will be issued soon, I will conduct rebase based on
>> arm patch in the future.
>>
>> Therefore, I would like to see if arm has any good suggestions. If
>> there are no good suggestions at this stage,
>>
>> I think we can shelve this problem for the first time, and I can
>> consider not referencing this function for the first time,
>>
>> and we can submit another patch to solve this problem.
>>
>> Hi Salil Mehta:
>>
>> Is the cpu_address_space_destroy function still present in the new
>> patch version of arm?
>>
>> Can we put this function on the public path of cpu destroy?

Looks like this has to be fixed for all archs that support VCPU unplug.

The CPU implementation end up call qemu_init_vcpu() in their realize 
function; there should be something like qemu_destroy_vcpu() on the 
unrealize path that takes care of undoing any cpu_address_space_init().

We seem to have cpu_common_unrealizefn()->cpu_exec_unrealizefn() but 
that doesn't take care of address spaces.

Also, in qemu_init_vcpu() we do a cpus_accel->create_vcpu_thread(cpu). 
I'm, curious if we destroy that thread somehow.

-- 
Cheers,

David / dhildenb


