Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E29F82D09D
	for <lists+qemu-devel@lfdr.de>; Sun, 14 Jan 2024 13:44:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOzpc-0007e6-8a; Sun, 14 Jan 2024 07:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rOzoc-0007EP-Ug
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 07:42:17 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rOzoY-0003EZ-LB
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 07:42:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705236131; x=1736772131;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=OZWDrXewF8MtC/kb9j01WL/a8ou0hazpkHKjaBK9OCA=;
 b=h3ph0C1rJ/KT+RHd+PbyQWcrV7aJA32oWR/Vg9Qo9QvXirRW/KZRTd14
 a/0A2YqPu49UYlbcsc3Z7785Hwu5B+/fM5fx2eUlSJ7FD0saCLF0JXDnM
 cikKFUbIn0gVtXCH2cfoXRO+C6+7bdA8+hRZXO5F72IM9mNnOhpF6XssX
 WF5W5yWydp6B509fKyGGwTeCmC7my2nuMwdUM0hCdnf8d+M+PFHoYwGER
 1H+AuaJFUPsQuC9vVodob/SWu9EbaAqWgOvLAIoksRs18FNH9xKN2h5w+
 GPz6VA9I2bGrvExGWIHhaKU6F7bNicj6myVxHVhUOUj7lZkqIzIhYcF3T A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="12940713"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; d="scan'208";a="12940713"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 04:42:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="786835381"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; d="scan'208";a="786835381"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.22.149])
 ([10.93.22.149])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 04:42:03 -0800
