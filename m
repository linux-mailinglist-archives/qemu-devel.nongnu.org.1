Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B778299DA
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 12:54:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNX8g-0007Bd-CC; Wed, 10 Jan 2024 06:52:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rNX8d-0007B0-8h
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 06:52:51 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rNX8b-0008LA-6V
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 06:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704887569; x=1736423569;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=PpTniVRf/mUrjDL1i7K82KKY0DYSCGANpu49oItuHkE=;
 b=gAkJjPTTQJiKoydwXyAzul4njV+0qIK+okSQhCnC76JQY3o349GDqt4E
 /1Ubv135vyady7Rr2HPW3lrv2zyee/h4aRH8a2k8eStCh+0ow1vqZneQ9
 yJuHqG/MQRK+sa+TSjIjOBBcQPLfBg1csvg+2nftOsuGmgz7DMoLU+Nxg
 c7I46iOsFbSFT9NA/I4gZjyjiYD9MIl3fiewg2GnQ6RXF+cmIwb7kB05Q
 DxT9JC8VcPIEpL5T1Ml1jo9sOCvDXwqjq9rNTqF2vq7RCp6kMxMlb8690
 ipgO2RoHnJ5fNB6PYaf24Ab+a1v36AX4bOfsgLbmAQs8eGVUxS08Nclgj g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="11977274"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; d="scan'208";a="11977274"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jan 2024 03:52:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="905505974"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; d="scan'208";a="905505974"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.22.149])
 ([10.93.22.149])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jan 2024 03:52:41 -0800
Message-ID: <ddb911d0-6054-43ab-a763-242216b9c8d9@intel.com>
Date: Wed, 10 Jan 2024 19:52:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/16] i386/cpu: Consolidate the use of topo_info in
 cpu_x86_cpuid()
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Robert Hoo <robert.hu@linux.intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>
References: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
 <20240108082727.420817-4-zhao1.liu@linux.intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240108082727.420817-4-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/8/2024 4:27 PM, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> In cpu_x86_cpuid(), there are many variables in representing the cpu
> topology, e.g., topo_info, cs->nr_cores/cs->nr_threads.

Please use comma instead of slash. cs->nr_cores/cs->nr_threads looks 
like one variable.

> Since the names of cs->nr_cores/cs->nr_threads does not accurately
> represent its meaning, the use of cs->nr_cores/cs->nr_threads is prone
> to confusion and mistakes.
> 
> And the structure X86CPUTopoInfo names its members clearly, thus the
> variable "topo_info" should be preferred.
> 
> In addition, in cpu_x86_cpuid(), to uniformly use the topology variable,
> replace env->dies with topo_info.dies_per_pkg as well.
> 
> Suggested-by: Robert Hoo <robert.hu@linux.intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Tested-by: Babu Moger <babu.moger@amd.com>
> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> Changes since v3:
>   * Fix typo. (Babu)
> 
> Changes since v1:
>   * Extract cores_per_socket from the code block and use it as a local
>     variable for cpu_x86_cpuid(). (Yanan)
>   * Remove vcpus_per_socket variable and use cpus_per_pkg directly.
>     (Yanan)
>   * Replace env->dies with topo_info.dies_per_pkg in cpu_x86_cpuid().
> ---
>   target/i386/cpu.c | 31 ++++++++++++++++++-------------
>   1 file changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index c8d2a585723a..6f8fa772ecf8 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6017,11 +6017,16 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>       uint32_t limit;
>       uint32_t signature[3];
>       X86CPUTopoInfo topo_info;
> +    uint32_t cores_per_pkg;
> +    uint32_t cpus_per_pkg;

I prefer to lps_per_pkg or threads_per_pkg.

Other than it,

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

