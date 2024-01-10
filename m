Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BD4829658
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:33:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUwB-0007Ed-Oy; Wed, 10 Jan 2024 04:31:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rNUw5-0007Dh-Po
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:31:45 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rNUw3-0000xq-S7
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:31:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704879104; x=1736415104;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=/ygn6JtmrinRVkGJ8YnVjTEcwrCjm9jo5L/XJXXDOvA=;
 b=Gc6yyC+XK6ZHoLdIWBscOLWWN2AajCvb1M5Gu3BmZq8kTtSmCNRNr+1N
 qvM3PEwANft5eByiT8HvJQqH9J3HUF/2dLfltNbR2FpAkmBGZSuK4xuZF
 OGy/Vq6JkTpsroyqCVZb4VMWZepL7DIQlYdwMgD21qYUX1uMqJO6jZap4
 stsxEi4BQfvZvIETM6UPS71+IJdly2i7NMZ9kFs4IrQ9bZC5VgjHC5zyL
 SI0XlTac5exORjXaJt/gGhfiGxb/qZl10yQtlPiJfQzx7agEbuGm4MJIC
 UzfwsqZ20pwER4/8NiKDxxkEPsJ4MTOFE6KIszVv6/WQwifR1+innS6WK w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5830136"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5830136"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jan 2024 01:31:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="785544000"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; d="scan'208";a="785544000"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.22.149])
 ([10.93.22.149])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jan 2024 01:31:32 -0800
Message-ID: <f5202ebd-6bc8-44b1-b22b-f3a033e0f283@intel.com>
Date: Wed, 10 Jan 2024 17:31:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/16] i386/cpu: Use APIC ID offset to encode cache
 topo in CPUID[4]
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Robert Hoo <robert.hu@linux.intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>
References: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
 <20240108082727.420817-3-zhao1.liu@linux.intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240108082727.420817-3-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, SPF_HELO_NONE=0.001,
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

On 1/8/2024 4:27 PM, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Refer to the fixes of cache_info_passthrough ([1], [2]) and SDM, the
> CPUID.04H:EAX[bits 25:14] and CPUID.04H:EAX[bits 31:26] should use the
> nearest power-of-2 integer.
> 
> The nearest power-of-2 integer can be calculated by pow2ceil() or by
> using APIC ID offset (like L3 topology using 1 << die_offset [3]).
> 
> But in fact, CPUID.04H:EAX[bits 25:14] and CPUID.04H:EAX[bits 31:26]
> are associated with APIC ID. For example, in linux kernel, the field
> "num_threads_sharing" (Bits 25 - 14) is parsed with APIC ID. 

And for
> another example, on Alder Lake P, the CPUID.04H:EAX[bits 31:26] is not
> matched with actual core numbers and it's calculated by:
> "(1 << (pkg_offset - core_offset)) - 1".

could you elaborate it more? what is the value of actual core numbers on 
Alder lake P? and what is the pkg_offset and core_offset?

> Therefore the offset of APIC ID should be preferred to calculate nearest
> power-of-2 integer for CPUID.04H:EAX[bits 25:14] and CPUID.04H:EAX[bits
> 31:26]:
> 1. d/i cache is shared in a core, 1 << core_offset should be used
>     instand of "cs->nr_threads" in encode_cache_cpuid4() for

/s/instand/instead

>     CPUID.04H.00H:EAX[bits 25:14] and CPUID.04H.01H:EAX[bits 25:14].
> 2. L2 cache is supposed to be shared in a core as for now, thereby
>     1 << core_offset should also be used instand of "cs->nr_threads" in

ditto

