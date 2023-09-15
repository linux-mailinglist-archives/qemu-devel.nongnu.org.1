Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E62F57A1799
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 09:40:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh3QC-0001yG-0W; Fri, 15 Sep 2023 03:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qh3QA-0001y7-2a
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 03:39:22 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qh3Q7-00007r-Cs
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 03:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694763559; x=1726299559;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=/L5js5y+5VD6VJOtk0WYiYTY/emloq6pGvAJxw3+EWg=;
 b=j86OlX4pxpA7A+RYI4XtO6P6mZqw3qk0P4vG0CYdKDFwylSqNhX52Dpt
 p0zxCRhJtBjmyHR2vN5TAGNTs4vgn6tUxoamqWy9msB0uY8PVQDX8ACWr
 iq9ccnL/I0eD79IRL33727FrBGkz8MEH1Y4eYqNOcPuKfQDfGOMF95jBz
 mg01ivDrR6Q8jxjALn7KNzLAj+pwSGf0inuUsT1RvCUz3Hj1WA/lWjWtI
 b196Du6gdgRnamIdih1KLZTS0vrvE9SfmJ1A880/dMEph3z+aClI4uxiz
 GxeNLdnWaS5SwNIcF2xyTqLw4YlwzJUFUnjLUcUjiWcVAq2vOs7j6H9XA A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="378101883"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; d="scan'208";a="378101883"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2023 00:39:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="744876439"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; d="scan'208";a="744876439"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga002.jf.intel.com with ESMTP; 15 Sep 2023 00:39:12 -0700
Date: Fri, 15 Sep 2023 15:50:14 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Babu Moger <babu.moger@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>, Zhuocheng Ding <zhuocheng.ding@intel.com>
Subject: Re: [PATCH v4 10/21] i386: Introduce module-level cpu topology to
 CPUX86State
Message-ID: <ZQQMtqYqIVXt++s+@liuzhao-OptiPlex-7080>
References: <20230914072159.1177582-1-zhao1.liu@linux.intel.com>
 <20230914072159.1177582-11-zhao1.liu@linux.intel.com>
 <b98d2eb3-7228-5a78-3c91-d347f160bc8a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b98d2eb3-7228-5a78-3c91-d347f160bc8a@linaro.org>
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

Hi Philippe,

On Thu, Sep 14, 2023 at 09:38:46AM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu, 14 Sep 2023 09:38:46 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: Re: [PATCH v4 10/21] i386: Introduce module-level cpu topology to
>  CPUX86State
> 
> On 14/9/23 09:21, Zhao Liu wrote:
> > From: Zhuocheng Ding <zhuocheng.ding@intel.com>
> > 
> > smp command has the "clusters" parameter but x86 hasn't supported that
> > level. "cluster" is a CPU topology level concept above cores, in which
> > the cores may share some resources (L2 cache or some others like L3
> > cache tags, depending on the Archs) [1][2]. For x86, the resource shared
> > by cores at the cluster level is mainly the L2 cache.
> > 
> > However, using cluster to define x86's L2 cache topology will cause the
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
> > "cluster" in smp is the CPU topology level which is between "core" and
> > die.
> > 
> > For x86, the "cluster" in smp is corresponding to the module level [2],
> > which is above the core level. So use the "module" other than "cluster"
> > in i386 code.
> > 
> > And please note that x86 already has a cpu topology level also named
> > "cluster" [3], this level is at the upper level of the package. Here,
> > the cluster in x86 cpu topology is completely different from the
> > "clusters" as the smp parameter. After the module level is introduced,
> > the cluster as the smp parameter will actually refer to the module level
> > of x86.
> > 
> > [1]: 864c3b5c32f0 ("hw/core/machine: Introduce CPU cluster topology support")
> > [2]: Yanan's comment about "cluster",
> >       https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg04051.html
> > [3]: SDM, vol.3, ch.9, 9.9.1 Hierarchical Mapping of Shared Resources.
> > 
> > Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
> > Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > Changes since v1:
> >   * The background of the introduction of the "cluster" parameter and its
> >     exact meaning were revised according to Yanan's explanation. (Yanan)
> > ---
> >   hw/i386/x86.c     | 1 +
> >   target/i386/cpu.c | 1 +
> >   target/i386/cpu.h | 5 +++++
> >   3 files changed, 7 insertions(+)
> 
> 
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index 470257b92240..556e80f29764 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -1903,6 +1903,11 @@ typedef struct CPUArchState {
> >       /* Number of dies within this CPU package. */
> >       unsigned nr_dies;
> > +    /*
> > +     * Number of modules within this CPU package.
> > +     * Module level in x86 cpu topology is corresponding to smp.clusters.
> > +     */
> > +    unsigned nr_modules;
> >   } CPUX86State;
> 
> It would be really useful to have an ASCII art comment showing
> the architecture topology.

Good idea, I could consider how to show that.

> Also for clarity the topo fields from
> CPU[Arch]State could be moved into a 'topo' sub structure, or even
> clearer would be to re-use the X86CPUTopoIDs structure?

Yeah, I also have the plan to do further cleanup about these topology
structures [1]. X86CPUTopoInfo is not suitable for hybrid topology case,
(hybrid case needs another structure to store the max number elements
for each level), so I will try to move that X86CPUTopoInfo into
CPU[Arch]State.

[1]: https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg01032.html

Thanks,
Zhao

