Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C5079FCF3
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 09:13:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qggWE-000331-20; Thu, 14 Sep 2023 03:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qggWB-00031A-Cd
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:12:03 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qggW9-0006Be-Ci
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694675521; x=1726211521;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bxZMj09RTls2PD88x4ZIBjZXLDNESTOmPQ6HOGq8L5I=;
 b=M+aGutdx48qum2nkdPB1eXMYX/tUL7oHUiXYUyDqI3JeyDqT6AaJTmD3
 MgqTDoXfCD8mu4lAUkjPuwMcdQghksBTxyPc4sDjfQDWJEyi2Iu8IvPg4
 pZCbmBxI10emVPlm0cq2gb1cSOxfsduMSeC8uDSmgOsuXUwHzPNM2s5p0
 RJ4EKm3Q1diWCh59oUAERswtOo6UiTlnZ4DZvv00vUuX9XNIOpL3SjHhA
 SccPuFyYnA5GC2TkoYykBN3YZ6Wkq0GxMwaA3QD+YHSeRDzbFHrwvWdIR
 aAXd2P5fs6tI4hCJ7wHBfivYPTZkSbgThDCIUbE0nQztM+mtKS/MobDd3 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="359136093"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; d="scan'208";a="359136093"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2023 00:11:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="779526400"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; d="scan'208";a="779526400"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga001.jf.intel.com with ESMTP; 14 Sep 2023 00:11:41 -0700
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
 Robert Hoo <robert.hu@linux.intel.com>
Subject: [PATCH v4 07/21] i386/cpu: Consolidate the use of topo_info in
 cpu_x86_cpuid()
Date: Thu, 14 Sep 2023 15:21:45 +0800
Message-Id: <20230914072159.1177582-8-zhao1.liu@linux.intel.com>
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

From: Zhao Liu <zhao1.liu@intel.com>

In cpu_x86_cpuid(), there are many variables in representing the cpu
topology, e.g., topo_info, cs->nr_cores/cs->nr_threads.

Since the names of cs->nr_cores/cs->nr_threads does not accurately
represent its meaning, the use of cs->nr_cores/cs->nr_threads is prone
to confusion and mistakes.

And the structure X86CPUTopoInfo names its members clearly, thus the
variable "topo_info" should be preferred.

In addition, in cpu_x86_cpuid(), to uniformly use the topology variable,
replace env->dies with topo_info.dies_per_pkg as well.

Suggested-by: Robert Hoo <robert.hu@linux.intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v3:
 * Fix typo. (Babu)

Changes since v1:
 * Extract cores_per_socket from the code block and use it as a local
   variable for cpu_x86_cpuid(). (Yanan)
 * Remove vcpus_per_socket variable and use cpus_per_pkg directly.
   (Yanan)
 * Replace env->dies with topo_info.dies_per_pkg in cpu_x86_cpuid().
---
 target/i386/cpu.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a3d67c1762c0..0e9a33034026 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6012,11 +6012,16 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     uint32_t limit;
     uint32_t signature[3];
     X86CPUTopoInfo topo_info;
+    uint32_t cores_per_pkg;
+    uint32_t cpus_per_pkg;
 
     topo_info.dies_per_pkg = env->nr_dies;
     topo_info.cores_per_die = cs->nr_cores / env->nr_dies;
     topo_info.threads_per_core = cs->nr_threads;
 
+    cores_per_pkg = topo_info.cores_per_die * topo_info.dies_per_pkg;
+    cpus_per_pkg = cores_per_pkg * topo_info.threads_per_core;
+
     /* Calculate & apply limits for different index ranges */
     if (index >= 0xC0000000) {
         limit = env->cpuid_xlevel2;
@@ -6052,8 +6057,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ecx |= CPUID_EXT_OSXSAVE;
         }
         *edx = env->features[FEAT_1_EDX];
-        if (cs->nr_cores * cs->nr_threads > 1) {
-            *ebx |= (cs->nr_cores * cs->nr_threads) << 16;
+        if (cpus_per_pkg > 1) {
+            *ebx |= cpus_per_pkg << 16;
             *edx |= CPUID_HT;
         }
         if (!cpu->enable_pmu) {
@@ -6090,8 +6095,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              */
             if (*eax & 31) {
                 int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
-                int vcpus_per_socket = cs->nr_cores * cs->nr_threads;
-                if (cs->nr_cores > 1) {
+
+                if (cores_per_pkg > 1) {
                     int addressable_cores_offset =
                                                 apicid_pkg_offset(&topo_info) -
                                                 apicid_core_offset(&topo_info);
@@ -6099,7 +6104,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                     *eax &= ~0xFC000000;
                     *eax |= (1 << (addressable_cores_offset - 1)) << 26;
                 }
-                if (host_vcpus_per_cache > vcpus_per_socket) {
+                if (host_vcpus_per_cache > cpus_per_pkg) {
                     int pkg_offset = apicid_pkg_offset(&topo_info);
 
                     *eax &= ~0x3FFC000;
@@ -6244,12 +6249,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         switch (count) {
         case 0:
             *eax = apicid_core_offset(&topo_info);
-            *ebx = cs->nr_threads;
+            *ebx = topo_info.threads_per_core;
             *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
             break;
         case 1:
             *eax = apicid_pkg_offset(&topo_info);
-            *ebx = cs->nr_cores * cs->nr_threads;
+            *ebx = cpus_per_pkg;
             *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
             break;
         default:
@@ -6270,7 +6275,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x1F:
         /* V2 Extended Topology Enumeration Leaf */
-        if (env->nr_dies < 2) {
+        if (topo_info.dies_per_pkg < 2) {
             *eax = *ebx = *ecx = *edx = 0;
             break;
         }
@@ -6280,7 +6285,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         switch (count) {
         case 0:
             *eax = apicid_core_offset(&topo_info);
-            *ebx = cs->nr_threads;
+            *ebx = topo_info.threads_per_core;
             *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
             break;
         case 1:
@@ -6290,7 +6295,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             break;
         case 2:
             *eax = apicid_pkg_offset(&topo_info);
-            *ebx = cs->nr_cores * cs->nr_threads;
+            *ebx = cpus_per_pkg;
             *ecx |= CPUID_TOPOLOGY_LEVEL_DIE;
             break;
         default:
@@ -6515,7 +6520,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
          * discards multiple thread information if it is set.
          * So don't set it here for Intel to make Linux guests happy.
          */
-        if (cs->nr_cores * cs->nr_threads > 1) {
+        if (cpus_per_pkg > 1) {
             if (env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1 ||
                 env->cpuid_vendor2 != CPUID_VENDOR_INTEL_2 ||
                 env->cpuid_vendor3 != CPUID_VENDOR_INTEL_3) {
@@ -6581,7 +6586,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              *eax |= (cpu_x86_virtual_addr_width(env) << 8);
         }
         *ebx = env->features[FEAT_8000_0008_EBX];
-        if (cs->nr_cores * cs->nr_threads > 1) {
+        if (cpus_per_pkg > 1) {
             /*
              * Bits 15:12 is "The number of bits in the initial
              * Core::X86::Apic::ApicId[ApicId] value that indicate
@@ -6589,7 +6594,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              * Bits 7:0 is "The number of threads in the package is NC+1"
              */
             *ecx = (apicid_pkg_offset(&topo_info) << 12) |
-                   ((cs->nr_cores * cs->nr_threads) - 1);
+                   (cpus_per_pkg - 1);
         } else {
             *ecx = 0;
         }
-- 
2.34.1


