Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 624A681C734
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 10:15:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGbbk-0001jA-5w; Fri, 22 Dec 2023 04:14:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rGbbg-0001ik-CK
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 04:14:12 -0500
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rGbbe-0006yX-0x
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 04:14:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703236449; x=1734772449;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1D7KQ6om+191RblVh2tcDXW6qZjNZ5uTw46ob4sfG+M=;
 b=CBULGKmJy8g2dddFlxw6l2G5sIl+ihdbvoH1vfqmlhpumM5muP4ZE7Pj
 i6Jgcho8rbOxhnoRhQ6C22JuxU7GVN3BwlZO7AFzjO/3BcfLz5M8KCEYK
 aLs+wyDnXn4nWcGzpLiO8aPDSikalbIeFMW8b5TRy42FML4N04WmixRq4
 MB+ALXbVc/D+xZYhgk2Y3hF0Ca6c6yKQS63omL2A+5VssR8kbNUgukK0B
 UgOXAev/BCE9kfYNmEV9CyLHYd6hDIBoHHc5Ij3aSpaLjh6wt+CU0v/P9
 tQZwwCBIpNRnT5g0TuL65Nq64gp/DNdjyFoi7t9zum2olHWVVt6C92Apc A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="482276113"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; d="scan'208";a="482276113"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2023 01:13:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; d="scan'208";a="18651217"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 22 Dec 2023 01:13:55 -0800
Date: Fri, 22 Dec 2023 17:26:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xin Li <xin3.li@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, seanjc@google.com, chao.gao@intel.com,
 hpa@zytor.com, xiaoyao.li@intel.com, weijiang.yang@intel.com
Subject: Re: [PATCH v3 2/6] target/i386: mark CR4.FRED not reserved
Message-ID: <ZYVWUHt6EAVN9YMp@intel.com>
References: <20231109072012.8078-1-xin3.li@intel.com>
 <20231109072012.8078-3-xin3.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109072012.8078-3-xin3.li@intel.com>
Received-SPF: pass client-ip=192.55.52.43; envelope-from=zhao1.liu@intel.com;
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

On Wed, Nov 08, 2023 at 11:20:08PM -0800, Xin Li wrote:
> Date: Wed,  8 Nov 2023 23:20:08 -0800
> From: Xin Li <xin3.li@intel.com>
> Subject: [PATCH v3 2/6] target/i386: mark CR4.FRED not reserved
> X-Mailer: git-send-email 2.42.0
> 
> The CR4.FRED bit, i.e., CR4[32], is no longer a reserved bit when FRED
> is exposed to guests, otherwise it is still a reserved bit.
> 
> Tested-by: Shan Kang <shan.kang@intel.com>
> Signed-off-by: Xin Li <xin3.li@intel.com>
> ---

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

>  target/i386/cpu.h | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 5faf00551d..e210957cba 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -262,6 +262,12 @@ typedef enum X86Seg {
>  #define CR4_PKE_MASK   (1U << 22)
>  #define CR4_PKS_MASK   (1U << 24)
>  
> +#ifdef TARGET_X86_64
> +#define CR4_FRED_MASK   (1ULL << 32)
> +#else
> +#define CR4_FRED_MASK   0
> +#endif
> +
>  #define CR4_RESERVED_MASK \
>  (~(target_ulong)(CR4_VME_MASK | CR4_PVI_MASK | CR4_TSD_MASK \
>                  | CR4_DE_MASK | CR4_PSE_MASK | CR4_PAE_MASK \
> @@ -269,7 +275,8 @@ typedef enum X86Seg {
>                  | CR4_OSFXSR_MASK | CR4_OSXMMEXCPT_MASK | CR4_UMIP_MASK \
>                  | CR4_LA57_MASK \
>                  | CR4_FSGSBASE_MASK | CR4_PCIDE_MASK | CR4_OSXSAVE_MASK \
> -                | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | CR4_PKS_MASK))
> +                | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | CR4_PKS_MASK \
> +                | CR4_FRED_MASK))
>  
>  #define DR6_BD          (1 << 13)
>  #define DR6_BS          (1 << 14)
> @@ -2520,6 +2527,9 @@ static inline uint64_t cr4_reserved_bits(CPUX86State *env)
>      if (!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_PKS)) {
>          reserved_bits |= CR4_PKS_MASK;
>      }
> +    if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_FRED)) {
> +        reserved_bits |= CR4_FRED_MASK;
> +    }
>      return reserved_bits;
>  }
>  
> -- 
> 2.42.0
> 
> 

