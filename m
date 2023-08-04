Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7822876FBBC
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 10:11:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRptm-0005QP-VX; Fri, 04 Aug 2023 04:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qRptj-0005QE-Ci
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 04:11:00 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qRptg-0002bx-3k
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 04:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691136656; x=1722672656;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=mGbAFbwdE6srelvPUShTMt4mxKxYBGfYgecCxGjVIKQ=;
 b=hLhT4dPOSGpsWJdYFsXzQOInATSrCyMAIT3NWQGTcW/GqiRCsRrcF0ET
 aubeYxzqSyL2EAzhdcj1tfZgdd304wcXSzkv+r6oxvYnHFNfg6C4dBASf
 FcXsQW3/mluiqzzdNyFU/VuAoPrFn10vKniiCAQSavf3Rh+i9Mqihq35w
 kvhdQWm3mcePiA7NRKNibw3Q3bLxkRz04JRkxyiEiflWcBh90sNC0j11l
 fUBn7dorz1idwmuPWGkXcmPNA4iIFGNjWha0vtD4sQIpItQTmfIpF9xrs
 H9Uby9ozM5zsLT0dpEbpTsBoraNz5Iu2UqyXn0fDcuMNCD5lDxKAeQRJt Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="355035190"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; d="scan'208";a="355035190"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2023 01:10:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="795303632"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; d="scan'208";a="795303632"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by fmsmga008.fm.intel.com with ESMTP; 04 Aug 2023 01:10:45 -0700
Date: Fri, 4 Aug 2023 16:21:12 +0800
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
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Robert Hoo <robert.hu@linux.intel.com>
Subject: Re: [PATCH v3 05/17] i386/cpu: Use APIC ID offset to encode cache
 topo in CPUID[4]
Message-ID: <ZMy0+GIm2jw/NMY7@liuzhao-OptiPlex-7080>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-6-zhao1.liu@linux.intel.com>
 <39c38442-cabf-985c-6125-5d0b3583de58@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39c38442-cabf-985c-6125-5d0b3583de58@amd.com>
Received-SPF: none client-ip=134.134.136.126;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 MIME_CHARSET_FARAWAY=2.45, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Hi Babu,

