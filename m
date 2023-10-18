Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4B57CD764
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 11:03:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt2Rq-0006Yy-F9; Wed, 18 Oct 2023 05:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qt2Rb-0006YR-Qt
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:02:23 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qt2RY-0003aY-M3
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697619741; x=1729155741;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=B6LH3qypfS6IkyLJ99c5BzJdh0fkueEcO4ciBzI4ANk=;
 b=e4fqOLihbEgxU08C/aKqmS6K4qPhTtAgSpEdqWU1+x0QkSJFOwiP7VJb
 NeqVESIpWA13nhTs5b1GWxPJwqyQmu14fegF0nEOAkwBGMVtihbhS12Ue
 VhyxmqsRaItGz8W7dZQH1fJp6PeXJ0ro/to60efOCNsp5EqAr9l1Aecm0
 72XnA8i6Ujxi2PZ3xHnZWgv3RAqlX69GZlwc9dnn7iz/3M2S6YUKO+JSS
 ytsiqD0a1OVPMopSsRMHQmKujWY6Bb1fTJxvM4zxDfShsQhkyySUrqZfe
 5SFWgDAJ39fsJbLs4beO9VFOrvrdtx5IZGEbh6vYgOfCYnl7wR3rwMoOg w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="4569030"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="4569030"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2023 02:02:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="880153060"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; d="scan'208";a="880153060"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.19.128])
 ([10.93.19.128])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2023 02:02:14 -0700
Message-ID: <23d209c1-f860-4915-935e-816d9077b65c@intel.com>
Date: Wed, 18 Oct 2023 17:02:11 +0800
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
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <e96e96a2-e996-4507-8548-684aa1e56846@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
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

On 10/18/2023 3:42 PM, David Hildenbrand wrote:
> On 18.10.23 05:02, Xiaoyao Li wrote:
>> David,
>>
>> On 7/6/2023 3:56 PM, David Hildenbrand wrote:
>>> ram_block_discard_range() cannot possibly do the right thing in
>>> MAP_PRIVATE file mappings in the general case.
>>>
>>> To achieve the documented semantics, we also have to punch a hole into
>>> the file, possibly messing with other MAP_PRIVATE/MAP_SHARED mappings
>>> of such a file.
>>>
>>> For example, using VM templating -- see commit b17fbbe55cba ("migration:
>>> allow private destination ram with x-ignore-shared") -- in 
>>> combination with
>>> any mechanism that relies on discarding of RAM is problematic. This
>>> includes:
>>> * Postcopy live migration
>>> * virtio-balloon inflation/deflation or free-page-reporting
>>> * virtio-mem
>>>
>>> So at least warn that there is something possibly dangerous is going on
>>> when using ram_block_discard_range() in these cases.
>>>
>>> Acked-by: Peter Xu <peterx@redhat.com>
>>> Tested-by: Mario Casquero <mcasquer@redhat.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>    softmmu/physmem.c | 18 ++++++++++++++++++
>>>    1 file changed, 18 insertions(+)
>>>
>>> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
>>> index bda475a719..4ee157bda4 100644
>>> --- a/softmmu/physmem.c
>>> +++ b/softmmu/physmem.c
>>> @@ -3456,6 +3456,24 @@ int ram_block_discard_range(RAMBlock *rb, 
>>> uint64_t start, size_t length)
>>>                 * so a userfault will trigger.
>>>                 */
>>>    #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
>>> +            /*
>>> +             * We'll discard data from the actual file, even though 
>>> we only
>>> +             * have a MAP_PRIVATE mapping, possibly messing with other
>>> +             * MAP_PRIVATE/MAP_SHARED mappings. There is no easy way to
>>> +             * change that behavior whithout violating the promised
>>> +             * semantics of ram_block_discard_range().
>>> +             *
>>> +             * Only warn, because it work as long as nobody else 
>>> uses that
>>> +             * file.
>>> +             */
>>> +            if (!qemu_ram_is_shared(rb)) {
>>> +                warn_report_once("ram_block_discard_range: 
>>> Discarding RAM"
>>> +                                 " in private file mappings is 
>>> possibly"
>>> +                                 " dangerous, because it will modify 
>>> the"
>>> +                                 " underlying file and will affect 
>>> other"
>>> +                                 " users of the file");
>>> +            }
>>> +
>>
>> TDX has two types of memory backend for each RAM, shared memory and
>> private memory. Private memory is serviced by guest memfd and shared
>> memory can also be backed with a fd.
>>
>> At any time, only one type needs to be valid, which means the opposite
>> can be discarded. We do implement the memory discard when TDX converts
>> the memory[1]. It will trigger this warning 100% because by default the
>> guest memfd is not mapped as shared (MAP_SHARED).
> 
> If MAP_PRIVATE is not involved and you are taking the pages directly out 
> of the memfd, you should mark that thing as shared. 

Is it the general rule of Linux? Of just the rule of QEMU memory discard?

> Anonymous memory is never involved.

Could you please elaborate more on this? What do you want to express 
here regrading anonymous memory? (Sorry that I'm newbie for mmap stuff)

> 
> "Private memory" is only private from the guest POV, not from a mmap() 
> point of view.
> 
> Two different concepts of "private".
> 
>>
>> Simply remove the warning will fail the purpose of this patch. The other
>> option is to skip the warning for TDX case, which looks vary hacky. Do
>> you have any idea?
> 
> For TDX, all memory backends / RAMBlocks should be marked as "shared", 
> and you should fail if that is not provided by the user.

As I asked above, I want to understand the logic clearly. Is mapped as 
shared is a must to support the memory discard? i.e., if we want to 
support memory discard after memory type change, then the memory must be 
mapped with MAP_SHARED?



