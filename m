Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDFF831B88
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:38:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTX0-0004zV-NT; Thu, 18 Jan 2024 09:38:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rQTWf-0004ux-1T
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 09:37:50 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rQTWZ-0004T0-AI
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 09:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705588663; x=1737124663;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=scLXbUoC+ZDyb0yjC19HMwOlFwwAZ+GFvAD3rT1YF14=;
 b=Od+vLzl2UKCeNtHv4Ai+hw6Hs5ztnDPS2anO0u6ckNtpfbP6nERpPaZt
 bqUo1g/0eko/ZNZvhIgnishR5FfONfLxqGQiwiyWlaTrz8Lm12ZCy8WHJ
 xRCyMXleyHoqPboAeMH2oqhK/LT+8+Sd+9NDXjOpOgK5iuPVAEpzAPyVt
 uieiTroAUjJOgpnyGGlzW27k/nnP3DbgegZS0ikVLHgJwnClWU1B3FHzZ
 eydDfOYhr0Le8IIM32ZbNuoBQkzQcWZis/dgfLTeQwCqb5y2BiOkkgqUO
 bcpK+4uHFFX5iJBMf6PaCuk1Det/k5wesY2PeDl2VWDjjFGG2m33vf5m7 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="19057059"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; d="scan'208";a="19057059"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2024 06:36:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="329252"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 18 Jan 2024 06:36:08 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Cc: qemu-devel@nongnu.org, Xiaoling Song <xiaoling.song@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 1/8] tests/unit/test-smp-parse.c: Use CPU number macros in
 invalid topology case
Date: Thu, 18 Jan 2024 22:48:50 +0800
Message-Id: <20240118144857.2124034-2-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118144857.2124034-1-zhao1.liu@linux.intel.com>
References: <20240118144857.2124034-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.9;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

From: Zhao Liu <zhao1.liu@intel.com>

Use MAX_CPUS/MIN_CPUS micros in invalid topology case. This gives us the
flexibility to change the maximum and minimum CPU limits.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 tests/unit/test-smp-parse.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 24972666a74d..20c663a006b3 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -323,15 +323,21 @@ static const struct SMPTestData data_generic_invalid[] = {
                         "sockets (2) * cores (4) * threads (2) "
                         "== maxcpus (16) < smp_cpus (18)",
     }, {
-        /* config: -smp 1
-         * should tweak the supported min CPUs to 2 for testing */
-        .config = SMP_CONFIG_GENERIC(T, 1, F, 0, F, 0, F, 0, F, 0),
+        /*
+         * config: -smp 1
+         * The test machine should tweak the supported min CPUs to
+         * 2 (MIN_CPUS + 1) for testing.
+         */
+        .config = SMP_CONFIG_GENERIC(T, MIN_CPUS, F, 0, F, 0, F, 0, F, 0),
         .expect_error = "Invalid SMP CPUs 1. The min CPUs supported "
                         "by machine '" SMP_MACHINE_NAME "' is 2",
     }, {
-        /* config: -smp 512
-         * should tweak the supported max CPUs to 511 for testing */
-        .config = SMP_CONFIG_GENERIC(T, 512, F, 0, F, 0, F, 0, F, 0),
+        /*
+         * config: -smp 512
+         * The test machine should tweak the supported max CPUs to
+         * 511 (MAX_CPUS - 1) for testing.
+         */
+        .config = SMP_CONFIG_GENERIC(T, MAX_CPUS, F, 0, F, 0, F, 0, F, 0),
         .expect_error = "Invalid SMP CPUs 512. The max CPUs supported "
                         "by machine '" SMP_MACHINE_NAME "' is 511",
     },
@@ -575,8 +581,8 @@ static void machine_generic_invalid_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
 
     /* Force invalid min CPUs and max CPUs */
-    mc->min_cpus = 2;
-    mc->max_cpus = 511;
+    mc->min_cpus = MIN_CPUS + 1;
+    mc->max_cpus = MAX_CPUS - 1;
 }
 
 static void machine_with_dies_class_init(ObjectClass *oc, void *data)
-- 
2.34.1


