Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 850528AEA6B
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Apr 2024 17:14:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnJ-00058Q-Cn; Tue, 23 Apr 2024 11:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmy-0004Xk-QV
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmu-0000F7-Ve
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UW4YrDtZCX8tDfueSUgjHMV3UH+1CRlAmd0wHJhDTp0=;
 b=F1LsJWtEH3LRzgZeWqoHE+IeR6Ta7KVKzPkLRuCfKzbs5loy6OIpPL8Fe7+w/YnuRPuEQ8
 fgSo2owJT6LD5S8dZ/Z7+Gy7AgP5SIEwkpPPmEL3my+LgGXEnxojq4osiqhs4aaWJqionK
 5BFp8SASCFraWRu58ejusW8zrUIHKmk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-LXctwQejOiO9H97tYUtGmQ-1; Tue, 23 Apr 2024 11:10:24 -0400
X-MC-Unique: LXctwQejOiO9H97tYUtGmQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DF9480253A;
 Tue, 23 Apr 2024 15:10:21 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 731B6200AFA2;
 Tue, 23 Apr 2024 15:10:20 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tao Su <tao1.su@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 27/63] target/i386: Add new CPU model SierraForest
Date: Tue, 23 Apr 2024 17:09:15 +0200
Message-ID: <20240423150951.41600-28-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Tao Su <tao1.su@linux.intel.com>

According to table 1-2 in Intel Architecture Instruction Set Extensions and
Future Features (rev 051) [1], SierraForest has the following new features
which have already been virtualized:

- CMPCCXADD CPUID.(EAX=7,ECX=1):EAX[bit 7]
- AVX-IFMA CPUID.(EAX=7,ECX=1):EAX[bit 23]
- AVX-VNNI-INT8 CPUID.(EAX=7,ECX=1):EDX[bit 4]
- AVX-NE-CONVERT CPUID.(EAX=7,ECX=1):EDX[bit 5]

Add above features to new CPU model SierraForest. Comparing with GraniteRapids
CPU model, SierraForest bare-metal removes the following features:

- HLE CPUID.(EAX=7,ECX=0):EBX[bit 4]
- RTM CPUID.(EAX=7,ECX=0):EBX[bit 11]
- AVX512F CPUID.(EAX=7,ECX=0):EBX[bit 16]
- AVX512DQ CPUID.(EAX=7,ECX=0):EBX[bit 17]
- AVX512_IFMA CPUID.(EAX=7,ECX=0):EBX[bit 21]
- AVX512CD CPUID.(EAX=7,ECX=0):EBX[bit 28]
- AVX512BW CPUID.(EAX=7,ECX=0):EBX[bit 30]
- AVX512VL CPUID.(EAX=7,ECX=0):EBX[bit 31]
- AVX512_VBMI CPUID.(EAX=7,ECX=0):ECX[bit 1]
- AVX512_VBMI2 CPUID.(EAX=7,ECX=0):ECX[bit 6]
- AVX512_VNNI CPUID.(EAX=7,ECX=0):ECX[bit 11]
- AVX512_BITALG CPUID.(EAX=7,ECX=0):ECX[bit 12]
- AVX512_VPOPCNTDQ CPUID.(EAX=7,ECX=0):ECX[bit 14]
- LA57 CPUID.(EAX=7,ECX=0):ECX[bit 16]
- TSXLDTRK CPUID.(EAX=7,ECX=0):EDX[bit 16]
- AMX-BF16 CPUID.(EAX=7,ECX=0):EDX[bit 22]
- AVX512_FP16 CPUID.(EAX=7,ECX=0):EDX[bit 23]
- AMX-TILE CPUID.(EAX=7,ECX=0):EDX[bit 24]
- AMX-INT8 CPUID.(EAX=7,ECX=0):EDX[bit 25]
- AVX512_BF16 CPUID.(EAX=7,ECX=1):EAX[bit 5]
- fast zero-length MOVSB CPUID.(EAX=7,ECX=1):EAX[bit 10]
- fast short CMPSB, SCASB CPUID.(EAX=7,ECX=1):EAX[bit 12]
- AMX-FP16 CPUID.(EAX=7,ECX=1):EAX[bit 21]
- PREFETCHI CPUID.(EAX=7,ECX=1):EDX[bit 14]
- XFD CPUID.(EAX=0xD,ECX=1):EAX[bit 4]
- EPT_PAGE_WALK_LENGTH_5 VMX_EPT_VPID_CAP(0x48c)[bit 7]

Add all features of GraniteRapids CPU model except above features to
SierraForest CPU model.

SierraForest doesn’t support TSX and RTM but supports TAA_NO. When RTM is
not enabled in host, KVM will not report TAA_NO. So, just don't include
TAA_NO in SierraForest CPU model.

[1] https://cdrdv2.intel.com/v1/dl/getContent/671368

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Message-ID: <20240320021044.508263-1-tao1.su@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 126 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3f4b1214683..c295491d8ae 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4109,6 +4109,132 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             { /* end of list */ },
         },
     },
