Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4EC802E70
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 10:22:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA58y-0001JY-6P; Mon, 04 Dec 2023 04:21:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rA58v-0001JA-GT
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 04:21:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rA58t-0003if-NO
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 04:21:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701681690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tc75wqmwpTlOFyQiLAQ0bHBYISxk1tSqwpM808aphXc=;
 b=I/GDBAVgJXJo3dESI6bur8NZAXXEFOfwOgPn2exTbnhRscI79T40GvxDGRMC8VT3PpXXBl
 90EIqws8n5lk3QBCVXJ5Z+ixVm7GiVMXUTLSB4sW6G4doZ6sOBUzN404oYw06xZPX+/Ben
 3DBOE/EWipFIYIi/6oVihpKD75ei9fo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-d5IkX-g3O7ipd85bLJGe-g-1; Mon, 04 Dec 2023 04:21:27 -0500
X-MC-Unique: d5IkX-g3O7ipd85bLJGe-g-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4083717431eso30502745e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 01:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701681685; x=1702286485;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tc75wqmwpTlOFyQiLAQ0bHBYISxk1tSqwpM808aphXc=;
 b=wiq2u8I/9mzmIH/iJGcoei4FN0v6I9kL81PCWMuSIL3K5wKDmDGR+YvcpLrvcBCRhx
 iYJV29px4SCGXmScotRNMtx4uE5RIHmfhld/7IUedJFTc8hLa2dxWOOH98PzXwbYxOmp
 0zAcY2eGT1D1+s79tF3LOLZuD5wlb9KBi0C3/7rronMcqzep2VK54ukJGiltU2Cp2ARK
 boAUbD8CYhMdRsZ9vB3LXfbHP8rBg7GysZCw9pc3EtbhNRUT+92Oeca106BsrB4Iv+1P
 O1VVFy1xVgfUTz6o9HB9iGeZ3HgpYXkXmV1c+Va/NUkRJVfWIBXi9S5JUzjL6j2glTap
 NhHw==
X-Gm-Message-State: AOJu0Yxi/a25lXqg70YiiiMNP11eCoTy9a61piztJ4j+NmCoDZWUTyKl
 42b+ngYApfJP5hZKGXbxJlIAdQVD3pusWSdrae7wmXqReqFyvuAxAZmvZNXCrYAOxclKnM3xZdd
 ObWVQr3lcOZ05MXs=
X-Received: by 2002:a05:600c:4393:b0:40c:909:fdb4 with SMTP id
 e19-20020a05600c439300b0040c0909fdb4mr1147187wmn.90.1701681685640; 
 Mon, 04 Dec 2023 01:21:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEazfDLPWikCue2Jo7ekcZy1hCydwB6W1HMc1w6ETI8Lu7UVQXwoO6eV+8+jpdWv2h0Hj7wng==
X-Received: by 2002:a05:600c:4393:b0:40c:909:fdb4 with SMTP id
 e19-20020a05600c439300b0040c0909fdb4mr1147179wmn.90.1701681685142; 
 Mon, 04 Dec 2023 01:21:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c722:3700:6501:8925:6f9:fcdc?
 (p200300cbc72237006501892506f9fcdc.dip0.t-ipconnect.de.
 [2003:cb:c722:3700:6501:8925:6f9:fcdc])
 by smtp.gmail.com with ESMTPSA id
 r20-20020a05600c35d400b0040c05c768afsm7033321wmq.9.2023.12.04.01.21.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Dec 2023 01:21:24 -0800 (PST)
Message-ID: <0b6dacd2-a7c0-469f-830a-9162dfae75bf@redhat.com>
Date: Mon, 4 Dec 2023 10:21:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hostmem: Round up memory size for qemu_madvise() in
 host_memory_backend_memory_complete()
Content-Language: en-US
To: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>,
 qemu-devel@nongnu.org
Cc: imammedo@redhat.com
References: <f77d641d500324525ac036fe1827b3070de75fc1.1701088320.git.mprivozn@redhat.com>
 <9b8a2863-1264-4058-b367-0b61a75921ac@redhat.com>
 <b9c8b4da-cb14-4a67-b98d-655ed7348bef@redhat.com>
 <de569c7a-2e21-4a98-a4a9-98132b43c621@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <de569c7a-2e21-4a98-a4a9-98132b43c621@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 01.12.23 10:07, Michal Prívozník wrote:
