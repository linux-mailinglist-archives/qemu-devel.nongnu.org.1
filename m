Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECAC76FBAB
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 10:08:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRpr0-00037p-31; Fri, 04 Aug 2023 04:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qRpqw-00031U-Q5
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 04:08:07 -0400
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qRpqu-0001Se-Q8
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 04:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691136484; x=1722672484;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=o3rW56g7RfPZKGhUOzyEHy2PbaFY9RtYPHmk5hwPaDE=;
 b=fNaGrojrXnAkmhzaTiYtjB4aObsZ19Yz/T8JIdA5h7XXK+AAkO3Wy1IR
 3KXyRU4ySxeaDV1PSuF1Fuq5nA5dM6UcqKrwLDtmS4yuofJi7lJDSaVTT
 sidkxekkKTJqCutOYtQ8JGEWRj+yIpP6hjpGEkHuDv7V0pr2Y5klw1I/U
 yVcs8uqXhHqemOlCfy6SuBHcnHNHqUcL2y421L6RNJ7nPSwdR4d9kuR+G
 rqw2EDwfJRsBpYa0xm5mUWyfIN27EUrqya14U6T7KEWbMiRQU7K++TFYF
 MwcFRUoVc4K2RdMYZbUizsJOT5mGD+NXZMjw5O1TO3ESrk0naGergLSEJ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="401053938"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; d="scan'208";a="401053938"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2023 01:06:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="723553384"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; d="scan'208";a="723553384"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by orsmga007.jf.intel.com with ESMTP; 04 Aug 2023 01:06:23 -0700
Date: Fri, 4 Aug 2023 16:16:51 +0800
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
Subject: Re: [PATCH v3 03/17] softmmu: Fix CPUSTATE.nr_cores' calculation
Message-ID: <ZMyz82EjuASaFsxg@liuzhao-OptiPlex-7080>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-4-zhao1.liu@linux.intel.com>
 <275a4850-2d70-4a6e-a72e-5c3fd20f98ba@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <275a4850-2d70-4a6e-a72e-5c3fd20f98ba@amd.com>
Received-SPF: none client-ip=192.55.52.88;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Babu,

