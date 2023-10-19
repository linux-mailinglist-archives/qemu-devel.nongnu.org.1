Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A4F7CF43B
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 11:44:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtPZJ-0006oj-D6; Thu, 19 Oct 2023 05:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qtPZG-0006ju-KJ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 05:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qtPZE-0008VN-9T
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 05:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697708627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wOkrDYMdLOyU9/KgQ/NJ12OE1s922NEmGkCXL92u2Qs=;
 b=FFC+Hlb6CrwDTJPPl//oFIJ8ka7hu4o33kOK1/tERiI38LMbq4pwIc6s2zZqS/lXQwIwtJ
 yX3kYM6mVQy4LbSd/a3z8yPI2EbvpljCdMbMr7ao3J7UrEVQ2VF80561PJXCpxqQLP+RpN
 /hD2CuajoYGs8+ZIyfhSuYqBlFzSf10=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-t2YrgqWhPemqurmPQdYSrQ-1; Thu, 19 Oct 2023 05:43:30 -0400
X-MC-Unique: t2YrgqWhPemqurmPQdYSrQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f5df65fa35so48282425e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 02:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697708609; x=1698313409;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wOkrDYMdLOyU9/KgQ/NJ12OE1s922NEmGkCXL92u2Qs=;
 b=WjrOX17iXgm4ZOLsRmTD+CKinxtjQxk5XG+v6DbItLT6vQJrd2YJ8IFL+wa9dLh9se
 i/vs6PCiH29J7YzqKB3rGk2tEp0IBd3WhvM8Oidr/ljJRUxQK2HoFi0Wk2HI72JvWjWC
 hjrtycSVkVJ8lloRenvbVYw3IGL+e3ekFRfkUmloUT1LXCOHB0VH90zDp1WyRld6knnW
 SMSNt0veg/EdFN7Da03lZzRapSntmio8EXPgLGOTI+3hA5TIq6ceHqDzIhApWFI9t2Ox
 uIhYZsjNWd3EboyebVHUTmwfP2AOzWRDyf/wAo/I9UYnCG+HzlDB+a/zSm0XNI5Ggfew
 i9Bg==
X-Gm-Message-State: AOJu0Yyxv5WeZ9AYXsr/OT+FItsBJ6Qbp1nzwCLK06ab7oj9W56kc6pB
 P0qaUWJHG855S15ExpdFPg/0IKcvEhG1Of0YPvnKEfKatBlMGL8fYRRW0TG2ICd1OSAzB0qeWbA
 c1o/bDnb9nmB+9yI=
X-Received: by 2002:a05:600c:4752:b0:401:bcd9:4871 with SMTP id
 w18-20020a05600c475200b00401bcd94871mr1468504wmo.21.1697708609240; 
 Thu, 19 Oct 2023 02:43:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFojKIJNfR0WIeNoViipshjEewGe/NPYGc3kyhOS4I9DVQwL9KmWDTOROiobe++NWgZa0652Q==
X-Received: by 2002:a05:600c:4752:b0:401:bcd9:4871 with SMTP id
 w18-20020a05600c475200b00401bcd94871mr1468485wmo.21.1697708608696; 
 Thu, 19 Oct 2023 02:43:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:500:6a06:17fc:810b:b054?
 (p200300cbc70b05006a0617fc810bb054.dip0.t-ipconnect.de.
 [2003:cb:c70b:500:6a06:17fc:810b:b054])
 by smtp.gmail.com with ESMTPSA id
 h19-20020a05600c315300b004064741f855sm3941125wmo.47.2023.10.19.02.43.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 02:43:28 -0700 (PDT)
Message-ID: <5a40b152-115b-4dfd-9821-876d340148e2@redhat.com>
Date: Thu, 19 Oct 2023 11:43:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] softmmu/physmem: Warn with
 ram_block_discard_range() on MAP_PRIVATE file mapping
Content-Language: en-US
To: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peng Tao <tao.peng@linux.alibaba.com>, Mario Casquero <mcasquer@redhat.com>
References: <20230706075612.67404-1-david@redhat.com>
 <20230706075612.67404-2-david@redhat.com>
 <a23ee3d1-e03b-4442-bdec-341b3e52d3e0@intel.com>
 <e96e96a2-e996-4507-8548-684aa1e56846@redhat.com>
 <23d209c1-f860-4915-935e-816d9077b65c@intel.com>
 <ab0d4962-1e38-4758-bd3c-88c8754b433f@redhat.com>
 <a3aca8df-1b4a-4efe-9f79-107aa2fd1a39@intel.com>
 <0e436056-95c3-4ed6-a17e-a46a780e5ab9@redhat.com>
 <f958c479-d861-4579-b683-112c5de7b51f@intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f958c479-d861-4579-b683-112c5de7b51f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 19.10.23 11:26, Xiaoyao Li wrote:
