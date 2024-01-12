Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D096882BB20
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 07:02:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOAbN-0004h3-Sl; Fri, 12 Jan 2024 01:01:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1rOAbH-0004gG-7R
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 01:01:03 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1rOAbF-0001cG-8i
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 01:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705039262; x=1736575262;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=T7zTI2fBo/8VZG27Zg+D+2Lu+dRzE4jKGwoDwuPXqZs=;
 b=SEFzJVJ80jvmTm9hjBOFfJ7dyrxCoGtusM1ylaIbOKaxMQOu+b9p5mag
 UTYuNs4dXvtGqD1Inavd6C/8Pfmgo4kOp2T0u1EctjgbJU7jpHQHTU2dM
 0fWVS/p3sIMynEgKTQqEKeX2Hmf6WwKuDIJj2YfvI5F9v2z89raBZc1Ts
 BSWNT551JubOKK20RF0GivxWMkQvQ1a6QkGtdl6P7NDFkaW66M1NTJCqL
 OJGLq+Qz72elfY5gR1hSMHhVxL0UI7CODyar8IYTCMQ7IqdWKSDRozvjI
 TKeDDszx0DXYJtjW9zvaMCMQjQN+TwhtUXFuRoqG+xm+t9d2G30nkwptm w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="5815758"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="5815758"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2024 22:00:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="873274771"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; d="scan'208";a="873274771"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO
 binbinwu-mobl.sh.intel.com) ([10.238.2.99])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2024 22:00:50 -0800
From: Binbin Wu <binbin.wu@linux.intel.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, chao.gao@intel.com,
 robert.hu@linux.intel.com, binbin.wu@linux.intel.com
Subject: [PATCH v4 2/2] target/i386: add control bits support for LAM
Date: Fri, 12 Jan 2024 14:00:42 +0800
Message-Id: <20240112060042.19925-3-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240112060042.19925-1-binbin.wu@linux.intel.com>
References: <20240112060042.19925-1-binbin.wu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.11;
 envelope-from=binbin.wu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
  LAM is not supported for TCG of target-i386.  helper_write_crN() and
  helper_vmrun() check max physical address bits before calling
  cpu_x86_update_cr3(), no change needed, i.e. CR3 LAM bits are not allowed
  to be set in TCG.
- gdbstub
  x86_cpu_gdb_write_register() will call cpu_x86_update_cr3() to update cr3.
  Allow gdb to set the LAM bit(s) to CR3, if vcpu doesn't support LAM,
  KVM_SET_SREGS will fail as other reserved bits.

For CR4 LAM bit, its reservation depends on vcpu supporting LAM feature or
not.
- TCG
  LAM is not supported for TCG of target-i386.  helper_write_crN() and
  helper_vmrun() check CR4 reserved bit before calling cpu_x86_update_cr4(),
  i.e. CR4 LAM bit is not allowed to be set in TCG.
- gdbstub
  x86_cpu_gdb_write_register() will call cpu_x86_update_cr4() to update cr4.
  Mask out LAM bit on CR4 if vcpu doesn't support LAM.
- x86_cpu_reset_hold() doesn't need special handling.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
Tested-by: Xuelian Guo <xuelian.guo@intel.com>
---
 target/i386/cpu.h    | 7 ++++++-
 target/i386/helper.c | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 18ea755644..598a3fa140 100644
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
@@ -2522,6 +2524,9 @@ static inline uint64_t cr4_reserved_bits(CPUX86State *env)
     if (!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_PKS)) {
         reserved_bits |= CR4_PKS_MASK;
     }
+    if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_LAM)) {
+        reserved_bits |= CR4_LAM_SUP_MASK;
+    }
     return reserved_bits;
 }
 
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 2070dd0dda..1da7a7d315 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -219,6 +219,10 @@ void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4)
         new_cr4 &= ~CR4_PKS_MASK;
     }
 
+    if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_LAM)) {
+        new_cr4 &= ~CR4_LAM_SUP_MASK;
+    }
+
     env->cr[4] = new_cr4;
     env->hflags = hflags;
 
-- 
2.25.1


