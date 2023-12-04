Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E79AE802C24
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 08:36:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA3UT-0007G4-Ta; Mon, 04 Dec 2023 02:35:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rA3UR-0007Ft-9d
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 02:35:39 -0500
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rA3UN-0007EM-Ng
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 02:35:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701675335; x=1733211335;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=cqnx3GOOOeEnGFwr2YUHohM2BY2Tg7uefwELeHw0OWY=;
 b=Q5sUzb/x0XLDZJU6dQihKTefYfwbZYzJAu5OOJ6K7lrLfaDS8Y1JtxJn
 xV0nKpJpywod+SD9iJx4Idx5o+ZSJ/Z5BcHIXdtXmH7yfdb52N1h973hF
 NtOBHASSPQ3dG2KFR1GN6hvgeEU1rwUtPpzu088j9Az256dmuzy9O9GgC
 k7zC+4DJYlAJSCqeBoN2KjDFXV5Ioe+z/vcaId84LnbQq56fl/MyC8MRn
 BurL+V/YEe9Onm3uXXW/rA6HedVsGgnB3g0R2MnPMzTUFBjzwQyJg5+pS
 W9GvojoiLRczlT0imnqP1uDJ59E4LiH3z+pjTsUgM1XfmA2LlSwaH4biq w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="424860785"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; d="scan'208";a="424860785"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2023 23:35:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="893916998"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; d="scan'208";a="893916998"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.29.154])
 ([10.93.29.154])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2023 23:35:24 -0800
Message-ID: <4fe173c9-6be2-4850-a5a4-d2b9299278f9@intel.com>
Date: Mon, 4 Dec 2023 15:35:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/70] physmem: Relax the alignment check of
 host_startaddr in ram_block_discard_range()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, Sean Christopherson
 <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Isaku Yamahata
 <isaku.yamahata@gmail.com>, Chenyi Qiang <chenyi.qiang@intel.com>
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
 <20231115071519.2864957-8-xiaoyao.li@intel.com>
 <a61206eb-03c4-41e3-a876-bb67577e5204@redhat.com>
 <00b533ee-fbb1-4e78-bc8b-b6d87761bb92@intel.com>
 <419ffc61-fcd7-4940-a550-9ce6c6a14e1b@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <419ffc61-fcd7-4940-a550-9ce6c6a14e1b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.88; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 11/20/2023 5:56 PM, David Hildenbrand wrote:
> On 16.11.23 03:56, Xiaoyao Li wrote:
>> On 11/16/2023 2:20 AM, David Hildenbrand wrote:
>>> On 15.11.23 08:14, Xiaoyao Li wrote:
>>>> Commit d3a5038c461 ("exec: ram_block_discard_range") introduced
>>>> ram_block_discard_range() which grabs some code from
>>>> ram_discard_range(). However, during code movement, it changed 
>>>> alignment
>>>> check of host_startaddr from qemu_host_page_size to rb->page_size.
>>>>
>>>> When ramblock is back'ed by hugepage, it requires the startaddr to be
>>>> huge page size aligned, which is a overkill. e.g., TDX's private-shared
>>>> page conversion is done at 4KB granularity. Shared page is discarded
>>>> when it gets converts to private and when shared page back'ed by
>>>> hugepage it is going to fail on this check.
>>>>
>>>> So change to alignment check back to qemu_host_page_size.
>>>>
>>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>> ---
>>>> Changes in v3:
>>>>    - Newly added in v3;
>>>> ---
>>>>    system/physmem.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/system/physmem.c b/system/physmem.c
>>>> index c56b17e44df6..8a4e42c7cf60 100644
>>>> --- a/system/physmem.c
>>>> +++ b/system/physmem.c
>>>> @@ -3532,7 +3532,7 @@ int ram_block_discard_range(RAMBlock *rb,
>>>> uint64_t start, size_t length)
>>>>        uint8_t *host_startaddr = rb->host + start;
>>>> -    if (!QEMU_PTR_IS_ALIGNED(host_startaddr, rb->page_size)) {
>>>> +    if (!QEMU_PTR_IS_ALIGNED(host_startaddr, qemu_host_page_size)) {
>>>
>>> For your use cases, rb->page_size should always match 
>>> qemu_host_page_size.
>>>
>>> IIRC, we only set rb->page_size to different values for hugetlb. And
>>> guest_memfd does not support hugetlb.
>>>
>>> Even if QEMU is using THP, rb->page_size should 4k.
>>>
>>> Please elaborate how you can actually trigger that. From what I recall,
>>> guest_memfd is not compatible with hugetlb.
>>
>> It's the shared memory that can be back'ed by hugetlb.
> 
> Serious question: does that configuration make any sense to support at 
> this point? I claim: no.
> 
>>
>> Later patch 9 introduces ram_block_convert_page(), which will discard
>> shared memory when it gets converted to private. TD guest can request
>> convert a 4K to private while the page is previously back'ed by hugetlb
>> as 2M shared page.
> 
> So you can call ram_block_discard_guest_memfd_range() on subpage basis, 
> but not ram_block_discard_range().
> 
> ram_block_convert_range() would have to thought that that (questionable) 
> combination of hugetlb for shmem and ordinary pages for guest_memfd 
> cannot discard shared memory.
> 
> And it probably shouldn't either way. There are other problems when not 
> using hugetlb along with preallocation.

If I understand correctly, preallocation needs to be enabled for 
hugetlb. And in preallocation case, it doesn't need to discard memory. 
Is it correct?

> The check in ram_block_discard_range() is correct, whoever ends up 
> calling it has to stop calling it.
> 

So, I need add logic to ram_block_discard_page() that if the size of 
shared memory indicates hugepage, skip the discarding?


