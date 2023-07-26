Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 984C4762F5F
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 10:12:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOZcf-0000K6-Ts; Wed, 26 Jul 2023 04:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qOZcd-0000Jt-Qz
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 04:11:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qOZcb-0000ZB-Km
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 04:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690359108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ExX7vwtG+h4oqKGZxaboIPpez0P/xxObkqP+WA1JGJg=;
 b=DtgzfUeG+S8LnGEBUVjFyd57k2URn9hbc1xygW7Jd3+rcthKPJhJH6s15qfpVBH7ebHhGs
 Sh1Gq+0y6r2pNiA2RuwJEFWbuhV9B0DL6GFrV3NKZGEGW+g2TWpSHQHvJV3oB9v7B/6XH3
 JGblGxpXa1nR7jrh2sYZuElL6pA13tc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-RdGPSU4fNTO1MWAl1qgnZQ-1; Wed, 26 Jul 2023 04:11:47 -0400
X-MC-Unique: RdGPSU4fNTO1MWAl1qgnZQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31701b27d19so370247f8f.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 01:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690359106; x=1690963906;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ExX7vwtG+h4oqKGZxaboIPpez0P/xxObkqP+WA1JGJg=;
 b=jtbd/F8MVgINtkd7tjkCHznjU9b++leKnM2OFh+z985kSEsI7fFBI4bnHB8Yr+GvrB
 +Z+XaAXp/v0sgT9QElGClwbs7T3UMtfl+hhZ+Hn/WfvjNT97S81uLc52zhWt0Sp5elN3
 eJ0Jjo+J64D2NH7gh377pBj4kK5QG+JjzMYOokks2ZzIgEc1GzezT6bfGsm0dMQTpzG3
 iEZzbg8VjfWaV6R/J/Osa/HFS+Wyu3+2v1sH6KgllPM9DeQ4bjEaVm892r+rPQkPFQil
 r3lHB2gXCEezfa8+3dc/lNMqP/JE/sokZpzH/hAb26S31bxMHL14XzOYl1cAqvvm1jR3
 BUpQ==
X-Gm-Message-State: ABy/qLawvphmn18fqja/jikyDqgERRA6Xc3Hpmgn4pZ36fAxi8tvbLFn
 yzgN+ppOqASpd9s7Vz2NyXzP3DCsSbKiC6oKhK5ij8p60+qyKtlEl6Kgn0bGYGfQub4V20VzXbh
 yDD4pK4cgDPNNECs=
X-Received: by 2002:a05:6000:1082:b0:313:ee8b:8489 with SMTP id
 y2-20020a056000108200b00313ee8b8489mr3617251wrw.10.1690359106127; 
 Wed, 26 Jul 2023 01:11:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGMy5KX9ChGO+O4096haHudxQ7MLoYeVv6Bw1YeO4oLZMRHyxynaoeAEhzm+UuGccV7GPJoTw==
X-Received: by 2002:a05:6000:1082:b0:313:ee8b:8489 with SMTP id
 y2-20020a056000108200b00313ee8b8489mr3617232wrw.10.1690359105506; 
 Wed, 26 Jul 2023 01:11:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:f600:a519:c50:799b:f1e3?
 (p200300cbc705f600a5190c50799bf1e3.dip0.t-ipconnect.de.
 [2003:cb:c705:f600:a519:c50:799b:f1e3])
 by smtp.gmail.com with ESMTPSA id
 q6-20020adff506000000b003141e629cb6sm18886571wro.101.2023.07.26.01.11.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jul 2023 01:11:44 -0700 (PDT)
Message-ID: <96a462ec-6f9d-fd83-f697-73e132432ca4@redhat.com>
Date: Wed, 26 Jul 2023 10:11:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: ThinerLogoer <logoerthiner1@163.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: imammedo <imammedo@redhat.com>
References: <20230725105239.2022-1-logoerthiner1@163.com>
 <5395c9a4-ead5-ad94-c5c6-6128953fdcc8@redhat.com>
 <524210f0.7aca.1898dc8d60e.Coremail.logoerthiner1@163.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] Open file as read only on private mapping in
 qemu_ram_alloc_from_file
In-Reply-To: <524210f0.7aca.1898dc8d60e.Coremail.logoerthiner1@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 25.07.23 18:01, ThinerLogoer wrote:
> 
> At 2023-07-25 19:42:30, "David Hildenbrand" <david@redhat.com> wrote:
>> Hi,
>>
>> patch subject should start with "softmmu/physmem: Open ..."
> 
> Sorry I am newbie to the patch submission part. I will resubmit a version of patch if the
> final acceptable patch after discussion is mostly the same. (For example, if this patch
> finally involves adding another parameter and adding various hooks, then I may feel it
> hard to finish the patch myself, both due to lack of knowledge of qemu source code tree,
> and due to lack of various environment to test every case out)