> On 10/19/2023 4:26 PM, David Hildenbrand wrote:
>> On 18.10.23 18:27, Xiaoyao Li wrote:
>>> On 10/18/2023 5:26 PM, David Hildenbrand wrote:
>>>> On 18.10.23 11:02, Xiaoyao Li wrote:
>>>>> On 10/18/2023 3:42 PM, David Hildenbrand wrote:
>>>>>> On 18.10.23 05:02, Xiaoyao Li wrote:
>>>>>>> David,
>>>>>>>
>>>>>>> On 7/6/2023 3:56 PM, David Hildenbrand wrote:
>>>>>>>> ram_block_discard_range() cannot possibly do the right thing in
>>>>>>>> MAP_PRIVATE file mappings in the general case.
>>>>>>>>
>>>>>>>> To achieve the documented semantics, we also have to punch a hole
>>>>>>>> into
>>>>>>>> the file, possibly messing with other MAP_PRIVATE/MAP_SHARED
>>>>>>>> mappings
>>>>>>>> of such a file.
>>>>>>>>
>>>>>>>> For example, using VM templating -- see commit b17fbbe55cba
>>>>>>>> ("migration:
>>>>>>>> allow private destination ram with x-ignore-shared") -- in
>>>>>>>> combination with
>>>>>>>> any mechanism that relies on discarding of RAM is problematic. This
>>>>>>>> includes:
>>>>>>>> * Postcopy live migration
>>>>>>>> * virtio-balloon inflation/deflation or free-page-reporting
>>>>>>>> * virtio-mem
>>>>>>>>
>>>>>>>> So at least warn that there is something possibly dangerous is
>>>>>>>> going on
>>>>>>>> when using ram_block_discard_range() in these cases.
>>>>>>>>
>>>>>>>> Acked-by: Peter Xu <peterx@redhat.com>
>>>>>>>> Tested-by: Mario Casquero <mcasquer@redhat.com>
>>>>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>>>>> ---
>>>>>>>>       softmmu/physmem.c | 18 ++++++++++++++++++
>>>>>>>>       1 file changed, 18 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
>>>>>>>> index bda475a719..4ee157bda4 100644
>>>>>>>> --- a/softmmu/physmem.c
>>>>>>>> +++ b/softmmu/physmem.c
>>>>>>>> @@ -3456,6 +3456,24 @@ int ram_block_discard_range(RAMBlock *rb,
>>>>>>>> uint64_t start, size_t length)
>>>>>>>>                    * so a userfault will trigger.
>>>>>>>>                    */
>>>>>>>>       #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
>>>>>>>> +            /*
>>>>>>>> +             * We'll discard data from the actual file, even though
>>>>>>>> we only
>>>>>>>> +             * have a MAP_PRIVATE mapping, possibly messing with
>>>>>>>> other
>>>>>>>> +             * MAP_PRIVATE/MAP_SHARED mappings. There is no easy
>>>>>>>> way to
>>>>>>>> +             * change that behavior whithout violating the promised
>>>>>>>> +             * semantics of ram_block_discard_range().
>>>>>>>> +             *
>>>>>>>> +             * Only warn, because it work as long as nobody else
>>>>>>>> uses that
>>>>>>>> +             * file.
>>>>>>>> +             */
>>>>>>>> +            if (!qemu_ram_is_shared(rb)) {
>>>>>>>> +                warn_report_once("ram_block_discard_range:
>>>>>>>> Discarding RAM"
>>>>>>>> +                                 " in private file mappings is
>>>>>>>> possibly"
>>>>>>>> +                                 " dangerous, because it will
>>>>>>>> modify
>>>>>>>> the"
>>>>>>>> +                                 " underlying file and will affect
>>>>>>>> other"
>>>>>>>> +                                 " users of the file");
>>>>>>>> +            }
>>>>>>>> +
>>>>>>>
>>>>>>> TDX has two types of memory backend for each RAM, shared memory and
>>>>>>> private memory. Private memory is serviced by guest memfd and shared
>>>>>>> memory can also be backed with a fd.
>>>>>>>
>>>>>>> At any time, only one type needs to be valid, which means the
>>>>>>> opposite
>>>>>>> can be discarded. We do implement the memory discard when TDX
>>>>>>> converts
>>>>>>> the memory[1]. It will trigger this warning 100% because by
>>>>>>> default the
>>>>>>> guest memfd is not mapped as shared (MAP_SHARED).
>>>>>>
>>>>>> If MAP_PRIVATE is not involved and you are taking the pages
>>>>>> directly out
>>>>>> of the memfd, you should mark that thing as shared.
>>>>>
>>>>> Is it the general rule of Linux? Of just the rule of QEMU memory
>>>>> discard?
>>>>>
>>>>
>>>> MAP_SHARED vs. MAP_PRIVATE is a common UNIX principle, and that's what
>>>> this flag and the check is about.
>>>>
>>>>    From mmap(2)
>>>>
>>>> MAP_SHARED: Share this mapping.  Updates to the mapping are visible to
>>>> other processes mapping the same region, and (in the case of file-backed
>>>> mappings) are carried through to the underlying file.
>>>>
>>>> MAP_PRIVATE: Create a private copy-on-write mapping.  Updates to the
>>>> mapping are not visible to other processes mapping the same file, and
>>>> are not carried through to the underlying file.  It is unspecified
>>>> whether changes made  to the file after the mmap() call are visible in
>>>> the mapped region.
>>>>
>>>> For your purpose (no mmap() at all), we behave like MAP_SHARED -- as if
>>>> nothing special is done. No Copy-on-write, no anonymous memory.
>>>>
>>>>>> Anonymous memory is never involved.
>>>>>
>>>>> Could you please elaborate more on this? What do you want to express
>>>>> here regrading anonymous memory? (Sorry that I'm newbie for mmap stuff)
>>>>
>>>> Anonymous memory is memory that is private to a specific process, and
>>>> (see MAP_PRIVATE) modifications remain private to the process and are
>>>> not reflected to the file.
>>>>
>>>> If you have a MAP_PRIVATE file mapping and write to a virtual memory
>>>> location, you'll get a process-private copy of the underlying pagecache
>>>> page. that's what we call anonymous memory, because it does not belong
>>>> to a specific file. fallocate(punch) would not free up that anonymous
>>>> memory.
>>>
>>> For guest memfd, it does implement kvm_gmem_fallocate as .fallocate()
>>> callback, which calls truncate_inode_pages_range() [*].
>>>
>>> I'm not sure if it frees up the memory. I need to learn it.
>>>
>>> [*]
>>> https://github.com/kvm-x86/linux/blob/911b515af3ec5f53992b9cc162cf7d3893c2fbe2/virt/kvm/guest_memfd.c#L147C73-L147C73
>>>
>>>>>
>>>>>>
>>>>>> "Private memory" is only private from the guest POV, not from a mmap()
>>>>>> point of view.
>>>>>>
>>>>>> Two different concepts of "private".
>>>>>>
>>>>>>>
>>>>>>> Simply remove the warning will fail the purpose of this patch. The
>>>>>>> other
>>>>>>> option is to skip the warning for TDX case, which looks vary
>>>>>>> hacky. Do
>>>>>>> you have any idea?
>>>>>>
>>>>>> For TDX, all memory backends / RAMBlocks should be marked as "shared",
>>>>>> and you should fail if that is not provided by the user.
>>>>>
>>>>> As I asked above, I want to understand the logic clearly. Is mapped as
>>>>> shared is a must to support the memory discard? i.e., if we want to
>>>>> support memory discard after memory type change, then the memory
>>>>> must be
>>>>> mapped with MAP_SHARED?
>>>>
>>>> MAP_PIRVATE means that it's not sufficient to only fallocate(punch) the
>>>> fd to free up all memory for a virtual address, because there might be
>>>> anonymous memory in a private mapping that has to be freed up using
>>>> MADV_DONTNEED.
>>>
>>> I can understand this. But it seems unrelated to my question: Is mapped
>>> as shared is a must to support the memory discard?
>>
>> Sorry, I don't quite get what you are asking that I haven't answered
>> yet. Let's talk about the issue you are seeing below.
>>
>>>
>>> e.g., if use below parameters to specify the RAM for a VM
>>>
>>>      -object memory-backend-memfd,id=mem0,size=2G    \
>>>      -machine memory-backend=mem0
>>>
>>> since not specifying "share" property, the ram_block doesn't have
>>> RAM_SHARED set. If want to discard some range of this memfd, it triggers
>>> the warning. Is this warning expected?
>>
>> That should not be the case. See "memfd_backend_instance_init" where we
>> set share=true. In memfd_backend_memory_alloc(), we set RAM_SHARED.
>>
>> We only default to share=off for memory-backend-file (well, and
>> memory-backend-ram).
>>
>> So are you sure you get this error message in the configuration you are
>> describing here?
> 
> Sorry, I made an mistake. I was using "-object
> memory-backend-ram,id=mem0,size=2G" instead of "memory-backend-memfd".
> 
> yes, when using "memory-backend-memfd" as the backend for TDX shared
> memory, it doesn't trigger the warning because
> memfd_backend_instance_init() set "share" to true.
> 
> When using "memory-backend-ram" as the backend for TDX shared memory,
> the warning is triggered converting memory from private (kvm gmem) to
> shared (backend-ram). In this case, there is a valid fd (kvm gmem fd),
> so it goes to the path of need_fallocate. However,
> qemu_ram_is_shared(rb) returns false because "memory-backend-ram"
> doesn't have "share" default on. Thus, the warning is triggered.
> 
> It seems I need figure out a more proper solution to refactor the
> ram_block_discard_range(), to make it applicable for kvm gmem discard case.

You should probably completely ignore any ramblock flags when 
fallocate(punch) the kvm_gmem_fd. kvm_gmem_fd is a rather special 
"secondary storage that's never mapped", independent of the ordinary 
RAMBlock memory.

-- 
Cheers,

David / dhildenb


