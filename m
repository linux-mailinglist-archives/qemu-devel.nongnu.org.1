Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D7D7325D7
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 05:25:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA03b-0000Dx-1b; Thu, 15 Jun 2023 23:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qA03Z-0000Cc-BR
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 23:23:25 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qA03W-0002HW-Q9
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 23:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686885802; x=1718421802;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kKci2m6UczSqf7UUmiVddjuCdD8Hr1aVNfCyQg0rVmg=;
 b=jPPYFs6Wp5NybIX0MQL9jRQLx8Y4AuY7e7Tr7segWo3QkTsgwdn7EhwR
 gZ9aNrRQSZbNbpN5dCe5ls0oNq26OWIhri5tZP9JQG5xpgkidXQahTe4l
 7FANrCbJtr7KDck6QY0O9HP5NcqiYBvpOZTNIWDbw19gx8raJ+KfVUiHE
 tiGdsWfrqZgKjNNmO7zUK+fvsBNvAp3zh3Z+UcOYTKHrZY1c4sTKkqRSe
 72/w6U77ec34S6qiyBz9CFoiYTKMjmh7u/oQM/z1OMJ4clYwkQz5bdj0I
 h0OOfWIL1bN1+DLYw9awcRP6NIFIGjGXxFeePeWf0cm89vR9v9AavmhB0 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="357979155"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; d="scan'208";a="357979155"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2023 20:23:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="715845982"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; d="scan'208";a="715845982"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by fmsmga007.fm.intel.com with ESMTP; 15 Jun 2023 20:23:19 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, lei4.wang@intel.com,
 qian.wen@intel.com, imammedo@redhat.com, tao1.su@linux.intel.com
Subject: [PATCH 2/7] target/i386: Add support for MCDT_NO in CPUID enumeration
Date: Fri, 16 Jun 2023 11:23:06 +0800
Message-Id: <20230616032311.19137-3-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616032311.19137-1-tao1.su@linux.intel.com>
References: <20230616032311.19137-1-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.120;
 envelope-from=tao1.su@linux.intel.com; helo=mga04.intel.com
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
index e8a70c35d2..7898a4c79a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -668,6 +668,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_7_1_EAX_FEATURES (CPUID_7_1_EAX_FZRM | CPUID_7_1_EAX_FSRS | \
           CPUID_7_1_EAX_FSRC)
 #define TCG_7_1_EDX_FEATURES 0
+#define TCG_7_2_EDX_FEATURES 0
 #define TCG_APM_FEATURES 0
 #define TCG_6_EAX_FEATURES CPUID_6_EAX_ARAT
 #define TCG_XSAVE_FEATURES (CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XGETBV1)
@@ -910,6 +911,25 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
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
@@ -5919,6 +5939,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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
@@ -6779,6 +6804,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         x86_cpu_adjust_feat_level(cpu, FEAT_7_0_ECX);
         x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EAX);
         x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EDX);
+        x86_cpu_adjust_feat_level(cpu, FEAT_7_2_EDX);
         x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_EDX);
         x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_ECX);
         x86_cpu_adjust_feat_level(cpu, FEAT_8000_0007_EDX);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cd047e0410..64d50acf41 100644
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


