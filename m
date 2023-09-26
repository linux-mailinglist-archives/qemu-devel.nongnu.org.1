Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 856287AE3D8
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 04:59:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkyGy-0003TD-7D; Mon, 25 Sep 2023 22:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qkyGu-0003T5-Rm
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 22:58:00 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qkyGs-0003Av-4s
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 22:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695697078; x=1727233078;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=6Vlhpy7x58o2/+dG5U3wB6nifjQsA7018Vk9J5UoX0Y=;
 b=JGGhjw9BMKyAxcGBNnqX3lC9HDNGOhiFL8sdA4k5cbQ/Kwl/hOAG+ihD
 dZONrBbasZk/zgrlKqN4mFOpoyYbbtaGDSPAg8eGE6AfcINyXF1WJKsuc
 y+KSahaiBzTxS7HXGEO+NWplpPP+pc3NW6jtViYLSPrjidN8JonewJ4hj
 T6wF8Gva5cj5bjzNYefI4yjM7fNHMl//B9Srvzw2pcjigT4lzOjZIs5w3
 8b4c8ZJYYPddOWpsDJ+Ola65GeWXymIpTWUKgH1GXe4Q3QFj1P08ho/fX
 nmNe3xd0/tAoDSBxJkkYZCvMYvmKNeu+e3ov5uvm0qVGtPxtpk1ym/OJH A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="366527084"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; d="scan'208";a="366527084"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2023 19:57:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="1079528082"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; d="scan'208";a="1079528082"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga005.fm.intel.com with ESMTP; 25 Sep 2023 19:57:47 -0700
Date: Tue, 26 Sep 2023 11:08:55 +0800
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
Subject: Re: [PATCH v4 20/21] i386: Use CPUCacheInfo.share_level to encode
 CPUID[0x8000001D].EAX[bits 25:14]
Message-ID: <ZRJLR+9hpNCrHND8@liuzhao-OptiPlex-7080>
References: <20230914072159.1177582-1-zhao1.liu@linux.intel.com>
 <20230914072159.1177582-21-zhao1.liu@linux.intel.com>
 <269b02c3-7abb-2fb1-959e-1441d3ecf07f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <269b02c3-7abb-2fb1-959e-1441d3ecf07f@amd.com>
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

On Fri, Sep 22, 2023 at 02:27:58PM -0500, Moger, Babu wrote:
> Date: Fri, 22 Sep 2023 14:27:58 -0500
> From: "Moger, Babu" <bmoger@amd.com>
> Subject: Re: [PATCH v4 20/21] i386: Use CPUCacheInfo.share_level to encode
>  CPUID[0x8000001D].EAX[bits 25:14]
> 
> 
> On 9/14/2023 2:21 AM, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > CPUID[0x8000001D].EAX[bits 25:14] NumSharingCache: number of logical
> > processors sharing cache.
> > 
> > The number of logical processors sharing this cache is
> > NumSharingCache + 1.
> > 
> > After cache models have topology information, we can use
> > CPUCacheInfo.share_level to decide which topology level to be encoded
> > into CPUID[0x8000001D].EAX[bits 25:14].
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> 
> Reviewed-by: Babu Moger <babu.moger@amd.com>

Thanks Babu!

-Zhao

> 
> 
> > ---
> > Changes since v3:
> >   * Explain what "CPUID[0x8000001D].EAX[bits 25:14]" means in the commit
> >     message. (Babu)
> > 
> > Changes since v1:
> >   * Use cache->share_level as the parameter in
> >     max_processor_ids_for_cache().
> > ---
> >   target/i386/cpu.c | 10 +---------
> >   1 file changed, 1 insertion(+), 9 deletions(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index bc28c59df089..3bed823dc3b7 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -482,20 +482,12 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
> >                                          uint32_t *eax, uint32_t *ebx,
> >                                          uint32_t *ecx, uint32_t *edx)
> >   {
> > -    uint32_t num_sharing_cache;
> >       assert(cache->size == cache->line_size * cache->associativity *
> >                             cache->partitions * cache->sets);
> >       *eax = CACHE_TYPE(cache->type) | CACHE_LEVEL(cache->level) |
> >                  (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0);
> > -
> > -    /* L3 is shared among multiple cores */
> > -    if (cache->level == 3) {
> > -        num_sharing_cache = 1 << apicid_die_offset(topo_info);
> > -    } else {
> > -        num_sharing_cache = 1 << apicid_core_offset(topo_info);
> > -    }
> > -    *eax |= (num_sharing_cache - 1) << 14;
> > +    *eax |= max_processor_ids_for_cache(topo_info, cache->share_level) << 14;
> >       assert(cache->line_size > 0);
> >       assert(cache->partitions > 0);

