Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FB387DC97
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Mar 2024 09:33:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rllwb-0005hC-Os; Sun, 17 Mar 2024 04:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1rllwZ-0005h3-Gc
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 04:32:35 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1rllwX-0007HJ-6B
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 04:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710664353; x=1742200353;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=92hfYwokdeu/YuQ+PkV1vqiKNBjGzAAHo/vUwVuYsRo=;
 b=AD+2GEar85rqzsLOFZS7Fz//1M2aHApDBNjJEvvOi/CVJeZBa6+5M68t
 g0Xj9tQ6J+ct1o9KHkj+LpRq4QZr+0gUTKUUI/0h7j4G+bqwAL0mAhIZh
 NpMXgeQY7/75HeDJLXzc59ZKCdxCwxxUkfb74/ywh2op5R5gFfkAo4Fo3
 hgMzfYVBT0cmWKHwylt6OCURkDH4OE4q0tfmJl8Sh97wfuLxEAG1wA0a1
 AvQm7jwAKUl5PXlE+yUcH9WZpg77gOX64KLS/tpjrJTd7wE2sO7le9rq1
 cibnoQbQuQvsuP5mHcuI6hXAzqONgzt77o37hJjAZC7+4eLEo3+IacEQH w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11015"; a="23006650"
X-IronPort-AV: E=Sophos;i="6.07,132,1708416000"; d="scan'208";a="23006650"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2024 01:32:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,132,1708416000"; d="scan'208";a="13788545"
Received: from linux.bj.intel.com ([10.238.157.71])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2024 01:32:26 -0700
Date: Sun, 17 Mar 2024 16:29:31 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Tom Lendacky <thomas.lendacky@amd.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v3 2/3] kvm: add support for guest physical bits
Message-ID: <Zfap1cqJngPblW+x@linux.bj.intel.com>
References: <20240313132719.939417-1-kraxel@redhat.com>
 <20240313132719.939417-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313132719.939417-3-kraxel@redhat.com>
Received-SPF: none client-ip=192.198.163.8;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On Wed, Mar 13, 2024 at 02:27:18PM +0100, Gerd Hoffmann wrote:
> Query kvm for supported guest physical address bits, in cpuid
> function 80000008, eax[23:16].  Usually this is identical to host
> physical address bits.  With NPT or EPT being used this might be
> restricted to 48 (max 4-level paging address space size) even if
> the host cpu supports more physical address bits.
> 
> When set pass this to the guest, using cpuid too.  Guest firmware
> can use this to figure how big the usable guest physical address
> space is, so PCI bar mapping are actually reachable.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  target/i386/cpu.h         |  1 +
>  target/i386/cpu.c         |  1 +
>  target/i386/kvm/kvm-cpu.c | 32 +++++++++++++++++++++++++++++++-
>  3 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 952174bb6f52..d427218827f6 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2026,6 +2026,7 @@ struct ArchCPU {
>  
>      /* Number of physical address bits supported */
>      uint32_t phys_bits;
> +    uint32_t guest_phys_bits;
>  
>      /* in order to simplify APIC support, we leave this pointer to the
>         user */
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 9a210d8d9290..c88c895a5b3e 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6570,6 +6570,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
>              /* 64 bit processor */
>               *eax |= (cpu_x86_virtual_addr_width(env) << 8);
> +             *eax |= (cpu->guest_phys_bits << 16);
>          }
>          *ebx = env->features[FEAT_8000_0008_EBX];
>          if (cs->nr_cores * cs->nr_threads > 1) {
> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
> index 9c791b7b0520..a2b7bfaeadf8 100644
> --- a/target/i386/kvm/kvm-cpu.c
> +++ b/target/i386/kvm/kvm-cpu.c
> @@ -18,10 +18,36 @@
>  #include "kvm_i386.h"
>  #include "hw/core/accel-cpu.h"
>  
> +static void kvm_set_guest_phys_bits(CPUState *cs)
> +{
> +    X86CPU *cpu = X86_CPU(cs);
> +    uint32_t eax, guest_phys_bits;
> +
> +    if (!cpu->host_phys_bits) {
> +        return;
> +    }
> +
> +    eax = kvm_arch_get_supported_cpuid(cs->kvm_state, 0x80000008, 0, R_EAX);
> +    guest_phys_bits = (eax >> 16) & 0xff;
> +    if (!guest_phys_bits) {
> +        return;
> +    }
> +
> +    if (cpu->guest_phys_bits == 0 ||
> +        cpu->guest_phys_bits > guest_phys_bits) {
> +        cpu->guest_phys_bits = guest_phys_bits;
> +    }
> +
> +    if (cpu->guest_phys_bits > cpu->host_phys_bits_limit) {
> +        cpu->guest_phys_bits = cpu->host_phys_bits_limit;

host_phys_bits_limit is zero by default, so I think it is better to be
like:

        if (cpu->host_phys_bits_limit &&
            cpu->guest_phys_bits > cpu->host_phys_bits_limit) {
            cpu->guest_phys_bits = cpu->host_phys_bits_limit;
        }

> +    }
> +}
> +
>  static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
>  {
>      X86CPU *cpu = X86_CPU(cs);
>      CPUX86State *env = &cpu->env;
> +    bool ret;
>  
>      /*
>       * The realize order is important, since x86_cpu_realize() checks if
> @@ -50,7 +76,11 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
>                                                     MSR_IA32_UCODE_REV);
>          }
>      }
> -    return host_cpu_realizefn(cs, errp);
> +    ret = host_cpu_realizefn(cs, errp);
> +
> +    kvm_set_guest_phys_bits(cs);
> +
> +    return ret;
>  }
>  
>  static bool lmce_supported(void)
> -- 
> 2.44.0
> 
> 

