Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AD173F367
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 06:30:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE0KN-0002XC-2j; Tue, 27 Jun 2023 00:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qE0KI-0002Wm-QA
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 00:29:14 -0400
Received: from mga11.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qE0KG-0006YH-Kx
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 00:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687840152; x=1719376152;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1xxAI78+kvfipU16nfnafHfLLbRV4S+gqXTbiOXyGmw=;
 b=N31pjeGxn85Tv/6qo+MaqTuHmtVhiiDonHto9N/d2FcXLt+c+K5G/+tK
 5QLYtDE0ujErubhUG4Qa/4Y7SoDsolUgl1T3LrYroFK6hzyjVfYhbhB3W
 wHLFlt51QbTB+kXrKiTMl4r2uf85AiFUtP+oyYkl6epa6uBxsopYZsck7
 n9g14O4t7NWcn2pQbuq3l8vu21gpgQwzU0C1JKCoyedsACC0twH64wPqI
 tXjfyKJ9lGjtbGfKMv73dKSlIlwOnc16SafaLHoCibD1nHQc7ZKJ/Ja/+
 HqJBNd7dxcs+JBGfqfvriDjym5ZYsajoOG/3xPIwcJJ2pWi6SHprg7/pk w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="358970257"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; d="scan'208";a="358970257"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2023 21:29:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="746067009"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; d="scan'208";a="746067009"
Received: from linux.bj.intel.com ([10.238.156.127])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2023 21:29:04 -0700
Date: Tue, 27 Jun 2023 12:27:19 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xiaoyao.li@intel.com,
 lei4.wang@intel.com, qian.wen@intel.com
Subject: Re: [PATCH 1/7] target/i386: Add FEAT_7_1_EDX to adjust feature level
Message-ID: <ZJplJ+feTMppRWt3@linux.bj.intel.com>
References: <20230616032311.19137-1-tao1.su@linux.intel.com>
 <20230616032311.19137-2-tao1.su@linux.intel.com>
 <20230626143915.34d5712b@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626143915.34d5712b@imammedo.users.ipa.redhat.com>
Received-SPF: none client-ip=192.55.52.93;
 envelope-from=tao1.su@linux.intel.com; helo=mga11.intel.com
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

On Mon, Jun 26, 2023 at 02:39:15PM +0200, Igor Mammedov wrote:
> On Fri, 16 Jun 2023 11:23:05 +0800
> Tao Su <tao1.su@linux.intel.com> wrote:
> 
> > Considering the case of FEAT_7_1_EAX being 0 and FEAT_7_1_EDX being
> > non-zero,
> Can you clarify when/why that happens?

When start a VM on GraniteRapids using '-cpu host', we can see two leafs CPUID_7_0
and CPUID_7_1 in VM, because both CPUID_7_1_EAX and CPUID_7_1_EDX have non-zero value:
0x00000007 0x01: eax=0x00201c30 edx=0x00004000

But if we minus all FEAT_7_1_EAX features using
'-cpu host,-avx-vnni,-avx512-bf16,-fzrm,-fsrs,-fsrc,-amx-fp16', we can't get CPUID_7_1
leaf even though CPUID_7_1_EDX has non-zero value, so it is necessary to update
cpuid_level_func7 by CPUID_7_1_EDX.

Thanks,
Tao

> 
> > guest may report wrong maximum number sub-leaves in leaf
> > 07H. So add FEAT_7_1_EDX to adjust feature level.
> > 
> > Fixes: eaaa197d5b11 ("target/i386: Add support for AVX-VNNI-INT8 in CPUID
> > enumeration")
> > 
> > Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> > Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > ---
> >  target/i386/cpu.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 1242bd541a..e8a70c35d2 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -6778,6 +6778,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
> >          x86_cpu_adjust_feat_level(cpu, FEAT_6_EAX);
> >          x86_cpu_adjust_feat_level(cpu, FEAT_7_0_ECX);
> >          x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EAX);
> > +        x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EDX);
> >          x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_EDX);
> >          x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_ECX);
> >          x86_cpu_adjust_feat_level(cpu, FEAT_8000_0007_EDX);
> 
> 

