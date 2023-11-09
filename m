Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A4A7E64C0
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 08:52:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0zoM-0007L1-HQ; Thu, 09 Nov 2023 02:50:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1r0zoJ-0007JD-0B
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 02:50:43 -0500
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1r0zoF-0001o2-Qn
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 02:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699516239; x=1731052239;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OTzIm8gCXp6Ung+Q+TxnUDKEdG2Zy3BQi6wounkD6Es=;
 b=JAXKgNVvtyh/zDFlbj7L698woHPVYg1kGF5g0FBwX0I7WIcqeGK2PtEa
 NLXmcXOjxqHB2l2OiIJ6glSHjIvGwMJUQjHqVFUrZ/ZiQsEht+jb9OhRJ
 aZiVk35Ocl/XQpy++UoRRUVFa6seVTPTyyV8gYphfdUIoJsdxYi4Q9ZDO
 MF1+PcFOyyJ5H4b3trBQhIpSJJpQeknsp8NUzm67oJtwTt2MYnaybmB0a
 o0NZ0eXkAWtLmoC6J0LArYQ5NT3GxdwAmk71m8ZK3YW6IqS0sYkIkG9fc
 pF0Gpd8UQA8tM9VHdouSPsiuRRT/oLCg1qNljaH4EvR1o4xztFbA8f3dk Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="476165145"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; d="scan'208";a="476165145"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2023 23:50:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="763329279"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; d="scan'208";a="763329279"
Received: from unknown (HELO fred..) ([172.25.112.68])
 by orsmga002.jf.intel.com with ESMTP; 08 Nov 2023 23:50:22 -0800
From: Xin Li <xin3.li@intel.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, seanjc@google.com, chao.gao@intel.com, hpa@zytor.com,
 xiaoyao.li@intel.com, weijiang.yang@intel.com
Subject: [PATCH v3 3/6] target/i386: add the secondary VM exit controls MSR
Date: Wed,  8 Nov 2023 23:20:09 -0800
Message-ID: <20231109072012.8078-4-xin3.li@intel.com>
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

Add the secondary VM exit controls MSR to prepare for KVM FRED enabling.

Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 scripts/kvm/vmxcap | 9 +++++++++
 target/i386/cpu.c  | 2 +-
 target/i386/cpu.h  | 1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/scripts/kvm/vmxcap b/scripts/kvm/vmxcap
index 3fb4d5b342..7da1e00ca8 100755
--- a/scripts/kvm/vmxcap
+++ b/scripts/kvm/vmxcap
@@ -24,6 +24,7 @@ MSR_IA32_VMX_TRUE_EXIT_CTLS = 0x48F
 MSR_IA32_VMX_TRUE_ENTRY_CTLS = 0x490
 MSR_IA32_VMX_VMFUNC = 0x491
 MSR_IA32_VMX_PROCBASED_CTLS3 = 0x492
+MSR_IA32_VMX_EXIT_CTLS2 = 0x493
 
 class msr(object):
     def __init__(self):
@@ -219,11 +220,19 @@ controls = [
             23: 'Clear IA32_BNDCFGS',
             24: 'Conceal VM exits from PT',
             25: 'Clear IA32_RTIT_CTL',
+            31: 'Activate secondary VM-exit controls',
             },
         cap_msr = MSR_IA32_VMX_EXIT_CTLS,
         true_cap_msr = MSR_IA32_VMX_TRUE_EXIT_CTLS,
         ),
 
+    Allowed1Control(
+        name = 'secondary VM-Exit controls',
+        bits = {
+            },
+        cap_msr = MSR_IA32_VMX_EXIT_CTLS2,
+        ),
+
     Control(
         name = 'VM-Entry controls',
         bits = {
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 403c84177a..227ee1c759 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1270,7 +1270,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "vmx-exit-save-efer", "vmx-exit-load-efer",
                 "vmx-exit-save-preemption-timer", "vmx-exit-clear-bndcfgs",
             NULL, "vmx-exit-clear-rtit-ctl", NULL, NULL,
-            NULL, "vmx-exit-load-pkrs", NULL, NULL,
+            NULL, "vmx-exit-load-pkrs", NULL, "vmx-exit-secondary-ctls",
         },
         .msr = {
             .index = MSR_IA32_VMX_TRUE_EXIT_CTLS,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e210957cba..a4d3702621 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -551,6 +551,7 @@ typedef enum X86Seg {
 #define MSR_IA32_VMX_TRUE_EXIT_CTLS      0x0000048f
 #define MSR_IA32_VMX_TRUE_ENTRY_CTLS     0x00000490
 #define MSR_IA32_VMX_VMFUNC             0x00000491
+#define MSR_IA32_VMX_EXIT_CTLS2         0x00000493
 
 #define XSTATE_FP_BIT                   0
 #define XSTATE_SSE_BIT                  1
-- 
2.42.0


