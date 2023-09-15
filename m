Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E302B7A17B1
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 09:42:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh3TD-0005RI-Dt; Fri, 15 Sep 2023 03:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qh3TB-0005LH-Ha
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 03:42:29 -0400
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qh3T9-00017H-Th
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 03:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694763747; x=1726299747;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=cDgMalxwmA0/rs78BBy/qTkAwU1CeKaTo0idZtPsVfs=;
 b=EsPAziSSJ7u+gh/AQ0lnopHn4s53VX9lSTUReKZY8fc5d8q7qGFhBYHh
 1It1xHjR+ewN1V+ZoVl6GA9OYZwfcFg2eGQcMhjeW4W0IiSWNKu0bNwSW
 Y56JS71D0ExzJ6oCV0jXJeu/ONgsJvKfY2Fc+NhtSMQahi4y4+KnT0GqU
 3FDZ0czg3kJKAS+9oxqz5xSYXbWCZXiNQAwRjypM9xHOXGXI3zNsiZTwH
 NNz1Tfy7oiWzES5Gm3HkJfrnd5CUoRX08YsdevkdVL0ZVdg4lZ4cC3hcp
 EYl4aL62M0AbufkrjeiDsFPzosfq1pDiETypC8pZ8lP7F99hs4TG2orYc A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="379104079"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; d="scan'208";a="379104079"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2023 00:42:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="860059358"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; d="scan'208";a="860059358"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga002.fm.intel.com with ESMTP; 15 Sep 2023 00:42:22 -0700
Date: Fri, 15 Sep 2023 15:53:25 +0800
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
 Zhao Liu <zhao1.liu@intel.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH v4 21/21] i386: Add new property to control L2 cache topo
 in CPUID.04H
Message-ID: <ZQQNddiCky/cImAz@liuzhao-OptiPlex-7080>
References: <20230914072159.1177582-1-zhao1.liu@linux.intel.com>
 <20230914072159.1177582-22-zhao1.liu@linux.intel.com>
 <75ea5477-ca1b-7016-273c-abd6c36f4be4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75ea5477-ca1b-7016-273c-abd6c36f4be4@linaro.org>
Received-SPF: none client-ip=192.55.52.115;
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

On Thu, Sep 14, 2023 at 09:41:30AM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu, 14 Sep 2023 09:41:30 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: Re: [PATCH v4 21/21] i386: Add new property to control L2 cache
>  topo in CPUID.04H
> 
> On 14/9/23 09:21, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > The property x-l2-cache-topo will be used to change the L2 cache
> > topology in CPUID.04H.
> > 
> > Now it allows user to set the L2 cache is shared in core level or
> > cluster level.
> > 
> > If user passes "-cpu x-l2-cache-topo=[core|cluster]" then older L2 cache
> > topology will be overrode by the new topology setting.
> > 
> > Here we expose to user "cluster" instead of "module", to be consistent
> > with "cluster-id" naming.
> > 
> > Since CPUID.04H is used by intel CPUs, this property is available on
> > intel CPUs as for now.
> > 
> > When necessary, it can be extended to CPUID.8000001DH for AMD CPUs.
> > 
> > (Tested the cache topology in CPUID[0x04] leaf with "x-l2-cache-topo=[
> > core|cluster]", and tested the live migration between the QEMUs w/ &
> > w/o this patch series.)
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> > ---
> > Changes since v3:
> >   * Add description about test for live migration compatibility. (Babu)
> > 
> > Changes since v1:
> >   * Rename MODULE branch to CPU_TOPO_LEVEL_MODULE to match the previous
> >     renaming changes.
> > ---
> >   target/i386/cpu.c | 34 +++++++++++++++++++++++++++++++++-
> >   target/i386/cpu.h |  2 ++
> >   2 files changed, 35 insertions(+), 1 deletion(-)
> 
> 
> > @@ -8079,6 +8110,7 @@ static Property x86_cpu_properties[] = {
> >                        false),
> >       DEFINE_PROP_BOOL("x-intel-pt-auto-level", X86CPU, intel_pt_auto_level,
> >                        true),
> > +    DEFINE_PROP_STRING("x-l2-cache-topo", X86CPU, l2_cache_topo_level),
> 
> We use the 'x-' prefix for unstable features, is it the case here?

I thought that if we can have a more general CLI way to define cache
topology in the future, then this option can be removed.

I'm not sure if this option could be treated as unstable, what do you
think?


Thanks,
Zhao

> 
> >       DEFINE_PROP_END_OF_LIST()
> >   };
> 

