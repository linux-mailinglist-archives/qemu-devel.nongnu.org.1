Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4922076FCAC
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 10:55:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRqaf-0000ZU-Fb; Fri, 04 Aug 2023 04:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qRqaW-0000Z8-SM
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 04:55:13 -0400
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qRqaU-0001YY-6z
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 04:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691139310; x=1722675310;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=rBDxvGMvVr6aZNzelsYUbt+eN/S3O7+kRulh3aQDvlA=;
 b=fwtkGQ7drwcLeDgg2doRAVNzp3jD8Kb2YlEKm+vrIYT9ihdFW2O2Wk03
 u/lQ3ooLqZl8Y8WTp6W8jC9tJPVCi2tuPQvY68ONYbHAyTlJyhRKjl6Gr
 vtOeXm68c6UVO19x20FkPhtjCqvf2uzCAbTe8uvPuaHKzUIep5N8AthON
 rwyrHqWu/yIZIp1FwuI6PLM8Gv7MRu4ViK/3o0sVJkroe6meHdWF2zs6f
 VGoLvmNKezJOvq8uQ/fHzYaMUvRg+Ag80Qe5zW5mP7YWTNj57L9xP5YkF
 fI/COXHtW9qoIE9Xk8pS5KxPdXit+f2wMYEzt70wC6gY9lk02A1gYKaq8 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="456479873"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; d="scan'208";a="456479873"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2023 01:55:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; d="scan'208";a="873305586"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by fmsmga001.fm.intel.com with ESMTP; 04 Aug 2023 01:55:06 -0700
Date: Fri, 4 Aug 2023 17:05:32 +0800
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
 Zhuocheng Ding <zhuocheng.ding@intel.com>
Subject: Re: [PATCH v3 08/17] i386: Support modules_per_die in X86CPUTopoInfo
Message-ID: <ZMy/XAhuXJSZrwLk@liuzhao-OptiPlex-7080>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-9-zhao1.liu@linux.intel.com>
 <cc472f47-2cb0-3cb8-f4c4-6f6db7bea782@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc472f47-2cb0-3cb8-f4c4-6f6db7bea782@amd.com>
Received-SPF: none client-ip=192.55.52.43;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi Babu,