>     encode_cache_cpuid4() for CPUID.04H.02H:EAX[bits 25:14].
> 3. Similarly, the value for CPUID.04H:EAX[bits 31:26] should also be
>     calculated with the bit width between the Package and SMT levels in
>     the APIC ID (1 << (pkg_offset - core_offset) - 1).
> 
> In addition, use APIC ID offset to replace "pow2ceil()" for
> cache_info_passthrough case.
> 
> [1]: efb3934adf9e ("x86: cpu: make sure number of addressable IDs for processor cores meets the spec")
> [2]: d7caf13b5fcf ("x86: cpu: fixup number of addressable IDs for logical processors sharing cache")
> [3]: d65af288a84d ("i386: Update new x86_apicid parsing rules with die_offset support")
> 
> Fixes: 7e3482f82480 ("i386: Helpers to encode cache information consistently")
> Suggested-by: Robert Hoo <robert.hu@linux.intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Tested-by: Babu Moger <babu.moger@amd.com>
> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> Changes since v3:
>   * Fix compile warnings. (Babu)
>   * Fix spelling typo.
> 
> Changes since v1:
>   * Use APIC ID offset to replace "pow2ceil()" for cache_info_passthrough
>     case. (Yanan)
>   * Split the L1 cache fix into a separate patch.
>   * Rename the title of this patch (the original is "i386/cpu: Fix number
>     of addressable IDs in CPUID.04H").
> ---
>   target/i386/cpu.c | 30 +++++++++++++++++++++++-------
>   1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 5a3678a789cf..c8d2a585723a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6014,7 +6014,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>   {
>       X86CPU *cpu = env_archcpu(env);
>       CPUState *cs = env_cpu(env);
> -    uint32_t die_offset;
>       uint32_t limit;
>       uint32_t signature[3];
>       X86CPUTopoInfo topo_info;
> @@ -6098,39 +6097,56 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>                   int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
>                   int vcpus_per_socket = cs->nr_cores * cs->nr_threads;
>                   if (cs->nr_cores > 1) {
> +                    int addressable_cores_offset =
> +                                                apicid_pkg_offset(&topo_info) -
> +                                                apicid_core_offset(&topo_info);
> +
>                       *eax &= ~0xFC000000;
> -                    *eax |= (pow2ceil(cs->nr_cores) - 1) << 26;
> +                    *eax |= (1 << (addressable_cores_offset - 1)) << 26;

it should be ((1 << addressable_cores_offset) - 1) << 26

I think naming it addressable_cores_width is better than 
addressable_cores_offset. It's not offset because offset means the bit 
position from bit 0.

And we can get the width by another algorithm:

int addressable_cores_width = apicid_core_width(&topo_info) + 
apicid_die_width(&topo_info);
*eax |= ((1 << addressable_cores_width) - 1)) << 26;
		
>                   }
>                   if (host_vcpus_per_cache > vcpus_per_socket) {
> +                    int pkg_offset = apicid_pkg_offset(&topo_info);
> +
>                       *eax &= ~0x3FFC000;
> -                    *eax |= (pow2ceil(vcpus_per_socket) - 1) << 14;
> +                    *eax |= (1 << (pkg_offset - 1)) << 14;

Ditto, ((1 << pkg_offset) - 1) << 14

For this one, I think pow2ceil(vcpus_per_socket) is better. Because it's 
intuitive that when host_vcpus_per_cache > vcpus_per_socket, we expose 
vcpus_per_cache (configured by users) to VM.

>                   }
>               }
>           } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
>               *eax = *ebx = *ecx = *edx = 0;
>           } else {
>               *eax = 0;
> +            int addressable_cores_offset = apicid_pkg_offset(&topo_info) -
> +                                           apicid_core_offset(&topo_info);
> +            int core_offset, die_offset;
> +
>               switch (count) {
>               case 0: /* L1 dcache info */
> +                core_offset = apicid_core_offset(&topo_info);
>                   encode_cache_cpuid4(env->cache_info_cpuid4.l1d_cache,
> -                                    cs->nr_threads, cs->nr_cores,
> +                                    (1 << core_offset),
> +                                    (1 << addressable_cores_offset),
>                                       eax, ebx, ecx, edx);
>                   break;
>               case 1: /* L1 icache info */
> +                core_offset = apicid_core_offset(&topo_info);
>                   encode_cache_cpuid4(env->cache_info_cpuid4.l1i_cache,
> -                                    cs->nr_threads, cs->nr_cores,
> +                                    (1 << core_offset),
> +                                    (1 << addressable_cores_offset),
>                                       eax, ebx, ecx, edx);
>                   break;
>               case 2: /* L2 cache info */
> +                core_offset = apicid_core_offset(&topo_info);
>                   encode_cache_cpuid4(env->cache_info_cpuid4.l2_cache,
> -                                    cs->nr_threads, cs->nr_cores,
> +                                    (1 << core_offset),
> +                                    (1 << addressable_cores_offset),
>                                       eax, ebx, ecx, edx);
>                   break;
>               case 3: /* L3 cache info */
>                   die_offset = apicid_die_offset(&topo_info);
>                   if (cpu->enable_l3_cache) {
>                       encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
> -                                        (1 << die_offset), cs->nr_cores,
> +                                        (1 << die_offset),
> +                                        (1 << addressable_cores_offset),
>                                           eax, ebx, ecx, edx);
>                       break;
>                   }