>   
>       topo_info.dies_per_pkg = env->nr_dies;
>       topo_info.cores_per_die = cs->nr_cores / env->nr_dies;
>       topo_info.threads_per_core = cs->nr_threads;
>   
> +    cores_per_pkg = topo_info.cores_per_die * topo_info.dies_per_pkg;
> +    cpus_per_pkg = cores_per_pkg * topo_info.threads_per_core;
> +
>       /* Calculate & apply limits for different index ranges */
>       if (index >= 0xC0000000) {
>           limit = env->cpuid_xlevel2;
> @@ -6057,8 +6062,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>               *ecx |= CPUID_EXT_OSXSAVE;
>           }
>           *edx = env->features[FEAT_1_EDX];
> -        if (cs->nr_cores * cs->nr_threads > 1) {
> -            *ebx |= (cs->nr_cores * cs->nr_threads) << 16;
> +        if (cpus_per_pkg > 1) {
> +            *ebx |= cpus_per_pkg << 16;
>               *edx |= CPUID_HT;
>           }
>           if (!cpu->enable_pmu) {
> @@ -6095,8 +6100,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>                */
>               if (*eax & 31) {
>                   int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
> -                int vcpus_per_socket = cs->nr_cores * cs->nr_threads;
> -                if (cs->nr_cores > 1) {
> +
> +                if (cores_per_pkg > 1) {
>                       int addressable_cores_offset =
>                                                   apicid_pkg_offset(&topo_info) -
>                                                   apicid_core_offset(&topo_info);
> @@ -6104,7 +6109,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>                       *eax &= ~0xFC000000;
>                       *eax |= (1 << (addressable_cores_offset - 1)) << 26;
>                   }
> -                if (host_vcpus_per_cache > vcpus_per_socket) {
> +                if (host_vcpus_per_cache > cpus_per_pkg) {
>                       int pkg_offset = apicid_pkg_offset(&topo_info);
>   
>                       *eax &= ~0x3FFC000;
> @@ -6249,12 +6254,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>           switch (count) {
>           case 0:
>               *eax = apicid_core_offset(&topo_info);
> -            *ebx = cs->nr_threads;
> +            *ebx = topo_info.threads_per_core;
>               *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
>               break;
>           case 1:
>               *eax = apicid_pkg_offset(&topo_info);
> -            *ebx = cs->nr_cores * cs->nr_threads;
> +            *ebx = cpus_per_pkg;
>               *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
>               break;
>           default:
> @@ -6274,7 +6279,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>           break;
>       case 0x1F:
>           /* V2 Extended Topology Enumeration Leaf */
> -        if (env->nr_dies < 2) {
> +        if (topo_info.dies_per_pkg < 2) {
>               *eax = *ebx = *ecx = *edx = 0;
>               break;
>           }
> @@ -6284,7 +6289,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>           switch (count) {
>           case 0:
>               *eax = apicid_core_offset(&topo_info);
> -            *ebx = cs->nr_threads;
> +            *ebx = topo_info.threads_per_core;
>               *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
>               break;
>           case 1:
> @@ -6294,7 +6299,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>               break;
>           case 2:
>               *eax = apicid_pkg_offset(&topo_info);
> -            *ebx = cs->nr_cores * cs->nr_threads;
> +            *ebx = cpus_per_pkg;
>               *ecx |= CPUID_TOPOLOGY_LEVEL_DIE;
>               break;
>           default:
> @@ -6518,7 +6523,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>            * discards multiple thread information if it is set.
>            * So don't set it here for Intel to make Linux guests happy.
>            */
> -        if (cs->nr_cores * cs->nr_threads > 1) {
> +        if (cpus_per_pkg > 1) {
>               if (env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1 ||
>                   env->cpuid_vendor2 != CPUID_VENDOR_INTEL_2 ||
>                   env->cpuid_vendor3 != CPUID_VENDOR_INTEL_3) {
> @@ -6584,7 +6589,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>                *eax |= (cpu_x86_virtual_addr_width(env) << 8);
>           }
>           *ebx = env->features[FEAT_8000_0008_EBX];
> -        if (cs->nr_cores * cs->nr_threads > 1) {
> +        if (cpus_per_pkg > 1) {
>               /*
>                * Bits 15:12 is "The number of bits in the initial
>                * Core::X86::Apic::ApicId[ApicId] value that indicate
> @@ -6592,7 +6597,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>                * Bits 7:0 is "The number of threads in the package is NC+1"
>                */
>               *ecx = (apicid_pkg_offset(&topo_info) << 12) |
> -                   ((cs->nr_cores * cs->nr_threads) - 1);
> +                   (cpus_per_pkg - 1);
>           } else {
>               *ecx = 0;
>           }


