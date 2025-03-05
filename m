Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A6CA4F79E
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Mar 2025 08:05:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpinT-0006G6-1z; Wed, 05 Mar 2025 02:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1tpinO-0006Fb-Ac
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 02:03:59 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1tpinK-00074k-BG
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 02:03:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741158234; x=1772694234;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=8jzrqTqhnifkrDyJTtW4igiWDfZ+eSKjlbRZVYBx39w=;
 b=LHB89xXbc2UO5iDSzo2GIXh8ib/drpa1i+PXvJ0ttcpwW/ltyeFpW3nF
 aFxmimukS+2WxhucGzP1eLaZw8lqhTIwDR/s5CCngeg+o8aPXWWNhSBgH
 2OkicnDs/rvOX1ZqviEiQEop8VDWE8KqCjSM8gt4svG9FjjJUSA3UlVJL
 8i0yeBtlr5r9Rm155VWvzlhdBjp+9CHtghLsrbfiZKntU++0OIaIM0apG
 5wR0Wul85zycNG+mDrw8Zi4hFNgVdanpsZuYImwNv2r5zOwYGbWa3vASe
 38Vss9lVDa1b73bmyjcg+dhQt8tCycl0KYMvyRbRfChfWtytagx2BLCli w==;
X-CSE-ConnectionGUID: N6UM6k6/QkuAy8au4bPcOg==
X-CSE-MsgGUID: 8GpuKrxmRjW8FzFOy035YQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41965852"
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; d="scan'208";a="41965852"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2025 23:03:48 -0800
X-CSE-ConnectionGUID: 9xVNrOErS1+czG8AUsdpxw==
X-CSE-MsgGUID: gJ77evYTTHyiJK2c6J45sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="155794923"
Received: from unknown (HELO [10.238.2.135]) ([10.238.2.135])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2025 23:03:44 -0800
Message-ID: <7a6ec4ef-500f-491a-aba9-bf013b1058da@linux.intel.com>
Date: Wed, 5 Mar 2025 15:03:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] target/i386/kvm: extract unrelated code out of
 kvm_x86_build_cpuid()
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, zhenyuw@linux.intel.com, groug@kaod.org,
 khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com, joe.jin@oracle.com
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-6-dongli.zhang@oracle.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250302220112.17653-6-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=198.175.65.19;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 3/3/2025 6:00 AM, Dongli Zhang wrote:
> The initialization of 'has_architectural_pmu_version',
> 'num_architectural_pmu_gp_counters', and
> 'num_architectural_pmu_fixed_counters' is unrelated to the process of
> building the CPUID.
>
> Extract them out of kvm_x86_build_cpuid().
>
> No functional change.
>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
> Changed since v1:
>   - Still extract the code, but call them for all CPUs.
>
>  target/i386/kvm/kvm.c | 66 +++++++++++++++++++++++++------------------
>  1 file changed, 39 insertions(+), 27 deletions(-)
>
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 5c8a852dbd..8f293ffd61 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -1959,33 +1959,6 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
>          }
>      }
>  
> -    if (limit >= 0x0a) {
> -        uint32_t eax, edx;
> -
> -        cpu_x86_cpuid(env, 0x0a, 0, &eax, &unused, &unused, &edx);
> -
> -        has_architectural_pmu_version = eax & 0xff;
> -        if (has_architectural_pmu_version > 0) {
> -            num_architectural_pmu_gp_counters = (eax & 0xff00) >> 8;
> -
> -            /* Shouldn't be more than 32, since that's the number of bits
> -             * available in EBX to tell us _which_ counters are available.
> -             * Play it safe.
> -             */
> -            if (num_architectural_pmu_gp_counters > MAX_GP_COUNTERS) {
> -                num_architectural_pmu_gp_counters = MAX_GP_COUNTERS;
> -            }
> -
> -            if (has_architectural_pmu_version > 1) {
> -                num_architectural_pmu_fixed_counters = edx & 0x1f;
> -
> -                if (num_architectural_pmu_fixed_counters > MAX_FIXED_COUNTERS) {
> -                    num_architectural_pmu_fixed_counters = MAX_FIXED_COUNTERS;
> -                }
> -            }
> -        }
> -    }
> -
>      cpu_x86_cpuid(env, 0x80000000, 0, &limit, &unused, &unused, &unused);
>  
>      for (i = 0x80000000; i <= limit; i++) {
> @@ -2085,6 +2058,43 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
>      return 0;
>  }
>  
> +static void kvm_init_pmu_info(CPUX86State *env)
> +{
> +    uint32_t eax, edx;
> +    uint32_t unused;
> +    uint32_t limit;
> +
> +    cpu_x86_cpuid(env, 0, 0, &limit, &unused, &unused, &unused);
> +
> +    if (limit < 0x0a) {
> +        return;
> +    }
> +
> +    cpu_x86_cpuid(env, 0x0a, 0, &eax, &unused, &unused, &edx);
> +
> +    has_architectural_pmu_version = eax & 0xff;
> +    if (has_architectural_pmu_version > 0) {
> +        num_architectural_pmu_gp_counters = (eax & 0xff00) >> 8;
> +
> +        /*
> +         * Shouldn't be more than 32, since that's the number of bits
> +         * available in EBX to tell us _which_ counters are available.
> +         * Play it safe.
> +         */
> +        if (num_architectural_pmu_gp_counters > MAX_GP_COUNTERS) {
> +            num_architectural_pmu_gp_counters = MAX_GP_COUNTERS;
> +        }
> +
> +        if (has_architectural_pmu_version > 1) {
> +            num_architectural_pmu_fixed_counters = edx & 0x1f;
> +
> +            if (num_architectural_pmu_fixed_counters > MAX_FIXED_COUNTERS) {
> +                num_architectural_pmu_fixed_counters = MAX_FIXED_COUNTERS;
> +            }
> +        }
> +    }
> +}
> +
>  int kvm_arch_init_vcpu(CPUState *cs)
>  {
>      struct {
> @@ -2267,6 +2277,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      cpuid_i = kvm_x86_build_cpuid(env, cpuid_data.entries, cpuid_i);
>      cpuid_data.cpuid.nent = cpuid_i;
>  
> +    kvm_init_pmu_info(env);
> +
>      if (((env->cpuid_version >> 8)&0xF) >= 6
>          && (env->features[FEAT_1_EDX] & (CPUID_MCE | CPUID_MCA)) ==
>             (CPUID_MCE | CPUID_MCA)) {

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>



