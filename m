Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5645F9C1061
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Nov 2024 22:03:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t99cq-0000CR-AA; Thu, 07 Nov 2024 16:01:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1t99cW-0000BI-0d
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 16:00:50 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1t99cR-0003LZ-Bv
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 16:00:47 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:b1cb:0:640:2a1e:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 2AD6960A55;
 Fri,  8 Nov 2024 00:00:34 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a507::1:28] (unknown
 [2a02:6b8:b081:a507::1:28])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id T0q7j21BR8c0-YG5zpvlF; Fri, 08 Nov 2024 00:00:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1731013233;
 bh=Dp6A0mIoBNs+G/dTAJYWiWkc14VowCV14QzHck7kYiU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=nJvMBmhJHSZ0l3MCm5R0ne45ejLwNTFpZMXA1wBcp9Gg0j0Kj/XEwbibPmWbRUCHZ
 0CPbq3/6il6XEhpvkzQWToINE/OqwKPdiqT0MMFD9A5HY79ilHXPuA+4WSKxMsEI63
 Eacw0y3lzF2saeARIH4kF3AC7nT2lw++8nePCoLs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a7f9c3c9-09af-4941-b137-2cb83ef8ceb3@yandex-team.ru>
Date: Fri, 8 Nov 2024 00:00:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] target/i386/kvm: reset AMD PMU registers during VM
 reset
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, sandipan.das@amd.com,
 babu.moger@amd.com, zhao1.liu@intel.com, likexu@tencent.com,
 like.xu.linux@gmail.com, zhenyuw@linux.intel.com, groug@kaod.org,
 lyan@digitalocean.com, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com, joe.jin@oracle.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20241104094119.4131-1-dongli.zhang@oracle.com>
 <20241104094119.4131-6-dongli.zhang@oracle.com>
Content-Language: en-US
From: Maksim Davydov <davydov-max@yandex-team.ru>
In-Reply-To: <20241104094119.4131-6-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=davydov-max@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



On 11/4/24 12:40, Dongli Zhang wrote:
> QEMU uses the kvm_get_msrs() function to save Intel PMU registers from KVM
> and kvm_put_msrs() to restore them to KVM. However, there is no support for
> AMD PMU registers. Currently, has_pmu_version and num_pmu_gp_counters are
> initialized based on cpuid(0xa), which does not apply to AMD processors.
> For AMD CPUs, prior to PerfMonV2, the number of general-purpose registers
> is determined based on the CPU version.
> 
> To address this issue, we need to add support for AMD PMU registers.
> Without this support, the following problems can arise:
> 
> 1. If the VM is reset (e.g., via QEMU system_reset or VM kdump/kexec) while
> running "perf top", the PMU registers are not disabled properly.
> 
> 2. Despite x86_cpu_reset() resetting many registers to zero, kvm_put_msrs()
> does not handle AMD PMU registers, causing some PMU events to remain
> enabled in KVM.
> 
> 3. The KVM kvm_pmc_speculative_in_use() function consistently returns true,
> preventing the reclamation of these events. Consequently, the
> kvm_pmc->perf_event remains active.
> 
> 4. After a reboot, the VM kernel may report the following error:
> 
> [    0.092011] Performance Events: Fam17h+ core perfctr, Broken BIOS detected, complain to your hardware vendor.
> [    0.092023] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR c0010200 is 530076)
> 
> 5. In the worst case, the active kvm_pmc->perf_event may inject unknown
> NMIs randomly into the VM kernel:
> 
> [...] Uhhuh. NMI received for unknown reason 30 on CPU 0.
> 
> To resolve these issues, we propose resetting AMD PMU registers during the
> VM reset process.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>   target/i386/cpu.h     |   8 +++
>   target/i386/kvm/kvm.c | 156 +++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 161 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 59959b8b7a..0505eb3b08 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -488,6 +488,14 @@ typedef enum X86Seg {
>   #define MSR_CORE_PERF_GLOBAL_CTRL       0x38f
>   #define MSR_CORE_PERF_GLOBAL_OVF_CTRL   0x390
>   
> +#define MSR_K7_EVNTSEL0                 0xc0010000
> +#define MSR_K7_PERFCTR0                 0xc0010004
> +#define MSR_F15H_PERF_CTL0              0xc0010200
> +#define MSR_F15H_PERF_CTR0              0xc0010201
> +
> +#define AMD64_NUM_COUNTERS              4
> +#define AMD64_NUM_COUNTERS_CORE         6
> +
>   #define MSR_MC0_CTL                     0x400
>   #define MSR_MC0_STATUS                  0x401
>   #define MSR_MC0_ADDR                    0x402
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index ca2b644e2c..83ec85a9b9 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -2035,7 +2035,7 @@ full:
>       abort();
>   }
>   
> -static void kvm_init_pmu_info(CPUX86State *env)
> +static void kvm_init_pmu_info_intel(CPUX86State *env)
>   {
>       uint32_t eax, edx;
>       uint32_t unused;
> @@ -2072,6 +2072,80 @@ static void kvm_init_pmu_info(CPUX86State *env)
>       }
>   }
>   
> +static void kvm_init_pmu_info_amd(CPUX86State *env)
> +{
> +    int64_t family;
> +
> +    has_pmu_version = 0;
> +
> +    /*
> +     * To determine the CPU family, the following code is derived from
> +     * x86_cpuid_version_get_family().
> +     */
> +    family = (env->cpuid_version >> 8) & 0xf;
> +    if (family == 0xf) {
> +        family += (env->cpuid_version >> 20) & 0xff;
> +    }
> +
> +    /*
> +     * Performance-monitoring supported from K7 and later.
> +     */
> +    if (family < 6) {
> +        return;
> +    }
> +
> +    has_pmu_version = 1;
> +
> +    if (!(env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_PERFCORE)) {
> +        num_pmu_gp_counters = AMD64_NUM_COUNTERS;
> +        return;
> +    }
> +
> +    num_pmu_gp_counters = AMD64_NUM_COUNTERS_CORE;
> +}

