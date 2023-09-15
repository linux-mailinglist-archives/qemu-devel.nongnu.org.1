Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F13597A176F
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 09:29:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh3G5-0002J9-SK; Fri, 15 Sep 2023 03:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qh3Fy-0002IY-Mu
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 03:28:50 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qh3Fw-0006NW-0r
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 03:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694762928; x=1726298928;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=CtOBPQZyUBN5NDue58Zh64Cy4DA7T1sPgVLCsteFWak=;
 b=kQpDpKKc14W1/kWTF0BN0ZmQmfRl0GXpQRDoOkhwairoVuWvSgZTIkxa
 oaq+WHQ9Zm3NVRH9jd4uGtwKqoLAoqGKTuhtb5zsffoSP8cnJaARJ4/h2
 v4q8Z8rym1juOsY1nuheDX8t5v/LGQsn7VlLJsW7iZdfp4LO4rWrchBA6
 wk+Vh7c234WtjR2YRT1mQM6l+Gj7zhQfKVUd0z9/5mBiKdH5QACCci/xa
 SRVU9OlSqELmYkfZCCBbctaS+h9ByOh9AepbA9M6rYIrS8BXLm8eBhM/N
 +4sNWgLJoFiOy7uW76caA5PrDi7WIqJ3fGtOqKy3mCQLBPeO53XYuFB+g Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="358597077"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; d="scan'208";a="358597077"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2023 00:28:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="918558582"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; d="scan'208";a="918558582"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga005.jf.intel.com with ESMTP; 15 Sep 2023 00:28:39 -0700
Date: Fri, 15 Sep 2023 15:39:41 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Babu Moger <babu.moger@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>, Zhuocheng Ding <zhuocheng.ding@intel.com>
Subject: Re: [PATCH v4 03/21] softmmu: Fix CPUSTATE.nr_cores' calculation
Message-ID: <ZQQKPbiMSV3s+h0Z@liuzhao-OptiPlex-7080>
References: <20230914072159.1177582-1-zhao1.liu@linux.intel.com>
 <20230914072159.1177582-4-zhao1.liu@linux.intel.com>
 <b6f8be4e-2c47-95ec-c29c-dcca67d882ae@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6f8be4e-2c47-95ec-c29c-dcca67d882ae@linaro.org>
Received-SPF: none client-ip=192.55.52.136;
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

Hi Philippe,

