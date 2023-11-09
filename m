Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C997E64C1
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 08:52:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0zoK-0007Je-1c; Thu, 09 Nov 2023 02:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1r0zoF-0007HQ-7s
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 02:50:39 -0500
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1r0zo9-0001pD-55
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 02:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699516233; x=1731052233;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XHdLvfVHJIvI0mv20DOWuf8Ii7qbgRx1MvES8geIcoU=;
 b=SUxuHbS9TGfvJUx1nRBLaXIuQ1SCxrqca/1NDc+t+D8USEkK0qd43+Db
 +96hdDeW2+JkndRjXsoulS2E2af+9a0ejVvgvsDfgagT2SJU3j8u+i7Er
 MYShRx6iv55LaC8vBABP4z1rr0uVFeXL3HhWYYTQmhKXINqMqNDVywlh7
 MGGLvYO2lpaDurj8cLFR/vQkWtW4tCMqqxbxwcqoKYuHbMrpjQmAYIRDG
 k69468Zd2QWf57SDHWDvwnB+nUE1/1G2SAO+PVD820gMlooKbM+6RNpQI
 t5uFxOJL/nfaDXBN1GFgJ+dxihWl3L7p5rKEuz4FYAeDkMJzTT9l5F6MI A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="476165129"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; d="scan'208";a="476165129"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2023 23:50:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="763329268"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; d="scan'208";a="763329268"
Received: from unknown (HELO fred..) ([172.25.112.68])
 by orsmga002.jf.intel.com with ESMTP; 08 Nov 2023 23:50:21 -0800
From: Xin Li <xin3.li@intel.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, seanjc@google.com, chao.gao@intel.com, hpa@zytor.com,
 xiaoyao.li@intel.com, weijiang.yang@intel.com
Subject: [PATCH v3 1/6] target/i386: add support for FRED in CPUID enumeration
Date: Wed,  8 Nov 2023 23:20:07 -0800
Message-ID: <20231109072012.8078-2-xin3.li@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231109072012.8078-1-xin3.li@intel.com>
References: <20231109072012.8078-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.43; envelope-from=xin3.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

FRED, i.e., the Intel flexible return and event delivery architecture,
defines simple new transitions that change privilege level (ring
transitions).

The new transitions defined by the FRED architecture are FRED event
delivery and, for returning from events, two FRED return instructions.
FRED event delivery can effect a transition from ring 3 to ring 0, but
it is used also to deliver events incident to ring 0.  One FRED
instruction (ERETU) effects a return from ring 0 to ring 3, while the
other (ERETS) returns while remaining in ring 0.  Collectively, FRED
event delivery and the FRED return instructions are FRED transitions.

In addition to these transitions, the FRED architecture defines a new
instruction (LKGS) for managing the state of the GS segment register.
The LKGS instruction can be used by 64-bit operating systems that do
not use the new FRED transitions.

WRMSRNS is an instruction that behaves exactly like WRMSR, with the
only difference being that it is not a serializing instruction by
default.  Under certain conditions, WRMSRNS may replace WRMSR to improve
performance.  FRED uses it to switch RSP0 in a faster manner.

Search for the latest FRED spec in most search engines with this search
pattern:

  site:intel.com FRED (flexible return and event delivery) specification

The CPUID feature flag CPUID.(EAX=7,ECX=1):EAX[17] enumerates FRED, and
the CPUID feature flag CPUID.(EAX=7,ECX=1):EAX[18] enumerates LKGS, and
the CPUID feature flag CPUID.(EAX=7,ECX=1):EAX[19] enumerates WRMSRNS.

Add CPUID definitions for FRED/LKGS/WRMSRNS, and expose them to KVM guests.

Because FRED relies on LKGS and WRMSRNS, add that to feature dependency
map.

Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 target/i386/cpu.c | 10 +++++++++-
 target/i386/cpu.h |  6 ++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 358d9c0a65..403c84177a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -965,7 +965,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "avx-vnni", "avx512-bf16", NULL, "cmpccxadd",
             NULL, NULL, "fzrm", "fsrs",
             "fsrc", NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, "fred", "lkgs", "wrmsrns",
             NULL, "amx-fp16", NULL, "avx-ifma",
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
@@ -1552,6 +1552,14 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_VMX_SECONDARY_CTLS,  VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE },
         .to = { FEAT_7_0_ECX,               CPUID_7_0_ECX_WAITPKG },
     },
+    {
+        .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_FRED },
+        .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_LKGS },
+    },
+    {
+        .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_FRED },
+        .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_WRMSRNS },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cd2e295bd6..5faf00551d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -934,6 +934,12 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_7_1_EDX_AMX_COMPLEX       (1U << 8)
 /* PREFETCHIT0/1 Instructions */
 #define CPUID_7_1_EDX_PREFETCHITI       (1U << 14)
+/* Flexible return and event delivery (FRED) */
+#define CPUID_7_1_EAX_FRED              (1U << 17)
+/* Load into IA32_KERNEL_GS_BASE (LKGS) */
+#define CPUID_7_1_EAX_LKGS              (1U << 18)
+/* Non-Serializing Write to Model Specific Register (WRMSRNS) */
+#define CPUID_7_1_EAX_WRMSRNS           (1U << 19)
 
 /* Do not exhibit MXCSR Configuration Dependent Timing (MCDT) behavior */
 #define CPUID_7_2_EDX_MCDT_NO           (1U << 5)
-- 
2.42.0


