Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDBD78F84A
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 08:00:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbxC3-0003ul-V3; Fri, 01 Sep 2023 01:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1qbxC1-0003mf-KT
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 01:59:41 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1qbxBz-0003Xk-1D
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 01:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693547978; x=1725083978;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=P4dZkvuV0tYhJwKydOtUzePt0LTMzJINaIN3aOdzRXI=;
 b=WP31XDNZpQwCw6UfYRfRFVCOA2YgnBShhxLtwYeSC8rcAOD0M1TkLniq
 p2d4KIh/avOvmponDJPd0zupQvCsHT8Q55A9YriUNl8NqsqTGVDZUfmYu
 PKLvNRZ4350Qf0gtF2ns19Er1g4yDkZR7dYyKcktay4a180IPXYi8tsnw
 YcLqDkAszLFGNBWXc8Ym9g2bbOjuolutTQsEv04lLuY+7sH5AghCMGQE2
 1uMOrk3uqz4e7nvTq5o9W2ybgXbeGZ/gmtLDlhKiewV8zEFef7i0/S5hL
 gLK0lG6kSrTHz1FltKpKFyBNVPV0X8anJtkwe5AnL7czgrVg2M6t3spZN w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="356456646"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; d="scan'208";a="356456646"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2023 22:59:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="739816171"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; d="scan'208";a="739816171"
Received: from unknown (HELO fred..) ([172.25.112.68])
 by orsmga002.jf.intel.com with ESMTP; 31 Aug 2023 22:59:26 -0700
From: Xin Li <xin3.li@intel.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, seanjc@google.com,
 chao.gao@intel.com, hpa@zytor.com, xiaoyao.li@intel.com,
 weijiang.yang@intel.com
Subject: [PATCH 4/4] target/i386: add live migration support for FRED
Date: Thu, 31 Aug 2023 22:30:22 -0700
Message-Id: <20230901053022.18672-5-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901053022.18672-1-xin3.li@intel.com>
References: <20230901053022.18672-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.151; envelope-from=xin3.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

FRED CPU states are managed in 10 FRED MSRs, in addtion to a few existing
CPU registers and MSRs, e.g., the CR4.FRED bit.

Add the 10 new FRED MSRs to x86 CPUArchState for live migration support.

Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 target/i386/cpu.h     | 24 +++++++++++++++++++
 target/i386/kvm/kvm.c | 54 +++++++++++++++++++++++++++++++++++++++++++
 target/i386/machine.c | 10 ++++++++
 3 files changed, 88 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 924819a64c..a36a1a58c4 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -529,6 +529,20 @@ typedef enum X86Seg {
 #define MSR_IA32_XFD                    0x000001c4
 #define MSR_IA32_XFD_ERR                0x000001c5
 
+#define MSR_IA32_PL0_SSP                0x000006a4       /* Stack level 0 shadow stack pointer in ring 0 */
+
+/* FRED MSRs */
+#define MSR_IA32_FRED_RSP0              0x000001cc       /* Stack level 0 regular stack pointer */
+#define MSR_IA32_FRED_RSP1              0x000001cd       /* Stack level 1 regular stack pointer */
+#define MSR_IA32_FRED_RSP2              0x000001ce       /* Stack level 2 regular stack pointer */
+#define MSR_IA32_FRED_RSP3              0x000001cf       /* Stack level 3 regular stack pointer */
+#define MSR_IA32_FRED_STKLVLS           0x000001d0       /* FRED exception stack levels */
+#define MSR_IA32_FRED_SSP0              MSR_IA32_PL0_SSP /* Stack level 0 shadow stack pointer in ring 0 */
+#define MSR_IA32_FRED_SSP1              0x000001d1       /* Stack level 1 shadow stack pointer in ring 0 */
+#define MSR_IA32_FRED_SSP2              0x000001d2       /* Stack level 2 shadow stack pointer in ring 0 */
+#define MSR_IA32_FRED_SSP3              0x000001d3       /* Stack level 3 shadow stack pointer in ring 0 */
+#define MSR_IA32_FRED_CONFIG            0x000001d4       /* FRED Entrypoint and interrupt stack level */
+
 #define MSR_IA32_BNDCFGS                0x00000d90
 #define MSR_IA32_XSS                    0x00000da0
 #define MSR_IA32_UMWAIT_CONTROL         0xe1
@@ -1680,6 +1694,16 @@ typedef struct CPUArchState {
     target_ulong cstar;
     target_ulong fmask;
     target_ulong kernelgsbase;
+    target_ulong fred_rsp0;
+    target_ulong fred_rsp1;
+    target_ulong fred_rsp2;
+    target_ulong fred_rsp3;
+    target_ulong fred_stklvls;
+    target_ulong fred_ssp0;
+    target_ulong fred_ssp1;
+    target_ulong fred_ssp2;
+    target_ulong fred_ssp3;
+    target_ulong fred_config;
 #endif
 
     uint64_t tsc_adjust;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 639a242ad8..4b241c82d8 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3401,6 +3401,18 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
         kvm_msr_entry_add(cpu, MSR_KERNELGSBASE, env->kernelgsbase);
         kvm_msr_entry_add(cpu, MSR_FMASK, env->fmask);
         kvm_msr_entry_add(cpu, MSR_LSTAR, env->lstar);
+        if (env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_FRED) {
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_RSP0, env->fred_rsp0);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_RSP1, env->fred_rsp1);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_RSP2, env->fred_rsp2);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_RSP3, env->fred_rsp3);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_STKLVLS, env->fred_stklvls);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP0, env->fred_ssp0);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP1, env->fred_ssp1);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP2, env->fred_ssp2);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP3, env->fred_ssp3);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_CONFIG, env->fred_config);
+        }
     }
 #endif
 
