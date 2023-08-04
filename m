Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5863C7700D4
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 15:09:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRuXg-0000u8-SI; Fri, 04 Aug 2023 09:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qRuXb-0000kX-V3
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 09:08:28 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qRuXX-0000uI-N7
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 09:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691154503; x=1722690503;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=sYUKWsosnvhaRJyTGh+luAG/R3g4SSzOKLqF5ooJylk=;
 b=M0OYCDltri1o9W2+0tNi8LgNIV/9W1rIam4Iwp8I4jBUl2IE8XWznZwE
 JtQ3Egx6Y7GbYRJPw/ZNEqZHteK/yT68TkTFqgKchKNuNDULDptKGhlbS
 lhktMT07jhWEToOia9mKXRiYgzwvhqoRhD6QaAEhX+PbjOBTSEULHzup3
 zK5x/YI/nHhQdhBrU17+WCZhGek+sqSlakfjTHa+SKaab3pTEg3CyWnsO
 WLum8GfmIk87T0bRO5ekd+cSu8jBgNOAQx8PR9BvOmYnBkgYs+R/LGj1b
 t+hv3dtZjPdFfC/R29T/VOXqFvBAbiDi2GzqoONi4SIFbYvHup5oUsibc A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="369048112"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; d="scan'208";a="369048112"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2023 06:07:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="795416235"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; d="scan'208";a="795416235"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by fmsmga008.fm.intel.com with ESMTP; 04 Aug 2023 06:07:31 -0700
Date: Fri, 4 Aug 2023 21:17:59 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Babu Moger <babu.moger@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 00/17] Support smp.clusters for x86
Message-ID: <ZMz6h/c1WrV+jf83@liuzhao-OptiPlex-7080>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801163527.00004bcc@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801163527.00004bcc@Huawei.com>
Received-SPF: none client-ip=192.55.52.120;
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

Hi Jonathan,

On Tue, Aug 01, 2023 at 04:35:27PM +0100, Jonathan Cameron via wrote:
> > 

[snip]

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
> 
> Hi Zhao Liu,
> 
> As part of emulating arm's MPAM (cache partitioning controls) I needed
> to add the missing cache description in the ACPI PPTT table. As such I ran
> into a very similar problem to the one you are addressing.

May I ask if the cache topology you need is symmetric or heterogeneous?

I had the discussion with Yanan [5] about heterogeneous cache. If you
need a "symmetric" cache topology, maybe we could consider trying make
this x-l2-cache-topo more generic.

But if you need a heterogeneous cache topo, e.g., some cores have its
own l2 cache, and other cores share the same l2 cache, only this command
is not enough.

Intel hybrid platforms have the above case I mentioned, we used "hybrid
CPU topology" [6] + "x-l2-cache-topo=cluster" to solve this:

For example, AdlerLake has 2 types of core, one type is P-core with L2 per
P-core, and another type is E-core that 4 E-cores share a L2.

So we set a CPU topology like this:

Set 2 kinds of clusters:
* 1 P-core is in a cluster.
* 4 E-cores in a cluster.

Then we use "x-l2-cache-topo" to make l2 is shared at cluster. In this
way, a P-core could own a L2 because its cluster only has 1 P-core, and
4 E-cores could could share a L2.

For more general way to set cache topology, Yanan and me discussed 2
ways ([7] [8]). [8] depends on the QOM CPU topology mechanism that I'm
working on.

[5]: https://mail.gnu.org/archive/html/qemu-devel/2023-02/msg04795.html
[6]: https://mail.gnu.org/archive/html/qemu-devel/2023-02/msg03205.html
[7]: https://mail.gnu.org/archive/html/qemu-devel/2023-02/msg05139.html
[8]: https://mail.gnu.org/archive/html/qemu-devel/2023-02/msg05167.html

> 
> I wonder if a more generic description is possible? We can rely on ordering
> of the cache levels, so what I was planning to propose was the rather lengthy
> but flexible (and with better names ;)
> 
> -smp 16,sockets=1,clusters=4,threads=2,cache-cluster-start-level=2,cache-node-start-level=3

Could you explain more about this command?
I don't understand what "cache-cluster-start-level=2,cache-node-start-level=3" mean.

> 
> Perhaps we can come up with a common scheme that covers both usecases?
> It gets more fiddly to define if we have variable topology across different clusters
> - and that was going to be an open question in the RFC proposing this - our current
> definition of the more basic topology doesn't cover those cases anyway.
> 
> What I want:
> 
> 1) No restriction on maximum cache levels - ...

Hmmm, if there's no cache name, it would be difficult to define in cli.

> ... some systems have more than 3

What about L4? A name can simplify a lot of issues.

> 2) Easy ability to express everything from all caches are private to all caches are shared.
> Is 3 levels enough? (private, shared at cluster level, shared at a level above that) I think
> so, but if not any scheme should be extensible to cover another level.

It seems you may need the "heterogeneous" cache topology.

I think "private" and "shared" are not good definitions of cache, since
they are not technical terms? (Correct me if I'm wrong.) And i/d cache,
l1 cache, l2 cache are generic terms accepted by many architectures.

Though cache topology is different with CPU topology, it's true that the
cache topology is related to the CPU hierarchy, so I think using the CPU
topology hierarchy to define the heterogeneous topology looks like a more
appropriate way to do it.

> 
> Great if we can figure out a common scheme.

Yeah, it's worth discussing.

Thanks,
Zhao

> 
> Jonathan
> 
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
> > [1]: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg07179.html
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
> > Changes since v2:
> >  * Add "Tested-by", "Reviewed-by" and "ACKed-by" tags.
> >  * Use newly added wrapped helper to get cores per socket in
> >    qemu_init_vcpu().
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
> 
> 

