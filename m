Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4714079FCF6
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 09:13:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qggWj-0003YY-Te; Thu, 14 Sep 2023 03:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qggWJ-00039J-Kl
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:12:13 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qggWG-0006Er-Jb
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694675528; x=1726211528;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BF4Z6XoLEDGlzMfkKC1wm0TZEbXVwXQeJu6RHyVbuqM=;
 b=ASKw2GZZkn1HVCLia7GYhZQ+7X9woAzeTFd1tkKDtEoJQnAbRzFOLM8k
 mam11lCGd6P5nJ/KR85pzMpioHRrR0M/m+KLZGEHvdhTY26IUUk1AbHMw
 01aRtBq8YjyKt8B7TYnGT5IhGmUrgbQzQH8sHvW78xjqSTGoEO1gg+Epz
 chvXAzabrxQDNEawOnxjF3XHeL1UlJeUiIp2yMokkaqsshd5TREK5+cgG
 13ehIaspZjtsL1lBWOd/B2bWHgUrRSzz18549bmju73kn3OUP5tdH6jJC
 8zmBVYa3hKGQXtMGLi9Jew8/TkN1PsDGAhru3sSTeHEJJz1yZVrlfWWnF g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="359136322"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; d="scan'208";a="359136322"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2023 00:12:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="779526598"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; d="scan'208";a="779526598"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga001.jf.intel.com with ESMTP; 14 Sep 2023 00:11:56 -0700
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
Subject: [PATCH v4 11/21] i386: Support modules_per_die in X86CPUTopoInfo
Date: Thu, 14 Sep 2023 15:21:49 +0800
Message-Id: <20230914072159.1177582-12-zhao1.liu@linux.intel.com>
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

Support module level in i386 cpu topology structure "X86CPUTopoInfo".

Since x86 does not yet support the "clusters" parameter in "-smp",
X86CPUTopoInfo.modules_per_die is currently always 1. Therefore, the
module level width in APIC ID, which can be calculated by
"apicid_bitwidth_for_count(topo_info->modules_per_die)", is always 0
for now, so we can directly add APIC ID related helpers to support
module level parsing.

In addition, update topology structure in test-x86-topo.c.

Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v3:
 * Drop the description about not exposing module level in commit
   message.
 * Update topology related calculation in newly added helpers:
   num_cpus_by_topo_level() and apicid_offset_by_topo_level().
 * Since the code change, drop the "Acked-by" tag.

Changes since v1:
 * Include module level related helpers (apicid_module_width() and
   apicid_module_offset()) in this patch. (Yanan)
---
 hw/i386/x86.c              |  3 ++-
 include/hw/i386/topology.h | 22 +++++++++++++++----
 target/i386/cpu.c          | 17 +++++++++-----
 tests/unit/test-x86-topo.c | 45 ++++++++++++++++++++------------------
 4 files changed, 55 insertions(+), 32 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 9c61b6882b99..267bb0f96ca5 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -72,7 +72,8 @@ static void init_topo_info(X86CPUTopoInfo *topo_info,
     MachineState *ms = MACHINE(x86ms);
 
     topo_info->dies_per_pkg = ms->smp.dies;
-    topo_info->cores_per_die = ms->smp.cores;
+    topo_info->modules_per_die = ms->smp.clusters;
+    topo_info->cores_per_module = ms->smp.cores;
     topo_info->threads_per_core = ms->smp.threads;
 }
 
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 5a19679f618b..c807d3811dd3 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -56,7 +56,8 @@ typedef struct X86CPUTopoIDs {
 
 typedef struct X86CPUTopoInfo {
     unsigned dies_per_pkg;
-    unsigned cores_per_die;
+    unsigned modules_per_die;
+    unsigned cores_per_module;
     unsigned threads_per_core;
 } X86CPUTopoInfo;
 
@@ -77,7 +78,13 @@ static inline unsigned apicid_smt_width(X86CPUTopoInfo *topo_info)
 /* Bit width of the Core_ID field */
 static inline unsigned apicid_core_width(X86CPUTopoInfo *topo_info)
 {
-    return apicid_bitwidth_for_count(topo_info->cores_per_die);
+    return apicid_bitwidth_for_count(topo_info->cores_per_module);
+}
+
+/* Bit width of the Module_ID (cluster ID) field */
+static inline unsigned apicid_module_width(X86CPUTopoInfo *topo_info)
+{
+    return apicid_bitwidth_for_count(topo_info->modules_per_die);
 }
 
 /* Bit width of the Die_ID field */
@@ -92,10 +99,16 @@ static inline unsigned apicid_core_offset(X86CPUTopoInfo *topo_info)
     return apicid_smt_width(topo_info);
 }
 
