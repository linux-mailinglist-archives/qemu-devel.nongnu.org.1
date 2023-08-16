Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5272477DC85
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 10:38:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWC2W-0000EH-F1; Wed, 16 Aug 2023 04:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qian.wen@intel.com>)
 id 1qWC2T-0000Dy-U5
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 04:38:01 -0400
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qian.wen@intel.com>)
 id 1qWC2P-00071s-Sp
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 04:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692175077; x=1723711077;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=l/sHSq2bkyzEGG3sTM7DJxDgtjrbIBayTBA1pI6caL8=;
 b=AEghtsRuDKzgvLzEcb5k9TeRNQhINSc2CsdsFmtndprau6Z03lrPsby/
 4X5qBrAEmnfKE6NM3ROsTjbDeLcwtnbptCJSWYSXIDpNYmMpWOKBMoYVZ
 uTEAOAEMfjd0UyqEjZ2vOmhrPxSaqEXdJ/v7WJpUkn4bbf//xkKOLBFmp
 cN4Y38fSXM/mJPNm2PMt3FpnR+/3B+d+V7ADc2Wz/W4HbWrDt5bZR17d1
 XSrm1YyUs82Rd1TfRLW72HBbY+DFGF/DSEo5/QjfC97DHgEPqMsZUVbcs
 WTwBJitpsv8zwdmh8WZgZZNvJs18kch+3FCGY46HJwVaKy5sLXoW/mvTR A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="458829128"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; d="scan'208";a="458829128"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2023 01:37:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="737214655"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; d="scan'208";a="737214655"
Received: from qianwen-mobl1.ccr.corp.intel.com (HELO [10.238.5.29])
 ([10.238.5.29])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2023 01:37:53 -0700
Message-ID: <ef89b2a2-86c3-2c74-0d36-c35f75d6c4b4@intel.com>
Date: Wed, 16 Aug 2023 16:37:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] target/i386: Fix reporting of CPU dies when
 nr_cores=nr_threads=1
Content-Language: en-US
To: =?UTF-8?B?5bCP5aSq?= <nospam@kota.moe>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, babu.moger@amd.com
References: <20230723185909.441455-1-nospam@kota.moe>
From: "Wen, Qian" <qian.wen@intel.com>
In-Reply-To: <20230723185909.441455-1-nospam@kota.moe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.43; envelope-from=qian.wen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.04,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.045, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 7/24/2023 2:59 AM, 小太 wrote:
> When QEMU is started with `-smp D,sockets=1,dies=D,cores=1,threads=1` (that
> is, 1 socket with D dies but each die contains just a single thread), both
> Linux and Windows guests incorrectly interprets the system as having D
> sockets with 1 die each
> 
> Ultimately this is caused by various CPUID leaves not being die-aware in
> their "threads per socket" calculations, so this patch fixes that
> 
> These changes are referenced to the AMD PPR for Family 19h Model 01h (Milan)
> and Family 17h Model 01h (Naples) manuals:
>  - CPUID_Fn00000001_EBX[23:16]: Number of threads in the processor
>                                 (Core::X86::Cpuid::SizeId[NC] + 1)
>  - CPUID_Fn0000000B_EBX_x01[15:0]: Number of logical cores in processor
>                                    socket (not present until Rome)
>  - CPUID_Fn80000001_ECX[1]: Multi core product
>                             (Core::X86::Cpuid::SizeId[NC] != 0)
>  - CPUID_Fn80000008_ECX[7:0]: The number of threads in the package - 1
>                               (Core::X86::Cpuid::SizeId[NC])
> 
> Note there are two remaining occurences that I didn't touch:
>  - CPUID_Fn8000001E_ECX[10:8]: Always 0 (1 node per processor) for Milan.
>                                But for Naples, it can also be 2 or 4 nodes
>                                where each node is defined as one or two
>                                CCXes (CCD?). But Milan also has multiple
>                                CCXes, so clearly the definition of a node is
>                                different from model to model, so I've left
>                                it untouched. (QEMU seems to use the Naples
>                                definition)
>  - MSR_CORE_THREAD_COUNT: This MSR doesn't exist on Milan or Naples
> 
> Signed-off-by: 小太 <nospam@kota.moe>
> ---
>  target/i386/cpu.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 97ad229d8b..6ff23fa590 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6049,8 +6049,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              *ecx |= CPUID_EXT_OSXSAVE;
>          }
>          *edx = env->features[FEAT_1_EDX];
> -        if (cs->nr_cores * cs->nr_threads > 1) {
> -            *ebx |= (cs->nr_cores * cs->nr_threads) << 16;
> +        if (env->nr_dies * cs->nr_cores * cs->nr_threads > 1) {
> +            *ebx |= (env->nr_dies * cs->nr_cores * cs->nr_threads) << 16;

The nr_cores in CPUState means "Number of cores within this CPU package", so it doesn't need
"nr_dies" here. Zhao Liu is fixing the calculation of nr_cores [1].

[1]: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg07187.html

Thanks,
Qian

>              *edx |= CPUID_HT;
>          }
>          if (!cpu->enable_pmu) {
> @@ -6230,7 +6230,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              break;
>          case 1:
>              *eax = apicid_pkg_offset(&topo_info);
> -            *ebx = cs->nr_cores * cs->nr_threads;
> +            *ebx = env->nr_dies * cs->nr_cores * cs->nr_threads;
>              *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
>              break;
>          default:
> @@ -6496,7 +6496,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>           * discards multiple thread information if it is set.
>           * So don't set it here for Intel to make Linux guests happy.
>           */
> -        if (cs->nr_cores * cs->nr_threads > 1) {
> +        if (env->nr_dies * cs->nr_cores * cs->nr_threads > 1) {
>              if (env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1 ||
>                  env->cpuid_vendor2 != CPUID_VENDOR_INTEL_2 ||
>                  env->cpuid_vendor3 != CPUID_VENDOR_INTEL_3) {
> @@ -6562,7 +6562,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>               *eax |= (cpu_x86_virtual_addr_width(env) << 8);
>          }
>          *ebx = env->features[FEAT_8000_0008_EBX];
> -        if (cs->nr_cores * cs->nr_threads > 1) {
> +        if (env->nr_dies * cs->nr_cores * cs->nr_threads > 1) {
>              /*
>               * Bits 15:12 is "The number of bits in the initial
>               * Core::X86::Apic::ApicId[ApicId] value that indicate
> @@ -6570,7 +6570,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>               * Bits 7:0 is "The number of threads in the package is NC+1"
>               */
>              *ecx = (apicid_pkg_offset(&topo_info) << 12) |
> -                   ((cs->nr_cores * cs->nr_threads) - 1);
> +                   ((env->nr_dies * cs->nr_cores * cs->nr_threads) - 1);
>          } else {
>              *ecx = 0;
>          }

