Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34291740777
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 03:09:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEJfj-0000XL-C2; Tue, 27 Jun 2023 21:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qEJfb-0000X4-CC
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 21:08:31 -0400
Received: from mga14.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qEJfV-0000Pj-O7
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 21:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687914506; x=1719450506;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Z3CKasSDyfKnOS7BslVK2hBsb3mwqPVolxi0Jf++cp0=;
 b=OmiNeGuJhf1sJ6HGBMMe1Xn5uH2e0mlnLDFhCZUopPZsHvLP4Ec3jbrn
 z9oQuPTHPvNg+tZa6hZ7zROvOaQP43q2wcsWop2gGu5vxA+w9F2c6PjBZ
 3CO8zdZU9sC5u4EszM/xUBSSr/0+8PWZeKDpxFUKUg+n+7iIcpl2GvP+q
 MUyDkL0L3wRdf2zgS4iJcbhviQgR5fOwNQurG4F2jDU8IdsyRbob5j729
 CSLx8jWUAznOv7NouYi2rig7kpK8flVcgJNPttUpWy/oeawTHjYxutAVv
 vmlM/koOIWKA1Ucl7ceY6sMgymeSQrc+Afz+kROrDREj4F3K6F5FPSCVj Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="361762862"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; d="scan'208";a="361762862"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2023 18:08:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="829871555"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; d="scan'208";a="829871555"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by fmsmga002.fm.intel.com with ESMTP; 27 Jun 2023 18:08:08 -0700
Date: Wed, 28 Jun 2023 09:18:06 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 00/17] Support smp.clusters for x86
Message-ID: <ZJuKTl9RJet6FEO2@liuzhao-OptiPlex-7080>
References: <20230529123101.411267-1-zhao1.liu@linux.intel.com>
 <20230622161427-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622161427-mutt-send-email-mst@kernel.org>
Received-SPF: none client-ip=192.55.52.115;
 envelope-from=zhao1.liu@linux.intel.com; helo=mga14.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Jun 22, 2023 at 04:14:44PM -0400, Michael S. Tsirkin wrote:
