Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5CE97079C
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Sep 2024 14:45:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snHGZ-0007bC-SW; Sun, 08 Sep 2024 08:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1snHGT-0007SX-TO; Sun, 08 Sep 2024 08:43:38 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1snHGQ-0006Ae-Of; Sun, 08 Sep 2024 08:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1725799415; x=1757335415;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RvWgjebE8unRFRUI+axp5q2lOdejb+OMki3EAlYBf3o=;
 b=dGbEVWejEXnS6oNxuR4rW6qYbxQzRe6O1j6X0SUrwMYCNoO5bBVsNxem
 pOS2gfjHYz9CPwULEWhdRn0eq4DBSJvQ4RxhBBghtlIciKVbU9EFQMr/S
 2ww8rHvaY+nh7RLxF6IQwG5wbD8BcXkxbQJZC7MNzwzfcM0uV+bjFVrS9
 DjqkmsXeZR8fFtYwtKLCtGvl6aw6M53kxoQfqBnwk7Po+4/y/OLcUzjFl
 tVfn8Q3Bmukw7ZhWveeCzlhmlpLOpUBr4rUUOKKkRetUvqnAaYXhtoqcP
 mIAcLWH+oWrnIk6TKdfyF4Ep1By983AHWZ6XIszT2xeVYmuWpAAMwH36c g==;
X-CSE-ConnectionGUID: 148LR+J6QmOPZE8WXTF6jQ==
X-CSE-MsgGUID: L5bqaRYzRsK91Ra4/d24HA==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="28238118"
X-IronPort-AV: E=Sophos;i="6.10,212,1719903600"; d="scan'208";a="28238118"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2024 05:43:33 -0700
X-CSE-ConnectionGUID: /XRFLVh4RJSmMw0uK4NJFA==
X-CSE-MsgGUID: ZE40gl4sSMyRc1+/64X5TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,212,1719903600"; d="scan'208";a="97196491"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 08 Sep 2024 05:43:26 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 1/7] hw/core: Make CPU topology enumeration arch-agnostic
Date: Sun,  8 Sep 2024 20:59:14 +0800
Message-Id: <20240908125920.1160236-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240908125920.1160236-1-zhao1.liu@intel.com>
References: <20240908125920.1160236-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Cache topology needs to be defined based on CPU topology levels. Thus,
define CPU topology enumeration in qapi/machine.json to make it generic
for all architectures.

To match the general topology naming style, rename CPU_TOPO_LEVEL_* to
CPU_TOPOLOGY_LEVEL_*, and rename SMT and package levels to thread and
socket.

Also, enumerate additional topology levels for non-i386 arches, and add
a CPU_TOPOLOGY_LEVEL_DEFAULT to help future smp-cache object to work
with compatibility requirement of arch-specific cache topology models.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
---
Changes since Patch v1:
 * Dropped prefix of CpuTopologyLevel enumeration. (Markus)
 * Rename CPU_TOPO_LEVEL_* to CPU_TOPOLOGY_LEVEL_* to match the QAPI's
   generated code. (Markus)

Changes since RFC v2:
 * Dropped cpu-topology.h and cpu-topology.c since QAPI has the helper
   (CpuTopologyLevel_str) to convert enum to string. (Markus)
 * Fixed text format in machine.json (CpuTopologyLevel naming, 2 spaces
   between sentences). (Markus)
 * Added a new level "default" to de-compatibilize some arch-specific
   topo settings. (Daniel)
 * Moved CpuTopologyLevel to qapi/machine-common.json, at where the
   cache enumeration and smp-cache object would be added.
   - If smp-cache object is defined in qapi/machine.json, storage-daemon
     will complain about the qmp cmds in qapi/machine.json during
     compiling.

Changes since RFC v1:
 * Used QAPI to enumerate CPU topology levels.
 * Dropped string_to_cpu_topo() since QAPI will help to parse the topo
   levels.
