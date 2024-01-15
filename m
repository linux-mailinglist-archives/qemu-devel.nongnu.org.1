Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 982B682D3A4
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 05:28:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPEZu-0000iW-8i; Sun, 14 Jan 2024 23:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rPEZo-0000fH-PI
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 23:27:57 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rPEZm-00087R-4Y
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 23:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705292874; x=1736828874;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ADNYX0sXyhJEQBPOP1j26AhT59aSb/3DLJMQn2Rse24=;
 b=NR3pwkvk0KNsYtYCQT10/OEz0e8e2Fk2gVB1sYzcO707fFEOuVFd4dQW
 qAzEwSQ6ZmJBEPaiQq8wTfGDwoJVz3jAg9D0GhvqFDGH7JqJgR+/YqrVv
 vSqsXvIS6QoTatL7XJOqOfAVTGzuXzdARpw60R5/1Q6QUtOnlkzErNw3B
 KbGipDhiSq5kXc6PPTZE0gXDwBR2qvjpgVLUoKu6keOC+D0xb0Bq9CkPf
 kMcawREKho7rtVddSyLBUy9CKtlf3Opvbfp2RfldRPRxwkANLWTvkRTOo
 Y0e1Sg6uUDwPOxo6XIPYVFR5vjIMWqVXmPBI3zvuItS5JQl9MmtsvapAc g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="6245809"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="6245809"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 20:27:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; d="scan'208";a="25666142"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.22.149])
 ([10.93.22.149])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 20:27:46 -0800
Message-ID: <23c5eb57-d086-4e51-bfdf-a3019aad1c29@intel.com>
Date: Mon, 15 Jan 2024 12:27:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 15/16] i386: Use offsets get NumSharingCache for
 CPUID[0x8000001D].EAX[bits 25:14]
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Babu Moger <babu.moger@amd.com>, Yongwei Ma <yongwei.ma@intel.com>
References: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
 <20240108082727.420817-16-zhao1.liu@linux.intel.com>
 <599ddf2d-dc2e-4684-b2c2-ba6dfd886f32@intel.com> <ZaSrKB3y9TEJZG5T@intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZaSrKB3y9TEJZG5T@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998, SPF_HELO_NONE=0.001,
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

On 1/15/2024 11:48 AM, Zhao Liu wrote:
> Hi Xiaoyao,
> 
> On Sun, Jan 14, 2024 at 10:42:41PM +0800, Xiaoyao Li wrote:
>> Date: Sun, 14 Jan 2024 22:42:41 +0800
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>> Subject: Re: [PATCH v7 15/16] i386: Use offsets get NumSharingCache for
>>   CPUID[0x8000001D].EAX[bits 25:14]
>>
>> On 1/8/2024 4:27 PM, Zhao Liu wrote:
>>> From: Zhao Liu <zhao1.liu@intel.com>
>>>
>>> The commit 8f4202fb1080 ("i386: Populate AMD Processor Cache Information
>>> for cpuid 0x8000001D") adds the cache topology for AMD CPU by encoding
>>> the number of sharing threads directly.
>>>
>>>   From AMD's APM, NumSharingCache (CPUID[0x8000001D].EAX[bits 25:14])
>>> means [1]:
>>>
>>> The number of logical processors sharing this cache is the value of
>>> this field incremented by 1. To determine which logical processors are
>>> sharing a cache, determine a Share Id for each processor as follows:
>>>
>>> ShareId = LocalApicId >> log2(NumSharingCache+1)
>>>
>>> Logical processors with the same ShareId then share a cache. If
>>> NumSharingCache+1 is not a power of two, round it up to the next power
>>> of two.
>>>
>>>   From the description above, the calculation of this field should be same
>>> as CPUID[4].EAX[bits 25:14] for Intel CPUs. So also use the offsets of
>>> APIC ID to calculate this field.
>>>
>>> [1]: APM, vol.3, appendix.E.4.15 Function 8000_001Dh--Cache Topology
>>>        Information
>>
>> this patch can be dropped because we have next patch.
> 
> This patch is mainly used to explicitly emphasize the change in encoding
> way and compliance with AMD spec... I didn't tested on AMD machine, so
> the more granular patch would make it easier for the community to review
> and test.

then please move this patch ahead, e.g., after patch 2.

> Thanks,
> Zhao
> 
>>
>>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>>> Reviewed-by: Babu Moger <babu.moger@amd.com>
>>> Tested-by: Babu Moger <babu.moger@amd.com>
>>> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>> Changes since v3:
>>>    * Rewrite the subject. (Babu)
>>>    * Delete the original "comment/help" expression, as this behavior is
>>>      confirmed for AMD CPUs. (Babu)
>>>    * Rename "num_apic_ids" (v3) to "num_sharing_cache" to match spec
>>>      definition. (Babu)
>>>
>>> Changes since v1:
>>>    * Rename "l3_threads" to "num_apic_ids" in
>>>      encode_cache_cpuid8000001d(). (Yanan)
>>>    * Add the description of the original commit and add Cc.
>>> ---
>>>    target/i386/cpu.c | 10 ++++------
>>>    1 file changed, 4 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index b23e8190dc68..8a4d72f6f760 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -483,7 +483,7 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
>>>                                           uint32_t *eax, uint32_t *ebx,
>>>                                           uint32_t *ecx, uint32_t *edx)
>>>    {
>>> -    uint32_t l3_threads;
>>> +    uint32_t num_sharing_cache;
>>>        assert(cache->size == cache->line_size * cache->associativity *
>>>                              cache->partitions * cache->sets);
>>> @@ -492,13 +492,11 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
>>>        /* L3 is shared among multiple cores */
>>>        if (cache->level == 3) {
>>> -        l3_threads = topo_info->modules_per_die *
>>> -                     topo_info->cores_per_module *
>>> -                     topo_info->threads_per_core;
>>> -        *eax |= (l3_threads - 1) << 14;
>>> +        num_sharing_cache = 1 << apicid_die_offset(topo_info);
>>>        } else {
>>> -        *eax |= ((topo_info->threads_per_core - 1) << 14);
>>> +        num_sharing_cache = 1 << apicid_core_offset(topo_info);
>>>        }
>>> +    *eax |= (num_sharing_cache - 1) << 14;
>>>        assert(cache->line_size > 0);
>>>        assert(cache->partitions > 0);
>>


