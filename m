Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8824C787E8B
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 05:27:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZNSm-0000JA-HA; Thu, 24 Aug 2023 23:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qZNSj-0000Iz-8o
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 23:26:17 -0400
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qZNSg-0003wW-UC
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 23:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692933974; x=1724469974;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=86B6Djpk3AsAKdgCoiBoDb6/O76cCHLV9R98JvkYgw0=;
 b=jOR/ay5fADt0tNF20Yv0CLxnG8HVCOwPZPVf7pmeBllSMPpcLEvLDZee
 2FOH3jihCHn9Aqnh5rkf7iZH7DsvPNUAKM5Hn7B8yUIb56lu+tCW9NORl
 ApEVHwdFbwNfqaeOI2PQCM2m1Fv0hUhXZ0EE+garYQQ6C8ajIcixTPMYH
 u5oXEHFEFEJjrNz04jTO2xWV7mxLMqaHMNmF5ojBVJO5DL1MslwI0kPdi
 P35PP9VI19DtXe96l4I6ulQ38qWWiIsEGc0t9cYWA3UtF2gfsSpHE4IMD
 c6uPUnbcQLUHhMb4DB20kIbAN2fkK4XJRRrEf7Qy+FMav0i37c7527wWq w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="374595598"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; d="scan'208";a="374595598"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2023 20:26:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="714201467"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; d="scan'208";a="714201467"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga006.jf.intel.com with ESMTP; 24 Aug 2023 20:26:10 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 01/16] tests: test-smp-parse: Add the test for cores/threads
 per socket helpers
Date: Fri, 25 Aug 2023 11:36:04 +0800
Message-Id: <20230825033619.2075837-2-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825033619.2075837-1-zhao1.liu@linux.intel.com>
References: <20230825033619.2075837-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.115;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Use the different ways to calculate cores/threads per socket, so that
the new CPU topology levels won't be missed in these 2 helpes:

* machine_topo_get_cores_per_socket()
* machine_topo_get_threads_per_socket()

Test the commit a1d027be95bc3 ("machine: Add helpers to get cores/
threads per socket").

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 tests/unit/test-smp-parse.c | 67 ++++++++++++++++++++++++++++++-------
 1 file changed, 54 insertions(+), 13 deletions(-)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index fdc39a846ca6..24972666a74d 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -394,20 +394,47 @@ static char *smp_config_to_string(const SMPConfiguration *config)
         config->has_maxcpus ? "true" : "false", config->maxcpus);
 }
 
-static char *cpu_topology_to_string(const CpuTopology *topo)
+/* Use the different calculation than machine_topo_get_threads_per_socket(). */
+static unsigned int cpu_topology_get_threads_per_socket(const CpuTopology *topo)
+{
+    /* Check the divisor to avoid invalid topology examples causing SIGFPE. */
+    if (!topo->sockets) {
+        return 0;
+    } else {
+        return topo->max_cpus / topo->sockets;
+    }
+}
+
+/* Use the different calculation than machine_topo_get_cores_per_socket(). */
+static unsigned int cpu_topology_get_cores_per_socket(const CpuTopology *topo)
+{
+    /* Check the divisor to avoid invalid topology examples causing SIGFPE. */
+    if (!topo->threads) {
+        return 0;
+    } else {
+        return cpu_topology_get_threads_per_socket(topo) / topo->threads;
+    }
+}
+
+static char *cpu_topology_to_string(const CpuTopology *topo,
+                                    unsigned int threads_per_socket,
+                                    unsigned int cores_per_socket)
 {
     return g_strdup_printf(
         "(CpuTopology) {\n"
-        "    .cpus     = %u,\n"
-        "    .sockets  = %u,\n"
-        "    .dies     = %u,\n"
-        "    .clusters = %u,\n"
-        "    .cores    = %u,\n"
-        "    .threads  = %u,\n"
-        "    .max_cpus = %u,\n"
+        "    .cpus               = %u,\n"
+        "    .sockets            = %u,\n"
+        "    .dies               = %u,\n"
+        "    .clusters           = %u,\n"
+        "    .cores              = %u,\n"
+        "    .threads            = %u,\n"
+        "    .max_cpus           = %u,\n"
+        "    .threads_per_socket = %u,\n"
+        "    .cores_per_socket   = %u,\n"
         "}",
         topo->cpus, topo->sockets, topo->dies, topo->clusters,
-        topo->cores, topo->threads, topo->max_cpus);
+        topo->cores, topo->threads, topo->max_cpus,
+        threads_per_socket, cores_per_socket);
 }
 
 static void check_parse(MachineState *ms, const SMPConfiguration *config,
@@ -415,14 +442,26 @@ static void check_parse(MachineState *ms, const SMPConfiguration *config,
                         bool is_valid)
 {
     g_autofree char *config_str = smp_config_to_string(config);
-    g_autofree char *expect_topo_str = cpu_topology_to_string(expect_topo);
-    g_autofree char *output_topo_str = NULL;
+    g_autofree char *expect_topo_str = NULL, *output_topo_str = NULL;
+    unsigned int expect_threads_per_socket, expect_cores_per_socket;
+    unsigned int ms_threads_per_socket, ms_cores_per_socket;
     Error *err = NULL;
 
+    expect_threads_per_socket =
+                        cpu_topology_get_threads_per_socket(expect_topo);
+    expect_cores_per_socket =
+                        cpu_topology_get_cores_per_socket(expect_topo);
+    expect_topo_str = cpu_topology_to_string(expect_topo,
+                                             expect_threads_per_socket,
+                                             expect_cores_per_socket);
+
     /* call the generic parser */
     machine_parse_smp_config(ms, config, &err);
 
-    output_topo_str = cpu_topology_to_string(&ms->smp);
+    ms_threads_per_socket = machine_topo_get_threads_per_socket(ms);
+    ms_cores_per_socket = machine_topo_get_cores_per_socket(ms);
+    output_topo_str = cpu_topology_to_string(&ms->smp, ms_threads_per_socket,
+                                             ms_cores_per_socket);
 
     /* when the configuration is supposed to be valid */
     if (is_valid) {
@@ -433,7 +472,9 @@ static void check_parse(MachineState *ms, const SMPConfiguration *config,
             (ms->smp.clusters == expect_topo->clusters) &&
             (ms->smp.cores == expect_topo->cores) &&
             (ms->smp.threads == expect_topo->threads) &&
-            (ms->smp.max_cpus == expect_topo->max_cpus)) {
+            (ms->smp.max_cpus == expect_topo->max_cpus) &&
+            (ms_threads_per_socket == expect_threads_per_socket) &&
+            (ms_cores_per_socket == expect_cores_per_socket)) {
             return;
         }
 
-- 
2.34.1


