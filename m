Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E4A82A92F
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 09:34:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNqVf-0007VQ-2q; Thu, 11 Jan 2024 03:33:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rNqVc-0007Us-Q4
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:33:52 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rNqVb-00087J-2c
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704962032; x=1736498032;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=larED5ocgA7/Xweo3DyaTLQk2Fdwzv9gml6jTTCp4KM=;
 b=SreU4JkdWBi0ipv4XA8rNXvqXK/cb5tn0uOUK0DKn4yfsbCnq0/CPPGN
 XtTXVodYNFGhDSUKrxrCD7VaBYI86MzJwTxFwTXTmN9M3TFsaBDuclNnG
 QWzCqJBEePnhT3iS0Y8Fj7U+zP2oR3pR+vEuszguqyuzj7ELu9eZfEFAc
 oZXLNWHM/g1/Hox70Q3eQjoTELqr8LnwZkFG6Kj/20HZ0jtTE7GbX23/m
 enxXb/jx2GowJluzu2XRj4fyrZRAXwm7QAXlXPBWsq3n9LYaUDE+ifQal
 7/sA57L3fQouaQiLsJJDAZSFmXHz/VTV5ugZrHU8FP7qRr0HnlpQshh9f Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="12135454"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; d="scan'208";a="12135454"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2024 00:33:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="732142769"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; d="scan'208";a="732142769"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga003.jf.intel.com with ESMTP; 11 Jan 2024 00:33:41 -0800
Date: Thu, 11 Jan 2024 16:46:37 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Robert Hoo <robert.hu@linux.intel.com>,
 Babu Moger <babu.moger@amd.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH v7 03/16] i386/cpu: Consolidate the use of topo_info in
 cpu_x86_cpuid()
Message-ID: <ZZ+q7d9+ZOwOum2F@intel.com>
References: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
 <20240108082727.420817-4-zhao1.liu@linux.intel.com>
 <ddb911d0-6054-43ab-a763-242216b9c8d9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddb911d0-6054-43ab-a763-242216b9c8d9@intel.com>
Received-SPF: none client-ip=198.175.65.10;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
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

On Wed, Jan 10, 2024 at 07:52:38PM +0800, Xiaoyao Li wrote:
> Date: Wed, 10 Jan 2024 19:52:38 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH v7 03/16] i386/cpu: Consolidate the use of topo_info in
>  cpu_x86_cpuid()
> 
> On 1/8/2024 4:27 PM, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > In cpu_x86_cpuid(), there are many variables in representing the cpu
> > topology, e.g., topo_info, cs->nr_cores/cs->nr_threads.
> 
> Please use comma instead of slash. cs->nr_cores/cs->nr_threads looks like
> one variable.

Okay.

> 
> > Since the names of cs->nr_cores/cs->nr_threads does not accurately
> > represent its meaning, the use of cs->nr_cores/cs->nr_threads is prone
> > to confusion and mistakes.
> > 
> > And the structure X86CPUTopoInfo names its members clearly, thus the
> > variable "topo_info" should be preferred.
> > 
> > In addition, in cpu_x86_cpuid(), to uniformly use the topology variable,
> > replace env->dies with topo_info.dies_per_pkg as well.
> > 
> > Suggested-by: Robert Hoo <robert.hu@linux.intel.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > Tested-by: Babu Moger <babu.moger@amd.com>
> > Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > Changes since v3:
> >   * Fix typo. (Babu)
> > 
> > Changes since v1:
> >   * Extract cores_per_socket from the code block and use it as a local
> >     variable for cpu_x86_cpuid(). (Yanan)
> >   * Remove vcpus_per_socket variable and use cpus_per_pkg directly.
> >     (Yanan)
> >   * Replace env->dies with topo_info.dies_per_pkg in cpu_x86_cpuid().
> > ---
> >   target/i386/cpu.c | 31 ++++++++++++++++++-------------
> >   1 file changed, 18 insertions(+), 13 deletions(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index c8d2a585723a..6f8fa772ecf8 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -6017,11 +6017,16 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >       uint32_t limit;
> >       uint32_t signature[3];
> >       X86CPUTopoInfo topo_info;
> > +    uint32_t cores_per_pkg;
> > +    uint32_t cpus_per_pkg;
> 
> I prefer to lps_per_pkg or threads_per_pkg.

Okay, lp is not common in QEMU code, so I would change this to
threads_per_pkg.

> 
> Other than it,
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

Thanks!

-Zhao


