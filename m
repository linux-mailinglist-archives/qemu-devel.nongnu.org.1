Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 635C0740965
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 08:14:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEOQc-0002aN-Ke; Wed, 28 Jun 2023 02:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qEOQX-0002XZ-QL
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 02:13:18 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qEOQU-00027Y-KB
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 02:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687932794; x=1719468794;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=D32A/1wTufL3otalSdXv92pRotUhiqbqZdBSQnrmSJc=;
 b=RR8IOuTiANRHZSE7CEjhhD5f7dzBwZL7CP1b6XKXGFURg16Jv7uSJYy8
 NOopn4mCwBURg4kdSGajpCYzQK6lcBnjbqp7uyF+ytDFZLSlUzv4lr0ua
 hPkEjoeewQRsWoVSic7zB5Yhn+whq1h2eq4su+mRayy7Bb2dp3wWxTRpy
 bWP9LEdyq56t8odYVlgiE3Mx/9/XicZLq9B/l4/YPshKZFgUTH9V/0yof
 XzYVQF9o07bUyE/5uLYUvHI/loylkTt6pWhYLBTQ3UdquxJCBbOdxBAKG
 t1Ds6E6b9MXZ/rLtMuv+ZlhiVqO7nYKiMjkeC9V4Beze+gvTQzha5V0kt A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="427768453"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; d="scan'208";a="427768453"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2023 23:13:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="666969034"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; d="scan'208";a="666969034"
Received: from linux.bj.intel.com ([10.238.156.127])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2023 23:13:07 -0700
Date: Wed, 28 Jun 2023 14:11:23 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xiaoyao.li@intel.com,
 lei4.wang@intel.com, qian.wen@intel.com
Subject: Re: [PATCH 7/7] target/i386: Add new CPU model GraniteRapids
Message-ID: <ZJvPC9i2rnxV/Mf9@linux.bj.intel.com>
References: <20230616032311.19137-1-tao1.su@linux.intel.com>
 <20230616032311.19137-8-tao1.su@linux.intel.com>
 <20230627135523.2a68e875@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627135523.2a68e875@imammedo.users.ipa.redhat.com>
Received-SPF: none client-ip=134.134.136.100;
 envelope-from=tao1.su@linux.intel.com; helo=mga07.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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

On Tue, Jun 27, 2023 at 01:55:23PM +0200, Igor Mammedov wrote:
> On Fri, 16 Jun 2023 11:23:11 +0800
> Tao Su <tao1.su@linux.intel.com> wrote:
> 
> > The GraniteRapids CPU model mainly adds the following new features based
> > on SapphireRapids:
> > 
> > - PREFETCHITI CPUID.(EAX=7,ECX=1):EDX[bit 14]
> > - AMX-FP16 CPUID.(EAX=7,ECX=1):EAX[bit 21]
> > - MCDT_NO CPUID.(EAX=7,ECX=2):EDX[bit 5]
> > - SBDR_SSDP_NO MSR_IA32_ARCH_CAPABILITIES[bit 13]
> > - FBSDP_NO MSR_IA32_ARCH_CAPABILITIES[bit 14]
> > - PSDP_NO MSR_IA32_ARCH_CAPABILITIES[bit 15]
> > - PBRSB_NO MSR_IA32_ARCH_CAPABILITIES[bit 24]
> 
> Can you point me to a some doc where above features
> are are documented as being introduced by GraniteRapids?

Sure. For PREFETCHITI and AMX-FP16, Intel ISE[1] lists them as GraniteRapids new
features, but the last five mainly indicate the HW contains the security fix for
corresponding vulnerabilities, which not list there. I dump the CPUIDs/MSRs
from the physical machine and get these added features.

[1] https://cdrdv2.intel.com/v1/dl/getContent/671368

Thanks,
Tao

