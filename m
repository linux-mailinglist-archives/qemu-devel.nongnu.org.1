Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6B576FD95
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 11:40:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRrI2-0006V9-VJ; Fri, 04 Aug 2023 05:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qRrHz-0006Sg-Ty
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 05:40:07 -0400
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qRrHy-0001PB-2S
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 05:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691142006; x=1722678006;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=wa3x85XOHEm10QzQr3r9ZtuF8usNYajkzksygZ1KvY4=;
 b=IXVRwbL+5NNCo1+BmRXiSNc0Lz7PS3DLM43egsyM9UEj9ZIiTOtXORl4
 i44IZIsSQMQl1HNuE7F8Q30UXGplk7nuadpeo6QXuFhVwiYfGwKv8ekMB
 Ablg2mA6aUBob1ywjxnZ0DEc651fegPWwLIpQi67vdlTWbEbJkY/fQiT+
 8gVh+62q4PDSdO5C8Thax1ZXiEJlkLcKXBFE219mNF2uwyaawo+9OclC0
 5RwBwPAA9anbgs5d/dbQ7Fb0oCAbg7beJDcDSs+pW+oZq8dlfr5c5pifj
 cViZzolV+g3M3OVQ5SBdIVGO5Q2iXzMExY2QBKV3/kmp92P5cqorY+K9a Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="401072778"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; d="scan'208";a="401072778"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2023 02:40:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="853681994"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; d="scan'208";a="853681994"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by orsmga004.jf.intel.com with ESMTP; 04 Aug 2023 02:39:59 -0700
Date: Fri, 4 Aug 2023 17:50:26 +0800
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
Subject: Re: [PATCH v3 15/17] i386: Fix NumSharingCache for
 CPUID[0x8000001D].EAX[bits 25:14]
Message-ID: <ZMzJ4i1RmJwSLfhm@liuzhao-OptiPlex-7080>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-16-zhao1.liu@linux.intel.com>
 <e05ca4e2-b4a8-99cf-cd4d-cfac71262a74@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e05ca4e2-b4a8-99cf-cd4d-cfac71262a74@amd.com>
Received-SPF: none client-ip=192.55.52.88;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Babu,

On Thu, Aug 03, 2023 at 03:40:20PM -0500, Moger, Babu wrote:
> Date: Thu, 3 Aug 2023 15:40:20 -0500
> From: "Moger, Babu" <babu.moger@amd.com>
> Subject: Re: [PATCH v3 15/17] i386: Fix NumSharingCache for
>  CPUID[0x8000001D].EAX[bits 25:14]
> 
> Hi Zhao,
> 
> On 8/1/23 05:35, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > The commit 8f4202fb1080 ("i386: Populate AMD Processor Cache Information
> > for cpuid 0x8000001D") adds the cache topology for AMD CPU by encoding
> > the number of sharing threads directly.
> > 
> > From AMD's APM, NumSharingCache (CPUID[0x8000001D].EAX[bits 25:14])
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
> > From the description above, the caculation of this feild should be same
> > as CPUID[4].EAX[bits 25:14] for intel cpus. So also use the offsets of
> > APIC ID to calculate this field.
> > 
> > Note: I don't have the AMD hardware available, hope folks can help me
> > to test this, thanks!
> 
> Yes. Decode looks good. You can remove this note in next revision.

Many thanks! :-)

> 
> The subject line "Fix" gives wrong impression. I would change the subject
> to (or something like this).
> 
> i386: Use offsets get NumSharingCache for CPUID[0x8000001D].EAX[bits 25:14]

Okay, will change like this.

> 
> 
> > 
> > [1]: APM, vol.3, appendix.E.4.15 Function 8000_001Dh--Cache Topology
> >      Information
> > 
> > Cc: Babu Moger <babu.moger@amd.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> > Changes since v1:
> >  * Rename "l3_threads" to "num_apic_ids" in
> >    encode_cache_cpuid8000001d(). (Yanan)
> >  * Add the description of the original commit and add Cc.
> > ---
> >  target/i386/cpu.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index c9897c0fe91a..f67b6be10b8d 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -361,7 +361,7 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
> >                                         uint32_t *eax, uint32_t *ebx,
> >                                         uint32_t *ecx, uint32_t *edx)
> >  {
> > -    uint32_t l3_threads;
> > +    uint32_t num_apic_ids;
> 
> I would change it to match spec definition.
> 
>   uint32_t num_sharing_cache;

Okay.

Thanks,
Zhao

> 
> 
> >      assert(cache->size == cache->line_size * cache->associativity *
> >                            cache->partitions * cache->sets);
> >  
> > @@ -370,13 +370,11 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
> >  
> >      /* L3 is shared among multiple cores */
> >      if (cache->level == 3) {
> > -        l3_threads = topo_info->modules_per_die *
> > -                     topo_info->cores_per_module *
> > -                     topo_info->threads_per_core;
> > -        *eax |= (l3_threads - 1) << 14;
> > +        num_apic_ids = 1 << apicid_die_offset(topo_info);
> >      } else {
> > -        *eax |= ((topo_info->threads_per_core - 1) << 14);
> > +        num_apic_ids = 1 << apicid_core_offset(topo_info);
> >      }
> > +    *eax |= (num_apic_ids - 1) << 14;
> >  
> >      assert(cache->line_size > 0);
> >      assert(cache->partitions > 0);
> 
> -- 
> Thanks
> Babu Moger

