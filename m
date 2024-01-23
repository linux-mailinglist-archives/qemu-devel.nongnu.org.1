Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D72C838A8C
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 10:44:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSDJn-0005fx-6l; Tue, 23 Jan 2024 04:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rSDJh-0005fV-K1
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 04:43:37 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rSDJd-0005mg-JE
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 04:43:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706003013; x=1737539013;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=wU64uHlR52rNEzdKGKovUXzpWZVCS6qVw80l/VHg/G4=;
 b=VFeCwX+JSMZg7DHfy3Pl4PsxWGQNc6S9yUKUccN3fVNE79pc0pGdNXF/
 vO6VbKSAOo5gk3pmteBqgdhzEiNWk7sENLcGS+bWXNIOux+MqzTKYbqB2
 c25OGmYI5HZ+7qCS1lmhu/DzX1Kw/hLvsnlr6LI8UQFhiHGHP+kEYw1RY
 Bc6hrfOLsoBwLR5kwPyn0SaPL0g8u/J5I151zafcF92rDuPmZMiBsKmva
 q2VU/kevmGjFa15xAXFal1r6geT7F4lc7IspSCCG/BM3b/zn9dLks4KFA
 U8/PyMT7JQDznGBtL1FVuhvKFCq35N6bJ49XKfmVvE7g9PG5accxZzSB7 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="8838340"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="8838340"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2024 01:43:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="735514573"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; d="scan'208";a="735514573"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga003.jf.intel.com with ESMTP; 23 Jan 2024 01:43:25 -0800
Date: Tue, 23 Jan 2024 17:56:27 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH v7 05/16] i386: Decouple CPUID[0x1F] subleaf with
 specific topology level
Message-ID: <Za+NS1OneKg7IHOj@intel.com>
References: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
 <20240108082727.420817-6-zhao1.liu@linux.intel.com>
 <cb75fcea-7e3a-4062-8d1c-3067f5e53bcc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb75fcea-7e3a-4062-8d1c-3067f5e53bcc@intel.com>