It seems that AMD implementation has one issue.
KVM has parameter `enable_pmu`. So vPMU can be disabled in another way, 
not only via KVM_PMU_CAP_DISABLE. For Intel it's not a problem, because 
the vPMU initialization uses info from KVM_GET_SUPPORTED_CPUID. The 
enable_pmu state is reflected in KVM_GET_SUPPORTED_CPUID.  Thus no PMU 
MSRs in kvm_put_msrs/kvm_get_msrs will be used.

But on AMD we don't use information from KVM_GET_SUPPORTED_CPUID to set 
an appropriate number of PMU registers. So, if vPMU is disabled by KVM 
parameter `enable_pmu` and pmu-cap-disable=false, then has_pmu_version 
will be 1 after kvm_init_pmu_info_amd execution. It means that in 
kvm_put_msrs/kvm_get_msrs 4 PMU counters will be processed, but the 
correct behavior in that situation is to skip all PMU registers.
I think we should get info from KVM to fix that.

I tested this series on Zen2 and found that PMU MSRs were still 
processed during initialization even with enable_pmu=N. But it doesn't 
lead to any errors in QEMU

> +
> +static bool is_same_vendor(CPUX86State *env)
> +{
> +    static uint32_t host_cpuid_vendor1;
> +    static uint32_t host_cpuid_vendor2;
> +    static uint32_t host_cpuid_vendor3;
> +
> +    host_cpuid(0x0, 0, NULL, &host_cpuid_vendor1, &host_cpuid_vendor3,
> +               &host_cpuid_vendor2);
> +
> +    return env->cpuid_vendor1 == host_cpuid_vendor1 &&
> +           env->cpuid_vendor2 == host_cpuid_vendor2 &&
> +           env->cpuid_vendor3 == host_cpuid_vendor3;
> +}
> +
> +static void kvm_init_pmu_info(CPUX86State *env)
> +{
> +    /*
> +     * It is not supported to virtualize AMD PMU registers on Intel
> +     * processors, nor to virtualize Intel PMU registers on AMD processors.
> +     */
> +    if (!is_same_vendor(env)) {
> +        return;
> +    }
> +
> +    /*
> +     * If KVM_CAP_PMU_CAPABILITY is not supported, there is no way to
> +     * disable the AMD pmu virtualization.
> +     *
> +     * If KVM_CAP_PMU_CAPABILITY is supported, kvm_state->pmu_cap_disabled
> +     * indicates the KVM has already disabled the pmu virtualization.
> +     */
> +    if (kvm_state->pmu_cap_disabled) {
> +        return;
> +    }
> +

It seems that after these changes the issue concerning using
pmu-cap-disable=true with +pmu on Intel platform (that Zhao Liu has 
mentioned before) is fixed

> +    if (IS_INTEL_CPU(env)) {
> +        kvm_init_pmu_info_intel(env);
> +    } else if (IS_AMD_CPU(env)) {
> +        kvm_init_pmu_info_amd(env);
> +    }
> +}
> +
>   int kvm_arch_init_vcpu(CPUState *cs)
>   {
>       struct {
> @@ -4027,7 +4101,7 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>               kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, env->poll_control_msr);
>           }
>   
> -        if (has_pmu_version > 0) {
> +        if (IS_INTEL_CPU(env) && has_pmu_version > 0) {
>               if (has_pmu_version > 1) {
>                   /* Stop the counter.  */
>                   kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
> @@ -4058,6 +4132,38 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>                                     env->msr_global_ctrl);
>               }
>           }
> +
> +        if (IS_AMD_CPU(env) && has_pmu_version > 0) {
> +            uint32_t sel_base = MSR_K7_EVNTSEL0;
> +            uint32_t ctr_base = MSR_K7_PERFCTR0;
> +            /*
> +             * The address of the next selector or counter register is
> +             * obtained by incrementing the address of the current selector
> +             * or counter register by one.
> +             */
> +            uint32_t step = 1;
> +
> +            /*
> +             * When PERFCORE is enabled, AMD PMU uses a separate set of
> +             * addresses for the selector and counter registers.
> +             * Additionally, the address of the next selector or counter
> +             * register is determined by incrementing the address of the
> +             * current register by two.
> +             */
> +            if (num_pmu_gp_counters == AMD64_NUM_COUNTERS_CORE) {
> +                sel_base = MSR_F15H_PERF_CTL0;
> +                ctr_base = MSR_F15H_PERF_CTR0;
> +                step = 2;
> +            }
> +
> +            for (i = 0; i < num_pmu_gp_counters; i++) {
> +                kvm_msr_entry_add(cpu, ctr_base + i * step,
> +                                  env->msr_gp_counters[i]);
> +                kvm_msr_entry_add(cpu, sel_base + i * step,
> +                                  env->msr_gp_evtsel[i]);
> +            }
> +        }
> +
>           /*
>            * Hyper-V partition-wide MSRs: to avoid clearing them on cpu hot-add,
>            * only sync them to KVM on the first cpu
> @@ -4503,7 +4609,8 @@ static int kvm_get_msrs(X86CPU *cpu)
>       if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_POLL_CONTROL)) {
>           kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, 1);
>       }
> -    if (has_pmu_version > 0) {
> +
> +    if (IS_INTEL_CPU(env) && has_pmu_version > 0) {
>           if (has_pmu_version > 1) {
>               kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
>               kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
> @@ -4519,6 +4626,35 @@ static int kvm_get_msrs(X86CPU *cpu)
>           }
>       }
>   
> +    if (IS_AMD_CPU(env) && has_pmu_version > 0) {
> +        uint32_t sel_base = MSR_K7_EVNTSEL0;
> +        uint32_t ctr_base = MSR_K7_PERFCTR0;
> +        /*
> +         * The address of the next selector or counter register is
> +         * obtained by incrementing the address of the current selector
> +         * or counter register by one.
> +         */
> +        uint32_t step = 1;
> +
> +        /*
> +         * When PERFCORE is enabled, AMD PMU uses a separate set of
> +         * addresses for the selector and counter registers.
> +         * Additionally, the address of the next selector or counter
> +         * register is determined by incrementing the address of the
> +         * current register by two.
> +         */
> +        if (num_pmu_gp_counters == AMD64_NUM_COUNTERS_CORE) {
> +            sel_base = MSR_F15H_PERF_CTL0;
> +            ctr_base = MSR_F15H_PERF_CTR0;
> +            step = 2;
> +        }
> +
> +        for (i = 0; i < num_pmu_gp_counters; i++) {
> +            kvm_msr_entry_add(cpu, ctr_base + i * step, 0);
> +            kvm_msr_entry_add(cpu, sel_base + i * step, 0);
> +        }
> +    }
> +
>       if (env->mcg_cap) {
>           kvm_msr_entry_add(cpu, MSR_MCG_STATUS, 0);
>           kvm_msr_entry_add(cpu, MSR_MCG_CTL, 0);
> @@ -4830,6 +4966,20 @@ static int kvm_get_msrs(X86CPU *cpu)
>           case MSR_P6_EVNTSEL0 ... MSR_P6_EVNTSEL0 + MAX_GP_COUNTERS - 1:
>               env->msr_gp_evtsel[index - MSR_P6_EVNTSEL0] = msrs[i].data;
>               break;
> +        case MSR_K7_EVNTSEL0 ... MSR_K7_EVNTSEL0 + 3:
> +            env->msr_gp_evtsel[index - MSR_K7_EVNTSEL0] = msrs[i].data;
> +            break;
> +        case MSR_K7_PERFCTR0 ... MSR_K7_PERFCTR0 + 3:
> +            env->msr_gp_counters[index - MSR_K7_PERFCTR0] = msrs[i].data;
> +            break;
> +        case MSR_F15H_PERF_CTL0 ... MSR_F15H_PERF_CTL0 + 0xb:
> +            index = index - MSR_F15H_PERF_CTL0;
> +            if (index & 0x1) {
> +                env->msr_gp_counters[index] = msrs[i].data;
> +            } else {
> +                env->msr_gp_evtsel[index] = msrs[i].data;
> +            }
> +            break;
>           case HV_X64_MSR_HYPERCALL:
>               env->msr_hv_hypercall = msrs[i].data;
>               break;

-- 
Best regards,
Maksim Davydov