On Wed, Aug 02, 2023 at 10:25:58AM -0500, Moger, Babu wrote:
> Date: Wed, 2 Aug 2023 10:25:58 -0500
> From: "Moger, Babu" <babu.moger@amd.com>
> Subject: Re: [PATCH v3 03/17] softmmu: Fix CPUSTATE.nr_cores' calculation
> 
> Hi Zhao,
> 
> On 8/1/23 05:35, Zhao Liu wrote:
> > From: Zhuocheng Ding <zhuocheng.ding@intel.com>
> > 
> > From CPUState.nr_cores' comment, it represents "number of cores within
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
> >    incorrect because it expects "cpus per package" but now the
> >    result is "cpus per die".
> > 2. In cpu_x86_cpuid() of target/i386/cpu.c, for all leaves of CPUID.04H:
> >    EAX[bits 31:26] is incorrect because they expect "cpus per package"
> >    but now the result is "cpus per die". The error not only impacts the
> >    EAX caculation in cache_info_passthrough case, but also impacts other
> >    cases of setting cache topology for Intel CPU according to cpu
> >    topology (specifically, the incoming parameter "num_cores" expects
> >    "cores per package" in encode_cache_cpuid4()).
> > 3. In cpu_x86_cpuid() of target/i386/cpu.c, CPUID.0BH.01H:EBX[bits
> >    15:00] is incorrect because the EBX of 0BH.01H (core level) expects
> >    "cpus per package", which may be different with 1FH.01H (The reason
> >    is 1FH can support more levels. For QEMU, 1FH also supports die,
> >    1FH.01H:EBX[bits 15:00] expects "cpus per die").
> > 4. In cpu_x86_cpuid() of target/i386/cpu.c, when CPUID.80000001H is
> >    caculated, here "cpus per package" is expected to be checked, but in
> >    fact, now it checks "cpus per die". Though "cpus per die" also works
> >    for this code logic, this isn't consistent with AMD's APM.
> > 5. In cpu_x86_cpuid() of target/i386/cpu.c, CPUID.80000008H:ECX expects
> >    "cpus per package" but it obtains "cpus per die".
> > 6. In simulate_rdmsr() of target/i386/hvf/x86_emu.c, in
> >    kvm_rdmsr_core_thread_count() of target/i386/kvm/kvm.c, and in
> >    helper_rdmsr() of target/i386/tcg/sysemu/misc_helper.c,
> >    MSR_CORE_THREAD_COUNT expects "cpus per package" and "cores per
> >    package", but in these functions, it obtains "cpus per die" and
> >    "cores per die".
> > 
> > On the other hand, these uses are correct now (they are added in/after
> > a94e1428991f):
> > 1. In cpu_x86_cpuid() of target/i386/cpu.c, topo_info.cores_per_die
> >    meets the actual meaning of CPUState.nr_cores ("cores per die").
> > 2. In cpu_x86_cpuid() of target/i386/cpu.c, vcpus_per_socket (in CPUID.
> >    04H's caculation) considers number of dies, so it's correct.
> > 3. In cpu_x86_cpuid() of target/i386/cpu.c, CPUID.1FH.01H:EBX[bits
> >    15:00] needs "cpus per die" and it gets the correct result, and
> >    CPUID.1FH.02H:EBX[bits 15:00] gets correct "cpus per package".
> > 
> > When CPUState.nr_cores is correctly changed to "cores per package" again
> > , the above errors will be fixed without extra work, but the "currently"
> > correct cases will go wrong and need special handling to pass correct
> > "cpus/cores per die" they want.
> > 
> > Thus in this patch, we fix CPUState.nr_cores' caculation to fit the
> 
> s/Thus in this patch, we fix CPUState.nr_cores' caculation/Fix
> CPUState.nr_cores' calculation/

Thanks!

> 
> 
> Describe your changes in imperative mood also spell check.

Thanks for your suggestion!

-Zhao

> 
> 
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
> >  * Use wrapped helper to get cores per socket in qemu_init_vcpu().
> > Changes since v1:
> >  * Add comment for nr_dies in CPUX86State. (Yanan)
> > ---
> >  include/hw/core/cpu.h | 2 +-
> >  softmmu/cpus.c        | 2 +-
> >  target/i386/cpu.c     | 9 ++++-----
> >  target/i386/cpu.h     | 1 +
> >  4 files changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > index fdcbe8735258..57f4d50ace72 100644
> > --- a/include/hw/core/cpu.h
> > +++ b/include/hw/core/cpu.h
> > @@ -277,7 +277,7 @@ struct qemu_work_item;
> >   *   See TranslationBlock::TCG CF_CLUSTER_MASK.
> >   * @tcg_cflags: Pre-computed cflags for this cpu.
> >   * @nr_cores: Number of cores within this CPU package.
> > - * @nr_threads: Number of threads within this CPU.
> > + * @nr_threads: Number of threads within this CPU core.
> >   * @running: #true if CPU is currently running (lockless).
> >   * @has_waiter: #true if a CPU is currently waiting for the cpu_exec_end;
> >   * valid under cpu_list_lock.
> > diff --git a/softmmu/cpus.c b/softmmu/cpus.c
> > index fed20ffb5dd2..984558d7b245 100644
> > --- a/softmmu/cpus.c
> > +++ b/softmmu/cpus.c
> > @@ -630,7 +630,7 @@ void qemu_init_vcpu(CPUState *cpu)
> >  {
> >      MachineState *ms = MACHINE(qdev_get_machine());
> >  
> > -    cpu->nr_cores = ms->smp.cores;
> > +    cpu->nr_cores = machine_topo_get_cores_per_socket(ms);
> >      cpu->nr_threads =  ms->smp.threads;
> >      cpu->stopped = true;
> >      cpu->random_seed = qemu_guest_random_seed_thread_part1();
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 97ad229d8ba3..50613cd04612 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -6011,7 +6011,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >      X86CPUTopoInfo topo_info;
> >  
> >      topo_info.dies_per_pkg = env->nr_dies;
> > -    topo_info.cores_per_die = cs->nr_cores;
> > +    topo_info.cores_per_die = cs->nr_cores / env->nr_dies;
> >      topo_info.threads_per_core = cs->nr_threads;
> >  
> >      /* Calculate & apply limits for different index ranges */
> > @@ -6087,8 +6087,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >               */
> >              if (*eax & 31) {
> >                  int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
> > -                int vcpus_per_socket = env->nr_dies * cs->nr_cores *
> > -                                       cs->nr_threads;
> > +                int vcpus_per_socket = cs->nr_cores * cs->nr_threads;
> >                  if (cs->nr_cores > 1) {
> >                      *eax &= ~0xFC000000;
> >                      *eax |= (pow2ceil(cs->nr_cores) - 1) << 26;
> > @@ -6266,12 +6265,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >              break;
> >          case 1:
> >              *eax = apicid_die_offset(&topo_info);
> > -            *ebx = cs->nr_cores * cs->nr_threads;
> > +            *ebx = topo_info.cores_per_die * topo_info.threads_per_core;
> >              *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
> >              break;
> >          case 2:
> >              *eax = apicid_pkg_offset(&topo_info);
> > -            *ebx = env->nr_dies * cs->nr_cores * cs->nr_threads;
> > +            *ebx = cs->nr_cores * cs->nr_threads;
> >              *ecx |= CPUID_TOPOLOGY_LEVEL_DIE;
> >              break;
> >          default:
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index e0771a10433b..7638128d59cc 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -1878,6 +1878,7 @@ typedef struct CPUArchState {
> >  
> >      TPRAccess tpr_access_type;
> >  
> > +    /* Number of dies within this CPU package. */
> >      unsigned nr_dies;
> >  } CPUX86State;
> >  
> 
> -- 
> Thanks
> Babu Moger

