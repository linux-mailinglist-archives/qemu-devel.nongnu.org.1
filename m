Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B3A75B119
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 16:21:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMUW0-0000z4-Qy; Thu, 20 Jul 2023 10:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1qMUVW-0000sr-RF
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 10:19:55 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1qMUVU-0004Ur-Sw
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 10:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689862792; x=1721398792;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KdjKIag+jbGTolKothZA8nfZL3D2MAVYfiTzfh7452k=;
 b=jhX8OaZ3CqoaVv5F1njYlGxbRngi23pscMnsaGHkHw3KYH71T6T9wqzW
 vXyQtNnNXONzg2q3ml3wWCyo69tDEh5GUqh6RJhnvo4hbHcp36mkyY2Jc
 l3jUPoKHYfaAM211sf933SCginBQbSyp+Rj5LZxKGtpcJG1B7VaCk5tIL
 MFn9oe2hsfazAAwsv/xoPOlLRtN9Ln3anu5NsN+tiVeesz/z3ey4EiOWw
 6wMrQa6PzNaV24Mu64Z3ha774dxi5NzLouiqeLJ70/4FA+FBJSTsdEXgs
 PJQi2/YyU1CNNJny1AF/rAUf2RESQ2UTSxT5KrfLNaWGAzIo8G+KPyUjo g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="397629157"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; d="scan'208";a="397629157"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2023 07:19:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="898295619"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; d="scan'208";a="898295619"
Received: from embargo.jf.intel.com ([10.165.9.183])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2023 07:19:29 -0700
From: Yang Weijiang <weijiang.yang@intel.com>
To: pbonzini@redhat.com, mtosatti@redhat.com, seanjc@google.com,
 qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	weijiang.yang@intel.com
Subject: [PATCH v2 1/4] target/i386: Enable XSAVES support for CET states
Date: Thu, 20 Jul 2023 07:14:42 -0400
Message-Id: <20230720111445.99509-2-weijiang.yang@intel.com>
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

Add CET_U/S bits in xstate area and report support in xstate
feature mask.
MSR_XSS[bit 11] corresponds to CET user mode states.
MSR_XSS[bit 12] corresponds to CET supervisor mode states.

CET Shadow Stack(SHSTK) and Indirect Branch Tracking(IBT) features
are enumerated via CPUID.(EAX=07H,ECX=0H):ECX[7] and EDX[20]
respectively, two featues share the same state bits in XSS,so
if either of the features is enabled, set CET_U and CET_S bits
together.

Opportunistically fix the array format issue.

Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 target/i386/cpu.c | 45 ++++++++++++++++++++++++++++++++++++---------
 target/i386/cpu.h | 23 +++++++++++++++++++++++
 2 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f083ff4335..ea11b589e3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -944,8 +944,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .feat_names = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, "cet-u",
+            "cet-s", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
@@ -1421,7 +1421,8 @@ static const X86RegisterInfo32 x86_reg_info_32[CPU_NB_REGS32] = {
 #undef REGISTER
 
 /* CPUID feature bits available in XSS */
-#define CPUID_XSTATE_XSS_MASK    (XSTATE_ARCH_LBR_MASK)
+#define CPUID_XSTATE_XSS_MASK    (XSTATE_ARCH_LBR_MASK | XSTATE_CET_U_MASK | \
+                                  XSTATE_CET_S_MASK)
 
 ExtSaveArea x86_ext_save_areas[XSAVE_STATE_AREA_COUNT] = {
     [XSTATE_FP_BIT] = {
@@ -1439,7 +1440,7 @@ ExtSaveArea x86_ext_save_areas[XSAVE_STATE_AREA_COUNT] = {
             .size = sizeof(XSaveAVX) },
     [XSTATE_BNDREGS_BIT] =
           { .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_MPX,
-            .size = sizeof(XSaveBNDREG)  },
+            .size = sizeof(XSaveBNDREG) },
     [XSTATE_BNDCSR_BIT] =
           { .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_MPX,
             .size = sizeof(XSaveBNDCSR)  },
@@ -1459,14 +1460,24 @@ ExtSaveArea x86_ext_save_areas[XSAVE_STATE_AREA_COUNT] = {
             .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_ARCH_LBR,
             .offset = 0 /*supervisor mode component, offset = 0 */,
             .size = sizeof(XSavesArchLBR) },
+    [XSTATE_CET_U_BIT] = {
+        .feature = FEAT_7_0_ECX, .bits = CPUID_7_0_ECX_CET_SHSTK,
+        /*
+         * The features enabled in XSS MSR always use compacted format
+         * to store the data, in this case .offset == 0.
+         */
+        .offset = 0,
+        .size = sizeof(XSavesCETU) },
+    [XSTATE_CET_S_BIT] = {
+        .feature = FEAT_7_0_ECX, .bits = CPUID_7_0_ECX_CET_SHSTK,
+        .offset = 0,
+        .size = sizeof(XSavesCETS) },
     [XSTATE_XTILE_CFG_BIT] = {
         .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_AMX_TILE,
-        .size = sizeof(XSaveXTILECFG),
-    },
+        .size = sizeof(XSaveXTILECFG) },
     [XSTATE_XTILE_DATA_BIT] = {
         .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_AMX_TILE,
-        .size = sizeof(XSaveXTILEDATA)
-    },
+        .size = sizeof(XSaveXTILEDATA) }
 };
 
 uint32_t xsave_area_size(uint64_t mask, bool compacted)
