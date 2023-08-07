Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE45771D08
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 11:21:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSwP9-00068D-EV; Mon, 07 Aug 2023 05:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qSwP5-00067n-Lv
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:19:55 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qSwP2-00053L-UM
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691399992; x=1722935992;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=+mFgfWjV2+pizFyuJps77lFen7DU1EbhgRAxNmXhqCo=;
 b=f1+Q+1KU8qtN5YmrH9xAhV7NrejTZ5kU/raV/GLJIRaUM+impsbQOirY
 Sg1NP7/BpC9MFudd/iJziR5FAJi//B++M/g7d0dHd/iDsg4vUoMRi1CSu
 zRcwfJKYpfrHVCvtyFTuVY1VoJNBL79c4GLSJWw0Taa0oHcmwyi88+smD
 3CPLA4aRN2SOVD4fUP3XxbsmYy7j710XGul6AYYaHZZtRm1QEsfNn8ccS
 5QNltmhdVeNbnCn/nEXMv/lkbYCaXTdqb4Q0YXclfQv16hDTcAwJWk2Sd
 a6Ug49I7Jv5T87gjDZlTwc74gDMmgN1F7rU7KbM57St8L9fxZmqMkpp6U w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="367957405"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; d="scan'208";a="367957405"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2023 02:19:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="854599510"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; d="scan'208";a="854599510"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by orsmga004.jf.intel.com with ESMTP; 07 Aug 2023 02:19:45 -0700
Date: Mon, 7 Aug 2023 17:30:14 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Babu Moger <babu.moger@amd.com>, Zhao Liu <zhao1.liu@intel.com>,
 Robert Hoo <robert.hu@linux.intel.com>
Subject: Re: [PATCH v3 05/17] i386/cpu: Use APIC ID offset to encode cache
 topo in CPUID[4]
Message-ID: <ZNC5plqi6D/riSPM@liuzhao-OptiPlex-7080>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-6-zhao1.liu@linux.intel.com>
 <0ae07b73-0b44-bae4-141a-947a13990daf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ae07b73-0b44-bae4-141a-947a13990daf@intel.com>
Received-SPF: none client-ip=192.55.52.93;
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

Hi Xiaoyao,

On Mon, Aug 07, 2023 at 04:13:36PM +0800, Xiaoyao Li wrote:
> Date: Mon, 7 Aug 2023 16:13:36 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH v3 05/17] i386/cpu: Use APIC ID offset to encode cache
>  topo in CPUID[4]
> 
> On 8/1/2023 6:35 PM, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > Refer to the fixes of cache_info_passthrough ([1], [2]) and SDM, the
> > CPUID.04H:EAX[bits 25:14] and CPUID.04H:EAX[bits 31:26] should use the
> > nearest power-of-2 integer.
> 
> I doubt it. Especially for [1].
> 
> SDM doesn't state it should be the nearest power-of-2 integer.
> For example, regarding EAX[25:14], what SDM states are,
> 
> 1. The value needs to be added with 1
> ¡¡
> 2. The nearest power-of-2 integer that is not smaller than (1+EAX[25:14]) is
> the number of unique initial APIC IDs reserved for addressing different
> logical processor sharing this cache.
> 
> Above indicates that
> 
> 1. "EAX[25:14] + 1", indicates the real number of how many LPs sharing this
> cache. i.e., how many APIC IDs
> 
> while 2. "The nearest power-of-2 integer that is not smaller than
> (EAX[25:14] + 1)" indicates the how many APIC IDs are reserved for LPs
> sharing this cache. It doesn't require EAX[25:14] + 1, to be power of 2.

Semantically, it is true that SDM does not strictly require that 
EAX[25:14] + 1 is the power of 2.

But for our emulation, how much bigger EAX[25:14] + 1 is than "nearest
power-of-2", it's hard to define...and even there's no rule to define...

Using "nearest power-of-2" directly is a common and generic way (and in
line with spec). :-)

