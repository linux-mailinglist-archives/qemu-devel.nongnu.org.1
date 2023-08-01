Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC60C76B8AD
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 17:36:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQrPa-0005j9-Mj; Tue, 01 Aug 2023 11:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qQrPY-0005ie-3g
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:35:48 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qQrPV-0001bH-33
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:35:47 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RFfHJ1xXSz6J6rP;
 Tue,  1 Aug 2023 23:32:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 16:35:28 +0100
Date: Tue, 1 Aug 2023 16:35:27 +0100
To: Zhao Liu <zhao1.liu@linux.intel.com>
CC: Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, <qemu-devel@nongnu.org>, Zhenyu Wang
 <zhenyu.z.wang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Babu Moger
 <babu.moger@amd.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 00/17] Support smp.clusters for x86
Message-ID: <20230801163527.00004bcc@Huawei.com>
In-Reply-To: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue,  1 Aug 2023 18:35:10 +0800
Zhao Liu <zhao1.liu@linux.intel.com> wrote:

> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Hi list,
> 
> This is the our v3 patch series, rebased on the master branch at the
> commit 234320cd0573 ("Merge tag 'pull-target-arm-20230731' of https:
> //git.linaro.org/people/pmaydell/qemu-arm into staging").
> 
> Comparing with v2 [1], v3 mainly adds "Tested-by", "Reviewed-by" and
> "ACKed-by" (for PC related patchies) tags and minor code changes (Pls
> see changelog).
> 
> 
> # Introduction
> 
> This series add the cluster support for x86 PC machine, which allows
> x86 can use smp.clusters to configure x86 modlue level CPU topology.
> 
> And since the compatibility issue (see section: ## Why not share L2
> cache in cluster directly), this series also introduce a new command
> to adjust the x86 L2 cache topology.
> 
> Welcome your comments!
> 
> 
> # Backgroud
> 
> The "clusters" parameter in "smp" is introduced by ARM [2], but x86
> hasn't supported it.
> 
> At present, x86 defaults L2 cache is shared in one core, but this is
> not enough. There're some platforms that multiple cores share the
> same L2 cache, e.g., Alder Lake-P shares L2 cache for one module of
> Atom cores [3], that is, every four Atom cores shares one L2 cache.
> Therefore, we need the new CPU topology level (cluster/module).
> 
> Another reason is for hybrid architecture. cluster support not only
> provides another level of topology definition in x86, but would aslo
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
> "cluster" [4], this level is at the upper level of the package. Here,
> the cluster in x86 cpu topology is completely different from the
> "clusters" as the smp parameter. After the module level is introduced,
> the cluster as the smp parameter will actually refer to the module level
> of x86.
> 
> 
> ## Why not share L2 cache in cluster directly
> 
> Though "clusters" was introduced to help define L2 cache topology
> [2], using cluster to define x86's L2 cache topology will cause the
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
> Currently, we don't expose module level in CPUID.1FH because currently
> linux (v6.2-rc6) doesn't support module level. And exposing module and
> die levels at the same time in CPUID.1FH will cause linux to calculate
> wrong die_id. The module level should be exposed until the real machine
> has the module level in CPUID.1FH.
> 
> We can configure CPUID.04H.02H (L2 cache topology) with module level by
> a new command:
> 
>         "-cpu,x-l2-cache-topo=cluster"
> 
> More information about this command, please see the section: "## New
> property: x-l2-cache-topo".
> 
> 
> ## New cache topology info in CPUCacheInfo
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
> four Atom cores share the same L2 cache [2].
> 
> Thus, in this patch set, we explicitly define the corresponding cache
> topology for different cpu models and this has two benefits:
> 1. Easy to expand to new CPU models in the future, which has different
>    cache topology.
> 2. It can easily support custom cache topology by some command (e.g.,
>    x-l2-cache-topo).
> 
> 
> ## New property: x-l2-cache-topo
> 
> The property l2-cache-topo will be used to change the L2 cache topology
> in CPUID.04H.
> 
> Now it allows user to set the L2 cache is shared in core level or
> cluster level.
> 
> If user passes "-cpu x-l2-cache-topo=[core|cluster]" then older L2 cache
> topology will be overrided by the new topology setting.
> 
> Since CPUID.04H is used by intel cpus, this property is available on
> intel cpus as for now.
> 
> When necessary, it can be extended to CPUID[0x8000001D] for amd cpus.

Hi Zhao Liu,

As part of emulating arm's MPAM (cache partitioning controls) I needed
to add the missing cache description in the ACPI PPTT table. As such I ran
into a very similar problem to the one you are addressing.

I wonder if a more generic description is possible? We can rely on ordering
of the cache levels, so what I was planning to propose was the rather lengthy
but flexible (and with better names ;)

-smp 16,sockets=1,clusters=4,threads=2,cache-cluster-start-level=2,cache-node-start-level=3

Perhaps we can come up with a common scheme that covers both usecases?
It gets more fiddly to define if we have variable topology across different clusters
- and that was going to be an open question in the RFC proposing this - our current
definition of the more basic topology doesn't cover those cases anyway.

What I want:

1) No restriction on maximum cache levels - some systems have more than 3.
2) Easy ability to express everything from all caches are private to all caches are shared.
Is 3 levels enough? (private, shared at cluster level, shared at a level above that) I think
so, but if not any scheme should be extensible to cover another level.

