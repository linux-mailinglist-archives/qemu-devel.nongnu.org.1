Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7837682D079
	for <lists+qemu-devel@lfdr.de>; Sun, 14 Jan 2024 13:10:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOzIs-0004qr-AQ; Sun, 14 Jan 2024 07:09:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rOzIp-0004pT-U4
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 07:09:23 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rOzIn-0008AG-JO
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 07:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705234161; x=1736770161;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=0hibwSD1PQ4vDgip1K/Sx6DPnqV9+de/ew2mFMg5AVY=;
 b=MWFEBgJInmKKGpKKpy7wDZKHsSkjTh1cbeEiC+0dvFYGKUjMl2RB5Ifp
 MEEfXmSNbNrKdunHRAHKTWh6q2aHwY2TQzdh+ytzNFB1ICsKt9Zg4bKDQ
 uCHaoeT0kfhavutUfQ377k0ogueDFOG38it0D2EYS0W150UauLDLehkMI
 z7h/sfICKuVaedzGp3CtJ2+bJtkJEWyaKATbHFY4cvUnt0FoAtTTY+blW
 Uptdsa4Z53vofFnQ5EH7jfQsGn/aaQ3nj7nT0aQRVmL1HyT9ZH2YMGETc
 8kL0BcHJw8exzjVJWjlWtcN1pEa+0pFHvr/eHD0CQDszLiI22uc4Rdka6 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="399133647"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; d="scan'208";a="399133647"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 04:09:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="926860982"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; d="scan'208";a="926860982"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.22.149])
 ([10.93.22.149])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 04:09:15 -0800
Message-ID: <cf6d5c3a-384b-41c9-aa5f-04b2dd0e8c6d@intel.com>
Date: Sun, 14 Jan 2024 20:09:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] target/i386: add control bits support for LAM
Content-Language: en-US
To: Binbin Wu <binbin.wu@linux.intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Cc: pbonzini@redhat.com, chao.gao@intel.com, robert.hu@linux.intel.com
References: <20240112060042.19925-1-binbin.wu@linux.intel.com>
 <20240112060042.19925-3-binbin.wu@linux.intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240112060042.19925-3-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.55.52.115; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
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

On 1/12/2024 2:00 PM, Binbin Wu wrote:
> LAM uses CR3[61] and CR3[62] to configure/enable LAM on user pointers.
> LAM uses CR4[28] to configure/enable LAM on supervisor pointers.
> 
> For CR3 LAM bits, no additional handling needed:
> - TCG
>    LAM is not supported for TCG of target-i386.  helper_write_crN() and
>    helper_vmrun() check max physical address bits before calling
>    cpu_x86_update_cr3(), no change needed, i.e. CR3 LAM bits are not allowed
>    to be set in TCG.
> - gdbstub
>    x86_cpu_gdb_write_register() will call cpu_x86_update_cr3() to update cr3.
>    Allow gdb to set the LAM bit(s) to CR3, if vcpu doesn't support LAM,
>    KVM_SET_SREGS will fail as other reserved bits.
> 
> For CR4 LAM bit, its reservation depends on vcpu supporting LAM feature or
> not.
> - TCG
>    LAM is not supported for TCG of target-i386.  helper_write_crN() and
>    helper_vmrun() check CR4 reserved bit before calling cpu_x86_update_cr4(),
>    i.e. CR4 LAM bit is not allowed to be set in TCG.
> - gdbstub
>    x86_cpu_gdb_write_register() will call cpu_x86_update_cr4() to update cr4.
>    Mask out LAM bit on CR4 if vcpu doesn't support LAM.
> - x86_cpu_reset_hold() doesn't need special handling.
> 
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> Tested-by: Xuelian Guo <xuelian.guo@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   target/i386/cpu.h    | 7 ++++++-
>   target/i386/helper.c | 4 ++++
>   2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 18ea755644..598a3fa140 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -261,6 +261,7 @@ typedef enum X86Seg {
>   #define CR4_SMAP_MASK   (1U << 21)
>   #define CR4_PKE_MASK   (1U << 22)
>   #define CR4_PKS_MASK   (1U << 24)
> +#define CR4_LAM_SUP_MASK (1U << 28)
>   
>   #define CR4_RESERVED_MASK \
>   (~(target_ulong)(CR4_VME_MASK | CR4_PVI_MASK | CR4_TSD_MASK \
> @@ -269,7 +270,8 @@ typedef enum X86Seg {
>                   | CR4_OSFXSR_MASK | CR4_OSXMMEXCPT_MASK | CR4_UMIP_MASK \
>                   | CR4_LA57_MASK \
>                   | CR4_FSGSBASE_MASK | CR4_PCIDE_MASK | CR4_OSXSAVE_MASK \
> -                | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | CR4_PKS_MASK))
> +                | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | CR4_PKS_MASK \
> +                | CR4_LAM_SUP_MASK))
>   
>   #define DR6_BD          (1 << 13)
>   #define DR6_BS          (1 << 14)
> @@ -2522,6 +2524,9 @@ static inline uint64_t cr4_reserved_bits(CPUX86State *env)
>       if (!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_PKS)) {
>           reserved_bits |= CR4_PKS_MASK;
>       }
> +    if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_LAM)) {
> +        reserved_bits |= CR4_LAM_SUP_MASK;
> +    }
>       return reserved_bits;
>   }
>   
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index 2070dd0dda..1da7a7d315 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -219,6 +219,10 @@ void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4)
>           new_cr4 &= ~CR4_PKS_MASK;
>       }
>   
> +    if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_LAM)) {
> +        new_cr4 &= ~CR4_LAM_SUP_MASK;
> +    }
> +
>       env->cr[4] = new_cr4;
>       env->hflags = hflags;
>   


