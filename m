Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EDF7E64C2
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 08:52:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0zoL-0007Ju-DF; Thu, 09 Nov 2023 02:50:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1r0zoJ-0007JF-0j
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 02:50:43 -0500
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1r0zoF-0001pD-Qj
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 02:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699516239; x=1731052239;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cErrvaQ2Y2YRcZJb/xIJHbANMmxb80XwPPZKGztP7x4=;
 b=WOdD3i0FlOmHQMOkLfGMBj3WDOwBJs7u9Y+XbF6TaDBiVFG6U3k7hX2d
 DIMKptqY1pz0a3cuk/EjplKoBYxapk/bSAA9k12FzTL6SgQKHy2qZtjwQ
 fhmevxP3xX2598d+UQX3eRFPnoV3QHERQB8anub/z+SawArrCCucat793
 Wu51jLmGz7sXzBylriqGvS7Sh5SbL5c7KEas8oq+cXwiBUF9tWh8lmJka
 D9GFlMfEMtxOU/6eiwIYhTicqfEhaeZ3soiXhCNo3yt5GEEyZBwk3/8q2
 xnHQ4Wd3qvpoGASJAMEdAZOLI0bxgW6WWJIIWyjSHyR2Nl9mNospXcxgZ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="476165137"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; d="scan'208";a="476165137"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2023 23:50:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="763329273"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; d="scan'208";a="763329273"
Received: from unknown (HELO fred..) ([172.25.112.68])
 by orsmga002.jf.intel.com with ESMTP; 08 Nov 2023 23:50:22 -0800
From: Xin Li <xin3.li@intel.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, seanjc@google.com, chao.gao@intel.com, hpa@zytor.com,
 xiaoyao.li@intel.com, weijiang.yang@intel.com
Subject: [PATCH v3 2/6] target/i386: mark CR4.FRED not reserved
Date: Wed,  8 Nov 2023 23:20:08 -0800
Message-ID: <20231109072012.8078-3-xin3.li@intel.com>
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

The CR4.FRED bit, i.e., CR4[32], is no longer a reserved bit when FRED
is exposed to guests, otherwise it is still a reserved bit.

Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 target/i386/cpu.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 5faf00551d..e210957cba 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -262,6 +262,12 @@ typedef enum X86Seg {
 #define CR4_PKE_MASK   (1U << 22)
 #define CR4_PKS_MASK   (1U << 24)
 
+#ifdef TARGET_X86_64
+#define CR4_FRED_MASK   (1ULL << 32)
+#else
+#define CR4_FRED_MASK   0
+#endif
+
 #define CR4_RESERVED_MASK \
 (~(target_ulong)(CR4_VME_MASK | CR4_PVI_MASK | CR4_TSD_MASK \
                 | CR4_DE_MASK | CR4_PSE_MASK | CR4_PAE_MASK \
@@ -269,7 +275,8 @@ typedef enum X86Seg {
                 | CR4_OSFXSR_MASK | CR4_OSXMMEXCPT_MASK | CR4_UMIP_MASK \
                 | CR4_LA57_MASK \
                 | CR4_FSGSBASE_MASK | CR4_PCIDE_MASK | CR4_OSXSAVE_MASK \
-                | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | CR4_PKS_MASK))
+                | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | CR4_PKS_MASK \
+                | CR4_FRED_MASK))
 
 #define DR6_BD          (1 << 13)
 #define DR6_BS          (1 << 14)
@@ -2520,6 +2527,9 @@ static inline uint64_t cr4_reserved_bits(CPUX86State *env)
     if (!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_PKS)) {
         reserved_bits |= CR4_PKS_MASK;
     }
+    if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_FRED)) {
+        reserved_bits |= CR4_FRED_MASK;
+    }
     return reserved_bits;
 }
 
-- 
2.42.0


