Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88047831B8C
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:38:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTX1-00054h-9M; Thu, 18 Jan 2024 09:38:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rQTWn-0004yD-4T
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 09:37:58 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rQTWf-0004T0-Hf
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 09:37:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705588669; x=1737124669;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QfOinMTK+1ht/wbdQeHTf0b3RVG46r8xv44ktE/vwyY=;
 b=W3J5p3/0PT/HWCsq3Sf7sODGzdoodPxtM/I3H6wmT5a8e7E0xIzEq39S
 0kHErwihIBIsArPgb379pK/Tfl4cEnUPaYV/9fRnmWnr0w+ullXK7bl1Y
 qauh+uubvWWTs9+Ic7vzTKlm+RB7QPwelgC5HwHj4RnkLa2qcwwvBBpEQ
 i3k8MQcvHiW9GF+S/RK1/CF6na8SRntUYzAeA1UzwUunyGUE7bthlBhjp
 DdPhn2INkUtgfWs5foDuOmdxqq1AGXhKSzMSh4Oh8YqX2TUM/B6InjZHG
 O9pvAJV3EX2skLvSWb5LeVerqNzk+e61vVKVUwyLrbt44iY34O7CY+D/P w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="19057182"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; d="scan'208";a="19057182"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2024 06:36:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="329334"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 18 Jan 2024 06:36:15 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Cc: qemu-devel@nongnu.org, Xiaoling Song <xiaoling.song@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 4/8] tests/unit/test-smp-parse.c: Test "books" parameter in
 -smp
Date: Thu, 18 Jan 2024 22:48:53 +0800
Message-Id: <20240118144857.2124034-5-zhao1.liu@linux.intel.com>
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

Although book was introduced to -smp along with drawer by s390 machine,
as a general topology level in QEMU that may be reused by other arches
in the future, it is desirable to cover this parameter's parsing in a
separate case.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 tests/unit/test-smp-parse.c | 105 ++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index a8eb3bbb35ed..31f3f713e851 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -75,6 +75,22 @@
             .has_maxcpus  = hf, .maxcpus  = f,                \
         }
 
+/*
+ * Currently a 5-level topology hierarchy is supported on s390 ccw machines
+ *  -drawers/books/sockets/cores/threads
+ */
+#define SMP_CONFIG_WITH_BOOKS_DRAWERS(ha, a, hb, b, hc, c, hd, \
+                                      d, he, e, hf, f, hg, g)  \
+        {                                                      \
+            .has_cpus     = ha, .cpus     = a,                 \
+            .has_drawers  = hb, .drawers  = b,                 \
+            .has_books    = hc, .books    = c,                 \
+            .has_sockets  = hd, .sockets  = d,                 \
+            .has_cores    = he, .cores    = e,                 \
+            .has_threads  = hf, .threads  = f,                 \
+            .has_maxcpus  = hg, .maxcpus  = g,                 \
+        }
+
 /**
  * @config - the given SMP configuration
  * @expect_prefer_sockets - the expected parsing result for the
@@ -308,6 +324,11 @@ static const struct SMPTestData data_generic_invalid[] = {
         /* config: -smp 2,clusters=2 */
         .config = SMP_CONFIG_WITH_CLUSTERS(T, 2, F, 0, T, 2, F, 0, F, 0, F, 0),
         .expect_error = "clusters not supported by this machine's CPU topology",
+    }, {
+        /* config: -smp 2,books=2 */
+        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 2, F, 0, T, 2, F,
+                                                0, F, 0, F, 0, F, 0),
+        .expect_error = "books not supported by this machine's CPU topology",
     }, {
         /* config: -smp 8,sockets=2,cores=4,threads=2,maxcpus=8 */
         .config = SMP_CONFIG_GENERIC(T, 8, T, 2, T, 4, T, 2, T, 8),
@@ -379,6 +400,26 @@ static const struct SMPTestData data_with_clusters_invalid[] = {
     },
 };
 
