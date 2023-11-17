Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5067EECDC
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 08:41:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3tSp-0005fS-9H; Fri, 17 Nov 2023 02:40:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1r3tSk-0005N7-2o
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 02:40:27 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1r3tSf-0008K1-Bu
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 02:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700206821; x=1731742821;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2cHMC5a5BJRlD/PsC4aspwTroLUP40TmuAMHURKso6g=;
 b=Dc4pDGZr76zF4tcjabiEOvw4XWRNQjQ4zNl04NCQdyfW0h7L4iJT19vd
 0d5hhc0MrkIIc/WPih9zNh36pqhkI/8s+U772sat/9rQd+7Md1GKcT/P7
 D6tvtYm3Kl3lAzxDjMWboycVWJl0u1e1JRwhFq42XQP0YWiL5dY92H7vj
 MvvQwgx/ZKp/XxBSSEeEOWAjCiMmY8+XGEvoUSL5Y2Ow60TEti9n+jDhl
 yJtTCLlSFnX3BNfVsxgp1U7D4DVlAuP06drsTrszOKKNKUtFMZjXouA2V
 /guMekPxuBqfSE/sUTSrJN2X7TwSIcno9oFB3IwOSbjf0X5Bg6MGELZeG w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="395180393"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; d="scan'208";a="395180393"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2023 23:40:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="883042813"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; d="scan'208";a="883042813"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmsmga002.fm.intel.com with ESMTP; 16 Nov 2023 23:40:01 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v6 11/16] tests: Add test case of APIC ID for module level
 parsing
Date: Fri, 17 Nov 2023 15:51:01 +0800
Message-Id: <20231117075106.432499-12-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117075106.432499-1-zhao1.liu@linux.intel.com>
References: <20231117075106.432499-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.65;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
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

From: Zhuocheng Ding <zhuocheng.ding@intel.com>

After i386 supports module level, it's time to add the test for module
level's parsing.

Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Yanan Wang <wangyanan55@huawei.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/unit/test-x86-topo.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tests/unit/test-x86-topo.c b/tests/unit/test-x86-topo.c
index f21b8a5d95c2..55b731ccae55 100644
--- a/tests/unit/test-x86-topo.c
+++ b/tests/unit/test-x86-topo.c
@@ -37,6 +37,7 @@ static void test_topo_bits(void)
     topo_info = (X86CPUTopoInfo) {1, 1, 1, 1};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 0);
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 0);
+    g_assert_cmpuint(apicid_module_width(&topo_info), ==, 0);
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
 
     topo_info = (X86CPUTopoInfo) {1, 1, 1, 1};
@@ -74,13 +75,22 @@ static void test_topo_bits(void)
     topo_info = (X86CPUTopoInfo) {1, 1, 33, 2};
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 6);
 
-    topo_info = (X86CPUTopoInfo) {1, 1, 30, 2};
+    topo_info = (X86CPUTopoInfo) {1, 6, 30, 2};
+    g_assert_cmpuint(apicid_module_width(&topo_info), ==, 3);
+    topo_info = (X86CPUTopoInfo) {1, 7, 30, 2};
+    g_assert_cmpuint(apicid_module_width(&topo_info), ==, 3);
+    topo_info = (X86CPUTopoInfo) {1, 8, 30, 2};
+    g_assert_cmpuint(apicid_module_width(&topo_info), ==, 3);
+    topo_info = (X86CPUTopoInfo) {1, 9, 30, 2};
+    g_assert_cmpuint(apicid_module_width(&topo_info), ==, 4);
+
+    topo_info = (X86CPUTopoInfo) {1, 6, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
-    topo_info = (X86CPUTopoInfo) {2, 1, 30, 2};
+    topo_info = (X86CPUTopoInfo) {2, 6, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 1);
-    topo_info = (X86CPUTopoInfo) {3, 1, 30, 2};
+    topo_info = (X86CPUTopoInfo) {3, 6, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 2);
-    topo_info = (X86CPUTopoInfo) {4, 1, 30, 2};
+    topo_info = (X86CPUTopoInfo) {4, 6, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 2);
 
     /* build a weird topology and see if IDs are calculated correctly
@@ -91,6 +101,7 @@ static void test_topo_bits(void)
     topo_info = (X86CPUTopoInfo) {1, 1, 6, 3};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
     g_assert_cmpuint(apicid_core_offset(&topo_info), ==, 2);
+    g_assert_cmpuint(apicid_module_offset(&topo_info), ==, 5);
     g_assert_cmpuint(apicid_die_offset(&topo_info), ==, 5);
     g_assert_cmpuint(apicid_pkg_offset(&topo_info), ==, 5);
 
-- 
2.34.1


