Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E04B2C138DF
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Oct 2025 09:34:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDf9D-0006kh-63; Tue, 28 Oct 2025 04:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDf8w-0006iq-OG
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:33:30 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDf8t-0004d8-BR
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761640403; x=1793176403;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=JtwjiXeZbF82FprgRA+z7v+PU021hA/Ygg03TKh5C+Y=;
 b=GwifzV7RFCzzfFgxKk30vhlei1J6VtQltD+nT8pcf2QTFbZTTO8hV72Z
 B+PPzLNqQlKyQPA56qzp+1VgU2ZogljNTDLPGf7dzkBu/+B7TIJIjfEzz
 5wN3IBxdzcNt8Yf7Mm33aMTwKT43yS3g52SvEz/+QeX8FlBp+5UqRZVB1
 hC9ZRSYN2HTD38Yphy8H9ycPlh87c6k7zbqG8SKVoXDS8xH0N86Ukv9fA
 Cjw0ow1Hq17BMDP5G133ENqYLf7MguYeAIODIMMhqvFaC4AwuVGNulrJq
 2WHgTy8AhUMzmgzM8tQvZynbl9SCqwMEX+UkpQ1uA1JATKKdIv6XZ32Z6 g==;
X-CSE-ConnectionGUID: VF/tK7+fSma603G55AQWQQ==
X-CSE-MsgGUID: 66y1JUCdSLOgjIqi0ydaPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="75180577"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="75180577"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 01:33:19 -0700
X-CSE-ConnectionGUID: Elr61Lh9TGmH8IkK9ySpEw==
X-CSE-MsgGUID: jzO8APFNRqGG/OFA5FwHdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="189341692"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 01:33:15 -0700
Message-ID: <534db36d-d440-409a-8a80-ee0fe9df12b4@intel.com>
Date: Tue, 28 Oct 2025 16:33:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/20] i386/cpu: Advertise CET related flags in feature
 words
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao
 <chao.gao@intel.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Yang Weijiang <weijiang.yang@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-18-zhao1.liu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251024065632.1448606-18-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.574, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/24/2025 2:56 PM, Zhao Liu wrote:
> From: Yang Weijiang <weijiang.yang@intel.com>
> 
> Add SHSTK and IBT flags in feature words with entry/exit
> control flags.
> 
> CET SHSTK and IBT feature are enumerated via CPUID(EAX=7,ECX=0)
> ECX[bit 7] and EDX[bit 20]. CET states load/restore at vmentry/
> vmexit are controlled by VMX_ENTRY_CTLS[bit 20] and VMX_EXIT_CTLS[bit 28].
> Enable these flags so that KVM can enumerate the features properly.
> 
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> Co-developed-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
> Changes Since v2:
>   - Rename "shstk"/"ibt" to "cet-ss"/"cet-ibt" to match feature names
>     in SDM & APM.
>   - Rename "vmx-exit-save-cet-ctl"/"vmx-entry-load-cet-ctl" to
>     "vmx-exit-save-cet"/"vmx-entry-load-cet".
>   - Define the feature mask macro for easier double check.
> ---
>   target/i386/cpu.c | 8 ++++----
>   target/i386/cpu.h | 2 ++
>   2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index c08066a338a3..9a1001c47891 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1221,7 +1221,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>           .type = CPUID_FEATURE_WORD,
>           .feat_names = {
>               NULL, "avx512vbmi", "umip", "pku",
> -            NULL /* ospke */, "waitpkg", "avx512vbmi2", NULL,
> +            NULL /* ospke */, "waitpkg", "avx512vbmi2", "cet-ss",
>               "gfni", "vaes", "vpclmulqdq", "avx512vnni",
>               "avx512bitalg", NULL, "avx512-vpopcntdq", NULL,
>               "la57", NULL, NULL, NULL,
> @@ -1244,7 +1244,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>               "avx512-vp2intersect", NULL, "md-clear", NULL,
>               NULL, NULL, "serialize", NULL,
>               "tsx-ldtrk", NULL, NULL /* pconfig */, "arch-lbr",
> -            NULL, NULL, "amx-bf16", "avx512-fp16",
> +            "cet-ibt", NULL, "amx-bf16", "avx512-fp16",
>               "amx-tile", "amx-int8", "spec-ctrl", "stibp",
>               "flush-l1d", "arch-capabilities", "core-capability", "ssbd",
>           },
> @@ -1666,7 +1666,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>               "vmx-exit-save-efer", "vmx-exit-load-efer",
>                   "vmx-exit-save-preemption-timer", "vmx-exit-clear-bndcfgs",
>               NULL, "vmx-exit-clear-rtit-ctl", NULL, NULL,
> -            NULL, "vmx-exit-load-pkrs", NULL, "vmx-exit-secondary-ctls",
> +            "vmx-exit-save-cet", "vmx-exit-load-pkrs", NULL, "vmx-exit-secondary-ctls",
>           },
>           .msr = {
>               .index = MSR_IA32_VMX_TRUE_EXIT_CTLS,
> @@ -1681,7 +1681,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>               NULL, "vmx-entry-ia32e-mode", NULL, NULL,
>               NULL, "vmx-entry-load-perf-global-ctrl", "vmx-entry-load-pat", "vmx-entry-load-efer",
>               "vmx-entry-load-bndcfgs", NULL, "vmx-entry-load-rtit-ctl", NULL,
> -            NULL, NULL, "vmx-entry-load-pkrs", "vmx-entry-load-fred",
> +            "vmx-entry-load-cet", NULL, "vmx-entry-load-pkrs", "vmx-entry-load-fred",
>               NULL, NULL, NULL, NULL,
>               NULL, NULL, NULL, NULL,
>           },
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index ad4287822831..fa3e5d87fe50 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1369,6 +1369,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>   #define VMX_VM_EXIT_CLEAR_BNDCFGS                   0x00800000
>   #define VMX_VM_EXIT_PT_CONCEAL_PIP                  0x01000000
>   #define VMX_VM_EXIT_CLEAR_IA32_RTIT_CTL             0x02000000
> +#define VMX_VM_EXIT_SAVE_CET                        0x10000000
>   #define VMX_VM_EXIT_LOAD_IA32_PKRS                  0x20000000
>   #define VMX_VM_EXIT_ACTIVATE_SECONDARY_CONTROLS     0x80000000
>   
> @@ -1382,6 +1383,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>   #define VMX_VM_ENTRY_LOAD_BNDCFGS                   0x00010000
>   #define VMX_VM_ENTRY_PT_CONCEAL_PIP                 0x00020000
>   #define VMX_VM_ENTRY_LOAD_IA32_RTIT_CTL             0x00040000
> +#define VMX_VM_ENTRY_LOAD_CET                       0x00100000
>   #define VMX_VM_ENTRY_LOAD_IA32_PKRS                 0x00400000
>   
>   /* Supported Hyper-V Enlightenments */