+static const struct SMPTestData data_with_books_invalid[] = {
+    {
+        /* config: -smp 16,books=2,sockets=2,cores=4,threads=2,maxcpus=16 */
+        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 16, F, 1, T, 2, T,
+                                                2, T, 4, T, 2, T, 16),
+        .expect_error = "Invalid CPU topology: "
+                        "product of the hierarchy must match maxcpus: "
+                        "books (2) * sockets (2) * cores (4) * threads (2) "
+                        "!= maxcpus (16)",
+    }, {
+        /* config: -smp 34,books=2,sockets=2,cores=4,threads=2,maxcpus=32 */
+        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 34, F, 1, T, 2, T,
+                                                2, T, 4, T, 2, T, 32),
+        .expect_error = "Invalid CPU topology: "
+                        "maxcpus must be equal to or greater than smp: "
+                        "books (2) * sockets (2) * cores (4) * threads (2) "
+                        "== maxcpus (32) < smp_cpus (34)",
+    },
+};
+
 static char *smp_config_to_string(const SMPConfiguration *config)
 {
     return g_strdup_printf(
@@ -618,6 +659,13 @@ static void machine_with_clusters_class_init(ObjectClass *oc, void *data)
     mc->smp_props.clusters_supported = true;
 }
 
+static void machine_with_books_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->smp_props.books_supported = true;
+}
+
 static void test_generic_valid(const void *opaque)
 {
     const char *machine_type = opaque;
@@ -761,6 +809,56 @@ static void test_with_clusters(const void *opaque)
     object_unref(obj);
 }
 
+static void test_with_books(const void *opaque)
+{
+    const char *machine_type = opaque;
+    Object *obj = object_new(machine_type);
+    MachineState *ms = MACHINE(obj);
+    MachineClass *mc = MACHINE_GET_CLASS(obj);
+    SMPTestData data = {};
+    unsigned int num_books = 2;
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(data_generic_valid); i++) {
+        data = data_generic_valid[i];
+        unsupported_params_init(mc, &data);
+
+        /* when books parameter is omitted, it will be set as 1 */
+        data.expect_prefer_sockets.books = 1;
+        data.expect_prefer_cores.books = 1;
+
+        smp_parse_test(ms, &data, true);
+
+        /* when books parameter is specified */
+        data.config.has_books = true;
+        data.config.books = num_books;
+        if (data.config.has_cpus) {
+            data.config.cpus *= num_books;
+        }
+        if (data.config.has_maxcpus) {
+            data.config.maxcpus *= num_books;
+        }
+
+        data.expect_prefer_sockets.books = num_books;
+        data.expect_prefer_sockets.cpus *= num_books;
+        data.expect_prefer_sockets.max_cpus *= num_books;
+        data.expect_prefer_cores.books = num_books;
+        data.expect_prefer_cores.cpus *= num_books;
+        data.expect_prefer_cores.max_cpus *= num_books;
+
+        smp_parse_test(ms, &data, true);
+    }
+
+    for (i = 0; i < ARRAY_SIZE(data_with_books_invalid); i++) {
+        data = data_with_books_invalid[i];
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
@@ -785,6 +883,10 @@ static const TypeInfo smp_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("smp-with-clusters"),
         .parent         = TYPE_MACHINE,
         .class_init     = machine_with_clusters_class_init,
+    }, {
+        .name           = MACHINE_TYPE_NAME("smp-with-books"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = machine_with_books_class_init,
     }
 };
 
@@ -808,6 +910,9 @@ int main(int argc, char *argv[])
     g_test_add_data_func("/test-smp-parse/with_clusters",
                          MACHINE_TYPE_NAME("smp-with-clusters"),
                          test_with_clusters);
+    g_test_add_data_func("/test-smp-parse/with_books",
+                         MACHINE_TYPE_NAME("smp-with-books"),
+                         test_with_books);
 
     g_test_run();
 
-- 
2.34.1


