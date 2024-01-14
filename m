Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F400782D0E7
	for <lists+qemu-devel@lfdr.de>; Sun, 14 Jan 2024 15:33:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rP1X3-0005AY-6d; Sun, 14 Jan 2024 09:32:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rP1Wt-0005AD-T0
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 09:32:04 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rP1Wq-0006E3-Nq
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 09:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705242719; x=1736778719;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=j6+Urk3lkm3T5NcmHM8cKKiAlRUgQrRUD/6ylVMNn3I=;
 b=JOzCMPuDhAV2R+wT4LggI1oz1RWKBCkMQlHKk6N++0ozHjWFwEVVPuSd
 dYuvgCH0ESfpATLw1cBos97fZNQZ7k9aL7cyZdaJ92HmKoiYScoiJqv+O
 vKwZeS/0561GVLANH6/GocFMZEdzfl3S5IyIqdvDZkidvjFNiLc93AMDZ
 gXa94sOpVDvH6ZNEdraVsP4ev/wniTUEs5XT0hssRHz3GSxr/sODfUU4i
 ZNf79IOsh8zKenOOV372G1ZHubqeboYvalnFrNDpCjWtAlXvXMaXvHfm+
 IXi/95yEuz9UCh88ZS5wfMUuJwtitXZi28Lgkg30NSuEhxHesDoVkyS7Y A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="6559359"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="6559359"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 06:31:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="906806193"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; d="scan'208";a="906806193"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.22.149])
 ([10.93.22.149])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 06:31:52 -0800
Message-ID: <a0cd67f2-94f2-4c4b-9212-6b7344163660@intel.com>
Date: Sun, 14 Jan 2024 22:31:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/16] i386: Use CPUCacheInfo.share_level to encode
 CPUID[4]
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
 Babu Moger <babu.moger@amd.com>, Yongwei Ma <yongwei.ma@intel.com>
References: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
 <20240108082727.420817-15-zhao1.liu@linux.intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240108082727.420817-15-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
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

On 1/8/2024 4:27 PM, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> CPUID[4].EAX[bits 25:14] is used to represent the cache topology for
> Intel CPUs.
> 
> After cache models have topology information, we can use
> CPUCacheInfo.share_level to decide which topology level to be encoded
> into CPUID[4].EAX[bits 25:14].
> 
> And since maximum_processor_id (original "num_apic_ids") is parsed
> based on cpu topology levels, which are verified when parsing smp, it's
> no need to check this value by "assert(num_apic_ids > 0)" again, so
> remove this assert.
> 
> Additionally, wrap the encoding of CPUID[4].EAX[bits 31:26] into a
> helper to make the code cleaner.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Tested-by: Babu Moger <babu.moger@amd.com>
> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> Changes since v1:
>   * Use "enum CPUTopoLevel share_level" as the parameter in
>     max_processor_ids_for_cache().
>   * Make cache_into_passthrough case also use
>     max_processor_ids_for_cache() and max_core_ids_in_package() to
>     encode CPUID[4]. (Yanan)
>   * Rename the title of this patch (the original is "i386: Use
>     CPUCacheInfo.share_level to encode CPUID[4].EAX[bits 25:14]").
> ---
>   target/i386/cpu.c | 70 +++++++++++++++++++++++++++++------------------
>   1 file changed, 43 insertions(+), 27 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 81e07474acef..b23e8190dc68 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -235,22 +235,53 @@ static uint8_t cpuid2_cache_descriptor(CPUCacheInfo *cache)
>                          ((t) == UNIFIED_CACHE) ? CACHE_TYPE_UNIFIED : \
>                          0 /* Invalid value */)
>   
> +static uint32_t max_processor_ids_for_cache(X86CPUTopoInfo *topo_info,
> +                                            enum CPUTopoLevel share_level)

I prefer the name to max_lp_ids_share_the_cache()