+/* Bit offset of the Module_ID (cluster ID) field */
+static inline unsigned apicid_module_offset(X86CPUTopoInfo *topo_info)
+{
+    return apicid_core_offset(topo_info) + apicid_core_width(topo_info);
+}
+
 /* Bit offset of the Die_ID field */
 static inline unsigned apicid_die_offset(X86CPUTopoInfo *topo_info)
 {
-    return apicid_core_offset(topo_info) + apicid_core_width(topo_info);
+    return apicid_module_offset(topo_info) + apicid_module_width(topo_info);
 }
 
 /* Bit offset of the Pkg_ID (socket ID) field */
@@ -127,7 +140,8 @@ static inline void x86_topo_ids_from_idx(X86CPUTopoInfo *topo_info,
                                          X86CPUTopoIDs *topo_ids)
 {
     unsigned nr_dies = topo_info->dies_per_pkg;
-    unsigned nr_cores = topo_info->cores_per_die;
+    unsigned nr_cores = topo_info->cores_per_module *
+                        topo_info->modules_per_die;
     unsigned nr_threads = topo_info->threads_per_core;
 
     topo_ids->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 401409c5db08..cef9a4606d89 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -277,10 +277,11 @@ static uint32_t num_cpus_by_topo_level(X86CPUTopoInfo *topo_info,
     case CPU_TOPO_LEVEL_CORE:
         return topo_info->threads_per_core;
     case CPU_TOPO_LEVEL_DIE:
-        return topo_info->threads_per_core * topo_info->cores_per_die;
+        return topo_info->threads_per_core * topo_info->cores_per_module *
+               topo_info->modules_per_die;
     case CPU_TOPO_LEVEL_PACKAGE:
-        return topo_info->threads_per_core * topo_info->cores_per_die *
-               topo_info->dies_per_pkg;
+        return topo_info->threads_per_core * topo_info->cores_per_module *
+               topo_info->modules_per_die * topo_info->dies_per_pkg;
     default:
         g_assert_not_reached();
     }
@@ -449,7 +450,9 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
 
     /* L3 is shared among multiple cores */
     if (cache->level == 3) {
-        l3_threads = topo_info->cores_per_die * topo_info->threads_per_core;
+        l3_threads = topo_info->modules_per_die *
+                     topo_info->cores_per_module *
+                     topo_info->threads_per_core;
         *eax |= (l3_threads - 1) << 14;
     } else {
         *eax |= ((topo_info->threads_per_core - 1) << 14);
@@ -6126,10 +6129,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     uint32_t cpus_per_pkg;
 
     topo_info.dies_per_pkg = env->nr_dies;
-    topo_info.cores_per_die = cs->nr_cores / env->nr_dies;
+    topo_info.modules_per_die = env->nr_modules;
+    topo_info.cores_per_module = cs->nr_cores / env->nr_dies / env->nr_modules;
     topo_info.threads_per_core = cs->nr_threads;
 
-    cores_per_pkg = topo_info.cores_per_die * topo_info.dies_per_pkg;
+    cores_per_pkg = topo_info.cores_per_module * topo_info.modules_per_die *
+                    topo_info.dies_per_pkg;
     cpus_per_pkg = cores_per_pkg * topo_info.threads_per_core;
 
     /* Calculate & apply limits for different index ranges */
diff --git a/tests/unit/test-x86-topo.c b/tests/unit/test-x86-topo.c
index 2b104f86d7c2..f21b8a5d95c2 100644
--- a/tests/unit/test-x86-topo.c
+++ b/tests/unit/test-x86-topo.c
@@ -30,13 +30,16 @@ static void test_topo_bits(void)
 {
     X86CPUTopoInfo topo_info = {0};
 
-    /* simple tests for 1 thread per core, 1 core per die, 1 die per package */
-    topo_info = (X86CPUTopoInfo) {1, 1, 1};
+    /*
+     * simple tests for 1 thread per core, 1 core per module,
+     *                  1 module per die, 1 die per package
+     */
+    topo_info = (X86CPUTopoInfo) {1, 1, 1, 1};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 0);
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 0);
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
 
-    topo_info = (X86CPUTopoInfo) {1, 1, 1};
+    topo_info = (X86CPUTopoInfo) {1, 1, 1, 1};
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), ==, 1);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), ==, 2);
@@ -45,39 +48,39 @@ static void test_topo_bits(void)
 
     /* Test field width calculation for multiple values
      */
