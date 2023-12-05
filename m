Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFA5804582
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 04:16:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rALuy-0007mH-2s; Mon, 04 Dec 2023 22:16:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rALuv-0007ln-Dy
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 22:16:13 -0500
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rALut-0001aQ-26
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 22:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701746171; x=1733282171;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=wYTu0593b2ZxnWujgrnnZbZVcAahmIkF+Tth6aFA88k=;
 b=gkcp0YIyiMomfDFw4J05LGwFgnpAXUGxH18JHhIwrA53k8yjAgexC+oc
 ZJpXKG4iwjDZpQpVXSdRVktAZxMGYZYU3q4A1acl/t5Ug4Kl3TfzNuDl6
 0JV6musC89EQvLoy0agCWlyznfFZLdlAArQv17YuCxfChtM5oG7l4AP+r
 t5RPMD8beA/5dB4A86ll45QgUBWL+5zoBjaoqENo6T5jFjXV3JNjwuIMU
 pWyRb0qbROVZHuMp7FGe9LciEm904noO7aft+avvA+9qqrqhhVQ7t08oH
 nd+yfR82i/67HyqiRlH+HcKWy4t5HYqI037/lOYcQbNIsfylnpcmU9iVJ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="378862169"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; d="scan'208";a="378862169"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2023 19:16:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="841291102"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; d="scan'208";a="841291102"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga004.fm.intel.com with ESMTP; 04 Dec 2023 19:16:04 -0800
Date: Tue, 5 Dec 2023 11:28:24 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Babu Moger <babu.moger@amd.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v6 00/16] Support smp.clusters for x86 in QEMU
Message-ID: <ZW6Y2AYJZWYsodBq@intel.com>
References: <20231117075106.432499-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117075106.432499-1-zhao1.liu@linux.intel.com>
Received-SPF: none client-ip=134.134.136.126;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi maintainers,

Just a friendly ping. Do I need to refresh another version?

Thanks,
Zhao

