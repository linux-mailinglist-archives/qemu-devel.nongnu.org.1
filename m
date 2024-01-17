Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EAB8308AC
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 15:52:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7GO-0002p0-E3; Wed, 17 Jan 2024 09:51:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rQ7GI-0002nX-6Q
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:51:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rQ7GE-0001gb-Ck
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705503080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mtHxHszigEapZr4e4Kwdgw81k2xblKFJ892XAdUQjFk=;
 b=K0NtdMAdlGbITjTNToAlcWI7/7Cw4suO/aAYWCRsHKfEjZ4btqZF2w//8/wEMtKc2FBWwx
 34ze1aQUe6gdXG3aTUjk/9O1fpC/Arczt1FeZDZ2RjTCV6ymzFmrCfAkSur+JHGjibZb8v
 7xcioVW2lZ5MXBE5/DmyUTsRbOlBh28=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-9xc5MlDAMc2gthpWcT8ZUg-1; Wed, 17 Jan 2024 09:51:19 -0500
X-MC-Unique: 9xc5MlDAMc2gthpWcT8ZUg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40e6e3c46bfso35720485e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 06:51:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705503078; x=1706107878;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mtHxHszigEapZr4e4Kwdgw81k2xblKFJ892XAdUQjFk=;
 b=hx7Hj85c8IruyTLx7UqKAcP/HNgCXhGwiVgOa3T/AINebPxUAIQozNTK/iVwYdU/X4
 bb7POXR1W/t4oT503GtcANiDfk0yh4fgBgF8pIPwbh3HMj7pi/LiGpinP88BFe7386iK
 U3Mh+giMfN7NuLBk0sODybCFrZ+n6AqDgjQVwesg/Uyk8JY9gbUIUPL1d+94HMdPILNg
 iB3M7LXa08s4Gfw8ID1p7dZvmaYrin0LtpXxAQ8gkcmyODRzBiWZJ2dTAkz7SS+7D6pC
 2zQ3rVd+BIygscS7bEM+lFYJJ6ng/96CWJbYn3TNKKAoLkfcKWs+M8++x+29lfHERity
 S+Gg==
X-Gm-Message-State: AOJu0YyxXl2oPTJIz6kZzn+ho+tOPuekPhiZnY/x+ACjFh5TTphoUvJ1
 sttDBTM7QW+XYyAgl/QyrnEK+7Z1h4wvythLLt2KuxnownB1Nh131uLo3GiSJ2L60aHiaSUhFWf
 LK4NVdN9Nm3QRySqkQfvgz9o=
X-Received: by 2002:a1c:721a:0:b0:40e:670f:488 with SMTP id
 n26-20020a1c721a000000b0040e670f0488mr4073411wmc.0.1705503077850; 
 Wed, 17 Jan 2024 06:51:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5mE38mMPDZJc8alHHB7/+J0IZL6D1GZQU4K56pIddUqCWijdboBBeSO/sCVOYPhfWSaHuDQ==
X-Received: by 2002:a1c:721a:0:b0:40e:670f:488 with SMTP id
 n26-20020a1c721a000000b0040e670f0488mr4073402wmc.0.1705503077377; 
 Wed, 17 Jan 2024 06:51:17 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:b700:5a87:3a7a:c28d:2cff?
 (p200300cbc70bb7005a873a7ac28d2cff.dip0.t-ipconnect.de.
 [2003:cb:c70b:b700:5a87:3a7a:c28d:2cff])
 by smtp.gmail.com with ESMTPSA id
 m35-20020a05600c3b2300b0040e541ddcb1sm22900163wms.33.2024.01.17.06.51.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 06:51:16 -0800 (PST)
Message-ID: <c0a0158e-b672-4e3e-aaab-c3305628dcd1@redhat.com>
Date: Wed, 17 Jan 2024 15:51:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] oslib-posix: refactor memory prealloc threads
Content-Language: en-US
To: Mark Kanda <mark.kanda@oracle.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
References: <20240108151041.529716-1-mark.kanda@oracle.com>
 <20240108151041.529716-2-mark.kanda@oracle.com>
 <2be78fc2-f76a-44de-8db7-fbc1bbdc0d2b@redhat.com>
 <1854ecdd-88d8-462d-aa0f-990c2bbe57ff@oracle.com>
 <02801117-4408-4069-b0ba-b54f4d050fc4@redhat.com>
 <ZZ1VDF0U7PkOwgWh@redhat.com>
 <fc3a6a13-6a2d-44c4-9cf0-a91dc2cf1b97@redhat.com>
 <931d619a-d5f7-41a1-bb15-b6c10b94af90@oracle.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <931d619a-d5f7-41a1-bb15-b6c10b94af90@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

