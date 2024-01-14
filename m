Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB3E82D0D8
	for <lists+qemu-devel@lfdr.de>; Sun, 14 Jan 2024 15:13:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rP1Dk-0000li-Np; Sun, 14 Jan 2024 09:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rP1Dh-0000lM-76
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 09:12:13 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rP1De-0004ZR-Ja
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 09:12:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705241530; x=1736777530;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=UjJ5O13bpswRlqJejMMM1pLz358xGiXN9MKXNXFh3/E=;
 b=hsdWYUhonlCub8L+Xml/h5Ybsu3+XzvnJfGKBeIvoIkt1bHZ738sw/Hw
 bxJExUuyekCup+YETxoJw1YHysa3zOYVfkEf/onmtYZzO762MSkW4D1fB
 dARdwV8oZBg7EYhxOt2SIw6FIqjXuHrAz5YlehaGwSmdnzNKForsV2r/d
 11GwoutcoHUY01x4aioB4w0PefDgN4vVyOyLD/U9POdwCBH/0GEtMNonW
 3VlI/F03Rx4kQJ19HIOs9uyvle1IkTncKWSkX718Eb4X0yMaF+ySfueyI
 y5072D/tO9dKFgzPVY8167u6zxA/DT3J3E7afqyS6ZFvzF/mrysRsk5ps A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="6180356"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="6180356"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 06:12:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="783552779"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; d="scan'208";a="783552779"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.22.149])
 ([10.93.22.149])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 06:12:02 -0800
Message-ID: <a2ee40c0-a198-41cd-86af-7ef52e6d591f@intel.com>
Date: Sun, 14 Jan 2024 22:11:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/16] i386/cpu: Use APIC ID offset to encode cache
 topo in CPUID[4]
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
 Robert Hoo <robert.hu@linux.intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>
References: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
 <20240108082727.420817-3-zhao1.liu@linux.intel.com>
 <f5202ebd-6bc8-44b1-b22b-f3a033e0f283@intel.com> <ZZ+qGfykupOEFPA2@intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZZ+qGfykupOEFPA2@intel.com>
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