---
 hw/i386/x86-common.c       |   4 +-
 include/hw/i386/topology.h |  22 +-----
 qapi/machine-common.json   |  46 +++++++++++-
 target/i386/cpu.c          | 144 ++++++++++++++++++-------------------
 target/i386/cpu.h          |   4 +-
 5 files changed, 124 insertions(+), 96 deletions(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 992ea1f25e94..b21d2ab97349 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -273,12 +273,12 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     if (ms->smp.modules > 1) {
         env->nr_modules = ms->smp.modules;
-        set_bit(CPU_TOPO_LEVEL_MODULE, env->avail_cpu_topo);
+        set_bit(CPU_TOPOLOGY_LEVEL_MODULE, env->avail_cpu_topo);
     }
 
     if (ms->smp.dies > 1) {
         env->nr_dies = ms->smp.dies;
-        set_bit(CPU_TOPO_LEVEL_DIE, env->avail_cpu_topo);
+        set_bit(CPU_TOPOLOGY_LEVEL_DIE, env->avail_cpu_topo);
     }
 
     /*
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index dff49fce1154..bf740383038b 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -39,7 +39,7 @@
  *  CPUID Fn8000_0008_ECX[ApicIdCoreIdSize[3:0]] is set to apicid_core_width().
  */
 
-
+#include "qapi/qapi-types-machine-common.h"
 #include "qemu/bitops.h"
 
 /*
@@ -62,22 +62,6 @@ typedef struct X86CPUTopoInfo {
     unsigned threads_per_core;
 } X86CPUTopoInfo;
 
-/*
- * CPUTopoLevel is the general i386 topology hierarchical representation,
- * ordered by increasing hierarchical relationship.
- * Its enumeration value is not bound to the type value of Intel (CPUID[0x1F])
- * or AMD (CPUID[0x80000026]).
- */
-enum CPUTopoLevel {
-    CPU_TOPO_LEVEL_INVALID,
-    CPU_TOPO_LEVEL_SMT,
-    CPU_TOPO_LEVEL_CORE,
-    CPU_TOPO_LEVEL_MODULE,
-    CPU_TOPO_LEVEL_DIE,
-    CPU_TOPO_LEVEL_PACKAGE,
-    CPU_TOPO_LEVEL_MAX,
-};
-
 /* Return the bit width needed for 'count' IDs */
 static unsigned apicid_bitwidth_for_count(unsigned count)
 {
@@ -212,8 +196,8 @@ static inline apic_id_t x86_apicid_from_cpu_idx(X86CPUTopoInfo *topo_info,
  */
 static inline bool x86_has_extended_topo(unsigned long *topo_bitmap)
 {
-    return test_bit(CPU_TOPO_LEVEL_MODULE, topo_bitmap) ||
-           test_bit(CPU_TOPO_LEVEL_DIE, topo_bitmap);
+    return test_bit(CPU_TOPOLOGY_LEVEL_MODULE, topo_bitmap) ||
+           test_bit(CPU_TOPOLOGY_LEVEL_DIE, topo_bitmap);
 }
 
 #endif /* HW_I386_TOPOLOGY_H */
diff --git a/qapi/machine-common.json b/qapi/machine-common.json
index fa6bd71d1280..148a2c8dccca 100644
--- a/qapi/machine-common.json
+++ b/qapi/machine-common.json
@@ -5,7 +5,7 @@
 # See the COPYING file in the top-level directory.
 
 ##
-# = Machines S390 data types
+# = Common machine types
 ##
 
 ##
@@ -19,3 +19,47 @@
 { 'enum': 'CpuS390Entitlement',
   'prefix': 'S390_CPU_ENTITLEMENT',
   'data': [ 'auto', 'low', 'medium', 'high' ] }
+
+##
+# @CpuTopologyLevel:
+#
+# An enumeration of CPU topology levels.
+#
+# @invalid: Invalid topology level.
+#
+# @thread: thread level, which would also be called SMT level or
+#     logical processor level.  The @threads option in
+#     SMPConfiguration is used to configure the topology of this
+#     level.
+#
+# @core: core level.  The @cores option in SMPConfiguration is used
+#     to configure the topology of this level.
+#
+# @module: module level.  The @modules option in SMPConfiguration is
+#     used to configure the topology of this level.
+#
+# @cluster: cluster level.  The @clusters option in SMPConfiguration
+#     is used to configure the topology of this level.
+#
+# @die: die level.  The @dies option in SMPConfiguration is used to
+#     configure the topology of this level.
+#
+# @socket: socket level, which would also be called package level.
+#     The @sockets option in SMPConfiguration is used to configure
+#     the topology of this level.
+#
+# @book: book level.  The @books option in SMPConfiguration is used
+#     to configure the topology of this level.
+#
+# @drawer: drawer level.  The @drawers option in SMPConfiguration is
+#     used to configure the topology of this level.
+#
+# @default: default level.  Some architectures will have default
+#     topology settings (e.g., cache topology), and this special
+#     level means following the architecture-specific settings.
+#
+# Since: 9.1
+##
+{ 'enum': 'CpuTopologyLevel',
+  'data': [ 'invalid', 'thread', 'core', 'module', 'cluster',
+            'die', 'socket', 'book', 'drawer', 'default' ] }
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 85ef7452c04e..e3a81bc64922 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -236,23 +236,23 @@ static uint8_t cpuid2_cache_descriptor(CPUCacheInfo *cache)
                        0 /* Invalid value */)
 
 static uint32_t max_thread_ids_for_cache(X86CPUTopoInfo *topo_info,
-                                         enum CPUTopoLevel share_level)
+                                         enum CpuTopologyLevel share_level)
 {
     uint32_t num_ids = 0;
 
     switch (share_level) {
-    case CPU_TOPO_LEVEL_CORE:
+    case CPU_TOPOLOGY_LEVEL_CORE:
         num_ids = 1 << apicid_core_offset(topo_info);
         break;
-    case CPU_TOPO_LEVEL_DIE:
+    case CPU_TOPOLOGY_LEVEL_DIE:
         num_ids = 1 << apicid_die_offset(topo_info);
         break;
-    case CPU_TOPO_LEVEL_PACKAGE:
+    case CPU_TOPOLOGY_LEVEL_SOCKET:
         num_ids = 1 << apicid_pkg_offset(topo_info);
         break;
     default:
         /*
-         * Currently there is no use case for SMT and MODULE, so use
+         * Currently there is no use case for THREAD and MODULE, so use
          * assert directly to facilitate debugging.
          */
         g_assert_not_reached();
@@ -301,19 +301,19 @@ static void encode_cache_cpuid4(CPUCacheInfo *cache,
 }
 
 static uint32_t num_threads_by_topo_level(X86CPUTopoInfo *topo_info,
-                                          enum CPUTopoLevel topo_level)
+                                          enum CpuTopologyLevel topo_level)
 {
     switch (topo_level) {
-    case CPU_TOPO_LEVEL_SMT:
+    case CPU_TOPOLOGY_LEVEL_THREAD:
         return 1;
-    case CPU_TOPO_LEVEL_CORE:
+    case CPU_TOPOLOGY_LEVEL_CORE:
         return topo_info->threads_per_core;
-    case CPU_TOPO_LEVEL_MODULE:
+    case CPU_TOPOLOGY_LEVEL_MODULE:
         return topo_info->threads_per_core * topo_info->cores_per_module;
-    case CPU_TOPO_LEVEL_DIE:
+    case CPU_TOPOLOGY_LEVEL_DIE:
         return topo_info->threads_per_core * topo_info->cores_per_module *
                topo_info->modules_per_die;
-    case CPU_TOPO_LEVEL_PACKAGE:
+    case CPU_TOPOLOGY_LEVEL_SOCKET:
         return topo_info->threads_per_core * topo_info->cores_per_module *
                topo_info->modules_per_die * topo_info->dies_per_pkg;
     default:
@@ -323,18 +323,18 @@ static uint32_t num_threads_by_topo_level(X86CPUTopoInfo *topo_info,
 }
 
 static uint32_t apicid_offset_by_topo_level(X86CPUTopoInfo *topo_info,
-                                            enum CPUTopoLevel topo_level)
+                                            enum CpuTopologyLevel topo_level)
 {
     switch (topo_level) {
-    case CPU_TOPO_LEVEL_SMT:
+    case CPU_TOPOLOGY_LEVEL_THREAD:
         return 0;
-    case CPU_TOPO_LEVEL_CORE:
+    case CPU_TOPOLOGY_LEVEL_CORE:
         return apicid_core_offset(topo_info);
-    case CPU_TOPO_LEVEL_MODULE:
+    case CPU_TOPOLOGY_LEVEL_MODULE:
         return apicid_module_offset(topo_info);
-    case CPU_TOPO_LEVEL_DIE:
+    case CPU_TOPOLOGY_LEVEL_DIE:
         return apicid_die_offset(topo_info);
-    case CPU_TOPO_LEVEL_PACKAGE:
+    case CPU_TOPOLOGY_LEVEL_SOCKET:
         return apicid_pkg_offset(topo_info);
     default:
         g_assert_not_reached();
@@ -342,18 +342,18 @@ static uint32_t apicid_offset_by_topo_level(X86CPUTopoInfo *topo_info,
     return 0;
 }
 
-static uint32_t cpuid1f_topo_type(enum CPUTopoLevel topo_level)
+static uint32_t cpuid1f_topo_type(enum CpuTopologyLevel topo_level)
 {
     switch (topo_level) {
-    case CPU_TOPO_LEVEL_INVALID:
+    case CPU_TOPOLOGY_LEVEL_INVALID:
         return CPUID_1F_ECX_TOPO_LEVEL_INVALID;
-    case CPU_TOPO_LEVEL_SMT:
+    case CPU_TOPOLOGY_LEVEL_THREAD:
         return CPUID_1F_ECX_TOPO_LEVEL_SMT;
-    case CPU_TOPO_LEVEL_CORE:
+    case CPU_TOPOLOGY_LEVEL_CORE:
         return CPUID_1F_ECX_TOPO_LEVEL_CORE;
-    case CPU_TOPO_LEVEL_MODULE:
+    case CPU_TOPOLOGY_LEVEL_MODULE:
         return CPUID_1F_ECX_TOPO_LEVEL_MODULE;
-    case CPU_TOPO_LEVEL_DIE:
+    case CPU_TOPOLOGY_LEVEL_DIE:
         return CPUID_1F_ECX_TOPO_LEVEL_DIE;
     default:
         /* Other types are not supported in QEMU. */
@@ -371,16 +371,16 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
     unsigned long level, next_level;
     uint32_t num_threads_next_level, offset_next_level;
 
-    assert(count + 1 < CPU_TOPO_LEVEL_MAX);
+    assert(count + 1 < CPU_TOPOLOGY_LEVEL__MAX);
 
     /*
      * Find the No.(count + 1) topology level in avail_cpu_topo bitmap.
-     * The search starts from bit 1 (CPU_TOPO_LEVEL_INVALID + 1).
+     * The search starts from bit 1 (CPU_TOPOLOGY_LEVEL_INVALID + 1).
      */
-    level = CPU_TOPO_LEVEL_INVALID;
+    level = CPU_TOPOLOGY_LEVEL_INVALID;
     for (int i = 0; i <= count; i++) {
         level = find_next_bit(env->avail_cpu_topo,
-                              CPU_TOPO_LEVEL_PACKAGE,
+                              CPU_TOPOLOGY_LEVEL_SOCKET,
                               level + 1);
 
         /*
@@ -388,18 +388,18 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
          * and it just encodes the invalid level (all fields are 0)
          * into the last subleaf of 0x1f.
          */
-        if (level == CPU_TOPO_LEVEL_PACKAGE) {
-            level = CPU_TOPO_LEVEL_INVALID;
+        if (level == CPU_TOPOLOGY_LEVEL_SOCKET) {
+            level = CPU_TOPOLOGY_LEVEL_INVALID;
             break;
         }
     }
 
-    if (level == CPU_TOPO_LEVEL_INVALID) {
+    if (level == CPU_TOPOLOGY_LEVEL_INVALID) {
         num_threads_next_level = 0;
         offset_next_level = 0;
     } else {
         next_level = find_next_bit(env->avail_cpu_topo,
-                                   CPU_TOPO_LEVEL_PACKAGE,
+                                   CPU_TOPOLOGY_LEVEL_SOCKET,
                                    level + 1);
         num_threads_next_level = num_threads_by_topo_level(topo_info,
                                                            next_level);
@@ -575,7 +575,7 @@ static CPUCacheInfo legacy_l1d_cache = {
     .sets = 64,
     .partitions = 1,
     .no_invd_sharing = true,
-    .share_level = CPU_TOPO_LEVEL_CORE,
+    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
 /*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
@@ -590,7 +590,7 @@ static CPUCacheInfo legacy_l1d_cache_amd = {
     .partitions = 1,
     .lines_per_tag = 1,
     .no_invd_sharing = true,
-    .share_level = CPU_TOPO_LEVEL_CORE,
+    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
 /* L1 instruction cache: */
@@ -604,7 +604,7 @@ static CPUCacheInfo legacy_l1i_cache = {
     .sets = 64,
     .partitions = 1,
     .no_invd_sharing = true,
-    .share_level = CPU_TOPO_LEVEL_CORE,
+    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
 /*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
@@ -619,7 +619,7 @@ static CPUCacheInfo legacy_l1i_cache_amd = {
     .partitions = 1,
     .lines_per_tag = 1,
     .no_invd_sharing = true,
-    .share_level = CPU_TOPO_LEVEL_CORE,
+    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
 /* Level 2 unified cache: */
@@ -633,7 +633,7 @@ static CPUCacheInfo legacy_l2_cache = {
     .sets = 4096,
     .partitions = 1,
     .no_invd_sharing = true,
-    .share_level = CPU_TOPO_LEVEL_CORE,
+    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
 /*FIXME: CPUID leaf 2 descriptor is inconsistent with CPUID leaf 4 */
@@ -643,7 +643,7 @@ static CPUCacheInfo legacy_l2_cache_cpuid2 = {
     .size = 2 * MiB,
     .line_size = 64,
     .associativity = 8,
-    .share_level = CPU_TOPO_LEVEL_INVALID,
+    .share_level = CPU_TOPOLOGY_LEVEL_INVALID,
 };
 
 
@@ -657,7 +657,7 @@ static CPUCacheInfo legacy_l2_cache_amd = {
     .associativity = 16,
     .sets = 512,
     .partitions = 1,
-    .share_level = CPU_TOPO_LEVEL_CORE,
+    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
 /* Level 3 unified cache: */
@@ -673,7 +673,7 @@ static CPUCacheInfo legacy_l3_cache = {
     .self_init = true,
     .inclusive = true,
     .complex_indexing = true,
-    .share_level = CPU_TOPO_LEVEL_DIE,
+    .share_level = CPU_TOPOLOGY_LEVEL_DIE,
 };
 
 /* TLB definitions: */
@@ -2017,7 +2017,7 @@ static const CPUCaches epyc_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2030,7 +2030,7 @@ static const CPUCaches epyc_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2041,7 +2041,7 @@ static const CPUCaches epyc_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2055,7 +2055,7 @@ static const CPUCaches epyc_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = true,
-        .share_level = CPU_TOPO_LEVEL_DIE,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
     },
 };
 
@@ -2071,7 +2071,7 @@ static CPUCaches epyc_v4_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2084,7 +2084,7 @@ static CPUCaches epyc_v4_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2095,7 +2095,7 @@ static CPUCaches epyc_v4_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2109,7 +2109,7 @@ static CPUCaches epyc_v4_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = false,
-        .share_level = CPU_TOPO_LEVEL_DIE,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
     },
 };
 
@@ -2125,7 +2125,7 @@ static const CPUCaches epyc_rome_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2138,7 +2138,7 @@ static const CPUCaches epyc_rome_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2149,7 +2149,7 @@ static const CPUCaches epyc_rome_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2163,7 +2163,7 @@ static const CPUCaches epyc_rome_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = true,
-        .share_level = CPU_TOPO_LEVEL_DIE,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
     },
 };
 
@@ -2179,7 +2179,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2192,7 +2192,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2203,7 +2203,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2217,7 +2217,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = false,
-        .share_level = CPU_TOPO_LEVEL_DIE,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
     },
 };
 
@@ -2233,7 +2233,7 @@ static const CPUCaches epyc_milan_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2246,7 +2246,7 @@ static const CPUCaches epyc_milan_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2257,7 +2257,7 @@ static const CPUCaches epyc_milan_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2271,7 +2271,7 @@ static const CPUCaches epyc_milan_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = true,
-        .share_level = CPU_TOPO_LEVEL_DIE,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
     },
 };
 
@@ -2287,7 +2287,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2300,7 +2300,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2311,7 +2311,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2325,7 +2325,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = false,
-        .share_level = CPU_TOPO_LEVEL_DIE,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
     },
 };
 
@@ -2341,7 +2341,7 @@ static const CPUCaches epyc_genoa_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2354,7 +2354,7 @@ static const CPUCaches epyc_genoa_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2365,7 +2365,7 @@ static const CPUCaches epyc_genoa_cache_info = {
         .partitions = 1,
         .sets = 2048,
         .lines_per_tag = 1,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2379,7 +2379,7 @@ static const CPUCaches epyc_genoa_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = false,
-        .share_level = CPU_TOPO_LEVEL_DIE,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
     },
 };
 
@@ -6507,7 +6507,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
 
                     /* Share the cache at package level. */
                     *eax |= max_thread_ids_for_cache(&topo_info,
-                                CPU_TOPO_LEVEL_PACKAGE) << 14;
+                                CPU_TOPOLOGY_LEVEL_SOCKET) << 14;
                 }
             }
         } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