No worries. I'll be happy to guide you. But if you feel more comfortable 
that I take over, just let me know.

> 
> Anyway thanks to all your suggestions.
> 
>>
>> On 25.07.23 12:52, Thiner Logoer wrote:
>>> An read only file can be mapped with read write as long as the
>>> mapping is private, which is very common case. Make
>>
>> At least in the environments I know, using private file mappings is a corner case ;)
>>
>> What is you use case? VM templating?
> 
> Mostly, if I understand the terminology correct. I was experimenting on vm snapshoting
> that uses MAP_PRIVATE when recovering memory, similar to what firecracker says in this
> documentation.
> 
> https://github.com/firecracker-microvm/firecracker/blob/main/docs/snapshotting/snapshot-support.md
> 
> And in my experiment qemu supports recovering from a memory file + a guest state file out
> of the box.
> In fact, `-mem-path filename4pc.ram` works out of the box (since the default parameter is
> map_private+readwrite), only that vanilla setup requires memory file to be writeable

Oh, you're saying "-mem-path" results in a MAP_PRIVATE mapping? That 
sounds very nasty :/ It probably was introduced only for hugetlb 
handling, and wouldn't actually share memory with another process.

In fact, we added MAP_SHARED handling later

commit dbcb8981183592be129b2e624b7bcd4245e75fbc
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue Jun 10 19:15:24 2014 +0800

     hostmem: add property to map memory with MAP_SHARED

     A new "share" property can be used with the "memory-file" backend to
     map memory with MAP_SHARED instead of MAP_PRIVATE.


Even one doc in docs/devel/multi-process.rst is wrong:

"Note guest memory must be backed by file descriptors, such as when QEMU 
is given the *-mem-path* command line option."

... no, that won't work with a MAP_PRIVATE mapping.


> though the file never gets written. (the actual memory file & guest state file require
> separated hacking)
> 
> And at least the patch provided here have been the solution to this last problem for me
> for a while.
> 
> By the way the commit: "Commit 134253a4, machine: do not crash if default RAM backend name
> has been stolen" disallows me to use a memory backed file directly as pc.ram and make
> `-object memory-backed-file,*` based setup more complex (I cannot easily make the memory

Can't you simply do

-object memory-backed-file,id=mem1 \
-machine q35,memory-backend=mem1,share=off \

Or what would be the problem with that?

> unbacked by any file before snapshoting and backed by file after recovery from snapshot
> after this patch). This is the reason why I prefer `-mem-path` despite the doc tells that
> this usage is close to deprecated, and that `-mem-path` has less configurable parameters.
> 
>>
>>> qemu_ram_alloc_from_file open file as read only when the
>>> mapping is private, otherwise open will fail when file
>>> does not allow write.
>>>
>>> If this file does not exist or is a directory, the flag is not used,
>>> so it should be OK.
>>>
>>> from https://gitlab.com/qemu-project/qemu/-/issues/1689
>>>
>>> Signed-off-by: Thiner Logoer <logoerthiner1@163.com>
>>> ---
>>>    softmmu/physmem.c | 9 ++++++++-
>>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
>>> index 3df73542e1..e8036ee335 100644
>>> --- a/softmmu/physmem.c
>>> +++ b/softmmu/physmem.c
>>> @@ -1945,8 +1945,15 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion*mr,
>>>        int fd;
>>>        bool created;
>>>        RAMBlock *block;
>>> +
>>
>> ^
>>
>> .git/rebase-apply/patch:13: trailing whitespace.
> 
> I remembered I have deleted this whitespace before. Obviously I have messed up with
> different version of patch files, sorry about that ...
> 

No worries :)

