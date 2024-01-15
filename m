Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCD082DB87
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 15:43:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPOB0-0005Ff-DE; Mon, 15 Jan 2024 09:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPOAt-0005Ex-1k
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 09:42:51 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPOAr-00056N-3P
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 09:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705329769; x=1736865769;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=KeytAfpjTvYio2gds7krRqPVXqHJi+pnUY06Djw7X0c=;
 b=Cxujro1nGhMv/MNXM24DSGdAQtpTk974jzOn4JTfwtnLq69ieMZkltyr
 4cJQ6r4Ai8m1n6b/KoDySahPhdnDJ0/YgQSdLnU4tz1vwWloRuwzluvM9
 8+IMX1SstWR+RGFYscK3dL3hAOFN4BJ0GuPD5hhJztEljMs2kBicexT6G
 TvosGq3xnbDEYd8DQIz2PZzarnFstwlz0zyKVc3Z7nvNi1qT+0ZqY3Y6S
 qD41N68RCLnreWggO4lKzC+d6d7+eklyBnNPMfnjk48ZLlie3kf1SDC/z
 Zscb/JBN5L22Icy5M6KQecgp0kqo4JR4GOpZvmj76atVUDaLMPUR41FgS w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="12984192"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="12984192"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 06:42:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="1030663434"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="1030663434"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga006.fm.intel.com with ESMTP; 15 Jan 2024 06:42:43 -0800
Date: Mon, 15 Jan 2024 22:55:41 +0800
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
Message-ID: <ZaVHbUo2rJgV3jtA@intel.com>
References: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
 <20240108082727.420817-15-zhao1.liu@linux.intel.com>
 <a0cd67f2-94f2-4c4b-9212-6b7344163660@intel.com>
 <ZaSpQuQxU5UrbIf4@intel.com>
 <5a004819-b9bf-4a2e-b8b3-ed238a66245a@intel.com>
 <ZaTPvmU/6gXHNDRo@intel.com>
 <4094e712-65b9-4b47-9c3f-67970ff8a86c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4094e712-65b9-4b47-9c3f-67970ff8a86c@intel.com>
Received-SPF: none client-ip=198.175.65.10;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
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

On Mon, Jan 15, 2024 at 03:00:25PM +0800, Xiaoyao Li wrote:
> Date: Mon, 15 Jan 2024 15:00:25 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH v7 14/16] i386: Use CPUCacheInfo.share_level to encode
>  CPUID[4]
> 
> On 1/15/2024 2:25 PM, Zhao Liu wrote:
> > Hi Xiaoyao,
> > 
> > On Mon, Jan 15, 2024 at 12:25:19PM +0800, Xiaoyao Li wrote:
> > > Date: Mon, 15 Jan 2024 12:25:19 +0800
> > > From: Xiaoyao Li <xiaoyao.li@intel.com>
> > > Subject: Re: [PATCH v7 14/16] i386: Use CPUCacheInfo.share_level to encode
> > >   CPUID[4]
> > > 
> > > On 1/15/2024 11:40 AM, Zhao Liu wrote:
> > > > > > +{
> > > > > > +    uint32_t num_ids = 0;
> > > > > > +
> > > > > > +    switch (share_level) {
> > > > > > +    case CPU_TOPO_LEVEL_CORE:
> > > > > > +        num_ids = 1 << apicid_core_offset(topo_info);
> > > > > > +        break;
> > > > > > +    case CPU_TOPO_LEVEL_DIE:
> > > > > > +        num_ids = 1 << apicid_die_offset(topo_info);
> > > > > > +        break;
> > > > > > +    case CPU_TOPO_LEVEL_PACKAGE:
> > > > > > +        num_ids = 1 << apicid_pkg_offset(topo_info);
> > > > > > +        break;
> > > > > > +    default:
> > > > > > +        /*
> > > > > > +         * Currently there is no use case for SMT and MODULE, so use
> > > > > > +         * assert directly to facilitate debugging.
> > > > > > +         */
> > > > > > +        g_assert_not_reached();
> > > > > > +    }
> > > > > > +
> > > > > > +    return num_ids - 1;
> > > > > suggest to just return num_ids, and let the caller to do the -1 work.
> > > > Emm, SDM calls the whole "num_ids - 1" (CPUID.0x4.EAX[bits 14-25]) as
> > > > "maximum number of addressable IDs for logical processors sharing this
> > > > cache"...
> > > > 
> > > > So if this helper just names "num_ids" as max_lp_ids_share_the_cache,
> > > > I'm not sure there would be ambiguity here?
> > > 
> > > I don't think it will.
> > > 
> > > if this function is going to used anywhere else, people will need to keep in
> > > mind to do +1 stuff to get the actual number.
> > > 
> > > leaving the -1 trick to where CPUID value gets encoded. let's make this
> > > function generic.
> > 
> > This helper is the complete pattern to get addressable IDs, this is to
> > say, the "- 1" is also the part of this calculation.
> > 
> > Its own meaning is self-consistent and generic enough to meet the common
> > definitions of AMD and Intel.
> 
> OK. I stop bikeshedding on it.
>

Thanks for your review ;-).

Regards,
Zhao


