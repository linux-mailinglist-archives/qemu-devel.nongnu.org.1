Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D8875C0DE
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 10:08:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMlBS-0001It-SV; Fri, 21 Jul 2023 04:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1qMlBQ-0001IZ-Cf
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 04:08:16 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1qMlBO-0001XF-D7
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 04:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689926894; x=1721462894;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oCFFutrEn+VKrrza6L63mi/kRhNVoDCDg+rildlSC7Q=;
 b=IdKch63AIUmyS8/VCHSlR915QfSruExzwZ/eWmK/3T5n6lTPB8l+hQvt
 mEJhlkD3VpE3GeSw7L9w1Aajga7BZzC6BGjn6JoP0TZ0SK2cC5ZtlFlCn
 vpjg8RxQrA9rLFeRCYEa8gzRQlF4zcrY43+RHpmp1Y4nOpinMuADY6yfQ
 iHwJYQvL/y3VniyExVdgPAbOlX3upfnGiQsz8tpMLON9d4qdZaVlkDT9K
 q76PhEHkumYYucDA4KwsDIX9dy6PmCZmE/V3BDRQjMC1+GMuyNUgVyzAl
 qX4442RiDZZVL/pygRTyo8Du+QbDOVB7fYMJb/UW5srLdpnOFY20teW4i Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="346557459"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; d="scan'208";a="346557459"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2023 01:08:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="724781751"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; d="scan'208";a="724781751"
Received: from binbinwu-mobl.ccr.corp.intel.com ([10.238.9.27])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2023 01:08:06 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, chao.gao@intel.com,
 robert.hu@linux.intel.com, binbin.wu@linux.intel.com
Subject: [PATCH v3 1/2] target/i386: add support for LAM in CPUID enumeration
Date: Fri, 21 Jul 2023 16:07:59 +0800
Message-Id: <20230721080800.2329-2-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721080800.2329-1-binbin.wu@linux.intel.com>
References: <20230721080800.2329-1-binbin.wu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.136;
 envelope-from=binbin.wu@linux.intel.com; helo=mga12.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
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

From: Robert Hoo <robert.hu@linux.intel.com>

Linear Address Masking (LAM) is a new Intel CPU feature, which allows software
to use of the untranslated address bits for metadata.

The bit definition:
CPUID.(EAX=7,ECX=1):EAX[26]

Add CPUID definition for LAM.

Note LAM feature is not supported for TCG of target-386, LAM CPIUD bit will not
be added to TCG_7_1_EAX_FEATURES.

More info can be found in Intel ISE Chapter "LINEAR ADDRESS MASKING (LAM)"
https://cdrdv2.intel.com/v1/dl/getContent/671368

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
Co-developed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 97ad229d8b..3a42340730 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -965,7 +965,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "fsrc", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, "amx-fp16", NULL, "avx-ifma",
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, "lam", NULL,
             NULL, NULL, NULL, NULL,
         },
         .cpuid = {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e0771a1043..4db97899fe 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -925,6 +925,8 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_7_1_EAX_AMX_FP16          (1U << 21)
 /* Support for VPMADD52[H,L]UQ */
 #define CPUID_7_1_EAX_AVX_IFMA          (1U << 23)
+/* Linear Address Masking */
+#define CPUID_7_1_EAX_LAM               (1U << 26)
 
 /* Support for VPDPB[SU,UU,SS]D[,S] */
 #define CPUID_7_1_EDX_AVX_VNNI_INT8     (1U << 4)
-- 
2.25.1


