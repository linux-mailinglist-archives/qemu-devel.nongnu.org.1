Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D28826949
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 09:17:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMkna-0002MA-El; Mon, 08 Jan 2024 03:15:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rMkn2-00018A-TI
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 03:15:26 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rMkmt-0007pk-K8
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 03:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704701712; x=1736237712;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QYiHrfek1hWaaXELXA4fhxcDMqX/Jd+C6szs3KHjl6Y=;
 b=gDHwPWaOpbVGOuIO3TRXRFP1uiEGch6alsxxAvo06ySM6zfAV5FtEJ/s
 pXoIfRJRTteWseU+LcptPenVp1PxBQBs6PbfkAjCM0uqqX0ucKoN72e4p
 dHV9WicpO4+vG10xaN3qYWFpHaoEMH4kzOn37amq/2ShgP56cuBwGgoGN
 cL3lrXDWb+KXNx/fVPzTxuOM8NERFn0jB6l1h3gkTzlVosZV9DUeYHtP0
 ZFl/Qpm8ktIrsN9fbG277eXovNDyKA27ESgxMD1TzVaQ+c9eQNwn0jRk3
 8Re2okdBJXs7dZAQQFapTI5xAxEWO8B833IzqSSxf5q7C/4rQFqkkpgs+ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="16420010"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; d="scan'208";a="16420010"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2024 00:15:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; d="scan'208";a="15850252"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 08 Jan 2024 00:15:07 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Babu Moger <babu.moger@amd.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: [PATCH v7 10/16] i386/cpu: Introduce cluster-id to X86CPU
Date: Mon,  8 Jan 2024 16:27:21 +0800
Message-Id: <20240108082727.420817-11-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
References: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.9;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.098,
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

From: Zhuocheng Ding <zhuocheng.ding@intel.com>

Introduce cluster-id other than module-id to be consistent with
CpuInstanceProperties.cluster-id, and this avoids the confusion
of parameter names when hotplugging.

Following the legacy smp check rules, also add the cluster_id validity
into x86_cpu_pre_plug().

Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
Changes since v6:
 * Update the comment when check cluster-id. Since there's no
   v8.2, the cluster-id support should at least start from v9.0.

Changes since v5:
 * Update the comment when check cluster-id. Since current QEMU is
   v8.2, the cluster-id support should at least start from v8.3.

Changes since v3:
 * Use the imperative in the commit message. (Babu)
---
 hw/i386/x86.c     | 33 +++++++++++++++++++++++++--------
 target/i386/cpu.c |  2 ++
 target/i386/cpu.h |  1 +
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 5269aae3a5c2..1c1d368614ee 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -329,6 +329,14 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
             cpu->die_id = 0;
         }
 
+        /*
+         * cluster-id was optional in QEMU 9.0 and older, so keep it optional
+         * if there's only one cluster per die.
+         */
+        if (cpu->cluster_id < 0 && ms->smp.clusters == 1) {
+            cpu->cluster_id = 0;
+        }
+
         if (cpu->socket_id < 0) {
             error_setg(errp, "CPU socket-id is not set");
             return;
@@ -345,6 +353,14 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
                        cpu->die_id, ms->smp.dies - 1);
             return;
         }
+        if (cpu->cluster_id < 0) {
+            error_setg(errp, "CPU cluster-id is not set");
+            return;
+        } else if (cpu->cluster_id > ms->smp.clusters - 1) {
+            error_setg(errp, "Invalid CPU cluster-id: %u must be in range 0:%u",
+                       cpu->cluster_id, ms->smp.clusters - 1);
+            return;
+        }
         if (cpu->core_id < 0) {
             error_setg(errp, "CPU core-id is not set");
             return;
@@ -364,16 +380,9 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
         topo_ids.pkg_id = cpu->socket_id;
         topo_ids.die_id = cpu->die_id;
+        topo_ids.module_id = cpu->cluster_id;
         topo_ids.core_id = cpu->core_id;
         topo_ids.smt_id = cpu->thread_id;
-
-        /*
-         * TODO: This is the temporary initialization for topo_ids.module_id to
-         * avoid "maybe-uninitialized" compilation errors. Will remove when
-         * X86CPU supports cluster_id.
-         */
-        topo_ids.module_id = 0;
-
         cpu->apic_id = x86_apicid_from_topo_ids(&topo_info, &topo_ids);
     }
 
@@ -418,6 +427,14 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
     }
     cpu->die_id = topo_ids.die_id;
 
+    if (cpu->cluster_id != -1 && cpu->cluster_id != topo_ids.module_id) {
+        error_setg(errp, "property cluster-id: %u doesn't match set apic-id:"
+            " 0x%x (cluster-id: %u)", cpu->cluster_id, cpu->apic_id,
+            topo_ids.module_id);
+        return;
+    }
+    cpu->cluster_id = topo_ids.module_id;
+
     if (cpu->core_id != -1 && cpu->core_id != topo_ids.core_id) {
         error_setg(errp, "property core-id: %u doesn't match set apic-id:"
             " 0x%x (core-id: %u)", cpu->core_id, cpu->apic_id,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a2d39d2198b6..498a4be62b40 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7909,12 +7909,14 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_UINT32("apic-id", X86CPU, apic_id, 0),
     DEFINE_PROP_INT32("thread-id", X86CPU, thread_id, 0),
     DEFINE_PROP_INT32("core-id", X86CPU, core_id, 0),
+    DEFINE_PROP_INT32("cluster-id", X86CPU, cluster_id, 0),
     DEFINE_PROP_INT32("die-id", X86CPU, die_id, 0),
     DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, 0),
 #else
     DEFINE_PROP_UINT32("apic-id", X86CPU, apic_id, UNASSIGNED_APIC_ID),
     DEFINE_PROP_INT32("thread-id", X86CPU, thread_id, -1),
     DEFINE_PROP_INT32("core-id", X86CPU, core_id, -1),
+    DEFINE_PROP_INT32("cluster-id", X86CPU, cluster_id, -1),
     DEFINE_PROP_INT32("die-id", X86CPU, die_id, -1),
     DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, -1),
 #endif
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 97b290e10576..009950b87203 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2057,6 +2057,7 @@ struct ArchCPU {
     int32_t node_id; /* NUMA node this CPU belongs to */
     int32_t socket_id;
     int32_t die_id;
+    int32_t cluster_id;
     int32_t core_id;
     int32_t thread_id;
 
-- 
2.34.1


