Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC3F771B11
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 09:04:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSuH5-000754-5S; Mon, 07 Aug 2023 03:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qSuH3-00074w-10
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 03:03:29 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qSuGz-0001Oa-FT
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 03:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691391805; x=1722927805;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=pEpZn/4/867jyHeAhAJDZFFP4bzwQgej6VQP9BaVZx0=;
 b=gBuR+nhvsidHQ6ARlKj36mkwRqNHEnhRUkWwRFvfIlHBVHP1JuPSs0oo
 wP9Hj73FPos38xzlUZdxXkRFWCUKc3vDJiaCtDs/XMch4ybIc33mUg3pf
 Sb25q5cIY/gpl2+MJfJMOhc9h/YAyEJj+2RFxbrk8Jue/W4BcYp6fpskW
 Hlg++XzsJzljCzkuhGpGt8oqd8kT1NV3wSsCEto7sVTYq2ynWZJbrCU/3
 6eZ+Uyu54mYsIDUMhi4/qnzRaFIeLylxxzLe9EtoMNarCNY7jlXvN7kDb
 A1KlkzA/EWQ23oQ3IoNvrUkUR0zS4so2m3loIll7CSkpLvuxtKdhFiKML A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="434319954"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; d="scan'208";a="434319954"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2023 00:03:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="854553762"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; d="scan'208";a="854553762"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.16.81])
 ([10.93.16.81])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2023 00:03:18 -0700
