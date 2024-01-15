Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F8382D41F
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 07:12:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPGCk-00046a-Ch; Mon, 15 Jan 2024 01:12:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPGCi-00044b-DH
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:12:12 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPGCg-0001tg-OX
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:12:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705299131; x=1736835131;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Icxs9cOG0QTkV29eLd1mD8xTYSicMFjqmusnrrSXIxY=;
 b=net4a1++Lvu57/aQIyy0U5HXU0I/iauGjXneMo3pP4e0ibxTbukbOk7m
 pOxongORFvBNeS6LscTMUGOHSi0e1CcofHDSttRa7/dug7uJSG0sy3Kab
 qg3z/k9OsY9gGW7wBrsOHq448YQMUxM9Rm/kXIC4FAmwwcjDvBv0fiaZA
 Ezf3EiXgbw5EnUSEFDDxhxR7ctSl0a9wheww1I21y30AX7jwt7MvYcf+c
 vxS70iUG7y3XIHooX5mhl9LRDHI6Qjxv9yC/UbmnI9XT6j1wy43PGbUBf
 cI5WNcrHs8QGxpMaOU9MUHodo4lwJYnwIvpG+8j8k4sAsBp6s1EFvyfcm g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="6636319"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="6636319"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 22:12:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="906963749"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; d="scan'208";a="906963749"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga004.jf.intel.com with ESMTP; 14 Jan 2024 22:12:05 -0800
Date: Mon, 15 Jan 2024 14:25:02 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH v7 14/16] i386: Use CPUCacheInfo.share_level to encode
 CPUID[4]
Message-ID: <ZaTPvmU/6gXHNDRo@intel.com>
References: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
 <20240108082727.420817-15-zhao1.liu@linux.intel.com>
 <a0cd67f2-94f2-4c4b-9212-6b7344163660@intel.com>
 <ZaSpQuQxU5UrbIf4@intel.com>
 <5a004819-b9bf-4a2e-b8b3-ed238a66245a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a004819-b9bf-4a2e-b8b3-ed238a66245a@intel.com>
Received-SPF: none client-ip=198.175.65.13;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
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

On Mon, Jan 15, 2024 at 12:25:19PM +0800, Xiaoyao Li wrote:
> Date: Mon, 15 Jan 2024 12:25:19 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH v7 14/16] i386: Use CPUCacheInfo.share_level to encode
>  CPUID[4]
> 
> On 1/15/2024 11:40 AM, Zhao Liu wrote:
> > > > +{
> > > > +    uint32_t num_ids = 0;
> > > > +
> > > > +    switch (share_level) {
> > > > +    case CPU_TOPO_LEVEL_CORE:
> > > > +        num_ids = 1 << apicid_core_offset(topo_info);
> > > > +        break;
> > > > +    case CPU_TOPO_LEVEL_DIE:
> > > > +        num_ids = 1 << apicid_die_offset(topo_info);
> > > > +        break;
> > > > +    case CPU_TOPO_LEVEL_PACKAGE:
> > > > +        num_ids = 1 << apicid_pkg_offset(topo_info);
> > > > +        break;
> > > > +    default:
> > > > +        /*
> > > > +         * Currently there is no use case for SMT and MODULE, so use
> > > > +         * assert directly to facilitate debugging.
> > > > +         */
> > > > +        g_assert_not_reached();
> > > > +    }
> > > > +
> > > > +    return num_ids - 1;
> > > suggest to just return num_ids, and let the caller to do the -1 work.
> > Emm, SDM calls the whole "num_ids - 1" (CPUID.0x4.EAX[bits 14-25]) as
> > "maximum number of addressable IDs for logical processors sharing this
> > cache"...
> > 
> > So if this helper just names "num_ids" as max_lp_ids_share_the_cache,
> > I'm not sure there would be ambiguity here?
> 
> I don't think it will.
> 
> if this function is going to used anywhere else, people will need to keep in
> mind to do +1 stuff to get the actual number.
> 
> leaving the -1 trick to where CPUID value gets encoded. let's make this
> function generic.

This helper is the complete pattern to get addressable IDs, this is to
say, the "- 1" is also the part of this calculation.

Its own meaning is self-consistent and generic enough to meet the common
definitions of AMD and Intel.

Thanks,
Zhao


