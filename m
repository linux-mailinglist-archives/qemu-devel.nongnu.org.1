Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0570475B120
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 16:21:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMUVu-0000yP-Lk; Thu, 20 Jul 2023 10:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1qMUVX-0000sv-O4
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 10:19:57 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1qMUVV-0004eq-O5
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 10:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689862793; x=1721398793;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=M/a3wHNklegTy0CnAtcx63Fey327xDt1/DhN1RH7MDU=;
 b=QAc0QxJ/z47Y9l7uf7P1OmOl7B5dRRwJ3xhA8GAzJFdTIGsAUe8j28mI
 DuEUSbgNoeKbHh24RkIB/3wUXUA1srJ/e/KNP0f2RfSQi0t0S9+0F4Kr3
 F+zQY9OWmW3uwkd8Y97xLyantlUGN4JKd2jc0p758kS04l3z9fiwFlVQ0
 JGz3CPv0UMTHPTO3umSc6NB2prjdm2ZfVsyjmY4hnt8ORneYhATAtBuX6
 DLDhhqN9sRkKPw33pXeN5WwBxANJiIsON1bdAWaynod//b/I0gYky/4Yb
 bAPHPkg3T3FBgYwRl+TMqumcm/cS9XIUdvjdZiJnC+JGqBSPp7CyQhsTF g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="397629163"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; d="scan'208";a="397629163"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2023 07:19:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="898295622"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; d="scan'208";a="898295622"
Received: from embargo.jf.intel.com ([10.165.9.183])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2023 07:19:29 -0700
From: Yang Weijiang <weijiang.yang@intel.com>
To: pbonzini@redhat.com, mtosatti@redhat.com, seanjc@google.com,
 qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	weijiang.yang@intel.com
Subject: [PATCH v2 2/4] target/i386: Add CET MSRs access interface
Date: Thu, 20 Jul 2023 07:14:43 -0400
Message-Id: <20230720111445.99509-3-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230720111445.99509-1-weijiang.yang@intel.com>
References: <20230720111445.99509-1-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.88;
 envelope-from=weijiang.yang@intel.com; helo=mga01.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

CET MSRs include:
MSR_IA32_U_CET - user mode CET control bits.
MSR_IA32_S_CET - supervisor mode CET control bits.
MSR_IA32_PL{0,1,2,3}_SSP - linear addresses of SSPs for user/kernel modes.
MSR_IA32_SSP_TBL_ADDR - linear address of interrupt SSP table
MSR_KVM_GUEST_SSP - current shadow stack pointer

Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 target/i386/cpu.h     | 18 +++++++++++++
 target/i386/kvm/kvm.c | 59 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 06855e0926..ef1f3d6138 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -545,6 +545,15 @@ typedef enum X86Seg {
 #define MSR_IA32_VMX_TRUE_ENTRY_CTLS     0x00000490
 #define MSR_IA32_VMX_VMFUNC             0x00000491
 
+#define MSR_IA32_U_CET                  0x000006a0
+#define MSR_IA32_S_CET                  0x000006a2
+#define MSR_IA32_PL0_SSP                0x000006a4
+#define MSR_IA32_PL1_SSP                0x000006a5
+#define MSR_IA32_PL2_SSP                0x000006a6
+#define MSR_IA32_PL3_SSP                0x000006a7
+#define MSR_IA32_SSP_TBL_ADDR           0x000006a8
+#define MSR_KVM_GUEST_SSP               0x4b564d09
+
 #define XSTATE_FP_BIT                   0
 #define XSTATE_SSE_BIT                  1
 #define XSTATE_YMM_BIT                  2
@@ -1766,6 +1775,15 @@ typedef struct CPUArchState {
 
     uintptr_t retaddr;
 
+    uint64_t u_cet;
+    uint64_t s_cet;
+    uint64_t pl0_ssp;
+    uint64_t pl1_ssp;
+    uint64_t pl2_ssp;
+    uint64_t pl3_ssp;
+    uint64_t ssp_table_addr;
+    uint64_t guest_ssp;
+
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index de531842f6..ab3a755b97 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3591,6 +3591,24 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
                               env->msr_ia32_sgxlepubkeyhash[3]);
         }
 
