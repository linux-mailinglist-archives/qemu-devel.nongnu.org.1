Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 816F4780655
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 09:28:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWttD-0002qS-QR; Fri, 18 Aug 2023 03:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qWtt7-0002qG-Mo
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 03:27:17 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qWtt4-000240-0X
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 03:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692343634; x=1723879634;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=b/VwXdY1S8Rrt8d506nAf7O88j1HNGObBnysetfFOpg=;
 b=eURgdYOh5JeqJKt8CkRt+uqTVO4LTjQr02EGcFr93JjBnUtcqQ0CM/b7
 EQxMMHDokKCPToZWA/wv92AINFqAtK+oEO+t9mBPcHW1xLqb/yknE6/Sf
 joo3tfet0F34Ltc12zK7DFnxaxuqP8grHZE2jg3aw/ksp1T8clvb/m0ot
 fVHparQ9sN67Fjvb3BbKl78E8BC941dJYYhA918wCKUO1Z/3rJMkel6lZ
 ZtTWwHhwoTKxs2CbjG8wp3ZUEzswGWJiQFyZ38qZQX1AqAsIVtZPC65wz
 0fMyNGi9rPszffWe4tgYV17WGxR4d1K6QBGpvg9rSVg/C5s6eyPCIMKNP g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="352624892"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="352624892"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2023 00:27:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="908757435"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="908757435"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by orsmga005.jf.intel.com with ESMTP; 18 Aug 2023 00:27:05 -0700
Date: Fri, 18 Aug 2023 15:37:39 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Moger, Babu" <babu.moger@amd.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Wei Wang <wei.w.wang@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 14/17] i386: Use CPUCacheInfo.share_level to encode
 CPUID[4]
Message-ID: <ZN8fw0CU+j/dOvBy@liuzhao-OptiPlex-7080>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-15-zhao1.liu@linux.intel.com>
 <19ba8210-3e11-a36f-3b26-52cbe40042b1@amd.com>
 <3f7510f2-20f3-93df-72b3-01cfa687f554@amd.com>
 <ZMzJaElw/T5caQU+@liuzhao-OptiPlex-7080>
 <5947274f-e29d-cb76-3325-5dc75f205eeb@amd.com>
 <ZNnkR+G6PvE2q77E@liuzhao-OptiPlex-7080>
 <4615221c-407c-1542-56c8-a9557a5800b2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4615221c-407c-1542-56c8-a9557a5800b2@amd.com>
Received-SPF: none client-ip=192.55.52.136;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
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

Hi Babu,

On Mon, Aug 14, 2023 at 11:03:53AM -0500, Moger, Babu wrote:
> Date: Mon, 14 Aug 2023 11:03:53 -0500
> From: "Moger, Babu" <babu.moger@amd.com>
> Subject: Re: [PATCH v3 14/17] i386: Use CPUCacheInfo.share_level to encode
>  CPUID[4]
> 
> Hi Zhao,
> 
> 
> On 8/14/23 03:22, Zhao Liu wrote:
> > Hi Babu,
> > 
> > On Fri, Aug 04, 2023 at 10:48:29AM -0500, Moger, Babu wrote:
> >> Date: Fri, 4 Aug 2023 10:48:29 -0500
> >> From: "Moger, Babu" <babu.moger@amd.com>
> >> Subject: Re: [PATCH v3 14/17] i386: Use CPUCacheInfo.share_level to encode
> >>  CPUID[4]
> >>
> >> Hi Zhao,
> >>
> >> On 8/4/23 04:48, Zhao Liu wrote:
> >>> Hi Babu,
> >>>
> >>> On Thu, Aug 03, 2023 at 11:41:40AM -0500, Moger, Babu wrote:
> >>>> Date: Thu, 3 Aug 2023 11:41:40 -0500
> >>>> From: "Moger, Babu" <babu.moger@amd.com>
> >>>> Subject: Re: [PATCH v3 14/17] i386: Use CPUCacheInfo.share_level to encode
> >>>>  CPUID[4]
> >>>>
> >>>> Hi Zhao,
> >>>>
> >>>> On 8/2/23 18:49, Moger, Babu wrote:
> >>>>> Hi Zhao,
> >>>>>
> >>>>> Hitting this error after this patch.
> >>>>>
> >>>>> ERROR:../target/i386/cpu.c:257:max_processor_ids_for_cache: code should
> >>>>> not be reached
> >>>>> Bail out! ERROR:../target/i386/cpu.c:257:max_processor_ids_for_cache: code
> >>>>> should not be reached
> >>>>> Aborted (core dumped)
> >>>>>
> >>>>> Looks like share_level for all the caches for AMD is not initialized.
> >>>
> >>> I missed these change when I rebase. Sorry for that.
> >>>
> >>> BTW, could I ask a question? From a previous discussion[1], I understand
> >>> that the cache info is used to show the correct cache information in
> >>> new machine. And from [2], the wrong cache info may cause "compatibility
> >>> issues".
> >>>
> >>> Is this "compatibility issues" AMD specific? I'm not sure if Intel should
> >>> update the cache info like that. thanks!
> >>
> >> I was going to comment about that. Good that you asked me.
> >>
> >> Compatibility is qemu requirement.  Otherwise the migrations will fail.
> >>
> >> Any changes in the topology is going to cause migration problems.
> > 
> > Could you please educate me more about the details of the "migration
> > problem"?
> > 
> > I didn't understand why it was causing the problem and wasn't sure if I
> > was missing any cases.
> > 
> 
> I am not an expert on migration but I test VM migration sometimes.
> Here are some guidelines.
> https://developers.redhat.com/blog/2015/03/24/live-migrating-qemu-kvm-virtual-machines

Thanks for the material!

> 
> When you migrate a VM to newer qemu using the same CPU type, migration
> should work seamless. That means list of CPU features should be compatible
> when you move to newer qemu version with CPU type.

I see. This patches set adds the "-smp cluster" command and the
"x-l2-cache-topo" command. Migration requires that the target and
source VM command lines are the same, so the new commands ensure that
the migration is consistent.

But this patch set also includes some topology fixes (nr_cores fix and
l1 cache topology fix) and encoding change (use APIC ID offset to encode
addressable ids), these changes would affect migration and may cause
CPUID change for VM view. Thus if this patch set is accepted, these
changes also need to be pushed into stable versions. Do you agree?

And about cache info for different CPU generations, migration usually
happens on the same CPU type, and Intel uses the same default cache
info for all CPU types. With the consistent cache info, migration is
also Ok. So if we don't care about the specific cache info in the VM,
it's okay to use the same default cache info for all CPU types. Right?

Thanks,
Zhao

