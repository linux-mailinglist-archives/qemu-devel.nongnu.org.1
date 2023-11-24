Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EFC7F76DA
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 15:49:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6XUD-0007Ia-4q; Fri, 24 Nov 2023 09:48:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1r6XUA-0007AH-TP
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 09:48:50 -0500
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1r6XU7-00024V-EC
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 09:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700837327; x=1732373327;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=mJlP42EwFBc16ghLQRRkc5r9YjcPw5oEp6hAtSa1ZHU=;
 b=Fdf2rz6cRw9RtDDWv7FLc7NHY0fpca216jYu6ZHX7wevk7qnRs976jWG
 K+KeYC1avPmKrv9zwdvUILiWGieqUDexeT+WM60Zm4oBDOxPOcBWAz/2f
 lAA6J55b3TEJ7hzZZgrUFGo9wRnw0MnybFscPDTKvOAyNODO6HU52wcBD
 SiGsC+6MT7RP09W/tZINdxfy3cHIRdjgOni3gjWs+VQGTOrLSlk5CgE1X
 8eB20RQfCJfTm1o03gV/CGryMYpGQkk1wNiUJQJGVsfd6cR3KbbduqxiM
 dv69c++OdSocv2Ix0CXOzJ+X089re+7nuGjsMFYRE4AkrIV8uAlTptRl5 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="395249871"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; d="scan'208";a="395249871"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2023 06:48:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="767501974"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; d="scan'208";a="767501974"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga002.jf.intel.com with ESMTP; 24 Nov 2023 06:48:29 -0800
Date: Fri, 24 Nov 2023 23:00:44 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, ewanhai@zhaoxin.com, cobechen@zhaoxin.com
Subject: Re: [PATCH] target/i386/kvm: Refine VMX controls setting for
 backward compatibility
Message-ID: <ZWC6nOF43KUghl6K@intel.com>
References: <20230925071453.14908-1-ewanhai-oc@zhaoxin.com>
 <ZTnbFJrHeKhoUA6F@intel.com>
 <eb9a08b2-a7c4-c45c-edd8-0585037194aa@zhaoxin.com>
 <a75f0b92-4894-bee9-ecbd-78b849702f61@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a75f0b92-4894-bee9-ecbd-78b849702f61@zhaoxin.com>
Received-SPF: pass client-ip=134.134.136.24; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Ewan,

Look good to me. No other comments.

Regards,
Zhao

