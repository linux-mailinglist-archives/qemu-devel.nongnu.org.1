Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EE282DC0C
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 16:06:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPOWs-0006zn-Pp; Mon, 15 Jan 2024 10:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPOWc-0006zK-3b
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 10:05:19 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPOWW-0000Z0-66
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 10:05:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705331113; x=1736867113;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=69wjef3zFT5Ckvpkc5jU1SfwMpFVCzUmeTaQ+mJd1ok=;
 b=OlozrjLMiiIZbB89cjvJhETDBnqnfcN3yaXae42UaSqH9d/UR/T2D2QZ
 rrbkWG1OrV0xb2TqtDl0QufyTc4gX16/9djFj99clYc4oF4x9X9K/wVAJ
 aHH3jIaz0wsxCeNErn4yPP4pranhOLJCDRLqv5BrymY2XkYIeCaQyTSbg
 ItkokfH0ICvUKYRaTG98/f/dvcz1j6+2OWYUMTa05g3pjI8aDcnsMYJ1H
 WrpMs+M8Cg/L8kkKt4i6Ck2YCWu8f0GzdqAk8Wa0zPg2Pb7oqn5eRLU9e
 ehWAGAb9EX0aKmN32afXMQFCHjZz0ULK7caIfaDB0GCKP3gWePkTDXXTG g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="18236044"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="18236044"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 07:05:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="783831210"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="783831210"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga002.jf.intel.com with ESMTP; 15 Jan 2024 07:05:05 -0800
Date: Mon, 15 Jan 2024 23:18:03 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH v7 10/16] i386/cpu: Introduce cluster-id to X86CPU
Message-ID: <ZaVMq3v6yPoFARsF@intel.com>
References: <ZaTJyea4KMMk6x/m@intel.com>
 <1c58dd98-d4f6-4226-9a17-8b89c3ed632e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c58dd98-d4f6-4226-9a17-8b89c3ed632e@intel.com>
Received-SPF: none client-ip=198.175.65.9;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
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

Hi Xiaoyao,

On Mon, Jan 15, 2024 at 03:45:58PM +0800, Xiaoyao Li wrote:
> Date: Mon, 15 Jan 2024 15:45:58 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH v7 10/16] i386/cpu: Introduce cluster-id to X86CPU
> 
> On 1/15/2024 1:59 PM, Zhao Liu wrote:
> > (Also cc "machine core" maintainers.)
> > 
> > Hi Xiaoyao,
> > 
> > On Mon, Jan 15, 2024 at 12:18:17PM +0800, Xiaoyao Li wrote:
> > > Date: Mon, 15 Jan 2024 12:18:17 +0800
> > > From: Xiaoyao Li <xiaoyao.li@intel.com>
> > > Subject: Re: [PATCH v7 10/16] i386/cpu: Introduce cluster-id to X86CPU
> > > 
> > > On 1/15/2024 11:27 AM, Zhao Liu wrote:
> > > > On Sun, Jan 14, 2024 at 09:49:18PM +0800, Xiaoyao Li wrote:
> > > > > Date: Sun, 14 Jan 2024 21:49:18 +0800
> > > > > From: Xiaoyao Li <xiaoyao.li@intel.com>
> > > > > Subject: Re: [PATCH v7 10/16] i386/cpu: Introduce cluster-id to X86CPU
> > > > > 
> > > > > On 1/8/2024 4:27 PM, Zhao Liu wrote:
> > > > > > From: Zhuocheng Ding <zhuocheng.ding@intel.com>
> > > > > > 
> > > > > > Introduce cluster-id other than module-id to be consistent with
> > > > > > CpuInstanceProperties.cluster-id, and this avoids the confusion
> > > > > > of parameter names when hotplugging.
> > > > > 
> > > > > I don't think reusing 'cluster' from arm for x86's 'module' is a good idea.
> > > > > It introduces confusion around the code.
> > > > 
> > > > There is a precedent: generic "socket" v.s. i386 "package".
> > > 
> > > It's not the same thing. "socket" vs "package" is just software people and
> > > hardware people chose different name. It's just different naming issue.
> > 
> > No, it's a similar issue. Same physical device, different name only.
> > 
> > Furthermore, the topology was introduced for resource layout and silicon
> > fabrication, and similar design ideas and fabrication processes are fairly
> > consistent across common current arches. Therefore, it is possible to
> > abstract similar topological hierarchies for different arches.
> > 
> > > 
> > > however, here it's reusing name issue while 'cluster' has been defined for
> > > x86. It does introduce confusion.
> > 
> > There's nothing fundamentally different between the x86 module and the
> > generic cluster, is there? This is the reason that I don't agree with
> > introducing "modules" in -smp.
> 
> generic cluster just means the cluster of processors, i.e, a group of
> cpus/lps. It is just a middle level between die and core.

Not sure if you mean the "cluster" device for TCG GDB? "cluster" device
is different with "cluster" option in -smp.