On the actual machines (I've seen), this field is also implemented using
"power-of-2 - 1". (When you meet counterexample, pls educate me)

Thanks,
Zhao

> 
> > The nearest power-of-2 integer can be caculated by pow2ceil() or by
> > using APIC ID offset (like L3 topology using 1 << die_offset [3]).
> > 
> > But in fact, CPUID.04H:EAX[bits 25:14] and CPUID.04H:EAX[bits 31:26]
> > are associated with APIC ID. For example, in linux kernel, the field
> > "num_threads_sharing" (Bits 25 - 14) is parsed with APIC ID. And for
> > another example, on Alder Lake P, the CPUID.04H:EAX[bits 31:26] is not
> > matched with actual core numbers and it's caculated by:
> > "(1 << (pkg_offset - core_offset)) - 1".
> > 
> > Therefore the offset of APIC ID should be preferred to caculate nearest
> > power-of-2 integer for CPUID.04H:EAX[bits 25:14] and CPUID.04H:EAX[bits
> > 31:26]:
> > 1. d/i cache is shared in a core, 1 << core_offset should be used
> >     instand of "cs->nr_threads" in encode_cache_cpuid4() for
> >     CPUID.04H.00H:EAX[bits 25:14] and CPUID.04H.01H:EAX[bits 25:14].
> > 2. L2 cache is supposed to be shared in a core as for now, thereby
> >     1 << core_offset should also be used instand of "cs->nr_threads" in
> >     encode_cache_cpuid4() for CPUID.04H.02H:EAX[bits 25:14].
> > 3. Similarly, the value for CPUID.04H:EAX[bits 31:26] should also be
> >     replaced by the offsets upper SMT level in APIC ID.
> > 
> > In addition, use APIC ID offset to replace "pow2ceil()" for
> > cache_info_passthrough case.
> > 
> > [1]: efb3934adf9e ("x86: cpu: make sure number of addressable IDs for processor cores meets the spec")
> > [2]: d7caf13b5fcf ("x86: cpu: fixup number of addressable IDs for logical processors sharing cache")
> > [3]: d65af288a84d ("i386: Update new x86_apicid parsing rules with die_offset support")
> > 
> > Fixes: 7e3482f82480 ("i386: Helpers to encode cache information consistently")
> > Suggested-by: Robert Hoo <robert.hu@linux.intel.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> > Changes since v1:
> >   * Use APIC ID offset to replace "pow2ceil()" for cache_info_passthrough
> >     case. (Yanan)
> >   * Split the L1 cache fix into a separate patch.
> >   * Rename the title of this patch (the original is "i386/cpu: Fix number
> >     of addressable IDs in CPUID.04H").
> > ---
> >   target/i386/cpu.c | 30 +++++++++++++++++++++++-------
> >   1 file changed, 23 insertions(+), 7 deletions(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index b439a05244ee..c80613bfcded 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -6005,7 +6005,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >   {
> >       X86CPU *cpu = env_archcpu(env);
> >       CPUState *cs = env_cpu(env);
> > -    uint32_t die_offset;
> >       uint32_t limit;
> >       uint32_t signature[3];
> >       X86CPUTopoInfo topo_info;
> > @@ -6089,39 +6088,56 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >                   int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
> >                   int vcpus_per_socket = cs->nr_cores * cs->nr_threads;
> >                   if (cs->nr_cores > 1) {
> > +                    int addressable_cores_offset =
> > +                                                apicid_pkg_offset(&topo_info) -
> > +                                                apicid_core_offset(&topo_info);
> > +
> >                       *eax &= ~0xFC000000;
> > -                    *eax |= (pow2ceil(cs->nr_cores) - 1) << 26;
> > +                    *eax |= (1 << addressable_cores_offset - 1) << 26;
> >                   }
> >                   if (host_vcpus_per_cache > vcpus_per_socket) {
> > +                    int pkg_offset = apicid_pkg_offset(&topo_info);
> > +
> >                       *eax &= ~0x3FFC000;
> > -                    *eax |= (pow2ceil(vcpus_per_socket) - 1) << 14;
> > +                    *eax |= (1 << pkg_offset - 1) << 14;
> >                   }
> >               }
> >           } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
> >               *eax = *ebx = *ecx = *edx = 0;
> >           } else {
> >               *eax = 0;
> > +            int addressable_cores_offset = apicid_pkg_offset(&topo_info) -
> > +                                           apicid_core_offset(&topo_info);
> > +            int core_offset, die_offset;
> > +
> >               switch (count) {
> >               case 0: /* L1 dcache info */
> > +                core_offset = apicid_core_offset(&topo_info);
> >                   encode_cache_cpuid4(env->cache_info_cpuid4.l1d_cache,
> > -                                    cs->nr_threads, cs->nr_cores,
> > +                                    (1 << core_offset),
> > +                                    (1 << addressable_cores_offset),
> >                                       eax, ebx, ecx, edx);
> >                   break;
> >               case 1: /* L1 icache info */
> > +                core_offset = apicid_core_offset(&topo_info);
> >                   encode_cache_cpuid4(env->cache_info_cpuid4.l1i_cache,
> > -                                    cs->nr_threads, cs->nr_cores,
> > +                                    (1 << core_offset),
> > +                                    (1 << addressable_cores_offset),
> >                                       eax, ebx, ecx, edx);
> >                   break;
> >               case 2: /* L2 cache info */
> > +                core_offset = apicid_core_offset(&topo_info);
> >                   encode_cache_cpuid4(env->cache_info_cpuid4.l2_cache,
> > -                                    cs->nr_threads, cs->nr_cores,
> > +                                    (1 << core_offset),
> > +                                    (1 << addressable_cores_offset),
> >                                       eax, ebx, ecx, edx);
> >                   break;
> >               case 3: /* L3 cache info */
> >                   die_offset = apicid_die_offset(&topo_info);
> >                   if (cpu->enable_l3_cache) {
> >                       encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
> > -                                        (1 << die_offset), cs->nr_cores,
> > +                                        (1 << die_offset),
> > +                                        (1 << addressable_cores_offset),
> >                                           eax, ebx, ecx, edx);
> >                       break;
> >                   }
> 