On Fri, Oct 27, 2023 at 02:08:57AM -0400, Ewan Hai wrote:
> Date: Fri, 27 Oct 2023 02:08:57 -0400
> From: Ewan Hai <ewanhai-oc@zhaoxin.com>
> Subject: Re: [PATCH] target/i386/kvm: Refine VMX controls setting for
>  backward compatibility
> 
> Hi Zhao,
> 
> since I found last email contains non-plain-text content, andkvm@vger.kernel.org
> rejected to receive my mail, so just re-send last mail here, to follow the rule of qemu
> /kvm community.
> 
> On 10/25/23 23:20, Zhao Liu wrote:
> > On Mon, Sep 25, 2023 at 03:14:53AM -0400, EwanHai wrote:
> > > Date: Mon, 25 Sep 2023 03:14:53 -0400
> > > From: EwanHai<ewanhai-oc@zhaoxin.com>
> > > Subject: [PATCH] target/i386/kvm: Refine VMX controls setting for backward
> > >   compatibility
> > > X-Mailer: git-send-email 2.34.1
> > > 
> > > Commit 4a910e1 ("target/i386: do not set unsupported VMX secondary
> > > execution controls") implemented a workaround for hosts that have
> > > specific CPUID features but do not support the corresponding VMX
> > > controls, e.g., hosts support RDSEED but do not support RDSEED-Exiting.
> > > 
> > > In detail, commit 4a910e1 introduced a flag `has_msr_vmx_procbased_clts2`.
> > > If KVM has `MSR_IA32_VMX_PROCBASED_CTLS2` in its msr list, QEMU would
> > > use KVM's settings, avoiding any modifications to this MSR.
> > > 
> > > However, this commit (4a910e1) didn’t account for cases in older Linux
> > s/didn’t/didn't/
> 
> I'll fix it.
> 
> > > kernels(e.g., linux-4.19.90) where `MSR_IA32_VMX_PROCBASED_CTLS2` is
> > For this old kernel, it's better to add the brief lifecycle note (e.g.,
> > lts, EOL) to illustrate the value of considering such compatibility
> > fixes.
> 
> I've checked the linux-stable repo, found that
> MSR_IA32_VMX_PROCBASED_CTLS2 is not included in kvm regular msr list
> until linux-5.3, and in linux-4.19.x(EOL:Dec,2024), there is also no
> MSR_IA32_VMX_PROCBASED_CTLS2 in kvm regular msr list.
> 
> So maybe this is an important compatibility fix for kernel < 5.3.
> 
> > > in `kvm_feature_msrs`—obtained by ioctl(KVM_GET_MSR_FEATURE_INDEX_LIST),
> > s/—obtained/-obtained/
> 
> I'll fix it.
> 
> > > but not in `kvm_msr_list`—obtained by ioctl(KVM_GET_MSR_INDEX_LIST).
> > s/—obtained/-obtained/
> 
> I'll fix it.
> 
> > > As a result,it did not set the `has_msr_vmx_procbased_clts2` flag based
> > > on `kvm_msr_list` alone, even though KVM maintains the value of this MSR.
> > > 
> > > This patch supplements the above logic, ensuring that
> > > `has_msr_vmx_procbased_clts2` is correctly set by checking both MSR
> > > lists, thus maintaining compatibility with older kernels.
> > > 
> > > Signed-off-by: EwanHai<ewanhai-oc@zhaoxin.com>
> > > ---
> > >   target/i386/kvm/kvm.c | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> > > index af101fcdf6..6299284de4 100644
> > > --- a/target/i386/kvm/kvm.c
> > > +++ b/target/i386/kvm/kvm.c
> > > @@ -2343,6 +2343,7 @@ void kvm_arch_do_init_vcpu(X86CPU *cpu)
> > >   static int kvm_get_supported_feature_msrs(KVMState *s)
> > >   {
> > >       int ret = 0;
> > > +    int i;
> > >       if (kvm_feature_msrs != NULL) {
> > >           return 0;
> > > @@ -2377,6 +2378,11 @@ static int kvm_get_supported_feature_msrs(KVMState *s)
> > >           return ret;
> > >       }
> > It's worth adding a comment here to indicate that this is a
> > compatibility fix.
> > 
> > -Zhao
> > 
> > > +    for (i = 0; i < kvm_feature_msrs->nmsrs; i++) {
> > > +        if (kvm_feature_msrs->indices[i] == MSR_IA32_VMX_PROCBASED_CTLS2) {
> > > +            has_msr_vmx_procbased_ctls2 = true;
> > > +        }
> > > +    }
> > >       return 0;
> > >   }
> > > -- 
> > > 2.34.1
> > > 
> Plan to use patch bellow, any more suggestion?
> 
> >  From a3006fcec3615d98ac1eb252a61952d44aa5029b Mon Sep 17 00:00:00 2001
> > From: EwanHai<ewanhai-oc@zhaoxin.com>
> > Date: Mon, 25 Sep 2023 02:11:59 -0400
> > Subject: [PATCH] target/i386/kvm: Refine VMX controls setting for backward
> >   compatibility
> > 
> > Commit 4a910e1 ("target/i386: do not set unsupported VMX secondary
> > execution controls") implemented a workaround for hosts that have
> > specific CPUID features but do not support the corresponding VMX
> > controls, e.g., hosts support RDSEED but do not support RDSEED-Exiting.
> > 
> > In detail, commit 4a910e1 introduced a flag `has_msr_vmx_procbased_clts2`.
> > If KVM has `MSR_IA32_VMX_PROCBASED_CTLS2` in its msr list, QEMU would
> > use KVM's settings, avoiding any modifications to this MSR.
> > 
> > However, this commit (4a910e1) didn't account for cases in older Linux
> > kernels(<5.3) where `MSR_IA32_VMX_PROCBASED_CTLS2` is in
> > `kvm_feature_msrs`-obtained by ioctl(KVM_GET_MSR_FEATURE_INDEX_LIST),
> > but not in `kvm_msr_list`-obtained by ioctl(KVM_GET_MSR_INDEX_LIST).
> > As a result,it did not set the `has_msr_vmx_procbased_clts2` flag based
> > on `kvm_msr_list` alone, even though KVM maintains the value of this MSR.
> > 
> > This patch supplements the above logic, ensuring that
> > `has_msr_vmx_procbased_clts2` is correctly set by checking both MSR
> > lists, thus maintaining compatibility with older kernels.
> > 
> > Signed-off-by: EwanHai<ewanhai-oc@zhaoxin.com>
> > ---
> >   target/i386/kvm/kvm.c | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> > 
> > diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> > index af101fcdf6..3cf95f8579 100644
> > --- a/target/i386/kvm/kvm.c
> > +++ b/target/i386/kvm/kvm.c
> > @@ -2343,6 +2343,7 @@ void kvm_arch_do_init_vcpu(X86CPU *cpu)
> >   static int kvm_get_supported_feature_msrs(KVMState *s)
> >   {
> >       int ret = 0;
> > +    int i;
> > 
> >       if (kvm_feature_msrs != NULL) {
> >           return 0;
> > @@ -2377,6 +2378,19 @@ static int kvm_get_supported_feature_msrs(KVMState *s)
> >           return ret;
> >       }
> > 
> > +    /*
> > +     * Compatibility fix:
> > +     * Older Linux kernels(<5.3) include the MSR_IA32_VMX_PROCBASED_CTLS2
> > +     * only in feature msr list, but not in regular msr list. This lead to
> > +     * an issue in older kernel versions where QEMU, through the regular
> > +     * MSR list check, assumes the kernel doesn't maintain this msr,
> > +     * resulting in incorrect settings by QEMU for this msr.
> > +     */
> > +    for (i = 0; i < kvm_feature_msrs->nmsrs; i++) {
> > +        if (kvm_feature_msrs->indices[i] == MSR_IA32_VMX_PROCBASED_CTLS2) {
> > +            has_msr_vmx_procbased_ctls2 = true;
> > +        }
> > +    }
> >       return 0;
> >   }
> > 
> > -- 
> > 2.34.1
> 
> Best regards.
> 

