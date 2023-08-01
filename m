Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ECE76B1EB
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 12:34:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQmhD-0002Or-NC; Tue, 01 Aug 2023 06:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qQmhB-0002HA-Jh
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 06:33:41 -0400
Received: from [192.55.52.88] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qQmh9-0003Cu-Vf
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 06:33:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690886020; x=1722422020;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XFNRA6qL99jXr5lXDxjIiHWNWpIj8xxG4L5OTXEsoag=;
 b=nlI0GacisCgnT9cSwDp+jhZq77tyV4lqw4Q9QSTyIl1Estnk7j467SQU
 hDynSeOwlpj6ZH7qEcIj9MVSemejh6ufXb80hKAyLrw3FNepLcOKX7Pmp
 LwfzM3mDSkhJyeKWTpRk3zqEJU4Gm9+aC5OLY7RyVFMzzaJa8bc6Uotf9
 2tjHLDysf9dXsGN8VP2Wr0PY3iEhL+hqh90Qv8jFtL0ECWTQDQkoxVmAc
 0qjBI0QZ51TsayWr/AdJAeM/N/IL4mhSbCYX7WX20zkAOUjw2f5b8v5K2
 b+AKEeDs2Rr6CDUJgHOZg5+vvjdkDLZXXRSEvJ73n2xHjIYHuyq5UNTLB A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="400211298"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; d="scan'208";a="400211298"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2023 03:25:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="731932224"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; d="scan'208";a="731932224"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.28])
 by fmsmga007.fm.intel.com with ESMTP; 01 Aug 2023 03:25:54 -0700
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
 Zhao Liu <zhao1.liu@intel.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: [PATCH v3 17/17] i386: Add new property to control L2 cache topo in
 CPUID.04H
Date: Tue,  1 Aug 2023 18:35:27 +0800
Message-Id: <20230801103527.397756-18-zhao1.liu@linux.intel.com>
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

From: Zhao Liu <zhao1.liu@intel.com>

The property x-l2-cache-topo will be used to change the L2 cache
topology in CPUID.04H.

Now it allows user to set the L2 cache is shared in core level or
cluster level.

If user passes "-cpu x-l2-cache-topo=[core|cluster]" then older L2 cache
topology will be overrided by the new topology setting.

Here we expose to user "cluster" instead of "module", to be consistent
with "cluster-id" naming.

Since CPUID.04H is used by intel CPUs, this property is available on
intel CPUs as for now.

When necessary, it can be extended to CPUID.8000001DH for amd CPUs.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
---
Changes since v1:
 * Rename MODULE branch to CPU_TOPO_LEVEL_MODULE to match the previous
   renaming changes.
---
 target/i386/cpu.c | 34 +++++++++++++++++++++++++++++++++-
 target/i386/cpu.h |  2 ++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6eee0274ade4..f4c48e19fa4e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -243,6 +243,9 @@ static uint32_t max_processor_ids_for_cache(X86CPUTopoInfo *topo_info,
     case CPU_TOPO_LEVEL_CORE:
         num_ids = 1 << apicid_core_offset(topo_info);
         break;
+    case CPU_TOPO_LEVEL_MODULE:
+        num_ids = 1 << apicid_module_offset(topo_info);
+        break;
     case CPU_TOPO_LEVEL_DIE:
         num_ids = 1 << apicid_die_offset(topo_info);
         break;
@@ -251,7 +254,7 @@ static uint32_t max_processor_ids_for_cache(X86CPUTopoInfo *topo_info,
         break;
     default:
         /*
-         * Currently there is no use case for SMT and MODULE, so use
+         * Currently there is no use case for SMT, so use
          * assert directly to facilitate debugging.
          */
         g_assert_not_reached();
@@ -7458,6 +7461,34 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         env->cache_info_amd.l3_cache = &legacy_l3_cache;
     }
 
+    if (cpu->l2_cache_topo_level) {
+        /*
+         * FIXME: Currently only supports changing CPUID[4] (for intel), and
+         * will support changing CPUID[0x8000001D] when necessary.
+         */
+        if (!IS_INTEL_CPU(env)) {
+            error_setg(errp, "only intel cpus supports x-l2-cache-topo");
+            return;
+        }
+
+        if (!strcmp(cpu->l2_cache_topo_level, "core")) {
+            env->cache_info_cpuid4.l2_cache->share_level = CPU_TOPO_LEVEL_CORE;
+        } else if (!strcmp(cpu->l2_cache_topo_level, "cluster")) {
+            /*
+             * We expose to users "cluster" instead of "module", to be
+             * consistent with "cluster-id" naming.
+             */
+            env->cache_info_cpuid4.l2_cache->share_level =
+                                                        CPU_TOPO_LEVEL_MODULE;
+        } else {
+            error_setg(errp,
+                       "x-l2-cache-topo doesn't support '%s', "
+                       "and it only supports 'core' or 'cluster'",
+                       cpu->l2_cache_topo_level);
+            return;
+        }
+    }
+
 #ifndef CONFIG_USER_ONLY
     MachineState *ms = MACHINE(qdev_get_machine());
     qemu_register_reset(x86_cpu_machine_reset_cb, cpu);
@@ -7961,6 +7992,7 @@ static Property x86_cpu_properties[] = {
                      false),
     DEFINE_PROP_BOOL("x-intel-pt-auto-level", X86CPU, intel_pt_auto_level,
                      true),
+    DEFINE_PROP_STRING("x-l2-cache-topo", X86CPU, l2_cache_topo_level),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 3f0cdc45607a..24db2a0d9588 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2057,6 +2057,8 @@ struct ArchCPU {
     int32_t hv_max_vps;
 
     bool xen_vapic;
+
+    char *l2_cache_topo_level;
 };
 
 
-- 
2.34.1