On Fri, Nov 17, 2023 at 03:50:50PM +0800, Zhao Liu wrote:
> Date: Fri, 17 Nov 2023 15:50:50 +0800
> From: Zhao Liu <zhao1.liu@linux.intel.com>
> Subject: [PATCH v6 00/16] Support smp.clusters for x86 in QEMU
> X-Mailer: git-send-email 2.34.1
> 
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Hi list,
> 
> This is the our v6 patch series, rebased on the master branch at the
> commit 34a5cb6d8434 (Merge tag 'pull-tcg-20231114' of
> https://gitlab.com/rth7680/qemu into staging).
> 
> Because the first four patches of v5 [1] have been merged, v6 contains
> the remaining patches and reabse on the latest master.
> 
> No more change since v5 exclude the comment update about QEMU version
> (see Changelog).
> 
> Welcome your comments!
> 
> 
> PS: About the idea to implement generic smp cache topology, we're
> considerring to port the original x-l2-cache-topo option to smp [2].
> Just like:
> 
> -smp cpus=4,sockets=2,cores=2,threads=1, \
>      l3-cache=socket,l2-cache=core,l1-i-cache=core,l1-d-cache=core
> 
> Any feedback about this direction is also welcomed! ;-)
> 
> 
> ---
> # Introduction
> 
> This series adds the cluster support for x86 PC machine, which allows
> x86 can use smp.clusters to configure the module level CPU topology
> of x86.
> 
> This series also is the preparation to help x86 to define the more
> flexible cache topology, such as having multiple cores share the
> same L2 cache at cluster level. (That was what x-l2-cache-topo did,
> and we will explore a generic way.)
> 
> About why we don't share L2 cache at cluster and need a configuration
> way, pls see section: ## Why not share L2 cache in cluster directly.
> 
> 
> # Background
> 
> The "clusters" parameter in "smp" is introduced by ARM [3], but x86
> hasn't supported it.
> 
> At present, x86 defaults L2 cache is shared in one core, but this is
> not enough. There're some platforms that multiple cores share the
> same L2 cache, e.g., Alder Lake-P shares L2 cache for one module of
> Atom cores [4], that is, every four Atom cores shares one L2 cache.
> Therefore, we need the new CPU topology level (cluster/module).
> 
> Another reason is for hybrid architecture. cluster support not only
> provides another level of topology definition in x86, but would also
> provide required code change for future our hybrid topology support.
> 
> 
> # Overview
> 
> ## Introduction of module level for x86
> 
> "cluster" in smp is the CPU topology level which is between "core" and
> die.
> 
> For x86, the "cluster" in smp is corresponding to the module level [4],
> which is above the core level. So use the "module" other than "cluster"
> in x86 code.
> 
> And please note that x86 already has a cpu topology level also named
> "cluster" [5], this level is at the upper level of the package. Here,
> the cluster in x86 cpu topology is completely different from the
> "clusters" as the smp parameter. After the module level is introduced,
> the cluster as the smp parameter will actually refer to the module level
> of x86.
> 
> 
> ## Why not share L2 cache in cluster directly
> 
> Though "clusters" was introduced to help define L2 cache topology
> [3], using cluster to define x86's L2 cache topology will cause the
> compatibility problem:
> 
> Currently, x86 defaults that the L2 cache is shared in one core, which
> actually implies a default setting "cores per L2 cache is 1" and
> therefore implicitly defaults to having as many L2 caches as cores.
> 
> For example (i386 PC machine):
> -smp 16,sockets=2,dies=2,cores=2,threads=2,maxcpus=16 (*)
> 
> Considering the topology of the L2 cache, this (*) implicitly means "1
> core per L2 cache" and "2 L2 caches per die".
> 
> If we use cluster to configure L2 cache topology with the new default
> setting "clusters per L2 cache is 1", the above semantics will change
> to "2 cores per cluster" and "1 cluster per L2 cache", that is, "2
> cores per L2 cache".
> 
> So the same command (*) will cause changes in the L2 cache topology,
> further affecting the performance of the virtual machine.
> 
> Therefore, x86 should only treat cluster as a cpu topology level and
> avoid using it to change L2 cache by default for compatibility.
> 
> 
> ## module level in CPUID
> 
> Linux kernel (from v6.4, with commit edc0a2b595765 ("x86/topology: Fix
> erroneous smp_num_siblings on Intel Hybrid platforms") is able to
> handle platforms with Module level enumerated via CPUID.1F.
> 
> Expose the module level in CPUID[0x1F] (for Intel CPUs) if the machine
> has more than 1 modules since v3.
> 
> 
> ## New cache topology info in CPUCacheInfo
> 
> (This is in preparation for users being able to configure cache topology
> from the cli later on.)
> 
> Currently, by default, the cache topology is encoded as:
> 1. i/d cache is shared in one core.
> 2. L2 cache is shared in one core.
> 3. L3 cache is shared in one die.
> 
> This default general setting has caused a misunderstanding, that is, the
> cache topology is completely equated with a specific cpu topology, such
> as the connection between L2 cache and core level, and the connection
> between L3 cache and die level.
> 
> In fact, the settings of these topologies depend on the specific
> platform and are not static. For example, on Alder Lake-P, every
> four Atom cores share the same L2 cache [3].
> 
> Thus, in this patch set, we explicitly define the corresponding cache
> topology for different cpu models and this has two benefits:
> 1. Easy to expand to new CPU models in the future, which has different
>    cache topology.
> 2. It can easily support custom cache topology by some command.
> 
> 
> # Patch description
> 
> patch 1 Fixes about x86 topology and Intel l1 cache topology.
> 
> patch 2-3 Cleanups about topology related CPUID encoding and QEMU
>           topology variables.
> 
> patch 4-5 Refactor CPUID[0x1F] encoding to prepare to introduce module
>           level.
> 
> patch 6-12 Add the module as the new CPU topology level in x86, and it
>             is corresponding to the cluster level in generic code.
> 
> patch 13,14,16 Add cache topology information in cache models.
> 
> patch 15 Update AMD CPUs' cache topology encoding.
> 
> 
> [1]: https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg08233.html
> [2]: https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg01954.html
> [3]: https://patchew.org/QEMU/20211228092221.21068-1-wangyanan55@huawei.com/
> [4]: https://www.intel.com/content/www/us/en/products/platforms/details/alder-lake-p.html
> [5]: SDM, vol.3, ch.9, 9.9.1 Hierarchical Mapping of Shared Resources.
> 
> Best Regards,
> Zhao
> ---
> Changelog:
> 
> Changes since v5:
>  * The first four patches of v5 [1] have been merged, v6 contains
>    the remaining patches.
>  * Reabse on the latest master.
>  * Update the comment when check cluster-id. Since current QEMU is
>    v8.2, the cluster-id support should at least start from v8.3.
> 
> Changes since v4:
>  * Drop the "x-l2-cache-topo" option. (Michael)
>  * Add A/R/T tags.
> 
> Changes since v3 (main changes):
>  * Expose module level in CPUID[0x1F].
>  * Fix compile warnings. (Babu)
>  * Fixes cache topology uninitialization bugs for some AMD CPUs. (Babu)
> 
> Changes since v2:
>  * Add "Tested-by", "Reviewed-by" and "ACKed-by" tags.
>  * Use newly added wrapped helper to get cores per socket in
>    qemu_init_vcpu().
> 
> Changes since v1:
>  * Reordered patches. (Yanan)
>  * Deprecated the patch to fix comment of machine_parse_smp_config().
>    (Yanan)
>  * Rename test-x86-cpuid.c to test-x86-topo.c. (Yanan)
>  * Split the intel's l1 cache topology fix into a new separate patch.
>    (Yanan)
>  * Combined module_id and APIC ID for module level support into one
>    patch. (Yanan)
>  * Make cache_into_passthrough case of cpuid 0x04 leaf in
>  * cpu_x86_cpuid() use max_processor_ids_for_cache() and
>    max_core_ids_in_package() to encode CPUID[4]. (Yanan)
>  * Add the prefix "CPU_TOPO_LEVEL_*" for CPU topology level names.
>    (Yanan)
> 
> ---
> Zhao Liu (10):
>   i386/cpu: Fix i/d-cache topology to core level for Intel CPU
>   i386/cpu: Use APIC ID offset to encode cache topo in CPUID[4]
>   i386/cpu: Consolidate the use of topo_info in cpu_x86_cpuid()
>   i386: Split topology types of CPUID[0x1F] from the definitions of
>     CPUID[0xB]
>   i386: Decouple CPUID[0x1F] subleaf with specific topology level
>   i386: Expose module level in CPUID[0x1F]
>   i386: Add cache topology info in CPUCacheInfo
>   i386: Use CPUCacheInfo.share_level to encode CPUID[4]
>   i386: Use offsets get NumSharingCache for CPUID[0x8000001D].EAX[bits
>     25:14]
>   i386: Use CPUCacheInfo.share_level to encode
>     CPUID[0x8000001D].EAX[bits 25:14]
> 
> Zhuocheng Ding (6):
>   i386: Introduce module-level cpu topology to CPUX86State
>   i386: Support modules_per_die in X86CPUTopoInfo
>   i386: Support module_id in X86CPUTopoIDs
>   i386/cpu: Introduce cluster-id to X86CPU
>   tests: Add test case of APIC ID for module level parsing
>   hw/i386/pc: Support smp.clusters for x86 PC machine
> 
>  hw/i386/pc.c               |   1 +
>  hw/i386/x86.c              |  49 ++++++-
>  include/hw/i386/topology.h |  35 ++++-
>  qemu-options.hx            |  10 +-
>  target/i386/cpu.c          | 289 +++++++++++++++++++++++++++++--------
>  target/i386/cpu.h          |  43 +++++-
>  target/i386/kvm/kvm.c      |   2 +-
>  tests/unit/test-x86-topo.c |  56 ++++---
>  8 files changed, 379 insertions(+), 106 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