> +{
> +    uint32_t num_ids = 0;
> +
> +    switch (share_level) {
> +    case CPU_TOPO_LEVEL_CORE:
> +        num_ids = 1 << apicid_core_offset(topo_info);
> +        break;
> +    case CPU_TOPO_LEVEL_DIE:
> +        num_ids = 1 << apicid_die_offset(topo_info);
> +        break;
> +    case CPU_TOPO_LEVEL_PACKAGE:
> +        num_ids = 1 << apicid_pkg_offset(topo_info);
> +        break;
> +    default:
> +        /*
> +         * Currently there is no use case for SMT and MODULE, so use
> +         * assert directly to facilitate debugging.
> +         */
> +        g_assert_not_reached();
> +    }
> +
> +    return num_ids - 1;

suggest to just return num_ids, and let the caller to do the -1 work.

> +}
> +
> +static uint32_t max_core_ids_in_package(X86CPUTopoInfo *topo_info)
> +{
> +    uint32_t num_cores = 1 << (apicid_pkg_offset(topo_info) -
> +                               apicid_core_offset(topo_info));
> +    return num_cores - 1;

ditto.

> +}
>   
>   /* Encode cache info for CPUID[4] */
>   static void encode_cache_cpuid4(CPUCacheInfo *cache,
> -                                int num_apic_ids, int num_cores,
> +                                X86CPUTopoInfo *topo_info,
>                                   uint32_t *eax, uint32_t *ebx,
>                                   uint32_t *ecx, uint32_t *edx)
>   {
>       assert(cache->size == cache->line_size * cache->associativity *
>                             cache->partitions * cache->sets);
>   
> -    assert(num_apic_ids > 0);
>       *eax = CACHE_TYPE(cache->type) |
>              CACHE_LEVEL(cache->level) |
>              (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0) |
> -           ((num_cores - 1) << 26) |
> -           ((num_apic_ids - 1) << 14);
> +           (max_core_ids_in_package(topo_info) << 26) |
> +           (max_processor_ids_for_cache(topo_info, cache->share_level) << 14);

by the way, we can change the order of the two line. :)

>   
>       assert(cache->line_size > 0);
>       assert(cache->partitions > 0);
> @@ -6263,56 +6294,41 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>                   int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
>   
>                   if (cores_per_pkg > 1) {
> -                    int addressable_cores_offset =
> -                                                apicid_pkg_offset(&topo_info) -
> -                                                apicid_core_offset(&topo_info);
> -
>                       *eax &= ~0xFC000000;
> -                    *eax |= (1 << (addressable_cores_offset - 1)) << 26;
> +                    *eax |= max_core_ids_in_package(&topo_info) << 26;
>                   }
>                   if (host_vcpus_per_cache > cpus_per_pkg) {
> -                    int pkg_offset = apicid_pkg_offset(&topo_info);
> -
>                       *eax &= ~0x3FFC000;
> -                    *eax |= (1 << (pkg_offset - 1)) << 14;
> +                    *eax |=
> +                        max_processor_ids_for_cache(&topo_info,
> +                                                CPU_TOPO_LEVEL_PACKAGE) << 14;
>                   }
>               }
>           } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
>               *eax = *ebx = *ecx = *edx = 0;
>           } else {
>               *eax = 0;
> -            int addressable_cores_offset = apicid_pkg_offset(&topo_info) -
> -                                           apicid_core_offset(&topo_info);
> -            int core_offset, die_offset;
>   
>               switch (count) {
>               case 0: /* L1 dcache info */
> -                core_offset = apicid_core_offset(&topo_info);
>                   encode_cache_cpuid4(env->cache_info_cpuid4.l1d_cache,
> -                                    (1 << core_offset),
> -                                    (1 << addressable_cores_offset),
> +                                    &topo_info,
>                                       eax, ebx, ecx, edx);
>                   break;
>               case 1: /* L1 icache info */
> -                core_offset = apicid_core_offset(&topo_info);
>                   encode_cache_cpuid4(env->cache_info_cpuid4.l1i_cache,
> -                                    (1 << core_offset),
> -                                    (1 << addressable_cores_offset),
> +                                    &topo_info,
>                                       eax, ebx, ecx, edx);
>                   break;
>               case 2: /* L2 cache info */
> -                core_offset = apicid_core_offset(&topo_info);
>                   encode_cache_cpuid4(env->cache_info_cpuid4.l2_cache,
> -                                    (1 << core_offset),
> -                                    (1 << addressable_cores_offset),
> +                                    &topo_info,
>                                       eax, ebx, ecx, edx);
>                   break;
>               case 3: /* L3 cache info */
> -                die_offset = apicid_die_offset(&topo_info);
>                   if (cpu->enable_l3_cache) {
>                       encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
> -                                        (1 << die_offset),
> -                                        (1 << addressable_cores_offset),
> +                                        &topo_info,
>                                           eax, ebx, ecx, edx);
>                       break;
>                   }


