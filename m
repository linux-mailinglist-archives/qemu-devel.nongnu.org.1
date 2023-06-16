Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A584D7325D0
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 05:24:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA03b-0000EA-KG; Thu, 15 Jun 2023 23:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qA03Z-0000DK-US
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 23:23:25 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qA03Y-0002FT-CW
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 23:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686885804; x=1718421804;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=g5659xiMVup3wt5LX08hxZGyXfUKj970C0M06dtCxOA=;
 b=nSeXQtlgQysytmMKWFqpA2aRMJXxIYoAqr/KhsooA50X3kC5sSXRMNiG
 4R8J/jZ7gP3bcN8HoH4hxm/gSXSMlpWbnyoRqCIxex25R3bnvasoilbNP
 V3vJdmJZZ6cNLBFWLnDUNIBk+xa7wYuWyFN3JHI1RDeI6do31tfePxbkq
 RzTq+mBdr+FCke+RIrMYy8wsGBcZotI5BQPCu75Vxf1UocV8QVRN8427A
 RBlQ9RZDr/FeLKA3peSNLOdz738Ot5QQpbkiNLkaVKdEUs/yE2cmRxt6v
 6H6LoYxf1+OCaCLldQx7jPK+nFV6MgMJVwY82u1ZkgBoizY0xKMV4ZMwf w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="357979162"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; d="scan'208";a="357979162"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2023 20:23:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="715845986"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; d="scan'208";a="715845986"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by fmsmga007.fm.intel.com with ESMTP; 15 Jun 2023 20:23:21 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, lei4.wang@intel.com,
 qian.wen@intel.com, imammedo@redhat.com, tao1.su@linux.intel.com
Subject: [PATCH 3/7] target/i386: Allow MCDT_NO if host supports
Date: Fri, 16 Jun 2023 11:23:07 +0800
Message-Id: <20230616032311.19137-4-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616032311.19137-1-tao1.su@linux.intel.com>
References: <20230616032311.19137-1-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.120;
 envelope-from=tao1.su@linux.intel.com; helo=mga04.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

MCDT_NO bit indicates HW contains the security fix and doesn't need to
be mitigated to avoid data-dependent behaviour for certain instructions.
It needs no hypervisor support. Treat it as supported regardless of what
KVM reports.

Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/kvm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index de531842f6..4defd8b479 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -432,6 +432,11 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
         uint32_t eax;
         host_cpuid(7, 1, &eax, &unused, &unused, &unused);
         ret |= eax & (CPUID_7_1_EAX_FZRM | CPUID_7_1_EAX_FSRS | CPUID_7_1_EAX_FSRC);
+    } else if (function == 7 && index == 2 && reg == R_EDX) {
+        /* Not new instructions, just an optimization.  */
+        uint32_t edx;
+        host_cpuid(7, 2, &unused, &unused, &unused, &edx);
+        ret |= edx & CPUID_7_2_EDX_MCDT_NO;
     } else if (function == 0xd && index == 0 &&
                (reg == R_EAX || reg == R_EDX)) {
         /*
-- 
2.34.1


