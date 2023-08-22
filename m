Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 165327841FD
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 15:26:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYRO3-0004iW-8B; Tue, 22 Aug 2023 09:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYRO1-0004ht-3b
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:25:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYRNy-0003Ta-B0
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692710729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KFsIw/yMDmpohd9njbuBjjoQilF4FSTBa6w+0fcEWq0=;
 b=S2sJ9WW7MdeFX3/lwJW2iRoqPUX7HpvJ0VROTUNRWCzWw95d+ZCcQzVUVw4XqeXm5RlRUo
 /nkacuNNK9QrJVY9eMuoty+j2yuINc8PMcRajMarCg2u1AT0MbKd2R1LENEp8086ouZB6X
 Fg2IjZQrTia3mxbH5/+hZiHiBsrQ8O4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-Os1vkf3xNdiQ5bkjkpYOqA-1; Tue, 22 Aug 2023 09:25:28 -0400
X-MC-Unique: Os1vkf3xNdiQ5bkjkpYOqA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3feb93ba681so30602815e9.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 06:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692710727; x=1693315527;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KFsIw/yMDmpohd9njbuBjjoQilF4FSTBa6w+0fcEWq0=;
 b=hjYL6iSo2Y688s0jyQOaVbJRN3B6OlxfHecFs+fjCmi/fLZw4O52EVtKNaMoofyg4T
 hRUgzACC4Vj2ouWpok3gKyMMUVev1C3z/IebUntzIJR2Tz7x+bmubfPAYuQxt9IFZu7f
 wEZ3yl3ulrOIWIcn3gWJhi46XEdpS1ARMidHKKTQfiDmKsbYNUKKChaUEULcQemRTCM6
 E9/hG540RoY3wV0+2enHArOgA674gwWOigjAqmHz8y8fwlYcHJFpFrktq+Z3d+9GRsEp
 rv789Gy/lwSPYK4WunyQjsMvF/h6hI8N7WXhZXFwCZiMezhzfq5eC5qNYAzj7MtmNFa+
 SuNA==
X-Gm-Message-State: AOJu0YynB6LX+5CLTK+X/oal4ve0By/D0VBdEZUa48oyFEj9TLLRxXZW
 a/Oyb+t5S2eow2rM5EQkua0BRFbZQLp6VVnUlz5CbZM/tTOL59sfkUXovov85cNLSXo1O/EJIFm
 lH4jVuwSmR7dfWzc=
X-Received: by 2002:adf:cd0e:0:b0:317:67bf:3376 with SMTP id
 w14-20020adfcd0e000000b0031767bf3376mr7488243wrm.57.1692710726844; 
 Tue, 22 Aug 2023 06:25:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDnH0KnNYxJ0YqwUbyp3NS1c23vTObkGiYee6g3bNGq+zPwPxjzT7rc0VpVC5W3Z81M3DFTg==
X-Received: by 2002:adf:cd0e:0:b0:317:67bf:3376 with SMTP id
 w14-20020adfcd0e000000b0031767bf3376mr7488220wrm.57.1692710726417; 
 Tue, 22 Aug 2023 06:25:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:7400:83da:ebad:ba7f:c97c?
 (p200300cbc706740083daebadba7fc97c.dip0.t-ipconnect.de.
 [2003:cb:c706:7400:83da:ebad:ba7f:c97c])
 by smtp.gmail.com with ESMTPSA id
 o18-20020adfead2000000b003143b14848dsm15790282wrn.102.2023.08.22.06.25.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 06:25:26 -0700 (PDT)
Message-ID: <08478308-105e-5260-e279-a96178cb32db@redhat.com>
Date: Tue, 22 Aug 2023 15:25:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/9] softmmu/physmem: Distinguish between file access
 mode and mmap protection
Content-Language: en-US
To: ThinerLogoer <logoerthiner1@163.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, Greg Kurz <groug@kaod.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230822114504.239505-1-david@redhat.com>
 <20230822114504.239505-3-david@redhat.com>
 <68f94cf4.45d0.18a1d615de9.Coremail.logoerthiner1@163.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <68f94cf4.45d0.18a1d615de9.Coremail.logoerthiner1@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.767, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 22.08.23 15:13, ThinerLogoer wrote:
> Hello,
> 
> At 2023-08-22 19:44:50, "David Hildenbrand" <david@redhat.com> wrote:
>> There is a difference between how we open a file and how we mmap it,
>> and we want to support writable private mappings of readonly files. Let's
>> define RAM_READONLY and RAM_READONLY_FD flags, to replace the single
>> "readonly" parameter for file-related functions.
>>
>> In memory_region_init_ram_from_fd() and memory_region_init_ram_from_file(),
>> initialize mr->readonly based on the new RAM_READONLY flag.
>>
>> While at it, add some RAM_* flags we missed to add to the list of accepted
>> flags in the documentation of some functions.
>>
>> No change in functionality intended. We'll make use of both flags next
>> and start setting them independently for memory-backend-file.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>> backends/hostmem-file.c |  4 ++--
>> include/exec/memory.h   | 14 ++++++++++----
>> include/exec/ram_addr.h |  8 ++++----
>> softmmu/memory.c        |  8 ++++----
>> softmmu/physmem.c       | 21 ++++++++++-----------
>> 5 files changed, 30 insertions(+), 25 deletions(-)
>>
>> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
>> index b4335a80e6..ef2d5533af 100644
>> --- a/backends/hostmem-file.c
>> +++ b/backends/hostmem-file.c
>> @@ -55,13 +55,13 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>>
>>      name = host_memory_backend_get_name(backend);
>>      ram_flags = backend->share ? RAM_SHARED : 0;
>> +    ram_flags |= fb->readonly ? RAM_READONLY | RAM_READONLY_FD : 0;
>>      ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
>>      ram_flags |= fb->is_pmem ? RAM_PMEM : 0;
>>      ram_flags |= RAM_NAMED_FILE;
>>      memory_region_init_ram_from_file(&backend->mr, OBJECT(backend), name,
>>                                       backend->size, fb->align, ram_flags,
>> -                                     fb->mem_path, fb->offset, fb->readonly,
>> -                                     errp);
>> +                                     fb->mem_path, fb->offset, errp);
>>      g_free(name);
>> #endif
>> }
>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>> index 68284428f8..cc68249eda 100644
>> --- a/include/exec/memory.h
>> +++ b/include/exec/memory.h
>> @@ -235,6 +235,12 @@ typedef struct IOMMUTLBEvent {
>> /* RAM is an mmap-ed named file */
>> #define RAM_NAMED_FILE (1 << 9)
>>
>> +/* RAM is mmap-ed read-only */
>> +#define RAM_READONLY (1 << 10)
>> +
>> +/* RAM FD is opened read-only */
>> +#define RAM_READONLY_FD (1 << 11)
>> +
>> static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
>>                                         IOMMUNotifierFlag flags,
>>                                         hwaddr start, hwaddr end,
>> @@ -1331,10 +1337,10 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
>>   * @align: alignment of the region base address; if 0, the default alignment
>>   *         (getpagesize()) will be used.
>>   * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
>> - *             RAM_NORESERVE,
>> + *             RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
>> + *             RAM_READONLY_FD
>>   * @path: the path in which to allocate the RAM.
>>   * @offset: offset within the file referenced by path
>> - * @readonly: true to open @path for reading, false for read/write.
>>   * @errp: pointer to Error*, to store an error if it happens.
>>   *
>>   * Note that this function does not do anything to cause the data in the
>> @@ -1348,7 +1354,6 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
>>                                        uint32_t ram_flags,
>>                                        const char *path,
>>                                        ram_addr_t offset,
>> -                                      bool readonly,
>>                                        Error **errp);
>>
>> /**
>> @@ -1360,7 +1365,8 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
>>   * @name: the name of the region.
>>   * @size: size of the region.
>>   * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
>> - *             RAM_NORESERVE, RAM_PROTECTED.
>> + *             RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
>> + *             RAM_READONLY_FD
>>   * @fd: the fd to mmap.
>>   * @offset: offset within the file referenced by fd
>>   * @errp: pointer to Error*, to store an error if it happens.
>> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
>> index 9f2e3893f5..90676093f5 100644
>> --- a/include/exec/ram_addr.h
>> +++ b/include/exec/ram_addr.h
>> @@ -108,10 +108,10 @@ long qemu_maxrampagesize(void);
>>   *  @size: the size in bytes of the ram block
>>   *  @mr: the memory region where the ram block is
>>   *  @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
>> - *              RAM_NORESERVE.
>> + *              RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
>> + *              RAM_READONLY_FD
>>   *  @mem_path or @fd: specify the backing file or device
>>   *  @offset: Offset into target file
>> - *  @readonly: true to open @path for reading, false for read/write.
>>   *  @errp: pointer to Error*, to store an error if it happens
>>   *
>>   * Return:
>> @@ -120,10 +120,10 @@ long qemu_maxrampagesize(void);
>>   */
>> RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>>                                     uint32_t ram_flags, const char *mem_path,
>> -                                   off_t offset, bool readonly, Error **errp);
>> +                                   off_t offset, Error **errp);
>> RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>>                                   uint32_t ram_flags, int fd, off_t offset,
>> -                                 bool readonly, Error **errp);
>> +                                 Error **errp);
>>
>> RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
>>                                    MemoryRegion *mr, Error **errp);
>> diff --git a/softmmu/memory.c b/softmmu/memory.c
>> index 7d9494ce70..d8974a1e65 100644
>> --- a/softmmu/memory.c
>> +++ b/softmmu/memory.c
>> @@ -1620,18 +1620,17 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
>>                                        uint32_t ram_flags,
>>                                        const char *path,
>>                                        ram_addr_t offset,
>> -                                      bool readonly,
>>                                        Error **errp)
>> {
>>      Error *err = NULL;
>>      memory_region_init(mr, owner, name, size);
>>      mr->ram = true;
>> -    mr->readonly = readonly;
>> +    mr->readonly = ram_flags & RAM_READONLY;
> 
> I only did a quick code auditing, but I suspect that
> ```
> mr->readonly = !!(ram_flags & RAM_READONLY);
> ```
> is safer. So is the other parts of the code probably.

Yes, looks cleaner, thanks!

-- 
Cheers,

David / dhildenb