On Thu, Sep 14, 2023 at 09:31:52AM +0200, Philippe Mathieu-Daud¨¦ wrote:
> Date: Thu, 14 Sep 2023 09:31:52 +0200
> From: Philippe Mathieu-Daud¨¦ <philmd@linaro.org>
> Subject: Re: [PATCH v4 03/21] softmmu: Fix CPUSTATE.nr_cores' calculation
> 
> Hi,
> 
> On 14/9/23 09:21, Zhao Liu wrote:
> > From: Zhuocheng Ding <zhuocheng.ding@intel.com>
> > 
> >  From CPUState.nr_cores' comment, it represents "number of cores within
> > this CPU package".
> > 
> > After 003f230e37d7 ("machine: Tweak the order of topology members in
> > struct CpuTopology"), the meaning of smp.cores changed to "the number of
> > cores in one die", but this commit missed to change CPUState.nr_cores'
> > calculation, so that CPUState.nr_cores became wrong and now it
> > misses to consider numbers of clusters and dies.
> > 
> > At present, only i386 is using CPUState.nr_cores.
> > 
> > But as for i386, which supports die level, the uses of CPUState.nr_cores
> > are very confusing:
> > 
> > Early uses are based on the meaning of "cores per package" (before die
> > is introduced into i386), and later uses are based on "cores per die"
> > (after die's introduction).
> > 
> > This difference is due to that commit a94e1428991f ("target/i386: Add
> > CPUID.1F generation support for multi-dies PCMachine") misunderstood
> > that CPUState.nr_cores means "cores per die" when calculated
> > CPUID.1FH.01H:EBX. After that, the changes in i386 all followed this
> > wrong understanding.
> > 
> > With the influence of 003f230e37d7 and a94e1428991f, for i386 currently
> > the result of CPUState.nr_cores is "cores per die", thus the original
> > uses of CPUState.cores based on the meaning of "cores per package" are
> > wrong when multiple dies exist:
> > 1. In cpu_x86_cpuid() of target/i386/cpu.c, CPUID.01H:EBX[bits 23:16] is
> >     incorrect because it expects "cpus per package" but now the
> >     result is "cpus per die".
> > 2. In cpu_x86_cpuid() of target/i386/cpu.c, for all leaves of CPUID.04H:
> >     EAX[bits 31:26] is incorrect because they expect "cpus per package"
> >     but now the result is "cpus per die". The error not only impacts the
> >     EAX calculation in cache_info_passthrough case, but also impacts other
> >     cases of setting cache topology for Intel CPU according to cpu
> >     topology (specifically, the incoming parameter "num_cores" expects
> >     "cores per package" in encode_cache_cpuid4()).
> > 3. In cpu_x86_cpuid() of target/i386/cpu.c, CPUID.0BH.01H:EBX[bits
> >     15:00] is incorrect because the EBX of 0BH.01H (core level) expects
> >     "cpus per package", which may be different with 1FH.01H (The reason
> >     is 1FH can support more levels. For QEMU, 1FH also supports die,
> >     1FH.01H:EBX[bits 15:00] expects "cpus per die").
> > 4. In cpu_x86_cpuid() of target/i386/cpu.c, when CPUID.80000001H is
> >     calculated, here "cpus per package" is expected to be checked, but in
> >     fact, now it checks "cpus per die". Though "cpus per die" also works
> >     for this code logic, this isn't consistent with AMD's APM.
> > 5. In cpu_x86_cpuid() of target/i386/cpu.c, CPUID.80000008H:ECX expects
> >     "cpus per package" but it obtains "cpus per die".
> > 6. In simulate_rdmsr() of target/i386/hvf/x86_emu.c, in
> >     kvm_rdmsr_core_thread_count() of target/i386/kvm/kvm.c, and in
> >     helper_rdmsr() of target/i386/tcg/sysemu/misc_helper.c,
> >     MSR_CORE_THREAD_COUNT expects "cpus per package" and "cores per
> >     package", but in these functions, it obtains "cpus per die" and
> >     "cores per die".
> > 
> > On the other hand, these uses are correct now (they are added in/after
> > a94e1428991f):
> > 1. In cpu_x86_cpuid() of target/i386/cpu.c, topo_info.cores_per_die
> >     meets the actual meaning of CPUState.nr_cores ("cores per die").
> > 2. In cpu_x86_cpuid() of target/i386/cpu.c, vcpus_per_socket (in CPUID.
> >     04H's calculation) considers number of dies, so it's correct.
> > 3. In cpu_x86_cpuid() of target/i386/cpu.c, CPUID.1FH.01H:EBX[bits
> >     15:00] needs "cpus per die" and it gets the correct result, and
> >     CPUID.1FH.02H:EBX[bits 15:00] gets correct "cpus per package".
> > 
> > When CPUState.nr_cores is correctly changed to "cores per package" again
> > , the above errors will be fixed without extra work, but the "currently"
> > correct cases will go wrong and need special handling to pass correct
> > "cpus/cores per die" they want.
> > 
> > Fix CPUState.nr_cores' calculation to fit the original meaning "cores
> > per package", as well as changing calculation of topo_info.cores_per_die,
> > vcpus_per_socket and CPUID.1FH.
> 
> What a pain. Can we split this patch in 2, first the x86 part
> and then the common part (softmmu/cpus.c)?

Since x86 uses this nr_cores to calculate many things, if the first
patch just fix nr_cores without changing x86 related code, then that
first patch will break many places (there will be many incorrect CPUIDs).

So I think it¡¯s more appropriate to make these changes into one patch.

Thanks,
Zhao

> 
> > Fixes: a94e1428991f ("target/i386: Add CPUID.1F generation support for multi-dies PCMachine")
> > Fixes: 003f230e37d7 ("machine: Tweak the order of topology members in struct CpuTopology")
> > Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
> > Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> > Changes since v3:
> >   * Describe changes in imperative mood. (Babu)
> >   * Fix spelling typo. (Babu)
> >   * Split the comment change into a separate patch. (Xiaoyao)
> > 
> > Changes since v2:
> >   * Use wrapped helper to get cores per socket in qemu_init_vcpu().
> > 
> > Changes since v1:
> >   * Add comment for nr_dies in CPUX86State. (Yanan)
> > ---
> >   softmmu/cpus.c    | 2 +-
> >   target/i386/cpu.c | 9 ++++-----
> >   2 files changed, 5 insertions(+), 6 deletions(-)
> > 
> > diff --git a/softmmu/cpus.c b/softmmu/cpus.c
> > index 0848e0dbdb3f..fa8239c217ff 100644
> > --- a/softmmu/cpus.c
> > +++ b/softmmu/cpus.c
> > @@ -624,7 +624,7 @@ void qemu_init_vcpu(CPUState *cpu)
> >   {
> >       MachineState *ms = MACHINE(qdev_get_machine());
> > -    cpu->nr_cores = ms->smp.cores;
> > +    cpu->nr_cores = machine_topo_get_cores_per_socket(ms);
> >       cpu->nr_threads =  ms->smp.threads;
> >       cpu->stopped = true;
> >       cpu->random_seed = qemu_guest_random_seed_thread_part1();
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 24ee67b42d05..709c055c8468 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -6015,7 +6015,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >       X86CPUTopoInfo topo_info;
> >       topo_info.dies_per_pkg = env->nr_dies;
> > -    topo_info.cores_per_die = cs->nr_cores;
> > +    topo_info.cores_per_die = cs->nr_cores / env->nr_dies;
> >       topo_info.threads_per_core = cs->nr_threads;
> >       /* Calculate & apply limits for different index ranges */
> > @@ -6091,8 +6091,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >                */
> >               if (*eax & 31) {
> >                   int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
> > -                int vcpus_per_socket = env->nr_dies * cs->nr_cores *
> > -                                       cs->nr_threads;
> > +                int vcpus_per_socket = cs->nr_cores * cs->nr_threads;
> >                   if (cs->nr_cores > 1) {
> >                       *eax &= ~0xFC000000;
> >                       *eax |= (pow2ceil(cs->nr_cores) - 1) << 26;
> > @@ -6270,12 +6269,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >               break;
> >           case 1:
> >               *eax = apicid_die_offset(&topo_info);
> > -            *ebx = cs->nr_cores * cs->nr_threads;
> > +            *ebx = topo_info.cores_per_die * topo_info.threads_per_core;
> >               *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
> >               break;
> >           case 2:
> >               *eax = apicid_pkg_offset(&topo_info);
> > -            *ebx = env->nr_dies * cs->nr_cores * cs->nr_threads;
> > +            *ebx = cs->nr_cores * cs->nr_threads;
> >               *ecx |= CPUID_TOPOLOGY_LEVEL_DIE;
> >               break;
> >           default:
> 

