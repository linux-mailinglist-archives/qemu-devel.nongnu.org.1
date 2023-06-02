Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA0E71FA60
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 08:54:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4yee-0004wL-I6; Fri, 02 Jun 2023 02:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1q4yeT-0004ud-L1
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 02:52:47 -0400
Received: from mga18.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1q4yeR-0000li-75
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 02:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685688763; x=1717224763;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=FwgYrz1IDP9c7kauWadg1APibIldQUe7agGPQEpeJCU=;
 b=I/QqGeEoS6wckvtJgARxaLm413hrSrsKswmUpk3GEbWR1lA+MGpBws5O
 JaAWnr/emiARpnSoSzttCyGHIh2Vo62LgcZqFMrh2vrFg6EOw2vKA0tx4
 swoSqrUCh3rd+7C898duDGLIwtU1Jfc34qn5HTGXyF4Y9BpbMU3nX8cXj
 2e6kbufxvoRIqiU/tf/guQXG+zYYYpRZzPYZjo73/e6iwTIguU7/eVspl
 k7CnXFP8Upapr8mEeHyddhI/kfDkPH2VGoK1lI/B3VcfDYlK1eG+rqDTA
 2eH7LM9hUqPGg4CPNkffOiK2+hD4ePm8DNpOxOdawXUvtoD2LI64mRuPw Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="340419974"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; d="scan'208";a="340419974"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2023 23:52:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="954350468"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; d="scan'208";a="954350468"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.255.29.226])
 ([10.255.29.226])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2023 23:52:30 -0700
Message-ID: <3f060dcb-fb7c-683f-7543-8e8c615f3ed5@intel.com>
Date: Fri, 2 Jun 2023 14:52:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH] i386/cpu: Don't emulate L3 cache on 8000_001D if l3-cache
 is disabled
To: Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Babu Moger <babu.moger@amd.com>, Michael Roth <michael.roth@amd.com>,
 qemu-devel@nongnu.org
Cc: yuzenghui@huawei.com, zhangjianguo18@huawei.com, wanghaibin.wang@huawei.com
References: <20230531120028.25144-1-wangyanan55@huawei.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20230531120028.25144-1-wangyanan55@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=xiaoyao.li@intel.com; helo=mga18.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-0.1,
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

On 5/31/2023 8:00 PM, Yanan Wang wrote:
> Currently, we only avoid emulating L3 cache properties for AMD CPU
> when l3-cache is off, but failed to consider this case on CPUID 8000_001D.
> This result in a fact that we will still have L3 caches in the VM
> although we pass "host-cache-info=off,l3-cache=off" CLI to qemu.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

Out of curiosity, do you have a valid real use case to run VM with 
"l3-cache = off"?

> Fixes: 8f4202fb108 ("i386: Populate AMD Processor Cache Information for cpuid 0x8000001D")
> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
> ---
>   target/i386/cpu.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1242bd541a..17c367c5ba 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6337,8 +6337,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>                                          &topo_info, eax, ebx, ecx, edx);
>               break;
>           case 3: /* L3 cache info */
> -            encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache,
> -                                       &topo_info, eax, ebx, ecx, edx);
> +            if (cpu->enable_l3_cache) {
> +                encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache,
> +                                           &topo_info, eax, ebx, ecx, edx);
> +            }
>               break;
>           default: /* end of info */
>               *eax = *ebx = *ecx = *edx = 0;


