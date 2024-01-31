Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A492D843BC0
	for <lists+qemu-devel@lfdr.de>; Wed, 31 Jan 2024 11:03:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV7PB-0004KS-3y; Wed, 31 Jan 2024 05:01:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rV7Oq-0004JH-E4
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:00:56 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rV7Oo-0008Lk-1Y
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:00:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706695254; x=1738231254;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FNchQTkIBzQfwCaK8Fa0+EBQesoyJ6CLLz7w5FYNTdo=;
 b=oBDo5Pg8ocek/Jjn1TgYB/BminW2d64+jwBSC8Th8tFIqi0nYZ/Xi/nS
 v16f/ih3w0EBLluA7umn2ZTcUVtGfxXQG4bffIZgugUgX2Yyu1bEz+DTg
 tD5lf7HsBoiYZZx5DSn/WKaiX11F9icmCtA7k4yByL7BGcZavqe6xaYvy
 5trhwEdqT7lOzofMAvpmNECYVl83oaH5hV4ELJ7rMG3fSf8ug7EcXmnY2
 CciqZa6zfsTm6GlBkhym/PCJbb+57g/hiu0dkMZPJmcPdYBVTIwamWvSJ
 NQfwXgv2PfhS/Gv9d51M9RqnZ6ZJnlUVzmMi0iSUBg7AMdFnyqW4V208i g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="25032513"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; d="scan'208";a="25032513"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 02:00:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="4035937"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 31 Jan 2024 02:00:46 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Babu Moger <babu.moger@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v8 02/21] hw/core/machine: Support modules in -smp
Date: Wed, 31 Jan 2024 18:13:31 +0800
Message-Id: <20240131101350.109512-3-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131101350.109512-1-zhao1.liu@linux.intel.com>
References: <20240131101350.109512-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
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

Add "modules" parameter parsing support in -smp.

Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v7:
 * New commit to introduce module level in -smp.
---
 hw/core/machine-smp.c | 39 +++++++++++++++++++++++++++++----------
 hw/core/machine.c     |  1 +
 qapi/machine.json     |  3 +++
 3 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index a0a30da59aa4..8a8296b0d05b 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -51,6 +51,10 @@ static char *cpu_hierarchy_to_string(MachineState *ms)
         g_string_append_printf(s, " * clusters (%u)", ms->smp.clusters);
     }
 
+    if (mc->smp_props.modules_supported) {
+        g_string_append_printf(s, " * modules (%u)", ms->smp.clusters);
+    }
+
     g_string_append_printf(s, " * cores (%u)", ms->smp.cores);
     g_string_append_printf(s, " * threads (%u)", ms->smp.threads);
 
