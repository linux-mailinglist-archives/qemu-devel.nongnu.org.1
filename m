Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AAD7CDE2F
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:01:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt76t-00005I-Mi; Wed, 18 Oct 2023 10:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qt76d-0008Uc-62
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:01:03 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qt76b-0002bD-5Q
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697637661; x=1729173661;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=PZSpbvjgwAY4YZBoKxKFoin1sX3JYllTNPMx6/Mbh5o=;
 b=GaLlWjwKrI2Y8amxjlSETIGlt16QfjIqhW+cP0+EpSjBSD5v9mvV14WW
 MgSoe8/tK/0p2iO0BpqsC6UBkbP2ErGlJO4CI5RBD4ECa2aKkaadNdHOC
 dRsgAFEnuA4hdQbE4nDAP/IsEiLFKc0jaoH9fb7i8FLpKL9H4T8Du98mQ
 sISqzmx6n6xvdDGrmjMjfYzFTBoMMoscl1nEpaMldn9XzArWayeoV80zW
 wChFJPLjEzFRPhX+1HVGBroTnLia9pWs59b2vK4WQk7ivy1Dn0wWAt/oM
 y5Xf8KN9kJXwtZWHauy8QJOoDKsuN4RQYkiXwpyeNaGgE1xvjh9McX6uC A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="371080266"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; d="scan'208";a="371080266"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2023 07:00:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="760230362"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; d="scan'208";a="760230362"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga007.fm.intel.com with ESMTP; 18 Oct 2023 07:00:53 -0700
Date: Wed, 18 Oct 2023 22:12:30 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Babu Moger <babu.moger@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 21/21] i386: Add new property to control L2 cache topo
 in CPUID.04H
Message-ID: <ZS/nzpLD/ZmEnpGb@liuzhao-OptiPlex-7080>
References: <20230914072159.1177582-1-zhao1.liu@linux.intel.com>
 <20230914072159.1177582-22-zhao1.liu@linux.intel.com>
 <75ea5477-ca1b-7016-273c-abd6c36f4be4@linaro.org>
 <ZQQNddiCky/cImAz@liuzhao-OptiPlex-7080>
 <20231003085516-mutt-send-email-mst@kernel.org>
 <ZSA3mfmOz+RZcmct@liuzhao-OptiPlex-7080>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSA3mfmOz+RZcmct@liuzhao-OptiPlex-7080>
Received-SPF: none client-ip=134.134.136.126;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi Michael,

On Sat, Oct 07, 2023 at 12:36:41AM +0800, Zhao Liu wrote:
> Date: Sat, 7 Oct 2023 00:36:41 +0800
> From: Zhao Liu <zhao1.liu@linux.intel.com>
> Subject: Re: [PATCH v4 21/21] i386: Add new property to control L2 cache
>  topo in CPUID.04H
> 
> Hi Michael,
> 
> On Tue, Oct 03, 2023 at 08:57:27AM -0400, Michael S. Tsirkin wrote:
> > Date: Tue, 3 Oct 2023 08:57:27 -0400
> > From: "Michael S. Tsirkin" <mst@redhat.com>
> > Subject: Re: [PATCH v4 21/21] i386: Add new property to control L2 cache
> >  topo in CPUID.04H
> > 
> > On Fri, Sep 15, 2023 at 03:53:25PM +0800, Zhao Liu wrote:
> > > Hi Philippe,
> > > 
> > > On Thu, Sep 14, 2023 at 09:41:30AM +0200, Philippe Mathieu-Daud? wrote:
> > > > Date: Thu, 14 Sep 2023 09:41:30 +0200
> > > > From: Philippe Mathieu-Daud? <philmd@linaro.org>
> > > > Subject: Re: [PATCH v4 21/21] i386: Add new property to control L2 cache
> > > >  topo in CPUID.04H
> > > > 
> > > > On 14/9/23 09:21, Zhao Liu wrote:
> > > > > From: Zhao Liu <zhao1.liu@intel.com>
> > > > > 
> > > > > The property x-l2-cache-topo will be used to change the L2 cache
> > > > > topology in CPUID.04H.
> > > > > 
> > > > > Now it allows user to set the L2 cache is shared in core level or
> > > > > cluster level.
> > > > > 
> > > > > If user passes "-cpu x-l2-cache-topo=[core|cluster]" then older L2 cache
> > > > > topology will be overrode by the new topology setting.
> > > > > 
> > > > > Here we expose to user "cluster" instead of "module", to be consistent
> > > > > with "cluster-id" naming.
> > > > > 
> > > > > Since CPUID.04H is used by intel CPUs, this property is available on
> > > > > intel CPUs as for now.
> > > > > 
> > > > > When necessary, it can be extended to CPUID.8000001DH for AMD CPUs.
> > > > > 
> > > > > (Tested the cache topology in CPUID[0x04] leaf with "x-l2-cache-topo=[
> > > > > core|cluster]", and tested the live migration between the QEMUs w/ &
> > > > > w/o this patch series.)
> > > > > 
> > > > > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > > > > Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> > > > > ---
> > > > > Changes since v3:
> > > > >   * Add description about test for live migration compatibility. (Babu)
> > > > > 
> > > > > Changes since v1:
> > > > >   * Rename MODULE branch to CPU_TOPO_LEVEL_MODULE to match the previous
> > > > >     renaming changes.
> > > > > ---
> > > > >   target/i386/cpu.c | 34 +++++++++++++++++++++++++++++++++-
> > > > >   target/i386/cpu.h |  2 ++
> > > > >   2 files changed, 35 insertions(+), 1 deletion(-)
> > > > 
> > > > 
> > > > > @@ -8079,6 +8110,7 @@ static Property x86_cpu_properties[] = {
> > > > >                        false),
> > > > >       DEFINE_PROP_BOOL("x-intel-pt-auto-level", X86CPU, intel_pt_auto_level,
> > > > >                        true),
> > > > > +    DEFINE_PROP_STRING("x-l2-cache-topo", X86CPU, l2_cache_topo_level),
> > > > 
> > > > We use the 'x-' prefix for unstable features, is it the case here?
> > > 
> > > I thought that if we can have a more general CLI way to define cache
> > > topology in the future, then this option can be removed.
> > > 
> > > I'm not sure if this option could be treated as unstable, what do you
> > > think?
> > > 
> > > 
> > > Thanks,
> > > Zhao
> > 
> > Then, please work on this new generic thing.
> > What we don't want is people relying on unstable options.
> > 
> 
> Okay, I'll remove this option in the next refresh.
> 
> BTW, about the generic cache topology, what about porting this option to
> smp? Just like:
> 
> -smp cpus=4,sockets=2,cores=2,threads=1, \
>      l3-cache=socket,l2-cache=core,l1-i-cache=core,l1-d-cache=core
> 
> From the previous discussion [1] with Jonathan, it seems this format
> could also meet the requirement for ARM.
> 
> If you like this, I'll move forward in this direction. ;-)
> 
> [1]: https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg03997.html

Let me get this thread warmed up again.

Could I get your initial thoughts on the general cache topology idea
above?

Thanks,
Zhao

