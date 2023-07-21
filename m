Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDB375C0E0
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 10:08:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMlBU-0001KJ-Bj; Fri, 21 Jul 2023 04:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1qMlBT-0001KB-D1
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 04:08:19 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1qMlBR-0001Wg-Ta
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 04:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689926897; x=1721462897;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fWUW9Gr0X48+N7XWiK22zkj4La00XlSu76n1v3EbIqY=;
 b=TuBjz1QIHJiDCJWGLWdU7DnwTqgWJIxXoLUE0buvS4uuyjGnDx/q9so+
 XZEEObnleYDJkyilqn2+HNiI0e74Q3+upiOg44MRRtMN41z/FPFcZ3gEV
 OlN6Cs0CXuHfpdDoWT558cfyW6NG5AD1LwozfO6MZ26qd7fZwS2d7V3cf
 XfXsYUeTxUNMEr6Z+bsXvtA9OojzD7Xm9BLtb2KgL3cmTRxQ5xtdviyRG
 ALMcINSMfsELwIC8J6b8JH0L7actZ+d1/DIDtuP+hjXotDmx9QSbTzEIZ
 G4m8HImg+VZX9GTqW5U4pflHSrTJK7ourxINzP717UV5mIkjPOcGTUBVP g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="346557461"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; d="scan'208";a="346557461"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2023 01:08:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="724781764"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; d="scan'208";a="724781764"
Received: from binbinwu-mobl.ccr.corp.intel.com ([10.238.9.27])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2023 01:08:08 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, chao.gao@intel.com,
 robert.hu@linux.intel.com, binbin.wu@linux.intel.com
Subject: [PATCH v3 2/2] target/i386: add control bits support for LAM
Date: Fri, 21 Jul 2023 16:08:00 +0800
Message-Id: <20230721080800.2329-3-binbin.wu@linux.intel.com>
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

LAM uses CR3[61] and CR3[62] to configure/enable LAM on user pointers.
LAM uses CR4[28] to configure/enable LAM on supervisor pointers.

For CR3 LAM bits, no additional handling needed:
- TCG
  LAM is not supported for TCG of target-i386.  helper_write_crN() and helper_vmrun()
  check max physical address bits before calling cpu_x86_update_cr3(), no change needed,
  i.e. CR3 LAM bits are not allowed to be set in TCG.
- gdbstub
  x86_cpu_gdb_write_register() will call cpu_x86_update_cr3() to update cr3. Allow gdb
  to set the LAM bit(s) to CR3, if vcpu doesn't support LAM, KVM_SET_SREGS will fail as
  other CR3 reserved bits.

For CR4 LAM bit, its reservation depends on vcpu supporting LAM feature or not.
- TCG
  LAM is not supported for TCG of target-i386.  helper_write_crN() and helper_vmrun()
  check CR4 reserved bit before calling cpu_x86_update_cr4(), i.e. CR4 LAM bit is not
  allowed to be set in TCG.
- gdbstub
  x86_cpu_gdb_write_register() will call cpu_x86_update_cr4() to update cr4. Allow gdb
  to set the LAM bit to CR4, if vcpu doesn't support LAM, KVM_SET_SREGS will fail.
- x86_cpu_reset_hold() doesn't need special handling.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 target/i386/cpu.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 4db97899fe..710fadf550 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -261,6 +261,7 @@ typedef enum X86Seg {
 #define CR4_SMAP_MASK   (1U << 21)
 #define CR4_PKE_MASK   (1U << 22)
 #define CR4_PKS_MASK   (1U << 24)
+#define CR4_LAM_SUP_MASK (1U << 28)
 
 #define CR4_RESERVED_MASK \
 (~(target_ulong)(CR4_VME_MASK | CR4_PVI_MASK | CR4_TSD_MASK \
@@ -269,7 +270,8 @@ typedef enum X86Seg {
                 | CR4_OSFXSR_MASK | CR4_OSXMMEXCPT_MASK | CR4_UMIP_MASK \
                 | CR4_LA57_MASK \
                 | CR4_FSGSBASE_MASK | CR4_PCIDE_MASK | CR4_OSXSAVE_MASK \
-                | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | CR4_PKS_MASK))
+                | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | CR4_PKS_MASK \
+                | CR4_LAM_SUP_MASK))
 
 #define DR6_BD          (1 << 13)
 #define DR6_BS          (1 << 14)
@@ -2478,6 +2480,9 @@ static inline uint64_t cr4_reserved_bits(CPUX86State *env)
     if (!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_PKS)) {
         reserved_bits |= CR4_PKS_MASK;
     }
+    if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_LAM)) {
+        reserved_bits |= CR4_LAM_SUP_MASK;
+    }
     return reserved_bits;
 }
 
-- 
2.25.1


