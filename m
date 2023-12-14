Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD20812A1C
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 09:15:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDgrd-000052-0x; Thu, 14 Dec 2023 03:14:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rDgrZ-0008W7-Hd
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 03:14:34 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rDgrW-00018L-PJ
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 03:14:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702541670; x=1734077670;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=anBGHWHI6zWCgDvVGIFMDDZtXjG7aH3m4+Y4cCCtAdw=;
 b=K8HZmf6HktpuV6gAY9Hl76PhxUgdINrLiK6V1amIyc5F1ChxPXPpiVt9
 X64f4ZgKEOmyTQF9kvOc+MBrm93amKaJPpulqYAWg2wNih+PcNaVZ4DfX
 MQswlmkawH4u9zhsnk2PUqV2gytcGj/0ZXBGqHJLmGg8j2MF/yx4iQCdu
 r9hGBgGa/SZvn0fQQK13VgAq2nUH5beu7k1flWlrrcZTDmDmk+ZQjoRS6
 y/1qtHAsADQgyc694VoBvhFo1LMXf8UXOLBb2H93UHJxtAdiqAtGSE2A6
 aAl5EskTmFSW7w0y6oJlBH6/TDtSXxp2FFXdSWgWVeIN1UbUHvS2ktG5o w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="8482976"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="8482976"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2023 00:14:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; d="scan'208";a="17709052"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.29.154])
 ([10.93.29.154])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2023 00:14:24 -0800
Message-ID: <10b16be0-4db5-4652-a70e-ad96c7b773ca@intel.com>
Date: Thu, 14 Dec 2023 16:14:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] target/i386: add support for
 VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE
Content-Language: en-US
To: Ake Koomsin <ake@igel.co.jp>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230808024000.3985-3-ake@igel.co.jp>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20230808024000.3985-3-ake@igel.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 8/8/2023 10:40 AM, Ake Koomsin wrote:
> Current QEMU can expose waitpkg to guests when it is available. However,
> VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE is still not recognized and
> masked by QEMU. This can lead to an unexpected situation when a L1
> hypervisor wants to expose waitpkg to a L2 guest. The L1 hypervisor can
> assume that VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE exists as waitpkg is
> available. The L1 hypervisor then can accidentally expose waitpkg to the
> L2 guest. This will cause invalid opcode exception in the L2 guest when
> it executes waitpkg related instructions.
> 
> This patch adds VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE support, and
> sets up dependency between the bit and CPUID_7_0_ECX_WAITPKG. QEMU should
> not expose waitpkg feature if VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE is
> not available to avoid unexpected invalid opcode exception in L2 guests.
> 
> Signed-off-by: Ake Koomsin <ake@igel.co.jp>
> ---
> 
> v2:
> - Fix typo in the patch header (targer -> target)
> 
> v1:
> https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg01048.html
> 
>   target/i386/cpu.c | 6 +++++-
>   target/i386/cpu.h | 1 +
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 97ad229d8b..00f913b638 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1228,7 +1228,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>               "vmx-invpcid-exit", "vmx-vmfunc", "vmx-shadow-vmcs", "vmx-encls-exit",
>               "vmx-rdseed-exit", "vmx-pml", NULL, NULL,
>               "vmx-xsaves", NULL, NULL, NULL,
> -            NULL, "vmx-tsc-scaling", NULL, NULL,
> +            NULL, "vmx-tsc-scaling", "vmx-enable-user-wait-pause", NULL,
>               NULL, NULL, NULL, NULL,
>           },
>           .msr = {
> @@ -1545,6 +1545,10 @@ static FeatureDep feature_dependencies[] = {
>           .from = { FEAT_8000_0001_ECX,       CPUID_EXT3_SVM },
>           .to = { FEAT_SVM,                   ~0ull },
>       },
> +    {
> +        .from = { FEAT_VMX_SECONDARY_CTLS,  VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE },
> +        .to = { FEAT_7_0_ECX,               CPUID_7_0_ECX_WAITPKG },
> +    },

Is this what we really want?

It prevents us from exposing WAITPKG to the guest when we don't want to 
expose VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE.

An easy example is that, we want to launch a VM without virtualization 
capability. And this VM cannot have WAITPKG?

>   };
>   
>   typedef struct X86RegisterInfo32 {
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index e0771a1043..a6000e93bd 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1111,6 +1111,7 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
>   #define VMX_SECONDARY_EXEC_ENABLE_PML               0x00020000
>   #define VMX_SECONDARY_EXEC_XSAVES                   0x00100000
>   #define VMX_SECONDARY_EXEC_TSC_SCALING              0x02000000
> +#define VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE   0x04000000
>   
>   #define VMX_PIN_BASED_EXT_INTR_MASK                 0x00000001
>   #define VMX_PIN_BASED_NMI_EXITING                   0x00000008


