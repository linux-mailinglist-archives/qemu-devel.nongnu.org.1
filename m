Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B93281C38E
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 04:36:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGWJB-0002Yn-8c; Thu, 21 Dec 2023 22:34:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1rGWJ9-0002YO-Fj
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 22:34:43 -0500
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1rGWJ7-0003Q1-10
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 22:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703216081; x=1734752081;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wv7hjwJFZ1odjItKIHqGWAOc1phfNDJDLzujD7QDe+k=;
 b=BWuJEdQ1u7DfDPoyoL9wQkcm3kvhc58b+LhrN/XogWuJiH05EB7I38CR
 5Yb1DRZbRqueWKU4yekxO/HJP1tauNRnLt54vS8n+4heINbMGEKcBYEDA
 qXuZSN1z2sL3R6sNg7kHtWRO8j3uWwFbq/mQXwjn5aU8GJ+HLSAXWnjHe
 qRERidp0IQMp+qrjLXhK6l4PGLTe/otBz3TFVstXqRrVp/tuLMxLOwmci
 SVS6kQHTIcpkuSqHsNW8cSrPl1MZ2SroTUBe4/T4+pyHsXeny1Lot6apb
 RxHgRj2nek69DFC/e+TG0IHYwY0aSS3hbkBjkvqBLvz3obDwCzc+SdWsn Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="398858270"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; d="scan'208";a="398858270"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2023 19:34:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; d="scan'208";a="25205208"
Received: from unknown (HELO fred..) ([172.25.112.68])
 by orviesa001.jf.intel.com with ESMTP; 21 Dec 2023 19:34:38 -0800
From: Xin Li <xin3.li@intel.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, seanjc@google.com, chao.gao@intel.com, hpa@zytor.com,
 xiaoyao.li@intel.com, weijiang.yang@intel.com, dan1.wu@intel.com
Subject: [PATCH v3A 1/6] target/i386: add support for FRED in CPUID enumeration
Date: Thu, 21 Dec 2023 19:03:36 -0800
Message-ID: <20231222030336.38096-1-xin3.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <MW4PR11MB6737DC0CCD50B5D3D00521A7A895A@MW4PR11MB6737.namprd11.prod.outlook.com>
References: <MW4PR11MB6737DC0CCD50B5D3D00521A7A895A@MW4PR11MB6737.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.24; envelope-from=xin3.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Changelog
v3A:
- Fix reversed dependency (Wu Dan1).
---
 target/i386/cpu.c | 10 +++++++++-
 target/i386/cpu.h |  6 ++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 358d9c0a65..66551c7eae 100644
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
+        .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_LKGS },
+        .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_FRED },
+    },
+    {
+        .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_WRMSRNS },
+        .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_FRED },
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
2.43.0


