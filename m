Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BBD803627
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 15:14:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA9gh-000501-PA; Mon, 04 Dec 2023 09:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1rA9gf-0004zr-TT
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:12:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1rA9gc-0005rI-6X
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:12:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701699157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HJvppl0bnHuGXwMnHNYv8qakLAHXl1pv+rHU9YgacsA=;
 b=QzqcSOCho4ZWVin1JlU6z6rVBc/sooXjpPerg8N/PUaK1+/bbLZRQ+WX1y8UraaO2PwvMx
 MppFCR8f0AcmIBZWfCLvmmFSFqDIhatxCpCy2hzFdGsIWLh6eBP87YKiaSohpVKDFmRKiW
 iH2Vr7XVtJgdHAlQBSfGs5nSkIyCXac=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-2ZL0wHaOMnqfgzN1LSlTrg-1; Mon, 04 Dec 2023 09:12:35 -0500
X-MC-Unique: 2ZL0wHaOMnqfgzN1LSlTrg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-547bb01fec2so3520690a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 06:12:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701699154; x=1702303954;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HJvppl0bnHuGXwMnHNYv8qakLAHXl1pv+rHU9YgacsA=;
 b=wGsgiiLqdfk6kfFUW1R9J/GpKEYQ4gnrOJFZ3MP+6uOgmfpJLcaMudMicSqpJ3m6Ev
 7ys1ta90yC5LIp6vTgRlKUQ2lsB/mDxqOHqWG/YKkOe7YMaUtsBdneSlLGQezd3AMJ4D
 bepBIcAzrD08jwwuMzD/YQIMSld1cMOq5zFgJcvowG83PmWFROEwkejjZZfr+f9Y4gnx
 ucd5EUJrDhjdU9RDvAHPGMQC4O7tJSM3rHr9n2tz7t+CXg05C25XVCGF+b9pbB4KeHj+
 f8gIA4L2PUAs4QJ58rtJoe+dNnxeoPyZjIcSzpCJcaAaO9qJGWADE9VKOcKd3AAz6AVL
 Gcww==
X-Gm-Message-State: AOJu0YwL7c794oheQawnE+0+H+ItftFDqNYtRVc+1tJa1iyimFQ3wd54
 FdTZT7XstM3Rr/Vh8V6soB+hG3IJzb9pVwkMnv7lQywRzHWQdkbK3jn00A9VNfYYKaSYe7xcBnK
 eiYVCR2J4h8/xy2U=
X-Received: by 2002:aa7:c911:0:b0:54c:c68e:95a7 with SMTP id
 b17-20020aa7c911000000b0054cc68e95a7mr612591edt.52.1701699154379; 
 Mon, 04 Dec 2023 06:12:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXS+40ULlw5o4zVwS+jmxYechxhc74FiL7R76SS/YdTu9Y5fSQ4VrjIzJUn/oOuDD0XQU+IQ==
X-Received: by 2002:aa7:c911:0:b0:54c:c68e:95a7 with SMTP id
 b17-20020aa7c911000000b0054cc68e95a7mr612584edt.52.1701699153977; 
 Mon, 04 Dec 2023 06:12:33 -0800 (PST)