@@ -88,6 +92,7 @@ void machine_parse_smp_config(MachineState *ms,
     unsigned sockets = config->has_sockets ? config->sockets : 0;
     unsigned dies    = config->has_dies ? config->dies : 0;
     unsigned clusters = config->has_clusters ? config->clusters : 0;
+    unsigned modules = config->has_modules ? config->modules : 0;
     unsigned cores   = config->has_cores ? config->cores : 0;
     unsigned threads = config->has_threads ? config->threads : 0;
     unsigned maxcpus = config->has_maxcpus ? config->maxcpus : 0;
@@ -102,6 +107,7 @@ void machine_parse_smp_config(MachineState *ms,
         (config->has_sockets && config->sockets == 0) ||
         (config->has_dies && config->dies == 0) ||
         (config->has_clusters && config->clusters == 0) ||
+        (config->has_modules && config->modules == 0) ||
         (config->has_cores && config->cores == 0) ||
         (config->has_threads && config->threads == 0) ||
         (config->has_maxcpus && config->maxcpus == 0)) {
@@ -117,12 +123,12 @@ void machine_parse_smp_config(MachineState *ms,
         error_setg(errp, "dies not supported by this machine's CPU topology");
         return;
     }
+    dies = dies > 0 ? dies : 1;
+
     if (!mc->smp_props.clusters_supported && clusters > 1) {
         error_setg(errp, "clusters not supported by this machine's CPU topology");
         return;
     }
-
-    dies = dies > 0 ? dies : 1;
     clusters = clusters > 0 ? clusters : 1;
 
     if (!mc->smp_props.books_supported && books > 1) {
@@ -138,6 +144,13 @@ void machine_parse_smp_config(MachineState *ms,
     }
     drawers = drawers > 0 ? drawers : 1;
 
+    if (!mc->smp_props.modules_supported && modules > 1) {
+        error_setg(errp, "modules not supported by this "
+                   "machine's CPU topology");
+        return;
+    }
+    modules = modules > 0 ? modules : 1;
+
     /* compute missing values based on the provided ones */
     if (cpus == 0 && maxcpus == 0) {
         sockets = sockets > 0 ? sockets : 1;
@@ -152,11 +165,13 @@ void machine_parse_smp_config(MachineState *ms,
                 cores = cores > 0 ? cores : 1;
                 threads = threads > 0 ? threads : 1;
                 sockets = maxcpus /
-                          (drawers * books * dies * clusters * cores * threads);
+                          (drawers * books * dies * clusters *
+                           modules * cores * threads);
             } else if (cores == 0) {
                 threads = threads > 0 ? threads : 1;
                 cores = maxcpus /
-                        (drawers * books * sockets * dies * clusters * threads);
+                        (drawers * books * sockets * dies *
+                         clusters * modules * threads);
             }
         } else {
             /* prefer cores over sockets since 6.2 */
@@ -164,23 +179,26 @@ void machine_parse_smp_config(MachineState *ms,
                 sockets = sockets > 0 ? sockets : 1;
                 threads = threads > 0 ? threads : 1;
                 cores = maxcpus /
-                        (drawers * books * sockets * dies * clusters * threads);
+                        (drawers * books * sockets * dies *
+                         clusters * modules * threads);
             } else if (sockets == 0) {
                 threads = threads > 0 ? threads : 1;
                 sockets = maxcpus /
-                          (drawers * books * dies * clusters * cores * threads);
+                          (drawers * books * dies * clusters *
+                           modules * cores * threads);
             }
         }
 
         /* try to calculate omitted threads at last */
         if (threads == 0) {
             threads = maxcpus /
-                      (drawers * books * sockets * dies * clusters * cores);
+                      (drawers * books * sockets * dies *
+                       clusters * modules * cores);
         }
     }
 
     maxcpus = maxcpus > 0 ? maxcpus : drawers * books * sockets * dies *
-                                      clusters * cores * threads;
+                                      clusters * modules * cores * threads;
     cpus = cpus > 0 ? cpus : maxcpus;
 
     ms->smp.cpus = cpus;
@@ -189,6 +207,7 @@ void machine_parse_smp_config(MachineState *ms,
     ms->smp.sockets = sockets;
     ms->smp.dies = dies;
     ms->smp.clusters = clusters;
+    ms->smp.modules = modules;
     ms->smp.cores = cores;
     ms->smp.threads = threads;
     ms->smp.max_cpus = maxcpus;
@@ -196,8 +215,8 @@ void machine_parse_smp_config(MachineState *ms,
     mc->smp_props.has_clusters = config->has_clusters;
 
     /* sanity-check of the computed topology */
-    if (drawers * books * sockets * dies * clusters * cores * threads !=
-        maxcpus) {
+    if (drawers * books * sockets * dies * clusters * modules * cores *
+        threads != maxcpus) {
         g_autofree char *topo_msg = cpu_hierarchy_to_string(ms);
         error_setg(errp, "Invalid CPU topology: "
                    "product of the hierarchy must match maxcpus: "
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 36fe3a4806f2..030b7e250ac5 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -872,6 +872,7 @@ static void machine_get_smp(Object *obj, Visitor *v, const char *name,
         .has_sockets = true, .sockets = ms->smp.sockets,
         .has_dies = true, .dies = ms->smp.dies,
         .has_clusters = true, .clusters = ms->smp.clusters,
+        .has_modules = true, .modules = ms->smp.modules,
         .has_cores = true, .cores = ms->smp.cores,
         .has_threads = true, .threads = ms->smp.threads,
         .has_maxcpus = true, .maxcpus = ms->smp.max_cpus,
diff --git a/qapi/machine.json b/qapi/machine.json
index aa99fa333f69..93ae0a987c3a 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1626,6 +1626,8 @@
 #
 # @clusters: number of clusters per parent container (since 7.0)
 #
+# @modules: number of modules per parent container (since 9.0)
+#
 # @cores: number of cores per parent container
 #
 # @threads: number of threads per core
@@ -1639,6 +1641,7 @@
      '*sockets': 'int',
      '*dies': 'int',
      '*clusters': 'int',
+     '*modules': 'int',
      '*cores': 'int',
      '*threads': 'int',
      '*maxcpus': 'int' } }
-- 
2.34.1


