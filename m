Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B527D766804
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 11:00:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPIT3-0000dA-O0; Fri, 28 Jul 2023 04:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qian.wen@intel.com>)
 id 1qPIT1-0000d2-8Y
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 04:04:55 -0400
Received: from [134.134.136.126] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qian.wen@intel.com>)
 id 1qPISz-000396-0z
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 04:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690531493; x=1722067493;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=sFI1OAlNaKUehdKLnVhjSxxvKxggVgE5NufYvhSSFzg=;
 b=hjsefpEgntlx+LnZS9/SCBCPJQkuaOusnUJDkwbqUMmUC5iTzuKMbMZg
 5AaGjQMJkejIyaQlBaFYnlFj8DcfrvSW72czrwdPykuEUI7AKVB70s8hQ
 swT4xsXCG6kU73TjzR7fc1QEDrgaldB6IKz2PN8vKNmFwZ74/oF2tWSoN
 vO15QieMm/VUn+T2NQGX0TW5tU/JoWDfVtOzNNPRAdwWkd3unoNnpYPSU
 Bym6DCeSXWScuYjiXKg7eTJWez6525CbovV2VxjVHeRpjTkhM7nURGOEQ
 78/SQApZAifUWI3pXWIdn7yPvfyXanIGTDC5jVRz+ddB0ueL4YQf5gwqg w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="353440651"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; d="scan'208";a="353440651"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2023 00:57:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="727378942"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; d="scan'208";a="727378942"
Received: from pc.sh.intel.com ([10.238.200.75])
 by orsmga002.jf.intel.com with ESMTP; 28 Jul 2023 00:57:36 -0700
From: Qian Wen <qian.wen@intel.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com, zhao1.liu@intel.com, Qian Wen <qian.wen@intel.com>
Subject: [PATCH] target/i386: Avoid cpu number overflow in legacy topology
Date: Fri, 28 Jul 2023 16:01:50 +0800
Message-Id: <20230728080150.2958048-1-qian.wen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 134.134.136.126 (failed)
Received-SPF: pass client-ip=134.134.136.126; envelope-from=qian.wen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The legacy topology enumerated by CPUID.1.EBX[23:16] is defined in SDM
Vol2:

Bits 23-16: Maximum number of addressable IDs for logical processors in
this physical package.

To avoid data overflow, limit the max value written to EBX[23:16] to
255.

Signed-off-by: Qian Wen <qian.wen@intel.com>
---
 target/i386/cpu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1294be374ab2..70589a58b727 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5356,6 +5356,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     uint32_t die_offset;
     uint32_t limit;
     uint32_t signature[3];
+    uint32_t threads_per_socket;
     X86CPUTopoInfo topo_info;
 
     topo_info.dies_per_pkg = env->nr_dies;
@@ -5397,8 +5398,18 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ecx |= CPUID_EXT_OSXSAVE;
         }
         *edx = env->features[FEAT_1_EDX];
-        if (cs->nr_cores * cs->nr_threads > 1) {
-            *ebx |= (cs->nr_cores * cs->nr_threads) << 16;
+        /*
+         * The vCPU number more than 255 needs support of V2 Extended
+         * Topology enumerated by CPUID.0x1f or Extended Topology
+         * enumerated by CPUID.0x0b.
+         */
+        threads_per_socket = cs->nr_cores * cs->nr_threads;
+        if (threads_per_socket > 255) {
+            threads_per_socket = 255;
+        }
+
+        if (threads_per_socket > 1) {
+            *ebx |= threads_per_socket << 16;
             *edx |= CPUID_HT;
         }
         /*
-- 
2.25.1


