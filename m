Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C707B4CE2
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 09:54:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnDjj-0000Y9-29; Mon, 02 Oct 2023 03:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1qnDjh-0000XX-4U
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 03:53:01 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1qnDjf-0007fN-5V
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 03:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1696233179; x=1727769179;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kw/yjSYXiI7ySaJO66BP5TFzDlJrtu/QbJsPliJ4Iec=;
 b=K2ryY995kHzceFeenCv9GnbonvUmvuulnJFz1irlBYXFPReG3blpW11A
 Hr/BkdNtcUj2y7Zkpv5lJDHFlWalJ5IoYljIVC7m6q+Q3DYbKWM1qFPy4
 EmU7Ses1G46JzSoYQTa4RTmRUf0wmn8hRwlyM869pv8W8sUrQRm6rA1+O
 m+K+PSR5VUsUgGJyyWsFjU0f4qoish4VPtXbzO2J4IT54YM+JygqWnays
 uq6vmCdHlls+etnPFazcQ0RuM6RcjEMFDMxtJWLpZ07+m2m4G2KMrXCqE
 IFa216E3P8iObBwihxQL74oo573NRNG6lGqzxiAAJrK11494AJOM2ubt4 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="361975587"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; d="scan'208";a="361975587"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2023 00:52:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="750511633"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; d="scan'208";a="750511633"
Received: from unknown (HELO fred..) ([172.25.112.68])
 by orsmga002.jf.intel.com with ESMTP; 02 Oct 2023 00:52:50 -0700
From: Xin Li <xin3.li@intel.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, seanjc@google.com, chao.gao@intel.com, hpa@zytor.com,
 xiaoyao.li@intel.com, weijiang.yang@intel.com
Subject: [PATCH v2 4/4] target/i386: Add get/set/migrate support for FRED MSRs
Date: Mon,  2 Oct 2023 00:23:13 -0700
Message-Id: <20231002072313.17603-5-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002072313.17603-1-xin3.li@intel.com>
References: <20231002072313.17603-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.136; envelope-from=xin3.li@intel.com;
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

FRED CPU states are managed in 9 new FRED MSRs, in addtion to a few
existing CPU registers and MSRs, e.g., CR4.FRED and MSR_IA32_PL0_SSP.

Save/restore/migrate FRED MSRs if FRED is exposed to the guest.

Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 target/i386/cpu.h     | 26 +++++++++++++++++++++
 target/i386/kvm/kvm.c | 54 +++++++++++++++++++++++++++++++++++++++++++
 target/i386/machine.c | 29 +++++++++++++++++++++++
 3 files changed, 109 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f4f0c57574..48e713ecc1 100644
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
@@ -1684,6 +1698,18 @@ typedef struct CPUArchState {
     target_ulong cstar;
     target_ulong fmask;
     target_ulong kernelgsbase;
+
+    /* FRED MSRs */
+    uint64_t fred_rsp0;
+    uint64_t fred_rsp1;
+    uint64_t fred_rsp2;
+    uint64_t fred_rsp3;
+    uint64_t fred_stklvls;
+    uint64_t fred_ssp0;
+    uint64_t fred_ssp1;
+    uint64_t fred_ssp2;
+    uint64_t fred_ssp3;
+    uint64_t fred_config;
 #endif
 
     uint64_t tsc_adjust;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index f6c7f7e268..6ee3369a93 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3399,6 +3399,18 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
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
 
@@ -3897,6 +3909,18 @@ static int kvm_get_msrs(X86CPU *cpu)
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
@@ -4118,6 +4142,36 @@ static int kvm_get_msrs(X86CPU *cpu)
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
index a1041ef828..695e402246 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1544,6 +1544,34 @@ static const VMStateDescription vmstate_msr_xfd = {
 };
 
 #ifdef TARGET_X86_64
+static bool intel_fred_msrs_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return !!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_FRED);
+}
+
+static const VMStateDescription vmstate_msr_fred = {
+    .name = "cpu/fred",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = intel_fred_msrs_needed,
+    .fields = (VMStateField[]) {
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
+        VMSTATE_END_OF_LIST()
+            }
+        };
+
 static bool amx_xtile_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
@@ -1747,6 +1775,7 @@ const VMStateDescription vmstate_x86_cpu = {
         &vmstate_pdptrs,
         &vmstate_msr_xfd,
 #ifdef TARGET_X86_64
+        &vmstate_msr_fred,
         &vmstate_amx_xtile,
 #endif
         &vmstate_arch_lbr,
-- 
2.34.1


