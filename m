Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F5D771BBA
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 09:44:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSutU-0000Bi-K7; Mon, 07 Aug 2023 03:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qSutI-0000BS-Ml
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 03:43:01 -0400
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qSutA-0002p8-Sd
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 03:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691394172; x=1722930172;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=49hLyGEKx+5+7Eyw6N5RWnB2cRrKMm+TO1SF+YtBP24=;
 b=HADOVTPrQC8YuN2GxX7wl9Y0muN+xHd7Uo9IyoMGfQr83ULt507IF1Rk
 V6XNRDlfDO6tJuzhAggSuJL/ErNNUtgE9P4lWQAa6HBBhjVldUOA+d3s6
 DphjUYHKxgyo8zn7EkkE3XmtMXgL797weUZx3SJYAHoEAMfXcUWUTI21Z
 CKAr+rdpxxFTred/J7d7MAVXYpqkwxWPw+uzAHH1JLwHNXmXsrizteQNv
 xkJzrXx35xdUtcxWnnnLw+V4lcHXY0cnT31BNJYVLkVgCpmp5MINOx+k8
 txeHRTqqoT/pfBmOzEixd8I0a045p0mEWzZKsSUN+wIRmelycYbRgtCgH Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="370476508"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; d="scan'208";a="370476508"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2023 00:42:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="707756157"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; d="scan'208";a="707756157"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by orsmga006.jf.intel.com with ESMTP; 07 Aug 2023 00:42:45 -0700
Date: Mon, 7 Aug 2023 15:53:14 +0800
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
 Zhuocheng Ding <zhuocheng.ding@intel.com>
Subject: Re: [PATCH v3 03/17] softmmu: Fix CPUSTATE.nr_cores' calculation
Message-ID: <ZNCi6uNsVB1F39XD@liuzhao-OptiPlex-7080>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-4-zhao1.liu@linux.intel.com>
 <17d46d49-844c-60ed-56cc-0e671564948a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17d46d49-844c-60ed-56cc-0e671564948a@intel.com>
Received-SPF: none client-ip=192.55.52.115;
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

On Mon, Aug 07, 2023 at 03:03:13PM +0800, Xiaoyao Li wrote:
> Date: Mon, 7 Aug 2023 15:03:13 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH v3 03/17] softmmu: Fix CPUSTATE.nr_cores' calculation
> 
> On 8/1/2023 6:35 PM, Zhao Liu wrote:
> > From: Zhuocheng Ding <zhuocheng.ding@intel.com>
> > 
> >  From CPUState.nr_cores' comment, it represents "number of cores within
> > this CPU package".
> > 
> > After 003f230e37d7 ("machine: Tweak the order of topology members in
> > struct CpuTopology"), the meaning of smp.cores changed to "the number of
> > cores in one die", but this commit missed to change CPUState.nr_cores'
> > caculation, so that CPUState.nr_cores became wrong and now it
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
> > that CPUState.nr_cores means "cores per die" when caculated
> > CPUID.1FH.01H:EBX. After that, the changes in i386 all followed this
> > wrong understanding.
> > 
> > With the influence of 003f230e37d7 and a94e1428991f, for i386 currently
> > the result of CPUState.nr_cores is "cores per die", thus the original
> > uses of CPUState.cores based on the meaning of "cores per package" are
> > wrong when mutiple dies exist:
> > 1. In cpu_x86_cpuid() of target/i386/cpu.c, CPUID.01H:EBX[bits 23:16] is
> >     incorrect because it expects "cpus per package" but now the
> >     result is "cpus per die".
> > 2. In cpu_x86_cpuid() of target/i386/cpu.c, for all leaves of CPUID.04H:
> >     EAX[bits 31:26] is incorrect because they expect "cpus per package"
> >     but now the result is "cpus per die". The error not only impacts the
> >     EAX caculation in cache_info_passthrough case, but also impacts other
> >     cases of setting cache topology for Intel CPU according to cpu
> >     topology (specifically, the incoming parameter "num_cores" expects
> >     "cores per package" in encode_cache_cpuid4()).
> > 3. In cpu_x86_cpuid() of target/i386/cpu.c, CPUID.0BH.01H:EBX[bits
> >     15:00] is incorrect because the EBX of 0BH.01H (core level) expects
> >     "cpus per package", which may be different with 1FH.01H (The reason
> >     is 1FH can support more levels. For QEMU, 1FH also supports die,
> >     1FH.01H:EBX[bits 15:00] expects "cpus per die").
> > 4. In cpu_x86_cpuid() of target/i386/cpu.c, when CPUID.80000001H is
> >     caculated, here "cpus per package" is expected to be checked, but in
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
> >     04H's caculation) considers number of dies, so it's correct.
> > 3. In cpu_x86_cpuid() of target/i386/cpu.c, CPUID.1FH.01H:EBX[bits
> >     15:00] needs "cpus per die" and it gets the correct result, and
> >     CPUID.1FH.02H:EBX[bits 15:00] gets correct "cpus per package".
> > 
> > When CPUState.nr_cores is correctly changed to "cores per package" again
> > , the above errors will be fixed without extra work, but the "currently"
> > correct cases will go wrong and need special handling to pass correct
> > "cpus/cores per die" they want.
> > 
> > Thus in this patch, we fix CPUState.nr_cores' caculation to fit the
> > original meaning "cores per package", as well as changing calculation of
> > topo_info.cores_per_die, vcpus_per_socket and CPUID.1FH.
> > 
> > In addition, in the nr_threads' comment, specify it represents the
> > number of threads in the "core" to avoid confusion, and also add comment
> > for nr_dies in CPUX86State.
> > 
> > Fixes: a94e1428991f ("target/i386: Add CPUID.1F generation support for multi-dies PCMachine")
> > Fixes: 003f230e37d7 ("machine: Tweak the order of topology members in struct CpuTopology")
> > Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
> > Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> > Changes since v2:
> >   * Use wrapped helper to get cores per socket in qemu_init_vcpu().
> > Changes since v1:
> >   * Add comment for nr_dies in CPUX86State. (Yanan)
> > ---
> >   include/hw/core/cpu.h | 2 +-
> >   softmmu/cpus.c        | 2 +-
> >   target/i386/cpu.c     | 9 ++++-----
> >   target/i386/cpu.h     | 1 +
> >   4 files changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > index fdcbe8735258..57f4d50ace72 100644
> > --- a/include/hw/core/cpu.h
> > +++ b/include/hw/core/cpu.h
> > @@ -277,7 +277,7 @@ struct qemu_work_item;
> >    *   See TranslationBlock::TCG CF_CLUSTER_MASK.
> >    * @tcg_cflags: Pre-computed cflags for this cpu.
> >    * @nr_cores: Number of cores within this CPU package.
> > - * @nr_threads: Number of threads within this CPU.
> > + * @nr_threads: Number of threads within this CPU core.
> 
> This seems to be better as a separate patch.

Ok, I can spilt it into a new patch in v4.

> 
> Besides, if could, I think it's better to rename them to nr_threads_per_core
> and nr_cores_per_pkg.

Yeah, the names nr_threads and nr_cores are more historical, having been
around for a long time. With more CPU topology levels available today,
it's really worth reconsidering the names.

In the previous RFC of hybrid topology [1], I proposed the new structure
to replace nr_threads/nr_cores:

typedef struct TopologyState {
    int sockets;
    int cores_per_socket;
    int threads_per_socket;
    int dies_per_socket;
    int clusters_per_die;
    int cores_per_cluster;
    int threads_per_core;
} TopologyState;

I'm still working on hybrid topology, and I'll continue to follow up on
this cleanup! :-)