>>
>>> +    /*
>>> +     * If map is private, the fd does not need to be writable.
>>> +     * This only get effective when the file is existent.
>>
>> "This will get ignored if the file does not yet exist."
>>
>>> +     */
>>> +    bool open_as_readonly = readonly || !(ram_flags & RAM_SHARED);
>>>
>>> -    fd = file_ram_open(mem_path, memory_region_name(mr), readonly, &created,
>>> +    fd = file_ram_open(mem_path, memory_region_name(mr),
>>> +                       open_as_readonly, &created,
>>>                           errp);
>>>        if (fd < 0) {
>>>            return NULL;
>>
>>
>> Opening a file R/O will also make operations like fallocate/ftruncate/ ... fail.
> 
> I saw fallocate in softmmu/physmem.c on somewhere, though I was not sure how it is
> actually used. Your response fills in this part.
> 
>>
>> For example, this will make fallocate(FALLOC_FL_PUNCH_HOLE) stop working and in
>> turn make ram_block_discard_range() bail out.
>>
>>
>> There was a recent discussion/patch on that:
>>
>> commit 1d44ff586f8a8e113379430750b5a0a2a3f64cf9
>> Author: David Hildenbrand <david@redhat.com>
>> Date:   Thu Jul 6 09:56:06 2023 +0200
>>
>>      softmmu/physmem: Warn with ram_block_discard_range() on MAP_PRIVATE file mapping
>>
>>      ram_block_discard_range() cannot possibly do the right thing in
>>      MAP_PRIVATE file mappings in the general case.
>>
>>      To achieve the documented semantics, we also have to punch a hole into
>>      the file, possibly messing with other MAP_PRIVATE/MAP_SHARED mappings
>>      of such a file.
>>
>>      For example, using VM templating -- see commit b17fbbe55cba ("migration:
>>      allow private destination ram with x-ignore-shared") -- in combination with
>>      any mechanism that relies on discarding of RAM is problematic. This
>>      includes:
>>      * Postcopy live migration
>>      * virtio-balloon inflation/deflation or free-page-reporting
>>      * virtio-mem
>>
>>      So at least warn that there is something possibly dangerous is going on
>>      when using ram_block_discard_range() in these cases.
>>
> 
> I did not expect that multiple qemu features will contradict each other - private cow map
> of file & user fault fd based on demand memory serving ... (do not blame me too much if I
> get the terminology wrong - I am no professional qemu dev :D)

Let me rephrase:

"I did not wish that multiple qemu features will contradict each other"

:)

> 
>>
>> While it doesn't work "in the general case", it works in the "single file owner" case
>> where someone simply forgot to specify "share=on" -- "share=off" is the default for
>> memory-backend-file :( .
>>
>>
>> For example, with hugetlb+virtio-mem the following works if the file does not exists:
>>
>> (note that virtio-mem will fallocate(FALLOC_FL_PUNCH_HOLE) the whole file upfront)
>>
>> ...
>> -object memory-backend-file,share=off,mem-path=/dev/hugepages/vmem0,id=mem2,size=2G \
>> -device virtio-mem-pci,id=vmem0,memdev=mem2,requested-size=1g,bus=root
>>
>>
>> With you patch, once the file already exists, we would now get
>>
>> qemu-system-x86_64: -device
> virtio-mem-pci,id=vmem0,memdev=mem2,requested-size=1g,bus=root: ram_block_discard_range:
> Failed to fallocate :0 +80000000 (-9)
>> qemu-system-x86_64: -device
> virtio-mem-pci,id=vmem0,memdev=mem2,requested-size=1g,bus=root: Unexpected error
> discarding RAM: Bad file descriptor
>>
>>
>> So this has the potential to break existing setups.
>>
>> The easy fix for these would be to configure "share=on" in these now-failing setups. Hmmmmm ....
> 
> I am afraid that the easiest prefix could be to configure `share=on` when the path starts
> with "/dev/huge" while firing a warning :D
> 
> I am sorry about that if existing systems will be broken because of my patch ...
> 
> I have learnt that mem-path commonly refer to hugetlb/hugepage, but actually I have no
> idea what is the outcome if hugetlb or anything similar was mapped with map_private and
> copy-on-write happens - will a whole huge page be copied on write then?
> 
> I would suppose that in reality system managers may consider directly remove the file
> first if the file will be truncated anyway. However t would be a different story if this
> file should be truncated exactly PARTIALLY.
> 
> Alternatively maybe another flag "create=on" can be added when private semantics are
> required, so that if the file exists, the file should be unlinked or truncated first
> before using?
> 
> Since I am nowhere familiar to this part of qemu source code, it will be hard for me to
> write the additional command line flag part correct, if this is believed to be the correct
> solution though.
> 
> In summary I am glad to learn more of the backgrounds here.

The easiest way not break any existing setup would be to open the file 
R/O only if opening it R/W failed due to lack of permissions, and we 
have a private mapping. So, in case of !RAMP_SHARED, simply retry once 
more without write permissions.

Would that keep your use-case working?

> 
> Back to `-mem-path` part. Now I wonder whether filling the initial value for ram is what
> `-mem-path` is expected behavior (whether I am using a feature that will be deprecated
> soon); whether there is a convenient method to filling the initial value in copy-on-write
> styles if `mem-path` is not good to use; and in general whether a privately used memory
> backed file SHOULD be writeable.

The case that "-mem-path" has always used MAP_PRIVATE and seemed to have 
worked with postcopy live migration (another user of 
fallocate(PUNCH_HOLE)) tells me that we should be careful about that.

-- 
Cheers,

David / dhildenb


