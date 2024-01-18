Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E610F831B8E
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:39:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTX0-00052t-TJ; Thu, 18 Jan 2024 09:38:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rQTWi-0004xx-R8
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 09:37:58 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rQTWc-0004TI-VI
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 09:37:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705588667; x=1737124667;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=raK/CZUO9BGxPhxaK6FT5X9pHU+bYuQa1Xhf/KvW4Sk=;
 b=h/yOhP5D5Hxl7z6Zb2/vJQbfnCuQHIlL41qxDMgRVR5/kyIXYk5/yKvv
 N3/jRfZo9YE9BLxH08YLrS+k3CKbXy9aHxGKsZlkNa9lwjVHQQOWXtyMe
 T+p1fcKfVJbPtD96S2Czaoda4dNKABAQ8NJGnUHlwcT+0kjjVN2wvCFQx
 3PT2b/g/8nQBQMobHNN5CmovfeI0viEsXCjwp6xKYhJbp9SCpquKL3GkD
 YoeAF2xLrT12T35Zjvtb1cSQfyZ5qF6IRh1UFkjqPH+P5L9dtfa4S8DRG
 Dsl6ryxvEYZgPVJCFMqYSF43dcUNScAXsluwDsNh502shPcztMRiD9wQH w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="19057100"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; d="scan'208";a="19057100"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2024 06:36:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="329281"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 18 Jan 2024 06:36:10 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Cc: qemu-devel@nongnu.org, Xiaoling Song <xiaoling.song@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/8] tests/unit/test-smp-parse.c: Bump max_cpus to 4096
Date: Thu, 18 Jan 2024 22:48:51 +0800
Message-Id: <20240118144857.2124034-3-zhao1.liu@linux.intel.com>
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

PC mahine is trying to support up to 4096 vCPUs [1], so it's necessary
to bump max_cpus in test-smp-parse to 4096 to cover the topological
needs of future machines.

[1]: https://lore.kernel.org/qemu-devel/20231208122611.32311-1-anisinha@redhat.com/

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 tests/unit/test-smp-parse.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 20c663a006b3..55ba13bf7d15 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -20,8 +20,8 @@
 #define T true
 #define F false
 
-#define MIN_CPUS 1   /* set the min CPUs supported by the machine as 1 */
-#define MAX_CPUS 512 /* set the max CPUs supported by the machine as 512 */
+#define MIN_CPUS 1    /* set the min CPUs supported by the machine as 1 */
+#define MAX_CPUS 4096 /* set the max CPUs supported by the machine as 4096 */
 
 #define SMP_MACHINE_NAME "TEST-SMP"
 
@@ -333,13 +333,13 @@ static const struct SMPTestData data_generic_invalid[] = {
                         "by machine '" SMP_MACHINE_NAME "' is 2",
     }, {
         /*
-         * config: -smp 512
+         * config: -smp 4096
          * The test machine should tweak the supported max CPUs to
-         * 511 (MAX_CPUS - 1) for testing.
+         * 4095 (MAX_CPUS - 1) for testing.
          */
-        .config = SMP_CONFIG_GENERIC(T, MAX_CPUS, F, 0, F, 0, F, 0, F, 0),
-        .expect_error = "Invalid SMP CPUs 512. The max CPUs supported "
-                        "by machine '" SMP_MACHINE_NAME "' is 511",
+        .config = SMP_CONFIG_GENERIC(T, 4096, F, 0, F, 0, F, 0, F, 0),
+        .expect_error = "Invalid SMP CPUs 4096. The max CPUs supported "
+                        "by machine '" SMP_MACHINE_NAME "' is 4095",
     },
 };
 
-- 
2.34.1


