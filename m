Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5717D7B2A
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 05:10:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvqkN-0005oP-7A; Wed, 25 Oct 2023 23:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1qvqkL-0005oA-FZ
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 23:09:21 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1qvqkI-0005FH-NN
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 23:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698289758; x=1729825758;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=yWQDhRurLOH/L8IKsfUYl5qFYKHRqCxDZQmP6sNWFTk=;
 b=DmzONRzeMuyNnHksQ9ykEjGqJPBS018tH7vaOhvo1k4wFFxKpbn6ye3s
 Rq2tMdK5+2BV/wLPHpUWOQwGM0SBu8JZAa/eRsq+/c0i/XEMVZzMathqt
 wIGEIPPBUSOiRTl3FOQ+rw4qxTWBLl9owrjt126DjgSsS5V0ABkR60S8t
 Z/jfgsbn6DzrlZcyaoWYeSJ3byyKDdxVF7gJ8jDedDSyknxMdj9fVB0hr
 81jWSNrreorzoZc/01QPGtgapW7dH6dAaJlcImdlhbBRl2g6xudMVnOEy
 Ob3UDBqRy7n67oQbXGck0c2oXdMKrWVPuxbG8ARg3NRMYHtYVUNrU+8x1 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="366797525"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; d="scan'208";a="366797525"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2023 20:09:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="794043153"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; d="scan'208";a="794043153"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga001.jf.intel.com with ESMTP; 25 Oct 2023 20:09:12 -0700
Date: Thu, 26 Oct 2023 11:20:52 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: EwanHai <ewanhai-oc@zhaoxin.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] target/i386/kvm: Refine VMX controls setting for
 backward compatibility
Message-ID: <ZTnbFJrHeKhoUA6F@intel.com>
References: <20230925071453.14908-1-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230925071453.14908-1-ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=192.55.52.136; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 25, 2023 at 03:14:53AM -0400, EwanHai wrote:
> Date: Mon, 25 Sep 2023 03:14:53 -0400
> From: EwanHai <ewanhai-oc@zhaoxin.com>
> Subject: [PATCH] target/i386/kvm: Refine VMX controls setting for backward
>  compatibility
> X-Mailer: git-send-email 2.34.1
> 
> Commit 4a910e1 ("target/i386: do not set unsupported VMX secondary
> execution controls") implemented a workaround for hosts that have
> specific CPUID features but do not support the corresponding VMX
> controls, e.g., hosts support RDSEED but do not support RDSEED-Exiting.
> 
> In detail, commit 4a910e1 introduced a flag `has_msr_vmx_procbased_clts2`.
> If KVM has `MSR_IA32_VMX_PROCBASED_CTLS2` in its msr list, QEMU would
> use KVM's settings, avoiding any modifications to this MSR.
> 
> However, this commit (4a910e1) didn’t account for cases in older Linux

s/didn’t/didn't/

> kernels(e.g., linux-4.19.90) where `MSR_IA32_VMX_PROCBASED_CTLS2` is

For this old kernel, it's better to add the brief lifecycle note (e.g.,
lts, EOL) to illustrate the value of considering such compatibility
fixes.

> in `kvm_feature_msrs`—obtained by ioctl(KVM_GET_MSR_FEATURE_INDEX_LIST),

s/—obtained/-obtained/

> but not in `kvm_msr_list`—obtained by ioctl(KVM_GET_MSR_INDEX_LIST).

s/—obtained/-obtained/

> As a result,it did not set the `has_msr_vmx_procbased_clts2` flag based
> on `kvm_msr_list` alone, even though KVM maintains the value of this MSR.
> 
> This patch supplements the above logic, ensuring that
> `has_msr_vmx_procbased_clts2` is correctly set by checking both MSR
> lists, thus maintaining compatibility with older kernels.
> 
> Signed-off-by: EwanHai <ewanhai-oc@zhaoxin.com>
> ---
>  target/i386/kvm/kvm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index af101fcdf6..6299284de4 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -2343,6 +2343,7 @@ void kvm_arch_do_init_vcpu(X86CPU *cpu)
>  static int kvm_get_supported_feature_msrs(KVMState *s)
>  {
>      int ret = 0;
> +    int i;
>  
>      if (kvm_feature_msrs != NULL) {
>          return 0;
> @@ -2377,6 +2378,11 @@ static int kvm_get_supported_feature_msrs(KVMState *s)
>          return ret;
>      }

It's worth adding a comment here to indicate that this is a
compatibility fix.

-Zhao

>  
> +    for (i = 0; i < kvm_feature_msrs->nmsrs; i++) {
> +        if (kvm_feature_msrs->indices[i] == MSR_IA32_VMX_PROCBASED_CTLS2) {
> +            has_msr_vmx_procbased_ctls2 = true;
> +        }
> +    }
>      return 0;
>  }
>  
> -- 
> 2.34.1
> 

