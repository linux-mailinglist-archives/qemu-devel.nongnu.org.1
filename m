Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A65A189AB
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Jan 2025 02:45:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taPnd-0002zj-3r; Tue, 21 Jan 2025 20:44:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1taPna-0002zH-8s
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 20:44:54 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1taPnX-0005Mq-Rc
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 20:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737510292; x=1769046292;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=BDes4S4T+m8rZmpSSMmH231Xx4BRxeie4y5zzpggwn4=;
 b=FqhoAGeAYLF3+wY8Yijm7bVO1yKY1GmPic/0TiO+QUODD3f/7Fbt6Ydd
 7hDxUJU+rF5oU5dGB8s6q7nVnEyloNMwu/wvZ3AvzXFfFbNMM7TeqahGI
 P5+0CToeFg41vkUuwDct5vPB5x+5cuV/ARowkrrIKuOlIuElrahMikJMi
 dG5aWv2PBHgG1/E4EQurjJkl/6qvVI6l1P1/6tJMJUCbY00b6TptD0aXF
 wO2T8AVK7RyRzDtn3zfdrNh2WceI7l9VpxMJrKGk0tFRCVp4nZoW7gUwi
 oYsyqJwHTFvpm08dOe2velzt/K8n0j33QHm0j70yk9zeC2IkvLlj70gtm g==;
X-CSE-ConnectionGUID: 6//zIK4qR5C/1PAm46rxfQ==
X-CSE-MsgGUID: tB33H0x+QNGOlaGMOsUiIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="38203955"
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; d="scan'208";a="38203955"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 17:44:50 -0800
X-CSE-ConnectionGUID: dblUstKxRcyWdLAzcoop7g==
X-CSE-MsgGUID: eSHpeEROQcWze941enIXWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; d="scan'208";a="107590281"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 17:44:49 -0800
Message-ID: <edc993ac-7e05-4792-bc68-b5d438dfa6af@intel.com>
Date: Wed, 22 Jan 2025 09:44:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] target/i386: Add new CPU model ClearwaterForest
To: Tao Su <tao1.su@linux.intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, imammedo@redhat.com, zhao1.liu@linux.intel.com,
 xuelian.guo@intel.com
References: <20250121020650.1899618-1-tao1.su@linux.intel.com>
 <20250121020650.1899618-4-tao1.su@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250121020650.1899618-4-tao1.su@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/21/2025 10:06 AM, Tao Su wrote:
> According to table 1-2 in Intel Architecture Instruction Set Extensions
> and Future Features (rev 056) [1], ClearwaterForest has the following new
> features which have already been virtualized:
> 
>      - AVX-VNNI-INT16 CPUID.(EAX=7,ECX=1):EDX[bit 10]
>      - SHA512 CPUID.(EAX=7,ECX=1):EAX[bit 0]
>      - SM3 CPUID.(EAX=7,ECX=1):EAX[bit 1]
>      - SM4 CPUID.(EAX=7,ECX=1):EAX[bit 2]
> 
> Add above features to new CPU model ClearwaterForest. Comparing with
> SierraForest, ClearwaterForest bare-metal contains all features of
> SierraForest-v2 CPU model and adds:
> 
>      - PREFETCHI CPUID.(EAX=7,ECX=1):EDX[bit 14]
>      - DDPD_U CPUID.(EAX=7,ECX=2):EDX[bit 3]
>      - BHI_NO IA32_ARCH_CAPABILITIES[bit 20]
> 
> Add above and all features of SierraForest-v2 CPU model to new CPU model
> ClearwaterForest.
> 
> [1] https://cdrdv2.intel.com/v1/dl/getContent/671368
> 
> Tested-by: Xuelian Guo <xuelian.guo@intel.com>
> Signed-off-by: Tao Su <tao1.su@linux.intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   target/i386/cpu.c | 135 ++++++++++++++++++++++++++++++++++++++++++++++
>   target/i386/cpu.h |  33 +++++++++---
>   2 files changed, 162 insertions(+), 6 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 33fb27a611..b5dd60d281 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4571,6 +4571,141 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>               { /* end of list */ },
>           },
>       },
> +    {
> +        .name = "ClearwaterForest",
> +        .level = 0x23,
> +        .xlevel = 0x80000008,
> +        .vendor = CPUID_VENDOR_INTEL,
> +        .family = 6,
> +        .model = 221,
> +        .stepping = 0,
> +        /*
> +         * please keep the ascending order so that we can have a clear view of
> +         * bit position of each feature.
> +         */
> +        .features[FEAT_1_EDX] =
> +            CPUID_FP87 | CPUID_VME | CPUID_DE | CPUID_PSE | CPUID_TSC |
> +            CPUID_MSR | CPUID_PAE | CPUID_MCE | CPUID_CX8 | CPUID_APIC |
> +            CPUID_SEP | CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV |
> +            CPUID_PAT | CPUID_PSE36 | CPUID_CLFLUSH | CPUID_MMX | CPUID_FXSR |
> +            CPUID_SSE | CPUID_SSE2 | CPUID_SS,
> +        .features[FEAT_1_ECX] =
> +            CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSSE3 |
> +            CPUID_EXT_FMA | CPUID_EXT_CX16 | CPUID_EXT_PCID | CPUID_EXT_SSE41 |
> +            CPUID_EXT_SSE42 | CPUID_EXT_X2APIC | CPUID_EXT_MOVBE |
> +            CPUID_EXT_POPCNT | CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_AES |
> +            CPUID_EXT_XSAVE | CPUID_EXT_AVX | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
> +        .features[FEAT_8000_0001_EDX] =
> +            CPUID_EXT2_SYSCALL | CPUID_EXT2_NX | CPUID_EXT2_PDPE1GB |
> +            CPUID_EXT2_RDTSCP | CPUID_EXT2_LM,
> +        .features[FEAT_8000_0001_ECX] =
> +            CPUID_EXT3_LAHF_LM | CPUID_EXT3_ABM | CPUID_EXT3_3DNOWPREFETCH,
> +        .features[FEAT_8000_0008_EBX] =
> +            CPUID_8000_0008_EBX_WBNOINVD,
> +        .features[FEAT_7_0_EBX] =
> +            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_TSC_ADJUST |
> +            CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
> +            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
> +            CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_SMAP |
> +            CPUID_7_0_EBX_CLFLUSHOPT | CPUID_7_0_EBX_CLWB |
> +            CPUID_7_0_EBX_SHA_NI,
> +        .features[FEAT_7_0_ECX] =
> +            CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU | CPUID_7_0_ECX_GFNI |
> +            CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
> +            CPUID_7_0_ECX_RDPID | CPUID_7_0_ECX_BUS_LOCK_DETECT |
> +            CPUID_7_0_ECX_CLDEMOTE | CPUID_7_0_ECX_MOVDIRI |
> +            CPUID_7_0_ECX_MOVDIR64B,
> +        .features[FEAT_7_0_EDX] =
> +            CPUID_7_0_EDX_FSRM | CPUID_7_0_EDX_SERIALIZE |
> +            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_ARCH_CAPABILITIES |
> +            CPUID_7_0_EDX_SPEC_CTRL_SSBD,
> +        .features[FEAT_ARCH_CAPABILITIES] =
> +            MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_IBRS_ALL |
> +            MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY | MSR_ARCH_CAP_MDS_NO |
> +            MSR_ARCH_CAP_PSCHANGE_MC_NO | MSR_ARCH_CAP_SBDR_SSDP_NO |
> +            MSR_ARCH_CAP_FBSDP_NO | MSR_ARCH_CAP_PSDP_NO |
> +            MSR_ARCH_CAP_BHI_NO | MSR_ARCH_CAP_PBRSB_NO |
> +            MSR_ARCH_CAP_GDS_NO | MSR_ARCH_CAP_RFDS_NO,
> +        .features[FEAT_XSAVE] =
> +            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
> +            CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES,
> +        .features[FEAT_6_EAX] =
> +            CPUID_6_EAX_ARAT,
> +        .features[FEAT_7_1_EAX] =
> +            CPUID_7_1_EAX_SHA512 | CPUID_7_1_EAX_SM3 | CPUID_7_1_EAX_SM4 |
> +            CPUID_7_1_EAX_AVX_VNNI | CPUID_7_1_EAX_CMPCCXADD |
> +            CPUID_7_1_EAX_FSRS | CPUID_7_1_EAX_AVX_IFMA |
> +            CPUID_7_1_EAX_LAM,
> +        .features[FEAT_7_1_EDX] =
> +            CPUID_7_1_EDX_AVX_VNNI_INT8 | CPUID_7_1_EDX_AVX_NE_CONVERT |
> +            CPUID_7_1_EDX_AVX_VNNI_INT16 | CPUID_7_1_EDX_PREFETCHITI,
> +        .features[FEAT_7_2_EDX] =
> +            CPUID_7_2_EDX_PSFD | CPUID_7_2_EDX_IPRED_CTRL |
> +            CPUID_7_2_EDX_RRSBA_CTRL | CPUID_7_2_EDX_DDPD_U |
> +            CPUID_7_2_EDX_BHI_CTRL | CPUID_7_2_EDX_MCDT_NO,
> +        .features[FEAT_VMX_BASIC] =
> +            MSR_VMX_BASIC_INS_OUTS | MSR_VMX_BASIC_TRUE_CTLS,
> +        .features[FEAT_VMX_ENTRY_CTLS] =
> +            VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_IA32E_MODE |
> +            VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
> +            VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
> +        .features[FEAT_VMX_EPT_VPID_CAPS] =
> +            MSR_VMX_EPT_EXECONLY | MSR_VMX_EPT_PAGE_WALK_LENGTH_4 |
> +            MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB | MSR_VMX_EPT_1GB |
> +            MSR_VMX_EPT_INVEPT | MSR_VMX_EPT_AD_BITS |
> +            MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
> +            MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
> +            MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT |
> +            MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
> +            MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
> +        .features[FEAT_VMX_EXIT_CTLS] =
> +            VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
> +            VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
> +            VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_IA32_PAT |
> +            VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
> +            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
> +        .features[FEAT_VMX_MISC] =
> +            MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_ACTIVITY_HLT |
> +            MSR_VMX_MISC_VMWRITE_VMEXIT,
> +        .features[FEAT_VMX_PINBASED_CTLS] =
> +            VMX_PIN_BASED_EXT_INTR_MASK | VMX_PIN_BASED_NMI_EXITING |
> +            VMX_PIN_BASED_VIRTUAL_NMIS | VMX_PIN_BASED_VMX_PREEMPTION_TIMER |
> +            VMX_PIN_BASED_POSTED_INTR,
> +        .features[FEAT_VMX_PROCBASED_CTLS] =
> +            VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
> +            VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
> +            VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
> +            VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
> +            VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
> +            VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
> +            VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_VIRTUAL_NMI_PENDING |
> +            VMX_CPU_BASED_MOV_DR_EXITING | VMX_CPU_BASED_UNCOND_IO_EXITING |
> +            VMX_CPU_BASED_USE_IO_BITMAPS | VMX_CPU_BASED_MONITOR_TRAP_FLAG |
> +            VMX_CPU_BASED_USE_MSR_BITMAPS | VMX_CPU_BASED_MONITOR_EXITING |
> +            VMX_CPU_BASED_PAUSE_EXITING |
> +            VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
> +        .features[FEAT_VMX_SECONDARY_CTLS] =
> +            VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
> +            VMX_SECONDARY_EXEC_ENABLE_EPT | VMX_SECONDARY_EXEC_DESC |
> +            VMX_SECONDARY_EXEC_RDTSCP |
> +            VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
> +            VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_WBINVD_EXITING |
> +            VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
> +            VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
> +            VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
> +            VMX_SECONDARY_EXEC_RDRAND_EXITING |
> +            VMX_SECONDARY_EXEC_ENABLE_INVPCID |
> +            VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
> +            VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML |
> +            VMX_SECONDARY_EXEC_XSAVES,
> +        .features[FEAT_VMX_VMFUNC] =
> +            MSR_VMX_VMFUNC_EPT_SWITCHING,
> +        .model_id = "Intel Xeon Processor (ClearwaterForest)",
> +        .versions = (X86CPUVersionDefinition[]) {
> +            { .version = 1 },
> +            { /* end of list */ },
> +        },
> +    },
>       {
>           .name = "Denverton",
>           .level = 21,
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index b26e25ba15..c67b42d34f 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -951,6 +951,12 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>   /* Speculative Store Bypass Disable */
>   #define CPUID_7_0_EDX_SPEC_CTRL_SSBD    (1U << 31)
>   
> +/* SHA512 Instruction */
> +#define CPUID_7_1_EAX_SHA512            (1U << 0)
> +/* SM3 Instruction */
> +#define CPUID_7_1_EAX_SM3               (1U << 1)
> +/* SM4 Instruction */
> +#define CPUID_7_1_EAX_SM4               (1U << 2)
>   /* AVX VNNI Instruction */
>   #define CPUID_7_1_EAX_AVX_VNNI          (1U << 4)
>   /* AVX512 BFloat16 Instruction */
> @@ -963,6 +969,12 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>   #define CPUID_7_1_EAX_FSRS              (1U << 11)
>   /* Fast Short REP CMPS/SCAS */
>   #define CPUID_7_1_EAX_FSRC              (1U << 12)
> +/* Flexible return and event delivery (FRED) */
> +#define CPUID_7_1_EAX_FRED              (1U << 17)
> +/* Load into IA32_KERNEL_GS_BASE (LKGS) */
> +#define CPUID_7_1_EAX_LKGS              (1U << 18)
> +/* Non-Serializing Write to Model Specific Register (WRMSRNS) */
> +#define CPUID_7_1_EAX_WRMSRNS           (1U << 19)
>   /* Support Tile Computational Operations on FP16 Numbers */
>   #define CPUID_7_1_EAX_AMX_FP16          (1U << 21)
>   /* Support for VPMADD52[H,L]UQ */
> @@ -976,17 +988,23 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>   #define CPUID_7_1_EDX_AVX_NE_CONVERT    (1U << 5)
>   /* AMX COMPLEX Instructions */
>   #define CPUID_7_1_EDX_AMX_COMPLEX       (1U << 8)
> +/* AVX-VNNI-INT16 Instructions */
> +#define CPUID_7_1_EDX_AVX_VNNI_INT16    (1U << 10)
>   /* PREFETCHIT0/1 Instructions */
>   #define CPUID_7_1_EDX_PREFETCHITI       (1U << 14)
>   /* Support for Advanced Vector Extensions 10 */
>   #define CPUID_7_1_EDX_AVX10             (1U << 19)
> -/* Flexible return and event delivery (FRED) */
> -#define CPUID_7_1_EAX_FRED              (1U << 17)
> -/* Load into IA32_KERNEL_GS_BASE (LKGS) */
> -#define CPUID_7_1_EAX_LKGS              (1U << 18)
> -/* Non-Serializing Write to Model Specific Register (WRMSRNS) */
> -#define CPUID_7_1_EAX_WRMSRNS           (1U << 19)
>   
> +/* Indicate bit 7 of the IA32_SPEC_CTRL MSR is supported */
> +#define CPUID_7_2_EDX_PSFD              (1U << 0)
> +/* Indicate bits 3 and 4 of the IA32_SPEC_CTRL MSR are supported */
> +#define CPUID_7_2_EDX_IPRED_CTRL        (1U << 1)
> +/* Indicate bits 5 and 6 of the IA32_SPEC_CTRL MSR are supported */
> +#define CPUID_7_2_EDX_RRSBA_CTRL        (1U << 2)
> +/* Indicate bit 8 of the IA32_SPEC_CTRL MSR is supported */
> +#define CPUID_7_2_EDX_DDPD_U            (1U << 3)
> +/* Indicate bit 10 of the IA32_SPEC_CTRL MSR is supported */
> +#define CPUID_7_2_EDX_BHI_CTRL          (1U << 4)
>   /* Do not exhibit MXCSR Configuration Dependent Timing (MCDT) behavior */
>   #define CPUID_7_2_EDX_MCDT_NO           (1U << 5)
>   
> @@ -1144,7 +1162,10 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>   #define MSR_ARCH_CAP_FBSDP_NO           (1U << 14)
>   #define MSR_ARCH_CAP_PSDP_NO            (1U << 15)
>   #define MSR_ARCH_CAP_FB_CLEAR           (1U << 17)
> +#define MSR_ARCH_CAP_BHI_NO             (1U << 20)
>   #define MSR_ARCH_CAP_PBRSB_NO           (1U << 24)
> +#define MSR_ARCH_CAP_GDS_NO             (1U << 26)
> +#define MSR_ARCH_CAP_RFDS_NO            (1U << 27)
>   
>   #define MSR_CORE_CAP_SPLIT_LOCK_DETECT  (1U << 5)
>   