On Wed, Aug 02, 2023 at 12:25:07PM -0500, Moger, Babu wrote:
> Date: Wed, 2 Aug 2023 12:25:07 -0500
> From: "Moger, Babu" <babu.moger@amd.com>
> Subject: Re: [PATCH v3 08/17] i386: Support modules_per_die in
>  X86CPUTopoInfo
> 
> Hi Zhao,
> 
> On 8/1/23 05:35, Zhao Liu wrote:
> > From: Zhuocheng Ding <zhuocheng.ding@intel.com>
> > 
> > Support module level in i386 cpu topology structure "X86CPUTopoInfo".
> > 
> > Since x86 does not yet support the "clusters" parameter in "-smp",
> > X86CPUTopoInfo.modules_per_die is currently always 1. Therefore, the
> > module level width in APIC ID, which can be calculated by
> > "apicid_bitwidth_for_count(topo_info->modules_per_die)", is always 0
> > for now, so we can directly add APIC ID related helpers to support
> > module level parsing.
> > 
> > At present, we don't expose module level in CPUID.1FH because currently
> > linux (v6.4-rc1) doesn't support module level. And exposing module and
> > die levels at the same time in CPUID.1FH will cause linux to calculate
> > the wrong die_id. The module level should be exposed until the real
> > machine has the module level in CPUID.1FH.
> > 
> > In addition, update topology structure in test-x86-topo.c.
> > 
> > Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
> > Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > Changes since v1:
> >  * Include module level related helpers (apicid_module_width() and
> >    apicid_module_offset()) in this patch. (Yanan)
> > ---
> >  hw/i386/x86.c              |  3 ++-
> >  include/hw/i386/topology.h | 22 +++++++++++++++----
> >  target/i386/cpu.c          | 12 ++++++----
> >  tests/unit/test-x86-topo.c | 45 ++++++++++++++++++++------------------
> >  4 files changed, 52 insertions(+), 30 deletions(-)
> > 
> > diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> > index 4efc390905ff..a552ae8bb4a8 100644
> > --- a/hw/i386/x86.c
> > +++ b/hw/i386/x86.c
> > @@ -72,7 +72,8 @@ static void init_topo_info(X86CPUTopoInfo *topo_info,
> >      MachineState *ms = MACHINE(x86ms);
> >  
> >      topo_info->dies_per_pkg = ms->smp.dies;
> > -    topo_info->cores_per_die = ms->smp.cores;
> > +    topo_info->modules_per_die = ms->smp.clusters;
> 
> It is confusing. You said in the previous patch, using the clusters for
> x86 is going to cause compatibility issues. 

The compatibility issue means the default L2 cache topology should be "1
L2 cache per core", and we shouldn't change this default setting.

If we want the "1 L2 cache per module", then we need other way to do
this (this is x-l2-cache-topo).

Since "cluster" was originally introduced into QEMU to help define the
L2 cache topology, I explained that we can't just change the default
topology level of L2.

> Why is this clusters is used to initialize modules_per_die?

"cluster" v.s. "module" just like "socket" v.s. "package".

The former is the generic name in smp code, while the latter is the more
accurate naming in the i386 context.

> 
> Why not define a new field "modules"(just like clusters) in smp and use it
> x86? Is is going to a problem?

In this case (just add a new "module" in smp), the "cluster" parameter of
smp is not useful for i386, and different architectures have different
parameters for smp, which is not general enough. I think it's clearest to
have a common topology hierarchy in QEMU.

cluster was originally introduced to QEMU by arm. From Yanan's explanation
[1], it is a CPU topology level, above the core level, and that L2 is often
shared at this level as well.

This description is very similar to i386's module, so I think we could align
cluster with module instead of intruducing a new "module" in smp, just like
"socket" in smp is the same as "package" in i386.

[1]: https://patchew.org/QEMU/20211228092221.21068-1-wangyanan55@huawei.com/

> May be I am not clear here. I am yet to understand all the other changes.
> 

Hope my explanation above clarifies your question.

Thanks,
Zhao

> Thanks
> Babu
> 
> > +    topo_info->cores_per_module = ms->smp.cores;
> >      topo_info->threads_per_core = ms->smp.threads;
> >  }
> >  
> > diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> > index 5a19679f618b..c807d3811dd3 100644
> > --- a/include/hw/i386/topology.h
> > +++ b/include/hw/i386/topology.h
> > @@ -56,7 +56,8 @@ typedef struct X86CPUTopoIDs {
> >  
> >  typedef struct X86CPUTopoInfo {
> >      unsigned dies_per_pkg;
> > -    unsigned cores_per_die;
> > +    unsigned modules_per_die;
> > +    unsigned cores_per_module;
> >      unsigned threads_per_core;
> >  } X86CPUTopoInfo;
> >  
> > @@ -77,7 +78,13 @@ static inline unsigned apicid_smt_width(X86CPUTopoInfo *topo_info)
> >  /* Bit width of the Core_ID field */
> >  static inline unsigned apicid_core_width(X86CPUTopoInfo *topo_info)
> >  {
> > -    return apicid_bitwidth_for_count(topo_info->cores_per_die);
> > +    return apicid_bitwidth_for_count(topo_info->cores_per_module);
> > +}
> > +
> > +/* Bit width of the Module_ID (cluster ID) field */
> > +static inline unsigned apicid_module_width(X86CPUTopoInfo *topo_info)
> > +{
> > +    return apicid_bitwidth_for_count(topo_info->modules_per_die);
> >  }
> >  
> >  /* Bit width of the Die_ID field */
> > @@ -92,10 +99,16 @@ static inline unsigned apicid_core_offset(X86CPUTopoInfo *topo_info)
> >      return apicid_smt_width(topo_info);
> >  }
> >  
> > +/* Bit offset of the Module_ID (cluster ID) field */
> > +static inline unsigned apicid_module_offset(X86CPUTopoInfo *topo_info)
> > +{
> > +    return apicid_core_offset(topo_info) + apicid_core_width(topo_info);
> > +}
> > +
> >  /* Bit offset of the Die_ID field */
> >  static inline unsigned apicid_die_offset(X86CPUTopoInfo *topo_info)
> >  {
> > -    return apicid_core_offset(topo_info) + apicid_core_width(topo_info);
> > +    return apicid_module_offset(topo_info) + apicid_module_width(topo_info);
> >  }
> >  
> >  /* Bit offset of the Pkg_ID (socket ID) field */
> > @@ -127,7 +140,8 @@ static inline void x86_topo_ids_from_idx(X86CPUTopoInfo *topo_info,
> >                                           X86CPUTopoIDs *topo_ids)
> >  {
> >      unsigned nr_dies = topo_info->dies_per_pkg;
> > -    unsigned nr_cores = topo_info->cores_per_die;
> > +    unsigned nr_cores = topo_info->cores_per_module *
> > +                        topo_info->modules_per_die;
> >      unsigned nr_threads = topo_info->threads_per_core;
> >  
> >      topo_ids->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 8a9fd5682efc..d6969813ee02 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -339,7 +339,9 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
> >  
> >      /* L3 is shared among multiple cores */
> >      if (cache->level == 3) {
> > -        l3_threads = topo_info->cores_per_die * topo_info->threads_per_core;
> > +        l3_threads = topo_info->modules_per_die *
> > +                     topo_info->cores_per_module *
> > +                     topo_info->threads_per_core;
> >          *eax |= (l3_threads - 1) << 14;
> >      } else {
> >          *eax |= ((topo_info->threads_per_core - 1) << 14);
> > @@ -6012,10 +6014,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >      uint32_t cpus_per_pkg;
> >  
> >      topo_info.dies_per_pkg = env->nr_dies;
> > -    topo_info.cores_per_die = cs->nr_cores / env->nr_dies;
> > +    topo_info.modules_per_die = env->nr_modules;
> > +    topo_info.cores_per_module = cs->nr_cores / env->nr_dies / env->nr_modules;
> >      topo_info.threads_per_core = cs->nr_threads;
> >  
> > -    cores_per_pkg = topo_info.cores_per_die * topo_info.dies_per_pkg;
> > +    cores_per_pkg = topo_info.cores_per_module * topo_info.modules_per_die *
> > +                    topo_info.dies_per_pkg;
> >      cpus_per_pkg = cores_per_pkg * topo_info.threads_per_core;
> >  
> >      /* Calculate & apply limits for different index ranges */
> > @@ -6286,7 +6290,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >              break;
> >          case 1:
> >              *eax = apicid_die_offset(&topo_info);
> > -            *ebx = topo_info.cores_per_die * topo_info.threads_per_core;
> > +            *ebx = cpus_per_pkg / topo_info.dies_per_pkg;
> >              *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
> >              break;
> >          case 2:
> > diff --git a/tests/unit/test-x86-topo.c b/tests/unit/test-x86-topo.c
> > index 2b104f86d7c2..f21b8a5d95c2 100644
> > --- a/tests/unit/test-x86-topo.c
> > +++ b/tests/unit/test-x86-topo.c
> > @@ -30,13 +30,16 @@ static void test_topo_bits(void)
> >  {
> >      X86CPUTopoInfo topo_info = {0};
> >  
> > -    /* simple tests for 1 thread per core, 1 core per die, 1 die per package */
> > -    topo_info = (X86CPUTopoInfo) {1, 1, 1};
> > +    /*
> > +     * simple tests for 1 thread per core, 1 core per module,
> > +     *                  1 module per die, 1 die per package
> > +     */
> > +    topo_info = (X86CPUTopoInfo) {1, 1, 1, 1};
> >      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 0);
> >      g_assert_cmpuint(apicid_core_width(&topo_info), ==, 0);
> >      g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
> >  
> > -    topo_info = (X86CPUTopoInfo) {1, 1, 1};
> > +    topo_info = (X86CPUTopoInfo) {1, 1, 1, 1};
> >      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
> >      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), ==, 1);
> >      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), ==, 2);
> > @@ -45,39 +48,39 @@ static void test_topo_bits(void)
> >  
> >      /* Test field width calculation for multiple values
> >       */
> > -    topo_info = (X86CPUTopoInfo) {1, 1, 2};
> > +    topo_info = (X86CPUTopoInfo) {1, 1, 1, 2};
> >      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 1);
> > -    topo_info = (X86CPUTopoInfo) {1, 1, 3};
> > +    topo_info = (X86CPUTopoInfo) {1, 1, 1, 3};
> >      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
> > -    topo_info = (X86CPUTopoInfo) {1, 1, 4};
> > +    topo_info = (X86CPUTopoInfo) {1, 1, 1, 4};
> >      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
> >  
> > -    topo_info = (X86CPUTopoInfo) {1, 1, 14};
> > +    topo_info = (X86CPUTopoInfo) {1, 1, 1, 14};
> >      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
> > -    topo_info = (X86CPUTopoInfo) {1, 1, 15};
> > +    topo_info = (X86CPUTopoInfo) {1, 1, 1, 15};
> >      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
> > -    topo_info = (X86CPUTopoInfo) {1, 1, 16};
> > +    topo_info = (X86CPUTopoInfo) {1, 1, 1, 16};
> >      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
> > -    topo_info = (X86CPUTopoInfo) {1, 1, 17};
> > +    topo_info = (X86CPUTopoInfo) {1, 1, 1, 17};
> >      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 5);
> >  
> >  
> > -    topo_info = (X86CPUTopoInfo) {1, 30, 2};
> > +    topo_info = (X86CPUTopoInfo) {1, 1, 30, 2};
> >      g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
> > -    topo_info = (X86CPUTopoInfo) {1, 31, 2};
> > +    topo_info = (X86CPUTopoInfo) {1, 1, 31, 2};
> >      g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
> > -    topo_info = (X86CPUTopoInfo) {1, 32, 2};
> > +    topo_info = (X86CPUTopoInfo) {1, 1, 32, 2};
> >      g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
> > -    topo_info = (X86CPUTopoInfo) {1, 33, 2};
> > +    topo_info = (X86CPUTopoInfo) {1, 1, 33, 2};
> >      g_assert_cmpuint(apicid_core_width(&topo_info), ==, 6);
> >  
> > -    topo_info = (X86CPUTopoInfo) {1, 30, 2};
> > +    topo_info = (X86CPUTopoInfo) {1, 1, 30, 2};
> >      g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
> > -    topo_info = (X86CPUTopoInfo) {2, 30, 2};
> > +    topo_info = (X86CPUTopoInfo) {2, 1, 30, 2};
> >      g_assert_cmpuint(apicid_die_width(&topo_info), ==, 1);
> > -    topo_info = (X86CPUTopoInfo) {3, 30, 2};
> > +    topo_info = (X86CPUTopoInfo) {3, 1, 30, 2};
> >      g_assert_cmpuint(apicid_die_width(&topo_info), ==, 2);
> > -    topo_info = (X86CPUTopoInfo) {4, 30, 2};
> > +    topo_info = (X86CPUTopoInfo) {4, 1, 30, 2};
> >      g_assert_cmpuint(apicid_die_width(&topo_info), ==, 2);
> >  
> >      /* build a weird topology and see if IDs are calculated correctly
> > @@ -85,18 +88,18 @@ static void test_topo_bits(void)
> >  
> >      /* This will use 2 bits for thread ID and 3 bits for core ID
> >       */
> > -    topo_info = (X86CPUTopoInfo) {1, 6, 3};
> > +    topo_info = (X86CPUTopoInfo) {1, 1, 6, 3};
> >      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
> >      g_assert_cmpuint(apicid_core_offset(&topo_info), ==, 2);
> >      g_assert_cmpuint(apicid_die_offset(&topo_info), ==, 5);
> >      g_assert_cmpuint(apicid_pkg_offset(&topo_info), ==, 5);
> >  
> > -    topo_info = (X86CPUTopoInfo) {1, 6, 3};
> > +    topo_info = (X86CPUTopoInfo) {1, 1, 6, 3};
> >      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
> >      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), ==, 1);
> >      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), ==, 2);
> >  
> > -    topo_info = (X86CPUTopoInfo) {1, 6, 3};
> > +    topo_info = (X86CPUTopoInfo) {1, 1, 6, 3};
> >      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 0), ==,
> >                       (1 << 2) | 0);
> >      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 1), ==,
> 
> -- 
> Thanks
> Babu Moger

