Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E289F7AE3DB
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 04:59:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkyIO-00048K-F0; Mon, 25 Sep 2023 22:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qkyIL-00044j-Iv
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 22:59:29 -0400
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qkyIJ-0003MH-Rm
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 22:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695697167; x=1727233167;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Rn9ZAVdvw5aAJT0ZRX6eVmguRCBmW4htGGpT1cAptSY=;
 b=DiE13yh2Ip4zhSPkFzybtmlCFrj3e8CJt+jALw442GvSh0/tE9uTRvcY
 hmzQcl4fd21yieS5I/HXvGDGPNOkExXmf3UmrBD+bhkI69UdraerVwFS+
 idQXWS7Is34xv+r1o/PMpSvDR2GaMhJ6pQTzA89JkCzcXYBuPUMGKceCk
 BiYcHt3XTkFg5moBYk9VD2dsxy+lrQ/IlrXK2ZZ2TNTjtYppQ0jKPhtqV
 uEGHEdh20wzmijow2eQG7Rv4T3meTlZuwTOnIys63GpWbht9senFiD0FT
 n/AXT1moSoaTooo+kJLpMA1n20idJs3cQSaVNEaYa57DSF9rEHpx4BOP1 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="384244003"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; d="scan'208";a="384244003"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2023 19:59:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="864241897"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; d="scan'208";a="864241897"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga002.fm.intel.com with ESMTP; 25 Sep 2023 19:59:20 -0700
Date: Tue, 26 Sep 2023 11:10:28 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Babu Moger <babu.moger@amd.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v4 19/21] i386: Use offsets get NumSharingCache for
 CPUID[0x8000001D].EAX[bits 25:14]
Message-ID: <ZRJLpDmI8nBKsleY@liuzhao-OptiPlex-7080>
References: <20230914072159.1177582-1-zhao1.liu@linux.intel.com>
 <20230914072159.1177582-20-zhao1.liu@linux.intel.com>
 <69d49658-07ca-e7e5-df2b-aec75f6652ff@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69d49658-07ca-e7e5-df2b-aec75f6652ff@amd.com>
Received-SPF: none client-ip=134.134.136.24;
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

On Fri, Sep 22, 2023 at 02:27:18PM -0500, Moger, Babu wrote:
> Date: Fri, 22 Sep 2023 14:27:18 -0500
> From: "Moger, Babu" <bmoger@amd.com>
> Subject: Re: [PATCH v4 19/21] i386: Use offsets get NumSharingCache for
>  CPUID[0x8000001D].EAX[bits 25:14]
> 
> 
> On 9/14/2023 2:21 AM, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > The commit 8f4202fb1080 ("i386: Populate AMD Processor Cache Information
> > for cpuid 0x8000001D") adds the cache topology for AMD CPU by encoding
> > the number of sharing threads directly.
> > 
> >  From AMD's APM, NumSharingCache (CPUID[0x8000001D].EAX[bits 25:14])
> > means [1]:
> > 
> > The number of logical processors sharing this cache is the value of
> > this field incremented by 1. To determine which logical processors are
> > sharing a cache, determine a Share Id for each processor as follows:
> > 
> > ShareId = LocalApicId >> log2(NumSharingCache+1)
> > 
> > Logical processors with the same ShareId then share a cache. If
> > NumSharingCache+1 is not a power of two, round it up to the next power
> > of two.
> > 
> >  From the description above, the calculation of this field should be same
> > as CPUID[4].EAX[bits 25:14] for Intel CPUs. So also use the offsets of
> > APIC ID to calculate this field.
> > 
> > [1]: APM, vol.3, appendix.E.4.15 Function 8000_001Dh--Cache Topology
> >       Information
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Babu Moger <babu.moger@amd.com>

Thanks Babu!

-Zhao

> > ---
> > Changes since v3:
> >   * Rewrite the subject. (Babu)
> >   * Delete the original "comment/help" expression, as this behavior is
> >     confirmed for AMD CPUs. (Babu)
> >   * Rename "num_apic_ids" (v3) to "num_sharing_cache" to match spec
> >     definition. (Babu)
> > 
> > Changes since v1:
> >   * Rename "l3_threads" to "num_apic_ids" in
> >     encode_cache_cpuid8000001d(). (Yanan)
> >   * Add the description of the original commit and add Cc.
> > ---
> >   target/i386/cpu.c | 10 ++++------
> >   1 file changed, 4 insertions(+), 6 deletions(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 5d066107d6ce..bc28c59df089 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -482,7 +482,7 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
> >                                          uint32_t *eax, uint32_t *ebx,
> >                                          uint32_t *ecx, uint32_t *edx)
> >   {
> > -    uint32_t l3_threads;
> > +    uint32_t num_sharing_cache;
> >       assert(cache->size == cache->line_size * cache->associativity *
> >                             cache->partitions * cache->sets);
> > @@ -491,13 +491,11 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
> >       /* L3 is shared among multiple cores */
> >       if (cache->level == 3) {
> > -        l3_threads = topo_info->modules_per_die *
> > -                     topo_info->cores_per_module *
> > -                     topo_info->threads_per_core;
> > -        *eax |= (l3_threads - 1) << 14;
> > +        num_sharing_cache = 1 << apicid_die_offset(topo_info);
> >       } else {
> > -        *eax |= ((topo_info->threads_per_core - 1) << 14);
> > +        num_sharing_cache = 1 << apicid_core_offset(topo_info);
> >       }
> > +    *eax |= (num_sharing_cache - 1) << 14;
> >       assert(cache->line_size > 0);
> >       assert(cache->partitions > 0);

