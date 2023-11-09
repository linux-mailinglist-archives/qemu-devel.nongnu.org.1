Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9AA7E64C4
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 08:52:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0zoL-0007Jw-Bn; Thu, 09 Nov 2023 02:50:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1r0zoJ-0007JE-0C
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 02:50:43 -0500
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1r0zoG-0001sR-9g
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 02:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699516240; x=1731052240;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MRaXk3shPh7gkjPfs7QFU/AG2qwffhxmzb8OZqrofHo=;
 b=dNhGs7GzD73pf7QkH0ulCnC+BST1Wfz2INB2/HkJJhKvSZdMRoLLz5WJ
 pM4TQnZmXEPMCbiOq9pywJgN13jI4ObXadvcr86EPOt7Y1MLMExJUlOcl
 1uuh75LTgF8MDeuMERt+NFEApEoVGxdUPQEAGbo38sui/SxRF8bFrD0NA
 3RP7U6gu8ngV5eBQ3U1+AF5EIBJSQjn9lMjjxS4XyMMdmTZFNbhjciwuN
 VSG1BBmMQ95p2PeVgs8Gb50Y2O5RNWnK+WsUqsu6orrk0qttnmayqyOB4
 1Bu86Eol/Yt9N37C/Q1ZOUhuHjpeBg49ZD84LXg0SA15CJ5nVse2oVS+q g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="476165154"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; d="scan'208";a="476165154"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2023 23:50:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="763329284"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; d="scan'208";a="763329284"
Received: from unknown (HELO fred..) ([172.25.112.68])
 by orsmga002.jf.intel.com with ESMTP; 08 Nov 2023 23:50:22 -0800
From: Xin Li <xin3.li@intel.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, seanjc@google.com, chao.gao@intel.com, hpa@zytor.com,
 xiaoyao.li@intel.com, weijiang.yang@intel.com
Subject: [PATCH v3 4/6] target/i386: add support for VMX FRED controls
Date: Wed,  8 Nov 2023 23:20:10 -0800
Message-ID: <20231109072012.8078-5-xin3.li@intel.com>
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

Add VMX FRED controls used to enable save/load of FRED MSRs.

Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 scripts/kvm/vmxcap | 3 +++
 target/i386/cpu.c  | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/kvm/vmxcap b/scripts/kvm/vmxcap
index 7da1e00ca8..44898d73c2 100755
--- a/scripts/kvm/vmxcap
+++ b/scripts/kvm/vmxcap
@@ -229,6 +229,8 @@ controls = [
     Allowed1Control(
         name = 'secondary VM-Exit controls',
         bits = {
+            0: 'Save IA32 FRED MSRs',
+            1: 'Load IA32 FRED MSRs',
             },
         cap_msr = MSR_IA32_VMX_EXIT_CTLS2,
         ),
@@ -246,6 +248,7 @@ controls = [
             16: 'Load IA32_BNDCFGS',
             17: 'Conceal VM entries from PT',
             18: 'Load IA32_RTIT_CTL',
+            23: 'Load IA32 FRED MSRs',
             },
         cap_msr = MSR_IA32_VMX_ENTRY_CTLS,
         true_cap_msr = MSR_IA32_VMX_TRUE_ENTRY_CTLS,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 227ee1c759..dcf914a7ec 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1285,7 +1285,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, "vmx-entry-ia32e-mode", NULL, NULL,
             NULL, "vmx-entry-load-perf-global-ctrl", "vmx-entry-load-pat", "vmx-entry-load-efer",
             "vmx-entry-load-bndcfgs", NULL, "vmx-entry-load-rtit-ctl", NULL,
-            NULL, NULL, "vmx-entry-load-pkrs", NULL,
+            NULL, NULL, "vmx-entry-load-pkrs", "vmx-entry-load-fred",
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-- 
2.42.0


