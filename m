Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DBE831B90
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:39:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTX0-0004zX-QA; Thu, 18 Jan 2024 09:38:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rQTWp-0004yl-Dn
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 09:38:00 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rQTWn-0004TI-2y
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 09:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705588677; x=1737124677;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RDgYqj/XVdmu2RMnb6OR9L7CyP8Rr87nWaRWTDOGDU8=;
 b=XMbyJee3HsSWxrc5GWJvG9pzSATX/0QgrmsgprAVmDFMoELNYS9vnem2
 vbbXm2jteZE3O+AJHYHJOSBhm/l9a+WEF17Rl+JkVtUJzXQq80VqOTSn2
 +MdGWhK2oShsBOQYvrfwgtJXWBgBiR15HCvSu6+ukHT6g9Pm50Qz+5DvI
 o3kYA3WthBNIYeA+NNbbLNlwRR/z9XRt0M87p48ikDeZ+IwE1o0bGBh3F
 ZbX5OfKmvgxUGzZGUBXD+FR0PvaUpC7IRzMFGGIbH/QyfUMz9m3nQ2nfR
 /KxeOWb3SBImMKgp1FFX8FdAo3OyDHwlr0GmIzFRmjVE2tZBoC98TGWGV w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="19057223"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; d="scan'208";a="19057223"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2024 06:36:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="329370"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 18 Jan 2024 06:36:17 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Cc: qemu-devel@nongnu.org, Xiaoling Song <xiaoling.song@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 5/8] tests/unit/test-smp-parse.c: Test "drawers" parameter in
 -smp
Date: Thu, 18 Jan 2024 22:48:54 +0800
Message-Id: <20240118144857.2124034-6-zhao1.liu@linux.intel.com>
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

Although drawer was introduced to -smp along with book by s390 machine,
as a general topology level in QEMU that may be reused by other arches
in the future, it is desirable to cover this parameter's parsing in a
separate case.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 tests/unit/test-smp-parse.c | 89 +++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 31f3f713e851..d59e220360d5 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -329,6 +329,11 @@ static const struct SMPTestData data_generic_invalid[] = {
         .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 2, F, 0, T, 2, F,
                                                 0, F, 0, F, 0, F, 0),
         .expect_error = "books not supported by this machine's CPU topology",
+    }, {
+        /* config: -smp 2,drawers=2 */
+        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 2, T, 2, F, 0, F,
+                                                0, F, 0, F, 0, F, 0),
+        .expect_error = "drawers not supported by this machine's CPU topology",
     }, {
         /* config: -smp 8,sockets=2,cores=4,threads=2,maxcpus=8 */
         .config = SMP_CONFIG_GENERIC(T, 8, T, 2, T, 4, T, 2, T, 8),
@@ -420,6 +425,26 @@ static const struct SMPTestData data_with_books_invalid[] = {
     },
 };
 
+static const struct SMPTestData data_with_drawers_invalid[] = {
+    {
+        /* config: -smp 16,drawers=2,sockets=2,cores=4,threads=2,maxcpus=16 */
+        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 16, T, 2, F, 1, T,
+                                                2, T, 4, T, 2, T, 16),
+        .expect_error = "Invalid CPU topology: "
+                        "product of the hierarchy must match maxcpus: "
+                        "drawers (2) * sockets (2) * cores (4) * threads (2) "
+                        "!= maxcpus (16)",
+    }, {
+        /* config: -smp 34,drawers=2,sockets=2,cores=4,threads=2,maxcpus=32 */
+        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 34, T, 2, F, 1, T,
+                                                2, T, 4, T, 2, T, 32),
+        .expect_error = "Invalid CPU topology: "
+                        "maxcpus must be equal to or greater than smp: "
+                        "drawers (2) * sockets (2) * cores (4) * threads (2) "
+                        "== maxcpus (32) < smp_cpus (34)",
+    },
+};
+
 static char *smp_config_to_string(const SMPConfiguration *config)
 {
     return g_strdup_printf(
@@ -666,6 +691,13 @@ static void machine_with_books_class_init(ObjectClass *oc, void *data)
     mc->smp_props.books_supported = true;
 }
 
+static void machine_with_drawers_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->smp_props.drawers_supported = true;
+}
+
 static void test_generic_valid(const void *opaque)
 {
     const char *machine_type = opaque;
@@ -859,6 +891,56 @@ static void test_with_books(const void *opaque)
     object_unref(obj);
 }
 
+static void test_with_drawers(const void *opaque)
+{
+    const char *machine_type = opaque;
+    Object *obj = object_new(machine_type);
+    MachineState *ms = MACHINE(obj);
+    MachineClass *mc = MACHINE_GET_CLASS(obj);
+    SMPTestData data = {};
+    unsigned int num_drawers = 2;
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(data_generic_valid); i++) {
+        data = data_generic_valid[i];
+        unsupported_params_init(mc, &data);
+
+        /* when drawers parameter is omitted, it will be set as 1 */
+        data.expect_prefer_sockets.drawers = 1;
+        data.expect_prefer_cores.drawers = 1;
+
+        smp_parse_test(ms, &data, true);
+
+        /* when drawers parameter is specified */
+        data.config.has_drawers = true;
+        data.config.drawers = num_drawers;
+        if (data.config.has_cpus) {
+            data.config.cpus *= num_drawers;
+        }
+        if (data.config.has_maxcpus) {
+            data.config.maxcpus *= num_drawers;
+        }
+
+        data.expect_prefer_sockets.drawers = num_drawers;
+        data.expect_prefer_sockets.cpus *= num_drawers;
+        data.expect_prefer_sockets.max_cpus *= num_drawers;
+        data.expect_prefer_cores.drawers = num_drawers;
+        data.expect_prefer_cores.cpus *= num_drawers;
+        data.expect_prefer_cores.max_cpus *= num_drawers;
+
+        smp_parse_test(ms, &data, true);
+    }
+
+    for (i = 0; i < ARRAY_SIZE(data_with_drawers_invalid); i++) {
+        data = data_with_drawers_invalid[i];
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
@@ -887,6 +969,10 @@ static const TypeInfo smp_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("smp-with-books"),
         .parent         = TYPE_MACHINE,
         .class_init     = machine_with_books_class_init,
+    }, {
+        .name           = MACHINE_TYPE_NAME("smp-with-drawers"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = machine_with_drawers_class_init,
     }
 };
 
@@ -913,6 +999,9 @@ int main(int argc, char *argv[])
     g_test_add_data_func("/test-smp-parse/with_books",
                          MACHINE_TYPE_NAME("smp-with-books"),
                          test_with_books);
+    g_test_add_data_func("/test-smp-parse/with_drawers",
+                         MACHINE_TYPE_NAME("smp-with-drawers"),
+                         test_with_drawers);
 
     g_test_run();
 
-- 
2.34.1


