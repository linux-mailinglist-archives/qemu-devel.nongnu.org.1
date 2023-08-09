Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E3F775704
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 12:23:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTgKr-00063Q-U2; Wed, 09 Aug 2023 06:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qian.wen@intel.com>)
 id 1qTgKq-00063I-2k
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 06:22:36 -0400
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qian.wen@intel.com>)
 id 1qTgKo-000516-12
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 06:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691576554; x=1723112554;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Wh7XBLP58hF4dL5lFiAOGgXc5b/WB4YnPaj7ALK8ev4=;
 b=W2Y/1ezwnKfKaOXL9v4P4jRYjJwAbE9FXCxDZItVyPZ20CYrGc8rk6g/
 CsigT3z+xp8NDMWLsT5qXxTf4N3UZ+48Wlw+kk0vAbMiTzqYqUpSEiOL7
 mIDhRWhEMshC8f36Az924mZJ5P0d0fMPwKBVRAJp5VWjvBvYQTy7Jv1pn
 pr9m8CtEASXc7OptFZTgJEo3FXVWqJ6fHwLr6qSvCQxSVb3JRZqVJRJJN
 IlrzCgDwWup3IWMeNIidjyh+UOlTcjjzKFgID0xEd1v4yIgr569ccO4Fr
 Sc5spr22d0ZyF90khdeNPWKcp+DwRyJGbRFRuMww29ICVtaEwnzqt+G9U g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="373866650"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; d="scan'208";a="373866650"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2023 03:22:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="821797231"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; d="scan'208";a="821797231"
Received: from pc.sh.intel.com ([10.238.200.75])
 by FMSMGA003.fm.intel.com with ESMTP; 09 Aug 2023 03:22:27 -0700
From: Qian Wen <qian.wen@intel.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, babu.moger@amd.com,
 Qian Wen <qian.wen@intel.com>
Subject: [PATCH v2] target/i386: Avoid cpu number overflow in legacy topology
Date: Wed,  9 Aug 2023 18:27:32 +0800
Message-Id: <20230809102732.3124908-1-qian.wen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.24; envelope-from=qian.wen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When launching the VM with -smp 256, the value written to EBX[23:16] is
0 because of data overflow. If the guest only supports legacy topology,
without V2 Extended Topology enumerated by CPUID.0x1f or Extended
Topology enumerated by CPUID.0x0b to support over 255 CPUs, the return
of the kernel invoking cpu_smt_allowed() is false and AP's bring-up will
fail. Then only CPU 0 is online, and others are offline.

To avoid this issue caused by overflow, limit the max value written to
EBX[23:16] to 255.

Signed-off-by: Qian Wen <qian.wen@intel.com>
---
Changes v1 -> v2:
 - Revise the commit message and comment to more clearer.
 - Rebased to v8.1.0-rc2.
---
 target/i386/cpu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 97ad229d8b..6e1d88fbd7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6008,6 +6008,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     uint32_t die_offset;
     uint32_t limit;
     uint32_t signature[3];
+    uint32_t threads_per_socket;
     X86CPUTopoInfo topo_info;
 
     topo_info.dies_per_pkg = env->nr_dies;
@@ -6049,8 +6050,19 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ecx |= CPUID_EXT_OSXSAVE;
         }
         *edx = env->features[FEAT_1_EDX];
-        if (cs->nr_cores * cs->nr_threads > 1) {
-            *ebx |= (cs->nr_cores * cs->nr_threads) << 16;
+        /*
+         * Only bits [23:16] represent the maximum number of addressable
+         * IDs for logical processors in this physical package.
+         * When thread_per_socket > 255, it will 1) overwrite bits[31:24]
+         * which is apic_id, 2) bits [23:16] get truncated.
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
         if (!cpu->enable_pmu) {
-- 
2.25.1


