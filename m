Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD7677B3A4
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 10:15:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVSiW-0002CK-Ai; Mon, 14 Aug 2023 04:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qVSiT-0002Bn-Qy
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 04:14:22 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qVSiQ-0004fy-Fq
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 04:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692000858; x=1723536858;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=kWdxUOqURLP428vsbApyECv/gwXtVN+wJeWUWEZvIj4=;
 b=munofiyklMgqkKp5UCh+OskZRYbl1Zxp6E0Y79S1NY1HYR8Ri65OYu7K
 lplHGz9MbmYVfZU6Abdvo6xe1VWcsqck1XIXFLYesDYd9Ql9+pkEoi2Mp
 k7amvxISc5C+YBougO+lccWcSmQmhvX/8LmpMPK94p3h9dC6xoo9HV16/
 w9IbxsoF8EWZon3gQ5iNi/vbDNlzoCwamkngsyNeVELRSXndKD1O+ZfPh
 ILG1MQfEZTkLULoNcWocIGU7HWnF0RXkZD6veTnkl9BQMTVKHcBLb/zJa
 ktNWERByHVDsqV52yx6pQIh5ZHifq3EDOB8T44NmAtWSxGQhWrw86PAdO g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="352314706"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; d="scan'208";a="352314706"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2023 01:12:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="979907405"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; d="scan'208";a="979907405"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by fmsmga006.fm.intel.com with ESMTP; 14 Aug 2023 01:11:59 -0700
Date: Mon, 14 Aug 2023 16:22:31 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Moger, Babu" <babu.moger@amd.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Wei Wang <wei.w.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 14/17] i386: Use CPUCacheInfo.share_level to encode
 CPUID[4]
Message-ID: <ZNnkR+G6PvE2q77E@liuzhao-OptiPlex-7080>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-15-zhao1.liu@linux.intel.com>
 <19ba8210-3e11-a36f-3b26-52cbe40042b1@amd.com>
 <3f7510f2-20f3-93df-72b3-01cfa687f554@amd.com>
 <ZMzJaElw/T5caQU+@liuzhao-OptiPlex-7080>
 <5947274f-e29d-cb76-3325-5dc75f205eeb@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5947274f-e29d-cb76-3325-5dc75f205eeb@amd.com>
Received-SPF: none client-ip=192.55.52.151;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi Babu,

On Fri, Aug 04, 2023 at 10:48:29AM -0500, Moger, Babu wrote:
> Date: Fri, 4 Aug 2023 10:48:29 -0500
> From: "Moger, Babu" <babu.moger@amd.com>
> Subject: Re: [PATCH v3 14/17] i386: Use CPUCacheInfo.share_level to encode
>  CPUID[4]
> 
> Hi Zhao,
> 
> On 8/4/23 04:48, Zhao Liu wrote:
> > Hi Babu,
> > 
> > On Thu, Aug 03, 2023 at 11:41:40AM -0500, Moger, Babu wrote:
> >> Date: Thu, 3 Aug 2023 11:41:40 -0500
> >> From: "Moger, Babu" <babu.moger@amd.com>
> >> Subject: Re: [PATCH v3 14/17] i386: Use CPUCacheInfo.share_level to encode
> >>  CPUID[4]
> >>
> >> Hi Zhao,
> >>
> >> On 8/2/23 18:49, Moger, Babu wrote:
> >>> Hi Zhao,
> >>>
> >>> Hitting this error after this patch.
> >>>
> >>> ERROR:../target/i386/cpu.c:257:max_processor_ids_for_cache: code should
> >>> not be reached
> >>> Bail out! ERROR:../target/i386/cpu.c:257:max_processor_ids_for_cache: code
> >>> should not be reached
> >>> Aborted (core dumped)
> >>>
> >>> Looks like share_level for all the caches for AMD is not initialized.
> > 
> > I missed these change when I rebase. Sorry for that.
> > 
> > BTW, could I ask a question? From a previous discussion[1], I understand
> > that the cache info is used to show the correct cache information in
> > new machine. And from [2], the wrong cache info may cause "compatibility
> > issues".
> > 
> > Is this "compatibility issues" AMD specific? I'm not sure if Intel should
> > update the cache info like that. thanks!
> 
> I was going to comment about that. Good that you asked me.
> 
> Compatibility is qemu requirement.  Otherwise the migrations will fail.
> 
> Any changes in the topology is going to cause migration problems.

