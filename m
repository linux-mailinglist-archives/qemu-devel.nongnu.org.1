Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C2C771C1C
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 10:14:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSvN7-0007f2-AC; Mon, 07 Aug 2023 04:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qSvN5-0007et-Ny
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 04:13:47 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qSvN3-0001SV-4r
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 04:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691396025; x=1722932025;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=1P/ygiq2ZznFXTopDanu9BY2NVu37gvYGGJ8jgCgJ/I=;
 b=NllvfXoq5xvsms6JHKjYazk+f07QuvrQaHbZTfd6XVeTCNUKQk6SC0E8
 8Njdiyc4XFTZJnsNLsxf91NkfDdO2XOCeoLmmREZW4mDf+HkjnbB84wnA
 mzB86kFEGZTEREs85gJ2wWhkQLgFfnnnH+NzYkAc0Du2l7e2HmCh8BzBy
 e8rYXeyczLrP3A0hn0eqMXXjCjeJUZjBl737mXhOTeDnms48wXImIiSSE
 Yswo1lMltSWM6Hmh6TTOVP4dI9MKZ91+Zdg6JGsC0YbW4H6fepQ9LyXKU
 gXYpnhTxOLIBLtNjvBY1wKUaChYLnZ5JA7wOTjZJEL6hj/GYRUdjG+Iug Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="367942597"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; d="scan'208";a="367942597"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2023 01:13:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="854570502"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; d="scan'208";a="854570502"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.16.81])
 ([10.93.16.81])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2023 01:13:38 -0700
Message-ID: <0ae07b73-0b44-bae4-141a-947a13990daf@intel.com>
Date: Mon, 7 Aug 2023 16:13:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v3 05/17] i386/cpu: Use APIC ID offset to encode cache
 topo in CPUID[4]
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Babu Moger <babu.moger@amd.com>, Zhao Liu <zhao1.liu@intel.com>,
 Robert Hoo <robert.hu@linux.intel.com>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-6-zhao1.liu@linux.intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20230801103527.397756-6-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.93; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -84
X-Spam_score: -8.5
X-Spam_bar: --------
X-Spam_report: (-8.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-4.139,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/1/2023 6:35 PM, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Refer to the fixes of cache_info_passthrough ([1], [2]) and SDM, the
> CPUID.04H:EAX[bits 25:14] and CPUID.04H:EAX[bits 31:26] should use the
> nearest power-of-2 integer.

I doubt it. Especially for [1].

SDM doesn't state it should be the nearest power-of-2 integer.
For example, regarding EAX[25:14], what SDM states are,

1. The value needs to be added with 1
　
2. The nearest power-of-2 integer that is not smaller than 
(1+EAX[25:14]) is the number of unique initial APIC IDs reserved for 
addressing different logical processor sharing this cache.

Above indicates that

1. "EAX[25:14] + 1", indicates the real number of how many LPs sharing 
this cache. i.e., how many APIC IDs

while 2. "The nearest power-of-2 integer that is not smaller than 
(EAX[25:14] + 1)" indicates the how many APIC IDs are reserved for LPs 
sharing this cache. It doesn't require EAX[25:14] + 1, to be power of 2.

> The nearest power-of-2 integer can be caculated by pow2ceil() or by
> using APIC ID offset (like L3 topology using 1 << die_offset [3]).
> 
> But in fact, CPUID.04H:EAX[bits 25:14] and CPUID.04H:EAX[bits 31:26]
> are associated with APIC ID. For example, in linux kernel, the field
> "num_threads_sharing" (Bits 25 - 14) is parsed with APIC ID. And for
> another example, on Alder Lake P, the CPUID.04H:EAX[bits 31:26] is not
> matched with actual core numbers and it's caculated by:
> "(1 << (pkg_offset - core_offset)) - 1".
> 
> Therefore the offset of APIC ID should be preferred to caculate nearest
> power-of-2 integer for CPUID.04H:EAX[bits 25:14] and CPUID.04H:EAX[bits
> 31:26]:
> 1. d/i cache is shared in a core, 1 << core_offset should be used
>     instand of "cs->nr_threads" in encode_cache_cpuid4() for
>     CPUID.04H.00H:EAX[bits 25:14] and CPUID.04H.01H:EAX[bits 25:14].
> 2. L2 cache is supposed to be shared in a core as for now, thereby
>     1 << core_offset should also be used instand of "cs->nr_threads" in
>     encode_cache_cpuid4() for CPUID.04H.02H:EAX[bits 25:14].
> 3. Similarly, the value for CPUID.04H:EAX[bits 31:26] should also be
>     replaced by the offsets upper SMT level in APIC ID.
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
> ---
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
> index b439a05244ee..c80613bfcded 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6005,7 +6005,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>   {
>       X86CPU *cpu = env_archcpu(env);
>       CPUState *cs = env_cpu(env);
> -    uint32_t die_offset;
>       uint32_t limit;
>       uint32_t signature[3];
>       X86CPUTopoInfo topo_info;
> @@ -6089,39 +6088,56 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>                   int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
>                   int vcpus_per_socket = cs->nr_cores * cs->nr_threads;
>                   if (cs->nr_cores > 1) {
> +                    int addressable_cores_offset =
> +                                                apicid_pkg_offset(&topo_info) -
> +                                                apicid_core_offset(&topo_info);
> +
>                       *eax &= ~0xFC000000;
> -                    *eax |= (pow2ceil(cs->nr_cores) - 1) << 26;
> +                    *eax |= (1 << addressable_cores_offset - 1) << 26;
>                   }
>                   if (host_vcpus_per_cache > vcpus_per_socket) {
> +                    int pkg_offset = apicid_pkg_offset(&topo_info);
> +
>                       *eax &= ~0x3FFC000;
> -                    *eax |= (pow2ceil(vcpus_per_socket) - 1) << 14;
> +                    *eax |= (1 << pkg_offset - 1) << 14;
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


