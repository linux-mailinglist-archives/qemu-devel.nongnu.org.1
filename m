Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CB2771D8A
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 11:52:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSwtn-0004y9-UD; Mon, 07 Aug 2023 05:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qSwsA-0004Ni-5z
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:50:04 -0400
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qSws7-0003hD-CV
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691401795; x=1722937795;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=lx2Usg4vitoRh3VrdkazUO/AHTuyjUYyJciBAk+4334=;
 b=nRl5SLlHLvrbllV9jSlEyoNPvk6igP2aK3HQAcxRtPDnigDfQxk8nDLV
 2C5kpQMNW7rsihK6U7773vyyVwM6zZFqCs5iZzPrGjx8OVaD+vG6hQTxE
 c6T7fVX1eNe486wWNTOv2A8Fk5Cx7nzVcR5CMoisF/fEfea5luUHWVy/Z
 nKjsFofuwjdzSdzD2l2IJ82BD3kwgpojJDPfgIEKccqCE3s9Cdku0urkH
 grtmaZSn8bYUSEsUa92eLHSwFwoaY+i7L392tLVX8QkQxVzMq6VyLog9u
 SKqrDSNnlkwyUdk8LShAU48vPVN+QhIgn6WgSZmkflYkJZW6t1W17v4QI g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="360585237"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; d="scan'208";a="360585237"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2023 02:49:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="707811179"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; d="scan'208";a="707811179"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by orsmga006.jf.intel.com with ESMTP; 07 Aug 2023 02:49:49 -0700
Date: Mon, 7 Aug 2023 18:00:18 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Babu Moger <babu.moger@amd.com>, Zhao Liu <zhao1.liu@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>
Subject: Re: [PATCH v3 03/17] softmmu: Fix CPUSTATE.nr_cores' calculation
Message-ID: <ZNDAsj0N/FoBXG/b@liuzhao-OptiPlex-7080>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-4-zhao1.liu@linux.intel.com>
 <17d46d49-844c-60ed-56cc-0e671564948a@intel.com>
 <ZNCi6uNsVB1F39XD@liuzhao-OptiPlex-7080>
 <7d3d2630-4ac4-8875-8c6f-054000462755@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d3d2630-4ac4-8875-8c6f-054000462755@intel.com>
Received-SPF: none client-ip=134.134.136.20;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 07, 2023 at 04:43:32PM +0800, Xiaoyao Li wrote:
> Date: Mon, 7 Aug 2023 16:43:32 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH v3 03/17] softmmu: Fix CPUSTATE.nr_cores' calculation
> 
> On 8/7/2023 3:53 PM, Zhao Liu wrote:
> > > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > > index 97ad229d8ba3..50613cd04612 100644
> > > > --- a/target/i386/cpu.c
> > > > +++ b/target/i386/cpu.c
> > > > @@ -6011,7 +6011,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> > > >        X86CPUTopoInfo topo_info;
> > > >        topo_info.dies_per_pkg = env->nr_dies;
> > > > -    topo_info.cores_per_die = cs->nr_cores;
> > > > +    topo_info.cores_per_die = cs->nr_cores / env->nr_dies;
> > > This and below things make me think that, it looks ugly that @nr_dies is
> > > added separately in struct CPUArchState for i386 because CPUState only has
> > > @nr_cores and nr_threads. Further, for i386, it defines a specific struct
> > > X86CPUTopoInfo to contain topology info when setting up CPUID. To me, struct
> > > X86CPUTopoInfo is redundant as struct CpuTopology.
> > > 
> > > maybe we can carry a struct CpuTopology in CPUState, so that we can drop
> > > @nr_threads, @nr_cores in CPUState for all ARCHes, and @nr_dies in struct
> > > CPUArchState for i386. As well, topo_info can be dropped here.
> > Yeah, I agree. We think the same way, as did in [1].
> > 
> > About X86CPUTopoInfo, it's still necessary to keep to help encode
> > APICID.
> 
> typedef struct X86CPUTopoInfo {
>     unsigned dies_per_pkg;
>     unsigned cores_per_die;
>     unsigned threads_per_core;
> } X86CPUTopoInfo;
> 
> /**
>  * CpuTopology:
>  * @cpus: the number of present logical processors on the machine
>  * @sockets: the number of sockets on the machine
>  * @dies: the number of dies in one socket
>  * @clusters: the number of clusters in one die
>  * @cores: the number of cores in one cluster
>  * @threads: the number of threads in one core
>  * @max_cpus: the maximum number of logical processors on the machine
>  */
> typedef struct CpuTopology {
>     unsigned int cpus;
>     unsigned int sockets;
>     unsigned int dies;
>     unsigned int clusters;
>     unsigned int cores;
>     unsigned int threads;
>     unsigned int max_cpus;
> } CpuTopology;
> 
> I think 'struct X86CPUTopoInfo' is just a subset of 'struct CpuTopology'

For smp topology, it's correct.

> 
> IIUC, currently the value of X86CPUTopoInfo::dies_per_pkg should equal with
> CpuTopology::dies, and the same for cores_per_die and threads_per_core.
> 
> So it's OK to keep an copy of 'struct CpuTopology' in CPUState and drop
> 'struct X86CPUTopoInfo'
> 
> > For hybrid topology case, the APICID is likely discontinuous,
> > and the width of each CPU level in APICID depends on the maximum number
> > of elements in this level. So I also proposed to rename it to
> > X86ApicidTopoInfo [2] and count the maximum number of elements in each
> > CPU level.
> 
> Do you mean, for example, for hybrid topology, X86CPUTopoInfo::dies_per_pkg
> != CpuTopology::dies? Or after rename
> X86CPUTopoInfo::max_dies != CpuTopology::dies?

I mean the latter.

A more typical example nowadays is thread level.

X86CPUTopoInfo::max_threads may not euqal to CpuTopology::threads,

since P core has 2 threads per core and E core doesn't support SMT.

The CpuTopology in CPUState should reflect the topology information for
current CPU, so CpuTopology::threads is 2 for P core and
CpuTopology::threads = 1 for E core.

But the width of the SMT level in APICID must be fixed, so that SMT width
should be determined by X86CPUTopoInfo::max_threads. Current hybrid
platforms implement it the same way.

Thanks,
Zhao

> 
> > [2]:https://mail.gnu.org/archive/html/qemu-devel/2023-02/msg03237.html
> > 
> > Thanks,
> > Zhao
> > 
> 

