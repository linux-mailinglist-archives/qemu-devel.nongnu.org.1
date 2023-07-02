Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA153744E11
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 16:17:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFxsG-0004st-OA; Sun, 02 Jul 2023 10:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <like.xu.linux@gmail.com>)
 id 1qFxs5-0004sV-MD
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 10:16:20 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <like.xu.linux@gmail.com>)
 id 1qFxs3-0000In-Na
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 10:16:13 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-7948540a736so937625241.1
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 07:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688307370; x=1690899370;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O5JObF6v0mMbYnDE0yTMYfP2LdlzMCghcp3b95C3Ztw=;
 b=FZYZgXncgDFlJygsNKiZmtAsO6Nkvu74ls207CpQLSZZDXW4/+N1RGUJ88qUXV/o2i
 UrwrbUeEzCs1IBwldJlGLfHMeupotZc0O7LQPushyOWfrdVZiu6/AgAZCrsttM+zgn42
 L3jeJWcVdavFh7nlmmUkmpkM4gxmm8Fsftkks/f+vPNWykzUVmFbvBNVL3rI3ZcKIaRS
 NDjPEg2yw4mhwJvkM7Vp7UT8XBc+I2Z845mV74IMRuhnh+LWUIJeoEzPoBMfQd8lATPG
 mz28afyKV9TFjwpxwBqrysbvticgyxA4vS5Sss9pxSn9umXFXRy1wv5XU5mpGhXkU8xC
 +NSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688307370; x=1690899370;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O5JObF6v0mMbYnDE0yTMYfP2LdlzMCghcp3b95C3Ztw=;
 b=AYHvNrbsH73XfM3I+cuP1vlmHWNU05Fq8WGPqrQ7UWgCdNBU9hkwsUuSYsXCx6uDHB
 EirylaMkRqDPjkFMidSmnIIniEpT9SoON3fWXFTDKt/85O1a0oHdW9fNdv7nQUZc4pWC
 dfDPifj9xQWYDezPpQxMkCGWvBaQykri4t3deu5lQCJ4gbeIOPbO2Zviqa6scrJW0eHr
 /M3+mcasDu3CoAw21M5CbHuaw1Cpb3aLZiJqkEtaGZZ7Jxc/ZtJTFfa2HE7nuhMkEHis
 g4aPgqHxuhc35p6sxU0fv+p1l6MNw4cck+S5lPxPzl/nXb8YHmUK70kLjUqeOr15I9O9
 CLew==
X-Gm-Message-State: ABy/qLayg7DL1hV4yQpzYmV34RytW4RrwadFbBfNUOkSDYQ0V1unqNzE
 QzLeCy+mQGdrEhMmyCRUmpTncRj88NB2OXa9kZE=
X-Google-Smtp-Source: APBJJlEZOZmA8IvhmeUhdHkTyXW7dBa4+LD7HWHR1pmAPO7G68dLfGxdZBtfPn5Y74GkJm51FYx9CNhCyN8x8RlfqcQ=
X-Received: by 2002:a67:f14a:0:b0:443:90a4:4c60 with SMTP id
 t10-20020a67f14a000000b0044390a44c60mr4498617vsm.33.1688307370390; Sun, 02
 Jul 2023 07:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230621013821.6874-1-dongli.zhang@oracle.com>
 <20230621013821.6874-3-dongli.zhang@oracle.com>
In-Reply-To: <20230621013821.6874-3-dongli.zhang@oracle.com>
From: Like Xu <like.xu.linux@gmail.com>
Date: Sun, 2 Jul 2023 22:15:53 +0800
Message-ID: <CAA3+yLdC0Vo-cMuPh++U1-u=eROOG-YdaPrfCMUF+TgErtwj4w@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 2/2] target/i386/kvm: get and put AMD pmu
 registers
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com, 
 joe.jin@oracle.com, zhenyuw@linux.intel.com, groug@kaod.org, 
 lyan@digitalocean.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=like.xu.linux@gmail.com; helo=mail-ua1-x929.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Jun 21, 2023 at 9:39=E2=80=AFAM Dongli Zhang <dongli.zhang@oracle.c=
om> wrote:
>
> The QEMU side calls kvm_get_msrs() to save the pmu registers from the KVM
> side to QEMU, and calls kvm_put_msrs() to store the pmu registers back to
> the KVM side.
>
> However, only the Intel gp/fixed/global pmu registers are involved. There
> is not any implementation for AMD pmu registers. The
> 'has_architectural_pmu_version' and 'num_architectural_pmu_gp_counters' a=
re
> calculated at kvm_arch_init_vcpu() via cpuid(0xa). This does not work for
> AMD. Before AMD PerfMonV2, the number of gp registers is decided based on
> the CPU version.

