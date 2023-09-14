Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C8279FCF7
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 09:13:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qggWn-00045y-ON; Thu, 14 Sep 2023 03:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qggWb-0003ZS-PB
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:12:30 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qggWX-0006Hg-U8
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694675545; x=1726211545;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Lrz1j8s+Fu/q8ZaE3mzUH66sFuI2Kkh92/7k5e65fVI=;
 b=dvVKiSgyfV/6G233um+dATbAX3j1v/v279/e5xPVtVVJlTTl4TVnIprx
 ePFSrXtUCHg0WhHuFLypfmAMMnGTRjj9oOn6Eml85qpJ0HFRyPEbGkjfC
 gpFWPxungl90Azt3vdpcOAXOUzJoxBBZ4ATA+g62e5mx8BmJdCU1hJbCO
 bNydogF/+90sS2BARdAfOLBATFvJzfJzSn3pS8yFmpF91d41f89LsYjan
 hFuyDNAduuDaKSQh3hP+peW10zCAKb2mM+N0rKXDoxBXILtKU74H1vwjP
 MpwJXVCMCu4iuAbiF5Vsepk2L7b7rI2g5VssZs84bD84VKBfHOKEJHcqa w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="359136506"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; d="scan'208";a="359136506"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2023 00:12:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="779526716"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; d="scan'208";a="779526716"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga001.jf.intel.com with ESMTP; 14 Sep 2023 00:12:09 -0700
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
 Babu Moger <babu.moger@amd.com>, Zhao Liu <zhao1.liu@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>
Subject: [PATCH v4 14/21] i386/cpu: Introduce cluster-id to X86CPU
Date: Thu, 14 Sep 2023 15:21:52 +0800
Message-Id: <20230914072159.1177582-15-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914072159.1177582-1-zhao1.liu@linux.intel.com>
References: <20230914072159.1177582-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.151;
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

From: Zhuocheng Ding <zhuocheng.ding@intel.com>

Introduce cluster-id other than module-id to be consistent with
CpuInstanceProperties.cluster-id, and this avoids the confusion
of parameter names when hotplugging.

Following the legacy smp check rules, also add the cluster_id validity
into x86_cpu_pre_plug().

Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
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
index 5b05dbdedbff..a93f0771d97b 100644
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
 
@@ -416,6 +425,14 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
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
index f0ddb253b6b5..d8c5e774cf95 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7907,12 +7907,14 @@ static Property x86_cpu_properties[] = {
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
index 54019e82fdb4..fa1452380882 100644
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