Message-ID: <1b2dd718-5968-4036-8b80-fd456058dce6@intel.com>
Date: Sun, 14 Jan 2024 20:42:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/16] i386: Support module_id in X86CPUTopoIDs
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
 <20240108082727.420817-10-zhao1.liu@linux.intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240108082727.420817-10-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998, SPF_HELO_NONE=0.001,
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
> From: Zhuocheng Ding <zhuocheng.ding@intel.com>
> 
> Add module_id member in X86CPUTopoIDs.
> 
> module_id can be parsed from APIC ID, so also update APIC ID parsing
> rule to support module level. With this support, the conversions with
> module level between X86CPUTopoIDs, X86CPUTopoInfo and APIC ID are
> completed.
> 
> module_id can be also generated from cpu topology, and before i386
> supports "clusters" in smp, the default "clusters per die" is only 1,
> thus the module_id generated in this way is 0, so that it will not
> conflict with the module_id generated by APIC ID.
> 
> Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
> Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Tested-by: Babu Moger <babu.moger@amd.com>
> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> Changes since v1:
>   * Merge the patch "i386: Update APIC ID parsing rule to support module
>     level" into this one. (Yanan)
>   * Move the apicid_module_width() and apicid_module_offset() support
>     into the previous modules_per_die related patch. (Yanan)
> ---
>   hw/i386/x86.c              | 28 +++++++++++++++++++++-------
>   include/hw/i386/topology.h | 17 +++++++++++++----
>   2 files changed, 34 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 85b847ac7914..5269aae3a5c2 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -315,11 +315,11 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
>   
>       /*
>        * If APIC ID is not set,
> -     * set it based on socket/die/core/thread properties.
> +     * set it based on socket/die/cluster/core/thread properties.
>        */
>       if (cpu->apic_id == UNASSIGNED_APIC_ID) {
> -        int max_socket = (ms->smp.max_cpus - 1) /
> -                                smp_threads / smp_cores / ms->smp.dies;
> +        int max_socket = (ms->smp.max_cpus - 1) / smp_threads / smp_cores /
> +                                ms->smp.clusters / ms->smp.dies;
>   
>           /*
>            * die-id was optional in QEMU 4.0 and older, so keep it optional
> @@ -366,17 +366,27 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
>           topo_ids.die_id = cpu->die_id;
>           topo_ids.core_id = cpu->core_id;
>           topo_ids.smt_id = cpu->thread_id;
> +
> +        /*
> +         * TODO: This is the temporary initialization for topo_ids.module_id to
> +         * avoid "maybe-uninitialized" compilation errors. Will remove when
> +         * X86CPU supports cluster_id.
> +         */
> +        topo_ids.module_id = 0;
> 

if you put patch 10 before this patch, then we don't need this trick.

>           cpu->apic_id = x86_apicid_from_topo_ids(&topo_info, &topo_ids);
>       }
>   
>       cpu_slot = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, &idx);
>       if (!cpu_slot) {
>           x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
> +
>           error_setg(errp,
> -            "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
> -            " APIC ID %" PRIu32 ", valid index range 0:%d",
> -            topo_ids.pkg_id, topo_ids.die_id, topo_ids.core_id, topo_ids.smt_id,
> -            cpu->apic_id, ms->possible_cpus->len - 1);
> +            "Invalid CPU [socket: %u, die: %u, module: %u, core: %u, thread: %u]"
> +            " with APIC ID %" PRIu32 ", valid index range 0:%d",
> +            topo_ids.pkg_id, topo_ids.die_id, topo_ids.module_id,
> +            topo_ids.core_id, topo_ids.smt_id, cpu->apic_id,
> +            ms->possible_cpus->len - 1);
>           return;
>       }
>   
> @@ -502,6 +512,10 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
>               ms->possible_cpus->cpus[i].props.has_die_id = true;
>               ms->possible_cpus->cpus[i].props.die_id = topo_ids.die_id;
>           }
> +        if (ms->smp.clusters > 1) {
> +            ms->possible_cpus->cpus[i].props.has_cluster_id = true;
> +            ms->possible_cpus->cpus[i].props.cluster_id = topo_ids.module_id;
> +        }
>           ms->possible_cpus->cpus[i].props.has_core_id = true;
>           ms->possible_cpus->cpus[i].props.core_id = topo_ids.core_id;
>           ms->possible_cpus->cpus[i].props.has_thread_id = true;
> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> index 517e51768c13..ed1f3d6c1d5e 100644
> --- a/include/hw/i386/topology.h
> +++ b/include/hw/i386/topology.h
> @@ -50,6 +50,7 @@ typedef uint32_t apic_id_t;
>   typedef struct X86CPUTopoIDs {
>       unsigned pkg_id;
>       unsigned die_id;
> +    unsigned module_id;
>       unsigned core_id;
>       unsigned smt_id;
>   } X86CPUTopoIDs;
> @@ -127,6 +128,7 @@ static inline apic_id_t x86_apicid_from_topo_ids(X86CPUTopoInfo *topo_info,
>   {
>       return (topo_ids->pkg_id  << apicid_pkg_offset(topo_info)) |
>              (topo_ids->die_id  << apicid_die_offset(topo_info)) |
> +           (topo_ids->module_id << apicid_module_offset(topo_info)) |
>              (topo_ids->core_id << apicid_core_offset(topo_info)) |
>              topo_ids->smt_id;
>   }
> @@ -140,12 +142,16 @@ static inline void x86_topo_ids_from_idx(X86CPUTopoInfo *topo_info,
>                                            X86CPUTopoIDs *topo_ids)
>   {
>       unsigned nr_dies = topo_info->dies_per_pkg;
> -    unsigned nr_cores = topo_info->cores_per_module *
> -                        topo_info->modules_per_die;
> +    unsigned nr_modules = topo_info->modules_per_die;
> +    unsigned nr_cores = topo_info->cores_per_module;
>       unsigned nr_threads = topo_info->threads_per_core;
>   
> -    topo_ids->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
> -    topo_ids->die_id = cpu_index / (nr_cores * nr_threads) % nr_dies;
> +    topo_ids->pkg_id = cpu_index / (nr_dies * nr_modules *
> +                       nr_cores * nr_threads);
> +    topo_ids->die_id = cpu_index / (nr_modules * nr_cores *
> +                       nr_threads) % nr_dies;
> +    topo_ids->module_id = cpu_index / (nr_cores * nr_threads) %
> +                          nr_modules;
>       topo_ids->core_id = cpu_index / nr_threads % nr_cores;
>       topo_ids->smt_id = cpu_index % nr_threads;
>   }
> @@ -163,6 +169,9 @@ static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
>       topo_ids->core_id =
>               (apicid >> apicid_core_offset(topo_info)) &
>               ~(0xFFFFFFFFUL << apicid_core_width(topo_info));
> +    topo_ids->module_id =
> +            (apicid >> apicid_module_offset(topo_info)) &
> +            ~(0xFFFFFFFFUL << apicid_module_width(topo_info));
>       topo_ids->die_id =
>               (apicid >> apicid_die_offset(topo_info)) &
>               ~(0xFFFFFFFFUL << apicid_die_width(topo_info));