Updating the relevant documentation to clarify this part of the deficiency
would be a good first step.

>
> This patch is to add the support for AMD version=3D1 pmu, to get and put =
AMD
> pmu registers. Otherwise, there will be a bug:

AMD version=3D1 ?

AMD does not have version 1, just directly has 2, perhaps because of x86
compatibility. AMD also does not have the so-called architectural pmu.
Maybe need to rename has_architectural_pmu_version for AMD.

It might be more helpful to add similar support for AMD PerfMonV2.

>
> 1. The VM resets (e.g., via QEMU system_reset or VM kdump/kexec) while it
> is running "perf top". The pmu registers are not disabled gracefully.
>
> 2. Although the x86_cpu_reset() resets many registers to zero, the
> kvm_put_msrs() does not puts AMD pmu registers to KVM side. As a result,
> some pmu events are still enabled at the KVM side.

I agree that we should have done that, especially if guest pmu is enabled
on the AMD platforms.

>
> 3. The KVM pmc_speculative_in_use() always returns true so that the event=
s
> will not be reclaimed. The kvm_pmc->perf_event is still active.
>
> 4. After the reboot, the VM kernel reports below error:
>
> [    0.092011] Performance Events: Fam17h+ core perfctr, Broken BIOS dete=
cted, complain to your hardware vendor.
> [    0.092023] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (M=
SR c0010200 is 530076)
>
> 5. In a worse case, the active kvm_pmc->perf_event is still able to
> inject unknown NMIs randomly to the VM kernel.
>
> [...] Uhhuh. NMI received for unknown reason 30 on CPU 0.
>
> The patch is to fix the issue by resetting AMD pmu registers during the
> reset.

I'm not sure if the qemu_reset or VM kexec will necessarily trigger
kvm::amd_pmu_reset().