Great if we can figure out a common scheme.

Jonathan

> 
> 
> # Patch description
> 
> patch 1-2 Cleanups about coding style and test name.
> 
> patch 3-4,15 Fixes about x86 topology, intel l1 cache topology and amd
>              cache topology encoding.
> 
> patch 5-6 Cleanups about topology related CPUID encoding and QEMU
>           topology variables.
> 
> patch 7-12 Add the module as the new CPU topology level in x86, and it
>            is corresponding to the cluster level in generic code.
> 
> patch 13,14,16 Add cache topology infomation in cache models.
> 
> patch 17 Introduce a new command to configure L2 cache topology.
> 
> 
> [1]: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg07179.html
> [2]: https://patchew.org/QEMU/20211228092221.21068-1-wangyanan55@huawei.com/
> [3]: https://www.intel.com/content/www/us/en/products/platforms/details/alder-lake-p.html
> [4]: SDM, vol.3, ch.9, 9.9.1 Hierarchical Mapping of Shared Resources.
> 
> Best Regards,
> Zhao
> 
> ---
> Changelog:
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
>  * Rename the "INVALID" level to "CPU_TOPO_LEVEL_UNKNOW". (Yanan)
> 
> ---
> Zhao Liu (10):
>   i386: Fix comment style in topology.h
>   tests: Rename test-x86-cpuid.c to test-x86-topo.c
>   i386/cpu: Fix i/d-cache topology to core level for Intel CPU
>   i386/cpu: Use APIC ID offset to encode cache topo in CPUID[4]
>   i386/cpu: Consolidate the use of topo_info in cpu_x86_cpuid()
>   i386: Add cache topology info in CPUCacheInfo
>   i386: Use CPUCacheInfo.share_level to encode CPUID[4]
>   i386: Fix NumSharingCache for CPUID[0x8000001D].EAX[bits 25:14]
>   i386: Use CPUCacheInfo.share_level to encode
>     CPUID[0x8000001D].EAX[bits 25:14]
>   i386: Add new property to control L2 cache topo in CPUID.04H
> 
> Zhuocheng Ding (7):
>   softmmu: Fix CPUSTATE.nr_cores' calculation
>   i386: Introduce module-level cpu topology to CPUX86State
>   i386: Support modules_per_die in X86CPUTopoInfo
>   i386: Support module_id in X86CPUTopoIDs
>   i386/cpu: Introduce cluster-id to X86CPU
>   tests: Add test case of APIC ID for module level parsing
>   hw/i386/pc: Support smp.clusters for x86 PC machine
> 
>  MAINTAINERS                                   |   2 +-
>  hw/i386/pc.c                                  |   1 +
>  hw/i386/x86.c                                 |  49 +++++-
>  include/hw/core/cpu.h                         |   2 +-
>  include/hw/i386/topology.h                    |  68 +++++---
>  qemu-options.hx                               |  10 +-
>  softmmu/cpus.c                                |   2 +-
>  target/i386/cpu.c                             | 158 ++++++++++++++----
>  target/i386/cpu.h                             |  25 +++
>  tests/unit/meson.build                        |   4 +-
>  .../{test-x86-cpuid.c => test-x86-topo.c}     |  58 ++++---
>  11 files changed, 280 insertions(+), 99 deletions(-)
>  rename tests/unit/{test-x86-cpuid.c => test-x86-topo.c} (73%)
> 


