Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0587CE2C0
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:28:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt9OK-0004ix-P1; Wed, 18 Oct 2023 12:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qt9O9-0004hO-Ed
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:27:17 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qt9O5-0005ny-Er
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697646433; x=1729182433;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=b4kEMoajX+fy+gDiLuH8EYMyslKZDVMZ/zxmUc7zPSY=;
 b=IF/9N49C2gm1kTQj5f/okYRQZZY78ViOQeisyMlmPG5evBBiGNwTdsxu
 TJ5YTq5TpEVw8crWIACDJD9O3VLndWZYcz4oIC2ueHRs4OJR79aIkKawK
 rO7HzuB3qz58twNZp5wfi3yiT8kihOGzl8buHvWnZKAGAvvLTKdnnpmwR
 pO8h+1am4qpZHYP1pzEQo6HGVb+oEEDOiqdulpIDq0+Qt5SQtHmx+A7bL
 ds9IGQAA3EQW2heMCcrdo0M94SZ2aoW1JNkM02DylxNurESaMfD6DNP+V
 EFtxQVsT7z1jRMLx5STbNRILpb+YADXNc9Q6hwsIgMqhc7I6KetYPiRb1 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="371112860"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; d="scan'208";a="371112860"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2023 09:27:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="4608611"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.19.128])
 ([10.93.19.128])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2023 09:27:11 -0700
