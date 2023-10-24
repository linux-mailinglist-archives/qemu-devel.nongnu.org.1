Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC977D4B39
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 10:55:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvDAY-0000n1-Ue; Tue, 24 Oct 2023 04:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qvDAT-0000Um-Ev
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:53:41 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qvDAQ-0006L5-Lz
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698137619; x=1729673619;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IcYJ3JWRIhXwVt1LkLnGAUJWGR7gnfonpF5KBsId+tg=;
 b=eVzXsqpwE3kv1cLuYHolmhzEW5ywXV2W5VC+URH/jwJE74iU5LgyonB1
 aNNd4J9omPN5UT1EjDv0xJSn6ocxDD3njHWQz/9b9K+DN0FEun1qXrfgx
 iP3MxMVUWhkSoGLFsb7/z03p05jhZghyI4Uj5JmOdtK5FYX73Bf69m5ZG
 7xhkiIntpYYlrGG5TEX8nXk4kFjsmsSGsBrhNxMkU/sAz3R8zMAcw4SM/
 jJSPBcgAHAWwQjk+S9fZxZ21/UywXJgnLJTTiHE0EsXsMp0Dd/x1vOnPY
 EtXgQBTW8PM4VrudUWGUo725wUy8cuSl5r3jXIQigWZiH2A0eV+eBsF6G w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5638570"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="5638570"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2023 01:53:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="793418231"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; d="scan'208";a="793418231"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga001.jf.intel.com with ESMTP; 24 Oct 2023 01:53:29 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Babu Moger <babu.moger@amd.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Zhuocheng Ding <zhuocheng.ding@intel.com>
Subject: [PATCH v5 14/20] i386/cpu: Introduce cluster-id to X86CPU
Date: Tue, 24 Oct 2023 17:03:17 +0800
Message-Id: <20231024090323.1859210-15-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024090323.1859210-1-zhao1.liu@linux.intel.com>
References: <20231024090323.1859210-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.9;
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
Changes since v3:
 * Use the imperative in the commit message. (Babu)
---
 hw/i386/x86.c     | 33 +++++++++++++++++++++++++--------
 target/i386/cpu.c |  2 ++
 target/i386/cpu.h |  1 +
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 3e2fabf3d5bd..12213af3c04c 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -325,6 +325,14 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
             cpu->die_id = 0;
         }
 
+        /*
+         * cluster-id was optional in QEMU 8.0 and older, so keep it optional
+         * if there's only one cluster per die.
+         */
+        if (cpu->cluster_id < 0 && ms->smp.clusters == 1) {
+            cpu->cluster_id = 0;
+        }
+
         if (cpu->socket_id < 0) {
             error_setg(errp, "CPU socket-id is not set");
             return;
@@ -341,6 +349,14 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
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
@@ -360,16 +376,9 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
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
 
@@ -414,6 +423,14 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
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
index 37566eca7e23..4b231cdc5005 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7908,12 +7908,14 @@ static Property x86_cpu_properties[] = {
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
index 37bbf32f6c78..2496839f2a28 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2059,6 +2059,7 @@ struct ArchCPU {
     int32_t node_id; /* NUMA node this CPU belongs to */
     int32_t socket_id;
     int32_t die_id;
+    int32_t cluster_id;
     int32_t core_id;
     int32_t thread_id;
 
-- 
2.34.1


