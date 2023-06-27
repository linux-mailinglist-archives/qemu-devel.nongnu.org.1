Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 881AC73F36C
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 06:34:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE0OE-0003b1-4q; Tue, 27 Jun 2023 00:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qE0No-0003Z4-5p
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 00:32:55 -0400
Received: from mga11.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qE0Nm-0007Np-AD
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 00:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687840370; x=1719376370;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nvSMkMUYRPWtpfBX4q4yiKo0rjOAz8xze8ZXSR/YlL8=;
 b=C+LUEO1oUHyRUwoDKkjPa5o11FhnqIX181dQ+bBHGcqJ1r336UFirvBM
 N71CurAeGNKTzVATzburBdsNeD459x7atlA7sY7ZDOnwDePAMf/6b3GVz
 nDvetkUyTHyKM5MmCA8RfiLfudPVlpvlXFV9HJQXpVZjJcClxTfrtr8m4
 UgS50M7ZWfSACsQ34SagY6sW/doI5xCE8sS7MxVeU+40Kqtg/2n9Qvk21
 dhQvnUV4E8OW7zXheepgB4osuBZhp04hhPwEr4fAUUwokJS0ec6dudjZw
 nPRgnra6g4R6xzmH7o2LpJ0H9h/PWCkbCPclAVJiJi+TSSM2u/4rjl0Ng g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="358970606"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; d="scan'208";a="358970606"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2023 21:32:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="963019081"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; d="scan'208";a="963019081"
Received: from linux.bj.intel.com ([10.238.156.127])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2023 21:32:46 -0700
Date: Tue, 27 Jun 2023 12:31:03 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xiaoyao.li@intel.com,
 lei4.wang@intel.com, qian.wen@intel.com
Subject: Re: [PATCH 3/7] target/i386: Allow MCDT_NO if host supports
Message-ID: <ZJpmB5iHZQ+XfSuc@linux.bj.intel.com>
References: <20230616032311.19137-1-tao1.su@linux.intel.com>
 <20230616032311.19137-4-tao1.su@linux.intel.com>
 <20230626150312.5edefe7b@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626150312.5edefe7b@imammedo.users.ipa.redhat.com>
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

On Mon, Jun 26, 2023 at 03:03:12PM +0200, Igor Mammedov wrote:
> On Fri, 16 Jun 2023 11:23:07 +0800
> Tao Su <tao1.su@linux.intel.com> wrote:
> 
> > MCDT_NO bit indicates HW contains the security fix and doesn't need to
> > be mitigated to avoid data-dependent behaviour for certain instructions.
> > It needs no hypervisor support. Treat it as supported regardless of what
> > KVM reports.
> > 
> > Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> > Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > ---
> >  target/i386/kvm/kvm.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> > index de531842f6..4defd8b479 100644
> > --- a/target/i386/kvm/kvm.c
> > +++ b/target/i386/kvm/kvm.c
> > @@ -432,6 +432,11 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
> >          uint32_t eax;
> >          host_cpuid(7, 1, &eax, &unused, &unused, &unused);
> >          ret |= eax & (CPUID_7_1_EAX_FZRM | CPUID_7_1_EAX_FSRS | CPUID_7_1_EAX_FSRC);
> > +    } else if (function == 7 && index == 2 && reg == R_EDX) {
> 
> > +        /* Not new instructions, just an optimization.  */
> comment doesn't make much sense to me, just drop it or
> describe what MCDT_NO is/mitigates.

Ok, I will drop it in the next version, thanks!

> 
> > +        uint32_t edx;
> > +        host_cpuid(7, 2, &unused, &unused, &unused, &edx);
> > +        ret |= edx & CPUID_7_2_EDX_MCDT_NO;
> >      } else if (function == 0xd && index == 0 &&
> >                 (reg == R_EAX || reg == R_EDX)) {
> >          /*
> 
> 

