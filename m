Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CF076FBC1
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 10:14:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRpwE-0006GP-1N; Fri, 04 Aug 2023 04:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qRpwC-0006GF-Hm
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 04:13:32 -0400
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qRpwA-0003PD-IL
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 04:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691136810; x=1722672810;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=aangjT9AAuLzr3taMjaBp8tQSVQaBgPCmOPsCfcW2E4=;
 b=bk7xjb7WulaqLin7VEy1gTzq09mAkld2AjuHqbR7esZWbIasEy015MF/
 Yv31bYd2l2LvLGO7GWSgoYvH4DGEbjE4y8iqK1g+G+FjzsHr5S/qtS1wf
 0ekvlqDDap5DOju0GKiFGp49m24MPQiUQV2uNivV+uNHg5ZXeHF4LE7Vy
 M802EJzAlhgoYMS8khLTf8+0nUIVx6fvjaNSZ8d0LHx13PIDDzaH67Fnf
 MCB8ynZTR0LNz39TV5CZ3ZwjNO6H7BNw9dJppoOLRHqu8/A+qu5WAdftr
 KdOysH+qLpPxFjkhbh/+bQQp/bB15ybL/iCBOBU2h9ZW06QnWLlzIVVJj g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="401055677"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; d="scan'208";a="401055677"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2023 01:12:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; d="scan'208";a="873280764"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by fmsmga001.fm.intel.com with ESMTP; 04 Aug 2023 01:12:43 -0700
Date: Fri, 4 Aug 2023 16:23:09 +0800
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
Subject: Re: [PATCH v3 06/17] i386/cpu: Consolidate the use of topo_info in
 cpu_x86_cpuid()
Message-ID: <ZMy1bcxc9prSUcIS@liuzhao-OptiPlex-7080>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-7-zhao1.liu@linux.intel.com>
 <c0307538-e1cc-f675-8c5e-1973f40fdaaa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0307538-e1cc-f675-8c5e-1973f40fdaaa@amd.com>
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

On Wed, Aug 02, 2023 at 11:31:46AM -0500, Moger, Babu wrote:
> Date: Wed, 2 Aug 2023 11:31:46 -0500
> From: "Moger, Babu" <babu.moger@amd.com>
> Subject: Re: [PATCH v3 06/17] i386/cpu: Consolidate the use of topo_info in
>  cpu_x86_cpuid()
> 
> Hi Zhao,
> 
> On 8/1/23 05:35, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > In cpu_x86_cpuid(), there are many variables in representing the cpu
> > topology, e.g., topo_info, cs->nr_cores/cs->nr_threads.
> > 
> > Since the names of cs->nr_cores/cs->nr_threads does not accurately
> > represent its meaning, the use of cs->nr_cores/cs->nr_threads is prone
> > to confusion and mistakes.
> > 
> > And the structure X86CPUTopoInfo names its memebers clearly, thus the
> 
> s/memebers/members/

Thanks! I'll be more careful with my spelling.

-Zhao


