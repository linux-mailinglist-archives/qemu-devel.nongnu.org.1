Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BFC76B1E7
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 12:34:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQmgg-0000J8-RZ; Tue, 01 Aug 2023 06:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qQmge-0000Ij-71
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 06:33:08 -0400
Received: from [192.55.52.88] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qQmgc-00034s-Di
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 06:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690885986; x=1722421986;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3JGnbMKHQjMdtmlBxosdfMaTzhxl/Yr9hJTWPNwddZc=;
 b=lr64/vp3cjFa8cbnqsyDzjc44yLffkIkxCe7J0djVT1jrHO5t75WVdCA
 Drg6wjHKJZt8/nBP7x/RnRmbP9aVWOBFcskH+7GPApy1yvzHuJoMVUrOS
 aItf+Z2WwEfRm6ucV7n3llPI4NO/u5mvQgNSHFn7NY4syYQFOs0Iq1MI+
 HIedaP6YrDvttjGtTP49ugUlLuJdHRc0EZkYTAwKoHsGyqy/mbUfeHFhP
 tGElan94/IBe91AFx3wQdYq50oEwuTAYMxC9S9xMUTMBo84l1APrj/tgg
 bAH3ojbKwn+EXRKWosN2cGbGipX0+rZzpdSQn/5p0EyK+vdxis/HklFEz Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="400211178"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; d="scan'208";a="400211178"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2023 03:25:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="731932112"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; d="scan'208";a="731932112"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.28])
 by fmsmga007.fm.intel.com with ESMTP; 01 Aug 2023 03:25:29 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Babu Moger <babu.moger@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>, Zhuocheng Ding <zhuocheng.ding@intel.com>
Subject: [PATCH v3 09/17] i386: Support module_id in X86CPUTopoIDs
Date: Tue,  1 Aug 2023 18:35:19 +0800
Message-Id: <20230801103527.397756-10-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 192.55.52.88 (failed)
Received-SPF: none client-ip=192.55.52.88;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, RDNS_NONE=0.793,
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

Add module_id member in X86CPUTopoIDs.

module_id can be parsed from APIC ID, so also update APIC ID parsing
rule to support module level. With this support, the conversions with
module level between X86CPUTopoIDs, X86CPUTopoInfo and APIC ID are
completed.

module_id can be also generated from cpu topology, and before i386
supports "clusters" in smp, the default "clusters per die" is only 1,
thus the module_id generated in this way is 0, so that it will not
conflict with the module_id generated by APIC ID.

Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
Changes since v1:
 * Merge the patch "i386: Update APIC ID parsing rule to support module
   level" into this one. (Yanan)
 * Move the apicid_module_width() and apicid_module_offset() support
   into the previous modules_per_die related patch. (Yanan)
---
 hw/i386/x86.c              | 28 +++++++++++++++++++++-------
 include/hw/i386/topology.h | 17 +++++++++++++----
 2 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index a552ae8bb4a8..0b460fd6074d 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -314,11 +314,11 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     /*
      * If APIC ID is not set,
-     * set it based on socket/die/core/thread properties.
+     * set it based on socket/die/cluster/core/thread properties.
      */
     if (cpu->apic_id == UNASSIGNED_APIC_ID) {
-        int max_socket = (ms->smp.max_cpus - 1) /
-                                smp_threads / smp_cores / ms->smp.dies;
+        int max_socket = (ms->smp.max_cpus - 1) / smp_threads / smp_cores /
+                                ms->smp.clusters / ms->smp.dies;
 
         /*
          * die-id was optional in QEMU 4.0 and older, so keep it optional
@@ -365,6 +365,14 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
         topo_ids.die_id = cpu->die_id;
         topo_ids.core_id = cpu->core_id;
         topo_ids.smt_id = cpu->thread_id;
+
+        /*
+         * TODO: This is the temporary initialization for topo_ids.module_id to
+         * avoid "maybe-uninitialized" compilation errors. Will remove when
+         * X86CPU supports cluster_id.
+         */
+        topo_ids.module_id = 0;
+
         cpu->apic_id = x86_apicid_from_topo_ids(&topo_info, &topo_ids);
     }
 
