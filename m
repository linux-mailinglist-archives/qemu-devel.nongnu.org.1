Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3203831B83
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:38:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTWv-0004z7-Pf; Thu, 18 Jan 2024 09:38:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rQTWi-0004xy-SF
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 09:37:58 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rQTWe-0004Sm-4I
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 09:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705588668; x=1737124668;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1SWHqFeXzNGnco53f5tEtcR6EUCJeAlBwzP8tS2mFJo=;
 b=fEb1BFh61P3IFd21l2VkHinrIJnnRKhxLUQTvMCRLIajazOwHtUHnfcc
 rDYI4hTk/U5idfk2w9oGUz0ZmFGAz2oC+4eQj3uriGuAwnlB7CTo9RL5k
 P5XTPYDXqX3ryadOdOeU2Z9s7LCt7MeeIi2iIuxGqvQjx1lnDQaGGahtE
 /au5bs3okGZiGKhummgX62zyyOe/e2dx/IF4MBsRLY5eMBa4AiDobEfFw
 lCkii7zDTAQX7WHQlamUh96eyiKKdCAHb2/pcxyKZbl5KYgeyVQzqXBAo
 Cf9xuAcufHVaKrk4hUPip7E3ti8y7MS923E/kB6fsg4gnLqXkfHOljdaX Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="19057150"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; d="scan'208";a="19057150"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2024 06:36:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="329305"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 18 Jan 2024 06:36:12 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Cc: qemu-devel@nongnu.org, Xiaoling Song <xiaoling.song@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 3/8] tests/unit/test-smp-parse.c: Make test cases aware of the
 book/drawer
Date: Thu, 18 Jan 2024 22:48:52 +0800
Message-Id: <20240118144857.2124034-4-zhao1.liu@linux.intel.com>
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

Currently, -smp supports 2 more new levels: book and drawer.

It is necessary to consider the effects of book and drawer in the test
cases to ensure that the calculations are correct. This is also the
preparation to add new book and drawer test cases.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 tests/unit/test-smp-parse.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 55ba13bf7d15..a8eb3bbb35ed 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -384,6 +384,8 @@ static char *smp_config_to_string(const SMPConfiguration *config)
     return g_strdup_printf(
         "(SMPConfiguration) {\n"
         "    .has_cpus     = %5s, cpus     = %" PRId64 ",\n"
+        "    .has_drawers  = %5s, drawers  = %" PRId64 ",\n"
+        "    .has_books    = %5s, books    = %" PRId64 ",\n"
         "    .has_sockets  = %5s, sockets  = %" PRId64 ",\n"
         "    .has_dies     = %5s, dies     = %" PRId64 ",\n"
         "    .has_clusters = %5s, clusters = %" PRId64 ",\n"
@@ -392,6 +394,8 @@ static char *smp_config_to_string(const SMPConfiguration *config)
         "    .has_maxcpus  = %5s, maxcpus  = %" PRId64 ",\n"
         "}",
         config->has_cpus ? "true" : "false", config->cpus,
+        config->has_drawers ? "true" : "false", config->drawers,
+        config->has_books ? "true" : "false", config->books,
         config->has_sockets ? "true" : "false", config->sockets,
         config->has_dies ? "true" : "false", config->dies,
         config->has_clusters ? "true" : "false", config->clusters,
@@ -404,10 +408,10 @@ static char *smp_config_to_string(const SMPConfiguration *config)
 static unsigned int cpu_topology_get_threads_per_socket(const CpuTopology *topo)
 {
     /* Check the divisor to avoid invalid topology examples causing SIGFPE. */
-    if (!topo->sockets) {
+    if (!topo->drawers || !topo->books || !topo->sockets) {
         return 0;
     } else {
-        return topo->max_cpus / topo->sockets;
+        return topo->max_cpus / topo->drawers / topo->books / topo->sockets;
     }
 }
 
@@ -429,6 +433,8 @@ static char *cpu_topology_to_string(const CpuTopology *topo,
     return g_strdup_printf(
         "(CpuTopology) {\n"
         "    .cpus               = %u,\n"
+        "    .drawers            = %u,\n"
+        "    .books              = %u,\n"
         "    .sockets            = %u,\n"
         "    .dies               = %u,\n"
         "    .clusters           = %u,\n"
@@ -438,7 +444,8 @@ static char *cpu_topology_to_string(const CpuTopology *topo,
         "    .threads_per_socket = %u,\n"
         "    .cores_per_socket   = %u,\n"
         "}",
-        topo->cpus, topo->sockets, topo->dies, topo->clusters,
+        topo->cpus, topo->drawers, topo->books,
+        topo->sockets, topo->dies, topo->clusters,
         topo->cores, topo->threads, topo->max_cpus,
         threads_per_socket, cores_per_socket);
 }
@@ -473,6 +480,8 @@ static void check_parse(MachineState *ms, const SMPConfiguration *config,
     if (is_valid) {
         if ((err == NULL) &&
             (ms->smp.cpus == expect_topo->cpus) &&
+            (ms->smp.drawers == expect_topo->drawers) &&
+            (ms->smp.books == expect_topo->books) &&
             (ms->smp.sockets == expect_topo->sockets) &&
             (ms->smp.dies == expect_topo->dies) &&
             (ms->smp.clusters == expect_topo->clusters) &&
@@ -564,6 +573,16 @@ static void unsupported_params_init(const MachineClass *mc, SMPTestData *data)
         data->expect_prefer_sockets.clusters = 1;
         data->expect_prefer_cores.clusters = 1;
     }
+
+    if (!mc->smp_props.books_supported) {
+        data->expect_prefer_sockets.books = 1;
+        data->expect_prefer_cores.books = 1;
+    }
+
+    if (!mc->smp_props.drawers_supported) {
+        data->expect_prefer_sockets.drawers = 1;
+        data->expect_prefer_cores.drawers = 1;
+    }
 }
 
 static void machine_base_class_init(ObjectClass *oc, void *data)
-- 
2.34.1