+        if ((env->features[FEAT_XSAVE_XSS_LO] & XSTATE_CET_U_MASK) &&
+            (env->features[FEAT_XSAVE_XSS_LO] & XSTATE_CET_S_MASK)) {
+            if (env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK) {
+                kvm_msr_entry_add(cpu, MSR_IA32_U_CET, env->u_cet);
+                kvm_msr_entry_add(cpu, MSR_IA32_S_CET, env->s_cet);
+                kvm_msr_entry_add(cpu, MSR_KVM_GUEST_SSP, env->guest_ssp);
+                kvm_msr_entry_add(cpu, MSR_IA32_PL0_SSP, env->pl0_ssp);
+                kvm_msr_entry_add(cpu, MSR_IA32_PL1_SSP, env->pl1_ssp);
+                kvm_msr_entry_add(cpu, MSR_IA32_PL2_SSP, env->pl2_ssp);
+                kvm_msr_entry_add(cpu, MSR_IA32_PL3_SSP, env->pl3_ssp);
+                kvm_msr_entry_add(cpu, MSR_IA32_SSP_TBL_ADDR,
+                                  env->ssp_table_addr);
+            } else if (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_CET_IBT) {
+                kvm_msr_entry_add(cpu, MSR_IA32_U_CET, env->u_cet);
+                kvm_msr_entry_add(cpu, MSR_IA32_S_CET, env->s_cet);
+            }
+        }
+
         if (env->features[FEAT_XSAVE] & CPUID_D_1_EAX_XFD) {
             kvm_msr_entry_add(cpu, MSR_IA32_XFD,
                               env->msr_xfd);
@@ -4024,6 +4042,23 @@ static int kvm_get_msrs(X86CPU *cpu)
         kvm_msr_entry_add(cpu, MSR_IA32_SGXLEPUBKEYHASH3, 0);
     }
 
+    if ((env->features[FEAT_XSAVE_XSS_LO] & XSTATE_CET_U_MASK) &&
+        (env->features[FEAT_XSAVE_XSS_LO] & XSTATE_CET_S_MASK)) {
+            if (env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK) {
+                kvm_msr_entry_add(cpu, MSR_IA32_U_CET, 0);
+                kvm_msr_entry_add(cpu, MSR_IA32_S_CET, 0);
+                kvm_msr_entry_add(cpu, MSR_KVM_GUEST_SSP, 0);
+                kvm_msr_entry_add(cpu, MSR_IA32_PL0_SSP, 0);
+                kvm_msr_entry_add(cpu, MSR_IA32_PL1_SSP, 0);
+                kvm_msr_entry_add(cpu, MSR_IA32_PL2_SSP, 0);
+                kvm_msr_entry_add(cpu, MSR_IA32_PL3_SSP, 0);
+                kvm_msr_entry_add(cpu, MSR_IA32_SSP_TBL_ADDR, 0);
+             } else if (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_CET_IBT) {
+                kvm_msr_entry_add(cpu, MSR_IA32_U_CET, 0);
+                kvm_msr_entry_add(cpu, MSR_IA32_S_CET, 0);
+            }
+    }
+
     if (env->features[FEAT_XSAVE] & CPUID_D_1_EAX_XFD) {
         kvm_msr_entry_add(cpu, MSR_IA32_XFD, 0);
         kvm_msr_entry_add(cpu, MSR_IA32_XFD_ERR, 0);
@@ -4346,6 +4381,30 @@ static int kvm_get_msrs(X86CPU *cpu)
             env->msr_ia32_sgxlepubkeyhash[index - MSR_IA32_SGXLEPUBKEYHASH0] =
                            msrs[i].data;
             break;
+        case MSR_IA32_U_CET:
+            env->u_cet = msrs[i].data;
+            break;
+        case MSR_IA32_S_CET:
+            env->s_cet = msrs[i].data;
+            break;
+        case MSR_KVM_GUEST_SSP:
+            env->guest_ssp = msrs[i].data;
+            break;
+        case MSR_IA32_PL0_SSP:
+            env->pl0_ssp = msrs[i].data;
+            break;
+        case MSR_IA32_PL1_SSP:
+            env->pl1_ssp = msrs[i].data;
+            break;
+        case MSR_IA32_PL2_SSP:
+            env->pl2_ssp = msrs[i].data;
+            break;
+        case MSR_IA32_PL3_SSP:
+            env->pl3_ssp = msrs[i].data;
+            break;
+        case MSR_IA32_SSP_TBL_ADDR:
+            env->ssp_table_addr = msrs[i].data;
+            break;
         case MSR_IA32_XFD:
             env->msr_xfd = msrs[i].data;
             break;
-- 
2.27.0


