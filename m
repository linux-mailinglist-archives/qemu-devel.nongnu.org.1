Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0767977EEEE
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 04:07:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWSQ5-0003Xz-Sb; Wed, 16 Aug 2023 22:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWSQ3-0003Xa-5N
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 22:07:27 -0400
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWSQ0-00011h-Vi
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 22:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692238045; x=1723774045;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=KOhxiqy/Y56viG44yG8qC3p/FmWXY3J4HKUFqCx0/N8=;
 b=Nwhj2RqeAR1fIuEJb29yWOhbrRox8ld8vQe1GrC8YS988bh+UpMf3QG/
 ydolsxqMfger77MYpaVS0NCSAkN1hktphgqqoXd+dEnASgGELs4ha5GUg
 TMHgOZc4IkKKWQ/hYBLeunyqE4O3Bvl9Dw8hn1ik48ljOSlnMtzOg0LNR
 JhX16DJSqKSMN+ctPajGIkLsBqnolexS/sf08gtlotM7RAUaaS96myU0H
 y9hQoDOTWozKnwNcFlNQYRiqsLfevRVFxpyk47zTxUosDYVSVC2FOt9NT
 Y/LZG/EL4lvYeFdaNhguq7ZSqdyP4fBH5SpvnbPKVJP0m2Nnc6m1Okw23 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="362843068"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; d="scan'208";a="362843068"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2023 19:07:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="804454661"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; d="scan'208";a="804454661"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.8.54])
 ([10.93.8.54])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2023 19:07:20 -0700
Message-ID: <2fe588e7-7121-f279-fa50-0e7743585d68@intel.com>
Date: Thu, 17 Aug 2023 10:07:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v3 2/2] target/i386: Avoid overflow of the cache parameter
 enumerated by leaf 4
Content-Language: en-US
To: Qian Wen <qian.wen@intel.com>, qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 babu.moger@amd.com
References: <20230816080658.3562730-1-qian.wen@intel.com>
 <20230816080658.3562730-3-qian.wen@intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20230816080658.3562730-3-qian.wen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.20; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -75
X-Spam_score: -7.6
X-Spam_bar: -------
X-Spam_report: (-7.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-3.165,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/16/2023 4:06 PM, Qian Wen wrote:
> According to SDM, CPUID.0x4:EAX[31:26] indicates the Maximum number of
> addressable IDs for processor cores in the physical package. If we
> launch over 64 cores VM, the 6-bit field will overflow, and the wrong
> core_id number will be reported.
> 
> Since the HW reports 0x3f when the intel processor has over 64 cores,
> limit the max value written to EBX[31:26] to 63, so max num_cores should
> be 64.
> 
> Signed-off-by: Qian Wen <qian.wen@intel.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   target/i386/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 5c008b9d7e..3b6854300a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -248,7 +248,7 @@ static void encode_cache_cpuid4(CPUCacheInfo *cache,
>       *eax = CACHE_TYPE(cache->type) |
>              CACHE_LEVEL(cache->level) |
>              (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0) |
> -           ((num_cores - 1) << 26) |
> +           ((MIN(num_cores, 64) - 1) << 26) |
>              ((num_apic_ids - 1) << 14);
>   
>       assert(cache->line_size > 0);


