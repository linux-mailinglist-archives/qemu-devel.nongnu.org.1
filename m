Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F75E93A256
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jul 2024 16:12:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWGDt-0007gx-5b; Tue, 23 Jul 2024 10:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sWGDq-0007Zh-2m
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:10:34 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sWGDm-0005mp-HT
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721743830; x=1753279830;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=gviRZg3JKGdD97Tqc5cd1fofR/eusBA1ki2jYN7sh4o=;
 b=Cf3Ke0gBuHWCdfFUQ25Yrq/ENPoTSVlfRFUuE6rIIrzt6uEATKtO4dwy
 y7gA2LZAk/hoA/3r95/JjcLX/qQzV/x4yMzIANs1oHLEEuadwTmvMJ/kl
 /aXByFRk2HbZue1d0rkaqqn/RYiWoovegQVKBPf+AIj+bNVEjMDkOjcze
 RcLOTFIPHcAO4z+f6GRmzOUH8naOFLGfFWzibG3XwAHlEne89xvdd/EU8
 TLVSCqCZRQ5ssu5UOtmSfSUb/MHG+M/m0/SNqsuNwhMn+GdRodOzqyV2n
 RzQfELDnt/qm4aghcm4cZ7rq46leeyVpqXwgzkGAAM2+mYFrtJx38euBN w==;
X-CSE-ConnectionGUID: FbCLPzswTlGM6OMrfOj83Q==
X-CSE-MsgGUID: P0eQFyarT6WHMgdbofCY+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="18985023"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; d="scan'208";a="18985023"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2024 07:10:26 -0700
X-CSE-ConnectionGUID: jeZAjQ6nQSeRdN4nKQ7qag==
X-CSE-MsgGUID: VeOarEFmQ4WVi+mE2x+N+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; d="scan'208";a="89715694"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa001.jf.intel.com with ESMTP; 23 Jul 2024 07:10:24 -0700
Date: Tue, 23 Jul 2024 22:26:08 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "manish.mishra" <manish.mishra@nutanix.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 bob.ball@nutanix.com, prerna.saxena@nutanix.com,
 john.levon@nutanix.com, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH] target/i386: Always set leaf 0x1f
Message-ID: <Zp+9gOESPaUi8ATT@intel.com>
References: <20240722101859.47408-1-manish.mishra@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722101859.47408-1-manish.mishra@nutanix.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

(+Xiaoyao, whose TDX work may also be related with this.)

Hi Manish,

Thanks for your patch! Some comments below.

On Mon, Jul 22, 2024 at 10:18:59AM +0000, manish.mishra wrote:
> Date: Mon, 22 Jul 2024 10:18:59 +0000
> From: "manish.mishra" <manish.mishra@nutanix.com>
> Subject: [PATCH] target/i386: Always set leaf 0x1f
> X-Mailer: git-send-email 2.22.3
> 
> QEMU does not set 0x1f in case VM does not have extended CPU topology
> and expects guests to fallback to 0xb. Some versions of windows i.e.
> windows 10, 11 does not like this behavior and expects this leaf to be
> populated. This is observed with windows VMs with secure boot, uefi
> and HyperV role enabled.
> 
> Leaf 0x1f is superset of 0xb, so it makes sense to set 0x1f equivalent
> to 0xb by default and workaround windows issue. This change adds a
> new property 'cpuid-0x1f-enforce' to set leaf 0x1f equivalent to 0xb in
> case extended CPU topology is not present and behave as before otherwise.
> ---
>  hw/i386/pc.c          |  1 +
>  target/i386/cpu.c     | 71 +++++++++++++++++++++++++++----------------
>  target/i386/cpu.h     |  5 +++
>  target/i386/kvm/kvm.c |  4 ++-
>  4 files changed, 53 insertions(+), 28 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index c74931d577..4cab04e443 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -85,6 +85,7 @@ GlobalProperty pc_compat_9_0[] = {
>      { TYPE_X86_CPU, "guest-phys-bits", "0" },
>      { "sev-guest", "legacy-vm-type", "on" },
>      { TYPE_X86_CPU, "legacy-multi-node", "on" },
> +    { TYPE_X86_CPU, "cpuid-0x1f-enforce", "false" },
>  };
>  const size_t pc_compat_9_0_len = G_N_ELEMENTS(pc_compat_9_0);

Yes, this is needed, but the 9.1 soft freeze is coming close soon, so
you may have to add pc_compat_9_1[] if it doesn't get accepted before
the soft freeze.

> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 4688d140c2..f89b2ef335 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -416,6 +416,43 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
>      assert(!(*eax & ~0x1f));
>  }
>  
> +static void encode_topo_cpuid_b(CPUX86State *env, uint32_t count,
> +                                X86CPUTopoInfo *topo_info,
> +                                uint32_t threads_per_pkg,
> +                                uint32_t *eax, uint32_t *ebx,
> +                                uint32_t *ecx, uint32_t *edx)
> +{
> +    X86CPU *cpu = env_archcpu(env);
> +
> +    if (!cpu->enable_cpuid_0xb) {
> +        *eax = *ebx = *ecx = *edx = 0;
> +        return;
> +    }
> +
> +    *ecx = count & 0xff;
> +    *edx = cpu->apic_id;
> +
> +    switch (count) {
> +        case 0:
> +            *eax = apicid_core_offset(topo_info);
> +            *ebx = topo_info->threads_per_core;
> +            *ecx |= CPUID_B_ECX_TOPO_LEVEL_SMT << 8;
> +            break;
> +        case 1:
> +            *eax = apicid_pkg_offset(topo_info);
> +            *ebx = threads_per_pkg;
> +            *ecx |= CPUID_B_ECX_TOPO_LEVEL_CORE << 8;
> +            break;
> +        default:
> +            *eax = 0;
> +            *ebx = 0;
> +            *ecx |= CPUID_B_ECX_TOPO_LEVEL_INVALID << 8;
> +    }
> +
> +    assert(!(*eax & ~0x1f));
> +    *ebx &= 0xffff; /* The count doesn't need to be reliable. */
> +}
> +
>  /* Encode cache info for CPUID[0x80000005].ECX or CPUID[0x80000005].EDX */
>  static uint32_t encode_cache_cpuid80000005(CPUCacheInfo *cache)
>  {
> @@ -6601,33 +6638,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          break;
>      case 0xB:
>          /* Extended Topology Enumeration Leaf */
> -        if (!cpu->enable_cpuid_0xb) {
> -                *eax = *ebx = *ecx = *edx = 0;
> -                break;
> -        }
> -
> -        *ecx = count & 0xff;
> -        *edx = cpu->apic_id;
> -
> -        switch (count) {
> -        case 0:
> -            *eax = apicid_core_offset(&topo_info);
> -            *ebx = topo_info.threads_per_core;
> -            *ecx |= CPUID_B_ECX_TOPO_LEVEL_SMT << 8;
> -            break;
> -        case 1:
> -            *eax = apicid_pkg_offset(&topo_info);
> -            *ebx = threads_per_pkg;
> -            *ecx |= CPUID_B_ECX_TOPO_LEVEL_CORE << 8;
> -            break;
> -        default:
> -            *eax = 0;
> -            *ebx = 0;
> -            *ecx |= CPUID_B_ECX_TOPO_LEVEL_INVALID << 8;
> -        }
> -
> -        assert(!(*eax & ~0x1f));
> -        *ebx &= 0xffff; /* The count doesn't need to be reliable. */
> +        encode_topo_cpuid_b(env, count, &topo_info, threads_per_pkg,
> +                            eax, ebx, ecx, edx);
>          break;
>      case 0x1C:
>          if (cpu->enable_pmu && (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
> @@ -6639,6 +6651,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          /* V2 Extended Topology Enumeration Leaf */
>          if (!x86_has_extended_topo(env->avail_cpu_topo)) {
>              *eax = *ebx = *ecx = *edx = 0;
> +            if (cpu->enable_cpuid_0x1f_enforce) {
> +                encode_topo_cpuid_b(env, count, &topo_info, threads_per_pkg,
> +                                    eax, ebx, ecx, edx);
> +            }

encode_topo_cpuid_b() is not necessary since encode_topo_cpuid1f() could
encode SMT/core levels with the same type code as 0x0b.

So here we just need tweak the encoding condition:

-        if (!x86_has_extended_topo(env->avail_cpu_topo)) {
+        if (!x86_has_extended_topo(env->avail_cpu_topo) &&
+            !cpu->enable_cpuid_0x1f_enforce) {
             *eax = *ebx = *ecx = *edx = 0;
             break;
         }

         encode_topo_cpuid1f(env, count, &topo_info, eax, ebx, ecx, edx);
         break;

Then wrapping encode_topo_cpuid_b() could also be omitted, which keeps the
code changes as minor as possible.

>              break;
>          }
>  
> @@ -8316,6 +8332,7 @@ static Property x86_cpu_properties[] = {
>      DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
>      DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
>      DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
> +    DEFINE_PROP_BOOL("cpuid-0x1f-enforce", X86CPU, enable_cpuid_0x1f_enforce, true),
>      DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
>      DEFINE_PROP_BOOL("x-amd-topoext-features-only", X86CPU, amd_topoext_features_only, true),
>      DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 1e121acef5..718b9f2b0b 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2102,6 +2102,11 @@ struct ArchCPU {
>      /* Compatibility bits for old machine types: */
>      bool enable_cpuid_0xb;
>  
> +    /* Always return values for 0x1f leaf. In cases where extended CPU topology
> +     * is not supported, return values equivalent of leaf 0xb.

s/is not supported/is not configured/

> +     */
> +    bool enable_cpuid_0x1f_enforce;
> +
>      /* Enable auto level-increase for all CPUID leaves */
>      bool full_cpuid_auto_level;
>  
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index becca2efa5..a9c6f02900 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -1799,6 +1799,7 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
>      uint32_t limit, i, j;
>      uint32_t unused;
>      struct kvm_cpuid_entry2 *c;
> +    X86CPU *cpu = env_archcpu(env);
>  
>      cpu_x86_cpuid(env, 0, 0, &limit, &unused, &unused, &unused);
>  
> @@ -1831,7 +1832,8 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
>              break;
>          }
>          case 0x1f:
> -            if (!x86_has_extended_topo(env->avail_cpu_topo)) {
> +            if (!x86_has_extended_topo(env->avail_cpu_topo) &&
> +                !cpu->enable_cpuid_0x1f_enforce) {
>                  cpuid_i--;
>                  break;
>              }

In addition to the above changes, we need to adjust the min_level of the
CPUID to ensure that 0x1f can be encoded:

@@ -7466,7 +7466,8 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
          * cpu->vendor_cpuid_only has been unset for compatibility with older
          * machine types.
          */
-        if (x86_has_extended_topo(env->avail_cpu_topo) &&
+        if ((x86_has_extended_topo(env->avail_cpu_topo) ||
+            cpu->enable_cpuid_0x1f_enforce) &&
             (IS_INTEL_CPU(env) || !cpu->vendor_cpuid_only)) {
             x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x1F);
         }

Thanks,
Zhao


