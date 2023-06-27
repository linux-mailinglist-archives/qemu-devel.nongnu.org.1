Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8368F73FB7D
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 13:55:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7IQ-0007Nb-Pm; Tue, 27 Jun 2023 07:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qE7IA-0007JI-Ha
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:55:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qE7I8-0005iA-P0
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687866927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uiehOqnapi77jmCBfrKLaVOdgtJ4jiIpXljNT564ET4=;
 b=WdP1j7X+3jmDZdM9lXIkgBsQVYEPMQgjTKcwEzBimdRnEgjdx6rTMfaGfWZCuuj/PoDl3j
 W2Ts0sOCfn0LgeBb5jbv33H5pXJQUk/oJdbnReg1SRojP1QPseEOcuNTZQmiq3n6fxHtLE
 ff5FA3eiix84i6ijdWRW0VsQ3SYem/8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-KDk2sxhLPV2izZvmuYNiXA-1; Tue, 27 Jun 2023 07:55:26 -0400
X-MC-Unique: KDk2sxhLPV2izZvmuYNiXA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-98e40d91fdfso238785966b.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 04:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687866924; x=1690458924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uiehOqnapi77jmCBfrKLaVOdgtJ4jiIpXljNT564ET4=;
 b=UJ1yOxCXwvHL8HOLrHHafPxzRKst9cLIyjHswQklrHZ4Zq4zjGu/TIA/CULd5CgpfI
 cOFU246OIVSmbmfPSy8m4e+zhJfYayqnyyi+QK371xJpDi/cqJkhZvgElLevClzx+5WA
 pJ6LE34WfQilv3bvxoeL1WXUXDvEkAGX8tDoYnOuJm/TEgvC+rXfODa47ZR/XRcSxR2I
 o27hAUBDsPhAO+F0VM9yGuN0tjBeGhpt0uGKdiFnYJvima7gK3QU3izcP97KDF9PNEek
 z1QkDks5tvQPKqa56QM8AkURwlY3eiPdourDixaRscdaGOWxL+3NNoFYwVZyZSuBebEs
 eqcQ==
X-Gm-Message-State: AC+VfDxncC01iIptUf+Qx3BdCxCXb8mxrbIBPuC5sYW4jJ5nGyuuJOBu
 GpQU16sHkY+mQXvVrjsU2KrmLMjb5+sY9P+z1RhK5+TmTF/pu4AF/WFHv7F0jn0B9C2/cT8YmwV
 Ao6Aba9NdA9wwMjMQzyyk7qY=
X-Received: by 2002:a17:906:da8b:b0:982:26c5:6525 with SMTP id
 xh11-20020a170906da8b00b0098226c56525mr31845933ejb.60.1687866924609; 
 Tue, 27 Jun 2023 04:55:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4nVkmdLNS8HvnjVfn1mKMsft1ba7hvLHP3GUEX513Iy5sMlWU4AxeJmj2FEuRFEKPSyVQVvg==
X-Received: by 2002:a17:906:da8b:b0:982:26c5:6525 with SMTP id
 xh11-20020a170906da8b00b0098226c56525mr31845918ejb.60.1687866924289; 
 Tue, 27 Jun 2023 04:55:24 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 gu8-20020a170906f28800b0098f33157e7dsm2820181ejb.82.2023.06.27.04.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 04:55:23 -0700 (PDT)
Date: Tue, 27 Jun 2023 13:55:23 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xiaoyao.li@intel.com,
 lei4.wang@intel.com, qian.wen@intel.com
Subject: Re: [PATCH 7/7] target/i386: Add new CPU model GraniteRapids
Message-ID: <20230627135523.2a68e875@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230616032311.19137-8-tao1.su@linux.intel.com>
References: <20230616032311.19137-1-tao1.su@linux.intel.com>
 <20230616032311.19137-8-tao1.su@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UPPERCASE_75_100=0.001 autolearn=no autolearn_force=no
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

On Fri, 16 Jun 2023 11:23:11 +0800
Tao Su <tao1.su@linux.intel.com> wrote:

> The GraniteRapids CPU model mainly adds the following new features based
> on SapphireRapids:
> 
> - PREFETCHITI CPUID.(EAX=7,ECX=1):EDX[bit 14]
> - AMX-FP16 CPUID.(EAX=7,ECX=1):EAX[bit 21]
> - MCDT_NO CPUID.(EAX=7,ECX=2):EDX[bit 5]
> - SBDR_SSDP_NO MSR_IA32_ARCH_CAPABILITIES[bit 13]
> - FBSDP_NO MSR_IA32_ARCH_CAPABILITIES[bit 14]
> - PSDP_NO MSR_IA32_ARCH_CAPABILITIES[bit 15]
> - PBRSB_NO MSR_IA32_ARCH_CAPABILITIES[bit 24]