@@ -3901,6 +3913,18 @@ static int kvm_get_msrs(X86CPU *cpu)
         kvm_msr_entry_add(cpu, MSR_KERNELGSBASE, 0);
         kvm_msr_entry_add(cpu, MSR_FMASK, 0);
         kvm_msr_entry_add(cpu, MSR_LSTAR, 0);
+        if (env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_FRED) {
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_RSP0, 0);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_RSP1, 0);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_RSP2, 0);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_RSP3, 0);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_STKLVLS, 0);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP0, 0);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP1, 0);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP2, 0);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP3, 0);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_CONFIG, 0);
+        }
     }
 #endif
     kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, 0);
@@ -4123,6 +4147,36 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_LSTAR:
             env->lstar = msrs[i].data;
             break;
+        case MSR_IA32_FRED_RSP0:
+            env->fred_rsp0 = msrs[i].data;
+            break;
+        case MSR_IA32_FRED_RSP1:
+            env->fred_rsp1 = msrs[i].data;
+            break;
+        case MSR_IA32_FRED_RSP2:
+            env->fred_rsp2 = msrs[i].data;
+            break;
+        case MSR_IA32_FRED_RSP3:
+            env->fred_rsp3 = msrs[i].data;
+            break;
+        case MSR_IA32_FRED_STKLVLS:
+            env->fred_stklvls = msrs[i].data;
+            break;
+        case MSR_IA32_FRED_SSP0:
+            env->fred_ssp0 = msrs[i].data;
+            break;
+        case MSR_IA32_FRED_SSP1:
+            env->fred_ssp1 = msrs[i].data;
+            break;
+        case MSR_IA32_FRED_SSP2:
+            env->fred_ssp2 = msrs[i].data;
+            break;
+        case MSR_IA32_FRED_SSP3:
+            env->fred_ssp3 = msrs[i].data;
+            break;
+        case MSR_IA32_FRED_CONFIG:
+            env->fred_config = msrs[i].data;
+            break;
 #endif
         case MSR_IA32_TSC:
             env->tsc = msrs[i].data;
diff --git a/target/i386/machine.c b/target/i386/machine.c
index c7ac8084b2..5c722a49c5 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1652,6 +1652,16 @@ const VMStateDescription vmstate_x86_cpu = {
         VMSTATE_UINT64(env.cstar, X86CPU),
         VMSTATE_UINT64(env.fmask, X86CPU),
         VMSTATE_UINT64(env.kernelgsbase, X86CPU),
+        VMSTATE_UINT64(env.fred_rsp0, X86CPU),
+        VMSTATE_UINT64(env.fred_rsp1, X86CPU),
+        VMSTATE_UINT64(env.fred_rsp2, X86CPU),
+        VMSTATE_UINT64(env.fred_rsp3, X86CPU),
+        VMSTATE_UINT64(env.fred_stklvls, X86CPU),
+        VMSTATE_UINT64(env.fred_ssp0, X86CPU),
+        VMSTATE_UINT64(env.fred_ssp1, X86CPU),
+        VMSTATE_UINT64(env.fred_ssp2, X86CPU),
+        VMSTATE_UINT64(env.fred_ssp3, X86CPU),
+        VMSTATE_UINT64(env.fred_config, X86CPU),
 #endif
         VMSTATE_UINT32(env.smbase, X86CPU),
 
-- 
2.34.1