Received-SPF: none client-ip=198.175.65.12;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Jan 11, 2024 at 11:19:34AM +0800, Xiaoyao Li wrote:
> Date: Thu, 11 Jan 2024 11:19:34 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH v7 05/16] i386: Decouple CPUID[0x1F] subleaf with
>  specific topology level
> 
> On 1/8/2024 4:27 PM, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > At present, the subleaf 0x02 of CPUID[0x1F] is bound to the "die" level.
> > 
> > In fact, the specific topology level exposed in 0x1F depends on the
> > platform's support for extension levels (module, tile and die).
> > 
> > To help expose "module" level in 0x1F, decouple CPUID[0x1F] subleaf
> > with specific topology level.
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > Tested-by: Babu Moger <babu.moger@amd.com>
> > Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > Changes since v3:
> >   * New patch to prepare to expose module level in 0x1F.
> >   * Move the CPUTopoLevel enumeration definition from "i386: Add cache
> >     topology info in CPUCacheInfo" to this patch. Note, to align with
> >     topology types in SDM, revert the name of CPU_TOPO_LEVEL_UNKNOW to
> >     CPU_TOPO_LEVEL_INVALID.
> > ---
> >   target/i386/cpu.c | 136 +++++++++++++++++++++++++++++++++++++---------
> >   target/i386/cpu.h |  15 +++++
> >   2 files changed, 126 insertions(+), 25 deletions(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index bc440477d13d..5c295c9a9e2d 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -269,6 +269,116 @@ static void encode_cache_cpuid4(CPUCacheInfo *cache,
> >              (cache->complex_indexing ? CACHE_COMPLEX_IDX : 0);
> >   }
> > +static uint32_t num_cpus_by_topo_level(X86CPUTopoInfo *topo_info,
> > +                                       enum CPUTopoLevel topo_level)
> > +{
> > +    switch (topo_level) {
> > +    case CPU_TOPO_LEVEL_SMT:
> > +        return 1;
> > +    case CPU_TOPO_LEVEL_CORE:
> > +        return topo_info->threads_per_core;
> > +    case CPU_TOPO_LEVEL_DIE:
> > +        return topo_info->threads_per_core * topo_info->cores_per_die;
> > +    case CPU_TOPO_LEVEL_PACKAGE:
> > +        return topo_info->threads_per_core * topo_info->cores_per_die *
> > +               topo_info->dies_per_pkg;
> > +    default:
> > +        g_assert_not_reached();
> > +    }
> > +    return 0;
> > +}
> > +
> > +static uint32_t apicid_offset_by_topo_level(X86CPUTopoInfo *topo_info,
> > +                                            enum CPUTopoLevel topo_level)
> > +{
> > +    switch (topo_level) {
> > +    case CPU_TOPO_LEVEL_SMT:
> > +        return 0;
> > +    case CPU_TOPO_LEVEL_CORE:
> > +        return apicid_core_offset(topo_info);
> > +    case CPU_TOPO_LEVEL_DIE:
> > +        return apicid_die_offset(topo_info);
> > +    case CPU_TOPO_LEVEL_PACKAGE:
> > +        return apicid_pkg_offset(topo_info);
> > +    default:
> > +        g_assert_not_reached();
> > +    }
> > +    return 0;
> > +}
> > +
> > +static uint32_t cpuid1f_topo_type(enum CPUTopoLevel topo_level)
> > +{
> > +    switch (topo_level) {
> > +    case CPU_TOPO_LEVEL_INVALID:
> > +        return CPUID_1F_ECX_TOPO_LEVEL_INVALID;
> > +    case CPU_TOPO_LEVEL_SMT:
> > +        return CPUID_1F_ECX_TOPO_LEVEL_SMT;
> > +    case CPU_TOPO_LEVEL_CORE:
> > +        return CPUID_1F_ECX_TOPO_LEVEL_CORE;
> > +    case CPU_TOPO_LEVEL_DIE:
> > +        return CPUID_1F_ECX_TOPO_LEVEL_DIE;
> > +    default:
> > +        /* Other types are not supported in QEMU. */
> > +        g_assert_not_reached();
> > +    }
> > +    return 0;
> > +}
> > +
> > +static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
> > +                                X86CPUTopoInfo *topo_info,
> > +                                uint32_t *eax, uint32_t *ebx,
> > +                                uint32_t *ecx, uint32_t *edx)
> > +{
> > +    static DECLARE_BITMAP(topo_bitmap, CPU_TOPO_LEVEL_MAX);
> > +    X86CPU *cpu = env_archcpu(env);
> > +    unsigned long level, next_level;
> > +    uint32_t num_cpus_next_level, offset_next_level;
> 
> again, I dislike the name of cpus to represent the logical process or
> thread. we can call it, num_lps_next_level, or num_threads_next_level;
> 
> > +
> > +    /*
> > +     * Initialize the bitmap to decide which levels should be
> > +     * encoded in 0x1f.
> > +     */
> > +    if (!count) {
> 
> using static bitmap and initialize the bitmap on (count == 0), looks bad to
> me. It highly relies on the order of how encode_topo_cpuid1f() is called,
> and fragile.
> 
> Instead, we can maintain an array in CPUX86State, e.g.,

In my practice, I have found this way to be rather tricky since...

> 
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1904,6 +1904,8 @@ typedef struct CPUArchState {
> 
>      /* Number of dies within this CPU package. */
>      unsigned nr_dies;
> +
> +    unint8_t valid_cpu_topo[CPU_TOPO_LEVEL_MAX];
>  } CPUX86State;
> 

this array actually pre-binds the 0x1f subleaf to the topology level,
so this way brings difficulties to the array initialization stage...

> 
> and initialize it as below, when initializing the env
> 
> env->valid_cpu_topo[0] = CPU_TOPO_LEVEL_SMT;
> env->valid_cpu_topo[1] = CPU_TOPO_LEVEL_CORE;
> if (env->nr_dies > 1) {
> 	env->valid_cpu_topo[2] = CPU_TOPO_LEVEL_DIE;
> }

... as here.

Based on 1f encoding rule, with module, we may need this logic like
this:

// If there's module, encode the module level at ECX=2.
if (env->nr_modules > 1) {
       env->valid_cpu_topo[2] = CPU_TOPO_LEVEL_MODULE;
       if (env->nr_dies > 1) {
       		env->valid_cpu_topo[3] = CPU_TOPO_LEVEL_DIE;
       }
} else if (env->nr_dies > 1) { // Otherwise, encode die directly.
       env->valid_cpu_topo[2] = CPU_TOPO_LEVEL_DIE;
}

Such case-by-case checking lacks scalability, and if more levels are
supported in the future, such as tiles, the whole checking becomes
unclean. Am I understanding you correctly?

About the static bitmap, declaring it as static is an optimization.
Because the count (ECX, e.g., ECX=N) means the Nth topology levels,
if we didn't use static virable, we would need to iterate each time
to find the Nth level.

Since we know that the subleaf of 0x1f must be sequentially encoded,
the logic of this static code is always in effect.

What do you think?

Thanks,
Zhao

> 
> then in encode_topo_cpuid1f(), we can get level and next_level as
> 
> level = env->valid_cpu_topo[count];
> next_level = env->valid_cpu_topo[count + 1];
> 
> 
> > +        /* SMT and core levels are exposed in 0x1f leaf by default. */
> > +        set_bit(CPU_TOPO_LEVEL_SMT, topo_bitmap);
> > +        set_bit(CPU_TOPO_LEVEL_CORE, topo_bitmap);
> > +
> > +        if (env->nr_dies > 1) {
> > +            set_bit(CPU_TOPO_LEVEL_DIE, topo_bitmap);
> > +        }
> > +    }
> > +
> > +    *ecx = count & 0xff;
> > +    *edx = cpu->apic_id;
> > +
> > +    level = find_first_bit(topo_bitmap, CPU_TOPO_LEVEL_MAX);
> > +    if (level == CPU_TOPO_LEVEL_MAX) {
> > +        num_cpus_next_level = 0;
> > +        offset_next_level = 0;
> > +
> > +        /* Encode CPU_TOPO_LEVEL_INVALID into the last subleaf of 0x1f. */
> > +        level = CPU_TOPO_LEVEL_INVALID;
> > +    } else {
> > +        next_level = find_next_bit(topo_bitmap, CPU_TOPO_LEVEL_MAX, level + 1);
> > +        if (next_level == CPU_TOPO_LEVEL_MAX) {
> > +            next_level = CPU_TOPO_LEVEL_PACKAGE;
> > +        }
> > +
> > +        num_cpus_next_level = num_cpus_by_topo_level(topo_info, next_level);
> > +        offset_next_level = apicid_offset_by_topo_level(topo_info, next_level);
> > +    }
> > +
> > +    *eax = offset_next_level;
> > +    *ebx = num_cpus_next_level;
> > +    *ecx |= cpuid1f_topo_type(level) << 8;
> > +
> > +    assert(!(*eax & ~0x1f));
> > +    *ebx &= 0xffff; /* The count doesn't need to be reliable. */
> > +    if (level != CPU_TOPO_LEVEL_MAX) {
> > +        clear_bit(level, topo_bitmap);
> > +    }
> > +}
> > +
> >   /* Encode cache info for CPUID[0x80000005].ECX or CPUID[0x80000005].EDX */
> >   static uint32_t encode_cache_cpuid80000005(CPUCacheInfo *cache)
> >   {
> > @@ -6284,31 +6394,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >               break;
> >           }
> > -        *ecx = count & 0xff;
> > -        *edx = cpu->apic_id;
> > -        switch (count) {
> > -        case 0:
> > -            *eax = apicid_core_offset(&topo_info);
> > -            *ebx = topo_info.threads_per_core;
> > -            *ecx |= CPUID_1F_ECX_TOPO_LEVEL_SMT << 8;
> > -            break;
> > -        case 1:
> > -            *eax = apicid_die_offset(&topo_info);
> > -            *ebx = topo_info.cores_per_die * topo_info.threads_per_core;
> > -            *ecx |= CPUID_1F_ECX_TOPO_LEVEL_CORE << 8;
> > -            break;
> > -        case 2:
> > -            *eax = apicid_pkg_offset(&topo_info);
> > -            *ebx = cpus_per_pkg;
> > -            *ecx |= CPUID_1F_ECX_TOPO_LEVEL_DIE << 8;
> > -            break;
> > -        default:
> > -            *eax = 0;
> > -            *ebx = 0;
> > -            *ecx |= CPUID_1F_ECX_TOPO_LEVEL_INVALID << 8;
> > -        }
> > -        assert(!(*eax & ~0x1f));
> > -        *ebx &= 0xffff; /* The count doesn't need to be reliable. */
> > +        encode_topo_cpuid1f(env, count, &topo_info, eax, ebx, ecx, edx);
> >           break;
> >       case 0xD: {
> >           /* Processor Extended State */
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index f47bad46db5e..9c78cfc3f322 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -1008,6 +1008,21 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
> >   #define CPUID_MWAIT_IBE     (1U << 1) /* Interrupts can exit capability */
> >   #define CPUID_MWAIT_EMX     (1U << 0) /* enumeration supported */
> > +/*
> > + * CPUTopoLevel is the general i386 topology hierarchical representation,
> > + * ordered by increasing hierarchical relationship.
> > + * Its enumeration value is not bound to the type value of Intel (CPUID[0x1F])
> > + * or AMD (CPUID[0x80000026]).
> > + */
> > +enum CPUTopoLevel {
> > +    CPU_TOPO_LEVEL_INVALID,
> > +    CPU_TOPO_LEVEL_SMT,
> > +    CPU_TOPO_LEVEL_CORE,
> > +    CPU_TOPO_LEVEL_DIE,
> > +    CPU_TOPO_LEVEL_PACKAGE,
> > +    CPU_TOPO_LEVEL_MAX,
> > +};
> > +
> >   /* CPUID[0xB].ECX level types */
> >   #define CPUID_B_ECX_TOPO_LEVEL_INVALID  0
> >   #define CPUID_B_ECX_TOPO_LEVEL_SMT      1
> 

