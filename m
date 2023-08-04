Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31199770047
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 14:33:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRtzC-0004ck-0H; Fri, 04 Aug 2023 08:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qRtz9-0004c2-63
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 08:32:51 -0400
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qRtz6-0002Ba-Pk
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 08:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691152368; x=1722688368;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=onQnkNB2I9Gshy/otEKs8C4XVr+BJ4k0ZiMyZIgohXc=;
 b=Jkoq1hBaX+dr530dJTNLzz/GPqTNL8o1HKX5aFq6Jbjuwg0cna0mQTQN
 ZkYr+UnPkZg0xGpV4Xzrq4jBgyPQcTmTTVV1ANZ/FeAknvwvZcv1vLO/M
 LzrCLhoi1g37yBKNo+rFKfTxo5W1Ai/TcWlIyNh0SRbYNhfyA84ZtxhUh
 ftkrzZDzucf1wVcNXXr3p1XU6gTBPK7UPlA2hTyfcUJnk+o88ppbNstdI
 BgdbeLMUhOMyaBsHVeC+cJR5+LeZ52zUgrZXL8t9ExhsSnAp3xo2lYHbM
 /aBLAPKW+E/8upp+Mc8ouFGGPrPAZ6qMFIVW5vMuUtj7IPc7MFL6Dpj8y g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="360197377"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; d="scan'208";a="360197377"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2023 05:32:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="1060734025"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; d="scan'208";a="1060734025"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by fmsmga005.fm.intel.com with ESMTP; 04 Aug 2023 05:32:42 -0700
Date: Fri, 4 Aug 2023 20:43:10 +0800
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
 Robert Hoo <robert.hu@linux.intel.com>
Subject: Re: [PATCH v3 04/17] i386/cpu: Fix i/d-cache topology to core level
 for Intel CPU
Message-ID: <ZMzyXjHAk9hw7ON3@liuzhao-OptiPlex-7080>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-5-zhao1.liu@linux.intel.com>
 <5514cbba-50ac-11cb-af46-ddd8ec4750e7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5514cbba-50ac-11cb-af46-ddd8ec4750e7@intel.com>
Received-SPF: none client-ip=134.134.136.20;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Fri, Aug 04, 2023 at 05:56:47PM +0800, Xiaoyao Li wrote:
> Date: Fri, 4 Aug 2023 17:56:47 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH v3 04/17] i386/cpu: Fix i/d-cache topology to core
>  level for Intel CPU
> 
> On 8/1/2023 6:35 PM, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > For i-cache and d-cache, the maximum IDs for CPUs sharing cache (
> > CPUID.04H.00H:EAX[bits 25:14] and CPUID.04H.01H:EAX[bits 25:14]) are
> > both 0,
> 
> This sounds like you are describing some architectural rules, which misleads
> me. I suggest changing the description to
> 
> For i-cache and d-cache, current QEMU hardcodes the maximum IDs for CPUs
> sharing cache (CPUID.04H.00H:EAX[bits 25:14] and CPUID.04H.01H:EAX[bits
> 25:14]) to 0. ...

Yeah, it's clearer. Will use your description. Thanks!

> 
> > and this means i-cache and d-cache are shared in the SMT level.
> > This is correct if there's single thread per core, but is wrong for the
> > hyper threading case (one core contains multiple threads) since the
> > i-cache and d-cache are shared in the core level other than SMT level.
> > 
> > For AMD CPU, commit 8f4202fb1080 ("i386: Populate AMD Processor Cache
> > Information for cpuid 0x8000001D") has already introduced i/d cache
> > topology as core level by default.
> > 
> > Therefore, in order to be compatible with both multi-threaded and
> > single-threaded situations, we should set i-cache and d-cache be shared
> > at the core level by default.
> > 
> > This fix changes the default i/d cache topology from per-thread to
> > per-core. Potentially, this change in L1 cache topology may affect the
> > performance of the VM if the user does not specifically specify the
> > topology or bind the vCPU. However, the way to achieve optimal
> > performance should be to create a reasonable topology and set the
> > appropriate vCPU affinity without relying on QEMU's default topology
> > structure.
> > 
> > Fixes: 7e3482f82480 ("i386: Helpers to encode cache information consistently")
> > Suggested-by: Robert Hoo <robert.hu@linux.intel.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

Thanks!

-Zhao

> 
> > ---
> > Changes since v1:
> >   * Split this fix from the patch named "i386/cpu: Fix number of
> >     addressable IDs in CPUID.04H".
> >   * Add the explanation of the impact on performance. (Xiaoyao)
> > ---
> >   target/i386/cpu.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 50613cd04612..b439a05244ee 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -6104,12 +6104,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >               switch (count) {
> >               case 0: /* L1 dcache info */
> >                   encode_cache_cpuid4(env->cache_info_cpuid4.l1d_cache,
> > -                                    1, cs->nr_cores,
> > +                                    cs->nr_threads, cs->nr_cores,
> >                                       eax, ebx, ecx, edx);
> >                   break;
> >               case 1: /* L1 icache info */
> >                   encode_cache_cpuid4(env->cache_info_cpuid4.l1i_cache,
> > -                                    1, cs->nr_cores,
> > +                                    cs->nr_threads, cs->nr_cores,
> >                                       eax, ebx, ecx, edx);
> >                   break;
> >               case 2: /* L2 cache info */
> 

