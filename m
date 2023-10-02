Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFB47B4CE4
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 09:54:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnDjh-0000XE-8i; Mon, 02 Oct 2023 03:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1qnDjf-0000UQ-6w
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 03:52:59 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1qnDjd-0007eV-E0
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 03:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1696233177; x=1727769177;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4tKHv5OEKwpSrHxLYdaqKvaovIBLgPE2/VnUpwq6398=;
 b=B7JVZc3ErudwCdSqQ55Cew01e1s8Ai30ijnV7v6lMjp2OxlFaqx0e7lf
 mP2zhzWKNd/TZzySePFLSIeHOuLVNa+q2syH2I4NQTU2HlhdrBkX6Madb
 bUHihEv8mtpzA1noe/P5AXsWT3veQqd0I/l2UAL1TdX4b2575uPyCjOPU
 tvNM6l4zWlwNi5kkQKk+hDw3H6bb5bTdMbohwDeJF4/l7IdcANzJYYqCK
 Na4gGPYmbgNNBV1BHlm5KFH/By36m/314vne6SOApptMhzE0OO4V56F5W
 rMsrPwAj0bWKPNZmb2ANyMF3/yH5cBGEIbh6YXLs80fdHKZKp/DcPJs4E A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="361975573"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; d="scan'208";a="361975573"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2023 00:52:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="750511627"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; d="scan'208";a="750511627"
Received: from unknown (HELO fred..) ([172.25.112.68])
 by orsmga002.jf.intel.com with ESMTP; 02 Oct 2023 00:52:49 -0700
From: Xin Li <xin3.li@intel.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, seanjc@google.com, chao.gao@intel.com, hpa@zytor.com,
 xiaoyao.li@intel.com, weijiang.yang@intel.com
Subject: [PATCH v2 2/4] target/i386: mark CR4.FRED not reserved
Date: Mon,  2 Oct 2023 00:23:11 -0700
Message-Id: <20231002072313.17603-3-xin3.li@intel.com>
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

The CR4.FRED bit, i.e., CR4[32], is no longer a reserved bit when FRED
is exposed to guests, otherwise it is still a reserved bit.

Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 target/i386/cpu.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e2946f1d6b..322547aa49 100644
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
@@ -2484,6 +2491,9 @@ static inline uint64_t cr4_reserved_bits(CPUX86State *env)
     if (!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_PKS)) {
         reserved_bits |= CR4_PKS_MASK;
     }
+    if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_FRED)) {
+        reserved_bits |= CR4_FRED_MASK;
+    }
     return reserved_bits;
 }
 
-- 
2.34.1