Message-ID: <a3aca8df-1b4a-4efe-9f79-107aa2fd1a39@intel.com>
Date: Thu, 19 Oct 2023 00:27:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] softmmu/physmem: Warn with
 ram_block_discard_range() on MAP_PRIVATE file mapping
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
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
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ab0d4962-1e38-4758-bd3c-88c8754b433f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=xiaoyao.li@intel.com; helo=mgamail.intel.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/18/2023 5:26 PM, David Hildenbrand wrote:
> On 18.10.23 11:02, Xiaoyao Li wrote:
>> On 10/18/2023 3:42 PM, David Hildenbrand wrote:
>>> On 18.10.23 05:02, Xiaoyao Li wrote:
>>>> David,
>>>>
>>>> On 7/6/2023 3:56 PM, David Hildenbrand wrote:
>>>>> ram_block_discard_range() cannot possibly do the right thing in
>>>>> MAP_PRIVATE file mappings in the general case.
>>>>>
>>>>> To achieve the documented semantics, we also have to punch a hole into
>>>>> the file, possibly messing with other MAP_PRIVATE/MAP_SHARED mappings
>>>>> of such a file.
>>>>>
>>>>> For example, using VM templating -- see commit b17fbbe55cba 
>>>>> ("migration:
>>>>> allow private destination ram with x-ignore-shared") -- in
>>>>> combination with
>>>>> any mechanism that relies on discarding of RAM is problematic. This
>>>>> includes:
>>>>> * Postcopy live migration
>>>>> * virtio-balloon inflation/deflation or free-page-reporting
>>>>> * virtio-mem
>>>>>
>>>>> So at least warn that there is something possibly dangerous is 
>>>>> going on
>>>>> when using ram_block_discard_range() in these cases.
>>>>>
>>>>> Acked-by: Peter Xu <peterx@redhat.com>
>>>>> Tested-by: Mario Casquero <mcasquer@redhat.com>
>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>> ---
>>>>>     softmmu/physmem.c | 18 ++++++++++++++++++
>>>>>     1 file changed, 18 insertions(+)
>>>>>
>>>>> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
>>>>> index bda475a719..4ee157bda4 100644
>>>>> --- a/softmmu/physmem.c
>>>>> +++ b/softmmu/physmem.c
>>>>> @@ -3456,6 +3456,24 @@ int ram_block_discard_range(RAMBlock *rb,
>>>>> uint64_t start, size_t length)
>>>>>                  * so a userfault will trigger.
>>>>>                  */
>>>>>     #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
>>>>> +            /*
>>>>> +             * We'll discard data from the actual file, even though
>>>>> we only
>>>>> +             * have a MAP_PRIVATE mapping, possibly messing with 
>>>>> other
>>>>> +             * MAP_PRIVATE/MAP_SHARED mappings. There is no easy 
>>>>> way to
>>>>> +             * change that behavior whithout violating the promised
>>>>> +             * semantics of ram_block_discard_range().
>>>>> +             *
>>>>> +             * Only warn, because it work as long as nobody else
>>>>> uses that
>>>>> +             * file.
>>>>> +             */
>>>>> +            if (!qemu_ram_is_shared(rb)) {
>>>>> +                warn_report_once("ram_block_discard_range:
>>>>> Discarding RAM"
>>>>> +                                 " in private file mappings is
>>>>> possibly"
>>>>> +                                 " dangerous, because it will modify
>>>>> the"
>>>>> +                                 " underlying file and will affect
>>>>> other"
>>>>> +                                 " users of the file");
>>>>> +            }
>>>>> +
>>>>
>>>> TDX has two types of memory backend for each RAM, shared memory and
>>>> private memory. Private memory is serviced by guest memfd and shared
>>>> memory can also be backed with a fd.
>>>>
>>>> At any time, only one type needs to be valid, which means the opposite
>>>> can be discarded. We do implement the memory discard when TDX converts
>>>> the memory[1]. It will trigger this warning 100% because by default the
>>>> guest memfd is not mapped as shared (MAP_SHARED).
>>>
>>> If MAP_PRIVATE is not involved and you are taking the pages directly out
>>> of the memfd, you should mark that thing as shared.
>>
>> Is it the general rule of Linux? Of just the rule of QEMU memory discard?
>>
> 
> MAP_SHARED vs. MAP_PRIVATE is a common UNIX principle, and that's what 
> this flag and the check is about.
> 
>  From mmap(2)
> 
> MAP_SHARED: Share this mapping.  Updates to the mapping are visible to 
> other processes mapping the same region, and (in the case of file-backed 
> mappings) are carried through to the underlying file.
> 
> MAP_PRIVATE: Create a private copy-on-write mapping.  Updates to the 
> mapping are not visible to other processes mapping the same file, and 
> are not carried through to the underlying file.  It is unspecified 
> whether changes made  to the file after the mmap() call are visible in 
> the mapped region.
> 
> For your purpose (no mmap() at all), we behave like MAP_SHARED -- as if 
> nothing special is done. No Copy-on-write, no anonymous memory.
> 
>>> Anonymous memory is never involved.
>>
>> Could you please elaborate more on this? What do you want to express
>> here regrading anonymous memory? (Sorry that I'm newbie for mmap stuff)
> 
> Anonymous memory is memory that is private to a specific process, and 
> (see MAP_PRIVATE) modifications remain private to the process and are 
> not reflected to the file.
> 
> If you have a MAP_PRIVATE file mapping and write to a virtual memory 
> location, you'll get a process-private copy of the underlying pagecache 
> page. that's what we call anonymous memory, because it does not belong 
> to a specific file. fallocate(punch) would not free up that anonymous 
> memory.

For guest memfd, it does implement kvm_gmem_fallocate as .fallocate() 
callback, which calls truncate_inode_pages_range() [*].

I'm not sure if it frees up the memory. I need to learn it.

[*] 
https://github.com/kvm-x86/linux/blob/911b515af3ec5f53992b9cc162cf7d3893c2fbe2/virt/kvm/guest_memfd.c#L147C73-L147C73

>>
>>>
>>> "Private memory" is only private from the guest POV, not from a mmap()
>>> point of view.
>>>
>>> Two different concepts of "private".
>>>
>>>>
>>>> Simply remove the warning will fail the purpose of this patch. The 
>>>> other
>>>> option is to skip the warning for TDX case, which looks vary hacky. Do
>>>> you have any idea?
>>>
>>> For TDX, all memory backends / RAMBlocks should be marked as "shared",
>>> and you should fail if that is not provided by the user.
>>
>> As I asked above, I want to understand the logic clearly. Is mapped as
>> shared is a must to support the memory discard? i.e., if we want to
>> support memory discard after memory type change, then the memory must be
>> mapped with MAP_SHARED?
> 
> MAP_PIRVATE means that it's not sufficient to only fallocate(punch) the 
> fd to free up all memory for a virtual address, because there might be 
> anonymous memory in a private mapping that has to be freed up using 
> MADV_DONTNEED. 

I can understand this. But it seems unrelated to my question: Is mapped 
as shared is a must to support the memory discard?

e.g., if use below parameters to specify the RAM for a VM

	-object memory-backend-memfd,id=mem0,size=2G	\
	-machine memory-backend=mem0

since not specifying "share" property, the ram_block doesn't have 
RAM_SHARED set. If want to discard some range of this memfd, it triggers 
the warning. Is this warning expected?

I know it is not a possible case for current QEMU, but it's true for 
future TDX VM. TDX VM can have memory-backend-memfd as the backend for 
shared memory and kvm gmem memfd for private memory. At any time, for 
any memory range, only one type is valid, thus the range in opposite 
memfd can be fallocated.

Here I get your message as "the ramblock needs to have RAM_SHARED flag 
to allow the fallocate of the memfd". This is what I don't understand.

That's why this functions handles both cases differently,
> and warns if something possibly nasty is being done.
> 


