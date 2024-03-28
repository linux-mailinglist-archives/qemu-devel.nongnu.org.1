Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2252E8809CA
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Mar 2024 03:45:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmlx1-0006bI-Sh; Tue, 19 Mar 2024 22:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rmlx0-0006ao-2l
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 22:45:10 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rmlww-0006jr-NS
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 22:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710902707; x=1742438707;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=wDrdXvmqmwC120bCCmSpfnoYTook8fzexp+jUU3i9mc=;
 b=jC8NxyUJYiIafRI3VwRNDL6R0L2Ha4+1VUzTiutMT+h0eNbpF3Lq4oY1
 IYWtf0UweIM9RJBPJgJUrvnSZiJisnm/MaA8oxR/ua0ONh57n2jt2qZOF
 ou0UBmCa6tHxLC+hXZwt0Cg2kHdB/J8b/Kz0UdwY/s1HGv+P2l5jOIa4I
 z8wPT/fdUjUmZ35Seuscp1JUDRsnSO12unYF7imPGRSHPFyTytVYmImt/
 1VkGdMRUIiuEo+y4lE04ZYTxLTL0wIyQ6IQuuv38w9kqYvUTdhdYoLLIY
 uOZj3giF2NP3WylzFG4YkbtXUinD/TpWgId7CrZfrvo+EedT3Kwk43Rud Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="28281889"
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; d="scan'208";a="28281889"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2024 19:45:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; d="scan'208";a="51451803"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.242.48])
 ([10.124.242.48])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2024 19:45:01 -0700
Message-ID: <54e8b518-2bea-4a5b-a75a-4fd45535c6fa@intel.com>
Date: Wed, 20 Mar 2024 10:44:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] kvm: add support for guest physical bits
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240318155336.156197-1-kraxel@redhat.com>
 <20240318155336.156197-2-kraxel@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240318155336.156197-2-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 3/18/2024 11:53 PM, Gerd Hoffmann wrote:
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
>   target/i386/cpu.h         |  1 +
>   target/i386/cpu.c         |  1 +
>   target/i386/kvm/kvm-cpu.c | 31 ++++++++++++++++++++++++++++++-
>   3 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 952174bb6f52..d427218827f6 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2026,6 +2026,7 @@ struct ArchCPU {
>   
>       /* Number of physical address bits supported */
>       uint32_t phys_bits;
> +    uint32_t guest_phys_bits;
>   
>       /* in order to simplify APIC support, we leave this pointer to the
>          user */
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 9a210d8d9290..c88c895a5b3e 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6570,6 +6570,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>           if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
>               /* 64 bit processor */
>                *eax |= (cpu_x86_virtual_addr_width(env) << 8);
> +             *eax |= (cpu->guest_phys_bits << 16);
>           }
>           *ebx = env->features[FEAT_8000_0008_EBX];
>           if (cs->nr_cores * cs->nr_threads > 1) {
> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
> index 9c791b7b0520..5132bb96abd5 100644
> --- a/target/i386/kvm/kvm-cpu.c
> +++ b/target/i386/kvm/kvm-cpu.c
> @@ -18,10 +18,33 @@
>   #include "kvm_i386.h"
>   #include "hw/core/accel-cpu.h"
>   
> +static void kvm_set_guest_phys_bits(CPUState *cs)
> +{
> +    X86CPU *cpu = X86_CPU(cs);
> +    uint32_t eax, guest_phys_bits;
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
> +    if (cpu->host_phys_bits_limit &&
> +        cpu->guest_phys_bits > cpu->host_phys_bits_limit) {
> +        cpu->guest_phys_bits = cpu->host_phys_bits_limit;

host_phys_bits_limit takes effect only when cpu->host_phys_bits is set.

If users pass configuration like "-cpu 
qemu64,phys-bits=52,host-phys-bits-limit=45", the cpu->guest_phys_bits 
will be set to 45. I think this is not what we want, though the usage 
seems insane.

We can guard it as

  if (cpu->host_phys_bits && cpu->host_phys_bits_limit &&
      cpu->guest_phys_bits > cpu->host_phys_bits_limt)
{
}

Simpler, we can guard with cpu->phys_bits like below, because 
cpu->host_phys_bits_limit is used to guard cpu->phys_bits in 
host_cpu_realizefn()

  if (cpu->guest_phys_bits > cpu->phys_bits) {
	cpu->guest_phys_bits = cpu->phys_bits;
}


with this resolved,

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> +    }
> +}
> +
>   static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
>   {
>       X86CPU *cpu = X86_CPU(cs);
>       CPUX86State *env = &cpu->env;
> +    bool ret;
>   
>       /*
>        * The realize order is important, since x86_cpu_realize() checks if
> @@ -50,7 +73,13 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
>                                                      MSR_IA32_UCODE_REV);
>           }
>       }
> -    return host_cpu_realizefn(cs, errp);
> +    ret = host_cpu_realizefn(cs, errp);
> +    if (!ret) {
> +        return ret;
> +    }
> +
> +    kvm_set_guest_phys_bits(cs);
> +    return true;
>   }
>   
>   static bool lmce_supported(void)


