Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F136882A768
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 07:05:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNoBn-0002LD-UY; Thu, 11 Jan 2024 01:05:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rNoBe-0002Bo-Rh
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 01:05:06 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rNoBc-0003Ic-Bp
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 01:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704953104; x=1736489104;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=KLqtRe8CUiiOqmN97iPsj+U+yGAzCbUmPqXi/IC89jU=;
 b=TlaYZS4/nTC5ZlJcFt8aHXsMzIh12+BPoa8VIUs99kYNKPpvndvfMy8Y
 AZ4T/+tBEg0kH8pSf7Rdr/lVhzyXah3nEMdwu8mOdMcdRtc8vACbd03fw
 XxGLER+rQO3awRgj1r0Y13chxMPTZgkjxZRtxrT48LxxSd9bzaDPQGyCD
 we3dVeE/kV+1W2nUujBkieljMWMRc2l3uASXVuTHz9o+LTScot/37I8pe
 F7rWklEEQ/SzHxalRjDoDkgXu/ueY57kLxo17o4QXG3kPWhL0MlBaeLu4
 sjhGIbmSP8SGPtTm6LUKPlG+O112EL3tSPg29yBFotVb7XA1tpPV7jNZ5 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="12238515"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; d="scan'208";a="12238515"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jan 2024 22:05:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="1113717957"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; d="scan'208";a="1113717957"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.22.149])
 ([10.93.22.149])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jan 2024 22:04:56 -0800
Message-ID: <a7b93109-9543-4967-a467-9fead80b434d@intel.com>
Date: Thu, 11 Jan 2024 14:04:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/16] i386: Expose module level in CPUID[0x1F]
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
 Babu Moger <babu.moger@amd.com>, Yongwei Ma <yongwei.ma@intel.com>
References: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
 <20240108082727.420817-9-zhao1.liu@linux.intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240108082727.420817-9-zhao1.liu@linux.intel.com>
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
> Linux kernel (from v6.4, with commit edc0a2b595765 ("x86/topology: Fix
> erroneous smp_num_siblings on Intel Hybrid platforms") is able to
> handle platforms with Module level enumerated via CPUID.1F.
> 
> Expose the module level in CPUID[0x1F] if the machine has more than 1
> modules.
> 
> (Tested CPU topology in CPUID[0x1F] leaf with various die/cluster
> configurations in "-smp".)
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Tested-by: Babu Moger <babu.moger@amd.com>
> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> Changes since v3:
>   * New patch to expose module level in 0x1F.
>   * Add Tested-by tag from Yongwei.
> ---
>   target/i386/cpu.c     | 12 +++++++++++-
>   target/i386/cpu.h     |  2 ++
>   target/i386/kvm/kvm.c |  2 +-
>   3 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 294ca6b8947a..a2d39d2198b6 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -277,6 +277,8 @@ static uint32_t num_cpus_by_topo_level(X86CPUTopoInfo *topo_info,
>           return 1;
>       case CPU_TOPO_LEVEL_CORE:
>           return topo_info->threads_per_core;
> +    case CPU_TOPO_LEVEL_MODULE:
> +        return topo_info->threads_per_core * topo_info->cores_per_module;
>       case CPU_TOPO_LEVEL_DIE:
>           return topo_info->threads_per_core * topo_info->cores_per_module *
>                  topo_info->modules_per_die;
> @@ -297,6 +299,8 @@ static uint32_t apicid_offset_by_topo_level(X86CPUTopoInfo *topo_info,
>           return 0;
>       case CPU_TOPO_LEVEL_CORE:
>           return apicid_core_offset(topo_info);
> +    case CPU_TOPO_LEVEL_MODULE:
> +        return apicid_module_offset(topo_info);
>       case CPU_TOPO_LEVEL_DIE:
>           return apicid_die_offset(topo_info);
>       case CPU_TOPO_LEVEL_PACKAGE:
> @@ -316,6 +320,8 @@ static uint32_t cpuid1f_topo_type(enum CPUTopoLevel topo_level)
>           return CPUID_1F_ECX_TOPO_LEVEL_SMT;
>       case CPU_TOPO_LEVEL_CORE:
>           return CPUID_1F_ECX_TOPO_LEVEL_CORE;
> +    case CPU_TOPO_LEVEL_MODULE:
> +        return CPUID_1F_ECX_TOPO_LEVEL_MODULE;
>       case CPU_TOPO_LEVEL_DIE:
>           return CPUID_1F_ECX_TOPO_LEVEL_DIE;
>       default:
> @@ -347,6 +353,10 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
>           if (env->nr_dies > 1) {
>               set_bit(CPU_TOPO_LEVEL_DIE, topo_bitmap);
>           }
> +
> +        if (env->nr_modules > 1) {
> +            set_bit(CPU_TOPO_LEVEL_MODULE, topo_bitmap);
> +        }
>       }
>   
>       *ecx = count & 0xff;
> @@ -6394,7 +6404,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>           break;
>       case 0x1F:
>           /* V2 Extended Topology Enumeration Leaf */
> -        if (topo_info.dies_per_pkg < 2) {
> +        if (topo_info.modules_per_die < 2 && topo_info.dies_per_pkg < 2) {

maybe we can come up with below function if we have 
env->valid_cpu_topo[] as I suggested in patch 5.

bool cpu_x86_has_valid_cpuid1f(CPUX86State *env) {
	return env->valid_cpu_topo[2] ? true : false;
}

...

>               *eax = *ebx = *ecx = *edx = 0;
>               break;
>           }
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index eecd30bde92b..97b290e10576 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1018,6 +1018,7 @@ enum CPUTopoLevel {
>       CPU_TOPO_LEVEL_INVALID,
>       CPU_TOPO_LEVEL_SMT,
>       CPU_TOPO_LEVEL_CORE,
> +    CPU_TOPO_LEVEL_MODULE,
>       CPU_TOPO_LEVEL_DIE,
>       CPU_TOPO_LEVEL_PACKAGE,
>       CPU_TOPO_LEVEL_MAX,
> @@ -1032,6 +1033,7 @@ enum CPUTopoLevel {
>   #define CPUID_1F_ECX_TOPO_LEVEL_INVALID  CPUID_B_ECX_TOPO_LEVEL_INVALID
>   #define CPUID_1F_ECX_TOPO_LEVEL_SMT      CPUID_B_ECX_TOPO_LEVEL_SMT
>   #define CPUID_1F_ECX_TOPO_LEVEL_CORE     CPUID_B_ECX_TOPO_LEVEL_CORE
> +#define CPUID_1F_ECX_TOPO_LEVEL_MODULE   3
>   #define CPUID_1F_ECX_TOPO_LEVEL_DIE      5
>   
>   /* MSR Feature Bits */
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 4ce80555b45c..e5ddb214cb36 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -1913,7 +1913,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>               break;
>           }
>           case 0x1f:
> -            if (env->nr_dies < 2) {
> +            if (env->nr_modules < 2 && env->nr_dies < 2) {

then cpu_x86_has_valid_cpuid1f() can be used here.

>                   break;
>               }
>               /* fallthrough */