> 
>  
> > Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> > Tested-by: Xuelian Guo <xuelian.guo@intel.com>
> > Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > ---
> >  target/i386/cpu.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 136 insertions(+)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 7faf6dfaee..860106fc24 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -3993,6 +3993,142 @@ static const X86CPUDefinition builtin_x86_defs[] = {
> >              { /* end of list */ },
> >          },
> >      },
> > +    {
> > +        .name = "GraniteRapids",
> > +        .level = 0x20,
> > +        .vendor = CPUID_VENDOR_INTEL,
> > +        .family = 6,
> > +        .model = 173,
> > +        .stepping = 0,
> > +        /*
> > +         * please keep the ascending order so that we can have a clear view of
> > +         * bit position of each feature.
> > +         */
> > +        .features[FEAT_1_EDX] =
> > +            CPUID_FP87 | CPUID_VME | CPUID_DE | CPUID_PSE | CPUID_TSC |
> > +            CPUID_MSR | CPUID_PAE | CPUID_MCE | CPUID_CX8 | CPUID_APIC |
> > +            CPUID_SEP | CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV |
> > +            CPUID_PAT | CPUID_PSE36 | CPUID_CLFLUSH | CPUID_MMX | CPUID_FXSR |
> > +            CPUID_SSE | CPUID_SSE2,
> > +        .features[FEAT_1_ECX] =
> > +            CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSSE3 |
> > +            CPUID_EXT_FMA | CPUID_EXT_CX16 | CPUID_EXT_PCID | CPUID_EXT_SSE41 |
> > +            CPUID_EXT_SSE42 | CPUID_EXT_X2APIC | CPUID_EXT_MOVBE |
> > +            CPUID_EXT_POPCNT | CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_AES |
> > +            CPUID_EXT_XSAVE | CPUID_EXT_AVX | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
> > +        .features[FEAT_8000_0001_EDX] =
> > +            CPUID_EXT2_SYSCALL | CPUID_EXT2_NX | CPUID_EXT2_PDPE1GB |
> > +            CPUID_EXT2_RDTSCP | CPUID_EXT2_LM,
> > +        .features[FEAT_8000_0001_ECX] =
> > +            CPUID_EXT3_LAHF_LM | CPUID_EXT3_ABM | CPUID_EXT3_3DNOWPREFETCH,
> > +        .features[FEAT_8000_0008_EBX] =
> > +            CPUID_8000_0008_EBX_WBNOINVD,
> > +        .features[FEAT_7_0_EBX] =
> > +            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_HLE |
> > +            CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 |
> > +            CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID | CPUID_7_0_EBX_RTM |
> > +            CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
> > +            CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_SMAP |
> > +            CPUID_7_0_EBX_AVX512IFMA | CPUID_7_0_EBX_CLFLUSHOPT |
> > +            CPUID_7_0_EBX_CLWB | CPUID_7_0_EBX_AVX512CD | CPUID_7_0_EBX_SHA_NI |
> > +            CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512VL,
> > +        .features[FEAT_7_0_ECX] =
> > +            CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
> > +            CPUID_7_0_ECX_AVX512_VBMI2 | CPUID_7_0_ECX_GFNI |
> > +            CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
> > +            CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG |
> > +            CPUID_7_0_ECX_AVX512_VPOPCNTDQ | CPUID_7_0_ECX_LA57 |
> > +            CPUID_7_0_ECX_RDPID | CPUID_7_0_ECX_BUS_LOCK_DETECT,
> > +        .features[FEAT_7_0_EDX] =
> > +            CPUID_7_0_EDX_FSRM | CPUID_7_0_EDX_SERIALIZE |
> > +            CPUID_7_0_EDX_TSX_LDTRK | CPUID_7_0_EDX_AMX_BF16 |
> > +            CPUID_7_0_EDX_AVX512_FP16 | CPUID_7_0_EDX_AMX_TILE |
> > +            CPUID_7_0_EDX_AMX_INT8 | CPUID_7_0_EDX_SPEC_CTRL |
> > +            CPUID_7_0_EDX_ARCH_CAPABILITIES | CPUID_7_0_EDX_SPEC_CTRL_SSBD,
> > +        .features[FEAT_ARCH_CAPABILITIES] =
> > +            MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_IBRS_ALL |
> > +            MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY | MSR_ARCH_CAP_MDS_NO |
> > +            MSR_ARCH_CAP_PSCHANGE_MC_NO | MSR_ARCH_CAP_TAA_NO |
> > +            MSR_ARCH_CAP_SBDR_SSDP_NO | MSR_ARCH_CAP_FBSDP_NO |
> > +            MSR_ARCH_CAP_PSDP_NO | MSR_ARCH_CAP_PBRSB_NO,
> > +        .features[FEAT_XSAVE] =
> > +            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
> > +            CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES | CPUID_D_1_EAX_XFD,
> > +        .features[FEAT_6_EAX] =
> > +            CPUID_6_EAX_ARAT,
> > +        .features[FEAT_7_1_EAX] =
> > +            CPUID_7_1_EAX_AVX_VNNI | CPUID_7_1_EAX_AVX512_BF16 |
> > +            CPUID_7_1_EAX_FZRM | CPUID_7_1_EAX_FSRS | CPUID_7_1_EAX_FSRC |
> > +            CPUID_7_1_EAX_AMX_FP16,
> > +        .features[FEAT_7_1_EDX] =
> > +            CPUID_7_1_EDX_PREFETCHITI,
> > +        .features[FEAT_7_2_EDX] =
> > +            CPUID_7_2_EDX_MCDT_NO,
> > +        .features[FEAT_VMX_BASIC] =
> > +            MSR_VMX_BASIC_INS_OUTS | MSR_VMX_BASIC_TRUE_CTLS,
> > +        .features[FEAT_VMX_ENTRY_CTLS] =
> > +            VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_IA32E_MODE |
> > +            VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
> > +            VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
> > +        .features[FEAT_VMX_EPT_VPID_CAPS] =
> > +            MSR_VMX_EPT_EXECONLY |
> > +            MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_PAGE_WALK_LENGTH_5 |
> > +            MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB | MSR_VMX_EPT_1GB |
> > +            MSR_VMX_EPT_INVEPT | MSR_VMX_EPT_AD_BITS |
> > +            MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
> > +            MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
> > +            MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT |
> > +            MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
> > +            MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
> > +        .features[FEAT_VMX_EXIT_CTLS] =
> > +            VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
> > +            VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
> > +            VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_IA32_PAT |
> > +            VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
> > +            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
> > +        .features[FEAT_VMX_MISC] =
> > +            MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_ACTIVITY_HLT |
> > +            MSR_VMX_MISC_VMWRITE_VMEXIT,
> > +        .features[FEAT_VMX_PINBASED_CTLS] =
> > +            VMX_PIN_BASED_EXT_INTR_MASK | VMX_PIN_BASED_NMI_EXITING |
> > +            VMX_PIN_BASED_VIRTUAL_NMIS | VMX_PIN_BASED_VMX_PREEMPTION_TIMER |
> > +            VMX_PIN_BASED_POSTED_INTR,
> > +        .features[FEAT_VMX_PROCBASED_CTLS] =
> > +            VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
> > +            VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
> > +            VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
> > +            VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
> > +            VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
> > +            VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
> > +            VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_VIRTUAL_NMI_PENDING |
> > +            VMX_CPU_BASED_MOV_DR_EXITING | VMX_CPU_BASED_UNCOND_IO_EXITING |
> > +            VMX_CPU_BASED_USE_IO_BITMAPS | VMX_CPU_BASED_MONITOR_TRAP_FLAG |
> > +            VMX_CPU_BASED_USE_MSR_BITMAPS | VMX_CPU_BASED_MONITOR_EXITING |
> > +            VMX_CPU_BASED_PAUSE_EXITING |
> > +            VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
> > +        .features[FEAT_VMX_SECONDARY_CTLS] =
> > +            VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
> > +            VMX_SECONDARY_EXEC_ENABLE_EPT | VMX_SECONDARY_EXEC_DESC |
> > +            VMX_SECONDARY_EXEC_RDTSCP |
> > +            VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
> > +            VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_WBINVD_EXITING |
> > +            VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
> > +            VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
> > +            VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
> > +            VMX_SECONDARY_EXEC_RDRAND_EXITING |
> > +            VMX_SECONDARY_EXEC_ENABLE_INVPCID |
> > +            VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
> > +            VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML |
> > +            VMX_SECONDARY_EXEC_XSAVES,
> > +        .features[FEAT_VMX_VMFUNC] =
> > +            MSR_VMX_VMFUNC_EPT_SWITCHING,
> > +        .xlevel = 0x80000008,
> > +        .model_id = "Intel Xeon Processor (GraniteRapids)",
> > +        .versions = (X86CPUVersionDefinition[]) {
> > +            { .version = 1 },
> > +            { /* end of list */ },
> > +        },
> > +    },
> >      {
> >          .name = "Denverton",
> >          .level = 21,
> 