Received: from [10.43.3.102] (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 b19-20020a50ccd3000000b0054c49f1f207sm4224382edj.39.2023.12.04.06.12.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Dec 2023 06:12:33 -0800 (PST)
Message-ID: <7e70c5d4-8c18-4861-8aca-497ba940c839@redhat.com>
Date: Mon, 4 Dec 2023 15:12:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hostmem: Round up memory size for qemu_madvise() in
 host_memory_backend_memory_complete()
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com
References: <f77d641d500324525ac036fe1827b3070de75fc1.1701088320.git.mprivozn@redhat.com>
 <9b8a2863-1264-4058-b367-0b61a75921ac@redhat.com>
 <b9c8b4da-cb14-4a67-b98d-655ed7348bef@redhat.com>
 <de569c7a-2e21-4a98-a4a9-98132b43c621@redhat.com>
 <0b6dacd2-a7c0-469f-830a-9162dfae75bf@redhat.com>
Content-Language: en-US
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
In-Reply-To: <0b6dacd2-a7c0-469f-830a-9162dfae75bf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 12/4/23 10:21, David Hildenbrand wrote:
> On 01.12.23 10:07, Michal Prívozník wrote:
>> On 11/27/23 14:55, David Hildenbrand wrote:
>>> On 27.11.23 14:37, David Hildenbrand wrote:
>>>> On 27.11.23 13:32, Michal Privoznik wrote:
>>>>> Simple reproducer:
>>>>> qemu.git $ ./build/qemu-system-x86_64 \
>>>>> -m size=8389632k,slots=16,maxmem=25600000k \
>>>>> -object
>>>>> '{"qom-type":"memory-backend-file","id":"ram-node0","mem-path":"/hugepages2M/","prealloc":true,"size":8590983168,"host-nodes":[0],"policy":"bind"}' \
>>>>> -numa node,nodeid=0,cpus=0,memdev=ram-node0
>>>>>
>>>>> With current master I get:
>>>>>
>>>>> qemu-system-x86_64: cannot bind memory to host NUMA nodes: Invalid
>>>>> argument
>>>>>
>>>>> The problem is that memory size (8193MiB) is not an integer
>>>>> multiple of underlying pagesize (2MiB) which triggers a check
>>>>> inside of madvise(), since we can't really set a madvise() policy
>>>>> just to a fraction of a page.
>>>>
>>>> I thought we would just always fail create something that doesn't
>>>> really
>>>> make any sense.
>>>>
>>>> Why would we want to support that case?
>>>>
>>>> Let me dig, I thought we would have had some check there at some point
>>>> that would make that fail (especially: RAM block not aligned to the
>>>> pagesize).
>>>
>>>
>>> At least memory-backend-memfd properly fails for that case:
>>>
>>> $ ./build/qemu-system-x86_64 -object
>>> memory-backend-memfd,hugetlb=on,size=3m,id=tmp
>>> qemu-system-x86_64: failed to resize memfd to 3145728: Invalid argument
>>>
>>> memory-backend-file ends up creating a new file:
>>>
>>>   $ ./build/qemu-system-x86_64 -object
>>> memory-backend-file,share=on,mem-path=/dev/hugepages/tmp,size=3m,id=tmp
>>>
>>> $ stat /dev/hugepages/tmp
>>>    File: /dev/hugepages/tmp
>>>    Size: 4194304         Blocks: 0          IO Block: 2097152 regular
>>> file
>>>
>>> ... and ends up sizing it properly aligned to the huge page size.
>>>
>>>
>>> Seems to be due to:
>>>
>>>      if (memory < block->page_size) {
>>>          error_setg(errp, "memory size 0x" RAM_ADDR_FMT " must be
>>> equal to "
>>>                     "or larger than page size 0x%zx",
>>>                     memory, block->page_size);
>>>          return NULL;
>>>      }
>>>
>>>      memory = ROUND_UP(memory, block->page_size);
>>>
>>>      /*
>>>       * ftruncate is not supported by hugetlbfs in older
>>>       * hosts, so don't bother bailing out on errors.
>>>       * If anything goes wrong with it under other filesystems,
>>>       * mmap will fail.
>>>       *
>>>       * Do not truncate the non-empty backend file to avoid corrupting
>>>       * the existing data in the file. Disabling shrinking is not
>>>       * enough. For example, the current vNVDIMM implementation stores
>>>       * the guest NVDIMM labels at the end of the backend file. If the
>>>       * backend file is later extended, QEMU will not be able to find
>>>       * those labels. Therefore, extending the non-empty backend file
>>>       * is disabled as well.
>>>       */
>>>      if (truncate && ftruncate(fd, offset + memory)) {
>>>          perror("ftruncate");
>>>      }
>>>
>>> So we create a bigger file and map the bigger file and also have a
>>> RAMBlock that is bigger. So we'll also consume more memory.
>>>
>>> ... but the memory region is smaller and we tell the VM that it has
>>> less memory. Lot of work with no obvious benefit, and only some
>>> memory waste :)
>>>
>>>
>>> We better should have just rejected such memory backends right from
>>> the start. But now it's likely too late.
>>>
>>> I suspect other things like
>>>   * qemu_madvise(ptr, sz, QEMU_MADV_MERGEABLE);
>>>   * qemu_madvise(ptr, sz, QEMU_MADV_DONTDUMP);
>>>
>>> fail, but we don't care for hugetlb at least regarding merging
>>> and don't even log an error.
>>>
>>> But QEMU_MADV_DONTDUMP might also be broken, because that
>>> qemu_madvise() call will just fail.
>>>
>>> Your fix would be correct. But I do wonder if we want to just let that
>>> case fail and warn users that they are doing something that doesn't
>>> make too much sense.
>>>
>>
>> Yeah, what's suspicious is: if the size is smaller than page size we
>> error out, but if it's larger (but still not aligned) we accept that.
>> I'm failing to see reasoning there. Looks like the ROUND_UP() was added
>> in v0.13.0-rc0~1201^2~4 (though it's done with some bit magic) and the
>> check itself was added in v2.8.0-rc0~30^2~23. So it's a bit late, yes.
> 
> Yeah.
> 
>>
>> OTOH - if users want to waste resources, should we stop them? For
> 
> It's all inconsistent, including memfd handling or what you noted above.
> 
> For example, Having a 1025 MiB guest on gigantic pages, consuming 2 GiB
> really is just absolutely stupid.
> 
> Likely the user wants to know about such mistakes instead of making QEMU
> silence all side effects of that. :)

Agreed. As I said, consistency should win here.

> 
> 
>> instance, when user requests more vCPUs than physical CPUs a warning is
>> printed:
>>
>> $ ./build/qemu-system-x86_64 -accel kvm -smp cpus=128
>> qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested
>> (128) exceeds the recommended cpus supported by KVM (8)
> 
> But that case is still reasonable for testing guest behavior with many
> vCPUs, or migrating from a machine with more vCPUs.
> 
> Here, the guest will actually see all vCPUs. In comparison, the memory
> waste here will never ever be consumable by the VM.

Good point.

> 
>>
>> but that's about it. So maybe the error can be demoted to just a warning?
> 
> The question is what we want to do, for example, with the
> qemu_madvise(QEMU_MADV_DONTDUMP). It will similarly simply fail.

It will. But the retval of qemu_madvise() is not checked here, and in
qemu_ram_setup_dump() it's just a warning.

> 
> I'm curious, are there real customers running into that?
> 
>

No, I haven't seen any bugreport from a customer, just our QE ran into
this issue: https://issues.redhat.com/browse/RHEL-1127 (I've asked to
make this issue public).


> We could fix it all that but always warn when something like that is
> being done.
> 

Fair enough. After all of this, I'm inclined to turn this into a proper
error and deny not page aligned sizes. There's no real benefit in having
them and furthermore, the original bug report is about cryptic error
message.

Michal