-    topo_info = (X86CPUTopoInfo) {1, 1, 2};
+    topo_info = (X86CPUTopoInfo) {1, 1, 1, 2};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 1);
-    topo_info = (X86CPUTopoInfo) {1, 1, 3};
+    topo_info = (X86CPUTopoInfo) {1, 1, 1, 3};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
-    topo_info = (X86CPUTopoInfo) {1, 1, 4};
+    topo_info = (X86CPUTopoInfo) {1, 1, 1, 4};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
 
-    topo_info = (X86CPUTopoInfo) {1, 1, 14};
+    topo_info = (X86CPUTopoInfo) {1, 1, 1, 14};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
-    topo_info = (X86CPUTopoInfo) {1, 1, 15};
+    topo_info = (X86CPUTopoInfo) {1, 1, 1, 15};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
-    topo_info = (X86CPUTopoInfo) {1, 1, 16};
+    topo_info = (X86CPUTopoInfo) {1, 1, 1, 16};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
-    topo_info = (X86CPUTopoInfo) {1, 1, 17};
+    topo_info = (X86CPUTopoInfo) {1, 1, 1, 17};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 5);
 
 
-    topo_info = (X86CPUTopoInfo) {1, 30, 2};
+    topo_info = (X86CPUTopoInfo) {1, 1, 30, 2};
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
-    topo_info = (X86CPUTopoInfo) {1, 31, 2};
+    topo_info = (X86CPUTopoInfo) {1, 1, 31, 2};
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
-    topo_info = (X86CPUTopoInfo) {1, 32, 2};
+    topo_info = (X86CPUTopoInfo) {1, 1, 32, 2};
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
-    topo_info = (X86CPUTopoInfo) {1, 33, 2};
+    topo_info = (X86CPUTopoInfo) {1, 1, 33, 2};
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 6);
 
-    topo_info = (X86CPUTopoInfo) {1, 30, 2};
+    topo_info = (X86CPUTopoInfo) {1, 1, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
-    topo_info = (X86CPUTopoInfo) {2, 30, 2};
+    topo_info = (X86CPUTopoInfo) {2, 1, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 1);
-    topo_info = (X86CPUTopoInfo) {3, 30, 2};
+    topo_info = (X86CPUTopoInfo) {3, 1, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 2);
-    topo_info = (X86CPUTopoInfo) {4, 30, 2};
+    topo_info = (X86CPUTopoInfo) {4, 1, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 2);
 
     /* build a weird topology and see if IDs are calculated correctly
@@ -85,18 +88,18 @@ static void test_topo_bits(void)
 
     /* This will use 2 bits for thread ID and 3 bits for core ID
      */
-    topo_info = (X86CPUTopoInfo) {1, 6, 3};
+    topo_info = (X86CPUTopoInfo) {1, 1, 6, 3};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
     g_assert_cmpuint(apicid_core_offset(&topo_info), ==, 2);
     g_assert_cmpuint(apicid_die_offset(&topo_info), ==, 5);
     g_assert_cmpuint(apicid_pkg_offset(&topo_info), ==, 5);
 
-    topo_info = (X86CPUTopoInfo) {1, 6, 3};
+    topo_info = (X86CPUTopoInfo) {1, 1, 6, 3};
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), ==, 1);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), ==, 2);
 
-    topo_info = (X86CPUTopoInfo) {1, 6, 3};
+    topo_info = (X86CPUTopoInfo) {1, 1, 6, 3};
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 0), ==,
                      (1 << 2) | 0);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 1), ==,
-- 
2.34.1


