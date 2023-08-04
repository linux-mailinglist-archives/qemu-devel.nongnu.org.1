Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A192F76FDE8
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 11:58:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRrYP-0003rm-74; Fri, 04 Aug 2023 05:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qRrYM-0003re-7v
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 05:57:02 -0400
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qRrYJ-0006Ud-1T
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 05:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691143019; x=1722679019;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Vf8bqIMlt23OTTT1t7EvwWbm4BPqDtczucdrLSsPVRM=;
 b=iHI0iJFp9mOSrzOTIEv419tWHHPMCYpaM6tONqY8nH/Kb5hn0YZYFAIq
 nKdvxXqtNhAhVfNNNP7W6sM5/pg43fphmTakrK1qW+jjIyGnImh3wiBP/
 WDLlSMcTORXPjDNcskMiWnRJlFbV5BKVJIYcT5AFjfdFc4iKXwaSq+CfF
 f6oOd7pOq45CncFe9+f+PqGit6B39+XLr7uNg9xDtqohCFnRWO1dB2OQk
 KY9icmlOXXZrbaRpgWLhfsm3eMkALebbfjdv7PzPw3Z25F2l5o7yJamfx
 q8T3/cPlWyVkid2Ub5s8XTNM7ogaAM3S/H489ydnMhsMbZ/83+icrAXu7 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="360173214"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; d="scan'208";a="360173214"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2023 02:56:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="765044537"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; d="scan'208";a="765044537"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.16.81])
 ([10.93.16.81])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2023 02:56:50 -0700
Message-ID: <5514cbba-50ac-11cb-af46-ddd8ec4750e7@intel.com>
Date: Fri, 4 Aug 2023 17:56:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v3 04/17] i386/cpu: Fix i/d-cache topology to core level
 for Intel CPU
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Babu Moger <babu.moger@amd.com>, Zhao Liu <zhao1.liu@intel.com>,
 Robert Hoo <robert.hu@linux.intel.com>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-5-zhao1.liu@linux.intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20230801103527.397756-5-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.20; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-0.091,
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

On 8/1/2023 6:35 PM, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> For i-cache and d-cache, the maximum IDs for CPUs sharing cache (
> CPUID.04H.00H:EAX[bits 25:14] and CPUID.04H.01H:EAX[bits 25:14]) are
> both 0, 

This sounds like you are describing some architectural rules, which 
misleads me. I suggest changing the description to

For i-cache and d-cache, current QEMU hardcodes the maximum IDs for CPUs 
sharing cache (CPUID.04H.00H:EAX[bits 25:14] and CPUID.04H.01H:EAX[bits 
25:14]) to 0. ...

> and this means i-cache and d-cache are shared in the SMT level.
> This is correct if there's single thread per core, but is wrong for the
> hyper threading case (one core contains multiple threads) since the
> i-cache and d-cache are shared in the core level other than SMT level.
> 
> For AMD CPU, commit 8f4202fb1080 ("i386: Populate AMD Processor Cache
> Information for cpuid 0x8000001D") has already introduced i/d cache
> topology as core level by default.
> 
> Therefore, in order to be compatible with both multi-threaded and
> single-threaded situations, we should set i-cache and d-cache be shared
> at the core level by default.
> 
> This fix changes the default i/d cache topology from per-thread to
> per-core. Potentially, this change in L1 cache topology may affect the
> performance of the VM if the user does not specifically specify the
> topology or bind the vCPU. However, the way to achieve optimal
> performance should be to create a reasonable topology and set the
> appropriate vCPU affinity without relying on QEMU's default topology
> structure.
> 
> Fixes: 7e3482f82480 ("i386: Helpers to encode cache information consistently")
> Suggested-by: Robert Hoo <robert.hu@linux.intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
> Changes since v1:
>   * Split this fix from the patch named "i386/cpu: Fix number of
>     addressable IDs in CPUID.04H".
>   * Add the explanation of the impact on performance. (Xiaoyao)
> ---
>   target/i386/cpu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 50613cd04612..b439a05244ee 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6104,12 +6104,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>               switch (count) {
>               case 0: /* L1 dcache info */
>                   encode_cache_cpuid4(env->cache_info_cpuid4.l1d_cache,
> -                                    1, cs->nr_cores,
> +                                    cs->nr_threads, cs->nr_cores,
>                                       eax, ebx, ecx, edx);
>                   break;
>               case 1: /* L1 icache info */
>                   encode_cache_cpuid4(env->cache_info_cpuid4.l1i_cache,
> -                                    1, cs->nr_cores,
> +                                    cs->nr_threads, cs->nr_cores,
>                                       eax, ebx, ecx, edx);
>                   break;
>               case 2: /* L2 cache info */