[1]: https://mail.gnu.org/archive/html/qemu-devel/2023-02/msg03235.html

> 
> Side topic. Ideally, it seems redundant to maintain the @nr_threads and
> @nr_cores in struct CPUState because we have ms->smp to carry all the
> topology info. However, various codes across different arches use
> @nr_threads and @nr_cores. It looks painful to get rid of it or use
> something else to replace it.

IIUC, user emulator needs the topology info in CPUState. System emulator
could use ms->smp directly.

> 
> >    * @running: #true if CPU is currently running (lockless).
> >    * @has_waiter: #true if a CPU is currently waiting for the cpu_exec_end;
> >    * valid under cpu_list_lock.
> > diff --git a/softmmu/cpus.c b/softmmu/cpus.c
> > index fed20ffb5dd2..984558d7b245 100644
> > --- a/softmmu/cpus.c
> > +++ b/softmmu/cpus.c
> > @@ -630,7 +630,7 @@ void qemu_init_vcpu(CPUState *cpu)
> >   {
> >       MachineState *ms = MACHINE(qdev_get_machine());
> > -    cpu->nr_cores = ms->smp.cores;
> > +    cpu->nr_cores = machine_topo_get_cores_per_socket(ms);
> >       cpu->nr_threads =  ms->smp.threads;
> >       cpu->stopped = true;
> >       cpu->random_seed = qemu_guest_random_seed_thread_part1();
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 97ad229d8ba3..50613cd04612 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -6011,7 +6011,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >       X86CPUTopoInfo topo_info;
> >       topo_info.dies_per_pkg = env->nr_dies;
> > -    topo_info.cores_per_die = cs->nr_cores;
> > +    topo_info.cores_per_die = cs->nr_cores / env->nr_dies;
> 
> This and below things make me think that, it looks ugly that @nr_dies is
> added separately in struct CPUArchState for i386 because CPUState only has
> @nr_cores and nr_threads. Further, for i386, it defines a specific struct
> X86CPUTopoInfo to contain topology info when setting up CPUID. To me, struct
> X86CPUTopoInfo is redundant as struct CpuTopology.
> 
> maybe we can carry a struct CpuTopology in CPUState, so that we can drop
> @nr_threads, @nr_cores in CPUState for all ARCHes, and @nr_dies in struct
> CPUArchState for i386. As well, topo_info can be dropped here.

Yeah, I agree. We think the same way, as did in [1].

About X86CPUTopoInfo, it's still necessary to keep to help encode
APICID. For hybrid topology case, the APICID is likely discontinuous,
and the width of each CPU level in APICID depends on the maximum number
of elements in this level. So I also proposed to rename it to
X86ApicidTopoInfo [2] and count the maximum number of elements in each
CPU level.

[2]: https://mail.gnu.org/archive/html/qemu-devel/2023-02/msg03237.html

Thanks,
Zhao

> 
> >       topo_info.threads_per_core = cs->nr_threads;
> >       /* Calculate & apply limits for different index ranges */
> > @@ -6087,8 +6087,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >                */
> >               if (*eax & 31) {
> >                   int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
> > -                int vcpus_per_socket = env->nr_dies * cs->nr_cores *
> > -                                       cs->nr_threads;
> > +                int vcpus_per_socket = cs->nr_cores * cs->nr_threads;
> >                   if (cs->nr_cores > 1) {
> >                       *eax &= ~0xFC000000;
> >                       *eax |= (pow2ceil(cs->nr_cores) - 1) << 26;
> > @@ -6266,12 +6265,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index e0771a10433b..7638128d59cc 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -1878,6 +1878,7 @@ typedef struct CPUArchState {
> >       TPRAccess tpr_access_type;
> > +    /* Number of dies within this CPU package. */
> >       unsigned nr_dies;
> >   } CPUX86State;
> 