Can you point me to a some doc where above features
are are documented as being introduced by GraniteRapids?

 
> Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> Tested-by: Xuelian Guo <xuelian.guo@intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/cpu.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 136 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 7faf6dfaee..860106fc24 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3993,6 +3993,142 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>              { /* end of list */ },
>          },
>      },
> +    {
> +        .name = "GraniteRapids",
> +        .level = 0x20,
> +        .vendor = CPUID_VENDOR_INTEL,
> +        .family = 6,
> +        .model = 173,
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
> +            CPUID_SSE | CPUID_SSE2,
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
> +            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_HLE |
> +            CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 |
> +            CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID | CPUID_7_0_EBX_RTM |
> +            CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
> +            CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_SMAP |
> +            CPUID_7_0_EBX_AVX512IFMA | CPUID_7_0_EBX_CLFLUSHOPT |
> +            CPUID_7_0_EBX_CLWB | CPUID_7_0_EBX_AVX512CD | CPUID_7_0_EBX_SHA_NI |
> +            CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512VL,
> +        .features[FEAT_7_0_ECX] =
> +            CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
> +            CPUID_7_0_ECX_AVX512_VBMI2 | CPUID_7_0_ECX_GFNI |
> +            CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
> +            CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG |
> +            CPUID_7_0_ECX_AVX512_VPOPCNTDQ | CPUID_7_0_ECX_LA57 |
> +            CPUID_7_0_ECX_RDPID | CPUID_7_0_ECX_BUS_LOCK_DETECT,
> +        .features[FEAT_7_0_EDX] =
> +            CPUID_7_0_EDX_FSRM | CPUID_7_0_EDX_SERIALIZE |
> +            CPUID_7_0_EDX_TSX_LDTRK | CPUID_7_0_EDX_AMX_BF16 |
> +            CPUID_7_0_EDX_AVX512_FP16 | CPUID_7_0_EDX_AMX_TILE |
> +            CPUID_7_0_EDX_AMX_INT8 | CPUID_7_0_EDX_SPEC_CTRL |
> +            CPUID_7_0_EDX_ARCH_CAPABILITIES | CPUID_7_0_EDX_SPEC_CTRL_SSBD,
> +        .features[FEAT_ARCH_CAPABILITIES] =
> +            MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_IBRS_ALL |
> +            MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY | MSR_ARCH_CAP_MDS_NO |
> +            MSR_ARCH_CAP_PSCHANGE_MC_NO | MSR_ARCH_CAP_TAA_NO |
> +            MSR_ARCH_CAP_SBDR_SSDP_NO | MSR_ARCH_CAP_FBSDP_NO |
> +            MSR_ARCH_CAP_PSDP_NO | MSR_ARCH_CAP_PBRSB_NO,
> +        .features[FEAT_XSAVE] =
> +            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
> +            CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES | CPUID_D_1_EAX_XFD,
> +        .features[FEAT_6_EAX] =
> +            CPUID_6_EAX_ARAT,
> +        .features[FEAT_7_1_EAX] =
> +            CPUID_7_1_EAX_AVX_VNNI | CPUID_7_1_EAX_AVX512_BF16 |
> +            CPUID_7_1_EAX_FZRM | CPUID_7_1_EAX_FSRS | CPUID_7_1_EAX_FSRC |
> +            CPUID_7_1_EAX_AMX_FP16,
> +        .features[FEAT_7_1_EDX] =
> +            CPUID_7_1_EDX_PREFETCHITI,
> +        .features[FEAT_7_2_EDX] =
> +            CPUID_7_2_EDX_MCDT_NO,
> +        .features[FEAT_VMX_BASIC] =
> +            MSR_VMX_BASIC_INS_OUTS | MSR_VMX_BASIC_TRUE_CTLS,
> +        .features[FEAT_VMX_ENTRY_CTLS] =
> +            VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_IA32E_MODE |
> +            VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
> +            VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
> +        .features[FEAT_VMX_EPT_VPID_CAPS] =
> +            MSR_VMX_EPT_EXECONLY |
> +            MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_PAGE_WALK_LENGTH_5 |
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
> +        .xlevel = 0x80000008,
> +        .model_id = "Intel Xeon Processor (GraniteRapids)",
> +        .versions = (X86CPUVersionDefinition[]) {
> +            { .version = 1 },
> +            { /* end of list */ },
> +        },
> +    },
>      {
>          .name = "Denverton",
>          .level = 21,