+    {
+        .name = "SierraForest",
+        .level = 0x23,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 175,
+        .stepping = 0,
+        /*
+         * please keep the ascending order so that we can have a clear view of
+         * bit position of each feature.
+         */
+        .features[FEAT_1_EDX] =
+            CPUID_FP87 | CPUID_VME | CPUID_DE | CPUID_PSE | CPUID_TSC |
+            CPUID_MSR | CPUID_PAE | CPUID_MCE | CPUID_CX8 | CPUID_APIC |
+            CPUID_SEP | CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV |
+            CPUID_PAT | CPUID_PSE36 | CPUID_CLFLUSH | CPUID_MMX | CPUID_FXSR |
+            CPUID_SSE | CPUID_SSE2,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSSE3 |
+            CPUID_EXT_FMA | CPUID_EXT_CX16 | CPUID_EXT_PCID | CPUID_EXT_SSE41 |
+            CPUID_EXT_SSE42 | CPUID_EXT_X2APIC | CPUID_EXT_MOVBE |
+            CPUID_EXT_POPCNT | CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_AES |
+            CPUID_EXT_XSAVE | CPUID_EXT_AVX | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_SYSCALL | CPUID_EXT2_NX | CPUID_EXT2_PDPE1GB |
+            CPUID_EXT2_RDTSCP | CPUID_EXT2_LM,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_LAHF_LM | CPUID_EXT3_ABM | CPUID_EXT3_3DNOWPREFETCH,
+        .features[FEAT_8000_0008_EBX] =
+            CPUID_8000_0008_EBX_WBNOINVD,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
+            CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS |
+            CPUID_7_0_EBX_INVPCID | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
+            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLFLUSHOPT | CPUID_7_0_EBX_CLWB |
+            CPUID_7_0_EBX_SHA_NI,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU | CPUID_7_0_ECX_GFNI |
+            CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
+            CPUID_7_0_ECX_RDPID | CPUID_7_0_ECX_BUS_LOCK_DETECT,
+        .features[FEAT_7_0_EDX] =
+            CPUID_7_0_EDX_FSRM | CPUID_7_0_EDX_SERIALIZE |
+            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_ARCH_CAPABILITIES |
+            CPUID_7_0_EDX_SPEC_CTRL_SSBD,
+        .features[FEAT_ARCH_CAPABILITIES] =
+            MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_IBRS_ALL |
+            MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY | MSR_ARCH_CAP_MDS_NO |
+            MSR_ARCH_CAP_PSCHANGE_MC_NO | MSR_ARCH_CAP_SBDR_SSDP_NO |
+            MSR_ARCH_CAP_FBSDP_NO | MSR_ARCH_CAP_PSDP_NO |
+            MSR_ARCH_CAP_PBRSB_NO,
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .features[FEAT_7_1_EAX] =
+            CPUID_7_1_EAX_AVX_VNNI | CPUID_7_1_EAX_CMPCCXADD |
+            CPUID_7_1_EAX_FSRS | CPUID_7_1_EAX_AVX_IFMA,
+        .features[FEAT_7_1_EDX] =
+            CPUID_7_1_EDX_AVX_VNNI_INT8 | CPUID_7_1_EDX_AVX_NE_CONVERT,
+        .features[FEAT_7_2_EDX] =
+            CPUID_7_2_EDX_MCDT_NO,
+        .features[FEAT_VMX_BASIC] =
+            MSR_VMX_BASIC_INS_OUTS | MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] =
+            VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_IA32E_MODE |
+            VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
+            VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] =
+            MSR_VMX_EPT_EXECONLY | MSR_VMX_EPT_PAGE_WALK_LENGTH_4 |
+            MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB | MSR_VMX_EPT_1GB |
+            MSR_VMX_EPT_INVEPT | MSR_VMX_EPT_AD_BITS |
+            MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+            MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+            MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT |
+            MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+            MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+            VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+            VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+            VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_IA32_PAT |
+            VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] =
+            MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_ACTIVITY_HLT |
+            MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] =
+            VMX_PIN_BASED_EXT_INTR_MASK | VMX_PIN_BASED_NMI_EXITING |
+            VMX_PIN_BASED_VIRTUAL_NMIS | VMX_PIN_BASED_VMX_PREEMPTION_TIMER |
+            VMX_PIN_BASED_POSTED_INTR,
+        .features[FEAT_VMX_PROCBASED_CTLS] =
+            VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+            VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+            VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+            VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+            VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+            VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+            VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_VIRTUAL_NMI_PENDING |
+            VMX_CPU_BASED_MOV_DR_EXITING | VMX_CPU_BASED_UNCOND_IO_EXITING |
+            VMX_CPU_BASED_USE_IO_BITMAPS | VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+            VMX_CPU_BASED_USE_MSR_BITMAPS | VMX_CPU_BASED_MONITOR_EXITING |
+            VMX_CPU_BASED_PAUSE_EXITING |
+            VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+            VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+            VMX_SECONDARY_EXEC_ENABLE_EPT | VMX_SECONDARY_EXEC_DESC |
+            VMX_SECONDARY_EXEC_RDTSCP |
+            VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+            VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_WBINVD_EXITING |
+            VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+            VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+            VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+            VMX_SECONDARY_EXEC_RDRAND_EXITING |
+            VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+            VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
+            VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML |
+            VMX_SECONDARY_EXEC_XSAVES,
+        .features[FEAT_VMX_VMFUNC] =
+            MSR_VMX_VMFUNC_EPT_SWITCHING,
+        .xlevel = 0x80000008,
+        .model_id = "Intel Xeon Processor (SierraForest)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            { /* end of list */ },
+        },
+    },
     {
         .name = "Denverton",
         .level = 21,
-- 
2.44.0



