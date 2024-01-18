Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34323831B8A
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:38:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTX5-000572-Al; Thu, 18 Jan 2024 09:38:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rQTWq-0004zI-Qt
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 09:38:02 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rQTWn-0004Sm-2x
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 09:38:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705588677; x=1737124677;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=a/xabLPMBsdO48zQjvhZ0Bv6j9AKZrtM0IobJMO/WNE=;
 b=bLZ6WCCjNeFUsQM0izVQY/6bdzJiGUAS+l4psualWev7lXx5inCLLef/
 UM4vzhbXrmh1ndIhP1F2iZKKA9Lu7NnylYS3aCunZfPb0LAmKp9lQ8041
 Rf27Qfhh+QUYfskQDaWYUS8eK3oFFPl+QWN6CFRve5uYhg/Bulnp0bcWG
 PY5gRs/RkmLT/jMzRDGJi7Hk2HqviHv8OY2qdFKi1PcrI5hrXDXLLfo8t
 2k3bl5w1rqL8EwG+LoE2U18EAECHMrvUo5qzsPEkyn4lwVXPf6XelxPX0
 iymFYwNSyEJQGfFGbyrUXOqVXxof6jQVefepCdLQvcBq828JCmdwXAuYj A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="19057277"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; d="scan'208";a="19057277"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2024 06:36:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="329390"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 18 Jan 2024 06:36:19 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Cc: qemu-devel@nongnu.org, Xiaoling Song <xiaoling.song@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 6/8] tests/unit/test-smp-parse.c: Test "drawers" and "books"
 combination case
Date: Thu, 18 Jan 2024 22:48:55 +0800
Message-Id: <20240118144857.2124034-7-zhao1.liu@linux.intel.com>
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

Since s390 machine supports both "drawers" and "books" in -smp, add the
"drawers" and "books" combination test case to match the actual topology
usage scenario.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 tests/unit/test-smp-parse.c | 103 ++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index d59e220360d5..a1ef297248cd 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -445,6 +445,33 @@ static const struct SMPTestData data_with_drawers_invalid[] = {
     },
 };
 
+static const struct SMPTestData data_with_drawers_books_invalid[] = {
+    {
+        /*
+         * config: -smp 200,drawers=2,books=2,sockets=2,cores=4,\
+         * threads=2,maxcpus=200
+         */
+        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 200, T, 3, T, 5, T,
+                                                2, T, 4, T, 2, T, 200),
+        .expect_error = "Invalid CPU topology: "
+                        "product of the hierarchy must match maxcpus: "
+                        "drawers (3) * books (5) * sockets (2) * "
+                        "cores (4) * threads (2) != maxcpus (200)",
+    }, {
+        /*
+         * config: -smp 242,drawers=2,books=2,sockets=2,cores=4,\
+         * threads=2,maxcpus=240
+         */
+        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 242, T, 3, T, 5, T,
+                                                2, T, 4, T, 2, T, 240),
+        .expect_error = "Invalid CPU topology: "
+                        "maxcpus must be equal to or greater than smp: "
+                        "drawers (3) * books (5) * sockets (2) * "
+                        "cores (4) * threads (2) "
+                        "== maxcpus (240) < smp_cpus (242)",
+    },
+};
+
 static char *smp_config_to_string(const SMPConfiguration *config)
 {
     return g_strdup_printf(
@@ -698,6 +725,14 @@ static void machine_with_drawers_class_init(ObjectClass *oc, void *data)
     mc->smp_props.drawers_supported = true;
 }
 
+static void machine_with_drawers_books_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->smp_props.drawers_supported = true;
+    mc->smp_props.books_supported = true;
+}
+
 static void test_generic_valid(const void *opaque)
 {
     const char *machine_type = opaque;
@@ -941,6 +976,67 @@ static void test_with_drawers(const void *opaque)
     object_unref(obj);
 }
 
+static void test_with_drawers_books(const void *opaque)
+{
+    const char *machine_type = opaque;
+    Object *obj = object_new(machine_type);
+    MachineState *ms = MACHINE(obj);
+    MachineClass *mc = MACHINE_GET_CLASS(obj);
+    SMPTestData data = {};
+    unsigned int num_drawers = 5, num_books = 3;
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(data_generic_valid); i++) {
+        data = data_generic_valid[i];
+        unsupported_params_init(mc, &data);
+
+        /*
+         * when drawers and books parameters are omitted, they will
+         * be both set as 1.
+         */
+        data.expect_prefer_sockets.drawers = 1;
+        data.expect_prefer_sockets.books = 1;
+        data.expect_prefer_cores.drawers = 1;
+        data.expect_prefer_cores.books = 1;
+
+        smp_parse_test(ms, &data, true);
+
+        /* when drawers and books parameters are both specified */
+        data.config.has_drawers = true;
+        data.config.drawers = num_drawers;
+        data.config.has_books = true;
+        data.config.books = num_books;
+
+        if (data.config.has_cpus) {
+            data.config.cpus *= num_drawers * num_books;
+        }
+        if (data.config.has_maxcpus) {
+            data.config.maxcpus *= num_drawers * num_books;
+        }
+
+        data.expect_prefer_sockets.drawers = num_drawers;
+        data.expect_prefer_sockets.books = num_books;
+        data.expect_prefer_sockets.cpus *= num_drawers * num_books;
+        data.expect_prefer_sockets.max_cpus *= num_drawers * num_books;
+
+        data.expect_prefer_cores.drawers = num_drawers;
+        data.expect_prefer_cores.books = num_books;
+        data.expect_prefer_cores.cpus *= num_drawers * num_books;
+        data.expect_prefer_cores.max_cpus *= num_drawers * num_books;
+
+        smp_parse_test(ms, &data, true);
+    }
+
+    for (i = 0; i < ARRAY_SIZE(data_with_drawers_books_invalid); i++) {
+        data = data_with_drawers_books_invalid[i];
+        unsupported_params_init(mc, &data);
+
+        smp_parse_test(ms, &data, false);
+    }
+
+    object_unref(obj);
+}
+
 /* Type info of the tested machine */
 static const TypeInfo smp_machine_types[] = {
     {
@@ -973,6 +1069,10 @@ static const TypeInfo smp_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("smp-with-drawers"),
         .parent         = TYPE_MACHINE,
         .class_init     = machine_with_drawers_class_init,
+    }, {
+        .name           = MACHINE_TYPE_NAME("smp-with-drawers-books"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = machine_with_drawers_books_class_init,
     }
 };
 
@@ -1002,6 +1102,9 @@ int main(int argc, char *argv[])
     g_test_add_data_func("/test-smp-parse/with_drawers",
                          MACHINE_TYPE_NAME("smp-with-drawers"),
                          test_with_drawers);
+    g_test_add_data_func("/test-smp-parse/with_drawers_books",
+                         MACHINE_TYPE_NAME("smp-with-drawers-books"),
+                         test_with_drawers_books);
 
     g_test_run();
 
-- 
2.34.1


