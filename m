Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 852A776FBA6
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 10:06:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRpp1-0007PA-KK; Fri, 04 Aug 2023 04:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qRpoz-0007On-0W
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 04:06:05 -0400
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qRpow-000182-Qm
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 04:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691136362; x=1722672362;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=iEUnJ1iml60Elv9i5H+2/Pwy26DsoqILd9qu41HD4AI=;
 b=I+cSXXOX+2bH1s0ocVRVHcxbopSbigA5iGHzH7AS3XTEnxQBFADrlaaC
 Js23uuaH4w9UyiskoRG5w1z0UB2mz/YNYyv23VAGFBXuLB3+0ISRyvBs2
 JOQVrNqyLNgfsZ9QtLafCsktz9nYRmjETDPlmajsrG7LtxOBSH/GX2Ihp
 eafeg5823tAEByCLWUGBypSJb7tUbDEswGrOpxYJVNnR5YHP9YQ6Y/8/Q
 RQOH5/Yn7P3B50nVaeo+LZBlu5gIYL6hIVLGs0hky6S3SAf7B6p0fz+lk
 J/YqmxktTOB+VjI8jF3fJnZuXXF2lEid7LY5ucLhBMqM/l+lwyaP1jpyz A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="401053008"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; d="scan'208";a="401053008"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2023 01:04:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="799935553"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; d="scan'208";a="799935553"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by fmsmga004.fm.intel.com with ESMTP; 04 Aug 2023 01:04:09 -0700
Date: Fri, 4 Aug 2023 16:14:37 +0800
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
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH v3 02/17] tests: Rename test-x86-cpuid.c to test-x86-topo.c
Message-ID: <ZMyzbcNZqkdHE0AE@liuzhao-OptiPlex-7080>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-3-zhao1.liu@linux.intel.com>
 <cb782016-1daa-1e04-df1d-89171fcc814c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb782016-1daa-1e04-df1d-89171fcc814c@amd.com>
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

On Tue, Aug 01, 2023 at 06:20:46PM -0500, Moger, Babu wrote:
> Date: Tue, 1 Aug 2023 18:20:46 -0500
> From: "Moger, Babu" <babu.moger@amd.com>
> Subject: Re: [PATCH v3 02/17] tests: Rename test-x86-cpuid.c to
>  test-x86-topo.c
> 
> Zhao,
> 
> On 8/1/23 05:35, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > In fact, this unit tests APIC ID other than CPUID.
> 
> This is not clear.
> 
> The tests in test-x86-topo.c actually test the APIC ID combinations.
> Rename to test-x86-topo.c to make its name more in line with its actual
> content.

Thanks, your description is better and clearer!

-Zhao

> 
> > Rename to test-x86-topo.c to make its name more in line with its
> > actual content.
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > Changes since v1:
> >  * Rename test-x86-apicid.c to test-x86-topo.c. (Yanan)
> > ---
> >  MAINTAINERS                                      | 2 +-
> >  tests/unit/meson.build                           | 4 ++--
> >  tests/unit/{test-x86-cpuid.c => test-x86-topo.c} | 2 +-
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> >  rename tests/unit/{test-x86-cpuid.c => test-x86-topo.c} (99%)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 12e59b6b27de..51ba3d593e90 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1719,7 +1719,7 @@ F: include/hw/southbridge/ich9.h
> >  F: include/hw/southbridge/piix.h
> >  F: hw/isa/apm.c
> >  F: include/hw/isa/apm.h
> > -F: tests/unit/test-x86-cpuid.c
> > +F: tests/unit/test-x86-topo.c
> >  F: tests/qtest/test-x86-cpuid-compat.c
> >  
> >  PC Chipset
> > diff --git a/tests/unit/meson.build b/tests/unit/meson.build
> > index 93977cc32d2b..39b5d0007c69 100644
> > --- a/tests/unit/meson.build
> > +++ b/tests/unit/meson.build
> > @@ -21,8 +21,8 @@ tests = {
> >    'test-opts-visitor': [testqapi],
> >    'test-visitor-serialization': [testqapi],
> >    'test-bitmap': [],
> > -  # all code tested by test-x86-cpuid is inside topology.h
> > -  'test-x86-cpuid': [],
> > +  # all code tested by test-x86-topo is inside topology.h
> > +  'test-x86-topo': [],
> >    'test-cutils': [],
> >    'test-div128': [],
> >    'test-shift128': [],
> > diff --git a/tests/unit/test-x86-cpuid.c b/tests/unit/test-x86-topo.c
> > similarity index 99%
> > rename from tests/unit/test-x86-cpuid.c
> > rename to tests/unit/test-x86-topo.c
> > index bfabc0403a1a..2b104f86d7c2 100644
> > --- a/tests/unit/test-x86-cpuid.c
> > +++ b/tests/unit/test-x86-topo.c
> > @@ -1,5 +1,5 @@
> >  /*
> > - *  Test code for x86 CPUID and Topology functions
> > + *  Test code for x86 APIC ID and Topology functions
> >   *
> >   *  Copyright (c) 2012 Red Hat Inc.
> >   *
> 
> -- 
> Thanks
> Babu Moger

