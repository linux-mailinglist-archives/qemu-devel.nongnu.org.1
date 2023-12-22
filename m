Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C81581C6B2
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 09:36:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGazz-0000oH-WE; Fri, 22 Dec 2023 03:35:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rGazx-0000o2-K7
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 03:35:13 -0500
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rGazv-0004dj-Ie
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 03:35:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703234111; x=1734770111;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=LoIAA0CvLDyDd2zMRzU7xGB8nmg2Wi0fDASQta4ZIUM=;
 b=H29/5yjjQpaJg5/pyp4nc5Oo63u94Y3xX8XIrbe1PwQ9xmlbOndr/1r9
 atT/laOI5cI9OYJ0C4aPvd4z628RSnx7g9QcF9wsH06zXQLwPgGkpjMyz
 EvsVCXSI301jwam4JGizQjX/x4CBKKXCJDL2dsGQGfAAWSbIWcldaVI4x
 qUnTtwcrh3aimIIEg5TC7jNT+9gQkSnT0SLjv+CzgqEWVzQztn0Nwv9WM
 XlmZPjb8nTsG1xZ6GluK5oAmj1R1gfbu7uSBU5ULBQGpwtc3YyhGOOKcQ
 /M0SzWF0HpkPq8gc4QkmXxTOIxJMoUNZDf3bL8tVmXGoz8c+i0Zhc6sar w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="393255157"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; d="scan'208";a="393255157"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2023 00:35:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="753202490"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; d="scan'208";a="753202490"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga006.jf.intel.com with ESMTP; 22 Dec 2023 00:35:00 -0800
Date: Fri, 22 Dec 2023 16:47:46 +0800
From: "Liu, Zhao1" <zhao1.liu@intel.com>
To: "Li, Xin3" <xin3.li@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>,
 "seanjc@google.com" <seanjc@google.com>,
 "Gao, Chao" <chao.gao@intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
 "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "Yang, Weijiang" <weijiang.yang@intel.com>, "Wu, Dan1" <dan1.wu@intel.com>
Subject: Re: [PATCH v3A 1/6] target/i386: add support for FRED in CPUID
 enumeration
Message-ID: <ZYVNMh4UvogvuRwt@intel.com>
References: <MW4PR11MB6737DC0CCD50B5D3D00521A7A895A@MW4PR11MB6737.namprd11.prod.outlook.com>
 <20231222030336.38096-1-xin3.li@intel.com>
 <ZYU76ipTvj1WIBgm@intel.com> <ZYVFrBvu39X7E1Yf@intel.com>
 <MW4PR11MB6737937A73F2E0D2752F0835A894A@MW4PR11MB6737.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR11MB6737937A73F2E0D2752F0835A894A@MW4PR11MB6737.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=192.55.52.93; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Dec 22, 2023 at 08:24:52AM +0000, Li, Xin3 wrote:
> Date: Fri, 22 Dec 2023 08:24:52 +0000
> From: "Li, Xin3" <xin3.li@intel.com>
> Subject: RE: [PATCH v3A 1/6] target/i386: add support for FRED in CPUID
>  enumeration
> 
> 
> > > >              NULL, NULL, NULL, NULL, @@ -1552,6 +1552,14 @@ static
> > > > FeatureDep feature_dependencies[] = {
> > > >          .from = { FEAT_VMX_SECONDARY_CTLS,
> > VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE },
> > > >          .to = { FEAT_7_0_ECX,               CPUID_7_0_ECX_WAITPKG },
> > > >      },
> > > > +    {
> > > > +        .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_LKGS },
> > > > +        .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_FRED },
> > > > +    },
> > > > +    {
> > > > +        .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_WRMSRNS },
> > > > +        .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_FRED },
> > > > +    },
> > 
> > Oh, sorry, one thing that comes to mind, is this dependency required?
> > Since the FRED spec (v3.0) is all about WRMSR as the example, without
> > mentioning WRMSRNS, could there be other implementations that depend on
> > WRMSR instead of WRMSRNS?
> 
> This is a community ask from tglx:
> https://lkml.kernel.org/kvm/87y1h81ht4.ffs@tglx/
> 
> Boris had the same question:
> https://lore.kernel.org/lkml/20231114050201.GAZVL%2FSd%2FyLIdON9la@fat_crate.local/
> 
> But it needs to go through a formal approach, which takes time, to reach
> the FRED public spec.
> 

Thanks Xin! You can add a simple note in the commit message, such as
FRED's dependency on WRMSRNS will be documented, to avoid confusion
for later reviewers interested in FRED.

Regards,
Zhao


