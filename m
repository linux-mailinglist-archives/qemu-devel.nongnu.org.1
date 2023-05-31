Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C513717478
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 05:46:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Cmp-0003PZ-7H; Tue, 30 May 2023 23:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1q4Cmm-0003PG-UZ
 for qemu-devel@nongnu.org; Tue, 30 May 2023 23:46:08 -0400
Received: from mga18.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1q4Cmk-0003NJ-Ek
 for qemu-devel@nongnu.org; Tue, 30 May 2023 23:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685504766; x=1717040766;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=oHn7T8yNwxa+AbzdsiEBFHCufnORPKF96rmxuSedbfM=;
 b=RaCUnd9iUhRzflMsf3y/6aY6TDe/jrN+UkHeLlGvvmxbPYyjYQjZ6Qim
 1Wz8m/QoY20Bye159MdFm5FtFC9+5owhgii7ZSEdt+FrPy5vW6SoQUUOe
 k2cb4rhtpVVwW5bOfxqtaIDOf29Lfb/M3GzwxLbeS28USiGHS9ivSjOuS
 Cdu95EmdLIDmjGkB84LU9aLsdpp3bPiIxWB8oGYYpY9QuRf9LabCfhg01
 WQS/+sh9XlmN1x7aVfkmT1ySbo7Oq16fcF4cQ17EW2w+Y9Mj708+jwFMo
 yNpVXWJESrdahq4CI2Coq5CNJOqLYLFOxEp0v1NFcAOTEKCMAX41acnCg g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="339718307"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; d="scan'208";a="339718307"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2023 20:46:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="706710230"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; d="scan'208";a="706710230"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.254.213.251])
 ([10.254.213.251])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2023 20:46:00 -0700
Message-ID: <48b25232-b487-e056-92c0-a6c2d02e61fe@intel.com>
Date: Wed, 31 May 2023 11:45:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/1] target/i386: add support for LAM in CPUID
 enumeration
Content-Language: en-US
To: Binbin Wu <binbin.wu@linux.intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, chao.gao@intel.com, robert.hu@linux.intel.com
References: <20230531013250.18311-1-binbin.wu@linux.intel.com>
 <20230531013250.18311-2-binbin.wu@linux.intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20230531013250.18311-2-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=xiaoyao.li@intel.com; helo=mga18.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-0.09,
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

On 5/31/2023 9:32 AM, Binbin Wu wrote:
> From: Robert Hoo <robert.hu@linux.intel.com>
> 
> Linear Address Masking (LAM) is a new Intel CPU feature, which allows software
> to use of the untranslated address bits for metadata.
> 
> The bit definition:
> CPUID.(EAX=7,ECX=1):EAX[26]
> 
> Add CPUID definition for LAM.
> 
> More info can be found in Intel ISE Chapter "LINEAR ADDRESS MASKING (LAM)"
> https://cdrdv2.intel.com/v1/dl/getContent/671368

LAM defines new bits in CR3 and CR4. I think it needs corresponding 
support in QEMU as well.

> Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> Co-developed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> ---
>   target/i386/cpu.c | 2 +-
>   target/i386/cpu.h | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1242bd541a..f4436b3657 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -881,7 +881,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>               "fsrc", NULL, NULL, NULL,
>               NULL, NULL, NULL, NULL,
>               NULL, "amx-fp16", NULL, "avx-ifma",
> -            NULL, NULL, NULL, NULL,
> +            NULL, NULL, "lam", NULL,
>               NULL, NULL, NULL, NULL,
>           },
>           .cpuid = {
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 7201a71de8..eb800ba2e2 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -924,6 +924,8 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
>   #define CPUID_7_1_EAX_AMX_FP16          (1U << 21)
>   /* Support for VPMADD52[H,L]UQ */
>   #define CPUID_7_1_EAX_AVX_IFMA          (1U << 23)
> +/* Linear Address Masking */
> +#define CPUID_7_1_EAX_LAM               (1U << 26)
>   
>   /* Support for VPDPB[SU,UU,SS]D[,S] */
>   #define CPUID_7_1_EDX_AVX_VNNI_INT8     (1U << 4)


