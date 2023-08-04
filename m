Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2B276FDC3
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 11:48:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRrOI-00067y-9m; Fri, 04 Aug 2023 05:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qRrO6-00067g-W1
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 05:46:27 -0400
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qRrO4-0003pU-D4
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 05:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691142384; x=1722678384;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Cy61lAWWKhJaIjukjGekckyc3aGLCXsVGe6ZyYNOitg=;
 b=Kp9Ia21NJ80Goqsa6s9Vgu+fv44UVZFN9pxnTLNe3vaxPDGJtsMZoM16
 0oLRNIZGqfwOAO8AbaRw+5AnsRzo/39gdAHn8y/IUBBsMdvvGi0tdEJKA
 YY1jzAYBcWo3XtR2qtVf37CG3lYBJBsHqxhJbN8hioqWKmXRS6OeeSeav
 hT2IMX2W9umXKCyCamvv3vPHOBsRjdiEMBCRDKv0vSsLi5l1PORaGwr4y
 xPNxqbqadvx1Q+ScSZiZXxheQ6iAOctrO+rS/7HIMvKAXh4pOJcvAxEMI
 xGyZ7xc7pD/ehCIDcPBumzyNFzjfRavC2RKIP6x1XLz7dwDD5sUl2NBtF w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="456488666"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; d="scan'208";a="456488666"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2023 02:46:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="679920994"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; d="scan'208";a="679920994"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by orsmga003.jf.intel.com with ESMTP; 04 Aug 2023 02:46:18 -0700
Date: Fri, 4 Aug 2023 17:56:46 +0800
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
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 16/17] i386: Use CPUCacheInfo.share_level to encode
 CPUID[0x8000001D].EAX[bits 25:14]
Message-ID: <ZMzLXqx3hbUaARAU@liuzhao-OptiPlex-7080>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-17-zhao1.liu@linux.intel.com>
 <1902cfe3-f858-1442-8875-2b6bef83d68d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1902cfe3-f858-1442-8875-2b6bef83d68d@amd.com>
Received-SPF: none client-ip=192.55.52.43;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 03, 2023 at 03:44:13PM -0500, Moger, Babu wrote:
> Date: Thu, 3 Aug 2023 15:44:13 -0500
> From: "Moger, Babu" <babu.moger@amd.com>
> Subject: Re: [PATCH v3 16/17] i386: Use CPUCacheInfo.share_level to encode
>  CPUID[0x8000001D].EAX[bits 25:14]
> 
> Hi Zhao,
>   Please copy the thread to kvm@vger.kernel.org also.  It makes it easier
> to browse.
> 

OK. I'm not sure how to cc, should I forward all mail to KVM for the
current version (v3), or should I cc the kvm mail list for the next
version (v4)?

> 
> On 8/1/23 05:35, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > CPUID[0x8000001D].EAX[bits 25:14] is used to represent the cache
> > topology for amd CPUs.
> Please change this to.
> 
> 
> CPUID[0x8000001D].EAX[bits 25:14] NumSharingCache: number of logical
> processors sharing cache. The number of
> logical processors sharing this cache is NumSharingCache + 1.

OK.

Thanks,
Zhao

> 
> > 
> > After cache models have topology information, we can use
> > CPUCacheInfo.share_level to decide which topology level to be encoded
> > into CPUID[0x8000001D].EAX[bits 25:14].
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> > Changes since v1:
> >  * Use cache->share_level as the parameter in
> >    max_processor_ids_for_cache().
> > ---
> >  target/i386/cpu.c | 10 +---------
> >  1 file changed, 1 insertion(+), 9 deletions(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index f67b6be10b8d..6eee0274ade4 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -361,20 +361,12 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
> >                                         uint32_t *eax, uint32_t *ebx,
> >                                         uint32_t *ecx, uint32_t *edx)
> >  {
> > -    uint32_t num_apic_ids;
> >      assert(cache->size == cache->line_size * cache->associativity *
> >                            cache->partitions * cache->sets);
> >  
> >      *eax = CACHE_TYPE(cache->type) | CACHE_LEVEL(cache->level) |
> >                 (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0);
> > -
> > -    /* L3 is shared among multiple cores */
> > -    if (cache->level == 3) {
> > -        num_apic_ids = 1 << apicid_die_offset(topo_info);
> > -    } else {
> > -        num_apic_ids = 1 << apicid_core_offset(topo_info);
> > -    }
> > -    *eax |= (num_apic_ids - 1) << 14;
> > +    *eax |= max_processor_ids_for_cache(topo_info, cache->share_level) << 14;
> >  
> >      assert(cache->line_size > 0);
> >      assert(cache->partitions > 0);
> 
> -- 
> Thanks
> Babu Moger

