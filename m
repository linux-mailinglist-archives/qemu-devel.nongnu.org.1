Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14874831B8B
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:38:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTX2-00055j-M7; Thu, 18 Jan 2024 09:38:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rQTWt-0004zb-73
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 09:38:05 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rQTWr-0004TI-5q
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 09:38:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705588681; x=1737124681;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=puRksK45xSTrVV4ALj1HMgknReXjDrc3DoIKDgHTG+E=;
 b=F/3O2kxGozAjsdEibvTo/O+gxT12MwaD7xZ71OpB1dWcCUPpzpc7WQtT
 6jaclthHuuhjy0p9y2pBDi4SS/xdvQuEltZ0hmQHkFFAu9EQtMLa7BY/4
 f6h8JvgnDqrl9isSdhyma/sJI+mxh2iQqNMM5xLlmE3LY4zPRxWNn1Uaa
 vJ5ifcdWV6mjgAUT8mm+Ol5ZLl7s7zt8eypCGPVgiD9XYQiaRcoTDLzFR
 4LOZ2OlZ2GGZzVL50V2qXjmzaNv6CNZF69XMqRgQGoBOhcCqkrjKedhcc
 qf4Jd9WxH+hQG7LW3Eo8KiwoMDuczQVRa60zCOtUlyX40EbU1XFBOOT/4 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="19057338"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; d="scan'208";a="19057338"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2024 06:36:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="329428"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 18 Jan 2024 06:36:24 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Cc: qemu-devel@nongnu.org, Xiaoling Song <xiaoling.song@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 8/8] tests/unit/test-smp-parse.c: Test smp_props.has_clusters
Date: Thu, 18 Jan 2024 22:48:57 +0800
Message-Id: <20240118144857.2124034-9-zhao1.liu@linux.intel.com>
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

The smp_props.has_clusters in MachineClass is not a user configured
field, and it indicates if user specifies "clusters" in -smp.

After -smp parsing, other module could aware if the cluster level
is configured by user. This is used when the machine has only 1 cluster
since there's only 1 cluster by default.

Add the check to cover this field.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 tests/unit/test-smp-parse.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 1d1f10b4faf0..bc55af96f30d 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -573,7 +573,8 @@ static unsigned int cpu_topology_get_cores_per_socket(const CpuTopology *topo)
 
 static char *cpu_topology_to_string(const CpuTopology *topo,
                                     unsigned int threads_per_socket,
-                                    unsigned int cores_per_socket)
+                                    unsigned int cores_per_socket,
+                                    bool has_clusters)
 {
     return g_strdup_printf(
         "(CpuTopology) {\n"
@@ -588,17 +589,20 @@ static char *cpu_topology_to_string(const CpuTopology *topo,
         "    .max_cpus           = %u,\n"
         "    .threads_per_socket = %u,\n"
         "    .cores_per_socket   = %u,\n"
+        "    .has_clusters       = %s,\n"
         "}",
         topo->cpus, topo->drawers, topo->books,
         topo->sockets, topo->dies, topo->clusters,
         topo->cores, topo->threads, topo->max_cpus,
-        threads_per_socket, cores_per_socket);
+        threads_per_socket, cores_per_socket,
+        has_clusters ? "true" : "false");
 }
 
 static void check_parse(MachineState *ms, const SMPConfiguration *config,
                         const CpuTopology *expect_topo, const char *expect_err,
                         bool is_valid)
 {
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
     g_autofree char *config_str = smp_config_to_string(config);
     g_autofree char *expect_topo_str = NULL, *output_topo_str = NULL;
     unsigned int expect_threads_per_socket, expect_cores_per_socket;
@@ -611,15 +615,18 @@ static void check_parse(MachineState *ms, const SMPConfiguration *config,
                         cpu_topology_get_cores_per_socket(expect_topo);
     expect_topo_str = cpu_topology_to_string(expect_topo,
                                              expect_threads_per_socket,
-                                             expect_cores_per_socket);
+                                             expect_cores_per_socket,
+                                             config->has_clusters);
 
     /* call the generic parser */
     machine_parse_smp_config(ms, config, &err);
 
     ms_threads_per_socket = machine_topo_get_threads_per_socket(ms);
     ms_cores_per_socket = machine_topo_get_cores_per_socket(ms);
-    output_topo_str = cpu_topology_to_string(&ms->smp, ms_threads_per_socket,
-                                             ms_cores_per_socket);
+    output_topo_str = cpu_topology_to_string(&ms->smp,
+                                             ms_threads_per_socket,
+                                             ms_cores_per_socket,
+                                             mc->smp_props.has_clusters);
 
     /* when the configuration is supposed to be valid */
     if (is_valid) {
@@ -634,7 +641,8 @@ static void check_parse(MachineState *ms, const SMPConfiguration *config,
             (ms->smp.threads == expect_topo->threads) &&
             (ms->smp.max_cpus == expect_topo->max_cpus) &&
             (ms_threads_per_socket == expect_threads_per_socket) &&
-            (ms_cores_per_socket == expect_cores_per_socket)) {
+            (ms_cores_per_socket == expect_cores_per_socket) &&
+            (mc->smp_props.has_clusters == config->has_clusters)) {
             return;
         }
 
-- 
2.34.1