@@ -6259,9 +6270,25 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
         if (env->features[esa->feature] & esa->bits) {
             mask |= (1ULL << i);
         }
+
+        /*
+         * Both CET SHSTK and IBT feature depend on XSAVES support, and two
+         * features can be enabled independently, so if either of the two
+         * features is enabled, we set the XSAVES support bits to make the
+         * enabled feature(s) work.
+         */
+        if (i == XSTATE_CET_U_BIT || i == XSTATE_CET_S_BIT) {
+            uint64_t ecx = env->features[FEAT_7_0_ECX];
+            uint64_t edx = env->features[FEAT_7_0_EDX];
+
+            if ((ecx & CPUID_7_0_ECX_CET_SHSTK) ||
+                (edx & CPUID_7_0_EDX_CET_IBT)) {
+                mask |= (1ULL << i);
+            }
+        }
     }
 
-    /* Only request permission for first vcpu */
+    /* Only request permission from fisrt vcpu. */
     if (kvm_enabled() && !request_perm) {
         kvm_request_xsave_components(cpu, mask);
         request_perm = true;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index d243e290d3..06855e0926 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -554,6 +554,8 @@ typedef enum X86Seg {
 #define XSTATE_ZMM_Hi256_BIT            6
 #define XSTATE_Hi16_ZMM_BIT             7
 #define XSTATE_PKRU_BIT                 9
+#define XSTATE_CET_U_BIT                11
+#define XSTATE_CET_S_BIT                12
 #define XSTATE_ARCH_LBR_BIT             15
 #define XSTATE_XTILE_CFG_BIT            17
 #define XSTATE_XTILE_DATA_BIT           18
@@ -567,6 +569,8 @@ typedef enum X86Seg {
 #define XSTATE_ZMM_Hi256_MASK           (1ULL << XSTATE_ZMM_Hi256_BIT)
 #define XSTATE_Hi16_ZMM_MASK            (1ULL << XSTATE_Hi16_ZMM_BIT)
 #define XSTATE_PKRU_MASK                (1ULL << XSTATE_PKRU_BIT)
+#define XSTATE_CET_U_MASK               (1ULL << XSTATE_CET_U_BIT)
+#define XSTATE_CET_S_MASK               (1ULL << XSTATE_CET_S_BIT)
 #define XSTATE_ARCH_LBR_MASK            (1ULL << XSTATE_ARCH_LBR_BIT)
 #define XSTATE_XTILE_CFG_MASK           (1ULL << XSTATE_XTILE_CFG_BIT)
 #define XSTATE_XTILE_DATA_MASK          (1ULL << XSTATE_XTILE_DATA_BIT)
@@ -841,6 +845,8 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_7_0_ECX_WAITPKG           (1U << 5)
 /* Additional AVX-512 Vector Byte Manipulation Instruction */
 #define CPUID_7_0_ECX_AVX512_VBMI2      (1U << 6)
+/* CET SHSTK feature */
+#define CPUID_7_0_ECX_CET_SHSTK         (1U << 7)
 /* Galois Field New Instructions */
 #define CPUID_7_0_ECX_GFNI              (1U << 8)
 /* Vector AES Instructions */
@@ -884,6 +890,8 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_7_0_EDX_TSX_LDTRK         (1U << 16)
 /* Architectural LBRs */
 #define CPUID_7_0_EDX_ARCH_LBR          (1U << 19)
+/* CET IBT feature */
+#define CPUID_7_0_EDX_CET_IBT           (1U << 20)
 /* AMX_BF16 instruction */
 #define CPUID_7_0_EDX_AMX_BF16          (1U << 22)
 /* AVX512_FP16 instruction */
@@ -1428,6 +1436,19 @@ typedef struct XSavePKRU {
     uint32_t padding;
 } XSavePKRU;
 
+/* Ext. save area 11: User mode CET state */
+typedef struct XSavesCETU {
+    uint64_t u_cet;
+    uint64_t user_ssp;
+} XSavesCETU;
+
+/* Ext. save area 12: Supervisor mode CET state */
+typedef struct XSavesCETS {
+    uint64_t pl0_ssp;
+    uint64_t pl1_ssp;
+    uint64_t pl2_ssp;
+} XSavesCETS;
+
 /* Ext. save area 17: AMX XTILECFG state */
 typedef struct XSaveXTILECFG {
     uint8_t xtilecfg[64];
@@ -1463,6 +1484,8 @@ QEMU_BUILD_BUG_ON(sizeof(XSaveOpmask) != 0x40);
 QEMU_BUILD_BUG_ON(sizeof(XSaveZMM_Hi256) != 0x200);
 QEMU_BUILD_BUG_ON(sizeof(XSaveHi16_ZMM) != 0x400);
 QEMU_BUILD_BUG_ON(sizeof(XSavePKRU) != 0x8);
+QEMU_BUILD_BUG_ON(sizeof(XSavesCETU) != 0x10);
+QEMU_BUILD_BUG_ON(sizeof(XSavesCETS) != 0x18);
 QEMU_BUILD_BUG_ON(sizeof(XSaveXTILECFG) != 0x40);
 QEMU_BUILD_BUG_ON(sizeof(XSaveXTILEDATA) != 0x2000);
 QEMU_BUILD_BUG_ON(sizeof(XSavesArchLBR) != 0x328);
-- 
2.27.0


