Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CC6749514
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 07:50:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHHsk-0006wA-RZ; Thu, 06 Jul 2023 01:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qHHse-0006vu-5W
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 01:50:16 -0400
Received: from mga14.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qHHsb-0006J9-SP
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 01:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688622613; x=1720158613;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OxhmAdcjXELgH9pqd7cb2eFBi2iIUfe33eP1y5CdATA=;
 b=kRODxirlOxso15yEEH8VDnNkRkVOSC+UqO7JrrT2IixOXg1kLrLAKO87
 eWAHeHYy78lH6kAD3HgaZOFx2OnRNDqYrJn+iv+N3jM7q0YSBq4HWAqcb
 MDgB6GEXLkojxFO2Fc9l1I0cmKup92FgPvM8tiEILcyepv7KYO1qBjtaj
 2QRE+5rDlZkmBYzmfZakmy051q3FSekPQsnmTQ3YgXHheX4qqZ33MiXeL
 GEgvUzPADahhZPQelPpJq7G18veCJXQYv8n7AOUz0yo/GXE7oVPp9AkwV
 1Let9/IN0aOC3wkpGVsw768W1fEYXE82DbDu+2pWdyjc14cImPj9VQMVs g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="363540151"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; d="scan'208";a="363540151"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2023 22:50:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="863975933"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; d="scan'208";a="863975933"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2023 22:49:57 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, imammedo@redhat.com, xiaoyao.li@intel.com,
 lei4.wang@intel.com, qian.wen@intel.com, tao1.su@linux.intel.com
Subject: [PATCH v2 2/6] target/i386: Add support for MCDT_NO in CPUID
 enumeration
Date: Thu,  6 Jul 2023 13:49:45 +0800
Message-Id: <20230706054949.66556-3-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706054949.66556-1-tao1.su@linux.intel.com>
References: <20230706054949.66556-1-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.115;
 envelope-from=tao1.su@linux.intel.com; helo=mga14.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

CPUID.(EAX=7,ECX=2):EDX[bit 5] enumerates MCDT_NO. Processors enumerate
this bit as 1 do not exhibit MXCSR Configuration Dependent Timing (MCDT)
behavior and do not need to be mitigated to avoid data-dependent behavior
for certain instructions.

Since MCDT_NO is in a new sub-leaf, add a new CPUID feature word
FEAT_7_2_EDX. Also update cpuid_level_func7 by FEAT_7_2_EDX.

Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 26 ++++++++++++++++++++++++++
 target/i386/cpu.h |  4 ++++
 2 files changed, 30 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 952744af97..852c45b965 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -739,6 +739,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_7_1_EAX_FEATURES (CPUID_7_1_EAX_FZRM | CPUID_7_1_EAX_FSRS | \
           CPUID_7_1_EAX_FSRC)
 #define TCG_7_1_EDX_FEATURES 0
+#define TCG_7_2_EDX_FEATURES 0
 #define TCG_APM_FEATURES 0
 #define TCG_6_EAX_FEATURES CPUID_6_EAX_ARAT
 #define TCG_XSAVE_FEATURES (CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XGETBV1)
@@ -993,6 +994,25 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = TCG_7_1_EDX_FEATURES,
     },
+    [FEAT_7_2_EDX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            NULL, NULL, NULL, NULL,
+            NULL, "mcdt-no", NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = {
+            .eax = 7,
+            .needs_ecx = true, .ecx = 2,
+            .reg = R_EDX,
+        },
+        .tcg_features = TCG_7_2_EDX_FEATURES,
+    },
     [FEAT_8000_0007_EDX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -6017,6 +6037,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *edx = env->features[FEAT_7_1_EDX];
             *ebx = 0;
             *ecx = 0;
+        } else if (count == 2) {
+            *edx = env->features[FEAT_7_2_EDX];
+            *eax = 0;
+            *ebx = 0;
+            *ecx = 0;
         } else {
             *eax = 0;
             *ebx = 0;
@@ -6881,6 +6906,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         x86_cpu_adjust_feat_level(cpu, FEAT_7_0_ECX);
         x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EAX);
         x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EDX);
+        x86_cpu_adjust_feat_level(cpu, FEAT_7_2_EDX);
         x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_EDX);
         x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_ECX);
         x86_cpu_adjust_feat_level(cpu, FEAT_8000_0007_EDX);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 2c9b0d2ebc..c196b0a482 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -628,6 +628,7 @@ typedef enum FeatureWord {
     FEAT_XSAVE_XSS_LO,     /* CPUID[EAX=0xd,ECX=1].ECX */
     FEAT_XSAVE_XSS_HI,     /* CPUID[EAX=0xd,ECX=1].EDX */
     FEAT_7_1_EDX,       /* CPUID[EAX=7,ECX=1].EDX */
+    FEAT_7_2_EDX,       /* CPUID[EAX=7,ECX=2].EDX */
     FEATURE_WORDS,
 } FeatureWord;
 
@@ -932,6 +933,9 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 /* PREFETCHIT0/1 Instructions */
 #define CPUID_7_1_EDX_PREFETCHITI       (1U << 14)
 
+/* Do not exhibit MXCSR Configuration Dependent Timing (MCDT) behavior */
+#define CPUID_7_2_EDX_MCDT_NO           (1U << 5)
+
 /* XFD Extend Feature Disabled */
 #define CPUID_D_1_EAX_XFD               (1U << 4)
 
-- 
2.34.1