When Yanan introduced the "cluster" option in -smp, he mentioned that it
is for sharing L2 and L3 tags, which roughly corresponds to our module.

> 
> It can be the module level in intel, or tile level. Further, if per die lp
> number increases in the future, there might be more middle levels in intel
> between die and core. Then at that time, how to decide what level should
> cluster be mapped to?

Currently, there're 3 levels defined in SDM which are between die and
core: diegrp, tile and module. In our products, L2 is just sharing on the
module, so the intel's module and the general cluster are the best match.

There are no commercially available machines for the other levels yet,
so there's no way to ensure exactly what the future holds, but we should
try to avoid fragmentation of the topology hierarchy and try to maintain
the uniform and common topology hierarchies for QEMU.

Unless a new level for -smp is introduced in the future when an unsolvable
problem is raised.

> 
> > > 
> > > > The direct definition of cluster is the level that is above the "core"
> > > > and shares the hardware resources including L2. In this sense, arm's
> > > > cluster is the same as x86's module.
> > > 
> > > then, what about intel implements tile level in the future? why ARM's
> > > 'cluster' is mapped to 'module', but not 'tile' ?
> > 
> > This depends on the actual need.
> > 
> > Module (for x86) and cluster (in general) are similar, and tile (for x86)
> > is used for L3 in practice, so I use module rather than tile to map
> > generic cluster.
> >
> > And, it should be noted that x86 module is mapped to the generic cluster,
> > not to ARM's. It's just that currently only ARM is using the clusters
> > option in -smp.
> > 
> > I believe QEMU provides the abstract and unified topology hierarchies in
> > -smp, not the arch-specific hierarchies.
> > 
> > > 
> > > reusing 'cluster' for 'module' is just a bad idea.
> > > 
> > > > Though different arches have different naming styles, but QEMU's generic
> > > > code still need the uniform topology hierarchy.
> > > 
> > > generic code can provide as many topology levels as it can. each ARCH can
> > > choose to use the ones it supports.
> > > 
> > > e.g.,
> > > 
> > > in qapi/machine.json, it says,
> > > 
> > > # The ordering from highest/coarsest to lowest/finest is:
> > > # @drawers, @books, @sockets, @dies, @clusters, @cores, @threads.
> > 
> > This ordering is well-defined...
> > 
> > > #
> > > # Different architectures support different subsets of topology
> > > # containers.
> > > #
> > > # For example, s390x does not have clusters and dies, and the socket
> > > # is the parent container of cores.
> > > 
> > > we can update it to
> > > 
> > > # The ordering from highest/coarsest to lowest/finest is:
> > > # @drawers, @books, @sockets, @dies, @clusters, @module, @cores,
> > > # @threads.
> > 
> > ...but here it's impossible to figure out why cluster is above module,
> > and even I can't come up with the difference between cluster and module.
> > 
> > > #
> > > # Different architectures support different subsets of topology
> > > # containers.
> > > #
> > > # For example, s390x does not have clusters and dies, and the socket
> > > # is the parent container of cores.
> > > #
> > > # For example, x86 does not have drawers and books, and does not support
> > > # cluster.
> > > 
> > > even if cluster of x86 is supported someday in the future, we can remove the
> > > ordering requirement from above description.
> > 
> > x86's cluster is above the package.
> > 
> > To reserve this name for x86, we can't have the well-defined topology
> > ordering.
> > 
> > But topology ordering is necessary in generic code, and many
> > calculations depend on the topology ordering.
> 
> could you point me to the code?

Yes, e.g., there're 2 helpers: machine_topo_get_cores_per_socket() and
machine_topo_get_threads_per_socket().

> 
> > > 
> > > > > 
> > > > > s390 just added 'drawer' and 'book' in cpu topology[1]. I think we can also
> > > > > add a module level for x86 instead of reusing cluster.
> > > > > 
> > > > > (This is also what I want to reply to the cover letter.)
> > > > > 
> > > > > [1] https://lore.kernel.org/qemu-devel/20231016183925.2384704-1-nsg@linux.ibm.com/
> > > > 
> > > > These two new levels have the clear topological hierarchy relationship
> > > > and don't duplicate existing ones.
> > > > 
> > > > "book" or "drawer" may correspond to intel's "cluster".
> > > > 
> > > > Maybe, in the future, we could support for arch-specific alias topologies
> > > > in -smp.
> > > 
> > > I don't think we need alias, reusing 'cluster' for 'module' doesn't gain any
> > > benefit except avoid adding a new field in SMPconfiguration. All the other
> > > cluster code is ARM specific and x86 cannot share.
> > 
> > The point is that there is no difference between intel module and general
> > cluster...Considering only the naming issue, even AMD has the "complex" to
> > correspond to the Intel's "module".
> 
> does complex of AMD really match with intel module? L3 cache is shared in
> one complex, while L2 cache is shared in one module for now.

If then it could correspond to intel's tile, which is after all a level
below die.

Thanks,
Zhao


