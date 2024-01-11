Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3077C82A9C2
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 09:54:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNqpP-0006wF-4D; Thu, 11 Jan 2024 03:54:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rNqpL-0006w2-Mp
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:54:15 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rNqpJ-0006a5-HL
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:54:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704963253; x=1736499253;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=SLxjjko8qKGRdIGBrm/PZpmWi4YJzLg3fbqCblM3LrI=;
 b=j2tBNW6HKg5EC8osjBYrowO4HO/4a/5Ktvr7tQhhdkzEVLE62fTT0fME
 0y1fgBEr1Q2MzPPY2UzjlIk504uMuOMP1L1u/y8tcCP/Jpdcy4WKl0/k3
 QOHQaAVCA7WIyptThwygpsFLnTWjoUqCNn0MwzWTbxSmHPRUUGWVCHPmf
 hZerwsg8UICp7VkKbl/GXXm7qmfHXcnm7QHw+UlV9ATQW10hMzfaJd/8q
 fQAldh1g+YMwkE20II/sFoYRMRPGI7IUoz6Dl1bBhfQaUF+GDnuDsGNeb
 YVbWQ7LIafEW0CMUwDTEUvGXzDQ5P4jSFoc6BUC0zNPDCP9BA6Kr1Mh5Q A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="397657380"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; d="scan'208";a="397657380"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2024 00:54:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="852886314"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; d="scan'208";a="852886314"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga004.fm.intel.com with ESMTP; 11 Jan 2024 00:54:07 -0800
Date: Thu, 11 Jan 2024 17:07:03 +0800
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
Message-ID: <ZZ+vt/JxXaAgdl9d@intel.com>
References: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
 <20240108082727.420817-6-zhao1.liu@linux.intel.com>
 <cb75fcea-7e3a-4062-8d1c-3067f5e53bcc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb75fcea-7e3a-4062-8d1c-3067f5e53bcc@intel.com>
Received-SPF: none client-ip=192.55.52.120;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Okay, will use num_threads_next_level ;-)

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
> 
> and initialize it as below, when initializing the env
> 
> env->valid_cpu_topo[0] = CPU_TOPO_LEVEL_SMT;
> env->valid_cpu_topo[1] = CPU_TOPO_LEVEL_CORE;
> if (env->nr_dies > 1) {
> 	env->valid_cpu_topo[2] = CPU_TOPO_LEVEL_DIE;
> }
> 
> then in encode_topo_cpuid1f(), we can get level and next_level as
> 
> level = env->valid_cpu_topo[count];
> next_level = env->valid_cpu_topo[count + 1];
> 

Good idea, let me try this way.

Thanks,
Zhao


