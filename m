Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A29181F619
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 09:52:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIm7S-0001ex-KN; Thu, 28 Dec 2023 03:51:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rIm7Q-0001ec-F7
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 03:51:56 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rIm7O-0006gW-DM
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 03:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703753515; x=1735289515;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=GCUOPShrQFtgfRPSYe5pL9qRcSAD6kvC1wbrne8GpJg=;
 b=GudLUXQE+BHoNcZFGuGt+KFm52CWCJFlkWap3NEaC0vZa47jRf2Gv+E+
 EdzdSkVkvlRhwIoSOm1Gwv8zmyp0IqsSzsJUX4L+ty7cKGcC0aI/nKmbb
 hG1f1bLEyy4/5KwjGC6n9LsxlKgmVGNBhx1KDFgjShdpMk7PbU499CwVr
 WCFOiTem6V2KgyrFFB7rTYmxTYCfUbIY1lS6LHdHR5+uoiFBNkn9C0ASh
 Vq02hysH8DTwHlqeJPce280HvfxG7eMmXRnwvThJqtLZ5lHuVQh66Ut5R
 OycrmWlF9jp6Fflowa+nBulqtIB1bgkOakR5Mpy5qSOHsrQk/SGKmQ+Dx A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="3374968"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="3374968"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Dec 2023 00:51:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="848902138"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; d="scan'208";a="848902138"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.22.149])
 ([10.93.22.149])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Dec 2023 00:51:50 -0800
Message-ID: <00183641-865d-4ffb-84e6-6bf8bf5529cb@intel.com>
Date: Thu, 28 Dec 2023 16:51:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] target/i386: add support for LAM in CPUID
 enumeration
Content-Language: en-US
To: Binbin Wu <binbin.wu@linux.intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, chao.gao@intel.com, robert.hu@linux.intel.com
References: <20230721080800.2329-1-binbin.wu@linux.intel.com>
 <20230721080800.2329-2-binbin.wu@linux.intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20230721080800.2329-2-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.755,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 7/21/2023 4:07 PM, Binbin Wu wrote:
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
> Note LAM feature is not supported for TCG of target-386, LAM CPIUD bit will not
> be added to TCG_7_1_EAX_FEATURES.
> 
> More info can be found in Intel ISE Chapter "LINEAR ADDRESS MASKING (LAM)"
> https://cdrdv2.intel.com/v1/dl/getContent/671368
> 
> Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> Co-developed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   target/i386/cpu.c | 2 +-
>   target/i386/cpu.h | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 97ad229d8b..3a42340730 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -965,7 +965,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>               "fsrc", NULL, NULL, NULL,
>               NULL, NULL, NULL, NULL,
>               NULL, "amx-fp16", NULL, "avx-ifma",
> -            NULL, NULL, NULL, NULL,
> +            NULL, NULL, "lam", NULL,
>               NULL, NULL, NULL, NULL,
>           },
>           .cpuid = {
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index e0771a1043..4db97899fe 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -925,6 +925,8 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
>   #define CPUID_7_1_EAX_AMX_FP16          (1U << 21)
>   /* Support for VPMADD52[H,L]UQ */
>   #define CPUID_7_1_EAX_AVX_IFMA          (1U << 23)
> +/* Linear Address Masking */
> +#define CPUID_7_1_EAX_LAM               (1U << 26)
>   
>   /* Support for VPDPB[SU,UU,SS]D[,S] */
>   #define CPUID_7_1_EDX_AVX_VNNI_INT8     (1U << 4)


