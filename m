Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE307D2E82
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 11:35:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qurL6-0005lK-4T; Mon, 23 Oct 2023 05:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qurL3-0005l0-EV
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 05:35:09 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qurL1-000515-It
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 05:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698053708; x=1729589708;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YC4cLHG5Ot3FNIJG1fOkplASOnZFJvLnF/OKwjmaqso=;
 b=QU+gTMP2bmnnYDrNzDIBHtIa6uOHZ/DSVJRPPVwcrbQV2scXbn8orWoQ
 h284+KK7s7nREE7corsbywPt5fY30U3tISaqOOOIoOot1QAZXRcEOFKy4
 eqTS6He/Avm+8JhKS14RYQiO1TeTlryJMpyxzXvl7FdLlUjJ2mGJ2KNsF
 ysdTzFzzGRLSaMGKlIut8Y/7RHgYSEb+RIFQ8Xsvnrr+18WXXlsA5Wa3l
 iQZiQbMVd0cb9n/jnwLP1G7GjoHcRI2KdbkEtd6LPEm47d7esDAYK/Il4
 uKouU9+cHUuoSG2ABHoxL+/xAaU+q0mjDYUkb8B7DdDGdsF+b+tNASfjr A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="8359479"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="8359479"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2023 02:35:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="707882899"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; d="scan'208";a="707882899"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga003.jf.intel.com with ESMTP; 23 Oct 2023 02:35:00 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 01/16] tests: test-smp-parse: Add the test for
 cores/threads per socket helpers
Date: Mon, 23 Oct 2023 17:46:20 +0800
Message-Id: <20231023094635.1588282-2-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023094635.1588282-1-zhao1.liu@linux.intel.com>
References: <20231023094635.1588282-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
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