Could you please educate me more about the details of the "migration
problem"?

I didn't understand why it was causing the problem and wasn't sure if I
was missing any cases.

Thanks,
Zhao

> 
> I am not sure how you are going to handle this. You can probably look at
> the feature "x-intel-pt-auto-level".
> 
> make sure to test the migration.
> 
> Thanks
> Babu
> 
> 
> > 
> > [1]: https://patchwork.kernel.org/project/kvm/patch/CY4PR12MB1768A3CBE42AAFB03CB1081E95AA0@CY4PR12MB1768.namprd12.prod.outlook.com/
> > [2]: https://lore.kernel.org/qemu-devel/20180510204148.11687-1-babu.moger@amd.com/
> > 
> >>
> >> The following patch fixes the problem.
> >>
> >> ======================================================
> >>
> >>
> >> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> >> index f4c48e19fa..976a2755d8 100644
> >> --- a/target/i386/cpu.c
> >> +++ b/target/i386/cpu.c
> >> @@ -528,6 +528,7 @@ static CPUCacheInfo legacy_l2_cache_cpuid2 = {
> >>      .size = 2 * MiB,
> >>      .line_size = 64,
> >>      .associativity = 8,
> >> +    .share_level = CPU_TOPO_LEVEL_CORE,
> > 
> > This "legacy_l2_cache_cpuid2" is not used to encode cache topology.
> > I should explicitly set this default topo level as CPU_TOPO_LEVEL_UNKNOW.
> > 
> >>  };
> >>
> >>
> >> @@ -1904,6 +1905,7 @@ static CPUCaches epyc_v4_cache_info = {
> >>          .lines_per_tag = 1,
> >>          .self_init = 1,
> >>          .no_invd_sharing = true,
> >> +        .share_level = CPU_TOPO_LEVEL_CORE,
> >>      },
> >>      .l1i_cache = &(CPUCacheInfo) {
> >>          .type = INSTRUCTION_CACHE,
> >> @@ -1916,6 +1918,7 @@ static CPUCaches epyc_v4_cache_info = {
> >>          .lines_per_tag = 1,
> >>          .self_init = 1,
> >>          .no_invd_sharing = true,
> >> +        .share_level = CPU_TOPO_LEVEL_CORE,
> >>      },
> >>      .l2_cache = &(CPUCacheInfo) {
> >>          .type = UNIFIED_CACHE,
> >> @@ -1926,6 +1929,7 @@ static CPUCaches epyc_v4_cache_info = {
> >>          .partitions = 1,
> >>          .sets = 1024,
> >>          .lines_per_tag = 1,
> >> +        .share_level = CPU_TOPO_LEVEL_CORE,
> >>      },
> >>      .l3_cache = &(CPUCacheInfo) {
> >>          .type = UNIFIED_CACHE,
> >> @@ -1939,6 +1943,7 @@ static CPUCaches epyc_v4_cache_info = {
> >>          .self_init = true,
> >>          .inclusive = true,
> >>          .complex_indexing = false,
> >> +        .share_level = CPU_TOPO_LEVEL_DIE,
> >>      },
> >>  };
> >>
> >> @@ -2008,6 +2013,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
> >>          .lines_per_tag = 1,
> >>          .self_init = 1,
> >>          .no_invd_sharing = true,
> >> +        .share_level = CPU_TOPO_LEVEL_CORE,
> >>      },
> >>      .l1i_cache = &(CPUCacheInfo) {
> >>          .type = INSTRUCTION_CACHE,
> >> @@ -2020,6 +2026,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
> >>          .lines_per_tag = 1,
> >>          .self_init = 1,
> >>          .no_invd_sharing = true,
> >> +        .share_level = CPU_TOPO_LEVEL_CORE,
> >>      },
> >>      .l2_cache = &(CPUCacheInfo) {
> >>          .type = UNIFIED_CACHE,
> >> @@ -2030,6 +2037,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
> >>          .partitions = 1,
> >>          .sets = 1024,
> >>          .lines_per_tag = 1,
> >> +        .share_level = CPU_TOPO_LEVEL_CORE,
> >>      },
> >>      .l3_cache = &(CPUCacheInfo) {
> >>          .type = UNIFIED_CACHE,
> >> @@ -2043,6 +2051,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
> >>          .self_init = true,
> >>          .inclusive = true,
> >>          .complex_indexing = false,
> >> +        .share_level = CPU_TOPO_LEVEL_DIE,
> >>      },
> >>  };
> >>
> >> @@ -2112,6 +2121,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
> >>          .lines_per_tag = 1,
> >>          .self_init = 1,
> >>          .no_invd_sharing = true,
> >> +        .share_level = CPU_TOPO_LEVEL_CORE,
> >>      },
> >>      .l1i_cache = &(CPUCacheInfo) {
> >>          .type = INSTRUCTION_CACHE,
> >> @@ -2124,6 +2134,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
> >>          .lines_per_tag = 1,
> >>          .self_init = 1,
> >>          .no_invd_sharing = true,
> >> +        .share_level = CPU_TOPO_LEVEL_CORE,
> >>      },
> >>      .l2_cache = &(CPUCacheInfo) {
> >>          .type = UNIFIED_CACHE,
> >> @@ -2134,6 +2145,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
> >>          .partitions = 1,
> >>          .sets = 1024,
> >>          .lines_per_tag = 1,
> >> +        .share_level = CPU_TOPO_LEVEL_CORE,
> >>      },
> >>      .l3_cache = &(CPUCacheInfo) {
> >>          .type = UNIFIED_CACHE,
> >> @@ -2147,6 +2159,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
> >>          .self_init = true,
> >>          .inclusive = true,
> >>          .complex_indexing = false,
> >> +        .share_level = CPU_TOPO_LEVEL_DIE,
> >>      },
> >>  };
> >>
> >> @@ -2162,6 +2175,7 @@ static const CPUCaches epyc_genoa_cache_info = {
> >>          .lines_per_tag = 1,
> >>          .self_init = 1,
> >>          .no_invd_sharing = true,
> >> +        .share_level = CPU_TOPO_LEVEL_CORE,
> >>      },
> >>      .l1i_cache = &(CPUCacheInfo) {
> >>          .type = INSTRUCTION_CACHE,
> >> @@ -2174,6 +2188,7 @@ static const CPUCaches epyc_genoa_cache_info = {
> >>          .lines_per_tag = 1,
> >>          .self_init = 1,
> >>          .no_invd_sharing = true,
> >> +        .share_level = CPU_TOPO_LEVEL_CORE,
> >>      },
> >>      .l2_cache = &(CPUCacheInfo) {
> >>          .type = UNIFIED_CACHE,
> >> @@ -2184,6 +2199,7 @@ static const CPUCaches epyc_genoa_cache_info = {
> >>          .partitions = 1,
> >>          .sets = 2048,
> >>          .lines_per_tag = 1,
> >> +        .share_level = CPU_TOPO_LEVEL_CORE,
> >>      },
> >>      .l3_cache = &(CPUCacheInfo) {
> >>          .type = UNIFIED_CACHE,
> >> @@ -2197,6 +2213,7 @@ static const CPUCaches epyc_genoa_cache_info = {
> >>          .self_init = true,
> >>          .inclusive = true,
> >>          .complex_indexing = false,
> >> +        .share_level = CPU_TOPO_LEVEL_DIE,
> >>      },
> >>  };
> >>
> >>
> >> =========================================================================
> > 
> > 
> > Look good to me except legacy_l2_cache_cpuid2, thanks very much!
> > I'll add this in next version.
> > 
> > -Zhao
> > 
> >>
> >> Thanks
> >> Babu
> >>>
> >>> On 8/1/23 05:35, Zhao Liu wrote:
> >>>> From: Zhao Liu <zhao1.liu@intel.com>
> >>>>
> >>>> CPUID[4].EAX[bits 25:14] is used to represent the cache topology for
> >>>> intel CPUs.
> >>>>
> >>>> After cache models have topology information, we can use
> >>>> CPUCacheInfo.share_level to decide which topology level to be encoded
> >>>> into CPUID[4].EAX[bits 25:14].
> >>>>
> >>>> And since maximum_processor_id (original "num_apic_ids") is parsed
> >>>> based on cpu topology levels, which are verified when parsing smp, it's
> >>>> no need to check this value by "assert(num_apic_ids > 0)" again, so
> >>>> remove this assert.
> >>>>
> >>>> Additionally, wrap the encoding of CPUID[4].EAX[bits 31:26] into a
> >>>> helper to make the code cleaner.
> >>>>
> >>>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> >>>> ---
> >>>> Changes since v1:
> >>>>  * Use "enum CPUTopoLevel share_level" as the parameter in
> >>>>    max_processor_ids_for_cache().
> >>>>  * Make cache_into_passthrough case also use
> >>>>    max_processor_ids_for_cache() and max_core_ids_in_package() to
> >>>>    encode CPUID[4]. (Yanan)
> >>>>  * Rename the title of this patch (the original is "i386: Use
> >>>>    CPUCacheInfo.share_level to encode CPUID[4].EAX[bits 25:14]").
> >>>> ---
> >>>>  target/i386/cpu.c | 70 +++++++++++++++++++++++++++++------------------
> >>>>  1 file changed, 43 insertions(+), 27 deletions(-)
> >>>>
> >>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> >>>> index 55aba4889628..c9897c0fe91a 100644
> >>>> --- a/target/i386/cpu.c
> >>>> +++ b/target/i386/cpu.c
> >>>> @@ -234,22 +234,53 @@ static uint8_t cpuid2_cache_descriptor(CPUCacheInfo *cache)
> >>>>                         ((t) == UNIFIED_CACHE) ? CACHE_TYPE_UNIFIED : \
> >>>>                         0 /* Invalid value */)
> >>>>  
> >>>> +static uint32_t max_processor_ids_for_cache(X86CPUTopoInfo *topo_info,
> >>>> +                                            enum CPUTopoLevel share_level)
> >>>> +{
> >>>> +    uint32_t num_ids = 0;
> >>>> +
> >>>> +    switch (share_level) {
> >>>> +    case CPU_TOPO_LEVEL_CORE:
> >>>> +        num_ids = 1 << apicid_core_offset(topo_info);
> >>>> +        break;
> >>>> +    case CPU_TOPO_LEVEL_DIE:
> >>>> +        num_ids = 1 << apicid_die_offset(topo_info);
> >>>> +        break;
> >>>> +    case CPU_TOPO_LEVEL_PACKAGE:
> >>>> +        num_ids = 1 << apicid_pkg_offset(topo_info);
> >>>> +        break;
> >>>> +    default:
> >>>> +        /*
> >>>> +         * Currently there is no use case for SMT and MODULE, so use
> >>>> +         * assert directly to facilitate debugging.
> >>>> +         */
> >>>> +        g_assert_not_reached();
> >>>> +    }
> >>>> +
> >>>> +    return num_ids - 1;
> >>>> +}
> >>>> +
> >>>> +static uint32_t max_core_ids_in_package(X86CPUTopoInfo *topo_info)
> >>>> +{
> >>>> +    uint32_t num_cores = 1 << (apicid_pkg_offset(topo_info) -
> >>>> +                               apicid_core_offset(topo_info));
> >>>> +    return num_cores - 1;
> >>>> +}
> >>>>  
> >>>>  /* Encode cache info for CPUID[4] */
> >>>>  static void encode_cache_cpuid4(CPUCacheInfo *cache,
> >>>> -                                int num_apic_ids, int num_cores,
> >>>> +                                X86CPUTopoInfo *topo_info,
> >>>>                                  uint32_t *eax, uint32_t *ebx,
> >>>>                                  uint32_t *ecx, uint32_t *edx)
> >>>>  {
> >>>>      assert(cache->size == cache->line_size * cache->associativity *
> >>>>                            cache->partitions * cache->sets);
> >>>>  
> >>>> -    assert(num_apic_ids > 0);
> >>>>      *eax = CACHE_TYPE(cache->type) |
> >>>>             CACHE_LEVEL(cache->level) |
> >>>>             (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0) |
> >>>> -           ((num_cores - 1) << 26) |
> >>>> -           ((num_apic_ids - 1) << 14);
> >>>> +           (max_core_ids_in_package(topo_info) << 26) |
> >>>> +           (max_processor_ids_for_cache(topo_info, cache->share_level) << 14);
> >>>>  
> >>>>      assert(cache->line_size > 0);
> >>>>      assert(cache->partitions > 0);
> >>>> @@ -6116,56 +6147,41 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >>>>                  int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
> >>>>  
> >>>>                  if (cores_per_pkg > 1) {
> >>>> -                    int addressable_cores_offset =
> >>>> -                                                apicid_pkg_offset(&topo_info) -
> >>>> -                                                apicid_core_offset(&topo_info);
> >>>> -
> >>>>                      *eax &= ~0xFC000000;
> >>>> -                    *eax |= (1 << addressable_cores_offset - 1) << 26;
> >>>> +                    *eax |= max_core_ids_in_package(&topo_info) << 26;
> >>>>                  }
> >>>>                  if (host_vcpus_per_cache > cpus_per_pkg) {
> >>>> -                    int pkg_offset = apicid_pkg_offset(&topo_info);
> >>>> -
> >>>>                      *eax &= ~0x3FFC000;
> >>>> -                    *eax |= (1 << pkg_offset - 1) << 14;
> >>>> +                    *eax |=
> >>>> +                        max_processor_ids_for_cache(&topo_info,
> >>>> +                                                CPU_TOPO_LEVEL_PACKAGE) << 14;
> >>>>                  }
> >>>>              }
> >>>>          } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
> >>>>              *eax = *ebx = *ecx = *edx = 0;
> >>>>          } else {
> >>>>              *eax = 0;
> >>>> -            int addressable_cores_offset = apicid_pkg_offset(&topo_info) -
> >>>> -                                           apicid_core_offset(&topo_info);
> >>>> -            int core_offset, die_offset;
> >>>>  
> >>>>              switch (count) {
> >>>>              case 0: /* L1 dcache info */
> >>>> -                core_offset = apicid_core_offset(&topo_info);
> >>>>                  encode_cache_cpuid4(env->cache_info_cpuid4.l1d_cache,
> >>>> -                                    (1 << core_offset),
> >>>> -                                    (1 << addressable_cores_offset),
> >>>> +                                    &topo_info,
> >>>>                                      eax, ebx, ecx, edx);
> >>>>                  break;
> >>>>              case 1: /* L1 icache info */
> >>>> -                core_offset = apicid_core_offset(&topo_info);
> >>>>                  encode_cache_cpuid4(env->cache_info_cpuid4.l1i_cache,
> >>>> -                                    (1 << core_offset),
> >>>> -                                    (1 << addressable_cores_offset),
> >>>> +                                    &topo_info,
> >>>>                                      eax, ebx, ecx, edx);
> >>>>                  break;
> >>>>              case 2: /* L2 cache info */
> >>>> -                core_offset = apicid_core_offset(&topo_info);
> >>>>                  encode_cache_cpuid4(env->cache_info_cpuid4.l2_cache,
> >>>> -                                    (1 << core_offset),
> >>>> -                                    (1 << addressable_cores_offset),
> >>>> +                                    &topo_info,
> >>>>                                      eax, ebx, ecx, edx);
> >>>>                  break;
> >>>>              case 3: /* L3 cache info */
> >>>> -                die_offset = apicid_die_offset(&topo_info);
> >>>>                  if (cpu->enable_l3_cache) {
> >>>>                      encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
> >>>> -                                        (1 << die_offset),
> >>>> -                                        (1 << addressable_cores_offset),
> >>>> +                                        &topo_info,
> >>>>                                          eax, ebx, ecx, edx);
> >>>>                      break;
> >>>>                  }
> >>>
> >>
> >> -- 
> >> Thanks
> >> Babu Moger
> 
> -- 
> Thanks
> Babu Moger