> Date: Thu, 22 Jun 2023 16:14:44 -0400
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Subject: Re: [PATCH v2 00/17] Support smp.clusters for x86
> 
> On Mon, May 29, 2023 at 08:30:44PM +0800, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > Hi list,
> > 
> > This is the our v2 patch series, rebased on the master branch at the
> > commit ac84b57b4d74 ("Merge tag 'for-upstream' of
> > https://gitlab.com/bonzini/qemu into staging").
> > 
> > Comparing with v1 [1], v2 mainly reorganizes patches and does some
> > cleanup.
> > 
> > This series add the cluster support for x86 PC machine, which allows
> > x86 can use smp.clusters to configure the modlue level CPU topology
> > of x86.
> > 
> > And since the compatibility issue (see section: ## Why not share L2
> > cache in cluster directly), this series also introduce a new command
> > to adjust the topology of the x86 L2 cache.
> > 
> > Welcome your comments!
> 
> PC things:
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 

Thanks Michael!

Could I double check if I can add your ACK tag to the following patches?

[PATCH v2 01/17] i386: Fix comment style in topology.h
[PATCH v2 02/17] tests: Rename test-x86-cpuid.c to test-x86-topo.c
[PATCH v2 07/17] i386: Introduce module-level cpu topology to
CPUX86State
[PATCH v2 08/17] i386: Support modules_per_die in X86CPUTopoInfo
[PATCH v2 09/17] i386: Support module_id in X86CPUTopoIDs
[PATCH v2 10/17] i386/cpu: Introduce cluster-id to X86CPU
[PATCH v2 11/17] tests: Add test case of APIC ID for module level parsing
[PATCH v2 12/17] hw/i386/pc: Support smp.clusters for x86 PC machine

Zhao

> 
> 
> > 
> > # Backgroud
> > 
> > The "clusters" parameter in "smp" is introduced by ARM [2], but x86
> > hasn't supported it.
> > 
> > At present, x86 defaults L2 cache is shared in one core, but this is
> > not enough. There're some platforms that multiple cores share the
> > same L2 cache, e.g., Alder Lake-P shares L2 cache for one module of
> > Atom cores [3], that is, every four Atom cores shares one L2 cache.
> > Therefore, we need the new CPU topology level (cluster/module).
> > 
> > Another reason is for hybrid architecture. cluster support not only
> > provides another level of topology definition in x86, but would aslo
> > provide required code change for future our hybrid topology support.
> > 
> > 
> > # Overview
> > 
> > ## Introduction of module level for x86
> > 
> > "cluster" in smp is the CPU topology level which is between "core" and
> > die.
> > 
> > For x86, the "cluster" in smp is corresponding to the module level [4],
> > which is above the core level. So use the "module" other than "cluster"
> > in x86 code.
> > 
> > And please note that x86 already has a cpu topology level also named
> > "cluster" [4], this level is at the upper level of the package. Here,
> > the cluster in x86 cpu topology is completely different from the
> > "clusters" as the smp parameter. After the module level is introduced,
> > the cluster as the smp parameter will actually refer to the module level
> > of x86.
> > 
> > 
> > ## Why not share L2 cache in cluster directly
> > 
> > Though "clusters" was introduced to help define L2 cache topology
> > [2], using cluster to define x86's L2 cache topology will cause the
> > compatibility problem:
> > 
> > Currently, x86 defaults that the L2 cache is shared in one core, which
> > actually implies a default setting "cores per L2 cache is 1" and
> > therefore implicitly defaults to having as many L2 caches as cores.
> > 
> > For example (i386 PC machine):
> > -smp 16,sockets=2,dies=2,cores=2,threads=2,maxcpus=16 (*)
> > 
> > Considering the topology of the L2 cache, this (*) implicitly means "1
> > core per L2 cache" and "2 L2 caches per die".
> > 
> > If we use cluster to configure L2 cache topology with the new default
> > setting "clusters per L2 cache is 1", the above semantics will change
> > to "2 cores per cluster" and "1 cluster per L2 cache", that is, "2
> > cores per L2 cache".
> > 
> > So the same command (*) will cause changes in the L2 cache topology,
> > further affecting the performance of the virtual machine.
> > 
> > Therefore, x86 should only treat cluster as a cpu topology level and
> > avoid using it to change L2 cache by default for compatibility.
> > 
> > 
> > ## module level in CPUID
> > 
> > Currently, we don't expose module level in CPUID.1FH because currently
> > linux (v6.2-rc6) doesn't support module level. And exposing module and
> > die levels at the same time in CPUID.1FH will cause linux to calculate
> > wrong die_id. The module level should be exposed until the real machine
> > has the module level in CPUID.1FH.
> > 
> > We can configure CPUID.04H.02H (L2 cache topology) with module level by
> > a new command:
> > 
> >         "-cpu,x-l2-cache-topo=cluster"
> > 
> > More information about this command, please see the section: "## New
> > property: x-l2-cache-topo".
> > 
> > 
> > ## New cache topology info in CPUCacheInfo
> > 
> > Currently, by default, the cache topology is encoded as:
> > 1. i/d cache is shared in one core.
> > 2. L2 cache is shared in one core.
> > 3. L3 cache is shared in one die.
> > 
> > This default general setting has caused a misunderstanding, that is, the
> > cache topology is completely equated with a specific cpu topology, such
> > as the connection between L2 cache and core level, and the connection
> > between L3 cache and die level.
> > 
> > In fact, the settings of these topologies depend on the specific
> > platform and are not static. For example, on Alder Lake-P, every
> > four Atom cores share the same L2 cache [2].
> > 
> > Thus, in this patch set, we explicitly define the corresponding cache
> > topology for different cpu models and this has two benefits:
> > 1. Easy to expand to new CPU models in the future, which has different
> >    cache topology.
> > 2. It can easily support custom cache topology by some command (e.g.,
> >    x-l2-cache-topo).
> > 
> > 
> > ## New property: x-l2-cache-topo
> > 
> > The property l2-cache-topo will be used to change the L2 cache topology
> > in CPUID.04H.
> > 
> > Now it allows user to set the L2 cache is shared in core level or
> > cluster level.
> > 
> > If user passes "-cpu x-l2-cache-topo=[core|cluster]" then older L2 cache
> > topology will be overrided by the new topology setting.
> > 
> > Since CPUID.04H is used by intel cpus, this property is available on
> > intel cpus as for now.
> > 
> > When necessary, it can be extended to CPUID[0x8000001D] for amd cpus.
> > 
> > 
> > # Patch description
> > 
> > patch 1-2 Cleanups about coding style and test name.
> > 
> > patch 3-4,15 Fixes about x86 topology, intel l1 cache topology and amd
> >              cache topology encoding.
> > 
> > patch 5-6 Cleanups about topology related CPUID encoding and QEMU
> >           topology variables.
> > 
> > patch 7-12 Add the module as the new CPU topology level in x86, and it
> >            is corresponding to the cluster level in generic code.
> > 
> > patch 13,14,16 Add cache topology infomation in cache models.
> > 
> > patch 17 Introduce a new command to configure L2 cache topology.
> > 
> > 
> > [1]: https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg03184.html
> > [2]: https://patchew.org/QEMU/20211228092221.21068-1-wangyanan55@huawei.com/
> > [3]: https://www.intel.com/content/www/us/en/products/platforms/details/alder-lake-p.html
> > [4]: SDM, vol.3, ch.9, 9.9.1 Hierarchical Mapping of Shared Resources.
> > 
> > Best Regards,
> > Zhao
> > 
> > ---
> > Changelog:
> > 
> > Changes since v1:
> >  * Reordered patches. (Yanan)
> >  * Deprecated the patch to fix comment of machine_parse_smp_config().
> >    (Yanan)
> >  * Rename test-x86-cpuid.c to test-x86-topo.c. (Yanan)
> >  * Split the intel's l1 cache topology fix into a new separate patch.
> >    (Yanan)
> >  * Combined module_id and APIC ID for module level support into one
> >    patch. (Yanan)
> >  * Make cache_into_passthrough case of cpuid 0x04 leaf in
> >  * cpu_x86_cpuid() use max_processor_ids_for_cache() and
> >    max_core_ids_in_package() to encode CPUID[4]. (Yanan)
> >  * Add the prefix "CPU_TOPO_LEVEL_*" for CPU topology level names.
> >    (Yanan)
> >  * Rename the "INVALID" level to "CPU_TOPO_LEVEL_UNKNOW". (Yanan)
> > 
> > ---
> > Zhao Liu (10):
> >   i386: Fix comment style in topology.h
> >   tests: Rename test-x86-cpuid.c to test-x86-topo.c
> >   i386/cpu: Fix i/d-cache topology to core level for Intel CPU
> >   i386/cpu: Use APIC ID offset to encode cache topo in CPUID[4]
> >   i386/cpu: Consolidate the use of topo_info in cpu_x86_cpuid()
> >   i386: Add cache topology info in CPUCacheInfo
> >   i386: Use CPUCacheInfo.share_level to encode CPUID[4]
> >   i386: Fix NumSharingCache for CPUID[0x8000001D].EAX[bits 25:14]
> >   i386: Use CPUCacheInfo.share_level to encode
> >     CPUID[0x8000001D].EAX[bits 25:14]
> >   i386: Add new property to control L2 cache topo in CPUID.04H
> > 
> > Zhuocheng Ding (7):
> >   softmmu: Fix CPUSTATE.nr_cores' calculation
> >   i386: Introduce module-level cpu topology to CPUX86State
> >   i386: Support modules_per_die in X86CPUTopoInfo
> >   i386: Support module_id in X86CPUTopoIDs
> >   i386/cpu: Introduce cluster-id to X86CPU
> >   tests: Add test case of APIC ID for module level parsing
> >   hw/i386/pc: Support smp.clusters for x86 PC machine
> > 
> >  MAINTAINERS                                   |   2 +-
> >  hw/i386/pc.c                                  |   1 +
> >  hw/i386/x86.c                                 |  49 +++++-
> >  include/hw/core/cpu.h                         |   2 +-
> >  include/hw/i386/topology.h                    |  68 +++++---
> >  qemu-options.hx                               |  10 +-
> >  softmmu/cpus.c                                |   2 +-
> >  target/i386/cpu.c                             | 158 ++++++++++++++----
> >  target/i386/cpu.h                             |  25 +++
> >  tests/unit/meson.build                        |   4 +-
> >  .../{test-x86-cpuid.c => test-x86-topo.c}     |  58 ++++---
> >  11 files changed, 280 insertions(+), 99 deletions(-)
> >  rename tests/unit/{test-x86-cpuid.c => test-x86-topo.c} (73%)
> > 
> > -- 
> > 2.34.1
> 