@@ -373,11 +381,13 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
         MachineState *ms = MACHINE(x86ms);
 
         x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
+
         error_setg(errp,
-            "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
-            " APIC ID %" PRIu32 ", valid index range 0:%d",
-            topo_ids.pkg_id, topo_ids.die_id, topo_ids.core_id, topo_ids.smt_id,
-            cpu->apic_id, ms->possible_cpus->len - 1);
+            "Invalid CPU [socket: %u, die: %u, module: %u, core: %u, thread: %u]"
+            " with APIC ID %" PRIu32 ", valid index range 0:%d",
+            topo_ids.pkg_id, topo_ids.die_id, topo_ids.module_id,
+            topo_ids.core_id, topo_ids.smt_id, cpu->apic_id,
+            ms->possible_cpus->len - 1);
         return;
     }
 
@@ -498,6 +508,10 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
             ms->possible_cpus->cpus[i].props.has_die_id = true;
             ms->possible_cpus->cpus[i].props.die_id = topo_ids.die_id;
         }
+        if (ms->smp.clusters > 1) {
+            ms->possible_cpus->cpus[i].props.has_cluster_id = true;
+            ms->possible_cpus->cpus[i].props.cluster_id = topo_ids.module_id;
+        }
         ms->possible_cpus->cpus[i].props.has_core_id = true;
         ms->possible_cpus->cpus[i].props.core_id = topo_ids.core_id;
         ms->possible_cpus->cpus[i].props.has_thread_id = true;
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index c807d3811dd3..3cec97b377f2 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -50,6 +50,7 @@ typedef uint32_t apic_id_t;
 typedef struct X86CPUTopoIDs {
     unsigned pkg_id;
     unsigned die_id;
+    unsigned module_id;
     unsigned core_id;
     unsigned smt_id;
 } X86CPUTopoIDs;
@@ -127,6 +128,7 @@ static inline apic_id_t x86_apicid_from_topo_ids(X86CPUTopoInfo *topo_info,
 {
     return (topo_ids->pkg_id  << apicid_pkg_offset(topo_info)) |
            (topo_ids->die_id  << apicid_die_offset(topo_info)) |
+           (topo_ids->module_id << apicid_module_offset(topo_info)) |
            (topo_ids->core_id << apicid_core_offset(topo_info)) |
            topo_ids->smt_id;
 }
@@ -140,12 +142,16 @@ static inline void x86_topo_ids_from_idx(X86CPUTopoInfo *topo_info,
                                          X86CPUTopoIDs *topo_ids)
 {
     unsigned nr_dies = topo_info->dies_per_pkg;
-    unsigned nr_cores = topo_info->cores_per_module *
-                        topo_info->modules_per_die;
+    unsigned nr_modules = topo_info->modules_per_die;
+    unsigned nr_cores = topo_info->cores_per_module;
     unsigned nr_threads = topo_info->threads_per_core;
 
-    topo_ids->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
-    topo_ids->die_id = cpu_index / (nr_cores * nr_threads) % nr_dies;
+    topo_ids->pkg_id = cpu_index / (nr_dies * nr_modules *
+                       nr_cores * nr_threads);
+    topo_ids->die_id = cpu_index / (nr_modules * nr_cores *
+                       nr_threads) % nr_dies;
+    topo_ids->module_id = cpu_index / (nr_cores * nr_threads) %
+                          nr_modules;
     topo_ids->core_id = cpu_index / nr_threads % nr_cores;
     topo_ids->smt_id = cpu_index % nr_threads;
 }
@@ -163,6 +169,9 @@ static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
     topo_ids->core_id =
             (apicid >> apicid_core_offset(topo_info)) &
             ~(0xFFFFFFFFUL << apicid_core_width(topo_info));
+    topo_ids->module_id =
+            (apicid >> apicid_module_offset(topo_info)) &
+            ~(0xFFFFFFFFUL << apicid_module_width(topo_info));
     topo_ids->die_id =
             (apicid >> apicid_die_offset(topo_info)) &
             ~(0xFFFFFFFFUL << apicid_die_width(topo_info));
-- 
2.34.1