>
> Cc: Joe Jin <joe.jin@oracle.com>
> Cc: Like Xu <likexu@tencent.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  target/i386/cpu.h     |  5 +++
>  target/i386/kvm/kvm.c | 83 +++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 86 insertions(+), 2 deletions(-)
>
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index cd047e0410..b8ba72e87a 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -471,6 +471,11 @@ typedef enum X86Seg {
>  #define MSR_CORE_PERF_GLOBAL_CTRL       0x38f
>  #define MSR_CORE_PERF_GLOBAL_OVF_CTRL   0x390
>
> +#define MSR_K7_EVNTSEL0                 0xc0010000
> +#define MSR_K7_PERFCTR0                 0xc0010004
> +#define MSR_F15H_PERF_CTL0              0xc0010200
> +#define MSR_F15H_PERF_CTR0              0xc0010201
> +
>  #define MSR_MC0_CTL                     0x400
>  #define MSR_MC0_STATUS                  0x401
>  #define MSR_MC0_ADDR                    0x402
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index bf4136fa1b..a0f7273dad 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -2084,6 +2084,32 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          }
>      }
>
> +    /*
> +     * If KVM_CAP_PMU_CAPABILITY is not supported, there is no way to
> +     * disable the AMD pmu virtualization.
> +     *
> +     * If KVM_CAP_PMU_CAPABILITY is supported, kvm_state->pmu_cap_disabl=
ed
> +     * indicates the KVM side has already disabled the pmu virtualizatio=
n.
> +     */
> +    if (IS_AMD_CPU(env) && !cs->kvm_state->pmu_cap_disabled) {
> +        int64_t family;
> +
> +        family =3D (env->cpuid_version >> 8) & 0xf;
> +        if (family =3D=3D 0xf) {
> +            family +=3D (env->cpuid_version >> 20) & 0xff;
> +        }
> +
> +        if (family >=3D 6) {
> +            has_architectural_pmu_version =3D 1;
> +
> +            if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_PERFCORE)=
 {
> +                num_architectural_pmu_gp_counters =3D 6;

Please make the code a little more readable with some macro definitions.

#define AMD64_NUM_COUNTERS 4
#define AMD64_NUM_COUNTERS_CORE 6

> +            } else {
> +                num_architectural_pmu_gp_counters =3D 4;
> +            }
> +        }
> +    }
> +
>      cpu_x86_cpuid(env, 0x80000000, 0, &limit, &unused, &unused, &unused)=
;
>
>      for (i =3D 0x80000000; i <=3D limit; i++) {
> @@ -3438,7 +3464,7 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>              kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, env->poll_contr=
ol_msr);
>          }
>
> -        if (has_architectural_pmu_version > 0) {
> +        if (has_architectural_pmu_version > 0 && IS_INTEL_CPU(env)) {

It seems to be saying here that it is possible to perform kvm_msr_entry_add=
()
for Intel-related pmu on AMD platforms. So the reverse is expected to be
feasible as well. Why need distinction?

>              if (has_architectural_pmu_version > 1) {
>                  /* Stop the counter.  */
>                  kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
> @@ -3469,6 +3495,26 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>                                    env->msr_global_ctrl);
>              }
>          }
> +
> +        if (has_architectural_pmu_version > 0 && IS_AMD_CPU(env)) {
> +            uint32_t sel_base =3D MSR_K7_EVNTSEL0;
> +            uint32_t ctr_base =3D MSR_K7_PERFCTR0;
> +            uint32_t step =3D 1;
> +
> +            if (num_architectural_pmu_gp_counters =3D=3D 6) {
> +                sel_base =3D MSR_F15H_PERF_CTL0;
> +                ctr_base =3D MSR_F15H_PERF_CTR0;
> +                step =3D 2;
> +            }
> +
> +            for (i =3D 0; i < num_architectural_pmu_gp_counters; i++) {
> +                kvm_msr_entry_add(cpu, ctr_base + i * step,
> +                                  env->msr_gp_counters[i]);
> +                kvm_msr_entry_add(cpu, sel_base + i * step,
> +                                  env->msr_gp_evtsel[i]);
> +            }
> +        }
> +
>          /*
>           * Hyper-V partition-wide MSRs: to avoid clearing them on cpu ho=
t-add,
>           * only sync them to KVM on the first cpu
> @@ -3929,7 +3975,7 @@ static int kvm_get_msrs(X86CPU *cpu)
>      if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_POLL_CONTROL)) {
>          kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, 1);
>      }
> -    if (has_architectural_pmu_version > 0) {
> +    if (has_architectural_pmu_version > 0 && IS_INTEL_CPU(env)) {
>          if (has_architectural_pmu_version > 1) {
>              kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
>              kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
> @@ -3945,6 +3991,25 @@ static int kvm_get_msrs(X86CPU *cpu)
>          }
>      }
>
> +    if (has_architectural_pmu_version > 0 && IS_AMD_CPU(env)) {
> +        uint32_t sel_base =3D MSR_K7_EVNTSEL0;
> +        uint32_t ctr_base =3D MSR_K7_PERFCTR0;
> +        uint32_t step =3D 1;
> +
> +        if (num_architectural_pmu_gp_counters =3D=3D 6) {
> +            sel_base =3D MSR_F15H_PERF_CTL0;
> +            ctr_base =3D MSR_F15H_PERF_CTR0;
> +            step =3D 2;

Perhaps it would be more helpful to add a little commentary on why
step 2 is needed.

> +        }
> +
> +        for (i =3D 0; i < num_architectural_pmu_gp_counters; i++) {
> +            kvm_msr_entry_add(cpu, ctr_base + i * step,
> +                              env->msr_gp_counters[i]);
> +            kvm_msr_entry_add(cpu, sel_base + i * step,
> +                              env->msr_gp_evtsel[i]);
> +        }
> +    }
> +
>      if (env->mcg_cap) {
>          kvm_msr_entry_add(cpu, MSR_MCG_STATUS, 0);
>          kvm_msr_entry_add(cpu, MSR_MCG_CTL, 0);
> @@ -4230,6 +4295,20 @@ static int kvm_get_msrs(X86CPU *cpu)
>          case MSR_P6_EVNTSEL0 ... MSR_P6_EVNTSEL0 + MAX_GP_COUNTERS - 1:
>              env->msr_gp_evtsel[index - MSR_P6_EVNTSEL0] =3D msrs[i].data=
;
>              break;
> +        case MSR_K7_EVNTSEL0 ... MSR_K7_EVNTSEL0 + 3:
> +            env->msr_gp_evtsel[index - MSR_K7_EVNTSEL0] =3D msrs[i].data=
;
> +            break;
> +        case MSR_K7_PERFCTR0 ... MSR_K7_PERFCTR0 + 3:
> +            env->msr_gp_counters[index - MSR_K7_PERFCTR0] =3D msrs[i].da=
ta;
> +            break;
> +        case MSR_F15H_PERF_CTL0 ... MSR_F15H_PERF_CTL0 + 0xb:
> +            index =3D index - MSR_F15H_PERF_CTL0;
> +            if (index & 0x1) {
> +                env->msr_gp_counters[index] =3D msrs[i].data;
> +            } else {
> +                env->msr_gp_evtsel[index] =3D msrs[i].data;
> +            }
> +            break;
>          case HV_X64_MSR_HYPERCALL:
>              env->msr_hv_hypercall =3D msrs[i].data;
>              break;
> --
> 2.34.1
>