> Thanks
> Babu
> 
> > variable "topo_info" should be preferred.
> > 
> > In addition, in cpu_x86_cpuid(), to uniformly use the topology variable,
> > replace env->dies with topo_info.dies_per_pkg as well.
> > 
> > Suggested-by: Robert Hoo <robert.hu@linux.intel.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> > Changes since v1:
> >  * Extract cores_per_socket from the code block and use it as a local
> >    variable for cpu_x86_cpuid(). (Yanan)
> >  * Remove vcpus_per_socket variable and use cpus_per_pkg directly.
> >    (Yanan)
> >  * Replace env->dies with topo_info.dies_per_pkg in cpu_x86_cpuid().
> > ---
> >  target/i386/cpu.c | 31 ++++++++++++++++++-------------
> >  1 file changed, 18 insertions(+), 13 deletions(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index c80613bfcded..fc50bf98c60e 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -6008,11 +6008,16 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >      uint32_t limit;
> >      uint32_t signature[3];
> >      X86CPUTopoInfo topo_info;
> > +    uint32_t cores_per_pkg;
> > +    uint32_t cpus_per_pkg;
> >  
> >      topo_info.dies_per_pkg = env->nr_dies;
> >      topo_info.cores_per_die = cs->nr_cores / env->nr_dies;
> >      topo_info.threads_per_core = cs->nr_threads;
> >  
> > +    cores_per_pkg = topo_info.cores_per_die * topo_info.dies_per_pkg;
> > +    cpus_per_pkg = cores_per_pkg * topo_info.threads_per_core;
> > +
> >      /* Calculate & apply limits for different index ranges */
> >      if (index >= 0xC0000000) {
> >          limit = env->cpuid_xlevel2;
> > @@ -6048,8 +6053,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >              *ecx |= CPUID_EXT_OSXSAVE;
> >          }
> >          *edx = env->features[FEAT_1_EDX];
> > -        if (cs->nr_cores * cs->nr_threads > 1) {
> > -            *ebx |= (cs->nr_cores * cs->nr_threads) << 16;
> > +        if (cpus_per_pkg > 1) {
> > +            *ebx |= cpus_per_pkg << 16;
> >              *edx |= CPUID_HT;
> >          }
> >          if (!cpu->enable_pmu) {
> > @@ -6086,8 +6091,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >               */
> >              if (*eax & 31) {
> >                  int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
> > -                int vcpus_per_socket = cs->nr_cores * cs->nr_threads;
> > -                if (cs->nr_cores > 1) {
> > +
> > +                if (cores_per_pkg > 1) {
> >                      int addressable_cores_offset =
> >                                                  apicid_pkg_offset(&topo_info) -
> >                                                  apicid_core_offset(&topo_info);
> > @@ -6095,7 +6100,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >                      *eax &= ~0xFC000000;
> >                      *eax |= (1 << addressable_cores_offset - 1) << 26;
> >                  }
> > -                if (host_vcpus_per_cache > vcpus_per_socket) {
> > +                if (host_vcpus_per_cache > cpus_per_pkg) {
> >                      int pkg_offset = apicid_pkg_offset(&topo_info);
> >  
> >                      *eax &= ~0x3FFC000;
> > @@ -6240,12 +6245,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >          switch (count) {
> >          case 0:
> >              *eax = apicid_core_offset(&topo_info);
> > -            *ebx = cs->nr_threads;
> > +            *ebx = topo_info.threads_per_core;
> >              *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
> >              break;
> >          case 1:
> >              *eax = apicid_pkg_offset(&topo_info);
> > -            *ebx = cs->nr_cores * cs->nr_threads;
> > +            *ebx = cpus_per_pkg;
> >              *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
> >              break;
> >          default:
> > @@ -6266,7 +6271,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >          break;
> >      case 0x1F:
> >          /* V2 Extended Topology Enumeration Leaf */
> > -        if (env->nr_dies < 2) {
> > +        if (topo_info.dies_per_pkg < 2) {
> >              *eax = *ebx = *ecx = *edx = 0;
> >              break;
> >          }
> > @@ -6276,7 +6281,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >          switch (count) {
> >          case 0:
> >              *eax = apicid_core_offset(&topo_info);
> > -            *ebx = cs->nr_threads;
> > +            *ebx = topo_info.threads_per_core;
> >              *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
> >              break;
> >          case 1:
> > @@ -6286,7 +6291,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >              break;
> >          case 2:
> >              *eax = apicid_pkg_offset(&topo_info);
> > -            *ebx = cs->nr_cores * cs->nr_threads;
> > +            *ebx = cpus_per_pkg;
> >              *ecx |= CPUID_TOPOLOGY_LEVEL_DIE;
> >              break;
> >          default:
> > @@ -6511,7 +6516,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >           * discards multiple thread information if it is set.
> >           * So don't set it here for Intel to make Linux guests happy.
> >           */
> > -        if (cs->nr_cores * cs->nr_threads > 1) {
> > +        if (cpus_per_pkg > 1) {
> >              if (env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1 ||
> >                  env->cpuid_vendor2 != CPUID_VENDOR_INTEL_2 ||
> >                  env->cpuid_vendor3 != CPUID_VENDOR_INTEL_3) {
> > @@ -6577,7 +6582,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >               *eax |= (cpu_x86_virtual_addr_width(env) << 8);
> >          }
> >          *ebx = env->features[FEAT_8000_0008_EBX];
> > -        if (cs->nr_cores * cs->nr_threads > 1) {
> > +        if (cpus_per_pkg > 1) {
> >              /*
> >               * Bits 15:12 is "The number of bits in the initial
> >               * Core::X86::Apic::ApicId[ApicId] value that indicate
> > @@ -6585,7 +6590,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >               * Bits 7:0 is "The number of threads in the package is NC+1"
> >               */
> >              *ecx = (apicid_pkg_offset(&topo_info) << 12) |
> > -                   ((cs->nr_cores * cs->nr_threads) - 1);
> > +                   (cpus_per_pkg - 1);
> >          } else {
> >              *ecx = 0;
> >          }
> 
> -- 
> Thanks
> Babu Moger

