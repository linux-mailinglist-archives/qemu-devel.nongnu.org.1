Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3926375B11A
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 16:21:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMUWB-00011V-KR; Thu, 20 Jul 2023 10:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1qMUVZ-0000t9-Sy
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 10:20:01 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1qMUVX-0004Ur-BQ
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 10:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689862795; x=1721398795;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=buXmaIF8bsSZQ+khArpLQjEisj2O6Xke+QF4SVMpF2M=;
 b=BnWurAufHZ/My55aMv+jliSwUiwtEFRW3T5TNb0UPZYy+VgsQ0tWG4r6
 0oBpBIKD+BRTAQYepNY9W5hN3hUMyhP+hhTBVzBsCXoWwwVpDhOo4UQUv
 vjSa9Lha2i1K3Bxen7exJyxw/kGh6c8kwnpZf0M5ksfz44pI+TYooTiP6
 na0bs+Nhl5GoBub+cCjW/leNMIh22p1bbDju7WBmjfa5dAyxlZIBuIRLc
 DAlNKwKNXa8uwEV5RptkprjdrptRBiKxcp6jceIX5knESGOEzwsifV5sq
 3KRqYSCyNyhc+QdprjltcNFUZm16XWoxrK/JV0uBICTYcUxxSBY2lqKmT g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="397629169"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; d="scan'208";a="397629169"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2023 07:19:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="898295625"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; d="scan'208";a="898295625"
Received: from embargo.jf.intel.com ([10.165.9.183])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2023 07:19:29 -0700
From: Yang Weijiang <weijiang.yang@intel.com>
To: pbonzini@redhat.com, mtosatti@redhat.com, seanjc@google.com,
 qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	weijiang.yang@intel.com
Subject: [PATCH v2 3/4] target/i386: Add CET states to vmstate
Date: Thu, 20 Jul 2023 07:14:44 -0400
Message-Id: <20230720111445.99509-4-weijiang.yang@intel.com>
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

Add CET states in vmstate if the feature is enabled.

Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 target/i386/machine.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index c7ac8084b2..6d42f6dc7e 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1586,6 +1586,33 @@ static const VMStateDescription vmstate_arch_lbr = {
     }
 };
 
+static bool cet_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return !!((env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK) ||
+              (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_CET_IBT));
+}
+
+static const VMStateDescription vmstate_cet = {
+    .name = "cpu/cet",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = cet_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.u_cet, X86CPU),
+        VMSTATE_UINT64(env.s_cet, X86CPU),
+        VMSTATE_UINT64(env.guest_ssp, X86CPU),
+        VMSTATE_UINT64(env.pl0_ssp, X86CPU),
+        VMSTATE_UINT64(env.pl1_ssp, X86CPU),
+        VMSTATE_UINT64(env.pl2_ssp, X86CPU),
+        VMSTATE_UINT64(env.pl3_ssp, X86CPU),
+        VMSTATE_UINT64(env.ssp_table_addr, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool triple_fault_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
@@ -1745,6 +1772,7 @@ const VMStateDescription vmstate_x86_cpu = {
         &vmstate_msr_tsx_ctrl,
         &vmstate_msr_intel_sgx,
         &vmstate_pdptrs,
+        &vmstate_cet,
         &vmstate_msr_xfd,
 #ifdef TARGET_X86_64
         &vmstate_amx_xtile,
-- 
2.27.0


