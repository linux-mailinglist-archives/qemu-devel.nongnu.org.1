Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D73881C62E
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 09:05:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGaWG-0002XV-UE; Fri, 22 Dec 2023 03:04:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rGaWC-0002WA-VZ
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 03:04:28 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rGaW8-0007z2-6x
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 03:04:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703232265; x=1734768265;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=NpdxjEsMM5AmDky+ElBNKQV1ir7MOmgrckZm9PloNfg=;
 b=kxoJXQ5YStr5SnGo+O9b6r92LocgCx/J8k3IyYzpUp6I4bIJAe6AQ0gS
 PMOlnBqpebEZZriNNgyJm5L3NyGfLw1+QymCd6kOpmExpWqvG/PxVSYTs
 xaPzu9hI+pFq0iUEx5wQlqEKsvnjJlPTq45br4gpDGCuEqqNtkSxcig4D
 xzaWANVkVvgDBwS3qP1ROE1hpYb3QNA9t7TeD+xtWFKCQZ00juXx3eWbZ
 P+33P//t881RHvb3YLSwOoY/Q1o1nVmnaoL0ivPq57+SjjjCBd78ZACMi
 vxVsmgOEChub5W5vdoYoZ8pQ5kBL5TUF7Yc8vKl7AHEdBLbxdmJ+BYI2g w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="2917818"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="2917818"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2023 00:02:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="900352873"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; d="scan'208";a="900352873"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga004.jf.intel.com with ESMTP; 22 Dec 2023 00:02:54 -0800
Date: Fri, 22 Dec 2023 16:15:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xin Li <xin3.li@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, seanjc@google.com, chao.gao@intel.com,
 hpa@zytor.com, xiaoyao.li@intel.com, weijiang.yang@intel.com,
 dan1.wu@intel.com
Subject: Re: [PATCH v3A 1/6] target/i386: add support for FRED in CPUID
 enumeration
Message-ID: <ZYVFrBvu39X7E1Yf@intel.com>
References: <MW4PR11MB6737DC0CCD50B5D3D00521A7A895A@MW4PR11MB6737.namprd11.prod.outlook.com>
 <20231222030336.38096-1-xin3.li@intel.com>
 <ZYU76ipTvj1WIBgm@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYU76ipTvj1WIBgm@intel.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Dec 22, 2023 at 03:34:02PM +0800, Zhao Liu wrote:
> Date: Fri, 22 Dec 2023 15:34:02 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: Re: [PATCH v3A 1/6] target/i386: add support for FRED in CPUID
>  enumeration
> 
> On Thu, Dec 21, 2023 at 07:03:36PM -0800, Xin Li wrote:
> > Date: Thu, 21 Dec 2023 19:03:36 -0800
> > From: Xin Li <xin3.li@intel.com>
> > Subject: [PATCH v3A 1/6] target/i386: add support for FRED in CPUID
> >  enumeration
> > X-Mailer: git-send-email 2.43.0
> > 
> > FRED, i.e., the Intel flexible return and event delivery architecture,
> > defines simple new transitions that change privilege level (ring
> > transitions).
> > 
> > The new transitions defined by the FRED architecture are FRED event
> > delivery and, for returning from events, two FRED return instructions.
> > FRED event delivery can effect a transition from ring 3 to ring 0, but
> > it is used also to deliver events incident to ring 0.  One FRED
> > instruction (ERETU) effects a return from ring 0 to ring 3, while the
> > other (ERETS) returns while remaining in ring 0.  Collectively, FRED
> > event delivery and the FRED return instructions are FRED transitions.
> > 
> > In addition to these transitions, the FRED architecture defines a new
> > instruction (LKGS) for managing the state of the GS segment register.
> > The LKGS instruction can be used by 64-bit operating systems that do
> > not use the new FRED transitions.
> > 
> > WRMSRNS is an instruction that behaves exactly like WRMSR, with the
> > only difference being that it is not a serializing instruction by
> > default.  Under certain conditions, WRMSRNS may replace WRMSR to improve
> > performance.  FRED uses it to switch RSP0 in a faster manner.
> > 
> > Search for the latest FRED spec in most search engines with this search
> > pattern:
> > 
> >   site:intel.com FRED (flexible return and event delivery) specification
> > 
> > The CPUID feature flag CPUID.(EAX=7,ECX=1):EAX[17] enumerates FRED, and
> > the CPUID feature flag CPUID.(EAX=7,ECX=1):EAX[18] enumerates LKGS, and
> > the CPUID feature flag CPUID.(EAX=7,ECX=1):EAX[19] enumerates WRMSRNS.
> > 
> > Add CPUID definitions for FRED/LKGS/WRMSRNS, and expose them to KVM guests.
> > 
> > Because FRED relies on LKGS and WRMSRNS, add that to feature dependency
> > map.
> > 
> > Tested-by: Shan Kang <shan.kang@intel.com>
> > Signed-off-by: Xin Li <xin3.li@intel.com>
> > ---
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 
> > 
> > Changelog
> > v3A:
> > - Fix reversed dependency (Wu Dan1).
> > ---
> >  target/i386/cpu.c | 10 +++++++++-
> >  target/i386/cpu.h |  6 ++++++
> >  2 files changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 358d9c0a65..66551c7eae 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -965,7 +965,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
> >              "avx-vnni", "avx512-bf16", NULL, "cmpccxadd",
> >              NULL, NULL, "fzrm", "fsrs",
> >              "fsrc", NULL, NULL, NULL,
> > -            NULL, NULL, NULL, NULL,
> > +            NULL, "fred", "lkgs", "wrmsrns",
> >              NULL, "amx-fp16", NULL, "avx-ifma",
> >              NULL, NULL, NULL, NULL,
> >              NULL, NULL, NULL, NULL,
> > @@ -1552,6 +1552,14 @@ static FeatureDep feature_dependencies[] = {
> >          .from = { FEAT_VMX_SECONDARY_CTLS,  VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE },
> >          .to = { FEAT_7_0_ECX,               CPUID_7_0_ECX_WAITPKG },
> >      },
> > +    {
> > +        .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_LKGS },
> > +        .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_FRED },
> > +    },
> > +    {
> > +        .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_WRMSRNS },
> > +        .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_FRED },
> > +    },

Oh, sorry, one thing that comes to mind, is this dependency required?
Since the FRED spec (v3.0) is all about WRMSR as the example, without
mentioning WRMSRNS, could there be other implementations that depend on
WRMSR instead of WRMSRNS?

The dependencies of LKGS are clearly defined in spec.

-Zhao

> >  };
> >  
> >  typedef struct X86RegisterInfo32 {
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index cd2e295bd6..5faf00551d 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -934,6 +934,12 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
> >  #define CPUID_7_1_EDX_AMX_COMPLEX       (1U << 8)
> >  /* PREFETCHIT0/1 Instructions */
> >  #define CPUID_7_1_EDX_PREFETCHITI       (1U << 14)
> > +/* Flexible return and event delivery (FRED) */
> > +#define CPUID_7_1_EAX_FRED              (1U << 17)
> > +/* Load into IA32_KERNEL_GS_BASE (LKGS) */
> > +#define CPUID_7_1_EAX_LKGS              (1U << 18)
> > +/* Non-Serializing Write to Model Specific Register (WRMSRNS) */
> > +#define CPUID_7_1_EAX_WRMSRNS           (1U << 19)
> >  
> >  /* Do not exhibit MXCSR Configuration Dependent Timing (MCDT) behavior */
> >  #define CPUID_7_2_EDX_MCDT_NO           (1U << 5)
> > -- 
> > 2.43.0
> > 
> > 
> 