On Wed, Aug 02, 2023 at 10:41:17AM -0500, Moger, Babu wrote:
> Date: Wed, 2 Aug 2023 10:41:17 -0500
> From: "Moger, Babu" <babu.moger@amd.com>
> Subject: Re: [PATCH v3 05/17] i386/cpu: Use APIC ID offset to encode cache
>  topo in CPUID[4]
> 
> Hi Zhao,
> 
> On 8/1/23 05:35, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > Refer to the fixes of cache_info_passthrough ([1], [2]) and SDM, the
> > CPUID.04H:EAX[bits 25:14] and CPUID.04H:EAX[bits 31:26] should use the
> > nearest power-of-2 integer.
> > 
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
> >    instand of "cs->nr_threads" in encode_cache_cpuid4() for
> >    CPUID.04H.00H:EAX[bits 25:14] and CPUID.04H.01H:EAX[bits 25:14].
> > 2. L2 cache is supposed to be shared in a core as for now, thereby
> >    1 << core_offset should also be used instand of "cs->nr_threads" in
> >    encode_cache_cpuid4() for CPUID.04H.02H:EAX[bits 25:14].
> > 3. Similarly, the value for CPUID.04H:EAX[bits 31:26] should also be
> >    replaced by the offsets upper SMT level in APIC ID.
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
> >  * Use APIC ID offset to replace "pow2ceil()" for cache_info_passthrough
> >    case. (Yanan)
> >  * Split the L1 cache fix into a separate patch.
> >  * Rename the title of this patch (the original is "i386/cpu: Fix number
> >    of addressable IDs in CPUID.04H").
> > ---
> >  target/i386/cpu.c | 30 +++++++++++++++++++++++-------
> >  1 file changed, 23 insertions(+), 7 deletions(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index b439a05244ee..c80613bfcded 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -6005,7 +6005,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >  {
> >      X86CPU *cpu = env_archcpu(env);
> >      CPUState *cs = env_cpu(env);
> > -    uint32_t die_offset;
> >      uint32_t limit;
> >      uint32_t signature[3];
> >      X86CPUTopoInfo topo_info;
> > @@ -6089,39 +6088,56 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >                  int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
> >                  int vcpus_per_socket = cs->nr_cores * cs->nr_threads;
> >                  if (cs->nr_cores > 1) {
> > +                    int addressable_cores_offset =
> > +                                                apicid_pkg_offset(&topo_info) -
> > +                                                apicid_core_offset(&topo_info);
> > +
> >                      *eax &= ~0xFC000000;
> > -                    *eax |= (pow2ceil(cs->nr_cores) - 1) << 26;
> > +                    *eax |= (1 << addressable_cores_offset - 1) << 26;
> >                  }
> >                  if (host_vcpus_per_cache > vcpus_per_socket) {
> > +                    int pkg_offset = apicid_pkg_offset(&topo_info);
> > +
> >                      *eax &= ~0x3FFC000;
> > -                    *eax |= (pow2ceil(vcpus_per_socket) - 1) << 14;
> > +                    *eax |= (1 << pkg_offset - 1) << 14;
> >                  }
> >              }
> 
> I hit this compile error with this patch.
> 
> [1/18] Generating qemu-version.h with a custom command (wrapped by meson
> to capture output)
> [2/4] Compiling C object libqemu-x86_64-softmmu.fa.p/target_i386_cpu.c.o
> FAILED: libqemu-x86_64-softmmu.fa.p/target_i386_cpu.c.o
> ..
> ..
> softmmu.fa.p/target_i386_cpu.c.o -c ../target/i386/cpu.c
> ../target/i386/cpu.c: In function ¡®cpu_x86_cpuid¡¯:
> ../target/i386/cpu.c:6096:60: error: suggest parentheses around ¡®-¡¯ inside
> ¡®<<¡¯ [-Werror=parentheses]
>  6096 |                     *eax |= (1 << addressable_cores_offset - 1) << 26;
>       |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> ../target/i386/cpu.c:6102:46: error: suggest parentheses around ¡®-¡¯ inside
> ¡®<<¡¯ [-Werror=parentheses]
>  6102 |                     *eax |= (1 << pkg_offset - 1) << 14;
>       |                                   ~~~~~~~~~~~^~~
> cc1: all warnings being treated as errors
> 
> Please fix this.

Thanks for your test! Sorry I may miss this warning. I'll fix this.

Thanks,
Zhao

> 
> 
> >          } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
> >              *eax = *ebx = *ecx = *edx = 0;
> >          } else {
> >              *eax = 0;
> > +            int addressable_cores_offset = apicid_pkg_offset(&topo_info) -
> > +                                           apicid_core_offset(&topo_info);
> > +            int core_offset, die_offset;
> > +
> >              switch (count) {
> >              case 0: /* L1 dcache info */
> > +                core_offset = apicid_core_offset(&topo_info);
> >                  encode_cache_cpuid4(env->cache_info_cpuid4.l1d_cache,
> > -                                    cs->nr_threads, cs->nr_cores,
> > +                                    (1 << core_offset),
> > +                                    (1 << addressable_cores_offset),
> >                                      eax, ebx, ecx, edx);
> >                  break;
> >              case 1: /* L1 icache info */
> > +                core_offset = apicid_core_offset(&topo_info);
> >                  encode_cache_cpuid4(env->cache_info_cpuid4.l1i_cache,
> > -                                    cs->nr_threads, cs->nr_cores,
> > +                                    (1 << core_offset),
> > +                                    (1 << addressable_cores_offset),
> >                                      eax, ebx, ecx, edx);
> >                  break;
> >              case 2: /* L2 cache info */
> > +                core_offset = apicid_core_offset(&topo_info);
> >                  encode_cache_cpuid4(env->cache_info_cpuid4.l2_cache,
> > -                                    cs->nr_threads, cs->nr_cores,
> > +                                    (1 << core_offset),
> > +                                    (1 << addressable_cores_offset),
> >                                      eax, ebx, ecx, edx);
> >                  break;
> >              case 3: /* L3 cache info */
> >                  die_offset = apicid_die_offset(&topo_info);
> >                  if (cpu->enable_l3_cache) {
> >                      encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
> > -                                        (1 << die_offset), cs->nr_cores,
> > +                                        (1 << die_offset),
> > +                                        (1 << addressable_cores_offset),
> >                                          eax, ebx, ecx, edx);
> >                      break;
> >                  }
> 
> -- 
> Thanks
> Babu Moger