@@ -7992,10 +7992,10 @@ static void x86_cpu_init_default_topo(X86CPU *cpu)
     env->nr_modules = 1;
     env->nr_dies = 1;
 
-    /* SMT, core and package levels are set by default. */
-    set_bit(CPU_TOPO_LEVEL_SMT, env->avail_cpu_topo);
-    set_bit(CPU_TOPO_LEVEL_CORE, env->avail_cpu_topo);
-    set_bit(CPU_TOPO_LEVEL_PACKAGE, env->avail_cpu_topo);
+    /* thread, core and socket levels are set by default. */
+    set_bit(CPU_TOPOLOGY_LEVEL_THREAD, env->avail_cpu_topo);
+    set_bit(CPU_TOPOLOGY_LEVEL_CORE, env->avail_cpu_topo);
+    set_bit(CPU_TOPOLOGY_LEVEL_SOCKET, env->avail_cpu_topo);
 }
 
 static void x86_cpu_initfn(Object *obj)
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 14edd57a37ba..afe2b5fd3382 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1665,7 +1665,7 @@ typedef struct CPUCacheInfo {
      * Used to encode CPUID[4].EAX[bits 25:14] or
      * CPUID[0x8000001D].EAX[bits 25:14].
      */
-    enum CPUTopoLevel share_level;
+    CpuTopologyLevel share_level;
 } CPUCacheInfo;
 
 
@@ -1995,7 +1995,7 @@ typedef struct CPUArchState {
     unsigned nr_modules;
 
     /* Bitmap of available CPU topology levels for this CPU. */
-    DECLARE_BITMAP(avail_cpu_topo, CPU_TOPO_LEVEL_MAX);
+    DECLARE_BITMAP(avail_cpu_topo, CPU_TOPOLOGY_LEVEL__MAX);
 } CPUX86State;
 
 struct kvm_msrs;
-- 
2.34.1