> On 11/27/23 14:55, David Hildenbrand wrote:
>> On 27.11.23 14:37, David Hildenbrand wrote:
>>> On 27.11.23 13:32, Michal Privoznik wrote:
>>>> Simple reproducer:
>>>> qemu.git $ ./build/qemu-system-x86_64 \
>>>> -m size=8389632k,slots=16,maxmem=25600000k \
>>>> -object
>>>> '{"qom-type":"memory-backend-file","id":"ram-node0","mem-path":"/hugepages2M/","prealloc":true,"size":8590983168,"host-nodes":[0],"policy":"bind"}' \
>>>> -numa node,nodeid=0,cpus=0,memdev=ram-node0
>>>>
>>>> With current master I get:
>>>>
>>>> qemu-system-x86_64: cannot bind memory to host NUMA nodes: Invalid
>>>> argument
>>>>
>>>> The problem is that memory size (8193MiB) is not an integer
>>>> multiple of underlying pagesize (2MiB) which triggers a check
>>>> inside of madvise(), since we can't really set a madvise() policy
>>>> just to a fraction of a page.
>>>
>>> I thought we would just always fail create something that doesn't really
>>> make any sense.
>>>
>>> Why would we want to support that case?
>>>
>>> Let me dig, I thought we would have had some check there at some point
>>> that would make that fail (especially: RAM block not aligned to the
>>> pagesize).
>>
>>
>> At least memory-backend-memfd properly fails for that case:
>>
>> $ ./build/qemu-system-x86_64 -object
>> memory-backend-memfd,hugetlb=on,size=3m,id=tmp
>> qemu-system-x86_64: failed to resize memfd to 3145728: Invalid argument
>>
>> memory-backend-file ends up creating a new file:
>>
>>   $ ./build/qemu-system-x86_64 -object
>> memory-backend-file,share=on,mem-path=/dev/hugepages/tmp,size=3m,id=tmp
>>
>> $ stat /dev/hugepages/tmp
>>    File: /dev/hugepages/tmp
>>    Size: 4194304         Blocks: 0          IO Block: 2097152 regular file
>>
>> ... and ends up sizing it properly aligned to the huge page size.
>>
>>
>> Seems to be due to:
>>
>>      if (memory < block->page_size) {
>>          error_setg(errp, "memory size 0x" RAM_ADDR_FMT " must be equal to "
>>                     "or larger than page size 0x%zx",
>>                     memory, block->page_size);
>>          return NULL;
>>      }
>>
>>      memory = ROUND_UP(memory, block->page_size);
>>
>>      /*
>>       * ftruncate is not supported by hugetlbfs in older
>>       * hosts, so don't bother bailing out on errors.
>>       * If anything goes wrong with it under other filesystems,
>>       * mmap will fail.
>>       *
>>       * Do not truncate the non-empty backend file to avoid corrupting
>>       * the existing data in the file. Disabling shrinking is not
>>       * enough. For example, the current vNVDIMM implementation stores
>>       * the guest NVDIMM labels at the end of the backend file. If the
>>       * backend file is later extended, QEMU will not be able to find
>>       * those labels. Therefore, extending the non-empty backend file
>>       * is disabled as well.
>>       */
>>      if (truncate && ftruncate(fd, offset + memory)) {
>>          perror("ftruncate");
>>      }
>>
>> So we create a bigger file and map the bigger file and also have a
>> RAMBlock that is bigger. So we'll also consume more memory.
>>
>> ... but the memory region is smaller and we tell the VM that it has
>> less memory. Lot of work with no obvious benefit, and only some
>> memory waste :)
>>
>>
>> We better should have just rejected such memory backends right from
>> the start. But now it's likely too late.
>>
>> I suspect other things like
>>   * qemu_madvise(ptr, sz, QEMU_MADV_MERGEABLE);
>>   * qemu_madvise(ptr, sz, QEMU_MADV_DONTDUMP);
>>
>> fail, but we don't care for hugetlb at least regarding merging
>> and don't even log an error.
>>
>> But QEMU_MADV_DONTDUMP might also be broken, because that
>> qemu_madvise() call will just fail.
>>
>> Your fix would be correct. But I do wonder if we want to just let that
>> case fail and warn users that they are doing something that doesn't
>> make too much sense.
>>
> 
> Yeah, what's suspicious is: if the size is smaller than page size we
> error out, but if it's larger (but still not aligned) we accept that.
> I'm failing to see reasoning there. Looks like the ROUND_UP() was added
> in v0.13.0-rc0~1201^2~4 (though it's done with some bit magic) and the
> check itself was added in v2.8.0-rc0~30^2~23. So it's a bit late, yes.

Yeah.

> 
> OTOH - if users want to waste resources, should we stop them? For

It's all inconsistent, including memfd handling or what you noted above.

For example, Having a 1025 MiB guest on gigantic pages, consuming 2 GiB 
really is just absolutely stupid.

Likely the user wants to know about such mistakes instead of making QEMU 
silence all side effects of that. :)


> instance, when user requests more vCPUs than physical CPUs a warning is
> printed:
> 
> $ ./build/qemu-system-x86_64 -accel kvm -smp cpus=128
> qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested
> (128) exceeds the recommended cpus supported by KVM (8)

But that case is still reasonable for testing guest behavior with many 
vCPUs, or migrating from a machine with more vCPUs.

Here, the guest will actually see all vCPUs. In comparison, the memory 
waste here will never ever be consumable by the VM.

> 
> but that's about it. So maybe the error can be demoted to just a warning?

The question is what we want to do, for example, with the 
qemu_madvise(QEMU_MADV_DONTDUMP). It will similarly simply fail.

I'm curious, are there real customers running into that?


We could fix it all that but always warn when something like that is 
being done.

-- 
Cheers,

David / dhildenb