On 17.01.24 15:44, Mark Kanda wrote:
> On 1/9/24 8:25 AM, David Hildenbrand wrote:
>> On 09.01.24 15:15, Daniel P. Berrangé wrote:
>>> On Tue, Jan 09, 2024 at 03:02:00PM +0100, David Hildenbrand wrote:
>>>> On 08.01.24 19:40, Mark Kanda wrote:
>>>>> On 1/8/24 9:40 AM, David Hildenbrand wrote:
>>>>>> On 08.01.24 16:10, Mark Kanda wrote:
>>>>>>> Refactor the memory prealloc threads support:
>>>>>>> - Make memset context a global qlist
>>>>>>> - Move the memset thread join/cleanup code to a separate routine
>>>>>>>
>>>>>>> This is functionally equivalent and facilitates multiple memset
>>>>>>> contexts
>>>>>>> (used in a subsequent patch).
>>>>>>>
>>>>>>> Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
>>>>>>> ---
>>>>>>>      util/oslib-posix.c | 104
>>>>>>> +++++++++++++++++++++++++++++----------------
>>>>>>>      1 file changed, 68 insertions(+), 36 deletions(-)
>>>>>>>
>>>>>>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>>>>>>> index e86fd64e09..293297ac6c 100644
>>>>>>> --- a/util/oslib-posix.c
>>>>>>> +++ b/util/oslib-posix.c
>>>>>>> @@ -63,11 +63,15 @@
>>>>>>>        struct MemsetThread;
>>>>>>>      +static QLIST_HEAD(, MemsetContext) memset_contexts =
>>>>>>> +    QLIST_HEAD_INITIALIZER(memset_contexts);
>>>>>>> +
>>>>>>>      typedef struct MemsetContext {
>>>>>>>          bool all_threads_created;
>>>>>>>          bool any_thread_failed;
>>>>>>>          struct MemsetThread *threads;
>>>>>>>          int num_threads;
>>>>>>> +    QLIST_ENTRY(MemsetContext) next;
>>>>>>>      } MemsetContext;
>>>>>>>        struct MemsetThread {
>>>>>>> @@ -81,7 +85,7 @@ struct MemsetThread {
>>>>>>>      typedef struct MemsetThread MemsetThread;
>>>>>>>        /* used by sigbus_handler() */
>>>>>>> -static MemsetContext *sigbus_memset_context;
>>>>>>> +static bool sigbus_memset_context;
>>>>>>>      struct sigaction sigbus_oldact;
>>>>>>>      static QemuMutex sigbus_mutex;
>>>>>>>      @@ -295,13 +299,16 @@ static void sigbus_handler(int signal)
>>>>>>>      #endif /* CONFIG_LINUX */
>>>>>>>      {
>>>>>>>          int i;
>>>>>>> +    MemsetContext *context;
>>>>>>>            if (sigbus_memset_context) {
>>>>>>> -        for (i = 0; i < sigbus_memset_context->num_threads; i++) {
>>>>>>> -            MemsetThread *thread =
>>>>>>> &sigbus_memset_context->threads[i];
>>>>>>> +        QLIST_FOREACH(context, &memset_contexts, next) {
>>>>>>> +            for (i = 0; i < context->num_threads; i++) {
>>>>>>> +                MemsetThread *thread = &context->threads[i];
>>>>>>>      -            if (qemu_thread_is_self(&thread->pgthread)) {
>>>>>>> -                siglongjmp(thread->env, 1);
>>>>>>> +                if (qemu_thread_is_self(&thread->pgthread)) {
>>>>>>> +                    siglongjmp(thread->env, 1);
>>>>>>> +                }
>>>>>>>                  }
>>>>>>>              }
>>>>>>>          }
>>>>>>> @@ -417,14 +424,15 @@ static int touch_all_pages(char *area, size_t
>>>>>>> hpagesize, size_t numpages,
>>>>>>>                                 bool use_madv_populate_write)
>>>>>>>      {
>>>>>>>          static gsize initialized = 0;
>>>>>>> -    MemsetContext context = {
>>>>>>> -        .num_threads = get_memset_num_threads(hpagesize, numpages,
>>>>>>> max_threads),
>>>>>>> -    };
>>>>>>> +    MemsetContext *context = g_malloc0(sizeof(MemsetContext));
>>>>>>>          size_t numpages_per_thread, leftover;
>>>>>>>          void *(*touch_fn)(void *);
>>>>>>> -    int ret = 0, i = 0;
>>>>>>> +    int i = 0;
>>>>>>>          char *addr = area;
>>>>>>>      +    context->num_threads =
>>>>>>> +        get_memset_num_threads(hpagesize, numpages, max_threads);
>>>>>>> +
>>>>>>>          if (g_once_init_enter(&initialized)) {
>>>>>>>              qemu_mutex_init(&page_mutex);
>>>>>>>              qemu_cond_init(&page_cond);
>>>>>>> @@ -433,7 +441,7 @@ static int touch_all_pages(char *area, size_t
>>>>>>> hpagesize, size_t numpages,
>>>>>>>            if (use_madv_populate_write) {
>>>>>>>              /* Avoid creating a single thread for
>>>>>>> MADV_POPULATE_WRITE */
>>>>>>> -        if (context.num_threads == 1) {
>>>>>>> +        if (context->num_threads == 1) {
>>>>>>>                  if (qemu_madvise(area, hpagesize * numpages,
>>>>>>> QEMU_MADV_POPULATE_WRITE)) {
>>>>>>>                      return -errno;
>>>>>>> @@ -445,49 +453,74 @@ static int touch_all_pages(char *area, size_t
>>>>>>> hpagesize, size_t numpages,
>>>>>>>              touch_fn = do_touch_pages;
>>>>>>>          }
>>>>>>>      -    context.threads = g_new0(MemsetThread,
>>>>>>> context.num_threads);
>>>>>>> -    numpages_per_thread = numpages / context.num_threads;
>>>>>>> -    leftover = numpages % context.num_threads;
>>>>>>> -    for (i = 0; i < context.num_threads; i++) {
>>>>>>> -        context.threads[i].addr = addr;
>>>>>>> -        context.threads[i].numpages = numpages_per_thread + (i <
>>>>>>> leftover);
>>>>>>> -        context.threads[i].hpagesize = hpagesize;
>>>>>>> -        context.threads[i].context = &context;
>>>>>>> +    context->threads = g_new0(MemsetThread, context->num_threads);
>>>>>>> +    numpages_per_thread = numpages / context->num_threads;
>>>>>>> +    leftover = numpages % context->num_threads;
>>>>>>> +    for (i = 0; i < context->num_threads; i++) {
>>>>>>> +        context->threads[i].addr = addr;
>>>>>>> +        context->threads[i].numpages = numpages_per_thread + (i <
>>>>>>> leftover);
>>>>>>> +        context->threads[i].hpagesize = hpagesize;
>>>>>>> +        context->threads[i].context = context;
>>>>>>>              if (tc) {
>>>>>>> -            thread_context_create_thread(tc,
>>>>>>> &context.threads[i].pgthread,
>>>>>>> +            thread_context_create_thread(tc,
>>>>>>> &context->threads[i].pgthread,
>>>>>>> "touch_pages",
>>>>>>> -                                         touch_fn,
>>>>>>> &context.threads[i],
>>>>>>> +                                         touch_fn,
>>>>>>> &context->threads[i],
>>>>>>> QEMU_THREAD_JOINABLE);
>>>>>>>              } else {
>>>>>>> - qemu_thread_create(&context.threads[i].pgthread, "touch_pages",
>>>>>>> -                               touch_fn, &context.threads[i],
>>>>>>> + qemu_thread_create(&context->threads[i].pgthread, "touch_pages",
>>>>>>> +                               touch_fn, &context->threads[i],
>>>>>>> QEMU_THREAD_JOINABLE);
>>>>>>>              }
>>>>>>> -        addr += context.threads[i].numpages * hpagesize;
>>>>>>> +        addr += context->threads[i].numpages * hpagesize;
>>>>>>>          }
>>>>>>>      +    QLIST_INSERT_HEAD(&memset_contexts, context, next);
>>>>>>> +
>>>>>>>          if (!use_madv_populate_write) {
>>>>>>> -        sigbus_memset_context = &context;
>>>>>>> +        sigbus_memset_context = true;
>>>>>>
>>>>> Thanks David,
>>>>>
>>>>>> Could we just use the sigbus handling alone and support parallel init
>>>>>> only when using MADV_POPULATE_WRITE where we don't have to mess with
>>>>>> signal handlers?
>>>>>>
>>>>>
>>>>> Ideally, we're hoping to support this with earlier kernels which don't
>>>>> support MADV_POPULATE _WRITE. But, I will check to see if we really
>>>>> need it.
>>>>
>>>> That's around since Linux 5.14, so please try simplifying.
>>>>
>>>>>
>>>>>> Further, how do you changes interact with other callers of
>>>>>> qemu_prealloc_mem(), like virtio-mem?
>>>>>>
>>>>>
>>>>> I'm not familiar with the intricacies of virtio-mem, but the basic
>>>>> idea
>>>>> of this series is to *only* allow parallel init during the start up
>>>>> phase (while prealloc_init == false). Once we have parsed all the
>>>>> command line args, we set prealloc_init = true
>>>>> (wait_mem_prealloc_init()) which causes all subsequent calls to
>>>>> qemu_prealloc_mem() to perform initialization synchronously. So, I
>>>>> *think* this covers the virtio-mem use case. Am I missing something?
>>>>
>>>> Good, so this should likely not affect virtio-mem (which also ends up
>>>> preallocating memory when loading from a vmstate).
>>>>
>>>> To make this all a bit clearer, what about the following to make this:
>>>>
>>>> * Optimize for MADV_POPULATE_WRITE. If we really need support for
>>>>     !MADV_POPULATE_WRITE, this is better added on top later.
>>>> * Pass in via a parameter that the caller requests async handling.
>>>> "bool
>>>>     async" should be good enough. Then, pass that only from the memory
>>>>     backend call, while QEMU is still initializing (we can find a way to
>>>>     make that work).
>>>> * Provide a function that waits for any remaining async os-mem-prealloc
>>>>     activity. That is essentially "wait_mem_prealloc_init", but without
>>>>     the special internal flag handling.
>>>>
>>>> Further, I do wonder if we want to make that behavior configurable. For
>>>> example, one might want to initialize backends sequentially using 16
>>>> threads
>>>> max, instead of consuming multiple times 16 threads concurrently.
>>>
>>> Seems to me that no matter what parallelisation we use (within
>>> mem regions, or across mem regions, or a mix of both), we should
>>> never use more threads than there are host CPUs.
>>
>> Yes. It gets tricky with multipe NUMA nodes, though. And that's what's
>> being requested here.
>>
>>>
>>> Can we have a pool of threads sized per available host CPUs that
>>> QEMU can access. Then for each memory backend fire off a set of
>>> init jobs that get distributed to "appropriate" threads in the
>>> pool. By appropriate I mean threads with the same NUMA affinity
>>> as the memory backend. This would give parallelisation both
>>> within a single large memory region, as well as across memory
>>> regions.
>>>
>>>
>>> eg 4 host CPUs, 3 memory regions (1GB for 1st numa node, 1GB
>>> for 2nd numa node, and 1 GB with no numa affinity). If we
>>> spread the init work then we end up with
>>
>> I'll note that having a mixture of numa + no numa is not a common
>> config we should try to optimize.
>>
>>>
>>>    1st thread gets 500MB to init from 1st memory region, and
>>>        250MB to init from 3rd memory region
>>>
>>>    2st thread gets 500MB to init from 1st memory region, and
>>>        250MB to init from 3rd memory region
>>>
>>>    3st thread gets 500MB to init from 2nd memory region, and
>>>        250MB to init from 3rd memory region
>>>
>>>    4th thread gets 500MB to init from 2nd memory region, and
>>>        250MB to init from 3rd memory region
>>
>> We do have prealloc contexts that are used to craft new CPUs with the
>> right NUMA affinity. Prealloc contexts are set for memory backends. So
>> extending prealloc context to limit/reuse threads and do the pooling
>> might be possible.
>>
> 
>   From a NUMA perspective, I feel prealloc contexts already supports what
> we want - i.e. we can set the number of prealloc threads and their node
> affinity per memory region. As such, unless you feel strongly about it,
> I'm inclined to leave additional enhancements (thread pool) as a future
> project.

I tend to agree. It's uncommon to have many memory backends target the 
same NUMA node such that you would want to use pooling.

Usually, you'd expect in most vNUMA setups to have, say, 1 memory 
backend per vNUMA node that is mapped to some NUMA nodes in the parent.

Using prealloc contexts you can make sure that preallocating each 
individual one gets the right CPU affinity. Setting the prealloc threads 
you can limit the number of threads used per memory backend.

>  > Since multiple NUMA node configs are the primary motivation for parallel
> init, I do wonder if it should *only* be used in conjunction
> with prealloc context. Perhaps we should have parallel init only enabled
> for memory regions with prealloc context?

That sounds reasonable.

-- 
Cheers,

David / dhildenb