Message-ID: <17d46d49-844c-60ed-56cc-0e671564948a@intel.com>
Date: Mon, 7 Aug 2023 15:03:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v3 03/17] softmmu: Fix CPUSTATE.nr_cores' calculation
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Babu Moger <babu.moger@amd.com>, Zhao Liu <zhao1.liu@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-4-zhao1.liu@linux.intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20230801103527.397756-4-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.31; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -84
X-Spam_score: -8.5
X-Spam_bar: --------
X-Spam_report: (-8.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-4.139,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/1/2023 6:35 PM, Zhao Liu wrote:
> From: Zhuocheng Ding <zhuocheng.ding@intel.com>
> 
>  From CPUState.nr_cores' comment, it represents "number of cores within
> this CPU package".
> 
> After 003f230e37d7 ("machine: Tweak the order of topology members in
> struct CpuTopology"), the meaning of smp.cores changed to "the number of
> cores in one die", but this commit missed to change CPUState.nr_cores'
> caculation, so that CPUState.nr_cores became wrong and now it
> misses to consider numbers of clusters and dies.
> 
> At present, only i386 is using CPUState.nr_cores.
> 
> But as for i386, which supports die level, the uses of CPUState.nr_cores
> are very confusing:
> 
> Early uses are based on the meaning of "cores per package" (before die
> is introduced into i386), and later uses are based on "cores per die"
> (after die's introduction).
> 
> This difference is due to that commit a94e1428991f ("target/i386: Add
> CPUID.1F generation support for multi-dies PCMachine") misunderstood
> that CPUState.nr_cores means "cores per die" when caculated
> CPUID.1FH.01H:EBX. After that, the changes in i386 all followed this
> wrong understanding.
> 
> With the influence of 003f230e37d7 and a94e1428991f, for i386 currently
> the result of CPUState.nr_cores is "cores per die", thus the original
> uses of CPUState.cores based on the meaning of "cores per package" are
> wrong when mutiple dies exist:
> 1. In cpu_x86_cpuid() of target/i386/cpu.c, CPUID.01H:EBX[bits 23:16] is
>     incorrect because it expects "cpus per package" but now the
>     result is "cpus per die".
> 2. In cpu_x86_cpuid() of target/i386/cpu.c, for all leaves of CPUID.04H:
>     EAX[bits 31:26] is incorrect because they expect "cpus per package"
>     but now the result is "cpus per die". The error not only impacts the
>     EAX caculation in cache_info_passthrough case, but also impacts other
>     cases of setting cache topology for Intel CPU according to cpu
>     topology (specifically, the incoming parameter "num_cores" expects
>     "cores per package" in encode_cache_cpuid4()).
> 3. In cpu_x86_cpuid() of target/i386/cpu.c, CPUID.0BH.01H:EBX[bits
>     15:00] is incorrect because the EBX of 0BH.01H (core level) expects
>     "cpus per package", which may be different with 1FH.01H (The reason
>     is 1FH can support more levels. For QEMU, 1FH also supports die,
>     1FH.01H:EBX[bits 15:00] expects "cpus per die").
> 4. In cpu_x86_cpuid() of target/i386/cpu.c, when CPUID.80000001H is
>     caculated, here "cpus per package" is expected to be checked, but in
>     fact, now it checks "cpus per die". Though "cpus per die" also works
>     for this code logic, this isn't consistent with AMD's APM.
> 5. In cpu_x86_cpuid() of target/i386/cpu.c, CPUID.80000008H:ECX expects
>     "cpus per package" but it obtains "cpus per die".
> 6. In simulate_rdmsr() of target/i386/hvf/x86_emu.c, in
>     kvm_rdmsr_core_thread_count() of target/i386/kvm/kvm.c, and in
>     helper_rdmsr() of target/i386/tcg/sysemu/misc_helper.c,
>     MSR_CORE_THREAD_COUNT expects "cpus per package" and "cores per
>     package", but in these functions, it obtains "cpus per die" and
>     "cores per die".
> 
> On the other hand, these uses are correct now (they are added in/after
> a94e1428991f):
> 1. In cpu_x86_cpuid() of target/i386/cpu.c, topo_info.cores_per_die
>     meets the actual meaning of CPUState.nr_cores ("cores per die").
> 2. In cpu_x86_cpuid() of target/i386/cpu.c, vcpus_per_socket (in CPUID.
>     04H's caculation) considers number of dies, so it's correct.
> 3. In cpu_x86_cpuid() of target/i386/cpu.c, CPUID.1FH.01H:EBX[bits
>     15:00] needs "cpus per die" and it gets the correct result, and
>     CPUID.1FH.02H:EBX[bits 15:00] gets correct "cpus per package".
> 
> When CPUState.nr_cores is correctly changed to "cores per package" again
> , the above errors will be fixed without extra work, but the "currently"
> correct cases will go wrong and need special handling to pass correct
> "cpus/cores per die" they want.
> 
> Thus in this patch, we fix CPUState.nr_cores' caculation to fit the
> original meaning "cores per package", as well as changing calculation of
> topo_info.cores_per_die, vcpus_per_socket and CPUID.1FH.
> 
> In addition, in the nr_threads' comment, specify it represents the
> number of threads in the "core" to avoid confusion, and also add comment
> for nr_dies in CPUX86State.
> 
> Fixes: a94e1428991f ("target/i386: Add CPUID.1F generation support for multi-dies PCMachine")
> Fixes: 003f230e37d7 ("machine: Tweak the order of topology members in struct CpuTopology")
> Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
> Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changes since v2:
>   * Use wrapped helper to get cores per socket in qemu_init_vcpu().
> Changes since v1:
>   * Add comment for nr_dies in CPUX86State. (Yanan)
> ---
>   include/hw/core/cpu.h | 2 +-
>   softmmu/cpus.c        | 2 +-
>   target/i386/cpu.c     | 9 ++++-----
>   target/i386/cpu.h     | 1 +
>   4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index fdcbe8735258..57f4d50ace72 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -277,7 +277,7 @@ struct qemu_work_item;
>    *   See TranslationBlock::TCG CF_CLUSTER_MASK.
>    * @tcg_cflags: Pre-computed cflags for this cpu.
>    * @nr_cores: Number of cores within this CPU package.
> - * @nr_threads: Number of threads within this CPU.
> + * @nr_threads: Number of threads within this CPU core.

This seems to be better as a separate patch.

Besides, if could, I think it's better to rename them to 
nr_threads_per_core and nr_cores_per_pkg.

Side topic. Ideally, it seems redundant to maintain the @nr_threads and 
@nr_cores in struct CPUState because we have ms->smp to carry all the 
topology info. However, various codes across different arches use 
@nr_threads and @nr_cores. It looks painful to get rid of it or use 
something else to replace it.

>    * @running: #true if CPU is currently running (lockless).
>    * @has_waiter: #true if a CPU is currently waiting for the cpu_exec_end;
>    * valid under cpu_list_lock.
> diff --git a/softmmu/cpus.c b/softmmu/cpus.c
> index fed20ffb5dd2..984558d7b245 100644
> --- a/softmmu/cpus.c
> +++ b/softmmu/cpus.c
> @@ -630,7 +630,7 @@ void qemu_init_vcpu(CPUState *cpu)
>   {
>       MachineState *ms = MACHINE(qdev_get_machine());
>   
> -    cpu->nr_cores = ms->smp.cores;
> +    cpu->nr_cores = machine_topo_get_cores_per_socket(ms);
>       cpu->nr_threads =  ms->smp.threads;
>       cpu->stopped = true;
>       cpu->random_seed = qemu_guest_random_seed_thread_part1();
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 97ad229d8ba3..50613cd04612 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6011,7 +6011,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>       X86CPUTopoInfo topo_info;
>   
>       topo_info.dies_per_pkg = env->nr_dies;
> -    topo_info.cores_per_die = cs->nr_cores;
> +    topo_info.cores_per_die = cs->nr_cores / env->nr_dies;

This and below things make me think that, it looks ugly that @nr_dies is 
added separately in struct CPUArchState for i386 because CPUState only 
has @nr_cores and nr_threads. Further, for i386, it defines a specific 
struct X86CPUTopoInfo to contain topology info when setting up CPUID. To 
me, struct X86CPUTopoInfo is redundant as struct CpuTopology.

maybe we can carry a struct CpuTopology in CPUState, so that we can drop 
@nr_threads, @nr_cores in CPUState for all ARCHes, and @nr_dies in 
struct CPUArchState for i386. As well, topo_info can be dropped here.

>       topo_info.threads_per_core = cs->nr_threads;
>   
>       /* Calculate & apply limits for different index ranges */
> @@ -6087,8 +6087,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>                */
>               if (*eax & 31) {
>                   int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
> -                int vcpus_per_socket = env->nr_dies * cs->nr_cores *
> -                                       cs->nr_threads;
> +                int vcpus_per_socket = cs->nr_cores * cs->nr_threads;
>                   if (cs->nr_cores > 1) {
>                       *eax &= ~0xFC000000;
>                       *eax |= (pow2ceil(cs->nr_cores) - 1) << 26;
> @@ -6266,12 +6265,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>               break;
>           case 1:
>               *eax = apicid_die_offset(&topo_info);
> -            *ebx = cs->nr_cores * cs->nr_threads;
> +            *ebx = topo_info.cores_per_die * topo_info.threads_per_core;
>               *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
>               break;
>           case 2:
>               *eax = apicid_pkg_offset(&topo_info);
> -            *ebx = env->nr_dies * cs->nr_cores * cs->nr_threads;
> +            *ebx = cs->nr_cores * cs->nr_threads;
>               *ecx |= CPUID_TOPOLOGY_LEVEL_DIE;
>               break;
>           default:
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index e0771a10433b..7638128d59cc 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1878,6 +1878,7 @@ typedef struct CPUArchState {
>   
>       TPRAccess tpr_access_type;
>   
> +    /* Number of dies within this CPU package. */
>       unsigned nr_dies;
>   } CPUX86State;
>   