On 1/11/2024 4:43 PM, Zhao Liu wrote:
> Hi Xiaoyao,
> 
> On Wed, Jan 10, 2024 at 05:31:28PM +0800, Xiaoyao Li wrote:
>> Date: Wed, 10 Jan 2024 17:31:28 +0800
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>> Subject: Re: [PATCH v7 02/16] i386/cpu: Use APIC ID offset to encode cache
>>   topo in CPUID[4]
>>
>> On 1/8/2024 4:27 PM, Zhao Liu wrote:
>>> From: Zhao Liu <zhao1.liu@intel.com>
>>>
>>> Refer to the fixes of cache_info_passthrough ([1], [2]) and SDM, the
>>> CPUID.04H:EAX[bits 25:14] and CPUID.04H:EAX[bits 31:26] should use the
>>> nearest power-of-2 integer.
>>>
>>> The nearest power-of-2 integer can be calculated by pow2ceil() or by
>>> using APIC ID offset (like L3 topology using 1 << die_offset [3]).
>>>
>>> But in fact, CPUID.04H:EAX[bits 25:14] and CPUID.04H:EAX[bits 31:26]
>>> are associated with APIC ID. For example, in linux kernel, the field
>>> "num_threads_sharing" (Bits 25 - 14) is parsed with APIC ID.
>>
>> And for
>>> another example, on Alder Lake P, the CPUID.04H:EAX[bits 31:26] is not
>>> matched with actual core numbers and it's calculated by:
>>> "(1 << (pkg_offset - core_offset)) - 1".
>>
>> could you elaborate it more? what is the value of actual core numbers on
>> Alder lake P? and what is the pkg_offset and core_offset?
> 
> For example, the following's the CPUID dump of an ADL-S machine:
> 
> CPUID.04H:
> 
> 0x00000004 0x00: eax=0xfc004121 ebx=0x01c0003f ecx=0x0000003f edx=0x00000000
> 0x00000004 0x01: eax=0xfc004122 ebx=0x01c0003f ecx=0x0000007f edx=0x00000000
> 0x00000004 0x02: eax=0xfc01c143 ebx=0x03c0003f ecx=0x000007ff edx=0x00000000
> 0x00000004 0x03: eax=0xfc1fc163 ebx=0x0240003f ecx=0x00009fff edx=0x00000004
> 0x00000004 0x04: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 edx=0x00000000
> 
> 
> CPUID.1FH:
> 
> 0x0000001f 0x00: eax=0x00000001 ebx=0x00000001 ecx=0x00000100 edx=0x0000004c
> 0x0000001f 0x01: eax=0x00000007 ebx=0x00000014 ecx=0x00000201 edx=0x0000004c
> 0x0000001f 0x02: eax=0x00000000 ebx=0x00000000 ecx=0x00000002 edx=0x0000004c
> 
> The CPUID.04H:EAX[bits 31:26] is 63.
>  From CPUID.1FH.00H:EAX[bits 04:00], the core_offset is 1, and from
> CPUID.1FH.01H:EAX[bits 04:00], the pkg_offset is 7.
> 
> Thus we can verify that the above equation as:
> 
> 1 << (0x7 - 0x1) - 1 = 63.
> 
> "Maximum number of addressable IDs" refers to the maximum number of IDs
> that can be enumerated in the APIC ID's topology layout, which does not
> necessarily correspond to the actual number of topology domains.
> 
>>
>>> Therefore the offset of APIC ID should be preferred to calculate nearest
>>> power-of-2 integer for CPUID.04H:EAX[bits 25:14] and CPUID.04H:EAX[bits
>>> 31:26]:
>>> 1. d/i cache is shared in a core, 1 << core_offset should be used
>>>      instand of "cs->nr_threads" in encode_cache_cpuid4() for
>>
>> /s/instand/instead
> 
> Thanks!
> 
>>
>>>      CPUID.04H.00H:EAX[bits 25:14] and CPUID.04H.01H:EAX[bits 25:14].
>>> 2. L2 cache is supposed to be shared in a core as for now, thereby
>>>      1 << core_offset should also be used instand of "cs->nr_threads" in
>>
>> ditto
> 
> Okay.
> 
>>
>>>      encode_cache_cpuid4() for CPUID.04H.02H:EAX[bits 25:14].
>>> 3. Similarly, the value for CPUID.04H:EAX[bits 31:26] should also be
>>>      calculated with the bit width between the Package and SMT levels in
>>>      the APIC ID (1 << (pkg_offset - core_offset) - 1).
>>>
>>> In addition, use APIC ID offset to replace "pow2ceil()" for
>>> cache_info_passthrough case.
>>>
>>> [1]: efb3934adf9e ("x86: cpu: make sure number of addressable IDs for processor cores meets the spec")
>>> [2]: d7caf13b5fcf ("x86: cpu: fixup number of addressable IDs for logical processors sharing cache")
>>> [3]: d65af288a84d ("i386: Update new x86_apicid parsing rules with die_offset support")
>>>
>>> Fixes: 7e3482f82480 ("i386: Helpers to encode cache information consistently")
>>> Suggested-by: Robert Hoo <robert.hu@linux.intel.com>
>>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>>> Tested-by: Babu Moger <babu.moger@amd.com>
>>> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>> Changes since v3:
>>>    * Fix compile warnings. (Babu)
>>>    * Fix spelling typo.
>>>
>>> Changes since v1:
>>>    * Use APIC ID offset to replace "pow2ceil()" for cache_info_passthrough
>>>      case. (Yanan)
>>>    * Split the L1 cache fix into a separate patch.
>>>    * Rename the title of this patch (the original is "i386/cpu: Fix number
>>>      of addressable IDs in CPUID.04H").
>>> ---
>>>    target/i386/cpu.c | 30 +++++++++++++++++++++++-------
>>>    1 file changed, 23 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index 5a3678a789cf..c8d2a585723a 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -6014,7 +6014,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>>    {
>>>        X86CPU *cpu = env_archcpu(env);
>>>        CPUState *cs = env_cpu(env);
>>> -    uint32_t die_offset;
>>>        uint32_t limit;
>>>        uint32_t signature[3];
>>>        X86CPUTopoInfo topo_info;
>>> @@ -6098,39 +6097,56 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>>                    int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
>>>                    int vcpus_per_socket = cs->nr_cores * cs->nr_threads;
>>>                    if (cs->nr_cores > 1) {
>>> +                    int addressable_cores_offset =
>>> +                                                apicid_pkg_offset(&topo_info) -
>>> +                                                apicid_core_offset(&topo_info);
>>> +
>>>                        *eax &= ~0xFC000000;
>>> -                    *eax |= (pow2ceil(cs->nr_cores) - 1) << 26;
>>> +                    *eax |= (1 << (addressable_cores_offset - 1)) << 26;
>>
>> it should be ((1 << addressable_cores_offset) - 1) << 26
> 
> Good catch! The helper wrapped in a subsequent patch masks the error here.
> 
>>
>> I think naming it addressable_cores_width is better than
>> addressable_cores_offset. It's not offset because offset means the bit
>> position from bit 0.
> 
> I agree, "width" is better.
> 
>>
>> And we can get the width by another algorithm:
>>
>> int addressable_cores_width = apicid_core_width(&topo_info) +
>> apicid_die_width(&topo_info);
>> *eax |= ((1 << addressable_cores_width) - 1)) << 26;
> 
> This algorithm lacks flexibility because there will be more topology
> levels between package and core, such as the cluster being introduced...
> 
> Using "addressable_cores_width" is clear enough.
> 
>> 		
>>>                    }
>>>                    if (host_vcpus_per_cache > vcpus_per_socket) {
>>> +                    int pkg_offset = apicid_pkg_offset(&topo_info);
>>> +
>>>                        *eax &= ~0x3FFC000;
>>> -                    *eax |= (pow2ceil(vcpus_per_socket) - 1) << 14;
>>> +                    *eax |= (1 << (pkg_offset - 1)) << 14;
>>
>> Ditto, ((1 << pkg_offset) - 1) << 14
> 
> Thanks!
> 
>>
>> For this one, I think pow2ceil(vcpus_per_socket) is better. Because it's
>> intuitive that when host_vcpus_per_cache > vcpus_per_socket, we expose
>> vcpus_per_cache (configured by users) to VM.
> 
> I tend to use a uniform calculation that is less confusing and easier to
> maintain. 

less confusing?

the original code is

	if (host_vcpus_per_cache > vcpus_per_socket) {
		*eax |= (pow2ceil(vcpus_per_socket) - 1) << 14;
	}

and this patch is going to change it to

	if (host_vcpus_per_cache > vcpus_per_socket) {
		int pkg_offset = apicid_pkg_offset(&topo_info);
		*eax |= (1 << pkg_offset - 1)) << 14;
	}

Apparently, the former is clearer that everyone knows what is wants to 
do is "when guest's total vcpus_per_socket is even smaller than host's 
vcpu_per_cache, using guest's configuration". While the latter is more 
confusing.

> Since this field encodes "Maximum number of addressable IDs",
> OS can't get the exact number of CPUs/vCPUs sharing L3 from here, it can
> only know that L3 is shared at the package level.

It doesn't matter with L3. What the code want to fulfill is that,

host_vcpus_per_cache is the actual number of LPs that share this level 
of cache. While vcpus_per_socket is the maximum numbere of LPs that can 
share a cache (at any level) in guest. When guest's maximum number is 
even smaller than host's, use guest's value.

> Thanks,
> Zhao
> 


